using System;
using System.Threading.Tasks;
using Microsoft.Azure.Services.AppAuthentication;
using Microsoft.Azure.KeyVault;

namespace secrets
{
    class Program
    {
        static void Main(string[] args)
        {
            RunAsync().Wait();
        }

        private static async Task RunAsync()
        {
            // Create AzureServiceTokenProvider
            var azureServiceTokenProvider1 = 
                new AzureServiceTokenProvider();

            // Create Key Vault Client Object - Grabs MSI if Service or Look Up By Logged in Azure CLI Identity
            var kvc = new KeyVaultClient(
                new KeyVaultClient.AuthenticationCallback(
                    azureServiceTokenProvider1.KeyVaultTokenCallback));

            // Pass URL and Name of Secret
            var kvBaseUrl = "https://laaz203kvsecrets.vault.azure.net/";
            var secret = await kvc.GetSecretAsync(
                kvBaseUrl, "connectionString");
            System.Console.WriteLine(secret.Value);
        }
    }
}