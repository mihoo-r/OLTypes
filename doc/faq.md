# OLTypes FAQ - Frequently Asked Questions

## Getting Started & Installation

### What is OLTypes?

OLTypes is a comprehensive Delphi library that enhances basic Delphi types with null-safety, fluent APIs, and extensive helper methods. It provides nullable types like `OLString`, `OLInteger`, `OLDateTime`, etc., that can handle null values without crashes, plus powerful extensions for standard Delphi types.

> **Key Features:** Null-safe value types, fluent validation, automatic DataBinding, JSON/XML manipulation, and more than 500 helper methods.

### How do I install OLTypes?

You have two installation options:

#### Option 1: Using Boss (Recommended)

```
boss init
boss install github.com/mihoo-r/OLTypes
```

- **boss init:** Initializes a new Boss project in your current folder, creating the `boss.json` file if it doesn't already exist.
- **boss install:** Downloads the library, adds it to `boss.json`, and automatically configures your project's search paths.

#### Option 2: Manual Installation

1. Download the library from GitHub
2. Add `source/` folder to your project's search path
3. Add `uses OLTypes;` to your unit

> **Tip:** For global availability, add the source folder to your Library Path in Tools → Options → Delphi Options → Library.

### Which Delphi versions are supported?

| Delphi Version | OLTypes | Primitive Helpers | DataBinding | OLArrays | OLDictionaries |
|---|---|---|---|---|---|
| 2010 | ✓ | ✗ | ✗ | ✗ | ✗ |
| XE | ✓ | ✗ | ✗ | ✓ | ✗ |
| XE2 | ✓ | ✗ | ✓ | ✓ | ✗ |
| XE3+ | ✓ | ✓ | ✓ | ✓ | ✗ |
| 10.4+ | ✓ | ✓ | ✓ | ✓ | ✓ |

**Tested with:** Delphi 12 Athens, Delphi XE

**Compatible with:** Delphi 11 Alexandria, Delphi 10 Seattle/Berlin/Tokyo/Sydney

### What's the difference between OLTypes and standard Delphi types?

OLTypes provide:

- **Null Safety:** Can store null values without crashes
- **Fluent API:** Method chaining like `str.Trimmed.LowerCase.Contains('test')`
- **Rich Helpers:** Over 500 methods available directly on types (including standard `string`, `Integer` etc.), compared to scattered functions in standard library units.
- **DataBinding:** Automatic UI synchronization
- **Validation:** Built-in validation rules

```pascal
// Standard Delphi
var s: string;
begin
  s := '  hello  ';
  if Assigned(s) then // Doesn't help with empty strings
    s := Trim(UpperCase(s));
end;

// OLTypes
var s: OLString;
begin
  s := '  hello  ';
  s := s.Trimmed.UpperCase; // Null-safe, fluent
end;
```

### When should I use OLTypes instead of standard Delphi types?

If you are working with a modern version of Delphi and you are certain that you will not be working with `Null` values, nor do you require `DataBinding` to connect your variables directly with UI controls, you should continue using standard Delphi types.

> **Note:** for standard Delphi types (starting from Delphi XE3 and later), simply adding `uses OLTypes;` to your unit makes most of the 500+ methods and properties available through Record Helpers. You get the fluent API and rich functionality without changing your existing type declarations.

### What is the default value of OLTypes after declaration?

One of the important advantages of OLTypes is **guaranteed initialization**. Unlike native Delphi types (such as `Integer` or `Boolean` local variables), whose initial value often depends on the stack content and may contain random "garbage" data, OLTypes are always initialized to a safe, deterministic state.

For almost all types (including `OLInteger`, `OLBoolean`, `OLDate`, etc.), the default value is **NULL**.

**Exception:** `OLString` initializes to an **empty string** (`''`) by default. This design choice safeguards compatibility with the native Delphi `string` type, which is also automatically initialized to an empty string.

### How do I migrate existing code to OLTypes?

You don't need to change your existing types! OLTypes allows for **incremental adoption**. You can freely mix different approaches depending on your needs — even within the same unit:

#### Level 1: Enhance what you already have (Zero code change)

Simply add `uses OLTypes;` to enable helper methods on standard types:

```pascal
// Your existing code stays the same
var name: string;
    age: Integer;
    price: Currency;
begin
  name := '  john doe  ';
  age := 25;
  price := 99.95;

  // Now you have helper methods available
  ShowMessage(name);              // 'JOHN DOE'
  ShowMessage(age.IsPrime.ToString); // False
  ShowMessage(price.Round(0).ToString); // 100
end;
```

#### Level 2: Use OL-types for critical logic (Advanced features)

Convert to OLTypes only where you need null-handling or advanced features:

```pascal
// Keep existing types for simple cases
var userCount: Integer;

// Use OLTypes for nullable/complex scenarios
var userName: OLString;      // Can be null, has validation
var userAge: OLInteger;      // Can be null, has range checks
var birthDate: OLDate;       // Rich date operations

begin
  userName := Null;          // Explicit null
  userName := userName.IfNull('Anonymous');

  if userAge.HasValue and userAge.Between(18, 65) then
    ShowMessage('Valid age');

  birthDate := '1990-01-01';
  ShowMessage(birthDate.YearsBetween(Today).ToString);
end;
```

> **Migration Strategy:**
> 1. Add `uses OLTypes;` for helper methods on types in existing code
> 2. Convert fields to OLTypes where null-safety provides value
> 3. Add DataBinding and validation incrementally
> 4. Replace TList/TStringList with OLArrays where appropriate

> **Seamless Transition:** Do not hesitate to update previously declared fields or variables to OLTypes (integer -> OLInteger, string -> OLString, etc.). Their compatibility with native types is close to 100%, making refactoring safe and easy.

### Do I need to change all my existing code?

No! OLTypes are designed for gradual adoption:

- Use `OLString` alongside `string`
- Implicit conversions work both ways
- Add `uses OLTypes;` to enable helpers on standard types
- Start with specific features you need

### Will OLTypes make me a better programmer?

**Absolutely!** (Well, at least a more productive and happier one).

OLTypes shifts your focus from "how to implement this loop safely" to "what this business logic should achieve".

- **Readability:** Your code becomes a clear narrative (e.g., `User.Name.Trimmed.UpperCase`) rather than a puzzle of nested functions.
- **Stability:** Automatic null handling and memory management eliminate entire classes of common bugs (like Access Violations or memory leaks).
- **Speed:** With hundreds of built-in helpers, you stop reinventing the wheel and start shipping features faster.

---

## OLString - String Operations

### How do I handle null strings safely?

OLString provides null-safe operations:

```pascal
var s: OLString;
begin
  s := Null;
  ShowMessage(s.IsNull.ToString);      // True
  ShowMessage(s.HasValue.ToString);    // False
  s := s.IfNull('default');    // Safe fallback
  ShowMessage(s);             // 'default'
end;
```

Unlike standard strings, OLString won't crash when calling methods on null values.

### How do I search and replace in strings?

OLString offers multiple search and replace methods:

```pascal
var text: OLString;
begin
  text := 'Hello World World';

  // Basic search
  ShowMessage(text.ContainsStr('World').ToString); // True
  ShowMessage(text.Pos('World').ToString);         // 7

  // Case-insensitive
  ShowMessage(text.ContainsText('world').ToString); // True

  // Replace operations
  text := text.Replaced('World', 'Universe');
  ShowMessage(text);                      // 'Hello Universe Universe'

  text := text.ReplacedFirst('Universe', 'Galaxy');
  ShowMessage(text);                      // 'Hello Galaxy Universe'
end;
```

### How do I work with substrings?

Use substring methods for text extraction:

```pascal
var s: OLString;
begin
  s := 'Hello Delphi World';

  ShowMessage(s.LeftStr(5));   // 'Hello'
  ShowMessage(s.RightStr(5));  // 'World'
  ShowMessage(s.MidStr(7, 6)); // 'Delphi'

  // Character access (1-based)
  ShowMessage(s[1]);                    // 'H'
  ShowMessage(s[s.Length]);             // 'd'
end;
```

### How can I extract text between specific patterns?

Use `FindPattern` to extract text enclosed between two strings (like HTML tags). It returns a `TStringPatternFind` record containing the found value and its position.

```pascal
function OLString.FindPattern(InFront: OLString; Behind: OLString;
    const StartingPosition: integer = 1; const CaseSensitivity:
    TCaseSensitivity = csCaseSensitive): TStringPatternFind;
```

Example: Extracting all `<h2>` headers from HTML source using a `while` loop:

```pascal
var
  html: OLString;
  Patern: TStringPatternFind;
begin
  html := '<h1>Title</h1><h2>First Header</h2><p>Text</p><h2>Second Header</h2>';

  Patern := html.FindPattern('<h2>', '</h2>');
  while Patern.Found() do
  begin
    // Output: 'First Header', then 'Second Header'
    ShowMessage('Found header: ' + Patern.Value);

    Patern := html.FindPattern('<h2>', '</h2>', Patern.Position + 1);
  end;
end;
```

> **Hint:** If you are looking for a single specific value, you can use the `FindPatternStr` method, which returns the first matching pattern or an empty string if not found:
> ```pascal
> function OLString.FindPatternStr(const InFront: OLString; const Behind:
>     OLString; const StartingPosition: integer = 1; const CaseSensitivity:
>     TCaseSensitivity = csCaseSensitive): OLString;
> ```

### How do I split and join strings?

OLString provides SplitString and various join operations:

```pascal
var s: OLString;
    parts: TArray<string>;
begin
  s := 'apple,banana,cherry';

  // Split into array
  parts := s.SplitString(',');
  ShowMessage(Length(parts).ToString);  // 3

  // Join back
  s := OLString.Join(',', parts);
  ShowMessage(s);              // 'apple,banana,cherry'

  // Work with lines
  s := 'Line 1'#13#10'Line 2'#13#10'Line 3';
  ShowMessage(s.LineCount.ToString);    // 3
  s := s.WithLineChanged(2, 'Modified Line 2');
end;
```

### How do I validate string content?

OLString includes built-in validation methods:

```pascal
var email, iban: OLString;
begin
  email := 'user@example.com';
  ShowMessage(email.Like('%@%.%').ToString);  // True

  iban := 'GB29 NWBK 6016 1331 9268 19';
  ShowMessage(iban.IsIBAN.ToString);    // True

  // Polish specific validations
  ShowMessage('12345678901'.IsPESEL.ToString); // True
  ShowMessage('1234567890'.IsNIP.ToString);    // True
end;
```

### How do I work with JSON in OLString?

Use the JSON property for path-based access:

```pascal
var json: OLString;
begin
  // Build JSON
  json := '{"user": {"name": "Alice"}}';
  json := json.WithJSON('user.name', 'John') // Overwrite existing value ('Alice' -> 'John')
              .WithJSON('user.age', 30) 
              .WithJSON('user.roles[0]', 'admin')
              .WithJSON('user.roles[1]', 'user'); 

  ShowMessage(json);
  // {"user":{"name":"John","age":30,"roles":["admin","user"]}}

  // Access values
  ShowMessage(json.JSON['user.name']);     // 'John'
  ShowMessage(json.JSON['user.roles[0]']); // 'admin'

  // Check existence
  if json.JSON['user.email'].IsNull then
    ShowMessage('Email not provided');
end;
```

### How do I work with XML in OLString?

Use XPath-like syntax for XML manipulation:

```pascal
var xml: OLString;
begin
  xml := '<config><theme>dark</theme><version>1.0</version></config>';

  xml := xml.WithXML('/config/theme/@mode', 'auto'); // Attribute

  ShowMessage(xml);
  // <config><theme mode="auto">dark</theme><language>en</language></config>
end;
```

### How do I work with CSV data?

Use the CSV property for semicolon-separated values:

```pascal
var csv: OLString;
begin
  csv := 'John;Doe;30;New York';
  
  //csv is zero based
  ShowMessage(csv.CSV[0]); // 'John'
  ShowMessage(csv.CSV[3]); // 'New York'

  // Modify fields
  csv := csv.WithCSV(2, '31');     // Update age

  // Add new field
  csv := csv.WithCSV(4, 'Engineer');

  ShowMessage(csv);        // 'John;Doe;31;New York;Engineer'
end;
```

### How do I use string templates?

Use the Params property for template substitution:

```pascal
var template, message: OLString;
begin
  template := 'Hello :name, welcome to :app!';
  template := template.WithParam('name', 'Alice')
                      .WithParam('app', 'OLTypes');

  ShowMessage(template); // 'Hello Alice, welcome to OLTypes!'

  // SQL template
  template := 'SELECT * FROM users WHERE name = :name AND age > :age';  
  template := template.WithParam('name', 'John'.ToSQLString())
                      .WithParam('age', 18.ToSQLString());

  ShowMessage(template); // 'SELECT * FROM users WHERE name = ''John'' AND age > 18'
end;
```

> **Note:** Parameter names are **case-insensitive**. Setting `template.Params['NAME']` is exactly the same as `template.Params['name']`, and it will correctly replace `:name`, `:Name`, or `:NAME` in the template string.

### How do I handle file operations with OLString?

Built-in file I/O methods:

```pascal
var content: OLString;
begin
  // Load from file
  content := OLString.FromFile('data.txt');

  // Compress and save
  content := content.Compressed;
  content.SaveToFile('data.zlib');

  // Load and decompress
  content := OLString.FromFile('data.zlib');
  content := content.Decompressed;

  // Base64 encoding
  content := OLString.Base64FromFile('image.jpg');
  content := content.DecodeBase64ToFile('decoded.jpg');
end;
```

### How do I download content from URLs?

Use GetFromUrl for web content:

```pascal
var webContent: OLString;
begin
  webContent := OLString.FromUrl('https://api.github.com/users/octocat');

  if webContent.HasValue then
  begin
    ShowMessage('Downloaded ' + webContent.Length.ToString + ' characters');

    // Parse JSON response
    ShowMessage(webContent.JSON['login']);
    ShowMessage(webContent.JSON['name']);
  end
  else
    ShowMessage('Download failed');
end;
```

### How can OLString replace TStringList?

OLString facilitates the replacement of TStringList by offering built-in methods for file operations and line manipulation. It allows you to load, modify, and save text files without the overhead of creating and freeing an auxiliary object.

```pascal
var content: OLString;
begin
  // 1. Loading content (automatic memory management, no Create/Free)
  content := OLString.FromFile('data.txt');

  // 2. Accessing and modifying lines
  ShowMessage('Lines count: ' + content.LineCount.ToString);
  content := content.WithLineChanged(0, 'First line modified')
                    .WithLineAdded('New line at the end');

  // 3. Saving content
  content.SaveToFile('updated_data.txt');
end;
```

> **Why use OLString instead of TStringList?**
> - **Automated Memory:** No need to remember `try..finally Free`.
> - **Fluent API:** Chain line operations with string transformations.
> - **Lightweight:** It's a value type (record), which is more efficient for simple tasks.

### What is the ToSQLString method used for?

The `ToSQLString()` method is designed to safely generate string representations of values for use in SQL queries. It handles quoting, null values, and type-specific formatting automatically.

- **For OLString and OLDate:** It applies `QuotedStr` to properly wrap the value in single quotes and escape any internal quotes.
- **For Numeric types (OLDouble, OLCurrency):** It ensures a SQL-compatible format, specifically converting the decimal separator to a dot (`.`) even if the system locale uses a comma.
- **For Null values:** It returns the literal string `'NULL'` (without quotes).

```pascal
var sql: OLString;
    userName: OLString;
    height: OLCurrency;
    birthDate: OLDate;
    age: OLInteger;
begin
  userName := 'O''Connor';
  height := 185.5;
  birthDate := '1980-05-20';

  // Using string templates (Params) to build a query
  sql := 'INSERT INTO users (name, height, birth_date, age) VALUES (:name, :height, :date, :age)';
  
  // ToSQLString handles all formatting
  sql := sql.WithParam('name', userName.ToSQLString)   // Result: 'O''Connor'
            .WithParam('height', height.ToSQLString)   // Result: 185.5 
            .WithParam('date', birthDate.ToSQLString); // Result: '1980-05-20'
  
  // Handling Nulls
  sql := sql.WithParam('age', age.ToSQLString);   // Result: NULL (literal) - we didn't set any value

  // sql now contains:
  // INSERT INTO users (...) VALUES ('O''Connor', 185.5, '1980-05-20', NULL)
  ShowMessage(sql);
end;
```

### How do I use OLString with system APIs that require a PWideChar (e.g., Application.MessageBox)?

Some Windows and Delphi system APIs require a `PWideChar` pointer. You can use the `ToPWideChar()` method for this purpose. It is especially powerful when combined with `Params` to build dynamic messages.

```pascal
var MyMessage: OLString;
begin
  MyMessage := 'User :name has :count new messages. Do you want to read them?';
  
  MyMessage := MyMessage.WithParam('name', 'John')
                        .WithParam('count', 5);

  Application.MessageBox(MyMessage.ToPWideChar(), 
                        'System Notification', MB_YESNO + MB_ICONQUESTION);
end;
```

### How to use regular expressions with OLString?

OLString provides two methods for working with regular expressions: `Matches` for validation (checking if a string matches a pattern) and `MatchCollection` for extracting all occurrences of a pattern from the string.

#### Validation with Matches

The `Matches` method returns an `OLBoolean` indicating whether the string matches the given regular expression pattern.

```pascal
var
  email, phone, zipCode: OLString;
begin
  // Validate an email address
  email := 'user@example.com';
  ShowMessage(email.Matches('^\w+@\w+\.\w+$').ToString);  // True

  email := 'invalid-email';
  ShowMessage(email.Matches('^\w+@\w+\.\w+$').ToString);  // False

  // Validate a phone number (e.g. +48 123-456-789)
  phone := '+48 123-456-789';
  ShowMessage(phone.Matches('^\+\d{1,3}\s\d{3}-\d{3}-\d{3}$').ToString);  // True

  // Validate a Polish zip code (XX-XXX)
  zipCode := '00-001';
  ShowMessage(zipCode.Matches('^\d{2}-\d{3}$').ToString);  // True
end;
```

#### Extracting matches with MatchCollection

The `MatchCollection` method returns a `TMatchCollection` containing all occurrences of the pattern found in the string. You can iterate over them and access the `Value`, `Index`, and `Length` of each match.

```pascal
var
  text: OLString;
  Collection: TMatchCollection;
  i: Integer;
begin
  text := 'Order 1234 shipped on 2025-01-15, Order 5678 shipped on 2025-02-20';

  // Extract all order numbers (sequences of 4 digits)
  Collection := text.MatchCollection('\b\d{4}\b');
  for i := 0 to Collection.Count - 1 do
    ShowMessage('Order number: ' + Collection.Item[i].Value);
  // Output: 'Order number: 1234', 'Order number: 5678'

  // Extract all dates (YYYY-MM-DD)
  Collection := text.MatchCollection('\d{4}-\d{2}-\d{2}');
  for i := 0 to Collection.Count - 1 do
    ShowMessage('Date: ' + Collection.Item[i].Value);
  // Output: 'Date: 2025-01-15', 'Date: 2025-02-20'
end;
```

> **Tip:** If you find writing regex patterns difficult, use `TOLRegEx` — a fluent regex builder that lets you construct patterns step-by-step using readable method names instead of cryptic symbols. The result can be passed directly to `Matches` and `MatchCollection`:
> ```pascal
> var
>   text: OLString;
>   regex: TOLRegEx;
> begin
>   text := 'Call us at 123-456-789 or 987-654-321';
> 
>   // Build a phone pattern: three groups of digits separated by dashes
>   regex := OLRegEx.Digit.Exactly(3)
>                        .Literal('-')
>                        .Digit.Exactly(3)
>                        .Literal('-')
>                        .Digit.Exactly(3);
> 
>   // Use the built pattern with OLString methods
>   ShowMessage(text.Matches(regex).ToString);  // True (text contains the pattern)
> 
>   Collection := text.MatchCollection(regex);
>   // Collection.Count = 2: '123-456-789', '987-654-321'
> end;
> ```

---

## OLInteger - Integer Operations

### How do I check number properties?

OLInteger provides mathematical predicates:

```pascal
var num: OLInteger;
begin
  num := 17;

  ShowMessage(num.IsPrime.ToString);        // True
  ShowMessage(num.IsEven.ToString);         // False
  ShowMessage(num.IsOdd.ToString);          // True
  ShowMessage(num.IsPositive.ToString);     // True
  ShowMessage(num.IsDividableBy(3).ToString); // False

  num := -5;
  ShowMessage(num.IsNegative.ToString);     // True
  ShowMessage(num.IsNonNegative.ToString);  // False
end;
```

### How do I perform mathematical operations?

Rich set of mathematical methods:

```pascal
var x, y: OLInteger;
begin
  x := 5;
  y := 3;

  ShowMessage(x.Sqr.ToString);              // 25
  ShowMessage(x.Power(3).ToString);         // 125
  ShowMessage(x.Max(y).ToString);          // 5
  ShowMessage(x.Min(y).ToString);          // 3
  ShowMessage(x.Abs.ToString);             // 5 (absolute value)

  x := -7;
  ShowMessage(x.Abs.ToString);             // 7

  x := 127;
  ShowMessage(x.Round(1).ToString);        // 130 (round to tens)
  ShowMessage(x.Round(2).ToString);        // 100 (round to hundreds)
end;
```

### How do I work with different number systems?

Built-in conversion between number systems:

```pascal
var num: OLInteger;
begin
  num := 42;

  ShowMessage(num.Binary.ToString);         // '101010'
  ShowMessage(num.Octal.ToString);          // '52'
  ShowMessage(num.Hexidecimal.ToString);    // '2A'
  ShowMessage(num.NumeralSystem32.ToString); // '1A'
  ShowMessage(num.NumeralSystem64.ToString); // 'q'

  // Set from different bases
  num := OLInteger.FromBinary('11111111');
  ShowMessage(num.ToString);                // 255

  num := OLInteger.FromHexidecimal('FF');
  ShowMessage(num.ToString);                // 255

  num := OLInteger.FromOctal('377');
  ShowMessage(num.ToString);                // 255
end;
```

### How do I generate random numbers?

Static and instance random methods:

```pascal
var randNum: OLInteger;
begin
  // Random in range
  randNum := OLInteger.Random(1, 100);
  ShowMessage('Random: ' + randNum.ToString);

  // Random prime
  randNum := OLInteger.RandomPrime(1000000, 5000000);
  ShowMessage('Prime: ' + randNum.ToString);
end;
```

### How do I handle ranges and bounds?

Range checking and manipulation:

```pascal
var value: OLInteger;
begin
  value := 15;

  ShowMessage(value.Between(10, 20).ToString);    // True
  ShowMessage(value.Between(20, 30).ToString);    // False

  // Increment/decrement
  value := value.Increased(5);       // 20
  value := value.Decreased(3);       // 17

  // Replace values
  value := 10;
  value := value.Replaced(10, 100).ToString;  // 100
end;
```

---

## OLDate & OLDateTime - Date Operations

### How do I create and manipulate dates?

OLDate provides extensive date operations:

```pascal
var today, birthday: OLDate;
begin
  // Static function
  today := OLDate.Today;
  ShowMessage('Today: ' + today.ToString);

  birthday := OLDate.Yesterday;
  ShowMessage('Yesterday: ' + birthday.ToString);

  // From string (ISO format)
  birthday := '1990-05-15';
  ShowMessage('Birthday: ' + birthday.ToString);

  // Date arithmetic
  birthday := birthday.IncYear(30);
  ShowMessage('30 years later: ' + birthday.ToString);

  birthday := birthday.IncMonth(-5);
  ShowMessage('5 months earlier: ' + birthday.ToString);
end;
```

### How do I work with date components?

Access and modify individual components:

```pascal
var date: OLDate;
begin
  date := '2023-12-25';

  ShowMessage('Year: ' + date.Year.ToString);
  ShowMessage('Month: ' + date.Month.ToString);
  ShowMessage('Day: ' + date.Day.ToString);

  // Modify components
  date := date.WithYear(2024);
  date := date.WithMonth(1);
  date := date.WithDay(1);

  ShowMessage('New Year: ' + date.ToString);

  // Check properties
  ShowMessage('Is leap year: ' + date.IsInLeapYear.ToString);
  ShowMessage('Days in month: ' + date.DaysInMonth.ToString);
  ShowMessage('Day of week: ' + date.DayOfTheWeek.ToString);
end;
```

### How do I work with date ranges and periods?

Date range operations and calculations:

```pascal
var startDate, endDate: OLDate;
begin
  startDate := '2023-01-01';
  endDate := '2023-12-31';

  ShowMessage('Days between: ' + startDate.DaysBetween(endDate).ToString);
  ShowMessage('Months between: ' + startDate.MonthsBetween(endDate).ToString);
  ShowMessage('Years between: ' + startDate.YearsBetween(endDate).ToString);

  // Check if in range
  ShowMessage(startDate.InRange('2022-12-31', '2023-01-02').ToString); // True

  // Start/end of periods
  ShowMessage('Start of year: ' + startDate.StartOfTheYear.ToString);
  ShowMessage('End of year: ' + startDate.EndOfTheYear.ToString);
  ShowMessage('Start of month: ' + startDate.StartOfTheMonth.ToString);
  ShowMessage('End of month: ' + startDate.EndOfTheMonth.ToString);
end;
```

### What is the difference between DaysBetween, DaysFrom, and DaysTo?

These methods calculate the difference between two dates but handle the sign of the result differently:

- **`DaysBetween(Date)`**: Returns the **absolute** number of full days. The result is always non-negative (e.g., the difference between today and tomorrow is 1, and between tomorrow and today is also 1).
- **`DaysFrom(Date)`**: Returns the **signed** number of days from the provided date to the current object (`Self - Date`). If the current object is later (ahead in time), the result is positive.
- **`DaysTo(Date)`**: Returns the **signed** number of days from the current object to the provided date (`Date - Self`). If the parameter is later (in the future relative to `Self`), the result is positive.

```pascal
var d1, d2: OLDate;
begin
  d1 := '2023-01-01';
  d2 := '2023-01-10';

  ShowMessage(d1.DaysBetween(d2).ToString); // 9 (absolute)
  ShowMessage(d1.DaysFrom(d2).ToString);    // -9 (d1 is 9 days BEFORE d2)
  ShowMessage(d1.DaysTo(d2).ToString);      // 9 (d2 is 9 days AFTER d1)
end;
```

> **Logic Consistency:** This same "Between vs From vs To" logic applies to all other time component triples in `OLDate` and `OLDateTime`, such as: `Years...`, `Months...`, `Weeks...`, `Hours...`, `Minutes...`, `Seconds...`, and `MilliSeconds...`.

### How do I work with OLDateTime?

OLDateTime extends OLDate with time components:

```pascal
var dt: OLDateTime;
begin
  dt := OLDateTime.Now;
  ShowMessage('Now: ' + dt.ToString);

  // Access time components
  ShowMessage('Hour: ' + dt.Hour.ToString);
  ShowMessage('Minute: ' + dt.Minute.ToString);
  ShowMessage('Second: ' + dt.Second.ToString);

  // Time checks
  ShowMessage('Is AM: ' + dt.IsAM.ToString);
  ShowMessage('Is PM: ' + dt.IsPM.ToString);

  // Time arithmetic
  dt := dt.IncHour(2);
  dt := dt.IncMinute(30);

  ShowMessage('2.5 hours later: ' + dt.ToString);

  // Time spans
  ShowMessage('Hours between: ' + dt.HoursBetween(OLDateTime.Now).ToString);
end;
```

### How do I format dates for display?

Built-in formatting methods:

```pascal
var date: OLDate;
begin
  date := '2023-07-15';

  // Default formatting
  ShowMessage(date.ToString);                    // '2023-07-15'

  // Custom format
  ShowMessage(date.ToString('yyyy-mm-dd'));     // '2023-07-15'
  ShowMessage(date.ToString('dd/mm/yyyy'));     // '15/07/2023'
  ShowMessage(date.ToString('mmmm dd, yyyy'));  // 'July 15, 2023'

  // SQL format
  ShowMessage(date.ToSQLString);                // '2023-07-15'

  // Long/short names
  ShowMessage(date.LongMonthName);              // 'July'
  ShowMessage(date.ShortMonthName);             // 'Jul'
  ShowMessage(date.LongDayName);                // 'Saturday'
end;
```

---

## Null Safety & Error Handling

### What happens when I try to convert null OLTypes to native types?

Converting null OLTypes to native types raises exceptions:

```pascal
var olStr: OLString;
    nativeStr: string;
begin
  olStr := Null;

  try
    nativeStr := olStr;  // Exception: 'OLString is null'
  except
    on E: Exception do
      ShowMessage('Error: ' + E.Message);
  end;

  // Safe conversion
  nativeStr := olStr.AsString('default');
  ShowMessage(nativeStr);   // 'default'
end;
```

> ⚠️ Always check `HasValue` or use safe conversion methods before implicit casting to native types.

### How do I safely handle null values in method chains?

Method chaining is null-safe - null propagates through the chain:

```pascal
var userInput: OLString;
    result: OLString;
begin
  userInput := Null;

  // This won't crash - null propagates
  result := userInput.Trimmed.UpperCased.LeftStr(10);

  ShowMessage(result.IsNull.ToString);     // True
  ShowMessage(result.HasValue.ToString);   // False

  // Safe with fallback
  result := userInput.IfNull('default').Trimmed.UpperCased;
  ShowMessage(result);            // 'DEFAULT'
end;
```

### What does the ToString method return when an OL type variable is Null?

For all OLTypes, the `ToString()` method returns an **empty string (`''`)** if the variable is `Null`. This is a safety feature that prevents exceptions and allows you to safely use `ToString` in UI displays or string concatenations.

> **Tip:** If you need a string representation specifically for database queries, use `ToSQLString()`. It returns the literal string `'NULL'` when the value is missing, and a formatted value otherwise.

### Besides database values, what else can I use Null for in program code?

OLTypes allow you to use `Null` as a first-class state in your application logic, solving several common architectural challenges:

#### 1. Differentiating "Cancel" from "Empty Input"

Standard Delphi `InputBox` returns an empty string both when the user clicks **Cancel** and when they click **OK** with no text. With OLString, you could return `Null` for Cancel and `''` for OK:

```pascal
function GetUserName: OLString;
begin   
  if MyInputBox.ShowModal = mrOK then
    Result := MyInputBox.EditValue  // Could be ''
  else
    Result := Null;      // Explicitly cancelled
end;

// Usage
name := GetUserName;
if name.IsNull then
  ShowMessage('Action cancelled')
else
  ShowMessage('Hello ' + name.IfNullOrEmpty('Stranger'));
```

#### 2. Lazy Initialization

```pascal
property ReportSummary: OLString read GetReportSummary;

function TReport.GetReportSummary: OLString;
begin
  if FSummary.IsNull then
    FSummary := HeavyComputation(); // Only runs once and only if needed
  Result := FSummary;
end;
```

#### 3. System Defaults vs. User Override

```pascal
var userFontSize: OLInteger;
begin
  fontSize := userFontSize.IfNull(SYSTEM_DEFAULT_FONT_SIZE); // Null = System Default (e.g. 12pt)
end;
```

#### 4. Checking JSON Field Existence

```pascal
var json: OLString;
begin
  json := '{"user":{"name":"John","age":30,"roles":["admin","user"]}}';

  if json.JSON['user.email'].IsNull then
    ShowMessage('Email not provided');
end;
```

### Do I now have to check for both Null and empty string separately?

No, you don't have to write double checks like `if s.IsNull or (s = '') then...`. OLString provides specialized methods:

- **`IsNullOrEmpty`**: Returns `True` if the string is either `Null` or contains an empty string (`''`).
- **`NotNullNorEmpty`**: Returns `True` only if the string has a value **and** that value is not empty.

```pascal
var s: OLString;
begin
  if s.IsNullOrEmpty then
    ShowMessage('Value is missing or empty');

  if s.NotNullNorEmpty then
    ShowMessage('We have valid data: ' + s);
end;
```

> **Tip:** Using `NotNullNorEmpty` makes your code much cleaner and less prone to "forgotten null check" bugs compared to native Delphi strings.

### What are the best practices for null handling?

> **Best Practices:**
> 1. Use `IfNull()` for safe defaults
> 2. Check `HasValue()` before native conversions
> 3. Use `AsString()`, `AsInteger()` etc. for safe casting
> 4. Method chaining is inherently null-safe

```pascal
var name: OLString;
    age: OLInteger;
begin
  name := Null;
  age := Null;

  ShowMessage('Name: ' + name.IfNull('Unknown'));
  ShowMessage('Age: ' + age.AsInteger(0).ToString);

  if name.HasValue then
    ProcessName(name)
  else
    ShowMessage('Name not provided');
end;
```

### What is the difference between OLInteger.AsInteger, OLInteger.IfNull and OLInteger.ToString?

1. **`IfNull(DefaultValue)`**: Returns an `OLInteger`. Used for **fluent chaining**. If null, returns the provided `OLInteger` default.
2. **`AsInteger(NullReplacement)`**: Returns a native Delphi **`Integer`**. Used as an **exit point** from the OLType to the native world.
3. **`ToString()`**: Returns a **`string`**. If null, returns an **empty string (`''`)**. Used for UI display or string concatenations.

> **Note:** This same triplet of methods (`As...`, `IfNull`, and `ToString`) exists for all other OL core types, providing a consistent way to handle nulls across the entire library.

---

## DataBinding & Validation

### What is DataBinding?

DataBinding is a mechanism that **synchronizes data automatically** between your code (OLTypes variables) and the User Interface (VCL/FMX controls).

- **Bi-directional:** When a user types in an `Edit`, the `OLString` variable is updated. If you change the `OLString` value in your code, the `Edit` content updates immediately.
- **Automatic:** No more `try..finally` blocks for manual UI updates or validation checks.
- **Validation:** DataBinding integrates with a validation engine that can visually signal errors.

### How do I bind OLTypes to UI controls?

Use the `Link()` method for automatic synchronization:

```pascal
procedure TForm1.FormCreate(Sender: TObject);
begin
  EditName.Link(FUserName);
  SpinAge.Link(FUserAge);
  // Changes in UI update fields automatically
  // Changes in fields update UI automatically
end;
```

> **Tip:** DataBinding works only with controls on the same form.

### Which controls support DataBinding?

| Control Type | Supported OLTypes | Description |
|---|---|---|
| TEdit, TMemo | OLString, OLInteger, OLDouble, OLCurrency | Text input controls |
| TSpinEdit | OLInteger | Numeric spinner |
| TCheckBox | OLBoolean | Boolean checkbox |
| TDateTimePicker | OLDate, OLDateTime | Date/time picker |
| TLabel | All types | Display only (one-way) |
| TTrackBar, TScrollBar | OLInteger | Range controls |

### If I link an OLInteger to a TEdit, can I enter any text?

No. When you link numeric types like `OLInteger` or `OLCurrency` to a `TEdit`, OLTypes automatically restricts input at the keyboard level. Only characters that form a valid number are permitted.

> **Tip:** This input filtering is a built-in mechanism of DataBinding and is **independent** of the validation engine.

### How do I add validation to bound controls?

Chain validation rules after `Link()`:

```pascal
procedure TForm1.FormCreate(Sender: TObject);
begin
  EditEmail.Link(FUserEmail)
    .RequireValue
    .Email('Please enter a valid email address');

  EditAge.Link(FUserAge)
    .RequireValue
    .Min(18, 'Must be at least 18 years old')
    .Max(120, 'Age seems unrealistic');

  EditSalary.Link(FUserSalary)
    .Positive('Salary must be positive')
    .Max(1000000, 'Salary too high');
end;
```

### What validation rules are available?

#### For OLString:

- `RequireValue` - Cannot be null or empty
- `MinLength(n)`, `MaxLength(n)` - String length
- `Email`, `URL`, `IBAN`, `CreditCard` - Format validation
- `PESEL`, `NIP` - Polish ID validation
- `AlphaNumeric`, `DigitsOnly` - Character restrictions

#### For OLInteger/OLDouble/OLCurrency:

- `RequireValue` - Cannot be null
- `Min(value)`, `Max(value)` - Range validation
- `Positive`, `Negative` - Sign validation
- `Between(min, max)` - Inclusive range

#### For OLDate/OLDateTime:

- `RequireValue` - Cannot be null
- `Min(date)`, `Max(date)` - Date range
- `Past`, `Future` - Relative to now
- `MinAge(years)`, `MaxAge(years)` - Age validation

### How do I create custom validation rules?

```pascal
EditCode.Link(FProductCode)
  .AddValidator(
    function(Value: OLString): TOLValidationResult
    begin
      if Value.StartsWith('P') and (Value.Length = 8) then
        Result := TOLValidationResult.Ok
      else
        Result := TOLValidationResult.Error('Code must start with P and be 8 characters');
    end
  );
```

### How do I validate the entire form?

```pascal
procedure TForm1.SaveData;
begin
  if Self.IsValid then
  begin
    ShowMessage('Data saved successfully');
  end
  else
  begin
    Self.ShowValidationState;
    ShowMessage('Please correct the errors and try again');
  end;
end;
```

### How do I customize validation error display?

Validation automatically shows visual feedback:

- **Background Color:** Control turns yellow/red on error
- **Balloon Hint:** Hover shows error message
- **Custom Colors:** Pass color parameters to validation methods

```pascal
EditName.Link(FUserName)
  .RequireValue(clYellow, 'Name is required')
  .MinLength(2, clRed, 'Name too short');
```

---

## Advanced Features

### How to use TOLRegEx to build regular expressions?

`TOLRegEx` is a fluent regex builder that lets you construct regular expressions step-by-step using readable method names. To start building, call the `OLRegEx` function — it creates a new, empty `TOLRegEx` instance that you chain methods on.

#### Anchors

Anchors match a position in the text, not an actual character:

| Method | Pattern | Matches |
|---|---|---|
| `StartOfLine` | `^` | Start of a line |
| `EndOfLine` | `$` | End of a line |
| `StartOfText` | `\A` | Absolute start of text (ignores multiline mode) |
| `EndOfText` | `\z` | Absolute end of text (ignores multiline mode) |
| `WordBoundary` | `\b` | Position between a word and non-word character |
| `NonWordBoundary` | `\B` | Position that is not a word boundary |

#### Terminals

Terminals are the basic building blocks — each one matches a specific character:

| Method | Pattern | Matches |
|---|---|---|
| `Literal('text')` | escaped text | Exact literal string (special characters are auto-escaped) |
| `Digit` | `\d` | A single digit (0-9) |
| `NonDigit` | `\D` | Any character that is not a digit |
| `Alphanumeric` | `\w` | Letter, digit, or underscore |
| `NonAlphanumeric` | `\W` | Any non-alphanumeric character |
| `Whitespace` | `\s` | Space, tab, newline, etc. |
| `NonWhitespace` | `\S` | Any non-whitespace character |
| `AnyChar` | `.` | Any single character (except newline) |
| `Letter` | `\p{L}` | Any Unicode letter |
| `Punctuation` | `\p{P}` | Any Unicode punctuation character |
| `HexDigit` | `[0-9a-fA-F]` | A hexadecimal digit |
| `Tab` | `\t` | A tab character |
| `LineBreak` | `\R` | Any line break (CR, LF, CRLF, Unicode separators) |

#### Quantifiers

Quantifiers control how many times the preceding terminal repeats. Each comes in three variants: **Greedy** (match as much as possible), **Lazy** (match as little as possible), and **Possessive** (match as much as possible, no backtracking).

| Greedy | Lazy | Possessive | Description |
|---|---|---|---|
| `Exactly(N)` | — | `ExactlyPossessive(N)` | Exactly N times |
| `Between(Min, Max)` | `BetweenLazy(Min, Max)` | `BetweenPossessive(Min, Max)` | Between Min and Max times |
| `AtLeast(Min)` | `AtLeastLazy(Min)` | `AtLeastPossessive(Min)` | At least Min times (no upper limit) |
| `Optional` | `OptionalLazy` | `OptionalPossessive` | Zero or one time |
| `OneOrMore` | `OneOrMoreLazy` | `OneOrMorePossessive` | One or more times |
| `ZeroOrMore` | `ZeroOrMoreLazy` | `ZeroOrMorePossessive` | Zero or more times |

#### Example: Building a date pattern (YYYY-MM-DD)

```pascal
var
  regex: TOLRegEx;
  text: OLString;
begin
  regex := OLRegEx.Digit.Exactly(4)       // year:  4 digits
                  .Literal('-')            // separator
                  .Digit.Exactly(2)        // month: 2 digits
                  .Literal('-')            // separator
                  .Digit.Exactly(2);       // day:   2 digits

  // Generated pattern: \d{4}-\d{2}-\d{2}

  text := 'Deadline: 2025-12-31, Start: 2025-01-01';
  ShowMessage(text.Matches(regex).ToString);  // True
  ShowMessage(regex.Pattern);      // \d{4}-\d{2}-\d{2}
  ShowMessage(regex.Explanation);  // a digit (exactly 4 times), then literal "-", ...
end;
```

### How do I use OLArrays for collections?

OLArrays provide type-safe dynamic arrays with automatic memory management:

> **Note:** OLArrays use automatic memory management - no need to create or free them manually.

```pascal
var names: OLStringArray;
    numbers: OLIntegerArray;
begin
  names := ['Alice', 'Bob', 'Charlie'];

  ShowMessage(names.Length.ToString);        // 3
  ShowMessage(names.Contains('Bob').ToString); // True

  names.Add('David');
  names.Insert(1, 'Eve');
  ShowMessage(names.Join(', '));    // 'Alice,Eve,Bob,Charlie,David'

  names.Sort;
  ShowMessage(names.Join(', '));    // 'Alice,Bob,Charlie,David,Eve'

  numbers := [1, 5, 3, 9, 2];
  numbers.Sort;
  ShowMessage(numbers.Sum.ToString);         // 20
  ShowMessage(numbers.Average.ToString);     // 4
end;
```

### Do OLArrays and OLDictionaries require manual memory management?

No! They use automatic memory management.

```pascal
// OLArrays
var names: OLStringArray;
begin
  names := ['Alice', 'Bob'];
  names.Add('Charlie');
  ShowMessage(names.Join(', '));      // 'Alice,Bob,Charlie'
end; // Memory freed automatically

// OLDictionaries
var config: OLStrStrDictionary;
begin
  config['theme'] := 'dark';
  config['version'] := '1.0';
  ShowMessage(config['theme']);        // 'dark'
end; // Memory freed automatically
```

> ⚠️ **Important Exception:** If you store **Objects** (TObject descendants), you MUST free those objects manually. The collection only manages its own memory.

### How do I use OLDictionaries for key-value storage?

```pascal
var settings: OLStrStrDictionary;
begin
  settings['theme'] := 'dark';
  settings['language'] := 'en';
  settings['font-size'] := '14';

  ShowMessage(settings['theme']);   // 'dark'
  ShowMessage(settings.ContainsKey('language').ToString); // True

  // Iterate using for..in
  var Pair: TPair<string, OLString>;
  for Pair in settings do
    ShowMessage(Pair.Key + ': ' + Pair.Value);
end;
```

### What predefined OLDictionary types are available?

| Type Name | Key Type | Value Type | Common Use Case |
|---|---|---|---|
| `OLStrStrDictionary` | string | string | Configuration, Localization, simple Key-Value pairs |
| `OLStrIntDictionary` | string | Integer | Code to ID mapping, status counts |
| `OLStrCurrDictionary` | string | Currency | Sum grouping by code (e.g. Sales by Category) |
| `OLIntCurrDictionary` | Integer | Currency | Sum grouping by ID (e.g. Incomes by Department) |
| `OLIntStrDictionary` | Integer | string | ID to label mapping (ID -> Name) |
| `OLIntIntDictionary` | Integer | Integer | Sparse arrays, Graph edges, ID remapping |
| `OLIntBooleanDictionary` | Integer | Boolean | Flags mapping (is n-th item enabled) |
| `OLIntDateDictionary` | Integer | TDateTime | Timestamps mapping (max date for a given ID) |

### How can I create a custom OLDictionary for my own types?

```pascal
type
  TUserScoreDict = OLGenericDictionary<string, Double>;
  TProductLookup = OLGenericDictionary<Integer, TProductRecord>;

var scores: TUserScoreDict;
begin
  scores['Alice'] := 95.5;
  scores['Bob'] := 82.0;
  
  if scores.ContainsKey('Alice') then
    ShowMessage('Alice score: ' + scores['Alice'].ToString);
end;
```

### How do I use primitive type helpers?

Standard types get helper methods when OLTypes is included:

```pascal
uses OLTypes;

var s: string;
    i: Integer;
    d: Double;
    b: Boolean;
begin
  s := '  hello world  ';
  s := s.Trimmed.UpperCase;              // 'HELLO WORLD'

  i := 17;
  ShowMessage(i.IsPrime.ToString);    // True
  ShowMessage(i.ToHexString);         // '$11'

  d := 3.14159;
  ShowMessage(d.Round(2).ToString);   // 3.14

  b := True;
  ShowMessage(b.ToString);            // 'True'
  ShowMessage(b.IfThen('Yes', 'No')); // 'Yes'
end;
```

### Delphi already has built-in helpers for Integer and String. Does OLTypes shadow them?

Yes, since Delphi allows only one active record helper for a type at a time, OLTypes replaces the native helpers. However, **all original methods** from the native Embarcadero helpers are preserved and safely called from within the OLTypes implementation. You don't lose any standard functionality.

### How do I use OLThreadRunner for threading?

```pascal
procedure TForm1.RunBackgroundTask;
begin
  OLThreadRunner.Run(
    procedure
    begin
      Sleep(5000);
      WriteLn('Task completed');
    end,
    procedure
    begin
      ShowMessage('Background task finished!');
    end
  );
end;
```

### How do I work with Windows Registry?

Use `TOLRegistry` for simplified registry operations. It automatically manages a registry key based on the application's executable name.

```pascal
uses OLRegistry;

begin
  TOLRegistry.Settings['Theme'] := 'Dark';
  TOLRegistry.Settings['LastUser'] := 'John';
  ShowMessage('Theme: ' + TOLRegistry.Settings['Theme']);
  TOLRegistry.ClearSettings;
end;
```

> **Note:** `TOLRegistry` uses a static interface. All settings are stored under `HKEY_CURRENT_USER` in a key named after your EXE.

---

## Best Practices

### Is OLTypes slower than native types?

OLTypes have minimal performance overhead:

- **Memory:** ~8-16 bytes more per instance (for null tracking)
- **CPU:** Method calls are inlined where possible
- **Conversion:** Implicit conversions are optimized
- **Chaining:** No intermediate allocations in method chains

> **Tip:** For performance-critical code, use native types. For application logic with safety requirements, use OLTypes.

### When should I use OLTypes vs native types?

> **Use OLTypes when:**
> - Null safety is important
> - DataBinding is required
> - Rich validation is needed
> - Complex string/date operations
>
> **Use native types when:**
> - Performance is critical
> - Memory usage is constrained

### What are the good practices for working with OLTypes?

> **Coding Style:**
> - **Assign Fluent Results:** Methods like `Trimmed`, `UpperCase`, or `AddDays` return a **new value** and do not modify the variable in-place.
>   `s := s.UpperCase; // Correct`
>   `s.UpperCase;      // Wrong (result is lost)`
> - **Use `IfNull` for Defaults:** Prefer `IfNull('default')` over verbose `if IsNull` checks for cleaner code.
>   `ShowMessage(UserName.IfNull('Anonymous').ToString);`
> - **Leverage Null Propagation:** You don't need to check for nulls at every step. Let nulls propagate through the chain and handle them once at the end.
>   `val := input.Trimmed.UpperCase.LeftStr(10).IfNull('NONE');`
> - **Use `OLString` for Text Processing:** For simple file/text operations, prefer `OLString` over `TStringList`. It manages memory automatically and supports chaining.
>   `str.LineAdded(LogItem).SaveToFile('Log.txt');`
> - **Prefer Explicit Conversion:** Use properties like `AsString`, `AsInteger` etc. instead of implicit conversion when possible to improve readability.

### How do I optimize OLTypes usage?

> **Performance Tips:**
> 1. **Pass as const:** When passing `OLString` to procedures/functions, use `const` parameters to avoid copying the internal Delphi `string` (e.g., `procedure Process(const s: OLString);`). For other OLTypes (like `OLInteger`, `OLDate`) this is optional — they are small records with no reference-counted fields.
> 2. Avoid unnecessary method chaining in tight loops
> 3. Use `HasValue` checks before complex operations
> 4. Consider native types for math-heavy computations

### How do I handle memory management?

Not much to worry about with OLTypes! Most things are handled automatically:

- **Value Types (OLString, OLInteger, etc.):** Being records, they have zero overhead and are cleaned up by the compiler when they go out of scope.
- **Collections (OLArrays, OLDictionaries):**
  - **OLArrays** wrap a standard `TArray<T>` with copy-on-write semantics. Assigning one OLArray to another initially shares the internal array, but any mutation triggers a deep copy, so they behave as independent value types.
  - **OLDictionaries** use record operators to manage their internal storage automatically.
    ⚠️ **Warning:** If you store **Objects** (TObject descendants) as values, you MUST free them manually!
- **DataBindings:** Automatically managed and destroyed when the owner form or control is freed.

### What are common pitfalls to avoid?

> ⚠️ **Things to remember:**
> 1. **Check `HasValue` before native conversion:**
>    ```pascal
>    var val: OLInteger; i: Integer;
>    if val.HasValue then i := val;
>    ```
> 2. **Unit Order Matters:** Ensure `OLTypes` appears **after** `SysUtils` in your `uses` clause. This is essential for accessing extended methods on standard built-in types.
>    ```pascal
>    uses
>      SysUtils, // System helpers
>      OLTypes;  // OLTypes helpers (must be last)
>    ```
> 3. **Use `.ToString` for Writeln:** Explicitly convert OLTypes to string for console output.
>    ```pascal
>    writeln(s.ToString);
>    ```
> 4. **Use standard `Integer` for loops:** Loop variables must be ordinal types, so use native `Integer`.
>    ```pascal
>    for i := 0 to 10 do ... // i: Integer. OLInteger is not ordinal and is not allowed in loops.
>    ```
> 5. **Do not use OLTypes as `var` parameters where standard types are expected:**
>    ```pascal
>    procedure DoubleIt(var idx: Integer);
>    begin
>      idx := idx * 2;
>    end;
>    
>    var i: OLInteger; j: Integer;
>    DoubleIt(i);           // Does not compile
>    DoubleIt(i.AsInteger); // Does not compile either
>    DoubleIt(j);           // Works fine for regular Integer
>    ```
> 6. **Cast to `Integer` for array indexing:**
>    ```pascal
>    var idx: OLInteger;
>    arr[idx] := 'value';           // Does not compile
>    arr[idx.AsInteger] := 'value';
>    ```
> 7. **OLString 1-based indexing:** `OLString` follows Delphi's standard 1-based string indexing.
>    ```pascal
>    c := str[0]; // Range check error at runtime
>    c := str[1]; // First character
>    ```
> 8. **Assignments create deep copies:** Assigning collections (OLArrays/OLDictionaries) copies the entire data.
>    ```pascal
>    listB := listA;      // listB is a separate copy
>    listB.Add('new');    // listB has one more element than listA now
>    ```
> 9. **Handle nulls in method chains:** Nulls propagate through chains; use `IfNull` to ensure a value.
>    ```pascal
>    MyString := s.UpperCase.LeftStr(5);                    // Be ready that MyString can be null
>    MyString := s.UpperCase.LeftStr(5).IfNull('default');  // Or use IfNull to ensure a value
>    ```
> 10. **OLDictionary does not manage object lifecycle:** Objects stored inside the dictionary must be freed manually, typically in the owner's destructor.
>     ```pascal
>     type
>       TOrderManager = class
>       private
>         FOrders: OLGenericDictionary<Integer, TOrder>;
>       public
>         destructor Destroy; override;
>       end;
>     
>     destructor TOrderManager.Destroy;
>     var Pair: TPair<Integer, TOrder>;
>     begin
>       for Pair in FOrders do
>         Pair.Value.Free;
>       inherited;
>     end;
>     ```
> 11. **OLDate/OLDateTime must be initialized before using WithYear/Month/Day:** Calling methods like `WithYear` on a `NULL` date will return `NULL`.
>     ```pascal
>     var d: OLDate;
>     begin
>       d := Null;
>       d := d.WithYear(2024); // Result: still Null
>       
>       d := OLDate.Today;
>       d := d.WithYear(2024); // Result: today's date in 2024
>     end;
>     ```
> 12. **Date transition risks:** Changing only the Year or Month component can result in an invalid date.
>     ```pascal
>     var d: OLDate;
>     begin
>       d := '2023-05-31';
>       d := d.WithMonth(4); // EXCEPTION! April 31st does not exist.
>       
>       // Safe way:
>       d := d.IncMonth(-1); // April 30th (safe calculation)
>     end;
>     ```
> 13. **Properties return values, not references:** Modifying a sub-property in a chain will not affect the original variable.
>     ```pascal
>     var s, row: OLString;
>     begin
>       s := s.WithLineAdded('apple;banana;cherry');
>       s := s.WithLineAdded('dog;cat;bird');
>       
>       // WRONG: This modifies a temporary copy
>       s.Lines[1].CSV[2] := 'elephant'; 
>       
>       // CORRECT: Using immutable "With..." patterns
>       s := s.WithLineChanged(1, s.Lines[1].WithCSV(2, 'elephant'));
>     end;
>     ```

---

*OLTypes Library - Comprehensive FAQ*

*Generated for version compatible with Delphi XE - 12.1*

*For more information, visit the [GitHub repository](https://github.com/mihoo-r/OLTypes)*
