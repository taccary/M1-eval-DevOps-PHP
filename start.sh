#!/bin/bash
# script pour démarrer les serveurs PHP (SQLite — MariaDB non requis)

# Définir le chemin vers le dossier web
WEB_DIR="site"

# Initialiser la base SQLite si elle n'existe pas encore
if [ ! -f "database/oceane.db" ]; then
    echo "Initialisation de la base de données SQLite..."
    chmod +x ./database/scripts/initSQLite.sh
    ./database/scripts/initSQLite.sh
fi

# Fonction pour vérifier si un port est utilisé
is_port_in_use() {
    # Utilise lsof pour vérifier si le port spécifié est en cours d'utilisation
    lsof -i:$1 > /dev/null # teste si le port $1 est utilisé et redirige la sortie standard et la sortie d'erreur vers /dev/null 
    return $? # Retourne le code de sortie de la commande lsof -> 0 si le port est utilisé
}

# Démarrage du serveur PHP pour le dossier web
WEB_PORT=8000
if is_port_in_use $WEB_PORT; then
    echo "Le serveur PHP pour le dossier web est déjà démarré sur le port $WEB_PORT"
else
    echo "Démarrage du serveur PHP sur http://0.0.0.0:$WEB_PORT depuis $WEB_DIR"
    php -S 0.0.0.0:$WEB_PORT -t $WEB_DIR &
fi