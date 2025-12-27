# Getting Started with OLTypes

## Installation

1.  **Download and Unpack**: Download the library and unpack it into your preferred directory.
2.  **Project Integration**:
    *   Add all units from the `source` folder directly to your project.
    *   **OR** add the path to the `source` folder to your project's **Search path** (*Project -> Options -> Delphi Compiler -> Search path*).
3.  **Global Installation (Optional)**: 
    If you want the library available for all new projects, add the source folder to your **Library path** (*Tools -> Options -> Environment Options -> Delphi Options -> Library -> Library path*).

## Basic Usage

To start using the library, simply add the `OLTypes` unit to the `uses` clause of your unit.

```pascal
uses
  OLTypes;
```

Once added, all library tools become immediately available. This includes:
*   **OL Types**: Null-safe versions of primitive types.
*   **Native Helpers**: Powerful extensions for standard Delphi types (string, Integer, TDateTime) via record helpers.

By using these types, you no longer need to manually manage different utility units like `SysUtils`, `StrUtils`, or `DateUtils` for basic operations. All these methods are directly accessible on the types themselves.

### Why use OLTypes?

The primary advantage of OLTypes is its **fluent interface** and **null-safety**. Standard Delphi types lack a built-in "empty" or "null" state, often leading to cumbersome tracking of separate boolean flags. OLTypes solves this by providing a unified way to handle missing data while offering a rich set of helper methods that can be chained together.
