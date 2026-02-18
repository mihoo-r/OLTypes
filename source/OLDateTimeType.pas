unit OLDateTimeType;

interface

uses
  Variants, SysUtils, DateUtils, OlBooleanType, OLIntegerType, OLDoubleType,
  {$IF CompilerVersion >= 23.0} System.Classes {$ELSE} Classes {$IFEND};

type
  /// <summary>
  ///   A record type representing a date and time value with null-handling capabilities.
  /// </summary>
  OLDateTime = record
  private
    FValue: TDateTime;
    {$IF CompilerVersion >= 34.0}
    FHasValue: Boolean;
    FOnChange: TNotifyEvent;
    {$ELSE}
    FHasValue: string;
    {$IFEND}

    function GetHasValue(): OLBoolean;
    procedure SetHasValue(const Value: OLBoolean);
    function GetDay: OLInteger;
    function GetHour: OLInteger;
    function GetMilliSecond: OLInteger;
    function GetMinute: OLInteger;
    function GetMonth: OLInteger;
    function GetSecond: OLInteger;
    function GetYear: OLInteger;
   {$IFDEF OL_MUTABLE}
    procedure SetHour(const Value: OLInteger);
    procedure SetMilliSecond(const Value: OLInteger);
    procedure SetMinute(const Value: OLInteger);
    procedure SetMonth(const Value: OLInteger);
    procedure SetSecond(const Value: OLInteger);
    procedure SetYear(const Value: OLInteger);
    procedure SetDay(const Value: OLInteger);
    {$ENDIF}
    /// <summary>
    ///   Gets or sets whether the datetime has a value (is not null).
    /// </summary>
    property ValuePresent: OLBoolean read GetHasValue write SetHasValue;

    function YearOf(): OLInteger;
    function MonthOf(): OLInteger;
    function WeekOf(): OLInteger; { ISO 8601 }
    function DayOf(): OLInteger;
    function HourOf(): OLInteger;
    function MinuteOf(): OLInteger;
    function SecondOf(): OLInteger;
    function MilliSecondOf(): OLInteger;
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
    ///   Gets or sets the hour component.
    /// </summary>
    property Hour: OLInteger read GetHour {$IFDEF OL_MUTABLE} write SetHour {$ENDIF};
    /// <summary>
    ///   Gets or sets the minute component.
    /// </summary>
    property Minute: OLInteger read GetMinute {$IFDEF OL_MUTABLE} write SetMinute {$ENDIF};
    /// <summary>
    ///   Gets or sets the second component.
    /// </summary>
    property Second: OLInteger read GetSecond {$IFDEF OL_MUTABLE} write SetSecond {$ENDIF};
    /// <summary>
    ///   Gets or sets the millisecond component.
    /// </summary>
    property MilliSecond: OLInteger read GetMilliSecond {$IFDEF OL_MUTABLE} write SetMilliSecond {$ENDIF};

    /// <summary>
    ///   Checks if the datetime is null (has no value).
    /// </summary>
    function IsNull(): OLBoolean;
    /// <summary>
    ///   Checks if the datetime has a value (is not null).
    /// </summary>
    function HasValue(): OLBoolean;
    /// <summary>
    ///   Returns the TDateTime value, or a replacement TDateTime if null.
    /// </summary>
    function AsDateTime(const NullReplacement: TDateTime = 0): TDateTime;
    /// <summary>
    ///   Converts the datetime to a string.
    /// </summary>
    function ToString(): string; overload;
    /// <summary>
    ///   Converts the datetime to a string with the specified format.
    /// </summary>
    function ToString(const Format: string): string; overload;
    /// <summary>
    ///   Converts the datetime to a SQL-safe string (value or NULL).
    /// </summary>
    function ToSQLString(): string;
    /// <summary>
    ///   Returns the current datetime if it has a value, otherwise returns the provided default value.
    /// </summary>
    function IfNull(b: OLDateTime): OLDateTime;

    class operator Implicit(const a: TDateTime): OLDateTime;
    class operator Implicit(const a: OLDateTime): TDateTime;
    class operator Implicit(const a: Variant): OLDateTime;
    class operator Implicit(const a: OLDateTime): Variant;
    class operator Implicit(const a: OLDateTime): Extended;
    class operator Implicit(const a: Extended): OLDateTime;
    class operator Implicit(const a: string): OLDateTime;

    class operator Equal(const a, b: OLDateTime): Boolean;
    class operator NotEqual(const a, b: OLDateTime): Boolean;
    class operator GreaterThan(const a, b: OLDateTime): Boolean;
    class operator GreaterThanOrEqual(const a, b: OLDateTime): Boolean;
    class operator LessThan(const a, b: OLDateTime): Boolean;
    class operator LessThanOrEqual(const a, b: OLDateTime): Boolean;

    class operator Add(const a: OLDateTime; const b: Extended): OLDateTime;
    class operator Subtract(const a: OLDateTime; const b: Extended): OLDateTime;

    /// <summary>
    ///   Returns the date part of the datetime.
    /// </summary>
    function DateOf(): OLDateTime;
    /// <summary>
    ///   Returns the time part of the datetime.
    /// </summary>
    function TimeOf(): OLDateTime;

    /// <summary>
    ///   Checks if the datetime is in a leap year.
    /// </summary>
    function IsInLeapYear(): OLBoolean;

    /// <summary>
    ///   Checks if the time is PM (afternoon).
    /// </summary>
    function IsPM(): OLBoolean;
    /// <summary>
    ///   Checks if the time is AM (morning).
    /// </summary>
    function IsAM(): OLBoolean;

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
    class function Today: OLDateTime; static;
    /// <summary>
    ///   Returns yesterday's date.
    /// </summary>
    class function Yesterday: OLDateTime; static;
    /// <summary>
    ///   Returns tomorrow's date.
    /// </summary>
    class function Tomorrow: OLDateTime; static;
    /// <summary>
    ///   Returns the current date and time.
    /// </summary>
    class function Now(): OLDateTime; static;

    {$IFDEF OL_MUTABLE}
    /// <summary>
    ///   Sets the datetime to the current date and time.
    /// </summary>
    procedure SetNow();
    /// <summary>
    ///   Sets the datetime to today's date.
    /// </summary>
    procedure SetToday();
    /// <summary>
    ///   Sets the datetime to tomorrow's date.
    /// </summary>
    procedure SetTomorrow();
    /// <summary>
    ///   Sets the datetime to yesterday's date.
    /// </summary>
    procedure SetYesterday();
    {$ENDIF}

    /// <summary>
    ///   Checks if the datetime is today.
    /// </summary>
    function IsToday(): OLBoolean;
    /// <summary>
    ///   Checks if the datetime is on the same day as the specified datetime.
    /// </summary>
    function SameDay(const DateTimeToCompare: OLDateTime): OLBoolean;

    /// <summary>
    ///   Returns the start of the current year.
    /// </summary>
    function StartOfTheYear(): OLDateTime;
    /// <summary>
    ///   Returns the end of the current year.
    /// </summary>
    function EndOfTheYear(): OLDateTime;
    /// <summary>
    ///   Returns the start of the specified year.
    /// </summary>
    class function StartOfAYear(const AYear: Word): OLDateTime; static;
    /// <summary>
    ///   Returns the end of the specified year.
    /// </summary>
    class function EndOfAYear(const AYear: Word): OLDateTime; static;

    {$IFDEF OL_MUTABLE}
    /// <summary>
    ///   Sets the datetime to the start of the specified year.
    /// </summary>
    procedure SetStartOfAYear(const AYear: Word);
    /// <summary>
    ///   Sets the datetime to the end of the specified year.
    /// </summary>
    procedure SetEndOfAYear(const AYear: Word);
    {$ENDIF}

    /// <summary>
    ///   Returns the start of the current month.
    /// </summary>
    function StartOfTheMonth(): OLDateTime;
    /// <summary>
    ///   Returns the end of the current month.
    /// </summary>
    function EndOfTheMonth(): OLDateTime;
    /// <summary>
    ///   Returns the start of the specified month.
    /// </summary>
    class function StartOfAMonth(const AYear, AMonth: Word): OLDateTime; static;
    /// <summary>
    ///   Returns the end of the specified month.
    /// </summary>
    class function EndOfAMonth(const AYear, AMonth: Word): OLDateTime; static;
    {$IFDEF OL_MUTABLE}
    /// <summary>
    ///   Sets the datetime to the start of the specified month.
    /// </summary>
    procedure SetStartOfAMonth(const AYear, AMonth: Word);
    /// <summary>
    ///   Sets the datetime to the end of the specified month.
    /// </summary>
    procedure SetEndOfAMonth(const AYear, AMonth: Word);
    {$ENDIF}

    /// <summary>
    ///   Returns the start of the current week (ISO 8601).
    /// </summary>
    function StartOfTheWeek(): OLDateTime; { ISO 8601 }
    /// <summary>
    ///   Returns the end of the current week (ISO 8601).
    /// </summary>
    function EndOfTheWeek(): OLDateTime; { ISO 8601 }

    /// <summary>
    ///   Returns the start of the current day.
    /// </summary>
    function StartOfTheDay(): OLDateTime;
    /// <summary>
    ///   Returns the end of the current day.
    /// </summary>
    function EndOfTheDay(): OLDateTime;

    /// <summary>
    ///   Returns the day number within the year.
    /// </summary>
    function DayOfTheYear(): OLInteger;
    /// <summary>
    ///   Returns the hour number within the year.
    /// </summary>
    function HourOfTheYear(): OLInteger;
    /// <summary>
    ///   Returns the minute number within the year.
    /// </summary>
    function MinuteOfTheYear(): OLInt64;
    /// <summary>
    ///   Returns the second number within the year.
    /// </summary>
    function SecondOfTheYear(): OLInt64;
    /// <summary>
    ///   Returns the millisecond number within the year.
    /// </summary>
    function MilliSecondOfTheYear(): OLInt64;

    /// <summary>
    ///   Returns the hour number within the month.
    /// </summary>
    function HourOfTheMonth(): OLInteger;
    /// <summary>
    ///   Returns the minute number within the month.
    /// </summary>
    function MinuteOfTheMonth(): OLInteger;
    /// <summary>
    ///   Returns the second number within the month.
    /// </summary>
    function SecondOfTheMonth(): OLInt64;
    /// <summary>
    ///   Returns the millisecond number within the month.
    /// </summary>
    function MilliSecondOfTheMonth(): OLInt64;

    /// <summary>
    ///   Returns the day number within the week (ISO 8601).
	///   1 as Monday, 7 as Sunday.
    /// </summary>
    function DayOfTheWeek(): OLInteger; { ISO 8601 }
    /// <summary>
    ///   Returns the hour number within the week (ISO 8601).
    /// </summary>
    function HourOfTheWeek(): OLInteger; { ISO 8601 }
    /// <summary>
    ///   Returns the minute number within the week (ISO 8601).
    /// </summary>
    function MinuteOfTheWeek(): OLInteger; { ISO 8601 }
    /// <summary>
    ///   Returns the second number within the week (ISO 8601).
    /// </summary>
    function SecondOfTheWeek(): OLInt64; { ISO 8601 }
    /// <summary>
    ///   Returns the millisecond number within the week (ISO 8601).
    /// </summary>
    function MilliSecondOfTheWeek(): OLInt64; { ISO 8601 }

    /// <summary>
    ///   Returns the minute number within the day.
    /// </summary>
    function MinuteOfTheDay(): OLInteger;
    /// <summary>
    ///   Returns the second number within the day.
    /// </summary>
    function SecondOfTheDay(): OLInt64;
    /// <summary>
    ///   Returns the millisecond number within the day.
    /// </summary>
    function MilliSecondOfTheDay(): OLInt64;

    /// <summary>
    ///   Returns the second number within the hour.
    /// </summary>
    function SecondOfTheHour(): OLInteger;
    /// <summary>
    ///   Returns the millisecond number within the hour.
    /// </summary>
    function MilliSecondOfTheHour(): OLInt64;

    /// <summary>
    ///   Returns the millisecond number within the minute.
    /// </summary>
    function MilliSecondOfTheMinute(): OLInt64;

    /// <summary>
    ///   Returns the number of seconds since the start of the specified year.
    /// </summary>
    class function SecondCount(const StartingYear: Integer = 2017): OLInteger; static;
    /// <summary>
    ///   Creates a datetime from a second count since the start of the specified year.
    /// </summary>
    class function DateTimeFromSecondCount(const Count: integer; const StartingYear: Integer = 2017): OLDateTime; static;
    {$IFDEF OL_MUTABLE}
    /// <summary>
    ///   Sets the datetime from a second count since the start of the specified year.
    /// </summary>
    procedure SetFromSecondCount(const Count: integer; const StartingYear: Integer = 2017);
    {$ENDIF}

    /// <summary>
    ///   Returns the number of complete years between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function YearsBetween(const Date: OLDateTime): OLInteger;
    /// <summary>
    ///   Returns the number of complete months between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function MonthsBetween(const Date: OLDateTime): OLInteger;
    /// <summary>
    ///   Returns the number of complete weeks between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function WeeksBetween(const Date: OLDateTime): OLInteger;
    /// <summary>
    ///   Returns the number of complete days between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function DaysBetween(const Date: OLDateTime): OLInteger;
    /// <summary>
    ///   Returns the number of complete hours between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function HoursBetween(const Date: OLDateTime): OLInt64;
    /// <summary>
    ///   Returns the number of complete minutes between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function MinutesBetween(const Date: OLDateTime): OLInt64;
    /// <summary>
    ///   Returns the number of complete seconds between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function SecondsBetween(const Date: OLDateTime): OLInt64;
    /// <summary>
    ///   Returns the number of complete milliseconds between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. The result is always a non-negative number.</param>
    function MilliSecondsBetween(const Date: OLDateTime): OLInt64;

    /// <summary>
    ///   Returns the number of complete years from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function YearsFrom(const Date: OLDateTime): OLInteger;
    /// <summary>
    ///   Returns the number of complete years from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function YearsTo(const Date: OLDateTime): OLInteger;
    /// <summary>
    ///   Returns the number of complete months from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function MonthsFrom(const Date: OLDateTime): OLInteger;
    /// <summary>
    ///   Returns the number of complete months from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function MonthsTo(const Date: OLDateTime): OLInteger;
    /// <summary>
    ///   Returns the number of complete weeks from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function WeeksFrom(const Date: OLDateTime): OLInteger;
    /// <summary>
    ///   Returns the number of complete weeks from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function WeeksTo(const Date: OLDateTime): OLInteger;
    /// <summary>
    ///   Returns the number of complete days from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function DaysFrom(const Date: OLDateTime): OLInteger;
    /// <summary>
    ///   Returns the number of complete days from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function DaysTo(const Date: OLDateTime): OLInteger;
    /// <summary>
    ///   Returns the number of complete hours from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function HoursFrom(const Date: OLDateTime): OLInt64;
    /// <summary>
    ///   Returns the number of complete hours from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function HoursTo(const Date: OLDateTime): OLInt64;
    /// <summary>
    ///   Returns the number of complete minutes from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function MinutesFrom(const Date: OLDateTime): OLInt64;
    /// <summary>
    ///   Returns the number of complete minutes from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function MinutesTo(const Date: OLDateTime): OLInt64;
    /// <summary>
    ///   Returns the number of complete seconds from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function SecondsFrom(const Date: OLDateTime): OLInt64;
    /// <summary>
    ///   Returns the number of complete seconds from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function SecondsTo(const Date: OLDateTime): OLInt64;
    /// <summary>
    ///   Returns the number of complete milliseconds from the specified datetime to this datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date > Self.</param>
    function MilliSecondsFrom(const Date: OLDateTime): OLInt64;
    /// <summary>
    ///   Returns the number of complete milliseconds from this datetime to the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. Returns negative if Date < Self.</param>
    function MilliSecondsTo(const Date: OLDateTime): OLInt64;

    /// <summary>
    ///   Checks if the datetime is within the specified range.
    /// </summary>
    function InRange(const AStartDateTime, AEndDateTime: OLDateTime; const aInclusive: Boolean = True): OLBoolean;
    /// <summary>
    ///   Checks if the date part is within the specified date range.
    /// </summary>
    function InDateRange(const AStartDateTime, AEndDateTime: TDate; const aInclusive: Boolean = True): OLBoolean;

    /// <summary>
    ///   Returns the approximate number of years between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. If Date is less than Self, the result is a non-negative number.</param>
    function YearSpan(const Date: OLDateTime): OLDouble;
    /// <summary>
    ///   Returns the approximate number of months between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. If Date is less than Self, the result is a non-negative number.</param>
    function MonthSpan(const Date: OLDateTime): OLDouble;
    /// <summary>
    ///   Returns the approximate number of weeks between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. If Date is less than Self, the result is a non-negative number.</param>
    function WeekSpan(const Date: OLDateTime): OLDouble;
    /// <summary>
    ///   Returns the approximate number of days between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. If Date is less than Self, the result is a non-negative number.</param>
    function DaySpan(const Date: OLDateTime): OLDouble;
    /// <summary>
    ///   Returns the approximate number of hours between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. If Date is less than Self, the result is a non-negative number.</param>
    function HourSpan(const Date: OLDateTime): OLDouble;
    /// <summary>
    ///   Returns the approximate number of minutes between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. If Date is less than Self, the result is a non-negative number.</param>
    function MinuteSpan(const Date: OLDateTime): OLDouble;
    /// <summary>
    ///   Returns the approximate number of seconds between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. If Date is less than Self, the result is a non-negative number.</param>
    function SecondSpan(const Date: OLDateTime): OLDouble;
    /// <summary>
    ///   Returns the approximate number of milliseconds between this datetime and the specified datetime.
    /// </summary>
    /// <param name="Date">The datetime to compare with. If Date is less than Self, the result is a non-negative number.</param>
    function MilliSecondSpan(const Date: OLDateTime): OLDouble;


    /// <summary>
    ///   Returns the datetime incremented by the specified number of years.
    /// </summary>
    function IncYear(const ANumberOfYears: Integer = 1): OLDateTime;
    /// <summary>
    ///   Returns the datetime incremented by the specified number of months.
    /// </summary>
    function IncMonth(const ANumberOfMonths: Integer = 1): OLDateTime;
    /// <summary>
    ///   Returns the datetime incremented by the specified number of weeks.
    /// </summary>
    function IncWeek(const ANumberOfWeeks: Integer = 1): OLDateTime;
    /// <summary>
    ///   Returns the datetime incremented by the specified number of days.
    /// </summary>
    function IncDay(const ANumberOfDays: Integer = 1): OLDateTime;
    /// <summary>
    ///   Returns the datetime incremented by the specified number of hours.
    /// </summary>
    function IncHour(const ANumberOfHours: Int64 = 1): OLDateTime;
    /// <summary>
    ///   Returns the datetime incremented by the specified number of minutes.
    /// </summary>
    function IncMinute(const ANumberOfMinutes: Int64 = 1): OLDateTime;
    /// <summary>
    ///   Returns the datetime incremented by the specified number of seconds.
    /// </summary>
    function IncSecond(const ANumberOfSeconds: Int64 = 1): OLDateTime;
    /// <summary>
    ///   Returns the datetime incremented by the specified number of milliseconds.
    /// </summary>
    function IncMilliSecond(const ANumberOfMilliSeconds: Int64 = 1): OLDateTime;

    /// <summary>
    ///   Decodes the datetime into its component parts.
    /// </summary>
    procedure DecodeDateTime(out AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word);
    class function Create(const AYear, AMonth, ADay: Word; const AHour: Word = 0;
        const AMinute: Word = 0; const ASecond: Word = 0; const AMilliSecond: Word
        = 0): OLDateTime; static;
    {$IFDEF OL_MUTABLE}
    /// <summary>
    ///   Encodes the datetime from component parts.
    /// </summary>
    procedure EncodeDateTime(const AYear, AMonth, ADay: Word; const AHour: Word = 0; const AMinute: Word = 0;
      const ASecond: Word = 0; const AMilliSecond: Word = 0);
    {$ENDIF}

    /// <summary>
    ///   Returns the datetime with the year component changed.
    /// </summary>
    function WithYear(const AYear: OLInteger): OLDateTime;
    /// <summary>
    ///   Returns the datetime with the month component changed.
    /// </summary>
    function WithMonth(const AMonth: OLInteger): OLDateTime;
    /// <summary>
    ///   Returns the datetime with the day component changed.
    /// </summary>
    function WithDay(const ADay: OLInteger): OLDateTime;
    /// <summary>
    ///   Returns the datetime with the hour component changed.
    /// </summary>
    function WithHour(const AHour: OLInteger): OLDateTime;
    /// <summary>
    ///   Returns the datetime with the minute component changed.
    /// </summary>
    function WithMinute(const AMinute: OLInteger): OLDateTime;
    /// <summary>
    ///   Returns the datetime with the second component changed.
    /// </summary>
    function WithSecond(const ASecond: OLInteger): OLDateTime;
    /// <summary>
    ///   Returns the datetime with the millisecond component changed.
    /// </summary>
    function WithMilliSecond(const AMilliSecond: OLInteger): OLDateTime;

    /// <summary>
    ///   Returns the datetime with the year component changed.
    /// </summary>
    function RecodedYear(const AYear: Word): OLDateTime;
    /// <summary>
    ///   Returns the datetime with the month component changed.
    /// </summary>
    function RecodedMonth(const AMonth: Word): OLDateTime;
    /// <summary>
    ///   Returns the datetime with the day component changed.
    /// </summary>
    function RecodedDay(const ADay: Word): OLDateTime;
    /// <summary>
    ///   Returns the datetime with the hour component changed.
    /// </summary>
    function RecodedHour(const AHour: Word): OLDateTime;
    /// <summary>
    ///   Returns the datetime with the minute component changed.
    /// </summary>
    function RecodedMinute(const AMinute: Word): OLDateTime;
    /// <summary>
    ///   Returns the datetime with the second component changed.
    /// </summary>
    function RecodedSecond(const ASecond: Word): OLDateTime;
    /// <summary>
    ///   Returns the datetime with the millisecond component changed.
    /// </summary>
    function RecodedMilliSecond(const AMilliSecond: Word): OLDateTime;

    /// <summary>
    ///   Checks if the time part is the same as the specified datetime.
    /// </summary>
    function SameTime(const DateTimeToCompare: OLDateTime): OLBoolean;

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
    ///   Returns the later of the two datetimes.
    /// </summary>
    function Max(const CompareDate: OLDateTime): OLDateTime;
    /// <summary>
    ///   Returns the earlier of the two datetimes.
    /// </summary>
    function Min(const CompareDate: OLDateTime): OLDateTime;

    {$IF CompilerVersion >= 34.0}
    class operator Initialize(out Dest: OLDateTime);
    class operator Assign(var Dest: OLDateTime; const [ref] Src: OLDateTime);
    /// <summary>
    ///   Event handler for value changes.
    /// </summary>
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {$IFEND}
  end;

  POLDateTime = ^OLDateTime;

implementation


const
  NonEmptyStr = ' ';

  { OLDateTime }

class operator OLDateTime.Add(const a: OLDateTime; const b: Extended):
    OLDateTime;
var
  OutPut: OLDateTime;
begin
  if a.ValuePresent then
    OutPut := a.FValue + b
  else
    OutPut := Null;

  Result := OutPut;
end;

function OLDateTime.DateOf: OLDateTime;
var
  OutPut: OLDateTime;
begin
  if Self.ValuePresent then
    OutPut := DateUtils.DateOf(Self.FValue)
  else
    OutPut := Null;

  Result := OutPut;
end;

class function OLDateTime.DateTimeFromSecondCount(const Count,
  StartingYear: Integer): OLDateTime;
begin
  Result := OLDateTime.StartOfAYear(StartingYear).IncSecond(Count);
end;

function OLDateTime.InDateRange(const AStartDateTime, AEndDateTime: TDate; const aInclusive: Boolean): OLBoolean;
var
  OutPut: OLBoolean;
begin
  if aInclusive then
    OutPut := (Self.DateOf() >= AStartDateTime) and (Self.DateOf() <= AEndDateTime)
  else
    OutPut := (Self.DateOf() > AStartDateTime) and (Self.DateOf() < AEndDateTime);

  Result := OutPut;
end;

function OLDateTime.InRange(const AStartDateTime, AEndDateTime: OLDateTime;
  const aInclusive: Boolean): OLBoolean;
var
  OutPut: OLBoolean;
begin
  if aInclusive then
    OutPut := (Self >= AStartDateTime) and (Self <= AEndDateTime)
  else
    OutPut := (Self > AStartDateTime) and (Self < AEndDateTime);

  Result := OutPut;
end;

function OLDateTime.DayOf: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.DayOf(Self);
end;

function OLDateTime.DayOfTheWeek: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.DayOfTheWeek(Self);
end;

function OLDateTime.DayOfTheYear: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.DayOfTheYear(Self);
end;

function OLDateTime.DaysBetween(const Date: OLDateTime): OLInteger;
begin
  if IsNull or Date.IsNull then
    exit(null);

  Result := Abs(Round(Self.FValue - Date.FValue));
end;

function OLDateTime.DaysInMonth(): OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.DaysInMonth(Self);
end;

function OLDateTime.DaysInYear: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.DaysInYear(Self);
end;

function OLDateTime.DaySpan(const Date: OLDateTime): OLDouble;
begin
  if not Self.ValuePresent or not Date.ValuePresent then
    Exit(Null);
  Result := DateUtils.DaySpan(Self, Date);
end;

procedure OLDateTime.DecodeDateTime(out AYear, AMonth, ADay, AHour, AMinute,
  ASecond, AMilliSecond: Word);
begin
  DateUtils.DecodeDateTime(Self, AYear, AMonth, ADay, AHour, AMinute, ASecond,  AMilliSecond);
end;

{$IFDEF OL_MUTABLE}
procedure OLDateTime.EncodeDateTime(const AYear, AMonth, ADay: Word; const
    AHour: Word = 0; const AMinute: Word = 0; const ASecond: Word = 0; const
    AMilliSecond: Word = 0);
begin
  self := DateUtils.EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
end;
{$ENDIF}

class function OLDateTime.Create(const AYear, AMonth, ADay: Word; const AHour:
    Word = 0; const AMinute: Word = 0; const ASecond: Word = 0; const
    AMilliSecond: Word = 0): OLDateTime;
begin
  Result := DateUtils.EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
end;

class function OLDateTime.EndOfAMonth(const AYear, AMonth: Word): OLDateTime;
begin
  Result := DateUtils.EndOfAMonth(AYear, AMonth);
end;

class function OLDateTime.EndOfAYear(const AYear: Word): OLDateTime;
begin
  Result := DateUtils.EndOfAYear(AYear);
end;

function OLDateTime.EndOfTheDay: OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.EndOfTheDay(Self);
end;

function OLDateTime.EndOfTheMonth: OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.EndOfTheMonth(Self);
end;

function OLDateTime.EndOfTheWeek: OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.EndOfTheWeek(Self);
end;

function OLDateTime.EndOfTheYear: OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.EndOfTheYear(Self);
end;

class operator OLDateTime.Equal(const a, b: OLDateTime): Boolean;
begin
  Result := (a.ValuePresent and b.ValuePresent and (System.Abs(a.FValue - b.FValue) < 1.1574e-8)) or (a.IsNull() and b.IsNull());  //Less than a millisecond difference
end;

function OLDateTime.GetDay: OLInteger;
begin
  Result := Self.DayOf();
end;

function OLDateTime.GetHasValue: OLBoolean;
begin
  {$IF CompilerVersion >= 34.0}
  Result := FHasValue;
  {$ELSE}
  Result := FHasValue = ' ';
  {$IFEND}
end;

function OLDateTime.GetHour: OLInteger;
begin
  Result := Self.HourOf();
end;

function OLDateTime.GetMilliSecond: OLInteger;
begin
  Result := Self.MilliSecondOf();
end;

function OLDateTime.GetMinute: OLInteger;
begin
  Result := Self.MinuteOf();
end;

function OLDateTime.GetMonth: OLInteger;
begin
  Result := Self.MonthOf();
end;

function OLDateTime.GetSecond: OLInteger;
begin
  Result := Self.SecondOf();
end;

function OLDateTime.GetYear: OLInteger;
begin
  Result := Self.YearOf();
end;

class function OLDateTime.SecondCount(const StartingYear: Integer): OLInteger;
var
  d: OLDateTime;
begin
  {$IFDEF OL_MUTABLE}
  d.SetNow();
  {$ENDIF}

  {$IFNDEF OL_MUTABLE}
  d := OLDateTime.Now();
  {$ENDIF}

  Result := d.SecondsBetween(OLDateTime.StartOfAYear(StartingYear));
end;

class operator OLDateTime.GreaterThan(const a, b: OLDateTime): Boolean;
begin
  Result := (a.FValue > b.FValue) and a.ValuePresent and b.ValuePresent;
end;

class operator OLDateTime.GreaterThanOrEqual(const a, b: OLDateTime): Boolean;
begin
  Result := ((a.FValue >= b.FValue) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLDateTime.HasValue: OLBoolean;
begin
  Result := ValuePresent;
end;

function OLDateTime.HourOf: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.HourOf(Self);
end;

function OLDateTime.HourOfTheMonth: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.HourOfTheMonth(Self);
end;

function OLDateTime.HourOfTheWeek: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.HourOfTheWeek(Self);
end;

function OLDateTime.HourOfTheYear: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.HourOfTheYear(Self);
end;

function OLDateTime.HoursBetween(const Date: OLDateTime): OLInt64;
var
  MinusSign: OLBoolean;
begin
  if not Self.ValuePresent or not Date.ValuePresent then
    Exit(Null);
  Result := DateUtils.HoursBetween(Self, Date);
end;

function OLDateTime.HourSpan(const Date: OLDateTime): OLDouble;
begin
  if not Self.ValuePresent or not Date.ValuePresent then
    Exit(Null);
  Result := DateUtils.HourSpan(Self, Date);
end;

function OLDateTime.IfNull(b: OLDateTime): OLDateTime;
var
  OutPut: OLDateTime;
begin
  if ValuePresent then
    OutPut := Self
  else
    OutPut := b;

  Result := OutPut;
end;

function OLDateTime.AsDateTime(const NullReplacement: TDateTime = 0): TDateTime;
begin
  Result := IfNull(NullReplacement);
end;

class operator OLDateTime.Implicit(const a: OLDateTime): Variant;
var
  OutPut: Variant;
begin
  if a.ValuePresent then
    OutPut := a.FValue
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLDateTime.Implicit(const a: Variant): OLDateTime;
var
  OutPut: OLDateTime;
  b: TDateTime;
begin
  if VarIsNull(a) then
  begin
    OutPut.ValuePresent := false;
    OutPut.FValue := 0;
  end
  else
  begin
    if TryStrToDateTime(a, b) then
    begin
      OutPut.FValue := b;
      OutPut.ValuePresent := True;
    end
    else
    begin
      raise Exception.Create('Value ''' + VarToStr(a) + ''' cannot be assigned to variable of OLDateTime type.');
    end;
  end;

  Result := OutPut;
end;

class operator OLDateTime.Implicit(const a: OLDateTime): TDateTime;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as TDateTime value.');
  Result := a.FValue;
end;

class operator OLDateTime.Implicit(const a: OLDateTime): Extended;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as Extended value');
  Result := a.FValue;
end;

class operator OLDateTime.Implicit(const a: TDateTime): OLDateTime;
var
  OutPut: OLDateTime;
begin
  OutPut.FValue := a;
  OutPut.ValuePresent := True;
  Result := OutPut;
end;

function OLDateTime.IsAM: OLBoolean;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := not DateUtils.IsPM(Self);
end;

function OLDateTime.IsInLeapYear: OLBoolean;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.IsInLeapYear(Self);
end;

function OLDateTime.IsNull: OLBoolean;
begin
  Result := not ValuePresent;
end;

function OLDateTime.IsPM: OLBoolean;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.IsPM(Self);
end;

function OLDateTime.SameDay(const DateTimeToCompare: OLDateTime): OLBoolean;
begin
  if not Self.ValuePresent or not DateTimeToCompare.ValuePresent then
    Exit(Null);
  Result := DateUtils.IsSameDay(Self, DateTimeToCompare);
end;

function OLDateTime.IsToday: OLBoolean;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.IsToday(Self);
end;

class operator OLDateTime.LessThan(const a, b: OLDateTime): Boolean;
begin
  Result := (a.FValue < b.FValue) and a.ValuePresent and b.ValuePresent;
end;

class operator OLDateTime.LessThanOrEqual(const a, b: OLDateTime): Boolean;
begin
  Result := ((a.FValue <= b.FValue) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLDateTime.LongDayName: string;
begin
  {$if CompilerVersion > 22} // Delphi XE or later
     Result := SysUtils.FormatSettings.LongDayNames[DayOfWeek(Self)];
  {$else}
    Result := LongDayNames[DayOfWeek(Self)];
  {$ifend}
end;

function OLDateTime.LongMonthName: string;
begin
  {$if CompilerVersion > 22} // Delphi XE or later
     Result := SysUtils.FormatSettings.LongMonthNames[Self.Month.AsInteger()];
  {$else}
    Result := LongMonthNames[Self.Month.AsInteger()];
  {$ifend}
end;

function OLDateTime.ShortMonthName: string;
begin
  {$if CompilerVersion > 22} // Delphi XE or later
     Result := SysUtils.FormatSettings.ShortMonthNames[Self.Month.AsInteger()];
  {$else}
    Result := ShortMonthNames[Self.Month.AsInteger()];
  {$ifend}
end;

function OLDateTime.Max(const CompareDate: OLDateTime): OLDateTime;
var
  OutPut: OLDateTime;
begin
  if Self.ValuePresent and CompareDate.ValuePresent then
  begin
    if Self.FValue > CompareDate.FValue then
      OutPut := Self
    else
      OutPut := CompareDate;
  end
  else
    OutPut := Null;

  Result := OutPut;
end;

function OLDateTime.MilliSecondOf: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.MilliSecondOf(Self);
end;

function OLDateTime.MilliSecondOfTheDay: OLInt64;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.MilliSecondOfTheDay(Self);
end;

function OLDateTime.MilliSecondOfTheHour: OLInt64;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.MilliSecondOfTheHour(Self);
end;

function OLDateTime.MilliSecondOfTheMinute: OLInt64;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.MilliSecondOfTheMinute(Self);
end;

function OLDateTime.MilliSecondOfTheMonth: OLInt64;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.MilliSecondOfTheMonth(Self);
end;

function OLDateTime.MilliSecondOfTheWeek: OLInt64;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.MilliSecondOfTheWeek(Self);
end;

function OLDateTime.MilliSecondOfTheYear: OLInt64;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.MilliSecondOfTheYear(Self);
end;

function OLDateTime.MilliSecondsBetween(const Date: OLDateTime): OLInt64;
begin
  if not Self.ValuePresent or not Date.ValuePresent then
    Exit(Null);
  Result := DateUtils.MilliSecondsBetween(Self, Date);
end;

function OLDateTime.YearsFrom(const Date: OLDateTime): OLInteger;
begin
  if Date > Self then
    Result := -YearsBetween(Date)
  else
    Result := YearsBetween(Date);
end;

function OLDateTime.YearsTo(const Date: OLDateTime): OLInteger;
begin
  if Date < Self then
    Result := -YearsBetween(Date)
  else
    Result := YearsBetween(Date);
end;

function OLDateTime.MonthsFrom(const Date: OLDateTime): OLInteger;
begin
  if Date > Self then
    Result := -MonthsBetween(Date)
  else
    Result := MonthsBetween(Date);
end;

function OLDateTime.MonthsTo(const Date: OLDateTime): OLInteger;
begin
  if Date < Self then
    Result := -MonthsBetween(Date)
  else
    Result := MonthsBetween(Date);
end;

function OLDateTime.WeeksFrom(const Date: OLDateTime): OLInteger;
begin
  if Date > Self then
    Result := -WeeksBetween(Date)
  else
    Result := WeeksBetween(Date);
end;

function OLDateTime.WeeksTo(const Date: OLDateTime): OLInteger;
begin
  if Date < Self then
    Result := -WeeksBetween(Date)
  else
    Result := WeeksBetween(Date);
end;

function OLDateTime.DaysFrom(const Date: OLDateTime): OLInteger;
begin
  if Date > Self then
    Result := -DaysBetween(Date)
  else
    Result := DaysBetween(Date);
end;

function OLDateTime.DaysTo(const Date: OLDateTime): OLInteger;
begin
  if Date < Self then
    Result := -DaysBetween(Date)
  else
    Result := DaysBetween(Date);
end;

function OLDateTime.HoursFrom(const Date: OLDateTime): OLInt64;
begin
  if Date > Self then
    Result := -HoursBetween(Date)
  else
    Result := HoursBetween(Date);
end;

function OLDateTime.HoursTo(const Date: OLDateTime): OLInt64;
begin
  if Date < Self then
    Result := -HoursBetween(Date)
  else
    Result := HoursBetween(Date);
end;

function OLDateTime.MinutesFrom(const Date: OLDateTime): OLInt64;
begin
  if Date > Self then
    Result := -MinutesBetween(Date)
  else
    Result := MinutesBetween(Date);
end;

function OLDateTime.MinutesTo(const Date: OLDateTime): OLInt64;
begin
  if Date < Self then
    Result := -MinutesBetween(Date)
  else
    Result := MinutesBetween(Date);
end;

function OLDateTime.SecondsFrom(const Date: OLDateTime): OLInt64;
begin
  if Date > Self then
    Result := -SecondsBetween(Date)
  else
    Result := SecondsBetween(Date);
end;

function OLDateTime.SecondsTo(const Date: OLDateTime): OLInt64;
begin
  if Date < Self then
    Result := -SecondsBetween(Date)
  else
    Result := SecondsBetween(Date);
end;

function OLDateTime.MilliSecondsFrom(const Date: OLDateTime): OLInt64;
begin
  if Date > Self then
    Result := -MilliSecondsBetween(Date)
  else
    Result := MilliSecondsBetween(Date);
end;

function OLDateTime.MilliSecondsTo(const Date: OLDateTime): OLInt64;
begin
  if Date < Self then
    Result := -MilliSecondsBetween(Date)
  else
    Result := MilliSecondsBetween(Date);
end;

function OLDateTime.MilliSecondSpan(const Date: OLDateTime): OLDouble;
begin
  if not Self.ValuePresent or not Date.ValuePresent then
    Exit(Null);
  Result := DateUtils.MilliSecondSpan(Self, Date);
end;

function OLDateTime.Min(const CompareDate: OLDateTime): OLDateTime;
var
  OutPut: OLDateTime;
begin
  if Self.ValuePresent and CompareDate.ValuePresent then
  begin
    if Self.FValue < CompareDate.FValue then
      OutPut := Self
    else
      OutPut := CompareDate;
  end
  else
    OutPut := Null;

  Result := OutPut;
end;

function OLDateTime.MinuteOf: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.MinuteOf(Self);
end;

function OLDateTime.MinuteOfTheDay: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.MinuteOfTheDay(Self);
end;

function OLDateTime.MinuteOfTheMonth: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.MinuteOfTheMonth(Self);
end;

function OLDateTime.MinuteOfTheWeek: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.MinuteOfTheWeek(Self);
end;

function OLDateTime.MinuteOfTheYear: OLInt64;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.MinuteOfTheYear(Self);
end;

function OLDateTime.MinutesBetween(const Date: OLDateTime): OLInt64;
begin
  if not Self.ValuePresent or not Date.ValuePresent then
    Exit(Null);
  Result := DateUtils.MinutesBetween(Self, Date);
end;

function OLDateTime.MinuteSpan(const Date: OLDateTime): OLDouble;
begin
  if not Self.ValuePresent or not Date.ValuePresent then
    Exit(Null);
  Result := DateUtils.MinuteSpan(Self, Date);
end;

function OLDateTime.MonthOf: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.MonthOf(Self);
end;

function OLDateTime.MonthsBetween(const Date: OLDateTime): OLInteger;
var
  Y1, Y2, M1, M2, D1, D2: Integer;
  FullMonth: OLBoolean;
begin
//Result := Self.Value.MonthsBetween(Date); //Useless - returns "approximate" number of months based on avg days in month (30.4375 days)

  if IsNull or Date.IsNull then
    Exit(Null);

  if Date > Self then
  begin
    Y2 := Date.Year;
    M2 := Date.Month;
    D2 := Date.Day;

    Y1 := Self.Year;
    M1 := Self.Month;
    D1 := Self.Day;
  end
  else
  begin
    Y1 := Date.Year;
    M1 := Date.Month;
    D1 := Date.Day;

    Y2 := Self.Year;
    M2 := Self.Month;
    D2 := Self.Day;
  end;

  FullMonth := (D2 >= D1) or (D2 = DaysInAMonth(Y2, M2));

  //Decrease when comparing for example '2020-01-10' and '2020-02-09' - not a full month so result is 0
  Result := 12 * (Y2 - Y1) + (M2 - M1) + FullMonth.IfThen(0, -1);
end;

function OLDateTime.MonthSpan(const Date: OLDateTime): OLDouble;
begin
  if not Self.ValuePresent or not Date.ValuePresent then
    Exit(Null);
  Result := DateUtils.MonthSpan(Self, Date);
end;

class operator OLDateTime.NotEqual(const a, b: OLDateTime): Boolean;
begin
  Result := ((a.FValue <> b.FValue) and a.ValuePresent and b.ValuePresent) or (a.ValuePresent <> b.ValuePresent);
end;

class function OLDateTime.Now: OLDateTime;
begin
  Result := SysUtils.Now();
end;

function OLDateTime.RecodedDay(const ADay: Word): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.RecodeDay(Self, ADay);
end;

function OLDateTime.RecodedHour(const AHour: Word): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.RecodeHour(Self, AHour);
end;

function OLDateTime.RecodedMilliSecond(const AMilliSecond: Word): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.RecodeMilliSecond(Self, AMilliSecond);
end;

function OLDateTime.RecodedMinute(const AMinute: Word): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.RecodeMinute(Self, AMinute);
end;

function OLDateTime.RecodedMonth(const AMonth: Word): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.RecodeMonth(Self, AMonth);
end;

function OLDateTime.RecodedSecond(const ASecond: Word): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.RecodeSecond(Self, ASecond);
end;

function OLDateTime.RecodedYear(const AYear: Word): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.RecodeYear(Self, AYear);
end;

function OLDateTime.SameTime(const DateTimeToCompare: OLDateTime): OLBoolean;
begin
  if not Self.ValuePresent or not DateTimeToCompare.ValuePresent then
    Exit(Null);
  Result := DateUtils.SameTime(Self, DateTimeToCompare);
end;

function OLDateTime.SecondOf: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.SecondOf(Self);
end;

function OLDateTime.SecondOfTheDay: OLInt64;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.SecondOfTheDay(Self);
end;

function OLDateTime.SecondOfTheHour: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.SecondOfTheHour(Self);
end;

function OLDateTime.SecondOfTheMonth: OLInt64;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.SecondOfTheMonth(Self);
end;

function OLDateTime.SecondOfTheWeek: OLInt64;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.SecondOfTheWeek(Self);
end;

function OLDateTime.SecondOfTheYear: OLInt64;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.SecondOfTheYear(Self);
end;

function OLDateTime.SecondsBetween(const Date: OLDateTime): OLInt64;
begin
  if not Self.ValuePresent or not Date.ValuePresent then
    Exit(Null);
  Result := DateUtils.SecondsBetween(Self, Date);
end;

function OLDateTime.SecondSpan(const Date: OLDateTime): OLDouble;
begin
  if not Self.ValuePresent or not Date.ValuePresent then
    Exit(Null);
  Result := DateUtils.SecondSpan(Self, Date);
end;

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetDay(const Value: OLInteger);
begin
  Self := DateUtils.RecodeDay(Self, Value);
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetEndOfAMonth(const AYear, AMonth: Word);
begin
  Self := OLDateTime.EndOfAMonth(AYear, AMonth);
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;

procedure OLDateTime.SetEndOfAYear(const AYear: Word);
begin
  Self := OLDateTime.EndOfAYear(AYear);
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

procedure OLDateTime.SetHasValue(const Value: OLBoolean);
begin
  {$IF CompilerVersion >= 34.0}
  FHasValue := Value;
  {$ELSE}
  FHasValue := Value.IfThen(' ', '');
  {$IFEND}
end;

{$IF CompilerVersion >= 34.0}
class operator OLDateTime.Initialize(out Dest: OLDateTime);
begin
  Dest.FHasValue := False;
  Dest.FOnChange := nil;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
class operator OLDateTime.Assign(var Dest: OLDateTime; const [ref] Src: OLDateTime);
begin
  Dest.FValue := Src.FValue;
  Dest.FHasValue := Src.FHasValue;

  if Assigned(Dest.FOnChange) then
    Dest.FOnChange(nil);
end;
{$IFEND}

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetHour(const Value: OLInteger);
begin
  Self := DateUtils.RecodeHour(Self, Value);
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetMilliSecond(const Value: OLInteger);
begin
  Self := DateUtils.RecodeMilliSecond(Self, Value);
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetMinute(const Value: OLInteger);
begin
  Self := DateUtils.RecodeMinute(Self, Value);
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetMonth(const Value: OLInteger);
begin
  Self := DateUtils.RecodeMonth(Self, Value);
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetNow;
begin
  Self := SysUtils.Now();
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetFromSecondCount(const Count: integer; const StartingYear: Integer);
begin
  Self := OLDateTime.DateTimeFromSecondCount(Count, StartingYear);
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetSecond(const Value: OLInteger);
begin
  Self := DateUtils.RecodeSecond(Self, Value);
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetStartOfAMonth(const AYear, AMonth: Word);
begin
  Self := OLDateTime.StartOfAMonth(AYear, AMonth);
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetStartOfAYear(const AYear: Word);
begin
  Self := OLDateTime.StartOfAYear(AYear);
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetToday;
begin
  Self := OLDateTime.Today();
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetTomorrow;
begin
  Self := OLDateTime.Tomorrow();
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetYear(const Value: OLInteger);
begin
  Self := DateUtils.RecodeYear(Self, Value);
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

{$IFDEF OL_MUTABLE}
procedure OLDateTime.SetYesterday;
begin
  Self := OLDateTime.Yesterday();
  {$IF CompilerVersion >= 34.0}
  if Assigned(FOnChange) then
    FOnChange(nil);
  {$IFEND}
end;
{$ENDIF}

function OLDateTime.ShortDayName: string;
begin
  {$if CompilerVersion > 22} // Delphi XE or later
     Result := SysUtils.FormatSettings.ShortDayNames[DayOfWeek(Self.FValue)];
  {$else}
    Result := ShortDayNames[DayOfWeek(Self.FValue)];
  {$ifend}

end;

class function OLDateTime.StartOfAMonth(const AYear, AMonth: Word): OLDateTime;
begin
  Result := DateUtils.StartOfAMonth(AYear, AMonth);
end;

class function OLDateTime.StartOfAYear(const AYear: Word): OLDateTime;
begin
  Result := DateUtils.StartOfAYear(AYear);
end;

function OLDateTime.StartOfTheDay: OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.StartOfTheDay(Self);
end;

function OLDateTime.StartOfTheMonth: OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.StartOfTheMonth(Self);
end;

function OLDateTime.StartOfTheWeek: OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.StartOfTheWeek(Self);
end;

function OLDateTime.StartOfTheYear: OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.StartOfTheYear(Self);
end;

class operator OLDateTime.Subtract(const a: OLDateTime; const b: Extended):
    OLDateTime;
var
  OutPut: OLDateTime;
begin
  if a.ValuePresent then
    OutPut := a.FValue - b
  else
    OutPut := Null;

  Result := OutPut;
end;

function OLDateTime.TimeOf: OLDateTime;
var
  OutPut: OLDateTime;
begin
  if Self.ValuePresent then
    OutPut := DateUtils.TimeOf(Self.FValue)
  else
    OutPut := Null;

  Result := OutPut;
end;

class function OLDateTime.Today: OLDateTime;
begin
  Result := DateUtils.Today();
end;

class function OLDateTime.Tomorrow: OLDateTime;
begin
  Result := DateUtils.Tomorrow();
end;

function OLDateTime.ToString(const Format: string): string;
begin
  if not Self.ValuePresent then
    Result := ''
  else
  begin
    if Format = '' then
      raise EArgumentException.Create('Format string cannot be empty');
    try
      Result := FormatDateTime(Format, Self.FValue);
    except
      on E: EConvertError do
        raise EArgumentException.CreateFmt('Invalid format string: %s', [Format]);
    end;
  end;
end;

function OLDateTime.ToString: string;
var
  OutPut: string;
begin
  if Self.ValuePresent then
    OutPut := DateTimeToStr(Self.FValue)
  else
    OutPut := '';

  Result := OutPut;
end;

function OLDateTime.ToSQLString: string;
var
  OutPut: string;
begin
  if HasValue then
    OutPut := QuotedStr(ToString())
  else
    OutPut := 'NULL';

  Result := OutPut;
end;

function OLDateTime.WeekOf: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.WeekOf(Self);
end;


function OLDateTime.WeeksBetween(const Date: OLDateTime): OLInteger;
begin
  if IsNull or Date.IsNull then
    Exit(Null);
  Result := DateUtils.WeeksBetween(Self, Date);
end;

function OLDateTime.WeeksInYear: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.WeeksInYear(Self);
end;

function OLDateTime.WeekSpan(const Date: OLDateTime): OLDouble;
begin
  if not Self.ValuePresent or not Date.ValuePresent then
    Exit(Null);
  Result := DateUtils.WeekSpan(Self, Date);
end;

function OLDateTime.YearOf: OLInteger;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.YearOf(Self);
end;

function OLDateTime.YearsBetween(const Date: OLDateTime): OLInteger;
var
  Y1, Y2, M1, M2, D1, D2: Integer;
  FullYear: OLBoolean;
begin
  // Result := DateUtils.YearsBetween(Self, Date); // Replaced to maintain consistency with MonthsBetween logic
  if IsNull or Date.IsNull then
    Exit(Null);
  if Date > Self then
  begin
    Y2 := Date.Year;
    M2 := Date.Month;
    D2 := Date.Day;

    Y1 := Self.Year;
    M1 := Self.Month;
    D1 := Self.Day;
  end
  else
  begin
    Y1 := Date.Year;
    M1 := Date.Month;
    D1 := Date.Day;

    Y2 := Self.Year;
    M2 := Self.Month;
    D2 := Self.Day;
  end;

  // Check if a full year cycle has passed based on Month and Day comparison
  if M2 > M1 then
    FullYear := True
  else if M2 < M1 then
    FullYear := False
  else // M2 = M1
    // Same month: check days. The (D2 = DaysInAMonth) check handles cases like Feb 29 -> Feb 28
    FullYear := (D2 >= D1) or (D2 = DaysInAMonth(Y2, M2));

  // Calculate year difference and decrease by 1 if the current date hasn't reached the start date's Month/Day yet
  Result := (Y2 - Y1) + FullYear.IfThen(0, -1);
end;

function OLDateTime.YearSpan(const Date: OLDateTime): OLDouble;
begin
  if not Self.ValuePresent or not Date.ValuePresent then
    Exit(Null);
  Result := DateUtils.YearSpan(Self, Date);
end;

class function OLDateTime.Yesterday: OLDateTime;
begin
  Result := DateUtils.Yesterday;
end;

class operator OLDateTime.Implicit(const a: Extended): OLDateTime;
var
  OutPut: OLDateTime;
  dt: TDateTime;
begin
  dt := a;

  OutPut.FValue := dt;
  OutPut.ValuePresent := True;
  Result := OutPut;
end;

function OLDateTime.IncDay(const ANumberOfDays: Integer): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.IncDay(Self, ANumberOfDays);
end;

function OLDateTime.IncHour(const ANumberOfHours: Int64): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.IncHour(Self, ANumberOfHours);
end;

function OLDateTime.IncMilliSecond(
  const ANumberOfMilliSeconds: Int64): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.IncMilliSecond(Self, ANumberOfMilliSeconds);
end;

function OLDateTime.IncMinute(const ANumberOfMinutes: Int64): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.IncMinute(Self, ANumberOfMinutes);
end;

function OLDateTime.IncMonth(const ANumberOfMonths: Integer): OLDateTime;
var
  Day: OLInteger;
  Month: Integer;
  Year: Integer;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Year := Self.YearOf();
  Month := Self.MonthOf();
  Inc(Month, ANumberOfMonths);

  while Month < 1 do
  begin
    Dec(Year);
    Inc(Month, 12);
  end;

  while Month > 12 do
  begin
    Inc(Year);
    Dec(Month, 12);
  end;

  if DaysInAMonth(Year, Month) < Self.Day then
    Day := DaysInAMonth(Year, Month)
  else
    Day := Self.Day;

  Result := Self.RecodedDay(Day).RecodedMonth(Month).RecodedYear(Year);
end;

function OLDateTime.IncSecond(const ANumberOfSeconds: Int64): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.IncSecond(Self, ANumberOfSeconds);
end;

function OLDateTime.IncWeek(const ANumberOfWeeks: Integer): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.IncWeek(Self, ANumberOfWeeks);
end;

function OLDateTime.IncYear(const ANumberOfYears: Integer): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.IncYear(Self, ANumberOfYears);
end;

function OLDateTime.WithYear(const AYear: OLInteger): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.RecodeYear(Self, AYear);
end;

function OLDateTime.WithMonth(const AMonth: OLInteger): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.RecodeMonth(Self, AMonth);
end;

function OLDateTime.WithDay(const ADay: OLInteger): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.RecodeDay(Self, ADay);
end;

function OLDateTime.WithHour(const AHour: OLInteger): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.RecodeHour(Self, AHour);
end;

function OLDateTime.WithMinute(const AMinute: OLInteger): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.RecodeMinute(Self, AMinute);
end;

function OLDateTime.WithSecond(const ASecond: OLInteger): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.RecodeSecond(Self, ASecond);
end;

function OLDateTime.WithMilliSecond(const AMilliSecond: OLInteger): OLDateTime;
begin
  if not Self.ValuePresent then
    Exit(Null);
  Result := DateUtils.RecodeMilliSecond(Self, AMilliSecond);
end;

class operator OLDateTime.Implicit(const a: string): OLDateTime;
begin
  Result := SysUtils.StrToDateTime(a);
end;

end.
