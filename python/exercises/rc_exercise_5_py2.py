#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Tue Dec 12 16:21:56 2017

@author: trn2306
"""

import operator
from exceptions import ValueError


def clever_int(token):
 
 ## if we put the map in the try the exception destroy the map stack. it should
 ## be added before. How? I have just to reinvent a clever way to convert the
 ## the element of the token list (tokens) to an int the map will take this function
 ## and it will apply to every element of the tokens (as it usually does)
 
    try:
        return int(token)
    except ValueError:
        print 'ValueError: Assigning 0 to non-integer values' 
        return 0
    
        
    
## open the file
with open('numbers.txt') as myfile:
    for line in myfile:
        ## first tokenize the string and 
        tokens = line.split() # no separator specified. better because it eliminates automatically 
        #numbers = map(lambda x:int(x),tokens)
        # better to do        
        numbers = map(clever_int, tokens)
        print reduce(operator.add,numbers,0) ## Note the specification of the identitiy (0) for the operation we want to perform