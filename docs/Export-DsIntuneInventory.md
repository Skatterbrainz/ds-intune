---
external help file: ds-intune-help.xml
Module Name: ds-intune
online version: https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Export-DsIntuneInventory.md
schema: 2.0.0
---

# Export-DsIntuneInventory

## SYNOPSIS
Export Intune Device Applications Inventory to Excel Workbook

## SYNTAX

```
Export-DsIntuneInventory [[-DeviceData] <Object>] [-Title] <String> [-UserName] <String> [-Overwrite]
 [-Distinct] [[-DaysOld] <Int32>] [-Show] [<CommonParameters>]
```

## DESCRIPTION
Export Intune Device Applications Inventory to Excel Workbook

## EXAMPLES

### EXAMPLE 1
```
Export-DsIntuneInventory -Title "Contoso" -UserName "john.doe@contoso.com" -Overwrite
```

Queries all Intune devices and applications to generate output file

### EXAMPLE 2
```
$devices = Get-DsIntuneDevices -UserName "john.doe@contoso.com"
```

$apps = Get-DsIntuneInstalledApps -DataSet $devices
Export-DsIntuneInventory -DeviceData $devices -Title "Contoso" -UserName "john.doe@contoso.com" -Overwrite -Show

Processes existing data ($devices) to generate output file with "Contoso" in the filename, and 
display the results in Excel when finished

### EXAMPLE 3
```
$devices = Get-DsIntuneDevices -UserName "john.doe@contoso.com"
```

$apps = Get-DsIntuneInstalledApps -DataSet $devices
Export-DsIntuneInventory -DeviceData $devices -Title "Contoso" -UserName "john.doe@contoso.com" -Overwrite -Show -Distinct

Processes existing data ($devices) to generate output file with "Contoso" in the filename, and 
display the unique App results in Excel when finished

### EXAMPLE 4
```
$devices = Get-DsIntuneDevices -UserName "john.doe@contoso.com" | Where-Object {$_.OSName -eq 'Windows'}
```

$apps = Get-DsIntuneInstalledApps -DataSet $devices
Export-DsIntuneInventory -DeviceData $devices -Title "Contoso" -UserName "john.doe@contoso.com" -Overwrite -Show -Distinct

Processes existing data ($devices) for only Windows devices, to generate output file with "Contoso" in the
filename, and display the unique App results in Excel when finished

## PARAMETERS

### -DeviceData
Device data returned from Get-DsIntuneDeviceData().
If not provided, Get-DsIntuneDeviceData() is invoked automatically.
Passing Device data to -DeviceData can save significant processing time.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
Title used for prefix of XLSX filename

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
UserPrincipalName for authentication

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Overwrite
Replace output file it exists

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Distinct
Filter DeviceName+AppName only to remove duplicates arising from different versions

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -DaysOld
Filter stale accounts by specified number of days (range 10 to 1000, default = 180)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 180
Accept pipeline input: False
Accept wildcard characters: False
```

### -Show
Open workbook in Excel when completed (requires Excel on host machine)

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
NAME: Export-DsIntuneInventory
Requires PS module ImportExcel

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Export-DsIntuneInventory.md](https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Export-DsIntuneInventory.md)

