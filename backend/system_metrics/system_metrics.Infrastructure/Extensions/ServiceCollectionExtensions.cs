using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using system_metrics.Infrastructure.Persistence;

namespace system_metrics.Infrastructure.Extensions
{

    public static class ServiceCollectionExtensions
    {
        public static void AddInfrastructureServices(this IServiceCollection services, IConfiguration configuration)
        {
            var connectionString = configuration.GetConnectionString("DefaultConnection");
            services.AddDbContext<SystemMetricsDBContext>(options =>
                options.UseSqlite(connectionString));
        }
    }
}