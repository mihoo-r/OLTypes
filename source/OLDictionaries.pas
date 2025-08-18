unit OLDictionaries;

interface

uses OLTypes, System.Generics.Collections, OLStringType;

type
  OLIntIntDictionary = record

  end;

  OLIntStrDictionary = record

  end;

  OLIntFloatDictionary = record

  end;

  OLIntCurrDictionary = record

  end;

  OLIntBooleanDictionary = record
  private
    Dict: TDictionary<integer, OLBoolean>;
    function GetValue(Key: integer): OLBoolean;
    procedure SetValue(Key: integer; const Value: OLBoolean);
    function GetKeys: TDictionary<integer, OLBoolean>.TKeyCollection;
  public
     class operator Initialize (out Dest: OLIntBooleanDictionary);
     class operator Finalize(var Dest: OLIntBooleanDictionary);

     class operator Assign (var Dest: OLIntBooleanDictionary; const [ref] Src: OLIntBooleanDictionary);
     procedure Clear();
     function ContainsKey(Key: OLInteger): OLBoolean;
     function GetEnumerator: TDictionary<integer, OLBoolean>.TPairEnumerator;

     property Values[Key: integer]: OLBoolean read GetValue write SetValue;  default;
     property Keys: TDictionary<integer, OLBoolean>.TKeyCollection read GetKeys;
     function ToArray(): TArray<TPair<integer, OLBoolean>>;
  end;

  OLStrStrDictionary = record
  private
    Dict: TDictionary<string, OLString>;
    function GetValue(Key: string): OLString;
    procedure SetValue(Key: string; const Value: OLString);
    function GetKeys: TDictionary<string, OLString>.TKeyCollection;
  public
     class operator Initialize (out Dest: OLStrStrDictionary);
     class operator Finalize(var Dest: OLStrStrDictionary);

     class operator Assign (var Dest: OLStrStrDictionary; const [ref] Src: OLStrStrDictionary);
     procedure Clear();
     function ContainsKey(Key: OLString): OLBoolean;
     function GetEnumerator: TDictionary<string, OLString>.TPairEnumerator;

     property Values[Key: string]: OLString read GetValue write SetValue;  default;
     property Keys: TDictionary<string, OLString>.TKeyCollection read GetKeys;
     function ToArray(): TArray<TPair<string, OLString>>;
  end;

  OLStrIntDictionary = record
  private
    Dict: TDictionary<string, OLInteger>;
    function GetValue(Key: string): OLInteger;
    procedure SetValue(Key: string; const Value: OLInteger);
    function GetKeys: TDictionary<string, OLInteger>.TKeyCollection;
  public
     class operator Initialize (out Dest: OLStrIntDictionary);
     class operator Finalize(var Dest: OLStrIntDictionary);

     class operator Assign (var Dest: OLStrIntDictionary; const [ref] Src: OLStrIntDictionary);
     procedure Clear();
     function ContainsKey(Key: string): OLBoolean;
     function GetEnumerator: TDictionary<string, OLInteger>.TPairEnumerator;

     property Values[Key: string]: OLInteger read GetValue write SetValue;  default;
     property Keys: TDictionary<string, OLInteger>.TKeyCollection read GetKeys;
     function ToArray(): TArray<TPair<string, OLInteger>>;
  end;

  OLStrCurrDictionary = record
  private
    Dict: TDictionary<string, OLCurrency>;
    function GetValue(Key: string): OLCurrency;
    procedure SetValue(Key: string; const Value: OLCurrency);
    function GetKeys: TDictionary<string, OLCurrency>.TKeyCollection;
  public
     class operator Initialize (out Dest: OLStrCurrDictionary);
     class operator Finalize(var Dest: OLStrCurrDictionary);

     class operator Assign (var Dest: OLStrCurrDictionary; const [ref] Src: OLStrCurrDictionary);
     procedure Clear();
     function ContainsKey(Key: OLString): OLBoolean;
     function GetEnumerator: TDictionary<string, OLCurrency>.TPairEnumerator;

     property Values[Key: string]: OLCurrency read GetValue write SetValue;  default;
     property Keys: TDictionary<string, OLCurrency>.TKeyCollection read GetKeys;
     function ToArray(): TArray<TPair<string, OLCurrency>>;
  end;

  OLIntDateDictionary = record
  private
    Dict: TDictionary<integer, OLDate>;
    function GetValue(Key: integer): OLDate;
    procedure SetValue(Key: integer; const Value: OLDate);
    function GetKeys: TDictionary<integer, OLDate>.TKeyCollection;
  public
     class operator Initialize (out Dest: OLIntDateDictionary);
     class operator Finalize(var Dest: OLIntDateDictionary);

     class operator Assign (var Dest: OLIntDateDictionary; const [ref] Src: OLIntDateDictionary);
     procedure Clear();
     function ContainsKey(Key: OLInteger): OLBoolean;
     function GetEnumerator: TDictionary<integer, OLDate>.TPairEnumerator;

     property Values[Key: integer]: OLDate read GetValue write SetValue;  default;
     property Keys: TDictionary<integer, OLDate>.TKeyCollection read GetKeys;
     function ToArray(): TArray<TPair<integer, OLDate>>;
  end;

  OLStrFloatDictionary = record

  end;


implementation

uses
  System.SysUtils, System.Generics.Defaults;

class operator OLStrCurrDictionary.Initialize (out Dest: OLStrCurrDictionary);
begin
  Dest.Dict := TDictionary<string, OLCurrency>.Create();
end;

class operator OLStrCurrDictionary.Finalize(var Dest: OLStrCurrDictionary);
begin
  Dest.Dict.Free();
end;

procedure OLStrCurrDictionary.Clear();
begin
  Dict.Clear();
end;

function OLStrCurrDictionary.ContainsKey(Key: OLString): OLBoolean;
begin
  Result := Dict.ContainsKey(Key);
end;

function OLStrCurrDictionary.GetKeys: TDictionary<string, OLCurrency>.TKeyCollection;
begin
  Result := Dict.Keys;
end;

function OLStrCurrDictionary.GetValue(Key: string): OLCurrency;
var
  OutPut: OLCurrency;
begin
  if Dict.ContainsKey(Key) then
    OutPut := Dict[Key];

  Result := OutPut;
end;

class operator OLStrCurrDictionary.Assign (var Dest: OLStrCurrDictionary; const [ref] Src: OLStrCurrDictionary);
begin
  Dest.Dict.Clear();

  for var p in Src.Dict do
    Dest.Dict.AddOrSetValue(p.Key, p.Value);
end;

procedure OLStrCurrDictionary.SetValue(Key: string; const Value: OLCurrency);
begin
  Dict.AddOrSetValue(Key, Value);
end;

function OLStrCurrDictionary.GetEnumerator: TDictionary<string, OLCurrency>.TPairEnumerator;
begin
  result :=  Dict.GetEnumerator();
end;

function OLStrCurrDictionary.ToArray(): TArray<TPair<string, OLCurrency>>;
begin
  Result := Dict.ToArray();
end;

//===OLIntBooleanDictionary
class operator OLIntBooleanDictionary.Initialize (out Dest: OLIntBooleanDictionary);
begin
  Dest.Dict := TDictionary<integer, OLBoolean>.Create();
end;

class operator OLIntBooleanDictionary.Finalize(var Dest: OLIntBooleanDictionary);
begin
  Dest.Dict.Free();
end;

procedure OLIntBooleanDictionary.Clear();
begin
  Dict.Clear();
end;

function OLIntBooleanDictionary.ContainsKey(Key: OLInteger): OLBoolean;
begin
  Result := Dict.ContainsKey(Key);
end;

function OLIntBooleanDictionary.GetKeys: TDictionary<integer, OLBoolean>.TKeyCollection;
begin
  Result := Dict.Keys;
end;

function OLIntBooleanDictionary.GetValue(Key: integer): OLBoolean;
var
  OutPut: OLBoolean;
begin
  if Dict.ContainsKey(Key) then
    OutPut := Dict[Key];

  Result := OutPut;
end;

class operator OLIntBooleanDictionary.Assign (var Dest: OLIntBooleanDictionary; const [ref] Src: OLIntBooleanDictionary);
begin
  Dest.Dict.Clear();

  for var p in Src.Dict do
    Dest.Dict.AddOrSetValue(p.Key, p.Value);
end;

procedure OLIntBooleanDictionary.SetValue(Key: integer; const Value: OLBoolean);
begin
  Dict.AddOrSetValue(Key, Value);
end;

function OLIntBooleanDictionary.GetEnumerator: TDictionary<integer, OLBoolean>.TPairEnumerator;
begin
  result :=  Dict.GetEnumerator();
end;

function OLIntBooleanDictionary.ToArray(): TArray<TPair<integer, OLBoolean>>;
begin
  Result := Dict.ToArray();
end;


//===OLStrStrDictionary
class operator OLStrStrDictionary.Initialize (out Dest: OLStrStrDictionary);
begin
  Dest.Dict := TDictionary<string, OLString>.Create();
end;

class operator OLStrStrDictionary.Finalize(var Dest: OLStrStrDictionary);
begin
  Dest.Dict.Free();
end;

procedure OLStrStrDictionary.Clear();
begin
  Dict.Clear();
end;

function OLStrStrDictionary.ContainsKey(Key: OLString): OLBoolean;
begin
  Result := Dict.ContainsKey(Key);
end;

function OLStrStrDictionary.GetKeys: TDictionary<string, OLString>.TKeyCollection;
begin
  Result := Dict.Keys;
end;

function OLStrStrDictionary.GetValue(Key: string): OLString;
var
  OutPut: OLString;
begin
  if Dict.ContainsKey(Key) then
    OutPut := Dict[Key];

  Result := OutPut;
end;

class operator OLStrStrDictionary.Assign (var Dest: OLStrStrDictionary; const [ref] Src: OLStrStrDictionary);
begin
  Dest.Dict.Clear();

  for var p in Src.Dict do
    Dest.Dict.AddOrSetValue(p.Key, p.Value);
end;

procedure OLStrStrDictionary.SetValue(Key: string; const Value: OLString);
begin
  Dict.AddOrSetValue(Key, Value);
end;

function OLStrStrDictionary.GetEnumerator: TDictionary<string, OLString>.TPairEnumerator;
begin
  result :=  Dict.GetEnumerator();
end;

function OLStrStrDictionary.ToArray(): TArray<TPair<string, OLString>>;
begin
  Result := Dict.ToArray();
end;

//===OLStrIntDictionary
class operator OLStrIntDictionary.Initialize (out Dest: OLStrIntDictionary);
begin
  Dest.Dict := TDictionary<string, OLInteger>.Create();
end;

class operator OLStrIntDictionary.Finalize(var Dest: OLStrIntDictionary);
begin
  Dest.Dict.Free();
end;

procedure OLStrIntDictionary.Clear();
begin
  Dict.Clear();
end;

function OLStrIntDictionary.ContainsKey(Key: string): OLBoolean;
begin
  Result := Dict.ContainsKey(Key);
end;

function OLStrIntDictionary.GetKeys: TDictionary<string, OLInteger>.TKeyCollection;
begin
  Result := Dict.Keys;
end;

function OLStrIntDictionary.GetValue(Key: string): OLInteger;
var
  OutPut: OLInteger;
begin
  if Dict.ContainsKey(Key) then
    OutPut := Dict[Key];

  Result := OutPut;
end;

class operator OLStrIntDictionary.Assign (var Dest: OLStrIntDictionary; const [ref] Src: OLStrIntDictionary);
begin
  Dest.Dict.Clear();

  for var p in Src.Dict do
    Dest.Dict.AddOrSetValue(p.Key, p.Value);
end;

procedure OLStrIntDictionary.SetValue(Key: string; const Value: OLInteger);
begin
  Dict.AddOrSetValue(Key, Value);
end;

function OLStrIntDictionary.GetEnumerator: TDictionary<string, OLInteger>.TPairEnumerator;
begin
  result :=  Dict.GetEnumerator();
end;

function OLStrIntDictionary.ToArray(): TArray<TPair<string, OLInteger>>;
begin
  Result := Dict.ToArray();
end;


//===OLIntDateDictionary
class operator OLIntDateDictionary.Initialize (out Dest: OLIntDateDictionary);
begin
  Dest.Dict := TDictionary<integer, OLDate>.Create();
end;

class operator OLIntDateDictionary.Finalize(var Dest: OLIntDateDictionary);
begin
  Dest.Dict.Free();
end;

procedure OLIntDateDictionary.Clear();
begin
  Dict.Clear();
end;

function OLIntDateDictionary.ContainsKey(Key: OLInteger): OLBoolean;
begin
  Result := Dict.ContainsKey(Key);
end;

function OLIntDateDictionary.GetKeys: TDictionary<integer, OLDate>.TKeyCollection;
begin
  Result := Dict.Keys;
end;

function OLIntDateDictionary.GetValue(Key: integer): OLDate;
var
  OutPut: OLDate;
begin
  if Dict.ContainsKey(Key) then
    OutPut := Dict[Key];

  Result := OutPut;
end;

class operator OLIntDateDictionary.Assign (var Dest: OLIntDateDictionary; const [ref] Src: OLIntDateDictionary);
begin
  Dest.Dict.Clear();

  for var p in Src.Dict do
    Dest.Dict.AddOrSetValue(p.Key, p.Value);
end;

procedure OLIntDateDictionary.SetValue(Key: integer; const Value: OLDate);
begin
  Dict.AddOrSetValue(Key, Value);
end;

function OLIntDateDictionary.GetEnumerator: TDictionary<integer, OLDate>.TPairEnumerator;
begin
  result :=  Dict.GetEnumerator();
end;

function OLIntDateDictionary.ToArray(): TArray<TPair<integer, OLDate>>;
begin
  Result := Dict.ToArray();
end;

end.
