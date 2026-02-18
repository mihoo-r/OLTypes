# Regular Expressions with TOLRegEx - Tutorial

This tutorial will teach you how to create and use regular expressions (regex) in Delphi using the `TOLRegEx` library from the OLTypes package. Instead of writing cryptic pattern strings, you build expressions through readable method calls.

---

## Table of Contents

1. [Introduction: What Are Regular Expressions For?](#1-introduction)
2. [Literal and Escape](#2-literal-and-escape)
3. [Digit / NonDigit](#3-digit--nondigit)
4. [Alphanumeric / NonAlphanumeric](#4-alphanumeric--nonalphanumeric)
5. [Whitespace / Tab](#5-whitespace--tab)
6. [Letter / Punctuation / HexDigit](#6-letter--punctuation--hexdigit)
7. [AnyChar (Dot)](#7-anychar-dot)
8. [CharSet / NotCharSet / Range](#8-charset--notcharset--range)
9. [Choice / AnyOf](#9-choice--anyof)
10. [Optional](#10-optional)
11. [OneOrMore / ZeroOrMore](#11-oneormore--zeroormore)
12. [Exactly / AtLeast / Between](#12-exactly--atleast--between)
13. [Greedy vs Lazy](#13-greedy-vs-lazy)
14. [WordBoundary / NonWordBoundary](#14-wordboundary--nonwordboundary)
15. [StartOfLine / EndOfLine](#15-startofline--endofline)
16. [AsLeftMatch / AsFullMatch](#16-asleftmatch--asfullmatch)
17. [LineByLine](#17-linebyline)
18. [Groups](#18-groups)
19. [Capture](#19-capture)
20. [Reference](#20-reference)
21. [Lookahead / NegativeLookahead](#21-lookahead--negativelookahead)
22. [Lookbehind / NegativeLookbehind](#22-lookbehind--negativelookbehind)
23. [Summary](#23-summary)

---

## 1. Introduction

Regular expressions (regex) are patterns used to search and analyze text. They have two main use cases:

### Validation
Checking whether a text **matches** a specific format:

```delphi
var
  Pattern: TOLRegEx;
  Email: OLString;
begin
  Pattern := OLRegEx.Alphanumeric.OneOrMore
    .Literal('@')
    .Alphanumeric.OneOrMore
    .Literal('.')
    .Letter.AtLeast(2)
    .AsFullMatch;  // Enforces matching the entire text

  Email := 'user@example.com';
  if Email.Matches(Pattern) then
    ShowMessage('Valid email format');
end;
```

### Extraction
Extracting **fragments** of text that match a pattern:

```delphi
var
  Pattern: TOLRegEx;
  Text: OLString;
  Match: TMatch;
begin
  Pattern := OLRegEx.Literal('#').Digit.OneOrMore;  // Looks for "#" + digits
  Text := 'Order #12345 shipped';

  for Match in Text.MatchCollection(Pattern) do
    ShowMessage('Found: ' + Match.Value);  // #12345
end;
```

### TOLRegEx vs Raw Patterns

| Raw regex | TOLRegEx |
|-----------|----------|
| `\d+` | `OLRegEx.Digit.OneOrMore` |
| `[a-zA-Z]+@[a-zA-Z]+\.[a-zA-Z]{2,}` | `OLRegEx.Letter.OneOrMore.Literal('@').Letter.OneOrMore.Literal('.').Letter.AtLeast(2)` |

TOLRegEx automatically escapes special characters and generates a human-readable description of the pattern via the `Explanation` property.

---

## 2. Literal and Escape

### Literal - Exact Text
The `Literal` method matches exact text. Special regex characters (`.\+*?^$()[]{}|`) are automatically escaped.

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.Literal('Price: $100');
  // Generates: Price: \$100  ($ is escaped)
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'Price: $100'` | ✅ Yes | Exact match |
| `'Price: 100'` | ❌ No | Missing `$` sign |
| `'price: $100'` | ❌ No | Case difference |

### Special Character Escaping

In raw regex, the characters `.\+*?^$()[]{}|` have special meaning. TOLRegEx escapes them automatically:

```delphi
// Looking for the text "1+1=2"
Pattern := OLRegEx.Literal('1+1=2');
// Generates: 1\+1=2  (+ is escaped)
```

> [!TIP]
> Thanks to automatic escaping, you don't need to remember which characters are special - just use `Literal`.

---

## 3. Digit / NonDigit

### Digit (`\d`)
Matches a single digit (0-9).

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.Literal('ID:').Digit;  // Pattern: ID:\d
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'ID:5'` | ✅ Yes | "5" is a digit |
| `'ID:42'` | ✅ Yes | Matches "ID:4", "2" remains |
| `'ID:A'` | ❌ No | "A" is not a digit |

### NonDigit (`\D`)
Matches any character that is **not** a digit.

```delphi
Pattern := OLRegEx.NonDigit.OneOrMore;  // Pattern: \D+
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'abc'` | ✅ Yes | All letters |
| `'a1b'` | ✅ Yes | Matches "a", then stops at "1" |
| `'123'` | ❌ No | All digits, no NonDigit match |

---

## 4. Alphanumeric / NonAlphanumeric

### Alphanumeric (`\w`)
Matches a letter, digit, or underscore (a-z, A-Z, 0-9, _).

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.Alphanumeric.OneOrMore;  // Pattern: \w+
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'user_123'` | ✅ Yes | Letters, underscore, digits |
| `'John'` | ✅ Yes | All letters |
| `'john@mail'` | ✅ Yes | Matches "john", stops at "@" |
| `'@#$%'` | ❌ No | All special characters |

### NonAlphanumeric (`\W`)
Matches any character that is **not** alphanumeric.

```delphi
Pattern := OLRegEx.NonAlphanumeric;  // Pattern: \W
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'@'` | ✅ Yes | Special character |
| `' '` | ✅ Yes | Space |
| `'A'` | ❌ No | Letter is alphanumeric |

---

## 5. Whitespace / Tab

### Whitespace (`\s`)
Matches a space, tab, newline, and other whitespace characters.

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.Literal('Hello').Whitespace.Literal('World');
  // Pattern: Hello\sWorld
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'Hello World'` | ✅ Yes | Space between words |
| `'Hello	World'` | ✅ Yes | Tab between words |
| `'HelloWorld'` | ❌ No | No whitespace character |

### Tab (`\t`)
Matches only a tab character.

```delphi
Pattern := OLRegEx.Tab.Literal('data');  // Pattern: \tdata
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `#9'data'` | ✅ Yes | Tab + "data" (Delphi: #9 is tab) |
| `' data'` | ❌ No | Space is not a tab |

---

## 6. Letter / Punctuation / HexDigit

### Letter (`\p{L}`)
Matches any Unicode letter (Latin, Cyrillic, Greek, accented characters, etc.).

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.Letter.OneOrMore;  // Pattern: \p{L}+
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'Café'` | ✅ Yes | Accented Latin letters |
| `'Привет'` | ✅ Yes | Cyrillic |
| `'ABC123'` | ✅ Yes | Matches "ABC", stops at "1" |
| `'123'` | ❌ No | Digits are not letters |

### Punctuation (`\p{P}`)
Matches Unicode punctuation characters.

```delphi
Pattern := OLRegEx.Punctuation;  // Pattern: \p{P}
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'.'` | ✅ Yes | Period is punctuation |
| `'!'` | ✅ Yes | Exclamation mark |
| `'A'` | ❌ No | Letter |

### HexDigit (`[0-9a-fA-F]`)
Matches a hexadecimal digit.

```delphi
Pattern := OLRegEx.Literal('#').HexDigit.Exactly(6);  // Pattern: #[0-9a-fA-F]{6}
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'#FF5733'` | ✅ Yes | Valid HEX color |
| `'#abc123'` | ✅ Yes | Lowercase letters also OK |
| `'#GHIJKL'` | ❌ No | G, H, I... are not hex digits |

---

## 7. AnyChar (Dot)

### AnyChar (`.`)
Matches **any single character** except newline (unless `DotAll` mode is enabled).

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.Literal('a').AnyChar.Literal('c');  // Pattern: a.c
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'abc'` | ✅ Yes | "b" is any character |
| `'a1c'` | ✅ Yes | "1" is any character |
| `'a@c'` | ✅ Yes | "@" also matches |
| `'ac'` | ❌ No | No character between "a" and "c" |
| `'abbc'` | ❌ No | Two characters between "a" and "c" |

> [!WARNING]
> Use `AnyChar` carefully with quantifiers - `AnyChar.ZeroOrMore` can match too much text. See the [Greedy vs Lazy](#13-greedy-vs-lazy) section.

---

## 8. CharSet / NotCharSet / Range

### CharSet (`[abc]`)
Matches **one character** from the given set.

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.CharSet('aeiou');  // Pattern: [aeiou]
  // Matches a vowel
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'a'` | ✅ Yes | "a" is in the set |
| `'e'` | ✅ Yes | "e" is in the set |
| `'b'` | ❌ No | "b" is not a vowel |

### NotCharSet (`[^abc]`)
Matches **one character NOT** in the set.

```delphi
Pattern := OLRegEx.NotCharSet('aeiou');  // Pattern: [^aeiou]
// Matches a consonant or other character
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'b'` | ✅ Yes | "b" is not a vowel |
| `'1'` | ✅ Yes | "1" is not a vowel |
| `'a'` | ❌ No | "a" is in the exclusion set |

### Range (`[a-z]`)
Matches a character within a specified range.

```delphi
Pattern := OLRegEx.Range('a', 'z');  // Pattern: [a-z]
// Matches a lowercase letter
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'m'` | ✅ Yes | "m" is between a-z |
| `'A'` | ❌ No | Uppercase letter, range is a-z |
| `'5'` | ❌ No | Digit, not a letter |

---

## 9. Choice / AnyOf

### Choice - Literal Alternatives
Matches **one of the given texts**.

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.Choice(['cat', 'dog', 'fish']);
  // Pattern: (?:cat|dog|fish)
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'cat'` | ✅ Yes | "cat" is on the list |
| `'dog'` | ✅ Yes | "dog" is on the list |
| `'catfish'` | ✅ Yes | Contains "cat" |
| `'bird'` | ❌ No | None of the three words |

### AnyOf - Pattern Alternatives
Matches **one of the given regex patterns**.

```delphi
Pattern := OLRegEx.AnyOf([
  OLRegEx.Digit.OneOrMore,    // Number
  OLRegEx.Letter.OneOrMore    // Word
]);
// Pattern: (?:\d+|\p{L}+)
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'123'` | ✅ Yes | Matches first pattern |
| `'abc'` | ✅ Yes | Matches second pattern |
| `'@#$'` | ❌ No | Neither digits nor letters |

> [!TIP]
> Use `Choice` for simple text alternatives, `AnyOf` for complex pattern alternatives.

---

## 10. Optional

### Optional (`?`)
Indicates that the previous element can occur **0 or 1 time**.

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.Literal('-').Optional.Digit.OneOrMore;
  // Pattern: -?\d+
  // Optional minus, then digits
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'42'` | ✅ Yes | Number without minus |
| `'-42'` | ✅ Yes | Number with minus |
| `'--42'` | ❌ No | Two minuses - Optional allows max 1 |

```delphi
// Example: optional letter "s" at the end of a word
Pattern := OLRegEx.Literal('car').Literal('s').Optional;
// Pattern: cars?
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'car'` | ✅ Yes | Without "s" |
| `'cars'` | ✅ Yes | With "s" |
| `'carss'` | ❌ No | Only one "s" allowed |

---

## 11. OneOrMore / ZeroOrMore

### OneOrMore (`+`)
Requires **at least one** occurrence of the previous element.

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.Digit.OneOrMore;  // Pattern: \d+
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'5'` | ✅ Yes | One digit |
| `'12345'` | ✅ Yes | Multiple digits |
| `''` | ❌ No | Empty text - requires at least 1 |
| `'abc'` | ❌ No | No digits |

### ZeroOrMore (`*`)
Allows **zero or more** occurrences of the previous element.

```delphi
Pattern := OLRegEx.Literal('a').Literal('b').ZeroOrMore.Literal('c');
// Pattern: ab*c
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'ac'` | ✅ Yes | Zero "b"s |
| `'abc'` | ✅ Yes | One "b" |
| `'abbbc'` | ✅ Yes | Three "b"s |
| `'adc'` | ❌ No | "d" doesn't match "b*" |

---

## 12. Exactly / AtLeast / Between

### Exactly (`{n}`)
Requires **exactly n** occurrences.

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.Digit.Exactly(4);  // Pattern: \d{4}
  // Exactly 4 digits
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'1234'` | ✅ Yes | Exactly 4 digits |
| `'12345678'` | ✅ Yes | Matches the first 4 |
| `'123'` | ❌ No | Too few digits |

### AtLeast (`{n,}`)
Requires **at least n** occurrences.

```delphi
Pattern := OLRegEx.Letter.AtLeast(3);  // Pattern: \p{L}{3,}
// Minimum 3 letters
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'abc'` | ✅ Yes | Exactly 3 letters |
| `'abcdef'` | ✅ Yes | 6 letters > 3 |
| `'ab'` | ❌ No | Only 2 letters |

### Between (`{n,m}`)
Requires **from n to m** occurrences.

```delphi
Pattern := OLRegEx.Digit.Between(2, 4);  // Pattern: \d{2,4}
// From 2 to 4 digits
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'12'` | ✅ Yes | 2 digits (minimum) |
| `'123'` | ✅ Yes | 3 digits |
| `'1234'` | ✅ Yes | 4 digits (maximum) |
| `'1'` | ❌ No | Too few |
| `'12345'` | ✅ Yes | Matches 4 digits, "5" remains |

---

## 13. Greedy vs Lazy

### Default Behavior: Greedy
Quantifiers by default match **as many** characters as possible.

```delphi
var
  Pattern: TOLRegEx;
  Text: OLString;
begin
  Pattern := OLRegEx.Literal('<').AnyChar.ZeroOrMore.Literal('>');
  // Pattern: <.*>
  Text := '<tag>content</tag>';
  // Greedy matches: "<tag>content</tag>" (from first < to last >)
end;
```

### Lazy - Match as Few as Possible
Adding `Lazy` to a quantifier causes it to match **as few** characters as possible.

```delphi
Pattern := OLRegEx.Literal('<').AnyChar.ZeroOrMoreLazy.Literal('>');
// Pattern: <.*?>
Text := '<tag>content</tag>';
// Lazy matches: "<tag>" (first match)
```

### Comparison

| Quantifier | Greedy | Lazy |
|------------|--------|------|
| `?` | `Optional` | `OptionalLazy` |
| `+` | `OneOrMore` | `OneOrMoreLazy` |
| `*` | `ZeroOrMore` | `ZeroOrMoreLazy` |
| `{n,m}` | `Between(n, m)` | `BetweenLazy(n, m)` |
| `{n,}` | `AtLeast(n)` | `AtLeastLazy(n)` |

### Practical Example

```delphi
var
  Text: OLString;
  GreedyPattern, LazyPattern: TOLRegEx;
  M: TMatch;
begin
  Text := '"first" and "second"';

  // Greedy: matches everything from first " to last "
  GreedyPattern := OLRegEx.Literal('"').AnyChar.OneOrMore.Literal('"');
  for M in Text.MatchCollection(GreedyPattern) do
    WriteLn(M.Value);  // Outputs: "first" and "second"

  // Lazy: matches each quote separately
  LazyPattern := OLRegEx.Literal('"').AnyChar.OneOrMoreLazy.Literal('"');
  for M in Text.MatchCollection(LazyPattern) do
    WriteLn(M.Value);  // Outputs: "first", then "second"
end;
```

> [!IMPORTANT]
> For `Matches` checks (true/false), the difference doesn't matter. It matters when **extracting** text using `MatchCollection`.

---

## 14. WordBoundary / NonWordBoundary

### WordBoundary (`\b`)
Matches a **word boundary** - the position between an alphanumeric and a non-alphanumeric character.

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.WordBoundary.Literal('cat').WordBoundary;
  // Pattern: \bcat\b
  // Matches "cat" as a whole word
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'I have cats'` | ❌ No | "cats" ≠ "cat" |
| `'the cat is'` | ✅ Yes | "cat" as a separate word |
| `'catfish'` | ❌ No | "cat" is part of "catfish" |
| `'a cat.'` | ✅ Yes | Period ends the word |

### NonWordBoundary (`\B`)
Matches a position that is **not** a word boundary.

```delphi
Pattern := OLRegEx.NonWordBoundary.Literal('at');
// Pattern: \Bat
// "at" inside a word
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'catch'` | ✅ Yes | "at" inside a word |
| `'at'` | ❌ No | "at" at the beginning - it's a boundary |
| `'robot'` | ✅ Yes | "at" is not present, but "ot" - no match for "at" |

---

## 15. StartOfLine / EndOfLine

### StartOfLine (`^`)
Matches the **beginning of a line** (or text in single-line mode).

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.StartOfLine.Digit.OneOrMore;
  // Pattern: ^\d+
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'123abc'` | ✅ Yes | Starts with digits |
| `'abc123'` | ❌ No | Digits are not at the beginning |

### EndOfLine (`$`)
Matches the **end of a line** (or text).

```delphi
Pattern := OLRegEx.Digit.OneOrMore.EndOfLine;
// Pattern: \d+$
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'abc123'` | ✅ Yes | Ends with digits |
| `'123abc'` | ❌ No | Ends with letters |

### Combination: Entire Line

```delphi
Pattern := OLRegEx.StartOfLine.Digit.OneOrMore.EndOfLine;
// Pattern: ^\d+$
// The entire line is digits only
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'12345'` | ✅ Yes | Digits only |
| `'123abc'` | ❌ No | Letters at the end |
| `'abc123'` | ❌ No | Letters at the beginning |

---

## 16. AsLeftMatch / AsFullMatch

### AsLeftMatch
Enforces matching **from the beginning of text**. Useful for prefix validation.

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.Literal('http').AsLeftMatch;
  // Pattern: \A(?:http)
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'http://example.com'` | ✅ Yes | Starts with "http" |
| `'ftp://http.org'` | ❌ No | "http" is not at the beginning |

### AsFullMatch
Enforces matching **the entire text**. Ideal for form validation.

```delphi
Pattern := OLRegEx.Digit.Exactly(5).AsFullMatch;
// Pattern: \A(?:\d{5})\z
// Exactly 5 digits, nothing more
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'12345'` | ✅ Yes | Exactly 5 digits |
| `'1234'` | ❌ No | Too few digits |
| `'123456'` | ❌ No | Too many digits |
| `'12345a'` | ❌ No | Letter at the end |

> [!TIP]
> Use `AsFullMatch` for validating user input (postal codes, phone numbers, etc.).

---

## 17. LineByLine

### Multiline Mode (`(?m)`)
Enables a mode where `^` and `$` match the beginning and end of **each line**, not just the entire text.

```delphi
var
  Pattern: TOLRegEx;
  Text: OLString;
  M: TMatch;
begin
  Pattern := OLRegEx.StartOfLine.Digit.OneOrMore.EndOfLine.LineByLine;
  // Pattern: (?m)^\d+$

  Text := 'abc' + sLineBreak + '123' + sLineBreak + 'xyz';

  for M in Text.MatchCollection(Pattern) do
    WriteLn(M.Value);  // Outputs: 123
end;
```

### Comparison

```delphi
// Without LineByLine - only the first/last position of the text
OLRegEx.StartOfLine.Digit.OneOrMore
// Pattern: ^\d+

// With LineByLine - each line separately
OLRegEx.StartOfLine.Digit.OneOrMore.LineByLine
// Pattern: (?m)^\d+
```

| Multiline text | Without LineByLine | With LineByLine |
|----------------|-------------------|-----------------|
| `'abc\n123\n456'` | No match (text doesn't start with digits) | Matches "123" and "456" |

---

## 18. Groups

### Group - Non-Capturing Grouping
The `Group` method combines elements into a single unit that can be repeated by quantifiers.

```delphi
var Pattern: TOLRegEx;
begin
  // Pattern: two digits and a dash, repeated 3 times
  Pattern := OLRegEx.Group(
    OLRegEx.Digit.Exactly(2).Literal('-')
  ).Exactly(3);
  // Pattern: (?:\d{2}-){3}
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'12-34-56-'` | ✅ Yes | Three pairs of digits with dashes |
| `'12-34-'` | ❌ No | Only two pairs |
| `'123-45-67-'` | ❌ No | First pair has 3 digits |

### Use Case: Optional Group

```delphi
// Phone number with optional country code
Pattern := OLRegEx
  .Group(OLRegEx.Literal('+1 ')).Optional
  .Digit.Exactly(3)
  .Literal('-')
  .Digit.Exactly(3)
  .Literal('-')
  .Digit.Exactly(4);
// Pattern: (?:\+1 )?\d{3}-\d{3}-\d{4}
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'+1 123-456-7890'` | ✅ Yes | With country code |
| `'123-456-7890'` | ✅ Yes | Without country code |
| `'+2 123-456-7890'` | ❌ No | Wrong country code |

---

## 19. Capture

### Capture - Extracting Fragments
`Capture` creates a group whose contents can be extracted from the match.

```delphi
var
  Pattern: TOLRegEx;
  Text: OLString;
  Matches: TMatchCollection;
begin
  Pattern := OLRegEx
    .Literal('Price: ')
    .Capture(OLRegEx.Digit.OneOrMore)  // Captures the number
    .Literal(' USD');
  // Pattern: Price: (\d+) USD

  Text := 'Price: 150 USD';
  Matches := Text.MatchCollection(Pattern);

  if Matches.Count > 0 then
  begin
    WriteLn('Full match: ' + Matches[0].Value);           // Price: 150 USD
    WriteLn('Group 1: ' + Matches[0].Groups[1].Value);    // 150
  end;
end;
```

### Named Capture
Named groups are more readable and easier to use.

```delphi
Pattern := OLRegEx
  .Capture('year', OLRegEx.Digit.Exactly(4))
  .Literal('-')
  .Capture('month', OLRegEx.Digit.Exactly(2))
  .Literal('-')
  .Capture('day', OLRegEx.Digit.Exactly(2));
// Pattern: (?P<year>\d{4})-(?P<month>\d{2})-(?P<day>\d{2})

Text := '2024-01-15';
Matches := Text.MatchCollection(Pattern);

WriteLn('Year: ' + Matches[0].Groups['year'].Value);    // 2024
WriteLn('Month: ' + Matches[0].Groups['month'].Value);  // 01
WriteLn('Day: ' + Matches[0].Groups['day'].Value);      // 15
```

### Multiple Matches

```delphi
Pattern := OLRegEx.Literal('#').Capture(OLRegEx.Digit.OneOrMore);
Text := 'Orders: #100, #200, #300';

for Match in Text.MatchCollection(Pattern) do
  WriteLn('Number: ' + Match.Groups[1].Value);
// Outputs: 100, 200, 300
```

---

## 20. Reference

### Reference - Backreference to a Captured Group
Matches **the same text** that was captured earlier.

```delphi
var Pattern: TOLRegEx;
begin
  // Finds repeated words e.g. "the the"
  Pattern := OLRegEx
    .Capture(OLRegEx.Alphanumeric.OneOrMore)  // Captures a word
    .Whitespace
    .Reference(1);  // Matches the same word
  // Pattern: (\w+)\s\1
end;
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'the the'` | ✅ Yes | "the" repeated |
| `'is is'` | ✅ Yes | "is" repeated |
| `'the a'` | ❌ No | Different words |

### Named Reference

```delphi
// Matches HTML tags: <tag>...</tag>
Pattern := OLRegEx
  .Literal('<')
  .Capture('tag', OLRegEx.Alphanumeric.OneOrMore)
  .Literal('>')
  .AnyChar.ZeroOrMoreLazy
  .Literal('</')
  .Reference('tag')  // Must be the same tag
  .Literal('>');
// Pattern: <(?P<tag>\w+)>.*?</(?P=tag)>
```

| Text | Matches? | Explanation |
|------|----------|-------------|
| `'<b>text</b>'` | ✅ Yes | Opening = closing |
| `'<div>text</div>'` | ✅ Yes | Works for any tag |
| `'<b>text</i>'` | ❌ No | Different tags |

---

## 21. Lookahead / NegativeLookahead

### Lookahead (`(?=...)`)
An **assertion** that checks what **follows** the current position, without consuming text.

```delphi
var Pattern: TOLRegEx;
begin
  // Number before "px", but without matching "px"
  Pattern := OLRegEx.Digit.OneOrMore.Lookahead(OLRegEx.Literal('px'));
  // Pattern: \d+(?=px)
end;
```

| Text | Match | Explanation |
|------|-------|-------------|
| `'100px'` | ✅ `'100'` | Digits before "px" |
| `'100em'` | ❌ None | No "px" after digits |
| `'width100px'` | ✅ `'100'` | Finds digits before "px" |

### NegativeLookahead (`(?!...)`)
An assertion that checks that the current position is **NOT followed by** the given pattern.

```delphi
// A word that is NOT followed by "@"
Pattern := OLRegEx.Alphanumeric.OneOrMore.NegativeLookahead(OLRegEx.Literal('@'));
// Pattern: \w+(?!@)
```

| Text | Match | Explanation |
|------|-------|-------------|
| `'user@mail'` | ❌ No full "user" match | "user" is before "@" |
| `'admin'` | ✅ `'admin'` | No "@" after the word |
| `'user name'` | ✅ `'user'` | Space is not "@" |

### Practical Example: Password Validation

```delphi
// Password must contain a digit (lookahead checks without consuming)
Pattern := OLRegEx
  .Lookahead(OLRegEx.AnyChar.ZeroOrMore.Digit)  // There must be a digit somewhere
  .AnyChar.AtLeast(8)  // Minimum 8 characters
  .AsFullMatch;
```

---

## 22. Lookbehind / NegativeLookbehind

### Lookbehind (`(?<=...)`)
An assertion that checks what **precedes** the current position.

```delphi
var Pattern: TOLRegEx;
begin
  // A number after the "$" sign
  Pattern := OLRegEx.Lookbehind(OLRegEx.Literal('$')).Digit.OneOrMore;
  // Pattern: (?<=\$)\d+
end;
```

| Text | Match | Explanation |
|------|-------|-------------|
| `'$100'` | ✅ `'100'` | Digits after "$" |
| `'100'` | ❌ None | No "$" before the digits |
| `'€50'` | ❌ None | "€" is not "$" |

### NegativeLookbehind (`(?<!...)`)
An assertion that checks that the current position is **NOT preceded by** the given pattern.

```delphi
// A number NOT preceded by a minus
Pattern := OLRegEx.NegativeLookbehind(OLRegEx.Literal('-')).Digit.OneOrMore;
// Pattern: (?<!-)\d+
```

| Text | Match | Explanation |
|------|-------|-------------|
| `'42'` | ✅ `'42'` | No minus |
| `'-42'` | ❌ None for "42" | Preceded by minus |
| `'a42'` | ✅ `'42'` | Preceded by a letter, not minus |

### Combining Lookahead and Lookbehind

```delphi
// Text inside parentheses, but without the parentheses
Pattern := OLRegEx
  .Lookbehind(OLRegEx.Literal('('))
  .AnyChar.OneOrMoreLazy
  .Lookahead(OLRegEx.Literal(')'));
// Pattern: (?<=\().+?(?=\))
```

| Text | Match | Explanation |
|------|-------|-------------|
| `'(test)'` | ✅ `'test'` | Without parentheses |
| `'(a)(b)'` | ✅ `'a'`, `'b'` | Two matches |

---

## 23. Summary

### TOLRegEx Element Categories

#### Terminals (Character Matchers)
Match **individual characters** or **character sequences**.

| Method | Pattern | Description |
|--------|---------|-------------|
| `Literal(S)` | escaped text | Exact text |
| `Digit` | `\d` | Digit 0-9 |
| `NonDigit` | `\D` | Non-digit |
| `Alphanumeric` | `\w` | Letter, digit, underscore |
| `NonAlphanumeric` | `\W` | Non-alphanumeric |
| `Whitespace` | `\s` | Whitespace character |
| `NonWhitespace` | `\S` | Non-whitespace |
| `AnyChar` | `.` | Any character |
| `Tab` | `\t` | Tab character |
| `Letter` | `\p{L}` | Unicode letter |
| `Punctuation` | `\p{P}` | Unicode punctuation |
| `HexDigit` | `[0-9a-fA-F]` | Hexadecimal digit |
| `LineBreak` | `\R` | Line break |
| `CharSet(S)` | `[abc]` | One from set |
| `NotCharSet(S)` | `[^abc]` | Not from set |
| `Range(A, B)` | `[a-z]` | Character from range |

#### Anchors
Match **positions** in text, not characters.

| Method | Pattern | Description |
|--------|---------|-------------|
| `StartOfLine` | `^` | Start of line |
| `EndOfLine` | `$` | End of line |
| `StartOfText` | `\A` | Absolute start of text |
| `EndOfText` | `\z` | Absolute end of text |
| `WordBoundary` | `\b` | Word boundary |
| `NonWordBoundary` | `\B` | Non-word boundary |

#### Quantifiers

| Method | Greedy | Lazy | Possessive |
|--------|--------|------|------------|
| Optional | `Optional` (`?`) | `OptionalLazy` | `OptionalPossessive` |
| One or more | `OneOrMore` (`+`) | `OneOrMoreLazy` | `OneOrMorePossessive` |
| Zero or more | `ZeroOrMore` (`*`) | `ZeroOrMoreLazy` | `ZeroOrMorePossessive` |
| Exactly n | `Exactly(n)` | - | `ExactlyPossessive(n)` |
| At least n | `AtLeast(n)` | `AtLeastLazy(n)` | `AtLeastPossessive(n)` |
| Between n and m | `Between(n,m)` | `BetweenLazy(n,m)` | `BetweenPossessive(n,m)` |

#### Grouping

| Method | Description |
|--------|-------------|
| `Group(Sub)` | Non-capturing group |
| `Capture(Sub)` | Capturing group (by index) |
| `Capture(Name, Sub)` | Capturing group (by name) |
| `Reference(Index)` | Backreference to group #n |
| `Reference(Name)` | Backreference to named group |
| `Choice([...])` | Literal alternatives |
| `AnyOf([...])` | Pattern alternatives |

#### Lookaround (Assertions)

| Method | Pattern | Description |
|--------|---------|-------------|
| `Lookahead(Sub)` | `(?=...)` | Positive lookahead |
| `NegativeLookahead(Sub)` | `(?!...)` | Negative lookahead |
| `Lookbehind(Sub)` | `(?<=...)` | Positive lookbehind |
| `NegativeLookbehind(Sub)` | `(?<!...)` | Negative lookbehind |

#### Flags (Engine Flags)

| Method | Pattern | Description |
|--------|---------|-------------|
| `CaseInsensitive(Sub)` | `(?i:...)` | Ignore case |
| `CaseSensitive(Sub)` | `(?-i:...)` | Case-sensitive |
| `DotAll` | `(?s)` | Dot matches `\n` too |
| `LineByLine` | `(?m)` | `^`/`$` match line boundaries |

#### Validation Helpers

| Method | Description |
|--------|-------------|
| `AsLeftMatch` | Enforces matching from the start of text |
| `AsFullMatch` | Enforces matching the entire text |

---

### Useful Properties

```delphi
var Pattern: TOLRegEx;
begin
  Pattern := OLRegEx.Digit.OneOrMore.Literal('-').Digit.Exactly(2);

  WriteLn(Pattern.Pattern);     // \d+-\d{2}
  WriteLn(Pattern.Explanation); // a digit (one or more times), then literal "-", then a digit (exactly 2 times)
end;
```

### Integration with OLString

```delphi
var
  Text: OLString;
  Pattern: TOLRegEx;
begin
  Text := 'Order #12345';
  Pattern := OLRegEx.Literal('#').Digit.OneOrMore;

  // Checking
  if Text.Matches(Pattern) then ...

  // Extraction
  for Match in Text.MatchCollection(Pattern) do ...
end;
```
