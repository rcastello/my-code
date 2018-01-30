#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec 12 11:06:59 2017

@author: trn2306
"""

## create a dictionary out of the loop
data = [] # list this time

with open('/etc/passwd') as pwds:
    for line in pwds:
        #unpacking
        username, _ , userid, _  =line.split(sep=':',maxsplit=3)
        data.append((int(userid),username)) # filling with tuples
        
print(sorted(data))
## the sorting is done on the first element of the tuple. if we put int is 
## is done for int, otherwise is done alphabetically for the username string
