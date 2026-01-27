using system_metrics.Domain.Entities;
using system_metrics.Domain.Repositories;
using system_metrics.Infrastructure.Persistence;

namespace system_metrics.Infrastructure.Repositories
{
    internal class MetricsRepository(SystemMetricsDBContext dbContext) : IMetricsRepository
    {
        public async Task<string> Create(DeviceDetails deviceDetails)
        {
            await dbContext.DeviceDetails.AddAsync(deviceDetails);   
            await dbContext.SaveChangesAsync();
            return "created";
        }
    }
}