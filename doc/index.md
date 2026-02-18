# OLTypes Library Documentation

Welcome to the **OLTypes** documentation. This library is a comprehensive set of non-native types for Delphi that combine the power of primitive types with **Null value support** and a rich, fluent API.

## Navigation

*   [**Getting Started**](getting-started.md) - Installation and basic usage.
*   [**Comprehensive Examples**](examples.md) - See OLTypes in action with full code snippets.
*   [**API Reference**](api/index.md) - Detailed documentation for every type and helper.
*   [**Regular Expressions Tutorial**](RegExTutorial.md) - Learn how to build regex patterns with `TOLRegEx` using a fluent, readable API.
*   [**FAQ**](faq.md) - Frequently Asked Questions about OLTypes.
*   [**DeepWiki**](https://deepwiki.com/mihoo-r/OLTypes) - AI-generated documentation and code insights.

---

## Key Features

*   **Null-Safe Value Types**: `OLString`, `OLInteger`, `OLBoolean`, and more. Direct support for `Null` states without crashing or boilerplate flags.
*   **Declarative DataBinding**: Link your fields directly to VCL controls with `.Link()`. 
*   **Fluent Validation API**: Chain validation rules (e.g., `.Min(18).RequireValue`) directly to your UI controls.
*   **Powerful Native Helpers**: Extend standard Delphi `string`, `Integer`, and `TDateTime` with modern methods like `IsEven`, `Contains`, or `StartOfMonth`.
*   **Memory Managed Collections**: `OLArrays` and `OLDictionaries` featuring automatic memory management and optimized performance.
*   **Utility Tools**: Simplified Windows Registry operations (`OLRegistry`) and easy threading (`OLThreadRunner`).

## Compatibility

OLTypes is compatible with various Delphi versions. It has been specifically tested with:
*   Delphi 12 (Athens)
*   Delphi XE

It should also be compatible with:
*   Delphi 11 (Alexandria)
*   Delphi 10 (Seattle/Berlin/Tokyo/Sydney)
*   Delphi 2010 (Partial support for some features)


---

> [!TIP]
> **Pro Tip**: For the best development experience, use the `OLTypes` unit as your primary type source. It bundles most functionality and makes transition from native types seamless.
