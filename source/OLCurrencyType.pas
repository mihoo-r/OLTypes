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
    procedure SetHasValue(Value: OLBoolean);
    property ValuePresent: OLBoolean read GetHasValue write SetHasValue;
  public
    function Sqr(): OLCurrency;
    function Power(Exponent: integer): OLCurrency;
    function IsPositive(): OLBoolean;
    function IsNegative(): OLBoolean;
    function IsNonNegative(): OLBoolean;
    function Max(i: OLCurrency): OLCurrency;
    function Min(i: OLCurrency): OLCurrency;
    function Abs(): OLCurrency;
    function IsNull(): OLBoolean;
    function HasValue(): OLBoolean;
    function ToString(): string;
    function IfNull(i: OLCurrency): OLCurrency;
    function Round(Digits: integer): OLCurrency; overload;
    function Round(): OLInteger; overload;

    class operator Add(a, b: OLCurrency): OLCurrency;
    class operator Subtract(a, b: OLCurrency): OLCurrency;
    class operator Multiply(a, b: OLCurrency): OLCurrency;
    class operator Divide(a, b: OLCurrency): OLDouble;
    class operator Divide(a: OLDouble; b: OLCurrency): OLDouble;
    class operator Divide(a: OLCurrency; b: OLDouble): OLDouble;
    class operator Divide(a: Extended; b: OLCurrency): OLDouble;
    class operator Divide(a: OLCurrency; b: Extended): OLDouble;
    class operator Negative(a: OLCurrency): OLCurrency;

    class operator Implicit(a: Extended): OLCurrency;
    class operator Implicit(a: OLCurrency): Extended;
    class operator Implicit(a: OLCurrency): Double;
    class operator Implicit(a: Variant): OLCurrency;
    class operator Implicit(a: OLCurrency): Variant;
    class operator Implicit(a: OLCurrency): Currency;

    class operator Equal(a, b: OLCurrency): OLBoolean; overload;
    class operator NotEqual(a, b: OLCurrency): OLBoolean; overload;
    class operator GreaterThan(a, b: OLCurrency): OLBoolean; overload;
    class operator GreaterThanOrEqual(a, b: OLCurrency): OLBoolean; overload;
    class operator LessThan(a, b: OLCurrency): OLBoolean; overload;
    class operator LessThanOrEqual(a, b: OLCurrency): OLBoolean; overload;

    class operator Equal(a: OLCurrency; b: Extended): OLBoolean; overload;
    class operator NotEqual(a: OLCurrency; b: Extended): OLBoolean; overload;
    class operator GreaterThan(a: OLCurrency; b: Extended): OLBoolean; overload;
    class operator GreaterThanOrEqual(a: OLCurrency; b: Extended): OLBoolean; overload;
    class operator LessThan(a: OLCurrency; b: Extended): OLBoolean; overload;
    class operator LessThanOrEqual(a: OLCurrency; b: Extended): OLBoolean; overload;
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

class operator OLCurrency.Add(a, b: OLCurrency): OLCurrency;

var
  returnrec: OLCurrency;
begin
  returnrec.Value := a.Value + b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLCurrency.Implicit(a: Extended): OLCurrency;
var
  OutPut: OLCurrency;
begin
  OutPut.Value := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLCurrency.Implicit(a: OLCurrency): Extended;
var
  OutPut: Extended;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as integer value');
  OutPut := a.Value;
  Result := OutPut;
end;


class operator OLCurrency.Divide(a: OLDouble; b: OLCurrency): OLDouble;
var
  OutPut: OLDouble;
begin
  if (a.IsNull()) or (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a / b.Value;

  Result := OutPut;
end;

class operator OLCurrency.Divide(a: OLCurrency; b: OLDouble): OLDouble;
var
  OutPut: OLDouble;
begin
  if (not a.ValuePresent) or (b.IsNull()) then
    OutPut := Null
  else
    OutPut := a.Value / b;


  Result := OutPut;
end;

class operator OLCurrency.Equal(a: OLCurrency; b: Extended): OLBoolean;
begin
  Result := (System.Abs(a.Value - b) < 1e-10) and a.ValuePresent;
end;

class operator OLCurrency.Divide(a, b: OLCurrency): OLDouble;
var
  OutPut: OLDouble;
begin
  if (not a.ValuePresent) or (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a.Value / b.Value;


  Result := OutPut;
end;


class operator OLCurrency.Equal(a, b: OLCurrency): OLBoolean;
begin
  Result := ((a.Value = b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLCurrency.GetHasValue: OLBoolean;
begin
  Result := (NullFlag <> EmptyStr);
end;

class operator OLCurrency.GreaterThan(a, b: OLCurrency): OLBoolean;
begin
  Result := (a.Value > b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLCurrency.GreaterThanOrEqual(a, b: OLCurrency): OLBoolean;
begin
  Result := ((a.Value >= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLCurrency.IfNull(i: OLCurrency): OLCurrency;
var
  Output: OLCurrency;
begin
  if ValuePresent then
    Output := Self
  else
    Output := i;

  Result := Output;
end;

class operator OLCurrency.Implicit(a: OLCurrency): Variant;
var
  OutPut: Variant;
begin
  if a.ValuePresent then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLCurrency.Implicit(a: OLCurrency): Double;
var
  OutPut: Double;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as Double value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLCurrency.Implicit(a: Variant): OLCurrency;
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

class operator OLCurrency.LessThan(a, b: OLCurrency): OLBoolean;
begin
  Result := (a.Value < b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLCurrency.LessThanOrEqual(a, b: OLCurrency): OLBoolean;
begin
  Result := ((a.Value <= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLCurrency.Max(i: OLCurrency): OLCurrency;
begin
  if (not ValuePresent) or (i = Null) then
    raise Exception.Create('Null value cannot be compared to integer.');

  Result := Math.Max(Value, i);
end;

function OLCurrency.Min(i: OLCurrency): OLCurrency;
begin
  if (not ValuePresent) or (i = Null) then
    raise Exception.Create('Null value cannot be compared to integer.');

  Result := Math.Min(Value, i);
end;


class operator OLCurrency.Multiply(a, b: OLCurrency): OLCurrency;
var
  returnrec: OLCurrency;
begin
  returnrec.Value := a.Value * b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLCurrency.Negative(a: OLCurrency): OLCurrency;
var
  b: OLCurrency;
begin
  b.Value := -a.Value;
  b.ValuePresent := a.ValuePresent;
  Result := b;
end;

class operator OLCurrency.NotEqual(a: OLCurrency; b: Extended): OLBoolean;
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

class operator OLCurrency.NotEqual(a, b: OLCurrency): OLBoolean;
begin
  Result := ((a.Value <> b.Value) and a.ValuePresent and b.ValuePresent) or (a.ValuePresent <> b.ValuePresent);
end;

function OLCurrency.Power(Exponent: integer): OLCurrency;
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


procedure OLCurrency.SetHasValue(Value: OLBoolean);
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

class operator OLCurrency.Subtract(a, b: OLCurrency): OLCurrency;

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


function OLCurrency.Round(Digits: integer): OLCurrency;
begin
  Result := Math.RoundTo(Self, Digits);
end;


class operator OLCurrency.GreaterThan(a: OLCurrency; b: Extended): OLBoolean;
begin
  Result := (a.Value > b) and a.ValuePresent;
end;

class operator OLCurrency.GreaterThanOrEqual(a: OLCurrency;
  b: Extended): OLBoolean;
begin
  Result := (a.Value >= b) and a.ValuePresent;
end;

function OLCurrency.HasValue: OLBoolean;
begin
  Result := ValuePresent;
end;

class operator OLCurrency.LessThan(a: OLCurrency; b: Extended): OLBoolean;
begin
  Result := (a.Value < b) and a.ValuePresent;
end;

class operator OLCurrency.LessThanOrEqual(a: OLCurrency;
  b: Extended): OLBoolean;
begin
  Result := (a.Value <= b) and a.ValuePresent;
end;

class operator OLCurrency.Implicit(a: OLCurrency): Currency;
var
  OutPut: Extended;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as Currency value');
  OutPut := a.Value;
  Result := OutPut;
end;

class operator OLCurrency.Divide(a: Extended; b: OLCurrency): OLDouble;
var
  OutPut: OLDouble;
begin
  if (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a / b.Value;

  Result := OutPut;
end;

class operator OLCurrency.Divide(a: OLCurrency; b: Extended): OLDouble;
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
