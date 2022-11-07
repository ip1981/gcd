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
 * # g++ -DGMP gcd.cpp -lgmpxx -lgmp -o gcd-cpp-gmp
 * # ./gcd-cpp-gmp 1234567890987654321 987654321234567
 * # 63
 *
 */

#include <cstdlib>
#include <iostream>
#include <sstream>
#include <vector>
#if __cplusplus >= 201703L
#include <execution>
#include <numeric>
#endif

#ifdef GMP
#include <gmpxx.h>
typedef mpz_class Number;
#else
typedef unsigned int Number;
#endif

using namespace std;

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

#if __cplusplus >= 201703L
class GCD {
public:
  Number operator()(Number a, Number b) const { return gcd(a, b); };
} GCD;

Number gcd(const Numbers &ns) {
  return reduce(execution::par, begin(ns), end(ns), Number(0), GCD);
}

#else

Number gcd(const Numbers &ns) {
  Number r = 0;
  for (Numbers::const_iterator n = ns.begin(); n != ns.end(); ++n)
    r = gcd(*n, r);
  return r;
}
#endif

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
