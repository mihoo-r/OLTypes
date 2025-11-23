unit OLTypes;

interface

uses OLBooleanType, OLCurrencyType, OLDateTimeType, OLDateType, OLDoubleType,
  OLIntegerType, OLInt64Type, OLStringType, SmartToDate, System.Threading,
  System.SysUtils, OLArrays, OLDictionaries;

type
  OLBoolean = OLBooleanType.OLBoolean;
  OLCurrency = OLCurrencyType.OLCurrency;
  OLDecimal = OLCurrencyType.OLCurrency;
  OLDateTime = OLDateTimeType.OLDateTime;
  OLDate = OLDateType.OLDate;
  OLDouble = OLDoubleType.OLDouble;
  OLInteger = OLIntegerType.OLInteger;
  OLInt64 = OLInt64Type.OLInt64;
  OLString = OLStringType.OLString;

  POLBoolean = OLBooleanType.POLBoolean;
  POLCurrency = OLCurrencyType.POLCurrency;
  POLDecimal = OLCurrencyType.POLCurrency;
  POLDateTime = OLDateTimeType.POLDateTime;
  POLDate = OLDateType.POLDate;
  POLDouble = OLDoubleType.POLDouble;
  POLInteger = OLIntegerType.POLInteger;
  POLInt64 = OLInt64Type.POLInt64;
  POLString = OLStringType.POLString;

  TBooleanDynArray = OLArrays.TBooleanDynArray;
  TCurrencyDynArray = OLArrays.TCurrencyDynArray;
  TDateTimeDynArray = OLArrays.TDateTimeDynArray;
  TDateDynArray = OLArrays.TDateDynArray;
  TDoubleDynArray = OLArrays.TDoubleDynArray;
  TIntegerDynArray = OLArrays.TIntegerDynArray;
  TInt64DynArray = OLArrays.TInt64DynArray;
  TByteDynArray = OLArrays.TByteDynArray;
  TStringDynArray = OLArrays.TStringDynArray;

  OLBooleanArray = OLArrays.OLBooleanArray;
  OLCurrencyArray = OLArrays.OLCurrencyArray;
  OLDateTimeArray = OLArrays.OLDateTimeArray;
  OLDateArray = OLArrays.OLDateArray;
  OLDoubleArray = OLArrays.OLDoubleArray;
  OLIntegerArray = OLArrays.OLIntegerArray;
  OLInt64Array = OLArrays.OLInt64Array;
  OLByteArray = OLArrays.OLByteArray;
  OLStringArray = OLArrays.OLStringArray;

  OLIntIntDictionary = OLDictionaries.OLIntIntDictionary;
  OLIntStrDictionary = OLDictionaries.OLIntStrDictionary;
  OLIntDblDictionary = OLDictionaries.OLIntDblDictionary;
  OLIntCurrDictionary = OLDictionaries.OLIntCurrDictionary;
  OLIntBooleanDictionary = OLDictionaries.OLIntBooleanDictionary;
  OLStrStrDictionary = OLDictionaries.OLStrStrDictionary;
  OLStrIntDictionary = OLDictionaries.OLStrIntDictionary;
  OLStrCurrDictionary = OLDictionaries.OLStrCurrDictionary;
  OLIntDateDictionary = OLDictionaries.OLIntDateDictionary;
  OLStrDblDictionary = OLDictionaries.OLStrDblDictionary;


  TStringPatternFind = OLStringType.TStringPatternFind;

  TCaseSensitivity = OLStringType.TCaseSensitivity;
  const
    csCaseSensitive = OLStringType.csCaseSensitive;
    csCaseInsensitive = OLStringType.csCaseInsensitive;


function OLType(b: System.Boolean): OLBoolean; overload;
function OLType(c: System.Currency): OLCurrency; overload;
function OLType(d: System.TDateTime): OLDateTime; overload;
function OLType(d: System.TDate): OLDate; overload;
function OLType(d: System.Double): OLDouble; overload;
function OLType(d: System.Extended): OLDouble; overload;
function OLType(i: System.Integer): OLInteger; overload;
function OLType(i: System.Int64): OLInt64; overload;
function OLType(s: System.string): OLString; overload;

function OLFuture(f: TFunc<OLInteger>): IFuture<OLInteger>; overload;
function OLFuture(f: TFunc<integer>): IFuture<OLInteger>; overload;

const
  // today, yesterday, tomorow
  ssTD = SmartToDate.ssTD;
  ssTM = SmartToDate.ssTM;
  ssYD = SmartToDate.ssYD;

  // Start/End of the Month/Year
  ssSY = SmartToDate.ssSY;
  ssEY = SmartToDate.ssEY;
  ssSM = SmartToDate.ssSM;
  ssEM = SmartToDate.ssEM;

  // Start/End of the Next Month/Year
  ssSNY = SmartToDate.ssSNY;
  ssENY = SmartToDate.ssENY;
  ssSNM = SmartToDate.ssSNM;
  ssENM = SmartToDate.ssENM;

  // Start/End of the Prior Month/Year
  ssSPY = SmartToDate.ssSPY;
  ssEPY = SmartToDate.ssEPY;
  ssSPM = SmartToDate.ssSPM;
  ssEPM = SmartToDate.ssEPM;

  EmptyChar: Char = #0;

  END_OF_THE_STRING = OLStringtype.END_OF_THE_STRING;

implementation

function OLType(b: System.Boolean): OLBoolean;
begin
  Result := b;
end;

function OLType(c: System.Currency): OLCurrency;
begin
  Result := c;
end;

function OLType(d: System.TDateTime): OLDateTime;
begin
  Result := d;
end;

function OLType(d: System.TDate): OLDate;
begin
  Result := d;
end;

function OLType(d: System.Double): OLDouble;
begin
  Result := d;
end;

function OLType(d: System.Extended): OLDouble; overload;
begin
  Result := d;
end;

function OLType(i: System.Integer): OLInteger;
begin
  Result := i;
end;

function OLType(i: System.Int64): OLInt64;
begin
  Result := i;
end;

function OLType(s: System.string): OLString;
begin
  Result := s;
end;

function OLFuture(f: TFunc<OLInteger>): IFuture<OLInteger>;
begin
  Result := TTask.Future<OLInteger>(f);
end;

function OLFuture(f: TFunc<integer>): IFuture<OLInteger>;
begin
  Result := TTask.Future<OLInteger>(
    function: OLInteger
    begin
      Result := f();
    end);
end;

end.
