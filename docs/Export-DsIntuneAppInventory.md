---
external help file: ds-intune-help.xml
Module Name: ds-intune
online version: https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Export-DsIntuneAppInventory.md
schema: 2.0.0
---

# Export-DsIntuneAppInventory

## SYNOPSIS
Export Intune Device Applications Inventory to Excel Workbook

## SYNTAX

```
Export-DsIntuneAppInventory [[-DeviceData] <Object>] [-Title] <String> [-UserName] <String> [-Overwrite]
 [-Show] [<CommonParameters>]
```

## DESCRIPTION
Export Intune Device Applications Inventory to Excel Workbook

## EXAMPLES

### EXAMPLE 1
```
Export-DsIntuneAppInventory -Title "Contoso" -UserName "john.doe@contoso.com" -Overwrite
```

Queries devices and applications to generate output file

### EXAMPLE 2
```
Export-DsIntuneAppInventory -DeviceData $devices -Title "Contoso" -UserName "john.doe@contoso.com" -Overwrite -Show
```

Processes existing data ($devices) to generate output file and display the results in Excel when finished

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
Requires PS module ImportExcel

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Export-DsIntuneAppInventory.md](https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Export-DsIntuneAppInventory.md)

