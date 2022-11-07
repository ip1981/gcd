/*
 * SYNOPSIS:
 *
 * # javac gcd.java
 * # java gcd 11 22 33
 *
 */

public class gcd {
  public static long gcd2(long a, long b) {
    long c;
    while (b != 0) {
      c = b;
      b = a % b;
      a = c;
    }
    return a;
  }

  public static long gcdn(long[] a) {
    long r = a[0];
    for (int i = 1; i < a.length; i++)
      r = gcd2(r, a[i]);
    return r;
  }

  public static void main(String[] argv) {
    if (argv.length == 0)
      return;

    long[] n = new long[argv.length];
    for (int i = 0; i < argv.length; i++) {
      n[i] = Long.parseLong(argv[i]);
    }

    System.out.println(gcdn(n));
  }
}
