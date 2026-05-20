#!/bin/bash
# 🌱 SETUP SCRIPT — Clemencia Garden avec Gemini CLI
# Usage: bash setup_clemencia_gemini.sh

set -e

# Configuration
PROJECT_DIR="$HOME/Clemenciagarden"
CONTEXT_FILE="$PROJECT_DIR/clemencia_context.txt"

echo "╔════════════════════════════════════════════════════════════╗"
echo "║   🌱 CLEMENCIA GARDEN — SETUP GEMINI CLI                  ║"
echo "║      Dossier : $PROJECT_DIR                               ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Créer structure dossiers
echo "📂 Création structure dossiers..."
mkdir -p "$PROJECT_DIR"/{01_System_Documentation,02_Data_Templates,03_Tools_Apps,04_Implementation_Guide,05_Ravageurs_Reference,06_Monthly_Dashboards,logs,output}

# Copier fichier contexte
echo "📋 Installation fichier contexte Gemini..."
if [ -f "/mnt/user-data/outputs/GEMINI_CONTEXT_PROMPT.md" ]; then
    cp /mnt/user-data/outputs/GEMINI_CONTEXT_PROMPT.md "$CONTEXT_FILE"
    echo "✓ Contexte copié : $CONTEXT_FILE"
else
    echo "⚠️  Fichier contexte non trouvé. À créer manuellement."
fi

# Copier tous les fichiers du projet
echo "📄 Copie fichiers projet..."
cp /mnt/user-data/outputs/CLEMENCIA_TRACKING_SYSTEM.md "$PROJECT_DIR/01_System_Documentation/" 2>/dev/null && echo "✓ System documentation"
cp /mnt/user-data/outputs/CLEMENCIA_SHEETS_TEMPLATE.csv "$PROJECT_DIR/02_Data_Templates/" 2>/dev/null && echo "✓ Sheets template"
cp /mnt/user-data/outputs/clemencia_farm_tracker_app.html "$PROJECT_DIR/03_Tools_Apps/" 2>/dev/null && echo "✓ App tracker"
cp /mnt/user-data/outputs/SEMAINE_1_IMPLEMENTATION.md "$PROJECT_DIR/04_Implementation_Guide/" 2>/dev/null && echo "✓ Implementation guide"

# Créer README racine
cat > "$PROJECT_DIR/README.md" << 'EOF'
# 🌱 Clemencia Garden — Gemini CLI Edition

**Système de suivi maraîchage + IA frugale pour Clemencia, Maurice**

## 📂 Structure
```
~/Clemenciagarden/
├── 01_System_Documentation/      ← Architecture système
├── 02_Data_Templates/             ← Google Sheets templates
├── 03_Tools_Apps/                 ← App web offline-first
├── 04_Implementation_Guide/       ← Semaine 1 checklist
├── 05_Ravageurs_Reference/        ← Fiches ravageurs
├── 06_Monthly_Dashboards/         ← Templates dataviz
├── logs/                           ← Historique requêtes Gemini
├── output/                         ← Résultats générés
├── clemencia_context.txt           ← Contexte Gemini (core)
└── README.md (ce fichier)
```

## 🚀 Utilisation rapide

### Setup initial (si pas fait)
```bash
cd ~/Clemenciagarden
bash setup_clemencia_gemini.sh
```

### Utiliser Gemini CLI avec contexte
```bash
# Format basique
gemini --context-file clemencia_context.txt "Ta question agriculture"

# Avec output vers fichier
gemini --context-file clemencia_context.txt "Question" > output/response_$(date +%Y%m%d_%H%M%S).md

# Requête spécifique culture
gemini --context-file clemencia_context.txt "Coriandre : comment gérer mouche blanche jour 3?"

# Requête système/données
gemini --context-file clemencia_context.txt "Créer formule Sheets pour suivre humidité moyenne mensuelle par planche"
```

## 📋 Cas d'usage courants

### Questions agriculture
```bash
gemini --context-file clemencia_context.txt "Ravageur détecté coriandre. Identification + plan action?"

gemini --context-file clemencia_context.txt "Irrigation carotte sans eau réseau. Solutions low-tech?"

gemini --context-file clemencia_context.txt "Papaye : anthracnose risque. Prévention bio?"
```

### Questions système/données
```bash
gemini --context-file clemencia_context.txt "Créer app tracker Sheets avec dropdown ravageurs + photos"

gemini --context-file clemencia_context.txt "Formules Sheets pour synthèse mensuelle (moyenne humidité, somme pluie, efficacité bio)"

gemini --context-file clemencia_context.txt "Export CSV app HTML → Google Sheets : workflow sync"
```

### Questions ravageurs spécifiques
```bash
gemini --context-file clemencia_context.txt "Mouche carotte : seuil alerte? Calendrier Clemencia? Filet specs?"

gemini --context-file clemencia_context.txt "Alternaria carotte : prévention post-récolte + stockage?"

gemini --context-file clemencia_context.txt "Pourriture capsule elaichi. Humidité critique? Solutions ventilation?"
```

## 📊 Fichiers contexte

- `clemencia_context.txt` : **Core** — données, ravageurs Maurice, Sheets structure, règles décision
- Utiliser pour TOUTES les requêtes liées Clemencia

## 📈 Workflow recommandé

### Jour 1 (Setup)
```bash
# Lire système complet
gemini --context-file clemencia_context.txt "Résumer architecture système : 4 couches, flux données, feedback loops"

# Setup Sheets
gemini --context-file clemencia_context.txt "Template exact Google Sheets 6 onglets : colonnes, types, formules pour Clemencia"
```

### Semaine 1 (Démarrage)
```bash
# Questions terrain
gemini --context-file clemencia_context.txt "Coriandre jour 0-30 : stades phéno, irrigation seuil, ravageurs attendus saison mai?"

# Validation données
gemini --context-file clemencia_context.txt "Données saisies semaine 1 : comment valider que tracking 'fait sens'?"

# Monitoring
gemini --context-file clemencia_context.txt "Première observation ravageur jour 3. Diagnostic + plan J0/J3/J6?"
```

### Mois 1-3 (Pattern recognition)
```bash
# Analyse données
gemini --context-file clemencia_context.txt "Données mois 1 (30 observations) : patterns irrigation, pics ravageurs, vélocité crop par culture?"

# Efficacité bio
gemini --context-file clemencia_context.txt "Mouche blanche : spray neem 3x. Efficacité observable (% avant/après)? Ajustements?"

# Rendement vs prévision
gemini --context-file clemencia_context.txt "Coriandre récolte jour 30 : kg réel vs attendu. Analyse écart. Données manquantes?"
```

### Saison 1 (Validation 90 jours)
```bash
# ROI calculation
gemini --context-file clemencia_context.txt "Coûts intrants (neem, soufre, semences) vs revenu récolte. Viabilité par culture?"

# Viabilité travail
gemini --context-file clemencia_context.txt "Heures travail cumulées par culture/tâche. Rentabilité €/heure? Optimisations?"

# Décisions année 2
gemini --context-file clemencia_context.txt "Données saison 1 : quelle variété garder? Dates semis ajustées? Surfaces à augmenter?"
```

## 🔧 Variables d'environnement

Ajouter à `~/.zshrc` ou `~/.bash_profile` pour faciliter :

```bash
# Alias Gemini Clemencia
alias cgarden="gemini --context-file ~/Clemenciagarden/clemencia_context.txt"

# Usage: cgarden "Ta question agriculture"
# Output: cgarden "Question" > output/response.md
```

Puis ajouter à bashrc/zshrc :
```bash
export CLEMENCIA_CONTEXT="$HOME/Clemenciagarden/clemencia_context.txt"
```

## 📞 Support

### Si Gemini demande clarifications
- Fournir données Clemencia (climat, dates, observables)
- Préciser quelle culture/planche
- Indiquer saison (mai = humide? Juillet = sec?)
- Donner contexte temps (jour 1? Mois 2?)

### Si réponse incomplète
- Re-poser avec plus de détail
- Ajouter "avec données/formules concrètes"
- Demander "adapté climat Maurice"

## 📝 Notes

- `clemencia_context.txt` peut être partagé avec Kush (read-only)
- Logs requêtes sauvegardés pour audit trail
- Outputs versionner (date + heure automatique)
- Contexte = point de référence unique (pas 3 sources)

---

**Clemencia Garden × Gemini CLI**  
Maraîchage bio tropical + système data frugal + apprentissage continu

---
EOF

# Créer alias Gemini dans bashrc/zshrc
echo ""
echo "⚙️  Configuration shell alias..."

for shell_rc in "$HOME/.zshrc" "$HOME/.bash_profile" "$HOME/.bashrc"; do
    if [ -f "$shell_rc" ]; then
        if ! grep -q "alias cgarden" "$shell_rc"; then
            cat >> "$shell_rc" << 'ALIAS'

# Clemencia Garden × Gemini
export CLEMENCIA_CONTEXT="$HOME/Clemenciagarden/clemencia_context.txt"
alias cgarden="gemini --context-file $CLEMENCIA_CONTEXT"
ALIAS
            echo "✓ Alias ajouté : $shell_rc"
        fi
    fi
done

# Créer script helper
cat > "$PROJECT_DIR/gemini_helper.sh" << 'HELPER'
#!/bin/bash
# Helper script pour requêtes Gemini courantes

CONTEXT="$HOME/Clemenciagarden/clemencia_context.txt"
OUTPUT_DIR="$HOME/Clemenciagarden/output"
LOGS="$HOME/Clemenciagarden/logs"

mkdir -p "$OUTPUT_DIR" "$LOGS"

# Fonction pour logger requête
log_request() {
    local query="$1"
    local timestamp=$(date +%Y%m%d_%H%M%S)
    echo "[$timestamp] $query" >> "$LOGS/requests.log"
}

# Fonction pour exécuter + sauvegarder
run_clemencia_query() {
    local query="$1"
    local timestamp=$(date +%Y%m%d_%H%M%S_%N)
    local output_file="$OUTPUT_DIR/response_${timestamp}.md"
    
    log_request "$query"
    
    echo "⏳ Executing: $query"
    gemini --context-file "$CONTEXT" "$query" > "$output_file"
    
    echo "✓ Saved to: $output_file"
    cat "$output_file"
}

# Utilisation
if [ $# -eq 0 ]; then
    echo "Usage: bash gemini_helper.sh \"Ta question agriculture\""
    echo ""
    echo "Exemples :"
    echo "  bash gemini_helper.sh \"Mouche blanche détectée coriandre jour 3\""
    echo "  bash gemini_helper.sh \"Créer app Sheets pour tracker 4 cultures\""
else
    run_clemencia_query "$@"
fi
HELPER

chmod +x "$PROJECT_DIR/gemini_helper.sh"
echo "✓ Helper script créé : $PROJECT_DIR/gemini_helper.sh"

# Vérifier Gemini CLI installed
echo ""
echo "🔍 Vérification Gemini CLI..."
if command -v gemini &> /dev/null; then
    GEMINI_VERSION=$(gemini --version 2>/dev/null || echo "Version inconnue")
    echo "✓ Gemini CLI détecté : $GEMINI_VERSION"
else
    echo "⚠️  Gemini CLI non trouvé. Installation :"
    echo "   macOS : brew install google-cloud-sdk"
    echo "   Ou : npm install -g @google-cloud/cli"
fi

# Résumé
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║     ✅ SETUP TERMINÉ — Clemencia Garden ready!             ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📂 Dossier projet : $PROJECT_DIR"
echo "📋 Contexte Gemini : $CONTEXT"
echo ""
echo "🚀 Commandes rapides :"
echo ""
echo "   # Via alias (si shell reloaded)"
echo "   cgarden \"Mouche blanche coriandre : plan action?\""
echo ""
echo "   # Via script helper"
echo "   bash $PROJECT_DIR/gemini_helper.sh \"Ta question\""
echo ""
echo "   # Directement"
echo "   gemini --context-file $CONTEXT \"Ta question\""
echo ""
echo "📚 Lire : $PROJECT_DIR/README.md"
echo ""
echo "🌱 Bon courage!"
echo ""
