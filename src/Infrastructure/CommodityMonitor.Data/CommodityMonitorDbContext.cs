using CommodityMonitor.Domain.Entities;
using Microsoft.EntityFrameworkCore;

namespace CommodityMonitor.Data
{
    public class CommodityMonitorDbContext : DbContext
    {
        public CommodityMonitorDbContext(DbContextOptions<CommodityMonitorDbContext> options) : base(options) { }

        public DbSet<CommodityConfig> CommodityConfig { get; set; }
        public DbSet<CommodityPrices> CommodityPrices { get; set; }
        public DbSet<CommodityStatus> CommodityStatus { get; set; }
        public DbSet<TrendHistory> TrendHistory { get; set; }
        public DbSet<Alerts> Alerts { get; set; }
        public DbSet<CommentTemplates> CommentTemplates { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // CommodityConfig
            modelBuilder.Entity<CommodityConfig>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Symbol).HasMaxLength(10).IsRequired();
                entity.Property(e => e.Name).HasMaxLength(100).IsRequired();
                entity.Property(e => e.ThresholdPct).HasColumnType("decimal(5,2)").IsRequired();
                entity.Property(e => e.Sector).HasMaxLength(50).IsRequired();
                entity.Property(e => e.SectorIndexSymbol).HasMaxLength(10).IsRequired();
                entity.Property(e => e.GlobalIndexSymbol).HasMaxLength(10).IsRequired();
                entity.Property(e => e.CreatedAt).HasDefaultValueSql("NOW()");
                entity.Property(e => e.UpdatedAt).HasDefaultValueSql("NOW()");

                entity.HasIndex(e => new { e.Symbol, e.ValidFrom, e.ValidTo });
                entity.HasIndex(e => e.Active).HasFilter("Active = true");
            });

            // CommodityPrices
            modelBuilder.Entity<CommodityPrices>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Price).HasColumnType("decimal(18,6)").IsRequired();
                entity.Property(e => e.MA30).HasColumnType("decimal(18,6)");
                entity.Property(e => e.SectorIndexValue).HasColumnType("decimal(18,6)");
                entity.Property(e => e.GlobalIndexValue).HasColumnType("decimal(18,6)");
                entity.Property(e => e.CreatedAt).HasDefaultValueSql("NOW()");

                entity.HasIndex(e => new { e.CommodityConfigId, e.Date }).IsUnique();
                entity.HasIndex(e => e.Date);
            });

            // CommodityStatus
            modelBuilder.Entity<CommodityStatus>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.CommodityConfigId).IsRequired();
                entity.Property(e => e.MA30Deviation).HasColumnType("decimal(8,3)");
                entity.Property(e => e.SectorDeviation).HasColumnType("decimal(8,3)");
                entity.Property(e => e.GlobalDeviation).HasColumnType("decimal(8,3)");
                entity.Property(e => e.CreatedAt).HasDefaultValueSql("NOW()");
                entity.Property(e => e.UpdatedAt).HasDefaultValueSql("NOW()");

                entity.HasIndex(e => e.CommodityConfigId).IsUnique();
                entity.HasIndex(e => e.IsInTrend);
            });

            // TrendHistory
            modelBuilder.Entity<TrendHistory>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.MA30Deviation).HasColumnType("decimal(8,3)");
                entity.Property(e => e.SectorDeviation).HasColumnType("decimal(8,3)");
                entity.Property(e => e.GlobalDeviation).HasColumnType("decimal(8,3)");
                entity.Property(e => e.CreatedAt).HasDefaultValueSql("NOW()");

                entity.HasIndex(e => new { e.CommodityConfigId, e.Date }).IsUnique();
                entity.HasIndex(e => e.Date);
            });

            // Alerts
            modelBuilder.Entity<Alerts>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.AlertType).HasMaxLength(20).IsRequired();
                entity.Property(e => e.Message).IsRequired();
                entity.Property(e => e.MA30Deviation).HasColumnType("decimal(8,3)");
                entity.Property(e => e.SectorDeviation).HasColumnType("decimal(8,3)");
                entity.Property(e => e.GlobalDeviation).HasColumnType("decimal(8,3)");
                entity.Property(e => e.CreatedAt).HasDefaultValueSql("NOW()");

                entity.HasIndex(e => e.Date);
                entity.HasIndex(e => e.AlertType);
            });

            // CommentTemplates
            modelBuilder.Entity<CommentTemplates>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.Category).HasMaxLength(50).IsRequired();
                entity.Property(e => e.TemplateText).IsRequired();
                entity.Property(e => e.CreatedAt).HasDefaultValueSql("NOW()");
                entity.Property(e => e.UpdatedAt).HasDefaultValueSql("NOW()");

                entity.HasIndex(e => new { e.Category, e.Priority }).HasDatabaseName("IX_CommentTemplates_Category_Priority");
                entity.HasIndex(e => e.Active).HasFilter("Active = true");
            });
        }
    }
}
