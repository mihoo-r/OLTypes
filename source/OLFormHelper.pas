unit OLFormHelper;

interface

uses
  Vcl.Forms, Vcl.StdCtrls, System.SysUtils, Vcl.Samples.Spin, Vcl.ComCtrls,
  OLTypes, OLTypesToEdits, System.Classes, System.Generics.Collections, Vcl.ExtCtrls;

type

  TFormTimerManager = class
  private
    FMap: TDictionary<TForm, TTimer>;
    FOriginalOnDestroys: TDictionary<TForm, TNotifyEvent>;
    procedure OnTimer(Sender: TObject);
    procedure OnFormDestroy(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure EnsureTimer(Form: TForm);
    procedure RemoveForm(Form: TForm);
  end;

TOLFormHelper = class helper for TForm
  procedure Link(const Edit: TEdit; var i: OLInteger; const Alignment:
      TAlignment=taRightJustify); overload;
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

  procedure RefreshControls();
  procedure RemoveLinks();
  procedure NewOnPaint(Sender: TObject);
  private
    procedure NewOnDestroy(Sender: TObject);
end;

TOLEditHelper = class helper for TEdit
  procedure Link(var i: OLInteger; const Alignment: TAlignment=taRightJustify); overload;
  procedure Link(var d: OLDouble); overload;
  procedure Link(var curr: OLCurrency); overload;
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

TOLLableHelper = class helper for TLabel
  procedure Link(var i: OLInteger); overload;
  procedure Link(const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
  procedure Link(var s: OLString); overload;
  procedure Link(const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
  procedure Link(var d: OLDouble); overload;
  procedure Link(const f: TFunctionReturningOLDouble; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
  procedure Link(var curr: OLCurrency); overload;
  procedure Link(const f: TFunctionReturningOLCurrency; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
  procedure Link(var d: OLDate); overload;
  procedure Link(const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
  procedure Link(var d: OLDateTime); overload;
  procedure Link(const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
end;

implementation

uses
  Vcl.Controls;

{ TOLFormHelper }

var
  Links: TOLTypesToControlsLinks;
  TimerManager: TFormTimerManager;

procedure EnsureTimer(Control: TControl);
var
  f: TForm;
begin
  f := GetParentForm(Control) as TForm;
  TimerManager.EnsureTimer(f);
  f.OnDestroy := f.NewOnDestroy;
end;

{ TOLFormHelper }

procedure TOLFormHelper.Link(const Edit: TEdit; var s: OLString);
begin
  EnsureTimer(Edit);
  Links.Link(Edit, s);
end;

procedure TOLFormHelper.Link(const Edit: TMemo; var s: OLString);
begin
  EnsureTimer(Edit);
  Links.Link(Edit, s);
end;

procedure TOLFormHelper.Link(const Edit: TDateTimePicker; var d: OLDate);
begin
  EnsureTimer(Edit);
  Links.Link(Edit, d);
end;

procedure TOLFormHelper.Link(const Edit: TDateTimePicker; var d: OLDateTime);
begin
  EnsureTimer(Edit);
  Links.Link(Edit, d);
end;

procedure TOLFormHelper.Link(const Edit: TCheckBox; var b: OLBoolean);
begin
  EnsureTimer(Edit);
  Links.Link(Edit, b);
end;

procedure TOLFormHelper.Link(const Edit: TEdit; var curr: OLCurrency; const
    Alignment: TAlignment=taRightJustify);
begin
  EnsureTimer(Edit);

  Links.Link(Edit, curr, Alignment);
end;

procedure TOLFormHelper.Link(const Edit: TEdit; var i: OLInteger; const Alignment: TAlignment=taRightJustify);
begin
  EnsureTimer(Edit);

  Links.Link(Edit, i, Alignment);
end;

procedure TOLFormHelper.Link(const Edit: TSpinEdit; var i: OLInteger);
begin
  EnsureTimer(Edit);

  Links.Link(Edit, i);
end;

procedure TOLFormHelper.Link(const Edit: TTrackBar; var i: OLInteger);
begin
  EnsureTimer(Edit);

  Links.Link(Edit, i);
end;

procedure TOLFormHelper.Link(const Edit: TScrollBar; var i: OLInteger);
begin
  EnsureTimer(Edit);

  Links.Link(Edit, i);
end;

procedure TOLFormHelper.Link(const Edit: TEdit; var d: OLDouble; const
    Alignment: TAlignment=taRightJustify);
begin
  EnsureTimer(Edit);

  Links.Link(Edit, d, Alignment);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var i: OLInteger);
begin
  EnsureTimer(Lbl);
  Links.Link(Lbl, i);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLCurrency; const ValueOnErrorInCalculation: string);
begin
  EnsureTimer(Lbl);
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var d: OLDate);
begin
  EnsureTimer(Lbl);
  Links.Link(Lbl, d);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
begin
  EnsureTimer(Lbl);
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var d: OLDateTime);
begin
  EnsureTimer(Lbl);
  Links.Link(Lbl, d);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
begin
  EnsureTimer(Lbl);
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.NewOnPaint(Sender: TObject);
begin
  // This method is deprecated and replaced by TimerManager
end;

procedure TOLFormHelper.NewOnDestroy(Sender: TObject);
begin
  RemoveLinks();
  TimerManager.OnFormDestroy(Sender);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var curr: OLCurrency);
begin
  EnsureTimer(Lbl);
  Links.Link(Lbl, curr);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string);
begin
  EnsureTimer(Lbl);
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var s: OLString);
begin
  EnsureTimer(Lbl);
  Links.Link(Lbl, s);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string);
begin
  EnsureTimer(Lbl);
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLDouble; const ValueOnErrorInCalculation: string);
begin
  EnsureTimer(Lbl);
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var d: OLDouble);
begin
  EnsureTimer(Lbl);
  Links.Link(Lbl, d);
end;

procedure TOLFormHelper.RefreshControls;
begin
  Links.RefreshControls(Self);
end;

procedure TOLFormHelper.RemoveLinks;
begin
  Links.RemoveLinks(Self);
end;

{ TOLEditHelper }

procedure TOLEditHelper.Link(var i: OLInteger; const Alignment:
    TAlignment=taRightJustify);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  F.Link(Self, i, Alignment);
end;

procedure TOLEditHelper.Link(var d: OLDouble);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  F.Link(Self, d);
end;

procedure TOLEditHelper.Link(var curr: OLCurrency);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  F.Link(Self, curr);
end;

procedure TOLEditHelper.Link(var s: OLString);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  F.Link(Self, s);
end;

{ TOLSpinEditHelper }

procedure TOLSpinEditHelper.Link(var i: OLInteger);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  F.Link(Self, i);
end;

{ TOLTrackBarHelper }

procedure TOLTrackBarHelper.Link(var i: OLInteger);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  F.Link(Self, i);
end;

{ TOLScrollBarHelper }

procedure TOLScrollBarHelper.Link(var i: OLInteger);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  F.Link(Self, i);
end;

{ TOLMemoHelper }

procedure TOLMemoHelper.Link(var s: OLString);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  F.Link(Self, s);
end;

{ TOLDateTimePickerHelper }

procedure TOLDateTimePickerHelper.Link(var d: OLDateTime);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  F.Link(Self, d);
end;

procedure TOLDateTimePickerHelper.Link(var d: OLDate);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  F.Link(Self, d);
end;

{ TOLCheckBoxHelper }

procedure TOLCheckBoxHelper.Link(var b: OLBoolean);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  F.Link(Self, b);
end;

{ TOLLableHelper }

procedure TOLLableHelper.Link(const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  Frm.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLableHelper.Link(var d: OLDouble);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  Frm.Link(Self, d);
end;

procedure TOLLableHelper.Link(const f: TFunctionReturningOLDouble; const ValueOnErrorInCalculation: string);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  Frm.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLableHelper.Link(var i: OLInteger);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  Frm.Link(Self, i);
end;

procedure TOLLableHelper.Link(const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  Frm.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLableHelper.Link(var s: OLString);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  Frm.Link(Self, s);
end;

procedure TOLLableHelper.Link(const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  Frm.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLableHelper.Link(var d: OLDateTime);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  Frm.Link(Self, d);
end;

procedure TOLLableHelper.Link(const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  Frm.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLableHelper.Link(var curr: OLCurrency);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  Frm.Link(Self, curr);
end;

procedure TOLLableHelper.Link(const f: TFunctionReturningOLCurrency; const ValueOnErrorInCalculation: string);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  Frm.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLableHelper.Link(var d: OLDate);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  Frm.Link(Self, d);
end;

{ TFormsOriginalEvents }

{ TFormTimerManager }

type
  TRefreshTimer = class(TTimer)
  public
    Form: TForm;
  end;

constructor TFormTimerManager.Create;
begin
  FMap := TDictionary<TForm, TTimer>.Create;
  FOriginalOnDestroys := TDictionary<TForm, TNotifyEvent>.Create;
end;

destructor TFormTimerManager.Destroy;
begin
  FMap.Free;
  FOriginalOnDestroys.Free;
  inherited;
end;

procedure TFormTimerManager.EnsureTimer(Form: TForm);
var
  T: TRefreshTimer;
begin
  if not FMap.ContainsKey(Form) then
  begin
    T := TRefreshTimer.Create(nil);
    T.Form := Form;
    T.Interval := 100;
    T.OnTimer := OnTimer;
    FMap.Add(Form, T);

    if Assigned(Form.OnDestroy) and (TMethod(Form.OnDestroy).Code <> TMethod(Form.NewOnDestroy).Code) then
      FOriginalOnDestroys.Add(Form, Form.OnDestroy);
  end;
end;

procedure TFormTimerManager.OnFormDestroy(Sender: TObject);
var
  Form: TForm;
  OriginalOnDestroy: TNotifyEvent;
begin
  Form := Sender as TForm;
  RemoveForm(Form);

  if FOriginalOnDestroys.TryGetValue(Form, OriginalOnDestroy) then
  begin
    FOriginalOnDestroys.Remove(Form);
    if Assigned(OriginalOnDestroy) then
      OriginalOnDestroy(Sender);
  end;
end;

procedure TFormTimerManager.OnTimer(Sender: TObject);
var
  T: TRefreshTimer;
begin
  T := Sender as TRefreshTimer;
  if Assigned(T.Form) then
    Links.RefreshControls(T.Form);
end;

procedure TFormTimerManager.RemoveForm(Form: TForm);
var
  T: TTimer;
begin
  if FMap.TryGetValue(Form, T) then
  begin
    T.Enabled := False;
    T.Free;
    FMap.Remove(Form);
  end;
end;

initialization
  TimerManager := TFormTimerManager.Create;

finalization
  TimerManager.Free;

end.
