program OlTypesTest;
{

  Delphi DUnit Test Project
  -------------------------
  This project contains the DUnit test framework and the GUI/Console test runners.
  Add "CONSOLE_TESTRUNNER" to the conditional defines entry in the project options
  to use the console test runner.  Otherwise the GUI test runner will be used by
  default.

}

{$IFDEF CONSOLE_TESTRUNNER}
{$APPTYPE CONSOLE}
{$ENDIF}

uses
  Forms,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  Test_OlTypes in 'Test_OlTypes.pas',
  Test_Helpers in 'Test_Helpers.pas',
  Test_NullPropagation in 'Test_NullPropagation.pas',
  TestOLRegistry in 'TestOLRegistry.pas',
  TestOLArrays in 'TestOLArrays.pas',
  Test_OLTypesToEdits in 'Test_OLTypesToEdits.pas',
  Test_RecordLink in 'Test_RecordLink.pas',
  TestOLDictionaries in 'TestOLDictionaries.pas',
  Test_OLValidation in 'Test_OLValidation.pas',
  Test_FluentValidation in 'Test_FluentValidation.pas',
  Test_OLStringXML in 'Test_OLStringXML.pas',
  Test_StringHelperXML in 'Test_StringHelperXML.pas',
  Test_PrettyPrint in 'Test_PrettyPrint.pas',
  TestOLDictionaryWrapper in 'TestOLDictionaryWrapper.pas',
  Test_OLStringImmutable in 'Test_OLStringImmutable.pas',
  StringHelperFunctions in '..\source\StringHelperFunctions.pas',
  SmartToDate in '..\source\SmartToDate.pas',
  OLValidationTypes in '..\source\OLValidationTypes.pas',
  OLValidationLocalization in '..\source\OLValidationLocalization.pas',
  OLValidation in '..\source\OLValidation.pas',
  OLTypesToEdits in '..\source\OLTypesToEdits.pas',
  OLTypes in '..\source\OLTypes.pas',
  OLThreadRunner in '..\source\OLThreadRunner.pas',
  OLStringType in '..\source\OLStringType.pas',
  OLRegistry in '..\source\OLRegistry.pas',
  OLIntegerType in '..\source\OLIntegerType.pas',
  OLIntegerArray in '..\source\OLIntegerArray.pas',
  OLFormHelper in '..\source\OLFormHelper.pas',
  OLDoubleType in '..\source\OLDoubleType.pas',
  OLDictionaries in '..\source\OLDictionaries.pas',
  OLDateType in '..\source\OLDateType.pas',
  OLDateTimeType in '..\source\OLDateTimeType.pas',
  OLCurrencyType in '..\source\OLCurrencyType.pas',
  OLColorType in '..\source\OLColorType.pas',
  OLBooleanType in '..\source\OLBooleanType.pas',
  OLArrays in '..\source\OLArrays.pas',
  NumeralSystemConvert in '..\source\NumeralSystemConvert.pas',
  IntegerHelperFunctions in '..\source\IntegerHelperFunctions.pas',
  Int64HelperFunctions in '..\source\Int64HelperFunctions.pas',
  DoubleHelperFunctions in '..\source\DoubleHelperFunctions.pas',
  CurrencyHelperFunctions in '..\source\CurrencyHelperFunctions.pas',
  BooleanHelperFunctions in '..\source\BooleanHelperFunctions.pas';

{$R *.RES}

procedure DirtyStack;
var
  arr: array[0..1024] of Byte;
begin
  FillChar(arr, SizeOf(arr), 1 + Random(254));
end;

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;

  DirtyStack();

  if IsConsole then
    with TextTestRunner.RunRegisteredTests do
      Free
  else
    GUITestRunner.RunRegisteredTests;
end.

