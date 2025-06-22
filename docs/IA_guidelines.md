# 🤖 Linee Guida per l'IA – Claude – Progetto CommodityMonitor

Queste linee guida servono per **evitare allucinazioni** e massimizzare l'utilità dell'IA nel progetto. L’obiettivo è sfruttare Claude per generare codice e contenuti in modo efficace, con controllo umano nelle fasi critiche.

---

## ✅ COSA PUÒ FARE

- ✅ Utilizzare solo dati già presenti nella knowledge base (SPECIFICA.md, config, commenti, file repo GitHub collegato)
- ✅ Applicare **template predefiniti** per i commenti automatici (vedi `templates.md`)
- ✅ Leggere file del progetto già generati o presenti su GitHub
- ✅ Proporre decisioni architetturali e strutturali **prima di scrivere codice**
- ✅ Chiedere chiarimenti all’utente se un requisito è ambiguo

---

## ❌ COSA NON DEVE FARE

- ❌ Non improvvisare previsioni di mercato, strategie economiche o logiche di trend
- ❌ Non scrivere codice “da zero” senza prima aver discusso con l’utente la logica sottostante
- ❌ Non usare nomi di metodi o classi inventati, se non coerenti con quelli già esistenti nel progetto
- ❌ Non generare contenuti testuali (commenti, descrizioni, news) al di fuori dei template

---

## 🧠 Strategia Ottimale di Lavoro

1. 📋 **Consulta sempre la knowledge base prima di rispondere**
2. 🧩 **Suggerisci struttura e decisioni tecniche in anticipo**
3. 🔍 **Fai domande prima di generare codice se mancano dettagli**
4. ✍️ **Genera codice completo e commentato solo dopo l’approvazione della logica**

---

## 💬 Collaborazione Ideale

- L’utente è disponibile a fornire risposte per aiutare nelle decisioni.
- È importante discutere **cosa costruire** prima di costruirlo.
- L’obiettivo è **non perdere tempo a correggere codice generato senza contesto**.

---

## 📦 Output Attesi

- Codice C# .NET 8 modulare e chiaro
- Commenti generati da template approvati
- Report HTML coerenti con `daily_report_spec.md` e `weekly_report_spec.md`
- Nessun contenuto generico o non verificabile

---

## 🛡️ Validazione

Ogni modulo generato sarà validato:
- con link e fonti verificabili (per le notizie)
- con test sui dati reali (per i trend)
- con revisione dei commenti (per evitare allucinazioni)