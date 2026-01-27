using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("api")]
public class CheckController : ControllerBase
{
    [HttpGet("check")]
    public async Task<IActionResult> CheckAPI()
    {
        return Ok("API is running");
    }
}