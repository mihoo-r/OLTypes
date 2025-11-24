unit OLTypesToEdits;

{$IF CompilerVersion >= 34.0}

interface

uses OLTypes, System.Generics.Collections,
  {$IF CompilerVersion >= 23.0}
  Vcl.StdCtrls, System.SysUtils, Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.Forms, System.Classes, Vcl.Controls, Messages, Winapi.Windows, Vcl.ExtCtrls;
  {$ELSE}
  StdCtrls, SysUtils, Spin, ComCtrls, Forms, Classes, Controls, Messages, Windows, ExtCtrls;
  {$IFEND}

const
  ERROR_STRING = '#ERROR';
  DOUBLE_FORMAT = '###,###,###,##0.0####';
  CURRENCY_FORMAT = '###,###,###,##0.00##';

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

  TOLLinkBase = class(TComponent)
  public
    constructor Create; reintroduce;
    procedure RefreshControl; virtual; abstract;
  end;

  TEditToOLInteger = class(TOLLinkBase)
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLInteger);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshControl; override;
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TSpinEditToOLInteger = class(TOLLinkBase)
  private
    FEdit: TSpinEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    procedure SetEdit(const Value: TSpinEdit);
    procedure SetOLPointer(const Value: POLInteger);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshControl; override;
    property Edit: TSpinEdit read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TScrollBarToILInteger = class(TOLLinkBase)
  private
    FEdit: TScrollBar;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    procedure SetEdit(const Value: TScrollBar);
    procedure SetOLPointer(const Value: POLInteger);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshControl; override;
    property Edit: TScrollBar read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TTrackBarToILInteger = class(TOLLinkBase)
  private
    FEdit: TTrackBar;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    procedure SetEdit(const Value: TTrackBar);
    procedure SetOLPointer(const Value: POLInteger);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshControl; override;
    property Edit: TTrackBar read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TEditToOLDouble = class(TOLLinkBase)
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLDouble;
    FFormat: string;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLDouble);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshControl; override;
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLDouble read FOLPointer write SetOLPointer;
  end;

  TEditToOLCurrency = class(TOLLinkBase)
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLCurrency;
    FFormat: string;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLCurrency);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshControl; override;
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLCurrency read FOLPointer write SetOLPointer;
  end;

  TEditToOLString = class(TOLLinkBase)
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLString;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLString);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshControl; override;
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLString read FOLPointer write SetOLPointer;
  end;

  TMemoToOLString = class(TOLLinkBase)
  private
    FEdit: TMemo;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLString;
    procedure SetEdit(const Value: TMemo);
    procedure SetOLPointer(const Value: POLString);
  public
    constructor Create;
    procedure NewOnChange(Sender: TObject);
    procedure RefreshControl; override;
    property Edit: TMemo read FEdit write SetEdit;
    property OLPointer: POLString read FOLPointer write SetOLPointer;
  end;

  TDateTimePickerToOLDate = class(TOLLinkBase)
  private
    FEdit: TDateTimePicker;
    FEditOnChange: TEditOnChange;
    FEditOnEnter: TEditOnEnter;
    FEditOnKeyPress: TEditOnKeyPress;
    FOLPointer: POLDate;
    NotNullFormat: string;
    LastTwoKeys, LastThreeKeys: OLString;
    FOriginalWindowProc: TWndMethod;
    FUpdatingFromRefresh: Boolean;
    FUpdatingFromControl: Boolean;

    procedure NewWindowProc(var Message: TMessage);
    procedure SetEdit(const Value: TDateTimePicker);
    procedure SetOLPointer(const Value: POLDate);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure NewOnEnter(Sender: TObject);
    procedure NewOnKeyPress(Sender: TObject; var Key: Char);
    procedure RefreshControl; override;
    property Edit: TDateTimePicker read FEdit write SetEdit;
    property OLPointer: POLDate read FOLPointer write SetOLPointer;
  end;

  TDateTimePickerToOLDateTime = class(TOLLinkBase)
  private
    FEdit: TDateTimePicker;
    FEditOnChange: TEditOnChange;
    FEditOnEnter: TEditOnEnter;
    FEditOnKeyPress: TEditOnKeyPress;
    FOLPointer: POLDateTime;
    NotNullFormat: string;
    LastTwoKeys, LastThreeKeys: OLString;
    FOriginalWindowProc: TWndMethod;
    FUpdatingFromRefresh: Boolean;
    FUpdatingFromControl: Boolean;

    procedure NewWindowProc(var Message: TMessage);
    procedure SetEdit(const Value: TDateTimePicker);
    procedure SetOLPointer(const Value: POLDateTime);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure NewOnEnter(Sender: TObject);
    procedure NewOnKeyPress(Sender: TObject; var Key: Char);
    procedure RefreshControl; override;
    property Edit: TDateTimePicker read FEdit write SetEdit;
    property OLPointer: POLDateTime read FOLPointer write SetOLPointer;
  end;

  TCheckBoxToOLBoolean = class(TOLLinkBase)
  private
    FEdit: TCheckBox;
    FEditOnClick: TEditOnClick;
    FOLPointer: POLBoolean;
    procedure SetEdit(const Value: TCheckBox);
    procedure SetOLPointer(const Value: POLBoolean);
  public
    constructor Create;
    procedure NewOnClick(Sender: TObject);
    procedure RefreshControl; override;
    property Edit: TCheckBox read FEdit write SetEdit;
    property OLPointer: POLBoolean read FOLPointer write SetOLPointer;
  end;

  TOLIntegerToLabel = class(TOLLinkBase)
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
    procedure RefreshControl; override;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLInteger read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLStringToLabel = class(TOLLinkBase)
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
    procedure RefreshControl; override;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLString read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLString read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLDoubleToLabel = class(TOLLinkBase)
  private
    FLabel: TLabel;
    FOLPointer: POLDouble;
    FCalculation: TFunctionReturningOLDouble;
    FValueOnErrorInCalculation: OLString;
    FFormat: string;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLDouble);
    procedure SetCalculation(const Value: TFunctionReturningOLDouble);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
  public
    constructor Create;
    procedure RefreshControl; override;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLDouble read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLDouble read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLCurrencyToLabel = class(TOLLinkBase)
  private
    FLabel: TLabel;
    FOLPointer: POLCurrency;
    FCalculation: TFunctionReturningOLCurrency;
    FValueOnErrorInCalculation: OLString;
    FFormat: string;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLCurrency);
    procedure SetCalculation(const Value: TFunctionReturningOLCurrency);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
  public
    constructor Create;
    procedure RefreshControl; override;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLCurrency read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLCurrency read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLDateToLabel = class(TOLLinkBase)
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
    procedure RefreshControl; override;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLDate read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLDate read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLDateTimeToLabel = class(TOLLinkBase)
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
    procedure RefreshControl; override;
    constructor Create;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLDateTime read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLDateTime read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLTypesToControlsLinks = record
  private
    FLinks: TDictionary<TForm, TObjectList<TOLLinkBase>>;
    FTimers: TDictionary<TForm, TTimer>;
    FWatchers: TDictionary<TForm, TComponent>;
    procedure AddLink(Control: TControl; Link: TOLLinkBase);
  public
    class operator Initialize(out Dest: TOLTypesToControlsLinks);
    class operator Finalize(var Dest: TOLTypesToControlsLinks);
    procedure Link(const Edit: TEdit; var i: OLInteger; const Alignment: TAlignment=taRightJustify); overload;
    procedure Link(const Edit: TSpinEdit; var i: OLInteger); overload;
    procedure Link(const Edit: TTrackBar; var i: OLInteger); overload;
    procedure Link(const Edit: TScrollBar; var i: OLInteger); overload;
    procedure Link(const Edit: TEdit; var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify); overload;
    procedure Link(const Edit: TEdit; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify); overload;
    procedure Link(const Edit: TEdit; var s: OLString); overload;
    procedure Link(const Edit: TMemo; var s: OLString); overload;
    procedure Link(const Edit: TDateTimePicker; var d: OLDate); overload;
    procedure Link(const Edit: TDateTimePicker; var d: OLDateTime); overload;
    procedure Link(const Edit: TCheckBox; var b: OLBoolean); overload;

    procedure Link(const Lbl: TLabel; var i: OLInteger); overload;
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const Lbl: TLabel; var s: OLString); overload;
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const Lbl: TLabel; var d: OLDouble; const Format: string = DOUBLE_FORMAT); overload;
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLDouble; const Format: string = DOUBLE_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const Lbl: TLabel; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT); overload;
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLCurrency; const Format: string = CURRENCY_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const Lbl: TLabel; var d: OLDate); overload;
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const Lbl: TLabel; var d: OLDateTime); overload;
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;

    procedure RefreshControls(FormToRefresh: TForm = nil);
    procedure RemoveLinks(DestroyedForm: TForm = nil);
  end;

var
  Links: TOLTypesToControlsLinks;


implementation

uses
  System.Variants, SmartToDate;

const
  NULL_FORMAT = '- - -';
  CALCULATION_ASSIGN_ERROR = 'Calculation cannot be set when OLPointer property is other then nil.';
  OLPOINTER_ASSIGN_ERROR = 'OLPointer cannot be set when Calculation property is other then nil.';

type
  THackDateTimePicker = class(TDateTimePicker);

  TRefreshTimer = class(TTimer)
  private
    FForm: TForm;
    procedure TimerEvent(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent; AForm: TForm); reintroduce;
    destructor Destroy; override;
  end;

  TOLFormWatcher = class(TComponent)
  public
    destructor Destroy; override;
  end;

constructor TRefreshTimer.Create(AOwner: TComponent; AForm: TForm);
begin
  inherited Create(AOwner);
  FForm := AForm;
  if Assigned(FForm) then
    FForm.FreeNotification(Self);
  Interval := 100;
  OnTimer := TimerEvent;
end;

destructor TRefreshTimer.Destroy;
begin
  if Assigned(FForm) then
    FForm.RemoveFreeNotification(Self);
  inherited;
end;

procedure TRefreshTimer.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FForm) then
  begin
    FForm := nil;
    Enabled := False;
    if Assigned(Links.FTimers) then
       Links.FTimers.Remove(AComponent as TForm);
    
    // Ensure we free ourselves since we are owned by nil
    Self.Free;
  end;
end;

procedure TRefreshTimer.TimerEvent(Sender: TObject);
begin
  if Assigned(FForm) then
    Links.RefreshControls(FForm);
end;

destructor TOLFormWatcher.Destroy;
begin
  if Owner is TForm then
    Links.RemoveLinks(Owner as TForm);
  inherited;
end;

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

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TEditToOLInteger.RefreshControl;
begin
  if Edit.Text <> (OLPointer^).ToString() then
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

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TEditToOLString.RefreshControl;
begin
  if Edit.Text <> (OLPointer^).ToString() then
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

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TMemoToOLString.RefreshControl;
begin
  if Edit.Text <> (OLPointer^).ToString() then
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
  FFormat := DOUBLE_FORMAT;
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

  if s = '' then
  begin
    OLPointer^ := Null;

    if Edit.Focused() then
      Edit.Text := (OLPointer^).ToString(#0, fs.DecimalSeparator, FFormat)
    else
      Edit.Text := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, FFormat);

    j := j - 1;
  end
  else if TryStrToFloat(s, d) then
  begin
    OLPointer^ := d;
    l := 0;
  end
  else
  begin
    if Edit.Focused() then
      Edit.Text := (OLPointer^).ToString(#0, fs.DecimalSeparator, FFormat)
    else
      Edit.Text := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, FFormat);

    j := j - 1;
  end;

  Edit.SelStart := j;

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TEditToOLDouble.RefreshControl;
var
  fs: TFormatSettings;
  s: string;
begin
  if not Edit.Focused() then
  begin
    fs := TFormatSettings.Create();
    s := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, FFormat);
    if Edit.Text <> s then
      Edit.Text := s;
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
  FFormat := CURRENCY_FORMAT;
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

  if s = '' then
  begin
    OLPointer^ := Null;

    if Edit.Focused() then
      Edit.Text := (OLPointer^).ToString(#0, fs.DecimalSeparator, CURRENCY_FORMAT)
    else
      Edit.Text := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, CURRENCY_FORMAT);

    j := j - 1;
  end
  else if TryStrToCurr(s, curr) then
  begin
    OLPointer^ := curr;
    l := 0;
  end
  else
  begin
    if Edit.Focused() then
      Edit.Text := (OLPointer^).ToString(#0, fs.DecimalSeparator, CURRENCY_FORMAT)
    else
      Edit.Text := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, CURRENCY_FORMAT);

    j := j - 1;
  end;

  Edit.SelStart := j;

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TEditToOLCurrency.RefreshControl;
var
  fs: TFormatSettings;
  s: string;
begin
  if not Edit.Focused() then
  begin
    fs := TFormatSettings.Create();
    s := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, '###,###,###,##0.00####');
    if Edit.Text <> s then
      Edit.Text := s;
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

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TSpinEditToOLInteger.RefreshControl;
begin
  if Edit.Text <> (OLPointer^).ToString() then
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

{ TOLLinkBase }

constructor TOLLinkBase.Create;
begin
  inherited Create(nil);
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
  FUpdatingFromRefresh := False;
  FUpdatingFromControl := False;
end;

destructor TDateTimePickerToOLDate.Destroy;
begin
  if Assigned(FEdit) then
  begin
    if Assigned(FOriginalWindowProc) then
      FEdit.WindowProc := FOriginalWindowProc;
    if Assigned(FEditOnChange) then
      FEdit.OnChange := FEditOnChange;
    if Assigned(FEditOnEnter) then
      FEdit.OnEnter := FEditOnEnter;
    if Assigned(FEditOnKeyPress) then
      FEdit.OnKeyPress := FEditOnKeyPress;
  end;
  inherited;
end;

procedure TDateTimePickerToOLDate.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FEdit) then
    FEdit := nil;
end;

procedure TDateTimePickerToOLDate.NewOnChange(Sender: TObject);
begin
  FUpdatingFromControl := True;
  try
    OLPointer^ := Edit.DateTime;

    if Assigned(FEditOnChange) then
      FEditOnChange(Edit);
  finally
    FUpdatingFromControl := False;
  end;
end;

procedure TDateTimePickerToOLDate.NewWindowProc(var Message: TMessage);
const
  DTM_SETSYSTEMTIME = $1002;
  GDT_VALID = 0;
  CM_PARENTCHANGED = $B001;
var
  SysTime: PSystemTime;
  NewDate: TDateTime;
  IsSetSystemTime: Boolean;
begin
  IsSetSystemTime := (Message.Msg = DTM_SETSYSTEMTIME) and (not FUpdatingFromRefresh);

  if IsSetSystemTime then
  begin
    FUpdatingFromControl := True;
    try
      if Message.WParam = GDT_VALID then
      begin
        SysTime := PSystemTime(Message.LParam);
        NewDate := SystemTimeToDateTime(SysTime^);
        OLPointer^ := NewDate;
      end
      else
        OLPointer^ := Null;

      FOriginalWindowProc(Message);

      if Assigned(FEditOnChange) then
        FEditOnChange(Edit);
    finally
      FUpdatingFromControl := False;
    end;
  end
  else if Message.Msg = CM_PARENTCHANGED then
  begin
    FOriginalWindowProc(Message);
    if (Edit <> nil) and (Edit.Parent <> nil) then
      Edit.HandleNeeded;
  end
  else
    FOriginalWindowProc(Message);
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

procedure TDateTimePickerToOLDate.RefreshControl;
var
  d: OLDate;
begin
  if FUpdatingFromControl then
    Exit;

  if not Edit.Focused() then
  begin
    d := (OLPointer^);

    if d.HasValue then
    begin
      if Edit.DateTime <> d then
      begin
        FUpdatingFromRefresh := True;
        try
          Edit.DateTime := d;
        finally
          FUpdatingFromRefresh := False;
        end;
      end;
      if Edit.Format <> NotNullFormat then
        Edit.Format := NotNullFormat;
    end
    else
    begin
      if Edit.Format <> NULL_FORMAT then
        edit.Format := NULL_FORMAT;
    end;
  end;
end;

procedure TDateTimePickerToOLDate.SetEdit(const Value: TDateTimePicker);
begin
  FEdit := Value;

  if Assigned(Value) then
  begin
    Value.FreeNotification(Self);

    NotNullFormat := Value.Format;

    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;

    FEditOnEnter := Value.OnEnter;
    Value.OnEnter := NewOnEnter;

    FEditOnKeyPress := Value.OnKeyPress;
    Value.OnKeyPress := NewOnKeyPress;

    FOriginalWindowProc := Value.WindowProc;
    Value.WindowProc := NewWindowProc;

    if Value.Parent <> nil then
      Value.HandleNeeded;
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
  FUpdatingFromRefresh := False;
  FUpdatingFromControl := False;
end;

destructor TDateTimePickerToOLDateTime.Destroy;
begin
  if Assigned(FEdit) then
  begin
    if Assigned(FOriginalWindowProc) then
      FEdit.WindowProc := FOriginalWindowProc;
    if Assigned(FEditOnChange) then
      FEdit.OnChange := FEditOnChange;
    if Assigned(FEditOnEnter) then
      FEdit.OnEnter := FEditOnEnter;
    if Assigned(FEditOnKeyPress) then
      FEdit.OnKeyPress := FEditOnKeyPress;
  end;
  inherited;
end;

procedure TDateTimePickerToOLDateTime.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FEdit) then
    FEdit := nil;
end;

procedure TDateTimePickerToOLDateTime.NewOnChange(Sender: TObject);
begin
  FUpdatingFromControl := True;
  try
    //OLPointer^ := Edit.Date + Edit.Time;

    //OLPointer^ := StrToDateTime(THackDateTimePicker(Edit).Caption);

    OLPointer^ := Edit.DateTime;

    if Assigned(FEditOnChange) then
      FEditOnChange(Edit);
  finally
    FUpdatingFromControl := False;
  end;
end;

procedure TDateTimePickerToOLDateTime.NewWindowProc(var Message: TMessage);
const
  DTM_SETSYSTEMTIME = $1002;
  GDT_VALID = 0;
  CM_PARENTCHANGED = $B001;
var
  SysTime: PSystemTime;
  NewDate: TDateTime;
  IsSetSystemTime: Boolean;
begin
  IsSetSystemTime := (Message.Msg = DTM_SETSYSTEMTIME) and (not FUpdatingFromRefresh);

  if IsSetSystemTime then
  begin
    FUpdatingFromControl := True;
    try
      if Message.WParam = GDT_VALID then
      begin
        SysTime := PSystemTime(Message.LParam);
        NewDate := SystemTimeToDateTime(SysTime^);
        OLPointer^ := NewDate;
      end
      else
        OLPointer^ := Null;

      FOriginalWindowProc(Message);

      if Assigned(FEditOnChange) then
        FEditOnChange(Edit);
    finally
      FUpdatingFromControl := False;
    end;
  end
  else if Message.Msg = CM_PARENTCHANGED then
  begin
    FOriginalWindowProc(Message);
    if (Edit <> nil) and (Edit.Parent <> nil) then
      Edit.HandleNeeded;
  end
  else
    FOriginalWindowProc(Message);
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

procedure TDateTimePickerToOLDateTime.RefreshControl;
var
  d: OLDateTime;
begin
  if FUpdatingFromControl then
    Exit;

  if not Edit.Focused() then
  begin
    d := (OLPointer^);

    if d.HasValue then
    begin
      if Edit.DateTime <> d then
      begin
        FUpdatingFromRefresh := True;
        try
          Edit.DateTime := d;
        finally
          FUpdatingFromRefresh := False;
        end;
      end;
      if Edit.Format <> NotNullFormat then
        Edit.Format := NotNullFormat;
    end
    else
    begin
      if Edit.Format <> NULL_FORMAT then
        edit.Format := NULL_FORMAT;
    end;
  end;
end;

procedure TDateTimePickerToOLDateTime.SetEdit(const Value: TDateTimePicker);
begin
  FEdit := Value;

  if Assigned(Value) then
  begin
    Value.FreeNotification(Self);

    NotNullFormat := Value.Format;

    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;

    FEditOnEnter := Value.OnEnter;
    Value.OnEnter := NewOnEnter;

    FEditOnKeyPress := Value.OnKeyPress;
    Value.OnKeyPress := NewOnKeyPress;

    FOriginalWindowProc := Value.WindowProc;
    Value.WindowProc := NewWindowProc;

    if Value.Parent <> nil then
      Value.HandleNeeded;
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

  if Assigned(FEditOnClick) then
    FEditOnClick(Edit);
end;

procedure TCheckBoxToOLBoolean.RefreshControl;
begin
  if Edit.Checked <> (OLPointer^).IfNull(False) then
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

procedure TOLIntegerToLabel.RefreshControl;
var
  s: string;
begin
  if OLPointer <> nil then
  begin
    s := (OLPointer^).ToString();
    if Lbl.Caption <> s then
      Lbl.Caption := s;
  end;

  if Assigned(Calculation) then
  try
    s := Calculation().ToString();
    if Lbl.Caption <> s then
      Lbl.Caption := s;
  except
    s := ValueOnErrorInCalculation.IfNullOrEmpty(ERROR_STRING);
    if Lbl.Caption <> s then
      Lbl.Caption := s;
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

procedure TOLStringToLabel.RefreshControl;
var
  s: string;
begin
  if OLPointer <> nil then
  begin
    s := (OLPointer^).ToString();
    if Lbl.Caption <> s then
      Lbl.Caption := s;
  end;

  if Assigned(Calculation) then
  try
    s := Calculation().ToString();
    if Lbl.Caption <> s then
      Lbl.Caption := s;
  except
    s := ValueOnErrorInCalculation.IfNullOrEmpty(ERROR_STRING);
    if Lbl.Caption <> s then
      Lbl.Caption := s;
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
  FFormat := DOUBLE_FORMAT;
end;

procedure TOLDoubleToLabel.RefreshControl;
var
  fs: TFormatSettings;
  s: string;
begin
  fs := TFormatSettings.Create();

  if OLPointer <> nil then
  begin
    s := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, FFormat);
    if Lbl.Caption <> s then
      Lbl.Caption := s;
  end;

  if Assigned(Calculation) then
  try
    s := Calculation().ToString(fs.ThousandSeparator, fs.DecimalSeparator, FFormat);
    if Lbl.Caption <> s then
      Lbl.Caption := s;
  except
    s := ValueOnErrorInCalculation.IfNullOrEmpty(ERROR_STRING);
    if Lbl.Caption <> s then
      Lbl.Caption := s;
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
  FFormat := CURRENCY_FORMAT;
end;

procedure TOLCurrencyToLabel.RefreshControl;
var
  fs: TFormatSettings;
  s: string;
begin
  fs := TFormatSettings.Create();

  if OLPointer <> nil then
  begin
    s := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, FFormat);
    if Lbl.Caption <> s then
      Lbl.Caption := s;
  end;

  if Assigned(Calculation) then
  try
    s := Calculation().ToString(fs.ThousandSeparator, fs.DecimalSeparator, FFormat);
    if Lbl.Caption <> s then
      Lbl.Caption := s;
  except
    s := ValueOnErrorInCalculation.IfNullOrEmpty(ERROR_STRING);
    if Lbl.Caption <> s then
      Lbl.Caption := s;
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

procedure TOLDateToLabel.RefreshControl;
var
  s: string;
begin
  if OLPointer <> nil then
  begin
    s := (OLPointer^).ToString();
    if Lbl.Caption <> s then
      Lbl.Caption := s;
  end;

  if Assigned(Calculation) then
  try
    s := Calculation().ToString();
    if Lbl.Caption <> s then
      Lbl.Caption := s;
  except
    s := ValueOnErrorInCalculation.IfNullOrEmpty(ERROR_STRING);
    if Lbl.Caption <> s then
      Lbl.Caption := s;
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

procedure TOLDateTimeToLabel.RefreshControl;
var
  s: string;
begin
  if OLPointer <> nil then
  begin
    s := (OLPointer^).ToString();
    if Lbl.Caption <> s then
      Lbl.Caption := s;
  end;

  if Assigned(Calculation) then
  try
    s := Calculation().ToString();
    if Lbl.Caption <> s then
      Lbl.Caption := s;
  except
    s := ValueOnErrorInCalculation.IfNullOrEmpty(ERROR_STRING);
    if Lbl.Caption <> s then
      Lbl.Caption := s;
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

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TScrollBarToILInteger.RefreshControl;
begin
  if Edit.Position <> (OLPointer^).IfNull(0) then
    Edit.Position := (OLPointer^).IfNull(0);
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

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TTrackBarToILInteger.RefreshControl;
begin
  if Edit.Position <> (OLPointer^).IfNull(0) then
    Edit.Position := (OLPointer^).IfNull(0);
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
  Dest.FLinks := TDictionary<TForm, TObjectList<TOLLinkBase>>.Create;
  Dest.FTimers := TDictionary<TForm, TTimer>.Create;
  Dest.FWatchers := TDictionary<TForm, TComponent>.Create;
end;

class operator TOLTypesToControlsLinks.Finalize(var Dest: TOLTypesToControlsLinks);
var
  List: TObjectList<TOLLinkBase>;
begin
  if Assigned(Dest.FLinks) then
  begin
    for List in Dest.FLinks.Values do
      List.Free;
    Dest.FLinks.Free;
  end;
  if Assigned(Dest.FTimers) then
  begin
    // Free all timers to avoid leaks and AVs
    for var Timer in Dest.FTimers.Values do
    begin
      Timer.Enabled := False;
      Timer.Free;
    end;
    Dest.FTimers.Free;
  end;
  if Assigned(Dest.FWatchers) then
    Dest.FWatchers.Free;
end;

procedure TOLTypesToControlsLinks.AddLink(Control: TControl; Link: TOLLinkBase);
var
  Form: TForm;
  List: TObjectList<TOLLinkBase>;
  Timer: TTimer;
  Watcher: TOLFormWatcher;
begin
  Form := GetParentForm(Control) as TForm;
  if Form = nil then Exit;

  if not Assigned(FLinks) then Exit;

  if not FLinks.TryGetValue(Form, List) then
  begin
    List := TObjectList<TOLLinkBase>.Create(True);
    FLinks.Add(Form, List);
  end;

  List.Add(Link);

  // Ensure Timer
  if not FTimers.ContainsKey(Form) then
  begin
    Timer := TRefreshTimer.Create(nil, Form); // Owned by nil, we manage it
    Timer.Enabled := True;
    FTimers.Add(Form, Timer);
  end;

  // Ensure Watcher
  if not FWatchers.ContainsKey(Form) then
  begin
    Watcher := TOLFormWatcher.Create(Form); // Owned by Form, so it dies with Form
    FWatchers.Add(Form, Watcher);
  end;
end;


procedure TOLTypesToControlsLinks.Link(const Edit: TSpinEdit; var i: OLInteger);
var
  Link: TSpinEditToOLInteger;
begin
  Link := TSpinEditToOLInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var i: OLInteger;
    const Alignment: TAlignment=taRightJustify);
var
  Link: TEditToOLInteger;
begin
  Link := TEditToOLInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  AddLink(Edit, Link);
  
  Edit.Alignment := Alignment;

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TTrackBar; var i: OLInteger);
var
  Link: TTrackBarToILInteger;
begin
  Link := TTrackBarToILInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TScrollBar; var i: OLInteger);
var
  Link: TScrollBarToILInteger;
begin
  Link := TScrollBarToILInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify);
var
  Link: TEditToOLDouble;
begin
  Link := TEditToOLDouble.Create;
  Link.FFormat := Format;
  Link.Edit := Edit;
  Link.FOLPointer := @d;
  AddLink(Edit, Link);

  Edit.Alignment := Alignment;

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify);
var
  Link: TEditToOLCurrency;
begin
  Link := TEditToOLCurrency.Create;
  Link.FFormat := Format;
  Link.Edit := Edit;
  Link.FOLPointer := @curr;
  AddLink(Edit, Link);
  
  Edit.Alignment := Alignment;

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var s: OLString);
var
  Link: TEditToOLString;
begin
  Link := TEditToOLString.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @s;
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TMemo; var s: OLString);
var
  Link: TMemoToOLString;
begin
  Link := TMemoToOLString.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @s;
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TDateTimePicker; var d: OLDate);
var
  Link: TDateTimePickerToOLDate;
  fs: TFormatSettings;
begin
  if Edit.Format = '' then
  begin
    Edit.Format := OLType(FormatSettings.ShortDateFormat);
  end;
  
  Link := TDateTimePickerToOLDate.Create;
  Link.FOLPointer := @d;
  Link.Edit := Edit;
  AddLink(Edit, Link);

  Link.RefreshControl();
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
  Link.FOLPointer := @d;
  Link.Edit := Edit;
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TCheckBox; var b: OLBoolean);
var
  Link: TCheckBoxToOLBoolean;
begin
  Link := TCheckBoxToOLBoolean.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @b;
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var i: OLInteger);
var
  Link: TOLIntegerToLabel;
begin
  Link := TOLIntegerToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @i;
  AddLink(Lbl, Link);

  Link.RefreshControl();
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
  AddLink(Lbl, Link);

  Link.RefreshControl();
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
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var s: OLString);
var
  Link: TOLStringToLabel;
begin
  Link := TOLStringToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @s;
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f: TFunctionReturningOLDouble; const Format: string = DOUBLE_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING);
var
  Link: TOLDoubleToLabel;
begin
  Link := TOLDoubleToLabel.Create;
  Link.FFormat := Format;
  Link.Lbl := Lbl;
  Link.Calculation := f;
  Link.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var d: OLDouble; const Format: string = DOUBLE_FORMAT);
var
  Link: TOLDoubleToLabel;
begin
  Link := TOLDoubleToLabel.Create;
  Link.FFormat := Format;
  Link.Lbl := Lbl;
  Link.FOLPointer := @d;
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f: TFunctionReturningOLCurrency; const Format: string = CURRENCY_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING);
var
  Link: TOLCurrencyToLabel;
begin
  Link := TOLCurrencyToLabel.Create;
  Link.FFormat := Format;
  Link.Lbl := Lbl;
  Link.Calculation := f;
  Link.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT);
var
  Link: TOLCurrencyToLabel;
begin
  Link := TOLCurrencyToLabel.Create;
  Link.FFormat := Format;
  Link.Lbl := Lbl;
  Link.FOLPointer := @curr;
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
var
  Link: TOLDateToLabel;
begin
  Link := TOLDateToLabel.Create;
  Link.Lbl := Lbl;
  Link.Calculation := f;
  Link.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var d: OLDate);
var
  Link: TOLDateToLabel;
begin
  Link := TOLDateToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @d;
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
var
  Link: TOLDateTimeToLabel;
begin
  Link := TOLDateTimeToLabel.Create;
  Link.Lbl := Lbl;
  Link.Calculation := f;
  Link.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var d: OLDateTime);
var
  Link: TOLDateTimeToLabel;
begin
  Link := TOLDateTimeToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @d;
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.RefreshControls(FormToRefresh: TForm = nil);
var
  List: TObjectList<TOLLinkBase>;
  Link: TOLLinkBase;
begin
  if FormToRefresh = nil then Exit;

  if not Assigned(FLinks) then Exit;

  if FLinks.TryGetValue(FormToRefresh, List) then
  begin
    for Link in List do
      Link.RefreshControl();
  end;
end;

procedure TOLTypesToControlsLinks.RemoveLinks(DestroyedForm: TForm = nil);
var
  List: TObjectList<TOLLinkBase>;
  Timer: TTimer;
  Watcher: TComponent;
begin
  if DestroyedForm <> nil then
  begin
    if not Assigned(FLinks) then Exit;

    // Remove Watcher
    if FWatchers.TryGetValue(DestroyedForm, Watcher) then
    begin
      FWatchers.Remove(DestroyedForm);
      // Only free if it's not being destroyed already (e.g. Form destruction)
      if not (csDestroying in Watcher.ComponentState) then
        Watcher.Free;
    end;

    // Remove Timer
    if FTimers.TryGetValue(DestroyedForm, Timer) then
    begin
      FTimers.Remove(DestroyedForm);
      Timer.Enabled := False;
      Timer.Free;
    end;

    if FLinks.TryGetValue(DestroyedForm, List) then
    begin
      List.Free;  // Free the list and all its link objects
      FLinks.Remove(DestroyedForm);
    end;
  end;
end;

{$IFEND}

end.
