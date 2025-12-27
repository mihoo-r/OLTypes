unit OLColorType;

interface

{$IF CompilerVersion >= 23.0}
uses
  Vcl.Graphics, System.Math;
{$ELSE}
uses
  Graphics, Math;
{$IFEND}


type
  TRGB = record
    R, G, B: Byte;
  end;

  THSV = record
    H: Double;
    S: Double;
    V: Double;
  end;

  OLColor = record
  private
    Color: TColor;
    class function RGBtoHSV(const RGB: TRGB): THSV; static;
    class function HSVtoRGB(HSV: THSV): TRGB; static;
    class function RGBtoTColor(const RGB: TRGB): TColor; static;
    class function TColorToRGB(Color: TColor): TRGB; static;
    class function ChangeColorsSaturationAndBrightness(const Color: TColor; SaturationDelta, BrightnessDelta:
      Integer): TColor; static;
    function GetB: Integer;
    function GetG: Integer;
    function GetH: Integer;
    function GetR: Byte;
    function GetS: Byte;
    function GetV: Byte;
    procedure SetB(const Value: Integer);
    procedure SetG(const Value: Integer);
    procedure SetH(const Value: Integer);
    procedure SetR(const Value: Byte);
    procedure SetS(const Value: Byte);
    procedure SetV(const Value: Byte);
  public
    class operator Implicit(const a: TColor): OLColor;
    class operator Implicit(const a: OLColor): TColor;

    {$IF CompilerVersion >= 23.0}
    class function Aliceblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Antiquewhite(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}
    class function Aqua(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IF CompilerVersion >= 23.0}
    class function Aquamarine(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Azure(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Beige(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Bisque(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}
    class function Black(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IF CompilerVersion >= 23.0}
    class function Blanchedalmond(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}
    class function Blue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IF CompilerVersion >= 23.0}
    class function Blueviolet(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Brown(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Burlywood(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Cadetblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Chartreuse(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Chocolate(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Coral(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Cornflowerblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Cornsilk(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Crimson(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Cyan(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkcyan(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkgoldenrod(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkgray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkgreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkgrey(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkkhaki(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkmagenta(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkolivegreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkorange(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkorchid(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkred(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darksalmon(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkseagreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkslateblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkslategray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkslategrey(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkturquoise(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Darkviolet(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Deeppink(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Deepskyblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Dimgray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Dimgrey(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Dodgerblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Firebrick(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Floralwhite(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Forestgreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}
    class function Fuchsia(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IF CompilerVersion >= 23.0}
    class function Gainsboro(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Ghostwhite(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Gold(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Goldenrod(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}
    class function Gray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Green(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IF CompilerVersion >= 23.0}
    class function Greenyellow(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Grey(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Honeydew(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Hotpink(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Indianred(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Indigo(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Ivory(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Khaki(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lavender(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lavenderblush(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lawngreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lemonchiffon(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightcoral(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightcyan(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightgoldenrodyellow(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightgray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightgreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightgrey(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightpink(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightsalmon(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightseagreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightskyblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightslategray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightslategrey(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightsteelblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lightyellow(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}
    class function LtGray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function MedGray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function DkGray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function MoneyGreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function LegacySkyBlue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Cream(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Lime(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IF CompilerVersion >= 23.0}
    class function Limegreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Linen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Magenta(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}
    class function Maroon(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IF CompilerVersion >= 23.0}
    class function Mediumaquamarine(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Mediumblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Mediumorchid(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Mediumpurple(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Mediumseagreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Mediumslateblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Mediumspringgreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Mediumturquoise(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Mediumvioletred(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Midnightblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Mintcream(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Mistyrose(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Moccasin(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Navajowhite(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}
    class function Navy(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IF CompilerVersion >= 23.0}
    class function Oldlace(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}
    class function Olive(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IF CompilerVersion >= 23.0}
    class function Olivedrab(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Orange(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Orangered(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Orchid(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Palegoldenrod(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Palegreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Paleturquoise(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Palevioletred(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Papayawhip(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Peachpuff(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Peru(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Pink(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Plum(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Powderblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}
    class function Purple(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Red(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IF CompilerVersion >= 23.0}
    class function Rosybrown(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Royalblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Saddlebrown(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Salmon(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Sandybrown(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Seagreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Seashell(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Sienna(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}
    class function Silver(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IF CompilerVersion >= 23.0}
    class function Skyblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Slateblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Slategray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Slategrey(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Snow(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Springgreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Steelblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Tan(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}
    class function Teal(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IF CompilerVersion >= 23.0}
    class function Thistle(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Tomato(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Turquoise(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Violet(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    class function Wheat(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}
    class function White(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IF CompilerVersion >= 23.0}
    class function Whitesmoke(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}
    class function Yellow(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IF CompilerVersion >= 23.0}
    class function Yellowgreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; static;
    {$IFEND}

    /// <summary>Returns the complementary color (opposite on the color wheel).</summary>
    function Complementary(): OLColor;
    /// <summary>Returns a brighter version of the color.</summary>
    function Brighter(BrightnessDelta: Integer = 20): OLColor;
    /// <summary>Returns a darker version of the color.</summary>
    function Darker(BrightnessDelta: Integer = -20): OLColor;
    /// <summary>Returns a more vivid (saturated) version of the color.</summary>
    function Vividier(SaturationDelta: Integer = 20): OLColor;
    /// <summary>Returns a duller (less saturated) version of the color.</summary>
    function Duller(SaturationDelta: Integer = -20): OLColor;

    property R: Byte read GetR write SetR;
    property G: Integer read GetG write SetG;
    property B: Integer read GetB write SetB;

    property H: Integer read GetH write SetH;
    property S: Byte read GetS write SetS;
    property V: Byte read GetV write SetV;

  end;

implementation

{$IF CompilerVersion >= 23.0}
uses
  System.UITypes;
{$IFEND}


function OLColor.Brighter(BrightnessDelta: Integer = 20): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(Color, 0, BrightnessDelta);
end;

class operator OLColor.Implicit(const a: TColor): OLColor;
var
  Output: OLColor;
begin
  Output.Color := a;

  Result := Output;
end;

class operator OLColor.Implicit(const a: OLColor): TColor;
begin
  Result := a.Color;
end;

class function OLColor.ChangeColorsSaturationAndBrightness(const Color: TColor; SaturationDelta,
  BrightnessDelta: Integer): TColor;
var
  HSV: THSV;
  RGB: TRGB;
begin
  RGB := TColorToRGB(Color);
  HSV := RGBtoHSV(RGB);

  HSV.S := Min(100, Max(0, 100 * HSV.S + SaturationDelta)) / 100;
  HSV.V := Min(100, Max(0, 100 * HSV.V + BrightnessDelta)) / 100;

  RGB := HSVtoRGB(HSV);

  Result := RGBtoTColor(RGB);
end;

function OLColor.Complementary(): OLColor;
var
  OutPut: OLColor;
  H: integer;
begin
  OutPut := Self;

  H := OutPut.H;
  H := H + 180;
  if H > 359 then
    H := H - 360;

  OutPut.H := H;

  Result := OutPut;
end;

function OLColor.Darker(BrightnessDelta: Integer = -20): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(Color, 0, BrightnessDelta);
end;

function OLColor.Duller(SaturationDelta: Integer = -20): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(Color, SaturationDelta, 0);
end;

function OLColor.GetB: Integer;
begin
  Result := TColorToRGB(Color).B;
end;

function OLColor.GetG: Integer;
begin
  Result := TColorToRGB(Color).G;
end;

function OLColor.GetH: Integer;
begin
  Result := Round(RGBtoHSV(TColorToRGB(Color)).H);
end;

function OLColor.GetR: Byte;
begin
  Result := TColorToRGB(Color).R;
end;

function OLColor.GetS: Byte;
begin
  Result := Round(RGBtoHSV(TColorToRGB(Color)).S * 100);
end;

function OLColor.GetV: Byte;
begin
  Result := Round(RGBtoHSV(TColorToRGB(Color)).V * 100);
end;

class function OLColor.Green(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
var
  OutPut: TColor;
begin
  OutPut := clGreen;

  Result := ChangeColorsSaturationAndBrightness(OutPut, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Red(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clRed, SaturationDelta, BrightnessDelta);
end;


class function OLColor.RGBtoHSV(const RGB: TRGB): THSV;
var
  MinVal, MaxVal, Delta: Double;
begin
  MinVal := Min(Min(RGB.R, RGB.G), RGB.B);
  MaxVal := Max(Max(RGB.R, RGB.G), RGB.B);
  Delta := MaxVal - MinVal;
  Result.V := MaxVal / 255;

  if (MaxVal <> 0) and (Delta <> 0) then
    Result.S := Delta / MaxVal
  else
  begin
    // R = G = B = 0
    Result.S := 0;
    Result.H := -1;
    Exit;
  end;

  if RGB.R = MaxVal then
    Result.H := (RGB.G - RGB.B) / Delta
  else if RGB.G = MaxVal then
    Result.H := 2 + (RGB.B - RGB.R) / Delta
  else
    Result.H := 4 + (RGB.R - RGB.G) / Delta;

  Result.H := Result.H * 60;
  if Result.H < 0 then
    Result.H := Result.H + 360;
end;

class function OLColor.HSVtoRGB(HSV: THSV): TRGB;
var
  i: Integer;
  f, p, q, t: Double;
begin
  if HSV.S = 0 then
  begin
    Result.R := Round(HSV.V * 255);
    Result.G := Result.R;
    Result.B := Result.R;
    Exit;
  end;

  HSV.H := HSV.H / 60;
  i := Trunc(HSV.H);
  f := HSV.H - i;
  p := HSV.V * (1 - HSV.S);
  q := HSV.V * (1 - HSV.S * f);
  t := HSV.V * (1 - HSV.S * (1 - f));

  case i of
    0:
      begin
        Result.R := Round(HSV.V * 255);
        Result.G := Round(t * 255);
        Result.B := Round(p * 255);
      end;
    1:
      begin
        Result.R := Round(q * 255);
        Result.G := Round(HSV.V * 255);
        Result.B := Round(p * 255);
      end;
    2:
      begin
        Result.R := Round(p * 255);
        Result.G := Round(HSV.V * 255);
        Result.B := Round(t * 255);
      end;
    3:
      begin
        Result.R := Round(p * 255);
        Result.G := Round(q * 255);
        Result.B := Round(HSV.V * 255);
      end;
    4:
      begin
        Result.R := Round(t * 255);
        Result.G := Round(p * 255);
        Result.B := Round(HSV.V * 255);
      end;
  else
    begin
      Result.R := Round(HSV.V * 255);
      Result.G := Round(p * 255);
      Result.B := Round(q * 255);
    end;
  end;
end;

class function OLColor.RGBtoTColor(const RGB: TRGB): TColor;
begin
  Result := RGB.R or (RGB.G shl 8) or (RGB.B shl 16);
end;

procedure OLColor.SetB(const Value: Integer);
var
  RGB: TRGB;
begin
  RGB := TColorToRGB(Color);
  RGB.B := Value;
  Color := RGBtoTColor(RGB);
end;

procedure OLColor.SetG(const Value: Integer);
var
  RGB: TRGB;
begin
  RGB := TColorToRGB(Color);
  RGB.G := Value;
  Color := RGBtoTColor(RGB);
end;

procedure OLColor.SetH(const Value: Integer);
var
  HSV: THSV;
  RGB: TRGB;
begin
  HSV := RGBtoHSV(TColorToRGB(Color));
  HSV.H := Value;
  RGB := HSVtoRGB(HSV);

  Color := RGBtoTColor(RGB);
end;

procedure OLColor.SetR(const Value: Byte);
var
  RGB: TRGB;
begin
  RGB := TColorToRGB(Color);
  RGB.R := Value;
  Color := RGBtoTColor(RGB);
end;

procedure OLColor.SetS(const Value: Byte);
var
  HSV: THSV;
  RGB: TRGB;
begin
  HSV := RGBtoHSV(TColorToRGB(Color));
  HSV.S := Value / 100;
  RGB := HSVtoRGB(HSV);

  Color := RGBtoTColor(RGB);
end;

procedure OLColor.SetV(const Value: Byte);
var
  HSV: THSV;
  RGB: TRGB;
begin
  HSV := RGBtoHSV(TColorToRGB(Color));
  HSV.V := Value / 100;
  RGB := HSVtoRGB(HSV);

  Color := RGBtoTColor(RGB);
end;

class function OLColor.TColorToRGB(Color: TColor): TRGB;
begin
  Result.R := Color and $FF;
  Result.G := (Color shr 8) and $FF;
  Result.B := (Color shr 16) and $FF;
end;

function OLColor.Vividier(SaturationDelta: Integer = 20): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(Color, SaturationDelta, 0);
end;

{$IF CompilerVersion >= 23.0}
class function OLColor.Aliceblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Aliceblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Antiquewhite(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Antiquewhite, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


class function OLColor.Aqua(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clAqua, SaturationDelta, BrightnessDelta);
end;


{$IF CompilerVersion >= 23.0}
class function OLColor.Aquamarine(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Aquamarine, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Azure(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Azure, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Beige(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Beige, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Bisque(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Bisque, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


class function OLColor.Black(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clBlack, SaturationDelta, BrightnessDelta);
end;


{$IF CompilerVersion >= 23.0}
class function OLColor.Blanchedalmond(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Blanchedalmond, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


class function OLColor.Blue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clBlue, SaturationDelta, BrightnessDelta);
end;


{$IF CompilerVersion >= 23.0}
class function OLColor.Blueviolet(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Blueviolet, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Brown(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Brown, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Burlywood(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Burlywood, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Cadetblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Cadetblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Chartreuse(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Chartreuse, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Chocolate(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Chocolate, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Coral(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Coral, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Cornflowerblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Cornflowerblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Cornsilk(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Cornsilk, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Crimson(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Crimson, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Cyan(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Cyan, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkcyan(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkcyan, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkgoldenrod(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkgoldenrod, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkgray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkgray, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkgreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkgreen, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkgrey(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkgrey, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkkhaki(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkkhaki, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkmagenta(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkmagenta, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkolivegreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkolivegreen, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkorange(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkorange, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkorchid(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkorchid, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkred(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkred, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darksalmon(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darksalmon, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkseagreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkseagreen, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkslateblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkslateblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkslategray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkslategray, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkslategrey(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkslategrey, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkturquoise(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkturquoise, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Darkviolet(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Darkviolet, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Deeppink(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Deeppink, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Deepskyblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Deepskyblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Dimgray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Dimgray, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Dimgrey(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Dimgrey, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Dodgerblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Dodgerblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Firebrick(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Firebrick, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Floralwhite(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Floralwhite, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Forestgreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Forestgreen, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


class function OLColor.Fuchsia(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clFuchsia, SaturationDelta, BrightnessDelta);
end;


{$IF CompilerVersion >= 23.0}
class function OLColor.Gainsboro(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Gainsboro, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Ghostwhite(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Ghostwhite, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Gold(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Gold, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Goldenrod(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Goldenrod, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


class function OLColor.Gray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clGray, SaturationDelta, BrightnessDelta);
end;


{$IF CompilerVersion >= 23.0}
class function OLColor.Greenyellow(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Greenyellow, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Grey(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Grey, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Honeydew(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Honeydew, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Hotpink(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Hotpink, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Indianred(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Indianred, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Indigo(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Indigo, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Ivory(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Ivory, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Khaki(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Khaki, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lavender(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lavender, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lavenderblush(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lavenderblush, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lawngreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lawngreen, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lemonchiffon(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lemonchiffon, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightcoral(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightcoral, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightcyan(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightcyan, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightgoldenrodyellow(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightgoldenrodyellow, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightgray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightgray, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightgreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightgreen, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightgrey(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightgrey, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightpink(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightpink, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightsalmon(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightsalmon, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightseagreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightseagreen, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightskyblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightskyblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightslategray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightslategray, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightslategrey(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightslategrey, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightsteelblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightsteelblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lightyellow(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Lightyellow, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


class function OLColor.LtGray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clLtGray, SaturationDelta, BrightnessDelta);
end;

class function OLColor.MedGray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clMedGray, SaturationDelta, BrightnessDelta);
end;

class function OLColor.DkGray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clDkGray, SaturationDelta, BrightnessDelta);
end;

class function OLColor.MoneyGreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clMoneyGreen, SaturationDelta, BrightnessDelta);
end;

class function OLColor.LegacySkyBlue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clSkyBlue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Cream(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clCream, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Lime(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clLime, SaturationDelta, BrightnessDelta);
end;


{$IF CompilerVersion >= 23.0}
class function OLColor.Limegreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Limegreen, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Linen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Linen, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Magenta(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Magenta, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


class function OLColor.Maroon(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clMaroon, SaturationDelta, BrightnessDelta);
end;


{$IF CompilerVersion >= 23.0}
class function OLColor.Mediumaquamarine(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Mediumaquamarine, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Mediumblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Mediumblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Mediumorchid(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Mediumorchid, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Mediumpurple(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Mediumpurple, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Mediumseagreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Mediumseagreen, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Mediumslateblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Mediumslateblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Mediumspringgreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Mediumspringgreen, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Mediumturquoise(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Mediumturquoise, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Mediumvioletred(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Mediumvioletred, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Midnightblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Midnightblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Mintcream(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Mintcream, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Mistyrose(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Mistyrose, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Moccasin(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Moccasin, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Navajowhite(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Navajowhite, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


class function OLColor.Navy(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clNavy, SaturationDelta, BrightnessDelta);
end;


{$IF CompilerVersion >= 23.0}
class function OLColor.Oldlace(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Oldlace, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


class function OLColor.Olive(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clOlive, SaturationDelta, BrightnessDelta);
end;


{$IF CompilerVersion >= 23.0}
class function OLColor.Olivedrab(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Olivedrab, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Orange(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Orange, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Orangered(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Orangered, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Orchid(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Orchid, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Palegoldenrod(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Palegoldenrod, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Palegreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Palegreen, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Paleturquoise(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Paleturquoise, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Palevioletred(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Palevioletred, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Papayawhip(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Papayawhip, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Peachpuff(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Peachpuff, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Peru(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Peru, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Pink(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Pink, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Plum(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Plum, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Powderblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Powderblue, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


class function OLColor.Purple(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clPurple, SaturationDelta, BrightnessDelta);
end;

//class function OLColor.Red(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor; begin Result := ChangeColorsSaturationAndBrightness(TColors.Red, SaturationDelta, BrightnessDelta); end;

{$IF CompilerVersion >= 23.0}
class function OLColor.Rosybrown(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Rosybrown, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Royalblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Royalblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Saddlebrown(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Saddlebrown, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Salmon(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Salmon, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Sandybrown(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Sandybrown, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Seagreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Seagreen, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Seashell(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Seashell, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Sienna(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Sienna, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


class function OLColor.Silver(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clSilver, SaturationDelta, BrightnessDelta);
end;


{$IF CompilerVersion >= 23.0}
class function OLColor.Skyblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Skyblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Slateblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Slateblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Slategray(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Slategray, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Slategrey(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Slategrey, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Snow(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Snow, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Springgreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Springgreen, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Steelblue(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Steelblue, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Tan(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Tan, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


class function OLColor.Teal(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clTeal, SaturationDelta, BrightnessDelta);
end;


{$IF CompilerVersion >= 23.0}
class function OLColor.Thistle(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Thistle, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Tomato(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Tomato, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Turquoise(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Turquoise, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Violet(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Violet, SaturationDelta, BrightnessDelta);
end;

class function OLColor.Wheat(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Wheat, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


class function OLColor.White(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clWhite, SaturationDelta, BrightnessDelta);
end;


{$IF CompilerVersion >= 23.0}
class function OLColor.Whitesmoke(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Whitesmoke, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


class function OLColor.Yellow(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(clYellow, SaturationDelta, BrightnessDelta);
end;


{$IF CompilerVersion >= 23.0}
class function OLColor.Yellowgreen(SaturationDelta: Integer = 0; BrightnessDelta: Integer = 0): OLColor;
begin
  Result := ChangeColorsSaturationAndBrightness(TColors.Yellowgreen, SaturationDelta, BrightnessDelta);
end;
{$IFEND}


end.

