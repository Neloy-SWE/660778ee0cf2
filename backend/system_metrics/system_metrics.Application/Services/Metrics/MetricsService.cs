using system_metrics.Application.Dtos;
using system_metrics.Domain.Repositories;

namespace system_metrics.Application.Services.Metrics
{
    internal class MetricsService(IMetricsRepository metricsRepository) : IMetricsService
    {
        public async Task<string> AddDeviceDetails(DeviceDetailsDTO deviceDetailsDto)
        {
            try
            {
                var deviceDetails = DeviceDetailsDTO.MapEntity(deviceDetailsDto);
                return await metricsRepository.Create(deviceDetails);
            }
            catch
            {
                throw;
            }

        }
    }
}