namespace CommodityMonitor.Domain.Entities
{
    public class CommodityConfig
    {
        public int Id { get; set; }
        public string Symbol { get; set; } = string.Empty;
        public string Name { get; set; } = string.Empty;
        public decimal ThresholdPct { get; set; }
        public string Sector { get; set; } = string.Empty;
        public string SectorIndexSymbol { get; set; } = string.Empty;
        public string GlobalIndexSymbol { get; set; } = string.Empty;
        public DateTime ValidFrom { get; set; }
        public DateTime? ValidTo { get; set; }
        public bool Active { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
    }

}
