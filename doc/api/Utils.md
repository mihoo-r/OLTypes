# Utilities

The OLTypes library includes several utility tools to simplify common development tasks like Registry management, background threading, and smart date parsing.

## Registry Helper (`OLRegistry`)

`TOLRegistry` provides an extremely simple way to save and load application settings from the Windows Registry. It automatically creates a separate key for each executable, preventing setting conflicts between different applications.

### Basic Usage
```delphi
begin
  // Saving a value
  TOLRegistry.Settings['LastUser'] := 'JohnDoe';
  
  // Loading a value
  Writeln('User: ' + TOLRegistry.Settings['LastUser'].ToString);
end;
```

---

## Thread Runner (`OLThreadRunner`)

`TOLThreadRunner` is a simple tool for executing long-running tasks in a background thread without blocking the User Interface (Main Thread). It also supports an optional completion callback that is automatically synchronized with the main thread.

### Basic Usage
```delphi
begin
  TOLThreadRunner.Run(
    procedure // Background Thread
    begin
      Sleep(2000); // Simulate long work
    end,
    procedure // Main Thread (Sync)
    begin
      ShowMessage('Work Finished!');
    end
  );
end;
```

---

## Smart Date Parsing (`SmartToDate`)

The `SmartToDate` unit provides the `ParsingToDate` function, which allows users to enter dates using natural language shortcuts.

### Supported Shortcuts
- `td` -> Today
- `tm` -> Tomorrow
- `yd` -> Yesterday
- `sm` -> Start of current Month
- `em` -> End of current Month
- `sy` -> Start of current Year
- `ey` -> End of current Year

### Example
```delphi
var
  d: OLDate;
begin
  d := ParsingToDate('td'); // Sets d to Today
  d := ParsingToDate('em'); // Sets d to last day of current month
end;
```

---

## Global OLType Function

The unit `OLTypes` provides a global `OLType` overloaded function that serves as a factory for converting native types to their nullable record counterparts.

```delphi
var
  oli: OLInteger;
begin
  oli := OLType(123); // Explicitly creates OLInteger from native Integer
end;
```

> [!TIP]
> `OLRegistry` is ideal for persistent UI state (like form positions or last opened files) because it requires zero configuration.
