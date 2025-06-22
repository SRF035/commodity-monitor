# 📄 Template Commenti Automatici – Sistema Trend Commodity

Questo file contiene l'elenco dei **template di commenti** utilizzabili dal sistema per generare messaggi automatici nei report e negli alert email. Ogni template ha una **categoria**, una **priorità dinamica** e condizioni di attivazione.

---

## 🧠 Linee Guida

- I template sono **espandibili** e **modificabili** facilmente: si possono aggiungere nuove righe nella tabella sottostante o aggiornare testo e condizioni.
- Ogni categoria contiene un insieme di messaggi adatti a diverse fasi del trend: **entrata, mantenimento, uscita**.
- Il sistema sceglie il **template con priorità più alta** (valore numerico maggiore) tra quelli le cui condizioni sono soddisfatte.

---

## 📋 Struttura Template

| Categoria     | Priorità | Template                                                                                 | Condizioni                                                                          |
|---------------|----------|----------------------------------------------------------------------------------------- |-------------------------------------------------------------------------------------|
| Entrata       | 100      | 🚀 [Commodity] ha superato la soglia rispetto alla [Fonte] ed è entrata in trend.       | Almeno uno scostamento > soglia, trend non attivo ieri                             |
| Entrata       | 80       | 📈 Nuovo trend attivo su [Commodity] grazie alla variazione rispetto a [Fonte].         | Primo giorno in trend                                                               |
| Mantenimento  | 70       | 📊 [Commodity] mantiene un trend attivo da [X] giorni consecutivi.                      | Trend attivo da più di 1 giorno                                                     |
| Mantenimento  | 60       | 🔄 Il trend di [Commodity] prosegue: spread positivo e scostamenti ancora sopra soglia. | Tutti gli scostamenti >= soglia                                                     |
| Mantenimento  | 50       | 📈 [Commodity] resta in trend con performance coerente sul benchmark.                   | Scostamento MA30 ancora valido, altri rientrati                                    |
| Uscita        | 90       | 🛑 Il trend di [Commodity] è terminato: tutti gli scostamenti sono rientrati.           | Tutti gli scostamenti < soglia                                                      |
| Uscita        | 70       | 📉 Trend concluso per [Commodity], spread sotto soglia e normalizzazione in corso.      | Spread < soglia e MA30 < soglia                                                     |

---

## 🛠️ Campi Variabili

I campi seguenti saranno **sostituiti dinamicamente** dal sistema:
- `[Commodity]`: nome della materia prima
- `[Fonte]`: fonte dello scostamento prevalente (es. MA30, Settore, Globale)
- `[X]`: numero di giorni consecutivi in trend

---

## 📌 Note Tecniche

- Ogni template è associato a una categoria logica.
- I commenti vengono generati in automatico **al momento della creazione dell’email o del report**.
- In caso di più template attivabili, viene scelto quello con la **priorità più alta**.
- In futuro è possibile salvare i template in una tabella database (`comment_templates`) per gestione da dashboard o script.

---

## ✅ Espandibilità

Per aggiungere un nuovo template:
1. Inserire una riga nella tabella rispettando formato e priorità.
2. Includere condizioni precise per l’attivazione.
3. Assicurarsi che la logica di selezione consideri il nuovo caso.