# ⚙️ Configurazioni Predefinite Commodity

Queste configurazioni sono predefinite ma **devono essere configurabili per ciascuna commodity** tramite database o file di configurazione.

| Commodity | Soglia (%) | Settore    | Benchmark Primario | Indice Settoriale (Ticker) | Indice Globale (Ticker) |
|-----------|------------|------------|---------------------|-----------------------------|--------------------------|
| Rame      | 3.5        | Metalli    | Media Mobile 30gg   | DBB (Invesco Base Metals)   | BCOM                     |
| Argento   | 3.0        | Metalli    | Media Mobile 30gg   | SLV (iShares Silver Trust)  | BCOM                     |
| Palladio  | 4.0        | Metalli    | Media Mobile 30gg   | PALL (Aberdeen Palladium)   | BCOM                     |
| Uranio    | 6.0        | Energia    | Media Mobile 30gg   | URA (Global X Uranium ETF)  | BCOM                     |
| Platino   | 3.5        | Metalli    | Media Mobile 30gg   | PPLT (Aberdeen Platinum)    | BCOM                     |
| Soia      | 3.0        | Agricolo   | Media Mobile 30gg   | SOYB (Teucrium Soybean)     | BCOM                     |
| Caffè     | 4.5        | Agricolo   | Media Mobile 30gg   | JO (iPath Coffee ETN)       | BCOM                     |

## 📌 Note

- La **"Soglia (%)"** è il valore oltre il quale lo scostamento genera un alert di ingresso in trend.
- Il **Benchmark Primario** è la **Media Mobile a 30 giorni** del prezzo della commodity.
- Gli **Indici Settoriali** e **Globali** sono utilizzati per confronto secondario e validazione del trend.
- L’**alert di ingresso** scatta quando **almeno uno** degli scostamenti (vs MA30, indice settoriale, indice globale) supera la soglia.
- L’**uscita dal trend** si verifica quando **tutti e tre** gli scostamenti tornano **al di sotto** della soglia.
- Questi valori possono essere modificati nel tempo e devono essere **gestibili dinamicamente** a livello di sistema.