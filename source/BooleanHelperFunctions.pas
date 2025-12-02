unit BooleanHelperFunctions;

interface

uses
  System.SysUtils;

// --- Instance Functions (operating on 'b: Boolean') ---

function Instance_ToInteger(var b: Boolean): Integer; inline;
function Instance_ToString(var b: Boolean; UseBoolStrs: TUseBoolStrs = TUseBoolStrs.False): string; overload; inline;

// --- Type Functions (Static methods) ---

function Type_Size: Integer;
function Type_ToString(const Value: Boolean; UseBoolStrs: TUseBoolStrs = TUseBoolStrs.False): string; overload;
function Type_Parse(const S: string): Boolean;
function Type_TryToParse(const S: string; out Value: Boolean): Boolean;


implementation

function Instance_ToInteger(var b: Boolean): Integer;
begin
  // Converts the boolean value to its integer representation (1 for True, 0 for False).
  Result := b.ToInteger;
end;

function Instance_ToString(var b: Boolean; UseBoolStrs: TUseBoolStrs = TUseBoolStrs.False): string; overload;
begin
  // Converts the boolean value to its string representation ('True'/'False' or '1'/'0').
  Result := b.ToString(UseBoolStrs);
end;

function Type_Size: Integer;
begin
  // Returns the size of the Boolean type in bytes.
  Result := Boolean.Size;
end;

function Type_ToString(const Value: Boolean; UseBoolStrs: TUseBoolStrs = TUseBoolStrs.False): string; overload;
begin
  // Converts a given boolean value to its string representation.
  Result := Boolean.ToString(Value, UseBoolStrs);
end;

function Type_Parse(const S: string): Boolean;
begin
  // Converts a string representation (e.g., 'True', 'False', '1', '0') to a Boolean value.
  Result := Boolean.Parse(S);
end;

function Type_TryToParse(const S: string; out Value: Boolean): Boolean;
begin
  // Attempts to convert a string representation to a Boolean value, returning True if successful.
  Result := Boolean.TryToParse(S, Value);
end;

end.
