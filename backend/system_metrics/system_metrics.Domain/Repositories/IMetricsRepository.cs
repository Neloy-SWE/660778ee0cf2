using system_metrics.Domain.Entities;

namespace system_metrics.Domain.Repositories
{
    public interface IMetricsRepository
    {
        Task<String> Create(DeviceDetails deviceDetails);
    }
}