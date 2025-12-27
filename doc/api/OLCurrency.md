# OLCurrency

`OLCurrency` (aliased as `OLDecimal`) is a value type representing a currency value with `Null` (empty) state support. It uses the standard Delphi `Currency` type internally to ensure high precision for financial calculations (fixed-point arithmetic).

## Properties

### Basic
| Property | Type | Description |
| :--- | :--- | :--- |

| `OnChange` | `TNotifyEvent` | (Delphi 10.4+) Event triggered when the value changes. |

---

## Methods

### State & Check
| Method | Description |
| :--- | :--- |
| `IsNull()` | Returns `True` if the value is `Null`. |
| `HasValue()` | Returns `True` if a value is present. |
| `IsPositive()`, `IsNegative()` | Checks the sign of the value. |
| `Between(Min, Max)` | Checks if the value is within a range (inclusive). |

### Mathematical Operations
| Method | Description |
| :--- | :--- |
| `Abs()`, `Sqr()`, `Power(Exp)` | Absolute value, square, and integer power. |
| `Max(c)`, `Min(c)` | Returns the maximum or minimum of two currency values. |
| `Round(PowerOfTen)` | Rounds to specified precision (e.g., `0` for integer). |
| `Round()` | Rounds to the nearest `OLInteger`. |
| `Floor()`, `Ceil()` | Standard floor and ceiling functions (returns `OLInteger`). |
| `SimpleRoundTo()` | Symmetric arithmetic rounding (rounds 0.5 away from zero). |

### Formatting
| Method | Description |
| :--- | :--- |
| `ToString()` | Returns string formatted using system currency settings. |
| `ToString(Sep, Dec, Fmt)`| Fully custom formatting with thousand/decimal separators. |
| `ToStrF(Fmt, Digits)` | Returns string using specified `TFloatFormat`. |
| `ToSQLString()` | Returns SQL-safe string (e.g., '12.3400' or 'NULL'). |
| `IfNull(c)` | Returns `c` if the current value is `Null`. |

---

## Examples

#### Financial Formatting
```delphi
var
  salary: OLCurrency;
begin
  salary := 5000.50;
  Writeln(salary.ToString); // Depends on OS locale (e.g., '$5,000.50')
  
  // Custom format
  Writeln(salary.ToString(',', '.', '#,##0.00 EUR')); // '5.000,50 EUR'
end;
```

#### Precise Calculations
`OLCurrency` avoids common binary floating-point rounding errors.
```delphi
var
  a, b, res: OLCurrency;
begin
  a := 10.10;
  b := 20.20;
  res := a + b;
  Writeln(res.ToString); // '30.30'
end;
```

#### Handling Nulls in Business Logic
```delphi
var
  bonus: OLCurrency;
begin
  bonus := Null;
  Writeln('Total: ' + (5000 + bonus.IfNull(0)).ToString); // '5000.00'
end;
```

---

## Operators

`OLCurrency` supports standard arithmetic and comparison operators.

### Arithmetic
`+`, `-`, `*` (supports `OLInteger`, `Double`, `OLDouble`), `/` (always returns `OLDouble`).

### Comparison
`=`, `<>`, `>`, `>=`, `<`, `<=`. Supports comparison with `OLCurrency`, `Currency`, and `Extended`.

### Implicit Conversion
```delphi
var
  ol: OLCurrency;
  native: Currency;
begin
  ol := 10.99;        // Currency to OL
  native := ol;      // OL to native (raises exception if Null)
  
  ol := 100;          // Integer to OL
end;
```

> [!NOTE]
> `OLDecimal` is an exact alias for `OLCurrency`. You can use them interchangeably.
