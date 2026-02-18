# TOLRegEx

`TOLRegEx` is a fluent builder for creating regular expression patterns in a readable, chainable way. Instead of writing cryptic regex strings, you build patterns using descriptive method calls.

## Quick Start

```delphi
uses OLRegExType;

var
  Pattern: TOLRegEx;
  Email: OLString;
begin
  // Build a pattern for validating email-like strings
  Pattern := OLRegEx
    .Alphanumeric.OneOrMore
    .Literal('@')
    .Alphanumeric.OneOrMore
    .Literal('.')
    .Letter.AtLeast(2)
    .AsFullMatch;

  Email := 'user@example.com';
  if Email.Matches(Pattern) then
    ShowMessage('Valid email format');
end;
```

## Creating a Pattern

There are two ways to start building a pattern:

### Using the `OLRegEx` Function
```delphi
Pattern := OLRegEx.Digit.OneOrMore;  // Creates empty builder and chains methods
```

### Using `TOLRegEx.New`
```delphi
Pattern := TOLRegEx.New.Digit.OneOrMore;  // Explicit constructor
```

Both are equivalent. The `OLRegEx` function is a shorthand that returns an empty `TOLRegEx` record.

---

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `Pattern` | `string` | The generated regex pattern string. |
| `Explanation` | `string` | Human-readable description of the pattern. |

### Property Examples

```delphi
var
  P: TOLRegEx;
begin
  P := OLRegEx.Digit.Exactly(4).Literal('-').Digit.Exactly(2);
  
  ShowMessage(P.Pattern);      // Outputs: \d{4}-\d{2}
  ShowMessage(P.Explanation);  // Outputs: a digit (exactly 4 times), then literal "-", then a digit (exactly 2 times)
end;
```

---

## Terminals (Character Matchers)

| Method | Pattern | Description |
| :--- | :--- | :--- |
| `Literal(S)` | escaped text | Matches exact string (special chars escaped) |
| `Digit` | `\d` | Matches a digit (0-9) |
| `NonDigit` | `\D` | Matches any non-digit character |
| `Alphanumeric` | `\w` | Matches alphanumeric or underscore |
| `NonAlphanumeric` | `\W` | Matches non-alphanumeric character |
| `Whitespace` | `\s` | Matches whitespace (space, tab, newline) |
| `NonWhitespace` | `\S` | Matches non-whitespace |
| `AnyChar` | `.` | Matches any character (except newline) |
| `Tab` | `\t` | Matches tab character |
| `Letter` | `\p{L}` | Matches any Unicode letter |
| `Punctuation` | `\p{P}` | Matches any Unicode punctuation |
| `HexDigit` | `[0-9a-fA-F]` | Matches hexadecimal digit |
| `LineBreak` | `\R` | Matches any line break (CR, LF, CRLF) |

---

## Anchors

| Method | Pattern | Description |
| :--- | :--- | :--- |
| `StartOfLine` | `^` | Matches start of line (or text) |
| `EndOfLine` | `$` | Matches end of line (or text) |
| `StartOfText` | `\A` | Matches absolute start of text |
| `EndOfText` | `\z` | Matches absolute end of text |
| `WordBoundary` | `\b` | Matches word boundary |
| `NonWordBoundary` | `\B` | Matches non-word boundary |

---

## Quantifiers

### Greedy (default - match as much as possible)

| Method | Pattern | Description |
| :--- | :--- | :--- |
| `Exactly(N)` | `{N}` | Exactly N times |
| `Between(Min, Max)` | `{Min,Max}` | Between Min and Max times |
| `AtLeast(Min)` | `{Min,}` | At least Min times |
| `Optional` | `?` | Zero or one time |
| `OneOrMore` | `+` | One or more times |
| `ZeroOrMore` | `*` | Zero or more times |

### Lazy (match as few as possible)

| Method | Pattern | Description |
| :--- | :--- | :--- |
| `BetweenLazy(Min, Max)` | `{Min,Max}?` | Lazy version of Between |
| `AtLeastLazy(Min)` | `{Min,}?` | Lazy version of AtLeast |
| `OptionalLazy` | `??` | Lazy version of Optional |
| `OneOrMoreLazy` | `+?` | Lazy version of OneOrMore |
| `ZeroOrMoreLazy` | `*?` | Lazy version of ZeroOrMore |

### Possessive (no backtracking)

| Method | Pattern | Description |
| :--- | :--- | :--- |
| `ExactlyPossessive(N)` | `{N}+` | Possessive version of Exactly |
| `BetweenPossessive(Min, Max)` | `{Min,Max}+` | Possessive version of Between |
| `AtLeastPossessive(Min)` | `{Min,}+` | Possessive version of AtLeast |
| `OptionalPossessive` | `?+` | Possessive version of Optional |
| `OneOrMorePossessive` | `++` | Possessive version of OneOrMore |
| `ZeroOrMorePossessive` | `*+` | Possessive version of ZeroOrMore |

> [!TIP]
> Use **Lazy** quantifiers when extracting content between delimiters. Use **Possessive** for performance optimization when backtracking is not needed.

---

## Greedy vs Lazy Quantifiers

Understanding the difference is crucial for correct pattern matching:

```delphi
// Text: "<tag>First</tag><tag>Second</tag>"

// Greedy: matches from first <tag> to LAST </tag>
OLRegEx.Literal('<tag>').AnyChar.ZeroOrMore.Literal('</tag>')
// Captures: "First</tag><tag>Second"

// Lazy: matches from first <tag> to FIRST </tag>
OLRegEx.Literal('<tag>').AnyChar.ZeroOrMoreLazy.Literal('</tag>')
// Captures: "First"
```

For `OLString.Matches` (boolean check), both work identically. The difference matters when **extracting** matched content with `MatchCollection`.

---

## Groups

| Method | Description |
| :--- | :--- |
| `Group(Sub)` | Non-capturing group for combining elements |
| `Capture(Sub)` | Capturing group (accessible by index) |
| `Capture(Name, Sub)` | Named capturing group (accessible by name) |
| `Reference(Name)` | Backreference to named group |
| `Reference(Index)` | Backreference to group by index |

### Capturing Groups Example

```delphi
var
  Pattern: TOLRegEx;
  Text: string;
  Matches: TMatchCollection;
begin
  Pattern := OLRegEx
    .Capture('year', OLRegEx.Digit.Exactly(4))
    .Literal('-')
    .Capture('month', OLRegEx.Digit.Exactly(2))
    .Literal('-')
    .Capture('day', OLRegEx.Digit.Exactly(2));

  Text := '2024-01-15';
  Matches := Text.MatchCollection(Pattern);
  
  if Matches.Count > 0 then
  begin
    ShowMessage('Year: ' + Matches[0].Groups['year'].Value);   // 2024
    ShowMessage('Month: ' + Matches[0].Groups['month'].Value); // 01
    ShowMessage('Day: ' + Matches[0].Groups['day'].Value);     // 15
  end;
end;
```

---

## Alternatives

| Method | Description |
| :--- | :--- |
| `Choice(Options)` | Matches one of the literal strings |
| `AnyOf(Options)` | Matches one of the regex patterns |
| `Range(Start, End)` | Matches character in range |
| `CharSet(Chars)` | Matches any character from set |
| `NotCharSet(Chars)` | Matches any character NOT in set |

### Examples

```delphi
// Match file extension
OLRegEx.Choice(['jpg', 'png', 'gif'])  // Pattern: (?:jpg|png|gif)

// Match digit or letter pattern
OLRegEx.AnyOf([OLRegEx.Digit, OLRegEx.Letter])  // Pattern: (?:\d|\p{L})

// Match lowercase letter
OLRegEx.Range('a', 'z')  // Pattern: [a-z]

// Match vowel
OLRegEx.CharSet('aeiou')  // Pattern: [aeiou]
```

---

## Lookarounds

| Method | Pattern | Description |
| :--- | :--- | :--- |
| `Lookahead(Sub)` | `(?=...)` | Positive lookahead (assert what follows) |
| `NegativeLookahead(Sub)` | `(?!...)` | Negative lookahead |
| `Lookbehind(Sub)` | `(?<=...)` | Positive lookbehind (assert what precedes) |
| `NegativeLookbehind(Sub)` | `(?<!...)` | Negative lookbehind |

### Lookahead Example

```delphi
// Match number only if followed by "px"
Pattern := OLRegEx.Digit.OneOrMore.Lookahead(OLRegEx.Literal('px'));
// "100px" matches, capturing "100" (not "px")
```

---

## Engine Flags

| Method | Description |
| :--- | :--- |
| `CaseInsensitive(Sub)` | Makes subpattern case-insensitive |
| `CaseSensitive(Sub)` | Makes subpattern case-sensitive (explicit) |
| `DotAll` | Dot matches newlines too |
| `LineByLine` | `^` and `$` match line boundaries (multiline mode) |

---

## Validation Helpers

| Method | Description |
| :--- | :--- |
| `AsLeftMatch` | Anchors pattern to start of text |
| `AsFullMatch` | Anchors pattern to match entire text |

```delphi
// Validate that entire string is exactly 5 digits
Pattern := OLRegEx.Digit.Exactly(5).AsFullMatch;
// Pattern: \A(?:\d{5})\z
```

---

## Integration with OLString

`TOLRegEx` integrates seamlessly with `OLString` methods:

```delphi
var
  Text: OLString;
  Pattern: TOLRegEx;
begin
  Text := 'Order #12345 shipped';
  Pattern := OLRegEx.Literal('#').Digit.OneOrMore;

  // Boolean check
  if Text.Matches(Pattern) then
    ShowMessage('Contains order number');

  // Extract all matches
  for Match in Text.MatchCollection(Pattern) do
    ShowMessage('Found: ' + Match.Value);  // #12345
end;
```

---

## Complete Example: Log Parsing

```delphi
var
  Pattern: TOLRegEx;
  EventLog: string;
  Matches: TMatchCollection;
  M: TMatch;
begin
  // Extract date and message from exception log entries
  Pattern := OLRegEx
    .Literal('[')
    .Capture('date', OLRegEx.Digit.Exactly(4)
      .Literal('-').Digit.Exactly(2)
      .Literal('-').Digit.Exactly(2)
      .Whitespace
      .Digit.Exactly(2).Literal(':')
      .Digit.Exactly(2).Literal(':')
      .Digit.Exactly(2))
    .Literal(']')
    .AnyChar.ZeroOrMoreLazy        // Lazy to stop at first "Exception:"
    .Literal('Exception: ')
    .Capture('message', OLRegEx.AnyChar.OneOrMore)
    .LineByLine;

  EventLog := 
    '[2024-01-15 08:30:00] INFO: Started' + sLineBreak +
    '[2024-01-15 08:32:45] ERROR: Exception: Connection timeout' + sLineBreak +
    '[2024-01-15 09:15:22] ERROR: Exception: Access denied';

  Matches := EventLog.MatchCollection(Pattern);
  for M in Matches do
  begin
    ShowMessage('Date: ' + M.Groups['date'].Value);
    ShowMessage('Error: ' + M.Groups['message'].Value);
  end;
end;
```
