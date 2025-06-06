/* Question #1 */
CREATE TABLE account (
    account_id SERIAL PRIMARY KEY,
    balance NUMERIC(15, 2) NOT NULL CHECK (balance >= 0),
    start_date DATE NOT NULL
);

CREATE TABLE client (
    client_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    credit_limit NUMERIC(15, 2) CHECK (credit_limit >= 0),
    street_number TEXT NOT NULL,
    street_name TEXT NOT NULL,
    city TEXT NOT NULL,
    client_type TEXT NOT NULL CHECK (client_type IN ('person', 'company'))
);

CREATE TABLE client_phone (
    client_id INTEGER NOT NULL REFERENCES client(client_id) ON DELETE CASCADE,
    phone_number TEXT NOT NULL,
    PRIMARY KEY (client_id, phone_number)
);

CREATE TABLE client_account (
    client_id INTEGER NOT NULL REFERENCES client(client_id) ON DELETE CASCADE,
    account_id INTEGER NOT NULL REFERENCES account(account_id) ON DELETE CASCADE,
    PRIMARY KEY (client_id, account_id)
);

CREATE TABLE person (
    client_id INTEGER PRIMARY KEY REFERENCES client(client_id) ON DELETE CASCADE,
    income NUMERIC(15, 2) CHECK (income >= 0)
);

CREATE TABLE company (
    client_id INTEGER PRIMARY KEY REFERENCES client(client_id) ON DELETE CASCADE,
    capital NUMERIC(15, 2) CHECK (capital >= 0),
    tax_id TEXT NOT NULL UNIQUE
);

CREATE TABLE employment (
    person_id INTEGER NOT NULL REFERENCES person(client_id) ON DELETE CASCADE,
    company_id INTEGER NOT NULL REFERENCES company(client_id) ON DELETE CASCADE,
    PRIMARY KEY (person_id, company_id)
);

/* Question #2A */
Consider a relation R(A, B, C, D).(a) If A → C
and D → B are true on R,
use Armstrong ’ s Axioms to prove that A D → B (i.e., { A, D } → B) is also true on R.AD + = { A,
D }
/*
 A in AD+
 If A -> C then AD+ = { A,C, D } 
 If D -> B and D in AD+ then AD+ = { A, C, D, B } 
 If B in AD+ then AD+ -> B
 */


 /* Question #2B */
Give a relation instance of R that satisfies A → C
and B → C,
but does not satisfy A → B.
/*
 +----+----+----+
 | A  | B  | C  |
 +----+----+----+
 | 7  | 2  | 3  |
 | 7  | 9  | 3  |
 +----+----+----+
 */

/* Question #3A */
Closure = {M,Y}+
If M -> T, then Closure = {M, Y, T}
If MY -> P, then Clkosure = {M,Y, T, P}
If T -> C, then Closure = {M,Y,P,T,C}
{M,Y}+ = {M,Y,P,T,C}

/* Question #3B */
This relation is not in 3NF, If M -> T, and T -> C, then T -> C is a transitive dependency.

If (M -> T), then relation ModelManufaturer(M, T)
If (T -> C), then relation ColorManufacturer(T, C)
If (MY -> P) then  relation ModelPrice(M, Y, P)

/* Question #3C */
Yes. M determines all attributes in R2.