// Import the dgram module
const dgram = require('dgram');

// Create a UDP socket
const client = dgram.createSocket('udp4');

// Message to send as a packet
const message = Buffer.from('Hello, UDP Server!');

// Send the packet to the server
client.send(message, 41234, 'localhost', (err) => {
    if (err) {
        console.error(err);
    } else {
        console.log('Packet sent to server');
    }
    client.close();
});