SET browser="C:\Program Files (x86)\Google\Chrome\Application" chrome.exe

EXPLORER "%_MbDir%"
START python "%_MbDir%\recreate_MBHotKeys_files.py"
START python "%_MbDir%\oddsmonkeycopytextparse.py"
@REM START python "%_MbDir%\_OddsMonkey (SkyBet £10 Q Alert)"
START /d %browser% "https://smarkets.com/sport/horse-racing/" "http://www.betdaq.com/UI/?siteTab=exchange" "http://sports.betfair.com/horse-racing/"
@REM START /d %browser% "https://www.skybet.com/horse-racing" "https://odds.betsafe.com/en/"
@REM START /d %browser% "http://www.freebets4all.com/automatcher/"
START /d "%_MbDir%" MBHotkeys.ahk
START /d "%_MbDir%" Ultimatcher3.08.xls
@REM START /d "%_MbDir%" CalcConsecutiveMultipleLays.xlsm
@REM pause