using system_metrics.Application.Dtos;
using system_metrics.Domain.Entities;
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
                throw new Exception("Fail");
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

        public async Task<AnalyticsDTO> GetAnalytics(string? deviceId, DateTime? fromDate, DateTime? toDate)
        {
            try
            {
                var data = await metricsRepository.GetAnalytics(deviceId);
                List<DeviceDetails> deviceDetailsList = [.. data];
                if (fromDate.HasValue)
                {
                    deviceDetailsList = deviceDetailsList.Where(d => d.Timestamp >= fromDate.Value).ToList();
                }
                if (toDate.HasValue)
                {
                    deviceDetailsList = deviceDetailsList.Where(d => d.Timestamp <= toDate.Value).ToList();
                }
                var analyticsDto = new AnalyticsDTO
                {
                    AverageThermalValue = deviceDetailsList.Any() ? deviceDetailsList.Average(d => d.ThermalValue ?? 0) : 0,
                    AverageBatteryLevel = deviceDetailsList.Any() ? deviceDetailsList.Average(d => d.BatteryLevel ?? 0) : 0,
                    AverageMemoryUsage = deviceDetailsList.Any() ? deviceDetailsList.Average(d => d.MemoryUsage ?? 0) : 0,

                    MinimumBatteryLevel = deviceDetailsList.Any() ? deviceDetailsList.Min(d => d.BatteryLevel ?? 0) : 0,
                    MaximumBatteryLevel = deviceDetailsList.Any() ? deviceDetailsList.Max(d => d.BatteryLevel ?? 0) : 0,

                    MinimumMemoryUsage = deviceDetailsList.Any() ? deviceDetailsList.Min(d => d.MemoryUsage ?? 0) : 0,
                    MaximumMemoryUsage = deviceDetailsList.Any() ? deviceDetailsList.Max(d => d.MemoryUsage ?? 0) : 0,

                    MinimumThermalValue = deviceDetailsList.Any() ? deviceDetailsList.Min(d => d.ThermalValue ?? 0) : 0,
                    MaximumThermalValue = deviceDetailsList.Any() ? deviceDetailsList.Max(d => d.ThermalValue ?? 0) : 0
                };

                return analyticsDto;
            }
            catch
            {
                throw new ArgumentException("Failed to retrieve analytics data");
            }
        }
    }
}