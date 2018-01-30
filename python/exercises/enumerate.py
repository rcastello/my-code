#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Thu Dec 14 16:00:01 2017

@author: trn2306
"""

## it has 
def genumerate(iterable,start=0):
    count = start
    for item in iterable:
        yield count, item   #next()
        count +=1


from itertools import count, izip

def ienumerate(iterable, start=0):
    return izip(count(start=start), iterable)

class cenumerate:
    
    def __init__(self,iterable, start =0):
        self._iterable = iter(iterable) ## taking the iterator of an iterable
        self._count = start-1
        
    def __iter__(self):
        return self
    
    def next(self,):
        self._count +=1
        return self._count,next(self._iter)
        