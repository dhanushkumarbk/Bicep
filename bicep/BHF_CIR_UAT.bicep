@description('Action rule name')
param actionRuleName string

@description('Target subscription ID')
param targetSubscriptionId string

@description('Target resource group name')
param targetResourceGroupName string

@description('Target resource type')
param targetResourceType string

@description('Enable or disable action rule')
param enabled bool = true

@description('Action rule description')
param description string

resource actionRule 'Microsoft.AlertsManagement/actionRules@2021-08-08' = {
  name: actionRuleName
  location: 'Global'
  tags: {
    _deployed_by_amba: 'true'
  }
  properties: {
    scopes: [
      '/subscriptions/${targetSubscriptionId}'
    ]
    conditions: [
      {
        field: 'TargetResourceGroup'
        operator: 'Equals'
        values: [
          '/subscriptions/${targetSubscriptionId}/resourceGroups/${targetResourceGroupName}'
        ]
      }
      {
        field: 'TargetResourceType'
        operator: 'Equals'
        values: [
          targetResourceType
        ]
      }
    ]
    enabled: enabled
    actions: [
      {
        actionType: 'RemoveAllActionGroups'
      }
    ]
    description: description
  }
}