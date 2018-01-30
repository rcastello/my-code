#!/usr/bin/env python2
# -*- coding: utf-8 -*-
"""
Created on Wed Dec 13 11:28:16 2017

@author: trn2306
"""

## Queue class
## Let's make it private with '_'
 
class Queue:
    def __init__(self):
         ## what we want queue to do. stick the list to it
         self._list = []
         
    def add_item(self,item):
        ## doing something with item
        self._list.append(item)
    
    def remove_front_item(self):
        try:
            return self._list.pop(0)
        ## at this point I have to tell python that Empty_queue exist in the scope.
        ## For the moment it will try to send the usual exception
        except IndexError:
            raise Empty_queue
        
## NB: to show what is inside just:
## q.list    
    
## Inheritance
   
class Emergency_queue(Queue):
    
    def add_front_item(self,item):
        self._list.insert(0,item)
        
        
## Class to raise the exception

class Empty_queue(Exception):
    pass