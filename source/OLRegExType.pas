unit OLRegExType;

//------------------------------------------------------------------------------
//  Regular Expression Builder for Delphi
//
//  PCRE Compatibility Notes:
//  -------------------------
//  This unit uses PCRE features that require Delphi XE or later.
//
//  Unicode Properties (\p{L}, \p{P}):
//  - Supported in all Delphi versions with TRegEx (XE+)
//  - Delphi 10.3+ uses native UTF-16 PCRE = best performance
//  - Delphi XE4-10.2 uses UTF-8 PCRE = works but slower due to conversions
//  - Only short forms supported (\p{L}), not long forms (\p{Letter})
//
//  Line Break (\R):
//  - Fully supported in Delphi TRegEx
//  - Matches CR, LF, CRLF, and Unicode line separators
//
//  Possessive Quantifiers (?+, ++, *+, {n}+):
//  - Supported by PCRE in Delphi
//------------------------------------------------------------------------------

interface

uses
  SysUtils, OLBooleanType, OLIntegerType;

type
  TOLRegEx = record
  public
    const Unlimited = -1;
  private
    FPattern: string;
    FExplanation: string;
    function Escape(const S: string): string;
    function EscapeCharClass(const C: Char): string;
    procedure AppendExplanation(const Text: string);
    procedure ValidateRange(const Min, Max: Integer);
    procedure ValidateGroupName(const Name: string);
  public
    class operator Implicit(const AValue: TOLRegEx): string;
    class operator Implicit(const AValue: string): TOLRegEx;
    class function New: TOLRegEx; static;

    // Anchors
    function StartOfLine: TOLRegEx;
    function EndOfLine: TOLRegEx;
    function StartOfText: TOLRegEx;
    function EndOfText: TOLRegEx;

    // Terminals
    function Literal(const S: string): TOLRegEx;
    function Digit: TOLRegEx;
    function NonDigit: TOLRegEx;
    function Alphanumeric: TOLRegEx;
    function NonAlphanumeric: TOLRegEx;
    function Whitespace: TOLRegEx;
    function NonWhitespace: TOLRegEx;
    function AnyChar: TOLRegEx;
    function Tab: TOLRegEx;
    function WordBoundary: TOLRegEx;
    function NonWordBoundary: TOLRegEx;
    function Letter: TOLRegEx;
    function Punctuation: TOLRegEx;
    function HexDigit: TOLRegEx;
    function LineBreak: TOLRegEx;

    // Quantifiers - Greedy
    function Exactly(const Count: Integer): TOLRegEx;
    function Between(const Min, Max: Integer): TOLRegEx;
    function AtLeast(const Min: Integer): TOLRegEx;
    function Optional: TOLRegEx;
    function OneOrMore: TOLRegEx;
    function ZeroOrMore: TOLRegEx;

    // Quantifiers - Lazy
    function BetweenLazy(const Min, Max: Integer): TOLRegEx;
    function AtLeastLazy(const Min: Integer): TOLRegEx;
    function OptionalLazy: TOLRegEx;
    function OneOrMoreLazy: TOLRegEx;
    function ZeroOrMoreLazy: TOLRegEx;

    // Quantifiers - Possessive
    function ExactlyPossessive(const Count: Integer): TOLRegEx;
    function BetweenPossessive(const Min, Max: Integer): TOLRegEx;
    function AtLeastPossessive(const Min: Integer): TOLRegEx;
    function OptionalPossessive: TOLRegEx;
    function OneOrMorePossessive: TOLRegEx;
    function ZeroOrMorePossessive: TOLRegEx;

    // Groups
    function Group(const Sub: TOLRegEx): TOLRegEx;
    function Capture(const Sub: TOLRegEx): TOLRegEx; overload;
    function Capture(const Name: string; const Sub: TOLRegEx): TOLRegEx; overload;
    function Reference(const Name: string): TOLRegEx; overload;
    function Reference(const Index: Integer): TOLRegEx; overload;

    // Logic
    function Choice(const Options: array of string): TOLRegEx;
    function AnyOf(const Options: array of TOLRegEx): TOLRegEx;
    function Range(const StartChar, EndChar: Char): TOLRegEx;
    function CharSet(const Chars: string): TOLRegEx;
    function NotCharSet(const Chars: string): TOLRegEx;

    // Lookarounds
    function Lookahead(const Sub: TOLRegEx): TOLRegEx;
    function NegativeLookahead(const Sub: TOLRegEx): TOLRegEx;
    function Lookbehind(const Sub: TOLRegEx): TOLRegEx;
    function NegativeLookbehind(const Sub: TOLRegEx): TOLRegEx;

    // Engine Flags
    function CaseInsensitive(const Sub: TOLRegEx): TOLRegEx;
    function CaseSensitive(const Sub: TOLRegEx): TOLRegEx;
    function DotAll: TOLRegEx;
    function LineByLine: TOLRegEx;

    // Validation Helpers
    function AsLeftMatch: TOLRegEx;
    function AsFullMatch: TOLRegEx;

    property Pattern: string read FPattern;
    property Explanation: string read FExplanation;
  end;

function OLRegEx: TOLRegEx;

implementation

{ TOLRegEx }

function TOLRegEx.Escape(const S: string): string;
const
  SpecialChars = '\.+*?^$()[]{}|';
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(S) do
  begin
    if Pos(S[i], SpecialChars) > 0 then
      Result := Result + '\' + S[i]
    else
      Result := Result + S[i];
  end;
end;

function TOLRegEx.EscapeCharClass(const C: Char): string;
begin
  // Inside character class [], these chars need escaping: ] \ ^ -
  case C of
    ']', '\', '^', '-': Result := '\' + C;
  else
    Result := C;
  end;
end;

procedure TOLRegEx.AppendExplanation(const Text: string);
begin
  if (FExplanation = '') or (FExplanation[Length(FExplanation)] = ' ') then
    FExplanation := FExplanation + Text
  else
    FExplanation := FExplanation + ', then ' + Text;
end;

procedure TOLRegEx.ValidateRange(const Min, Max: Integer);
begin
  if Min < 0 then
    raise ERangeError.Create('Minimum count cannot be negative');
  if (Max <> Unlimited) and (Max < Min) then
    raise ERangeError.Create('Maximum count cannot be less than minimum');
end;

procedure TOLRegEx.ValidateGroupName(const Name: string);
var
  i: Integer;
begin
  if Name = '' then
    raise EArgumentException.Create('Group name cannot be empty');

  if (Name[1] >= '0') and (Name[1] <= '9') then
    raise EArgumentException.Create('Group name cannot start with a digit: ' + Name);

  for i := 1 to Length(Name) do
  begin
    case Name[i] of
      'A'..'Z', 'a'..'z', '0'..'9', '_': ; // OK
    else
      raise EArgumentException.Create('Invalid character in group name "' + Name + '": ' + Name[i]);
    end;
  end;
end;

class operator TOLRegEx.Implicit(const AValue: TOLRegEx): string;
begin
  Result := AValue.FPattern;
end;

class operator TOLRegEx.Implicit(const AValue: string): TOLRegEx;
begin
  Result.FPattern := AValue;
  Result.FExplanation := 'custom pattern "' + AValue + '"';
end;

class function TOLRegEx.New: TOLRegEx;
begin
  Result.FPattern := '';
  Result.FExplanation := '';
end;

function TOLRegEx.StartOfLine: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '^';
  Result.AppendExplanation('start of line');
end;

function TOLRegEx.EndOfLine: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '$';
  Result.AppendExplanation('end of line');
end;

function TOLRegEx.StartOfText: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '\A';
  Result.AppendExplanation('start of text');
end;

function TOLRegEx.EndOfText: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '\z';
  Result.AppendExplanation('end of text');
end;

function TOLRegEx.Literal(const S: string): TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + Escape(S);
  Result.AppendExplanation('literal "' + S + '"');
end;

function TOLRegEx.Digit: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '\d';
  Result.AppendExplanation('a digit');
end;

function TOLRegEx.NonDigit: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '\D';
  Result.AppendExplanation('a non-digit character');
end;

function TOLRegEx.Alphanumeric: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '\w';
  Result.AppendExplanation('an alphanumeric character');
end;

function TOLRegEx.NonAlphanumeric: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '\W';
  Result.AppendExplanation('a non-alphanumeric character');
end;

function TOLRegEx.Whitespace: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '\s';
  Result.AppendExplanation('a whitespace character');
end;

function TOLRegEx.NonWhitespace: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '\S';
  Result.AppendExplanation('a non-whitespace character');
end;

function TOLRegEx.AnyChar: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '.';
  Result.AppendExplanation('any character');
end;

function TOLRegEx.Tab: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '\t';
  Result.AppendExplanation('a tab character');
end;

function TOLRegEx.WordBoundary: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '\b';
  Result.AppendExplanation('a word boundary');
end;

function TOLRegEx.NonWordBoundary: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '\B';
  Result.AppendExplanation('a non-word boundary');
end;

// Uses Unicode property \p{L} - supported in Delphi XE+ (PCRE with Unicode)
// Matches any Unicode letter (Latin, Cyrillic, Greek, etc.)
function TOLRegEx.Letter: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '\p{L}';
  Result.AppendExplanation('any letter');
end;

// Uses Unicode property \p{P} - supported in Delphi XE+ (PCRE with Unicode)
// Matches any Unicode punctuation character
function TOLRegEx.Punctuation: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '\p{P}';
  Result.AppendExplanation('a punctuation character');
end;

function TOLRegEx.HexDigit: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '[0-9a-fA-F]';
  Result.AppendExplanation('a hexadecimal digit');
end;

// Uses PCRE \R - supported in Delphi XE+
// Matches any Unicode newline: CR, LF, CRLF, VT, FF, NEL, LS, PS
function TOLRegEx.LineBreak: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '\R';
  Result.AppendExplanation('a line break');
end;

// Quantifiers - Greedy

function TOLRegEx.Exactly(const Count: Integer): TOLRegEx;
begin
  ValidateRange(Count, Count);
  Result := Self;
  Result.FPattern := FPattern + '{' + IntToStr(Count) + '}';
  Result.FExplanation := Result.FExplanation + ' (exactly ' + IntToStr(Count) + ' times)';
end;

function TOLRegEx.Between(const Min, Max: Integer): TOLRegEx;
begin
  ValidateRange(Min, Max);
  Result := Self;
  Result.FPattern := FPattern + '{' + IntToStr(Min) + ',' + IntToStr(Max) + '}';
  Result.FExplanation := Result.FExplanation + ' (' + IntToStr(Min) + ' to ' + IntToStr(Max) + ' times)';
end;

function TOLRegEx.AtLeast(const Min: Integer): TOLRegEx;
begin
  ValidateRange(Min, Unlimited);
  Result := Self;
  Result.FPattern := FPattern + '{' + IntToStr(Min) + ',}';
  Result.FExplanation := Result.FExplanation + ' (at least ' + IntToStr(Min) + ' times)';
end;

function TOLRegEx.Optional: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '?';
  Result.FExplanation := Result.FExplanation + ' (optional)';
end;

function TOLRegEx.OneOrMore: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '+';
  Result.FExplanation := Result.FExplanation + ' (one or more times)';
end;

function TOLRegEx.ZeroOrMore: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '*';
  Result.FExplanation := Result.FExplanation + ' (zero or more times)';
end;

// Quantifiers - Lazy

function TOLRegEx.BetweenLazy(const Min, Max: Integer): TOLRegEx;
begin
  ValidateRange(Min, Max);
  Result := Self;
  Result.FPattern := FPattern + '{' + IntToStr(Min) + ',' + IntToStr(Max) + '}?';
  Result.FExplanation := Result.FExplanation + ' (' + IntToStr(Min) + ' to ' + IntToStr(Max) + ' times, lazy)';
end;

function TOLRegEx.AtLeastLazy(const Min: Integer): TOLRegEx;
begin
  ValidateRange(Min, Unlimited);
  Result := Self;
  Result.FPattern := FPattern + '{' + IntToStr(Min) + ',}?';
  Result.FExplanation := Result.FExplanation + ' (at least ' + IntToStr(Min) + ' times, lazy)';
end;

function TOLRegEx.OptionalLazy: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '??';
  Result.FExplanation := Result.FExplanation + ' (optional, lazy)';
end;

function TOLRegEx.OneOrMoreLazy: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '+?';
  Result.FExplanation := Result.FExplanation + ' (one or more times, lazy)';
end;

function TOLRegEx.ZeroOrMoreLazy: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '*?';
  Result.FExplanation := Result.FExplanation + ' (zero or more times, lazy)';
end;

// Quantifiers - Possessive

function TOLRegEx.ExactlyPossessive(const Count: Integer): TOLRegEx;
begin
  ValidateRange(Count, Count);
  Result := Self;
  Result.FPattern := FPattern + '{' + IntToStr(Count) + '}+';
  Result.FExplanation := Result.FExplanation + ' (exactly ' + IntToStr(Count) + ' times, possessive)';
end;

function TOLRegEx.BetweenPossessive(const Min, Max: Integer): TOLRegEx;
begin
  ValidateRange(Min, Max);
  Result := Self;
  Result.FPattern := FPattern + '{' + IntToStr(Min) + ',' + IntToStr(Max) + '}+';
  Result.FExplanation := Result.FExplanation + ' (' + IntToStr(Min) + ' to ' + IntToStr(Max) + ' times, possessive)';
end;

function TOLRegEx.AtLeastPossessive(const Min: Integer): TOLRegEx;
begin
  ValidateRange(Min, Unlimited);
  Result := Self;
  Result.FPattern := FPattern + '{' + IntToStr(Min) + ',}+';
  Result.FExplanation := Result.FExplanation + ' (at least ' + IntToStr(Min) + ' times, possessive)';
end;

function TOLRegEx.OptionalPossessive: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '?+';
  Result.FExplanation := Result.FExplanation + ' (optional, possessive)';
end;

function TOLRegEx.OneOrMorePossessive: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '++';
  Result.FExplanation := Result.FExplanation + ' (one or more times, possessive)';
end;

function TOLRegEx.ZeroOrMorePossessive: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '*+';
  Result.FExplanation := Result.FExplanation + ' (zero or more times, possessive)';
end;

// Groups

function TOLRegEx.Group(const Sub: TOLRegEx): TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '(?:' + Sub.FPattern + ')';
  Result.AppendExplanation('group containing (' + Sub.FExplanation + ')');
end;

function TOLRegEx.Capture(const Sub: TOLRegEx): TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '(' + Sub.FPattern + ')';
  Result.AppendExplanation('captured group containing (' + Sub.FExplanation + ')');
end;

function TOLRegEx.Capture(const Name: string; const Sub: TOLRegEx): TOLRegEx;
begin
  ValidateGroupName(Name);
  Result := Self;
  Result.FPattern := FPattern + '(?P<' + Name + '>' + Sub.FPattern + ')';
  Result.AppendExplanation('captured group named "' + Name + '" containing (' + Sub.FExplanation + ')');
end;

function TOLRegEx.Reference(const Name: string): TOLRegEx;
begin
  ValidateGroupName(Name);
  Result := Self;
  Result.FPattern := FPattern + '(?P=' + Name + ')';
  Result.AppendExplanation('reference to captured group "' + Name + '"');
end;

function TOLRegEx.Reference(const Index: Integer): TOLRegEx;
begin
  if Index < 1 then
    raise EArgumentException.Create('Group index must be at least 1');

  Result := Self;
  Result.FPattern := FPattern + '\' + IntToStr(Index);
  Result.AppendExplanation('reference to captured group #' + IntToStr(Index));
end;

function TOLRegEx.Choice(const Options: array of string): TOLRegEx;
var
  i: Integer;
  Desc: string;
begin
  if Length(Options) = 0 then
    raise EArgumentException.Create('List of choices cannot be empty');

  Result := Self;
  Result.FPattern := FPattern + '(?:';
  Desc := '';
  for i := Low(Options) to High(Options) do
  begin
    if i > Low(Options) then
    begin
      Result.FPattern := Result.FPattern + '|';
      if i = High(Options) then Desc := Desc + ' or ' else Desc := Desc + ', ';
    end;
    Result.FPattern := Result.FPattern + Escape(Options[i]);
    Desc := Desc + '"' + Options[i] + '"';
  end;
  Result.FPattern := Result.FPattern + ')';
  Result.AppendExplanation('one of: ' + Desc);
end;

function TOLRegEx.AnyOf(const Options: array of TOLRegEx): TOLRegEx;
var
  i: Integer;
  Desc: string;
begin
  if Length(Options) = 0 then
    raise EArgumentException.Create('List of options cannot be empty');

  Result := Self;
  Result.FPattern := FPattern + '(?:';
  Desc := '';
  for i := Low(Options) to High(Options) do
  begin
    if i > Low(Options) then
    begin
      Result.FPattern := Result.FPattern + '|';
      if i = High(Options) then Desc := Desc + ' or ' else Desc := Desc + ', ';
    end;
    Result.FPattern := Result.FPattern + Options[i].FPattern;
    Desc := Desc + '(' + Options[i].FExplanation + ')';
  end;
  Result.FPattern := Result.FPattern + ')';
  Result.AppendExplanation('one of: ' + Desc);
end;

function TOLRegEx.Range(const StartChar, EndChar: Char): TOLRegEx;
begin
  if Ord(StartChar) > Ord(EndChar) then
    raise EArgumentException.Create('Range start character must come before end character');
  Result := Self;
  Result.FPattern := FPattern + '[' + EscapeCharClass(StartChar) + '-' + EscapeCharClass(EndChar) + ']';
  Result.AppendExplanation('character in range "' + StartChar + '" to "' + EndChar + '"');
end;

// CharSet allows custom character class patterns like 'abc0-9'
// Special chars are escaped where needed, but ranges like 'a-z' are preserved
function TOLRegEx.CharSet(const Chars: string): TOLRegEx;
var
  i: Integer;
  Escaped: string;
begin
  if Chars = '' then
    raise EArgumentException.Create('CharSet cannot be empty');

  Escaped := '';
  i := 1;
  while i <= Length(Chars) do
  begin
    // Check for range pattern: char-char
    if (i + 2 <= Length(Chars)) and (Chars[i + 1] = '-') and (i > 1) then
    begin
      // This is part of a range like 'a-z', preserve as-is
      Escaped := Escaped + EscapeCharClass(Chars[i]);
      Inc(i);
    end
    else if (i >= 2) and (Chars[i] = '-') and (i < Length(Chars)) then
    begin
      // Hyphen in range context - keep it
      Escaped := Escaped + '-';
      Inc(i);
    end
    else
    begin
      // Regular character - escape if needed
      Escaped := Escaped + EscapeCharClass(Chars[i]);
      Inc(i);
    end;
  end;

  Result := Self;
  Result.FPattern := FPattern + '[' + Escaped + ']';
  Result.AppendExplanation('any of "' + Chars + '"');
end;

// NotCharSet creates negated character class [^...]
function TOLRegEx.NotCharSet(const Chars: string): TOLRegEx;
var
  i: Integer;
  Escaped: string;
begin
  if Chars = '' then
    raise EArgumentException.Create('NotCharSet cannot be empty');

  Escaped := '';
  i := 1;
  while i <= Length(Chars) do
  begin
    if (i + 2 <= Length(Chars)) and (Chars[i + 1] = '-') and (i > 1) then
    begin
      Escaped := Escaped + EscapeCharClass(Chars[i]);
      Inc(i);
    end
    else if (i >= 2) and (Chars[i] = '-') and (i < Length(Chars)) then
    begin
      Escaped := Escaped + '-';
      Inc(i);
    end
    else
    begin
      Escaped := Escaped + EscapeCharClass(Chars[i]);
      Inc(i);
    end;
  end;

  Result := Self;
  Result.FPattern := FPattern + '[^' + Escaped + ']';
  Result.AppendExplanation('any character except "' + Chars + '"');
end;

function TOLRegEx.Lookahead(const Sub: TOLRegEx): TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '(?=' + Sub.FPattern + ')';
  Result.AppendExplanation('followed by (' + Sub.FExplanation + ')');
end;

function TOLRegEx.NegativeLookahead(const Sub: TOLRegEx): TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '(?!' + Sub.FPattern + ')';
  Result.AppendExplanation('not followed by (' + Sub.FExplanation + ')');
end;

function TOLRegEx.Lookbehind(const Sub: TOLRegEx): TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '(?<=' + Sub.FPattern + ')';
  Result.AppendExplanation('preceded by (' + Sub.FExplanation + ')');
end;

function TOLRegEx.NegativeLookbehind(const Sub: TOLRegEx): TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '(?<!' + Sub.FPattern + ')';
  Result.AppendExplanation('not preceded by (' + Sub.FExplanation + ')');
end;

function TOLRegEx.CaseInsensitive(const Sub: TOLRegEx): TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '(?i:' + Sub.FPattern + ')';
  Result.AppendExplanation('case-insensitive: (' + Sub.FExplanation + ')');
end;

function TOLRegEx.CaseSensitive(const Sub: TOLRegEx): TOLRegEx;
begin
  Result := Self;
  Result.FPattern := FPattern + '(?-i:' + Sub.FPattern + ')';
  Result.AppendExplanation('case-sensitive: (' + Sub.FExplanation + ')');
end;

function TOLRegEx.DotAll: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := '(?s)' + FPattern;
  Result.FExplanation := 'in dot-all mode: ' + Result.FExplanation;
end;

function TOLRegEx.LineByLine: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := '(?m)' + FPattern;
  Result.FExplanation := 'for each line: ' + Result.FExplanation;
end;

function TOLRegEx.AsLeftMatch: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := '\A(?:' + FPattern + ')';
  Result.FExplanation := 'starting from the beginning: ' + Result.FExplanation;
end;

function TOLRegEx.AsFullMatch: TOLRegEx;
begin
  Result := Self;
  Result.FPattern := '\A(?:' + FPattern + ')\z';
  Result.FExplanation := 'entire text must match: ' + Result.FExplanation;
end;

function OLRegEx: TOLRegEx;
begin
  Result := TOLRegEx.New;
end;

end.
