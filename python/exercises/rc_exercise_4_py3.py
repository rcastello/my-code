#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Dec 12 13:36:40 2017

@author: trn2306
"""

# Exercise without using cmp()

data = []

# since I cannot pass more than 1 argument, I have to do a factory of functions

def my_key_factory(ncol):
   # lexical closure: it grabs something external
    def my_key(pair):
        return pair[ncol]
    return my_key

with open('/etc/passwd') as pwds:
    for line in pwds:
        #unpacking
        username, _ , userid, _  =line.split(':',3)
        data.append((username,int(userid))) # filling with tuples
        
print(sorted(data,key=my_key_factory(1))) #interested in the functiuon itself, 
## not in the result! 