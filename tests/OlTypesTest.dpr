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
  TestOLArrays in 'TestOLArrays.pas',
  Test_OLTypesToEdits in 'Test_OLTypesToEdits.pas',
  Test_RecordLink in 'Test_RecordLink.pas',
  OLBooleanType in '..\source\OLBooleanType.pas',
  OLCurrencyType in '..\source\OLCurrencyType.pas',
  OLDateTimeType in '..\source\OLDateTimeType.pas',
  OLDateType in '..\source\OLDateType.pas',
  OLDoubleType in '..\source\OLDoubleType.pas',
  OLIntegerType in '..\source\OLIntegerType.pas',
  OLStringType in '..\source\OLStringType.pas',
  OLTypes in '..\source\OLTypes.pas',
  OLTypesToEdits in '..\source\OLTypesToEdits.pas',
  SmartToDate in '..\source\SmartToDate.pas',
  TestOLDictionaries in 'TestOLDictionaries.pas',
  Test_OLValidation in 'Test_OLValidation.pas',
  Test_FluentValidation in 'Test_FluentValidation.pas',
  Test_OLStringXML in 'Test_OLStringXML.pas',
  Test_PrettyPrint in 'Test_PrettyPrint.pas',
  OLDictionaries in '..\source\OLDictionaries.pas',
  OLArrays in '..\source\OLArrays.pas',
  OLInt64Type in '..\source\OLInt64Type.pas';

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

