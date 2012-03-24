#!/usr/bin/node


function gcd2(a, b) {
    return b == 0 ? a : gcd2(b, a % b);
}

// Don't use parseInt() itself in map() - it used to have 2 arguments
var nums = process.argv.map(
        function(s) {return parseInt(s)}
    ).filter( // It will not work if this script or node itself is named as number ;-)
        function(t) {return !isNaN(t)}
    );

if (nums.length > 0) {
    var GCD = nums.reduce(gcd2); // Yeah, we could use lambda here
    console.log(GCD);
}

