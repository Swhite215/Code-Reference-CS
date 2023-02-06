using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;

namespace linuxacademy.az203.storage.blobs
{
    public class Blobs
    {
        public static string _connectionString = 
            "<CONNECTION_STRING>";
        public static async Task RunAsync()
        {
            // Get Storage Account
            var storageAccount = CloudStorageAccount
                                    .Parse(_connectionString);
            // Get Cloud Blob Client
            var cloudBlobClient = storageAccount
                                    .CreateCloudBlobClient();
            // Get Container Reference
            var cloudBlobContainer = cloudBlobClient
                                        .GetContainerReference("mycontainer");
            // Create Container
            await cloudBlobContainer.CreateAsync();
            // Generate Container Permissions
            var permissions = new BlobContainerPermissions {
                PublicAccess = BlobContainerPublicAccessType.Blob
            };
            // Set Container Permissions
            await cloudBlobContainer.SetPermissionsAsync(permissions);
            // Create File and Add Text
            var localFileName = "Blob.txt";
            File.WriteAllText(localFileName, "Hello, World!");
            // Get Blob Reference at File Name
            var cloudBlockBlob = cloudBlobContainer
                                    .GetBlockBlobReference(localFileName);
            // Upload File as Block Blob
            await cloudBlockBlob.UploadFromFileAsync(localFileName);

            // List Blobs in the Container
            Console.WriteLine("Listing blobs in container.");
            BlobContinuationToken blobContinuationToken = null;
            do {
                var results = await cloudBlobContainer
                        .ListBlobsSegmentedAsync(null, 
                                                 blobContinuationToken);
                blobContinuationToken = results.ContinuationToken;
                foreach (var item in results.Results) {
                    Console.WriteLine(item.Uri);
                }
            } while (blobContinuationToken != null); 

            // Create Destination File and Download Blob
            var destinationFile = localFileName.Replace(".txt", "_DOWNLOADED.txt");
            await cloudBlockBlob.DownloadToFileAsync(
                                    destinationFile, FileMode.Create);

            // Create a Lease ID - GUID
            var leaseId = Guid.NewGuid().ToString();

            // Modify Contents of Local File
            File.WriteAllText(localFileName, "New Content");

            // Acquire Lease on Blob
            cloudBlockBlob.AcquireLease(
                TimeSpan.FromSeconds(30),
                leaseId);

            try
            {
                // Upload File to Blob WITHOUT Lease ID
                await cloudBlockBlob.UploadFromFileAsync(localFileName);
            }
            catch (StorageException ex)
            {
                // Catch Exception - Lease on Blob
                System.Console.WriteLine(ex.Message);
                if (ex.InnerException != null) System.Console.WriteLine(ex.InnerException.Message);
            }

            // Wait
            await Task.Delay(TimeSpan.FromSeconds(5));

            // Upload File to Blob AFTER Lease
            await cloudBlockBlob.UploadFromFileAsync(localFileName);

            // Release Lease
            await cloudBlockBlob.ReleaseLeaseAsync(
                new AccessCondition()
            {
                LeaseId = leaseId
            });

            // Delete Container
            await cloudBlobContainer.DeleteIfExistsAsync();
        }
    }
}