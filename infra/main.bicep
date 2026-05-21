@description('Nom de base du projet (utilise pour nommer les ressources)')
param projectName string = 'retrogamein'

@description('Region Azure')
param location string = resourceGroup().location

@description('SKU du plan App Service')
@allowed(['B1', 'B2', 'B3', 'S1', 'S2', 'P1v3'])
param appServiceSkuName string = 'B1'

@description('Version PHP pour App Service (ex: 8.3)')
param phpVersion string = '8.3'

// Variables
var appServicePlanName = '${projectName}-plan'
var webAppName         = '${projectName}-web'

// Plan App Service
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

// Web App (PHP + SQLite)
// La base oceane.db est deployee dans database/ au meme niveau que site/
// WEBSITE_DOCUMENT_ROOT indique a App Service de servir depuis le sous-dossier site/
resource webApp 'Microsoft.Web/sites@2023-01-01' = {
  name: webAppName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'PHP|${phpVersion}'
      appSettings: [
        {
          name: 'WEBSITE_DOCUMENT_ROOT'
          value: '/home/site/wwwroot/site'
        }
      ]
    }
    httpsOnly: true
  }
}

// Outputs
output webAppUrl  string = 'https://${webApp.properties.defaultHostName}'
output webAppName string = webApp.name
