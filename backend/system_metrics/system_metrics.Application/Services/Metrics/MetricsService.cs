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

        public async Task<Pagination<DeviceDetails>> GetDeviceDetails(string deviceId, int pageNumber, int pageSize)
        {
            try
            {
                pageNumber = pageNumber < 1 ? 1 : pageNumber;
                pageSize = pageSize < 1 ? 10 : pageSize;
                int count = await metricsRepository.GetTotalCount(deviceId);
                var items = await metricsRepository.GetPagedDeviceDetails(deviceId, pageNumber, pageSize);

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

        public async Task<IEnumerable<AnalyticsListDTO>> GetAnalytics(string? deviceId, DateTime? fromDate, DateTime? toDate)
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
                    AverageThermalValue = deviceDetailsList.Count != 0 ? deviceDetailsList.Average(d => d.ThermalValue ?? 0) : 0,
                    AverageBatteryLevel = deviceDetailsList.Count != 0 ? deviceDetailsList.Average(d => d.BatteryLevel ?? 0) : 0,
                    AverageMemoryUsage = deviceDetailsList.Count != 0 ? deviceDetailsList.Average(d => d.MemoryUsage ?? 0) : 0,

                    MinimumBatteryLevel = deviceDetailsList.Count != 0 ? deviceDetailsList.Min(d => d.BatteryLevel ?? 0) : 0,
                    MaximumBatteryLevel = deviceDetailsList.Count != 0 ? deviceDetailsList.Max(d => d.BatteryLevel ?? 0) : 0,

                    MinimumMemoryUsage = deviceDetailsList.Count != 0 ? deviceDetailsList.Min(d => d.MemoryUsage ?? 0) : 0,
                    MaximumMemoryUsage = deviceDetailsList.Count != 0 ? deviceDetailsList.Max(d => d.MemoryUsage ?? 0) : 0,

                    MinimumThermalValue = deviceDetailsList.Count != 0 ? deviceDetailsList.Min(d => d.ThermalValue ?? 0) : 0,
                    MaximumThermalValue = deviceDetailsList.Count != 0 ? deviceDetailsList.Max(d => d.ThermalValue ?? 0) : 0
                };

                AnalyticsListDTO thermalAnalytics = new AnalyticsListDTO
                {
                    Title = "Thermal Information",
                    Average = analyticsDto.AverageThermalValue,
                    Minimum = analyticsDto.MinimumThermalValue,
                    Maximum = analyticsDto.MaximumThermalValue
                };

                AnalyticsListDTO batteryAnalytics = new AnalyticsListDTO
                {
                    Title = "Battery Information",
                    Average = analyticsDto.AverageBatteryLevel,
                    Minimum = analyticsDto.MinimumBatteryLevel,
                    Maximum = analyticsDto.MaximumBatteryLevel
                };

                AnalyticsListDTO memoryAnalytics = new AnalyticsListDTO
                {
                    Title = "Memory Information",
                    Average = analyticsDto.AverageMemoryUsage,
                    Minimum = analyticsDto.MinimumMemoryUsage,
                    Maximum = analyticsDto.MaximumMemoryUsage
                };

                return
                [
                    thermalAnalytics,
                    batteryAnalytics,
                    memoryAnalytics
                ];
            }
            catch
            {
                throw new ArgumentException("Failed to retrieve analytics data");
            }
        }
    }
}