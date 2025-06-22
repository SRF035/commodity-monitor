# 📘 SPECIFICA GENERALE – Sistema CommodityMonitor

## 🎯 Obiettivo

Monitorare giornalmente una selezione di materie prime per identificare l’inizio e la fine di trend direzionali basandosi su scostamenti rispetto a:
- una media mobile a 30 giorni (benchmark primario)
- un indice settoriale
- un indice globale (Bloomberg Commodity Index - BCOM)

Fornire alert tramite email testuale giornaliera e un report settimanale in HTML ricco di grafici, commenti e notizie.

---

## ⚙️ Architettura Tecnica

📄 Vedi: [ARCHITECTURE.md](ARCHITECTURE.md)

- Linguaggio: .NET 8 (C#)
- Database: PostgreSQL
- Fonte Dati: Yahoo Finance
- Scheduler: giornaliero (dati e calcoli), settimanale (report)
- Output: email testo + report HTML
- Modulare, configurabile e facilmente estendibile

---

## 📊 Logiche di Calcolo

### 🔢 Scostamenti monitorati
1. Media Mobile 30 giorni (MA30)
2. Indice Settoriale (es. DBB, SLV, URA…)
3. Indice Globale (BCOM)

### 📐 Formula Scostamento
```
Scostamento = ((Prezzo Attuale - Valore Benchmark) / Valore Benchmark) * 100
```

---

## 🚦 Regole di Attivazione Trend

### ✅ Entrata in Trend
Un trend è **attivo** se almeno uno degli scostamenti supera la soglia configurata.

### ❌ Uscita dal Trend
Un trend termina quando **tutti e tre** gli scostamenti rientrano sotto soglia.

🔗 Configurazioni: [commodity_config_defaults.md](commodity_config_defaults.md)

---

## ✉️ Notifiche e Report

### 📨 Email Giornaliera (solo testo)
📄 Specifiche: [daily_report_spec.md](daily_report_spec.md)

- Riepilogo alert: entrata, mantenimento, uscita trend
- Commenti dinamici
- Nessun grafico o allegato

### 📊 Report Settimanale (HTML)
📄 Specifiche: [weekly_report_spec.md](weekly_report_spec.md)

- Contesto macroeconomico (BCOM, S&P500, VIX)
- Settori: ranking e variazioni
- Commodity attive: dettaglio con grafici, notizie, commenti
- Max 3 link verificati per commodity
- 🔗 Esempi: [file_esempi.md](file_esempi.md)

---

## 🧠 Commenti Automatici

📄 Template commenti: [templates.md](templates.md)

- Sistema di template dinamici
- Priorità e condizioni
- Espandibili nel tempo
- Usati sia nelle email che nei report

---

## 🔐 Linee Guida per l’IA

📄 [IA_guidelines.md](IA_guidelines.md)

- Evitare allucinazioni
- Usare solo dati, soglie e template approvati
- Nessuna previsione o interpretazione autonoma
- Struttura deterministica, spiegabile e verificabile

---

## 👤 Guida Operativa

📘 [OPERATOR_GUIDE.md](OPERATOR_GUIDE.md)

- Come leggere email e report
- Dove verificare notizie e prezzi
- Validazioni manuali e alert

---

## 🗄️ Struttura Database

- `commodity_config`: soglie, indici, stato attivo
- `commodity_prices`: prezzi, media mobile, benchmark
- `commodity_status`: stato attuale, giorni in trend
- `trend_history`: storico completo trend
- `alerts`: log alert entrata/uscita

---

## 📌 Prerequisiti

- Yahoo Finance Wrapper/API
- Connettività SMTP per invio email
- Libreria grafica compatibile con .NET (ChartJS, SVG)
- Logging e fallback su database

---

## 🚀 Estensioni Future

- Dashboard web interattiva
- AI per generazione commenti (fase 2)
- Calcolo dinamico soglie in base a volatilità
- Notifiche Telegram / Push

---

## 📁 File di Riferimento
- [README.md](README.md)
- [ARCHITECTURE.md](ARCHITECTURE.md)
- [templates.md](templates.md)
- [weekly_report_spec.md](weekly_report_spec.md)
- [daily_report_spec.md](daily_report_spec.md)
- [file_esempi.md](file_esempi.md)
- [IA_guidelines.md](IA_guidelines.md)
- [commodity_config_defaults.md](commodity_config_defaults.md)
- [OPERATOR_GUIDE.md](OPERATOR_GUIDE.md)