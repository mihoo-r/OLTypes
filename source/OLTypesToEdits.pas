unit OLTypesToEdits;

{$IF CompilerVersion >= 34.0}

interface

uses OLTypes, System.Generics.Collections,
  {$IF CompilerVersion >= 23.0}
  Vcl.StdCtrls, System.SysUtils, Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.Forms, System.Classes;
  {$ELSE}
  StdCtrls, SysUtils, Spin, ComCtrls, Forms, Classes;
  {$IFEND}

const
  ERROR_STRING = '#ERROR';

type
  POLInteger = ^OLInteger;
  POLString = ^OLString;
  POLDouble = ^OLDouble;
  POLCurrency = ^OLCurrency;
  POLDate = ^OLDate;
  POLDateTime = ^OLDateTime;
  POLBoolean = ^OLBoolean;

  TEditOnChange = procedure (Sender: TObject) of object;
  TEditOnClick = procedure (Sender: TObject) of object;
  TEditOnEnter = procedure (Sender: TObject) of object;
  TEditOnKeyPress = procedure (Sender: TObject; var Key: Char) of object;

  TFunctionReturningOLInteger = reference to function(): OLInteger;
  TFunctionReturningOLString = reference to function(): OLString;
  TFunctionReturningOLDouble = reference to function(): OLDouble;
  TFunctionReturningOLCurrency = reference to function(): OLCurrency;
  TFunctionReturningOLDate = reference to function(): OLDate;
  TFunctionReturningOLDateTime= reference to function(): OLDateTime;

  TEditToOLInteger = class
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLInteger);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TSpinEditToOLInteger = class
  private
    FEdit: TSpinEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    procedure SetEdit(const Value: TSpinEdit);
    procedure SetOLPointer(const Value: POLInteger);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TSpinEdit read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TScrollBarToILInteger = class
  private
    FEdit: TScrollBar;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    procedure SetEdit(const Value: TScrollBar);
    procedure SetOLPointer(const Value: POLInteger);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TScrollBar read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TTrackBarToILInteger = class
  private
    FEdit: TTrackBar;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    procedure SetEdit(const Value: TTrackBar);
    procedure SetOLPointer(const Value: POLInteger);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TTrackBar read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TEditToOLDouble = class
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLDouble;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLDouble);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLDouble read FOLPointer write SetOLPointer;
  end;

  TEditToOLCurrency = class
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLCurrency;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLCurrency);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLCurrency read FOLPointer write SetOLPointer;
  end;

  TEditToOLString = class
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLString;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLString);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLString read FOLPointer write SetOLPointer;
  end;

  TMemoToOLString = class
  private
    FEdit: TMemo;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLString;
    procedure SetEdit(const Value: TMemo);
    procedure SetOLPointer(const Value: POLString);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TMemo read FEdit write SetEdit;
    property OLPointer: POLString read FOLPointer write SetOLPointer;
  end;

  TDateTimePickerToOLDate = class
  private
    FEdit: TDateTimePicker;
    FEditOnChange: TEditOnChange;
    FEditOnEnter: TEditOnEnter;
    FEditOnKeyPress: TEditOnKeyPress;
    FOLPointer: POLDate;
    NotNullFormat: string;
    LastTwoKeys, LastThreeKeys: OLString;
    procedure SetEdit(const Value: TDateTimePicker);
    procedure SetOLPointer(const Value: POLDate);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure NewOnEnter(Sender: TObject);
    procedure NewOnKeyPress(Sender: TObject; var Key: Char);
    procedure RefreshEdit();
    property Edit: TDateTimePicker read FEdit write SetEdit;
    property OLPointer: POLDate read FOLPointer write SetOLPointer;
  end;

  TDateTimePickerToOLDateTime = class
  private
    FEdit: TDateTimePicker;
    FEditOnChange: TEditOnChange;
    FEditOnEnter: TEditOnEnter;
    FEditOnKeyPress: TEditOnKeyPress;
    FOLPointer: POLDateTime;
    NotNullFormat: string;
    LastTwoKeys, LastThreeKeys: OLString;
    procedure SetEdit(const Value: TDateTimePicker);
    procedure SetOLPointer(const Value: POLDateTime);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure NewOnEnter(Sender: TObject);
    procedure NewOnKeyPress(Sender: TObject; var Key: Char);
    procedure RefreshEdit();
    property Edit: TDateTimePicker read FEdit write SetEdit;
    property OLPointer: POLDateTime read FOLPointer write SetOLPointer;
  end;

  TCheckBoxToOLBoolean = class
  private
    FEdit: TCheckBox;
    FEditOnClick: TEditOnClick;
    FOLPointer: POLBoolean;
    procedure SetEdit(const Value: TCheckBox);
    procedure SetOLPointer(const Value: POLBoolean);
  public
    constructor Create;
    procedure NewOnClick(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TCheckBox read FEdit write SetEdit;
    property OLPointer: POLBoolean read FOLPointer write SetOLPointer;
  end;

  TOLIntegerToLabel = class
  private
    FLabel: TLabel;
    FOLPointer: POLInteger;
    FCalculation: TFunctionReturningOLInteger;
    FValueOnErrorInCalculation: OLString;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLInteger);
    procedure SetCalculation(const Value: TFunctionReturningOLInteger);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
  public
    constructor Create;
    procedure RefreshLabel;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLInteger read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLStringToLabel = class
  private
    FLabel: TLabel;
    FOLPointer: POLString;
    FCalculation: TFunctionReturningOLString;
    FValueOnErrorInCalculation: OLString;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLString);
    procedure SetCalculation(const Value: TFunctionReturningOLString);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
  public
    constructor Create;
    procedure RefreshLabel;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLString read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLString read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLDoubleToLabel = class
  private
    FLabel: TLabel;
    FOLPointer: POLDouble;
    FCalculation: TFunctionReturningOLDouble;
    FValueOnErrorInCalculation: OLString;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLDouble);
    procedure SetCalculation(const Value: TFunctionReturningOLDouble);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
  public
    constructor Create;
    procedure RefreshLabel;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLDouble read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLDouble read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLCurrencyToLabel = class
  private
    FLabel: TLabel;
    FOLPointer: POLCurrency;
    FCalculation: TFunctionReturningOLCurrency;
    FValueOnErrorInCalculation: OLString;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLCurrency);
    procedure SetCalculation(const Value: TFunctionReturningOLCurrency);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
  public
    constructor Create;
    procedure RefreshLabel;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLCurrency read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLCurrency read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLDateToLabel = class
  private
    FLabel: TLabel;
    FOLPointer: POLDate;
    FCalculation: TFunctionReturningOLDate;
    FValueOnErrorInCalculation: OLString;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLDate);
    procedure SetCalculation(const Value: TFunctionReturningOLDate);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
  public
    constructor Create;
    procedure RefreshLabel;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLDate read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLDate read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLDateTimeToLabel = class
  private
    FLabel: TLabel;
    FOLPointer: POLDateTime;
    FCalculation: TFunctionReturningOLDateTime;
    FValueOnErrorInCalculation: OLString;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLDateTime);
    procedure SetCalculation(const Value: TFunctionReturningOLDateTime);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
  public
    procedure RefreshLabel;
    constructor Create;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLDateTime read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLDateTime read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLTypesToControlsLinks = record
  private
    EditsToOLIntegers: TObjectList<TEditToOLInteger>;
    SpinEditsToOLIntegers: TObjectList<TSpinEditToOLInteger>;
    TrackBarsToOLIntegers: TObjectList<TTrackBarToILInteger>;
    ScrollBarsToOLIntegers: TObjectList<TScrollBarToILInteger>;
    EditsToOLDoubles: TObjectList<TEditToOLDouble>;
    EditsToOLCurrencies: TObjectList<TEditToOLCurrency>;
    EditsToOLStrings: TObjectList<TEditToOLString>;
    MemosToOLStrings: TObjectList<TMemoToOLString>;
    DataTimerPickersToOLDates: TObjectList<TDateTimePickerToOLDate>;
    DataTimerPickersToOLDateTimes: TObjectList<TDateTimePickerToOLDateTime>;
    CheckBoxesToOLBooleans: TObjectList<TCheckBoxToOLBoolean>;
    OLIntegersToLabels: TObjectList<TOLIntegerToLabel>;
    OLStringToLabels: TObjectList<TOLStringToLabel>;
    OLDoublesToLabels: TObjectList<TOLDoubleToLabel>;
    OLCurrencyToLabels: TObjectList<TOLCurrencyToLabel>;
    OLDatesToLabels: TObjectList<TOLDateToLabel>;
    OLDateTimesToLabels: TObjectList<TOLDateTimeToLabel>;
  public
    class operator Initialize(out Dest: TOLTypesToControlsLinks);
    class operator Finalize(var Dest: TOLTypesToControlsLinks);
    procedure Link(const Edit: TEdit; var i: OLInteger; const Alignment: TAlignment=taRightJustify); overload;
    procedure Link(const Edit: TSpinEdit; var i: OLInteger); overload;
    procedure Link(const Edit: TTrackBar; var i: OLInteger); overload;
    procedure Link(const Edit: TScrollBar; var i: OLInteger); overload;
    procedure Link(const Edit: TEdit; var d: OLDouble; const Alignment: TAlignment=taRightJustify); overload;
    procedure Link(const Edit: TEdit; var curr: OLCurrency; const Alignment: TAlignment=taRightJustify); overload;
    procedure Link(const Edit: TEdit; var s: OLString); overload;
    procedure Link(const Edit: TMemo; var s: OLString); overload;
    procedure Link(const Edit: TDateTimePicker; var d: OLDate); overload;
    procedure Link(const Edit: TDateTimePicker; var d: OLDateTime); overload;
    procedure Link(const Edit: TCheckBox; var b: OLBoolean); overload;

    procedure Link(const Lbl: TLabel; var i: OLInteger); overload;
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const Lbl: TLabel; var s: OLString); overload;
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const Lbl: TLabel; var d: OLDouble); overload;
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLDouble; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const Lbl: TLabel; var curr: OLCurrency); overload;
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLCurrency; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const Lbl: TLabel; var d: OLDate); overload;
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const Lbl: TLabel; var d: OLDateTime); overload;
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;

    procedure RefreshControls(FormToRefresh: TForm = nil);
    procedure RemoveLinks(DestroyedForm: TForm = nil);
  end;


implementation

uses
  System.Variants, SmartToDate;

const
  NULL_FORMAT = '- - -';
  CALCULATION_ASSIGN_ERROR = 'Calculation cannot be set when OLPointer property is other then nil.';
  OLPOINTER_ASSIGN_ERROR = 'OLPointer cannot be set when Calculation property is other then nil.';
  DOUBLE_FORMAT = '###,###,###,##0.0####';
  CURRENCY_FORMAT = '###,###,###,##0.00##';

type
  THackDateTimePicker = class(TDateTimePicker);

constructor TEditToOLInteger.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FOLPointer := nil;
end;

procedure TEditToOLInteger.NewOnChange(Sender: TObject);
var
  i, j: integer;
begin
  if Edit.Text = EmptyStr then
    OLPointer^ := Null
  else
  begin
    if TryStrToInt(Edit.Text, i) then
      OLPointer^ := i
    else
    begin
      j := Edit.SelStart;
      Edit.Text := (OLPointer^).ToString();
      Edit.SelStart := j - 1;
    end;
  end;

  GetParentForm(Edit).Invalidate();

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TEditToOLInteger.RefreshEdit;
begin
  Edit.Text := (OLPointer^).ToString();
end;

procedure TEditToOLInteger.SetEdit(const Value: TEdit);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
  end;
end;

procedure TEditToOLInteger.SetOLPointer(const Value: POLInteger);
begin
  FOLPointer := Value;
end;

{ TEditToOLString }

constructor TEditToOLString.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FOLPointer := nil;
end;

procedure TEditToOLString.NewOnChange(Sender: TObject);
begin
  OLPointer^ := Edit.Text;

  GetParentForm(Edit).Invalidate();

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TEditToOLString.RefreshEdit;
begin
  Edit.Text := (OLPointer^).ToString();
end;

procedure TEditToOLString.SetEdit(const Value: TEdit);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
  end;
end;

procedure TEditToOLString.SetOLPointer(const Value: POLString);
begin
  FOLPointer := Value;
end;

{ TMemoToOLString }

constructor TMemoToOLString.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FOLPointer := nil;
end;

procedure TMemoToOLString.NewOnChange(Sender: TObject);
begin
  OLPointer^ := Edit.Text;

  GetParentForm(Edit).Invalidate();

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TMemoToOLString.RefreshEdit;
begin
  Edit.Text := (OLPointer^).ToString();
end;

procedure TMemoToOLString.SetEdit(const Value: TMemo);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
  end;
end;

procedure TMemoToOLString.SetOLPointer(const Value: POLString);
begin
  FOLPointer := Value;
end;

{ TEditToOLDouble }

constructor TEditToOLDouble.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FOLPointer := nil;
end;

procedure TEditToOLDouble.NewOnChange(Sender: TObject);
var
  d: Double;
  fs: TFormatSettings;
  s: string;
  j,l: Integer;
begin
  fs := TFormatSettings.Create();

  s := Edit.Text;
  s := OLType(s).Replaced(fs.ThousandSeparator, '');

  j := Edit.SelStart;
  l := Edit.SelLength;

  if TryStrToFloat(s, d) then
  begin
    OLPointer^ := d;
    l := 0;
  end
  else
  begin
    if s = '' then
      OLPointer^ := Null;


    if Edit.Focused() then
      Edit.Text := (OLPointer^).ToString(#0, fs.DecimalSeparator, DOUBLE_FORMAT)
    else
      Edit.Text := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, DOUBLE_FORMAT);

    j := j - 1;
  end;

  Edit.SelStart := j;

  GetParentForm(Edit).Invalidate();

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TEditToOLDouble.RefreshEdit;
var
  fs: TFormatSettings;
begin
  if not Edit.Focused() then
  begin
    fs := TFormatSettings.Create();
    Edit.Text := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, DOUBLE_FORMAT);
  end;
end;

procedure TEditToOLDouble.SetEdit(const Value: TEdit);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
  end;
end;

procedure TEditToOLDouble.SetOLPointer(const Value: POLDouble);
begin
  FOLPointer := Value;
end;

{ TEditToOLCurrency }

constructor TEditToOLCurrency.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FOLPointer := nil;
end;

procedure TEditToOLCurrency.NewOnChange(Sender: TObject);
var
  curr: Currency;
  s: OLString;
  fs: TFormatSettings;
  j,l: Integer;
  k: OLInteger;
begin
  fs := TFormatSettings.Create();

  s := Edit.Text;
  s := s.Replaced(fs.ThousandSeparator, '');

  j := Edit.SelStart;
  l := Edit.SelLength;

  if Edit.Focused() then
  begin
    k := s.PosLast(fs.DecimalSeparator);

    if (k.HasValue() = true) and (s.RightStrFrom(k + 1).Length > 4) then
    begin
      s := s.LeftStr(k + 4);
      Edit.Text := s;
    end;
  end;

  if TryStrToCurr(s, curr) then
  begin
    OLPointer^ := curr;
    l := 0;
  end
  else
  begin
    if s = '' then
      OLPointer^ := Null;


    if Edit.Focused() then
      Edit.Text := (OLPointer^).ToString(#0, fs.DecimalSeparator, CURRENCY_FORMAT)
    else
      Edit.Text := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, CURRENCY_FORMAT);

    j := j - 1;
  end;

  Edit.SelStart := j;

  GetParentForm(Edit).Invalidate();

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TEditToOLCurrency.RefreshEdit;
var
  fs: TFormatSettings;
begin
  if not Edit.Focused() then
  begin
    fs := TFormatSettings.Create();
    Edit.Text := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, '###,###,###,##0.00####');
  end;
end;

procedure TEditToOLCurrency.SetEdit(const Value: TEdit);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
  end;
end;

procedure TEditToOLCurrency.SetOLPointer(const Value: POLCurrency);
begin
  FOLPointer := Value;
end;

{ TSpinEditToOLInteger }

constructor TSpinEditToOLInteger.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FOLPointer := nil;
end;

procedure TSpinEditToOLInteger.NewOnChange(Sender: TObject);
var
  i, j: integer;
begin
  if Edit.Text = EmptyStr then
    OLPointer^ := Null
  else
  begin
    if TryStrToInt(Edit.Text, i) then
      OLPointer^ := i
    else
    begin
      j := Edit.SelStart;
      Edit.Text := (OLPointer^).ToString();
      Edit.SelStart := j - 1;
    end;
  end;

  GetParentForm(Edit).Invalidate();

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TSpinEditToOLInteger.RefreshEdit;
begin
  Edit.Text := (OLPointer^).ToString();
end;

procedure TSpinEditToOLInteger.SetEdit(const Value: TSpinEdit);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
  end;
end;

procedure TSpinEditToOLInteger.SetOLPointer(const Value: POLInteger);
begin
  FOLPointer := Value;
end;

{ TDateTimePickerToOLDate }

constructor TDateTimePickerToOLDate.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FEditOnEnter := nil;
  FEditOnKeyPress := nil;
  FOLPointer := nil;
  NotNullFormat := '';
  LastTwoKeys := '';
  LastThreeKeys := '';
end;

procedure TDateTimePickerToOLDate.NewOnChange(Sender: TObject);
begin
  OLPointer^ := Edit.DateTime;

  GetParentForm(Edit).Invalidate();

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TDateTimePickerToOLDate.NewOnEnter(Sender: TObject);
begin
  if (OLPointer^).IsNull then
  begin
    Edit.Format := NotNullFormat;
    Edit.Date := OLDate.Today();
    OLPointer^ := OLDate.Today();
  end;

  if Assigned(FEditOnEnter) then
    FEditOnEnter(Edit);
end;

procedure TDateTimePickerToOLDate.NewOnKeyPress(Sender: TObject; var Key: Char);
var
  d: TDate;
  d2: OLDate;
const
  Alpha = ['a'..'z', 'A'..'Z'];
begin
  if key in Alpha then
  begin
    LastTwoKeys := LastTwoKeys.RightStr(1) + Key;
    LastThreeKeys := LastThreeKeys.RightStr(2) + Key;

    if (LastThreeKeys.Length > 2) and TrySmartStrToDate(LastThreeKeys, d) then
    begin
      Edit.Date := d;
      OLPointer^ := d;
      LastThreeKeys := '';
      LastTwoKeys := '';
    end
    else if (LastTwoKeys.Length > 1) and  TrySmartStrToDate(LastTwoKeys, d) then
    begin
      Edit.Date := d;
      OLPointer^ := d;
      LastTwoKeys := '';
    end
    else if TrySmartStrToDate(key, d) then
    begin
      Edit.Date := d;
      OLPointer^ := d;
    end;


    key := #0;
  end;

  if Assigned(FEditOnKeyPress) then
    FEditOnKeyPress(Sender, Key);
end;

procedure TDateTimePickerToOLDate.RefreshEdit;
var
  d: OLDate;
begin
  if not Edit.Focused() then
  begin
    d := (OLPointer^);

    if d.HasValue then
    begin
      Edit.DateTime := d;
      Edit.Format := NotNullFormat;
    end
    else
    begin
      edit.Format := NULL_FORMAT;
    end;
  end;
end;

procedure TDateTimePickerToOLDate.SetEdit(const Value: TDateTimePicker);
begin
  FEdit := Value;

  if Assigned(Value) then
  begin
    NotNullFormat := Value.Format;

    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;

    FEditOnEnter := Value.OnEnter;
    Value.OnEnter := NewOnEnter;

    FEditOnKeyPress := Value.OnKeyPress;
    Value.OnKeyPress := NewOnKeyPress;
  end;
end;

procedure TDateTimePickerToOLDate.SetOLPointer(const Value: POLDate);
begin
  FOLPointer := Value;
end;

{ TDateTimePickerToOLDateTime }

constructor TDateTimePickerToOLDateTime.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FEditOnEnter := nil;
  FEditOnKeyPress := nil;
  FOLPointer := nil;
  NotNullFormat := '';
  LastTwoKeys := '';
  LastThreeKeys := '';
end;

procedure TDateTimePickerToOLDateTime.NewOnChange(Sender: TObject);
begin
  //OLPointer^ := Edit.Date + Edit.Time;

  //OLPointer^ := StrToDateTime(THackDateTimePicker(Edit).Caption);

  OLPointer^ := Edit.DateTime;

  GetParentForm(Edit).Invalidate();

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TDateTimePickerToOLDateTime.NewOnEnter(Sender: TObject);
begin
  if (OLPointer^).IsNull then
  begin
    Edit.Format := NotNullFormat;
    Edit.DateTime := OLDateTime.Now();
    OLPointer^ := OLDateTime.Now();
  end;

  if Assigned(FEditOnEnter) then
    FEditOnEnter(Edit);
end;

procedure TDateTimePickerToOLDateTime.NewOnKeyPress(Sender: TObject; var Key: Char);
var
  d: TDate;
const
  Alpha = ['a'..'z', 'A'..'Z'];
begin
  if key in Alpha then
  begin
    LastTwoKeys := LastTwoKeys.RightStr(1) + Key;
    LastThreeKeys := LastThreeKeys.RightStr(2) + Key;

    if (LastThreeKeys.Length > 2) and TrySmartStrToDate(LastThreeKeys, d) then
    begin
      Edit.Date := d;
      OLPointer^ := d;
      LastThreeKeys := '';
      LastTwoKeys := '';
    end
    else if (LastTwoKeys.Length > 1) and  TrySmartStrToDate(LastTwoKeys, d) then
    begin
      Edit.Date := d;
      OLPointer^ := d;
      LastTwoKeys := '';
    end
    else if TrySmartStrToDate(key, d) then
    begin
      Edit.Date := d;
      OLPointer^ := d;
    end;


    key := #0;
  end;

  if Assigned(FEditOnKeyPress) then
    FEditOnKeyPress(Sender, Key);
end;

procedure TDateTimePickerToOLDateTime.RefreshEdit;
var
  d: OLDateTime;
begin
  if not Edit.Focused() then
  begin
    d := (OLPointer^);

    if d.HasValue then
    begin
      Edit.DateTime := d;
      Edit.Format := NotNullFormat;
    end
    else
    begin
      edit.Format := NULL_FORMAT;
    end;
  end;
end;

procedure TDateTimePickerToOLDateTime.SetEdit(const Value: TDateTimePicker);
begin
  FEdit := Value;

  if Assigned(Value) then
  begin
    NotNullFormat := Value.Format;

    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;

    FEditOnEnter := Value.OnEnter;
    Value.OnEnter := NewOnEnter;

    FEditOnKeyPress := Value.OnKeyPress;
    Value.OnKeyPress := NewOnKeyPress;
  end;
end;

procedure TDateTimePickerToOLDateTime.SetOLPointer(const Value: POLDateTime);
begin
  FOLPointer := Value;
end;

{ TCheckBoxToOLBoolean }

constructor TCheckBoxToOLBoolean.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnClick := nil;
  FOLPointer := nil;
end;

procedure TCheckBoxToOLBoolean.NewOnClick(Sender: TObject);
begin
  OLPointer^ := Edit.Checked;

  GetParentForm(Edit).Invalidate();

  if Assigned(FEditOnClick) then
    FEditOnClick(Edit);
end;

procedure TCheckBoxToOLBoolean.RefreshEdit;
begin
  Edit.Checked := (OLPointer^).IfNull(False);
end;

procedure TCheckBoxToOLBoolean.SetEdit(const Value: TCheckBox);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnClick := Value.OnClick;
    Value.OnClick := NewOnClick;
  end;
end;

procedure TCheckBoxToOLBoolean.SetOLPointer(const Value: POLBoolean);
begin
  FOLPointer := Value;
end;

{ TOLIntegerToLabel }

constructor TOLIntegerToLabel.Create;
begin
  inherited;
  FLabel := nil;
  FOLPointer := nil;
  FCalculation := nil;
  FValueOnErrorInCalculation := '';
end;

procedure TOLIntegerToLabel.RefreshLabel;
begin
  if OLPointer <> nil then
    Lbl.Caption := (OLPointer^).ToString();

  if Assigned(Calculation) then
  try
    Lbl.Caption := Calculation().ToString();
  except
    Lbl.Caption := ValueOnErrorInCalculation.IfNullOrEmpty(ERROR_STRING);
  end;
end;

procedure TOLIntegerToLabel.SetCalculation(const Value: TFunctionReturningOLInteger);
begin
  if Assigned(Value) and (FOLPointer <> nil) then
    raise Exception.Create(CALCULATION_ASSIGN_ERROR);

  FCalculation := Value;
end;

procedure TOLIntegerToLabel.SetLabel(const Value: TLabel);
begin
  FLabel := Value;
end;

procedure TOLIntegerToLabel.SetOLPointer(const Value: POLInteger);
begin
  if (Value <> nil) and Assigned(Calculation) then
    raise Exception.Create(OLPOINTER_ASSIGN_ERROR);

  FOLPointer := Value;
end;

procedure TOLIntegerToLabel.SetValueOnErrorInCalculation(const Value: OLString);
begin
  FValueOnErrorInCalculation := Value;
end;

{ TOLStringToLabel }

constructor TOLStringToLabel.Create;
begin
  inherited;
  FLabel := nil;
  FOLPointer := nil;
  FCalculation := nil;
  FValueOnErrorInCalculation := '';
end;

procedure TOLStringToLabel.RefreshLabel;
begin
  if OLPointer <> nil then
    Lbl.Caption := (OLPointer^).ToString();

  if Assigned(Calculation) then
  try
    Lbl.Caption := Calculation().ToString();
  except
    Lbl.Caption := ValueOnErrorInCalculation.IfNullOrEmpty(ERROR_STRING);
  end;
end;

procedure TOLStringToLabel.SetCalculation(const Value: TFunctionReturningOLString);
begin
  if Assigned(Value) and (FOLPointer <> nil) then
    raise Exception.Create(CALCULATION_ASSIGN_ERROR);

  FCalculation := Value;
end;

procedure TOLStringToLabel.SetLabel(const Value: TLabel);
begin
  FLabel := Value;
end;

procedure TOLStringToLabel.SetOLPointer(const Value: POLString);
begin
  if (Value <> nil) and Assigned(Calculation) then
    raise Exception.Create(OLPOINTER_ASSIGN_ERROR);

  FOLPointer := Value;
end;

procedure TOLStringToLabel.SetValueOnErrorInCalculation(const Value: OLString);
begin
  FValueOnErrorInCalculation := Value;
end;

{ TOLDoubleToLabel }

constructor TOLDoubleToLabel.Create;
begin
  inherited;
  FLabel := nil;
  FOLPointer := nil;
  FCalculation := nil;
  FValueOnErrorInCalculation := '';
end;

procedure TOLDoubleToLabel.RefreshLabel;
var
  fs: TFormatSettings;
begin
  fs := TFormatSettings.Create();

  if OLPointer <> nil then
    Lbl.Caption := (OLPointer^).ToString(#0, fs.DecimalSeparator, DOUBLE_FORMAT);

  if Assigned(Calculation) then
  try
    Lbl.Caption := Calculation().ToString(#0, fs.DecimalSeparator, DOUBLE_FORMAT);
  except
    Lbl.Caption := ValueOnErrorInCalculation.IfNullOrEmpty(ERROR_STRING);
  end;
end;

procedure TOLDoubleToLabel.SetCalculation(const Value: TFunctionReturningOLDouble);
begin
  if Assigned(Value) and (FOLPointer <> nil) then
    raise Exception.Create(CALCULATION_ASSIGN_ERROR);

  FCalculation := Value;
end;

procedure TOLDoubleToLabel.SetLabel(const Value: TLabel);
begin
  FLabel := Value;
end;

procedure TOLDoubleToLabel.SetOLPointer(const Value: POLDouble);
begin
  if (Value <> nil) and Assigned(Calculation) then
    raise Exception.Create(OLPOINTER_ASSIGN_ERROR);

  FOLPointer := Value;
end;

procedure TOLDoubleToLabel.SetValueOnErrorInCalculation(const Value: OLString);
begin
  FValueOnErrorInCalculation := Value;
end;

{ TOLCurrencyToLabel }

constructor TOLCurrencyToLabel.Create;
begin
  inherited;
  FLabel := nil;
  FOLPointer := nil;
  FCalculation := nil;
  FValueOnErrorInCalculation := '';
end;

procedure TOLCurrencyToLabel.RefreshLabel;
var
  fs: TFormatSettings;
begin
  fs := TFormatSettings.Create();

  if OLPointer <> nil then
    Lbl.Caption := (OLPointer^).ToString(#0, fs.DecimalSeparator, CURRENCY_FORMAT);

  if Assigned(Calculation) then
  try
    Lbl.Caption := Calculation().ToString(#0, fs.DecimalSeparator, CURRENCY_FORMAT);
  except
    Lbl.Caption := ValueOnErrorInCalculation.IfNullOrEmpty(ERROR_STRING);
  end;
end;

procedure TOLCurrencyToLabel.SetCalculation(const Value: TFunctionReturningOLCurrency);
begin
  if Assigned(Value) and (FOLPointer <> nil) then
    raise Exception.Create(CALCULATION_ASSIGN_ERROR);

  FCalculation := Value;
end;

procedure TOLCurrencyToLabel.SetLabel(const Value: TLabel);
begin
  FLabel := Value;
end;

procedure TOLCurrencyToLabel.SetOLPointer(const Value: POLCurrency);
begin
  if (Value <> nil) and Assigned(Calculation) then
    raise Exception.Create(OLPOINTER_ASSIGN_ERROR);

  FOLPointer := Value;
end;

procedure TOLCurrencyToLabel.SetValueOnErrorInCalculation(const Value: OLString);
begin
  FValueOnErrorInCalculation := Value;
end;

{ TOLDateToLabel }

constructor TOLDateToLabel.Create;
begin
  inherited;
  FLabel := nil;
  FOLPointer := nil;
  FCalculation := nil;
  FValueOnErrorInCalculation := '';
end;

procedure TOLDateToLabel.RefreshLabel;
begin
  if OLPointer <> nil then
    Lbl.Caption := (OLPointer^).ToString();

  if Assigned(Calculation) then
  try
    Lbl.Caption := Calculation().ToString();
  except
    Lbl.Caption := ValueOnErrorInCalculation.IfNullOrEmpty(ERROR_STRING);
  end;
end;

procedure TOLDateToLabel.SetCalculation(const Value: TFunctionReturningOLDate);
begin
  if Assigned(Value) and (FOLPointer <> nil) then
    raise Exception.Create(CALCULATION_ASSIGN_ERROR);

  FCalculation := Value;
end;

procedure TOLDateToLabel.SetLabel(const Value: TLabel);
begin
  FLabel := Value;
end;

procedure TOLDateToLabel.SetOLPointer(const Value: POLDate);
begin
  if (Value <> nil) and Assigned(Calculation) then
    raise Exception.Create(OLPOINTER_ASSIGN_ERROR);

  FOLPointer := Value;
end;

procedure TOLDateToLabel.SetValueOnErrorInCalculation(const Value: OLString);
begin
  FValueOnErrorInCalculation := Value;
end;

{ TOLDateTimeToLabel }

constructor TOLDateTimeToLabel.Create;
begin
  inherited;
  FLabel := nil;
  FOLPointer := nil;
  FCalculation := nil;
  FValueOnErrorInCalculation := '';
end;

procedure TOLDateTimeToLabel.RefreshLabel;
begin
  if OLPointer <> nil then
    Lbl.Caption := (OLPointer^).ToString();

  if Assigned(Calculation) then
  try
    Lbl.Caption := Calculation().ToString();
  except
    Lbl.Caption := ValueOnErrorInCalculation.IfNullOrEmpty(ERROR_STRING);
  end;
end;

procedure TOLDateTimeToLabel.SetCalculation(const Value: TFunctionReturningOLDateTime);
begin
  if Assigned(Value) and (FOLPointer <> nil) then
    raise Exception.Create(CALCULATION_ASSIGN_ERROR);

  FCalculation := Value;
end;

procedure TOLDateTimeToLabel.SetLabel(const Value: TLabel);
begin
  FLabel := Value;
end;

procedure TOLDateTimeToLabel.SetOLPointer(const Value: POLDateTime);
begin
  if (Value <> nil) and Assigned(Calculation) then
    raise Exception.Create(OLPOINTER_ASSIGN_ERROR);

  FOLPointer := Value;
end;

procedure TOLDateTimeToLabel.SetValueOnErrorInCalculation(const Value: OLString);
begin
  FValueOnErrorInCalculation := Value;
end;

{ TScrollBarToILInteger }

constructor TScrollBarToILInteger.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FOLPointer := nil;
end;

procedure TScrollBarToILInteger.NewOnChange(Sender: TObject);
begin
  OLPointer^ := Edit.Position;

  GetParentForm(Edit).Invalidate();

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TScrollBarToILInteger.RefreshEdit;
begin
  Edit.Position := (OLPointer^).IfNull(0)
end;

procedure TScrollBarToILInteger.SetEdit(const Value: TScrollBar);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
  end;
end;

procedure TScrollBarToILInteger.SetOLPointer(const Value: POLInteger);
begin
  FOLPointer := Value;
end;

{ TTrackBarToILInteger }

constructor TTrackBarToILInteger.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FOLPointer := nil;
end;

procedure TTrackBarToILInteger.NewOnChange(Sender: TObject);
begin
  OLPointer^ := Edit.Position;

  GetParentForm(Edit).Invalidate();

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TTrackBarToILInteger.RefreshEdit;
begin
  Edit.Position := (OLPointer^).IfNull(0)
end;

procedure TTrackBarToILInteger.SetEdit(const Value: TTrackBar);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
  end;
end;

procedure TTrackBarToILInteger.SetOLPointer(const Value: POLInteger);
begin
  FOLPointer := Value;
end;

{ TOLTypesToControlsLinks }

class operator TOLTypesToControlsLinks.Initialize(out Dest: TOLTypesToControlsLinks);
begin
  Dest.EditsToOLIntegers := TObjectList<TEditToOLInteger>.Create(True);
  Dest.SpinEditsToOLIntegers := TObjectList<TSpinEditToOLInteger>.Create(True);
  Dest.TrackBarsToOLIntegers := TObjectList<TTrackBarToILInteger>.Create(True);
  Dest.ScrollBarsToOLIntegers := TObjectList<TScrollBarToILInteger>.Create(True);
  Dest.EditsToOLDoubles := TObjectList<TEditToOLDouble>.Create(True);
  Dest.EditsToOLCurrencies := TObjectList<TEditToOLCurrency>.Create(True);
  Dest.EditsToOLStrings := TObjectList<TEditToOLString>.Create(True);
  Dest.MemosToOLStrings := TObjectList<TMemoToOLString>.Create(True);
  Dest.DataTimerPickersToOLDates := TObjectList<TDateTimePickerToOLDate>.Create(True);
  Dest.DataTimerPickersToOLDateTimes := TObjectList<TDateTimePickerToOLDateTime>.Create(True);
  Dest.CheckBoxesToOLBooleans := TObjectList<TCheckBoxToOLBoolean>.Create(True);
  Dest.OLIntegersToLabels := TObjectList<TOLIntegerToLabel>.Create(True);
  Dest.OLStringToLabels := TObjectList<TOLStringToLabel>.Create(True);
  Dest.OLDoublesToLabels := TObjectList<TOLDoubleToLabel>.Create(True);
  Dest.OLCurrencyToLabels := TObjectList<TOLCurrencyToLabel>.Create(True);
  Dest.OLDatesToLabels := TObjectList<TOLDateToLabel>.Create(True);
  Dest.OLDateTimesToLabels := TObjectList<TOLDateTimeToLabel>.Create(True);
end;

class operator TOLTypesToControlsLinks.Finalize(var Dest: TOLTypesToControlsLinks);
begin
  Dest.EditsToOLIntegers.Free;
  Dest.SpinEditsToOLIntegers.Free;
  Dest.TrackBarsToOLIntegers.Free;
  Dest.ScrollBarsToOLIntegers.Free;
  Dest.EditsToOLDoubles.Free;
  Dest.EditsToOLCurrencies.Free;
  Dest.EditsToOLStrings.Free;
  Dest.MemosToOLStrings.Free;
  Dest.DataTimerPickersToOLDates.Free;
  Dest.DataTimerPickersToOLDateTimes.Free;
  Dest.CheckBoxesToOLBooleans.Free;
  Dest.OLIntegersToLabels.Free;
  Dest.OLStringToLabels.Free;
  Dest.OLDoublesToLabels.Free;
  Dest.OLCurrencyToLabels.Free;
  Dest.OLDatesToLabels.Free;
  Dest.OLDateTimesToLabels.Free;
end;


procedure TOLTypesToControlsLinks.Link(const Edit: TSpinEdit; var i: OLInteger);
var
  Link: TSpinEditToOLInteger;
begin
  Link := TSpinEditToOLInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  SpinEditsToOLIntegers.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var i: OLInteger;
    const Alignment: TAlignment=taRightJustify);
var
  Link: TEditToOLInteger;
begin
  Link := TEditToOLInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  EditsToOLIntegers.Add(Link);
  
  Edit.Alignment := Alignment;
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TTrackBar; var i: OLInteger);
var
  Link: TTrackBarToILInteger;
begin
  Link := TTrackBarToILInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  TrackBarsToOLIntegers.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TScrollBar; var i: OLInteger);
var
  Link: TScrollBarToILInteger;
begin
  Link := TScrollBarToILInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  ScrollBarsToOLIntegers.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var d: OLDouble; const Alignment: TAlignment=taRightJustify);
var
  Link: TEditToOLDouble;
begin
  Link := TEditToOLDouble.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @d;
  EditsToOLDoubles.Add(Link);
  
  Edit.Alignment := Alignment;
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var curr: OLCurrency;
    const Alignment: TAlignment=taRightJustify);
var
  Link: TEditToOLCurrency;
begin
  Link := TEditToOLCurrency.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @curr;
  EditsToOLCurrencies.Add(Link);
  
  Edit.Alignment := Alignment;
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var s: OLString);
var
  Link: TEditToOLString;
begin
  Link := TEditToOLString.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @s;
  EditsToOLStrings.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TMemo; var s: OLString);
var
  Link: TMemoToOLString;
begin
  Link := TMemoToOLString.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @s;
  MemosToOLStrings.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TDateTimePicker; var d: OLDate);
var
  Link: TDateTimePickerToOLDate;
  fs: TFormatSettings;
begin
  if Edit.Format = '' then
  begin
    fs := TFormatSettings.Create();
    Edit.Format := OLType(fs.ShortDateFormat).Replaced('/', fs.DateSeparator);
  end;
  
  Link := TDateTimePickerToOLDate.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @d;
  DataTimerPickersToOLDates.Add(Link);
end;


procedure TOLTypesToControlsLinks.Link(const Edit: TDateTimePicker; var d:
    OLDateTime);
var
  Link: TDateTimePickerToOLDateTime;
  fs: TFormatSettings;
begin
  if Edit.Format  = '' then
  begin
    fs := TFormatSettings.Create();
    
    if Edit.Kind = dtkTime then
      Edit.Format := OLType(fs.LongTimeFormat).Replaced(':', fs.TimeSeparator)
    else
      Edit.Format := OLType(fs.ShortDateFormat).Replaced('/', fs.DateSeparator) + ' ' +
                     OLType(fs.LongTimeFormat).Replaced(':', fs.TimeSeparator);
  end;
  
  Link := TDateTimePickerToOLDateTime.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @d;
  DataTimerPickersToOLDateTimes.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TCheckBox; var b: OLBoolean);
var
  Link: TCheckBoxToOLBoolean;
begin
  Link := TCheckBoxToOLBoolean.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @b;
  CheckBoxesToOLBooleans.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var i: OLInteger);
var
  Link: TOLIntegerToLabel;
begin
  Link := TOLIntegerToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @i;
  OLIntegersToLabels.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f:
    TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string =
    ERROR_STRING);
var
  Link: TOLIntegerToLabel;
begin
  Link := TOLIntegerToLabel.Create;
  Link.Lbl := Lbl;
  Link.Calculation := f;
  Link.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  OLIntegersToLabels.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f:
    TFunctionReturningOLString; const ValueOnErrorInCalculation: string =
    ERROR_STRING);
var
  Link: TOLStringToLabel;
begin
  Link := TOLStringToLabel.Create;
  Link.Lbl := Lbl;
  Link.Calculation := f;
  Link.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  OLStringToLabels.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var s: OLString);
var
  Link: TOLStringToLabel;
begin
  Link := TOLStringToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @s;
  OLStringToLabels.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f: TFunctionReturningOLDouble; const ValueOnErrorInCalculation: string);
var
  Link: TOLDoubleToLabel;
begin
  Link := TOLDoubleToLabel.Create;
  Link.Lbl := Lbl;
  Link.Calculation := f;
  Link.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  OLDoublesToLabels.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var d: OLDouble);
var
  Link: TOLDoubleToLabel;
begin
  Link := TOLDoubleToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @d;
  OLDoublesToLabels.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f: TFunctionReturningOLCurrency; const ValueOnErrorInCalculation: string);
var
  Link: TOLCurrencyToLabel;
begin
  Link := TOLCurrencyToLabel.Create;
  Link.Lbl := Lbl;
  Link.Calculation := f;
  Link.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  OLCurrencyToLabels.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var curr: OLCurrency);
var
  Link: TOLCurrencyToLabel;
begin
  Link := TOLCurrencyToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @curr;
  OLCurrencyToLabels.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
var
  Link: TOLDateToLabel;
begin
  Link := TOLDateToLabel.Create;
  Link.Lbl := Lbl;
  Link.Calculation := f;
  Link.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  OLDatesToLabels.Add(Link);
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var d: OLDate);
var
  Link: TOLDateToLabel;
begin
  Link := TOLDateToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @d;
  OLDatesToLabels.Add(Link);
end;



procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
var
  Link: TOLDateTimeToLabel;
begin
  Link := TOLDateTimeToLabel.Create;
  Link.Lbl := Lbl;
  Link.Calculation := f;
  Link.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  OLDateTimesToLabels.Add(Link);
end;

procedure TOLTypesToControlsLinks.RefreshControls(FormToRefresh: TForm = nil);
var
  EditToOLInteger: TEditToOLInteger;
  SpinEditToOLInteger: TSpinEditToOLInteger;
  TrackBarToILInteger: TTrackBarToILInteger;
  ScrollBarToILInteger: TScrollBarToILInteger;
  EditToOLDouble: TEditToOLDouble;
  EditToOLCurrency: TEditToOLCurrency;
  EditToOLString: TEditToOLString;
  MemoToOLString: TMemoToOLString;
  DateTimePickerToOLDate: TDateTimePickerToOLDate;
  DateTimePickerToOLDateTime: TDateTimePickerToOLDateTime;
  CheckBoxToOLBoolean: TCheckBoxToOLBoolean;
  OLIntegerToLabel: TOLIntegerToLabel;
  OLStringToLabel: TOLStringToLabel;
  OLDoubleToLabel: TOLDoubleToLabel;
  OLCurrencyToLabel: TOLCurrencyToLabel;
  OLDateToLabel: TOLDateToLabel;
  OLDateTimeToLabel: TOLDateTimeToLabel;
begin
  for EditToOLInteger in EditsToOLIntegers do
    if (not Assigned(FormToRefresh)) or (GetParentForm(EditToOLInteger.Edit) = FormToRefresh) then
      EditToOLInteger.RefreshEdit();

  for SpinEditToOLInteger in SpinEditsToOLIntegers do
    if (not Assigned(FormToRefresh)) or (GetParentForm(SpinEditToOLInteger.Edit) = FormToRefresh) then
      SpinEditToOLInteger.RefreshEdit();

  for TrackBarToILInteger in TrackBarsToOLIntegers do
    if (not Assigned(FormToRefresh)) or (GetParentForm(TrackBarToILInteger.Edit) = FormToRefresh) then
      TrackBarToILInteger.RefreshEdit();

  for ScrollBarToILInteger in ScrollBarsToOLIntegers do
    if (not Assigned(FormToRefresh)) or (GetParentForm(ScrollBarToILInteger.Edit) = FormToRefresh) then
      ScrollBarToILInteger.RefreshEdit();

  for EditToOLDouble in EditsToOLDoubles do
    if (not Assigned(FormToRefresh)) or (GetParentForm(EditToOLDouble.Edit) = FormToRefresh) then
      EditToOLDouble.RefreshEdit();

  for EditToOLCurrency in EditsToOLCurrencies do
    if (not Assigned(FormToRefresh)) or (GetParentForm(EditToOLCurrency.Edit) = FormToRefresh) then
      EditToOLCurrency.RefreshEdit();

  for EditToOLString in EditsToOLStrings do
    if (not Assigned(FormToRefresh)) or (Assigned(EditToOLString.Edit) and Assigned(EditToOLString.Edit.Parent) and (GetParentForm(EditToOLString.Edit) = FormToRefresh)) then
      EditToOLString.RefreshEdit();

  for MemoToOLString in MemosToOLStrings do
    if (not Assigned(FormToRefresh)) or (GetParentForm(MemoToOLString.Edit) = FormToRefresh) then
      MemoToOLString.RefreshEdit();

  for DateTimePickerToOLDate in DataTimerPickersToOLDates do
    if (not Assigned(FormToRefresh)) or (GetParentForm(DateTimePickerToOLDate.Edit) = FormToRefresh) then
      DateTimePickerToOLDate.RefreshEdit();

  for DateTimePickerToOLDateTime in DataTimerPickersToOLDateTimes do
    if (not Assigned(FormToRefresh)) or (GetParentForm(DateTimePickerToOLDateTime.Edit) = FormToRefresh) then
      DateTimePickerToOLDateTime.RefreshEdit();

  for CheckBoxToOLBoolean in CheckBoxesToOLBooleans do
    if (not Assigned(FormToRefresh)) or (GetParentForm(CheckBoxToOLBoolean.Edit) = FormToRefresh) then
      CheckBoxToOLBoolean.RefreshEdit();

  for OLIntegerToLabel in OLIntegersToLabels do
    if (not Assigned(FormToRefresh)) or (Assigned(OLIntegerToLabel.Lbl) and Assigned(OLIntegerToLabel.Lbl.Parent) and (GetParentForm(OLIntegerToLabel.Lbl) = FormToRefresh)) then
      OLIntegerToLabel.RefreshLabel();

  for OLStringToLabel in OLStringToLabels do
    if (not Assigned(FormToRefresh)) or (Assigned(OLStringToLabel.Lbl) and Assigned(OLStringToLabel.Lbl.Parent) and (GetParentForm(OLStringToLabel.Lbl) = FormToRefresh)) then
      OLStringToLabel.RefreshLabel();

  for OLDoubleToLabel in OLDoublesToLabels do
    if (not Assigned(FormToRefresh)) or (GetParentForm(OLDoubleToLabel.Lbl) = FormToRefresh) then
      OLDoubleToLabel.RefreshLabel();

  for OLCurrencyToLabel in OLCurrencyToLabels do
    if (not Assigned(FormToRefresh)) or (GetParentForm(OLCurrencyToLabel.Lbl) = FormToRefresh) then
      OLCurrencyToLabel.RefreshLabel();

  for OLDateToLabel in OLDatesToLabels do
    if (not Assigned(FormToRefresh)) or (GetParentForm(OLDateToLabel.Lbl) = FormToRefresh) then
      OLDateToLabel.RefreshLabel();

  for OLDateTimeToLabel in OLDateTimesToLabels do
    if (not Assigned(FormToRefresh)) or (GetParentForm(OLDateTimeToLabel.Lbl) = FormToRefresh) then
      OLDateTimeToLabel.RefreshLabel();

end;

procedure TOLTypesToControlsLinks.RemoveLinks(DestroyedForm: TForm);
var
  i: Integer;
begin
  // Remove links for destroyed form - iterate backwards for safe deletion
  for i := EditsToOLIntegers.Count - 1 downto 0 do
    if GetParentForm(EditsToOLIntegers[i].Edit) = DestroyedForm then
      EditsToOLIntegers.Delete(i);

  for i := SpinEditsToOLIntegers.Count - 1 downto 0 do
    if GetParentForm(SpinEditsToOLIntegers[i].Edit) = DestroyedForm then
      SpinEditsToOLIntegers.Delete(i);

  for i := TrackBarsToOLIntegers.Count - 1 downto 0 do
    if GetParentForm(TrackBarsToOLIntegers[i].Edit) = DestroyedForm then
      TrackBarsToOLIntegers.Delete(i);

  for i := ScrollBarsToOLIntegers.Count - 1 downto 0 do
    if GetParentForm(ScrollBarsToOLIntegers[i].Edit) = DestroyedForm then
      ScrollBarsToOLIntegers.Delete(i);

  for i := EditsToOLDoubles.Count - 1 downto 0 do
    if GetParentForm(EditsToOLDoubles[i].Edit) = DestroyedForm then
      EditsToOLDoubles.Delete(i);

  for i := EditsToOLCurrencies.Count - 1 downto 0 do
    if GetParentForm(EditsToOLCurrencies[i].Edit) = DestroyedForm then
      EditsToOLCurrencies.Delete(i);

  for i := EditsToOLStrings.Count - 1 downto 0 do
    if GetParentForm(EditsToOLStrings[i].Edit) = DestroyedForm then
      EditsToOLStrings.Delete(i);

  for i := MemosToOLStrings.Count - 1 downto 0 do
    if GetParentForm(MemosToOLStrings[i].Edit) = DestroyedForm then
      MemosToOLStrings.Delete(i);

  for i := DataTimerPickersToOLDates.Count - 1 downto 0 do
    if GetParentForm(DataTimerPickersToOLDates[i].Edit) = DestroyedForm then
      DataTimerPickersToOLDates.Delete(i);

  for i := DataTimerPickersToOLDateTimes.Count - 1 downto 0 do
    if GetParentForm(DataTimerPickersToOLDateTimes[i].Edit) = DestroyedForm then
      DataTimerPickersToOLDateTimes.Delete(i);

  for i := CheckBoxesToOLBooleans.Count - 1 downto 0 do
    if GetParentForm(CheckBoxesToOLBooleans[i].Edit) = DestroyedForm then
      CheckBoxesToOLBooleans.Delete(i);

  for i := OLIntegersToLabels.Count - 1 downto 0 do
    if (OLIntegersToLabels[i].Lbl <> nil) and (GetParentForm(OLIntegersToLabels[i].Lbl) = DestroyedForm) then
      OLIntegersToLabels.Delete(i);

  for i := OLStringToLabels.Count - 1 downto 0 do
    if (OLStringToLabels[i].Lbl <> nil) and (GetParentForm(OLStringToLabels[i].Lbl) = DestroyedForm) then
      OLStringToLabels.Delete(i);

  for i := OLDoublesToLabels.Count - 1 downto 0 do
    if (OLDoublesToLabels[i].Lbl <> nil) and (GetParentForm(OLDoublesToLabels[i].Lbl) = DestroyedForm) then
      OLDoublesToLabels.Delete(i);

  for i := OLCurrencyToLabels.Count - 1 downto 0 do
    if (OLCurrencyToLabels[i].Lbl <> nil) and (GetParentForm(OLCurrencyToLabels[i].Lbl) = DestroyedForm) then
      OLCurrencyToLabels.Delete(i);

  for i := OLDatesToLabels.Count - 1 downto 0 do
    if (OLDatesToLabels[i].Lbl <> nil) and (GetParentForm(OLDatesToLabels[i].Lbl) = DestroyedForm) then
      OLDatesToLabels.Delete(i);

  for i := OLDateTimesToLabels.Count - 1 downto 0 do
    if (OLDateTimesToLabels[i].Lbl <> nil) and (GetParentForm(OLDateTimesToLabels[i].Lbl) = DestroyedForm) then
      OLDateTimesToLabels.Delete(i);
end;



procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var d: OLDateTime);
var
  Link: TOLDateTimeToLabel;
begin
  Link := TOLDateTimeToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @d;
  OLDateTimesToLabels.Add(Link);
end;

{$IFEND}

end.
