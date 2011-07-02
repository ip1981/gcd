/* 
 * http://gmplib.org/
 *
 * gcc gcd-gmp.c -o gcd-gmp -lgmp
 *
 */

#include <stdlib.h>
#include <stdio.h>
#include <gmp.h>

void gcd2(mpz_t r, mpz_t a1, mpz_t b1)
{
    mpz_t a, b;
    mpz_init_set(a, a1);
    mpz_init_set(b, b1);
    while (mpz_sgn(b) != 0) {
        mpz_set(r, b);    /* r = b; */
        mpz_mod(b, a, b); /* b = a % b; */
        mpz_set(a, r);    /* a = r; */
    }
    mpz_set(r, a);
    mpz_clear(a);
    mpz_clear(b);
}

void gcdn(mpz_t r, mpz_t a[], size_t n)
{
    size_t i;
    mpz_set(r, a[0]);
    for (i = 1; i < n; i++)
        gcd2(r, r, a[i]); /* mpz_gcd ;-) */
}


int main (int argc, char *argv[])
{
    mpz_t *a, g;
    int i, n;

    if (argc > 1) {
        n = argc - 1;
        a = malloc(sizeof(mpz_t) * n);
        if (NULL != a) {
            for (i = 1; i <= n; i++)
                mpz_init_set_str(a[i-1], argv[i], 10);

            mpz_init(g);
            gcdn(g, a, n);
            mpz_out_str(NULL, 10, g);
            printf("\n");

            /* No need actually before exit */
            mpz_clear(g);
            for (i = 1; i <= n; i++)
                mpz_clear(a[i-1]);
            free(a);
            return EXIT_SUCCESS;
        }
        return EXIT_FAILURE;
    }
    return EXIT_SUCCESS;
}

