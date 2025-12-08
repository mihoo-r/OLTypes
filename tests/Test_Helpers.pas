unit Test_Helpers;

interface

uses
  TestFramework, SysUtils, Types, Classes, DateUtils, OLTypes;



implementation

{$IF CompilerVersion >= 24.0}

type
  TestIntegerHelper = class(TTestCase)
  published
    procedure TestIsDividableBy;
    procedure TestIsOdd;
    procedure TestIsEven;
    procedure TestIsPositive;
    procedure TestIsNegative;
    procedure TestIsNonNegative;
    procedure TestIsPrime;
    procedure TestSqr;
    procedure TestPower;
    procedure TestAbs;
    procedure TestMax;
    procedure TestMin;
    procedure TestRound;
    procedure TestBetween;
    procedure TestIncreased;
    procedure TestDecreased;
    procedure TestReplaced;
    procedure TestToString;
    procedure TestToSQLString;
    procedure TestToNumeralSystem;
    procedure TestBinary;
    procedure TestOctal;
    procedure TestHexidecimal;
    procedure TestNumeralSystem32;
    procedure TestNumeralSystem64;
    procedure TestForLoop;
    procedure TestRandom;
    procedure TestRandomPrime;
    procedure TestSetRandom;
    procedure TestSetRandomPrime;
    procedure TestBasicFunctionality;
    procedure TestBinaryAndHex;
    procedure TestMathOperations;
    procedure TestPrimeNumbers;
  end;

procedure TestIntegerHelper.TestIsDividableBy;
var
  i: Integer;
begin
  i := 10;
  CheckTrue(i.IsDividableBy(2));
  CheckFalse(i.IsDividableBy(3));
end;

procedure TestIntegerHelper.TestIsOdd;
var
  i: Integer;
begin
  i := 5;
  CheckTrue(i.IsOdd());
  i := 4;
  CheckFalse(i.IsOdd());
end;

procedure TestIntegerHelper.TestIsEven;
var
  i: Integer;
begin
  i := 4;
  CheckTrue(i.IsEven());
  i := 5;
  CheckFalse(i.IsEven());
end;

procedure TestIntegerHelper.TestIsPositive;
var
  i: Integer;
begin
  i := 5;
  CheckTrue(i.IsPositive());
  i := -5;
  CheckFalse(i.IsPositive());
end;

procedure TestIntegerHelper.TestIsNegative;
var
  i: Integer;
begin
  i := -5;
  CheckTrue(i.IsNegative());
  i := 5;
  CheckFalse(i.IsNegative());
end;

procedure TestIntegerHelper.TestIsNonNegative;
var
  i: Integer;
begin
  i := 0;
  CheckTrue(i.IsNonNegative());
  i := 5;
  CheckTrue(i.IsNonNegative());
  i := -5;
  CheckFalse(i.IsNonNegative());
end;

procedure TestIntegerHelper.TestIsPrime;
var
  i: Integer;
begin
  i := 7;
  CheckTrue(i.IsPrime());
  i := 4;
  CheckFalse(i.IsPrime());
end;

procedure TestIntegerHelper.TestSqr;
var
  i: Integer;
begin
  i := 5;
  CheckEquals(25, i.Sqr());
end;

procedure TestIntegerHelper.TestPower;
var
  i: Integer;
begin
  i := 2;
  CheckEquals(8, i.Power(3));
  i := 3;
  CheckEquals(9.0, i.Power(2), 0.001);
end;

procedure TestIntegerHelper.TestAbs;
var
  i: Integer;
begin
  i := -5;
  CheckEquals(5, i.Abs());
  i := 5;
  CheckEquals(5, i.Abs());
end;

procedure TestIntegerHelper.TestMax;
var
  i: Integer;
begin
  i := 5;
  CheckEquals(10, i.Max(10));
  i := 10;
  CheckEquals(10, i.Max(5));
end;

procedure TestIntegerHelper.TestMin;
var
  i: Integer;
begin
  i := 5;
  CheckEquals(5, i.Min(10));
  i := 10;
  CheckEquals(5, i.Min(5));
end;

procedure TestIntegerHelper.TestRound;
var
  i: Integer;
begin
  i := 15;
  CheckEquals(20, i.Round(1));

  i := 25;
  CheckEquals(20, i.Round(1)); //banker's round
end;

procedure TestIntegerHelper.TestBetween;
var
  i: Integer;
begin
  i := 5;
  CheckTrue(i.Between(1, 10));
  i := 15;
  CheckFalse(i.Between(1, 10));
end;

procedure TestIntegerHelper.TestIncreased;
var
  i: Integer;
begin
  i := 5;
  CheckEquals(6, i.Increased());
  CheckEquals(7, i.Increased(2));
end;

procedure TestIntegerHelper.TestDecreased;
var
  i: Integer;
begin
  i := 5;
  CheckEquals(4, i.Decreased());
  CheckEquals(3, i.Decreased(2));
end;

procedure TestIntegerHelper.TestReplaced;
var
  i: Integer;
begin
  i := 5;
  CheckEquals(20, i.Replaced(5, 20));
end;

procedure TestIntegerHelper.TestToString;
var
  i: Integer;
begin
  i := 10;
  CheckEquals('10', i.ToString());
end;

procedure TestIntegerHelper.TestToSQLString;
var
  i: Integer;
begin
  i := 10;
  CheckEquals('10', i.ToSQLString());
end;

procedure TestIntegerHelper.TestToNumeralSystem;
var
  i: Integer;
begin
  i := 10;
  CheckEquals('1010', i.ToNumeralSystem(2));
end;

procedure TestIntegerHelper.TestBinary;
var
  i: Integer;
begin
  i := 10;
  i.Binary := '1010';
  CheckEquals(10, i);
end;

procedure TestIntegerHelper.TestOctal;
var
  i: Integer;
begin
  i := 8;
  i.Octal := '10';
  CheckEquals(8, i);
end;

procedure TestIntegerHelper.TestHexidecimal;
var
  i: Integer;
begin
  i := 16;
  i.Hexidecimal := '10';
  CheckEquals(16, i);
end;

procedure TestIntegerHelper.TestNumeralSystem32;
var
  i: Integer;
begin
  i := 32;
  i.NumeralSystem32 := '10';
  CheckEquals(32, i);
end;

procedure TestIntegerHelper.TestNumeralSystem64;
var
  i: Integer;
begin
  i := 64;
  i.NumeralSystem64 := '10';
  CheckEquals(64, i);
end;

procedure TestIntegerHelper.TestForLoop;
var
  Sum, i: Integer;
begin
  Sum := 0;
  i := 5;
  i.ForLoop(1, 3, procedure begin Inc(Sum); end);
  CheckEquals(3, Sum);
end;

procedure TestIntegerHelper.TestRandom;
var
  RandVal: Integer;
begin
  RandVal := Integer.Random(1, 10);
  CheckTrue(RandVal >= 1);
  CheckTrue(RandVal <= 10);
end;

procedure TestIntegerHelper.TestRandomPrime;
var
  RandPrime: Integer;
begin
  RandPrime := Integer.RandomPrime(2, 10);
  CheckTrue(RandPrime.IsPrime());
end;

procedure TestIntegerHelper.TestSetRandom;
var
  i: Integer;
begin
  i := 0;
  i.SetRandom(1, 10);
  CheckTrue((i >= 1) and (i <= 10));
end;

procedure TestIntegerHelper.TestSetRandomPrime;
var
  i: Integer;
begin
  i := 0;
  i.SetRandomPrime(2, 10);
  CheckTrue(i.IsPrime());
end;

procedure TestIntegerHelper.TestBasicFunctionality;
var
  i: Integer;
begin
  i := 10;
  CheckTrue(i.IsEven, 'IsEven for 10');
  CheckFalse(i.IsOdd, 'IsOdd for 10');

  i := -5;
  CheckEquals(5, i.Abs, 'Abs');
  CheckTrue(i.IsNegative, 'IsNegative');

  i := 5;
  CheckFalse(i.IsNegative, 'IsNegative for positive');
  CheckTrue(i.IsPositive, 'IsPositive');
end;

procedure TestIntegerHelper.TestBinaryAndHex;
var
  i: Integer;
begin
  i := 10;
  i.Binary := '1011';

  CheckEquals(11, i, 'Binary setter');
  CheckEquals('1011', i.Binary, 'Binary getter');
  CheckEquals('B', i.Hexidecimal, 'Hex getter');
end;

procedure TestIntegerHelper.TestPrimeNumbers;
var
  i: Integer;
begin
  i := 11;
  CheckTrue(i.IsPrime, 'IsPrime (11)');

  i := 10;
  CheckFalse(i.IsPrime, 'IsPrime (10)');

  i := 2;
  CheckTrue(i.IsPrime, 'IsPrime (2)');

  i := 1;
  CheckFalse(i.IsPrime, 'IsPrime (1)');
end;

procedure TestIntegerHelper.TestMathOperations;
var
  i: Integer;
begin
  i := 10;
  CheckEquals(15, i.Increased(5), 'Increased');
  CheckEquals(100, i.Sqr, 'Sqr');

  i := 11;
  CheckEquals('10', i.Increased(5).Hexidecimal, 'Increased then Hex');
end;

type
  TestBooleanHelper = class(TTestCase)
  published
    procedure TestToString;
    procedure TestToSQLString;
    procedure TestIfThenString;
    procedure TestIfThenInteger;
    procedure TestIfThenCurrency;
    procedure TestIfThenExtended;
    procedure TestIfThenDateTime;
    procedure TestIfThenBoolean;
  end;

procedure TestBooleanHelper.TestToString;
var
  b: Boolean;
begin
  b := True;
  CheckEquals('-1', b.ToString());
  b := False;
  CheckEquals('0', b.ToString());

  b := True;
  CheckEquals('True', b.ToString(TUseBoolStrs.True));
  b := False;
  CheckEquals('False', b.ToString(TUseBoolStrs.True));
end;

procedure TestBooleanHelper.TestToSQLString;
var
  b: Boolean;
begin
  b := True;
  CheckEquals('True', b.ToSQLString());
  b := False;
  CheckEquals('False', b.ToSQLString());
end;

procedure TestBooleanHelper.TestIfThenString;
var
  b: Boolean;
begin
  b := True;
  CheckEquals('Yes', b.IfThen('Yes', 'No'));
  b := False;
  CheckEquals('No', b.IfThen('Yes', 'No'));
end;

procedure TestBooleanHelper.TestIfThenInteger;
var
  b: Boolean;
begin
  b := True;
  CheckEquals(1, b.IfThen(1, 0));
  b := False;
  CheckEquals(0, b.IfThen(1, 0));
end;

procedure TestBooleanHelper.TestIfThenCurrency;
var
  b: Boolean;
  result: Currency;
begin
  b := True;
  result := b.IfThen(100.50, 0.0);
  CheckEquals(100.50, result, 0.01);
  b := False;
  result := b.IfThen(100.50, 0.0);
  CheckEquals(0.0, result, 0.01);
end;

procedure TestBooleanHelper.TestIfThenExtended;
var
  b: Boolean;
  result: Extended;
begin
  b := True;
  result := b.IfThen(3.14, 0.0);
  CheckEquals(3.14, result, 0.01);
  b := False;
  result := b.IfThen(3.14, 0.0);
  CheckEquals(0.0, result, 0.01);
end;

procedure TestBooleanHelper.TestIfThenDateTime;
var
  b: Boolean;
  dt1, dt2: TDateTime;
begin
  b := True;
  dt1 := EncodeDate(2023, 1, 1);
  dt2 := EncodeDate(2024, 1, 1);
  CheckEquals(dt1, b.IfThen(dt1, dt2));
  b := False;
  CheckEquals(dt2, b.IfThen(dt1, dt2));
end;

procedure TestBooleanHelper.TestIfThenBoolean;
var
  b: Boolean;
begin
  b := True;
  CheckTrue(b.IfThen(True, False));
  b := False;
  CheckFalse(b.IfThen(True, False));
end;


type
  TestDoubleHelper = class(TTestCase)
  published
    procedure TestSqr;
    procedure TestSqrt;
    procedure TestPower;
    procedure TestIsPositive;
    procedure TestIsNegative;
    procedure TestIsNonNegative;
    procedure TestMaxMin;
    procedure TestAbs;
    procedure TestToString;
    procedure TestToSQLString;
    procedure TestRound;
    procedure TestFloorCeil;
    procedure TestIsNan;
    procedure TestIsInfinite;
    procedure TestIsZero;
    procedure TestInRange;
    procedure TestEnsureRange;
    procedure TestSameValue;
    procedure TestRandom;
    procedure TestExponent;
    procedure TestFraction;
    procedure TestMantissa;
    procedure TestSign;
    procedure TestExp;
    procedure TestFrac;
    procedure TestSpecialType;
    procedure TestBuildUp;
    procedure TestToStringOverloads;
    procedure TestIsNegativeInfinity;
    procedure TestIsPositiveInfinity;
    procedure TestBytes;
    procedure TestWords;
    procedure TestParse;
    procedure TestTryParse;
    procedure TestStaticIsNan;
    procedure TestStaticIsInfinity;
    procedure TestStaticIsNegativeInfinity;
    procedure TestStaticIsPositiveInfinity;
    procedure TestSize;
  end;

procedure TestDoubleHelper.TestSqr;
var
  d: Double;
begin
  d := 5.0;
  CheckEquals(25.0, d.Sqr, 0.01);
end;

procedure TestDoubleHelper.TestSqrt;
var
  d: Double;
begin
  d := 25.0;
  CheckEquals(5.0, d.Sqrt, 0.01);
end;

procedure TestDoubleHelper.TestPower;
var
  d: Double;
begin
  d := 2.0;
  CheckEquals(8.0, d.Power(3), 0.01);
  CheckEquals(8.0, d.Power(3.0), 0.01);
end;

procedure TestDoubleHelper.TestIsPositive;
var
  d: Double;
begin
  d := 5.5;
  CheckTrue(d.IsPositive);
  d := -5.5;
  CheckFalse(d.IsPositive);
end;

procedure TestDoubleHelper.TestIsNegative;
var
  d: Double;
begin
  d := -5.5;
  CheckTrue(d.IsNegative);
  d := 5.5;
  CheckFalse(d.IsNegative);
end;

procedure TestDoubleHelper.TestIsNonNegative;
var
  d: Double;
begin
  d := 0.0;
  CheckTrue(d.IsNonNegative);
  d := 5.5;
  CheckTrue(d.IsNonNegative);
  d := -5.5;
  CheckFalse(d.IsNonNegative);
end;

procedure TestDoubleHelper.TestMaxMin;
var
  d: Double;
begin
  d := 5.5;
  CheckEquals(10.0, d.Max(10.0), 0.01);
  CheckEquals(5.5, d.Max(3.0), 0.01);
  CheckEquals(3.0, d.Min(3.0), 0.01);
  CheckEquals(5.5, d.Min(10.0), 0.01);
end;

procedure TestDoubleHelper.TestAbs;
var
  d: Double;
begin
  d := -5.5;
  CheckEquals(5.5, d.Abs, 0.01);
  d := 5.5;
  CheckEquals(5.5, d.Abs, 0.01);
end;

procedure TestDoubleHelper.TestToString;
var
  d: Double;
begin
  d := 123.45;
  CheckNotEquals('', d.ToString);
  CheckNotEquals('', d.ToString(2));
  CheckNotEquals('', d.ToString(',', '.'));
end;

procedure TestDoubleHelper.TestToSQLString;
var
  d: Double;
begin
  d := 123.45;
  CheckNotEquals('', d.ToSQLString);
end;

procedure TestDoubleHelper.TestRound;
var
  d: Double;
  i: Integer;
begin
  d := 123.456;
  CheckEquals(123.46, d.Round(-2), 0.01);
  i := d.Round;
  CheckEquals(123, i);

  d := 12345;
  CheckEquals(12340, d.Round(1));
end;

procedure TestDoubleHelper.TestFloorCeil;
var
  d: Double;
begin
  d := 123.7;
  CheckEquals(123, d.Floor);
  CheckEquals(124, d.Ceil);
end;

procedure TestDoubleHelper.TestIsNan;
var
  d: Double;
begin
  d := 0.0 / 0.0;
  CheckTrue(d.IsNan);
  d := 5.5;
  CheckFalse(d.IsNan);
end;

procedure TestDoubleHelper.TestIsInfinite;
var
  d: Double;
begin
  d := 1.0 / 0.0;
  CheckTrue(d.IsInfinite);
  d := 5.5;
  CheckFalse(d.IsInfinite);
end;

procedure TestDoubleHelper.TestIsZero;
var
  d: Double;
begin
  d := 0.0;
  CheckTrue(d.IsZero);
  d := 0.0000001;
  CheckTrue(d.IsZero(0.001));
  d := 5.5;
  CheckFalse(d.IsZero);
end;

procedure TestDoubleHelper.TestInRange;
var
  d: Double;
begin
  d := 5.5;
  CheckTrue(d.InRange(1.0, 10.0));
  d := 15.5;
  CheckFalse(d.InRange(1.0, 10.0));
end;

procedure TestDoubleHelper.TestEnsureRange;
var
  d: Double;
begin
  d := 15.5;
  CheckEquals(10.0, d.EnsureRange(1.0, 10.0), 0.01);
  d := 5.5;
  CheckEquals(5.5, d.EnsureRange(1.0, 10.0), 0.01);
end;

procedure TestDoubleHelper.TestSameValue;
var
  d: Double;
begin
  d := 5.5;
  CheckTrue(d.SameValue(5.5));
  CheckTrue(d.SameValue(5.50001, 0.001));
  CheckFalse(d.SameValue(6.0));
end;

procedure TestDoubleHelper.TestRandom;
var
  d: Double;
begin
  d := Double.Random(1.0, 10.0);
  CheckTrue((d >= 1.0) and (d <= 10.0));
  d := Double.Random(10.0);
  CheckTrue((d >= 0.0) and (d <= 10.0));
end;

procedure TestDoubleHelper.TestExponent;
var
  d: Double;
begin
  d := 8.0;
  CheckEquals(3, d.Exponent);
end;

procedure TestDoubleHelper.TestFraction;
var
  d: Double;
begin
  d := 1.5;
  CheckEquals(1.5, d.Fraction, 0.0001); 
end;

procedure TestDoubleHelper.TestMantissa;
var
  d: Double;
begin
  d := 1.0;
  CheckEquals(4503599627370496, d.Mantissa);
end;

procedure TestDoubleHelper.TestSign;
var
  d: Double;
begin
  d := -5.0;
  CheckTrue(d.Sign); // True for negative
  d := 5.0;
  CheckFalse(d.Sign); // False for positive

  d.Sign := True;
  CheckEquals(-5.0, d, 0.001);
end;

procedure TestDoubleHelper.TestExp;
var
  d: Double;
begin
  d := 8.0;
  CheckEquals(1026, d.Exp);
  d.Exp := 1027; // 16.0
  CheckEquals(16.0, d, 0.001);
end;

procedure TestDoubleHelper.TestFrac;
var
  d: Double;
begin
  d := 1.5;
  CheckEquals(2251799813685248, d.Frac);
end;

procedure TestDoubleHelper.TestSpecialType;
var
  d: Double;
begin
  d := 0.0 / 0.0;
  CheckTrue(d.SpecialType = fsNaN);
  d := 1.0 / 0.0;
  CheckTrue(d.SpecialType = fsInf);
  d := -1.0 / 0.0;
  CheckTrue(d.SpecialType = fsNInf);
  d := 0.0;
  CheckTrue(d.SpecialType = fsZero);
end;

procedure TestDoubleHelper.TestBuildUp;
var
  d: Double;
begin
  d.BuildUp(True, 0, 3); // Sign=Neg, Mantissa=0, Exp=3 (2^3=8)
  CheckEquals(-8.0, d, 0.001);
end;

procedure TestDoubleHelper.TestToStringOverloads;
var
  d: Double;
  fs: TFormatSettings;
begin
  d := 123.456;
  fs := TFormatSettings.Create;
  fs.DecimalSeparator := ',';
  CheckEquals('123,456', d.ToString(fs));
  
  CheckEquals('123,46', d.ToString(ffFixed, 15, 2, fs));
end;

procedure TestDoubleHelper.TestIsNegativeInfinity;
var
  d: Double;
begin
  d := -1.0 / 0.0;
  CheckTrue(d.IsNegativeInfinity);
  d := 1.0 / 0.0;
  CheckFalse(d.IsNegativeInfinity);
end;

procedure TestDoubleHelper.TestIsPositiveInfinity;
var
  d: Double;
begin
  d := 1.0 / 0.0;
  CheckTrue(d.IsPositiveInfinity);
  d := -1.0 / 0.0;
  CheckFalse(d.IsPositiveInfinity);
end;

procedure TestDoubleHelper.TestBytes;
var
  d: Double;
begin
  d := 1.0;
  CheckEquals($00, d.Bytes[0]);
  CheckEquals($F0, d.Bytes[6]);
  CheckEquals($3F, d.Bytes[7]);
  
  d.Bytes[7] := $40;
  CheckEquals(65536.0, d, 0.001);
end;

procedure TestDoubleHelper.TestWords;
var
  d: Double;
begin
  d := 1.0;
  CheckEquals($0000, d.Words[0]);
  CheckEquals($3FF0, d.Words[3]);
  
  d.Words[3] := $4000;
  CheckEquals(2.0, d, 0.001);
end;

procedure TestDoubleHelper.TestParse;
var
  fs: TFormatSettings;
begin
  CheckEquals(123.45, Double.Parse('123.45', TFormatSettings.Invariant), 0.001);
  
  fs := TFormatSettings.Create;
  fs.DecimalSeparator := ',';
  CheckEquals(123.45, Double.Parse('123,45', fs), 0.001);
end;

procedure TestDoubleHelper.TestTryParse;
var
  d: Double;
  fs: TFormatSettings;
begin
  CheckTrue(Double.TryParse('123.45', d, TFormatSettings.Invariant));
  CheckEquals(123.45, d, 0.001);
  
  fs := TFormatSettings.Create;
  fs.DecimalSeparator := ',';
  CheckTrue(Double.TryParse('123,45', d, fs));
  CheckEquals(123.45, d, 0.001);
  
  CheckFalse(Double.TryParse('invalid', d));
end;

procedure TestDoubleHelper.TestStaticIsNan;
begin
  CheckTrue(Double.IsNan(0.0 / 0.0));
  CheckFalse(Double.IsNan(1.0));
end;

procedure TestDoubleHelper.TestStaticIsInfinity;
begin
  CheckTrue(Double.IsInfinity(1.0 / 0.0));
  CheckTrue(Double.IsInfinity(-1.0 / 0.0));
  CheckFalse(Double.IsInfinity(1.0));
end;

procedure TestDoubleHelper.TestStaticIsNegativeInfinity;
begin
  CheckTrue(Double.IsNegativeInfinity(-1.0 / 0.0));
  CheckFalse(Double.IsNegativeInfinity(1.0 / 0.0));
end;

procedure TestDoubleHelper.TestStaticIsPositiveInfinity;
begin
  CheckTrue(Double.IsPositiveInfinity(1.0 / 0.0));
  CheckFalse(Double.IsPositiveInfinity(-1.0 / 0.0));
end;

procedure TestDoubleHelper.TestSize;
begin
  CheckEquals(8, Double.Size);
end;


type
  TestCurrencyHelper = class(TTestCase)
  published
    procedure TestSqr;
    procedure TestPower;
    procedure TestIsPositive;
    procedure TestIsNegative;
    procedure TestIsNonNegative;
    procedure TestBetween;
    procedure TestMaxMin;
    procedure TestAbs;
    procedure TestToString;
    procedure TestToSQLString;
    procedure TestToStrF;
    procedure TestRound;
    procedure TestFloorCeil;
  end;

procedure TestCurrencyHelper.TestSqr;
var
  c: Currency;
begin
  c := 5.0;
  CheckEquals(25.0, c.Sqr, 0.01);
end;

procedure TestCurrencyHelper.TestPower;
var
  c: Currency;
begin
  c := 2.0;
  CheckEquals(8.0, c.Power(3), 0.01);
end;

procedure TestCurrencyHelper.TestIsPositive;
var
  c: Currency;
begin
  c := 5.50;
  CheckTrue(c.IsPositive);
  c := -5.50;
  CheckFalse(c.IsPositive);
end;

procedure TestCurrencyHelper.TestIsNegative;
var
  c: Currency;
begin
  c := -5.50;
  CheckTrue(c.IsNegative);
  c := 5.50;
  CheckFalse(c.IsNegative);
end;

procedure TestCurrencyHelper.TestIsNonNegative;
var
  c: Currency;
begin
  c := 0.0;
  CheckTrue(c.IsNonNegative);
  c := 5.50;
  CheckTrue(c.IsNonNegative);
  c := -5.50;
  CheckFalse(c.IsNonNegative);
end;

procedure TestCurrencyHelper.TestBetween;
var
  c: Currency;
begin
  c := 5.50;

  CheckTrue(c.Between(1.1, 5.5));
  c := 15.50;
  CheckFalse(c.Between(1, 15.4999));
end;

procedure TestCurrencyHelper.TestMaxMin;
var
  c: Currency;
begin
  c := 5.50;
  CheckEquals(10.0, c.Max(10.0), 0.01);
  CheckEquals(5.50, c.Max(3.0), 0.01);
  CheckEquals(3.0, c.Min(3.0), 0.01);
  CheckEquals(5.50, c.Min(10.0), 0.01);
end;

procedure TestCurrencyHelper.TestAbs;
var
  c: Currency;
begin
  c := -5.50;
  CheckEquals(5.50, c.Abs, 0.01);
  c := 5.50;
  CheckEquals(5.50, c.Abs, 0.01);
end;

procedure TestCurrencyHelper.TestToString;
var
  c: Currency;
begin
  c := 123.45;
  CheckNotEquals('', c.ToString);
  CheckNotEquals('', c.ToString(',', '.'));
end;

procedure TestCurrencyHelper.TestToSQLString;
var
  c: Currency;
begin
  c := 123.45;
  CheckNotEquals('', c.ToSQLString);
end;

procedure TestCurrencyHelper.TestToStrF;
var
  c: Currency;
begin
  c := 123.45;
  CheckNotEquals('', c.ToStrF(ffCurrency, 2));
end;

procedure TestCurrencyHelper.TestRound;
var
  c: Currency;
  i: Integer;
begin
  c := 123.456;
  CheckEquals(123.46, c.Round(-2), 0.01);
  i := c.Round;
  CheckEquals(123, i);

  i := 12345;
  CheckEquals(12340, i.Round(1));
end;

procedure TestCurrencyHelper.TestFloorCeil;
var
  c: Currency;
begin
  c := 123.7;
  CheckEquals(123, c.Floor);
  CheckEquals(124, c.Ceil);
end;




type
  TestDateTimeHelper = class(TTestCase)
  published
    procedure TestProperties;
    procedure TestToString;
    procedure TestDateOfTimeOf;
    procedure TestChecks;
    procedure TestStartEnd;
    procedure TestParts;
    procedure TestBetween;
    procedure TestSpan;
    procedure TestInc;
    procedure TestRecoded;
    procedure TestEncodeDecode;
    procedure TestNames;
    procedure TestMaxMin;
    procedure TestStaticCreators;
  end;

procedure TestDateTimeHelper.TestProperties;
var
  dt: TDateTime;
begin
  dt := EncodeDateTime(2023, 10, 27, 14, 30, 45, 500);

  CheckEquals(2023, dt.Year);
  CheckEquals(10, dt.Month);
  CheckEquals(27, dt.Day);
  CheckEquals(14, dt.Hour);
  CheckEquals(30, dt.Minute);
  CheckEquals(45, dt.Second);
  CheckEquals(500, dt.test);

  dt.Year := 2024;
  CheckEquals(2024, dt.Year);
end;

procedure TestDateTimeHelper.TestToString;
var
  dt: TDateTime;
begin
  dt := EncodeDate(2023, 1, 1);
  CheckNotEquals('', dt.ToString);
  CheckNotEquals('', dt.ToString('yyyy-mm-dd'));
  CheckNotEquals('', dt.ToSQLString);
end;

procedure TestDateTimeHelper.TestDateOfTimeOf;
var
  dt: TDateTime;
begin
  dt := EncodeDateTime(2023, 10, 27, 14, 30, 45, 500);
  CheckEquals(EncodeDate(2023, 10, 27), dt.DateOf);
  CheckEquals(EncodeTime(14, 30, 45, 500), dt.TimeOf, 0.00000001);
end;

procedure TestDateTimeHelper.TestChecks;
var
  dt: TDateTime;
begin
  dt := EncodeDate(2020, 1, 1); // Leap year
  CheckTrue(dt.IsInLeapYear);
  dt := EncodeDate(2023, 1, 1);
  CheckFalse(dt.IsInLeapYear);

  dt := EncodeTime(14, 0, 0, 0);
  CheckTrue(dt.IsPM);
  CheckFalse(dt.IsAM);

  dt := Date;
  CheckTrue(dt.IsToday);
end;

procedure TestDateTimeHelper.TestStartEnd;
var
  dt: TDateTime;
begin
  dt := EncodeDate(2023, 10, 27);
  CheckEquals(EncodeDate(2023, 1, 1), dt.StartOfTheYear);
  CheckEquals(EncodeDate(2023, 12, 31), dt.EndOfTheYear.DateOf); // EndOfTheYear includes time
  CheckEquals(EncodeDate(2023, 10, 1), dt.StartOfTheMonth);
  CheckEquals(EncodeDate(2023, 10, 31), dt.EndOfTheMonth.DateOf);
end;

procedure TestDateTimeHelper.TestParts;
var
  dt: TDateTime;
begin
  dt := EncodeDate(2023, 1, 1);
  CheckEquals(1, dt.DayOfTheYear);
end;

procedure TestDateTimeHelper.TestBetween;
var
  dt1, dt2: TDateTime;
begin
  dt1 := EncodeDate(2023, 1, 1);
  dt2 := EncodeDate(2024, 1, 1);
  CheckEquals(-1, dt1.YearsBetween(dt2));
  CheckEquals(-12, dt1.MonthsBetween(dt2));
  CheckEquals(-365, dt1.DaysBetween(dt2));
end;

procedure TestDateTimeHelper.TestSpan;
var
  dt1, dt2: TDateTime;
begin
  dt1 := EncodeDate(2023, 1, 1);
  dt2 := EncodeDate(2023, 1, 2);
  CheckEquals(1.0, dt1.DaySpan(dt2), 0.001);
end;

procedure TestDateTimeHelper.TestInc;
var
  dt: TDateTime;
begin
  dt := EncodeDate(2023, 1, 1);
  CheckEquals(EncodeDate(2024, 1, 1), dt.IncYear(1));
  CheckEquals(EncodeDate(2023, 2, 1), dt.IncMonth(1));
  CheckEquals(EncodeDate(2023, 1, 2), dt.IncDay(1));
end;

procedure TestDateTimeHelper.TestRecoded;
var
  dt: TDateTime;
begin
  dt := EncodeDate(2023, 1, 1);
  CheckEquals(EncodeDate(2024, 1, 1), dt.RecodedYear(2024));
end;

procedure TestDateTimeHelper.TestEncodeDecode;
var
  dt: TDateTime;
  Y, M, D, H, N, S, MS: Word;
begin
  dt := EncodeDateTime(2023, 10, 27, 14, 30, 45, 500);
  dt.DecodeDateTime(Y, M, D, H, N, S, MS);
  CheckEquals(2023, Y);
  CheckEquals(10, M);
  CheckEquals(27, D);
  CheckEquals(14, H);
  CheckEquals(30, N);
  CheckEquals(45, S);
  CheckEquals(500, MS);
end;

procedure TestDateTimeHelper.TestNames;
var
  dt: TDateTime;
begin
  dt := EncodeDate(2023, 1, 1); // Sunday
  CheckNotEquals('', dt.LongDayName);
  CheckNotEquals('', dt.ShortDayName);
  CheckNotEquals('', dt.LongMonthName);
  CheckNotEquals('', dt.ShortMonthName);
end;

procedure TestDateTimeHelper.TestMaxMin;
var
  dt1, dt2: TDateTime;
begin
  dt1 := EncodeDate(2023, 1, 1);
  dt2 := EncodeDate(2024, 1, 1);
  CheckEquals(dt2, dt1.Max(dt2));
  CheckEquals(dt1, dt1.Min(dt2));
end;

procedure TestDateTimeHelper.TestStaticCreators;
begin
  CheckEquals(Date, TDateTime.Today);
  TDateTime.Now;
  TDateTime.Yesterday;
  TDateTime.Tomorrow;
end;



type
  TestDateHelper = class(TTestCase)
  published
    procedure TestProperties;
    procedure TestToString;
    procedure TestChecks;
    procedure TestStartEnd;
    procedure TestParts;
    procedure TestBetween;
    procedure TestSpan;
    procedure TestInc;
    procedure TestRecoded;
    procedure TestEncodeDecode;
    procedure TestNames;
    procedure TestMaxMin;
    procedure TestStaticCreators;
  end;

procedure TestDateHelper.TestProperties;
var
  d: TDate;
begin
  d := EncodeDate(2023, 10, 27);
  CheckEquals(2023, d.Year);
  CheckEquals(10, d.Month);
  CheckEquals(27, d.Day);

  d.Year := 2024;
  CheckEquals(2024, d.Year);
end;

procedure TestDateHelper.TestToString;
var
  d: TDate;
begin
  d := EncodeDate(2023, 1, 1);
  CheckNotEquals('', d.ToString);
  CheckNotEquals('', d.ToString('yyyy-mm-dd'));
  CheckNotEquals('', d.ToSQLString);
end;

procedure TestDateHelper.TestChecks;
var
  d: TDate;
begin
  d := EncodeDate(2020, 1, 1); // Leap year
  CheckTrue(d.IsInLeapYear);
  d := EncodeDate(2023, 1, 1);
  CheckFalse(d.IsInLeapYear);

  d := Date;
  CheckTrue(d.IsToday);
end;

procedure TestDateHelper.TestStartEnd;
var
  d: TDate;
begin
  d := EncodeDate(2023, 10, 27);
  CheckEquals(EncodeDate(2023, 1, 1), d.StartOfTheYear);
  CheckEquals(EncodeDate(2023, 12, 31), d.EndOfTheYear);
  CheckEquals(EncodeDate(2023, 10, 1), d.StartOfTheMonth);
  CheckEquals(EncodeDate(2023, 10, 31), d.EndOfTheMonth);
end;

procedure TestDateHelper.TestParts;
var
  d: TDate;
begin
  d := EncodeDate(2023, 1, 1);
  CheckEquals(1, d.DayOfTheYear);
end;

procedure TestDateHelper.TestBetween;
var
  d1, d2: TDate;
begin
  d1 := EncodeDate(2024, 1, 1);
  d2 := EncodeDate(2023, 1, 1);
  CheckEquals(1, d1.YearsBetween(d2));
  CheckEquals(12, d1.MonthsBetween(d2));
  CheckEquals(365, d1.DaysBetween(d2));
end;

procedure TestDateHelper.TestSpan;
var
  d1, d2: TDate;
begin
  d1 := EncodeDate(2023, 1, 1);
  d2 := EncodeDate(2023, 1, 8);
  CheckEquals(1.0, d1.WeekSpan(d2), 0.001);
end;

procedure TestDateHelper.TestInc;
var
  d: TDate;
begin
  d := EncodeDate(2023, 1, 1);
  CheckEquals(EncodeDate(2024, 1, 1), d.IncYear(1));
  CheckEquals(EncodeDate(2023, 2, 1), d.IncMonth(1));
  CheckEquals(EncodeDate(2023, 1, 2), d.IncDay(1));
end;

procedure TestDateHelper.TestRecoded;
var
  d: TDate;
begin
  d := EncodeDate(2023, 1, 1);
  CheckEquals(EncodeDate(2024, 1, 1), d.RecodedYear(2024));
end;

procedure TestDateHelper.TestEncodeDecode;
var
  dt: TDate;
  Y, M, D: Word;
begin
  dt := EncodeDate(2023, 10, 27);
  dt.DecodeDate(Y, M, D);
  CheckEquals(2023, Y);
  CheckEquals(10, M);
  CheckEquals(27, D);
end;

procedure TestDateHelper.TestNames;
var
  d: TDate;
begin
  d := EncodeDate(2023, 1, 1); // Sunday
  CheckNotEquals('', d.LongDayName);
  CheckNotEquals('', d.ShortDayName);
  CheckNotEquals('', d.LongMonthName);
  CheckNotEquals('', d.ShortMonthName);
end;

procedure TestDateHelper.TestMaxMin;
var
  d1, d2: TDate;
begin
  d1 := EncodeDate(2023, 1, 1);
  d2 := EncodeDate(2024, 1, 1);
  CheckEquals(d2, d1.Max(d2));
  CheckEquals(d1, d1.Min(d2));
end;

procedure TestDateHelper.TestStaticCreators;
begin
  CheckEquals(Date, TDate.Today);
  TDate.Yesterday;
  TDate.Tomorrow;
  CheckTrue(TDate.IsValidDate(2023, 1, 1));
  CheckFalse(TDate.IsValidDate(2023, 2, 30));
end;




type
  TestInt64Helper = class(TTestCase)
  published
    procedure TestIsDividableBy;
    procedure TestIsOdd;
    procedure TestIsEven;
    procedure TestSqr;
    procedure TestPower;
    procedure TestIsPositive;
    procedure TestIsNegative;
    procedure TestIsNonNegative;
    procedure TestMaxMin;
    procedure TestAbs;
    procedure TestToString;
    procedure TestToSQLString;
    procedure TestRound;
    procedure TestBetween;
    procedure TestIncreaseDecrease;
    procedure TestReplaced;
    procedure TestToNumeralSystem;
    procedure TestNumeralSystems;
    procedure TestSetBinary;
    procedure TestSetOctal;
    procedure TestSetHexidecimal;
    procedure TestSetNumeralSystem32;
    procedure TestSetNumeralSystem64;
    procedure TestForLoop;
    procedure TestIsPrime;
    procedure TestRandom;
    procedure TestRandomPrime;
    procedure TestSetRandom;
    procedure TestSetRandomPrime;
    procedure TestToBoolean;
    procedure TestToHexString;
    procedure TestToSingle;
    procedure TestToDouble;
    procedure TestToExtended;
    procedure TestSize;
    procedure TestParse;
    procedure TestTryParse;
    procedure TestConstants;
  end;

procedure TestInt64Helper.TestIsDividableBy;
var
  i: Int64;
begin
  i := 10;
  CheckTrue(i.IsDividableBy(2));
  CheckTrue(i.IsDividableBy(5));
  CheckFalse(i.IsDividableBy(3));
end;

procedure TestInt64Helper.TestIsOdd;
var
  i: Int64;
begin
  i := 5;
  CheckTrue(i.IsOdd);
  i := 10;
  CheckFalse(i.IsOdd);
end;

procedure TestInt64Helper.TestIsEven;
var
  i: Int64;
begin
  i := 10;
  CheckTrue(i.IsEven);
  i := 5;
  CheckFalse(i.IsEven);
end;

procedure TestInt64Helper.TestSqr;
var
  i: Int64;
begin
  i := 5;
  CheckEquals(25, i.Sqr);
end;

procedure TestInt64Helper.TestPower;
var
  i: Int64;
begin
  i := 2;
  CheckEquals(8, i.Power(3));
  CheckEquals(8.0, i.Power(Int64(3)), 0.001);
end;

procedure TestInt64Helper.TestIsPositive;
var
  i: Int64;
begin
  i := 5;
  CheckTrue(i.IsPositive);
  i := -5;
  CheckFalse(i.IsPositive);
  i := 0;
  CheckFalse(i.IsPositive);
end;

procedure TestInt64Helper.TestIsNegative;
var
  i: Int64;
begin
  i := -5;
  CheckTrue(i.IsNegative);
  i := 5;
  CheckFalse(i.IsNegative);
  i := 0;
  CheckFalse(i.IsNegative);
end;

procedure TestInt64Helper.TestIsNonNegative;
var
  i: Int64;
begin
  i := 5;
  CheckTrue(i.IsNonNegative);
  i := 0;
  CheckTrue(i.IsNonNegative);
  i := -5;
  CheckFalse(i.IsNonNegative);
end;

procedure TestInt64Helper.TestMaxMin;
var
  i: Int64;
begin
  i := 10;
  CheckEquals(15, i.Max(15));
  CheckEquals(10, i.Max(5));
  CheckEquals(5, i.Min(5));
  CheckEquals(10, i.Min(15));
end;

procedure TestInt64Helper.TestAbs;
var
  i: Int64;
begin
  i := -5;
  CheckEquals(5, i.Abs);
  i := 5;
  CheckEquals(5, i.Abs);
end;

procedure TestInt64Helper.TestToString;
var
  i: Int64;
begin
  i := 123;
  CheckEquals('123', i.ToString);
  CheckEquals('123', i.ToSQLString);
end;

procedure TestInt64Helper.TestBetween;
var
  i: Int64;
begin
  i := 10;
  CheckTrue(i.Between(5, 15));
  CheckTrue(i.Between(10, 15));
  CheckTrue(i.Between(5, 10));
  CheckFalse(i.Between(11, 15));
  CheckFalse(i.Between(1, 9));
end;

procedure TestInt64Helper.TestIncreaseDecrease;
var
  i: Int64;
begin
  i := 10;
  CheckEquals(15, i.Increased(5));
  CheckEquals(5, i.Decreased(5));
  CheckEquals(11, i.Increased);
  CheckEquals(9, i.Decreased);
end;

procedure TestInt64Helper.TestReplaced;
var
  i: Int64;
begin
  i := 10;
  CheckEquals(20, i.Replaced(10, 20));
  CheckEquals(10, i.Replaced(15, 20));
end;

procedure TestInt64Helper.TestNumeralSystems;
var
  i: Int64;
begin
  i := 255;
  CheckEquals('11111111', i.Binary);
  CheckEquals('377', i.Octal);
  CheckEquals('FF', i.Hexidecimal);
  CheckNotEquals('', i.NumeralSystem32);
  CheckNotEquals('', i.NumeralSystem64);
end;

procedure TestInt64Helper.TestIsPrime;
var
  i: Int64;
begin
  i := 2;
  CheckTrue(i.IsPrime);
  i := 3;
  CheckTrue(i.IsPrime);
  i := 5;
  CheckTrue(i.IsPrime);
  i := 7;
  CheckTrue(i.IsPrime);
  i := 4;
  CheckFalse(i.IsPrime);
  i := 6;
  CheckFalse(i.IsPrime);
  i := 9;
  CheckFalse(i.IsPrime);
end;

procedure TestInt64Helper.TestRandom;
var
  i: Int64;
begin
  i := Int64.Random(100);
  CheckTrue(i >= 0);
  CheckTrue(i <= 100);

  i := Int64.Random(10, 20);
  CheckTrue(i >= 10);
  CheckTrue(i <= 20);
end;

procedure TestInt64Helper.TestToSQLString;
var
  i: Int64;
begin
  i := 123456789012345;
  CheckEquals('123456789012345', i.ToSQLString);
  i := -999;
  CheckEquals('-999', i.ToSQLString);
end;

procedure TestInt64Helper.TestRound;
var
  i: Int64;
begin
  i := 12355;
  CheckEquals(12360, i.Round(1));

  i := 12345;
  CheckEquals(12340, i.Round(1)); //Banker's round
  CheckEquals(12300, i.Round(2));
  CheckEquals(12000, i.Round(3));
end;

procedure TestInt64Helper.TestToNumeralSystem;
var
  i: Int64;
begin
  i := 10;
  CheckEquals('1010', i.ToNumeralSystem(2));
  CheckEquals('12', i.ToNumeralSystem(8));
  CheckEquals('A', i.ToNumeralSystem(16));
end;

procedure TestInt64Helper.TestSetBinary;
var
  i: Int64;
begin
  i := 0;
  i.SetBinary('1010');
  CheckEquals(10, i);
  i.SetBinary('11111111');
  CheckEquals(255, i);
end;

procedure TestInt64Helper.TestSetOctal;
var
  i: Int64;
begin
  i := 0;
  i.SetOctal('12');
  CheckEquals(10, i);
  i.SetOctal('377');
  CheckEquals(255, i);
end;

procedure TestInt64Helper.TestSetHexidecimal;
var
  i: Int64;
begin
  i := 0;
  i.SetHexidecimal('A');
  CheckEquals(10, i);
  i.SetHexidecimal('FF');
  CheckEquals(255, i);
end;

procedure TestInt64Helper.TestSetNumeralSystem32;
var
  i: Int64;
begin
  i := 0;
  i.SetNumeralSystem32('10');
  CheckEquals(32, i);
end;

procedure TestInt64Helper.TestSetNumeralSystem64;
var
  i: Int64;
begin
  i := 0;
  i.SetNumeralSystem64('10');
  CheckEquals(64, i);
end;

procedure TestInt64Helper.TestForLoop;
var
  i: Int64;
  Sum: Int64;
begin
  i := 0;
  Sum := 0;
  i.ForLoop(1, 5, procedure begin Inc(Sum); end);
  CheckEquals(5, Sum);

  Sum := 0;
  i.ForLoop(1, 10, procedure begin Inc(Sum); end);
  CheckEquals(10, Sum);
end;

procedure TestInt64Helper.TestRandomPrime;
var
  i: Int64;
begin
  i := Int64.RandomPrime(100);
  CheckTrue(i.IsPrime);
  CheckTrue(i <= 100);

  i := Int64.RandomPrime(10, 50);
  CheckTrue(i.IsPrime);
  CheckTrue(i >= 10);
  CheckTrue(i <= 50);
end;

procedure TestInt64Helper.TestSetRandom;
var
  i: Int64;
begin
  i := 0;
  i.SetRandom(100);
  CheckTrue(i <= 100);

  i := 0;
  i.SetRandom(50, 100);
  CheckTrue(i >= 50);
  CheckTrue(i <= 100);
end;

procedure TestInt64Helper.TestSetRandomPrime;
var
  i: Int64;
begin
  i := 0;
  i.SetRandomPrime(100);
  CheckTrue(i.IsPrime);
  CheckTrue(i <= 100);

  i := 0;
  i.SetRandomPrime(10, 50);
  CheckTrue(i.IsPrime);
  CheckTrue(i >= 10);
  CheckTrue(i <= 50);
end;

procedure TestInt64Helper.TestToBoolean;
var
  i: Int64;
begin
  i := 0;
  CheckFalse(i.ToBoolean);
  i := 1;
  CheckTrue(i.ToBoolean);
  i := -1;
  CheckTrue(i.ToBoolean);
  i := 100;
  CheckTrue(i.ToBoolean);
end;

procedure TestInt64Helper.TestToHexString;
var
  i: Int64;
begin
  i := 255;
  CheckEquals('00000000000000FF', i.ToHexString);
  i := 16;
  CheckEquals('0000000000000010', i.ToHexString);
  i := 255;
  CheckEquals('00FF', i.ToHexString(4));
end;

procedure TestInt64Helper.TestToSingle;
var
  i: Int64;
  s: Single;
begin
  i := 123;
  s := i.ToSingle;
  CheckEquals(123.0, s, 0.01);
end;

procedure TestInt64Helper.TestToDouble;
var
  i: Int64;
  d: Double;
begin
  i := 123456789;
  d := i.ToDouble;
  CheckEquals(123456789.0, d, 0.01);
end;

procedure TestInt64Helper.TestToExtended;
var
  i: Int64;
  e: Extended;
begin
  i := 123456789012;
  e := i.ToExtended;
  CheckEquals(123456789012.0, e, 0.01);
end;

procedure TestInt64Helper.TestSize;
begin
  CheckEquals(8, Int64.Size);
end;

procedure TestInt64Helper.TestParse;
var
  i: Int64;
begin
  i := Int64.Parse('12345678901234');
  CheckEquals(12345678901234, i);
  i := Int64.Parse('-999');
  CheckEquals(-999, i);
end;

procedure TestInt64Helper.TestTryParse;
var
  i: Int64;
  success: Boolean;
begin
  success := Int64.TryParse('12345678901234', i);
  CheckTrue(success);
  CheckEquals(12345678901234, i);

  success := Int64.TryParse('invalid', i);
  CheckFalse(success);
end;

procedure TestInt64Helper.TestConstants;
begin
  CheckEquals(9223372036854775807, Int64.MaxValue);
  CheckTrue(Int64.MinValue < 0);
end;

type
  TestStringHelper = class(TTestCase)
  published
    procedure TestIsEmptyStr;
    procedure TestLength;
    procedure TestSubstring;
    procedure TestLeftStr;
    procedure TestRightStr;
    procedure TestContainsStr;
    procedure TestPos;
    procedure TestReplace;
    procedure TestToLower;
    procedure TestToUpper;
    procedure TestTrim;
    procedure TestTrimLeft;
    procedure TestTrimRight;
    procedure TestStartsStr;
    procedure TestEndsStr;
    procedure TestReversedString;
    procedure TestHashStr;
    procedure TestCompressed;
    procedure TestDecompressed;
    procedure TestExtractedFileName;
    procedure TestExtractedFileExt;
    procedure TestFormated;
    procedure TestFindTagStr;
    procedure TestLike;
    procedure TestSameStr;
    procedure TestSameText;
    procedure TestToInt;
    procedure TestTryToInt;
    procedure TestLineCount;
    procedure TestMatchStr;
    procedure TestPosEx;
    procedure TestOccurrencesCount;
    procedure TestMidStr;
    procedure TestReplacedText;
    procedure TestTrimmed;
    procedure TestTrimmedLeft;
    procedure TestTrimmedRight;
    procedure TestLeadingZerosAdded;
    procedure TestInserted;
    procedure TestDeleted;
    procedure TestDigitsOnly;
    procedure TestNoDigits;
    procedure TestSpacesRemoved;
    procedure TestQuotedStr;
    procedure TestInitCaps;
    procedure TestAlphanumericsOnly;
    procedure TestRepeatedString;
    procedure TestLineAdded;
    procedure TestTrailingPathDelimiterIncluded;
    procedure TestTrailingPathDelimiterExcluded;
    procedure TestRandomString;
    procedure TestGetLine;
    procedure TestCSVFieldValue;
    procedure TestSetParam;
    procedure TestLinesProperty;
    procedure TestCSVProperty;
    procedure TestJSONProperty;
    procedure JSONString;
    procedure TestFileAndPathOperations;
    procedure TestLineOperations;
    procedure TestCSVOperations;
    procedure TestSearchAndMatching;
    procedure TestTextManipulation;
    procedure TestConversion;
    procedure TestProperties;
    procedure TestCaseConversion;
    procedure TestLastDelimiterPosition;
    procedure TestHash;
    procedure TestToSQLString;
    procedure TestReplacedFirstText;
    procedure TestPosLastEx;
  end;

procedure TestStringHelper.TestIsEmptyStr;
var
  s: string;
begin
  s := '';
  CheckTrue(s.IsEmptyStr());
  s := 'hello';
  CheckFalse(s.IsEmptyStr());
end;

procedure TestStringHelper.TestLength;
var
  s: string;
begin
  s := 'hello';
  CheckEquals(5, Integer(s.Length()));
end;

procedure TestStringHelper.TestSubstring;
var
  s: string;
begin
  s := 'hello world';
  CheckEquals('lo world', s.Substring(4));
  CheckEquals('lo', s.Substring(4, 2));
end;

procedure TestStringHelper.TestLeftStr;
var
  s: string;
begin
  s := 'hello';
  CheckEquals('hel', s.LeftStr(3));
end;

procedure TestStringHelper.TestRightStr;
var
  s: string;
begin
  s := 'hello';
  CheckEquals('llo', s.RightStr(3));
end;

procedure TestStringHelper.TestContainsStr;
var
  s: string;
begin
  s := 'hello world';
  CheckTrue(s.ContainsStr('world'));
  CheckFalse(s.ContainsStr('foo'));
end;

procedure TestStringHelper.TestPos;
var
  s: string;
begin
  s := 'hello world';
  CheckEquals(7, Integer(s.Pos('world')));
  CheckTrue(s.Pos('foo') = 0);
end;

procedure TestStringHelper.TestReplace;
var
  s: string;
begin
  s := 'hello world';
  CheckEquals('hello universe', s.Replace('world', 'universe'));
end;

procedure TestStringHelper.TestToLower;
var
  s: string;
begin
  s := 'HELLO';
  CheckEquals('hello', s.LowerCase());
end;

procedure TestStringHelper.TestToUpper;
var
  s: string;
begin
  s := 'hello';
  CheckEquals('HELLO', s.UpperCase());
end;

procedure TestStringHelper.TestTrim;
var
  s: string;
begin
  s := '  hello  ';
  CheckEquals('hello', s.Trim());
end;

procedure TestStringHelper.TestTrimLeft;
var
  s: string;
begin
  s := '  hello';
  CheckEquals('hello', s.TrimLeft());
end;

procedure TestStringHelper.TestTrimRight;
var
  s: string;
begin
  s := 'hello  ';
  CheckEquals('hello', s.TrimRight());
end;

procedure TestStringHelper.TestStartsStr;
var
  s: string;
begin
  s := 'hello world';
  CheckTrue(s.StartsStr('hello'));
  CheckFalse(s.StartsStr('world'));
end;

procedure TestStringHelper.TestEndsStr;
var
  s: string;
begin
  s := 'hello world';
  CheckTrue(s.EndsStr('world'));
  CheckFalse(s.EndsStr('hello'));
end;

procedure TestStringHelper.TestReversedString;
var
  s: string;
begin
  s := 'hello';
  CheckEquals('olleh', s.ReversedString());
end;

procedure TestStringHelper.TestHashStr;
var
  s: string;
begin
  s := 'test';
  CheckNotEquals('', s.HashStr());
  CheckNotEquals('', s.HashStr('salt'));
end;

procedure TestStringHelper.TestCompressed;
var
  s: string;
begin
  s := 'hello world';
  CheckNotEquals('', s.Compressed());
end;

procedure TestStringHelper.TestDecompressed;
var
  s: string;
begin
  s := 'hello world';
  CheckEquals('hello world', s.Compressed().Decompressed());
end;

procedure TestStringHelper.TestExtractedFileName;
var
  s: string;
begin
  s := 'C:\path\to\file.txt';
  CheckEquals('file.txt', s.ExtractedFileName());
end;

procedure TestStringHelper.TestExtractedFileExt;
var
  s: string;
begin
  s := 'file.txt';
  CheckEquals('.txt', s.ExtractedFileExt());
end;

procedure TestStringHelper.TestFormated;
var
  s: string;
begin
  s := 'Value: %d';
  CheckEquals('Value: 42', s.Formated([42]));
end;

procedure TestStringHelper.TestFindTagStr;
var
  s: string;
begin
  s := '<tag>content</tag>';
  CheckEquals('content', s.FindTagStr('tag'));
end;

procedure TestStringHelper.TestLike;
var
  s: string;
begin
  s := 'hello';
  CheckTrue(s.Like('h%'));
  CheckFalse(s.Like('x%'));
end;

procedure TestStringHelper.TestSameStr;
var
  s: string;
begin
  s := 'hello';
  CheckTrue(s.SameStr('hello'));
  CheckFalse(s.SameStr('HELLO'));
end;

procedure TestStringHelper.TestSameText;
var
  s: string;
begin
  s := 'hello';
  CheckTrue(s.SameText('HELLO'));
  CheckFalse(s.SameText('world'));
end;

procedure TestStringHelper.TestToInt;
var
  s: string;
begin
  s := '123';
  CheckEquals(123, Integer(s.ToInt()));
end;

procedure TestStringHelper.TestTryToInt;
var
  s: string;
  i: Integer;
begin
  s := '123';
  CheckTrue(s.TryToInt());
  CheckTrue(s.TryToInt(i));
  CheckEquals(123, i);

  s := 'abc';
  CheckFalse(s.TryToInt());
end;

procedure TestStringHelper.TestLineCount;
var
  s: string;
begin
  s := 'line1'#13#10'line2'#13#10'line3';
  CheckEquals(3, Integer(s.LineCount()));
end;

procedure TestStringHelper.TestMatchStr;
var
  s: string;
begin
  s := 'hello';
  CheckTrue(s.MatchStr(['hello', 'world']));
  CheckFalse(s.MatchStr(['hi', 'world']));
end;

procedure TestStringHelper.TestPosEx;
var
  s: string;
begin
  s := 'hello hello';
  CheckEquals(7, Integer(s.PosEx('hello', 2)));
end;

procedure TestStringHelper.TestOccurrencesCount;
var
  s: string;
begin
  s := 'hello hello hello';
  CheckEquals(3, Integer(s.OccurrencesCount('hello')));
end;

procedure TestStringHelper.TestMidStr;
var
  s: string;
begin
  s := 'hello world';
  CheckEquals('lo wo', s.MidStr(4, 5));
end;

procedure TestStringHelper.TestReplacedText;
var
  s: string;
begin
  s := 'Hello World';
  CheckEquals('Hi World', s.ReplacedText('Hello', 'Hi'));
end;

procedure TestStringHelper.TestTrimmed;
var
  s: string;
begin
  s := '  hello  ';
  CheckEquals('hello', s.Trimmed());
end;

procedure TestStringHelper.TestTrimmedLeft;
var
  s: string;
begin
  s := '  hello';
  CheckEquals('hello', s.TrimmedLeft());
end;

procedure TestStringHelper.TestTrimmedRight;
var
  s: string;
begin
  s := 'hello  ';
  CheckEquals('hello', s.TrimmedRight());
end;

procedure TestStringHelper.TestLeadingZerosAdded;
var
  s: string;
begin
  s := '123';
  CheckEquals('00123', s.LeadingZerosAdded(5));
end;

procedure TestStringHelper.TestInserted;
var
  s: string;
begin
  s := 'hello';
  CheckEquals('he inserted llo', s.Inserted(' inserted ', 3));
end;

procedure TestStringHelper.TestDeleted;
var
  s: string;
begin
  s := 'hello world';
  CheckEquals('helo world', s.Deleted(4, 1));
end;

procedure TestStringHelper.TestDigitsOnly;
var
  s: string;
begin
  s := 'abc123def456';
  CheckEquals('123456', s.DigitsOnly());
end;

procedure TestStringHelper.TestNoDigits;
var
  s: string;
begin
  s := 'abc123def456';
  CheckEquals('abcdef', s.NoDigits());
end;

procedure TestStringHelper.TestSpacesRemoved;
var
  s: string;
begin
  s := 'a b c';
  CheckEquals('abc', s.SpacesRemoved());
end;

procedure TestStringHelper.TestQuotedStr;
var
  s: string;
begin
  s := 'hello';
  CheckEquals('''hello''', s.QuotedStr());
end;

procedure TestStringHelper.TestInitCaps;
var
  s: string;
begin
  s := 'hello world';
  CheckEquals('Hello World', s.InitCaps());
end;

procedure TestStringHelper.TestAlphanumericsOnly;
var
  s: string;
begin
  s := 'abc123!@#';
  CheckEquals('abc123', s.AlphanumericsOnly());
end;

procedure TestStringHelper.TestRepeatedString;
var
  s: string;
begin
  s := 'ha';
  CheckEquals('hahaha', s.RepeatedString(3));
end;

procedure TestStringHelper.TestLineAdded;
var
  s: string;
begin
  s := 'line1';
  CheckEquals('line1'#13#10'line2', s.LineAdded('line2'));
end;

procedure TestStringHelper.TestTrailingPathDelimiterIncluded;
var
  s: string;
begin
  s := 'C:\path';
  CheckEquals('C:\path\', s.TrailingPathDelimiterIncluded());
end;

procedure TestStringHelper.TestTrailingPathDelimiterExcluded;
var
  s: string;
begin
  s := 'C:\path\';
  CheckEquals('C:\path', s.TrailingPathDelimiterExcluded());
end;

procedure TestStringHelper.TestRandomString;
var
  s: string;
begin
  s := string.RandomString(5);
  CheckEquals(5, Length(s));
end;

procedure TestStringHelper.TestGetLine;
var
  s: string;
begin
  s := 'line1'#13#10'line2'#13#10'line3';
  CheckEquals('line2', s.GetLine(1));
end;

procedure TestStringHelper.TestCSVFieldValue;
var
  s: string;
begin
  s := 'field1;field2;field3';
  CheckEquals('field2', s.CSVFieldValue(1));
end;

procedure TestStringHelper.TestSetParam;
var
  s: string;
begin
  s := 'Hello :name, you are :age years old';
  s.Params['name'] := 'John';
  s.Params['age'] := '30';
  Check(s = 'Hello John, you are 30 years old');

  s := 'Hello :Param, you are :Param2 years old';
  s.Params['Param'] := 'John';
  s.Params['Param2'] := '30';
  Check(s = 'Hello John, you are 30 years old');
end;

procedure TestStringHelper.TestLinesProperty;
var
  s: string;
begin
  s := 'line1'#13#10'line2';
  CheckEquals('line2', string(s.Lines[1]));
  s.Lines[1] := 'new line2';
  CheckEquals('new line2', string(s.Lines[1]));
end;

procedure TestStringHelper.TestCSVProperty;
var
  s: string;
begin
  s := 'field1;field2;field3';
  CheckEquals('field2', string(s.CSV[1]));
  s.CSV[1] := 'new field2';
  CheckEquals('new field2', string(s.CSV[1]));
end;

procedure TestStringHelper.TestJSONProperty;
var
  s: string;
begin
  s := '{"key":"value"}';
  CheckEquals('value', string(s.JSON['key']));
  s.JSON['key'] := 'new value';
  CheckEquals('new value', string(s.JSON['key']));
end;

procedure TestStringHelper.JSONString;
var
  s: string;
begin
  s := '{"name":"John","age":30,"city":"NYC"}';
  Check(s.JSON['name'] = 'John');
  Check(s.JSON['age'] = '30');
  Check(s.JSON['city'] = 'NYC');

  s.JSON['name'] := 'Jane';
  Check(s.JSON['name'] = 'Jane');

  s := '{"User":{"name":"John","age":30,"city":"NYC"}}';
  Check(s.JSON['User.name'] = 'John');
  Check(s.JSON['User.age'] = '30');
  Check(s.JSON['User.city'] = 'NYC');

  s.JSON['User.name'] := 'Jane';
  Check(s.JSON['User.name'] = 'Jane');


  s :='{"People":[{"name":"John"},{"name":"Anna"},{"name":"Nick"}]}';
  Check(s.JSON['People[0].name'] = 'John');
  Check(s.JSON['People[1].name'] = 'Anna');
  Check(s.JSON['People[2].name'] = 'Nick');

  s.JSON['People[1].name'] := 'Joanna';
  Check(s.JSON['People[1].name'] = 'Joanna');
  Check(s = '{"People":[{"name":"John"},{"name":"Joanna"},{"name":"Nick"}]}');

  s.JSON['People[3].name'] := 'Kate';
  s.JSON['People[3].age'] := 15;

  Check(s = '{"People":[{"name":"John"},{"name":"Joanna"},{"name":"Nick"},{"name":"Kate","age":15}]}');
end;

procedure TestStringHelper.TestFileAndPathOperations;
var
  s: string;
begin
  s := 'C:\MyDir\MyFile.txt';
  CheckEquals('MyFile.txt', s.ExtractedFileName, 'ExtractedFileName');
  CheckEquals('.txt', s.ExtractedFileExt, 'ExtractedFileExt');
end;

procedure TestStringHelper.TestLineOperations;
var
  s: string;
begin
  s := 'Line1' + sLineBreak + 'Line2';
  CheckEquals(2, s.LineCount, 'LineCount');
  CheckEquals('Line1', s.GetLine(0), 'GetLine(0)');
  CheckEquals('Line2', s.GetLine(1), 'GetLine(1)');

  s.LineAdd('Line3');
  CheckEquals(3, s.LineCount, 'LineAdd');
  CheckEquals('Line3', s.GetLine(2), 'LineAdd content');

  s.LineDelete(1); // Deletes 'Line2'
  CheckEquals(2, s.LineCount, 'LineDelete');
  CheckEquals('Line3', s.GetLine(1), 'LineDelete content shift');
end;

procedure TestStringHelper.TestCSVOperations;
var
  s: string;
begin
  s := 'Val1;Val2;Val3';
  CheckEquals(3, s.CSVFieldCount, 'CSVFieldCount');
  CheckEquals('Val1', s.CSVFieldValue(0), 'CSVFieldValue(1)');
  CheckEquals('Val2', s.CSVFieldValue(1), 'CSVFieldValue(2)');

  s.SetCSVFieldValue(1, 'NewVal2');
  CheckEquals('NewVal2', s.CSVFieldValue(1), 'SetCSVFieldValue');
  CheckEquals('Val1;NewVal2;Val3', s, 'CSV string update');
end;

procedure TestStringHelper.TestSearchAndMatching;
var
  s: string;
begin
  s := 'Hello World';
  CheckTrue(s.ContainsText('world'), 'ContainsText (case insensitive)');
  CheckTrue(s.StartsText('he'), 'StartsText (case insensitive)');
  CheckTrue(s.EndsText('LD'), 'EndsText (case insensitive)');
end;

procedure TestStringHelper.TestTextManipulation;
var
  s: string;
  arr: TStringDynArray;
begin
  s := 'A;B;C';
  arr := s.SplitString(';');
  CheckEquals(3, Length(arr), 'SplitString count');
  CheckEquals('A', arr[0], 'SplitString[0]');

  s := '12345';
  CheckEquals('234', s.MidStrEx(2, 4), 'MidStrEx');

  s := '  abc  ';
  CheckEquals('     abc  ', s.LeadingSpacesAdded(10), 'LeadingSpacesAdded');
end;

procedure TestStringHelper.TestConversion;
var
  s: string;
begin
  s := '123';
  CheckEquals(123, s.ToInt64, 'ToInt64');
end;

procedure TestStringHelper.TestProperties;
var
  s: string;
begin
  s := '';
  s.Base64 := 'SGVsbG8='; // "Hello" in Base64
  CheckEquals('SGVsbG8=', s.Base64, 'Base64 Property Read');

  s := 'Hello';
  CheckEquals('SGVsbG8=', s.Base64, 'GetBase64 from "Hello"');

  s.Base64 := 'SGVsbG8=';
  CheckEquals('Hello', s, 'SetBase64 updates Value');
end;

procedure TestStringHelper.TestCaseConversion;
var
  s: string;
begin
  s := 'Hello World';
  CheckEquals('hello world', s.LowerCase, 'LowerCase');
  CheckEquals('HELLO WORLD', s.UpperCase, 'UpperCase');
end;

procedure TestStringHelper.TestLastDelimiterPosition;
var
  s: string;
begin
  s := 'path/to/file';
  CheckEquals(8, s.LastDelimiterPosition('/'), 'LastDelimiterPosition');
end;

procedure TestStringHelper.TestHash;
var
  s: string;
begin
  s := 'test';
  CheckTrue(s.Hash > 0, 'Hash');
end;

procedure TestStringHelper.TestToSQLString;
var
  s: string;
begin
  s := 'O''Neil';
  CheckEquals('''O''''Neil''', s.ToSQLString, 'ToSQLString');
end;

procedure TestStringHelper.TestReplacedFirstText;
var
  s: string;
begin
  s := 'Hello World hello';
  CheckEquals('Hi World hello', s.ReplacedFirstText('HELLO', 'Hi'));
  CheckEquals('Hello World hello', s.ReplacedFirstText('xyz', 'abc'));
end;

procedure TestStringHelper.TestPosLastEx;
var
  s: string;
begin
  s := '12345 hello hello hello';
  CheckEquals(19, Integer(s.PosLastEx('hello', 21)));
  CheckEquals(13, Integer(s.PosLastEx('hello', 16)));
  CheckTrue(s.PosLastEx('hello', 5) = 0);
end;

{$IFEND}

initialization
  {$IF CompilerVersion >= 24.0}
  RegisterTest(TestIntegerHelper.Suite);
  RegisterTest(TestBooleanHelper.Suite);
  RegisterTest(TestDoubleHelper.Suite);
  RegisterTest(TestCurrencyHelper.Suite);
  RegisterTest(TestDateTimeHelper.Suite);
  RegisterTest(TestDateHelper.Suite);
  RegisterTest(TestInt64Helper.Suite);
  RegisterTest(TestStringHelper.Suite);
  {$IFEND}

end.
