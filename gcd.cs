using System;
using System.Linq;

class Program {
  static ulong gcd2(ulong a, ulong b) {
    ulong c;
    while (b != 0) {
      c = b;
      b = a % b;
      a = c;
    }
    return a;
  }

  static ulong gcdn(ulong[] nums) {
    return nums.Aggregate(0UL, (gcd, n) => gcd2(gcd, n));
  }

  static void Main(string[] argv) {
    ulong[] nums = Array.ConvertAll<string, ulong>(
        argv, new Converter<string, ulong>(
                  delegate(string s) { return ulong.Parse(s); }));

    if (nums.Length > 0)
      Console.WriteLine("{0}", gcdn(nums));
  }
}
