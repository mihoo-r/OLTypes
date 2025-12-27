unit OLDictionaries;

interface

{$IF CompilerVersion >= 34.0}

uses
  {$IF CompilerVersion >= 23.0}
  System.SysUtils,
  System.Generics.Collections,
  System.Generics.Defaults,
  {$ELSE}
  SysUtils,
  Generics.Collections,
  Generics.Defaults,
  {$IFEND}
  // Twoje typy
  OLBooleanType,
  OLCurrencyType,
  OLDateTimeType,
  OLDateType,
  OLDoubleType,
  OLIntegerType,
  OLInt64Type,
  OLStringType;

type
  /// <summary>
  /// Wewnetrzny generyczny wrapper na TDictionary.
  /// Nie uzywaj bezposrednio - uzywaj dedykowanych wrapperow.
  /// </summary>
  OLGenericDictionary<K, V> = record
  private
    FDict: TDictionary<K, V>;
    function GetValue(const Key: K): V;
    procedure SetValue(const Key: K; const Value: V);
    function GetKeys: TArray<K>;
  public
    class operator Initialize(out Dest: OLGenericDictionary<K, V>);
    class operator Finalize(var Dest: OLGenericDictionary<K, V>);
    {$IF CompilerVersion >= 31.0}
    class operator Assign(var Dest: OLGenericDictionary<K, V>; const [ref] Src: OLGenericDictionary<K, V>);
    {$ELSE}
    class operator Assign(var Dest: OLGenericDictionary<K, V>; const Src: OLGenericDictionary<K, V>);
    {$IFEND}

    /// <summary>Clears the dictionary.</summary>
    procedure Clear;
    /// <summary>Adds a key-value pair.</summary>
    procedure Add(const Key: K; const Value: V);
    /// <summary>Removes a key-value pair.</summary>
    function Remove(const Key: K): OLBoolean;
    /// <summary>Tries to get a value.</summary>
    function TryGetValue(const Key: K; out Value: V): OLBoolean;
    /// <summary>Checks if key exists.</summary>
    function ContainsKey(const Key: K): OLBoolean;
    /// <summary>Returns count of items.</summary>
    function Count: Integer;

    /// <summary>Returns an enumerator for the collection.</summary>
    function GetEnumerator: TDictionary<K, V>.TPairEnumerator;
    /// <summary>Returns an array of key-value pairs.</summary>
    function ToArray: TArray<TPair<K, V>>;



    property Values[const Key: K]: V read GetValue write SetValue; default;
    property Keys: TArray<K> read GetKeys;
  end;

  /// <summary>
  ///   Dictionary wrapper for Integer to OLInteger mappings.
  /// </summary>
  OLIntIntDictionary = record
  private
    FEngine: OLGenericDictionary<Integer, OLInteger>;
    function GetValue(const Key: Integer): OLInteger;
    procedure SetValue(const Key: Integer; const Value: OLInteger);
    function GetKeys: TArray<Integer>;
  public
    /// <summary>
    ///   Assigns one dictionary to another.
    /// </summary>
    {$IF CompilerVersion >= 31.0}
    class operator Assign(var Dest: OLIntIntDictionary; const [ref] Src: OLIntIntDictionary);
    {$ELSE}
    class operator Assign(var Dest: OLIntIntDictionary; const Src: OLIntIntDictionary);
    {$IFEND}


    /// <summary>
    ///   Clears the dictionary.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Adds a key-value pair to the dictionary.
    /// </summary>
    procedure Add(const Key: Integer; const Value: OLInteger);
    /// <summary>
    ///   Removes the key-value pair with the specified key.
    /// </summary>
    function Remove(const Key: Integer): OLBoolean;
    /// <summary>
    ///   Tries to get the value associated with the specified key.
    /// </summary>
    function TryGetValue(const Key: Integer; out Value: OLInteger): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified key.
    /// </summary>
    function ContainsKey(const Key: Integer): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified value.
    /// </summary>
    function ContainsValue(const Value: OLInteger): OLBoolean;
    /// <summary>
    ///   Returns the number of key-value pairs in the dictionary.
    /// </summary>
    function Count: Integer;
    /// <summary>
    ///   Gets the enumerator for the dictionary.
    /// </summary>
    function GetEnumerator: TDictionary<Integer, OLInteger>.TPairEnumerator;
    /// <summary>
    ///   Converts the dictionary to an array of pairs.
    /// </summary>
    function ToArray: TArray<TPair<Integer, OLInteger>>;

    /// <summary>
    ///   Gets or sets the value associated with the specified key.
    /// </summary>
    property Values[const Key: Integer]: OLInteger read GetValue write SetValue; default;
    /// <summary>
    ///   Gets an array of all keys in the dictionary.
    /// </summary>
    property Keys: TArray<Integer> read GetKeys;
  end;
  /// <summary>
  ///   Dictionary wrapper for Integer to OLString mappings.
  /// </summary>
  OLIntStrDictionary = record
  private
    FEngine: OLGenericDictionary<Integer, OLString>;
    function GetValue(const Key: Integer): OLString;
    procedure SetValue(const Key: Integer; const Value: OLString);
    function GetKeys: TArray<Integer>;
  public
    /// <summary>
    ///   Assigns one dictionary to another.
    /// </summary>
    {$IF CompilerVersion >= 31.0}
    class operator Assign(var Dest: OLIntStrDictionary; const [ref] Src: OLIntStrDictionary);
    {$ELSE}
    class operator Assign(var Dest: OLIntStrDictionary; const Src: OLIntStrDictionary);
    {$IFEND}


    /// <summary>
    ///   Clears the dictionary.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Adds a key-value pair to the dictionary.
    /// </summary>
    procedure Add(const Key: Integer; const Value: OLString);
    /// <summary>
    ///   Removes the key-value pair with the specified key.
    /// </summary>
    function Remove(const Key: Integer): OLBoolean;
    /// <summary>
    ///   Tries to get the value associated with the specified key.
    /// </summary>
    function TryGetValue(const Key: Integer; out Value: OLString): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified key.
    /// </summary>
    function ContainsKey(const Key: Integer): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified value.
    /// </summary>
    function ContainsValue(const Value: OLString): OLBoolean;
    /// <summary>
    ///   Returns the number of key-value pairs in the dictionary.
    /// </summary>
    function Count: Integer;
    /// <summary>
    ///   Gets the enumerator for the dictionary.
    /// </summary>
    function GetEnumerator: TDictionary<Integer, OLString>.TPairEnumerator;
    /// <summary>
    ///   Converts the dictionary to an array of pairs.
    /// </summary>
    function ToArray: TArray<TPair<Integer, OLString>>;

    /// <summary>
    ///   Gets or sets the value associated with the specified key.
    /// </summary>
    property Values[const Key: Integer]: OLString read GetValue write SetValue; default;
    /// <summary>
    ///   Gets an array of all keys in the dictionary.
    /// </summary>
    property Keys: TArray<Integer> read GetKeys;
  end;
  /// <summary>
  ///   Dictionary wrapper for Integer to OLDouble mappings.
  /// </summary>
  OLIntDblDictionary = record
  private
    FEngine: OLGenericDictionary<Integer, OLDouble>;
    function GetValue(const Key: Integer): OLDouble;
    procedure SetValue(const Key: Integer; const Value: OLDouble);
    function GetKeys: TArray<Integer>;
  public
    /// <summary>
    ///   Assigns one dictionary to another.
    /// </summary>
    {$IF CompilerVersion >= 31.0}
    class operator Assign(var Dest: OLIntDblDictionary; const [ref] Src: OLIntDblDictionary);
    {$ELSE}
    class operator Assign(var Dest: OLIntDblDictionary; const Src: OLIntDblDictionary);
    {$IFEND}


    /// <summary>
    ///   Clears the dictionary.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Adds a key-value pair to the dictionary.
    /// </summary>
    procedure Add(const Key: Integer; const Value: OLDouble);
    /// <summary>
    ///   Removes the key-value pair with the specified key.
    /// </summary>
    function Remove(const Key: Integer): OLBoolean;
    /// <summary>
    ///   Tries to get the value associated with the specified key.
    /// </summary>
    function TryGetValue(const Key: Integer; out Value: OLDouble): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified key.
    /// </summary>
    function ContainsKey(const Key: Integer): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified value.
    /// </summary>
    function ContainsValue(const Value: OLDouble): OLBoolean;
    /// <summary>
    ///   Returns the number of key-value pairs in the dictionary.
    /// </summary>
    function Count: Integer;
    /// <summary>
    ///   Gets the enumerator for the dictionary.
    /// </summary>
    function GetEnumerator: TDictionary<Integer, OLDouble>.TPairEnumerator;
    /// <summary>
    ///   Converts the dictionary to an array of pairs.
    /// </summary>
    function ToArray: TArray<TPair<Integer, OLDouble>>;

    /// <summary>
    ///   Gets or sets the value associated with the specified key.
    /// </summary>
    property Values[const Key: Integer]: OLDouble read GetValue write SetValue; default;
    /// <summary>
    ///   Gets an array of all keys in the dictionary.
    /// </summary>
    property Keys: TArray<Integer> read GetKeys;
  end;
  /// <summary>
  ///   Dictionary wrapper for Integer to OLCurrency mappings.
  /// </summary>
  OLIntCurrDictionary = record
  private
    FEngine: OLGenericDictionary<Integer, OLCurrency>;
    function GetValue(const Key: Integer): OLCurrency;
    procedure SetValue(const Key: Integer; const Value: OLCurrency);
    function GetKeys: TArray<Integer>;
  public
    /// <summary>
    ///   Assigns one dictionary to another.
    /// </summary>
    {$IF CompilerVersion >= 31.0}
    class operator Assign(var Dest: OLIntCurrDictionary; const [ref] Src: OLIntCurrDictionary);
    {$ELSE}
    class operator Assign(var Dest: OLIntCurrDictionary; const Src: OLIntCurrDictionary);
    {$IFEND}


    /// <summary>
    ///   Clears the dictionary.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Adds a key-value pair to the dictionary.
    /// </summary>
    procedure Add(const Key: Integer; const Value: OLCurrency);
    /// <summary>
    ///   Removes the key-value pair with the specified key.
    /// </summary>
    function Remove(const Key: Integer): OLBoolean;
    /// <summary>
    ///   Tries to get the value associated with the specified key.
    /// </summary>
    function TryGetValue(const Key: Integer; out Value: OLCurrency): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified key.
    /// </summary>
    function ContainsKey(const Key: Integer): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified value.
    /// </summary>
    function ContainsValue(const Value: OLCurrency): OLBoolean;
    /// <summary>
    ///   Returns the number of key-value pairs in the dictionary.
    /// </summary>
    function Count: Integer;
    /// <summary>
    ///   Gets the enumerator for the dictionary.
    /// </summary>
    function GetEnumerator: TDictionary<Integer, OLCurrency>.TPairEnumerator;
    /// <summary>
    ///   Converts the dictionary to an array of pairs.
    /// </summary>
    function ToArray: TArray<TPair<Integer, OLCurrency>>;

    /// <summary>
    ///   Gets or sets the value associated with the specified key.
    /// </summary>
    property Values[const Key: Integer]: OLCurrency read GetValue write SetValue; default;
    /// <summary>
    ///   Gets an array of all keys in the dictionary.
    /// </summary>
    property Keys: TArray<Integer> read GetKeys;
  end;
  /// <summary>
  ///   Dictionary wrapper for Integer to OLBoolean mappings.
  /// </summary>
  OLIntBooleanDictionary = record
  private
    FEngine: OLGenericDictionary<Integer, OLBoolean>;
    function GetValue(const Key: Integer): OLBoolean;
    procedure SetValue(const Key: Integer; const Value: OLBoolean);
    function GetKeys: TArray<Integer>;
  public
    /// <summary>
    ///   Assigns one dictionary to another.
    /// </summary>
    {$IF CompilerVersion >= 31.0}
    class operator Assign(var Dest: OLIntBooleanDictionary; const [ref] Src: OLIntBooleanDictionary);
    {$ELSE}
    class operator Assign(var Dest: OLIntBooleanDictionary; const Src: OLIntBooleanDictionary);
    {$IFEND}


    /// <summary>
    ///   Clears the dictionary.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Adds a key-value pair to the dictionary.
    /// </summary>
    procedure Add(const Key: Integer; const Value: OLBoolean);
    /// <summary>
    ///   Removes the key-value pair with the specified key.
    /// </summary>
    function Remove(const Key: Integer): OLBoolean;
    /// <summary>
    ///   Tries to get the value associated with the specified key.
    /// </summary>
    function TryGetValue(const Key: Integer; out Value: OLBoolean): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified key.
    /// </summary>
    function ContainsKey(const Key: Integer): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified value.
    /// </summary>
    function ContainsValue(const Value: OLBoolean): OLBoolean;
    /// <summary>
    ///   Returns the number of key-value pairs in the dictionary.
    /// </summary>
    function Count: Integer;
    /// <summary>
    ///   Gets the enumerator for the dictionary.
    /// </summary>
    function GetEnumerator: TDictionary<Integer, OLBoolean>.TPairEnumerator;
    /// <summary>
    ///   Converts the dictionary to an array of pairs.
    /// </summary>
    function ToArray: TArray<TPair<Integer, OLBoolean>>;

    /// <summary>
    ///   Gets or sets the value associated with the specified key.
    /// </summary>
    property Values[const Key: Integer]: OLBoolean read GetValue write SetValue; default;
    /// <summary>
    ///   Gets an array of all keys in the dictionary.
    /// </summary>
    property Keys: TArray<Integer> read GetKeys;
  end;
  /// <summary>
  ///   Dictionary wrapper for Integer to OLDate mappings.
  /// </summary>
  OLIntDateDictionary = record
  private
    FEngine: OLGenericDictionary<Integer, OLDate>;
    function GetValue(const Key: Integer): OLDate;
    procedure SetValue(const Key: Integer; const Value: OLDate);
    function GetKeys: TArray<Integer>;
  public
    /// <summary>
    ///   Assigns one dictionary to another.
    /// </summary>
    {$IF CompilerVersion >= 31.0}
    class operator Assign(var Dest: OLIntDateDictionary; const [ref] Src: OLIntDateDictionary);
    {$ELSE}
    class operator Assign(var Dest: OLIntDateDictionary; const Src: OLIntDateDictionary);
    {$IFEND}


    /// <summary>
    ///   Clears the dictionary.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Adds a key-value pair to the dictionary.
    /// </summary>
    procedure Add(const Key: Integer; const Value: OLDate);
    /// <summary>
    ///   Removes the key-value pair with the specified key.
    /// </summary>
    function Remove(const Key: Integer): OLBoolean;
    /// <summary>
    ///   Tries to get the value associated with the specified key.
    /// </summary>
    function TryGetValue(const Key: Integer; out Value: OLDate): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified key.
    /// </summary>
    function ContainsKey(const Key: Integer): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified value.
    /// </summary>
    function ContainsValue(const Value: OLDate): OLBoolean;
    /// <summary>
    ///   Returns the number of key-value pairs in the dictionary.
    /// </summary>
    function Count: Integer;
    /// <summary>
    ///   Gets the enumerator for the dictionary.
    /// </summary>
    function GetEnumerator: TDictionary<Integer, OLDate>.TPairEnumerator;
    /// <summary>
    ///   Converts the dictionary to an array of pairs.
    /// </summary>
    function ToArray: TArray<TPair<Integer, OLDate>>;

    /// <summary>
    ///   Gets or sets the value associated with the specified key.
    /// </summary>
    property Values[const Key: Integer]: OLDate read GetValue write SetValue; default;
    /// <summary>
    ///   Gets an array of all keys in the dictionary.
    /// </summary>
    property Keys: TArray<Integer> read GetKeys;
  end;
  /// <summary>
  ///   Dictionary wrapper for string to OLString mappings.
  /// </summary>
  OLStrStrDictionary = record
  private
    FEngine: OLGenericDictionary<string, OLString>;
    function GetValue(const Key: string): OLString;
    procedure SetValue(const Key: string; const Value: OLString);
    function GetKeys: TArray<string>;
  public
    /// <summary>
    ///   Assigns one dictionary to another.
    /// </summary>
    {$IF CompilerVersion >= 31.0}
    class operator Assign(var Dest: OLStrStrDictionary; const [ref] Src: OLStrStrDictionary);
    {$ELSE}
    class operator Assign(var Dest: OLStrStrDictionary; const Src: OLStrStrDictionary);
    {$IFEND}


    /// <summary>
    ///   Clears the dictionary.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Adds a key-value pair to the dictionary.
    /// </summary>
    procedure Add(const Key: string; const Value: OLString);
    /// <summary>
    ///   Removes the key-value pair with the specified key.
    /// </summary>
    function Remove(const Key: string): OLBoolean;
    /// <summary>
    ///   Tries to get the value associated with the specified key.
    /// </summary>
    function TryGetValue(const Key: string; out Value: OLString): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified key.
    /// </summary>
    function ContainsKey(const Key: string): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified value.
    /// </summary>
    function ContainsValue(const Value: OLString): OLBoolean;
    /// <summary>
    ///   Returns the number of key-value pairs in the dictionary.
    /// </summary>
    function Count: Integer;
    /// <summary>
    ///   Gets the enumerator for the dictionary.
    /// </summary>
    function GetEnumerator: TDictionary<string, OLString>.TPairEnumerator;
    /// <summary>
    ///   Converts the dictionary to an array of pairs.
    /// </summary>
    function ToArray: TArray<TPair<string, OLString>>;

    /// <summary>
    ///   Gets or sets the value associated with the specified key.
    /// </summary>
    property Values[const Key: string]: OLString read GetValue write SetValue; default;
    /// <summary>
    ///   Gets an array of all keys in the dictionary.
    /// </summary>
    property Keys: TArray<string> read GetKeys;
  end;
  /// <summary>
  ///   Dictionary wrapper for string to OLInteger mappings.
  /// </summary>
  OLStrIntDictionary = record
  private
    FEngine: OLGenericDictionary<string, OLInteger>;
    function GetValue(const Key: string): OLInteger;
    procedure SetValue(const Key: string; const Value: OLInteger);
    function GetKeys: TArray<string>;
  public
    /// <summary>
    ///   Assigns one dictionary to another.
    /// </summary>
    {$IF CompilerVersion >= 31.0}
    class operator Assign(var Dest: OLStrIntDictionary; const [ref] Src: OLStrIntDictionary);
    {$ELSE}
    class operator Assign(var Dest: OLStrIntDictionary; const Src: OLStrIntDictionary);
    {$IFEND}


    /// <summary>
    ///   Clears the dictionary.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Adds a key-value pair to the dictionary.
    /// </summary>
    procedure Add(const Key: string; const Value: OLInteger);
    /// <summary>
    ///   Removes the key-value pair with the specified key.
    /// </summary>
    function Remove(const Key: string): OLBoolean;
    /// <summary>
    ///   Tries to get the value associated with the specified key.
    /// </summary>
    function TryGetValue(const Key: string; out Value: OLInteger): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified key.
    /// </summary>
    function ContainsKey(const Key: string): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified value.
    /// </summary>
    function ContainsValue(const Value: OLInteger): OLBoolean;
    /// <summary>
    ///   Returns the number of key-value pairs in the dictionary.
    /// </summary>
    function Count: Integer;
    /// <summary>
    ///   Gets the enumerator for the dictionary.
    /// </summary>
    function GetEnumerator: TDictionary<string, OLInteger>.TPairEnumerator;
    /// <summary>
    ///   Converts the dictionary to an array of pairs.
    /// </summary>
    function ToArray: TArray<TPair<string, OLInteger>>;

    /// <summary>
    ///   Gets or sets the value associated with the specified key.
    /// </summary>
    property Values[const Key: string]: OLInteger read GetValue write SetValue; default;
    /// <summary>
    ///   Gets an array of all keys in the dictionary.
    /// </summary>
    property Keys: TArray<string> read GetKeys;
  end;
  /// <summary>
  ///   Dictionary wrapper for string to OLCurrency mappings.
  /// </summary>
  OLStrCurrDictionary = record
  private
    FEngine: OLGenericDictionary<string, OLCurrency>;
    function GetValue(const Key: string): OLCurrency;
    procedure SetValue(const Key: string; const Value: OLCurrency);
    function GetKeys: TArray<string>;
  public
    /// <summary>
    ///   Assigns one dictionary to another.
    /// </summary>
    {$IF CompilerVersion >= 31.0}
    class operator Assign(var Dest: OLStrCurrDictionary; const [ref] Src: OLStrCurrDictionary);
    {$ELSE}
    class operator Assign(var Dest: OLStrCurrDictionary; const Src: OLStrCurrDictionary);
    {$IFEND}


    /// <summary>
    ///   Clears the dictionary.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Adds a key-value pair to the dictionary.
    /// </summary>
    procedure Add(const Key: string; const Value: OLCurrency);
    /// <summary>
    ///   Removes the key-value pair with the specified key.
    /// </summary>
    function Remove(const Key: string): OLBoolean;
    /// <summary>
    ///   Tries to get the value associated with the specified key.
    /// </summary>
    function TryGetValue(const Key: string; out Value: OLCurrency): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified key.
    /// </summary>
    function ContainsKey(const Key: string): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified value.
    /// </summary>
    function ContainsValue(const Value: OLCurrency): OLBoolean;
    /// <summary>
    ///   Returns the number of key-value pairs in the dictionary.
    /// </summary>
    function Count: Integer;
    /// <summary>
    ///   Gets the enumerator for the dictionary.
    /// </summary>
    function GetEnumerator: TDictionary<string, OLCurrency>.TPairEnumerator;
    /// <summary>
    ///   Converts the dictionary to an array of pairs.
    /// </summary>
    function ToArray: TArray<TPair<string, OLCurrency>>;

    /// <summary>
    ///   Gets or sets the value associated with the specified key.
    /// </summary>
    property Values[const Key: string]: OLCurrency read GetValue write SetValue; default;
    /// <summary>
    ///   Gets an array of all keys in the dictionary.
    /// </summary>
    property Keys: TArray<string> read GetKeys;
  end;
  /// <summary>
  ///   Dictionary wrapper for string to OLDouble mappings.
  /// </summary>
  OLStrDblDictionary = record
  private
    FEngine: OLGenericDictionary<string, OLDouble>;
    function GetValue(const Key: string): OLDouble;
    procedure SetValue(const Key: string; const Value: OLDouble);
    function GetKeys: TArray<string>;
  public
    /// <summary>
    ///   Assigns one dictionary to another.
    /// </summary>
    {$IF CompilerVersion >= 31.0}
    class operator Assign(var Dest: OLStrDblDictionary; const [ref] Src: OLStrDblDictionary);
    {$ELSE}
    class operator Assign(var Dest: OLStrDblDictionary; const Src: OLStrDblDictionary);
    {$IFEND}


    /// <summary>
    ///   Clears the dictionary.
    /// </summary>
    procedure Clear;
    /// <summary>
    ///   Adds a key-value pair to the dictionary.
    /// </summary>
    procedure Add(const Key: string; const Value: OLDouble);
    /// <summary>
    ///   Removes the key-value pair with the specified key.
    /// </summary>
    function Remove(const Key: string): OLBoolean;
    /// <summary>
    ///   Tries to get the value associated with the specified key.
    /// </summary>
    function TryGetValue(const Key: string; out Value: OLDouble): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified key.
    /// </summary>
    function ContainsKey(const Key: string): OLBoolean;
    /// <summary>
    ///   Checks if the dictionary contains the specified value.
    /// </summary>
    function ContainsValue(const Value: OLDouble): OLBoolean;
    /// <summary>
    ///   Returns the number of key-value pairs in the dictionary.
    /// </summary>
    function Count: Integer;
    /// <summary>
    ///   Gets the enumerator for the dictionary.
    /// </summary>
    function GetEnumerator: TDictionary<string, OLDouble>.TPairEnumerator;
    /// <summary>
    ///   Converts the dictionary to an array of pairs.
    /// </summary>
    function ToArray: TArray<TPair<string, OLDouble>>;

    /// <summary>
    ///   Gets or sets the value associated with the specified key.
    /// </summary>
    property Values[const Key: string]: OLDouble read GetValue write SetValue; default;
    /// <summary>
    ///   Gets an array of all keys in the dictionary.
    /// </summary>
    property Keys: TArray<string> read GetKeys;
  end;
{$IFEND}

implementation

{$IF CompilerVersion >= 34.0}

{ OLGenericDictionary<K, V> }

class operator OLGenericDictionary<K, V>.Initialize(out Dest: OLGenericDictionary<K, V>);
begin
  Dest.FDict := TDictionary<K, V>.Create;
end;

class operator OLGenericDictionary<K, V>.Finalize(var Dest: OLGenericDictionary<K, V>);
begin
  if Assigned(Dest.FDict) then
    Dest.FDict.Free;
end;

{$IF CompilerVersion >= 31.0}
class operator OLGenericDictionary<K, V>.Assign(var Dest: OLGenericDictionary<K, V>; const [ref] Src: OLGenericDictionary<K, V>);
{$ELSE}
class operator OLGenericDictionary<K, V>.Assign(var Dest: OLGenericDictionary<K, V>; const Src: OLGenericDictionary<K, V>);
{$IFEND}
var
  Pair: TPair<K, V>;
begin
  if @Dest = @Src then
    Exit;

  if not Assigned(Dest.FDict) then
    Dest.FDict := TDictionary<K, V>.Create;

  Dest.FDict.Clear;

  if Assigned(Src.FDict) then
  begin
    for Pair in Src.FDict do
    begin
      Dest.FDict.AddOrSetValue(Pair.Key, Pair.Value);
    end;
  end;
end;

procedure OLGenericDictionary<K, V>.Clear;
begin
  if Assigned(FDict) then
    FDict.Clear;
end;

procedure OLGenericDictionary<K, V>.Add(const Key: K; const Value: V);
begin
  if Assigned(FDict) then
    FDict.Add(Key, Value);
end;

function OLGenericDictionary<K, V>.Remove(const Key: K): OLBoolean;
var
  Found: Boolean;
begin
  if Assigned(FDict) then
  begin
    Found := FDict.ContainsKey(Key);
    if Found then
      FDict.Remove(Key);
    Result := Found;
  end
  else
    Result := False;
end;

function OLGenericDictionary<K, V>.TryGetValue(const Key: K; out Value: V): OLBoolean;
begin
  if Assigned(FDict) then
    Result := FDict.TryGetValue(Key, Value)
  else
  begin
    Value := Default(V);
    Result := False;
  end;
end;

function OLGenericDictionary<K, V>.ContainsKey(const Key: K): OLBoolean;
begin
  if Assigned(FDict) then
    Result := FDict.ContainsKey(Key)
  else
    Result := False;
end;

function OLGenericDictionary<K, V>.Count: Integer;
begin
  if Assigned(FDict) then
    Result := FDict.Count
  else
    Result := 0;
end;

function OLGenericDictionary<K, V>.GetEnumerator: TDictionary<K, V>.TPairEnumerator;
begin
  if not Assigned(FDict) then
    FDict := TDictionary<K, V>.Create;
  Result := FDict.GetEnumerator;
end;

function OLGenericDictionary<K, V>.GetKeys: TArray<K>;
begin
  if Assigned(FDict) then
    Result := FDict.Keys.ToArray
  else
    SetLength(Result, 0);
end;

function OLGenericDictionary<K, V>.GetValue(const Key: K): V;
begin
  if not Assigned(FDict) or not FDict.TryGetValue(Key, Result) then
  begin
    Result := Default(V);
  end;
end;

procedure OLGenericDictionary<K, V>.SetValue(const Key: K; const Value: V);
begin
  if Assigned(FDict) then
    FDict.AddOrSetValue(Key, Value);
end;

function OLGenericDictionary<K, V>.ToArray: TArray<TPair<K, V>>;
begin
  if Assigned(FDict) then
    Result := FDict.ToArray
  else
    SetLength(Result, 0);
end;


{ OLIntIntDictionary }

{$IF CompilerVersion >= 31.0}
class operator OLIntIntDictionary.Assign(var Dest: OLIntIntDictionary; const [ref] Src: OLIntIntDictionary);
{$ELSE}
class operator OLIntIntDictionary.Assign(var Dest: OLIntIntDictionary; const Src: OLIntIntDictionary);
{$IFEND}
begin
  Dest.FEngine := Src.FEngine;
end;



procedure OLIntIntDictionary.Clear;
begin
  FEngine.Clear;
end;

procedure OLIntIntDictionary.Add(const Key: Integer; const Value: OLInteger);
begin
  FEngine.Add(Key, Value);
end;

function OLIntIntDictionary.Remove(const Key: Integer): OLBoolean;
begin
  Result := FEngine.Remove(Key);
end;

function OLIntIntDictionary.TryGetValue(const Key: Integer; out Value: OLInteger): OLBoolean;
begin
  Result := FEngine.TryGetValue(Key, Value);
end;

function OLIntIntDictionary.ContainsKey(const Key: Integer): OLBoolean;
begin
  Result := FEngine.ContainsKey(Key);
end;

function OLIntIntDictionary.ContainsValue(const Value: OLInteger): OLBoolean;
var
  Pair: TPair<Integer, OLInteger>;
begin
  for Pair in FEngine do
  begin
    if Pair.Value = Value then
      Exit(True);
  end;
  Result := False;
end;

function OLIntIntDictionary.Count: Integer;
begin
  Result := FEngine.Count;
end;

function OLIntIntDictionary.GetEnumerator: TDictionary<Integer, OLInteger>.TPairEnumerator;
begin
  Result := FEngine.GetEnumerator;
end;

function OLIntIntDictionary.ToArray: TArray<TPair<Integer, OLInteger>>;
begin
  Result := FEngine.ToArray;
end;

function OLIntIntDictionary.GetValue(const Key: Integer): OLInteger;
begin
  Result := FEngine.GetValue(Key);
end;

procedure OLIntIntDictionary.SetValue(const Key: Integer; const Value: OLInteger);
begin
  FEngine.SetValue(Key, Value);
end;

function OLIntIntDictionary.GetKeys: TArray<Integer>;
begin
  Result := FEngine.GetKeys;
end;
{ OLIntStrDictionary }

{$IF CompilerVersion >= 31.0}
class operator OLIntStrDictionary.Assign(var Dest: OLIntStrDictionary; const [ref] Src: OLIntStrDictionary);
{$ELSE}
class operator OLIntStrDictionary.Assign(var Dest: OLIntStrDictionary; const Src: OLIntStrDictionary);
{$IFEND}
begin
  Dest.FEngine := Src.FEngine;
end;



procedure OLIntStrDictionary.Clear;
begin
  FEngine.Clear;
end;

procedure OLIntStrDictionary.Add(const Key: Integer; const Value: OLString);
begin
  FEngine.Add(Key, Value);
end;

function OLIntStrDictionary.Remove(const Key: Integer): OLBoolean;
begin
  Result := FEngine.Remove(Key);
end;

function OLIntStrDictionary.TryGetValue(const Key: Integer; out Value: OLString): OLBoolean;
begin
  Result := FEngine.TryGetValue(Key, Value);
end;

function OLIntStrDictionary.ContainsKey(const Key: Integer): OLBoolean;
begin
  Result := FEngine.ContainsKey(Key);
end;

function OLIntStrDictionary.ContainsValue(const Value: OLString): OLBoolean;
var
  Pair: TPair<Integer, OLString>;
begin
  for Pair in FEngine do
  begin
    if Pair.Value = Value then
      Exit(True);
  end;
  Result := False;
end;

function OLIntStrDictionary.Count: Integer;
begin
  Result := FEngine.Count;
end;

function OLIntStrDictionary.GetEnumerator: TDictionary<Integer, OLString>.TPairEnumerator;
begin
  Result := FEngine.GetEnumerator;
end;

function OLIntStrDictionary.ToArray: TArray<TPair<Integer, OLString>>;
begin
  Result := FEngine.ToArray;
end;

function OLIntStrDictionary.GetValue(const Key: Integer): OLString;
begin
  Result := FEngine.GetValue(Key);
end;

procedure OLIntStrDictionary.SetValue(const Key: Integer; const Value: OLString);
begin
  FEngine.SetValue(Key, Value);
end;

function OLIntStrDictionary.GetKeys: TArray<Integer>;
begin
  Result := FEngine.GetKeys;
end;
{ OLIntDblDictionary }

{$IF CompilerVersion >= 31.0}
class operator OLIntDblDictionary.Assign(var Dest: OLIntDblDictionary; const [ref] Src: OLIntDblDictionary);
{$ELSE}
class operator OLIntDblDictionary.Assign(var Dest: OLIntDblDictionary; const Src: OLIntDblDictionary);
{$IFEND}
begin
  Dest.FEngine := Src.FEngine;
end;



procedure OLIntDblDictionary.Clear;
begin
  FEngine.Clear;
end;

procedure OLIntDblDictionary.Add(const Key: Integer; const Value: OLDouble);
begin
  FEngine.Add(Key, Value);
end;

function OLIntDblDictionary.Remove(const Key: Integer): OLBoolean;
begin
  Result := FEngine.Remove(Key);
end;

function OLIntDblDictionary.TryGetValue(const Key: Integer; out Value: OLDouble): OLBoolean;
begin
  Result := FEngine.TryGetValue(Key, Value);
end;

function OLIntDblDictionary.ContainsKey(const Key: Integer): OLBoolean;
begin
  Result := FEngine.ContainsKey(Key);
end;

function OLIntDblDictionary.ContainsValue(const Value: OLDouble): OLBoolean;
var
  Pair: TPair<Integer, OLDouble>;
begin
  for Pair in FEngine do
  begin
    if Pair.Value = Value then
      Exit(True);
  end;
  Result := False;
end;

function OLIntDblDictionary.Count: Integer;
begin
  Result := FEngine.Count;
end;

function OLIntDblDictionary.GetEnumerator: TDictionary<Integer, OLDouble>.TPairEnumerator;
begin
  Result := FEngine.GetEnumerator;
end;

function OLIntDblDictionary.ToArray: TArray<TPair<Integer, OLDouble>>;
begin
  Result := FEngine.ToArray;
end;

function OLIntDblDictionary.GetValue(const Key: Integer): OLDouble;
begin
  Result := FEngine.GetValue(Key);
end;

procedure OLIntDblDictionary.SetValue(const Key: Integer; const Value: OLDouble);
begin
  FEngine.SetValue(Key, Value);
end;

function OLIntDblDictionary.GetKeys: TArray<Integer>;
begin
  Result := FEngine.GetKeys;
end;
{ OLIntCurrDictionary }

{$IF CompilerVersion >= 31.0}
class operator OLIntCurrDictionary.Assign(var Dest: OLIntCurrDictionary; const [ref] Src: OLIntCurrDictionary);
{$ELSE}
class operator OLIntCurrDictionary.Assign(var Dest: OLIntCurrDictionary; const Src: OLIntCurrDictionary);
{$IFEND}
begin
  Dest.FEngine := Src.FEngine;
end;



procedure OLIntCurrDictionary.Clear;
begin
  FEngine.Clear;
end;

procedure OLIntCurrDictionary.Add(const Key: Integer; const Value: OLCurrency);
begin
  FEngine.Add(Key, Value);
end;

function OLIntCurrDictionary.Remove(const Key: Integer): OLBoolean;
begin
  Result := FEngine.Remove(Key);
end;

function OLIntCurrDictionary.TryGetValue(const Key: Integer; out Value: OLCurrency): OLBoolean;
begin
  Result := FEngine.TryGetValue(Key, Value);
end;

function OLIntCurrDictionary.ContainsKey(const Key: Integer): OLBoolean;
begin
  Result := FEngine.ContainsKey(Key);
end;

function OLIntCurrDictionary.ContainsValue(const Value: OLCurrency): OLBoolean;
var
  Pair: TPair<Integer, OLCurrency>;
begin
  for Pair in FEngine do
  begin
    if Pair.Value = Value then
      Exit(True);
  end;
  Result := False;
end;

function OLIntCurrDictionary.Count: Integer;
begin
  Result := FEngine.Count;
end;

function OLIntCurrDictionary.GetEnumerator: TDictionary<Integer, OLCurrency>.TPairEnumerator;
begin
  Result := FEngine.GetEnumerator;
end;

function OLIntCurrDictionary.ToArray: TArray<TPair<Integer, OLCurrency>>;
begin
  Result := FEngine.ToArray;
end;

function OLIntCurrDictionary.GetValue(const Key: Integer): OLCurrency;
begin
  Result := FEngine.GetValue(Key);
end;

procedure OLIntCurrDictionary.SetValue(const Key: Integer; const Value: OLCurrency);
begin
  FEngine.SetValue(Key, Value);
end;

function OLIntCurrDictionary.GetKeys: TArray<Integer>;
begin
  Result := FEngine.GetKeys;
end;
{ OLIntBooleanDictionary }

{$IF CompilerVersion >= 31.0}
class operator OLIntBooleanDictionary.Assign(var Dest: OLIntBooleanDictionary; const [ref] Src: OLIntBooleanDictionary);
{$ELSE}
class operator OLIntBooleanDictionary.Assign(var Dest: OLIntBooleanDictionary; const Src: OLIntBooleanDictionary);
{$IFEND}
begin
  Dest.FEngine := Src.FEngine;
end;



procedure OLIntBooleanDictionary.Clear;
begin
  FEngine.Clear;
end;

procedure OLIntBooleanDictionary.Add(const Key: Integer; const Value: OLBoolean);
begin
  FEngine.Add(Key, Value);
end;

function OLIntBooleanDictionary.Remove(const Key: Integer): OLBoolean;
begin
  Result := FEngine.Remove(Key);
end;

function OLIntBooleanDictionary.TryGetValue(const Key: Integer; out Value: OLBoolean): OLBoolean;
begin
  Result := FEngine.TryGetValue(Key, Value);
end;

function OLIntBooleanDictionary.ContainsKey(const Key: Integer): OLBoolean;
begin
  Result := FEngine.ContainsKey(Key);
end;

function OLIntBooleanDictionary.ContainsValue(const Value: OLBoolean): OLBoolean;
var
  Pair: TPair<Integer, OLBoolean>;
begin
  for Pair in FEngine do
  begin
    if Pair.Value = Value then
      Exit(True);
  end;
  Result := False;
end;

function OLIntBooleanDictionary.Count: Integer;
begin
  Result := FEngine.Count;
end;

function OLIntBooleanDictionary.GetEnumerator: TDictionary<Integer, OLBoolean>.TPairEnumerator;
begin
  Result := FEngine.GetEnumerator;
end;

function OLIntBooleanDictionary.ToArray: TArray<TPair<Integer, OLBoolean>>;
begin
  Result := FEngine.ToArray;
end;

function OLIntBooleanDictionary.GetValue(const Key: Integer): OLBoolean;
begin
  Result := FEngine.GetValue(Key);
end;

procedure OLIntBooleanDictionary.SetValue(const Key: Integer; const Value: OLBoolean);
begin
  FEngine.SetValue(Key, Value);
end;

function OLIntBooleanDictionary.GetKeys: TArray<Integer>;
begin
  Result := FEngine.GetKeys;
end;
{ OLIntDateDictionary }

{$IF CompilerVersion >= 31.0}
class operator OLIntDateDictionary.Assign(var Dest: OLIntDateDictionary; const [ref] Src: OLIntDateDictionary);
{$ELSE}
class operator OLIntDateDictionary.Assign(var Dest: OLIntDateDictionary; const Src: OLIntDateDictionary);
{$IFEND}
begin
  Dest.FEngine := Src.FEngine;
end;



procedure OLIntDateDictionary.Clear;
begin
  FEngine.Clear;
end;

procedure OLIntDateDictionary.Add(const Key: Integer; const Value: OLDate);
begin
  FEngine.Add(Key, Value);
end;

function OLIntDateDictionary.Remove(const Key: Integer): OLBoolean;
begin
  Result := FEngine.Remove(Key);
end;

function OLIntDateDictionary.TryGetValue(const Key: Integer; out Value: OLDate): OLBoolean;
begin
  Result := FEngine.TryGetValue(Key, Value);
end;

function OLIntDateDictionary.ContainsKey(const Key: Integer): OLBoolean;
begin
  Result := FEngine.ContainsKey(Key);
end;

function OLIntDateDictionary.ContainsValue(const Value: OLDate): OLBoolean;
var
  Pair: TPair<Integer, OLDate>;
begin
  for Pair in FEngine do
  begin
    if Pair.Value = Value then
      Exit(True);
  end;
  Result := False;
end;

function OLIntDateDictionary.Count: Integer;
begin
  Result := FEngine.Count;
end;

function OLIntDateDictionary.GetEnumerator: TDictionary<Integer, OLDate>.TPairEnumerator;
begin
  Result := FEngine.GetEnumerator;
end;

function OLIntDateDictionary.ToArray: TArray<TPair<Integer, OLDate>>;
begin
  Result := FEngine.ToArray;
end;

function OLIntDateDictionary.GetValue(const Key: Integer): OLDate;
begin
  Result := FEngine.GetValue(Key);
end;

procedure OLIntDateDictionary.SetValue(const Key: Integer; const Value: OLDate);
begin
  FEngine.SetValue(Key, Value);
end;

function OLIntDateDictionary.GetKeys: TArray<Integer>;
begin
  Result := FEngine.GetKeys;
end;
{ OLStrStrDictionary }

{$IF CompilerVersion >= 31.0}
class operator OLStrStrDictionary.Assign(var Dest: OLStrStrDictionary; const [ref] Src: OLStrStrDictionary);
{$ELSE}
class operator OLStrStrDictionary.Assign(var Dest: OLStrStrDictionary; const Src: OLStrStrDictionary);
{$IFEND}
begin
  Dest.FEngine := Src.FEngine;
end;



procedure OLStrStrDictionary.Clear;
begin
  FEngine.Clear;
end;

procedure OLStrStrDictionary.Add(const Key: string; const Value: OLString);
begin
  FEngine.Add(Key, Value);
end;

function OLStrStrDictionary.Remove(const Key: string): OLBoolean;
begin
  Result := FEngine.Remove(Key);
end;

function OLStrStrDictionary.TryGetValue(const Key: string; out Value: OLString): OLBoolean;
begin
  Result := FEngine.TryGetValue(Key, Value);
end;

function OLStrStrDictionary.ContainsKey(const Key: string): OLBoolean;
begin
  Result := FEngine.ContainsKey(Key);
end;

function OLStrStrDictionary.ContainsValue(const Value: OLString): OLBoolean;
var
  Pair: TPair<string, OLString>;
begin
  for Pair in FEngine do
  begin
    if Pair.Value = Value then
      Exit(True);
  end;
  Result := False;
end;

function OLStrStrDictionary.Count: Integer;
begin
  Result := FEngine.Count;
end;

function OLStrStrDictionary.GetEnumerator: TDictionary<string, OLString>.TPairEnumerator;
begin
  Result := FEngine.GetEnumerator;
end;

function OLStrStrDictionary.ToArray: TArray<TPair<string, OLString>>;
begin
  Result := FEngine.ToArray;
end;

function OLStrStrDictionary.GetValue(const Key: string): OLString;
begin
  Result := FEngine.GetValue(Key);
end;

procedure OLStrStrDictionary.SetValue(const Key: string; const Value: OLString);
begin
  FEngine.SetValue(Key, Value);
end;

function OLStrStrDictionary.GetKeys: TArray<string>;
begin
  Result := FEngine.GetKeys;
end;
{ OLStrIntDictionary }

{$IF CompilerVersion >= 31.0}
class operator OLStrIntDictionary.Assign(var Dest: OLStrIntDictionary; const [ref] Src: OLStrIntDictionary);
{$ELSE}
class operator OLStrIntDictionary.Assign(var Dest: OLStrIntDictionary; const Src: OLStrIntDictionary);
{$IFEND}
begin
  Dest.FEngine := Src.FEngine;
end;



procedure OLStrIntDictionary.Clear;
begin
  FEngine.Clear;
end;

procedure OLStrIntDictionary.Add(const Key: string; const Value: OLInteger);
begin
  FEngine.Add(Key, Value);
end;

function OLStrIntDictionary.Remove(const Key: string): OLBoolean;
begin
  Result := FEngine.Remove(Key);
end;

function OLStrIntDictionary.TryGetValue(const Key: string; out Value: OLInteger): OLBoolean;
begin
  Result := FEngine.TryGetValue(Key, Value);
end;

function OLStrIntDictionary.ContainsKey(const Key: string): OLBoolean;
begin
  Result := FEngine.ContainsKey(Key);
end;

function OLStrIntDictionary.ContainsValue(const Value: OLInteger): OLBoolean;
var
  Pair: TPair<string, OLInteger>;
begin
  for Pair in FEngine do
  begin
    if Pair.Value = Value then
      Exit(True);
  end;
  Result := False;
end;

function OLStrIntDictionary.Count: Integer;
begin
  Result := FEngine.Count;
end;

function OLStrIntDictionary.GetEnumerator: TDictionary<string, OLInteger>.TPairEnumerator;
begin
  Result := FEngine.GetEnumerator;
end;

function OLStrIntDictionary.ToArray: TArray<TPair<string, OLInteger>>;
begin
  Result := FEngine.ToArray;
end;

function OLStrIntDictionary.GetValue(const Key: string): OLInteger;
begin
  Result := FEngine.GetValue(Key);
end;

procedure OLStrIntDictionary.SetValue(const Key: string; const Value: OLInteger);
begin
  FEngine.SetValue(Key, Value);
end;

function OLStrIntDictionary.GetKeys: TArray<string>;
begin
  Result := FEngine.GetKeys;
end;
{ OLStrCurrDictionary }

{$IF CompilerVersion >= 31.0}
class operator OLStrCurrDictionary.Assign(var Dest: OLStrCurrDictionary; const [ref] Src: OLStrCurrDictionary);
{$ELSE}
class operator OLStrCurrDictionary.Assign(var Dest: OLStrCurrDictionary; const Src: OLStrCurrDictionary);
{$IFEND}
begin
  Dest.FEngine := Src.FEngine;
end;



procedure OLStrCurrDictionary.Clear;
begin
  FEngine.Clear;
end;

procedure OLStrCurrDictionary.Add(const Key: string; const Value: OLCurrency);
begin
  FEngine.Add(Key, Value);
end;

function OLStrCurrDictionary.Remove(const Key: string): OLBoolean;
begin
  Result := FEngine.Remove(Key);
end;

function OLStrCurrDictionary.TryGetValue(const Key: string; out Value: OLCurrency): OLBoolean;
begin
  Result := FEngine.TryGetValue(Key, Value);
end;

function OLStrCurrDictionary.ContainsKey(const Key: string): OLBoolean;
begin
  Result := FEngine.ContainsKey(Key);
end;

function OLStrCurrDictionary.ContainsValue(const Value: OLCurrency): OLBoolean;
var
  Pair: TPair<string, OLCurrency>;
begin
  for Pair in FEngine do
  begin
    if Pair.Value = Value then
      Exit(True);
  end;
  Result := False;
end;

function OLStrCurrDictionary.Count: Integer;
begin
  Result := FEngine.Count;
end;

function OLStrCurrDictionary.GetEnumerator: TDictionary<string, OLCurrency>.TPairEnumerator;
begin
  Result := FEngine.GetEnumerator;
end;

function OLStrCurrDictionary.ToArray: TArray<TPair<string, OLCurrency>>;
begin
  Result := FEngine.ToArray;
end;

function OLStrCurrDictionary.GetValue(const Key: string): OLCurrency;
begin
  Result := FEngine.GetValue(Key);
end;

procedure OLStrCurrDictionary.SetValue(const Key: string; const Value: OLCurrency);
begin
  FEngine.SetValue(Key, Value);
end;

function OLStrCurrDictionary.GetKeys: TArray<string>;
begin
  Result := FEngine.GetKeys;
end;
{ OLStrDblDictionary }

{$IF CompilerVersion >= 31.0}
class operator OLStrDblDictionary.Assign(var Dest: OLStrDblDictionary; const [ref] Src: OLStrDblDictionary);
{$ELSE}
class operator OLStrDblDictionary.Assign(var Dest: OLStrDblDictionary; const Src: OLStrDblDictionary);
{$IFEND}
begin
  Dest.FEngine := Src.FEngine;
end;



procedure OLStrDblDictionary.Clear;
begin
  FEngine.Clear;
end;

procedure OLStrDblDictionary.Add(const Key: string; const Value: OLDouble);
begin
  FEngine.Add(Key, Value);
end;

function OLStrDblDictionary.Remove(const Key: string): OLBoolean;
begin
  Result := FEngine.Remove(Key);
end;

function OLStrDblDictionary.TryGetValue(const Key: string; out Value: OLDouble): OLBoolean;
begin
  Result := FEngine.TryGetValue(Key, Value);
end;

function OLStrDblDictionary.ContainsKey(const Key: string): OLBoolean;
begin
  Result := FEngine.ContainsKey(Key);
end;

function OLStrDblDictionary.ContainsValue(const Value: OLDouble): OLBoolean;
var
  Pair: TPair<string, OLDouble>;
begin
  for Pair in FEngine do
  begin
    if Pair.Value = Value then
      Exit(True);
  end;
  Result := False;
end;

function OLStrDblDictionary.Count: Integer;
begin
  Result := FEngine.Count;
end;

function OLStrDblDictionary.GetEnumerator: TDictionary<string, OLDouble>.TPairEnumerator;
begin
  Result := FEngine.GetEnumerator;
end;

function OLStrDblDictionary.ToArray: TArray<TPair<string, OLDouble>>;
begin
  Result := FEngine.ToArray;
end;

function OLStrDblDictionary.GetValue(const Key: string): OLDouble;
begin
  Result := FEngine.GetValue(Key);
end;

procedure OLStrDblDictionary.SetValue(const Key: string; const Value: OLDouble);
begin
  FEngine.SetValue(Key, Value);
end;

function OLStrDblDictionary.GetKeys: TArray<string>;
begin
  Result := FEngine.GetKeys;
end;
{$IFEND}
end.