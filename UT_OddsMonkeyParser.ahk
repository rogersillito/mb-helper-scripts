#Include <Yunit\Yunit>
#Include <Yunit\Window>
#Include <Yunit\StdOut>

#Include OddsMonkeyParser.ahk

Yunit.Use(YunitStdOut, YunitWindow).Test(OddsMonkeyParserTestSuite)

class OddsMonkeyParserTestSuite
{
    Begin()
    {
        this.ValidRow := "31/08/2014 13:30:00		Aston Villa v Hull	1-0	Correct Score	106.95		<b>LADBROKES</b><br /><br />UP TO £100 FREE BET (CODE F50)<br /><br />	Direct link to event on Bookmaker website	8.5	<b>BETFAIR</b><br /><br />£20 FREE BET PLUS UPTO £1000 CASHBACK<br /><br />	Direct link to event on Exchange website	7.6	£208	1.8"
        ; invalid - no event column
        this.InvalidRow := "31/08/2014 13:30:00		1-0	Correct Score	106.95		<b>LADBROKES</b><br /><br />UP TO £100 FREE BET (CODE F50)<br /><br />	Direct link to event on Bookmaker website	8.5	<b>BETFAIR</b><br /><br />£20 FREE BET PLUS UPTO £1000 CASHBACK<br /><br />	Direct link to event on Exchange website	7.6	£208	1.8"
        this.SUT := new OddsMonkeyParser()
    }

    Test_Parsed_is_false_when_row_is_invalid()
    {
        ;this.SUT.Parse(this.InvalidRow)
        ;throw Exception("rubbish")
        Yunit.assert(this.SUT.Parsed != 0, "SUT.Parsed = " . SUT.Parsed)
    }
    
    Test_ErrorMessage_equals_expected_when_row_is_invalid()
    {
        this.SUT.Parse(this.InvalidRow)
        Yunit.assert(this.SUT.ErrorMessage == "rubbish")
    }
}
