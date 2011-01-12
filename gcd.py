#!/usr/bin/env python3

import sys
import functools

def gcd2(a, b):
    if b == 0:
        return a
    else:
        return gcd2(b, a % b)

def gcdn(ns):
    return functools.reduce(gcd2, ns)

ints = map(int, sys.argv[1:])
gcd = gcdn(ints)
print(gcd)

