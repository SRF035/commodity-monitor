namespace CommodityMonitor.Domain.Entities
{
    public class CommodityStatus
    {
        public int Id { get; set; }
        public int CommodityConfigId { get; set; }
        public bool IsInTrend { get; set; }
        public int DaysInTrend { get; set; }
        public DateTime? TrendStartDate { get; set; }
        public DateTime LastUpdateDate { get; set; }
        public decimal? MA30Deviation { get; set; }
        public decimal? SectorDeviation { get; set; }
        public decimal? GlobalDeviation { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
    }
}
