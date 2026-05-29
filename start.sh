#!/bin/bash
# script pour démarrer le serveur PHP et la base de données SQLite

# Définir le chemin vers le dossier web
WEB_DIR="site"

# Initialiser la base SQLite si elle n'existe pas encore
if [ ! -f "database/oceane.db" ]; then
    echo "Initialisation de la base de données SQLite..."
    chmod +x ./database/scripts/initSQLite.sh
    ./database/scripts/initSQLite.sh
fi

# Démarrage du serveur PHP pour le dossier web
WEB_PORT=8000
if lsof -i:$WEB_PORT > /dev/null 2>&1; then
    echo "Le serveur PHP pour le dossier web est déjà démarré sur le port $WEB_PORT"
else
    echo "Démarrage du serveur PHP sur http://0.0.0.0:$WEB_PORT depuis $WEB_DIR"
    php -S 0.0.0.0:$WEB_PORT -t $WEB_DIR &
fi
