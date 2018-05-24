unit OLDoubleType;

interface

uses
  variants, SysUtils, Math, OLBooleanType;

type
  OLDouble = record
  private
    Value: Double;
    NullFlag: string;

    function GetHasValue(): OLBoolean;
    procedure SetHasValue(Value: OLBoolean);
    property ValuePresent: OLBoolean read GetHasValue write SetHasValue;
  public
    function Sqr(): OLDouble;
    function Sqrt(): OLDouble;
    function Power(Exponent: integer): OLDouble;  overload;
    function IsPositive(): OLBoolean;
    function IsNegative(): OLBoolean;
    function IsNonNegative(): OLBoolean;
    function Max(d: OLDouble): OLDouble;
    function Min(d: OLDouble): OLDouble;
    function Abs(): OLDouble;
    function IsNull(): OLBoolean;
    function HasValue(): OLBoolean;
    function ToString(): string; overload;
    function ToString(Digits: integer; Format: TFloatFormat = ffFixed; Precision: integer = 16): string; overload;
    function IfNull(d: OLDouble): OLDouble;

    function Round(const Digits: integer = 0): OLDouble;
    function Floor(): Integer;
    function Ceil(): Integer;

    function Power(Exponent: Extended): OLDouble;  overload;

    function IsNan(): OLBoolean;
    function IsInfinite(): OLBoolean;
    function IsZero(Epsilon: Extended = 0): OLBoolean;

    function InRange(AMin, AMax: Extended): OLBoolean;
    function EnsureRange(AMin, AMax: Extended): Extended;

    function SameValue(const B: Extended; Epsilon: Extended = 0): OLBoolean;

    class function Random(MinValue: Double; MaxValue:Double): OLDouble;  overload; static;
    class function Random(MaxValue:Double = MaxInt): OLDouble;  overload; static;

    class operator Add(a, b: OLDouble): OLDouble;
    class operator Subtract(a, b: OLDouble): OLDouble;
    class operator Multiply(a, b: OLDouble): OLDouble;
    class operator Divide(a, b: OLDouble): OLDouble;

    class operator Implicit(a: Double): OLDouble;
    class operator Implicit(a: OLDouble): Double;
    class operator Implicit(a: Variant): OLDouble;
    class operator Implicit(a: OLDouble): Variant;
    class operator Implicit(a: Integer): OLDouble;

    class operator Implicit(a: Extended): OLDouble;
    class operator Implicit(a: OLDouble): Extended;

    class operator Inc(a: OLDouble): OLDouble;
    class operator Dec(a: OLDouble): OLDouble;
    class operator Negative(a: OLDouble): OLDouble;

    class operator Equal(a, b: OLDouble): OLBoolean;
    class operator NotEqual(a, b: OLDouble): OLBoolean;
    class operator GreaterThan(a, b: OLDouble): OLBoolean;
    class operator GreaterThanOrEqual(a, b: OLDouble): OLBoolean;
    class operator LessThan(a, b: OLDouble): OLBoolean;
    class operator LessThanOrEqual(a, b: OLDouble): OLBoolean;
  end;

implementation

//uses
//  ;

const
  NonEmptyStr = ' ';

function OLDouble.Abs(): OLDouble;
begin
  if Self.ValuePresent then
    Result := System.Abs(Self.Value)
  else
    Result := Null;
end;

class operator OLDouble.Add(a, b: OLDouble): OLDouble;

var
  returnrec: OLDouble;
begin
  returnrec.Value := a.Value + b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLDouble.Ceil: Integer;
begin
  Result := Math.Ceil(Self);
end;

class operator OLDouble.Implicit(a: Double): OLDouble;
var
  OutPut: OLDouble;
begin
  OutPut.Value := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLDouble.Implicit(a: OLDouble): Double;
var
  OutPut: Double;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as double value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLDouble.Dec(a: OLDouble): OLDouble;
begin
  Result := a - 1;
end;

class operator OLDouble.Divide(a, b: OLDouble): OLDouble;
var
  returnrec: OLDouble;
begin
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;

  if returnrec.ValuePresent then
    returnrec.Value := a.Value / b.Value;

  Result := returnrec;
end;

function OLDouble.EnsureRange(AMin, AMax: Extended): Extended;
begin
  Result := Math.EnsureRange(Self, AMin, AMax);
end;

class operator OLDouble.Equal(a, b: OLDouble): OLBoolean;
begin
  Result := (a.ValuePresent and b.ValuePresent and (System.Abs(a.Value - b.Value) < 1e-10)) or (a.IsNull() and b.IsNull());
end;

function OLDouble.Floor: Integer;
begin
  Result := Math.Floor(Self);
end;

function OLDouble.GetHasValue: OLBoolean;
begin
  Result := (NullFlag <> EmptyStr);
end;

class operator OLDouble.GreaterThan(a, b: OLDouble): OLBoolean;
begin
  Result := (a.Value > b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLDouble.GreaterThanOrEqual(a, b: OLDouble): OLBoolean;
begin
  Result := ((a.Value >= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLDouble.HasValue: OLBoolean;
begin
  Result := ValuePresent;
end;

function OLDouble.IfNull(d: OLDouble): OLDouble;
var
  Output: OLDouble;
begin
  if ValuePresent then
    Output := Self
  else
    Output := d;

  Result := Output;
end;

class operator OLDouble.Implicit(a: Variant): OLDouble;
var
  OutPut: OLDouble;
  f: Double;
begin
  if VarIsNull(a) then
    OutPut.ValuePresent := false
  else
  begin
    if TryStrToFloat(a, f) then
    begin
      OutPut.Value := f;
      OutPut.ValuePresent := true;
    end
    else
    begin
      raise Exception.Create('Value ''' + VarToStr(a) + ''' cannot be assigned to variable of OLDouble type.');
    end;
  end;

  Result := OutPut;
end;

class operator OLDouble.Inc(a: OLDouble): OLDouble;
begin
  Result := a + 1;
end;

function OLDouble.InRange(AMin, AMax: Extended): OLBoolean;
begin
  Result := Math.InRange(Self, AMin, AMax);
end;

function OLDouble.IsNull: OLBoolean;
begin
  Result := not ValuePresent;
end;

class operator OLDouble.LessThan(a, b: OLDouble): OLBoolean;
begin
  Result := (a.Value < b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLDouble.LessThanOrEqual(a, b: OLDouble): OLBoolean;
begin
  Result := ((a.Value <= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLDouble.Max(d: OLDouble): OLDouble;
begin
  if (not ValuePresent) or (d.IsNull()) then
    raise Exception.Create('Null value cannot be compared to double.');

  Result := Math.Max(Value, d);
end;

function OLDouble.Min(d: OLDouble): OLDouble;
begin
  if (not ValuePresent) or (d.IsNull) then
    raise Exception.Create('Null value cannot be compared to double.');

  Result := Math.Min(Value, d);
end;


class operator OLDouble.Multiply(a, b: OLDouble): OLDouble;
var
  returnrec: OLDouble;
begin
  returnrec.Value := a.Value * b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLDouble.Negative(a: OLDouble): OLDouble;

var
  b: OLDouble;
begin
  b := -a.Value;
  Result := b;
end;

function OLDouble.IsInfinite: OLBoolean;
begin
  Result := Math.IsInfinite(Self);
end;

function OLDouble.IsNan: OLBoolean;
begin
  Result := Math.IsNan(Self);
end;

function OLDouble.IsNegative: OLBoolean;
begin
  Result := ValuePresent and (Value < 0);
end;

function OLDouble.IsNonNegative: OLBoolean;
begin
  Result := ValuePresent and (Value >= 0);
end;

class operator OLDouble.NotEqual(a, b: OLDouble): OLBoolean;
begin
  Result := ((a.Value <> b.Value) and a.ValuePresent and b.ValuePresent) or (a.ValuePresent <> b.ValuePresent);
end;

function OLDouble.Power(Exponent: Extended): OLDouble;
begin
  Result := Math.Power(Self, Exponent);
end;

function OLDouble.Power(Exponent: integer): OLDouble;
var
  returnrec: OLDouble;
begin
  returnrec.Value := Math.IntPower(Value, Exponent);
  returnrec.ValuePresent := ValuePresent;
  Result := returnrec;
end;


class function OLDouble.Random(MinValue: Double; MaxValue:Double): OLDouble;
begin
  Result := MinValue + system.Random() * (MaxValue - MinValue);
end;

function OLDouble.IsPositive: OLBoolean;
begin
  Result := ValuePresent and (Value > 0);
end;

function OLDouble.IsZero(Epsilon: Extended): OLBoolean;
begin
  Result := Math.IsZero(Self, Epsilon);
end;

function OLDouble.SameValue(const B: Extended; Epsilon: Extended): OLBoolean;
begin
  Result := Math.SameValue(Self, B, Epsilon);
end;

procedure OLDouble.SetHasValue(Value: OLBoolean);
begin
  if Value then
    NullFlag := NonEmptyStr
  else
    NullFlag := EmptyStr;
end;

function OLDouble.Round(const Digits: integer): OLDouble;
begin
  Result := Math.RoundTo(Self, Digits);
end;

function OLDouble.Sqr: OLDouble;
var
  returnrec: OLDouble;
begin
  returnrec.Value := Value * Value;
  returnrec.ValuePresent := ValuePresent;
  Result := returnrec;
end;

function OLDouble.Sqrt: OLDouble;
begin
  Result := System.Sqrt(Self);
end;

class operator OLDouble.Subtract(a, b: OLDouble): OLDouble;

var
  returnrec: OLDouble;
begin
  returnrec.Value := a.Value - b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLDouble.ToString(Digits: integer; Format: TFloatFormat;
  Precision: integer): string;
begin
  Result := FloatToStrF(Self, Format, Precision, Digits);
end;

function OLDouble.ToString: string;
var
  Output: string;
begin
  if ValuePresent then
    Output := FloatToStr(Value)
  else
    Output := '';

  Result := Output;
end;

class function OLDouble.Random(MaxValue: Double): OLDouble;
begin
  Result := OLDouble.Random(0, MaxValue);
end;

class operator OLDouble.Implicit(a: Integer): OLDouble;
var
  OutPut: OLDouble;
begin
  OutPut.Value := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLDouble.Implicit(a: Extended): OLDouble;
var
  OutPut: OLDouble;
begin
  OutPut.Value := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLDouble.Implicit(a: OLDouble): Extended;
var
  OutPut: Double;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as extended value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLDouble.Implicit(a: OLDouble): Variant;
var
  OutPut: Variant;
begin
  if a.ValuePresent then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

end.
