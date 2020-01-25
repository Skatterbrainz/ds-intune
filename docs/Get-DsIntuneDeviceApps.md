---
external help file: ds-intune-help.xml
Module Name: ds-intune
online version: https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneDeviceApps.md
schema: 2.0.0
---

# Get-DsIntuneDeviceApps

## SYNOPSIS
Returns App inventory data from Intune Device data set

## SYNTAX

```
Get-DsIntuneDeviceApps [[-DataSet] <Object>]
```

## DESCRIPTION
Returns App inventory data from Intune Device data set

## EXAMPLES

### EXAMPLE 1
```
$devices = Get-DsIntuneDeviceData -UserName "john.doe@contoso.com"
```

$applist = Get-DsIntuneDeviceApps -DataSet $devices

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

## INPUTS

## OUTPUTS

## NOTES
NAME: Get-DsIntuneDeviceApps

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneDeviceApps.md](https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Get-DsIntuneDeviceApps.md)

