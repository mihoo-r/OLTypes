unit OLTypes;

interface

uses
  OLBooleanType, OLCurrencyType, OLDateTimeType, OLDateType, OLDoubleType,
  OLIntegerType, OLInt64Type, OLStringType, SmartToDate, OLArrays, OLDictionaries,
  {$IF CompilerVersion >= 23.0} System.SysUtils, System.Classes, System.Generics.Collections, System.Rtti,
    Vcl.Forms, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Controls
  {$ELSE} SysUtils, Classes, Generics.Collections, Rtti,
    Forms, StdCtrls, Spin, ComCtrls, ExtCtrls, Controls
  {$IFEND};

type
  TRttiFieldHack = class(TRttiField);



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

   TFormFieldsHelper = class helper for TForm
   private
     function IsFieldOfRecord(const ctx: TRttiContext; const RecValue: TValue; ParamPtr: Pointer): Boolean;
   public
     function IsMyField(var X): Boolean;
   end;

implementation

uses OLTypesToEdits, TypInfo;

function GetFieldAddressHack(f: TRttiField; Instance: Pointer): Pointer;
begin
  Result := PByte(Instance) + TRttiFieldHack(f).Offset;
end;

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



{ TFormFieldsHelper }

function TFormFieldsHelper.IsFieldOfRecord(
  const ctx: TRttiContext; const RecValue: TValue; ParamPtr: Pointer): Boolean;
var
  RecType: TRttiStructuredType;
  f: TRttiField;
  FieldValue: TValue;
  RType: TRttiType;
  TK: TTypeKind;
begin
  Result := False;

  // Get RTTI type of the record
  RType := ctx.GetType(RecValue.TypeInfo);
  if not (RType is TRttiStructuredType) then
    Exit;

  RecType := TRttiStructuredType(RType);

  for f in RecType.GetFields do
  begin
    // 1. Compare direct field address
    if GetFieldAddressHack(f, RecValue.GetReferenceToRawData) = ParamPtr then
      Exit(True);

    FieldValue := f.GetValue(RecValue.GetReferenceToRawData);

    // 2. Check field type (RTTI)
    TK := f.FieldType.TypeKind;

    {$IF CompilerVersion >= 34.0}
    // Delphi 10.4+ — handle Managed Records
    if (TK = tkRecord) or (TK = tkMRecord) then
    {$ELSE}
    // Delphi XE..10.3 — only standard records
    if TK = tkRecord then
    {$IFEND}
    begin
      // Recurse into nested record fields
      if IsFieldOfRecord(ctx, FieldValue, ParamPtr) then
        Exit(True);
    end;
  end;
end;


function TFormFieldsHelper.IsMyField(var X): Boolean;
var
  ctx: TRttiContext;
  t: TRttiType;
  f: TRttiField;
  FieldValue: TValue;
  ParamPtr: Pointer;
  TK: TTypeKind;
begin
  Result := False;
  ParamPtr := @X;

  t := ctx.GetType(Self.ClassType);
  if t = nil then
    Exit(False);

  for f in t.GetFields do
  begin
    // 1. Compare direct field address
    if GetFieldAddressHack(f, Self) = ParamPtr then
      Exit(True);

    FieldValue := f.GetValue(Self);

    // 2. Recurse into record fields
    TK := f.FieldType.TypeKind;

    {$IF CompilerVersion >= 34.0}
    if (TK = tkRecord) or (TK = tkMRecord) then
    {$ELSE}
    if TK = tkRecord then
    {$IFEND}
    begin
      if IsFieldOfRecord(ctx, FieldValue, ParamPtr) then
        Exit(True);
    end;
  end;
end;

{ TOLEditHelper }

procedure TOLEditHelper.Link(var i: OLInteger; const Alignment: TAlignment);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(i) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, i, Alignment);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;


procedure TOLEditHelper.Link(var d: OLDouble; const Format: string; const Alignment: TAlignment);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(d) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, d, Format, Alignment);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;


procedure TOLEditHelper.Link(var curr: OLCurrency; const Format: string; const Alignment: TAlignment);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(curr) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, curr, Format, Alignment);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;

procedure TOLEditHelper.Link(var s: OLString);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(s) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, s);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TEdit: ' + E.Message);
   end;
end;

{ TOLSpinEditHelper }

procedure TOLSpinEditHelper.Link(var i: OLInteger);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(i) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, i);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TSpinEdit: ' + E.Message);
   end;
end;

{ TOLTrackBarHelper }

procedure TOLTrackBarHelper.Link(var i: OLInteger);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(i) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, i);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TTrackBar: ' + E.Message);
   end;
end;

{ TOLScrollBarHelper }

procedure TOLScrollBarHelper.Link(var i: OLInteger);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(i) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, i);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TScrollBar: ' + E.Message);
   end;
end;

{ TOLMemoHelper }

procedure TOLMemoHelper.Link(var s: OLString);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(s) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, s);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TMemo: ' + E.Message);
   end;
end;

{ TOLDateTimePickerHelper }

procedure TOLDateTimePickerHelper.Link(var d: OLDate);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(d) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, d);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TDateTimePicker: ' + E.Message);
   end;
end;

procedure TOLDateTimePickerHelper.Link(var d: OLDateTime);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(d) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, d);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TDateTimePicker: ' + E.Message);
   end;
end;

{ TOLCheckBoxHelper }

procedure TOLCheckBoxHelper.Link(var b: OLBoolean);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(b) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, b);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TCheckBox: ' + E.Message);
   end;
end;

{ TOLLabelHelper }

procedure TOLLabelHelper.Link(var i: OLInteger);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(i) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, i);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var s: OLString);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(s) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, s);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var d: OLDouble; const Format: string);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(d) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, d, Format);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDouble; const Format: string; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, Format, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var curr: OLCurrency; const Format: string);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(curr) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, curr, Format);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLCurrency; const Format: string; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, Format, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var d: OLDate);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(d) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, d);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var d: OLDateTime);
var
  Form: TForm;
begin
   if not Assigned(Self) then
     raise Exception.Create('Control is nil.');
   Form := Self.Owner as TForm;
   if not Assigned(Form) then
     raise Exception.Create('Control must be owned by a TForm.');
   
   if not Form.IsMyField(d) then
     raise Exception.Create('OLType must be a field of the owning TForm.');

   try
     Links.Link(Self, d);
   except
     on E: Exception do
       raise Exception.Create('Link failed for TLabel: ' + E.Message);
   end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
begin
   Links.Link(Self, f, ValueOnErrorInCalculation);
end;

end.
