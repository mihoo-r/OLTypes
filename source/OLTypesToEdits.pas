unit OLTypesToEdits;

interface

uses 
  OLBooleanType, OLCurrencyType, OLDateTimeType, OLDateType, OLDoubleType,
  OLIntegerType, OLInt64Type, OLStringType,
  OLValidation, OLValidationTypes, {$IF CompilerVersion >= 23.0} System.Generics.Collections, {$ELSE} Generics.Collections, {$IFEND}
  {$IF CompilerVersion >= 23.0}
  Vcl.StdCtrls, System.SysUtils, Vcl.Samples.Spin, Vcl.ComCtrls, Vcl.Forms,
  System.Classes, Vcl.Controls, Messages, Winapi.Windows, Vcl.ExtCtrls,
  Vcl.Graphics;
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
    {$IF CompilerVersion >= 34.0}
    procedure ShowValidationState(vr: TOLValidationResult); virtual;
    {$IFEND}
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
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements: TStyleElements;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    FValidators: TList<TOLValidationFunction<T>>;
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
    function GetValidationFunction: TOLValidationFunction<T>;
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
    function AddValidator(const Value: TOLValidationFunction<T>): TOLEditLink<T>;
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(const v: T): TOLValidationResult; virtual;
    property ValidationFunction: TOLValidationFunction<T> read GetValidationFunction write SetValidationFunction;
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
  public
    {$IF CompilerVersion >= 34.0}
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLIntegerValidationFunction): TEditToOLInteger;
    /// <summary>Adds a validation rule: value is required. For OLInteger, it checks if it has a value.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLInteger;
    /// <summary>Adds a validation rule: value must be at least MinVal.</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Min(const MinVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLInteger;
    /// <summary>Adds a validation rule: value must be at most MaxVal.</summary>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Max(const MaxVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLInteger;
    /// <summary>Adds a validation rule: value must be between MinVal and MaxVal (inclusive).</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Between(const MinVal, MaxVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLInteger;
    /// <summary>Adds a validation rule: value must be greater than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Positive(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLInteger;
    /// <summary>Adds a validation rule: value must be less than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Negative(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLInteger;
    {$IFEND}
  end;

  TSpinEditToOLInteger = class(TOLControlLink)
  private
    FEdit: TSpinEdit;
    FEditOnChange: TEditOnChange;
    FEditOnExit: TNotifyEvent;
    FOLPointer: POLInteger;
    FUpdatingFromControl: Boolean;
    {$IF CompilerVersion >= 34.0}
    FValidators: TList<TOLIntegerValidationFunction>;
    {$IFEND}
    FOriginalColor: TColor;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements: TStyleElements;
    {$IFEND}
    procedure NewOnExit(Sender: TObject);
    procedure SetEdit(const Value: TSpinEdit);
    procedure SetOLPointer(const Value: POLInteger);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLIntegerValidationFunction;
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
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLIntegerValidationFunction): TSpinEditToOLInteger;
    /// <summary>Adds a validation rule: value is required. For OLInteger, it checks if it has a value.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TSpinEditToOLInteger;
    /// <summary>Adds a validation rule: value must be at least MinVal.</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Min(const MinVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TSpinEditToOLInteger;
    /// <summary>Adds a validation rule: value must be at most MaxVal.</summary>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Max(const MaxVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TSpinEditToOLInteger;
    /// <summary>Adds a validation rule: value must be between MinVal and MaxVal (inclusive).</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Between(const MinVal, MaxVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TSpinEditToOLInteger;
    /// <summary>Adds a validation rule: value must be greater than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Positive(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TSpinEditToOLInteger;
    /// <summary>Adds a validation rule: value must be less than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Negative(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TSpinEditToOLInteger;
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(i: OLInteger): TOLValidationResult;
    {$IFEND}

    property Edit: TSpinEdit read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;

    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLIntegerValidationFunction read GetValidationFunction write SetValidationFunction;
    {$IFEND}

  end;

  TScrollBarToOLInteger = class(TOLControlLink)
  private
    FEdit: TScrollBar;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    {$IF CompilerVersion >= 34.0}
    FValidators: TList<TOLIntegerValidationFunction>;
    {$IFEND}
    FWarningLabel: TLabel;
    procedure SetEdit(const Value: TScrollBar);
    procedure SetOLPointer(const Value: POLInteger);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLIntegerValidationFunction;
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
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLIntegerValidationFunction): TScrollBarToOLInteger;
    /// <summary>Adds a validation rule: value is required. For OLInteger, it checks if it has a value.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TScrollBarToOLInteger;
    /// <summary>Adds a validation rule: value must be at least MinVal.</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Min(const MinVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TScrollBarToOLInteger;
    /// <summary>Adds a validation rule: value must be at most MaxVal.</summary>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Max(const MaxVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TScrollBarToOLInteger;
    /// <summary>Adds a validation rule: value must be between MinVal and MaxVal (inclusive).</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Between(const MinVal, MaxVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TScrollBarToOLInteger;
    /// <summary>Adds a validation rule: value must be greater than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Positive(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TScrollBarToOLInteger;
    /// <summary>Adds a validation rule: value must be less than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Negative(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TScrollBarToOLInteger;
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(i: OLInteger): TOLValidationResult;
    {$IFEND}
    property Edit: TScrollBar read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLIntegerValidationFunction read GetValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TTrackBarToOLInteger = class(TOLControlLink)
  private
    FEdit: TTrackBar;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLInteger;
    {$IF CompilerVersion >= 34.0}
    FValidators: TList<TOLIntegerValidationFunction>;
    {$IFEND}
    FWarningLabel: TLabel;
    procedure SetEdit(const Value: TTrackBar);
    procedure SetOLPointer(const Value: POLInteger);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLIntegerValidationFunction;
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
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLIntegerValidationFunction): TTrackBarToOLInteger;
    /// <summary>Adds a validation rule: value is required. For OLInteger, it checks if it has a value.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TTrackBarToOLInteger;
    /// <summary>Adds a validation rule: value must be at least MinVal.</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Min(const MinVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TTrackBarToOLInteger;
    /// <summary>Adds a validation rule: value must be at most MaxVal.</summary>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Max(const MaxVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TTrackBarToOLInteger;
    /// <summary>Adds a validation rule: value must be between MinVal and MaxVal (inclusive).</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Between(const MinVal, MaxVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TTrackBarToOLInteger;
    /// <summary>Adds a validation rule: value must be greater than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Positive(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TTrackBarToOLInteger;
    /// <summary>Adds a validation rule: value must be less than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Negative(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TTrackBarToOLInteger;
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(i: OLInteger): TOLValidationResult;
    {$IFEND}
    property Edit: TTrackBar read FEdit write SetEdit;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLIntegerValidationFunction read GetValidationFunction write SetValidationFunction;
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
    FValidators: TList<TOLDoubleValidationFunction>;
    {$IFEND}
    FOriginalColor: TColor;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements: TStyleElements;
    {$IFEND}
    procedure SetEdit(const Value: TEdit);

    procedure SetOLPointer(const Value: POLDouble);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLDoubleValidationFunction;
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
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLDoubleValidationFunction): TEditToOLDouble;
    /// <summary>Adds a validation rule: value is required. For OLDouble, it checks if it has a value.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLDouble;
    /// <summary>Adds a validation rule: value must be at least MinVal.</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Min(const MinVal: Double; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLDouble;
    /// <summary>Adds a validation rule: value must be at most MaxVal.</summary>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Max(const MaxVal: Double; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLDouble;
    /// <summary>Adds a validation rule: value must be between MinVal and MaxVal (inclusive).</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Between(const MinVal, MaxVal: Double; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLDouble;
    /// <summary>Adds a validation rule: value must be greater than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Positive(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLDouble;
    /// <summary>Adds a validation rule: value must be less than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Negative(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLDouble;
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(d: OLDouble): TOLValidationResult;
    {$IFEND}
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLDouble read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLDoubleValidationFunction read
        GetValidationFunction write SetValidationFunction;
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
    FValidators: TList<TOLCurrencyValidationFunction>;
    {$IFEND}
    FOriginalColor: TColor;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements: TStyleElements;
    {$IFEND}
    procedure SetEdit(const Value: TEdit);
    procedure SetOLPointer(const Value: POLCurrency);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLCurrencyValidationFunction;
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
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLCurrencyValidationFunction): TEditToOLCurrency;
    /// <summary>Adds a validation rule: value is required. For OLCurrency, it checks if it has a value.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLCurrency;
    /// <summary>Adds a validation rule: value must be at least MinVal.</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Min(const MinVal: Currency; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLCurrency;
    /// <summary>Adds a validation rule: value must be at most MaxVal.</summary>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Max(const MaxVal: Currency; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLCurrency;
    /// <summary>Adds a validation rule: value must be between MinVal and MaxVal (inclusive).</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Between(const MinVal, MaxVal: Currency; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLCurrency;
    /// <summary>Adds a validation rule: value must be greater than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Positive(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLCurrency;
    /// <summary>Adds a validation rule: value must be less than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Negative(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLCurrency;
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(c: OLCurrency): TOLValidationResult;
    {$IFEND}
    property Edit: TEdit read FEdit write SetEdit;
    property OLPointer: POLCurrency read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLCurrencyValidationFunction read
        GetValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TEditToOLString = class(TOLEditLink<OLString>)
  protected
    function ValToString(const v: OLString): string; override;
    function StringToVal(const s: string; out v: OLString): Boolean; override;
    function GetNull: OLString; override;
    function TreatEmptyAsNull: Boolean; override;
  public
    {$IF CompilerVersion >= 34.0}
    /// <summary>Adds a validation rule: value must be a valid PESEL (Poland).</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Pesel(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: value is required. For OLString, it checks if it is not null and not empty.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: string length must be at least MinLen.</summary>
    /// <param name="MinLen">Minimum character count.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function MinLength(const MinLen: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: string length must be at most MaxLen.</summary>
    /// <param name="MaxLen">Maximum character count.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function MaxLength(const MaxLen: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: string must contain only alphanumeric characters.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AlphaNumeric(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: string must contain only digits.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function DigitsOnly(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: string must be a valid email address.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Email(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: string must meet password complexity requirements.</summary>
    /// <param name="MinLen">Minimum password length.</param>
    /// <param name="RequireMixedCase">Whether to require both upper and lower case letters.</param>
    /// <param name="RequireDigits">Whether to require numeric digits.</param>
    /// <param name="RequireSpecialChar">Whether to require special characters.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Password(const MinLen: Integer = 8; const RequireMixedCase: Boolean = True; const RequireDigits: Boolean = True; const RequireSpecialChar: Boolean = False; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: string must be a valid URL.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function URL(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: string must be a valid Credit Card number (Luhn check).</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function CreditCard(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: string must be a valid EAN code.</summary>
    /// <param name="IsGTIN14">True if checking for GTIN-14 specifically.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function EAN(const IsGTIN14: Boolean = False; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: string must be a valid BIC/SWIFT code.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function BIC(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: string must be a valid IPv4 address.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function IPv4(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: string must be a valid IPv6 address.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function IPv6(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: string must be a valid IBAN.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function IBAN(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    /// <summary>Adds a validation rule: value must be a valid NIP (Poland).</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function NIP(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TEditToOLString;
    {$IFEND}
  end;


  TMemoToOLString = class(TOLControlLink)
  private
    FEdit: TMemo;
    FEditOnChange: TEditOnChange;
    FOLPointer: POLString;
    {$IF CompilerVersion >= 34.0}
    FValidators: TList<TOLStringValidationFunction>;
    {$IFEND}
    FOriginalColor: TColor;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements: TStyleElements;
    {$IFEND}
    procedure SetEdit(const Value: TMemo);
    procedure SetOLPointer(const Value: POLString);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLStringValidationFunction;
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
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLStringValidationFunction): TMemoToOLString;
    /// <summary>Adds a validation rule: value must be a valid PESEL (Poland).</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Pesel(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: value is required. For OLString, it checks if it is not null and not empty.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: string length must be at least MinLen.</summary>
    /// <param name="MinLen">Minimum character count.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function MinLength(const MinLen: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: string length must be at most MaxLen.</summary>
    /// <param name="MaxLen">Maximum character count.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function MaxLength(const MaxLen: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: string must contain only alphanumeric characters.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AlphaNumeric(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: string must contain only digits.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function DigitsOnly(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: string must be a valid email address.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Email(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: string must meet password complexity requirements.</summary>
    /// <param name="MinLen">Minimum password length.</param>
    /// <param name="RequireMixedCase">Whether to require both upper and lower case letters.</param>
    /// <param name="RequireDigits">Whether to require numeric digits.</param>
    /// <param name="RequireSpecialChar">Whether to require special characters.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Password(const MinLen: Integer = 8; const RequireMixedCase: Boolean = True; const RequireDigits: Boolean = True; const RequireSpecialChar: Boolean = False; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: string must be a valid URL.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function URL(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: string must be a valid Credit Card number (Luhn check).</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function CreditCard(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: string must be a valid EAN code.</summary>
    /// <param name="IsGTIN14">True if checking for GTIN-14 specifically.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function EAN(const IsGTIN14: Boolean = False; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: string must be a valid BIC/SWIFT code.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function BIC(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: string must be a valid IPv4 address.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function IPv4(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: string must be a valid IPv6 address.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function IPv6(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: string must be a valid IBAN.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function IBAN(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    /// <summary>Adds a validation rule: value must be a valid NIP (Poland).</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function NIP(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TMemoToOLString;
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(s: OLString): TOLValidationResult;
    {$IFEND}
    property Edit: TMemo read FEdit write SetEdit;
    property OLPointer: POLString read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLStringValidationFunction read
        GetValidationFunction write SetValidationFunction;
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
    FValidators: TList<TOLDateValidationFunction>;
    {$IFEND}
    FWarningLabel: TLabel;
    NotNullFormat: string;
    LastTwoKeys, LastThreeKeys: OLString;
    FOriginalWindowProc: TWndMethod;
    FUpdatingFromRefresh: Boolean;
    FUpdatingFromControl: Boolean;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements: TStyleElements;
    {$IFEND}


    procedure NewWindowProc(var Message: TMessage);
    procedure SetEdit(const Value: TDateTimePicker);
    procedure SetOLPointer(const Value: POLDate);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLDateValidationFunction;
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
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLDateValidationFunction): TDateTimePickerToOLDate;
    /// <summary>Adds a validation rule: value is required. For OLDate, it checks if it has a value.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TDateTimePickerToOLDate;
    /// <summary>Adds a validation rule: date must be at least MinVal.</summary>
    /// <param name="MinVal">Minimum allowed date.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Min(const MinDate: TDate; const AColor: TColor; const ErrorMessage:
        string): TDateTimePickerToOLDate;
    /// <summary>Adds a validation rule: date must be at most MaxVal.</summary>
    /// <param name="MaxVal">Maximum allowed date.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Max(const MaxDate: TDate; const AColor: TColor; const ErrorMessage:
        string): TDateTimePickerToOLDate;
    /// <summary>Adds a validation rule: date must be between MinVal and MaxVal (inclusive).</summary>
    /// <param name="MinVal">Minimum allowed date.</param>
    /// <param name="MaxVal">Maximum allowed date.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Between(const MinDate, MaxDate: TDate; const AColor: TColor; const
        ErrorMessage: string): TDateTimePickerToOLDate;
    /// <summary>Adds a validation rule: date must be in the past.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Past(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TDateTimePickerToOLDate;
    /// <summary>Adds a validation rule: date must be in the future.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Future(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TDateTimePickerToOLDate;
    /// <summary>Adds a validation rule: date must be today.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Today(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TDateTimePickerToOLDate;
    /// <summary>Adds a validation rule: birth date implies a minimum age.</summary>
    /// <param name="Age">Minimum required age.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function MinAge(const Age: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TDateTimePickerToOLDate;
    /// <summary>Adds a validation rule: birth date implies a maximum age.</summary>
    /// <param name="Age">Maximum allowed age.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function MaxAge(const Age: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TDateTimePickerToOLDate;
    /// <summary>Adds a validation rule: date must be a weekday (Mon-Fri).</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function IsWeekday(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TDateTimePickerToOLDate;
    /// <summary>Adds a validation rule: date must be a weekend (Sat-Sun).</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function IsWeekend(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TDateTimePickerToOLDate;
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(d: OLDate): TOLValidationResult;
    {$IFEND}
    property Edit: TDateTimePicker read FEdit write SetEdit;
    property OLPointer: POLDate read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLDateValidationFunction read
        GetValidationFunction write SetValidationFunction;
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
    FValidators: TList<TOLDateTimeValidationFunction>;
    {$IFEND}
    FWarningLabel: TLabel;
    NotNullFormat: string;
    LastTwoKeys, LastThreeKeys: OLString;
    FOriginalWindowProc: TWndMethod;
    FUpdatingFromRefresh: Boolean;
    FUpdatingFromControl: Boolean;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements: TStyleElements;
    {$IFEND}


    procedure NewWindowProc(var Message: TMessage);
    procedure SetEdit(const Value: TDateTimePicker);
    procedure SetOLPointer(const Value: POLDateTime);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLDateTimeValidationFunction;
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
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLDateTimeValidationFunction): TDateTimePickerToOLDateTime;
    /// <summary>Adds a validation rule: value is required. For OLDateTime, it checks if it has a value.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TDateTimePickerToOLDateTime;
    /// <summary>Adds a validation rule: date/time must be at least MinVal.</summary>
    /// <param name="MinVal">Minimum allowed date/time.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Min(const MinDate: TDateTime; const AColor: TColor; const
        ErrorMessage: string): TDateTimePickerToOLDateTime;
    /// <summary>Adds a validation rule: date/time must be at most MaxVal.</summary>
    /// <param name="MaxVal">Maximum allowed date/time.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Max(const MaxDate: TDateTime; const AColor: TColor; const
        ErrorMessage: string): TDateTimePickerToOLDateTime;
    /// <summary>Adds a validation rule: date/time must be between MinVal and MaxVal (inclusive).</summary>
    /// <param name="MinVal">Minimum allowed date/time.</param>
    /// <param name="MaxVal">Maximum allowed date/time.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Between(const MinDate, MaxDate: TDateTime; const AColor: TColor; const
        ErrorMessage: string): TDateTimePickerToOLDateTime;
    /// <summary>Adds a validation rule: date/time must be in the past.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Past(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TDateTimePickerToOLDateTime;
    /// <summary>Adds a validation rule: date/time must be in the future.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Future(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TDateTimePickerToOLDateTime;

    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(dt: OLDateTime): TOLValidationResult;
    {$IFEND}
    property Edit: TDateTimePicker read FEdit write SetEdit;
    property OLPointer: POLDateTime read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLDateTimeValidationFunction read
        GetValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TCheckBoxToOLBoolean = class(TOLControlLink)
  private
    FEdit: TCheckBox;
    FEditOnClick: TEditOnClick;
    FOLPointer: POLBoolean;
    {$IF CompilerVersion >= 34.0}
    FValidators: TList<TOLBooleanValidationFunction>;
    {$IFEND}
    FOriginalFontColor: TColor;
    FOriginalHint: string;
    FOriginalShowHint: Boolean;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements: TStyleElements;
    {$IFEND}
    FWarningLabel: TLabel;
    FAllowGrayed: Boolean;
    procedure SetEdit(const Value: TCheckBox);
    procedure SetOLPointer(const Value: POLBoolean);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLBooleanValidationFunction;
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
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLBooleanValidationFunction): TCheckBoxToOLBoolean;
    /// <summary>Adds a validation rule: value is required. For OLBoolean, it checks if it has a value.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage:
        string = ''): TCheckBoxToOLBoolean;
    function ValueIsValid(b: OLBoolean): TOLValidationResult;
    procedure ShowValidationState(vr: TOLValidationResult); override;
    {$IFEND}
    property Edit: TCheckBox read FEdit write SetEdit;
    property OLPointer: POLBoolean read FOLPointer write SetOLPointer;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLBooleanValidationFunction read
        GetValidationFunction write SetValidationFunction;
    {$IFEND}
    property AllowGrayed: Boolean read FAllowGrayed write FAllowGrayed;
  end;

  TOLIntegerToLabel = class(TOLControlLink)
  private
    FLabel: TLabel;
    FOLPointer: POLInteger;
    FCalculation: TFunctionReturningOLInteger;
    FValueOnErrorInCalculation: OLString;
    {$IF CompilerVersion >= 34.0}
    FValidators: TList<TOLIntegerValidationFunction>;
    {$IFEND}
    FOriginalFontColor: TColor;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements: TStyleElements;
    {$IFEND}

    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLInteger);
    procedure SetCalculation(const Value: TFunctionReturningOLInteger);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLIntegerValidationFunction;
    procedure SetValidationFunction(const Value: TOLIntegerValidationFunction);
    {$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    function NeedsTimer: Boolean; override;
    {$IF CompilerVersion >= 34.0}
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLIntegerValidationFunction): TOLIntegerToLabel;
    /// <summary>Adds a validation rule: value is required. For OLInteger, it checks if it has a value.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLIntegerToLabel;
    /// <summary>Adds a validation rule: value must be at least MinVal.</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Min(const MinVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLIntegerToLabel;
    /// <summary>Adds a validation rule: value must be at most MaxVal.</summary>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Max(const MaxVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLIntegerToLabel;
    /// <summary>Adds a validation rule: value must be between MinVal and MaxVal (inclusive).</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Between(const MinVal, MaxVal: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLIntegerToLabel;
    /// <summary>Adds a validation rule: value must be greater than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Positive(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLIntegerToLabel;
    /// <summary>Adds a validation rule: value must be less than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Negative(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLIntegerToLabel;
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(i: OLInteger): TOLValidationResult;
    property ValidationFunction: TOLIntegerValidationFunction read GetValidationFunction write SetValidationFunction;
    {$IFEND}
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLInteger read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLInteger read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;

  end;

  TOLStringToLabel = class(TOLControlLink)
  private
    FLabel: TLabel;
    FOLPointer: POLString;
    FCalculation: TFunctionReturningOLString;
    FValueOnErrorInCalculation: OLString;
    {$IF CompilerVersion >= 34.0}
    FValidators: TList<TOLStringValidationFunction>;
    {$IFEND}
    FOriginalFontColor: TColor;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements: TStyleElements;
    {$IFEND}
    procedure SetLabel(const Value: TLabel);

    procedure SetOLPointer(const Value: POLString);
    procedure SetCalculation(const Value: TFunctionReturningOLString);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLStringValidationFunction;
    procedure SetValidationFunction(const Value: TOLStringValidationFunction);
    {$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure RefreshControl; override;
    function NeedsTimer: Boolean; override;
    {$IF CompilerVersion >= 34.0}
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLStringValidationFunction): TOLStringToLabel;
    /// <summary>Adds a validation rule: value must be a valid PESEL (Poland).</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Pesel(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: value is required. For OLString, it checks if it is not null and not empty.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: string length must be at least MinLen.</summary>
    /// <param name="MinLen">Minimum character count.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function MinLength(const MinLen: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: string length must be at most MaxLen.</summary>
    /// <param name="MaxLen">Maximum character count.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function MaxLength(const MaxLen: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: string must contain only alphanumeric characters.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AlphaNumeric(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: string must contain only digits.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function DigitsOnly(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: string must be a valid email address.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Email(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: string must meet password complexity requirements.</summary>
    /// <param name="MinLen">Minimum password length.</param>
    /// <param name="RequireMixedCase">Whether to require both upper and lower case letters.</param>
    /// <param name="RequireDigits">Whether to require numeric digits.</param>
    /// <param name="RequireSpecialChar">Whether to require special characters.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Password(const MinLen: Integer = 8; const RequireMixedCase: Boolean = True; const RequireDigits: Boolean = True; const RequireSpecialChar: Boolean = False; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: string must be a valid URL.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function URL(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: string must be a valid Credit Card number (Luhn check).</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function CreditCard(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: string must be a valid EAN code.</summary>
    /// <param name="IsGTIN14">True if checking for GTIN-14 specifically.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function EAN(const IsGTIN14: Boolean = False; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: string must be a valid BIC/SWIFT code.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function BIC(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: string must be a valid IPv4 address.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function IPv4(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: string must be a valid IPv6 address.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function IPv6(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: string must be a valid IBAN.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function IBAN(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    /// <summary>Adds a validation rule: value must be a valid NIP (Poland).</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function NIP(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLStringToLabel;
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(s: OLString): TOLValidationResult;
    {$IFEND}
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLString read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLString read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLStringValidationFunction read
        GetValidationFunction write SetValidationFunction;
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
    FValidators: TList<TOLDoubleValidationFunction>;
    {$IFEND}
    FOriginalFontColor: TColor;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements: TStyleElements;
    {$IFEND}
    procedure SetLabel(const Value: TLabel);

    procedure SetOLPointer(const Value: POLDouble);
    procedure SetCalculation(const Value: TFunctionReturningOLDouble);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLDoubleValidationFunction;
    procedure SetValidationFunction(const Value: TOLDoubleValidationFunction);
    {$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    function NeedsTimer: Boolean; override;
    {$IF CompilerVersion >= 34.0}
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLDoubleValidationFunction): TOLDoubleToLabel;
    /// <summary>Adds a validation rule: value is required. For OLDouble, it checks if it has a value.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDoubleToLabel;
    /// <summary>Adds a validation rule: value must be at least MinVal.</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Min(const MinVal: Double; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDoubleToLabel;
    /// <summary>Adds a validation rule: value must be at most MaxVal.</summary>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Max(const MaxVal: Double; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDoubleToLabel;
    /// <summary>Adds a validation rule: value must be between MinVal and MaxVal (inclusive).</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Between(const MinVal, MaxVal: Double; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDoubleToLabel;
    /// <summary>Adds a validation rule: value must be greater than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Positive(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDoubleToLabel;
    /// <summary>Adds a validation rule: value must be less than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Negative(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDoubleToLabel;
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(d: OLDouble): TOLValidationResult;
    {$IFEND}
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLDouble read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLDouble read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLDoubleValidationFunction read
        GetValidationFunction write SetValidationFunction;
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
    FValidators: TList<TOLCurrencyValidationFunction>;
    {$IFEND}
    FOriginalFontColor: TColor;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements: TStyleElements;
    {$IFEND}
    procedure SetLabel(const Value: TLabel);

    procedure SetOLPointer(const Value: POLCurrency);
    procedure SetCalculation(const Value: TFunctionReturningOLCurrency);
    procedure SetValueOnErrorInCalculation(const Value: OLString);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLCurrencyValidationFunction;
    procedure SetValidationFunction(const Value: TOLCurrencyValidationFunction);
    {$IFEND}
  public
    constructor Create;
    destructor Destroy; override;
    procedure OnOLChange(Sender: TObject);
    procedure RefreshControl; override;
    function NeedsTimer: Boolean; override;
    {$IF CompilerVersion >= 34.0}
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLCurrencyValidationFunction): TOLCurrencyToLabel;
    /// <summary>Adds a validation rule: value is required. For OLCurrency, it checks if it has a value.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLCurrencyToLabel;
    /// <summary>Adds a validation rule: value must be at least MinVal.</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Min(const MinVal: Currency; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLCurrencyToLabel;
    /// <summary>Adds a validation rule: value must be at most MaxVal.</summary>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Max(const MaxVal: Currency; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLCurrencyToLabel;
    /// <summary>Adds a validation rule: value must be between MinVal and MaxVal (inclusive).</summary>
    /// <param name="MinVal">Minimum allowed value.</param>
    /// <param name="MaxVal">Maximum allowed value.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Between(const MinVal, MaxVal: Currency; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLCurrencyToLabel;
    /// <summary>Adds a validation rule: value must be greater than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Positive(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLCurrencyToLabel;
    /// <summary>Adds a validation rule: value must be less than zero.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Negative(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLCurrencyToLabel;
    procedure ShowValidationState(vr: TOLValidationResult); override;
    function ValueIsValid(c: OLCurrency): TOLValidationResult;
    {$IFEND}
    property Lbl: TLabel read FLabel write SetLabel;
    property OLPointer: POLCurrency read FOLPointer write SetOLPointer;
    property Calculation: TFunctionReturningOLCurrency read FCalculation write SetCalculation;
    property ValueOnErrorInCalculation: OLString read FValueOnErrorInCalculation write SetValueOnErrorInCalculation;
    {$IF CompilerVersion >= 34.0}
    property ValidationFunction: TOLCurrencyValidationFunction read
        GetValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TOLDateToLabel = class(TOLControlLink)
  private
    FLabel: TLabel;
    FOLPointer: POLDate;
    {$IF CompilerVersion >= 34.0}
    FValidators: TList<TOLDateValidationFunction>;
    {$IFEND}
    FOriginalFontColor: TColor;
    FCalculation: TFunctionReturningOLDate;
    FValueOnErrorInCalculation: OLString;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements: TStyleElements;
    {$IFEND}
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLDate);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLDateValidationFunction;
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
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLDateValidationFunction): TOLDateToLabel;
    /// <summary>Adds a validation rule: value is required. For OLDate, it checks if it has a value.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDateToLabel;
    /// <summary>Adds a validation rule: date must be at least MinVal.</summary>
    /// <param name="MinVal">Minimum allowed date.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Min(const MinDate: TDate; const AColor: TColor; const ErrorMessage:
        string): TOLDateToLabel;
    /// <summary>Adds a validation rule: date must be at most MaxVal.</summary>
    /// <param name="MaxVal">Maximum allowed date.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Max(const MaxDate: TDate; const AColor: TColor; const ErrorMessage:
        string): TOLDateToLabel;
    /// <summary>Adds a validation rule: date must be between MinVal and MaxVal (inclusive).</summary>
    /// <param name="MinVal">Minimum allowed date.</param>
    /// <param name="MaxVal">Maximum allowed date.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Between(const MinDate, MaxDate: TDate; const AColor: TColor; const
        ErrorMessage: string): TOLDateToLabel;
    /// <summary>Adds a validation rule: date must be in the past.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Past(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDateToLabel;
    /// <summary>Adds a validation rule: date must be in the future.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Future(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDateToLabel;
    /// <summary>Adds a validation rule: date must be today.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Today(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDateToLabel;
    /// <summary>Adds a validation rule: birth date implies a minimum age.</summary>
    /// <param name="Age">Minimum required age.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function MinAge(const Age: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDateToLabel;
    /// <summary>Adds a validation rule: birth date implies a maximum age.</summary>
    /// <param name="Age">Maximum allowed age.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function MaxAge(const Age: Integer; const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDateToLabel;
    /// <summary>Adds a validation rule: date must be a weekday (Mon-Fri).</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function IsWeekday(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDateToLabel;
    /// <summary>Adds a validation rule: date must be a weekend (Sat-Sun).</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function IsWeekend(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDateToLabel;
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
        GetValidationFunction write SetValidationFunction;
    {$IFEND}
  end;

  TOLDateTimeToLabel = class(TOLControlLink)
  private
    FLabel: TLabel;
    FOLPointer: POLDateTime;
    {$IF CompilerVersion >= 34.0}
    FValidators: TList<TOLDateTimeValidationFunction>;
    {$IFEND}
    FOriginalFontColor: TColor;
    FCalculation: TFunctionReturningOLDateTime;
    FValueOnErrorInCalculation: OLString;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements: TStyleElements;
    {$IFEND}
    procedure SetLabel(const Value: TLabel);
    procedure SetOLPointer(const Value: POLDateTime);
    {$IF CompilerVersion >= 34.0}
    function GetValidationFunction: TOLDateTimeValidationFunction;
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
    /// <summary>Adds a manual validation function to the list of validators.</summary>
    /// <param name="Value">The validation function to add.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function AddValidator(const Value: TOLDateTimeValidationFunction): TOLDateTimeToLabel;
    /// <summary>Adds a validation rule: value is required. For OLDateTime, it checks if it has a value.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function RequireValue(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDateTimeToLabel;
    /// <summary>Adds a validation rule: date/time must be at least MinVal.</summary>
    /// <param name="MinVal">Minimum allowed date/time.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Min(const MinDate: TDateTime; const AColor: TColor; const
        ErrorMessage: string): TOLDateTimeToLabel;
    /// <summary>Adds a validation rule: date/time must be at most MaxVal.</summary>
    /// <param name="MaxVal">Maximum allowed date/time.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Max(const MaxDate: TDateTime; const AColor: TColor; const
        ErrorMessage: string): TOLDateTimeToLabel;
    /// <summary>Adds a validation rule: date/time must be between MinVal and MaxVal (inclusive).</summary>
    /// <param name="MinVal">Minimum allowed date/time.</param>
    /// <param name="MaxVal">Maximum allowed date/time.</param>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Between(const MinDate, MaxDate: TDateTime; const AColor: TColor; const
        ErrorMessage: string): TOLDateTimeToLabel;
    /// <summary>Adds a validation rule: date/time must be in the past.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Past(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDateTimeToLabel;
    /// <summary>Adds a validation rule: date/time must be in the future.</summary>
    /// <param name="AColor">Color to set when validation fails.</param>
    /// <param name="ErrorMessage">Custom error message.</param>
    /// <returns>Returns Self for fluent API chaining.</returns>
    function Future(const AColor: TColor = clDefault; const ErrorMessage: string = ''): TOLDateTimeToLabel;
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
        GetValidationFunction write SetValidationFunction;
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
    function Link(const Edit: TEdit; var i: OLInteger; const Alignment: TAlignment=taRightJustify): TEditToOLInteger;
        overload;
    {$ELSE}
    function Link(const Edit: TEdit; var i: OLInteger; const Alignment: TAlignment=taRightJustify): TEditToOLInteger;
        overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    function Link(const Edit: TSpinEdit; var i: OLInteger): TSpinEditToOLInteger; overload;
    {$ELSE}
    function Link(const Edit: TSpinEdit; var i: OLInteger): TSpinEditToOLInteger; overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    function Link(const Edit: TTrackBar; var i: OLInteger): TTrackBarToOLInteger; overload;
    {$ELSE}
    function Link(const Edit: TTrackBar; var i: OLInteger): TTrackBarToOLInteger; overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    function Link(const Edit: TScrollBar; var i: OLInteger): TScrollBarToOLInteger; overload;
    {$ELSE}
    function Link(const Edit: TScrollBar; var i: OLInteger): TScrollBarToOLInteger; overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    function Link(const Edit: TEdit; var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLDouble; overload;
    {$ELSE}
    function Link(const Edit: TEdit; var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLDouble; overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    function Link(const Edit: TEdit; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLCurrency; overload;
    {$ELSE}
    function Link(const Edit: TEdit; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLCurrency; overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    function Link(const Edit: TEdit; var s: OLString): TEditToOLString; overload;
    {$ELSE}
    function Link(const Edit: TEdit; var s: OLString): TEditToOLString; overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    function Link(const Edit: TMemo; var s: OLString): TMemoToOLString; overload;
    {$ELSE}
    function Link(const Edit: TMemo; var s: OLString): TMemoToOLString; overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    function Link(const Edit: TDateTimePicker; var d: OLDate): TDateTimePickerToOLDate; overload;
    {$ELSE}
    function Link(const Edit: TDateTimePicker; var d: OLDate): TDateTimePickerToOLDate; overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    function Link(const Edit: TDateTimePicker; var d: OLDateTime): TDateTimePickerToOLDateTime; overload;
    {$ELSE}
    function Link(const Edit: TDateTimePicker; var d: OLDateTime): TDateTimePickerToOLDateTime; overload;
    {$IFEND}
    {$IF CompilerVersion >= 34.0}
    function Link(const Edit: TCheckBox; var b: OLBoolean; AllowGrayed: Boolean = False): TCheckBoxToOLBoolean; overload;
    {$ELSE}
    function Link(const Edit: TCheckBox; var b: OLBoolean; AllowGrayed: Boolean = False): TCheckBoxToOLBoolean; overload;
    {$IFEND}

    {$IF CompilerVersion >= 34.0}
    function Link(const Lbl: TLabel; var i: OLInteger): TOLIntegerToLabel; overload;
    {$ELSE}
    function Link(const Lbl: TLabel; var i: OLInteger): TOLIntegerToLabel; overload;
    {$IFEND}
    function Link(const Lbl: TLabel; const f: TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string = ERROR_STRING): TOLIntegerToLabel; overload;
    {$IF CompilerVersion >= 34.0}
    function Link(const Lbl: TLabel; var s: OLString): TOLStringToLabel; overload;
    {$ELSE}
    function Link(const Lbl: TLabel; var s: OLString): TOLStringToLabel; overload;
    {$IFEND}
    function Link(const Lbl: TLabel; const f: TFunctionReturningOLString; const ValueOnErrorInCalculation: string = ERROR_STRING): TOLStringToLabel; overload;
    {$IF CompilerVersion >= 34.0}
    function Link(const Lbl: TLabel; var d: OLDouble; const Format: string = DOUBLE_FORMAT): TOLDoubleToLabel; overload;
    {$ELSE}
    function Link(const Lbl: TLabel; var d: OLDouble; const Format: string = DOUBLE_FORMAT): TOLDoubleToLabel; overload;
    {$IFEND}
    function Link(const Lbl: TLabel; const f: TFunctionReturningOLDouble; const Format: string = DOUBLE_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING): TOLDoubleToLabel; overload;
    {$IF CompilerVersion >= 34.0}
    function Link(const Lbl: TLabel; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT): TOLCurrencyToLabel; overload;
    {$ELSE}
    function Link(const Lbl: TLabel; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT): TOLCurrencyToLabel; overload;
    {$IFEND}
    function Link(const Lbl: TLabel; const f: TFunctionReturningOLCurrency; const Format: string = CURRENCY_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING): TOLCurrencyToLabel; overload;
    {$IF CompilerVersion >= 34.0}
    function Link(const Lbl: TLabel; var d: OLDate): TOLDateToLabel; overload;
    {$ELSE}
    function Link(const Lbl: TLabel; var d: OLDate): TOLDateToLabel; overload;
    {$IFEND}
    function Link(const Lbl: TLabel; const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string = ERROR_STRING): TOLDateToLabel; overload;
    {$IF CompilerVersion >= 34.0}
    function Link(const Lbl: TLabel; var d: OLDateTime): TOLDateTimeToLabel; overload;
    {$ELSE}
    function Link(const Lbl: TLabel; var d: OLDateTime): TOLDateTimeToLabel; overload;
    {$IFEND}
    function Link(const Lbl: TLabel; const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string = ERROR_STRING): TOLDateTimeToLabel; overload;

    procedure RefreshControls(FormToRefresh: TForm = nil);
    procedure RemoveLinks(DestroyedForm: TForm = nil);
    function GetLinkForControl(AControl: TControl): TOLControlLink;
  end;

   function Links(): TOLLinkManager;

const
  NULL_FORMAT = '- - -';

implementation

uses
  {$IF CompilerVersion >= 23.0}
  System.Variants,
  {$ELSE}
  Variants,
  {$IFEND}
  SmartToDate;

const
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
  {$IF CompilerVersion >= 34.0}
  FValidators := TList<TOLValidationFunction<T>>.Create;
  {$IFEND}
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
  {$IF CompilerVersion >= 34.0}
  FValidators.Free;
  {$IFEND}
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
function TOLEditLink<T>.GetValidationFunction: TOLValidationFunction<T>;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TOLEditLink<T>.SetValidationFunction(const Value: TOLValidationFunction<T>);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TOLEditLink<T>.AddValidator(const Value: TOLValidationFunction<T>): TOLEditLink<T>;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TOLEditLink<T>.ValueIsValid(const v: T): TOLValidationResult;
var
  Validator: TOLValidationFunction<T>;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(v);
    if not Result.Valid then
      Exit;
  end;
end;

procedure TOLEditLink<T>.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
  begin
    Edit.Color := FOriginalColor;
    Edit.Hint := FOriginalHint;
    Edit.ShowHint := FOriginalShowHint;
    {$IF CompilerVersion >= 23.0}
    Edit.StyleElements := FOriginalStyleElements;
    {$IFEND}
  end
  else
  begin
    {$IF CompilerVersion >= 23.0}
    Edit.StyleElements := Edit.StyleElements - [seClient];
    {$IFEND}
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

{$IF CompilerVersion >= 34.0}
function TEditToOLInteger.AddValidator(const Value: TOLIntegerValidationFunction): TEditToOLInteger;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(function(val: OLInteger): TOLValidationResult
      begin
        Result := Value(val);
      end);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TEditToOLInteger.RequireValue(const AColor: TColor; const ErrorMessage: string): TEditToOLInteger;
begin
  AddValidator(OLValid.IsRequired(AColor, ErrorMessage));
  Result := Self;
end;

function TEditToOLInteger.Min(const MinVal: Integer; const AColor: TColor; const ErrorMessage: string): TEditToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Min(MinVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLInteger.Max(const MaxVal: Integer; const AColor: TColor; const ErrorMessage: string): TEditToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Max(MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLInteger.Between(const MinVal, MaxVal: Integer; const AColor: TColor; const ErrorMessage: string): TEditToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Between(MinVal, MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLInteger.Positive(const AColor: TColor; const ErrorMessage: string): TEditToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Positive(AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLInteger.Negative(const AColor: TColor; const ErrorMessage: string): TEditToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Negative(AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;
{$IFEND}




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

{$IF CompilerVersion >= 34.0}
function TEditToOLString.Pesel(const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.PESEL(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLString.RequireValue(const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TSmartValidator;
begin
  vFunc := OLValid.IsRequired(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      // TSmartValidator implicitly converts to TOLStringValidationFunction
      Result := TOLStringValidationFunction(vFunc)(val);
    end);
  Result := Self;
end;

function TEditToOLString.MinLength(const MinLen: Integer; const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.MinLength(MinLen, AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLString.MaxLength(const MaxLen: Integer; const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.MaxLength(MaxLen, AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLString.AlphaNumeric(const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.AlphaNumeric(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLString.DigitsOnly(const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.DigitsOnly(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLString.Email(const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.Email(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLString.Password(const MinLen: Integer; const RequireMixedCase, RequireDigits, RequireSpecialChar: Boolean; const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.Password(MinLen, RequireMixedCase, RequireDigits, RequireSpecialChar, AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLString.URL(const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.URL(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLString.CreditCard(const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.CreditCard(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLString.EAN(const IsGTIN14: Boolean; const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.EAN(IsGTIN14, AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLString.BIC(const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.BIC(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLString.IPv4(const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.IPv4(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLString.IPv6(const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.IPv6(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLString.IBAN(const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.IBAN(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLString.NIP(const AColor: TColor; const ErrorMessage: string): TEditToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.NIP(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;
{$IFEND}

{ TMemoToOLString }

constructor TMemoToOLString.Create;
begin
  inherited;
  FEdit := nil;
  FEditOnChange := nil;
  FOLPointer := nil;

  {$IF CompilerVersion >= 34.0}
  FValidators := TList<TOLStringValidationFunction>.Create;
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
  {$IF CompilerVersion >= 34.0}
  FValidators.Free;
  {$IFEND}
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
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements := Value.StyleElements;
    {$IFEND}
  end;
end;

procedure TMemoToOLString.SetOLPointer(const Value: POLString);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{$IF CompilerVersion >= 34.0}
function TMemoToOLString.GetValidationFunction: TOLStringValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TMemoToOLString.SetValidationFunction(const Value: TOLStringValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TMemoToOLString.AddValidator(const Value: TOLStringValidationFunction): TMemoToOLString;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

{$IF CompilerVersion >= 34.0}
function TMemoToOLString.Pesel(const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.PESEL(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TMemoToOLString.RequireValue(const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TSmartValidator;
begin
  vFunc := OLValid.IsRequired(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := TOLStringValidationFunction(vFunc)(val);
    end);
  Result := Self;
end;

function TMemoToOLString.MinLength(const MinLen: Integer; const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.MinLength(MinLen, AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TMemoToOLString.MaxLength(const MaxLen: Integer; const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.MaxLength(MaxLen, AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TMemoToOLString.AlphaNumeric(const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.AlphaNumeric(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TMemoToOLString.DigitsOnly(const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.DigitsOnly(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TMemoToOLString.Email(const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.Email(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TMemoToOLString.Password(const MinLen: Integer; const RequireMixedCase, RequireDigits, RequireSpecialChar: Boolean; const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.Password(MinLen, RequireMixedCase, RequireDigits, RequireSpecialChar, AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TMemoToOLString.URL(const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.URL(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TMemoToOLString.CreditCard(const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.CreditCard(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TMemoToOLString.EAN(const IsGTIN14: Boolean; const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.EAN(IsGTIN14, AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TMemoToOLString.BIC(const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.BIC(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TMemoToOLString.IPv4(const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.IPv4(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TMemoToOLString.IPv6(const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.IPv6(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TMemoToOLString.IBAN(const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.IBAN(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TMemoToOLString.NIP(const AColor: TColor; const ErrorMessage: string): TMemoToOLString;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.NIP(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;
{$IFEND}

function TMemoToOLString.ValueIsValid(s: OLString): TOLValidationResult;
var
  Validator: TOLStringValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(s);
    if not Result.Valid then
      Exit;
  end;
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
    {$IF CompilerVersion >= 23.0}
    Edit.StyleElements := FOriginalStyleElements;
    {$IFEND}
  end
  else
  begin
    {$IF CompilerVersion >= 23.0}
    Edit.StyleElements := Edit.StyleElements - [seClient];
    {$IFEND}
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
  FValidators := TList<TOLDoubleValidationFunction>.Create;
  {$IFEND}
end;

destructor TEditToOLDouble.Destroy;
begin
  // Note: We don't set FOLPointer^.OnChange := nil here because when using
  // observer pattern (multiple controls to one value), the OnChange points to
  // the observer, not to this link. The observer handles cleanup via RemoveLink.
  {$IF CompilerVersion >= 34.0}
  FValidators.Free;
  {$IFEND}
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
  CleanS := OLString(s).Replaced(fs.ThousandSeparator, '');

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
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements := Value.StyleElements;
    {$IFEND}
  end;
end;

procedure TEditToOLDouble.SetOLPointer(const Value: POLDouble);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{$IF CompilerVersion >= 34.0}
function TEditToOLDouble.GetValidationFunction: TOLDoubleValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TEditToOLDouble.SetValidationFunction(const Value: TOLDoubleValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TEditToOLDouble.AddValidator(const Value: TOLDoubleValidationFunction): TEditToOLDouble;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TEditToOLDouble.RequireValue(const AColor: TColor; const ErrorMessage: string): TEditToOLDouble;
begin
  AddValidator(OLValid.IsRequired(AColor, ErrorMessage));
  Result := Self;
end;

function TEditToOLDouble.Min(const MinVal: Double; const AColor: TColor; const ErrorMessage: string): TEditToOLDouble;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Min(MinVal, AColor, ErrorMessage);
  AddValidator(function(val: OLDouble): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLDouble.Max(const MaxVal: Double; const AColor: TColor; const ErrorMessage: string): TEditToOLDouble;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Max(MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLDouble): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLDouble.Between(const MinVal, MaxVal: Double; const AColor: TColor; const ErrorMessage: string): TEditToOLDouble;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Between(MinVal, MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLDouble): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLDouble.Positive(const AColor: TColor; const ErrorMessage: string): TEditToOLDouble;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Positive(AColor, ErrorMessage);
  AddValidator(function(val: OLDouble): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLDouble.Negative(const AColor: TColor; const ErrorMessage: string): TEditToOLDouble;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Negative(AColor, ErrorMessage);
  AddValidator(function(val: OLDouble): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLDouble.ValueIsValid(d: OLDouble): TOLValidationResult;
var
  Validator: TOLDoubleValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(d);
    if not Result.Valid then
      Exit;
  end;
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
    {$IF CompilerVersion >= 23.0}
    Edit.StyleElements := FOriginalStyleElements;
    {$IFEND}
  end
  else
  begin
    {$IF CompilerVersion >= 23.0}
    Edit.StyleElements := Edit.StyleElements - [seClient];
    {$IFEND}
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
  FValidators := TList<TOLCurrencyValidationFunction>.Create;
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
  {$IF CompilerVersion >= 34.0}
  FValidators.Free;
  {$IFEND}
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
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements := Value.StyleElements;
    {$IFEND}
  end;
end;

procedure TEditToOLCurrency.SetOLPointer(const Value: POLCurrency);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{$IF CompilerVersion >= 34.0}
function TEditToOLCurrency.GetValidationFunction: TOLCurrencyValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TEditToOLCurrency.SetValidationFunction(const Value: TOLCurrencyValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TEditToOLCurrency.AddValidator(const Value: TOLCurrencyValidationFunction): TEditToOLCurrency;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TEditToOLCurrency.RequireValue(const AColor: TColor; const ErrorMessage: string): TEditToOLCurrency;
begin
  AddValidator(OLValid.IsRequired(AColor, ErrorMessage));
  Result := Self;
end;

function TEditToOLCurrency.Min(const MinVal: Currency; const AColor: TColor; const ErrorMessage: string): TEditToOLCurrency;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Min(MinVal, AColor, ErrorMessage);
  AddValidator(function(val: OLCurrency): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLCurrency.Max(const MaxVal: Currency; const AColor: TColor; const ErrorMessage: string): TEditToOLCurrency;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Max(MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLCurrency): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLCurrency.Between(const MinVal, MaxVal: Currency; const AColor: TColor; const ErrorMessage: string): TEditToOLCurrency;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Between(MinVal, MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLCurrency): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLCurrency.Positive(const AColor: TColor; const ErrorMessage: string): TEditToOLCurrency;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Positive(AColor, ErrorMessage);
  AddValidator(function(val: OLCurrency): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLCurrency.Negative(const AColor: TColor; const ErrorMessage: string): TEditToOLCurrency;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Negative(AColor, ErrorMessage);
  AddValidator(function(val: OLCurrency): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TEditToOLCurrency.ValueIsValid(c: OLCurrency): TOLValidationResult;
var
  Validator: TOLCurrencyValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(c);
    if not Result.Valid then
      Exit;
  end;
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
    {$IF CompilerVersion >= 23.0}
    Edit.StyleElements := FOriginalStyleElements;
    {$IFEND}
  end
  else
  begin
    {$IF CompilerVersion >= 23.0}
    Edit.StyleElements := Edit.StyleElements - [seClient];
    {$IFEND}
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
  FValidators := TList<TOLIntegerValidationFunction>.Create;
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

   {$IF CompilerVersion >= 34.0}
   FValidators.Free;
   {$IFEND}

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
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements := Value.StyleElements;
    {$IFEND}
  end;
end;

procedure TSpinEditToOLInteger.SetOLPointer(const Value: POLInteger);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{$IF CompilerVersion >= 34.0}
function TSpinEditToOLInteger.GetValidationFunction: TOLIntegerValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TSpinEditToOLInteger.SetValidationFunction(const Value: TOLIntegerValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TSpinEditToOLInteger.AddValidator(const Value: TOLIntegerValidationFunction): TSpinEditToOLInteger;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TSpinEditToOLInteger.RequireValue(const AColor: TColor; const ErrorMessage: string): TSpinEditToOLInteger;
begin
  AddValidator(OLValid.IsRequired(AColor, ErrorMessage));
  Result := Self;
end;

function TSpinEditToOLInteger.Min(const MinVal: Integer; const AColor: TColor; const ErrorMessage: string): TSpinEditToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Min(MinVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TSpinEditToOLInteger.Max(const MaxVal: Integer; const AColor: TColor; const ErrorMessage: string): TSpinEditToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Max(MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TSpinEditToOLInteger.Between(const MinVal, MaxVal: Integer; const AColor: TColor; const ErrorMessage: string): TSpinEditToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Between(MinVal, MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TSpinEditToOLInteger.Positive(const AColor: TColor; const ErrorMessage: string): TSpinEditToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Positive(AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TSpinEditToOLInteger.Negative(const AColor: TColor; const ErrorMessage: string): TSpinEditToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Negative(AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TSpinEditToOLInteger.ValueIsValid(i: OLInteger): TOLValidationResult;
var
  Validator: TOLIntegerValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(i);
    if not Result.Valid then
      Exit;
  end;
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
    {$IF CompilerVersion >= 23.0}
    Edit.StyleElements := FOriginalStyleElements;
    {$IFEND}
  end
  else
  begin
    {$IF CompilerVersion >= 23.0}
    Edit.StyleElements := Edit.StyleElements - [seClient];
    {$IFEND}
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

{$IF CompilerVersion >= 34.0}
procedure TOLControlLink.ShowValidationState(vr: TOLValidationResult);
begin
  // Do nothing by default
end;
{$IFEND}

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
  FValidators := TList<TOLDateValidationFunction>.Create;
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

  if Assigned(FWarningLabel) then
  begin
    FWarningLabel.Free;
    FWarningLabel := nil;
  end;

  {$IF CompilerVersion >= 34.0}
  FValidators.Free;
  {$IFEND}

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
  if FUpdatingFromRefresh then Exit;
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

  {$IF CompilerVersion >= 34.0}
  ShowValidationState(ValueIsValid(OLPointer^));
  {$IFEND}
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

    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements := Value.StyleElements;
    {$IFEND}

    FUpdatingFromRefresh := True;
    try
      if Value.Parent <> nil then
        Value.HandleNeeded;

      RefreshControl;
    finally
      FUpdatingFromRefresh := False;
    end;
  end;
end;

procedure TDateTimePickerToOLDate.SetOLPointer(const Value: POLDate);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{$IF CompilerVersion >= 34.0}
function TDateTimePickerToOLDate.GetValidationFunction: TOLDateValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TDateTimePickerToOLDate.SetValidationFunction(const Value: TOLDateValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TDateTimePickerToOLDate.AddValidator(const Value: TOLDateValidationFunction): TDateTimePickerToOLDate;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TDateTimePickerToOLDate.RequireValue(const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDate;
begin
  AddValidator(OLValid.IsRequired(AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDate.Min(const MinDate: TDate; const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDate;
begin
  AddValidator(OLValid.Min(MinDate, AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDate.Max(const MaxDate: TDate; const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDate;
begin
  AddValidator(OLValid.Max(MaxDate, AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDate.Between(const MinDate, MaxDate: TDate; const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDate;
begin
  AddValidator(OLValid.Between(MinDate, MaxDate, AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDate.Past(const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDate;
begin
  AddValidator(OLValid.Past(AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDate.Future(const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDate;
begin
  AddValidator(OLValid.Future(AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDate.Today(const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDate;
begin
  AddValidator(OLValid.Today(AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDate.MinAge(const Age: Integer; const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDate;
begin
  AddValidator(OLValid.MinAge(Age, AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDate.MaxAge(const Age: Integer; const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDate;
begin
  AddValidator(OLValid.MaxAge(Age, AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDate.IsWeekday(const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDate;
begin
  AddValidator(OLValid.IsWeekday(AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDate.IsWeekend(const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDate;
begin
  AddValidator(OLValid.IsWeekend(AColor, ErrorMessage));
  Result := Self;
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
  Validator: TOLDateValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(d);
    if not Result.Valid then
      Exit;
  end;
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
  FValidators := TList<TOLDateTimeValidationFunction>.Create;
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

   {$IF CompilerVersion >= 34.0}
   FValidators.Free;
   {$IFEND}

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
  if FUpdatingFromRefresh then Exit;
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

  {$IF CompilerVersion >= 34.0}
  ShowValidationState(ValueIsValid(OLPointer^));
  {$IFEND}
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

    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements := Value.StyleElements;
    {$IFEND}

    FUpdatingFromRefresh := True;
    try
      if Value.Parent <> nil then
        Value.HandleNeeded;

      RefreshControl;
    finally
      FUpdatingFromRefresh := False;
    end;
  end;
end;

procedure TDateTimePickerToOLDateTime.SetOLPointer(const Value: POLDateTime);
begin
  if not Assigned(Value) then
    raise Exception.Create('OLPointer cannot be nil.');
  FOLPointer := Value;
end;

{$IF CompilerVersion >= 34.0}
function TDateTimePickerToOLDateTime.GetValidationFunction: TOLDateTimeValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TDateTimePickerToOLDateTime.SetValidationFunction(const Value: TOLDateTimeValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TDateTimePickerToOLDateTime.AddValidator(const Value: TOLDateTimeValidationFunction): TDateTimePickerToOLDateTime;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TDateTimePickerToOLDateTime.RequireValue(const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDateTime;
begin
  AddValidator(OLValid.IsRequired(AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDateTime.Min(const MinDate: TDateTime; const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDateTime;
begin
  AddValidator(OLValid.Min(MinDate, AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDateTime.Max(const MaxDate: TDateTime; const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDateTime;
begin
  AddValidator(OLValid.Max(MaxDate, AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDateTime.Between(const MinDate, MaxDate: TDateTime; const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDateTime;
begin
  AddValidator(OLValid.Between(MinDate, MaxDate, AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDateTime.Past(const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDateTime;
begin
  AddValidator(OLValid.Past(AColor, ErrorMessage));
  Result := Self;
end;

function TDateTimePickerToOLDateTime.Future(const AColor: TColor; const ErrorMessage: string): TDateTimePickerToOLDateTime;
begin
  AddValidator(OLValid.Future(AColor, ErrorMessage));
  Result := Self;
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
  Validator: TOLDateTimeValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(dt);
    if not Result.Valid then
      Exit;
  end;
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
  FValidators := TList<TOLBooleanValidationFunction>.Create;
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
  {$IF CompilerVersion >= 34.0}
  FValidators.Free;
  {$IFEND}
  inherited;
end;

{$IF CompilerVersion >= 34.0}
function TCheckBoxToOLBoolean.GetValidationFunction: TOLBooleanValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TCheckBoxToOLBoolean.SetValidationFunction(const Value: TOLBooleanValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TCheckBoxToOLBoolean.AddValidator(const Value: TOLBooleanValidationFunction): TCheckBoxToOLBoolean;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TCheckBoxToOLBoolean.RequireValue(const AColor: TColor = clDefault;
    const ErrorMessage: string = ''): TCheckBoxToOLBoolean;
begin
  AddValidator(OLValid.IsRequired(AColor, ErrorMessage));
  Result := Self;
end;

function TCheckBoxToOLBoolean.ValueIsValid(b: OLBoolean): TOLValidationResult;
var
  Validator: TOLBooleanValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(b);
    if not Result.Valid then
      Exit;
  end;
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
var b: OLBoolean;
begin
  if FAllowGrayed then
  begin
    case Edit.State of
      cbUnchecked: b := False;
      cbChecked: b := True;
      cbGrayed: b := Null;
    end;
  end
  else
    b := Edit.Checked;

  {$IF CompilerVersion >= 34.0}
  SetValueAfterValidation(b);
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
  if FAllowGrayed then
  begin
    if (OLPointer^).IsNull then
    begin
      if Edit.State <> cbGrayed then
        Edit.State := cbGrayed;
    end
    else
    begin
      if Edit.Checked <> OLPointer^ then
        Edit.Checked := OLPointer^;
    end;
  end
  else
  begin
    if Edit.Checked <> (OLPointer^).IfNull(False) then
      Edit.Checked := (OLPointer^).IfNull(False);
  end;

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
    if Value.AllowGrayed then
      FAllowGrayed := True;
    Value.AllowGrayed := FAllowGrayed;
    FEditOnClick := Value.OnClick;
    Value.OnClick := NewOnClick;
    FOriginalFontColor := Value.Font.Color;
    FOriginalHint := Value.Hint;
    FOriginalShowHint := Value.ShowHint;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements := Value.StyleElements;
    {$IFEND}
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
  FValidators := TList<TOLIntegerValidationFunction>.Create;
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
  {$IF CompilerVersion >= 34.0}
  FValidators.Free;
  {$IFEND}
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
  begin
    FOriginalFontColor := Value.Font.Color;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements := Value.StyleElements;
    {$IFEND}
  end;
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
function TOLIntegerToLabel.GetValidationFunction: TOLIntegerValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TOLIntegerToLabel.SetValidationFunction(const Value: TOLIntegerValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TOLIntegerToLabel.AddValidator(const Value: TOLIntegerValidationFunction): TOLIntegerToLabel;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TOLIntegerToLabel.RequireValue(const AColor: TColor; const ErrorMessage: string): TOLIntegerToLabel;
begin
  AddValidator(OLValid.IsRequired(AColor, ErrorMessage));
  Result := Self;
end;

function TOLIntegerToLabel.Min(const MinVal: Integer; const AColor: TColor; const ErrorMessage: string): TOLIntegerToLabel;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Min(MinVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLIntegerToLabel.Max(const MaxVal: Integer; const AColor: TColor; const ErrorMessage: string): TOLIntegerToLabel;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Max(MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLIntegerToLabel.Between(const MinVal, MaxVal: Integer; const AColor: TColor; const ErrorMessage: string): TOLIntegerToLabel;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Between(MinVal, MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLIntegerToLabel.Positive(const AColor: TColor; const ErrorMessage: string): TOLIntegerToLabel;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Positive(AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLIntegerToLabel.Negative(const AColor: TColor; const ErrorMessage: string): TOLIntegerToLabel;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Negative(AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLIntegerToLabel.ValueIsValid(i: OLInteger): TOLValidationResult;
var
  Validator: TOLIntegerValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(i);
    if not Result.Valid then
      Exit;
  end;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TOLIntegerToLabel.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
  begin
    Lbl.Font.Color := FOriginalFontColor;
    {$IF CompilerVersion >= 23.0}
    Lbl.StyleElements := FOriginalStyleElements;
    {$IFEND}
  end
  else
  begin
    if vr.Color = clDefault then
      Lbl.Font.Color:= clRed
    else
      Lbl.Font.Color := vr.Color;
    {$IF CompilerVersion >= 23.0}
    Lbl.StyleElements := Lbl.StyleElements - [seFont];
    {$IFEND}
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
  FValidators := TList<TOLStringValidationFunction>.Create;
  {$IFEND}
end;

destructor TOLStringToLabel.Destroy;
begin
  if Assigned(FOLPointer) then
  begin
    {$IF CompilerVersion >= 34.0}
    FOLPointer^.OnChange := nil;
    {$IFEND}
  end;
  {$IF CompilerVersion >= 34.0}
  FValidators.Free;
  {$IFEND}
  inherited;
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
  begin
    FOriginalFontColor := Value.Font.Color;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements := Value.StyleElements;
    {$IFEND}
  end;
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
function TOLStringToLabel.GetValidationFunction: TOLStringValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TOLStringToLabel.SetValidationFunction(const Value: TOLStringValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TOLStringToLabel.AddValidator(const Value: TOLStringValidationFunction): TOLStringToLabel;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

{$IF CompilerVersion >= 34.0}
function TOLStringToLabel.Pesel(const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.PESEL(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.RequireValue(const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TSmartValidator;
begin
  vFunc := OLValid.IsRequired(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := TOLStringValidationFunction(vFunc)(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.MinLength(const MinLen: Integer; const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.MinLength(MinLen, AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.MaxLength(const MaxLen: Integer; const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.MaxLength(MaxLen, AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.AlphaNumeric(const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.AlphaNumeric(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.DigitsOnly(const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.DigitsOnly(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.Email(const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.Email(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.Password(const MinLen: Integer; const RequireMixedCase, RequireDigits, RequireSpecialChar: Boolean; const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.Password(MinLen, RequireMixedCase, RequireDigits, RequireSpecialChar, AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.URL(const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.URL(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.CreditCard(const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.CreditCard(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.EAN(const IsGTIN14: Boolean; const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.EAN(IsGTIN14, AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.BIC(const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.BIC(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.IPv4(const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.IPv4(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.IPv6(const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.IPv6(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.IBAN(const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.IBAN(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLStringToLabel.NIP(const AColor: TColor; const ErrorMessage: string): TOLStringToLabel;
var
  vFunc: TOLStringValidationFunction;
begin
  vFunc := OLValid.NIP(AColor, ErrorMessage);
  AddValidator(function(val: OLString): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;
{$IFEND}

function TOLStringToLabel.ValueIsValid(s: OLString): TOLValidationResult;
var
  Validator: TOLStringValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(s);
    if not Result.Valid then
      Exit;
  end;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TOLStringToLabel.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
  begin
    Lbl.Font.Color := FOriginalFontColor;
    {$IF CompilerVersion >= 23.0}
    Lbl.StyleElements := FOriginalStyleElements;
    {$IFEND}
  end
  else
  begin
    if vr.Color = clDefault then
      Lbl.Font.Color := clRed
    else
       Lbl.Font.Color := vr.Color;
    {$IF CompilerVersion >= 23.0}
    Lbl.StyleElements := Lbl.StyleElements - [seFont];
    {$IFEND}
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
  FValidators := TList<TOLDoubleValidationFunction>.Create;
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
  {$IF CompilerVersion >= 34.0}
  FValidators.Free;
  {$IFEND}
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
  begin
    FOriginalFontColor := Value.Font.Color;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements := Value.StyleElements;
    {$IFEND}
  end;
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
function TOLDoubleToLabel.GetValidationFunction: TOLDoubleValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TOLDoubleToLabel.SetValidationFunction(const Value: TOLDoubleValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TOLDoubleToLabel.AddValidator(const Value: TOLDoubleValidationFunction): TOLDoubleToLabel;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TOLDoubleToLabel.RequireValue(const AColor: TColor; const ErrorMessage: string): TOLDoubleToLabel;
begin
  AddValidator(OLValid.IsRequired(AColor, ErrorMessage));
  Result := Self;
end;

function TOLDoubleToLabel.Min(const MinVal: Double; const AColor: TColor; const ErrorMessage: string): TOLDoubleToLabel;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Min(MinVal, AColor, ErrorMessage);
  AddValidator(function(val: OLDouble): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLDoubleToLabel.Max(const MaxVal: Double; const AColor: TColor; const ErrorMessage: string): TOLDoubleToLabel;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Max(MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLDouble): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLDoubleToLabel.Between(const MinVal, MaxVal: Double; const AColor: TColor; const ErrorMessage: string): TOLDoubleToLabel;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Between(MinVal, MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLDouble): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLDoubleToLabel.Positive(const AColor: TColor; const ErrorMessage: string): TOLDoubleToLabel;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Positive(AColor, ErrorMessage);
  AddValidator(function(val: OLDouble): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLDoubleToLabel.Negative(const AColor: TColor; const ErrorMessage: string): TOLDoubleToLabel;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Negative(AColor, ErrorMessage);
  AddValidator(function(val: OLDouble): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TOLDoubleToLabel.ValueIsValid(d: OLDouble): TOLValidationResult;
var
  Validator: TOLDoubleValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(d);
    if not Result.Valid then
      Exit;
  end;
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
  FValidators := TList<TOLCurrencyValidationFunction>.Create;
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
  {$IF CompilerVersion >= 34.0}
  FValidators.Free;
  {$IFEND}
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
  begin
    FOriginalFontColor := Value.Font.Color;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements := Value.StyleElements;
    {$IFEND}
  end;
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
function TOLCurrencyToLabel.GetValidationFunction: TOLCurrencyValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TOLCurrencyToLabel.SetValidationFunction(const Value: TOLCurrencyValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TOLCurrencyToLabel.AddValidator(const Value: TOLCurrencyValidationFunction): TOLCurrencyToLabel;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TOLCurrencyToLabel.RequireValue(const AColor: TColor; const ErrorMessage: string): TOLCurrencyToLabel;
begin
  AddValidator(OLValid.IsRequired(AColor, ErrorMessage));
  Result := Self;
end;

function TOLCurrencyToLabel.Min(const MinVal: Currency; const AColor: TColor; const ErrorMessage: string): TOLCurrencyToLabel;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Min(Double(MinVal), AColor, ErrorMessage);
  AddValidator(function(val: OLCurrency): TOLValidationResult
    begin
      Result := vFunc(Double(val));
    end);
  Result := Self;
end;

function TOLCurrencyToLabel.Max(const MaxVal: Currency; const AColor: TColor; const ErrorMessage: string): TOLCurrencyToLabel;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Max(Double(MaxVal), AColor, ErrorMessage);
  AddValidator(function(val: OLCurrency): TOLValidationResult
    begin
      Result := vFunc(Double(val));
    end);
  Result := Self;
end;

function TOLCurrencyToLabel.Between(const MinVal, MaxVal: Currency; const AColor: TColor; const ErrorMessage: string): TOLCurrencyToLabel;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Between(Double(MinVal), Double(MaxVal), AColor, ErrorMessage);
  AddValidator(function(val: OLCurrency): TOLValidationResult
    begin
      Result := vFunc(Double(val));
    end);
  Result := Self;
end;

function TOLCurrencyToLabel.Positive(const AColor: TColor; const ErrorMessage: string): TOLCurrencyToLabel;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Positive(AColor, ErrorMessage);
  AddValidator(function(val: OLCurrency): TOLValidationResult
    begin
      Result := vFunc(Double(val));
    end);
  Result := Self;
end;

function TOLCurrencyToLabel.Negative(const AColor: TColor; const ErrorMessage: string): TOLCurrencyToLabel;
var
  vFunc: TOLDoubleValidationFunction;
begin
  vFunc := OLValid.Negative(AColor, ErrorMessage);
  AddValidator(function(val: OLCurrency): TOLValidationResult
    begin
      Result := vFunc(Double(val));
    end);
  Result := Self;
end;

function TOLCurrencyToLabel.ValueIsValid(c: OLCurrency): TOLValidationResult;
var
  Validator: TOLCurrencyValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(c);
    if not Result.Valid then
      Exit;
  end;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TOLCurrencyToLabel.ShowValidationState(vr: TOLValidationResult);
begin
  if vr.Valid then
  begin
    Lbl.Font.Color := FOriginalFontColor;
    {$IF CompilerVersion >= 23.0}
    Lbl.StyleElements := FOriginalStyleElements;
    {$IFEND}
  end
  else
  begin
    if vr.Color = clDefault then
      Lbl.Font.Color := clRed
    else
       Lbl.Font.Color := vr.Color;
    {$IF CompilerVersion >= 23.0}
    Lbl.StyleElements := Lbl.StyleElements - [seFont];
    {$IFEND}
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
  {$IF CompilerVersion >= 34.0}
  FValidators := TList<TOLDateValidationFunction>.Create;
  {$IFEND}
end;

destructor TOLDateToLabel.Destroy;
begin
  if Assigned(FOLPointer) then
  begin
    {$IF CompilerVersion >= 34.0}
    FOLPointer^.OnChange := nil;
    {$IFEND}
  end;
  {$IF CompilerVersion >= 34.0}
  FValidators.Free;
  {$IFEND}
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
  begin
    FOriginalFontColor := Value.Font.Color;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements := Value.StyleElements;
    {$IFEND}
  end;
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
function TOLDateToLabel.GetValidationFunction: TOLDateValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TOLDateToLabel.SetValidationFunction(const Value: TOLDateValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TOLDateToLabel.AddValidator(const Value: TOLDateValidationFunction): TOLDateToLabel;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TOLDateToLabel.RequireValue(const AColor: TColor; const ErrorMessage: string): TOLDateToLabel;
begin
  AddValidator(OLValid.IsRequired(AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateToLabel.Min(const MinDate: TDate; const AColor: TColor; const ErrorMessage: string): TOLDateToLabel;
begin
  AddValidator(OLValid.Min(MinDate, AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateToLabel.Max(const MaxDate: TDate; const AColor: TColor; const ErrorMessage: string): TOLDateToLabel;
begin
  AddValidator(OLValid.Max(MaxDate, AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateToLabel.Between(const MinDate, MaxDate: TDate; const AColor: TColor; const ErrorMessage: string): TOLDateToLabel;
begin
  AddValidator(OLValid.Between(MinDate, MaxDate, AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateToLabel.Past(const AColor: TColor; const ErrorMessage: string): TOLDateToLabel;
begin
  AddValidator(OLValid.Past(AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateToLabel.Future(const AColor: TColor; const ErrorMessage: string): TOLDateToLabel;
begin
  AddValidator(OLValid.Future(AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateToLabel.Today(const AColor: TColor; const ErrorMessage: string): TOLDateToLabel;
begin
  AddValidator(OLValid.Today(AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateToLabel.MinAge(const Age: Integer; const AColor: TColor; const ErrorMessage: string): TOLDateToLabel;
begin
  AddValidator(OLValid.MinAge(Age, AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateToLabel.MaxAge(const Age: Integer; const AColor: TColor; const ErrorMessage: string): TOLDateToLabel;
begin
  AddValidator(OLValid.MaxAge(Age, AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateToLabel.IsWeekday(const AColor: TColor; const ErrorMessage: string): TOLDateToLabel;
begin
  AddValidator(OLValid.IsWeekday(AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateToLabel.IsWeekend(const AColor: TColor; const ErrorMessage: string): TOLDateToLabel;
begin
  AddValidator(OLValid.IsWeekend(AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateToLabel.ValueIsValid(d: OLDate): TOLValidationResult;
var
  Validator: TOLDateValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(d);
    if not Result.Valid then
      Exit;
  end;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TOLDateToLabel.ShowValidationState(vr: TOLValidationResult);
begin
  if Assigned(FLabel) then
  begin
    if vr.Valid then
    begin
      FLabel.Font.Color := FOriginalFontColor;
      {$IF CompilerVersion >= 23.0}
      FLabel.StyleElements := FOriginalStyleElements;
      {$IFEND}
    end
    else
    begin
      if vr.Color = clDefault then
        FLabel.Font.Color := clRed
      else
        FLabel.Font.Color := vr.Color;
      {$IF CompilerVersion >= 23.0}
      FLabel.StyleElements := FLabel.StyleElements - [seFont];
      {$IFEND}
    end;
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
  {$IF CompilerVersion >= 34.0}
  FValidators := TList<TOLDateTimeValidationFunction>.Create;
  {$IFEND}
end;

destructor TOLDateTimeToLabel.Destroy;
begin
  if Assigned(FOLPointer) then
  begin
    {$IF CompilerVersion >= 34.0}
    FOLPointer^.OnChange := nil;
    {$IFEND}
  end;
  {$IF CompilerVersion >= 34.0}
  FValidators.Free;
  {$IFEND}
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
  begin
    FOriginalFontColor := Value.Font.Color;
    {$IF CompilerVersion >= 23.0}
    FOriginalStyleElements := Value.StyleElements;
    {$IFEND}
  end;
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
function TOLDateTimeToLabel.GetValidationFunction: TOLDateTimeValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TOLDateTimeToLabel.SetValidationFunction(const Value: TOLDateTimeValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TOLDateTimeToLabel.AddValidator(const Value: TOLDateTimeValidationFunction): TOLDateTimeToLabel;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TOLDateTimeToLabel.RequireValue(const AColor: TColor; const ErrorMessage: string): TOLDateTimeToLabel;
begin
  AddValidator(OLValid.IsRequired(AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateTimeToLabel.Min(const MinDate: TDateTime; const AColor: TColor; const ErrorMessage: string): TOLDateTimeToLabel;
begin
  AddValidator(OLValid.Min(MinDate, AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateTimeToLabel.Max(const MaxDate: TDateTime; const AColor: TColor; const ErrorMessage: string): TOLDateTimeToLabel;
begin
  AddValidator(OLValid.Max(MaxDate, AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateTimeToLabel.Between(const MinDate, MaxDate: TDateTime; const AColor: TColor; const ErrorMessage: string): TOLDateTimeToLabel;
begin
  AddValidator(OLValid.Between(MinDate, MaxDate, AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateTimeToLabel.Past(const AColor: TColor; const ErrorMessage: string): TOLDateTimeToLabel;
begin
  AddValidator(OLValid.Past(AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateTimeToLabel.Future(const AColor: TColor; const ErrorMessage: string): TOLDateTimeToLabel;
begin
  AddValidator(OLValid.Future(AColor, ErrorMessage));
  Result := Self;
end;

function TOLDateTimeToLabel.ValueIsValid(dt: OLDateTime): TOLValidationResult;
var
  Validator: TOLDateTimeValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(dt);
    if not Result.Valid then
      Exit;
  end;
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
procedure TOLDateTimeToLabel.ShowValidationState(vr: TOLValidationResult);
begin
  if Assigned(FLabel) then
  begin
    if vr.Valid then
    begin
      FLabel.Font.Color := FOriginalFontColor;
      {$IF CompilerVersion >= 23.0}
      FLabel.StyleElements := FOriginalStyleElements;
      {$IFEND}
    end
    else
    begin
      if vr.Color = clDefault then
        FLabel.Font.Color := clRed
      else
        FLabel.Font.Color := vr.Color;
      {$IF CompilerVersion >= 23.0}
      FLabel.StyleElements := FLabel.StyleElements - [seFont];
      {$IFEND}
    end;
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
  FValidators := TList<TOLIntegerValidationFunction>.Create;
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

  if Assigned(FWarningLabel) then
  begin
    FWarningLabel.Free;
    FWarningLabel := nil;
  end;

  {$IF CompilerVersion >= 34.0}
  FValidators.Free;
  {$IFEND}
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
function TScrollBarToOLInteger.GetValidationFunction: TOLIntegerValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TScrollBarToOLInteger.SetValidationFunction(const Value: TOLIntegerValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TScrollBarToOLInteger.AddValidator(const Value: TOLIntegerValidationFunction): TScrollBarToOLInteger;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TScrollBarToOLInteger.RequireValue(const AColor: TColor; const ErrorMessage: string): TScrollBarToOLInteger;
begin
  AddValidator(OLValid.IsRequired(AColor, ErrorMessage));
  Result := Self;
end;

function TScrollBarToOLInteger.Min(const MinVal: Integer; const AColor: TColor; const ErrorMessage: string): TScrollBarToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Min(MinVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TScrollBarToOLInteger.Max(const MaxVal: Integer; const AColor: TColor; const ErrorMessage: string): TScrollBarToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Max(MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TScrollBarToOLInteger.Between(const MinVal, MaxVal: Integer; const AColor: TColor; const ErrorMessage: string): TScrollBarToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Between(MinVal, MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TScrollBarToOLInteger.Positive(const AColor: TColor; const ErrorMessage: string): TScrollBarToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Positive(AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TScrollBarToOLInteger.Negative(const AColor: TColor; const ErrorMessage: string): TScrollBarToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Negative(AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TScrollBarToOLInteger.ValueIsValid(i: OLInteger): TOLValidationResult;
var
  Validator: TOLIntegerValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(i);
    if not Result.Valid then
      Exit;
  end;
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
  FValidators := TList<TOLIntegerValidationFunction>.Create;
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

  if Assigned(FWarningLabel) then
  begin
    FWarningLabel.Free;
    FWarningLabel := nil;
  end;

  {$IF CompilerVersion >= 34.0}
  FValidators.Free;
  {$IFEND}
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
function TTrackBarToOLInteger.GetValidationFunction: TOLIntegerValidationFunction;
begin
  if FValidators.Count > 0 then
    Result := FValidators[0]
  else
    Result := nil;
end;

procedure TTrackBarToOLInteger.SetValidationFunction(const Value: TOLIntegerValidationFunction);
begin
  FValidators.Clear;
  if Assigned(Value) then
    FValidators.Add(Value);
end;

function TTrackBarToOLInteger.AddValidator(const Value: TOLIntegerValidationFunction): TTrackBarToOLInteger;
var
  vr: TOLValidationResult;
begin
  Result := Self;
  if Assigned(Value) then
    FValidators.Add(Value);

  vr := ValueIsValid(FOLPointer^);
  ShowValidationState(vr);
end;

function TTrackBarToOLInteger.RequireValue(const AColor: TColor; const ErrorMessage: string): TTrackBarToOLInteger;
begin
  AddValidator(OLValid.IsRequired(AColor, ErrorMessage));
  Result := Self;
end;

function TTrackBarToOLInteger.Min(const MinVal: Integer; const AColor: TColor; const ErrorMessage: string): TTrackBarToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Min(MinVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TTrackBarToOLInteger.Max(const MaxVal: Integer; const AColor: TColor; const ErrorMessage: string): TTrackBarToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Max(MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TTrackBarToOLInteger.Between(const MinVal, MaxVal: Integer; const AColor: TColor; const ErrorMessage: string): TTrackBarToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Between(MinVal, MaxVal, AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TTrackBarToOLInteger.Positive(const AColor: TColor; const ErrorMessage: string): TTrackBarToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Positive(AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TTrackBarToOLInteger.Negative(const AColor: TColor; const ErrorMessage: string): TTrackBarToOLInteger;
var
  vFunc: TOLIntegerValidationFunction;
begin
  vFunc := OLValid.Negative(AColor, ErrorMessage);
  AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      Result := vFunc(val);
    end);
  Result := Self;
end;

function TTrackBarToOLInteger.ValueIsValid(i: OLInteger): TOLValidationResult;
var
  Validator: TOLIntegerValidationFunction;
begin
  Result := TOLValidationResult.Ok;
  for Validator in FValidators do
  begin
    Result := Validator(i);
    if not Result.Valid then
      Exit;
  end;
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
function TOLLinkManager.Link(const Edit: TEdit; var i: OLInteger; const Alignment:
    TAlignment=taRightJustify): TEditToOLInteger;
{$ELSE}
function TOLLinkManager.Link(const Edit: TEdit; var i: OLInteger; const Alignment:
    TAlignment=taRightJustify): TEditToOLInteger;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TEditToOLInteger.Create;
  Result.Edit := Edit;
  Result.FOLPointer := @i;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLInteger
  if not FValueMulticasters.TryGetValue(@i, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@i, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  i.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLInteger
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Result);

  Edit.Alignment := Alignment;

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Edit: TTrackBar; var i: OLInteger): TTrackBarToOLInteger;
{$ELSE}
function TOLLinkManager.Link(const Edit: TTrackBar; var i: OLInteger): TTrackBarToOLInteger;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TTrackBarToOLInteger.Create;
  Result.Edit := Edit;
  Result.FOLPointer := @i;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLInteger
  if not FValueMulticasters.TryGetValue(@i, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@i, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  i.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLInteger
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Result);

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Edit: TScrollBar; var i: OLInteger): TScrollBarToOLInteger;
{$ELSE}
function TOLLinkManager.Link(const Edit: TScrollBar; var i: OLInteger): TScrollBarToOLInteger;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TScrollBarToOLInteger.Create;
  Result.Edit := Edit;
  Result.FOLPointer := @i;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLInteger
  if not FValueMulticasters.TryGetValue(@i, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@i, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  i.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLInteger
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Result);

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Edit: TEdit; var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLDouble;
{$ELSE}
function TOLLinkManager.Link(const Edit: TEdit; var d: OLDouble; const Format: string = DOUBLE_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLDouble;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TEditToOLDouble.Create;
  Result.FFormat := Format;
  Result.Edit := Edit;
  Result.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLDouble
  if not FValueMulticasters.TryGetValue(@d, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@d, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  d.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLDouble
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Result);

  Edit.Alignment := Alignment;

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Edit: TEdit; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLCurrency;
{$ELSE}
function TOLLinkManager.Link(const Edit: TEdit; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT; const Alignment: TAlignment=taRightJustify): TEditToOLCurrency;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TEditToOLCurrency.Create;
  Result.FFormat := Format;
  Result.Edit := Edit;
  Result.FOLPointer := @curr;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLCurrency
  if not FValueMulticasters.TryGetValue(@curr, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@curr, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  curr.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLCurrency
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Result);

  Edit.Alignment := Alignment;

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Edit: TEdit; var s: OLString): TEditToOLString;
{$ELSE}
function TOLLinkManager.Link(const Edit: TEdit; var s: OLString): TEditToOLString;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TEditToOLString.Create;
  Result.Edit := Edit;
  Result.FOLPointer := @s;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLString
  if not FValueMulticasters.TryGetValue(@s, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@s, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  s.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLString
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Result);

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Edit: TMemo; var s: OLString): TMemoToOLString;
{$ELSE}
function TOLLinkManager.Link(const Edit: TMemo; var s: OLString): TMemoToOLString;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TMemoToOLString.Create;
  Result.Edit := Edit;
  Result.FOLPointer := @s;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLString
  if not FValueMulticasters.TryGetValue(@s, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@s, ValueMulticaster);
    s.OnChange := ValueMulticaster.OnOLChange;  // Set multicaster's handler on OLString
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Result);

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Edit: TDateTimePicker; var d: OLDate): TDateTimePickerToOLDate;
{$ELSE}
function TOLLinkManager.Link(const Edit: TDateTimePicker; var d: OLDate): TDateTimePickerToOLDate;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  if Edit.Format = '' then
  begin
    Edit.Format := DelphiDateTimeFormatToWindowsFormat(FormatSettings.ShortDateFormat);
  end;

  Result := TDateTimePickerToOLDate.Create;
  Result.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLDate
  if not FValueMulticasters.TryGetValue(@d, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@d, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  d.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLDate
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  Result.Edit := Edit;
  AddLink(Edit, Result);

  Result.RefreshControl();
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
function TOLLinkManager.Link(const Lbl: TLabel; var d: OLDate): TOLDateToLabel;
{$ELSE}
function TOLLinkManager.Link(const Lbl: TLabel; var d: OLDate): TOLDateToLabel;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TOLDateToLabel.Create;
  Result.Lbl := Lbl;
  Result.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLDate
  if not FValueMulticasters.TryGetValue(@d, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@d, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  d.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLDate
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Lbl, Result);

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Edit: TDateTimePicker; var d: OLDateTime): TDateTimePickerToOLDateTime;
{$ELSE}
function TOLLinkManager.Link(const Edit: TDateTimePicker; var d: OLDateTime): TDateTimePickerToOLDateTime;
{$IFEND}
var
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

  Result := TDateTimePickerToOLDateTime.Create;
  Result.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLDateTime
  if not FValueMulticasters.TryGetValue(@d, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@d, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  d.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLDateTime
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  Result.Edit := Edit;
  AddLink(Edit, Result);

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Edit: TCheckBox; var b: OLBoolean; AllowGrayed: Boolean = False): TCheckBoxToOLBoolean;
{$ELSE}
function TOLLinkManager.Link(const Edit: TCheckBox; var b: OLBoolean; AllowGrayed: Boolean = False): TCheckBoxToOLBoolean;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TCheckBoxToOLBoolean.Create;
  Result.AllowGrayed := AllowGrayed;
  Result.Edit := Edit;
  Result.FOLPointer := @b;
  {$IF CompilerVersion >= 34.0}

  // Get or create multicaster for this OLBoolean
  if not FValueMulticasters.TryGetValue(@b, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@b, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  b.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLBoolean
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Result);

  Result.RefreshControl();
end;


function TOLLinkManager.Link(const Lbl: TLabel; const f:
    TFunctionReturningOLInteger; const ValueOnErrorInCalculation: string =
    ERROR_STRING): TOLIntegerToLabel;
begin
  Result := TOLIntegerToLabel.Create;
  Result.Lbl := Lbl;
  Result.Calculation := f;
  Result.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  AddLink(Lbl, Result);

  Result.RefreshControl();
end;

function TOLLinkManager.Link(const Lbl: TLabel; const f:
    TFunctionReturningOLString; const ValueOnErrorInCalculation: string =
    ERROR_STRING): TOLStringToLabel;
begin
  Result := TOLStringToLabel.Create;
  Result.Lbl := Lbl;
  Result.Calculation := f;
  Result.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  AddLink(Lbl, Result);

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Lbl: TLabel; var s: OLString): TOLStringToLabel;
{$ELSE}
function TOLLinkManager.Link(const Lbl: TLabel; var s: OLString): TOLStringToLabel;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TOLStringToLabel.Create;
  Result.Lbl := Lbl;
  Result.FOLPointer := @s;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLString
  if not FValueMulticasters.TryGetValue(@s, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@s, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  s.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLString
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Lbl, Result);

  Result.RefreshControl();
end;

function TOLLinkManager.Link(const Lbl: TLabel; const f: TFunctionReturningOLDouble; const Format: string = DOUBLE_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING): TOLDoubleToLabel;
begin
  Result := TOLDoubleToLabel.Create;
  Result.FFormat := Format;
  Result.Lbl := Lbl;
  Result.Calculation := f;
  Result.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  AddLink(Lbl, Result);

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Lbl: TLabel; var d: OLDouble; const Format: string = DOUBLE_FORMAT): TOLDoubleToLabel;
{$ELSE}
function TOLLinkManager.Link(const Lbl: TLabel; var d: OLDouble; const Format: string = DOUBLE_FORMAT): TOLDoubleToLabel;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TOLDoubleToLabel.Create;
  Result.FFormat := Format;
  Result.Lbl := Lbl;
  Result.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLDouble
  if not FValueMulticasters.TryGetValue(@d, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@d, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  d.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLDouble
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Lbl, Result);

  Result.RefreshControl();
end;

function TOLLinkManager.Link(const Lbl: TLabel; const f: TFunctionReturningOLCurrency; const Format: string = CURRENCY_FORMAT; const ValueOnErrorInCalculation: string = ERROR_STRING): TOLCurrencyToLabel;
begin
  Result := TOLCurrencyToLabel.Create;
  Result.FFormat := Format;
  Result.Lbl := Lbl;
  Result.Calculation := f;
  Result.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  AddLink(Lbl, Result);

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Lbl: TLabel; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT): TOLCurrencyToLabel;
{$ELSE}
function TOLLinkManager.Link(const Lbl: TLabel; var curr: OLCurrency; const Format: string = CURRENCY_FORMAT): TOLCurrencyToLabel;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TOLCurrencyToLabel.Create;
  Result.FFormat := Format;
  Result.Lbl := Lbl;
  Result.FOLPointer := @curr;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLCurrency
  if not FValueMulticasters.TryGetValue(@curr, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@curr, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  curr.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLCurrency
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Lbl, Result);

  Result.RefreshControl();
end;

function TOLLinkManager.Link(const Lbl: TLabel; const f: TFunctionReturningOLDate; const ValueOnErrorInCalculation: string): TOLDateToLabel;
begin
  Result := TOLDateToLabel.Create;
  Result.Lbl := Lbl;
  Result.Calculation := f;
  Result.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  AddLink(Lbl, Result);

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Lbl: TLabel; var d: OLDateTime): TOLDateTimeToLabel;
{$ELSE}
function TOLLinkManager.Link(const Lbl: TLabel; var d: OLDateTime): TOLDateTimeToLabel;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TOLDateTimeToLabel.Create;
  Result.Lbl := Lbl;
  Result.FOLPointer := @d;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLDateTime
  if not FValueMulticasters.TryGetValue(@d, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@d, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  d.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLDateTime
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Lbl, Result);

  Result.RefreshControl();
end;

 function TOLLinkManager.Link(const Lbl: TLabel; const f: TFunctionReturningOLDateTime; const ValueOnErrorInCalculation: string): TOLDateTimeToLabel;
begin
  Result := TOLDateTimeToLabel.Create;
  Result.Lbl := Lbl;
  Result.Calculation := f;
  Result.ValueOnErrorInCalculation := ValueOnErrorInCalculation;
  AddLink(Lbl, Result);

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Edit: TSpinEdit; var i: OLInteger): TSpinEditToOLInteger;
{$ELSE}
function TOLLinkManager.Link(const Edit: TSpinEdit; var i: OLInteger): TSpinEditToOLInteger;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TSpinEditToOLInteger.Create;
  Result.Edit := Edit;
  Result.FOLPointer := @i;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLInteger
  if not FValueMulticasters.TryGetValue(@i, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@i, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  i.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLInteger
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Edit, Result);

  Result.RefreshControl();
end;

{$IF CompilerVersion >= 34.0}
function TOLLinkManager.Link(const Lbl: TLabel; var i: OLInteger): TOLIntegerToLabel;
{$ELSE}
function TOLLinkManager.Link(const Lbl: TLabel; var i: OLInteger): TOLIntegerToLabel;
{$IFEND}
var
  Observer: TObject;
  ValueMulticaster: TOLValueMulticaster;
begin
  Result := TOLIntegerToLabel.Create;
  Result.Lbl := Lbl;
  Result.FOLPointer := @i;
  {$IF CompilerVersion >= 34.0}
  // Get or create multicaster for this OLInteger
  if not FValueMulticasters.TryGetValue(@i, Observer) then
  begin
    ValueMulticaster := TOLValueMulticaster.Create;
    FValueMulticasters.Add(@i, ValueMulticaster);
  end
  else
    ValueMulticaster := Observer as TOLValueMulticaster;
  i.OnChange := ValueMulticaster.OnOLChange;  // Always set multicaster's handler on OLInteger
  ValueMulticaster.AddLink(Result);  // Register this link with the multicaster
  {$IFEND}
  AddLink(Lbl, Result);

  Result.RefreshControl();
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
