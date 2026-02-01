using System.ComponentModel.DataAnnotations;
using system_metrics.Application.Dtos;

namespace system_metrics.Tests
{
    public class DeviceDTOTest
    {
        [Fact]
        public void DeviceDetailsDTO_Validation_Should_Fail_For_Invalid_Data()
        {
            var dto = new DeviceDetailsDTO
            {
                DeviceId = null,
                DeviceOS = "iOS",
                Timestamp = DateTime.UtcNow.AddHours(1),
                ThermalValue = -2,
                BatteryLevel = -10,
                MemoryUsage = 1000
            };

            var validationContext = new ValidationContext(dto);
            var validationResults = new List<ValidationResult>();

            var isValid = Validator.TryValidateObject(dto, validationContext, validationResults, true);

            Assert.False(isValid);
            Assert.Equal(5, validationResults.Count);
        }
    }
}