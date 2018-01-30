#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Thu Dec 14 10:06:51 2017

@author: trn2306
"""

def fib(n):
    if n<2: return 1
    return fib(n-2)+fib(n-1)

## time function that can accept in input every type pf function

## pythonic implementation    

from time import time as tick

def time(fn, *args, **kwds):
    start = tick()
    result = fn(*args, **kwds) ## unpacking since fn takes any additional arguments
    stop = tick()
    return stop-start, result

# time(fib,35)

## computer science implementation
    
def time1(thunk):
    start = tick()
    result = thunk()
    stop =tick()
    return stop-start, result

# time(lambda:fib(35))

class memo:
    def __init__(self,fn):
        self._dict = {}
        self._fn = fn
        
    ## the call is "()" and it accepts only arguments    
    def __call__(self, *args):
        if(self._dict[self._fn]): return self._dict[self._fn]
        result = self._fn(*args) 
        self._dict[self._fn]= result        
        return result
