Import-Module Microsoft.Powershell.SecretStore
# Copy APIKeys.example.txt to APIKeys.txt and put your key in it. APIKeys.txt is
# listed in .gitignore so it stays on your machine. You can also swap the
# Get-Content below for your key inline, or make it prompt.
$SecretKey = Get-Content -Path .\APIKeys.txt
# Register the Secret Vault
Register-SecretVault -ModuleName Microsoft.PowerShell.SecretStore
# Set the secret using a friendly name and a password that will be needed to get the secret
Set-Secret -Name MyOpenAIKey -Secret $SecretKey -Vault Microsoft.PowerShell.SecretStore
# Retrieve the secret - it will prompt for a password
Get-Secret -Name MyOpenAIKey -Vault Microsoft.PowerShell.SecretStore
# set the API Key
Set-OpenAIKey -Key (Get-Secret -Name MyOpenAIKey -Vault Microsoft.PowerShell.SecretStore)