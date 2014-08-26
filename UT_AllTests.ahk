#Include <Yunit\Yunit>
#Include <Yunit\Window>
#Include <Yunit\StdOut>

#SingleInstance Force
#Include UT_OddsMonkeyParser.ahk

Yunit.Use(YunitStdOut, YunitWindow).Test(OddsMonkeyParserTests)
