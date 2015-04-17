#Include <Yunit\Yunit>
#Include <Yunit\Window>
#Include <Yunit\StdOut>

#Include OddsMonkeyParser.ahk

class OddsMonkeyParserTests
{
    class When_row_is_valid
    {
        static Row := "31/08/2014 13:30:00		Aston Villa v Hull	1-0	Correct Score	106.95		 	Ladbrokes	Direct link to event on Bookmaker website	8.5	 	Betfair	Direct link to event on Exchange website	7.6	£208	1.8"

        Begin()
        {
            bettingSites := [{oMName: "LADBROKES", uMNames:["_A Ladbrokes", "_B Ladbrokes"]}, {oMName: "BETFAIR", uMNames:["Betfair"]}]
            this.SUT := new OddsMonkeyParser(bettingSites)
            this.SUT.Parse(OddsMonkeyParserTests.When_row_is_valid.Row)
        }

        End()
        {
            this.remove("SUT")
        }

        Parsed_is_true_when_row_is_valid()
        {
            Yunit.assert(this.SUT.Parsed, "SUT.Parsed = false")
        }
        
        ErrorMessage_equals_empty_string()
        {
            Yunit.assert(this.SUT.ErrorMessage == "", "Error message was '" . this.SUT.ErrorMessage . "'")
        }

        TimeDate_property_is_set()
        {
            Yunit.assert(this.SUT.TimeDate == "31/08/2014 13:30:00", "TimeDate is '" . this.SUT.TimeDate . "'")
        }

        Time_property_is_set()
        {
            Yunit.assert(this.SUT.Time == "13:30", "Time is '" . this.SUT.Time . "'")
        }

        Liquidity_property_is_set()
        {
            Yunit.assert(this.SUT.Liquidity == "208", "Liquidity is '" . this.SUT.Liquidity . "'")
        }

        LayOdds_property_is_set()
        {
            Yunit.assert(this.SUT.LayOdds == "7.6", "LayOdds is '" . this.SUT.LayOdds . "'")
        }

        BackOdds_property_is_set()
        {
            Yunit.assert(this.SUT.BackOdds == "8.5", "BackOdds is '" . this.SUT.BackOdds . "'")
        }

        Selection_property_is_set()
        {
            Yunit.assert(this.SUT.Selection == "1-0", "Selection is '" . this.SUT.Selection . "'")
        }

        Event_property_is_set()
        {
            Yunit.assert(this.SUT.Event == "Aston Villa v Hull", "Event is '" . this.SUT.Event . "'")
        }

        Bookies_property_is_set_with_the_uMName_values_from_bettingSites()
        {
            Yunit.assert(this.SUT.Bookies.MaxIndex() == 2, "Bookies list length is '" . this.SUT.Bookies.MaxIndex() . "'")
            Yunit.assert(this.SUT.Bookies[1] == "_A Ladbrokes", "Bookies uMName 1 is '" . this.SUT.Bookies[1] . "'")
            Yunit.assert(this.SUT.Bookies[2] == "_B Ladbrokes", "Bookies uMName 2 is '" . this.SUT.Bookies[2] . "'")
        }

        Exchanges_property_is_set_with_the_uMName_values_from_bettingSites()
        {
            Yunit.assert(this.SUT.Exchanges.MaxIndex() == 1, "Exchanges list length is '" . this.SUT.Exchanges.MaxIndex() . "'")
            Yunit.assert(this.SUT.Exchanges[1] == "Betfair", "Exchanges uMName 1 is '" . this.SUT.Exchanges[1] . "'")
        }

        class And_betting_sites_list_does_not_contain_an_entry_for_bookie
        {
            Begin()
            {
                bettingSites := [{oMName: "BETFAIR", uMNames:["Betfair"]}]
                this.SUT := new OddsMonkeyParser(bettingSites)
                this.SUT.Parse(OddsMonkeyParserTests.When_row_is_valid.Row)
            }

            Bookies_property_is_not_set()
            {
                msg = expected no value
                Yunit.assert(!this.SUT.Bookies, msg)
            }

            Exchanges_property_is_set_with_the_uMName_values()
            {
                Yunit.assert(this.SUT.Exchanges.MaxIndex() == 1, "Exchanges list length is '" . this.SUT.Exchanges.MaxIndex() . "'")
                Yunit.assert(this.SUT.Exchanges[1] == "Betfair", "Exchanges uMName 1 is '" . this.SUT.Exchanges[1] . "'")
            }

            Parsed_is_false()
            {
                Yunit.assert(!this.SUT.Parsed, "SUT.Parsed = true")
            }
            
            ErrorMessage_equals_expected()
            {
                expected := "OddsMonkeyParser.GetMappedUMNamesFor(): No entry found in bettingSites list for 'LADBROKES'"
                Yunit.assert(this.SUT.ErrorMessage == expected, "Error message was '" . this.SUT.ErrorMessage . "'")
            }
        }

        class And_betting_sites_list_does_not_contain_an_entry_for_exchange
        {
            Begin()
            {
                bettingSites := [{oMName: "LADBROKES", uMNames:["_A Ladbrokes", "_B Ladbrokes"]}]
                this.SUT := new OddsMonkeyParser(bettingSites)
                this.SUT.Parse(OddsMonkeyParserTests.When_row_is_valid.Row)
            }

            Exchanges_property_is_not_set()
            {
                msg = expected no value
                Yunit.assert(!this.SUT.Exchanges, msg)
            }

            Bookies_property_is_set_with_the_uMName_values()
            {
                Yunit.assert(this.SUT.Bookies.MaxIndex() == 2, "Bookies list length is '" . this.SUT.Bookies.MaxIndex() . "'")
                Yunit.assert(this.SUT.Bookies[1] == "_A Ladbrokes", "Bookies uMName 1 is '" . this.SUT.Bookies[1] . "'")
                Yunit.assert(this.SUT.Bookies[2] == "_B Ladbrokes", "Bookies uMName 2 is '" . this.SUT.Bookies[2] . "'")
            }

            Parsed_is_false()
            {
                Yunit.assert(!this.SUT.Parsed, "SUT.Parsed = true")
            }
            
            ErrorMessage_equals_expected()
            {
                expected := "OddsMonkeyParser.GetMappedUMNamesFor(): No entry found in bettingSites list for 'BETFAIR'"
                Yunit.assert(this.SUT.ErrorMessage == expected, "Error message was '" . this.SUT.ErrorMessage . "'")
            }
        }
    }   

    class When_row_is_invalid
    {
        ; invalid - no event column
        static Row := "31/08/2014 13:30:00		1-0	Correct Score	106.95		<b>LADBROKES</b><br /><br />UP TO £100 FREE BET (CODE F50)<br /><br />	Direct link to event on Bookmaker website	8.5	<b>BETFAIR</b><br /><br />£20 FREE BET PLUS UPTO £1000 CASHBACK<br /><br />	Direct link to event on Exchange website	7.6	£208	1.8"

        Begin()
        {
            this.SUT := new OddsMonkeyParser()
            this.SUT.Parse(OddsMonkeyParserTests.When_row_is_invalid.Row)
        }

        End()
        {
            this.remove("SUT")
        }

        Parsed_is_false()
        {
            Yunit.assert(!this.SUT.Parsed, "SUT.Parsed = true")
        }
        
        ErrorMessage_equals_expected()
        {
            expected := "OddsMonkeyParser.Parse(): Expected 17 table columns, got 14"
            Yunit.assert(this.SUT.ErrorMessage == expected, "Error message was '" . this.SUT.ErrorMessage . "'")
        }

        all_data_properties_should_be_blank()
        {
            msg = expected no value
            Yunit.assert(!this.SUT.TimeDate, msg)
            Yunit.assert(!this.SUT.Time, msg)
            Yunit.assert(!this.SUT.Selection, msg)
            Yunit.assert(!this.SUT.Event, msg)
            Yunit.assert(!this.SUT.Bookies, msg)
            Yunit.assert(!this.SUT.BackOdds, msg)
            Yunit.assert(!this.SUT.Exchanges, msg)
            Yunit.assert(!this.SUT.LayOdds, msg)
            Yunit.assert(!this.SUT.Liquidity, msg)
        }
    }   
}
