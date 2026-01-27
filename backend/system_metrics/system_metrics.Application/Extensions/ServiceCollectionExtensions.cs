using Microsoft.Extensions.DependencyInjection;
using system_metrics.Application.Services.Metrics;

namespace system_metrics.Application.Services.Extensions
{
    public static class ServiceCollectionExtensions
    {
        public static void AddApplication(this IServiceCollection services)
        {
            services.AddScoped<IMetricsService, MetricsService>();
        }
    }
}