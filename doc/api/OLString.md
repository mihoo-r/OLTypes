# OLString

`OLString` is a powerful value type that extends the standard Delphi `string` with `Null` state support and a vast array of helper methods for text manipulation, file I/O, web integration, and structured data (JSON/XML/CSV).

## Properties

### Basic
| Property | Type | Description |
| :--- | :--- | :--- |

| `Chars[Index]` | `Char` | (Default property) Gets or sets the character at 1-based index. |

### Structured Access
| Property | Type | Description |
| :--- | :--- | :--- |
| `Lines[Index]` | `OLString` | Gets or sets the line at the specified index. |
| `CSV[Index]` | `OLString` | Gets or sets the CSV field at the specified index. |
| `Params[Name]` | `OLString` | Gets or sets template parameters (e.g., `s.Params['name'] := 'John'`). |
| `JSON[Path]` | `OLString` | (Delphi XE6+) Gets or sets JSON field value by name/path. |
| `XML[XPath]` | `OLString` | (Delphi XE6+) Gets or sets XML element value by XPath. |
| `Base64` | `OLString` | Gets or sets the Base64 encoded version of the string. |

---

## Basic Operations & State

| Method | Description |
| :--- | :--- |
| `IsNull()` | Returns `True` if the string is `Null`. |
| `IsEmptyStr()` | Returns `True` if the string is exactly `''`. |
| `IsNullOrEmpty()` | Returns `True` if the string is `Null` or `''`. |
| `Length()` | Returns the character count. |
| `LowerCase()`, `UpperCase()`, `InitCaps()` | Case transformations. |
| `Trimmed()`, `TrimmedLeft()`, `TrimmedRight()` | Removes whitespace. |
| `ToString()` / `ToSQLString()` | Native string and SQL-safe conversion. |

### Basic Examples
```delphi
var
  s: OLString;
begin
  s := '  hello world  ';
  Writeln(s.Trimmed.InitCaps.ToString); // 'Hello World'
  Writeln(s.Length.ToString);           // '15'
end;
```

---

## Search & Pattern Matching

| Method | Description |
| :--- | :--- |
| `ContainsStr()`, `ContainsText()` | Checks if substring exists (Str=CaseSensitive, Text=Insensitive). |
| `StartsStr()`, `EndsStr()` | Check prefix/suffix. |
| `Pos()`, `PosEx()`, `PosLast()` | Find position of substring. |
| `Like(Pattern)` | SQL-like pattern matching (using `%` and `_`). |
| `MatchStr()`, `MatchText()` | Checks if string matches any value in an array. |
| `OccurrencesCount(Sub)` | Counts how many times `Sub` appears. |

### Search Examples
```delphi
var
  email: OLString;
begin
  email := 'test@example.com';
  if email.EndsText('.com') then Writeln('Commercial');
  if email.Like('%@%') then Writeln('Valid format');
  Writeln(email.Pos('@').ToString); // '5'
end;
```

---

## Manipulation

| Method | Description |
| :--- | :--- |
| `MidStr(Start, Count)` | Returns extracted substring. |
| `LeftStr(n)`, `RightStr(n)` | Returns a string extracted from begin/end. |
| `Replaced(Old, New)` | Returns a string with all occurrences replaced. |
| `ReplacedFirst(Old, New)` | Returns a string with only the first occurrence replaced. |
| `Deleted(Pos, Count)` | Returns a string with deleted characters. |
| `Inserted(Str, Pos)` | Returns a string with inserted substring. |
| `SplitString(Delim)`| Returns an array of strings. |
| `ReversedString()` | Returns reversed string. |

### Manipulation Examples
```delphi
var
  s: OLString;
begin
  s := 'ABC-123-DEF';
  Writeln(s.Replaced('-', '/').ToString); // 'ABC/123/DEF'
  Writeln(s.LeftStr(3).ToString);         // 'ABC'
  Writeln(s.Deleted(4, 4).ToString);      // 'ABCDEF'
end;
```

---

## File & Web

| Method | Description |
| :--- | :--- |
| `LoadFromFile(Path)` | Loads text from file. |
| `SaveToFile(Path)` | Saves text to file. |
| `GetFromUrl(URL)` | Downloads content from URL. |
| `CopyToClipboard()` | Puts string in Windows clipboard. |
| `EncodeBase64FromFile()` | Loads file and encodes to Base64. |
| `IsValidIBAN()` | Validates International Bank Account Number. |

---

## Feature Overview

| Feature | Description | Requirement |
| :--- | :--- | :--- |
| `JSON[Path]` | Gets or sets JSON values by path (e.g. `User.Name` or `Items[0]`). | Delphi XE6+ |
| `XML[XPath]` | Gets or sets XML element/attribute values by XPath. | Delphi XE6+ |
| `CSV[Index]` | Gets or sets the CSV field at the specified index. | Delphi XE3+ |
| `Params[Name]` | Template engine: replaces `:Name` with a value. | Delphi XE3+ |
| `Lines[Index]` | Gets or sets a line by index. | Delphi XE3+ |
| `Base64` | Property to get/set Base64 representation of the string. | Delphi XE3+ |
| `Compressed` | Returns a ZLib-compressed version of the string. | Delphi XE3+ |
| `HashStr` | Returns a hex-encoded hash of the string. | Delphi XE3+ |

---

## Notable examples

### 1. The Power of Null-Safe Chaining
Standard Delphi strings crash if you try to call methods on an uninitialized state. `OLString` propagates `Null` safely through your entire chain.

```delphi
var
  s: OLString; // Uninitialized (Null)
begin
  // This will NOT crash. It will simply return Null.
  Writeln('Result: ' + s.Trimmed.UpperCase.Reverse.ToString); 
  // Result: "" (Empty string because ToString on Null is empty)
end;
```

### 2. JSON Manipulation
Work with JSON strings using simple path navigation.

```delphi
var
  s: OLString;
begin
  // Creation and modification
  s.JSON['User.Name'] := 'Antigravity';
  s.JSON['User.Roles[0]'] := 'Admin';
  
  Writeln(s); // {"User":{"Name":"Antigravity","Roles":["Admin"]}}
  
  // Navigation
  if s.JSON['User.Name'] = 'Antigravity' then
    Writeln('Access Granted');
end;
```

### 3. XML Manipulation
Access and modify XML elements or attributes using XPath-like syntax.

```delphi
var
  s: OLString;
begin
  s.XML['/config/theme'] := 'Dark';
  if s.XML['/config/theme'] = 'Dark' then
    Writeln('Dark mode enabled');
    
  s.XML['/config/theme/@version'] := '1.0';
end;
```

### 4. Smart Templates (Params)
Perfect for SQL queries or dynamic messages.

```delphi
var
  msg: OLString;
begin
  msg := 'Hello :user, your code is :code.';
  msg.Params['user'] := 'John';
  msg.Params['code'] := '1234';
  
  Writeln(msg); // 'Hello John, your code is 1234.'
end;
```

### 5. File & Web Express
Handle downloads and file operations with zero boilerplate.

```delphi
var
  content: OLString;
begin
  // Download, compress, and save
  content.GetFromUrl('https://api.example.com/data');
  if content.HasValue then
    content.Compressed.SaveToFile('data.zlib');
    
  // Load and decode Base64
  content.EncodeBase64FromFile('photo.jpg');
end;
```

---

## Conversion & Parsing

| Method | Description |
| :--- | :--- |
| `ToInt()`, `ToFloat()`, `ToDate()`, `ToCurr()` | Unsafe conversion (raises exception if fails). |
| `TryToInt()`, `TryToDate()`, etc. | Safe conversion (returns `OLBoolean`). |
| `SmartStrToDate()` | Advanced date parsing (handles 'today', 'yesterday', '2023-01-01', etc.). |

---

## Random Generation
```delphi
var
  pwd, choice: OLString;
begin
  pwd := OLString.RandomString(12); // Generates 12 random chars
  choice := OLString.RandomFrom(['Value1', 'Value2', 'Value3']);
end;
```

---

## Operators

`OLString` supports:
- `+` for concatenation.
- `=`, `<>`, `>`, `>=`, `<`, `<=` for alphabetical comparison.
- `Implicit` cast from/to `string`, `Variant`, `OLInteger`, etc.

> [!CAUTION]
> Implicit conversion to native `string` will raise an exception if the `OLString` is `Null`, unless `SetNullAsDefault` was called.
