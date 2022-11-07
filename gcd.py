#!/usr/bin/env python3

import sys
import functools


def gcd2(a, b):
    while b != 0:
        a, b = b, a % b
    return a


def gcdn(nums):
    return functools.reduce(gcd2, nums)


if len(sys.argv) > 1:
    print(gcdn(map(int, sys.argv[1:])))
