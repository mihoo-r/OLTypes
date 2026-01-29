# OLInteger / OLInt64

`OLInteger` (and `OLInt64`) is a value type representing integer with `Null` (empty) state support. It provide a rich set of mathematical operations, number system conversions, and random number generation capabilities.

## Properties

### Basic
| Property | Type | Description |
| :--- | :--- | :--- |
| `OnChange` | `TNotifyEvent` | (Delphi 10.4+) Event triggered when the value changes. |

### Number Systems (String Representation)
| Property | Description |
| :--- | :--- |
| `Binary` | Gets the binary (base-2) string representation. |
| `Octal` | Gets the octal (base-8) string representation. |
| `Hexidecimal` | Gets the hexadecimal (base-16) string representation. |
| `NumeralSystem32` | Gets the base-32 string representation. |
| `NumeralSystem64` | Gets the base-64 string representation. |

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
| `IsDividableBy(i)` | Checks if the value is divisible by `i`. |
| `Between(Min, Max)` | Checks if the value is within a range (inclusive). |

### Mathematical Operations
| Method | Description |
| :--- | :--- |
| `Abs()` | Returns the absolute value. |
| `Sqr()` | Returns the square of the value. |
| `Power(Exponent)` | Returns the value raised to the power. |
| `Max(i)`, `Min(i)` | Returns the maximum or minimum of two values. |
| `Round(Digits)` | Rounds to the nearest multi-digit precision (e.g., 1 rounds to tens). |
| `Increased(Amount)`, `Decreased(Amount)` | Returns the value incremented or decremented. |
| `Replaced(From, To)` | Returns `To` if current value equals `From`, otherwise current value. |

### Conversions & Utilities
| Method | Description |
| :--- | :--- |
| `ToString()` | Returns string representation or empty string if `Null`. |
| `ToSQLString()` | Returns SQL-safe string ('123' or 'NULL'). |
| `ToNumeralSystem(Base)` | Converts to string in any base between 2 and 64. |
| `IfNull(i)` | Returns `i` if the current value is `Null`. |
| `AsInteger(Default)` | Returns the native `Integer` value, or `Default` if `Null`. |

### Random Generation
| Method | Description |
| :--- | :--- |
| `Random(Min, Max)` | (Static) Returns a random `OLInteger` in range. |
| `RandomPrime(Min, Max)` | (Static) Returns a random prime `OLInteger` in range. |

---

## Examples

#### Basic Properties
```delphi
var
  count: OLInteger;
begin
  count := 42;
  Writeln(count.HasValue.ToString);     // 'True'
  Writeln(count.Hexidecimal);           // '2A'
  
  count := OLInteger.FromBinary('101010');
  Writeln(count.ToString);              // '42'
end;
```

#### Predicates (Primes & Divisibility)
```delphi
var
  val: OLInteger;
begin
  val := 17;
  if val.IsPrime then Writeln('17 is prime');
  if val.IsOdd then Writeln('17 is odd');
  if val.IsDividableBy(3) then Writeln('17 is divisible by 3 (False)');
end;
```

#### Mathematical Operations
```delphi
var
  base: OLInteger;
begin
  base := 5;
  Writeln(base.Sqr.ToString);        // '25'
  Writeln(base.Power(3).ToString);   // '125' (as OLInteger)
  Writeln(base.Max(10).ToString);    // '10'
end;
```

#### Rounding
```delphi
var
  val: OLInteger;
begin
  val := 127;
  Writeln(val.Round(1).ToString); // '130' (rounds to tens)
  Writeln(val.Round(2).ToString); // '100' (rounds to hundreds)
end;
```

#### Random Generation
```delphi
var
  lucky: OLInteger;
begin
  lucky := OLInteger.Random(1, 100);
  
  // Static method to create a random prime
  lucky := OLInteger.RandomPrime(50, 100); 
  Writeln('Random Prime: ' + lucky.ToString);
end;
```

---

## Operators

`OLInteger` supports all standard arithmetic and comparison operators.

### Arithmetic
`+`, `-`, `*`, `div`, `mod`, `xor`, `inc`, `dec`, `-` (unary).

### Comparison
`=`, `<>`, `>`, `>=`, `<`, `<=`. Supports comparison with `OLInteger` and `Extended` types.

### Implicit Conversion

> [!CAUTION]
> Implicit conversion to native `Integer` or `Double` will raise an exception if the `OLInteger` is `Null`.

```delphi
var
  ol: OLInteger;
  native: Integer;
begin
  ol := 10;          // Native to OL
  native := ol;      // OL to native (raises exception if Null)
  
  if ol = 10.5 then ; // OL to Extended comparison
end;
```
