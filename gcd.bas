' Tested with FreeBASIC 1.10.0
'
' Synopsis:
' $ fbc -x gcd-bas gcd.bas
' $ ./gcd-bas 11 22 33 121
'

FUNCTION gcd2 (BYVAL a AS ULONGINT, BYVAL b AS ULONGINT) AS ULONGINT
  DIM c AS ULONGINT
  DO WHILE (b > 0)
    c = b
    b = a MOD b
    a = c
  LOOP
  RETURN a
END FUNCTION


FUNCTION gcdn (nums() AS ULONGINT) AS ULONGINT
  DIM gcd AS ULONGINT = nums(LBOUND(nums))
  FOR i AS INTEGER = LBOUND(nums) + 1 TO UBOUND(nums)
    gcd = gcd2(gcd, nums(i))
  NEXT
  RETURN gcd
END FUNCTION


DIM argc AS INTEGER = 0
DO WHILE (LEN(COMMAND(argc + 1)) > 0)
  argc += 1
LOOP

IF argc = 0 THEN STOP

DIM nums(argc) AS ULONGINT
FOR i AS INTEGER = 1 TO argc
  nums(i) = VALULNG(COMMAND(i))
NEXT

PRINT gcdn(nums())

