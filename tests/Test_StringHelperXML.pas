unit Test_StringHelperXML;

interface

{$IF CompilerVersion >= 27.0}
uses
  TestFramework, SysUtils, Variants, OLTypes;

type
  TStringHelperXMLTest = class(TTestCase)
  published
    procedure TestGetXmlCollection;
    procedure TestGetJsonCollection;
  end;
{$IFEND}

implementation

{$IF CompilerVersion >= 27.0}
procedure TStringHelperXMLTest.TestGetXmlCollection;
var
  s: string;
  items: TArray<string>;
begin
  s := '<root>' +
       '  <items>' +
       '    <item>A</item>' +
       '    <item>B</item>' +
       '  </items>' +
       '</root>';
  
  items := s.GetXmlCollection('root/items');
  CheckEquals(2, Length(items), 'Should return 2 items');
  
  // Verify content using standard string operations or helper
  Check(Pos('>A<', items[0]) > 0, 'Item 0 content mismatch');
  Check(Pos('>B<', items[1]) > 0, 'Item 1 content mismatch');
  
  // Verify using helper property XML
  CheckEqualsString('A', string(items[0].XML['item']), 'Item 0 value mismatch using helper');
  CheckEqualsString('B', string(items[1].XML['item']), 'Item 1 value mismatch using helper');
end;

procedure TStringHelperXMLTest.TestGetJsonCollection;
var
  s: string;
  items: TArray<string>;
begin
  s := '{ "items": [ { "val": "A" }, { "val": "B" } ] }';
  
  items := s.GetJsonCollection('items');
  CheckEquals(2, Length(items), 'Should return 2 items');
  
  // Verify content
  CheckEqualsString('A', string(items[0].JSON['val']), 'Item 0 value mismatch using helper');
  CheckEqualsString('B', string(items[1].JSON['val']), 'Item 1 value mismatch using helper');
end;

initialization
  RegisterTest(TStringHelperXMLTest.Suite);
{$IFEND}

end.
