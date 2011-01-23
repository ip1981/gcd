{Tested with FreePascal 2.4.0}

program GCD(output);
uses sysutils; {StrToInt}

function gcd2(a: integer; b: integer): integer;
var c: integer;
begin
    while b <> 0 do
    begin
        c := b;
        b := a mod b;
        a := c;
    end;
    gcd2 := a;
end;

function gcdn(n: array of integer): integer;
var i: integer;
begin
    gcdn := n[0];
    for i := 1 to High(n) do {See also <http://wiki.freepascal.org/for-in_loop> }
        gcdn := gcd2(gcdn, n[i]);
end;


var
    n: array of integer;
    i: integer;
begin
    SetLength(n, ParamCount);
    for i := 1 to ParamCount do
        n[i-1] := StrToInt(ParamStr(i));
    Writeln(gcdn(n))
end.

