// Import the dgram module
const dgram = require('dgram');

// Create a UDP socket
const server = dgram.createSocket('udp4');

// Event listener for incoming messages
server.on('message', (msg, rinfo) => {
    console.log(`Server received: ${msg} from ${rinfo.address}:${rinfo.port}`);
});

// Event listener for errors
server.on('error', (err) => {
    console.log(`Server error:\n${err.stack}`);
    server.close();
});

// Start server on port 41234
server.bind(41234, () => {
    console.log('Server is listening on port 41234');
});