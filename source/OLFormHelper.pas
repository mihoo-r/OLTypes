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
  Links.Link(Self, i, Alignment);
end;

procedure TOLEditHelper.Link(var d: OLDouble; const Format: string; const Alignment: TAlignment);
begin
  Links.Link(Self, d, Format, Alignment);
end;

procedure TOLEditHelper.Link(var curr: OLCurrency; const Format: string; const Alignment: TAlignment);
begin
  Links.Link(Self, curr, Format, Alignment);
end;

procedure TOLEditHelper.Link(var s: OLString);
begin
  Links.Link(Self, s);
end;

{ TOLSpinEditHelper }

procedure TOLSpinEditHelper.Link(var i: OLInteger);
begin
  Links.Link(Self, i);
end;

{ TOLTrackBarHelper }

procedure TOLTrackBarHelper.Link(var i: OLInteger);
begin
  Links.Link(Self, i);
end;

{ TOLScrollBarHelper }

procedure TOLScrollBarHelper.Link(var i: OLInteger);
begin
  Links.Link(Self, i);
end;

{ TOLMemoHelper }

procedure TOLMemoHelper.Link(var s: OLString);
begin
  Links.Link(Self, s);
end;

{ TOLDateTimePickerHelper }

procedure TOLDateTimePickerHelper.Link(var d: OLDate);
begin
  Links.Link(Self, d);
end;

procedure TOLDateTimePickerHelper.Link(var d: OLDateTime);
begin
  Links.Link(Self, d);
end;

{ TOLCheckBoxHelper }

procedure TOLCheckBoxHelper.Link(var b: OLBoolean);
begin
  Links.Link(Self, b);
end;

{ TOLLabelHelper }

procedure TOLLabelHelper.Link(var i: OLInteger);
begin
  Links.Link(Self, i);
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string);
begin
  Links.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var s: OLString);
begin
  Links.Link(Self, s);
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string);
begin
  Links.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var d: OLDouble; const Format: string);
begin
  Links.Link(Self, d, Format);
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDouble; const Format: string; const ValueOnErrorInCalculation: string);
begin
  Links.Link(Self, f, Format, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var curr: OLCurrency; const Format: string);
begin
  Links.Link(Self, curr, Format);
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLCurrency; const Format: string; const ValueOnErrorInCalculation: string);
begin
  Links.Link(Self, f, Format, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var d: OLDate);
begin
  Links.Link(Self, d);
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
begin
  Links.Link(Self, f, ValueOnErrorInCalculation);
end;

procedure TOLLabelHelper.Link(var d: OLDateTime);
begin
  Links.Link(Self, d);
end;

procedure TOLLabelHelper.Link(const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
begin
  Links.Link(Self, f, ValueOnErrorInCalculation);
end;

end.
