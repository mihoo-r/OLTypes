unit OLIntegerType;

interface

uses
  variants, SysUtils, OLBooleanType, OLDoubleType, {$IF CompilerVersion >= 23.0} System.Classes {$ELSE} Classes {$IFEND};

type
  /// <summary>
  ///   A record type representing an integer with null-handling capabilities.
  /// </summary>
  OLInteger = record
  private
    FValue: integer;
    {$IF CompilerVersion >= 34.0}
    FOnChange: TNotifyEvent;
    FHasValue: Boolean;
    {$ELSE}
    FHasValue: string;
    {$IFEND}

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
    /// <summary>
    ///   Gets or sets whether the integer has a value (is not null).
    /// </summary>
    property ValuePresent: OLBoolean read GetHasValue write SetHasValue;
  public
    /// <summary>
    ///   Checks if the integer is divisible by the specified value.
    /// </summary>
    function IsDividableBy(const i: integer): OLBoolean;
    /// <summary>
    ///   Checks if the integer is odd.
    /// </summary>
    function IsOdd(): OLBoolean;
    /// <summary>
    ///   Checks if the integer is even.
    /// </summary>
    function IsEven(): OLBoolean;
    /// <summary>
    ///   Returns the square of the integer.
    /// </summary>
    function Sqr(): OLInteger;
    /// <summary>
    ///   Returns the integer raised to the specified exponent.
    /// </summary>
    function Power(const Exponent: LongWord): OLInteger; overload;
    /// <summary>
    ///   Returns the integer raised to the specified exponent as a Double.
    /// </summary>
    function Power(const Exponent: integer): Double; overload;
    /// <summary>
    ///   Checks if the integer is positive (> 0).
    /// </summary>
    function IsPositive(): OLBoolean;
    /// <summary>
    ///   Checks if the integer is negative (< 0).
    /// </summary>
    function IsNegative(): OLBoolean;
    /// <summary>
    ///   Checks if the integer is non-negative (>= 0).
    /// </summary>
    function IsNonNegative(): OLBoolean;
    /// <summary>
    ///   Returns the larger of the two integers.
    /// </summary>
    function Max(const i: OLInteger): OLInteger;
    /// <summary>
    ///   Returns the smaller of the two integers.
    /// </summary>
    function Min(const i: OLInteger): OLInteger;
    /// <summary>
    ///   Returns the absolute value of the integer.
    /// </summary>
    function Abs(): OLInteger;
    /// <summary>
    ///   Checks if the integer is null (has no value).
    /// </summary>
    function IsNull(): OLBoolean;
    /// <summary>
    ///   Checks if the integer has a value (is not null).
    /// </summary>
    function HasValue(): OLBoolean;
    /// <summary>
    ///   Converts the integer to a string.
    /// </summary>
    function ToString(): string;
    /// <summary>
    ///   Converts the integer to a SQL-safe string (value or NULL).
    /// </summary>
    function ToSQLString(): string;
    /// <summary>
    ///   Returns the current integer if it has a value, otherwise returns the provided default value.
    /// </summary>
    function IfNull(const i: OLInteger): OLInteger;
    /// <summary>
    ///   Returns the integer value, or a replacement value if null.
    /// </summary>
    function AsInteger(const NullReplacement: Integer = 0): Integer;
    /// <summary>
    ///   Rounds the integer to the specified number of digits.
    ///   A parameter value of one rounds to the nearest ten.
    ///   A parameter value of two rounds to the nearest hundred, and so on
    /// </summary>
    function Round(const Digits: OLInteger): OLInteger;
    /// <summary>
    ///   Checks if the integer is between the specified values (inclusive).
    /// </summary>
    function Between(const BottomIncluded, TopIncluded: OLInteger): OLBoolean;
    /// <summary>
    ///   Returns the integer increased by the specified amount.
    /// </summary>
    function Increased(const IncreasedBy: integer = 1): OLInteger;
    /// <summary>
    ///   Returns the integer decreased by the specified amount.
    /// </summary>
    function Decreased(const DecreasedBy: integer = 1): OLInteger;
    /// <summary>
    ///   Returns the integer with the value replaced if it matches FromValue.
    /// </summary>
    function Replaced(const FromValue: OLInteger; const ToValue: OLInteger): OLInteger;

    /// <summary>
    ///   Converts the integer to a string representation in the specified base.
    /// </summary>
    function ToNumeralSystem(const Base: Integer): string;

    /// <summary>
    ///   Executes a procedure for each value from InitialValue to ToValue.
    /// </summary>
    procedure ForLoop(const InitialValue: integer; const ToValue: integer; const Proc: TProc);
    /// <summary>
    ///   Checks if the integer is a prime number.
    /// </summary>
    function IsPrime(): OLBoolean;
    /// <summary>
    ///   Generates a random integer between MinValue and MaxValue.
    /// </summary>
    class function Random(const MinValue: Integer; const MaxValue:Integer): OLInteger;  overload; static;
    /// <summary>
    ///   Generates a random prime number between MinValue and MaxValue.
    /// </summary>
    class function RandomPrime(const MinValue: Integer; const MaxValue:Integer): OLInteger; overload; static;

    /// <summary>
    ///   Generates a random integer up to MaxValue.
    /// </summary>
    class function Random(const MaxValue:Integer = MaxInt): OLInteger;  overload; static;
    /// <summary>
    ///   Generates a random prime number up to MaxValue.
    /// </summary>
    class function RandomPrime(const MaxValue:Integer = MaxInt): OLInteger; overload; static;

    /// <summary>
    ///   Sets the integer to a random value between MinValue and MaxValue.
    /// </summary>
    procedure SetRandom(const MinValue: Integer; const MaxValue:Integer); overload;
    /// <summary>
    ///   Sets the integer to a random value up to MaxValue.
    /// </summary>
    procedure SetRandom(const MaxValue:Integer = MaxInt); overload;

    /// <summary>
    ///   Sets the integer to a random prime value between MinValue and MaxValue.
    /// </summary>
    procedure SetRandomPrime(const MinValue: Integer; const MaxValue:Integer); overload;
    /// <summary>
    ///   Sets the integer to a random prime value up to MaxValue.
    /// </summary>
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


    class operator Inc(a: OLInteger): OLInteger;
    class operator Dec(a: OLInteger): OLInteger;
    class operator Negative(const a: OLInteger): OLInteger;

    class operator Equal(const a, b: OLInteger): Boolean; overload;
    class operator NotEqual(const a, b: OLInteger): Boolean;  overload;
    class operator GreaterThan(const a, b: OLInteger): Boolean;  overload;
    class operator GreaterThanOrEqual(const a, b: OLInteger): Boolean;  overload;
    class operator LessThan(const a, b: OLInteger): Boolean;  overload;
    class operator LessThanOrEqual(const a, b: OLInteger): Boolean;  overload;

    class operator Equal(const a: OLInteger; const b: Extended): Boolean;  overload;
    class operator NotEqual(const a: OLInteger; const b: Extended): Boolean;  overload;
    class operator GreaterThan(const a: OLInteger; const b: Extended): Boolean;  overload;
    class operator GreaterThanOrEqual(const a: OLInteger; const b: Extended): Boolean;  overload;
    class operator LessThan(const a: OLInteger; const b: Extended): Boolean;  overload;
    class operator LessThanOrEqual(const a: OLInteger; const b: Extended): Boolean;  overload;

    {$IF CompilerVersion >= 34.0}
    class operator Initialize(out Dest: OLInteger);
    class operator Assign(var Dest: OLInteger; const [ref] Src: OLInteger);
    /// <summary>
    ///   Event handler for value changes.
    /// </summary>
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {$IFEND}

    /// <summary>
    ///   Gets or sets the binary string representation of the integer.
    /// </summary>
    property Binary: string read GetBinary write SetBinary;
    /// <summary>
    ///   Gets or sets the octal string representation of the integer.
    /// </summary>
    property Octal: string read GetOctal write SetOctal;
    /// <summary>
    ///   Gets or sets the hexadecimal string representation of the integer.
    /// </summary>
    property Hexidecimal: string read GetHexidecimal write SetHexidecimal;
    /// <summary>
    ///   Gets or sets the base-32 string representation of the integer.
    /// </summary>
    property NumeralSystem32: string read GetNumeralSystem32 write SetNumeralSystem32;
    /// <summary>
    ///   Gets or sets the base-64 string representation of the integer.
    /// </summary>
    property NumeralSystem64: string read GetNumeralSystem64 write SetNumeralSystem64;
  end;

  POLInteger = ^OLInteger;

implementation

uses
  Math, NumeralSystemConvert;

const
  NonEmptyStr = ' ';

function OLInteger.Abs(): OLInteger;
begin

  if Self.ValuePresent then
    Result := System.Abs(Self.FValue)
  else
    Result := Null;
end;

class operator OLInteger.Add(const a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin
  if not (a.ValuePresent and b.ValuePresent) then
    Exit(Null);
  returnrec.FValue := a.FValue + b.FValue;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLInteger.AsInteger(const NullReplacement: Integer): Integer;
begin

  Result := IfNull(NullReplacement);
end;

function OLInteger.Between(const BottomIncluded, TopIncluded: OLInteger):
    OLBoolean;
var
  OutPut: OLBoolean;
begin
  if HasValue() then
    OutPut := ((FValue <= TopIncluded) and (FValue >= BottomIncluded))
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLInteger.BitwiseXor(const a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin

  returnrec.FValue := a.FValue xor b.FValue;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLInteger.ToNumeralSystem(const Base: Integer): string;
begin

  Result := ConvertNumeralSystem(Self, Base);
end;

class operator OLInteger.Implicit(const a: integer): OLInteger;
var
  OutPut: OLInteger;
begin
  OutPut.FValue := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLInteger.Implicit(const a: OLInteger): integer;
var
  OutPut: integer;
begin

  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as integer value');
  OutPut := a.FValue;
  Result := OutPut;
end;

class operator OLInteger.Dec(a: OLInteger): OLInteger;
begin

  System.Dec(&a.FValue);
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
    OutPut := a / b.FValue;

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
    OutPut := a.FValue / b;

  Result := OutPut;
end;

class operator OLInteger.Equal(const a: OLInteger; const b: Extended):
    Boolean;
begin

  Result := (a.FValue = b) and a.ValuePresent;
end;

class operator OLInteger.Divide(const a, b: OLInteger): OLDouble;
var
  OutPut: OLDouble;
begin

  if (not a.ValuePresent) or (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a.FValue / b.FValue;

  Result := OutPut;
end;

function OLInteger.IsDividableBy(const i: integer): OLBoolean;
begin
  if not Self.ValuePresent then
    Result := Null
  else
    Result := (Self.FValue mod i) = 0;
end;

class operator OLInteger.Equal(const a, b: OLInteger): Boolean;
begin

  Result := ((a.FValue = b.FValue) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
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

function OLInteger.GetBinary: string;
begin

  Result := ToNumeralSystem(2);
end;

function OLInteger.GetHasValue: OLBoolean;
begin
  {$IF CompilerVersion >= 34.0}
  Result := FHasValue;
  {$ELSE}
  Result := FHasValue = ' ';
  {$IFEND}
end;

function OLInteger.GetHexidecimal: string;
begin

  Result := ToNumeralSystem(16);
end;

function OLInteger.GetNumeralSystem32: string;
begin

  Result := ToNumeralSystem(32);
end;

function OLInteger.GetNumeralSystem64: string;
begin

  Result := ToNumeralSystem(64);
end;

function OLInteger.GetOctal: string;
begin

  Result := ToNumeralSystem(8);
end;

class operator OLInteger.GreaterThan(const a, b: OLInteger): Boolean;
begin

  Result := (a.FValue > b.FValue) and a.ValuePresent and b.ValuePresent;
end;

class operator OLInteger.GreaterThanOrEqual(const a, b: OLInteger): Boolean;
begin

  Result := ((a.FValue >= b.FValue) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
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
  OutPut := a.FValue;
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
      OutPut.FValue := i;
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

  System.Inc(&a.FValue);
  Result := a;
end;

function OLInteger.Increased(const IncreasedBy: integer = 1): OLInteger;
begin

  Result := Self + IncreasedBy;
end;

{$IF CompilerVersion >= 34.0}
class operator OLInteger.Initialize(out Dest: OLInteger);
begin
  Dest.ValuePresent := False;
  Dest.FOnChange := nil;
end;

class operator OLInteger.Assign(var Dest: OLInteger; const [ref] Src: OLInteger);
begin
  Dest.FValue := Src.FValue;
  Dest.ValuePresent := Src.ValuePresent;
  if Assigned(Dest.FOnChange) then
    Dest.FOnChange(nil);
end;
{$IFEND}

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
    returnrec.FValue := a.FValue div b.FValue;

  Result := returnrec;
end;

function OLInteger.IsNull: OLBoolean;
begin

  Result := not ValuePresent;
end;

class operator OLInteger.LessThan(const a, b: OLInteger): Boolean;
begin

  Result := (a.FValue < b.FValue) and a.ValuePresent and b.ValuePresent;
end;

class operator OLInteger.LessThanOrEqual(const a, b: OLInteger): Boolean;
begin

  Result := ((a.FValue <= b.FValue) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLInteger.Max(const i: OLInteger): OLInteger;
begin
  
  if (not ValuePresent) or (i = Null) then
    Result := Null
  else
    Result := Math.Max(FValue, i);
end;

function OLInteger.Min(const i: OLInteger): OLInteger;
begin

  if (not ValuePresent) or (i = Null) then
    Result := Null
  else
    Result := Math.Min(FValue, i);
end;

class operator OLInteger.Modulus(const a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin

  returnrec.FValue := a.FValue mod b.FValue;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLInteger.Multiply(const a: Extended;
  const b: OLInteger): OLDouble;
var
  OutPut: OLDouble;
begin

  if b.IsNull then
    OutPut := Null
  else
    OutPut := a * b.FValue;

  Result := OutPut;
end;

class operator OLInteger.Multiply(const a: OLInteger;
  const b: Extended): OLDouble;
var
  OutPut: OLDouble;
begin

  if not a.ValuePresent then
    OutPut := Null
  else
    OutPut := a.FValue * b;

  Result := OutPut;
end;

class operator OLInteger.Multiply(const a: OLDouble;
  const b: OLInteger): OLDouble;
var
  OutPut: OLDouble;
begin

  if (a.IsNull()) or (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a * b.FValue;

  Result := OutPut;
end;

class operator OLInteger.Multiply(const a: OLInteger;
  const b: OLDouble): OLDouble;
var
  OutPut: OLDouble;
begin

  if (not a.ValuePresent) or (b.IsNull) then
    OutPut := Null
  else
    OutPut := a.FValue * b;

  Result := OutPut;
end;

class operator OLInteger.Multiply(const a: OLInteger;
  const b: Integer): OLInteger;
var
  returnrec: OLInteger;
begin

  returnrec.FValue := a.FValue * b;
  returnrec.ValuePresent := a.ValuePresent;
  Result := returnrec;
end;

class operator OLInteger.Multiply(const a: Integer;
  const b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin

  returnrec.FValue := a * b.FValue;
  returnrec.ValuePresent := b.ValuePresent;
  Result := returnrec;
end;

class operator OLInteger.Multiply(const a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin

  returnrec.FValue := a.FValue * b.FValue;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLInteger.Negative(const a: OLInteger): OLInteger;
var
  b: OLInteger;
begin

  b.FValue := -a.FValue;
  b.ValuePresent := a.ValuePresent;
  Result := b;
end;

class operator OLInteger.NotEqual(const a: OLInteger; const b: Extended):
    Boolean;
begin

  Result := (a.FValue <> b) and a.ValuePresent;
end;

function OLInteger.Power(const Exponent: integer): Double;
begin

  Result := Math.IntPower(FValue, Exponent);
end;

function OLInteger.IsNegative: OLBoolean;
begin

  if not ValuePresent then
    Result := Null
  else
    Result := FValue < 0;
end;

function OLInteger.IsNonNegative: OLBoolean;
begin

  if not ValuePresent then
    Result := Null
  else
    Result := FValue >= 0;
end;

class operator OLInteger.NotEqual(const a, b: OLInteger): Boolean;
begin

  Result := ((a.FValue <> b.FValue) and a.ValuePresent and b.ValuePresent) or (a.ValuePresent <> b.ValuePresent);
end;

function OLInteger.Power(const Exponent: LongWord): OLInteger;
var
  returnrec: OLInteger;
begin

  returnrec.FValue := Math.Floor(Math.IntPower(FValue, Exponent));
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

  if not ValuePresent then
    Result := Null
  else
    Result := not IsEven();
end;

function OLInteger.IsPositive: OLBoolean;
begin

  if not ValuePresent then
    Result := Null
  else
    Result := FValue > 0;
end;

function OLInteger.IsPrime: OLBoolean;
var
  i: Integer;
  Limit: Integer;
begin
  if not Self.ValuePresent then
    Exit(Null);

  if FValue <= 1 then
    Exit(False);

  if FValue <= 3 then
    Exit(True);

  if (FValue mod 2 = 0) or (FValue mod 3 = 0) then
    Exit(False);

  i := 5;
  Limit := Trunc(Sqrt(FValue));

  while i <= Limit do
  begin
    if (FValue mod i = 0) or (FValue mod (i + 2) = 0) then
      Exit(False);
    Inc(i, 6);
  end;

  Result := True;
end;

procedure OLInteger.SetBinary(const Value: string);
begin

  Self := ConvertNumeralSystem(Value, 2);
end;

procedure OLInteger.SetHasValue(const Value: OLBoolean);
begin
  {$IF CompilerVersion >= 34.0}
  FHasValue := Value;
  {$ELSE}
  FHasValue := Value.IfThen(' ', '');
  {$IFEND}
end;

procedure OLInteger.SetHexidecimal(const Value: string);
begin

  Self := ConvertNumeralSystem(Value, 16);
end;

procedure OLInteger.SetNumeralSystem32(const Value: string);
begin

  Self := ConvertNumeralSystem(Value, 32);
end;

procedure OLInteger.SetNumeralSystem64(const Value: string);
begin

  Self := ConvertNumeralSystem(Value, 64);
end;

procedure OLInteger.SetOctal(const Value: string);
begin

  Self := ConvertNumeralSystem(Value, 8);
end;

procedure OLInteger.SetRandom(const MaxValue:Integer = MaxInt);
begin

  Self.FValue := OLInteger.Random(MaxValue);
  Self.ValuePresent := True;
end;

procedure OLInteger.SetRandom(const MinValue: Integer; const MaxValue:Integer);
begin

  Self.FValue := OLInteger.Random(MinValue, MaxValue);
  Self.ValuePresent := True;
end;

procedure OLInteger.SetRandomPrime(const MaxValue:Integer = MaxInt);
begin

  Self.FValue := OLInteger.RandomPrime(MaxValue);
  Self.ValuePresent := True;
end;

procedure OLInteger.SetRandomPrime(const MinValue: Integer; const
    MaxValue:Integer);
begin

  Self.FValue := OLInteger.RandomPrime(MinValue, MaxValue);
  Self.ValuePresent := True;
end;

function OLInteger.Sqr: OLInteger;
var
  returnrec: OLInteger;
begin

  returnrec.FValue := FValue * FValue;
  returnrec.ValuePresent := ValuePresent;
  Result := returnrec;
end;

class operator OLInteger.Subtract(const a, b: OLInteger): OLInteger;
var
  returnrec: OLInteger;
begin

  returnrec.FValue := a.FValue - b.FValue;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLInteger.ToSQLString: string;
var
  OutPut: string;
begin

  if HasValue then
    OutPut := ToString()
  else
    OutPut := 'NULL';

  Result := OutPut;
end;

function OLInteger.ToString: string;
var
  Output: string;
begin

  if ValuePresent then
    Output := IntToStr(FValue)
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
    OutPut := a.FValue
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLInteger.GreaterThan(const a: OLInteger; const b: Extended): Boolean;
begin

  Result := (a.FValue > b) and a.ValuePresent;
end;

class operator OLInteger.GreaterThanOrEqual(const a: OLInteger; const b:
    Extended): Boolean;
begin

  Result := (a.FValue >= b) and a.ValuePresent;
end;

function OLInteger.HasValue: OLBoolean;
begin

  Result := ValuePresent;
end;

class operator OLInteger.LessThan(const a: OLInteger; const b: Extended):
    Boolean;
begin

  Result := (a.FValue < b) and a.ValuePresent;
end;

class operator OLInteger.LessThanOrEqual(const a: OLInteger; const b:
    Extended): Boolean;
begin

  Result := (a.FValue <= b) and a.ValuePresent;
end;

class operator OLInteger.Implicit(const a: OLInteger): OLDouble;
var
  OutPut: OLDouble;
begin

  if a.ValuePresent then
    OutPut := a.FValue
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
    OutPut := a / b.FValue;

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
    OutPut := a.FValue / b;

  Result := OutPut;
end;

initialization


end.
