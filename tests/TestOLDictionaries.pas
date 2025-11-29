unit TestOLDictionaries;

interface

{$IF CompilerVersion >= 34.0}

uses
  TestFramework,
  System.SysUtils,
  System.Generics.Collections,
  OLDictionaries,
  OLBooleanType,
  OLCurrencyType,
  OLDateTimeType,
  OLDateType,
  OLDoubleType,
  OLIntegerType,
  OLInt64Type,
  OLStringType;

type
  TTestOLIntIntDictionary = class(TTestCase)
  published
    procedure TestAddAndCount;
    procedure TestRemove;
    procedure TestClear;
    procedure TestTryGetValue;
    procedure TestContainsKey;
    procedure TestContainsValue;
    procedure TestValuesProperty;
    procedure TestKeys;
    procedure TestToArray;
    procedure TestEnumerator;
    procedure TestAssign;

  end;

  TTestOLIntStrDictionary = class(TTestCase)
  published
    procedure TestAddAndCount;
    procedure TestRemove;
    procedure TestClear;
    procedure TestTryGetValue;
    procedure TestContainsKey;
    procedure TestContainsValue;
    procedure TestValuesProperty;
    procedure TestKeys;
    procedure TestToArray;
    procedure TestEnumerator;
    procedure TestAssign;

  end;

  TTestOLIntDblDictionary = class(TTestCase)
  published
    procedure TestAddAndCount;
    procedure TestRemove;
    procedure TestClear;
    procedure TestTryGetValue;
    procedure TestContainsKey;
    procedure TestContainsValue;
    procedure TestValuesProperty;
    procedure TestKeys;
    procedure TestToArray;
    procedure TestEnumerator;
    procedure TestAssign;

  end;

  TTestOLIntCurrDictionary = class(TTestCase)
  published
    procedure TestAddAndCount;
    procedure TestRemove;
    procedure TestClear;
    procedure TestTryGetValue;
    procedure TestContainsKey;
    procedure TestContainsValue;
    procedure TestValuesProperty;
    procedure TestKeys;
    procedure TestToArray;
    procedure TestEnumerator;
    procedure TestAssign;

  end;

  TTestOLIntBooleanDictionary = class(TTestCase)
  published
    procedure TestAddAndCount;
    procedure TestRemove;
    procedure TestClear;
    procedure TestTryGetValue;
    procedure TestContainsKey;
    procedure TestContainsValue;
    procedure TestValuesProperty;
    procedure TestKeys;
    procedure TestToArray;
    procedure TestEnumerator;
    procedure TestAssign;

  end;

  TTestOLIntDateDictionary = class(TTestCase)
  published
    procedure TestAddAndCount;
    procedure TestRemove;
    procedure TestClear;
    procedure TestTryGetValue;
    procedure TestContainsKey;
    procedure TestContainsValue;
    procedure TestValuesProperty;
    procedure TestKeys;
    procedure TestToArray;
    procedure TestEnumerator;
    procedure TestAssign;

  end;

  TTestOLStrStrDictionary = class(TTestCase)
  published
    procedure TestAddAndCount;
    procedure TestRemove;
    procedure TestClear;
    procedure TestTryGetValue;
    procedure TestContainsKey;
    procedure TestContainsValue;
    procedure TestValuesProperty;
    procedure TestKeys;
    procedure TestToArray;
    procedure TestEnumerator;
    procedure TestAssign;

  end;

  TTestOLStrIntDictionary = class(TTestCase)
  published
    procedure TestAddAndCount;
    procedure TestRemove;
    procedure TestClear;
    procedure TestTryGetValue;
    procedure TestContainsKey;
    procedure TestContainsValue;
    procedure TestValuesProperty;
    procedure TestKeys;
    procedure TestToArray;
    procedure TestEnumerator;
    procedure TestAssign;

  end;

  TTestOLStrCurrDictionary = class(TTestCase)
  published
    procedure TestAddAndCount;
    procedure TestRemove;
    procedure TestClear;
    procedure TestTryGetValue;
    procedure TestContainsKey;
    procedure TestContainsValue;
    procedure TestValuesProperty;
    procedure TestKeys;
    procedure TestToArray;
    procedure TestEnumerator;
    procedure TestAssign;

  end;

  TTestOLStrDblDictionary = class(TTestCase)
  published
    procedure TestAddAndCount;
    procedure TestRemove;
    procedure TestClear;
    procedure TestTryGetValue;
    procedure TestContainsKey;
    procedure TestContainsValue;
    procedure TestValuesProperty;
    procedure TestKeys;
    procedure TestToArray;
    procedure TestEnumerator;
    procedure TestAssign;

  end;

{$IFEND}

implementation

{$IF CompilerVersion >= 34.0}

{ TTestOLIntIntDictionary }

procedure TTestOLIntIntDictionary.TestAddAndCount;
var
  Dict: OLIntIntDictionary;
begin
  Dict.Clear;
  CheckEquals(0, Dict.Count);
  Dict.Add(1, 100);
  CheckEquals(1, Dict.Count);
  Dict.Add(2, 200);
  CheckEquals(2, Dict.Count);
end;

procedure TTestOLIntIntDictionary.TestRemove;
var
  Dict: OLIntIntDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 100);
  CheckTrue(Dict.Remove(1));
  CheckEquals(0, Dict.Count);
  CheckFalse(Dict.Remove(99));
end;

procedure TTestOLIntIntDictionary.TestClear;
var
  Dict: OLIntIntDictionary;
begin
  Dict.Add(1, 100);
  Dict.Clear;
  CheckEquals(0, Dict.Count);
end;

procedure TTestOLIntIntDictionary.TestTryGetValue;
var
  Dict: OLIntIntDictionary;
  Val: OLInteger;
begin
  Dict.Clear;
  Dict.Add(1, 100);
  CheckTrue(Dict.TryGetValue(1, Val));
  CheckTrue(Val = 100);
  CheckFalse(Dict.TryGetValue(99, Val));
end;

procedure TTestOLIntIntDictionary.TestContainsKey;
var
  Dict: OLIntIntDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 100);
  CheckTrue(Dict.ContainsKey(1));
  CheckFalse(Dict.ContainsKey(99));
end;

procedure TTestOLIntIntDictionary.TestContainsValue;
var
  Dict: OLIntIntDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 100);
  CheckTrue(Dict.ContainsValue(100));
  CheckFalse(Dict.ContainsValue(200));
end;

procedure TTestOLIntIntDictionary.TestValuesProperty;
var
  Dict: OLIntIntDictionary;
begin
  Dict.Clear;
  Dict.Values[1] := 100;
  CheckTrue(Dict.Values[1] = 100);
  Dict[1] := 200;
  CheckTrue(Dict[1] = 200);
end;

procedure TTestOLIntIntDictionary.TestKeys;
var
  Dict: OLIntIntDictionary;
  Keys: TArray<Integer>;
begin
  Dict.Clear;
  Dict.Add(1, 100);
  Dict.Add(2, 200);
  Keys := Dict.Keys;
  CheckEquals(2, Length(Keys));
  // Order is not guaranteed, so just check existence
  CheckTrue((Keys[0] = 1) or (Keys[0] = 2));
  CheckTrue((Keys[1] = 1) or (Keys[1] = 2));
end;

procedure TTestOLIntIntDictionary.TestToArray;
var
  Dict: OLIntIntDictionary;
  Arr: TArray<TPair<Integer, OLInteger>>;
begin
  Dict.Clear;
  Dict.Add(1, 100);
  Arr := Dict.ToArray;
  CheckEquals(1, Length(Arr));
  CheckEquals(1, Arr[0].Key);
  CheckTrue(Arr[0].Value = 100);
end;

procedure TTestOLIntIntDictionary.TestEnumerator;
var
  Dict: OLIntIntDictionary;
  Pair: TPair<Integer, OLInteger>;
  Count: Integer;
begin
  Dict.Clear;
  Dict.Add(1, 100);
  Dict.Add(2, 200);
  Count := 0;
  for Pair in Dict do
  begin
    Inc(Count);
  end;
  CheckEquals(2, Count);
end;

procedure TTestOLIntIntDictionary.TestAssign;
var
  D1, D2: OLIntIntDictionary;
begin
  D1.Clear;
  D1.Add(1, 100);
  D2 := D1;
  CheckEquals(1, D2.Count);
  CheckTrue(D2[1] = 100);
  
  D2[1] := 200;
  // Should be separate if it was a deep copy, but TDictionary is a reference type.
  // Wait, OLGenericDictionary wraps TDictionary. Assign operator does a copy.
  // Let's verify if Assign creates a new dictionary or copies reference.
  // The implementation of Assign in OLDictionaries.pas does:
  // Dest.FDict.Clear; ... for Pair in Src.FDict do Dest.FDict.AddOrSetValue...
  // So it is a deep copy of the content.
  CheckTrue(D1[1] = 100); // Original should be unchanged
  CheckTrue(D2[1] = 200);
end;



{ TTestOLIntStrDictionary }

procedure TTestOLIntStrDictionary.TestAddAndCount;
var
  Dict: OLIntStrDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 'A');
  CheckEquals(1, Dict.Count);
end;

procedure TTestOLIntStrDictionary.TestRemove;
var
  Dict: OLIntStrDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 'A');
  CheckTrue(Dict.Remove(1));
  CheckEquals(0, Dict.Count);
end;

procedure TTestOLIntStrDictionary.TestClear;
var
  Dict: OLIntStrDictionary;
begin
  Dict.Add(1, 'A');
  Dict.Clear;
  CheckEquals(0, Dict.Count);
end;

procedure TTestOLIntStrDictionary.TestTryGetValue;
var
  Dict: OLIntStrDictionary;
  Val: OLString;
begin
  Dict.Clear;
  Dict.Add(1, 'A');
  CheckTrue(Dict.TryGetValue(1, Val));
  CheckTrue(Val = 'A');
end;

procedure TTestOLIntStrDictionary.TestContainsKey;
var
  Dict: OLIntStrDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 'A');
  CheckTrue(Dict.ContainsKey(1));
end;

procedure TTestOLIntStrDictionary.TestContainsValue;
var
  Dict: OLIntStrDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 'A');
  CheckTrue(Dict.ContainsValue('A'));
  CheckFalse(Dict.ContainsValue('B'));
end;

procedure TTestOLIntStrDictionary.TestValuesProperty;
var
  Dict: OLIntStrDictionary;
begin
  Dict.Clear;
  Dict[1] := 'A';
  CheckTrue(Dict[1] = 'A');
end;

procedure TTestOLIntStrDictionary.TestKeys;
var
  Dict: OLIntStrDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 'A');
  CheckEquals(1, Length(Dict.Keys));
end;

procedure TTestOLIntStrDictionary.TestToArray;
var
  Dict: OLIntStrDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 'A');
  CheckEquals(1, Length(Dict.ToArray));
end;

procedure TTestOLIntStrDictionary.TestEnumerator;
var
  Dict: OLIntStrDictionary;
  Pair: TPair<Integer, OLString>;
  Count: Integer;
begin
  Dict.Clear;
  Dict.Add(1, 'A');
  Count := 0;
  for Pair in Dict do Inc(Count);
  CheckEquals(1, Count);
end;

procedure TTestOLIntStrDictionary.TestAssign;
var
  D1, D2: OLIntStrDictionary;
begin
  D1.Clear;
  D1.Add(1, 'A');
  D2 := D1;
  CheckTrue(D2[1] = 'A');
  D2[1] := 'B';
  CheckTrue(D1[1] = 'A');
end;



{ TTestOLIntDblDictionary }

procedure TTestOLIntDblDictionary.TestAddAndCount;
var
  Dict: OLIntDblDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 1.5);
  CheckEquals(1, Dict.Count);
end;

procedure TTestOLIntDblDictionary.TestRemove;
var
  Dict: OLIntDblDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 1.5);
  CheckTrue(Dict.Remove(1));
end;

procedure TTestOLIntDblDictionary.TestClear;
var
  Dict: OLIntDblDictionary;
begin
  Dict.Add(1, 1.5);
  Dict.Clear;
  CheckEquals(0, Dict.Count);
end;

procedure TTestOLIntDblDictionary.TestTryGetValue;
var
  Dict: OLIntDblDictionary;
  Val: OLDouble;
begin
  Dict.Clear;
  Dict.Add(1, 1.5);
  CheckTrue(Dict.TryGetValue(1, Val));
  CheckTrue(Val = 1.5);
end;

procedure TTestOLIntDblDictionary.TestContainsKey;
var
  Dict: OLIntDblDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 1.5);
  CheckTrue(Dict.ContainsKey(1));
end;

procedure TTestOLIntDblDictionary.TestContainsValue;
var
  Dict: OLIntDblDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 1.5);
  CheckTrue(Dict.ContainsValue(1.5));
  CheckFalse(Dict.ContainsValue(2.5));
end;

procedure TTestOLIntDblDictionary.TestValuesProperty;
var
  Dict: OLIntDblDictionary;
begin
  Dict.Clear;
  Dict[1] := 1.5;
  CheckTrue(Dict[1] = 1.5);
end;

procedure TTestOLIntDblDictionary.TestKeys;
var
  Dict: OLIntDblDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 1.5);
  CheckEquals(1, Length(Dict.Keys));
end;

procedure TTestOLIntDblDictionary.TestToArray;
var
  Dict: OLIntDblDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 1.5);
  CheckEquals(1, Length(Dict.ToArray));
end;

procedure TTestOLIntDblDictionary.TestEnumerator;
var
  Dict: OLIntDblDictionary;
  Pair: TPair<Integer, OLDouble>;
  Count: Integer;
begin
  Dict.Clear;
  Dict.Add(1, 1.5);
  Count := 0;
  for Pair in Dict do Inc(Count);
  CheckEquals(1, Count);
end;

procedure TTestOLIntDblDictionary.TestAssign;
var
  D1, D2: OLIntDblDictionary;
begin
  D1.Clear;
  D1.Add(1, 1.5);
  D2 := D1;
  CheckTrue(D2[1] = 1.5);
  D2[1] := 2.5;
  CheckTrue(D1[1] = 1.5);
end;



{ TTestOLIntCurrDictionary }

procedure TTestOLIntCurrDictionary.TestAddAndCount;
var
  Dict: OLIntCurrDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 10.5);
  CheckEquals(1, Dict.Count);
end;

procedure TTestOLIntCurrDictionary.TestRemove;
var
  Dict: OLIntCurrDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 10.5);
  CheckTrue(Dict.Remove(1));
end;

procedure TTestOLIntCurrDictionary.TestClear;
var
  Dict: OLIntCurrDictionary;
begin
  Dict.Add(1, 10.5);
  Dict.Clear;
  CheckEquals(0, Dict.Count);
end;

procedure TTestOLIntCurrDictionary.TestTryGetValue;
var
  Dict: OLIntCurrDictionary;
  Val: OLCurrency;
begin
  Dict.Clear;
  Dict.Add(1, 10.5);
  CheckTrue(Dict.TryGetValue(1, Val));
  CheckTrue(Val = 10.5);
end;

procedure TTestOLIntCurrDictionary.TestContainsKey;
var
  Dict: OLIntCurrDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 10.5);
  CheckTrue(Dict.ContainsKey(1));
end;

procedure TTestOLIntCurrDictionary.TestContainsValue;
var
  Dict: OLIntCurrDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 10.5);
  CheckTrue(Dict.ContainsValue(10.5));
  CheckFalse(Dict.ContainsValue(20.5));
end;

procedure TTestOLIntCurrDictionary.TestValuesProperty;
var
  Dict: OLIntCurrDictionary;
begin
  Dict.Clear;
  Dict[1] := 10.5;
  CheckTrue(Dict[1] = 10.5);
end;

procedure TTestOLIntCurrDictionary.TestKeys;
var
  Dict: OLIntCurrDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 10.5);
  CheckEquals(1, Length(Dict.Keys));
end;

procedure TTestOLIntCurrDictionary.TestToArray;
var
  Dict: OLIntCurrDictionary;
begin
  Dict.Clear;
  Dict.Add(1, 10.5);
  CheckEquals(1, Length(Dict.ToArray));
end;

procedure TTestOLIntCurrDictionary.TestEnumerator;
var
  Dict: OLIntCurrDictionary;
  Pair: TPair<Integer, OLCurrency>;
  Count: Integer;
begin
  Dict.Clear;
  Dict.Add(1, 10.5);
  Count := 0;
  for Pair in Dict do Inc(Count);
  CheckEquals(1, Count);
end;

procedure TTestOLIntCurrDictionary.TestAssign;
var
  D1, D2: OLIntCurrDictionary;
begin
  D1.Clear;
  D1.Add(1, 10.5);
  D2 := D1;
  CheckTrue(D2[1] = 10.5);
  D2[1] := 20.5;
  CheckTrue(D1[1] = 10.5);
end;



{ TTestOLIntBooleanDictionary }

procedure TTestOLIntBooleanDictionary.TestAddAndCount;
var
  Dict: OLIntBooleanDictionary;
begin
  Dict.Clear;
  Dict.Add(1, True);
  CheckEquals(1, Dict.Count);
end;

procedure TTestOLIntBooleanDictionary.TestRemove;
var
  Dict: OLIntBooleanDictionary;
begin
  Dict.Clear;
  Dict.Add(1, True);
  CheckTrue(Dict.Remove(1));
end;

procedure TTestOLIntBooleanDictionary.TestClear;
var
  Dict: OLIntBooleanDictionary;
begin
  Dict.Add(1, True);
  Dict.Clear;
  CheckEquals(0, Dict.Count);
end;

procedure TTestOLIntBooleanDictionary.TestTryGetValue;
var
  Dict: OLIntBooleanDictionary;
  Val: OLBoolean;
begin
  Dict.Clear;
  Dict.Add(1, True);
  CheckTrue(Dict.TryGetValue(1, Val));
  CheckTrue(Val = True);
end;

procedure TTestOLIntBooleanDictionary.TestContainsKey;
var
  Dict: OLIntBooleanDictionary;
begin
  Dict.Clear;
  Dict.Add(1, True);
  CheckTrue(Dict.ContainsKey(1));
end;

procedure TTestOLIntBooleanDictionary.TestContainsValue;
var
  Dict: OLIntBooleanDictionary;
begin
  Dict.Clear;
  Dict.Add(1, True);
  CheckTrue(Dict.ContainsValue(True));
  CheckFalse(Dict.ContainsValue(False));
end;

procedure TTestOLIntBooleanDictionary.TestValuesProperty;
var
  Dict: OLIntBooleanDictionary;
begin
  Dict.Clear;
  Dict[1] := True;
  CheckTrue(Dict[1] = True);
end;

procedure TTestOLIntBooleanDictionary.TestKeys;
var
  Dict: OLIntBooleanDictionary;
begin
  Dict.Clear;
  Dict.Add(1, True);
  CheckEquals(1, Length(Dict.Keys));
end;

procedure TTestOLIntBooleanDictionary.TestToArray;
var
  Dict: OLIntBooleanDictionary;
begin
  Dict.Clear;
  Dict.Add(1, True);
  CheckEquals(1, Length(Dict.ToArray));
end;

procedure TTestOLIntBooleanDictionary.TestEnumerator;
var
  Dict: OLIntBooleanDictionary;
  Pair: TPair<Integer, OLBoolean>;
  Count: Integer;
begin
  Dict.Clear;
  Dict.Add(1, True);
  Count := 0;
  for Pair in Dict do Inc(Count);
  CheckEquals(1, Count);
end;

procedure TTestOLIntBooleanDictionary.TestAssign;
var
  D1, D2: OLIntBooleanDictionary;
begin
  D1.Clear;
  D1.Add(1, True);
  D2 := D1;
  CheckTrue(D2[1] = True);
  D2[1] := False;
  CheckTrue(D1[1] = True);
end;



{ TTestOLIntDateDictionary }

procedure TTestOLIntDateDictionary.TestAddAndCount;
var
  Dict: OLIntDateDictionary;
  D: TDateTime;
begin
  D := Now;
  Dict.Clear;
  Dict.Add(1, D);
  CheckEquals(1, Dict.Count);
end;

procedure TTestOLIntDateDictionary.TestRemove;
var
  Dict: OLIntDateDictionary;
  D: TDateTime;
begin
  D := Now;
  Dict.Clear;
  Dict.Add(1, D);
  CheckTrue(Dict.Remove(1));
end;

procedure TTestOLIntDateDictionary.TestClear;
var
  Dict: OLIntDateDictionary;
  D: TDateTime;
begin
  D := Now;
  Dict.Add(1, D);
  Dict.Clear;
  CheckEquals(0, Dict.Count);
end;

procedure TTestOLIntDateDictionary.TestTryGetValue;
var
  Dict: OLIntDateDictionary;
  Val: OLDate;
  D: TDateTime;
begin
  D := EncodeDate(2023, 1, 1);
  Dict.Clear;
  Dict.Add(1, D);
  CheckTrue(Dict.TryGetValue(1, Val));
  CheckTrue(Val = D);
end;

procedure TTestOLIntDateDictionary.TestContainsKey;
var
  Dict: OLIntDateDictionary;
  D: TDateTime;
begin
  D := Now;
  Dict.Clear;
  Dict.Add(1, D);
  CheckTrue(Dict.ContainsKey(1));
end;

procedure TTestOLIntDateDictionary.TestContainsValue;
var
  Dict: OLIntDateDictionary;
  D1, D2: TDateTime;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 1, 2);
  Dict.Clear;
  Dict.Add(1, D1);
  CheckTrue(Dict.ContainsValue(D1));
  CheckFalse(Dict.ContainsValue(D2));
end;

procedure TTestOLIntDateDictionary.TestValuesProperty;
var
  Dict: OLIntDateDictionary;
  D: TDateTime;
begin
  D := EncodeDate(2023, 1, 1);
  Dict.Clear;
  Dict[1] := D;
  CheckTrue(Dict[1] = D);
end;

procedure TTestOLIntDateDictionary.TestKeys;
var
  Dict: OLIntDateDictionary;
  D: TDateTime;
begin
  D := Now;
  Dict.Clear;
  Dict.Add(1, D);
  CheckEquals(1, Length(Dict.Keys));
end;

procedure TTestOLIntDateDictionary.TestToArray;
var
  Dict: OLIntDateDictionary;
  D: TDateTime;
begin
  D := Now;
  Dict.Clear;
  Dict.Add(1, D);
  CheckEquals(1, Length(Dict.ToArray));
end;

procedure TTestOLIntDateDictionary.TestEnumerator;
var
  Dict: OLIntDateDictionary;
  Pair: TPair<Integer, OLDate>;
  Count: Integer;
  D: TDateTime;
begin
  D := Now;
  Dict.Clear;
  Dict.Add(1, D);
  Count := 0;
  for Pair in Dict do Inc(Count);
  CheckEquals(1, Count);
end;

procedure TTestOLIntDateDictionary.TestAssign;
var
  D1, D2: OLIntDateDictionary;
  Date1, Date2: TDateTime;
begin
  Date1 := EncodeDate(2023, 1, 1);
  Date2 := EncodeDate(2023, 1, 2);
  D1.Clear;
  D1.Add(1, Date1);
  D2 := D1;
  CheckTrue(D2[1] = Date1);
  D2[1] := Date2;
  CheckTrue(D1[1] = Date1);
end;



{ TTestOLStrStrDictionary }

procedure TTestOLStrStrDictionary.TestAddAndCount;
var
  Dict: OLStrStrDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 'V1');
  CheckEquals(1, Dict.Count);
end;

procedure TTestOLStrStrDictionary.TestRemove;
var
  Dict: OLStrStrDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 'V1');
  CheckTrue(Dict.Remove('K1'));
end;

procedure TTestOLStrStrDictionary.TestClear;
var
  Dict: OLStrStrDictionary;
begin
  Dict.Add('K1', 'V1');
  Dict.Clear;
  CheckEquals(0, Dict.Count);
end;

procedure TTestOLStrStrDictionary.TestTryGetValue;
var
  Dict: OLStrStrDictionary;
  Val: OLString;
begin
  Dict.Clear;
  Dict.Add('K1', 'V1');
  CheckTrue(Dict.TryGetValue('K1', Val));
  CheckTrue(Val = 'V1');
end;

procedure TTestOLStrStrDictionary.TestContainsKey;
var
  Dict: OLStrStrDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 'V1');
  CheckTrue(Dict.ContainsKey('K1'));
end;

procedure TTestOLStrStrDictionary.TestContainsValue;
var
  Dict: OLStrStrDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 'V1');
  CheckTrue(Dict.ContainsValue('V1'));
  CheckFalse(Dict.ContainsValue('V2'));
end;

procedure TTestOLStrStrDictionary.TestValuesProperty;
var
  Dict: OLStrStrDictionary;
begin
  Dict.Clear;
  Dict['K1'] := 'V1';
  CheckTrue(Dict['K1'] = 'V1');
end;

procedure TTestOLStrStrDictionary.TestKeys;
var
  Dict: OLStrStrDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 'V1');
  CheckEquals(1, Length(Dict.Keys));
end;

procedure TTestOLStrStrDictionary.TestToArray;
var
  Dict: OLStrStrDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 'V1');
  CheckEquals(1, Length(Dict.ToArray));
end;

procedure TTestOLStrStrDictionary.TestEnumerator;
var
  Dict: OLStrStrDictionary;
  Pair: TPair<string, OLString>;
  Count: Integer;
begin
  Dict.Clear;
  Dict.Add('K1', 'V1');
  Count := 0;
  for Pair in Dict do Inc(Count);
  CheckEquals(1, Count);
end;

procedure TTestOLStrStrDictionary.TestAssign;
var
  D1, D2: OLStrStrDictionary;
begin
  D1.Clear;
  D1.Add('K1', 'V1');
  D2 := D1;
  CheckTrue(D2['K1'] = 'V1');
  D2['K1'] := 'V2';
  CheckTrue(D1['K1'] = 'V1');
end;



{ TTestOLStrIntDictionary }

procedure TTestOLStrIntDictionary.TestAddAndCount;
var
  Dict: OLStrIntDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 100);
  CheckEquals(1, Dict.Count);
end;

procedure TTestOLStrIntDictionary.TestRemove;
var
  Dict: OLStrIntDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 100);
  CheckTrue(Dict.Remove('K1'));
end;

procedure TTestOLStrIntDictionary.TestClear;
var
  Dict: OLStrIntDictionary;
begin
  Dict.Add('K1', 100);
  Dict.Clear;
  CheckEquals(0, Dict.Count);
end;

procedure TTestOLStrIntDictionary.TestTryGetValue;
var
  Dict: OLStrIntDictionary;
  Val: OLInteger;
begin
  Dict.Clear;
  Dict.Add('K1', 100);
  CheckTrue(Dict.TryGetValue('K1', Val));
  CheckTrue(Val = 100);
end;

procedure TTestOLStrIntDictionary.TestContainsKey;
var
  Dict: OLStrIntDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 100);
  CheckTrue(Dict.ContainsKey('K1'));
end;

procedure TTestOLStrIntDictionary.TestContainsValue;
var
  Dict: OLStrIntDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 100);
  CheckTrue(Dict.ContainsValue(100));
  CheckFalse(Dict.ContainsValue(200));
end;

procedure TTestOLStrIntDictionary.TestValuesProperty;
var
  Dict: OLStrIntDictionary;
begin
  Dict.Clear;
  Dict['K1'] := 100;
  CheckTrue(Dict['K1'] = 100);
end;

procedure TTestOLStrIntDictionary.TestKeys;
var
  Dict: OLStrIntDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 100);
  CheckEquals(1, Length(Dict.Keys));
end;

procedure TTestOLStrIntDictionary.TestToArray;
var
  Dict: OLStrIntDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 100);
  CheckEquals(1, Length(Dict.ToArray));
end;

procedure TTestOLStrIntDictionary.TestEnumerator;
var
  Dict: OLStrIntDictionary;
  Pair: TPair<string, OLInteger>;
  Count: Integer;
begin
  Dict.Clear;
  Dict.Add('K1', 100);
  Count := 0;
  for Pair in Dict do Inc(Count);
  CheckEquals(1, Count);
end;

procedure TTestOLStrIntDictionary.TestAssign;
var
  D1, D2: OLStrIntDictionary;
begin
  D1.Clear;
  D1.Add('K1', 100);
  D2 := D1;
  CheckTrue(D2['K1'] = 100);
  D2['K1'] := 200;
  CheckTrue(D1['K1'] = 100);
end;



{ TTestOLStrCurrDictionary }

procedure TTestOLStrCurrDictionary.TestAddAndCount;
var
  Dict: OLStrCurrDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 10.5);
  CheckEquals(1, Dict.Count);
end;

procedure TTestOLStrCurrDictionary.TestRemove;
var
  Dict: OLStrCurrDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 10.5);
  CheckTrue(Dict.Remove('K1'));
end;

procedure TTestOLStrCurrDictionary.TestClear;
var
  Dict: OLStrCurrDictionary;
begin
  Dict.Add('K1', 10.5);
  Dict.Clear;
  CheckEquals(0, Dict.Count);
end;

procedure TTestOLStrCurrDictionary.TestTryGetValue;
var
  Dict: OLStrCurrDictionary;
  Val: OLCurrency;
begin
  Dict.Clear;
  Dict.Add('K1', 10.5);
  CheckTrue(Dict.TryGetValue('K1', Val));
  CheckTrue(Val = 10.5);
end;

procedure TTestOLStrCurrDictionary.TestContainsKey;
var
  Dict: OLStrCurrDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 10.5);
  CheckTrue(Dict.ContainsKey('K1'));
end;

procedure TTestOLStrCurrDictionary.TestContainsValue;
var
  Dict: OLStrCurrDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 10.5);
  CheckTrue(Dict.ContainsValue(10.5));
  CheckFalse(Dict.ContainsValue(20.5));
end;

procedure TTestOLStrCurrDictionary.TestValuesProperty;
var
  Dict: OLStrCurrDictionary;
begin
  Dict.Clear;
  Dict['K1'] := 10.5;
  CheckTrue(Dict['K1'] = 10.5);
end;

procedure TTestOLStrCurrDictionary.TestKeys;
var
  Dict: OLStrCurrDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 10.5);
  CheckEquals(1, Length(Dict.Keys));
end;

procedure TTestOLStrCurrDictionary.TestToArray;
var
  Dict: OLStrCurrDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 10.5);
  CheckEquals(1, Length(Dict.ToArray));
end;

procedure TTestOLStrCurrDictionary.TestEnumerator;
var
  Dict: OLStrCurrDictionary;
  Pair: TPair<string, OLCurrency>;
  Count: Integer;
begin
  Dict.Clear;
  Dict.Add('K1', 10.5);
  Count := 0;
  for Pair in Dict do Inc(Count);
  CheckEquals(1, Count);
end;

procedure TTestOLStrCurrDictionary.TestAssign;
var
  D1, D2: OLStrCurrDictionary;
begin
  D1.Clear;
  D1.Add('K1', 10.5);
  D2 := D1;
  CheckTrue(D2['K1'] = 10.5);
  D2['K1'] := 20.5;
  CheckTrue(D1['K1'] = 10.5);
end;



{ TTestOLStrDblDictionary }

procedure TTestOLStrDblDictionary.TestAddAndCount;
var
  Dict: OLStrDblDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 1.5);
  CheckEquals(1, Dict.Count);
end;

procedure TTestOLStrDblDictionary.TestRemove;
var
  Dict: OLStrDblDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 1.5);
  CheckTrue(Dict.Remove('K1'));
end;

procedure TTestOLStrDblDictionary.TestClear;
var
  Dict: OLStrDblDictionary;
begin
  Dict.Add('K1', 1.5);
  Dict.Clear;
  CheckEquals(0, Dict.Count);
end;

procedure TTestOLStrDblDictionary.TestTryGetValue;
var
  Dict: OLStrDblDictionary;
  Val: OLDouble;
begin
  Dict.Clear;
  Dict.Add('K1', 1.5);
  CheckTrue(Dict.TryGetValue('K1', Val));
  CheckTrue(Val = 1.5);
end;

procedure TTestOLStrDblDictionary.TestContainsKey;
var
  Dict: OLStrDblDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 1.5);
  CheckTrue(Dict.ContainsKey('K1'));
end;

procedure TTestOLStrDblDictionary.TestContainsValue;
var
  Dict: OLStrDblDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 1.5);
  CheckTrue(Dict.ContainsValue(1.5));
  CheckFalse(Dict.ContainsValue(2.5));
end;

procedure TTestOLStrDblDictionary.TestValuesProperty;
var
  Dict: OLStrDblDictionary;
begin
  Dict.Clear;
  Dict['K1'] := 1.5;
  CheckTrue(Dict['K1'] = 1.5);
end;

procedure TTestOLStrDblDictionary.TestKeys;
var
  Dict: OLStrDblDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 1.5);
  CheckEquals(1, Length(Dict.Keys));
end;

procedure TTestOLStrDblDictionary.TestToArray;
var
  Dict: OLStrDblDictionary;
begin
  Dict.Clear;
  Dict.Add('K1', 1.5);
  CheckEquals(1, Length(Dict.ToArray));
end;

procedure TTestOLStrDblDictionary.TestEnumerator;
var
  Dict: OLStrDblDictionary;
  Pair: TPair<string, OLDouble>;
  Count: Integer;
begin
  Dict.Clear;
  Dict.Add('K1', 1.5);
  Count := 0;
  for Pair in Dict do Inc(Count);
  CheckEquals(1, Count);
end;

procedure TTestOLStrDblDictionary.TestAssign;
var
  D1, D2: OLStrDblDictionary;
begin
  D1.Clear;
  D1.Add('K1', 1.5);
  D2 := D1;
  CheckTrue(D2['K1'] = 1.5);
  D2['K1'] := 2.5;
  CheckTrue(D1['K1'] = 1.5);
end;



initialization
  RegisterTest(TTestOLIntIntDictionary.Suite);
  RegisterTest(TTestOLIntStrDictionary.Suite);
  RegisterTest(TTestOLIntDblDictionary.Suite);
  RegisterTest(TTestOLIntCurrDictionary.Suite);
  RegisterTest(TTestOLIntBooleanDictionary.Suite);
  RegisterTest(TTestOLIntDateDictionary.Suite);
  RegisterTest(TTestOLStrStrDictionary.Suite);
  RegisterTest(TTestOLStrIntDictionary.Suite);
  RegisterTest(TTestOLStrCurrDictionary.Suite);
  RegisterTest(TTestOLStrDblDictionary.Suite);

{$IFEND}

end.
