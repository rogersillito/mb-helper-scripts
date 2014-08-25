

class OddsMonkeyParser
{
    Parsed := 0
    ErrorMessage := ""
    static RowIndexMap := {0: TimeDate, 2: Event, 3: Selection, 7: Bookie, 9: BackOdds, 10: Exchange, 12: LayOdds, 13: Liquidity}

    Parse(row)
    {
;1	Time/Date       = TimeDate
;2	Blank
;3	Details         = Event
;4	Bet             = Selection
;5	Type
;6	Rating
;7	[blank]
;8   Bookmaker		<b>BETVICTOR</b><br /><br />£25 FREE BET<br /><br /> 
;                   = Bookie
;9	[blank]
;10  Back           = BackOdds
;11	Exchange		<b>BETFAIR</b><br /><br />£20 FREE BET PLUS UPTO £1000 CASHBACK<br /><br />
;                   = Exchange
;12	[exchange link]
;13	Lay             = LayOdds
;14 	Avail.      = Liquidity
;15 	Age
        rowEls := StrSplit(row, [A_Tab])
        if (rowEls.MaxIndex() != 15)
            throw "OddsMonkeyParser.Parse: Expected 15 row elements, got " . rowEls.MaxIndex() + 1
        this.TimeDate := rowEls[0]
        MsgBox % this.TimeDate
        for index, element in rowEls 
        {
            ;MsgBox % "Index " . index . " = " . element 
        }
    }
}
