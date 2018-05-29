using System.Collections.Generic;

namespace HelloService.Repositories
{
    public class GreetingRepository
    {
        private Dictionary<string, string> Greetings = new Dictionary<string, string>
        {
            { "en", "Hi!" },
            { "ca", "Hola!" },
            { "es", "Hola!" },
            { "ja", "こんにちは" }
        };
        
        public string GetGreeting(string language)
        {
            Greetings.TryGetValue(language, out var greeting);
            return greeting;
        }
    }
}
