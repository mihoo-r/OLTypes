unit OLFormHelper;

interface

uses
  Vcl.Forms, Vcl.StdCtrls, System.SysUtils, Vcl.Samples.Spin, Vcl.ComCtrls,
  OLTypes, OLTypesToEdits, System.Classes;

type

TFormsOriginalEvents = record
  strict private
    Forms: array of TForm;
    OnPaints: array of TNotifyEvent;
    OnDestroys: array of TNotifyEvent;
    function FormIndex(Form: TForm): Integer;
  public
   procedure Add(Form: TForm);
   function GetOnPaint(Form: TForm): TNotifyEvent;
   function GetOnDestroy(Form: TForm): TNotifyEvent;
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
  FormsOriginalEvents: TFormsOriginalEvents;

procedure ReplaceFormsOnPaint(Control: TControl);
var
  f: TForm;
begin
  f := GetParentForm(Control) as TForm;
  FormsOriginalEvents.Add(f);
  f.OnPaint := f.NewOnPaint;
  f.OnDestroy := f.NewOnDestroy;
end;

{ TOLFormHelper }

procedure TOLFormHelper.Link(const Edit: TEdit; var s: OLString);
begin
  ReplaceFormsOnPaint(Edit);
  Links.Link(Edit, s);
end;

procedure TOLFormHelper.Link(const Edit: TMemo; var s: OLString);
begin
  ReplaceFormsOnPaint(Edit);
  Links.Link(Edit, s);
end;

procedure TOLFormHelper.Link(const Edit: TDateTimePicker; var d: OLDate);
begin
  ReplaceFormsOnPaint(Edit);
  Links.Link(Edit, d);
end;

procedure TOLFormHelper.Link(const Edit: TDateTimePicker; var d: OLDateTime);
begin
  ReplaceFormsOnPaint(Edit);
  Links.Link(Edit, d);
end;

procedure TOLFormHelper.Link(const Edit: TCheckBox; var b: OLBoolean);
begin
  ReplaceFormsOnPaint(Edit);
  Links.Link(Edit, b);
end;

procedure TOLFormHelper.Link(const Edit: TEdit; var curr: OLCurrency; const
    Alignment: TAlignment=taRightJustify);
begin
  ReplaceFormsOnPaint(Edit);

  Links.Link(Edit, curr, Alignment);
end;

procedure TOLFormHelper.Link(const Edit: TEdit; var i: OLInteger; const Alignment: TAlignment=taRightJustify);
begin
  ReplaceFormsOnPaint(Edit);

  Links.Link(Edit, i, Alignment);
end;

procedure TOLFormHelper.Link(const Edit: TSpinEdit; var i: OLInteger);
begin
  ReplaceFormsOnPaint(Edit);

  Links.Link(Edit, i);
end;

procedure TOLFormHelper.Link(const Edit: TTrackBar; var i: OLInteger);
begin
  ReplaceFormsOnPaint(Edit);

  Links.Link(Edit, i);
end;

procedure TOLFormHelper.Link(const Edit: TScrollBar; var i: OLInteger);
begin
  ReplaceFormsOnPaint(Edit);

  Links.Link(Edit, i);
end;

procedure TOLFormHelper.Link(const Edit: TEdit; var d: OLDouble; const
    Alignment: TAlignment=taRightJustify);
begin
  ReplaceFormsOnPaint(Edit);

  Links.Link(Edit, d, Alignment);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var i: OLInteger);
begin
  ReplaceFormsOnPaint(Lbl);
  Links.Link(Lbl, i);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLCurrency; const ValueOnErrorInCalculation: string);
begin
  ReplaceFormsOnPaint(Lbl);
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var d: OLDate);
begin
  ReplaceFormsOnPaint(Lbl);
  Links.Link(Lbl, d);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
begin
  ReplaceFormsOnPaint(Lbl);
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var d: OLDateTime);
begin
  ReplaceFormsOnPaint(Lbl);
  Links.Link(Lbl, d);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
begin
  ReplaceFormsOnPaint(Lbl);
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.NewOnPaint(Sender: TObject);
var
 OriginalOnPaint: TNotifyEvent;
begin
  OriginalOnPaint := FormsOriginalEvents.GetOnPaint(Self);

  if Assigned(OriginalOnPaint) then
    OriginalOnPaint(Sender);

  RefreshControls();
end;

procedure TOLFormHelper.NewOnDestroy(Sender: TObject);
var
 OriginalOnDestroy: TNotifyEvent;
begin
  RemoveLinks();

  OriginalOnDestroy := FormsOriginalEvents.GetOnDestroy(Self);

  if Assigned(OriginalOnDestroy) then
    OriginalOnDestroy(Sender);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var curr: OLCurrency);
begin
  ReplaceFormsOnPaint(Lbl);
  Links.Link(Lbl, curr);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string);
begin
  ReplaceFormsOnPaint(Lbl);
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var s: OLString);
begin
  ReplaceFormsOnPaint(Lbl);
  Links.Link(Lbl, s);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string);
begin
  ReplaceFormsOnPaint(Lbl);
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLDouble; const ValueOnErrorInCalculation: string);
begin
  ReplaceFormsOnPaint(Lbl);
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var d: OLDouble);
begin
  ReplaceFormsOnPaint(Lbl);
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

procedure TFormsOriginalEvents.Add(Form: TForm);
var
  idx, i: Integer;
begin
  idx := FormIndex(Form);

  if idx = -1 then
  begin
    i := Length(Forms);

    SetLength(Forms, i + 1);
    SetLength(OnPaints, i + 1);
    SetLength(OnDestroys, i + 1);

    Forms[i] := Form;
    OnPaints[i] := Form.OnPaint;
    OnDestroys[i] := Form.OnDestroy;
  end;
end;

function TFormsOriginalEvents.FormIndex(Form: TForm): Integer;
var
  i: Integer;
  Output: Integer;
begin
  Output := -1;

  for i := 0 to Length(Forms) - 1 do
  begin
    if Forms[i] = Form then
      Output := i;
  end;

  Result := Output;
end;

function TFormsOriginalEvents.GetOnDestroy(Form: TForm): TNotifyEvent;
var
  idx: Integer;
  Output: TNotifyEvent;
begin
  idx := FormIndex(Form);

  if idx > -1 then
    Output := OnDestroys[idx];

  Result := Output;
end;

function TFormsOriginalEvents.GetOnPaint(Form: TForm): TNotifyEvent;
var
  idx: Integer;
  Output: TNotifyEvent;
begin
  idx := FormIndex(Form);

  if idx > -1 then
    Output := OnPaints[idx];

  Result := Output;
end;

end.
