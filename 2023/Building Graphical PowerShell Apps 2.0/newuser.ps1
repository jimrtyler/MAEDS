<# 
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$MakeHogwartsUser                = New-Object system.Windows.Forms.Form
$MakeHogwartsUser.ClientSize     = New-Object System.Drawing.Point(381,285)
$MakeHogwartsUser.text           = "Make Hogwarts User"
$MakeHogwartsUser.TopMost        = $false

$firstNameLabel                  = New-Object system.Windows.Forms.Label
$firstNameLabel.text             = "First Name:"
$firstNameLabel.AutoSize         = $true
$firstNameLabel.width            = 25
$firstNameLabel.height           = 10
$firstNameLabel.location         = New-Object System.Drawing.Point(58,48)
$firstNameLabel.Font             = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$firstNameTextBox                = New-Object system.Windows.Forms.TextBox
$firstNameTextBox.multiline      = $false
$firstNameTextBox.width          = 100
$firstNameTextBox.height         = 20
$firstNameTextBox.location       = New-Object System.Drawing.Point(194,43)
$firstNameTextBox.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$LastNameLabel                   = New-Object system.Windows.Forms.Label
$LastNameLabel.text              = "Last Name:"
$LastNameLabel.AutoSize          = $true
$LastNameLabel.width             = 25
$LastNameLabel.height            = 10
$LastNameLabel.location          = New-Object System.Drawing.Point(58,102)
$LastNameLabel.Font              = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$LastNameTextbox                 = New-Object system.Windows.Forms.TextBox
$LastNameTextbox.multiline       = $false
$LastNameTextbox.width           = 100
$LastNameTextbox.height          = 20
$LastNameTextbox.location        = New-Object System.Drawing.Point(195,97)
$LastNameTextbox.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',12)

$HouseNameComboBox               = New-Object system.Windows.Forms.ComboBox
$HouseNameComboBox.text          = "Choose House"
$HouseNameComboBox.width         = 195
$HouseNameComboBox.height        = 20
$HouseNameComboBox.location      = New-Object System.Drawing.Point(83,155)
$HouseNameComboBox.Font          = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$CreateUserButton                = New-Object system.Windows.Forms.Button
$CreateUserButton.text           = "Create User"
$CreateUserButton.width          = 89
$CreateUserButton.height         = 30
$CreateUserButton.location       = New-Object System.Drawing.Point(144,214)
$CreateUserButton.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$MakeHogwartsUser.controls.AddRange(@($firstNameLabel,$firstNameTextBox,$LastNameLabel,$LastNameTextbox,$HouseNameComboBox,$CreateUserButton))

$CreateUserButton.Add_Click({ 
    
    $FirstName = $firstNameTextBox.Text
    $Surname = $LastNameTextbox.Text 
    $FullName = "$FirstName$Surname"

    #$MakeHogwartsUser.Text = $FullName

    New-ADUser -Name $FullName -OtherAttributes @{
    'GivenName'=$FirstName
    'Surname'=$Surname
    }
 })

#region Logic 

#endregion

[void]$MakeHogwartsUser.ShowDialog()