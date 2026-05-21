@description('Nom de base du projet (utilisé pour nommer les ressources)')
param projectName string = 'retrogamein'

@description('Région Azure')
param location string = resourceGroup().location

@description('SKU du plan App Service')
@allowed(['B1', 'B2', 'B3', 'S1', 'S2', 'P1v3'])
param appServiceSkuName string = 'B1'

@description('Nom de l\'administrateur MySQL')
param mysqlAdminLogin string = 'adminretro'

@description('Mot de passe administrateur MySQL')
@secure()
param mysqlAdminPassword string

@description('Version PHP pour App Service (ex: 8.3)')
param phpVersion string = '8.3'

// ─── Variables ────────────────────────────────────────────────────────────────
var appServicePlanName = '${projectName}-plan'
var webAppName         = '${projectName}-web'
var mysqlServerName    = '${projectName}-mysql'
var mysqlDbName        = 'retrogamein'

// ─── Plan App Service ──────────────────────────────────────────────────────────
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: appServicePlanName
  location: location
  kind: 'linux'
  sku: {
    name: appServiceSkuName
  }
  properties: {
    reserved: true // obligatoire pour Linux
  }
}

// ─── Web App (conteneur PHP Apache) ───────────────────────────────────────────
resource webApp 'Microsoft.Web/sites@2023-01-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'PHP|${phpVersion}'
      appSettings: [
        {
          name: 'DB_HOST'
          value: '${mysqlServerName}.mysql.database.azure.com'
        }
        {
          name: 'DB_PORT'
          value: '3306'
        }
        {
          name: 'DB_NAME'
          value: mysqlDbName
        }
        {
          name: 'DB_USER'
          value: '${mysqlAdminLogin}@${mysqlServerName}'
        }
        {
          name: 'DB_PASSWORD'
          value: mysqlAdminPassword
        }
      ]
    }
    httpsOnly: true
  }
}

// ─── Azure Database for MySQL Flexible Server ──────────────────────────────────
resource mysqlServer 'Microsoft.DBforMySQL/flexibleServers@2023-06-30' = {
  name: mysqlServerName
  location: location
  sku: {
    name: 'Standard_B1ms'
    tier: 'Burstable'
  }
  properties: {
    administratorLogin: mysqlAdminLogin
    administratorLoginPassword: mysqlAdminPassword
    version: '5.7'
    storage: {
      storageSizeGB: 20
    }
    backup: {
      backupRetentionDays: 7
      geoRedundantBackup: 'Disabled'
    }
    highAvailability: {
      mode: 'Disabled'
    }
  }
}

// ─── Base de données ───────────────────────────────────────────────────────────
resource mysqlDatabase 'Microsoft.DBforMySQL/flexibleServers/databases@2023-06-30' = {
  parent: mysqlServer
  name: mysqlDbName
  properties: {
    charset: 'utf8mb4'
    collation: 'utf8mb4_unicode_ci'
  }
}

// ─── Règle firewall : autoriser les services Azure ─────────────────────────────
resource mysqlFirewallAllowAzure 'Microsoft.DBforMySQL/flexibleServers/firewallRules@2023-06-30' = {
  parent: mysqlServer
  name: 'AllowAzureServices'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

// ─── Outputs ───────────────────────────────────────────────────────────────────
output webAppUrl string = 'https://${webApp.properties.defaultHostName}'
output webAppName string = webApp.name
output mysqlFqdn string = mysqlServer.properties.fullyQualifiedDomainName
