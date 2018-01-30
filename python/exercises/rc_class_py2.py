#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Wed Dec 13 11:00:56 2017

@author: trn2306
"""

class Counter:
    def __init__(self,start):
        #print dir(self)
        self.count = start ## we stack count on the istance
        #print dir(self)
    
    def up(self, n=1):
        self.count += n
    
    def down(self, n=1):
        self.count -= n
        
class Addcounter(Counter):
    
    # another way to represnt the object overwriting the __builtins__ std method
    def __repr__(self):
        return 'Addcounter({.count})'.format(self)
    
    # another way to represnt the object overwriting the __add__ std method
    # operator overloading:
    def __add__(self, other):
        return Addcounter(self.count + other.count)