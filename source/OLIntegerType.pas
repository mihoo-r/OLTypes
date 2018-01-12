unit OLIntegerType;

interface

uses
  variants, SysUtils, OLBooleanType, OLDoubleType;

type
  OLInteger = record
  private
    Value: integer;
    NullFlag: string;

    function GetHasValue(): OLBoolean;
    procedure SetHasValue(Value: OLBoolean);
    property HasValue: OLBoolean read GetHasValue write SetHasValue;
  public
    function IsDividableBy(i: integer): OLBoolean;
    function IsOdd(): OLBoolean;
    function IsEven(): OLBoolean;
    function Sqr(): OLInteger;
    function Power(Exponent: LongWord): OLInteger; overload;
    function Power(Exponent: integer): Double; overload;
    function IsPositive(): OLBoolean;
    function IsNegative(): OLBoolean;
    function IsNonNegative(): OLBoolean;
    function Max(i: OLInteger): OLInteger;
    function Min(i: OLInteger): OLInteger;
    function Abs(): OLInteger;
    function IsNull(): OLBoolean;
    function ToString(): string;
    function IfNull(i: OLInteger): OLInteger;
    function Round(Digits: OLInteger): OLInteger;
    function Between(BottomIncluded, TopIncluded: OLInteger): OLBoolean;
    function Increased(IncreasedBy: integer = 1): OLInteger;
    function Decreased(DecreasedBy: integer = 1): OLInteger;
    function Replaced(FromValue: OLInteger; ToValue: OLInteger): OLInteger;

    procedure ForLoop(InitialValue: integer; ToValue: integer; Proc: TProc);
    function IsPrime(): OLBoolean;
    class function Random(MinValue: Integer; MaxValue:Integer): OLInteger;  overload; static;
    class function RandomPrime(MinValue: Integer; MaxValue:Integer): OLInteger; overload; static;

    class function Random(MaxValue:Integer = MaxInt): OLInteger;  overload; static;
    class function RandomPrime(MaxValue:Integer = MaxInt): OLInteger; overload; static;

    procedure SetRandom(MinValue: Integer; MaxValue:Integer); overload;
    procedure SetRandom(MaxValue:Integer = MaxInt); overload;

    procedure SetRandomPrime(MinValue: Integer; MaxValue:Integer); overload;
    procedure SetRandomPrime(MaxValue:Integer = MaxInt); overload;

    class operator Add(a, b: OLInteger): OLInteger;
    class operator Subtract(a, b: OLInteger): OLInteger;
    class operator Multiply(a, b: OLInteger): OLInteger;
    class operator IntDivide(a, b: OLInteger): OLInteger;
    class operator Divide(a, b: OLInteger): OLDouble;
    class operator Divide(a: Extended; b: OLInteger): OLDouble;
    class operator Divide(a: OLInteger; b: Extended): OLDouble;
    class operator Divide(a: OLDouble; b: OLInteger): OLDouble;
    class operator Divide(a: OLInteger; b: OLDouble): OLDouble;
    class operator Modulus(a, b: OLInteger): OLInteger;
    class operator BitwiseXor(a, b: OLInteger): OLInteger;

    class operator Implicit(a: integer): OLInteger;
    class operator Implicit(a: OLInteger): integer;
    class operator Implicit(a: OLInteger): Double;
    class operator Implicit(a: Variant): OLInteger;
    class operator Implicit(a: OLInteger): Variant;
    class operator Implicit(a: OLInteger): OLDouble;

    class operator Inc(a: OLInteger): OLInteger;
    class operator Dec(a: OLInteger): OLInteger;
    class operator Negative(a: OLInteger): OLInteger;

    class operator Equal(a, b: OLInteger): OLBoolean; overload;
    class operator NotEqual(a, b: OLInteger): OLBoolean;  overload;
    class operator GreaterThan(a, b: OLInteger): OLBoolean;  overload;
    class operator GreaterThanOrEqual(a, b: OLInteger): OLBoolean;  overload;
    class operator LessThan(a, b: OLInteger): OLBoolean;  overload;
    class operator LessThanOrEqual(a, b: OLInteger): OLBoolean;  overload;

    class operator Equal(a: OLInteger; b: Extended): OLBoolean;  overload;
    class operator NotEqual(a: OLInteger; b: Extended): OLBoolean;  overload;
    class operator GreaterThan(a: OLInteger; b: Extended): OLBoolean;  overload;
    class operator GreaterThanOrEqual(a: OLInteger; b: Extended): OLBoolean;  overload;
    class operator LessThan(a: OLInteger; b: Extended): OLBoolean;  overload;
    class operator LessThanOrEqual(a: OLInteger; b: Extended): OLBoolean;  overload;
  end;

implementation

uses
  Math;

const
  NonEmptyStr = ' ';

var
  primes: array of integer;

procedure AddPrime(n: integer);
var
  l: integer;
begin
  l := length(primes);
  SetLength(primes, l + 1);
  primes[l] := n;
end;

function OLInteger.Abs(): OLInteger;
begin
  if Self.HasValue then
    Result := System.Abs(Self.Value)
  else
    Result := Null;
end;

class operator OLInteger.Add(a, b: OLInteger): OLInteger;

var
  returnrec: OLInteger;
begin
  returnrec.Value := a.Value + b.Value;
  returnrec.HasValue := a.HasValue and b.HasValue;
  Result := returnrec;
end;

function OLInteger.Between(BottomIncluded, TopIncluded: OLInteger): OLBoolean;
begin
  Result := (Value <= TopIncluded) and (Value >= BottomIncluded);
end;

class operator OLInteger.BitwiseXor(a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin
  returnrec.Value := a.Value xor b.Value;
  returnrec.HasValue := a.HasValue and b.HasValue;
  Result := returnrec;
end;

class operator OLInteger.Implicit(a: integer): OLInteger;
var
  OutPut: OLInteger;
begin
  OutPut.Value := a;
  OutPut.HasValue := true;
  Result := OutPut;
end;

class operator OLInteger.Implicit(a: OLInteger): integer;
var
  OutPut: integer;
begin
  if not a.HasValue then
    raise Exception.Create('Null cannot be used as integer value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLInteger.Dec(a: OLInteger): OLInteger;
begin
  System.Dec(&a.Value);
  Result := a;
end;

class operator OLInteger.Divide(a: Extended; b: OLInteger): OLDouble;
var
  OutPut: OLDouble;
begin
  if not b.HasValue then
    OutPut := Null
  else
    OutPut := a / b.Value;

  Result := OutPut;
end;

class operator OLInteger.Divide(a: OLInteger; b: Extended): OLDouble;
var
  OutPut: OLDouble;
begin
  if not a.HasValue then
    OutPut := Null
  else
    OutPut := a.Value / b;

  Result := OutPut;
end;

class operator OLInteger.Equal(a: OLInteger; b: Extended): OLBoolean;
begin
  Result := (a.Value = b) and a.HasValue;
end;

class operator OLInteger.Divide(a, b: OLInteger): OLDouble;
var
  OutPut: OLDouble;
begin
  if (not a.HasValue) or (not b.HasValue) then
    OutPut := Null
  else
    OutPut := a.Value / b.Value;

  Result := OutPut;
end;

function OLInteger.IsDividableBy(i: integer): OLBoolean;
begin
  Result := Self.HasValue and ((Self.Value mod i) = 0);
end;

class operator OLInteger.Equal(a, b: OLInteger): OLBoolean;
begin
  Result := ((a.Value = b.Value) and (a.HasValue and b.HasValue)) or (a.IsNull() and b.IsNull());
end;

procedure OLInteger.ForLoop(InitialValue, ToValue: integer; Proc: TProc);
var
  iterator: integer;
begin
  if InitialValue < ToValue then
  begin
    for iterator := InitialValue to ToValue do
    begin
      Self := iterator;
      Proc();
    end;
  end
  else
  begin
    for iterator := InitialValue downto ToValue do
    begin
      Self := iterator;
      Proc();
    end;
  end;
end;

function OLInteger.IsEven: OLBoolean;
begin
  Result := Self.IsDividableBy(2);
end;

function OLInteger.GetHasValue: OLBoolean;
begin
  Result := (NullFlag <> EmptyStr);
end;

class operator OLInteger.GreaterThan(a, b: OLInteger): OLBoolean;
begin
  Result := (a.Value > b.Value) and a.HasValue and b.HasValue;
end;

class operator OLInteger.GreaterThanOrEqual(a, b: OLInteger): OLBoolean;
begin
  Result := ((a.Value >= b.Value) and (a.HasValue and b.HasValue)) or (a.IsNull() and b.IsNull());
end;

function OLInteger.IfNull(i: OLInteger): OLInteger;
var
  Output: OLInteger;
begin
  if HasValue then
    Output := Self
  else
    Output := i;

  Result := Output;
end;

class operator OLInteger.Implicit(a: OLInteger): Double;
var
  OutPut: Double;
begin
  if not a.HasValue then
    raise Exception.Create('Null cannot be used as Double value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLInteger.Implicit(a: Variant): OLInteger;
var
  OutPut: OLInteger;
  i: integer;
begin
  if VarIsNull(a) then
    OutPut.HasValue := false
  else
  begin
    if TryStrToInt(a, i) then
    begin
      OutPut.Value := i;
      OutPut.HasValue := true;
    end
    else
    begin
      raise Exception.Create('Value ''' + VarToStr(a) + ''' cannot be assigned to variable of OLInteger type.');
    end;
  end;

  Result := OutPut;
end;

class operator OLInteger.Inc(a: OLInteger): OLInteger;
begin
  System.Inc(&a.Value);
  Result := a;
end;

function OLInteger.Increased(IncreasedBy: integer = 1): OLInteger;
begin
  Result := Self + IncreasedBy;
end;

function OLInteger.Decreased(DecreasedBy: integer = 1): OLInteger;
begin
  Result := Self - DecreasedBy;
end;

class operator OLInteger.IntDivide(a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin
  returnrec.HasValue := a.HasValue and b.HasValue;

  if (returnrec.HasValue) then
    returnrec.Value := a.Value div b.Value;

  Result := returnrec;
end;

function OLInteger.IsNull: OLBoolean;
begin
  Result := not HasValue;
end;

class operator OLInteger.LessThan(a, b: OLInteger): OLBoolean;
begin
  Result := (a.Value < b.Value) and a.HasValue and b.HasValue;
end;

class operator OLInteger.LessThanOrEqual(a, b: OLInteger): OLBoolean;
begin
  Result := ((a.Value <= b.Value) and (a.HasValue and b.HasValue)) or (a.IsNull() and b.IsNull());
end;

function OLInteger.Max(i: OLInteger): OLInteger;
begin
  if (not HasValue) or (i = Null) then
    raise Exception.Create('Null value cannot be compared to integer.');

  Result := Math.Max(Value, i);
end;

function OLInteger.Min(i: OLInteger): OLInteger;
begin
  if (not HasValue) or (i = Null) then
    raise Exception.Create('Null value cannot be compared to integer.');

  Result := Math.Min(Value, i);
end;

class operator OLInteger.Modulus(a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin
  returnrec.Value := a.Value mod b.Value;
  returnrec.HasValue := a.HasValue and b.HasValue;
  Result := returnrec;
end;

class operator OLInteger.Multiply(a, b: OLInteger): OLInteger;

var
  returnrec: OLInteger;
begin
  returnrec.Value := a.Value * b.Value;
  returnrec.HasValue := a.HasValue and b.HasValue;
  Result := returnrec;
end;

class operator OLInteger.Negative(a: OLInteger): OLInteger;
var
  b: OLInteger;
begin
  b.Value := -a.Value;
  b.HasValue := a.HasValue;
  Result := b;
end;

class operator OLInteger.NotEqual(a: OLInteger; b: Extended): OLBoolean;
begin
  Result := (a.Value <> b) and a.HasValue;
end;

function OLInteger.Power(Exponent: integer): Double;
begin
  Result := Math.IntPower(Value, Exponent);
end;

function OLInteger.IsNegative: OLBoolean;
begin
  Result := HasValue and (Value < 0);
end;

function OLInteger.IsNonNegative: OLBoolean;
begin
  Result := HasValue and (Value >= 0);
end;

class operator OLInteger.NotEqual(a, b: OLInteger): OLBoolean;
begin
  Result := ((a.Value <> b.Value) and a.HasValue and b.HasValue) or (a.HasValue <> b.HasValue);
end;

function OLInteger.Power(Exponent: LongWord): OLInteger;
var
  returnrec: OLInteger;
begin
  returnrec.Value := Math.Floor(Math.IntPower(Value, Exponent));
  returnrec.HasValue := HasValue;
  Result := returnrec;
end;


class function OLInteger.Random(MinValue: Integer; MaxValue:Integer): OLInteger;
begin
  Result := MinValue + system.Random(MaxValue - MinValue + 1);
end;

class function OLInteger.RandomPrime(MinValue: Integer; MaxValue:Integer): OLInteger;
var
  new: OLInteger;
begin
  repeat
    new := OLInteger.Random(MinValue, MaxValue);
  until new.IsPrime;

  Result := new;
end;

function OLInteger.IsOdd: OLBoolean;
begin
  Result := HasValue and (not IsEven());
end;

function OLInteger.IsPositive: OLBoolean;
begin
  Result := HasValue and (Value > 0);
end;

function OLInteger.IsPrime: OLBoolean;
var
  i, j: integer;
  PrimeLen: integer;
  OutPut: OLBoolean;
  MaxPrimeDivader: integer;
  PrimeAddStart, PrimeAddFinnish: integer;
  LoopCount: integer;
  k: OLInteger;
begin
  if Self.HasValue then
  begin
    i := 0;
    PrimeLen := Length(primes);

    MaxPrimeDivader := Ceil(Sqrt(Value));
    LoopCount := Math.Min(PrimeLen, MaxPrimeDivader);

    while (i < LoopCount) and (Value mod primes[i] > 0) do
      system.inc(i);

    if (i < LoopCount) then
      OutPut := False
    else
    begin
      OutPut := true;

      if MaxPrimeDivader > PrimeLen then
      begin
        OutPut := true;

        PrimeAddStart := (primes[PrimeLen - 1] div 6) + 1;
        PrimeAddFinnish := Math.Max(PrimeAddStart, (MaxPrimeDivader div 6));

        j := PrimeAddStart;
        while j <= PrimeAddFinnish do
        begin
          k := 6 * j + 1;

          if k.IsPrime() then
          begin
            AddPrime(6 * j + 1);
            if Value mod (6 * j + 1) = 0 then
            begin
              OutPut := false;
              break;
            end;
          end;

          k := 6 * j + 5;

          if k.IsPrime() then
          begin
            AddPrime(6 * j + 5);
            if Value mod (6 * j + 5) = 0 then
            begin
              OutPut := false;
              break;
            end;
          end;

          system.inc(j);
        end;
      end;
    end;
  end
  else
    OutPut := False;

  Result := OutPut;
end;

procedure OLInteger.SetHasValue(Value: OLBoolean);
begin
  if Value then
    NullFlag := NonEmptyStr
  else
    NullFlag := EmptyStr;
end;

procedure OLInteger.SetRandom(MaxValue: Integer);
begin
  Self.Value := OLInteger.Random(MaxValue);
  Self.HasValue := True;
end;

procedure OLInteger.SetRandom(MinValue, MaxValue: Integer);
begin
  Self.Value := OLInteger.Random(MinValue, MaxValue);
  Self.HasValue := True;
end;

procedure OLInteger.SetRandomPrime(MaxValue: Integer);
begin
  Self.Value := OLInteger.RandomPrime(MaxValue);
  Self.HasValue := True;
end;

procedure OLInteger.SetRandomPrime(MinValue, MaxValue: Integer);
begin
  Self.Value := OLInteger.RandomPrime(MinValue, MaxValue);
  Self.HasValue := True;
end;

function OLInteger.Sqr: OLInteger;
var
  returnrec: OLInteger;
begin
  returnrec.Value := Value * Value;
  returnrec.HasValue := HasValue;
  Result := returnrec;
end;

class operator OLInteger.Subtract(a, b: OLInteger): OLInteger;

var
  returnrec: OLInteger;
begin
  returnrec.Value := a.Value - b.Value;
  returnrec.HasValue := a.HasValue and b.HasValue;
  Result := returnrec;
end;

function OLInteger.ToString: string;
var
  Output: string;
begin
  if HasValue then
    Output := IntToStr(Value)
  else
    Output := '';

  Result := Output;
end;

class function OLInteger.Random(MaxValue: Integer): OLInteger;
begin
  Result := OLInteger.Random(0, MaxValue);
end;

class function OLInteger.RandomPrime(MaxValue: Integer): OLInteger;
begin
  Result := OLInteger.RandomPrime(0, MaxValue);
end;

function OLInteger.Replaced(FromValue, ToValue: OLInteger): OLInteger;
var
  Output: OLInteger;
begin
  if Self = FromValue then
    Output := ToValue
  else
    Output := Self;

  Result := Output;
end;

function OLInteger.Round(Digits: OLInteger): OLInteger;
begin
  Result := Math.RoundTo(Self, Digits);
end;

class operator OLInteger.Implicit(a: OLInteger): Variant;
var
  OutPut: Variant;
begin
  if a.HasValue then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLInteger.GreaterThan(a: OLInteger; b: Extended): OLBoolean;
begin
  Result := (a.Value > b) and a.HasValue;
end;

class operator OLInteger.GreaterThanOrEqual(a: OLInteger;
  b: Extended): OLBoolean;
begin
  Result := (a.Value >= b) and a.HasValue;
end;

class operator OLInteger.LessThan(a: OLInteger; b: Extended): OLBoolean;
begin
  Result := (a.Value < b) and a.HasValue;
end;

class operator OLInteger.LessThanOrEqual(a: OLInteger; b: Extended): OLBoolean;
begin
  Result := (a.Value <= b) and a.HasValue;
end;

class operator OLInteger.Implicit(a: OLInteger): OLDouble;
var
  OutPut: OLDouble;
begin
  if a.HasValue then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLInteger.Divide(a: OLDouble; b: OLInteger): OLDouble;
var
  OutPut: OLDouble;
begin
  if (a.IsNull()) or (not b.HasValue) then
    OutPut := Null
  else
    OutPut := a / b.Value;

  Result := OutPut;
end;

class operator OLInteger.Divide(a: OLInteger; b: OLDouble): OLDouble;
var
  OutPut: OLDouble;
begin
  if (not a.HasValue) or (b.IsNull) then
    OutPut := Null
  else
    OutPut := a.Value / b;

  Result := OutPut;
end;

initialization
  setlength(primes, 3);
  primes[0] := 2;
  primes[1] := 3;
  primes[2] := 5;

end.
