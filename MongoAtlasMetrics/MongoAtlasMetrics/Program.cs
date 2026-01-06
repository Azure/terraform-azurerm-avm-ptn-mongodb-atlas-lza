using Microsoft.Azure.Functions.Worker;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System;
using System.Net.Http.Headers;

var host = new HostBuilder()
    .ConfigureFunctionsWebApplication()
    .ConfigureServices(s =>
    {
        // Add Application Insights for telemetry
        s.AddApplicationInsightsTelemetryWorkerService();
        s.ConfigureFunctionsApplicationInsights();

        // HttpClient for Mongo Atlas API calls
        s.AddHttpClient("MongoAtlasClient", client =>
        {
            client.DefaultRequestHeaders.Accept.Clear();
            client.DefaultRequestHeaders.Accept.Add(
                new MediaTypeWithQualityHeaderValue("application/vnd.atlas.2023-01-01+json"));
            client.Timeout = TimeSpan.FromSeconds(30);
        });

        // HttpClient for Mongo Atlas OAuth authentication
        s.AddHttpClient("MongoAtlasAuthClient", client =>
        {
            client.Timeout = TimeSpan.FromSeconds(30);
        });
    })
    .Build();

host.Run();
