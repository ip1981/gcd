#!/usr/bin/env lua

-- SYNOSPSIS:
-- # chmod +x gcd.lua; ./gcd.lua 121 22 33 44
-- # lua gcd.lua 121 33 22

-- http://www.lua.org/pil/6.3.html
function gcd2(a, b)
    if b == 0 then
        return a
    else
        return gcd2(b, a % b)
    end
end

function gcdn(ns)
    r = ns[1]
    for i = 2, table.maxn(ns) do
        r = gcd2(r, ns[i])
    end
    return r
end

print(gcdn(arg))

