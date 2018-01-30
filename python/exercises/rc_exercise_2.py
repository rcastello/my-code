#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Dec 11 16:19:58 2017

@author: trn2306
"""

def make_adder(n):
    def adder(x):
        return n+x
    return adder

add3 = make_adder(3)
add9 = make_adder(9)
print(add3(4), ' and ', add9(4))