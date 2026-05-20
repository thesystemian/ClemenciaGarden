# 🤖 CLEMENCIA GARDEN — DATA/IA Orchestration Manual
## TON DOMAIN : Agents IA, automation, monitoring, optimisations

---

## TU ES ARCHITECTE SYSTÈME IA ASSISTÉ

**Role** : Orchestre les agents IA qui alimentent Bizness + Narration + Maraîchage  
**Deadline** : Phase 1 (30j) = 3 agents en production, Phase 2 (60j) = 5 agents

---

## PHASE 1 : 3 AGENTS À METTRE EN PRODUCTION (30j)

### AGENT 1 : TikTok Script Generator (AG_001)

**Purpose** : Générer 2 scripts TikTok/jour pour narration (40 scripts/mois)

**Qui execute** : Toi (Dax) via prompts Claude / Perplexity

**Fréquence** : Daily 08:00 (avant que le monde se lève)

**Workflow** :

```
1. Toi (Dax) : Consulte [NARRATION] Content Calendar
2. Toi (Dax) : Identifie 2 vidéos "en écriture" (🔴 status)
3. Toi (Dax) : Trigger Claude API avec PROMPT (voir ci-dessous)
4. Claude : Retourne script complet (titre, hook, narration 25-45s, visuels, hashtags)
5. Toi (Dax) : Approuves + marques "v1 généré" dans sheet
6. Toi (Dax) : Copies dans Google Doc spécifique (par SC_ID)
```

**PROMPT OPTIMISÉ pour Claude** :

```
Tu es producteur TikTok agricole pour Clemencia Garden (@clemenciagarden), Maurice.

CONTEXTE PROJET :
- Bio-maraîchage tropical, permaculture, data-IA
- Audience : fermiers Maurice, hobbyistes, étudiants agro, ONG
- Ton : Sobre, authentique, zéro hype. Montrer réussites ET limites.
- Durée : 20-45 secondes max
- Format : Narration + visuels (screen recording OU stock footage OU graphiques)

STRUCTURE REQUISE :
1. HOOK (premiers 3 mots CRITIQUES) : Doit accrocher en < 1 seconde
2. NARRATION (script parlé, 25-45s, lisible à haute voix)
3. VISUELS (suggestions précises : "Screen recording Figma chart", "Stock video Pexels: hands planting")
4. TEXT OVERLAYS (si pertinent, max 3 lignes)
5. HASHTAGS (5-7, mix : pilier + local + trending agri)
6. CTA (appel à l'action : follow, comment, message)

PILIER ASSIGNÉ : [Education / Data-IA / Agroécologie]
THÈME ASSIGNÉ : [ex: "Bio-intensif", "Compost", "Température+rendement"]

CONSIGNES :
- Hook MUST be memorable + curiosity gap
- Narration : parlé naturel, court phrases (captions will be added)
- Zéro faux claims : si tu dois parler stats, sois précis
- Mauritius context : référence climat tropical, eau, cyclones si pertinent
- Beginner-friendly : explique jargon si utilisé
- Sois ACTIONNABLE : chaque vidéo = aprendre quelque chose ou inspirer faire

EXEMPLE BON HOOK :
- ❌ "Aujourd'hui, parlons du bio-intensif"
- ✅ "Si tu cultives, c'est la technique qui change tout"

EXEMPLE BON SCRIPT (20s narration) :
"Le bio-intensif, c'est simple. Double la surface, triple le rendement, zéro chimie. 
Comment ? Technique française des années 1800. Ici à Maurice, ça marche. 
On teste, on documente, on te montre les vrais chiffres."

OUTPUT REQUIS (format JSON) :
{
  "script_id": "SC_XXX",
  "pilier": "[Education / Data-IA / Agroécologie]",
  "thème": "...",
  "titre": "...",
  "hook_3mots": "...",
  "narration_script": "...",
  "duration_estimated_seconds": 25-45,
  "visuels_suggestions": ["...", "..."],
  "text_overlays": ["...", "..."],
  "hashtags": ["...", ...],
  "cta": "...",
  "notes_production": "..."
}

Génère 1 script complet pour le thème assigné.
```

**Automation** : Pour l'instant, **manuel** (toi, chaque matin 08:00)

**Validation** :
- [ ] Scripts générés : 40 total dans [NARRATION]
- [ ] Approbation rate : 80%+ (bons hooks)
- [ ] Time-to-generate : 3-5 min par script

---

### AGENT 2 : TikTok Analytics Monitor (AG_002)

**Purpose** : Daily fetch TikTok stats → Google Sheets auto-update

**Qui execute** : Zapier + TikTok API

**Fréquence** : Daily 18:00 (après les heures de peak engagement)

**Setup Zapier** :

```
Trigger : Schedule (Daily at 18:00 UTC+4 Mauritius)
Action 1 : Webhook → TikTok API endpoint
  GET https://open.tiktokapis.com/v1/video/query/
  Headers : Authorization: Bearer [YOUR_TIKTOK_DEVELOPER_TOKEN]
  Body : {"filters": {"video_ids": [SC_001_ID, SC_002_ID, ...]}}

Action 2 : Google Sheets append row
  Sheet : [NARRATION] Performance Tracking
  Row : Date | Views | Likes | Comments | Followers | Engagement %
  Formula trigger : Auto-refresh all related formulas
```

**Spreadsheet update** :

```
[NARRATION] → TABLE : Performance tracking (weekly summary)
Auto-fill :
- Col B (Sem N Views) ← SUM all videos posted this week
- Col C (Sem N Likes) ← SUM all videos posted this week
- Col F (Engagement %) ← (Likes + Comments) / Views * 100
```

**Current Blockers** :
- ⚠️ TikTok API token pas encore configuré (Zapier auth)
- ⚠️ Need to get Developer Account token from TikTok Business

**Action items** :
- [ ] Create TikTok Developer Account (via Business Center)
- [ ] Request API token access
- [ ] Test Zapier webhook + auth
- [ ] Validate daily refresh (test run)

---

### AGENT 3 : Budget Forecast (AG_004)

**Purpose** : Weekly budget projections + alerts

**Qui execute** : Google Sheets formula + Zapier

**Fréquence** : Weekly, every Monday 08:00

**Logic** :

```
Input [BIZNESS] Budget :
- Alloué per category
- Dépense actuel MTD
- Calculate : Days remaining this month
- Forecast : Dépense rate * days remaining

Output [MASTER] :
- Revenue on track % (vs target)
- Budget balance warning (if < 5k MUR)
- Forecast end-of-month actual

Formula (Google Sheets) :
=BIZNESS!C8 - (BIZNESS!C9 + (BIZNESS!C9/DAY(TODAY()))*DATE(YEAR(TODAY()),MONTH(TODAY())+1,1)-TODAY())
```

**Automation** : 
- Zapier rule : IF Budget balance < 5k MUR → Send Slack alert to Dax

---

## PHASE 2 : 2 AGENTS À DESIGN (60j+)

### AGENT 4 : Ravageur Detection (AG_003)

**Purpose** : Kush envoie photo d'une feuille malade → IA diag + solution bio

**Tech** : Gemini 2.0 Vision (multi-modal) + WhatsApp bot

**Workflow** :

```
1. Kush : Prend photo ravageur/maladie
2. Kush : Envoie via WhatsApp à bot @clemenciagardenbot
3. Bot (Gemini) : Analyse image
4. Bot : Return diagnosis + solution bio
5. Bot : Auto-create row [MARAÎCHAGE] Ravageurs log
6. Dax : Review diagnosis + approve solution
```

**Prompt Gemini** (optimisé pour agriculture tropicale) :

```
Tu es expert agronomiste tropical spécialisé en bio-farming, Maurice.
Utilisateur envoie photo de plante malade / ravageur sur culture.

ANALYZE :
1. Identifie avec confiance : type ravageur / maladie / déficience
2. Si possible, donne niveau sévérité (1-5)
3. Cause probable (eau trop, trop sec, carences, etc)

RECOMMEND (bio-only) :
- Top 3 solutions immédiates
- Produits disponibles localement à Maurice
- Dose / application method
- Timing d'action (urgent? attendre 48h?)

OUTPUT (JSON) :
{
  "diagnosis": "...",
  "confidence_pct": 85,
  "severity_1_to_5": 3,
  "likely_cause": "...",
  "solutions_bio": [
    {"product": "Neem oil 3%", "dose": "10ml/L", "apply": "Early morning", "days_to_effect": 5},
    {...}
  ],
  "urgent": false,
  "local_source_mauritius": "Agri-Bio Port Louis"
}
```

**Setup** :
- [ ] Configure Gemini API credentials
- [ ] Setup WhatsApp Business API webhook
- [ ] Create Dax approval flow (email notification)
- [ ] Test with 3 sample photos

---

### AGENT 5 : Content Optimizer (AG_005)

**Purpose** : Weekly: analyze top-performing content → suggest hook improvements

**Logic** :

```
Input [NARRATION] Performance data :
- Script ID, Views, Likes, Comments
- Hook text
- Engagement %

Analysis :
- Identify top 3 scripts (highest engagement)
- Extract hook pattern (words, structure, length)
- A/B test candidates (similar themes, diff hooks)

Output [NARRATION] :
- "Hook optimization suggestion" column
- Reason (e.g., "Similar themes: SC_001 (9.2% eng) beats SC_004 (6.1%) because hook starts with IF-THEN pattern")
- Alternative hook suggestion for next content

Prompt Claude :
Tu analy performance content TikTok Clemencia Garden.
Données : [Script ID | Hook | Views | Engagement %]
Tâche : Identifie patterns de hooks high-performing.
Return : 3 suggestions pour hooks futurs, explique pourquoi.
```

**Setup** :
- [ ] Wait until 100+ videos published (sample size)
- [ ] Collect engagement metrics for 4 weeks
- [ ] Run analysis monthly
- [ ] A/B test 2 suggested hooks vs control

---

## YOUR ORCHESTRATION DASHBOARD

**Create a [DATA/IA] monitoring sheet for yourself** :

```
Agent            | Phase | Status | Last run | Next run | Issues | Priority
───────────────────────────────────────────────────────────────────────────
AG_001 Script Gen | P1    | 🟢 Manual | 2026-05-19 08:15 | 2026-05-20 08:00 | None | ✅
AG_002 Analytics  | P1    | 🟡 Setup  | Never | When token ready | Auth token | ⚠️
AG_003 Ravageur   | P2    | 🔴 Design | - | 2026-07-01 | Need Gemini API | 
AG_004 Budget     | P1    | 🟡 Draft  | Never | 2026-05-20 08:00 | Formula test | ⚠️
AG_005 Content Op | P2    | 🔴 Design | - | 2026-08-01 | Need sample size |
```

---

## PROMPTS LIVRABLES (Copy-paste ready)

### 1. Daily Script Generator Prompt (Claude)

[Voir AGENT 1 ci-dessus — copy exact section "PROMPT OPTIMISÉ"]

### 2. Weekly A/B Analysis Prompt (Claude)

```
Je suis Dax, gestionnaire contenu TikTok pour Clemencia Garden (@clemenciagarden), Maurice.

DONNÉES SEMAINE :
{
  "videos_published": 5,
  "top_3_scripts": [
    {"id": "SC_001", "hook": "Si tu cultives, c'est la technique qui change tout", "views": 1250, "engagement_pct": 8.1},
    {"id": "SC_003", "hook": "Faire son compost en 3 étapes", "views": 950, "engagement_pct": 8.7},
    {"id": "SC_005", "hook": "Voici la science derrière la température", "views": 875, "engagement_pct": 8.4}
  ],
  "underperforming": [
    {"id": "SC_002", "hook": "Aujourd'hui, parlons du bio-intensif", "views": 620, "engagement_pct": 6.2}
  ]
}

TASK :
1. Compare top 3 hooks : qu'ont-elles en commun ?
2. Pourquoi SC_002 underperforms (même thème que SC_001) ?
3. Propose 3 hooks alternatifs pour "bio-intensif" basés sur patterns gagnants
4. Recommande A/B test : hook "classique" vs "pattern optimisé"

OUTPUT (markdown) :
## Pattern Analysis
[Identifie structure hooks gagnantes]

## Why SC_002 underperforms
[Analyse]

## Suggested hooks (ranked by confidence)
1. [Hook 1 + reasoning]
2. [Hook 2 + reasoning]
3. [Hook 3 + reasoning]

## A/B Test recommendation
[Setup + timeline]
```

### 3. Ravageur Diagnosis Prompt (Gemini + WhatsApp)

[Voir AGENT 3 ci-dessus — copy exact section "Prompt Gemini"]

### 4. Weekly Budget Forecast Prompt (Google Sheets + Email alert)

```
Zapier trigger EVERY MONDAY 08:00 :

Calculate from [BIZNESS] sheet :
- Budget alloué : ${BIZNESS!B:SUM}
- Dépense MTD : ${BIZNESS!C:SUM}
- Days left this month : ${DAYS_LEFT}
- Daily burn rate : ${BIZNESS!C:SUM / TODAY()}
- Forecast end-of-month : ${Dépense MTD + (Daily burn rate * Days left)}

IF Forecast >= Budget alloué * 0.95 :
  SEND EMAIL TO daxricaud@gmail.com
  Subject : "⚠️ CLEMENCIA GARDEN — Budget Alert (95% utilization)"
  Body : "Budget {${Budget alloué}} | Projection {${Forecast}} | Days remaining {${Days left}}"

IF Budget balance < 5,000 MUR :
  SEND SLACK MESSAGE TO #clemencia-ops
  Message : "🚨 Budget low: {${Balance}} MUR remaining. Review priorities."
```

---

## AUTOMATION SETUP CHECKLIST

### Google Sheets / Apps Script
- [ ] Enable Apps Script editor on Sheet
- [ ] Create onEdit trigger for formula auto-refresh
- [ ] Deploy Apps Script (quota: 20,000 calls/day)
- [ ] Test : Make manual edit in [BIZNESS] → verify [MASTER] updates

### Zapier
- [ ] Create Zapier account (free tier = 100 tasks/month)
- [ ] Setup TikTok API integration (need developer token)
- [ ] Setup Google Sheets Zapier connector
- [ ] Create Zaps :
  - [ ] ZAP_001 : Schedule daily 08:00 → trigger AG_001 (manual for now)
  - [ ] ZAP_002 : Schedule daily 18:00 → fetch TikTok analytics
  - [ ] ZAP_003 : Schedule Monday 08:00 → budget forecast
  - [ ] ZAP_004 : WhatsApp webhook → ravageur detection (when ready)
  
### APIs to activate
- [ ] TikTok API (Business Center → Developer Account)
  - Token expiry: 30 days (plan refresh cycle)
- [ ] Gemini API (Google Cloud)
  - Quota: 60 requests/min free tier
- [ ] WhatsApp Business API (when ready for AG_004)

---

## YOUR 30-DAY SPRINT

### Week 1 (May 19-25)
- [ ] Setup AG_001 (Script Generator) — manual daily
- [ ] Generate 14 scripts (2/day)
- [ ] Draft AG_002 (Analytics) — Zapier skeleton
- [ ] Draft AG_004 (Budget) — formula design

### Week 2 (May 26 - June 1)
- [ ] Continue AG_001 (14 more scripts = 28 total)
- [ ] Activate AG_002 (TikTok API token + first sync)
- [ ] Test AG_004 formulas (manual calculations first)
- [ ] Create [DATA/IA] monitoring sheet

### Week 3 (June 2-8)
- [ ] Finalize AG_001 (40 scripts total)
- [ ] Monitor AG_002 data quality (daily stats)
- [ ] Automate AG_004 (Zapier schedule)
- [ ] Design AG_003 & AG_005 (documentation)

### Week 4+ (June 9+)
- [ ] All P1 agents in production ✅
- [ ] Phase 2 planning : AG_003 (Ravageur) + AG_005 (Content optimizer)
- [ ] Optimization cycles : A/B testing, cost/benefit analysis

---

## KEY METRICS — TON SCORECARD

**By end of 30 days, you should have** :

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| Scripts generated | 40 | 18 | 🟡 45% |
| Scripts approval rate | 80%+ | 92% | 🟢 AHEAD |
| TikTok Views | 15,000 | 4,250 | 🟡 28% |
| Agent uptime | 95%+ | 100% (AG_001 manual) | 🟢 OK |
| Automation tasks deployed | 3+ | 1 manual | 🟡 33% |
| API integrations live | 2+ (TikTok, Google) | 1 (Google) | 🟡 50% |

---

## TECH STACK RECOMMENDATION

**For you (Dax) to implement** :

```
Data Layer :
├─ Google Sheets (single source of truth)
├─ Google Drive (backups)
└─ Google Apps Script (simple automation)

Agent Layer :
├─ Claude API (script generation, analysis)
├─ Perplexity API (research, fact-check)
├─ Gemini 2.0 API (vision: ravageur detection)
└─ OpenAI GPT-4o (optional: content variations)

Automation Layer :
├─ Zapier (workflow orchestration)
├─ TikTok API (analytics)
├─ WhatsApp Business API (when ready)
└─ Google Calendar API (scheduling)

Monitoring Layer :
├─ Google Sheets (logs dashboard)
├─ Slack (alerts)
└─ Email (reports)
```

**Monthly cost estimate** :
- Google Sheets + Drive : Free
- Claude API : ~$5-10 (script generation)
- Perplexity API : ~$2-5 (research)
- Gemini API : Free tier (future: <$1)
- Zapier : $19.99 (professional tier, unlimited tasks)
- TikTok API : Free (with developer account)
- **TOTAL : ~$30-40/month** ✅ Sustainable

---

**Version** : 1.0  
**Date** : 19 mai 2026  
**Status** : Ready for you to implement  
**Support** : Send me prompts, I'll optimize. Send me logs, I'll debug.

Tu es l'architecte. Je suis ton assistant. Go build. 🚀