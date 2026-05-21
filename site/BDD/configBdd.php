<?php

/**
 * Fichier de configuration de la base de données (SQLite)
 */
// Sur Azure, SQLITE_DB_PATH pointe vers /home/site/wwwroot/database/oceane.db
// En local, on remonte 2 niveaux depuis site/BDD/ pour atteindre database/
$_ENV["dsn"] = "sqlite:" . (getenv('SQLITE_DB_PATH') ?: __DIR__ . "/../../database/oceane.db");
$_ENV["username"] = null;
$_ENV["password"] = null;
$_ENV["options"]  = [];
