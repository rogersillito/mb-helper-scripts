#Include <Yunit\Yunit>
#Include <Yunit\Window>
#Include <Yunit\StdOut>

#SingleInstance Force
#Include OddsMonkeyParser.ahk

Yunit.Use(YunitStdOut, YunitWindow).Test(OddsMonkeyParserTestSuite)

class OddsMonkeyParserTestSuite
{
    class When_row_is_valid
    {
        Begin()
        {
            this.Row := "31/08/2014 13:30:00		Aston Villa v Hull	1-0	Correct Score	106.95		<b>LADBROKES</b><br /><br />UP TO £100 FREE BET (CODE F50)<br /><br />	Direct link to event on Bookmaker website	8.5	<b>BETFAIR</b><br /><br />£20 FREE BET PLUS UPTO £1000 CASHBACK<br /><br />	Direct link to event on Exchange website	7.6	£208	1.8"
            this.SUT := new OddsMonkeyParser()
            this.SUT.Parse(this.Row)
        }

        End()
        {
            this.remove("SUT")
        }

        Test_Parsed_is_true_when_row_is_valid()
        {
            Yunit.assert(this.SUT.Parsed, "SUT.Parsed = " . SUT.Parsed)
        }
        
        Test_ErrorMessage_equals_empty_string()
        {
            Yunit.assert(this.SUT.ErrorMessage == "", "Error message was '" . this.SUT.ErrorMessage . "'")
        }

        Test_TimeDate_property_is_set()
        {
            Yunit.assert(this.SUT.TimeDate == "31/08/2014 13:30:00", "TimeDate is '" . this.SUT.TimeDate . "'")
        }

        Test_Time_property_is_set()
        {
            Yunit.assert(this.SUT.Time == "13:30", "Time is '" . this.SUT.Time . "'")
        }

        Test_Liquidity_property_is_set()
        {
            Yunit.assert(this.SUT.Liquidity == "208", "Liquidity is '" . this.SUT.Liquidity . "'")
        }

        Test_LayOdds_property_is_set()
        {
            Yunit.assert(this.SUT.LayOdds == "7.6", "LayOdds is '" . this.SUT.LayOdds . "'")
        }

        Test_Exchange_property_is_set()
        {
            Yunit.assert(this.SUT.Exchange == "Betfair", "Exchange is '" . this.SUT.Exchange . "'")
        }

        Test_BackOdds_property_is_set()
        {
            Yunit.assert(this.SUT.BackOdds == "8.5", "BackOdds is '" . this.SUT.BackOdds . "'")
        }

        Test_Bookie_property_is_set()
        {
            Yunit.assert(this.SUT.Bookie == "Ladbrokes", "Bookie is '" . this.SUT.Bookie . "'")
        }

        Test_Selection_property_is_set()
        {
            Yunit.assert(this.SUT.Selection == "1-0", "Selection is '" . this.SUT.Selection . "'")
        }

        Test_Event_property_is_set()
        {
            Yunit.assert(this.SUT.Event == "Aston Villa v Hull", "Event is '" . this.SUT.Event . "'")
        }
    }   

    class When_row_is_invalid
    {
        Begin()
        {
            ; invalid - no event column
            this.Row := "31/08/2014 13:30:00		1-0	Correct Score	106.95		<b>LADBROKES</b><br /><br />UP TO £100 FREE BET (CODE F50)<br /><br />	Direct link to event on Bookmaker website	8.5	<b>BETFAIR</b><br /><br />£20 FREE BET PLUS UPTO £1000 CASHBACK<br /><br />	Direct link to event on Exchange website	7.6	£208	1.8"
            this.SUT := new OddsMonkeyParser()
            this.SUT.Parse(this.Row)
        }

        End()
        {
            this.remove("SUT")
        }

        Test_Parsed_is_false()
        {
            Yunit.assert(!this.SUT.Parsed, "SUT.Parsed = " . SUT.Parsed)
        }
        
        Test_ErrorMessage_equals_expected()
        {
            expected := "OddsMonkeyParser.Parse(): Expected 15 table columns, got 14"
            Yunit.assert(this.SUT.ErrorMessage == expected, "Error message was '" . this.SUT.ErrorMessage . "'")
        }

        Test_all_data_properties_should_be_blank()
        {
            msg = expected no value
            Yunit.assert(!this.SUT.TimeDate, msg)
            Yunit.assert(!this.SUT.Time, msg)
            Yunit.assert(!this.SUT.Selection, msg)
            Yunit.assert(!this.SUT.Event, msg)
            Yunit.assert(!this.SUT.Bookie, msg)
            Yunit.assert(!this.SUT.BackOdds, msg)
            Yunit.assert(!this.SUT.Exchange, msg)
            Yunit.assert(!this.SUT.LayOdds, msg)
            Yunit.assert(!this.SUT.Liquidity, msg)
        }
    }   
}
