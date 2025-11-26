unit OLFormHelper;

interface

uses
  Vcl.Forms, Vcl.StdCtrls, System.SysUtils, Vcl.Samples.Spin, Vcl.ComCtrls,
  OLTypes, OLTypesToEdits, System.Classes, System.Generics.Collections, Vcl.ExtCtrls,
  Vcl.Controls;

type

  TOLFormHelper = class helper for TForm
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

    procedure RefreshControls();
    procedure RemoveLinks();
  end;

  TOLControlHelper = class helper for TControl
    procedure Link(var i: OLInteger; const Alignment: TAlignment=taRightJustify); overload;
    procedure Link(var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify); overload;
    procedure Link(var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify); overload;
    procedure Link(var s: OLString); overload;
    procedure Link(var d: OLDate); overload;
    procedure Link(var d: OLDateTime); overload;
    procedure Link(var b: OLBoolean); overload;

    // Calculation links (Label only)
    procedure Link(const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const f: TFunctionReturningOLDouble; const Format: string = DOUBLE_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const f: TFunctionReturningOLCurrency; const Format: string = CURRENCY_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    procedure Link(const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
  end;

implementation

{ TOLFormHelper }

procedure TOLFormHelper.Link(const Edit: TEdit; var s: OLString);
begin
  Links.Link(Edit, s);
end;

procedure TOLFormHelper.Link(const Edit: TMemo; var s: OLString);
begin
  Links.Link(Edit, s);
end;

procedure TOLFormHelper.Link(const Edit: TDateTimePicker; var d: OLDate);
begin
  Links.Link(Edit, d);
end;

procedure TOLFormHelper.Link(const Edit: TDateTimePicker; var d: OLDateTime);
begin
  Links.Link(Edit, d);
end;

procedure TOLFormHelper.Link(const Edit: TCheckBox; var b: OLBoolean);
begin
  Links.Link(Edit, b);
end;

procedure TOLFormHelper.Link(const Edit: TEdit; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const
    Alignment: TAlignment=taRightJustify);
begin
  Links.Link(Edit, curr, Format, Alignment);
end;

procedure TOLFormHelper.Link(const Edit: TEdit; var i: OLInteger; const Alignment: TAlignment=taRightJustify);
begin
  Links.Link(Edit, i, Alignment);
end;

procedure TOLFormHelper.Link(const Edit: TSpinEdit; var i: OLInteger);
begin
  Links.Link(Edit, i);
end;

procedure TOLFormHelper.Link(const Edit: TTrackBar; var i: OLInteger);
begin
  Links.Link(Edit, i);
end;

procedure TOLFormHelper.Link(const Edit: TScrollBar; var i: OLInteger);
begin
  Links.Link(Edit, i);
end;

procedure TOLFormHelper.Link(const Edit: TEdit; var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify);
begin
  Links.Link(Edit, d, Format, Alignment);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var i: OLInteger);
begin
  Links.Link(Lbl, i);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f:
    TFunctionReturningOLCurrency; const Format: string = CURRENCY_FORMAT; const
    ValueOnErrorInCalculation: string = ERROR_STRING);
begin
  Links.Link(Lbl, f, Format, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var d: OLDate);
begin
  Links.Link(Lbl, d);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
begin
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var d: OLDateTime);
begin
  Links.Link(Lbl, d);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
begin
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var curr: OLCurrency; const
    Format: string = CURRENCY_FORMAT);
begin
  Links.Link(Lbl, curr, Format);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string);
begin
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var s: OLString);
begin
  Links.Link(Lbl, s);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string);
begin
  Links.Link(Lbl, f, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; const f:
    TFunctionReturningOLDouble; const Format: string = DOUBLE_FORMAT; const
    ValueOnErrorInCalculation: string = ERROR_STRING);
begin
  Links.Link(Lbl, f, Format, ValueOnErrorInCalculation);
end;

procedure TOLFormHelper.Link(const Lbl: TLabel; var d: OLDouble; const Format:
    string = DOUBLE_FORMAT);
begin
  Links.Link(Lbl, d, Format);
end;

procedure TOLFormHelper.RefreshControls;
begin
  Links.RefreshControls(Self);
end;

procedure TOLFormHelper.RemoveLinks;
begin
  Links.RemoveLinks(Self);
end;

{ TOLControlHelper }

procedure TOLControlHelper.Link(var i: OLInteger; const Alignment: TAlignment);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  if not Assigned(F) then Exit;

  if Self is TEdit then
    F.Link(TEdit(Self), i, Alignment)
  else if Self is TSpinEdit then
    F.Link(TSpinEdit(Self), i)
  else if Self is TTrackBar then
    F.Link(TTrackBar(Self), i)
  else if Self is TScrollBar then
    F.Link(TScrollBar(Self), i)
  else if Self is TLabel then
    F.Link(TLabel(Self), i);
end;

procedure TOLControlHelper.Link(var d: OLDouble; const Format: string; const Alignment: TAlignment);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  if not Assigned(F) then Exit;

  if Self is TEdit then
    F.Link(TEdit(Self), d, Format, Alignment)
  else if Self is TLabel then
    F.Link(TLabel(Self), d, Format);
end;

procedure TOLControlHelper.Link(var curr: OLCurrency; const Format: string; const Alignment: TAlignment);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  if not Assigned(F) then Exit;

  if Self is TEdit then
    F.Link(TEdit(Self), curr, Format, Alignment)
  else if Self is TLabel then
    F.Link(TLabel(Self), curr, Format);
end;

procedure TOLControlHelper.Link(var s: OLString);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  if not Assigned(F) then Exit;

  if Self is TEdit then
    F.Link(TEdit(Self), s)
  else if Self is TMemo then
    F.Link(TMemo(Self), s)
  else if Self is TLabel then
    F.Link(TLabel(Self), s);
end;

procedure TOLControlHelper.Link(var d: OLDate);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  if not Assigned(F) then Exit;

  if Self is TDateTimePicker then
    F.Link(TDateTimePicker(Self), d)
  else if Self is TLabel then
    F.Link(TLabel(Self), d);
end;

procedure TOLControlHelper.Link(var d: OLDateTime);
var
  F: TForm;
begin
  F := GetParentForm(Self) as TForm;
  if not Assigned(F) then Exit;

  if Self is TDateTimePicker then
    F.Link(TDateTimePicker(Self), d)
  else if Self is TLabel then
    F.Link(TLabel(Self), d);
end;

procedure TOLControlHelper.Link(var b: OLBoolean);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  if not Assigned(Frm) then Exit;

  if Self is TCheckBox then
    Frm.Link(TCheckBox(Self), b);
end;

procedure TOLControlHelper.Link(const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  if not Assigned(Frm) then Exit;

  if Self is TLabel then
    Frm.Link(TLabel(Self), f, ValueOnErrorInCalculation);
end;

procedure TOLControlHelper.Link(const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  if not Assigned(Frm) then Exit;

  if Self is TLabel then
    Frm.Link(TLabel(Self), f, ValueOnErrorInCalculation);
end;

procedure TOLControlHelper.Link(const f: TFunctionReturningOLDouble; const Format: string; const ValueOnErrorInCalculation: string);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  if not Assigned(Frm) then Exit;

  if Self is TLabel then
    Frm.Link(TLabel(Self), f, Format, ValueOnErrorInCalculation);
end;

procedure TOLControlHelper.Link(const f: TFunctionReturningOLCurrency; const Format: string; const ValueOnErrorInCalculation: string);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  if not Assigned(Frm) then Exit;

  if Self is TLabel then
    Frm.Link(TLabel(Self), f, Format, ValueOnErrorInCalculation);
end;

procedure TOLControlHelper.Link(const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  if not Assigned(Frm) then Exit;

  if Self is TLabel then
    Frm.Link(TLabel(Self), f, ValueOnErrorInCalculation);
end;

procedure TOLControlHelper.Link(const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
var
  Frm: TForm;
begin
  Frm := GetParentForm(Self) as TForm;
  if not Assigned(Frm) then Exit;

  if Self is TLabel then
    Frm.Link(TLabel(Self), f, ValueOnErrorInCalculation);
end;

initialization

finalization

end.
