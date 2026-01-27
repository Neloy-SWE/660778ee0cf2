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
    }
}