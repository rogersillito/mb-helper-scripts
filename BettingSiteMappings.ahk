; This script defines mappings between the bookie/exchange names used in OddsMonkey 
; and those used in the Ultimatcher "Bookies" tab.  The must be a mapping defined for each
; bookie/exchange you copy from in OddsMonkey
; TODO if there is no mapping for a site, create a mapped item from the oddsmonkey name
; TODO if only 1 value, accept a string instead of a list
; TODO simplify mappings - each entry is a 1 property object key=OMName, value=UMNames
BettingSiteMappings := []

BettingSiteMappings.Insert({"OMName": "SMARKETS", "UMNames": ["Smarkets"]})
BettingSiteMappings.Insert({"OMName": "BETDAQ", "UMNames": ["Betdaq"]})
BettingSiteMappings.Insert({"OMName": "BETFAIR", "UMNames": ["Betfair"]})
BettingSiteMappings.Insert({"OMName": "LADBROKES", "UMNames": ["Ladbrokes", "_K Ladbrokes", "_M Ladbrokes"]})
BettingSiteMappings.Insert({"OMName": "SKYBET", "UMNames": ["Skybet"]})
BettingSiteMappings.Insert({"OMName": "CORAL", "UMNames": ["Coral"]})
;BettingSiteMappings.Insert({"OMName": "", "UMNames": ""})
