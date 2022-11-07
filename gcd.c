#include <stdlib.h>
#include <stdio.h>

static unsigned long
gcd2 (unsigned long a, unsigned long b)
{
  unsigned long c;
  while (b != 0)
    {
      c = b;
      b = a % b;
      a = c;
    }
  return a;
}

static unsigned long
gcdn (const unsigned long *a, size_t n)
{
  unsigned long r;
  size_t i;
  r = a[0];
  for (i = 1; i < n; i++)
    r = gcd2 (r, a[i]);
  return r;
}


int
main (int argc, char *argv[])
{
  unsigned long *a;
  size_t i, n;

  if (argc > 1)
    {
      n = (size_t) (argc - 1);
      a = (unsigned long *) malloc (n * sizeof (unsigned long));
      if (!a)
        return EXIT_FAILURE;

      for (i = 1; i <= n; i++)
        a[i - 1] = strtoul (argv[i], NULL, 10);
      printf ("%lu\n", gcdn (a, n));
      free (a);
    }
  return EXIT_SUCCESS;
}
