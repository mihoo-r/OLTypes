unit OLTypesToEdits;

interface

uses OLTypes,
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

  TEditToOLInteger = record
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLInteger);
  public
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TSpinEditToOLInteger = record
  private
    FEdit: TSpinEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    procedure SetEdit(const Value: TSpinEdit);
    procedure SetOLPointer(const Value: POLInteger);
  public
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TSpinEdit read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TScrollBarToILInteger = record
  private
    FEdit: TScrollBar;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    procedure SetEdit(const Value: TScrollBar);
    procedure SetOLPointer(const Value: POLInteger);
  public
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TScrollBar read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TTrackBarToILInteger = record
  private
    FEdit: TTrackBar;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    procedure SetEdit(const Value: TTrackBar);
    procedure SetOLPointer(const Value: POLInteger);
  public
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TTrackBar read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TEditToOLDouble = record
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLDouble;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLDouble);
  public
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLDouble read FOLPointer write SetOLPointer;
  end;

  TEditToOLCurrency = record
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLCurrency;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLCurrency);
  public
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLCurrency read FOLPointer write SetOLPointer;
  end;

  TEditToOLString = record
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLString;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLString);
  public
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLString read FOLPointer write SetOLPointer;
  end;

  TMemoToOLString = record
  private
    FEdit: TMemo;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLString;
    procedure SetEdit(const Value: TMemo);
    procedure SetOLPointer(const Value: POLString);
  public
    procedure NewOnChange(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TMemo read FEdit write SetEdit;
    property OLPointer: POLString read FOLPointer write SetOLPointer;
  end;

  TDateTimePickerToOLDate = record
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
    procedure NewOnChange(Sender: TObject);
    procedure NewOnEnter(Sender: TObject);
    procedure NewOnKeyPress(Sender: TObject; var Key: Char);
    procedure RefreshEdit();
    property Edit: TDateTimePicker read FEdit write SetEdit;
    property OLPointer: POLDate read FOLPointer write SetOLPointer;
  end;

  TDateTimePickerToOLDateTime = record
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
    procedure NewOnChange(Sender: TObject);
    procedure NewOnEnter(Sender: TObject);
    procedure NewOnKeyPress(Sender: TObject; var Key: Char);
    procedure RefreshEdit();
    property Edit: TDateTimePicker read FEdit write SetEdit;
    property OLPointer: POLDateTime read FOLPointer write SetOLPointer;
  end;

  TCheckBoxToOLBoolean = record
  private
    FEdit: TCheckBox;
    FEditOnClick: TEditOnClick;
    FOLPointer: POLBoolean;
    procedure SetEdit(const Value: TCheckBox);
    procedure SetOLPointer(const Value: POLBoolean);
  public
    procedure NewOnClick(Sender: TObject);
    procedure RefreshEdit();
    property Edit: TCheckBox read FEdit write SetEdit;
    property OLPointer: POLBoolean read FOLPointer write SetOLPointer;
  end;

  TOLIntegerToLabel = record
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
    procedure RefreshLabel;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLInteger read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLStringToLabel = record
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
    procedure RefreshLabel;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLString read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLString read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLDoubleToLabel = record
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
    procedure RefreshLabel;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLDouble read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLDouble read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLCurrencyToLabel = record
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
    procedure RefreshLabel;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLCurrency read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLCurrency read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLDateToLabel = record
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
    procedure RefreshLabel;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLDate read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLDate read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLDateTimeToLabel = record
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
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLDateTime read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLDateTime read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLTypesToControlsLinks = record
  private
    EditsToOLIntegers: array of TEditToOLInteger;
    SpinEditsToOLIntegers: array of TSpinEditToOLInteger;
    TrackBarsToOLIntegers: array of TTrackBarToILInteger;
    ScrollBarsToOLIntegers: array of TScrollBarToILInteger;
    EditsToOLDoubles: array of TEditToOLDouble;
    EditsToOLCurrencies: array of TEditToOLCurrency;
    EditsToOLStrings: array of TEditToOLString;
    MemosToOLStrings: array of TMemoToOLString;
    DataTimerPickersToOLDates: array of TDateTimePickerToOLDate;
    DataTimerPickersToOLDateTimes: array of TDateTimePickerToOLDateTime;
    CheckBoxesToOLBooleans: array of TCheckBoxToOLBoolean;
    OLIntegersToLabels: array of TOLIntegerToLabel;
    OLStringToLabels: array of TOLStringToLabel;
    OLDoublesToLabels: array of TOLDoubleToLabel;
    OLCurrencyToLabels: array of TOLCurrencyToLabel;
    OLDatesToLabels: array of TOLDateToLabel;
    OLDateTimesToLabels: array of TOLDateTimeToLabel;
  public
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

procedure TEditToOLCurrency.NewOnChange(Sender: TObject);
var
  curr: Currency;
  s: OLString;
  fs: TFormatSettings;
  j,l,k: Integer;
begin
  fs := TFormatSettings.Create();

  s := Edit.Text;
  s := s.Replaced(fs.ThousandSeparator, '');

  j := Edit.SelStart;
  l := Edit.SelLength;

  if Edit.Focused() then
  begin
    k := s.PosLast(fs.DecimalSeparator);

    if (k > 0) and (s.RightStrFrom(k + 1).Length > 4) then
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

procedure TDateTimePickerToOLDateTime.NewOnChange(Sender: TObject);
begin
  //OLPointer^ := Edit.Date + Edit.Time;

  OLPointer^ := StrToDateTime(THackDateTimePicker(Edit).Caption);

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

procedure TOLTypesToControlsLinks.Link(const Edit: TSpinEdit; var i: OLInteger);
var
  idx: Integer;
  j: Integer;
begin
  idx := Length(SpinEditsToOLIntegers);

  SetLength(SpinEditsToOLIntegers, idx + 1);

  SpinEditsToOLIntegers[idx].Edit := Edit;
  SpinEditsToOLIntegers[idx].FOLPointer := @i;

  for j := 0 to Length(SpinEditsToOLIntegers) - 2 do
  begin
    SpinEditsToOLIntegers[j].Edit.OnChange := SpinEditsToOLIntegers[j].NewOnChange;
  end;
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var i: OLInteger;
    const Alignment: TAlignment=taRightJustify);
var
  idx: Integer;
  j: Integer;
begin
  idx := Length(EditsToOLIntegers);

  SetLength(EditsToOLIntegers, idx + 1);

  EditsToOLIntegers[idx].Edit := Edit;
  EditsToOLIntegers[idx].FOLPointer := @i;

  for j := 0 to Length(EditsToOLIntegers) - 2 do
  begin
    EditsToOLIntegers[j].Edit.OnChange := EditsToOLIntegers[j].NewOnChange;
  end;

  Edit.Alignment := Alignment;
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TTrackBar; var i: OLInteger);
var
  idx: Integer;
  j: Integer;
begin
  idx := Length(TrackBarsToOLIntegers);

  SetLength(TrackBarsToOLIntegers, idx + 1);

  TrackBarsToOLIntegers[idx].Edit := Edit;
  TrackBarsToOLIntegers[idx].FOLPointer := @i;

  for j := 0 to Length(TrackBarsToOLIntegers) - 2 do
  begin
    TrackBarsToOLIntegers[j].Edit.OnChange := TrackBarsToOLIntegers[j].NewOnChange;
  end;
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TScrollBar; var i: OLInteger);
var
  idx: Integer;
  j: Integer;
begin
  idx := Length(ScrollBarsToOLIntegers);

  SetLength(ScrollBarsToOLIntegers, idx + 1);

  ScrollBarsToOLIntegers[idx].Edit := Edit;
  ScrollBarsToOLIntegers[idx].FOLPointer := @i;

  for j := 0 to Length(ScrollBarsToOLIntegers) - 2 do
  begin
    ScrollBarsToOLIntegers[j].Edit.OnChange := ScrollBarsToOLIntegers[j].NewOnChange;
  end;
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var d: OLDouble; const Alignment: TAlignment=taRightJustify);
var
  idx: Integer;
  i: Integer;
begin
  idx := Length(EditsToOLDoubles);

  SetLength(EditsToOLDoubles, idx + 1);

  EditsToOLDoubles[idx].Edit := Edit;
  EditsToOLDoubles[idx].FOLPointer := @d;

  for i := 0 to Length(EditsToOLDoubles) - 2 do
  begin
    EditsToOLDoubles[i].Edit.OnChange := EditsToOLDoubles[i].NewOnChange;
  end;

  Edit.Alignment := Alignment;
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var curr: OLCurrency;
    const Alignment: TAlignment=taRightJustify);
var
  idx: Integer;
  i: Integer;
begin
  idx := Length(EditsToOLCurrencies);

  SetLength(EditsToOLCurrencies, idx + 1);

  EditsToOLCurrencies[idx].Edit := Edit;
  EditsToOLCurrencies[idx].FOLPointer := @curr;

  for i := 0 to Length(EditsToOLCurrencies) - 2 do
  begin
    EditsToOLCurrencies[i].Edit.OnChange := EditsToOLCurrencies[i].NewOnChange;
  end;

  Edit.Alignment := Alignment;
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var s: OLString);
var
  idx: Integer;
  i: Integer;
begin
  idx := Length(EditsToOLStrings);

  SetLength(EditsToOLStrings, idx + 1);

  EditsToOLStrings[idx].Edit := Edit;
  EditsToOLStrings[idx].FOLPointer := @s;

  for i := 0 to Length(EditsToOLStrings) - 2 do
  begin
    EditsToOLStrings[i].Edit.OnChange := EditsToOLStrings[i].NewOnChange;
  end;
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TMemo; var s: OLString);
var
  idx: Integer;
  i: Integer;
begin
  idx := Length(MemosToOLStrings);

  SetLength(MemosToOLStrings, idx + 1);

  MemosToOLStrings[idx].Edit := Edit;
  MemosToOLStrings[idx].FOLPointer := @s;

  for i := 0 to Length(MemosToOLStrings) - 2 do
  begin
    MemosToOLStrings[i].Edit.OnChange := MemosToOLStrings[i].NewOnChange;
  end;
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TDateTimePicker; var d: OLDate);
var
  idx: Integer;
  i: Integer;
  fs: TFormatSettings;
begin
  if Edit.Format = '' then
  begin
    fs := TFormatSettings.Create();
    Edit.Format := OLType(fs.ShortDateFormat).Replaced('/', fs.DateSeparator);
  end;

  idx := Length(DataTimerPickersToOLDates);

  SetLength(DataTimerPickersToOLDates, idx + 1);

  DataTimerPickersToOLDates[idx].Edit := Edit;
  DataTimerPickersToOLDates[idx].FOLPointer := @d;

  for i := 0 to Length(DataTimerPickersToOLDates) - 2 do
  begin
    DataTimerPickersToOLDates[i].Edit.OnChange := DataTimerPickersToOLDates[i].NewOnChange;
    DataTimerPickersToOLDates[i].Edit.OnKeyPress := DataTimerPickersToOLDates[i].NewOnKeyPress;
    DataTimerPickersToOLDates[i].Edit.OnEnter := DataTimerPickersToOLDates[i].NewOnEnter;
  end;
end;


procedure TOLTypesToControlsLinks.Link(const Edit: TDateTimePicker; var d:
    OLDateTime);
var
  idx: Integer;
  i: Integer;
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

  idx := Length(DataTimerPickersToOLDateTimes);

  SetLength(DataTimerPickersToOLDateTimes, idx + 1);

  DataTimerPickersToOLDateTimes[idx].Edit := Edit;
  DataTimerPickersToOLDateTimes[idx].FOLPointer := @d;

  for i := 0 to Length(DataTimerPickersToOLDateTimes) - 2 do
  begin
    DataTimerPickersToOLDateTimes[i].Edit.OnChange := DataTimerPickersToOLDateTimes[i].NewOnChange;
    DataTimerPickersToOLDateTimes[i].Edit.OnKeyPress := DataTimerPickersToOLDateTimes[i].NewOnKeyPress;
    DataTimerPickersToOLDateTimes[i].Edit.OnEnter := DataTimerPickersToOLDateTimes[i].NewOnEnter;
  end;
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TCheckBox; var b: OLBoolean);
var
  idx: Integer;
  i: integer;
begin
  idx := Length(CheckBoxesToOLBooleans);

  SetLength(CheckBoxesToOLBooleans, idx + 1);

  CheckBoxesToOLBooleans[idx].Edit := Edit;
  CheckBoxesToOLBooleans[idx].FOLPointer := @b;

  for i := 0 to Length(CheckBoxesToOLBooleans) - 2 do
  begin
    CheckBoxesToOLBooleans[i].Edit.OnClick := CheckBoxesToOLBooleans[i].NewOnClick;
  end;
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var i: OLInteger);
var
  idx: Integer;
begin
  idx := Length(OLIntegersToLabels);

  SetLength(OLIntegersToLabels, idx + 1);

  OLIntegersToLabels[idx].Lbl := Lbl;
  OLIntegersToLabels[idx].FOLPointer := @i;
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f:
    TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string =
    ERROR_STRING);
var
  idx: Integer;
  i: Integer;
begin
  idx := Length(OLIntegersToLabels);

  SetLength(OLIntegersToLabels, idx + 1);

  OLIntegersToLabels[idx].Lbl := Lbl;
  OLIntegersToLabels[idx].Calculation := f;
  OLIntegersToLabels[idx].ValueOnErrorInCalculation := ValueOnErrorInCalculation;
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f:
    TFunctionReturningOLString; const ValueOnErrorInCalculation: string =
    ERROR_STRING);
var
  idx: Integer;
begin
  idx := Length(OLStringToLabels);

  SetLength(OLStringToLabels, idx + 1);

  OLStringToLabels[idx].Lbl := Lbl;
  OLStringToLabels[idx].Calculation := f;
  OLStringToLabels[idx].ValueOnErrorInCalculation := ValueOnErrorInCalculation;
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var s: OLString);
var
  idx: Integer;
  i: Integer;
begin
  idx := Length(OLStringToLabels);

  SetLength(OLStringToLabels, idx + 1);

  OLStringToLabels[idx].Lbl := Lbl;
  OLStringToLabels[idx].FOLPointer := @s;
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f: TFunctionReturningOLDouble; const ValueOnErrorInCalculation: string);
var
  idx: Integer;
  i: Integer;
begin
  idx := Length(OLDoublesToLabels);

  SetLength(OLDoublesToLabels, idx + 1);

  OLDoublesToLabels[idx].Lbl := Lbl;
  OLDoublesToLabels[idx].Calculation := f;
  OLDoublesToLabels[idx].ValueOnErrorInCalculation := ValueOnErrorInCalculation;
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var d: OLDouble);
var
  idx: Integer;
  i: Integer;
begin
  idx := Length(OLDoublesToLabels);

  SetLength(OLDoublesToLabels, idx + 1);

  OLDoublesToLabels[idx].Lbl := Lbl;
  OLDoublesToLabels[idx].FOLPointer := @d;
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f: TFunctionReturningOLCurrency; const ValueOnErrorInCalculation: string);
var
  idx: Integer;
  i: Integer;
begin
  idx := Length(OLCurrencyToLabels);

  SetLength(OLCurrencyToLabels, idx + 1);

  OLCurrencyToLabels[idx].Lbl := Lbl;
  OLCurrencyToLabels[idx].Calculation := f;
  OLCurrencyToLabels[idx].ValueOnErrorInCalculation := ValueOnErrorInCalculation;
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var curr: OLCurrency);
var
  idx: Integer;
  i: Integer;
begin
  idx := Length(OLCurrencyToLabels);

  SetLength(OLCurrencyToLabels, idx + 1);

  OLCurrencyToLabels[idx].Lbl := Lbl;
  OLCurrencyToLabels[idx].FOLPointer := @curr;
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
var
  idx: Integer;
  i: Integer;
begin
  idx := Length(OLDatesToLabels);

  SetLength(OLDatesToLabels, idx + 1);

  OLDatesToLabels[idx].Lbl := Lbl;
  OLDatesToLabels[idx].Calculation := f;
  OLDatesToLabels[idx].ValueOnErrorInCalculation := ValueOnErrorInCalculation;
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var d: OLDate);
var
  idx: Integer;
  i: Integer;
begin
  idx := Length(OLDatesToLabels);

  SetLength(OLDatesToLabels, idx + 1);

  OLDatesToLabels[idx].Lbl := Lbl;
  OLDatesToLabels[idx].FOLPointer := @d;
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
var
  idx: Integer;
  i: Integer;
begin
  idx := Length(OLDateTimesToLabels);

  SetLength(OLDateTimesToLabels, idx + 1);

  OLDateTimesToLabels[idx].Lbl := Lbl;
  OLDateTimesToLabels[idx].Calculation := f;
  OLDateTimesToLabels[idx].ValueOnErrorInCalculation := ValueOnErrorInCalculation;
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

  i: Integer;
  j: Integer;
  RemovedCount: Integer;
begin
  if length(EditsToOLIntegers) > 0 then
  begin
    i := 0;

    while i < length(EditsToOLIntegers) do
    begin
      if (GetParentForm(EditsToOLIntegers[i].Edit) = DestroyedForm) then
      begin
        if i < length(EditsToOLIntegers) - 1 then
        for j := i to length(EditsToOLIntegers) - 2 do
        begin
          EditsToOLIntegers[j] := EditsToOLIntegers[j + 1];
        end;

        SetLength(EditsToOLIntegers, length(EditsToOLIntegers) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;

  if length(SpinEditsToOLIntegers) > 0 then
  begin
    i := 0;

    while i < length(SpinEditsToOLIntegers) do
    begin
      if (GetParentForm(SpinEditsToOLIntegers[i].Edit) = DestroyedForm) then
      begin
        if i < length(SpinEditsToOLIntegers) - 1 then
        for j := i to length(SpinEditsToOLIntegers) - 2 do
        begin
          SpinEditsToOLIntegers[j] := SpinEditsToOLIntegers[j + 1];
        end;

        SetLength(SpinEditsToOLIntegers, length(SpinEditsToOLIntegers) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;

  if length(TrackBarsToOLIntegers) > 0 then
  begin
    i := 0;

    while i < length(TrackBarsToOLIntegers) do
    begin
      if (GetParentForm(TrackBarsToOLIntegers[i].Edit) = DestroyedForm) then
      begin
        if i < length(TrackBarsToOLIntegers) - 1 then
        for j := i to length(TrackBarsToOLIntegers) - 2 do
        begin
          TrackBarsToOLIntegers[j] := TrackBarsToOLIntegers[j + 1];
        end;

        SetLength(TrackBarsToOLIntegers, length(TrackBarsToOLIntegers) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;

  if length(ScrollBarsToOLIntegers) > 0 then
  begin
    i := 0;

    while i < length(ScrollBarsToOLIntegers) do
    begin
      if (GetParentForm(ScrollBarsToOLIntegers[i].Edit) = DestroyedForm) then
      begin
        if i < length(ScrollBarsToOLIntegers) - 1 then
        for j := i to length(ScrollBarsToOLIntegers) - 2 do
        begin
          ScrollBarsToOLIntegers[j] := ScrollBarsToOLIntegers[j + 1];
        end;

        SetLength(ScrollBarsToOLIntegers, length(ScrollBarsToOLIntegers) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;

  if length(EditsToOLDoubles) > 0 then
  begin
    i := 0;

    while i < length(EditsToOLDoubles) do
    begin
      if (GetParentForm(EditsToOLDoubles[i].Edit) = DestroyedForm) then
      begin
        if i < length(EditsToOLDoubles) - 1 then
        for j := i to length(EditsToOLDoubles) - 2 do
        begin
          EditsToOLDoubles[j] := EditsToOLDoubles[j + 1];
        end;

        SetLength(EditsToOLDoubles, length(EditsToOLDoubles) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;


  if length(EditsToOLCurrencies) > 0 then
  begin
    i := 0;

    while i < length(EditsToOLCurrencies) do
    begin
      if (GetParentForm(EditsToOLCurrencies[i].Edit) = DestroyedForm) then
      begin
        if i < length(EditsToOLCurrencies) - 1 then
        for j := i to length(EditsToOLCurrencies) - 2 do
        begin
          EditsToOLCurrencies[j] := EditsToOLCurrencies[j + 1];
        end;

        SetLength(EditsToOLCurrencies, length(EditsToOLCurrencies) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;


  if length(EditsToOLStrings) > 0 then
  begin
    i := 0;

    while i < length(EditsToOLStrings) do
    begin
      if (GetParentForm(EditsToOLStrings[i].Edit) = DestroyedForm) then
      begin
        if i < length(EditsToOLStrings) - 1 then
        for j := i to length(EditsToOLStrings) - 2 do
        begin
          EditsToOLStrings[j] := EditsToOLStrings[j + 1];
        end;

        SetLength(EditsToOLStrings, length(EditsToOLStrings) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;


  if length(MemosToOLStrings) > 0 then
  begin
    i := 0;

    while i < length(MemosToOLStrings) do
    begin
      if (GetParentForm(MemosToOLStrings[i].Edit) = DestroyedForm) then
      begin
        if i < length(MemosToOLStrings) - 1 then
        for j := i to length(MemosToOLStrings) - 2 do
        begin
          MemosToOLStrings[j] := MemosToOLStrings[j + 1];
        end;

        SetLength(MemosToOLStrings, length(MemosToOLStrings) - 1);
      end
      else
      begin
        inc(i);
      end;

    end;
  end;


  if length(DataTimerPickersToOLDates) > 0 then
  begin
    i := 0;

    while i < length(DataTimerPickersToOLDates) do
    begin
      if (GetParentForm(DataTimerPickersToOLDates[i].Edit) = DestroyedForm) then
      begin
        if i < length(DataTimerPickersToOLDates) - 1 then
        for j := i to length(DataTimerPickersToOLDates) - 2 do
        begin
          DataTimerPickersToOLDates[j] := DataTimerPickersToOLDates[j + 1];
        end;

        SetLength(DataTimerPickersToOLDates, length(DataTimerPickersToOLDates) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;


  if length(DataTimerPickersToOLDateTimes) > 0 then
  begin
    i := 0;

    while i < length(DataTimerPickersToOLDateTimes) do
    begin
      if (GetParentForm(DataTimerPickersToOLDateTimes[i].Edit) = DestroyedForm) then
      begin
        if i < length(DataTimerPickersToOLDateTimes) - 1 then
        for j := i to length(DataTimerPickersToOLDateTimes) - 2 do
        begin
          DataTimerPickersToOLDateTimes[j] := DataTimerPickersToOLDateTimes[j + 1];
        end;

        SetLength(DataTimerPickersToOLDateTimes, length(DataTimerPickersToOLDateTimes) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;


  if length(CheckBoxesToOLBooleans) > 0 then
  begin
    i := 0;

    while i < length(CheckBoxesToOLBooleans) do
    begin
      if (GetParentForm(CheckBoxesToOLBooleans[i].Edit) = DestroyedForm) then
      begin
        if i < length(CheckBoxesToOLBooleans) - 1 then
        for j := i to length(CheckBoxesToOLBooleans) - 2 do
        begin
          CheckBoxesToOLBooleans[j] := CheckBoxesToOLBooleans[j + 1];
        end;

        SetLength(CheckBoxesToOLBooleans, length(CheckBoxesToOLBooleans) - 1);
      end
      else
      begin
        inc(i);
      end;

    end;
  end;


  if length(OLIntegersToLabels) > 0 then
  begin
    i := 0;

    while i < length(OLIntegersToLabels) do
    begin
      if (GetParentForm(OLIntegersToLabels[i].Lbl) = DestroyedForm) then
      begin
        if i < length(OLIntegersToLabels) - 1 then
        for j := i to length(OLIntegersToLabels) - 2 do
        begin
          OLIntegersToLabels[j] := OLIntegersToLabels[j + 1];
        end;

        SetLength(OLIntegersToLabels, length(OLIntegersToLabels) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;

  if length(OLStringToLabels) > 0 then
  begin
    i := 0;

    while i < length(OLStringToLabels) do
    begin
      if (GetParentForm(OLStringToLabels[i].Lbl) = DestroyedForm) then
      begin
        if i < length(OLStringToLabels) - 1 then
        for j := i to length(OLStringToLabels) - 2 do
        begin
          OLStringToLabels[j] := OLStringToLabels[j + 1];
        end;

        SetLength(OLStringToLabels, length(OLStringToLabels) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;

  if length(OLDoublesToLabels) > 0 then
  begin
    i := 0;

    while i < length(OLDoublesToLabels) do
    begin
      if (GetParentForm(OLDoublesToLabels[i].Lbl) = DestroyedForm) then
      begin
        if i < length(OLDoublesToLabels) - 1 then
        for j := i to length(OLDoublesToLabels) - 2 do
        begin
          OLDoublesToLabels[j] := OLDoublesToLabels[j + 1];
        end;

        SetLength(OLDoublesToLabels, length(OLDoublesToLabels) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;


  if length(OLCurrencyToLabels) > 0 then
  begin
    i := 0;

    while i < length(OLCurrencyToLabels) do
    begin
      if (GetParentForm(OLCurrencyToLabels[i].Lbl) = DestroyedForm) then
      begin
        if i < length(OLCurrencyToLabels) - 1 then
        for j := i to length(OLCurrencyToLabels) - 2 do
        begin
          OLCurrencyToLabels[j] := OLCurrencyToLabels[j + 1];
        end;

        SetLength(OLCurrencyToLabels, length(OLCurrencyToLabels) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;


  if length(OLDatesToLabels) > 0 then
  begin
    i := 0;

    while i < length(OLDatesToLabels) do
    begin
      if (GetParentForm(OLDatesToLabels[i].Lbl) = DestroyedForm) then
      begin
        if i < length(OLDatesToLabels) - 1 then
        for j := i to length(OLDatesToLabels) - 2 do
        begin
          OLDatesToLabels[j] := OLDatesToLabels[j + 1];
        end;

        SetLength(OLDatesToLabels, length(OLDatesToLabels) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;


  if length(OLDateTimesToLabels) > 0 then
  begin
    i := 0;

    while i < length(OLDateTimesToLabels) do
    begin
      if (GetParentForm(OLDateTimesToLabels[i].Lbl) = DestroyedForm) then
      begin
        if i < length(OLDateTimesToLabels) - 1 then
        for j := i to length(OLDateTimesToLabels) - 2 do
        begin
          OLDateTimesToLabels[j] := OLDateTimesToLabels[j + 1];
        end;

        SetLength(OLDateTimesToLabels, length(OLDateTimesToLabels) - 1);
      end
      else
      begin
        inc(i);
      end;
    end;
  end;

end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var d: OLDateTime);
var
  idx: Integer;
  i: Integer;
begin
  idx := Length(OLDateTimesToLabels);

  SetLength(OLDateTimesToLabels, idx + 1);

  OLDateTimesToLabels[idx].Lbl := Lbl;
  OLDateTimesToLabels[idx].FOLPointer := @d;
end;

end.
