---
external help file: ds-intune-help.xml
Module Name: ds-intune
online version: https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneStaleDevices.md
schema: 2.0.0
---

# Get-DsIntuneStaleDevices

## SYNOPSIS
Returns devices which have not synchronized within the last N (-Days)

## SYNTAX

```
Get-DsIntuneStaleDevices [[-DataSet] <Object>] [[-Days] <Int32>] [-Detailed] [-ShowProgress]
 [<CommonParameters>]
```

## DESCRIPTION
Returns Intune device accounts which have not synchronized within
the last \<N\> days as specified by -Days

## EXAMPLES

### EXAMPLE 1
```
Get-DsIntuneStaleDevices -DataSet $devices
```

Returns devices which have not synchronized with AzureAD in the last 30 days

### EXAMPLE 2
```
Get-DsIntuneStaleDevices -DataSet $devices -Detailed -Days 60
```

Returns devices with detailed properties which have not synchronized with AzureAD in the last 60 days

## PARAMETERS

### -DataSet
Data returned from Get-DsIntuneDeviceData()

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

### -Days
Number of days to allow (default is 30)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 30
Accept pipeline input: False
Accept wildcard characters: False
```

### -Detailed
Returns detailed property set for each device (see Get-DsIntuneDeviceData) if -DataSet is $null

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

### -ShowProgress
Displays progress during query if -DataSet is $null

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
NAME: Get-DsIntuneStaleDevices

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneStaleDevices.md](https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneStaleDevices.md)

