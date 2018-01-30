# -*- coding: utf-8 -*-
"""
Spyder Editor

This is a temporary script file.
"""

def my_enumerate(iterable):
    my_len=range(len(iterable))
    ## in python 3 is already lazy and using xrange
    return zip(my_len, iterable)


print('My enumerate results')

for index,item in my_enumerate('hello'):
    print('The index is ', index, ' and item is ' , item)
    
print('Python enumerate results')

for index,item in enumerate('hello'):
    print ('The index is ', index, ' and item is ' , item)
