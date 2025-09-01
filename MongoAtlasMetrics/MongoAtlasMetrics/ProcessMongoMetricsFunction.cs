using Microsoft.ApplicationInsights;
using Microsoft.ApplicationInsights.DataContracts;
using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.Logging;
using System.Net.Http.Headers;
using System.Text;
using System.Text.Json;

namespace MongoAtlasMetrics
{
    public class ProcessMongoMetricsFunction
    {
        private readonly TelemetryClient telemetryClient;
        private readonly ILogger<ProcessMongoMetricsFunction> logger;
        private readonly IHttpClientFactory httpClientFactory;

        public ProcessMongoMetricsFunction(
            TelemetryClient telemetryClient,
            ILogger<ProcessMongoMetricsFunction> logger,
            IHttpClientFactory httpClientFactory)
        {
            this.telemetryClient = telemetryClient;
            this.logger = logger;
            this.httpClientFactory = httpClientFactory;
        }

        [Function("ProcessMongoMetricsTimer")]
        public async Task Run([TimerTrigger("0 * * * *")] TimerInfo timer)
        {
            logger.LogInformation("Timer function triggered for MongoDB metrics processing.");
            DateTime startTime = DateTime.UtcNow;

            var end = DateTime.UtcNow;
            var start = end.AddHours(-1);

            var groupName = Environment.GetEnvironmentVariable("MONGODB_GROUP_NAME");
            if (string.IsNullOrWhiteSpace(groupName))
            {
                logger.LogError("MONGODB_GROUP_NAME environment variable is not set.");
                return;
            }

            string token;
            try
            {
                token = await GetMongoAccessToken();
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Failed to retrieve MongoDB token.");
                telemetryClient.TrackException(ex);
                return;
            }

            string groupId;
            try
            {
                groupId = await GetGroupId(groupName, token);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Failed to get group id.");
                telemetryClient.TrackException(ex);
                return;
            }

            string primaryProcessName;
            try
            {
                primaryProcessName = await GetPrimaryProcessName(groupId, token);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Failed to get primary replica process name.");
                telemetryClient.TrackException(ex);
                return;
            }

            string url = BuildAtlasUrl(groupId, primaryProcessName, start, end);
            var (success, content) = await CallMongoAtlasApi(url, token, startTime);

            if (success && !string.IsNullOrEmpty(content))
            {
                ProcessMeasurements(content);
            }
        }

        private string BuildAtlasUrl(string groupId, string processName, DateTime start, DateTime end)
        {
            return $"https://cloud.mongodb.com/api/atlas/v2/groups/{groupId}/processes/{processName}/measurements" +
                   $"?envelope=false&pretty=false&granularity=PT5M&start={start:o}&end={end:o}";
        }

        private async Task<string> GetGroupId(string groupName, string token)
        {
            var client = httpClientFactory.CreateClient("MongoAtlasClient");
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

            string url = $"https://cloud.mongodb.com/api/atlas/v2/groups/byName/{groupName}";
            var response = await client.GetAsync(url);
            response.EnsureSuccessStatusCode();

            var content = await response.Content.ReadAsStringAsync();
            using var jsonDoc = JsonDocument.Parse(content);
            var root = jsonDoc.RootElement;

            if (root.TryGetProperty("id", out var id))
            {
                return id.GetString();
            }

            throw new Exception("No group id found in Atlas response.");
        }

        private async Task<string> GetPrimaryProcessName(string groupId, string token)
        {
            var client = httpClientFactory.CreateClient("MongoAtlasClient");
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

            string url = $"https://cloud.mongodb.com/api/atlas/v2/groups/{groupId}/processes";
            var response = await client.GetAsync(url);
            response.EnsureSuccessStatusCode();

            var content = await response.Content.ReadAsStringAsync();
            using var jsonDoc = JsonDocument.Parse(content);
            var root = jsonDoc.RootElement;

            if (!root.TryGetProperty("results", out var results))
                throw new Exception("No processes found in Atlas response.");

            foreach (var process in results.EnumerateArray())
            {
                if (process.TryGetProperty("typeName", out var typeProp) && typeProp.GetString() == "REPLICA_PRIMARY")
                {
                    return process.GetProperty("id").GetString();
                }
            }

            throw new Exception("Primary replica not found in Atlas processes.");
        }

        private async Task<(bool Success, string Content)> CallMongoAtlasApi(string url, string token, DateTime startTime)
        {
            var client = httpClientFactory.CreateClient("MongoAtlasClient");
            client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);

            telemetryClient.TrackEvent("ProcessMongoMetrics function called");

            try
            {
                var response = await client.GetAsync(url);
                bool success = response.IsSuccessStatusCode;
                string content = await response.Content.ReadAsStringAsync();

                telemetryClient.TrackDependency(new DependencyTelemetry
                {
                    Name = "MongoDB Atlas API",
                    Target = "cloud.mongodb.com",
                    Data = url,
                    Timestamp = startTime,
                    Duration = DateTime.UtcNow - startTime,
                    Success = success
                });

                return (success, content);
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error calling MongoDB Atlas API.");
                telemetryClient.TrackException(ex);
                return (false, null);
            }
        }

        private void ProcessMeasurements(string content)
        {
            try
            {
                using var jsonDoc = JsonDocument.Parse(content);
                var root = jsonDoc.RootElement;

                if (root.TryGetProperty("measurements", out var measurements))
                {
                    foreach (var measurement in measurements.EnumerateArray())
                    {
                        string metricName = measurement.GetProperty("name").GetString() ?? "UnknownMetric";
                        string units = measurement.GetProperty("units").GetString() ?? "units";

                        if (measurement.TryGetProperty("dataPoints", out var dataPoints))
                        {
                            foreach (var point in dataPoints.EnumerateArray())
                            {
                                if (point.TryGetProperty("value", out var valueProp) && valueProp.ValueKind == JsonValueKind.Number)
                                {
                                    double value = valueProp.GetDouble();
                                    telemetryClient.GetMetric(metricName, "Units").TrackValue(value);

                                    logger.LogInformation("Tracked metric {Metric}={Value} {Units} at {Timestamp}",
                                        metricName, value, units, point.GetProperty("timestamp").GetString());
                                }
                                else
                                {
                                    logger.LogWarning("Skipping metric {Metric} because value is null", metricName);
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                logger.LogError(ex, "Error processing MongoDB measurements.");
                telemetryClient.TrackException(ex);
            }
        }

        public async Task<string> GetMongoAccessToken()
        {
            var clientId = Environment.GetEnvironmentVariable("MONGODB_CLIENT_ID");
            var clientSecret = Environment.GetEnvironmentVariable("MONGODB_CLIENT_SECRET");

            var tokenUrl = "https://cloud.mongodb.com/api/oauth/token";
            var tokenClient = httpClientFactory.CreateClient("MongoAtlasAuthClient");

            var authHeader = Convert.ToBase64String(Encoding.UTF8.GetBytes($"{clientId}:{clientSecret}"));
            tokenClient.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Basic", authHeader);

            var content = new FormUrlEncodedContent(new[]
            {
                new KeyValuePair<string, string>("grant_type", "client_credentials")
            });

            var response = await tokenClient.PostAsync(tokenUrl, content);
            response.EnsureSuccessStatusCode();

            var responseBody = await response.Content.ReadAsStringAsync();
            using var jsonDoc = JsonDocument.Parse(responseBody);

            if (jsonDoc.RootElement.TryGetProperty("access_token", out var tokenElement))
            {
                return tokenElement.GetString();
            }

            throw new Exception("access_token not found in response.");
        }
    }
}
