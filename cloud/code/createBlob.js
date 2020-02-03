#!/usr/bin/env node

// IMPORTANT: npm i dotenv azure-storage

require('dotenv').config();

const util = require('util');

const storage = require('azure-storage');
const blobService = storage.createBlobService();
const createContainerAsync = util.promisify(blobService.createContainerIfNotExists).bind(blobService);

const containerName = 'containerName';

async function main() {
    try {
        var result = await createContainerAsync(containerName);
        if (result.created) {
            console.log(`Blob container ${containerName} created`);
        }
        else {
            console.log(`Blob container ${containerName} already exists.`);
        }
    }
    catch (err) {
        console.log(err.message);
    }
}

main();