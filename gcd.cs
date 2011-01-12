using System;

namespace GCD {
    class Program {
        static uint gcd2(uint a, uint b) {
            uint c;
            while (b != 0) {
                c = b;
                b = a % b;
                a = c;
            }
            return a;
        }

        static uint gcdn(uint [] n) {
            uint r = n[0];
            for (int i = 1; i < n.Length; i++)
                r = gcd2(r, n[i]);
            return r;
        }

        static void Main(string [] argv) {
            uint [] a = Array.ConvertAll<string, uint>(argv,
                    new Converter<string, uint>
                    (delegate(string s) {return uint.Parse(s);})
                    );

            Console.WriteLine("{0}", gcdn(a));
        }
    }
}

