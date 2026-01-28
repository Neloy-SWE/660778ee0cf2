using System.ComponentModel.DataAnnotations;
using system_metrics.Application.Validation;
using system_metrics.Domain.Entities;

namespace system_metrics.Application.Dtos
{
    public class DeviceDetailsDTO
    {
        [Required(ErrorMessage = "The DeviceId field is required.")]
        public string? DeviceId { get; set; }
        
        [Required(ErrorMessage = "The DeviceOS field is required.")]
        public string? DeviceOS { get; set; }

        [Required(ErrorMessage = "The Timestamp field is required.")]
        [TimeStamp(ErrorMessage = "You cannot report metrics for a future time.")]
        public DateTime? Timestamp { get; set; }

        [Required(ErrorMessage = "The ThermalValue field is required.")]
        [Range(0, 3, ErrorMessage = "Thermal value must be between 0 and 3")]
        public int? ThermalValue { get; set; }

        [Required(ErrorMessage = "The BatteryLevel field is required.")]
        [Range(0, 100, ErrorMessage = "Battery level must be between 0 and 100")]
        public int? BatteryLevel { get; set; }

        [Required(ErrorMessage = "The MemoryUsage field is required.")]
        [Range(0, 100, ErrorMessage = "Memory usage must be between 0 and 100")]
        public int? MemoryUsage { get; set; }
        public static DeviceDetails MapEntity(DeviceDetailsDTO dto)
        {
            return new DeviceDetails
            {
                DeviceId = dto.DeviceId,
                DeviceOS = dto.DeviceOS,
                Timestamp = dto.Timestamp,
                ThermalValue = dto.ThermalValue,
                BatteryLevel = dto.BatteryLevel,
                MemoryUsage = dto.MemoryUsage
            };
        }
    }


}