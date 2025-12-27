# OLColor

`OLColor` is a helper type for advanced color manipulation in Delphi (VCL). It allows for easy adjustment of saturation and brightness, and supports working with different color models (RGB, HSV). It integrates seamlessly with the native `TColor` type.

## Static Methods (Named Colors)

The type contains dozens of static methods corresponding to standard colors (e.g., `Red`, `Blue`, `Aliceblue`, `Darkolivegreen`). Each of these methods accepts optional parameters for immediate saturation and brightness adjustment.

| Method | Description |
| :--- | :--- |
| `OLColor.Red(Sat, Bri)` | Returns Red with optional adjustments. |
| `OLColor.Blue(Sat, Bri)` | Returns Blue with optional adjustments. |
| `OLColor.Steelblue(Sat, Bri)` | Returns SteelBlue with optional adjustments. |
| ... and many more. | (Most standard TColors colors are available). |

### Example
```delphi
var
  c: OLColor;
begin
  c := OLColor.Red;
  // Deep saturated blue, slightly darker
  c := OLColor.Blue(10, -5); 
end;
```

---

## Instance Methods

| Method | Description |
| :--- | :--- |
| `Brighter(Delta)` | Returns a brighter version of the color (default delta +20). |
| `Darker(Delta)` | Returns a darker version of the color (default delta -20). |
| `Vividier(Delta)` | Increases color saturation (vividness) (default delta +20). |
| `Duller(Delta)` | Decreases color saturation (default delta -20). |
| `Complementary()` | Returns the complementary color (opposite on the color wheel). |

#### Visual adjustments example
```delphi
procedure TForm1.ApplyStyles;
var
  base: OLColor;
begin
  base := OLColor.Steelblue;
  PanelHeader.Color := base.Brighter(10);
  PanelFooter.Color := base.Darker(10);
  PanelHighlight.Color := base.Complementary;
end;
```

---

## Properties

### RGB Model
| Property | Type | Description |
| :--- | :--- | :--- |
| `R`, `G`, `B` | `Byte` / `Integer`| Red, Green, and Blue components (0-255). |

### HSV Model
| Property | Type | Description |
| :--- | :--- | :--- |
| `H` | `Integer` | Hue (0-359). |
| `S` | `Byte` | Saturation (0-100). |
| `V` | `Byte` | Value/Brightness (0-100). |

---

## Conversions & Operators

`OLColor` supports implicit casting (`implicit`) to and from the native `TColor` type from `Vcl.Graphics`.

```delphi
var
  oc: OLColor;
begin
  oc := clRed;          // Native TColor to OLColor
  Self.Color := oc;     // OLColor to Native TColor (e.g., Form.Color)
end;
```

> [!TIP]
> Use `Vividier` and `Brighter` to dynamically generate UI themes based on a single base color.
