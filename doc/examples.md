# Comprehensive Examples

These examples demonstrate how OLTypes can be used in real-world scenarios, showcasing the seamless integration with native types and the power of the fluent API.

## 1. OLInteger & Math

The following test procedure demonstrates state checking, random generation, and method chaining.

```pascal
procedure OLIntegerTest();
var
  i: Integer;
  b: Boolean;
  s: string;
  SuperI: OLInteger; 
begin
  b := SuperI.IsNull();               // Default value is Null
  i := 5;
  SuperI := i;                        // Assign regular Integer
  s := SuperI.ToString();             // Like IntToStr but cleaner
  SuperI := SuperI + 4;               // Arithmetic support
  SuperI := Null;                     // Assign Null
  SuperI := SuperI.IfNull(6);         // If Null, use 6
  b := SuperI.IsEven();               // Divisibility checks
  b := (SuperI >= 9);                 // Compare against native Integer
  SuperI.SetRandom(100);              // Set random integer
  SuperI := SuperI.Max(200).Min(400); // Method chaining (Max returns OLInteger)
  s := IntToStr(SuperI) + '.';        // Casts implicitly to Integer for parameters
  b := SuperI.IsPrime();              // Prime number check
  i := SuperI;                        // Assign back to native Integer (Raises Exception if Null)
end;
```

## 2. OLString & JSON

This example covers file I/O, compression, CSV handling, and the powerful JSON path navigation.

```pascal
procedure OLStringTest();
var
  s: string;
  SuperS: OLString;
begin
  s := 'This is a test';

  if SuperS.IsEmptyStr() then                   // Default value is empty string, not Null
    SuperS := s;                                // Assign a regular string
  SuperS[1] := 't';                             // Direct character access (1-based)
  SuperS := SuperS + ' !!! ';                   // Concatenation
  SuperS := Null;                               // Assign Null
  SuperS := SuperS.IfNull('New string');        // Fallback for Null
  SuperS.SaveToFile('c:\text.txt');             // Built-in File I/O
  SuperS.LoadFromFile('c:\text.txt');           
  SuperS.LineAdd('Second Line');                // StringList-like behavior
  SuperS.Lines[1] := 'It is the 2. line.';      
  SuperS := SuperS.Compressed();                // ZLib Compression
  SuperS := SuperS.Decompressed();              
  SuperS := SuperS.MidStr(11, 4);               // Substring extraction
  SuperS := OLType('Aa;Bb;Cc;Dd').LowerCase();  // Explicit casting with OLType helper
  SuperS := SuperS.CSV[1];                      // CSV Field access (second field: 'Bb')
  SuperS.CSV[4] := 'ee';                        // Semi-colon based field management
  SuperS.CopyToClipboard();                     // Windows Clipboard integration
  
  if SuperS.Like('%cc_dd%') then                // SQL-like pattern matching
    SuperS := 'Found matching pattern!';

  // JSON operations (Path-based)
  SuperS.JSON['Name'] := 'Admin';               // Creates {"Name":"Admin"}
  SuperS.JSON['Address.City'] := 'Pętkowo';     // {"Name":"Admin","Address":{"City":"Pętkowo"}}
  
  s := SuperS;                                  // Implicit cast back to native string
end;
```

## 3. OLDate & Time

Demonstrates how to handle dates, ranges, and ISO 8601 formatting.

```pascal
procedure OLDateTest();
var
  d: TDate;
  i: integer;
  b: Boolean;
  SuperD: OLDate;
begin
  d := Date();

  if SuperD.IsNull() then             // Default state is Null
    SuperD := d;                      // Assign regular TDate
  SuperD.Year := 2024;                // Direct property modification
  SuperD := SuperD.IncMonth(5);       // Date math
  SuperD := '2024-05-12';             // Implicit assignment from ISO 8601 string
  
  b := SuperD.InRange('2024-01-01', '2025-01-01');
  i := SuperD.EndOfAMonth(2024, 2).DaysInMonth(); // 29 (Leap year)

  ShowMessage(SuperD.ToString());     // Formatting (DateToStr equivalent)

  SuperD := Now();                    // Assigning TDateTime truncates the time part
  b := (SuperD = Date());             // Equality check against TDate
  
  d := SuperD;                        // Assign back to native TDate
end;
```
