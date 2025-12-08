unit DoubleHelperFunctions;

interface

uses
  System.SysUtils;

// --- Instance Functions (operating on 'd: Double') ---

function Instance_Exponent(var d: Double): Integer;
function Instance_Fraction(var d: Double): Extended;
function Instance_Mantissa(var d: Double): UInt64;
function Instance_GetSign(var d: Double): Boolean;
procedure Instance_SetSign(var d: Double; NewSign: Boolean);
function Instance_GetExp(var d: Double): UInt64;
procedure Instance_SetExp(var d: Double; NewExp: UInt64);
function Instance_GetFrac(var d: Double): UInt64;
procedure Instance_SetFrac(var d: Double; NewFrac: UInt64);
function Instance_SpecialType(var d: Double): TFloatSpecial;
procedure Instance_BuildUp(var d: Double; const SignFlag: Boolean; const Mantissa: UInt64; const Exponent: Integer);
function Instance_ToString(var d: Double): string; overload; inline;
function Instance_ToString(var d: Double; const AFormatSettings: TFormatSettings): string; overload; inline;
function Instance_ToString(var d: Double; const Format: TFloatFormat; const Precision, Digits: Integer): string; overload; inline;
function Instance_ToString(var d: Double; const Format: TFloatFormat; const Precision, Digits: Integer;
                           const AFormatSettings: TFormatSettings): string; overload; inline;
function Instance_IsNan(var d: Double): Boolean; overload; inline;
function Instance_IsInfinity(var d: Double): Boolean; overload; inline;
function Instance_IsNegativeInfinity(var d: Double): Boolean; overload; inline;
function Instance_IsPositiveInfinity(var d: Double): Boolean; overload; inline;
function Instance_GetBytes(var d: Double; Index: Cardinal): UInt8;
procedure Instance_SetBytes(var d: Double; Index: Cardinal; const Value: UInt8);
function Instance_GetWords(var d: Double; Index: Cardinal): UInt16;
procedure Instance_SetWords(var d: Double; Index: Cardinal; const Value: UInt16);

// --- Type Functions (Static methods) ---

function Type_ToString(const Value: Double): string; overload;
function Type_ToString(const Value: Double; const AFormatSettings: TFormatSettings): string; overload;
function Type_ToString(const Value: Double; const Format: TFloatFormat; const Precision, Digits: Integer): string; overload;
function Type_ToString(const Value: Double; const Format: TFloatFormat; const Precision, Digits: Integer;
                       const AFormatSettings: TFormatSettings): string; overload;
function Type_Parse(const S: string; const AFormatSettings: TFormatSettings): Double; overload;
function Type_Parse(const S: string): Double; overload;
function Type_TryParse(const S: string; out Value: Double; const AFormatSettings: TFormatSettings): Boolean; overload;
function Type_TryParse(const S: string; out Value: Double): Boolean; overload;
function Type_IsNan(const Value: Double): Boolean; overload;
function Type_IsInfinity(const Value: Double): Boolean; overload;
function Type_IsNegativeInfinity(const Value: Double): Boolean; overload;
function Type_IsPositiveInfinity(const Value: Double): Boolean; overload;
function Type_Size: Integer;

implementation

// --- Implementation of Instance Functions ---

function Instance_Exponent(var d: Double): Integer;
begin
  // Returns the exponent part of the double-precision floating-point number.
  Result := d.Exponent;
end;

function Instance_Fraction(var d: Double): Extended;
begin
  // Returns the fractional part of the double-precision floating-point number.
  Result := d.Fraction;
end;

function Instance_Mantissa(var d: Double): UInt64;
begin
  // Returns the mantissa part of the double-precision floating-point number.
  Result := d.Mantissa;
end;

function Instance_GetSign(var d: Double): Boolean;
begin
  // Reads the sign bit.
  Result := d.Sign;
end;

procedure Instance_SetSign(var d: Double; NewSign: Boolean);
begin
  // Writes to the sign bit.
  d.Sign := NewSign;
end;

function Instance_GetExp(var d: Double): UInt64;
begin
  // Reads the raw exponent value.
  Result := d.Exp;
end;

procedure Instance_SetExp(var d: Double; NewExp: UInt64);
begin
  // Writes to the raw exponent value.
  d.Exp := NewExp;
end;

function Instance_GetFrac(var d: Double): UInt64;
begin
  // Reads the raw fractional value (significand).
  Result := d.Frac;
end;

procedure Instance_SetFrac(var d: Double; NewFrac: UInt64);
begin
  // Writes to the raw fractional value (significand).
  d.Frac := NewFrac;
end;

function Instance_SpecialType(var d: Double): TFloatSpecial;
begin
  // Returns the special type (NaN, Infinity, Normal, etc.).
  Result := d.SpecialType;
end;

procedure Instance_BuildUp(var d: Double; const SignFlag: Boolean; const Mantissa: UInt64; const Exponent: Integer);
begin
  // Constructs a Double from sign, mantissa, and exponent.
  d.BuildUp(SignFlag, Mantissa, Exponent);
end;

function Instance_ToString(var d: Double): string; overload;
begin
  // Converts the Double value to its string representation using default formatting.
  Result := d.ToString;
end;

function Instance_ToString(var d: Double; const AFormatSettings: TFormatSettings): string; overload;
begin
  // Converts the Double value to its string representation using specific formatting settings.
  Result := d.ToString(AFormatSettings);
end;

function Instance_ToString(var d: Double; const Format: TFloatFormat; const Precision, Digits: Integer): string; overload;
begin
  // Converts the Double value to its string representation using format parameters.
  Result := d.ToString(Format, Precision, Digits);
end;

function Instance_ToString(var d: Double; const Format: TFloatFormat; const Precision, Digits: Integer;
                           const AFormatSettings: TFormatSettings): string; overload;
begin
  // Converts the Double value to its string representation using format parameters and settings.
  Result := d.ToString(Format, Precision, Digits, AFormatSettings);
end;

function Instance_IsNan(var d: Double): Boolean; overload;
begin
  // Checks if the Double value is Not a Number (NaN).
  Result := d.IsNan;
end;

function Instance_IsInfinity(var d: Double): Boolean; overload;
begin
  // Checks if the Double value is positive or negative infinity.
  Result := d.IsInfinity;
end;

function Instance_IsNegativeInfinity(var d: Double): Boolean; overload;
begin
  // Checks if the Double value is negative infinity.
  Result := d.IsNegativeInfinity;
end;

function Instance_IsPositiveInfinity(var d: Double): Boolean; overload;
begin
  // Checks if the Double value is positive infinity.
  Result := d.IsPositiveInfinity;
end;

function Instance_GetBytes(var d: Double; Index: Cardinal): UInt8;
begin
  // Reads one byte of the underlying IEEE-754 representation (0..7).
  Result := d.Bytes[Index];
end;

procedure Instance_SetBytes(var d: Double; Index: Cardinal; const Value: UInt8);
begin
  // Writes one byte of the underlying IEEE-754 representation (0..7).
  d.Bytes[Index] := Value;
end;

function Instance_GetWords(var d: Double; Index: Cardinal): UInt16;
begin
  // Reads one word (2 bytes) of the underlying IEEE-754 representation (0..3).
  Result := d.Words[Index];
end;

procedure Instance_SetWords(var d: Double; Index: Cardinal; const Value: UInt16);
begin
  // Writes one word (2 bytes) of the underlying IEEE-754 representation (0..3).
  d.Words[Index] := Value;
end;

// --- Implementation of Type Functions ---

function Type_ToString(const Value: Double): string; overload;
begin
  // Converts a given Double value to its string representation using default formatting.
  Result := Double.ToString(Value);
end;

function Type_ToString(const Value: Double; const AFormatSettings: TFormatSettings): string; overload;
begin
  // Converts a given Double value to its string representation using specific formatting settings.
  Result := Double.ToString(Value, AFormatSettings);
end;

function Type_ToString(const Value: Double; const Format: TFloatFormat; const Precision, Digits: Integer): string; overload;
begin
  // Converts a given Double value to its string representation using format parameters.
  Result := Double.ToString(Value, Format, Precision, Digits);
end;

function Type_ToString(const Value: Double; const Format: TFloatFormat; const Precision, Digits: Integer;
                       const AFormatSettings: TFormatSettings): string; overload;
begin
  // Converts a given Double value to its string representation using format parameters and settings.
  Result := Double.ToString(Value, Format, Precision, Digits, AFormatSettings);
end;

function Type_Parse(const S: string; const AFormatSettings: TFormatSettings): Double; overload;
begin
  // Converts a string to a Double value using specific formatting settings.
  Result := Double.Parse(S, AFormatSettings);
end;

function Type_Parse(const S: string): Double; overload;
begin
  // Converts a string to a Double value using default formatting.
  Result := Double.Parse(S);
end;

function Type_TryParse(const S: string; out Value: Double; const AFormatSettings: TFormatSettings): Boolean; overload;
begin
  // Attempts to convert a string to a Double value using specific formatting settings.
  Result := Double.TryParse(S, Value, AFormatSettings);
end;

function Type_TryParse(const S: string; out Value: Double): Boolean; overload;
begin
  // Attempts to convert a string to a Double value using default formatting.
  Result := Double.TryParse(S, Value);
end;

function Type_IsNan(const Value: Double): Boolean; overload;
begin
  // Checks if the given Double value is Not a Number (NaN).
  Result := Double.IsNan(Value);
end;

function Type_IsInfinity(const Value: Double): Boolean; overload;
begin
  // Checks if the given Double value is positive or negative infinity.
  Result := Double.IsInfinity(Value);
end;

function Type_IsNegativeInfinity(const Value: Double): Boolean; overload;
begin
  // Checks if the given Double value is negative infinity.
  Result := Double.IsNegativeInfinity(Value);
end;

function Type_IsPositiveInfinity(const Value: Double): Boolean; overload;
begin
  // Checks if the given Double value is positive infinity.
  Result := Double.IsPositiveInfinity(Value);
end;

function Type_Size: Integer;
begin
  // Returns the size of the Double type in bytes.
  Result := Double.Size;
end;

end.
