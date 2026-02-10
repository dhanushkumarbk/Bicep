@description('Name of the Action Rule')
param actionRuleName string

@description('Target Resource Group name where alerts originate')
param targetResourceGroupName string

@description('Target Resource Type for alert suppression')
param targetResourceType string

@description('Enable or disable the Action Rule')
param enabled bool = true

@description('Description for the Action Rule')
param actionRuleDescription string

resource actionRule 'Microsoft.AlertsManagement/actionRules@2021-08-08' = {
  name: actionRuleName
  location: 'Global'
  tags: {
    _deployed_by_amba: 'true'
  }
  properties: {
    scopes: [
      subscription().id
    ]
    conditions: [
      {
        field: 'TargetResourceGroup'
        operator: 'Equals'
        values: [
          '${subscription().id}/resourceGroups/${targetResourceGroupName}'
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
    description: actionRuleDescription
  }
}
