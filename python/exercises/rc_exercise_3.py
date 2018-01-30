#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec 12 09:30:33 2017

@author: trn2306
"""

## create a dictionary out of the loop
data = {}

with open('/etc/passwd') as pwds:
    for line in pwds:
        #print(line)
        
        #unpacking
        username, _ , userid, _  =line.split(sep=':',maxsplit=3)
        data[int(userid)] = username # filling the dictionary

# BUT DICTIONARY CANNOT BE SORTED, so retrieving the keys (int) and sort 
# them with sorted (built in function)

for uid in sorted(data.keys()):
    print(uid,data[uid])         
        #username = splitline[0]
        #userid = splitline[2]
        
#    sorted(pwds,/,*,)    