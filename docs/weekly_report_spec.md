# 📊 Specifiche Report Settimanale – CommodityMonitor

Il report settimanale fornisce una **visione macro-strutturale** dello stato del mondo attraverso l'analisi delle materie prime, dei settori e dei trend globali.

## 📆 Frequenza
- Ogni sabato mattina

## 🎯 Obiettivo
Offrire un quadro strategico utile a:
- Verificare il contesto globale
- Identificare trend emergenti settoriali
- Convalidare o confutare gli alert tramite notizie

## 🧱 Struttura del Report HTML

### 1. 🌍 Contesto Macro
- Indice BCOM (andamento settimanale, grafico)
- S&P500, VIX (andamento settimanale, grafico)
- Mini-commento automatico
- Link a 3 notizie economiche globali affidabili (Bloomberg, Reuters, WSJ, ecc.)

### 2. 🏭 Contesto Settoriale
- Classifica dei settori per performance aggregata (ranking)
- Variazione media dei benchmark settoriali
- Commento sintetico sul settore dominante
- Link a max 3 notizie di settore significative

### 3. 📦 Dettaglio per Commodity
Per ogni commodity **attualmente in trend**:
- Nome
- Giorni consecutivi in trend
- Scostamenti e spread (tabella)
- Commento automatico selezionato
- Fino a **3 link a notizie specifiche** su quella commodity

### 4. 📉 Uscite rilevanti della settimana
- Commodity uscite dal trend negli ultimi 7 giorni
- Motivo uscita
- Variazione prezzo settimanale

## 🛠️ Requisiti Tecnici
- Report generato in HTML
- Compilato dal modulo `WeeklyReportGenerator`
- Include dati da DB + fonti notizie (RSS o API)
- Grafici generati via libreria .NET (es. ChartJS, SVG, o altro)

## 🔐 Anti-allucinazione
- Ogni commento deve provenire da `templates.md`
- Ogni notizia deve avere link cliccabile
- Niente previsioni autonome: solo descrizione dello stato attuale

## ✅ Output
- File HTML salvato in `/reports/YYYY-MM-DD-weekly.html`
- Copia inviata via email