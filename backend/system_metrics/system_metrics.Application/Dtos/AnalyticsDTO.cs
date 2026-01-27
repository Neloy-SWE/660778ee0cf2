namespace system_metrics.Application.Dtos
{
    public class AnalyticsDTO
    {
        public double AverageThermalValue { get; set; }
        public double AverageBatteryLevel { get; set; }
        public double AverageMemoryUsage { get; set; }
        public int MinimumThermalValue { get; set; }
        public int MaximumThermalValue { get; set; }
        public int MinimumBatteryLevel { get; set; }
        public int MaximumBatteryLevel { get; set; }
        public int MinimumMemoryUsage { get; set; }
        public int MaximumMemoryUsage { get; set; }
    }
}