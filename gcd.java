/*
 * SYNOPSIS:
 *
 * # gcj -o gcd --main=gcd gcd.java
 * # ./gcd 11 22 33 44 121
 *
 * # javac gcd.java
 * # java gcd 11 22 33
 *
 */

public class gcd
{
    public static int gcd2(int a, int b) {
        int c;
        while (b != 0) {
            c = b;
            b = a % b;
            a = c;
        }
        return a;
    }

    public static int gcdn(int [] a) {
        int r = a[0];
        for (int i = 1; i < a.length; i++)
            r = gcd2(r, a[i]);
        return r;
    }

    public static void main(String [] argv) {
        int [] n = new int [argv.length];
        for (int i = 0; i < argv.length; i++) {
            n[i] = Integer.parseInt(argv[i]);
        }
        System.out.println(gcdn(n));
    }
}

