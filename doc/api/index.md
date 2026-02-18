[← Back to Home](../index.md)

# API Reference

Welcome to the documentation for the OLTypes library. This library enhances standard Delphi types by introducing `Null` (empty state) support and a rich set of helper methods for daily development.

## Table of Contents

### 1. Core Nullable Types
These types are interchangeable with native Delphi types but can safely store a `Null` value.

- [OLString](OLString.md) - Enhanced text with JSON, XML, File I/O, and Null support.
- [OLInteger](OLInteger.md) - Integers with math operations and numeral system support.
- [OLBoolean](OLBoolean.md) - Logical type with three-state logic (True, False, Null).
- [OLDouble](OLDouble.md) - Floating-point numbers with precise epsilon-based comparison.
- [OLCurrency / OLDecimal](OLCurrency.md) - Fixed-point types for financial calculations.
- [OLDate](OLDate.md) / [OLDateTime](OLDateTime.md) - Sophisticated date and time manipulation.

### 2. Collections
Optimized containers for `OL` types with automatic memory management.

- [Arrays & Dictionaries](Collections.md) - `OLArrays` and `OLDictionaries` with fluent API support.

### 3. DataBinding & Validation
Mechanisms to automate working with VCL forms.

- [DataBinding & Validation](DataBinding.md) - Two-way binding for VCL controls with fluent validation rules.

### 4. Utilities & Helpers
- [Native Type Helpers](NativeHelpers.md) - Extensions for standard Delphi types like `string`, `Integer`, etc.
- [Utilities](Utils.md) - Rapid Registry access, background threading, and smart date parsing.
- [OLColor](OLColor.md) - Advanced color manipulation (Saturation, Brightness, HSV).
- [OLRegEx](OLRegEx.md) - Fluent regex builder for readable pattern construction.

---

> [!TIP]
> Most types in the library support **Implicit Casting**, allowing them to be used wherever a native type is expected. Remember to check `.HasValue` or `.IsNull()` before casting to a native type that does not support Nulls.
