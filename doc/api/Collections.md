# Collections

The OLTypes library provides specialized collection types (Arrays and Dictionaries) optimized for working with `OL` types. These collections handle memory management automatically and provide a fluent interface for common operations like sorting, filtering, and conversion.

## Arrays (OLArrays)

`OLArrays` are dynamic array wrappers that support `OL` types and provide methods for manipulation, sorting, and distinct values.

### Available Array Types
- `OLIntegerArray`
- `OLStringArray`
- `OLBooleanArray`
- `OLCurrencyArray`
- `OLDateTimeArray`
- `OLDateArray`
- `OLDoubleArray`
- `OLInt64Array`

### Core Methods
| Method | Description |
| :--- | :--- |
| `Add(Value)` | Appends a value to the array. |
| `Insert(Index, Value)`| Inserts a value at the specified position. |
| `Delete(Index)` | Removes the item at the specified index. |
| `Clear()` | Empties the array. |
| `Sort()` | Sorts the array in-place. |
| `Sorted()` | Returns a new sorted copy. |
| `ContainsValue(v)` | Returns `True` if the value exists in the array. |
| `Distinct()` | Returns a new array with unique values only. |
| `Reversed()` | Returns a new array with items in reverse order. |
| `Length` | Property to get or set (resize) the number of elements. |

### Array Examples
```delphi
var
  arr: OLIntegerArray;
  v: OLInteger;
begin
  arr := [10, 5, 20, 5, 30]; // Implicit conversion from native array
  arr.Add(15);
  
  arr.Sort; 
  // arr is [5, 5, 10, 15, 20, 30]
  
  for v in arr.Distinct do
    Writeln(v.ToString); // 5, 10, 15, 20, 30
end;
```

---

## Dictionaries (OLDictionaries)

`OLDictionaries` are specialized wrappers for `TDictionary<K, V>`, providing automatic initialization, finalization, and value-based assignment.

### Available Dictionary Types
- `OLIntIntDictionary` (Integer -> OLInteger)
- `OLIntStrDictionary` (Integer -> OLString)
- `OLIntDblDictionary` (Integer -> OLDouble)
- `OLIntCurrDictionary` (Integer -> OLCurrency)
- `OLIntBooleanDictionary` (Integer -> OLBoolean)
- `OLIntDateDictionary` (Integer -> OLDate)
- `OLStrStrDictionary` (string -> OLString)
- `OLStrIntDictionary` (string -> OLInteger)
- `OLStrCurrDictionary` (string -> OLCurrency)
- `OLStrDblDictionary` (string -> OLDouble)

### Core Methods
| Method | Description |
| :--- | :--- |
| `Add(Key, Value)` | Adds a new entry. |
| `Remove(Key)` | Removes the entry with the specified key. |
| `TryGetValue(Key, out)`| Safely retrieves a value. |
| `ContainsKey(Key)` | Checks if key exists. |
| `Count` | Returns the number of entries. |
| `Clear()` | Removes all entries. |
| `Keys` | Property returning an array of all keys. |

### Dictionary Examples
```delphi
var
  prices: OLStrCurrDictionary;
begin
  prices['Apple'] := 1.50;
  prices['Orange'] := 2.00;
  
  if prices.ContainsKey('Apple') then
    Writeln('Apple price: ' + prices['Apple'].ToString);
    
  Writeln('Total items: ' + IntToStr(prices.Count));
end;
```

---

## Technical Features

### Fluent API
Many methods return a new collection, allowing for method chaining:
```delphi
var
  processed: OLStringArray;
begin
  processed := original.Distinct.Sorted.Reversed;
end;
```

### Automatic Memory Management
Since these are value types (using `Initialize`/`Finalize` in newer Delphi versions, or reference counting wrappers), you don't need to manually call `Create` or `Free` for most common usage patterns.

### Implicit Conversions
Collections support conversion to/from standard Delphi dynamic arrays (`TArray<T>`):
```delphi
var
  nativeArr: TArray<Integer>;
  olArr: OLIntegerArray;
begin
  nativeArr := [1, 2, 3];
  olArr := nativeArr; // Implicitly converts to OLIntegerArray
end;
```
