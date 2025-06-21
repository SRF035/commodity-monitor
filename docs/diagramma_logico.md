# 📊 Diagramma Logico del Sistema

```
Utente
  │
  ▼
Email giornaliera <------┐
  ▲                      │
  │                      │
Report settimanale       │
  ▲                      │
  │                      │
Trend Analyzer <---------┐
  ▲                      │
  │                      │
Scostamento Calculator   │
  ▲                      │
  │                      │
Dati da Yahoo Finance ──►│
  ▲                      │
  │                      │
Scheduler (giornaliero/settimanale)
```