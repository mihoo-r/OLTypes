# OLDouble

`OLDouble` is a value type representing a double-precision floating-point number with `Null` (empty) state support. It addresses common floating-point issues (like comparison noise) and provides a rich set of mathematical and formatting tools.

## Properties

### Basic
| Property | Type | Description |
| :--- | :--- | :--- |
| `OnChange` | `TNotifyEvent` | (Delphi 10.4+) Event triggered when the value of the double changes. |

---

## Methods

### State & Check
| Method | Description |
| :--- | :--- |
| `IsNull()` | Returns `True` if the value is `Null`. |
| `HasValue()` | Returns `True` if a value is present. |
| `IsPositive()`, `IsNegative()` | Checks the sign of the value. |
| `IsNan()`, `IsInfinite()` | Checks for special floating-point values. |
| `IsZero(Epsilon)` | Checks if value is zero (within optional tolerance). |
| `Between(Min, Max)` | Checks if the value is within a range (inclusive). |
| `SameValue(B, Epsilon)` | Checks equality with another value within a tolerance. |

### Mathematical Operations
| Method | Description |
| :--- | :--- |
| `Abs()`, `Sqr()`, `Sqrt()` | Absolute value, square, and square root. |
| `Power(Exponent)` | Raises value to the power (Integer or Extended). |
| `Max(d)`, `Min(d)` | Returns the maximum or minimum of two doubles. |
| `Round(PowerOfTen)` | Rounds to specified precision (e.g., `-2` for cents). |
| `Round()` | Rounds to nearest Integer. |
| `Floor()`, `Ceil()` | Standard floor and ceiling functions. |
| `SimpleRoundTo()` | Symmetric arithmetic rounding (rounds 0.5 away from zero). |
| `EnsureRange(Min, Max)` | Returns value clamped between Min and Max. |

### Formatting
| Method | Description |
| :--- | :--- |
| `ToString()` | Returns string using default format. |
| `ToString(Digits, ...)`| Returns string with fixed number of decimal digits. |
| `ToString(Sep, Dec, Fmt)`| Fully custom formatting with thousand/decimal separators. |
| `ToSQLString()` | Returns SQL-safe string (e.g., '12.34' or 'NULL'). |
| `IfNull(d)` | Returns `d` if the current value is `Null`. |

### Random Generation
| Method | Description |
| :--- | :--- |
| `Random(Min, Max)` | (Static) Returns a random `OLDouble` in range. |

---

## Examples

#### Formatting with Precision
```delphi
var
  price: OLDouble;
begin
  price := 1234.5678;
  Writeln(price.ToString(2)); // '1234.57'
  
  // Custom Polish format
  Writeln(price.ToString(' ', ',', '# ###,## zł')); // '1 234,57 zł'
end;
```

#### Safe Comparison
`OLDouble` uses a default epsilon of `1E-9` to handle floating-point noise automatically.
```delphi
var
  a, b: OLDouble;
begin
  a := 5.55;
  b := (1.85 * 3); // Might be 5.550000000000001
  
  if a = b then Writeln('Equal'); // True
end;
```

#### Math & Range
```delphi
var
  val: OLDouble;
begin
  val := 25.0;
  Writeln(val.Sqrt.ToString(0)); // '5'
  
  val := 150.0;
  Writeln(val.EnsureRange(0, 100).ToString(0)); // '100'
end;
```

---

## Operators

`OLDouble` supports all standard arithmetic and comparison operators.

### Arithmetic
`+`, `-`, `*`, `/`, `inc`, `dec`, `-` (unary).

### Comparison
`=`, `<>`, `>`, `>=`, `<`, `<=`.

### Implicit Conversion
```delphi
var
  ol: OLDouble;
  native: Double;
begin
  ol := 10.5;        // Double to OL
  native := ol;      // OL to native (raises exception if Null)
  
  ol := 100;         // Integer to OL
end;
```

> [!TIP]
> Use `HasValue` or `IsNull` before converting to native `Double` to avoid exceptions.
