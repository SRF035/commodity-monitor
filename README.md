# 📊 CommodityMonitor

Sistema per il monitoraggio di commodity finanziarie con lo scopo di identificare e seguire trend significativi attraverso scostamenti rispetto a benchmark predefiniti.

---

## 🎯 Obiettivo

Cavalcare trend direzionali di medio periodo sulle materie prime attraverso:
- Alert automatici basati su scostamenti rispetto a media mobile e benchmark
- Notifiche giornaliere via email
- Report settimanali in HTML con analisi macro, settoriale e specifica

---

## ⚙️ Stack Tecnologico

- **Backend**: .NET 8 (C#)
- **Database**: PostgreSQL
- **Dati Finanziari**: Yahoo Finance (wrapper API)
- **Output**:
  - Email testuale giornaliera (SMTP)
  - Report settimanale HTML con grafici e notizie
- **Ambiente configurabile**: appsettings.json e configurazioni per commodity

---

## 📁 Struttura del Repository

| Cartella         | Contenuto                                      |
|------------------|------------------------------------------------|
| `/src`           | Codice sorgente .NET                           |
| `/docs`          | Documentazione tecnica e specifiche            |
| `/reports`       | Output dei report HTML                         |
| `/db`            | Script SQL e schema del database               |
| `/examples`      | File di esempio di email, commenti, HTML       |

---

## 📄 Documentazione Essenziale

- 📘 [SPECIFICA.md](docs/SPECIFICA.md) – Tutti i dettagli funzionali e tecnici
- 📦 [commodity_config_defaults.md](docs/commodity_config_defaults.md) – Config predefinite per ogni commodity
- 💬 [templates.md](docs/templates.md) – Template commenti automatici con priorità dinamica
- 📬 [daily_report_spec.md](docs/daily_report_spec.md) – Email giornaliera
- 📊 [weekly_report_spec.md](docs/weekly_report_spec.md) – Report settimanale con grafici e notizie
- 🤖 [IA_guidelines.md](docs/IA_guidelines.md) – Come usare Claude senza allucinazioni
- 👤 [OPERATOR_GUIDE.md](docs/OPERATOR_GUIDE.md) – Istruzioni operative quotidiane e settimanali

---

## 🚀 Avvio Rapido

1. Clona il repository
2. Configura `appsettings.json` per DB e SMTP
3. Esegui il job giornaliero schedulato (scheduler/task)
4. Verifica email e report generati

---

## 🤖 Integrazione con Claude

Claude può generare codice, moduli, refactoring e analisi seguendo:
- La guida IA: [IA_guidelines.md](docs/IA_guidelines.md)
- La specifica centrale: [SPECIFICA.md](docs/SPECIFICA.md)
- I file strutturati della knowledge base

---

## 📈 Estensioni Future

- Dashboard interattiva per monitoraggio trend
- Integrazione con AI per commenti avanzati
- Telegram/PWA Notifications

---

## 📜 Licenza

MIT (o altra a tua scelta)

---

## 👤 Autore
Sistema progettato per analisi di trend sulle materie prime con approccio semi-automatico e supporto all’operatore.