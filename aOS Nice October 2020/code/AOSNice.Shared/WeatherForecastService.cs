using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace AOSNice.Shared
{
    public class WeatherForecastService
    {
        public static IList<string> Cities = new List<string> { "Nice" };

        private static readonly string[] Summaries = new[]
        {
            "Freezing", "Bracing", "Chilly", "Cool", "Mild", "Warm", "Balmy", "Hot", "Sweltering", "Scorching"
        };

        public WeatherForecastService() { }

        public void AddCity(string cityName)
        {
            Cities.Add(cityName);
        }

        public Task<WeatherForecast[]> GetForecastAsync(DateTime startDate)
        {
            var rng = new Random();
            return Task.FromResult(Enumerable.Range(1, 5).Select(index => new WeatherForecast
            {
                Date = startDate.AddDays(index),
                TemperatureC = rng.Next(-20, 55),
                Summary = Summaries[rng.Next(Summaries.Length)]
            }).ToArray());
        }
    }
}
