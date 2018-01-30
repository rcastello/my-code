#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec 12 11:51:08 2017

@author: trn2306
"""

# Exercise without using cmp()

data = []

def my_key(pair):
    return pair[1]

with open('/etc/passwd') as pwds:
    for line in pwds:
        #unpacking
        username, _ , userid, _  =line.split(':',3)
        data.append((username,int(userid))) # filling with tuples
        
print(sorted(data,key=my_key)) #interested in the functiuon itself, 
## not in the result! 