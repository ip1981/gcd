#!/bin/sh

gcd2() {
    if test $2 = 0 ; then
        echo $1
    else
        gcd2 $2 `expr $1 % $2`
    fi
}

gcdn() {
    r=$1; shift
    for n in $*; do
        r=`gcd2 $r $n`
    done
    echo $r
}

gcdn $*

