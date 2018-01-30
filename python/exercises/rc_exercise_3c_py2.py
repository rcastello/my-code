# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

data = [] # list this time

## DECORATE/SORT/UNDECORATE

def my_cmp(pair1,pair2):
    return cmp(pair1[1],pair2[1])

with open('/etc/passwd') as pwds:
    for line in pwds:
        #unpacking
        username, _ , userid, _  =line.split(':',3)
        data.append((username,int(userid))) # filling with tuples
        
print sorted(data,cmp=my_cmp) #interested in the functiuon itself, 
## not in the result!