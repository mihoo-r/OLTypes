unit OLDateType;

interface

uses
  Variants, SysUtils, DateUtils, OlBooleanType, OLIntegerType, OLDoubleType, OLDateTimeType,
  SmartToDate, System.Classes;

type
  OLDate = record
  private
    FValue: OLDateTime;
    {$IF CompilerVersion >= 34.0}
    FOnChange: TNotifyEvent;
    {$IFEND}
    function GetDay: OLInteger;
    function GetMonth: OLInteger;
    function GetYear: OLInteger;
    procedure SetDay(const Value: OLInteger);
    procedure SetMonth(const Value: OLInteger);
    procedure SetYear(const Value: OLInteger);

  public
    property Year: OLInteger read GetYear write SetYear;
    property Month: OLInteger read GetMonth write SetMonth;
    property Day: OLInteger read GetDay write SetDay;

    function IsNull(): OLBoolean;
    function HasValue(): OLBoolean;
    function ToString(): string; overload;
    function ToString(const Format: string): string; overload;
    function ToSQLString(): string;
    function IfNull(const b: OLDate): OLDate;

    class operator Implicit(const a: TDate): OLDate;
    class operator Implicit(const a: OLDate): TDate;
    class operator Implicit(const a: OLDateTime): OLDate;
    class operator Implicit(const a: OLDate): OLDateTime;
    class operator Implicit(const a: TDateTime): OLDate;
    class operator Implicit(const a: OLDate): TDateTime;
    class operator Implicit(const a: Variant): OLDate;
    class operator Implicit(const a: OLDate): Variant;
    class operator Implicit(const a: Extended): OLDate;
    class operator Implicit(const a: string): OLDate;

    class operator Equal(const a, b: OLDate): Boolean;
    class operator NotEqual(const a, b: OLDate): Boolean;
    class operator GreaterThan(const a, b: OLDate): Boolean;
    class operator GreaterThanOrEqual(const a, b: OLDate): Boolean;
    class operator LessThan(const a, b: OLDate): Boolean;
    class operator LessThanOrEqual(const a, b: OLDate): Boolean;

    class operator Add(const a: OLDate; b: integer): OLDate;
    class operator Subtract(const a: OLDate; const b: integer): OLDate;

    function IsInLeapYear(): OLBoolean;

    function WeeksInYear(): OLInteger; { ISO 8601 }

    function DaysInYear(): OLInteger;
    function DaysInMonth(): OLInteger;
    class function Today: OLDate; static;
    class function Yesterday: OLDate; static;
    class function Tomorrow: OLDate; static;

    procedure SetToday();
    procedure SetTomorow();
    procedure SetYesterday();

    function IsToday(): OLBoolean;
    function SameDay(const DateToCompare: OLDate): OLBoolean;

    function StartOfTheYear(): OLDate;
    function EndOfTheYear(): OLDate;
    class function StartOfAYear(const AYear: Word): OLDate; static;
    class function EndOfAYear(const AYear: Word): OLDate; static;

    procedure SetStartOfAYear(const AYear: Word);
    procedure SetEndOfAYear(const AYear: Word);

    function StartOfTheMonth(): OLDate;
    function EndOfTheMonth(): OLDate;
    class function StartOfAMonth(const AYear, AMonth: Word): OLDate; static;
    class function EndOfAMonth(const AYear, AMonth: Word): OLDate; static;
    procedure SetStartOfAMonth(const AYear, AMonth: Word);
    procedure SetEndOfAMonth(const AYear, AMonth: Word);

    function StartOfTheWeek(): OLDate; { ISO 8601 }
    function EndOfTheWeek(): OLDate; { ISO 8601 }

    function DayOfTheYear(): OLInteger;

    function DayOfTheWeek(): OLInteger; { ISO 8601 }

    function YearsBetween(const AThen: OLDate): OLInteger;
    function MonthsBetween(const AThen: OLDate): OLInteger;
    function WeeksBetween(const AThen: OLDate): OLInteger;
    function DaysBetween(const AThen: OLDate): OLInteger;

    function InRange(const AStartDateTime, AEndDateTime: OLDate; const aInclusive: Boolean = True): OLBoolean;

    function YearSpan(const AThen: OLDate): OLDouble;
    function MonthSpan(const AThen: OLDate): OLDouble;
    function WeekSpan(const AThen: OLDate): OLDouble;


    function IncYear(const ANumberOfYears: Integer = 1): OLDate;
    function IncMonth(const ANumberOfMonths: Integer = 1): OLDate;
    function IncWeek(const ANumberOfWeeks: Integer = 1): OLDate;
    function IncDay(const ANumberOfDays: Integer = 1): OLDate;

    procedure DecodeDate(out AYear, AMonth, ADay: Word);
    procedure EncodeDate(const AYear, AMonth, ADay: Word);

    function RecodedYear(const AYear: Word): OLDate;
    function RecodedMonth(const AMonth: Word): OLDate;
    function RecodedDay(const ADay: Word): OLDate;

    function LongDayName(): string;
    function LongMonthName(): string;
    function ShortDayName(): string;
    function ShortMonthName(): string;

    function Max(const CompareDate: OLDate): OLDate;
    function Min(const CompareDate: OLDate): OLDate;

    class function IsValidDate(const Year, Month, Day: OLInteger): OLBoolean; static;

    {$IF CompilerVersion >= 34.0}
    class operator Initialize(out Dest: OLDate);
    class operator Assign(var Dest: OLDate; const [ref] Src: OLDate);
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {$IFEND}
  end;

  POLDate = ^OLDate;

implementation

uses Math;

{ OLDate }

class operator OLDate.Add(const a: OLDate; b: integer): OLDate;
begin
  Result := a.FValue + b;
end;

function OLDate.DayOfTheWeek: OLInteger;
begin
  Result := Self.FValue.DayOfTheWeek();
end;

function OLDate.DayOfTheYear: OLInteger;
begin
  Result := Self.FValue.DayOfTheYear();
end;

function OLDate.DaysBetween(const AThen: OLDate): OLInteger;
begin
  Result := Self.FValue.DaysBetween(AThen);
end;

function OLDate.DaysInMonth: OLInteger;
begin
  Result := Self.FValue.DaysInMonth();
end;

function OLDate.DaysInYear: OLInteger;
begin
  Result := Self.FValue.DaysInYear();
end;

procedure OLDate.DecodeDate(out AYear, AMonth, ADay: Word);
var
  AHour, AMinute, ASecond, AMilliSecond: Word;
begin
  Self.FValue.DecodeDateTime(AYear, AMonth, ADay,
    AHour, AMinute, ASecond, AMilliSecond);
end;

procedure OLDate.EncodeDate(const AYear, AMonth, ADay: Word);
begin
  Self.FValue.EncodeDateTime(AYear, AMonth, ADay);
end;

class function OLDate.EndOfAMonth(const AYear, AMonth: Word): OLDate;
begin
  Result := OLDateTime.EndOfAMonth(AYear, AMonth);
end;

class function OLDate.EndOfAYear(const AYear: Word): OLDate;
begin
  Result := OLDateTime.EndOfAYear(AYear);
end;

function OLDate.EndOfTheMonth: OLDate;
begin
  Result := Self.FValue.EndOfTheMonth();
end;

function OLDate.EndOfTheWeek: OLDate;
begin
  Result := Self.FValue.EndOfTheWeek();
end;

function OLDate.EndOfTheYear: OLDate;
begin
  Result := Self.FValue.EndOfTheYear();
end;

class operator OLDate.Equal(const a, b: OLDate): Boolean;
begin
  Result := (a.FValue = b.FValue);
end;

function OLDate.GetDay: OLInteger;
begin
  Result := Self.FValue.Day;
end;

function OLDate.GetMonth: OLInteger;
begin
  Result := Self.FValue.Month;
end;

function OLDate.GetYear: OLInteger;
begin
  Result := Self.FValue.Year;
end;

class operator OLDate.GreaterThan(const a, b: OLDate): Boolean;
begin
  Result := (a.FValue > b.FValue);
end;

class operator OLDate.GreaterThanOrEqual(const a, b: OLDate): Boolean;
begin
  Result := (a.FValue >= b.FValue);
end;

function OLDate.HasValue: OLBoolean;
begin
  Result := not IsNull();
end;

function OLDate.IfNull(const b: OLDate): OLDate;
begin
  Result := Self.FValue.IfNull(b);
end;

class operator OLDate.Implicit(const a: OLDate): Variant;
var
  OutPut: Variant;
begin
  if not a.FValue.IsNull then
    OutPut := a.FValue
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLDate.Implicit(const a: Extended): OLDate;
var
  OutPut: OLDateTime;
begin
  OutPut := a;
  OutPut := OutPut.DateOf;

  Result.FValue := OutPut;
end;

class operator OLDate.Implicit(const a: string): OLDate;
begin
  Result := SmartStrToDate(a);
end;

class operator OLDate.Implicit(const a: OLDateTime): OLDate;
begin
  Result.FValue := a.DateOf();
end;

class operator OLDate.Implicit(const a: OLDate): OLDateTime;
begin
  Result := a.FValue;
end;

class operator OLDate.Implicit(const a: Variant): OLDate;
var
  OutPut: OLDate;
  b: TDateTime;
begin
  if VarIsNull(a) then
    OutPut.FValue := Null
  else
  begin
    if TryStrToDateTime(a, b) then
    begin
      OutPut.FValue := b;
    end
    else
    begin
      raise Exception.Create('Value ''' + VarToStr(a) + ''' cannot be assigned to variable of OLDate type.');
    end;
  end;

  Result := OutPut;
end;

class operator OLDate.Implicit(const a: TDateTime): OLDate;
var
  OutPut: OLDate;
begin
  OutPut.FValue := DateOf(a);

  Result := OutPut;
end;

class operator OLDate.Implicit(const a: TDate): OLDate;
var
  OutPut: OLDate;
begin
  OutPut.FValue := a;

  Result := OutPut;
end;

class operator OLDate.Implicit(const a: OLDate): TDateTime;
begin
  Result := a.FValue;
end;

class operator OLDate.Implicit(const a: OLDate): TDate;
begin
  Result := a.FValue;
end;

function OLDate.IncDay(const ANumberOfDays: Integer): OLDate;
begin
  Result := Self.FValue.IncDay(ANumberOfDays);
end;

function OLDate.IncMonth(const ANumberOfMonths: Integer): OLDate;
begin
  Result := Self.FValue.IncMonth(ANumberOfMonths);
end;

function OLDate.IncWeek(const ANumberOfWeeks: Integer): OLDate;
begin
  Result := Self.FValue.IncWeek(ANumberOfWeeks);
end;

function OLDate.IncYear(const ANumberOfYears: Integer): OLDate;
begin
  Result := Self.FValue.IncYear(ANumberOfYears);
end;

function OLDate.InRange(const AStartDateTime, AEndDateTime: OLDate; const
    aInclusive: Boolean = True): OLBoolean;
begin
  Result := Self.FValue.InDateRange(AStartDateTime, AEndDateTime, aInclusive);
end;

function OLDate.IsInLeapYear: OLBoolean;
begin
  Result := Self.FValue.IsInLeapYear();
end;

function OLDate.IsNull: OLBoolean;
begin
  Result := Self.FValue.IsNull;
end;

function OLDate.IsToday: OLBoolean;
begin
  Result := Self.FValue.IsToday;
end;

class function OLDate.IsValidDate(const Year, Month, Day: OLInteger): OLBoolean;
begin
  Result := (Month > 0) and (Day > 0) and (DaysInAMonth(Year, Month) >= Day);
end;

class operator OLDate.LessThan(const a, b: OLDate): Boolean;
begin
  Result := (a.FValue < b.FValue);
end;

class operator OLDate.LessThanOrEqual(const a, b: OLDate): Boolean;
begin
  Result := (a.FValue <= b.FValue);
end;

function OLDate.LongDayName: string;
begin
  Result := Self.FValue.LongDayName();
end;

function OLDate.LongMonthName: string;
begin
  Result := Self.FValue.LongMonthName();
end;

function OLDate.Max(const CompareDate: OLDate): OLDate;
begin
  Result := Self.FValue.Max(CompareDate);
end;

function OLDate.Min(const CompareDate: OLDate): OLDate;
begin
  Result := Self.FValue.Min(CompareDate);
end;

function OLDate.MonthsBetween(const AThen: OLDate): OLInteger;
var
  Y1, Y2, M1, M2, D1, D2: Integer;
  FullMonth: OLBoolean;
begin
//Result := Self.Value.MonthsBetween(AThen); //Useless - returns "approximate" number of months based on avg days in month (30.4375 days)

  Y1 := AThen.Year;
  M1 := AThen.Month;
  D1 := AThen.Day;

  Y2 := Self.Year;
  M2 := Self.Month;
  D2 := Self.Day;

  FullMonth := (D2 >= D1) or (D2 = DaysInAMonth(Y2, M2));

  //Decrease when comparing for example '2020-01-10' and '2020-02-09' - not a full month so result is 0
  Result := 12 * (Y2 - Y1) + (M2 - M1) + FullMonth.IfThen(0, -1);
end;

function OLDate.MonthSpan(const AThen: OLDate): OLDouble;
begin
  Result := Self.FValue.MonthSpan(AThen);
end;

class operator OLDate.NotEqual(const a, b: OLDate): Boolean;
begin
  Result := (a.FValue <> b.FValue);
end;

function OLDate.RecodedDay(const ADay: Word): OLDate;
begin
  Result := Self.FValue.RecodedDay(ADay);
end;

function OLDate.RecodedMonth(const AMonth: Word): OLDate;
begin
  Result := Self.FValue.RecodedMonth(AMonth);
end;

function OLDate.RecodedYear(const AYear: Word): OLDate;
begin
  Result := Self.FValue.RecodedYear(AYear);
end;

function OLDate.SameDay(const DateToCompare: OLDate): OLBoolean;
begin
  Result := Self.FValue.SameDay(DateToCompare);
end;

procedure OLDate.SetDay(const Value: OLInteger);
begin
  Self.FValue.Day := Value;
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then FOnChange(nil);
  {$IFEND}
end;

procedure OLDate.SetEndOfAMonth(const AYear, AMonth: Word);
var
  dt: OLDateTime;
begin
  dt := Self.FValue;

  dt.SetEndOfAMonth(AYear, AMonth);
  dt := dt.DateOf();

  Self.FValue := dt;
end;

procedure OLDate.SetEndOfAYear(const AYear: Word);
var
  dt: OLDateTime;
begin
  dt := Self.FValue;

  dt.SetEndOfAYear(AYear);
  dt := dt.DateOf();

  Self.FValue := dt;
end;

procedure OLDate.SetMonth(const Value: OLInteger);
begin
  Self.FValue.Month := Value;
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then FOnChange(nil);
  {$IFEND}
end;

procedure OLDate.SetStartOfAMonth(const AYear, AMonth: Word);
var
  dt: OLDateTime;
begin
  dt := Self.FValue;

  dt.SetStartOfAMonth(AYear, AMonth);
  dt := dt.DateOf();

  Self.FValue := dt;
end;

procedure OLDate.SetStartOfAYear(const AYear: Word);
var
  dt: OLDateTime;
begin
  dt := Self.FValue;

  dt.SetStartOfAYear(AYear);
  dt := dt.DateOf();

  Self.FValue := dt;
end;

procedure OLDate.SetToday;
begin
  Self.FValue := OLDateTime.Today().DateOf();
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then FOnChange(nil);
  {$IFEND}
end;

procedure OLDate.SetTomorow;
begin
  Self.FValue := OLDateTime.Tomorrow().DateOf();
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then FOnChange(nil);
  {$IFEND}
end;

procedure OLDate.SetYear(const Value: OLInteger);
begin
  Self.FValue.Year := Value;
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then FOnChange(nil);
  {$IFEND}
end;

procedure OLDate.SetYesterday;
begin
  Self.FValue := OLDateTime.Yesterday().DateOf();
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then FOnChange(nil);
  {$IFEND}
end;

function OLDate.ShortDayName: string;
begin
  Result := Self.FValue.ShortDayName();
end;

function OLDate.ShortMonthName: string;
begin
  Result := Self.FValue.ShortMonthName();
end;

class function OLDate.StartOfAMonth(const AYear, AMonth: Word): OLDate;
begin
  Result.FValue := OLDateTime.StartOfAMonth(AYear, AMonth);
end;

class function OLDate.StartOfAYear(const AYear: Word): OLDate;
begin
  Result.FValue := OLDateTime.StartOfAYear(AYear);
end;

function OLDate.StartOfTheMonth: OLDate;
begin
  Result := Self.FValue.StartOfTheMonth().DateOf();
end;

function OLDate.StartOfTheWeek: OLDate;
begin
  Result := Self.FValue.StartOfTheWeek().DateOf();
end;

function OLDate.StartOfTheYear: OLDate;
begin
  Result := Self.FValue.StartOfTheYear().DateOf();
end;

class operator OLDate.Subtract(const a: OLDate; const b: integer): OLDate;
begin
  Result := a.FValue - b;
end;

class function OLDate.Today: OLDate;
begin
  Result := OLDateTime.Today().DateOf();
end;

class function OLDate.Tomorrow: OLDate;
begin
  Result := OLDateTime.Tomorrow().DateOf();
end;

function OLDate.ToString: string;
var
  OutPut: string;
begin
  if Self.IsNull then
    OutPut := ''
  else
    OutPut := DateToStr(Self.FValue);

  Result := OutPut;
end;

function OLDate.ToSQLString: string;
var
  OutPut: string;
begin
  if HasValue then
    OutPut := QuotedStr(ToString())
  else
    OutPut := 'NULL';

  Result := OutPut;
end;

function OLDate.ToString(const Format: string): string;
var
  OutPut: string;
begin
  if Self.HasValue then
    OutPut := FormatDateTime(Format, Self.FValue)
  else
    OutPut := '';

  Result := OutPut;
end;

function OLDate.WeeksBetween(const AThen: OLDate): OLInteger;
begin
  Result := Self.FValue.WeeksBetween(AThen);
end;

function OLDate.WeeksInYear: OLInteger;
begin
  Result := Self.FValue.WeeksInYear();
end;

function OLDate.WeekSpan(const AThen: OLDate): OLDouble;
begin
  Result := Self.FValue.WeekSpan(AThen);
end;

function OLDate.YearsBetween(const AThen: OLDate): OLInteger;
begin
  Result := Self.FValue.YearsBetween(AThen);
end;

function OLDate.YearSpan(const AThen: OLDate): OLDouble;
begin
  Result := Self.FValue.YearSpan(AThen);
end;

class function OLDate.Yesterday: OLDate;
begin
  Result := OLDateTime.Yesterday().DateOf();
end;

{$IF CompilerVersion >= 34.0}
class operator OLDate.Initialize(out Dest: OLDate);
begin
  Dest.FOnChange := nil;
end;

class operator OLDate.Assign(var Dest: OLDate; const [ref] Src: OLDate);
begin
  Dest.FValue := Src.FValue;

  if Assigned(Dest.FOnChange) then
    Dest.FOnChange(nil);
end;
{$IFEND}

end.
