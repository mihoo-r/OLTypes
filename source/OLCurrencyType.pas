unit OLCurrencyType;

interface

uses
  variants, SysUtils, OLIntegerType, OlBooleanType, OLDoubleType, System.Classes;

type
  OLCurrency = record
  private
    FValue: Currency;
    {$IF CompilerVersion >= 34.0}
    FHasValue: Boolean;
    FOnChange: TNotifyEvent;
    {$ELSE}
    FHasValue: string;
    {$IFEND}

    function GetHasValue(): OLBoolean;
    procedure SetHasValue(const Value: OLBoolean);
    property ValuePresent: OLBoolean read GetHasValue write SetHasValue;
  public
    function Sqr(): OLCurrency;
    function Power(const Exponent: integer): OLCurrency;
    function IsPositive(): OLBoolean;
    function IsNegative(): OLBoolean;
    function IsNonNegative(): OLBoolean;
    function Between(const BottomIncluded, TopIncluded: OLInteger): OLBoolean;
    function Max(const i: OLCurrency): OLCurrency;
    function Min(const i: OLCurrency): OLCurrency;
    function Abs(): OLCurrency;
    function IsNull(): OLBoolean;
    function HasValue(): OLBoolean;
    function ToString(): string; overload;
    function ToString(ThousandSeparator: Char; DecimalSeparator: Char = '.'; Format: string = '###,###,###,##0.##'): string; overload;
    function ToSQLString: string;
    function ToStrF(Format: TFloatFormat; Digits: Integer): string;
    function IfNull(const i: OLCurrency): OLCurrency;
    function Round(): OLInteger; overload;
    function Round(const PowerOfTen: integer): OLCurrency; overload;
    function Ceil(): OLInteger;
    function Floor(): OLInteger;

    class operator Add(const a, b: OLCurrency): OLCurrency;
    class operator Subtract(const a, b: OLCurrency): OLCurrency;
    class operator Multiply(const a, b: OLCurrency): OLCurrency;
    class operator Multiply(const a: OLCurrency; b: OLInteger): OLCurrency;
    class operator Multiply(const a: OLCurrency; b: Extended): OLCurrency;
    class operator Multiply(const a: OLCurrency; b: Double): OLCurrency;
    class operator Multiply(const a: OLCurrency; b: OLDouble): OLCurrency;
    class operator Divide(const a, b: OLCurrency): OLDouble;
    class operator Divide(const a: OLDouble; const b: OLCurrency): OLDouble;
    class operator Divide(const a: OLCurrency; const b: OLDouble): OLDouble;
    class operator Divide(const a: Extended; const b: OLCurrency): OLDouble;
    class operator Divide(const a: OLCurrency; const b: Extended): OLDouble;
    class operator Negative(const a: OLCurrency): OLCurrency;

    class operator Implicit(const a: Integer): OLCurrency;
    class operator Implicit(const a: Extended): OLCurrency;
    class operator Implicit(const a: OLCurrency): Extended;
    class operator Implicit(const a: Double): OLCurrency;
    class operator Implicit(const a: OLCurrency): Double;
    class operator Implicit(const a: Real): OLCurrency;
    class operator Implicit(const a: OLCurrency): Real;
    class operator Implicit(const a: OLDouble): OLCurrency;
    class operator Implicit(const a: OLCurrency): OLDouble;
    class operator Implicit(const a: Variant): OLCurrency;
    class operator Implicit(const a: OLCurrency): Variant;
    class operator Implicit(const a: OLCurrency): Currency;

    class operator Equal(const a, b: OLCurrency): Boolean; overload;
    class operator NotEqual(const a, b: OLCurrency): Boolean; overload;
    class operator GreaterThan(const a, b: OLCurrency): Boolean; overload;
    class operator GreaterThanOrEqual(const a, b: OLCurrency): Boolean; overload;
    class operator LessThan(const a, b: OLCurrency): Boolean; overload;
    class operator LessThanOrEqual(const a, b: OLCurrency): Boolean; overload;

    class operator Equal(const a: OLCurrency; const b: Currency): Boolean; overload;
    class operator NotEqual(const a: OLCurrency; const b: Currency): Boolean; overload;
    class operator GreaterThan(const a: OLCurrency; const b: Currency): Boolean; overload;
    class operator GreaterThanOrEqual(const a: OLCurrency; const b: Currency): Boolean; overload;
    class operator LessThan(const a: OLCurrency; const b: Currency): Boolean; overload;
    class operator LessThanOrEqual(const a: OLCurrency; const b: Currency): Boolean; overload;

    class operator Equal(const a: OLCurrency; const b: Extended): Boolean; overload;
    class operator NotEqual(const a: OLCurrency; const b: Extended): Boolean; overload;
    class operator GreaterThan(const a: OLCurrency; const b: Extended): Boolean; overload;
    class operator GreaterThanOrEqual(const a: OLCurrency; const b: Extended): Boolean; overload;
    class operator LessThan(const a: OLCurrency; const b: Extended): Boolean; overload;
    class operator LessThanOrEqual(const a: OLCurrency; const b: Extended): Boolean; overload;

    {$IF CompilerVersion >= 34.0}
    class operator Initialize(out Dest: OLCurrency);
    class operator Assign(var Dest: OLCurrency; const [ref] Src: OLCurrency);
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {$IFEND}
  end;

  OLDecimal = OLCurrency;
  POLCurrency = ^OLCurrency;

implementation

uses
  Math;

const
  NonEmptyStr = ' ';

function OLCurrency.Abs(): OLCurrency;
begin
  if Self.ValuePresent then
    Result := System.Abs(FValue)
  else
    Result := Null;
end;

class operator OLCurrency.Add(const a, b: OLCurrency): OLCurrency;

var
  returnrec: OLCurrency;
begin
  returnrec.FValue := a.FValue + b.FValue;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLCurrency.Between(const BottomIncluded, TopIncluded: OLInteger): OLBoolean;
begin
  Result := HasValue.IfThen((FValue <= TopIncluded) and (FValue >= BottomIncluded), null);
end;

function OLCurrency.Ceil: OLInteger;
var
  OutPut: OLInteger;
begin
  if HasValue then
    OutPut := Math.Ceil(Self)
  else
    OutPut := null;

  Result := OutPut;
end;

class operator OLCurrency.Implicit(const a: Extended): OLCurrency;
var
  OutPut: OLCurrency;
begin
  OutPut.FValue := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLCurrency.Implicit(const a: OLCurrency): Extended;
var
  OutPut: Extended;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as Extended value');
  OutPut := a.FValue;
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
    OutPut := a / b.FValue;

  Result := OutPut;
end;

class operator OLCurrency.Divide(const a: OLCurrency; const b: OLDouble):
    OLDouble;
var
  OutPut: OLDouble;
begin
  if (not a.ValuePresent) or (b.IsNull()) then
    OutPut := Null
  else
    OutPut := a.FValue / b;


  Result := OutPut;
end;

class operator OLCurrency.Equal(const a: OLCurrency; const b: Extended):
    Boolean;
begin
  Result := (System.Abs(a.FValue - b) < 1e-10) and a.ValuePresent;
end;

class operator OLCurrency.Equal(const a: OLCurrency; const b: Currency): Boolean;
begin
  Result := (a.FValue = b) and a.ValuePresent;
end;

function OLCurrency.Floor: OLInteger;
var
  OutPut: OLInteger;
begin
  if HasValue then
    OutPut := Math.Floor(Self)
  else
    OutPut := null;

  Result := OutPut;
end;

class operator OLCurrency.Divide(const a, b: OLCurrency): OLDouble;
var
  OutPut: OLDouble;
begin
  if (not a.ValuePresent) or (not b.ValuePresent) then
    OutPut := Null
  else
    OutPut := a.FValue / b.FValue;


  Result := OutPut;
end;


class operator OLCurrency.Equal(const a, b: OLCurrency): Boolean;
begin
  Result := ((a.FValue = b.FValue) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLCurrency.GetHasValue: OLBoolean;
begin
  {$IF CompilerVersion >= 34.0}
  Result := FHasValue;
  {$ELSE}
  Result := FHasValue = ' ';
  {$IFEND}
end;

class operator OLCurrency.GreaterThan(const a, b: OLCurrency): Boolean;
begin
  Result := (a.FValue > b.FValue) and a.ValuePresent and b.ValuePresent;
end;

class operator OLCurrency.GreaterThanOrEqual(const a, b: OLCurrency): Boolean;
begin
  Result := ((a.FValue >= b.FValue) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
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
    OutPut := a.FValue
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
  OutPut := a.FValue;
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
      OutPut.FValue := i;
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

class operator OLCurrency.LessThan(const a, b: OLCurrency): Boolean;
begin
  Result := (a.FValue < b.FValue) and a.ValuePresent and b.ValuePresent;
end;

class operator OLCurrency.LessThanOrEqual(const a, b: OLCurrency): Boolean;
begin
  Result := ((a.FValue <= b.FValue) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLCurrency.Max(const i: OLCurrency): OLCurrency;
begin
  if (not ValuePresent) or (i = Null) then
    Result := Null
  else
    Result := Math.Max(FValue, i);
end;

function OLCurrency.Min(const i: OLCurrency): OLCurrency;
begin
  if (not ValuePresent) or (i = Null) then
    Result := Null
  else
    Result := Math.Min(FValue, i);
end;


class operator OLCurrency.Multiply(const a: OLCurrency; b: Extended): OLCurrency;
var
  returnrec: OLCurrency;
begin
  returnrec.FValue := a.FValue * b;
  returnrec.ValuePresent := a.ValuePresent;
  Result := returnrec;
end;

class operator OLCurrency.Multiply(const a: OLCurrency; b: OLInteger): OLCurrency;
var
  returnrec: OLCurrency;
begin
  returnrec.FValue := a.FValue * b.AsInteger();
  returnrec.ValuePresent := a.ValuePresent and b.HasValue();
  Result := returnrec;
end;

class operator OLCurrency.Multiply(const a, b: OLCurrency): OLCurrency;
var
  returnrec: OLCurrency;
begin
  returnrec.FValue := a.FValue * b.FValue;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

class operator OLCurrency.Negative(const a: OLCurrency): OLCurrency;
var
  b: OLCurrency;
begin
  b.FValue := -a.FValue;
  b.ValuePresent := a.ValuePresent;
  Result := b;
end;

class operator OLCurrency.NotEqual(const a: OLCurrency; const b: Extended):
    Boolean;
begin
  Result := (System.Abs(a.FValue - b) > 1e-10) and a.ValuePresent;
end;

class operator OLCurrency.NotEqual(const a: OLCurrency; const b: Currency): Boolean;
begin
  Result := (a.FValue <> b) and a.ValuePresent;
end;

function OLCurrency.IsNegative: OLBoolean;
begin
  if not ValuePresent then
    Result := Null
  else
    Result := FValue < 0;
end;

function OLCurrency.IsNonNegative: OLBoolean;
begin
  if not ValuePresent then
    Result := Null
  else
    Result := FValue >= 0;
end;

class operator OLCurrency.NotEqual(const a, b: OLCurrency): Boolean;
begin
  Result := ((a.FValue <> b.FValue) and a.ValuePresent and b.ValuePresent) or (a.ValuePresent <> b.ValuePresent);
end;

function OLCurrency.Power(const Exponent: integer): OLCurrency;
var
  returnrec: OLCurrency;
begin
  returnrec.ValuePresent := self.ValuePresent;
  if returnrec.ValuePresent then
    returnrec.FValue := Math.IntPower(FValue, Exponent);
  Result := returnrec;
end;


function OLCurrency.Round: OLInteger;
var
  OutPut: OLInteger;
begin
  if HasValue then
    OutPut := System.Trunc(Math.RoundTo(Self, 0))
  else
    OutPut := null;

  Result := OutPut;
end;

function OLCurrency.IsPositive: OLBoolean;
begin
  if not ValuePresent then
    Result := Null
  else
    Result := FValue > 0;
end;


procedure OLCurrency.SetHasValue(const Value: OLBoolean);
begin
  {$IF CompilerVersion >= 34.0}
  FHasValue := Value;
  {$ELSE}
  FHasValue := Value.IfThen(' ', '');
  {$IFEND}
end;

{$IF CompilerVersion >= 34.0}
class operator OLCurrency.Initialize(out Dest: OLCurrency);
begin
  Dest.FHasValue := False;
  Dest.FOnChange := nil;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
class operator OLCurrency.Assign(var Dest: OLCurrency; const [ref] Src: OLCurrency);
begin
  Dest.FValue := Src.FValue;
  Dest.FHasValue := Src.FHasValue;

  if Assigned(Dest.FOnChange) then
    Dest.FOnChange(nil);
end;
{$IFEND}

function OLCurrency.Sqr: OLCurrency;
var
  returnrec: OLCurrency;
begin
  returnrec.FValue := FValue * FValue;
  returnrec.ValuePresent := ValuePresent;
  Result := returnrec;
end;

class operator OLCurrency.Subtract(const a, b: OLCurrency): OLCurrency;
var
  returnrec: OLCurrency;
begin
  returnrec.FValue := a.FValue - b.FValue;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

function OLCurrency.ToString: string;
begin
  Result := ToStrF(ffCurrency, 2);
end;

function OLCurrency.ToSQLString: string;
var
  fs: TFormatSettings;
  OutPut: string;
begin
  fs.ThousandSeparator := #0;
  fs.DecimalSeparator := '.';

  if HasValue then
    OutPut := CurrToStrF(Self, ffNumber, 4, fs)
  else
    OutPut := 'NULL';

  Result := OutPut;
end;

function OLCurrency.ToStrF(Format: TFloatFormat; Digits: Integer): string;
var
  Output: string;
begin
  if ValuePresent then
    Output := CurrToStrF(FValue, Format, Digits)
  else
    Output := EmptyStr;

  Result := Output;
end;

function OLCurrency.ToString(ThousandSeparator, DecimalSeparator: Char; Format: string): string;
var
  fs: TFormatSettings;
  Output: string;
begin
  if ValuePresent then
  begin
    fs.ThousandSeparator := ThousandSeparator;
    fs.DecimalSeparator := DecimalSeparator;
    Output := FormatFloat(Format, FValue, fs)
  end
  else
    Output := '';

  Result := Output;
end;

function OLCurrency.Round(const PowerOfTen: integer): OLCurrency;
var
  OutPut: OLCurrency;
begin
  if HasValue then
    OutPut := Math.RoundTo(Self, PowerOfTen)
  else
    OutPut := null;

  Result := OutPut;
end;


class operator OLCurrency.GreaterThan(const a: OLCurrency; const b: Extended):
    Boolean;
begin
  Result := (a.FValue > b) and a.ValuePresent;
end;

class operator OLCurrency.GreaterThan(const a: OLCurrency; const b: Currency): Boolean;
begin
  Result := (a.FValue > b) and a.ValuePresent;
end;

class operator OLCurrency.GreaterThanOrEqual(const a: OLCurrency; const b: Currency): Boolean;
begin
  Result := (a.FValue >= b) and a.ValuePresent;
end;

class operator OLCurrency.GreaterThanOrEqual(const a: OLCurrency; const b:
    Extended): Boolean;
begin
  Result := (a.FValue >= b) and a.ValuePresent;
end;

function OLCurrency.HasValue: OLBoolean;
begin
  Result := ValuePresent;
end;

class operator OLCurrency.LessThan(const a: OLCurrency; const b: Extended):
    Boolean;
begin
  Result := (a.FValue < b) and a.ValuePresent;
end;

class operator OLCurrency.LessThan(const a: OLCurrency; const b: Currency): Boolean;
begin
  Result := (a.FValue < b) and a.ValuePresent;
end;

class operator OLCurrency.LessThanOrEqual(const a: OLCurrency; const b: Currency): Boolean;
begin
  Result := (a.FValue <= b) and a.ValuePresent;
end;

class operator OLCurrency.LessThanOrEqual(const a: OLCurrency; const b:
    Extended): Boolean;
begin
  Result := (a.FValue <= b) and a.ValuePresent;
end;

class operator OLCurrency.Implicit(const a: OLCurrency): Currency;
var
  OutPut: Extended;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as Currency value');
  OutPut := a.FValue;
  Result := OutPut;
end;

class operator OLCurrency.Implicit(const a: Integer): OLCurrency;
var
  OutPut: OLCurrency;
begin
  OutPut.FValue := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLCurrency.Implicit(const a: OLCurrency): Real;
var
  OutPut: Real;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as Real value');
  OutPut := a.FValue;
  Result := OutPut;
end;

class operator OLCurrency.Implicit(const a: Real): OLCurrency;
var
  OutPut: OLCurrency;
begin
  OutPut.FValue := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

class operator OLCurrency.Implicit(const a: OLCurrency): OLDouble;
var
  OutPut: OLDouble;
begin
  if a.IsNull then
    OutPut := Null
  else
    OutPut := a.FValue;

  Result := OutPut;
end;

class operator OLCurrency.Implicit(const a: OLDouble): OLCurrency;
var
  OutPut: OLCurrency;
begin
  OutPut.ValuePresent := a.HasValue;
  if a.HasValue then
    OutPut.FValue := a;

  Result := OutPut;
end;

class operator OLCurrency.Implicit(const a: Double): OLCurrency;
var
  OutPut: OLCurrency;
begin
  OutPut.FValue := a;
  OutPut.ValuePresent := true;
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
    OutPut := a / b.FValue;

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
    OutPut := a.FValue / b;


  Result := OutPut;
end;

class operator OLCurrency.Multiply(const a: OLCurrency; b: Double): OLCurrency;
var
  returnrec: OLCurrency;
begin
  returnrec.FValue := a.FValue * b;
  returnrec.ValuePresent := a.ValuePresent;
  Result := returnrec;
end;

class operator OLCurrency.Multiply(const a: OLCurrency; b: OLDouble): OLCurrency;
var
  OutPut: OLDouble;
begin
  if (not a.ValuePresent) or (b.IsNull()) then
    OutPut := Null
  else
    OutPut := a.FValue * b;


  Result := OutPut;
end;

end.

