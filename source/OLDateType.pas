unit OLDateType;

interface

uses
  Variants, SysUtils, DateUtils, OlBooleanType, OLIntegerType, OLDoubleType, OLDateTimeType;

type
  OLDate = record
  private
    Value: OLDateTime;
    function GetDateTimeParts: TDateTimeParts;
    procedure SetDateTimeParts(const Value: TDateTimeParts);

  public
    function IsNull(): OLBoolean;
    function ToString(): string;
    function IfNull(b: OLDate): OLDate;

    class operator Implicit(a: TDate): OLDate;
    class operator Implicit(a: OLDate): TDate;
    class operator Implicit(a: OLDateTime): OLDate;
    class operator Implicit(a: OLDate): OLDateTime;
    class operator Implicit(a: TDateTime): OLDate;
    class operator Implicit(a: OLDate): TDateTime;
    class operator Implicit(a: Variant): OLDate;
    class operator Implicit(a: OLDate): Variant;
    class operator Implicit(a: Extended): OLDate;
    class operator Implicit(a: string): OLDate;

    class operator Equal(a, b: OLDate): OLBoolean;
    class operator NotEqual(a, b: OLDate): OLBoolean;
    class operator GreaterThan(a, b: OLDate): OLBoolean;
    class operator GreaterThanOrEqual(a, b: OLDate): OLBoolean;
    class operator LessThan(a, b: OLDate): OLBoolean;
    class operator LessThanOrEqual(a, b: OLDate): OLBoolean;

    class operator Add(a: OLDate; b: integer): OLDate;
    class operator Subtract(a: OLDate; b: integer): OLDate;

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

    function YearOf(): OLInteger;
    function MonthOf(): OLInteger;
    function WeekOf(): OLInteger; { ISO 8601 }
    function DayOf(): OLInteger;

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

    function InRange(AStartDateTime, AEndDateTime: OLDate; aInclusive: Boolean = True): OLBoolean;

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

    property DateTimeParts: TDateTimeParts read GetDateTimeParts write SetDateTimeParts;
  end;

implementation

uses Math;

{ OLDate }

class operator OLDate.Add(a: OLDate; b: integer): OLDate;
begin
  Result := a.Value + b;
end;

function OLDate.DayOf: OLInteger;
begin
  Result := Self.Value.DayOf();
end;

function OLDate.DayOfTheWeek: OLInteger;
begin
  Result := Self.Value.DayOfTheWeek();
end;

function OLDate.DayOfTheYear: OLInteger;
begin
  Result := Self.Value.DayOfTheYear();
end;

function OLDate.DaysBetween(const AThen: OLDate): OLInteger;
begin
  Result := Self.Value.DaysBetween(AThen);
end;

function OLDate.DaysInMonth: OLInteger;
begin
  Result := Self.Value.DaysInMonth();
end;

function OLDate.DaysInYear: OLInteger;
begin
  Result := Self.Value.DaysInYear();
end;

procedure OLDate.DecodeDate(out AYear, AMonth, ADay: Word);
var
  AHour, AMinute, ASecond, AMilliSecond: Word;
begin
  Self.Value.DecodeDateTime(AYear, AMonth, ADay,
    AHour, AMinute, ASecond, AMilliSecond);
end;

procedure OLDate.EncodeDate(const AYear, AMonth, ADay: Word);
begin
  Self.Value.EncodeDateTime(AYear, AMonth, ADay);
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
  Result := Self.Value.EndOfTheMonth();
end;

function OLDate.EndOfTheWeek: OLDate;
begin
  Result := Self.Value.EndOfTheWeek();
end;

function OLDate.EndOfTheYear: OLDate;
begin
  Result := Self.Value.EndOfTheYear();
end;

class operator OLDate.Equal(a, b: OLDate): OLBoolean;
begin
  Result := (a.Value = b.Value);
end;

function OLDate.GetDateTimeParts: TDateTimeParts;
var
  OutPut: TDateTimeParts;
begin
  OutPut.DateTime := Self;

  Result := OutPut;
end;

class operator OLDate.GreaterThan(a, b: OLDate): OLBoolean;
begin
  Result := (a.Value > b.Value);
end;

class operator OLDate.GreaterThanOrEqual(a, b: OLDate): OLBoolean;
begin
  Result := (a.Value >= b.Value);
end;

function OLDate.IfNull(b: OLDate): OLDate;
begin
  Result := Self.Value.IfNull(b);
end;

class operator OLDate.Implicit(a: OLDate): Variant;
var
  OutPut: Variant;
begin
  if not a.Value.IsNull then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLDate.Implicit(a: Extended): OLDate;
var
  dt: OLDateTime;
begin
  dt := a;
  dt := dt.DateOf;

  Result.Value := dt;
end;

class operator OLDate.Implicit(a: string): OLDate;
begin
  Result := StrToDate(a);
end;

class operator OLDate.Implicit(a: OLDateTime): OLDate;
begin
  Result.Value := a.DateOf();
end;

class operator OLDate.Implicit(a: OLDate): OLDateTime;
begin
  Result := a.Value;
end;

class operator OLDate.Implicit(a: Variant): OLDate;
var
  returnrec: OLDate;
  b: TDateTime;
begin
  if VarIsNull(a) then
    returnrec.Value := Null
  else
  begin
    if TryStrToDate(a, b) then
    begin
      returnrec.Value := b;
    end
    else
    begin
      raise Exception.Create('Value ''' + VarToStr(a) + ''' cannot be assigned to variable of OLDate type.');
    end;
  end;

  Result := returnrec;
end;

class operator OLDate.Implicit(a: TDateTime): OLDate;
var
  OutPut: OLDate;
begin
  OutPut.Value := DateOf(a);

  Result := OutPut;
end;

class operator OLDate.Implicit(a: TDate): OLDate;
var
  OutPut: OLDate;
begin
  OutPut.Value := a;

  Result := OutPut;
end;

class operator OLDate.Implicit(a: OLDate): TDateTime;
begin
  Result := a.Value;
end;

class operator OLDate.Implicit(a: OLDate): TDate;
begin
  Result := a.Value;
end;

function OLDate.IncDay(const ANumberOfDays: Integer): OLDate;
begin
  Result := Self.Value.IncDay(ANumberOfDays);
end;

function OLDate.IncMonth(const ANumberOfMonths: Integer): OLDate;
begin
  Result := Self.Value.IncMonth(ANumberOfMonths);
end;

function OLDate.IncWeek(const ANumberOfWeeks: Integer): OLDate;
begin
  Result := Self.Value.IncWeek(ANumberOfWeeks);
end;

function OLDate.IncYear(const ANumberOfYears: Integer): OLDate;
begin
  Result := Self.Value.IncYear(ANumberOfYears);
end;

function OLDate.InRange(AStartDateTime, AEndDateTime: OLDate;
  aInclusive: Boolean): OLBoolean;
begin
  Result := Self.Value.InDateRange(AStartDateTime, AEndDateTime, aInclusive);
end;

function OLDate.IsInLeapYear: OLBoolean;
begin
  Result := Self.Value.IsInLeapYear();
end;

function OLDate.IsNull: OLBoolean;
begin
  Result := Self.Value.IsNull;
end;

function OLDate.IsToday: OLBoolean;
begin
  Result := Self.Value.IsToday;
end;

class operator OLDate.LessThan(a, b: OLDate): OLBoolean;
begin
  Result := (a.Value < b.Value);
end;

class operator OLDate.LessThanOrEqual(a, b: OLDate): OLBoolean;
begin
  Result := (a.Value <= b.Value);
end;

function OLDate.MonthOf: OLInteger;
begin
  Result := Self.Value.MonthOf();
end;

function OLDate.MonthsBetween(const AThen: OLDate): OLInteger;
begin
  Result := Self.Value.MonthsBetween(AThen);
end;

function OLDate.MonthSpan(const AThen: OLDate): OLDouble;
begin
  Result := Self.Value.MonthSpan(AThen);
end;

class operator OLDate.NotEqual(a, b: OLDate): OLBoolean;
begin
  Result := (a.Value <> b.Value);
end;

function OLDate.RecodedDay(const ADay: Word): OLDate;
begin
  Result := Self.Value.RecodedDay(ADay);
end;

function OLDate.RecodedMonth(const AMonth: Word): OLDate;
begin
  Result := Self.Value.RecodedMonth(AMonth);
end;

function OLDate.RecodedYear(const AYear: Word): OLDate;
begin
  Result := Self.Value.RecodedYear(AYear);
end;

function OLDate.SameDay(const DateToCompare: OLDate): OLBoolean;
begin
  Result := Self.Value.SameDay(DateToCompare);
end;

procedure OLDate.SetDateTimeParts(const Value: TDateTimeParts);
begin
  Self := DateOf(Value.DateTime);
end;

procedure OLDate.SetEndOfAMonth(const AYear, AMonth: Word);
var
  dt: OLDateTime;
begin
  dt := Self.Value;

  dt.SetEndOfAMonth(AYear, AMonth);
  dt := dt.DateOf();

  Self.Value := dt;
end;

procedure OLDate.SetEndOfAYear(const AYear: Word);
var
  dt: OLDateTime;
begin
  dt := Self.Value;

  dt.SetEndOfAYear(AYear);
  dt := dt.DateOf();

  Self.Value := dt;
end;

procedure OLDate.SetStartOfAMonth(const AYear, AMonth: Word);
var
  dt: OLDateTime;
begin
  dt := Self.Value;

  dt.SetStartOfAMonth(AYear, AMonth);
  dt := dt.DateOf();

  Self.Value := dt;
end;

procedure OLDate.SetStartOfAYear(const AYear: Word);
var
  dt: OLDateTime;
begin
  dt := Self.Value;

  dt.SetStartOfAYear(AYear);
  dt := dt.DateOf();

  Self.Value := dt;
end;

procedure OLDate.SetToday;
begin
  Self.Value := OLDateTime.Today().DateOf();
end;

procedure OLDate.SetTomorow;
begin
  Self.Value := OLDateTime.Tomorrow().DateOf();
end;

procedure OLDate.SetYesterday;
begin
  Self.Value := OLDateTime.Yesterday().DateOf();
end;

class function OLDate.StartOfAMonth(const AYear, AMonth: Word): OLDate;
begin
  Result.Value := OLDateTime.StartOfAMonth(AYear, AMonth);
end;

class function OLDate.StartOfAYear(const AYear: Word): OLDate;
begin
  Result.Value := OLDateTime.StartOfAYear(AYear);
end;

function OLDate.StartOfTheMonth: OLDate;
begin
  Result := Self.Value.StartOfTheMonth().DateOf();
end;

function OLDate.StartOfTheWeek: OLDate;
begin
  Result := Self.Value.StartOfTheWeek().DateOf();
end;

function OLDate.StartOfTheYear: OLDate;
begin
  Result := Self.Value.StartOfTheYear().DateOf();
end;

class operator OLDate.Subtract(a: OLDate; b: integer): OLDate;
begin
  Result := a.Value - b;
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
    OutPut := DateToStr(Self.Value);

  Result := OutPut;
end;

function OLDate.WeekOf: OLInteger;
begin
  Result := Self.Value.WeekOf();
end;

function OLDate.WeeksBetween(const AThen: OLDate): OLInteger;
begin
  Result := Self.Value.WeeksBetween(AThen);
end;

function OLDate.WeeksInYear: OLInteger;
begin
  Result := Self.Value.WeeksInYear();
end;

function OLDate.WeekSpan(const AThen: OLDate): OLDouble;
begin
  Result := Self.Value.WeekSpan(AThen);
end;

function OLDate.YearOf: OLInteger;
begin
  Result := Self.Value.YearOf();
end;

function OLDate.YearsBetween(const AThen: OLDate): OLInteger;
begin
  Result := Self.Value.YearsBetween(AThen);
end;

function OLDate.YearSpan(const AThen: OLDate): OLDouble;
begin
  Result := Self.Value.YearSpan(AThen);
end;

class function OLDate.Yesterday: OLDate;
begin
  Result := OLDateTime.Yesterday().DateOf();
end;

end.
