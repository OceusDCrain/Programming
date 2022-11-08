$ous = 'OU=Plano,DC=eficomm,DC=com','OU=Reston,DC=eficomm,DC=com','OU=Remote users,DC=eficomm,DC=com'
$ous |
    ForEach-Object{
        Get-AdUser -filter {enabled -eq $true -and userprincipalname -notlike 'ladm*'} -searchbase $_  -properties mail,DisplayName,Title,Department,Manager
    } |
    Select mail,DisplayName,Title,Department,@{Name = "Manager";Expression = {foreach-object{(Get-AdUser $_.Manager -Properties DisplayName).DisplayName}}} |
    Out-GridView