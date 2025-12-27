# OLBoolean

`OLBoolean` is a value type that represents a boolean value with `Null` (empty) state support. It is designed to be highly compatible with the native `Boolean` type while providing additional functionality for handling missing data.

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `OnChange` | `TNotifyEvent` | (Delphi 10.4+) Event triggered when the value moves from Null to data or changes. |

### Property Examples

#### OnChange
```delphi
procedure TMyForm.HandleBooleanChange(Sender: TObject);
begin
  ShowMessage('Value has changed!');
end;

procedure TMyForm.Setup;
var
  active: OLBoolean;
begin
  active.OnChange := HandleBooleanChange;
  active := True; // Triggers the event
end;
```

---

## Methods

### State & Check
| Method | Description |
| :--- | :--- |
| `IsNull()` | Returns `True` if no value is present (`Null`). |
| `HasValue()` | Returns `True` if a value is present. |

### Conversions
| Method | Description |
| :--- | :--- |
| `ToString()` | Converts the value to string ('True' or 'False'). Returns an empty string if `Null`. |
| `ToSQLString()` | Converts the value to a fixed SQL format ('True', 'False' or 'NULL'). |

### Logical Flow
| Method | Description |
| :--- | :--- |
| `IfNull(const b: OLBoolean)` | Returns the current value if present, otherwise returns `b`. |
| `IfThen(...)` | Returns the first parameter if `True`, otherwise returns the second. Supported types: `string`, `Integer`, `Currency`, `Extended`, `TDateTime`, `Boolean`. |

---

### Method Examples

#### IsNull
```delphi
var
  val: OLBoolean;
begin
  // val is uninitialized (Null)
  if val.IsNull then
    Writeln('No value assigned');
end;
```

#### HasValue
```delphi
var
  active: OLBoolean;
begin
  active := False;
  if active.HasValue then
    Writeln('Value is present (even if it is False)');
end;
```

#### ToString
```delphi
var
  val: OLBoolean;
begin
  val := True;
  Writeln(val.ToString); // Outputs: 'True'
  
  val := Null;
  Writeln('"' + val.ToString + '"'); // Outputs: ""
end;
```

#### ToSQLString
```delphi
var
  val: OLBoolean;
begin
  val := True;
  Writeln(val.ToSQLString); // Outputs: 'True'
  
  val := Null;
  Writeln(val.ToSQLString); // Outputs: 'NULL'
end;
```

#### IfNull
```delphi
var
  val, default: OLBoolean;
begin
  default := True;
  Writeln(val.IfNull(default).ToString); // Outputs: 'True' because val was Null
end;
```

#### IfThen (string)
```delphi
var
  isVip: OLBoolean;
begin
  isVip := True;
  Writeln(isVip.IfThen('Welcome VIP!', 'Access Denied')); // Outputs: 'Welcome VIP!'
end;
```

#### IfThen (Integer)
```delphi
var
  enabled: OLBoolean;
begin
  enabled := False;
  Writeln(enabled.IfThen(1, 0)); // Outputs: 0
end;
```

#### IfThen (Currency)
```delphi
var
  hasDiscount: OLBoolean;
begin
  hasDiscount := True;
  Writeln(FloatToStr(hasDiscount.IfThen(19.99, 29.99))); // Outputs: 19.99
end;
```

#### IfThen (TDateTime)
```delphi
var
  isMorning: OLBoolean;
begin
  isMorning := True;
  Writeln(DateTimeToStr(isMorning.IfThen(Now, PreviousDay)));
end;
```

---

## Operators

`OLBoolean` supports standard logical and comparison operators. It also provides implicit casting for seamless integration with the native `Boolean` type.

### Implicit Conversion
You can assign a `Boolean` or `Variant` directly to an `OLBoolean` and vice versa.

> [!CAUTION]
> Implicit conversion from `OLBoolean` to `Boolean` will raise an exception if the value is `Null`.

```delphi
var
  ol: OLBoolean;
  native: Boolean;
begin
  ol := True;       // Implicit from native
  native := ol;     // Implicit to native
  
  ol := Null;
  // native := ol;  // THIS WOULD RAISE AN EXCEPTION!
end;
```

### Logical Operators
Supported operators: `not`, `and`, `or`, `xor`.
```delphi
var
  a, b, res: OLBoolean;
begin
  a := True;
  b := False;
  res := a and b; // res.FValue is False
  res := not b;   // res.FValue is True
end;
```

### Comparison Operators
Supported operators: `=`, `<>`, `>`, `>=`, `<`, `<=`.
Comparison with `Variant` is also supported for the `=` operator.

```delphi
var
  a, b: OLBoolean;
begin
  a := True;
  b := Null;
  if a <> b then Writeln('Different');
end;
```
