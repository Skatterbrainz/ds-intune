---
external help file: ds-intune-help.xml
Module Name: ds-intune
online version: https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneDeviceSummary.md
schema: 2.0.0
---

# Get-DsIntuneDeviceSummary

## SYNOPSIS
Returns Summary by Property Set

## SYNTAX

```
Get-DsIntuneDeviceSummary [[-Property] <Object>] [[-DataSet] <Object>] [[-UserName] <String>] [-ShowProgress]
 [<CommonParameters>]
```

## DESCRIPTION
Returns grouped data by property set

## EXAMPLES

### EXAMPLE 1
```
$devices = Get-DsIntuneDevices -UserName "john.doe@contoso.com"
```

Get-DsIntuneDeviceSummary -DataSet $devices -Property Model -ShowProgress

Query against data returned from direct query and saved to $devices

### EXAMPLE 2
```
Get-DsIntuneDeviceSummary -Property Model -UserName "john.doe@contoso.com" -ShowProgress
```

Query data directly from Intune graph source

## PARAMETERS

### -Property
Name of device property to group dataset on.
Default is OSName

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: OSName
Accept pipeline input: False
Accept wildcard characters: False
```

### -DataSet
Devices dataset returned from Get-DsIntuneDevices

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UserName
Required for invoked query if DataSet is $null

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowProgress
Show progress indicator while querying dataset

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
Name: Get-DsIntuneDeviceSummary

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneDeviceSummary.md](https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneDeviceSummary.md)

