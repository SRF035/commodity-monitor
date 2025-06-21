# 📈 Sistema di Monitoraggio e Analisi delle Materie Prime

## 🎯 Obiettivo

Monitorare giornalmente una selezione di materie prime per identificare l'inizio e la fine di trend direzionali, basandosi su scostamenti rispetto a benchmark, indici settoriali e un indice globale.

---

## ⚙️ Architettura Tecnica

- **Linguaggio**: C# (.NET 8)
- **Database**: PostgreSQL
- **Fonte Dati**: Yahoo Finance
- **Frequenza**: Giornaliera (prezzi e benchmark)
- **Formati Output**:
  - Email giornaliera (testo)
  - Report settimanale (HTML con grafici e news)
- **Report settimanale generato ogni**: Sabato mattina

---

## 🔢 Logica dei Calcoli

### 🔍 Scostamenti monitorati:
1. Media mobile 30 giorni (benchmark primario)
2. Indice settoriale (es. S&P GSCI)
3. Indice globale: Bloomberg Commodity Index (BCOM)

### 📐 Formula Scostamento:
```
Scostamento = ((Prezzo Attuale - Valore Benchmark) / Valore Benchmark) * 100
```

---

## 🚦 Logica di Attivazione/Disattivazione Trend

### ✅ Entrata in Trend
Un trend si attiva quando **almeno uno** dei tre scostamenti supera la soglia.

### ❌ Uscita dal Trend
Il trend termina quando **tutti e tre** i valori rientrano sotto soglia.

### 🧠 Stato Trend Tracciato:
- Data inizio trend
- Data uscita
- Giorni in trend
- Tipo di attivazione
- Spread massimo registrato

---

## 📨 Notifiche

### 📧 Email giornaliera (solo testo)
- Commodity entrate/uscite dal trend
- Stato corrente
- Nessun allegato

### 📊 Report settimanale (HTML)
- Generato sabato mattina
- Contiene:
  - Contesto macro
  - Contesto settoriale
  - Dettaglio per ogni commodity attiva

---

## 📊 Report Settimanale – Struttura

### 🔵 Contesto Macroeconomico
- Andamento settimanale:
  - Bloomberg Commodity Index (BCOM)
  - S&P 500
  - VIX
  - US10Y
- Link a fonti di verifica (Yahoo Finance, Investing.com)
- Commento automatico (testuale)

### 🟠 Contesto Settoriale
- Performance settimanale dei macro-settori
- Grafico a barre (ranking settoriale)
- Commodity leader per settore
- Commento automatico

### 🟢 Focus su Commodity Attive
Per ogni commodity “in trend”:
- Nome, simbolo, giorni attivi
- Grafico linea: prezzo vs media mobile
- Scostamenti vs benchmark, settore, globale
- Ultimo alert generato
- Notizie principali (fino a 3) con fonte
- Commento automatico (vedi appendice)

---

## 🧠 Appendice: Commenti Automatici – Template a Regole

Il sistema utilizza una lista ordinata di **template dinamici**, selezionati in base a priorità e condizioni attive.

### 📥 Entrata in Trend
[template table omessa per brevità]

### 🔁 Mantenimento del Trend
[template table omessa per brevità]

### 📤 Uscita dal Trend
[template table omessa per brevità]

---

## 🗃️ Struttura Database (PostgreSQL)
[descrizione delle tabelle omessa per brevità]

---

## 🧭 Linee guida per intelligenza artificiale o sviluppatore

### ✅ Cosa deve fare
[lista omessa per brevità]

### ❌ Cosa NON deve fare
[lista omessa per brevità]

### 🛡️ Obiettivo
[descrizione omessa per brevità]