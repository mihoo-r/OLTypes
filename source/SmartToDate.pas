unit SmartToDate;

interface

function TrySmartStrToDate(s: string; var d: TDate): Boolean;
function SmartStrToDate(s: string): TDate;

const
  // today, yesterday, tomorow
  ssTD = 'td';
  ssTM = 'tm';
  ssYD = 'yd';

  // Start/End of the Month/Year
  ssSY = 'sy';
  ssEY = 'ey';
  ssSM = 'sm';
  ssEM = 'em';

  // Start/End of the Next Month/Year
  ssSNY = 'sny';
  ssENY = 'eny';
  ssSNM = 'snm';
  ssENM = 'enm';

  // Start/End of the Prior Month/Year
  ssSPY = 'spy';
  ssEPY = 'epy';
  ssSPM = 'spm';
  ssEPM = 'epm';

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
  if (s = 't') or (s = ssTD) then
  begin
    d := Date;
    OutPut := true;
  end;
  if (s = 'y') or (s = ssYD) then
  begin
    d := IncDay(Date, -1);
    OutPut := true;
  end;
  if s = ssTM then
  begin
    d := IncDay(Date, 1);
    OutPut := true;
  end;
  if s = ssEY then
  begin
    d := Floor(EndOfTheYear(Date));
    OutPut := true;
  end;
  if s = ssEM then
  begin
    d := Floor(EndOfTheMonth(Date));
    OutPut := true;
  end;
  if s = ssSY then
  begin
    d := StartOfTheYear(Date);
    OutPut := true;
  end;
  if s = ssSM then
  begin
    d := StartOfTheMonth(Date);
    OutPut := true;
  end;
  if s = ssENY then
  begin
    d := Floor(EndOfTheYear(IncYear(Date, 1)));
    OutPut := true;
  end;
  if s = ssENM then
  begin
    d := Floor(EndOfTheMonth(IncMonth(Date, 1)));
    OutPut := true;
  end;
  if s = ssSNY then
  begin
    d := StartOfTheYear(IncYear(Date, 1));
    OutPut := true;
  end;
  if s = ssSNM then
  begin
    d := StartOfTheMonth(IncMonth(Date, 1));
    OutPut := true;
  end;
  if s = ssEPY then
  begin
    d := Floor(EndOfTheYear(IncYear(Date, -1)));
    OutPut := true;
  end;
  if s = ssEPM then
  begin
    d := Floor(EndOfTheMonth(IncMonth(Date, -1)));
    OutPut := true;
  end;
  if s = ssSPY then
  begin
    d := StartOfTheYear(IncYear(Date, -1));
    OutPut := true;
  end;
  if s = ssSPM then
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
