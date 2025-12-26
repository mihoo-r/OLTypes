unit Test_OLStringXML;

interface

{$IF CompilerVersion >= 27.0}
uses
  TestFramework, OLTypes, SysUtils, Variants;

type
  OLStringXMLTest = class(TTestCase)
  published
    procedure TestReadElement;
    procedure TestReadNested;
    procedure TestReadAttribute;
    procedure TestReadFragment;
    procedure TestChain;
    procedure TestReadNull;
    procedure TestWriteStructure;
    procedure TestWriteIndices;
    procedure TestWriteAttribute;
    procedure TestFormat;
  end;
{$IFEND}

implementation

{$IF CompilerVersion >= 27.0}
{ OLStringXMLTest }

procedure OLStringXMLTest.TestReadElement;
var
  s: OLString;
begin
  s := '<person><name>Jan</name></person>';
  CheckEqualsString('Jan', s.XML['person/name']);
end;

procedure OLStringXMLTest.TestReadNested;
var
  s: OLString;
begin
  s := '<root><level1><level2>val</level2></level1></root>';
  CheckEqualsString('val', s.XML['root/level1/level2']);
end;

procedure OLStringXMLTest.TestReadAttribute;
var
  s: OLString;
begin
  s := '<user id="123" name="John"/>';
  CheckEqualsString('123', s.XML['user/@id']);
  CheckEqualsString('John', s.XML['user/@name']);
end;

procedure OLStringXMLTest.TestReadFragment;
var
  s: OLString;
begin
  s := '<person><address><city>Poznan</city><street>Lipowa</street></address></person>';
  // Should return inner XML of address
  Check(s.XML['person/address'].ContainsText('<city>Poznan</city>'));
  Check(s.XML['person/address'].ContainsText('<street>Lipowa</street>'));
end;

procedure OLStringXMLTest.TestChain;
var
  s: OLString;
begin
  s := '<person><address><city>Poznan</city></address></person>';
  CheckEqualsString('Poznan', s.XML['person/address'].XML['city']);
end;

procedure OLStringXMLTest.TestReadNull;
var
  s: OLString;
begin
  s := '<person><name>Jan</name></person>';
  CheckTrue(s.XML['person/age'].IsNull);
  CheckTrue(s.XML['nonexistent'].IsNull);
end;

procedure OLStringXMLTest.TestWriteStructure;
var
  s: OLString;
begin
  s := Null;
  s.XML['person/name'] := 'Jan';
  s.XML['person/age'] := '30';
  
  CheckEqualsString('Jan', s.XML['person/name']);
  CheckEqualsString('30', s.XML['person/age']);
end;

procedure OLStringXMLTest.TestWriteIndices;
var
  s: OLString;
begin
  s := Null;
  s.XML['users/user[0]/name'] := 'Jan';
  s.XML['users/user[1]/name'] := 'Anna';
  
  CheckEqualsString('Jan', s.XML['users/user[0]/name']);
  CheckEqualsString('Anna', s.XML['users/user[1]/name']);
end;

procedure OLStringXMLTest.TestWriteAttribute;
var
  s: OLString;
begin
  s := Null;
  s.XML['user/name'] := 'John';
  s.XML['user/@id'] := '555';
  
  CheckEqualsString('John', s.XML['user/name']);
  CheckEqualsString('555', s.XML['user/@id']);
end;

procedure OLStringXMLTest.TestFormat;
var
  s: OLString;
begin
  s := Null;
  s.XML['root/item'] := 'test';
  // Check if it contains multiple lines (pretty print)
  Check(s.LineCount > 1, 'XML should be pretty printed with multiple lines');
end;

initialization
  RegisterTest(OLStringXMLTest.Suite);
{$IFEND}

end.
