<#
.COPYRIGHT
Portions of this are derived from Microsoft content on GitHub at the following URL:

https://github.com/microsoftgraph/powershell-intune-samples/blob/master/ManagedDevices/ManagedDevices_Apps_Get.ps1

Copyright (c) Microsoft Corporation. All rights reserved. Licensed under the MIT license.
See LICENSE in the project root for license information.
#>

#region Microsoft GitHub sample code

function Get-AuthToken {
	<#
	.SYNOPSIS
	This function is used to authenticate with the Graph API REST interface
	.DESCRIPTION
	The function authenticate with the Graph API Interface with the tenant name
	.EXAMPLE
	Get-AuthToken
	Authenticates you with the Graph API interface
	.NOTES
	NAME: Get-AuthToken
	#>
	[cmdletbinding()]
	param (
		[parameter(Mandatory)] $User
	)

	$userUpn = New-Object "System.Net.Mail.MailAddress" -ArgumentList $User
	$tenant = $userUpn.Host

	Write-Host "Checking for AzureAD module..."
	$AadModule = Get-Module -Name "AzureAD" -ListAvailable

	if ($null -eq $AadModule) {
		Write-Host "AzureAD PowerShell module not found, looking for AzureADPreview"
		$AadModule = Get-Module -Name "AzureADPreview" -ListAvailable
	}

	if ($null -eq $AadModule) {
		Write-Host
		Write-Host "AzureAD Powershell module not installed..." -f Red
		Write-Host "Install by running 'Install-Module AzureAD' or 'Install-Module AzureADPreview' from an elevated PowerShell prompt" -f Yellow
		Write-Host "Script can't continue..." -f Red
		Write-Host
		exit
	}

	# Getting path to ActiveDirectory Assemblies
	# If the module count is greater than 1 find the latest version

	if ($AadModule.count -gt 1){
		$Latest_Version = ($AadModule | Select-Object version | Sort-Object)[-1]
		$aadModule = $AadModule | Where-Object { $_.version -eq $Latest_Version.version }

		# Checking if there are multiple versions of the same module found
		if($AadModule.count -gt 1){
			$aadModule = $AadModule | Select-Object -Unique
		}
		$adal = Join-Path $AadModule.ModuleBase "Microsoft.IdentityModel.Clients.ActiveDirectory.dll"
		$adalforms = Join-Path $AadModule.ModuleBase "Microsoft.IdentityModel.Clients.ActiveDirectory.Platform.dll"
	}
	else {
		$adal = Join-Path $AadModule.ModuleBase "Microsoft.IdentityModel.Clients.ActiveDirectory.dll"
		$adalforms = Join-Path $AadModule.ModuleBase "Microsoft.IdentityModel.Clients.ActiveDirectory.Platform.dll"
	}

	[System.Reflection.Assembly]::LoadFrom($adal) | Out-Null
	[System.Reflection.Assembly]::LoadFrom($adalforms) | Out-Null

	$clientId = "d1ddf0e4-d672-4dae-b554-9d5bdfd93547"
	$redirectUri = "urn:ietf:wg:oauth:2.0:oob"
	$resourceAppIdURI = "https://graph.microsoft.com"
	$authority = "https://login.microsoftonline.com/$Tenant"

	try {
		$authContext = New-Object "Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext" -ArgumentList $authority
		# https://msdn.microsoft.com/en-us/library/azure/microsoft.identitymodel.clients.activedirectory.promptbehavior.aspx
		# Change the prompt behaviour to force credentials each time: Auto, Always, Never, RefreshSession
		$platformParameters = New-Object "Microsoft.IdentityModel.Clients.ActiveDirectory.PlatformParameters" -ArgumentList "Auto"
		$userId = New-Object "Microsoft.IdentityModel.Clients.ActiveDirectory.UserIdentifier" -ArgumentList ($User, "OptionalDisplayableId")
		$authResult = $authContext.AcquireTokenAsync($resourceAppIdURI,$clientId,$redirectUri,$platformParameters,$userId).Result

		# If the accesstoken is valid then create the authentication header
		if ($authResult.AccessToken){
			# Creating header for Authorization token
			$authHeader = @{
				'Content-Type'='application/json'
				'Authorization'="Bearer " + $authResult.AccessToken
				'ExpiresOn'=$authResult.ExpiresOn
			}
			return $authHeader
		}
		else {
			#Write-Host
			Write-Host "Authorization Access Token is null, please re-run authentication..." -ForegroundColor Red
			#Write-Host
			break
		}
	}
	catch {
		Write-Error $_.Exception.Message
		Write-Error $_.Exception.ItemName
		break
	}
}

function Get-DsIntuneAuth {
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string] $UserName
	)
	# Checking if authToken exists before running authentication
	if ($global:authToken) {

		# Setting DateTime to Universal time to work in all timezones
		$DateTime = (Get-Date).ToUniversalTime()

		# If the authToken exists checking when it expires
		$TokenExpires = ($authToken.ExpiresOn.datetime - $DateTime).Minutes

		if ($TokenExpires -le 0){
			Write-Host "Authentication Token expired" $TokenExpires "minutes ago" -ForegroundColor Yellow
			# Defining Azure AD tenant name, this is the name of your Azure Active Directory (do not use the verified domain name)
			$global:authToken = Get-AuthToken -User $UserName
		}
	}
	else {
		# Authentication doesn't exist, calling Get-AuthToken function
		$global:authToken = Get-AuthToken -User $UserName
	}
}

Function Get-AADUser() {
	<#
	.SYNOPSIS
	This function is used to get AAD Users from the Graph API REST interface
	.DESCRIPTION
	The function connects to the Graph API Interface and gets any users registered with AAD
	.EXAMPLE
	Get-AADUser
	Returns all users registered with Azure AD
	.EXAMPLE
	Get-AADUser -userPrincipleName user@domain.com
	Returns specific user by UserPrincipalName registered with Azure AD
	.NOTES
	NAME: Get-AADUser
	#>
	[cmdletbinding()]
	param (
		[parameter()][string] $userPrincipalName,
		[parameter()][string] $Property
	)
	$graphApiVersion = "v1.0"
	$User_resource = "users"

	try {
		if ([string]::IsNullOrEmpty($userPrincipalName)) {
			$uri = "https://graph.microsoft.com/$graphApiVersion/$($User_resource)"
			(Invoke-RestMethod -Uri $uri -Headers $authToken -Method Get).Value
		}
		else {
			if ([string]::IsNullOrEmpty($Property)) {
				$uri = "https://graph.microsoft.com/$graphApiVersion/$($User_resource)/$userPrincipalName"
				Write-Verbose $uri
				Invoke-RestMethod -Uri $uri -Headers $authToken -Method Get
			}
			else {
				$uri = "https://graph.microsoft.com/$graphApiVersion/$($User_resource)/$userPrincipalName/$Property"
				Write-Verbose $uri
				(Invoke-RestMethod -Uri $uri -Headers $authToken -Method Get).Value
			}
		}
	}
	catch {
		$ex = $_.Exception
		$errorResponse = $ex.Response.GetResponseStream()
		$reader = New-Object System.IO.StreamReader($errorResponse)
		$reader.BaseStream.Position = 0
		$reader.DiscardBufferedData()
		$responseBody = $reader.ReadToEnd();
		Write-Host "Response content:`n$responseBody" -f Red
		Write-Error "Request to $Uri failed with HTTP Status $($ex.Response.StatusCode) $($ex.Response.StatusDescription)"
		#Write-Host
		break
	}
}

Function Get-ManagedDevices(){
	<#
	.SYNOPSIS
	This function is used to get Intune Managed Devices from the Graph API REST interface
	.DESCRIPTION
	The function connects to the Graph API Interface and gets any Intune Managed Device
	.PARAMETER IncludeEAS
	Switch to include EAS devices (not included by default)
	.PARAMETER ExcludeMDM
	Switch to exclude MDM devices (not excluded by default)
	.EXAMPLE
	Get-ManagedDevices
	Returns all managed devices but excludes EAS devices registered within the Intune Service
	.EXAMPLE
	Get-ManagedDevices -IncludeEAS
	Returns all managed devices including EAS devices registered within the Intune Service
	.NOTES
	NAME: Get-ManagedDevices
	#>

	[cmdletbinding()]
	param (
		[parameter()][switch] $IncludeEAS,
		[parameter()][switch] $ExcludeMDM
	)
	$graphApiVersion = "beta"
	$Resource = "deviceManagement/managedDevices"
	try {
		$Count_Params = 0
		if ($IncludeEAS.IsPresent){ $Count_Params++ }
		if ($ExcludeMDM.IsPresent){ $Count_Params++ }
		if ($Count_Params -gt 1) {
			Write-Warning "Multiple parameters set, specify a single parameter -IncludeEAS, -ExcludeMDM or no parameter against the function"
			#Write-Host
			break
		}
		elseif ($IncludeEAS) {
			$uri = "https://graph.microsoft.com/$graphApiVersion/$Resource"
		}
		elseif ($ExcludeMDM) {
			$uri = "https://graph.microsoft.com/$graphApiVersion/$Resource`?`$filter=managementAgent eq 'eas'"
		}
		else {
			$uri = "https://graph.microsoft.com/$graphApiVersion/$Resource`?`$filter=managementAgent eq 'mdm' and managementAgent eq 'easmdm'"
			Write-Warning "EAS Devices are excluded by default, please use -IncludeEAS if you want to include those devices"
			#Write-Host
		}
		$response = (Invoke-RestMethod -Uri $uri -Headers $authToken -Method Get)
		$Devices = $response.Value
		$DevicesNextLink = $response."@odata.nextLink"
		while ($DevicesNextLink) {
			$response = (Invoke-RestMethod -Uri $DevicesNextLink -Headers $authToken -Method Get)
			$DevicesNextLink = $response."@odata.nextLink"
			$Devices += $response.value 
		}
		$Devices
	}
	catch {
		$ex = $_.Exception
		$errorResponse = $ex.Response.GetResponseStream()
		$reader = New-Object System.IO.StreamReader($errorResponse)
		$reader.BaseStream.Position = 0
		$reader.DiscardBufferedData()
		$responseBody = $reader.ReadToEnd();
		Write-Warning "Response content:`n$responseBody"
		Write-Error "Request to $Uri failed with HTTP Status $($ex.Response.StatusCode) $($ex.Response.StatusDescription)"
		Write-Host
		break
	}
}

#endregion 

function Get-DsIntuneDeviceData {
	<#
	.SYNOPSIS
	Returns dataset of Intune-managed devices with inventoried apps
	.DESCRIPTION
	Returns dataset of Intune-managed devices with inventoried apps
	.PARAMETER UserName
	UserPrincipalName for authentication request
	.PARAMETER ShowProgress
	Display progress as data is exported (default is silent / no progress shown)
	.PARAMETER Detailed
	Optional expanded list of device properties: Manufacturer, Model, Memory, 
	Disk Size, Disk Free, SerialNumber, Ownership, and Category
	.EXAMPLE
	$devices = Get-DsIntuneDeviceData -UserName "john.doe@contoso.com"
	Returns results of online request to variable $devices
	.EXAMPLE
	$devices = Get-DsIntuneDeviceData -UserName "john.doe@contoso.com" -ShowProgress
	Returns results of online request to variable $devices while displaying concurrent progress
	.LINK
	https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneDeviceData.md
	#>
	[CmdletBinding()]
	param(
		[parameter(Mandatory)][string] $UserName,
		[parameter()][switch] $ShowProgress,
		[parameter()][switch] $Detailed
	)
	Get-DsIntuneAuth -UserName $UserName
	$Devices = Get-ManagedDevices
	Write-Host "returned $($Devices.Count) managed devices"
	if ($Devices){
		$dx = 1
		$dcount = $Devices.Count
		foreach ($Device in $Devices){
			if ($ShowProgress) { 
				Write-Progress -Activity "Found $dcount" -Status "$dx of $dcount" -PercentComplete $(($dx/$dcount)*100) -id 1
			}
			$DeviceID = $Device.id
			$uri = "https://graph.microsoft.com/beta/deviceManagement/manageddevices('$DeviceID')?`$expand=detectedApps"
			$DetectedApps = (Invoke-RestMethod -Uri $uri -Headers $authToken -Method Get).detectedApps
			$dx++
			if ($Detailed) {
				$disksize  = [math]::Round(($Device.totalStorageSpaceInBytes / 1GB),2)
				$freespace = [math]::Round(($Device.freeStorageSpaceInBytes / 1GB),2)
				$mem       = [math]::Round(($Device.physicalMemoryInBytes / 1GB),2)
				[pscustomobject]@{
					DeviceName   = $Device.DeviceName
					DeviceID     = $DeviceID
					Manufacturer = $Device.manufacturer
					Model        = $Device.model 
					MemoryGB     = $mem
					DiskSizeGB   = $disksize
					FreeSpaceGB  = $freespace
					SerialNumber = $Device.serialNumber 
					OSName       = $Device.operatingSystem 
					OSVersion    = $Device.osVersion
					Ownership    = $Device.ownerType
					Category     = $Device.deviceCategoryDisplayName
					Apps         = $DetectedApps
				}
			}
			else {
				$disksize  = [math]::Round(($Device.totalStorageSpaceInBytes / 1GB),2)
				$freespace = [math]::Round(($Device.freeStorageSpaceInBytes / 1GB),2)
				[pscustomobject]@{
					DeviceName   = $Device.DeviceName
					DeviceID     = $DeviceID
					OSName       = $Device.operatingSystem 
					OSVersion    = $Device.osVersion
					Apps         = $DetectedApps
				}
			}
		}
	}
	else {
		Write-Host "No Intune Managed Devices found..." -f green
		Write-Host
	}
}

function Get-DsIntuneDeviceApps($DataSet) {
	<#
	.SYNOPSIS
	Returns App inventory data from Intune Device data set
	.DESCRIPTION
	Returns App inventory data from Intune Device data set
	.PARAMETER DataSet
	Data returned from Get-DsIntuneDeviceData()
	.EXAMPLE
	$devices = Get-DsIntuneDeviceData -UserName "john.doe@contoso.com"
	$applist = Get-DsIntuneDeviceApps -DataSet $devices
	.LINK
	https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneDeviceApps.md
	#>
	foreach ($row in $Dataset) {
		$devicename = $row.DeviceName
		if ($null -ne $row.Apps) {
			$apps = $row.Apps
			foreach ($app in $apps) {
				if (![string]::IsNullOrEmpty($app.displayName)) {
					[pscustomobject]@{
						DeviceName     = $devicename
						ProductName    = $app.displayName
						ProductVersion = $app.version
						ProductCode    = $app.Id
					}
				}
			}
		}   
	}
}

Function Get-MsGraphData($Path) {
	<#
	.NOTES
	This function was derived from https://www.dowst.dev/search-intune-for-devices-with-application-installed/
	(Thanks to Matt Dowst)
	#>
	$FullUri = "https://graph.microsoft.com/beta/$Path"
	[System.Collections.Generic.List[PSObject]]$Collection = @()
	$NextLink = $FullUri
	do {
		$Result = Invoke-RestMethod -Method Get -Uri $NextLink -Headers $AuthHeader
		if ($Result.'@odata.count') {
			$Result.value | ForEach-Object{$Collection.Add($_)}
		} 
		else {
			$Collection.Add($Result)
		}
		$NextLink = $Result.'@odata.nextLink'
	} while ($NextLink)
	return $Collection
}

function Get-DsIntuneDevicesWithApp {
	<#
	.SYNOPSIS
	Returns Intune managed devices having a specified App installed
	.DESCRIPTION
	Returns Intune managed devices having a specified App installed
	.PARAMETER AppDataSet
	Applications dataset returned from Get-DsIntuneDeviceApps().
	If not provided, Devices are queried automatically, which will incur additional time.
	.PARAMETER Application
	Name, or wildcard name, of App to search for
	.PARAMETER UserName
	UserPrincipalName for authentication request
	.PARAMETER ShowProgress
	Display progress during execution (default is silent / no progress shown)
	.EXAMPLE
	Get-DsIntuneDevicesWithApp -Application "*Putty*" -UserName "john.doe@contoso.com"
	Returns list of Intune-managed devices which have any app name containing "Putty" installed
	.EXAMPLE
	Get-DsIntuneDevicesWithApp -Application "*Putty*" -UserName "john.doe@contoso.com" -ShowProgress
	Returns list of Intune-managed devices which have any apps name containing "Putty" installed, and displays progress during execution
	.NOTES
	This function was derived almost entirely from https://www.dowst.dev/search-intune-for-devices-with-application-installed/
	(Thanks to Matt Dowst)
	.LINK
	https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneDevicesWithApp.md
	#>
	[CmdletBinding()]
	param (
		[parameter()] $AppDataSet,
		[parameter(Mandatory)][ValidateNotNullOrEmpty()][string] $Application,
		[parameter(Mandatory)][ValidateNotNullOrEmpty()][string] $Username,
		[parameter()][switch] $ShowProgress
	)
	# Get authentication token
	$AuthHeader = Get-AuthToken -User $Username

	# Get all devices in Intune
	$AllDevices = Get-MsGraphData "deviceManagement/managedDevices"

	# Get detected app for each device and check for app name
	[System.Collections.Generic.List[PSObject]]$FoundApp = @()
	$wp = 1
	foreach($Device in $AllDevices) {
		if ($ShowProgress) { Write-Progress -Activity "Found $($FoundApp.count)" -Status "$wp of $($AllDevices.count)" -PercentComplete $(($wp/$($AllDevices.count))*100) -id 1 }
		$AppData = Get-MsGraphData "deviceManagement/managedDevices/$($Device.id)?`$expand=detectedApps"
		$DetectedApp = $AppData.detectedApps | Where-Object {$_.displayname -like $Application}
		if ($DetectedApp) {
			$DetectedApp | 
				Select-Object @{l='DeviceName';e={$Device.DeviceName}}, @{l='Application';e={$_.displayname}}, Version, SizeInByte,
				@{l='LastSyncDateTime';e={$Device.lastSyncDateTime}}, @{l='DeviceId';e={$Device.id}} | 
					Foreach-Object { $FoundApp.Add($_) }
		}
		$wp++
	}
	if ($ShowProgress) { Write-Progress -Activity "Done" -Id 1 -Completed }
	$FoundApp
}

function Get-DsIntuneAppInstallCounts {
	<#
	.SYNOPSIS
	Return Applications grouped and sorted by Installation Counts
	.DESCRIPTION
	Return Applications grouped and sorted by Installation Counts in descending order
	.PARAMETER AppDataSet
	Applications dataset returned from Get-DsIntuneDeviceApps()
	.PARAMETER RowCount
	Limit to first (N) rows (default is 0 / returns all rows)
	.EXAMPLE
	$apps = Get-DsIntuneDeviceApps -DataSet $devices
	$top20 = Get-DsIntuneAppInstallCounts -AppDataSet $apps -RowCount 20
	.LINK
	https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneAppInstallCounts.md
	#>
	param (
		[parameter()] $AppDataSet,
		[parameter()][int] $RowCount = 0
	)
	try {
		$result = $AppDataSet | Group-Object -Property ProductName,ProductVersion | Select-Object Count,Name | Sort-Object Count -Descending
		if ($RowCount -gt 0) { 
			$result | Select-Object -First $RowCount
		}
		else {
			$result
		}
	}
	catch {
		Write-Error $_.Exception.Message
	}
}

function Export-DsIntuneAppInventory {
	<#
	.SYNOPSIS
	Export Intune Device Applications Inventory to Excel Workbook
	.DESCRIPTION
	Export Intune Device Applications Inventory to Excel Workbook
	.PARAMETER DeviceData
	Device data returned from Get-DsIntuneDeviceData(). If not provided, Get-DsIntuneDeviceData() is invoked automatically.
	Passing Device data to -DeviceData can save significant processing time.
	.PARAMETER Title
	Title used for prefix of XLSX filename
	.PARAMETER UserName
	UserPrincipalName for authentication
	.PARAMETER Overwrite
	Replace output file it exists
	.PARAMETER Show
	Open workbook in Excel when completed (requires Excel on host machine)
	.EXAMPLE
	Export-DsIntuneAppInventory -Title "Contoso" -UserName "john.doe@contoso.com" -Overwrite
	Queries devices and applications to generate output file
	.EXAMPLE
	Export-DsIntuneAppInventory -DeviceData $devices -Title "Contoso" -UserName "john.doe@contoso.com" -Overwrite -Show
	Processes existing data ($devices) to generate output file and display the results in Excel when finished
	.NOTES
	Requires PS module ImportExcel
	.LINK
	https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Export-DsIntuneAppInventory.md
	#>
	[CmdletBinding()]
	param (
		[parameter()] $DeviceData,
		[parameter(Mandatory)][ValidateNotNullOrEmpty()][string] $Title,
		[parameter(Mandatory)][ValidateNotNullOrEmpty()][string] $UserName,
		[parameter()][switch] $Overwrite,
		[parameter()][switch] $Show
	)
	if (!(Get-Module ImportExcel -ListAvailable)) {
		Write-Warning "This function requires the PowerShell module ImportExcel, which is not installed."
		break
	}
	try {
		$xlFile = "$($env:USERPROFILE)\Documents\$Title`_IntuneDeviceApps_$(Get-Date -f 'yyyy-MM-dd').xlsx"
		if ((Test-Path $xlFile) -and (!$Overwrite)) {
			Write-Warning "Output file exists [$xlFile]. Use -Overwrite to replace."
			break
		}
		$time1 = Get-Date
		if (!$DeviceData) {
			Write-Host "requesting managed devices data from Intune" -ForegroundColor Cyan
			$DeviceData = Get-DsIntuneDeviceData -UserName $UserName -Detailed
		}
		else {
			Write-Warning "device dataset should be derived with [-Detailed] option, to get the full set of properties."
		}
		Write-Host "querying installed applications for each device" -ForegroundColor Cyan
		$applist = Get-DsIntuneDeviceApps -DataSet $DeviceData
		Write-Host "exporting results to file: $xlFile" -ForegroundColor Cyan
		$DeviceData | Select-Object DeviceName,DeviceID,Manufacturer,Model,DiskSizeGB,FreeSpaceGB,SerialNumber,OSName,OSVersion,Ownership,Category |
			Export-Excel -Path $xlFile -WorksheetName "Devices" -ClearSheet -AutoSize -AutoFilter -FreezeTopRow
		$applist | 
			Export-Excel -Path $xlFile -WorksheetName "Applications" -ClearSheet -AutoSize -AutoFilter -FreezeTopRow
		Write-Host "Results saved to: $xlFile" -ForegroundColor Green
		$time2 = Get-Date
		$rt = New-TimeSpan -Start $time1 -End $time2
		Write-Host "total runtime: $($rt.Hours)`:$($rt.Minutes)`:$($rt.Seconds) (hh`:mm`:ss)" -ForegroundColor Cyan
		if ($Show) {
			Start-Process -FilePath "$xlFile"
		}
	}
	catch {
		Write-Error $_.Exception.Message
	}
}