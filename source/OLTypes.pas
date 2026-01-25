unit OLTypes;

interface

uses
  OLBooleanType, OLCurrencyType, OLDateTimeType, OLDateType, OLDoubleType,
  OLIntegerType, OLStringType, SmartToDate, OLArrays, OLDictionaries,
  {$IFDEF VCL}
  Vcl.Graphics,
  {$ENDIF}
  {$IFDEF FMX}
  FMX.Graphics, FMX.TextLayout,
  {$ENDIF}
  {$IF CompilerVersion >= 23.0} System.SysUtils, System.Classes, System.Generics.Collections, System.Rtti,
    Vcl.Forms, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Controls
  {$ELSE} SysUtils, Classes, Generics.Collections, Rtti,
    Forms, StdCtrls, Spin, ComCtrls, ExtCtrls, Controls
  {$IFEND}, OLValidation, OLValidationTypes, OLTypesToEdits, OLColorType,
  OLThreadRunner, TypInfo;

type
  TRttiFieldHack = class(TRttiField);


type
  OLColor = OLColorType.OLColor;
  TOLThreadRuner = OLThreadRunner.TOLThreadRuner;

  TOLValidationResult = OLValidationTypes.TOLValidationResult;

  TOLIntegerValidationFunction = OLValidationTypes.TOLIntegerValidationFunction;
  TOLDoubleValidationFunction = OLValidationTypes.TOLDoubleValidationFunction;
  TOLCurrencyValidationFunction = OLValidationTypes.TOLCurrencyValidationFunction;
  TOLStringValidationFunction = OLValidationTypes.TOLStringValidationFunction;
  TOLBooleanValidationFunction = OLValidationTypes.TOLBooleanValidationFunction;
  TOLDateValidationFunction = OLValidationTypes.TOLDateValidationFunction;
  TOLDateTimeValidationFunction = OLValidationTypes.TOLDateTimeValidationFunction;


  OLBoolean = OLBooleanType.OLBoolean;
  OLCurrency = OLCurrencyType.OLCurrency;
  OLDecimal = OLCurrencyType.OLCurrency;
  OLDateTime = OLDateTimeType.OLDateTime;
  OLDate = OLDateType.OLDate;
  OLDouble = OLDoubleType.OLDouble;
  OLInteger = OLIntegerType.OLInteger;
  OLInt64 = OLIntegerType.OLInt64;
  OLString = OLStringType.OLString;

  POLBoolean = OLBooleanType.POLBoolean;
  POLCurrency = OLCurrencyType.POLCurrency;
  POLDecimal = OLCurrencyType.POLCurrency;
  POLDateTime = OLDateTimeType.POLDateTime;
  POLDate = OLDateType.POLDate;
  POLDouble = OLDoubleType.POLDouble;
  POLInteger = OLIntegerType.POLInteger;
  POLInt64 = OLIntegerType.POLInt64;
  POLString = OLStringType.POLString;

  TOLBooleanDynArray = OLArrays.TOLBooleanDynArray;
  TOLCurrencyDynArray = OLArrays.TOLCurrencyDynArray;
  TOLDateTimeDynArray = OLArrays.TOLDateTimeDynArray;
  TOLDateDynArray = OLArrays.TOLDateDynArray;
  TOLDoubleDynArray = OLArrays.TOLDoubleDynArray;
  TOLIntegerDynArray = OLArrays.TOLIntegerDynArray;
  TOLInt64DynArray = OLArrays.TOLInt64DynArray;
  TOLByteDynArray = OLArrays.TOLByteDynArray;
  TOLStringDynArray = OLArrays.TOLStringDynArray;

  OLBooleanArray = OLArrays.OLBooleanArray;
  OLCurrencyArray = OLArrays.OLCurrencyArray;
  OLDateArray = OLArrays.OLDateArray;
  OLDateTimeArray = OLArrays.OLDateTimeArray;
  OLDoubleArray = OLArrays.OLDoubleArray;
  OLInt64Array = OLArrays.OLInt64Array;
  OLIntegerArray = OLArrays.OLIntegerArray;
  OLStringArray = OLArrays.OLStringArray;

  {$IF CompilerVersion >= 34.0}
  OLIntIntDictionary = OLDictionaries.OLIntIntDictionary;
  OLIntStrDictionary = OLDictionaries.OLIntStrDictionary;
  OLIntDblDictionary = OLDictionaries.OLIntDblDictionary;
  OLIntCurrDictionary = OLDictionaries.OLIntCurrDictionary;
  OLIntBooleanDictionary = OLDictionaries.OLIntBooleanDictionary;
  OLStrStrDictionary = OLDictionaries.OLStrStrDictionary;
  OLStrIntDictionary = OLDictionaries.OLStrIntDictionary;
  OLStrCurrDictionary = OLDictionaries.OLStrCurrDictionary;
  OLIntDateDictionary = OLDictionaries.OLIntDateDictionary;
  OLStrDblDictionary = OLDictionaries.OLStrDblDictionary;
  OLDictionary<K, V> = record
  private
    FEngine: OLDictionaries.OLGenericDictionary<K, V>;
    function GetValue(const Key: K): V;
    procedure SetValue(const Key: K; const Value: V);
    function GetKeys: TArray<K>;
  public
    {$IF CompilerVersion >= 31.0}
    class operator Assign(var Dest: OLDictionary<K, V>; const [ref] Src: OLDictionary<K, V>);
    {$ELSE}
    class operator Assign(var Dest: OLDictionary<K, V>; const Src: OLDictionary<K, V>);
    {$IFEND}

    procedure Clear;
    procedure Add(const Key: K; const Value: V);
    function Remove(const Key: K): OLBoolean;
    function TryGetValue(const Key: K; out Value: V): OLBoolean;
    function ContainsKey(const Key: K): OLBoolean;
    function Count: Integer;
    function GetEnumerator: TDictionary<K, V>.TPairEnumerator;
    function ToArray: TArray<TPair<K, V>>;

    property Values[const Key: K]: V read GetValue write SetValue; default;
    property Keys: TArray<K> read GetKeys;
  end;
  {$IFEND}

  TStringPatternFind = OLStringType.TStringPatternFind;

  TCaseSensitivity = OLStringType.TCaseSensitivity;
  const
    csCaseSensitive = OLStringType.csCaseSensitive;
    csCaseInsensitive = OLStringType.csCaseInsensitive;
    NULL_FORMAT = OLTypesToEdits.NULL_FORMAT;

function OLType(b: System.Boolean): OLBoolean; overload;
function OLType(c: System.Currency): OLCurrency; overload;
function OLType(d: System.TDateTime): OLDateTime; overload;
function OLType(d: System.TDate): OLDate; overload;
function OLType(d: System.Double): OLDouble; overload;
function OLType(d: System.Extended): OLDouble; overload;
function OLType(i: System.Integer): OLInteger; overload;
function OLType(i: System.Int64): OLInt64; overload;
function OLType(s: System.string): OLString; overload;

const
  // today, yesterday, tomorrow
  ssTD = SmartToDate.ssTD;
  ssTM = SmartToDate.ssTM;
  ssYD = SmartToDate.ssYD;

  // Start/End of the Month/Year
  ssSY = SmartToDate.ssSY;
  ssEY = SmartToDate.ssEY;
  ssSM = SmartToDate.ssSM;
  ssEM = SmartToDate.ssEM;

  // Start/End of the Next Month/Year
  ssSNY = SmartToDate.ssSNY;
  ssENY = SmartToDate.ssENY;
  ssSNM = SmartToDate.ssSNM;
  ssENM = SmartToDate.ssENM;

  // Start/End of the Prior Month/Year
  ssSPY = SmartToDate.ssSPY;
  ssEPY = SmartToDate.ssEPY;
  ssSPM = SmartToDate.ssSPM;
  ssEPM = SmartToDate.ssEPM;

   EmptyChar: Char = #0;

   END_OF_THE_STRING = OLStringtype.END_OF_THE_STRING;

type
  // Helper for Integer type - provides OLInteger methods without null handling
  {$IF CompilerVersion >= 24.0}
  TOLIntegerHelper = record  helper for Integer
   public
    // Predicates
    /// <summary>
    ///   Checks if the integer is divisible by the specified value.
    /// </summary>
    function IsDividableBy(const i: Integer): Boolean;
    /// <summary>
    ///   Checks if the integer is an odd number.
    /// </summary>
    function IsOdd(): Boolean;
    /// <summary>
    ///   Checks if the integer is an even number.
    /// </summary>
    function IsEven(): Boolean;
    /// <summary>
    ///   Checks if the integer is positive (> 0).
    /// </summary>
    function IsPositive(): Boolean;
    /// <summary>
    ///   Checks if the integer is negative (< 0).
    /// </summary>
    function IsNegative(): Boolean;
    /// <summary>
    ///   Checks if the integer is non-negative (>= 0).
    /// </summary>
    function IsNonNegative(): Boolean;
    /// <summary>
    ///   Checks if the integer is a prime number.
    /// </summary>
    function IsPrime(): Boolean;

    // Mathematical operations
    /// <summary>
    ///   Returns the square of the integer.
    /// </summary>
    function Sqr(): Integer;
    /// <summary>
    ///   Returns the integer raised to the specified power.
    /// </summary>
    function Power(const Exponent: LongWord): Integer; overload;
    /// <summary>
    ///   Returns the integer raised to the specified power as a double.
    /// </summary>
    function Power(const Exponent: Integer): Double; overload;
    /// <summary>
    ///   Returns the absolute value of the integer.
    /// </summary>
    function Abs(): Integer;
    /// <summary>
    ///   Returns the larger of the integer and the specified value.
    /// </summary>
    function Max(const i: Integer): Integer;
    /// <summary>
    ///   Returns the smaller of the integer and the specified value.
    /// </summary>
    function Min(const i: Integer): Integer;
    /// <summary>
    ///   Rounds the integer to the specified number of digits.
    /// </summary>
    function Round(const Digits: Integer): Integer;

    // Range operations
    /// <summary>
    ///   Checks if the integer is between the specified bounds (inclusive).
    /// </summary>
    function Between(const BottomIncluded, TopIncluded: Integer): Boolean;
    /// <summary>
    ///   Returns the integer increased by the specified amount.
    /// </summary>
    function Increased(const IncreasedBy: Integer = 1): Integer;
    /// <summary>
    ///   Returns the integer decreased by the specified amount.
    /// </summary>
    function Decreased(const DecreasedBy: Integer = 1): Integer;
    /// <summary>
    ///   Replaces the integer with ToValue if it equals FromValue.
    /// </summary>
    function Replaced(const FromValue: Integer; const ToValue: Integer): Integer;

    // String conversion
    /// <summary>
    ///   Converts the integer to a string representation.
    /// </summary>
    function ToString(): string; overload;
    /// <summary>
    ///   Converts the integer to a SQL-compatible string representation.
    /// </summary>
    function ToSQLString(): string;
    /// <summary>
    ///   Converts the integer to a string in the specified numeral system.
    /// </summary>
    function ToNumeralSystem(const Base: Integer): string;

    // Number system properties
    /// <summary>
    ///   Returns the binary representation of the integer.
    /// </summary>
    function GetBinary: string;
    /// <summary>
    ///   Returns the octal representation of the integer.
    /// </summary>
    function GetOctal: string;
    /// <summary>
    ///   Returns the hexadecimal representation of the integer.
    /// </summary>
    function GetHexidecimal: string;
    /// <summary>
    ///   Returns the base-32 numeral system representation of the integer.
    /// </summary>
    function GetNumeralSystem32: string;
    /// <summary>
    ///   Returns the base-64 numeral system representation of the integer.
    /// </summary>
    function GetNumeralSystem64: string;
    /// <summary>
    ///   Sets the integer from a binary string.
    /// </summary>
    procedure SetBinary(const Value: string);
    /// <summary>
    ///   Sets the integer from an octal string.
    /// </summary>
    procedure SetOctal(const Value: string);
    /// <summary>
    ///   Sets the integer from a hexadecimal string.
    /// </summary>
    procedure SetHexidecimal(const Value: string);
    /// <summary>
    ///   Sets the integer from a base-32 numeral system string.
    /// </summary>
    procedure SetNumeralSystem32(const Value: string);
    /// <summary>
    ///   Sets the integer from a base-64 numeral system string.
    /// </summary>
    procedure SetNumeralSystem64(const Value: string);

    /// <summary>
    ///   Gets or sets the binary representation of the integer.
    /// </summary>
    property Binary: string read GetBinary write SetBinary;
    /// <summary>
    ///   Gets or sets the octal representation of the integer.
    /// </summary>
    property Octal: string read GetOctal write SetOctal;
    /// <summary>
    ///   Gets or sets the hexadecimal representation of the integer.
    /// </summary>
    property Hexidecimal: string read GetHexidecimal write SetHexidecimal;
    /// <summary>
    ///   Gets or sets the base-32 numeral system representation of the integer.
    /// </summary>
    property NumeralSystem32: string read GetNumeralSystem32 write SetNumeralSystem32;
    /// <summary>
    ///   Gets or sets the base-64 numeral system representation of the integer.
    /// </summary>
    property NumeralSystem64: string read GetNumeralSystem64 write SetNumeralSystem64;

    // Loop utility
    /// <summary>
    ///   Executes a procedure for each value in the specified range.
    /// </summary>
    procedure ForLoop(const InitialValue: Integer; const ToValue: Integer; const Proc: TProc);

    // Random generation
    /// <summary>
    ///   Returns a random integer between the specified minimum and maximum values.
    /// </summary>
    class function Random(const MinValue: Integer; const MaxValue: Integer): Integer; overload; static;
    /// <summary>
    ///   Returns a random prime integer between the specified minimum and maximum values.
    /// </summary>
    class function RandomPrime(const MinValue: Integer; const MaxValue: Integer): Integer; overload; static;
    /// <summary>
    ///   Returns a random integer up to the specified maximum value.
    /// </summary>
    class function Random(const MaxValue: Integer = MaxInt): Integer; overload; static;
    /// <summary>
    ///   Returns a random prime integer up to the specified maximum value.
    /// </summary>
    class function RandomPrime(const MaxValue: Integer = MaxInt): Integer; overload; static;
    /// <summary>
    ///   Sets the integer to a random value between the specified minimum and maximum values.
    /// </summary>
    procedure SetRandom(const MinValue: Integer; const MaxValue: Integer); overload;
    /// <summary>
    ///   Sets the integer to a random value up to the specified maximum value.
    /// </summary>
    procedure SetRandom(const MaxValue: Integer = MaxInt); overload;
    /// <summary>
    ///   Sets the integer to a random prime value between the specified minimum and maximum values.
    /// </summary>
    procedure SetRandomPrime(const MinValue: Integer; const MaxValue: Integer); overload;
    /// <summary>
    ///   Sets the integer to a random prime value up to the specified maximum value.
    /// </summary>
    procedure SetRandomPrime(const MaxValue: Integer = MaxInt); overload;

    const
      MaxValue = 2147483647;
      MinValue = -2147483648;

    /// <summary>
    ///   Converts the integer to a boolean value.
    /// </summary>
    function ToBoolean: Boolean; inline;
    /// <summary>
    ///   Converts the integer to a hexadecimal string.
    /// </summary>
    function ToHexString: string; overload; inline;
    /// <summary>
    ///   Converts the integer to a hexadecimal string with the specified minimum digits.
    /// </summary>
    function ToHexString(const MinDigits: Integer): string; overload; inline;
    /// <summary>
    ///   Converts the integer to a single-precision floating-point value.
    /// </summary>
    function ToSingle: Single; inline;
    /// <summary>
    ///   Converts the integer to a double-precision floating-point value.
    /// </summary>
    function ToDouble: Double; inline;
    /// <summary>
    ///   Converts the integer to an extended-precision floating-point value.
    /// </summary>
    function ToExtended: Extended; inline;

    /// <summary>
    ///   Returns the size of the Integer type in bytes.
    /// </summary>
    class function Size: Integer; static; inline;
    /// <summary>
    ///   Converts the specified integer value to a string.
    /// </summary>
    class function ToString(const Value: Integer): string; overload; static; inline;
    /// <summary>
    ///   Parses the string and returns the integer value.
    /// </summary>
    class function Parse(const S: string): Integer; static;
    /// <summary>
    ///   Tries to parse the string and returns true if successful.
    /// </summary>
    class function TryParse(const S: string; out Value: Integer): Boolean; static;
        inline;

   end;
  {$IFEND}

  {$IF CompilerVersion >= 24.0}
  TOLBooleanHelper = record helper for Boolean
   public
    /// <summary>
    ///   Converts the boolean to a SQL-safe string representation.
    /// </summary>
    function ToSQLString(): string;
    /// <summary>
    ///   Returns ATrue if the boolean is true, otherwise returns AFalse.
    /// </summary>
    function IfThen(const ATrue: string; const AFalse: string = ''): string; overload;
    /// <summary>
    ///   Returns ATrue if the boolean is true, otherwise returns AFalse.
    /// </summary>
    function IfThen(const ATrue: Integer; const AFalse: Integer): Integer; overload;
    /// <summary>
    ///   Returns ATrue if the boolean is true, otherwise returns AFalse.
    /// </summary>
    function IfThen(const ATrue: Currency; const AFalse: Currency): Currency; overload;
    /// <summary>
    ///   Returns ATrue if the boolean is true, otherwise returns AFalse.
    /// </summary>
    function IfThen(const ATrue: Extended; const AFalse: Extended): Extended; overload;
    /// <summary>
    ///   Returns ATrue if the boolean is true, otherwise returns AFalse.
    /// </summary>
    function IfThen(const ATrue: TDateTime; const AFalse: TDateTime): TDateTime; overload;
    /// <summary>
    ///   Returns ATrue if the boolean is true, otherwise returns AFalse.
    /// </summary>
    function IfThen(const ATrue: Boolean; const AFalse: Boolean): Boolean; overload;

    /// <summary>
    ///   Converts the boolean to an integer value (0 or 1).
    /// </summary>
    function ToInteger: Integer; inline;
    /// <summary>
    ///   Converts the boolean to a string representation.
    /// </summary>
    function ToString(UseBoolStrs: TUseBoolStrs = TUseBoolStrs.False): string;
        overload; inline;
    /// <summary>
    ///   Returns the size of the Boolean type in bytes.
    /// </summary>
    class function Size: Integer; static; inline;
    /// <summary>
    ///   Converts the specified boolean value to a string.
    /// </summary>
    class function ToString(const Value: Boolean; UseBoolStrs: TUseBoolStrs =
        TUseBoolStrs.False): string; overload; static; inline;
    /// <summary>
    ///   Parses the string and returns the boolean value.
    /// </summary>
    class function Parse(const S: string): Boolean; static; inline;
    /// <summary>
    ///   Tries to parse the string and returns true if successful.
    /// </summary>
    class function TryToParse(const S: string; out Value: Boolean): Boolean;
        static; inline;
  end;
  {$IFEND}

  {$IF CompilerVersion >= 24.0}
  TOLDoubleHelper = record helper for Double
   private
    function GetBytes(Index: Cardinal): UInt8;
    function GetExp: UInt64;
    function GetFrac: UInt64;
    function GetSign: Boolean;
    function GetWords(Index: Cardinal): UInt16;
    procedure SetBytes(Index: Cardinal; const Value: UInt8);
    procedure SetExp(const Value: UInt64);
    procedure SetFrac(const Value: UInt64);
    procedure SetSign(const Value: Boolean);
    procedure SetWords(Index: Cardinal; const Value: UInt16);
   public
    /// <summary>
    ///   Returns the square of the double.
    /// </summary>
    function Sqr(): Double;
    /// <summary>
    ///   Returns the square root of the double.
    /// </summary>
    function Sqrt(): Double;
    /// <summary>
    ///   Returns the double raised to the specified exponent.
    /// </summary>
    function Power(const Exponent: Integer): Double; overload;
    /// <summary>
    ///   Returns the double raised to the specified exponent.
    /// </summary>
    function Power(const Exponent: Extended): Double; overload;
    /// <summary>
    ///   Checks if the double is positive (> 0).
    /// </summary>
    function IsPositive(): Boolean;
    /// <summary>
    ///   Checks if the double is negative (< 0).
    /// </summary>
    function IsNegative(): Boolean;
    /// <summary>
    ///   Checks if the double is non-negative (>= 0).
    /// </summary>
    function IsNonNegative(): Boolean;
    /// <summary>
    ///   Returns the larger of the two doubles.
    /// </summary>
    function Max(const d: Double): Double;
    /// <summary>
    ///   Returns the smaller of the two doubles.
    /// </summary>
    function Min(const d: Double): Double;
    /// <summary>
    ///   Returns the absolute value of the double.
    /// </summary>
    function Abs(): Double;
    /// <summary>
    ///   Converts the double to a string representation.
    /// </summary>
    function ToString(): string; overload;
    /// <summary>
    ///   Converts the double to a formatted string representation.
    /// </summary>
    function ToString(const Digits: Integer; const Format: TFloatFormat = ffFixed; const Precision: Integer = 16): string; overload;
    /// <summary>
    ///   Converts the double to a string with custom separators.
    /// </summary>
    function ToString(ThousandSeparator: Char; DecimalSeparator: Char = '.'; Format: string = '###,###,###,##0.##'): string; overload;
    /// <summary>
    ///   Converts the double to a SQL-compatible string representation.
    /// </summary>
    function ToSQLString(): string;
    /// <summary>
    ///   Rounds the double to the specified power of ten.
    /// </summary>
    function Round(const PowerOfTen: Integer): Double; overload;
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
    function SimpleRoundTo(const PowerOfTen: Integer = -2): Double;
    /// <summary>
    ///   Checks if the double is NaN (Not a Number).
    /// </summary>
    function IsNan(): Boolean; overload;
    /// <summary>
    ///   Checks if the double is infinite.
    /// </summary>
    function IsInfinite(): Boolean; overload;
    /// <summary>
    ///   Checks if the double is zero within the specified epsilon.
    /// </summary>
    function IsZero(const Epsilon: Extended = 0): Boolean;
    /// <summary>
    ///   Checks if the double is within the specified range.
    /// </summary>
    function InRange(const AMin, AMax: Extended): Boolean;
    /// <summary>
    ///   Ensures the double is within the specified range.
    /// </summary>
    function EnsureRange(const AMin, AMax: Extended): Extended;
    /// <summary>
    ///   Checks if the double is equal to another within the specified epsilon.
    /// </summary>
    function SameValue(const B: Extended; const Epsilon: Extended = 0): Boolean;
    /// <summary>
    ///   Generates a random double between MinValue and MaxValue.
    /// </summary>
    class function Random(const MinValue: Double; const MaxValue: Double): Double; overload; static;
    /// <summary>
    ///   Generates a random double up to MaxValue.
    /// </summary>
    class function Random(const MaxValue: Double = MaxInt): Double; overload; static;

    const
      Epsilon:Double = 4.9406564584124654418e-324;
      MaxValue:Double =  1.7976931348623157081e+308;
      MinValue:Double = -1.7976931348623157081e+308;
      PositiveInfinity:Double =  1.0 / 0.0;
      NegativeInfinity:Double = -1.0 / 0.0;
      NaN:Double = 0.0 / 0.0;

    /// <summary>
    ///   Returns the exponent of the floating-point representation.
    /// </summary>
    function Exponent: Integer;
    /// <summary>
    ///   Returns the fractional part of the floating-point number.
    /// </summary>
    function Fraction: Extended;
    /// <summary>
    ///   Returns the mantissa (significand) of the floating-point representation.
    /// </summary>
    function Mantissa: UInt64;

    /// <summary>
    ///   Gets or sets the sign bit of the floating-point number.
    /// </summary>
    property Sign: Boolean read GetSign write SetSign;
    /// <summary>
    ///   Gets or sets the exponent bits of the floating-point number.
    /// </summary>
    property Exp: UInt64 read GetExp write SetExp;
    /// <summary>
    ///   Gets or sets the fraction bits of the floating-point number.
    /// </summary>
    property Frac: UInt64 read GetFrac write SetFrac;

    /// <summary>
    ///   Returns the special type classification of the floating-point number.
    /// </summary>
    function SpecialType: TFloatSpecial;
    /// <summary>
    ///   Builds a floating-point number from its components.
    /// </summary>
    procedure BuildUp(const SignFlag: Boolean; const Mantissa: UInt64; const Exponent: Integer);
    /// <summary>
    ///   Converts the double to a string using the specified format settings.
    /// </summary>
    function ToString(const AFormatSettings: TFormatSettings): string; overload; inline;
    /// <summary>
    ///   Converts the double to a formatted string with the specified format, precision, and digits.
    /// </summary>
    function ToString(const Format: TFloatFormat; const Precision, Digits:
        Integer): string; overload; inline;
    /// <summary>
    ///   Converts the double to a formatted string with the specified format settings.
    /// </summary>
    function ToString(const Format: TFloatFormat; const Precision, Digits: Integer;
                         const AFormatSettings: TFormatSettings): string; overload; inline;
    /// <summary>
    ///   Checks if the double is positive or negative infinity.
    /// </summary>
    function IsInfinity: Boolean; overload; inline;
    /// <summary>
    ///   Checks if the double is negative infinity.
    /// </summary>
    function IsNegativeInfinity: Boolean; overload; inline;
    /// <summary>
    ///   Checks if the double is positive infinity.
    /// </summary>
    function IsPositiveInfinity: Boolean; overload; inline;

    /// <summary>
    ///   Gets or sets the bytes of the floating-point representation.
    /// </summary>
    property Bytes[Index: Cardinal]: UInt8 read GetBytes write SetBytes;  // 0..7
    property Words[Index: Cardinal]: UInt16 read GetWords write SetWords; // 0..3

    /// <summary>
    ///   Converts the specified double value to a string.
    /// </summary>
    class function ToString(const Value: Double): string; overload; inline; static;
    /// <summary>
    ///   Converts the specified double value to a string using the specified format settings.
    /// </summary>
    class function ToString(const Value: Double; const AFormatSettings: TFormatSettings): string; overload; inline; static;
    /// <summary>
    ///   Converts the specified double value to a formatted string.
    /// </summary>
    class function ToString(const Value: Double; const Format: TFloatFormat; const Precision, Digits: Integer): string; overload; inline; static;
    /// <summary>
    ///   Converts the specified double value to a formatted string using the specified format settings.
    /// </summary>
    class function ToString(const Value: Double; const Format: TFloatFormat; const Precision, Digits: Integer;
                               const AFormatSettings: TFormatSettings): string; overload; inline; static;
    /// <summary>
    ///   Parses the string and returns the double value using the specified format settings.
    /// </summary>
    class function Parse(const S: string; const AFormatSettings: TFormatSettings): Double; overload; static;
    /// <summary>
    ///   Parses the string and returns the double value.
    /// </summary>
    class function Parse(const S: string): Double; overload; inline; static;
    /// <summary>
    ///   Tries to parse the string and returns true if successful, using the specified format settings.
    /// </summary>
    class function TryParse(const S: string; out Value: Double; const AFormatSettings: TFormatSettings): Boolean; overload;
      {$IFNDEF EXTENDEDHAS10BYTES}inline;{$ENDIF}static;
    /// <summary>
    ///   Tries to parse the string and returns true if successful.
    /// </summary>
    class function TryParse(const S: string; out Value: Double): Boolean; overload; inline; static;
    /// <summary>
    ///   Checks if the specified double value is NaN.
    /// </summary>
    class function IsNan(const Value: Double): Boolean; overload; inline; static;
    /// <summary>
    ///   Checks if the specified double value is positive or negative infinity.
    /// </summary>
    class function IsInfinity(const Value: Double): Boolean; overload; inline; static;
    /// <summary>
    ///   Checks if the specified double value is negative infinity.
    /// </summary>
    class function IsNegativeInfinity(const Value: Double): Boolean; overload; inline; static;
    /// <summary>
    ///   Checks if the specified double value is positive infinity.
    /// </summary>
    class function IsPositiveInfinity(const Value: Double): Boolean; overload; inline; static;
    /// <summary>
    ///   Returns the size of the Double type in bytes.
    /// </summary>
    class function Size: Integer; inline; static;

  end;
  {$IFEND}

  {$IF CompilerVersion >= 24.0}
  TOLCurrencyHelper = record helper for Currency
   public
    /// <summary>
    ///   Returns the square of the currency.
    /// </summary>
    function Sqr(): Currency;
    /// <summary>
    ///   Returns the currency raised to the specified exponent.
    /// </summary>
    function Power(const Exponent: Integer): Currency;
    /// <summary>
    ///   Checks if the currency is positive (> 0).
    /// </summary>
    function IsPositive(): Boolean;
    /// <summary>
    ///   Checks if the currency is negative (< 0).
    /// </summary>
    function IsNegative(): Boolean;
    /// <summary>
    ///   Checks if the currency is non-negative (>= 0).
    /// </summary>
    function IsNonNegative(): Boolean;
    /// <summary>
    ///   Checks if the currency is between the specified values (inclusive).
    /// </summary>
    function Between(const BottomIncluded, TopIncluded: Currency): Boolean;
    /// <summary>
    ///   Returns the larger of the two currencies.
    /// </summary>
    function Max(const c: Currency): Currency;
    /// <summary>
    ///   Returns the smaller of the two currencies.
    /// </summary>
    function Min(const c: Currency): Currency;
    /// <summary>
    ///   Returns the absolute value of the currency.
    /// </summary>
    function Abs(): Currency;
    /// <summary>
    ///   Converts the currency to a string representation.
    /// </summary>
    function ToString(): string; overload;
    /// <summary>
    ///   Converts the currency to a string with custom separators.
    /// </summary>
    function ToString(ThousandSeparator: Char; DecimalSeparator: Char = '.'; Format: string = '###,###,###,##0.##'): string; overload;
    /// <summary>
    ///   Converts the currency to a SQL-compatible string representation.
    /// </summary>
    function ToSQLString(): string;
    /// <summary>
    ///   Converts the currency to a formatted string.
    /// </summary>
    function ToStrF(Format: TFloatFormat; Digits: Integer): string;
    /// <summary>
    ///   Rounds the currency to the nearest integer.
    /// </summary>
    function Round(): Integer; overload;
    /// <summary>
    ///   Rounds the currency to the specified power of ten.
    /// </summary>
    function Round(const PowerOfTen: Integer): Currency; overload;
    /// <summary>
    ///   Returns the smallest integer greater than or equal to the currency.
    /// </summary>
    function Ceil(): Integer;
    /// <summary>
    ///   Returns the largest integer less than or equal to the currency.
    /// </summary>
    function Floor(): Integer;
    /// <summary>
    ///   Rounds the currency using symmetric arithmetic rounding to the specified power of ten.
    ///   Unlike Round, SimpleRoundTo always rounds 0.5 away from zero.
    /// </summary>
    function SimpleRoundTo(const PowerOfTen: Integer = -2): Currency;

    const
       MaxValue: Currency =  922337203685477.5807;
       MinValue: Currency = -922337203685477.5807;

    /// <summary>
    ///   Converts the currency to a string using the specified format settings.
    /// </summary>
    function ToString(const AFormatSettings: TFormatSettings): string; overload;
        inline;

    /// <summary>
    ///   Returns the fractional part of the currency value.
    /// </summary>
    function Frac: Currency; inline;
    /// <summary>
    ///   Returns the integer part of the currency value.
    /// </summary>
    function Trunc: Int64; inline;

    /// <summary>
    ///   Returns the size of the Currency type in bytes.
    /// </summary>
    class function Size: Integer; static; inline;
    /// <summary>
    ///   Converts the specified currency value to a string using the specified format settings.
    /// </summary>
    class function ToString(const Value: Currency; const AFormatSettings:
        TFormatSettings): string; overload; static; inline;
    /// <summary>
    ///   Converts the specified currency value to a string.
    /// </summary>
    class function ToString(const Value: Currency): string; overload; static;
        inline;
    /// <summary>
    ///   Parses the string and returns the currency value using the specified format settings.
    /// </summary>
    class function Parse(const S: string; const AFormatSettings: TFormatSettings):
        Currency; overload; static;
    /// <summary>
    ///   Parses the string and returns the currency value.
    /// </summary>
    class function Parse(const S: string): Currency; overload; static; inline;
    /// <summary>
    ///   Tries to parse the string and returns true if successful, using the specified format settings.
    /// </summary>
    class function TryParse(const S: string; out Value: Currency; const
        AFormatSettings: TFormatSettings): Boolean; overload; static; inline;
    /// <summary>
    ///   Tries to parse the string and returns true if successful.
    /// </summary>
    class function TryParse(const S: string; out Value: Currency): Boolean;
        overload; static; inline;
  end;
  {$IFEND}

  {$IF CompilerVersion >= 24.0}
  TOLDateTimeHelper = record helper for TDateTime
  private
    function GetYear: Integer;
    function GetMonth: Integer;
    function GetDay: Integer;
    function GetHour: Integer;
    function GetMinute: Integer;
    function GetSecond: Integer;
    function GetMilliSecond: Integer;
    procedure SetYear(const Value: Integer);
    procedure SetMonth(const Value: Integer);
    procedure SetDay(const Value: Integer);
    procedure SetHour(const Value: Integer);
    procedure SetMinute(const Value: Integer);
    procedure SetSecond(const Value: Integer);
     procedure SetMilliSecond(const Value: Integer);
   public
     /// <summary>
     ///   Gets or sets the year component of the date/time.
     /// </summary>
     property Year: Integer read GetYear write SetYear;
     /// <summary>
     ///   Gets or sets the month component of the date/time.
     /// </summary>
     property Month: Integer read GetMonth write SetMonth;
     /// <summary>
     ///   Gets or sets the day component of the date/time.
     /// </summary>
     property Day: Integer read GetDay write SetDay;
    /// <summary>
    ///   Gets or sets the hour component of the date/time.
    /// </summary>
    property Hour: Integer read GetHour write SetHour;
    /// <summary>
    ///   Gets or sets the minute component of the date/time.
    /// </summary>
    property Minute: Integer read GetMinute write SetMinute;
    /// <summary>
    ///   Gets or sets the second component of the date/time.
    /// </summary>
    property Second: Integer read GetSecond write SetSecond;
    /// <summary>
    ///   Gets or sets the millisecond component of the date/time.
    /// </summary>
    property MilliSecond: Integer read GetMilliSecond write SetMilliSecond;

    /// <summary>
    ///   Converts the date/time to a string representation.
    /// </summary>
    function ToString(): string; overload;
    /// <summary>
    ///   Converts the date/time to a formatted string representation.
    /// </summary>
     function ToString(const Format: string): string; overload;
     /// <summary>
     ///   Converts the date/time to a SQL-compatible string representation.
     /// </summary>
     function ToSQLString(): string;

    /// <summary>
    ///   Returns the date part of the date/time.
    /// </summary>
    function DateOf(): TDateTime;
    /// <summary>
    ///   Returns the time part of the date/time.
    /// </summary>
    function TimeOf(): TDateTime;

    /// <summary>
    ///   Checks if the year of the date/time is a leap year.
    /// </summary>
    function IsInLeapYear(): Boolean;
    /// <summary>
    ///   Checks if the time is in PM.
    /// </summary>
    function IsPM(): Boolean;
    /// <summary>
    ///   Checks if the time is in AM.
    /// </summary>
    function IsAM(): Boolean;
    /// <summary>
    ///   Returns the number of weeks in the year of the date/time.
    /// </summary>
     function WeeksInYear(): Integer;
     /// <summary>
     ///   Returns the number of days in the year of the date/time.
     /// </summary>
     function DaysInYear(): Integer;
     /// <summary>
     ///   Returns the number of days in the month of the date/time.
     /// </summary>
     function DaysInMonth(): Integer;

    /// <summary>
    ///   Returns the current date.
    /// </summary>
    class function Today: TDateTime; static;
    /// <summary>
    ///   Returns yesterday's date.
    /// </summary>
    class function Yesterday: TDateTime; static;
    /// <summary>
    ///   Returns tomorrow's date.
    /// </summary>
    class function Tomorrow: TDateTime; static;
    /// <summary>
    ///   Returns the current date and time.
    /// </summary>
    class function Now(): TDateTime; static;

    /// <summary>
    ///   Sets the date/time to the current date and time.
    /// </summary>
    procedure SetNow();
    /// <summary>
    ///   Sets the date/time to today's date.
    /// </summary>
    procedure SetToday();
    /// <summary>
    ///   Sets the date/time to tomorrow's date.
    /// </summary>
    procedure SetTomorrow();
    /// <summary>
    ///   Sets the date/time to yesterday's date.
    /// </summary>
     procedure SetYesterday();

     /// <summary>
     ///   Checks if the date/time represents today's date.
     /// </summary>
     function IsToday(): Boolean;
    /// <summary>
    ///   Checks if the date/time is the same day as the specified date/time.
    /// </summary>
    function SameDay(const DateTimeToCompare: TDateTime): Boolean;

    /// <summary>
    ///   Returns the start of the year for the date/time.
    /// </summary>
    function StartOfTheYear(): TDateTime;
    /// <summary>
    ///   Returns the end of the year for the date/time.
    /// </summary>
    function EndOfTheYear(): TDateTime;
    /// <summary>
    ///   Returns the start of the specified year.
    /// </summary>
    class function StartOfAYear(const AYear: Word): TDateTime; static;
    /// <summary>
    ///   Returns the end of the specified year.
    /// </summary>
    class function EndOfAYear(const AYear: Word): TDateTime; static;
    /// <summary>
    ///   Sets the date/time to the start of the specified year.
    /// </summary>
    procedure SetStartOfAYear(const AYear: Word);
    /// <summary>
    ///   Sets the date/time to the end of the specified year.
    /// </summary>
    procedure SetEndOfAYear(const AYear: Word);

    /// <summary>
    ///   Returns the start of the month for the date/time.
    /// </summary>
    function StartOfTheMonth(): TDateTime;
    /// <summary>
    ///   Returns the end of the month for the date/time.
    /// </summary>
    function EndOfTheMonth(): TDateTime;
    /// <summary>
    ///   Returns the start of the specified month and year.
    /// </summary>
    class function StartOfAMonth(const AYear, AMonth: Word): TDateTime; static;
    /// <summary>
    ///   Returns the end of the specified month and year.
    /// </summary>
    class function EndOfAMonth(const AYear, AMonth: Word): TDateTime; static;
    /// <summary>
    ///   Sets the date/time to the start of the specified month and year.
    /// </summary>
    procedure SetStartOfAMonth(const AYear, AMonth: Word);
    /// <summary>
    ///   Sets the date/time to the end of the specified month and year.
    /// </summary>
    procedure SetEndOfAMonth(const AYear, AMonth: Word);

    /// <summary>
    ///   Returns the start of the week for the date/time.
    /// </summary>
    function StartOfTheWeek(): TDateTime;
    /// <summary>
    ///   Returns the end of the week for the date/time.
    /// </summary>
    function EndOfTheWeek(): TDateTime;

    /// <summary>
    ///   Returns the start of the day for the date/time.
    /// </summary>
    function StartOfTheDay(): TDateTime;
    /// <summary>
    ///   Returns the end of the day for the date/time.
    /// </summary>
    function EndOfTheDay(): TDateTime;

    /// <summary>
    ///   Returns the day of the year for the date/time.
    /// </summary>
    function DayOfTheYear(): Integer;
    /// <summary>
    ///   Returns the hour of the year for the date/time.
    /// </summary>
    function HourOfTheYear(): Integer;
    /// <summary>
    ///   Returns the minute of the year for the date/time.
    /// </summary>
    function MinuteOfTheYear(): LongWord;
    /// <summary>
    ///   Returns the second of the year for the date/time.
    /// </summary>
    function SecondOfTheYear(): LongWord;
    /// <summary>
    ///   Returns the millisecond of the year for the date/time.
    /// </summary>
    function MilliSecondOfTheYear(): Int64;

    /// <summary>
    ///   Returns the hour of the month for the date/time.
    /// </summary>
    function HourOfTheMonth(): Integer;
    /// <summary>
    ///   Returns the minute of the month for the date/time.
    /// </summary>
    function MinuteOfTheMonth(): Integer;
    /// <summary>
    ///   Returns the second of the month for the date/time.
    /// </summary>
    function SecondOfTheMonth(): LongWord;
    /// <summary>
    ///   Returns the millisecond of the month for the date/time.
    /// </summary>
    function MilliSecondOfTheMonth(): LongWord;

    /// <summary>
    ///   Returns the day of the week for the date/time.
    /// </summary>
    function DayOfTheWeek(): Integer;
    /// <summary>
    ///   Returns the hour of the week for the date/time.
    /// </summary>
    function HourOfTheWeek(): Integer;
    /// <summary>
    ///   Returns the minute of the week for the date/time.
    /// </summary>
    function MinuteOfTheWeek(): Integer;
    /// <summary>
    ///   Returns the second of the week for the date/time.
    /// </summary>
    function SecondOfTheWeek(): LongWord;
    /// <summary>
    ///   Returns the millisecond of the week for the date/time.
    /// </summary>
    function MilliSecondOfTheWeek(): LongWord;

    /// <summary>
    ///   Returns the minute of the day for the date/time.
    /// </summary>
    function MinuteOfTheDay(): Integer;
    /// <summary>
    ///   Returns the second of the day for the date/time.
    /// </summary>
    function SecondOfTheDay(): LongWord;
    /// <summary>
    ///   Returns the millisecond of the day for the date/time.
    /// </summary>
    function MilliSecondOfTheDay(): LongWord;

    /// <summary>
    ///   Returns the second of the hour for the date/time.
    /// </summary>
    function SecondOfTheHour(): Integer;
    /// <summary>
    ///   Returns the millisecond of the hour for the date/time.
    /// </summary>
    function MilliSecondOfTheHour(): LongWord;

    /// <summary>
    ///   Returns the millisecond of the minute for the date/time.
    /// </summary>
    function MilliSecondOfTheMinute(): LongWord;

    /// <summary>
    ///   Returns the total number of seconds from the starting year to the date/time.
    /// </summary>
    class function SecondCount(const StartingYear: Integer = 2017): Integer; static;
    /// <summary>
    ///   Returns the date/time from the total number of seconds since the starting year.
    /// </summary>
    class function DateTimeFromSecondCount(const Count: Integer; const StartingYear: Integer = 2017): TDateTime; static;
    /// <summary>
    ///   Sets the date/time from the total number of seconds since the starting year.
    /// </summary>
    procedure SetFromSecondCount(const Count: Integer; const StartingYear: Integer = 2017);

    /// <summary>
    ///   Returns the number of complete years between the date/time and the specified date/time.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function YearsBetween(const Date: TDateTime): Integer;
    /// <summary>
    ///   Returns the number of complete months between the date/time and the specified date/time.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function MonthsBetween(const Date: TDateTime): Integer;
    /// <summary>
    ///   Returns the number of complete weeks between the date/time and the specified date/time.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function WeeksBetween(const Date: TDateTime): Integer;
    /// <summary>
    ///   Returns the number of complete days between the date/time and the specified date/time.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function DaysBetween(const Date: TDateTime): Integer;
    /// <summary>
    ///   Returns the number of complete hours between the date/time and the specified date/time.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function HoursBetween(const Date: TDateTime): Int64;
    /// <summary>
    ///   Returns the number of complete minutes between the date/time and the specified date/time.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function MinutesBetween(const Date: TDateTime): Int64;
    /// <summary>
    ///   Returns the number of complete seconds between the date/time and the specified date/time.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function SecondsBetween(const Date: TDateTime): Int64;
    /// <summary>
    ///   Returns the number of complete milliseconds between the date/time and the specified date/time.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function MilliSecondsBetween(const Date: TDateTime): Int64;

    /// <summary>
    ///   Returns the number of complete years from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function YearsFrom(const Date: TDateTime): Integer;
    /// <summary>
    ///   Returns the number of complete years from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function YearsTo(const Date: TDateTime): Integer;
    /// <summary>
    ///   Returns the number of complete months from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function MonthsFrom(const Date: TDateTime): Integer;
    /// <summary>
    ///   Returns the number of complete months from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function MonthsTo(const Date: TDateTime): Integer;
    /// <summary>
    ///   Returns the number of complete weeks from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function WeeksFrom(const Date: TDateTime): Integer;
    /// <summary>
    ///   Returns the number of complete weeks from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function WeeksTo(const Date: TDateTime): Integer;
    /// <summary>
    ///   Returns the number of complete days from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function DaysFrom(const Date: TDateTime): Integer;
    /// <summary>
    ///   Returns the number of complete days from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function DaysTo(const Date: TDateTime): Integer;
    /// <summary>
    ///   Returns the number of complete hours from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function HoursFrom(const Date: TDateTime): Int64;
    /// <summary>
    ///   Returns the number of complete hours from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function HoursTo(const Date: TDateTime): Int64;
    /// <summary>
    ///   Returns the number of complete minutes from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function MinutesFrom(const Date: TDateTime): Int64;
    /// <summary>
    ///   Returns the number of complete minutes from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function MinutesTo(const Date: TDateTime): Int64;
    /// <summary>
    ///   Returns the number of complete seconds from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function SecondsFrom(const Date: TDateTime): Int64;
    /// <summary>
    ///   Returns the number of complete seconds from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function SecondsTo(const Date: TDateTime): Int64;
    /// <summary>
    ///   Returns the number of complete milliseconds from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function MilliSecondsFrom(const Date: TDateTime): Int64;
    /// <summary>
    ///   Returns the number of complete milliseconds from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function MilliSecondsTo(const Date: TDateTime): Int64;

    /// <summary>
    ///   Checks if the date/time is within the specified range.
    /// </summary>
    function InRange(const AStartDateTime, AEndDateTime: TDateTime; const aInclusive: Boolean = True): Boolean;
    /// <summary>
    ///   Checks if the date is within the specified date range.
    /// </summary>
    function InDateRange(const AStartDateTime, AEndDateTime: TDate; const aInclusive: Boolean = True): Boolean;

    /// <summary>
    ///   Returns the number of years as a double between the date/time and the specified date/time.
    /// </summary>
    function YearSpan(const Date: TDateTime): Double;
    /// <summary>
    ///   Returns the number of months as a double between the date/time and the specified date/time.
    /// </summary>
    function MonthSpan(const Date: TDateTime): Double;
    /// <summary>
    ///   Returns the number of weeks as a double between the date/time and the specified date/time.
    /// </summary>
    function WeekSpan(const Date: TDateTime): Double;
    /// <summary>
    ///   Returns the number of days as a double between the date/time and the specified date/time.
    /// </summary>
    function DaySpan(const Date: TDateTime): Double;
    /// <summary>
    ///   Returns the number of hours as a double between the date/time and the specified date/time.
    /// </summary>
    function HourSpan(const Date: TDateTime): Double;
    /// <summary>
    ///   Returns the number of minutes as a double between the date/time and the specified date/time.
    /// </summary>
    function MinuteSpan(const Date: TDateTime): Double;
    /// <summary>
    ///   Returns the number of seconds as a double between the date/time and the specified date/time.
    /// </summary>
    function SecondSpan(const Date: TDateTime): Double;
    /// <summary>
    ///   Returns the number of milliseconds as a double between the date/time and the specified date/time.
    /// </summary>
    function MilliSecondSpan(const Date: TDateTime): Double;

    /// <summary>
    ///   Returns the date/time incremented by the specified number of years.
    /// </summary>
    function IncYear(const ANumberOfYears: Integer = 1): TDateTime;
    /// <summary>
    ///   Returns the date/time incremented by the specified number of months.
    /// </summary>
    function IncMonth(const ANumberOfMonths: Integer = 1): TDateTime;
    /// <summary>
    ///   Returns the date/time incremented by the specified number of weeks.
    /// </summary>
    function IncWeek(const ANumberOfWeeks: Integer = 1): TDateTime;
    /// <summary>
    ///   Returns the date/time incremented by the specified number of days.
    /// </summary>
    function IncDay(const ANumberOfDays: Integer = 1): TDateTime;
    /// <summary>
    ///   Returns the date/time incremented by the specified number of hours.
    /// </summary>
    function IncHour(const ANumberOfHours: Int64 = 1): TDateTime;
    /// <summary>
    ///   Returns the date/time incremented by the specified number of minutes.
    /// </summary>
    function IncMinute(const ANumberOfMinutes: Int64 = 1): TDateTime;
    /// <summary>
    ///   Returns the date/time incremented by the specified number of seconds.
    /// </summary>
    function IncSecond(const ANumberOfSeconds: Int64 = 1): TDateTime;
    /// <summary>
    ///   Returns the date/time incremented by the specified number of milliseconds.
    /// </summary>
     function IncMilliSecond(const ANumberOfMilliSeconds: Int64 = 1): TDateTime;

     /// <summary>
     ///   Decodes the date/time into its component parts.
     /// </summary>
     procedure DecodeDateTime(out AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word);
     /// <summary>
     ///   Encodes the date/time from its component parts.
     /// </summary>
     procedure EncodeDateTime(const AYear, AMonth, ADay: Word; const AHour: Word = 0; const AMinute: Word = 0;
       const ASecond: Word = 0; const AMilliSecond: Word = 0);

     /// <summary>
     ///   Returns a new date/time with the year component changed.
     /// </summary>
     function RecodedYear(const AYear: Word): TDateTime;
     /// <summary>
     ///   Returns a new date/time with the month component changed.
     /// </summary>
     function RecodedMonth(const AMonth: Word): TDateTime;
     /// <summary>
     ///   Returns a new date/time with the day component changed.
     /// </summary>
     function RecodedDay(const ADay: Word): TDateTime;
     /// <summary>
     ///   Returns a new date/time with the hour component changed.
     /// </summary>
     function RecodedHour(const AHour: Word): TDateTime;
     /// <summary>
     ///   Returns a new date/time with the minute component changed.
     /// </summary>
     function RecodedMinute(const AMinute: Word): TDateTime;
     /// <summary>
     ///   Returns a new date/time with the second component changed.
     /// </summary>
     function RecodedSecond(const ASecond: Word): TDateTime;
     /// <summary>
     ///   Returns a new date/time with the millisecond component changed.
     /// </summary>
     function RecodedMilliSecond(const AMilliSecond: Word): TDateTime;

     /// <summary>
     ///   Checks if the time part of the date/time is the same as the specified date/time.
     /// </summary>
     function SameTime(const DateTimeToCompare: TDateTime): Boolean;

     /// <summary>
     ///   Returns the long name of the day of the week.
     /// </summary>
     function LongDayName(): string;
     /// <summary>
     ///   Returns the long name of the month.
     /// </summary>
     function LongMonthName(): string;
     /// <summary>
     ///   Returns the short name of the day of the week.
     /// </summary>
     function ShortDayName(): string;
     /// <summary>
     ///   Returns the short name of the month.
     /// </summary>
     function ShortMonthName(): string;

     /// <summary>
     ///   Returns the maximum of the current date/time and the specified date/time.
     /// </summary>
     function Max(const CompareDate: TDateTime): TDateTime;
     /// <summary>
     ///   Returns the minimum of the current date/time and the specified date/time.
     /// </summary>
     function Min(const CompareDate: TDateTime): TDateTime;
  end;

  TOLDateHelper = record helper for TDate
  private
    function GetYear: Integer;
    function GetMonth: Integer;
    function GetDay: Integer;
    procedure SetYear(const Value: Integer);
    procedure SetMonth(const Value: Integer);
    procedure SetDay(const Value: Integer);
   public
     /// <summary>
     ///   Gets or sets the year component of the date.
     /// </summary>
     property Year: Integer read GetYear write SetYear;
     /// <summary>
     ///   Gets or sets the month component of the date.
     /// </summary>
     property Month: Integer read GetMonth write SetMonth;
     /// <summary>
     ///   Gets or sets the day component of the date.
     /// </summary>
     property Day: Integer read GetDay write SetDay;

     /// <summary>
     ///   Converts the date to a string representation.
     /// </summary>
     function ToString(): string; overload;
     /// <summary>
     ///   Converts the date to a formatted string representation.
     /// </summary>
     function ToString(const Format: string): string; overload;
     /// <summary>
     ///   Converts the date/time to a SQL-compatible string representation.
     /// </summary>
      function ToSQLString(): string;

     /// <summary>
     ///   Checks if the year of the date is a leap year.
     /// </summary>
     function IsInLeapYear(): Boolean;
     /// <summary>
     ///   Returns the number of weeks in the year of the date.
     /// </summary>
     function WeeksInYear(): Integer;
     /// <summary>
     ///   Returns the number of days in the year of the date/time.
     /// </summary>
     function DaysInYear(): Integer;
     /// <summary>
     ///   Returns the number of days in the month of the date/time.
     /// </summary>
      function DaysInMonth(): Integer;

     /// <summary>
     ///   Returns the current date.
     /// </summary>
     class function Today: TDate; static;
     /// <summary>
     ///   Returns yesterday's date.
     /// </summary>
     class function Yesterday: TDate; static;
     /// <summary>
     ///   Returns tomorrow's date.
     /// </summary>
     class function Tomorrow: TDate; static;

     /// <summary>
     ///   Sets the date to today's date.
     /// </summary>
     procedure SetToday();
     /// <summary>
     ///   Sets the date to tomorrow's date.
     /// </summary>
     procedure SetTomorrow();
     /// <summary>
     ///   Sets the date to yesterday's date.
     /// </summary>
     procedure SetYesterday();

     /// <summary>
     ///   Checks if the date/time represents today's date.
     /// </summary>
      function IsToday(): Boolean;
     /// <summary>
     ///   Checks if the date is the same day as the specified date.
     /// </summary>
     function SameDay(const DateToCompare: TDate): Boolean;

     /// <summary>
     ///   Returns the start of the year for the date.
     /// </summary>
     function StartOfTheYear(): TDate;
     /// <summary>
     ///   Returns the end of the year for the date.
     /// </summary>
     function EndOfTheYear(): TDate;
     /// <summary>
     ///   Returns the start of the specified year.
     /// </summary>
     class function StartOfAYear(const AYear: Word): TDate; static;
     /// <summary>
     ///   Returns the end of the specified year.
     /// </summary>
     class function EndOfAYear(const AYear: Word): TDate; static;
     /// <summary>
     ///   Sets the date to the start of the specified year.
     /// </summary>
     procedure SetStartOfAYear(const AYear: Word);
     /// <summary>
     ///   Sets the date to the end of the specified year.
     /// </summary>
     procedure SetEndOfAYear(const AYear: Word);

     /// <summary>
     ///   Returns the start of the month for the date.
     /// </summary>
     function StartOfTheMonth(): TDate;
     /// <summary>
     ///   Returns the end of the month for the date.
     /// </summary>
     function EndOfTheMonth(): TDate;
     /// <summary>
     ///   Returns the start of the specified month and year.
     /// </summary>
     class function StartOfAMonth(const AYear, AMonth: Word): TDate; static;
     /// <summary>
     ///   Returns the end of the specified month and year.
     /// </summary>
     class function EndOfAMonth(const AYear, AMonth: Word): TDate; static;
     /// <summary>
     ///   Sets the date to the start of the specified month and year.
     /// </summary>
     procedure SetStartOfAMonth(const AYear, AMonth: Word);
     /// <summary>
     ///   Sets the date to the end of the specified month and year.
     /// </summary>
     procedure SetEndOfAMonth(const AYear, AMonth: Word);

     /// <summary>
     ///   Returns the start of the week for the date.
     /// </summary>
     function StartOfTheWeek(): TDate;
     /// <summary>
     ///   Returns the end of the week for the date.
     /// </summary>
     function EndOfTheWeek(): TDate;

     /// <summary>
     ///   Returns the day of the year for the date.
     /// </summary>
     function DayOfTheYear(): Integer;
     /// <summary>
     ///   Returns the day of the week for the date.
     /// </summary>
     function DayOfTheWeek(): Integer;

     /// <summary>
     ///   Returns the number of complete years between the date and the specified date.
     /// </summary>
     /// <param name="Date">The date to compare with. The result is always a non-negative number.</param>
     function YearsBetween(const Date: TDate): Integer;
     /// <summary>
     ///   Returns the number of complete months between the date and the specified date.
     /// </summary>
     /// <param name="Date">The date to compare with. The result is always a non-negative number.</param>
     function MonthsBetween(const Date: TDate): Integer;
     /// <summary>
     ///   Returns the number of complete weeks between the date and the specified date.
     /// </summary>
     /// <param name="Date">The date to compare with. The result is always a non-negative number.</param>
     function WeeksBetween(const Date: TDate): Integer;
     /// <summary>
     ///   Returns the number of complete days between the date and the specified date.
     /// </summary>
     /// <param name="Date">The date to compare with. The result is always a non-negative number.</param>
     function DaysBetween(const Date: TDate): Integer;

     /// <summary>
     ///   Returns the number of complete years from the specified date to this date.
     /// </summary>
     /// <param name="Date">The date to compare with. Returns negative if Date > Self.</param>
     function YearsFrom(const Date: TDate): Integer;
     /// <summary>
     ///   Returns the number of complete years from this date to the specified date.
     /// </summary>
     /// <param name="Date">The date to compare with. Returns negative if Date < Self.</param>
     function YearsTo(const Date: TDate): Integer;
     /// <summary>
     ///   Returns the number of complete months from the specified date to this date.
     /// </summary>
     /// <param name="Date">The date to compare with. Returns negative if Date > Self.</param>
     function MonthsFrom(const Date: TDate): Integer;
     /// <summary>
     ///   Returns the number of complete months from this date to the specified date.
     /// </summary>
     /// <param name="Date">The date to compare with. Returns negative if Date < Self.</param>
     function MonthsTo(const Date: TDate): Integer;
     /// <summary>
     ///   Returns the number of complete weeks from the specified date to this date.
     /// </summary>
     /// <param name="Date">The date to compare with. Returns negative if Date > Self.</param>
     function WeeksFrom(const Date: TDate): Integer;
     /// <summary>
     ///   Returns the number of complete weeks from this date to the specified date.
     /// </summary>
     /// <param name="Date">The date to compare with. Returns negative if Date < Self.</param>
     function WeeksTo(const Date: TDate): Integer;
     /// <summary>
     ///   Returns the number of complete days from the specified date to this date.
     /// </summary>
     /// <param name="Date">The date to compare with. Returns negative if Date > Self.</param>
     function DaysFrom(const Date: TDate): Integer;
     /// <summary>
     ///   Returns the number of complete days from this date to the specified date.
     /// </summary>
     /// <param name="Date">The date to compare with. Returns negative if Date < Self.</param>
     function DaysTo(const Date: TDate): Integer;

     /// <summary>
     ///   Checks if the date is within the specified date range.
     /// </summary>
     function InRange(const AStartDateTime, AEndDateTime: TDate; const aInclusive: Boolean = True): Boolean;

     /// <summary>
     ///   Returns the number of years as a double between the date and the specified date.
     /// </summary>
     function YearSpan(const Date: TDate): Double;
     /// <summary>
     ///   Returns the number of months as a double between the date and the specified date.
     /// </summary>
     function MonthSpan(const Date: TDate): Double;
     /// <summary>
     ///   Returns the number of weeks as a double between the date and the specified date.
     /// </summary>
     function WeekSpan(const Date: TDate): Double;
     /// <summary>
     ///   Returns the date incremented by the specified number of years.
     /// </summary>
     function IncYear(const ANumberOfYears: Integer = 1): TDate;
     /// <summary>
     ///   Returns the date incremented by the specified number of months.
     /// </summary>
     function IncMonth(const ANumberOfMonths: Integer = 1): TDate;
     /// <summary>
     ///   Returns the date incremented by the specified number of weeks.
     /// </summary>
     function IncWeek(const ANumberOfWeeks: Integer = 1): TDate;
     /// <summary>
     ///   Returns the date incremented by the specified number of days.
     /// </summary>
     function IncDay(const ANumberOfDays: Integer = 1): TDate;

     /// <summary>
     ///   Decodes the date into its component parts.
     /// </summary>
     procedure DecodeDate(out AYear, AMonth, ADay: Word);
     /// <summary>
     ///   Encodes the date from its component parts.
     /// </summary>
     procedure EncodeDate(const AYear, AMonth, ADay: Word);

     /// <summary>
     ///   Returns a new date with the year component changed.
     /// </summary>
     function RecodedYear(const AYear: Word): TDate;
     /// <summary>
     ///   Returns a new date with the month component changed.
     /// </summary>
     function RecodedMonth(const AMonth: Word): TDate;
     /// <summary>
     ///   Returns a new date with the day component changed.
     /// </summary>
     function RecodedDay(const ADay: Word): TDate;

     /// <summary>
     ///   Returns the long name of the day of the week.
     /// </summary>
     function LongDayName(): string;
     /// <summary>
     ///   Returns the long name of the month.
     /// </summary>
     function LongMonthName(): string;
     /// <summary>
     ///   Returns the short name of the day of the week.
     /// </summary>
     function ShortDayName(): string;
     /// <summary>
     ///   Returns the short name of the month.
     /// </summary>
     function ShortMonthName(): string;

     /// <summary>
     ///   Returns the maximum of the current date and the specified date.
     /// </summary>
     function Max(const CompareDate: TDate): TDate;
     /// <summary>
     ///   Returns the minimum of the current date and the specified date.
     /// </summary>
     function Min(const CompareDate: TDate): TDate;

     /// <summary>
     ///   Checks if the specified year, month, and day form a valid date.
     /// </summary>
     class function IsValidDate(const Year, Month, Day: Integer): Boolean; static;
  end;

  TOLInt64Helper = record helper for Int64
   public
     /// <summary>
     ///   Checks if the value is divisible by the specified integer.
     /// </summary>
     function IsDividableBy(i: Int64): Boolean;
     /// <summary>
     ///   Checks if the value is an odd number.
     /// </summary>
     function IsOdd(): Boolean;
     /// <summary>
     ///   Checks if the value is an even number.
     /// </summary>
     function IsEven(): Boolean;
     /// <summary>
     ///   Returns the square of the value.
     /// </summary>
     function Sqr(): Int64;
     /// <summary>
     ///   Returns the value raised to the specified power.
     /// </summary>
     function Power(Exponent: LongWord): Int64; overload;
     /// <summary>
     ///   Returns the value raised to the specified power as a double.
     /// </summary>
     function Power(Exponent: Int64): Double; overload;
     /// <summary>
     ///   Checks if the value is positive.
     /// </summary>
     function IsPositive(): Boolean;
     /// <summary>
     ///   Checks if the value is negative.
     /// </summary>
     function IsNegative(): Boolean;
     /// <summary>
     ///   Checks if the value is non-negative.
     /// </summary>
     function IsNonNegative(): Boolean;
     /// <summary>
     ///   Returns the maximum of the value and the specified integer.
     /// </summary>
     function Max(i: Int64): Int64;
     /// <summary>
     ///   Returns the minimum of the value and the specified integer.
     /// </summary>
     function Min(i: Int64): Int64;
     /// <summary>
     ///   Returns the absolute value of the value.
     /// </summary>
     function Abs(): Int64;
     /// <summary>
     ///   Converts the value to a string representation.
     /// </summary>
     function ToString(): string; overload;
     /// <summary>
     ///   Converts the value to a SQL-compatible string representation.
     /// </summary>
     function ToSQLString(): string;
     /// <summary>
     ///   Rounds the value to the specified number of digits.
     /// </summary>
     function Round(Digits: Int64): Int64;
     /// <summary>
     ///   Checks if the value is between the specified bounds.
     /// </summary>
     function Between(BottomIncluded, TopIncluded: Int64): Boolean;
     /// <summary>
     ///   Returns the value increased by the specified amount.
     /// </summary>
     function Increased(IncreasedBy: Int64 = 1): Int64;
     /// <summary>
     ///   Returns the value decreased by the specified amount.
     /// </summary>
     function Decreased(DecreasedBy: Int64 = 1): Int64;
     /// <summary>
     ///   Replaces the specified value with another value.
     /// </summary>
     function Replaced(FromValue: Int64; ToValue: Int64): Int64;

     /// <summary>
     ///   Converts the value to a string in the specified numeral system.
     /// </summary>
     function ToNumeralSystem(const Base: Integer): string;
     /// <summary>
     ///   Returns the binary representation of the value.
     /// </summary>
     function Binary: string;
     /// <summary>
     ///   Returns the octal representation of the value.
     /// </summary>
     function Octal: string;
     /// <summary>
     ///   Returns the hexadecimal representation of the value.
     /// </summary>
     function Hexidecimal: string;
     /// <summary>
     ///   Returns the base-32 numeral system representation of the value.
     /// </summary>
     function NumeralSystem32: string;
     /// <summary>
     ///   Returns the base-64 numeral system representation of the value.
     /// </summary>
     function NumeralSystem64: string;

     /// <summary>
     ///   Sets the value from a binary string.
     /// </summary>
     procedure SetBinary(const Value: string);
     /// <summary>
     ///   Sets the value from an octal string.
     /// </summary>
     procedure SetOctal(const Value: string);
     /// <summary>
     ///   Sets the value from a hexadecimal string.
     /// </summary>
     procedure SetHexidecimal(const Value: string);
     /// <summary>
     ///   Sets the value from a base-32 numeral system string.
     /// </summary>
     procedure SetNumeralSystem32(const Value: string);
     /// <summary>
     ///   Sets the value from a base-64 numeral system string.
     /// </summary>
     procedure SetNumeralSystem64(const Value: string);

     /// <summary>
     ///   Executes a procedure for each value in the range.
     /// </summary>
     procedure ForLoop(InitialValue: Int64; ToValue: Int64; Proc: TProc);
     /// <summary>
     ///   Checks if the value is a prime number.
     /// </summary>
     function IsPrime(): Boolean;

     /// <summary>
     ///   Returns a random integer between the specified minimum and maximum values.
     /// </summary>
     class function Random(MinValue: Int64; MaxValue: Int64): Int64; overload; static;
     /// <summary>
     ///   Returns a random prime integer between the specified minimum and maximum values.
     /// </summary>
     class function RandomPrime(MinValue: Int64; MaxValue: Int64): Int64; overload; static;
     /// <summary>
     ///   Returns a random integer up to the specified maximum value.
     /// </summary>
     class function Random(MaxValue: Int64 = MaxInt): Int64; overload; static;
     /// <summary>
     ///   Returns a random prime integer up to the specified maximum value.
     /// </summary>
     class function RandomPrime(MaxValue: Int64 = MaxInt): Int64; overload; static;

     /// <summary>
     ///   Sets the value to a random integer between the specified minimum and maximum values.
     /// </summary>
     procedure SetRandom(MinValue: Int64; MaxValue: Int64); overload;
     /// <summary>
     ///   Sets the value to a random integer up to the specified maximum value.
     /// </summary>
     procedure SetRandom(MaxValue: Int64 = MaxInt); overload;
     /// <summary>
     ///   Sets the value to a random prime integer between the specified minimum and maximum values.
     /// </summary>
     procedure SetRandomPrime(MinValue: Int64; MaxValue: Int64); overload;
     /// <summary>
     ///   Sets the value to a random prime integer up to the specified maximum value.
     /// </summary>
     procedure SetRandomPrime(MaxValue: Int64 = MaxInt); overload;

    const
      MaxValue = 9223372036854775807;
      MinValue = -9223372036854775808;

    /// <summary>
    ///   Converts the Int64 value to a boolean.
    /// </summary>
    function ToBoolean: Boolean; inline;
    /// <summary>
    ///   Converts the Int64 value to a hexadecimal string.
    /// </summary>
    function ToHexString: string; overload; inline;
    /// <summary>
    ///   Converts the Int64 value to a hexadecimal string with the specified minimum digits.
    /// </summary>
    function ToHexString(const MinDigits: Integer): string; overload; inline;
    /// <summary>
    ///   Converts the Int64 value to a single-precision floating-point value.
    /// </summary>
    function ToSingle: Single; inline;
    /// <summary>
    ///   Converts the Int64 value to a double-precision floating-point value.
    /// </summary>
    function ToDouble: Double; inline;
    /// <summary>
    ///   Converts the Int64 value to an extended-precision floating-point value.
    /// </summary>
    function ToExtended: Extended; inline;

    /// <summary>
    ///   Returns the size of the Int64 type in bytes.
    /// </summary>
    class function Size: Integer; inline; static;
    /// <summary>
    ///   Converts the specified Int64 value to a string.
    /// </summary>
    class function ToString(const Value: Int64): string; overload; inline; static;
    /// <summary>
    ///   Parses the string and returns the Int64 value.
    /// </summary>
    class function Parse(const S: string): Int64; static;
    /// <summary>
    ///   Tries to parse the string and returns true if successful.
    /// </summary>
    class function TryParse(const S: string; out Value: Int64): Boolean; inline; static;
  end;
  {$IFEND}

  {$IF CompilerVersion >= 24.0}
  TOLStringHelper = record helper for string
  private
    function GetLines(const Index: Integer): OLString;
    function GetCSV(const Index: Integer): OLString; overload;
    function GetCSV(const ColIndex, RowIndex: Integer): OLString; overload;
    procedure SetCSV(const Index: Integer; const Value: OLString); overload;
    procedure SetCSV(const ColIndex, RowIndex: Integer; const Value: OLString); overload;
    procedure SetLines(const Index: Integer; const Value: OLString);
    procedure SetParams(const ParamName: string; const Value: OLString);
    function GetHtmlUnicodeText: string;
    procedure SetHtmlUnicodeText(const Value: string);
    function GetUrlEncodedText: string;
    procedure SetUrlEncodedText(const Value: string);
    function GetBase64: string;
    procedure SetBase64(const Value: string);

   Public
     // Basic properties
     /// <summary>
     ///   Checks if the string is empty.
     /// </summary>
     function IsEmptyStr(): OLBoolean;
     /// <summary>
     ///   Returns the length of the string.
     /// </summary>
     function Length(): OLInteger;

     // Substring operations
     /// <summary>
     ///   Returns a substring starting from the specified index.
     /// </summary>
     function Substring(StartIndex: Integer): string; overload;
     /// <summary>
     ///   Returns a substring starting from the specified index with the specified length.
     /// </summary>
     function Substring(StartIndex, Length: Integer): string; overload;
     /// <summary>
     ///   Returns the left part of the string with the specified count of characters.
     /// </summary>
     function LeftStr(Count: Integer): string;
     /// <summary>
     ///   Returns the right part of the string with the specified count of characters.
     /// </summary>
     function RightStr(Count: Integer): string;

     // Search and replace
     /// <summary>
     ///   Checks if the string contains the specified substring.
     /// </summary>
     function ContainsStr(SubString: string): OLBoolean;
     /// <summary>
     ///   Returns the position of the specified substring in the string.
     /// </summary>
     function Pos(SubString: string): OLInteger;
     /// <summary>
     ///   Replaces occurrences of the old value with the new value in the string.
     /// </summary>
     function Replace(OldValue, NewValue: string): string; overload;

     // Case operations
     /// <summary>
     ///   Converts the string to lowercase.
     /// </summary>
     function LowerCase(): string; overload;
     /// <summary>
     ///   Converts the string to uppercase.
     /// </summary>
     function UpperCase(): string; overload;

     // Trim operations
     /// <summary>
     ///   Trims whitespace from both ends of the string.
     /// </summary>
     function Trim(): string; overload;
     /// <summary>
     ///   Trims whitespace from the left end of the string.
     /// </summary>
     function TrimLeft(): string; overload;
     /// <summary>
     ///   Trims whitespace from the right end of the string.
     /// </summary>
     function TrimRight(): string; overload;

     // Other utilities
     /// <summary>
     ///   Checks if the string starts with the specified value.
     /// </summary>
     function StartsStr(Value: string): OLBoolean;
     /// <summary>
     ///   Checks if the string ends with the specified value.
     /// </summary>
     function EndsStr(Value: string): OLBoolean;
     /// <summary>
     ///   Returns the reversed string.
     /// </summary>
     function ReversedString(): string;

     // Additional methods from OLString
     /// <summary>
     ///   Returns a hash of the string with the optional salt.
     /// </summary>
     function HashStr(const Salt: string = ''): string;
     /// <summary>
     ///   Returns the compressed version of the string.
     /// </summary>
     function Compressed(): string;
     /// <summary>
     ///   Returns the decompressed version of the string.
     /// </summary>
     function Decompressed(): string;
     /// <summary>
     ///   Extracts the file name from the string.
     /// </summary>
     function ExtractedFileName(): string;
     /// <summary>
     ///   Extracts the file extension from the string.
     /// </summary>
     function ExtractedFileExt(): string;
     /// <summary>
     ///   Extracts the file drive string from the string.
     /// </summary>
     function ExtractedFileDriveString(): string;
     /// <summary>
     ///   Extracts the file directory from the string.
     /// </summary>
     function ExtractedFileDir(): string;
     /// <summary>
     ///   Extracts the file path from the string.
     /// </summary>
     function ExtractedFilePath(): string;
     /// <summary>
     ///   Loads the string from the specified file.
     /// </summary>
     procedure LoadFromFile(const FileName: string); overload;
     /// <summary>
     ///   Loads the string from the specified file with the specified encoding.
     /// </summary>
     procedure LoadFromFile(const FileName: string; Encoding: TEncoding); overload;
     /// <summary>
     ///   Saves the string to the specified file.
     /// </summary>
     procedure SaveToFile(const FileName: string); overload;
     /// <summary>
     ///   Saves the string to the specified file with the specified encoding.
     /// </summary>
     procedure SaveToFile(const FileName: string; Encoding: TEncoding); overload;
     /// <summary>
     ///   Encodes the file content to Base64 and sets it to the string.
     /// </summary>
     procedure EndcodeBase64FromFile(const FileName: string);
     /// <summary>
     ///   Decodes the Base64 string and saves it to the specified file.
     /// </summary>
     procedure DecodeBase64ToFile(const FileName: string);
     /// <summary>
     ///   Formats the string with the specified data.
     /// </summary>
     function Formated(const Data: array of const): string;
     /// <summary>
     ///   Finds a tag in the string starting from the specified position.
     /// </summary>
     function FindTagStr(const Tag: string; const StartingPosition: Integer = 1): string;
     /// <summary>
     ///   Checks if the string matches the specified pattern.
     /// </summary>
     function Like(Pattern: string): OLBoolean;
     /// <summary>
     ///   Checks if the string is the same as the specified string (case-sensitive).
     /// </summary>
     function SameStr(s: string): OLBoolean;
     /// <summary>
     ///   Checks if the string is the same as the specified string (case-insensitive).
     /// </summary>
     function SameText(s: string): OLBoolean;
     /// <summary>
     ///   Converts the string to an integer.
     /// </summary>
     function ToInt(): OLInteger;
     /// <summary>
     ///   Tries to convert the string to an integer.
     /// </summary>
     function TryToInt(): OLBoolean; overload;
     /// <summary>
     ///   Tries to convert the string to an integer and stores the result in the variable.
     /// </summary>
     function TryToInt(var i: Integer): OLBoolean; overload;
     /// <summary>
     ///   Returns the number of lines in the string.
     /// </summary>
     function LineCount(): OLInteger;
     /// <summary>
     ///   Returns the index of the last line in the string.
     /// </summary>
     function LastLineIndex(): Integer;
     /// <summary>
     ///   Adds a new line to the string.
     /// </summary>
     procedure LineAdd(const NewLine: string);
     /// <summary>
     ///   Deletes the line at the specified index.
     /// </summary>
     procedure LineDelete(const LineIndex: Integer);
     /// <summary>
     ///   Inserts a string at the specified line index.
     /// </summary>
     procedure LineInsertAt(const LineIndex: Integer; const s: string);
     /// <summary>
     ///   Returns the index of the line that matches the specified string.
     /// </summary>
     function LineIndexLike(const s: string; StartingFrom: Integer = 0): OLInteger;
     /// <summary>
     ///   Returns the lines of the string sorted.
     /// </summary>
     function LinesSorted(): string;
     /// <summary>
     ///   Returns the start position of the line at the specified index.
     /// </summary>
     function GetLineStartPosition(const Index: Integer): OLInteger;
     /// <summary>
     ///   Returns the end position of the line at the specified index.
     /// </summary>
     function GetLineEndPosition(const Index: Integer): OLInteger;
     /// <summary>
     ///   Returns the end position of the line at the specified index.
     /// </summary>
     function LineEndAt(const LineIndex: Integer): OLInteger;
     /// <summary>
     ///   Checks if the string matches any of the specified values.
     /// </summary>
     function MatchStr(const AValues: array of string): OLBoolean;
     /// <summary>
     ///   Checks if the string contains the specified substring (case-insensitive).
     /// </summary>
     function ContainsText(SubString: string): OLBoolean;
     /// <summary>
     ///   Checks if the string starts with the specified value (case-insensitive).
     /// </summary>
     function StartsText(Value: string): OLBoolean; overload;
     /// <summary>
     ///   Checks if the string ends with the specified value (case-insensitive).
     /// </summary>
     function EndsText(Value: string): OLBoolean; overload;
     /// <summary>
     ///   Returns the index of the first matching value in the array.
     /// </summary>
     function IndexStr(const AValues: array of string): OLInteger;
     /// <summary>
     ///   Returns the index of the first matching value in the array (case-insensitive).
     /// </summary>
     function IndexText(const AValues: array of string): OLInteger;
     /// <summary>
     ///   Checks if the string matches any of the specified values (case-insensitive).
     /// </summary>
     function MatchText(const AValues: array of string): OLBoolean;
     /// <summary>
     ///   Finds a pattern in the string between the specified front and behind strings.
     /// </summary>
     function FindPatternStr(const InFront, Behind: string; const StartingPosition: Integer = 1; const CaseSensitivity: TCaseSensitivity = csCaseSensitive): string; overload;
     /// <summary>
     ///   Finds a tag in the string starting from the specified position.
     /// </summary>
     function FindPatternStr(const Tag: string; const StartingPosition: Integer = 1; const CaseSensitivity: TCaseSensitivity = csCaseInsensitive): string; overload;
     /// <summary>
     ///   Returns the position of the substring starting from the specified offset.
     /// </summary>
     function PosEx(const SubStr: string; const Offset: Integer): OLInteger;
     /// <summary>
     ///   Returns the number of occurrences of the substring in the string.
     /// </summary>
     function OccurrencesCount(const SubString: string): OLInteger;
     /// <summary>
     ///   Returns a substring starting from the specified position with the specified count.
     /// </summary>
     function MidStr(const AStart, ACount: Integer): string;
     /// <summary>
     ///   Splits the string into an array using the specified delimiters.
     /// </summary>
     function SplitString(const Delimiters: string = ';'): TOLStringDynArray;
     /// <summary>
     ///   Returns a substring from the start to the end position.
     /// </summary>
     function MidStrEx(const AStart, AEnd: Integer): string;
     /// <summary>
     ///   Replaces the string starting from the specified position with the new value.
     /// </summary>
     function ReplacedStartingAt(const Position: Cardinal; const NewValue: string): string;
     /// <summary>
     ///   Removes the specified number of characters from the end of the string.
     /// </summary>
     function EndingRemoved(const ACount: Integer): string;
     /// <summary>
     ///   Returns the right part of the string starting from the specified position.
     /// </summary>
     function RightStrFrom(const StartFrom: Integer): string;
     /// <summary>
     ///   Adds leading spaces to the string to reach the specified length.
     /// </summary>
     function LeadingSpacesAdded(const NewLength: Integer): string;
     /// <summary>
     ///   Adds trailing spaces to the string to reach the specified length.
     /// </summary>
     function TrailingSpacesAdded(const NewLength: Integer): string;
     /// <summary>
     ///   Excludes the specified trailing character from the string.
     /// </summary>
     function TrailingCharExcluded(const c: Char): string;
     /// <summary>
     ///   Includes the specified trailing character in the string.
     /// </summary>
     function TrailingCharIncluded(const c: Char): string;
     /// <summary>
     ///   Excludes trailing apostrophes from the string.
     /// </summary>
     function TrailingApostropheExcluded(): string;
     /// <summary>
     ///   Includes trailing apostrophes in the string.
     /// </summary>
     function TrailingApostropheIncluded(): string;
     /// <summary>
     ///   Excludes the specified leading character from the string.
     /// </summary>
     function LeadingCharExcluded(const c: Char): string;
     /// <summary>
     ///   Includes the specified leading character in the string.
     /// </summary>
     function LeadingCharIncluded(const c: Char): string;
     /// <summary>
     ///   Includes a leading comma in the string.
     /// </summary>
     function LeadingComaIncluded(): string;
     /// <summary>
     ///   Excludes leading apostrophes from the string.
     /// </summary>
     function LeadingApostropheExcluded(): string;
     /// <summary>
     ///   Includes leading apostrophes in the string.
     /// </summary>
     function LeadingApostropheIncluded(): string;
     /// <summary>
     ///   Replaces the specified text with another text (case-insensitive).
     /// </summary>
     function ReplacedText(const AFromText, AToText: string): string;
     /// <summary>
     ///   Trims whitespace from both ends of the string.
     /// </summary>
     function Trimmed(): string;
     /// <summary>
     ///   Trims whitespace from the left end of the string.
     /// </summary>
     function TrimmedLeft(): string;
     /// <summary>
     ///   Trims whitespace from the right end of the string.
     /// </summary>
     function TrimmedRight(): string;
     /// <summary>
     ///   Adds leading zeros to the string to reach the specified length.
     /// </summary>
     function LeadingZerosAdded(const NewLength: Integer): string;
     /// <summary>
     ///   Inserts the specified string at the specified position.
     /// </summary>
     function Inserted(const InsertStr: string; const Position: Integer): string;
     /// <summary>
     ///   Deletes the specified number of characters from the specified position.
     /// </summary>
     function Deleted(const FromPosition: Integer; const Count: Integer = 1): string;
     /// <summary>
     ///   Returns only the digits from the string.
     /// </summary>
     function DigitsOnly(): string;
     /// <summary>
     ///   Returns the string with all digits removed.
     /// </summary>
     function NoDigits(): string;
     /// <summary>
     ///   Removes all spaces from the string.
     /// </summary>
     function SpacesRemoved(): string;
     /// <summary>
     ///   Quotes the string.
     /// </summary>
     function QuotedStr(): string;
     /// <summary>
     ///   Capitalizes the first letter of each word in the string.
     /// </summary>
     function InitCaps(): string;
     /// <summary>
     ///   Returns only alphanumeric characters from the string.
     /// </summary>
     function AlphanumericsOnly(): string;
     /// <summary>
     ///   Repeats the string the specified number of times.
     /// </summary>
     function RepeatedString(const ACount: Integer): string;
     /// <summary>
     ///   Adds a new line to the string.
     /// </summary>
     function LineAdded(const NewLine: string): string;
     /// <summary>
     ///   Includes a trailing path delimiter in the string.
     /// </summary>
     function TrailingPathDelimiterIncluded(): string;
     /// <summary>
     ///   Excludes the trailing path delimiter from the string.
     /// </summary>
     function TrailingPathDelimiterExcluded(): string;
     /// <summary>
     ///   Returns a random string of the specified length.
     /// </summary>
     class function RandomString(const Length: Integer): string; static;
     /// <summary>
     ///   Returns the line at the specified index.
     /// </summary>
     function GetLine(const Index: Integer): string;
     /// <summary>
     ///   Returns the value of the CSV field at the specified index.
     /// </summary>
     function CSVFieldValue(const FieldIndex: Integer; const Delimiter: Char = ';'): string;

     /// <summary>
     ///   Gets or sets the parameter value by name.
     /// </summary>
     property Params[const ParamName: string]: OLString write SetParams;
     /// <summary>
     ///   Gets or sets the line at the specified index.
     /// </summary>
     property Lines[const Index: Integer]: OLString read GetLines write SetLines;
     /// <summary>
     ///   Gets or sets the CSV field at the specified index.
     /// </summary>
     property CSV[const Index: Integer]: OLString read GetCSV write SetCSV;
     /// <summary>
     ///   Replaces the first occurrence of the specified text with another text.
     /// </summary>
     function ReplacedFirst(const AFromText, AToText: string): string;
     /// <summary>
     ///   Replaces the first occurrence of the specified text with another text (case-insensitive).
     /// </summary>
     function ReplacedFirstText(const AFromText, AToText: string): string;
     /// <summary>
     ///   Adds leading characters to the string to reach the specified length.
     /// </summary>
     function LeadingCharsAdded(const C: Char; const NewLength: Integer): string;
     /// <summary>
     ///   Adds trailing characters to the string to reach the specified length.
     /// </summary>
     function TrailingCharsAdded(const C: Char; const NewLength: Integer): string;
     /// <summary>
     ///   Returns the position of the specified occurrence of the substring.
     /// </summary>
     function OccurrencesPosition(const SubString: string; const Index: Integer): OLInteger;
     /// <summary>
     ///   Returns the last position of the substring in the string.
     /// </summary>
     function PosLast(const SubStr: string): OLInteger;
     /// <summary>
     ///   Returns the last position of the substring in the string before the specified position.
     /// </summary>
     function PosLastEx(const SubStr: string; const NotAfterPosition: Integer; const CaseSensitivity: TCaseSensitivity = csCaseSensitive): OLInteger;
     /// <summary>
     ///   Finds a pattern in the string between the specified front and behind strings.
     /// </summary>
     function FindPattern(const InFront, Behind: string; const StartingPosition: Integer = 1): TStringPatternFind;
     /// <summary>
     ///   Returns the index of the line that contains the specified string.
     /// </summary>
     function LineIndexOf(const s: string): OLInteger;
     /// <summary>
     ///   Returns the index of the CSV field that contains the specified value.
     /// </summary>
     function CSVIndex(const ValueToFind: string): OLInteger;
     /// <summary>
     ///   Returns the number of CSV fields in the string.
     /// </summary>
     function CSVFieldCount(const Delimiter: Char = ';'): OLInteger;
     /// <summary>
     ///   Sets the value of the CSV field at the specified index.
     /// </summary>
     procedure SetCSVFieldValue(const FieldIndex: Integer; const Value: OLString; const Delimiter: Char = ';');
     /// <summary>
     ///   Returns the name of the CSV field at the specified index.
     /// </summary>
     function CSVFieldName(const index: Integer): string;
     /// <summary>
     ///   Returns the value of the CSV field by name.
     /// </summary>
     function CSVFieldByName(const FieldName: string; const RowIndex: Integer = 1): string;
     {$IFDEF VCL}
     /// <summary>
     ///   Returns the pixel width of the string using the specified font.
     /// </summary>
     function PixelWidth(const F: TFont): OLInteger;
     {$ENDIF}
     /// <summary>
     ///   Checks if the string is a valid IBAN.
     /// </summary>
     function IsValidIBAN: OLBoolean;
     /// <summary>
     ///   Excludes trailing commas from the string.
     /// </summary>
     function TrailingComaExcluded(): string;
     /// <summary>
     ///   Excludes leading commas from the string.
     /// </summary>
     function LeadingComaExcluded(): string;
     /// <summary>
     ///   Tries to convert the string to a float.
     /// </summary>
     function TryToFloat(): OLBoolean; overload;
     /// <summary>
     ///   Tries to convert the string to a float and stores the result in the variable.
     /// </summary>
     function TryToFloat(var e: Double): OLBoolean; overload;
     /// <summary>
     ///   Tries to convert the string to a date.
     /// </summary>
     function TryToDate(): OLBoolean; overload;
     /// <summary>
     ///   Tries to convert the string to a date and stores the result in the variable.
     /// </summary>
     function TryToDate(var d: TDate): OLBoolean; overload;
     /// <summary>
     ///   Tries to convert the string to a currency.
     /// </summary>
     function TryToCurr(): OLBoolean; overload;
     /// <summary>
     ///   Tries to convert the string to a currency and stores the result in the variable.
     /// </summary>
     function TryToCurr(var c: Currency): OLBoolean; overload;
     /// <summary>
     ///   Tries to convert the string to an Int64.
     /// </summary>
     function TryToInt64(): OLBoolean; overload;
     /// <summary>
     ///   Tries to convert the string to an Int64 and stores the result in the variable.
     /// </summary>
     function TryToInt64(var i: Int64): OLBoolean; overload;
     /// <summary>
     ///   Converts the string to a currency.
     /// </summary>
     function ToCurr(): OLCurrency;
     /// <summary>
     ///   Converts the string to a date.
     /// </summary>
     function ToDate(): OLDate;
     /// <summary>
     ///   Converts the string to a date/time.
     /// </summary>
     function ToDateTime(): OLDateTime;
     /// <summary>
     ///   Converts the string to a float.
     /// </summary>
     function ToFloat(): OLDouble;
     /// <summary>
     ///   Converts the string to an Int64.
     /// </summary>
     function ToInt64(): OLInt64;  overload;
     /// <summary>
     ///   Tries to convert the string to a date using smart parsing.
     /// </summary>
     function TrySmartStrToDate(): OLBoolean; overload;
     /// <summary>
     ///   Tries to convert the string to a date using smart parsing and stores the result in the variable.
     /// </summary>
     function TrySmartStrToDate(var d: TDate): OLBoolean; overload;
     /// <summary>
     ///   Converts the string to a date using smart parsing.
     /// </summary>
     function SmartStrToDate(): OLDate;
     /// <summary>
     ///   Converts the string to a PWideChar.
     /// </summary>
     function ToPWideChar(): PWideChar;
     /// <summary>
     ///   Returns the position of the last delimiter in the string.
     /// </summary>
     function LastDelimiterPosition(const Delimiters: string = ';'): OLInteger;
     /// <summary>
     ///   Returns a hash of the string with the optional salt.
     /// </summary>
     function Hash(const Salt: string = ''): Cardinal;
     /// <summary>
     ///   Converts the string to a SQL-compatible string representation.
     /// </summary>
     function ToSQLString(): string;
     /// <summary>
     ///   Copies the string to the clipboard.
     /// </summary>
     procedure CopyToClipboard();
     /// <summary>
     ///   Pastes the string from the clipboard.
     /// </summary>
     procedure PasteFromClipboard();
     /// <summary>
     ///   Loads the string from the specified URL.
     /// </summary>
     procedure GetFromUrl(const URL: string; Timeout: LongWord = 0);
     /// <summary>
     ///   Returns a random string from the specified array of values.
     /// </summary>
     class function RandomFrom(const AValues: array of string): string; static;
     /// <summary>
     ///   Gets or sets the HTML Unicode text representation of the string.
     /// </summary>
     property HtmlUnicodeText: string read GetHtmlUnicodeText write SetHtmlUnicodeText;
     /// <summary>
     ///   Gets or sets the URL-encoded text representation of the string.
     /// </summary>
     property UrlEncodedText: string read GetUrlEncodedText write SetUrlEncodedText;
     /// <summary>
     ///   Gets or sets the Base64 representation of the string.
     /// </summary>
     property Base64: string read GetBase64 write SetBase64;
     {$IF CompilerVersion >= 27.0}
     /// <summary>
     ///   Gets the JSON value for the specified field name.
     /// </summary>
     function GetJSON(const JsonFieldName: string): OLString;
     /// <summary>
     ///   Sets the JSON value for the specified field name.
     /// </summary>
     procedure SetJSON(const JsonFieldName: string; const Value: OLString);
     /// <summary>
     ///   Gets the XML value for the specified XPath.
     /// </summary>
     function GetXML(const XPath: string): OLString;
     /// <summary>
     ///   Sets the XML value for the specified XPath.
     /// </summary>
     procedure SetXML(const XPath: string; const Value: OLString);
     /// <summary>
     ///   Gets or sets the JSON value for the specified field name.
     /// </summary>
     property JSON[const JsonFieldName: string]: OLString read GetJSON write SetJSON;
     /// <summary>
     ///   Gets or sets the XML value for the specified XPath.
     /// </summary>
     property XML[const XPath: string]: OLString read GetXML write SetXML;
     /// <summary>
     ///   Returns a list of JSON strings from the specified path.
     /// </summary>
     function GetJsonCollection(const JsonPath: string): TArray<string>;
     /// <summary>
     ///   Returns a list of XML strings from the child nodes of the specified path.
     /// </summary>
     function GetXmlCollection(const XPath: string): TArray<string>;
      /// <summary>
      ///   Gets or sets the CSV value for the specified column and row.
      /// </summary>
      property CSVCell[const ColIndex, RowIndex: Integer]: OLString read GetCSV write SetCSV;
     {$IFEND}

    // Immutable "From..." methods (static factories)

    /// <summary>
    ///  Creates a new string from HTML Unicode encoded text.
    /// </summary>
    class function FromHtmlUnicodeText(const Value: string): string; static;

    /// <summary>
    ///  Creates a new string from URL encoded text.
    /// </summary>
    class function FromUrlEncodedText(const Value: string): string; static;

    /// <summary>
    ///  Creates a new string from a Base64 encoded string.
    /// </summary>
    class function FromBase64(const Value: string): string; static;

    /// <summary>
    ///  Creates a new string by reading a file and encoding its content to Base64.
    /// </summary>
    class function FromBase64File(const FileName: string): string; static;

    /// <summary>
    ///  Creates a new string by downloading content from the specified URL.
    /// </summary>
    class function FromUrl(const URL: string): string; static;

    /// <summary>
    ///  Creates a new string from the current clipboard text content.
    /// </summary>
    class function FromClipboard: string; static;

    // Immutable "With..." methods (instance modifiers)

    /// <summary>
    ///  Returns a new string with a new line added at the end.
    /// </summary>
    function WithLineAdded(const Line: string): string;

    /// <summary>
    ///  Returns a new string with the content of the specified line changed.
    /// </summary>
    function WithLineChanged(const Index: Integer; const Line: string): string;

    /// <summary>
    ///  Returns a new string with the line at the specified index removed.
    /// </summary>
    function WithLineDeleted(const Index: Integer): string;

    /// <summary>
    ///  Returns a new string with a new line inserted at the specified index.
    /// </summary>
    function WithLineInserted(const Index: Integer; const Line: string): string;

    /// <summary>
    ///  Returns a new string with the specified CSV field value updated.
    /// </summary>
    function WithCSV(const Index: Integer; const Value: string): string;

    /// <summary>
    ///  Returns a new string with the CSV cell at the specified column and row updated.
    /// </summary>
    function WithCSVCell(const ColIndex, RowIndex: Integer; const Value: string): string;

    /// <summary>
    ///  Returns a new string with the value of the specified parameter updated.
    /// </summary>
    function WithParam(const ParamName: string; const Value: string): string;

    {$IF CompilerVersion >= 27.0}
    /// <summary>
    ///  Returns a new string with the specified JSON field value updated.
    /// </summary>
    function WithJSON(const Field: string; const Value: string): string;

    /// <summary>
    ///  Returns a new string with the content at the specified XPath updated.
    /// </summary>
    function WithXML(const XPath: string; const Value: string): string;
    {$IFEND}

     const Empty = '';
      // Methods
      class function Create(C: Char; Count: Integer): string; overload; static;
          inline;
      class function Create(const Value: array of Char; StartIndex: Integer; Length:
          Integer): string; overload; static;
      class function Create(const Value: array of Char): string; overload; static;
      class function Compare(const StrA: string; const StrB: string): Integer;
          overload; static; inline;
      class function Compare(const StrA: string; const StrB: string; LocaleID:
          TLocaleID): Integer; overload; static; inline;
      class function Compare(const StrA: string; const StrB: string; IgnoreCase:
          Boolean): Integer; overload; static; inline;
      class function Compare(const StrA: string; const StrB: string; IgnoreCase:
          Boolean; LocaleID: TLocaleID): Integer; overload; static; inline;
      class function Compare(const StrA: string; const StrB: string; Options:
          TCompareOptions): Integer; overload; static; inline;
      class function Compare(const StrA: string; const StrB: string; Options:
          TCompareOptions; LocaleID: TLocaleID): Integer; overload; static; inline;
      class function Compare(const StrA: string; IndexA: Integer; const StrB: string;
          IndexB: Integer; Length: Integer): Integer; overload; static; inline;
      class function Compare(const StrA: string; IndexA: Integer; const StrB: string;
          IndexB: Integer; Length: Integer; LocaleID: TLocaleID): Integer; overload;
          static; inline;
      class function Compare(const StrA: string; IndexA: Integer; const StrB: string;
          IndexB: Integer; Length: Integer; IgnoreCase: Boolean): Integer; overload;
          static; inline;
      class function Compare(const StrA: string; IndexA: Integer; const StrB: string;
          IndexB: Integer; Length: Integer; IgnoreCase: Boolean; LocaleID:
          TLocaleID): Integer; overload; static; inline;
      class function Compare(const StrA: string; IndexA: Integer; const StrB: string;
          IndexB: Integer; Length: Integer; Options: TCompareOptions): Integer;
          overload; static; inline;
      class function Compare(const StrA: string; IndexA: Integer; const StrB: string;
          IndexB: Integer; Length: Integer; Options: TCompareOptions; LocaleID:
          TLocaleID): Integer; overload; static; inline;
      class function CompareOrdinal(const StrA: string; const StrB: string): Integer;
          overload; static;
      class function CompareOrdinal(const StrA: string; IndexA: Integer; const StrB:
          string; IndexB: Integer; Length: Integer): Integer; overload; static;
      class function CompareText(const StrA: string; const StrB: string): Integer;
          static; inline;
      class function Parse(const Value: Integer): string; overload; static; inline;
      class function Parse(const Value: Int64): string; overload; static; inline;
      class function Parse(const Value: Boolean): string; overload; static; inline;
      class function Parse(const Value: Extended): string; overload; static; inline;
      class function ToBoolean(const S: string): Boolean; overload; static; inline;
      class function ToInteger(const S: string): Integer; overload; static; inline;
      /// <summary>Class function to Convert a string to an Int64 value</summary>
      class function ToSingle(const S: string): Single; overload; static; inline;
      class function ToDouble(const S: string): Double; overload; static; inline;
      class function ToExtended(const S: string): Extended; overload; static; inline;
      class function LowerCase(const S: string): string; overload; static; inline;
      class function LowerCase(const S: string; LocaleOptions: TLocaleOptions):
          string; overload; static; inline;
      class function UpperCase(const S: string): string; overload; static; inline;
      class function UpperCase(const S: string; LocaleOptions: TLocaleOptions):
          string; overload; static; inline;
      /// <summary>Compares this string to another string.</summary>
      function CompareTo(const strB: string): Integer;
      /// <summary>Checks if the string contains the specified value.</summary>
      function Contains(const Value: string): Boolean;
      /// <summary>Creates a copy of the string.</summary>
      class function Copy(const Str: string): string; static; inline;
      /// <summary>Copies characters from this string to a destination array.</summary>
      procedure CopyTo(SourceIndex: Integer; var destination: array of Char;
          DestinationIndex: Integer; Count: Integer);
      /// <summary>Counts the occurrences of a character in the string.</summary>
      function CountChar(const C: Char): Integer;
      /// <summary>Removes quotes from the string.</summary>
      function DeQuotedString: string; overload;
      /// <summary>Removes specified quote characters from the string.</summary>
      function DeQuotedString(const QuoteChar: Char): string; overload;
      /// <summary>Checks if the string ends with the specified text (case-insensitive).</summary>
      class function EndsText(const ASubText, AText: string): Boolean; overload; static;
      /// <summary>Checks if the string ends with the specified value.</summary>
      function EndsWith(const Value: string): Boolean; overload; inline;
      /// <summary>Checks if the string ends with the specified value, with optional case sensitivity.</summary>
      function EndsWith(const Value: string; IgnoreCase: Boolean): Boolean; overload;
      /// <summary>Checks if the string equals another string.</summary>
      function Equals(const Value: string): Boolean; overload;
      class function Equals(const a: string; const b: string): Boolean; overload;
          static;
      class function Format(const Format: string; const args: array of const):
          string; overload; static;
      /// <summary>Returns the hash code for the string.</summary>
      function GetHashCode: Integer;
      /// <summary>Returns the index of the first occurrence of a character.</summary>
      function IndexOf(Value: Char): Integer; overload;
      /// <summary>Returns the index of the first occurrence of a substring.</summary>
      function IndexOf(const Value: string): Integer; overload; inline;
      /// <summary>Returns the index of the first occurrence of a character, starting from a specified index.</summary>
      function IndexOf(Value: Char; StartIndex: Integer): Integer; overload;
      /// <summary>Returns the index of the first occurrence of a substring, starting from a specified index.</summary>
      function IndexOf(const Value: string; StartIndex: Integer): Integer; overload;
      /// <summary>Returns the index of the first occurrence of a character, starting from a specified index and checking a count of characters.</summary>
      function IndexOf(Value: Char; StartIndex: Integer; Count: Integer): Integer;
          overload;
      /// <summary>Returns the index of the first occurrence of a substring, starting from a specified index and checking a count of characters.</summary>
      function IndexOf(const Value: string; StartIndex: Integer; Count: Integer):
          Integer; overload;
      /// <summary>Returns the index of the first occurrence of any character in the array.</summary>
      function IndexOfAny(const AnyOf: array of Char): Integer; overload;
      /// <summary>Returns the index of the first occurrence of any character in the array, starting from a specified index.</summary>
      function IndexOfAny(const AnyOf: array of Char; StartIndex: Integer): Integer;
          overload;
      /// <summary>Returns the index of the first occurrence of any character in the array, starting from a specified index and checking a count of characters.</summary>
      function IndexOfAny(const AnyOf: array of Char; StartIndex: Integer; Count:
          Integer): Integer; overload;
      /// <summary>Index of any given chars, excluding those that are between quotes.</summary>
      function IndexOfAnyUnquoted(const AnyOf: array of Char; StartQuote, EndQuote:
          Char): Integer; overload;
      /// <summary>Index of any given chars, excluding those that are between quotes, starting from a specified index.</summary>
      function IndexOfAnyUnquoted(const AnyOf: array of Char; StartQuote, EndQuote:
          Char; StartIndex: Integer): Integer; overload;
      /// <summary>Index of any given chars, excluding those that are between quotes, starting from a specified index and count.</summary>
      function IndexOfAnyUnquoted(const AnyOf: array of Char; StartQuote, EndQuote:
          Char; StartIndex: Integer; Count: Integer): Integer; overload;
      /// <summary>Inserts a string at a specified index.</summary>
      function Insert(StartIndex: Integer; const Value: string): string;
      /// <summary>Checks if the character at the specified index is a delimiter.</summary>
      function IsDelimiter(const Delimiters: string; Index: Integer): Boolean;
      /// <summary>Checks if the string is empty.</summary>
      function IsEmpty: Boolean; inline;
      /// <summary>Checks if the string contains JSON.</summary>
      function IsJSON: OLBoolean;
      /// <summary>Checks if the string contains XML.</summary>
      function IsXML: OLBoolean;
      /// <summary>Returns the string in a formatted (indented) way if it is JSON or XML.</summary>
      function PrettyPrint: OLString;
      /// <summary>Checks if the string is null or empty.</summary>
      class function IsNullOrEmpty(const Value: string): Boolean; static; inline;
      /// <summary>Checks if the string is null, empty, or consists only of white-space characters.</summary>
      class function IsNullOrWhiteSpace(const Value: string): Boolean; static;
      /// <summary>Concatenates elements of an array, using the specified separator between each element.</summary>
      class function Join(const Separator: string; const Values: array of const):
          string; overload; static;
      /// <summary>Concatenates elements of a string array, using the specified separator between each element.</summary>
      class function Join(const Separator: string; const Values: array of string):
          string; overload; static;
      /// <summary>Concatenates elements of a string collection, using the specified separator between each element.</summary>
      class function Join(const Separator: string; const Values:
          IEnumerator<string>): string; overload; static;
      /// <summary>Concatenates elements of a string collection, using the specified separator between each element.</summary>
      class function Join(const Separator: string; const Values:
          IEnumerable<string>): string; overload; static; inline;
      /// <summary>Concatenates elements of a string array, using the specified separator between each element, starting from a specified index and count.</summary>
      class function Join(const Separator: string; const Values: array of string;
          StartIndex: Integer; Count: Integer): string; overload; static;
      /// <summary>Returns the index of the last delimiter character.</summary>
      function LastDelimiter(const Delims: string): Integer; overload;
      /// <summary>Returns the index of the last delimiter character using a set of characters.</summary>
      function LastDelimiter(const Delims: TSysCharSet): Integer; overload;
      /// <summary>Returns the index of the last occurrence of a character.</summary>
      function LastIndexOf(Value: Char): Integer; overload;
      /// <summary>Returns the index of the last occurrence of a substring.</summary>
      function LastIndexOf(const Value: string): Integer; overload;
      /// <summary>Returns the index of the last occurrence of a character, searching backward from a specified index.</summary>
      function LastIndexOf(Value: Char; StartIndex: Integer): Integer; overload;
      /// <summary>Returns the index of the last occurrence of a substring, searching backward from a specified index.</summary>
      function LastIndexOf(const Value: string; StartIndex: Integer): Integer;
          overload;
      /// <summary>Returns the index of the last occurrence of a character, searching backward from a specified index and checking a count of characters.</summary>
      function LastIndexOf(Value: Char; StartIndex: Integer; Count: Integer):
          Integer; overload;
      /// <summary>Returns the index of the last occurrence of a substring, searching backward from a specified index and checking a count of characters.</summary>
      function LastIndexOf(const Value: string; StartIndex: Integer; Count: Integer):
          Integer; overload;
      /// <summary>Returns the index of the last occurrence of any character in the array.</summary>
      function LastIndexOfAny(const AnyOf: array of Char): Integer; overload;
      /// <summary>Returns the index of the last occurrence of any character in the array, searching backward from a specified index.</summary>
      function LastIndexOfAny(const AnyOf: array of Char; StartIndex: Integer):
          Integer; overload;
      /// <summary>Returns the index of the last occurrence of any character in the array, searching backward from a specified index and checking a count of characters.</summary>
      function LastIndexOfAny(const AnyOf: array of Char; StartIndex: Integer; Count:
          Integer): Integer; overload;
      /// <summary>Right-aligns the characters in this instance, padding with spaces on the left, for a specified total length.</summary>
      function PadLeft(TotalWidth: Integer): string; overload; inline;
      /// <summary>Right-aligns the characters in this instance, padding with a specified character on the left, for a specified total length.</summary>
      function PadLeft(TotalWidth: Integer; PaddingChar: Char): string; overload;
          inline;
      /// <summary>Left-aligns the characters in this instance, padding with spaces on the right, for a specified total length.</summary>
      function PadRight(TotalWidth: Integer): string; overload; inline;
      /// <summary>Left-aligns the characters in this instance, padding with a specified character on the right, for a specified total length.</summary>
      function PadRight(TotalWidth: Integer; PaddingChar: Char): string; overload;
          inline;
      /// <summary>Returns a quoted string.</summary>
      function QuotedString: string; overload;
      /// <summary>Returns a quoted string using a specified quote character.</summary>
      function QuotedString(const QuoteChar: Char): string; overload;
      /// <summary>Removes characters from the string starting at a specified index.</summary>
      function Remove(StartIndex: Integer): string; overload; inline;
      /// <summary>Removes a specified number of characters from the string starting at a specified index.</summary>
      function Remove(StartIndex: Integer; Count: Integer): string; overload; inline;
      /// <summary>Replaces all occurrences of a character with another character.</summary>
      function Replace(OldChar: Char; NewChar: Char): string; overload;
      /// <summary>Replaces all occurrences of a character with another character, utilizing replace flags.</summary>
      function Replace(OldChar: Char; NewChar: Char; ReplaceFlags: TReplaceFlags):
          string; overload;
      /// <summary>Replaces all occurrences of a substring with another string, utilizing replace flags.</summary>
      function Replace(const OldValue: string; const NewValue: string; ReplaceFlags:
          TReplaceFlags): string; overload;
    function Replaced(const AFromText, AToText: string): string;
      /// <summary>Splits the string into an array of substrings based on characters separator.</summary>
      function Split(const Separator: array of Char): TArray<string>; overload;
      /// <summary>Splits the string into an array of substrings based on characters separator, limiting the number of substrings.</summary>
      function Split(const Separator: array of Char; Count: Integer): TArray<string>;
          overload;
      /// <summary>Splits the string into an array of substrings based on characters separator, with options.</summary>
      function Split(const Separator: array of Char; Options: TStringSplitOptions):
          TArray<string>; overload;
      /// <summary>Splits the string into an array of substrings based on characters separator, limiting the number of substrings, with options.</summary>
      function Split(const Separator: array of Char; Count: Integer; Options:
          TStringSplitOptions): TArray<string>; overload;
      /// <summary>Splits the string into an array of substrings based on string separator.</summary>
      function Split(const Separator: array of string): TArray<string>; overload;
      /// <summary>Splits the string into an array of substrings based on string separator, limiting the number of substrings.</summary>
      function Split(const Separator: array of string; Count: Integer):
          TArray<string>; overload;
      /// <summary>Splits the string into an array of substrings based on string separator, with options.</summary>
      function Split(const Separator: array of string; Options: TStringSplitOptions):
          TArray<string>; overload;
      /// <summary>Splits the string into an array of substrings based on string separator, limiting the number of substrings, with options.</summary>
      function Split(const Separator: array of string; Count: Integer; Options:
          TStringSplitOptions): TArray<string>; overload;
      /// <summary>Splits the string into an array of substrings based on characters separatorIn quotes.</summary>
      /// <summary>Splits the string into an array of substrings based on characters separator in quotes.</summary>
      function Split(const Separator: array of Char; Quote: Char): TArray<string>;
          overload;
      /// <summary>Splits the string into an array of substrings based on characters separator in quotes defined by start and end characters.</summary>
      function Split(const Separator: array of Char; QuoteStart, QuoteEnd: Char):
          TArray<string>; overload;
      /// <summary>Splits the string into an array of substrings based on characters separator in quotes, with options.</summary>
      function Split(const Separator: array of Char; QuoteStart, QuoteEnd: Char;
          Options: TStringSplitOptions): TArray<string>; overload;
      /// <summary>Splits the string into an array of substrings based on characters separator in quotes, limiting the count.</summary>
      function Split(const Separator: array of Char; QuoteStart, QuoteEnd: Char;
          Count: Integer): TArray<string>; overload;
      /// <summary>Splits the string into an array of substrings based on characters separator in quotes, limiting the count, with options.</summary>
      function Split(const Separator: array of Char; QuoteStart, QuoteEnd: Char;
          Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
      /// <summary>Splits the string into an array of substrings based on string separator in quotes.</summary>
      function Split(const Separator: array of string; Quote: Char): TArray<string>;
          overload;
      /// <summary>Splits the string into an array of substrings based on string separator in quotes defined by start and end characters.</summary>
      function Split(const Separator: array of string; QuoteStart, QuoteEnd: Char):
          TArray<string>; overload;
      /// <summary>Splits the string into an array of substrings based on string separator in quotes, with options.</summary>
      function Split(const Separator: array of string; QuoteStart, QuoteEnd: Char;
          Options: TStringSplitOptions): TArray<string>; overload;
      /// <summary>Splits the string into an array of substrings based on string separator in quotes, limiting the count.</summary>
      function Split(const Separator: array of string; QuoteStart, QuoteEnd: Char;
          Count: Integer): TArray<string>; overload;
      /// <summary>Splits the string into an array of substrings based on string separator in quotes, limiting the count, with options.</summary>
      function Split(const Separator: array of string; QuoteStart, QuoteEnd: Char;
          Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
      /// <summary>Checks if the string starts with the specified text.</summary>
      class function StartsText(const ASubText, AText: string): Boolean; overload;
          static;
      /// <summary>Checks if the string starts with the specified value.</summary>
      function StartsWith(const Value: string): Boolean; overload; inline;
      /// <summary>Checks if the string starts with the specified value, with optional case sensitivity.</summary>
      function StartsWith(const Value: string; IgnoreCase: Boolean): Boolean;
          overload;
      /// <summary>Converts the string to a Boolean value.</summary>
      function ToBoolean: Boolean; overload; inline;
      /// <summary>Converts the string to an Integer value.</summary>
      function ToInteger: Integer; overload; inline;
      /// <summary>Converts the string to an Int64 value</summary>
      function ToSingle: Single; overload; inline;
      /// <summary>Converts the string to a Double value.</summary>
      function ToDouble: Double; overload; inline;
      /// <summary>Converts the string to an Extended value.</summary>
      function ToExtended: Extended; overload; inline;
      /// <summary>Converts the string to a character array.</summary>
      function ToCharArray: TArray<Char>; overload;
      /// <summary>Converts a substring to a character array.</summary>
      function ToCharArray(StartIndex: Integer; Length: Integer): TArray<Char>;
          overload;
      /// <summary>Returns a copy of this string converted to lowercase.</summary>
      function ToLower: string; overload; inline;
      /// <summary>Returns a copy of this string converted to lowercase using specified locale.</summary>
      function ToLower(LocaleID: TLocaleID): string; overload;
      /// <summary>Returns a copy of this string converted to lowercase using invariant culture.</summary>
      function ToLowerInvariant: string; inline;
      /// <summary>Returns a copy of this string converted to uppercase.</summary>
      function ToUpper: string; overload; inline;
      /// <summary>Returns a copy of this string converted to uppercase using specified locale.</summary>
      function ToUpper(LocaleID: TLocaleID): string; overload;
      /// <summary>Returns a copy of this string converted to uppercase using invariant culture.</summary>
      function ToUpperInvariant: string; inline;
      /// <summary>Trims the specified characters from the string.</summary>
      function Trim(const TrimChars: array of Char): string; overload;
      /// <summary>Trims the specified characters from the beginning of the string.</summary>
      function TrimLeft(const TrimChars: array of Char): string; overload;
      /// <summary>Trims the specified characters from the end of the string.</summary>
      function TrimRight(const TrimChars: array of Char): string; overload;
      /// <summary>Trims the specified characters from the end of the string (deprecated, use TrimRight).</summary>
      function TrimEnd(const TrimChars: array of Char): string; deprecated
          'Use TrimRight';
      /// <summary>Trims the specified characters from the beginning of the string (deprecated, use TrimLeft).</summary>
      function TrimStart(const TrimChars: array of Char): string; deprecated
          'Use TrimLeft';

  end;
  {$IFEND}

   /// <summary>
   ///   Helper class for TEdit to enable data binding with OL types.
   /// </summary>
   TOLEditHelper = class helper for TEdit
      {$IF CompilerVersion >= 34.0}
      /// <summary>
      ///   Links the edit control to an OLInteger variable for two-way data binding with validation.
      /// </summary>
      function Link(var i: OLInteger; const Alignment: TAlignment=taRightJustify): TEditToOLInteger; overload;
      {$ELSE}
      /// <summary>
      ///   Links the edit control to an OLInteger variable for two-way data binding.
      /// </summary>
      function Link(var i: OLInteger; const Alignment: TAlignment=taRightJustify): TEditToOLInteger; overload;
      {$IFEND}
       {$IF CompilerVersion >= 34.0}
       /// <summary>
       ///   Links the edit control to an OLDouble variable for two-way data binding with validation.
       /// </summary>
       function Link(var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLDouble; overload;
       {$ELSE}
       /// <summary>
       ///   Links the edit control to an OLDouble variable for two-way data binding.
       /// </summary>
       function Link(var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLDouble; overload;
       {$IFEND}
       {$IF CompilerVersion >= 34.0}
       /// <summary>
       ///   Links the edit control to an OLCurrency variable for two-way data binding with validation.
       /// </summary>
       function Link(var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLCurrency; overload;
       {$ELSE}
       /// <summary>
       ///   Links the edit control to an OLCurrency variable for two-way data binding.
       /// </summary>
       function Link(var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLCurrency; overload;
       {$IFEND}
       {$IF CompilerVersion >= 34.0}
       /// <summary>
       ///   Links the edit control to an OLString variable for two-way data binding with validation.
       /// </summary>
       function Link(var s: OLString): TEditToOLString; overload;
       {$ELSE}
       /// <summary>
       ///   Links the edit control to an OLString variable for two-way data binding.
       /// </summary>
       function Link(var s: OLString): TEditToOLString; overload;
        {$IFEND}
         {$IF CompilerVersion >= 34.0}
         /// <summary>
         ///   Checks if the edit control has a valid value.
         /// </summary>
         function IsValid: Boolean;
         /// <summary>
         ///   Shows the validation state based on current control value.
         /// </summary>
         procedure ShowValidationState;
         {$IFEND}
       {$IF CompilerVersion >= 34.0}
       /// <summary>
       ///   Links the edit control to an OLDate variable for two-way data binding with validation.
       /// </summary>
       function Link(var d: OLDate; const Alignment: TAlignment=taRightJustify): TEditToOLDate; overload;
       {$ELSE}
       /// <summary>
       ///   Links the edit control to an OLDate variable for two-way data binding.
       /// </summary>
       function Link(var d: OLDate; const Alignment: TAlignment=taRightJustify): TEditToOLDate; overload;
       {$IFEND}
     end;

   /// <summary>
   ///   Helper class for TSpinEdit to enable data binding with OL types.
   /// </summary>
    TOLSpinEditHelper = class helper for TSpinEdit
       {$IF CompilerVersion >= 34.0}
       /// <summary>
       ///   Links the spin edit control to an OLInteger variable for two-way data binding with validation.
       /// </summary>
       function Link(var i: OLInteger): TSpinEditToOLInteger; overload;
       /// <summary>
       ///   Checks if the spin edit control has a valid value.
       /// </summary>
       function IsValid: Boolean;
       /// <summary>
       ///   Shows the validation state based on current control value.
       /// </summary>
       procedure ShowValidationState;
       {$ELSE}
      /// <summary>
      ///   Links the spin edit control to an OLInteger variable for two-way data binding.
      /// </summary>
      function Link(var i: OLInteger): TSpinEditToOLInteger; overload;
      {$IFEND}
    end;

   /// <summary>
   ///   Helper class for TTrackBar to enable data binding with OL types.
   /// </summary>
    TOLTrackBarHelper = class helper for TTrackBar
      {$IF CompilerVersion >= 34.0}
      /// <summary>
      ///   Links the track bar control to an OLInteger variable for two-way data binding with validation.
      /// </summary>
       function Link(var i: OLInteger): TTrackBarToOLInteger; overload;
       /// <summary>
       ///   Checks if the track bar control has a valid value.
       /// </summary>
       function IsValid: Boolean;
       /// <summary>
       ///   Shows the validation state based on current control value.
       /// </summary>
       procedure ShowValidationState;
      {$ELSE}
      /// <summary>
      ///   Links the track bar control to an OLInteger variable for two-way data binding.
      /// </summary>
      function Link(var i: OLInteger): TTrackBarToOLInteger; overload;
      {$IFEND}
    end;

   /// <summary>
   ///   Helper class for TScrollBar to enable data binding with OL types.
   /// </summary>
    TOLScrollBarHelper = class helper for TScrollBar
       {$IF CompilerVersion >= 34.0}
       /// <summary>
       ///   Links the scroll bar control to an OLInteger variable for two-way data binding with validation.
       /// </summary>
       function Link(var i: OLInteger): TScrollBarToOLInteger; overload;
       /// <summary>
       ///   Checks if the scroll bar control has a valid value.
       /// </summary>
       function IsValid: Boolean;
       /// <summary>
       ///   Shows the validation state based on current control value.
       /// </summary>
       procedure ShowValidationState;
       {$ELSE}
      /// <summary>
      ///   Links the scroll bar control to an OLInteger variable for two-way data binding.
      /// </summary>
      function Link(var i: OLInteger): TScrollBarToOLInteger; overload;
      {$IFEND}
    end;

   /// <summary>
   ///   Helper class for TMemo to enable data binding with OL types.
   /// </summary>
    TOLMemoHelper = class helper for TMemo
      {$IF CompilerVersion >= 34.0}
      /// <summary>
      ///   Links the memo control to an OLString variable for two-way data binding with validation.
      /// </summary>
      function Link(var s: OLString): TMemoToOLString; overload;
      {$ELSE}
      /// <summary>
      ///   Links the memo control to an OLString variable for two-way data binding.
      /// </summary>
        function Link(var s: OLString): TMemoToOLString; overload;
        {$IFEND}
        {$IF CompilerVersion >= 34.0}
        /// <summary>
        ///   Checks if the memo control has a valid value.
        /// </summary>
        function IsValid: Boolean;
        /// <summary>
        ///   Shows the validation state based on current control value.
        /// </summary>
        procedure ShowValidationState;
        {$IFEND}
     end;

   /// <summary>
   ///   Helper class for TDateTimePicker to enable data binding with OL types.
   /// </summary>
   TOLDateTimePickerHelper = class helper for TDateTimePicker
     {$IF CompilerVersion >= 34.0}
     /// <summary>
     ///   Links the date/time picker control to an OLDate variable for two-way data binding with validation.
     /// </summary>
     function Link(var d: OLDate): TDateTimePickerToOLDate; overload;
      /// <summary>
      ///   Links the date/time picker control to an OLDateTime variable for two-way data binding with validation.
      /// </summary>
      function Link(var d: OLDateTime): TDateTimePickerToOLDateTime; overload;
      /// <summary>
      ///   Checks if the date/time picker control has a valid value.
      /// </summary>
      function IsValid: Boolean;
      /// <summary>
      ///   Shows the validation state based on current control value.
      /// </summary>
      procedure ShowValidationState;
      {$ELSE}
     /// <summary>
     ///   Links the date/time picker control to an OLDate variable for two-way data binding.
     /// </summary>
     function Link(var d: OLDate): TDateTimePickerToOLDate; overload;
     /// <summary>
     ///   Links the date/time picker control to an OLDateTime variable for two-way data binding.
     /// </summary>
     function Link(var d: OLDateTime): TDateTimePickerToOLDateTime; overload;
     {$IFEND}
   end;

   /// <summary>
   ///   Helper class for TCheckBox to enable data binding with OL types.
   /// </summary>
   TOLCheckBoxHelper = class helper for TCheckBox
     {$IF CompilerVersion >= 34.0}
     /// <summary>
     ///   Links the checkbox control to an OLBoolean variable for two-way data binding with validation.
     /// </summary>
       function Link(var b: OLBoolean; AllowGrayed: Boolean = False): TCheckBoxToOLBoolean;
       /// <summary>
       ///   Checks if the checkbox control has a valid value.
       /// </summary>
       function IsValid: Boolean;
       /// <summary>
       ///   Shows the validation state based on current control value.
       /// </summary>
       procedure ShowValidationState;
      {$ELSE}
     /// <summary>
     ///   Links the checkbox control to an OLBoolean variable for two-way data binding.
     /// </summary>
        function Link(var b: OLBoolean; AllowGrayed: Boolean = False): TCheckBoxToOLBoolean;
     {$IFEND}
   end;

   /// <summary>
   ///   Helper class for TLabel to enable data binding with OL types.
   /// </summary>
    TOLLabelHelper = class helper for TLabel
      {$IF CompilerVersion >= 34.0}
      /// <summary>
      ///   Links the label control to an OLInteger variable for one-way data binding (display only) with validation.
      /// </summary>
       function Link(var i: OLInteger): TOLIntegerToLabel; overload;
      {$ELSE}
      /// <summary>
      ///   Links the label control to an OLInteger variable for one-way data binding (display only).
      /// </summary>
      function Link(var i: OLInteger): TOLIntegerToLabel; overload;
      {$IFEND}
     /// <summary>
     ///   Links the label control to a function that returns OLInteger for computed display.
     /// </summary>
     function Link(const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string = ERROR_STRING): TOLIntegerToLabel; overload;
     {$IF CompilerVersion >= 34.0}
      /// <summary>
      ///   Links the label control to an OLString variable for one-way data binding (display only) with validation.
      /// </summary>
       function Link(var s: OLString): TOLStringToLabel; overload;
      {$ELSE}
      /// <summary>
      ///   Links the label control to an OLString variable for one-way data binding (display only).
      /// </summary>
      function Link(var s: OLString): TOLStringToLabel; overload;
      {$IFEND}
     /// <summary>
     ///   Links the label control to a function that returns OLString for computed display.
     /// </summary>
     function Link(const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string = ERROR_STRING): TOLStringToLabel; overload;
     {$IF CompilerVersion >= 34.0}
      /// <summary>
      ///   Links the label control to an OLDouble variable for one-way data binding (display only) with validation.
      /// </summary>
       function Link(var d: OLDouble; const Format: string = DOUBLE_FORMAT): TOLDoubleToLabel; overload;
      {$ELSE}
      /// <summary>
      ///   Links the label control to an OLDouble variable for one-way data binding (display only).
      /// </summary>
      function Link(var d: OLDouble; const Format: string = DOUBLE_FORMAT): TOLDoubleToLabel; overload;
      {$IFEND}
      /// <summary>
      ///   Links the label control to a function that returns OLDouble for computed display.
      /// </summary>
      function Link(const f: TFunctionReturningOLDouble; const Format: string = DOUBLE_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING): TOLDoubleToLabel; overload;
      {$IF CompilerVersion >= 34.0}
      /// <summary>
      ///   Links the label control to an OLCurrency variable for one-way data binding (display only) with validation.
      /// </summary>
       function Link(var curr: OLCurrency; const Format: string = CURRENCY_FORMAT): TOLCurrencyToLabel; overload;
      {$ELSE}
      /// <summary>
      ///   Links the label control to an OLCurrency variable for one-way data binding (display only).
      /// </summary>
      function Link(var curr: OLCurrency; const Format: string = CURRENCY_FORMAT): TOLCurrencyToLabel; overload;
      {$IFEND}
     /// <summary>
     ///   Links the label control to a function that returns OLCurrency for computed display.
     /// </summary>
     function Link(const f: TFunctionReturningOLCurrency; const Format: string = CURRENCY_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING): TOLCurrencyToLabel; overload;
     /// <summary>
     ///   Links the label control to an OLDate variable for one-way data binding (display only).
     /// </summary>
     {$IF CompilerVersion >= 34.0}
      function Link(var d: OLDate): TOLDateToLabel; overload;
     {$ELSE}
     function Link(var d: OLDate): TOLDateToLabel; overload;
     {$IFEND}
     /// <summary>
     ///   Links the label control to a function that returns OLDate for computed display.
     /// </summary>
     function Link(const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string = ERROR_STRING): TOLDateToLabel; overload;
     /// <summary>
     ///   Links the label control to an OLDateTime variable for one-way data binding (display only).
     /// </summary>
     {$IF CompilerVersion >= 34.0}
      function Link(var d: OLDateTime): TOLDateTimeToLabel; overload;
     {$ELSE}
     function Link(var d: OLDateTime): TOLDateTimeToLabel; overload;
     {$IFEND}
      /// <summary>
      ///   Links the label control to a function that returns OLDateTime for computed display.
      /// </summary>
      function Link(const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string = ERROR_STRING): TOLDateTimeToLabel; overload;
      {$IF CompilerVersion >= 34.0}
      /// <summary>
      ///   Returns true if the control is valid according to its validation function, or if not linked or no validation function is set.
      /// </summary>
      function IsValid: Boolean;
      /// <summary>
      ///   Shows the validation state based on current control value.
      /// </summary>
      procedure ShowValidationState;
      {$IFEND}
    end;

   /// <summary>
   ///   Helper class for TForm to check if variables are form fields and all controls on the form are valid
   /// </summary>
   TOLFormHelper = class helper for TForm
   private
     function IsFieldOfRecord(const ctx: TRttiContext; ATypeInfo: PTypeInfo;
         DataPtr: Pointer; ParamPtr: Pointer): Boolean;
     procedure CollectAllControls(AControl: TControl; var Controls: TList<TControl>);
   public
     {$IF CompilerVersion >= 34.0}
     /// <summary>
     ///   Checks if the form is valid (all controls on the form are valid).
     /// </summary>
     function IsValid: Boolean;
      /// <summary>
      ///   Shows the validation state based on current control value.
      /// </summary>
      procedure ShowValidationState;
      {$IFEND}
     /// <summary>
     ///   Checks if the specified variable is a field of this form.
     /// </summary>
     function IsMyField(var X): Boolean;
   end;

implementation

uses Math,
    {$IF CompilerVersion >= 23.0}
        System.Character, IntegerHelperFunctions, StringHelperFunctions,
        BooleanHelperFunctions, CurrencyHelperFunctions, DoubleHelperFunctions, Int64HelperFunctions;
    {$ELSE}
        Character;
    {$IFEND}

function GetFieldAddressHack(f: TRttiField; Instance: Pointer): Pointer;
begin
  Result := PByte(Instance) + TRttiFieldHack(f).Offset;
end;

function OLType(b: System.Boolean): OLBoolean;
begin
  Result := b;
end;

function OLType(c: System.Currency): OLCurrency;
begin
  Result := c;
end;

function OLType(d: System.TDateTime): OLDateTime;
begin
  Result := d;
end;

function OLType(d: System.TDate): OLDate;
begin
  Result := d;
end;

function OLType(d: System.Double): OLDouble;
begin
  Result := d;
end;

function OLType(d: System.Extended): OLDouble; overload;
begin
  Result := d;
end;

function OLType(i: System.Integer): OLInteger;
begin
  Result := i;
end;

function OLType(i: System.Int64): OLInt64;
begin
  Result := i;
end;

function OLType(s: System.string): OLString;
begin
  Result := s;
end;



procedure TOLFormHelper.CollectAllControls(AControl: TControl; var
    Controls: TList<TControl>);
var
  i: Integer;
begin
  Controls.Add(AControl);
  if AControl is TWinControl then
  begin
    for i := 0 to TWinControl(AControl).ControlCount - 1 do
      CollectAllControls(TWinControl(AControl).Controls[i], Controls);
  end;
end;

{ TOLFormHelper }

function TOLFormHelper.IsFieldOfRecord(const ctx: TRttiContext; ATypeInfo: PTypeInfo; DataPtr: Pointer; ParamPtr: Pointer): Boolean;
var
  RType: TRttiType;
  RecType: TRttiStructuredType;
  f: TRttiField;
  FieldAddr: Pointer;
  TK: TTypeKind;
begin
  Result := False;

  // Get RTTI type and ensure it is a structured type (record)
  RType := ctx.GetType(ATypeInfo);
  if not (RType is TRttiStructuredType) then
    Exit;

  RecType := TRttiStructuredType(RType);

  for f in RecType.GetFields do
  begin
    // Calculate the actual memory address of the field
    FieldAddr := Pointer(NativeInt(DataPtr) + f.Offset);

    // 1. Check if the pointer matches the field address
    if FieldAddr = ParamPtr then
      Exit(True);

    // 2. Check for nested records
    TK := f.FieldType.TypeKind;

    {$IF CompilerVersion >= 34.0}
    if (TK = tkRecord) or (TK = tkMRecord) then
    {$ELSE}
    if TK = tkRecord then
    {$IFEND}
    begin
      // Recurse using the actual field address to keep pointer consistency
      if IsFieldOfRecord(ctx, f.FieldType.Handle, FieldAddr, ParamPtr) then
        Exit(True);
    end;
  end;
end;


function TOLFormHelper.IsMyField(var X): Boolean;
var
  ctx: TRttiContext;
  t: TRttiType;
  f: TRttiField;
  ParamPtr: Pointer;
  FieldAddr: Pointer;
  TK: TTypeKind;
begin
  Result := False;
  ParamPtr := @X;

  t := ctx.GetType(Self.ClassType);
  if t = nil then
    Exit(False);

  for f in t.GetFields do
  begin
    // Calculate the absolute memory address of the field within the object instance
    FieldAddr := Pointer(NativeInt(Self) + f.Offset);

    // 1. Compare direct field address
    if FieldAddr = ParamPtr then
      Exit(True);

    // 2. Recurse into record fields if necessary
    TK := f.FieldType.TypeKind;

    {$IF CompilerVersion >= 34.0}
    if (TK = tkRecord) or (TK = tkMRecord) then
    {$ELSE}
    if TK = tkRecord then
    {$IFEND}
    begin
      // Use the corrected function passing the exact memory address (FieldAddr)
      // to avoid data copying via TValue
      if IsFieldOfRecord(ctx, f.FieldType.Handle, FieldAddr, ParamPtr) then
        Exit(True);
    end;
  end;
end;

 {$IF CompilerVersion >= 34.0}
function TOLFormHelper.IsValid: Boolean;
var
  Controls: TList<TControl>;
  Control: TControl;
  Link: TOLControlLink;

  i: Integer;
  d: Double;
  curr: Currency;
  s: OLString;
  fs: TFormatSettings;
  CleanS: string;
begin
  Result := True;
  Controls := TList<TControl>.Create;
  try
    CollectAllControls(Self, Controls);
    for Control in Controls do
    begin
      Link := Links.GetLinkForControl(Control);
      if Assigned(Link) then
      begin
        if Link.Control is TLabel then
          Result := TLabel(Link.Control).IsValid;

        if Link.Control is TEdit then
          Result := TEdit(Link.Control).IsValid;

        if Link.Control is TTrackBar then
          Result := TTrackBar(Link.Control).IsValid;

        if Link.Control is TScrollBar then
          Result := TScrollBar(Link.Control).IsValid;

        if Link.Control is TSpinEdit then
          Result := TSpinEdit(Link.Control).IsValid;

        if Link.Control is TMemo then
          Result := TMemo(Link.Control).IsValid;

        if Link.Control is TDateTimePicker then
          Result := TDateTimePicker(Link.Control).IsValid;

        if Link.Control is TCheckBox then
          Result := TCheckBox(Link.Control).IsValid;

        if not Result then
          Exit;

      end;
    end;
  finally
    Controls.Free;
  end;
end;

procedure TOLFormHelper.ShowValidationState;
var
  Controls: TList<TControl>;
  Control: TControl;
  Link: TOLControlLink;

  i: Integer;
  d: Double;
  curr: Currency;
  s: OLString;
  fs: TFormatSettings;
  CleanS: string;
begin
  Controls := TList<TControl>.Create;
  try
    CollectAllControls(Self, Controls);
    for Control in Controls do
    begin
      Link := Links.GetLinkForControl(Control);
      if Assigned(Link) then
      begin
        if Link.Control is TLabel then
          TLabel(Link.Control).ShowValidationState;

        if Link.Control is TEdit then
          TEdit(Link.Control).ShowValidationState;

        if Link.Control is TTrackBar then
          TTrackBar(Link.Control).ShowValidationState;

        if Link.Control is TScrollBar then
          TScrollBar(Link.Control).ShowValidationState;

        if Link.Control is TSpinEdit then
          TSpinEdit(Link.Control).ShowValidationState;

        if Link.Control is TMemo then
          TMemo(Link.Control).ShowValidationState;

        if Link.Control is TDateTimePicker then
          TDateTimePicker(Link.Control).ShowValidationState;

        if Link.Control is TCheckBox then
          TCheckBox(Link.Control).ShowValidationState;
      end;
    end;
  finally
    Controls.Free;
  end;
end;
{$IFEND}

{ TOLEditHelper }

{$IF CompilerVersion >= 34.0}
function TOLEditHelper.Link(var i: OLInteger; const Alignment:
    TAlignment=taRightJustify): TEditToOLInteger;
{$ELSE}
function TOLEditHelper.Link(var i: OLInteger; const Alignment:
    TAlignment=taRightJustify): TEditToOLInteger;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(i) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

    try
      {$IF CompilerVersion >= 34.0}
      Result := Links.Link(Self, i, Alignment);
      {$ELSE}
      Result := Links.Link(Self, i, Alignment);
      {$IFEND}
    except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;


{$IF CompilerVersion >= 34.0}
function TOLEditHelper.Link(var d: OLDouble; const Format: string =
    DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLDouble;
{$ELSE}
function TOLEditHelper.Link(var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLDouble;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(d) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

    try
      {$IF CompilerVersion >= 34.0}
      Result := Links.Link(Self, d, Format, Alignment);
      {$ELSE}
      Result := Links.Link(Self, d, Format, Alignment);
      {$IFEND}
    except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;


{$IF CompilerVersion >= 34.0}
function TOLEditHelper.Link(var curr: OLCurrency; const Format: string =
    CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify):
    TEditToOLCurrency;
{$ELSE}
function TOLEditHelper.Link(var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLCurrency;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(curr) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

    try
      {$IF CompilerVersion >= 34.0}
      Result := Links.Link(Self, curr, Format, Alignment);
      {$ELSE}
      Result := Links.Link(Self, curr, Format, Alignment);
      {$IFEND}
    except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;

{$IF CompilerVersion >= 34.0}
function TOLEditHelper.Link(var s: OLString): TEditToOLString;
{$ELSE}
function TOLEditHelper.Link(var s: OLString): TEditToOLString;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(s) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     {$IF CompilerVersion >= 34.0}
     Result := Links.Link(Self, s);
     {$ELSE}
     Result := Links.Link(Self, s);
     {$IFEND}
   except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
    end;
  end;

{$IF CompilerVersion >= 34.0}
function TOLEditHelper.Link(var d: OLDate; const Alignment: TAlignment=taRightJustify): TEditToOLDate;
{$ELSE}
function TOLEditHelper.Link(var d: OLDate; const Alignment: TAlignment=taRightJustify): TEditToOLDate;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(d) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     {$IF CompilerVersion >= 34.0}
     Result := Links.Link(Self, d, Alignment);
     {$ELSE}
     Result := Links.Link(Self, d, Alignment);
     {$IFEND}
   except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
    end;
  end;

{$IF CompilerVersion >= 34.0}
function TOLEditHelper.IsValid: Boolean;
var
  Link: TOLControlLink;
  i: Integer;
  d: Double;
  curr: Currency;
  s: OLString;
  fs: TFormatSettings;
  CleanS: string;
  dVal: TDate;
begin
  Link := Links.GetLinkForControl(Self);
  if not Assigned(Link) then
  begin
    Result := True;
    Exit;
  end;

  if Link is TEditToOLInteger then
  begin
    if TryStrToInt(TEditToOLInteger(Link).Edit.Text, i) then
      Result := TEditToOLInteger(Link).ValueIsValid(i).Valid
    else
      Result := False;
  end
  else if Link is TEditToOLDouble then
  begin
    fs := FormatSettings;
    s := TEditToOLDouble(Link).Edit.Text;
    CleanS := OLType(s).Replaced(fs.ThousandSeparator, '');
    if TryStrToFloat(CleanS, d) then
      Result := TEditToOLDouble(Link).ValueIsValid(d).Valid
    else
      Result := False;
  end
  else if Link is TEditToOLCurrency then
  begin
    fs := FormatSettings;
    s := TEditToOLCurrency(Link).Edit.Text;
    CleanS := s.Replaced(fs.ThousandSeparator, '');
    if TryStrToCurr(CleanS, curr) then
      Result := TEditToOLCurrency(Link).ValueIsValid(curr).Valid
    else
      Result := False;
  end
  else if Link is TEditToOLString then
  begin
    Result := TEditToOLString(Link).ValueIsValid(OLString(TEditToOLString(Link).Edit.Text)).Valid;
  end
  else if Link is TEditToOLDate then
  begin
    if TrySmartStrToDate(TEditToOLDate(Link).Edit.Text, dVal) then
      Result := TEditToOLDate(Link).ValueIsValid(dVal).Valid
    else
      Result := False;
  end
  else
    Result := True; // Fallback
end;

procedure TOLEditHelper.ShowValidationState;
var
  Link: TOLControlLink;
  i: Integer;
  d: Double;
  curr: Currency;
  s: OLString;
  fs: TFormatSettings;
  CleanS: string;
begin
  Link := Links.GetLinkForControl(Self);
  if not Assigned(Link) then Exit;

  if Link is TEditToOLInteger then
  begin
    if TryStrToInt(TEditToOLInteger(Link).Edit.Text, i) then
      Link.ShowValidationState(TEditToOLInteger(Link).ValueIsValid(i))
    else
      Link.ShowValidationState(TOLValidationResult.Error('Invalid Value'));
  end
  else if Link is TEditToOLDouble then
  begin
    fs := FormatSettings;
    s := TEditToOLDouble(Link).Edit.Text;
    CleanS := OLType(s).Replaced(fs.ThousandSeparator, '');
    if TryStrToFloat(CleanS, d) then
      Link.ShowValidationState(TEditToOLDouble(Link).ValueIsValid(d))
    else
      Link.ShowValidationState(TOLValidationResult.Error('Invalid Value'));
  end
  else if Link is TEditToOLCurrency then
  begin
    fs := FormatSettings;
    s := TEditToOLCurrency(Link).Edit.Text;
    CleanS := s.Replaced(fs.ThousandSeparator, '');
    if TryStrToCurr(CleanS, curr) then
      Link.ShowValidationState(TEditToOLCurrency(Link).ValueIsValid(curr))
    else
      Link.ShowValidationState(TOLValidationResult.Error('Invalid Value'));
  end
  else if Link is TEditToOLString then
  begin
    Link.ShowValidationState(TEditToOLString(Link).ValueIsValid(OLString(TEditToOLString(Link).Edit.Text)));
  end;
end;
{$IFEND}

 {$IF CompilerVersion >= 34.0}
 function TOLSpinEditHelper.Link(var i: OLInteger): TSpinEditToOLInteger;
{$ELSE}
function TOLSpinEditHelper.Link(var i: OLInteger): TSpinEditToOLInteger;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

    if not Form.IsMyField(i) then
      raise Exception.Create('OLType must be a field of the owning TForm.');

    try
      {$IF CompilerVersion >= 34.0}
      Result := Links.Link(Self, i);
      {$ELSE}
      Result := Links.Link(Self, i);
      {$IFEND}
    except
      on E: Exception do
        raise Exception.Create('Link failed for TSpinEdit: ' + E.Message);
    end;
end;

{$IF CompilerVersion >= 34.0}
function TOLSpinEditHelper.IsValid: Boolean;
var
  Link: TOLControlLink;
begin
  Link := Links.GetLinkForControl(Self);
  if Assigned(Link) then
    Result := TSpinEditToOLInteger(Link).ValueIsValid(TSpinEditToOLInteger(Link).Edit.Value).Valid
  else
    Result := True;
end;

procedure TOLSpinEditHelper.ShowValidationState;
var
  Link: TOLControlLink;
begin
  Link := Links.GetLinkForControl(Self);
  if Assigned(Link) and (Link is TSpinEditToOLInteger) then
    Link.ShowValidationState(TSpinEditToOLInteger(Link).ValueIsValid(TSpinEditToOLInteger(Link).Edit.Value));
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TOLTrackBarHelper.Link(var i: OLInteger): TTrackBarToOLInteger;
{$ELSE}
function TOLTrackBarHelper.Link(var i: OLInteger): TTrackBarToOLInteger;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

    if not Form.IsMyField(i) then
      raise Exception.Create('OLType must be a field of the owning TForm.');

    try
      {$IF CompilerVersion >= 34.0}
      Result := Links.Link(Self, i);
      {$ELSE}
      Result := Links.Link(Self, i);
      {$IFEND}
    except
      on E: Exception do
        raise Exception.Create('Link failed for TTrackBar: ' + E.Message);
    end;
end;
 
{$IF CompilerVersion >= 34.0}
function TOLTrackBarHelper.IsValid: Boolean;
var
  Link: TOLControlLink;
begin
  Link := Links.GetLinkForControl(Self);
  if Assigned(Link) then
    Result := TTrackBarToOLInteger(Link).ValueIsValid(TTrackBarToOLInteger(Link).Edit.Position).Valid
  else
    Result := True;
end;

procedure TOLTrackBarHelper.ShowValidationState;
var
  Link: TOLControlLink;
begin
  Link := Links.GetLinkForControl(Self);
  if Assigned(Link) and (Link is TTrackBarToOLInteger) then
    Link.ShowValidationState(TTrackBarToOLInteger(Link).ValueIsValid(TTrackBarToOLInteger(Link).Edit.Position));
end;
{$IFEND}
 
{$IF CompilerVersion >= 34.0}
function TOLScrollBarHelper.Link(var i: OLInteger): TScrollBarToOLInteger;
{$ELSE}
function TOLScrollBarHelper.Link(var i: OLInteger): TScrollBarToOLInteger;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(i) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

    try
      {$IF CompilerVersion >= 34.0}
      Result := Links.Link(Self, i);
      {$ELSE}
      Result := Links.Link(Self, i);
      {$IFEND}
    except
      on E: Exception do
        raise Exception.Create('Link failed for TScrollBar: ' + E.Message);
    end;
end;

{$IF CompilerVersion >= 34.0}
function TOLScrollBarHelper.IsValid: Boolean;
var
  Link: TOLControlLink;
begin
  Link := Links.GetLinkForControl(Self);
  if Assigned(Link) then
    Result := TScrollBarToOLInteger(Link).ValueIsValid(TScrollBarToOLInteger(Link).Edit.Position).Valid
  else
    Result := True;
end;

procedure TOLScrollBarHelper.ShowValidationState;
var
  Link: TOLControlLink;
begin
  Link := Links.GetLinkForControl(Self);
  if Assigned(Link) and (Link is TScrollBarToOLInteger) then
     Link.ShowValidationState(TScrollBarToOLInteger(Link).ValueIsValid(TScrollBarToOLInteger(Link).Edit.Position));
end;
{$IFEND}

{ TOLMemoHelper }

{$IF CompilerVersion >= 34.0}
function TOLMemoHelper.Link(var s: OLString): TMemoToOLString;
{$ELSE}
function TOLMemoHelper.Link(var s: OLString): TMemoToOLString;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

    if not Form.IsMyField(s) then
      raise Exception.Create('OLType must be a field of the owning TForm.');

    try
      {$IF CompilerVersion >= 34.0}
      Result := Links.Link(Self, s);
      {$ELSE}
      Result := Links.Link(Self, s);
      {$IFEND}
    except
     on E: Exception do
        raise Exception.Create('Link failed for TMemo: ' + E.Message);
    end;
 end;

{$IF CompilerVersion >= 34.0}
function TOLMemoHelper.IsValid: Boolean;
var
  Link: TOLControlLink;
begin
  Link := Links.GetLinkForControl(Self);
  if Assigned(Link) then
    Result := TMemoToOLString(Link).ValueIsValid(OLString(TMemoToOLString(Link).Edit.Text)).Valid
  else
    Result := True;
end;

procedure TOLMemoHelper.ShowValidationState;
var
  Link: TOLControlLink;
begin
  Link := Links.GetLinkForControl(Self);
  if Assigned(Link) and (Link is TMemoToOLString) then
     Link.ShowValidationState(TMemoToOLString(Link).ValueIsValid(OLString(TMemoToOLString(Link).Edit.Text)));
end;
{$IFEND}


 { TOLDateTimePickerHelper }

{$IF CompilerVersion >= 34.0}
function TOLDateTimePickerHelper.Link(var d: OLDate): TDateTimePickerToOLDate;
{$ELSE}
function TOLDateTimePickerHelper.Link(var d: OLDate): TDateTimePickerToOLDate;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(d) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     {$IF CompilerVersion >= 34.0}
     Result := Links.Link(Self, d);
     {$ELSE}
     Result := Links.Link(Self, d);
     {$IFEND}
   except
     on E: Exception do
       raise Exception.Create('Link failed for TDateTimePicker: ' + E.Message);
   end;
end;

{$IF CompilerVersion >= 34.0}
function TOLDateTimePickerHelper.Link(var d: OLDateTime): TDateTimePickerToOLDateTime;
{$ELSE}
function TOLDateTimePickerHelper.Link(var d: OLDateTime): TDateTimePickerToOLDateTime;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(d) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     {$IF CompilerVersion >= 34.0}
     Result := Links.Link(Self, d);
     {$ELSE}
     Result := Links.Link(Self, d);
     {$IFEND}
    except
      on E: Exception do
        raise Exception.Create('Link failed for TDateTimePicker: ' + E.Message);
    end;
 end;

{$IF CompilerVersion >= 34.0}
function TOLDateTimePickerHelper.IsValid: Boolean;
var
  Link: TOLControlLink;
begin
  Link := Links.GetLinkForControl(Self);
  if not Assigned(Link) then
  begin
    Result := True;
    Exit;
  end;

  if Link is TDateTimePickerToOLDate then
    Result := TDateTimePickerToOLDate(Link).ValueIsValid(OLDate(TDateTimePickerToOLDate(Link).Edit.Date)).Valid
  else if Link is TDateTimePickerToOLDateTime then
    Result := TDateTimePickerToOLDateTime(Link).ValueIsValid(OLDateTime(TDateTimePickerToOLDateTime(Link).Edit.DateTime)).Valid
  else
    Result := True;
end;

procedure TOLDateTimePickerHelper.ShowValidationState;
var
  Link: TOLControlLink;
begin
  Link := Links.GetLinkForControl(Self);
  if not Assigned(Link) then Exit;

  if Link is TDateTimePickerToOLDate then
    Link.ShowValidationState(TDateTimePickerToOLDate(Link).ValueIsValid(OLDate(TDateTimePickerToOLDate(Link).Edit.Date)))
  else if Link is TDateTimePickerToOLDateTime then
    Link.ShowValidationState(TDateTimePickerToOLDateTime(Link).ValueIsValid(OLDateTime(TDateTimePickerToOLDateTime(Link).Edit.DateTime)));
end;
{$IFEND}

 { TOLCheckBoxHelper }
{$IF CompilerVersion >= 34.0}
function TOLCheckBoxHelper.Link(var b: OLBoolean; AllowGrayed: Boolean = False): TCheckBoxToOLBoolean;
{$ELSE}
function TOLCheckBoxHelper.Link(var b: OLBoolean; AllowGrayed: Boolean = False): TCheckBoxToOLBoolean;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(b) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     {$IF CompilerVersion >= 34.0}
     Result := Links.Link(Self, b, AllowGrayed);
     {$ELSE}
     Result := Links.Link(Self, b, AllowGrayed);
     {$IFEND}
   except
     on E: Exception do
       raise Exception.Create('Link failed for TCheckBox: ' + E.Message);
    end;
 end;

{$IF CompilerVersion >= 34.0}
function TOLCheckBoxHelper.IsValid: Boolean;
var
  Link: TOLControlLink;
begin
  Link := Links.GetLinkForControl(Self);
  if Assigned(Link) then
    Result := TCheckBoxToOLBoolean(Link).ValueIsValid(OLBoolean(TCheckBoxToOLBoolean(Link).Edit.Checked)).Valid
  else
    Result := True;
end;

procedure TOLCheckBoxHelper.ShowValidationState;
var
  Link: TOLControlLink;
begin
  Link := Links.GetLinkForControl(Self);
  if Assigned(Link) and (Link is TCheckBoxToOLBoolean) then
    Link.ShowValidationState(TCheckBoxToOLBoolean(Link).ValueIsValid(OLBoolean(TCheckBoxToOLBoolean(Link).Edit.Checked)));
end;
{$IFEND}

 {$IF CompilerVersion >= 34.0}
 function TOLLabelHelper.Link(var i: OLInteger): TOLIntegerToLabel;
{$ELSE}
function TOLLabelHelper.Link(var i: OLInteger): TOLIntegerToLabel;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(i) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     {$IF CompilerVersion >= 34.0}
     Result := Links.Link(Self, i);
     {$ELSE}
     Result := Links.Link(Self, i);
     {$IFEND}
   except
     on E: Exception do
       raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

function TOLLabelHelper.Link(const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string): TOLIntegerToLabel;
begin
   Result := Links.Link(Self, f, ValueOnErrorInCalculation);
end;

{$IF CompilerVersion >= 34.0}
function TOLLabelHelper.Link(var s: OLString): TOLStringToLabel;
{$ELSE}
function TOLLabelHelper.Link(var s: OLString): TOLStringToLabel;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(s) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     {$IF CompilerVersion >= 34.0}
     Result := Links.Link(Self, s);
     {$ELSE}
     Result := Links.Link(Self, s);
     {$IFEND}
   except
     on E: Exception do
       raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

function TOLLabelHelper.Link(const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string): TOLStringToLabel;
begin
   Result := Links.Link(Self, f, ValueOnErrorInCalculation);
end;

{$IF CompilerVersion >= 34.0}
function TOLLabelHelper.Link(var d: OLDouble; const Format: string = DOUBLE_FORMAT): TOLDoubleToLabel;
{$ELSE}
function TOLLabelHelper.Link(var d: OLDouble; const Format: string = DOUBLE_FORMAT): TOLDoubleToLabel;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(d) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

    try
      {$IF CompilerVersion >= 34.0}
      Result := Links.Link(Self, d, Format);
      {$ELSE}
      Result := Links.Link(Self, d, Format);
      {$IFEND}
    except
      on E: Exception do
        raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

function TOLLabelHelper.Link(const f: TFunctionReturningOLDouble; const Format: string; const ValueOnErrorInCalculation: string): TOLDoubleToLabel;
begin
   Result := Links.Link(Self, f, Format, ValueOnErrorInCalculation);
end;

{$IF CompilerVersion >= 34.0}
function TOLLabelHelper.Link(var curr: OLCurrency; const Format: string = CURRENCY_FORMAT): TOLCurrencyToLabel;
{$ELSE}
function TOLLabelHelper.Link(var curr: OLCurrency; const Format: string = CURRENCY_FORMAT): TOLCurrencyToLabel;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(curr) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

    try
      {$IF CompilerVersion >= 34.0}
      Result := Links.Link(Self, curr, Format);
      {$ELSE}
      Result := Links.Link(Self, curr, Format);
      {$IFEND}
    except
      on E: Exception do
        raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

function TOLLabelHelper.Link(const f: TFunctionReturningOLCurrency; const Format: string; const ValueOnErrorInCalculation: string): TOLCurrencyToLabel;
begin
   Result := Links.Link(Self, f, Format, ValueOnErrorInCalculation);
end;

{$IF CompilerVersion >= 34.0}
function TOLLabelHelper.Link(var d: OLDate): TOLDateToLabel;
{$ELSE}
function TOLLabelHelper.Link(var d: OLDate): TOLDateToLabel;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(d) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

    try
      {$IF CompilerVersion >= 34.0}
      Result := Links.Link(Self, d);
      {$ELSE}
      Result := Links.Link(Self, d);
      {$IFEND}
    except
      on E: Exception do
        raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

function TOLLabelHelper.Link(const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string): TOLDateToLabel;
begin
   Result := Links.Link(Self, f, ValueOnErrorInCalculation);
end;

{$IF CompilerVersion >= 34.0}
function TOLLabelHelper.Link(var d: OLDateTime): TOLDateTimeToLabel;
{$ELSE}
function TOLLabelHelper.Link(var d: OLDateTime): TOLDateTimeToLabel;
{$IFEND}
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');

   if not Form.IsMyField(d) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

    try
      {$IF CompilerVersion >= 34.0}
      Result := Links.Link(Self, d);
      {$ELSE}
      Result := Links.Link(Self, d);
      {$IFEND}
    except
      on E: Exception do
        raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

function TOLLabelHelper.Link(const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string): TOLDateTimeToLabel;
begin
    Result := Links.Link(Self, f, ValueOnErrorInCalculation);
end;

{$IF CompilerVersion >= 34.0}
function TOLLabelHelper.IsValid: Boolean;
var
  Link: TOLControlLink;
  i: Integer;
  d: Double;
  curr: Currency;
  s: OLString;
  fs: TFormatSettings;
  CleanS: string;
begin
  Link := Links.GetLinkForControl(Self);
  if not Assigned(Link) then
  begin
    Result := True;
    Exit;
  end;

  if Link is TOLIntegerToLabel then
  begin
    if TryStrToInt(TOLIntegerToLabel(Link).Lbl.Caption, i) then
      Result := TOLIntegerToLabel(Link).ValueIsValid(i).Valid
    else
      Result := False;
  end
  else if Link is TOLDoubleToLabel then
  begin
    fs := FormatSettings;
    s := TOLDoubleToLabel(Link).Lbl.Caption;
    CleanS := OLType(s).Replaced(fs.ThousandSeparator, '');
    if TryStrToFloat(CleanS, d) then
      Result := TOLDoubleToLabel(Link).ValueIsValid(d).Valid
    else
      Result := False;
  end
  else if Link is TOLCurrencyToLabel then
  begin
    fs := FormatSettings;
    s := TOLCurrencyToLabel(Link).Lbl.Caption;
    CleanS := s.Replaced(fs.ThousandSeparator, '');
    if TryStrToCurr(CleanS, curr) then
      Result := TOLCurrencyToLabel(Link).ValueIsValid(curr).Valid
    else
      Result := False;
  end
  else if Link is TOLStringToLabel then
  begin
    Result := TOLStringToLabel(Link).ValueIsValid(OLString(TOLStringToLabel(Link).lbl.Caption)).Valid;
  end
  else if Link is TOLDateToLabel then
  begin
    if OLString(TOLDateToLabel(Link).lbl.Caption).TryToDate() then
      Result := TOLDateToLabel(Link).ValueIsValid(OLString(TOLDateToLabel(Link).lbl.Caption).ToDate()).Valid
    else
      Result := False;
  end
  else if Link is TOLDateTimeToLabel then
  begin
    if OLString(TOLDateTimeToLabel(Link).lbl.Caption).TryToDateTime() then
      Result := TOLDateTimeToLabel(Link).ValueIsValid(OLString(TOLDateTimeToLabel(Link).lbl.Caption).ToDateTime()).Valid
    else
      Result := False;
  end
  else
    Result := True; // Fallback
end;

procedure TOLLabelHelper.ShowValidationState;
var
  Link: TOLControlLink;
  i: Integer;
  d: Double;
  curr: Currency;
  s: OLString;
  fs: TFormatSettings;
  CleanS: string;
begin
  Link := Links.GetLinkForControl(Self);
  if not Assigned(Link) then Exit;

  if Link is TOLIntegerToLabel then
  begin
    if TryStrToInt(TOLIntegerToLabel(Link).Lbl.Caption, i) then
      Link.ShowValidationState(TOLIntegerToLabel(Link).ValueIsValid(i))
    else
      Link.ShowValidationState(TOLValidationResult.Error('Invalid Value'));
  end
  else if Link is TOLDoubleToLabel then
  begin
    fs := FormatSettings;
    s := TOLDoubleToLabel(Link).Lbl.Caption;
    CleanS := OLType(s).Replaced(fs.ThousandSeparator, '');
    if TryStrToFloat(CleanS, d) then
      Link.ShowValidationState(TOLDoubleToLabel(Link).ValueIsValid(d))
    else
      Link.ShowValidationState(TOLValidationResult.Error('Invalid Value'));
  end
  else if Link is TOLCurrencyToLabel then
  begin
    fs := FormatSettings;
    s := TOLCurrencyToLabel(Link).Lbl.Caption;
    CleanS := s.Replaced(fs.ThousandSeparator, '');
    if TryStrToCurr(CleanS, curr) then
      Link.ShowValidationState(TOLCurrencyToLabel(Link).ValueIsValid(curr))
    else
      Link.ShowValidationState(TOLValidationResult.Error('Invalid Value'));
  end
  else if Link is TOLStringToLabel then
  begin
    Link.ShowValidationState(TOLStringToLabel(Link).ValueIsValid(OLString(TOLStringToLabel(Link).lbl.Caption)));
  end
  else if Link is TOLDateToLabel then
  begin
    if OLString(TOLDateToLabel(Link).lbl.Caption).TryToDate() then
      Link.ShowValidationState(TOLDateToLabel(Link).ValueIsValid(OLString(TOLDateToLabel(Link).lbl.Caption).ToDate()))
    else
      Link.ShowValidationState(TOLValidationResult.Error('Invalid Value'));
  end
  else if Link is TOLDateTimeToLabel then
  begin
    if OLString(TOLDateTimeToLabel(Link).lbl.Caption).TryToDateTime() then
      Link.ShowValidationState(TOLDateTimeToLabel(Link).ValueIsValid(OLString(TOLDateTimeToLabel(Link).lbl.Caption).ToDateTime()))
    else
      Link.ShowValidationState(TOLValidationResult.Error('Invalid Value'));
  end;
end;
{$IFEND}


  {$IF CompilerVersion >= 24.0}

{ TOLIntegerHelper }



function TOLIntegerHelper.IsDividableBy(const i: Integer): Boolean;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.IsDividableBy(i);
end;

function TOLIntegerHelper.IsOdd: Boolean;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.IsOdd();
end;

function TOLIntegerHelper.IsEven: Boolean;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.IsEven();
end;

function TOLIntegerHelper.IsPositive: Boolean;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.IsPositive();
end;

function TOLIntegerHelper.IsNegative: Boolean;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.IsNegative();
end;

function TOLIntegerHelper.IsNonNegative: Boolean;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.IsNonNegative();
end;

function TOLIntegerHelper.IsPrime: Boolean;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.IsPrime();
end;

function TOLIntegerHelper.Sqr: Integer;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.Sqr();
end;

function TOLIntegerHelper.Power(const Exponent: LongWord): Integer;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.Power(Exponent);
end;

function TOLIntegerHelper.Power(const Exponent: Integer): Double;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.Power(Exponent);
end;

function TOLIntegerHelper.Abs: Integer;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.Abs();
end;

function TOLIntegerHelper.Max(const i: Integer): Integer;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.Max(i);
end;

function TOLIntegerHelper.Min(const i: Integer): Integer;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.Min(i);
end;

function TOLIntegerHelper.Round(const Digits: Integer): Integer;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.Round(Digits);
end;

function TOLIntegerHelper.Between(const BottomIncluded, TopIncluded: Integer): Boolean;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.Between(BottomIncluded, TopIncluded);
end;

function TOLIntegerHelper.Increased(const IncreasedBy: Integer): Integer;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.Increased(IncreasedBy);
end;

function TOLIntegerHelper.Decreased(const DecreasedBy: Integer): Integer;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.Decreased(DecreasedBy);
end;

function TOLIntegerHelper.Replaced(const FromValue, ToValue: Integer): Integer;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.Replaced(FromValue, ToValue);
end;

function TOLIntegerHelper.ToString: string;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.ToString();
end;

function TOLIntegerHelper.ToSQLString: string;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.ToSQLString();
end;

function TOLIntegerHelper.ToNumeralSystem(const Base: Integer): string;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.ToNumeralSystem(Base);
end;

function TOLIntegerHelper.GetBinary: string;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.Binary;
end;

function TOLIntegerHelper.GetOctal: string;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.Octal;
end;

function TOLIntegerHelper.GetHexidecimal: string;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.Hexidecimal;
end;

function TOLIntegerHelper.GetNumeralSystem32: string;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.NumeralSystem32;
end;

function TOLIntegerHelper.GetNumeralSystem64: string;
var
  ol: OLInteger;
begin
  ol := Self;
  Result := ol.NumeralSystem64;
end;

procedure TOLIntegerHelper.SetBinary(const Value: string);
var
  ol: OLInteger;
begin
  ol := Self;
  ol.Binary := Value;
  Self := ol;
end;

procedure TOLIntegerHelper.SetOctal(const Value: string);
var
  ol: OLInteger;
begin
  ol := Self;
  ol.Octal := Value;
  Self := ol;
end;

procedure TOLIntegerHelper.SetHexidecimal(const Value: string);
var
  ol: OLInteger;
begin
  ol := Self;
  ol.Hexidecimal := Value;
  Self := ol;
end;

procedure TOLIntegerHelper.SetNumeralSystem32(const Value: string);
var
  ol: OLInteger;
begin
  ol := Self;
  ol.NumeralSystem32 := Value;
  Self := ol;
end;

procedure TOLIntegerHelper.SetNumeralSystem64(const Value: string);
var
  ol: OLInteger;
begin
  ol := Self;
  ol.NumeralSystem64 := Value;
  Self := ol;
end;

procedure TOLIntegerHelper.ForLoop(const InitialValue, ToValue: Integer; const Proc: TProc);
var
  i: Integer;
begin
  for i := InitialValue to ToValue do
    Proc();
end;

class function TOLIntegerHelper.Parse(const S: string): Integer;
begin
  Result := IntegerHelperFunctions.Type_Parse(s);
end;

class function TOLIntegerHelper.Random(const MinValue, MaxValue: Integer): Integer;
begin
  Result := OLInteger.Random(MinValue, MaxValue);
end;

class function TOLIntegerHelper.RandomPrime(const MinValue, MaxValue: Integer): Integer;
begin
  Result := OLInteger.RandomPrime(MinValue, MaxValue);
end;

class function TOLIntegerHelper.Random(const MaxValue: Integer): Integer;
begin
  Result := OLInteger.Random(MaxValue);
end;

class function TOLIntegerHelper.RandomPrime(const MaxValue: Integer): Integer;
begin
  Result := OLInteger.RandomPrime(MaxValue);
end;

procedure TOLIntegerHelper.SetRandom(const MinValue, MaxValue: Integer);
var
  ol: OLInteger;
begin
  ol := Self;
  ol.SetRandom(MinValue, MaxValue);
  Self := ol;
end;

procedure TOLIntegerHelper.SetRandom(const MaxValue: Integer);
var
  ol: OLInteger;
begin
  ol := Self;
  ol.SetRandom(MaxValue);
  Self := ol;
end;

procedure TOLIntegerHelper.SetRandomPrime(const MinValue, MaxValue: Integer);
var
  ol: OLInteger;
begin
  ol := Self;
  ol.SetRandomPrime(MinValue, MaxValue);
  Self := ol;
end;

procedure TOLIntegerHelper.SetRandomPrime(const MaxValue: Integer);
var
  ol: OLInteger;
begin
  ol := Self;
  ol.SetRandomPrime(MaxValue);
  Self := ol;
end;

class function TOLIntegerHelper.Size: Integer;
begin
  Result := integer.size;
end;

function TOLIntegerHelper.ToBoolean: Boolean;
begin
  Result := IntegerHelperFunctions.Instance_ToBoolean(self);
end;

function TOLIntegerHelper.ToDouble: Double;
begin
  Result := IntegerHelperFunctions.Instance_ToDouble(Self);
end;

function TOLIntegerHelper.ToExtended: Extended;
begin
  Result := IntegerHelperFunctions.Instance_ToExtended(Self);
end;

function TOLIntegerHelper.ToHexString: string;
begin
  Result := IntegerHelperFunctions.Instance_ToHexString(self);
end;

function TOLIntegerHelper.ToHexString(const MinDigits: Integer): string;
begin
  Result := IntegerHelperFunctions.Instance_ToHexString(Self, MinDigits);
end;

function TOLIntegerHelper.ToSingle: Single;
begin
  Result := IntegerHelperFunctions.Instance_ToSingle(Self);
end;

class function TOLIntegerHelper.ToString(const Value: Integer): string;
begin
  Result := IntegerHelperFunctions.Type_ToString(Value);
end;

class function TOLIntegerHelper.TryParse(const S: string; out Value: Integer):
    Boolean;
begin
  Result := IntegerHelperFunctions.Type_TryParse(s, Value);
end;

{$IF CompilerVersion >= 24.0}
function TOLBooleanHelper.ToSQLString(): string;
var
  ol: OLBoolean;
begin
  ol := Self;
  Result := ol.ToSQLString();
end;

function TOLBooleanHelper.IfThen(const ATrue: string; const AFalse: string): string;
var
  ol: OLBoolean;
begin
  ol := Self;
  Result := ol.IfThen(ATrue, AFalse);
end;

function TOLBooleanHelper.IfThen(const ATrue: Integer; const AFalse: Integer): Integer;
var
  ol: OLBoolean;
begin
  ol := Self;
  Result := ol.IfThen(ATrue, AFalse);
end;

function TOLBooleanHelper.IfThen(const ATrue: Currency; const AFalse: Currency): Currency;
var
  ol: OLBoolean;
begin
  ol := Self;
  Result := ol.IfThen(ATrue, AFalse);
end;

function TOLBooleanHelper.IfThen(const ATrue: Extended; const AFalse: Extended): Extended;
var
  ol: OLBoolean;
begin
  ol := Self;
  Result := ol.IfThen(ATrue, AFalse);
end;

function TOLBooleanHelper.IfThen(const ATrue: TDateTime; const AFalse: TDateTime): TDateTime;
var
  ol: OLBoolean;
begin
  ol := Self;
  Result := ol.IfThen(ATrue, AFalse);
end;

function TOLBooleanHelper.IfThen(const ATrue: Boolean; const AFalse: Boolean): Boolean;
var
  ol: OLBoolean;
begin
  ol := Self;
  Result := ol.IfThen(ATrue, AFalse);
end;

class function TOLBooleanHelper.Parse(const S: string): Boolean;
begin
  Result := BooleanHelperFunctions.Type_Parse(S);
end;

class function TOLBooleanHelper.Size: Integer;
begin
  Result := BooleanHelperFunctions.Type_Size();
end;

function TOLBooleanHelper.ToInteger: Integer;
begin
  Result := BooleanHelperFunctions.Instance_ToInteger(Self);
end;

function TOLBooleanHelper.ToString(UseBoolStrs: TUseBoolStrs =
    TUseBoolStrs.False): string;
begin
  Result := BooleanHelperFunctions.Instance_ToString(Self, UseBoolStrs);
end;

class function TOLBooleanHelper.ToString(const Value: Boolean; UseBoolStrs:
    TUseBoolStrs = TUseBoolStrs.False): string;
begin
  Result := BooleanHelperFunctions.Type_ToString(Value, UseBoolStrs)
end;

class function TOLBooleanHelper.TryToParse(const S: string; out Value:
    Boolean): Boolean;
begin
  Result := BooleanHelperFunctions.Type_TryToParse(S, Value);
end;

{$IFEND}

{$IF CompilerVersion >= 24.0}
{ TOLDoubleHelper }

function TOLDoubleHelper.Sqr(): Double;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.Sqr();
end;

function TOLDoubleHelper.Sqrt(): Double;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.Sqrt();
end;

function TOLDoubleHelper.Power(const Exponent: Integer): Double;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.Power(Exponent);
end;

function TOLDoubleHelper.Power(const Exponent: Extended): Double;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.Power(Exponent);
end;

function TOLDoubleHelper.IsPositive(): Boolean;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.IsPositive();
end;

function TOLDoubleHelper.IsNegative(): Boolean;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.IsNegative();
end;

function TOLDoubleHelper.IsNonNegative(): Boolean;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.IsNonNegative();
end;

function TOLDoubleHelper.Max(const d: Double): Double;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.Max(d);
end;

function TOLDoubleHelper.Min(const d: Double): Double;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.Min(d);
end;

function TOLDoubleHelper.Abs(): Double;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.Abs();
end;

function TOLDoubleHelper.ToString(): string;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.ToString();
end;

function TOLDoubleHelper.ToString(const Digits: Integer; const Format: TFloatFormat; const Precision: Integer): string;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.ToString(Digits, Format, Precision);
end;

function TOLDoubleHelper.ToString(ThousandSeparator: Char; DecimalSeparator: Char; Format: string): string;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.ToString(ThousandSeparator, DecimalSeparator, Format);
end;

function TOLDoubleHelper.ToSQLString(): string;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.ToSQLString();
end;

function TOLDoubleHelper.Round(const PowerOfTen: Integer): Double;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.Round(PowerOfTen);
end;

function TOLDoubleHelper.Round(): Integer;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.Round();
end;

function TOLDoubleHelper.Floor(): Integer;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.Floor();
end;

function TOLDoubleHelper.Ceil(): Integer;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.Ceil();
end;

function TOLDoubleHelper.SimpleRoundTo(const PowerOfTen: Integer = -2): Double;
begin
  Result := Math.SimpleRoundTo(Self, PowerOfTen);
end;

function TOLDoubleHelper.IsNan(): Boolean;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.IsNan();
end;

function TOLDoubleHelper.IsInfinite(): Boolean;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.IsInfinite();
end;

function TOLDoubleHelper.IsZero(const Epsilon: Extended): Boolean;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.IsZero(Epsilon);
end;

function TOLDoubleHelper.InRange(const AMin, AMax: Extended): Boolean;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.InRange(AMin, AMax);
end;

function TOLDoubleHelper.EnsureRange(const AMin, AMax: Extended): Extended;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.EnsureRange(AMin, AMax);
end;

function TOLDoubleHelper.SameValue(const B: Extended; const Epsilon: Extended): Boolean;
var
  ol: OLDouble;
begin
  ol := Self;
  Result := ol.SameValue(B, Epsilon);
end;

class function TOLDoubleHelper.Random(const MinValue: Double; const MaxValue: Double): Double;
begin
  Result := OLDouble.Random(MinValue, MaxValue);
end;

class function TOLDoubleHelper.Random(const MaxValue: Double): Double;
begin
  Result := OLDouble.Random(MaxValue);
end;

function TOLDoubleHelper.Exponent: Integer;
begin
  Result := DoubleHelperFunctions.Instance_Exponent(Self);
end;

function TOLDoubleHelper.Fraction: Extended;
begin
  Result := DoubleHelperFunctions.Instance_Fraction(Self);
end;

function TOLDoubleHelper.Mantissa: UInt64;
begin
  Result := DoubleHelperFunctions.Instance_Mantissa(Self);
end;

function TOLDoubleHelper.GetSign: Boolean;
begin
  Result := DoubleHelperFunctions.Instance_GetSign(Self);
end;

procedure TOLDoubleHelper.SetSign(const Value: Boolean);
begin
  DoubleHelperFunctions.Instance_SetSign(Self, Value);
end;

function TOLDoubleHelper.GetExp: UInt64;
begin
  Result := DoubleHelperFunctions.Instance_GetExp(Self);
end;

procedure TOLDoubleHelper.SetExp(const Value: UInt64);
begin
  DoubleHelperFunctions.Instance_SetExp(Self, Value);
end;

function TOLDoubleHelper.GetFrac: UInt64;
begin
  Result := DoubleHelperFunctions.Instance_GetFrac(Self);
end;

procedure TOLDoubleHelper.SetFrac(const Value: UInt64);
begin
  DoubleHelperFunctions.Instance_SetFrac(Self, Value);
end;

function TOLDoubleHelper.SpecialType: TFloatSpecial;
begin
  Result := DoubleHelperFunctions.Instance_SpecialType(Self);
end;

procedure TOLDoubleHelper.BuildUp(const SignFlag: Boolean; const Mantissa: UInt64; const Exponent: Integer);
begin
  DoubleHelperFunctions.Instance_BuildUp(Self, SignFlag, Mantissa, Exponent);
end;

function TOLDoubleHelper.ToString(const AFormatSettings: TFormatSettings): string;
begin
  Result := DoubleHelperFunctions.Instance_ToString(Self, AFormatSettings);
end;

function TOLDoubleHelper.ToString(const Format: TFloatFormat; const Precision, Digits: Integer; const AFormatSettings: TFormatSettings): string;
begin
  Result := DoubleHelperFunctions.Instance_ToString(Self, Format, Precision, Digits, AFormatSettings);
end;

function TOLDoubleHelper.IsNegativeInfinity: Boolean;
begin
  Result := DoubleHelperFunctions.Instance_IsNegativeInfinity(Self);
end;

function TOLDoubleHelper.IsPositiveInfinity: Boolean;
begin
  Result := DoubleHelperFunctions.Instance_IsPositiveInfinity(Self);
end;

function TOLDoubleHelper.GetBytes(Index: Cardinal): UInt8;
begin
  Result := DoubleHelperFunctions.Instance_GetBytes(Self, Index);
end;

procedure TOLDoubleHelper.SetBytes(Index: Cardinal; const Value: UInt8);
begin
  DoubleHelperFunctions.Instance_SetBytes(Self, Index, Value);
end;

function TOLDoubleHelper.GetWords(Index: Cardinal): UInt16;
begin
  Result := DoubleHelperFunctions.Instance_GetWords(Self, Index);
end;

procedure TOLDoubleHelper.SetWords(Index: Cardinal; const Value: UInt16);
begin
  DoubleHelperFunctions.Instance_SetWords(Self, Index, Value);
end;

class function TOLDoubleHelper.ToString(const Value: Double): string;
begin
  Result := DoubleHelperFunctions.Type_ToString(Value);
end;

class function TOLDoubleHelper.ToString(const Value: Double; const AFormatSettings: TFormatSettings): string;
begin
  Result := DoubleHelperFunctions.Type_ToString(Value, AFormatSettings);
end;

class function TOLDoubleHelper.ToString(const Value: Double; const Format: TFloatFormat; const Precision, Digits: Integer): string;
begin
  Result := DoubleHelperFunctions.Type_ToString(Value, Format, Precision, Digits);
end;

class function TOLDoubleHelper.ToString(const Value: Double; const Format: TFloatFormat; const Precision, Digits: Integer; const AFormatSettings: TFormatSettings): string;
begin
  Result := DoubleHelperFunctions.Type_ToString(Value, Format, Precision, Digits, AFormatSettings);
end;

class function TOLDoubleHelper.Parse(const S: string): Double;
begin
  Result := DoubleHelperFunctions.Type_Parse(S);
end;

class function TOLDoubleHelper.Parse(const S: string; const AFormatSettings: TFormatSettings): Double;
begin
  Result := DoubleHelperFunctions.Type_Parse(S, AFormatSettings);
end;

class function TOLDoubleHelper.TryParse(const S: string; out Value: Double): Boolean;
begin
  Result := DoubleHelperFunctions.Type_TryParse(S, Value);
end;

class function TOLDoubleHelper.TryParse(const S: string; out Value: Double; const AFormatSettings: TFormatSettings): Boolean;
begin
  Result := DoubleHelperFunctions.Type_TryParse(S, Value, AFormatSettings);
end;

class function TOLDoubleHelper.IsNan(const Value: Double): Boolean;
begin
  Result := DoubleHelperFunctions.Type_IsNan(Value);
end;

class function TOLDoubleHelper.IsInfinity(const Value: Double): Boolean;
begin
  Result := DoubleHelperFunctions.Type_IsInfinity(Value);
end;

function TOLDoubleHelper.IsInfinity: Boolean;
begin
  Result := DoubleHelperFunctions.Type_IsInfinity(Self);
end;

class function TOLDoubleHelper.IsNegativeInfinity(const Value: Double): Boolean;
begin
  Result := DoubleHelperFunctions.Type_IsNegativeInfinity(Value);
end;

class function TOLDoubleHelper.IsPositiveInfinity(const Value: Double): Boolean;
begin
  Result := DoubleHelperFunctions.Type_IsPositiveInfinity(Value);
end;

class function TOLDoubleHelper.Size: Integer;
begin
  Result := DoubleHelperFunctions.Type_Size;
end;

function TOLDoubleHelper.ToString(const Format: TFloatFormat; const Precision,
    Digits: Integer): string;
begin
  Result := DoubleHelperFunctions.Instance_ToString(self, Format, Precision, Digits);
end;

{$IFEND}

{$IF CompilerVersion >= 24.0}
{ TOLCurrencyHelper }

function TOLCurrencyHelper.Sqr(): Currency;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.Sqr();
end;

function TOLCurrencyHelper.Power(const Exponent: Integer): Currency;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.Power(Exponent);
end;

function TOLCurrencyHelper.IsPositive(): Boolean;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.IsPositive();
end;

function TOLCurrencyHelper.IsNegative(): Boolean;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.IsNegative();
end;

function TOLCurrencyHelper.IsNonNegative(): Boolean;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.IsNonNegative();
end;

function TOLCurrencyHelper.Between(const BottomIncluded, TopIncluded:
    Currency): Boolean;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.Between(BottomIncluded, TopIncluded);
end;

function TOLCurrencyHelper.Max(const c: Currency): Currency;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.Max(c);
end;

function TOLCurrencyHelper.Min(const c: Currency): Currency;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.Min(c);
end;

function TOLCurrencyHelper.Abs(): Currency;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.Abs();
end;

function TOLCurrencyHelper.ToString(): string;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.ToString();
end;

function TOLCurrencyHelper.ToString(ThousandSeparator: Char; DecimalSeparator: Char; Format: string): string;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.ToString(ThousandSeparator, DecimalSeparator, Format);
end;

function TOLCurrencyHelper.ToSQLString(): string;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.ToSQLString();
end;

function TOLCurrencyHelper.ToStrF(Format: TFloatFormat; Digits: Integer): string;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.ToStrF(Format, Digits);
end;

function TOLCurrencyHelper.Round(): Integer;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.Round();
end;

function TOLCurrencyHelper.Round(const PowerOfTen: Integer): Currency;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.Round(PowerOfTen);
end;

function TOLCurrencyHelper.Ceil(): Integer;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.Ceil();
end;

function TOLCurrencyHelper.Floor(): Integer;
var
  ol: OLCurrency;
begin
  ol := Self;
  Result := ol.Floor();
end;

function TOLCurrencyHelper.SimpleRoundTo(const PowerOfTen: Integer = -2): Currency;
begin
  Result := Math.SimpleRoundTo(Self, PowerOfTen);
end;

function TOLCurrencyHelper.Frac: Currency;
begin
  Result := CurrencyHelperFunctions.Instance_Frac(Self);
end;

class function TOLCurrencyHelper.Parse(const S: string; const AFormatSettings:
    TFormatSettings): Currency;
begin
  Result := CurrencyHelperFunctions.Type_Parse(s, AFormatSettings);
end;

class function TOLCurrencyHelper.Parse(const S: string): Currency;
begin
  Result := CurrencyHelperFunctions.Type_Parse(S);
end;

class function TOLCurrencyHelper.Size: Integer;
begin
  Result := CurrencyHelperFunctions.Type_Size();
end;

function TOLCurrencyHelper.ToString(const AFormatSettings: TFormatSettings):
    string;
begin
  Result := CurrencyHelperFunctions.Type_ToString(Self, AFormatSettings);
end;

class function TOLCurrencyHelper.ToString(const Value: Currency; const
    AFormatSettings: TFormatSettings): string;
begin
  Result := CurrencyHelperFunctions.Type_ToString(Value, AFormatSettings);
end;

class function TOLCurrencyHelper.ToString(const Value: Currency): string;
begin
  Result := CurrencyHelperFunctions.Type_ToString(Value);
end;

function TOLCurrencyHelper.Trunc: Int64;
begin
  Result := CurrencyHelperFunctions.Instance_Trunc(Self);
end;

class function TOLCurrencyHelper.TryParse(const S: string; out Value: Currency;
    const AFormatSettings: TFormatSettings): Boolean;
begin
  Result := CurrencyHelperFunctions.Type_TryParse(S, Value, AFormatSettings);
end;

class function TOLCurrencyHelper.TryParse(const S: string; out Value:
    Currency): Boolean;
begin
  Result := CurrencyHelperFunctions.Type_TryParse(s, Value);
end;

{$IFEND}

{$IF CompilerVersion >= 24.0}
{ TOLDateTimeHelper }

function TOLDateTimeHelper.GetYear: Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.Year;
end;

function TOLDateTimeHelper.GetMonth: Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.Month;
end;

function TOLDateTimeHelper.GetDay: Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.Day;
end;

function TOLDateTimeHelper.GetHour: Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.Hour;
end;

function TOLDateTimeHelper.GetMinute: Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.Minute;
end;

function TOLDateTimeHelper.GetSecond: Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.Second;
end;

function TOLDateTimeHelper.GetMilliSecond: Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MilliSecond;
end;

procedure TOLDateTimeHelper.SetYear(const Value: Integer);
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.Year := Value;
  Self := ol;
end;

procedure TOLDateTimeHelper.SetMonth(const Value: Integer);
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.Month := Value;
  Self := ol;
end;

procedure TOLDateTimeHelper.SetDay(const Value: Integer);
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.Day := Value;
  Self := ol;
end;

procedure TOLDateTimeHelper.SetHour(const Value: Integer);
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.Hour := Value;
  Self := ol;
end;

procedure TOLDateTimeHelper.SetMinute(const Value: Integer);
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.Minute := Value;
  Self := ol;
end;

procedure TOLDateTimeHelper.SetSecond(const Value: Integer);
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.Second := Value;
  Self := ol;
end;

procedure TOLDateTimeHelper.SetMilliSecond(const Value: Integer);
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.MilliSecond := Value;
  Self := ol;
end;

function TOLDateTimeHelper.ToString(): string;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.ToString();
end;

function TOLDateTimeHelper.ToString(const Format: string): string;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.ToString(Format);
end;

function TOLDateTimeHelper.ToSQLString(): string;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.ToSQLString();
end;

function TOLDateTimeHelper.DateOf(): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.DateOf();
end;

function TOLDateTimeHelper.TimeOf(): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.TimeOf();
end;

function TOLDateTimeHelper.IsInLeapYear(): Boolean;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.IsInLeapYear();
end;

function TOLDateTimeHelper.IsPM(): Boolean;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.IsPM();
end;

function TOLDateTimeHelper.IsAM(): Boolean;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.IsAM();
end;

function TOLDateTimeHelper.WeeksInYear(): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.WeeksInYear();
end;

function TOLDateTimeHelper.DaysInYear(): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.DaysInYear();
end;

function TOLDateTimeHelper.DaysInMonth(): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.DaysInMonth();
end;

class function TOLDateTimeHelper.Today: TDateTime;
begin
  Result := OLDateTime.Today;
end;

class function TOLDateTimeHelper.Yesterday: TDateTime;
begin
  Result := OLDateTime.Yesterday;
end;

class function TOLDateTimeHelper.Tomorrow: TDateTime;
begin
  Result := OLDateTime.Tomorrow;
end;

class function TOLDateTimeHelper.Now(): TDateTime;
begin
  Result := OLDateTime.Now();
end;

procedure TOLDateTimeHelper.SetNow();
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.SetNow();
  Self := ol;
end;

procedure TOLDateTimeHelper.SetToday();
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.SetToday();
  Self := ol;
end;

procedure TOLDateTimeHelper.SetTomorrow();
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.SetTomorrow();
  Self := ol;
end;

procedure TOLDateTimeHelper.SetYesterday();
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.SetYesterday();
  Self := ol;
end;

function TOLDateTimeHelper.IsToday(): Boolean;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.IsToday();
end;

function TOLDateTimeHelper.SameDay(const DateTimeToCompare: TDateTime): Boolean;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.SameDay(DateTimeToCompare);
end;

function TOLDateTimeHelper.StartOfTheYear(): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.StartOfTheYear();
end;

function TOLDateTimeHelper.EndOfTheYear(): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.EndOfTheYear();
end;

class function TOLDateTimeHelper.StartOfAYear(const AYear: Word): TDateTime;
begin
  Result := OLDateTime.StartOfAYear(AYear);
end;

class function TOLDateTimeHelper.EndOfAYear(const AYear: Word): TDateTime;
begin
  Result := OLDateTime.EndOfAYear(AYear);
end;

procedure TOLDateTimeHelper.SetStartOfAYear(const AYear: Word);
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.SetStartOfAYear(AYear);
  Self := ol;
end;

procedure TOLDateTimeHelper.SetEndOfAYear(const AYear: Word);
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.SetEndOfAYear(AYear);
  Self := ol;
end;

function TOLDateTimeHelper.StartOfTheMonth(): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.StartOfTheMonth();
end;

function TOLDateTimeHelper.EndOfTheMonth(): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.EndOfTheMonth();
end;

class function TOLDateTimeHelper.StartOfAMonth(const AYear, AMonth: Word): TDateTime;
begin
  Result := OLDateTime.StartOfAMonth(AYear, AMonth);
end;

class function TOLDateTimeHelper.EndOfAMonth(const AYear, AMonth: Word): TDateTime;
begin
  Result := OLDateTime.EndOfAMonth(AYear, AMonth);
end;

procedure TOLDateTimeHelper.SetStartOfAMonth(const AYear, AMonth: Word);
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.SetStartOfAMonth(AYear, AMonth);
  Self := ol;
end;

procedure TOLDateTimeHelper.SetEndOfAMonth(const AYear, AMonth: Word);
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.SetEndOfAMonth(AYear, AMonth);
  Self := ol;
end;

function TOLDateTimeHelper.StartOfTheWeek(): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.StartOfTheWeek();
end;

function TOLDateTimeHelper.EndOfTheWeek(): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.EndOfTheWeek();
end;

function TOLDateTimeHelper.StartOfTheDay(): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.StartOfTheDay();
end;

function TOLDateTimeHelper.EndOfTheDay(): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.EndOfTheDay();
end;

function TOLDateTimeHelper.DayOfTheYear(): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.DayOfTheYear();
end;

function TOLDateTimeHelper.HourOfTheYear(): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.HourOfTheYear();
end;

function TOLDateTimeHelper.MinuteOfTheYear(): LongWord;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MinuteOfTheYear();
end;

function TOLDateTimeHelper.SecondOfTheYear(): LongWord;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.SecondOfTheYear();
end;

function TOLDateTimeHelper.MilliSecondOfTheYear(): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MilliSecondOfTheYear();
end;

function TOLDateTimeHelper.HourOfTheMonth(): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.HourOfTheMonth();
end;

function TOLDateTimeHelper.MinuteOfTheMonth(): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MinuteOfTheMonth();
end;

function TOLDateTimeHelper.SecondOfTheMonth(): LongWord;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.SecondOfTheMonth();
end;

function TOLDateTimeHelper.MilliSecondOfTheMonth(): LongWord;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MilliSecondOfTheMonth();
end;

function TOLDateTimeHelper.DayOfTheWeek(): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.DayOfTheWeek();
end;

function TOLDateTimeHelper.HourOfTheWeek(): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.HourOfTheWeek();
end;

function TOLDateTimeHelper.MinuteOfTheWeek(): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MinuteOfTheWeek();
end;

function TOLDateTimeHelper.SecondOfTheWeek(): LongWord;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.SecondOfTheWeek();
end;

function TOLDateTimeHelper.MilliSecondOfTheWeek(): LongWord;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MilliSecondOfTheWeek();
end;

function TOLDateTimeHelper.MinuteOfTheDay(): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MinuteOfTheDay();
end;

function TOLDateTimeHelper.SecondOfTheDay(): LongWord;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.SecondOfTheDay();
end;

function TOLDateTimeHelper.MilliSecondOfTheDay(): LongWord;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MilliSecondOfTheDay();
end;

function TOLDateTimeHelper.SecondOfTheHour(): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.SecondOfTheHour();
end;

function TOLDateTimeHelper.MilliSecondOfTheHour(): LongWord;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MilliSecondOfTheHour();
end;

function TOLDateTimeHelper.MilliSecondOfTheMinute(): LongWord;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MilliSecondOfTheMinute();
end;

class function TOLDateTimeHelper.SecondCount(const StartingYear: Integer): Integer;
begin
  Result := OLDateTime.SecondCount(StartingYear);
end;

class function TOLDateTimeHelper.DateTimeFromSecondCount(const Count: Integer; const StartingYear: Integer): TDateTime;
begin
  Result := OLDateTime.DateTimeFromSecondCount(Count, StartingYear);
end;

procedure TOLDateTimeHelper.SetFromSecondCount(const Count: Integer; const StartingYear: Integer);
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.SetFromSecondCount(Count, StartingYear);
  Self := ol;
end;

function TOLDateTimeHelper.YearsBetween(const Date: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.YearsBetween(Date);
end;

function TOLDateTimeHelper.MonthsBetween(const Date: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MonthsBetween(Date);
end;

function TOLDateTimeHelper.WeeksBetween(const Date: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.WeeksBetween(Date);
end;

function TOLDateTimeHelper.DaysBetween(const Date: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.DaysBetween(Date);
end;

function TOLDateTimeHelper.HoursBetween(const Date: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.HoursBetween(Date);
end;

function TOLDateTimeHelper.MinutesBetween(const Date: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MinutesBetween(Date);
end;

function TOLDateTimeHelper.SecondsBetween(const Date: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.SecondsBetween(Date);
end;

function TOLDateTimeHelper.MilliSecondsBetween(const Date: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MilliSecondsBetween(Date);
end;

function TOLDateTimeHelper.YearsFrom(const Date: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.YearsFrom(Date);
end;

function TOLDateTimeHelper.YearsTo(const Date: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.YearsTo(Date);
end;

function TOLDateTimeHelper.MonthsFrom(const Date: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MonthsFrom(Date);
end;

function TOLDateTimeHelper.MonthsTo(const Date: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MonthsTo(Date);
end;

function TOLDateTimeHelper.WeeksFrom(const Date: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.WeeksFrom(Date);
end;

function TOLDateTimeHelper.WeeksTo(const Date: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.WeeksTo(Date);
end;

function TOLDateTimeHelper.DaysFrom(const Date: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.DaysFrom(Date);
end;

function TOLDateTimeHelper.DaysTo(const Date: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.DaysTo(Date);
end;

function TOLDateTimeHelper.HoursFrom(const Date: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.HoursFrom(Date);
end;

function TOLDateTimeHelper.HoursTo(const Date: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.HoursTo(Date);
end;

function TOLDateTimeHelper.MinutesFrom(const Date: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MinutesFrom(Date);
end;

function TOLDateTimeHelper.MinutesTo(const Date: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MinutesTo(Date);
end;

function TOLDateTimeHelper.SecondsFrom(const Date: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.SecondsFrom(Date);
end;

function TOLDateTimeHelper.SecondsTo(const Date: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.SecondsTo(Date);
end;

function TOLDateTimeHelper.MilliSecondsFrom(const Date: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MilliSecondsFrom(Date);
end;

function TOLDateTimeHelper.MilliSecondsTo(const Date: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MilliSecondsTo(Date);
end;

function TOLDateTimeHelper.InRange(const AStartDateTime, AEndDateTime: TDateTime; const aInclusive: Boolean): Boolean;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.InRange(AStartDateTime, AEndDateTime, aInclusive);
end;

function TOLDateTimeHelper.InDateRange(const AStartDateTime, AEndDateTime: TDate; const aInclusive: Boolean): Boolean;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.InDateRange(AStartDateTime, AEndDateTime, aInclusive);
end;

function TOLDateTimeHelper.YearSpan(const Date: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.YearSpan(Date);
end;

function TOLDateTimeHelper.MonthSpan(const Date: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MonthSpan(Date);
end;

function TOLDateTimeHelper.WeekSpan(const Date: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.WeekSpan(Date);
end;

function TOLDateTimeHelper.DaySpan(const Date: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.DaySpan(Date);
end;

function TOLDateTimeHelper.HourSpan(const Date: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.HourSpan(Date);
end;

function TOLDateTimeHelper.MinuteSpan(const Date: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MinuteSpan(Date);
end;

function TOLDateTimeHelper.SecondSpan(const Date: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.SecondSpan(Date);
end;

function TOLDateTimeHelper.MilliSecondSpan(const Date: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MilliSecondSpan(Date);
end;

function TOLDateTimeHelper.IncYear(const ANumberOfYears: Integer): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.IncYear(ANumberOfYears);
end;

function TOLDateTimeHelper.IncMonth(const ANumberOfMonths: Integer): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.IncMonth(ANumberOfMonths);
end;

function TOLDateTimeHelper.IncWeek(const ANumberOfWeeks: Integer): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.IncWeek(ANumberOfWeeks);
end;

function TOLDateTimeHelper.IncDay(const ANumberOfDays: Integer): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.IncDay(ANumberOfDays);
end;

function TOLDateTimeHelper.IncHour(const ANumberOfHours: Int64): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.IncHour(ANumberOfHours);
end;

function TOLDateTimeHelper.IncMinute(const ANumberOfMinutes: Int64): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.IncMinute(ANumberOfMinutes);
end;

function TOLDateTimeHelper.IncSecond(const ANumberOfSeconds: Int64): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.IncSecond(ANumberOfSeconds);
end;

function TOLDateTimeHelper.IncMilliSecond(const ANumberOfMilliSeconds: Int64): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.IncMilliSecond(ANumberOfMilliSeconds);
end;

procedure TOLDateTimeHelper.DecodeDateTime(out AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word);
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.DecodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
end;

procedure TOLDateTimeHelper.EncodeDateTime(const AYear, AMonth, ADay: Word; const AHour, AMinute, ASecond, AMilliSecond: Word);
var
  ol: OLDateTime;
begin
  ol := Self;
  ol.EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
  Self := ol;
end;

function TOLDateTimeHelper.RecodedYear(const AYear: Word): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.RecodedYear(AYear);
end;

function TOLDateTimeHelper.RecodedMonth(const AMonth: Word): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.RecodedMonth(AMonth);
end;

function TOLDateTimeHelper.RecodedDay(const ADay: Word): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.RecodedDay(ADay);
end;

function TOLDateTimeHelper.RecodedHour(const AHour: Word): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.RecodedHour(AHour);
end;

function TOLDateTimeHelper.RecodedMinute(const AMinute: Word): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.RecodedMinute(AMinute);
end;

function TOLDateTimeHelper.RecodedSecond(const ASecond: Word): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.RecodedSecond(ASecond);
end;

function TOLDateTimeHelper.RecodedMilliSecond(const AMilliSecond: Word): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.RecodedMilliSecond(AMilliSecond);
end;

function TOLDateTimeHelper.SameTime(const DateTimeToCompare: TDateTime): Boolean;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.SameTime(DateTimeToCompare);
end;

function TOLDateTimeHelper.LongDayName(): string;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.LongDayName();
end;

function TOLDateTimeHelper.LongMonthName(): string;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.LongMonthName();
end;

function TOLDateTimeHelper.ShortDayName(): string;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.ShortDayName();
end;

function TOLDateTimeHelper.ShortMonthName(): string;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.ShortMonthName();
end;

function TOLDateTimeHelper.Max(const CompareDate: TDateTime): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.Max(CompareDate);
end;

function TOLDateTimeHelper.Min(const CompareDate: TDateTime): TDateTime;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.Min(CompareDate);
end;
{$IFEND}

{$IF CompilerVersion >= 24.0}
{ TOLDateHelper }

function TOLDateHelper.GetYear: Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.Year;
end;

function TOLDateHelper.GetMonth: Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.Month;
end;

function TOLDateHelper.GetDay: Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.Day;
end;

procedure TOLDateHelper.SetYear(const Value: Integer);
var
  ol: OLDate;
begin
  ol := Self;
  ol.Year := Value;
  Self := ol;
end;

procedure TOLDateHelper.SetMonth(const Value: Integer);
var
  ol: OLDate;
begin
  ol := Self;
  ol.Month := Value;
  Self := ol;
end;

procedure TOLDateHelper.SetDay(const Value: Integer);
var
  ol: OLDate;
begin
  ol := Self;
  ol.Day := Value;
  Self := ol;
end;

function TOLDateHelper.ToString(): string;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.ToString();
end;

function TOLDateHelper.ToString(const Format: string): string;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.ToString(Format);
end;

function TOLDateHelper.ToSQLString(): string;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.ToSQLString();
end;

function TOLDateHelper.IsInLeapYear(): Boolean;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.IsInLeapYear();
end;

function TOLDateHelper.WeeksInYear(): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.WeeksInYear();
end;

function TOLDateHelper.DaysInYear(): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.DaysInYear();
end;

function TOLDateHelper.DaysInMonth(): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.DaysInMonth();
end;

class function TOLDateHelper.Today: TDate;
begin
  Result := OLDate.Today;
end;

class function TOLDateHelper.Yesterday: TDate;
begin
  Result := OLDate.Yesterday;
end;

class function TOLDateHelper.Tomorrow: TDate;
begin
  Result := OLDate.Tomorrow;
end;

procedure TOLDateHelper.SetToday();
var
  ol: OLDate;
begin
  ol := Self;
  ol.SetToday();
  Self := ol;
end;

procedure TOLDateHelper.SetTomorrow();
var
  ol: OLDate;
begin
  ol := Self;
  ol.SetTomorrow();
  Self := ol;
end;

procedure TOLDateHelper.SetYesterday();
var
  ol: OLDate;
begin
  ol := Self;
  ol.SetYesterday();
  Self := ol;
end;

function TOLDateHelper.IsToday(): Boolean;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.IsToday();
end;

function TOLDateHelper.SameDay(const DateToCompare: TDate): Boolean;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.SameDay(DateToCompare);
end;

function TOLDateHelper.StartOfTheYear(): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.StartOfTheYear();
end;

function TOLDateHelper.EndOfTheYear(): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.EndOfTheYear();
end;

class function TOLDateHelper.StartOfAYear(const AYear: Word): TDate;
begin
  Result := OLDate.StartOfAYear(AYear);
end;

class function TOLDateHelper.EndOfAYear(const AYear: Word): TDate;
begin
  Result := OLDate.EndOfAYear(AYear);
end;

procedure TOLDateHelper.SetStartOfAYear(const AYear: Word);
var
  ol: OLDate;
begin
  ol := Self;
  ol.SetStartOfAYear(AYear);
  Self := ol;
end;

procedure TOLDateHelper.SetEndOfAYear(const AYear: Word);
var
  ol: OLDate;
begin
  ol := Self;
  ol.SetEndOfAYear(AYear);
  Self := ol;
end;

function TOLDateHelper.StartOfTheMonth(): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.StartOfTheMonth();
end;

function TOLDateHelper.EndOfTheMonth(): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.EndOfTheMonth();
end;

class function TOLDateHelper.StartOfAMonth(const AYear, AMonth: Word): TDate;
begin
  Result := OLDate.StartOfAMonth(AYear, AMonth);
end;

class function TOLDateHelper.EndOfAMonth(const AYear, AMonth: Word): TDate;
begin
  Result := OLDate.EndOfAMonth(AYear, AMonth);
end;

procedure TOLDateHelper.SetStartOfAMonth(const AYear, AMonth: Word);
var
  ol: OLDate;
begin
  ol := Self;
  ol.SetStartOfAMonth(AYear, AMonth);
  Self := ol;
end;

procedure TOLDateHelper.SetEndOfAMonth(const AYear, AMonth: Word);
var
  ol: OLDate;
begin
  ol := Self;
  ol.SetEndOfAMonth(AYear, AMonth);
  Self := ol;
end;

function TOLDateHelper.StartOfTheWeek(): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.StartOfTheWeek();
end;

function TOLDateHelper.EndOfTheWeek(): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.EndOfTheWeek();
end;

function TOLDateHelper.DayOfTheYear(): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.DayOfTheYear();
end;

function TOLDateHelper.DayOfTheWeek(): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.DayOfTheWeek();
end;

function TOLDateHelper.YearsBetween(const Date: TDate): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.YearsBetween(Date);
end;

function TOLDateHelper.MonthsBetween(const Date: TDate): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.MonthsBetween(Date);
end;

function TOLDateHelper.WeeksBetween(const Date: TDate): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.WeeksBetween(Date);
end;

function TOLDateHelper.DaysBetween(const Date: TDate): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.DaysBetween(Date);
end;

function TOLDateHelper.YearsFrom(const Date: TDate): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.YearsFrom(Date);
end;

function TOLDateHelper.YearsTo(const Date: TDate): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.YearsTo(Date);
end;

function TOLDateHelper.MonthsFrom(const Date: TDate): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.MonthsFrom(Date);
end;

function TOLDateHelper.MonthsTo(const Date: TDate): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.MonthsTo(Date);
end;

function TOLDateHelper.WeeksFrom(const Date: TDate): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.WeeksFrom(Date);
end;

function TOLDateHelper.WeeksTo(const Date: TDate): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.WeeksTo(Date);
end;

function TOLDateHelper.DaysFrom(const Date: TDate): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.DaysFrom(Date);
end;

function TOLDateHelper.DaysTo(const Date: TDate): Integer;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.DaysTo(Date);
end;

function TOLDateHelper.InRange(const AStartDateTime, AEndDateTime: TDate; const aInclusive: Boolean): Boolean;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.InRange(AStartDateTime, AEndDateTime, aInclusive);
end;

function TOLDateHelper.YearSpan(const Date: TDate): Double;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.YearSpan(Date);
end;

function TOLDateHelper.MonthSpan(const Date: TDate): Double;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.MonthSpan(Date);
end;

function TOLDateHelper.WeekSpan(const Date: TDate): Double;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.WeekSpan(Date);
end;

function TOLDateHelper.IncYear(const ANumberOfYears: Integer): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.IncYear(ANumberOfYears);
end;

function TOLDateHelper.IncMonth(const ANumberOfMonths: Integer): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.IncMonth(ANumberOfMonths);
end;

function TOLDateHelper.IncWeek(const ANumberOfWeeks: Integer): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.IncWeek(ANumberOfWeeks);
end;

function TOLDateHelper.IncDay(const ANumberOfDays: Integer): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.IncDay(ANumberOfDays);
end;

procedure TOLDateHelper.DecodeDate(out AYear, AMonth, ADay: Word);
var
  ol: OLDate;
begin
  ol := Self;
  ol.DecodeDate(AYear, AMonth, ADay);
end;

procedure TOLDateHelper.EncodeDate(const AYear, AMonth, ADay: Word);
var
  ol: OLDate;
begin
  ol := Self;
  ol.EncodeDate(AYear, AMonth, ADay);
  Self := ol;
end;

function TOLDateHelper.RecodedYear(const AYear: Word): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.RecodedYear(AYear);
end;

function TOLDateHelper.RecodedMonth(const AMonth: Word): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.RecodedMonth(AMonth);
end;

function TOLDateHelper.RecodedDay(const ADay: Word): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.RecodedDay(ADay);
end;

function TOLDateHelper.LongDayName(): string;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.LongDayName();
end;

function TOLDateHelper.LongMonthName(): string;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.LongMonthName();
end;

function TOLDateHelper.ShortDayName(): string;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.ShortDayName();
end;

function TOLDateHelper.ShortMonthName(): string;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.ShortMonthName();
end;

function TOLDateHelper.Max(const CompareDate: TDate): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.Max(CompareDate);
end;

function TOLDateHelper.Min(const CompareDate: TDate): TDate;
var
  ol: OLDate;
begin
  ol := Self;
  Result := ol.Min(CompareDate);
end;

class function TOLDateHelper.IsValidDate(const Year, Month, Day: Integer): Boolean;
begin
  Result := OLDate.IsValidDate(Year, Month, Day);
end;
{$IFEND}

{$IF CompilerVersion >= 24.0}
{ TOLInt64Helper }

function TOLInt64Helper.IsDividableBy(i: Int64): Boolean;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.IsDividableBy(i);
end;

function TOLInt64Helper.IsOdd(): Boolean;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.IsOdd();
end;

function TOLInt64Helper.IsEven(): Boolean;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.IsEven();
end;

function TOLInt64Helper.Sqr(): Int64;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.Sqr();
end;

function TOLInt64Helper.Power(Exponent: LongWord): Int64;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.Power(Exponent);
end;

function TOLInt64Helper.Power(Exponent: Int64): Double;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.Power(Exponent);
end;

function TOLInt64Helper.IsPositive(): Boolean;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.IsPositive();
end;

function TOLInt64Helper.IsNegative(): Boolean;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.IsNegative();
end;

function TOLInt64Helper.IsNonNegative(): Boolean;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.IsNonNegative();
end;

function TOLInt64Helper.Max(i: Int64): Int64;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.Max(i);
end;

function TOLInt64Helper.Min(i: Int64): Int64;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.Min(i);
end;

function TOLInt64Helper.Abs(): Int64;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.Abs();
end;

function TOLInt64Helper.ToString(): string;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.ToString();
end;

function TOLInt64Helper.ToSQLString(): string;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.ToSQLString();
end;

function TOLInt64Helper.Round(Digits: Int64): Int64;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.Round(Digits);
end;

function TOLInt64Helper.Between(BottomIncluded, TopIncluded: Int64): Boolean;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.Between(BottomIncluded, TopIncluded);
end;

function TOLInt64Helper.Increased(IncreasedBy: Int64): Int64;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.Increased(IncreasedBy);
end;

function TOLInt64Helper.Decreased(DecreasedBy: Int64): Int64;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.Decreased(DecreasedBy);
end;

function TOLInt64Helper.Replaced(FromValue: Int64; ToValue: Int64): Int64;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.Replaced(FromValue, ToValue);
end;

function TOLInt64Helper.ToNumeralSystem(const Base: Integer): string;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.ToNumeralSystem(Base);
end;

function TOLInt64Helper.Binary: string;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.Binary;
end;

function TOLInt64Helper.Octal: string;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.Octal;
end;

function TOLInt64Helper.Hexidecimal: string;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.Hexidecimal;
end;

function TOLInt64Helper.NumeralSystem32: string;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.NumeralSystem32;
end;

function TOLInt64Helper.NumeralSystem64: string;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.NumeralSystem64;
end;

procedure TOLInt64Helper.SetBinary(const Value: string);
var
  ol: OLInt64;
begin
  ol.Binary := Value;
  Self := ol;
end;

procedure TOLInt64Helper.SetOctal(const Value: string);
var
  ol: OLInt64;
begin
  ol.Octal := Value;
  Self := ol;
end;

procedure TOLInt64Helper.SetHexidecimal(const Value: string);
var
  ol: OLInt64;
begin
  ol.Hexidecimal := Value;
  Self := ol;
end;

procedure TOLInt64Helper.SetNumeralSystem32(const Value: string);
var
  ol: OLInt64;
begin
  ol.NumeralSystem32 := Value;
  Self := ol;
end;

procedure TOLInt64Helper.SetNumeralSystem64(const Value: string);
var
  ol: OLInt64;
begin
  ol.NumeralSystem64 := Value;
  Self := ol;
end;

procedure TOLInt64Helper.ForLoop(InitialValue: Int64; ToValue: Int64; Proc: TProc);
var
  ol: OLInt64;
begin
  ol := Self;
  ol.ForLoop(InitialValue, ToValue, Proc);
  Self := ol;
end;

function TOLInt64Helper.IsPrime(): Boolean;
var
  ol: OLInt64;
begin
  ol := Self;
  Result := ol.IsPrime();
end;

class function TOLInt64Helper.Random(MinValue: Int64; MaxValue: Int64): Int64;
begin
  Result := OLInt64.Random(MinValue, MaxValue);
end;

class function TOLInt64Helper.RandomPrime(MinValue: Int64; MaxValue: Int64): Int64;
begin
  Result := OLInt64.RandomPrime(MinValue, MaxValue);
end;

class function TOLInt64Helper.Random(MaxValue: Int64): Int64;
begin
  Result := OLInt64.Random(MaxValue);
end;

class function TOLInt64Helper.RandomPrime(MaxValue: Int64): Int64;
begin
  Result := OLInt64.RandomPrime(MaxValue);
end;

procedure TOLInt64Helper.SetRandom(MinValue: Int64; MaxValue: Int64);
var
  ol: OLInt64;
begin
  ol := Self;
  ol.SetRandom(MinValue, MaxValue);
  Self := ol;
end;

procedure TOLInt64Helper.SetRandom(MaxValue: Int64);
var
  ol: OLInt64;
begin
  ol := Self;
  ol.SetRandom(MaxValue);
  Self := ol;
end;

procedure TOLInt64Helper.SetRandomPrime(MinValue: Int64; MaxValue: Int64);
var
  ol: OLInt64;
begin
  ol := Self;
  ol.SetRandomPrime(MinValue, MaxValue);
  Self := ol;
end;

procedure TOLInt64Helper.SetRandomPrime(MaxValue: Int64);
var
  ol: OLInt64;
begin
  ol := Self;
  ol.SetRandomPrime(MaxValue);
  Self := ol;
end;

function TOLInt64Helper.ToBoolean: Boolean;
begin
  Result := Int64HelperFunctions.Instance_ToBoolean(Self);
end;

function TOLInt64Helper.ToHexString: string;
begin
  Result := Int64HelperFunctions.Instance_ToHexString(Self);
end;

function TOLInt64Helper.ToHexString(const MinDigits: Integer): string;
begin
  Result := Int64HelperFunctions.Instance_ToHexString(Self, MinDigits);
end;

function TOLInt64Helper.ToSingle: Single;
begin
  Result := Int64HelperFunctions.Instance_ToSingle(Self);
end;

function TOLInt64Helper.ToDouble: Double;
begin
  Result := Int64HelperFunctions.Instance_ToDouble(Self);
end;

function TOLInt64Helper.ToExtended: Extended;
begin
  Result := Int64HelperFunctions.Instance_ToExtended(Self);
end;

class function TOLInt64Helper.Size: Integer;
begin
  Result := Int64HelperFunctions.Type_Size;
end;

class function TOLInt64Helper.ToString(const Value: Int64): string;
begin
  Result := Int64HelperFunctions.Type_ToString(Value);
end;

class function TOLInt64Helper.Parse(const S: string): Int64;
begin
  Result := Int64HelperFunctions.Type_Parse(S);
end;

class function TOLInt64Helper.TryParse(const S: string; out Value: Int64): Boolean;
begin
  Result := Int64HelperFunctions.Type_TryParse(S, Value);
end;
{$IFEND}

{$IF CompilerVersion >= 24.0}
{ TOLStringHelper }

function TOLStringHelper.IsEmptyStr(): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.IsEmptyStr();
end;

function TOLStringHelper.Length(): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Length();
end;

function TOLStringHelper.Substring(StartIndex: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.MidStr(StartIndex, ol.Length() - StartIndex + 1);
end;

function TOLStringHelper.Substring(StartIndex, Length: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.MidStr(StartIndex, Length);
end;

function TOLStringHelper.LeftStr(Count: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LeftStr(Count);
end;

function TOLStringHelper.RightStr(Count: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.RightStr(Count);
end;

function TOLStringHelper.ContainsStr(SubString: string): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ContainsStr(SubString);
end;

function TOLStringHelper.Pos(SubString: string): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Pos(SubString);
end;

function TOLStringHelper.Replace(OldValue, NewValue: string): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Replaced(OldValue, NewValue);
end;

function TOLStringHelper.LowerCase(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LowerCase();
end;

function TOLStringHelper.UpperCase(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.UpperCase();
end;

function TOLStringHelper.Trim(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Trimmed();
end;

function TOLStringHelper.TrimLeft(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrimmedLeft();
end;

function TOLStringHelper.TrimRight(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrimmedRight();
end;

function TOLStringHelper.StartsStr(Value: string): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.StartsStr(Value);
end;

function TOLStringHelper.EndsStr(Value: string): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.EndsStr(Value);
end;

function TOLStringHelper.ReversedString(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ReversedString();
end;

function TOLStringHelper.HashStr(const Salt: string = ''): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.HashStr(Salt);
end;

function TOLStringHelper.Compressed(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Compressed();
end;

function TOLStringHelper.Decompressed(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Decompressed();
end;

function TOLStringHelper.ExtractedFileName(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ExtractedFileName();
end;

function TOLStringHelper.ExtractedFileExt(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ExtractedFileExt();
end;

function TOLStringHelper.ExtractedFileDriveString: string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ExtractedFileDriveString();
end;

function TOLStringHelper.ExtractedFileDir: string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ExtractedFileDir();
end;

function TOLStringHelper.ExtractedFilePath: string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ExtractedFilePath();
end;

procedure TOLStringHelper.LoadFromFile(const FileName: string);
var
  ol: OLString;
begin
  ol := Self;
  ol.LoadFromFile(FileName);
  Self := ol;
end;

procedure TOLStringHelper.LoadFromFile(const FileName: string; Encoding: TEncoding);
var
  ol: OLString;
begin
  ol := Self;
  ol.LoadFromFile(FileName, Encoding);
  Self := ol;
end;

procedure TOLStringHelper.SaveToFile(const FileName: string);
var
  ol: OLString;
begin
  ol := Self;
  ol.SaveToFile(FileName);
end;

procedure TOLStringHelper.SaveToFile(const FileName: string; Encoding: TEncoding);
var
  ol: OLString;
begin
  ol := Self;
  ol.SaveToFile(FileName, Encoding);
end;

procedure TOLStringHelper.EndcodeBase64FromFile(const FileName: string);
var
  ol: OLString;
begin
  ol := Self;
  ol.EndcodeBase64FromFile(FileName);
  Self := ol;
end;

procedure TOLStringHelper.DecodeBase64ToFile(const FileName: string);
var
  ol: OLString;
begin
  ol := Self;
  ol.DecodeBase64ToFile(FileName);
end;

function TOLStringHelper.Formated(const Data: array of const): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Formated(Data);
end;

function TOLStringHelper.FindTagStr(const Tag: string; const StartingPosition: Integer = 1): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.FindTagStr(Tag, StartingPosition);
end;

function TOLStringHelper.Like(Pattern: string): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Like(Pattern);
end;

function TOLStringHelper.SameStr(s: string): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.SameStr(s);
end;

function TOLStringHelper.SameText(s: string): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.SameText(s);
end;

function TOLStringHelper.ToInt(): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ToInt();
end;

function TOLStringHelper.TryToInt(): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TryToInt();
end;

function TOLStringHelper.TryToInt(var i: Integer): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TryToInt(i);
end;

function TOLStringHelper.LineCount(): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LineCount();
end;

function TOLStringHelper.LastLineIndex: Integer;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LastLineIndex();
end;

procedure TOLStringHelper.LineAdd(const NewLine: string);
var
  ol: OLString;
begin
  ol := Self;
  ol.LineAdd(NewLine);
  Self := ol;
end;

procedure TOLStringHelper.LineDelete(const LineIndex: Integer);
var
  ol: OLString;
begin
  ol := Self;
  ol.LineDelete(LineIndex);
  Self := ol;
end;

procedure TOLStringHelper.LineInsertAt(const LineIndex: Integer; const s: string);
var
  ol: OLString;
begin
  ol := Self;
  ol.LineInsertAt(LineIndex, s);
  Self := ol;
end;

function TOLStringHelper.LineIndexOf(const s: string): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LineIndexOf(s);
end;

function TOLStringHelper.LineIndexLike(const s: string; StartingFrom: Integer): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LineIndexLike(s, StartingFrom);
end;

function TOLStringHelper.LinesSorted: string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LinesSorted();
end;

function TOLStringHelper.GetLineStartPosition(const Index: Integer): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.GetLineStartPosition(Index);
end;

function TOLStringHelper.GetLineEndPosition(const Index: Integer): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.GetLineEndPosition(Index);
end;

function TOLStringHelper.LineEndAt(const LineIndex: Integer): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LineEndAt(LineIndex);
end;

function TOLStringHelper.MatchStr(const AValues: array of string): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.MatchStr(AValues);
end;

function TOLStringHelper.ContainsText(SubString: string): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ContainsText(SubString);
end;

function TOLStringHelper.StartsText(Value: string): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.StartsText(Value);
end;

function TOLStringHelper.EndsText(Value: string): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.EndsText(Value);
end;

function TOLStringHelper.IndexStr(const AValues: array of string): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.IndexStr(AValues);
end;

function TOLStringHelper.IndexText(const AValues: array of string): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.IndexText(AValues);
end;

function TOLStringHelper.MatchText(const AValues: array of string): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.MatchText(AValues);
end;

function TOLStringHelper.FindPatternStr(const InFront, Behind: string; const StartingPosition: Integer; const CaseSensitivity: TCaseSensitivity): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.FindPatternStr(InFront, Behind, StartingPosition, CaseSensitivity);
end;

function TOLStringHelper.FindPatternStr(const Tag: string; const StartingPosition: Integer; const CaseSensitivity: TCaseSensitivity): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.FindPatternStr(Tag, StartingPosition, CaseSensitivity);
end;

function TOLStringHelper.PosEx(const SubStr: string; const Offset: Integer): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.PosEx(SubStr, Offset);
end;

function TOLStringHelper.OccurrencesCount(const SubString: string): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.OccurrencesCount(SubString);
end;

function TOLStringHelper.MidStr(const AStart, ACount: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.MidStr(AStart, ACount);
end;

function TOLStringHelper.SplitString(const Delimiters: string = ';'):
    TOLStringDynArray;
var
  ol: OLString;
begin
  ol := Self;
  Result := TOLStringDynArray(ol.SplitString(Delimiters));
end;

function TOLStringHelper.MidStrEx(const AStart, AEnd: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.MidStrEx(AStart, AEnd);
end;

function TOLStringHelper.ReplacedStartingAt(const Position: Cardinal; const NewValue: string): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ReplacedStartingAt(Position, NewValue);
end;

function TOLStringHelper.EndingRemoved(const ACount: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.EndingRemoved(ACount);
end;

function TOLStringHelper.RightStrFrom(const StartFrom: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.RightStrFrom(StartFrom);
end;

function TOLStringHelper.LeadingSpacesAdded(const NewLength: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LeadingSpacesAdded(NewLength);
end;

function TOLStringHelper.TrailingSpacesAdded(const NewLength: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrailingSpacesAdded(NewLength);
end;

function TOLStringHelper.TrailingCharExcluded(const c: Char): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrailingCharExcluded(c);
end;

function TOLStringHelper.TrailingCharIncluded(const c: Char): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrailingCharIncluded(c);
end;

function TOLStringHelper.TrailingApostropheExcluded(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrailingApostropheExcluded();
end;

function TOLStringHelper.TrailingApostropheIncluded(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrailingApostropheIncluded();
end;

function TOLStringHelper.LeadingCharExcluded(const c: Char): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LeadingCharExcluded(c);
end;

function TOLStringHelper.LeadingCharIncluded(const c: Char): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LeadingCharIncluded(c);
end;

function TOLStringHelper.LeadingComaIncluded(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LeadingComaIncluded();
end;

function TOLStringHelper.LeadingApostropheExcluded(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LeadingApostropheExcluded();
end;

function TOLStringHelper.LeadingApostropheIncluded(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LeadingApostropheIncluded();
end;

function TOLStringHelper.ReplacedText(const AFromText, AToText: string): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ReplacedText(AFromText, AToText);
end;

function TOLStringHelper.Trimmed(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Trimmed();
end;

function TOLStringHelper.TrimmedLeft(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrimmedLeft();
end;

function TOLStringHelper.TrimmedRight(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrimmedRight();
end;

function TOLStringHelper.LeadingZerosAdded(const NewLength: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LeadingZerosAdded(NewLength);
end;

function TOLStringHelper.Inserted(const InsertStr: string; const Position: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Inserted(InsertStr, Position);
end;

function TOLStringHelper.Deleted(const FromPosition: Integer; const Count: Integer = 1): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Deleted(FromPosition, Count);
end;

function TOLStringHelper.DigitsOnly(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.DigitsOnly();
end;

function TOLStringHelper.NoDigits(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.NoDigits();
end;

function TOLStringHelper.SpacesRemoved(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.SpacesRemoved();
end;

function TOLStringHelper.QuotedStr(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.QuotedStr();
end;

function TOLStringHelper.InitCaps(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.InitCaps();
end;

function TOLStringHelper.AlphanumericsOnly(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.AlphanumericsOnly();
end;

class function TOLStringHelper.Compare(const StrA: string; const StrB: string):
    Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, StrB);
end;

class function TOLStringHelper.Compare(const StrA: string; const StrB: string;
    LocaleID: TLocaleID): Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, StrB, LocaleID);
end;

class function TOLStringHelper.Compare(const StrA: string; const StrB: string;
    IgnoreCase: Boolean): Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, StrB, IgnoreCase);
end;

class function TOLStringHelper.Compare(const StrA: string; const StrB: string;
    IgnoreCase: Boolean; LocaleID: TLocaleID): Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, StrB, IgnoreCase, LocaleID);
end;

class function TOLStringHelper.Compare(const StrA: string; const StrB: string;
    Options: TCompareOptions): Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, StrB, Options);
end;

class function TOLStringHelper.Compare(const StrA: string; const StrB: string;
    Options: TCompareOptions; LocaleID: TLocaleID): Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, StrB, Options, LocaleID);
end;

class function TOLStringHelper.Compare(const StrA: string; IndexA: Integer;
    const StrB: string; IndexB: Integer; Length: Integer): Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, IndexA, StrB, IndexB, Length);
end;

class function TOLStringHelper.Compare(const StrA: string; IndexA: Integer;
    const StrB: string; IndexB: Integer; Length: Integer; LocaleID: TLocaleID):
    Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, IndexA, StrB, IndexB, Length, LocaleID);
end;

class function TOLStringHelper.Compare(const StrA: string; IndexA: Integer;
    const StrB: string; IndexB: Integer; Length: Integer; IgnoreCase: Boolean):
    Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, IndexA, StrB, IndexB, Length, IgnoreCase);
end;

class function TOLStringHelper.Compare(const StrA: string; IndexA: Integer;
    const StrB: string; IndexB: Integer; Length: Integer; IgnoreCase: Boolean;
    LocaleID: TLocaleID): Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, IndexA, StrB, IndexB, Length,
    IgnoreCase, LocaleID);
end;

class function TOLStringHelper.Compare(const StrA: string; IndexA: Integer;
    const StrB: string; IndexB: Integer; Length: Integer; Options:
    TCompareOptions): Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, IndexA, StrB, IndexB, Length, Options);
end;

class function TOLStringHelper.Compare(const StrA: string; IndexA: Integer;
    const StrB: string; IndexB: Integer; Length: Integer; Options:
    TCompareOptions; LocaleID: TLocaleID): Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, IndexA, StrB, IndexB, Length,
    Options, LocaleID);
end;

class function TOLStringHelper.CompareOrdinal(const StrA: string; const StrB:
    string): Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, StrB);
end;

class function TOLStringHelper.CompareOrdinal(const StrA: string; IndexA:
    Integer; const StrB: string; IndexB: Integer; Length: Integer): Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, IndexA, StrB, IndexB, Length);
end;

class function TOLStringHelper.CompareText(const StrA: string; const StrB:
    string): Integer;
begin
  Result := StringHelperFunctions.Type_Compare(StrA, StrB);
end;

function TOLStringHelper.CompareTo(const strB: string): Integer;
begin
  Result := StringHelperFunctions.Instance_CompareTo(Self,  strB);
end;

function TOLStringHelper.Contains(const Value: string): Boolean;
begin
  Result := StringHelperFunctions.Instance_Contains(self, Value);
end;

class function TOLStringHelper.Copy(const Str: string): string;
begin
  Result := StringHelperFunctions.Type_Copy(Str);
end;

procedure TOLStringHelper.CopyTo(SourceIndex: Integer; var destination: array
    of Char; DestinationIndex: Integer; Count: Integer);
begin
  StringHelperFunctions.Instance_CopyTo(Self, SourceIndex, destination, DestinationIndex, Count);
end;

function TOLStringHelper.RepeatedString(const ACount: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.RepeatedString(ACount);
end;

function TOLStringHelper.LineAdded(const NewLine: string): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LineAdded(NewLine);
end;

function TOLStringHelper.TrailingPathDelimiterIncluded(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrailingPathDelimiterIncluded();
end;

function TOLStringHelper.TrailingPathDelimiterExcluded(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrailingPathDelimiterExcluded();
end;

class function TOLStringHelper.RandomString(const Length: Integer): string;
begin
  Result := OLString.RandomString(Length);
end;

function TOLStringHelper.GetLine(const Index: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Lines[Index];
end;

function TOLStringHelper.CSVFieldValue(const FieldIndex: Integer; const Delimiter: Char = ';'): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.CSVFieldValue(FieldIndex, Delimiter);
end;

procedure TOLStringHelper.SetParams(const ParamName: string; const Value: OLString);
var
  i: Integer;
  L: Integer;
  NewValue: string;
  ParamString: string;
  InsertLen: Integer;
begin
  NewValue := Self;
  ParamString := ':' + ParamName;

  L := System.Length(ParamString);
  InsertLen := System.Length(Value);
  i := 1;

  while i <= System.Length(NewValue) - L + 1 do
  begin
    if System.Copy(NewValue, i, L) = ParamString then
    begin
      if (i + L > System.Length(NewValue)) or
         (not TCharacter.IsLetterOrDigit(NewValue[i + L])) then
      begin
        NewValue :=
          System.Copy(NewValue, 1, i - 1) +
          Value +
          System.Copy(NewValue, i + L, MaxInt);

        Inc(i, InsertLen);
        Continue;
      end;
    end;

    Inc(i);
  end;

   Self := NewValue;
end;

function TOLStringHelper.GetCSV(const Index: Integer): OLString;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.CSV[Index];
end;

function TOLStringHelper.GetLines(const Index: Integer): OLString;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Lines[Index];
end;

procedure TOLStringHelper.SetCSV(const Index: Integer; const Value: OLString);
var
  ol: OLString;
begin
  ol := Self;
  ol.CSV[Index] := Value;
  Self := ol;
end;

function TOLStringHelper.GetCSV(const ColIndex, RowIndex: Integer): OLString;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.CSVCell[ColIndex, RowIndex];
end;

procedure TOLStringHelper.SetCSV(const ColIndex, RowIndex: Integer; const Value: OLString);
var
  ol: OLString;
begin
  ol := Self;
  ol.CSVCell[ColIndex, RowIndex] := Value;
  Self := ol;
end;

procedure TOLStringHelper.SetLines(const Index: Integer; const Value: OLString);
var
  ol: OLString;
begin
  ol := Self;
  ol.Lines[Index] := Value;
  Self := ol;
end;

function TOLStringHelper.ReplacedFirst(const AFromText, AToText: string): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ReplacedFirst(AFromText, AToText);
end;

function TOLStringHelper.Replaced(const AFromText, AToText: string): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Replaced(AFromText, AToText);
end;

function TOLStringHelper.ReplacedFirstText(const AFromText, AToText: string): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ReplacedFirstText(AFromText, AToText);
end;

function TOLStringHelper.LeadingCharsAdded(const C: Char; const NewLength: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LeadingCharsAdded(C, NewLength);
end;

function TOLStringHelper.TrailingCharsAdded(const C: Char; const NewLength: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrailingCharsAdded(C, NewLength);
end;

function TOLStringHelper.OccurrencesPosition(const SubString: string; const Index: Integer): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.OccurrencesPosition(SubString, Index);
end;

function TOLStringHelper.PosLast(const SubStr: string): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.PosLast(SubStr);
end;

function TOLStringHelper.PosLastEx(const SubStr: string; const NotAfterPosition: Integer; const CaseSensitivity: TCaseSensitivity): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.PosLastEx(SubStr, NotAfterPosition, CaseSensitivity);
end;

function TOLStringHelper.FindPattern(const InFront, Behind: string; const
    StartingPosition: Integer = 1): TStringPatternFind;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.FindPattern(InFront, Behind, StartingPosition);
end;

function TOLStringHelper.CSVIndex(const ValueToFind: string): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.CSVIndex(ValueToFind);
end;

function TOLStringHelper.CSVFieldCount(const Delimiter: Char): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.CSVFieldCount(Delimiter);
end;

procedure TOLStringHelper.SetCSVFieldValue(const FieldIndex: Integer; const Value: OLString; const Delimiter: Char);
var
  ol: OLString;
begin
  ol := Self;
  ol.SetCSVFieldValue(FieldIndex, Value, Delimiter);
  Self := ol;
end;

function TOLStringHelper.CSVFieldName(const index: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.CSVFieldName(index);
end;

function TOLStringHelper.CSVFieldByName(const FieldName: string; const RowIndex: Integer): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.CSVFieldByName(FieldName, RowIndex);
end;

function TOLStringHelper.IsValidIBAN(): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.IsValidIBAN();
end;

function TOLStringHelper.TrailingComaExcluded(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrailingComaExcluded();
end;

function TOLStringHelper.LeadingComaExcluded(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LeadingComaExcluded();
end;

function TOLStringHelper.TryToFloat(): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TryToFloat();
end;

function TOLStringHelper.TryToFloat(var e: Double): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TryToFloat(e);
end;

function TOLStringHelper.TryToDate(): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TryToDate();
end;

function TOLStringHelper.TryToDate(var d: TDate): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TryToDate(d);
end;

function TOLStringHelper.TryToCurr(): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TryToCurr();
end;

function TOLStringHelper.TryToCurr(var c: Currency): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TryToCurr(c);
end;

function TOLStringHelper.TryToInt64(): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TryToInt64();
end;

function TOLStringHelper.TryToInt64(var i: Int64): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TryToInt64(i);
end;

function TOLStringHelper.ToCurr(): OLCurrency;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ToCurr();
end;

function TOLStringHelper.ToDate(): OLDate;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ToDate();
end;

function TOLStringHelper.ToDateTime(): OLDateTime;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ToDateTime();
end;

function TOLStringHelper.ToFloat(): OLDouble;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ToFloat();
end;

function TOLStringHelper.ToInt64(): OLInt64;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ToInt64();
end;

function TOLStringHelper.TrySmartStrToDate(): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrySmartStrToDate();
end;

function TOLStringHelper.TrySmartStrToDate(var d: TDate): OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.TrySmartStrToDate(d);
end;

function TOLStringHelper.SmartStrToDate(): OLDate;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.SmartStrToDate();
end;

function TOLStringHelper.ToPWideChar(): PWideChar;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ToPWideChar();
end;

function TOLStringHelper.LastDelimiterPosition(const Delimiters: string): OLInteger;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.LastDelimiterPosition(Delimiters);
end;

function TOLStringHelper.Hash(const Salt: string): Cardinal;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Hash(Salt);
end;

function TOLStringHelper.ToSQLString(): string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.ToSQLString();
end;

function TOLStringHelper.GetHtmlUnicodeText: string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.HtmlUnicodeText;
end;

procedure TOLStringHelper.SetHtmlUnicodeText(const Value: string);
var
  ol: OLString;
begin
  ol := Self;
  ol.HtmlUnicodeText := Value;
  Self := ol;
end;

function TOLStringHelper.GetUrlEncodedText: string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.UrlEncodedText;
end;

procedure TOLStringHelper.SetUrlEncodedText(const Value: string);
var
  ol: OLString;
begin
  ol := Self;
  ol.UrlEncodedText := Value;
  Self := ol;
end;

function TOLStringHelper.GetBase64: string;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.Base64;
end;

procedure TOLStringHelper.SetBase64(const Value: string);
var
  ol: OLString;
begin
  ol := Self;
  ol.Base64 := Value;
  Self := ol;
end;

procedure TOLStringHelper.CopyToClipboard();
var
  ol: OLString;
begin
  ol := Self;
  ol.CopyToClipboard();
end;

function TOLStringHelper.CountChar(const C: Char): Integer;
begin
  Result := StringHelperFunctions.Instance_CountChar(Self, c);
end;

class function TOLStringHelper.Create(C: Char; Count: Integer): string;
begin
  Result := StringHelperFunctions.Type_Create(c, Count);
end;

class function TOLStringHelper.Create(const Value: array of Char; StartIndex:
    Integer; Length: Integer): string;
begin
  Result := StringHelperFunctions.Type_Create(Value, StartIndex, Length);
end;

class function TOLStringHelper.Create(const Value: array of Char): string;
begin
  Result := Create(Value);
end;

function TOLStringHelper.DeQuotedString: string;
begin
  Result := StringHelperFunctions.Instance_DeQuotedString(Self);
end;

function TOLStringHelper.DeQuotedString(const QuoteChar: Char): string;
begin
  Result := StringHelperFunctions.Instance_DeQuotedString(Self, QuoteChar);
end;

class function TOLStringHelper.EndsText(const ASubText, AText: string): Boolean;
begin
  Result := StringHelperFunctions.Type_EndsText(ASubText, AText);
end;

function TOLStringHelper.EndsWith(const Value: string): Boolean;
begin
  Result := StringHelperFunctions.Instance_EndsWith(Self, Value);
end;

function TOLStringHelper.EndsWith(const Value: string; IgnoreCase: Boolean):
    Boolean;
begin
  Result := StringHelperFunctions.Instance_EndsWith(Self, Value, IgnoreCase);
end;

function TOLStringHelper.Equals(const Value: string): Boolean;
begin
  Result := StringHelperFunctions.Instance_Equals(Self, Value);
end;

class function TOLStringHelper.Equals(const a: string; const b: string):
    Boolean;
begin
  Result := StringHelperFunctions.Type_Equals(a, b);
end;

class function TOLStringHelper.Format(const Format: string; const args: array
    of const): string;
begin
  Result := StringHelperFunctions.Type_Format(Format, args);
end;

procedure TOLStringHelper.PasteFromClipboard();
var
  ol: OLString;
begin
  ol := Self;
  ol.PasteFromClipboard();
  Self := ol;
end;

procedure TOLStringHelper.GetFromUrl(const URL: string; Timeout: LongWord);
var
  ol: OLString;
begin
  ol := Self;
  ol.GetFromUrl(URL, Timeout);
  Self := ol;
end;

function TOLStringHelper.GetHashCode: Integer;
begin
  Result := StringHelperFunctions.Instance_GetHashCode(Self);
end;

class function TOLStringHelper.RandomFrom(const AValues: array of string): string;
begin
  Result := OLString.RandomFrom(AValues);
end;

{$IF CompilerVersion >= 27.0}
function TOLStringHelper.GetJSON(const JsonFieldName: string): OLString;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.JSON[JsonFieldName];
end;

procedure TOLStringHelper.SetJSON(const JsonFieldName: string; const Value: OLString);
var
  ol: OLString;
begin
  ol := Self;
  ol.JSON[JsonFieldName] := Value;
  Self := ol;
end;

function TOLStringHelper.GetXML(const XPath: string): OLString;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.XML[XPath];
end;

procedure TOLStringHelper.SetXML(const XPath: string; const Value: OLString);
var
  ol: OLString;
begin
  ol := Self;
  ol.XML[XPath] := Value;
  Self := ol;
end;

function TOLStringHelper.GetJsonCollection(const JsonPath: string): TArray<string>;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.GetJsonCollection(JsonPath);
end;

function TOLStringHelper.GetXmlCollection(const XPath: string): TArray<string>;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.GetXmlCollection(XPath);
end;

function TOLStringHelper.IndexOf(Value: Char): Integer;
begin
  Result := StringHelperFunctions.Instance_IndexOf(Self, Value);
end;

function TOLStringHelper.IndexOf(const Value: string): Integer;
begin
  Result := StringHelperFunctions.Instance_IndexOf(Self, Value);
end;

function TOLStringHelper.IndexOf(Value: Char; StartIndex: Integer): Integer;
begin
  Result := StringHelperFunctions.Instance_IndexOf(Self, Value, StartIndex);
end;

function TOLStringHelper.IndexOf(const Value: string; StartIndex: Integer):
    Integer;
begin
  Result := StringHelperFunctions.Instance_IndexOf(Self, Value, StartIndex);
end;

function TOLStringHelper.IndexOf(Value: Char; StartIndex: Integer; Count:
    Integer): Integer;
begin
  Result := StringHelperFunctions.Instance_IndexOf(Self, Value, StartIndex, Count);
end;

function TOLStringHelper.IndexOf(const Value: string; StartIndex: Integer;
    Count: Integer): Integer;
begin
  Result := StringHelperFunctions.Instance_IndexOf(Self, Value, StartIndex, Count);
end;

function TOLStringHelper.IndexOfAny(const AnyOf: array of Char): Integer;
begin
  Result := StringHelperFunctions.Instance_IndexOfAny(Self, AnyOf);
end;

function TOLStringHelper.IndexOfAny(const AnyOf: array of Char; StartIndex:
    Integer): Integer;
begin
  Result := StringHelperFunctions.Instance_IndexOfAny(Self, AnyOf, StartIndex);
end;

function TOLStringHelper.IndexOfAny(const AnyOf: array of Char; StartIndex:
    Integer; Count: Integer): Integer;
begin
  Result := StringHelperFunctions.Instance_IndexOfAny(Self, AnyOf, StartIndex);
end;

function TOLStringHelper.IndexOfAnyUnquoted(const AnyOf: array of Char;
    StartQuote, EndQuote: Char): Integer;
begin
  Result := StringHelperFunctions.Instance_IndexOfAnyUnquoted(Self, AnyOf, StartQuote, EndQuote);
end;

function TOLStringHelper.IndexOfAnyUnquoted(const AnyOf: array of Char;
    StartQuote, EndQuote: Char; StartIndex: Integer): Integer;
begin
  Result := StringHelperFunctions.Instance_IndexOfAnyUnquoted(Self, AnyOf, StartQuote,
    EndQuote, StartIndex);
end;

function TOLStringHelper.IndexOfAnyUnquoted(const AnyOf: array of Char;
    StartQuote, EndQuote: Char; StartIndex: Integer; Count: Integer): Integer;
begin
  Result := StringHelperFunctions.Instance_IndexOfAnyUnquoted(Self, AnyOf, StartQuote,
    EndQuote, StartIndex, Count);
end;

function TOLStringHelper.Insert(StartIndex: Integer; const Value: string):
    string;
begin
  Result := StringHelperFunctions.Instance_Insert(Self, StartIndex, Value);
end;

function TOLStringHelper.IsDelimiter(const Delimiters: string; Index: Integer):
    Boolean;
begin
  Result := StringHelperFunctions.Instance_IsDelimiter(self, Delimiters, Index);
end;

function TOLStringHelper.IsEmpty: Boolean;
begin
  Result := StringHelperFunctions.Instance_IsEmpty(Self);
end;

function TOLStringHelper.IsJSON: OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.IsJSON;
end;

function TOLStringHelper.IsXML: OLBoolean;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.IsXML;
end;

function TOLStringHelper.PrettyPrint: OLString;
var
  ol: OLString;
begin
  ol := Self;
  Result := ol.PrettyPrint;
end;

class function TOLStringHelper.IsNullOrEmpty(const Value: string): Boolean;
begin
  Result := StringHelperFunctions.Type_IsNullOrEmpty(Value);
end;

class function TOLStringHelper.IsNullOrWhiteSpace(const Value: string): Boolean;
begin
  Result := StringHelperFunctions.Type_IsNullOrWhiteSpace(Value);
end;

class function TOLStringHelper.Join(const Separator: string; const Values:
    array of const): string;
begin
  Result := StringHelperFunctions.Type_Join(Separator, Values);
end;

class function TOLStringHelper.Join(const Separator: string; const Values:
    array of string): string;
begin
  Result := StringHelperFunctions.Type_Join(Separator, Values);
end;

class function TOLStringHelper.Join(const Separator: string; const Values:
    IEnumerator<string>): string;
begin
  Result := StringHelperFunctions.Type_Join(Separator, Values);
end;

class function TOLStringHelper.Join(const Separator: string; const Values:
    IEnumerable<string>): string;
begin
  Result := StringHelperFunctions.Type_Join(Separator, Values);
end;

class function TOLStringHelper.Join(const Separator: string; const Values:
    array of string; StartIndex: Integer; Count: Integer): string;
begin
  Result := StringHelperFunctions.Type_Join(Separator, Values, StartIndex, Count);
end;

function TOLStringHelper.LastDelimiter(const Delims: string): Integer;
begin
  Result := StringHelperFunctions.Instance_LastDelimiter(Self, Delims);
end;

function TOLStringHelper.LastDelimiter(const Delims: TSysCharSet): Integer;
begin
  Result := StringHelperFunctions.Instance_LastDelimiter(Self, Delims);
end;

function TOLStringHelper.LastIndexOf(Value: Char): Integer;
begin
  Result := StringHelperFunctions.Instance_LastIndexOf(Self, Value);
end;

function TOLStringHelper.LastIndexOf(const Value: string): Integer;
begin
  Result := StringHelperFunctions.Instance_LastIndexOf(Self, Value);
end;

function TOLStringHelper.LastIndexOf(Value: Char; StartIndex: Integer): Integer;
begin
  Result := StringHelperFunctions.Instance_LastIndexOf(Self, Value, StartIndex);
end;

function TOLStringHelper.LastIndexOf(const Value: string; StartIndex: Integer):
    Integer;
begin
  Result := StringHelperFunctions.Instance_LastIndexOf(Self, Value, StartIndex);
end;

function TOLStringHelper.LastIndexOf(Value: Char; StartIndex: Integer; Count:
    Integer): Integer;
begin
  Result := StringHelperFunctions.Instance_LastIndexOf(Self, Value, StartIndex, Count);
end;

function TOLStringHelper.LastIndexOf(const Value: string; StartIndex: Integer;
    Count: Integer): Integer;
begin
  Result := StringHelperFunctions.Instance_LastIndexOf(Self, Value, StartIndex, Count);
end;

function TOLStringHelper.LastIndexOfAny(const AnyOf: array of Char): Integer;
begin
  Result := StringHelperFunctions.Instance_LastIndexOfAny(Self, AnyOf);
end;

function TOLStringHelper.LastIndexOfAny(const AnyOf: array of Char; StartIndex:
    Integer): Integer;
begin
  Result := StringHelperFunctions.Instance_LastIndexOfAny(Self, AnyOf, StartIndex);
end;

function TOLStringHelper.LastIndexOfAny(const AnyOf: array of Char; StartIndex:
    Integer; Count: Integer): Integer;
begin
  Result := StringHelperFunctions.Instance_LastIndexOfAny(Self, AnyOf, StartIndex, Count);
end;

class function TOLStringHelper.LowerCase(const S: string): string;
begin
  Result := StringHelperFunctions.Type_LowerCase(s);
end;

class function TOLStringHelper.LowerCase(const S: string; LocaleOptions:
    TLocaleOptions): string;
begin
  Result := StringHelperFunctions.Type_LowerCase(s, LocaleOptions);
end;

function TOLStringHelper.PadLeft(TotalWidth: Integer): string;
begin
  Result := StringHelperFunctions.Instance_PadLeft(Self, TotalWidth);
end;

function TOLStringHelper.PadLeft(TotalWidth: Integer; PaddingChar: Char):
    string;
begin
  Result := StringHelperFunctions.Instance_PadLeft(Self, TotalWidth);
end;

function TOLStringHelper.PadRight(TotalWidth: Integer): string;
begin
  Result := StringHelperFunctions.Instance_PadRight(Self, TotalWidth);
end;

function TOLStringHelper.PadRight(TotalWidth: Integer; PaddingChar: Char):
    string;
begin
  Result := StringHelperFunctions.Instance_PadRight(Self, TotalWidth, PaddingChar);
end;

class function TOLStringHelper.Parse(const Value: Integer): string;
begin
  Result := StringHelperFunctions.Type_Parse(Value);
end;

class function TOLStringHelper.Parse(const Value: Int64): string;
begin
  Result := StringHelperFunctions.Type_Parse(Value);
end;

class function TOLStringHelper.Parse(const Value: Boolean): string;
begin
  Result := StringHelperFunctions.Type_Parse(Value);
end;

class function TOLStringHelper.Parse(const Value: Extended): string;
begin
  Result := StringHelperFunctions.Type_Parse(Value);
end;

function TOLStringHelper.QuotedString: string;
begin
  Result := StringHelperFunctions.Instance_QuotedString(Self);
end;

function TOLStringHelper.QuotedString(const QuoteChar: Char): string;
begin
  Result := StringHelperFunctions.Instance_QuotedString(Self, QuoteChar);
end;

function TOLStringHelper.Remove(StartIndex: Integer): string;
begin
  Result := StringHelperFunctions.Instance_Remove(Self, StartIndex);
end;

function TOLStringHelper.Remove(StartIndex: Integer; Count: Integer): string;
begin
  Result := StringHelperFunctions.Instance_Remove(Self, StartIndex, Count);
end;

function TOLStringHelper.Replace(OldChar: Char; NewChar: Char): string;
begin
  Result := StringHelperFunctions.Instance_Replace(Self, OldChar, NewChar);
end;

function TOLStringHelper.Replace(OldChar: Char; NewChar: Char; ReplaceFlags:
    TReplaceFlags): string;
begin
  Result := StringHelperFunctions.Instance_Replace(Self, OldChar, NewChar, ReplaceFlags);
end;

function TOLStringHelper.Replace(const OldValue: string; const NewValue:
    string; ReplaceFlags: TReplaceFlags): string;
begin
  Result := StringHelperFunctions.Instance_Replace(Self, OldValue, NewValue, ReplaceFlags);
end;

function TOLStringHelper.Split(const Separator: array of Char): TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator);
end;

function TOLStringHelper.Split(const Separator: array of Char; Count: Integer):
    TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, Count);
end;

function TOLStringHelper.Split(const Separator: array of Char; Options:
    TStringSplitOptions): TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, Options);
end;

function TOLStringHelper.Split(const Separator: array of Char; Count: Integer;
    Options: TStringSplitOptions): TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, Count, Options);
end;

function TOLStringHelper.Split(const Separator: array of string):
    TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator);
end;

function TOLStringHelper.Split(const Separator: array of string; Count:
    Integer): TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, Count);
end;

function TOLStringHelper.Split(const Separator: array of string; Options:
    TStringSplitOptions): TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, Options);
end;

function TOLStringHelper.Split(const Separator: array of string; Count:
    Integer; Options: TStringSplitOptions): TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, Count, Options);
end;

function TOLStringHelper.Split(const Separator: array of Char; Quote: Char):
    TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, Quote);
end;

function TOLStringHelper.Split(const Separator: array of Char; QuoteStart,
    QuoteEnd: Char): TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, QuoteStart, QuoteEnd);
end;

function TOLStringHelper.Split(const Separator: array of Char; QuoteStart,
    QuoteEnd: Char; Options: TStringSplitOptions): TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, QuoteStart, QuoteEnd, Options);
end;

function TOLStringHelper.Split(const Separator: array of Char; QuoteStart,
    QuoteEnd: Char; Count: Integer): TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, QuoteStart, QuoteEnd, Count);
end;

function TOLStringHelper.Split(const Separator: array of Char; QuoteStart,
    QuoteEnd: Char; Count: Integer; Options: TStringSplitOptions):
    TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, QuoteStart, QuoteEnd,
    Count, Options);
end;

function TOLStringHelper.Split(const Separator: array of string; Quote: Char):
    TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, Quote);
end;

function TOLStringHelper.Split(const Separator: array of string; QuoteStart,
    QuoteEnd: Char): TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, QuoteStart, QuoteEnd);
end;

function TOLStringHelper.Split(const Separator: array of string; QuoteStart,
    QuoteEnd: Char; Options: TStringSplitOptions): TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, QuoteStart,
    QuoteEnd, Options);
end;

function TOLStringHelper.Split(const Separator: array of string; QuoteStart,
    QuoteEnd: Char; Count: Integer): TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, QuoteStart, QuoteEnd, Count);
end;

function TOLStringHelper.Split(const Separator: array of string; QuoteStart,
    QuoteEnd: Char; Count: Integer; Options: TStringSplitOptions):
    TArray<string>;
begin
  Result := StringHelperFunctions.Instance_Split(self, Separator, QuoteStart,
    QuoteEnd, Count, Options);
end;

class function TOLStringHelper.StartsText(const ASubText, AText: string):
    Boolean;
begin
  Result := StringHelperFunctions.Type_StartsText(ASubText, AText);
end;

function TOLStringHelper.StartsWith(const Value: string): Boolean;
begin
  Result := StringHelperFunctions.Instance_StartsWith(Self, Value);
end;

function TOLStringHelper.StartsWith(const Value: string; IgnoreCase: Boolean):
    Boolean;
begin
  Result := StringHelperFunctions.Instance_StartsWith(Self, Value, IgnoreCase);
end;

class function TOLStringHelper.ToBoolean(const S: string): Boolean;
begin
  Result := StringHelperFunctions.Instance_ToBoolean(s);
end;

function TOLStringHelper.ToBoolean: Boolean;
begin
  Result := StringHelperFunctions.Instance_ToBoolean(Self);
end;

function TOLStringHelper.ToCharArray: TArray<Char>;
begin
  Result := StringHelperFunctions.Instance_ToCharArray(Self);
end;

function TOLStringHelper.ToCharArray(StartIndex: Integer; Length: Integer):
    TArray<Char>;
begin
  Result := StringHelperFunctions.Instance_ToCharArray(Self, StartIndex, Length);
end;

class function TOLStringHelper.ToDouble(const S: string): Double;
begin
  Result := StringHelperFunctions.Type_ToDouble(s);
end;

function TOLStringHelper.ToDouble: Double;
begin
  Result := StringHelperFunctions.Instance_ToDouble(self);
end;

class function TOLStringHelper.ToExtended(const S: string): Extended;
begin
  Result := StringHelperFunctions.Instance_ToExtended(s);
end;

function TOLStringHelper.ToExtended: Extended;
begin
  Result := StringHelperFunctions.Instance_ToExtended(Self);
end;

class function TOLStringHelper.ToInteger(const S: string): Integer;
begin
  Result := StringHelperFunctions.Type_ToInteger(s);
end;

function TOLStringHelper.ToInteger: Integer;
begin
  Result := StringHelperFunctions.Instance_ToInteger(Self);
end;

function TOLStringHelper.ToLower: string;
begin
  Result := StringHelperFunctions.Instance_ToLower(Self);
end;

function TOLStringHelper.ToLower(LocaleID: TLocaleID): string;
begin
  Result := StringHelperFunctions.Instance_ToLower(Self, LocaleID);
end;

function TOLStringHelper.ToLowerInvariant: string;
begin
  Result := StringHelperFunctions.Instance_ToLowerInvariant(Self);
end;

class function TOLStringHelper.ToSingle(const S: string): Single;
begin
  Result := StringHelperFunctions.Type_ToSingle(s);
end;

function TOLStringHelper.ToSingle: Single;
begin
  Result := StringHelperFunctions.Instance_ToSingle(Self);
end;

function TOLStringHelper.ToUpper: string;
begin
  Result := StringHelperFunctions.Instance_ToUpper(Self);
end;

function TOLStringHelper.ToUpper(LocaleID: TLocaleID): string;
begin
  Result := StringHelperFunctions.Instance_ToUpper(Self, LocaleID);
end;

function TOLStringHelper.ToUpperInvariant: string;
begin
  Result := StringHelperFunctions.Instance_ToUpperInvariant(Self);
end;

function TOLStringHelper.Trim(const TrimChars: array of Char): string;
begin
  Result := StringHelperFunctions.Instance_TrimLeft(Self, TrimChars);
end;

function TOLStringHelper.TrimEnd(const TrimChars: array of Char): string;
begin
  Result := TrimRight(TrimChars);
end;

function TOLStringHelper.TrimLeft(const TrimChars: array of Char): string;
begin
  Result := StringHelperFunctions.Instance_TrimLeft(Self, TrimChars);
end;

function TOLStringHelper.TrimRight(const TrimChars: array of Char): string;
begin
  Result := StringHelperFunctions.Instance_TrimRight(self, TrimChars);
end;

function TOLStringHelper.TrimStart(const TrimChars: array of Char): string;
begin
  Result := TrimLeft(TrimChars);
end;

class function TOLStringHelper.UpperCase(const S: string): string;
begin
  Result := StringHelperFunctions.Type_UpperCase(s);
end;

class function TOLStringHelper.UpperCase(const S: string; LocaleOptions:
    TLocaleOptions): string;
begin
  Result := StringHelperFunctions.Type_UpperCase(s, LocaleOptions);
end;

{$IFEND}  //CompilerVersion >= 27.0

{$IFEND}

{$IFEND}     //CompilerVersion >= 24.0

{$IF CompilerVersion >= 34.0}
{ OLDictionary<K, V> }

{$IF CompilerVersion >= 31.0}
class operator OLDictionary<K, V>.Assign(var Dest: OLDictionary<K, V>; const [ref] Src: OLDictionary<K, V>);
{$ELSE}
class operator OLDictionary<K, V>.Assign(var Dest: OLDictionary<K, V>; const Src: OLDictionary<K, V>);
{$IFEND}
begin
  Dest.FEngine := Src.FEngine;
end;

procedure OLDictionary<K, V>.Clear;
begin
  FEngine.Clear;
end;

procedure OLDictionary<K, V>.Add(const Key: K; const Value: V);
begin
  FEngine.Add(Key, Value);
end;

function OLDictionary<K, V>.Remove(const Key: K): OLBoolean;
begin
  Result := FEngine.Remove(Key);
end;

function OLDictionary<K, V>.TryGetValue(const Key: K; out Value: V): OLBoolean;
begin
  Result := FEngine.TryGetValue(Key, Value);
end;

function OLDictionary<K, V>.ContainsKey(const Key: K): OLBoolean;
begin
  Result := FEngine.ContainsKey(Key);
end;

function OLDictionary<K, V>.Count: Integer;
begin
  Result := FEngine.Count;
end;

function OLDictionary<K, V>.GetEnumerator: TDictionary<K, V>.TPairEnumerator;
begin
  Result := FEngine.GetEnumerator;
end;

function OLDictionary<K, V>.ToArray: TArray<TPair<K, V>>;
begin
  Result := FEngine.ToArray;
end;

function OLDictionary<K, V>.GetValue(const Key: K): V;
begin
  Result := FEngine.Values[Key];
end;

procedure OLDictionary<K, V>.SetValue(const Key: K; const Value: V);
begin
  FEngine.Values[Key] := Value;
end;

function OLDictionary<K, V>.GetKeys: TArray<K>;
begin
  Result := FEngine.Keys;
end;
{$IFEND}


// TOLStringHelper Immutable "With..." methods

// TOLStringHelper Immutable "From..." methods (static factories)



class function TOLStringHelper.FromHtmlUnicodeText(const Value: string): string;
var
  OutPut: OLString;
begin
  OutPut.HtmlUnicodeText := Value;
  Result := OutPut;
end;

class function TOLStringHelper.FromUrlEncodedText(const Value: string): string;
var
  OutPut: OLString;
begin
  OutPut.UrlEncodedText := Value;
  Result := OutPut;
end;

class function TOLStringHelper.FromBase64(const Value: string): string;
var
  OutPut: OLString;
begin
  OutPut.Base64 := Value;
  Result := OutPut;
end;

class function TOLStringHelper.FromBase64File(const FileName: string): string;
var
  OutPut: OLString;
begin
  OutPut.EndcodeBase64FromFile(FileName);
  Result := OutPut;
end;

class function TOLStringHelper.FromUrl(const URL: string): string;
var
  OutPut: OLString;
begin
  OutPut.GetFromUrl(URL);
  Result := OutPut;
end;

class function TOLStringHelper.FromClipboard: string;
var
  OutPut: OLString;
begin
  OutPut.PasteFromClipboard;
  Result := OutPut;
end;

// TOLStringHelper Immutable "With..." methods (instance modifiers)

function TOLStringHelper.WithLineAdded(const Line: string): string;
var
  OutPut: OLString;
begin
  OutPut := Self;
  OutPut.LineAdd(Line);
  Result := OutPut;
end;

function TOLStringHelper.WithLineChanged(const Index: Integer; const Line: string): string;
var
  OutPut: OLString;
begin
  OutPut := Self;
  OutPut.Lines[Index] := Line;
  Result := OutPut;
end;

function TOLStringHelper.WithLineDeleted(const Index: Integer): string;
var
  OutPut: OLString;
begin
  OutPut := Self;
  OutPut.LineDelete(Index);
  Result := OutPut;
end;

function TOLStringHelper.WithLineInserted(const Index: Integer; const Line: string): string;
var
  OutPut: OLString;
begin
  OutPut := Self;
  OutPut.LineInsertAt(Index, Line);
  Result := OutPut;
end;

function TOLStringHelper.WithCSV(const Index: Integer; const Value: string): string;
begin
  Result := Self;
  Result.SetCSV(Index, Value);
end;

function TOLStringHelper.WithCSVCell(const ColIndex, RowIndex: Integer; const Value: string): string;
begin
  Result := Self;
  Result.SetCSV(ColIndex, RowIndex, Value);
end;

function TOLStringHelper.WithParam(const ParamName: string; const Value: string): string;
begin
  Result := Self;
  Result.SetParams(ParamName, Value);
end;

{$IF CompilerVersion >= 27.0}
function TOLStringHelper.WithJSON(const Field: string; const Value: string): string;
begin
  Result := Self;
  Result.SetJSON(Field, Value);
end;

function TOLStringHelper.WithXML(const XPath: string; const Value: string): string;
begin
  Result := Self;
  Result.SetXML(XPath, Value);
end;
{$IFEND}

end.
