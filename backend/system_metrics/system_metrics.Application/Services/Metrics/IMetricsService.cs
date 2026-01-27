using system_metrics.Application.Dtos;
using system_metrics.Domain.Entities;

namespace system_metrics.Application.Services.Metrics
{
    public interface IMetricsService
    {
        Task<String> AddDeviceDetails(DeviceDetailsDTO deviceDetailsDto);
        Task<Pagination<DeviceDetails>> GetDeviceDetails(int pageNumber, int pageSize);
    }
}