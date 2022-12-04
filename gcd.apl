#!/usr/bin/apl --script
⍝
⍝ Tested with GNU APL 1.8 (2022-10-25)
⍝
⍝ Synopsis:
⍝   $ ./gcd.apl -- 11 22 121
⍝ or:
⍝   $ apl --script [-f] gcd.apl -- 11 22 121
⍝
⍝ One-liner, where "∨" is APL's built-in GCD:
⍝   $ apl --eval "∨/⍎¨(↑⍸{'--'≡⍵}¨a)↓a←⎕ARG" -- 11 22 121
⍝

⍝ Function to get the script arguments,
⍝ that is everything after '--':
∇ r ← sargs; a
  a ← ⎕ARG
  r ← (↑⍸{'--'≡⍵}¨a)↓a
∇

⍝ Function to calculate the GCD of two numbers:
∇ r ← a gcd2 b
T: →(b=0)/E ⋄ (a b) ← b (b|a) ⋄ →T
E: r ← a
∇

⍝ Recursive version:
⍝ ∇ r ← a gcd2 b
⍝   r ← a
⍝   →(b=0)/0
⍝   r ← b gcd2 b|a
⍝ ∇

⍝ Function (lambda) to calculate the GCD of several numbers:
gcdn ← {gcd2/⍵}

∇ main; a
  a ← sargs    ⍝ Get script arguments
  →(0=≢a)⍴0    ⍝ Exit the function if no arguments
  ⎕ ← gcdn⍎¨a  ⍝ Convert strings to numbers, calculate and print GCD
∇

main

)OFF

