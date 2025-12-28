unit OLDoubleType;

interface

uses
  variants, SysUtils, Math, Types, OLBooleanType, {$IF CompilerVersion >= 23.0} System.Classes {$ELSE} Classes {$IFEND};

type
  /// <summary>
  ///   A record type representing a double-precision floating point number with null-handling capabilities.
  /// </summary>
  OLDouble = record
  private
    FValue: Double;
    {$IF CompilerVersion >= 34.0}
    FHasValue: Boolean;
    FOnChange: TNotifyEvent;
    {$ELSE}
    FHasValue: string;
    {$IFEND}

    function GetHasValue(): OLBoolean;
    procedure SetHasValue(const Value: OLBoolean);
    /// <summary>
    ///   Gets or sets whether the double has a value (is not null).
    /// </summary>
    property ValuePresent: OLBoolean read GetHasValue write SetHasValue;
  public
    /// <summary>
    ///   Returns the square of the double.
    /// </summary>
    function Sqr(): OLDouble;
    /// <summary>
    ///   Returns the square root of the double.
    /// </summary>
    function Sqrt(): OLDouble;
    /// <summary>
    ///   Returns the double raised to the specified integer exponent.
    /// </summary>
    function Power(const Exponent: integer): OLDouble;  overload;
    /// <summary>
    ///   Checks if the double is positive (> 0).
    /// </summary>
    function IsPositive(): OLBoolean;
    /// <summary>
    ///   Checks if the double is negative (< 0).
    /// </summary>
    function IsNegative(): OLBoolean;
    /// <summary>
    ///   Checks if the double is non-negative (>= 0).
    /// </summary>
    function IsNonNegative(): OLBoolean;
    /// <summary>
    ///   Returns the larger of the two doubles.
    /// </summary>
    function Max(const d: OLDouble): OLDouble;
    /// <summary>
    ///   Returns the smaller of the two doubles.
    /// </summary>
    function Min(const d: OLDouble): OLDouble;
    /// <summary>
    ///   Returns the absolute value of the double.
    /// </summary>
    function Abs(): OLDouble;
    /// <summary>
    ///   Checks if the double is null (has no value).
    /// </summary>
    function IsNull(): OLBoolean;
    /// <summary>
    ///   Checks if the double has a value (is not null).
    /// </summary>
    function HasValue(): OLBoolean;
    /// <summary>
    ///   Converts the double to a string with specified formatting.
    /// </summary>
    function ToStrF(Format: TFloatFormat; Precision, Digits: Integer): string;
    /// <summary>
    ///   Converts the double to a string.
    /// </summary>
    function ToString(): string; overload;
    /// <summary>
    ///   Converts the double to a string with specified formatting.
    /// </summary>
    function ToString(const Digits: integer; const Format: TFloatFormat = ffFixed; const Precision: integer = 16): string; overload;
    /// <summary>
    ///   Converts the double to a string with custom separators and format.
    /// </summary>
    function ToString(ThousandSeparator: Char; DecimalSeparator: Char = '.'; Format: string = '###,###,###,##0.##'): string; overload;
    /// <summary>
    ///   Converts the double to a SQL-safe string (value or NULL).
    /// </summary>
    function ToSQLString(): string;
    /// <summary>
    ///   Returns the current double if it has a value, otherwise returns the provided default value.
    /// </summary>
    function IfNull(const d: OLDouble): OLDouble;

    /// <summary>
    ///   Rounds the double to the specified power of ten.
    /// </summary>
    /// <param name="PowerOfTen">The power of ten to which the value is rounded. For negative values, rounding is performed on the fractional part (to the right of the decimal point).</param>
    function Round(const PowerOfTen: integer): OLDouble; overload;
    /// <summary>
    ///   Rounds the double to the nearest integer.
    /// </summary>
    function Round(): Integer; overload;
    /// <summary>
    ///   Returns the largest integer less than or equal to the double.
    /// </summary>
    function Floor(): Integer;
    /// <summary>
    ///   Returns the smallest integer greater than or equal to the double.
    /// </summary>
    function Ceil(): Integer;
    /// <summary>
    ///   Rounds the double using symmetric arithmetic rounding to the specified power of ten.
    ///   Unlike Round, SimpleRoundTo always rounds 0.5 away from zero.
    /// </summary>
    /// <param name="PowerOfTen">The power of ten to which the value is rounded. For negative values, rounding is performed on the fractional part (to the right of the decimal point).</param>
    function SimpleRoundTo(const PowerOfTen: Integer = -2): OLDouble;

    /// <summary>
    ///   Returns the double raised to the specified extended exponent.
    /// </summary>
    function Power(const Exponent: Extended): OLDouble;  overload;

    /// <summary>
    ///   Checks if the double is NaN (Not a Number).
    /// </summary>
    function IsNan(): OLBoolean;
    /// <summary>
    ///   Checks if the double is infinite.
    /// </summary>
    function IsInfinite(): OLBoolean;
    /// <summary>
    ///   Checks if the double is zero within the specified epsilon.
    /// </summary>
    function IsZero(const Epsilon: Extended = 0): OLBoolean;

    /// <summary>
    ///   Checks if the double is within the specified range.
    /// </summary>
    function InRange(const AMin, AMax: Extended): OLBoolean;
    /// <summary>
    ///   Ensures the double is within the specified range.
    /// </summary>
    function EnsureRange(const AMin, AMax: Extended): Extended;

    /// <summary>
    ///   Checks if the double is equal to B within the specified epsilon.
    /// </summary>
    function SameValue(const B: Extended; const Epsilon: Extended = 0): OLBoolean;

    /// <summary>
    ///   Generates a random double between MinValue and MaxValue.
    /// </summary>
    class function Random(const MinValue: Double; const MaxValue:Double): OLDouble;  overload; static;
    /// <summary>
    ///   Generates a random double up to MaxValue.
    /// </summary>
    class function Random(const MaxValue:Double = MaxInt): OLDouble;  overload; static;

    class operator Add(const a, b: OLDouble): OLDouble;
    class operator Subtract(const a, b: OLDouble): OLDouble;
    class operator Multiply(const a, b: OLDouble): OLDouble;
    class operator Divide(const a, b: OLDouble): OLDouble;

    class operator Implicit(const a: Double): OLDouble;
    class operator Implicit(const a: OLDouble): Double;
    class operator Implicit(const a: Variant): OLDouble;
    class operator Implicit(const a: OLDouble): Variant;
    class operator Implicit(const a: Integer): OLDouble;

    class operator Implicit(const a: Extended): OLDouble;
    class operator Implicit(const a: OLDouble): Extended;

    class operator Inc(const a: OLDouble): OLDouble;
    class operator Dec(const a: OLDouble): OLDouble;
    class operator Negative(const a: OLDouble): OLDouble;

    class operator Equal(const a, b: OLDouble): Boolean;
    class operator NotEqual(const a, b: OLDouble): Boolean;
    class operator GreaterThan(const a, b: OLDouble): Boolean;
    class operator GreaterThanOrEqual(const a, b: OLDouble): Boolean;
    class operator LessThan(const a, b: OLDouble): Boolean;
    class operator LessThanOrEqual(const a, b: OLDouble): Boolean;

    {$IF CompilerVersion >= 34.0}
    class operator Initialize(out Dest: OLDouble);
    class operator Assign(var Dest: OLDouble; const [ref] Src: OLDouble);
    /// <summary>
    ///   Event handler for value changes.
    /// </summary>
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {$IFEND}
  end;

  POLDouble = ^OLDouble;

implementation

//uses
//  ;

const
  NonEmptyStr = ' ';
  // Tolerance for floating point comparisons.
  // 1E-9 handles standard arithmetic noise while keeping business precision safe.
  // This resolves issues where -1.85 * -3 results in 5.550000000000001
  OLEpsilon = 1E-9;

function OLDouble.Abs(): OLDouble;
begin
  if Self.ValuePresent then
    Result := System.Abs(Self.FValue)
  else
    Result := Null;
end;

class operator OLDouble.Add(const a, b: OLDouble): OLDouble;
var
  returnrec: OLDouble;
begin
  returnrec.FValue := a.FValue + b.FValue;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLDouble.Ceil: Integer;
var
  d: Double;
begin
  d := Self;
  Result := Math.Ceil(d);
end;

class operator OLDouble.Implicit(const a: Double): OLDouble;
var
  OutPut: OLDouble;
begin
  OutPut.FValue := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLDouble.Implicit(const a: OLDouble): Double;
var
  OutPut: Double;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as double value');
  OutPut := a.FValue;
  Result := OutPut;
end;

class operator OLDouble.Dec(const a: OLDouble): OLDouble;
begin
  Result := a - 1;
end;

class operator OLDouble.Divide(const a, b: OLDouble): OLDouble;
var
  returnrec: OLDouble;
begin
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;

  if returnrec.ValuePresent then
    returnrec.FValue := a.FValue / b.FValue;

  Result := returnrec;
end;

function OLDouble.EnsureRange(const AMin, AMax: Extended): Extended;
begin
  Result := Math.EnsureRange(Self, AMin, AMax);
end;

class operator OLDouble.Equal(const a, b: OLDouble): Boolean;
begin
  // Handle Null logic:
  // 1. If both are NULL -> they are effectively Equal in this context
  if a.IsNull and b.IsNull then
    begin
      Result := True;
      Exit;
    end;

  // 2. If one is NULL and the other is not -> Not Equal
  if a.IsNull or b.IsNull then
    begin
      Result := False;
      Exit;
    end;

  // 3. Value comparison using fixed pragmatic epsilon (OLEpsilon).
  // This handles floating point noise (e.g. 5.550000000000001 vs 5.55)
  // while maintaining consistency across all comparison operators.
  Result := Math.SameValue(a.FValue, b.FValue, OLEpsilon);
end;

function OLDouble.Floor: Integer;
var
  d: Double;
begin
  d := Self;
  Result := Math.Floor(d);
end;

function OLDouble.GetHasValue: OLBoolean;
begin
  {$IF CompilerVersion >= 34.0}
  Result := FHasValue;
  {$ELSE}
  Result := FHasValue = ' ';
  {$IFEND}
end;

class operator OLDouble.GreaterThan(const a, b: OLDouble): Boolean;
begin
  // Strict comparison: Any NULL results in False
  if not (a.ValuePresent and b.ValuePresent) then
    begin
      Result := False;
      Exit;
    end;

  // Use CompareValue with OLEpsilon.
  // Returns True only if a is strictly greater than b (beyond epsilon noise).
  Result := Math.CompareValue(a.FValue, b.FValue, OLEpsilon) = GreaterThanValue;
end;

class operator OLDouble.GreaterThanOrEqual(const a, b: OLDouble): Boolean;
begin
  // Handle Null logic: Null >= Null is True
  if a.IsNull and b.IsNull then
    begin
      Result := True;
      Exit;
    end;

  if not (a.ValuePresent and b.ValuePresent) then
    begin
      Result := False;
      Exit;
    end;

  // Equivalent to: NOT LessThan.
  // Covers both Equals (within epsilon) and GreaterThan.
  Result := Math.CompareValue(a.FValue, b.FValue, OLEpsilon) <> LessThanValue;
end;

function OLDouble.HasValue: OLBoolean;
begin
  Result := ValuePresent;
end;

function OLDouble.IfNull(const d: OLDouble): OLDouble;
var
  Output: OLDouble;
begin
  if ValuePresent then
    Output := Self
  else
    Output := d;

  Result := Output;
end;

class operator OLDouble.Implicit(const a: Variant): OLDouble;
var
  OutPut: OLDouble;
  f: Double;
begin
  if VarIsNull(a) then
    OutPut.ValuePresent := false
  else
  begin
    if TryStrToFloat(a, f) then
    begin
      OutPut.FValue := f;
      OutPut.ValuePresent := true;
    end
    else
    begin
      raise Exception.Create('Value ''' + VarToStr(a) + ''' cannot be assigned to variable of OLDouble type.');
    end;
  end;

  Result := OutPut;
end;

class operator OLDouble.Inc(const a: OLDouble): OLDouble;
begin
  Result := a + 1;
end;

function OLDouble.InRange(const AMin, AMax: Extended): OLBoolean;
begin
  Result := Math.InRange(Self, AMin, AMax);
end;

function OLDouble.IsNull: OLBoolean;
begin
  Result := not ValuePresent;
end;

class operator OLDouble.LessThan(const a, b: OLDouble): Boolean;
begin
  // Strict comparison: Any NULL results in False
  if not (a.ValuePresent and b.ValuePresent) then
    begin
      Result := False;
      Exit;
    end;

  // Use CompareValue with OLEpsilon.
  // Returns True only if a is strictly less than b (beyond epsilon noise).
  Result := Math.CompareValue(a.FValue, b.FValue, OLEpsilon) = LessThanValue;
end;

class operator OLDouble.LessThanOrEqual(const a, b: OLDouble): Boolean;
begin
  // Handle Null logic: Null <= Null is True
  if a.IsNull and b.IsNull then
    begin
      Result := True;
      Exit;
    end;

  if not (a.ValuePresent and b.ValuePresent) then
    begin
      Result := False;
      Exit;
    end;

  // Equivalent to: NOT GreaterThan.
  // Covers both Equals (within epsilon) and LessThan.
  Result := Math.CompareValue(a.FValue, b.FValue, OLEpsilon) <> GreaterThanValue;
end;

function OLDouble.Max(const d: OLDouble): OLDouble;
begin
  if (not ValuePresent) or (d.IsNull()) then
    Result := Null
  else
    Result := Math.Max(FValue, d);
end;

function OLDouble.Min(const d: OLDouble): OLDouble;
begin
  if (not ValuePresent) or (d.IsNull) then
    Result := Null
  else
    Result := Math.Min(FValue, d);
end;


class operator OLDouble.Multiply(const a, b: OLDouble): OLDouble;
var
  returnrec: OLDouble;
begin
  returnrec.FValue := a.FValue * b.FValue;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLDouble.Negative(const a: OLDouble): OLDouble;
var
  b: OLDouble;
begin
  b := -a.FValue;
  Result := b;
end;

function OLDouble.IsInfinite: OLBoolean;
var
  d: Double;
begin
  if not ValuePresent then
    Result := Null
  else
  begin
    d := Self;
    Result := Math.IsInfinite(d);
  end;
end;

function OLDouble.IsNan: OLBoolean;
var
  d: Double;
begin
  if not ValuePresent then
    Result := Null
  else
  begin
    d := Self;
    Result := Math.IsNan(d);
  end;
end;

function OLDouble.IsNegative: OLBoolean;
begin
  if not ValuePresent then
    Result := Null
  else
    Result := FValue < 0;
end;

function OLDouble.IsNonNegative: OLBoolean;
begin
  if not ValuePresent then
    Result := Null
  else
    Result := FValue >= 0;
end;

class operator OLDouble.NotEqual(const a, b: OLDouble): Boolean;
begin
  // Inverting the logic of Equal operator
  Result := not (a = b);
end;

function OLDouble.Power(const Exponent: Extended): OLDouble;
begin
  Result := Math.Power(Self, Exponent);
end;

function OLDouble.Power(const Exponent: integer): OLDouble;
var
  returnrec: OLDouble;
begin
  returnrec.FValue := Math.IntPower(FValue, Exponent);
  returnrec.ValuePresent := ValuePresent;
  Result := returnrec;
end;


class function OLDouble.Random(const MinValue: Double; const MaxValue:Double):
    OLDouble;
begin
  Result := MinValue + system.Random() * (MaxValue - MinValue);
end;

function OLDouble.IsPositive: OLBoolean;
begin
  if not ValuePresent then
    Result := Null
  else
    Result := FValue > 0;
end;

function OLDouble.IsZero(const Epsilon: Extended = 0): OLBoolean;
begin
  if not ValuePresent then
    Result := Null
  else
    Result := Math.IsZero(Self.FValue, Epsilon);
end;

function OLDouble.SameValue(const B: Extended; const Epsilon: Extended = 0):
    OLBoolean;
begin
  Result := Math.SameValue(Self.FValue, B, Epsilon);
end;

procedure OLDouble.SetHasValue(const Value: OLBoolean);
begin
  {$IF CompilerVersion >= 34.0}
  FHasValue := Value;
  {$ELSE}
  FHasValue := Value.IfThen(' ', '');
  {$IFEND}
end;

{$IF CompilerVersion >= 34.0}
class operator OLDouble.Initialize(out Dest: OLDouble);
begin
  Dest.FHasValue := False;
  Dest.FOnChange := nil;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
class operator OLDouble.Assign(var Dest: OLDouble; const [ref] Src: OLDouble);
begin
  Dest.FValue := Src.FValue;
  Dest.FHasValue := Src.FHasValue;

  if Assigned(Dest.FOnChange) then
    Dest.FOnChange(nil);
end;
{$IFEND}

function OLDouble.Round(const PowerOfTen: integer): OLDouble;
var
  OutPut: OLDouble;
begin
  if HasValue then
    OutPut := Math.RoundTo(Self, PowerOfTen)
  else
    OutPut := null;

  Result := OutPut;
end;

function OLDouble.SimpleRoundTo(const PowerOfTen: Integer = -2): OLDouble;
var
  OutPut: OLDouble;
begin
  if HasValue then
    OutPut := Math.SimpleRoundTo(Self, PowerOfTen)
  else
    OutPut := null;

  Result := OutPut;
end;

function OLDouble.Sqr: OLDouble;
var
  returnrec: OLDouble;
begin
  returnrec.FValue := FValue * FValue;
  returnrec.ValuePresent := ValuePresent;
  Result := returnrec;
end;

function OLDouble.Sqrt: OLDouble;
begin
  if not ValuePresent then
    Result := Null
  else
    Result := System.Sqrt(Self);
end;

class operator OLDouble.Subtract(const a, b: OLDouble): OLDouble;
var
  returnrec: OLDouble;
begin
  returnrec.FValue := a.FValue - b.FValue;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLDouble.ToSQLString: string;
var
  fs: TFormatSettings;
  OutPut: string;
begin
  fs.ThousandSeparator := #0;
  fs.DecimalSeparator := '.';

  if HasValue then
    OutPut := FloatToStrF(Self, ffNumber, 16, 16, fs)
  else
    OutPut := 'NULL';

  Result := OutPut;
end;

function OLDouble.ToString(const Digits: integer; const Format: TFloatFormat =
    ffFixed; const Precision: integer = 16): string;
begin
  if not ValuePresent then
    Result := ''
  else
  begin
    if Digits < 0 then
      raise EArgumentOutOfRangeException.Create('Digits must be >= 0');
    if Precision < 0 then
      raise EArgumentOutOfRangeException.Create('Precision must be >= 0');
    Result := FloatToStrF(FValue, Format, Precision, Digits);
  end;
end;

function OLDouble.ToString(ThousandSeparator, DecimalSeparator: Char; Format: string): string;
var
  fs: TFormatSettings;
  Output: string;
begin
  if not ValuePresent then
    Result := ''
  else
  begin
    if ThousandSeparator = DecimalSeparator then
      raise EArgumentException.Create('ThousandSeparator and DecimalSeparator must differ');
    if Format = '' then
      raise EArgumentException.Create('Format string cannot be empty');
    fs.ThousandSeparator := ThousandSeparator;
    fs.DecimalSeparator := DecimalSeparator;
    try
      Result := FormatFloat(Format, FValue, fs);
    except
      on E: EConvertError do
        raise EArgumentException.CreateFmt('Invalid format string: %s', [Format]);
    end;
  end;
end;

function OLDouble.ToString: string;
var
  Output: string;
begin
  if ValuePresent then
    Output := FloatToStr(FValue)
  else
    Output := '';

  Result := Output;
end;

class function OLDouble.Random(const MaxValue:Double = MaxInt): OLDouble;
begin
  Result := OLDouble.Random(0, MaxValue);
end;

function OLDouble.Round: Integer;
var
  d: Double;
begin
  d := Self;
  Result := System.Round(d);
end;

function OLDouble.ToStrF(Format: TFloatFormat; Precision, Digits: Integer):
    string;
var
  Output: string;
begin
  if Digits < 0 then
    raise EArgumentOutOfRangeException.Create('Digits must be >= 0');
  if ValuePresent then
    Output := FloatToStrF(FValue, Format, Precision, Digits)
  else
    Output := EmptyStr;

  Result := Output;
end;

class operator OLDouble.Implicit(const a: Integer): OLDouble;
var
  OutPut: OLDouble;
begin
  OutPut.FValue := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLDouble.Implicit(const a: Extended): OLDouble;
var
  OutPut: OLDouble;
begin
  OutPut.FValue := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLDouble.Implicit(const a: OLDouble): Extended;
var
  OutPut: Double;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as extended value');
  OutPut := a.FValue;
  Result := OutPut;
end;

class operator OLDouble.Implicit(const a: OLDouble): Variant;
var
  OutPut: Variant;
begin
  if a.ValuePresent then
    OutPut := a.FValue
  else
    OutPut := Null;

  Result := OutPut;
end;

end.
