unit NumeralSystemConvert;

interface

type
  TNumeralSystemBase = 2..64;

function ConvertNumeralSystem(i: Int64; const Base: TNumeralSystemBase = 64):
    string; overload;
function ConvertNumeralSystem(s: string; const Base: TNumeralSystemBase = 64):
    Int64; overload;

implementation

uses
  SysUtils;

var
  DigitChars: array[0..63] of Char;
  DigitCharsLookup: array [0..122] of Byte;
  i: Integer;
  Initialized: string;

procedure InitializeArrays();
begin
  if (Initialized = '') then
  begin
    DigitChars[0] := '0';
    DigitChars[1] := '1';
    DigitChars[2] := '2';
    DigitChars[3] := '3';
    DigitChars[4] := '4';
    DigitChars[5] := '5';
    DigitChars[6] := '6';
    DigitChars[7] := '7';
    DigitChars[8] := '8';
    DigitChars[9] := '9';


    DigitChars[10] := 'A';
    DigitChars[11] := 'B';
    DigitChars[12] := 'C';
    DigitChars[13] := 'D';
    DigitChars[14] := 'E';
    DigitChars[15] := 'F';
    DigitChars[16] := 'G';
    DigitChars[17] := 'H';
    DigitChars[18] := 'I';
    DigitChars[19] := 'J';

    DigitChars[20] := 'K';
    DigitChars[21] := 'L';
    DigitChars[22] := 'M';
    DigitChars[23] := 'N';
    DigitChars[24] := 'O';
    DigitChars[25] := 'P';
    DigitChars[26] := 'Q';
    DigitChars[27] := 'R';
    DigitChars[28] := 'S';
    DigitChars[29] := 'T';

    DigitChars[30] := 'U';
    DigitChars[31] := 'V';
    DigitChars[32] := 'W';
    DigitChars[33] := 'X';
    DigitChars[34] := 'Y';
    DigitChars[35] := 'Z';

    DigitChars[36] := 'a';
    DigitChars[37] := 'b';
    DigitChars[38] := 'c';
    DigitChars[39] := 'd';

    DigitChars[40] := 'e';
    DigitChars[41] := 'f';
    DigitChars[42] := 'g';
    DigitChars[43] := 'h';
    DigitChars[44] := 'i';
    DigitChars[45] := 'j';
    DigitChars[46] := 'k';
    DigitChars[47] := 'l';
    DigitChars[48] := 'm';
    DigitChars[49] := 'n';

    DigitChars[50] := 'o';
    DigitChars[51] := 'p';
    DigitChars[52] := 'q';
    DigitChars[53] := 'r';
    DigitChars[54] := 's';
    DigitChars[55] := 't';
    DigitChars[56] := 'u';
    DigitChars[57] := 'v';
    DigitChars[58] := 'w';
    DigitChars[59] := 'x';

    DigitChars[60] := 'y';
    DigitChars[61] := 'z';
    DigitChars[62] := '_';
    DigitChars[63] := '.';

    for i := 0 to 63 do
      DigitCharsLookup[Ord(DigitChars[i])] := i;

    Initialized := ' ';
  end;
end;

function DigitToByte(c: Char): Byte;
begin
  Result := DigitCharsLookup[Ord(c)];
end;

function ConvertNumeralSystem(i: Int64; const Base: TNumeralSystemBase = 64):
    string;
var
  OutPut: string;
  Nagative: Boolean;
begin
  InitializeArrays();

  Nagative := (i < 0);
  if Nagative then
    i := -i;

  repeat
    OutPut := DigitChars[i mod Base] + OutPut;
    i := i div Base;
  until i = 0;

  if Nagative then
    OutPut := '-' + OutPut;

  Result := OutPut;
end;

function ConvertNumeralSystem(s: string; const Base: TNumeralSystemBase = 64):
    Int64;
var
  i: Integer;
  p: Int64;
  OutPut: Int64;
  Nagative: Boolean;
begin
  InitializeArrays();


  Nagative := (s[1] = '-');
  if Nagative then
    Delete(s, 1, 1);

  OutPut := 0;
  p := 1;

  for i := Length(s) downto 1 do
  begin
    OutPut := OutPut + DigitToByte(s[i]) * P;
    p := p * Base;
  end;

  if Nagative then
    OutPut := - OutPut;

  Result := OutPut;
end;



initialization


end.
