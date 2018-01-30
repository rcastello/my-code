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
    
## We need to make a callable ==> class
## Doing a class for the memoizer and implementing its callabale "()" 
## Exploiting the fact that functions ARE OBJECTS in python

    ## the constructor has a callable in input and the two bits
    ## of informations are carried out in the constructor
    
class memo:
        
    def __init__(self,fn): 
        self._dict = {}
        self._fn = fn
       
        ## the __call__ is "()", a.k.a. the instance and it accepts only arguments    
    
    def __call__(self, *args):
        
        ## if include **keywds, these would be immutable, but i
        ## can only pass mutable --> tuple args 
        #  I want to ask if the values have been already used
        #  args is unpacked bcs im not in an argument of a function
        
        if args in self._dict: return self._dict[args]
        
        # otherwise store and return the calculated value
        
        self._dict[args] = self._fn(*args)
        return self._dict[args]
    
    
## iterative fib
        
def fibi(n):
    c,p = 1,1
    while n>1:
        c,p = c + p, c
        n-=1
    return c

## iterative recursive fib
    
def fibir(n, c=1, p=1):
    if n>1:
        return fibir(n-1, c+p, c)
    return c