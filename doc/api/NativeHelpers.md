# Native Type Helpers

The OLTypes library extends standard Delphi primitive types (Integer, String, Double, etc.) using **Class Helpers**. This allows you to use many of the library's advanced methods directly on native variables without needing to manualy convert them to `OL` types.

## Available Helpers

### Integer & Int64 Helpers
Extended methods and properties for native `Integer` and `Int64` types.
- **Predicates**: `IsEven`, `IsOdd`, `IsPrime`, `IsPositive`, `IsNegative`, `IsDividableBy(i)`.
- **Math**: `Sqr`, `Abs`, `Power`, `Max(i)`, `Min(i)`, `Round(digits)`.
- **Conversion**: `Binary`, `Hexidecimal`, `Octal`, `ToNumeralSystem(base)`.
- **Looping**: `ForLoop(Start, End, Procedure)` - Clean functional loops.
- **Random**: `Random(Min, Max)`, `RandomPrime(Min, Max)`.
- **Range**: `Between(min, max)`, `Increased(by)`, `Decreased(by)`.

```delphi
var
  i: Integer;
begin
  i := 17;
  if i.IsPrime then 
    Writeln(i.ToString + ' is prime');
    
  Writeln(i.Binary); // '10001'
end;
```

### String Helper
Extended methods and properties for the native `string` type.

| Feature | Description | Requirement |
| :--- | :--- | :--- |
| `JSON[Path]` | Gets JSON values by path (e.g. `user.id` or `Items[0].Name`). Use `WithJSON` to set values. | Delphi XE6+ |
| `XML[XPath]` | Gets XML element/attribute values by XPath. Use `WithXML` to set values. | Delphi XE6+ |
| `CSV[Index]` | Gets the CSV field at the specified index. Use `WithCSV` to set values. | Delphi XE3+ |
| `WithParam(Name, Value)` | Simple template engine: replaces `:Name` with a value. Use `WithParams` to set multiple values. | Delphi XE3+ |
| `Lines[Index]` | Gets a line by index (handles line breaks automatically). Use `WithLines` to set values. | Delphi XE3+ |
| `Base64` | Property to get Base64 representation of the string. | Delphi XE3+ |
| `Compressed` | Returns a ZLib-compressed version of the string. | Delphi XE3+ |
| `HashStr` | Returns a hex-encoded hash of the string. | Delphi XE3+ |

#### Notable examples

**1. Instant JSON Mastery**
```delphi
var
  s: string;
begin
  s := s.WithJSON('User.Name', 'Smith');
  s := s.WithJSON('User.Roles[0]', 'Admin');
  s := s.WithJSON('User.Roles[1]', 'Developer');
  
  Writeln(s); 
  // Result: {"User":{"Name":"Smith","Roles":["Admin","Developer"]}}
  
  if s.JSON['User.Name'] = 'Smith' then
    Writeln('Hello, John!');
end;
```

**2. Fluent Templates & Params**
```delphi
var
  sql: string;
begin
  sql := 'SELECT * FROM users WHERE id = :id AND status = :status';
  sql := sql.WithParam('id', '100')
            .WithParam('status', 'active');
  
  Writeln(sql); // 'SELECT * FROM users WHERE id = 100 AND status = active'
end;
```

**3. File & Data Shortcuts**
```delphi
var
  imgData: string;
begin
  // Load file, encode to Base64, and save to another file
  imgData := OLString.Base64FromFile('photo.jpg');
  Writeln('Size in Base64: ' + imgData.Length.ToString);
  imgData.SaveToFile('photo.txt');
end;
```

**4. Pattern Matching & Logic**
```delphi
var
  s: string;
begin
  s := 'Invoice_2023_001.pdf';
  if s.Like('Invoice_2023_%.pdf') then
    Writeln('Matches 2023 pattern');
    
  if s.ExtractedFileExt().MatchText(['.pdf', '.docx', '.xlsx']) then
    Writeln('It is a document');
end;
```

### Double & Currency Helpers
Extended methods for `Double` and `Currency` types.
- **Math**: `Sqr`, `Sqrt`, `Abs`, `Power`, `Max`, `Min`.
- **Rounding**: `Round(precision)`, `Floor`, `Ceil`, `SimpleRoundTo`.
- **Check**: `IsNan`, `IsInfinite`, `IsZero`, `InRange(min, max)`.
- **Formatting**: `ToString(precision)`, `ToSQLString`.

```delphi
var
  d: Double;
begin
  d := 123.456;
  Writeln(d.Round(-2).ToString); // '123.46'
end;
```

### Date & DateTime Helpers
(Delphi XE3+) Extensions for `TDate` and `TDateTime`. You can now access date components as properties!

- **Properties**: `Year`, `Month`, `Day`, `Hour`, `Minute`, `Second`, `MilliSecond`.
- **Methods**: `DateOf`, `TimeOf`, `ToString(format)`, `ToSQLString`.

```delphi
var
  dt: TDateTime;
begin
  dt := Now;
  dt := dt.RecodedYear(2025)
          .RecodedMonth(12); // Immutable modification
  Writeln(dt.ToString('yyyy-mm-dd HH:NN')); 
end;
```

### Boolean Helper
Extended methods for the native `Boolean` type.
- **Logic**: `IfThen` (overloaded for string, integer, currency, etc.).
- **Conversion**: `ToInteger` (0/1), `ToSQLString` ('true'/'false'), `ToString`.

```delphi
var
  active: Boolean;
begin
  active := True;
  Writeln(active.IfThen('Yes', 'No')); // 'Yes'
end;
```

---

## Technical Note

Native Type Helpers (record helpers for primitive types) are available in **Delphi XE3** and newer. To use them, simply include the `OLTypes` unit in your `uses` clause. 

> [!IMPORTANT]
> Some advanced string features like `JSON` and `XML` properties require **Delphi XE6** or newer.

> [!WARNING]
> Record helpers for native types do NOT add `Null` support to native types. If you need `Null` handling, use the `OL` record types (e.g., `OLInteger`, `OLString`) instead.
