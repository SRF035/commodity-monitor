namespace CommodityMonitor.Domain.Entities
{
    public class Alerts
    {
        public int Id { get; set; }
        public int CommodityConfigId { get; set; }
        public string AlertType { get; set; } = string.Empty; // TREND_START, TREND_END, TREND_CONTINUE
        public DateTime Date { get; set; }
        public string Message { get; set; } = string.Empty;
        public decimal? MA30Deviation { get; set; }
        public decimal? SectorDeviation { get; set; }
        public decimal? GlobalDeviation { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
