unit TestOLRegistry;

interface

uses
  TestFramework, OLRegistry, OLStringType;

type
  TestTOLRegistry = class(TTestCase)
  published
    procedure TestClearSettings;
  end;

implementation

procedure TestTOLRegistry.TestClearSettings;
const
  TEST_KEY = 'TestValue';
  TEST_STR = 'Hello World';
begin
  // Set a value
  TOLRegistry.Settings[TEST_KEY] := TEST_STR;
  
  // Verify it exists (assuming it was empty before or just that it works)
  CheckEquals(TEST_STR, TOLRegistry.Settings[TEST_KEY].ToString, 'Value should be saved');

  // Clear settings
  TOLRegistry.ClearSettings;

  // Verify it's gone
  CheckEquals('', TOLRegistry.Settings[TEST_KEY].ToString, 'Value should be empty after ClearSettings');
end;

initialization
  RegisterTest(TestTOLRegistry.Suite);

end.
