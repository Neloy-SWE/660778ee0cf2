using system_metrics.Domain.Entities;

namespace system_metrics.Application.Dtos
{
    public class DeviceDetailsDTO
    {
        public string DeviceId { get; set; } = string.Empty;
        public DateTime Timestamp { get; set; }
        public int ThermalValue { get; set; }
        public int BatteryLevel { get; set; }
        public int MemoryUsage { get; set; }
        public static DeviceDetails MapEntity(DeviceDetailsDTO dto)
        {
            return new DeviceDetails
            {
                DeviceId = dto.DeviceId,
                Timestamp = dto.Timestamp,
                ThermalValue = dto.ThermalValue,
                BatteryLevel = dto.BatteryLevel,
                MemoryUsage = dto.MemoryUsage
            };
        }
    }


}