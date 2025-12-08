unit Int64HelperFunctions;

interface

uses
  System.SysUtils;

// --- Instance Functions (operating on 'i: Int64') ---

function Instance_ToString(var i: Int64): string; overload; inline;
function Instance_ToBoolean(var i: Int64): Boolean; inline;
function Instance_ToHexString(var i: Int64): string; overload; inline;
function Instance_ToHexString(var i: Int64; const MinDigits: Integer): string; overload; inline;
function Instance_ToSingle(var i: Int64): Single; inline;
function Instance_ToDouble(var i: Int64): Double; inline;
function Instance_ToExtended(var i: Int64): Extended; inline;

// --- Type Functions (Static methods) ---

function Type_Size: Integer;
function Type_ToString(const Value: Int64): string; overload;
function Type_Parse(const S: string): Int64;
function Type_TryParse(const S: string; out Value: Int64): Boolean;


implementation

function Instance_ToString(var i: Int64): string; overload;
begin
  // Converts the 64-bit integer value to its string representation.
  Result := i.ToString();
end;

function Instance_ToBoolean(var i: Int64): Boolean;
begin
  // Converts the 64-bit integer value to its boolean representation (0 is False, any other value is True).
  Result := i.ToBoolean();
end;

function Instance_ToHexString(var i: Int64): string; overload;
begin
  // Converts the 64-bit integer value to a hexadecimal string representation.
  Result := i.ToHexString;
end;

function Instance_ToHexString(var i: Int64; const MinDigits: Integer): string; overload;
begin
  // Converts the 64-bit integer value to a hexadecimal string representation, ensuring minimum digit count.
  Result := i.ToHexString(MinDigits);
end;

function Instance_ToSingle(var i: Int64): Single;
begin
  // Converts the 64-bit integer value to a Single (32-bit floating point).
  Result := i.ToSingle();
end;

function Instance_ToDouble(var i: Int64): Double;
begin
  // Converts the 64-bit integer value to a Double (64-bit floating point).
  Result := i.ToDouble();
end;

function Instance_ToExtended(var i: Int64): Extended;
begin
  // Converts the 64-bit integer value to an Extended (80-bit floating point).
  Result := i.ToExtended();
end;

function Type_Size: Integer;
begin
  // Returns the size of the Int64 type in bytes (which is 8).
  Result := Int64.Size;
end;

function Type_ToString(const Value: Int64): string; overload;
begin
  // Converts a given Int64 value to its string representation.
  Result := Int64.ToString(Value);
end;

function Type_Parse(const S: string): Int64;
begin
  // Converts a string representation to an Int64 value.
  Result := Int64.Parse(S);
end;

function Type_TryParse(const S: string; out Value: Int64): Boolean;
begin
  // Attempts to convert a string representation to an Int64 value, returning True if successful.
  Result := Int64.TryParse(S, Value);
end;

end.
