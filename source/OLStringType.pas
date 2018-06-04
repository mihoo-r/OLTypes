unit OLStringType;

interface

uses
  variants, SysUtils, StrUtils, Types, Graphics, OLBooleanType, OLCurrencyType,
  OLDateTimeType, OLDateType, OLDoubleType, OLIntegerType, SmartToDate;

type
  TCaseSensitivity = (csCaseSensitive, csCaseInsensitive);
  TStringPatternFind = record
    Value: string;
    Position: integer;
  end;

  OLStringParamPair = record
    ParamName: string;
    ParamValue: string;
  end;

  OLString = record
  private
    Val: string;
    NullFlag: string;
    DefaultValueFlag: string;

    ValBeforeParams: string;
    Parameters: array of OLStringParamPair;

    function GetHasValue(): OLBoolean;
    procedure SetHasValue(const Value: OLBoolean);
    function GetLine(const Index: integer): OLString;
    procedure SetLine(const Index: integer; const Value: OLString);
    function IBANCalculateDigits(iban: OLString): OLInteger;
    function IBANChangeAlpha(const input: string): string;
    function GetValue: string;
    procedure SetValue(const Value: string);
    function GetCSV(const Index: integer): OLString;
    procedure SetCSV(const Index: integer; const Value: OLString);
    function ParamIndex(const ParamName: string): OLInteger;
    procedure AppendParam(const ParamName: string; const ParamValue: OLString);
    procedure UpdateParam(const ParamIndex: integer; const ParamValue: OLString);
    procedure ApplyParams;
    function GetParam(const ParamName: string): OLString;
    procedure SetParam(const ParamName: string; const Value: OLString);
    function GetHtmlUnicodeText: OLString;
    procedure SetHtmlUnicodeText(const Value: OLString);
    function GetBase64: OLString;
    procedure SetBase64(const Value: OLString);
    function GetUrlEncodedText: OLString;
    procedure SetUrlEncodedText(const Value: OLString);
    function Utf8Code(const c: Char): OLString;
    property ValuePresent: OLBoolean read GetHasValue write SetHasValue;

    function GetCharAtIndex(const Index: integer): Char;
    procedure SetCharAtIndex(const Index: integer; const Value: Char);
    procedure TurnDefaultValueFlagOff();
    property Value: string read GetValue write SetValue;
  public
    function IsNull(): OLBoolean;
    function HasValue(): OLBoolean;
    function IsEmptyStr(): OLBoolean;
    function IfNull(const s: OLString): OLString;
    function IfNullOrEmpty(const s: OLString): OLString;
    function IsNullOrEmpty(): OLBoolean;

    function GetLineStartPosition(const Index: integer): OLInteger;
    function GetLineEndPosition(const Index: integer): OLInteger;

    function CSVFieldValue(const FieldIndex: integer; const Delimiter: Char = ';'): OLString;
    function CSVFieldCount(const Delimiter: Char = ';'): OLInteger;
    procedure SetCSVFieldValue(const FieldIndex: integer; const Value: OLString; const Delimiter: Char = ';');
    function Length(): OLInteger;

    function ContainsStr(const ASubString: OLString): OLBoolean;
    function ContainsText(const ASubText: OLString): OLBoolean;
    function RepeatedString(const ACount: integer): OLString;

    function StartsStr(const ASubString: string): OLBoolean;
    function StartsText(const ASubText: string): OLBoolean;
    function EndsStr(const ASubString: OLString): OLBoolean;
    function EndsText(const ASubString: OLString): OLBoolean;

    function IndexStr(const AValues: array of string): OLInteger;
    function IndexText(const AValues: array of string): OLInteger;
    function MatchStr(const AValues: array of string): OLBoolean;
    function MatchText(const AValues: array of string): OLBoolean;

    function MidStr(const AStart, ACount: integer): OLString;
    function MidStrEx(const AStart, AEnd: integer): OLString;
    function FindPatternStr(const InFront: OLString; const Behind: OLString; const StartingPosition: integer = 1; const CaseSensitivity: TCaseSensitivity = csCaseSensitive) : OLString; overload;
    function FindPatternStr(const Tag: OLString; const StartingPosition: integer = 1; const CaseSensitivity: TCaseSensitivity = csCaseInsensitive): OLString; overload;
    function FindPattern(InFront: OLString; Behind: OLString; const
        StartingPosition: integer = 1; const CaseSensitivity: TCaseSensitivity =
        csCaseSensitive): TStringPatternFind; overload;
    function FindPattern(Tag: OLString; const StartingPosition: integer = 1; const
        CaseSensitivity: TCaseSensitivity = csCaseInsensitive): TStringPatternFind;
        overload;

    function Like(Pattern: OLString): OLBoolean;

    function Pos(const SubStr: string; const CaseSensitivity: TCaseSensitivity = csCaseSensitive): OLInteger;
    function PosEx(const SubStr: string; const Offset: integer; const CaseSensitivity: TCaseSensitivity = csCaseSensitive): OLInteger;
    function PosLast(const SubStr: string; const CaseSensitivity: TCaseSensitivity = csCaseSensitive): OLInteger;
    function PosLastEx(const SubStr: string; const NotAfterPosition: integer; const CaseSensitivity: TCaseSensitivity = csCaseSensitive): OLInteger;

    function Replaced(const AFromText, AToText: string): OLString;
    function ReplacedFirst(const AFromText, AToText: string): OLString;
    function ReplacedText(const AFromText, AToText: string): OLString;
    function ReplacedFirstText(const AFromText, AToText: string): OLString;
    function ReplacedStartingAt(const Position: Cardinal; const NewValue: OLString): OLString;

    function ReversedString(): OLString;

    function RightStr(const ACount: integer): OLString;
    function LeftStr(const ACount: integer): OLString;
    function EndingRemoved(const ACount: integer): OLString;
    function RightStrFrom(const StartFrom: integer): OLString;

    function SplitString(const Delimiters: string = ';'): TStringDynArray;

    function Inserted(const InsertStr: string; const Position: integer): OLString;
    function Deleted(const FromPosition: integer; const Count: integer = 1): OLString;

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

    function LeadingCharsAdded(const C: Char; const NewLength: integer): OLString;
    function TrailingCharsAdded(const C: Char; const NewLength: integer): OLString;
    function LeadingZerosAdded(const NewLength: integer): OLString;
    function LeadingSpacesAdded(const NewLength: integer): OLString;
    function TrailingSpacesAdded(const NewLength: integer): OLString;

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

    procedure EndcodeBase64FromFile(const FileName: string);
    procedure DecodeBase64ToFile(const FileName: string);

    function Compressed(): OLString;
    function Decompressed(): OLString;

    function TrailingPathDelimiterExcluded(): OLString;
    function TrailingPathDelimiterIncluded(): OLString;

    function TrailingCharExcluded(const c: Char): OLString;
    function TrailingCharIncluded(const c: Char): OLString;
    function TrailingComaExcluded(): OLString;
    function TrailingComaIncluded(): OLString;
    function TrailingApostropheExcluded(): OLString;
    function TrailingApostropheIncluded(): OLString;

    function LeadingCharExcluded(const c: Char): OLString;
    function LeadingCharIncluded(const c: Char): OLString;
    function LeadingComaExcluded(): OLString;
    function LeadingComaIncluded(): OLString;
    function LeadingApostropheExcluded(): OLString;
    function LeadingApostropheIncluded(): OLString;

    function PixelWidth(const F: TFont): OLInteger;

    function OccurrencesCount(const SubString: string; const CaseSensitivity: TCaseSensitivity = csCaseSensitive): OLInteger;
    function OccurrencesPosition(const SubString: string; const Index: integer; const CaseSensitivity: TCaseSensitivity = csCaseSensitive): OLInteger;

    function LineCount(): OLInteger;
    procedure LineAdd(const NewLine: string);
    procedure LineDelete(const LineIndex: integer);
    procedure LineInsertAt(const LineIndex: integer; const s: string);
    function LineIndexOf(const s: string): OLInteger;
    function LineIndexLike(const s: string; StartingFrom: Integer = 0): OLInteger;
    procedure LoadFromFile(const FileName: string);
    procedure SaveToFile(const FileName: string);
    function LineAdded(const NewLine: string): OLString;
    function LineEndAt(const LineIndex: Integer): OLInteger;

    procedure CopyToClipboard();
    procedure PasteFromClipboard();

    function Hash(const Salt: string = ''): cardinal;
    function HashStr(const Salt: string = ''): OLString;

    procedure GetFromUrl(const URL: string);

    function IsValidIBAN(): OLBoolean;

    function ToPWideChar(): PWideChar;


    class function RandomFrom(const AValues: array of string): OLString; static;

    class operator Add(const a, b: OLString): OLString;

    class operator Implicit(const a: string): OLString;
    class operator Implicit(const a: OLString): string;

    class operator Implicit(const a: Variant): OLString;
    class operator Implicit(const a: OLString): Variant;

    class operator Equal(const a, b: OLString): OLBoolean;
    class operator NotEqual(const a, b: OLString): OLBoolean;
    class operator GreaterThan(const a, b: OLString): OLBoolean;
    class operator GreaterThanOrEqual(const a, b: OLString): OLBoolean;
    class operator LessThan(const a, b: OLString): OLBoolean;
    class operator LessThanOrEqual(const a, b: OLString): OLBoolean;

    function CSVIndex(const ValueToFind: OLString): OLInteger;
    function CSVFieldByName(const FieldName: OLString; const RowIndex: Integer = 1): OLString;

    property Base64: OLString read GetBase64 write SetBase64;
    property Chars[const Index: integer]: Char read GetCharAtIndex write SetCharAtIndex; default;
    property Lines[const Index: integer]: OLString read GetLine write SetLine;
    property CSV[const Index: integer]: OLString read GetCSV write SetCSV;
    property Params[const ParamName: string]: OLString read GetParam write SetParam;

    property HtmlUnicodeText: OLString read GetHtmlUnicodeText write SetHtmlUnicodeText;
    property UrlEncodedText: OLString read GetUrlEncodedText write SetUrlEncodedText;
  end;

implementation

uses
  Classes, Clipbrd, WinInet, DateUtils, Math, EncdDecd,
  {$if CompilerVersion > 22.0 }
  System.ZLib;
  {$ELSE}
  Zlib;
  {$IFEND}


{ OLString }

const
  NonEmptyStr = ' ';
  DefaultValue = '';

type
  THtmlUnicodeTranslation = record
    UnicodeChar: Char;
    NumericalCode: string;
    LiteralCode: string;
  end;

  TUrlTranslation = record
    UnicodeChar: Char;
    Translation: string;
  end;

var
  HtmlUnicodeTranslation: array [0..315] of THtmlUnicodeTranslation;
  UrlTranslation: array[0..160] of TUrlTranslation;

class operator OLString.Add(const a, b: OLString): OLString;
var
  returnrec: OLString;
begin
  returnrec.Value := a.Value + b.Value;
  returnrec.ValuePresent := a.ValuePresent and b.ValuePresent;
  Result := returnrec;
end;

procedure OLString.EndcodeBase64FromFile(const FileName: string);
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

function OLString.EndsStr(const ASubString: OLString): OLBoolean;
begin
  Result := StrUtils.EndsStr(ASubString, Self);
end;

function OLString.EndsText(const ASubString: OLString): OLBoolean;
begin
  Result := StrUtils.EndsText(ASubString, Self);
end;

class operator OLString.Equal(const a, b: OLString): OLBoolean;
begin
  Result := ((a.Value = b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLString.TrailingApostropheExcluded: OLString;
begin
  Result := Self.TrailingCharExcluded('''');
end;

function OLString.TrailingApostropheIncluded: OLString;
begin
  Result := Self.TrailingCharIncluded('''');
end;

function OLString.TrailingCharExcluded(const c: Char): OLString;
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

function OLString.FindPattern(InFront: OLString; Behind: OLString;
    const StartingPosition: integer = 1; const CaseSensitivity:
    TCaseSensitivity = csCaseSensitive): TStringPatternFind;
var
  OutPut: TStringPatternFind;
  InFrontStart: integer;
  start, stop: integer;
  SearchIn: OLString;
begin
  if CaseSensitivity = csCaseInsensitive then
  begin
    SearchIn := Self.UpperCase();
    InFront := InFront.UpperCase();
    Behind := Behind.UpperCase();
  end
  else
    SearchIn := Self;

  InFrontStart := SearchIn.PosEx(InFront, StartingPosition);

  if InFrontStart > 0 then
  begin
    start := InFrontStart + InFront.Length();
    stop := SearchIn.PosEx(Behind, start);
  end
  else
  begin
    start := 0;
    stop := 0;
  end;

  OutPut.Value := Self.MidStr(start, stop - start);
  OutPut.Position := start;

  Result := OutPut;
end;

function OLString.FindPattern(Tag: OLString; const StartingPosition:
    integer = 1; const CaseSensitivity: TCaseSensitivity = csCaseInsensitive):
    TStringPatternFind;
var
  NewStartingPosition: integer;
  TagStart: OLString;
  SearchIn: OLString;
  TagStartPosition: OLInteger;
  OutPut: TStringPatternFind;
begin
  if CaseSensitivity = csCaseInsensitive then
  begin
    SearchIn := Self.UpperCase();
    Tag := Tag.UpperCase();
  end
  else
  begin
    SearchIn := Self;
  end;

  TagStart := '<' + Tag;

  TagStartPosition := SearchIn.PosEx(TagStart, StartingPosition);

  if TagStartPosition > 0 then
  begin
    NewStartingPosition := TagStartPosition + TagStart.Length();
    OutPut := Self.FindPattern('>', '</' + Tag, NewStartingPosition, CaseSensitivity);
  end
  else
  begin
    OutPut.Value := '';
    OutPut.Position := 0;
  end;

  Result := OutPut;
end;

function OLString.Formated(const Data: array of const ): OLString;
var
  s: string;
begin
  s := Self;

  Result := SysUtils.Format(s, Data);
end;

function OLString.GetBase64: OLString;
var
  OutPut: OLString;
begin
  if Self.IsNull() then
    OutPut := Null
  else
    OutPut := EncodeString(Self);

  Result := OutPut;
end;

function OLString.GetCharAtIndex(const Index: integer): Char;
begin
  if not Self.ValuePresent then
    raise Exception.Create('Cannot get chars from null value.');

  if Self.Length < Index then
    raise Exception.Create('Index greater then string length.');

  Result := Self.Value[Index];
end;

function OLString.GetCSV(const Index: integer): OLString;
begin
  Result := Self.CSVFieldValue(Index);
end;

//http://www.scalabium.com/faq/dct0080.htm
procedure OLString.GetFromUrl(const URL: string);
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

function OLString.GetHtmlUnicodeText: OLString;
var
  I: Integer;
  OutPut: OLString;
begin
  OutPut := Value;

  for I := 0 to System.Length(HtmlUnicodeTranslation) do
  begin
    if HtmlUnicodeTranslation[i].LiteralCode <> EmptyStr then
      OutPut := OutPut.Replaced(HtmlUnicodeTranslation[i].UnicodeChar, HtmlUnicodeTranslation[i].LiteralCode)
    else
      OutPut := OutPut.Replaced(HtmlUnicodeTranslation[i].UnicodeChar, HtmlUnicodeTranslation[i].NumericalCode);
  end;

  Result := OutPut;
end;

function OLString.GetLine(const Index: integer): OLString;
var
  sl: TStringList;
  OutPut: OLString;
begin
  sl := TStringList.Create();
  try
    if (Index = 0) and Self.IsEmptyStr() then
      OutPut := EmptyStr
    else
    begin
      sl.Text := Self;
      OutPut := sl[Index];
    end;
  finally
    sl.Free();
  end;

  Result := OutPut;
end;

function OLString.GetLineEndPosition(const Index: integer): OLInteger;
begin
  Result := Self.PosEx(sLineBreak, GetLineStartPosition(Index)).Increased(System.Length(sLineBreak) - 1).Replaced(System.Length(sLineBreak) - 1, 0);
end;

function OLString.GetLineStartPosition(const Index: integer): OLInteger;
var
  OutPut: integer;
  LineBreak: OLString;
begin
  LineBreak := sLineBreak;

  if Index = 0 then
    OutPut := 1
  else
    OutPut := OccurrencesPosition(sLineBreak, Index - 1) + LineBreak.Length();

  Result := OutPut;
end;

function OLString.GetParam(const ParamName: string): OLString;
var
  i: integer;
  OutPut: OLString;
begin
  OutPut := Null;

  for i := 0 to System.Length(Parameters) - 1 do
  begin
    if Parameters[i].ParamName = ParamName then
    begin
      OutPut := Parameters[i].ParamValue;
      Break;
    end;
  end;

  Result := OutPut;
end;

function OLString.Utf8Code(const c: Char): OLString;
var
  b: TBytes;
  es: RawByteString;
  OutPut: OLString;
  I: Integer;
begin
  es :=  UTF8Encode(c);

  b := BytesOf(es);

  for I := 0 to System.Length(b) - 1 do
   OutPut := OutPut + '%' + IntToHex(b[i],2);

  Result := OutPut;
end;

function OLString.GetUrlEncodedText: OLString;
var
  I: Integer;
  OutPut: string;
  c: Char;
begin
  for I := 1 to Self.Length do
  begin
    c := Self[i];
    if c in ['0'..'9', 'A'..'Z', 'a'..'z'] then
      OutPut := OutPut + c
    else
      OutPut := OutPut + Utf8Code(c);
  end;

  Result := OutPut;
end;

function OLString.GetValue: string;
begin
  Result := Self.Val;
end;

function OLString.FindPatternStr(const InFront: OLString; const Behind:
    OLString; const StartingPosition: integer = 1; const CaseSensitivity:
    TCaseSensitivity = csCaseSensitive): OLString;
begin
  Result := Self.FindPattern(InFront, Behind, StartingPosition, CaseSensitivity).Value;
end;

class operator OLString.GreaterThan(const a, b: OLString): OLBoolean;
begin
  Result := (a.Value > b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLString.GreaterThanOrEqual(const a, b: OLString): OLBoolean;
begin
  Result := ((a.Value >= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLString.Hash(const Salt: string = ''): cardinal;
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

function OLString.HashStr(const Salt: string = ''): OLString;
begin
  Result := IntToHex(Self.Hash(Salt), 4);
end;

function OLString.HasValue: OLBoolean;
begin
  Result := ValuePresent;
end;

class operator OLString.Implicit(const a: string): OLString;
var
  OutPut: OLString;
begin
  OutPut.Value := a;
  OutPut.ValuePresent := True;

  Result := OutPut;
end;

class operator OLString.Implicit(const a: OLString): string;
var
  OutPut: string;
begin
  if not a.ValuePresent then
    raise Exception.Create('Null cannot be used as string value');
  OutPut := a.Value;
  Result := OutPut;
end;

function OLString.IfNull(const s: OLString): OLString;
var
  OutPut: OLString;
begin
  if not ValuePresent then
    OutPut := s
  else
    OutPut := Self.Value;

  Result := OutPut;
end;

function OLString.IfNullOrEmpty(const s: OLString): OLString;
var
  OutPut: OLString;
begin
  if IsNullOrEmpty() then
    OutPut := s
  else
    OutPut := Self;

  Result := OutPut;
end;

class operator OLString.Implicit(const a: Variant): OLString;
var
  OutPut: OLString;
begin
  if VarIsNull(a) then
  begin
    OutPut.Value := '';
    OutPut.ValuePresent := False
  end
  else
  begin
    OutPut.Value := VarToStr(a);
    OutPut.ValuePresent := True;
  end;

  Result := OutPut;
end;

function OLString.TrailingCharIncluded(const c: Char): OLString;
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
  if not Self.ValuePresent then
    raise Exception.Create('Cannot determine index of null value.');

  Result := StrUtils.IndexStr(Self.Value, AValues);
end;

function OLString.IndexText(const AValues: array of string): OLInteger;
begin
  if not Self.ValuePresent then
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

function OLString.Inserted(const InsertStr: string; const Position: integer):
    OLString;
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
  Result := not ValuePresent;
end;

function OLString.IsNullOrEmpty: OLBoolean;
var
  OutPut: OLBoolean;
begin
  if Self.IsNull() then
    OutPut := True
  else if Self.IsEmptyStr() then
    OutPut := True
  else
    OutPut := False;

  Result := OutPut;
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
  if Self.ValuePresent then
    OutPut := System.Length(Self.Value)
  else
    OutPut := Null;

  Result := OutPut;
end;

class operator OLString.LessThan(const a, b: OLString): OLBoolean;
begin
  Result := (a.Value < b.Value) and a.ValuePresent and b.ValuePresent;
end;

class operator OLString.LessThanOrEqual(const a, b: OLString): OLBoolean;
begin
  Result := ((a.Value <= b.Value) and (a.ValuePresent and b.ValuePresent)) or (a.IsNull() and b.IsNull());
end;

function OLString.Like(Pattern: OLString): OLBoolean;
var
  I: Integer;
  s: OLString;
  Segment: OLString;
  OutPut: OLBoolean;
  p: OLInteger;
  SubSegment: OLString;
  j: Integer;
  SegmentMatch: Boolean;
  SegmentCount: OLInteger;
begin
  s := Self;

  OutPut := True;

  // '_%' = '%';
  while (Pattern.ContainsStr('_%')) do
    Pattern := Pattern.Replaced('_%', '%');

  // '_%' = '%'
  while (Pattern.ContainsStr('%_')) do
    Pattern := Pattern.Replaced('%_', '%');

  // '%%' = '%'
  while (Pattern.ContainsStr('%%')) do
    Pattern := Pattern.Replaced('%%', '%');

  if not Pattern.IsNullOrEmpty() then
  begin
    //Remove leading '_' from pattern, and equivalent from tested string
    while (Pattern[1] = '_') do
    begin
      Pattern := Pattern.Deleted(1,1);
      s := s.Deleted(1,1);

      if Pattern.IsEmptyStr() then
        break;
    end;
  end;

  SegmentCount := Pattern.CSVFieldCount('%');

  for I := 0 to SegmentCount - 1 do
  begin
    Segment := Pattern.CSVFieldValue(i, '%');
    if Segment <> '' then
    begin
      if Segment.ContainsStr('_') then
      begin
        Pattern := Pattern.Replaced(Segment, Segment.Replaced('_', ''));

        SubSegment := Segment.LeftStr(Segment.Pos('_').Decreased().Replaced(-1, Segment.Length));

        p := s.Pos(SubSegment);
        while p > 0 do
        begin
          SegmentMatch := True;

          if s.Length >= p + Segment.Length -1 then
          begin
            for j := 1 to Segment.Length do
            begin
               SegmentMatch := SegmentMatch and ((Segment[j] = s[p + j - 1]) or (Segment[j] = '_'));
            end;
          end
          else
            SegmentMatch := False;

          if SegmentMatch then
          begin
            for j := 1 to Segment.Length do
            begin
               if (Segment[j] = '_') then
                 s[p + j - 1] := '_';
            end;

            s := s.Replaced(Segment, Segment.Replaced('_', ''));
          end;


          p := s.PosEx(SubSegment, p + 1);
        end;
      end;
    end;
  end;

  if SegmentCount > 0 then
  begin
    p := 1;

    for I := 0 to SegmentCount - 1 do
    begin
      Segment := Pattern.CSVFieldValue(i, '%');

      if Segment <> '' then
      begin
        p := s.PosEx(Segment, p);

        OutPut := OutPut and (p > 0) and ((p = 1) or (i > 0)) and ((i <> SegmentCount - 1) or (p + Segment.Length - 1= s.Length));
      end;
    end;
  end
  else
    OutPut := False;

  Result := OutPut;
end;

procedure OLString.LineAdd(const NewLine: string);
var
  sl: TStringList;
begin
  sl := TStringList.Create();
  try
    sl.Text := Self.ToString();//LineAdd possible when self is null

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

function OLString.LineAdded(const NewLine: string): OLString;
var
  OutPut: OLString;
begin
  OutPut := Self;
  OutPut.LineAdd(NewLine);

  Result := OutPut;
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

procedure OLString.LineDelete(const LineIndex: integer);
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

function OLString.LineEndAt(const LineIndex: Integer): OLInteger;
begin

end;

function OLString.LineIndexLike(const s: string; StartingFrom: Integer): OLInteger;
var
  i: Integer;
  OutPut: OLInteger;
begin
  for i := StartingFrom to Self.LineCount - 1 do
  begin
    if Self.Lines[i].Like(s) then
    begin
      OutPut := i;
      Break;
    end;
  end;

  Result := OutPut;
end;

function OLString.LineIndexOf(const s: string): OLInteger;
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

procedure OLString.LineInsertAt(const LineIndex: integer; const s: string);
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


procedure OLString.LoadFromFile(const FileName: string);
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

function OLString.MidStrEx(const AStart, AEnd: integer): OLString;
begin
  Result := MidStr(AStart, AEnd - AStart + 1);
end;

class operator OLString.NotEqual(const a, b: OLString): OLBoolean;
begin
  Result := ((a.Value <> b.Value) and a.ValuePresent and b.ValuePresent) or (a.ValuePresent <> b.ValuePresent);
end;

procedure OLString.PasteFromClipboard;
begin
  Self := Clipboard.AsText;
end;

function OLString.PixelWidth(const F: TFont): OLInteger;
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

function OLString.Pos(const SubStr: string; const CaseSensitivity:
    TCaseSensitivity = csCaseSensitive): OLInteger;
var
  OutPut: OLInteger;
  UpperSubString: string;
begin
  if CaseSensitivity = csCaseSensitive then
    OutPut := System.Pos(SubStr, Self)
  else
  begin
    UpperSubString := SysUtils.UpperCase(SubStr);
    OutPut := System.Pos(UpperSubString, Self.UpperCase())
  end;

  Result := OutPut;
end;

function OLString.PosEx(const SubStr: string; const Offset: integer; const
    CaseSensitivity: TCaseSensitivity = csCaseSensitive): OLInteger;
var
  OutPut: OLInteger;
  UpperSubString: string;
begin
  if CaseSensitivity = csCaseSensitive then
    OutPut := StrUtils.PosEx(SubStr, Self, Offset)
  else
  begin
    UpperSubString := SysUtils.UpperCase(SubStr);
    OutPut := StrUtils.PosEx(UpperSubString, Self.UpperCase(), Offset)
  end;

  Result := OutPut;
end;

function OLString.PosLast(const SubStr: string; const CaseSensitivity:
    TCaseSensitivity = csCaseSensitive): OLInteger;
var
  SubStringLength: Integer;
  myCharPtr : PChar;
  i: Integer;
  OutPut: Integer;
begin
  OutPut := 0;

  SubStringLength := System.Length(SubStr);

  i := Self.Length() - SubStringLength + 1;
  myCharPtr := Addr(Self.Val[i]);

  if CaseSensitivity = csCaseSensitive then
  begin
    while i > 0 do
    begin
      if StrUtils.LeftStr(myCharPtr, SubStringLength) = SubStr then
      begin
        OutPut := i;
        Break;
      end;

      Dec(i);
      Dec(myCharPtr);
    end;
  end
  else
  begin
    while i > 0 do
    begin
      if SysUtils.AnsiUpperCase(StrUtils.LeftStr(myCharPtr, SubStringLength)) = SysUtils.AnsiUpperCase(SubStr) then
      begin
        OutPut := i;
        Break;
      end;

      Dec(i);
      Dec(myCharPtr);
    end;
  end;


  Result := OutPut;
end;

function OLString.PosLastEx(const SubStr: string; const NotAfterPosition:
    integer; const CaseSensitivity: TCaseSensitivity = csCaseSensitive):
    OLInteger;
var
  SubStringLength: Integer;
  myCharPtr : PChar;
  i: Integer;
  OutPut: Integer;
begin
  OutPut := 0;

  SubStringLength := System.Length(SubStr);

  i := Min(Self.Length() - SubStringLength + 1, NotAfterPosition);
  myCharPtr := Addr(Self.Val[i]);

  if CaseSensitivity = csCaseSensitive then
  begin
    while i > 0 do
    begin
      if StrUtils.LeftStr(myCharPtr, SubStringLength) = SubStr then
      begin
        OutPut := i;
        Break;
      end;

      Dec(i);
      Dec(myCharPtr);
    end;
  end
  else
  begin
    while i > 0 do
    begin
      if SysUtils.AnsiUpperCase(StrUtils.LeftStr(myCharPtr, SubStringLength)) = SysUtils.AnsiUpperCase(SubStr) then
      begin
        OutPut := i;
        Break;
      end;

      Dec(i);
      Dec(myCharPtr);
    end;
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

function OLString.ReplacedStartingAt(const Position: Cardinal; const NewValue:
    OLString): OLString;
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

function OLString.RightStrFrom(const StartFrom: integer): OLString;
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

procedure OLString.SaveToFile(const FileName: string);
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

procedure OLString.SetBase64(const Value: OLString);
begin
  Self := DecodeString(Value);
end;

procedure OLString.SetCharAtIndex(const Index: integer; const Value: Char);
begin
  if not Self.ValuePresent then
    raise Exception.Create('Cannot set chars in null value.');

  if Self.Length < Index then
    raise Exception.Create('Index greater then string length.');

  Self.Val[Index] := Value;
end;

procedure OLString.SetCSV(const Index: integer; const Value: OLString);
begin
  Self.SetCSVFieldValue(Index, Value);
end;

procedure OLString.SetCSVFieldValue(const FieldIndex: integer; const Value:
    OLString; const Delimiter: Char = ';');
var
  sl: TStringList;
begin
  sl := TStringList.Create();
  try
    sl.Delimiter := Delimiter;
    sl.StrictDelimiter := True;
    sl.DelimitedText := Self.Value;

    while sl.Count < FieldIndex + 1 do
      sl.Add('');

    sl[FieldIndex] := Value;

    Self := sl.DelimitedText;
  finally
    sl.Free;
  end;
end;

procedure OLString.SetHasValue(const Value: OLBoolean);
begin
  if Value then
    NullFlag := NonEmptyStr
  else
    NullFlag := EmptyStr;
end;

procedure OLString.SetHtmlUnicodeText(const Value: OLString);
var
  I: Integer;
  OutPut: OLString;
begin
  OutPut := Value;

  for I := 0 to System.Length(HtmlUnicodeTranslation) - 1 do
  begin
    OutPut := OutPut.Replaced(HtmlUnicodeTranslation[i].NumericalCode, HtmlUnicodeTranslation[i].UnicodeChar);
    if HtmlUnicodeTranslation[i].LiteralCode <> EmptyStr then
      OutPut := OutPut.Replaced(HtmlUnicodeTranslation[i].LiteralCode, HtmlUnicodeTranslation[i].UnicodeChar);
  end;

  Self := OutPut;
end;

procedure OLString.SetLine(const Index: integer; const Value: OLString);
var
  sl: TStringList;
begin
  sl := TStringList.Create();
  try
    sl.Text := Self;

    while sl.Count <= Index do
      sl.Add('');

    sl[Index] := Value;
    Self := sl.Text;
  finally
    sl.Free();
  end;
end;

procedure OLString.SetParam(const ParamName: string; const Value: OLString);
var
  ParIdx: OLInteger;
begin
  if ValBeforeParams = '' then
    ValBeforeParams := Val;

  ParIdx := ParamIndex(ParamName);
  if ParIdx.IsNull() then
    AppendParam(ParamName, Value)
  else
    UpdateParam(ParIdx, Value);

  ApplyParams();
end;

procedure OLString.SetUrlEncodedText(const Value: OLString);
var
  I: Integer;
  OutPut: OLString;
begin
  OutPut := Value;

  for I := 0 to System.Length(UrlTranslation) - 1 do
  begin
    OutPut := OutPut.Replaced(UrlTranslation[i].Translation, UrlTranslation[i].UnicodeChar);
  end;

  Self := OutPut;
end;

function OLString.ParamIndex(const ParamName: string): OLInteger;
var
  i: integer;
  output: OLInteger;
begin
  for i := 0 to System.Length(Self.Parameters) - 1 do
  begin
    if Self.Parameters[i].ParamName = ParamName then
    begin
      output := i;
      Break;
    end;
  end;

  Result := output;
end;

procedure OLString.AppendParam(const ParamName: string; const ParamValue:
    OLString);
var
  cnt: Integer;
begin
  cnt := System.Length(Self.Parameters);

  SetLength(Self.Parameters, cnt + 1);

  Self.Parameters[cnt].ParamName := ParamName;
  Self.Parameters[cnt].ParamValue := ParamValue;
end;


procedure OLString.UpdateParam(const ParamIndex: integer; const ParamValue:
    OLString);
begin
  Self.Parameters[ParamIndex].ParamValue := ParamValue;
end;

procedure OLString.ApplyParams();
var
  i: integer;
begin
  Self.Val := ValBeforeParams;

  for i := 0 to System.Length(Self.Parameters) - 1 do
  begin
    Self.Val := Self.Replaced(':' + Self.Parameters[i].ParamName, Self.Parameters[i].ParamValue)
  end;
end;


procedure OLString.SetValue(const Value: string);
begin
  Self.Val := Value;
  Self.TurnDefaultValueFlagOff();
end;

function OLString.SmartStrToDate: OLDate;
var
  OutPut: OLDate;
begin
  if Self.IsNull then
    OutPut := Null
  else
    OutPut := SmartToDate.SmartStrToDate(Self);


  Result := OutPut;
end;

function OLString.SpacesRemoved: OLString;
begin
  Result := Self.Replaced(' ', '');
end;

function OLString.SplitString(const Delimiters: string = ';'): TStringDynArray;
var
  i, l: integer;
  OutPut: TStringDynArray;
  TempStr: string;
begin
  //Result := StrUtils.SplitString(Self, Delimiters)

  for i := 1 to Self.Length do
  begin
    if System.Pos(Self[i], Delimiters) > 0 then
    begin
      l := System.Length(OutPut);
      SetLength(OutPut, l + 1);
      OutPut[l] := TempStr;
      TempStr := EmptyStr;
    end
    else
      TempStr := TempStr + Self[i];
  end;

  if TempStr <> EmptyStr then
  begin
    l := System.Length(OutPut);
    SetLength(OutPut, l + 1);
    OutPut[l] := TempStr;
  end;

  Result := OutPut;
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
var  OutPut: OLCurrency;
begin
  if Self.IsNull() then
    OutPut := Null
  else
  begin
    if Self.UpperCase = 'NULL' then
      OutPut := NULL
    else
      OutPut := StrToCurr(Self)
  end;

  Result := OutPut;
end;

function OLString.ToDate: OLDate;
var  OutPut: OLDate;
begin
  if Self.IsNull() then
    OutPut := Null
  else
  begin
    if Self.UpperCase = 'NULL' then
      OutPut := NULL
    else
      OutPut := StrToDate(Self)
  end;

  Result := OutPut;
end;

function OLString.ToDateTime: OLDateTime;
var  OutPut: OLDateTime;
begin
  if Self.IsNull() then
    OutPut := Null
  else
  begin
    if Self.UpperCase = 'NULL' then
      OutPut := NULL
    else
      OutPut := StrToDateTime(Self)
  end;

  Result := OutPut;
end;

function OLString.ToFloat: OLDouble;
var  OutPut: OLDouble;
begin
  if Self.IsNull() then
    OutPut := Null
  else
  begin
    if Self.UpperCase = 'NULL' then
      OutPut := NULL
    else
      OutPut := StrToFloat(Self)
  end;

  Result := OutPut;
end;

function OLString.ToInt: OLInteger;
var  OutPut: OLInteger;
begin
  if Self.IsNull() then
    OutPut := Null
  else
  begin
    if Self.UpperCase = 'NULL' then
      OutPut := NULL
    else
      OutPut := StrToInt(Self)
  end;

  Result := OutPut;
end;

function OLString.ToInt64: Int64;
var  OutPut: Int64;
begin
  if Self.IsNull() then
    OutPut := Null
  else
  begin
    if Self.UpperCase = 'NULL' then
      OutPut := NULL
    else
      OutPut := StrToInt64(Self)
  end;

  Result := OutPut;
end;

function OLString.ToPWideChar: PWideChar;
var
  OutPut: PWideChar;
begin
  if Self.IsNull then
    OutPut := PWideChar(EmptyStr)
  else
    OutPut := PWideChar(Self.Val);

  Result := OutPut;
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

function OLString.LeadingApostropheExcluded: OLString;
begin
  Result := Self.LeadingCharExcluded('''');
end;

function OLString.LeadingApostropheIncluded: OLString;
begin
  Result := Self.LeadingCharIncluded(',');
end;

function OLString.LeadingCharExcluded(const c: Char): OLString;
var
  OutPut: OLString;
begin
  if Self.LeftStr(1) = c then
    OutPut := Self.RightStrFrom(2)
  else
    OutPut := Self;

  Result := OutPut;
end;

function OLString.LeadingCharIncluded(const c: Char): OLString;
var
  OutPut: OLString;
begin
  if Self.LeftStr(1) = c then
    OutPut := Self
  else
    OutPut := c + Self;

  Result := OutPut;
end;

function OLString.LeadingCharsAdded(const C: Char; const NewLength: integer):
    OLString;
var
  OutPut: OLString;
begin
  OutPut := Self;

  while OutPut.Length < NewLength do
    OutPut := C + OutPut;

  Result := OutPut;
end;

function OLString.LeadingComaExcluded: OLString;
begin
  Result := Self.LeadingCharExcluded(',');
end;

function OLString.LeadingComaIncluded: OLString;
begin
  Result := Self.LeadingCharIncluded(',');
end;

function OLString.LeadingSpacesAdded(const NewLength: integer): OLString;
begin
  Result := Self.LeadingCharsAdded(' ', NewLength);
end;

function OLString.LeadingZerosAdded(const NewLength: integer): OLString;
begin
  Result := Self.LeadingCharsAdded('0', NewLength)
end;

function OLString.TrailingCharsAdded(const C: Char; const NewLength: integer):
    OLString;
var
  OutPut: OLString;
begin
  OutPut := Self;

  while OutPut.Length < NewLength do
    OutPut := OutPut + C;

  Result := OutPut;
end;

function OLString.TrailingSpacesAdded(const NewLength: integer): OLString;
begin
  Result := Self.TrailingCharsAdded(' ', NewLength);
end;


//http://www.yanniel.info/2011/01/string-compress-decompress-delphi-zlib.html
function OLString.Compressed: OLString;
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

function OLString.ContainsStr(const ASubString: OLString): OLBoolean;
begin
  Result := StrUtils.ContainsStr(Self, ASubString);
end;

function OLString.ContainsText(const ASubText: OLString): OLBoolean;
begin
  Result := StrUtils.ContainsText(Self, ASubText);
end;

procedure OLString.CopyToClipboard;
begin
  Clipboard.AsText := Self;
end;

function OLString.OccurrencesCount(const SubString: string; const
    CaseSensitivity: TCaseSensitivity = csCaseSensitive): OLInteger;
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

function OLString.OccurrencesPosition(const SubString: string; const Index:
    integer; const CaseSensitivity: TCaseSensitivity = csCaseSensitive):
    OLInteger;
var
  Position, Counter, OutPut: integer;
begin
  OutPut := 0;
  Counter := -1;
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

function OLString.CSVFieldByName(const FieldName: OLString; const RowIndex:
    Integer = 1): OLString;
var
  FieldIndex: OLInteger;
  Output: OLString;
  Header: OLString;
begin
  Output := Null;

  Header := self.Lines[0].UpperCase();
  FieldIndex := Header.CSVIndex(FieldName.UpperCase());

  if not FieldIndex.IsNull() then
    Output := Self.Lines[RowIndex].CSV[FieldIndex];

  Result := Output;
end;

function OLString.CSVFieldCount(const Delimiter: Char = ';'): OLInteger;
var
  sl: TStringList;
  OutPut: OLInteger;
begin
  sl := TStringList.Create();
  try
    sl.Delimiter := Delimiter;
    sl.StrictDelimiter := True;
    sl.DelimitedText := Self.Value;

    OutPut := sl.Count;
  finally
    sl.Free;
  end;

  Result := OutPut;
end;

function OLString.CSVFieldValue(const FieldIndex: integer; const Delimiter:
    Char = ';'): OLString;
var
  sl: TStringList;
  OutPut: string;
begin
  sl := TStringList.Create();
  try
    sl.Delimiter := Delimiter;
    sl.StrictDelimiter := True;
    sl.DelimitedText := Self.Value;
    if sl.Count > FieldIndex then
      OutPut := sl[FieldIndex];
  finally
    sl.Free;
  end;

  Result := OutPut;
end;


function OLString.CSVIndex(const ValueToFind: OLString): OLInteger;
var
  I: Integer;
  OutPut: OLInteger;
begin
  for I := 0 to CSVFieldCount() - 1 do
    if GetCSV(i) = ValueToFind then
    begin
      OutPut := I;
      Break;
    end;

  Result := OutPut;
end;

//http://stackoverflow.com/questions/32306960/delphi-7-and-decode-utf-8-base64

procedure OLString.DecodeBase64ToFile(const FileName: string);
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
function OLString.Decompressed: OLString;
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

function OLString.Deleted(const FromPosition: integer; const Count: integer =
    1): OLString;
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

function OLString.RepeatedString(const ACount: integer): OLString;
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

function OLString.FindPatternStr(const Tag: OLString; const StartingPosition:
    integer = 1; const CaseSensitivity: TCaseSensitivity = csCaseInsensitive):
    OLString;
begin
  Result := Self.FindPattern(Tag, StartingPosition, CaseSensitivity).Value;
end;


function OLString.IBANChangeAlpha(const input: string): string;
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



class operator OLString.Implicit(const a: OLString): Variant;
var
  OutPut: Variant;
begin
  if a.ValuePresent then
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
  if Self.IsNull then
    OutPut := Null
  else
    OutPut := SmartToDate.TrySmartStrToDate(Self, dat);

  Result := OutPut;
end;

function OLString.TrySmartStrToDate(var d: TDate): OLBoolean;
var
  OutPut: OLBoolean;
begin
  if Self.IsNull then
    OutPut := Null
  else
    OutPut := SmartToDate.TrySmartStrToDate(Self, d);

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

initialization

  HtmlUnicodeTranslation[0].UnicodeChar := '≠';	HtmlUnicodeTranslation[0].NumericalCode := '&#8800;';	HtmlUnicodeTranslation[0].LiteralCode := '&ne;';
  HtmlUnicodeTranslation[1].UnicodeChar := '&';	HtmlUnicodeTranslation[1].NumericalCode := '&#38;';	HtmlUnicodeTranslation[1].LiteralCode := '&amp;';
  HtmlUnicodeTranslation[2].UnicodeChar := '⊥';	HtmlUnicodeTranslation[2].NumericalCode := '&#8743;';	HtmlUnicodeTranslation[2].LiteralCode := '&and;';
  HtmlUnicodeTranslation[3].UnicodeChar := '¬';	HtmlUnicodeTranslation[3].NumericalCode := '&#172;';	HtmlUnicodeTranslation[3].LiteralCode := '&not;';
  HtmlUnicodeTranslation[4].UnicodeChar := '∼';	HtmlUnicodeTranslation[4].NumericalCode := '&#8764;';	HtmlUnicodeTranslation[4].LiteralCode := '&sim;';
  HtmlUnicodeTranslation[5].UnicodeChar := '⊦';	HtmlUnicodeTranslation[5].NumericalCode := '&#8744;';	HtmlUnicodeTranslation[5].LiteralCode := '&or;';
  HtmlUnicodeTranslation[6].UnicodeChar := '→';	HtmlUnicodeTranslation[6].NumericalCode := '&#8594;';	HtmlUnicodeTranslation[6].LiteralCode := '&rarr;';
  HtmlUnicodeTranslation[7].UnicodeChar := '←';	HtmlUnicodeTranslation[7].NumericalCode := '&#8592;';	HtmlUnicodeTranslation[7].LiteralCode := '&larr;';
  HtmlUnicodeTranslation[8].UnicodeChar := '↔';	HtmlUnicodeTranslation[8].NumericalCode := '&#8596;';	HtmlUnicodeTranslation[8].LiteralCode := '&harr;';
  HtmlUnicodeTranslation[9].UnicodeChar := '⇕';	HtmlUnicodeTranslation[9].NumericalCode := '&#8661;';
  HtmlUnicodeTranslation[10].UnicodeChar := '≡';	HtmlUnicodeTranslation[10].NumericalCode := '&#8801;';	HtmlUnicodeTranslation[10].LiteralCode := '&equiv;';
  HtmlUnicodeTranslation[11].UnicodeChar := '∀';	HtmlUnicodeTranslation[11].NumericalCode := '&#8704;';	HtmlUnicodeTranslation[11].LiteralCode := '&forall;';
  HtmlUnicodeTranslation[12].UnicodeChar := '∃';	HtmlUnicodeTranslation[12].NumericalCode := '&#8707;';	HtmlUnicodeTranslation[12].LiteralCode := '&exist;';
  HtmlUnicodeTranslation[13].UnicodeChar := '℩';	HtmlUnicodeTranslation[13].NumericalCode := '&#8489;';
  HtmlUnicodeTranslation[14].UnicodeChar := '□';	HtmlUnicodeTranslation[14].NumericalCode := '&#9633;';
  HtmlUnicodeTranslation[15].UnicodeChar := '◊';	HtmlUnicodeTranslation[15].NumericalCode := '&#9674;';	HtmlUnicodeTranslation[15].LiteralCode := '&loz;';
  HtmlUnicodeTranslation[16].UnicodeChar := '⇒';	HtmlUnicodeTranslation[16].NumericalCode := '&#8658;';	HtmlUnicodeTranslation[16].LiteralCode := '&rArr;';
  HtmlUnicodeTranslation[17].UnicodeChar := '⇐';	HtmlUnicodeTranslation[17].NumericalCode := '&#8656;';	HtmlUnicodeTranslation[17].LiteralCode := '&lArr;';
  HtmlUnicodeTranslation[18].UnicodeChar := '⇔';	HtmlUnicodeTranslation[18].NumericalCode := '&#8660;';	HtmlUnicodeTranslation[18].LiteralCode := '&hArr;';
  HtmlUnicodeTranslation[19].UnicodeChar := '∴';	HtmlUnicodeTranslation[19].NumericalCode := '&#8756;';	HtmlUnicodeTranslation[19].LiteralCode := '&there4;';
  HtmlUnicodeTranslation[20].UnicodeChar := '⊥';	HtmlUnicodeTranslation[20].NumericalCode := '&#8869;';	HtmlUnicodeTranslation[20].LiteralCode := '&perp;';
  HtmlUnicodeTranslation[21].UnicodeChar := '⊤';	HtmlUnicodeTranslation[21].NumericalCode := '&#8868;';
  HtmlUnicodeTranslation[22].UnicodeChar := '⊣';	HtmlUnicodeTranslation[22].NumericalCode := '&#8867;';
  HtmlUnicodeTranslation[23].UnicodeChar := '⊢';	HtmlUnicodeTranslation[23].NumericalCode := '&#8866;';
  HtmlUnicodeTranslation[24].UnicodeChar := '⊨';	HtmlUnicodeTranslation[24].NumericalCode := '&#8872;';
  HtmlUnicodeTranslation[25].UnicodeChar := '⊬';	HtmlUnicodeTranslation[25].NumericalCode := '&#8876;';
  HtmlUnicodeTranslation[26].UnicodeChar := '⊭';	HtmlUnicodeTranslation[26].NumericalCode := '&#8877;';
  HtmlUnicodeTranslation[27].UnicodeChar := '∈';	HtmlUnicodeTranslation[27].NumericalCode := '&#8712;';	HtmlUnicodeTranslation[27].LiteralCode := '&isin;';
  HtmlUnicodeTranslation[28].UnicodeChar := '∉';	HtmlUnicodeTranslation[28].NumericalCode := '&#8713;';	HtmlUnicodeTranslation[28].LiteralCode := '&notin;';
  HtmlUnicodeTranslation[29].UnicodeChar := '∋';	HtmlUnicodeTranslation[29].NumericalCode := '&#8715;';	HtmlUnicodeTranslation[29].LiteralCode := '&ni;';
  HtmlUnicodeTranslation[30].UnicodeChar := '∅';	HtmlUnicodeTranslation[30].NumericalCode := '&#8709;';	HtmlUnicodeTranslation[30].LiteralCode := '&empty;';
  HtmlUnicodeTranslation[31].UnicodeChar := '∩';	HtmlUnicodeTranslation[31].NumericalCode := '&#8745;';	HtmlUnicodeTranslation[31].LiteralCode := '&cap;';
  HtmlUnicodeTranslation[32].UnicodeChar := '∪';	HtmlUnicodeTranslation[32].NumericalCode := '&#8746;';	HtmlUnicodeTranslation[32].LiteralCode := '&cup;';
  HtmlUnicodeTranslation[33].UnicodeChar := '⊂';	HtmlUnicodeTranslation[33].NumericalCode := '&#8834;';	HtmlUnicodeTranslation[33].LiteralCode := '&sub;';
  HtmlUnicodeTranslation[34].UnicodeChar := '⊃';	HtmlUnicodeTranslation[34].NumericalCode := '&#8835;';	HtmlUnicodeTranslation[34].LiteralCode := '&sup;';
  HtmlUnicodeTranslation[35].UnicodeChar := '⊄';	HtmlUnicodeTranslation[35].NumericalCode := '&#8836;';	HtmlUnicodeTranslation[35].LiteralCode := '&nsub;';
  HtmlUnicodeTranslation[36].UnicodeChar := '⊆';	HtmlUnicodeTranslation[36].NumericalCode := '&#8838;';	HtmlUnicodeTranslation[36].LiteralCode := '&sube;';
  HtmlUnicodeTranslation[37].UnicodeChar := '⊇';	HtmlUnicodeTranslation[37].NumericalCode := '&#8839;';	HtmlUnicodeTranslation[37].LiteralCode := '&supe;';
  HtmlUnicodeTranslation[38].UnicodeChar := '○';	HtmlUnicodeTranslation[38].NumericalCode := '&#9675;';
  HtmlUnicodeTranslation[39].UnicodeChar := '⨡';	HtmlUnicodeTranslation[39].NumericalCode := '&#10785;';
  HtmlUnicodeTranslation[40].UnicodeChar := '−';	HtmlUnicodeTranslation[40].NumericalCode := '&#8722;';	HtmlUnicodeTranslation[40].LiteralCode := '&minus;';
  HtmlUnicodeTranslation[41].UnicodeChar := '±';	HtmlUnicodeTranslation[41].NumericalCode := '&#177;';	HtmlUnicodeTranslation[41].LiteralCode := '&plusmn;';
  HtmlUnicodeTranslation[42].UnicodeChar := '×';	HtmlUnicodeTranslation[42].NumericalCode := '&#215;';	HtmlUnicodeTranslation[42].LiteralCode := '&times;';
  HtmlUnicodeTranslation[43].UnicodeChar := '÷';	HtmlUnicodeTranslation[43].NumericalCode := '&#247;';	HtmlUnicodeTranslation[43].LiteralCode := '&divide;';
  HtmlUnicodeTranslation[44].UnicodeChar := '<';	HtmlUnicodeTranslation[44].NumericalCode := '&#60;';	HtmlUnicodeTranslation[44].LiteralCode := '&lt;';
  HtmlUnicodeTranslation[45].UnicodeChar := '>';	HtmlUnicodeTranslation[45].NumericalCode := '&#62;';	HtmlUnicodeTranslation[45].LiteralCode := '&gt;';
  HtmlUnicodeTranslation[46].UnicodeChar := '≤';	HtmlUnicodeTranslation[46].NumericalCode := '&#8804;';	HtmlUnicodeTranslation[46].LiteralCode := '&le;';
  HtmlUnicodeTranslation[47].UnicodeChar := '≥';	HtmlUnicodeTranslation[47].NumericalCode := '&#8805;';	HtmlUnicodeTranslation[47].LiteralCode := '&ge;';
  HtmlUnicodeTranslation[48].UnicodeChar := '≰';	HtmlUnicodeTranslation[48].NumericalCode := '&#8816;';
  HtmlUnicodeTranslation[49].UnicodeChar := '¼';	HtmlUnicodeTranslation[49].NumericalCode := '&#188;';	HtmlUnicodeTranslation[49].LiteralCode := '&frac14;';
  HtmlUnicodeTranslation[50].UnicodeChar := '½';	HtmlUnicodeTranslation[50].NumericalCode := '&#189;';	HtmlUnicodeTranslation[50].LiteralCode := '&frac12;';
  HtmlUnicodeTranslation[51].UnicodeChar := '¾';	HtmlUnicodeTranslation[51].NumericalCode := '&#190;';	HtmlUnicodeTranslation[51].LiteralCode := '&frac34;';
  HtmlUnicodeTranslation[52].UnicodeChar := '¹';	HtmlUnicodeTranslation[52].NumericalCode := '&#185;';	HtmlUnicodeTranslation[52].LiteralCode := '&sup1;';
  HtmlUnicodeTranslation[53].UnicodeChar := '²';	HtmlUnicodeTranslation[53].NumericalCode := '&#178;';	HtmlUnicodeTranslation[53].LiteralCode := '&sup2;';
  HtmlUnicodeTranslation[54].UnicodeChar := '³';	HtmlUnicodeTranslation[54].NumericalCode := '&#179;';	HtmlUnicodeTranslation[54].LiteralCode := '&sup3;';
  HtmlUnicodeTranslation[55].UnicodeChar := '°';	HtmlUnicodeTranslation[55].NumericalCode := '&#176;';	HtmlUnicodeTranslation[55].LiteralCode := '&deg;';
  HtmlUnicodeTranslation[56].UnicodeChar := '·';	HtmlUnicodeTranslation[56].NumericalCode := '&#183;';	HtmlUnicodeTranslation[56].LiteralCode := '&middot;';
  HtmlUnicodeTranslation[57].UnicodeChar := 'ƒ';	HtmlUnicodeTranslation[57].NumericalCode := '&#402;';	HtmlUnicodeTranslation[57].LiteralCode := '&fnof;';
  HtmlUnicodeTranslation[58].UnicodeChar := '′';	HtmlUnicodeTranslation[58].NumericalCode := '&#8242;';	HtmlUnicodeTranslation[58].LiteralCode := '&prime;';
  HtmlUnicodeTranslation[59].UnicodeChar := '″';	HtmlUnicodeTranslation[59].NumericalCode := '&#8243;';	HtmlUnicodeTranslation[59].LiteralCode := '&Prime;';
  HtmlUnicodeTranslation[60].UnicodeChar := '‾';	HtmlUnicodeTranslation[60].NumericalCode := '&#8254;';	HtmlUnicodeTranslation[60].LiteralCode := '&oline;';
  HtmlUnicodeTranslation[61].UnicodeChar := '⁄';	HtmlUnicodeTranslation[61].NumericalCode := '&#8260;';	HtmlUnicodeTranslation[61].LiteralCode := '&frasl;';
  HtmlUnicodeTranslation[62].UnicodeChar := 'ℵ';	HtmlUnicodeTranslation[62].NumericalCode := '&#8501;';	HtmlUnicodeTranslation[62].LiteralCode := '&alefsym;';
  HtmlUnicodeTranslation[63].UnicodeChar := '∂';	HtmlUnicodeTranslation[63].NumericalCode := '&#8706;';	HtmlUnicodeTranslation[63].LiteralCode := '&part;';
  HtmlUnicodeTranslation[64].UnicodeChar := '∑';	HtmlUnicodeTranslation[64].NumericalCode := '&#8721;';	HtmlUnicodeTranslation[64].LiteralCode := '&sum;';
  HtmlUnicodeTranslation[65].UnicodeChar := '∇';	HtmlUnicodeTranslation[65].NumericalCode := '&#8711;';	HtmlUnicodeTranslation[65].LiteralCode := '&nabla;';
  HtmlUnicodeTranslation[66].UnicodeChar := '√';	HtmlUnicodeTranslation[66].NumericalCode := '&#8730;';	HtmlUnicodeTranslation[66].LiteralCode := '&radic;';
  HtmlUnicodeTranslation[67].UnicodeChar := '∝';	HtmlUnicodeTranslation[67].NumericalCode := '&#8733;';	HtmlUnicodeTranslation[67].LiteralCode := '&prop;';
  HtmlUnicodeTranslation[68].UnicodeChar := '∞';	HtmlUnicodeTranslation[68].NumericalCode := '&#8734;';	HtmlUnicodeTranslation[68].LiteralCode := '&infin;';
  HtmlUnicodeTranslation[69].UnicodeChar := '∠';	HtmlUnicodeTranslation[69].NumericalCode := '&#8736;';	HtmlUnicodeTranslation[69].LiteralCode := '&ang;';
  HtmlUnicodeTranslation[70].UnicodeChar := '∫';	HtmlUnicodeTranslation[70].NumericalCode := '&#8747;';	HtmlUnicodeTranslation[70].LiteralCode := '&int;';
  HtmlUnicodeTranslation[71].UnicodeChar := '≅';	HtmlUnicodeTranslation[71].NumericalCode := '&#8773;';	HtmlUnicodeTranslation[71].LiteralCode := '&cong;';
  HtmlUnicodeTranslation[72].UnicodeChar := '≈';	HtmlUnicodeTranslation[72].NumericalCode := '&#8776;';	HtmlUnicodeTranslation[72].LiteralCode := '&asymp;';
  HtmlUnicodeTranslation[73].UnicodeChar := '⊕';	HtmlUnicodeTranslation[73].NumericalCode := '&#8853;';	HtmlUnicodeTranslation[73].LiteralCode := '&oplus;';
  HtmlUnicodeTranslation[74].UnicodeChar := '⊗';	HtmlUnicodeTranslation[74].NumericalCode := '&#8855;';	HtmlUnicodeTranslation[74].LiteralCode := '&otimes;';
  HtmlUnicodeTranslation[75].UnicodeChar := '‰';	HtmlUnicodeTranslation[75].NumericalCode := '&#8240;';	HtmlUnicodeTranslation[75].LiteralCode := '&permil;';
  HtmlUnicodeTranslation[76].UnicodeChar := 'ℜ';	HtmlUnicodeTranslation[76].NumericalCode := '&#8476;';	HtmlUnicodeTranslation[76].LiteralCode := '&real;';
  HtmlUnicodeTranslation[77].UnicodeChar := '℘';	HtmlUnicodeTranslation[77].NumericalCode := '&#8472;';	HtmlUnicodeTranslation[77].LiteralCode := '&weierp;';
  HtmlUnicodeTranslation[78].UnicodeChar := 'ℑ';	HtmlUnicodeTranslation[78].NumericalCode := '&#8465;';	HtmlUnicodeTranslation[78].LiteralCode := '&image;';
  HtmlUnicodeTranslation[79].UnicodeChar := '≺';	HtmlUnicodeTranslation[79].NumericalCode := '&#8826;';
  HtmlUnicodeTranslation[80].UnicodeChar := '≻';	HtmlUnicodeTranslation[80].NumericalCode := '&#8827;';
  HtmlUnicodeTranslation[81].UnicodeChar := '≼';	HtmlUnicodeTranslation[81].NumericalCode := '&#8828;';
  HtmlUnicodeTranslation[82].UnicodeChar := '≽';	HtmlUnicodeTranslation[82].NumericalCode := '&#8829;';
  HtmlUnicodeTranslation[83].UnicodeChar := '⋠';	HtmlUnicodeTranslation[83].NumericalCode := '&#8928;';
  HtmlUnicodeTranslation[84].UnicodeChar := '⊲';	HtmlUnicodeTranslation[84].NumericalCode := '&#8882;';
  HtmlUnicodeTranslation[85].UnicodeChar := '⊳';	HtmlUnicodeTranslation[85].NumericalCode := '&#8883;';
  HtmlUnicodeTranslation[86].UnicodeChar := '⊴';	HtmlUnicodeTranslation[86].NumericalCode := '&#8884;';
  HtmlUnicodeTranslation[87].UnicodeChar := 'ℏ';	HtmlUnicodeTranslation[87].NumericalCode := '&#8463;';
  HtmlUnicodeTranslation[88].UnicodeChar := 'ℕ';	HtmlUnicodeTranslation[88].NumericalCode := '&#8469;';
  HtmlUnicodeTranslation[89].UnicodeChar := 'ℚ';	HtmlUnicodeTranslation[89].NumericalCode := '&#8474;';
  HtmlUnicodeTranslation[90].UnicodeChar := 'ℤ';	HtmlUnicodeTranslation[90].NumericalCode := '&#8484;';
  HtmlUnicodeTranslation[91].UnicodeChar := '↑';	HtmlUnicodeTranslation[91].NumericalCode := '&#8593;';	HtmlUnicodeTranslation[91].LiteralCode := '&uarr;';
  HtmlUnicodeTranslation[92].UnicodeChar := '↓';	HtmlUnicodeTranslation[92].NumericalCode := '&#8595;';	HtmlUnicodeTranslation[92].LiteralCode := '&darr;';
  HtmlUnicodeTranslation[93].UnicodeChar := 'À';	HtmlUnicodeTranslation[93].NumericalCode := '&#192;';	HtmlUnicodeTranslation[93].LiteralCode := '&Agrave;';
  HtmlUnicodeTranslation[94].UnicodeChar := 'Á';	HtmlUnicodeTranslation[94].NumericalCode := '&#193;';	HtmlUnicodeTranslation[94].LiteralCode := '&Aacute;';
  HtmlUnicodeTranslation[95].UnicodeChar := 'Â';	HtmlUnicodeTranslation[95].NumericalCode := '&#194;';	HtmlUnicodeTranslation[95].LiteralCode := '&Acirc;';
  HtmlUnicodeTranslation[96].UnicodeChar := 'Ã';	HtmlUnicodeTranslation[96].NumericalCode := '&#195;';	HtmlUnicodeTranslation[96].LiteralCode := '&Atilde;';
  HtmlUnicodeTranslation[97].UnicodeChar := 'Ä';	HtmlUnicodeTranslation[97].NumericalCode := '&#196;';	HtmlUnicodeTranslation[97].LiteralCode := '&Auml;';
  HtmlUnicodeTranslation[98].UnicodeChar := 'Å';	HtmlUnicodeTranslation[98].NumericalCode := '&#197;';	HtmlUnicodeTranslation[98].LiteralCode := '&Aring;';
  HtmlUnicodeTranslation[99].UnicodeChar := 'Æ';	HtmlUnicodeTranslation[99].NumericalCode := '&#198;';	HtmlUnicodeTranslation[99].LiteralCode := '&AElig;';
  HtmlUnicodeTranslation[100].UnicodeChar := 'Ç';	HtmlUnicodeTranslation[100].NumericalCode := '&#199;';	HtmlUnicodeTranslation[100].LiteralCode := '&Ccedil;';
  HtmlUnicodeTranslation[101].UnicodeChar := 'È';	HtmlUnicodeTranslation[101].NumericalCode := '&#200;';	HtmlUnicodeTranslation[101].LiteralCode := '&Egrave;';
  HtmlUnicodeTranslation[102].UnicodeChar := 'É';	HtmlUnicodeTranslation[102].NumericalCode := '&#201;';	HtmlUnicodeTranslation[102].LiteralCode := '&Eacute;';
  HtmlUnicodeTranslation[103].UnicodeChar := 'Ê';	HtmlUnicodeTranslation[103].NumericalCode := '&#202;';	HtmlUnicodeTranslation[103].LiteralCode := '&Ecirc;';
  HtmlUnicodeTranslation[104].UnicodeChar := 'Ë';	HtmlUnicodeTranslation[104].NumericalCode := '&#203;';	HtmlUnicodeTranslation[104].LiteralCode := '&Euml;';
  HtmlUnicodeTranslation[105].UnicodeChar := 'Ì';	HtmlUnicodeTranslation[105].NumericalCode := '&#204;';	HtmlUnicodeTranslation[105].LiteralCode := '&Igrave;';
  HtmlUnicodeTranslation[106].UnicodeChar := 'Í';	HtmlUnicodeTranslation[106].NumericalCode := '&#205;';	HtmlUnicodeTranslation[106].LiteralCode := '&Iacute;';
  HtmlUnicodeTranslation[107].UnicodeChar := 'Î';	HtmlUnicodeTranslation[107].NumericalCode := '&#206;';	HtmlUnicodeTranslation[107].LiteralCode := '&Icirc;';
  HtmlUnicodeTranslation[108].UnicodeChar := 'Ï';	HtmlUnicodeTranslation[108].NumericalCode := '&#207;';	HtmlUnicodeTranslation[108].LiteralCode := '&Iuml;';
  HtmlUnicodeTranslation[109].UnicodeChar := 'Ð';	HtmlUnicodeTranslation[109].NumericalCode := '&#208;';	HtmlUnicodeTranslation[109].LiteralCode := '&ETH;';
  HtmlUnicodeTranslation[110].UnicodeChar := 'Ñ';	HtmlUnicodeTranslation[110].NumericalCode := '&#209;';	HtmlUnicodeTranslation[110].LiteralCode := '&Ntilde;';
  HtmlUnicodeTranslation[111].UnicodeChar := 'Ò';	HtmlUnicodeTranslation[111].NumericalCode := '&#210;';	HtmlUnicodeTranslation[111].LiteralCode := '&Ograve;';
  HtmlUnicodeTranslation[112].UnicodeChar := 'Ó';	HtmlUnicodeTranslation[112].NumericalCode := '&#211;';	HtmlUnicodeTranslation[112].LiteralCode := '&Oacute;';
  HtmlUnicodeTranslation[113].UnicodeChar := 'Ô';	HtmlUnicodeTranslation[113].NumericalCode := '&#212;';	HtmlUnicodeTranslation[113].LiteralCode := '&Ocirc;';
  HtmlUnicodeTranslation[114].UnicodeChar := 'Õ';	HtmlUnicodeTranslation[114].NumericalCode := '&#213;';	HtmlUnicodeTranslation[114].LiteralCode := '&Otilde;';
  HtmlUnicodeTranslation[115].UnicodeChar := 'Ö';	HtmlUnicodeTranslation[115].NumericalCode := '&#214;';	HtmlUnicodeTranslation[115].LiteralCode := '&Ouml;';
  HtmlUnicodeTranslation[116].UnicodeChar := 'Ø';	HtmlUnicodeTranslation[116].NumericalCode := '&#216;';	HtmlUnicodeTranslation[116].LiteralCode := '&Oslash;';
  HtmlUnicodeTranslation[117].UnicodeChar := 'Ù';	HtmlUnicodeTranslation[117].NumericalCode := '&#217;';	HtmlUnicodeTranslation[117].LiteralCode := '&Ugrave;';
  HtmlUnicodeTranslation[118].UnicodeChar := 'Ú';	HtmlUnicodeTranslation[118].NumericalCode := '&#218;';	HtmlUnicodeTranslation[118].LiteralCode := '&Uacute;';
  HtmlUnicodeTranslation[119].UnicodeChar := 'Û';	HtmlUnicodeTranslation[119].NumericalCode := '&#219;';	HtmlUnicodeTranslation[119].LiteralCode := '&Ucirc;';
  HtmlUnicodeTranslation[120].UnicodeChar := 'Ü';	HtmlUnicodeTranslation[120].NumericalCode := '&#220;';	HtmlUnicodeTranslation[120].LiteralCode := '&Uuml;';
  HtmlUnicodeTranslation[121].UnicodeChar := 'Ý';	HtmlUnicodeTranslation[121].NumericalCode := '&#221;';	HtmlUnicodeTranslation[121].LiteralCode := '&Yacute;';
  HtmlUnicodeTranslation[122].UnicodeChar := 'Þ';	HtmlUnicodeTranslation[122].NumericalCode := '&#222;';	HtmlUnicodeTranslation[122].LiteralCode := '&THORN;';
  HtmlUnicodeTranslation[123].UnicodeChar := 'ß';	HtmlUnicodeTranslation[123].NumericalCode := '&#223;';	HtmlUnicodeTranslation[123].LiteralCode := '&szlig;';
  HtmlUnicodeTranslation[124].UnicodeChar := 'à';	HtmlUnicodeTranslation[124].NumericalCode := '&#224;';	HtmlUnicodeTranslation[124].LiteralCode := '&agrave;';
  HtmlUnicodeTranslation[125].UnicodeChar := 'á';	HtmlUnicodeTranslation[125].NumericalCode := '&#225;';	HtmlUnicodeTranslation[125].LiteralCode := '&aacute;';
  HtmlUnicodeTranslation[126].UnicodeChar := 'â';	HtmlUnicodeTranslation[126].NumericalCode := '&#226;';	HtmlUnicodeTranslation[126].LiteralCode := '&acirc;';
  HtmlUnicodeTranslation[127].UnicodeChar := 'ã';	HtmlUnicodeTranslation[127].NumericalCode := '&#227;';	HtmlUnicodeTranslation[127].LiteralCode := '&atilde;';
  HtmlUnicodeTranslation[128].UnicodeChar := 'ä';	HtmlUnicodeTranslation[128].NumericalCode := '&#228;';	HtmlUnicodeTranslation[128].LiteralCode := '&auml;';
  HtmlUnicodeTranslation[129].UnicodeChar := 'å';	HtmlUnicodeTranslation[129].NumericalCode := '&#229;';	HtmlUnicodeTranslation[129].LiteralCode := '&aring;';
  HtmlUnicodeTranslation[130].UnicodeChar := 'æ';	HtmlUnicodeTranslation[130].NumericalCode := '&#230;';	HtmlUnicodeTranslation[130].LiteralCode := '&aelig;';
  HtmlUnicodeTranslation[131].UnicodeChar := 'ç';	HtmlUnicodeTranslation[131].NumericalCode := '&#231;';	HtmlUnicodeTranslation[131].LiteralCode := '&ccedil;';
  HtmlUnicodeTranslation[132].UnicodeChar := 'è';	HtmlUnicodeTranslation[132].NumericalCode := '&#232;';	HtmlUnicodeTranslation[132].LiteralCode := '&egrave;';
  HtmlUnicodeTranslation[133].UnicodeChar := 'é';	HtmlUnicodeTranslation[133].NumericalCode := '&#233;';	HtmlUnicodeTranslation[133].LiteralCode := '&eacute;';
  HtmlUnicodeTranslation[134].UnicodeChar := 'ê';	HtmlUnicodeTranslation[134].NumericalCode := '&#234;';	HtmlUnicodeTranslation[134].LiteralCode := '&ecirc;';
  HtmlUnicodeTranslation[135].UnicodeChar := 'ë';	HtmlUnicodeTranslation[135].NumericalCode := '&#235;';	HtmlUnicodeTranslation[135].LiteralCode := '&euml;';
  HtmlUnicodeTranslation[136].UnicodeChar := 'ì';	HtmlUnicodeTranslation[136].NumericalCode := '&#236;';	HtmlUnicodeTranslation[136].LiteralCode := '&igrave;';
  HtmlUnicodeTranslation[137].UnicodeChar := 'í';	HtmlUnicodeTranslation[137].NumericalCode := '&#237;';	HtmlUnicodeTranslation[137].LiteralCode := '&iacute;';
  HtmlUnicodeTranslation[138].UnicodeChar := 'î';	HtmlUnicodeTranslation[138].NumericalCode := '&#238;';	HtmlUnicodeTranslation[138].LiteralCode := '&icirc;';
  HtmlUnicodeTranslation[139].UnicodeChar := 'ï';	HtmlUnicodeTranslation[139].NumericalCode := '&#239;';	HtmlUnicodeTranslation[139].LiteralCode := '&iuml;';
  HtmlUnicodeTranslation[140].UnicodeChar := 'ð';	HtmlUnicodeTranslation[140].NumericalCode := '&#240;';	HtmlUnicodeTranslation[140].LiteralCode := '&eth;';
  HtmlUnicodeTranslation[141].UnicodeChar := 'ñ';	HtmlUnicodeTranslation[141].NumericalCode := '&#241;';	HtmlUnicodeTranslation[141].LiteralCode := '&ntilde;';
  HtmlUnicodeTranslation[142].UnicodeChar := 'ò';	HtmlUnicodeTranslation[142].NumericalCode := '&#242;';	HtmlUnicodeTranslation[142].LiteralCode := '&ograve;';
  HtmlUnicodeTranslation[143].UnicodeChar := 'ó';	HtmlUnicodeTranslation[143].NumericalCode := '&#243;';	HtmlUnicodeTranslation[143].LiteralCode := '&oacute;';
  HtmlUnicodeTranslation[144].UnicodeChar := 'ô';	HtmlUnicodeTranslation[144].NumericalCode := '&#244;';	HtmlUnicodeTranslation[144].LiteralCode := '&ocirc;';
  HtmlUnicodeTranslation[145].UnicodeChar := 'õ';	HtmlUnicodeTranslation[145].NumericalCode := '&#245;';	HtmlUnicodeTranslation[145].LiteralCode := '&otilde;';
  HtmlUnicodeTranslation[146].UnicodeChar := 'ö';	HtmlUnicodeTranslation[146].NumericalCode := '&#246;';	HtmlUnicodeTranslation[146].LiteralCode := '&ouml;';
  HtmlUnicodeTranslation[147].UnicodeChar := 'ø';	HtmlUnicodeTranslation[147].NumericalCode := '&#248;';	HtmlUnicodeTranslation[147].LiteralCode := '&oslash;';
  HtmlUnicodeTranslation[148].UnicodeChar := 'ù';	HtmlUnicodeTranslation[148].NumericalCode := '&#249;';	HtmlUnicodeTranslation[148].LiteralCode := '&ugrave;';
  HtmlUnicodeTranslation[149].UnicodeChar := 'ú';	HtmlUnicodeTranslation[149].NumericalCode := '&#250;';	HtmlUnicodeTranslation[149].LiteralCode := '&uacute;';
  HtmlUnicodeTranslation[150].UnicodeChar := 'û';	HtmlUnicodeTranslation[150].NumericalCode := '&#251;';	HtmlUnicodeTranslation[150].LiteralCode := '&ucirc;';
  HtmlUnicodeTranslation[151].UnicodeChar := 'ü';	HtmlUnicodeTranslation[151].NumericalCode := '&#252;';	HtmlUnicodeTranslation[151].LiteralCode := '&uuml;';
  HtmlUnicodeTranslation[152].UnicodeChar := 'ý';	HtmlUnicodeTranslation[152].NumericalCode := '&#253;';	HtmlUnicodeTranslation[152].LiteralCode := '&yacute;';
  HtmlUnicodeTranslation[153].UnicodeChar := 'þ';	HtmlUnicodeTranslation[153].NumericalCode := '&#254;';	HtmlUnicodeTranslation[153].LiteralCode := '&thorn;';
  HtmlUnicodeTranslation[154].UnicodeChar := 'ÿ';	HtmlUnicodeTranslation[154].NumericalCode := '&#255;';	HtmlUnicodeTranslation[154].LiteralCode := '&yuml;';
  HtmlUnicodeTranslation[155].UnicodeChar := 'Œ';	HtmlUnicodeTranslation[155].NumericalCode := '&#338;';	HtmlUnicodeTranslation[155].LiteralCode := '&OElig;';
  HtmlUnicodeTranslation[156].UnicodeChar := 'œ';	HtmlUnicodeTranslation[156].NumericalCode := '&#339;';	HtmlUnicodeTranslation[156].LiteralCode := '&oelig;';
  HtmlUnicodeTranslation[157].UnicodeChar := 'Š';	HtmlUnicodeTranslation[157].NumericalCode := '&#352;';	HtmlUnicodeTranslation[157].LiteralCode := '&Scaron;';
  HtmlUnicodeTranslation[158].UnicodeChar := 'š';	HtmlUnicodeTranslation[158].NumericalCode := '&#353;';	HtmlUnicodeTranslation[158].LiteralCode := '&scaron;';
  HtmlUnicodeTranslation[159].UnicodeChar := 'Ÿ';	HtmlUnicodeTranslation[159].NumericalCode := '&#376;';	HtmlUnicodeTranslation[159].LiteralCode := '&Yuml;';
  HtmlUnicodeTranslation[160].UnicodeChar := 'Α';	HtmlUnicodeTranslation[160].NumericalCode := '&#913;';	HtmlUnicodeTranslation[160].LiteralCode := '&Alpha;';
  HtmlUnicodeTranslation[161].UnicodeChar := 'Β';	HtmlUnicodeTranslation[161].NumericalCode := '&#914;';	HtmlUnicodeTranslation[161].LiteralCode := '&Beta;';
  HtmlUnicodeTranslation[162].UnicodeChar := 'Γ';	HtmlUnicodeTranslation[162].NumericalCode := '&#915;';	HtmlUnicodeTranslation[162].LiteralCode := '&Gamma;';
  HtmlUnicodeTranslation[163].UnicodeChar := 'Δ';	HtmlUnicodeTranslation[163].NumericalCode := '&#916;';	HtmlUnicodeTranslation[163].LiteralCode := '&Delta;';
  HtmlUnicodeTranslation[164].UnicodeChar := 'Ε';	HtmlUnicodeTranslation[164].NumericalCode := '&#917;';	HtmlUnicodeTranslation[164].LiteralCode := '&Epsilon;';
  HtmlUnicodeTranslation[165].UnicodeChar := 'Ζ';	HtmlUnicodeTranslation[165].NumericalCode := '&#918;';	HtmlUnicodeTranslation[165].LiteralCode := '&Zeta;';
  HtmlUnicodeTranslation[166].UnicodeChar := 'Η';	HtmlUnicodeTranslation[166].NumericalCode := '&#919;';	HtmlUnicodeTranslation[166].LiteralCode := '&Eta;';
  HtmlUnicodeTranslation[167].UnicodeChar := 'Θ';	HtmlUnicodeTranslation[167].NumericalCode := '&#920;';	HtmlUnicodeTranslation[167].LiteralCode := '&Theta;';
  HtmlUnicodeTranslation[168].UnicodeChar := 'Ι';	HtmlUnicodeTranslation[168].NumericalCode := '&#921;';	HtmlUnicodeTranslation[168].LiteralCode := '&Iota;';
  HtmlUnicodeTranslation[169].UnicodeChar := 'Κ';	HtmlUnicodeTranslation[169].NumericalCode := '&#922;';	HtmlUnicodeTranslation[169].LiteralCode := '&Kappa;';
  HtmlUnicodeTranslation[170].UnicodeChar := 'Λ';	HtmlUnicodeTranslation[170].NumericalCode := '&#923;';	HtmlUnicodeTranslation[170].LiteralCode := '&Lambda;';
  HtmlUnicodeTranslation[171].UnicodeChar := 'Μ';	HtmlUnicodeTranslation[171].NumericalCode := '&#924;';	HtmlUnicodeTranslation[171].LiteralCode := '&Mu;';
  HtmlUnicodeTranslation[172].UnicodeChar := 'Ν';	HtmlUnicodeTranslation[172].NumericalCode := '&#925;';	HtmlUnicodeTranslation[172].LiteralCode := '&Nu;';
  HtmlUnicodeTranslation[173].UnicodeChar := 'Ξ';	HtmlUnicodeTranslation[173].NumericalCode := '&#926;';	HtmlUnicodeTranslation[173].LiteralCode := '&Xi;';
  HtmlUnicodeTranslation[174].UnicodeChar := 'Ο';	HtmlUnicodeTranslation[174].NumericalCode := '&#927;';	HtmlUnicodeTranslation[174].LiteralCode := '&Omicron;';
  HtmlUnicodeTranslation[175].UnicodeChar := 'Π';	HtmlUnicodeTranslation[175].NumericalCode := '&#928;';	HtmlUnicodeTranslation[175].LiteralCode := '&Pi;';
  HtmlUnicodeTranslation[176].UnicodeChar := 'Ρ';	HtmlUnicodeTranslation[176].NumericalCode := '&#929;';	HtmlUnicodeTranslation[176].LiteralCode := '&Rho;';
  HtmlUnicodeTranslation[177].UnicodeChar := 'Σ';	HtmlUnicodeTranslation[177].NumericalCode := '&#931;';	HtmlUnicodeTranslation[177].LiteralCode := '&Sigma;';
  HtmlUnicodeTranslation[178].UnicodeChar := 'Τ';	HtmlUnicodeTranslation[178].NumericalCode := '&#932;';	HtmlUnicodeTranslation[178].LiteralCode := '&Tau;';
  HtmlUnicodeTranslation[179].UnicodeChar := 'Υ';	HtmlUnicodeTranslation[179].NumericalCode := '&#933;';	HtmlUnicodeTranslation[179].LiteralCode := '&Upsilon;';
  HtmlUnicodeTranslation[180].UnicodeChar := 'Φ';	HtmlUnicodeTranslation[180].NumericalCode := '&#934;';	HtmlUnicodeTranslation[180].LiteralCode := '&Phi;';
  HtmlUnicodeTranslation[181].UnicodeChar := 'Χ';	HtmlUnicodeTranslation[181].NumericalCode := '&#935;';	HtmlUnicodeTranslation[181].LiteralCode := '&Chi;';
  HtmlUnicodeTranslation[182].UnicodeChar := 'Ψ';	HtmlUnicodeTranslation[182].NumericalCode := '&#936;';	HtmlUnicodeTranslation[182].LiteralCode := '&Psi;';
  HtmlUnicodeTranslation[183].UnicodeChar := 'Ω';	HtmlUnicodeTranslation[183].NumericalCode := '&#937;';	HtmlUnicodeTranslation[183].LiteralCode := '&Omega;';
  HtmlUnicodeTranslation[184].UnicodeChar := 'α';	HtmlUnicodeTranslation[184].NumericalCode := '&#945;';	HtmlUnicodeTranslation[184].LiteralCode := '&alpha;';
  HtmlUnicodeTranslation[185].UnicodeChar := 'β';	HtmlUnicodeTranslation[185].NumericalCode := '&#946;';	HtmlUnicodeTranslation[185].LiteralCode := '&beta;';
  HtmlUnicodeTranslation[186].UnicodeChar := 'γ';	HtmlUnicodeTranslation[186].NumericalCode := '&#947;';	HtmlUnicodeTranslation[186].LiteralCode := '&gamma;';
  HtmlUnicodeTranslation[187].UnicodeChar := 'δ';	HtmlUnicodeTranslation[187].NumericalCode := '&#948;';	HtmlUnicodeTranslation[187].LiteralCode := '&delta;';
  HtmlUnicodeTranslation[188].UnicodeChar := 'ε';	HtmlUnicodeTranslation[188].NumericalCode := '&#949;';	HtmlUnicodeTranslation[188].LiteralCode := '&epsilon;';
  HtmlUnicodeTranslation[189].UnicodeChar := 'ζ';	HtmlUnicodeTranslation[189].NumericalCode := '&#950;';	HtmlUnicodeTranslation[189].LiteralCode := '&zeta;';
  HtmlUnicodeTranslation[190].UnicodeChar := 'η';	HtmlUnicodeTranslation[190].NumericalCode := '&#951;';	HtmlUnicodeTranslation[190].LiteralCode := '&eta;';
  HtmlUnicodeTranslation[191].UnicodeChar := 'θ';	HtmlUnicodeTranslation[191].NumericalCode := '&#952;';	HtmlUnicodeTranslation[191].LiteralCode := '&theta;';
  HtmlUnicodeTranslation[192].UnicodeChar := 'ι';	HtmlUnicodeTranslation[192].NumericalCode := '&#953;';	HtmlUnicodeTranslation[192].LiteralCode := '&iota;';
  HtmlUnicodeTranslation[193].UnicodeChar := 'κ';	HtmlUnicodeTranslation[193].NumericalCode := '&#954;';	HtmlUnicodeTranslation[193].LiteralCode := '&kappa;';
  HtmlUnicodeTranslation[194].UnicodeChar := 'λ';	HtmlUnicodeTranslation[194].NumericalCode := '&#955;';	HtmlUnicodeTranslation[194].LiteralCode := '&lambda;';
  HtmlUnicodeTranslation[195].UnicodeChar := 'μ';	HtmlUnicodeTranslation[195].NumericalCode := '&#956;';	HtmlUnicodeTranslation[195].LiteralCode := '&mu;';
  HtmlUnicodeTranslation[196].UnicodeChar := 'ν';	HtmlUnicodeTranslation[196].NumericalCode := '&#957;';	HtmlUnicodeTranslation[196].LiteralCode := '&nu;';
  HtmlUnicodeTranslation[197].UnicodeChar := 'ξ';	HtmlUnicodeTranslation[197].NumericalCode := '&#958;';	HtmlUnicodeTranslation[197].LiteralCode := '&xi;';
  HtmlUnicodeTranslation[198].UnicodeChar := 'ο';	HtmlUnicodeTranslation[198].NumericalCode := '&#959;';	HtmlUnicodeTranslation[198].LiteralCode := '&omicron;';
  HtmlUnicodeTranslation[199].UnicodeChar := 'π';	HtmlUnicodeTranslation[199].NumericalCode := '&#960;';	HtmlUnicodeTranslation[199].LiteralCode := '&pi;';
  HtmlUnicodeTranslation[200].UnicodeChar := 'ρ';	HtmlUnicodeTranslation[200].NumericalCode := '&#961;';	HtmlUnicodeTranslation[200].LiteralCode := '&rho;';
  HtmlUnicodeTranslation[201].UnicodeChar := 'ς';	HtmlUnicodeTranslation[201].NumericalCode := '&#962;';	HtmlUnicodeTranslation[201].LiteralCode := '&sigmaf;';
  HtmlUnicodeTranslation[202].UnicodeChar := 'σ';	HtmlUnicodeTranslation[202].NumericalCode := '&#963;';	HtmlUnicodeTranslation[202].LiteralCode := '&sigma;';
  HtmlUnicodeTranslation[203].UnicodeChar := 'τ';	HtmlUnicodeTranslation[203].NumericalCode := '&#964;';	HtmlUnicodeTranslation[203].LiteralCode := '&tau;';
  HtmlUnicodeTranslation[204].UnicodeChar := 'υ';	HtmlUnicodeTranslation[204].NumericalCode := '&#965;';	HtmlUnicodeTranslation[204].LiteralCode := '&upsilon;';
  HtmlUnicodeTranslation[205].UnicodeChar := 'φ';	HtmlUnicodeTranslation[205].NumericalCode := '&#966;';	HtmlUnicodeTranslation[205].LiteralCode := '&phi;';
  HtmlUnicodeTranslation[206].UnicodeChar := 'χ';	HtmlUnicodeTranslation[206].NumericalCode := '&#967;';	HtmlUnicodeTranslation[206].LiteralCode := '&chi;';
  HtmlUnicodeTranslation[207].UnicodeChar := 'ψ';	HtmlUnicodeTranslation[207].NumericalCode := '&#968;';	HtmlUnicodeTranslation[207].LiteralCode := '&psi;';
  HtmlUnicodeTranslation[208].UnicodeChar := 'ω';	HtmlUnicodeTranslation[208].NumericalCode := '&#969;';	HtmlUnicodeTranslation[208].LiteralCode := '&omega;';
  HtmlUnicodeTranslation[209].UnicodeChar := 'Ą';	HtmlUnicodeTranslation[209].NumericalCode := '&#260;';
  HtmlUnicodeTranslation[210].UnicodeChar := 'ą';	HtmlUnicodeTranslation[210].NumericalCode := '&#261;';
  HtmlUnicodeTranslation[211].UnicodeChar := 'Ć';	HtmlUnicodeTranslation[211].NumericalCode := '&#262;';
  HtmlUnicodeTranslation[212].UnicodeChar := 'ć';	HtmlUnicodeTranslation[212].NumericalCode := '&#263;';
  HtmlUnicodeTranslation[213].UnicodeChar := 'Č';	HtmlUnicodeTranslation[213].NumericalCode := '&#268;';
  HtmlUnicodeTranslation[214].UnicodeChar := 'č';	HtmlUnicodeTranslation[214].NumericalCode := '&#269;';
  HtmlUnicodeTranslation[215].UnicodeChar := 'Ę';	HtmlUnicodeTranslation[215].NumericalCode := '&#280;';
  HtmlUnicodeTranslation[216].UnicodeChar := 'ę';	HtmlUnicodeTranslation[216].NumericalCode := '&#281;';
  HtmlUnicodeTranslation[217].UnicodeChar := 'ě';	HtmlUnicodeTranslation[217].NumericalCode := '&#283;';
  HtmlUnicodeTranslation[218].UnicodeChar := 'Ł';	HtmlUnicodeTranslation[218].NumericalCode := '&#321;';
  HtmlUnicodeTranslation[219].UnicodeChar := 'ł';	HtmlUnicodeTranslation[219].NumericalCode := '&#322;';
  HtmlUnicodeTranslation[220].UnicodeChar := 'Ń';	HtmlUnicodeTranslation[220].NumericalCode := '&#323;';
  HtmlUnicodeTranslation[221].UnicodeChar := 'ń';	HtmlUnicodeTranslation[221].NumericalCode := '&#324;';
  HtmlUnicodeTranslation[222].UnicodeChar := 'Ř';	HtmlUnicodeTranslation[222].NumericalCode := '&#344;';
  HtmlUnicodeTranslation[223].UnicodeChar := 'ř';	HtmlUnicodeTranslation[223].NumericalCode := '&#345;';
  HtmlUnicodeTranslation[224].UnicodeChar := 'Š';	HtmlUnicodeTranslation[224].NumericalCode := '&#352;';
  HtmlUnicodeTranslation[225].UnicodeChar := 'š';	HtmlUnicodeTranslation[225].NumericalCode := '&#353;';
  HtmlUnicodeTranslation[226].UnicodeChar := 'Ś';	HtmlUnicodeTranslation[226].NumericalCode := '&#346;';
  HtmlUnicodeTranslation[227].UnicodeChar := 'ś';	HtmlUnicodeTranslation[227].NumericalCode := '&#347;';
  HtmlUnicodeTranslation[228].UnicodeChar := 'Ź';	HtmlUnicodeTranslation[228].NumericalCode := '&#377;';
  HtmlUnicodeTranslation[229].UnicodeChar := 'ź';	HtmlUnicodeTranslation[229].NumericalCode := '&#378;';
  HtmlUnicodeTranslation[230].UnicodeChar := 'Ż';	HtmlUnicodeTranslation[230].NumericalCode := '&#379;';
  HtmlUnicodeTranslation[231].UnicodeChar := 'ż';	HtmlUnicodeTranslation[231].NumericalCode := '&#380;';
  HtmlUnicodeTranslation[232].UnicodeChar := 'Ž';	HtmlUnicodeTranslation[232].NumericalCode := '&#381;';
  HtmlUnicodeTranslation[233].UnicodeChar := 'ž';	HtmlUnicodeTranslation[233].NumericalCode := '&#382;';
  HtmlUnicodeTranslation[234].UnicodeChar := 'Ā';	HtmlUnicodeTranslation[234].NumericalCode := '&#256;';
  HtmlUnicodeTranslation[235].UnicodeChar := 'ā';	HtmlUnicodeTranslation[235].NumericalCode := '&#257;';
  HtmlUnicodeTranslation[236].UnicodeChar := 'ḍ';	HtmlUnicodeTranslation[236].NumericalCode := '&#7693;';
  HtmlUnicodeTranslation[237].UnicodeChar := 'ē';	HtmlUnicodeTranslation[237].NumericalCode := '&275;';
  HtmlUnicodeTranslation[238].UnicodeChar := 'ğ';	HtmlUnicodeTranslation[238].NumericalCode := '&#287;';
  HtmlUnicodeTranslation[239].UnicodeChar := 'Ḥ';	HtmlUnicodeTranslation[239].NumericalCode := '&#7716;';
  HtmlUnicodeTranslation[240].UnicodeChar := 'ḥ';	HtmlUnicodeTranslation[240].NumericalCode := '&#7717;';
  HtmlUnicodeTranslation[241].UnicodeChar := 'Ī';	HtmlUnicodeTranslation[241].NumericalCode := '&#298;';
  HtmlUnicodeTranslation[242].UnicodeChar := 'ī';	HtmlUnicodeTranslation[242].NumericalCode := '&#299;';
  HtmlUnicodeTranslation[243].UnicodeChar := 'ṃ';	HtmlUnicodeTranslation[243].NumericalCode := '&#7747;';
  HtmlUnicodeTranslation[244].UnicodeChar := 'Ṁ';	HtmlUnicodeTranslation[244].NumericalCode := '&#7744;';
  HtmlUnicodeTranslation[245].UnicodeChar := 'ṁ';	HtmlUnicodeTranslation[245].NumericalCode := '&#7745;';
  HtmlUnicodeTranslation[246].UnicodeChar := 'ṇ';	HtmlUnicodeTranslation[246].NumericalCode := '&#7751;';
  HtmlUnicodeTranslation[247].UnicodeChar := 'ṅ';	HtmlUnicodeTranslation[247].NumericalCode := '&#7749;';
  HtmlUnicodeTranslation[248].UnicodeChar := 'ō';	HtmlUnicodeTranslation[248].NumericalCode := '&#333;';
  HtmlUnicodeTranslation[249].UnicodeChar := 'ṛ';	HtmlUnicodeTranslation[249].NumericalCode := '&#7771;';
  HtmlUnicodeTranslation[250].UnicodeChar := 'Ś';	HtmlUnicodeTranslation[250].NumericalCode := '&#346;';
  HtmlUnicodeTranslation[251].UnicodeChar := 'ś';	HtmlUnicodeTranslation[251].NumericalCode := '&#347;';
  HtmlUnicodeTranslation[252].UnicodeChar := 'Ṣ';	HtmlUnicodeTranslation[252].NumericalCode := '&#7778;';
  HtmlUnicodeTranslation[253].UnicodeChar := 'ṣ';	HtmlUnicodeTranslation[253].NumericalCode := '&#7779;';
  HtmlUnicodeTranslation[254].UnicodeChar := 'ṭ';	HtmlUnicodeTranslation[254].NumericalCode := '&#7789;';
  HtmlUnicodeTranslation[255].UnicodeChar := 'Ṭ';	HtmlUnicodeTranslation[255].NumericalCode := '&#7788;';
  HtmlUnicodeTranslation[256].UnicodeChar := 'ū';	HtmlUnicodeTranslation[256].NumericalCode := '&#363;';
  HtmlUnicodeTranslation[257].UnicodeChar := 'ŭ';	HtmlUnicodeTranslation[257].NumericalCode := '&#365;';
  HtmlUnicodeTranslation[258].UnicodeChar := 'ǔ';	HtmlUnicodeTranslation[258].NumericalCode := '&#468;';
  HtmlUnicodeTranslation[259].UnicodeChar := 'Ṽ';	HtmlUnicodeTranslation[259].NumericalCode := '&#7804;';
  HtmlUnicodeTranslation[260].UnicodeChar := 'ẓ';	HtmlUnicodeTranslation[260].NumericalCode := '&#7827;';
  HtmlUnicodeTranslation[261].UnicodeChar := '"';	HtmlUnicodeTranslation[261].NumericalCode := '&#34;';	HtmlUnicodeTranslation[261].LiteralCode := '&quot;';
  HtmlUnicodeTranslation[262].UnicodeChar := '‘';	HtmlUnicodeTranslation[262].NumericalCode := '&#8216;';	HtmlUnicodeTranslation[262].LiteralCode := '&lsquo;';
  HtmlUnicodeTranslation[263].UnicodeChar := '’';	HtmlUnicodeTranslation[263].NumericalCode := '&#8217;';	HtmlUnicodeTranslation[263].LiteralCode := '&rsquo;';
  HtmlUnicodeTranslation[264].UnicodeChar := '“';	HtmlUnicodeTranslation[264].NumericalCode := '&#8220;';	HtmlUnicodeTranslation[264].LiteralCode := '&ldquo;';
  HtmlUnicodeTranslation[265].UnicodeChar := '”';	HtmlUnicodeTranslation[265].NumericalCode := '&#8221;';	HtmlUnicodeTranslation[265].LiteralCode := '&rdquo;';
  HtmlUnicodeTranslation[266].UnicodeChar := '–';	HtmlUnicodeTranslation[266].NumericalCode := '&#8211;';	HtmlUnicodeTranslation[266].LiteralCode := '&ndash;';
  HtmlUnicodeTranslation[267].UnicodeChar := '—';	HtmlUnicodeTranslation[267].NumericalCode := '&#8212;';	HtmlUnicodeTranslation[267].LiteralCode := '&mdash;';
  HtmlUnicodeTranslation[268].UnicodeChar := '…';	HtmlUnicodeTranslation[268].NumericalCode := '&#8230;';	HtmlUnicodeTranslation[268].LiteralCode := '&hellip;';
  HtmlUnicodeTranslation[269].UnicodeChar := '•';	HtmlUnicodeTranslation[269].NumericalCode := '&#8226;';	HtmlUnicodeTranslation[269].LiteralCode := '&bull;';
  HtmlUnicodeTranslation[270].UnicodeChar := '§';	HtmlUnicodeTranslation[270].NumericalCode := '&#167;';	HtmlUnicodeTranslation[270].LiteralCode := '&sect;';
  HtmlUnicodeTranslation[271].UnicodeChar := '¶';	HtmlUnicodeTranslation[271].NumericalCode := '&#182;';	HtmlUnicodeTranslation[271].LiteralCode := '&para;';
  HtmlUnicodeTranslation[272].UnicodeChar := '«';	HtmlUnicodeTranslation[272].NumericalCode := '&#171;';	HtmlUnicodeTranslation[272].LiteralCode := '&laquo;';
  HtmlUnicodeTranslation[273].UnicodeChar := '»';	HtmlUnicodeTranslation[273].NumericalCode := '&#187;';	HtmlUnicodeTranslation[273].LiteralCode := '&raquo;';
  HtmlUnicodeTranslation[274].UnicodeChar := '‹';	HtmlUnicodeTranslation[274].NumericalCode := '&#8249;';	HtmlUnicodeTranslation[274].LiteralCode := '&lsaquo;';
  HtmlUnicodeTranslation[275].UnicodeChar := '›';	HtmlUnicodeTranslation[275].NumericalCode := '&#8250;';	HtmlUnicodeTranslation[275].LiteralCode := '&rsaquo;';
  HtmlUnicodeTranslation[276].UnicodeChar := '⟨';	HtmlUnicodeTranslation[276].NumericalCode := '&#10216;';
  HtmlUnicodeTranslation[277].UnicodeChar := '⟩';	HtmlUnicodeTranslation[277].NumericalCode := '&#10217;';
  HtmlUnicodeTranslation[278].UnicodeChar := '¡';	HtmlUnicodeTranslation[278].NumericalCode := '&#161;';	HtmlUnicodeTranslation[278].LiteralCode := '&iexcl;';
  HtmlUnicodeTranslation[279].UnicodeChar := '¿';	HtmlUnicodeTranslation[279].NumericalCode := '&#191;';	HtmlUnicodeTranslation[279].LiteralCode := '&iquest;';
  HtmlUnicodeTranslation[280].UnicodeChar := '‚';	HtmlUnicodeTranslation[280].NumericalCode := '&#8218;';	HtmlUnicodeTranslation[280].LiteralCode := '&sbquo;';
  HtmlUnicodeTranslation[281].UnicodeChar := '„';	HtmlUnicodeTranslation[281].NumericalCode := '&#8222;';	HtmlUnicodeTranslation[281].LiteralCode := '&bdquo;';
  HtmlUnicodeTranslation[282].UnicodeChar := '†';	HtmlUnicodeTranslation[282].NumericalCode := '&#8224;';	HtmlUnicodeTranslation[282].LiteralCode := '&dagger;';
  HtmlUnicodeTranslation[283].UnicodeChar := '‡';	HtmlUnicodeTranslation[283].NumericalCode := '&#8225;';	HtmlUnicodeTranslation[283].LiteralCode := '&Dagger;';
  HtmlUnicodeTranslation[288].UnicodeChar := '⌈';	HtmlUnicodeTranslation[288].NumericalCode := '&#8968;';	HtmlUnicodeTranslation[288].LiteralCode := '&lceil;';
  HtmlUnicodeTranslation[289].UnicodeChar := '⌉';	HtmlUnicodeTranslation[289].NumericalCode := '&#8969;';	HtmlUnicodeTranslation[289].LiteralCode := '&rceil;';
  HtmlUnicodeTranslation[290].UnicodeChar := '⌊';	HtmlUnicodeTranslation[290].NumericalCode := '&#8970;';	HtmlUnicodeTranslation[290].LiteralCode := '&lfloor;';
  HtmlUnicodeTranslation[291].UnicodeChar := '⌋';	HtmlUnicodeTranslation[291].NumericalCode := '&#8971;';	HtmlUnicodeTranslation[291].LiteralCode := '&rfloor;';
  HtmlUnicodeTranslation[292].UnicodeChar := '⟦';	HtmlUnicodeTranslation[292].NumericalCode := '&#10214;';
  HtmlUnicodeTranslation[293].UnicodeChar := '⟧';	HtmlUnicodeTranslation[293].NumericalCode := '&#10215;';
  HtmlUnicodeTranslation[294].UnicodeChar := '´';	HtmlUnicodeTranslation[294].NumericalCode := '&#180;';	HtmlUnicodeTranslation[294].LiteralCode := '&acute;';
  HtmlUnicodeTranslation[295].UnicodeChar := '¨';	HtmlUnicodeTranslation[295].NumericalCode := '&#168;';	HtmlUnicodeTranslation[295].LiteralCode := '&uml;';
  HtmlUnicodeTranslation[296].UnicodeChar := '¯';	HtmlUnicodeTranslation[296].NumericalCode := '&#175;';	HtmlUnicodeTranslation[296].LiteralCode := '&macr;';
  HtmlUnicodeTranslation[297].UnicodeChar := '¸';	HtmlUnicodeTranslation[297].NumericalCode := '&#184;';	HtmlUnicodeTranslation[297].LiteralCode := '&cedil;';
  HtmlUnicodeTranslation[298].UnicodeChar := 'ˆ';	HtmlUnicodeTranslation[298].NumericalCode := '&#710;';	HtmlUnicodeTranslation[298].LiteralCode := '&circ;';
  HtmlUnicodeTranslation[299].UnicodeChar := '˜';	HtmlUnicodeTranslation[299].NumericalCode := '&#732;';	HtmlUnicodeTranslation[299].LiteralCode := '&tilde;';
  HtmlUnicodeTranslation[300].UnicodeChar := 'ª';	HtmlUnicodeTranslation[300].NumericalCode := '&#170;';	HtmlUnicodeTranslation[300].LiteralCode := '&ordf;';
  HtmlUnicodeTranslation[301].UnicodeChar := 'º';	HtmlUnicodeTranslation[301].NumericalCode := '&#186;';	HtmlUnicodeTranslation[301].LiteralCode := '&ordm;';
  HtmlUnicodeTranslation[302].UnicodeChar := '¦';	HtmlUnicodeTranslation[302].NumericalCode := '&#166;';	HtmlUnicodeTranslation[302].LiteralCode := '&brvbar;';
  HtmlUnicodeTranslation[303].UnicodeChar := '©';	HtmlUnicodeTranslation[303].NumericalCode := '&#169;';	HtmlUnicodeTranslation[303].LiteralCode := '&copy;';
  HtmlUnicodeTranslation[304].UnicodeChar := '®';	HtmlUnicodeTranslation[304].NumericalCode := '&#174;';	HtmlUnicodeTranslation[304].LiteralCode := '&reg;';
  HtmlUnicodeTranslation[305].UnicodeChar := '™';	HtmlUnicodeTranslation[305].NumericalCode := '&#8482;';	HtmlUnicodeTranslation[305].LiteralCode := '&trade;';
  HtmlUnicodeTranslation[306].UnicodeChar := 'µ';	HtmlUnicodeTranslation[306].NumericalCode := '&#181;';	HtmlUnicodeTranslation[306].LiteralCode := '&micro;';
  HtmlUnicodeTranslation[307].UnicodeChar := '¢';	HtmlUnicodeTranslation[307].NumericalCode := '&#162;';	HtmlUnicodeTranslation[307].LiteralCode := '&cent;';
  HtmlUnicodeTranslation[308].UnicodeChar := '£';	HtmlUnicodeTranslation[308].NumericalCode := '&#163;';	HtmlUnicodeTranslation[308].LiteralCode := '&pound;';
  HtmlUnicodeTranslation[309].UnicodeChar := '¤';	HtmlUnicodeTranslation[309].NumericalCode := '&#164;';	HtmlUnicodeTranslation[309].LiteralCode := '&curren;';
  HtmlUnicodeTranslation[310].UnicodeChar := '¥';	HtmlUnicodeTranslation[310].NumericalCode := '&#y165;';	HtmlUnicodeTranslation[310].LiteralCode := '&yen;';
  HtmlUnicodeTranslation[311].UnicodeChar := '€';	HtmlUnicodeTranslation[311].NumericalCode := '&#8364;';	HtmlUnicodeTranslation[311].LiteralCode := '&euro;';
  HtmlUnicodeTranslation[312].UnicodeChar := '♠';	HtmlUnicodeTranslation[312].NumericalCode := '&#9824;';	HtmlUnicodeTranslation[312].LiteralCode := '&spades;';
  HtmlUnicodeTranslation[313].UnicodeChar := '♣';	HtmlUnicodeTranslation[313].NumericalCode := '&#9827;';	HtmlUnicodeTranslation[313].LiteralCode := '&clubs;';
  HtmlUnicodeTranslation[314].UnicodeChar := '♥';	HtmlUnicodeTranslation[314].NumericalCode := '&#9829;';	HtmlUnicodeTranslation[314].LiteralCode := '&hearts;';
  HtmlUnicodeTranslation[315].UnicodeChar := '♦';	HtmlUnicodeTranslation[315].NumericalCode := '&#9830;';	HtmlUnicodeTranslation[315].LiteralCode := '&diams;';


  UrlTranslation[0].UnicodeChar := '%'; UrlTranslation[0].Translation := '%25'; //Must be first
  UrlTranslation[1].UnicodeChar := '!'; UrlTranslation[1].Translation := '%21';
  UrlTranslation[2].UnicodeChar := '"'; UrlTranslation[2].Translation := '%22';
  UrlTranslation[3].UnicodeChar := '#'; UrlTranslation[3].Translation := '%23';
  UrlTranslation[4].UnicodeChar := '$'; UrlTranslation[4].Translation := '%24';
  UrlTranslation[5].UnicodeChar := ' '; UrlTranslation[5].Translation := '%20';
  UrlTranslation[6].UnicodeChar := '&'; UrlTranslation[6].Translation := '%26';
  UrlTranslation[7].UnicodeChar := ''''; UrlTranslation[7].Translation := '%27';
  UrlTranslation[8].UnicodeChar := '('; UrlTranslation[8].Translation := '%28';
  UrlTranslation[9].UnicodeChar := ')'; UrlTranslation[9].Translation := '%29';
  UrlTranslation[10].UnicodeChar := '*'; UrlTranslation[10].Translation := '%2A';
  UrlTranslation[11].UnicodeChar := '+'; UrlTranslation[11].Translation := '%2B';
  UrlTranslation[12].UnicodeChar := ','; UrlTranslation[12].Translation := '%2C';
  UrlTranslation[13].UnicodeChar := '-'; UrlTranslation[13].Translation := '%2D';
  UrlTranslation[14].UnicodeChar := '.'; UrlTranslation[14].Translation := '%2E';
  UrlTranslation[15].UnicodeChar := '/'; UrlTranslation[15].Translation := '%2F';
  UrlTranslation[16].UnicodeChar := ':'; UrlTranslation[16].Translation := '%3A';
  UrlTranslation[17].UnicodeChar := '<'; UrlTranslation[17].Translation := '%3C';
  UrlTranslation[18].UnicodeChar := '='; UrlTranslation[18].Translation := '%3D';
  UrlTranslation[19].UnicodeChar := '>'; UrlTranslation[19].Translation := '%3E';
  UrlTranslation[20].UnicodeChar := '?'; UrlTranslation[20].Translation := '%3F';
  UrlTranslation[21].UnicodeChar := '@'; UrlTranslation[21].Translation := '%40';
  UrlTranslation[22].UnicodeChar := '['; UrlTranslation[22].Translation := '%5B';
  UrlTranslation[23].UnicodeChar := '\'; UrlTranslation[23].Translation := '%5C';
  UrlTranslation[24].UnicodeChar := ']'; UrlTranslation[24].Translation := '%5D';
  UrlTranslation[25].UnicodeChar := '^'; UrlTranslation[25].Translation := '%5E';
  UrlTranslation[26].UnicodeChar := '_'; UrlTranslation[26].Translation := '%5F';
  UrlTranslation[27].UnicodeChar := '`'; UrlTranslation[27].Translation := '%60';
  UrlTranslation[28].UnicodeChar := '{'; UrlTranslation[28].Translation := '%7B';
  UrlTranslation[29].UnicodeChar := '|'; UrlTranslation[29].Translation := '%7C';
  UrlTranslation[30].UnicodeChar := '}'; UrlTranslation[30].Translation := '%7D';
  UrlTranslation[31].UnicodeChar := '~'; UrlTranslation[31].Translation := '%7E';
  UrlTranslation[32].UnicodeChar := ' '; UrlTranslation[32].Translation := '%7F';
  UrlTranslation[33].UnicodeChar := '`'; UrlTranslation[33].Translation := '%E2%82%AC';
  UrlTranslation[34].UnicodeChar := ''; UrlTranslation[34].Translation := '%81';
  UrlTranslation[35].UnicodeChar := '‚'; UrlTranslation[35].Translation := '%E2%80%9A';
  UrlTranslation[36].UnicodeChar := 'ƒ'; UrlTranslation[36].Translation := '%C6%92';
  UrlTranslation[37].UnicodeChar := '„'; UrlTranslation[37].Translation := '%E2%80%9E';
  UrlTranslation[38].UnicodeChar := '…'; UrlTranslation[38].Translation := '%E2%80%A6';
  UrlTranslation[39].UnicodeChar := '†'; UrlTranslation[39].Translation := '%E2%80%A0';
  UrlTranslation[40].UnicodeChar := '‡'; UrlTranslation[40].Translation := '%E2%80%A1';
  UrlTranslation[41].UnicodeChar := 'ˆ'; UrlTranslation[41].Translation := '%CB%86';
  UrlTranslation[42].UnicodeChar := '‰'; UrlTranslation[42].Translation := '%E2%80%B0';
  UrlTranslation[43].UnicodeChar := 'Š'; UrlTranslation[43].Translation := '%C5%A0';
  UrlTranslation[44].UnicodeChar := '‹'; UrlTranslation[44].Translation := '%E2%80%B9';
  UrlTranslation[45].UnicodeChar := 'Œ'; UrlTranslation[45].Translation := '%C5%92';
  UrlTranslation[46].UnicodeChar := ''; UrlTranslation[46].Translation := '%C5%8D';
  UrlTranslation[47].UnicodeChar := 'Ž'; UrlTranslation[47].Translation := '%C5%BD';
  UrlTranslation[48].UnicodeChar := ''; UrlTranslation[48].Translation := '%8F';
  UrlTranslation[49].UnicodeChar := ''; UrlTranslation[49].Translation := '%C2%90';
  UrlTranslation[50].UnicodeChar := '‘'; UrlTranslation[50].Translation := '%E2%80%98';
  UrlTranslation[51].UnicodeChar := '’'; UrlTranslation[51].Translation := '%E2%80%99';
  UrlTranslation[52].UnicodeChar := '“'; UrlTranslation[52].Translation := '%E2%80%9C';
  UrlTranslation[53].UnicodeChar := '”'; UrlTranslation[53].Translation := '%E2%80%9D';
  UrlTranslation[54].UnicodeChar := '•'; UrlTranslation[54].Translation := '%E2%80%A2';
  UrlTranslation[55].UnicodeChar := '–'; UrlTranslation[55].Translation := '%E2%80%93';
  UrlTranslation[56].UnicodeChar := '—'; UrlTranslation[56].Translation := '%E2%80%94';
  UrlTranslation[57].UnicodeChar := '˜'; UrlTranslation[57].Translation := '%CB%9C';
  UrlTranslation[58].UnicodeChar := '™'; UrlTranslation[58].Translation := '%E2%84';
  UrlTranslation[59].UnicodeChar := 'š'; UrlTranslation[59].Translation := '%C5%A1';
  UrlTranslation[60].UnicodeChar := '›'; UrlTranslation[60].Translation := '%E2%80';
  UrlTranslation[61].UnicodeChar := 'œ'; UrlTranslation[61].Translation := '%C5%93';
  UrlTranslation[62].UnicodeChar := ''; UrlTranslation[62].Translation := '%9D';
  UrlTranslation[63].UnicodeChar := 'ž'; UrlTranslation[63].Translation := '%C5%BE';
  UrlTranslation[64].UnicodeChar := 'Ÿ'; UrlTranslation[64].Translation := '%C5%B8';
  UrlTranslation[65].UnicodeChar := ' '; UrlTranslation[65].Translation := '%C2%A0';
  UrlTranslation[66].UnicodeChar := '¡'; UrlTranslation[66].Translation := '%C2%A1';
  UrlTranslation[67].UnicodeChar := '¢'; UrlTranslation[67].Translation := '%C2%A2';
  UrlTranslation[68].UnicodeChar := '£'; UrlTranslation[68].Translation := '%C2%A3';
  UrlTranslation[69].UnicodeChar := '¤'; UrlTranslation[69].Translation := '%C2%A4';
  UrlTranslation[70].UnicodeChar := '¥'; UrlTranslation[70].Translation := '%C2%A5';
  UrlTranslation[71].UnicodeChar := '¦'; UrlTranslation[71].Translation := '%C2%A6';
  UrlTranslation[72].UnicodeChar := '§'; UrlTranslation[72].Translation := '%C2%A7';
  UrlTranslation[73].UnicodeChar := '¨'; UrlTranslation[73].Translation := '%C2%A8';
  UrlTranslation[74].UnicodeChar := '©'; UrlTranslation[74].Translation := '%C2%A9';
  UrlTranslation[75].UnicodeChar := 'ª'; UrlTranslation[75].Translation := '%C2%AA';
  UrlTranslation[76].UnicodeChar := '«'; UrlTranslation[76].Translation := '%C2%AB';
  UrlTranslation[77].UnicodeChar := '¬'; UrlTranslation[77].Translation := '%C2%AC';
  UrlTranslation[78].UnicodeChar := '®'; UrlTranslation[78].Translation := '%C2%AE';
  UrlTranslation[79].UnicodeChar := '¯'; UrlTranslation[79].Translation := '%C2%AF';
  UrlTranslation[80].UnicodeChar := '°'; UrlTranslation[80].Translation := '%C2%B0';
  UrlTranslation[81].UnicodeChar := '±'; UrlTranslation[81].Translation := '%C2%B1';
  UrlTranslation[82].UnicodeChar := '²'; UrlTranslation[82].Translation := '%C2%B2';
  UrlTranslation[83].UnicodeChar := '³'; UrlTranslation[83].Translation := '%C2%B3';
  UrlTranslation[84].UnicodeChar := '´'; UrlTranslation[84].Translation := '%C2%B4';
  UrlTranslation[85].UnicodeChar := 'µ'; UrlTranslation[85].Translation := '%C2%B5';
  UrlTranslation[86].UnicodeChar := '¶'; UrlTranslation[86].Translation := '%C2%B6';
  UrlTranslation[87].UnicodeChar := '·'; UrlTranslation[87].Translation := '%C2%B7';
  UrlTranslation[88].UnicodeChar := '¸'; UrlTranslation[88].Translation := '%C2%B8';
  UrlTranslation[89].UnicodeChar := '¹'; UrlTranslation[89].Translation := '%C2%B9';
  UrlTranslation[90].UnicodeChar := 'º'; UrlTranslation[90].Translation := '%C2%BA';
  UrlTranslation[91].UnicodeChar := '»'; UrlTranslation[91].Translation := '%C2%BB';
  UrlTranslation[92].UnicodeChar := '¼'; UrlTranslation[92].Translation := '%C2%BC';
  UrlTranslation[93].UnicodeChar := '½'; UrlTranslation[93].Translation := '%C2%BD';
  UrlTranslation[94].UnicodeChar := '¾'; UrlTranslation[94].Translation := '%C2%BE';
  UrlTranslation[95].UnicodeChar := '¿'; UrlTranslation[95].Translation := '%C2%BF';
  UrlTranslation[96].UnicodeChar := 'À'; UrlTranslation[96].Translation := '%C3%80';
  UrlTranslation[97].UnicodeChar := 'Á'; UrlTranslation[97].Translation := '%C3%81';
  UrlTranslation[98].UnicodeChar := 'Â'; UrlTranslation[98].Translation := '%C3%82';
  UrlTranslation[99].UnicodeChar := 'Ã'; UrlTranslation[99].Translation := '%C3%83';
  UrlTranslation[100].UnicodeChar := 'Ä'; UrlTranslation[100].Translation := '%C3%84';
  UrlTranslation[101].UnicodeChar := 'Å'; UrlTranslation[101].Translation := '%C3%85';
  UrlTranslation[102].UnicodeChar := 'Æ'; UrlTranslation[102].Translation := '%C3%86';
  UrlTranslation[103].UnicodeChar := 'Ç'; UrlTranslation[103].Translation := '%C3%87';
  UrlTranslation[104].UnicodeChar := 'È'; UrlTranslation[104].Translation := '%C3%88';
  UrlTranslation[105].UnicodeChar := 'É'; UrlTranslation[105].Translation := '%C3%89';
  UrlTranslation[106].UnicodeChar := 'Ê'; UrlTranslation[106].Translation := '%C3%8A';
  UrlTranslation[107].UnicodeChar := 'Ë'; UrlTranslation[107].Translation := '%C3%8B';
  UrlTranslation[108].UnicodeChar := 'Ì'; UrlTranslation[108].Translation := '%C3%8C';
  UrlTranslation[109].UnicodeChar := 'Í'; UrlTranslation[109].Translation := '%C3%8D';
  UrlTranslation[110].UnicodeChar := 'Î'; UrlTranslation[110].Translation := '%C3%8E';
  UrlTranslation[111].UnicodeChar := 'Ï'; UrlTranslation[111].Translation := '%C3%8F';
  UrlTranslation[112].UnicodeChar := 'Ð'; UrlTranslation[112].Translation := '%C3%90';
  UrlTranslation[113].UnicodeChar := 'Ñ'; UrlTranslation[113].Translation := '%C3%91';
  UrlTranslation[114].UnicodeChar := 'Ò'; UrlTranslation[114].Translation := '%C3%92';
  UrlTranslation[115].UnicodeChar := 'Ó'; UrlTranslation[115].Translation := '%C3%93';
  UrlTranslation[116].UnicodeChar := 'Ô'; UrlTranslation[116].Translation := '%C3%94';
  UrlTranslation[117].UnicodeChar := 'Õ'; UrlTranslation[117].Translation := '%C3%95';
  UrlTranslation[118].UnicodeChar := 'Ö'; UrlTranslation[118].Translation := '%C3%96';
  UrlTranslation[119].UnicodeChar := '×'; UrlTranslation[119].Translation := '%C3%97';
  UrlTranslation[120].UnicodeChar := 'Ø'; UrlTranslation[120].Translation := '%C3%98';
  UrlTranslation[121].UnicodeChar := 'Ù'; UrlTranslation[121].Translation := '%C3%99';
  UrlTranslation[122].UnicodeChar := 'Ú'; UrlTranslation[122].Translation := '%C3%9A';
  UrlTranslation[123].UnicodeChar := 'Û'; UrlTranslation[123].Translation := '%C3%9B';
  UrlTranslation[124].UnicodeChar := 'Ü'; UrlTranslation[124].Translation := '%C3%9C';
  UrlTranslation[125].UnicodeChar := 'Ý'; UrlTranslation[125].Translation := '%C3%9D';
  UrlTranslation[126].UnicodeChar := 'Þ'; UrlTranslation[126].Translation := '%C3%9E';
  UrlTranslation[127].UnicodeChar := 'ß'; UrlTranslation[127].Translation := '%C3%9F';
  UrlTranslation[128].UnicodeChar := 'à'; UrlTranslation[128].Translation := '%C3%A0';
  UrlTranslation[129].UnicodeChar := 'á'; UrlTranslation[129].Translation := '%C3%A1';
  UrlTranslation[130].UnicodeChar := 'â'; UrlTranslation[130].Translation := '%C3%A2';
  UrlTranslation[131].UnicodeChar := 'ã'; UrlTranslation[131].Translation := '%C3%A3';
  UrlTranslation[132].UnicodeChar := 'ä'; UrlTranslation[132].Translation := '%C3%A4';
  UrlTranslation[133].UnicodeChar := 'å'; UrlTranslation[133].Translation := '%C3%A5';
  UrlTranslation[134].UnicodeChar := 'æ'; UrlTranslation[134].Translation := '%C3%A6';
  UrlTranslation[135].UnicodeChar := 'ç'; UrlTranslation[135].Translation := '%C3%A7';
  UrlTranslation[136].UnicodeChar := 'è'; UrlTranslation[136].Translation := '%C3%A8';
  UrlTranslation[137].UnicodeChar := 'é'; UrlTranslation[137].Translation := '%C3%A9';
  UrlTranslation[138].UnicodeChar := 'ê'; UrlTranslation[138].Translation := '%C3%AA';
  UrlTranslation[139].UnicodeChar := 'ë'; UrlTranslation[139].Translation := '%C3%AB';
  UrlTranslation[140].UnicodeChar := 'ì'; UrlTranslation[140].Translation := '%C3%AC';
  UrlTranslation[141].UnicodeChar := 'í'; UrlTranslation[141].Translation := '%C3%AD';
  UrlTranslation[142].UnicodeChar := 'î'; UrlTranslation[142].Translation := '%C3%AE';
  UrlTranslation[143].UnicodeChar := 'ï'; UrlTranslation[143].Translation := '%C3%AF';
  UrlTranslation[144].UnicodeChar := 'ð'; UrlTranslation[144].Translation := '%C3%B0';
  UrlTranslation[145].UnicodeChar := 'ñ'; UrlTranslation[145].Translation := '%C3%B1';
  UrlTranslation[146].UnicodeChar := 'ò'; UrlTranslation[146].Translation := '%C3%B2';
  UrlTranslation[147].UnicodeChar := 'ó'; UrlTranslation[147].Translation := '%C3%B3';
  UrlTranslation[148].UnicodeChar := 'ô'; UrlTranslation[148].Translation := '%C3%B4';
  UrlTranslation[149].UnicodeChar := 'õ'; UrlTranslation[149].Translation := '%C3%B5';
  UrlTranslation[150].UnicodeChar := 'ö'; UrlTranslation[150].Translation := '%C3%B6';
  UrlTranslation[151].UnicodeChar := '÷'; UrlTranslation[151].Translation := '%C3%B7';
  UrlTranslation[152].UnicodeChar := 'ø'; UrlTranslation[152].Translation := '%C3%B8';
  UrlTranslation[153].UnicodeChar := 'ù'; UrlTranslation[153].Translation := '%C3%B9';
  UrlTranslation[154].UnicodeChar := 'ú'; UrlTranslation[154].Translation := '%C3%BA';
  UrlTranslation[155].UnicodeChar := 'û'; UrlTranslation[155].Translation := '%C3%BB';
  UrlTranslation[156].UnicodeChar := 'ü'; UrlTranslation[156].Translation := '%C3%BC';
  UrlTranslation[157].UnicodeChar := 'ý'; UrlTranslation[157].Translation := '%C3%BD';
  UrlTranslation[158].UnicodeChar := 'þ'; UrlTranslation[158].Translation := '%C3%BE';
  UrlTranslation[159].UnicodeChar := 'ÿ'; UrlTranslation[159].Translation := '%C3%BF';





end.
