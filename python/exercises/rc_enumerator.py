#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Thu Dec 14 16:00:01 2017

@author: trn2306
"""

genumerate = 1


def genumerate(iterable):
    while True:
        yield iterable.next()   #next()
    return            #StopIteration