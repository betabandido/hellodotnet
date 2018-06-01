using Microsoft.AspNetCore.Mvc;

namespace HelloService.Controllers
{
    [Route("healthz")]
    public class HealthzController : Controller
    {
        [HttpGet]
        public IActionResult Get()
        {
            return Ok();
        }
    }
}
