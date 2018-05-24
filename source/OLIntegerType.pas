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
    procedure SetHasValue(const Value: OLBoolean);
    property ValuePresent: OLBoolean read GetHasValue write SetHasValue;
  public
    function IsDividableBy(const i: integer): OLBoolean;
    function IsOdd(): OLBoolean;
    function IsEven(): OLBoolean;
    function Sqr(): OLInteger;
    function Power(const Exponent: LongWord): OLInteger; overload;
    function Power(const Exponent: integer): Double; overload;
    function IsPositive(): OLBoolean;
    function IsNegative(): OLBoolean;
    function IsNonNegative(): OLBoolean;
    function Max(const i: OLInteger): OLInteger;
    function Min(const i: OLInteger): OLInteger;
    function Abs(): OLInteger;
    function IsNull(): OLBoolean;
    function HasValue(): OLBoolean;
    function ToString(): string;
    function IfNull(const i: OLInteger): OLInteger;
    function Round(const Digits: OLInteger): OLInteger;
    function Between(const BottomIncluded, TopIncluded: OLInteger): OLBoolean;
    function Increased(const IncreasedBy: integer = 1): OLInteger;
    function Decreased(const DecreasedBy: integer = 1): OLInteger;
    function Replaced(const FromValue: OLInteger; const ToValue: OLInteger): OLInteger;

    procedure ForLoop(const InitialValue: integer; const ToValue: integer; const Proc: TProc);
    function IsPrime(): OLBoolean;
    class function Random(const MinValue: Integer; const MaxValue:Integer): OLInteger;  overload; static;
    class function RandomPrime(const MinValue: Integer; const MaxValue:Integer): OLInteger; overload; static;

    class function Random(const MaxValue:Integer = MaxInt): OLInteger;  overload; static;
    class function RandomPrime(const MaxValue:Integer = MaxInt): OLInteger; overload; static;

    procedure SetRandom(const MinValue: Integer; const MaxValue:Integer); overload;
    procedure SetRandom(const MaxValue:Integer = MaxInt); overload;

    procedure SetRandomPrime(const MinValue: Integer; const MaxValue:Integer); overload;
    procedure SetRandomPrime(const MaxValue:Integer = MaxInt); overload;

    class operator Add(const a, b: OLInteger): OLInteger;
    class operator Subtract(const a, b: OLInteger): OLInteger;
    class operator Multiply(const a, b: OLInteger): OLInteger;
    class operator IntDivide(const a, b: OLInteger): OLInteger;
    class operator Divide(const a, b: OLInteger): OLDouble;
    class operator Divide(const a: Extended; const b: OLInteger): OLDouble;
    class operator Divide(const a: OLInteger; const b: Extended): OLDouble;
    class operator Divide(const a: OLDouble; const b: OLInteger): OLDouble;
    class operator Divide(const a: OLInteger; const b: OLDouble): OLDouble;
    class operator Modulus(const a, b: OLInteger): OLInteger;
    class operator BitwiseXor(const a, b: OLInteger): OLInteger;

    class operator Implicit(const a: integer): OLInteger;
    class operator Implicit(const a: OLInteger): integer;
    class operator Implicit(const a: OLInteger): Double;
    class operator Implicit(const a: Variant): OLInteger;
    class operator Implicit(const a: OLInteger): Variant;
    class operator Implicit(const a: OLInteger): OLDouble;

    class operator Inc(a: OLInteger): OLInteger;
    class operator Dec(a: OLInteger): OLInteger;
    class operator Negative(const a: OLInteger): OLInteger;

    class operator Equal(const a, b: OLInteger): OLBoolean; overload;
    class operator NotEqual(const a, b: OLInteger): OLBoolean;  overload;
    class operator GreaterThan(const a, b: OLInteger): OLBoolean;  overload;
    class operator GreaterThanOrEqual(const a, b: OLInteger): OLBoolean;  overload;
    class operator LessThan(const a, b: OLInteger): OLBoolean;  overload;
    class operator LessThanOrEqual(const a, b: OLInteger): OLBoolean;  overload;

    class operator Equal(const a: OLInteger; const b: Extended): OLBoolean;  overload;
    class operator NotEqual(const a: OLInteger; const b: Extended): OLBoolean;  overload;
    class operator GreaterThan(const a: OLInteger; const b: Extended): OLBoolean;  overload;
    class operator GreaterThanOrEqual(const a: OLInteger; const b: Extended): OLBoolean;  overload;
    class operator LessThan(const a: OLInteger; const b: Extended): OLBoolean;  overload;
    class operator LessThanOrEqual(const a: OLInteger; const b: Extended): OLBoolean;  overload;
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
  if Self.ValuePresent then
    Result := System.Abs(Self.Value)
  else
    Result := Null;
end;

class operator OLInteger.Add(const a, b: OLInteger): OLInteger;

var
  returnrec: OLInteger;
begin
  returnrec.Value := a.Value + b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLInteger.Between(const BottomIncluded, TopIncluded: OLInteger):
    OLBoolean;
begin
  Result := (Value <= TopIncluded) and (Value >= BottomIncluded);
end;

class operator OLInteger.BitwiseXor(const a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin
  returnrec.Value := a.Value xor b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLInteger.Implicit(const a: integer): OLInteger;
var
  OutPut: OLInteger;
begin
  OutPut.Value := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLInteger.Implicit(const a: OLInteger): integer;
var
  OutPut: integer;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as integer value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLInteger.Dec(a: OLInteger): OLInteger;
begin
  System.Dec(&a.Value);
  Result := a;
end;

class operator OLInteger.Divide(const a: Extended; const b: OLInteger):
    OLDouble;
var
  OutPut: OLDouble;
begin
  if not b.ValuePresent then
    OutPut := Null
  else
    OutPut := a / b.Value;

  Result := OutPut;
end;

class operator OLInteger.Divide(const a: OLInteger; const b: Extended):
    OLDouble;
var
  OutPut: OLDouble;
begin
  if not a.ValuePresent then
    OutPut := Null
  else
    OutPut := a.Value / b;

  Result := OutPut;
end;

class operator OLInteger.Equal(const a: OLInteger; const b: Extended):
    OLBoolean;
begin
  Result := (a.Value = b) and a.ValuePresent;
end;

class operator OLInteger.Divide(const a, b: OLInteger): OLDouble;
var
  OutPut: OLDouble;
begin
  if (not a.ValuePresent) or (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a.Value / b.Value;

  Result := OutPut;
end;

function OLInteger.IsDividableBy(const i: integer): OLBoolean;
begin
  Result := Self.ValuePresent and ((Self.Value mod i) = 0);
end;

class operator OLInteger.Equal(const a, b: OLInteger): OLBoolean;
begin
  Result := ((a.Value = b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

procedure OLInteger.ForLoop(const InitialValue: integer; const ToValue:
    integer; const Proc: TProc);
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

class operator OLInteger.GreaterThan(const a, b: OLInteger): OLBoolean;
begin
  Result := (a.Value > b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLInteger.GreaterThanOrEqual(const a, b: OLInteger): OLBoolean;
begin
  Result := ((a.Value >= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLInteger.IfNull(const i: OLInteger): OLInteger;
var
  Output: OLInteger;
begin
  if ValuePresent then
    Output := Self
  else
    Output := i;

  Result := Output;
end;

class operator OLInteger.Implicit(const a: OLInteger): Double;
var
  OutPut: Double;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as Double value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLInteger.Implicit(const a: Variant): OLInteger;
var
  OutPut: OLInteger;
  i: integer;
begin
  if VarIsNull(a) then
    OutPut.ValuePresent := false
  else
  begin
    if TryStrToInt(a, i) then
    begin
      OutPut.Value := i;
      OutPut.ValuePresent := true;
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

function OLInteger.Increased(const IncreasedBy: integer = 1): OLInteger;
begin
  Result := Self + IncreasedBy;
end;

function OLInteger.Decreased(const DecreasedBy: integer = 1): OLInteger;
begin
  Result := Self - DecreasedBy;
end;

class operator OLInteger.IntDivide(const a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;

  if (returnrec.ValuePresent) then
    returnrec.Value := a.Value div b.Value;

  Result := returnrec;
end;

function OLInteger.IsNull: OLBoolean;
begin
  Result := not ValuePresent;
end;

class operator OLInteger.LessThan(const a, b: OLInteger): OLBoolean;
begin
  Result := (a.Value < b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLInteger.LessThanOrEqual(const a, b: OLInteger): OLBoolean;
begin
  Result := ((a.Value <= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLInteger.Max(const i: OLInteger): OLInteger;
begin
  if (not ValuePresent) or (i = Null) then
    raise Exception.Create('Null value cannot be compared to integer.');

  Result := Math.Max(Value, i);
end;

function OLInteger.Min(const i: OLInteger): OLInteger;
begin
  if (not ValuePresent) or (i = Null) then
    raise Exception.Create('Null value cannot be compared to integer.');

  Result := Math.Min(Value, i);
end;

class operator OLInteger.Modulus(const a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin
  returnrec.Value := a.Value mod b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLInteger.Multiply(const a, b: OLInteger): OLInteger;

var
  returnrec: OLInteger;
begin
  returnrec.Value := a.Value * b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLInteger.Negative(const a: OLInteger): OLInteger;
var
  b: OLInteger;
begin
  b.Value := -a.Value;
  b.ValuePresent := a.ValuePresent;
  Result := b;
end;

class operator OLInteger.NotEqual(const a: OLInteger; const b: Extended):
    OLBoolean;
begin
  Result := (a.Value <> b) and a.ValuePresent;
end;

function OLInteger.Power(const Exponent: integer): Double;
begin
  Result := Math.IntPower(Value, Exponent);
end;

function OLInteger.IsNegative: OLBoolean;
begin
  Result := ValuePresent and (Value < 0);
end;

function OLInteger.IsNonNegative: OLBoolean;
begin
  Result := ValuePresent and (Value >= 0);
end;

class operator OLInteger.NotEqual(const a, b: OLInteger): OLBoolean;
begin
  Result := ((a.Value <> b.Value) and a.ValuePresent and b.ValuePresent) or (a.ValuePresent <> b.ValuePresent);
end;

function OLInteger.Power(const Exponent: LongWord): OLInteger;
var
  returnrec: OLInteger;
begin
  returnrec.Value := Math.Floor(Math.IntPower(Value, Exponent));
  returnrec.ValuePresent := ValuePresent;
  Result := returnrec;
end;


class function OLInteger.Random(const MinValue: Integer; const
    MaxValue:Integer): OLInteger;
begin
  Result := MinValue + system.Random(MaxValue - MinValue + 1);
end;

class function OLInteger.RandomPrime(const MinValue: Integer; const
    MaxValue:Integer): OLInteger;
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
  Result := ValuePresent and (not IsEven());
end;

function OLInteger.IsPositive: OLBoolean;
begin
  Result := ValuePresent and (Value > 0);
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
  if Self.ValuePresent then
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

procedure OLInteger.SetHasValue(const Value: OLBoolean);
begin
  if Value then
    NullFlag := NonEmptyStr
  else
    NullFlag := EmptyStr;
end;

procedure OLInteger.SetRandom(const MaxValue:Integer = MaxInt);
begin
  Self.Value := OLInteger.Random(MaxValue);
  Self.ValuePresent := True;
end;

procedure OLInteger.SetRandom(const MinValue: Integer; const MaxValue:Integer);
begin
  Self.Value := OLInteger.Random(MinValue, MaxValue);
  Self.ValuePresent := True;
end;

procedure OLInteger.SetRandomPrime(const MaxValue:Integer = MaxInt);
begin
  Self.Value := OLInteger.RandomPrime(MaxValue);
  Self.ValuePresent := True;
end;

procedure OLInteger.SetRandomPrime(const MinValue: Integer; const
    MaxValue:Integer);
begin
  Self.Value := OLInteger.RandomPrime(MinValue, MaxValue);
  Self.ValuePresent := True;
end;

function OLInteger.Sqr: OLInteger;
var
  returnrec: OLInteger;
begin
  returnrec.Value := Value * Value;
  returnrec.ValuePresent := ValuePresent;
  Result := returnrec;
end;

class operator OLInteger.Subtract(const a, b: OLInteger): OLInteger;

var
  returnrec: OLInteger;
begin
  returnrec.Value := a.Value - b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLInteger.ToString: string;
var
  Output: string;
begin
  if ValuePresent then
    Output := IntToStr(Value)
  else
    Output := '';

  Result := Output;
end;

class function OLInteger.Random(const MaxValue:Integer = MaxInt): OLInteger;
begin
  Result := OLInteger.Random(0, MaxValue);
end;

class function OLInteger.RandomPrime(const MaxValue:Integer = MaxInt):
    OLInteger;
begin
  Result := OLInteger.RandomPrime(0, MaxValue);
end;

function OLInteger.Replaced(const FromValue: OLInteger; const ToValue:
    OLInteger): OLInteger;
var
  Output: OLInteger;
begin
  if Self = FromValue then
    Output := ToValue
  else
    Output := Self;

  Result := Output;
end;

function OLInteger.Round(const Digits: OLInteger): OLInteger;
begin
  Result := Math.RoundTo(Self, Digits);
end;

class operator OLInteger.Implicit(const a: OLInteger): Variant;
var
  OutPut: Variant;
begin
  if a.ValuePresent then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLInteger.GreaterThan(const a: OLInteger; const b: Extended):
    OLBoolean;
begin
  Result := (a.Value > b) and a.ValuePresent;
end;

class operator OLInteger.GreaterThanOrEqual(const a: OLInteger; const b:
    Extended): OLBoolean;
begin
  Result := (a.Value >= b) and a.ValuePresent;
end;

function OLInteger.HasValue: OLBoolean;
begin
  Result := ValuePresent;
end;

class operator OLInteger.LessThan(const a: OLInteger; const b: Extended):
    OLBoolean;
begin
  Result := (a.Value < b) and a.ValuePresent;
end;

class operator OLInteger.LessThanOrEqual(const a: OLInteger; const b:
    Extended): OLBoolean;
begin
  Result := (a.Value <= b) and a.ValuePresent;
end;

class operator OLInteger.Implicit(const a: OLInteger): OLDouble;
var
  OutPut: OLDouble;
begin
  if a.ValuePresent then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLInteger.Divide(const a: OLDouble; const b: OLInteger):
    OLDouble;
var
  OutPut: OLDouble;
begin
  if (a.IsNull()) or (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a / b.Value;

  Result := OutPut;
end;

class operator OLInteger.Divide(const a: OLInteger; const b: OLDouble):
    OLDouble;
var
  OutPut: OLDouble;
begin
  if (not a.ValuePresent) or (b.IsNull) then
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
