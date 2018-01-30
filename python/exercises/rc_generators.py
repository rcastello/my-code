#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Thu Dec 14 15:32:32 2017

@author: trn2306
"""

def gen_ints(start, stop):
    while start<stop:
        yield start   #next()
        start+=1
    return            #just for StopIteration NOT NEEDED

a = gen_ints(3,6)
for i in a: print i

## Fibonacci generating all the posssible number in the serie

def fibig():
    c,p = 1,1
    yield 1
    while True:
        yield c
        c,p = c + p, c

b = fibig()