unit OLTypesToEdits;

interface

uses OLTypes, OLValidation, {$IF CompilerVersion >= 23.0} System.Generics.Collections, {$ELSE} Generics.Collections, {$IFEND}
  {$IF CompilerVersion >= 23.0}
  Vcl.StdCtrls, System.SysUtils, Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.Forms,
  System.Classes, Vcl.Controls, Messages, Winapi.Windows, Vcl.ExtCtrls,
  Vcl.Graphics, OLBooleanType;
  {$ELSE}
  StdCtrls, SysUtils, Spin, ComCtrls, Forms, Classes, Controls, Messages, Windows, ExtCtrls, Graphics;
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

  TOLControlLink = class(TComponent)
  private
    FControl: TControl;
  public
    constructor Create; reintroduce;
    procedure RefreshControl; virtual; abstract;
    function NeedsTimer: Boolean; virtual;
    procedure ShowValidationState(vr: TOLValidationResult); virtual;
    property Control: TControl read FControl write FControl;
  end;

  {$IF CompilerVersion >= 34.0}
  TOLValidationFunction<T> = reference to function(val: T): TOLValidationResult;
  {$IFEND}

  TOLEditLink<T> = class(TOLControlLink)
  private
  protected
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FEditOnExit: TNotifyEvent;
    FOLPointer: ^T;
    FOriginalColor: TColor;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;
    FUpdatingFromControl: Boolean;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLValidationFunction<T>;
    {$IFEND}

    function ValToString(const v: T): string; virtual; abstract;
    function StringToVal(const s: string; out v: T): Boolean; virtual; abstract;
    function GetNull: T; virtual; abstract;
    function TreatEmptyAsNull: Boolean; virtual;
    function IsPartialEntry(const s: string): Boolean; virtual;

    procedure SetEdit(const Value: TEdit); virtual;
    function GetOLPointer: Pointer;
    procedure SetOLPointer(const Value: Pointer);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLValidationFunction<T>);
    procedure SetValueAfterValidation(const v: T);
    {$IFEND}

    procedure NewOnChange(Sender: TObject);
    procedure NewOnExit(Sender: TObject);

  public
    constructor Create;
    destructor Destroy; override;
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(const v: T): TOLValidationResult; virtual;
    property ValidationFunction: TOLValidationFunction<T> read FValidationFunction write SetValidationFunction;
    {$IFEND}
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: Pointer read GetOLPointer write SetOLPointer;
  end;

  TEditToOLInteger = class(TOLEditLink<OLInteger>)
  protected
    function ValToString(const v: OLInteger): string; override;
    function StringToVal(const s: string; out v: OLInteger): Boolean; override;
    function GetNull: OLInteger; override;
    function TreatEmptyAsNull: Boolean; override;
    function IsPartialEntry(const s: string): Boolean; override;
  end;

  TSpinEditToOLInteger = class(TOLControlLink)
  private
    FEdit: TSpinEdit;
    FEditOnChange: TEditOnChange;
    FEditOnExit: TNotifyEvent;
    FOLPointer: POLInteger;
    FUpdatingFromControl: Boolean;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLIntegerValidationFunction;
    {$IFEND}
    FOriginalColor: TColor;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;
    procedure NewOnExit(Sender: TObject);
    procedure SetEdit(const Value: TSpinEdit);
    procedure SetOLPointer(const Value: POLInteger);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLIntegerValidationFunction);
    procedure SetValueAfterValidation(i: OLInteger);
    {$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;

    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(i: OLInteger): TOLValidationResult;
    {$IFEND}

    property Edit: TSpinEdit read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;

    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLIntegerValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}

  end;

  TScrollBarToOLInteger = class(TOLControlLink)
  private
    FEdit: TScrollBar;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLIntegerValidationFunction;
    {$IFEND}
    FWarningLabel: TLabel;
    procedure SetEdit(const Value: TScrollBar);
    procedure SetOLPointer(const Value: POLInteger);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLIntegerValidationFunction);
    procedure SetValueAfterValidation(i: OLInteger);
    {$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(i: OLInteger): TOLValidationResult;
    {$IFEND}
    property Edit: TScrollBar read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLIntegerValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TTrackBarToOLInteger = class(TOLControlLink)
  private
    FEdit: TTrackBar;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLIntegerValidationFunction;
    {$IFEND}
    FWarningLabel: TLabel;
    procedure SetEdit(const Value: TTrackBar);
    procedure SetOLPointer(const Value: POLInteger);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLIntegerValidationFunction);
    procedure SetValueAfterValidation(i: OLInteger);
    {$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(i: OLInteger): TOLValidationResult;
    {$IFEND}
    property Edit: TTrackBar read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLIntegerValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TEditToOLDouble = class(TOLControlLink)
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FEditOnExit: TNotifyEvent;
    FOLPointer: POLDouble;
    FUpdatingFromControl: Boolean;
    FFormat: string;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLDoubleValidationFunction;
    {$IFEND}
    FOriginalColor: TColor;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLDouble);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLDoubleValidationFunction);
    procedure SetValueAfterValidation(d: OLDouble);
    {$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure NewOnExit(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult);
    function ValueIsValid(d: OLDouble): TOLValidationResult;
    {$IFEND}
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLDouble read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLDoubleValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TEditToOLCurrency = class(TOLControlLink)
  private
    FEdit: TEdit;
    FEditOnChange: TEditOnChange;
    FEditOnExit: TNotifyEvent;
    FOLPointer: POLCurrency;
    FUpdatingFromControl: Boolean;
    FFormat: string;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLCurrencyValidationFunction;
    {$IFEND}
    FOriginalColor: TColor;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLCurrency);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLCurrencyValidationFunction);
    procedure SetValueAfterValidation(c: OLCurrency);
    {$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure NewOnExit(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult);
    function ValueIsValid(c: OLCurrency): TOLValidationResult;
    {$IFEND}
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLCurrency read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLCurrencyValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TEditToOLString = class(TOLEditLink<OLString>)
  protected
    function ValToString(const v: OLString): string; override;
    function StringToVal(const s: string; out v: OLString): Boolean; override;
    function GetNull: OLString; override;
    function TreatEmptyAsNull: Boolean; override;
  end;


  TMemoToOLString = class(TOLControlLink)
  private
    FEdit: TMemo;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLString;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLStringValidationFunction;
    {$IFEND}
    FOriginalColor: TColor;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;
    procedure SetEdit(const Value: TMemo);
    procedure SetOLPointer(const Value: POLString);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLStringValidationFunction);
    procedure SetValueAfterValidation(s: OLString);
    {$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnChange(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult);
    function ValueIsValid(s: OLString): TOLValidationResult;
    {$IFEND}
    property Edit: TMemo read FEdit write SetEdit;
    property OLPointer: POLString read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLStringValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TDateTimePickerToOLDate = class(TOLControlLink)
  private
    FEdit: TDateTimePicker;
    FEditOnChange: TEditOnChange;
    FEditOnEnter: TEditOnEnter;
    FEditOnKeyPress: TEditOnKeyPress;
    FOLPointer: POLDate;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLDateValidationFunction;
    {$IFEND}
    FWarningLabel: TLabel;
    NotNullFormat: string;
    LastTwoKeys, LastThreeKeys: OLString;
    FOriginalWindowProc: TWndMethod;
    FUpdatingFromRefresh: Boolean;
    FUpdatingFromControl: Boolean;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;

    procedure NewWindowProc(var Message: TMessage);
    procedure SetEdit(const Value: TDateTimePicker);
    procedure SetOLPointer(const Value: POLDate);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLDateValidationFunction);
    procedure SetValueAfterValidation(d: OLDate);
    {$IFEND}
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
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(d: OLDate): TOLValidationResult;
    {$IFEND}
    property Edit: TDateTimePicker read FEdit write SetEdit;
    property OLPointer: POLDate read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLDateValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TDateTimePickerToOLDateTime = class(TOLControlLink)
  private
    FEdit: TDateTimePicker;
    FEditOnChange: TEditOnChange;
    FEditOnEnter: TEditOnEnter;
    FEditOnKeyPress: TEditOnKeyPress;
    FOLPointer: POLDateTime;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLDateTimeValidationFunction;
    {$IFEND}
    FWarningLabel: TLabel;
    NotNullFormat: string;
    LastTwoKeys, LastThreeKeys: OLString;
    FOriginalWindowProc: TWndMethod;
    FUpdatingFromRefresh: Boolean;
    FUpdatingFromControl: Boolean;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;

    procedure NewWindowProc(var Message: TMessage);
    procedure SetEdit(const Value: TDateTimePicker);
    procedure SetOLPointer(const Value: POLDateTime);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLDateTimeValidationFunction);
    procedure SetValueAfterValidation(dt: OLDateTime);
    {$IFEND}
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
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(dt: OLDateTime): TOLValidationResult;
    {$IFEND}
    property Edit: TDateTimePicker read FEdit write SetEdit;
    property OLPointer: POLDateTime read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLDateTimeValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TCheckBoxToOLBoolean = class(TOLControlLink)
  private
    FEdit: TCheckBox;
    FEditOnClick: TEditOnClick;
    FOLPointer: POLBoolean;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLBooleanValidationFunction;
    {$IFEND}
    FOriginalFontColor: TColor;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;
    FWarningLabel: TLabel;
    procedure SetEdit(const Value: TCheckBox);
    procedure SetOLPointer(const Value: POLBoolean);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLBooleanValidationFunction);
    procedure SetValueAfterValidation(b: OLBoolean);
    {$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure NewOnClick(Sender: TObject);
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    {$IF CompilerVersion >= 34.0}
    function ValueIsValid(b: OLBoolean): TOLValidationResult;
    procedure ShowValidationState(vr: TOLValidationResult); override;
    {$IFEND}
    property Edit: TCheckBox read FEdit write SetEdit;
    property OLPointer: POLBoolean read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLBooleanValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TOLIntegerToLabel = class(TOLControlLink)
  private
    FLabel: TLabel;
    FOLPointer: POLInteger;
    FCalculation: TFunctionReturningOLInteger;
    FValueOnErrorInCalculation: OLString;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLIntegerValidationFunction;
    {$IFEND}
    FOriginalFontColor: TColor;
    function NeedsTimer: Boolean;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLInteger);
    procedure SetCalculation(const Value: TFunctionReturningOLInteger);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLIntegerValidationFunction);
    {$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult);
    function ValueIsValid(i: OLInteger): TOLValidationResult;
    {$IFEND}
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLInteger read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLIntegerValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TOLStringToLabel = class(TOLControlLink)
  private
    FLabel: TLabel;
    FOLPointer: POLString;
    FCalculation: TFunctionReturningOLString;
    FValueOnErrorInCalculation: OLString;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLStringValidationFunction;
    {$IFEND}
    FOriginalFontColor: TColor;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLString);
    procedure SetCalculation(const Value: TFunctionReturningOLString);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLStringValidationFunction);
    {$IFEND}
  public
    constructor Create;
    procedure RefreshControl; override;
    function NeedsTimer: Boolean; override;
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult);
    function ValueIsValid(s: OLString): TOLValidationResult;
    {$IFEND}
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLString read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLString read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLStringValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TOLDoubleToLabel = class(TOLControlLink)
  private
    FLabel: TLabel;
    FOLPointer: POLDouble;
    FCalculation: TFunctionReturningOLDouble;
    FValueOnErrorInCalculation: OLString;
    FFormat: string;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLDoubleValidationFunction;
    {$IFEND}
    FOriginalFontColor: TColor;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLDouble);
    procedure SetCalculation(const Value: TFunctionReturningOLDouble);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLDoubleValidationFunction);
    {$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    function NeedsTimer: Boolean; override;
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult);
    function ValueIsValid(d: OLDouble): TOLValidationResult;
    {$IFEND}
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLDouble read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLDouble read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLDoubleValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TOLCurrencyToLabel = class(TOLControlLink)
  private
    FLabel: TLabel;
    FOLPointer: POLCurrency;
    FCalculation: TFunctionReturningOLCurrency;
    FValueOnErrorInCalculation: OLString;
    FFormat: string;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLCurrencyValidationFunction;
    {$IFEND}
    FOriginalFontColor: TColor;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLCurrency);
    procedure SetCalculation(const Value: TFunctionReturningOLCurrency);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLCurrencyValidationFunction);
    {$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    function NeedsTimer: Boolean; override;
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult);
    function ValueIsValid(c: OLCurrency): TOLValidationResult;
    {$IFEND}
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLCurrency read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLCurrency read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLCurrencyValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TOLDateToLabel = class(TOLControlLink)
  private
    FLabel: TLabel;
    FOLPointer: POLDate;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLDateValidationFunction;
    {$IFEND}
    FOriginalFontColor: TColor;
    FCalculation: TFunctionReturningOLDate;
    FValueOnErrorInCalculation: OLString;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLDate);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLDateValidationFunction);
    {$IFEND}
    procedure SetCalculation(const Value: TFunctionReturningOLDate);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
  public
    constructor Create;
    destructor Destroy; override;
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(d: OLDate): TOLValidationResult;
    {$IFEND}
    function NeedsTimer: Boolean; override;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLDate read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLDate read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLDateValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TOLDateTimeToLabel = class(TOLControlLink)
  private
    FLabel: TLabel;
    FOLPointer: POLDateTime;
    {$IF CompilerVersion >= 34.0}
    FValidationFunction: TOLDateTimeValidationFunction;
    {$IFEND}
    FOriginalFontColor: TColor;
    FCalculation: TFunctionReturningOLDateTime;
    FValueOnErrorInCalculation: OLString;
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLDateTime);
    {$IF CompilerVersion >= 34.0}
    procedure SetValidationFunction(const Value: TOLDateTimeValidationFunction);
    {$IFEND}
    procedure SetCalculation(const Value: TFunctionReturningOLDateTime);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
  public
    constructor Create;
    destructor Destroy; override;
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(dt: OLDateTime): TOLValidationResult;
    {$IFEND}
    function NeedsTimer: Boolean; override;
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLDateTime read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLDateTime read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLDateTimeValidationFunction read
        FValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TOLLinkManager = class
  private
    FControlLinks: TDictionary<TForm, TObjectList<TOLControlLink>>;
    FRefreshTimers: TDictionary<TForm, TTimer>;
    FFormCleanupHooks: TDictionary<TForm, TComponent>;
    FValueMulticasters: TDictionary<Pointer, TObject>;  // Maps OLType pointer -> TOLValueMulticaster
    procedure AddLink(Control: TControl; Link: TOLControlLink);
    function DelphiDateTimeFormatToWindowsFormat(const DelphiFormat: OLString): OLString;
  public
    constructor Create;
    destructor Destroy; override;
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Edit: TEdit; var i: OLInteger; const ValidationFunction:
        TOLIntegerValidationFunction = nil; const Alignment: TAlignment=taRightJustify);
        overload;
    {$ELSE}
    procedure Link(const Edit: TEdit; var i: OLInteger; const Alignment: TAlignment=taRightJustify);
        overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Edit: TSpinEdit; var i: OLInteger; const ValidationFunction: TOLIntegerValidationFunction = nil); overload;
    {$ELSE}
    procedure Link(const Edit: TSpinEdit; var i: OLInteger); overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Edit: TTrackBar; var i: OLInteger; const ValidationFunction: TOLIntegerValidationFunction = nil); overload;
    {$ELSE}
    procedure Link(const Edit: TTrackBar; var i: OLInteger); overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Edit: TScrollBar; var i: OLInteger; const ValidationFunction: TOLIntegerValidationFunction = nil); overload;
    {$ELSE}
    procedure Link(const Edit: TScrollBar; var i: OLInteger); overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Edit: TEdit; var d: OLDouble; const ValidationFunction: TOLDoubleValidationFunction = nil; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify); overload;
    {$ELSE}
    procedure Link(const Edit: TEdit; var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify); overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Edit: TEdit; var curr: OLCurrency; const ValidationFunction: TOLCurrencyValidationFunction = nil; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify); overload;
    {$ELSE}
    procedure Link(const Edit: TEdit; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify); overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Edit: TEdit; var s: OLString; const ValidationFunction: TOLStringValidationFunction = nil); overload;
    {$ELSE}
    procedure Link(const Edit: TEdit; var s: OLString); overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Edit: TMemo; var s: OLString; const ValidationFunction: TOLStringValidationFunction = nil); overload;
    {$ELSE}
    procedure Link(const Edit: TMemo; var s: OLString); overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Edit: TDateTimePicker; var d: OLDate; const ValidationFunction: TOLDateValidationFunction = nil); overload;
    {$ELSE}
    procedure Link(const Edit: TDateTimePicker; var d: OLDate); overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Edit: TDateTimePicker; var d: OLDateTime; const ValidationFunction: TOLDateTimeValidationFunction = nil); overload;
    {$ELSE}
    procedure Link(const Edit: TDateTimePicker; var d: OLDateTime); overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Edit: TCheckBox; var b: OLBoolean; const ValidationFunction: TOLBooleanValidationFunction = nil); overload;
    {$ELSE}
    procedure Link(const Edit: TCheckBox; var b: OLBoolean); overload;
    {$IFEND}

    {$IF CompilerVersion >= 34.0}
    procedure Link(const Lbl: TLabel; var i: OLInteger; const ValidationFunction: TOLIntegerValidationFunction = nil); overload;
    {$ELSE}
    procedure Link(const Lbl: TLabel; var i: OLInteger); overload;
    {$IFEND}
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Lbl: TLabel; var s: OLString; const ValidationFunction: TOLStringValidationFunction = nil); overload;
    {$ELSE}
    procedure Link(const Lbl: TLabel; var s: OLString); overload;
    {$IFEND}
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Lbl: TLabel; var d: OLDouble; const ValidationFunction: TOLDoubleValidationFunction = nil; const Format: string = DOUBLE_FORMAT); overload;
    {$ELSE}
    procedure Link(const Lbl: TLabel; var d: OLDouble; const Format: string = DOUBLE_FORMAT); overload;
    {$IFEND}
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLDouble; const Format: string = DOUBLE_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Lbl: TLabel; var curr: OLCurrency; const ValidationFunction: TOLCurrencyValidationFunction = nil; const Format: string = CURRENCY_FORMAT); overload;
    {$ELSE}
    procedure Link(const Lbl: TLabel; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT); overload;
    {$IFEND}
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLCurrency; const Format: string = CURRENCY_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Lbl: TLabel; var d: OLDate; const ValidationFunction: TOLDateValidationFunction = nil); overload;
    {$ELSE}
    procedure Link(const Lbl: TLabel; var d: OLDate); overload;
    {$IFEND}
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;
    {$IF CompilerVersion >= 34.0}
    procedure Link(const Lbl: TLabel; var d: OLDateTime; const ValidationFunction: TOLDateTimeValidationFunction = nil); overload;
    {$ELSE}
    procedure Link(const Lbl: TLabel; var d: OLDateTime); overload;
    {$IFEND}
    procedure Link(const Lbl: TLabel; const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string = ERROR_STRING); overload;

    procedure RefreshControls(FormToRefresh: TForm = nil);
    procedure RemoveLinks(DestroyedForm: TForm = nil);
    function GetLinkForControl(AControl: TControl): TOLControlLink;
  end;

   function Links(): TOLLinkManager;

implementation

uses
  {$IF CompilerVersion >= 23.0}
  System.Variants,
  {$ELSE}
  Variants,
  {$IFEND}
  SmartToDate;

const
  NULL_FORMAT = '- - -';
  CALCULATION_ASSIGN_ERROR = 'Calculation cannot be set when OLPointer property is other then nil.';
  OLPOINTER_ASSIGN_ERROR = 'OLPointer cannot be set when Calculation property is other then nil.';

var
  OLLinkManager: TOLLinkManager;

type
  THackDateTimePicker = class(TDateTimePicker);

  TOLRefreshTimer = class(TTimer)
  private
    FForm: TForm;
    procedure TimerEvent(Sender: TObject);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent; AForm: TForm); reintroduce;
    destructor Destroy; override;
  end;

  TOLFormCleanupHook = class(TComponent)
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  { Multicaster class to multicast OnChange events to multiple links }
  TOLValueMulticaster = class
  private
    FControlLinks: TList<TOLControlLink>;
    procedure OnOLChange(Sender: TObject);
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddLink(Link: TOLControlLink);
    procedure RemoveLink(Link: TOLControlLink);
    function IsEmpty: Boolean;
  end;

function Links(): TOLLinkManager;
begin
  Result := OLLinkManager;
end;

constructor TOLRefreshTimer.Create(AOwner: TComponent; AForm: TForm);
begin
  inherited Create(AOwner);
  FForm := AForm;
  if Assigned(FForm) then
    FForm.FreeNotification(Self);
  Interval := 100;
  OnTimer := TimerEvent;
end;

destructor TOLRefreshTimer.Destroy;
begin
  if Assigned(FForm) then
    FForm.RemoveFreeNotification(Self);
  inherited;
end;

procedure TOLRefreshTimer.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FForm) then
  begin
    FForm := nil;
    Enabled := False;
    if Assigned(Links.FRefreshTimers) then
       Links.FRefreshTimers.Remove(AComponent as TForm);

    // Ensure we free ourselves since we are owned by nil
    Self.Free;
  end;
end;

procedure TOLRefreshTimer.TimerEvent(Sender: TObject);
begin
  if Assigned(FForm) then
    Links.RefreshControls(FForm);
end;

constructor TOLFormCleanupHook.Create(AOwner: TComponent);
begin
  inherited;
  if Assigned(AOwner) then
      AOwner.FreeNotification(Self);
end;

{ TOLValueMulticaster }

constructor TOLValueMulticaster.Create;
begin
  inherited Create;
  FControlLinks := TList<TOLControlLink>.Create;
end;

destructor TOLValueMulticaster.Destroy;
begin
  FControlLinks.Free;
  inherited;
end;

procedure TOLValueMulticaster.AddLink(Link: TOLControlLink);
begin
  if not FControlLinks.Contains(Link) then
    FControlLinks.Add(Link);
end;

procedure TOLValueMulticaster.RemoveLink(Link: TOLControlLink);
begin
  FControlLinks.Remove(Link);
end;

function TOLValueMulticaster.IsEmpty: Boolean;
begin
  Result := FControlLinks.Count = 0;
end;

procedure TOLValueMulticaster.OnOLChange(Sender: TObject);
var
  Link: TOLControlLink;
begin
  // Multicast: call RefreshControl on all registered links
  for Link in FControlLinks do
    Link.RefreshControl;
end;

{ TOLEditLink<T> }

constructor TOLEditLink<T>.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FEditOnExit := nil;
  FOLPointer := nil;
  FUpdatingFromControl := False;
end;

destructor TOLEditLink<T>.Destroy;
begin
  if Assigned(FEdit) then
  begin
    if Assigned(FEditOnChange) then
      FEdit.OnChange := FEditOnChange;
    if Assigned(FEditOnExit) then
      FEdit.OnExit := FEditOnExit;
  end;
  inherited;
end;

function TOLEditLink<T>.TreatEmptyAsNull: Boolean;
begin
  Result := True;
end;

function TOLEditLink<T>.IsPartialEntry(const s: string): Boolean;
begin
  Result := False;
end;

procedure TOLEditLink<T>.NewOnChange(Sender: TObject);
var
  v: T;
  s: string;
  j: Integer;
begin
  if FUpdatingFromControl then Exit;

  s := Edit.Text;
  
  if (TreatEmptyAsNull and (s = '')) then
  begin
      FUpdatingFromControl := True;
      try
        {$IF CompilerVersion >= 34.0}
        SetValueAfterValidation(GetNull);
        {$ELSE}
        FOLPointer^ := GetNull;
        {$IFEND}
      finally
        FUpdatingFromControl := False;
      end;
  end
  else if IsPartialEntry(s) then
  begin
    // Do nothing
  end
  else if StringToVal(s, v) then
  begin
      FUpdatingFromControl := True;
      try
        {$IF CompilerVersion >= 34.0}
        SetValueAfterValidation(v);
        {$ELSE}
        FOLPointer^ := v;
        {$IFEND}
      finally
        FUpdatingFromControl := False;
      end;
  end
  else
  begin
      FUpdatingFromControl := True;
      try
        j := Edit.SelStart;
        Edit.Text := ValToString(FOLPointer^);
        if j > 0 then Edit.SelStart := j - 1;
      finally
        FUpdatingFromControl := False;
      end;
  end;

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TOLEditLink<T>.NewOnExit(Sender: TObject);
begin
  if Assigned(FEditOnExit) then
    FEditOnExit(Sender);
end;

procedure TOLEditLink<T>.OnOLChange(Sender: TObject);
begin
  RefreshControl;
end;

procedure TOLEditLink<T>.RefreshControl;
var
  s: string;
  {$IF CompilerVersion >= 34.0}
  vr: TOLValidationResult;
  {$IFEND}
begin
  if FUpdatingFromControl then Exit;
  if Edit.Focused() then Exit;

  s := ValToString(FOLPointer^);
  if Edit.Text <> s then
  begin
    FUpdatingFromControl := True;
    try
      Edit.Text := s;
      {$IF CompilerVersion >= 34.0}
      vr := ValueIsValid(FOLPointer^);
      ShowValidationState(vr);
      {$IFEND}
    finally
      FUpdatingFromControl := False;
    end;
  end;
end;

procedure TOLEditLink<T>.SetEdit(const Value: TEdit);
begin
  FEdit := Value;
  Control := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
    FEditOnExit := Value.OnExit;
    Value.OnExit := NewOnExit;
    FOriginalColor := Value.Color;
    FOriginalHint := Value.Hint;
    FOriginalShowHint := Value.ShowHint;
  end;
end;

function TOLEditLink<T>.GetOLPointer: Pointer;
begin
  Result := FOLPointer;
end;

procedure TOLEditLink<T>.SetOLPointer(const Value: Pointer);
begin
  if Value = nil then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{$IF CompilerVersion >= 34.0}
procedure TOLEditLink<T>.SetValidationFunction(const Value: TOLValidationFunction<T>);
begin
  FValidationFunction := Value;
end;

function TOLEditLink<T>.ValueIsValid(const v: T): TOLValidationResult;
begin
  if Assigned(FValidationFunction) then
    Result := FValidationFunction(v)
  else
    Result := TOLValidationResult.Ok;
end;

procedure TOLEditLink<T>.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
  begin
    Edit.Color := FOriginalColor;
    Edit.Hint := FOriginalHint;
    Edit.ShowHint := FOriginalShowHint;
  end
  else
  begin
    if vr.Color = clDefault then
      Edit.Color := $CBC0FF
    else
      Edit.Color := vr.Color;

    Edit.Hint := vr.Message;
    Edit.ShowHint := true;
  end;
end;

procedure TOLEditLink<T>.SetValueAfterValidation(const v: T);
var
  vr: TOLValidationResult;
begin
  vr := ValueIsValid(v);
  ShowValidationState(vr);

  if vr.Valid then
    FOLPointer^ := v;
end;
{$IFEND}

{ TEditToOLInteger }

function TEditToOLInteger.ValToString(const v: OLInteger): string;
begin
  Result := v.ToString();
end;

function TEditToOLInteger.StringToVal(const s: string; out v: OLInteger): Boolean;
var
  i: Integer;
begin
  if (s = '-') then
    Exit(False); // Should be handled by IsPartialEntry

  Result := TryStrToInt(s, i);
  if Result then
    v := i;
end;

function TEditToOLInteger.GetNull: OLInteger;
begin
  Result := Null;
end;

function TEditToOLInteger.TreatEmptyAsNull: Boolean;
begin
  Result := True;
end;

function TEditToOLInteger.IsPartialEntry(const s: string): Boolean;
begin
  Result := (s = '-');
end;




{ TEditToOLString }



{ TEditToOLString }

function TEditToOLString.ValToString(const v: OLString): string;
begin
  Result := v.ToString();
end;

function TEditToOLString.StringToVal(const s: string; out v: OLString): Boolean;
begin
  v := s;
  Result := True;
end;

function TEditToOLString.GetNull: OLString;
begin
  Result := Null;
end;

function TEditToOLString.TreatEmptyAsNull: Boolean;
begin
  Result := False;
end;

{ TMemoToOLString }

constructor TMemoToOLString.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FOLPointer := nil;

  {$IF CompilerVersion >= 34.0}
  FValidationFunction := nil;
  {$IFEND}
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
  {$IF CompilerVersion >= 34.0}
  SetValueAfterValidation(Edit.Text);
  {$ELSE}
  OLPointer^ := Edit.Text;
  {$IFEND}

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TMemoToOLString.OnOLChange(Sender: TObject);
begin
  RefreshControl;
end;

procedure TMemoToOLString.RefreshControl;
var
  vr: TOLValidationResult;
begin
  if Edit.Text <> (OLPointer^).ToString() then
  begin
    Edit.Text := (OLPointer^).ToString();

    {$IF CompilerVersion >= 34.0}
    vr := ValueIsValid(OLPointer^);
    ShowValidationState(vr);
    {$IFEND}
  end;
end;

procedure TMemoToOLString.SetEdit(const Value: TMemo);
begin
  FEdit := Value;
  Control := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
    FOriginalColor := Value.Color;
    FOriginalHint := Value.Hint;
    FOriginalShowHint := Value.ShowHint;
  end;
end;

procedure TMemoToOLString.SetOLPointer(const Value: POLString);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{$IF CompilerVersion >= 34.0}
procedure TMemoToOLString.SetValidationFunction(const Value: TOLStringValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TMemoToOLString.ValueIsValid(s: OLString): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(s)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TMemoToOLString.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
  begin
    Edit.Color := FOriginalColor;
    Edit.Hint := FOriginalHint;
    Edit.ShowHint := FOriginalShowHint;
  end
  else
  begin
    if vr.Color = clDefault then
      Edit.Color := $CBC0FF
    else
      Edit.Color := vr.Color;

    Edit.Hint := vr.Message;
    Edit.ShowHint := true;
  end;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TMemoToOLString.SetValueAfterValidation(s: OLString);
var
  vr: TOLValidationResult;
begin
  vr := ValueIsValid(s);
  ShowValidationState(vr);

  if vr.Valid then
    OLPointer^ := s;
end;
{$IFEND}

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

  {$IF CompilerVersion >= 34.0}
  FValidationFunction := nil;
  {$IFEND}
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
        {$IF CompilerVersion >= 34.0}
        SetValueAfterValidation(Null);
        {$ELSE}
        OLPointer^ := Null;
        {$IFEND}
      finally
        FUpdatingFromControl := False;
      end;
    end;
  end
  else if TryStrToFloat(CleanS, d) then
  begin
     FUpdatingFromControl := True;
     try
      {$IF CompilerVersion >= 34.0}
      SetValueAfterValidation(d);
      {$ELSE}
      OLPointer^ := d;
      {$IFEND}
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
  vr: TOLValidationResult;
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

        {$IF CompilerVersion >= 34.0}
        vr := ValueIsValid(OLPointer^);
        ShowValidationState(vr);
        {$IFEND}
      finally
        FUpdatingFromControl := False;
      end;
    end;
  end;
end;

procedure TEditToOLDouble.SetEdit(const Value: TEdit);
begin
  FEdit := Value;
  Control := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
    FEditOnExit := Value.OnExit;
    Value.OnExit := NewOnExit;
    FOriginalColor := Value.Color;
    FOriginalHint := Value.Hint;
    FOriginalShowHint := Value.ShowHint;
  end;
end;

procedure TEditToOLDouble.SetOLPointer(const Value: POLDouble);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{$IF CompilerVersion >= 34.0}
procedure TEditToOLDouble.SetValidationFunction(const Value: TOLDoubleValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TEditToOLDouble.ValueIsValid(d: OLDouble): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(d)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TEditToOLDouble.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
  begin
    Edit.Color := FOriginalColor;
    Edit.Hint := FOriginalHint;
    Edit.ShowHint := FOriginalShowHint;
  end
  else
  begin
    if vr.Color = clDefault then
      Edit.Color := $CBC0FF
    else
      Edit.Color := vr.Color;

    Edit.Hint := vr.Message;
    Edit.ShowHint := true;
  end;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TEditToOLDouble.SetValueAfterValidation(d: OLDouble);
var
  vr: TOLValidationResult;
begin
  vr := ValueIsValid(d);
  ShowValidationState(vr);

  if vr.Valid then
    OLPointer^ := d;
end;
{$IFEND}

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

  {$IF CompilerVersion >= 34.0}
  FValidationFunction := nil;
  {$IFEND}
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
        {$IF CompilerVersion >= 34.0}
        SetValueAfterValidation(Null);
        {$ELSE}
        OLPointer^ := Null;
        {$IFEND}
      finally
        FUpdatingFromControl := False;
      end;
    end;
  end
  else if TryStrToCurr(CleanS, curr) then
  begin
    FUpdatingFromControl := True;
    try
      {$IF CompilerVersion >= 34.0}
      SetValueAfterValidation(curr);
      {$ELSE}
      OLPointer^ := curr;
      {$IFEND}
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
  vr: TOLValidationResult;
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

        {$IF CompilerVersion >= 34.0}
        vr := ValueIsValid(OLPointer^);
        ShowValidationState(vr);
        {$IFEND}
      finally
        FUpdatingFromControl := False;
      end;
    end;
  end;
end;

procedure TEditToOLCurrency.SetEdit(const Value: TEdit);
begin
  FEdit := Value;
  Control := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
    FEditOnExit := Value.OnExit;
    Value.OnExit := NewOnExit;
    FOriginalColor := Value.Color;
    FOriginalHint := Value.Hint;
    FOriginalShowHint := Value.ShowHint;
  end;
end;

procedure TEditToOLCurrency.SetOLPointer(const Value: POLCurrency);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{$IF CompilerVersion >= 34.0}
procedure TEditToOLCurrency.SetValidationFunction(const Value: TOLCurrencyValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TEditToOLCurrency.ValueIsValid(c: OLCurrency): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(c)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TEditToOLCurrency.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
  begin
    Edit.Color := FOriginalColor;
    Edit.Hint := FOriginalHint;
    Edit.ShowHint := FOriginalShowHint;
  end
  else
  begin
    if vr.Color = clDefault then
      Edit.Color := $CBC0FF
    else
      Edit.Color := vr.Color;

    Edit.Hint := vr.Message;
    Edit.ShowHint := true;
  end;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TEditToOLCurrency.SetValueAfterValidation(c: OLCurrency);
var
  vr: TOLValidationResult;
begin
  vr := ValueIsValid(c);
  ShowValidationState(vr);

  if vr.Valid then
    OLPointer^ := c;
end;
{$IFEND}

{ TSpinEditToOLInteger }

constructor TSpinEditToOLInteger.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FEditOnExit := nil;
  FOLPointer := nil;
  FUpdatingFromControl := False;

  {$IF CompilerVersion >= 34.0}
  FValidationFunction := nil;
  {$IFEND}
end;

destructor TSpinEditToOLInteger.Destroy;
begin
  if Assigned(FOLPointer) then
  begin
    {$IF CompilerVersion >= 34.0}
    if Assigned(Links.FValueMulticasters) then
    begin
      var Observer: TObject;
      if Links.FValueMulticasters.TryGetValue(FOLPointer, Observer) then
      begin
        var Multicaster := Observer as TOLValueMulticaster;
        Multicaster.RemoveLink(Self);
        if Multicaster.IsEmpty then
        begin
          Links.FValueMulticasters.Remove(FOLPointer);
          FOLPointer^.OnChange := nil;
          Multicaster.Free;
        end;
      end;
    end
    else
      FOLPointer^.OnChange := nil;
    {$IFEND}
   end;

   if Assigned(FEdit) then
   begin
     if Assigned(FEditOnChange) then
       FEdit.OnChange := FEditOnChange;
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
        {$IF CompilerVersion >= 34.0}
        SetValueAfterValidation(Null);
        {$ELSE}
        OLPointer^ := Null;
        {$IFEND}
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
        {$IF CompilerVersion >= 34.0}
        SetValueAfterValidation(i);
        {$ELSE}
        OLPointer^ := i;
        {$IFEND}
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
  if Assigned(FEditOnExit) then
    FEditOnExit(Sender);
end;

procedure TSpinEditToOLInteger.OnOLChange(Sender: TObject);
begin
  RefreshControl;
end;

procedure TSpinEditToOLInteger.RefreshControl;
var
  vr: TOLValidationResult;
begin
  if FUpdatingFromControl then Exit;

  // Don't overwrite user input while they're typing
  if Edit.Focused() then Exit;

  if Edit.Text <> (OLPointer^).ToString() then
  begin
    FUpdatingFromControl := True;
    try
      Edit.Text := (OLPointer^).ToString();

      {$IF CompilerVersion >= 34.0}
      vr := ValueIsValid(OLPointer^);
      ShowValidationState(vr);
      {$IFEND}
    finally
      FUpdatingFromControl := False;
    end;
  end;
end;

procedure TSpinEditToOLInteger.SetEdit(const Value: TSpinEdit);
begin
  FEdit := Value;
  Control := Value;
  if Assigned(Value) then
  begin
    FEditOnChange := Value.OnChange;
    Value.OnChange := NewOnChange;
    FEditOnExit := Value.OnExit;
    Value.OnExit := NewOnExit;
    FOriginalColor := Value.Color;
    FOriginalHint := Value.Hint;
    FOriginalShowHint := Value.ShowHint;
  end;
end;

procedure TSpinEditToOLInteger.SetOLPointer(const Value: POLInteger);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{$IF CompilerVersion >= 34.0}
procedure TSpinEditToOLInteger.SetValidationFunction(const Value: TOLIntegerValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TSpinEditToOLInteger.ValueIsValid(i: OLInteger): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(i)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TSpinEditToOLInteger.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
  begin
    Edit.Color := FOriginalColor;
    Edit.Hint := FOriginalHint;
    Edit.ShowHint := FOriginalShowHint;
  end
  else
  begin
    if vr.Color = clDefault then
      Edit.Color := $CBC0FF
    else
      Edit.Color := vr.Color;

    Edit.Hint := vr.Message;
    Edit.ShowHint := true;
  end;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TSpinEditToOLInteger.SetValueAfterValidation(i: OLInteger);
var
  vr: TOLValidationResult;
begin
  vr := ValueIsValid(i);
  ShowValidationState(vr);

  if vr.Valid then
    OLPointer^ := i;
end;
{$IFEND}

{ TOLControlLink }

constructor TOLControlLink.Create;
begin
  inherited Create(nil);
end;

function TOLControlLink.NeedsTimer: Boolean;
begin
  Result := false;
end;


procedure TOLControlLink.ShowValidationState(vr: TOLValidationResult);
begin
  // Do nothing by default
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

  {$IF CompilerVersion >= 34.0}
  FValidationFunction := nil;
  {$IFEND}

  FWarningLabel := nil;
  NotNullFormat := '';
  LastTwoKeys := '';
  LastThreeKeys := '';
  FUpdatingFromRefresh := False;
  FUpdatingFromControl := False;
  FOriginalHint := '';
  FOriginalShowHint := False;
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
    {$IF CompilerVersion >= 34.0}
    SetValueAfterValidation(Edit.DateTime);
    {$ELSE}
    OLPointer^ := Edit.DateTime;
    {$IFEND}

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
        {$IF CompilerVersion >= 34.0}
        SetValueAfterValidation(NewDate);
        {$ELSE}
        OLPointer^ := NewDate;
        {$IFEND}
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
  Control := Value;

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

    FOriginalHint := Value.Hint;
    FOriginalShowHint := Value.ShowHint;

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

{$IF CompilerVersion >= 34.0}
procedure TDateTimePickerToOLDate.SetValidationFunction(const Value: TOLDateValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TDateTimePickerToOLDate.SetValueAfterValidation(d: OLDate);
var
  vr: TOLValidationResult;
begin
  vr := ValueIsValid(d);
  ShowValidationState(vr);

  if vr.Valid then
    OLPointer^ := d;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TDateTimePickerToOLDate.ValueIsValid(d: OLDate): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(d)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TDateTimePickerToOLDate.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
  begin
    if Assigned(FWarningLabel) then
    begin
      FWarningLabel.Visible := False;
      FWarningLabel.Free;
      FWarningLabel := nil;

      Edit.Hint := FOriginalHint;
      Edit.ShowHint := FOriginalShowHint;
    end;
  end
  else
  begin
    if not Assigned(FWarningLabel) then
    begin
      FWarningLabel := TLabel.Create(Edit.Owner as TForm);
      FWarningLabel.Parent := Edit.Owner as TForm;
      FWarningLabel.Caption := '⚠';
      FWarningLabel.Font.Color := clRed;
      FWarningLabel.Font.Size := 12;
      FWarningLabel.AutoSize := True;
      FWarningLabel.Left := Edit.Left + Edit.Width + 5;
      FWarningLabel.Top := Edit.Top;
    end;
    FWarningLabel.Hint := vr.Message;
    FWarningLabel.ShowHint := True;
    FWarningLabel.Visible := True;

    Edit.Hint := vr.Message;
    Edit.ShowHint := true;
  end;
end;
{$IFEND}

{ TDateTimePickerToOLDateTime }

constructor TDateTimePickerToOLDateTime.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FEditOnEnter := nil;
  FEditOnKeyPress := nil;
  FOLPointer := nil;

  {$IF CompilerVersion >= 34.0}
  FValidationFunction := nil;
  {$IFEND}

  FWarningLabel := nil;
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

   if Assigned(FWarningLabel) then
   begin
     FWarningLabel.Free;
     FWarningLabel := nil;
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
    {$IF CompilerVersion >= 34.0}
    SetValueAfterValidation(Edit.DateTime);
    {$ELSE}
    OLPointer^ := Edit.DateTime;
    {$IFEND}

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
        {$IF CompilerVersion >= 34.0}
        SetValueAfterValidation(NewDate);
        {$ELSE}
        OLPointer^ := NewDate;
        {$IFEND}
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
  Control := Value;

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

    FOriginalHint := Value.Hint;
    FOriginalShowHint := Value.ShowHint;
  end;
end;

procedure TDateTimePickerToOLDateTime.SetOLPointer(const Value: POLDateTime);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{$IF CompilerVersion >= 34.0}
procedure TDateTimePickerToOLDateTime.SetValidationFunction(const Value: TOLDateTimeValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TDateTimePickerToOLDateTime.SetValueAfterValidation(dt: OLDateTime);
var
  vr: TOLValidationResult;
begin
  vr := ValueIsValid(dt);
  ShowValidationState(vr);

  if vr.Valid then
    OLPointer^ := dt;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TDateTimePickerToOLDateTime.ValueIsValid(dt: OLDateTime): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(dt)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TDateTimePickerToOLDateTime.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
  begin
    if Assigned(FWarningLabel) then
    begin
      FWarningLabel.Visible := False;
      FWarningLabel.Free;
      FWarningLabel := nil;

      Edit.Hint := FOriginalHint;
      Edit.ShowHint := FOriginalShowHint;
    end;
  end
  else
  begin
    if not Assigned(FWarningLabel) then
    begin
      FWarningLabel := TLabel.Create(Edit.Owner as TForm);
      FWarningLabel.Parent := Edit.Owner as TForm;
      FWarningLabel.Caption := '⚠';
      FWarningLabel.Font.Color := clRed;
      FWarningLabel.Font.Size := 12;
      FWarningLabel.AutoSize := True;
      FWarningLabel.Left := Edit.Left + Edit.Width + 5;
      FWarningLabel.Top := Edit.Top;
    end;
    FWarningLabel.Hint := vr.Message;
    FWarningLabel.ShowHint := True;
    FWarningLabel.Visible := True;

    Edit.Hint := vr.Message;
    Edit.ShowHint := true;
  end;
end;
{$IFEND}

{ TCheckBoxToOLBoolean }

constructor TCheckBoxToOLBoolean.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnClick := nil;
  FOLPointer := nil;

  {$IF CompilerVersion >= 34.0}
  FValidationFunction := nil;
  {$IFEND}

  FOriginalHint := '';
  FOriginalShowHint := False;
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
  if Assigned(FWarningLabel) then
    FWarningLabel.Free;
  inherited;
end;

{$IF CompilerVersion >= 34.0}
procedure TCheckBoxToOLBoolean.SetValidationFunction(const Value: TOLBooleanValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TCheckBoxToOLBoolean.ValueIsValid(b: OLBoolean): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(b)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TCheckBoxToOLBoolean.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
  begin
    Edit.Hint := FOriginalHint;
    Edit.ShowHint := FOriginalShowHint;
    if Assigned(FWarningLabel) then
    begin
      FWarningLabel.Visible := False;
      FWarningLabel.Free;
      FWarningLabel := nil;
    end;
  end
  else
  begin
    if not Assigned(FWarningLabel) then
    begin
      FWarningLabel := TLabel.Create(Edit.Owner);
      FWarningLabel.Parent := Edit.Parent;
      FWarningLabel.Caption := '⚠';
      FWarningLabel.Font.Color := clRed;
      FWarningLabel.Font.Size := 12;
      FWarningLabel.AutoSize := True;
      FWarningLabel.Left := Edit.Left + Edit.Width + 5;
      FWarningLabel.Top := Edit.Top + (Edit.Height - FWarningLabel.Height) div 2;
    end;
    FWarningLabel.Hint := vr.Message;
    FWarningLabel.ShowHint := True;
    FWarningLabel.Visible := True;
    Edit.Hint := vr.Message;
    Edit.ShowHint := true;
  end;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TCheckBoxToOLBoolean.SetValueAfterValidation(b: OLBoolean);
var
  vr: TOLValidationResult;
begin
  vr := ValueIsValid(b);
  ShowValidationState(vr);

  if vr.Valid then
    OLPointer^ := b;
end;
{$IFEND}


procedure TCheckBoxToOLBoolean.OnOLChange(Sender: TObject);
begin
  RefreshControl;
end;

procedure TCheckBoxToOLBoolean.NewOnClick(Sender: TObject);
begin
  {$IF CompilerVersion >= 34.0}
  SetValueAfterValidation(Edit.Checked);
  {$ELSE}
  OLPointer^ := Edit.Checked;
  {$IFEND}

  if Assigned(FEditOnClick) then
    FEditOnClick(Edit);
end;

procedure TCheckBoxToOLBoolean.RefreshControl;
var
  vr: TOLValidationResult;
begin
  if Edit.Checked <> (OLPointer^).IfNull(False) then
    Edit.Checked := (OLPointer^).IfNull(False);

  {$IF CompilerVersion >= 34.0}
  vr := ValueIsValid(OLPointer^);
  ShowValidationState(vr);
  {$IFEND}
end;

procedure TCheckBoxToOLBoolean.SetEdit(const Value: TCheckBox);
begin
  FEdit := Value;
  Control := Value;
  if Assigned(Value) then
  begin
    FEditOnClick := Value.OnClick;
    Value.OnClick := NewOnClick;
    FOriginalFontColor := Value.Font.Color;
    FOriginalHint := Value.Hint;
    FOriginalShowHint := Value.ShowHint;
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

  {$IF CompilerVersion >= 34.0}
  FValidationFunction := nil;
  {$IFEND}
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
  vr: TOLValidationResult;
begin
  if OLPointer <> nil then
  begin
    s := (OLPointer^).ToString();
    if Lbl.Caption <> s then
      Lbl.Caption := s;

    {$IF CompilerVersion >= 34.0}
    vr := ValueIsValid(OLPointer^);
    ShowValidationState(vr);
    {$IFEND}
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
  Control := Value;
  if Assigned(Value) then
    FOriginalFontColor := Value.Font.Color;
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

{$IF CompilerVersion >= 34.0}
procedure TOLIntegerToLabel.SetValidationFunction(const Value: TOLIntegerValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TOLIntegerToLabel.ValueIsValid(i: OLInteger): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(i)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TOLIntegerToLabel.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
    Lbl.Font.Color := FOriginalFontColor
  else
  begin
    if vr.Color = clDefault then
      Lbl.Font.Color:= clRed
    else
      Lbl.Font.Color := vr.Color;
  end;
end;
{$IFEND}

{ TOLStringToLabel }

constructor TOLStringToLabel.Create;
begin
  inherited;
  FLabel := nil;
  FOLPointer := nil;
  FCalculation := nil;
  FValueOnErrorInCalculation := '';

  {$IF CompilerVersion >= 34.0}
  FValidationFunction := nil;
  {$IFEND}
end;

procedure TOLStringToLabel.RefreshControl;
var
  s: string;
  vr: TOLValidationResult;
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
  Control := Value;
  if Assigned(Value) then
    FOriginalFontColor := Value.Font.Color;
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

{$IF CompilerVersion >= 34.0}
procedure TOLStringToLabel.SetValidationFunction(const Value: TOLStringValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TOLStringToLabel.ValueIsValid(s: OLString): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(s)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TOLStringToLabel.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
    Lbl.Font.Color := FOriginalFontColor
  else
  begin
    if vr.Color = clDefault then
      Lbl.Font.Color := clRed
    else
       Lbl.Font.Color := vr.Color;
  end;
end;
{$IFEND}

{ TOLDoubleToLabel }

constructor TOLDoubleToLabel.Create;
begin
  inherited;
  FLabel := nil;
  FOLPointer := nil;
  FCalculation := nil;
  FValueOnErrorInCalculation := '';
  FFormat := DOUBLE_FORMAT;

  {$IF CompilerVersion >= 34.0}
  FValidationFunction := nil;
  {$IFEND}
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
  vr: TOLValidationResult;
begin
  {$IF CompilerVersion >= 22.0}
  fs := TFormatSettings.Create();
  {$ELSE}
  GetLocaleFormatSettings(LOCALE_USER_DEFAULT, fs);
  {$IFEND}

  if OLPointer <> nil then
  begin
    s := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, FFormat);
    if Lbl.Caption <> s then
      Lbl.Caption := s;

    {$IF CompilerVersion >= 34.0}
    vr := ValueIsValid(OLPointer^);
    ShowValidationState(vr);
      {$IFEND}
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
  Control := Value;
  if Assigned(Value) then
    FOriginalFontColor := Value.Font.Color;
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

{$IF CompilerVersion >= 34.0}
procedure TOLDoubleToLabel.SetValidationFunction(const Value: TOLDoubleValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TOLDoubleToLabel.ValueIsValid(d: OLDouble): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(d)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TOLDoubleToLabel.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
    Lbl.Font.Color := FOriginalFontColor
  else
  begin
    if vr.Color = clDefault then
      Lbl.Font.Color := clRed
    else
       Lbl.Font.Color := vr.Color;
  end;
end;
{$IFEND}

{ TOLCurrencyToLabel }

constructor TOLCurrencyToLabel.Create;
begin
  inherited;
  FLabel := nil;
  FOLPointer := nil;
  FCalculation := nil;
  FValueOnErrorInCalculation := '';
  FFormat := CURRENCY_FORMAT;

  {$IF CompilerVersion >= 34.0}
  FValidationFunction := nil;
  {$IFEND}
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
  vr: TOLValidationResult;
begin
  {$IF CompilerVersion >= 22.0}
  fs := TFormatSettings.Create();
  {$ELSE}
  GetLocaleFormatSettings(LOCALE_USER_DEFAULT, fs);
  {$IFEND}

  if OLPointer <> nil then
  begin
    s := (OLPointer^).ToString(fs.ThousandSeparator, fs.DecimalSeparator, FFormat);
    if Lbl.Caption <> s then
      Lbl.Caption := s;

    {$IF CompilerVersion >= 34.0}
    vr := ValueIsValid(OLPointer^);
    ShowValidationState(vr);
    {$IFEND}
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
  Control := Value;
  if Assigned(Value) then
    FOriginalFontColor := Value.Font.Color;
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

{$IF CompilerVersion >= 34.0}
procedure TOLCurrencyToLabel.SetValidationFunction(const Value: TOLCurrencyValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TOLCurrencyToLabel.ValueIsValid(c: OLCurrency): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(c)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TOLCurrencyToLabel.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
    Lbl.Font.Color := FOriginalFontColor
  else
  begin
    if vr.Color = clDefault then
      Lbl.Font.Color := clRed
    else
       Lbl.Font.Color := vr.Color;
  end;
end;
{$IFEND}

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

  {$IF CompilerVersion >= 34.0}
  if OLPointer <> nil then
    ShowValidationState(ValueIsValid(OLPointer^));
  {$IFEND}
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
  Control := Value;
  if Assigned(Value) then
    FOriginalFontColor := Value.Font.Color;
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

{$IF CompilerVersion >= 34.0}
procedure TOLDateToLabel.SetValidationFunction(const Value: TOLDateValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TOLDateToLabel.ValueIsValid(d: OLDate): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(d)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TOLDateToLabel.ShowValidationState(vr: TOLValidationResult);
begin
  if Assigned(FLabel) then
  begin
    if vr.Valid then
      FLabel.Font.Color := FOriginalFontColor
    else
      FLabel.Font.Color := clRed;
  end;
end;
{$IFEND}

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

  {$IF CompilerVersion >= 34.0}
  if OLPointer <> nil then
    ShowValidationState(ValueIsValid(OLPointer^));
  {$IFEND}
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
  Control := Value;
  if Assigned(Value) then
    FOriginalFontColor := Value.Font.Color;
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

{$IF CompilerVersion >= 34.0}
procedure TOLDateTimeToLabel.SetValidationFunction(const Value: TOLDateTimeValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TOLDateTimeToLabel.ValueIsValid(dt: OLDateTime): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(dt)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TOLDateTimeToLabel.ShowValidationState(vr: TOLValidationResult);
begin
  if Assigned(FLabel) then
  begin
    if vr.Valid then
      FLabel.Font.Color := FOriginalFontColor
    else
      FLabel.Font.Color := clRed;
  end;
end;
{$IFEND}

{ TScrollBarToOLInteger }

constructor TScrollBarToOLInteger.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FOLPointer := nil;

  {$IF CompilerVersion >= 34.0}
  FValidationFunction := nil;
  {$IFEND}
  FWarningLabel := nil;
end;

destructor TScrollBarToOLInteger.Destroy;
begin
  if Assigned(FOLPointer) then
  begin
    {$IF CompilerVersion >= 34.0}
    if Assigned(Links.FValueMulticasters) then
    begin
      var Observer: TObject;
      if Links.FValueMulticasters.TryGetValue(FOLPointer, Observer) then
      begin
        var Multicaster := Observer as TOLValueMulticaster;
        Multicaster.RemoveLink(Self);
        if Multicaster.IsEmpty then
        begin
          Links.FValueMulticasters.Remove(FOLPointer);
          FOLPointer^.OnChange := nil;
          Multicaster.Free;
        end;
      end;
    end
    else
      FOLPointer^.OnChange := nil;
    {$IFEND}
  end;
  inherited;
end;

procedure TScrollBarToOLInteger.NewOnChange(Sender: TObject);
begin
  {$IF CompilerVersion >= 34.0}
  SetValueAfterValidation(Edit.Position);
  {$ELSE}
  OLPointer^ := Edit.Position;
  {$IFEND}

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TScrollBarToOLInteger.OnOLChange(Sender: TObject);
begin
  RefreshControl;
end;

procedure TScrollBarToOLInteger.RefreshControl;
var
  vr: TOLValidationResult;
begin
  if Edit.Position <> (OLPointer^).IfNull(0) then
  begin
    Edit.Position := (OLPointer^).IfNull(0);

    {$IF CompilerVersion >= 34.0}
    vr := ValueIsValid(OLPointer^);
    ShowValidationState(vr);
    {$IFEND}
  end;
end;

procedure TScrollBarToOLInteger.SetEdit(const Value: TScrollBar);
begin
  FEdit := Value;
  Control := Value;
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

{$IF CompilerVersion >= 34.0}
procedure TScrollBarToOLInteger.SetValidationFunction(const Value: TOLIntegerValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TScrollBarToOLInteger.ValueIsValid(i: OLInteger): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(i)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TScrollBarToOLInteger.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
  begin
    if Assigned(FWarningLabel) then
    begin
      FWarningLabel.Visible := False;
      FWarningLabel.Free;
      FWarningLabel := nil;
    end;
  end
  else
  begin
    if not Assigned(FWarningLabel) then
    begin
      FWarningLabel := TLabel.Create(Edit.Owner as TForm);
      FWarningLabel.Parent := Edit.Owner as TForm;
      FWarningLabel.Caption := '⚠';
      FWarningLabel.Font.Color := clRed;
      FWarningLabel.Font.Size := 12;
      FWarningLabel.AutoSize := True;
      FWarningLabel.Left := Edit.Left + Edit.Width + 5;
      FWarningLabel.Top := Edit.Top;
    end;
    FWarningLabel.Hint := vr.Message;
    FWarningLabel.ShowHint := True;
    FWarningLabel.Visible := True;
  end;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TScrollBarToOLInteger.SetValueAfterValidation(i: OLInteger);
var
  vr: TOLValidationResult;
begin
  vr := ValueIsValid(i);
  ShowValidationState(vr);

  if vr.Valid then
    OLPointer^ := i;
end;
{$IFEND}

{ TTrackBarToOLInteger }

constructor TTrackBarToOLInteger.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FOLPointer := nil;

  {$IF CompilerVersion >= 34.0}
  FValidationFunction := nil;
  {$IFEND}
  FWarningLabel := nil;
end;

destructor TTrackBarToOLInteger.Destroy;
begin
  if Assigned(FOLPointer) then
  begin
    {$IF CompilerVersion >= 34.0}
    if Assigned(Links.FValueMulticasters) then
    begin
      var Observer: TObject;
      if Links.FValueMulticasters.TryGetValue(FOLPointer, Observer) then
      begin
        var Multicaster := Observer as TOLValueMulticaster;
        Multicaster.RemoveLink(Self);
        if Multicaster.IsEmpty then
        begin
          Links.FValueMulticasters.Remove(FOLPointer);
          FOLPointer^.OnChange := nil;
          Multicaster.Free;
        end;
      end;
    end
    else
      FOLPointer^.OnChange := nil;
    {$IFEND}
  end;
  inherited;
end;

procedure TTrackBarToOLInteger.NewOnChange(Sender: TObject);
begin
  {$IF CompilerVersion >= 34.0}
  SetValueAfterValidation(Edit.Position);
  {$ELSE}
  OLPointer^ := Edit.Position;
  {$IFEND}

  if Assigned(FEditOnChange) then
    FEditOnChange(Edit);
end;

procedure TTrackBarToOLInteger.OnOLChange(Sender: TObject);
begin
  RefreshControl;
end;

procedure TTrackBarToOLInteger.RefreshControl;
var
  vr: TOLValidationResult;
begin
  if Edit.Position <> (OLPointer^).IfNull(0) then
  begin
    Edit.Position := (OLPointer^).IfNull(0);

    {$IF CompilerVersion >= 34.0}
    vr := ValueIsValid(OLPointer^);
    ShowValidationState(vr);
    {$IFEND}
  end;
end;

procedure TTrackBarToOLInteger.SetEdit(const Value: TTrackBar);
begin
  FEdit := Value;
  Control := Value;
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

{$IF CompilerVersion >= 34.0}
procedure TTrackBarToOLInteger.SetValidationFunction(const Value: TOLIntegerValidationFunction);
begin
  FValidationFunction := Value;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
function TTrackBarToOLInteger.ValueIsValid(i: OLInteger): TOLValidationResult;
var
  vr: TOLValidationResult;
begin
  if Assigned(ValidationFunction) then
    vr := ValidationFunction(i)
  else
    vr := TOLValidationResult.Ok();

  Result := vr;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TTrackBarToOLInteger.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
  begin
    if Assigned(FWarningLabel) then
    begin
      FWarningLabel.Visible := False;
      FWarningLabel.Free;
      FWarningLabel := nil;
    end;
  end
  else
  begin
    if not Assigned(FWarningLabel) then
    begin
      FWarningLabel := TLabel.Create(Edit.Owner as TForm);
      FWarningLabel.Parent := Edit.Owner as TForm;
      FWarningLabel.Caption := '⚠';
      FWarningLabel.Font.Color := clRed;
      FWarningLabel.Font.Size := 12;
      FWarningLabel.AutoSize := True;
      FWarningLabel.Left := Edit.Left + Edit.Width + 5;
      FWarningLabel.Top := Edit.Top;
    end;
    FWarningLabel.Hint := vr.Message;
    FWarningLabel.ShowHint := True;
    FWarningLabel.Visible := True;
  end;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TTrackBarToOLInteger.SetValueAfterValidation(i: OLInteger);
var
  vr: TOLValidationResult;
begin
  vr := ValueIsValid(i);
  ShowValidationState(vr);

  if vr.Valid then
    OLPointer^ := i;
end;
{$IFEND}

{ TOLLinkManager }

constructor TOLLinkManager.Create;
begin
  FControlLinks := TDictionary<TForm, TObjectList<TOLControlLink>>.Create;
  FRefreshTimers := TDictionary<TForm, TTimer>.Create;
  FFormCleanupHooks := TDictionary<TForm, TComponent>.Create;
  FValueMulticasters := TDictionary<Pointer, TObject>.Create;
end;

destructor TOLLinkManager.Destroy;
var
  List: TObjectList<TOLControlLink>;
  Timer: TTimer;
  Obj: TObject;
begin
  if Assigned(FControlLinks) then
  begin
    for List in FControlLinks.Values do
      List.Free;
    FControlLinks.Free;
  end;
  if Assigned(FRefreshTimers) then
  begin
    // Free all timers to avoid leaks and AVs
    for Timer in FRefreshTimers.Values do
    begin
      Timer.Enabled := False;
      Timer.Free;
    end;
    FRefreshTimers.Free;
  end;
  if Assigned(FFormCleanupHooks) then
    FFormCleanupHooks.Free;
  if Assigned(FValueMulticasters) then
  begin
    for Obj in FValueMulticasters.Values do
      Obj.Free;
    FValueMulticasters.Free;
  end;
  inherited;
end;

procedure TOLLinkManager.AddLink(Control: TControl; Link: TOLControlLink);
var
  TempControl: TWinControl;
  Form: TForm;
  List: TObjectList<TOLControlLink>;
  Timer: TTimer;
  CleanupHook: TOLFormCleanupHook;
  NeedTimer: Boolean;
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

  if not Assigned(FControlLinks) then Exit;

  if not FControlLinks.TryGetValue(Form, List) then
  begin
    List := TObjectList<TOLControlLink>.Create(True);
    FControlLinks.Add(Form, List);
  end;

  List.Add(Link);

  // Ensure Timer
  NeedTimer := False;
  {$IF CompilerVersion < 34.0}
  NeedTimer := True;
  {$ELSE}
  NeedTimer := Link.NeedsTimer;
  {$IFEND}

  if NeedTimer and (not FRefreshTimers.ContainsKey(Form)) then
  begin
    Timer := TOLRefreshTimer.Create(nil, Form); // Owned by nil, we manage it
    Timer.Enabled := True;
    FRefreshTimers.Add(Form, Timer);
  end;

  // Ensure CleanupHook
  if not FFormCleanupHooks.ContainsKey(Form) then
  begin
    CleanupHook := TOLFormCleanupHook.Create(Form); // Owned by Form, so it dies with Form
    FFormCleanupHooks.Add(Form, CleanupHook);
  end;
end;


{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Edit: TEdit; var i: OLInteger; const
    ValidationFunction: TOLIntegerValidationFunction = nil; const Alignment:
    TAlignment=taRightJustify);
{$ELSE}
procedure TOLLinkManager.Link(const Edit: TEdit; var i: OLInteger; const Alignment:
    TAlignment=taRightJustify);
{$IFEND}
var
  Link: TEditToOLInteger;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TEditToOLInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := TOLValidationFunction<OLInteger>(ValidationFunction);
  // Get or create multicaster for this OLInteger
  if not FValueMulticasters.TryGetValue(@i, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@i, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  i.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLInteger
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Link);

  Edit.Alignment := Alignment;

  Link.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Edit: TTrackBar; var i: OLInteger; const ValidationFunction: TOLIntegerValidationFunction = nil);
{$ELSE}
procedure TOLLinkManager.Link(const Edit: TTrackBar; var i: OLInteger);
{$IFEND}
var
  Link: TTrackBarToOLInteger;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TTrackBarToOLInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := ValidationFunction;
  // Get or create multicaster for this OLInteger
  if not FValueMulticasters.TryGetValue(@i, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@i, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  i.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLInteger
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Edit: TScrollBar; var i: OLInteger; const ValidationFunction: TOLIntegerValidationFunction = nil);
{$ELSE}
procedure TOLLinkManager.Link(const Edit: TScrollBar; var i: OLInteger);
{$IFEND}
var
  Link: TScrollBarToOLInteger;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TScrollBarToOLInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := ValidationFunction;
  // Get or create multicaster for this OLInteger
  if not FValueMulticasters.TryGetValue(@i, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@i, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  i.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLInteger
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Edit: TEdit; var d: OLDouble; const ValidationFunction: TOLDoubleValidationFunction = nil; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify);
{$ELSE}
procedure TOLLinkManager.Link(const Edit: TEdit; var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify);
{$IFEND}
var
  Link: TEditToOLDouble;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TEditToOLDouble.Create;
  Link.FFormat := Format;
  Link.Edit := Edit;
  Link.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := ValidationFunction;
  // Get or create multicaster for this OLDouble
  if not FValueMulticasters.TryGetValue(@d, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@d, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  d.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLDouble
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Link);

  Edit.Alignment := Alignment;

  Link.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Edit: TEdit; var curr: OLCurrency; const ValidationFunction: TOLCurrencyValidationFunction = nil; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify);
{$ELSE}
procedure TOLLinkManager.Link(const Edit: TEdit; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify);
{$IFEND}
var
  Link: TEditToOLCurrency;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TEditToOLCurrency.Create;
  Link.FFormat := Format;
  Link.Edit := Edit;
  Link.FOLPointer := @curr;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := ValidationFunction;
  // Get or create multicaster for this OLCurrency
  if not FValueMulticasters.TryGetValue(@curr, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@curr, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  curr.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLCurrency
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Link);

  Edit.Alignment := Alignment;

  Link.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Edit: TEdit; var s: OLString; const ValidationFunction: TOLStringValidationFunction = nil);
{$ELSE}
procedure TOLLinkManager.Link(const Edit: TEdit; var s: OLString);
{$IFEND}
var
  Link: TEditToOLString;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TEditToOLString.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @s;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := TOLValidationFunction<OLString>(ValidationFunction);
  // Get or create multicaster for this OLString
  if not FValueMulticasters.TryGetValue(@s, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@s, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  s.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLString
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Edit: TMemo; var s: OLString; const ValidationFunction: TOLStringValidationFunction = nil);
{$ELSE}
procedure TOLLinkManager.Link(const Edit: TMemo; var s: OLString);
{$IFEND}
var
  Link: TMemoToOLString;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TMemoToOLString.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @s;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := ValidationFunction;
  // Get or create multicaster for this OLString
  if not FValueMulticasters.TryGetValue(@s, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@s, ValueMulticaster);
    s.OnChange := ValueMulticaster.OnOLChange;  // Set multicaster's handler on OLString
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Edit: TDateTimePicker; var d: OLDate; const
    ValidationFunction: TOLDateValidationFunction = nil);
{$ELSE}
procedure TOLLinkManager.Link(const Edit: TDateTimePicker; var d: OLDate);
{$IFEND}
var
  Link: TDateTimePickerToOLDate;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  if Edit.Format = '' then
  begin
    Edit.Format := DelphiDateTimeFormatToWindowsFormat(FormatSettings.ShortDateFormat);
  end;

  Link := TDateTimePickerToOLDate.Create;
  Link.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := ValidationFunction;
  // Get or create multicaster for this OLDate
  if not FValueMulticasters.TryGetValue(@d, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@d, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  d.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLDate
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
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
function TOLLinkManager.DelphiDateTimeFormatToWindowsFormat(const
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


{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Lbl: TLabel; var d: OLDate; const
    ValidationFunction: TOLDateValidationFunction = nil);
{$ELSE}
procedure TOLLinkManager.Link(const Lbl: TLabel; var d: OLDate);
{$IFEND}
var
  Link: TOLDateToLabel;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TOLDateToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := ValidationFunction;
  // Get or create multicaster for this OLDate
  if not FValueMulticasters.TryGetValue(@d, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@d, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  d.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLDate
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Edit: TDateTimePicker; var d: OLDateTime;
    const ValidationFunction: TOLDateTimeValidationFunction = nil);
{$ELSE}
procedure TOLLinkManager.Link(const Edit: TDateTimePicker; var d: OLDateTime);
{$IFEND}
var
  Link: TDateTimePickerToOLDateTime;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
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
  Link.ValidationFunction := ValidationFunction;
  // Get or create multicaster for this OLDateTime
  if not FValueMulticasters.TryGetValue(@d, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@d, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  d.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLDateTime
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  Link.Edit := Edit;
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Edit: TCheckBox; var b: OLBoolean; const ValidationFunction: TOLBooleanValidationFunction = nil);
{$ELSE}
procedure TOLLinkManager.Link(const Edit: TCheckBox; var b: OLBoolean);
{$IFEND}
var
  Link: TCheckBoxToOLBoolean;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TCheckBoxToOLBoolean.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @b;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := ValidationFunction;

  // Get or create multicaster for this OLBoolean
  if not FValueMulticasters.TryGetValue(@b, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@b, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  b.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLBoolean
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Link);

  Link.RefreshControl();
end;


procedure TOLLinkManager.Link(const Lbl: TLabel; const f:
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

procedure TOLLinkManager.Link(const Lbl: TLabel; const f:
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

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Lbl: TLabel; var s: OLString; const ValidationFunction: TOLStringValidationFunction = nil);
{$ELSE}
procedure TOLLinkManager.Link(const Lbl: TLabel; var s: OLString);
{$IFEND}
var
  Link: TOLStringToLabel;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TOLStringToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @s;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := ValidationFunction;
  // Get or create multicaster for this OLString
  if not FValueMulticasters.TryGetValue(@s, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@s, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  s.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLString
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

procedure TOLLinkManager.Link(const Lbl: TLabel; const f: TFunctionReturningOLDouble; const Format: string = DOUBLE_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING);
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

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Lbl: TLabel; var d: OLDouble; const ValidationFunction: TOLDoubleValidationFunction = nil; const Format: string = DOUBLE_FORMAT);
{$ELSE}
procedure TOLLinkManager.Link(const Lbl: TLabel; var d: OLDouble; const Format: string = DOUBLE_FORMAT);
{$IFEND}
var
  Link: TOLDoubleToLabel;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TOLDoubleToLabel.Create;
  Link.FFormat := Format;
  Link.Lbl := Lbl;
  Link.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := ValidationFunction;
  // Get or create multicaster for this OLDouble
  if not FValueMulticasters.TryGetValue(@d, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@d, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  d.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLDouble
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

procedure TOLLinkManager.Link(const Lbl: TLabel; const f: TFunctionReturningOLCurrency; const Format: string = CURRENCY_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING);
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

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Lbl: TLabel; var curr: OLCurrency; const ValidationFunction: TOLCurrencyValidationFunction = nil; const Format: string = CURRENCY_FORMAT);
{$ELSE}
procedure TOLLinkManager.Link(const Lbl: TLabel; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT);
{$IFEND}
var
  Link: TOLCurrencyToLabel;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TOLCurrencyToLabel.Create;
  Link.FFormat := Format;
  Link.Lbl := Lbl;
  Link.FOLPointer := @curr;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := ValidationFunction;
  // Get or create multicaster for this OLCurrency
  if not FValueMulticasters.TryGetValue(@curr, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@curr, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  curr.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLCurrency
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

procedure TOLLinkManager.Link(const Lbl: TLabel; const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string);
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

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Lbl: TLabel; var d: OLDateTime; const
    ValidationFunction: TOLDateTimeValidationFunction = nil);
{$ELSE}
procedure TOLLinkManager.Link(const Lbl: TLabel; var d: OLDateTime);
{$IFEND}
var
  Link: TOLDateTimeToLabel;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TOLDateTimeToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := ValidationFunction;
  // Get or create multicaster for this OLDateTime
  if not FValueMulticasters.TryGetValue(@d, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@d, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  d.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLDateTime
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

 procedure TOLLinkManager.Link(const Lbl: TLabel; const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string);
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

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Edit: TSpinEdit; var i: OLInteger; const ValidationFunction: TOLIntegerValidationFunction = nil);
{$ELSE}
procedure TOLLinkManager.Link(const Edit: TSpinEdit; var i: OLInteger);
{$IFEND}
var
  Link: TSpinEditToOLInteger;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TSpinEditToOLInteger.Create;
  Link.Edit := Edit;
  Link.FOLPointer := @i;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := ValidationFunction;
  // Get or create multicaster for this OLInteger
  if not FValueMulticasters.TryGetValue(@i, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@i, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  i.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLInteger
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Link);

  Link.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
procedure TOLLinkManager.Link(const Lbl: TLabel; var i: OLInteger; const ValidationFunction: TOLIntegerValidationFunction = nil);
{$ELSE}
procedure TOLLinkManager.Link(const Lbl: TLabel; var i: OLInteger);
{$IFEND}
var
  Link: TOLIntegerToLabel;
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Link := TOLIntegerToLabel.Create;
  Link.Lbl := Lbl;
  Link.FOLPointer := @i;
  {$IF CompilerVersion >= 34.0}
  Link.ValidationFunction := ValidationFunction;
  // Get or create multicaster for this OLInteger
  if not FValueMulticasters.TryGetValue(@i, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@i, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  i.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLInteger
  ValueMulticaster.AddLink(Link);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Lbl, Link);

  Link.RefreshControl();
end;

procedure TOLLinkManager.RefreshControls(FormToRefresh: TForm = nil);
var
  List: TObjectList<TOLControlLink>;
  Link: TOLControlLink;
begin
  if not Assigned(FControlLinks) then Exit;

  if Assigned(FormToRefresh) then
  begin
    if FControlLinks.TryGetValue(FormToRefresh, List) then
    begin
      for Link in List do
        Link.RefreshControl;
    end;
  end
  else
  begin
    for List in FControlLinks.Values do
    begin
      for Link in List do
        Link.RefreshControl;
    end;
  end;
end;

procedure TOLLinkManager.RemoveLinks(DestroyedForm: TForm = nil);
var
  List: TObjectList<TOLControlLink>;
  Timer: TTimer;
  CleanupHook: TComponent;
  Multicaster: TOLValueMulticaster;
  MulticastersToRemove: TList<Pointer>;
  OLIntPtr: POLInteger;
begin
  if DestroyedForm <> nil then
  begin
    if not Assigned(FControlLinks) then Exit;

    // Remove CleanupHook
    if FFormCleanupHooks.TryGetValue(DestroyedForm, CleanupHook) then
    begin
      FFormCleanupHooks.Remove(DestroyedForm);
      // CleanupHook is owned by Form, so Form will free it automatically.
      // We just remove it from our dictionary to avoid double-cleanup.
      // If the Form is being destroyed, CleanupHook.Destroy will call RemoveLinks anyway.
    end;

    // Remove Timer
    if FRefreshTimers.TryGetValue(DestroyedForm, Timer) then
    begin
      FRefreshTimers.Remove(DestroyedForm);
      Timer.Enabled := False;
      Timer.Free;
    end;

    if FControlLinks.TryGetValue(DestroyedForm, List) then
    begin
      // Remove links from multicasters before freeing
      {$IF CompilerVersion >= 34.0}
      if Assigned(FValueMulticasters) then
      begin
        for var Link in List do
        begin
          // Find and remove this link from any multicaster
          for var MulticasterPair in FValueMulticasters do
          begin
            Multicaster := MulticasterPair.Value as TOLValueMulticaster;
            Multicaster.RemoveLink(Link);  // Safe to call even if link not in multicaster
          end;
        end;

        // Clean up empty multicasters
        MulticastersToRemove := TList<Pointer>.Create;
        try
          for var MulticasterPair in FValueMulticasters do
          begin
            Multicaster := MulticasterPair.Value as TOLValueMulticaster;
            if Multicaster.IsEmpty then
              MulticastersToRemove.Add(MulticasterPair.Key);
          end;

          for var OLPointer in MulticastersToRemove do
          begin
            Multicaster := FValueMulticasters[OLPointer] as TOLValueMulticaster;
            FValueMulticasters.Remove(OLPointer);

            // Set OnChange := nil on the OLInteger variable before freeing multicaster
            // This prevents Access Violations when the variable is reused later
            // All OL types have OnChange at the same offset, so we can use POLInteger
            OLIntPtr := POLInteger(OLPointer);
            if Assigned(OLIntPtr) then
              OLIntPtr^.OnChange := nil;

            Multicaster.Free;
          end;
        finally
          MulticastersToRemove.Free;
        end;
      end;
      {$IFEND}

      List.Free;  // Free the list and all its link objects
      FControlLinks.Remove(DestroyedForm);
    end;
  end;
end;

function TOLLinkManager.GetLinkForControl(AControl: TControl): TOLControlLink;
var
  Form: TCustomForm;
  List: TObjectList<TOLControlLink>;
  Link: TOLControlLink;
begin
  Result := nil;
  Form := GetParentForm(AControl);

  if not Assigned(Form) then
    exit;

  if not (Form is TForm) then
    exit;

  if FControlLinks.TryGetValue(Form as TForm, List) then
  begin
    for Link in List do
    begin
      if Link.Control = AControl then
      begin
        Result := Link;
        Exit;
      end;
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

procedure TOLFormCleanupHook.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = Owner) then
  begin
    if Owner is TForm then
    begin
      if Owner is TForm then
        Links.RemoveLinks(Owner as TForm);
    end;
  end;

  inherited Notification(AComponent, Operation);
end;

initialization
  OLLinkManager := TOLLinkManager.Create;

finalization
  OLLinkManager.Free;

end.

