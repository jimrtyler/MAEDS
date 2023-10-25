Import-Module Microsoft.Powershell.SecretStore
# Set the variable from PREVIOUSLY CREATED PLAINTEXT FILE, can replace the Get-Content with your key in plaintext or make it prompt
$SecretKey = Get-Content -Path .\APIKeys.txt
# Register the Secret Vault
Register-SecretVault -ModuleName Microsoft.PowerShell.SecretStore
# Set the secret using a friendly name and a password that will be needed to get the secret
Set-Secret -Name MyOpenAIKey -Secret $SecretKey -Vault Microsoft.PowerShell.SecretStore
# Retrieve the secret - it will prompt for a password
Get-Secret -Name MyOpenAIKey -Vault Microsoft.PowerShell.SecretStore
# set the API Key
Set-OpenAIKey -Key (Get-Secret -Name MyOpenAIKey -Vault Microsoft.PowerShell.SecretStore)