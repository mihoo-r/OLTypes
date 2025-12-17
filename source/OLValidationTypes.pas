unit OLValidationTypes;

interface

uses
  {$IF CompilerVersion >= 23.0}
  Vcl.Graphics, Vcl.Controls,
  {$ELSE}
  Graphics, Controls,
  {$IFEND}
  OLIntegerType, OLBooleanType, OLDoubleType, OLCurrencyType, OLDateType, OLDateTimeType, OLStringType;

type
  /// <summary>Represents the result of a validation check.</summary>
  TOLValidationResult = record
    /// <summary>True if the value is valid, false otherwise.</summary>
    Valid: Boolean;
    /// <summary>Error message to display if validation fails.</summary>
    Message: string;
    /// <summary>Color to apply to the control if validation fails (e.g. clRed).</summary>
    Color: TColor;
    /// <summary>Creates a successful validation result.</summary>
    class function Ok: TOLValidationResult;  static;
    /// <summary>Creates a failed validation result with an error message and optional color.</summary>
    class function Error(MessageText: string; ControlColor: TColor = clDefault):
        TOLValidationResult; static;
  end;

  /// <summary>Function that validates a raw string value from a control.</summary>
  TValidationRule = reference to function(const Value: string; const SenderControl: TControl): TOLValidationResult;

  /// <summary>Function for a custom, anonymous validation rule.</summary>
  TCustomValidationRule = reference to function(const Value: string; const SenderControl: TControl): TOLValidationResult;

  // Typed validation functions for OL types
  /// <summary>Function that validates an OLInteger value.</summary>
  TOLIntegerValidationFunction = reference to function(Value: OLInteger): TOLValidationResult;
  /// <summary>Function that validates an OLDouble value.</summary>
  TOLDoubleValidationFunction = reference to function(Value: OLDouble): TOLValidationResult;
  /// <summary>Function that validates an OLCurrency value.</summary>
  TOLCurrencyValidationFunction = reference to function(Value: OLCurrency): TOLValidationResult;
  /// <summary>Function that validates an OLString value.</summary>
  TOLStringValidationFunction = reference to function(Value: OLString): TOLValidationResult;
  /// <summary>Function that validates an OLBoolean value.</summary>
  TOLBooleanValidationFunction = reference to function(Value: OLBoolean): TOLValidationResult;
  /// <summary>Function that validates an OLDate value.</summary>
  TOLDateValidationFunction = reference to function(Value: OLDate): TOLValidationResult;
  /// <summary>Function that validates an OLDateTime value.</summary>
  TOLDateTimeValidationFunction = reference to function(Value: OLDateTime): TOLValidationResult;

implementation

{ TOLValidationResult }

class function TOLValidationResult.Error(MessageText: string; ControlColor:
    TColor): TOLValidationResult;
begin
  Result.Valid := false;
  Result.Message := MessageText;
  Result.Color := ControlColor;
end;

class function TOLValidationResult.Ok: TOLValidationResult;
begin
  Result.Valid := true;
  Result.Message := '';
  Result.Color := clNone; 
end;

end.
