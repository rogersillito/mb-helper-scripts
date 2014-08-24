# coding: latin-1
import difflib
import os, time, sys
import re, traceback

def parse_om_row(row, out_dict):
    row = row.strip()
    row = extract_date(row, out_dict)
    row = extract_event(row, out_dict)
    row = extract_bet(row, out_dict)
    row = extract_layodds(row, out_dict)
    row = extract_backodds(row, out_dict)
    #out_dict["row"] = row

def write_out_file(output):
    if len(sys.argv) > 1:
        f = open(sys.argv[1], "w")
        f.write(output)
        f.close()
    #f1 = open("H:/_ToBackup/Matched betting/_NOTES/_TEMP/pyout.txt", "w")
    #f1.write(output)
    #f1.close()
    
def get_env_vars():
    env_prefix = "oddsmonkey_"
    env_vars = ["row"]
    env = {}
    for ev in env_vars:
        if os.environ.has_key(env_prefix + ev):
            env[ev] = os.environ[env_prefix + ev]
        else:
            raise Exception, "%s environment variable must be set" % ev
    return env
    
def get_best_match(input, match_list):
    matches = difflib.get_close_matches(input, match_list, 1)
    if len(matches) != 1:
        raise Exception, ("failed to lookup match for '%s' in list: '%s'" % (input, "', '".join(match_list)))
    return matches[0]
    
def extract_date(row, out_dict):
    regex = r"^(\d{2}/\d{2}/\d{4} \d{2}:\d{2}:\d{2}).*"
    matches = findall_extract_element(regex, 'date', row, out_dict)
    out_dict["date"] = matches[0]
    return row.replace(out_dict["date"], "").strip()
    
def extract_event(row, out_dict):
    regex = r"^([^\t]+).*"
    matches = findall_extract_element(regex, 'event', row, out_dict)
    out_dict["event"] = matches[0]
    return row.replace(out_dict["event"], "").strip()
    
def extract_bet(row, out_dict):
    regex = r"^([^\t]+).*"
    matches = findall_extract_element(regex, 'bet', row, out_dict)
    bet = matches[0]
    correct_score_bet = re.match(r"\d[:-]\d", bet)
    if correct_score_bet is not None:
        bet = "Score " + bet
    out_dict["bet"] = bet
    return row.replace(out_dict["bet"], "").strip()
    
def extract_layodds(row, out_dict):
    regex = r"(Direct link to event on Exchange website)?\W+(\d+\.?\d*)\W+(£\d+\.?\d*)\W+(\d+\.?\d*)$"
    matches = re.search(regex, row)
    if matches is None:
        raise Exception, ("Failed to extract 'layodds' from string: '%s' [no match]" % row)
    match_groups = matches.groups()
    out_dict["layodds"] = matches.group(2)
    return row.replace(matches.group(0), "").strip()
    
def extract_backodds(row, out_dict):
    #TODO: just use a string split approach (with regex to check pattern of each token! much easier than all this + can be done easily in the ahk script
    bits = row.split('\t')
    backodds = bits[-2].strip()
    regex = r"^(\d+\.?\d*)$"
    if not re.match(regex, backodds):
        raise Exception, ("string.split: Failed to extract 'backodds' in expected format from string: '%s' [backodds value '%s', out_dict: %s]" % (row, backodds, out_dict))
    out_dict["backodds"] = backodds
    
def assemble_output_string(out_dict):
    # STATUS|date|event|bet|backodds|layodds
    o = "OK|%(date)s|%(event)s|%(bet)s|%(backodds)s|%(layodds)s" % out_dict
    return o

def findall_extract_element(regex, fieldname, row, out_dict):
    matches = re.findall(regex, row)
    if len(matches) == 0:
        raise Exception, ("re.findall: Failed to extract '%s' from string: '%s' [%s matches, out_dict: %s]" % (fieldname, row, len(matches), out_dict))
    return matches

# regex to get  match rating, bed odds and lay odds:
# \t(\d+\.?\d*)\t

#def search_extract_element(regex, fieldname, row):
#    matches = re.search(regex, row)
#    if matches is None:
#        raise Exception, ("re.search: Failed to extract '%s' from row: '%s' [no match]" % (fieldname, row, len(matches)))
#    if len(matches.groups())
#    return matches

if __name__ == "__main__":
    try:
        #raise Exception, "testing..."
        env = {}
        env = get_env_vars()
        out = {}
        parse_om_row(env["row"], out)
        out_string = assemble_output_string(out)
        write_out_file(out_string)
        
    except Exception, ex:
        tb = traceback.format_exc() 
        row = ""
        if env.has_key('row'):
            row += "\n\nENV ROW:<<%s>>" % env['row']
        write_out_file("ERROR|\n\n%s%s" % (tb, row))
