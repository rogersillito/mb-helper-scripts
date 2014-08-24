exchanges = {}
exchanges["Betdaq"] = "http://www.betdaq.com/UI/?siteTab=exchange"
exchanges["_M Betfair"] = "http://www.betfair.com/"
exchanges["Betfair"] = "http://www.betfair.com/"
exchanges["Smarkets"] = "https://smarkets.com/"

bookies = {}
bookies["10Bet"] = "http://www.10bet.com/sports/soccer/"
bookies["188Bet"] = "http://www.188bet.com/en-gb/sports/football/select-competition/1x2"
bookies["_M 188Bet"] = "http://www.188bet.com/en-gb/sports/football/select-competition/1x2"
#bookies["888sport"] = "http://www.888sport.com/bet?action=go_football"
bookies["ApolloBet"] = "http://www.apollobet.com/apollobet?action=GoCategory&sport=Football"
#bookies["bar one racing"] = "http://www.baroneracing.ie/events/sports.asp?sportcode=H,h,o,a,%26"
#bookies["bet365"] = "http://www.bet365.com/home/FlashGen4/WebConsoleApp.asp"
bookies["Betfred"] = "http://www.betfred.com/sport"
#bookies["BetGun"] = "https://www.betgun.com/en/index.php"
#bookies["betinternet"] = "http://www.betinternet.com/en/Sports.bet"
bookies["betsafe"] = "https://odds.betsafe.com/en/"
#bookies["BetVictor"] = "http://www.betvictor.com/sports/en/horse-racing"
#bookies["Blue Square"] = "http://www.bluesq.com/bet?action=go_racing"
#bookies["Bodog"] = "http://sports.bodog.co.uk/football.htm"
bookies["Boylesports"] = "http://www.boylesports.com/Betting/HorseRacing?navigationid=top,21.1"
bookies["Bwin"] = "https://www.bwin.com/sportsbook.aspx"
bookies["Coral"] = "http://sports.coral.co.uk/football/"
bookies["_M Coral"] = "http://sports.coral.co.uk/football/"
bookies["ComeOn!"] = "https://www.comeon.com/gb/sports/"
bookies["DOXXbet"] = "https://www.doxxbet.com/en/sports-betting/"
bookies["Ladbrokes"] = "https://sports.ladbrokes.com/en-gb/"
bookies["_M Ladbrokes"] = "https://sports.ladbrokes.com/en-gb/"
bookies["_K Ladbrokes"] = "http://sportsbeta.ladbrokes.com/?view-odd=Decimal"
bookies["NordicBet"] = "http://www.nordicbet.com/eng/sportsbook"
bookies["_M Paddy Power"] = "http://www.paddypower.com/football/football-matches"
#bookies["redbet"] = "https://www.redbet.com/en/betting"
bookies["Skybet"] = "https://www.skybet.com/horse-racing"
#bookies["sportingbet"] = "http://www.sportingbet.com/"
#bookies["Stan James"] = "http://www.stanjames.com/"
bookies["unibet"] = "https://www.unibet.co.uk/betting"
bookies["William Hill"] = "http://sports.williamhill.com/bet/en-gb/betting/y/5/Football.html"

def write_file(contents, path):
    f = open(path, "w")
    f.write(contents)
    f.close()

def create_ahk_url_lookup_include_file():
    out = "url_lookup(bookie) {\n"
    for k in get_all_sorted_bookies():
        if exchanges.has_key(k):
            url = exchanges[k]
        else:
            url = bookies[k]
        out += "\tif (bookie == \"%s\") {\n" % k
        out += "\t\tReturn \"%s\"\n" % url.strip()
        out += "\t}\n"
    out += "}\n"
    write_file(out, "bookie_url_lookup.ahk")
    
    
def create_bookie_select_list_file():
    b = get_all_sorted_bookies()
    contents = "|".join(b)
    write_file(contents, "MBHotkey_bookies.txt")

def create_exchanges_select_list_file():
    e = get_all_sorted_bookies(True)
    contents = "|".join(e)
    write_file(contents, "MBHotkey_exchanges.txt")
    
def get_all_sorted_bookies(excludeBookies = False):
    bk = []
    if not excludeBookies:
        bk = bookies.keys()
    ek = exchanges.keys()
    all = bk + ek
    all.sort(key=str.lower)
    return all

if __name__ == "__main__":
    create_ahk_url_lookup_include_file()
    create_bookie_select_list_file()
    create_exchanges_select_list_file()
