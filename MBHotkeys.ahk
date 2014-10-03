;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;
#SingleInstance Force
#Include OddsMonkeyCopier.ahk
#Include OddsMonkeyParser.ahk
#Include BettingSiteMappings.ahk

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode, Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir, %A_ScriptDir%  ; Ensures a consistent starting directory.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Excel cell references
CalcMulti_Event      := "AA3:AH3"
CalcMulti_BookieSide := "AA6:AH6"
CalcMulti_BetLabel   := "R3:Z3"
CalcMulti_Bookie     := "G4:G9"
CalcMulti_BackOdds   := "I4:I6"
CalcMulti_BackOvOdds := "I7:I9"
CalcMulti_BackStake  := "J4:K9"
CalcMulti_BetType    := "R15:X15"
CalcMulti_BackEvent1 := "D4"
CalcMulti_BackEvent2 := "D5"
CalcMulti_BackEvent3 := "D6"
CalcMulti_BackEvent4 := "D7"
CalcMulti_BackEvent5 := "D8"
CalcMulti_BackEvent6 := "D9"
CalcMulti_BackOutcm1 := "E4"
CalcMulti_BackOutcm2 := "E5"
CalcMulti_BackOutcm3 := "E6"
CalcMulti_BackOutcm4 := "E7"
CalcMulti_BackOutcm5 := "E8"
CalcMulti_BackOutcm6 := "E9"
CalcMulti_BackLgOdd1 := "F4"
CalcMulti_BackLgOdd2 := "F5"
CalcMulti_BackLgOdd3 := "F6"
CalcMulti_BackLgOdd4 := "F7"
CalcMulti_BackLgOdd5 := "F8"
CalcMulti_BackLgOdd6 := "F9"
CalcMulti_Match1     := "AA13:AH13"
CalcMulti_Match2     := "AA14:AA14"
CalcMulti_Match3     := "AA15:AA15"
CalcMulti_Match4     := "AA16:AA16"
CalcMulti_Match5     := "AA17:AA17"
CalcMulti_Match6     := "AA18:AA18"
CalcMulti_Date1      := "C4"
CalcMulti_Date2      := "C5"
CalcMulti_Date3      := "C6"
CalcMulti_Date4      := "C7"
CalcMulti_Date5      := "C8"
CalcMulti_Date6      := "C9"
CalcMulti_Exchange1  := "G13"
CalcMulti_Exchange2  := "G14"
CalcMulti_Exchange3  := "G15"
CalcMulti_Exchange4  := "G16"
CalcMulti_Exchange5  := "G17"
CalcMulti_Exchange6  := "G18"
CalcMulti_Comm1      := "H13"
CalcMulti_Comm2      := "H14"
CalcMulti_Comm3      := "H15"
CalcMulti_Comm4      := "H16"
CalcMulti_Comm5      := "H17"
CalcMulti_Comm6      := "H18"
CalcMulti_LayOdds1   := "F13"
CalcMulti_LayOdds2   := "F14"
CalcMulti_LayOdds3   := "F15"
CalcMulti_LayOdds4   := "F16"
CalcMulti_LayOdds5   := "F17"
CalcMulti_LayOdds6   := "F18"
CalcMulti_LayStake1  := "J13"
CalcMulti_LayStake2  := "J14"
CalcMulti_LayStake3  := "J15"
CalcMulti_LayStake4  := "J16"
CalcMulti_LayStake5  := "J17"
CalcMulti_LayStake6  := "J18"
CalcMulti_LayOvStk1  := "K13"
CalcMulti_LayOvStk2  := "K14"
CalcMulti_LayOvStk3  := "K15"
CalcMulti_LayOvStk4  := "K16"
CalcMulti_LayOvStk5  := "K17"
CalcMulti_LayOvStk6  := "K18"

Ultimatch_Event      := "F3:N3"
Ultimatch_BookieSide := "F5:N5"
Ultimatch_MatchSide  := "F7:N7"
Ultimatch_BetLabel   := "T3:U3"
Ultimatch_BetType    := "E11"
Ultimatch_Date       := "E3"
Ultimatch_Bookie     := "E13"
Ultimatch_BackOdds   := "E18"
Ultimatch_BackStake  := "E15"
Ultimatch_Exchange   := "M13"
Ultimatch_LayOdds    := "M18"
Ultimatch_LayStake   := "M16"
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Exchange commission
Commission_Betfair   := .05
Commission_Betdaq    := .03
Commission_Smarkets  := .02
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Delay (ms) between executing key sends
KeyDelay = 400
;LongerDelay = 350
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

<^>!c:: 
    SetDefaults()
    CopyMultipleToUltimatcher()
Return

;<^>!y::
;    For Book in ComObjActive("Excel.Application").Workbooks
;    {
;       bn := Book.name
;       ;If InStr(Book.name,"Ultimatcher")
;       MsgBox, Found %bn%
;       Book.Select
;    }
;Return

<^>!x::
    SetTitleMatchMode, 2
    win := "Ultimatcher3.08.xls"
    IfWinExist %win%
    {
        MsgBox, %win%
        WinActivate
        WinMaximize
    }
    else
    {
        MsgBox, UltiMatcher is not open
    }
Return

<^>!l:: 
    SetDefaults()
    target := "Ultimatcher"
    preselectBookie := "_K Ladbrokes"
    preselectExchange := "Smarkets"
    preselectLabel := "Ladbrokes 100 FREE"
    preselectBackStake := "100"
    preselectBetType := "Free SNR"
    Gosub, CopyOddsMonkey
Return

<^>!9:: 
    SetDefaults()
    target := "CalcConsecutiveMultipleLays"
    preselectBookie := "_K Ladbrokes"
    preselectExchange := "Smarkets"
    preselectLabel := "Ladbrokes 5 Q"
    preselectBackStake := "10"
    preselectLeg := "1"
    preselectBetType := "Qualifier/Arb"
    Gosub, CopyOddsMonkey
Return

<^>!1:: 
    SetDefaults()
    target := "Ultimatcher"
    preselectBookie := "Ladbrokes"
    preselectExchange := "Betfair"
    preselectLabel := "Lad Donc123 Q"
    preselectBackStake := "10"
    preselectBetType := "Qualifier"
    Gosub, CopyOddsMonkey
Return

<^>!2:: 
    SetDefaults()
    target := "Ultimatcher"
    preselectBookie := "Coral"
    preselectExchange := "Betfair"
    preselectLabel := "Coral 50 Q"
    preselectBackStake := "50"
    preselectBetType := "Qualifier"
    Gosub, CopyOddsMonkey
Return

<^>!3:: 
    SetDefaults()
    target := "Ultimatcher"
    preselectBookie := "Coral"
    preselectExchange := "Betfair"
    preselectLabel := "Coral 50 FREE"
    preselectBackStake := "50"
    preselectBetType := "Free SNR"
    Gosub, CopyOddsMonkey
Return

<^>!s:: 
    SetDefaults()
    target := "Ultimatcher"
    preselectBookie := "Skybet"
    preselectExchange := "Smarkets"
    preselectLabel := "Skybet Loyalty Q"
    preselectBackStake := "25"
    preselectBetType := "Qualifier"
    Gosub, CopyOddsMonkey
Return

<^>!0:: 
    SetDefaults()
    target := "CalcConsecutiveMultipleLays"
    preselectBookie := "SkyBet"
    preselectExchange := "Smarkets"
    preselectLabel := "SkyBet Loyalty FREE"
    preselectBackStake := "5"
    preselectLeg := "1"
    preselectBetType := "Free SNR"
    Gosub, CopyOddsMonkey
Return

<^>!f:: 
    SetDefaults()
    target := "Ultimatcher"
    preselectBookie := "Skybet"
    preselectExchange := "Smarkets"
    preselectLabel := "Skybet Loyalty FREE"
    preselectBackStake := "5"
    preselectBetType := "Free SNR"
    Gosub, CopyOddsMonkey
Return

<^>!a:: 
    SetDefaults()
    target := "Ultimatcher"
    preselectBookie := ""
    preselectExchange := "Smarkets"
    preselectLabel := "ARB"
    preselectBackStake := "20"
    preselectBetType := "Arb"
    Gosub, CopyOddsMonkey
Return
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

CopyOddsMonkey:
    try
    {
       Gosub, DoOddsMonkeyFromClipboard
    }
    catch e
    {
        MsgBox ERROR: %e%
    }
Return

DoOddsMonkeyFromClipboard:
    OutputSpreadsheet = %target%
    IfWinExist, Odds Search
    {
        WinActivate
        om_row := SendCtrlCGetClipboardContents()
        ;;; WinActivate %target%
        ;;; MsgBox %om_row%
        if (target == "Ultimatcher") {
            Gosub, ShowOddsMonkeyGui_UM
        }
        if (target == "CalcConsecutiveMultipleLays") {
            Gosub, ShowOddsMonkeyGui_CMCL
        }
    }
    else
    {
        MsgBox, OddsMonkey Odds Search is not open
    }
Return

ShowOddsMonkeyGui_UM:
    Gui, Destroy
    Gui, Add, Text, w80, Bookie:
    Gui, Add, Text, w80, Exchange:
    Gui, Add, Text, w80, Label:
    Gui, Add, Text, w80, Back stake £:
    Gui, Add, Text, w80, Bet type:
    Gosub, BookieDropDowns
    UM_bettypeDropDownList := "Qualifier|Arb|Free SNR|Free SR"
    bettypesPreselected := Preselect_DDList_item(UM_bettypeDropDownList, preselectBetType)
    Gui, Add, DropDownList, w190 vbettype, %bettypesPreselected%
    Gui, Add, Button, default w60, Copy ; => label ButtonCopy
    Gui, -MinimizeBox -MaximizeBox
    Gui, Show, w300, Oddsmonkey to %target%
Return

ShowOddsMonkeyGui_CMCL:
    Gui, Destroy
    Gui, Add, Text, w80, Bookie:
    Gui, Add, Text, w80, Exchange:
    Gui, Add, Text, w80, Label:
    Gui, Add, Text, w80, Back stake £:
    Gui, Add, Text, w80, Leg:
    Gui, Add, Text, w80, Bet type:
    Gosub, BookieDropDowns
    Gui, Add, DropDownList, w190 vleginput, 1||2|3|4|5|6
    CMCL_bettypeDropDownList := "Qualifier/Arb|Free SNR|Free SR"
    bettypesPreselected := Preselect_DDList_item(CMCL_bettypeDropDownList, preselectBetType)
    Gui, Add, DropDownList, w190 vbettype, %bettypesPreselected%
    Gui, Add, Button, default w60, Copy ; => label ButtonCopy
    Gui, -MinimizeBox -MaximizeBox
    Gui, Show, w300, Oddsmonkey to %target%
Return

BookieDropDowns:
    FileRead, bookieDropDownList, MBHotkey_bookies.txt
    bookiesPreselected := Preselect_DDList_item(bookieDropDownList, preselectBookie)
    Gui, Add, DropDownList, w190 vbookie ym, %bookiesPreselected%  ; The ym option starts a new column of controls.
    FileRead, exchangeDropDownList, MBHotkey_exchanges.txt
    exchangesPreselected := Preselect_DDList_item(exchangeDropDownList, preselectExchange)
    Gui, Add, DropDownList, w190 vexchange, %exchangesPreselected%
    labelDropDownList := ""
    Loop, READ, MBHotkey_labels.txt
       labelDropDownList .=   "|" A_LoopReadLine
    labelsPreselected := Preselect_DDList_item(labelDropDownList, preselectLabel)
    Gui, Add, DropDownList, w190 vlabel, %labelsPreselected%
    Gui, Add, Edit, w190 vbackstakeinput, %preselectBackStake%
Return

GuiClose:
GuiEscape:
    Gui, Destroy
Return

ButtonCopy:
    Gui, Submit
    parser := new OddsMonkeyParser(BettingSiteMappings)
    parser.Parse(om_row) 
    if (!parser.Parsed) {
        MsgBox % "Could not parse OddsMonkey row: " . parser.ErrorMessage
        return
    }
    date := parser.TimeDate
    event := parser.Event
    bet := parser.Selection
    backodds := parser.BackOdds
    layodds := parser.LayOdds 
    if (OutputSpreadsheet == "Ultimatcher") {
        WriteOmRowToUltimatcher(backstakeinput, date, event, bet, bookie, backodds, exchange, layodds, label, bettype)
    }
    if (OutputSpreadsheet == "CalcConsecutiveMultipleLays") {
        WriteOmRowToCalcMulti(leginput, backstakeinput, date, event, bet, bookie, backodds, exchange, layodds, label, bettype)
    }
Return

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#Include %A_ScriptDir%
#Include bookie_url_lookup.ahk

SetDefaults()
{
    SetKeyDelay, 100
    SetTitleMatchMode, 2
}

Preselect_DDList_item(listitems, selectitem)
{
    selectSuffix := "||"
    repl := selectitem . selectSuffix
    StringReplace, newlistitems, listitems, %selectitem%, %repl%, All
    tooManyPipes := "|||"
    StringReplace, newlistitems2, newlistitems, %tooManyPipes%, %selectSuffix%, All
    Return newlistitems2
}

get_oddsmonkey_parsed(parsed, byref STATUS, byref error, byref date, byref event, byref bet, byref backodds, byref layodds)
{
    ; STATUS|date|event|bet|backodds|layodds
    StringSplit, Splitted, parsed, |
    STATUS := Splitted1
    if (STATUS == "ERROR") {
        error := Splitted2
    } else {
        date := Splitted2
        event := Splitted3
        bet := Splitted4
        backodds := Splitted5
        layodds := Splitted6
    }
    Return
}

WriteOmRowToUltimatcher(backstakeinput, date, event, bet, bookie, backodds, exchange, layodds, label, bettype)
{
    global
    SetTitleMatchMode, 2
    wintitle := "Ultimatcher3.08.xls"
    IfWinExist, %wintitle%
    {
        WinActivate
        MsgBox, Press Enter to paste
        SetCellValue(Ultimatch_Event, event)
        SetCellValue(Ultimatch_BookieSide, bet)
        SetCellValue(Ultimatch_MatchSide, bet)
        SetCellValue(Ultimatch_BetType, bettype)
        SetCellValue(Ultimatch_BetLabel, label)
        SetCellValue(Ultimatch_Date, date)
        SetCellValue(Ultimatch_Bookie, bookie)
        SetCellValue(Ultimatch_BackOdds, backodds)
        SetCellValue(Ultimatch_Exchange, exchange)
        SetCellValue(Ultimatch_LayOdds, layodds)
        SetCellValue(Ultimatch_BackStake, backstakeinput)
        GoToCell(Ultimatch_BackStake)
    }
    else
    {
        MsgBox, %wintitle% is not open
    }
}

WriteOmRowToCalcMulti(Leg, backstakeinput, date, event, bet, bookie, backodds, exchange, layodds, label, bettype)
{
    global
    IfWinExist, CalcConsecutiveMultipleLays
    {
        WinActivate
        MsgBox, Press Enter to paste
        GoToCell(CalcMulti_Bookie)
        if (Leg == "1") {
            SetCellValue(CalcMulti_Bookie, bookie)
            SetCellValue(CalcMulti_BetLabel, label)
        }
        if (backstakeinput != "") {
            SetCellValue(CalcMulti_BackStake, backstakeinput)
        }
        SetCellValue(CalcMulti_BackOvOdds, "")
        SetCellValue(CalcMulti_Date%Leg%, date)
        SetCellValue(CalcMulti_BackEvent%Leg%, event)
        SetCellValue(CalcMulti_BackOutcm%Leg%, bet)
        SetCellValue(CalcMulti_Bookie%Leg%, bookie)
        SetCellValue(CalcMulti_BackLgOdd%Leg%, backodds)
        SetCellValue(CalcMulti_Exchange%Leg%, exchange)
        SetCellValue(CalcMulti_LayOdds%Leg%, layodds)
        SetCellValue(CalcMulti_Comm%Leg%, Commission_%exchange%)
        SetCellValue(CalcMulti_LayOvStk%Leg%, "")
        SetCellValue(CalcMulti_BetType, bettype)
        GoToCell(CalcMulti_LayOvStk1)
    }
    else
    {
        MsgBox, UltiMatcher is not open
    }
}

CopyMultipleToUltimatcher()
{
    global
    IfWinExist, CalcConsecutiveMultipleLays
    {
        WinActivate
        InputBox, Leg, Copy Multiple leg to Ultimatcher, Enter leg number to copy, , , 140, , , , , 1
        if ErrorLevel
            Return
        Leg := RegExReplace(Leg, "[^1-6]", "")
        if (Leg = "") {
            MsgBox, Leg must be a numeric value between 1 and 6
            Return
        }
        
        betTypeVal := GetCellValue(CalcMulti_BetType)
        if (betTypeVal == "Qualifier/Arb") {
            betTypeVal := "Qualifier"
        }
        eventVal := GetCellValue(CalcMulti_Event)
        betLabelVal := GetCellValue(CalcMulti_BetLabel)
        backOddsVal := ""
        if (Leg == "1") {
            bookieSideVal := GetCellValue(CalcMulti_BookieSide)
            bookieVal := GetCellValue(CalcMulti_Bookie)
            backStakeVal := GetCellValue(CalcMulti_BackStake)
            backOddsVal := GetCellValue(CalcMulti_BackOvOdds)
            backOddsVal := RegExReplace(backOddsVal, "[£\r\n ]", "")
            if (backOddsVal == "") {
                backOddsVal := GetLockedCellValue(CalcMulti_BackOdds)
            }
        } else {
            bookieSideVal := ""
            bookieVal := ""
            backStakeVal := ""
            betTypeVal := "Qualifier" ; follow-up lay legs always calculated as Qualifiers
        }
        matchSideVal := GetCellValue(CalcMulti_Match%Leg%)
        dateVal := GetCellValue(CalcMulti_Date%Leg%)
        exchangeVal := GetCellValue(CalcMulti_Exchange%Leg%)
        layOddsVal := GetCellValue(CalcMulti_LayOdds%Leg%)
        layStakeVal := ""
        layStakeVal := GetCellValue(CalcMulti_LayOvStk%Leg%)
        layStakeVal := RegExReplace(layStakeVal, "[£\r\n ]", "")
        if (layStakeVal == "") {
            layStakeVal := GetLockedCellValue(CalcMulti_LayStake%Leg%)
            layStakeVal := RegExReplace(layStakeVal, "[£\r\n]", "")
        }
        
        ;;; MsgBox %eventVal% %betLabelVal% %bookieSideVal% %betTypeVal% %bookieVal% %backOddsVal% %backStakeVal% %matchSideVal% %dateVal% %exchangeVal% %layOddsVal% %layStakeVal%
        
        IfWinExist, Ultimatcher
        {
            WinActivate
            MsgBox, Press Enter to paste
            SetCellValue(Ultimatch_Event, eventVal)
            SetCellValue(Ultimatch_BookieSide, bookieSideVal)
            SetCellValue(Ultimatch_MatchSide, matchSideVal)
            SetCellValue(Ultimatch_BetType, betTypeVal)
            SetCellValue(Ultimatch_BetLabel, betLabelVal)
            SetCellValue(Ultimatch_Date, dateVal)
            SetCellValue(Ultimatch_Bookie, bookieVal)
            SetCellValue(Ultimatch_BackOdds, backOddsVal)
            SetCellValue(Ultimatch_BackStake, backStakeVal)
            SetCellValue(Ultimatch_Exchange, exchangeVal)
            SetCellValue(Ultimatch_LayOdds, layOddsVal)
            SetCellValue(Ultimatch_LayStake, layStakeVal)
        }
        else
        {
            MsgBox, UltiMatcher is not open
        }
    }
    else
    {
        MsgBox, CalcConsecutiveMultipleLays is not open
    }
    Return
}

TrimLeftAndRight(input, leftCount, rightCount)
{
    StringTrimLeft, trimmed, input, leftCount
    StringTrimRight, trimmed, trimmed, rightCount
    return trimmed
}

SendCtrlCGetClipboardContents()
{
    SetKeyDelay, 100
    clipboardWait_s := 5
    ClipSaved := ClipboardAll
    clipboard = ; Empty
    Send, ^c
    ClipWait, %clipboardWait_s%
    if ErrorLevel
    {
        MsgBox, Aborting: could not get clipboard contents after %clipboardWait_s% seconds.
        return
    }
    outval := clipboard
    clipboard := ClipSaved
    ClipSaved = ; Clear
    return outval
}

GetLockedCellValue(range, window = "")
{
    SetKeyDelay, 100
    UnlockActiveSheet()
    Send, ^g
    Send, %range%
    Send, {Enter}
    value := SendCtrlCGetClipboardContents()
    send, {F2}
    Sleep, 150
    send, {Enter}
    return value
}

GetCellValue(range, window = "")
{
    SetKeyDelay, 100
    Send, ^g
    Send, %range%
    Send, {Enter}
    Send, {F2}
    Send, {End}
    Send, ^+{Home}
    value := SendCtrlCGetClipboardContents()
    Send, {Esc}
    Return %value%
}

SetCellValue(range, value)
{
    SetKeyDelay, 100
    Send, ^g
    Send, %range%
    Send, {Enter}
    Send, {Del}
    Send, {F2}
    Send, %value%
    Send, {Enter}
    Return
}

UnlockActiveSheet()
{
    SetKeyDelay, 100
    Send, !r
    Send, !ps
    return
}

LockActiveSheet()
{
    SetKeyDelay, 100
    UnlockActiveSheet()
    send, {Enter}
    return
}

GoToCell(range)
{
    SetKeyDelay, 100
    Send, ^g
    Send, %range%
    Send, {Enter}
    Return
}

GetCellValueInWindow(window, range)
{
  IfWinExist, %window%
  {
      WinActivate
      val := GetCellValue(range)
      Return val
  }
  else
  {
      MsgBox, %window% is not open
  }
}

SetCellValueInWindow(window, range, value)
{
  IfWinExist, %window%
  {
      WinActivate
      SetCellValue(range, value)
      Return
  }
  else
  {
      MsgBox, %window% is not open
  }
}
