# 📈 Sistema di Monitoraggio Trend delle Materie Prime

Questo progetto ha l'obiettivo di monitorare giornalmente una selezione di materie prime per rilevare segnali di inizio o fine trend.  
Utilizza dati da Yahoo Finance e confronta il prezzo attuale delle commodity con:

- 📊 Media mobile a 30 giorni (MA30)
- 📉 Indice settoriale di riferimento (es. Energia, Metalli)
- 🌍 Indice globale Bloomberg Commodity Index (BCOM)

### 📌 Output del sistema

- Email giornaliera di alert testuale
- Report settimanale in HTML con:
  - Analisi macroeconomica
  - Tendenze settoriali
  - Dettagli per ciascuna commodity
  - Notizie rilevanti e commenti automatici

### 🔧 Tecnologie
- .NET 8 (C#)
- PostgreSQL
- Yahoo Finance (API o wrapper)
- HTML (per reportistica)
- Integrazione email SMTP

### 📁 Documentazione disponibile
La documentazione completa si trova nella cartella `/docs/` e include:

- SPECIFICA.md (requisiti completi)
- ROADMAP.md (fasi di sviluppo)
- templates.md (commenti automatici)
- IA_guidelines.md (regole per IA e sicurezza)

> Progetto pensato per essere modulare, spiegabile e facilmente estendibile con AI in una seconda fase.

---

## ⚠️ Stato attuale: fase di avvio

I moduli verranno generati e integrati gradualmente. Questo repository verrà usato anche come base per interazione con un assistente AI (Claude).