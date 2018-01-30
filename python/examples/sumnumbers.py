import operator

def float_or_zero(a_string):
    try: return float(a_string)
    except ValueError: return 0

print """Here are the sums of the numbers on each line of 'myfile'
calculated in a number of slightly different ways:
"""

try:
    for line in open('myfile', 'r'):


        # Using the operator module and map
        print reduce(operator.add, map(float_or_zero, line.split()),0),

        # Same again, using lambda and list comprehensions
        print reduce(lambda a,b:a+b,[float_or_zero(x) for x in line.split()],0),

        # It could be argued that you should do each step on a separate line:
        strings = line.split()
        numbers = map(float_or_zero, strings)
        sum = reduce(operator.add, numbers, 0)
        print sum

except IOError:
    print """This program relies on the presence of the readable file: './myfile'.
please provide this file and try again."""
