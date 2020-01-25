---
external help file: ds-intune-help.xml
Module Name: ds-intune
online version: https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneDevicesWithApp.md
schema: 2.0.0
---

# Get-DsIntuneDevicesWithApp

## SYNOPSIS
Returns Intune managed devices having a specified App installed

## SYNTAX

```
Get-DsIntuneDevicesWithApp [[-AppDataSet] <Object>] [-Application] <String> [-Username] <String>
 [-ShowProgress] [<CommonParameters>]
```

## DESCRIPTION
Returns Intune managed devices having a specified App installed

## EXAMPLES

### EXAMPLE 1
```
Get-DsIntuneDevicesWithApp -Application "*Putty*" -UserName "john.doe@contoso.com"
```

Returns list of Intune-managed devices which have any app name containing "Putty" installed

### EXAMPLE 2
```
Get-DsIntuneDevicesWithApp -Application "*Putty*" -UserName "john.doe@contoso.com" -ShowProgress
```

Returns list of Intune-managed devices which have any apps name containing "Putty" installed, and displays progress during execution

## PARAMETERS

### -AppDataSet
Applications dataset returned from Get-DsIntuneDeviceApps().
If not provided, Devices are queried automatically, which will incur additional time.

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

### -Application
Name, or wildcard name, of App to search for

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

### -Username
UserPrincipalName for authentication request

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

### -ShowProgress
Display progress during execution (default is silent / no progress shown)

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
NAME: Get-DsIntuneDevicesWithApp
This function was derived almost entirely from https://www.dowst.dev/search-intune-for-devices-with-application-installed/
(Thanks to Matt Dowst)

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneDevicesWithApp.md](https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneDevicesWithApp.md)

