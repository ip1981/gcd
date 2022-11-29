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
typedef unsigned long Number;
#endif

using std::vector;

template <class N> N gcd2(N a, N b) {
  while (b != 0) {
    N c = b;
    b = a % b;
    a = c;
  }
  return a;
}

#if __cplusplus >= 201703L
template <class N> class GCD {
public:
  N operator()(N a, N b) const { return gcd2(a, b); };
};

template <class N> N gcd(const vector<N> &ns) {
  GCD<N> GCD;
  return reduce(std::execution::par, begin(ns), end(ns), N(0), GCD);
}

#else

template <class N> N gcd(const vector<N> &ns) {
  N r = 0;
  for (typename vector<N>::const_iterator n = ns.begin(); n != ns.end(); ++n)
    r = gcd2(*n, r);
  return r;
}
#endif

int main(int argc, char *argv[]) {
  if (argc > 1) {
    vector<Number> ns(argc - 1);
    for (int n = 1; n < argc; ++n) {
      std::stringstream str;
      str << argv[n];
      str >> ns[n - 1];
    }
    std::cout << gcd(ns) << std::endl;
  }
  return EXIT_SUCCESS;
}
