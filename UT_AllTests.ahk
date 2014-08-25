#Include <Yunit\Yunit>
#Include <Yunit\Window>
#Include <Yunit\StdOut>

#Include UT_OddsMonkeyParser.ahk

Yunit.Use(YunitStdOut, YunitWindow).Test(OddsMonkeyParserTestSuite)
