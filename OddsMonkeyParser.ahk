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

class OddsMonkeyParser
{
    ColMap := {TimeDate: 1, Event: 3, Selection: 4, Bookie: 8, BackOdds: 10, Exchange: 11, LayOdds: 13, Liquidity: 14}
    ExpectedColumnCount := 15

    Parsed := false
    ErrorMessage := ""
    ColumnValues := []

    Parse(row)
    {
        this.ColumnValues := StrSplit(row, [A_Tab])
        columnCount := this.ColumnValues.MaxIndex()
        if (columnCount != this.ExpectedColumnCount)
        {   
            this.ErrorMessage := "OddsMonkeyParser.Parse(): Expected " . this.ExpectedColumnCount . " table columns, got " . columnCount
            return
        }
        this.TimeDate := this.GetElement(this.ColMap.TimeDate)
        this.Time := this.GetTimeFrom(this.TimeDate)
        this.Event := this.GetElement(this.ColMap.Event)
        this.Selection := this.GetElement(this.ColMap.Selection)
        this.BackOdds := this.GetElement(this.ColMap.BackOdds)
        this.LayOdds := this.GetElement(this.ColMap.LayOdds)
        this.Liquidity := SubStr(this.GetElement(this.ColMap.Liquidity), 2)
        this.Parsed := true
    }

    GetElement(idx)
    {
        return this.ColumnValues[idx]
    }

    GetTimeFrom(dateTime)
    {
        time := SubStr(dateTime, 12)
        StringTrimRight, trimmedTime, time, 3
        return trimmedTime
    }
}
