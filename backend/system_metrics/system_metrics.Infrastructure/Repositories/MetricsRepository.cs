using Microsoft.EntityFrameworkCore;
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

        public async Task<List<DeviceDetails>> GetPagedDeviceDetails(int pageNumber, int pageSize)
        {
            var items = await dbContext.DeviceDetails
        .AsNoTracking()
        .OrderByDescending(x => x.Id)
        .Skip((pageNumber - 1) * pageSize)
        .Take(pageSize)
        .ToListAsync();
            return items;
        }

        public async Task<int> GetTotalCount()
        {
            var count = await dbContext.DeviceDetails.CountAsync();
            return count;
        }

        public async Task<IEnumerable<DeviceDetails>> GetAnalytics(string? deviceId)
        {
            var query = await dbContext.DeviceDetails
            .AsNoTracking()
        .Where(x => x.DeviceId == deviceId)
        .ToListAsync();
            return query;
        }
    }
}