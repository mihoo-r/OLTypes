unit OLBooleanType;

interface

uses
  Variants, SysUtils, {$IF CompilerVersion >= 23.0} System.Classes {$ELSE} Classes {$IFEND};

type
  /// <summary>
  ///   A record type representing a boolean value with null-handling capabilities.
  /// </summary>
  OLBoolean = record
  private
    FValue: Boolean;
    {$IF CompilerVersion >= 34.0}
    FHasValue: Boolean;
    FOnChange: TNotifyEvent;
    {$ELSE}
    FHasValue: string;
    {$IFEND}

    function GetHasValue(): Boolean;
    procedure SetHasValue(const Value: Boolean);
    /// <summary>
    ///   Gets or sets whether the boolean has a value (is not null).
    /// </summary>
    property ValuePresent: Boolean read GetHasValue write SetHasValue;
  public
    /// <summary>
    ///   Checks if the boolean is null (has no value).
    /// </summary>
    function IsNull(): Boolean;
    /// <summary>
    ///   Converts the boolean to a string.
    /// </summary>
    function ToString(): string;
    /// <summary>
    ///   Converts the boolean to a SQL-safe string (value or NULL).
    /// </summary>
    function ToSQLString(): string;
    /// <summary>
    ///   Returns the current boolean if it has a value, otherwise returns the provided default value.
    /// </summary>
    function IfNull(const b: OLBoolean): OLBoolean;
    /// <summary>
    ///   Checks if the boolean has a value (is not null).
    /// </summary>
    function HasValue(): OLBoolean;
    /// <summary>
    ///   Returns the Boolean value, or a replacement Boolean if null.
    /// </summary>
    function AsBoolean(const NullReplacement: Boolean = False): Boolean;
    /// <summary>
    ///   Returns ATrue if the boolean is true, otherwise returns AFalse.
    /// </summary>
    function IfThen(const ATrue: string; const AFalse: string = ''): string; overload;
    /// <summary>
    ///   Returns ATrue if the boolean is true, otherwise returns AFalse.
    /// </summary>
    function IfThen(const ATrue: Integer; const AFalse: Integer): integer; overload;
    /// <summary>
    ///   Returns ATrue if the boolean is true, otherwise returns AFalse.
    /// </summary>
    function IfThen(const ATrue: Currency; const AFalse: Currency): Currency; overload;
    /// <summary>
    ///   Returns ATrue if the boolean is true, otherwise returns AFalse.
    /// </summary>
    function IfThen(const ATrue: Extended; const AFalse: Extended): Extended; overload;
    /// <summary>
    ///   Returns ATrue if the boolean is true, otherwise returns AFalse.
    /// </summary>
    function IfThen(const ATrue: TDateTime; const AFalse: TDateTime): TDateTime; overload;
    /// <summary>
    ///   Returns ATrue if the boolean is true, otherwise returns AFalse.
    /// </summary>
    function IfThen(const ATrue: Boolean; const AFalse: Boolean): Boolean; overload;

    class operator Implicit(const a: Boolean): OLBoolean;
    class operator Implicit(const a: OLBoolean): Boolean;
    class operator Implicit(const a: Variant): OLBoolean;
    class operator Implicit(const a: OLBoolean): Variant;

    class operator Equal(const a, b: OLBoolean): Boolean;
    class operator Equal(const a: OLBoolean; const b: Variant): Boolean;
    class operator NotEqual(const a, b: OLBoolean): Boolean;
    class operator GreaterThan(const a, b: OLBoolean): Boolean;
    class operator GreaterThanOrEqual(const a, b: OLBoolean): Boolean;
    class operator LessThan(const a, b: OLBoolean): Boolean;
    class operator LessThanOrEqual(const a, b: OLBoolean): Boolean;

    class operator LogicalNot(const a: OLBoolean): OLBoolean;
    class operator LogicalAnd(const a: OLBoolean; b: OLBoolean): OLBoolean;
    class operator LogicalOr(const a: OLBoolean; b: OLBoolean): OLBoolean;
    class operator LogicalXor(const a: OLBoolean; b: OLBoolean): OLBoolean;

    {$IF CompilerVersion >= 34.0}
    class operator Initialize(out Dest: OLBoolean);
    class operator Assign(var Dest: OLBoolean; const [ref] Src: OLBoolean);
    /// <summary>
    ///   Event handler for value changes.
    /// </summary>
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    {$IFEND}
  end;

  POLBoolean = ^OLBoolean;

implementation

const
  NonEmptyStr = ' ';



{ OLBoolean }

class operator OLBoolean.Equal(const a, b: OLBoolean): Boolean;
begin
  Result := ((a.FValue = b.FValue) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

class operator OLBoolean.Equal(const a: OLBoolean; const b: Variant): Boolean;
begin
  Result := ((a.FValue = b) and (a.ValuePresent and (b <> Null))) or (a.IsNull() and (b = Null));
end;

function OLBoolean.GetHasValue: Boolean;
begin
  {$IF CompilerVersion >= 34.0}
  Result := FHasValue;
  {$ELSE}
  Result := FHasValue = ' ';
  {$IFEND}
end;

class operator OLBoolean.GreaterThan(const a, b: OLBoolean): Boolean;
begin
  Result := (a.FValue > b.FValue) and a.ValuePresent and b.ValuePresent;
end;

class operator OLBoolean.GreaterThanOrEqual(const a, b: OLBoolean): Boolean;
begin
  Result := ((a.FValue >= b.FValue) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLBoolean.HasValue: OLBoolean;
begin
  Result := ValuePresent;
end;

function OLBoolean.IfNull(const b: OLBoolean): OLBoolean;
var
  Output: OLBoolean;
begin
  if ValuePresent then
    Output := Self
  else
    Output := b;

  Result := Output;
end;

function OLBoolean.AsBoolean(const NullReplacement: Boolean = False): Boolean;
begin
  Result := IfNull(NullReplacement);
end;

function OLBoolean.IfThen(const ATrue: Currency; const AFalse: Currency):
    Currency;
var
  OutPut: Currency;
begin
  if Self then
    OutPut := ATrue
  else
    OutPut := AFalse;

  Result := OutPut;
end;

function OLBoolean.IfThen(const ATrue: Integer; const AFalse: Integer): integer;
var
  OutPut: Integer;
begin
  if Self then
    OutPut := ATrue
  else
    OutPut := AFalse;

  Result := OutPut;
end;

function OLBoolean.IfThen(const ATrue: Extended; const AFalse: Extended):
    Extended;
var
  OutPut: Extended;
begin
  if Self then
    OutPut := ATrue
  else
    OutPut := AFalse;

  Result := OutPut;
end;

function OLBoolean.IfThen(const ATrue: TDateTime; const AFalse: TDateTime):
    TDateTime;
var
  OutPut: TDateTime;
begin
  if Self then
    OutPut := ATrue
  else
    OutPut := AFalse;

  Result := OutPut;
end;

function OLBoolean.IfThen(const ATrue: string; const AFalse: string = ''):
    string;
var
  OutPut: string;
begin
  if Self then
    OutPut := ATrue
  else
    OutPut := AFalse;

  Result := OutPut;
end;

class operator OLBoolean.Implicit(const a: OLBoolean): Variant;
var
  OutPut: Variant;
begin
  if a.ValuePresent then
    OutPut := a.FValue
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLBoolean.Implicit(const a: Variant): OLBoolean;
var
  OutPut: OLBoolean;
  b: Boolean;
begin
  if VarIsNull(a) then
    OutPut.ValuePresent := false
  else
  begin
    if TryStrToBool(a, b) then
    begin
      OutPut.FValue := b;
      OutPut.ValuePresent := true;
    end
    else
    begin
      raise Exception.Create('Value ''' + VarToStr(a) + ''' cannot be assigned to variable of OLBoolean type.');
    end;
  end;

  Result := OutPut;
end;

class operator OLBoolean.Implicit(const a: OLBoolean): Boolean;
var
  OutPut: Boolean;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as Boolean value.');
  OutPut := a.FValue;
  Result := OutPut;
end;

class operator OLBoolean.Implicit(const a: Boolean): OLBoolean;
var
  OutPut: OLBoolean;
begin
  OutPut.FValue := a;
  OutPut.ValuePresent := true;
  Result := OutPut;
end;

function OLBoolean.IsNull: Boolean;
begin
  Result := not ValuePresent;
end;

class operator OLBoolean.LessThan(const a, b: OLBoolean): Boolean;
begin
  Result := (a.FValue < b.FValue) and a.ValuePresent and b.ValuePresent;
end;

class operator OLBoolean.LessThanOrEqual(const a, b: OLBoolean): Boolean;
begin
  Result := ((a.FValue <= b.FValue) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

class operator OLBoolean.LogicalAnd(const a: OLBoolean; b: OLBoolean):
    OLBoolean;
var
  OutPut: OLBoolean;
begin
  OutPut.ValuePresent := a.ValuePresent and b.ValuePresent;
  OutPut.FValue := a.FValue and b.FValue;

  Result := OutPut;
end;

class operator OLBoolean.LogicalNot(const a: OLBoolean): OLBoolean;
var
  OutPut: OLBoolean;
begin
  OutPut.ValuePresent := a.ValuePresent;
  OutPut.FValue := not a.FValue;

  Result := OutPut;
end;

class operator OLBoolean.LogicalOr(const a: OLBoolean; b: OLBoolean): OLBoolean;
var
  OutPut: OLBoolean;
begin
  OutPut.ValuePresent := a.ValuePresent and b.ValuePresent;
  OutPut.FValue := a.FValue or b.FValue;

  Result := OutPut;
end;

class operator OLBoolean.LogicalXor(const a: OLBoolean; b: OLBoolean):
    OLBoolean;
var
  OutPut: OLBoolean;
begin
  OutPut.ValuePresent := a.ValuePresent and b.ValuePresent;
  OutPut.FValue := a.FValue xor b.FValue;

  Result := OutPut;
end;

{$IF CompilerVersion >= 34.0}
class operator OLBoolean.Initialize(out Dest: OLBoolean);
begin
  Dest.FHasValue := False;
  Dest.FOnChange := nil;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
class operator OLBoolean.Assign(var Dest: OLBoolean; const [ref] Src: OLBoolean);
begin
  Dest.FValue := Src.FValue;
  Dest.FHasValue := Src.FHasValue;

  if Assigned(Dest.FOnChange) then
    Dest.FOnChange(nil);
end;
{$IFEND}

class operator OLBoolean.NotEqual(const a, b: OLBoolean): Boolean;
begin
  Result := ((a.FValue <> b.FValue) and a.ValuePresent and b.ValuePresent) or (a.ValuePresent <> b.ValuePresent);
end;

procedure OLBoolean.SetHasValue(const Value: Boolean);
begin
  {$IF CompilerVersion >= 34.0}
  FHasValue := Value;
  {$ELSE}
  if Value then
    FHasValue := ' '
  else
    FHasValue := '';
  {$IFEND}
end;

function OLBoolean.ToSQLString: string;
var
  OutPut: string;
begin
  if HasValue then
    OutPut := ToString()
  else
    OutPut := 'NULL';

  Result := OutPut;
end;

function OLBoolean.ToString: string;
var
  Output: string;
begin
  if ValuePresent then
    Output := BoolToStr(FValue, true)
  else
    Output := '';

  Result := Output;
end;

function OLBoolean.IfThen(const ATrue: Boolean; const AFalse: Boolean): Boolean;
var
  OutPut: Boolean;
begin
  if Self then
    OutPut := ATrue
  else
    OutPut := AFalse;

  Result := OutPut;
end;

end.
