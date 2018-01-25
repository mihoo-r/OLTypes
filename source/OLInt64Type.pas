unit OLInt64Type;

interface

uses
  variants, SysUtils, OLBooleanType, OLDoubleType, OLIntegerType;

type
  OLInt64 = record
  private
    Value: Int64;
    NullFlag: string;

    function GetHasValue(): OLBoolean;
    procedure SetHasValue(Value: OLBoolean);
    property ValuePresent: OLBoolean read GetHasValue write SetHasValue;
  public
    function IsDividableBy(i: Int64): OLBoolean;
    function IsOdd(): OLBoolean;
    function IsEven(): OLBoolean;
    function Sqr(): OLInt64;
    function Power(Exponent: LongWord): OLInt64; overload;
    function Power(Exponent: Int64): Double; overload;
    function IsPositive(): OLBoolean;
    function IsNegative(): OLBoolean;
    function IsNonNegative(): OLBoolean;
    function Max(i: OLInt64): OLInt64;
    function Min(i: OLInt64): OLInt64;
    function Abs(): OLInt64;
    function IsNull(): OLBoolean;
    function HasValue(): OLBoolean;
    function ToString(): string;
    function IfNull(i: OLInt64): OLInt64;
    function Round(Digits: OLInt64): OLInt64;
    function Between(BottomIncluded, TopIncluded: OLInt64): OLBoolean;
    function Increased(IncreasedBy: Int64 = 1): OLInt64;
    function Decreased(DecreasedBy: Int64 = 1): OLInt64;
    function Replaced(FromValue: OLInt64; ToValue: OLInt64): OLInt64;

    procedure ForLoop(InitialValue: Int64; ToValue: Int64; Proc: TProc);
    function IsPrime(): OLBoolean;
    class function Random(MinValue: Int64; MaxValue:Int64): OLInt64;  overload; static;
    class function RandomPrime(MinValue: Int64; MaxValue:Int64): OLInt64; overload; static;

    class function Random(MaxValue:Int64 = MaxInt): OLInt64;  overload; static;
    class function RandomPrime(MaxValue:Int64 = MaxInt): OLInt64; overload; static;

    procedure SetRandom(MinValue: Int64; MaxValue:Int64); overload;
    procedure SetRandom(MaxValue:Int64 = MaxInt); overload;

    procedure SetRandomPrime(MinValue: Int64; MaxValue:Int64); overload;
    procedure SetRandomPrime(MaxValue:Int64 = MaxInt); overload;

    class operator Add(a, b: OLInt64): OLInt64;
    class operator Subtract(a, b: OLInt64): OLInt64;
    class operator Multiply(a, b: OLInt64): OLInt64;
    class operator IntDivide(a, b: OLInt64): OLInt64;
    class operator Divide(a, b: OLInt64): OLDouble;
    class operator Divide(a: Extended; b: OLInt64): OLDouble;
    class operator Divide(a: OLInt64; b: Extended): OLDouble;
    class operator Divide(a: OLDouble; b: OLInt64): OLDouble;
    class operator Divide(a: OLInt64; b: OLDouble): OLDouble;
    class operator Modulus(a, b: OLInt64): OLInt64;
    class operator BitwiseXor(a, b: OLInt64): OLInt64;

    class operator Implicit(a: Int64): OLInt64;
    class operator Implicit(a: OLInt64): Int64;

    class operator Implicit(a: Integer): OLInt64;
    class operator Implicit(a: OLInt64): Integer;

    class operator Implicit(a: OLInteger): OLInt64;
    class operator Implicit(a: OLInt64): OLInteger;

    class operator Implicit(a: OLInt64): Double;
    class operator Implicit(a: Variant): OLInt64;

    class operator Implicit(a: OLInt64): Variant;
    class operator Implicit(a: OLInt64): OLDouble;

    class operator Inc(a: OLInt64): OLInt64;
    class operator Dec(a: OLInt64): OLInt64;
    class operator Negative(a: OLInt64): OLInt64;

    class operator Equal(a, b: OLInt64): OLBoolean; overload;
    class operator NotEqual(a, b: OLInt64): OLBoolean;  overload;
    class operator GreaterThan(a, b: OLInt64): OLBoolean;  overload;
    class operator GreaterThanOrEqual(a, b: OLInt64): OLBoolean;  overload;
    class operator LessThan(a, b: OLInt64): OLBoolean;  overload;
    class operator LessThanOrEqual(a, b: OLInt64): OLBoolean;  overload;

    class operator Equal(a: OLInt64; b: Extended): OLBoolean;  overload;
    class operator NotEqual(a: OLInt64; b: Extended): OLBoolean;  overload;
    class operator GreaterThan(a: OLInt64; b: Extended): OLBoolean;  overload;
    class operator GreaterThanOrEqual(a: OLInt64; b: Extended): OLBoolean;  overload;
    class operator LessThan(a: OLInt64; b: Extended): OLBoolean;  overload;
    class operator LessThanOrEqual(a: OLInt64; b: Extended): OLBoolean;  overload;
  end;

implementation

uses
  Math;

const
  NonEmptyStr = ' ';

var
  primes: array of Int64;

procedure AddPrime(n: Int64);
var
  l: Int64;
begin
  l := length(primes);
  SetLength(primes, l + 1);
  primes[l] := n;
end;

function OLInt64.Abs(): OLInt64;
begin
  if Self.ValuePresent then
    Result := System.Abs(Self.Value)
  else
    Result := Null;
end;

class operator OLInt64.Add(a, b: OLInt64): OLInt64;

var
  returnrec: OLInt64;
begin
  returnrec.Value := a.Value + b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLInt64.Between(BottomIncluded, TopIncluded: OLInt64): OLBoolean;
begin
  Result := (Value <= TopIncluded) and (Value >= BottomIncluded);
end;

class operator OLInt64.BitwiseXor(a, b: OLInt64): OLInt64;
var
  returnrec: OLInt64;
begin
  returnrec.Value := a.Value xor b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLInt64.Implicit(a: Int64): OLInt64;
var
  OutPut: OLInt64;
begin
  OutPut.Value := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLInt64.Implicit(a: OLInt64): Int64;
var
  OutPut: Int64;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as Int64 value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLInt64.Dec(a: OLInt64): OLInt64;
begin
  System.Dec(&a.Value);
  Result := a;
end;

function OLInt64.Decreased(DecreasedBy: Int64): OLInt64;
begin
  Result := Self - DecreasedBy;
end;

class operator OLInt64.Divide(a: Extended; b: OLInt64): OLDouble;
var
  OutPut: OLDouble;
begin
  if not b.ValuePresent then
    OutPut := Null
  else
    OutPut := a / b.Value;

  Result := OutPut;
end;

class operator OLInt64.Divide(a: OLInt64; b: Extended): OLDouble;
var
  OutPut: OLDouble;
begin
  if not a.ValuePresent then
    OutPut := Null
  else
    OutPut := a.Value / b;

  Result := OutPut;
end;

class operator OLInt64.Equal(a: OLInt64; b: Extended): OLBoolean;
begin
  Result := (a.Value = b) and a.ValuePresent;
end;

class operator OLInt64.Divide(a, b: OLInt64): OLDouble;
var
  OutPut: OLDouble;
begin
  if (not a.ValuePresent) or (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a.Value / b.Value;

  Result := OutPut;
end;

function OLInt64.IsDividableBy(i: Int64): OLBoolean;
begin
  Result := Self.ValuePresent and ((Self.Value mod i) = 0);
end;

class operator OLInt64.Equal(a, b: OLInt64): OLBoolean;
begin
  Result := ((a.Value = b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

procedure OLInt64.ForLoop(InitialValue, ToValue: Int64; Proc: TProc);
var
  iterator: Int64;
begin
  if InitialValue < ToValue then
  begin
    iterator := InitialValue;
    while iterator <= ToValue do
    begin
      Self := iterator;
      Proc();
      iterator := iterator + 1;
    end;
  end
  else
  begin
    iterator := InitialValue;
    while iterator >= ToValue do
    begin
      Self := iterator;
      Proc();
      iterator := iterator - 1;
    end;
  end;
end;

function OLInt64.IsEven: OLBoolean;
begin
  Result := Self.IsDividableBy(2);
end;

function OLInt64.GetHasValue: OLBoolean;
begin
  Result := (NullFlag <> EmptyStr);
end;

class operator OLInt64.GreaterThan(a, b: OLInt64): OLBoolean;
begin
  Result := (a.Value > b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLInt64.GreaterThanOrEqual(a, b: OLInt64): OLBoolean;
begin
  Result := ((a.Value >= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLInt64.IfNull(i: OLInt64): OLInt64;
var
  Output: OLInt64;
begin
  if ValuePresent then
    Output := Self
  else
    Output := i;

  Result := Output;
end;

class operator OLInt64.Implicit(a: OLInt64): Double;
var
  OutPut: Double;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as Double value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLInt64.Implicit(a: Variant): OLInt64;
var
  OutPut: OLInt64;
  i: Int64;
begin
  if VarIsNull(a) then
    OutPut.ValuePresent := false
  else
  begin
    if TryStrToInt64(a, i) then
    begin
      OutPut.Value := i;
      OutPut.ValuePresent := true;
    end
    else
    begin
      raise Exception.Create('Value ''' + VarToStr(a) + ''' cannot be assigned to variable of OLInt64 type.');
    end;
  end;

  Result := OutPut;
end;

class operator OLInt64.Inc(a: OLInt64): OLInt64;
begin
  System.Inc(&a.Value);
  Result := a;
end;

function OLInt64.Increased(IncreasedBy: Int64): OLInt64;
begin
  Result := Self + IncreasedBy;
end;

class operator OLInt64.IntDivide(a, b: OLInt64): OLInt64;
var
  returnrec: OLInt64;
begin
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;

  if (returnrec.ValuePresent) then
    returnrec.Value := a.Value div b.Value;

  Result := returnrec;
end;

function OLInt64.IsNull: OLBoolean;
begin
  Result := not ValuePresent;
end;

class operator OLInt64.LessThan(a, b: OLInt64): OLBoolean;
begin
  Result := (a.Value < b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLInt64.LessThanOrEqual(a, b: OLInt64): OLBoolean;
begin
  Result := ((a.Value <= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLInt64.Max(i: OLInt64): OLInt64;
begin
  if (not ValuePresent) or (i = Null) then
    raise Exception.Create('Null value cannot be compared to Int64.');

  Result := Math.Max(Value, i);
end;

function OLInt64.Min(i: OLInt64): OLInt64;
begin
  if (not ValuePresent) or (i = Null) then
    raise Exception.Create('Null value cannot be compared to Int64.');

  Result := Math.Min(Value, i);
end;

class operator OLInt64.Modulus(a, b: OLInt64): OLInt64;
var
  returnrec: OLInt64;
begin
  returnrec.Value := a.Value mod b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLInt64.Multiply(a, b: OLInt64): OLInt64;

var
  returnrec: OLInt64;
begin
  returnrec.Value := a.Value * b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLInt64.Negative(a: OLInt64): OLInt64;
var
  b: OLInt64;
begin
  b.Value := -a.Value;
  b.ValuePresent := a.ValuePresent;
  Result := b;
end;

class operator OLInt64.NotEqual(a: OLInt64; b: Extended): OLBoolean;
begin
  Result := (a.Value <> b) and a.ValuePresent;
end;

function OLInt64.Power(Exponent: Int64): Double;
begin
  Result := Math.IntPower(Value, Exponent);
end;

function OLInt64.IsNegative: OLBoolean;
begin
  Result := ValuePresent and (Value < 0);
end;

function OLInt64.IsNonNegative: OLBoolean;
begin
  Result := ValuePresent and (Value >= 0);
end;

class operator OLInt64.NotEqual(a, b: OLInt64): OLBoolean;
begin
  Result := ((a.Value <> b.Value) and a.ValuePresent and b.ValuePresent) or (a.ValuePresent <> b.ValuePresent);
end;

function OLInt64.Power(Exponent: LongWord): OLInt64;
var
  returnrec: OLInt64;
begin
  returnrec.Value := Math.Floor(Math.IntPower(Value, Exponent));
  returnrec.ValuePresent := ValuePresent;
  Result := returnrec;
end;


class function OLInt64.Random(MinValue: Int64; MaxValue:Int64): OLInt64;
var
  sqr: Integer;
  OutPut: OLInt64;
  MaxIntGap: Int64;
begin
  MaxIntGap := (MaxValue - MinValue - MaxInt);

  if MaxIntGap > 0 then
  begin
    sqr := Ceil(Sqrt(MaxIntGap));

    OutPut := system.Random(sqr);
    OutPut := OutPut * system.Random(sqr);

    OutPut := OutPut + System.Random(MaxInt);

    OutPut := OutPut + MinValue;
  end
  else
  begin
    OutPut := MinValue;
    OutPut := OutPut + system.Random(MaxValue - MinValue + 1)
  end;

  Result := OutPut ;
end;

class function OLInt64.RandomPrime(MinValue: Int64; MaxValue:Int64): OLInt64;
var
  new: OLInt64;
begin
  repeat
    new := OLInt64.Random(MinValue, MaxValue);
  until new.IsPrime;

  Result := new;
end;

function OLInt64.IsOdd: OLBoolean;
begin
  Result := ValuePresent and (not IsEven());
end;

function OLInt64.IsPositive: OLBoolean;
begin
  Result := ValuePresent and (Value > 0);
end;

function OLInt64.IsPrime: OLBoolean;
var
  i, j: Int64;
  PrimeLen: Int64;
  OutPut: OLBoolean;
  MaxPrimeDivader: Int64;
  PrimeAddStart, PrimeAddFinnish: Int64;
  LoopCount: Int64;
  k: OLInt64;
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

procedure OLInt64.SetHasValue(Value: OLBoolean);
begin
  if Value then
    NullFlag := NonEmptyStr
  else
    NullFlag := EmptyStr;
end;

procedure OLInt64.SetRandom(MaxValue: Int64);
begin
  Self.Value := OLInt64.Random(MaxValue);
  Self.ValuePresent := True;
end;

procedure OLInt64.SetRandom(MinValue, MaxValue: Int64);
begin
  Self.Value := OLInt64.Random(MinValue, MaxValue);
  Self.ValuePresent := True;
end;

procedure OLInt64.SetRandomPrime(MaxValue: Int64);
begin
  Self.Value := OLInt64.RandomPrime(MaxValue);
  Self.ValuePresent := True;
end;

procedure OLInt64.SetRandomPrime(MinValue, MaxValue: Int64);
begin
  Self.Value := OLInt64.RandomPrime(MinValue, MaxValue);
  Self.ValuePresent := True;
end;

function OLInt64.Sqr: OLInt64;
var
  returnrec: OLInt64;
begin
  returnrec.Value := Value * Value;
  returnrec.ValuePresent := ValuePresent;
  Result := returnrec;
end;

class operator OLInt64.Subtract(a, b: OLInt64): OLInt64;

var
  returnrec: OLInt64;
begin
  returnrec.Value := a.Value - b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLInt64.ToString: string;
var
  Output: string;
begin
  if ValuePresent then
    Output := IntToStr(Value)
  else
    Output := '';

  Result := Output;
end;

class function OLInt64.Random(MaxValue: Int64): OLInt64;
begin
  Result := OLInt64.Random(0, MaxValue);
end;

class function OLInt64.RandomPrime(MaxValue: Int64): OLInt64;
begin
  Result := OLInt64.RandomPrime(0, MaxValue);
end;

function OLInt64.Replaced(FromValue, ToValue: OLInt64): OLInt64;
var
  OutPut: OLInt64;
begin
  if Self = FromValue then
    OutPut := ToValue
  else
    OutPut := Self;

  Result := Self;
end;

function OLInt64.Round(Digits: OLInt64): OLInt64;
begin
  Result := Math.RoundTo(Self, Digits);
end;

class operator OLInt64.Implicit(a: OLInt64): Variant;
var
  OutPut: Variant;
begin
  if a.ValuePresent then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLInt64.GreaterThan(a: OLInt64; b: Extended): OLBoolean;
begin
  Result := (a.Value > b) and a.ValuePresent;
end;

class operator OLInt64.GreaterThanOrEqual(a: OLInt64;
  b: Extended): OLBoolean;
begin
  Result := (a.Value >= b) and a.ValuePresent;
end;

function OLInt64.HasValue: OLBoolean;
begin
  Result := ValuePresent;
end;

class operator OLInt64.LessThan(a: OLInt64; b: Extended): OLBoolean;
begin
  Result := (a.Value < b) and a.ValuePresent;
end;

class operator OLInt64.LessThanOrEqual(a: OLInt64; b: Extended): OLBoolean;
begin
  Result := (a.Value <= b) and a.ValuePresent;
end;

class operator OLInt64.Implicit(a: OLInt64): OLDouble;
var
  OutPut: OLDouble;
begin
  if a.ValuePresent then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLInt64.Implicit(a: OLInteger): OLInt64;
var
  OutPut: OLInt64;
begin
  if a.IsNull() then
    OutPut := Null
  else
  begin
    OutPut.Value := a;
    OutPut.ValuePresent := true;
  end;

  Result := OutPut;
end;

class operator OLInt64.Implicit(a: OLInt64): OLInteger;
var
  OutPut: Integer;
begin
  if a.IsNull() then
    OutPut := Null
  else
    OutPut := a.Value;

  Result := OutPut;
end;

class operator OLInt64.Implicit(a: Integer): OLInt64;
var
  OutPut: OLInt64;
begin
  OutPut.Value := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLInt64.Implicit(a: OLInt64): Integer;
var
  OutPut: Integer;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as Integer value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLInt64.Divide(a: OLDouble; b: OLInt64): OLDouble;
var
  OutPut: OLDouble;
begin
  if (a.IsNull()) or (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a / b.Value;

  Result := OutPut;
end;

class operator OLInt64.Divide(a: OLInt64; b: OLDouble): OLDouble;
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
