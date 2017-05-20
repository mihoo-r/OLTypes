unit OLTypes;

interface

uses OLBooleanType, OLCurrencyType, OLDateTimeType, OLDateType, OLDoubleType,
  OLIntegerType, OLStringType, SmartToDate;

type
  OLBoolean = OLBooleanType.OLBoolean;
  OLCurrency = OLCurrencyType.OLCurrency;
  OLDecimal = OLCurrencyType.OLCurrency;
  OLDateTime = OLDateTimeType.OLDateTime;
  OLDate = OLDateType.OLDate;
  OLDouble = OLDoubleType.OLDouble;
  OLInteger = OLIntegerType.OLInteger;
  OLString = OLStringType.OLString;
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

const
  // today, yesterday, tomorow
  ssTD = SmartToDate.ssTD;
  ssTM = SmartToDate.ssTM;
  ssYD = SmartToDate.ssYD;

  // Start/End of the Month/Year
  ssSY = SmartToDate.ssSY;
  ssEY = SmartToDate.ssEY;
  ssSM = SmartToDate.ssSM;
  ssEM = SmartToDate.ssEM;

  // Start/End of the Next Month/Year
  ssSNY = SmartToDate.ssSNY;
  ssENY = SmartToDate.ssENY;
  ssSNM = SmartToDate.ssSNM;
  ssENM = SmartToDate.ssENM;

  // Start/End of the Prior Month/Year
  ssSPY = SmartToDate.ssSPY;
  ssEPY = SmartToDate.ssEPY;
  ssSPM = SmartToDate.ssSPM;
  ssEPM = SmartToDate.ssEPM;

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
