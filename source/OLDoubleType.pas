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
    procedure SetHasValue(const Value: OLBoolean);
    property ValuePresent: OLBoolean read GetHasValue write SetHasValue;
  public
    function Sqr(): OLDouble;
    function Sqrt(): OLDouble;
    function Power(const Exponent: integer): OLDouble;  overload;
    function IsPositive(): OLBoolean;
    function IsNegative(): OLBoolean;
    function IsNonNegative(): OLBoolean;
    function Max(const d: OLDouble): OLDouble;
    function Min(const d: OLDouble): OLDouble;
    function Abs(): OLDouble;
    function IsNull(): OLBoolean;
    function HasValue(): OLBoolean;
    function ToString(): string; overload;
    function ToString(const Digits: integer; const Format: TFloatFormat = ffFixed; const Precision: integer = 16): string; overload;
    function ToString(ThousandSeparator: Char; DecimalSeparator: Char = '.'; Format: string = '###,###,###,##0.##'): string; overload;
    function ToSQLString(): string;
    function IfNull(const d: OLDouble): OLDouble;

    function Round(const PowerOfTen: integer): OLDouble; overload;
    function Round(): Integer; overload;
    function Floor(): Integer;
    function Ceil(): Integer;

    function Power(const Exponent: Extended): OLDouble;  overload;

    function IsNan(): OLBoolean;
    function IsInfinite(): OLBoolean;
    function IsZero(const Epsilon: Extended = 0): OLBoolean;

    function InRange(const AMin, AMax: Extended): OLBoolean;
    function EnsureRange(const AMin, AMax: Extended): Extended;

    function SameValue(const B: Extended; const Epsilon: Extended = 0): OLBoolean;

    class function Random(const MinValue: Double; const MaxValue:Double): OLDouble;  overload; static;
    class function Random(const MaxValue:Double = MaxInt): OLDouble;  overload; static;

    class operator Add(const a, b: OLDouble): OLDouble;
    class operator Subtract(const a, b: OLDouble): OLDouble;
    class operator Multiply(const a, b: OLDouble): OLDouble;
    class operator Divide(const a, b: OLDouble): OLDouble;

    class operator Implicit(const a: Double): OLDouble;
    class operator Implicit(const a: OLDouble): Double;
    class operator Implicit(const a: Variant): OLDouble;
    class operator Implicit(const a: OLDouble): Variant;
    class operator Implicit(const a: Integer): OLDouble;

    class operator Implicit(const a: Extended): OLDouble;
    class operator Implicit(const a: OLDouble): Extended;

    class operator Inc(const a: OLDouble): OLDouble;
    class operator Dec(const a: OLDouble): OLDouble;
    class operator Negative(const a: OLDouble): OLDouble;

    class operator Equal(const a, b: OLDouble): OLBoolean;
    class operator NotEqual(const a, b: OLDouble): OLBoolean;
    class operator GreaterThan(const a, b: OLDouble): OLBoolean;
    class operator GreaterThanOrEqual(const a, b: OLDouble): OLBoolean;
    class operator LessThan(const a, b: OLDouble): OLBoolean;
    class operator LessThanOrEqual(const a, b: OLDouble): OLBoolean;
  end;

  POLDouble = ^OLDouble;

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

class operator OLDouble.Add(const a, b: OLDouble): OLDouble;

var
  returnrec: OLDouble;
begin
  returnrec.Value := a.Value + b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLDouble.Ceil: Integer;
var
  d: Double;
begin
  d := Self;

  Result := Math.Ceil(d);
end;

class operator OLDouble.Implicit(const a: Double): OLDouble;
var
  OutPut: OLDouble;
begin
  OutPut.Value := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLDouble.Implicit(const a: OLDouble): Double;
var
  OutPut: Double;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as double value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLDouble.Dec(const a: OLDouble): OLDouble;
begin
  Result := a - 1;
end;

class operator OLDouble.Divide(const a, b: OLDouble): OLDouble;
var
  returnrec: OLDouble;
begin
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;

  if returnrec.ValuePresent then
    returnrec.Value := a.Value / b.Value;

  Result := returnrec;
end;

function OLDouble.EnsureRange(const AMin, AMax: Extended): Extended;
begin
  Result := Math.EnsureRange(Self, AMin, AMax);
end;

class operator OLDouble.Equal(const a, b: OLDouble): OLBoolean;
begin
  Result := (a.ValuePresent and b.ValuePresent and (System.Abs(a.Value - b.Value) < 1e-10)) or (a.IsNull() and b.IsNull());
end;

function OLDouble.Floor: Integer;
var
  d: Double;
begin
  d := Self;
  Result := Math.Floor(d);
end;

function OLDouble.GetHasValue: OLBoolean;
begin
  Result := (NullFlag <> EmptyStr);
end;

class operator OLDouble.GreaterThan(const a, b: OLDouble): OLBoolean;
begin
  Result := (a.Value > b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLDouble.GreaterThanOrEqual(const a, b: OLDouble): OLBoolean;
begin
  Result := ((a.Value >= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLDouble.HasValue: OLBoolean;
begin
  Result := ValuePresent;
end;

function OLDouble.IfNull(const d: OLDouble): OLDouble;
var
  Output: OLDouble;
begin
  if ValuePresent then
    Output := Self
  else
    Output := d;

  Result := Output;
end;

class operator OLDouble.Implicit(const a: Variant): OLDouble;
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

class operator OLDouble.Inc(const a: OLDouble): OLDouble;
begin
  Result := a + 1;
end;

function OLDouble.InRange(const AMin, AMax: Extended): OLBoolean;
begin
  Result := Math.InRange(Self, AMin, AMax);
end;

function OLDouble.IsNull: OLBoolean;
begin
  Result := not ValuePresent;
end;

class operator OLDouble.LessThan(const a, b: OLDouble): OLBoolean;
begin
  Result := (a.Value < b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLDouble.LessThanOrEqual(const a, b: OLDouble): OLBoolean;
begin
  Result := ((a.Value <= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLDouble.Max(const d: OLDouble): OLDouble;
begin
  if (not ValuePresent) or (d.IsNull()) then
    raise Exception.Create('Null value cannot be compared to double.');

  Result := Math.Max(Value, d);
end;

function OLDouble.Min(const d: OLDouble): OLDouble;
begin
  if (not ValuePresent) or (d.IsNull) then
    raise Exception.Create('Null value cannot be compared to double.');

  Result := Math.Min(Value, d);
end;


class operator OLDouble.Multiply(const a, b: OLDouble): OLDouble;
var
  returnrec: OLDouble;
begin
  returnrec.Value := a.Value * b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLDouble.Negative(const a: OLDouble): OLDouble;

var
  b: OLDouble;
begin
  b := -a.Value;
  Result := b;
end;

function OLDouble.IsInfinite: OLBoolean;
var
  d: Double;
begin
  d := Self;
  Result := Math.IsInfinite(d);
end;

function OLDouble.IsNan: OLBoolean;
var
  d: Double;
begin
  d := Self;
  Result := Math.IsNan(d);
end;

function OLDouble.IsNegative: OLBoolean;
begin
  Result := ValuePresent and (Value < 0);
end;

function OLDouble.IsNonNegative: OLBoolean;
begin
  Result := ValuePresent and (Value >= 0);
end;

class operator OLDouble.NotEqual(const a, b: OLDouble): OLBoolean;
begin
  Result := ((a.Value <> b.Value) and a.ValuePresent and b.ValuePresent) or (a.ValuePresent <> b.ValuePresent);
end;

function OLDouble.Power(const Exponent: Extended): OLDouble;
begin
  Result := Math.Power(Self, Exponent);
end;

function OLDouble.Power(const Exponent: integer): OLDouble;
var
  returnrec: OLDouble;
begin
  returnrec.Value := Math.IntPower(Value, Exponent);
  returnrec.ValuePresent := ValuePresent;
  Result := returnrec;
end;


class function OLDouble.Random(const MinValue: Double; const MaxValue:Double):
    OLDouble;
begin
  Result := MinValue + system.Random() * (MaxValue - MinValue);
end;

function OLDouble.IsPositive: OLBoolean;
begin
  Result := ValuePresent and (Value > 0);
end;

function OLDouble.IsZero(const Epsilon: Extended = 0): OLBoolean;
begin
  Result := Math.IsZero(Self, Epsilon);
end;

function OLDouble.SameValue(const B: Extended; const Epsilon: Extended = 0):
    OLBoolean;
begin
  Result := Math.SameValue(Self, B, Epsilon);
end;

procedure OLDouble.SetHasValue(const Value: OLBoolean);
begin
  if Value then
    NullFlag := NonEmptyStr
  else
    NullFlag := EmptyStr;
end;

function OLDouble.Round(const PowerOfTen: integer): OLDouble;
var
  OutPut: OLDouble;
begin
  if HasValue then
    OutPut := Math.RoundTo(Self, PowerOfTen)
  else
    OutPut := null;

  Result := OutPut;
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

class operator OLDouble.Subtract(const a, b: OLDouble): OLDouble;

var
  returnrec: OLDouble;
begin
  returnrec.Value := a.Value - b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLDouble.ToSQLString: string;
var
  fs: TFormatSettings;
  OutPut: string;
begin
  fs.ThousandSeparator := #0;
  fs.DecimalSeparator := '.';

  if HasValue then
    OutPut := FloatToStrF(Self, ffNumber, 16, 16, fs)
  else
    OutPut := 'NULL';

  Result := OutPut;
end;

function OLDouble.ToString(const Digits: integer; const Format: TFloatFormat =
    ffFixed; const Precision: integer = 16): string;
begin
  Result := FloatToStrF(Self, Format, Precision, Digits);
end;

function OLDouble.ToString(ThousandSeparator, DecimalSeparator: Char; Format: string): string;
var
  fs: TFormatSettings;
  Output: string;
begin
  if ValuePresent then
  begin
    fs.ThousandSeparator := ThousandSeparator;
    fs.DecimalSeparator := DecimalSeparator;
    Output := FormatFloat(Format, Value, fs)
  end
  else
    Output := '';

  Result := Output;
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

class function OLDouble.Random(const MaxValue:Double = MaxInt): OLDouble;
begin
  Result := OLDouble.Random(0, MaxValue);
end;

function OLDouble.Round: Integer;
var
  d: Double;
begin
  d := Self;
  Result := System.Round(d);
end;

class operator OLDouble.Implicit(const a: Integer): OLDouble;
var
  OutPut: OLDouble;
begin
  OutPut.Value := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLDouble.Implicit(const a: Extended): OLDouble;
var
  OutPut: OLDouble;
begin
  OutPut.Value := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLDouble.Implicit(const a: OLDouble): Extended;
var
  OutPut: Double;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as extended value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLDouble.Implicit(const a: OLDouble): Variant;
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
