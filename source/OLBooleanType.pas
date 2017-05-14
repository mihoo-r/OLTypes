unit OLBooleanType;

interface

uses
  Variants, SysUtils;

type
  OLBoolean = record
  private
    Value: Boolean;
    NullFlag: string;

    function GetHasValue(): Boolean;
    procedure SetHasValue(Value: Boolean);
    property HasValue: Boolean read GetHasValue write SetHasValue;
  public
    function IsNull(): Boolean;
    function ToString(): string;
    function IfNull(b: OLBoolean): OLBoolean;

    function IfThen(ATrue: string; AFalse: string = ''): string; overload;
    function IfThen(ATrue: Integer; AFalse: Integer): integer; overload;
    function IfThen(ATrue: Currency; AFalse: Currency): Currency; overload;
    function IfThen(ATrue: Extended; AFalse: Extended): Extended; overload;
    function IfThen(ATrue: TDateTime; AFalse: TDateTime): TDateTime; overload;

    class operator Implicit(a: Boolean): OLBoolean;
    class operator Implicit(a: OLBoolean): Boolean;
    class operator Implicit(a: Variant): OLBoolean;
    class operator Implicit(a: OLBoolean): Variant;

    class operator Equal(a, b: OLBoolean): Boolean;
    class operator Equal(a: OLBoolean; b: Variant): Boolean;
    class operator NotEqual(a, b: OLBoolean): Boolean;
    class operator GreaterThan(a, b: OLBoolean): Boolean;
    class operator GreaterThanOrEqual(a, b: OLBoolean): Boolean;
    class operator LessThan(a, b: OLBoolean): Boolean;
    class operator LessThanOrEqual(a, b: OLBoolean): Boolean;

    class operator LogicalNot(a: OLBoolean): OLBoolean;
    class operator LogicalAnd(a: OLBoolean; b: OLBoolean): OLBoolean;
    class operator LogicalOr(a: OLBoolean; b: OLBoolean): OLBoolean;
    class operator LogicalXor(a: OLBoolean; b: OLBoolean): OLBoolean;
  end;

implementation

const
  NonEmptyStr = ' ';



{ OLBoolean }

class operator OLBoolean.Equal(a, b: OLBoolean): Boolean;
begin
  Result := ((a.Value = b.Value) and (a.HasValue and b.HasValue)) or (a.IsNull() and b.IsNull());
end;

class operator OLBoolean.Equal(a: OLBoolean; b: Variant): Boolean;
begin
  Result := ((a.Value = b) and (a.HasValue and (b <> Null))) or (a.IsNull() and (b = Null));
end;

function OLBoolean.GetHasValue: Boolean;
begin
  Result := (NullFlag <> EmptyStr);
end;

class operator OLBoolean.GreaterThan(a, b: OLBoolean): Boolean;
begin
  Result := (a.Value > b.Value) and a.HasValue and b.HasValue;
end;

class operator OLBoolean.GreaterThanOrEqual(a, b: OLBoolean): Boolean;
begin
  Result := ((a.Value >= b.Value) and (a.HasValue and b.HasValue)) or (a.IsNull() and b.IsNull());
end;

function OLBoolean.IfNull(b: OLBoolean): OLBoolean;
var
  Output: OLBoolean;
begin
  if HasValue then
    Output := Self
  else
    Output := b;

  Result := Output;
end;

function OLBoolean.IfThen(ATrue, AFalse: Currency): Currency;
var
  OutPut: Currency;
begin
  if Self then
    OutPut := ATrue
  else
    OutPut := AFalse;

  Result := OutPut;
end;

function OLBoolean.IfThen(ATrue, AFalse: Integer): integer;
var
  OutPut: Integer;
begin
  if Self then
    OutPut := ATrue
  else
    OutPut := AFalse;

  Result := OutPut;
end;

function OLBoolean.IfThen(ATrue, AFalse: Extended): Extended;
var
  OutPut: Extended;
begin
  if Self then
    OutPut := ATrue
  else
    OutPut := AFalse;

  Result := OutPut;
end;

function OLBoolean.IfThen(ATrue, AFalse: TDateTime): TDateTime;
var
  OutPut: TDateTime;
begin
  if Self then
    OutPut := ATrue
  else
    OutPut := AFalse;

  Result := OutPut;
end;

function OLBoolean.IfThen(ATrue, AFalse: string): string;
var
  OutPut: string;
begin
  if Self then
    OutPut := ATrue
  else
    OutPut := AFalse;

  Result := OutPut;
end;

class operator OLBoolean.Implicit(a: OLBoolean): Variant;
var
  OutPut: Variant;
begin
  if a.HasValue then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLBoolean.Implicit(a: Variant): OLBoolean;
var
  returnrec: OLBoolean;
  b: Boolean;
begin
  if VarIsNull(a) then
    returnrec.HasValue := false
  else
  begin
    if TryStrToBool(a, b) then
    begin
      returnrec.Value := b;
      returnrec.HasValue := true;
    end
    else
    begin
      raise Exception.Create('Value ''' + VarToStr(a) + ''' cannot be assigned to variable of OLBoolean type.');
    end;
  end;

  Result := returnrec;
end;

class operator OLBoolean.Implicit(a: OLBoolean): Boolean;
var
  myBoolean: Boolean;
begin
  if not a.HasValue then
    raise Exception.Create('Null cannot be used as Boolean value.');
  myBoolean := a.Value;
  Result := myBoolean;
end;

class operator OLBoolean.Implicit(a: Boolean): OLBoolean;
var
  returnrec: OLBoolean;
begin
  returnrec.Value := a;
  returnrec.HasValue := true;
  Result := returnrec;
end;

function OLBoolean.IsNull: Boolean;
begin
  Result := not HasValue;
end;

class operator OLBoolean.LessThan(a, b: OLBoolean): Boolean;
begin
  Result := (a.Value < b.Value) and a.HasValue and b.HasValue;
end;

class operator OLBoolean.LessThanOrEqual(a, b: OLBoolean): Boolean;
begin
  Result := ((a.Value <= b.Value) and (a.HasValue and b.HasValue)) or (a.IsNull() and b.IsNull());
end;

class operator OLBoolean.LogicalAnd(a, b: OLBoolean): OLBoolean;
var
  OutPut: OLBoolean;
begin
  OutPut.HasValue := a.HasValue and b.HasValue;
  OutPut.Value := a.Value and b.Value;

  Result := OutPut;
end;

class operator OLBoolean.LogicalNot(a: OLBoolean): OLBoolean;
var
  OutPut: OLBoolean;
begin
  OutPut.HasValue := a.HasValue;
  OutPut.Value := not a.Value;

  Result := OutPut;
end;

class operator OLBoolean.LogicalOr(a, b: OLBoolean): OLBoolean;
var
  OutPut: OLBoolean;
begin
  OutPut.HasValue := a.HasValue and b.HasValue;
  OutPut.Value := a.Value or b.Value;

  Result := OutPut;
end;

class operator OLBoolean.LogicalXor(a, b: OLBoolean): OLBoolean;
var
  OutPut: OLBoolean;
begin
  OutPut.HasValue := a.HasValue and b.HasValue;
  OutPut.Value := a.Value xor b.Value;

  Result := OutPut;
end;

class operator OLBoolean.NotEqual(a, b: OLBoolean): Boolean;
begin
  Result := ((a.Value <> b.Value) and a.HasValue and b.HasValue) or (a.HasValue <> b.HasValue);
end;

procedure OLBoolean.SetHasValue(Value: Boolean);
begin
  if Value then
    NullFlag := NonEmptyStr
  else
    NullFlag := EmptyStr;
end;

function OLBoolean.ToString: string;
var
  Output: string;
begin
  if HasValue then
    Output := BoolToStr(Value, true)
  else
    Output := '';

  Result := Output;
end;

end.
