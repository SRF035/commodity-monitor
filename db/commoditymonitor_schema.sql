-- =====================================================
-- CommodityMonitor - Schema PostgreSQL Completo
-- Progettato per .NET 8 con Entity Framework
-- =====================================================

-- =====================================================
-- 1. COMMODITY_CONFIG - Configurazioni con Versioning Temporale
-- =====================================================
CREATE TABLE CommodityConfig (
    Id SERIAL PRIMARY KEY,
    Symbol VARCHAR(10) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    ThresholdPct DECIMAL(5,2) NOT NULL, -- Es. 3.50 per 3.5%
    Sector VARCHAR(50) NOT NULL,
    SectorIndexSymbol VARCHAR(10) NOT NULL, -- Es. DBB, SLV, URA
    GlobalIndexSymbol VARCHAR(10) NOT NULL DEFAULT 'BCOM',
    ValidFrom DATE NOT NULL,
    ValidTo DATE NULL, -- NULL = configurazione attiva
    Active BOOLEAN NOT NULL DEFAULT TRUE,
    CreatedAt TIMESTAMP DEFAULT NOW(),
    UpdatedAt TIMESTAMP DEFAULT NOW()
);

-- Indici per performance su versioning temporale
CREATE INDEX IX_CommodityConfig_Symbol_ValidPeriod ON CommodityConfig(Symbol, ValidFrom, ValidTo);
CREATE INDEX IX_CommodityConfig_Active ON CommodityConfig(Active) WHERE Active = TRUE;

-- =====================================================
-- 2. COMMODITY_PRICES - Storico Completo Prezzi e Benchmark
-- =====================================================
CREATE TABLE CommodityPrices (
    Id SERIAL PRIMARY KEY,
    Symbol VARCHAR(10) NOT NULL,
    Date DATE NOT NULL,
    Price DECIMAL(18,6) NOT NULL,
    MA30 DECIMAL(18,6) NULL, -- Media Mobile 30 giorni pre-calcolata
    SectorIndexValue DECIMAL(18,6) NULL, -- Valore indice settoriale del giorno
    GlobalIndexValue DECIMAL(18,6) NULL, -- Valore indice globale (BCOM) del giorno
    CreatedAt TIMESTAMP DEFAULT NOW()
);

-- Indici per performance su query temporali
CREATE UNIQUE INDEX IX_CommodityPrices_Symbol_Date ON CommodityPrices(Symbol, Date);
CREATE INDEX IX_CommodityPrices_Date ON CommodityPrices(Date);
CREATE INDEX IX_CommodityPrices_Symbol_DateDesc ON CommodityPrices(Symbol, Date DESC);

-- =====================================================
-- 3. COMMODITY_STATUS - Stato Attuale Trend
-- =====================================================
CREATE TABLE CommodityStatus (
    Id SERIAL PRIMARY KEY,
    Symbol VARCHAR(10) NOT NULL UNIQUE,
    IsInTrend BOOLEAN NOT NULL DEFAULT FALSE,
    DaysInTrend INTEGER NOT NULL DEFAULT 0,
    TrendStartDate DATE NULL,
    LastUpdateDate DATE NOT NULL,
    MA30Deviation DECIMAL(8,3) NULL, -- Scostamento % vs MA30
    SectorDeviation DECIMAL(8,3) NULL, -- Scostamento % vs Settore
    GlobalDeviation DECIMAL(8,3) NULL, -- Scostamento % vs Globale
    CreatedAt TIMESTAMP DEFAULT NOW(),
    UpdatedAt TIMESTAMP DEFAULT NOW()
);

-- Indici per query frequenti
CREATE INDEX IX_CommodityStatus_IsInTrend ON CommodityStatus(IsInTrend);
CREATE INDEX IX_CommodityStatus_LastUpdate ON CommodityStatus(LastUpdateDate);

-- =====================================================
-- 4. TREND_HISTORY - Tracciamento Giornaliero Completo
-- =====================================================
CREATE TABLE TrendHistory (
    Id SERIAL PRIMARY KEY,
    Symbol VARCHAR(10) NOT NULL,
    Date DATE NOT NULL,
    IsInTrend BOOLEAN NOT NULL,
    DaysInTrend INTEGER NOT NULL,
    MA30Deviation DECIMAL(8,3) NULL,
    SectorDeviation DECIMAL(8,3) NULL,
    GlobalDeviation DECIMAL(8,3) NULL,
    CreatedAt TIMESTAMP DEFAULT NOW()
);

-- Indici per analisi storiche
CREATE UNIQUE INDEX IX_TrendHistory_Symbol_Date ON TrendHistory(Symbol, Date);
CREATE INDEX IX_TrendHistory_Date ON TrendHistory(Date);
CREATE INDEX IX_TrendHistory_Symbol_InTrend ON TrendHistory(Symbol, IsInTrend);

-- =====================================================
-- 5. ALERTS - Log Alert Entrata/Uscita
-- =====================================================
CREATE TABLE Alerts (
    Id SERIAL PRIMARY KEY,
    Symbol VARCHAR(10) NOT NULL,
    AlertType VARCHAR(20) NOT NULL, -- 'TREND_START', 'TREND_END', 'TREND_CONTINUE'
    Date DATE NOT NULL,
    Message TEXT NOT NULL,
    MA30Deviation DECIMAL(8,3) NULL,
    SectorDeviation DECIMAL(8,3) NULL,
    GlobalDeviation DECIMAL(8,3) NULL,
    CreatedAt TIMESTAMP DEFAULT NOW()
);

-- Indici per report e query
CREATE INDEX IX_Alerts_Date ON Alerts(Date);
CREATE INDEX IX_Alerts_Symbol_Date ON Alerts(Symbol, Date);
CREATE INDEX IX_Alerts_AlertType ON Alerts(AlertType);

-- =====================================================
-- 6. COMMENT_TEMPLATES - Template Commenti Automatici
-- =====================================================
CREATE TABLE CommentTemplates (
    Id SERIAL PRIMARY KEY,
    Category VARCHAR(50) NOT NULL, -- 'Entrata', 'Mantenimento', 'Uscita'
    Priority INTEGER NOT NULL, -- Priorità numerica (più alto = priorità maggiore)
    TemplateText TEXT NOT NULL, -- Template con placeholder [Commodity], [X], etc.
    Active BOOLEAN NOT NULL DEFAULT TRUE,
    CreatedAt TIMESTAMP DEFAULT NOW(),
    UpdatedAt TIMESTAMP DEFAULT NOW()
);

-- Indici per selezione template
CREATE INDEX IX_CommentTemplates_Category_Priority ON CommentTemplates(Category, Priority DESC);
CREATE INDEX IX_CommentTemplates_Active ON CommentTemplates(Active) WHERE Active = TRUE;

-- =====================================================
-- VINCOLI E RELAZIONI
-- =====================================================

-- Check constraints per validazione dati
ALTER TABLE CommodityConfig ADD CONSTRAINT CK_CommodityConfig_ThresholdPct 
    CHECK (ThresholdPct > 0 AND ThresholdPct <= 100);

ALTER TABLE CommodityConfig ADD CONSTRAINT CK_CommodityConfig_ValidPeriod 
    CHECK (ValidTo IS NULL OR ValidTo >= ValidFrom);

ALTER TABLE CommodityStatus ADD CONSTRAINT CK_CommodityStatus_DaysInTrend 
    CHECK (DaysInTrend >= 0);

ALTER TABLE TrendHistory ADD CONSTRAINT CK_TrendHistory_DaysInTrend 
    CHECK (DaysInTrend >= 0);

ALTER TABLE CommentTemplates ADD CONSTRAINT CK_CommentTemplates_Priority 
    CHECK (Priority > 0);

-- =====================================================
-- FUNZIONI DI SUPPORTO
-- =====================================================

-- Funzione per aggiornare automaticamente UpdatedAt
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.UpdatedAt = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger per aggiornamento automatico UpdatedAt
CREATE TRIGGER update_commodityconfig_updated_at BEFORE UPDATE ON CommodityConfig
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_commoditystatus_updated_at BEFORE UPDATE ON CommodityStatus
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_commenttemplates_updated_at BEFORE UPDATE ON CommentTemplates
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =====================================================
-- POPOLAZIONE DATI INIZIALI
-- =====================================================

-- Inserimento Configurazioni Commodity (da commodity_config_defaults.md)
INSERT INTO CommodityConfig (Symbol, Name, ThresholdPct, Sector, SectorIndexSymbol, GlobalIndexSymbol, ValidFrom, ValidTo, Active) VALUES
('COPPER', 'Rame', 3.50, 'Metalli', 'DBB', 'BCOM', '2025-01-01', NULL, TRUE),
('SILVER', 'Argento', 3.00, 'Metalli', 'SLV', 'BCOM', '2025-01-01', NULL, TRUE),
('PALLADIUM', 'Palladio', 4.00, 'Metalli', 'PALL', 'BCOM', '2025-01-01', NULL, TRUE),
('URANIUM', 'Uranio', 6.00, 'Energia', 'URA', 'BCOM', '2025-01-01', NULL, TRUE),
('PLATINUM', 'Platino', 3.50, 'Metalli', 'PPLT', 'BCOM', '2025-01-01', NULL, TRUE),
('SOYBEAN', 'Soia', 3.00, 'Agricolo', 'SOYB', 'BCOM', '2025-01-01', NULL, TRUE),
('COFFEE', 'Caffè', 4.50, 'Agricolo', 'JO', 'BCOM', '2025-01-01', NULL, TRUE);

-- Inizializzazione CommodityStatus per tutte le commodity
INSERT INTO CommodityStatus (Symbol, IsInTrend, DaysInTrend, LastUpdateDate) VALUES
('COPPER', FALSE, 0, CURRENT_DATE),
('SILVER', FALSE, 0, CURRENT_DATE),
('PALLADIUM', FALSE, 0, CURRENT_DATE),
('URANIUM', FALSE, 0, CURRENT_DATE),
('PLATINUM', FALSE, 0, CURRENT_DATE),
('SOYBEAN', FALSE, 0, CURRENT_DATE),
('COFFEE', FALSE, 0, CURRENT_DATE);

-- Inserimento Template Commenti (da templates.md)
INSERT INTO CommentTemplates (Category, Priority, TemplateText, Active) VALUES
('Entrata', 100, '🚀 [Commodity] ha superato la soglia rispetto alla [Fonte] ed è entrata in trend.', TRUE),
('Entrata', 80, '📈 Nuovo trend attivo su [Commodity] grazie alla variazione rispetto a [Fonte].', TRUE),
('Mantenimento', 70, '📊 [Commodity] mantiene un trend attivo da [X] giorni consecutivi.', TRUE),
('Mantenimento', 60, '🔄 Il trend di [Commodity] prosegue: spread positivo e scostamenti ancora sopra soglia.', TRUE),
('Mantenimento', 50, '📈 [Commodity] resta in trend con performance coerente sul benchmark.', TRUE),
('Uscita', 90, '🛑 Il trend di [Commodity] è terminato: tutti gli scostamenti sono rientrati.', TRUE),
('Uscita', 70, '📉 Trend concluso per [Commodity], spread sotto soglia e normalizzazione in corso.', TRUE);

-- =====================================================
-- INDICI AGGIUNTIVI PER PERFORMANCE
-- =====================================================

-- Indici compositi per query complesse del sistema
CREATE INDEX IX_CommodityPrices_Symbol_LastDays ON CommodityPrices(Symbol, Date DESC) 
    WHERE Date >= CURRENT_DATE - INTERVAL '35 days'; -- Per calcolo MA30

CREATE INDEX IX_TrendHistory_Symbol_LastWeek ON TrendHistory(Symbol, Date DESC)
    WHERE Date >= CURRENT_DATE - INTERVAL '7 days'; -- Per report settimanali

-- Indice parziale per configurazioni attive
CREATE INDEX IX_CommodityConfig_ActiveCurrent ON CommodityConfig(Symbol, ThresholdPct, SectorIndexSymbol)
    WHERE ValidTo IS NULL AND Active = TRUE;

-- =====================================================
-- COMMENTI E DOCUMENTAZIONE
-- =====================================================

COMMENT ON TABLE CommodityConfig IS 'Configurazioni commodity con versioning temporale per soglie e indici dinamici';
COMMENT ON TABLE CommodityPrices IS 'Storico completo prezzi con MA30 e benchmark pre-calcolati per controlli congruenza';
COMMENT ON TABLE CommodityStatus IS 'Stato corrente trend per query veloci di sistema';
COMMENT ON TABLE TrendHistory IS 'Tracciamento giornaliero completo di tutti i trend per analisi storiche';
COMMENT ON TABLE Alerts IS 'Log di tutti gli alert generati dal sistema';
COMMENT ON TABLE CommentTemplates IS 'Template per commenti automatici con priorità dinamica';

COMMENT ON COLUMN CommodityConfig.ValidTo IS 'NULL indica configurazione attualmente attiva';
COMMENT ON COLUMN CommodityPrices.MA30 IS 'Media Mobile 30 giorni pre-calcolata per performance';
COMMENT ON COLUMN TrendHistory.DaysInTrend IS 'Giorni consecutivi in trend alla data specifica';

-- =====================================================
-- SCRIPT COMPLETATO
-- =====================================================