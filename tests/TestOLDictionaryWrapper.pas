unit TestOLDictionaryWrapper;

interface

{$IF CompilerVersion >= 34.0}

uses
  TestFramework,
  System.SysUtils,
  System.Generics.Collections,
  OLTypes;

type
  TTestOLDictionaryWrapper = class(TTestCase)
  published
    procedure TestAddAndCount;
    procedure TestRemove;
    procedure TestClear;
    procedure TestTryGetValue;
    procedure TestContainsKey;
    procedure TestValuesProperty;
    procedure TestKeys;
    procedure TestToArray;
    procedure TestEnumerator;
    procedure TestAssign;
  end;

{$IFEND}

implementation

{$IF CompilerVersion >= 34.0}

{ TTestOLDictionaryWrapper }

procedure TTestOLDictionaryWrapper.TestAddAndCount;
var
  Dict: OLDictionary<Integer, OLString>;
begin
  Dict.Clear;
  CheckEquals(0, Dict.Count);
  Dict.Add(1, 'One');
  CheckEquals(1, Dict.Count);
  Dict.Add(2, 'Two');
  CheckEquals(2, Dict.Count);
end;

procedure TTestOLDictionaryWrapper.TestRemove;
var
  Dict: OLDictionary<Integer, OLString>;
begin
  Dict.Clear;
  Dict.Add(1, 'One');
  CheckTrue(Dict.Remove(1));
  CheckEquals(0, Dict.Count);
  CheckFalse(Dict.Remove(99));
end;

procedure TTestOLDictionaryWrapper.TestClear;
var
  Dict: OLDictionary<Integer, OLString>;
begin
  Dict.Add(1, 'One');
  Dict.Clear;
  CheckEquals(0, Dict.Count);
end;

procedure TTestOLDictionaryWrapper.TestTryGetValue;
var
  Dict: OLDictionary<Integer, OLString>;
  Val: OLString;
begin
  Dict.Clear;
  Dict.Add(1, 'One');
  CheckTrue(Dict.TryGetValue(1, Val));
  CheckEquals('One', Val.ToString);
  CheckFalse(Dict.TryGetValue(99, Val));
end;

procedure TTestOLDictionaryWrapper.TestContainsKey;
var
  Dict: OLDictionary<Integer, OLString>;
begin
  Dict.Clear;
  Dict.Add(1, 'One');
  CheckTrue(Dict.ContainsKey(1));
  CheckFalse(Dict.ContainsKey(99));
end;

procedure TTestOLDictionaryWrapper.TestValuesProperty;
var
  Dict: OLDictionary<Integer, OLString>;
begin
  Dict.Clear;
  Dict.Values[1] := 'One';
  CheckEquals('One', Dict.Values[1].ToString);
  Dict[1] := 'NewOne';
  CheckEquals('NewOne', Dict[1].ToString);
end;

procedure TTestOLDictionaryWrapper.TestKeys;
var
  Dict: OLDictionary<Integer, OLString>;
  Keys: TArray<Integer>;
begin
  Dict.Clear;
  Dict.Add(1, 'One');
  Dict.Add(2, 'Two');
  Keys := Dict.Keys;
  CheckEquals(2, Length(Keys));
  CheckTrue((Keys[0] = 1) or (Keys[0] = 2));
  CheckTrue((Keys[1] = 1) or (Keys[1] = 2));
end;

procedure TTestOLDictionaryWrapper.TestToArray;
var
  Dict: OLDictionary<Integer, OLString>;
  Arr: TArray<TPair<Integer, OLString>>;
begin
  Dict.Clear;
  Dict.Add(1, 'One');
  Arr := Dict.ToArray;
  CheckEquals(1, Length(Arr));
  CheckEquals(1, Arr[0].Key);
  CheckEquals('One', Arr[0].Value.ToString);
end;

procedure TTestOLDictionaryWrapper.TestEnumerator;
var
  Dict: OLDictionary<Integer, OLString>;
  Pair: TPair<Integer, OLString>;
  Count: Integer;
begin
  Dict.Clear;
  Dict.Add(1, 'One');
  Dict.Add(2, 'Two');
  Count := 0;
  for Pair in Dict do
  begin
    Inc(Count);
  end;
  CheckEquals(2, Count);
end;

procedure TTestOLDictionaryWrapper.TestAssign;
var
  D1, D2: OLDictionary<Integer, OLString>;
begin
  D1.Clear;
  D1.Add(1, 'One');
  D2 := D1;
  CheckEquals(1, D2.Count);
  CheckEquals('One', D2[1].ToString);
  
  D2[1] := 'Two';
  // Modifying D2 should modify D1 because they share the same FEngine (which is a class instance)?
  // NO! Wait. The wrapper helper methods delegate to FEngine.
  // FEngine is OLGenericDictionary<K, V> which is likely a record wrapping a TDictionary (class)?
  // Let's check OLDictionaries.OLGenericDictionary implementation.
  // If OLGenericDictionary is a record that auto-initializes a class, then assignment copy depends on how it's implemented.
  // If it's a record with a TDictionary field, default assignment copies the reference.
  // But OLTypes.pas defines class operator Assign.
  
  // Checking OLTypes.pas:
  // class operator Assign(var Dest: OLDictionary<K, V>; const [ref] Src: OLDictionary<K, V>);
  // And in implementation (checking previous diffs or assumption):
  // Dest.FEngine := Src.FEngine;
  // If FEngine is a record that behaves like a value type (copy-on-write or deep copy on assign), then they are separate.
  // But if FEngine is just a wrapper around TDictionary and Assign just copies the wrapper...
  
  // Let's look at OLDictionaries.pas to see what generic dictionary is.
  // But strictly speaking, if I implemented Assign in OLTypes.pas to just copy FEngine, 
  // and FEngine is a record from OLDictionaries.
  
  // Let's assume for now they are independent if the underlying implementation supports it, 
  // BUT the OLTypes Assign implementation I saw in the diff was:
  // Dest.FEngine := Src.FEngine;
  // If OLDictionaries.OLGenericDictionary has an Assign operator that does a deep copy, then they are separate.
  // If not, they share the reference.
  
  // In TestOLDictionaries.pas, TestAssign expects independent copies:
  // CheckTrue(D1[1] = 100); // Original should be unchanged
  
  // So I should expect deep copy behavior if it matches other dictionary types.
  
  D2[1] := 'Two';
  CheckEquals('One', D1[1].ToString);
  CheckEquals('Two', D2[1].ToString);
end;

{$IFEND}

initialization
  {$IF CompilerVersion >= 34.0}
  RegisterTest(TTestOLDictionaryWrapper.Suite);
  {$IFEND}
end.
