unit OLCurrencyType;

interface

uses
  variants, SysUtils, OLIntegerType, OlBooleanType, OLDoubleType;

type
  OLCurrency = record
  private
    Value: Currency;
    NullFlag: string;

    function GetHasValue(): OLBoolean;
    procedure SetHasValue(const Value: OLBoolean);
    property ValuePresent: OLBoolean read GetHasValue write SetHasValue;
  public
    function Sqr(): OLCurrency;
    function Power(const Exponent: integer): OLCurrency;
    function IsPositive(): OLBoolean;
    function IsNegative(): OLBoolean;
    function IsNonNegative(): OLBoolean;
    function Max(const i: OLCurrency): OLCurrency;
    function Min(const i: OLCurrency): OLCurrency;
    function Abs(): OLCurrency;
    function IsNull(): OLBoolean;
    function HasValue(): OLBoolean;
    function ToString(): string;
    function IfNull(const i: OLCurrency): OLCurrency;
    function Round(const Digits: integer): OLCurrency; overload;
    function Round(): OLInteger; overload;

    class operator Add(const a, b: OLCurrency): OLCurrency;
    class operator Subtract(const a, b: OLCurrency): OLCurrency;
    class operator Multiply(const a, b: OLCurrency): OLCurrency;
    class operator Divide(const a, b: OLCurrency): OLDouble;
    class operator Divide(const a: OLDouble; const b: OLCurrency): OLDouble;
    class operator Divide(const a: OLCurrency; b: OLDouble): OLDouble;
    class operator Divide(const a: Extended; const b: OLCurrency): OLDouble;
    class operator Divide(const a: OLCurrency; const b: Extended): OLDouble;
    class operator Negative(const a: OLCurrency): OLCurrency;

    class operator Implicit(const a: Extended): OLCurrency;
    class operator Implicit(const a: OLCurrency): Extended;
    class operator Implicit(const a: OLCurrency): Double;
    class operator Implicit(const a: Variant): OLCurrency;
    class operator Implicit(const a: OLCurrency): Variant;
    class operator Implicit(const a: OLCurrency): Currency;

    class operator Equal(const a, b: OLCurrency): OLBoolean; overload;
    class operator NotEqual(const a, b: OLCurrency): OLBoolean; overload;
    class operator GreaterThan(const a, b: OLCurrency): OLBoolean; overload;
    class operator GreaterThanOrEqual(const a, b: OLCurrency): OLBoolean; overload;
    class operator LessThan(const a, b: OLCurrency): OLBoolean; overload;
    class operator LessThanOrEqual(const a, b: OLCurrency): OLBoolean; overload;

    class operator Equal(const a: OLCurrency; const b: Extended): OLBoolean; overload;
    class operator NotEqual(const a: OLCurrency; const b: Extended): OLBoolean; overload;
    class operator GreaterThan(const a: OLCurrency; const b: Extended): OLBoolean; overload;
    class operator GreaterThanOrEqual(const a: OLCurrency; const b: Extended): OLBoolean; overload;
    class operator LessThan(const a: OLCurrency; const b: Extended): OLBoolean; overload;
    class operator LessThanOrEqual(const a: OLCurrency; const b: Extended): OLBoolean; overload;
  end;

  OLDecimal = OLCurrency;

implementation

uses
  Math;

const
  NonEmptyStr = ' ';

function OLCurrency.Abs(): OLCurrency;
begin
  if Self.ValuePresent then
    Result := System.Abs(Self.Value)
  else
    Result := Null;
end;

class operator OLCurrency.Add(const a, b: OLCurrency): OLCurrency;

var
  returnrec: OLCurrency;
begin
  returnrec.Value := a.Value + b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLCurrency.Implicit(const a: Extended): OLCurrency;
var
  OutPut: OLCurrency;
begin
  OutPut.Value := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLCurrency.Implicit(const a: OLCurrency): Extended;
var
  OutPut: Extended;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as integer value');
  OutPut := a.Value;
  Result := OutPut;
end;


class operator OLCurrency.Divide(const a: OLDouble; const b: OLCurrency):
    OLDouble;
var
  OutPut: OLDouble;
begin
  if (a.IsNull()) or (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a / b.Value;

  Result := OutPut;
end;

class operator OLCurrency.Divide(const a: OLCurrency; b: OLDouble): OLDouble;
var
  OutPut: OLDouble;
begin
  if (not a.ValuePresent) or (b.IsNull()) then
    OutPut := Null
  else
    OutPut := a.Value / b;


  Result := OutPut;
end;

class operator OLCurrency.Equal(const a: OLCurrency; const b: Extended):
    OLBoolean;
begin
  Result := (System.Abs(a.Value - b) < 1e-10) and a.ValuePresent;
end;

class operator OLCurrency.Divide(const a, b: OLCurrency): OLDouble;
var
  OutPut: OLDouble;
begin
  if (not a.ValuePresent) or (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a.Value / b.Value;


  Result := OutPut;
end;


class operator OLCurrency.Equal(const a, b: OLCurrency): OLBoolean;
begin
  Result := ((a.Value = b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLCurrency.GetHasValue: OLBoolean;
begin
  Result := (NullFlag <> EmptyStr);
end;

class operator OLCurrency.GreaterThan(const a, b: OLCurrency): OLBoolean;
begin
  Result := (a.Value > b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLCurrency.GreaterThanOrEqual(const a, b: OLCurrency): OLBoolean;
begin
  Result := ((a.Value >= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLCurrency.IfNull(const i: OLCurrency): OLCurrency;
var
  Output: OLCurrency;
begin
  if ValuePresent then
    Output := Self
  else
    Output := i;

  Result := Output;
end;

class operator OLCurrency.Implicit(const a: OLCurrency): Variant;
var
  OutPut: Variant;
begin
  if a.ValuePresent then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLCurrency.Implicit(const a: OLCurrency): Double;
var
  OutPut: Double;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as Double value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLCurrency.Implicit(const a: Variant): OLCurrency;
var
  OutPut: OLCurrency;
  i: Currency;
begin
  if VarIsNull(a) then
    OutPut.ValuePresent := false
  else
  begin
    if TryStrToCurr(a, i) then
    begin
      OutPut.Value := i;
      OutPut.ValuePresent := true;
    end
    else
    begin
      raise Exception.Create('Value ''' + VarToStr(a) + ''' cannot be assigned to variable of OLCurrency type.');
    end;
  end;

  Result := OutPut;
end;

function OLCurrency.IsNull: OLBoolean;
begin
  Result := not ValuePresent;
end;

class operator OLCurrency.LessThan(const a, b: OLCurrency): OLBoolean;
begin
  Result := (a.Value < b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLCurrency.LessThanOrEqual(const a, b: OLCurrency): OLBoolean;
begin
  Result := ((a.Value <= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLCurrency.Max(const i: OLCurrency): OLCurrency;
begin
  if (not ValuePresent) or (i = Null) then
    raise Exception.Create('Null value cannot be compared to integer.');

  Result := Math.Max(Value, i);
end;

function OLCurrency.Min(const i: OLCurrency): OLCurrency;
begin
  if (not ValuePresent) or (i = Null) then
    raise Exception.Create('Null value cannot be compared to integer.');

  Result := Math.Min(Value, i);
end;


class operator OLCurrency.Multiply(const a, b: OLCurrency): OLCurrency;
var
  returnrec: OLCurrency;
begin
  returnrec.Value := a.Value * b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLCurrency.Negative(const a: OLCurrency): OLCurrency;
var
  b: OLCurrency;
begin
  b.Value := -a.Value;
  b.ValuePresent := a.ValuePresent;
  Result := b;
end;

class operator OLCurrency.NotEqual(const a: OLCurrency; const b: Extended):
    OLBoolean;
begin
  Result := (a.Value <> b) and a.ValuePresent;
end;

function OLCurrency.IsNegative: OLBoolean;
begin
  Result := ValuePresent and (Value < 0);
end;

function OLCurrency.IsNonNegative: OLBoolean;
begin
  Result := ValuePresent and (Value >= 0);
end;

class operator OLCurrency.NotEqual(const a, b: OLCurrency): OLBoolean;
begin
  Result := ((a.Value <> b.Value) and a.ValuePresent and b.ValuePresent) or (a.ValuePresent <> b.ValuePresent);
end;

function OLCurrency.Power(const Exponent: integer): OLCurrency;
var
  returnrec: OLCurrency;
begin
  returnrec.ValuePresent := self.ValuePresent;
  if returnrec.ValuePresent then
    returnrec.Value := Math.IntPower(Value, Exponent);
  Result := returnrec;
end;


function OLCurrency.Round: OLInteger;
begin
  Result := System.Trunc(Math.RoundTo(Self, 0));
end;

function OLCurrency.IsPositive: OLBoolean;
begin
  Result := ValuePresent and (Value > 0);
end;


procedure OLCurrency.SetHasValue(const Value: OLBoolean);
begin
  if Value then
    NullFlag := NonEmptyStr
  else
    NullFlag := EmptyStr;
end;

function OLCurrency.Sqr: OLCurrency;
var
  returnrec: OLCurrency;
begin
  returnrec.Value := Value * Value;
  returnrec.ValuePresent := ValuePresent;
  Result := returnrec;
end;

class operator OLCurrency.Subtract(const a, b: OLCurrency): OLCurrency;

var
  returnrec: OLCurrency;
begin
  returnrec.Value := a.Value - b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLCurrency.ToString: string;
var
  Output: string;
begin
  if ValuePresent then
    Output := CurrToStrF(Value, ffCurrency, 2)
  else
    Output := EmptyStr;

  Result := Output;
end;


function OLCurrency.Round(const Digits: integer): OLCurrency;
begin
  Result := Math.RoundTo(Self, Digits);
end;


class operator OLCurrency.GreaterThan(const a: OLCurrency; const b: Extended):
    OLBoolean;
begin
  Result := (a.Value > b) and a.ValuePresent;
end;

class operator OLCurrency.GreaterThanOrEqual(const a: OLCurrency; const b:
    Extended): OLBoolean;
begin
  Result := (a.Value >= b) and a.ValuePresent;
end;

function OLCurrency.HasValue: OLBoolean;
begin
  Result := ValuePresent;
end;

class operator OLCurrency.LessThan(const a: OLCurrency; const b: Extended):
    OLBoolean;
begin
  Result := (a.Value < b) and a.ValuePresent;
end;

class operator OLCurrency.LessThanOrEqual(const a: OLCurrency; const b:
    Extended): OLBoolean;
begin
  Result := (a.Value <= b) and a.ValuePresent;
end;

class operator OLCurrency.Implicit(const a: OLCurrency): Currency;
var
  OutPut: Extended;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as Currency value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLCurrency.Divide(const a: Extended; const b: OLCurrency):
    OLDouble;
var
  OutPut: OLDouble;
begin
  if (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a / b.Value;

  Result := OutPut;
end;

class operator OLCurrency.Divide(const a: OLCurrency; const b: Extended):
    OLDouble;
var
  OutPut: OLDouble;
begin
  if (not a.ValuePresent) then
    OutPut := Null
  else
    OutPut := a.Value / b;


  Result := OutPut;
end;

end.
