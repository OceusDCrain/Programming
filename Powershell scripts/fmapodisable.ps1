$FMService = Get-Service | where Name -eq "FMAPOService"
	if ($FMService) {"FM APOService Found.. removing"} 
		stop-service -name fmaposervice -force
		set-service -name fmaposervice -startuptype disabled
	else {"FM APOService NOT Found.. exiting"}
		exit