# OLDateTime

`OLDateTime` is a value type representing a date and time value with `Null` (empty) state support. It wraps the standard `TDateTime` and provides a vast set of methods for component access, arithmetic, range checks, and formatting.

## Properties

### Component Access
| Property | Type | Description |
| :--- | :--- | :--- |
| `Year` | `OLInteger` | Gets or sets the year component. |
| `Month` | `OLInteger` | Gets or sets the month component (1-12). |
| `Day` | `OLInteger` | Gets or sets the day component (1-31). |
| `Hour` | `OLInteger` | Gets or sets the hour component (0-23). |
| `Minute` | `OLInteger` | Gets or sets the minute component (0-59). |
| `Second` | `OLInteger` | Gets or sets the second component (0-59). |
| `MilliSecond`| `OLInteger` | Gets or sets the millisecond component (0-999). |

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
| `IsToday()` | Checks if the date part equals today. |
| `IsInLeapYear()` | Checks if the year is a leap year. |
| `IsAM()`, `IsPM()` | Checks if the time is in the morning or afternoon. |
| `InRange(Start, End)`| Checks if value is within a range. |
| `SameDay(other)` | Checks if date parts are equal. |

### Static Helpers (Factory)
| Method | Description |
| :--- | :--- |
| `Now()` | Returns current local date and time. |
| `Today()`, `Yesterday()`, `Tomorrow()` | Returns date at midnight. |

### Modification
| Method | Description |
| :--- | :--- |
| `IncYear()`, `IncMonth()`, `IncDay()`, etc. | Increments the respective component. |
| `RecodedYear()`, `RecodedMonth()`, etc. | Returns a new value with one component changed. |
| `StartOfTheYear()`, `EndOfTheMonth()`, etc. | Returns boundary datetimes. |
| `DateOf()`, `TimeOf()`| Returns only date or only time part. |

### Logic & Math
| Method | Description |
| :--- | :--- |
| `YearsBetween()`, `MonthsBetween()`, etc. | Returns the number of complete units between two datetimes. If the parameter is earlier than `Self`, a non-negative number is returned. |
| `YearSpan()`, `MonthSpan()`, etc. | Returns approximate fractional units (as Double). If the parameter is earlier than `Self`, a non-negative number is returned. |
| `Max(other)`, `Min(other)` | Returns the latest or earliest of two values. |
| `IfNull(b)` | Returns `b` if the current value is `Null`. |

### Formatting
| Method | Description |
| :--- | :--- |
| `ToString()` | Returns string using default system format. |
| `ToString(Format)`| Returns string using custom format (e.g., 'yyyy-mm-dd'). |
| `LongDayName()`, `ShortMonthName()`, etc. | Locale-specific formatting. |

---

## Examples

#### Basic Usage
```delphi
var
  dt: OLDateTime;
begin
  dt := OLDateTime.Now;
  Writeln('Year: ' + dt.Year.ToString);
  Writeln('Formatted: ' + dt.ToString('yyyy-mm-dd hh:nn'));
end;
```

#### Calculations
```delphi
var
  start, finish: OLDateTime;
begin
  start := '2023-01-01 10:00';
  finish := start.IncHour(24).IncMinute(30);

  Writeln('Days between: ' + finish.DaysBetween(start).ToString); // 1
  Writeln('Hours between: ' + IntToStr(finish.HoursBetween(start))); // 24
end;
```

#### Range Checks
```delphi
var
  check: OLDateTime;
begin
  check.SetToday;
  if check.InRange('2023-01-01', '2023-12-31') then
    Writeln('Within year 2023');
end;
```

#### Start/End Boundaries
```delphi
var
  dt: OLDateTime;
begin
  dt := OLDateTime.Now;
  Writeln('End of month: ' + dt.EndOfTheMonth.ToString);
end;
```

---

## Operators

`OLDateTime` supports:
- `+` and `-` with `Double`/`Extended` (adds/subtracts days).
- `=`, `<>`, `>`, `>=`, `<`, `<=` for chronological comparison.
- `Implicit` conversion from/to `TDateTime`, `Variant`, `string`, `Extended`.

> [!CAUTION]
> Implicit conversion to native `TDateTime` will raise an exception if the `OLDateTime` is `Null`.
