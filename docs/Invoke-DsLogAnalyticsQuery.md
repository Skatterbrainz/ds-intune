---
external help file: ds-intune-help.xml
Module Name: ds-intune
online version: https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Invoke-DsLogAnalyticsQuery.md
schema: 2.0.0
---

# Invoke-DsLogAnalyticsQuery

## SYNOPSIS

## SYNTAX

```
Invoke-DsLogAnalyticsQuery [-WorkspaceName] <String> [-SubscriptionId] <Guid> [-ResourceGroup] <String>
 [-Query] <String> [[-Timespan] <String>] [-IncludeTabularView] [-IncludeStatistics] [-IncludeRender]
 [[-ServerTimeout] <Int32>] [[-Environment] <String>] [<CommonParameters>]
```

## DESCRIPTION
Invokes a query against the Log Analtyics Query API.

## EXAMPLES

### EXAMPLE 1
```
Invoke-DsLogAnaltyicsQuery -WorkspaceName "ws123" `
```

-SubscriptionId 12345678-abcd-efgh-4321-1234abcd5678 \`
	-ResourceGroup "my-resourcegroup" \`
	-Query "WaaSUpdateStatus | where NeedAttentionStatus==\`"Missing multiple security updates\`" | render table" \`
	-CreateObjectView

## PARAMETERS

### -WorkspaceName
The name of the Workspace to query against.

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

### -SubscriptionId
The ID of the Subscription this Workspace belongs to.

```yaml
Type: Guid
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ResourceGroup
The name of the Resource Group this Workspace belongs to.

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

### -Query
The query to execute.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Timespan
The timespan to execute the query against.
This should be an ISO 8601 timespan.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeTabularView
If specified, the raw tabular view from the API will be included in the response.

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

### -IncludeStatistics
If specified, query statistics will be included in the response.

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

### -IncludeRender
If specified, rendering statistics will be included (useful when querying metrics).

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

### -ServerTimeout
Specifies the amount of time (in seconds) for the server to wait while executing the query.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: 0
Accept pipeline input: False
Accept wildcard characters: False
```

### -Environment
Internal use only.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Adapted heavily from Eli Shlomo example at https://www.eshlomo.us/query-azure-log-analytics-data-with-powershell/

## RELATED LINKS

[https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Invoke-DsLogAnalyticsQuery.md](https://github.com/Skatterbrainz/ds-intune/blob/master/docs/Invoke-DsLogAnalyticsQuery.md)

