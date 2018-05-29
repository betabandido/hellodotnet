using HelloService.Repositories;
using Xunit;

namespace HelloService.Tests.Repositories
{
    public class GreetingRepositoryShould
    {
        [Fact]
        public void ReturnNullIfUnknownLanguage()
        {
            var repository = new GreetingRepository();

            Assert.Null(repository.GetGreeting("unknown-language"));
        }

        [Theory]
        [InlineData("en", "Hi!")]
        [InlineData("ca", "Hola!")]
        public void ReturnGreetingMessage(string language, string greeting)
        {
            var repository = new GreetingRepository();
            
            Assert.Equal(greeting, repository.GetGreeting(language));
        }
    }
}
