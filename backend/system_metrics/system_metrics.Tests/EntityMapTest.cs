using system_metrics.Application.Dtos;

namespace system_metrics.Tests
{
    public class EntityMapTest
    {
        [Fact]
        public void DeviceDetailsDTO_MapEntity_Should_Map_Correctly()
        {
            var dto = new DeviceDetailsDTO
            {
                DeviceId = "device123",
                DeviceOS = "Android",
                Timestamp = DateTime.UtcNow,
                ThermalValue = 2,
                BatteryLevel = 80,
                MemoryUsage = 60
            };

            var entity = DeviceDetailsDTO.MapEntity(dto);

            Assert.Equal(dto.DeviceId, entity.DeviceId);
            Assert.Equal(dto.DeviceOS, entity.DeviceOS);
            Assert.Equal(dto.Timestamp, entity.Timestamp);
            Assert.Equal(dto.ThermalValue, entity.ThermalValue);
            Assert.Equal(dto.BatteryLevel, entity.BatteryLevel);
            Assert.Equal(dto.MemoryUsage, entity.MemoryUsage);
        }
    }
}