class OddsMonkeyParser
{
    Parse(row)
    {
;1	Time/Date
;2	Blank
;3	Details
;4	Bet
;5	Type
;6	Rating
;7	[blank]
;8   Bookmaker		<b>BETVICTOR</b><br /><br />£25 FREE BET<br /><br />
;9	[blank]
;10  Back
;11	Exchange		<b>BETFAIR</b><br /><br />£20 FREE BET PLUS UPTO £1000 CASHBACK<br /><br />
;12	[exchange link]
;13	Lay
;14 	Avail.
;15 	Age
        rowElements := StrSplit(row, [A_Tab])
        for index, element in rowElements 
        {
            MsgBox % index . " = " . element 
        }
    }
}
