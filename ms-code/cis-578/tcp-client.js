const net = require('net');

// Create a TCP client and connect to the server
const client = net.createConnection({ port: 41234, host: 'localhost' }, () => {
    console.log('Connected to server');
    client.write('Hello, TCP Server!');  // Send message to server
});

// Event listener for data received from the server
client.on('data', (data) => {
    console.log(`Received from server: ${data}`);
    client.end();  // Close the connection
});

// Event listener for client disconnect
client.on('end', () => {
    console.log('Disconnected from server');
});