using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Table;

namespace linuxacademy.az203.storage.tables
{
    public class Tables
    {
        // Add Storage Account Connection String
        private static string _connectionString = "<CONNECTION-STRING>";

        public static async Task runDemoAsync(){
            // Create Storage Account Object
            var storageAccount = CloudStorageAccount
                                    .Parse(_connectionString);
            // Create Table Client
            var tableClient = storageAccount.CreateCloudTableClient();

            // Get Table Reference
            var gamersTable = tableClient.GetTableReference("Gamers");

            // Create Table If Not Exists
            await gamersTable.CreateIfNotExistsAsync(); 

            // Delete All Existing Game Entities
            await DeleteAllGamersAsync(gamersTable);

            // Create New Entity
            var gamer1 = new Gamer("bleu@game.net", "France", "Bleu");
            await AddAsync(gamersTable, gamer1);

            // Create Multiple Entities
            var gamers = new List<Gamer> {
                new Gamer("mike@game.net", "US", "Mike", "555-1212"),
                new Gamer("mike@contoso.net", "US", "Mike", "555-1234")
            };
            await AddBatchAsync(gamersTable, gamers);

            // Get An Entity
            var bleu = await GetAsync<Gamer>(
                gamersTable, "France", "bleu@game.net");
            System.Console.WriteLine(bleu);

            // Get Multiple Entities
            gamers = await FindGamersByNameAsync(gamersTable, "Mike");
            gamers.ForEach(Console.WriteLine);
        }

        // Method to Add an Entity to Table
        public static async Task AddAsync<T>(
            CloudTable table, T entity) where T : TableEntity
        {
            var insertOperation = TableOperation.Insert(entity);
            await table.ExecuteAsync(insertOperation);
        }

        // Method to Add Multiple Entities to Table through Batch
        public static async Task AddBatchAsync<T>(
            CloudTable table, IEnumerable<T> entities) where T : TableEntity
        {
            var batchOperation = new TableBatchOperation();
            foreach (var entity in entities) 
            batchOperation.Insert(entity);
            await table.ExecuteBatchAsync(batchOperation);
        }

        // Method to Get an Entity By Partition and Row Key
        public static async Task<T> GetAsync<T>(
            CloudTable table, string pk, string rk) where T : TableEntity
        {
            var retrieve = TableOperation.Retrieve<Gamer>(pk, rk);
            var result = await table.ExecuteAsync(retrieve);
            return (T)result.Result;
        }

        // Method to Delete an Entity
        public static async Task DeleteAsync<T>(
            CloudTable table, T entity) where T : TableEntity
        {
            var retrieve = TableOperation.Delete(entity);
            await table.ExecuteAsync(retrieve);
        }

        // Method to Get Multiple Entities Using Query Filter
        public static async Task<List<Gamer>> FindGamersByNameAsync(
            CloudTable table, string name) 
        {
            var filterCondition = TableQuery.GenerateFilterCondition("Name", QueryComparisons.Equal, name);
            var query = new TableQuery<Gamer>().Where(filterCondition);
            var results = await table.ExecuteQuerySegmentedAsync(query, null); // used to be ExecuteQuery / ExecuteQueryAsync
            return results.ToList();
        }

        // Method to Delete Multiple Entities
        public static async Task DeleteAllGamersAsync(CloudTable table)
        {
            // believe it or now, this is a hard problem to do right.  This is a fudge for this example
            var gamers = new [] {
                await GetAsync<Gamer>(table, "US", "mike@game.net"),
                await GetAsync<Gamer>(table, "US", "mike@contoso.net"),
                await GetAsync<Gamer>(table, "France", "bleu@game.net")
            }.ToList();
            gamers.ForEach(async gamer => 
            {
                if (gamer != null)
                    await DeleteAsync(table, gamer);
            });
        }
    }
}
