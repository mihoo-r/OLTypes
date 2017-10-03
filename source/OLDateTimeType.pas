unit OLDateTimeType;

interface

uses
  Variants, SysUtils, DateUtils, OlBooleanType, OLIntegerType, OLDoubleType;

type
  OLDateTime = record
  private
    Value: TDateTime;
    NullFlag: string;

    function GetHasValue(): OLBoolean;
    procedure SetHasValue(Value: OLBoolean);
    function GetDay: OLInteger;
    function GetHour: OLInteger;
    function GetMilliSecond: OLInteger;
    function GetMinute: OLInteger;
    function GetMonth: OLInteger;
    function GetSecond: OLInteger;
    function GetYear: OLInteger;
    procedure SetHour(const Value: OLInteger);
    procedure SetMilliSecond(const Value: OLInteger);
    procedure SetMinute(const Value: OLInteger);
    procedure SetMonth(const Value: OLInteger);
    procedure SetSecond(const Value: OLInteger);
    procedure SetYear(const Value: OLInteger);
    procedure SetDay(const Value: OLInteger);
    property HasValue: OLBoolean read GetHasValue write SetHasValue;

    function YearOf(): OLInteger;
    function MonthOf(): OLInteger;
    function WeekOf(): OLInteger; { ISO 8601 }
    function DayOf(): OLInteger;
    function HourOf(): OLInteger;
    function MinuteOf(): OLInteger;
    function SecondOf(): OLInteger;
    function MilliSecondOf(): OLInteger;
  public
    property Year: OLInteger read GetYear write SetYear;
    property Month: OLInteger read GetMonth write SetMonth;
    property Day: OLInteger read GetDay write SetDay;
    property Hour: OLInteger read GetHour write SetHour;
    property Minute: OLInteger read GetMinute write SetMinute;
    property Second: OLInteger read GetSecond write SetSecond;
    property MilliSecond: OLInteger read GetMilliSecond write SetMilliSecond;

    function IsNull(): OLBoolean;
    function ToString(): string;
    function IfNull(b: OLDateTime): OLDateTime;

    class operator Implicit(a: TDateTime): OLDateTime;
    class operator Implicit(a: OLDateTime): TDateTime;
    class operator Implicit(a: Variant): OLDateTime;
    class operator Implicit(a: OLDateTime): Variant;
    class operator Implicit(a: Extended): OLDateTime;
    class operator Implicit(a: string): OLDateTime;

    class operator Equal(a, b: OLDateTime): OLBoolean;
    class operator NotEqual(a, b: OLDateTime): OLBoolean;
    class operator GreaterThan(a, b: OLDateTime): OLBoolean;
    class operator GreaterThanOrEqual(a, b: OLDateTime): OLBoolean;
    class operator LessThan(a, b: OLDateTime): OLBoolean;
    class operator LessThanOrEqual(a, b: OLDateTime): OLBoolean;

    class operator Add(a: OLDateTime; b: Extended): OLDateTime;
    class operator Subtract(a: OLDateTime; b: Extended): OLDateTime;

    function DateOf(): OLDateTime;
    function TimeOf(): OLDateTime;

    function IsInLeapYear(): OLBoolean;

    function IsPM(): OLBoolean;
    function IsAM(): OLBoolean;

    function WeeksInYear(): OLInteger; { ISO 8601 }

    function DaysInYear(): OLInteger;
    function DaysInMonth(): OLInteger;
    class function Today: OLDateTime; static;
    class function Yesterday: OLDateTime; static;
    class function Tomorrow: OLDateTime; static;

    procedure SetNow();
    procedure SetToday();
    procedure SetTomorrow();
    procedure SetYesterday();

    function IsToday(): OLBoolean;
    function SameDay(const DateTimeToCompare: OLDateTime): OLBoolean;

    function StartOfTheYear(): OLDateTime;
    function EndOfTheYear(): OLDateTime;
    class function StartOfAYear(const AYear: Word): OLDateTime; static;
    class function EndOfAYear(const AYear: Word): OLDateTime; static;

    procedure SetStartOfAYear(const AYear: Word);
    procedure SetEndOfAYear(const AYear: Word);

    function StartOfTheMonth(): OLDateTime;
    function EndOfTheMonth(): OLDateTime;
    class function StartOfAMonth(const AYear, AMonth: Word): OLDateTime; static;
    class function EndOfAMonth(const AYear, AMonth: Word): OLDateTime; static;
    procedure SetStartOfAMonth(const AYear, AMonth: Word);
    procedure SetEndOfAMonth(const AYear, AMonth: Word);

    function StartOfTheWeek(): OLDateTime; { ISO 8601 }
    function EndOfTheWeek(): OLDateTime; { ISO 8601 }

    function StartOfTheDay(): OLDateTime;
    function EndOfTheDay(): OLDateTime;

    function DayOfTheYear(): OLInteger;
    function HourOfTheYear(): OLInteger;
    function MinuteOfTheYear(): LongWord;
    function SecondOfTheYear(): LongWord;
    function MilliSecondOfTheYear(): Int64;

    function HourOfTheMonth(): OLInteger;
    function MinuteOfTheMonth(): OLInteger;
    function SecondOfTheMonth(): LongWord;
    function MilliSecondOfTheMonth(): LongWord;

    function DayOfTheWeek(): OLInteger; { ISO 8601 }
    function HourOfTheWeek(): OLInteger; { ISO 8601 }
    function MinuteOfTheWeek(): OLInteger; { ISO 8601 }
    function SecondOfTheWeek(): LongWord; { ISO 8601 }
    function MilliSecondOfTheWeek(): LongWord; { ISO 8601 }

    function MinuteOfTheDay(): OLInteger;
    function SecondOfTheDay(): LongWord;
    function MilliSecondOfTheDay(): LongWord;

    function SecondOfTheHour(): OLInteger;
    function MilliSecondOfTheHour(): LongWord;

    function MilliSecondOfTheMinute(): LongWord;

    class function SecondCount(StartingYear: Integer = 2017): OLInteger; static;
    class function DateTimeFromSecondCount(Count: integer; StartingYear: Integer = 2017): OLDateTime; static;
    procedure SetFromSecondCount(Count: integer; StartingYear: Integer = 2017);

    function YearsBetween(const AThen: OLDateTime): OLInteger;
    function MonthsBetween(const AThen: OLDateTime): OLInteger;
    function WeeksBetween(const AThen: OLDateTime): OLInteger;
    function DaysBetween(const AThen: OLDateTime): OLInteger;
    function HoursBetween(const AThen: OLDateTime): Int64;
    function MinutesBetween(const AThen: OLDateTime): Int64;
    function SecondsBetween(const AThen: OLDateTime): Int64;
    function MilliSecondsBetween(const AThen: OLDateTime): Int64;

    function InRange(AStartDateTime, AEndDateTime: OLDateTime; aInclusive: Boolean = True): OLBoolean;
    function InDateRange(AStartDateTime, AEndDateTime: TDate; aInclusive: Boolean = True): OLBoolean;

    function YearSpan(const AThen: OLDateTime): OLDouble;
    function MonthSpan(const AThen: OLDateTime): OLDouble;
    function WeekSpan(const AThen: OLDateTime): OLDouble;
    function DaySpan(const AThen: OLDateTime): OLDouble;
    function HourSpan(const AThen: OLDateTime): OLDouble;
    function MinuteSpan(const AThen: OLDateTime): OLDouble;
    function SecondSpan(const AThen: OLDateTime): OLDouble;
    function MilliSecondSpan(const AThen: OLDateTime): OLDouble;


    function IncYear(const ANumberOfYears: Integer = 1): OLDateTime;
    function IncMonth(const ANumberOfMonths: Integer = 1): OLDateTime;
    function IncWeek(const ANumberOfWeeks: Integer = 1): OLDateTime;
    function IncDay(const ANumberOfDays: Integer = 1): OLDateTime;
    function IncHour(const ANumberOfHours: Int64 = 1): OLDateTime;
    function IncMinute(const ANumberOfMinutes: Int64 = 1): OLDateTime;
    function IncSecond(const ANumberOfSeconds: Int64 = 1): OLDateTime;
    function IncMilliSecond(const ANumberOfMilliSeconds: Int64 = 1): OLDateTime;

    procedure DecodeDateTime(out AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word);
    procedure EncodeDateTime(const AYear, AMonth, ADay: Word; AHour: Word = 0; AMinute: Word = 0;
      ASecond: Word = 0; AMilliSecond: Word = 0);

    function RecodedYear(const AYear: Word): OLDateTime;
    function RecodedMonth(const AMonth: Word): OLDateTime;
    function RecodedDay(const ADay: Word): OLDateTime;
    function RecodedHour(const AHour: Word): OLDateTime;
    function RecodedMinute(const AMinute: Word): OLDateTime;
    function RecodedSecond(const ASecond: Word): OLDateTime;
    function RecodedMilliSecond(const AMilliSecond: Word): OLDateTime;

    function SameTime(const DateTimeToCompare: OLDateTime): OLBoolean;

    function LongDayName(): string;
    function ShordDayName(): string;
  end;

implementation

const
  NonEmptyStr = ' ';

  { OLDateTime }

class operator OLDateTime.Add(a: OLDateTime; b: Extended): OLDateTime;
var
  OutPut: OLDateTime;
begin
  if a.HasValue then
    OutPut := a.Value + b
  else
    OutPut := Null;

  Result := OutPut;
end;

function OLDateTime.DateOf: OLDateTime;
var
  OutPut: OLDateTime;
begin
  if Self.HasValue then
    OutPut := DateUtils.DateOf(Self.Value)
  else
    OutPut := Null;

  Result := OutPut;
end;

class function OLDateTime.DateTimeFromSecondCount(Count,
  StartingYear: Integer): OLDateTime;
begin
  Result := OLDateTime.StartOfAYear(StartingYear).IncSecond(Count);
end;

function OLDateTime.InDateRange(AStartDateTime, AEndDateTime: TDate; aInclusive: Boolean): OLBoolean;
var
  OutPut: OLBoolean;
begin
  if aInclusive then
    OutPut := (Self.DateOf() >= AStartDateTime) and (Self.DateOf() <= AEndDateTime)
  else
    OutPut := (Self.DateOf() > AStartDateTime) and (Self.DateOf() < AEndDateTime);

  Result := OutPut;
end;

function OLDateTime.InRange(AStartDateTime, AEndDateTime: OLDateTime;
  aInclusive: Boolean): OLBoolean;
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
  Result := DateUtils.DayOf(Self);
end;

function OLDateTime.DayOfTheWeek: OLInteger;
begin
  Result := DateUtils.DayOfTheWeek(Self);
end;

function OLDateTime.DayOfTheYear: OLInteger;
begin
  Result := DateUtils.DayOfTheYear(Self);
end;

function OLDateTime.DaysBetween(const AThen: OLDateTime): OLInteger;
begin
  Result := DateUtils.DaysBetween(Self, AThen);
end;

function OLDateTime.DaysInMonth(): OLInteger;
begin
  Result := DateUtils.DaysInMonth(Self);
end;

function OLDateTime.DaysInYear: OLInteger;
begin
  Result := DateUtils.DaysInYear(Self);
end;

function OLDateTime.DaySpan(const AThen: OLDateTime): OLDouble;
begin
  Result := DateUtils.DaySpan(Self, AThen);
end;

procedure OLDateTime.DecodeDateTime(out AYear, AMonth, ADay, AHour, AMinute,
  ASecond, AMilliSecond: Word);
begin
  DateUtils.DecodeDateTime(Self, AYear, AMonth, ADay, AHour, AMinute, ASecond,  AMilliSecond);
end;

procedure OLDateTime.EncodeDateTime(const AYear, AMonth, ADay: Word; AHour, AMinute, ASecond, AMilliSecond: Word);
begin
  self := DateUtils.EncodeDateTime(AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
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
  Result := DateUtils.EndOfTheDay(Self);
end;

function OLDateTime.EndOfTheMonth: OLDateTime;
begin
  Result := DateUtils.EndOfTheMonth(Self);
end;

function OLDateTime.EndOfTheWeek: OLDateTime;
begin
  Result := DateUtils.EndOfTheWeek(Self);
end;

function OLDateTime.EndOfTheYear: OLDateTime;
begin
  Result := DateUtils.EndOfTheYear(Self);
end;

class operator OLDateTime.Equal(a, b: OLDateTime): OLBoolean;
begin
  Result := (a.HasValue and b.HasValue and (System.Abs(a.Value - b.Value) < 1.1574e-8)) or (a.IsNull() and b.IsNull());  //Less than a millisecond difference
end;

function OLDateTime.GetDay: OLInteger;
begin
  Result := Self.DayOf();
end;

function OLDateTime.GetHasValue: OLBoolean;
begin
  Result := (NullFlag <> EmptyStr);
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

class function OLDateTime.SecondCount(StartingYear: Integer): OLInteger;
var
  d: OLDateTime;
begin
  d.SetNow();
  Result := d.SecondsBetween(OLDateTime.StartOfAYear(StartingYear));
end;

class operator OLDateTime.GreaterThan(a, b: OLDateTime): OLBoolean;
begin
  Result := (a.Value > b.Value) and a.HasValue and b.HasValue;
end;

class operator OLDateTime.GreaterThanOrEqual(a, b: OLDateTime): OLBoolean;
begin
  Result := ((a.Value >= b.Value) and (a.HasValue and b.HasValue)) or (a.IsNull() and b.IsNull());
end;

function OLDateTime.HourOf: OLInteger;
begin
  Result := DateUtils.HourOf(Self);
end;

function OLDateTime.HourOfTheMonth: OLInteger;
begin
  Result := DateUtils.HourOfTheMonth(Self);
end;

function OLDateTime.HourOfTheWeek: OLInteger;
begin
  Result := DateUtils.HourOfTheWeek(Self);
end;

function OLDateTime.HourOfTheYear: OLInteger;
begin
  Result := DateUtils.HourOfTheYear(Self);
end;

function OLDateTime.HoursBetween(const AThen: OLDateTime): Int64;
begin
  Result := DateUtils.HoursBetween(Self, AThen);
end;

function OLDateTime.HourSpan(const AThen: OLDateTime): OLDouble;
begin
  Result := DateUtils.HourSpan(Self, AThen);
end;

function OLDateTime.IfNull(b: OLDateTime): OLDateTime;
var
  OutPut: OLDateTime;
begin
  if HasValue then
    OutPut := Self
  else
    OutPut := b;

  Result := OutPut;
end;

class operator OLDateTime.Implicit(a: OLDateTime): Variant;
var
  OutPut: Variant;
begin
  if a.HasValue then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLDateTime.Implicit(a: Variant): OLDateTime;
var
  OutPut: OLDateTime;
  b: TDateTime;
begin
  if VarIsNull(a) then
    OutPut.HasValue := false
  else
  begin
    if TryStrToDateTime(a, b) then
    begin
      OutPut.Value := b;
      OutPut.HasValue := True;
    end
    else
    begin
      raise Exception.Create('Value ''' + VarToStr(a) + ''' cannot be assigned to variable of OLDateTime type.');
    end;
  end;

  Result := OutPut;
end;

class operator OLDateTime.Implicit(a: OLDateTime): TDateTime;
begin
  if not a.HasValue then
    raise Exception.Create('Null cannot be used as TDateTime value.');
  Result := a.Value;
end;

class operator OLDateTime.Implicit(a: TDateTime): OLDateTime;
var
  OutPut: OLDateTime;
begin
  OutPut.Value := a;
  OutPut.HasValue := True;
  Result := OutPut;
end;

function OLDateTime.IsAM: OLBoolean;
begin
  Result := not DateUtils.IsPM(Self);
end;

function OLDateTime.IsInLeapYear: OLBoolean;
begin
  Result := DateUtils.IsInLeapYear(Self);
end;

function OLDateTime.IsNull: OLBoolean;
begin
  Result := not HasValue;
end;

function OLDateTime.IsPM: OLBoolean;
begin
  Result := DateUtils.IsPM(Self);
end;

function OLDateTime.SameDay(const DateTimeToCompare: OLDateTime): OLBoolean;
begin
  Result := (not Self.IsNull) and (not DateTimeToCompare.IsNull) and
    DateUtils.IsSameDay(Self, DateTimeToCompare);
end;

function OLDateTime.IsToday: OLBoolean;
begin
  Result := DateUtils.IsToday(Self);
end;

class operator OLDateTime.LessThan(a, b: OLDateTime): OLBoolean;
begin
  Result := (a.Value < b.Value) and a.HasValue and b.HasValue;
end;

class operator OLDateTime.LessThanOrEqual(a, b: OLDateTime): OLBoolean;
begin
  Result := ((a.Value <= b.Value) and (a.HasValue and b.HasValue)) or (a.IsNull() and b.IsNull());
end;

function OLDateTime.LongDayName: string;
begin
  Result := LongDayNames[DayOfWeek(Self.Value)];
end;

function OLDateTime.MilliSecondOf: OLInteger;
begin
  Result := DateUtils.MilliSecondOf(Self);
end;

function OLDateTime.MilliSecondOfTheDay: LongWord;
begin
  Result := DateUtils.MilliSecondOfTheDay(Self);
end;

function OLDateTime.MilliSecondOfTheHour: LongWord;
begin
  Result := DateUtils.MilliSecondOfTheHour(Self);
end;

function OLDateTime.MilliSecondOfTheMinute: LongWord;
begin
  Result := DateUtils.MilliSecondOfTheMinute(Self);
end;

function OLDateTime.MilliSecondOfTheMonth: LongWord;
begin
  Result := DateUtils.MilliSecondOfTheMonth(Self);
end;

function OLDateTime.MilliSecondOfTheWeek: LongWord;
begin
  Result := DateUtils.MilliSecondOfTheWeek(Self);
end;

function OLDateTime.MilliSecondOfTheYear: Int64;
begin
  Result := DateUtils.MilliSecondOfTheYear(Self);
end;

function OLDateTime.MilliSecondsBetween(const AThen: OLDateTime): Int64;
begin
  Result := DateUtils.MilliSecondsBetween(Self, AThen);
end;

function OLDateTime.MilliSecondSpan(const AThen: OLDateTime): OLDouble;
begin
  Result := DateUtils.MilliSecondSpan(Self, AThen);
end;

function OLDateTime.MinuteOf: OLInteger;
begin
  Result := DateUtils.MinuteOf(Self);
end;

function OLDateTime.MinuteOfTheDay: OLInteger;
begin
  Result := DateUtils.MinuteOfTheDay(Self);
end;

function OLDateTime.MinuteOfTheMonth: OLInteger;
begin
  Result := DateUtils.MinuteOfTheMonth(Self);
end;

function OLDateTime.MinuteOfTheWeek: OLInteger;
begin
  Result := DateUtils.MinuteOfTheWeek(Self);
end;

function OLDateTime.MinuteOfTheYear: LongWord;
begin
  Result := DateUtils.MinuteOfTheYear(Self);
end;

function OLDateTime.MinutesBetween(const AThen: OLDateTime): Int64;
begin
  Result := DateUtils.MinutesBetween(Self, AThen);
end;

function OLDateTime.MinuteSpan(const AThen: OLDateTime): OLDouble;
begin
  Result := DateUtils.MinuteSpan(Self, AThen);
end;

function OLDateTime.MonthOf: OLInteger;
begin
  Result := DateUtils.MonthOf(Self);
end;

function OLDateTime.MonthsBetween(const AThen: OLDateTime): OLInteger;
begin
  Result := DateUtils.MonthsBetween(Self, AThen);
end;

function OLDateTime.MonthSpan(const AThen: OLDateTime): OLDouble;
begin
  Result := DateUtils.MonthSpan(Self, AThen);
end;

class operator OLDateTime.NotEqual(a, b: OLDateTime): OLBoolean;
begin
  Result := ((a.Value <> b.Value) and a.HasValue and b.HasValue) or (a.HasValue <> b.HasValue);
end;

function OLDateTime.RecodedDay(const ADay: Word): OLDateTime;
begin
  Result := DateUtils.RecodeDay(Self, ADay);
end;

function OLDateTime.RecodedHour(const AHour: Word): OLDateTime;
begin
  Result := DateUtils.RecodeHour(Self, AHour);
end;

function OLDateTime.RecodedMilliSecond(const AMilliSecond: Word): OLDateTime;
begin
  Result := DateUtils.RecodeMilliSecond(Self, AMilliSecond);
end;

function OLDateTime.RecodedMinute(const AMinute: Word): OLDateTime;
begin
  Result := DateUtils.RecodeMinute(Self, AMinute);
end;

function OLDateTime.RecodedMonth(const AMonth: Word): OLDateTime;
begin
  Result := DateUtils.RecodeMonth(Self, AMonth);
end;

function OLDateTime.RecodedSecond(const ASecond: Word): OLDateTime;
begin
  Result := DateUtils.RecodeSecond(Self, ASecond);
end;

function OLDateTime.RecodedYear(const AYear: Word): OLDateTime;
begin
  Result := DateUtils.RecodeYear(Self, AYear);
end;

function OLDateTime.SameTime(const DateTimeToCompare: OLDateTime): OLBoolean;
begin
  Result := DateUtils.SameTime(Self, DateTimeToCompare);
end;

function OLDateTime.SecondOf: OLInteger;
begin
  Result := DateUtils.SecondOf(Self);
end;

function OLDateTime.SecondOfTheDay: LongWord;
begin
  Result := DateUtils.SecondOfTheDay(Self);
end;

function OLDateTime.SecondOfTheHour: OLInteger;
begin
  Result := DateUtils.SecondOfTheHour(Self);
end;

function OLDateTime.SecondOfTheMonth: LongWord;
begin
  Result := DateUtils.SecondOfTheMonth(Self);
end;

function OLDateTime.SecondOfTheWeek: LongWord;
begin
  Result := DateUtils.SecondOfTheWeek(Self);
end;

function OLDateTime.SecondOfTheYear: LongWord;
begin
  Result := DateUtils.SecondOfTheYear(Self);
end;

function OLDateTime.SecondsBetween(const AThen: OLDateTime): Int64;
begin
  Result := DateUtils.SecondsBetween(Self, AThen);
end;

function OLDateTime.SecondSpan(const AThen: OLDateTime): OLDouble;
begin
  Result := DateUtils.SecondSpan(Self, AThen);
end;

procedure OLDateTime.SetDay(const Value: OLInteger);
begin
  Self := DateUtils.RecodeDay(Self, Value);
end;

procedure OLDateTime.SetEndOfAMonth(const AYear, AMonth: Word);
begin
  Self := OLDateTime.EndOfAMonth(AYear, AMonth);
end;

procedure OLDateTime.SetEndOfAYear(const AYear: Word);
begin
  Self := OLDateTime.EndOfAYear(AYear);
end;

procedure OLDateTime.SetHasValue(Value: OLBoolean);
begin
  if Value then
    NullFlag := NonEmptyStr
  else
    NullFlag := EmptyStr;
end;

procedure OLDateTime.SetHour(const Value: OLInteger);
begin
  Self := DateUtils.RecodeHour(Self, Value);
end;

procedure OLDateTime.SetMilliSecond(const Value: OLInteger);
begin
  Self := DateUtils.RecodeMilliSecond(Self, Value);
end;

procedure OLDateTime.SetMinute(const Value: OLInteger);
begin
  Self := DateUtils.RecodeMinute(Self, Value);
end;

procedure OLDateTime.SetMonth(const Value: OLInteger);
begin
  Self := DateUtils.RecodeMonth(Self, Value);
end;

procedure OLDateTime.SetNow;
begin
  Self := SysUtils.Now();
end;

procedure OLDateTime.SetFromSecondCount(Count: integer; StartingYear: Integer);
begin
  Self := OLDateTime.DateTimeFromSecondCount(Count, StartingYear)
end;

procedure OLDateTime.SetSecond(const Value: OLInteger);
begin
  Self := DateUtils.RecodeSecond(Self, Value);
end;

procedure OLDateTime.SetStartOfAMonth(const AYear, AMonth: Word);
begin
  Self := OLDateTime.StartOfAMonth(AYear, AMonth);
end;

procedure OLDateTime.SetStartOfAYear(const AYear: Word);
begin
  Self := OLDateTime.StartOfAYear(AYear);
end;

procedure OLDateTime.SetToday;
begin
  Self := OLDateTime.Today();
end;

procedure OLDateTime.SetTomorrow;
begin
  Self := OLDateTime.Tomorrow();
end;

procedure OLDateTime.SetYear(const Value: OLInteger);
begin
  Self := DateUtils.RecodeYear(Self, Value);
end;

procedure OLDateTime.SetYesterday;
begin
  Self := OLDateTime.Yesterday();
end;

function OLDateTime.ShordDayName: string;
begin
  Result := ShortDayNames[DayOfWeek(Self.Value)];
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
  Result := DateUtils.StartOfTheDay(Self);
end;

function OLDateTime.StartOfTheMonth: OLDateTime;
begin
  Result := DateUtils.StartOfTheMonth(Self);
end;

function OLDateTime.StartOfTheWeek: OLDateTime;
begin
  Result := DateUtils.StartOfTheWeek(Self);
end;

function OLDateTime.StartOfTheYear: OLDateTime;
begin
  Result := DateUtils.StartOfTheYear(Self);
end;

class operator OLDateTime.Subtract(a: OLDateTime; b: Extended): OLDateTime;
var
  OutPut: OLDateTime;
begin
  if a.HasValue then
    OutPut := a.Value - b
  else
    OutPut := Null;

  Result := OutPut;
end;

function OLDateTime.TimeOf: OLDateTime;
var
  OutPut: OLDateTime;
begin
  if Self.HasValue then
    OutPut := DateUtils.TimeOf(Self.Value)
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

function OLDateTime.ToString: string;
var
  OutPut: string;
begin
  if Self.HasValue then
    OutPut := DateTimeToStr(Self.Value)
  else
    OutPut := '';

  Result := OutPut;
end;


function OLDateTime.WeekOf: OLInteger;
begin
  Result := DateUtils.WeekOf(Self);
end;


function OLDateTime.WeeksBetween(const AThen: OLDateTime): OLInteger;
begin
  Result := DateUtils.WeeksBetween(Self, AThen);
end;

function OLDateTime.WeeksInYear: OLInteger;
begin
  Result := DateUtils.WeeksInYear(Self);
end;

function OLDateTime.WeekSpan(const AThen: OLDateTime): OLDouble;
begin
  Result := DateUtils.WeekSpan(Self, AThen);
end;

function OLDateTime.YearOf: OLInteger;
begin
  Result := DateUtils.YearOf(Self);
end;

function OLDateTime.YearsBetween(const AThen: OLDateTime): OLInteger;
begin
  Result := DateUtils.YearsBetween(Self, AThen);
end;

function OLDateTime.YearSpan(const AThen: OLDateTime): OLDouble;
begin
  Result := DateUtils.YearSpan(Self, AThen);
end;

class function OLDateTime.Yesterday: OLDateTime;
begin
  Result := DateUtils.Yesterday;
end;

class operator OLDateTime.Implicit(a: Extended): OLDateTime;
var
  OutPut: OLDateTime;
  dt: TDateTime;
begin
  dt := a;

  OutPut.Value := dt;
  OutPut.HasValue := True;
  Result := OutPut;
end;

function OLDateTime.IncDay(const ANumberOfDays: Integer): OLDateTime;
begin
  Result := DateUtils.IncDay(Self, ANumberOfDays);
end;

function OLDateTime.IncHour(const ANumberOfHours: Int64): OLDateTime;
begin
  Result := DateUtils.IncHour(Self, ANumberOfHours);
end;

function OLDateTime.IncMilliSecond(
  const ANumberOfMilliSeconds: Int64): OLDateTime;
begin
  Result := DateUtils.IncMilliSecond(Self, ANumberOfMilliSeconds);
end;

function OLDateTime.IncMinute(const ANumberOfMinutes: Int64): OLDateTime;
begin
  Result := DateUtils.IncMinute(Self, ANumberOfMinutes);
end;

function OLDateTime.IncMonth(const ANumberOfMonths: Integer): OLDateTime;
var
  Month: Word;
  Year: Word;
begin
  Year := Self.YearOf();
  Month := Self.MonthOf();
  Inc(Month, ANumberOfMonths);

  while Month > 12 do
begin
    Inc(Year);
    Dec(Month, 12);
  end;

  Result := Self.RecodedYear(Year).RecodedMonth(Month);
end;

function OLDateTime.IncSecond(const ANumberOfSeconds: Int64): OLDateTime;
begin
  Result := DateUtils.IncSecond(Self, ANumberOfSeconds);
end;

function OLDateTime.IncWeek(const ANumberOfWeeks: Integer): OLDateTime;
begin
  Result := DateUtils.IncWeek(Self, ANumberOfWeeks);
end;

function OLDateTime.IncYear(const ANumberOfYears: Integer): OLDateTime;
begin
  Result := DateUtils.IncYear(Self, ANumberOfYears);
end;

class operator OLDateTime.Implicit(a: string): OLDateTime;
begin
  Result := SysUtils.StrToDateTime(a);
end;

end.
