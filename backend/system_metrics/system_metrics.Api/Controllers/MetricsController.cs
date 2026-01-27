using Microsoft.AspNetCore.Mvc;
using system_metrics.Application.Dtos;
using system_metrics.Application.Services.Metrics;

namespace system_metrics.Api.Controllers
{
    [ApiController]
    [Route("api/vitals")]
    public class MetricsController(IMetricsService metricsService) : ControllerBase
    {
        [HttpPost]
        public async Task<IActionResult> AddDeviceDetails(DeviceDetailsDTO deviceDetails)
        {
            try
            {
                var result = await metricsService.AddDeviceDetails(deviceDetails);
                return Ok(result);
            }
            catch (ArgumentException exception)
            {
                return StatusCode(500, exception.Message);
            }
        }

        [HttpGet]
        public async Task<IActionResult> GetDeviceDetails([FromQuery] int pageNumber = 1, [FromQuery] int pageSize = 10)
        {
            try
            {
                var result = await metricsService.GetDeviceDetails(pageNumber, pageSize);
                return Ok(result);
            }
            catch (ArgumentException exception)
            {
                return StatusCode(500, exception.Message);
            }
        }
    }
}