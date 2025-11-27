unit OLTypesToEdits;

{$IF CompilerVersion >= 34.0}

interface

uses OLTypes, System.Generics.Collections,
  {$IF CompilerVersion >= 23.0}
  Vcl.StdCtrls, System.SysUtils, Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.Forms,
  System.Classes, Vcl.Controls, Messages, Winapi.Windows, Vcl.ExtCtrls,
  OLStringType;
  {$ELSE}
  StdCtrls, SysUtils, Spin, ComCtrls, Forms, Classes, Controls, Messages, Windows, ExtCtrls;
  {$IFEND}

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


  TOLLinkBase = class(TComponent)
  public
    constructor Create; reintroduce;
    procedure RefreshControl; virtual; abstract;
    function NeedsTimer: Boolean; virtual;
  end;

  TEditToOLInteger = class(TOLLinkBase)
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FEditOnExit: TNotifyEvent;
    FOLPointer: POLInteger;
    FUpdatingFromControl: Boolean;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLInteger);
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure NewOnExit(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TSpinEditToOLInteger = class(TOLLinkBase)
  private
    FEdit: TSpinEdit;
    FEditOnChange: TEditOnChange;
    FEditOnExit: TNotifyEvent;
    FOLPointer: POLInteger;
    FUpdatingFromControl: Boolean;
    procedure NewOnExit(Sender: TObject);
    procedure SetEdit(const Value: TSpinEdit);
    procedure SetOLPointer(const Value: POLInteger);
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    property Edit: TSpinEdit read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TScrollBarToOLInteger = class(TOLLinkBase)
  private
    FEdit: TScrollBar;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    procedure SetEdit(const Value: TScrollBar);
    procedure SetOLPointer(const Value: POLInteger);
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    property Edit: TScrollBar read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TTrackBarToOLInteger = class(TOLLinkBase)
  private
    FEdit: TTrackBar;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    procedure SetEdit(const Value: TTrackBar);
    procedure SetOLPointer(const Value: POLInteger);
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    property Edit: TTrackBar read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
  end;

  TEditToOLDouble = class(TOLLinkBase)
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FEditOnExit: TNotifyEvent;
    FOLPointer: POLDouble;
    FUpdatingFromControl: Boolean;
    FFormat: string;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLDouble);
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure NewOnExit(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLDouble read FOLPointer write SetOLPointer;
  end;

  TEditToOLCurrency = class(TOLLinkBase)
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FEditOnExit: TNotifyEvent;
    FOLPointer: POLCurrency;
    FUpdatingFromControl: Boolean;
    FFormat: string;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLCurrency);
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure NewOnExit(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
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
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
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
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
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
    procedure OnOLChange(Sender: TObject);
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
    procedure OnOLChange(Sender: TObject);
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
    destructor Destroy; override;
    procedure NewOnClick(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
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
    function NeedsTimer: Boolean;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLInteger);
    procedure SetCalculation(const Value: TFunctionReturningOLInteger);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
  public
    constructor Create;
    destructor Destroy; override;
    procedure OnOLChange(Sender: TObject);
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
    function NeedsTimer: Boolean; override;
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
    destructor Destroy; override;
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    function NeedsTimer: Boolean; override;
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
    destructor Destroy; override;
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    function NeedsTimer: Boolean; override;
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
    destructor Destroy; override;
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    function NeedsTimer: Boolean; override;
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
    constructor Create;
    destructor Destroy; override;
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    function NeedsTimer: Boolean; override;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLDateTime read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLDateTime read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
  end;

  TOLTypesToControlsLinks = class
  private
    FLinks: TDictionary<TForm, TObjectList<TOLLinkBase>>;
    FTimers: TDictionary<TForm, TTimer>;
    FWatchers: TDictionary<TForm, TComponent>;
    FObservers: TDictionary<Pointer, TObject>;  // Maps OLType pointer -> TOLValueObserver
    procedure AddLink(Control: TControl; Link: TOLLinkBase);
    function DelphiDateTimeFormatToWindowsFormat(const DelphiFormat: OLString): OLString;
  public
    constructor Create;
    destructor Destroy; override;
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

   function Links(): TOLTypesToControlsLinks;

implementation

uses
  System.Variants, SmartToDate;

const
  NULL_FORMAT = '- - -';
  CALCULATION_ASSIGN_ERROR = 'Calculation cannot be set when OLPointer property is other then nil.';
  OLPOINTER_ASSIGN_ERROR = 'OLPointer cannot be set when Calculation property is other then nil.';

var
  OLLinks: TOLTypesToControlsLinks;

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

  { Observer class to multicast OnChange events to multiple links }
  TOLValueObserver = class
  private
    FLinks: TList<TOLLinkBase>;
    procedure OnOLChange(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddLink(Link: TOLLinkBase);
    procedure RemoveLink(Link: TOLLinkBase);
    function IsEmpty: Boolean;
  end;

function Links(): TOLTypesToControlsLinks;
begin
  Result := OLLinks;
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

{ TOLValueObserver }

constructor TOLValueObserver.Create;
begin
  inherited Create;
  FLinks := TList<TOLLinkBase>.Create;
end;

destructor TOLValueObserver.Destroy;
begin
  FLinks.Free;
  inherited;
end;

procedure TOLValueObserver.AddLink(Link: TOLLinkBase);
begin
  if not FLinks.Contains(Link) then
    FLinks.Add(Link);
end;

procedure TOLValueObserver.RemoveLink(Link: TOLLinkBase);
begin
  FLinks.Remove(Link);
end;

function TOLValueObserver.IsEmpty: Boolean;
begin
  Result := FLinks.Count = 0;
end;

procedure TOLValueObserver.OnOLChange(Sender: TObject);
var
  Link: TOLLinkBase;
begin
  // Multicast: call RefreshControl on all registered links
  for Link in FLinks do
    Link.RefreshControl;
end;

constructor TEditToOLInteger.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FEditOnExit := nil;
  FOLPointer := nil;
  FUpdatingFromControl := False;
end;

destructor TEditToOLInteger.Destroy;
begin
  // Note: We don't set FOLPointer^.OnChange := nil here because when using
  // observer pattern (multiple controls to one value), the OnChange points to
  // the observer, not to this link. The observer handles cleanup via RemoveLink.

  if Assigned(FEdit) then
  begin
    if Assigned(FEditOnChange) then
      FEdit.OnChange := FEditOnChange;
    if Assigned(FEditOnExit) then
      FEdit.OnExit := FEditOnExit;
  end;
  inherited;
end;

procedure TEditToOLInteger.NewOnChange(Sender: TObject);
var
  i, j: integer;
begin
  if FUpdatingFromControl then Exit;

  if (Edit.Text = '-') or (Edit.Text = '') then
  begin
    if Edit.Text = '' then
    begin
      FUpdatingFromControl := True;
      try
        OLPointer^ := Null;
      finally
        FUpdatingFromControl := False;
      end;
    end;
  end
  else
  begin
    if TryStrToInt(Edit.Text, i) then
    begin
      FUpdatingFromControl := True;
      try
        OLPointer^ := i;
      finally
        FUpdatingFromControl := False;
      end;
    end
    else
    begin
      FUpdatingFromControl := True;
      try
        j := Edit.SelStart;
        Edit.Text := (OLPointer^).ToString();
        if j > 0 then Edit.SelStart := j - 1;
      finally
        FUpdatingFromControl := False;
      end;
    end;
  end;

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TEditToOLInteger.NewOnExit(Sender: TObject);
begin
  RefreshControl;

  if Assigned(FEditOnExit) then
    FEditOnExit(Sender);
end;

procedure TEditToOLInteger.OnOLChange(Sender: TObject);
begin
  RefreshControl;
end;

procedure TEditToOLInteger.RefreshControl;
begin
  if FUpdatingFromControl then Exit;

  // Don't overwrite user input while they're typing
  if Edit.Focused() then Exit;

  if Edit.Text <> (OLPointer^).ToString() then
  begin
    FUpdatingFromControl := True;
    try
      Edit.Text := (OLPointer^).ToString();
    finally
      FUpdatingFromControl := False;
    end;
  end;
end;

procedure TEditToOLInteger.SetEdit(const Value: TEdit);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
    FEditOnExit := Value.OnExit;
    Value.OnExit := NewOnExit;
  end;
end;

procedure TEditToOLInteger.SetOLPointer(const Value: POLInteger);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
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

destructor TEditToOLString.Destroy;
begin
  // Note: We don't set FOLPointer^.OnChange := nil here because when using
  // observer pattern (multiple controls to one value), the OnChange points to
  // the observer, not to this link. The observer handles cleanup via RemoveLink.
  inherited;
end;

procedure TEditToOLString.NewOnChange(Sender: TObject);
begin
  OLPointer^ := Edit.Text;

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TEditToOLString.OnOLChange(Sender: TObject);
begin
  RefreshControl;
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
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
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

destructor TMemoToOLString.Destroy;
begin
  // Note: We don't set FOLPointer^.OnChange := nil here because when using
  // observer pattern (multiple controls to one value), the OnChange points to
  // the observer, not to this link. The observer handles cleanup via RemoveLink.

  if Assigned(FEdit) then
  begin
    if Assigned(FEditOnChange) then
      FEdit.OnChange := FEditOnChange;
  end;
  inherited;
end;

procedure TMemoToOLString.NewOnChange(Sender: TObject);
begin
  OLPointer^ := Edit.Text;

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TMemoToOLString.OnOLChange(Sender: TObject);
begin
  RefreshControl;
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
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{ TEditToOLDouble }

constructor TEditToOLDouble.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FEditOnExit := nil;
  FOLPointer := nil;
  FUpdatingFromControl := False;
  FFormat := DOUBLE_FORMAT;
end;

destructor TEditToOLDouble.Destroy;
begin
  // Note: We don't set FOLPointer^.OnChange := nil here because when using
  // observer pattern (multiple controls to one value), the OnChange points to
  // the observer, not to this link. The observer handles cleanup via RemoveLink.
  inherited;
end;

procedure TEditToOLDouble.NewOnChange(Sender: TObject);
var
  d: Double;
  fs: TFormatSettings;
  s, CleanS: string;
  j: Integer;
begin
  if FUpdatingFromControl then Exit;

  fs := FormatSettings;
  s := Edit.Text;
  CleanS := OLType(s).Replaced(fs.ThousandSeparator, '');

  if (CleanS = '-') or (CleanS = '') or (CleanS = fs.DecimalSeparator) or (CleanS = '-' + fs.DecimalSeparator) then
  begin
    if CleanS = '' then
    begin
      FUpdatingFromControl := True;
      try
        OLPointer^ := Null;
      finally
        FUpdatingFromControl := False;
      end;
    end;
  end
  else if TryStrToFloat(CleanS, d) then
  begin
    FUpdatingFromControl := True;
    try
      OLPointer^ := d;
    finally
      FUpdatingFromControl := False;
    end;
  end
  else
  begin
    // Invalid input, revert
    FUpdatingFromControl := True;
    try
      j := Edit.SelStart;
      if Edit.Focused() then
        Edit.Text := (OLPointer^).ToString(#0, fs.DecimalSeparator, FFormat)
      else
        Edit.Text := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, FFormat);
      
      // Restore cursor logic is complex with formatting changes, but simple revert is safer
      // Ideally we should try to keep cursor, but if text changed significantly it's hard.
      // For now, simple revert.
      if j > 0 then Edit.SelStart := j - 1;
    finally
      FUpdatingFromControl := False;
    end;
  end;

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TEditToOLDouble.NewOnExit(Sender: TObject);
begin
  RefreshControl;

  if Assigned(FEditOnExit) then
    FEditOnExit(Sender);
end;

procedure TEditToOLDouble.OnOLChange(Sender: TObject);
begin
  RefreshControl();
end;

procedure TEditToOLDouble.RefreshControl;
var
  fs: TFormatSettings;
  s: string;
begin
  if FUpdatingFromControl then Exit;

  if not Edit.Focused() then
  begin
    fs := FormatSettings;
    s := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, FFormat);
    if Edit.Text <> s then
    begin
      FUpdatingFromControl := True;
      try
        Edit.Text := s;
      finally
        FUpdatingFromControl := False;
      end;
    end;
  end;
end;

procedure TEditToOLDouble.SetEdit(const Value: TEdit);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
    FEditOnExit := Value.OnExit;
    Value.OnExit := NewOnExit;
  end;
end;

procedure TEditToOLDouble.SetOLPointer(const Value: POLDouble);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{ TEditToOLCurrency }

constructor TEditToOLCurrency.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FEditOnExit := nil;
  FOLPointer := nil;
  FUpdatingFromControl := False;
  FFormat := CURRENCY_FORMAT;
end;

destructor TEditToOLCurrency.Destroy;
begin
  // Note: We don't set FOLPointer^.OnChange := nil here because when using
  // observer pattern (multiple controls to one value), the OnChange points to
  // the observer, not to this link. The observer handles cleanup via RemoveLink.

  if Assigned(FEdit) then
  begin
    if Assigned(FEditOnChange) then
      FEdit.OnChange := FEditOnChange;
  end;
  inherited;
end;

procedure TEditToOLCurrency.NewOnChange(Sender: TObject);
var
  curr: Currency;
  s, CleanS: OLString;
  fs: TFormatSettings;
  j: Integer;
  k: OLInteger;
begin
  if FUpdatingFromControl then Exit;

  fs := FormatSettings;
  s := Edit.Text;
  CleanS := s.Replaced(fs.ThousandSeparator, '');

  if (CleanS = '-') or (CleanS = '') or (CleanS = fs.DecimalSeparator) or (CleanS = '-' + fs.DecimalSeparator) then
  begin
    if CleanS = '' then
    begin
      FUpdatingFromControl := True;
      try
        OLPointer^ := Null;
      finally
        FUpdatingFromControl := False;
      end;
    end;
  end
  else if TryStrToCurr(CleanS, curr) then
  begin
    FUpdatingFromControl := True;
    try
      OLPointer^ := curr;
    finally
      FUpdatingFromControl := False;
    end;
  end
  else
  begin
    // Invalid input, revert
    FUpdatingFromControl := True;
    try
      j := Edit.SelStart;
      if Edit.Focused() then
        Edit.Text := (OLPointer^).ToString(#0, fs.DecimalSeparator, CURRENCY_FORMAT)
      else
        Edit.Text := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, CURRENCY_FORMAT);
      
      if j > 0 then Edit.SelStart := j - 1;
    finally
      FUpdatingFromControl := False;
    end;
  end;

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TEditToOLCurrency.NewOnExit(Sender: TObject);
begin
  RefreshControl;

  if Assigned(FEditOnExit) then
    FEditOnExit(Sender);
end;

procedure TEditToOLCurrency.OnOLChange(Sender: TObject);
begin
  RefreshControl;
end;

procedure TEditToOLCurrency.RefreshControl;
var
  fs: TFormatSettings;
  s: string;
begin
  if FUpdatingFromControl then Exit;

  if not Edit.Focused() then
  begin
    fs := FormatSettings;
    s := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, '###,###,###,##0.00####');
    if Edit.Text <> s then
    begin
      FUpdatingFromControl := True;
      try
        Edit.Text := s;
      finally
        FUpdatingFromControl := False;
      end;
    end;
  end;
end;

procedure TEditToOLCurrency.SetEdit(const Value: TEdit);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
    FEditOnExit := Value.OnExit;
    Value.OnExit := NewOnExit;
  end;
end;

procedure TEditToOLCurrency.SetOLPointer(const Value: POLCurrency);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{ TSpinEditToOLInteger }

constructor TSpinEditToOLInteger.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FEditOnExit := nil;
  FOLPointer := nil;
  FUpdatingFromControl := False;
end;

destructor TSpinEditToOLInteger.Destroy;
begin
  if Assigned(FOLPointer) then
  begin
    {$IF CompilerVersion >= 34.0}
    FOLPointer^.OnChange := nil;
    {$IFEND}
  end;

  if Assigned(FEdit) then
  begin
    if Assigned(FEditOnChange) then
      FEdit.OnChange := FEditOnChange;
    if Assigned(FEditOnExit) then
      FEdit.OnExit := FEditOnExit;
  end;
  inherited;
end;

procedure TSpinEditToOLInteger.NewOnChange(Sender: TObject);
var
  i, j: integer;
begin
  if FUpdatingFromControl then Exit;

  if (Edit.Text = '-') or (Edit.Text = '') then
  begin
    if Edit.Text = '' then
    begin
      FUpdatingFromControl := True;
      try
        OLPointer^ := Null;
      finally
        FUpdatingFromControl := False;
      end;
    end;
  end
  else
  begin
    if TryStrToInt(Edit.Text, i) then
    begin
      FUpdatingFromControl := True;
      try
        OLPointer^ := i;
      finally
        FUpdatingFromControl := False;
      end;
    end
    else
    begin
      FUpdatingFromControl := True;
      try
        j := Edit.SelStart;
        Edit.Text := (OLPointer^).ToString();
        if j > 0 then Edit.SelStart := j - 1;
      finally
        FUpdatingFromControl := False;
      end;
    end;
  end;

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TSpinEditToOLInteger.NewOnExit(Sender: TObject);
begin
  RefreshControl;

  if Assigned(FEditOnExit) then
    FEditOnExit(Sender);
end;

procedure TSpinEditToOLInteger.OnOLChange(Sender: TObject);
begin
  RefreshControl;
end;

procedure TSpinEditToOLInteger.RefreshControl;
begin
  if FUpdatingFromControl then Exit;

  // Don't overwrite user input while they're typing
  if Edit.Focused() then Exit;

  if Edit.Text <> (OLPointer^).ToString() then
  begin
    FUpdatingFromControl := True;
    try
      Edit.Text := (OLPointer^).ToString();
    finally
      FUpdatingFromControl := False;
    end;
  end;
end;

procedure TSpinEditToOLInteger.SetEdit(const Value: TSpinEdit);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
    FEditOnExit := Value.OnExit;
    Value.OnExit := NewOnExit;
  end;
end;

procedure TSpinEditToOLInteger.SetOLPointer(const Value: POLInteger);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{ TOLLinkBase }

constructor TOLLinkBase.Create;
begin
  inherited Create(nil);
end;

function TOLLinkBase.NeedsTimer: Boolean;
begin
  Result := false;
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
  // Note: We don't set FOLPointer^.OnChange := nil here because when using
  // observer pattern (multiple controls to one value), the OnChange points to
  // the observer, not to this link. The observer handles cleanup via RemoveLink.

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

procedure TDateTimePickerToOLDate.OnOLChange(Sender: TObject);
begin
  RefreshControl;
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
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
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
  // Note: We don't set FOLPointer^.OnChange := nil here because when using
  // observer pattern (multiple controls to one value), the OnChange points to
  // the observer, not to this link. The observer handles cleanup via RemoveLink.

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

procedure TDateTimePickerToOLDateTime.OnOLChange(Sender: TObject);
begin
  RefreshControl;
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
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
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

destructor TCheckBoxToOLBoolean.Destroy;
begin
  // Note: We don't set FOLPointer^.OnChange := nil here because when using
  // observer pattern (multiple controls to one value), the OnChange points to
  // the observer, not to this link. The observer handles cleanup via RemoveLink.

  if Assigned(FEdit) then
  begin
    if Assigned(FEditOnClick) then
      FEdit.OnClick := FEditOnClick;
  end;
  inherited;
end;

procedure TCheckBoxToOLBoolean.OnOLChange(Sender: TObject);
begin
  RefreshControl;
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
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
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

destructor TOLIntegerToLabel.Destroy;
begin
  if Assigned(FOLPointer) then
  begin
    {$IF CompilerVersion >= 34.0}
    FOLPointer^.OnChange := nil;
    {$IFEND}
  end;
  inherited;
end;

procedure TOLIntegerToLabel.OnOLChange(Sender: TObject);
begin
  RefreshControl;
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
  if Assigned(Value) and Assigned(Calculation) then
    raise Exception.Create(OLPOINTER_ASSIGN_ERROR);
  if not Assigned(Value) and not Assigned(Calculation) then
    raise Exception.Create('OLPointer cannot be nil when Calculation is not set.');

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
  if Assigned(Value) and Assigned(Calculation) then
    raise Exception.Create(OLPOINTER_ASSIGN_ERROR);
  if not Assigned(Value) and not Assigned(Calculation) then
    raise Exception.Create('OLPointer cannot be nil when Calculation is not set.');

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

destructor TOLDoubleToLabel.Destroy;
begin
  if Assigned(FOLPointer) then
  begin
    {$IF CompilerVersion >= 34.0}
    FOLPointer^.OnChange := nil;
    {$IFEND}
  end;
  inherited;
end;

procedure TOLDoubleToLabel.OnOLChange(Sender: TObject);
begin
  RefreshControl;
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
  if Assigned(Value) and Assigned(Calculation) then
    raise Exception.Create(OLPOINTER_ASSIGN_ERROR);
  if not Assigned(Value) and not Assigned(Calculation) then
    raise Exception.Create('OLPointer cannot be nil when Calculation is not set.');

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

destructor TOLCurrencyToLabel.Destroy;
begin
  if Assigned(FOLPointer) then
  begin
    {$IF CompilerVersion >= 34.0}
    FOLPointer^.OnChange := nil;
    {$IFEND}
  end;
  inherited;
end;

procedure TOLCurrencyToLabel.OnOLChange(Sender: TObject);
begin
  RefreshControl;
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
  if Assigned(Value) and Assigned(Calculation) then
    raise Exception.Create(OLPOINTER_ASSIGN_ERROR);
  if not Assigned(Value) and not Assigned(Calculation) then
    raise Exception.Create('OLPointer cannot be nil when Calculation is not set.');

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

destructor TOLDateToLabel.Destroy;
begin
  if Assigned(FOLPointer) then
  begin
    {$IF CompilerVersion >= 34.0}
    FOLPointer^.OnChange := nil;
    {$IFEND}
  end;
  inherited;
end;

procedure TOLDateToLabel.OnOLChange(Sender: TObject);
begin
  RefreshControl;
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
  if Assigned(Value) and Assigned(Calculation) then
    raise Exception.Create(OLPOINTER_ASSIGN_ERROR);
  if not Assigned(Value) and not Assigned(Calculation) then
    raise Exception.Create('OLPointer cannot be nil when Calculation is not set.');

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

destructor TOLDateTimeToLabel.Destroy;
begin
  if Assigned(FOLPointer) then
  begin
    {$IF CompilerVersion >= 34.0}
    FOLPointer^.OnChange := nil;
    {$IFEND}
  end;
  inherited;
end;

procedure TOLDateTimeToLabel.OnOLChange(Sender: TObject);
begin
  RefreshControl;
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
  if Assigned(Value) and Assigned(Calculation) then
    raise Exception.Create(OLPOINTER_ASSIGN_ERROR);
  if not Assigned(Value) and not Assigned(Calculation) then
    raise Exception.Create('OLPointer cannot be nil when Calculation is not set.');

  FOLPointer := Value;
end;

procedure TOLDateTimeToLabel.SetValueOnErrorInCalculation(const Value: OLString);
begin
  FValueOnErrorInCalculation := Value;
end;

{ TScrollBarToOLInteger }

constructor TScrollBarToOLInteger.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FOLPointer := nil;
end;

destructor TScrollBarToOLInteger.Destroy;
begin
  if Assigned(FOLPointer) then
  begin
    {$IF CompilerVersion >= 34.0}
    FOLPointer^.OnChange := nil;
    {$IFEND}
  end;
  inherited;
end;

procedure TScrollBarToOLInteger.NewOnChange(Sender: TObject);
begin
  OLPointer^ := Edit.Position;

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TScrollBarToOLInteger.OnOLChange(Sender: TObject);
begin
  RefreshControl;
end;

procedure TScrollBarToOLInteger.RefreshControl;
begin
  if Edit.Position <> (OLPointer^).IfNull(0) then
    Edit.Position := (OLPointer^).IfNull(0);
end;

procedure TScrollBarToOLInteger.SetEdit(const Value: TScrollBar);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
  end;
end;

procedure TScrollBarToOLInteger.SetOLPointer(const Value: POLInteger);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{ TTrackBarToOLInteger }

constructor TTrackBarToOLInteger.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FOLPointer := nil;
end;

destructor TTrackBarToOLInteger.Destroy;
begin
  if Assigned(FOLPointer) then
  begin
    {$IF CompilerVersion >= 34.0}
    FOLPointer^.OnChange := nil;
    {$IFEND}
  end;
  inherited;
end;

procedure TTrackBarToOLInteger.NewOnChange(Sender: TObject);
begin
  OLPointer^ := Edit.Position;

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TTrackBarToOLInteger.OnOLChange(Sender: TObject);
begin
  RefreshControl;
end;

procedure TTrackBarToOLInteger.RefreshControl;
begin
  if Edit.Position <> (OLPointer^).IfNull(0) then
    Edit.Position := (OLPointer^).IfNull(0);
end;

procedure TTrackBarToOLInteger.SetEdit(const Value: TTrackBar);
begin
  FEdit := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
  end;
end;

procedure TTrackBarToOLInteger.SetOLPointer(const Value: POLInteger);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{ TOLTypesToControlsLinks }

constructor TOLTypesToControlsLinks.Create;
begin
  FLinks := TDictionary<TForm, TObjectList<TOLLinkBase>>.Create;
  FTimers := TDictionary<TForm, TTimer>.Create;
  FWatchers := TDictionary<TForm, TComponent>.Create;
  FObservers := TDictionary<Pointer, TObject>.Create;
end;

destructor TOLTypesToControlsLinks.Destroy;
var
  List: TObjectList<TOLLinkBase>;
begin
  if Assigned(FLinks) then
  begin
    for List in FLinks.Values do
      List.Free;
    FLinks.Free;
  end;
  if Assigned(FTimers) then
  begin
    // Free all timers to avoid leaks and AVs
    for var Timer in FTimers.Values do
    begin
      Timer.Enabled := False;
      Timer.Free;
    end;
    FTimers.Free;
  end;
  if Assigned(FWatchers) then
    FWatchers.Free;
  if Assigned(FObservers) then
  begin
    for var Obj in FObservers.Values do
      Obj.Free;
    FObservers.Free;
  end;
  inherited;
end;

procedure TOLTypesToControlsLinks.AddLink(Control: TControl; Link: TOLLinkBase);
var
  TempControl: TWinControl;
  Form: TForm;
  List: TObjectList<TOLLinkBase>;
  Timer: TTimer;
  Watcher: TOLFormWatcher;
begin
  if not Assigned(Control) then
    raise Exception.Create('Control cannot be nil in AddLink.');
  if not Assigned(Link) then
    raise Exception.Create('Link cannot be nil in AddLink.');

  TempControl := GetParentForm(Control);

  if TempControl is TForm then
    Form := TForm(TempControl)
  else
    Form := nil;

  if Form = nil then Exit;

  if not Assigned(FLinks) then Exit;

  if not FLinks.TryGetValue(Form, List) then
  begin
    List := TObjectList<TOLLinkBase>.Create(True);
    FLinks.Add(Form, List);
  end;

  List.Add(Link);

  // Ensure Timer
  var NeedTimer: Boolean;
  NeedTimer := False;
  {$IF CompilerVersion < 34.0}
  NeedTimer := True;
  {$ELSE}
  NeedTimer := Link.NeedsTimer;
  {$IFEND}

  if NeedTimer and (not FTimers.ContainsKey(Form)) then
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
  {$IF CompilerVersion >= 34.0}
  i.OnChange := Link.OnOLChange;
  {$IFEND}
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var i: OLInteger;
    const Alignment: TAlignment=taRightJustify);
var
  Link: TEditToOLInteger;
  Observer: TObject;
  ValueObserver: TOLValueObserver;
begin
  Link := TEditToOLInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  {$IF CompilerVersion >= 34.0}
  // Get or create observer for this OLInteger
  if not FObservers.TryGetValue(@i, Observer) then
  begin
    ValueObserver := TOLValueObserver.Create;
    FObservers.Add(@i, ValueObserver);
    i.OnChange := ValueObserver.OnOLChange;  // Set observer's handler on OLInteger
  end
  else
    ValueObserver := Observer as TOLValueObserver;
  ValueObserver.AddLink(Link);  // Register this link with the observer
  {$IFEND}
  AddLink(Edit, Link);
  
  Edit.Alignment := Alignment;

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TTrackBar; var i: OLInteger);
var
  Link: TTrackBarToOLInteger;
begin
  Link := TTrackBarToOLInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  {$IF CompilerVersion >= 34.0}
  i.OnChange := Link.OnOLChange;
  {$IFEND}
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TScrollBar; var i: OLInteger);
var
  Link: TScrollBarToOLInteger;
begin
  Link := TScrollBarToOLInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  {$IF CompilerVersion >= 34.0}
  i.OnChange := Link.OnOLChange;
  {$IFEND}
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify);
var
  Link: TEditToOLDouble;
  Observer: TObject;
  ValueObserver: TOLValueObserver;
begin
  Link := TEditToOLDouble.Create;
  Link.FFormat := Format;
  Link.Edit := Edit;
  Link.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  // Get or create observer for this OLDouble
  if not FObservers.TryGetValue(@d, Observer) then
  begin
    ValueObserver := TOLValueObserver.Create;
    FObservers.Add(@d, ValueObserver);
    d.OnChange := ValueObserver.OnOLChange;  // Set observer's handler on OLDouble
  end
  else
    ValueObserver := Observer as TOLValueObserver;
  ValueObserver.AddLink(Link);  // Register this link with the observer
  {$IFEND}
  AddLink(Edit, Link);

  Edit.Alignment := Alignment;

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify);
var
  Link: TEditToOLCurrency;
  Observer: TObject;
  ValueObserver: TOLValueObserver;
begin
  Link := TEditToOLCurrency.Create;
  Link.FFormat := Format;
  Link.Edit := Edit;
  Link.FOLPointer := @curr;
  {$IF CompilerVersion >= 34.0}
  // Get or create observer for this OLCurrency
  if not FObservers.TryGetValue(@curr, Observer) then
  begin
    ValueObserver := TOLValueObserver.Create;
    FObservers.Add(@curr, ValueObserver);
    curr.OnChange := ValueObserver.OnOLChange;  // Set observer's handler on OLCurrency
  end
  else
    ValueObserver := Observer as TOLValueObserver;
  ValueObserver.AddLink(Link);  // Register this link with the observer
  {$IFEND}
  AddLink(Edit, Link);
  
  Edit.Alignment := Alignment;

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TEdit; var s: OLString);
var
  Link: TEditToOLString;
  Observer: TObject;
  ValueObserver: TOLValueObserver;
begin
  Link := TEditToOLString.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @s;
  {$IF CompilerVersion >= 34.0}
  // Get or create observer for this OLString
  if not FObservers.TryGetValue(@s, Observer) then
  begin
    ValueObserver := TOLValueObserver.Create;
    FObservers.Add(@s, ValueObserver);
    s.OnChange := ValueObserver.OnOLChange;  // Set observer's handler on OLString
  end
  else
    ValueObserver := Observer as TOLValueObserver;
  ValueObserver.AddLink(Link);  // Register this link with the observer
  {$IFEND}
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TMemo; var s: OLString);
var
  Link: TMemoToOLString;
  Observer: TObject;
  ValueObserver: TOLValueObserver;
begin
  Link := TMemoToOLString.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @s;
  {$IF CompilerVersion >= 34.0}
  // Get or create observer for this OLString
  if not FObservers.TryGetValue(@s, Observer) then
  begin
    ValueObserver := TOLValueObserver.Create;
    FObservers.Add(@s, ValueObserver);
    s.OnChange := ValueObserver.OnOLChange;  // Set observer's handler on OLString
  end
  else
    ValueObserver := Observer as TOLValueObserver;
  ValueObserver.AddLink(Link);  // Register this link with the observer
  {$IFEND}
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TDateTimePicker; var d: OLDate);
var
  Link: TDateTimePickerToOLDate;
  Observer: TObject;
  ValueObserver: TOLValueObserver;
begin
  if Edit.Format = '' then
  begin
    Edit.Format := DelphiDateTimeFormatToWindowsFormat(FormatSettings.ShortDateFormat);
  end;
  
  Link := TDateTimePickerToOLDate.Create;
  Link.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  // Get or create observer for this OLDate
  if not FObservers.TryGetValue(@d, Observer) then
  begin
    ValueObserver := TOLValueObserver.Create;
    FObservers.Add(@d, ValueObserver);
    d.OnChange := ValueObserver.OnOLChange;  // Set observer's handler on OLDate
  end
  else
    ValueObserver := Observer as TOLValueObserver;
  ValueObserver.AddLink(Link);  // Register this link with the observer
  {$IFEND}
  Link.Edit := Edit;
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

{*
  Converts a Delphi-style date/time format string to a Windows (WinAPI)
  DateTimePicker format string.

  Delphi and Windows use different tokens for months, minutes, and hours:
    - Delphi:  mm = month, nn = minute, hh = hour (24-hour)
    - Windows: MM = month, mm = minute, HH = hour (24-hour)

  The order of replacements is important to avoid collisions:
    1. Convert Delphi month ("mm") to Windows month ("MM")
       - Must be done first, otherwise "mm" introduced later for minutes
         would also be incorrectly converted.
    2. Convert Delphi hours ("hh") to Windows hours ("HH")
    3. Convert Delphi minutes ("nn") to Windows minutes ("mm")

  After these conversions the resulting format string is compatible with
  TDateTimePicker.Format and DTM_SETFORMAT in the Windows API.
*}
function TOLTypesToControlsLinks.DelphiDateTimeFormatToWindowsFormat(const
    DelphiFormat: OLString): OLString;
var
  OutPut: OLString;
begin
  OutPut := DelphiFormat;
  OutPut := OutPut.Replaced('mm', 'MM');
  OutPut := OutPut.Replaced('hh', 'HH');
  OutPut := OutPut.Replaced('nn', 'mm');

  OutPut := OutPut.Replaced('/', FormatSettings.DateSeparator);

  Result := OutPut;
end;


procedure TOLTypesToControlsLinks.Link(const Edit: TDateTimePicker; var d:
    OLDateTime);
var
  Link: TDateTimePickerToOLDateTime;
  Observer: TObject;
  ValueObserver: TOLValueObserver;
begin
  if Edit.Format  = '' then
  begin
    if Edit.Kind = dtkTime then
      Edit.Format := FormatSettings.LongTimeFormat
    else
      Edit.Format := DelphiDateTimeFormatToWindowsFormat(
        FormatSettings.ShortDateFormat + ' ' + FormatSettings.LongTimeFormat);
  end;
  
  Link := TDateTimePickerToOLDateTime.Create;
  Link.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  // Get or create observer for this OLDateTime
  if not FObservers.TryGetValue(@d, Observer) then
  begin
    ValueObserver := TOLValueObserver.Create;
    FObservers.Add(@d, ValueObserver);
    d.OnChange := ValueObserver.OnOLChange;  // Set observer's handler on OLDateTime
  end
  else
    ValueObserver := Observer as TOLValueObserver;
  ValueObserver.AddLink(Link);  // Register this link with the observer
  {$IFEND}
  Link.Edit := Edit;
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Edit: TCheckBox; var b: OLBoolean);
var
  Link: TCheckBoxToOLBoolean;
  Observer: TObject;
  ValueObserver: TOLValueObserver;
begin
  Link := TCheckBoxToOLBoolean.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @b;
  {$IF CompilerVersion >= 34.0}
  // Get or create observer for this OLBoolean
  if not FObservers.TryGetValue(@b, Observer) then
  begin
    ValueObserver := TOLValueObserver.Create;
    FObservers.Add(@b, ValueObserver);
    b.OnChange := ValueObserver.OnOLChange;  // Set observer's handler on OLBoolean
  end
  else
    ValueObserver := Observer as TOLValueObserver;
  ValueObserver.AddLink(Link);  // Register this link with the observer
  {$IFEND}
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

procedure TOLTypesToControlsLinks.Link(const Lbl: TLabel; var i: OLInteger);
var
  Link: TOLIntegerToLabel;
  Observer: TObject;
  ValueObserver: TOLValueObserver;
begin
  Link := TOLIntegerToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @i;
  {$IF CompilerVersion >= 34.0}
  // Get or create observer for this OLInteger
  if not FObservers.TryGetValue(@i, Observer) then
  begin
    ValueObserver := TOLValueObserver.Create;
    FObservers.Add(@i, ValueObserver);
    i.OnChange := ValueObserver.OnOLChange;  // Set observer's handler on OLInteger
  end
  else
    ValueObserver := Observer as TOLValueObserver;
  ValueObserver.AddLink(Link);  // Register this link with the observer
  {$IFEND}
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
  Observer: TObject;
  ValueObserver: TOLValueObserver;
begin
  Link := TOLStringToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @s;
  {$IF CompilerVersion >= 34.0}
  // Get or create observer for this OLString
  if not FObservers.TryGetValue(@s, Observer) then
  begin
    ValueObserver := TOLValueObserver.Create;
    FObservers.Add(@s, ValueObserver);
    s.OnChange := ValueObserver.OnOLChange;  // Set observer's handler on OLString
  end
  else
    ValueObserver := Observer as TOLValueObserver;
  ValueObserver.AddLink(Link);  // Register this link with the observer
  {$IFEND}
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
  Observer: TObject;
  ValueObserver: TOLValueObserver;
begin
  Link := TOLDoubleToLabel.Create;
  Link.FFormat := Format;
  Link.Lbl := Lbl;
  Link.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  // Get or create observer for this OLDouble
  if not FObservers.TryGetValue(@d, Observer) then
  begin
    ValueObserver := TOLValueObserver.Create;
    FObservers.Add(@d, ValueObserver);
    d.OnChange := ValueObserver.OnOLChange;  // Set observer's handler on OLDouble
  end
  else
    ValueObserver := Observer as TOLValueObserver;
  ValueObserver.AddLink(Link);  // Register this link with the observer
  {$IFEND}
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
  Observer: TObject;
  ValueObserver: TOLValueObserver;
begin
  Link := TOLCurrencyToLabel.Create;
  Link.FFormat := Format;
  Link.Lbl := Lbl;
  Link.FOLPointer := @curr;
  {$IF CompilerVersion >= 34.0}
  // Get or create observer for this OLCurrency
  if not FObservers.TryGetValue(@curr, Observer) then
  begin
    ValueObserver := TOLValueObserver.Create;
    FObservers.Add(@curr, ValueObserver);
    curr.OnChange := ValueObserver.OnOLChange;  // Set observer's handler on OLCurrency
  end
  else
    ValueObserver := Observer as TOLValueObserver;
  ValueObserver.AddLink(Link);  // Register this link with the observer
  {$IFEND}
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
  Observer: TObject;
  ValueObserver: TOLValueObserver;
begin
  Link := TOLDateToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  // Get or create observer for this OLDate
  if not FObservers.TryGetValue(@d, Observer) then
  begin
    ValueObserver := TOLValueObserver.Create;
    FObservers.Add(@d, ValueObserver);
    d.OnChange := ValueObserver.OnOLChange;  // Set observer's handler on OLDate
  end
  else
    ValueObserver := Observer as TOLValueObserver;
  ValueObserver.AddLink(Link);  // Register this link with the observer
  {$IFEND}
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
  Observer: TObject;
  ValueObserver: TOLValueObserver;
begin
  Link := TOLDateTimeToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  // Get or create observer for this OLDateTime
  if not FObservers.TryGetValue(@d, Observer) then
  begin
    ValueObserver := TOLValueObserver.Create;
    FObservers.Add(@d, ValueObserver);
    d.OnChange := ValueObserver.OnOLChange;  // Set observer's handler on OLDateTime
  end
  else
    ValueObserver := Observer as TOLValueObserver;
  ValueObserver.AddLink(Link);  // Register this link with the observer
  {$IFEND}
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
      // Watcher is owned by Form, so Form will free it automatically.
      // We just remove it from our dictionary to avoid double-cleanup.
      // If the Form is being destroyed, Watcher.Destroy will call RemoveLinks anyway.
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
      // Remove links from observers before freeing
      {$IF CompilerVersion >= 34.0}
      if Assigned(FObservers) then
      begin
        for var Link in List do
        begin
          // Find and remove this link from any observer
          for var ObserverPair in FObservers do
          begin
            var Observer := ObserverPair.Value as TOLValueObserver;
            Observer.RemoveLink(Link);  // Safe to call even if link not in observer
          end;
        end;

        // Clean up empty observers
        var ObserversToRemove := TList<Pointer>.Create;
        try
          for var ObserverPair in FObservers do
          begin
            var Observer := ObserverPair.Value as TOLValueObserver;
            if Observer.IsEmpty then
              ObserversToRemove.Add(ObserverPair.Key);
          end;

          for var OLPointer in ObserversToRemove do
          begin
            var Observer := FObservers[OLPointer];
            FObservers.Remove(OLPointer);
            
            // Set OnChange := nil on the OLInteger variable before freeing observer
            // This prevents Access Violations when the variable is reused later
            // All OL types have OnChange at the same offset, so we can use POLInteger
            var OLIntPtr := POLInteger(OLPointer);
            if Assigned(OLIntPtr) then
              OLIntPtr^.OnChange := nil;
            
            Observer.Free;
          end;
        finally
          ObserversToRemove.Free;
        end;
      end;
      {$IFEND}

      List.Free;  // Free the list and all its link objects
      FLinks.Remove(DestroyedForm);
    end;
  end;
end;

function TOLIntegerToLabel.NeedsTimer: Boolean;
begin
  Result := Assigned(FCalculation);
end;

function TOLStringToLabel.NeedsTimer: Boolean;
begin
  Result := Assigned(FCalculation);
end;

function TOLDoubleToLabel.NeedsTimer: Boolean;
begin
  Result := Assigned(FCalculation);
end;

function TOLCurrencyToLabel.NeedsTimer: Boolean;
begin
  Result := Assigned(FCalculation);
end;

function TOLDateToLabel.NeedsTimer: Boolean;
begin
  Result := Assigned(FCalculation);
end;

function TOLDateTimeToLabel.NeedsTimer: Boolean;
begin
  Result := Assigned(FCalculation);
end;

initialization
  OLLinks := TOLTypesToControlsLinks.Create;

finalization
  OLLinks.Free;

{$IFEND}

end.
