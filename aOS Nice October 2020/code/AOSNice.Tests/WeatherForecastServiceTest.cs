using AOSNice.Shared;
using NUnit.Framework;

namespace AOSNice.Tests
{
    public class WeatherForecastServiceTest
    {
        [SetUp]
        public void Setup()
        {
        }

        [Test]
        public void Test1()
        {
            WeatherForecastService service = new WeatherForecastService();
            service.AddCity("Rennes");
            Assert.AreEqual(2, WeatherForecastService.Cities.Count);
        }
    }
}