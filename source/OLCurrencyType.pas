unit OLCurrencyType;

interface

uses
  variants, SysUtils, OLIntegerType, OlBooleanType, OLDoubleType, {$IF CompilerVersion >= 23.0} System.Classes {$ELSE} Classes {$IFEND};

type
  /// <summary>
  ///   A record type representing a currency value with null-handling capabilities.
  /// </summary>
  OLCurrency = record
  private
    FValue: Currency;
    {$IF CompilerVersion >= 34.0}
    FHasValue: Boolean;
    FOnChange: TNotifyEvent;
    {$ELSE}
    FHasValue: string;
    {$IFEND}

    function GetHasValue(): OLBoolean;
    procedure SetHasValue(const Value: OLBoolean);
    /// <summary>
    ///   Gets or sets whether the currency has a value (is not null).
    /// </summary>
    property ValuePresent: OLBoolean read GetHasValue write SetHasValue;
  public
/// <summary>
    ///   Returns the square of the currency value.
    /// </summary>
    function Sqr(): OLCurrency;
    /// <summary>
    ///   Returns the currency raised to the specified integer exponent.
    /// </summary>
    function Power(const Exponent: integer): OLCurrency;
    /// <summary>
    ///   Checks if the currency is positive (> 0).
    /// </summary>
    function IsPositive(): OLBoolean;
    /// <summary>
    ///   Checks if the currency is negative (< 0).
    /// </summary>
    function IsNegative(): OLBoolean;
    /// <summary>
    ///   Checks if the currency is non-negative (>= 0).
    /// </summary>
    function IsNonNegative(): OLBoolean;
    /// <summary>
    ///   Checks if the currency is between the specified values (inclusive).
    /// </summary>
    function Between(const BottomIncluded, TopIncluded: OLCurrency): OLBoolean;
    /// <summary>
    ///   Returns the larger of the two currency values.
    /// </summary>
    function Max(const i: OLCurrency): OLCurrency;
    /// <summary>
    ///   Returns the smaller of the two currency values.
    /// </summary>
    function Min(const i: OLCurrency): OLCurrency;
    /// <summary>
    ///   Returns the absolute value of the currency.
    /// </summary>
    function Abs(): OLCurrency;
    /// <summary>
    ///   Checks if the currency is null (has no value).
    /// </summary>
    function IsNull(): OLBoolean;
    /// <summary>
    ///   Checks if the currency has a value (is not null).
    /// </summary>
    function HasValue(): OLBoolean;
    /// <summary>
    ///   Converts the currency to a string.
    /// </summary>
    function ToString(): string; overload;
    /// <summary>
    ///   Converts the currency to a string with custom separators and format.
    /// </summary>
    function ToString(ThousandSeparator: Char; DecimalSeparator: Char = '.'; Format: string = '###,###,###,##0.##'): string; overload;
    /// <summary>
    ///   Converts the currency to a SQL-safe string (value or NULL).
    /// </summary>
    function ToSQLString: string;
    /// <summary>
    ///   Converts the currency to a string with specified formatting.
    /// </summary>
    function ToStrF(Format: TFloatFormat; Digits: Integer): string;
    /// <summary>
    ///   Returns the current currency if it has a value, otherwise returns the provided default value.
    /// </summary>
    function IfNull(const i: OLCurrency): OLCurrency;
    /// <summary>
    ///   Returns the Double value, or a replacement value if null.
    /// </summary>
    function AsCurrency(NullReplacement: Currency = 0): Currency;
    /// <summary>
    ///   Rounds the currency to the nearest integer.
    /// </summary>
    function Round(): OLInteger; overload;
    /// <summary>
    ///   Rounds the currency to the specified power of ten.
    /// </summary>
    /// <param name="PowerOfTen">The power of ten to which the value is rounded. For negative values, rounding is performed on the fractional part (to the right of the decimal point).</param>
    function Round(const PowerOfTen: integer): OLCurrency; overload;
    /// <summary>
    ///   Returns the smallest integer greater than or equal to the currency.
    /// </summary>
    function Ceil(): OLInteger;
    /// <summary>
    ///   Returns the largest integer less than or equal to the currency.
    /// </summary>
    function Floor(): OLInteger;
    /// <summary>
    ///   Rounds the currency using symmetric arithmetic rounding to the specified power of ten.
    ///   Unlike Round, SimpleRoundTo always rounds 0.5 away from zero.
    /// </summary>
    /// <param name="PowerOfTen">The power of ten to which the value is rounded. For negative values, rounding is performed on the fractional part (to the right of the decimal point).</param>
    function SimpleRoundTo(const PowerOfTen: Integer = -2): OLCurrency;

    {$REGION 'Operator Overloads - OLCurrency vs OLCurrency'}
    class operator Add(const a, b: OLCurrency): OLCurrency;
    class operator Subtract(const a, b: OLCurrency): OLCurrency;
    class operator Multiply(const a, b: OLCurrency): OLCurrency;
    class operator Divide(const a, b: OLCurrency): OLDouble;
    class operator Negative(const a: OLCurrency): OLCurrency;
    class operator Equal(const a, b: OLCurrency): Boolean; overload;
    class operator NotEqual(const a, b: OLCurrency): Boolean; overload;
    class operator GreaterThan(const a, b: OLCurrency): Boolean; overload;
    class operator GreaterThanOrEqual(const a, b: OLCurrency): Boolean; overload;
    class operator LessThan(const a, b: OLCurrency): Boolean; overload;
    class operator LessThanOrEqual(const a, b: OLCurrency): Boolean; overload;
    {$ENDREGION}

    {$REGION 'Operator Overloads - Integer'}
    // Implicit/Explicit
    class operator Implicit(const a: Integer): OLCurrency;
    class operator Explicit(const a: OLCurrency): Integer; // Conversion to Integer can be lossy
    // Math (Bidirectional)
    class operator Add(const a: OLCurrency; const b: Integer): OLCurrency;
    class operator Add(const a: Integer; const b: OLCurrency): OLCurrency;
    class operator Subtract(const a: OLCurrency; const b: Integer): OLCurrency;
    class operator Subtract(const a: Integer; const b: OLCurrency): OLCurrency;
    class operator Multiply(const a: OLCurrency; const b: Integer): OLCurrency;
    class operator Multiply(const a: Integer; const b: OLCurrency): OLCurrency;
    class operator Divide(const a: OLCurrency; const b: Integer): OLDouble;
    class operator Divide(const a: Integer; const b: OLCurrency): OLDouble;
    // Compare
    class operator Equal(const a: OLCurrency; const b: Integer): Boolean;
    class operator NotEqual(const a: OLCurrency; const b: Integer): Boolean;
    class operator GreaterThan(const a: OLCurrency; const b: Integer): Boolean;
    class operator GreaterThanOrEqual(const a: OLCurrency; const b: Integer): Boolean;
    class operator LessThan(const a: OLCurrency; const b: Integer): Boolean;
    class operator LessThanOrEqual(const a: OLCurrency; const b: Integer): Boolean;

    class operator Equal(const a: Integer; const b: OLCurrency): Boolean;
    class operator NotEqual(const a: Integer; const b: OLCurrency): Boolean;
    class operator GreaterThan(const a: Integer; const b: OLCurrency): Boolean;
    class operator GreaterThanOrEqual(const a: Integer; const b: OLCurrency): Boolean;
    class operator LessThan(const a: Integer; const b: OLCurrency): Boolean;
    class operator LessThanOrEqual(const a: Integer; const b: OLCurrency): Boolean;
    {$ENDREGION}

    {$REGION 'Operator Overloads - Double'}
    // Implicit/Explicit
    class operator Implicit(const a: Double): OLCurrency;
    class operator Implicit(const a: OLCurrency): Double; // Kept Implicit as per original file style for floats
    // Math (Bidirectional)
    class operator Add(const a: OLCurrency; const b: Double): OLCurrency;
    class operator Add(const a: Double; const b: OLCurrency): OLCurrency;
    class operator Subtract(const a: OLCurrency; const b: Double): OLCurrency;
    class operator Subtract(const a: Double; const b: OLCurrency): OLCurrency;
    class operator Multiply(const a: OLCurrency; const b: Double): OLCurrency;
    class operator Multiply(const a: Double; const b: OLCurrency): OLCurrency;
    class operator Divide(const a: OLCurrency; const b: Double): OLDouble;
    class operator Divide(const a: Double; const b: OLCurrency): OLDouble;
    // Compare
    class operator Equal(const a: OLCurrency; const b: Double): Boolean;
    class operator NotEqual(const a: OLCurrency; const b: Double): Boolean;
    class operator GreaterThan(const a: OLCurrency; const b: Double): Boolean;
    class operator GreaterThanOrEqual(const a: OLCurrency; const b: Double): Boolean;
    class operator LessThan(const a: OLCurrency; const b: Double): Boolean;
    class operator LessThanOrEqual(const a: OLCurrency; const b: Double): Boolean;

    class operator Equal(const a: Double; const b: OLCurrency): Boolean;
    class operator NotEqual(const a: Double; const b: OLCurrency): Boolean;
    class operator GreaterThan(const a: Double; const b: OLCurrency): Boolean;
    class operator GreaterThanOrEqual(const a: Double; const b: OLCurrency): Boolean;
    class operator LessThan(const a: Double; const b: OLCurrency): Boolean;
    class operator LessThanOrEqual(const a: Double; const b: OLCurrency): Boolean;
    {$ENDREGION}

    {$REGION 'Operator Overloads - OLDouble'}
    // Implicit/Explicit
    class operator Implicit(const a: OLDouble): OLCurrency;
    class operator Implicit(const a: OLCurrency): OLDouble; // Kept Implicit as per original file style for floats
    // Math (Bidirectional)
    class operator Add(const a: OLCurrency; const b: OLDouble): OLCurrency;
    class operator Add(const a: OLDouble; const b: OLCurrency): OLCurrency;
    class operator Subtract(const a: OLCurrency; const b: OLDouble): OLCurrency;
    class operator Subtract(const a: OLDouble; const b: OLCurrency): OLCurrency;
    class operator Multiply(const a: OLCurrency; const b: OLDouble): OLCurrency;
    class operator Multiply(const a: OLDouble; const b: OLCurrency): OLCurrency;
    class operator Divide(const a: OLCurrency; const b: OLDouble): OLDouble;
    class operator Divide(const a: OLDouble; const b: OLCurrency): OLDouble;
    // Compare
    class operator Equal(const a: OLCurrency; const b: OLDouble): Boolean;
    class operator NotEqual(const a: OLCurrency; const b: OLDouble): Boolean;
    class operator GreaterThan(const a: OLCurrency; const b: OLDouble): Boolean;
    class operator GreaterThanOrEqual(const a: OLCurrency; const b: OLDouble):
        Boolean;
    class operator LessThan(const a: OLCurrency; const b: OLDouble): Boolean;
    class operator LessThanOrEqual(const a: OLCurrency; const b: OLDouble): Boolean;

    class operator Equal(const a: OLDouble; const b: OLCurrency): Boolean;
    class operator NotEqual(const a: OLDouble; const b: OLCurrency): Boolean;
    class operator GreaterThan(const a: OLDouble; const b: OLCurrency): Boolean;
    class operator GreaterThanOrEqual(const a: OLDouble; const b: OLCurrency):
        Boolean;
    class operator LessThan(const a: OLDouble; const b: OLCurrency): Boolean;
    class operator LessThanOrEqual(const a: OLDouble; const b: OLCurrency): Boolean;
    {$ENDREGION}

    {$REGION 'Operator Overloads - OLInteger'}
    // Implicit/Explicit
    class operator Implicit(const a: OLInteger): OLCurrency;
    class operator Implicit(const a: OLCurrency): OLInteger;
    // Math (Bidirectional)
    class operator Add(const a: OLCurrency; const b: OLInteger): OLCurrency;
    class operator Add(const a: OLInteger; const b: OLCurrency): OLCurrency;
    class operator Subtract(const a: OLCurrency; const b: OLInteger): OLCurrency;
    class operator Subtract(const a: OLInteger; const b: OLCurrency): OLCurrency;
    class operator Multiply(const a: OLCurrency; const b: OLInteger): OLCurrency;
    class operator Multiply(const a: OLInteger; const b: OLCurrency): OLCurrency;
    class operator Divide(const a: OLCurrency; const b: OLInteger): OLDouble;
    class operator Divide(const a: OLInteger; const b: OLCurrency): OLDouble;
    // Compare
    class operator Equal(const a: OLCurrency; const b: OLInteger): Boolean;
    class operator NotEqual(const a: OLCurrency; const b: OLInteger): Boolean;
    class operator GreaterThan(const a: OLCurrency; const b: OLInteger): Boolean;
    class operator GreaterThanOrEqual(const a: OLCurrency; const b: OLInteger):
        Boolean;
    class operator LessThan(const a: OLCurrency; const b: OLInteger): Boolean;
    class operator LessThanOrEqual(const a: OLCurrency; const b: OLInteger):
        Boolean;

    class operator Equal(const a: OLInteger; const b: OLCurrency): Boolean;
    class operator NotEqual(const a: OLInteger; const b: OLCurrency): Boolean;
    class operator GreaterThan(const a: OLInteger; const b: OLCurrency): Boolean;
    class operator GreaterThanOrEqual(const a: OLInteger; const b: OLCurrency):
        Boolean;
    class operator LessThan(const a: OLInteger; const b: OLCurrency): Boolean;
    class operator LessThanOrEqual(const a: OLInteger; const b: OLCurrency):
        Boolean;
    {$ENDREGION}

    {$REGION 'Operator Overloads - Extended'}
    // Implicit/Explicit
    class operator Implicit(const a: Extended): OLCurrency;
    class operator Implicit(const a: OLCurrency): Extended;
    // Math (Bidirectional)
    class operator Add(const a: OLCurrency; const b: Extended): OLCurrency;
    class operator Add(const a: Extended; const b: OLCurrency): OLCurrency;
    class operator Subtract(const a: OLCurrency; const b: Extended): OLCurrency;
    class operator Subtract(const a: Extended; const b: OLCurrency): OLCurrency;
    class operator Multiply(const a: OLCurrency; const b: Extended): OLCurrency;
    class operator Multiply(const a: Extended; const b: OLCurrency): OLCurrency;
    class operator Divide(const a: OLCurrency; const b: Extended): OLDouble;
    class operator Divide(const a: Extended; const b: OLCurrency): OLDouble;
    // Compare
    class operator Equal(const a: OLCurrency; const b: Extended): Boolean;
    class operator NotEqual(const a: OLCurrency; const b: Extended): Boolean;
    class operator GreaterThan(const a: OLCurrency; const b: Extended): Boolean;
    class operator GreaterThanOrEqual(const a: OLCurrency; const b: Extended): Boolean;
    class operator LessThan(const a: OLCurrency; const b: Extended): Boolean;
    class operator LessThanOrEqual(const a: OLCurrency; const b: Extended): Boolean;

    class operator Equal(const a: Extended; const b: OLCurrency): Boolean;
    class operator NotEqual(const a: Extended; const b: OLCurrency): Boolean;
    class operator GreaterThan(const a: Extended; const b: OLCurrency): Boolean;
    class operator GreaterThanOrEqual(const a: Extended; const b: OLCurrency): Boolean;
    class operator LessThan(const a: Extended; const b: OLCurrency): Boolean;
    class operator LessThanOrEqual(const a: Extended; const b: OLCurrency): Boolean;
    {$ENDREGION}

    {$REGION 'Operator Overloads - Currency (Native)'}
    // Implicit/Explicit
    class operator Implicit(const a: OLCurrency): Currency;
    // Math (Bidirectional)
    class operator Add(const a: OLCurrency; const b: Currency): OLCurrency;
    class operator Add(const a: Currency; const b: OLCurrency): OLCurrency;
    class operator Subtract(const a: OLCurrency; const b: Currency): OLCurrency;
    class operator Subtract(const a: Currency; const b: OLCurrency): OLCurrency;
    class operator Multiply(const a: OLCurrency; const b: Currency): OLCurrency;
    class operator Multiply(const a: Currency; const b: OLCurrency): OLCurrency;
    class operator Divide(const a: OLCurrency; const b: Currency): OLDouble;
    class operator Divide(const a: Currency; const b: OLCurrency): OLDouble;
    // Compare
    class operator Equal(const a: OLCurrency; const b: Currency): Boolean; overload;
    class operator NotEqual(const a: OLCurrency; const b: Currency): Boolean; overload;
    class operator GreaterThan(const a: OLCurrency; const b: Currency): Boolean; overload;
    class operator GreaterThanOrEqual(const a: OLCurrency; const b: Currency): Boolean; overload;
    class operator LessThan(const a: OLCurrency; const b: Currency): Boolean; overload;
    class operator LessThanOrEqual(const a: OLCurrency; const b: Currency): Boolean; overload;

    class operator Equal(const a: Currency; const b: OLCurrency): Boolean; overload;
    class operator NotEqual(const a: Currency; const b: OLCurrency): Boolean; overload;
    class operator GreaterThan(const a: Currency; const b: OLCurrency): Boolean; overload;
    class operator GreaterThanOrEqual(const a: Currency; const b: OLCurrency): Boolean; overload;
    class operator LessThan(const a: Currency; const b: OLCurrency): Boolean; overload;
    class operator LessThanOrEqual(const a: Currency; const b: OLCurrency): Boolean; overload;
    {$ENDREGION}

    {$REGION 'Operator Overloads - Variant'}
    class operator Implicit(const a: Variant): OLCurrency;
    class operator Implicit(const a: OLCurrency): Variant;

    class operator Equal(const a: OLCurrency; const b: Variant): Boolean; overload;
    class operator Equal(const b: Variant; const a: OLCurrency): Boolean; overload;

    class operator NotEqual(const a: OLCurrency; const b: Variant): Boolean;
        overload;
    class operator NotEqual(const b: Variant; const a: OLCurrency): Boolean;
        overload;

    class operator GreaterThan(const a: OLCurrency; const b: Variant): Boolean;
        overload;
    class operator GreaterThan(const b: Variant; const a: OLCurrency): Boolean;
        overload;
    class operator GreaterThanOrEqual(const a: OLCurrency; const b: Variant): Boolean;
        overload;
    class operator GreaterThanOrEqual(const b: Variant; const a: OLCurrency): Boolean;
        overload;

    class operator LessThan(const a: OLCurrency; const b: Variant): Boolean;
        overload;
    class operator LessThan(const b: Variant; const a: OLCurrency): Boolean;
        overload;
    class operator LessThanOrEqual(const a: OLCurrency; const b: Variant): Boolean;
        overload;
    class operator LessThanOrEqual(const b: Variant; const a: OLCurrency): Boolean;
        overload;
    {$ENDREGION}

    {$IF CompilerVersion >= 34.0}
    class operator Initialize(out Dest: OLCurrency);
    class operator Assign(var Dest: OLCurrency; const [ref] Src: OLCurrency);
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {$IFEND}
  end;

  OLDecimal = OLCurrency;
  POLCurrency = ^OLCurrency;

implementation

uses
  Math;

const
  NonEmptyStr = ' ';

// ... (Keep generic helpers: Abs, Between, Ceil, Floor, Sqr, Power, Round, SimpleRoundTo, IsPositive/Negative etc.) ...
// I will list the Operator Implementations below.

function OLCurrency.Abs(): OLCurrency;
begin
  if Self.ValuePresent then
    Result := System.Abs(FValue)
  else
    Result := Null;
end;

function OLCurrency.AsCurrency(NullReplacement: Currency = 0): Currency;
begin
  Result := IfNull(NullReplacement);
end;

function OLCurrency.Between(const BottomIncluded, TopIncluded: OLCurrency): OLBoolean;
begin
  if HasValue() then
    Result := ((FValue <= TopIncluded) and (FValue >= BottomIncluded))
  else
    Result := Null;
end;

function OLCurrency.Ceil: OLInteger;
begin
  if HasValue then
    Result := Math.Ceil(Self)
  else
    Result := null;
end;

function OLCurrency.Floor: OLInteger;
begin
  if HasValue then
    Result := Math.Floor(Self)
  else
    Result := null;
end;

function OLCurrency.GetHasValue: OLBoolean;
begin
  {$IF CompilerVersion >= 34.0}
  Result := FHasValue;
  {$ELSE}
  Result := FHasValue = ' ';
  {$IFEND}
end;

procedure OLCurrency.SetHasValue(const Value: OLBoolean);
begin
  {$IF CompilerVersion >= 34.0}
  FHasValue := Value;
  {$ELSE}
  FHasValue := Value.IfThen(' ', '');
  {$IFEND}
end;

function OLCurrency.HasValue: OLBoolean;
begin
  Result := ValuePresent;
end;

function OLCurrency.IsNull: OLBoolean;
begin
  Result := not ValuePresent;
end;

function OLCurrency.IfNull(const i: OLCurrency): OLCurrency;
begin
  if ValuePresent then
    Result := Self
  else
    Result := i;
end;

function OLCurrency.Max(const i: OLCurrency): OLCurrency;
begin
  if (not ValuePresent) or (i.IsNull) then
    Result := Null
  else
    Result := Math.Max(FValue, i.FValue);
end;

function OLCurrency.Min(const i: OLCurrency): OLCurrency;
begin
  if (not ValuePresent) or (i.IsNull) then
    Result := Null
  else
    Result := Math.Min(FValue, i.FValue);
end;

function OLCurrency.Power(const Exponent: integer): OLCurrency;
begin
  Result.ValuePresent := Self.ValuePresent;
  if Result.ValuePresent then
    Result.FValue := Math.IntPower(FValue, Exponent);
end;

function OLCurrency.Round: OLInteger;
begin
  if HasValue then
    Result := System.Trunc(Math.RoundTo(Self, 0))
  else
    Result := null;
end;

function OLCurrency.Round(const PowerOfTen: integer): OLCurrency;
begin
  if HasValue then
    Result := Math.RoundTo(Self, PowerOfTen)
  else
    Result := null;
end;

function OLCurrency.SimpleRoundTo(const PowerOfTen: Integer = -2): OLCurrency;
begin
  if HasValue then
    Result := Math.SimpleRoundTo(Self, PowerOfTen)
  else
    Result := null;
end;

function OLCurrency.Sqr: OLCurrency;
begin
  Result.ValuePresent := ValuePresent;
  if Result.ValuePresent then
    Result.FValue := FValue * FValue;
end;

function OLCurrency.IsPositive: OLBoolean;
begin
  if not ValuePresent then Result := Null else Result := FValue > 0;
end;

function OLCurrency.IsNegative: OLBoolean;
begin
  if not ValuePresent then Result := Null else Result := FValue < 0;
end;

function OLCurrency.IsNonNegative: OLBoolean;
begin
  if not ValuePresent then Result := Null else Result := FValue >= 0;
end;

function OLCurrency.ToString: string;
begin
  Result := ToStrF(ffCurrency, 2);
end;

function OLCurrency.ToSQLString: string;
var
  fs: TFormatSettings;
begin
  fs.ThousandSeparator := #0;
  fs.DecimalSeparator := '.';
  if HasValue then
    Result := CurrToStrF(Self, ffNumber, 4, fs)
  else
    Result := 'NULL';
end;

function OLCurrency.ToStrF(Format: TFloatFormat; Digits: Integer): string;
begin
  if Digits < 0 then
    raise EArgumentOutOfRangeException.Create('Digits must be >= 0');
  if ValuePresent then
    Result := CurrToStrF(FValue, Format, Digits)
  else
    Result := EmptyStr;
end;

function OLCurrency.ToString(ThousandSeparator, DecimalSeparator: Char; Format: string): string;
var
  fs: TFormatSettings;
begin
  if ValuePresent then
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
  end
  else
    Result := '';
end;

{$IF CompilerVersion >= 34.0}
class operator OLCurrency.Initialize(out Dest: OLCurrency);
begin
  Dest.FHasValue := False;
  Dest.FOnChange := nil;
end;

class operator OLCurrency.Assign(var Dest: OLCurrency; const [ref] Src: OLCurrency);
begin
  Dest.FValue := Src.FValue;
  Dest.FHasValue := Src.FHasValue;
  if Assigned(Dest.FOnChange) then Dest.FOnChange(nil);
end;
{$IFEND}

{ ============================================================================ }
{                               OPERATOR IMPLEMENTATIONS                       }
{ ============================================================================ }

{$REGION 'OLCurrency vs OLCurrency'}
class operator OLCurrency.Add(const a, b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent and b.ValuePresent;
  if Result.ValuePresent then Result.FValue := a.FValue + b.FValue;
end;

class operator OLCurrency.Subtract(const a, b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent and b.ValuePresent;
  if Result.ValuePresent then Result.FValue := a.FValue - b.FValue;
end;

class operator OLCurrency.Multiply(const a, b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent and b.ValuePresent;
  if Result.ValuePresent then Result.FValue := a.FValue * b.FValue;
end;

class operator OLCurrency.Divide(const a, b: OLCurrency): OLDouble;
begin
  if (not a.ValuePresent) or (not b.ValuePresent) then
    Result := Null
  else
    Result := a.FValue / b.FValue;
end;

class operator OLCurrency.Negative(const a: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent;
  if Result.ValuePresent then Result.FValue := -a.FValue;
end;

class operator OLCurrency.Equal(const a, b: OLCurrency): Boolean;
begin
  Result := ((a.FValue = b.FValue) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

class operator OLCurrency.NotEqual(const a, b: OLCurrency): Boolean;
begin
  Result := not (a = b);
end;

class operator OLCurrency.GreaterThan(const a, b: OLCurrency): Boolean;
begin
  Result := (a.FValue > b.FValue) and a.ValuePresent and b.ValuePresent;
end;

class operator OLCurrency.GreaterThanOrEqual(const a, b: OLCurrency): Boolean;
begin
  Result := ((a.FValue >= b.FValue) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

class operator OLCurrency.LessThan(const a, b: OLCurrency): Boolean;
begin
  Result := (a.FValue < b.FValue) and a.ValuePresent and b.ValuePresent;
end;

class operator OLCurrency.LessThanOrEqual(const a, b: OLCurrency): Boolean;
begin
  Result := ((a.FValue <= b.FValue) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;
{$ENDREGION}

{$REGION 'Integer'}
class operator OLCurrency.Implicit(const a: Integer): OLCurrency;
begin
  Result.FValue := a;
  Result.ValuePresent := True;
end;

class operator OLCurrency.Explicit(const a: OLCurrency): Integer;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null OLCurrency cannot be converted to Integer');
  Result := System.Round(a.FValue);
end;

class operator OLCurrency.Add(const a: OLCurrency; const b: Integer): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent;
  if Result.ValuePresent then Result.FValue := a.FValue + b;
end;

class operator OLCurrency.Add(const a: Integer; const b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := b.ValuePresent;
  if Result.ValuePresent then Result.FValue := a + b.FValue;
end;

class operator OLCurrency.Subtract(const a: OLCurrency; const b: Integer): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent;
  if Result.ValuePresent then Result.FValue := a.FValue - b;
end;

class operator OLCurrency.Subtract(const a: Integer; const b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := b.ValuePresent;
  if Result.ValuePresent then Result.FValue := a - b.FValue;
end;

class operator OLCurrency.Multiply(const a: OLCurrency; const b: Integer): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent;
  if Result.ValuePresent then Result.FValue := a.FValue * b;
end;

class operator OLCurrency.Multiply(const a: Integer; const b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := b.ValuePresent;
  if Result.ValuePresent then Result.FValue := a * b.FValue;
end;

class operator OLCurrency.Divide(const a: OLCurrency; const b: Integer): OLDouble;
begin
  if not a.ValuePresent then Result := Null else Result := a.FValue / b;
end;

class operator OLCurrency.Divide(const a: Integer; const b: OLCurrency): OLDouble;
begin
  if not b.ValuePresent then Result := Null else Result := a / b.FValue;
end;

class operator OLCurrency.Equal(const a: OLCurrency; const b: Integer): Boolean;
begin
  Result := a.ValuePresent and (a.FValue = b);
end;

class operator OLCurrency.NotEqual(const a: OLCurrency; const b: Integer): Boolean;
begin
  Result := a.ValuePresent and (a.FValue <> b);
end;

class operator OLCurrency.GreaterThan(const a: OLCurrency; const b: Integer): Boolean;
begin
  Result := a.ValuePresent and (a.FValue > b);
end;

class operator OLCurrency.GreaterThanOrEqual(const a: OLCurrency; const b: Integer): Boolean;
begin
  Result := a.ValuePresent and (a.FValue >= b);
end;

class operator OLCurrency.LessThan(const a: OLCurrency; const b: Integer): Boolean;
begin
  Result := a.ValuePresent and (a.FValue < b);
end;

class operator OLCurrency.LessThanOrEqual(const a: OLCurrency; const b: Integer): Boolean;
begin
  Result := a.ValuePresent and (a.FValue <= b);
end;
{$ENDREGION}

{$REGION 'Double'}
class operator OLCurrency.Implicit(const a: Double): OLCurrency;
begin
  Result.FValue := a;
  Result.ValuePresent := True;
end;

class operator OLCurrency.Implicit(const a: OLCurrency): Double;
begin
  if not a.ValuePresent then raise Exception.Create('Null OLCurrency cannot be used as Double value');
  Result := a.FValue;
end;

class operator OLCurrency.Add(const a: OLCurrency; const b: Double): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent;
  if Result.ValuePresent then
    Result.FValue := a.FValue + b;
end;

class operator OLCurrency.Add(const a: Double; const b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := b.ValuePresent;
  if Result.ValuePresent then
    Result.FValue := a + b.FValue;
end;

class operator OLCurrency.Subtract(const a: OLCurrency; const b: Double): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent;
  if Result.ValuePresent then
    Result.FValue := a.FValue - b;
end;

class operator OLCurrency.Subtract(const a: Double; const b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := b.ValuePresent;
  if Result.ValuePresent then
    Result.FValue := a - b.FValue;
end;

class operator OLCurrency.Multiply(const a: OLCurrency; const b: Double): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent;
  if Result.ValuePresent then
    Result.FValue := a.FValue * b;
end;

class operator OLCurrency.Multiply(const a: Double; const b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := b.ValuePresent;
  if Result.ValuePresent then
    Result.FValue := a * b.FValue;
end;

class operator OLCurrency.Divide(const a: OLCurrency; const b: Double): OLDouble;
begin
  if not a.ValuePresent then
    Result := Null
  else
    Result := a.FValue / b;
end;

class operator OLCurrency.Divide(const a: Double; const b: OLCurrency): OLDouble;
begin
  if not b.ValuePresent then Result := Null else Result := a / b.FValue;
end;

class operator OLCurrency.Equal(const a: OLCurrency; const b: Double): Boolean;
begin
  Result := a.ValuePresent and (SameValue(a.FValue, b));
end;

class operator OLCurrency.NotEqual(const a: OLCurrency; const b: Double): Boolean;
begin
  Result := a.ValuePresent and (not SameValue(a.FValue, b));
end;

class operator OLCurrency.GreaterThan(const a: OLCurrency; const b: Double): Boolean;
begin
  Result := a.ValuePresent and (a.FValue > b);
end;

class operator OLCurrency.GreaterThanOrEqual(const a: OLCurrency; const b: Double): Boolean;
begin
  Result := a.ValuePresent and (a.FValue >= b);
end;

class operator OLCurrency.LessThan(const a: OLCurrency; const b: Double): Boolean;
begin
  Result := a.ValuePresent and (a.FValue < b);
end;

class operator OLCurrency.LessThanOrEqual(const a: OLCurrency; const b: Double): Boolean;
begin
  Result := a.ValuePresent and (a.FValue <= b);
end;
{$ENDREGION}

{$REGION 'Extended'}
class operator OLCurrency.Implicit(const a: Extended): OLCurrency;
begin
  Result.FValue := a;
  Result.ValuePresent := True;
end;

class operator OLCurrency.Implicit(const a: OLCurrency): Extended;
begin
  if not a.ValuePresent then raise Exception.Create('Null OLCurrency cannot be used as Extended value');
  Result := a.FValue;
end;

class operator OLCurrency.Add(const a: OLCurrency; const b: Extended): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent;
  if Result.ValuePresent then
    Result.FValue := a.FValue + b;
end;

class operator OLCurrency.Add(const a: Extended; const b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := b.ValuePresent;
  if Result.ValuePresent then
    Result.FValue := a + b.FValue;
end;

class operator OLCurrency.Subtract(const a: OLCurrency; const b: Extended): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent;
  if Result.ValuePresent then
    Result.FValue := a.FValue - b;
end;

class operator OLCurrency.Subtract(const a: Extended; const b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := b.ValuePresent;
  if Result.ValuePresent then
    Result.FValue := a - b.FValue;
end;

class operator OLCurrency.Multiply(const a: OLCurrency; const b: Extended): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent;
  if Result.ValuePresent then
    Result.FValue := a.FValue * b;
end;

class operator OLCurrency.Multiply(const a: Extended; const b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := b.ValuePresent;
  if Result.ValuePresent then Result.FValue := a * b.FValue;
end;

class operator OLCurrency.Divide(const a: OLCurrency; const b: Extended): OLDouble;
begin
  if not a.ValuePresent then Result := Null else Result := a.FValue / b;
end;

class operator OLCurrency.Divide(const a: Extended; const b: OLCurrency): OLDouble;
begin
  if not b.ValuePresent then Result := Null else Result := a / b.FValue;
end;

class operator OLCurrency.Equal(const a: OLCurrency; const b: Extended): Boolean;
begin
  Result := a.ValuePresent and (SameValue(a.FValue, b));
end;

class operator OLCurrency.NotEqual(const a: OLCurrency; const b: Extended): Boolean;
begin
  Result := a.ValuePresent and (not SameValue(a.FValue, b));
end;

class operator OLCurrency.GreaterThan(const a: OLCurrency; const b: Extended): Boolean;
begin
  Result := a.ValuePresent and (a.FValue > b);
end;

class operator OLCurrency.GreaterThanOrEqual(const a: OLCurrency; const b: Extended): Boolean;
begin
  Result := a.ValuePresent and (a.FValue >= b);
end;

class operator OLCurrency.LessThan(const a: OLCurrency; const b: Extended): Boolean;
begin
  Result := a.ValuePresent and (a.FValue < b);
end;

class operator OLCurrency.LessThanOrEqual(const a: OLCurrency; const b: Extended): Boolean;
begin
  Result := a.ValuePresent and (a.FValue <= b);
end;
{$ENDREGION}

{$REGION 'Currency'}
class operator OLCurrency.Implicit(const a: OLCurrency): Currency;
begin
  if not a.ValuePresent then raise Exception.Create('Null OLCurrency cannot be used as Currency value');
  Result := a.FValue;
end;

class operator OLCurrency.Add(const a: OLCurrency; const b: Currency): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent;
  if Result.ValuePresent then Result.FValue := a.FValue + b;
end;

class operator OLCurrency.Add(const a: Currency; const b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := b.ValuePresent;
  if Result.ValuePresent then Result.FValue := a + b.FValue;
end;

class operator OLCurrency.Add(const a: OLCurrency; const b: OLDouble):
    OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent and b.HasValue;
  if Result.ValuePresent then Result.FValue := a.FValue + b.AsDouble();
end;

class operator OLCurrency.Add(const a: OLDouble; const b: OLCurrency):
    OLCurrency;
begin
  Result.ValuePresent := a.HasValue and b.HasValue;
  if Result.ValuePresent then
    Result.FValue := a.AsDouble + b.FValue;
end;

class operator OLCurrency.Add(const a: OLCurrency; const b: OLInteger):
    OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent and b.HasValue;
  if Result.ValuePresent then Result.FValue := a.FValue + b.AsInt64();
end;

class operator OLCurrency.Add(const a: OLInteger; const b: OLCurrency):
    OLCurrency;
begin
  Result.ValuePresent := a.HasValue and b.HasValue;
  if Result.ValuePresent then
    Result.FValue := a.AsInt64() + b.FValue;
end;

class operator OLCurrency.Subtract(const a: OLCurrency; const b: Currency): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent;
  if Result.ValuePresent then Result.FValue := a.FValue - b;
end;

class operator OLCurrency.Subtract(const a: Currency; const b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := b.ValuePresent;
  if Result.ValuePresent then Result.FValue := a - b.FValue;
end;

class operator OLCurrency.Multiply(const a: OLCurrency; const b: Currency): OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent;
  if Result.ValuePresent then Result.FValue := a.FValue * b;
end;

class operator OLCurrency.Multiply(const a: Currency; const b: OLCurrency): OLCurrency;
begin
  Result.ValuePresent := b.ValuePresent;
  if Result.ValuePresent then Result.FValue := a * b.FValue;
end;

class operator OLCurrency.Divide(const a: OLCurrency; const b: Currency): OLDouble;
begin
  if not a.ValuePresent then Result := Null else Result := a.FValue / b;
end;

class operator OLCurrency.Divide(const a: Currency; const b: OLCurrency): OLDouble;
begin
  if not b.ValuePresent then Result := Null else Result := a / b.FValue;
end;

class operator OLCurrency.Divide(const a: OLCurrency; const b: OLDouble):
    OLDouble;
begin
  if a.ValuePresent and b.HasValue then
    Result := a.FValue / b.AsDouble()
  else
    Result := Null;
end;

class operator OLCurrency.Divide(const a: OLDouble; const b: OLCurrency):
    OLDouble;
begin
  if a.HasValue and b.HasValue then
    Result := a.AsDouble() / b.FValue
  else
    Result := Null;
end;

class operator OLCurrency.Divide(const a: OLCurrency; const b: OLInteger):
    OLDouble;
begin
  if a.IsNull or b.IsNull then
    Result := Null
  else
    Result := a.FValue / b.AsInt64();
end;

class operator OLCurrency.Divide(const a: OLInteger; const b: OLCurrency):
    OLDouble;
begin
  if a.IsNull or b.IsNull then
    Result := Null
  else
    Result := a.AsInt64() / b.FValue;
end;

class operator OLCurrency.Equal(const a: OLCurrency; const b: Currency): Boolean;
begin
  Result := a.ValuePresent and (a.FValue = b);
end;

class operator OLCurrency.Equal(const a: OLCurrency; const b: OLDouble):
    Boolean;
begin
  Result := a.ValuePresent and b.HasValue() and (SameValue(a.FValue, b.AsDouble()));
end;

class operator OLCurrency.NotEqual(const a: OLCurrency; const b: Currency): Boolean;
begin
  Result := a.ValuePresent and (a.FValue <> b);
end;

class operator OLCurrency.GreaterThan(const a: OLCurrency; const b: Currency): Boolean;
begin
  Result := a.ValuePresent and (a.FValue > b);
end;

class operator OLCurrency.GreaterThan(const a: OLCurrency; const b: OLDouble):
    Boolean;
begin
  Result := a.ValuePresent and b.HasValue() and (a.FValue > b.AsDouble());
end;

class operator OLCurrency.GreaterThanOrEqual(const a: OLCurrency; const b: Currency): Boolean;
begin
  Result := a.ValuePresent and (a.FValue >= b);
end;

class operator OLCurrency.GreaterThanOrEqual(const a: OLCurrency; const b:
    OLDouble): Boolean;
begin
  Result := a.ValuePresent and b.HasValue() and (a.FValue >= b.AsDouble());
end;

class operator OLCurrency.LessThan(const a: OLCurrency; const b: Currency): Boolean;
begin
  Result := a.ValuePresent and (a.FValue < b);
end;

class operator OLCurrency.LessThanOrEqual(const a: OLCurrency; const b: Currency): Boolean;
begin
  Result := a.ValuePresent and (a.FValue <= b);
end;
{$ENDREGION}

{$REGION 'OL Types & Variant'}
class operator OLCurrency.Implicit(const a: OLDouble): OLCurrency;
begin
  if a.IsNull then
    Result := Null
  else
  begin
    Result.FValue := a.AsDouble();
    Result.ValuePresent := true;
  end;
end;

class operator OLCurrency.Implicit(const a: OLCurrency): OLDouble;
begin
  if a.IsNull then
    Result := Null
  else
    Result := a.FValue;
end;

class operator OLCurrency.Multiply(const a: OLCurrency; const b: OLInteger):
    OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent and b.HasValue;
  if Result.ValuePresent then Result.FValue := a.FValue * b.AsInt64();
end;

class operator OLCurrency.Multiply(const a: OLCurrency; const b: OLDouble):
    OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent and b.HasValue;
  if Result.ValuePresent then
    Result.FValue := a.FValue * b.AsDouble();
end;

class operator OLCurrency.Implicit(const a: Variant): OLCurrency;
var
  i: Currency;
begin
  if VarIsNull(a) then
    Result.ValuePresent := false
  else if TryStrToCurr(a, i) then
  begin
    Result.FValue := i;
    Result.ValuePresent := true;
  end
  else
    raise Exception.Create('Value ''' + VarToStr(a) + ''' cannot be assigned to variable of OLCurrency type.');
end;

class operator OLCurrency.Implicit(const a: OLCurrency): Variant;
begin
  if a.ValuePresent then Result := a.FValue else Result := Null;
end;

class operator OLCurrency.LessThan(const a: OLCurrency; const b: OLDouble):
    Boolean;
begin
  Result := a.ValuePresent and b.HasValue() and (a.FValue < b.AsDouble());
end;

class operator OLCurrency.LessThanOrEqual(const a: OLCurrency; const b:
    OLDouble): Boolean;
begin
  Result := a.ValuePresent and b.HasValue() and (a.FValue <= b.AsDouble());
end;

class operator OLCurrency.Multiply(const a: OLDouble; const b: OLCurrency):
    OLCurrency;
begin
  Result.ValuePresent := a.HasValue and b.HasValue;
  if Result.ValuePresent then
    Result.FValue := a.AsDouble * b.FValue;
end;

class operator OLCurrency.NotEqual(const a: OLCurrency; const b: OLDouble):
    Boolean;
begin
  Result := a.ValuePresent and b.HasValue() and (not SameValue(a.FValue, b.AsDouble()));
end;

class operator OLCurrency.Subtract(const a: OLCurrency; const b: OLDouble):
    OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent and b.HasValue;
  if Result.ValuePresent then Result.FValue := a.FValue - b.AsDouble();
end;

class operator OLCurrency.Subtract(const a: OLDouble; const b: OLCurrency):
    OLCurrency;
begin
  Result.ValuePresent := a.HasValue and b.HasValue;
  if Result.ValuePresent then
    Result.FValue := a.AsDouble - b.FValue;
end;

{$ENDREGION}

class operator OLCurrency.Equal(const a: Extended; const b: OLCurrency): Boolean;
begin
  // Porównujemy 'a' z wartością wewnątrz 'b'.
  // Jeśli b jest NULL, wynik to False (chyba że uznasz, że a=0 a b=Null to co innego, ale standardowo Null != Value)
  Result := b.ValuePresent and SameValue(a, b.FValue);
end;

class operator OLCurrency.NotEqual(const a: Extended; const b: OLCurrency): Boolean;
begin
  // Tutaj uwaga: Jeśli b jest NULL, to a <> b jest Prawdą.
  Result := (not b.ValuePresent) or (not SameValue(a, b.FValue));
end;

class operator OLCurrency.GreaterThan(const a: Extended; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a > b.FValue);
end;

class operator OLCurrency.GreaterThanOrEqual(const a: Extended; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a >= b.FValue);
end;

class operator OLCurrency.LessThan(const a: Extended; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a < b.FValue);
end;

class operator OLCurrency.LessThanOrEqual(const a: Extended; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a <= b.FValue);
end;

{$REGION 'Integer - Reversed Comparison'}

class operator OLCurrency.Equal(const a: Integer; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a = b.FValue);
end;

class operator OLCurrency.NotEqual(const a: Integer; const b: OLCurrency): Boolean;
begin
  // Zgodnie z Twoją logiką: jeśli b jest Null, wynik to False.
  Result := b.ValuePresent and (a <> b.FValue);
end;

class operator OLCurrency.GreaterThan(const a: Integer; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a > b.FValue);
end;

class operator OLCurrency.GreaterThanOrEqual(const a: Integer; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a >= b.FValue);
end;

class operator OLCurrency.LessThan(const a: Integer; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a < b.FValue);
end;

class operator OLCurrency.LessThanOrEqual(const a: Integer; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a <= b.FValue);
end;

{$ENDREGION}

{$REGION 'Double - Reversed Comparison'}

class operator OLCurrency.Equal(const a: Double; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and SameValue(a, b.FValue);
end;

class operator OLCurrency.NotEqual(const a: Double; const b: OLCurrency): Boolean;
begin
  // Używamy 'not SameValue', ale zachowujemy warunek ValuePresent = True
  Result := b.ValuePresent and (not SameValue(a, b.FValue));
end;

class operator OLCurrency.GreaterThan(const a: Double; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a > b.FValue);
end;

class operator OLCurrency.GreaterThanOrEqual(const a: Double; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a >= b.FValue);
end;

class operator OLCurrency.LessThan(const a: Double; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a < b.FValue);
end;

class operator OLCurrency.LessThanOrEqual(const a: Double; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a <= b.FValue);
end;

{$ENDREGION}


{$REGION 'Currency - Reversed Comparison'}

class operator OLCurrency.Equal(const a: Currency; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a = b.FValue);
end;

class operator OLCurrency.Equal(const a: OLDouble; const b: OLCurrency):
    Boolean;
begin
  Result := a.HasValue() and b.ValuePresent and (SameValue(a.AsDouble(), b.FValue));
end;

class operator OLCurrency.Equal(const a: OLCurrency; const b: Variant): Boolean;
var
  c: Currency;
begin
  if VarIsNull(b) and a.IsNull then
    Exit(True);

  if (not VarIsNull(b)) and a.IsNull then
    Exit(False);

  if VarIsNull(b) and a.HasValue then
    Exit(False);

  try
    c := VarAsType(b, varCurrency)
  except
    raise Exception.Create('Value ' + VarToStr(b) + ' cannot be used as OLCurency.');
  end;

  Result := a.FValue = c;
end;

class operator OLCurrency.Equal(const b: Variant; const a: OLCurrency): Boolean;
var
  c: Currency;
begin
  if VarIsNull(b) and a.IsNull then
    Exit(True);

  if (not VarIsNull(b)) and a.IsNull then
    Exit(False);

  if VarIsNull(b) and a.HasValue then
    Exit(False);

  try
    c := VarAsType(b, varCurrency)
  except
    raise Exception.Create('Value ' + VarToStr(b) + ' cannot be used as OLCurency.');
  end;

  Result := a.FValue = c;
end;

class operator OLCurrency.Equal(const a: OLCurrency; const b: OLInteger):
    Boolean;
begin
  Result := a.ValuePresent and b.HasValue() and (SameValue(a.FValue, b.AsInt64()));
end;

class operator OLCurrency.Equal(const a: OLInteger; const b: OLCurrency):
    Boolean;
begin
  Result := a.HasValue() and b.ValuePresent and (SameValue(a.AsInt64(), b.FValue));
end;

class operator OLCurrency.NotEqual(const a: Currency; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a <> b.FValue);
end;

class operator OLCurrency.GreaterThan(const a: Currency; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a > b.FValue);
end;

class operator OLCurrency.GreaterThan(const a: OLDouble; const b: OLCurrency):
    Boolean;
begin
  Result := a.HasValue() and b.ValuePresent and (a.AsDouble() > b.FValue);
end;

class operator OLCurrency.GreaterThan(const a: OLCurrency; const b: Variant):
    Boolean;
var
  c: Currency;
begin
  if VarIsNull(b) or a.IsNull then
    Exit(False);

  try
    c := VarAsType(b, varCurrency)
  except
    raise Exception.Create('Value ' + VarToStr(b) + ' cannot be used as OLCurrency.');
  end;

  Result := a.FValue > c;
end;

class operator OLCurrency.GreaterThan(const b: Variant; const a: OLCurrency):
    Boolean;
var
  c: Currency;
begin
  if VarIsNull(b) or a.IsNull then
    Exit(False);

  try
    c := VarAsType(b, varCurrency)
  except
    raise Exception.Create('Value ' + VarToStr(b) + ' cannot be used as OLCurrency.');
  end;

  Result := c > a.FValue;
end;

class operator OLCurrency.GreaterThan(const a: OLCurrency; const b: OLInteger):
    Boolean;
begin
  Result := a.ValuePresent and b.HasValue() and (a.FValue > b.AsInt64());
end;

class operator OLCurrency.GreaterThan(const a: OLInteger; const b: OLCurrency):
    Boolean;
begin
  Result := a.HasValue() and b.ValuePresent and (a.AsInt64() > b.FValue);
end;

class operator OLCurrency.GreaterThanOrEqual(const a: Currency; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a >= b.FValue);
end;

class operator OLCurrency.GreaterThanOrEqual(const a: OLDouble; const b:
    OLCurrency): Boolean;
begin
  Result := a.HasValue() and b.ValuePresent and (a.AsDouble() >= b.FValue);
end;

class operator OLCurrency.LessThan(const a: Currency; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a < b.FValue);
end;

class operator OLCurrency.LessThan(const a: OLDouble; const b: OLCurrency):
    Boolean;
begin
  Result := a.HasValue() and b.ValuePresent and (a.AsDouble() < b.FValue);
end;

class operator OLCurrency.LessThanOrEqual(const a: Currency; const b: OLCurrency): Boolean;
begin
  Result := b.ValuePresent and (a <= b.FValue);
end;

class operator OLCurrency.LessThanOrEqual(const a: OLDouble; const b:
    OLCurrency): Boolean;
begin
  Result := a.HasValue() and b.ValuePresent and (a.AsDouble() <= b.FValue);
end;

class operator OLCurrency.NotEqual(const a: OLDouble; const b: OLCurrency):
    Boolean;
begin
  Result := a.HasValue() and b.ValuePresent and (not SameValue(a.AsDouble(), b.FValue));
end;

class operator OLCurrency.GreaterThanOrEqual(const a: OLCurrency; const b: Variant):
    Boolean;
var
  c: Currency;
begin
  if VarIsNull(b) or a.IsNull then
    Exit(False);

  try
    c := VarAsType(b, varCurrency)
  except
    raise Exception.Create('Value ' + VarToStr(b) + ' cannot be used as OLCurrency.');
  end;

  Result := a.FValue >= c;
end;

class operator OLCurrency.GreaterThanOrEqual(const b: Variant; const a: OLCurrency):
    Boolean;
var
  c: Currency;
begin
  if VarIsNull(b) or a.IsNull then
    Exit(False);

  try
    c := VarAsType(b, varCurrency)
  except
    raise Exception.Create('Value ' + VarToStr(b) + ' cannot be used as OLCurrency.');
  end;

  Result := c >= a.FValue;
end;

class operator OLCurrency.GreaterThanOrEqual(const a: OLCurrency; const b:
    OLInteger): Boolean;
begin
  Result := a.ValuePresent and b.HasValue() and (a.FValue >= b.AsInt64());
end;

class operator OLCurrency.GreaterThanOrEqual(const a: OLInteger; const b:
    OLCurrency): Boolean;
begin
  Result := a.HasValue() and b.ValuePresent and (a.AsInt64() >= b.FValue);
end;

class operator OLCurrency.Implicit(const a: OLInteger): OLCurrency;
begin
  if a.IsNull then
    Result := Null
  else
  begin
    Result.FValue := a.AsInteger();
    Result.ValuePresent := true;
  end;
end;

class operator OLCurrency.Implicit(const a: OLCurrency): OLInteger;
begin
  if a.IsNull then
    Result := Null
  else
    Result := a.FValue;
end;

class operator OLCurrency.LessThan(const a: OLCurrency; const b: Variant):
    Boolean;
var
  c: Currency;
begin
  if VarIsNull(b) or a.IsNull then
    Exit(False);

  try
    c := VarAsType(b, varCurrency)
  except
    raise Exception.Create('Value ' + VarToStr(b) + ' cannot be used as OLCurrency.');
  end;

  Result := a.FValue < c;
end;

class operator OLCurrency.LessThan(const b: Variant; const a: OLCurrency):
    Boolean;
var
  c: Currency;
begin
  if VarIsNull(b) or a.IsNull then
    Exit(False);

  try
    c := VarAsType(b, varCurrency)
  except
    raise Exception.Create('Value ' + VarToStr(b) + ' cannot be used as OLCurrency.');
  end;

  Result := c < a.FValue;
end;

class operator OLCurrency.LessThan(const a: OLCurrency; const b: OLInteger):
    Boolean;
begin
  Result := a.ValuePresent and b.HasValue() and (a.FValue < b.AsInt64());
end;

class operator OLCurrency.LessThan(const a: OLInteger; const b: OLCurrency):
    Boolean;
begin
  Result := a.HasValue() and b.ValuePresent and (a.AsInt64() < b.FValue);
end;

class operator OLCurrency.LessThanOrEqual(const a: OLCurrency; const b:
    Variant): Boolean;
var
  c: Currency;
begin
  if VarIsNull(b) or a.IsNull then
    Exit(False);

  try
    c := VarAsType(b, varCurrency)
  except
    raise Exception.Create('Value ' + VarToStr(b) + ' cannot be used as OLCurrency.');
  end;

  Result := a.FValue <= c;
end;

class operator OLCurrency.LessThanOrEqual(const b: Variant; const a:
    OLCurrency): Boolean;
var
  c: Currency;
begin
  if VarIsNull(b) or a.IsNull then
    Exit(False);

  try
    c := VarAsType(b, varCurrency)
  except
    raise Exception.Create('Value ' + VarToStr(b) + ' cannot be used as OLCurrency.');
  end;

  Result := c <= a.FValue;
end;

class operator OLCurrency.LessThanOrEqual(const a: OLCurrency; const b:
    OLInteger): Boolean;
begin
  Result := a.ValuePresent and b.HasValue() and (a.FValue <= b.AsInt64());
end;

class operator OLCurrency.LessThanOrEqual(const a: OLInteger; const b:
    OLCurrency): Boolean;
begin
  Result := a.HasValue() and b.ValuePresent and (a.AsInt64() <= b.FValue);
end;

class operator OLCurrency.Multiply(const a: OLInteger; const b: OLCurrency):
    OLCurrency;
begin
  Result.ValuePresent := a.HasValue and b.HasValue;
  if Result.ValuePresent then
    Result.FValue := a.AsInt64() * b.FValue;
end;

class operator OLCurrency.NotEqual(const a: OLCurrency; const b: Variant):
    Boolean;
var
  c: Currency;
begin
  if VarIsNull(b) and a.IsNull then
    Exit(False);

  if (not VarIsNull(b)) and a.IsNull then
    Exit(True);

  if VarIsNull(b) and a.HasValue then
    Exit(True);

  try
    c := VarAsType(b, varCurrency)
  except
    raise Exception.Create('Value ' + VarToStr(b) + ' cannot be used as OLCurency.');
  end;

  Result := a.FValue <> c;
end;

class operator OLCurrency.NotEqual(const b: Variant; const a: OLCurrency):
    Boolean;
var
  c: Currency;
begin
  if VarIsNull(b) and a.IsNull then
    Exit(False);

  if (not VarIsNull(b)) and a.IsNull then
    Exit(True);

  if VarIsNull(b) and a.HasValue then
    Exit(True);

  try
    c := VarAsType(b, varCurrency)
  except
    raise Exception.Create('Value ' + VarToStr(b) + ' cannot be used as OLCurency.');
  end;

  Result := a.FValue <> c;
end;

class operator OLCurrency.NotEqual(const a: OLCurrency; const b: OLInteger):
    Boolean;
begin
  Result := a.ValuePresent and b.HasValue() and (not SameValue(a.FValue, b.AsInt64()));
end;

class operator OLCurrency.NotEqual(const a: OLInteger; const b: OLCurrency):
    Boolean;
begin
  Result := a.HasValue() and b.ValuePresent and (not SameValue(a.AsInt64(), b.FValue));
end;

class operator OLCurrency.Subtract(const a: OLCurrency; const b: OLInteger):
    OLCurrency;
begin
  Result.ValuePresent := a.ValuePresent and b.HasValue;
  if Result.ValuePresent then Result.FValue := a.FValue - b.AsInt64();
end;

class operator OLCurrency.Subtract(const a: OLInteger; const b: OLCurrency):
    OLCurrency;
begin
  Result.ValuePresent := a.HasValue and b.HasValue;
  if Result.ValuePresent then
    Result.FValue := a.AsInt64() - b.FValue;
end;

{$ENDREGION}

end.
