unit Test_FluentValidation;

interface

{$IF CompilerVersion >= 34.0}

uses
  TestFramework,
  Classes, SysUtils, Vcl.Controls, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Forms, Vcl.Graphics,
  OLTypes, OLTypesToEdits, OLValidation, OLValidationTypes, OLIntegerType;

type
  TFluentValidationTest = class(TTestCase)
  private
    FForm: TForm;
    FEdit: TEdit;
    FMemo: TMemo;
    FCheckBox: TCheckBox;
    FDateTimePicker: TDateTimePicker;
    FLabel: TLabel;
    FString: OLString;
    FInteger: OLInteger;
    FDate: OLDate;
    FBoolean: OLBoolean;
    FControlLinks: TOLLinkManager;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestStringFluentValidation;
    procedure TestIntegerFluentValidation;
    procedure TestDateFluentValidation;
    procedure TestBooleanFluentValidation;
    procedure TestCheckBoxAllowGrayed;
  end;

{$IFEND}

implementation

{$IF CompilerVersion >= 34.0}

uses
  System.Variants;

{ TFluentValidationTest }

procedure TFluentValidationTest.SetUp;
begin
  FForm := TForm.Create(nil);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  
  FMemo := TMemo.Create(FForm);
  FMemo.Parent := FForm;
  
  FCheckBox := TCheckBox.Create(FForm);
  FCheckBox.Parent := FForm;
  
  FDateTimePicker := TDateTimePicker.Create(FForm);
  FDateTimePicker.Parent := FForm;
  
  FLabel := TLabel.Create(FForm);
  FLabel.Parent := FForm;

  FControlLinks := TOLLinkManager.Create;
end;

procedure TFluentValidationTest.TearDown;
begin
  FControlLinks.Free;
  FForm.Free;
end;

procedure TFluentValidationTest.TestStringFluentValidation;
var
  Link: TEditToOLString;
begin
  Link := FControlLinks.Link(FEdit, FString);
  
  {$IF CompilerVersion >= 34.0}
  // Fluent configuration
  Link.RequireValue(clRed, 'Required Field')
      .MinLength(3, clRed, 'Too Short');
      
  // Test Empty (Required)
  FString := '';
  // Note: Validation typically runs on change/update.
  // We can manually invoke validation checking via internal method or simply observe side effects 
  // if we could trigger ShowValidationState.
  // But unit testing private UI state is hard.
  // We can at least ensure the Check methods don't crash and the functions are added.
  
  // Actually, we can check if validators are added effectively by validating a value manually
  // using ValueIsValid (public public).
  
  CheckFalse(Link.ValueIsValid('').Valid, 'Should fail required check');
  CheckEquals('Required Field', Link.ValueIsValid('').Message, 'Should have correct error message');
  
  // Test Short (MinLength)
  CheckFalse(Link.ValueIsValid('ab').Valid, 'Should fail min length check');
  
  // Test Valid
  CheckTrue(Link.ValueIsValid('abc').Valid, 'Should pass validation');
  {$IFEND}
end;

procedure TFluentValidationTest.TestIntegerFluentValidation;
var
  Link: TEditToOLInteger;
begin
  Link := FControlLinks.Link(FEdit, FInteger);
  
  {$IF CompilerVersion >= 34.0}
  Link.Min(10, clRed, 'Must be >= 10')
      .Max(20, clRed, 'Must be <= 20');
      
  CheckFalse(Link.ValueIsValid(9).Valid, 'Should fail min check');
  CheckFalse(Link.ValueIsValid(21).Valid, 'Should fail max check');
  CheckTrue(Link.ValueIsValid(10).Valid, 'Should pass min boundary');
  CheckTrue(Link.ValueIsValid(20).Valid, 'Should pass max boundary');
  CheckTrue(Link.ValueIsValid(15).Valid, 'Should pass valid value');
  {$IFEND}
end;

procedure TFluentValidationTest.TestDateFluentValidation;
var
  Link: TDateTimePickerToOLDate;
  Today: TDate;
begin
  Link := FControlLinks.Link(FDateTimePicker, FDate);
  Today := Date;
  
  {$IF CompilerVersion >= 34.0}
  Link.Past(clRed, 'Must be past');
  
  CheckTrue(Link.ValueIsValid(Today - 1).Valid, 'Yesterday is past');
  CheckFalse(Link.ValueIsValid(Today + 1).Valid, 'Tomorrow is future');
  {$IFEND}
end;

procedure TFluentValidationTest.TestBooleanFluentValidation;
var
  Link: TCheckBoxToOLBoolean;
begin
  Link := FControlLinks.Link(FCheckBox, FBoolean, true);

  {$IF CompilerVersion >= 34.0}
  Link.RequireValue(clRed, 'Must be checked');
  
  CheckFalse(Link.ValueIsValid(Null).Valid, 'False should be invalid if required (HasValue check?)');

  
  FBoolean := Null;
  CheckFalse(Link.ValueIsValid(FBoolean).Valid, 'Null should be invalid');
  
  FBoolean := False;
  CheckTrue(Link.ValueIsValid(FBoolean).Valid, 'False has value');
  
  FBoolean := True;
  CheckTrue(Link.ValueIsValid(FBoolean).Valid, 'True has value');
  {$IFEND}
end;

procedure TFluentValidationTest.TestCheckBoxAllowGrayed;
var
  Link: TCheckBoxToOLBoolean;
begin
  // Test case 1: AllowGrayed = False (default)
  Link := FControlLinks.Link(FCheckBox, FBoolean, False);
  FBoolean := Null;
  Link.RefreshControl;
  CheckEquals(False, FCheckBox.Checked, 'Null should be Checked=False when AllowGrayed=False');
  CheckNotEquals(Ord(cbGrayed), Ord(FCheckBox.State), 'State should NOT be cbGrayed when AllowGrayed=False');
  
  FControlLinks.RemoveLinks(FForm);
  // Test case 2: AllowGrayed = True (passed via Link)
  Link := FControlLinks.Link(FCheckBox, FBoolean, True);
  FBoolean := Null;
  Link.RefreshControl;
  CheckEquals(Ord(cbGrayed), Ord(FCheckBox.State), 'Null should be cbGrayed when AllowGrayed=True (passed)');
  
  // Test case 3: Auto-detection (Link called without parameter, but TCheckBox has AllowGrayed=True)
  FControlLinks.RemoveLinks(FForm);
  FCheckBox.AllowGrayed := True;
  Link := FControlLinks.Link(FCheckBox, FBoolean); // default is False, but should auto-detect True
  FBoolean := Null;
  Link.RefreshControl;
  CheckEquals(Ord(cbGrayed), Ord(FCheckBox.State), 'Null should be cbGrayed via auto-detection');

  FBoolean := True;
  Link.RefreshControl;
  CheckEquals(True, FCheckBox.Checked, 'True should be Checked=True');
  
  FBoolean := False;
  Link.RefreshControl;
  CheckEquals(False, FCheckBox.Checked, 'False should be Checked=False');
end;

initialization
  TestFramework.RegisterTest(TFluentValidationTest.Suite);

{$IFEND}

end.
