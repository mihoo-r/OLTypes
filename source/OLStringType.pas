unit OLStringType;

interface

uses
  variants, SysUtils, StrUtils, Types, Graphics, OLBooleanType, OLCurrencyType,
  OLDateTimeType, OLDateType, OLDoubleType, OLIntegerType;

type
  TCaseSensitivity = (csCaseSensitive, csCaseInsensitive);
  TStringPatternFind = record
    Value: string;
    Position: integer;
  end;

  OLString = record
  private
    Val: string;
    NullFlag: string;
    DefaultValueFlag: string;

    function GetHasValue(): OLBoolean;
    procedure SetHasValue(Value: OLBoolean);
    function GetLine(Index: integer): OLString;
    procedure SetLine(Index: integer; const Value: OLString);
    function IBANCalculateDigits(iban: OLString): OLInteger;
    function IBANChangeAlpha(input: string): string;
    procedure AlfaSmartToDate(s: string; var d: OLDate; var OutPut: OLBoolean); overload;
    procedure AlfaSmartToDate(s: string; var d: TDate; var OutPut: OLBoolean); overload;
    procedure DigitsSmartToDate(Digits: OLString; var OutPut: OLBoolean;
      var d: TDate); overload;
    procedure DigitsSmartToDate(Digits: OLString; var OutPut: OLBoolean;
      var d: OLDate); overload;
    function GetValue: string;
    procedure SetValue(const Value: string);
    property HasValue: OLBoolean read GetHasValue write SetHasValue;

    function GetCharAtIndex(Index: integer): Char;
    procedure SetCharAtIndex(Index: integer; Value: Char);
    procedure TurnDefaultValueFlagOff();
    property Value: string read GetValue write SetValue;
  public
    function IsNull(): OLBoolean;
    function IsEmptyStr(): OLBoolean;
    function IfNull(i: OLString): OLString;

    function GetLineStartPosition(Index: integer): OLInteger;

    function CSVFieldValue(FieldIndex: integer; Delimiter: Char = ';'): OLString;
    function CSVFieldCount(Delimiter: Char = ';'): OLInteger;
    function Length(): OLInteger;

    function ContainsStr(ASubString: OLString): OLBoolean;
    function ContainsText(ASubText: OLString): OLBoolean;
    function RepeatedString(ACount: integer): OLString;

    function StartsStr(const ASubString: string): OLBoolean;
    function StartsText(const ASubText: string): OLBoolean;
    function EndsStr(ASubString: OLString): OLBoolean;
    function EndsText(ASubString: OLString): OLBoolean;

    function IndexStr(const AValues: array of string): OLInteger;
    function IndexText(const AValues: array of string): OLInteger;
    function MatchStr(const AValues: array of string): OLBoolean;
    function MatchText(const AValues: array of string): OLBoolean;

    function MidStr(const AStart, ACount: integer): OLString;
    function FindPatternStr(InFront: OLString; Behind: OLString; StartingPosition: integer = 1; CaseSensitivity: TCaseSensitivity = csCaseSensitive) : OLString; overload;
    function FindPatternStr(Tag: OLString; StartingPosition: integer = 1; CaseSensitivity: TCaseSensitivity = csCaseInsensitive): OLString; overload;
    function FindPattern(InFront: OLString; Behind: OLString; StartingPosition: integer = 1; CaseSensitivity: TCaseSensitivity = csCaseSensitive) : TStringPatternFind; overload;
    function FindPattern(Tag: OLString; StartingPosition: integer = 1; CaseSensitivity: TCaseSensitivity = csCaseInsensitive): TStringPatternFind; overload;

    function Pos(SubStr: string; CaseSensitivity: TCaseSensitivity = csCaseSensitive): OLInteger;
    function PosEx(SubStr: string; Offset: integer; CaseSensitivity: TCaseSensitivity = csCaseSensitive): OLInteger;

    function Replaced(const AFromText, AToText: string): OLString;
    function ReplacedFirst(const AFromText, AToText: string): OLString;
    function ReplacedText(const AFromText, AToText: string): OLString;
    function ReplacedFirstText(const AFromText, AToText: string): OLString;
    function ReplacedStartingAt(Position: Cardinal; const NewValue: OLString): OLString;

    function ReversedString(): OLString;

    function RightStr(const ACount: integer): OLString;
    function LeftStr(const ACount: integer): OLString;
    function EndingRemoved(const ACount: integer): OLString;
    function RightStrFrom(StartFrom: integer): OLString;

    function SplitString(const Delimiters: string = ';'): TStringDynArray;

    function Inserted(const InsertStr: string; Position: integer): OLString;
    function Deleted(FromPosition: integer; Count: integer = 1): OLString;

    function ExtractedFileDriveString(): OLString;
    function ExtractedFileDir(): OLString;
    function ExtractedFilePath(): OLString;
    function ExtractedFileName(): OLString;
    function ExtractedFileExt(): OLString;

    function Formated(Const Data: array of const ): OLString;
    function LastDelimiterPosition(const Delimiters: string = ';'): OLInteger;

    function LowerCase(): OLString;
    function UpperCase(): OLString;
    function InitCaps(): OLString;

    function Trimed(): OLString;
    function TrimedLeft(): OLString;
    function TrimedRight(): OLString;
    function QuotedStr(): OLString;
    function SameStr(s: OLString): OLBoolean;
    function SameText(s: OLString): OLBoolean;

    function DigitsOnly(): OLString;
    function SpacesRemoved(): OLString;

    function LeadingCharsAdded(C: Char; NewLength: integer): OLString;
    function TrailingCharsAdded(C: Char; NewLength: integer): OLString;
    function LeadingZerosAdded(NewLength: integer): OLString;
    function LeadingSpacesAdded(NewLength: integer): OLString;
    function TrailingSpacesAdded(NewLength: integer): OLString;

    function ToString(): string;
    function ToCurr(): OLCurrency;
    function ToDate(): OLDate;
    function ToDateTime(): OLDateTime;
    function ToFloat(): OLDouble;
    function ToInt(): OLInteger;
    function ToInt64(): Int64;

    function TryToCurr(): OLBoolean; overload;
    function TryToDate(): OLBoolean; overload;
    function TryToDateTime(): OLBoolean; overload;
    function TryToFloat(): OLBoolean; overload;
    function TryToInt(): OLBoolean; overload;
    function TryToInt64(): OLBoolean; overload;

    function TryToCurr(var c: Currency): OLBoolean; overload;
    function TryToCurr(var c: OLCurrency): OLBoolean; overload;
    function TryToDate(var d: TDate): OLBoolean; overload;
    function TryToDate(var d: OLDate): OLBoolean; overload;
    function TryToDate(var d: TDateTime): OLBoolean; overload;
    function TryToDateTime(var dt: TDateTime): OLBoolean; overload;
    function TryToDateTime(var dt: OLDateTime): OLBoolean; overload;
    function TryToFloat(var e: Extended): OLBoolean; overload;
    function TryToFloat(var e: Double): OLBoolean; overload;
    function TryToFloat(var e: OLDouble): OLBoolean; overload;
    function TryToInt(var i: integer): OLBoolean; overload;
    function TryToInt(var i: OLInteger): OLBoolean; overload;
    function TryToInt64(var i: Int64): OLBoolean; overload;

    function TrySmartStrToDate(): OLBoolean; overload;
    function TrySmartStrToDate(var d: TDate): OLBoolean; overload;
    function TrySmartStrToDate(var d: OLDate): OLBoolean; overload;
    function SmartStrToDate(): OLDate;

    procedure EndcodeBase64FromFile(FileName: string);
    procedure DecodeBase64ToFile(FileName: string);

    function Compressed(): string;
    function Decompressed(): string;

    function TrailingPathDelimiterExcluded(): OLString;
    function TrailingPathDelimiterIncluded(): OLString;
    function TrailingCharExcluded(c: Char): OLString;
    function TrailingCharIncluded(c: Char): OLString;
    function TrailingComaExcluded(): OLString;
    function TrailingComaIncluded(): OLString;

    function PixelWidth(F: TFont): OLInteger;

    function OccurrencesCount(SubString: string; CaseSensitivity: TCaseSensitivity = csCaseSensitive): OLInteger;
    function OccurrencesPosition(SubString: string; Index: integer; CaseSensitivity: TCaseSensitivity = csCaseSensitive): OLInteger;

    function LineCount(): OLInteger;
    procedure LineAdd(NewLine: string);
    procedure LineDelete(LineIndex: integer);
    procedure LineInsertAt(LineIndex: integer; s: string);
    function LineIndexOf(s: string): OLInteger;
    procedure LoadFromFile(FileName: string);
    procedure SaveToFile(FileName: string);

    procedure CopyToClipboard();
    procedure PasteFromClipboard();

    function Hash(Salt: string = ''): cardinal;
    function HashStr(Salt: string = ''): OLString;

    procedure GetFromUrl(URL: string);

    function IsValidIBAN(): OLBoolean;

    class function RandomFrom(const AValues: array of string): OLString; static;

    class operator Add(a, b: OLString): OLString;
    class operator Implicit(a: string): OLString;
    class operator Implicit(a: OLString): string;
    class operator Implicit(a: Variant): OLString;
    class operator Implicit(a: OLString): Variant;

    class operator Equal(a, b: OLString): OLBoolean;
    class operator NotEqual(a, b: OLString): OLBoolean;
    class operator GreaterThan(a, b: OLString): OLBoolean;
    class operator GreaterThanOrEqual(a, b: OLString): OLBoolean;
    class operator LessThan(a, b: OLString): OLBoolean;
    class operator LessThanOrEqual(a, b: OLString): OLBoolean;

    property Chars[Index: integer]: Char read GetCharAtIndex write SetCharAtIndex; default;
    property Lines[Index: integer]: OLString read GetLine write SetLine;
  end;

implementation

uses
  Classes, Clipbrd, WinInet, DateUtils, Math, EncdDecd, ZLib;

{ OLString }

const
  NonEmptyStr = ' ';
  DefaultValue = '';

class operator OLString.Add(a, b: OLString): OLString;
var
  returnrec: OLString;
begin
  returnrec.Value := a.Value + b.Value;
  returnrec.HasValue := a.HasValue and b.HasValue;
  Result := returnrec;
end;

procedure OLString.EndcodeBase64FromFile(FileName: string);
var
  InputStream: TFileStream;
  OutputStream: TStringStream;
begin
  InputStream := TFileStream.Create(FileName, fmOpenRead);
  try
    OutputStream := TStringStream.Create;
    try
      EncodeStream(InputStream, OutputStream);
      Self := OutputStream.DataString;
    finally
      OutputStream.Free;
    end;
  finally
    InputStream.Free;
  end;
end;

function OLString.EndsStr(ASubString: OLString): OLBoolean;
begin
  Result := StrUtils.EndsStr(ASubString, Self);
end;

function OLString.EndsText(ASubString: OLString): OLBoolean;
begin
  Result := StrUtils.EndsText(ASubString, Self);
end;

class operator OLString.Equal(a, b: OLString): OLBoolean;
begin
  Result := ((a.Value = b.Value) and (a.HasValue and b.HasValue)) or (a.IsNull() and b.IsNull());
end;

function OLString.TrailingCharExcluded(c: Char): OLString;
var
  OutPut: OLString;
begin
  if Self.RightStr(1) = c then
    OutPut := Self.EndingRemoved(1)
  else
    OutPut := Self;

  Result := OutPut;
end;

function OLString.TrailingComaExcluded: OLString;
begin
  Result := Self.TrailingCharExcluded(',');
end;

function OLString.TrailingPathDelimiterExcluded: OLString;
begin
  Result := SysUtils.ExcludeTrailingPathDelimiter(Self);
end;

function OLString.ExtractedFileDir: OLString;
begin
  Result := SysUtils.ExtractFileDir(Self);
end;

function OLString.ExtractedFileDriveString: OLString;
begin
  Result := SysUtils.ExtractFileDrive(Self);
end;

function OLString.ExtractedFileExt: OLString;
begin
  Result := SysUtils.ExtractFileExt(Self);
end;

function OLString.ExtractedFileName: OLString;
begin
  Result := SysUtils.ExtractFileName(Self);
end;

function OLString.ExtractedFilePath: OLString;
begin
  Result := SysUtils.ExtractFilePath(Self);
end;

function OLString.FindPattern(InFront, Behind: OLString; StartingPosition: integer; CaseSensitivity: TCaseSensitivity): TStringPatternFind;
var
  OutPut: TStringPatternFind;
  start, stop: integer;
begin
  if CaseSensitivity = csCaseInsensitive then
  begin
    start := Self.UpperCase().PosEx(InFront.UpperCase(), StartingPosition) + InFront.Length();
    stop := Self.UpperCase().PosEx(Behind.UpperCase(), start);
  end
  else
  begin
    start := Self.PosEx(InFront, StartingPosition) + InFront.Length();
    stop := Self.PosEx(Behind, start);
  end;

  OutPut.Value := Self.MidStr(start, stop - start);
  OutPut.Position := start;

  Result := OutPut;
end;

function OLString.FindPattern(Tag: OLString; StartingPosition: integer; CaseSensitivity: TCaseSensitivity): TStringPatternFind;
var
  NewStartingPosition: integer;
  TagStart: OLString;
begin
  TagStart := '<' + Tag;

  if CaseSensitivity = csCaseInsensitive then
  begin
    NewStartingPosition := Self.UpperCase().PosEx(TagStart.UpperCase(), StartingPosition) + TagStart.Length();
  end
  else
  begin
    NewStartingPosition := Self.PosEx(TagStart, StartingPosition) + TagStart.Length();
  end;

  Result := Self.FindPattern('>', '</' + Tag, NewStartingPosition, CaseSensitivity);
end;

function OLString.Formated(const Data: array of const ): OLString;
var
  s: string;
begin
  s := Self;

  Result := SysUtils.Format(s, Data);
end;

function OLString.GetCharAtIndex(Index: integer): Char;
var
  OutPut: Char;
begin
  if not Self.HasValue then
    raise Exception.Create('Cannot get chars from null value.');

  if Self.Length < Index then
    raise Exception.Create('Index greater then string length.');

  Result := Self.Value[Index];
end;

//http://www.scalabium.com/faq/dct0080.htm
procedure OLString.GetFromUrl(URL: string);
var
  NetHandle: HINTERNET;
  UrlHandle: HINTERNET;
  Buffer: array[0..1024] of AnsiChar;
  BytesRead: dWord;
  TextFromUrl: string;
begin
  TextFromUrl := '';
  NetHandle := InternetOpen('OLString', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);

  if Assigned(NetHandle) then
  begin
    UrlHandle := InternetOpenUrl(NetHandle, PChar(URL), nil, 0, INTERNET_FLAG_RELOAD, 0);

    if Assigned(UrlHandle) then
      { UrlHandle valid? Proceed with download }
    begin
      FillChar(Buffer, SizeOf(Buffer), 0);
      repeat
        TextFromUrl := TextFromUrl + Buffer;
        FillChar(Buffer, SizeOf(Buffer), 0);
        InternetReadFile(UrlHandle, @Buffer, SizeOf(Buffer), BytesRead);
      until BytesRead = 0;
      InternetCloseHandle(UrlHandle);
    end
    else
      { UrlHandle is not valid. Raise an exception. }
      raise Exception.CreateFmt('Cannot open URL %s', [URL]);

    InternetCloseHandle(NetHandle);
  end
  else
    { NetHandle is not valid. Raise an exception }
    raise Exception.Create('Unable to initialize Wininet');

  Self := TextFromUrl;
end;

function OLString.GetHasValue: OLBoolean;
begin
  Result := (NullFlag <> EmptyStr) or (DefaultValueFlag = EmptyStr);
end;

function OLString.GetLine(Index: integer): OLString;
var
  sl: TStringList;
  OutPut: OLString;
begin
  sl := TStringList.Create();
  try
    sl.Text := Self;
    OutPut := sl[Index];
  finally
    sl.Free();
  end;

  Result := OutPut;
end;

function OLString.GetLineStartPosition(Index: integer): OLInteger;
var
  OutPut: integer;
  LineBreak: OLString;
begin
  LineBreak := sLineBreak;

  if Index = 0 then
    OutPut := 1
  else
    OutPut := OccurrencesPosition(sLineBreak, Index) + LineBreak.Length();

  Result := OutPut;
end;

function OLString.GetValue: string;
begin
  Result := Self.Val;
end;

function OLString.FindPatternStr(InFront, Behind: OLString; StartingPosition: integer; CaseSensitivity: TCaseSensitivity): OLString;
begin
  Result := Self.FindPattern(InFront, Behind, StartingPosition, CaseSensitivity).Value;
end;

class operator OLString.GreaterThan(a, b: OLString): OLBoolean;
begin
  Result := (a.Value > b.Value) and a.HasValue and b.HasValue;
end;

class operator OLString.GreaterThanOrEqual(a, b: OLString): OLBoolean;
begin
  Result := ((a.Value >= b.Value) and (a.HasValue and b.HasValue)) or (a.IsNull() and b.IsNull());
end;

function OLString.Hash(Salt: string = ''): Cardinal;
 var
   s: string;
   i:integer;
   OutPut: Cardinal;
begin
  OutPut:=0;
  s := Self + Salt;

  for i:=1 to System.length(s) do
    OutPut := 506899 * OutPut xor byte(s[i]);

  Result := OutPut;
end;

function OLString.HashStr(Salt: string = ''): OLString;
begin
  Result := IntToHex(Self.Hash(Salt), 4);
end;

class operator OLString.Implicit(a: string): OLString;
var
  OutPut: OLString;
begin
  OutPut.Value := a;
  OutPut.HasValue := True;

  Result := OutPut;
end;

class operator OLString.Implicit(a: OLString): string;
var
  OutPut: string;
begin
  if not a.HasValue then
    raise Exception.Create('Null cannot be used as string value');
  OutPut := a.Value;
  Result := OutPut;
end;

function OLString.IfNull(i: OLString): OLString;
var
  OutPut: OLString;
begin
  if not HasValue then
    OutPut := i
  else
    OutPut := Self.Value;

  Result := OutPut;
end;

class operator OLString.Implicit(a: Variant): OLString;
var
  OutPut: OLString;
  s: string;
begin
  if VarIsNull(a) then
  begin
    OutPut.Value := '';
    OutPut.HasValue := False
  end
  else
  begin
    OutPut.Value := VarToStr(a);
    OutPut.HasValue := True;
  end;

  Result := OutPut;
end;

function OLString.TrailingCharIncluded(c: Char): OLString;
var
  OutPut: OLString;
begin
  if Self.RightStr(1) = c then
    OutPut := Self
  else
    OutPut := Self + c;

  Result := OutPut;
end;

function OLString.TrailingComaIncluded: OLString;
begin
  Result := Self.TrailingCharIncluded(',');
end;

function OLString.TrailingPathDelimiterIncluded: OLString;
begin
  Result := SysUtils.IncludeTrailingPathDelimiter(Self);
end;

function OLString.IndexStr(const AValues: array of string): OLInteger;
begin
  if not Self.HasValue then
    raise Exception.Create('Cannot determine index of null value.');

  Result := StrUtils.IndexStr(Self.Value, AValues);
end;

function OLString.IndexText(const AValues: array of string): OLInteger;
begin
  if not Self.HasValue then
    raise Exception.Create('Cannot determine index of null value.');

  Result := StrUtils.IndexText(Self.Value, AValues);
end;

function OLString.InitCaps: OLString;
var
  i: integer;
  OutPut: OLString;
begin
  OutPut := Self;

  OutPut[1] := UpCase(OutPut[1]);

  for i := 2 to OutPut.Length do
  begin
    if OutPut[i - 1] = ' ' then
      OutPut[i] := UpCase(OutPut[i])
    else
      OutPut[i] := SysUtils.LowerCase(OutPut[i])[1];
  end;

  Result := OutPut;
end;

function OLString.Inserted(const InsertStr: string; Position: integer): OLString;
var
  s: string;
begin
  s := Self;
  System.Insert(InsertStr, s, Position);
  Result := s;
end;

function OLString.IsEmptyStr: OLBoolean;
var
  OutPut: OLBoolean;
begin
  if Self.IsNull then
    OutPut := Null
  else
    OutPut := (Self = EmptyStr);

  Result := OutPut;
end;

function OLString.IsNull: OLBoolean;
begin
  Result := not HasValue;
end;

function OLString.LastDelimiterPosition(const Delimiters: string): OLInteger;
begin
  Result := SysUtils.LastDelimiter(Delimiters, Self);
end;

function OLString.LeftStr(const ACount: integer): OLString;
begin
  Result := StrUtils.LeftStr(Self, ACount);
end;

function OLString.Length: OLInteger;
var
  OutPut: OLInteger;
begin
  if Self.HasValue then
    OutPut := System.Length(Self.Value)
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLString.LessThan(a, b: OLString): OLBoolean;
begin
  Result := (a.Value < b.Value) and a.HasValue and b.HasValue;
end;

class operator OLString.LessThanOrEqual(a, b: OLString): OLBoolean;
begin
  Result := ((a.Value <= b.Value) and (a.HasValue and b.HasValue)) or (a.IsNull() and b.IsNull());
end;

procedure OLString.LineAdd(NewLine: string);
var
  sl: TStringList;
begin
  sl := TStringList.Create();
  try
    sl.Text := Self;

    //When adding line to empty string do not add second line
    //unless developer want to add empty line
    if (sl.Text = EmptyStr) then
    begin
      if (NewLine <> EmptyStr) then
        sl.Text := NewLine
      else
        sl.Text := sl.Text + sLineBreak;
    end
    else
      sl.Add(NewLine);
    Self := sl.Text;
  finally
    sl.Free();
  end;
end;

function OLString.LineCount: OLInteger;
var
  OutPut: OLInteger;
  LineBreak: OLString;
begin
  if Self.IsNull then
    OutPut := Null
  else
  begin
    LineBreak := sLineBreak;

    OutPut := Self.OccurrencesCount(sLineBreak);

    if Self.RightStr(LineBreak.Length) <> sLineBreak then
      inc(OutPut);
  end;

  Result := OutPut;
end;

procedure OLString.LineDelete(LineIndex: integer);
var
  sl: TStringList;
begin
  sl := TStringList.Create();
  try
    sl.Text := Self;
    sl.Delete(LineIndex);
    Self := sl.Text;
  finally
    sl.Free();
  end;
end;

function OLString.LineIndexOf(s: string): OLInteger;
var
  sl: TStringList;
  OutPut: integer;
begin
  sl := TStringList.Create();
  try
    sl.Text := Self;
    OutPut := sl.IndexOf(s);
  finally
    sl.Free();
  end;

  Result := OutPut;
end;

procedure OLString.LineInsertAt(LineIndex: integer; s: string);
var
  sl: TStringList;
begin
  sl := TStringList.Create();
  try
    sl.Text := Self;
    sl.Insert(LineIndex, s);
    Self := sl.Text;
  finally
    sl.Free();
  end;
end;

procedure OLString.LoadFromFile(FileName: string);
var
  sl: TStringList;
begin
  sl := TStringList.Create();
  try
    sl.LoadFromFile(FileName);
    Self := sl.Text;
  finally
    sl.Free();
  end;
end;

function OLString.LowerCase: OLString;
begin
  Result := SysUtils.AnsiLowerCase(Self)
end;

function OLString.MatchStr(const AValues: array of string): OLBoolean;
begin
  Result := Self.IndexStr(AValues) > 0;
end;

function OLString.MatchText(const AValues: array of string): OLBoolean;
begin
  Result := Self.IndexText(AValues) > 0;
end;

function OLString.MidStr(const AStart, ACount: integer): OLString;
begin
  Result := StrUtils.MidStr(Self, AStart, ACount);
end;

class operator OLString.NotEqual(a, b: OLString): OLBoolean;
begin
  Result := ((a.Value <> b.Value) and a.HasValue and b.HasValue) or (a.HasValue <> b.HasValue);
end;

procedure OLString.PasteFromClipboard;
begin
  Self := Clipboard.AsText;
end;

function OLString.PixelWidth(F: TFont): OLInteger;
var
  bmp: TBitmap;
begin
  bmp := TBitmap.Create;
  try
    bmp.Canvas.Font := F;
    Result := bmp.Canvas.TextWidth(Self);
  finally
    FreeAndNil(bmp);
  end;
end;

function OLString.Pos(SubStr: string; CaseSensitivity: TCaseSensitivity): OLInteger;
var
  OutPut: OLInteger;
begin
  if CaseSensitivity = csCaseSensitive then
    OutPut := System.Pos(SubStr, Self)
  else
  begin
    SubStr := SysUtils.UpperCase(SubStr);
    OutPut := System.Pos(SubStr, Self.UpperCase())
  end;

  Result := OutPut;
end;

function OLString.PosEx(SubStr: string; Offset: integer; CaseSensitivity: TCaseSensitivity): OLInteger;
var
  OutPut: OLInteger;
begin
  if CaseSensitivity = csCaseSensitive then
    OutPut := StrUtils.PosEx(SubStr, Self, Offset)
  else
  begin
    SubStr := SysUtils.UpperCase(SubStr);
    OutPut := StrUtils.PosEx(SubStr, Self.UpperCase(), Offset)
  end;

  Result := OutPut;
end;

function OLString.QuotedStr: OLString;
begin
  Result := SysUtils.QuotedStr(Self);
end;

class function OLString.RandomFrom(const AValues: array of string): OLString;
begin
  Result := StrUtils.RandomFrom(AValues);
end;

function OLString.EndingRemoved(const ACount: integer): OLString;
begin
  Result := Self.LeftStr(Self.Length() - ACount);
end;

function OLString.ReplacedFirst(const AFromText, AToText: string): OLString;
begin
  Result := SysUtils.StringReplace(Self, AFromText, AToText, []);
end;

function OLString.ReplacedFirstText(const AFromText, AToText: string): OLString;
begin
  Result := SysUtils.StringReplace(Self, AFromText, AToText, [rfIgnoreCase]);
end;

function OLString.ReplacedStartingAt(Position: Cardinal; const NewValue: OLString): OLString;
begin
  Result := StrUtils.StuffString(Self, Position, NewValue.Length, NewValue);
end;

function OLString.Replaced(const AFromText, AToText: string): OLString;
begin
  Result := StrUtils.ReplaceStr(Self, AFromText, AToText);
end;

function OLString.ReplacedText(const AFromText, AToText: string): OLString;
begin
  Result := StrUtils.ReplaceText(Self, AFromText, AToText);
end;

function OLString.ReversedString(): OLString;
begin
  Result := StrUtils.ReverseString(Self);
end;

function OLString.RightStr(const ACount: integer): OLString;
begin
  Result := StrUtils.RightStr(Self, ACount);
end;

function OLString.RightStrFrom(StartFrom: integer): OLString;
begin
  Result := Self.RightStr(Self.Length() - StartFrom + 1);
end;

function OLString.SameStr(s: OLString): OLBoolean;
begin
  Result := SysUtils.SameStr(Self, s);
end;

function OLString.SameText(s: OLString): OLBoolean;
begin
  Result := SysUtils.SameText(Self, s);
end;

procedure OLString.SaveToFile(FileName: string);
var
  sl: TStringList;
begin
  sl := TStringList.Create();
  try
    sl.Text := Self;
    sl.SaveToFile(FileName);
  finally
    sl.Free();
  end;
end;

procedure OLString.SetCharAtIndex(Index: integer; Value: Char);
begin
  if not Self.HasValue then
    raise Exception.Create('Cannot set chars in null value.');

  if Self.Length < Index then
    raise Exception.Create('Index greater then string length.');

  Self.Val[Index] := Value;
end;

procedure OLString.SetHasValue(Value: OLBoolean);
begin
  if Value then
    NullFlag := NonEmptyStr
  else
    NullFlag := EmptyStr;
end;

procedure OLString.SetLine(Index: integer; const Value: OLString);
var
  sl: TStringList;
begin
  sl := TStringList.Create();
  try
    sl.Text := Self;
    sl[Index] := Value;
    Self := sl.Text;
  finally
    sl.Free();
  end;
end;

procedure OLString.SetValue(const Value: string);
begin
  Self.Val := Value;
  Self.TurnDefaultValueFlagOff();
end;

function OLString.SpacesRemoved: OLString;
begin
  Result := Self.Replaced(' ', '');
end;

function OLString.SplitString(const Delimiters: string): TStringDynArray;
begin
  Result := StrUtils.SplitString(Self, Delimiters)
end;

function OLString.StartsStr(const ASubString: string): OLBoolean;
begin
  Result := StrUtils.StartsStr(ASubString, Self);
end;

function OLString.StartsText(const ASubText: string): OLBoolean;
begin
  Result := StrUtils.StartsText(ASubText, Self);
end;

function OLString.ToCurr: OLCurrency;
begin
  Result := StrToCurr(Self);
end;

function OLString.ToDate: OLDate;
begin
  Result := StrToDate(Self);
end;

function OLString.ToDateTime: OLDateTime;
begin
  Result := StrToDateTime(Self);
end;

function OLString.ToFloat: OLDouble;
begin
  Result := StrToFloat(Self);
end;

function OLString.ToInt: OLInteger;
begin
  Result := StrToInt(Self);
end;

function OLString.ToInt64: Int64;
begin
  Result := StrToInt64(Self);
end;

function OLString.ToString: string;
begin
  Result := Self.IfNull('');
end;

function OLString.TryToCurr: OLBoolean;
var
  c: Currency;
begin
  Result := SysUtils.TryStrToCurr(Self, c);
end;

function OLString.Trimed: OLString;
begin
  Result := SysUtils.Trim(Self);
end;

function OLString.TrimedLeft: OLString;
begin
  Result := SysUtils.TrimLeft(Self);
end;

function OLString.TrimedRight: OLString;
begin
  Result := SysUtils.TrimRight(Self);
end;

function OLString.TryToCurr(var c: Currency): OLBoolean;
begin
  Result := SysUtils.TryStrToCurr(Self, c);
end;

function OLString.TryToDate(var d: TDate): OLBoolean;
var
  dt: TDateTime;
  OutPut: OLBoolean;
begin
  if SysUtils.TryStrToDate(Self, dt) then
  begin
    d := Trunc(dt);
    OutPut := True;
  end
  else
    OutPut := False;

  Result := OutPut;
end;

function OLString.TryToDate: OLBoolean;
var
  d: TDateTime;
begin
  Result := SysUtils.TryStrToDate(Self, d);
end;

function OLString.TryToDateTime: OLBoolean;
var
  dt: TDateTime;
begin
  Result := SysUtils.TryStrToDateTime(Self, dt);
end;

function OLString.TryToDate(var d: OLDate): OLBoolean;
var
  dat: TDate;
  OutPut: OLBoolean;
begin
  OutPut := Self.TryToDate(dat);
  if OutPut then
    d := dat;

  Result := OutPut;
end;

function OLString.TryToDateTime(var dt: OLDateTime): OLBoolean;
var
 dattim: TDateTime;
 OutPut: OLBoolean;
begin
  OutPut := TryToDateTime(dattim);
  if OutPut then
    dt := dattim;

  Result := OutPut;
end;

function OLString.TryToFloat(var e: Double): OLBoolean;
var
  ext: Extended;
  OutPut: OLBoolean;
begin
  OutPut := TryToFloat(ext);
  if OutPut then
    e := ext;

  Result := OutPut;
end;

function OLString.TryToFloat(var e: OLDouble): OLBoolean;
var
  ext: Extended;
  OutPut: OLBoolean;
begin
  OutPut := TryToFloat(ext);
  if OutPut then
    e := ext;

  Result := OutPut;
end;

function OLString.TryToDateTime(var dt: TDateTime): OLBoolean;
begin
  Result := SysUtils.TryStrToDateTime(Self, dt);
end;

function OLString.TryToFloat(var e: Extended): OLBoolean;
begin
  Result := SysUtils.TryStrToFloat(Self, e);
end;

function OLString.TryToFloat: OLBoolean;
var
  e: Extended;
begin
  Result := SysUtils.TryStrToFloat(Self, e);
end;

function OLString.TryToInt(var i: integer): OLBoolean;
begin
  Result := SysUtils.TryStrToInt(Self, i);
end;

function OLString.TryToInt: OLBoolean;
var
  i: integer;
begin
  Result := SysUtils.TryStrToInt(Self, i);
end;

function OLString.TryToInt(var i: OLInteger): OLBoolean;
var
  OutPut: OLBoolean;
  int: Integer;
begin
  OutPut := TryToInt(int);
  if OutPut then
    i := int;

  Result := OutPut;
end;

function OLString.TryToInt64(var i: Int64): OLBoolean;
begin
  Result := SysUtils.TryStrToInt64(Self, i);
end;

procedure OLString.TurnDefaultValueFlagOff;
begin
  Self.DefaultValueFlag := NonEmptyStr;
end;

function OLString.TryToInt64: OLBoolean;
var
  i: Int64;
begin
  Result := SysUtils.TryStrToInt64(Self, i);
end;

function OLString.UpperCase: OLString;
begin
  Result := SysUtils.AnsiUpperCase(Self)
end;

function OLString.LeadingCharsAdded(C: Char; NewLength: integer): OLString;
var
  OutPut: OLString;
begin
  OutPut := Self;

  while OutPut.Length < NewLength do
    OutPut := C + OutPut;

  Result := OutPut;
end;

function OLString.LeadingSpacesAdded(NewLength: integer): OLString;
begin
  Result := Self.LeadingCharsAdded(' ', NewLength);
end;

function OLString.LeadingZerosAdded(NewLength: integer): OLString;
begin
  Result := Self.LeadingCharsAdded('0', NewLength)
end;

function OLString.TrailingCharsAdded(C: Char; NewLength: integer): OLString;
var
  OutPut: OLString;
begin
  OutPut := Self;

  while OutPut.Length < NewLength do
    OutPut := OutPut + C;

  Result := OutPut;
end;

function OLString.TrailingSpacesAdded(NewLength: integer): OLString;
begin
  Result := Self.TrailingCharsAdded(' ', NewLength);
end;

procedure OLString.AlfaSmartToDate(s: string; var d: TDate;
  var OutPut: OLBoolean);
var
  dat: OLDate;
begin
  AlfaSmartToDate(s, dat, OutPut);
  if OutPut then
    d := dat;
end;

//http://www.yanniel.info/2011/01/string-compress-decompress-delphi-zlib.html
function OLString.Compressed: string;
var
  strInput,
  strOutput: TStringStream;
  Zipper: TZCompressionStream;

  OutPut: string;
begin
  OutPut:= '';
  strInput:= TStringStream.Create(Self);
  strOutput:= TStringStream.Create;
  try
    Zipper:= TZCompressionStream.Create(strOutput, zcMax);
    try
      Zipper.CopyFrom(strInput, strInput.Size);
    finally
      Zipper.Free;
    end;
    OutPut:= strOutput.DataString;
  finally
    strInput.Free;
    strOutput.Free;
  end;

  Result := OutPut;
end;

function OLString.ContainsStr(ASubString: OLString): OLBoolean;
begin
  Result := StrUtils.ContainsStr(Self, ASubString);
end;

function OLString.ContainsText(ASubText: OLString): OLBoolean;
begin
  Result := StrUtils.ContainsText(Self, ASubText);
end;

procedure OLString.CopyToClipboard;
begin
  Clipboard.AsText := Self;
end;

function OLString.OccurrencesCount(SubString: string; CaseSensitivity: TCaseSensitivity): OLInteger;
var
  Position, OutPut: integer;
begin
  OutPut := 0;

  if not Self.IsNull then
  begin
    Position := Self.Pos(SubString, CaseSensitivity);

    while Position > 0 do
    begin
      inc(OutPut);
      Position := Self.PosEx(SubString, Position + 1, CaseSensitivity);
    end;
  end;

  Result := OutPut;
end;

function OLString.OccurrencesPosition(SubString: string; Index: integer; CaseSensitivity: TCaseSensitivity): OLInteger;
var
  Position, Counter, OutPut: integer;
begin
  OutPut := 0;
  Counter := 0;
  Position := Self.Pos(SubString, CaseSensitivity);

  while Position > 0 do
  begin
    inc(Counter);

    if (Counter = Index) then
    begin
      OutPut := Position;
      break;
    end;

    Position := Self.PosEx(SubString, Position + 1, CaseSensitivity);
  end;

  Result := OutPut;
end;

function OLString.CSVFieldCount(Delimiter: Char): OLInteger;
var
  sl: TStringList;
  wynik: OLInteger;
begin
  sl := TStringList.Create();
  try
    sl.Delimiter := Delimiter;
    sl.StrictDelimiter := True;
    sl.DelimitedText := Self.Value;

    wynik := sl.Count;
  finally
    sl.Free;
  end;

  Result := wynik;
end;

function OLString.CSVFieldValue(FieldIndex: integer; Delimiter: Char): OLString;
var
  sl: TStringList;
  wynik: string;
begin
  sl := TStringList.Create();
  try
    sl.Delimiter := Delimiter;
    sl.StrictDelimiter := True;
    sl.DelimitedText := Self.Value;
    if sl.Count > FieldIndex then
      wynik := sl[FieldIndex];
  finally
    sl.Free;
  end;

  Result := wynik;
end;


//http://stackoverflow.com/questions/32306960/delphi-7-and-decode-utf-8-base64

procedure OLString.DecodeBase64ToFile(FileName: string);
var
  InputStream: TStringStream;
  OutputStream: TFileStream;
begin
  InputStream := TStringStream.Create(Self);
  try
    OutputStream := TFileStream.Create(FileName, fmCreate);
    try
      DecodeStream(InputStream, OutputStream);
    finally
      OutputStream.Free;
    end;
  finally
    InputStream.Free;
  end;
end;

//http://www.yanniel.info/2011/01/string-compress-decompress-delphi-zlib.html
function OLString.Decompressed: string;
var
  strInput,
  strOutput: TStringStream;
  Unzipper: TZDecompressionStream;

  OutPut: string;
begin
  OutPut:= '';
  strInput := TStringStream.Create(Self);
  strOutput := TStringStream.Create;
  try
    Unzipper := TZDecompressionStream.Create(strInput);

    try
      strOutput.CopyFrom(Unzipper, Unzipper.Size);
    finally
      Unzipper.Free;
    end;

    OutPut := strOutput.DataString;
  finally
    strInput.Free;
    strOutput.Free;
  end;

  Result := OutPut;
end;

function OLString.Deleted(FromPosition, Count: integer): OLString;
var
  s: String;
begin
  s := Self;

  System.Delete(s, FromPosition, Count);

  Result := s;
end;

function OLString.DigitsOnly: OLString;
const
  Digits = ['0'..'9'];
var
  OutPut: OLString;
  i: integer;
begin
  OutPut := '';

  for i := 1 to Self.Length() do
  begin
    if Self[i] in Digits then
      OutPut := OutPut + Self[i];
  end;

  Result := OutPut;
end;

procedure OLString.DigitsSmartToDate(Digits: OLString; var OutPut: OLBoolean;
  var d: OLDate);
var
  dat: TDate;
begin
  DigitsSmartToDate(Digits, OutPut, dat);
  if OutPut then
    d := dat;
end;

function OLString.RepeatedString(ACount: integer): OLString;
var
  OutPut: OLString;
  i: integer;
begin
  OutPut := '';

  for i := 1 to ACount do
  begin
    OutPut := OutPut + Self;
  end;

  Result := OutPut;
end;

function OLString.FindPatternStr(Tag: OLString; StartingPosition: integer = 1; CaseSensitivity: TCaseSensitivity = csCaseInsensitive): OLString;
begin
  Result := Self.FindPattern(Tag, StartingPosition, CaseSensitivity).Value;
end;


function OLString.IBANChangeAlpha(input: string): string;
  // A -> 10, B -> 11, C -> 12 ...
var
  a: Char;
begin
  Result := input;
  for a := 'A' to 'Z' do
  begin
    Result := StringReplace(Result, a, IntToStr(Ord(a) - 55), [rfReplaceAll]);
  end;
end;

function OLString.IBANCalculateDigits(iban: OLString): OLInteger;
var
  v, l: Integer;
  alpha: OLString;
  number: Longint;
  rest: Integer;
begin
  iban := iban.Replaced(' ', '').UpperCase();
  if iban.Pos('IBAN') > 0 then
    iban.Deleted(iban.Pos('IBAN'), 4);
  iban := iban + iban.MidStr(1, 4);
  iban := iban.Deleted(1, 4);
  iban := IBANChangeAlpha(iban);
  v := 1;
  l := 9;
  rest := 0;
  alpha := '';
  try
    while v <= iban.Length() do
    begin
      if l > iban.Length() then
        l := iban.Length();
      alpha := alpha + iban.MidStr(v, l);
      number := alpha.ToInt();
      rest := number mod 97;
      v := v + l;
      alpha := IntToStr(rest);
      l := 9 - alpha.Length();
    end;
  except
    rest := 0;
  end;
  Result := rest;
end;


function OLString.IsValidIBAN(): OLBoolean;
begin
  Result := (IBANCalculateDigits(Self) = 1);
end;

procedure OLString.AlfaSmartToDate(s: string; var d: OLDate; var OutPut: OLBoolean);
begin
  if (s = 't') or (s = 'td') then
  begin
    d := Date;
    OutPut := true;
  end;
  if (s = 'y') or (s = 'yd') then
  begin
    d := IncDay(Date, -1);
    OutPut := true;
  end;
  if s = 'tm' then
  begin
    d := IncDay(Date, 1);
    OutPut := true;
  end;
  if s = 'ey' then
  begin
    d := EndOfTheYear(Date);
    OutPut := true;
  end;
  if s = 'em' then
  begin
    d := EndOfTheMonth(Date);
    OutPut := true;
  end;
  if s = 'by' then
  begin
    d := StartOfTheYear(Date);
    OutPut := true;
  end;
  if s = 'bm' then
  begin
    d := StartOfTheMonth(Date);
    OutPut := true;
  end;
  if s = 'eny' then
  begin
    d := EndOfTheYear(IncYear(Date, 1));
    OutPut := true;
  end;
  if s = 'enm' then
  begin
    d := EndOfTheMonth(IncMonth(Date, 1));
    OutPut := true;
  end;
  if s = 'bny' then
  begin
    d := StartOfTheYear(IncYear(Date, 1));
    OutPut := true;
  end;
  if s = 'bnm' then
  begin
    d := StartOfTheMonth(IncMonth(Date, 1));
    OutPut := true;
  end;
  if s = 'epy' then
  begin
    d := EndOfTheYear(IncYear(Date, -1));
    OutPut := true;
  end;
  if s = 'epm' then
  begin
    d := EndOfTheMonth(IncMonth(Date, -1));
    OutPut := true;
  end;
  if s = 'bpy' then
  begin
    d := StartOfTheYear(IncYear(Date, -1));
    OutPut := true;
  end;
  if s = 'bpm' then
  begin
    d := StartOfTheMonth(IncMonth(Date, -1));
    OutPut := true;
  end;
end;

procedure OLString.DigitsSmartToDate(Digits: OLString; var OutPut: OLBoolean; var d: TDate);
var
  YearStr: OLString;
  DayStr: OLString;
  MonthStr: OLString;
  day: Word;
  y: Word;
  m: Word;
  dt: TDateTime;
begin
  DecodeDate(Date, y, m, day);
  DayStr := Digits.RightStr(2);
  if Digits.Length() > 2 then
  begin
    MonthStr := Digits.MidStr(Digits.Length() - 3, Min(2, Digits.Length() - 2));
  end
  else
    MonthStr := IntToStr(m);
  if Digits.Length() > 4 then
  begin
    YearStr := Digits.MidStr(Digits.Length() - 7, Min(4, Digits.Length() - 4));
    if YearStr.Length() = 3 then
      YearStr := '2' + YearStr;
    if YearStr.Length() = 2 then
      YearStr := '20' + YearStr;
    if YearStr.Length() = 1 then
      YearStr := '200' + YearStr;
  end
  else
    YearStr := IntToStr(y);
  OutPut := TryEncodeDate(YearStr.ToInt(), MonthStr.ToInt(), DayStr.ToInt(), dt);
  if OutPut then
    d := dt;
end;

//ISO 8601
function OLString.TrySmartStrToDate(var d: TDate): OLBoolean;
var
  OutPut: OLBoolean;
  Digits: string;
  dt: TDateTime;
begin
  OutPut := TryStrToDate(Self, dt);

  if OutPut then
  begin
    d := dt;
  end
  else
  begin
    Digits := Self.DigitsOnly();

    if Digits <> EmptyStr then
    begin
      DigitsSmartToDate(Digits, OutPut, d);
    end
    else
    begin
      AlfaSmartToDate(Self, d, OutPut);
    end;
  end;


  Result := OutPut;
end;

function OLString.SmartStrToDate(): OLDate;
var
  d: OLDate;
begin
  if not Self.TrySmartStrToDate(d) then
    raise Exception.Create(Self.QuotedStr +'cannot be decoded as date.');

  Result := d;
end;

class operator OLString.Implicit(a: OLString): Variant;
var
  OutPut: Variant;
begin
  if a.HasValue then
    OutPut := a.Value
  else
    OutPut := Null;

  Result := OutPut;
end;

function OLString.TrySmartStrToDate(var d: OLDate): OLBoolean;
var
  OutPut: OLBoolean;
  dat: TDate;
begin
  OutPut := TrySmartStrToDate(dat);
  if OutPut then
    d := dat;

  Result := OutPut;
end;

function OLString.TrySmartStrToDate: OLBoolean;
var
  OutPut: OLBoolean;
  dat: TDate;
begin
  OutPut := TrySmartStrToDate(dat);

  Result := OutPut;
end;

function OLString.TryToCurr(var c: OLCurrency): OLBoolean;
var
  OutPut: OLBoolean;
  cur: Currency;
begin
  OutPut := SysUtils.TryStrToCurr(Self, cur);

  c := cur;
  Result := OutPut;
end;

function OLString.TryToDate(var d: TDateTime): OLBoolean;
var
  dt: TDateTime;
  OutPut: OLBoolean;
begin
  if SysUtils.TryStrToDate(Self, dt) then
  begin
    d := Trunc(dt);
    OutPut := True;
  end
  else
    OutPut := False;

  Result := OutPut;
end;

end.
