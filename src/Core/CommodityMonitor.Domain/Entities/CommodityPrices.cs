namespace CommodityMonitor.Domain.Entities
{
    public class CommodityPrices
    {
        public int Id { get; set; }
        public int CommodityConfigId { get; set; }
        public DateTime Date { get; set; }
        public decimal Price { get; set; }
        public decimal? MA30 { get; set; }
        public decimal? SectorIndexValue { get; set; }
        public decimal? GlobalIndexValue { get; set; }
        public DateTime CreatedAt { get; set; }
    }
}
