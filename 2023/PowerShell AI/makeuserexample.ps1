Import-Module PowershellAI
# REQUIRES GAM TO RUN
Set-OpenAIKey -Key (Get-Secret -Name MyOpenAIKey -Vault Microsoft.PowerShell.SecretStore)

#Initial Questions
$FName = Read-Host "What is the user's First Name? "
$LName = Read-Host "What is the user's Last Name? "

#Formatting and Variable Setup
$FInitial = $FName[0]
$domain = "@mydomain.com"
$email = ($FInitial + $LName).ToLower() + $domain

#Chat GPT Pluggins
$AnimalGPT = Get-GPT3Completion "Name an animal that starts with the letter $FInitial, respond in plaintext." 
$Animal = $AnimalGPT.tolower().trim()
start-sleep -s 3
Write-Host "Animal Chosen is $Animal"
$Image = Get-DalleImage "Get a realist image of a $Animal" | Out-String
$ImageLocation = $Image.ToLower().Trim()
Write-Host "Path is $ImageLocation"
start-sleep -s 3
$GetIdea = Get-GPT3Completion "What is a good name for a $Animal, respond in plaintext." 
$GetIdeaTrim = $GetIdea.ToLower().Trim()
Write-Host "Nickname for animal is $GetIdeaTrim"
start-sleep -s 3

#Makes the Password for the User based on the Animal and Name
$random = Get-Random -Minimum 00 -Maximum 99
$randomChar = -join ((33..33) + (35..38) + (60..64) | Get-Random -Count 2 | ForEach-Object {[char]$_} )
$rand3 = $random.ToString() + $randomChar.ToString()
$aname = $GetIdea.tolower().trim()
$substring = $aname.length - 1
$randomget = get-random -min 1 -max $substring 
$placement = $aname.Substring(($randomget - 1), $randomget)
$rname = $aname.Replace($placement,$placement.toupper())
$password = $rname + $rand3

#Displays the user's Password - Can be updated to send email or invoke webhook
Write-Host "$FName's password is $password"

#Creates the User
start-sleep -s 3
gam create user $email firstname $FName lastname $LName password $Password changepassword on 

#Uploads the Photo
start-sleep -s 3
gam user $email update photo $ImageLocation

#Removes the Photo from local storage
if (Test-Path $ImageLocation){
    remove-item $ImageLocation
}