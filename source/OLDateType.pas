unit OLDateType;

interface

uses
  Variants, SysUtils, DateUtils, OlBooleanType, OLIntegerType, OLDoubleType, OLDateTimeType,
  SmartToDate, {$IF CompilerVersion >= 23.0} System.Classes {$ELSE} Classes {$IFEND};

type
  /// <summary>
  ///   A record type representing a date value with null-handling capabilities.
  /// </summary>
  OLDate = record
  private
    FValue: OLDateTime;
    {$IF CompilerVersion >= 34.0}
    FOnChange: TNotifyEvent;
    {$IFEND}
    function GetDay: OLInteger;
    function GetMonth: OLInteger;
    function GetYear: OLInteger;
    {$IFDEF OL_MUTABLE}
    procedure SetDay(const Value: OLInteger);
    procedure SetMonth(const Value: OLInteger);
    procedure SetYear(const Value: OLInteger);
    {$ENDIF}

  public
    /// <summary>
    ///   Gets or sets the year component.
    /// </summary>
    property Year: OLInteger read GetYear {$IFDEF OL_MUTABLE} write SetYear {$ENDIF};
    /// <summary>
    ///   Gets or sets the month component.
    /// </summary>
    property Month: OLInteger read GetMonth {$IFDEF OL_MUTABLE} write SetMonth {$ENDIF};
    /// <summary>
    ///   Gets or sets the day component.
    /// </summary>
    property Day: OLInteger read GetDay {$IFDEF OL_MUTABLE} write SetDay {$ENDIF};

    /// <summary>
    ///   Checks if the date is null (has no value).
    /// </summary>
    function IsNull(): OLBoolean;
    /// <summary>
    ///   Checks if the date has a value (is not null).
    /// </summary>
    function HasValue(): OLBoolean;
    /// <summary>
    ///   Returns the TDate value, or a replacement TDate if null.
    /// </summary>
    function AsDate(const NullReplacement: TDate = 0): TDate;
    class function Create(const AYear, AMonth, ADay: Word): OLDate; static;
    /// <summary>
    ///   Converts the date to a string.
    /// </summary>
    function ToString(): string; overload;
    /// <summary>
    ///   Converts the date to a string with the specified format.
    /// </summary>
    function ToString(const Format: string): string; overload;
    /// <summary>
    ///   Converts the date to a SQL-safe string (value or NULL).
    /// </summary>
    function ToSQLString(): string;
    /// <summary>
    ///   Returns the current date if it has a value, otherwise returns the provided default value.
    /// </summary>
    function IfNull(const b: OLDate): OLDate;

    class operator Implicit(const a: TDate): OLDate;
    class operator Implicit(const a: OLDate): TDate;
    class operator Implicit(const a: OLDateTime): OLDate;
    class operator Implicit(const a: OLDate): OLDateTime;
    class operator Implicit(const a: TDateTime): OLDate;
    class operator Implicit(const a: OLDate): TDateTime;
    class operator Implicit(const a: Variant): OLDate;
    class operator Implicit(const a: OLDate): Variant;
    class operator Implicit(const a: OLDate): Extended;
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

    /// <summary>
    ///   Checks if the date is in a leap year.
    /// </summary>
    function IsInLeapYear(): OLBoolean;

    /// <summary>
    ///   Returns the number of weeks in the year (ISO 8601).
    /// </summary>
    function WeeksInYear(): OLInteger; { ISO 8601 }

    /// <summary>
    ///   Returns the number of days in the year.
    /// </summary>
    function DaysInYear(): OLInteger;
    /// <summary>
    ///   Returns the number of days in the month.
    /// </summary>
    function DaysInMonth(): OLInteger;
    /// <summary>
    ///   Returns today's date.
    /// </summary>
    class function Today: OLDate; static;
    /// <summary>
    ///   Returns yesterday's date.
    /// </summary>
    class function Yesterday: OLDate; static;
    /// <summary>
    ///   Returns tomorrow's date.
    /// </summary>
    class function Tomorrow: OLDate; static;

    {$IFDEF OL_MUTABLE}
    /// <summary>
    ///   Sets the date to today.
    /// </summary>
    procedure SetToday();
    /// <summary>
    ///   Sets the date to tomorrow.
    /// </summary>
    procedure SetTomorrow();
    /// <summary>
    ///   Sets the date to yesterday.
    /// </summary>
    procedure SetYesterday();
    {$ENDIF}

    /// <summary>
    ///   Checks if the date is today.
    /// </summary>
    function IsToday(): OLBoolean;
    /// <summary>
    ///   Checks if the date is on the same day as the specified date.
    /// </summary>
    function SameDay(const DateToCompare: OLDate): OLBoolean;

    /// <summary>
    ///   Returns the start of the current year.
    /// </summary>
    function StartOfTheYear(): OLDate;
    /// <summary>
    ///   Returns the end of the current year.
    /// </summary>
    function EndOfTheYear(): OLDate;
    /// <summary>
    ///   Returns the start of the specified year.
    /// </summary>
    class function StartOfAYear(const AYear: Word): OLDate; static;
    /// <summary>
    ///   Returns the end of the specified year.
    /// </summary>
    class function EndOfAYear(const AYear: Word): OLDate; static;

    {$IFDEF OL_MUTABLE}
    /// <summary>
    ///   Sets the date to the start of the specified year.
    /// </summary>
    procedure SetStartOfAYear(const AYear: Word);
    /// <summary>
    ///   Sets the date to the end of the specified year.
    /// </summary>
    procedure SetEndOfAYear(const AYear: Word);
    {$ENDIF}

    /// <summary>
    ///   Returns the start of the current month.
    /// </summary>
    function StartOfTheMonth(): OLDate;
    /// <summary>
    ///   Returns the end of the current month.
    /// </summary>
    function EndOfTheMonth(): OLDate;
    /// <summary>
    ///   Returns the start of the specified month.
    /// </summary>
    class function StartOfAMonth(const AYear, AMonth: Word): OLDate; static;
    /// <summary>
    ///   Returns the end of the specified month.
    /// </summary>
    class function EndOfAMonth(const AYear, AMonth: Word): OLDate; static;
    {$IFDEF OL_MUTABLE}
    /// <summary>
    ///   Sets the date to the start of the specified month.
    /// </summary>
    procedure SetStartOfAMonth(const AYear, AMonth: Word);
    /// <summary>
    ///   Sets the date to the end of the specified month.
    /// </summary>
    procedure SetEndOfAMonth(const AYear, AMonth: Word);
    {$ENDIF}

    /// <summary>
    ///   Returns the start of the current week (ISO 8601).
    /// </summary>
    function StartOfTheWeek(): OLDate; { ISO 8601 }
    /// <summary>
    ///   Returns the end of the current week (ISO 8601).
    /// </summary>
    function EndOfTheWeek(): OLDate; { ISO 8601 }

    /// <summary>
    ///   Returns the day number within the year.
    /// </summary>
    function DayOfTheYear(): OLInteger;

    /// <summary>
    ///   Returns the day number within the week (ISO 8601).
    ///  1 as Monday, 7 as Sunday.
    /// </summary>
    function DayOfTheWeek(): OLInteger; { ISO 8601 }

    /// <summary>
    ///   Returns the number of complete years between this date and the specified date.
    /// </summary>
    /// <param name="Date">The date to compare with. The result is always a non-negative number.</param>
    function YearsBetween(const Date: OLDate): OLInteger;
    /// <summary>
    ///   Returns the number of complete months between this date and the specified date.
    /// </summary>
    /// <param name="Date">The date to compare with. The result is always a non-negative number.</param>
    function MonthsBetween(const Date: OLDate): OLInteger;
    /// <summary>
    ///   Returns the number of complete weeks between this date and the specified date.
    /// </summary>
    /// <param name="Date">The date to compare with. The result is always a non-negative number.</param>
    function WeeksBetween(const Date: OLDate): OLInteger;
    /// <summary>
    ///   Returns the number of complete days between this date and the specified date.
    /// </summary>
    /// <param name="Date">The date to compare with. The result is always a non-negative number.</param>
    function DaysBetween(const Date: OLDate): OLInteger;
    /// <summary>
    ///   Returns the number of complete days between this date and the begining of 1900.
    /// </summary>
    function DaysSince1900: OLInteger;

    /// <summary>
    ///   Returns the number of complete years from the specified date to this date.
    /// </summary>
    /// <param name="Date">The date to compare with. Returns negative if Date > Self.</param>
    function YearsFrom(const Date: OLDate): OLInteger;
    /// <summary>
    ///   Returns the number of complete years from this date to the specified date.
    /// </summary>
    /// <param name="Date">The date to compare with. Returns negative if Date < Self.</param>
    function YearsTo(const Date: OLDate): OLInteger;
    /// <summary>
    ///   Returns the number of complete months from the specified date to this date.
    /// </summary>
    /// <param name="Date">The date to compare with. Returns negative if Date > Self.</param>
    function MonthsFrom(const Date: OLDate): OLInteger;
    /// <summary>
    ///   Returns the number of complete months from this date to the specified date.
    /// </summary>
    /// <param name="Date">The date to compare with. Returns negative if Date < Self.</param>
    function MonthsTo(const Date: OLDate): OLInteger;
    /// <summary>
    ///   Returns the number of complete weeks from the specified date to this date.
    /// </summary>
    /// <param name="Date">The date to compare with. Returns negative if Date > Self.</param>
    function WeeksFrom(const Date: OLDate): OLInteger;
    /// <summary>
    ///   Returns the number of complete weeks from this date to the specified date.
    /// </summary>
    /// <param name="Date">The date to compare with. Returns negative if Date < Self.</param>
    function WeeksTo(const Date: OLDate): OLInteger;
    /// <summary>
    ///   Returns the number of complete days from the specified date to this date.
    /// </summary>
    /// <param name="Date">The date to compare with. Returns negative if Date > Self.</param>
    function DaysFrom(const Date: OLDate): OLInteger;
    /// <summary>
    ///   Returns the number of complete days from this date to the specified date.
    /// </summary>
    /// <param name="Date">The date to compare with. Returns negative if Date < Self.</param>
    function DaysTo(const Date: OLDate): OLInteger;

    /// <summary>
    ///   Checks if the date is within the specified range.
    /// </summary>
    function InRange(const AStartDateTime, AEndDateTime: OLDate; const aInclusive: Boolean = True): OLBoolean;

    /// <summary>
    ///   Returns the approximate number of years between this date and the specified date.
    /// </summary>
    /// <param name="Date">The date to compare with. The result is always a non-negative number.</param>
    function YearSpan(const Date: OLDate): OLDouble;
    /// <summary>
    ///   Returns the approximate number of months between this date and the specified date.
    /// </summary>
    /// <param name="Date">The date to compare with. The result is always a non-negative number.</param>
    function MonthSpan(const Date: OLDate): OLDouble;
    /// <summary>
    ///   Returns the approximate number of weeks between this date and the specified date.
    /// </summary>
    /// <param name="Date">The date to compare with. The result is always a non-negative number.</param>
    function WeekSpan(const Date: OLDate): OLDouble;

    /// <summary>
    ///   Returns the date incremented by the specified number of years.
    /// </summary>
    function IncYear(const ANumberOfYears: Integer = 1): OLDate;
    /// <summary>
    ///   Returns the date incremented by the specified number of months.
    /// </summary>
    function IncMonth(const ANumberOfMonths: Integer = 1): OLDate;
    /// <summary>
    ///   Returns the date incremented by the specified number of weeks.
    /// </summary>
    function IncWeek(const ANumberOfWeeks: Integer = 1): OLDate;
    /// <summary>
    ///   Returns the date incremented by the specified number of days.
    /// </summary>
    function IncDay(const ANumberOfDays: Integer = 1): OLDate;

    /// <summary>
    ///   Decodes the date into its component parts.
    /// </summary>
    procedure DecodeDate(out AYear, AMonth, ADay: Word);
    {$IFDEF OL_MUTABLE}
    /// <summary>
    ///   Encodes the date from component parts.
    /// </summary>
    procedure EncodeDate(const AYear, AMonth, ADay: Word);
    {$ENDIF}

    class function EncodedDate(const AYear, AMonth, ADay: Word): OLDate; static;

    /// <summary>
    ///   Returns the date with the year component changed.
    /// </summary>
    function WithYear(const AYear: OLInteger): OLDate;
    /// <summary>
    ///   Returns the date with the month component changed.
    /// </summary>
    function WithMonth(const AMonth: OLInteger): OLDate;
    /// <summary>
    ///   Returns the date with the day component changed.
    /// </summary>
    function WithDay(const ADay: OLInteger): OLDate;

    /// <summary>
    ///   Returns the date with the year component changed.
    /// </summary>
    function RecodedYear(const AYear: Word): OLDate;
    /// <summary>
    ///   Returns the date with the month component changed.
    /// </summary>
    function RecodedMonth(const AMonth: Word): OLDate;
    /// <summary>
    ///   Returns the date with the day component changed.
    /// </summary>
    function RecodedDay(const ADay: Word): OLDate;

    /// <summary>
    ///   Returns the full name of the day of the week.
    /// </summary>
    function LongDayName(): string;
    /// <summary>
    ///   Returns the full name of the month.
    /// </summary>
    function LongMonthName(): string;
    /// <summary>
    ///   Returns the abbreviated name of the day of the week.
    /// </summary>
    function ShortDayName(): string;
    /// <summary>
    ///   Returns the abbreviated name of the month.
    /// </summary>
    function ShortMonthName(): string;

    /// <summary>
    ///   Returns the later of the two dates.
    /// </summary>
    function Max(const CompareDate: OLDate): OLDate;
    /// <summary>
    ///   Returns the earlier of the two dates.
    /// </summary>
    function Min(const CompareDate: OLDate): OLDate;

    /// <summary>
    ///   Checks if the specified year, month, and day form a valid date.
    /// </summary>
    class function IsValidDate(const Year, Month, Day: OLInteger): OLBoolean; static;

    {$IF CompilerVersion >= 34.0}
    class operator Initialize(out Dest: OLDate);
    class operator Assign(var Dest: OLDate; const [ref] Src: OLDate);
    /// <summary>
    ///   Event handler for value changes.
    /// </summary>
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

function OLDate.DaysBetween(const Date: OLDate): OLInteger;
begin
  Result := Self.FValue.DaysBetween(Date);
end;

function OLDate.YearsFrom(const Date: OLDate): OLInteger;
begin
  Result := Self.FValue.YearsFrom(Date);
end;

function OLDate.YearsTo(const Date: OLDate): OLInteger;
begin
  Result := Self.FValue.YearsTo(Date);
end;

function OLDate.MonthsFrom(const Date: OLDate): OLInteger;
begin
  Result := Self.FValue.MonthsFrom(Date);
end;

function OLDate.MonthsTo(const Date: OLDate): OLInteger;
begin
  Result := Self.FValue.MonthsTo(Date);
end;

function OLDate.WeeksFrom(const Date: OLDate): OLInteger;
begin
  Result := Self.FValue.WeeksFrom(Date);
end;

function OLDate.WeeksTo(const Date: OLDate): OLInteger;
begin
  Result := Self.FValue.WeeksTo(Date);
end;

function OLDate.DaysFrom(const Date: OLDate): OLInteger;
begin
  Result := Self.FValue.DaysFrom(Date);
end;

function OLDate.DaysTo(const Date: OLDate): OLInteger;
begin
  Result := Self.FValue.DaysTo(Date);
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

{$IFDEF OL_MUTABLE}
procedure OLDate.EncodeDate(const AYear, AMonth, ADay: Word);
begin
  Self.FValue.EncodeDateTime(AYear, AMonth, ADay);
end;
{$ENDIF}

class function OLDate.Create(const AYear, AMonth, ADay: Word): OLDate;
begin
  Result := OLDateTime.Create(AYear, AMonth, ADay);
end;

class function OLDate.EncodedDate(const AYear, AMonth, ADay: Word): OLDate;
begin
  Result.FValue := DateUtils.EncodeDateTime(AYear, AMonth, ADay, 0, 0, 0, 0);
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

function OLDate.AsDate(const NullReplacement: TDate = 0): TDate;
begin
  Result := IfNull(NullReplacement);
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
  if not a.HasValue then
    raise Exception.Create('Null cannot be used as TDateTime value');
  Result := a.FValue;
end;

class operator OLDate.Implicit(const a: OLDate): Extended;
begin
  if not a.HasValue then
    raise Exception.Create('Null cannot be used as Extended value');
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

function OLDate.DaysSince1900: OLInteger;
var
  OutPut: OLInteger;
  var d, td: TDate;
begin
  if HasValue() then
  begin
    d := self.FValue;
    td := SysUtils.EncodeDate(1900, 1, 1);

    OutPut := Round(d - td);
  end;

  Result := OutPut;
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

function OLDate.MonthsBetween(const Date: OLDate): OLInteger;
begin
  Result := Self.FValue.MonthsBetween(Date);
end;

function OLDate.MonthSpan(const Date: OLDate): OLDouble;
begin
  Result := Self.FValue.MonthSpan(Date);
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

{$IFDEF OL_MUTABLE}
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
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDate.SetEndOfAYear(const AYear: Word);
var
  dt: OLDateTime;
begin
  dt := Self.FValue;

  dt.SetEndOfAYear(AYear);
  dt := dt.DateOf();

  Self.FValue := dt;
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDate.SetMonth(const Value: OLInteger);
begin
  Self.FValue.Month := Value;
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDate.SetStartOfAMonth(const AYear, AMonth: Word);
var
  dt: OLDateTime;
begin
  dt := Self.FValue;

  dt.SetStartOfAMonth(AYear, AMonth);
  dt := dt.DateOf();

  Self.FValue := dt;
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDate.SetStartOfAYear(const AYear: Word);
var
  dt: OLDateTime;
begin
  dt := Self.FValue;

  dt.SetStartOfAYear(AYear);
  dt := dt.DateOf();

  Self.FValue := dt;
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDate.SetToday;
begin
  Self.FValue := OLDateTime.Today().DateOf();
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDate.SetTomorrow;
begin
  Self.FValue := OLDateTime.Tomorrow().DateOf();
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDate.SetYear(const Value: OLInteger);
begin
  Self.FValue.Year := Value;
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDate.SetYesterday;
begin
  Self.FValue := OLDateTime.Yesterday().DateOf();
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

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

function OLDate.WeeksBetween(const Date: OLDate): OLInteger;
begin
  Result := Self.FValue.WeeksBetween(Date);
end;

function OLDate.WeeksInYear: OLInteger;
begin
  Result := Self.FValue.WeeksInYear();
end;

function OLDate.WeekSpan(const Date: OLDate): OLDouble;
begin
  Result := Self.FValue.WeekSpan(Date);
end;

function OLDate.YearsBetween(const Date: OLDate): OLInteger;
begin
  Result := Self.FValue.YearsBetween(Date);
end;

function OLDate.YearSpan(const Date: OLDate): OLDouble;
begin
  Result := Self.FValue.YearSpan(Date);
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

function OLDate.WithYear(const AYear: OLInteger): OLDate;
begin
  Result := Self.FValue.WithYear(AYear);
end;

function OLDate.WithMonth(const AMonth: OLInteger): OLDate;
begin
  Result := Self.FValue.WithMonth(AMonth);
end;

function OLDate.WithDay(const ADay: OLInteger): OLDate;
begin
  Result := Self.FValue.WithDay(ADay);
end;

end.
