namespace system_metrics.Domain.Entities
{

    public class DeviceDetails
    {
        public int Id { get; set; }
        public string? DeviceId { get; set; }
        public DateTime? Timestamp { get; set; }
        public int? ThermalValue { get; set; }
        public int? BatteryLevel { get; set; }
        public int? MemoryUsage { get; set; }
        public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    }
}