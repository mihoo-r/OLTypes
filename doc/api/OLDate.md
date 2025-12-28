# OLDate

`OLDate` is a value type representing a date value with `Null` (empty) state support. It is essentially an `OLDateTime` specialized for date-only operations, where the time part is always ignored or set to midnight.

## Properties

### Component Access
| Property | Type | Description |
| :--- | :--- | :--- |
| `Year` | `OLInteger` | Gets or sets the year component. |
| `Month` | `OLInteger` | Gets or sets the month component (1-12). |
| `Day` | `OLInteger` | Gets or sets the day component (1-31). |

### Basic
| Property | Type | Description |
| :--- | :--- | :--- |
| `OnChange` | `TNotifyEvent` | (Delphi 10.4+) Event triggered when the value of the date changes. |

---

## Methods

### State & Check
| Method | Description |
| :--- | :--- |
| `IsNull()` | Returns `True` if the date is `Null`. |
| `HasValue()` | Returns `True` if a value is present. |
| `IsToday()` | Checks if the date equals today. |
| `IsInLeapYear()` | Checks if the year is a leap year. |
| `InRange(Start, End)`| Checks if the date is within a range. |
| `SameDay(other)` | Checks if dates are equal. |
| `IsValidDate(Y, M, D)`| (Static) Checks if the components form a valid date. |

### Static Helpers (Factory)
| Method | Description |
| :--- | :--- |
| `Today()`, `Yesterday()`, `Tomorrow()` | Returns the respective date. |

### Modification
| Method | Description |
| :--- | :--- |
| `IncYear()`, `IncMonth()`, `IncDay()`, `IncWeek()` | Increments the date. |
| `RecodedYear()`, `RecodedMonth()`, `RecodedDay()`| Returns a new date with one changed component. |
| `StartOfTheYear()`, `EndOfTheMonth()`, etc. | Returns boundary dates. |
| `SetToday()`, `SetYesterday()`, `SetTomorrow()` | Sets the current value. |

### Logic & Math
| Method | Description |
| :--- | :--- |
| `YearsBetween()`, `MonthsBetween()`, `DaysBetween()`| Returns count of complete units. If the parameter is earlier than `Self`, a non-negative number is returned. |
| `DaysSince1900()` | Returns days passed since 1900-01-01. |
| `Max(other)`, `Min(other)` | Returns the later or earlier of two dates. |

### Formatting
| Method | Description |
| :--- | :--- |
| `ToString()` | Returns string using default system format. |
| `ToString(Format)` | Returns string using custom format. |
| `LongDayName()`, `ShortMonthName()`, etc. | Locale-specific formatting. |

---

## Examples

#### Basic Usage
```delphi
var
  d: OLDate;
begin
  d := OLDate.Today;
  Writeln('Date: ' + d.ToString);
  Writeln('Year: ' + d.Year.ToString);
end;
```

#### Precise Month Calculation
Unlike standard Delphi `MonthsBetween`, `OLDate.MonthsBetween` in this library calculates full calendar months.
```delphi
var
  d1, d2: OLDate;
begin
  d1 := '2020-01-10';
  d2 := '2020-02-09';
  Writeln(d2.MonthsBetween(d1).ToString); // '0' (not a full month yet)

  d2 := '2020-02-10';
  Writeln(d2.MonthsBetween(d1).ToString); // '1'
end;
```

#### Handling Leap Years
```delphi
var
  d: OLDate;
begin
  d := '2024-02-01';
  if d.IsInLeapYear then
    Writeln('Days in Feb: ' + d.DaysInMonth.ToString); // '29'
end;
```

---

## Operators

`OLDate` supports:
- `+` and `-` with `Integer` (adds/subtracts days).
- `=`, `<>`, `>`, `>=`, `<`, `<=` for chronological comparison.
- `Implicit` conversion from/to `TDate`, `TDateTime`, `OLDateTime`, `Variant`, `string`.

> [!CAUTION]
> Implicit conversion to native `TDate` will raise an exception if the `OLDate` is `Null`.
