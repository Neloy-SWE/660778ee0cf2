using system_metrics.Application.Dtos;

namespace system_metrics.Application.Services.Metrics
{
    public interface IMetricsService
    {
        Task<String> AddDeviceDetails(DeviceDetailsDTO deviceDetailsDto);
    }
}