unit OLArrays;

interface

uses
  {$IF CompilerVersion >= 23.0}
  System.Generics.Collections,
  System.Generics.Defaults,
  System.SysUtils,
  {$ELSE}
  Generics.Collections,
  Generics.Defaults,
  SysUtils,
  {$IFEND}
  // Your original type modules
  OLBooleanType, OLCurrencyType, OLDateTimeType, OLDateType, OLDoubleType,
  OLIntegerType, OLStringType;

type
  // ===========================================================================
  // 1. GENERIC ENGINE (OLArray<T>)
  // Contains all memory management logic and algorithms.
  // ===========================================================================
  /// <summary>
  ///   Enumerator for OLArray<T>.
  /// </summary>
  TEnumerator<T> = record
  private
    FIndex: Integer;
    FItems: TArray<T>;
  public
    /// <summary>
    ///   Creates a new enumerator with the specified items.
    /// </summary>
    constructor Create(const AItems: TArray<T>);
    /// <summary>
    ///   Advances the enumerator to the next element.
    /// </summary>
    function MoveNext: Boolean;
    /// <summary>
    ///   Gets the current element.
    /// </summary>
    function GetCurrent: T;
    /// <summary>
    ///   Gets the current element.
    /// </summary>
    property Current: T read GetCurrent;
  end;

  /// <summary>
  ///   Generic array wrapper with advanced functionality.
  /// </summary>
  OLArray<T> = record
  private
    arr: TArray<T>;
    FSorted: Boolean; // Sorted state flag
    function GetItems(Index: Integer): T;
    function GetLength: Integer;
    procedure SetItems(Index: Integer; const Value: T);
    procedure SetLength(const Value: Integer);
    procedure MakeUnique; inline;
  public
    /// <summary>
    ///   Gets or sets the item at the specified index.
    /// </summary>
    property Items[Index: Integer]: T read GetItems write SetItems; default;
    /// <summary>
    ///   Gets or sets the length of the array.
    /// </summary>
    property Length: Integer read GetLength write SetLength;
    /// <summary>
    ///   Gets whether the array is sorted.
    /// </summary>
    property IsSorted: Boolean read FSorted;

    /// <summary>
    ///   Adds a value to the end of the array.
    /// </summary>
    procedure Add(const Value: T);
    /// <summary>
    ///   Inserts a value at the specified index.
    /// </summary>
    procedure Insert(AtIndex: Integer; const Value: T);
    /// <summary>
    ///   Deletes the item at the specified index.
    /// </summary>
    procedure Delete(Index: Integer);
    /// <summary>
    ///   Clears the array.
    /// </summary>
    procedure Clear;

    /// <summary>
    ///   Sorts the array in-place.
    /// </summary>
    procedure Sort;

    /// <summary>
    ///   Returns a new sorted copy of the array.
    /// </summary>
    function Sorted: OLArray<T>;

    /// <summary>
    ///   Returns the index of the last item.
    /// </summary>
    function LastItemIndex: Integer;
    /// <summary>
    ///   Checks if the array contains the specified value.
    /// </summary>
    function ContainsValue(const v: T): Boolean;
    {$IF CompilerVersion >= 23.0} // XE2+
    /// <summary>
    ///   Returns a new array with distinct values.
    /// </summary>
    function Distinct(const Comparer: IEqualityComparer<T> = nil): OLArray<T>;
    {$ELSE}
    /// <summary>
    ///   Returns a new array with distinct values.
    /// </summary>
    function Distinct(const Comparer: IEqualityComparer<T>): OLArray<T>;
    {$IFEND}
    /// <summary>
    ///   Returns a new reversed copy of the array.
    /// </summary>
    function Reversed: OLArray<T>;
    /// <summary>
    ///   Gets the enumerator for the array.
    /// </summary>
    function GetEnumerator: TEnumerator<T>;

    /// <summary>
    ///   Implicit conversion from TArray<T> to OLArray<T>.
    /// </summary>
    class operator Implicit(const A: TArray<T>): OLArray<T>; overload;
    /// <summary>
    ///   Implicit conversion from OLArray<T> to TArray<T>.
    /// </summary>
    class operator Implicit(const A: OLArray<T>): TArray<T>; overload;
  end;

  // Dynamic array definitions (as per original)
  TOLBooleanDynArray  = array of Boolean;
  TOLCurrencyDynArray = array of Currency;
  TOLDateTimeDynArray = array of TDateTime;
  TOLDateDynArray     = array of TDate;
  TOLDoubleDynArray   = array of Double;
  TOLIntegerDynArray  = array of Integer;
  TOLInt64DynArray    = array of Int64;
  TOLByteDynArray     = array of Byte;
  TOLStringDynArray   = array of string;

  // ===========================================================================
  // 2. WRAPPERS (Concrete types)
  // Implement 4 conversion operators and delegate work to FEngine.
  // ===========================================================================

  // --- OLIntegerArray ---
  /// <summary>
  ///   Array wrapper for OLInteger.
  /// </summary>
  OLIntegerArray = record
  private
    FEngine: OLArray<OLInteger>;
    function GetItems(Index: Integer): OLInteger; inline;
    function GetLength: Integer; inline;
    procedure SetItems(Index: Integer; const Value: OLInteger); inline;
    procedure SetLength(const Value: Integer); inline;
  public
    /// <summary>
    ///   Gets or sets the item at the specified index.
    /// </summary>
    property Items[Index: Integer]: OLInteger read GetItems write SetItems; default;
    /// <summary>
    ///   Gets or sets the length of the array.
    /// </summary>
    property Length: Integer read GetLength write SetLength;

    /// <summary>
    ///   Adds a value to the end of the array.
    /// </summary>
    procedure Add(Value: OLInteger); inline;
    /// <summary>
    ///   Inserts a value at the specified index.
    /// </summary>
    procedure Insert(AtIndex: Integer; Value: OLInteger); inline;
    /// <summary>
    ///   Deletes the item at the specified index.
    /// </summary>
    procedure Delete(Index: Integer); inline;
    /// <summary>
    ///   Clears the array.
    /// </summary>
    procedure Clear; inline;
    /// <summary>
    ///   Sorts the array in-place.
    /// </summary>
    procedure Sort; // In-place
    /// <summary>
    ///   Returns a new sorted copy of the array.
    /// </summary>
    function Sorted: OLIntegerArray; // Copy
    /// <summary>
    ///   Returns the index of the last item.
    /// </summary>
    function LastItemIndex: Integer; inline;
    /// <summary>
    ///   Checks if the array contains the specified value.
    /// </summary>
    function ContainsValue(v: OLInteger): Boolean;
    /// <summary>
    ///   Returns a new array with distinct values.
    /// </summary>
    function Distinct: OLIntegerArray;
    /// <summary>
    ///   Returns a new reversed copy of the array.
    /// </summary>
    function Reversed: OLIntegerArray;
    /// <summary>
    ///   Gets the enumerator for the array.
    /// </summary>
    function GetEnumerator: TEnumerator<OLInteger>;

    /// <summary>
    ///   Implicit conversion from array of Integer to OLIntegerArray.
    /// </summary>
    class operator Implicit(const A: array of Integer): OLIntegerArray; overload;
    /// <summary>
    ///   Implicit conversion from OLIntegerArray to TOLIntegerDynArray.
    /// </summary>
    class operator Implicit(const A: OLIntegerArray): TOLIntegerDynArray; overload;
    /// <summary>
    ///   Implicit conversion from TArray<Integer> to OLIntegerArray.
    /// </summary>
    class operator Implicit(const A: TArray<Integer>): OLIntegerArray; overload;
    /// <summary>
    ///   Implicit conversion from OLIntegerArray to TArray<Integer>.
    /// </summary>
    class operator Implicit(const A: OLIntegerArray): TArray<Integer>; overload;
  end;

  // --- OLStringArray ---
  /// <summary>
  ///   Array wrapper for OLString.
  /// </summary>
  OLStringArray = record
  private
    FEngine: OLArray<OLString>;
    function GetItems(Index: Integer): OLString; inline;
    function GetLength: Integer; inline;
    procedure SetItems(Index: Integer; const Value: OLString); inline;
    procedure SetLength(const Value: Integer); inline;
  public
    /// <summary>
    ///   Gets or sets the item at the specified index.
    /// </summary>
    property Items[Index: Integer]: OLString read GetItems write SetItems; default;
    /// <summary>
    ///   Gets or sets the length of the array.
    /// </summary>
    property Length: Integer read GetLength write SetLength;

    /// <summary>
    ///   Adds a value to the end of the array.
    /// </summary>
    procedure Add(Value: OLString); inline;
    /// <summary>
    ///   Inserts a value at the specified index.
    /// </summary>
    procedure Insert(AtIndex: Integer; Value: OLString); inline;
    /// <summary>
    ///   Deletes the item at the specified index.
    /// </summary>
    procedure Delete(Index: Integer); inline;
    /// <summary>
    ///   Clears the array.
    /// </summary>
    procedure Clear; inline;
    /// <summary>
    ///   Sorts the array in-place.
    /// </summary>
    procedure Sort;
    /// <summary>
    ///   Returns a new sorted copy of the array.
    /// </summary>
    function Sorted: OLStringArray;
    /// <summary>
    ///   Returns the index of the last item.
    /// </summary>
    function LastItemIndex: Integer; inline;
    /// <summary>
    ///   Checks if the array contains the specified value.
    /// </summary>
    function ContainsValue(v: OLString): Boolean;
    /// <summary>
    ///   Returns a new array with distinct values.
    /// </summary>
    function Distinct: OLStringArray;
    /// <summary>
    ///   Returns a new reversed copy of the array.
    /// </summary>
    function Reversed: OLStringArray;
    /// <summary>
    ///   Gets the enumerator for the array.
    /// </summary>
    function GetEnumerator: TEnumerator<OLString>;

    /// <summary>
    ///   Implicit conversion from array of string to OLStringArray.
    /// </summary>
    class operator Implicit(const A: array of string): OLStringArray; overload;
    /// <summary>
    ///   Implicit conversion from OLStringArray to TOLStringDynArray.
    /// </summary>
    class operator Implicit(const A: OLStringArray): TOLStringDynArray; overload;
    /// <summary>
    ///   Implicit conversion from TArray<string> to OLStringArray.
    /// </summary>
    class operator Implicit(const A: TArray<string>): OLStringArray; overload;
    /// <summary>
    ///   Implicit conversion from OLStringArray to TArray<string>.
    /// </summary>
    class operator Implicit(const A: OLStringArray): TArray<string>; overload;
  end;

  // --- OLBooleanArray ---
  /// <summary>
  ///   Array wrapper for OLBoolean.
  /// </summary>
  OLBooleanArray = record
  private
    FEngine: OLArray<OLBoolean>;
    function GetItems(Index: Integer): OLBoolean; inline;
    function GetLength: Integer; inline;
    procedure SetItems(Index: Integer; const Value: OLBoolean); inline;
    procedure SetLength(const Value: Integer); inline;
  public
    /// <summary>
    ///   Gets or sets the item at the specified index.
    /// </summary>
    property Items[Index: Integer]: OLBoolean read GetItems write SetItems; default;
    /// <summary>
    ///   Gets or sets the length of the array.
    /// </summary>
    property Length: Integer read GetLength write SetLength;

    /// <summary>
    ///   Adds a value to the end of the array.
    /// </summary>
    procedure Add(Value: OLBoolean); inline;
    /// <summary>
    ///   Inserts a value at the specified index.
    /// </summary>
    procedure Insert(AtIndex: Integer; Value: OLBoolean); inline;
    /// <summary>
    ///   Deletes the item at the specified index.
    /// </summary>
    procedure Delete(Index: Integer); inline;
    /// <summary>
    ///   Clears the array.
    /// </summary>
    procedure Clear; inline;
    /// <summary>
    ///   Sorts the array in-place.
    /// </summary>
    procedure Sort;
    /// <summary>
    ///   Returns a new sorted copy of the array.
    /// </summary>
    function Sorted: OLBooleanArray;
    /// <summary>
    ///   Returns the index of the last item.
    /// </summary>
    function LastItemIndex: Integer; inline;
    /// <summary>
    ///   Checks if the array contains the specified value.
    /// </summary>
    function ContainsValue(v: OLBoolean): Boolean;
    /// <summary>
    ///   Returns a new array with distinct values.
    /// </summary>
    function Distinct: OLBooleanArray;
    /// <summary>
    ///   Returns a new reversed copy of the array.
    /// </summary>
    function Reversed: OLBooleanArray;
    /// <summary>
    ///   Gets the enumerator for the array.
    /// </summary>
    function GetEnumerator: TEnumerator<OLBoolean>;

    /// <summary>
    ///   Implicit conversion from array of Boolean to OLBooleanArray.
    /// </summary>
    class operator Implicit(const A: array of Boolean): OLBooleanArray; overload;
    /// <summary>
    ///   Implicit conversion from OLBooleanArray to TOLBooleanDynArray.
    /// </summary>
    class operator Implicit(const A: OLBooleanArray): TOLBooleanDynArray; overload;
    /// <summary>
    ///   Implicit conversion from TArray<Boolean> to OLBooleanArray.
    /// </summary>
    class operator Implicit(const A: TArray<Boolean>): OLBooleanArray; overload;
    /// <summary>
    ///   Implicit conversion from OLBooleanArray to TArray<Boolean>.
    /// </summary>
    class operator Implicit(const A: OLBooleanArray): TArray<Boolean>; overload;
  end;

  // --- OLCurrencyArray ---
  /// <summary>
  ///   Array wrapper for OLCurrency.
  /// </summary>
  OLCurrencyArray = record
  private
    FEngine: OLArray<OLCurrency>;
    function GetItems(Index: Integer): OLCurrency; inline;
    function GetLength: Integer; inline;
    procedure SetItems(Index: Integer; const Value: OLCurrency); inline;
    procedure SetLength(const Value: Integer); inline;
  public
    /// <summary>
    ///   Gets or sets the item at the specified index.
    /// </summary>
    property Items[Index: Integer]: OLCurrency read GetItems write SetItems; default;
    /// <summary>
    ///   Gets or sets the length of the array.
    /// </summary>
    property Length: Integer read GetLength write SetLength;

    /// <summary>
    ///   Adds a value to the end of the array.
    /// </summary>
    procedure Add(Value: OLCurrency); inline;
    /// <summary>
    ///   Inserts a value at the specified index.
    /// </summary>
    procedure Insert(AtIndex: Integer; Value: OLCurrency); inline;
    /// <summary>
    ///   Deletes the item at the specified index.
    /// </summary>
    procedure Delete(Index: Integer); inline;
    /// <summary>
    ///   Clears the array.
    /// </summary>
    procedure Clear; inline;
    /// <summary>
    ///   Sorts the array in-place.
    /// </summary>
    procedure Sort;
    /// <summary>
    ///   Returns a new sorted copy of the array.
    /// </summary>
    function Sorted: OLCurrencyArray;
    /// <summary>
    ///   Returns the index of the last item.
    /// </summary>
    function LastItemIndex: Integer; inline;
    /// <summary>
    ///   Checks if the array contains the specified value.
    /// </summary>
    function ContainsValue(v: OLCurrency): Boolean;
    /// <summary>
    ///   Returns a new array with distinct values.
    /// </summary>
    function Distinct: OLCurrencyArray;
    /// <summary>
    ///   Returns a new reversed copy of the array.
    /// </summary>
    function Reversed: OLCurrencyArray;
    /// <summary>
    ///   Gets the enumerator for the array.
    /// </summary>
    function GetEnumerator: TEnumerator<OLCurrency>;

    /// <summary>
    ///   Implicit conversion from array of Currency to OLCurrencyArray.
    /// </summary>
    class operator Implicit(const A: array of Currency): OLCurrencyArray; overload;
    /// <summary>
    ///   Implicit conversion from OLCurrencyArray to TOLCurrencyDynArray.
    /// </summary>
    class operator Implicit(const A: OLCurrencyArray): TOLCurrencyDynArray; overload;
    /// <summary>
    ///   Implicit conversion from TArray<Currency> to OLCurrencyArray.
    /// </summary>
    class operator Implicit(const A: TArray<Currency>): OLCurrencyArray; overload;
    /// <summary>
    ///   Implicit conversion from OLCurrencyArray to TArray<Currency>.
    /// </summary>
    class operator Implicit(const A: OLCurrencyArray): TArray<Currency>; overload;
  end;

  // --- OLDateTimeArray ---
  /// <summary>
  ///   Array wrapper for OLDateTime.
  /// </summary>
  OLDateTimeArray = record
  private
    FEngine: OLArray<OLDateTime>;
    function GetItems(Index: Integer): OLDateTime; inline;
    function GetLength: Integer; inline;
    procedure SetItems(Index: Integer; const Value: OLDateTime); inline;
    procedure SetLength(const Value: Integer); inline;
  public
    /// <summary>
    ///   Gets or sets the item at the specified index.
    /// </summary>
    property Items[Index: Integer]: OLDateTime read GetItems write SetItems; default;
    /// <summary>
    ///   Gets or sets the length of the array.
    /// </summary>
    property Length: Integer read GetLength write SetLength;

    /// <summary>
    ///   Adds a value to the end of the array.
    /// </summary>
    procedure Add(Value: OLDateTime); inline;
    /// <summary>
    ///   Inserts a value at the specified index.
    /// </summary>
    procedure Insert(AtIndex: Integer; Value: OLDateTime); inline;
    /// <summary>
    ///   Deletes the item at the specified index.
    /// </summary>
    procedure Delete(Index: Integer); inline;
    /// <summary>
    ///   Clears the array.
    /// </summary>
    procedure Clear; inline;
    /// <summary>
    ///   Sorts the array in-place.
    /// </summary>
    procedure Sort;
    /// <summary>
    ///   Returns a new sorted copy of the array.
    /// </summary>
    function Sorted: OLDateTimeArray;
    /// <summary>
    ///   Returns the index of the last item.
    /// </summary>
    function LastItemIndex: Integer; inline;
    /// <summary>
    ///   Checks if the array contains the specified value.
    /// </summary>
    function ContainsValue(v: OLDateTime): Boolean;
    /// <summary>
    ///   Returns a new array with distinct values.
    /// </summary>
    function Distinct: OLDateTimeArray;
    /// <summary>
    ///   Returns a new reversed copy of the array.
    /// </summary>
    function Reversed: OLDateTimeArray;
    /// <summary>
    ///   Gets the enumerator for the array.
    /// </summary>
    function GetEnumerator: TEnumerator<OLDateTime>;

    /// <summary>
    ///   Implicit conversion from array of TDateTime to OLDateTimeArray.
    /// </summary>
    class operator Implicit(const A: array of TDateTime): OLDateTimeArray; overload;
    /// <summary>
    ///   Implicit conversion from OLDateTimeArray to TOLDateTimeDynArray.
    /// </summary>
    class operator Implicit(const A: OLDateTimeArray): TOLDateTimeDynArray; overload;
    /// <summary>
    ///   Implicit conversion from TArray<TDateTime> to OLDateTimeArray.
    /// </summary>
    class operator Implicit(const A: TArray<TDateTime>): OLDateTimeArray; overload;
    /// <summary>
    ///   Implicit conversion from OLDateTimeArray to TArray<TDateTime>.
    /// </summary>
    class operator Implicit(const A: OLDateTimeArray): TArray<TDateTime>; overload;
  end;

  // --- OLDateArray ---
  /// <summary>
  ///   Array wrapper for OLDate.
  /// </summary>
  OLDateArray = record
  private
    FEngine: OLArray<OLDate>;
    function GetItems(Index: Integer): OLDate; inline;
    function GetLength: Integer; inline;
    procedure SetItems(Index: Integer; const Value: OLDate); inline;
    procedure SetLength(const Value: Integer); inline;
  public
    /// <summary>
    ///   Gets or sets the item at the specified index.
    /// </summary>
    property Items[Index: Integer]: OLDate read GetItems write SetItems; default;
    /// <summary>
    ///   Gets or sets the length of the array.
    /// </summary>
    property Length: Integer read GetLength write SetLength;

    /// <summary>
    ///   Adds a value to the end of the array.
    /// </summary>
    procedure Add(Value: OLDate); inline;
    /// <summary>
    ///   Inserts a value at the specified index.
    /// </summary>
    procedure Insert(AtIndex: Integer; Value: OLDate); inline;
    /// <summary>
    ///   Deletes the item at the specified index.
    /// </summary>
    procedure Delete(Index: Integer); inline;
    /// <summary>
    ///   Clears the array.
    /// </summary>
    procedure Clear; inline;
    /// <summary>
    ///   Sorts the array in-place.
    /// </summary>
    procedure Sort;
    /// <summary>
    ///   Returns a new sorted copy of the array.
    /// </summary>
    function Sorted: OLDateArray;
    /// <summary>
    ///   Returns the index of the last item.
    /// </summary>
    function LastItemIndex: Integer; inline;
    /// <summary>
    ///   Checks if the array contains the specified value.
    /// </summary>
    function ContainsValue(v: OLDate): Boolean;
    /// <summary>
    ///   Returns a new array with distinct values.
    /// </summary>
    function Distinct: OLDateArray;
    /// <summary>
    ///   Returns a new reversed copy of the array.
    /// </summary>
    function Reversed: OLDateArray;
    /// <summary>
    ///   Gets the enumerator for the array.
    /// </summary>
    function GetEnumerator: TEnumerator<OLDate>;

    /// <summary>
    ///   Implicit conversion from array of TDate to OLDateArray.
    /// </summary>
    class operator Implicit(const A: array of TDate): OLDateArray; overload;
    /// <summary>
    ///   Implicit conversion from OLDateArray to TOLDateDynArray.
    /// </summary>
    class operator Implicit(const A: OLDateArray): TOLDateDynArray; overload;
    /// <summary>
    ///   Implicit conversion from TArray<TDate> to OLDateArray.
    /// </summary>
    class operator Implicit(const A: TArray<TDate>): OLDateArray; overload;
    /// <summary>
    ///   Implicit conversion from OLDateArray to TArray<TDate>.
    /// </summary>
    class operator Implicit(const A: OLDateArray): TArray<TDate>; overload;
  end;

  // --- OLDoubleArray ---
  /// <summary>
  ///   Array wrapper for OLDouble.
  /// </summary>
  OLDoubleArray = record
  private
    FEngine: OLArray<OLDouble>;
    function GetItems(Index: Integer): OLDouble; inline;
    function GetLength: Integer; inline;
    procedure SetItems(Index: Integer; const Value: OLDouble); inline;
    procedure SetLength(const Value: Integer); inline;
  public
    /// <summary>
    ///   Gets or sets the item at the specified index.
    /// </summary>
    property Items[Index: Integer]: OLDouble read GetItems write SetItems; default;
    /// <summary>
    ///   Gets or sets the length of the array.
    /// </summary>
    property Length: Integer read GetLength write SetLength;

    /// <summary>
    ///   Adds a value to the end of the array.
    /// </summary>
    procedure Add(Value: OLDouble); inline;
    /// <summary>
    ///   Inserts a value at the specified index.
    /// </summary>
    procedure Insert(AtIndex: Integer; Value: OLDouble); inline;
    /// <summary>
    ///   Deletes the item at the specified index.
    /// </summary>
    procedure Delete(Index: Integer); inline;
    /// <summary>
    ///   Clears the array.
    /// </summary>
    procedure Clear; inline;
    /// <summary>
    ///   Sorts the array in-place.
    /// </summary>
    procedure Sort;
    /// <summary>
    ///   Returns a new sorted copy of the array.
    /// </summary>
    function Sorted: OLDoubleArray;
    /// <summary>
    ///   Returns the index of the last item.
    /// </summary>
    function LastItemIndex: Integer; inline;
    /// <summary>
    ///   Checks if the array contains the specified value.
    /// </summary>
    function ContainsValue(v: OLDouble): Boolean;
    /// <summary>
    ///   Returns a new array with distinct values.
    /// </summary>
    function Distinct: OLDoubleArray;
    /// <summary>
    ///   Returns a new reversed copy of the array.
    /// </summary>
    function Reversed: OLDoubleArray;
    /// <summary>
    ///   Gets the enumerator for the array.
    /// </summary>
    function GetEnumerator: TEnumerator<OLDouble>;

    /// <summary>
    ///   Implicit conversion from array of Double to OLDoubleArray.
    /// </summary>
    class operator Implicit(const A: array of Double): OLDoubleArray; overload;
    /// <summary>
    ///   Implicit conversion from OLDoubleArray to TOLDoubleDynArray.
    /// </summary>
    class operator Implicit(const A: OLDoubleArray): TOLDoubleDynArray; overload;
    /// <summary>
    ///   Implicit conversion from TArray<Double> to OLDoubleArray.
    /// </summary>
    class operator Implicit(const A: TArray<Double>): OLDoubleArray; overload;
    /// <summary>
    ///   Implicit conversion from OLDoubleArray to TArray<Double>.
    /// </summary>
    class operator Implicit(const A: OLDoubleArray): TArray<Double>; overload;
  end;

  // --- OLInt64Array ---
  /// <summary>
  ///   Array wrapper for OLInt64.
  /// </summary>
  OLInt64Array = record
  private
    FEngine: OLArray<OLInt64>;
    function GetItems(Index: Integer): OLInt64; inline;
    function GetLength: Integer; inline;
    procedure SetItems(Index: Integer; const Value: OLInt64); inline;
    procedure SetLength(const Value: Integer); inline;
  public
    /// <summary>
    ///   Gets or sets the item at the specified index.
    /// </summary>
    property Items[Index: Integer]: OLInt64 read GetItems write SetItems; default;
    /// <summary>
    ///   Gets or sets the length of the array.
    /// </summary>
    property Length: Integer read GetLength write SetLength;

    /// <summary>
    ///   Adds a value to the end of the array.
    /// </summary>
    procedure Add(Value: OLInt64); inline;
    /// <summary>
    ///   Inserts a value at the specified index.
    /// </summary>
    procedure Insert(AtIndex: Integer; Value: OLInt64); inline;
    /// <summary>
    ///   Deletes the item at the specified index.
    /// </summary>
    procedure Delete(Index: Integer); inline;
    /// <summary>
    ///   Clears the array.
    /// </summary>
    procedure Clear; inline;
    /// <summary>
    ///   Sorts the array in-place.
    /// </summary>
    procedure Sort;
    /// <summary>
    ///   Returns a new sorted copy of the array.
    /// </summary>
    function Sorted: OLInt64Array;
    /// <summary>
    ///   Returns the index of the last item.
    /// </summary>
    function LastItemIndex: Integer; inline;
    /// <summary>
    ///   Checks if the array contains the specified value.
    /// </summary>
    function ContainsValue(v: OLInt64): Boolean;
    /// <summary>
    ///   Returns a new array with distinct values.
    /// </summary>
    function Distinct: OLInt64Array;
    /// <summary>
    ///   Returns a new reversed copy of the array.
    /// </summary>
    function Reversed: OLInt64Array;
    /// <summary>
    ///   Gets the enumerator for the array.
    /// </summary>
    function GetEnumerator: TEnumerator<OLInt64>;

    /// <summary>
    ///   Implicit conversion from array of Int64 to OLInt64Array.
    /// </summary>
    class operator Implicit(const A: array of Int64): OLInt64Array; overload;
    /// <summary>
    ///   Implicit conversion from OLInt64Array to TOLInt64DynArray.
    /// </summary>
    class operator Implicit(const A: OLInt64Array): TOLInt64DynArray; overload;
    /// <summary>
    ///   Implicit conversion from TArray<Int64> to OLInt64Array.
    /// </summary>
    class operator Implicit(const A: TArray<Int64>): OLInt64Array; overload;
    /// <summary>
    ///   Implicit conversion from OLInt64Array to TArray<Int64>.
    /// </summary>
    class operator Implicit(const A: OLInt64Array): TArray<Int64>; overload;
  end;

  OLByteArray = OLArray<Byte>;

implementation

{ TEnumerator<T> }

constructor TEnumerator<T>.Create(const AItems: TArray<T>);
begin
  FItems := AItems;
  FIndex := -1;
end;

function TEnumerator<T>.GetCurrent: T;
begin
  Result := FItems[FIndex];
end;

function TEnumerator<T>.MoveNext: Boolean;
begin
  Inc(FIndex);
  Result := FIndex < System.Length(FItems);
end;

{ OLArray<T> - GENERIC ENGINE }

procedure OLArray<T>.Add(const Value: T);
begin
  System.SetLength(arr, System.Length(arr) + 1);
  arr[High(arr)] := Value;
  FSorted := False;
end;

procedure OLArray<T>.Sort;
begin
  if System.Length(arr) > 1 then
  begin
    MakeUnique();
    TArray.Sort<T>(arr);
  end;

  FSorted := True;
end;

function OLArray<T>.Sorted: OLArray<T>;
begin
  {$IF CompilerVersion >= 24.0}
    // XE3+ → Copy works correctly for generic dynamic arrays
    Result.arr := System.Copy(Self.arr);
  {$ELSE}
    // Older Delphi versions: manual array copy required
    if System.Length(Self.arr) > 0 then
    begin
      System.SetLength(Result.arr, System.Length(Self.arr));
      System.Move(Self.arr[0], Result.arr[0], System.Length(Self.arr));
    end
    else
      System.SetLength(Result.arr, 0);
  {$IFEND}

  TArray.Sort<T>(Result.arr);
  Result.FSorted := True;
end;

function OLArray<T>.ContainsValue(const v: T): Boolean;
var
  Comparer: IEqualityComparer<T>;
  Item: T;
  FoundIndex: Integer;
begin
  // OPTIMIZATION: If sorted -> Binary Search (O(log N))
  if FSorted then
  begin
    Result := TArray.BinarySearch<T>(arr, v, FoundIndex, TComparer<T>.Default);
    Exit;
  end;

  // If not -> Linear (O(N))
  Comparer := TEqualityComparer<T>.Default;
  Result := False;
  for Item in arr do
  begin
    if Comparer.Equals(Item, v) then
      Exit(True);
  end;
end;

procedure OLArray<T>.Delete(Index: Integer);
var
  Len: Integer;
  i: Integer;
begin
  Len := System.Length(arr);
  if (Index < 0) or (Index >= Len) then Exit;

  MakeUnique();

  // [FIX] Use loop to shift elements safely (compiler handles refcounting)
  for i := Index to Len - 2 do
    arr[i] := arr[i + 1];

  System.SetLength(arr, Len - 1);
end;

function OLArray<T>.Distinct(const Comparer: IEqualityComparer<T>): OLArray<T>;
var
  Dict: TDictionary<T, Byte>;
  Item: T;
  ActualComparer: IEqualityComparer<T>;
begin
  Result.Clear;
  if System.Length(arr) = 0 then Exit;

  if Comparer <> nil then
    ActualComparer := Comparer
  else
    ActualComparer := TEqualityComparer<T>.Default;

  Dict := TDictionary<T, Byte>.Create(System.Length(arr), ActualComparer);
  try
    for Item in arr do
    begin
      if not Dict.ContainsKey(Item) then
      begin
        Dict.Add(Item, 0);
        Result.Add(Item);
      end;
    end;
  finally
    Dict.Free;
  end;
end;

function OLArray<T>.Reversed: OLArray<T>;
var
  i: Integer;
begin
  System.SetLength(Result.arr, System.Length(arr));
  for i := 0 to High(arr) do
    Result.arr[i] := arr[High(arr) - i];
  Result.FSorted := False;
end;

function OLArray<T>.GetEnumerator: TEnumerator<T>;
begin
  Result := TEnumerator<T>.Create(arr);
end;

function OLArray<T>.GetItems(Index: Integer): T;
begin
  Result := arr[Index];
end;

function OLArray<T>.GetLength: Integer;
begin
  Result := System.Length(arr);
end;

class operator OLArray<T>.Implicit(const A: OLArray<T>): TArray<T>;
begin
  Result := System.Copy(A.arr);
end;

procedure OLArray<T>.Insert(AtIndex: Integer; const Value: T);
var
  Len: Integer;
  i: Integer;
begin
  Len := System.Length(arr);
  System.SetLength(arr, Len + 1);
  if AtIndex < Len then
  begin
    // [FIX] Use loop to shift elements safely (compiler handles refcounting)
    for i := Len - 1 downto AtIndex do
      arr[i + 1] := arr[i];
  end;
  
  arr[AtIndex] := Value;
  FSorted := False;
end;

function OLArray<T>.LastItemIndex: Integer;
begin
  Result := System.Length(arr) - 1;
end;

// [Copy-On-Write ENFORCER]
// This line appears redundant but is crucial.
// It forces the Run-Time Library (RTL) to check the Reference Count (RefCount).
// If the internal dynamic array ('arr') is shared with another variable (e.g., after B := A),
// SetLength will trigger the Copy-On-Write (COW) mechanism, creating a Deep Copy for this instance.
// IT GUARANTEES that we modify our own memory block, preventing unwanted side effects on shared copies.
procedure OLArray<T>.MakeUnique;
begin
  System.SetLength(arr, System.Length(arr));
end;

procedure OLArray<T>.SetItems(Index: Integer; const Value: T);
begin
  if System.Length(arr) <= Index then
    System.SetLength(arr, Index + 1)
  else
    MakeUnique();
  arr[Index] := Value;
  FSorted := False;
end;

procedure OLArray<T>.SetLength(const Value: Integer);
begin
  System.SetLength(arr, Value);
  FSorted := False;
end;

procedure OLArray<T>.Clear;
begin
  System.SetLength(arr, 0);
  FSorted := True;
end;

class operator OLArray<T>.Implicit(const A: TArray<T>): OLArray<T>;
begin
  Result.arr := System.Copy(A);
  Result.FSorted := False;
end;

{ ========================================================================== }
{ WRAPPER IMPLEMENTATION (CONCRETE TYPES)                                }
{ ========================================================================== }

// Helper macro-like structure to implement standard proxy methods
// (Unfortunately in Pascal this has to be written out manually for each type)

// --- OLIntegerArray ---
procedure OLIntegerArray.Add(Value: OLInteger); begin FEngine.Add(Value); end;
procedure OLIntegerArray.Clear; begin FEngine.Clear; end;
function OLIntegerArray.ContainsValue(v: OLInteger): Boolean;
var
  i: Integer;
  FoundIndex: Integer;
begin
  if FEngine.IsSorted then
  begin
    Result := TArray.BinarySearch<OLInteger>(FEngine.arr, v, FoundIndex, TComparer<OLInteger>.Construct(
      function(const Left, Right: OLInteger): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end
  else
  begin
    Result := False;
    for i := 0 to FEngine.Length - 1 do
    begin
      if FEngine.Items[i] = v then
        Exit(True);
    end;
  end;
end;
procedure OLIntegerArray.Delete(Index: Integer); begin FEngine.Delete(Index); end;
function OLIntegerArray.Distinct: OLIntegerArray;
begin
  Result.FEngine := FEngine.Distinct(TEqualityComparer<OLInteger>.Construct(
    function(const Left, Right: OLInteger): Boolean
    begin
      Result := Left = Right;
    end,
    function(const Value: OLInteger): Integer
    begin
      Result := Value.AsInteger(0);
    end
  ));
end;
function OLIntegerArray.GetEnumerator: TEnumerator<OLInteger>; begin Result := FEngine.GetEnumerator; end;
function OLIntegerArray.GetItems(Index: Integer): OLInteger; begin Result := FEngine.Items[Index]; end;
function OLIntegerArray.GetLength: Integer; begin Result := FEngine.Length; end;
procedure OLIntegerArray.Insert(AtIndex: Integer; Value: OLInteger); begin FEngine.Insert(AtIndex, Value); end;
function OLIntegerArray.LastItemIndex: Integer; begin Result := FEngine.LastItemIndex; end;
function OLIntegerArray.Reversed: OLIntegerArray; begin Result.FEngine := FEngine.Reversed; end;
procedure OLIntegerArray.SetItems(Index: Integer; const Value: OLInteger); begin FEngine.Items[Index] := Value; end;
procedure OLIntegerArray.SetLength(const Value: Integer); begin FEngine.Length := Value; end;
procedure OLIntegerArray.Sort;
begin
  if FEngine.Length > 1 then
  begin
    FEngine.MakeUnique();
    TArray.Sort<OLInteger>(FEngine.arr, TComparer<OLInteger>.Construct(
      function(const Left, Right: OLInteger): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end;
  FEngine.FSorted := True;
end;
function OLIntegerArray.Sorted: OLIntegerArray;
begin
  Result.FEngine := FEngine; // Copy engine (triggers COW if modified later, but Sort modifies in place so we need a copy first)
  // Wait, FEngine assignment copies the record structure (arr ref).
  // We need a deep copy of the array for the new instance before sorting?
  // Actually, Result.Sort will call MakeUnique internally if needed?
  // Let's check FEngine.Sort implementation. It calls MakeUnique.
  // But here we are calling OLIntegerArray.Sort which calls FEngine.MakeUnique.
  // So:
  Result.FEngine := FEngine; // Shallow copy of record
  Result.Sort; // Will trigger MakeUnique inside Sort because we are modifying Result's array
end;

class operator OLIntegerArray.Implicit(const A: array of Integer): OLIntegerArray;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLIntegerArray.Implicit(const A: OLIntegerArray): TOLIntegerDynArray;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;
class operator OLIntegerArray.Implicit(const A: TArray<Integer>): OLIntegerArray;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLIntegerArray.Implicit(const A: OLIntegerArray): TArray<Integer>;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;

// --- OLStringArray ---
procedure OLStringArray.Add(Value: OLString); begin FEngine.Add(Value); end;
procedure OLStringArray.Clear; begin FEngine.Clear; end;
function OLStringArray.ContainsValue(v: OLString): Boolean;
var
  i: Integer;
  FoundIndex: Integer;
begin
  if FEngine.IsSorted then
  begin
    Result := TArray.BinarySearch<OLString>(FEngine.arr, v, FoundIndex, TComparer<OLString>.Construct(
      function(const Left, Right: OLString): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end
  else
  begin
    Result := False;
    for i := 0 to FEngine.Length - 1 do
    begin
      if FEngine.Items[i] = v then
        Exit(True);
    end;
  end;
end;
procedure OLStringArray.Delete(Index: Integer); begin FEngine.Delete(Index); end;
function OLStringArray.Distinct: OLStringArray;
begin
  Result.FEngine := FEngine.Distinct(TEqualityComparer<OLString>.Construct(
    function(const Left, Right: OLString): Boolean
    begin
      Result := Left = Right;
    end,
    function(const Value: OLString): Integer
    begin
      Result := TEqualityComparer<string>.Default.GetHashCode(Value.ToString);
    end
  ));
end;
function OLStringArray.GetEnumerator: TEnumerator<OLString>; begin Result := FEngine.GetEnumerator; end;
function OLStringArray.GetItems(Index: Integer): OLString; begin Result := FEngine.Items[Index]; end;
function OLStringArray.GetLength: Integer; begin Result := FEngine.Length; end;
procedure OLStringArray.Insert(AtIndex: Integer; Value: OLString); begin FEngine.Insert(AtIndex, Value); end;
function OLStringArray.LastItemIndex: Integer; begin Result := FEngine.LastItemIndex; end;
function OLStringArray.Reversed: OLStringArray; begin Result.FEngine := FEngine.Reversed; end;
procedure OLStringArray.SetItems(Index: Integer; const Value: OLString); begin FEngine.Items[Index] := Value; end;
procedure OLStringArray.SetLength(const Value: Integer); begin FEngine.Length := Value; end;
procedure OLStringArray.Sort;
begin
  if FEngine.Length > 1 then
  begin
    FEngine.MakeUnique();
    TArray.Sort<OLString>(FEngine.arr, TComparer<OLString>.Construct(
      function(const Left, Right: OLString): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end;
  FEngine.FSorted := True;
end;

function OLStringArray.Sorted: OLStringArray;
begin
  Result.FEngine := FEngine;
  Result.Sort;
end;

class operator OLStringArray.Implicit(const A: array of string): OLStringArray;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLStringArray.Implicit(const A: OLStringArray): TOLStringDynArray;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;
class operator OLStringArray.Implicit(const A: TArray<string>): OLStringArray;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLStringArray.Implicit(const A: OLStringArray): TArray<string>;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;

// --- OLBooleanArray ---
procedure OLBooleanArray.Add(Value: OLBoolean); begin FEngine.Add(Value); end;
procedure OLBooleanArray.Clear; begin FEngine.Clear; end;
function OLBooleanArray.ContainsValue(v: OLBoolean): Boolean;
var
  i: Integer;
  FoundIndex: Integer;
begin
  if FEngine.IsSorted then
  begin
    Result := TArray.BinarySearch<OLBoolean>(FEngine.arr, v, FoundIndex, TComparer<OLBoolean>.Construct(
      function(const Left, Right: OLBoolean): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end
  else
  begin
    Result := False;
    for i := 0 to FEngine.Length - 1 do
    begin
      if FEngine.Items[i] = v then
        Exit(True);
    end;
  end;
end;
procedure OLBooleanArray.Delete(Index: Integer); begin FEngine.Delete(Index); end;
function OLBooleanArray.Distinct: OLBooleanArray;
begin
  Result.FEngine := FEngine.Distinct(TEqualityComparer<OLBoolean>.Construct(
    function(const Left, Right: OLBoolean): Boolean
    begin
      Result := Left = Right;
    end,
    function(const Value: OLBoolean): Integer
    begin
      if Value.IsNull then Result := 0
      else Result := TEqualityComparer<Boolean>.Default.GetHashCode(Boolean(Value));
    end
  ));
end;
function OLBooleanArray.GetEnumerator: TEnumerator<OLBoolean>; begin Result := FEngine.GetEnumerator; end;
function OLBooleanArray.GetItems(Index: Integer): OLBoolean; begin Result := FEngine.Items[Index]; end;
function OLBooleanArray.GetLength: Integer; begin Result := FEngine.Length; end;
procedure OLBooleanArray.Insert(AtIndex: Integer; Value: OLBoolean); begin FEngine.Insert(AtIndex, Value); end;
function OLBooleanArray.LastItemIndex: Integer; begin Result := FEngine.LastItemIndex; end;
function OLBooleanArray.Reversed: OLBooleanArray; begin Result.FEngine := FEngine.Reversed; end;
procedure OLBooleanArray.SetItems(Index: Integer; const Value: OLBoolean); begin FEngine.Items[Index] := Value; end;
procedure OLBooleanArray.SetLength(const Value: Integer); begin FEngine.Length := Value; end;
procedure OLBooleanArray.Sort;
begin
  if FEngine.Length > 1 then
  begin
    FEngine.MakeUnique();
    TArray.Sort<OLBoolean>(FEngine.arr, TComparer<OLBoolean>.Construct(
      function(const Left, Right: OLBoolean): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end;
  FEngine.FSorted := True;
end;
function OLBooleanArray.Sorted: OLBooleanArray;
begin
  Result.FEngine := FEngine;
  Result.Sort;
end;

class operator OLBooleanArray.Implicit(const A: array of Boolean): OLBooleanArray;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLBooleanArray.Implicit(const A: OLBooleanArray): TOLBooleanDynArray;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;
class operator OLBooleanArray.Implicit(const A: TArray<Boolean>): OLBooleanArray;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLBooleanArray.Implicit(const A: OLBooleanArray): TArray<Boolean>;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;

// --- OLCurrencyArray ---
procedure OLCurrencyArray.Add(Value: OLCurrency); begin FEngine.Add(Value); end;
procedure OLCurrencyArray.Clear; begin FEngine.Clear; end;
function OLCurrencyArray.ContainsValue(v: OLCurrency): Boolean;
var
  i: Integer;
  FoundIndex: Integer;
begin
  if FEngine.IsSorted then
  begin
    Result := TArray.BinarySearch<OLCurrency>(FEngine.arr, v, FoundIndex, TComparer<OLCurrency>.Construct(
      function(const Left, Right: OLCurrency): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end
  else
  begin
    Result := False;
    for i := 0 to FEngine.Length - 1 do
    begin
      if FEngine.Items[i] = v then
        Exit(True);
    end;
  end;
end;

procedure OLCurrencyArray.Delete(Index: Integer); begin FEngine.Delete(Index); end;
function OLCurrencyArray.Distinct: OLCurrencyArray;
begin
  Result.FEngine := FEngine.Distinct(TEqualityComparer<OLCurrency>.Construct(
    function(const Left, Right: OLCurrency): Boolean
    begin
      Result := Left = Right;
    end,
    function(const Value: OLCurrency): Integer
    begin
      if Value.IsNull then Result := 0
      else Result := TEqualityComparer<Currency>.Default.GetHashCode(Currency(Value));
    end
  ));
end;
function OLCurrencyArray.GetEnumerator: TEnumerator<OLCurrency>; begin Result := FEngine.GetEnumerator; end;
function OLCurrencyArray.GetItems(Index: Integer): OLCurrency; begin Result := FEngine.Items[Index]; end;
function OLCurrencyArray.GetLength: Integer; begin Result := FEngine.Length; end;
procedure OLCurrencyArray.Insert(AtIndex: Integer; Value: OLCurrency); begin FEngine.Insert(AtIndex, Value); end;
function OLCurrencyArray.LastItemIndex: Integer; begin Result := FEngine.LastItemIndex; end;
function OLCurrencyArray.Reversed: OLCurrencyArray; begin Result.FEngine := FEngine.Reversed; end;
procedure OLCurrencyArray.SetItems(Index: Integer; const Value: OLCurrency); begin FEngine.Items[Index] := Value; end;
procedure OLCurrencyArray.SetLength(const Value: Integer); begin FEngine.Length := Value; end;
procedure OLCurrencyArray.Sort;
begin
  if FEngine.Length > 1 then
  begin
    FEngine.MakeUnique();
    TArray.Sort<OLCurrency>(FEngine.arr, TComparer<OLCurrency>.Construct(
      function(const Left, Right: OLCurrency): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end;
  FEngine.FSorted := True;
end;
function OLCurrencyArray.Sorted: OLCurrencyArray;
begin
  Result.FEngine := FEngine;
  Result.Sort;
end;

class operator OLCurrencyArray.Implicit(const A: array of Currency): OLCurrencyArray;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLCurrencyArray.Implicit(const A: OLCurrencyArray): TOLCurrencyDynArray;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;
class operator OLCurrencyArray.Implicit(const A: TArray<Currency>): OLCurrencyArray;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLCurrencyArray.Implicit(const A: OLCurrencyArray): TArray<Currency>;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;

// --- OLDateTimeArray ---
procedure OLDateTimeArray.Add(Value: OLDateTime); begin FEngine.Add(Value); end;
procedure OLDateTimeArray.Clear; begin FEngine.Clear; end;
function OLDateTimeArray.ContainsValue(v: OLDateTime): Boolean;
var
  i: Integer;
  FoundIndex: Integer;
begin
  if FEngine.IsSorted then
  begin
    Result := TArray.BinarySearch<OLDateTime>(FEngine.arr, v, FoundIndex, TComparer<OLDateTime>.Construct(
      function(const Left, Right: OLDateTime): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end
  else
  begin
    Result := False;
    for i := 0 to FEngine.Length - 1 do
    begin
      if FEngine.Items[i] = v then
        Exit(True);
    end;
  end;
end;
procedure OLDateTimeArray.Delete(Index: Integer); begin FEngine.Delete(Index); end;
function OLDateTimeArray.Distinct: OLDateTimeArray;
begin
  Result.FEngine := FEngine.Distinct(TEqualityComparer<OLDateTime>.Construct(
    function(const Left, Right: OLDateTime): Boolean
    begin
      Result := Left = Right;
    end,
    function(const Value: OLDateTime): Integer
    begin
      if Value.IsNull then Result := 0
      else Result := TEqualityComparer<TDateTime>.Default.GetHashCode(TDateTime(Value));
    end
  ));
end;
function OLDateTimeArray.GetEnumerator: TEnumerator<OLDateTime>; begin Result := FEngine.GetEnumerator; end;
function OLDateTimeArray.GetItems(Index: Integer): OLDateTime; begin Result := FEngine.Items[Index]; end;
function OLDateTimeArray.GetLength: Integer; begin Result := FEngine.Length; end;
procedure OLDateTimeArray.Insert(AtIndex: Integer; Value: OLDateTime); begin FEngine.Insert(AtIndex, Value); end;
function OLDateTimeArray.LastItemIndex: Integer; begin Result := FEngine.LastItemIndex; end;
function OLDateTimeArray.Reversed: OLDateTimeArray; begin Result.FEngine := FEngine.Reversed; end;
procedure OLDateTimeArray.SetItems(Index: Integer; const Value: OLDateTime); begin FEngine.Items[Index] := Value; end;
procedure OLDateTimeArray.SetLength(const Value: Integer); begin FEngine.Length := Value; end;
procedure OLDateTimeArray.Sort;
begin
  if FEngine.Length > 1 then
  begin
    FEngine.MakeUnique();
    TArray.Sort<OLDateTime>(FEngine.arr, TComparer<OLDateTime>.Construct(
      function(const Left, Right: OLDateTime): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end;
  FEngine.FSorted := True;
end;
function OLDateTimeArray.Sorted: OLDateTimeArray;
begin
  Result.FEngine := FEngine;
  Result.Sort;
end;

class operator OLDateTimeArray.Implicit(const A: array of TDateTime): OLDateTimeArray;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLDateTimeArray.Implicit(const A: OLDateTimeArray): TOLDateTimeDynArray;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;
class operator OLDateTimeArray.Implicit(const A: TArray<TDateTime>): OLDateTimeArray;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLDateTimeArray.Implicit(const A: OLDateTimeArray): TArray<TDateTime>;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;

// --- OLDateArray ---
procedure OLDateArray.Add(Value: OLDate); begin FEngine.Add(Value); end;
procedure OLDateArray.Clear; begin FEngine.Clear; end;
function OLDateArray.ContainsValue(v: OLDate): Boolean;
var
  i: Integer;
  FoundIndex: Integer;
begin
  if FEngine.IsSorted then
  begin
    Result := TArray.BinarySearch<OLDate>(FEngine.arr, v, FoundIndex, TComparer<OLDate>.Construct(
      function(const Left, Right: OLDate): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end
  else
  begin
    Result := False;
    for i := 0 to FEngine.Length - 1 do
    begin
      if FEngine.Items[i] = v then
        Exit(True);
    end;
  end;
end;
procedure OLDateArray.Delete(Index: Integer); begin FEngine.Delete(Index); end;
function OLDateArray.Distinct: OLDateArray;
begin
  Result.FEngine := FEngine.Distinct(TEqualityComparer<OLDate>.Construct(
    function(const Left, Right: OLDate): Boolean
    begin
      Result := Left = Right;
    end,
    function(const Value: OLDate): Integer
    begin
      if Value.IsNull then Result := 0
      else Result := TEqualityComparer<TDate>.Default.GetHashCode(TDate(Value));
    end
  ));
end;
function OLDateArray.GetEnumerator: TEnumerator<OLDate>; begin Result := FEngine.GetEnumerator; end;
function OLDateArray.GetItems(Index: Integer): OLDate; begin Result := FEngine.Items[Index]; end;
function OLDateArray.GetLength: Integer; begin Result := FEngine.Length; end;
procedure OLDateArray.Insert(AtIndex: Integer; Value: OLDate); begin FEngine.Insert(AtIndex, Value); end;
function OLDateArray.LastItemIndex: Integer; begin Result := FEngine.LastItemIndex; end;
function OLDateArray.Reversed: OLDateArray; begin Result.FEngine := FEngine.Reversed; end;
procedure OLDateArray.SetItems(Index: Integer; const Value: OLDate); begin FEngine.Items[Index] := Value; end;
procedure OLDateArray.SetLength(const Value: Integer); begin FEngine.Length := Value; end;
procedure OLDateArray.Sort;
begin
  if FEngine.Length > 1 then
  begin
    FEngine.MakeUnique();
    TArray.Sort<OLDate>(FEngine.arr, TComparer<OLDate>.Construct(
      function(const Left, Right: OLDate): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end;
  FEngine.FSorted := True;
end;
function OLDateArray.Sorted: OLDateArray;
begin
  Result.FEngine := FEngine;
  Result.Sort;
end;

class operator OLDateArray.Implicit(const A: array of TDate): OLDateArray;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLDateArray.Implicit(const A: OLDateArray): TOLDateDynArray;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;
class operator OLDateArray.Implicit(const A: TArray<TDate>): OLDateArray;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLDateArray.Implicit(const A: OLDateArray): TArray<TDate>;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;

// --- OLDoubleArray ---
procedure OLDoubleArray.Add(Value: OLDouble); begin FEngine.Add(Value); end;
procedure OLDoubleArray.Clear; begin FEngine.Clear; end;
function OLDoubleArray.ContainsValue(v: OLDouble): Boolean;
var
  i: Integer;
  FoundIndex: Integer;
begin
  if FEngine.IsSorted then
  begin
    Result := TArray.BinarySearch<OLDouble>(FEngine.arr, v, FoundIndex, TComparer<OLDouble>.Construct(
      function(const Left, Right: OLDouble): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end
  else
  begin
    Result := False;
    for i := 0 to FEngine.Length - 1 do
    begin
      if FEngine.Items[i] = v then
        Exit(True);
    end;
  end;
end;
procedure OLDoubleArray.Delete(Index: Integer); begin FEngine.Delete(Index); end;
function OLDoubleArray.Distinct: OLDoubleArray;
begin
  Result.FEngine := FEngine.Distinct(TEqualityComparer<OLDouble>.Construct(
    function(const Left, Right: OLDouble): Boolean
    begin
      Result := Left = Right;
    end,
    function(const Value: OLDouble): Integer
    begin
      if Value.IsNull then Result := 0
      else Result := TEqualityComparer<Double>.Default.GetHashCode(Double(Value));
    end
  ));
end;
function OLDoubleArray.GetEnumerator: TEnumerator<OLDouble>; begin Result := FEngine.GetEnumerator; end;
function OLDoubleArray.GetItems(Index: Integer): OLDouble; begin Result := FEngine.Items[Index]; end;
function OLDoubleArray.GetLength: Integer; begin Result := FEngine.Length; end;
procedure OLDoubleArray.Insert(AtIndex: Integer; Value: OLDouble); begin FEngine.Insert(AtIndex, Value); end;
function OLDoubleArray.LastItemIndex: Integer; begin Result := FEngine.LastItemIndex; end;
function OLDoubleArray.Reversed: OLDoubleArray; begin Result.FEngine := FEngine.Reversed; end;
procedure OLDoubleArray.SetItems(Index: Integer; const Value: OLDouble); begin FEngine.Items[Index] := Value; end;
procedure OLDoubleArray.SetLength(const Value: Integer); begin FEngine.Length := Value; end;
procedure OLDoubleArray.Sort;
begin
  if FEngine.Length > 1 then
  begin
    FEngine.MakeUnique();
    TArray.Sort<OLDouble>(FEngine.arr, TComparer<OLDouble>.Construct(
      function(const Left, Right: OLDouble): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end;
  FEngine.FSorted := True;
end;
function OLDoubleArray.Sorted: OLDoubleArray;
begin
  Result.FEngine := FEngine;
  Result.Sort;
end;

class operator OLDoubleArray.Implicit(const A: array of Double): OLDoubleArray;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLDoubleArray.Implicit(const A: OLDoubleArray): TOLDoubleDynArray;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;
class operator OLDoubleArray.Implicit(const A: TArray<Double>): OLDoubleArray;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLDoubleArray.Implicit(const A: OLDoubleArray): TArray<Double>;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;

// --- OLInt64Array ---
procedure OLInt64Array.Add(Value: OLInt64); begin FEngine.Add(Value); end;
procedure OLInt64Array.Clear; begin FEngine.Clear; end;
function OLInt64Array.ContainsValue(v: OLInt64): Boolean;
var
  i: Integer;
  FoundIndex: Integer;
begin
  if FEngine.IsSorted then
  begin
    Result := TArray.BinarySearch<OLInt64>(FEngine.arr, v, FoundIndex, TComparer<OLInt64>.Construct(
      function(const Left, Right: OLInt64): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end
  else
  begin
    Result := False;
    for i := 0 to FEngine.Length - 1 do
    begin
      if FEngine.Items[i] = v then
        Exit(True);
    end;
  end;
end;
procedure OLInt64Array.Delete(Index: Integer); begin FEngine.Delete(Index); end;
function OLInt64Array.Distinct: OLInt64Array;
begin
  Result.FEngine := FEngine.Distinct(TEqualityComparer<OLInt64>.Construct(
    function(const Left, Right: OLInt64): Boolean
    begin
      Result := Left = Right;
    end,
    function(const Value: OLInt64): Integer
    begin
      if Value.IsNull then Result := 0
      else Result := TEqualityComparer<Int64>.Default.GetHashCode(Int64(Value));
    end
  ));
end;
function OLInt64Array.GetEnumerator: TEnumerator<OLInt64>; begin Result := FEngine.GetEnumerator; end;
function OLInt64Array.GetItems(Index: Integer): OLInt64; begin Result := FEngine.Items[Index]; end;
function OLInt64Array.GetLength: Integer; begin Result := FEngine.Length; end;
procedure OLInt64Array.Insert(AtIndex: Integer; Value: OLInt64); begin FEngine.Insert(AtIndex, Value); end;
function OLInt64Array.LastItemIndex: Integer; begin Result := FEngine.LastItemIndex; end;
function OLInt64Array.Reversed: OLInt64Array; begin Result.FEngine := FEngine.Reversed; end;
procedure OLInt64Array.SetItems(Index: Integer; const Value: OLInt64); begin FEngine.Items[Index] := Value; end;
procedure OLInt64Array.SetLength(const Value: Integer); begin FEngine.Length := Value; end;
procedure OLInt64Array.Sort;
begin
  if FEngine.Length > 1 then
  begin
    FEngine.MakeUnique();
    TArray.Sort<OLInt64>(FEngine.arr, TComparer<OLInt64>.Construct(
      function(const Left, Right: OLInt64): Integer
      begin
        if Left = Right then Result := 0
        else if Left < Right then Result := -1
        else Result := 1;
      end
    ));
  end;
  FEngine.FSorted := True;
end;
function OLInt64Array.Sorted: OLInt64Array;
begin
  Result.FEngine := FEngine;
  Result.Sort;
end;

class operator OLInt64Array.Implicit(const A: array of Int64): OLInt64Array;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLInt64Array.Implicit(const A: OLInt64Array): TOLInt64DynArray;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;
class operator OLInt64Array.Implicit(const A: TArray<Int64>): OLInt64Array;
var i: Integer; begin Result.Length := System.Length(A); for i := 0 to High(A) do Result.Items[i] := A[i]; end;
class operator OLInt64Array.Implicit(const A: OLInt64Array): TArray<Int64>;
var i: Integer; begin System.SetLength(Result, A.Length); for i := 0 to A.LastItemIndex do Result[i] := A.Items[i]; end;

end.
