% Synopsis:
%
% $ escript gcd.erl 11 22 33 121
%
% or
%
% $ erl -compile gcd / erlc gcd.erl
% $ erl -noshell -run gcd main 11 22 33 121
%

-module(gcd).
-export([main/1, main/0]).
-mode(compile).

gcd2(A, 0) -> A;
gcd2(A, B) -> gcd2(B, A rem B).

gcdn(Nums) ->
  lists:foldl(fun gcd2/2, 0, Nums).

main() -> init:stop().

main([]) -> init:stop();
main(Args) ->
  Nums = lists:map(fun erlang:list_to_integer/1, Args),
  io:format("~w\n", [gcdn(Nums)]),
  init:stop().

