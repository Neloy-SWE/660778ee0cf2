using system_metrics.Domain.Entities;

namespace system_metrics.Tests
{
    public class AnalyticsTest
    {
        [Fact]
        public void GetAnalytics_ShouldReturnCorrectAverages()
        {
            
            var deviceDetails = new List<DeviceDetails>
            {
                new() { DeviceId = "device1", ThermalValue = 5, BatteryLevel = 80, MemoryUsage = 60 },
                new() { DeviceId = "device1", ThermalValue = 7, BatteryLevel = 70, MemoryUsage = 50 },
                new() { DeviceId = "device1", ThermalValue = 6, BatteryLevel = 75, MemoryUsage = 55 }
            };

            var analytics = deviceDetails
                .GroupBy(d => d.DeviceId)
                .Select(g => new
                {
                    DeviceId = g.Key,
                    AvgThermalValue = g.Average(d => d.ThermalValue),
                    AvgBatteryLevel = g.Average(d => d.BatteryLevel),
                    AvgMemoryUsage = g.Average(d => d.MemoryUsage)
                })
                .FirstOrDefault();

            Assert.NotNull(analytics);
            Assert.Equal("device1", analytics.DeviceId);
            Assert.Equal(6, analytics.AvgThermalValue);
            Assert.Equal(75, analytics.AvgBatteryLevel);
            Assert.Equal(55, analytics.AvgMemoryUsage);
        }
    }
}