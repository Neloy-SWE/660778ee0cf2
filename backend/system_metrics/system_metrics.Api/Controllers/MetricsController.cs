using Microsoft.AspNetCore.Mvc;
using system_metrics.Application.Dtos;
using system_metrics.Application.Services.Metrics;

namespace system_metrics.Api.Controllers
{
    [ApiController]
    [Route("api")]
    public class MetricsController(IMetricsService metricsService) : ControllerBase
    {
        [HttpPost("vitals")]
        public async Task<IActionResult> AddDeviceDetails(DeviceDetailsDTO deviceDetails)
        {
            try
            {
                var result = await metricsService.AddDeviceDetails(deviceDetails);
                return Ok(result);
            } catch
            {
                return StatusCode(500, "An error occurred while processing the request.");
            }
        }
    }
}