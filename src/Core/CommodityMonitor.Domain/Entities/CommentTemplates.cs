namespace CommodityMonitor.Domain.Entities
{
    public class CommentTemplates
    {
        public int Id { get; set; }
        public string Category { get; set; } = string.Empty; // Entrata, Mantenimento, Uscita
        public int Priority { get; set; }
        public string TemplateText { get; set; } = string.Empty;
        public bool Active { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime UpdatedAt { get; set; }
    }
}
