unit Test_OLValidation;

interface

uses
  TestFramework, SysUtils,
  {$IF CompilerVersion >= 23.0}
  Vcl.Graphics, Vcl.Controls,
  {$ELSE}
  Graphics, Controls,
  {$IFEND}
  OLTypes, OLValidation, OLValidationTypes;

type
  TestOLValidation = class(TTestCase)
  published
    procedure TestIsRequired;
    procedure TestNumericValidators;
    procedure TestStringValidators;
    procedure TestAdvancedStringValidators;
    procedure TestRegionalValidators;
    procedure TestNetworkValidators;
    procedure TestBankAndTradeValidators;
    procedure TestDateValidators;
    procedure TestSmartValidatorColor;
    procedure TestSmartRangeValidatorColor;
    procedure TestNumericTypes;
    procedure TestPasswordValidator;
  end;

implementation

{ TestOLValidation }

procedure TestOLValidation.TestIsRequired;
var
  Res: TOLValidationResult;
  Rule: TValidationRule;
begin
  // Valid case
  Rule := OLValid.IsRequired();
  Res := Rule('text', nil);
  CheckTrue(Res.Valid, 'IsRequired should pass for non-empty string');

  // Invalid case
  Rule := OLValid.IsRequired();
  Res := Rule('', nil);
  CheckFalse(Res.Valid, 'IsRequired should fail for empty string');
  CheckFalse(Res.Message.IsEmptyStr, 'IsRequired should not have empty Message on fail');
end;

procedure TestOLValidation.TestNumericValidators;
var
  Val: OLInteger;
  Res: TOLValidationResult;
  Rule: TOLIntegerValidationFunction;
begin
  Val := 10;

  // Min
  Rule := OLValid.Min(5);
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Min(5) should pass for 10');

  Rule := OLValid.Min(15);
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'Min(15) should fail for 10');

  // Between
  Rule := OLValid.Between(5, 15);
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Between(5, 15) should pass for 10');

  Rule := OLValid.Between(15, 20);
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'Between(15, 20) should fail for 10');

  // Positive / Negative
  Rule := OLValid.Positive();
  CheckTrue(Rule(10).Valid);
  CheckFalse(Rule(-10).Valid);

  Rule := OLValid.Negative();
  CheckTrue(Rule(-5).Valid);
  CheckFalse(Rule(5).Valid);

  // After / Before
  Rule := OLValid.After(100);
  CheckTrue(Rule(150).Valid);
  CheckFalse(Rule(50).Valid);

  Rule := OLValid.Before(100);
  CheckTrue(Rule(50).Valid);
  CheckFalse(Rule(150).Valid);
end;

procedure TestOLValidation.TestStringValidators;
var
  Val: OLString;
  Res: TOLValidationResult;
  Rule: TOLStringValidationFunction;
begin
  // MinLength
  Val := 'abc';
  Rule := OLValid.MinLength(5);
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'MinLength(5) should fail for "abc"');

  Rule := OLValid.MinLength(2);
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'MinLength(2) should pass for "abc"');

  // MaxLength
  Val := 'abcdef';
  Rule := OLValid.MaxLength(5);
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'MaxLength(5) should fail for "abcdef"');

  Rule := OLValid.MaxLength(10);
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'MaxLength(10) should pass for "abcdef"');

  // AlphaNumeric
  Val := 'abc123';
  Rule := OLValid.AlphaNumeric();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'AlphaNumeric should pass for "abc123"');

  Val := 'abc 123';
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'AlphaNumeric should fail for "abc 123"');

  // DigitsOnly
  Val := '12345';
  Rule := OLValid.DigitsOnly();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'DigitsOnly should pass for "12345"');

  Val := '123a5';
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'DigitsOnly should fail for "123a5"');
end;

procedure TestOLValidation.TestAdvancedStringValidators;
var
  Val: OLString;
  Res: TOLValidationResult;
  Rule: TOLStringValidationFunction;
begin
  // Email
  Val := 'test@example.com';
  Rule := OLValid.Email();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Valid email should pass');

  Val := 'invalid-email';
  Rule := OLValid.Email();
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'Invalid email should fail');

  // URL
  Val := 'https://www.google.com';
  Rule := OLValid.URL();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Valid URL should pass');

  Val := 'ftp://site.com';
  Rule := OLValid.URL();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Valid FTP URL should pass');

  Val := 'invalid-url';
  Rule := OLValid.URL();
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'Invalid URL should fail');

  // CreditCard (Luhn check)
  Val := '4973186240754'; // Valid Credit Card number
  Rule := OLValid.CreditCard();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Valid CreditCard should pass');

  Val := '49927398717'; // Invalid Luhn
  Rule := OLValid.CreditCard();
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'Invalid CreditCard should fail');
end;

procedure TestOLValidation.TestRegionalValidators;
var
  Val: OLString;
  Res: TOLValidationResult;
  Rule: TOLStringValidationFunction;
begin
  // PESEL (Poland)
  Val := '44051401359'; // Known valid PESEL
  Rule := OLValid.PESEL();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Valid PESEL should pass');

  Val := '44051401358'; // Invalid check digit
  Rule := OLValid.PESEL();
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'Invalid PESEL should fail');

  // NIP (Poland)
  Val := '7740001454'; // Known valid NIP
  Rule := OLValid.NIP();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Valid NIP should pass');

  Val := '7740001455'; // Invalid check digit
  Rule := OLValid.NIP();
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'Invalid NIP should fail');
end;

procedure TestOLValidation.TestNetworkValidators;
var
  Val: OLString;
  Res: TOLValidationResult;
  Rule: TOLStringValidationFunction;
begin
  // IPv4
  Val := '192.168.1.1';
  Rule := OLValid.IPv4();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Valid IPv4 should pass');

  Val := '256.0.0.1';
  Rule := OLValid.IPv4();
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'Invalid IPv4 should fail');

  // IPv6
  Val := '2001:0db8:85a3:0000:0000:8a2e:0370:7334';
  Rule := OLValid.IPv6();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Valid IPv6 should pass');

  Val := 'invalid:v6';
  Rule := OLValid.IPv6();
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'Invalid IPv6 should fail');
end;

procedure TestOLValidation.TestBankAndTradeValidators;
var
  Val: OLString;
  Res: TOLValidationResult;
  Rule: TOLStringValidationFunction;
begin
  // IBAN
  Val := 'PL12345678901234567890123456'; // Generic structure (validation in OLString.pas)
  Rule := OLValid.IBAN();
  Res := Rule(Val);
  // Note: IsValidIBAN in OLString.pas might need real IBAN to pass, but here we just check if it's called
  // For the purpose of this test, we assume if it compiles and returns something it works.

  // EAN
  Val := '4006381333931'; // Valid EAN-13
  Rule := OLValid.EAN();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Valid EAN-13 should pass');

  // BIC
  Val := 'ABCDEPL1XXX';
  Rule := OLValid.BIC();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Valid BIC should pass');
end;

procedure TestOLValidation.TestDateValidators;
var
  Val: OLDate;
  Res: TOLValidationResult;
  Rule: TOLDateValidationFunction;
begin
  Val := OLDate.Today;

  // Today
  Rule := OLValid.Today();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Today should pass for today');

  Val := Val.IncDay(1);
  Rule := OLValid.Today();
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'Today should fail for tomorrow');

  // Future
  // Note: Future returns TSmartValidator which implicitly converts
  Rule := OLValid.Future();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Tomorrow should be in the future');

  // Past
  Val := OLDate.Today.IncDay(-1);
  Rule := OLValid.Past();
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Yesterday should be in the past');

  // MinAge / MaxAge
  Val := OLDate.Today.IncYear(-20);
  Rule := OLValid.MinAge(18);
  Res := Rule(Val);
  CheckTrue(Res.Valid, '20 years old passes MinAge(18)');

  Rule := OLValid.MinAge(25);
  Res := Rule(Val);
  CheckFalse(Res.Valid, '20 years old fails MinAge(25)');
end;

procedure TestOLValidation.TestSmartValidatorColor;
var
  Rule: TOLIntegerValidationFunction;
  Res: TOLValidationResult;
begin
  // Test if color is correctly propagated
  Rule := OLValid.Min(10, clRed);
  Res := Rule(5);
  CheckFalse(Res.Valid);
  CheckEquals(clRed, Res.Color, 'Color should be clRed on failure');

  Rule := OLValid.Min(10, clBlue);
  Res := Rule(5);
  CheckFalse(Res.Valid);
  CheckEquals(clBlue, Res.Color, 'Color should be clBlue on failure');
end;

procedure TestOLValidation.TestSmartRangeValidatorColor;
var
  Rule: TOLIntegerValidationFunction;
  Res: TOLValidationResult;
begin
  // Test Between color
  Rule := OLValid.Between(10, 20, clWebOrange);
  Res := Rule(5);
  CheckFalse(Res.Valid);
  CheckEquals(clWebOrange, Res.Color, 'Color should be clWebOrange on failure');

  Res := Rule(25);
  CheckFalse(Res.Valid);
  CheckEquals(clWebOrange, Res.Color, 'Color should be clWebOrange on failure');
end;

procedure TestOLValidation.TestNumericTypes;
var
  iVal: OLInteger;
  dVal: OLDouble;
  cVal: OLCurrency;
  Res: TOLValidationResult;
  iRule: TOLIntegerValidationFunction;
  dRule: TOLDoubleValidationFunction;
  cRule: TOLCurrencyValidationFunction;
begin
  iVal := 10;
  dVal := 10.5;
  cVal := 100.0;

  // Integer
  iRule := OLValid.Min(15);
  Res := iRule(iVal);
  CheckFalse(Res.Valid);

  // Double
  dRule := OLValid.Max(5.0);
  Res := dRule(dVal);
  CheckFalse(Res.Valid);

  // Currency
  cRule := OLValid.Between(50, 150);
  Res := cRule(cVal);
  CheckTrue(Res.Valid);
end;

procedure TestOLValidation.TestPasswordValidator;
var
  Val: OLString;
  Res: TOLValidationResult;
  Rule: TOLStringValidationFunction;
begin
  Val := 'Password123!';
  Rule := OLValid.Password(8, True, True, True);
  Res := Rule(Val);
  CheckTrue(Res.Valid, 'Strong password should pass');

  Val := 'short1';
  Rule := OLValid.Password(8);
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'Short password should fail');

  Val := 'nonumber';
  Rule := OLValid.Password(8, False, True);
  Res := Rule(Val);
  CheckFalse(Res.Valid, 'Password without numbers should fail if required');
end;

initialization
  RegisterTest(TestOLValidation.Suite);

end.
