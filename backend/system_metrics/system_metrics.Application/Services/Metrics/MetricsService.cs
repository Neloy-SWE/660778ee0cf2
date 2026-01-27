using system_metrics.Application.Dtos;
using system_metrics.Domain.Entities;
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

        public async Task<Pagination<DeviceDetails>> GetDeviceDetails(int pageNumber, int pageSize)
        {
            try
            {
                pageNumber = pageNumber < 1 ? 1 : pageNumber;
                pageSize = pageSize < 1 ? 10 : pageSize;
                int count = await metricsRepository.GetTotalCount();
                var items = await metricsRepository.GetPagedDeviceDetails(pageNumber, pageSize);

                return new Pagination<DeviceDetails>
                {
                    Items = items,
                    TotalCount = count,
                    PageNumber = pageNumber,
                    PageSize = pageSize
                };
            }
            catch
            {
                throw new ArgumentException("Failed to retrieve device details");
            }
        }
    }
}