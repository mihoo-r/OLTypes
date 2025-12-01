# README #

### What is this repository for? ###

The repository holds the **OLTypes Delphi library**.
The library enhances basic Delphi types with a whole lot of useful methods and the ability to store Null values.
It was tested with Delphi 2010, Delphi XE, and Delphi 10.1. It will not work in Delphi 2005 and below.

The library provides a comprehensive set of features, including:

* **OLTypes (Nullable Primitive Types)**: The core library provides nullable types like OLString, OLDateTime, OLInteger, etc., which are interchangeable with standard Delphi types (String, TDateTime, Integer), but **allow storing Null values**.
* **Primitive Type Helpers**: Extensions with many additional methods for basic types like Integer, String, etc. (Available from Delphi 2006+).
* **DataBinding (OLTypesToEdits)**: Automatic binding of OL types to VCL controls for seamless UI synchronization (Available from Delphi XE2+).
* **OLArrays** and **OLDictionaries**: Dynamic arrays and dictionaries with helper methods for OL types (Available from Delphi 2009+).
* **OLRegistry**: Helper functions for Windows Registry operations (Available from Delphi 2006+).
* **OLThreadRunner**: A tool for running tasks in separate threads (Available from Delphi 2009+).

### Licence ###
OLTypes library is distributed under **[the MIT License](https://www.wikiwand.com/en/MIT_License)**.

### How do I get set up? ###

* Download library and unpack it.
* Add all units from the source folder directly to your project, **OR** add the path to the source folder to your project's **Search path** (Project -> Options -> Delphi Compiler -> Search path).
* Add OLTypes to the uses section in your program

If you wish for the library to be globally available for all new projects, you should add the source folder to your **Library path** instead.
(Menu Tools -> Options -> Environment Options -> Delphi Options -> Library -> Library path).

**You may also want to open the OLTypesTest.dpr to run the tests and see the new types in use before you start using it yourself.**

### Contribution guidelines ###

Please write me when you

* found a bug,
* have a suggestion,
* wrote an interesting modification.

Repo owner and admin: **[rajewicz+olt@gmail.com](mailto:rajewicz+olt@gmail.com)**