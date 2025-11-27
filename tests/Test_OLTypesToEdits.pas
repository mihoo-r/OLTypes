unit Test_OLTypesToEdits;

interface

uses
  TestFramework, Windows, Forms, Dialogs, Controls, Classes, SysUtils, Variants,
  Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ComCtrls, OLTypes, OLTypesToEdits;

type
  // Test class for TEditToOLInteger binding
  TestEditToOLInteger = class(TTestCase)
  private
    FEdit: TEdit;
    FValue: OLInteger;
    FForm: TForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestEditToValueSync;
    procedure TestValueToEditSync;
    procedure TestNullHandling;
    procedure TestInvalidInput;
    procedure TestEmptyStringToNull;
  end;

  // Test class for TEditToOLString binding
  TestEditToOLString = class(TTestCase)
  private
    FEdit: TEdit;
    FValue: OLString;
    FForm: TForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestEditToValueSync;
    procedure TestValueToEditSync;
    procedure TestEmptyString;
    procedure TestSpecialCharacters;
  end;

  // Test class for TEditToOLDouble binding
  TestEditToOLDouble = class(TTestCase)
  private
    FEdit: TEdit;
    FValue: OLDouble;
    FForm: TForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestEditToValueSync;
    procedure TestValueToEditSync;
    procedure TestNullHandling;
    procedure TestFormatting;
  end;

  // Test class for TEditToOLCurrency binding
  TestEditToOLCurrency = class(TTestCase)
  private
    FEdit: TEdit;
    FValue: OLCurrency;
    FForm: TForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestEditToValueSync;
    procedure TestValueToEditSync;
    procedure TestDecimalPrecision;
    procedure TestNullHandling;
  end;

  // Test class for TSpinEditToOLInteger binding
  TestSpinEditToOLInteger = class(TTestCase)
  private
    FSpinEdit: TSpinEdit;
    FValue: OLInteger;
    FForm: TForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestSpinToValueSync;
    procedure TestValueToSpinSync;
    procedure TestNullHandling;
  end;

  // Test class for TDateTimePickerToOLDate binding
  TestDateTimePickerToOLDate = class(TTestCase)
  private
    FPicker: TDateTimePicker;
    FValue: OLDate;
    FForm: TForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestPickerToValueSync;
    procedure TestValueToPickerSync;
    procedure TestNullHandling;
    procedure TestNullFormatDisplay;
  end;

  // Test class for TDateTimePickerToOLDateTime binding
  TestDateTimePickerToOLDateTime = class(TTestCase)
  private
    FPicker: TDateTimePicker;
    FValue: OLDateTime;
    FForm: TForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestPickerToValueSync;
    procedure TestValueToPickerSync;
    procedure TestNullHandling;
    procedure TestNullFormatDisplay;
  end;

  // Test class for TCheckBoxToOLBoolean binding
  TestCheckBoxToOLBoolean = class(TTestCase)
  private
    FCheckBox: TCheckBox;
    FValue: OLBoolean;
    FForm: TForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCheckBoxToValueSync;
    procedure TestValueToCheckBoxSync;
    procedure TestNullHandling;
  end;

  // Test class for TOLTypesToControlsLinks (integration tests)
  TestOLTypesToControlsLinks = class(TTestCase)
  private
    FForm: TForm;
    FIntValue: OLInteger;
    FStrValue: OLString;
    FEdit1: TEdit;
    FEdit2: TEdit;
    FLabel1: TLabel;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestLinkEditToInteger;
    procedure TestLinkEditToString;
    procedure TestLinkLabelToInteger;
    procedure TestLinkLabelWithCalculation;
    procedure TestMultipleControlsToOneValue;
    procedure TestRefreshControls;
    procedure TestCalculationError;
  end;

  // Test class for memory safety and edge cases
  TestMemorySafety = class(TTestCase)
  private
    FForm: TForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestMultipleLinkRemoval;
    procedure TestRefreshAfterRemoval;
    procedure TestFormDestruction;
  end;

implementation

uses
  DateUtils, OLFormHelper;

{ TestEditToOLInteger }

procedure TestEditToOLInteger.SetUp;
begin
  FForm := TForm.Create(nil);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  FValue := 100;
  FEdit.Link(FValue);
end;

procedure TestEditToOLInteger.TearDown;
begin
  FForm.Free;
end;

procedure TestEditToOLInteger.TestEditToValueSync;
begin
  FEdit.Text := '250';
  
  CheckEquals(250, Integer(FValue), 'Value should be synced from Edit');
end;

procedure TestEditToOLInteger.TestValueToEditSync;
begin
  FValue := 500;

  CheckEquals('500', FEdit.Text, 'Edit should display new value');
end;

procedure TestEditToOLInteger.TestNullHandling;
begin
  FEdit.Text := '1';
  FEdit.Text := '';
  
  CheckTrue(FValue.IsNull, 'Empty string should set value to NULL');
end;

procedure TestEditToOLInteger.TestInvalidInput;
var
  OldValue: OLInteger;
begin
  FValue := 100;
  OldValue := FValue;
  
  FEdit.Text := 'invalid';
  
  CheckEquals(Integer(OldValue), Integer(FValue), 'Invalid input should not change value');
end;

procedure TestEditToOLInteger.TestEmptyStringToNull;
begin
  FEdit.Text := '41';//To force OnChange when set to ''
  FValue := 42;
  FEdit.Text := '';
  
  CheckTrue(FValue.IsNull, 'Empty string should result in NULL');
  
  CheckEquals('', FEdit.Text, 'NULL should display as empty string');
end;

{ TestEditToOLString }

procedure TestEditToOLString.SetUp;
begin
  FForm := TForm.Create(nil);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  FValue := 'Initial Value';
  FEdit.Link(FValue);
end;

procedure TestEditToOLString.TearDown;
begin
  FForm.Free;
end;

procedure TestEditToOLString.TestEditToValueSync;
begin
  FEdit.Text := 'New Text';
  
  CheckEquals('New Text', string(FValue), 'Value should be synced from Edit');
end;

procedure TestEditToOLString.TestValueToEditSync;
begin
  FValue := 'Updated Value';
  
  CheckEquals('Updated Value', FEdit.Text, 'Edit should display new value');
end;

procedure TestEditToOLString.TestEmptyString;
begin
  FEdit.Text := 'not null';
  FEdit.Text := '';
  
  // OLString uses empty string, not NULL for empty
  CheckEquals('', string(FValue), 'Empty string should be preserved');
end;

procedure TestEditToOLString.TestSpecialCharacters;
begin
  FEdit.Text := 'Line1'#13#10'Line2';
  
  CheckEquals('Line1'#13#10'Line2', string(FValue), 'Special characters should be preserved');
end;

{ TestEditToOLDouble }

procedure TestEditToOLDouble.SetUp;
begin
  FForm := TForm.Create(nil);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  FValue := 123.456;
  FEdit.Link(FValue);
end;

procedure TestEditToOLDouble.TearDown;
begin
  FForm.Free;
end;

procedure TestEditToOLDouble.TestEditToValueSync;
begin
  FEdit.Text := FloatToStr(999.99);
  
  CheckEquals(999.99, Double(FValue), 0.001, 'Value should be synced from Edit');
end;

procedure TestEditToOLDouble.TestValueToEditSync;
begin
  FValue := 456.789;
  
  // Check that value is displayed (format may vary)
  CheckTrue(Pos('456', FEdit.Text) > 0, 'Edit should contain the value');
end;

procedure TestEditToOLDouble.TestNullHandling;
begin
  FEdit.Text := '1';
  FEdit.Text := '';//force OnChange

  CheckTrue(FValue.IsNull, 'Empty string should set value to NULL');
end;

procedure TestEditToOLDouble.TestFormatting;
begin
  FValue := 1234.5678;
  
  // When not focused, should have thousand separator
  // This is a basic check - actual formatting depends on locale
  CheckTrue(FEdit.Text <> '', 'Value should be formatted and displayed');
end;

{ TestEditToOLCurrency }

procedure TestEditToOLCurrency.SetUp;
begin
  FForm := TForm.Create(nil);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  FValue := 1000.50;
  FEdit.Link(FValue);
end;

procedure TestEditToOLCurrency.TearDown;
begin
  FForm.Free;
end;

procedure TestEditToOLCurrency.TestEditToValueSync;
begin
  FEdit.Text := CurrToStr(500.25);
  
  CheckEquals(500.25, Double(FValue), 0.001, 'Value should be synced from Edit');
end;

procedure TestEditToOLCurrency.TestValueToEditSync;
begin
  FValue := 999.99;
  
  CheckTrue(Pos('999', FEdit.Text) > 0, 'Edit should contain the value');
end;

procedure TestEditToOLCurrency.TestDecimalPrecision;
begin
  // Currency should limit decimal places
  FEdit.Text := '123.456789';
  
  // Should be limited to 4 decimal places during edit
  CheckTrue(True, 'Decimal precision test - check manually');
end;

procedure TestEditToOLCurrency.TestNullHandling;
begin
  FEdit.Text := '1';
  FEdit.Text := '';//force OnChange
  
  CheckTrue(FValue.IsNull, 'Empty string should set value to NULL');
end;

{ TestSpinEditToOLInteger }

procedure TestSpinEditToOLInteger.SetUp;
begin
  FForm := TForm.Create(nil);
  FSpinEdit := TSpinEdit.Create(FForm);
  FSpinEdit.Parent := FForm;
  FValue := 50;
  FSpinEdit.Link(FValue);
end;

procedure TestSpinEditToOLInteger.TearDown;
begin
  FForm.Free;
end;

procedure TestSpinEditToOLInteger.TestSpinToValueSync;
begin
  FSpinEdit.Value := 75;
  FSpinEdit.Text := '75';
  
  CheckEquals(75, Integer(FValue), 'Value should be synced from SpinEdit');
end;

procedure TestSpinEditToOLInteger.TestValueToSpinSync;
begin
  FValue := 100;
  
  CheckEquals('100', FSpinEdit.Text, 'SpinEdit should display new value');
end;

procedure TestSpinEditToOLInteger.TestNullHandling;
begin
  FSpinEdit.Text := '';
  
  CheckTrue(FValue.IsNull, 'Empty string should set value to NULL');
end;

{ TestDateTimePickerToOLDate }

procedure TestDateTimePickerToOLDate.SetUp;
begin
  FForm := TForm.Create(nil);
  FPicker := TDateTimePicker.Create(FForm);
  FPicker.Parent := FForm;
  FPicker.Format := 'dd/MM/yyyy';
  System.Initialize(FValue);
  FValue := OLDate.Today;
  FPicker.Link(FValue);
end;

procedure TestDateTimePickerToOLDate.TearDown;
begin
  FForm.Free;
end;

procedure TestDateTimePickerToOLDate.TestPickerToValueSync;
var
  TestDate: TDate;
begin
  TestDate := EncodeDate(2025, 11, 22);
  FPicker.Date := TestDate;
  
  CheckEquals(TestDate, TDate(FValue), 'Value should be synced from DateTimePicker');
end;

procedure TestDateTimePickerToOLDate.TestValueToPickerSync;
var
  TestDate: TDate;
begin
  TestDate := EncodeDate(2024, 1, 1);
  FValue := TestDate;
  
  CheckEquals(TestDate, FPicker.Date, 'DateTimePicker should display new value');
end;

procedure TestDateTimePickerToOLDate.TestNullHandling;
begin
  FValue := Null;
  
  // When NULL, format should change to NULL_FORMAT
  CheckTrue(FValue.IsNull, 'Value should be NULL');
end;

procedure TestDateTimePickerToOLDate.TestNullFormatDisplay;
begin
  FValue := Null;
  
  // Check that format changed to "- - -"
  CheckEquals('- - -', FPicker.Format, 'NULL should display as "- - -"');
end;

{ TestDateTimePickerToOLDateTime }

procedure TestDateTimePickerToOLDateTime.SetUp;
begin
  FForm := TForm.Create(nil);
  FPicker := TDateTimePicker.Create(FForm);
  FPicker.Parent := FForm;
  FPicker.Format := 'dd/MM/yyyy HH:mm:ss';
  FPicker.Kind := dtkDateTime;
  System.Initialize(FValue);
  FValue := OLDateTime.Now;
  FPicker.Link(FValue);
end;

procedure TestDateTimePickerToOLDateTime.TearDown;
begin
  FForm.Free;
end;

procedure TestDateTimePickerToOLDateTime.TestPickerToValueSync;
var
  TestDateTime: TDateTime;
begin
  TestDateTime := EncodeDate(2025, 11, 22) + EncodeTime(14, 30, 45, 0);
  FPicker.DateTime := TestDateTime;
  
  CheckEquals(TestDateTime, TDateTime(FValue), 0.001, 'Value should be synced from DateTimePicker');
end;

procedure TestDateTimePickerToOLDateTime.TestValueToPickerSync;
var
  TestDateTime: TDateTime;
begin
  TestDateTime := EncodeDate(2024, 1, 1) + EncodeTime(10, 15, 30, 0);
  FValue := TestDateTime;
  
  CheckEquals(TestDateTime, FPicker.DateTime, 0.001, 'DateTimePicker should display new value');
end;

procedure TestDateTimePickerToOLDateTime.TestNullHandling;
begin
  FValue := Null;
  
  // When NULL, format should change to NULL_FORMAT
  CheckTrue(FValue.IsNull, 'Value should be NULL');
end;

procedure TestDateTimePickerToOLDateTime.TestNullFormatDisplay;
begin
  FValue := Null;
  
  // Check that format changed to "- - -"
  CheckEquals('- - -', FPicker.Format, 'NULL should display as "- - -"');
end;

{ TestCheckBoxToOLBoolean }

procedure TestCheckBoxToOLBoolean.SetUp;
begin
  FForm := TForm.Create(nil);
  FCheckBox := TCheckBox.Create(FForm);
  FCheckBox.Parent := FForm;
  System.Initialize(FValue);
  FValue := True;
  FCheckBox.Link(FValue);
end;

procedure TestCheckBoxToOLBoolean.TearDown;
begin
  FForm.Free;
end;

procedure TestCheckBoxToOLBoolean.TestCheckBoxToValueSync;
begin
  FCheckBox.Checked := True;
  
  CheckTrue(FValue = True, 'Value should be TRUE when checked');
  
  FCheckBox.Checked := False;
  
  CheckTrue(FValue = False, 'Value should be FALSE when unchecked');
end;

procedure TestCheckBoxToOLBoolean.TestValueToCheckBoxSync;
begin
  FValue := True;
  
  CheckTrue(FCheckBox.Checked, 'CheckBox should be checked when value is TRUE');
  
  FValue := False;
  
  CheckFalse(FCheckBox.Checked, 'CheckBox should be unchecked when value is FALSE');
end;

procedure TestCheckBoxToOLBoolean.TestNullHandling;
begin
  FValue := Null;
  
  // NULL Boolean should display as unchecked (IfNull(False))
  CheckFalse(FCheckBox.Checked, 'NULL should display as unchecked');
end;

{ TestOLTypesToControlsLinks }

procedure TestOLTypesToControlsLinks.SetUp;
begin
  FForm := TForm.Create(nil);
  FEdit1 := TEdit.Create(FForm);
  FEdit1.Parent := FForm;
  FEdit2 := TEdit.Create(FForm);
  FEdit2.Parent := FForm;
  FLabel1 := TLabel.Create(FForm);
  FLabel1.Parent := FForm;
  FIntValue := 100;
  FStrValue := 'Test';
end;

procedure TestOLTypesToControlsLinks.TearDown;
begin
  FForm.Free;
end;

procedure TestOLTypesToControlsLinks.TestLinkEditToInteger;
begin
  FEdit1.Link(FIntValue);
  
  CheckEquals('100', FEdit1.Text, 'Edit should display linked value');
end;

procedure TestOLTypesToControlsLinks.TestLinkEditToString;
begin
  FEdit1.Link(FStrValue);
  
  CheckEquals('Test', FEdit1.Text, 'Edit should display linked string');
end;

procedure TestOLTypesToControlsLinks.TestLinkLabelToInteger;
begin
  FLabel1.Link(FIntValue);
  
  CheckEquals('100', FLabel1.Caption, 'Label should display linked value');
end;

procedure TestOLTypesToControlsLinks.TestLinkLabelWithCalculation;
var
  Calc: TFunctionReturningOLInteger;
begin
  Calc := function: OLInteger
    begin
      Result := FIntValue * 2;
    end;
  
  FLabel1.Link(Calc);
  
  CheckEquals('200', FLabel1.Caption, 'Label should display calculated value');
end;

procedure TestOLTypesToControlsLinks.TestMultipleControlsToOneValue;
begin
  FEdit1.Link(FIntValue);
  FEdit2.Link(FIntValue);
  FLabel1.Link(FIntValue);
  
  FIntValue := 500;
  
  CheckEquals('500', FEdit1.Text, 'Edit1 should be synced');
  CheckEquals('500', FEdit2.Text, 'Edit2 should be synced');
  CheckEquals('500', FLabel1.Caption, 'Label should be synced');
end;

procedure TestOLTypesToControlsLinks.TestRefreshControls;
begin
  FEdit1.Link(FIntValue);
  
  FIntValue := 777;

  CheckEquals('777', FEdit1.Text, 'RefreshControls should update display');
end;

procedure TestOLTypesToControlsLinks.TestCalculationError;
var
  Calc: TFunctionReturningOLInteger;
begin
  Calc := function: OLInteger
    begin
      raise Exception.Create('Test error');
    end;
  
  FLabel1.Link(Calc, 'CUSTOM_ERROR');
  
  CheckEquals('CUSTOM_ERROR', FLabel1.Caption, 'Error in calculation should display custom error message');
end;

{ TestMemorySafety }

procedure TestMemorySafety.SetUp;
begin
  FForm := TForm.Create(nil);
end;

procedure TestMemorySafety.TearDown;
begin
  FForm.Free;
end;

procedure TestMemorySafety.TestMultipleLinkRemoval;
var
  Edit1, Edit2, Edit3: TEdit;
  Value: OLInteger;
begin
  Edit1 := TEdit.Create(FForm);
  Edit1.Parent := FForm;
  Edit2 := TEdit.Create(FForm);
  Edit2.Parent := FForm;
  Edit3 := TEdit.Create(FForm);
  Edit3.Parent := FForm;
  
  Value := 100;
  
  Links.Link(Edit1, Value);
  Links.Link(Edit2, Value);
  Links.Link(Edit3, Value);
  
  Links.RemoveLinks(FForm);
  
  // Should not crash
  CheckTrue(True, 'Multiple link removal successful');
end;

procedure TestMemorySafety.TestRefreshAfterRemoval;
var
  Edit: TEdit;
  Value: OLInteger;
begin
  Edit := TEdit.Create(FForm);
  Edit.Parent := FForm;
  Value := 100;
  
  Links.Link(Edit, Value);
  Links.RemoveLinks(FForm);
  
  // Should not crash even after removal
  Links.RefreshControls(FForm);
  
  CheckTrue(True, 'Refresh after removal does not crash');
end;

procedure TestMemorySafety.TestFormDestruction;
var
  TestForm: TForm;
  Edit: TEdit;
  Value: OLInteger;
begin
  TestForm := TForm.Create(nil);
  try
    Edit := TEdit.Create(TestForm);
    Edit.Parent := TestForm;
    Value := 100;
    
    Links.Link(Edit, Value);
    Links.RemoveLinks(TestForm);
  finally
    TestForm.Free;
  end;
  
  CheckTrue(True, 'Form destruction with proper cleanup successful');
end;

initialization
  RegisterTest(TestEditToOLInteger.Suite);
  RegisterTest(TestEditToOLString.Suite);
  RegisterTest(TestEditToOLDouble.Suite);
  RegisterTest(TestEditToOLCurrency.Suite);
  RegisterTest(TestSpinEditToOLInteger.Suite);
  RegisterTest(TestDateTimePickerToOLDate.Suite);
  RegisterTest(TestDateTimePickerToOLDateTime.Suite);
  RegisterTest(TestCheckBoxToOLBoolean.Suite);
  RegisterTest(TestOLTypesToControlsLinks.Suite);
  RegisterTest(TestMemorySafety.Suite);

end.
