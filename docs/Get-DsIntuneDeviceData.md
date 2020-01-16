---
external help file: ds-intune-help.xml
Module Name: ds-intune
online version:
schema: 2.0.0
---

# Get-DsIntuneDeviceData

## SYNOPSIS
Returns dataset of Intune-managed devices with inventoried apps

## SYNTAX

```
Get-DsIntuneDeviceData [-UserName] <String> [-ShowProgress] [<CommonParameters>]
```

## DESCRIPTION
Returns dataset of Intune-managed devices with inventoried apps

## EXAMPLES

### EXAMPLE 1
```
$devices = Get-DsIntuneDeviceData -UserName "john.doe@contoso.com"
```

Returns results of online request to variable $devices

### EXAMPLE 2
```
$devices = Get-DsIntuneDeviceData -UserName "john.doe@contoso.com" -ShowProgress
```

Returns results of online request to variable $devices while displaying concurrent progress

## PARAMETERS

### -UserName
UserPrincipalName for authentication request

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ShowProgress
Display progress as data is exported (default is silent / no progress shown)

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

## RELATED LINKS
