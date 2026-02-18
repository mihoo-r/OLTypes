unit Test_NullPropagation;

interface

uses
  TestFramework,
  OLIntegerType,
  OLDoubleType,
  OLCurrencyType,
  OLBooleanType,
  OLDateType,
  OLDateTimeType,
  SysUtils,
  Variants;

type
  TTestNullPropagation = class(TTestCase)
  published
    procedure TestIntegerMaxMin;
    procedure TestDoubleMaxMinSqrt;
    procedure TestCurrencyMaxMin;
    procedure TestInt64MaxMin;
    procedure TestOLDateWithYearMonthDay;
    procedure TestOLDateTimeWithComponents;
    procedure TestOLDateTimeComponentGetters;
    procedure TestOLDateTimeBooleanMethods;
    procedure TestOLDateTimeStringMethods;
    procedure TestOLDateTimeStartEndMethods;
    procedure TestOLDateTimeIncMethods;
    procedure TestOLDateTimeRecodedMethods;
    procedure TestOLDateTimeSpanBetweenMethods;
    procedure TestOLDateTimeDecodeDateTime;
    procedure TestOLDateDelegatingMethods;
  end;

implementation

{ TTestNullPropagation }

procedure TTestNullPropagation.TestCurrencyMaxMin;
var
  c1, c2: OLCurrency;
  res: OLCurrency;
begin
  c1 := Null;
  c2 := 10.5;

  res := c1.Max(c2);
  Check(res.IsNull, 'OLCurrency.Max(Null, Value) should return Null');

  res := c2.Max(c1);
  Check(res.IsNull, 'OLCurrency.Max(Value, Null) should return Null');

  res := c1.Min(c2);
  Check(res.IsNull, 'OLCurrency.Min(Null, Value) should return Null');

  res := c2.Min(c1);
  Check(res.IsNull, 'OLCurrency.Min(Value, Null) should return Null');
end;

procedure TTestNullPropagation.TestDoubleMaxMinSqrt;
var
  d1, d2: OLDouble;
  res: OLDouble;
begin
  d1 := Null;
  d2 := 10.5;

  res := d1.Max(d2);
  Check(res.IsNull, 'OLDouble.Max(Null, Value) should return Null');

  res := d2.Max(d1);
  Check(res.IsNull, 'OLDouble.Max(Value, Null) should return Null');

  res := d1.Min(d2);
  Check(res.IsNull, 'OLDouble.Min(Null, Value) should return Null');

  res := d2.Min(d1);
  Check(res.IsNull, 'OLDouble.Min(Value, Null) should return Null');

  res := d1.Sqrt();
  Check(res.IsNull, 'OLDouble.Sqrt(Null) should return Null');
end;

procedure TTestNullPropagation.TestInt64MaxMin;
var
  i1, i2: OLInt64;
  res: OLInt64;
begin
  i1 := Null;
  i2 := 100;

  res := i1.Max(i2);
  Check(res.IsNull, 'OLInt64.Max(Null, Value) should return Null');

  res := i2.Max(i1);
  Check(res.IsNull, 'OLInt64.Max(Value, Null) should return Null');

  res := i1.Min(i2);
  Check(res.IsNull, 'OLInt64.Min(Null, Value) should return Null');

  res := i2.Min(i1);
  Check(res.IsNull, 'OLInt64.Min(Value, Null) should return Null');
end;

procedure TTestNullPropagation.TestIntegerMaxMin;
var
  i1, i2: OLInteger;
  res: OLInteger;
begin
  i1 := Null;
  i2 := 10;

  res := i1.Max(i2);
  Check(res.IsNull, 'OLInteger.Max(Null, Value) should return Null');

  res := i2.Max(i1);
  Check(res.IsNull, 'OLInteger.Max(Value, Null) should return Null');

  res := i1.Min(i2);
  Check(res.IsNull, 'OLInteger.Min(Null, Value) should return Null');

  res := i2.Min(i1);
  Check(res.IsNull, 'OLInteger.Min(Value, Null) should return Null');
end;

procedure TTestNullPropagation.TestOLDateWithYearMonthDay;
var
  d: OLDate;
  res: OLDate;
begin
  // d is uninitialized (null)

  res := d.WithYear(2024);
  Check(res.IsNull, 'OLDate.WithYear on null should return Null');

  res := d.WithMonth(6);
  Check(res.IsNull, 'OLDate.WithMonth on null should return Null');

  res := d.WithDay(15);
  Check(res.IsNull, 'OLDate.WithDay on null should return Null');
end;

procedure TTestNullPropagation.TestOLDateTimeWithComponents;
var
  dt: OLDateTime;
  res: OLDateTime;
begin
  // dt is uninitialized (null)

  res := dt.WithYear(2024);
  Check(res.IsNull, 'OLDateTime.WithYear on null should return Null');

  res := dt.WithMonth(6);
  Check(res.IsNull, 'OLDateTime.WithMonth on null should return Null');

  res := dt.WithDay(15);
  Check(res.IsNull, 'OLDateTime.WithDay on null should return Null');

  res := dt.WithHour(12);
  Check(res.IsNull, 'OLDateTime.WithHour on null should return Null');

  res := dt.WithMinute(30);
  Check(res.IsNull, 'OLDateTime.WithMinute on null should return Null');

  res := dt.WithSecond(45);
  Check(res.IsNull, 'OLDateTime.WithSecond on null should return Null');

  res := dt.WithMilliSecond(500);
  Check(res.IsNull, 'OLDateTime.WithMilliSecond on null should return Null');
end;

procedure TTestNullPropagation.TestOLDateTimeComponentGetters;
var
  dt: OLDateTime;
  ri: OLInteger;
begin
  // dt is uninitialized (null)

  ri := dt.Day;
  Check(ri.IsNull, 'Day on null should return Null');

  ri := dt.DayOfTheWeek;
  Check(ri.IsNull, 'DayOfTheWeek on null should return Null');

  ri := dt.DayOfTheYear;
  Check(ri.IsNull, 'DayOfTheYear on null should return Null');

  ri := dt.DaysInMonth;
  Check(ri.IsNull, 'DaysInMonth on null should return Null');

  ri := dt.DaysInYear;
  Check(ri.IsNull, 'DaysInYear on null should return Null');

  ri := dt.Hour;
  Check(ri.IsNull, 'Hour on null should return Null');

  ri := dt.HourOfTheMonth;
  Check(ri.IsNull, 'HourOfTheMonth on null should return Null');

  ri := dt.HourOfTheWeek;
  Check(ri.IsNull, 'HourOfTheWeek on null should return Null');

  ri := dt.HourOfTheYear;
  Check(ri.IsNull, 'HourOfTheYear on null should return Null');

  ri := dt.Minute;
  Check(ri.IsNull, 'Minute on null should return Null');

  ri := dt.MinuteOfTheDay;
  Check(ri.IsNull, 'MinuteOfTheDay on null should return Null');

  ri := dt.MinuteOfTheMonth;
  Check(ri.IsNull, 'MinuteOfTheMonth on null should return Null');

  ri := dt.MinuteOfTheWeek;
  Check(ri.IsNull, 'MinuteOfTheWeek on null should return Null');

  ri := dt.Second;
  Check(ri.IsNull, 'Second on null should return Null');

  ri := dt.SecondOfTheHour;
  Check(ri.IsNull, 'SecondOfTheHour on null should return Null');

  ri := dt.MilliSecond;
  Check(ri.IsNull, 'MilliSecond on null should return Null');

  ri := dt.Month;
  Check(ri.IsNull, 'Month on null should return Null');

  ri := dt.Year;
  Check(ri.IsNull, 'Year on null should return Null');

  ri := dt.WeeksInYear;
  Check(ri.IsNull, 'WeeksInYear on null should return Null');

  // Methods formerly returning LongWord/Int64, now OLInt64
  ri := dt.MinuteOfTheYear;
  Check(ri.IsNull, 'MinuteOfTheYear on null should return Null');

  ri := dt.SecondOfTheDay;
  Check(ri.IsNull, 'SecondOfTheDay on null should return Null');

  ri := dt.SecondOfTheMonth;
  Check(ri.IsNull, 'SecondOfTheMonth on null should return Null');

  ri := dt.SecondOfTheWeek;
  Check(ri.IsNull, 'SecondOfTheWeek on null should return Null');

  ri := dt.SecondOfTheYear;
  Check(ri.IsNull, 'SecondOfTheYear on null should return Null');

  ri := dt.MilliSecondOfTheDay;
  Check(ri.IsNull, 'MilliSecondOfTheDay on null should return Null');

  ri := dt.MilliSecondOfTheHour;
  Check(ri.IsNull, 'MilliSecondOfTheHour on null should return Null');

  ri := dt.MilliSecondOfTheMinute;
  Check(ri.IsNull, 'MilliSecondOfTheMinute on null should return Null');

  ri := dt.MilliSecondOfTheMonth;
  Check(ri.IsNull, 'MilliSecondOfTheMonth on null should return Null');

  ri := dt.MilliSecondOfTheWeek;
  Check(ri.IsNull, 'MilliSecondOfTheWeek on null should return Null');

  ri := dt.MilliSecondOfTheYear;
  Check(ri.IsNull, 'MilliSecondOfTheYear on null should return Null');
end;

procedure TTestNullPropagation.TestOLDateTimeBooleanMethods;
var
  dt: OLDateTime;
  rb: OLBoolean;
begin
  // dt is uninitialized (null)

  rb := dt.IsAM;
  Check(rb.IsNull, 'IsAM on null should return Null');

  rb := dt.IsPM;
  Check(rb.IsNull, 'IsPM on null should return Null');

  rb := dt.IsToday;
  Check(rb.IsNull, 'IsToday on null should return Null');

  rb := dt.IsInLeapYear;
  Check(rb.IsNull, 'IsInLeapYear on null should return Null');
end;

procedure TTestNullPropagation.TestOLDateTimeStringMethods;
var
  dt: OLDateTime;
  s: string;
begin
  // dt is uninitialized (null) — string methods should throw on null

  try
    s := dt.LongDayName;
    Fail('LongDayName on null should raise exception');
  except
    on E: Exception do
      Check(True);
  end;

  try
    s := dt.ShortDayName;
    Fail('ShortDayName on null should raise exception');
  except
    on E: Exception do
      Check(True);
  end;

  try
    s := dt.LongMonthName;
    Fail('LongMonthName on null should raise exception');
  except
    on E: Exception do
      Check(True);
  end;

  try
    s := dt.ShortMonthName;
    Fail('ShortMonthName on null should raise exception');
  except
    on E: Exception do
      Check(True);
  end;

  // ToString on null returns '' (already has null handling)
  CheckEquals('', dt.ToString, 'ToString on null should return empty string');
end;

procedure TTestNullPropagation.TestOLDateTimeStartEndMethods;
var
  dt: OLDateTime;
  res: OLDateTime;
begin
  // dt is uninitialized (null)

  res := dt.StartOfTheDay;
  Check(res.IsNull, 'StartOfTheDay on null should return Null');

  res := dt.StartOfTheMonth;
  Check(res.IsNull, 'StartOfTheMonth on null should return Null');

  res := dt.StartOfTheWeek;
  Check(res.IsNull, 'StartOfTheWeek on null should return Null');

  res := dt.StartOfTheYear;
  Check(res.IsNull, 'StartOfTheYear on null should return Null');

  res := dt.EndOfTheDay;
  Check(res.IsNull, 'EndOfTheDay on null should return Null');

  res := dt.EndOfTheMonth;
  Check(res.IsNull, 'EndOfTheMonth on null should return Null');

  res := dt.EndOfTheWeek;
  Check(res.IsNull, 'EndOfTheWeek on null should return Null');

  res := dt.EndOfTheYear;
  Check(res.IsNull, 'EndOfTheYear on null should return Null');
end;

procedure TTestNullPropagation.TestOLDateTimeIncMethods;
var
  dt: OLDateTime;
  res: OLDateTime;
begin
  // dt is uninitialized (null)

  res := dt.IncDay(1);
  Check(res.IsNull, 'IncDay on null should return Null');

  res := dt.IncWeek(1);
  Check(res.IsNull, 'IncWeek on null should return Null');

  res := dt.IncMonth(1);
  Check(res.IsNull, 'IncMonth on null should return Null');

  res := dt.IncYear(1);
  Check(res.IsNull, 'IncYear on null should return Null');

  res := dt.IncHour(1);
  Check(res.IsNull, 'IncHour on null should return Null');

  res := dt.IncMinute(1);
  Check(res.IsNull, 'IncMinute on null should return Null');

  res := dt.IncSecond(1);
  Check(res.IsNull, 'IncSecond on null should return Null');

  res := dt.IncMilliSecond(1);
  Check(res.IsNull, 'IncMilliSecond on null should return Null');
end;

procedure TTestNullPropagation.TestOLDateTimeRecodedMethods;
var
  dt: OLDateTime;
  res: OLDateTime;
begin
  // dt is uninitialized (null)

  res := dt.RecodedYear(2024);
  Check(res.IsNull, 'RecodedYear on null should return Null');

  res := dt.RecodedMonth(6);
  Check(res.IsNull, 'RecodedMonth on null should return Null');

  res := dt.RecodedDay(15);
  Check(res.IsNull, 'RecodedDay on null should return Null');

  res := dt.RecodedHour(12);
  Check(res.IsNull, 'RecodedHour on null should return Null');

  res := dt.RecodedMinute(30);
  Check(res.IsNull, 'RecodedMinute on null should return Null');

  res := dt.RecodedSecond(45);
  Check(res.IsNull, 'RecodedSecond on null should return Null');

  res := dt.RecodedMilliSecond(500);
  Check(res.IsNull, 'RecodedMilliSecond on null should return Null');
end;

procedure TTestNullPropagation.TestOLDateTimeSpanBetweenMethods;
var
  dt: OLDateTime;
  validDt: OLDateTime;
  rd: OLDouble;
  ri: OLInteger;
begin
  // dt is uninitialized (null)
  validDt := OLDateTime.Now;

  // Span methods (return OLDouble) — null on either arg
  rd := dt.DaySpan(validDt);
  Check(rd.IsNull, 'DaySpan on null self should return Null');

  rd := dt.HourSpan(validDt);
  Check(rd.IsNull, 'HourSpan on null self should return Null');

  rd := dt.MinuteSpan(validDt);
  Check(rd.IsNull, 'MinuteSpan on null self should return Null');

  rd := dt.SecondSpan(validDt);
  Check(rd.IsNull, 'SecondSpan on null self should return Null');

  rd := dt.MilliSecondSpan(validDt);
  Check(rd.IsNull, 'MilliSecondSpan on null self should return Null');

  rd := dt.WeekSpan(validDt);
  Check(rd.IsNull, 'WeekSpan on null self should return Null');

  rd := dt.MonthSpan(validDt);
  Check(rd.IsNull, 'MonthSpan on null self should return Null');

  rd := dt.YearSpan(validDt);
  Check(rd.IsNull, 'YearSpan on null self should return Null');

  // Between methods (OLInteger) — null on either arg
  ri := dt.DaysBetween(validDt);
  Check(ri.IsNull, 'DaysBetween on null self should return Null');

  ri := dt.WeeksBetween(validDt);
  Check(ri.IsNull, 'WeeksBetween on null self should return Null');

  ri := dt.MonthsBetween(validDt);
  Check(ri.IsNull, 'MonthsBetween on null self should return Null');

  ri := dt.YearsBetween(validDt);
  Check(ri.IsNull, 'YearsBetween on null self should return Null');

  // Between methods (OLInt64) — null on either arg
  ri := dt.HoursBetween(validDt);
  Check(ri.IsNull, 'HoursBetween on null self should return Null');

  ri := dt.MinutesBetween(validDt);
  Check(ri.IsNull, 'MinutesBetween on null self should return Null');

  ri := dt.SecondsBetween(validDt);
  Check(ri.IsNull, 'SecondsBetween on null self should return Null');

  ri := dt.MilliSecondsBetween(validDt);
  Check(ri.IsNull, 'MilliSecondsBetween on null self should return Null');

  // SameTime — returns Null on null (consistent null propagation)
  Check(dt.SameTime(validDt).IsNull, 'SameTime on null self should return Null');
end;

procedure TTestNullPropagation.TestOLDateTimeDecodeDateTime;
var
  dt: OLDateTime;
  Y, M, D, H, Mi, S, Ms: Word;
begin
  // dt is uninitialized (null) — DecodeDateTime should throw on null
  try
    dt.DecodeDateTime(Y, M, D, H, Mi, S, Ms);
    Fail('DecodeDateTime on null should raise exception');
  except
    on E: Exception do
      Check(True);
  end;
end;

procedure TTestNullPropagation.TestOLDateDelegatingMethods;
var
  d: OLDate;
  ri: OLInteger;
  rb: OLBoolean;
begin
  // d is uninitialized (null) — tests that OLDate delegates to OLDateTime safely

  ri := d.DayOfTheWeek;
  Check(ri.IsNull, 'OLDate.DayOfTheWeek on null should return Null');

  ri := d.DayOfTheYear;
  Check(ri.IsNull, 'OLDate.DayOfTheYear on null should return Null');

  ri := d.Year;
  Check(ri.IsNull, 'OLDate.Year on null should return Null');

  ri := d.Month;
  Check(ri.IsNull, 'OLDate.Month on null should return Null');

  ri := d.Day;
  Check(ri.IsNull, 'OLDate.Day on null should return Null');

  rb := d.IsInLeapYear;
  Check(rb.IsNull, 'OLDate.IsInLeapYear on null should return Null');

  rb := d.IsToday;
  Check(rb.IsNull, 'OLDate.IsToday on null should return Null');

  try
    d.LongDayName;
    Fail('OLDate.LongDayName on null should raise exception');
  except
    on E: Exception do
      Check(True);
  end;

  try
    d.ShortDayName;
    Fail('OLDate.ShortDayName on null should raise exception');
  except
    on E: Exception do
      Check(True);
  end;

  try
    d.LongMonthName;
    Fail('OLDate.LongMonthName on null should raise exception');
  except
    on E: Exception do
      Check(True);
  end;

  try
    d.ShortMonthName;
    Fail('OLDate.ShortMonthName on null should raise exception');
  except
    on E: Exception do
      Check(True);
  end;
end;

initialization
  RegisterTest(TTestNullPropagation.Suite);

end.

