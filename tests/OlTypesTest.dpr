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
  OLBooleanType in '..\source\OLBooleanType.pas',
  OLCurrencyType in '..\source\OLCurrencyType.pas',
  OLDateTimeType in '..\source\OLDateTimeType.pas',
  OLDateType in '..\source\OLDateType.pas',
  OLDoubleType in '..\source\OLDoubleType.pas',
  OLIntegerType in '..\source\OLIntegerType.pas',
  OLRaplaceTypes in '..\source\OLRaplaceTypes.pas',
  OLStringType in '..\source\OLStringType.pas',
  OLTypes in '..\source\OLTypes.pas';

{$R *.RES}

begin
  Application.Initialize;
  if IsConsole then
    with TextTestRunner.RunRegisteredTests do
      Free
  else
    GUITestRunner.RunRegisteredTests;
end.

