/*

See https://nixos.org/nix/

Usage:

$ nix-instantiate --eval --expr "import ./gcd.nix [22 33 44 121]"
trace: gcd2: 44 <-> 121
trace: gcd2: 121 <-> 44
trace: gcd2: 44 <-> 33
trace: gcd2: 33 <-> 11
trace: gcd2: 11 <-> 0
trace: gcd2: 33 <-> 11
trace: gcd2: 11 <-> 0
trace: gcd2: 22 <-> 11
trace: gcd2: 11 <-> 0
11

*/

list:

let
  inherit (builtins) trace tail head;

  rem = x: y: x - y*(x / y);

  gcd2 = x: y: trace "gcd2: ${toString x} <-> ${toString y}"
    (if y == 0 then x else gcd2 y (rem x y));

  gcd = nn:
    let
      x = head nn;
      xs = tail nn;
    in if xs == [] then x
       else gcd2 x (gcd xs);

in gcd list

