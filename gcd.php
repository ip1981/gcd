<?php

function gcd2($a, $b)
{
    $c = 0;
    while ($b != 0)
    {
        $c = $b;
        $b = $a % $b;
        $a = $c;
    }
    return $a;
}

function gcd($numbers)
{
    $r = 0;
    foreach ($numbers as $n)
    {
        $r = gcd2($n, $r);
    }
    return $r;
}

print gcd(array_slice($argv, 1));

?>

