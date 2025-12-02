unit IntegerHelperFunctions;

interface

function Instance_ToString(var i: integer): string;
function Instance_ToBoolean(var i: integer): Boolean;
function Instance_ToHexString(var i: integer): string; overload;
function Instance_ToHexString(var i: integer; const MinDigits: Integer):
    string; overload;
function Instance_ToSingle(var i: integer): Single;
function Instance_ToDouble(var i: integer): Double; inline;
function Instance_ToExtended(var i: integer): Extended; inline;

function Type_Size: Integer;
function Type_ToString(const Value: Integer): string;
function Type_Parse(const S: string): Integer;
function Type_TryParse(const S: string; out Value: Integer): Boolean;

implementation

uses
  System.SysUtils;

function Instance_ToString(var i: integer): string;
begin
  Result := i.ToString();
end;

function Instance_ToBoolean(var i: integer): Boolean;
begin
  Result := i.ToBoolean();
end;

function Instance_ToHexString(var i: integer): string; overload;
begin
  Result := i.ToHexString;
end;

function Instance_ToHexString(var i: integer; const MinDigits: Integer):
    string; overload;
begin
  Result := i.ToHexString(MinDigits);
end;

function Instance_ToSingle(var i: integer): Single;
begin
  Result := i.ToSingle();
end;

function Instance_ToDouble(var i: integer): Double; inline;
begin
 Result := i.ToDouble();
end;

function Instance_ToExtended(var i: integer): Extended; inline;
begin
  Result := i.ToExtended();
end;

function Type_Size: Integer;
begin
  Result := integer.Size;
end;

function Type_ToString(const Value: Integer): string;
begin
  Result := integer.ToString(Value);
end;

function Type_Parse(const S: string): Integer;
begin
  Result := integer.Parse(s);
end;

function Type_TryParse(const S: string; out Value: Integer): Boolean;
begin
  Result := integer.TryParse(s, Value);
end;

end.
