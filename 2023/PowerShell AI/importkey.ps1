# If you already have the key saved in secret store just run this to get the current Powershell line to import the PowershellAI module and prompt for the password for the OpenAI key
Import-Module PowershellAI
Set-OpenAIKey -Key (Get-Secret -Name MyOpenAIKey -Vault Microsoft.PowerShell.SecretStore)