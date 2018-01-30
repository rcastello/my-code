#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue Dec 12 13:22:24 2017

@author: trn2306
"""

data = [] # list this time
#n = 0
## DECORATE/SORT/UNDECORATE

def factory_mycmp(coln):
    def my_cmp(pair1,pair2):
        return cmp(pair1[coln],pair2[coln])
    return my_cmp

with open('/etc/passwd') as pwds:
    for line in pwds:
        #unpacking
        username, _ , userid, _  =line.split(':',3)
        data.append((username,int(userid))) # filling with tuples
        
print sorted(data,cmp=factory_mycmp(1)) #interested in the functiuon itself, 
## not in the result!