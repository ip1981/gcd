{
FreePascal: https://www.freepascal.org/
Tested with FreePascal 3.2

Usage:

  $ fpc gcd.pas -ogcd-pas
  $ ./gcd-pas 44 55 66 121
  11

}

Program GCD(output);

Uses sysutils; {StrToInt}

Function gcd2(a: integer; b: integer): integer;
Var c: integer;
Begin
  While b <> 0 Do
    Begin
      c := b;
      b := a Mod b;
      a := c;
    End;
  gcd2 := a;
End;

Function gcdn(n: Array Of integer): integer;
Var i: integer;
Begin
  gcdn := n[0];
  For i := 1 To High(n) Do {See also <http://wiki.freepascal.org/for-in_loop> }
    gcdn := gcd2(gcdn, n[i]);
End;


Var
  n: array Of integer;
  i: integer;
Begin
  If ParamCount = 0 then exit;

  SetLength(n, ParamCount);

  For i := 1 To ParamCount Do
    n[i-1] := StrToInt(ParamStr(i));

  Writeln(gcdn(n))
End.
