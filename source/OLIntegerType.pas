unit OLIntegerType;

interface

uses
  variants, SysUtils, OLBooleanType, OLDoubleType, System.Threading;

type
  OLInteger = record
  private
    Value: integer;
    NullFlag: string;

    FutureObject: IFuture<OLInteger>;

    function GetHasValue(): OLBoolean;
    procedure SetHasValue(const Value: OLBoolean);
    function GetBinary: string;
    function GetHexidecimal: string;
    function GetNumeralSystem32: string;
    function GetNumeralSystem64: string;
    function GetOctal: string;
    procedure SetBinary(const Value: string);
    procedure SetHexidecimal(const Value: string);
    procedure SetNumeralSystem32(const Value: string);
    procedure SetNumeralSystem64(const Value: string);
    procedure SetOctal(const Value: string);
    property ValuePresent: OLBoolean read GetHasValue write SetHasValue;
    procedure WaitForFuture();
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
    function ToSQLString(): string;
    function IfNull(const i: OLInteger): OLInteger;
    function AsInteger(const NullReplacement: Integer = 0): Integer;
    function Round(const Digits: OLInteger): OLInteger;
    function Between(const BottomIncluded, TopIncluded: OLInteger): OLBoolean;
    function Increased(const IncreasedBy: integer = 1): OLInteger;
    function Decreased(const DecreasedBy: integer = 1): OLInteger;
    function Replaced(const FromValue: OLInteger; const ToValue: OLInteger): OLInteger;


    function ToNumeralSystem(const Base: Integer): string;

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
    class operator Multiply(const a: Integer; const b: OLInteger): OLInteger;
    class operator Multiply(const a: OLInteger; const b: Integer): OLInteger;
    class operator Multiply(const a: Extended; const b: OLInteger): OLDouble;
    class operator Multiply(const a: OLInteger; const b: Extended): OLDouble;
    class operator Multiply(const a: OLDouble; const b: OLInteger): OLDouble;
    class operator Multiply(const a: OLInteger; const b: OLDouble): OLDouble;
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

    class operator Implicit(const a: IFuture<OLInteger>): OLInteger;

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

    property Binary: string read GetBinary write SetBinary;
    property Octal: string read GetOctal write SetOctal;
    property Hexidecimal: string read GetHexidecimal write SetHexidecimal;
    property NumeralSystem32: string read GetNumeralSystem32 write SetNumeralSystem32;
    property NumeralSystem64: string read GetNumeralSystem64 write SetNumeralSystem64;
  end;

  POLInteger = ^OLInteger;

implementation

uses
  Math, NumeralSystemConvert;

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
  WaitForFuture();

  if Self.ValuePresent then
    Result := System.Abs(Self.Value)
  else
    Result := Null;
end;

class operator OLInteger.Add(const a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin
  a.WaitForFuture();
  b.WaitForFuture();

  returnrec.Value := a.Value + b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLInteger.AsInteger(const NullReplacement: Integer): Integer;
begin
  WaitForFuture();

  Result := IfNull(NullReplacement);
end;

function OLInteger.Between(const BottomIncluded, TopIncluded: OLInteger):
    OLBoolean;
var
  OutPut: OLBoolean;
begin
  WaitForFuture();

  if HasValue() then
    OutPut := ((Value <= TopIncluded) and (Value >= BottomIncluded))
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLInteger.BitwiseXor(const a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin
  a.WaitForFuture();
  b.WaitForFuture();

  returnrec.Value := a.Value xor b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLInteger.ToNumeralSystem(const Base: Integer): string;
begin
  WaitForFuture();

  Result := ConvertNumeralSystem(Self, Base);
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
  a.WaitForFuture();

  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as integer value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLInteger.Dec(a: OLInteger): OLInteger;
begin
  a.WaitForFuture();

  System.Dec(&a.Value);
  Result := a;
end;

class operator OLInteger.Divide(const a: Extended; const b: OLInteger):
    OLDouble;
var
  OutPut: OLDouble;
begin
  b.WaitForFuture();

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
  a.WaitForFuture();

  if not a.ValuePresent then
    OutPut := Null
  else
    OutPut := a.Value / b;

  Result := OutPut;
end;

class operator OLInteger.Equal(const a: OLInteger; const b: Extended):
    OLBoolean;
begin
  a.WaitForFuture();

  Result := (a.Value = b) and a.ValuePresent;
end;

class operator OLInteger.Divide(const a, b: OLInteger): OLDouble;
var
  OutPut: OLDouble;
begin
  a.WaitForFuture();
  b.WaitForFuture();

  if (not a.ValuePresent) or (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a.Value / b.Value;

  Result := OutPut;
end;

function OLInteger.IsDividableBy(const i: integer): OLBoolean;
begin
  WaitForFuture();

  Result := Self.ValuePresent and ((Self.Value mod i) = 0);
end;

class operator OLInteger.Equal(const a, b: OLInteger): OLBoolean;
begin
  a.WaitForFuture();
  b.WaitForFuture();

  Result := ((a.Value = b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

procedure OLInteger.ForLoop(const InitialValue: integer; const ToValue:
    integer; const Proc: TProc);
var
  iterator: integer;
begin
  WaitForFuture();

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
  WaitForFuture();

  Result := Self.IsDividableBy(2);
end;

function OLInteger.GetBinary: string;
begin
  WaitForFuture();

  Result := ToNumeralSystem(2);
end;

function OLInteger.GetHasValue: OLBoolean;
begin
  WaitForFuture();

  Result := (NullFlag <> EmptyStr);
end;

function OLInteger.GetHexidecimal: string;
begin
  WaitForFuture();

  Result := ToNumeralSystem(16);
end;

function OLInteger.GetNumeralSystem32: string;
begin
  WaitForFuture();

  Result := ToNumeralSystem(32);
end;

function OLInteger.GetNumeralSystem64: string;
begin
  WaitForFuture();

  Result := ToNumeralSystem(64);
end;

function OLInteger.GetOctal: string;
begin
  WaitForFuture();

  Result := ToNumeralSystem(8);
end;

class operator OLInteger.GreaterThan(const a, b: OLInteger): OLBoolean;
begin
  a.WaitForFuture();
  b.WaitForFuture();

  Result := (a.Value > b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLInteger.GreaterThanOrEqual(const a, b: OLInteger): OLBoolean;
begin
  a.WaitForFuture();
  b.WaitForFuture();

  Result := ((a.Value >= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLInteger.IfNull(const i: OLInteger): OLInteger;
var
  Output: OLInteger;
begin
  WaitForFuture();

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
  a.WaitForFuture();

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
  a.WaitForFuture();

  System.Inc(&a.Value);
  Result := a;
end;

function OLInteger.Increased(const IncreasedBy: integer = 1): OLInteger;
begin
  WaitForFuture();

  Result := Self + IncreasedBy;
end;

function OLInteger.Decreased(const DecreasedBy: integer = 1): OLInteger;
begin
  WaitForFuture();

  Result := Self - DecreasedBy;
end;

class operator OLInteger.IntDivide(const a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin
  a.WaitForFuture();
  b.WaitForFuture();

  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;

  if (returnrec.ValuePresent) then
    returnrec.Value := a.Value div b.Value;

  Result := returnrec;
end;

function OLInteger.IsNull: OLBoolean;
begin
  WaitForFuture();

  Result := not ValuePresent;
end;

class operator OLInteger.LessThan(const a, b: OLInteger): OLBoolean;
begin
  a.WaitForFuture();
  b.WaitForFuture();

  Result := (a.Value < b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLInteger.LessThanOrEqual(const a, b: OLInteger): OLBoolean;
begin
  a.WaitForFuture();
  b.WaitForFuture();

  Result := ((a.Value <= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLInteger.Max(const i: OLInteger): OLInteger;
begin
  WaitForFuture();
  i.WaitForFuture();
  
  if (not ValuePresent) or (i = Null) then
    raise Exception.Create('Null value cannot be compared to integer.');

  Result := Math.Max(Value, i);
end;

function OLInteger.Min(const i: OLInteger): OLInteger;
begin
  WaitForFuture();
  i.WaitForFuture();

  if (not ValuePresent) or (i = Null) then
    raise Exception.Create('Null value cannot be compared to integer.');

  Result := Math.Min(Value, i);
end;

class operator OLInteger.Modulus(const a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin
  a.WaitForFuture();
  b.WaitForFuture();

  returnrec.Value := a.Value mod b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLInteger.Multiply(const a: Extended;
  const b: OLInteger): OLDouble;
var
  OutPut: OLDouble;
begin
  b.WaitForFuture();

  if b.IsNull then
    OutPut := Null
  else
    OutPut := a * b.Value;

  Result := OutPut;
end;

class operator OLInteger.Multiply(const a: OLInteger;
  const b: Extended): OLDouble;
var
  OutPut: OLDouble;
begin
  a.WaitForFuture();

  if not a.ValuePresent then
    OutPut := Null
  else
    OutPut := a.Value * b;

  Result := OutPut;
end;

class operator OLInteger.Multiply(const a: OLDouble;
  const b: OLInteger): OLDouble;
var
  OutPut: OLDouble;
begin
  b.WaitForFuture();

  if (a.IsNull()) or (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a * b.Value;

  Result := OutPut;
end;

class operator OLInteger.Multiply(const a: OLInteger;
  const b: OLDouble): OLDouble;
var
  OutPut: OLDouble;
begin
  a.WaitForFuture();

  if (not a.ValuePresent) or (b.IsNull) then
    OutPut := Null
  else
    OutPut := a.Value * b;

  Result := OutPut;
end;

class operator OLInteger.Multiply(const a: OLInteger;
  const b: Integer): OLInteger;
var
  returnrec: OLInteger;
begin
  a.WaitForFuture();

  returnrec.Value := a.Value * b;
  returnrec.ValuePresent := a.ValuePresent;
  Result := returnrec;
end;

class operator OLInteger.Multiply(const a: Integer;
  const b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin
  b.WaitForFuture();

  returnrec.Value := a * b.Value;
  returnrec.ValuePresent := b.ValuePresent;
  Result := returnrec;
end;

class operator OLInteger.Multiply(const a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin
  a.WaitForFuture();
  b.WaitForFuture();

  returnrec.Value := a.Value * b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLInteger.Negative(const a: OLInteger): OLInteger;
var
  b: OLInteger;
begin
  a.WaitForFuture();

  b.Value := -a.Value;
  b.ValuePresent := a.ValuePresent;
  Result := b;
end;

class operator OLInteger.NotEqual(const a: OLInteger; const b: Extended):
    OLBoolean;
begin
  a.WaitForFuture();

  Result := (a.Value <> b) and a.ValuePresent;
end;

function OLInteger.Power(const Exponent: integer): Double;
begin
  WaitForFuture();

  Result := Math.IntPower(Value, Exponent);
end;

function OLInteger.IsNegative: OLBoolean;
begin
  WaitForFuture();

  Result := ValuePresent and (Value < 0);
end;

function OLInteger.IsNonNegative: OLBoolean;
begin
  WaitForFuture();

  Result := ValuePresent and (Value >= 0);
end;

class operator OLInteger.NotEqual(const a, b: OLInteger): OLBoolean;
begin
  a.WaitForFuture();
  b.WaitForFuture();

  Result := ((a.Value <> b.Value) and a.ValuePresent and b.ValuePresent) or (a.ValuePresent <> b.ValuePresent);
end;

function OLInteger.Power(const Exponent: LongWord): OLInteger;
var
  returnrec: OLInteger;
begin
  WaitForFuture();

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
  WaitForFuture();

  Result := ValuePresent and (not IsEven());
end;

function OLInteger.IsPositive: OLBoolean;
begin
  WaitForFuture();

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
  WaitForFuture();

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

procedure OLInteger.SetBinary(const Value: string);
begin
  WaitForFuture();

  Self := ConvertNumeralSystem(Value, 2);
end;

procedure OLInteger.SetHasValue(const Value: OLBoolean);
begin
  WaitForFuture();

  if Value then
    NullFlag := NonEmptyStr
  else
    NullFlag := EmptyStr;
end;

procedure OLInteger.SetHexidecimal(const Value: string);
begin
  WaitForFuture();

  Self := ConvertNumeralSystem(Value, 16);
end;

procedure OLInteger.SetNumeralSystem32(const Value: string);
begin
  WaitForFuture();

  Self := ConvertNumeralSystem(Value, 32);
end;

procedure OLInteger.SetNumeralSystem64(const Value: string);
begin
  WaitForFuture();

  Self := ConvertNumeralSystem(Value, 64);
end;

procedure OLInteger.SetOctal(const Value: string);
begin
  WaitForFuture();

  Self := ConvertNumeralSystem(Value, 8);
end;

procedure OLInteger.SetRandom(const MaxValue:Integer = MaxInt);
begin
  WaitForFuture();

  Self.Value := OLInteger.Random(MaxValue);
  Self.ValuePresent := True;
end;

procedure OLInteger.SetRandom(const MinValue: Integer; const MaxValue:Integer);
begin
  WaitForFuture();

  Self.Value := OLInteger.Random(MinValue, MaxValue);
  Self.ValuePresent := True;
end;

procedure OLInteger.SetRandomPrime(const MaxValue:Integer = MaxInt);
begin
  WaitForFuture();

  Self.Value := OLInteger.RandomPrime(MaxValue);
  Self.ValuePresent := True;
end;

procedure OLInteger.SetRandomPrime(const MinValue: Integer; const
    MaxValue:Integer);
begin
  WaitForFuture();

  Self.Value := OLInteger.RandomPrime(MinValue, MaxValue);
  Self.ValuePresent := True;
end;

function OLInteger.Sqr: OLInteger;
var
  returnrec: OLInteger;
begin
  WaitForFuture();

  returnrec.Value := Value * Value;
  returnrec.ValuePresent := ValuePresent;
  Result := returnrec;
end;

class operator OLInteger.Subtract(const a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin
  a.WaitForFuture();
  b.WaitForFuture();

  returnrec.Value := a.Value - b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLInteger.ToSQLString: string;
var
  OutPut: string;
begin
  WaitForFuture();

  if HasValue then
    OutPut := ToString()
  else
    OutPut := 'NULL';

  Result := OutPut;
end;

procedure OLInteger.WaitForFuture();
begin
  if Assigned(FutureObject) then
  begin
    FutureObject.Wait();
    Self := FutureObject.Value;
    FutureObject := nil;
  end;

end;

function OLInteger.ToString: string;
var
  Output: string;
begin
  WaitForFuture();

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
  WaitForFuture();

  if Self = FromValue then
    Output := ToValue
  else
    Output := Self;

  Result := Output;
end;

function OLInteger.Round(const Digits: OLInteger): OLInteger;
begin
  WaitForFuture();
  Digits.WaitForFuture();
  
  Result := Math.RoundTo(Self, Digits);
end;

class operator OLInteger.Implicit(const a: OLInteger): Variant;
var
  OutPut: Variant;
begin
  a.WaitForFuture();

  if a.ValuePresent then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLInteger.GreaterThan(const a: OLInteger; const b: Extended):
    OLBoolean;
begin
  a.WaitForFuture();

  Result := (a.Value > b) and a.ValuePresent;
end;

class operator OLInteger.GreaterThanOrEqual(const a: OLInteger; const b:
    Extended): OLBoolean;
begin
  a.WaitForFuture();

  Result := (a.Value >= b) and a.ValuePresent;
end;

function OLInteger.HasValue: OLBoolean;
begin
  WaitForFuture();

  Result := ValuePresent;
end;

class operator OLInteger.LessThan(const a: OLInteger; const b: Extended):
    OLBoolean;
begin
  a.WaitForFuture();

  Result := (a.Value < b) and a.ValuePresent;
end;

class operator OLInteger.LessThanOrEqual(const a: OLInteger; const b:
    Extended): OLBoolean;
begin
  a.WaitForFuture();

  Result := (a.Value <= b) and a.ValuePresent;
end;

class operator OLInteger.Implicit(const a: OLInteger): OLDouble;
var
  OutPut: OLDouble;
begin
  a.WaitForFuture();

  if a.ValuePresent then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLInteger.Implicit(const a: IFuture<OLInteger>): OLInteger;
var
  OutPut: OLInteger;
begin
  OutPut.FutureObject := a;
  Result := OutPut;
end;

class operator OLInteger.Divide(const a: OLDouble; const b: OLInteger):
    OLDouble;
var
  OutPut: OLDouble;
begin
  b.WaitForFuture();

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
  a.WaitForFuture();

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
