Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.DirectoryServices.AccountManagement
Import-Module ActiveDirectory

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = 'Hogwarts User Creator'
$form.Size = New-Object System.Drawing.Size(500,500)
$form.StartPosition = 'CenterScreen'

# First name label and textbox
$fnameLabel = New-Object System.Windows.Forms.Label
$fnameLabel.Location = New-Object System.Drawing.Point(10,20)
$fnameLabel.Size = New-Object System.Drawing.Size(100,20)
$fnameLabel.Text = 'First Name:'
$form.Controls.Add($fnameLabel)

$fnameTextBox = New-Object System.Windows.Forms.TextBox
$fnameTextBox.Location = New-Object System.Drawing.Point(120,20)
$fnameTextBox.Size = New-Object System.Drawing.Size(200,20)
$form.Controls.Add($fnameTextBox)

# Last name label and textbox
$lnameLabel = New-Object System.Windows.Forms.Label
$lnameLabel.Location = New-Object System.Drawing.Point(10,60)
$lnameLabel.Size = New-Object System.Drawing.Size(100,20)
$lnameLabel.Text = 'Last Name:'
$form.Controls.Add($lnameLabel)

$lnameTextBox = New-Object System.Windows.Forms.TextBox
$lnameTextBox.Location = New-Object System.Drawing.Point(120,60)
$lnameTextBox.Size = New-Object System.Drawing.Size(200,20)
$form.Controls.Add($lnameTextBox)

# Hogwarts Houses combobox
$houseLabel = New-Object System.Windows.Forms.Label
$houseLabel.Location = New-Object System.Drawing.Point(10,100)
$houseLabel.Size = New-Object System.Drawing.Size(100,20)
$houseLabel.Text = 'House:'
$form.Controls.Add($houseLabel)

$houseComboBox = New-Object System.Windows.Forms.ComboBox
$houseComboBox.Location = New-Object System.Drawing.Point(120,100)
$houseComboBox.Size = New-Object System.Drawing.Size(200,20)
$houses = @('Gryffindor', 'Hufflepuff', 'Ravenclaw', 'Slytherin')
$houseComboBox.Items.AddRange($houses)
$form.Controls.Add($houseComboBox)

# Button with event for AD User creation
$createButton = New-Object System.Windows.Forms.Button
$createButton.Location = New-Object System.Drawing.Point(120,140)
$createButton.Size = New-Object System.Drawing.Size(100,30)
$createButton.Text = 'Create User'
$createButton.Add_Click({
    $username = ($fnameTextBox.Text[0] + $lnameTextBox.Text).ToLower()
    $password = ConvertTo-SecureString "Hogwarts@1" -AsPlainText -Force
    New-ADUser -SamAccountName $username -Name ($fnameTextBox.Text + " " + $lnameTextBox.Text) -GivenName $fnameTextBox.Text -Surname $lnameTextBox.Text -UserPassword $password -Enabled $true
    [System.Windows.Forms.MessageBox]::Show('User created successfully!')
})
$form.Controls.Add($createButton)

# Display the form
$form.ShowDialog()
