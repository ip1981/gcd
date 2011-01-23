#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use integer;
use List::Util qw/ reduce /;

sub gcd2 {
    my ($a, $b) = @_;
    $b == 0 ? $a : gcd2($b, $a % $b)
}

# http://stackoverflow.com/questions/1490505/how-do-i-prevent-listmoreutils-from-warning-about-using-a-and-b-only-once
sub gcdn {
    our ($a, $b);
    reduce {gcd2($a, $b)} $_[0], @_
}

print gcdn(@ARGV);

