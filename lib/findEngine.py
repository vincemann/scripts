#!/usr/bin/python
import subprocess
from subprocess import check_output

#give me search words and I find files/dirs that user can select from
#if there is only one result, user is not questioned
def findAndSelect(words,file=True):
    search="*";
    for word in words:
        search=search+word+"*";
    print("searchString: %s" % search);
    #print("search string: %s" % search);
    searchProgram=None;
    if file is True:
        print("searching for a file")
        searchProgram="findGlobal";
    else:
        print("searching for a dir")
        searchProgram="find / -type d -ipath";
    p = subprocess.Popen("%s \"%s\"" % (searchProgram,search),shell=True, stdout=subprocess.PIPE)
    out, err = p.communicate()
    #print("results:");
    #print(out);
    formattedOut=out.splitlines();
    
    finalResults = {};
    index = 0;
    for r in formattedOut:
        if r and (not r.isspace()):
            #print("actual result: %s" % r);
            finalResults[index]=r;
            index=index+1;

    print("items:\n")
    for item in finalResults.items():
        print(item);
    selected=None;
    if len(finalResults) is 1:
        selected = finalResults[0]
    else:
        selectedIndex = input("select item index\n");
        selected = finalResults[selectedIndex];
    return selected;
