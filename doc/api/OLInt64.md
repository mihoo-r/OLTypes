# OLInt64

`OLInt64` is a value type representing a 64-bit integer with `Null` (empty) state support. It provides extended range and a comprehensive set of mathematical and utility methods.

## Properties

### Number Systems (String Representation)
| Property | Description |
| :--- | :--- |
| `Binary` | Gets or sets the 64-bit binary (base-2) string representation. |
| `Octal` | Gets or sets the octal (base-8) string representation. |
| `Hexidecimal` | Gets or sets the hexadecimal (base-16) string representation. |
| `NumeralSystem32` | Gets or sets the base-32 string representation. |
| `NumeralSystem64` | Gets or sets the base-64 string representation. |

---

## Methods

### State & Check
| Method | Description |
| :--- | :--- |
| `IsNull()` | Returns `True` if the value is `Null`. |
| `HasValue()` | Returns `True` if a value is present. |
| `IsPositive()`, `IsNegative()`, `IsNonNegative()` | Checks the sign of the value. |
| `IsEven()`, `IsOdd()` | Checks if the value is even or odd. |
| `IsPrime()` | Checks if the value is a prime number. |
| `IsDividableBy(i)` | Checks if the value is divisible by `i` (Int64). |
| `Between(Min, Max)` | Checks if the value is within a range (inclusive). |

### Mathematical Operations
| Method | Description |
| :--- | :--- |
| `Abs()` | Returns the absolute value. |
| `Sqr()` | Returns the square of the value. |
| `Power(Exponent)` | Returns the value raised to the power (Int64 or LongWord). |
| `Max(i)`, `Min(i)` | Returns the maximum or minimum of two Int64 values. |
| `Round(Digits)` | Rounds to the nearest multi-digit precision. |
| `Increased(Amount)`, `Decreased(Amount)` | Returns the value incremented or decremented by Int64 amount. |
| `Replaced(From, To)` | Returns `To` if current value equals `From`, otherwise current value. |

### Conversions & Utilities
| Method | Description |
| :--- | :--- |
| `ToString()` | Returns string representation or empty string if `Null`. |
| `ToSQLString()` | Returns SQL-safe string ('123' or 'NULL'). |
| `ToNumeralSystem(Base)` | Converts to string in any base between 2 and 64. |
| `IfNull(i)` | Returns `i` if the current value is `Null`. |
| `ForLoop(Start, End, Proc)`| Executes a procedure in a loop using the current value as iterator. |

### Random Generation
| Method | Description |
| :--- | :--- |
| `Random(Min, Max)` | (Static) Returns a random `OLInt64` in range. |
| `RandomPrime(Min, Max)` | (Static) Returns a random prime `OLInt64` in range. |
| `SetRandom(Min, Max)` | (Instance) Sets the current value to a random value. |
| `SetRandomPrime(Min, Max)`| (Instance) Sets the current value to a random prime. |

---

## Examples

#### Working with Large Numbers
```delphi
var
  big: OLInt64;
begin
  big := 9223372036854775807; // Max Int64
  Writeln(big.ToString);
  Writeln(big.Hexidecimal);    // '7FFFFFFFFFFFFFFF'
end;
```

#### Predicates
```delphi
var
  val: OLInt64;
begin
  val := 1000000000000037;
  if val.IsPrime then Writeln('Found a large prime!');
  if val.IsDividableBy(2) then Writeln('Even');
end;
```

#### Math & Range
```delphi
var
  val: OLInt64;
begin
  val := 500;
  if val.Between(0, 1000) then 
    Writeln(val.Increased(500).ToString); // '1000'
    
  Writeln(val.Round(2).ToString); // '500' (already rounded to hundred)
end;
```

#### ForLoop (64-bit range)
```delphi
var
  i: OLInt64;
begin
  i.ForLoop(1, 3, procedure
    begin
      Writeln('Iteration: ' + i.ToString);
    end);
end;
```

#### Random
```delphi
var
  secret: OLInt64;
begin
  secret.SetRandom(1000000000, 2000000000);
  Writeln('Random Key: ' + secret.ToNumeralSystem(32));
end;
```

---

## Operators

`OLInt64` supports all standard arithmetic and comparison operators, including interoperability with `Integer`, `OLInteger`, and `Extended` types.

### Arithmetic
`+`, `-`, `*`, `div`, `/` (returns `OLDouble`), `mod`, `xor`, `inc`, `dec`, `-` (unary).

### Comparison
`=`, `<>`, `>`, `>=`, `<`, `<=`. Supports comparison with `OLInt64` and `Extended`.

### Implicit Conversion
```delphi
var
  ol: OLInt64;
  native: Int64;
  small: Integer;
begin
  ol := 100;         // Native to OL
  native := ol;      // OL to native (raises exception if Null)
  
  small := 50;
  ol := small;       // Integer to OLInt64
  small := ol;       // OLInt64 to Integer (checked cast)
end;
```
