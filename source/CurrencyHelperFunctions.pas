unit CurrencyHelperFunctions;

interface

{$IF CompilerVersion >= 24.0}

uses
  System.SysUtils;

// --- Instance Functions (operating on 'c: Currency') ---

function Instance_ToString(var c: Currency; const AFormatSettings: TFormatSettings): string; overload; inline;
function Instance_ToString(var c: Currency): string; overload; inline;

function Instance_Frac(var c: Currency): Currency; inline;
function Instance_Ceil(var c: Currency): Int64; inline;
function Instance_Floor(var c: Currency): Int64; inline;
function Instance_Trunc(var c: Currency): Int64; inline;

// --- Type Functions (Static methods) ---

function Type_Size: Integer;
function Type_ToString(const Value: Currency; const AFormatSettings: TFormatSettings): string; overload;
function Type_ToString(const Value: Currency): string; overload;
function Type_Parse(const S: string; const AFormatSettings: TFormatSettings): Currency; overload;
function Type_Parse(const S: string): Currency; overload;
function Type_TryParse(const S: string; out Value: Currency; const AFormatSettings: TFormatSettings): Boolean; overload;
function Type_TryParse(const S: string; out Value: Currency): Boolean; overload;

{$IFEND} //XE3 +

implementation

{$IF CompilerVersion >= 24.0}

function Instance_ToString(var c: Currency; const AFormatSettings: TFormatSettings): string; overload;
begin
  // Converts the Currency value to its string representation using specific formatting settings.
  Result := c.ToString(AFormatSettings);
end;

function Instance_ToString(var c: Currency): string; overload;
begin
  // Converts the Currency value to its string representation using default formatting.
  Result := c.ToString();
end;

function Instance_Frac(var c: Currency): Currency;
begin
  // Returns the fractional part of the Currency value.
  Result := c.Frac;
end;

function Instance_Ceil(var c: Currency): Int64;
begin
  // Returns the smallest integer greater than or equal to the Currency value (ceiling).
  Result := c.Ceil;
end;

function Instance_Floor(var c: Currency): Int64;
begin
  // Returns the largest integer less than or equal to the Currency value (floor).
  Result := c.Floor;
end;

function Instance_Trunc(var c: Currency): Int64;
begin
  // Returns the integer part of the Currency value (truncating the fraction).
  Result := c.Trunc;
end;

function Type_Size: Integer;
begin
  // Returns the size of the Currency type in bytes.
  Result := Currency.Size;
end;

function Type_ToString(const Value: Currency; const AFormatSettings: TFormatSettings): string; overload;
begin
  // Converts a given Currency value to its string representation using specific formatting settings.
  Result := Currency.ToString(Value, AFormatSettings);
end;

function Type_ToString(const Value: Currency): string; overload;
begin
  // Converts a given Currency value to its string representation using default formatting.
  Result := Currency.ToString(Value);
end;

function Type_Parse(const S: string; const AFormatSettings: TFormatSettings): Currency; overload;
begin
  // Converts a string to a Currency value using specific formatting settings.
  Result := Currency.Parse(S, AFormatSettings);
end;

function Type_Parse(const S: string): Currency; overload;
begin
  // Converts a string to a Currency value using default formatting.
  Result := Currency.Parse(S);
end;

function Type_TryParse(const S: string; out Value: Currency; const AFormatSettings: TFormatSettings): Boolean; overload;
begin
  // Attempts to convert a string to a Currency value using specific formatting settings.
  Result := Currency.TryParse(S, Value, AFormatSettings);
end;

function Type_TryParse(const S: string; out Value: Currency): Boolean; overload;
begin
  // Attempts to convert a string to a Currency value using default formatting.
  Result := Currency.TryParse(S, Value);
end;

{$IFEND} //XE3 +

end.
