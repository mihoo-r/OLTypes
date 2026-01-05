unit Test_NullPropagation;

interface

uses
  TestFramework,
  OLIntegerType,
  OLDoubleType,
  OLCurrencyType,
  OLBooleanType,
  SysUtils,
  Variants;

type
  TTestNullPropagation = class(TTestCase)
  published
    procedure TestIntegerMaxMin;
    procedure TestDoubleMaxMinSqrt;
    procedure TestCurrencyMaxMin;
    procedure TestInt64MaxMin;
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

  // Test Max with Null Self
  res := c1.Max(c2);
  Check(res.IsNull, 'OLCurrency.Max(Null, Value) should return Null');

  // Test Max with Null Argument
  res := c2.Max(c1);
  Check(res.IsNull, 'OLCurrency.Max(Value, Null) should return Null');

  // Test Min with Null Self
  res := c1.Min(c2);
  Check(res.IsNull, 'OLCurrency.Min(Null, Value) should return Null');

  // Test Min with Null Argument
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

  // Test Max with Null Self
  res := d1.Max(d2);
  Check(res.IsNull, 'OLDouble.Max(Null, Value) should return Null');

  // Test Max with Null Argument
  res := d2.Max(d1);
  Check(res.IsNull, 'OLDouble.Max(Value, Null) should return Null');

  // Test Min with Null Self
  res := d1.Min(d2);
  Check(res.IsNull, 'OLDouble.Min(Null, Value) should return Null');

  // Test Min with Null Argument
  res := d2.Min(d1);
  Check(res.IsNull, 'OLDouble.Min(Value, Null) should return Null');

  // Test Sqrt with Null Self
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

  // Test Max with Null Self
  res := i1.Max(i2);
  Check(res.IsNull, 'OLInt64.Max(Null, Value) should return Null');

  // Test Max with Null Argument
  res := i2.Max(i1);
  Check(res.IsNull, 'OLInt64.Max(Value, Null) should return Null');

  // Test Min with Null Self
  res := i1.Min(i2);
  Check(res.IsNull, 'OLInt64.Min(Null, Value) should return Null');

  // Test Min with Null Argument
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

  // Test Max with Null Self
  res := i1.Max(i2);
  Check(res.IsNull, 'OLInteger.Max(Null, Value) should return Null');

  // Test Max with Null Argument
  res := i2.Max(i1);
  Check(res.IsNull, 'OLInteger.Max(Value, Null) should return Null');

  // Test Min with Null Self
  res := i1.Min(i2);
  Check(res.IsNull, 'OLInteger.Min(Null, Value) should return Null');

  // Test Min with Null Argument
  res := i2.Min(i1);
  Check(res.IsNull, 'OLInteger.Min(Value, Null) should return Null');
end;

initialization
  RegisterTest(TTestNullPropagation.Suite);

end.
