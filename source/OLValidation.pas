unit OLValidation;

interface

uses
  {$IF CompilerVersion >= 23.0}
  Vcl.Graphics, Vcl.Controls,
  {$ELSE}
  Graphics, Controls,
  {$IFEND}
  {$IF CompilerVersion >= 23.0} System.SysUtils {$ELSE} SysUtils {$IFEND};

type


  // Represents the result of a validation check
  TOLValidationResult = record
    Valid: Boolean;
    Message: string;
    Color: TColor; // Color to apply to the control if validation fails
    class function Ok: TOLValidationResult;  static;
    class function Error(MessageText: string; ControlColor: TColor = clDefault):
        TOLValidationResult; static;
  end;

  // Type for a single validation rule function (reusable)
  // Value: The string value from the control.
  // SenderControl: The control being validated (for context, e.g., checking other controls).
  // Output: The validation result.
  // Returns True if validation passed, False otherwise.
  TValidationRule = reference to function(const Value: string; const SenderControl: TControl): TOLValidationResult;

  // Type for a custom, anonymous validation function (specific to one binding)
  TCustomValidationRule = reference to function(const Value: string; const SenderControl: TControl): TOLValidationResult;


  TOLValidators = class
  public
    /// <summary>
    ///   Returns a validation rule that checks if the string value is not empty.
    /// </summary>
    class function IsRequired(const ErrorMessage: string = 'This field is required.'): TValidationRule; static;
  end;

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
  Result.Color := clNone; // Or a default success color if needed
end;

{ TOLValidators }

class function TOLValidators.IsRequired(const ErrorMessage: string): TValidationRule;
begin
  Result := function(const Value: string; const SenderControl: TControl): TOLValidationResult
  begin
    if Trim(Value) = '' then
      Result := TOLValidationResult.Error(ErrorMessage)
    else
      Result := TOLValidationResult.Ok;
  end;
end;

end.