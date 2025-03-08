-- PostgreSQL DDL Script with Comments
-- ====================================
-- This script creates a sample database schema with tables, constraints,
-- indexes, views, stored procedures, triggers, roles, and sequences.

-- 1. Creating Users Table with Constraints
CREATE TABLE users (
    id SERIAL PRIMARY KEY, -- Auto-incrementing primary key
    username VARCHAR(50) UNIQUE NOT NULL, -- Unique constraint on username
    email VARCHAR(100) UNIQUE NOT NULL, -- Unique constraint on email
    age INT CHECK (age >= 18), -- Ensures users are at least 18
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Default timestamp
);

-- 2. Creating Orders Table with Foreign Key Constraint
CREATE TABLE orders (
    id SERIAL PRIMARY KEY, -- Auto-incrementing primary key
    user_id INT NOT NULL, -- Reference to users table
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount > 0), -- Ensures amount is positive
    status VARCHAR(20) DEFAULT 'pending', -- Default order status
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp of order creation
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE -- Cascade delete on user deletion
);

-- 3. Creating Indexes for Performance Optimization
CREATE INDEX idx_users_email ON users(email); -- Index on email for faster lookups
CREATE INDEX idx_orders_user_id ON orders(user_id); -- Index on user_id for join optimization

-- 4. Creating a View for User Orders
CREATE VIEW user_orders AS
SELECT u.id, u.username, u.email, o.id AS order_id, o.total_amount, o.status
FROM users u
JOIN orders o ON u.id = o.user_id;

-- 5. Creating a Stored Procedure for Order Insertion
CREATE OR REPLACE FUNCTION create_order(p_user_id INT, p_amount DECIMAL)
RETURNS VOID AS $$
BEGIN
    INSERT INTO orders (user_id, total_amount) 
    VALUES (p_user_id, p_amount);
END;
$$ LANGUAGE plpgsql;

-- 6. Creating a Trigger to Automatically Update Timestamps
CREATE OR REPLACE FUNCTION set_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_set_updated_at
BEFORE UPDATE ON users
FOR EACH ROW
EXECUTE FUNCTION set_updated_at();

-- 7. Creating a Role and Assigning Privileges
CREATE ROLE app_user WITH LOGIN PASSWORD 'securepassword';
GRANT SELECT, INSERT, UPDATE ON users TO app_user;
GRANT SELECT, INSERT, UPDATE ON orders TO app_user;

-- 8. Creating a Custom Sequence for User IDs
CREATE SEQUENCE custom_user_id_seq START 1000;
ALTER TABLE users ALTER COLUMN id SET DEFAULT nextval('custom_user_id_seq');

-- End of PostgreSQL DDL Script
