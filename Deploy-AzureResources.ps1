param(
    [Parameter(Mandatory=$true)]
    [string] $ResourceGroupName, 

    [Parameter(Mandatory=$true)]
    [string] $EnvironmentName
)

$ErrorActionPreference = "Stop"

$templateFile = "azuredeploy.json"
$parametersFile = "azuredeploy.parameters.json"

###
### Deploy environment Azure resources
### 

Write-Host ">>> Deploying ARM Template... "

$deploymentName = "deploy-$EnvironmentName";

$deploymentResult = New-AzResourceGroupDeployment `
    -Name $deploymentName `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $templateFile `
    -TemplateParameterFile $parametersFile `
    -Verbose `
    -ErrorAction "Continue"

if ($deploymentResult.ProvisioningState -ne "Succeeded") 
{
    $deploymentResult | Out-Host
    Write-Error "ARM deployment failed"
    exit 1
}

Write-Host ">>> Done!"