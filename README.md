# POC back-office de la Compagnie Océane
(TP PHP SIO1 SLAM semestre 2)

## Environnement technique

Ce dépôt est configuré pour être ouvert dans un Codespace ou un Dev Container VS Code. Le Dockerfile installe les dépendances nécessaires (PHP, extensions, outils). La base de données utilisée est **SQLite** (fichier `database/oceane.db`).

## Arborescence du dépôt

Voici l'arborescence du dépôt et le rôle des différents composants :

├── .devcontainer/ # config du Dev Container
|  ├── devcontainer.json # extensions VS Code et paramètres du conteneur
|  └── Dockerfile # image du Dev Container
├── .github/ # config pour les alertes de dépendances (sécurité)
├── .vscode/ # config XDebug et paramètres VS Code locaux
├── database/ # base de données SQLite
|  └── oceane.db # fichier de la base SQLite (créé automatiquement au 1er démarrage)
├── infra/ # infrastructure as code (Azure Bicep)
|  └── main.bicep # déploiement Azure
├── site/ # dossier racine du serveur web PHP
├── composer.json # dépendances PHP (Composer)
├── start.sh # démarre le serveur PHP (port 8000) et initialise la BDD si besoin
└── stop.sh # arrête le serveur PHP

## Configuration et lancement de l'application

Ce dépôt est configuré pour fonctionner avec les Codespaces de GitHub et les Dev Containers de Visual Studio Code. Suivez les étapes ci-dessous pour lancer les services.

### Serveur PHP et base de données SQLite

1. **Pour lancer les services** :
   - Dans le terminal, exécutez le script `start.sh` :
     ```bash
     ./start.sh
     ```
   Ce script démarre le serveur PHP intégré sur le port 8000. Si le fichier `database/oceane.db` n'existe pas encore, il initialise automatiquement la base SQLite.

2. **Ouvrir l'application dans un navigateur** :
   - Accédez à `http://localhost:8000`.

3. **Accéder à la BDD** :
   - En client graphique avec l'extension **SQLite Viewer** dans le Dev Container (ouvrir `database/oceane.db`).

4. **Arrêter les services** :
   ```bash
   ./stop.sh
   ```

> ℹ️ **Problèmes de droits sur les scripts**
> Si les scripts ne s'exécutent pas :
> ```bash
> sudo chmod +x *.sh
> ```


## Utilisation de XDebug

Ce Codespace contient XDebug pour le débogage PHP. 

1. **Exemple de déboguage avec Visual Studio Code** :
   - Ouvrez le panneau de débogage en cliquant sur l'icône de débogage dans la barre latérale ou en utilisant le raccourci clavier `Ctrl+Shift+D`.
   - Sélectionnez la configuration "Listen for XDebug" et cliquez sur le bouton de lancement (icône de lecture).
   - Ouvrez un fichier php
   - Ajouter un point d'arrêt.
   - Solicitez dans le navigateur une page qui appelle le traitement
   - Une fois le point d'arrêt atteint, essayez de survoler les variables, d'examiner les variables locales, etc.

[Tuto Grafikart : Xdebug, l'exécution pas à pas ](https://grafikart.fr/tutoriels/xdebug-breakpoint-834)

