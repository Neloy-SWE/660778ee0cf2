using system_metrics.Domain.Entities;

namespace system_metrics.Domain.Repositories
{
    public interface IMetricsRepository
    {
        Task<String> Create(DeviceDetails deviceDetails);
        Task<int> GetTotalCount(string deviceId);
        Task<List<DeviceDetails>> GetPagedDeviceDetails(string deviceId, int pageNumber, int pageSize);
        Task<IEnumerable<DeviceDetails>> GetAnalytics(string? deviceId);
    }
}