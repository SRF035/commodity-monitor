# 🏗️ Architettura

## Flusso dati
1. Scheduler avvia job
2. Fetch dati Yahoo
3. Calcolo scostamenti
4. Salvataggio DB
5. Invio alert/report

## Moduli
- Fetcher
- Calcolatore scostamenti
- Gestore stato trend
- Email sender
- Report HTML