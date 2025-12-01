unit OLTypes;

interface

uses
  OLBooleanType, OLCurrencyType, OLDateTimeType, OLDateType, OLDoubleType,
  OLIntegerType, OLInt64Type, OLStringType, SmartToDate, OLArrays, OLDictionaries,
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
  {$IFEND};

type
  TRttiFieldHack = class(TRttiField);

const
  ERROR_STRING = '#ERROR';
  DOUBLE_FORMAT = '###,###,###,##0.0####';
  CURRENCY_FORMAT = '###,###,###,##0.00##';

type
  TFunctionReturningOLInteger = reference to function(): OLInteger;
  TFunctionReturningOLString = reference to function(): OLString;
  TFunctionReturningOLDouble = reference to function(): OLDouble;
  TFunctionReturningOLCurrency = reference to function(): OLCurrency;
  TFunctionReturningOLDate = reference to function(): OLDate;
  TFunctionReturningOLDateTime= reference to function(): OLDateTime;


  OLBoolean = OLBooleanType.OLBoolean;
  OLCurrency = OLCurrencyType.OLCurrency;
  OLDecimal = OLCurrencyType.OLCurrency;
  OLDateTime = OLDateTimeType.OLDateTime;
  OLDate = OLDateType.OLDate;
  OLDouble = OLDoubleType.OLDouble;
  OLInteger = OLIntegerType.OLInteger;
  OLInt64 = OLInt64Type.OLInt64;
  OLString = OLStringType.OLString;

  POLBoolean = OLBooleanType.POLBoolean;
  POLCurrency = OLCurrencyType.POLCurrency;
  POLDecimal = OLCurrencyType.POLCurrency;
  POLDateTime = OLDateTimeType.POLDateTime;
  POLDate = OLDateType.POLDate;
  POLDouble = OLDoubleType.POLDouble;
  POLInteger = OLIntegerType.POLInteger;
  POLInt64 = OLInt64Type.POLInt64;
  POLString = OLStringType.POLString;

  TBooleanDynArray = OLArrays.TBooleanDynArray;
  TCurrencyDynArray = OLArrays.TCurrencyDynArray;
  TDateTimeDynArray = OLArrays.TDateTimeDynArray;
  TDateDynArray = OLArrays.TDateDynArray;
  TDoubleDynArray = OLArrays.TDoubleDynArray;
  TIntegerDynArray = OLArrays.TIntegerDynArray;
  TInt64DynArray = OLArrays.TInt64DynArray;
  TByteDynArray = OLArrays.TByteDynArray;
  TStringDynArray = OLArrays.TStringDynArray;

  OLBooleanArray = OLArrays.OLBooleanArray;
  OLCurrencyArray = OLArrays.OLCurrencyArray;
  OLDateTimeArray = OLArrays.OLDateTimeArray;

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
  {$IFEND}

  TStringPatternFind = OLStringType.TStringPatternFind;

  TCaseSensitivity = OLStringType.TCaseSensitivity;
  const
    csCaseSensitive = OLStringType.csCaseSensitive;
    csCaseInsensitive = OLStringType.csCaseInsensitive;

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
  // today, yesterday, tomorow
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

    // Predicates
    function IsDividableBy(const i: Integer): Boolean;
    function IsOdd(): Boolean;
    function IsEven(): Boolean;
    function IsPositive(): Boolean;
    function IsNegative(): Boolean;
    function IsNonNegative(): Boolean;
    function IsPrime(): Boolean;

    // Mathematical operations
    function Sqr(): Integer;
    function Power(const Exponent: LongWord): Integer; overload;
    function Power(const Exponent: Integer): Double; overload;
    function Abs(): Integer;
    function Max(const i: Integer): Integer;
    function Min(const i: Integer): Integer;
    function Round(const Digits: Integer): Integer;

    // Range operations
    function Between(const BottomIncluded, TopIncluded: Integer): Boolean;
    function Increased(const IncreasedBy: Integer = 1): Integer;
    function Decreased(const DecreasedBy: Integer = 1): Integer;
    function Replaced(const FromValue: Integer; const ToValue: Integer): Integer;

    // String conversion
    function ToString(): string;
    function ToSQLString(): string;
    function ToNumeralSystem(const Base: Integer): string;

    // Number system properties
    function GetBinary: string;
    function GetOctal: string;
    function GetHexidecimal: string;
    function GetNumeralSystem32: string;
    function GetNumeralSystem64: string;
    procedure SetBinary(const Value: string);
    procedure SetOctal(const Value: string);
    procedure SetHexidecimal(const Value: string);
    procedure SetNumeralSystem32(const Value: string);
    procedure SetNumeralSystem64(const Value: string);

    property Binary: string read GetBinary write SetBinary;
    property Octal: string read GetOctal write SetOctal;
    property Hexidecimal: string read GetHexidecimal write SetHexidecimal;
    property NumeralSystem32: string read GetNumeralSystem32 write SetNumeralSystem32;
    property NumeralSystem64: string read GetNumeralSystem64 write SetNumeralSystem64;

    // Loop utility
    procedure ForLoop(const InitialValue: Integer; const ToValue: Integer; const Proc: TProc);

    // Random generation
    class function Random(const MinValue: Integer; const MaxValue: Integer): Integer; overload; static;
    class function RandomPrime(const MinValue: Integer; const MaxValue: Integer): Integer; overload; static;
    class function Random(const MaxValue: Integer = MaxInt): Integer; overload; static;
    class function RandomPrime(const MaxValue: Integer = MaxInt): Integer; overload; static;
    procedure SetRandom(const MinValue: Integer; const MaxValue: Integer); overload;
    procedure SetRandom(const MaxValue: Integer = MaxInt); overload;
    procedure SetRandomPrime(const MinValue: Integer; const MaxValue: Integer); overload;
    procedure SetRandomPrime(const MaxValue: Integer = MaxInt); overload;

   end;
  {$IFEND}

  {$IF CompilerVersion >= 24.0}
  TOLBooleanHelper = record helper for Boolean
  public
    function ToString(): string;
    function ToSQLString(): string;
    function IfThen(const ATrue: string; const AFalse: string = ''): string; overload;
    function IfThen(const ATrue: Integer; const AFalse: Integer): Integer; overload;
    function IfThen(const ATrue: Currency; const AFalse: Currency): Currency; overload;
    function IfThen(const ATrue: Extended; const AFalse: Extended): Extended; overload;
    function IfThen(const ATrue: TDateTime; const AFalse: TDateTime): TDateTime; overload;
    function IfThen(const ATrue: Boolean; const AFalse: Boolean): Boolean; overload;
  end;
  {$IFEND}

  {$IF CompilerVersion >= 24.0}
  TOLDoubleHelper = record helper for Double
  public
    function Sqr(): Double;
    function Sqrt(): Double;
    function Power(const Exponent: Integer): Double; overload;
    function Power(const Exponent: Extended): Double; overload;
    function IsPositive(): Boolean;
    function IsNegative(): Boolean;
    function IsNonNegative(): Boolean;
    function Max(const d: Double): Double;
    function Min(const d: Double): Double;
    function Abs(): Double;
    function ToString(): string; overload;
    function ToString(const Digits: Integer; const Format: TFloatFormat = ffFixed; const Precision: Integer = 16): string; overload;
    function ToString(ThousandSeparator: Char; DecimalSeparator: Char = '.'; Format: string = '###,###,###,##0.##'): string; overload;
    function ToSQLString(): string;
    function Round(const PowerOfTen: Integer): Double; overload;
    function Round(): Integer; overload;
    function Floor(): Integer;
    function Ceil(): Integer;
    function IsNan(): Boolean;
    function IsInfinite(): Boolean;
    function IsZero(const Epsilon: Extended = 0): Boolean;
    function InRange(const AMin, AMax: Extended): Boolean;
    function EnsureRange(const AMin, AMax: Extended): Extended;
    function SameValue(const B: Extended; const Epsilon: Extended = 0): Boolean;
    class function Random(const MinValue: Double; const MaxValue: Double): Double; overload; static;
    class function Random(const MaxValue: Double = MaxInt): Double; overload; static;
  end;
  {$IFEND}

  {$IF CompilerVersion >= 24.0}
  TOLCurrencyHelper = record helper for Currency
  public
    function Sqr(): Currency;
    function Power(const Exponent: Integer): Currency;
    function IsPositive(): Boolean;
    function IsNegative(): Boolean;
    function IsNonNegative(): Boolean;
    function Between(const BottomIncluded, TopIncluded: Currency): Boolean;
    function Max(const c: Currency): Currency;
    function Min(const c: Currency): Currency;
    function Abs(): Currency;
    function ToString(): string; overload;
    function ToString(ThousandSeparator: Char; DecimalSeparator: Char = '.'; Format: string = '###,###,###,##0.##'): string; overload;
    function ToSQLString(): string;
    function ToStrF(Format: TFloatFormat; Digits: Integer): string;
    function Round(): Integer; overload;
    function Round(const PowerOfTen: Integer): Currency; overload;
    function Ceil(): Integer;
    function Floor(): Integer;
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
    property Year: Integer read GetYear write SetYear;
    property Month: Integer read GetMonth write SetMonth;
    property Day: Integer read GetDay write SetDay;
    property Hour: Integer read GetHour write SetHour;
    property Minute: Integer read GetMinute write SetMinute;
    property Second: Integer read GetSecond write SetSecond;
    property Test: Integer read GetMilliSecond write SetMilliSecond; //MilliSecond

    function ToString(): string; overload;
    function ToString(const Format: string): string; overload;
    function ToSQLString(): string;

    function DateOf(): TDateTime;
    function TimeOf(): TDateTime;

    function IsInLeapYear(): Boolean;
    function IsPM(): Boolean;
    function IsAM(): Boolean;
    function WeeksInYear(): Integer;
    function DaysInYear(): Integer;
    function DaysInMonth(): Integer;

    class function Today: TDateTime; static;
    class function Yesterday: TDateTime; static;
    class function Tomorrow: TDateTime; static;
    class function Now(): TDateTime; static;

    procedure SetNow();
    procedure SetToday();
    procedure SetTomorrow();
    procedure SetYesterday();

    function IsToday(): Boolean;
    function SameDay(const DateTimeToCompare: TDateTime): Boolean;

    function StartOfTheYear(): TDateTime;
    function EndOfTheYear(): TDateTime;
    class function StartOfAYear(const AYear: Word): TDateTime; static;
    class function EndOfAYear(const AYear: Word): TDateTime; static;
    procedure SetStartOfAYear(const AYear: Word);
    procedure SetEndOfAYear(const AYear: Word);

    function StartOfTheMonth(): TDateTime;
    function EndOfTheMonth(): TDateTime;
    class function StartOfAMonth(const AYear, AMonth: Word): TDateTime; static;
    class function EndOfAMonth(const AYear, AMonth: Word): TDateTime; static;
    procedure SetStartOfAMonth(const AYear, AMonth: Word);
    procedure SetEndOfAMonth(const AYear, AMonth: Word);

    function StartOfTheWeek(): TDateTime;
    function EndOfTheWeek(): TDateTime;

    function StartOfTheDay(): TDateTime;
    function EndOfTheDay(): TDateTime;

    function DayOfTheYear(): Integer;
    function HourOfTheYear(): Integer;
    function MinuteOfTheYear(): LongWord;
    function SecondOfTheYear(): LongWord;
    function MilliSecondOfTheYear(): Int64;

    function HourOfTheMonth(): Integer;
    function MinuteOfTheMonth(): Integer;
    function SecondOfTheMonth(): LongWord;
    function MilliSecondOfTheMonth(): LongWord;

    function DayOfTheWeek(): Integer;
    function HourOfTheWeek(): Integer;
    function MinuteOfTheWeek(): Integer;
    function SecondOfTheWeek(): LongWord;
    function MilliSecondOfTheWeek(): LongWord;

    function MinuteOfTheDay(): Integer;
    function SecondOfTheDay(): LongWord;
    function MilliSecondOfTheDay(): LongWord;

    function SecondOfTheHour(): Integer;
    function MilliSecondOfTheHour(): LongWord;

    function MilliSecondOfTheMinute(): LongWord;

    class function SecondCount(const StartingYear: Integer = 2017): Integer; static;
    class function DateTimeFromSecondCount(const Count: Integer; const StartingYear: Integer = 2017): TDateTime; static;
    procedure SetFromSecondCount(const Count: Integer; const StartingYear: Integer = 2017);

    function YearsBetween(const AThen: TDateTime): Integer;
    function MonthsBetween(const AThen: TDateTime): Integer;
    function WeeksBetween(const AThen: TDateTime): Integer;
    function DaysBetween(const AThen: TDateTime): Integer;
    function HoursBetween(const AThen: TDateTime): Int64;
    function MinutesBetween(const AThen: TDateTime): Int64;
    function SecondsBetween(const AThen: TDateTime): Int64;
    function MilliSecondsBetween(const AThen: TDateTime): Int64;

    function InRange(const AStartDateTime, AEndDateTime: TDateTime; const aInclusive: Boolean = True): Boolean;
    function InDateRange(const AStartDateTime, AEndDateTime: TDate; const aInclusive: Boolean = True): Boolean;

    function YearSpan(const AThen: TDateTime): Double;
    function MonthSpan(const AThen: TDateTime): Double;
    function WeekSpan(const AThen: TDateTime): Double;
    function DaySpan(const AThen: TDateTime): Double;
    function HourSpan(const AThen: TDateTime): Double;
    function MinuteSpan(const AThen: TDateTime): Double;
    function SecondSpan(const AThen: TDateTime): Double;
    function MilliSecondSpan(const AThen: TDateTime): Double;

    function IncYear(const ANumberOfYears: Integer = 1): TDateTime;
    function IncMonth(const ANumberOfMonths: Integer = 1): TDateTime;
    function IncWeek(const ANumberOfWeeks: Integer = 1): TDateTime;
    function IncDay(const ANumberOfDays: Integer = 1): TDateTime;
    function IncHour(const ANumberOfHours: Int64 = 1): TDateTime;
    function IncMinute(const ANumberOfMinutes: Int64 = 1): TDateTime;
    function IncSecond(const ANumberOfSeconds: Int64 = 1): TDateTime;
    function IncMilliSecond(const ANumberOfMilliSeconds: Int64 = 1): TDateTime;

    procedure DecodeDateTime(out AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word);
    procedure EncodeDateTime(const AYear, AMonth, ADay: Word; const AHour: Word = 0; const AMinute: Word = 0;
      const ASecond: Word = 0; const AMilliSecond: Word = 0);

    function RecodedYear(const AYear: Word): TDateTime;
    function RecodedMonth(const AMonth: Word): TDateTime;
    function RecodedDay(const ADay: Word): TDateTime;
    function RecodedHour(const AHour: Word): TDateTime;
    function RecodedMinute(const AMinute: Word): TDateTime;
    function RecodedSecond(const ASecond: Word): TDateTime;
    function RecodedMilliSecond(const AMilliSecond: Word): TDateTime;

    function SameTime(const DateTimeToCompare: TDateTime): Boolean;

    function LongDayName(): string;
    function LongMonthName(): string;
    function ShortDayName(): string;
    function ShortMonthName(): string;

    function Max(const CompareDate: TDateTime): TDateTime;
    function Min(const CompareDate: TDateTime): TDateTime;
  end;
  {$IFEND}

  {$IF CompilerVersion >= 24.0}
  TOLStringHelper = record helper for string
  private
    function GetLines(const Index: Integer): OLString;
    function GetCSV(const Index: Integer): OLString;
    procedure SetCSV(const Index: Integer; const Value: OLString);
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
    function IsEmptyStr(): OLBoolean;
    function Length(): OLInteger;

    // Substring operations
    function Substring(StartIndex: Integer): string; overload;
    function Substring(StartIndex, Length: Integer): string; overload;
    function LeftStr(Count: Integer): string;
    function RightStr(Count: Integer): string;

    // Search and replace
    function ContainsStr(SubString: string): OLBoolean;
    function Pos(SubString: string): OLInteger;
    function Replace(OldValue, NewValue: string): string;

    // Case operations
    function LowerCase(): string;
    function UpperCase(): string;

    // Trim operations
    function Trim(): string;
    function TrimLeft(): string;
    function TrimRight(): string;

    // Other utilities
    function StartsStr(Value: string): OLBoolean;
    function EndsStr(Value: string): OLBoolean;
    function ReversedString(): string;

    // Additional methods from OLString
    function HashStr(const Salt: string = ''): string;
    function Compressed(): string;
    function Decompressed(): string;
    function ExtractedFileName(): string;
    function ExtractedFileExt(): string;
    function ExtractedFileDriveString(): string;
    function ExtractedFileDir(): string;
    function ExtractedFilePath(): string;
    procedure LoadFromFile(const FileName: string); overload;
    procedure LoadFromFile(const FileName: string; Encoding: TEncoding); overload;
    procedure SaveToFile(const FileName: string); overload;
    procedure SaveToFile(const FileName: string; Encoding: TEncoding); overload;
    procedure EndcodeBase64FromFile(const FileName: string);
    procedure DecodeBase64ToFile(const FileName: string);
    function Formated(const Data: array of const): string;
    function FindTagStr(const Tag: string; const StartingPosition: Integer = 1): string;
    function Like(Pattern: string): OLBoolean;
    function SameStr(s: string): OLBoolean;
    function SameText(s: string): OLBoolean;
    function ToInt(): OLInteger;
    function TryToInt(): OLBoolean; overload;
    function TryToInt(var i: Integer): OLBoolean; overload;
    function LineCount(): OLInteger;
    function LastLineIndex(): Integer;
    procedure LineAdd(const NewLine: string);
    procedure LineDelete(const LineIndex: Integer);
    procedure LineInsertAt(const LineIndex: Integer; const s: string);
    function LineIndexLike(const s: string; StartingFrom: Integer = 0): OLInteger;
    function LinesSorted(): string;
    function GetLineStartPosition(const Index: Integer): OLInteger;
    function GetLineEndPosition(const Index: Integer): OLInteger;
    function LineEndAt(const LineIndex: Integer): OLInteger;
    function MatchStr(const AValues: array of string): OLBoolean;
    function ContainsText(SubString: string): OLBoolean;
    function StartsText(Value: string): OLBoolean;
    function EndsText(Value: string): OLBoolean;
    function IndexStr(const AValues: array of string): OLInteger;
    function IndexText(const AValues: array of string): OLInteger;
    function MatchText(const AValues: array of string): OLBoolean;
    function FindPatternStr(const InFront, Behind: string; const StartingPosition: Integer = 1; const CaseSensitivity: TCaseSensitivity = csCaseSensitive): string; overload;
    function FindPatternStr(const Tag: string; const StartingPosition: Integer = 1; const CaseSensitivity: TCaseSensitivity = csCaseInsensitive): string; overload;
    function PosEx(const SubStr: string; const Offset: Integer): OLInteger;
    function OccurrencesCount(const SubString: string): OLInteger;
    function MidStr(const AStart, ACount: Integer): string;
    function SplitString(const Delimiters: string = ';'): TStringDynArray;
    function MidStrEx(const AStart, AEnd: Integer): string;
    function ReplacedStartingAt(const Position: Cardinal; const NewValue: string): string;
    function EndingRemoved(const ACount: Integer): string;
    function RightStrFrom(const StartFrom: Integer): string;
    function LeadingSpacesAdded(const NewLength: Integer): string;
    function TrailingSpacesAdded(const NewLength: Integer): string;
    function TrailingCharExcluded(const c: Char): string;
    function TrailingCharIncluded(const c: Char): string;
    function TrailingApostropheExcluded(): string;
    function TrailingApostropheIncluded(): string;
    function LeadingCharExcluded(const c: Char): string;
    function LeadingCharIncluded(const c: Char): string;
    function LeadingComaIncluded(): string;
    function LeadingApostropheExcluded(): string;
    function LeadingApostropheIncluded(): string;
    function ReplacedText(const AFromText, AToText: string): string;
    function Trimmed(): string;
    function TrimmedLeft(): string;
    function TrimmedRight(): string;
    function LeadingZerosAdded(const NewLength: Integer): string;
    function Inserted(const InsertStr: string; const Position: Integer): string;
    function Deleted(const FromPosition: Integer; const Count: Integer = 1): string;
    function DigitsOnly(): string;
    function NoDigits(): string;
    function SpacesRemoved(): string;
    function QuotedStr(): string;
    function InitCaps(): string;
    function AlphanumericsOnly(): string;
    function RepeatedString(const ACount: Integer): string;
    function LineAdded(const NewLine: string): string;
    function TrailingPathDelimiterIncluded(): string;
    function TrailingPathDelimiterExcluded(): string;
    class function RandomString(const Length: Integer): string; static;
    function GetLine(const Index: Integer): string;
    function CSVFieldValue(const FieldIndex: Integer; const Delimiter: Char = ';'): string;

    property Params[const ParamName: string]: OLString write SetParams;
    property Lines[const Index: Integer]: OLString read GetLines write SetLines;
    property CSV[const Index: Integer]: OLString read GetCSV write SetCSV;
    function ReplacedFirst(const AFromText, AToText: string): string;
    function ReplacedFirstText(const AFromText, AToText: string): string;
    function LeadingCharsAdded(const C: Char; const NewLength: Integer): string;
    function TrailingCharsAdded(const C: Char; const NewLength: Integer): string;
    function OccurrencesPosition(const SubString: string; const Index: Integer): OLInteger;
    function PosLast(const SubStr: string): OLInteger;
    function PosLastEx(const SubStr: string; const NotAfterPosition: Integer; const CaseSensitivity: TCaseSensitivity = csCaseSensitive): OLInteger;
    function FindPattern(const InFront, Behind: string; const StartingPosition:
        Integer = 1): TStringPatternFind;
    function LineIndexOf(const s: string): OLInteger;
    function CSVIndex(const ValueToFind: string): OLInteger;
    function CSVFieldCount(const Delimiter: Char = ';'): OLInteger;
    procedure SetCSVFieldValue(const FieldIndex: Integer; const Value: OLString; const Delimiter: Char = ';');
    function CSVFieldName(const index: Integer): string;
    function CSVFieldByName(const FieldName: string; const RowIndex: Integer = 1): string;
    {$IFDEF VCL}
    function PixelWidth(const F: TFont): OLInteger;
    {$ENDIF}
    function IsValidIBAN: OLBoolean;
    function TrailingComaExcluded(): string;
    function LeadingComaExcluded(): string;
    function TryToFloat(): OLBoolean; overload;
    function TryToFloat(var e: Double): OLBoolean; overload;
    function TryToDate(): OLBoolean; overload;
    function TryToDate(var d: TDate): OLBoolean; overload;
    function TryToCurr(): OLBoolean; overload;
    function TryToCurr(var c: Currency): OLBoolean; overload;
    function TryToInt64(): OLBoolean; overload;
    function TryToInt64(var i: Int64): OLBoolean; overload;
    function ToCurr(): OLCurrency;
    function ToDate(): OLDate;
    function ToDateTime(): OLDateTime;
    function ToFloat(): OLDouble;
    function ToInt64(): OLInt64;
    function TrySmartStrToDate(): OLBoolean; overload;
    function TrySmartStrToDate(var d: TDate): OLBoolean; overload;
    function SmartStrToDate(): OLDate;
    function ToPWideChar(): PWideChar;
    function LastDelimiterPosition(const Delimiters: string = ';'): OLInteger;
    function Hash(const Salt: string = ''): Cardinal;
    function ToSQLString(): string;
    procedure CopyToClipboard();
    procedure PasteFromClipboard();
    procedure GetFromUrl(const URL: string; Timeout: LongWord = 0);
    class function RandomFrom(const AValues: array of string): string; static;
    class procedure SetNullAsDefault(); static;

    property HtmlUnicodeText: string read GetHtmlUnicodeText write SetHtmlUnicodeText;
    property UrlEncodedText: string read GetUrlEncodedText write SetUrlEncodedText;
    property Base64: string read GetBase64 write SetBase64;
    {$IF CompilerVersion >= 27.0}
    function GetJSON(const JsonFieldName: string): OLString;
    procedure SetJSON(const JsonFieldName: string; const Value: OLString);
    property JSON[const JsonFieldName: string]: OLString read GetJSON write SetJSON;
    {$IFEND}

  end;
  {$IFEND}

   TOLEditHelper = class helper for TEdit
     procedure Link(var i: OLInteger; const Alignment: TAlignment=taRightJustify); overload;
     procedure Link(var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify); overload;
     procedure Link(var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify); overload;
     procedure Link(var s: OLString); overload;
   end;

   TOLSpinEditHelper = class helper for TSpinEdit
     procedure Link(var i: OLInteger);
   end;

   TOLTrackBarHelper = class helper for TTrackBar
     procedure Link(var i: OLInteger);
   end;

   TOLScrollBarHelper = class helper for TScrollBar
     procedure Link(var i: OLInteger);
   end;

   TOLMemoHelper = class helper for TMemo
     procedure Link(var s: OLString);
   end;

   TOLDateTimePickerHelper = class helper for TDateTimePicker
     procedure Link(var d: OLDate); overload;
     procedure Link(var d: OLDateTime); overload;
   end;

   TOLCheckBoxHelper = class helper for TCheckBox
     procedure Link(var b: OLBoolean);
   end;

   TOLLabelHelper = class helper for TLabel
     procedure Link(var i: OLInteger); overload;
     procedure Link(const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
     procedure Link(var s: OLString); overload;
     procedure Link(const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
     procedure Link(var d: OLDouble; const Format: string = DOUBLE_FORMAT); overload;
     procedure Link(const f: TFunctionReturningOLDouble; const Format: string = DOUBLE_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
     procedure Link(var curr: OLCurrency; const Format: string = CURRENCY_FORMAT); overload;
     procedure Link(const f: TFunctionReturningOLCurrency; const Format: string = CURRENCY_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
     procedure Link(var d: OLDate); overload;
     procedure Link(const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
     procedure Link(var d: OLDateTime); overload;
     procedure Link(const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
   end;

   TFormFieldsHelper = class helper for TForm
   private
     function IsFieldOfRecord(const ctx: TRttiContext; const RecValue: TValue; ParamPtr: Pointer): Boolean;
   public
     function IsMyField(var X): Boolean;
   end;

implementation

uses OLTypesToEdits, TypInfo,
    {$IF CompilerVersion >= 23.0}
        System.Character;
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



{ TFormFieldsHelper }

function TFormFieldsHelper.IsFieldOfRecord(
  const ctx: TRttiContext; const RecValue: TValue; ParamPtr: Pointer): Boolean;
var
  RecType: TRttiStructuredType;
  f: TRttiField;
  FieldValue: TValue;
  RType: TRttiType;
  TK: TTypeKind;
begin
  Result := False;

  // Get RTTI type of the record
  RType := ctx.GetType(RecValue.TypeInfo);
  if not (RType is TRttiStructuredType) then
    Exit;

  RecType := TRttiStructuredType(RType);

  for f in RecType.GetFields do
  begin
    // 1. Compare direct field address
    if GetFieldAddressHack(f, RecValue.GetReferenceToRawData) = ParamPtr then
      Exit(True);

    FieldValue := f.GetValue(RecValue.GetReferenceToRawData);

    // 2. Check field type (RTTI)
    TK := f.FieldType.TypeKind;

    {$IF CompilerVersion >= 34.0}
    // Delphi 10.4+ � handle Managed Records
    if (TK = tkRecord) or (TK = tkMRecord) then
    {$ELSE}
    // Delphi XE..10.3 � only standard records
    if TK = tkRecord then
    {$IFEND}
    begin
      // Recurse into nested record fields
      if IsFieldOfRecord(ctx, FieldValue, ParamPtr) then
        Exit(True);
    end;
  end;
end;


function TFormFieldsHelper.IsMyField(var X): Boolean;
var
  ctx: TRttiContext;
  t: TRttiType;
  f: TRttiField;
  FieldValue: TValue;
  ParamPtr: Pointer;
  TK: TTypeKind;
begin
  Result := False;
  ParamPtr := @X;

  t := ctx.GetType(Self.ClassType);
  if t = nil then
    Exit(False);

  for f in t.GetFields do
  begin
    // 1. Compare direct field address
    if GetFieldAddressHack(f, Self) = ParamPtr then
      Exit(True);

    FieldValue := f.GetValue(Self);

    // 2. Recurse into record fields
    TK := f.FieldType.TypeKind;

    {$IF CompilerVersion >= 34.0}
    if (TK = tkRecord) or (TK = tkMRecord) then
    {$ELSE}
    if TK = tkRecord then
    {$IFEND}
    begin
      if IsFieldOfRecord(ctx, FieldValue, ParamPtr) then
        Exit(True);
    end;
  end;
end;

{ TOLEditHelper }

procedure TOLEditHelper.Link(var i: OLInteger; const Alignment: TAlignment);
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
     Links.Link(Self, i, Alignment);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;


procedure TOLEditHelper.Link(var d: OLDouble; const Format: string; const Alignment: TAlignment);
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
     Links.Link(Self, d, Format, Alignment);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;


procedure TOLEditHelper.Link(var curr: OLCurrency; const Format: string; const Alignment: TAlignment);
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
     Links.Link(Self, curr, Format, Alignment);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;

procedure TOLEditHelper.Link(var s: OLString);
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
     Links.Link(Self, s);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;

{ TOLSpinEditHelper }

procedure TOLSpinEditHelper.Link(var i: OLInteger);
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
     Links.Link(Self, i);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TSpinEdit: ' + E.Message);
   end;
end;

{ TOLTrackBarHelper }

procedure TOLTrackBarHelper.Link(var i: OLInteger);
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
     Links.Link(Self, i);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TTrackBar: ' + E.Message);
   end;
end;

{ TOLScrollBarHelper }

procedure TOLScrollBarHelper.Link(var i: OLInteger);
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
     Links.Link(Self, i);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TScrollBar: ' + E.Message);
   end;
end;

{ TOLMemoHelper }

procedure TOLMemoHelper.Link(var s: OLString);
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
     Links.Link(Self, s);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TMemo: ' + E.Message);
   end;
end;

{ TOLDateTimePickerHelper }

procedure TOLDateTimePickerHelper.Link(var d: OLDate);
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
     Links.Link(Self, d);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TDateTimePicker: ' + E.Message);
   end;
end;

procedure TOLDateTimePickerHelper.Link(var d: OLDateTime);
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
     Links.Link(Self, d);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TDateTimePicker: ' + E.Message);
   end;
end;

{ TOLCheckBoxHelper }

procedure TOLCheckBoxHelper.Link(var b: OLBoolean);
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
     Links.Link(Self, b);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TCheckBox: ' + E.Message);
   end;
end;

{ TOLLabelHelper }

procedure TOLLabelHelper.Link(var i: OLInteger);
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
     Links.Link(Self, i);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var s: OLString);
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
     Links.Link(Self, s);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var d: OLDouble; const Format: string);
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
     Links.Link(Self, d, Format);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDouble; const Format: string; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, Format, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var curr: OLCurrency; const Format: string);
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
     Links.Link(Self, curr, Format);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLCurrency; const Format: string; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, Format, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var d: OLDate);
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
     Links.Link(Self, d);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var d: OLDateTime);
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
     Links.Link(Self, d);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, ValueOnErrorInCalculation);
end;


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

{$IF CompilerVersion >= 24.0}
{ TOLBooleanHelper }

function TOLBooleanHelper.ToString(): string;
var
  ol: OLBoolean;
begin
  ol := Self;
  Result := ol.ToString();
end;

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

function TOLDateTimeHelper.YearsBetween(const AThen: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.YearsBetween(AThen);
end;

function TOLDateTimeHelper.MonthsBetween(const AThen: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MonthsBetween(AThen);
end;

function TOLDateTimeHelper.WeeksBetween(const AThen: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.WeeksBetween(AThen);
end;

function TOLDateTimeHelper.DaysBetween(const AThen: TDateTime): Integer;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.DaysBetween(AThen);
end;

function TOLDateTimeHelper.HoursBetween(const AThen: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.HoursBetween(AThen);
end;

function TOLDateTimeHelper.MinutesBetween(const AThen: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MinutesBetween(AThen);
end;

function TOLDateTimeHelper.SecondsBetween(const AThen: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.SecondsBetween(AThen);
end;

function TOLDateTimeHelper.MilliSecondsBetween(const AThen: TDateTime): Int64;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MilliSecondsBetween(AThen);
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

function TOLDateTimeHelper.YearSpan(const AThen: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.YearSpan(AThen);
end;

function TOLDateTimeHelper.MonthSpan(const AThen: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MonthSpan(AThen);
end;

function TOLDateTimeHelper.WeekSpan(const AThen: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.WeekSpan(AThen);
end;

function TOLDateTimeHelper.DaySpan(const AThen: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.DaySpan(AThen);
end;

function TOLDateTimeHelper.HourSpan(const AThen: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.HourSpan(AThen);
end;

function TOLDateTimeHelper.MinuteSpan(const AThen: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MinuteSpan(AThen);
end;

function TOLDateTimeHelper.SecondSpan(const AThen: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.SecondSpan(AThen);
end;

function TOLDateTimeHelper.MilliSecondSpan(const AThen: TDateTime): Double;
var
  ol: OLDateTime;
begin
  ol := Self;
  Result := ol.MilliSecondSpan(AThen);
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

function TOLStringHelper.SplitString(const Delimiters: string): TStringDynArray;
var
  ol: OLString;
begin
  ol := Self;
  Result := TStringDynArray(ol.SplitString(Delimiters));
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
    if Copy(NewValue, i, L) = ParamString then
    begin
      if (i + L > System.Length(NewValue)) or
         (not TCharacter.IsLetterOrDigit(NewValue[i + L])) then
      begin
        NewValue :=
          Copy(NewValue, 1, i - 1) +
          Value +
          Copy(NewValue, i + L, MaxInt);

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

class function TOLStringHelper.RandomFrom(const AValues: array of string): string;
begin
  Result := OLString.RandomFrom(AValues);
end;

class procedure TOLStringHelper.SetNullAsDefault();
begin
  OLString.SetNullAsDefault();
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
{$IFEND}  //CompilerVersion >= 27.0

{$IFEND}

{$IFEND}     //CompilerVersion >= 24.0

end.
