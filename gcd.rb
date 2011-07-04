#!/usr/bin/env ruby

def gcd2 a, b
    if b == 0
        a
    else
        gcd2 b, a % b
    end
end

# http://railspikes.com/2008/8/11/understanding-map-and-reduce
def gcdn ns
    ns.reduce{ |a, b| gcd2 a, b }
end

puts gcdn ARGV.collect{|s| s.to_i}

