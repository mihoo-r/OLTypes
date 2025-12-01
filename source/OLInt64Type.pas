unit OLInt64Type;

interface

uses
  variants, SysUtils, OLBooleanType, OLDoubleType, OLIntegerType;

type
  /// <summary>
  ///   A record type representing a 64-bit integer with null-handling capabilities.
  /// </summary>
  OLInt64 = record
  private
    Value: Int64;
    {$IF CompilerVersion >= 34.0}
    FHasValue: Boolean;
    {$ELSE}
    FHasValue: string;
    {$IFEND}

    function GetHasValue(): OLBoolean;
    procedure SetHasValue(Value: OLBoolean);
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
    /// <summary>
    ///   Gets or sets whether the Int64 has a value (is not null).
    /// </summary>
    property ValuePresent: OLBoolean read GetHasValue write SetHasValue;
  public
    /// <summary>
    ///   Checks if the Int64 is divisible by the specified value.
    /// </summary>
    function IsDividableBy(i: Int64): OLBoolean;
    /// <summary>
    ///   Checks if the Int64 is odd.
    /// </summary>
    function IsOdd(): OLBoolean;
    /// <summary>
    ///   Checks if the Int64 is even.
    /// </summary>
    function IsEven(): OLBoolean;
    /// <summary>
    ///   Returns the square of the Int64.
    /// </summary>
    function Sqr(): OLInt64;
    /// <summary>
    ///   Returns the Int64 raised to the specified exponent.
    /// </summary>
    function Power(Exponent: LongWord): OLInt64; overload;
    /// <summary>
    ///   Returns the Int64 raised to the specified exponent as a Double.
    /// </summary>
    function Power(Exponent: Int64): Double; overload;
    /// <summary>
    ///   Checks if the Int64 is positive (> 0).
    /// </summary>
    function IsPositive(): OLBoolean;
    /// <summary>
    ///   Checks if the Int64 is negative (< 0).
    /// </summary>
    function IsNegative(): OLBoolean;
    /// <summary>
    ///   Checks if the Int64 is non-negative (>= 0).
    /// </summary>
    function IsNonNegative(): OLBoolean;
    /// <summary>
    ///   Returns the larger of the two Int64 values.
    /// </summary>
    function Max(i: OLInt64): OLInt64;
    /// <summary>
    ///   Returns the smaller of the two Int64 values.
    /// </summary>
    function Min(i: OLInt64): OLInt64;
    /// <summary>
    ///   Returns the absolute value of the Int64.
    /// </summary>
    function Abs(): OLInt64;
    /// <summary>
    ///   Checks if the Int64 is null (has no value).
    /// </summary>
    function IsNull(): OLBoolean;
    /// <summary>
    ///   Checks if the Int64 has a value (is not null).
    /// </summary>
    function HasValue(): OLBoolean;
    /// <summary>
    ///   Converts the Int64 to a string.
    /// </summary>
    function ToString(): string;
    /// <summary>
    ///   Converts the Int64 to a SQL-safe string (value or NULL).
    /// </summary>
    function ToSQLString(): string;
    /// <summary>
    ///   Returns the current Int64 if it has a value, otherwise returns the provided default value.
    /// </summary>
    function IfNull(i: OLInt64): OLInt64;
    /// <summary>
    ///   Rounds the Int64 to the specified number of digits.
    ///   A parameter value of one rounds to the nearest ten.
    ///   A parameter value of two rounds to the nearest hundred, and so on
    /// </summary>
    function Round(Digits: OLInt64): OLInt64;
    /// <summary>
    ///   Checks if the Int64 is between the specified values (inclusive).
    /// </summary>
    function Between(BottomIncluded, TopIncluded: OLInt64): OLBoolean;
    /// <summary>
    ///   Returns the Int64 increased by the specified amount.
    /// </summary>
    function Increased(IncreasedBy: Int64 = 1): OLInt64;
    /// <summary>
    ///   Returns the Int64 decreased by the specified amount.
    /// </summary>
    function Decreased(DecreasedBy: Int64 = 1): OLInt64;
    /// <summary>
    ///   Returns the Int64 with the value replaced if it matches FromValue.
    /// </summary>
    function Replaced(FromValue: OLInt64; ToValue: OLInt64): OLInt64;

    /// <summary>
    ///   Converts the Int64 to a string representation in the specified base.
    /// </summary>
    function ToNumeralSystem(const Base: Integer): string;

    /// <summary>
    ///   Executes a procedure for each value from InitialValue to ToValue.
    /// </summary>
    procedure ForLoop(InitialValue: Int64; ToValue: Int64; Proc: TProc);
    /// <summary>
    ///   Checks if the Int64 is a prime number.
    /// </summary>
    function IsPrime(): OLBoolean;
    /// <summary>
    ///   Generates a random Int64 between MinValue and MaxValue.
    /// </summary>
    class function Random(MinValue: Int64; MaxValue:Int64): OLInt64;  overload; static;
    /// <summary>
    ///   Generates a random prime number between MinValue and MaxValue.
    /// </summary>
    class function RandomPrime(MinValue: Int64; MaxValue:Int64): OLInt64; overload; static;

    /// <summary>
    ///   Generates a random Int64 up to MaxValue.
    /// </summary>
    class function Random(MaxValue:Int64 = MaxInt): OLInt64;  overload; static;
    /// <summary>
    ///   Generates a random prime number up to MaxValue.
    /// </summary>
    class function RandomPrime(MaxValue:Int64 = MaxInt): OLInt64; overload; static;

    /// <summary>
    ///   Sets the Int64 to a random value between MinValue and MaxValue.
    /// </summary>
    procedure SetRandom(MinValue: Int64; MaxValue:Int64); overload;
    /// <summary>
    ///   Sets the Int64 to a random value up to MaxValue.
    /// </summary>
    procedure SetRandom(MaxValue:Int64 = MaxInt); overload;

    /// <summary>
    ///   Sets the Int64 to a random prime value between MinValue and MaxValue.
    /// </summary>
    procedure SetRandomPrime(MinValue: Int64; MaxValue:Int64); overload;
    /// <summary>
    ///   Sets the Int64 to a random prime value up to MaxValue.
    /// </summary>
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

    class operator Equal(a, b: OLInt64): Boolean; overload;
    class operator NotEqual(a, b: OLInt64): Boolean;  overload;
    class operator GreaterThan(a, b: OLInt64): Boolean;  overload;
    class operator GreaterThanOrEqual(a, b: OLInt64): Boolean;  overload;
    class operator LessThan(a, b: OLInt64): Boolean;  overload;
    class operator LessThanOrEqual(a, b: OLInt64): Boolean;  overload;

    class operator Equal(a: OLInt64; b: Extended): Boolean;  overload;
    class operator NotEqual(a: OLInt64; b: Extended): Boolean;  overload;
    class operator GreaterThan(a: OLInt64; b: Extended): Boolean;  overload;
    class operator GreaterThanOrEqual(a: OLInt64; b: Extended): Boolean;  overload;
    class operator LessThan(a: OLInt64; b: Extended): Boolean;  overload;
    class operator LessThanOrEqual(a: OLInt64; b: Extended): Boolean;  overload;

    /// <summary>
    ///   Gets or sets the binary string representation of the Int64.
    /// </summary>
    property Binary: string read GetBinary write SetBinary;
    /// <summary>
    ///   Gets or sets the octal string representation of the Int64.
    /// </summary>
    property Octal: string read GetOctal write SetOctal;
    /// <summary>
    ///   Gets or sets the hexadecimal string representation of the Int64.
    /// </summary>
    property Hexidecimal: string read GetHexidecimal write SetHexidecimal;
    /// <summary>
    ///   Gets or sets the base-32 string representation of the Int64.
    /// </summary>
    property NumeralSystem32: string read GetNumeralSystem32 write SetNumeralSystem32;
    /// <summary>
    ///   Gets or sets the base-64 string representation of the Int64.
    /// </summary>
    property NumeralSystem64: string read GetNumeralSystem64 write SetNumeralSystem64;

    {$IF CompilerVersion >= 34.0}
    class operator Initialize(out Dest: OLInt64);
    {$IFEND}
  end;

  POLInt64 = ^OLInt64;

implementation

uses
  Math, NumeralSystemConvert;

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

function OLInt64.ToNumeralSystem(const Base: Integer): string;
begin
  Result := ConvertNumeralSystem(Self, Base);
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

class operator OLInt64.Equal(a: OLInt64; b: Extended): Boolean;
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
  if not Self.ValuePresent then
    Result := Null
  else
    Result := (Self.Value mod i) = 0;
end;

class operator OLInt64.Equal(a, b: OLInt64): Boolean;
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

function OLInt64.GetBinary: string;
begin
  Result := ToNumeralSystem(2);
end;

function OLInt64.GetHasValue: OLBoolean;
begin
  {$IF CompilerVersion >= 34.0}
  Result := FHasValue;
  {$ELSE}
  Result := FHasValue = ' ';
  {$IFEND}
end;

function OLInt64.GetHexidecimal: string;
begin
  Result := ToNumeralSystem(16);
end;

function OLInt64.GetNumeralSystem32: string;
begin
Result := ToNumeralSystem(32);
end;

function OLInt64.GetNumeralSystem64: string;
begin
  Result := ToNumeralSystem(64);
end;

function OLInt64.GetOctal: string;
begin
  Result := ToNumeralSystem(8);
end;

class operator OLInt64.GreaterThan(a, b: OLInt64): Boolean;
begin
  Result := (a.Value > b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLInt64.GreaterThanOrEqual(a, b: OLInt64): Boolean;
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

class operator OLInt64.LessThan(a, b: OLInt64): Boolean;
begin
  Result := (a.Value < b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLInt64.LessThanOrEqual(a, b: OLInt64): Boolean;
begin
  Result := ((a.Value <= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLInt64.Max(i: OLInt64): OLInt64;
begin
  if (not ValuePresent) or (i = Null) then
    Result := Null
  else
    Result := Math.Max(Value, i);
end;

function OLInt64.Min(i: OLInt64): OLInt64;
begin
  if (not ValuePresent) or (i = Null) then
    Result := Null
  else
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

class operator OLInt64.NotEqual(a: OLInt64; b: Extended): Boolean;
begin
  Result := (a.Value <> b) and a.ValuePresent;
end;

function OLInt64.Power(Exponent: Int64): Double;
begin
  Result := Math.IntPower(Value, Exponent);
end;

function OLInt64.IsNegative: OLBoolean;
begin
  if not ValuePresent then
    Result := Null
  else
    Result := Value < 0;
end;

function OLInt64.IsNonNegative: OLBoolean;
begin
  if not ValuePresent then
    Result := Null
  else
    Result := Value >= 0;
end;

class operator OLInt64.NotEqual(a, b: OLInt64): Boolean;
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
  if not ValuePresent then
    Result := Null
  else
    Result := not IsEven();
end;

function OLInt64.IsPositive: OLBoolean;
begin
  if not ValuePresent then
    Result := Null
  else
    Result := Value > 0;
end;

function OLInt64.IsPrime: OLBoolean;
var
  i: Int64;
  Limit: Int64;
begin
  if not Self.ValuePresent then
    Exit(Null);

  if Value <= 1 then
    Exit(False);

  if Value <= 3 then
    Exit(True);

  if (Value mod 2 = 0) or (Value mod 3 = 0) then
    Exit(False);

  i := 5;
  Limit := Trunc(Sqrt(Value));

  while i <= Limit do
  begin
    if (Value mod i = 0) or (Value mod (i + 2) = 0) then
      Exit(False);
    Inc(i, 6);
  end;

  Result := True;
end;

procedure OLInt64.SetBinary(const Value: string);
begin
  Self := ConvertNumeralSystem(Value, 2);
end;

procedure OLInt64.SetHasValue(Value: OLBoolean);
begin
  {$IF CompilerVersion >= 34.0}
  FHasValue := Value;
  {$ELSE}
  FHasValue := Value.IfThen(' ', '');
  {$IFEND}
end;

{$IF CompilerVersion >= 34.0}
class operator OLInt64.Initialize(out Dest: OLInt64);
begin
  Dest.FHasValue := False;
end;
{$IFEND}

procedure OLInt64.SetHexidecimal(const Value: string);
begin
  Self := ConvertNumeralSystem(Value, 16);
end;

procedure OLInt64.SetNumeralSystem32(const Value: string);
begin
  Self := ConvertNumeralSystem(Value, 32);
end;

procedure OLInt64.SetNumeralSystem64(const Value: string);
begin
  Self := ConvertNumeralSystem(Value, 64);
end;

procedure OLInt64.SetOctal(const Value: string);
begin
  Self := ConvertNumeralSystem(Value, 8);
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

function OLInt64.ToSQLString: string;
var
  OutPut: string;
begin
  if HasValue then
    OutPut := ToString()
  else
    OutPut := 'NULL';

  Result := OutPut;
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

  Result := OutPut;
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

class operator OLInt64.GreaterThan(a: OLInt64; b: Extended): Boolean;
begin
  Result := (a.Value > b) and a.ValuePresent;
end;

class operator OLInt64.GreaterThanOrEqual(a: OLInt64;
  b: Extended): Boolean;
begin
  Result := (a.Value >= b) and a.ValuePresent;
end;

function OLInt64.HasValue: OLBoolean;
begin
  Result := ValuePresent;
end;

class operator OLInt64.LessThan(a: OLInt64; b: Extended): Boolean;
begin
  Result := (a.Value < b) and a.ValuePresent;
end;

class operator OLInt64.LessThanOrEqual(a: OLInt64; b: Extended): Boolean;
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
