unit Test_PrettyPrint;

interface

uses
  TestFramework, OLTypes, SysUtils, Variants;

type
  TestPrettyPrint = class(TTestCase)
  published
    procedure TestIsJSON;
    procedure TestIsXML;
    procedure TestPrettyPrintJSON;
    procedure TestPrettyPrintXML;
    procedure TestPrettyPrintText;
    procedure TestNullHandling;
  end;

implementation

procedure TestPrettyPrint.TestIsJSON;
var
  s: OLString;
begin
  s := '{"name": "John"}';
  CheckTrue(s.IsJSON, 'Should detect valid JSON object');
  
  s := '[1, 2, 3]';
  CheckTrue(s.IsJSON, 'Should detect valid JSON array');
  
  s := '  { "a": 1 }  '; // with spaces
  CheckTrue(s.IsJSON, 'Should detect JSON even with surrounding spaces');
  
  s := 'Not JSON';
  CheckFalse(s.IsJSON, 'Should not detect non-JSON');
end;

procedure TestPrettyPrint.TestIsXML;
var
  s: OLString;
begin
  s := '<root><item>val</item></root>';
  CheckTrue(s.IsXML, 'Should detect valid XML');
  
  s := '  <root/>  ';
  CheckTrue(s.IsXML, 'Should detect valid XML with spaces');
  
  s := 'Not XML';
  CheckFalse(s.IsXML, 'Should not detect non-XML');
end;

procedure TestPrettyPrint.TestPrettyPrintJSON;
var
  s: OLString;
begin
  s := '{"name":"John","age":30,"city":"New York"}';
  s := s.PrettyPrint;
  
  Check(s.LineCount > 1, 'JSON should be formatted into multiple lines');
  Check(s.ContainsText('  "age": 30'), 'Should contain indented age field');
end;

procedure TestPrettyPrint.TestPrettyPrintXML;
var
  s: OLString;
begin
  {$IF CompilerVersion >= 27.0}
  s := '<root><item>test</item></root>';
  s := s.PrettyPrint;
  
  Check(s.LineCount > 1, 'XML should be formatted into multiple lines');
  Check(s.ContainsText('  <item>'), 'Should contain indented item tag');
  {$IFEND}
end;

procedure TestPrettyPrint.TestPrettyPrintText;
var
  s: OLString;
begin
  s := 'Just some plain text';
  CheckEqualsString(s, s.PrettyPrint, 'Plain text should remain unchanged');
end;

procedure TestPrettyPrint.TestNullHandling;
var
  s: OLString;
begin
  s := Null;
  CheckTrue(s.IsJSON.IsNull, 'IsJSON should return Null for Null string');
  CheckTrue(s.IsXML.IsNull, 'IsXML should return Null for Null string');
  CheckTrue(s.PrettyPrint.IsNull, 'PrettyPrint should return Null for Null string');
end;

initialization
  RegisterTest(TestPrettyPrint.Suite);

end.
