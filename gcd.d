// D: https://dlang.org
//
// Synopsis:
//
// GNU D Compiler (tested GCC 12):
// $ gdc gcd.d -o gcd-d
// $ ./gcd-d 11 22 33 121
//
// LLVM D Compiler (tested LDC2 1.24.0):
// $ ldc2 --run gcd 11 22 33 121
// or
// $ ldc2 --of=gcd-d gcd.d
// $ ./gcd-d 11 22 33 121
//

import std.algorithm: map, reduce;
import std.conv: to;
import std.stdio: writeln;

ulong gcd2(ulong a, ulong b) {
  ulong c;
  while (b > 0) {
    c = b;
    b = a % b;
    a = c;
  }
  return c;
}

void main(string[] args) {
  if (args.length > 1) {
    auto gcd = args[1..$].map!(to!ulong).reduce!gcd2();
    writeln(gcd);
  }
}
