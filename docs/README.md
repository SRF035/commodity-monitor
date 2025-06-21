# 📊 Commodity Trend Monitoring System

## 🧠 Overview

This project implements a structured system for monitoring commodities and identifying potential trend reversals or accelerations. It is designed to detect and report trend activity based on price deviations from benchmarks and indexes.

The goal is to support high-level macro and sector analysis and provide trading signals or monitoring insights.

---

## ⚙️ Technologies

- **Backend**: .NET 8 (C#)
- **Database**: PostgreSQL
- **Data Source**: Yahoo Finance
- **Reporting**: HTML weekly reports, daily email alerts

---

## 🧱 Project Structure

```
/src/              → C# services and logic
/db/               → PostgreSQL schema and seed data
/docs/             → Documentation and specifications
/reports/          → Generated HTML weekly reports
README.md          → Project overview
```

---

## 📈 Key Features

- Daily monitoring of selected commodities
- Detection of trend entries and exits
- Daily email alerts (summarized)
- Weekly HTML report with:
  - Macroeconomic analysis
  - Sector trends
  - Commodity-specific insights
  - News and commentary
- Comment templates with dynamic prioritization
- Deterministic, explainable system (no hallucinations)

---

## 📝 Documentation

All project documentation is available in the `/docs/` folder:

- `SPECIFICA.md`: complete project specification
- `ARCHITECTURE.md`: system structure and data flow
- `schema.sql`: PostgreSQL schema
- `templates.md`: automatic commentary templates
- `weekly_report_spec.md`: HTML report structure

---

## 🚀 Getting Started

1. Clone the repo
2. Set up PostgreSQL using `db/schema.sql`
3. Add your API integration for Yahoo Finance
4. Configure settings in `appsettings.json`
5. Run the daily and weekly jobs
6. Receive alerts and view reports

---

## ✅ Status

This is the planning and development phase. The system is modular and expandable, with clear separation of logic, reporting, and automation.

---

## 🔐 AI Safety & Guardrails

The system includes strict logic to avoid hallucinations:
- Uses deterministic rules
- Comment generation based only on templates and data
- Includes source links for verification
- Not designed for speculative narrative generation

For more details, see `IA_guidelines.md`.

---

## 🤝 License

MIT — free to use, modify, and distribute.