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


  // Types moved to OLValidationTypes.pas



  TOLValidators = class
  public
    /// <summary>
    ///   Returns a validation rule that checks if the string value is not empty.
    /// </summary>
    class function IsRequired(const ErrorMessage: string = 'This field is required.'): TValidationRule; static;

    // Integer Validators
    /// <summary>Checks if the integer value is at least MinValue.</summary>
    class function MinInt(const MinValue: Integer; const ErrorMessage: string = ''): TOLIntegerValidationFunction; static;
    /// <summary>Checks if the integer value is at most MaxValue.</summary>
    class function MaxInt(const MaxValue: Integer; const ErrorMessage: string = ''): TOLIntegerValidationFunction; static;
    /// <summary>Checks if the integer value is between MinValue and MaxValue (inclusive).</summary>
    class function BetweenInt(const MinValue, MaxValue: Integer; const ErrorMessage: string = ''): TOLIntegerValidationFunction; static;
    /// <summary>Checks if the integer value is greater than zero.</summary>
    class function PositiveInt(const ErrorMessage: string = ''): TOLIntegerValidationFunction; static;
    /// <summary>Checks if the integer value is less than zero.</summary>
    class function NegativeInt(const ErrorMessage: string = ''): TOLIntegerValidationFunction; static;

    // Double Validators
    /// <summary>Checks if the double value is at least MinValue.</summary>
    class function MinDouble(const MinValue: Double; const ErrorMessage: string = ''): TOLDoubleValidationFunction; static;
    /// <summary>Checks if the double value is at most MaxValue.</summary>
    class function MaxDouble(const MaxValue: Double; const ErrorMessage: string = ''): TOLDoubleValidationFunction; static;
    /// <summary>Checks if the double value is between MinValue and MaxValue.</summary>
    class function BetweenDouble(const MinValue, MaxValue: Double; const ErrorMessage: string = ''): TOLDoubleValidationFunction; static;
    /// <summary>Checks if the double value is greater than zero.</summary>
    class function PositiveDouble(const ErrorMessage: string = ''): TOLDoubleValidationFunction; static;
    /// <summary>Checks if the double value is less than zero.</summary>
    class function NegativeDouble(const ErrorMessage: string = ''): TOLDoubleValidationFunction; static;

    // Currency Validators
    /// <summary>Checks if the currency value is at least MinValue.</summary>
    class function MinCurrency(const MinValue: Currency; const ErrorMessage: string = ''): TOLCurrencyValidationFunction; static;
    /// <summary>Checks if the currency value is at most MaxValue.</summary>
    class function MaxCurrency(const MaxValue: Currency; const ErrorMessage: string = ''): TOLCurrencyValidationFunction; static;
    /// <summary>Checks if the currency value is between MinValue and MaxValue.</summary>
    class function BetweenCurrency(const MinValue, MaxValue: Currency; const ErrorMessage: string = ''): TOLCurrencyValidationFunction; static;
    /// <summary>Checks if the currency value is greater than zero.</summary>
    class function PositiveCurrency(const ErrorMessage: string = ''): TOLCurrencyValidationFunction; static;
    /// <summary>Checks if the currency value is less than zero.</summary>
    class function NegativeCurrency(const ErrorMessage: string = ''): TOLCurrencyValidationFunction; static;

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

    // Date Validators
    /// <summary>Checks if the date is in the past.</summary>
    class function PastDate(const ErrorMessage: string = ''): TOLDateValidationFunction; static;
    /// <summary>Checks if the date is in the future.</summary>
    class function FutureDate(const ErrorMessage: string = ''): TOLDateValidationFunction; static;
    /// <summary>Checks if the date is after a specified date.</summary>
    class function AfterDate(const AValue: OLDate; const ErrorMessage: string = ''): TOLDateValidationFunction; static;
    /// <summary>Checks if the date is before a specified date.</summary>
    class function BeforeDate(const AValue: OLDate; const ErrorMessage: string = ''): TOLDateValidationFunction; static;
    /// <summary>Checks if the date is between AMin and AMax.</summary>
    class function BetweenDate(const AMin, AMax: OLDate; const ErrorMessage: string = ''): TOLDateValidationFunction; static;
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

    // DateTime Validators
    /// <summary>Checks if the date and time are in the past.</summary>
    class function PastDateTime(const ErrorMessage: string = ''): TOLDateTimeValidationFunction; static;
    /// <summary>Checks if the date and time are in the future.</summary>
    class function FutureDateTime(const ErrorMessage: string = ''): TOLDateTimeValidationFunction; static;
    /// <summary>Checks if the date and time are after a specified value.</summary>
    class function AfterDateTime(const AValue: OLDateTime; const ErrorMessage: string = ''): TOLDateTimeValidationFunction; static;
    /// <summary>Checks if the date and time are before a specified value.</summary>
    class function BeforeDateTime(const AValue: OLDateTime; const ErrorMessage: string = ''): TOLDateTimeValidationFunction; static;
    /// <summary>Checks if the date and time are between AMin and AMax.</summary>
    class function BetweenDateTime(const AMin, AMax: OLDateTime; const ErrorMessage: string = ''): TOLDateTimeValidationFunction; static;
  end;

implementation

{ TOLValidators }


class function TOLValidators.IsRequired(const ErrorMessage: string): TValidationRule;
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

class function TOLValidators.MinInt(const MinValue: Integer; const ErrorMessage: string): TOLIntegerValidationFunction;
begin
  Result := function(Value: OLInteger): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok); // Allow Null, use IsRequired to forbid

    if Value < MinValue then
    begin
      if ErrorMessage = '' then
        Msg := Format(GetLocalizedMessage(ValidationMessages.MinInt, 'Value must be at least %d.'), [MinValue])
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function TOLValidators.MaxInt(const MaxValue: Integer; const ErrorMessage: string): TOLIntegerValidationFunction;
begin
  Result := function(Value: OLInteger): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok);

    if Value > MaxValue then
    begin
      if ErrorMessage = '' then
        Msg := Format(GetLocalizedMessage(ValidationMessages.MaxInt, 'Value must be at most %d.'), [MaxValue])
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function TOLValidators.BetweenInt(const MinValue, MaxValue: Integer; const ErrorMessage: string): TOLIntegerValidationFunction;
begin
  Result := function(Value: OLInteger): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok);

    if (Value < MinValue) or (Value > MaxValue) then
    begin
      if ErrorMessage = '' then
        Msg := Format(GetLocalizedMessage(ValidationMessages.BetweenInt, 'Value must be between %d and %d.'), [MinValue, MaxValue])
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function TOLValidators.PositiveInt(const ErrorMessage: string): TOLIntegerValidationFunction;
begin
  Result := function(Value: OLInteger): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok);

    if Value.AsInteger <= 0 then
    begin
      if ErrorMessage = '' then
        Msg := GetLocalizedMessage(ValidationMessages.Positive, 'Value must be positive.')
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function TOLValidators.NegativeInt(const ErrorMessage: string): TOLIntegerValidationFunction;
begin
  Result := function(Value: OLInteger): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok);

    if Value.AsInteger >= 0 then
    begin
      if ErrorMessage = '' then
        Msg := GetLocalizedMessage(ValidationMessages.Negative, 'Value must be negative.')
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

{ Double Validators }

class function TOLValidators.MinDouble(const MinValue: Double; const ErrorMessage: string): TOLDoubleValidationFunction;
begin
  Result := function(Value: OLDouble): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok);

    if Value < MinValue then
    begin
      if ErrorMessage = '' then
        Msg := Format(GetLocalizedMessage(ValidationMessages.MinDouble, 'Value must be at least %g.'), [MinValue])
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function TOLValidators.MaxDouble(const MaxValue: Double; const ErrorMessage: string): TOLDoubleValidationFunction;
begin
  Result := function(Value: OLDouble): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok);

    if Value > MaxValue then
    begin
      if ErrorMessage = '' then
        Msg := Format(GetLocalizedMessage(ValidationMessages.MaxDouble, 'Value must be at most %g.'), [MaxValue])
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function TOLValidators.BetweenDouble(const MinValue, MaxValue: Double; const ErrorMessage: string): TOLDoubleValidationFunction;
begin
  Result := function(Value: OLDouble): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok);

    if (Value < MinValue) or (Value > MaxValue) then
    begin
      if ErrorMessage = '' then
        Msg := Format(GetLocalizedMessage(ValidationMessages.BetweenDouble, 'Value must be between %g and %g.'), [MinValue, MaxValue])
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function TOLValidators.PositiveDouble(const ErrorMessage: string): TOLDoubleValidationFunction;
begin
  Result := function(Value: OLDouble): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok);

    if Value <= 0 then
    begin
      if ErrorMessage = '' then
        Msg := 'Value must be positive.'
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function TOLValidators.NegativeDouble(const ErrorMessage: string): TOLDoubleValidationFunction;
begin
  Result := function(Value: OLDouble): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok);

    if Value >= 0 then
    begin
      if ErrorMessage = '' then
        Msg := GetLocalizedMessage(ValidationMessages.Negative, 'Value must be negative.')
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

{ Currency Validators }

class function TOLValidators.MinCurrency(const MinValue: Currency; const ErrorMessage: string): TOLCurrencyValidationFunction;
begin
  Result := function(Value: OLCurrency): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok);

    if Value < MinValue then
    begin
      if ErrorMessage = '' then
        Msg := Format(GetLocalizedMessage(ValidationMessages.MinCurrency, 'Value must be at least %m.'), [MinValue])
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function TOLValidators.MaxCurrency(const MaxValue: Currency; const ErrorMessage: string): TOLCurrencyValidationFunction;
begin
  Result := function(Value: OLCurrency): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok);

    if Value > MaxValue then
    begin
      if ErrorMessage = '' then
        Msg := Format(GetLocalizedMessage(ValidationMessages.MaxCurrency, 'Value must be at most %m.'), [MaxValue])
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function TOLValidators.BetweenCurrency(const MinValue, MaxValue: Currency; const ErrorMessage: string): TOLCurrencyValidationFunction;
begin
  Result := function(Value: OLCurrency): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok);

  if (Value < MinValue) or (Value > MaxValue) then
    begin
      if ErrorMessage = '' then
        Msg := Format(GetLocalizedMessage(ValidationMessages.BetweenCurrency, 'Value must be between %m and %m.'), [MinValue, MaxValue])
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function TOLValidators.PositiveCurrency(const ErrorMessage: string): TOLCurrencyValidationFunction;
begin
  Result := function(Value: OLCurrency): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok);

    if Value <= 0 then
    begin
      if ErrorMessage = '' then
        Msg := GetLocalizedMessage(ValidationMessages.Positive, 'Value must be positive.')
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

class function TOLValidators.NegativeCurrency(const ErrorMessage: string): TOLCurrencyValidationFunction;
begin
  Result := function(Value: OLCurrency): TOLValidationResult
  var
    Msg: string;
  begin
    if not Value.HasValue then
      Exit(TOLValidationResult.Ok);

    if Value >= 0 then
    begin
      if ErrorMessage = '' then
        Msg := GetLocalizedMessage(ValidationMessages.Negative, 'Value must be negative.')
      else
        Msg := ErrorMessage;
      Result := TOLValidationResult.Error(Msg);
    end
    else
      Result := TOLValidationResult.Ok;
  end;
end;

{ String Validators }

class function TOLValidators.MinLength(const MinLen: Integer; const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.MaxLength(const MaxLen: Integer; const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.AlphaNumeric(const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.DigitsOnly(const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.Email(const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.Password(const MinLen: Integer; const RequireMixedCase, RequireDigits, RequireSpecialChar: Boolean; const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.URL(const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.CreditCard(const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.EAN(const IsGTIN14: Boolean; const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.BIC(const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.IPv4(const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.IPv6(const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.IBAN(const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.PESEL(const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.NIP(const ErrorMessage: string): TOLStringValidationFunction;
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

class function TOLValidators.PastDate(const ErrorMessage: string): TOLDateValidationFunction;
begin
  Result := function(Value: OLDate): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if Value < OLDate.Today then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.PastDate, 'Date must be in the past.'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function TOLValidators.FutureDate(const ErrorMessage: string): TOLDateValidationFunction;
begin
  Result := function(Value: OLDate): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if Value > OLDate.Today then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.FutureDate, 'Date must be in the future.'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function TOLValidators.AfterDate(const AValue: OLDate; const ErrorMessage: string): TOLDateValidationFunction;
begin
  Result := function(Value: OLDate): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if Value > AValue then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(Format(GetLocalizedMessage(ValidationMessages.AfterDate, 'Date must be after %s.'), [AValue.ToString]))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function TOLValidators.BeforeDate(const AValue: OLDate; const ErrorMessage: string): TOLDateValidationFunction;
begin
  Result := function(Value: OLDate): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if Value < AValue then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(Format(GetLocalizedMessage(ValidationMessages.BeforeDate, 'Date must be before %s.'), [AValue.ToString]))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function TOLValidators.BetweenDate(const AMin, AMax: OLDate; const ErrorMessage: string): TOLDateValidationFunction;
begin
  Result := function(Value: OLDate): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if Value.InRange(AMin, AMax) then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(Format(GetLocalizedMessage(ValidationMessages.BetweenDate, 'Date must be between %s and %s.'), [AMin.ToString, AMax.ToString]))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function TOLValidators.Today(const ErrorMessage: string): TOLDateValidationFunction;
begin
  Result := function(Value: OLDate): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if Value = OLDate.Today then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.Today, 'Date must be today.'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function TOLValidators.MinAge(const Age: Integer; const ErrorMessage: string): TOLDateValidationFunction;
begin
  Result := function(Value: OLDate): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if OLDate.Today.YearsBetween(Value) >= Age then
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

class function TOLValidators.MaxAge(const Age: Integer; const ErrorMessage: string): TOLDateValidationFunction;
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

class function TOLValidators.IsWeekday(const ErrorMessage: string): TOLDateValidationFunction;
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

class function TOLValidators.IsWeekend(const ErrorMessage: string): TOLDateValidationFunction;
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

class function TOLValidators.PastDateTime(const ErrorMessage: string): TOLDateTimeValidationFunction;
begin
  Result := function(Value: OLDateTime): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if Value < OLDateTime.Now then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.PastDateTime, 'Date and time must be in the past.'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function TOLValidators.FutureDateTime(const ErrorMessage: string): TOLDateTimeValidationFunction;
begin
  Result := function(Value: OLDateTime): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if Value > OLDateTime.Now then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(GetLocalizedMessage(ValidationMessages.FutureDateTime, 'Date and time must be in the future.'))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function TOLValidators.AfterDateTime(const AValue: OLDateTime; const ErrorMessage: string): TOLDateTimeValidationFunction;
begin
  Result := function(Value: OLDateTime): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if Value > AValue then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(Format(GetLocalizedMessage(ValidationMessages.AfterDateTime, 'Date and time must be after %s.'), [AValue.ToString]))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function TOLValidators.BeforeDateTime(const AValue: OLDateTime; const ErrorMessage: string): TOLDateTimeValidationFunction;
begin
  Result := function(Value: OLDateTime): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if Value < AValue then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(Format(GetLocalizedMessage(ValidationMessages.BeforeDateTime, 'Date and time must be before %s.'), [AValue.ToString]))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

class function TOLValidators.BetweenDateTime(const AMin, AMax: OLDateTime; const ErrorMessage: string): TOLDateTimeValidationFunction;
begin
  Result := function(Value: OLDateTime): TOLValidationResult
  begin
    if not Value.HasValue then Exit(TOLValidationResult.Ok);
    if (Value >= AMin) and (Value <= AMax) then
      Result := TOLValidationResult.Ok
    else
    begin
      if ErrorMessage = '' then
        Result := TOLValidationResult.Error(Format(GetLocalizedMessage(ValidationMessages.BetweenDateTime, 'Date and time must be between %s and %s.'), [AMin.ToString, AMax.ToString]))
      else
        Result := TOLValidationResult.Error(ErrorMessage);
    end;
  end;
end;

end.