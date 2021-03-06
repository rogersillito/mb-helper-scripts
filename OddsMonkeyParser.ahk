;;;;; html row contents from copying an oddsmonkey row from Chrome ;;;;;
;1   Time/Date       = TimeDate
;2   [blank]
;3   Details         = Event
;4   Bet             = Selection
;5   Type
;6   Rating
;7   [blank]
;8   [blank]
;9   Bookmaker	     = Bookie      format:  <b>BETVICTOR</b><br /><br />�25 FREE BET<br /><br /> 
;10  [blank]
;11  Back            = BackOdds
;12  [blank]
;13  Exchange		 = Exchange    format:  <b>BETFAIR</b><br /><br />�20 FREE BET PLUS UPTO �1000 CASHBACK<br /><br />
;14  [exchange link]
;15  Lay             = LayOdds
;16  Avail.          = Liquidity
;17  Age

class OddsMonkeyParser
{
    __New(bettingSites)
    {
        ; Expected format [{oMName: "ABC", uMNames: ["ABC1", "ABC2"]}, {oMName: "XYZ", uMNames: ["XYZ"]}
        this.BettingSites := bettingSites
    }

    ColMap := {TimeDate: 1, Event: 3, Selection: 4, Bookie: 9, BackOdds: 11, Exchange: 13, LayOdds: 15, Liquidity: 16}
    ExpectedColumnCount := 17

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
        ;this.Bookies := this.GetMappedUMNamesFor(this.ColMap.Bookie)
        ;this.Exchanges := this.GetMappedUMNamesFor(this.ColMap.Exchange)
        if (this.ErrorMessage != "")
            return
        this.Parsed := true
    }

    GetElement(idx)
    {
        return this.ColumnValues[idx]
    }

    GetTimeFrom(dateTime)
    {
        time := SubStr(dateTime, 12)
        StringTrimRight, timeWithoutSeconds, time, 3
        return timeWithoutSeconds
    }

    GetMappedUMNamesFor(idx)
    {
        html := this.GetElement(idx)
        oMName := this.GetBettingSiteOMNameFrom(html)
        For idx, bettingSite in this.BettingSites
        {
            if (oMName = bettingSite.oMName)
                return bettingSite.uMNames
        }
        this.ErrorMessage := "OddsMonkeyParser.GetMappedUMNamesFor(): No entry found in bettingSites list for '" . oMName . "'"
    }

    GetBettingSiteOMNameFrom(html)
    {
        excludeFirstTag := SubStr(html, 4)
        return StrSplit(excludeFirstTag, "<")[1]
    }
}
