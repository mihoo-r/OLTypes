unit SmartToDate;

interface

function TrySmartStrToDate(s: string; var d: TDate): Boolean;
function SmartStrToDate(s: string): TDate;

const
  // today, yesterday, tomorow
  ssTD = 't'; ssTD2 = 'td';
  ssTM = 'm'; ssTM2 = 'tm';
  ssYD = 'y'; ssYD2 = 'yd';

  // Start/End of the Month/Year
  ssSY = 'sy'; ssSY2 = 'ss';
  ssEY = 'ey'; ssEY2 = 'ee';
  ssSM = 's'; ssSM2 = 'sm';
  ssEM = 'e'; ssEM2 = 'em';

  // Start/End of the Next Month/Year
  ssSNY = 'dd'; ssSNY2 = 'sny';
  ssENY = 'rr'; ssENY2 = 'eny';
  ssSNM = 'd'; ssSNM2 = 'snm';
  ssENM = 'r'; ssENM2 = 'enm';

  // Start/End of the Prior Month/Year
  ssSPY = 'aa'; ssSPY2 = 'spy';
  ssEPY = 'ww'; ssEPY2 = 'epy';
  ssSPM = 'a'; ssSPM2 = 'spm';
  ssEPM = 'w'; ssEPM2 = 'epm';

implementation

uses SysUtils, StrUtils, Math, DateUtils;

procedure DigitsSmartToDate(Digits: String; var OutPut: Boolean; var d: TDate);
var
  YearStr: String;
  DayStr: String;
  MonthStr: String;
  day: Word;
  y: Word;
  m: Word;
  dt: TDateTime;
begin
  DecodeDate(Date, y, m, day);
  DayStr := RightStr(Digits, 2);
  if Length(Digits) > 2 then
  begin
    MonthStr := MidStr(Digits, Length(Digits) - 3, Min(2, Length(Digits) - 2));
  end
  else
    MonthStr := IntToStr(m);
  if Length(Digits) > 4 then
  begin
    YearStr := MidStr(Digits, Length(Digits) - 7, Min(4, Length(Digits) - 4));
    if Length(YearStr) = 3 then
      YearStr := '2' + YearStr;
    if Length(YearStr) = 2 then
      YearStr := '20' + YearStr;
    if Length(YearStr) = 1 then
      YearStr := '200' + YearStr;
  end
  else
    YearStr := IntToStr(y);
  OutPut := TryEncodeDate(StrToInt(YearStr), StrToInt(MonthStr), StrToInt(DayStr), dt);
  if OutPut then
    d := dt;
end;

procedure AlfaSmartToDate(s: string; var d: TDate; var OutPut: Boolean);
begin
  if (s = ssTD) or (s = ssTD2) then
  begin
    d := Date;
    OutPut := true;
  end;
  if (s = ssYD) or (s = ssYD2) then
  begin
    d := IncDay(Date, -1);
    OutPut := true;
  end;
  if (s = ssTM) or (s = ssTM2) then
  begin
    d := IncDay(Date, 1);
    OutPut := true;
  end;
  if (s = ssEY) or (s = ssEY2) then
  begin
    d := Floor(EndOfTheYear(Date));
    OutPut := true;
  end;
  if (s = ssEM) or (s = ssEM2) then
  begin
    d := Floor(EndOfTheMonth(Date));
    OutPut := true;
  end;
  if (s = ssSY) or (s=ssSY2) then
  begin
    d := StartOfTheYear(Date);
    OutPut := true;
  end;
  if (s = ssSM) or (s = ssSM2) then
  begin
    d := StartOfTheMonth(Date);
    OutPut := true;
  end;
  if (s = ssENY) or (s = ssENY2)then
  begin
    d := Floor(EndOfTheYear(IncYear(Date, 1)));
    OutPut := true;
  end;
  if (s = ssENM) or (s = ssENM2) then
  begin
    d := Floor(EndOfTheMonth(IncMonth(Date, 1)));
    OutPut := true;
  end;
  if (s = ssSNY) or (s = ssSNY2) then
  begin
    d := StartOfTheYear(IncYear(Date, 1));
    OutPut := true;
  end;
  if (s = ssSNM) or (s = ssSNM2) then
  begin
    d := StartOfTheMonth(IncMonth(Date, 1));
    OutPut := true;
  end;
  if (s = ssEPY) or (s = ssEPY2) then
  begin
    d := Floor(EndOfTheYear(IncYear(Date, -1)));
    OutPut := true;
  end;
  if (s = ssEPM) or (s = ssEPM2) then
  begin
    d := Floor(EndOfTheMonth(IncMonth(Date, -1)));
    OutPut := true;
  end;
  if (s = ssSPY) or (s = ssSPY2) then
  begin
    d := StartOfTheYear(IncYear(Date, -1));
    OutPut := true;
  end;
  if (s = ssSPM) or (s = ssSPM2) then
  begin
    d := StartOfTheMonth(IncMonth(Date, -1));
    OutPut := true;
  end;
end;

function DigitsOnly(s: string): String;
const
  Digits = ['0'..'9'];
var
  OutPut: String;
  i: integer;
begin
  OutPut := '';

  for i := 1 to Length(s) do
  begin
    if s[i] in Digits then
      OutPut := OutPut + s[i];
  end;

  Result := OutPut;
end;

//ISO 8601
function TrySmartStrToDate(s: string; var d: TDate): Boolean;
var
  OutPut: Boolean;
  Digits: string;
  b: Boolean;
  dt: TDateTime;
begin
  OutPut := TryStrToDate(s, dt);

  if OutPut then
  begin
    d := ceil(dt);
  end
  else
  begin
    Digits := DigitsOnly(s);

    if Digits <> EmptyStr then
    begin
      DigitsSmartToDate(Digits, b, d);
      OutPut := b;
    end
    else
    begin
      AlfaSmartToDate(s, d, OutPut);
    end;
  end;


  Result := OutPut;
end;

function SmartStrToDate(s: string): TDate;
var
  d: TDate;
begin
  if not TrySmartStrToDate(s, d) then
    raise Exception.Create(QuotedStr(s) +' cannot be decoded as date.');

  Result := d;
end;

end.
