/*
 * SYNOPSIS:
 *
 * # g++ -o gcd-cpp gcd.cpp
 * # ./gcd-cpp 11 22 33 121
 * # 11
 *
 *
 * To use GNU Multiple Precision Arithmetic Library:
 *
 * # g++ -o gcd-cpp-gmp -DGMP -lgmpxx -lgmp gcd.cpp
 * # ./gcd-cpp-gmp 1234567890987654321 987654321234567
 * # 63
 *
 */

#include <cstdlib>
#include <iostream>
#include <sstream>
#include <vector>

using namespace std;

#ifdef GMP
#include <gmpxx.h>
typedef mpz_class Number;
#else
typedef unsigned int Number;
#endif // GMP

typedef vector<Number> Numbers;

Number gcd(Number a, Number b) {
  Number c;
  while (b != 0) {
    c = b;
    b = a % b;
    a = c;
  }
  return a;
}

Number gcd(const Numbers &ns) {
  Number r = 0;
  for (Numbers::const_iterator n = ns.begin(); n != ns.end(); ++n)
    r = gcd(*n, r);
  return r;
}

int main(int argc, char *argv[]) {
  if (argc > 1) {
    Numbers ns(argc - 1);
    for (int n = 1; n < argc; ++n) {
      stringstream str;
      str << argv[n];
      str >> ns[n - 1];
      /* NOTE:
       * For GMP we can just assign: ns[n-1] = argv[n],
       * and sstream is not needed.
       */
    }
    cout << gcd(ns) << endl;
  }
  return EXIT_SUCCESS;
}
