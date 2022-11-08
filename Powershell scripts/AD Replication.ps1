<#
/a Aborts, if any server is unavailable.
/A Synchronizes all naming contexts that are held on the home server.
/d Identifies servers by distinguished name in messages.
/e Synchronizes domain controllers across all sites in the enterprise. By default, this command does not synchronize domain controllers in other sites.
/h Displays Help.
/i Iterates indefinitely.
/I Runs the repadmin /showrepl command on each server pair in the path instead of synchronizing.
/j Synchronizes adjacent servers only.
/p Pauses after every message to allow the user to abort the command.
/P Pushes changes outward from the specified domain controller.
/q Runs in quiet mode, which suppresses call back messages.
/Q Runs in very quiet mode, which reports fatal errors only.
/s Does not synchronize.
/S Skips the initial server response check.
#>
(Get-ADDomainController -Filter *).Name | Foreach-Object { repadmin /syncall $_ (Get-ADDomain).DistinguishedName /AdeP }
Get-ADReplicationPartnerMetadata -Target "$env:userdnsdomain" -Scope Domain | Select-Object Server, LastReplicationSuccess

$SyncServerSession = New-PSSession -computername vm-azadc01.eficomm.com
Invoke-Command -Session $SyncServerSession -ScriptBlock {Start-ADSyncSyncCycle -PolicyType Delta}
Remove-PSSession $SyncServerSession
