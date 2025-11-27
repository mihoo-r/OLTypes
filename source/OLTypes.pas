unit OLTypes;

interface

uses OLBooleanType, OLCurrencyType, OLDateTimeType, OLDateType, OLDoubleType,
   OLIntegerType, OLInt64Type, OLStringType, SmartToDate, System.Threading,
   System.SysUtils, OLArrays, OLDictionaries, Vcl.Forms, Vcl.StdCtrls,
   Vcl.Samples.Spin, Vcl.ComCtrls, System.Classes,
   System.Generics.Collections, Vcl.ExtCtrls, Vcl.Controls;

const
  ERROR_STRING = '#ERROR';
  DOUBLE_FORMAT = '###,###,###,##0.0####';
  CURRENCY_FORMAT = '###,###,###,##0.00##';

type
  TFunctionReturningOLInteger = reference to function(): OLInteger;
  TFunctionReturningOLString = reference to function(): OLString;
  TFunctionReturningOLDouble = reference to function(): OLDouble;
  TFunctionReturningOLCurrency = reference to function(): OLCurrency;
  TFunctionReturningOLDate = reference to function(): OLDate;
  TFunctionReturningOLDateTime= reference to function(): OLDateTime;


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
  
  {$IF CompilerVersion >= 34.0}
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
  {$IFEND}


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

   type
   TOLEditHelper = class helper for TEdit
     procedure Link(var i: OLInteger; const Alignment: TAlignment=taRightJustify); overload;
     procedure Link(var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify); overload;
     procedure Link(var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify); overload;
     procedure Link(var s: OLString); overload;
   end;

   TOLSpinEditHelper = class helper for TSpinEdit
     procedure Link(var i: OLInteger);
   end;

   TOLTrackBarHelper = class helper for TTrackBar
     procedure Link(var i: OLInteger);
   end;

   TOLScrollBarHelper = class helper for TScrollBar
     procedure Link(var i: OLInteger);
   end;

   TOLMemoHelper = class helper for TMemo
     procedure Link(var s: OLString);
   end;

   TOLDateTimePickerHelper = class helper for TDateTimePicker
     procedure Link(var d: OLDate); overload;
     procedure Link(var d: OLDateTime); overload;
   end;

   TOLCheckBoxHelper = class helper for TCheckBox
     procedure Link(var b: OLBoolean);
   end;



   TOLLabelHelper = class helper for TLabel
     procedure Link(var i: OLInteger); overload;
     procedure Link(const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
     procedure Link(var s: OLString); overload;
     procedure Link(const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
     procedure Link(var d: OLDouble; const Format: string = DOUBLE_FORMAT); overload;
     procedure Link(const f: TFunctionReturningOLDouble; const Format: string = DOUBLE_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
     procedure Link(var curr: OLCurrency; const Format: string = CURRENCY_FORMAT); overload;
     procedure Link(const f: TFunctionReturningOLCurrency; const Format: string = CURRENCY_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
     procedure Link(var d: OLDate); overload;
     procedure Link(const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
     procedure Link(var d: OLDateTime); overload;
     procedure Link(const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
   end;

implementation

uses OLTypesToEdits;

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

{ TOLEditHelper }

procedure TOLEditHelper.Link(var i: OLInteger; const Alignment: TAlignment);
begin
   try
     Links.Link(Self, i, Alignment);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;


procedure TOLEditHelper.Link(var d: OLDouble; const Format: string; const Alignment: TAlignment);
begin
   try
     Links.Link(Self, d, Format, Alignment);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;


procedure TOLEditHelper.Link(var curr: OLCurrency; const Format: string; const Alignment: TAlignment);
begin
   try
     Links.Link(Self, curr, Format, Alignment);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;

procedure TOLEditHelper.Link(var s: OLString);
begin
   try
     Links.Link(Self, s);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;

{ TOLSpinEditHelper }

procedure TOLSpinEditHelper.Link(var i: OLInteger);
begin
   try
     Links.Link(Self, i);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TSpinEdit: ' + E.Message);
   end;
end;

{ TOLTrackBarHelper }

procedure TOLTrackBarHelper.Link(var i: OLInteger);
begin
   Links.Link(Self, i);
end;

{ TOLScrollBarHelper }

procedure TOLScrollBarHelper.Link(var i: OLInteger);
begin
   Links.Link(Self, i);
end;

{ TOLMemoHelper }

procedure TOLMemoHelper.Link(var s: OLString);
begin
   Links.Link(Self, s);
end;

{ TOLDateTimePickerHelper }

procedure TOLDateTimePickerHelper.Link(var d: OLDate);
begin
   Links.Link(Self, d);
end;

procedure TOLDateTimePickerHelper.Link(var d: OLDateTime);
begin
   Links.Link(Self, d);
end;

{ TOLCheckBoxHelper }

procedure TOLCheckBoxHelper.Link(var b: OLBoolean);
begin
   Links.Link(Self, b);
end;

{ TOLLabelHelper }

procedure TOLLabelHelper.Link(var i: OLInteger);
begin
   Links.Link(Self, i);
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var s: OLString);
begin
   Links.Link(Self, s);
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var d: OLDouble; const Format: string);
begin
   Links.Link(Self, d, Format);
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDouble; const Format: string; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, Format, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var curr: OLCurrency; const Format: string);
begin
   Links.Link(Self, curr, Format);
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLCurrency; const Format: string; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, Format, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var d: OLDate);
begin
   Links.Link(Self, d);
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var d: OLDateTime);
begin
   Links.Link(Self, d);
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, ValueOnErrorInCalculation);
end;

end.
