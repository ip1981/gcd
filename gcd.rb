#!/usr/bin/env ruby

def gcd2 a, b
    if b == 0
        a
    else
        gcd2 b, a % b
    end
end

def gcdn ns
    ns.reduce{ |a, b| gcd2 a, b }
end

puts gcdn ARGV.collect{|s| s.to_i}

