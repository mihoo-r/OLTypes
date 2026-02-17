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
    /// <summary>Converts TOLRegEx to its pattern string.</summary>
    class operator Implicit(const AValue: TOLRegEx): string;
    /// <summary>Creates TOLRegEx from a raw pattern string.</summary>
    /// <seealso cref="New"/>
    class operator Implicit(const AValue: string): TOLRegEx;
    /// <summary>Creates a new empty regex builder.</summary>
    /// <example>OLRegEx.New.Digit.OneOrMore  // Pattern: \d+</example>
    /// <seealso cref="Literal"/>
    /// <seealso cref="StartOfLine"/>
    class function New: TOLRegEx; static;

    // Anchors

    /// <summary>Matches at the start of a line (or text in single-line mode).</summary>
    /// <example>OLRegEx.StartOfLine.Digit  // Pattern: ^\d</example>
    /// <seealso cref="EndOfLine"/>
    /// <seealso cref="StartOfText"/>
    /// <seealso cref="LineByLine"/>
    function StartOfLine: TOLRegEx;
    /// <summary>Matches at the end of a line (or text in single-line mode).</summary>
    /// <example>OLRegEx.Digit.EndOfLine  // Pattern: \d$</example>
    /// <seealso cref="StartOfLine"/>
    /// <seealso cref="EndOfText"/>
    /// <seealso cref="LineByLine"/>
    function EndOfLine: TOLRegEx;
    /// <summary>Matches only at the absolute start of text (ignores multiline mode).</summary>
    /// <example>OLRegEx.StartOfText.Literal('BEGIN')  // Pattern: \ABEGIN</example>
    /// <seealso cref="EndOfText"/>
    /// <seealso cref="StartOfLine"/>
    /// <seealso cref="AsLeftMatch"/>
    function StartOfText: TOLRegEx;
    /// <summary>Matches only at the absolute end of text (ignores multiline mode).</summary>
    /// <example>OLRegEx.Literal('END').EndOfText  // Pattern: END\z</example>
    /// <seealso cref="StartOfText"/>
    /// <seealso cref="EndOfLine"/>
    /// <seealso cref="AsFullMatch"/>
    function EndOfText: TOLRegEx;

    // Terminals

    /// <summary>Matches the exact literal string (special regex chars are escaped).</summary>
    /// <example>OLRegEx.Literal('$100')  // Pattern: \$100</example>
    /// <seealso cref="Choice"/>
    /// <seealso cref="CaseInsensitive"/>
    function Literal(const S: string): TOLRegEx;
    /// <summary>Matches a single digit (0-9).</summary>
    /// <example>OLRegEx.Literal('ID:').Digit  // Pattern: ID:\d</example>
    /// <seealso cref="NonDigit"/>
    /// <seealso cref="HexDigit"/>
    /// <seealso cref="Exactly"/>
    /// <seealso cref="OneOrMore"/>
    function Digit: TOLRegEx;
    /// <summary>Matches any character that is not a digit.</summary>
    /// <example>OLRegEx.Digit.NonDigit  // Pattern: \d\D</example>
    /// <seealso cref="Digit"/>
    /// <seealso cref="NonAlphanumeric"/>
    function NonDigit: TOLRegEx;
    /// <summary>Matches an alphanumeric character or underscore (a-z, A-Z, 0-9, _).</summary>
    /// <example>OLRegEx.Alphanumeric.OneOrMore  // Pattern: \w+</example>
    /// <seealso cref="NonAlphanumeric"/>
    /// <seealso cref="Letter"/>
    /// <seealso cref="WordBoundary"/>
    function Alphanumeric: TOLRegEx;
    /// <summary>Matches any character that is not alphanumeric or underscore.</summary>
    /// <example>OLRegEx.Alphanumeric.NonAlphanumeric  // Pattern: \w\W</example>
    /// <seealso cref="Alphanumeric"/>
    /// <seealso cref="Punctuation"/>
    function NonAlphanumeric: TOLRegEx;
    /// <summary>Matches a whitespace character (space, tab, newline, etc.).</summary>
    /// <example>OLRegEx.Whitespace.OneOrMore  // Pattern: \s+</example>
    /// <seealso cref="NonWhitespace"/>
    /// <seealso cref="Tab"/>
    /// <seealso cref="LineBreak"/>
    function Whitespace: TOLRegEx;
    /// <summary>Matches any non-whitespace character.</summary>
    /// <example>OLRegEx.NonWhitespace.OneOrMore  // Pattern: \S+</example>
    /// <seealso cref="Whitespace"/>
    /// <seealso cref="Alphanumeric"/>
    function NonWhitespace: TOLRegEx;
    /// <summary>Matches any single character (except newline, unless DotAll mode).</summary>
    /// <example>OLRegEx.AnyChar.Exactly(3)  // Pattern: .{3}</example>
    /// <seealso cref="DotAll"/>
    /// <seealso cref="CharSet"/>
    function AnyChar: TOLRegEx;
    /// <summary>Matches a tab character.</summary>
    /// <example>OLRegEx.Tab.Literal('data')  // Pattern: \tdata</example>
    /// <seealso cref="Whitespace"/>
    /// <seealso cref="LineBreak"/>
    function Tab: TOLRegEx;
    /// <summary>Matches at a word boundary (between \w and \W).</summary>
    /// <example>OLRegEx.WordBoundary.Literal('cat').WordBoundary  // Pattern: \bcat\b</example>
    /// <seealso cref="NonWordBoundary"/>
    /// <seealso cref="Alphanumeric"/>
    function WordBoundary: TOLRegEx;
    /// <summary>Matches at a position that is not a word boundary.</summary>
    /// <example>OLRegEx.NonWordBoundary.Literal('cat')  // Pattern: \Bcat</example>
    /// <seealso cref="WordBoundary"/>
    function NonWordBoundary: TOLRegEx;
    /// <summary>Matches any Unicode letter (\p{L}).</summary>
    /// <example>OLRegEx.Letter.OneOrMore  // Pattern: \p{L}+</example>
    /// <seealso cref="Alphanumeric"/>
    /// <seealso cref="Punctuation"/>
    function Letter: TOLRegEx;
    /// <summary>Matches any Unicode punctuation character (\p{P}).</summary>
    /// <example>OLRegEx.Punctuation.ZeroOrMore  // Pattern: \p{P}*</example>
    /// <seealso cref="Letter"/>
    /// <seealso cref="NonAlphanumeric"/>
    function Punctuation: TOLRegEx;
    /// <summary>Matches a hexadecimal digit (0-9, a-f, A-F).</summary>
    /// <example>OLRegEx.Literal('#').HexDigit.Exactly(6)  // Pattern: #[0-9a-fA-F]{6}</example>
    /// <seealso cref="Digit"/>
    /// <seealso cref="Range"/>
    function HexDigit: TOLRegEx;
    /// <summary>Matches any line break (CR, LF, CRLF, or Unicode line separators).</summary>
    /// <example>OLRegEx.LineBreak.OneOrMore  // Pattern: \R+</example>
    /// <seealso cref="Whitespace"/>
    /// <seealso cref="EndOfLine"/>
    function LineBreak: TOLRegEx;

    // Quantifiers - Greedy

    /// <summary>Repeats the previous element exactly N times.</summary>
    /// <example>OLRegEx.Digit.Exactly(4)  // Pattern: \d{4}</example>
    /// <seealso cref="Between"/>
    /// <seealso cref="AtLeast"/>
    /// <seealso cref="ExactlyPossessive"/>
    function Exactly(const Count: Integer): TOLRegEx;
    /// <summary>Repeats the previous element between Min and Max times (greedy).</summary>
    /// <example>OLRegEx.Digit.Between(2, 4)  // Pattern: \d{2,4}</example>
    /// <seealso cref="Exactly"/>
    /// <seealso cref="AtLeast"/>
    /// <seealso cref="BetweenLazy"/>
    /// <seealso cref="BetweenPossessive"/>
    function Between(const Min, Max: Integer): TOLRegEx;
    /// <summary>Repeats the previous element at least Min times (greedy, no upper limit).</summary>
    /// <example>OLRegEx.Digit.AtLeast(3)  // Pattern: \d{3,}</example>
    /// <seealso cref="Between"/>
    /// <seealso cref="OneOrMore"/>
    /// <seealso cref="AtLeastLazy"/>
    /// <seealso cref="AtLeastPossessive"/>
    function AtLeast(const Min: Integer): TOLRegEx;
    /// <summary>Makes the previous element optional (0 or 1 occurrence, greedy).</summary>
    /// <example>OLRegEx.Literal('-').Optional.Digit  // Pattern: -?\d</example>
    /// <seealso cref="ZeroOrMore"/>
    /// <seealso cref="OptionalLazy"/>
    /// <seealso cref="OptionalPossessive"/>
    function Optional: TOLRegEx;
    /// <summary>Repeats the previous element one or more times (greedy).</summary>
    /// <example>OLRegEx.Digit.OneOrMore  // Pattern: \d+</example>
    /// <seealso cref="ZeroOrMore"/>
    /// <seealso cref="AtLeast"/>
    /// <seealso cref="OneOrMoreLazy"/>
    /// <seealso cref="OneOrMorePossessive"/>
    function OneOrMore: TOLRegEx;
    /// <summary>Repeats the previous element zero or more times (greedy).</summary>
    /// <example>OLRegEx.Whitespace.ZeroOrMore  // Pattern: \s*</example>
    /// <seealso cref="OneOrMore"/>
    /// <seealso cref="Optional"/>
    /// <seealso cref="ZeroOrMoreLazy"/>
    /// <seealso cref="ZeroOrMorePossessive"/>
    function ZeroOrMore: TOLRegEx;

    // Quantifiers - Lazy

    /// <summary>Repeats Min to Max times, matching as few as possible (lazy).</summary>
    /// <example>OLRegEx.AnyChar.BetweenLazy(1, 10)  // Pattern: .{1,10}?</example>
    /// <seealso cref="Between"/>
    /// <seealso cref="BetweenPossessive"/>
    function BetweenLazy(const Min, Max: Integer): TOLRegEx;
    /// <summary>Repeats at least Min times, matching as few as possible (lazy).</summary>
    /// <example>OLRegEx.AnyChar.AtLeastLazy(1)  // Pattern: .{1,}?</example>
    /// <seealso cref="AtLeast"/>
    /// <seealso cref="AtLeastPossessive"/>
    function AtLeastLazy(const Min: Integer): TOLRegEx;
    /// <summary>Makes the previous element optional, preferring not to match (lazy).</summary>
    /// <example>OLRegEx.Literal('s').OptionalLazy  // Pattern: s??</example>
    /// <seealso cref="Optional"/>
    /// <seealso cref="OptionalPossessive"/>
    function OptionalLazy: TOLRegEx;
    /// <summary>Repeats one or more times, matching as few as possible (lazy).</summary>
    /// <example>OLRegEx.AnyChar.OneOrMoreLazy  // Pattern: .+?</example>
    /// <seealso cref="OneOrMore"/>
    /// <seealso cref="OneOrMorePossessive"/>
    function OneOrMoreLazy: TOLRegEx;
    /// <summary>Repeats zero or more times, matching as few as possible (lazy).</summary>
    /// <example>OLRegEx.AnyChar.ZeroOrMoreLazy  // Pattern: .*?</example>
    /// <seealso cref="ZeroOrMore"/>
    /// <seealso cref="ZeroOrMorePossessive"/>
    function ZeroOrMoreLazy: TOLRegEx;

    // Quantifiers - Possessive

    /// <summary>Repeats exactly N times without backtracking (possessive).</summary>
    /// <example>OLRegEx.Digit.ExactlyPossessive(4)  // Pattern: \d{4}+</example>
    /// <seealso cref="Exactly"/>
    function ExactlyPossessive(const Count: Integer): TOLRegEx;
    /// <summary>Repeats Min to Max times without backtracking (possessive).</summary>
    /// <example>OLRegEx.Digit.BetweenPossessive(2, 4)  // Pattern: \d{2,4}+</example>
    /// <seealso cref="Between"/>
    /// <seealso cref="BetweenLazy"/>
    function BetweenPossessive(const Min, Max: Integer): TOLRegEx;
    /// <summary>Repeats at least Min times without backtracking (possessive).</summary>
    /// <example>OLRegEx.Digit.AtLeastPossessive(3)  // Pattern: \d{3,}+</example>
    /// <seealso cref="AtLeast"/>
    /// <seealso cref="AtLeastLazy"/>
    function AtLeastPossessive(const Min: Integer): TOLRegEx;
    /// <summary>Optional without backtracking (possessive).</summary>
    /// <example>OLRegEx.Literal('-').OptionalPossessive  // Pattern: -?+</example>
    /// <seealso cref="Optional"/>
    /// <seealso cref="OptionalLazy"/>
    function OptionalPossessive: TOLRegEx;
    /// <summary>Repeats one or more times without backtracking (possessive).</summary>
    /// <example>OLRegEx.Digit.OneOrMorePossessive  // Pattern: \d++</example>
    /// <seealso cref="OneOrMore"/>
    /// <seealso cref="OneOrMoreLazy"/>
    function OneOrMorePossessive: TOLRegEx;
    /// <summary>Repeats zero or more times without backtracking (possessive).</summary>
    /// <example>OLRegEx.AnyChar.ZeroOrMorePossessive  // Pattern: .*+</example>
    /// <seealso cref="ZeroOrMore"/>
    /// <seealso cref="ZeroOrMoreLazy"/>
    function ZeroOrMorePossessive: TOLRegEx;

    // Groups

    /// <summary>Creates a non-capturing group for combining elements without capturing.</summary>
    /// <example>OLRegEx.Group(OLRegEx.Digit.Literal('-')).Exactly(3)  // Pattern: (?:\d-){3}</example>
    /// <seealso cref="Capture"/>
    /// <seealso cref="AnyOf"/>
    function Group(const Sub: TOLRegEx): TOLRegEx;
    /// <summary>Creates a capturing group, accessible by index in match results.</summary>
    /// <example>OLRegEx.Capture(OLRegEx.Digit.OneOrMore)  // Pattern: (\d+)</example>
    /// <seealso cref="Group"/>
    /// <seealso cref="Reference"/>
    function Capture(const Sub: TOLRegEx): TOLRegEx; overload;
    /// <summary>Creates a named capturing group, accessible by name in match results.</summary>
    /// <example>OLRegEx.Capture('year', OLRegEx.Digit.Exactly(4))  // Pattern: (?P&lt;year&gt;\d{4})</example>
    /// <seealso cref="Capture"/>
    /// <seealso cref="Reference"/>
    function Capture(const Name: string; const Sub: TOLRegEx): TOLRegEx; overload;
    /// <summary>References a previously captured named group (backreference).</summary>
    /// <example>OLRegEx.Capture('tag', OLRegEx.Alphanumeric.OneOrMore).Literal('/').Reference('tag')  // Pattern: (?P&lt;tag&gt;\w+)/(?P=tag)</example>
    /// <seealso cref="Capture"/>
    function Reference(const Name: string): TOLRegEx; overload;
    /// <summary>References a previously captured group by index (backreference).</summary>
    /// <example>OLRegEx.Capture(OLRegEx.Letter).Reference(1)  // Pattern: (\p{L})\1</example>
    /// <seealso cref="Capture"/>
    function Reference(const Index: Integer): TOLRegEx; overload;

    // Logic

    /// <summary>Matches one of the given literal strings (alternatives).</summary>
    /// <example>OLRegEx.Choice(['cat', 'dog', 'fish'])  // Pattern: (?:cat|dog|fish)</example>
    /// <seealso cref="AnyOf"/>
    /// <seealso cref="CharSet"/>
    function Choice(const Options: array of string): TOLRegEx;
    /// <summary>Matches one of the given regex patterns (complex alternatives).</summary>
    /// <example>OLRegEx.AnyOf([OLRegEx.Digit.OneOrMore, OLRegEx.Letter.OneOrMore])  // Pattern: (?:\d+|\p{L}+)</example>
    /// <seealso cref="Choice"/>
    /// <seealso cref="Group"/>
    function AnyOf(const Options: array of TOLRegEx): TOLRegEx;
    /// <summary>Matches a single character in the specified range.</summary>
    /// <example>OLRegEx.Range('a', 'z')  // Pattern: [a-z]</example>
    /// <seealso cref="CharSet"/>
    /// <seealso cref="NotCharSet"/>
    /// <seealso cref="HexDigit"/>
    function Range(const StartChar, EndChar: Char): TOLRegEx;
    /// <summary>Matches any single character from the given set.</summary>
    /// <example>OLRegEx.CharSet('aeiou')  // Pattern: [aeiou]</example>
    /// <seealso cref="NotCharSet"/>
    /// <seealso cref="Range"/>
    /// <seealso cref="Choice"/>
    function CharSet(const Chars: string): TOLRegEx;
    /// <summary>Matches any single character NOT in the given set.</summary>
    /// <example>OLRegEx.NotCharSet('0-9')  // Pattern: [^0-9]</example>
    /// <seealso cref="CharSet"/>
    /// <seealso cref="Range"/>
    function NotCharSet(const Chars: string): TOLRegEx;

    // Lookarounds

    /// <summary>Zero-width positive lookahead - asserts what follows matches.</summary>
    /// <example>OLRegEx.Digit.OneOrMore.Lookahead(OLRegEx.Literal('px'))  // Pattern: \d+(?=px)</example>
    /// <seealso cref="NegativeLookahead"/>
    /// <seealso cref="Lookbehind"/>
    function Lookahead(const Sub: TOLRegEx): TOLRegEx;
    /// <summary>Zero-width negative lookahead - asserts what follows does not match.</summary>
    /// <example>OLRegEx.Alphanumeric.OneOrMore.NegativeLookahead(OLRegEx.Literal('@'))  // Pattern: \w+(?!@)</example>
    /// <seealso cref="Lookahead"/>
    /// <seealso cref="NegativeLookbehind"/>
    function NegativeLookahead(const Sub: TOLRegEx): TOLRegEx;
    /// <summary>Zero-width positive lookbehind - asserts what precedes matches.</summary>
    /// <example>OLRegEx.Lookbehind(OLRegEx.Literal('$')).Digit.OneOrMore  // Pattern: (?&lt;=\$)\d+</example>
    /// <seealso cref="NegativeLookbehind"/>
    /// <seealso cref="Lookahead"/>
    function Lookbehind(const Sub: TOLRegEx): TOLRegEx;
    /// <summary>Zero-width negative lookbehind - asserts what precedes does not match.</summary>
    /// <example>OLRegEx.NegativeLookbehind(OLRegEx.Literal('-')).Digit.OneOrMore  // Pattern: (?&lt;!-)\d+</example>
    /// <seealso cref="Lookbehind"/>
    /// <seealso cref="NegativeLookahead"/>
    function NegativeLookbehind(const Sub: TOLRegEx): TOLRegEx;

    // Engine Flags

    /// <summary>Makes the given subpattern case-insensitive.</summary>
    /// <example>OLRegEx.CaseInsensitive(OLRegEx.Literal('hello'))  // Pattern: (?i:hello)</example>
    /// <seealso cref="CaseSensitive"/>
    function CaseInsensitive(const Sub: TOLRegEx): TOLRegEx;
    /// <summary>Makes the given subpattern case-sensitive (explicit).</summary>
    /// <example>OLRegEx.CaseSensitive(OLRegEx.Literal('ABC'))  // Pattern: (?-i:ABC)</example>
    /// <seealso cref="CaseInsensitive"/>
    function CaseSensitive(const Sub: TOLRegEx): TOLRegEx;
    /// <summary>Enables single-line mode where dot (.) matches newlines too.</summary>
    /// <example>OLRegEx.AnyChar.OneOrMore.DotAll  // Pattern: (?s).+</example>
    /// <seealso cref="LineByLine"/>
    /// <seealso cref="AnyChar"/>
    function DotAll: TOLRegEx;
    /// <summary>Enables multiline mode where ^ and $ match at line boundaries.</summary>
    /// <example>OLRegEx.StartOfLine.Digit.OneOrMore.EndOfLine.LineByLine  // Pattern: (?m)^\d+$</example>
    /// <seealso cref="DotAll"/>
    /// <seealso cref="StartOfLine"/>
    /// <seealso cref="EndOfLine"/>
    function LineByLine: TOLRegEx;

    // Validation Helpers

    /// <summary>Wraps pattern to match from the beginning of text (prefix matching).</summary>
    /// <example>OLRegEx.Digit.OneOrMore.AsLeftMatch  // Pattern: \A(?:\d+)</example>
    /// <seealso cref="AsFullMatch"/>
    /// <seealso cref="StartOfText"/>
    function AsLeftMatch: TOLRegEx;
    /// <summary>Wraps pattern to match the entire text (full string validation).</summary>
    /// <example>OLRegEx.Digit.Exactly(5).AsFullMatch  // Pattern: \A(?:\d{5})\z</example>
    /// <seealso cref="AsLeftMatch"/>
    /// <seealso cref="StartOfText"/>
    /// <seealso cref="EndOfText"/>
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
