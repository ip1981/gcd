% Synopsis:
% # gplc gcd.pro
% # ./gcd
% | ?- gcd2(22, 121, 11).
% | ?- gcd2(22, 121, X).
% | ?- gcdn([22, 33], 11).
% | ?- gcdn([22, 33, 44], 11).
% | ?- gcdn([22], 11).      
% | ?- gcdn([22, 33, 44], B). 


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

% http://www.gprolog.org/manual/html_node/gprolog008.html#toc9
%:- initialization(main).


% http://www.fraber.de/bap/bap76.html
%main :-
%    argument_list(Args),
%    gcdn(Numbers, G),
%    write(G), nl.

