using Microsoft.EntityFrameworkCore;
using system_metrics.Domain.Entities;

namespace system_metrics.Infrastructure.Persistence
{

    public class SystemMetricsDBContext(DbContextOptions<SystemMetricsDBContext> options) : DbContext(options)
    {
        public DbSet<DeviceDetails> DeviceDetails { get; set; }
    }
}