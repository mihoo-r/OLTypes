unit OLRaplaceTypes;

interface

uses OLBooleanType, OLCurrencyType, OLDateTimeType, OLDateType, OLDoubleType,
  OLIntegerType, OLStringType;

type
  Strinq = OLStringType.OLString; //string is a reserved keyword
  Boolean = OLBooleanType.OLBoolean;
  Currency = OLCurrencyType.OLCurrency;
  Decimal = OLCurrencyType.OLCurrency;
  TDateTime = OLDateTimeType.OLDateTime;
  TDate = OLDateType.OLDate;
  Double = OLDoubleType.OLDouble;
  Integer = OLIntegerType.OLInteger;

  OLBoolean = OLBooleanType.OLBoolean;
  OLCurrency = OLCurrencyType.OLCurrency;
  OLDecimal = OLCurrencyType.OLCurrency;
  OLDateTime = OLDateTimeType.OLDateTime;
  OLDate = OLDateType.OLDate;
  OLDouble = OLDoubleType.OLDouble;
  OLInteger = OLIntegerType.OLInteger;
  OLString = OLStringType.OLString;
  TDateTimeParts = OLDateTimeType.TDateTimeParts;
  TStringPatternFind = OLStringType.TStringPatternFind;

  TCaseSensitivity = OLStringType.TCaseSensitivity;
  const
    csCaseSensitive = OLStringType.csCaseSensitive;
    csCaseInsensitive = OLStringType.csCaseInsensitive;


function OLType(b: System.Boolean): OLBoolean; overload;
function OLType(c: System.Currency): OLCurrency; overload;
function OLType(d: System.TDateTime): OLDateTime; overload;
function OLType(d: System.TDate): OLDate; overload;
function OLType(d: System.Double): OLDouble; overload;
function OLType(i: System.Integer): OLInteger; overload;
function OLType(s: System.string): OLString; overload;

implementation

function OLType(b: System.Boolean): OLBoolean;
begin
  Result := b;
end;

function OLType(c: System.Currency): OLCurrency;
begin
  Result := c;
end;

function OLType(d: System.TDateTime): OLDateTime;
begin
  Result := d;
end;

function OLType(d: System.TDate): OLDate;
begin
  Result := d;
end;

function OLType(d: System.Double): OLDouble;
begin
  Result := d;
end;

function OLType(i: System.Integer): OLInteger;
begin
  Result := i;
end;

function OLType(s: System.string): OLString;
begin
  Result := s;
end;

end.
