#include <stdlib.h>
#include <stdio.h>

static unsigned long int
gcd2 (unsigned long int a, unsigned long int b)
{
  unsigned long int c;
  while (b != 0)
    {
      c = b;
      b = a % b;
      a = c;
    }
  return a;
}

static unsigned long int
gcdn (unsigned long int *a, size_t n)
{
  unsigned long int r;
  size_t i;
  r = a[0];
  for (i = 1; i < n; i++)
    {
      r = gcd2 (r, a[i]);
    }
  return r;
}


int
main (int argc, char *argv[])
{
  unsigned long int *a;
  size_t i, n;

  if (argc > 1)
    {
      n = (size_t) (argc - 1);
      a = (unsigned long int *) malloc (sizeof (unsigned long int) * n);
      if (NULL != a)
        {
          for (i = 1; i <= n; i++)
            a[i - 1] = strtoul (argv[i], NULL, 10);
          printf ("%lu\n", gcdn (a, n));
          free (a);
          return EXIT_SUCCESS;
        }
      return EXIT_FAILURE;
    }
  return EXIT_SUCCESS;
}
