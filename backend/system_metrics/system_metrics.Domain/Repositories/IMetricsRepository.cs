using system_metrics.Domain.Entities;

namespace system_metrics.Domain.Repositories
{
    public interface IMetricsRepository
    {
        Task<String> Create(DeviceDetails deviceDetails);
        Task<int> GetTotalCount();
        Task<List<DeviceDetails>> GetPagedDeviceDetails(int pageNumber, int pageSize);

    }
}