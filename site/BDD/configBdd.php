<?php

/**
 * Fichier de configuration de la base de données (SQLite)
 */
$_ENV["dsn"] = "sqlite:" . realpath(__DIR__ . "/../../database") . "/oceane.db"; // chemin vers la base SQLite
$_ENV["username"] = null;
$_ENV["password"] = null;
$_ENV["options"]  = [];
