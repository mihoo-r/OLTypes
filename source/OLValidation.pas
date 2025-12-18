unit OLValidation;

interface

uses
  {$IF CompilerVersion >= 23.0}
  Vcl.Graphics, Vcl.Controls,
  {$ELSE}
  Graphics, Controls,
  {$IFEND}
  {$IF CompilerVersion >= 23.0} System.SysUtils, System.Types, System.StrUtils, System.DateUtils {$ELSE} SysUtils, Types, StrUtils, DateUtils {$IFEND},
  OLIntegerType, OLDoubleType, OLCurrencyType, OLStringType, OLDateType, OLDateTimeType, OLValidationTypes, OLValidationLocalization;

type
  /// <summary>Internal types for smart overloading.</summary>
  TSmartValidatorType = (svtMin, svtMax, svtPositive, svtNegative, svtAfter, svtBefore);

  /// <summary>
  ///   A record that can implicitly convert to any numeric/date validation function.
  ///   This solves the ambiguity of numeric literals in overloaded methods.
  /// </summary>
  TSmartValidator = record
  public
    FType: TSmartValidatorType;
    FValue: Extended;
    FMessage: string;
    class function Create(AType: TSmartValidatorType; AValue: Extended; const AMessage: string): TSmartValidator; static;
    class operator Implicit(const a: TSmartValidator): TOLIntegerValidationFunction;
    class operator Implicit(const a: TSmartValidator): TOLDoubleValidationFunction;
    class operator Implicit(const a: TSmartValidator): TOLCurrencyValidationFunction;
    class operator Implicit(const a: TSmartValidator): TOLDateValidationFunction;
    class operator Implicit(const a: TSmartValidator): TOLDateTimeValidationFunction;
  end;

  /// <summary>A record for range-based smart validators (Between).</summary>
  TSmartRangeValidator = record
  public
    FMin, FMax: Extended;
    FMessage: string;
    class function Create(AMin, AMax: Extended; const AMessage: string): TSmartRangeValidator; static;
    class operator Implicit(const a: TSmartRangeValidator): TOLIntegerValidationFunction;
    class operator Implicit(const a: TSmartRangeValidator): TOLDoubleValidationFunction;
    class operator Implicit(const a: TSmartRangeValidator): TOLCurrencyValidationFunction;
    class operator Implicit(const a: TSmartRangeValidator): TOLDateValidationFunction;
    class operator Implicit(const a: TSmartRangeValidator): TOLDateTimeValidationFunction;
  end;

  OLValid = class
  public
    /// <summary>
    ///   Returns a validation rule that checks if the string value is not empty.
    /// </summary>
    class function IsRequired(const ErrorMessage: string = 'This field is required.'): TValidationRule; static;

    // Numeric/Date Validators (Using Smart Overloading)
    /// <summary>Checks if the numeric or date value is at least AValue.</summary>
    class function Min(const AValue: Extended; const ErrorMessage: string = ''): TSmartValidator; overload; static;
    /// <summary>Checks if the numeric or date value is at most AValue.</summary>
    class function Max(const AValue: Extended; const ErrorMessage: string = ''): TSmartValidator; overload; static;
    /// <summary>Checks if the value is between AMin and AMax.</summary>
    class function Between(const AMin, AMax: Extended; const ErrorMessage: string = ''): TSmartRangeValidator; overload; static;
    /// <summary>Checks if the value is after a specified value.</summary>
    class function After(const AValue: Extended; const ErrorMessage: string = ''): TSmartValidator; overload; static;
    /// <summary>Checks if the value is before a specified value.</summary>
    class function Before(const AValue: Extended; const ErrorMessage: string = ''): TSmartValidator; overload; static;

    /// <summary>Checks if the value is greater than zero.</summary>
    class function Positive(const ErrorMessage: string = ''): TSmartValidator; static;
    /// <summary>Checks if the value is less than zero.</summary>
    class function Negative(const ErrorMessage: string = ''): TSmartValidator; static;

    // String Validators
    /// <summary>Checks if the string length is at least MinLen.</summary>
    class function MinLength(const MinLen: Integer; const ErrorMessage: string = ''): TOLStringValidationFunction; static;
    /// <summary>Checks if the string length is at most MaxLen.</summary>
    class function MaxLength(const MaxLen: Integer; const ErrorMessage: string = ''): TOLStringValidationFunction; static;
    /// <summary>Checks if the string contains only alphanumeric characters.</summary>
    class function AlphaNumeric(const ErrorMessage: string = ''): TOLStringValidationFunction; static;
    /// <summary>Checks if the string contains only digits.</summary>
    class function DigitsOnly(const ErrorMessage: string = ''): TOLStringValidationFunction; static;
    /// <summary>Checks if the string is a valid email address.</summary>
    class function Email(const ErrorMessage: string = ''): TOLStringValidationFunction; static;
    /// <summary>Checks if the string meets password complexity requirements.</summary>
    class function Password(const MinLen: Integer = 8; const RequireMixedCase: Boolean = True; const RequireDigits: Boolean = True; const RequireSpecialChar: Boolean = False; const ErrorMessage: string = ''): TOLStringValidationFunction; static;
    /// <summary>Checks if the string is a valid URL.</summary>
    class function URL(const ErrorMessage: string = ''): TOLStringValidationFunction; static;
    /// <summary>Checks if the string is a valid Credit Card number (Luhn check).</summary>
    class function CreditCard(const ErrorMessage: string = ''): TOLStringValidationFunction; static;
    /// <summary>Checks if the string is a valid EAN/GTIN code.</summary>
    class function EAN(const IsGTIN14: Boolean = False; const ErrorMessage: string = ''): TOLStringValidationFunction; static;
    /// <summary>Checks if the string is a valid BIC/SWIFT code.</summary>
    class function BIC(const ErrorMessage: string = ''): TOLStringValidationFunction; static;
    /// <summary>Checks if the string is a valid IPv4 address.</summary>
    class function IPv4(const ErrorMessage: string = ''): TOLStringValidationFunction; static;
    /// <summary>Checks if the string is a valid IPv6 address.</summary>
    class function IPv6(const ErrorMessage: string = ''): TOLStringValidationFunction; static;
    /// <summary>Checks if the string is a valid IBAN.</summary>
    class function IBAN(const ErrorMessage: string = ''): TOLStringValidationFunction; static;
    /// <summary>Checks if the string is a valid PESEL number (Poland).</summary>
    class function PESEL(const ErrorMessage: string = ''): TOLStringValidationFunction; static;
    /// <summary>Checks if the string is a valid NIP number (Poland).</summary>
    class function NIP(const ErrorMessage: string = ''): TOLStringValidationFunction; static;

    /// <summary>Checks if the date/time is in the past.</summary>
    class function Past(const ErrorMessage: string = ''): TSmartValidator; static;
    /// <summary>Checks if the date/time is in the future.</summary>
    class function Future(const ErrorMessage: string = ''): TSmartValidator; static;
    /// <summary>Checks if the date is today.</summary>
    class function Today(const ErrorMessage: string = ''): TOLDateValidationFunction; static;
    /// <summary>Checks if the birth date implies a minimum age.</summary>
    class function MinAge(const Age: Integer; const ErrorMessage: string = ''): TOLDateValidationFunction; static;
    /// <summary>Checks if the birth date implies a maximum age.</summary>
    class function MaxAge(const Age: Integer; const ErrorMessage: string = ''): TOLDateValidationFunction; static;
    /// <summary>Checks if the date is a weekday (Mon-Fri).</summary>
    class function IsWeekday(const ErrorMessage: string = ''): TOLDateValidationFunction; static;
    /// <summary>Checks if the date is a weekend (Sat-Sun).</summary>
    class function IsWeekend(const ErrorMessage: string = ''): TOLDateValidationFunction; static;

  end;

implementation

{ TSmartValidator }

class function TSmartValidator.Create(AType: TSmartValidatorType; AValue: Extended; const AMessage: string): TSmartValidator;
begin
  Result.FType := AType;
  Result.FValue := AValue;
  Result.FMessage := AMessage;
end;

class operator TSmartValidator.Implicit(const a: TSmartValidator): TOLIntegerValidationFunction;
begin
  Result := function(Value: OLInteger): TOLValidationResult
  var
    Msg: string;
    ival: Integer;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    ival := Trunc(a.FValue);
    case a.FType of
      svtMin: if Value < ival then
        begin
          if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.MinInt, 'Value must be at least %d.'), [ival]) else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
      svtMax: if Value > ival then
        begin
          if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.MaxInt, 'Value must be at most %d.'), [ival]) else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
      svtPositive: if Value <= 0 then
        begin
          if a.FMessage = '' then Msg := GetLocalizedMessage(ValidationMessages.Positive, 'Value must be positive.') else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
      svtNegative: if Value >= 0 then
        begin
          if a.FMessage = '' then Msg := GetLocalizedMessage(ValidationMessages.Negative, 'Value must be negative.') else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
    end;
    Result := TOLValidationResult.Ok;
  end;
end;

class operator TSmartValidator.Implicit(const a: TSmartValidator): TOLDoubleValidationFunction;
begin
  Result := function(Value: OLDouble): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    case a.FType of
      svtMin, svtAfter: if Value < a.FValue then
        begin
          if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.MinDouble, 'Value must be at least %g.'), [a.FValue]) else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
      svtMax, svtBefore: if Value > a.FValue then
        begin
          if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.MaxDouble, 'Value must be at most %g.'), [a.FValue]) else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
      svtPositive: if Value <= 0 then
        begin
          if a.FMessage = '' then Msg := GetLocalizedMessage(ValidationMessages.Positive, 'Value must be positive.') else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
      svtNegative: if Value >= 0 then
        begin
          if a.FMessage = '' then Msg := GetLocalizedMessage(ValidationMessages.Negative, 'Value must be negative.') else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
    end;
    Result := TOLValidationResult.Ok;
  end;
end;

class operator TSmartValidator.Implicit(const a: TSmartValidator): TOLCurrencyValidationFunction;
begin
  Result := function(Value: OLCurrency): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    case a.FType of
      svtMin: if Value < a.FValue then
        begin
          if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.MinCurrency, 'Value must be at least %m.'), [a.FValue]) else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
      svtMax: if Value > a.FValue then
        begin
          if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.MaxCurrency, 'Value must be at most %m.'), [a.FValue]) else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
      svtPositive: if Value <= 0 then
        begin
          if a.FMessage = '' then Msg := GetLocalizedMessage(ValidationMessages.Positive, 'Value must be positive.') else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
      svtNegative: if Value >= 0 then
        begin
          if a.FMessage = '' then Msg := GetLocalizedMessage(ValidationMessages.Negative, 'Value must be negative.') else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
    end;
    Result := TOLValidationResult.Ok;
  end;
end;

class operator TSmartValidator.Implicit(const a: TSmartValidator): TOLDateValidationFunction;
begin
  Result := function(Value: OLDate): TOLValidationResult
  var
    Msg: string;
    target: TDateTime;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    target := Int(a.FValue); // Use date part for OLDate
    case a.FType of
      svtMin, svtAfter: if Value <= target then
        begin
          if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.AfterDate, 'Date must be after %s.'), [DateToStr(target)]) else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
      svtMax, svtBefore: if Value >= target then
        begin
          if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.BeforeDate, 'Date must be before %s.'), [DateToStr(target)]) else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
    end;
    Result := TOLValidationResult.Ok;
  end;
end;

class operator TSmartValidator.Implicit(const a: TSmartValidator): TOLDateTimeValidationFunction;
begin
  Result := function(Value: OLDateTime): TOLValidationResult
  var
    Msg: string;
    target: TDateTime;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    target := a.FValue;
    case a.FType of
      svtMin, svtAfter: if Value <= target then
        begin
          if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.AfterDateTime, 'Date and time must be after %s.'), [DateTimeToStr(target)]) else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
      svtMax, svtBefore: if Value >= target then
        begin
          if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.BeforeDateTime, 'Date and time must be before %s.'), [DateTimeToStr(target)]) else Msg := a.FMessage;
          Exit(TOLValidationResult.Error(Msg));
        end;
    end;
    Result := TOLValidationResult.Ok;
  end;
end;

{ TSmartRangeValidator }

class function TSmartRangeValidator.Create(AMin, AMax: Extended; const AMessage: string): TSmartRangeValidator;
begin
  Result.FMin := AMin;
  Result.FMax := AMax;
  Result.FMessage := AMessage;
end;

class operator TSmartRangeValidator.Implicit(const a: TSmartRangeValidator): TOLIntegerValidationFunction;
begin
  Result := function(Value: OLInteger): TOLValidationResult
  var
    Msg: string;
    iMin, iMax: Integer;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    iMin := Trunc(a.FMin);
    iMax := Trunc(a.FMax);
    if (Value < iMin) or (Value > iMax) then
    begin
      if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.BetweenInt, 'Value must be between %d and %d.'), [iMin, iMax]) else Msg := a.FMessage;
      Exit(TOLValidationResult.Error(Msg));
    end;
    Result := TOLValidationResult.Ok;
  end;
end;

class operator TSmartRangeValidator.Implicit(const a: TSmartRangeValidator): TOLDoubleValidationFunction;
begin
  Result := function(Value: OLDouble): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if (Value < a.FMin) or (Value > a.FMax) then
    begin
      if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.BetweenDouble, 'Value must be between %g and %g.'), [a.FMin, a.FMax]) else Msg := a.FMessage;
      Exit(TOLValidationResult.Error(Msg));
    end;
    Result := TOLValidationResult.Ok;
  end;
end;

class operator TSmartRangeValidator.Implicit(const a: TSmartRangeValidator): TOLCurrencyValidationFunction;
begin
  Result := function(Value: OLCurrency): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if (Value < a.FMin) or (Value > a.FMax) then
    begin
      if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.BetweenCurrency, 'Value must be between %m and %m.'), [a.FMin, a.FMax]) else Msg := a.FMessage;
      Exit(TOLValidationResult.Error(Msg));
    end;
    Result := TOLValidationResult.Ok;
  end;
end;

class operator TSmartRangeValidator.Implicit(const a: TSmartRangeValidator): TOLDateValidationFunction;
begin
  Result := function(Value: OLDate): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if not Value.InRange(OLDate(a.FMin), OLDate(a.FMax)) then
    begin
      if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.BetweenDate, 'Date must be between %s and %s.'), [OLDate(a.FMin).ToString, OLDate(a.FMax).ToString]) else Msg := a.FMessage;
      Exit(TOLValidationResult.Error(Msg));
    end;
    Result := TOLValidationResult.Ok;
  end;
end;

class operator TSmartRangeValidator.Implicit(const a: TSmartRangeValidator): TOLDateTimeValidationFunction;
begin
  Result := function(Value: OLDateTime): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if (Value < a.FMin) or (Value > a.FMax) then
    begin
      if a.FMessage = '' then Msg := Format(GetLocalizedMessage(ValidationMessages.BetweenDateTime, 'Date and time must be between %s and %s.'), [OLDateTime(a.FMin).ToString, OLDateTime(a.FMax).ToString]) else Msg := a.FMessage;
      Exit(TOLValidationResult.Error(Msg));
    end;
    Result := TOLValidationResult.Ok;
  end;
end;

{ OLValid }


class function OLValid.IsRequired(const ErrorMessage: string): TValidationRule;
begin
  Result := function(const Value: string; const SenderControl: TControl): TOLValidationResult
  var
    Msg: string;
  begin
    if Trim(Value) = '' then
    begin
      if ErrorMessage = '' then
        Msg := GetLocalizedMessage(ValidationMessages.Required, 'Field is required.')
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function OLValid.Min(const AValue: Extended; const ErrorMessage: string): TSmartValidator;
begin
  Result := TSmartValidator.Create(svtMin, AValue, ErrorMessage);
end;

class function OLValid.Max(const AValue: Extended; const ErrorMessage: string): TSmartValidator;
begin
  Result := TSmartValidator.Create(svtMax, AValue, ErrorMessage);
end;

class function OLValid.Between(const AMin, AMax: Extended; const ErrorMessage: string): TSmartRangeValidator;
begin
  Result := TSmartRangeValidator.Create(AMin, AMax, ErrorMessage);
end;

class function OLValid.After(const AValue: Extended; const ErrorMessage: string): TSmartValidator;
begin
  Result := TSmartValidator.Create(svtAfter, AValue, ErrorMessage);
end;

class function OLValid.Before(const AValue: Extended; const ErrorMessage: string): TSmartValidator;
begin
  Result := TSmartValidator.Create(svtBefore, AValue, ErrorMessage);
end;

class function OLValid.Positive(const ErrorMessage: string): TSmartValidator;
begin
  Result := TSmartValidator.Create(svtPositive, 0, ErrorMessage);
end;

class function OLValid.Negative(const ErrorMessage: string): TSmartValidator;
begin
  Result := TSmartValidator.Create(svtNegative, 0, ErrorMessage);
end;

{ String Validators }

class function OLValid.MinLength(const MinLen: Integer; const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  var
    Msg: string;
  begin
    if (not Value.HasValue) or (Value.Length < MinLen) then
    begin
      if ErrorMessage = '' then
        Msg := Format(GetLocalizedMessage(ValidationMessages.MinLength, 'Minimal length is %d characters.'), [MinLen])
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function OLValid.MaxLength(const MaxLen: Integer; const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  var
    Msg: string;
  begin
    if Value.HasValue and (Value.Length > MaxLen) then
    begin
      if ErrorMessage = '' then
        Msg := Format(GetLocalizedMessage(ValidationMessages.MaxLength, 'Maximal length is %d characters.'), [MaxLen])
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function OLValid.AlphaNumeric(const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  var
    i: Integer;
    s: string;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    s := Value;
    for i := 1 to Length(s) do
      if not (s[i] in ['a'..'z', 'A'..'Z', '0'..'9']) then
      begin
        if ErrorMessage = '' then
          Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.AlphaNumeric, 'Only letters and digits are allowed.'))
        else
          Result := TOLValidationResult.Error(ErrorMessage);
        Exit;
      end;
    Result := TOLValidationResult.Ok;
  end;
end;

class function OLValid.DigitsOnly(const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  var
    i: Integer;
    s: string;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    s := Value;
    for i := 1 to Length(s) do
      if not (s[i] in ['0'..'9']) then
      begin
        if ErrorMessage = '' then
          Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.DigitsOnly, 'Only digits are allowed.'))
        else
          Result := TOLValidationResult.Error(ErrorMessage);
        Exit;
      end;
    Result := TOLValidationResult.Ok;
  end;
end;

class function OLValid.Email(const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  var
    s: string;
    atPos, dotPos: Integer;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    s := Value;
    // Basic validation without regex for maximum compatibility
    atPos := Pos('@', s);
    dotPos := LastDelimiter('.', s);
    if (atPos > 1) and (dotPos > atPos + 1) and (dotPos < Length(s)) then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Email, 'Invalid email format.'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function OLValid.Password(const MinLen: Integer; const RequireMixedCase, RequireDigits, RequireSpecialChar: Boolean; const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  var
    s: string;
    i: Integer;
    hasUpper, hasLower, hasDigit, hasSpecial: Boolean;
  begin
    if not Value.HasValue or (Value.Length = 0) then
      Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.PassRequired, 'Password is required.'))
    else
    begin
      s := Value;
      if Length(s) < MinLen then
      begin
        Result := TOLValidationResult.Error(Format(GetLocalizedMessage(ValidationMessages.PassTooShort, 'Password must be at least %d characters long.'), [MinLen]));
        Exit;
      end;
      hasUpper := False; hasLower := False; hasDigit := False; hasSpecial := False;
      for i := 1 to Length(s) do
      begin
        if s[i] in ['A'..'Z'] then hasUpper := True
        else if s[i] in ['a'..'z'] then hasLower := True
        else if s[i] in ['0'..'9'] then hasDigit := True
        else hasSpecial := True;
      end;
      if RequireMixedCase and (not (hasUpper and hasLower)) then
      begin
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.PassMixedCase, 'Password must contain both upper and lower case letters.'));
        Exit;
      end;
      if RequireDigits and (not hasDigit) then
      begin
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.PassDigit, 'Password must contain at least one digit.'));
        Exit;
      end;
      if RequireSpecialChar and (not hasSpecial) then
      begin
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.PassSpecial, 'Password must contain at least one special character.'));
        Exit;
      end;
      Result := TOLValidationResult.Ok;
    end;
  end;
end;

class function OLValid.URL(const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  var
    s: string;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    s := LowerCase(Value);
    if (Pos('http://', s) = 1) or (Pos('https://', s) = 1) or (Pos('ftp://', s) = 1) then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Url, 'Invalid URL (must start with http://, https:// or ftp://).'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function OLValid.CreditCard(const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  var
    s: string;
    i, digit, sum, weight: Integer;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    s := Value.DigitsOnly;
    if Length(s) < 13 then
    begin
      Result := TOLValidationResult.Error('Invalid credit card number length.');
      Exit;
    end;
    sum := 0;
    weight := 1;
    for i := Length(s) downto 1 do
    begin
      digit := Ord(s[i]) - Ord('0');
      digit := digit * weight;
      if digit > 9 then digit := digit - 9;
      sum := sum + digit;
      if weight = 1 then weight := 2 else weight := 1;
    end;
    if (sum mod 10) = 0 then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.CreditCard, 'Invalid credit card number (Luhn check failed).'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function OLValid.EAN(const IsGTIN14: Boolean; const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  var
    s: string;
    i, digit, sum, weight, expectedLen: Integer;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    s := Value.DigitsOnly;
    if IsGTIN14 then expectedLen := 14 else expectedLen := 13;
    if Length(s) <> expectedLen then
    begin
      Result := TOLValidationResult.Error(Format('Invalid EAN/GTIN length (expected %d).', [expectedLen]));
      Exit;
    end;
    sum := 0;
    if IsGTIN14 then
      for i := 1 to 13 do
      begin
        digit := Ord(s[i]) - Ord('0');
        if (i mod 2) = 1 then weight := 3 else weight := 1;
        sum := sum + digit * weight;
      end
    else
      for i := 1 to 12 do
      begin
        digit := Ord(s[i]) - Ord('0');
        if (i mod 2) = 0 then weight := 3 else weight := 1;
        sum := sum + digit * weight;
      end;
    digit := (10 - (sum mod 10)) mod 10;
    if digit = (Ord(s[expectedLen]) - Ord('0')) then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Ean, 'Invalid EAN/GTIN check digit.'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function OLValid.BIC(const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  var
    s: string;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    s := Value.UpperCase;
    if (Length(s) = 8) or (Length(s) = 11) then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Bic, 'Invalid BIC/SWIFT code (must be 8 or 11 characters).'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function OLValid.IPv4(const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  var
    parts: TStringDynArray;
    i, val: Integer;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    parts := Value.SplitString('.');
    if Length(parts) <> 4 then
    begin
      Result := TOLValidationResult.Error('Invalid IPv4 format (expected x.x.x.x).');
      Exit;
    end;
    for i := 0 to 3 do
    begin
      if not TryStrToInt(parts[i], val) or (val < 0) or (val > 255) then
      begin
        if ErrorMessage = '' then
          Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Ipv4, 'Invalid IPv4 address.'))
        else
          Result := TOLValidationResult.Error(ErrorMessage);
        Exit;
      end;
    end;
    Result := TOLValidationResult.Ok;
  end;
end;

class function OLValid.IPv6(const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  var
    parts: TStringDynArray;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    parts := Value.SplitString(':');
    if (Length(parts) >= 3) and (Length(parts) <= 8) then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Ipv6, 'Invalid IPv6 address.'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function OLValid.IBAN(const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  begin
    if (not Value.HasValue) or Value.IsValidIBAN then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Iban, 'Invalid IBAN.'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function OLValid.PESEL(const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  var
    S: string;
    i, Sum, ControlDigit: Integer;
    Weights: array[0..9] of Integer;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    S := Value;

    if Length(S) <> 11 then
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Pesel, 'Invalid PESEL number.'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
      Exit;
    end;

    Weights[0] := 1; Weights[1] := 3; Weights[2] := 7; Weights[3] := 9; Weights[4] := 1;
    Weights[5] := 3; Weights[6] := 7; Weights[7] := 9; Weights[8] := 1; Weights[9] := 3;

    Sum := 0;
    for i := 1 to 10 do
    begin
      if not (S[i] in ['0'..'9']) then
      begin
        if ErrorMessage = '' then
          Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Pesel, 'Invalid PESEL number.'))
        else
          Result := TOLValidationResult.Error(ErrorMessage);
        Exit;
      end;
      Sum := Sum + Weights[i - 1] * (Ord(S[i]) - Ord('0'));
    end;

    ControlDigit := (10 - (Sum mod 10)) mod 10;
    if (Ord(S[11]) - Ord('0')) = ControlDigit then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Pesel, 'Invalid PESEL number.'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function OLValid.NIP(const ErrorMessage: string): TOLStringValidationFunction;
begin
  Result := function(Value: OLString): TOLValidationResult
  var
    S: string;
    i, Sum, ControlDigit: Integer;
    Weights: array[0..8] of Integer;
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    S := OLString(Value).DigitsOnly();

    if Length(S) <> 10 then
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Nip, 'Invalid NIP number.'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
      Exit;
    end;

    Weights[0] := 6; Weights[1] := 5; Weights[2] := 7; Weights[3] := 2; Weights[4] := 3;
    Weights[5] := 4; Weights[6] := 5; Weights[7] := 6; Weights[8] := 7;

    Sum := 0;
    for i := 1 to 9 do
    begin
      if not (S[i] in ['0'..'9']) then
      begin
        if ErrorMessage = '' then
          Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Nip, 'Invalid NIP number.'))
        else
          Result := TOLValidationResult.Error(ErrorMessage);
        Exit;
      end;
      Sum := Sum + Weights[i - 1] * (Ord(S[i]) - Ord('0'));
    end;

    ControlDigit := Sum mod 11;
    if (ControlDigit <> 10) and ((Ord(S[10]) - Ord('0')) = ControlDigit) then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Nip, 'Invalid NIP number.'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

{ Date Validators }

class function OLValid.Today(const ErrorMessage: string): TOLDateValidationFunction;
begin
  Result := function(Value: OLDate): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if Value = OLDate.Today then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Today, 'Date must be today.')) // Reuse generic date error or add specific one
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function OLValid.MinAge(const Age: Integer; const ErrorMessage: string): TOLDateValidationFunction;
begin
  Result := function(Value: OLDate): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if Value.YearsBetween(OLDate.Today) >= Age then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(Format(GetLocalizedMessage(ValidationMessages.MinAge, 'You must be at least %d years old.'), [Age]))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function OLValid.MaxAge(const Age: Integer; const ErrorMessage: string): TOLDateValidationFunction;
begin
  Result := function(Value: OLDate): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if Value.YearsBetween(OLDate.Today) <= Age then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(Format(GetLocalizedMessage(ValidationMessages.MaxAge, 'Age cannot exceed %d years.'), [Age]))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function OLValid.IsWeekday(const ErrorMessage: string): TOLDateValidationFunction;
begin
  Result := function(Value: OLDate): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if not (DayOfTheWeek(Value) in [6, 7]) then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.IsWeekday, 'Date must be a weekday (Monday-Friday).'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function OLValid.IsWeekend(const ErrorMessage: string): TOLDateValidationFunction;
begin
  Result := function(Value: OLDate): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if DayOfTheWeek(Value) in [6, 7] then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.IsWeekend, 'Date must be a weekend (Saturday-Sunday).'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

{ DateTime Validators }

class function OLValid.Past(const ErrorMessage: string): TSmartValidator;
begin
  Result := TSmartValidator.Create(svtBefore, Now, ErrorMessage);
end;

class function OLValid.Future(const ErrorMessage: string): TSmartValidator;
begin
  Result := TSmartValidator.Create(svtAfter, Now, ErrorMessage);
end;

end.