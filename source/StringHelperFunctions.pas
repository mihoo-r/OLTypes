unit StringHelperFunctions;

interface

{$IF CompilerVersion >= 24.0}
uses
  System.Generics.Collections,
  System.SysUtils;

// --- Instance Functions (operating on 's: string') ---

/// <summary>Compares this string instance to another string.</summary>
function Instance_CompareTo(const s: string; const strB: string): Integer;
/// <summary>Returns true if the string contains the specified value.</summary>
function Instance_Contains(const s: string; const Value: string): Boolean;
/// <summary>Copies a specified number of characters from a specified position in this instance to a specified position in an array of Unicode characters.</summary>
procedure Instance_CopyTo(const s: string; SourceIndex: Integer; var destination: array of Char; DestinationIndex: Integer; Count: Integer);
/// <summary>Counts the occurrences of a character in the string.</summary>
function Instance_CountChar(const s: string; const C: Char): Integer;
/// <summary>Returns a copy of this string with the quote characters removed.</summary>
function Instance_DeQuotedString(const s: string): string; overload;
/// <summary>Returns a copy of this string with the specified quote characters removed.</summary>
function Instance_DeQuotedString(const s: string; const QuoteChar: Char): string; overload;
/// <summary>Determines whether the end of this string instance matches the specified string.</summary>
function Instance_EndsWith(const s: string; const Value: string): Boolean; overload;
/// <summary>Determines whether the end of this string instance matches the specified string, ignoring case if requested.</summary>
function Instance_EndsWith(const s: string; const Value: string; IgnoreCase: Boolean): Boolean; overload;
/// <summary>Determines whether this instance and another specified string have the same value.</summary>
function Instance_Equals(const s: string; const Value: string): Boolean; overload;
/// <summary>Returns the hash code for this string.</summary>
function Instance_GetHashCode(const s: string): Integer;
/// <summary>Reports the zero-based index of the first occurrence of the specified Unicode character in this string.</summary>
function Instance_IndexOf(const s: string; Value: Char): Integer; overload;
/// <summary>Reports the zero-based index of the first occurrence of the specified string in this instance.</summary>
function Instance_IndexOf(const s: string; const Value: string): Integer; overload;
function Instance_IndexOf(const s: string; Value: Char; StartIndex: Integer): Integer; overload;
function Instance_IndexOf(const s: string; const Value: string; StartIndex: Integer): Integer; overload;
function Instance_IndexOf(const s: string; Value: Char; StartIndex: Integer; Count: Integer): Integer; overload;
function Instance_IndexOf(const s: string; const Value: string; StartIndex: Integer; Count: Integer): Integer; overload;
/// <summary>Reports the zero-based index of the first occurrence in this instance of any character in a specified array of Unicode characters.</summary>
function Instance_IndexOfAny(const s: string; const AnyOf: array of Char): Integer; overload;
function Instance_IndexOfAny(const s: string; const AnyOf: array of Char; StartIndex: Integer): Integer; overload;
function Instance_IndexOfAny(const s: string; const AnyOf: array of Char; StartIndex: Integer; Count: Integer): Integer; overload;
function Instance_IndexOfAnyUnquoted(const s: string; const AnyOf: array of Char; StartQuote, EndQuote: Char): Integer; overload;
function Instance_IndexOfAnyUnquoted(const s: string; const AnyOf: array of Char; StartQuote, EndQuote: Char; StartIndex: Integer): Integer; overload;
function Instance_IndexOfAnyUnquoted(const s: string; const AnyOf: array of Char; StartQuote, EndQuote: Char; StartIndex: Integer; Count: Integer): Integer; overload;
/// <summary>Returns a new string in which a specified string is inserted at a specified index position in this instance.</summary>
function Instance_Insert(const s: string; StartIndex: Integer; const Value: string): string;
/// <summary>Indicates whether the character at the specified position in this string is categorized as a delimiter.</summary>
function Instance_IsDelimiter(const s: string; const Delimiters: string; Index: Integer): Boolean;
/// <summary>Indicates whether this string is empty.</summary>
function Instance_IsEmpty(const s: string): Boolean;
/// <summary>Returns the index position of the last occurrence of a specified character in this instance.</summary>
function Instance_LastDelimiter(const s: string; const Delims: string): Integer; overload;
function Instance_LastDelimiter(const s: string; const Delims: TSysCharSet): Integer; overload;
/// <summary>Reports the zero-based index position of the last occurrence of a specified Unicode character or string within this instance.</summary>
function Instance_LastIndexOf(const s: string; Value: Char): Integer; overload;
function Instance_LastIndexOf(const s: string; const Value: string): Integer; overload;
function Instance_LastIndexOf(const s: string; Value: Char; StartIndex: Integer): Integer; overload;
function Instance_LastIndexOf(const s: string; const Value: string; StartIndex: Integer): Integer; overload;
function Instance_LastIndexOf(const s: string; Value: Char; StartIndex: Integer; Count: Integer): Integer; overload;
function Instance_LastIndexOf(const s: string; const Value: string; StartIndex: Integer; Count: Integer): Integer; overload;
function Instance_LastIndexOfAny(const s: string; const AnyOf: array of Char): Integer; overload;
function Instance_LastIndexOfAny(const s: string; const AnyOf: array of Char; StartIndex: Integer): Integer; overload;
function Instance_LastIndexOfAny(const s: string; const AnyOf: array of Char; StartIndex: Integer; Count: Integer): Integer; overload;
/// <summary>Returns a new string that right-aligns the characters in this instance by padding them with spaces or a specified character on the left.</summary>
function Instance_PadLeft(const s: string; TotalWidth: Integer): string; overload;
function Instance_PadLeft(const s: string; TotalWidth: Integer; PaddingChar: Char): string; overload;
/// <summary>Returns a new string that left-aligns the characters in this instance by padding them with spaces or a specified character on the right.</summary>
function Instance_PadRight(const s: string; TotalWidth: Integer): string; overload;
function Instance_PadRight(const s: string; TotalWidth: Integer; PaddingChar: Char): string; overload;
/// <summary>Returns a quoted string.</summary>
function Instance_QuotedString(const s: string): string; overload;
/// <summary>Returns a quoted string using the specified quote character.</summary>
function Instance_QuotedString(const s: string; const QuoteChar: Char): string; overload;
/// <summary>Returns a new string in which a specified number of characters in the current instance beginning at a specified position have been deleted.</summary>
function Instance_Remove(const s: string; StartIndex: Integer): string; overload;
function Instance_Remove(const s: string; StartIndex: Integer; Count: Integer): string; overload;
/// <summary>Returns a new string in which all occurrences of a specified Unicode character or string in the current instance are replaced with another specified Unicode character or string.</summary>
function Instance_Replace(const s: string; OldChar: Char; NewChar: Char): string; overload;
function Instance_Replace(const s: string; OldChar: Char; NewChar: Char; ReplaceFlags: TReplaceFlags): string; overload;
function Instance_Replace(const s: string; const OldValue: string; const NewValue: string): string; overload;
function Instance_Replace(const s: string; const OldValue: string; const NewValue: string; ReplaceFlags: TReplaceFlags): string; overload;
/// <summary>Splits a string into substrings that are based on the characters in an array.</summary>
function Instance_Split(const s: string; const Separator: array of Char): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of Char; Count: Integer): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of Char; Options: TStringSplitOptions): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of Char; Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
/// <summary>Splits a string into substrings that are based on the strings in an array.</summary>
function Instance_Split(const s: string; const Separator: array of string): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of string; Count: Integer): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of string; Options: TStringSplitOptions): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of string; Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of Char; Quote: Char): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of Char; QuoteStart, QuoteEnd: Char): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of Char; QuoteStart, QuoteEnd: Char; Options: TStringSplitOptions): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of Char; QuoteStart, QuoteEnd: Char; Count: Integer): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of Char; QuoteStart, QuoteEnd: Char; Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of string; Quote: Char): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of string; QuoteStart, QuoteEnd: Char): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of string; QuoteStart, QuoteEnd: Char; Options: TStringSplitOptions): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of string; QuoteStart, QuoteEnd: Char; Count: Integer): TArray<string>; overload;
function Instance_Split(const s: string; const Separator: array of string; QuoteStart, QuoteEnd: Char; Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
/// <summary>Determines whether the beginning of this string instance matches the specified string.</summary>
function Instance_StartsWith(const s: string; const Value: string): Boolean; overload;
function Instance_StartsWith(const s: string; const Value: string; IgnoreCase: Boolean): Boolean; overload;
/// <summary>Retrieves a substring from this instance.</summary>
function Instance_Substring(const s: string; StartIndex: Integer): string; overload;
function Instance_Substring(const s: string; StartIndex: Integer; Length: Integer): string; overload;
/// <summary>Converts the string to a Boolean value.</summary>
function Instance_ToBoolean(const s: string): Boolean; overload;
/// <summary>Converts the string to an Integer value.</summary>
function Instance_ToInteger(const s: string): Integer; overload;
/// <summary>Converts the string to an Int64 value.</summary>
function Instance_ToInt64(const s: string): Int64; overload;
/// <summary>Converts the string to a Single value.</summary>
function Instance_ToSingle(const s: string): Single; overload;
/// <summary>Converts the string to a Double value.</summary>
function Instance_ToDouble(const s: string): Double; overload;
/// <summary>Converts the string to an Extended value.</summary>
function Instance_ToExtended(const s: string): Extended; overload;
/// <summary>Copies the characters in this instance to a Unicode character array.</summary>
function Instance_ToCharArray(const s: string): TArray<Char>; overload;
function Instance_ToCharArray(const s: string; StartIndex: Integer; Length: Integer): TArray<Char>; overload;
/// <summary>Returns a copy of this string converted to lowercase.</summary>
function Instance_ToLower(const s: string): string; overload;
function Instance_ToLower(const s: string; LocaleID: TLocaleID): string; overload;
function Instance_ToLowerInvariant(const s: string): string;
/// <summary>Returns a copy of this string converted to uppercase.</summary>
function Instance_ToUpper(const s: string): string; overload;
function Instance_ToUpper(const s: string; LocaleID: TLocaleID): string; overload;
function Instance_ToUpperInvariant(const s: string): string;
/// <summary>Removes all leading and trailing occurrences of a set of characters from the current string.</summary>
function Instance_Trim(const s: string): string; overload;
/// <summary>Removes all leading occurrences of a set of characters from the current string.</summary>
function Instance_TrimLeft(const s: string): string; overload;
/// <summary>Removes all trailing occurrences of a set of characters from the current string.</summary>
function Instance_TrimRight(const s: string): string; overload;
function Instance_Trim(const s: string; const TrimChars: array of Char): string; overload;
function Instance_TrimLeft(const s: string; const TrimChars: array of Char): string; overload;
function Instance_TrimRight(const s: string; const TrimChars: array of Char): string; overload;


// --- Type Functions (Static methods) ---

/// <summary>Creates a string from a character repeated a specified number of times.</summary>
function Type_Create(C: Char; Count: Integer): string; overload;
function Type_Create(const Value: array of Char; StartIndex: Integer; Length: Integer): string; overload;
function Type_Create(const Value: array of Char): string; overload;
/// <summary>Compares two specified String objects.</summary>
function Type_Compare(const StrA: string; const StrB: string): Integer; overload;
function Type_Compare(const StrA: string; const StrB: string; LocaleID: TLocaleID): Integer; overload;
function Type_Compare(const StrA: string; const StrB: string; IgnoreCase: Boolean): Integer; overload;
function Type_Compare(const StrA: string; const StrB: string; IgnoreCase: Boolean; LocaleID: TLocaleID): Integer; overload;
function Type_Compare(const StrA: string; const StrB: string; Options: TCompareOptions): Integer; overload;
function Type_Compare(const StrA: string; const StrB: string; Options: TCompareOptions; LocaleID: TLocaleID): Integer; overload;
function Type_Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer): Integer; overload;
function Type_Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; LocaleID: TLocaleID): Integer; overload;
function Type_Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; IgnoreCase: Boolean): Integer; overload;
function Type_Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; IgnoreCase: Boolean; LocaleID: TLocaleID): Integer; overload;
function Type_Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; Options: TCompareOptions): Integer; overload;
function Type_Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; Options: TCompareOptions; LocaleID: TLocaleID): Integer; overload;
/// <summary>Compares two specified String objects object by evaluating the numeric values of the corresponding Char objects in each string.</summary>
function Type_CompareOrdinal(const StrA: string; const StrB: string): Integer; overload;
function Type_CompareOrdinal(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer): Integer; overload;
/// <summary>Compares two specified String objects, ignoring or honoring their case.</summary>
function Type_CompareText(const StrA: string; const StrB: string): Integer;
/// <summary>Converts the value of an object to its equivalent string representation.</summary>
function Type_Parse(const Value: Integer): string; overload;
function Type_Parse(const Value: Int64): string; overload;
function Type_Parse(const Value: Boolean): string; overload;
function Type_Parse(const Value: Extended): string; overload;
/// <summary>Converts the string representation of a boolean to its Boolean equivalent.</summary>
function Type_ToBoolean(const S: string): Boolean; overload;
/// <summary>Converts the string representation of a number to its 32-bit signed integer equivalent.</summary>
function Type_ToInteger(const S: string): Integer; overload;
/// <summary>Converts the string representation of a number to its 64-bit signed integer equivalent.</summary>
function Type_ToInt64(const S: string): Int64; overload;
/// <summary>Converts the string representation of a number to its Single-precision floating-point number equivalent.</summary>
function Type_ToSingle(const S: string): Single; overload;
/// <summary>Converts the string representation of a number to its Double-precision floating-point number equivalent.</summary>
function Type_ToDouble(const S: string): Double; overload;
/// <summary>Converts the string representation of a number to its Extended-precision floating-point number equivalent.</summary>
function Type_ToExtended(const S: string): Extended; overload;
/// <summary>Returns a copy of this string converted to lowercase.</summary>
function Type_LowerCase(const S: string): string; overload;
function Type_LowerCase(const S: string; LocaleOptions: TLocaleOptions): string; overload;
/// <summary>Returns a copy of this string converted to uppercase.</summary>
function Type_UpperCase(const S: string): string; overload;
function Type_UpperCase(const S: string; LocaleOptions: TLocaleOptions): string; overload;
/// <summary>Creates a new instance of String with the same value as a specified String.</summary>
function Type_Copy(const Str: string): string;
/// <summary>Determines whether the end of the text matches the string.</summary>
function Type_EndsText(const ASubText, AText: string): Boolean;
/// <summary>Determines whether two specified String objects have the same value.</summary>
function Type_Equals(const a: string; const b: string): Boolean; overload;
/// <summary>Replaces the format item in a specified string with the string representation of a corresponding object in a specified array.</summary>
function Type_Format(const Format: string; const args: array of const): string; overload;
/// <summary>Indicates whether the specified string is null or an Empty string.</summary>
function Type_IsNullOrEmpty(const Value: string): Boolean;
/// <summary>Indicates whether a specified string is null, empty, or consists only of white-space characters.</summary>
function Type_IsNullOrWhiteSpace(const Value: string): Boolean;
/// <summary>Concatenates all the elements of a string array, using the specified separator between each element.</summary>
function Type_Join(const Separator: string; const Values: array of const): string; overload;
function Type_Join(const Separator: string; const Values: array of string): string; overload;
function Type_Join(const Separator: string; const Values: IEnumerator<string>): string; overload;
function Type_Join(const Separator: string; const Values: IEnumerable<string>): string; overload;
function Type_Join(const Separator: string; const Values: array of string; StartIndex: Integer; Count: Integer): string; overload;
/// <summary>Determines whether the beginning of the text matches the string.</summary>
function Type_StartsText(const ASubText, AText: string): Boolean;

{$IFEND} //XE3 +
implementation

{$IF CompilerVersion >= 24.0}

uses
  System.RTLConsts; // Needed for TStringHelper implementation details, e.g. TCompareOptions

// --- Implementation of Instance Functions ---

function Instance_CompareTo(const s: string; const strB: string): Integer;
begin
  Result := s.CompareTo(strB);
end;

function Instance_Contains(const s: string; const Value: string): Boolean;
begin
  Result := s.Contains(Value);
end;

procedure Instance_CopyTo(const s: string; SourceIndex: Integer; var destination: array of Char; DestinationIndex: Integer; Count: Integer);
begin
  // Note: 's' is 'const' here, but the destination array is 'var'
  s.CopyTo(SourceIndex, destination, DestinationIndex, Count);
end;

function Instance_CountChar(const s: string; const C: Char): Integer;
begin
  Result := s.CountChar(C);
end;

function Instance_DeQuotedString(const s: string): string; overload;
begin
  Result := s.DeQuotedString;
end;

function Instance_DeQuotedString(const s: string; const QuoteChar: Char): string; overload;
begin
  Result := s.DeQuotedString(QuoteChar);
end;

function Instance_EndsWith(const s: string; const Value: string): Boolean; overload;
begin
  Result := s.EndsWith(Value);
end;

function Instance_EndsWith(const s: string; const Value: string; IgnoreCase: Boolean): Boolean; overload;
begin
  Result := s.EndsWith(Value, IgnoreCase);
end;

function Instance_Equals(const s: string; const Value: string): Boolean; overload;
begin
  Result := s.Equals(Value);
end;

function Instance_GetHashCode(const s: string): Integer;
begin
  Result := s.GetHashCode;
end;

function Instance_IndexOf(const s: string; Value: Char): Integer; overload;
begin
  Result := s.IndexOf(Value);
end;

function Instance_IndexOf(const s: string; const Value: string): Integer; overload;
begin
  Result := s.IndexOf(Value);
end;

function Instance_IndexOf(const s: string; Value: Char; StartIndex: Integer): Integer; overload;
begin
  Result := s.IndexOf(Value, StartIndex);
end;

function Instance_IndexOf(const s: string; const Value: string; StartIndex: Integer): Integer; overload;
begin
  Result := s.IndexOf(Value, StartIndex);
end;

function Instance_IndexOf(const s: string; Value: Char; StartIndex: Integer; Count: Integer): Integer; overload;
begin
  Result := s.IndexOf(Value, StartIndex, Count);
end;

function Instance_IndexOf(const s: string; const Value: string; StartIndex: Integer; Count: Integer): Integer; overload;
begin
  Result := s.IndexOf(Value, StartIndex, Count);
end;

function Instance_IndexOfAny(const s: string; const AnyOf: array of Char): Integer; overload;
begin
  Result := s.IndexOfAny(AnyOf);
end;

function Instance_IndexOfAny(const s: string; const AnyOf: array of Char; StartIndex: Integer): Integer; overload;
begin
  Result := s.IndexOfAny(AnyOf, StartIndex);
end;

function Instance_IndexOfAny(const s: string; const AnyOf: array of Char; StartIndex: Integer; Count: Integer): Integer; overload;
begin
  Result := s.IndexOfAny(AnyOf, StartIndex, Count);
end;

function Instance_IndexOfAnyUnquoted(const s: string; const AnyOf: array of Char; StartQuote, EndQuote: Char): Integer; overload;
begin
  Result := s.IndexOfAnyUnquoted(AnyOf, StartQuote, EndQuote);
end;

function Instance_IndexOfAnyUnquoted(const s: string; const AnyOf: array of Char; StartQuote, EndQuote: Char; StartIndex: Integer): Integer; overload;
begin
  Result := s.IndexOfAnyUnquoted(AnyOf, StartQuote, EndQuote, StartIndex);
end;

function Instance_IndexOfAnyUnquoted(const s: string; const AnyOf: array of Char; StartQuote, EndQuote: Char; StartIndex: Integer; Count: Integer): Integer; overload;
begin
  Result := s.IndexOfAnyUnquoted(AnyOf, StartQuote, EndQuote, StartIndex, Count);
end;

function Instance_Insert(const s: string; StartIndex: Integer; const Value: string): string;
begin
  Result := s.Insert(StartIndex, Value);
end;

function Instance_IsDelimiter(const s: string; const Delimiters: string; Index: Integer): Boolean;
begin
  Result := s.IsDelimiter(Delimiters, Index);
end;

function Instance_IsEmpty(const s: string): Boolean;
begin
  Result := s.IsEmpty;
end;

function Instance_LastDelimiter(const s: string; const Delims: string): Integer; overload;
begin
  Result := s.LastDelimiter(Delims);
end;

function Instance_LastDelimiter(const s: string; const Delims: TSysCharSet): Integer; overload;
begin
  Result := s.LastDelimiter(Delims);
end;

function Instance_LastIndexOf(const s: string; Value: Char): Integer; overload;
begin
  Result := s.LastIndexOf(Value);
end;

function Instance_LastIndexOf(const s: string; const Value: string): Integer; overload;
begin
  Result := s.LastIndexOf(Value);
end;

function Instance_LastIndexOf(const s: string; Value: Char; StartIndex: Integer): Integer; overload;
begin
  Result := s.LastIndexOf(Value, StartIndex);
end;

function Instance_LastIndexOf(const s: string; const Value: string; StartIndex: Integer): Integer; overload;
begin
  Result := s.LastIndexOf(Value, StartIndex);
end;

function Instance_LastIndexOf(const s: string; Value: Char; StartIndex: Integer; Count: Integer): Integer; overload;
begin
  Result := s.LastIndexOf(Value, StartIndex, Count);
end;

function Instance_LastIndexOf(const s: string; const Value: string; StartIndex: Integer; Count: Integer): Integer; overload;
begin
  Result := s.LastIndexOf(Value, StartIndex, Count);
end;

function Instance_LastIndexOfAny(const s: string; const AnyOf: array of Char): Integer; overload;
begin
  Result := s.LastIndexOfAny(AnyOf);
end;

function Instance_LastIndexOfAny(const s: string; const AnyOf: array of Char; StartIndex: Integer): Integer; overload;
begin
  Result := s.LastIndexOfAny(AnyOf, StartIndex);
end;

function Instance_LastIndexOfAny(const s: string; const AnyOf: array of Char; StartIndex: Integer; Count: Integer): Integer; overload;
begin
  Result := s.LastIndexOfAny(AnyOf, StartIndex, Count);
end;

function Instance_PadLeft(const s: string; TotalWidth: Integer): string; overload;
begin
  Result := s.PadLeft(TotalWidth);
end;

function Instance_PadLeft(const s: string; TotalWidth: Integer; PaddingChar: Char): string; overload;
begin
  Result := s.PadLeft(TotalWidth, PaddingChar);
end;

function Instance_PadRight(const s: string; TotalWidth: Integer): string; overload;
begin
  Result := s.PadRight(TotalWidth);
end;

function Instance_PadRight(const s: string; TotalWidth: Integer; PaddingChar: Char): string; overload;
begin
  Result := s.PadRight(TotalWidth, PaddingChar);
end;

function Instance_QuotedString(const s: string): string; overload;
begin
  Result := s.QuotedString;
end;

function Instance_QuotedString(const s: string; const QuoteChar: Char): string; overload;
begin
  Result := s.QuotedString(QuoteChar);
end;

function Instance_Remove(const s: string; StartIndex: Integer): string; overload;
begin
  Result := s.Remove(StartIndex);
end;

function Instance_Remove(const s: string; StartIndex: Integer; Count: Integer): string; overload;
begin
  Result := s.Remove(StartIndex, Count);
end;

function Instance_Replace(const s: string; OldChar: Char; NewChar: Char): string; overload;
begin
  Result := s.Replace(OldChar, NewChar);
end;

function Instance_Replace(const s: string; OldChar: Char; NewChar: Char; ReplaceFlags: TReplaceFlags): string; overload;
begin
  Result := s.Replace(OldChar, NewChar, ReplaceFlags);
end;

function Instance_Replace(const s: string; const OldValue: string; const NewValue: string): string; overload;
begin
  Result := s.Replace(OldValue, NewValue);
end;

function Instance_Replace(const s: string; const OldValue: string; const NewValue: string; ReplaceFlags: TReplaceFlags): string; overload;
begin
  Result := s.Replace(OldValue, NewValue, ReplaceFlags);
end;

function Instance_Split(const s: string; const Separator: array of Char): TArray<string>; overload;
begin
  Result := s.Split(Separator);
end;

function Instance_Split(const s: string; const Separator: array of Char; Count: Integer): TArray<string>; overload;
begin
  Result := s.Split(Separator, Count);
end;

function Instance_Split(const s: string; const Separator: array of Char; Options: TStringSplitOptions): TArray<string>; overload;
begin
  Result := s.Split(Separator, Options);
end;

function Instance_Split(const s: string; const Separator: array of Char; Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
begin
  Result := s.Split(Separator, Count, Options);
end;

function Instance_Split(const s: string; const Separator: array of string): TArray<string>; overload;
begin
  Result := s.Split(Separator);
end;

function Instance_Split(const s: string; const Separator: array of string; Count: Integer): TArray<string>; overload;
begin
  Result := s.Split(Separator, Count);
end;

function Instance_Split(const s: string; const Separator: array of string; Options: TStringSplitOptions): TArray<string>; overload;
begin
  Result := s.Split(Separator, Options);
end;

function Instance_Split(const s: string; const Separator: array of string; Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
begin
  Result := s.Split(Separator, Count, Options);
end;

function Instance_Split(const s: string; const Separator: array of Char; Quote: Char): TArray<string>; overload;
begin
  Result := s.Split(Separator, Quote);
end;

function Instance_Split(const s: string; const Separator: array of Char; QuoteStart, QuoteEnd: Char): TArray<string>; overload;
begin
  Result := s.Split(Separator, QuoteStart, QuoteEnd);
end;

function Instance_Split(const s: string; const Separator: array of Char; QuoteStart, QuoteEnd: Char; Options: TStringSplitOptions): TArray<string>; overload;
begin
  Result := s.Split(Separator, QuoteStart, QuoteEnd, Options);
end;

function Instance_Split(const s: string; const Separator: array of Char; QuoteStart, QuoteEnd: Char; Count: Integer): TArray<string>; overload;
begin
  Result := s.Split(Separator, QuoteStart, QuoteEnd, Count);
end;

function Instance_Split(const s: string; const Separator: array of Char; QuoteStart, QuoteEnd: Char; Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
begin
  Result := s.Split(Separator, QuoteStart, QuoteEnd, Count, Options);
end;

function Instance_Split(const s: string; const Separator: array of string; Quote: Char): TArray<string>; overload;
begin
  Result := s.Split(Separator, Quote);
end;

function Instance_Split(const s: string; const Separator: array of string; QuoteStart, QuoteEnd: Char): TArray<string>; overload;
begin
  Result := s.Split(Separator, QuoteStart, QuoteEnd);
end;

function Instance_Split(const s: string; const Separator: array of string; QuoteStart, QuoteEnd: Char; Options: TStringSplitOptions): TArray<string>; overload;
begin
  Result := s.Split(Separator, QuoteStart, QuoteEnd, Options);
end;

function Instance_Split(const s: string; const Separator: array of string; QuoteStart, QuoteEnd: Char; Count: Integer): TArray<string>; overload;
begin
  Result := s.Split(Separator, QuoteStart, QuoteEnd, Count);
end;

function Instance_Split(const s: string; const Separator: array of string; QuoteStart, QuoteEnd: Char; Count: Integer; Options: TStringSplitOptions): TArray<string>; overload;
begin
  Result := s.Split(Separator, QuoteStart, QuoteEnd, Count, Options);
end;

function Instance_StartsWith(const s: string; const Value: string): Boolean; overload;
begin
  Result := s.StartsWith(Value);
end;

function Instance_StartsWith(const s: string; const Value: string; IgnoreCase: Boolean): Boolean; overload;
begin
  Result := s.StartsWith(Value, IgnoreCase);
end;

function Instance_Substring(const s: string; StartIndex: Integer): string; overload;
begin
  Result := s.Substring(StartIndex);
end;

function Instance_Substring(const s: string; StartIndex: Integer; Length: Integer): string; overload;
begin
  Result := s.Substring(StartIndex, Length);
end;

function Instance_ToBoolean(const s: string): Boolean; overload;
begin
  Result := s.ToBoolean;
end;

function Instance_ToInteger(const s: string): Integer; overload;
begin
  Result := s.ToInteger;
end;

function Instance_ToInt64(const s: string): Int64; overload;
begin
  Result := s.ToInt64;
end;

function Instance_ToSingle(const s: string): Single; overload;
begin
  Result := s.ToSingle;
end;

function Instance_ToDouble(const s: string): Double; overload;
begin
  Result := s.ToDouble;
end;

function Instance_ToExtended(const s: string): Extended; overload;
begin
  Result := s.ToExtended;
end;

function Instance_ToCharArray(const s: string): TArray<Char>; overload;
begin
  Result := s.ToCharArray;
end;

function Instance_ToCharArray(const s: string; StartIndex: Integer; Length: Integer): TArray<Char>; overload;
begin
  Result := s.ToCharArray(StartIndex, Length);
end;

function Instance_ToLower(const s: string): string; overload;
begin
  Result := s.ToLower;
end;

function Instance_ToLower(const s: string; LocaleID: TLocaleID): string; overload;
begin
  Result := s.ToLower(LocaleID);
end;

function Instance_ToLowerInvariant(const s: string): string;
begin
  Result := s.ToLowerInvariant;
end;

function Instance_ToUpper(const s: string): string; overload;
begin
  Result := s.ToUpper;
end;

function Instance_ToUpper(const s: string; LocaleID: TLocaleID): string; overload;
begin
  Result := s.ToUpper(LocaleID);
end;

function Instance_ToUpperInvariant(const s: string): string;
begin
  Result := s.ToUpperInvariant;
end;

function Instance_Trim(const s: string): string; overload;
begin
  Result := s.Trim;
end;

function Instance_TrimLeft(const s: string): string; overload;
begin
  Result := s.TrimLeft;
end;

function Instance_TrimRight(const s: string): string; overload;
begin
  Result := s.TrimRight;
end;

function Instance_Trim(const s: string; const TrimChars: array of Char): string; overload;
begin
  Result := s.Trim(TrimChars);
end;

function Instance_TrimLeft(const s: string; const TrimChars: array of Char): string; overload;
begin
  Result := s.TrimLeft(TrimChars);
end;

function Instance_TrimRight(const s: string; const TrimChars: array of Char): string; overload;
begin
  Result := s.TrimRight(TrimChars);
end;

// --- Implementation of Type Functions ---

function Type_Create(C: Char; Count: Integer): string; overload;
begin
  Result := string.Create(C, Count);
end;

function Type_Create(const Value: array of Char; StartIndex: Integer; Length: Integer): string; overload;
begin
  Result := string.Create(Value, StartIndex, Length);
end;

function Type_Create(const Value: array of Char): string; overload;
begin
  Result := string.Create(Value);
end;

function Type_Compare(const StrA: string; const StrB: string): Integer; overload;
begin
  Result := string.Compare(StrA, StrB);
end;

function Type_Compare(const StrA: string; const StrB: string; LocaleID: TLocaleID): Integer; overload;
begin
  Result := string.Compare(StrA, StrB, LocaleID);
end;

function Type_Compare(const StrA: string; const StrB: string; IgnoreCase: Boolean): Integer; overload;
begin
  Result := string.Compare(StrA, StrB, IgnoreCase);
end;

function Type_Compare(const StrA: string; const StrB: string; IgnoreCase: Boolean; LocaleID: TLocaleID): Integer; overload;
begin
  Result := string.Compare(StrA, StrB, IgnoreCase, LocaleID);
end;

function Type_Compare(const StrA: string; const StrB: string; Options: TCompareOptions): Integer; overload;
begin
  Result := string.Compare(StrA, StrB, Options);
end;

function Type_Compare(const StrA: string; const StrB: string; Options: TCompareOptions; LocaleID: TLocaleID): Integer; overload;
begin
  Result := string.Compare(StrA, StrB, Options, LocaleID);
end;

function Type_Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer): Integer; overload;
begin
  Result := string.Compare(StrA, IndexA, StrB, IndexB, Length);
end;

function Type_Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; LocaleID: TLocaleID): Integer; overload;
begin
  Result := string.Compare(StrA, IndexA, StrB, IndexB, Length, LocaleID);
end;

function Type_Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; IgnoreCase: Boolean): Integer; overload;
begin
  Result := string.Compare(StrA, IndexA, StrB, IndexB, Length, IgnoreCase);
end;

function Type_Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; IgnoreCase: Boolean; LocaleID: TLocaleID): Integer; overload;
begin
  Result := string.Compare(StrA, IndexA, StrB, IndexB, Length, IgnoreCase, LocaleID);
end;

function Type_Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; Options: TCompareOptions): Integer; overload;
begin
  Result := string.Compare(StrA, IndexA, StrB, IndexB, Length, Options);
end;

function Type_Compare(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer; Options: TCompareOptions; LocaleID: TLocaleID): Integer; overload;
begin
  Result := string.Compare(StrA, IndexA, StrB, IndexB, Length, Options, LocaleID);
end;

function Type_CompareOrdinal(const StrA: string; const StrB: string): Integer; overload;
begin
  Result := string.CompareOrdinal(StrA, StrB);
end;

function Type_CompareOrdinal(const StrA: string; IndexA: Integer; const StrB: string; IndexB: Integer; Length: Integer): Integer; overload;
begin
  Result := string.CompareOrdinal(StrA, IndexA, StrB, IndexB, Length);
end;

function Type_CompareText(const StrA: string; const StrB: string): Integer;
begin
  Result := string.CompareText(StrA, StrB);
end;

function Type_Parse(const Value: Integer): string; overload;
begin
  Result := string.Parse(Value);
end;

function Type_Parse(const Value: Int64): string; overload;
begin
  Result := string.Parse(Value);
end;

function Type_Parse(const Value: Boolean): string; overload;
begin
  Result := string.Parse(Value);
end;

function Type_Parse(const Value: Extended): string; overload;
begin
  Result := string.Parse(Value);
end;

function Type_ToBoolean(const S: string): Boolean; overload;
begin
  Result := string.ToBoolean(S);
end;

function Type_ToInteger(const S: string): Integer; overload;
begin
  Result := string.ToInteger(S);
end;

function Type_ToInt64(const S: string): Int64; overload;
begin
  Result := string.ToInt64(S);
end;

function Type_ToSingle(const S: string): Single; overload;
begin
  Result := string.ToSingle(S);
end;

function Type_ToDouble(const S: string): Double; overload;
begin
  Result := string.ToDouble(S);
end;

function Type_ToExtended(const S: string): Extended; overload;
begin
  Result := string.ToExtended(S);
end;

function Type_LowerCase(const S: string): string; overload;
begin
  Result := string.LowerCase(S);
end;

function Type_LowerCase(const S: string; LocaleOptions: TLocaleOptions): string; overload;
begin
  Result := string.LowerCase(S, LocaleOptions);
end;

function Type_UpperCase(const S: string): string; overload;
begin
  Result := string.UpperCase(S);
end;

function Type_UpperCase(const S: string; LocaleOptions: TLocaleOptions): string; overload;
begin
  Result := string.UpperCase(S, LocaleOptions);
end;

function Type_Copy(const Str: string): string;
begin
  Result := string.Copy(Str);
end;

function Type_EndsText(const ASubText, AText: string): Boolean;
begin
  Result := string.EndsText(ASubText, AText);
end;

function Type_Equals(const a: string; const b: string): Boolean; overload;
begin
  Result := string.Equals(a, b);
end;

function Type_Format(const Format: string; const args: array of const): string; overload;
begin
  Result := string.Format(Format, args);
end;

function Type_IsNullOrEmpty(const Value: string): Boolean;
begin
  Result := string.IsNullOrEmpty(Value);
end;

function Type_IsNullOrWhiteSpace(const Value: string): Boolean;
begin
  Result := string.IsNullOrWhiteSpace(Value);
end;

function Type_Join(const Separator: string; const Values: array of const): string; overload;
begin
  Result := string.Join(Separator, Values);
end;

function Type_Join(const Separator: string; const Values: array of string): string; overload;
begin
  Result := string.Join(Separator, Values);
end;

function Type_Join(const Separator: string; const Values: IEnumerator<string>): string; overload;
begin
  Result := string.Join(Separator, Values);
end;

function Type_Join(const Separator: string; const Values: IEnumerable<string>): string; overload;
begin
  Result := string.Join(Separator, Values);
end;

function Type_Join(const Separator: string; const Values: array of string; StartIndex: Integer; Count: Integer): string; overload;
begin
  Result := string.Join(Separator, Values, StartIndex, Count);
end;

function Type_StartsText(const ASubText, AText: string): Boolean;
begin
  Result := string.StartsText(ASubText, AText);
end;

{$IFEND} //XE3 +

end.
