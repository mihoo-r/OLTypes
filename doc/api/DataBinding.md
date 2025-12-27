# DataBinding & Validation

The `OLTypesToEdits` unit introduces a **DataBinding** mechanism that allows for declarative binding of OL types to User Interface (VCL) components.

This is a declarative approach that significantly simplifies form code. Instead of manually copying values from `Edit.Text` to fields and back in `OnChange` events or when showing the form, you simply declare the binding once.

### Key Benefits
- **Declarative Logic**: Define "what" to bind, not "how" to copy data.
- **Two-Way Synchronization**: Changes in the UI update the field, and changes in the field update the UI.
- **Integrated Validation**: Chain rules directly after the `.Link()` call.

### Supported Components
You can link OL types with many standard VCL controls:

- **TEdit, TMemo**: Two-way binding for `OLString`, `OLInteger`, `OLDouble`, `OLCurrency`.
- **TLabel**: One-way binding (displaying value or function results).
- **TCheckBox**: Binding for `OLBoolean`.
- **TDateTimePicker**: Binding for `OLDate` and `OLDateTime`.
- **TSpinEdit, TTrackBar, TScrollBar**: Binding for `OLInteger`.

---

## Core Syntax: .Link()

The entry point for all data binding is the `.Link()` method, which is added to VCL controls via a class helper. Once linked, you can easily apply **Validation** rules using a fluent API, with automatic UI feedback (colors, hints) handled for you.

## 1. DataBinding

DataBinding creates a two-way synchronization between an `OL`-typed field and a UI control.
- **Field to UI**: Changing the field updates the control.
- **UI to Field**: Changing the control updates the field.
- **Null Handling**: Empty strings in controls are automatically converted to `Null` (and vice-versa).

### Basic Usage (`Link`)

The easiest way to link an `OL`-typed field is using the `.Link()` helper method directly on the control.

> [!WARNING]
> You can only link `OL`-typed fields to controls that are on the **same Form**.

```delphi
// In your TForm declaration:
//   MyName: OLString;
//   MyAge: OLInteger;

procedure TForm1.FormCreate(Sender: TObject);
begin
  // Link field to control
  EditName.Link(MyName);
  SpinAge.Link(MyAge);
end;
```

### Supported Controls
The library supports linking to most standard VCL controls:
- **TEdit, TMemo**: Links to `OLString`, `OLInteger`, `OLDouble`, `OLCurrency`.
- **TSpinEdit**: Links to `OLInteger`.
- **TCheckBox**: Links to `OLBoolean`.
- **TDateTimePicker**: Links to `OLDate`, `OLDateTime`.
- **TLabel**: One-way binding (display only).
- **TTrackBar, TScrollBar**: Links to `OLInteger`.

---

## 2. Validation

Validation is built on top of DataBinding. You can chain validation rules directly after the `.Link()` call.

### Fluent Syntax

```delphi
procedure TForm1.FormCreate(Sender: TObject);
begin
  // Link and validate in one go
  EditAge.Link(MyAge)
    .RequireValue
    .Max(118)
    .Positive(clRed, 'Age must be positive');
end;
```

### Built-in Validators

The `OLTypes` unit provides fluent validation methods specific to the data type.

#### For `OLString`
- **Basics**: `RequireValue`, `MinLength(n)`, `MaxLength(n)`.
- **Content**: `AlphaNumeric`, `DigitsOnly`, `Email`, `URL`, `Password` (complexity).
- **Financial/ID**: `IBAN`, `BIC`, `CreditCard` (Luhn).
- **Polish Specific**: `PESEL`, `NIP`.
- **Network**: `IPv4`, `IPv6`.
- **Codes**: `EAN`.

#### For `OLInteger`, `OLDouble`, `OLCurrency`
- **Range**: `Min(v)`, `Max(v)` `Between(min, max)`.
- **Sign**: `Positive`, `Negative`.
- **Basics**: `RequireValue`.

#### For `OLDate`, `OLDateTime`
- **Range**: `Min(d)`, `Max(d)`, `Between(min, max)`.
- **Time**: `Past`, `Future`, `Today`.
- **Logic**: `IsWeekday`, `IsWeekend`.
- **Age**: `MinAge(y)`, `MaxAge(y)`.
- **Basics**: `RequireValue`.

---

### Custom Validators

You can add your own validation logic using `AddValidator`.

```delphi
EditCode.Link(MyCode)
  .AddValidator(
    function(Value: OLString): TOLValidationResult
    begin
      if Value.StartsWith('X') then
        Result := TOLValidationResult.Ok
      else
        Result := TOLValidationResult.Error('Code must start with X');
    end
  );
```

### UI Feedback
When validation fails:
1.  **Visual Cue**: The control's background color changes (default: yellow/red).
2.  **Message**: An error message is displayed as a balloon hint on hover.

> [!TIP]
> Use `OLFormHelper` to validate the entire form at once before saving.
```delphi
if Self.IsValid then
  SaveData()
else
  Self.ShowValidationState; // Force update of visual cues
```
