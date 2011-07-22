% SYNOPSIS.
%
% Tested with GNU Prolog 1.3.1
%
% # gplc --no-top-level gcd.pro
% # ./gcd 22 33 44 121


% 1st number, 2nd number, GCD

% It is true that GCD of A and 0 is A
% (The fact is GCD of A and 0 is A)
gcd2(A, 0, A).

% It is true that G is GCD of A and B
% when A>0 and B>0 and G is GCD of B and A % B
gcd2(A, B, G) :- A>0, B>0, N is mod(A, B), gcd2(B, N, G).

gcdn(A, [], A).
gcdn(A, [B|Bs], G) :- gcd2(A, B, N), gcdn(N, Bs, G).
gcdn([A|As], G) :- gcdn(A, As, G).

:- initialization(main).

str2int([], []).
str2int([S|St], [N|Nt]) :- number_atom(N, S), str2int(St, Nt).

main :-
    argument_list(Args),
    str2int(Args, Numbers),
    gcdn(Numbers, G),
    write(G), nl.

