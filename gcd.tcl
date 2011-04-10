#!/usr/bin/env tclsh
#
# TESTED WITH TCL 8.5
# There is no tail recursion optimization before tcl 8.6.
# See also: http://wiki.tcl.tk/1348
#
# SYNOPSIS:
# tclsh8.5 gcd.tcl 11 22 33 44 121
#
# chmod +x gcd.tcl
# ./gcd.tcl 11 22 33 44 121
#

# http://wiki.tcl.tk/14726
proc foldl {func init list} {
    foreach item $list { set init [invoke $func $init $item] }
    return $init
}
proc invoke {func args} { uplevel #0 $func $args }


# } and else must be in the same line
proc gcd2 {a b} {
    if {$b == 0} {
        return $a
    } else {
        return [gcd2 $b [ expr {$a % $b} ]]
    }
}

proc gcdn {numbers} {
    return [foldl gcd2 0 $numbers]
}

puts [gcdn $argv]

