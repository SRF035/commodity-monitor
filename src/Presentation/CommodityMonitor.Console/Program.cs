using CommodityMonitor.Data;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

var host = Host.CreateDefaultBuilder(args)
    .ConfigureServices((context, services) =>
    {
        // Database
        services.AddDbContext<CommodityMonitorDbContext>(options =>
            options.UseNpgsql(context.Configuration.GetConnectionString("DefaultConnection")));

        // Add other services as needed by individual modules
    })
    .Build();

// Basic application startup
var logger = host.Services.GetRequiredService<ILogger<Program>>();
logger.LogInformation("CommodityMonitor Console Application starting...");

await host.RunAsync();