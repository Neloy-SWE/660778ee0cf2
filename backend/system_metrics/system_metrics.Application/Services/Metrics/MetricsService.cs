using system_metrics.Application.Dtos;
using system_metrics.Domain.Repositories;

namespace system_metrics.Application.Services.Metrics
{
    internal class MetricsService(IMetricsRepository metricsRepository) : IMetricsService
    {
        public async Task<string> AddDeviceDetails(DeviceDetailsDTO deviceDetailsDto)
        {

            if (string.IsNullOrEmpty(deviceDetailsDto.DeviceId))
            {
                throw new ArgumentException("Device id cannot be null or empty");
            }
            if (deviceDetailsDto.ThermalValue < 0 || deviceDetailsDto.ThermalValue > 3)
            {
                throw new ArgumentException("Thermal value must be between 0 and 3");
            }
            if (deviceDetailsDto.BatteryLevel < 0 || deviceDetailsDto.BatteryLevel > 100)
            {
                throw new ArgumentException("Battery level must be between 0 and 100");
            }
            if (deviceDetailsDto.MemoryUsage < 0 || deviceDetailsDto.MemoryUsage > 100)
            {
                throw new ArgumentException("Memory usage must be between 0 and 100");
            }
            try
            {
                var deviceDetails = DeviceDetailsDTO.MapEntity(deviceDetailsDto);
                return await metricsRepository.Create(deviceDetails);
            }
            catch
            {
                throw new ArgumentException("Fail");
            }

        }
    }
}