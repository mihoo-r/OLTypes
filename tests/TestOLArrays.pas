unit TestOLArrays;

interface

uses
  TestFramework,
  {$IF CompilerVersion >= 23.0} System.SysUtils,{$ELSE} SysUtils,{$IFEND}
  OLArrays,
  OLIntegerType,
  OLStringType,
  OLBooleanType,
  OLCurrencyType,
  OLDateTimeType,
  OLDateType,
  OLDoubleType,
  OLInt64Type;

type
  TTestOLIntegerArray = class(TTestCase)
  published
    procedure TestAdd;
    procedure TestInsert;
    procedure TestDelete;
    procedure TestClear;
    procedure TestSort;
    procedure TestSorted;
    procedure TestLastItemIndex;
    procedure TestContainsValue;
    procedure TestDistinct;
    procedure TestReversed;
    procedure TestImplicit;
  end;

  TTestOLStringArray = class(TTestCase)
  published
    procedure TestAdd;
    procedure TestInsert;
    procedure TestDelete;
    procedure TestClear;
    procedure TestSort;
    procedure TestSorted;
    procedure TestLastItemIndex;
    procedure TestContainsValue;
    procedure TestDistinct;
    procedure TestReversed;
    procedure TestImplicit;
  end;

  TTestOLBooleanArray = class(TTestCase)
  published
    procedure TestAdd;
    procedure TestInsert;
    procedure TestDelete;
    procedure TestClear;
    procedure TestSort;
    procedure TestSorted;
    procedure TestLastItemIndex;
    procedure TestContainsValue;
    procedure TestDistinct;
    procedure TestReversed;
    procedure TestImplicit;
  end;

  TTestOLCurrencyArray = class(TTestCase)
  published
    procedure TestAdd;
    procedure TestInsert;
    procedure TestDelete;
    procedure TestClear;
    procedure TestSort;
    procedure TestSorted;
    procedure TestLastItemIndex;
    procedure TestContainsValue;
    procedure TestDistinct;
    procedure TestReversed;
    procedure TestImplicit;
  end;

  TTestOLDateTimeArray = class(TTestCase)
  published
    procedure TestAdd;
    procedure TestInsert;
    procedure TestDelete;
    procedure TestClear;
    procedure TestSort;
    procedure TestSorted;
    procedure TestLastItemIndex;
    procedure TestContainsValue;
    procedure TestDistinct;
    procedure TestReversed;
    procedure TestImplicit;
  end;

  TTestOLDateArray = class(TTestCase)
  published
    procedure TestAdd;
    procedure TestInsert;
    procedure TestDelete;
    procedure TestClear;
    procedure TestSort;
    procedure TestSorted;
    procedure TestLastItemIndex;
    procedure TestContainsValue;
    procedure TestDistinct;
    procedure TestReversed;
    procedure TestImplicit;
  end;

  TTestOLDoubleArray = class(TTestCase)
  published
    procedure TestAdd;
    procedure TestInsert;
    procedure TestDelete;
    procedure TestClear;
    procedure TestSort;
    procedure TestSorted;
    procedure TestLastItemIndex;
    procedure TestContainsValue;
    procedure TestDistinct;
    procedure TestReversed;
    procedure TestImplicit;
  end;

  TTestOLInt64Array = class(TTestCase)
  published
    procedure TestAdd;
    procedure TestInsert;
    procedure TestDelete;
    procedure TestClear;
    procedure TestSort;
    procedure TestSorted;
    procedure TestLastItemIndex;
    procedure TestContainsValue;
    procedure TestDistinct;
    procedure TestReversed;
    procedure TestImplicit;
  end;

  TTestOLByteArray = class(TTestCase)
  published
    procedure TestAdd;
    procedure TestInsert;
    procedure TestDelete;
    procedure TestClear;
    procedure TestSort;
    procedure TestSorted;
    procedure TestLastItemIndex;
    procedure TestContainsValue;
    procedure TestDistinct;
    procedure TestReversed;
    procedure TestImplicit;
  end;

implementation

{ TTestOLIntegerArray }

procedure TTestOLIntegerArray.TestAdd;
var
  Arr: OLIntegerArray;
begin
  Arr.Clear;
  CheckEquals(0, Arr.Length);
  Arr.Add(10);
  CheckEquals(1, Arr.Length);
  CheckTrue(Arr[0] = 10);
  Arr.Add(20);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[1] = 20);
end;

procedure TTestOLIntegerArray.TestInsert;
var
  Arr: OLIntegerArray;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(30);
  Arr.Insert(1, 20);
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = 10);
  CheckTrue(Arr[1] = 20);
  CheckTrue(Arr[2] = 30);
end;

procedure TTestOLIntegerArray.TestDelete;
var
  Arr: OLIntegerArray;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(20);
  Arr.Add(30);
  Arr.Delete(1);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[0] = 10);
  CheckTrue(Arr[1] = 30);
end;

procedure TTestOLIntegerArray.TestClear;
var
  Arr: OLIntegerArray;
begin
  Arr.Add(10);
  Arr.Clear;
  CheckEquals(0, Arr.Length);
end;

procedure TTestOLIntegerArray.TestSort;
var
  Arr: OLIntegerArray;
begin
  Arr.Clear;
  Arr.Add(30);
  Arr.Add(10);
  Arr.Add(20);
  Arr.Sort;
  CheckTrue(Arr[0] = 10);
  CheckTrue(Arr[1] = 20);
  CheckTrue(Arr[2] = 30);
end;

procedure TTestOLIntegerArray.TestSorted;
var
  Arr, SortedArr: OLIntegerArray;
begin
  Arr.Clear;
  Arr.Add(30);
  Arr.Add(10);
  Arr.Add(20);
  SortedArr := Arr.Sorted;
  
  // Original should remain unchanged (unsorted)
  CheckTrue(Arr[0] = 30);
  CheckTrue(Arr[1] = 10);
  CheckTrue(Arr[2] = 20);

  // New one should be sorted
  CheckTrue(SortedArr[0] = 10);
  CheckTrue(SortedArr[1] = 20);
  CheckTrue(SortedArr[2] = 30);
end;

procedure TTestOLIntegerArray.TestLastItemIndex;
var
  Arr: OLIntegerArray;
begin
  Arr.Clear;
  CheckEquals(-1, Arr.LastItemIndex);
  Arr.Add(10);
  CheckEquals(0, Arr.LastItemIndex);
  Arr.Add(20);
  CheckEquals(1, Arr.LastItemIndex);
end;

procedure TTestOLIntegerArray.TestContainsValue;
var
  Arr: OLIntegerArray;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(20);
  
  // Unsorted
  CheckTrue(Arr.ContainsValue(10));
  CheckFalse(Arr.ContainsValue(30));

  // Sorted
  Arr.Sort;
  CheckTrue(Arr.ContainsValue(10));
  CheckFalse(Arr.ContainsValue(30));
end;

procedure TTestOLIntegerArray.TestDistinct;
var
  Arr, Dist: OLIntegerArray;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(20);
  Arr.Add(10);
  Dist := Arr.Distinct;
  
  CheckEquals(2, Dist.Length);
  CheckTrue(Dist.ContainsValue(10));
  CheckTrue(Dist.ContainsValue(20));
end;

procedure TTestOLIntegerArray.TestReversed;
var
  Arr, Rev: OLIntegerArray;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(20);
  Arr.Add(30);
  Rev := Arr.Reversed;
  
  CheckEquals(3, Rev.Length);
  CheckTrue(Rev[0] = 30);
  CheckTrue(Rev[1] = 20);
  CheckTrue(Rev[2] = 10);
end;

procedure TTestOLIntegerArray.TestImplicit;
var
  Arr: OLIntegerArray;
  DynArr: TOLIntegerDynArray;
begin
  // Array of Integer -> OLIntegerArray
  {$IF CompilerVersion >= 34.0} // XE8+ supports array literal
    Arr := [10, 20, 30];
  {$ELSE} // Older Delphi versions: manual SetLength and assignments
    Arr[0] := 10;
    Arr[1] := 20;
    Arr[2] := 30;
  {$IFEND}
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = 10);

  // OLIntegerArray -> TIntegerDynArray
  DynArr := Arr;
  CheckEquals(3, Length(DynArr));
  CheckEquals(10, DynArr[0]);
end;

{ TTestOLStringArray }

procedure TTestOLStringArray.TestAdd;
var
  Arr: OLStringArray;
begin
  Arr.Clear;
  CheckEquals(0, Arr.Length);
  Arr.Add('A');
  CheckEquals(1, Arr.Length);
  CheckTrue(Arr[0] = 'A');
  Arr.Add('B');
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[1] = 'B');
end;

procedure TTestOLStringArray.TestInsert;
var
  Arr: OLStringArray;
begin
  Arr.Clear;
  Arr.Add('A');
  Arr.Add('C');
  Arr.Insert(1, 'B');
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = 'A');
  CheckTrue(Arr[1] = 'B');
  CheckTrue(Arr[2] = 'C');
end;

procedure TTestOLStringArray.TestDelete;
var
  Arr: OLStringArray;
begin
  Arr.Clear;
  Arr.Add('A');
  Arr.Add('B');
  Arr.Add('C');
  Arr.Delete(1);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[0] = 'A');
  CheckTrue(Arr[1] = 'C');
end;

procedure TTestOLStringArray.TestClear;
var
  Arr: OLStringArray;
begin
  Arr.Add('A');
  Arr.Clear;
  CheckEquals(0, Arr.Length);
end;

procedure TTestOLStringArray.TestSort;
var
  Arr: OLStringArray;
begin
  Arr.Clear;
  Arr.Add('C');
  Arr.Add('A');
  Arr.Add('B');
  Arr.Sort;
  CheckTrue(Arr[0] = 'A');
  CheckTrue(Arr[1] = 'B');
  CheckTrue(Arr[2] = 'C');
end;

procedure TTestOLStringArray.TestSorted;
var
  Arr, SortedArr: OLStringArray;
begin
  Arr.Clear;
  Arr.Add('C');
  Arr.Add('A');
  Arr.Add('B');
  SortedArr := Arr.Sorted;
  
  CheckTrue(Arr[0] = 'C');
  CheckTrue(Arr[1] = 'A');
  CheckTrue(Arr[2] = 'B');

  CheckTrue(SortedArr[0] = 'A');
  CheckTrue(SortedArr[1] = 'B');
  CheckTrue(SortedArr[2] = 'C');
end;

procedure TTestOLStringArray.TestLastItemIndex;
var
  Arr: OLStringArray;
begin
  Arr.Clear;
  CheckEquals(-1, Arr.LastItemIndex);
  Arr.Add('A');
  CheckEquals(0, Arr.LastItemIndex);
  Arr.Add('B');
  CheckEquals(1, Arr.LastItemIndex);
end;

procedure TTestOLStringArray.TestContainsValue;
var
  Arr: OLStringArray;
begin
  Arr.Clear;
  Arr.Add('A');
  Arr.Add('B');
  
  CheckTrue(Arr.ContainsValue('A'));
  CheckFalse(Arr.ContainsValue('C'));

  Arr.Sort;
  CheckTrue(Arr.ContainsValue('A'));
  CheckFalse(Arr.ContainsValue('C'));
end;

procedure TTestOLStringArray.TestDistinct;
var
  Arr, Dist: OLStringArray;
begin
  Arr.Clear;
  Arr.Add('A');
  Arr.Add('B');
  Arr.Add('A');
  Dist := Arr.Distinct;
  
  CheckEquals(2, Dist.Length);
  CheckTrue(Dist.ContainsValue('A'));
  CheckTrue(Dist.ContainsValue('B'));
end;

procedure TTestOLStringArray.TestReversed;
var
  Arr, Rev: OLStringArray;
begin
  Arr.Clear;
  Arr.Add('A');
  Arr.Add('B');
  Arr.Add('C');
  Rev := Arr.Reversed;
  
  CheckEquals(3, Rev.Length);
  CheckTrue(Rev[0] = 'C');
  CheckTrue(Rev[1] = 'B');
  CheckTrue(Rev[2] = 'A');
end;

procedure TTestOLStringArray.TestImplicit;
var
  Arr: OLStringArray;
  DynArr: TOLStringDynArray;
begin
  {$IF CompilerVersion >= 34.0} // XE8+ supports array literal
    Arr := ['A', 'B', 'C'];
  {$ELSE} // Older Delphi versions: manual SetLength and assignments
    Arr[0] := 'A';
    Arr[1] := 'B';
    Arr[2] := 'C';
  {$IFEND}
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = 'A');

  DynArr := Arr;
  CheckEquals(3, Length(DynArr));
  CheckEquals('A', DynArr[0]);
end;

{ TTestOLBooleanArray }

procedure TTestOLBooleanArray.TestAdd;
var
  Arr: OLBooleanArray;
begin
  Arr.Clear;
  CheckEquals(0, Arr.Length);
  Arr.Add(True);
  CheckEquals(1, Arr.Length);
  CheckTrue(Arr[0] = True);
  Arr.Add(False);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[1] = False);
end;

procedure TTestOLBooleanArray.TestInsert;
var
  Arr: OLBooleanArray;
begin
  Arr.Clear;
  Arr.Add(True);
  Arr.Add(True);
  Arr.Insert(1, False);
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = True);
  CheckTrue(Arr[1] = False);
  CheckTrue(Arr[2] = True);
end;

procedure TTestOLBooleanArray.TestDelete;
var
  Arr: OLBooleanArray;
begin
  Arr.Clear;
  Arr.Add(True);
  Arr.Add(False);
  Arr.Add(True);
  Arr.Delete(1);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[0] = True);
  CheckTrue(Arr[1] = True);
end;

procedure TTestOLBooleanArray.TestClear;
var
  Arr: OLBooleanArray;
begin
  Arr.Add(True);
  Arr.Clear;
  CheckEquals(0, Arr.Length);
end;

procedure TTestOLBooleanArray.TestSort;
var
  Arr: OLBooleanArray;
begin
  Arr.Clear;
  Arr.Add(True);
  Arr.Add(False);
  Arr.Sort;
  CheckTrue(Arr[0] = False);
  CheckTrue(Arr[1] = True);
end;

procedure TTestOLBooleanArray.TestSorted;
var
  Arr, SortedArr: OLBooleanArray;
begin
  Arr.Clear;
  Arr.Add(True);
  Arr.Add(False);
  SortedArr := Arr.Sorted;
  
  CheckTrue(Arr[0] = True);
  CheckTrue(Arr[1] = False);

  CheckTrue(SortedArr[0] = False);
  CheckTrue(SortedArr[1] = True);
end;

procedure TTestOLBooleanArray.TestLastItemIndex;
var
  Arr: OLBooleanArray;
begin
  Arr.Clear;
  CheckEquals(-1, Arr.LastItemIndex);
  Arr.Add(True);
  CheckEquals(0, Arr.LastItemIndex);
  Arr.Add(False);
  CheckEquals(1, Arr.LastItemIndex);
end;

procedure TTestOLBooleanArray.TestContainsValue;
var
  Arr: OLBooleanArray;
begin
  Arr.Clear;
  Arr.Add(True);
  
  CheckTrue(Arr.ContainsValue(True));
  CheckFalse(Arr.ContainsValue(False));

  Arr.Sort;
  CheckTrue(Arr.ContainsValue(True));
  CheckFalse(Arr.ContainsValue(False));
end;

procedure TTestOLBooleanArray.TestDistinct;
var
  Arr, Dist: OLBooleanArray;
begin
  Arr.Clear;
  Arr.Add(True);
  Arr.Add(False);
  Arr.Add(True);
  Dist := Arr.Distinct;
  
  CheckEquals(2, Dist.Length);
  CheckTrue(Dist.ContainsValue(True));
  CheckTrue(Dist.ContainsValue(False));
end;

procedure TTestOLBooleanArray.TestReversed;
var
  Arr, Rev: OLBooleanArray;
begin
  Arr.Clear;
  Arr.Add(True);
  Arr.Add(False);
  Rev := Arr.Reversed;
  
  CheckEquals(2, Rev.Length);
  CheckTrue(Rev[0] = False);
  CheckTrue(Rev[1] = True);
end;

procedure TTestOLBooleanArray.TestImplicit;
var
  Arr: OLBooleanArray;
  DynArr: TOLBooleanDynArray;
begin
  {$IF CompilerVersion >= 34.0} // XE8+ supports array literal
    Arr := [True, False];
  {$ELSE} // Older Delphi versions: manual SetLength and assignments
    Arr[0] := True;
    Arr[1] := False;
  {$IFEND}

  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[0] = True);

  DynArr := Arr;
  CheckEquals(2, Length(DynArr));
  CheckTrue(DynArr[0] = True);
end;

{ TTestOLCurrencyArray }

procedure TTestOLCurrencyArray.TestAdd;
var
  Arr: OLCurrencyArray;
begin
  Arr.Clear;
  CheckEquals(0, Arr.Length);
  Arr.Add(10.5);
  CheckEquals(1, Arr.Length);
  CheckTrue(Arr[0] = 10.5);
  Arr.Add(20.5);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[1] = 20.5);
end;

procedure TTestOLCurrencyArray.TestInsert;
var
  Arr: OLCurrencyArray;
begin
  Arr.Clear;
  Arr.Add(10.5);
  Arr.Add(30.5);
  Arr.Insert(1, 20.5);
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = 10.5);
  CheckTrue(Arr[1] = 20.5);
  CheckTrue(Arr[2] = 30.5);
end;

procedure TTestOLCurrencyArray.TestDelete;
var
  Arr: OLCurrencyArray;
begin
  Arr.Clear;
  Arr.Add(10.5);
  Arr.Add(20.5);
  Arr.Add(30.5);
  Arr.Delete(1);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[0] = 10.5);
  CheckTrue(Arr[1] = 30.5);
end;

procedure TTestOLCurrencyArray.TestClear;
var
  Arr: OLCurrencyArray;
begin
  Arr.Add(10.5);
  Arr.Clear;
  CheckEquals(0, Arr.Length);
end;

procedure TTestOLCurrencyArray.TestSort;
var
  Arr: OLCurrencyArray;
begin
  Arr.Clear;
  Arr.Add(30.5);
  Arr.Add(10.5);
  Arr.Add(20.5);
  Arr.Sort;
  CheckTrue(Arr[0] = 10.5);
  CheckTrue(Arr[1] = 20.5);
  CheckTrue(Arr[2] = 30.5);
end;

procedure TTestOLCurrencyArray.TestSorted;
var
  Arr, SortedArr: OLCurrencyArray;
begin
  Arr.Clear;
  Arr.Add(30.5);
  Arr.Add(10.5);
  Arr.Add(20.5);
  SortedArr := Arr.Sorted;
  
  CheckTrue(Arr[0] = 30.5);
  CheckTrue(Arr[1] = 10.5);
  CheckTrue(Arr[2] = 20.5);

  CheckTrue(SortedArr[0] = 10.5);
  CheckTrue(SortedArr[1] = 20.5);
  CheckTrue(SortedArr[2] = 30.5);
end;

procedure TTestOLCurrencyArray.TestLastItemIndex;
var
  Arr: OLCurrencyArray;
begin
  Arr.Clear;
  CheckEquals(-1, Arr.LastItemIndex);
  Arr.Add(10.5);
  CheckEquals(0, Arr.LastItemIndex);
  Arr.Add(20.5);
  CheckEquals(1, Arr.LastItemIndex);
end;

procedure TTestOLCurrencyArray.TestContainsValue;
var
  Arr: OLCurrencyArray;
begin
  Arr.Clear;
  Arr.Add(10.5);
  Arr.Add(20.5);
  
  CheckTrue(Arr.ContainsValue(10.5));
  CheckFalse(Arr.ContainsValue(30.5));

  Arr.Sort;
  CheckTrue(Arr.ContainsValue(10.5));
  CheckFalse(Arr.ContainsValue(30.5));
end;

procedure TTestOLCurrencyArray.TestDistinct;
var
  Arr, Dist: OLCurrencyArray;
begin
  Arr.Clear;
  Arr.Add(10.5);
  Arr.Add(20.5);
  Arr.Add(10.5);
  Dist := Arr.Distinct;
  
  CheckEquals(2, Dist.Length);
  CheckTrue(Dist.ContainsValue(10.5));
  CheckTrue(Dist.ContainsValue(20.5));
end;

procedure TTestOLCurrencyArray.TestReversed;
var
  Arr, Rev: OLCurrencyArray;
begin
  Arr.Clear;
  Arr.Add(10.5);
  Arr.Add(20.5);
  Arr.Add(30.5);
  Rev := Arr.Reversed;
  
  CheckEquals(3, Rev.Length);
  CheckTrue(Rev[0] = 30.5);
  CheckTrue(Rev[1] = 20.5);
  CheckTrue(Rev[2] = 10.5);
end;

procedure TTestOLCurrencyArray.TestImplicit;
var
  Arr: OLCurrencyArray;
  DynArr: TOLCurrencyDynArray;
begin
  {$IF CompilerVersion >= 34.0} // XE8+ supports array literal
    Arr := [10.5, 20.5, 30.5];
  {$ELSE} // Older Delphi versions: manual SetLength and assignments
    Arr[0] := 10.5;
    Arr[1] := 20.5;
    Arr[2] := 30.5;
  {$IFEND}
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = 10.5);

  DynArr := Arr;
  CheckEquals(3, Length(DynArr));
  CheckTrue(DynArr[0] = 10.5);
end;

{ TTestOLDateTimeArray }

procedure TTestOLDateTimeArray.TestAdd;
var
  Arr: OLDateTimeArray;
  D: TDateTime;
begin
  D := EncodeDate(2023, 1, 1);
  Arr.Clear;
  CheckEquals(0, Arr.Length);
  Arr.Add(D);
  CheckEquals(1, Arr.Length);
  CheckTrue(Arr[0] = D);
end;

procedure TTestOLDateTimeArray.TestInsert;
var
  Arr: OLDateTimeArray;
  D1, D2, D3: TDateTime;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);
  D3 := EncodeDate(2023, 3, 1);
  
  Arr.Clear;
  Arr.Add(D1);
  Arr.Add(D3);
  Arr.Insert(1, D2);
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = D1);
  CheckTrue(Arr[1] = D2);
  CheckTrue(Arr[2] = D3);
end;

procedure TTestOLDateTimeArray.TestDelete;
var
  Arr: OLDateTimeArray;
  D1, D2, D3: TDateTime;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);
  D3 := EncodeDate(2023, 3, 1);

  Arr.Clear;
  Arr.Add(D1);
  Arr.Add(D2);
  Arr.Add(D3);
  Arr.Delete(1);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[0] = D1);
  CheckTrue(Arr[1] = D3);
end;

procedure TTestOLDateTimeArray.TestClear;
var
  Arr: OLDateTimeArray;
begin
  Arr.Add(Now);
  Arr.Clear;
  CheckEquals(0, Arr.Length);
end;

procedure TTestOLDateTimeArray.TestSort;
var
  Arr: OLDateTimeArray;
  D1, D2, D3: TDateTime;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);
  D3 := EncodeDate(2023, 3, 1);

  Arr.Clear;
  Arr.Add(D3);
  Arr.Add(D1);
  Arr.Add(D2);
  Arr.Sort;
  CheckTrue(Arr[0] = D1);
  CheckTrue(Arr[1] = D2);
  CheckTrue(Arr[2] = D3);
end;

procedure TTestOLDateTimeArray.TestSorted;
var
  Arr, SortedArr: OLDateTimeArray;
  D1, D2, D3: TDateTime;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);
  D3 := EncodeDate(2023, 3, 1);

  Arr.Clear;
  Arr.Add(D3);
  Arr.Add(D1);
  Arr.Add(D2);
  SortedArr := Arr.Sorted;
  
  CheckTrue(Arr[0] = D3);
  CheckTrue(Arr[1] = D1);
  CheckTrue(Arr[2] = D2);

  CheckTrue(SortedArr[0] = D1);
  CheckTrue(SortedArr[1] = D2);
  CheckTrue(SortedArr[2] = D3);
end;

procedure TTestOLDateTimeArray.TestLastItemIndex;
var
  Arr: OLDateTimeArray;
begin
  Arr.Clear;
  CheckEquals(-1, Arr.LastItemIndex);
  Arr.Add(Now);
  CheckEquals(0, Arr.LastItemIndex);
  Arr.Add(Now);
  CheckEquals(1, Arr.LastItemIndex);
end;

procedure TTestOLDateTimeArray.TestContainsValue;
var
  Arr: OLDateTimeArray;
  D1, D2: TDateTime;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);

  Arr.Clear;
  Arr.Add(D1);
  
  CheckTrue(Arr.ContainsValue(D1));
  CheckFalse(Arr.ContainsValue(D2));

  Arr.Sort;
  CheckTrue(Arr.ContainsValue(D1));
  CheckFalse(Arr.ContainsValue(D2));
end;

procedure TTestOLDateTimeArray.TestDistinct;
var
  Arr, Dist: OLDateTimeArray;
  D1, D2: TDateTime;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);

  Arr.Clear;
  Arr.Add(D1);
  Arr.Add(D2);
  Arr.Add(D1);
  Dist := Arr.Distinct;
  
  CheckEquals(2, Dist.Length);
  CheckTrue(Dist.ContainsValue(D1));
  CheckTrue(Dist.ContainsValue(D2));
end;

procedure TTestOLDateTimeArray.TestReversed;
var
  Arr, Rev: OLDateTimeArray;
  D1, D2, D3: TDateTime;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);
  D3 := EncodeDate(2023, 3, 1);

  Arr.Clear;
  Arr.Add(D1);
  Arr.Add(D2);
  Arr.Add(D3);
  Rev := Arr.Reversed;
  
  CheckEquals(3, Rev.Length);
  CheckTrue(Rev[0] = D3);
  CheckTrue(Rev[1] = D2);
  CheckTrue(Rev[2] = D1);
end;

procedure TTestOLDateTimeArray.TestImplicit;
var
  Arr: OLDateTimeArray;
  DynArr: TOLDateTimeDynArray;
  D1, D2: TDateTime;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);

  {$IF CompilerVersion >= 34.0} // XE8+ supports array literal
    Arr := [D1, D2];
  {$ELSE} // Older Delphi versions: manual SetLength and assignments
    Arr[0] := D1;
    Arr[1] := D2;
  {$IFEND}
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[0] = D1);

  DynArr := Arr;
  CheckEquals(2, Length(DynArr));
  CheckTrue(DynArr[0] = D1);
end;

{ TTestOLDateArray }

procedure TTestOLDateArray.TestAdd;
var
  Arr: OLDateArray;
  D: TDate;
begin
  D := EncodeDate(2023, 1, 1);
  Arr.Clear;
  CheckEquals(0, Arr.Length);
  Arr.Add(D);
  CheckEquals(1, Arr.Length);
  CheckTrue(Arr[0] = D);
end;

procedure TTestOLDateArray.TestInsert;
var
  Arr: OLDateArray;
  D1, D2, D3: TDate;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);
  D3 := EncodeDate(2023, 3, 1);
  
  Arr.Clear;
  Arr.Add(D1);
  Arr.Add(D3);
  Arr.Insert(1, D2);
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = D1);
  CheckTrue(Arr[1] = D2);
  CheckTrue(Arr[2] = D3);
end;

procedure TTestOLDateArray.TestDelete;
var
  Arr: OLDateArray;
  D1, D2, D3: TDate;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);
  D3 := EncodeDate(2023, 3, 1);

  Arr.Clear;
  Arr.Add(D1);
  Arr.Add(D2);
  Arr.Add(D3);
  Arr.Delete(1);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[0] = D1);
  CheckTrue(Arr[1] = D3);
end;

procedure TTestOLDateArray.TestClear;
var
  Arr: OLDateArray;
begin
  Arr.Add(Date);
  Arr.Clear;
  CheckEquals(0, Arr.Length);
end;

procedure TTestOLDateArray.TestSort;
var
  Arr: OLDateArray;
  D1, D2, D3: TDate;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);
  D3 := EncodeDate(2023, 3, 1);

  Arr.Clear;
  Arr.Add(D3);
  Arr.Add(D1);
  Arr.Add(D2);
  Arr.Sort;
  CheckTrue(Arr[0] = D1);
  CheckTrue(Arr[1] = D2);
  CheckTrue(Arr[2] = D3);
end;

procedure TTestOLDateArray.TestSorted;
var
  Arr, SortedArr: OLDateArray;
  D1, D2, D3: TDate;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);
  D3 := EncodeDate(2023, 3, 1);

  Arr.Clear;
  Arr.Add(D3);
  Arr.Add(D1);
  Arr.Add(D2);
  SortedArr := Arr.Sorted;
  
  CheckTrue(Arr[0] = D3);
  CheckTrue(Arr[1] = D1);
  CheckTrue(Arr[2] = D2);

  CheckTrue(SortedArr[0] = D1);
  CheckTrue(SortedArr[1] = D2);
  CheckTrue(SortedArr[2] = D3);
end;

procedure TTestOLDateArray.TestLastItemIndex;
var
  Arr: OLDateArray;
begin
  Arr.Clear;
  CheckEquals(-1, Arr.LastItemIndex);
  Arr.Add(Date);
  CheckEquals(0, Arr.LastItemIndex);
  Arr.Add(Date);
  CheckEquals(1, Arr.LastItemIndex);
end;

procedure TTestOLDateArray.TestContainsValue;
var
  Arr: OLDateArray;
  D1, D2: TDate;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);

  Arr.Clear;
  Arr.Add(D1);
  
  CheckTrue(Arr.ContainsValue(D1));
  CheckFalse(Arr.ContainsValue(D2));

  Arr.Sort;
  CheckTrue(Arr.ContainsValue(D1));
  CheckFalse(Arr.ContainsValue(D2));
end;

procedure TTestOLDateArray.TestDistinct;
var
  Arr, Dist: OLDateArray;
  D1, D2: TDate;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);

  Arr.Clear;
  Arr.Add(D1);
  Arr.Add(D2);
  Arr.Add(D1);
  Dist := Arr.Distinct;
  
  CheckEquals(2, Dist.Length);
  CheckTrue(Dist.ContainsValue(D1));
  CheckTrue(Dist.ContainsValue(D2));
end;

procedure TTestOLDateArray.TestReversed;
var
  Arr, Rev: OLDateArray;
  D1, D2, D3: TDate;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);
  D3 := EncodeDate(2023, 3, 1);

  Arr.Clear;
  Arr.Add(D1);
  Arr.Add(D2);
  Arr.Add(D3);
  Rev := Arr.Reversed;
  
  CheckEquals(3, Rev.Length);
  CheckTrue(Rev[0] = D3);
  CheckTrue(Rev[1] = D2);
  CheckTrue(Rev[2] = D1);
end;

procedure TTestOLDateArray.TestImplicit;
var
  Arr: OLDateArray;
  DynArr: TOLDateDynArray;
  D1, D2: TDate;
begin
  D1 := EncodeDate(2023, 1, 1);
  D2 := EncodeDate(2023, 2, 1);

  {$IF CompilerVersion >= 34.0} // XE8+ supports array literal
    Arr := [D1, D2];
  {$ELSE} // Older Delphi versions: manual SetLength and assignments
    Arr[0] := D1;
    Arr[1] := D2;
  {$IFEND}
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[0] = D1);

  DynArr := Arr;
  CheckEquals(2, Length(DynArr));
  CheckTrue(DynArr[0] = D1);
end;

{ TTestOLDoubleArray }

procedure TTestOLDoubleArray.TestAdd;
var
  Arr: OLDoubleArray;
begin
  Arr.Clear;
  CheckEquals(0, Arr.Length);
  Arr.Add(1.1);
  CheckEquals(1, Arr.Length);
  CheckTrue(Arr[0] = 1.1);
  Arr.Add(2.2);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[1] = 2.2);
end;

procedure TTestOLDoubleArray.TestInsert;
var
  Arr: OLDoubleArray;
begin
  Arr.Clear;
  Arr.Add(1.1);
  Arr.Add(3.3);
  Arr.Insert(1, 2.2);
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = 1.1);
  CheckTrue(Arr[1] = 2.2);
  CheckTrue(Arr[2] = 3.3);
end;

procedure TTestOLDoubleArray.TestDelete;
var
  Arr: OLDoubleArray;
begin
  Arr.Clear;
  Arr.Add(1.1);
  Arr.Add(2.2);
  Arr.Add(3.3);
  Arr.Delete(1);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[0] = 1.1);
  CheckTrue(Arr[1] = 3.3);
end;

procedure TTestOLDoubleArray.TestClear;
var
  Arr: OLDoubleArray;
begin
  Arr.Add(1.1);
  Arr.Clear;
  CheckEquals(0, Arr.Length);
end;

procedure TTestOLDoubleArray.TestSort;
var
  Arr: OLDoubleArray;
begin
  Arr.Clear;
  Arr.Add(3.3);
  Arr.Add(1.1);
  Arr.Add(2.2);
  Arr.Sort;
  CheckTrue(Arr[0] = 1.1);
  CheckTrue(Arr[1] = 2.2);
  CheckTrue(Arr[2] = 3.3);
end;

procedure TTestOLDoubleArray.TestSorted;
var
  Arr, SortedArr: OLDoubleArray;
begin
  Arr.Clear;
  Arr.Add(3.3);
  Arr.Add(1.1);
  Arr.Add(2.2);
  SortedArr := Arr.Sorted;
  
  CheckTrue(Arr[0] = 3.3);
  CheckTrue(Arr[1] = 1.1);
  CheckTrue(Arr[2] = 2.2);

  CheckTrue(SortedArr[0] = 1.1);
  CheckTrue(SortedArr[1] = 2.2);
  CheckTrue(SortedArr[2] = 3.3);
end;

procedure TTestOLDoubleArray.TestLastItemIndex;
var
  Arr: OLDoubleArray;
begin
  Arr.Clear;
  CheckEquals(-1, Arr.LastItemIndex);
  Arr.Add(1.1);
  CheckEquals(0, Arr.LastItemIndex);
  Arr.Add(2.2);
  CheckEquals(1, Arr.LastItemIndex);
end;

procedure TTestOLDoubleArray.TestContainsValue;
var
  Arr: OLDoubleArray;
begin
  Arr.Clear;
  Arr.Add(1.1);
  Arr.Add(2.2);
  
  CheckTrue(Arr.ContainsValue(1.1));
  CheckFalse(Arr.ContainsValue(3.3));

  Arr.Sort;
  CheckTrue(Arr.ContainsValue(1.1));
  CheckFalse(Arr.ContainsValue(3.3));
end;

procedure TTestOLDoubleArray.TestDistinct;
var
  Arr, Dist: OLDoubleArray;
begin
  Arr.Clear;
  Arr.Add(1.1);
  Arr.Add(2.2);
  Arr.Add(1.1);
  Dist := Arr.Distinct;
  
  CheckEquals(2, Dist.Length);
  CheckTrue(Dist.ContainsValue(1.1));
  CheckTrue(Dist.ContainsValue(2.2));
end;

procedure TTestOLDoubleArray.TestReversed;
var
  Arr, Rev: OLDoubleArray;
begin
  Arr.Clear;
  Arr.Add(1.1);
  Arr.Add(2.2);
  Arr.Add(3.3);
  Rev := Arr.Reversed;
  
  CheckEquals(3, Rev.Length);
  CheckTrue(Rev[0] = 3.3);
  CheckTrue(Rev[1] = 2.2);
  CheckTrue(Rev[2] = 1.1);
end;

procedure TTestOLDoubleArray.TestImplicit;
var
  Arr: OLDoubleArray;
  DynArr: TOLDoubleDynArray;
begin
  {$IF CompilerVersion >= 34.0} // XE8+ supports array literal
    Arr := [1.1, 2.2, 3.3];
  {$ELSE} // Older Delphi versions: manual SetLength and assignments
    Arr[0] := 1.1;
    Arr[1] := 2.2;
    Arr[2] := 3.3;
  {$IFEND}
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = 1.1);

  DynArr := Arr;
  CheckEquals(3, Length(DynArr));
  CheckEquals(1.1, DynArr[0], 1e-10);
end;

{ TTestOLInt64Array }

procedure TTestOLInt64Array.TestAdd;
var
  Arr: OLInt64Array;
begin
  Arr.Clear;
  CheckEquals(0, Arr.Length);
  Arr.Add(10);
  CheckEquals(1, Arr.Length);
  CheckTrue(Arr[0] = 10);
  Arr.Add(20);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[1] = 20);
end;

procedure TTestOLInt64Array.TestInsert;
var
  Arr: OLInt64Array;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(30);
  Arr.Insert(1, 20);
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = 10);
  CheckTrue(Arr[1] = 20);
  CheckTrue(Arr[2] = 30);
end;

procedure TTestOLInt64Array.TestDelete;
var
  Arr: OLInt64Array;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(20);
  Arr.Add(30);
  Arr.Delete(1);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[0] = 10);
  CheckTrue(Arr[1] = 30);
end;

procedure TTestOLInt64Array.TestClear;
var
  Arr: OLInt64Array;
begin
  Arr.Add(10);
  Arr.Clear;
  CheckEquals(0, Arr.Length);
end;

procedure TTestOLInt64Array.TestSort;
var
  Arr: OLInt64Array;
begin
  Arr.Clear;
  Arr.Add(30);
  Arr.Add(10);
  Arr.Add(20);
  Arr.Sort;
  CheckTrue(Arr[0] = 10);
  CheckTrue(Arr[1] = 20);
  CheckTrue(Arr[2] = 30);
end;

procedure TTestOLInt64Array.TestSorted;
var
  Arr, SortedArr: OLInt64Array;
begin
  Arr.Clear;
  Arr.Add(30);
  Arr.Add(10);
  Arr.Add(20);
  SortedArr := Arr.Sorted;
  
  CheckTrue(Arr[0] = 30);
  CheckTrue(Arr[1] = 10);
  CheckTrue(Arr[2] = 20);

  CheckTrue(SortedArr[0] = 10);
  CheckTrue(SortedArr[1] = 20);
  CheckTrue(SortedArr[2] = 30);
end;

procedure TTestOLInt64Array.TestLastItemIndex;
var
  Arr: OLInt64Array;
begin
  Arr.Clear;
  CheckEquals(-1, Arr.LastItemIndex);
  Arr.Add(10);
  CheckEquals(0, Arr.LastItemIndex);
  Arr.Add(20);
  CheckEquals(1, Arr.LastItemIndex);
end;

procedure TTestOLInt64Array.TestContainsValue;
var
  Arr: OLInt64Array;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(20);
  
  CheckTrue(Arr.ContainsValue(10));
  CheckFalse(Arr.ContainsValue(30));

  Arr.Sort;
  CheckTrue(Arr.ContainsValue(10));
  CheckFalse(Arr.ContainsValue(30));
end;

procedure TTestOLInt64Array.TestDistinct;
var
  Arr, Dist: OLInt64Array;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(20);
  Arr.Add(10);
  Dist := Arr.Distinct;
  
  CheckEquals(2, Dist.Length);
  CheckTrue(Dist.ContainsValue(10));
  CheckTrue(Dist.ContainsValue(20));
end;

procedure TTestOLInt64Array.TestReversed;
var
  Arr, Rev: OLInt64Array;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(20);
  Arr.Add(30);
  Rev := Arr.Reversed;
  
  CheckEquals(3, Rev.Length);
  CheckTrue(Rev[0] = 30);
  CheckTrue(Rev[1] = 20);
  CheckTrue(Rev[2] = 10);
end;

procedure TTestOLInt64Array.TestImplicit;
var
  Arr: OLInt64Array;
  DynArr: TOLInt64DynArray;
begin
  {$IF CompilerVersion >= 34.0} // XE8+ supports array literal
    Arr := [10, 20, 30];
  {$ELSE} // Older Delphi versions: manual SetLength and assignments
    Arr[0] := 10;
    Arr[1] := 20;
    Arr[2] := 30;
  {$IFEND}
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = 10);

  DynArr := Arr;
  CheckEquals(3, Length(DynArr));
  CheckTrue(DynArr[0] = 10);
end;

{ TTestOLByteArray }

procedure TTestOLByteArray.TestAdd;
var
  Arr: OLByteArray;
begin
  Arr.Clear;
  CheckEquals(0, Arr.Length);
  Arr.Add(10);
  CheckEquals(1, Arr.Length);
  CheckTrue(Arr[0] = 10);
  Arr.Add(20);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[1] = 20);
end;

procedure TTestOLByteArray.TestInsert;
var
  Arr: OLByteArray;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(30);
  Arr.Insert(1, 20);
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = 10);
  CheckTrue(Arr[1] = 20);
  CheckTrue(Arr[2] = 30);
end;

procedure TTestOLByteArray.TestDelete;
var
  Arr: OLByteArray;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(20);
  Arr.Add(30);
  Arr.Delete(1);
  CheckEquals(2, Arr.Length);
  CheckTrue(Arr[0] = 10);
  CheckTrue(Arr[1] = 30);
end;

procedure TTestOLByteArray.TestClear;
var
  Arr: OLByteArray;
begin
  Arr.Add(10);
  Arr.Clear;
  CheckEquals(0, Arr.Length);
end;

procedure TTestOLByteArray.TestSort;
var
  Arr: OLByteArray;
begin
  Arr.Clear;
  Arr.Add(30);
  Arr.Add(10);
  Arr.Add(20);
  Arr.Sort;
  CheckTrue(Arr[0] = 10);
  CheckTrue(Arr[1] = 20);
  CheckTrue(Arr[2] = 30);
end;

procedure TTestOLByteArray.TestSorted;
var
  Arr, SortedArr: OLByteArray;
begin
  Arr.Clear;
  Arr.Add(30);
  Arr.Add(10);
  Arr.Add(20);
  SortedArr := Arr.Sorted;
  
  CheckTrue(Arr[0] = 30);
  CheckTrue(Arr[1] = 10);
  CheckTrue(Arr[2] = 20);

  CheckTrue(SortedArr[0] = 10);
  CheckTrue(SortedArr[1] = 20);
  CheckTrue(SortedArr[2] = 30);
end;

procedure TTestOLByteArray.TestLastItemIndex;
var
  Arr: OLByteArray;
begin
  Arr.Clear;
  CheckEquals(-1, Arr.LastItemIndex);
  Arr.Add(10);
  CheckEquals(0, Arr.LastItemIndex);
  Arr.Add(20);
  CheckEquals(1, Arr.LastItemIndex);
end;

procedure TTestOLByteArray.TestContainsValue;
var
  Arr: OLByteArray;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(20);
  
  CheckTrue(Arr.ContainsValue(10));
  CheckFalse(Arr.ContainsValue(30));

  Arr.Sort;
  CheckTrue(Arr.ContainsValue(10));
  CheckFalse(Arr.ContainsValue(30));
end;

procedure TTestOLByteArray.TestDistinct;
var
  Arr, Dist: OLByteArray;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(20);
  Arr.Add(10);
  Dist := Arr.Distinct(nil);
  
  CheckEquals(2, Dist.Length);
  CheckTrue(Dist.ContainsValue(10));
  CheckTrue(Dist.ContainsValue(20));
end;

procedure TTestOLByteArray.TestReversed;
var
  Arr, Rev: OLByteArray;
begin
  Arr.Clear;
  Arr.Add(10);
  Arr.Add(20);
  Arr.Add(30);
  Rev := Arr.Reversed;
  
  CheckEquals(3, Rev.Length);
  CheckTrue(Rev[0] = 30);
  CheckTrue(Rev[1] = 20);
  CheckTrue(Rev[2] = 10);
end;

procedure TTestOLByteArray.TestImplicit;
var
  Arr: OLByteArray;
  DynArr: TArray<Byte>;
  i: integer;
begin
  {$IF CompilerVersion >= 34.0} // XE8+ supports array literal
    Arr := [10, 20, 30];
  {$ELSE} // Older Delphi versions: manual SetLength and assignments
    Arr[0] := 10;
    Arr[1] := 20;
    Arr[2] := 30;
  {$IFEND}
  CheckEquals(3, Arr.Length);
  CheckTrue(Arr[0] = 10);

  {$IF CompilerVersion >= 24.0}
    // XE3+ → Copy works correctly for generic dynamic arrays
    DynArr := Arr;
  {$ELSE}
    // Older Delphi versions: manual array copy required
    if Arr.Length > 0 then
    begin
      System.SetLength(DynArr, Arr.Length);

      for i := 0 to Arr.Length - 1 do
        DynArr[i] := Arr[i];
    end
    else
      System.SetLength(DynArr, 0);
  {$IFEND}

  CheckEquals(3, Length(DynArr));
  CheckTrue(DynArr[0] = 10);
end;

initialization
  RegisterTest(TTestOLIntegerArray.Suite);
  RegisterTest(TTestOLStringArray.Suite);
  RegisterTest(TTestOLBooleanArray.Suite);
  RegisterTest(TTestOLCurrencyArray.Suite);
  RegisterTest(TTestOLDateTimeArray.Suite);
  RegisterTest(TTestOLDateArray.Suite);
  RegisterTest(TTestOLDoubleArray.Suite);
  RegisterTest(TTestOLInt64Array.Suite);
  RegisterTest(TTestOLByteArray.Suite);

end.
