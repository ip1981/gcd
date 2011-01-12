#include <stdlib.h>
#include <stdio.h>

unsigned int gcd2(unsigned int a, unsigned int b)
{
    unsigned int c;
    while (b != 0) {
        c = b;
        b = a % b;
        a = c;
    }
    return a;
}

unsigned int gcdn(unsigned int a[], size_t n)
{
    unsigned int r;
    size_t i;
    r = a[0];
    for(i = 1; i < n; i++) {
        r = gcd2(r, a[i]);
    }
    return r;
}


int main (int argc, char *argv[])
{
    unsigned int *a;
    int i, n;

    if (argc > 1) {
        n = argc - 1;
        a = malloc(sizeof(unsigned int) * n);
        if (NULL != a) {
            for (i = 1; i <= n; i++)
                a[i-1] = atoi(argv[i]);
            printf("%u\n", gcdn(a, n));
            free(a);
            return EXIT_SUCCESS;
        }
        return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;
}

