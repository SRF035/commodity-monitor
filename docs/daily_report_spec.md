# 📄 Specifiche Report Giornaliero – CommodityMonitor

Il report giornaliero è inviato via email (testuale/HTML) e serve come **riepilogo operativo** degli alert generati per ciascuna commodity.

## 🎯 Obiettivo
Fornire un riepilogo semplice e diretto delle commodity:
- entrate in trend
- ancora attive
- uscite dal trend

## 📦 Contenuto

### Intestazione
- Data del giorno
- Oggetto: `Alert giornaliero – [Data]`

### Sezioni principali
- 📈 **Entrate in trend**
  - Nome commodity
  - Fonte dello scostamento (MA30, Settore, Globale)
  - Spread calcolato
  - Commento automatico
- 🔄 **Ancora in trend**
  - Nome
  - Giorni consecutivi
  - Scostamenti attuali
  - Commento
- 📉 **Uscite dal trend**
  - Nome
  - Motivo uscita (tutti scostamenti < soglia)
  - Spread attuale
  - Commento

## 🛠️ Struttura
Formato HTML minimale compatibile con SMTP:
- Tabelle o liste ordinate
- Nessuna immagine o grafico
- Testo leggibile anche in plain-text fallback

## 🔐 Note Tecniche
- Soglie lette da `commodity_config_defaults.md` o database
- Commenti scelti da `templates.md`
- I dati vengono recuperati dal modulo `TrendAnalyzer`