# 🗄️ CommodityMonitor - Architettura Database PostgreSQL

## 📋 Stato del Progetto

**Modulo Completato**: Database Schema PostgreSQL  
**Data Completamento**: Giugno 2025  
**Stato**: ✅ Schema completo e testato, pronto per implementazione .NET

---

## 🎯 Decisioni Architetturali Prese

### 1. **Approccio "Storico Completo"**
- **Decisione**: Salvare **tutti i dati storici** (prezzi, MA30, benchmark, trend) per controlli di congruenza futuri
- **Razionale**: Massima trasparenza, debugging semplificato, audit trail completo
- **Impatto**: Schema più ricco ma query performance ottimali

### 2. **Configurazioni con Versioning Temporale**
- **Decisione**: `CommodityConfig` con `ValidFrom/ValidTo` per gestire modifiche dinamiche
- **Razionale**: Soglie, indici settoriali e globali devono essere configurabili runtime
- **Impatto**: Ogni modifica crea nuova riga, storico configurazioni completo

### 3. **Template System Ibrido**
- **Decisione**: Template commenti in database, logica condizioni in codice C#
- **Razionale**: Flessibilità modifica template senza deploy, business logic robusta in applicazione
- **Impatto**: Tabella `CommentTemplates` con priorità dinamica

### 4. **Tracciamento Giornaliero Completo**
- **Decisione**: `TrendHistory` salva **ogni giorno** stato completo trend + scostamenti
- **Razionale**: Analisi dettagliate, ricostruzione stati passati, audit granulare
- **Impatto**: Volume dati alto ma analisi complete possibili

### 5. **Naming Convention .NET**
- **Decisione**: PascalCase per tabelle e campi
- **Razionale**: Coerenza con stack .NET 8 + Entity Framework
- **Esempio**: `CommodityConfig`, `ThresholdPct`, `CreatedAt`

### 6. **Timestamp Essenziali**
- **Decisione**: `CreatedAt` su tutte le tabelle, `UpdatedAt` solo dove necessario
- **Razionale**: Sistema automatico, overhead minimo, informazioni fondamentali
- **Implementazione**: Trigger automatici per aggiornamento

---

## 📊 Schema Database Implementato

### **Tabelle Principali**

| Tabella | Scopo | Caratteristiche |
|---------|-------|-----------------|
| `CommodityConfig` | Configurazioni versionate | ValidFrom/ValidTo, tutti parametri dinamici |
| `CommodityPrices` | Storico prezzi completo | Price + MA30 + benchmark pre-calcolati |
| `CommodityStatus` | Stato trend corrente | Query veloci, stato real-time |
| `TrendHistory` | Tracciamento giornaliero | Ogni giorno tutti scostamenti e stato |
| `Alerts` | Log alert sistema | START/END/CONTINUE con dettagli |
| `CommentTemplates` | Template commenti | Categoria, priorità, modificabili |

### **Relazioni Chiave**
- `CommodityConfig.Id` → `CommodityPrices.CommodityConfigId` (1:N)
- `CommodityConfig.Id` → `CommodityStatus.CommodityConfigId` (1:1)
- `CommodityConfig.Id` → `TrendHistory.CommodityConfigId` (1:N)

### **Indici Performance**
- Range temporali ottimizzati (MA30 calculation)
- Lookup veloci per configurazioni attive
- Query composite per analisi storiche

---

## 🚀 Popolazione Dati Iniziali

### **7 Commodity Configurate**
```
HG=F (Rame 3.5%), SI=F (Argento 3.0%), PA=F (Palladio 4.0%), URA (Uranio 6.0%), 
PL=F (Platino 3.5%), ZS=F (Soia 3.0%), KC=F (Caffè 4.5%)
```

### **Template Commenti Implementati**
- **Entrata**: 2 template (priorità 100, 80)
- **Mantenimento**: 3 template (priorità 70, 60, 50)  
- **Uscita**: 2 template (priorità 90, 70)

---

## 💡 Logiche di Business Supportate

### **Calcolo Scostamenti**
```
Scostamento = ((Prezzo Attuale - Benchmark) / Benchmark) * 100
```

### **Regole Trend**
- **Entrata**: Almeno 1 scostamento > soglia
- **Uscita**: Tutti e 3 scostamenti < soglia

### **Benchmark Supportati**
1. Media Mobile 30 giorni (primario)
2. Indice Settoriale (DBB, SLV, URA, etc.)
3. Indice Globale (BCOM)

---

## 🔧 Configurazione Tecnica

### **Database Requirements**
- PostgreSQL 12+
- .NET 8 Entity Framework Core
- SMTP per email alerts
- Yahoo Finance API per dati

### **Performance Notes**
- Indici ottimizzati per query giornaliere
- Retention policy da definire (5+ anni raccomandato)
- Partitioning su TrendHistory se volume alto

---

## 📁 File di Riferimento

### **Documenti Base Progetto**
- `SPECIFICA.md` - Requisiti funzionali completi
- `commodity_config_defaults.md` - Configurazioni iniziali
- `templates.md` - Template commenti con priorità
- `IA_guidelines.md` - Linee guida anti-allucinazione

### **Output Questo Modulo**
- ✅ Schema SQL completo in `/db/schema.sql`
- ✅ Script popolazione in `/db/initial_data.sql`
- ✅ Documentazione tabelle e relazioni

---

## 🎯 Prossimi Moduli da Sviluppare

### **Modulo 2 - .NET Core Models & Entity Framework**
- Generazione models da database
- DbContext configurazione
- Repository pattern setup

### **Modulo 3 - Data Fetcher (Yahoo Finance)**
- Wrapper API Yahoo Finance
- Fetching prezzi + indici
- Calcolo MA30 e scostamenti

### **Modulo 4 - Trend Analyzer Engine**
- Logica entrata/uscita trend
- Aggiornamento CommodityStatus
- Generazione TrendHistory

### **Modulo 5 - Alert & Email System**
- Template engine per commenti
- Generazione email giornaliere
- SMTP sender configuration

### **Modulo 6 - Weekly Report Generator**
- Report HTML con grafici
- Integrazione news feeds
- Context macro + settoriale

---

## 🤖 Istruzioni per Claude nelle Prossime Chat

### **Contesto Disponibile**
- Schema database PostgreSQL completo implementato
- Tutte le decisioni architetturali documentate
- 7 commodity configurate e pronte
- Template system funzionante

### **Linee Guida Sviluppo**
1. **Usa SOLO** configurazioni da `commodity_config_defaults.md`
2. **Segui** le convenzioni PascalCase stabilite
3. **Rispetta** la logica versioning temporale per configurazioni
4. **Non allucinare** nuove commodity o configurazioni
5. **Consulta sempre** `SPECIFICA.md` per requisiti funzionali

### **Entity Framework Setup**
- Database-first approach dal schema esistente
- Connection string PostgreSQL
- Models generati automaticamente
- Repository pattern raccomandato

### **Note Critiche**
- ⚠️ **Non modificare** schema senza consultare questo documento
- ⚠️ **ValidFrom/ValidTo** obbligatorio per nuove configurazioni
- ⚠️ **Template ID** da rispettare per commenti automatici
- ⚠️ **Symbol** names esatti da commodity_config_defaults.md

---

## 📞 Contatto e Supporto

**Riferimento Modulo**: Database Schema PostgreSQL  
**Stato**: Completato e documentato  
**Prossimo Step**: Entity Framework Models Generation  

**Questo documento è aggiornato e contiene tutte le informazioni necessarie per continuare lo sviluppo del sistema CommodityMonitor.**