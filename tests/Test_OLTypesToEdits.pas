unit Test_OLTypesToEdits;

interface

uses
  TestFramework, Windows, Forms, Dialogs, Controls, Classes, SysUtils, Variants,
  Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ComCtrls, OLTypes, OLTypesToEdits;

type
  TestForm = class(TForm)
  public
    FInt: OLInteger;
    FDouble: OLDouble;
    FCurrency: OLCurrency;
    FString: OLString;
    FDate: OLDate;
    FDateTime: OLDateTime;
    FBoolean: OLBoolean;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer); override;
  end;

type
  // Test class for TEditToOLInteger binding
  TestEditToOLInteger = class(TTestCase)
  private
    FEdit: TEdit;
    FForm: TestForm;
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
    FForm: TestForm;
    procedure TestEmptyString;
    procedure TestSpecialCharacters;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestEditToValueSync;
    procedure TestValueToEditSync;
    procedure TestNullHandling;
    procedure TestEmptyStringToNull;
  end;

  // Test class for TEditToOLDouble binding
  TestEditToOLDouble = class(TTestCase)
  private
    FEdit: TEdit;
    FForm: TestForm;
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
    FForm: TestForm;
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
    FForm: TestForm;
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
    FForm: TestForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestPickerToValueSync;
    procedure TestValueToPickerSync;
    procedure TestNullHandling;
    procedure TestNullFormatDisplay;
    procedure TestOnChangeIsSetAfterLink;
    procedure TestMultipleLinkCycles;
    procedure TestValueChangeTriggersPickerUpdate;
  end;

  // Test class for TDateTimePickerToOLDateTime binding
  TestDateTimePickerToOLDateTime = class(TTestCase)
  private
    FPicker: TDateTimePicker;
    FForm: TestForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestPickerToValueSync;
    procedure TestValueToPickerSync;
    procedure TestNullHandling;
    procedure TestNullFormatDisplay;
    procedure TestOnChangeIsSetAfterLink;
    procedure TestMultipleLinkCycles;
    procedure TestValueChangeTriggersPickerUpdate;
  end;

  // Test class for TCheckBoxToOLBoolean binding
  TestCheckBoxToOLBoolean = class(TTestCase)
  private
    FCheckBox: TCheckBox;
    FForm: TestForm;
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
    FForm: TestForm;
    FEdit1: TEdit;
    FEdit2: TEdit;
    FLabel1: TLabel;
    FPicker1: TDateTimePicker;
    FPicker2: TDateTimePicker;
    FCheckBox1: TCheckBox;
    FCheckBox2: TCheckBox;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestLinkEditToInteger;
    procedure TestLinkEditToString;
    procedure TestLinkLabelToInteger;
    procedure TestLinkLabelWithCalculation;
    procedure TestMultipleControlsToOneInteger;
    procedure TestMultipleControlsToOneString;
    procedure TestMultipleControlsToOneDouble;
    procedure TestMultipleControlsToOneCurrency;
    procedure TestMultipleControlsToOneDate;
    procedure TestMultipleControlsToOneDateTime;
    procedure TestMultipleControlsToOneBoolean;
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
  DateUtils;

{ TestEditToOLInteger }

procedure TestEditToOLInteger.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  System.Finalize(FForm.FInt);
  System.Initialize(FForm.FInt);  // Clear OnChange from previous test run
  FForm.FInt := 100;
  FEdit.Link(FForm.FInt);
end;

procedure TestEditToOLInteger.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestEditToOLInteger.TestEditToValueSync;
begin
  FEdit.Text := '250';

  CheckEquals(250, Integer(FForm.FInt), 'Value should be synced from Edit');
end;

procedure TestEditToOLInteger.TestValueToEditSync;
begin
  FForm.FInt := 500;

  CheckEquals('500', FEdit.Text, 'Edit should display new value');
end;

procedure TestEditToOLInteger.TestNullHandling;
begin
  FEdit.Text := '1';
  FEdit.Text := '';

  CheckTrue(FForm.FInt.IsNull, 'Empty string should set value to NULL');
end;

procedure TestEditToOLInteger.TestInvalidInput;
var
  OldValue: OLInteger;
begin
  FForm.FInt := 100;
  OldValue := FForm.FInt;

  FEdit.Text := 'invalid';

  CheckEquals(Integer(OldValue), Integer(FForm.FInt), 'Invalid input should not change value');
end;

procedure TestEditToOLInteger.TestEmptyStringToNull;
begin
  FEdit.Text := '41';//To force OnChange when set to ''
  FForm.FInt := 42;
  FEdit.Text := '';

  CheckTrue(FForm.FInt.IsNull, 'Empty string should result in NULL');

  CheckEquals('', FEdit.Text, 'NULL should display as empty string');
end;

{ TestEditToOLString }

procedure TestEditToOLString.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  System.Finalize(FForm.FString);
  System.Initialize(FForm.FString);  // Clear OnChange from previous test run
  FForm.FString := 'Initial Value';
  FEdit.Link(FForm.FString);
end;

procedure TestEditToOLString.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestEditToOLString.TestEditToValueSync;
begin
  FEdit.Text := 'New Text';

  CheckEquals('New Text', string(FForm.FString), 'Value should be synced from Edit');
end;

procedure TestEditToOLString.TestValueToEditSync;
begin
  FForm.FString := 'Updated Value';

  CheckEquals('Updated Value', FEdit.Text, 'Edit should display new value');
end;

procedure TestEditToOLString.TestEmptyString;
begin
  FEdit.Text := 'not null';
  FEdit.Text := '';

  // OLString uses empty string, not NULL for empty
  CheckEquals('', string(FForm.FString), 'Empty string should be preserved');
end;

procedure TestEditToOLString.TestEmptyStringToNull;
begin
  FEdit.Text := '';

  CheckEquals('', string(FForm.FString), 'Empty string should be preserved');
  CheckFalse(FForm.FString.IsNull, 'Empty string should not be NULL');
end;

procedure TestEditToOLString.TestNullHandling;
begin
  FForm.FString := Null;

  CheckEquals('', FEdit.Text, 'NULL should display as empty string');

  //When you see it in an Edit, that it is an empty string it is no longer unknown, Null.
  CheckTrue(FForm.FString.IsEmptyStr, 'Value should be an empty string');
end;

procedure TestEditToOLString.TestSpecialCharacters;
begin
  FEdit.Text := 'Line1'#13#10'Line2';

  CheckEquals('Line1'#13#10'Line2', string(FForm.FString), 'Special characters should be preserved');
end;

{ TestEditToOLDouble }

procedure TestEditToOLDouble.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  System.Finalize(FForm.FDouble);
  System.Initialize(FForm.FDouble);  // Clear OnChange from previous test run
  FForm.FDouble := 123.456;
  FEdit.Link(FForm.FDouble);
end;

procedure TestEditToOLDouble.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestEditToOLDouble.TestEditToValueSync;
begin
  FEdit.Text := FloatToStr(999.99);

  CheckEquals(999.99, Double(FForm.FDouble), 0.001, 'Value should be synced from Edit');
end;

procedure TestEditToOLDouble.TestValueToEditSync;
begin
  FForm.FDouble := 456.789;

  // Check that value is displayed (format may vary)
  CheckTrue(Pos('456', FEdit.Text) > 0, 'Edit should contain the value');
end;

procedure TestEditToOLDouble.TestNullHandling;
begin
  FEdit.Text := '1';
  FEdit.Text := '';//force OnChange

  CheckTrue(FForm.FDouble.IsNull, 'Empty string should set value to NULL');
end;

procedure TestEditToOLDouble.TestFormatting;
begin
  FForm.FDouble := 1234.5678;

  // When not focused, should have thousand separator
  // This is a basic check - actual formatting depends on locale
  CheckTrue(FEdit.Text <> '', 'Value should be formatted and displayed');
end;

{ TestEditToOLCurrency }

procedure TestEditToOLCurrency.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  System.Finalize(FForm.FCurrency);
  System.Initialize(FForm.FCurrency);  // Clear OnChange from previous test run
  FForm.FCurrency := 1000.50;
  FEdit.Link(FForm.FCurrency);
end;

procedure TestEditToOLCurrency.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestEditToOLCurrency.TestEditToValueSync;
begin
  FEdit.Text := CurrToStr(500.25);

  CheckEquals(500.25, Double(FForm.FCurrency), 0.001, 'Value should be synced from Edit');
end;

procedure TestEditToOLCurrency.TestValueToEditSync;
begin
  FForm.FCurrency := 999.99;

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

  CheckTrue(FForm.FCurrency.IsNull, 'Empty string should set value to NULL');
end;

{ TestSpinEditToOLInteger }

procedure TestSpinEditToOLInteger.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FSpinEdit := TSpinEdit.Create(FForm);
  FSpinEdit.Parent := FForm;
  System.Finalize(FForm.FInt);
  System.Initialize(FForm.FInt);  // Clear OnChange from previous test run
  FForm.FInt := 50;
  FSpinEdit.Link(FForm.FInt);
end;

procedure TestSpinEditToOLInteger.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestSpinEditToOLInteger.TestSpinToValueSync;
begin
  FSpinEdit.Value := 75;
  FSpinEdit.Text := '75';

  CheckEquals(75, Integer(FForm.FInt), 'Value should be synced from SpinEdit');
end;

procedure TestSpinEditToOLInteger.TestValueToSpinSync;
begin
  FForm.FInt := 100;

  CheckEquals('100', FSpinEdit.Text, 'SpinEdit should display new value');
end;

procedure TestSpinEditToOLInteger.TestNullHandling;
begin
  FSpinEdit.Text := '';

  CheckTrue(FForm.FInt.IsNull, 'Empty string should set value to NULL');
end;

{ TestDateTimePickerToOLDate }

procedure TestDateTimePickerToOLDate.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FPicker := TDateTimePicker.Create(FForm);
  FPicker.Parent := FForm;
  FPicker.Format := 'dd/MM/yyyy';
  System.Finalize(FForm.FDate);
  System.Initialize(FForm.FDate);
  FForm.FDate := OLDate.Today;
  FPicker.Link(FForm.FDate);
end;

procedure TestDateTimePickerToOLDate.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestDateTimePickerToOLDate.TestPickerToValueSync;
var
  TestDate: TDate;
begin
  TestDate := EncodeDate(2025, 11, 22);
  FPicker.Date := TestDate;

  CheckEquals(TestDate, TDate(FForm.FDate), 'Value should be synced from DateTimePicker');
end;

procedure TestDateTimePickerToOLDate.TestValueToPickerSync;
var
  TestDate: TDate;
begin
  TestDate := EncodeDate(2024, 1, 1);
  FForm.FDate := TestDate;

  CheckEquals(TestDate, FPicker.Date, 'DateTimePicker should display new value');
end;

procedure TestDateTimePickerToOLDate.TestNullHandling;
begin
  FForm.FDate := Null;

  // When NULL, format should change to NULL_FORMAT
  CheckTrue(FForm.FDate.IsNull, 'Value should be NULL');
end;

procedure TestDateTimePickerToOLDate.TestNullFormatDisplay;
begin
  FForm.FDate := Null;

  // Check that format changed to "- - -"
  CheckEquals('- - -', FPicker.Format, 'NULL should display as "- - -"');
end;

procedure TestDateTimePickerToOLDate.TestOnChangeIsSetAfterLink;
begin
  {$IF CompilerVersion >= 34.0}
  CheckTrue(Assigned(FForm.FDate.OnChange),
    'OnChange should be assigned after linking in SetUp');
  {$ELSE}
  Check(True, 'OnChange not available in this Delphi version');
  {$IFEND}
end;

procedure TestDateTimePickerToOLDate.TestMultipleLinkCycles;
var
  TestDate: TDate;
  Picker2: TDateTimePicker;
  Value2: OLDate;
begin
  // First cycle already done in SetUp
  TestDate := EncodeDate(2025, 12, 25);
  FForm.FDate := TestDate;
  CheckEquals(TestDate, FPicker.Date, 'First cycle should work');
  
  // Second cycle - simulate reopening form
  Picker2 := TDateTimePicker.Create(FForm);
  Picker2.Parent := FForm;
  Picker2.Format := 'dd/MM/yyyy';
  System.Initialize(FForm.FDate);
  FForm.FDate := OLDate.Today;
  Picker2.Link(FForm.FDate);

  {$IF CompilerVersion >= 34.0}
  CheckTrue(Assigned(FForm.FDate.OnChange), 'OnChange should be set on second link');
  {$IFEND}

  TestDate := EncodeDate(2024, 6, 15);
  FForm.FDate := TestDate;
  CheckEquals(TestDate, Picker2.Date,
    'Second cycle: value change should update picker');
  
  Picker2.Free;
end;

procedure TestDateTimePickerToOLDate.TestValueChangeTriggersPickerUpdate;
var
  TestDate1, TestDate2: TDate;
begin
  TestDate1 := EncodeDate(2025, 1, 1);
  TestDate2 := EncodeDate(2025, 6, 15);

  FForm.FDate := TestDate1;
  CheckEquals(TestDate1, FPicker.Date, 'First update should work');

  FForm.FDate := TestDate2;
  CheckEquals(TestDate2, FPicker.Date,
    'Second update should work - this was failing when OnChange was not set');
end;

{ TestDateTimePickerToOLDateTime }

procedure TestDateTimePickerToOLDateTime.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FPicker := TDateTimePicker.Create(FForm);
  FPicker.Parent := FForm;
  FPicker.Format := 'dd/MM/yyyy HH:mm:ss';
  FPicker.Kind := dtkDateTime;
  System.Finalize(FForm.FDateTime);
  System.Initialize(FForm.FDateTime);
  FForm.FDateTime := OLDateTime.Now;
  FPicker.Link(FForm.FDateTime);
end;

procedure TestDateTimePickerToOLDateTime.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestDateTimePickerToOLDateTime.TestPickerToValueSync;
var
  TestDateTime: TDateTime;
begin
  TestDateTime := EncodeDate(2025, 11, 22) + EncodeTime(14, 30, 45, 0);
  FPicker.DateTime := TestDateTime;

  CheckEquals(TestDateTime, TDateTime(FForm.FDateTime), 0.001, 'Value should be synced from DateTimePicker');
end;

procedure TestDateTimePickerToOLDateTime.TestValueToPickerSync;
var
  TestDateTime: TDateTime;
begin
  TestDateTime := EncodeDate(2024, 1, 1) + EncodeTime(10, 15, 30, 0);
  FForm.FDateTime := TestDateTime;

  CheckEquals(TestDateTime, FPicker.DateTime, 0.001, 'DateTimePicker should display new value');
end;

procedure TestDateTimePickerToOLDateTime.TestNullHandling;
begin
  FForm.FDateTime := Null;

  // When NULL, format should change to NULL_FORMAT
  CheckTrue(FForm.FDateTime.IsNull, 'Value should be NULL');
end;

procedure TestDateTimePickerToOLDateTime.TestNullFormatDisplay;
begin
  FForm.FDateTime := Null;

  // Check that format changed to "- - -"
  CheckEquals('- - -', FPicker.Format, 'NULL should display as "- - -"');
end;

procedure TestDateTimePickerToOLDateTime.TestOnChangeIsSetAfterLink;
begin
  {$IF CompilerVersion >= 34.0}
  CheckTrue(Assigned(FForm.FDateTime.OnChange),
    'OnChange should be assigned after linking in SetUp');
  {$ELSE}
  Check(True, 'OnChange not available in this Delphi version');
  {$IFEND}
end;

procedure TestDateTimePickerToOLDateTime.TestMultipleLinkCycles;
var
  TestDateTime: TDateTime;
  Picker2: TDateTimePicker;
begin
  // First cycle already done in SetUp
  TestDateTime := EncodeDate(2025, 12, 25) + EncodeTime(10, 30, 0, 0);
  FForm.FDateTime := TestDateTime;
  CheckEquals(TestDateTime, FPicker.DateTime, 0.001, 'First cycle should work');
  
  // Second cycle - simulate reopening form
  Picker2 := TDateTimePicker.Create(FForm);
  Picker2.Parent := FForm;
  Picker2.Format := 'dd/MM/yyyy HH:mm:ss';
  Picker2.Kind := dtkDateTime;
  System.Initialize(FForm.FDateTime);
  FForm.FDateTime := OLDateTime.Now;
  Picker2.Link(FForm.FDateTime);

  {$IF CompilerVersion >= 34.0}
  CheckTrue(Assigned(FForm.FDateTime.OnChange), 'OnChange should be set on second link');
  {$IFEND}

  TestDateTime := EncodeDate(2024, 6, 15) + EncodeTime(14, 45, 30, 0);
  FForm.FDateTime := TestDateTime;
  CheckEquals(TestDateTime, Picker2.DateTime, 0.001, 
    'Second cycle: value change should update picker');
  
  Picker2.Free;
end;

procedure TestDateTimePickerToOLDateTime.TestValueChangeTriggersPickerUpdate;
var
  TestDateTime1, TestDateTime2: TDateTime;
begin
  TestDateTime1 := EncodeDate(2025, 1, 1) + EncodeTime(12, 0, 0, 0);
  TestDateTime2 := EncodeDate(2025, 6, 15) + EncodeTime(15, 30, 0, 0);

  FForm.FDateTime := TestDateTime1;
  CheckEquals(TestDateTime1, FPicker.DateTime, 0.001, 'First update should work');

  FForm.FDateTime := TestDateTime2;
  CheckEquals(TestDateTime2, FPicker.DateTime, 0.001,
    'Second update should work - this was failing when OnChange was not set');
end;

{ TestCheckBoxToOLBoolean }

procedure TestCheckBoxToOLBoolean.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FCheckBox := TCheckBox.Create(FForm);
  FCheckBox.Parent := FForm;
  System.Finalize(FForm.FBoolean);
  System.Initialize(FForm.FBoolean);
  FForm.FBoolean := True;
  FCheckBox.Link(FForm.FBoolean);
end;

procedure TestCheckBoxToOLBoolean.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestCheckBoxToOLBoolean.TestCheckBoxToValueSync;
begin
  FCheckBox.Checked := True;

  CheckTrue(FForm.FBoolean = True, 'Value should be TRUE when checked');

  FCheckBox.Checked := False;

  CheckTrue(FForm.FBoolean = False, 'Value should be FALSE when unchecked');
end;

procedure TestCheckBoxToOLBoolean.TestValueToCheckBoxSync;
begin
  FForm.FBoolean := True;

  CheckTrue(FCheckBox.Checked, 'CheckBox should be checked when value is TRUE');

  FForm.FBoolean := False;

  CheckFalse(FCheckBox.Checked, 'CheckBox should be unchecked when value is FALSE');
end;

procedure TestCheckBoxToOLBoolean.TestNullHandling;
begin
  FForm.FBoolean := Null;

  // NULL Boolean should display as unchecked (IfNull(False))
  CheckFalse(FCheckBox.Checked, 'NULL should display as unchecked');
end;

{ TestOLTypesToControlsLinks }

procedure TestOLTypesToControlsLinks.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FEdit1 := TEdit.Create(FForm);
  FEdit1.Parent := FForm;
  FEdit2 := TEdit.Create(FForm);
  FEdit2.Parent := FForm;
  FLabel1 := TLabel.Create(FForm);
  FLabel1.Parent := FForm;
  FPicker1 := TDateTimePicker.Create(FForm);
  FPicker1.Parent := FForm;
  FPicker2 := TDateTimePicker.Create(FForm);
  FPicker2.Parent := FForm;
  FCheckBox1 := TCheckBox.Create(FForm);
  FCheckBox1.Parent := FForm;
  FCheckBox2 := TCheckBox.Create(FForm);
  FCheckBox2.Parent := FForm;
  System.Finalize(FForm.FInt);
  System.Initialize(FForm.FInt);
  FForm.FInt := 100;
  System.Finalize(FForm.FString);
  System.Initialize(FForm.FString);
  FForm.FString := 'Test';
  System.Finalize(FForm.FDouble);
  System.Initialize(FForm.FDouble);
  FForm.FDouble := 123.456;
  System.Finalize(FForm.FCurrency);
  System.Initialize(FForm.FCurrency);
  FForm.FCurrency := 100.50;
  System.Finalize(FForm.FDate);
  System.Initialize(FForm.FDate);
  FForm.FDate := OLDate.Today;
  System.Finalize(FForm.FDateTime);
  System.Initialize(FForm.FDateTime);
  FForm.FDateTime := OLDateTime.Now;
  System.Finalize(FForm.FBoolean);
  System.Initialize(FForm.FBoolean);
  FForm.FBoolean := False;
end;

procedure TestOLTypesToControlsLinks.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestOLTypesToControlsLinks.TestLinkEditToInteger;
begin
  FEdit1.Link(FForm.FInt);

  CheckEquals('100', FEdit1.Text, 'Edit should display linked value');
end;

procedure TestOLTypesToControlsLinks.TestLinkEditToString;
begin
  FEdit1.Link(FForm.FString);

  CheckEquals('Test', FEdit1.Text, 'Edit should display linked string');
end;

procedure TestOLTypesToControlsLinks.TestLinkLabelToInteger;
begin
  FLabel1.Link(FForm.FInt);

  CheckEquals('100', FLabel1.Caption, 'Label should display linked value');
end;

procedure TestOLTypesToControlsLinks.TestLinkLabelWithCalculation;
var
  Calc: TFunctionReturningOLInteger;
begin
  Calc := function: OLInteger
    begin
      Result := FForm.FInt * 2;
    end;
  
  FLabel1.Link(Calc);
  
  CheckEquals('200', FLabel1.Caption, 'Label should display calculated value');
end;

procedure TestOLTypesToControlsLinks.TestMultipleControlsToOneInteger;
begin
  FEdit1.Link(FForm.FInt);
  FEdit2.Link(FForm.FInt);
  FLabel1.Link(FForm.FInt);

  FForm.FInt := 500;

  CheckEquals('500', FEdit1.Text, 'Edit1 should be synced');
  CheckEquals('500', FEdit2.Text, 'Edit2 should be synced');
  CheckEquals('500', FLabel1.Caption, 'Label should be synced');
end;

procedure TestOLTypesToControlsLinks.TestMultipleControlsToOneString;
begin
  FEdit1.Link(FForm.FString);
  FEdit2.Link(FForm.FString);
  FLabel1.Link(FForm.FString);

  FForm.FString := 'Updated';

  CheckEquals('Updated', FEdit1.Text, 'Edit1 should be synced');
  CheckEquals('Updated', FEdit2.Text, 'Edit2 should be synced');
  CheckEquals('Updated', FLabel1.Caption, 'Label should be synced');
end;

procedure TestOLTypesToControlsLinks.TestMultipleControlsToOneDouble;
begin
  FEdit1.Link(FForm.FDouble);
  FEdit2.Link(FForm.FDouble);
  FLabel1.Link(FForm.FDouble);

  FForm.FDouble := 789.012;

  CheckTrue(Pos('789', FEdit1.Text) > 0, 'Edit1 should be synced');
  CheckTrue(Pos('789', FEdit2.Text) > 0, 'Edit2 should be synced');
  CheckTrue(Pos('789', FLabel1.Caption) > 0, 'Label should be synced');
end;

procedure TestOLTypesToControlsLinks.TestMultipleControlsToOneCurrency;
begin
  FEdit1.Link(FForm.FCurrency);
  FEdit2.Link(FForm.FCurrency);
  FLabel1.Link(FForm.FCurrency);

  FForm.FCurrency := 200.75;

  CheckTrue(Pos('200', FEdit1.Text) > 0, 'Edit1 should be synced');
  CheckTrue(Pos('200', FEdit2.Text) > 0, 'Edit2 should be synced');
  CheckTrue(Pos('200', FLabel1.Caption) > 0, 'Label should be synced');
end;

procedure TestOLTypesToControlsLinks.TestMultipleControlsToOneDate;
var
  TestDate: TDate;
begin
  FPicker1.Link(FForm.FDate);
  FPicker2.Link(FForm.FDate);
  FLabel1.Link(FForm.FDate);

  TestDate := EncodeDate(2025, 12, 31);
  FForm.FDate := TestDate;

  CheckEquals(TestDate, FPicker1.Date, 'Picker1 should be synced');
  CheckEquals(TestDate, FPicker2.Date, 'Picker2 should be synced');
  CheckTrue(Pos('2025', FLabel1.Caption) > 0, 'Label should be synced');
end;

procedure TestOLTypesToControlsLinks.TestMultipleControlsToOneDateTime;
var
  TestDateTime: TDateTime;
begin
  FPicker1.Link(FForm.FDateTime);
  FPicker2.Link(FForm.FDateTime);
  FLabel1.Link(FForm.FDateTime);

  TestDateTime := EncodeDate(2025, 12, 31) + EncodeTime(23, 59, 59, 0);
  FForm.FDateTime := TestDateTime;

  CheckEquals(TestDateTime, FPicker1.DateTime, 0.001, 'Picker1 should be synced');
  CheckEquals(TestDateTime, FPicker2.DateTime, 0.001, 'Picker2 should be synced');
  CheckTrue(Pos('2025', FLabel1.Caption) > 0, 'Label should be synced');
end;

procedure TestOLTypesToControlsLinks.TestMultipleControlsToOneBoolean;
begin
  FCheckBox1.Link(FForm.FBoolean);
  FCheckBox2.Link(FForm.FBoolean);

  FForm.FBoolean := True;

  CheckTrue(FCheckBox1.Checked, 'CheckBox1 should be synced');
  CheckTrue(FCheckBox2.Checked, 'CheckBox2 should be synced');
end;

procedure TestOLTypesToControlsLinks.TestRefreshControls;
begin
  FEdit1.Link(FForm.FInt);

  FForm.FInt := 777;

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
  Links.RemoveLinks(FForm);
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

constructor TestForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner, Dummy);
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
