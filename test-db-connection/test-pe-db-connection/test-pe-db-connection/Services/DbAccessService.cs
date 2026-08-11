
using Microsoft.Net.Http.Headers;

using MongoDB.Driver;
using MongoDB.Bson;

namespace test_pe_db_connection.Services.User
{
    public class DbAccessService
    {

        public int TestDbConnection()
        {
            try
            {
                var connectionUri = Environment.GetEnvironmentVariable("MONGODB_CONNECTION_STRING") 
                    ?? throw new InvalidOperationException("MONGODB_CONNECTION_STRING environment variable is not set");
                var settings = MongoClientSettings.FromConnectionString(connectionUri);
                // Set the ServerApi field of the settings object to set the version of the Stable API on the client
                settings.ServerApi = new ServerApi(ServerApiVersion.V1);
                // Create a new client and connect to the server
                var client = new MongoClient(settings);
                // Send a ping to confirm a successful connection
                var result = client.GetDatabase("admin").RunCommand<BsonDocument>(new BsonDocument("ping", 1));
                Console.WriteLine("Pinged your deployment. You successfully connected to MongoDB!");
                return 1;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex);
                return 0;
            }
        }
    }
}
