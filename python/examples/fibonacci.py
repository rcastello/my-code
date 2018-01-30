from __future__ import generators

# Recursive version
def fibr(n):
    if n < 3:
        return 1
    return fibr(n-1) + fibr(n-2)

# Iterative version
def fibi(n):
    this, last = 1, 0
    for i in range(n-1):
        this, last = this+last, this
    return this

# Generator function
def fibgen():
    this, last = 1, 0
    while True:
        yield this
        this, last = this+last, this

# Combination of streams version
def fibstream():
    yield 1; yield 1
    f_minus_2 = fibstream()
    f_minus_1 = fibstream(); f_minus_1.next()
    while True:
	yield f_minus_1.next() + f_minus_2.next()

# A recursive O(1) version
def fibr1(n, c=1, p=1):
    if n>2:
        return fibr1(n-1, c+p, c)
    return c
        
def fibreduce(N):
    def step(pair,_):
        current, previous = pair
        return (current + previous, current)
    return reduce(step,range(N-2),(1,1))[0]

# A direct functional form of the Nth Fibonacci number:
import math
sqrt5 = math.sqrt(5)
phi = (1 + sqrt5) / 2.0
psi = (1 - sqrt5) / 2.0
def fibgolden(n):
    return (pow(phi,n) - pow(psi,n))/sqrt5

# fib(n) is the nearest integer to the result of the following
def fibapprox(n):
    return pow(phi,n)/sqrt5

if __name__ == '__main__':

    fibg = fibgen()

    # Show the result from 0 to 19 for all the variants
    print ' N    rec  iter   gen  fibr1 reduce golden  approx'
    for i in range(1,20):
        print '%2d%6d%6d%6d%6d%6d%9.2f%8.2f' % (i, fibr(i), fibi(i), fibg.next(),
                                                fibr1(i), fibreduce(i),
                                                fibgolden(i), fibapprox(i))

    print

    # A utility for timing the function invocations.
    import time
    def timer(fn,arg):
        start = time.time()
        fn(arg)
        stop = time.time()
        return stop-start

    # Check whether user specified a value to use for the long timing
    # test
    import sys
    try:
        N = int(sys.argv[1])
    except (IndexError, ValueError):
        N = 35
    print "timing with N=%s ..." % N
    print
        
    # Time all variants with a single argument
    the_fibs = fibapprox, fibgolden, fibi, fibreduce, fibr1, fibr

    padsize = max([len(fn.__name__) for fn in the_fibs])
    format = '%' + str(padsize) + "s(%d) took %f seconds"

    for fib in the_fibs:
        print format % (fib.__name__, N, timer(fib,N))
        


