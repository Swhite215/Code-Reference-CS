const dgram = require('dgram');

// DNS server configuration
const DNS_PORT = 53; // Standard DNS port
const server = dgram.createSocket('udp4');

// Mock DNS records (domain -> IP address)
const dnsRecords = {
    "example.com": "192.0.2.1",
    "localtest.me": "127.0.0.1",
    "myapp.local": "10.0.0.1"
};

// Function to parse incoming DNS requests and respond
server.on('message', (msg, rinfo) => {
    // Basic parsing of the DNS request
    const domainName = parseDomainName(msg);

    // Check if the domain exists in our mock DNS records
    if (dnsRecords[domainName]) {
        const ipAddress = dnsRecords[domainName];
        const response = createDnsResponse(msg, ipAddress);

        // Send DNS response
        server.send(response, rinfo.port, rinfo.address, (err) => {
            if (err) console.error(`Error sending response: ${err}`);
            else console.log(`Resolved ${domainName} to ${ipAddress}`);
        });
    } else {
        console.log(`Domain not found: ${domainName}`);
        // Respond with an empty DNS response (no records found)
        server.send(createEmptyDnsResponse(msg), rinfo.port, rinfo.address);
    }
});

// Helper function to parse domain name from the DNS request
function parseDomainName(buffer) {
    let domain = '';
    let i = 12; // DNS header is 12 bytes, domain starts after this
    while (buffer[i] !== 0) {
        const length = buffer[i];
        domain += buffer.slice(i + 1, i + 1 + length).toString() + '.';
        i += length + 1;
    }
    return domain.slice(0, -1); // Remove trailing dot
}

// Helper function to create a DNS response with an IP address
function createDnsResponse(request, ipAddress) {
    const response = Buffer.alloc(request.length + 16);

    // Copy request headers and flags to response (ID, flags)
    request.copy(response, 0, 0, 12);

    // Set response flags (standard query response, no error)
    response[2] = 0x81;
    response[3] = 0x80;

    // Set QDCOUNT and ANCOUNT (1 question, 1 answer)
    response.writeUInt16BE(1, 4); // QDCOUNT
    response.writeUInt16BE(1, 6); // ANCOUNT

    // Copy question section from request to response
    request.copy(response, 12, 12, request.length);

    // Answer section starts after question
    let offset = request.length;

    // Pointer to the domain name in the question section
    response.writeUInt16BE(0xC00C, offset);
    offset += 2;

    // Type A (IPv4) and Class IN (Internet)
    response.writeUInt16BE(1, offset); // TYPE
    offset += 2;
    response.writeUInt16BE(1, offset); // CLASS
    offset += 2;

    // TTL (Time to Live)
    response.writeUInt32BE(300, offset); // TTL in seconds
    offset += 4;

    // Data length (4 bytes for IPv4 address)
    response.writeUInt16BE(4, offset);
    offset += 2;

    // Write the IP address as 4 bytes
    ipAddress.split('.').forEach((octet) => {
        response[offset++] = parseInt(octet, 10);
    });

    return response;
}

// Helper function to create an empty DNS response if domain not found
function createEmptyDnsResponse(request) {
    const response = Buffer.alloc(request.length);

    // Copy request headers and set response flags (not found)
    request.copy(response, 0, 0, 12);
    response[2] = 0x81; // Response flag
    response[3] = 0x83; // RCODE 3 (Name Error)

    return response;
}

// Start the DNS server
server.bind(DNS_PORT, () => {
    console.log(`DNS server listening on port ${DNS_PORT}`);
});