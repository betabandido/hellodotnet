using Microsoft.AspNetCore.Mvc;

using HelloService.Repositories;

namespace HelloService.Controllers
{
    [Route("api/[controller]")]
    public class GreetingController : Controller
    {
        [HttpGet("{lang}")]
        [ProducesResponseType(200, Type = typeof(string))]
        [ProducesResponseType(404)]
        public IActionResult Get(string lang)
        {
            var repository = new GreetingRepository();
            var greeting = repository.GetGreeting(lang);
            if (greeting == null)
            {
                return NotFound();
            }
            
            return Ok(greeting);
        }
    }
}
