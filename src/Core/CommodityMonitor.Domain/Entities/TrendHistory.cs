namespace CommodityMonitor.Domain.Entities
{
    public class TrendHistory
    {
        public int Id { get; set; }
        public int CommodityConfigId { get; set; }
        public DateTime Date { get; set; }
        public bool IsInTrend { get; set; }
        public int DaysInTrend { get; set; }
        public decimal? MA30Deviation { get; set; }
        public decimal? SectorDeviation { get; set; }
        public decimal? GlobalDeviation { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
