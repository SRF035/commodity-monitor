# 🏗️ CommodityMonitor - Modulo 1.1: Architettura Base Completata

## 📋 Stato del Progetto

**Modulo Completato**: Architettura Base Clean Architecture  
**Data Completamento**: Giugno 2025  
**Stato**: ✅ Struttura completa e pronta per sviluppo moduli specifici

---

## 🎯 Decisioni Architetturali Implementate

### 1. **Clean Architecture con Organizzazione Modulare**
- **Struttura scelta**: Opzione C - Modular Clean Architecture
- **Separazione layer**: Core / Infrastructure / Presentation
- **Dependency Injection**: Layered registration pattern
- **Scalabilità**: Preparato per Console + Future Web API

### 2. **Entity Framework Code-First con Models Snelli**
- **Approccio**: Code-First con entità manuali basate su schema esistente
- **Navigation Properties**: Evitate per prevenire ricorsività
- **Mapping**: Completo con indici, vincoli e precision decimali
- **Database**: PostgreSQL con convenzioni PascalCase

### 3. **Repository Pattern per Aggregates**
- **Decisione**: Future chat implementeranno repository specifici per bounded context
- **Flessibilità**: Ogni modulo decide i propri repository in base alle esigenze
- **Nessun vincolo**: Struttura aperta per implementazioni custom

---

## 📁 Struttura Progetto Implementata

```
CommodityMonitor.sln
├── Core/
│   ├── CommodityMonitor.Domain/          ✅ COMPLETATO
│   │   ├── Entities/                     (6 entità da database schema)
│   │   └── Enums/                        (AlertType, CommentCategory)
│   └── CommodityMonitor.Application/     📁 LAYER VUOTO (pronto per interfacce)
├── Infrastructure/
│   ├── CommodityMonitor.Data/            ✅ DbContext CONFIGURATO
│   │   └── CommodityMonitorDbContext.cs  (Mapping completo 6 tabelle)
│   └── CommodityMonitor.Infrastructure/  📁 LAYER VUOTO (pronto per servizi esterni)
└── Presentation/
    ├── CommodityMonitor.Console/         ✅ SETUP BASE
    │   ├── Program.cs                    (Host + DI minimale)
    │   └── appsettings.json             (DB + Email + Yahoo Finance config)
    └── CommodityMonitor.Api/             📁 PREPARATO (per future estensioni)
```

---

## 🗄️ Database Layer - COMPLETATO

### **Entità Implementate** (basate su schema PostgreSQL esistente)

| Entità | Scopo | Campi Chiave | Stato |
|--------|-------|--------------|-------|
| `CommodityConfig` | Configurazioni commodity con versioning | Symbol, ThresholdPct, ValidFrom/ValidTo | ✅ |
| `CommodityPrices` | Storico prezzi + MA30 + benchmark | Price, MA30, SectorIndexValue, GlobalIndexValue | ✅ |
| `CommodityStatus` | Stato trend corrente | IsInTrend, DaysInTrend, Deviations | ✅ |
| `TrendHistory` | Tracciamento giornaliero | Date, IsInTrend, Deviations | ✅ |
| `Alerts` | Log alert sistema | AlertType, Message, Date | ✅ |
| `CommentTemplates` | Template commenti dinamici | Category, Priority, TemplateText | ✅ |

### **DbContext Configurato**
- ✅ **Mapping completo** con indici di performance
- ✅ **Vincoli e relazioni** da schema originale
- ✅ **Precision decimali** corrette (18,6 per prezzi, 8,3 per deviazioni)
- ✅ **Default values** e trigger timestamps
- ✅ **Filtri su indici** per performance

---

## 🎯 Linee Guida per Chat Future

### ✅ **COSA POSSONO FARE LE CHAT FUTURE**

#### **Nel Layer Application**
```csharp
// Creare interfacce per repository
namespace CommodityMonitor.Application.Interfaces.Repositories;
public interface IMioRepository { ... }

// Creare interfacce per servizi
namespace CommodityMonitor.Application.Interfaces.Services;
public interface IMioService { ... }

// Creare DTOs per trasferimento dati
namespace CommodityMonitor.Application.DTOs;
public record MioDto(...);

// Creare use cases
namespace CommodityMonitor.Application.Interfaces.UseCases;
public interface IMioUseCase { ... }
```

#### **Nel Layer Data**
```csharp
// Implementare repository specifici
namespace CommodityMonitor.Data.Repositories;
public class MioRepository : IMioRepository { ... }

// Estendere DbContext se necessario (con attenzione)
// Aggiungere query specifiche ottimizzate
```

#### **Nel Layer Infrastructure**
```csharp
// Implementare servizi esterni
namespace CommodityMonitor.Infrastructure.Services;
public class MioService : IMioService { ... }

// Integrazioni API (Yahoo Finance, Email, etc.)
// Servizi di calcolo e business logic
```

#### **Nel Layer Console**
```csharp
// Implementare use cases
namespace CommodityMonitor.Console.UseCases;
public class MioUseCase : IMioUseCase { ... }

// Aggiungere hosted services
public class MioHostedService : BackgroundService { ... }

// Estendere dependency injection
services.AddMieiServizi();
```

### ❌ **COSA NON DEVONO MODIFICARE**

#### **🚨 ENTITÀ DOMAIN - NON MODIFICARE**
- ❌ **Non cambiare** le entità Domain esistenti
- ❌ **Non aggiungere** navigation properties alle entità
- ❌ **Non modificare** nomi o tipi di proprietà esistenti
- ✅ **Se servono nuove entità**, aggiungerle seguendo il pattern esistente

#### **🚨 DbContext MAPPING - ATTENZIONE**
- ❌ **Non modificare** il mapping esistente delle 6 tabelle principali
- ❌ **Non cambiare** precision decimali (18,6 per prezzi, 8,3 per deviazioni)
- ✅ **Se servono nuove tabelle**, aggiungerle senza toccare l'esistente

#### **🚨 CONVENZIONI STABILITE**
- ❌ **Non cambiare** PascalCase per tabelle e campi
- ❌ **Non modificare** structure folder Core/Infrastructure/Presentation
- ❌ **Non toccare** dependency direction (sempre verso l'interno)

---

## 🤖 Istruzioni per Claude nelle Chat Future

### **Contesto Disponibile**
```
✅ Schema PostgreSQL completo (vedi db/commoditymonitor_schema.sql)
✅ Architettura Clean Architecture implementata
✅ 6 entità Domain configurate e mappate
✅ DbContext pronto con tutti gli indici
✅ Dependency injection base setup
✅ Configurazioni appsettings preparate
```

### **Come Iniziare una Chat di Sviluppo**

1. **Leggi la documentazione base**:
   - `SPECIFICA.md` - Requisiti funzionali
   - `docs/commodity_config_defaults.md` - Configurazioni commodity
   - `docs/templates.md` - Template commenti
   - Questo documento - Architettura implementata

2. **Identifica il tuo modulo**:
   - Che funzionalità devi implementare?
   - Quali layer devi toccare?
   - Che interfacce/servizi/repository ti servono?

3. **Segui il pattern stabilito**:
   - Interfacce in `Application.Interfaces`
   - Implementazioni nei layer appropriati
   - Dependency injection pulito
   - Test delle implementazioni

### **Linee Guida Anti-Allucinazione**

- ✅ **USA SOLO** configurazioni da `commodity_config_defaults.md`
- ✅ **RISPETTA** le entità Domain esistenti
- ✅ **CONSULTA** sempre `SPECIFICA.md` per requisiti
- ❌ **NON INVENTARE** nuove commodity o configurazioni
- ❌ **NON MODIFICARE** database schema senza consultare documentazione
- ❌ **NON IMPLEMENTARE** logiche non specificate

### **Template per Nuove Implementazioni**

```csharp
// 1. Definisci interfaccia in Application
namespace CommodityMonitor.Application.Interfaces.Services;
public interface IMioService 
{
    Task<ResultType> MiaOperazioneAsync(InputType input);
}

// 2. Implementa nel layer appropriato
namespace CommodityMonitor.Infrastructure.Services;
public class MioService : IMioService
{
    private readonly CommodityMonitorDbContext _context;
    private readonly ILogger<MioService> _logger;
    
    public MioService(CommodityMonitorDbContext context, ILogger<MioService> logger)
    {
        _context = context;
        _logger = logger;
    }
    
    public async Task<ResultType> MiaOperazioneAsync(InputType input)
    {
        // Implementazione con logging ed error handling
    }
}

// 3. Registra in DI
services.AddScoped<IMioService, MioService>();
```

---

## 📚 File di Riferimento Essenziali

### **Documentazione Base Progetto**
- `SPECIFICA.md` - Requisiti funzionali completi ⭐️
- `README.md` - Overview generale progetto
- `docs/commodity_config_defaults.md` - 7 commodity configurate ⭐️
- `docs/templates.md` - Template commenti con priorità ⭐️
- `docs/IA_guidelines.md` - Linee guida anti-allucinazione ⭐️

### **Database e Schema**
- `db/commoditymonitor_schema.sql` - Schema completo PostgreSQL ⭐️
- `db/database_design_document.md` - Decisioni architetturali database

### **Architettura (Questo Modulo)**
- Questo documento - Stato architettura e linee guida future ⭐️

---

## 🚀 Moduli Successivi Suggeriti

> **💡 Approccio Modulare**: Ogni funzionalità implementa il proprio data access layer in base alle proprie esigenze specifiche. Questo garantisce maggiore coesione e autonomia.

### **Modulo 2 - Yahoo Finance Integration**
- **Scopo**: Integrazione API Yahoo Finance + data access per prezzi e indici
- **Deliverable**: 
  - `IYahooFinanceService` + implementazione con retry/error handling
  - Repository specifici per operazioni su `CommodityPrices` e `CommodityConfig`
  - Query ottimizzate per calcoli MA30 e fetch configurazioni attive
- **Data Access**: Metodi per salvare prezzi, leggere configurazioni, calcolare MA30
- **Priorità**: Alta (base per tutti gli altri moduli)

### **Modulo 3 - Trend Calculator Engine**
- **Scopo**: Logica calcolo scostamenti, regole entrata/uscita trend, gestione alert
- **Deliverable**:
  - `ITrendCalculatorService` + `IAlertService` con logiche specifiche
  - Repository per operazioni su `CommodityStatus`, `TrendHistory`, `Alerts`
  - Query complesse per analisi trend e storico
- **Data Access**: Metodi per aggiornare status, salvare history, gestire alert
- **Dipendenze**: Modulo 2 (per prezzi e configurazioni)

### **Modulo 4 - Email & Report System**
- **Scopo**: Generazione email giornaliere e report HTML settimanali
- **Deliverable**:
  - `IEmailService` + `IReportGeneratorService` + `ICommentService`
  - Repository per operazioni su `CommentTemplates`, `Alerts`, aggregazioni report
  - Template engine per commenti dinamici
- **Data Access**: Query per template, alert del giorno/settimana, statistiche trend
- **Dipendenze**: Modulo 3 (per alert e trend data)

### **Modulo 5 - Job Orchestration**
- **Scopo**: Orchestrazione job giornalieri/settimanali + hosted services
- **Deliverable**:
  - `IDailyJobUseCase` + `IWeeklyReportUseCase`
  - `DailyJobHostedService` + `WeeklyReportHostedService`
  - Coordinamento e error handling centralizzato
- **Data Access**: Utilizza i repository dei moduli precedenti
- **Dipendenze**: Moduli 2, 3, 4 (orchestrazione completa)

### **Modulo 6 - Web API (Future)**
- **Scopo**: Dashboard e API REST per gestione manuale
- **Deliverable**: Controllers + Authentication + Swagger + SPA frontend
- **Data Access**: Riutilizza repository esistenti, possibili estensioni per UI
- **Priorità**: Bassa (estensione futura)

---

## 📞 Supporto e Coordinamento

### **Se Hai Dubbi su Architettura**
1. Consulta questo documento
2. Verifica la `SPECIFICA.md`
3. Controlla `IA_guidelines.md`
4. Se necessario, chiedi chiarimenti riferendoti a questo modulo

### **Prima di Modificare Struttura**
- ⚠️ **Verifica** che non impatti altri layer
- ⚠️ **Consulta** le convenzioni stabilite
- ⚠️ **Evita** breaking changes sulle entità Domain

### **Per Estensioni Future**
- ✅ Aggiungi nuovi layer se necessario
- ✅ Estendi configurazioni per nuove esigenze
- ✅ Implementa pattern repository/service customizzati
- ✅ Mantieni dependency direction verso il Core

---

## 🎯 Conclusioni

**L'architettura base è completa e robusta.** Ogni chat futura può concentrarsi sulla propria logica business specifica senza preoccuparsi della struttura fondamentale.

**Il sistema è progettato per essere**:
- 🔧 **Modulare**: Ogni componente è sostituibile
- 🧪 **Testabile**: Dependency injection e interfacce clean
- 📈 **Scalabile**: Pronto per estensioni web e dashboard
- 🛡️ **Robusto**: Error handling e logging integrati

**Ready to build! 🚀**