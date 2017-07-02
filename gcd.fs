: gcd ( a b -- d )
  2dup > if swap endif
  over mod
  dup 0 <> if recurse else drop endif
  ;

: gcdn ( a1 a2 .. an n -- d )
  dup 1 >
  if
    1 - rot rot
    gcd
    swap
    recurse
  else
    drop
  endif
  ;


\ This is gforth-specific.
\ Usage:
\ # gforth ./gcd.fs 11 22 33 121
\ 11 

: main
  0 >r
  begin
  next-arg 2dup 0 0 d<> while
  s>unumber? if drop else abort endif
  r> 1 + >r
  repeat
  2drop
  r> gcdn . cr
  ;

main bye

