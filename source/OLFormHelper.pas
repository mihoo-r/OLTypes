unit OLFormHelper;

interface

uses
  Vcl.Forms, Vcl.StdCtrls, System.SysUtils, Vcl.Samples.Spin, Vcl.ComCtrls,
  OLTypes, OLTypesToEdits, System.Classes, System.Generics.Collections, Vcl.ExtCtrls,
  Vcl.Controls;

type

  TOLFormHelper = class helper for TForm
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
begin
  if Self is TEdit then
    Links.Link(TEdit(Self), i, Alignment)
  else if Self is TSpinEdit then
    Links.Link(TSpinEdit(Self), i)
  else if Self is TTrackBar then
    Links.Link(TTrackBar(Self), i)
  else if Self is TScrollBar then
    Links.Link(TScrollBar(Self), i)
  else if Self is TLabel then
    Links.Link(TLabel(Self), i);
end;

procedure TOLControlHelper.Link(var d: OLDouble; const Format: string; const Alignment: TAlignment);
begin
  if Self is TEdit then
    Links.Link(TEdit(Self), d, Format, Alignment)
  else if Self is TLabel then
    Links.Link(TLabel(Self), d, Format);
end;

procedure TOLControlHelper.Link(var curr: OLCurrency; const Format: string; const Alignment: TAlignment);
begin
  if Self is TEdit then
    Links.Link(TEdit(Self), curr, Format, Alignment)
  else if Self is TLabel then
    Links.Link(TLabel(Self), curr, Format);
end;

procedure TOLControlHelper.Link(var s: OLString);
begin
  if Self is TEdit then
    Links.Link(TEdit(Self), s)
  else if Self is TMemo then
    Links.Link(TMemo(Self), s)
  else if Self is TLabel then
    Links.Link(TLabel(Self), s);
end;

procedure TOLControlHelper.Link(var d: OLDate);
begin
  if Self is TDateTimePicker then
    Links.Link(TDateTimePicker(Self), d)
  else if Self is TLabel then
    Links.Link(TLabel(Self), d);
end;

procedure TOLControlHelper.Link(var d: OLDateTime);
begin
  if Self is TDateTimePicker then
    Links.Link(TDateTimePicker(Self), d)
  else if Self is TLabel then
    Links.Link(TLabel(Self), d);
end;

procedure TOLControlHelper.Link(var b: OLBoolean);
begin
  if Self is TCheckBox then
    Links.Link(TCheckBox(Self), b);
end;

procedure TOLControlHelper.Link(const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string);
begin
  if Self is TLabel then
    Links.Link(TLabel(Self), f, ValueOnErrorInCalculation);
end;

procedure TOLControlHelper.Link(const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string);
begin
  if Self is TLabel then
    Links.Link(TLabel(Self), f, ValueOnErrorInCalculation);
end;

procedure TOLControlHelper.Link(const f: TFunctionReturningOLDouble; const Format: string; const ValueOnErrorInCalculation: string);
begin
  if Self is TLabel then
    Links.Link(TLabel(Self), f, Format, ValueOnErrorInCalculation);
end;

procedure TOLControlHelper.Link(const f: TFunctionReturningOLCurrency; const Format: string; const ValueOnErrorInCalculation: string);
begin
  if Self is TLabel then
    Links.Link(TLabel(Self), f, Format, ValueOnErrorInCalculation);
end;

procedure TOLControlHelper.Link(const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
begin
  if Self is TLabel then
    Links.Link(TLabel(Self), f, ValueOnErrorInCalculation);
end;

procedure TOLControlHelper.Link(const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
begin
  if Self is TLabel then
    Links.Link(TLabel(Self), f, ValueOnErrorInCalculation);
end;

end.
