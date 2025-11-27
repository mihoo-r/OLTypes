unit OLFormHelper;

interface

uses
   Vcl.Forms, Vcl.StdCtrls, System.SysUtils, Vcl.Samples.Spin, Vcl.ComCtrls,
   OLTypes, System.Classes, System.Generics.Collections, Vcl.ExtCtrls,
   Vcl.Controls;

type

  TOLFormHelper = class helper for TForm
    procedure RefreshControls();
    procedure RemoveLinks();
  end;

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

{ TOLFormHelper }

procedure TOLFormHelper.RefreshControls;
begin
  Links.RefreshControls(Self);
end;

procedure TOLFormHelper.RemoveLinks;
begin
  Links.RemoveLinks(Self);
end;

{ TOLEditHelper }

procedure TOLEditHelper.Link(var i: OLInteger; const Alignment: TAlignment);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, i, Alignment);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TEdit: ' + E.Message);
  end;
end;

procedure TOLEditHelper.Link(var d: OLDouble; const Format: string; const Alignment: TAlignment);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, d, Format, Alignment);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TEdit: ' + E.Message);
  end;
end;

procedure TOLEditHelper.Link(var curr: OLCurrency; const Format: string; const Alignment: TAlignment);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, curr, Format, Alignment);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TEdit: ' + E.Message);
  end;
end;

procedure TOLEditHelper.Link(var s: OLString);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
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
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
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
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, i);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TTrackBar: ' + E.Message);
  end;
end;

{ TOLScrollBarHelper }

procedure TOLScrollBarHelper.Link(var i: OLInteger);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, i);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TScrollBar: ' + E.Message);
  end;
end;

{ TOLMemoHelper }

procedure TOLMemoHelper.Link(var s: OLString);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, s);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TMemo: ' + E.Message);
  end;
end;

{ TOLDateTimePickerHelper }

procedure TOLDateTimePickerHelper.Link(var d: OLDate);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, d);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TDateTimePicker: ' + E.Message);
  end;
end;

procedure TOLDateTimePickerHelper.Link(var d: OLDateTime);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, d);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TDateTimePicker: ' + E.Message);
  end;
end;

{ TOLCheckBoxHelper }

procedure TOLCheckBoxHelper.Link(var b: OLBoolean);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, b);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TCheckBox: ' + E.Message);
  end;
end;

{ TOLLabelHelper }

procedure TOLLabelHelper.Link(var i: OLInteger);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, i);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TLabel: ' + E.Message);
  end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  if not Assigned(f) then
    raise Exception.Create('Function is nil.');
  try
    Links.Link(Self, f, ValueOnErrorInCalculation);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TLabel: ' + E.Message);
  end;
end;

procedure TOLLabelHelper.Link(var s: OLString);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, s);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TLabel: ' + E.Message);
  end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  if not Assigned(f) then
    raise Exception.Create('Function is nil.');
  try
    Links.Link(Self, f, ValueOnErrorInCalculation);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TLabel: ' + E.Message);
  end;
end;

procedure TOLLabelHelper.Link(var d: OLDouble; const Format: string);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, d, Format);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TLabel: ' + E.Message);
  end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDouble; const Format: string; const ValueOnErrorInCalculation: string);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  if not Assigned(f) then
    raise Exception.Create('Function is nil.');
  try
    Links.Link(Self, f, Format, ValueOnErrorInCalculation);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TLabel: ' + E.Message);
  end;
end;

procedure TOLLabelHelper.Link(var curr: OLCurrency; const Format: string);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, curr, Format);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TLabel: ' + E.Message);
  end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLCurrency; const Format: string; const ValueOnErrorInCalculation: string);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  if not Assigned(f) then
    raise Exception.Create('Function is nil.');
  try
    Links.Link(Self, f, Format, ValueOnErrorInCalculation);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TLabel: ' + E.Message);
  end;
end;

procedure TOLLabelHelper.Link(var d: OLDate);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, d);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TLabel: ' + E.Message);
  end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  if not Assigned(f) then
    raise Exception.Create('Function is nil.');
  try
    Links.Link(Self, f, ValueOnErrorInCalculation);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TLabel: ' + E.Message);
  end;
end;

procedure TOLLabelHelper.Link(var d: OLDateTime);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  try
    Links.Link(Self, d);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TLabel: ' + E.Message);
  end;
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
begin
  if not Assigned(Self) then
    raise Exception.Create('Control is nil.');
  if not Assigned(f) then
    raise Exception.Create('Function is nil.');
  try
    Links.Link(Self, f, ValueOnErrorInCalculation);
  except
    on E: Exception do
      raise Exception.Create('Link failed for TLabel: ' + E.Message);
  end;
end;

end.
