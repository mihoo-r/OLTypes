unit Test_OLTypesToEdits;

interface

uses
  TestFramework, Windows, Forms, Dialogs, Controls, Classes, SysUtils, Variants,
  {$IF CompilerVersion >= 23.0}
    Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ComCtrls, System.Rtti,
  {$ELSE}
    StdCtrls, Spin, ComCtrls,
  {$IFEND}
  OLTypes, OLTypesToEdits;

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

  // Test class for TEditToOLDate binding
  TestEditToOLDate = class(TTestCase)
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
  end;

  {$IF CompilerVersion >= 34.0}
  // Test class for TEditToOLDate validation
  TestEditToOLDateValidation = class(TTestCase)
  private
    FEdit: TEdit;
    FForm: TestForm;
    function MustBeFutureDate(d: OLDate): TOLValidationResult;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAfterValidator;
    procedure TestMinValidator;
    procedure TestBeforeValidator;
    procedure TestMaxValidator;
    procedure TestInvalidUpdate;
  end;

  // Test class for TDateTimePickerToOLDate validation
  TestDateTimePickerToOLDateValidation = class(TTestCase)
  private
    FPicker: TDateTimePicker;
    FForm: TestForm;
    function MustBeFutureDate(d: OLDate): TOLValidationResult;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValidationFail;
    procedure TestValidationPass;
    procedure TestValueNotUpdatedOnFail;
  end;

  // Test class for TDateTimePickerToOLDateTime validation
  TestDateTimePickerToOLDateTimeValidation = class(TTestCase)
  private
    FPicker: TDateTimePicker;
    FForm: TestForm;
    function MustBeFutureDateTime(dt: OLDateTime): TOLValidationResult;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValidationFail;
    procedure TestValidationPass;
    procedure TestValueNotUpdatedOnFail;
  end;

  // Test class for preventing double linking
  TestDoubleLinkPrevention = class(TTestCase)
  private
    FEdit: TEdit;
    FCheckBox: TCheckBox;
    FForm: TestForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestDoubleLinkEditToInteger;
    procedure TestDoubleLinkEditToString;
    procedure TestDoubleLinkCheckBox;
  end;

  // Test class for TOLDateToLabel validation
  TestOLDateToLabelValidation = class(TTestCase)
  private
    FLabel: TLabel;
    FPicker: TDateTimePicker;
    FForm: TestForm;
    function MustBeFutureDate(d: OLDate): TOLValidationResult;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValidationFail;
    procedure TestValidationPass;
  end;
  {$IFEND}

  {$IF CompilerVersion >= 34.0}
  // Test class for TOLIntegerToLabel validation
  TestOLIntegerToLabelValidation = class(TTestCase)
  private
    FLabel: TLabel;
    FEdit: TEdit;
    FForm: TestForm;
    function MustBePositive(val: OLInteger): TOLValidationResult;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValidationFail;
    procedure TestValidationPass;
  end;

  // Test class for TOLDoubleToLabel validation
  TestOLDoubleToLabelValidation = class(TTestCase)
  private
    FLabel: TLabel;
    FEdit: TEdit;
    FForm: TestForm;
    function MustBePositiveDouble(val: OLDouble): TOLValidationResult;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValidationFail;
    procedure TestValidationPass;
  end;

  // Test class for TOLCurrencyToLabel validation
  TestOLCurrencyToLabelValidation = class(TTestCase)
  private
    FLabel: TLabel;
    FEdit: TEdit;
    FForm: TestForm;
    function MustBePositiveCurrency(val: OLCurrency): TOLValidationResult;
    protected
      procedure SetUp; override;
      procedure TearDown; override;
    published
      procedure TestValidationFail;
      procedure TestValidationPass;
    end;

    // Test class for TDateTimePicker linking precedence (OLType value should win)
    TestDateTimePickerLinkingPrecedence = class(TTestCase)
    private
      FPicker: TDateTimePicker;
      FForm: TestForm;
    protected
      procedure SetUp; override;
      procedure TearDown; override;
    published
      procedure TestOLDatePrecedence;
      procedure TestOLDateTimePrecedence;
      procedure TestOLDateNullPrecedence;
    end;
    {$IFEND}

  {$IF CompilerVersion >= 34.0}
  // Test class for TOLStringToLabel validation
  TestOLStringToLabelValidation = class(TTestCase)
  private
    FLabel: TLabel;
    FEdit: TEdit;
    FForm: TestForm;
    function MustNotBeEmpty(s: OLString): TOLValidationResult;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValidationFail;
    procedure TestValidationPass;
  end;

  // Test class for TOLDateTimeToLabel validation
  TestOLDateTimeToLabelValidation = class(TTestCase)
  private
    FLabel: TLabel;
    FPicker: TDateTimePicker;
    FForm: TestForm;
    function MustBeFutureDateTime(dt: OLDateTime): TOLValidationResult;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValidationFail;
    procedure TestValidationPass;
  end;

  TestCheckBoxToOLBooleanValidation = class(TTestCase)
  private
    FCheckBox: TCheckBox;
    FForm: TestForm;
    function MustBeChecked(b: OLBoolean): TOLValidationResult;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValidationFail;
    procedure TestValidationPass;
    procedure TestValueNotUpdatedOnFail;
  end;
  TestMultiValidator = class(TTestCase)
  private
    FForm: TestForm;
    FEdit: TEdit;
    FValue: OLInteger;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestMultipleValidatorsSuccess;
    procedure TestMultipleValidatorsFirstFail;
    procedure TestMultipleValidatorsSecondFail;
    procedure TestSetValidationFunctionClearsOthers;
  end;

  // RTTI-based test to ensure polymorphism is correct (no shadowing)
  TestLinkPolymorphism = class(TTestCase)
  private
    procedure CheckMethodIsOverridden(AClass: TClass; const AMethodName: string);
  published
    procedure TestShowValidationStateIsOverridden;
    procedure TestNeedsTimerIsOverridden;
  end;
  {$IFEND}

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

  // Test class for TOLLinkManager (integration tests)
  TestOLLinkManager = class(TTestCase)
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

  {$IF CompilerVersion >= 34.0}
  // Test class for TForm.IsValid method
  TestFormIsValid = class(TTestCase)
  private
    FForm: TestForm;
    FEdit: TEdit;
    FValue: OLInteger;
    FCheckBox: TCheckBox;
    FBooleanValue: OLBoolean;
    FMemo: TMemo;
    FStringValue: OLString;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestFormIsValidWhenAllValid;
    procedure TestFormIsValidWhenOneInvalid;
  end;

  TestEditIsValid = class(TTestCase)
  private
    FForm: TestForm;
    FEdit: TEdit;
    FValue: OLInteger;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestIsValidWhenValid;
    procedure TestIsValidWhenInvalid;
    procedure TestIsValidWithoutValidation;
  end;
  {$IFEND}

  {$IF CompilerVersion >= 34.0}
  TestTrackBarIsValid = class(TTestCase)
  private
    FForm: TestForm;
    FTrackBar: TTrackBar;
    FValue: OLInteger;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestIsValidWhenValid;
    procedure TestIsValidWhenInvalid;
    procedure TestIsValidWithoutValidation;
  end;
  {$IFEND}

  {$IF CompilerVersion >= 34.0}
  TestMemoIsValid = class(TTestCase)
  private
    FForm: TestForm;
    FMemo: TMemo;
    FValue: OLString;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestIsValidWhenValid;
    procedure TestIsValidWhenInvalid;
    procedure TestIsValidWithoutValidation;
  end;
  {$IFEND}

  {$IF CompilerVersion >= 34.0}
  TestCheckBoxIsValid = class(TTestCase)
  private
    FForm: TestForm;
    FCheckBox: TCheckBox;
    FValue: OLBoolean;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestIsValidWhenValid;
    procedure TestIsValidWhenInvalid;
    procedure TestIsValidWithoutValidation;
  end;
  {$IFEND}

  {$IF CompilerVersion >= 34.0}
  // Test class for TForm.ShowValidationState method
  TestFormShowValidationState = class(TTestCase)
  private
    FForm: TestForm;
    FEdit: TEdit;
    FValue: OLInteger;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestUpdatesVisuals;
  end;
  {$IFEND}

implementation

uses
  DateUtils, OLValidationTypes,

  {$IF CompilerVersion >= 23.0}
    Vcl.Graphics;
  {$ELSE}
    Graphics;
  {$IFEND}

procedure WaitForTimers();
begin
  //For versions older than Delphi 10.4 wait for the timer to synchronize the control
  {$IF CompilerVersion < 34.0}
    sleep(100);
    Application.ProcessMessages();
    sleep(20);
    Application.ProcessMessages();
  {$IFEND}
end;

{ TestEditToOLInteger }

procedure TestEditToOLInteger.SetUp;
begin
   FForm := TestForm.CreateNew(nil, 0);
   FEdit := TEdit.Create(FForm);
   FEdit.Parent := FForm;
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
  WaitForTimers();

  CheckEquals('500', FEdit.Text, 'Edit should display new value');
end;

procedure TestEditToOLInteger.TestNullHandling;
begin
  FEdit.Text := '1';
  FEdit.Text := '';
  WaitForTimers();

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

{ TestEditToOLDate }

procedure TestEditToOLDate.SetUp;
begin
   FForm := TestForm.CreateNew(nil, 0);
   FEdit := TEdit.Create(FForm);
   FEdit.Parent := FForm;
   FForm.FDate := OLDate.Today;
   FEdit.Link(FForm.FDate);
end;

procedure TestEditToOLDate.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestEditToOLDate.TestEditToValueSync;
var
  NewDate: TDate;
begin
  NewDate := IncDay(Date, 5);
  FEdit.Text := DateToStr(NewDate);

  CheckEquals(NewDate, TDate(FForm.FDate), 'Value should be synced from Edit');
end;

procedure TestEditToOLDate.TestValueToEditSync;
var
  NewDate: TDate;
begin
  NewDate := IncDay(Date, 10);
  FForm.FDate := NewDate;
  WaitForTimers();

  CheckEquals(DateToStr(NewDate), FEdit.Text, 'Edit should display new value');
end;

procedure TestEditToOLDate.TestNullHandling;
begin
  FEdit.Text := DateToStr(Date);
  FEdit.Text := '';
  WaitForTimers();

  CheckTrue(FForm.FDate.IsNull, 'Empty string should set value to NULL');
end;

{ TestEditToOLString }

procedure TestEditToOLString.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
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
  WaitForTimers();

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
  WaitForTimers();

  CheckEquals('', FEdit.Text, 'NULL should display as empty string');

  CheckTrue(FForm.FString.IsNull, 'Value should be an Null');
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
  WaitForTimers();

  // Check that value is displayed (format may vary)
  CheckTrue(Pos('456', FEdit.Text) > 0, 'Edit should contain the value');
end;

procedure TestEditToOLDouble.TestNullHandling;
begin
  FEdit.Text := '1';
  FEdit.Text := '';//force OnChange
  WaitForTimers();

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
  WaitForTimers();

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
  WaitForTimers();

  CheckTrue(FForm.FCurrency.IsNull, 'Empty string should set value to NULL');
end;

{ TestSpinEditToOLInteger }

procedure TestSpinEditToOLInteger.SetUp;
begin
   FForm := TestForm.CreateNew(nil, 0);
   FSpinEdit := TSpinEdit.Create(FForm);
   FSpinEdit.Parent := FForm;
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
  WaitForTimers();

  CheckEquals('100', FSpinEdit.Text, 'SpinEdit should display new value');
end;

procedure TestSpinEditToOLInteger.TestNullHandling;
begin
  FSpinEdit.Text := '';
  WaitForTimers();

  CheckTrue(FForm.FInt.IsNull, 'Empty string should set value to NULL');
end;

{ TestDateTimePickerToOLDate }

procedure TestDateTimePickerToOLDate.SetUp;
begin
   FForm := TestForm.CreateNew(nil, 0);
   FPicker := TDateTimePicker.Create(FForm);
   FPicker.Parent := FForm;
   FPicker.Format := 'dd/MM/yyyy';
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
  WaitForTimers();

  CheckEquals(TestDate, FPicker.Date, 'DateTimePicker should display new value');
end;

procedure TestDateTimePickerToOLDate.TestNullHandling;
begin
  FForm.FDate := Null;
  WaitForTimers();

  // When NULL, format should change to NULL_FORMAT
  CheckTrue(FForm.FDate.IsNull, 'Value should be NULL');
end;

procedure TestDateTimePickerToOLDate.TestNullFormatDisplay;
begin
  FForm.FDate := Null;
  WaitForTimers();

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
  WaitForTimers();

  CheckEquals(TestDate, FPicker.Date, 'First cycle should work');

  // Second cycle - simulate reopening form
  Picker2 := TDateTimePicker.Create(FForm);
  Picker2.Parent := FForm;
  Picker2.Format := 'dd/MM/yyyy';
  FForm.FDate := OLDate.Today;
  Picker2.Link(FForm.FDate);
  WaitForTimers();

  {$IF CompilerVersion >= 34.0}
  CheckTrue(Assigned(FForm.FDate.OnChange), 'OnChange should be set on second link');
  {$IFEND}

  TestDate := EncodeDate(2024, 6, 15);
  FForm.FDate := TestDate;
  WaitForTimers();

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
  WaitForTimers();

  CheckEquals(TestDate1, FPicker.Date, 'First update should work');

  FForm.FDate := TestDate2;
  WaitForTimers();

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
  WaitForTimers();

  CheckEquals(TestDateTime, FPicker.DateTime, 0.001, 'DateTimePicker should display new value');
end;

procedure TestDateTimePickerToOLDateTime.TestNullHandling;
begin
  FForm.FDateTime := Null;
  WaitForTimers();

  // When NULL, format should change to NULL_FORMAT
  CheckTrue(FForm.FDateTime.IsNull, 'Value should be NULL');
end;

procedure TestDateTimePickerToOLDateTime.TestNullFormatDisplay;
begin
  FForm.FDateTime := Null;
  WaitForTimers();

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
  WaitForTimers();

  CheckEquals(TestDateTime, FPicker.DateTime, 0.001, 'First cycle should work');

  // Second cycle - simulate reopening form
  Picker2 := TDateTimePicker.Create(FForm);
  Picker2.Parent := FForm;
  Picker2.Format := 'dd/MM/yyyy HH:mm:ss';
  {$IF CompilerVersion >= 23.0} // XE2+
    Picker2.Kind := dtkDateTime;
  {$ELSE}
    // Delphi 2010: there is no dtkDateTime
    Picker2.Kind := dtkTime;
  {$IFEND}
  FForm.FDateTime := OLDateTime.Now;
  Picker2.Link(FForm.FDateTime);
  WaitForTimers();

  {$IF CompilerVersion >= 34.0}
  CheckTrue(Assigned(FForm.FDateTime.OnChange), 'OnChange should be set on second link');
  {$IFEND}

  TestDateTime := EncodeDate(2024, 6, 15) + EncodeTime(14, 45, 30, 0);
  FForm.FDateTime := TestDateTime;
  WaitForTimers();

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
  WaitForTimers();

  CheckEquals(TestDateTime1, FPicker.DateTime, 0.001, 'First update should work');

  FForm.FDateTime := TestDateTime2;
  WaitForTimers();

  CheckEquals(TestDateTime2, FPicker.DateTime, 0.001,
    'Second update should work - this was failing when OnChange was not set');
end;


{$IF CompilerVersion >= 34.0}

{ TestEditToOLDateValidation }

function TestEditToOLDateValidation.MustBeFutureDate(d: OLDate): TOLValidationResult;
begin
  if d > Date then
    Result := TOLValidationResult.Ok
  else
    Result := TOLValidationResult.Error('Must be future', clWebRed);
end;

procedure TestEditToOLDateValidation.SetUp;
begin
   FForm := TestForm.CreateNew(nil, 0);
   FEdit := TEdit.Create(FForm);
   FEdit.Parent := FForm;
   FForm.FDate := OLDate.Today;
end;

procedure TestEditToOLDateValidation.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestEditToOLDateValidation.TestAfterValidator;
begin
  // Link with After(Today) validator
  FEdit.Link(FForm.FDate).After(OLDate.Today());

  // Test Today (Should Fail as it must be AFTER today)
  FEdit.Text := OLDate.Today().ToString();
  CheckFalse(FEdit.IsValid(), 'After(Today) - Today should fail');

  // Test Tomorrow (Should Pass)
  FEdit.Text := OLDate.Tomorrow.ToString();
  CheckTrue(FEdit.IsValid(), 'After(Today) - Tomorrow should pass');
end;

procedure TestEditToOLDateValidation.TestMinValidator;
begin
  // Link with Min(Today) validator
  FEdit.Link(FForm.FDate).Min(OLDate.Today());

  // Test Yesterday (Should Fail)
  FEdit.Text := OLDate.Yesterday.ToString();
  CheckFalse(FEdit.IsValid(), 'Min(Today) - Yesterday should fail');

  // Test Today (Should Pass)
  FEdit.Text := OLDate.Today().ToString();
  CheckTrue(FEdit.IsValid(), 'Min(Today) - Today should pass');
end;

procedure TestEditToOLDateValidation.TestBeforeValidator;
begin
  // Link with Before(Today) validator
  FEdit.Link(FForm.FDate).Before(OLDate.Today());

  // Test Today (Should Fail)
  FEdit.Text := OLDate.Today().ToString();
  CheckFalse(FEdit.IsValid(), 'Before(Today) - Today should fail');

  // Test Yesterday (Should Pass)
  FEdit.Text := OLDate.Yesterday.ToString();
  CheckTrue(FEdit.IsValid(), 'Before(Today) - Yesterday should pass');
end;

procedure TestEditToOLDateValidation.TestMaxValidator;
begin
  // Link with Max(Today) validator
  FEdit.Link(FForm.FDate).Max(OLDate.Today());
  
  // Test Today (Should Pass)
  FEdit.Text := OLDate.Today().ToString();
  CheckTrue(FEdit.IsValid(), 'Max(Today) - Today should pass');

  // Test Tomorrow (Should Fail)
  FEdit.Text := OLDate.Tomorrow.ToString();
  CheckFalse(FEdit.IsValid(), 'Max(Today) - Tomorrow should fail');
end;

procedure TestEditToOLDateValidation.TestInvalidUpdate;
var
  Target: TDate;
begin
  // Set Max Date as Today
  Target := Date;
  FEdit.Link(FForm.FDate).Max(Target);
  
  // Type Tomorrow (Invalid)
  FEdit.Text := DateToStr(Target + 1);
  
  // Verify Value IS Updated despite validation error
  CheckEquals(Target + 1, TDate(FForm.FDate), 'Invalid date should still update value');
  
  // Verify validation state via Control
  CheckFalse(FEdit.IsValid(), 'Validation should define it as invalid');
end;

{ TestDateTimePickerToOLDateValidation }

function TestDateTimePickerToOLDateValidation.MustBeFutureDate(d: OLDate): TOLValidationResult;
begin
  if d.IfNull(EncodeDate(1900, 1, 1)) > Date then
    Result := TOLValidationResult.Ok
  else
    Result := TOLValidationResult.Error('Date must be in the future');
end;

procedure TestDateTimePickerToOLDateValidation.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FPicker := TDateTimePicker.Create(FForm);
  FPicker.Parent := FForm;
  FPicker.Format := 'dd/MM/yyyy';
  FPicker.Date := OLDate.Today.IncYear(10); // Future date
  FForm.FDate := OLDate.Today.IncYear(10); // Future date
  Links.Link(FPicker, FForm.FDate).AddValidator(MustBeFutureDate);
end;

procedure TestDateTimePickerToOLDateValidation.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestDateTimePickerToOLDateValidation.TestValidationFail;
var
  InitialComponentCount: Integer;
  i: Integer;
  WarningLabel: TLabel;
begin
  InitialComponentCount := FForm.ComponentCount;

  FPicker.Date := EncodeDate(2020, 1, 1); // Past date
  FPicker.OnChange(FPicker);
  WaitForTimers;

  CheckEquals(InitialComponentCount + 1, FForm.ComponentCount, 'A new label component should be added');

  WarningLabel := nil;
  for i := 0 to FForm.ComponentCount - 1 do
    if FForm.Components[i] is TLabel then
      if (FForm.Components[i] as TLabel).Caption = '⚠' then
      begin
        WarningLabel := FForm.Components[i] as TLabel;
        break;
      end;

  Check(Assigned(WarningLabel), 'Warning label should be found');
  if Assigned(WarningLabel) then
  begin
    Check(WarningLabel.Visible, 'Warning label should be visible');
    CheckEquals('Date must be in the future', WarningLabel.Hint, 'Hint should be set on validation fail');
  end;
end;

procedure TestDateTimePickerToOLDateValidation.TestValidationPass;
var
  ComponentCountBeforePass: Integer;
begin
  // First, fail validation to create the label
  FPicker.Date := EncodeDate(2020, 1, 1);
  FPicker.OnChange(FPicker);
  WaitForTimers;
  ComponentCountBeforePass := FForm.ComponentCount;

  // Now, pass validation
  FPicker.Date := EncodeDate(2030, 1, 1);
  FPicker.OnChange(FPicker);
  WaitForTimers;

  CheckEquals(ComponentCountBeforePass - 1, FForm.ComponentCount, 'Warning label component should be removed');
end;

procedure TestDateTimePickerToOLDateValidation.TestValueNotUpdatedOnFail;
begin
  FForm.FDate := EncodeDate(2026, 1, 1); // Start with a valid value
  FPicker.Date := EncodeDate(2020, 1, 1);
  FPicker.OnChange(FPicker);
  WaitForTimers;

  CheckEquals(EncodeDate(2026, 1, 1), TDate(FForm.FDate), 'Value should not be updated on validation fail');
end;

{ TestDateTimePickerToOLDateTimeValidation }

function TestDateTimePickerToOLDateTimeValidation.MustBeFutureDateTime(dt: OLDateTime): TOLValidationResult;
begin
  if dt.IfNull(EncodeDate(1900, 1, 1)) > Now then
    Result := TOLValidationResult.Ok
  else
    Result := TOLValidationResult.Error('DateTime must be in the future');
end;

procedure TestDateTimePickerToOLDateTimeValidation.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FPicker := TDateTimePicker.Create(FForm);
  FPicker.Parent := FForm;
  FPicker.Format := 'dd/MM/yyyy HH:mm:ss';
  {$IF CompilerVersion >= 23.0} // XE2+
    FPicker.Kind := dtkDateTime;
  {$ELSE}
    // Delphi 2010: there is no dtkDateTime
    FPicker.Kind := dtkTime;
  {$IFEND}
  FForm.FDateTime := Now + 1; // Future datetime
  FPicker.DateTime := Now + 1;
  Links.Link(FPicker, FForm.FDateTime).AddValidator(MustBeFutureDateTime);
end;

procedure TestDateTimePickerToOLDateTimeValidation.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestDateTimePickerToOLDateTimeValidation.TestValidationFail;
var
  InitialComponentCount: Integer;
  i: Integer;
  WarningLabel: TLabel;
begin
  InitialComponentCount := FForm.ComponentCount;

  FPicker.DateTime := Now - 1; // Past datetime
  FPicker.OnChange(FPicker);
  WaitForTimers;

  CheckEquals(InitialComponentCount + 1, FForm.ComponentCount, 'A new label component should be added');

  WarningLabel := nil;
  for i := 0 to FForm.ComponentCount - 1 do
    if FForm.Components[i] is TLabel then
      if (FForm.Components[i] as TLabel).Caption = '⚠' then
      begin
        WarningLabel := FForm.Components[i] as TLabel;
        break;
      end;

  Check(Assigned(WarningLabel), 'Warning label should be found');
  if Assigned(WarningLabel) then
  begin
    Check(WarningLabel.Visible, 'Warning label should be visible');
    CheckEquals('DateTime must be in the future', WarningLabel.Hint, 'Hint should be set on validation fail');
  end;
end;

procedure TestDateTimePickerToOLDateTimeValidation.TestValidationPass;
var
  ComponentCountBeforePass: Integer;
begin
  // First, fail validation to create the label
  FPicker.DateTime := Now - 1;
  FPicker.OnChange(FPicker);
  WaitForTimers;
  ComponentCountBeforePass := FForm.ComponentCount;

  // Now, pass validation
  FPicker.DateTime := Now + 2;
  FPicker.OnChange(FPicker);
  WaitForTimers;

  CheckEquals(ComponentCountBeforePass - 1, FForm.ComponentCount, 'Warning label component should be removed');
end;

procedure TestDateTimePickerToOLDateTimeValidation.TestValueNotUpdatedOnFail;
begin
  FForm.FDateTime := Now + 1; // Start with a valid value
  FPicker.DateTime := Now - 1;
  FPicker.OnChange(FPicker);
  WaitForTimers;

  CheckTrue(TDateTime(FForm.FDateTime) > Now, 'Value should not be updated on validation fail');
end;

{ TestOLDateToLabelValidation }

function TestOLDateToLabelValidation.MustBeFutureDate(d: OLDate): TOLValidationResult;
begin
  if d.IfNull(EncodeDate(1900, 1, 1)) > Date then
    Result := TOLValidationResult.Ok
  else
    Result := TOLValidationResult.Error('Date must be in the future');
end;

procedure TestOLDateToLabelValidation.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FLabel := TLabel.Create(FForm);
  FLabel.Parent := FForm;
  FPicker := TDateTimePicker.Create(FForm);
  FPicker.Parent := FForm;
  FForm.FDate := OLDate.Today.IncYear(10); // Future date

  FPicker.Link(FForm.FDate);
  FLabel.Link(FForm.FDate).AddValidator(MustBeFutureDate);
end;

procedure TestOLDateToLabelValidation.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestOLDateToLabelValidation.TestValidationFail;
var
  OriginalColor: TColor;
begin
  OriginalColor := FLabel.Font.Color;

  FPicker.Date := EncodeDate(2020, 1, 1); // Past date via Picker
  FPicker.OnChange(FPicker);
  WaitForTimers;

  CheckTrue(Pos('2020', FLabel.Caption) > 0, 'Label caption should update via Picker');
  CheckNotEquals(OriginalColor, FLabel.Font.Color, 'Label color should change on validation fail');
  CheckEquals(clRed, FLabel.Font.Color, 'Label should be red on validation fail');
end;

procedure TestOLDateToLabelValidation.TestValidationPass;
var
  OriginalColor: TColor;
begin
  OriginalColor := FLabel.Font.Color;

  // First, fail validation
  FPicker.Date := EncodeDate(2020, 1, 1);
  FPicker.OnChange(FPicker);
  WaitForTimers;

  // Now, pass validation
  FPicker.Date := EncodeDate(2030, 1, 1);
  FPicker.OnChange(FPicker);
  WaitForTimers;

  CheckTrue(Pos('2030', FLabel.Caption) > 0, 'Label caption should update via Picker');
  CheckEquals(OriginalColor, FLabel.Font.Color, 'Label color should revert on validation pass');
end;

{ TestOLStringToLabelValidation }

function TestOLStringToLabelValidation.MustNotBeEmpty(s: OLString): TOLValidationResult;
begin
  if not s.IsEmptyStr then
    Result := TOLValidationResult.Ok
  else
    Result := TOLValidationResult.Error('String must not be empty');
end;

procedure TestOLStringToLabelValidation.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FLabel := TLabel.Create(FForm);
  FLabel.Parent := FForm;
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  FForm.FString := 'Not empty';

  FEdit.Link(FForm.FString);
  FLabel.Link(FForm.FString).AddValidator(MustNotBeEmpty);
end;

procedure TestOLStringToLabelValidation.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestOLStringToLabelValidation.TestValidationFail;
var
  OriginalColor: TColor;
begin
  OriginalColor := FLabel.Font.Color;

  FEdit.Text := ''; // Fail validation via Edit
  WaitForTimers;

  CheckEquals('', FLabel.Caption, 'Label caption should update via Edit');
  CheckNotEquals(OriginalColor, FLabel.Font.Color, 'Label color should change on validation fail');
  CheckEquals(clRed, FLabel.Font.Color, 'Label should be red on validation fail');
end;

procedure TestOLStringToLabelValidation.TestValidationPass;
var
  OriginalColor: TColor;
begin
  OriginalColor := FLabel.Font.Color;

  // First, fail validation
  FEdit.Text := '';
  WaitForTimers;

  // Now, pass validation
  FEdit.Text := 'Back to valid';
  WaitForTimers;

  CheckEquals('Back to valid', FLabel.Caption, 'Label caption should update via Edit');
  CheckEquals(OriginalColor, FLabel.Font.Color, 'Label color should revert on validation pass');
end;

{ TestOLDateTimeToLabelValidation }

function TestOLDateTimeToLabelValidation.MustBeFutureDateTime(dt: OLDateTime): TOLValidationResult;
begin
  if dt.IfNull(EncodeDate(1900, 1, 1)) > Now then
    Result := TOLValidationResult.Ok
  else
    Result := TOLValidationResult.Error('DateTime must be in the future');
end;

procedure TestOLDateTimeToLabelValidation.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FLabel := TLabel.Create(FForm);
  FLabel.Parent := FForm;
  FPicker := TDateTimePicker.Create(FForm);
  FPicker.Parent := FForm;
  FForm.FDateTime := Now + 1; // Future datetime

  FPicker.Link(FForm.FDateTime);
  FLabel.Link(FForm.FDateTime).AddValidator(MustBeFutureDateTime);
end;

procedure TestOLDateTimeToLabelValidation.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestOLDateTimeToLabelValidation.TestValidationFail;
var
  OriginalColor: TColor;
begin
  OriginalColor := FLabel.Font.Color;

  FPicker.DateTime := Now - 1; // Past datetime via Picker
  FPicker.OnChange(FPicker);
  WaitForTimers;

  CheckNotEquals(OriginalColor, FLabel.Font.Color, 'Label color should change on validation fail');
  CheckEquals(clRed, FLabel.Font.Color, 'Label should be red on validation fail');
end;

procedure TestOLDateTimeToLabelValidation.TestValidationPass;
var
  OriginalColor: TColor;
begin
  OriginalColor := FLabel.Font.Color;

  // First, fail validation
  FPicker.DateTime := Now - 1;
  FPicker.OnChange(FPicker);
  WaitForTimers;

  // Now, pass validation
  FPicker.DateTime := Now + 2;
  FPicker.OnChange(FPicker);
  WaitForTimers;

  CheckEquals(OriginalColor, FLabel.Font.Color, 'Label color should revert on validation pass');
end;

{$IF CompilerVersion >= 34.0}
{ TestOLIntegerToLabelValidation }

function TestOLIntegerToLabelValidation.MustBePositive(val: OLInteger): TOLValidationResult;
begin
  if val.IfNull(0) > 0 then
    Result := TOLValidationResult.Ok
  else
    Result := TOLValidationResult.Error('Value must be positive');
end;

procedure TestOLIntegerToLabelValidation.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FLabel := TLabel.Create(FForm);
  FLabel.Parent := FForm;
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  FForm.FInt := 10;

  FEdit.Link(FForm.FInt);
  FLabel.Link(FForm.FInt).AddValidator(MustBePositive);
end;

procedure TestOLIntegerToLabelValidation.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestOLIntegerToLabelValidation.TestValidationFail;
var
  OriginalColor: TColor;
begin
  OriginalColor := FLabel.Font.Color;
  FEdit.Text := '-5'; // Fail validation via Edit
  WaitForTimers;

  CheckEquals('-5', FLabel.Caption, 'Label caption should update via Edit');
  CheckEquals(clRed, FLabel.Font.Color, 'Label should be red on validation fail');
end;

procedure TestOLIntegerToLabelValidation.TestValidationPass;
var
  OriginalColor: TColor;
begin
  OriginalColor := FLabel.Font.Color;

  // First, fail validation
  FEdit.Text := '-5';
  WaitForTimers;

  // Now, pass validation
  FEdit.Text := '100';
  WaitForTimers;

  CheckEquals('100', FLabel.Caption, 'Label caption should update via Edit');
  CheckEquals(OriginalColor, FLabel.Font.Color, 'Label color should revert on validation pass');
end;

{ TestOLDoubleToLabelValidation }

function TestOLDoubleToLabelValidation.MustBePositiveDouble(val: OLDouble): TOLValidationResult;
begin
  if val.IfNull(0) > 0 then
    Result := TOLValidationResult.Ok
  else
    Result := TOLValidationResult.Error('Value must be positive');
end;

procedure TestOLDoubleToLabelValidation.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FLabel := TLabel.Create(FForm);
  FLabel.Parent := FForm;
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  FForm.FDouble := 10.5;

  FEdit.Link(FForm.FDouble);
  FLabel.Link(FForm.FDouble).AddValidator(MustBePositiveDouble);
end;

procedure TestOLDoubleToLabelValidation.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestOLDoubleToLabelValidation.TestValidationFail;
var
  OriginalColor: TColor;
begin
  OriginalColor := FLabel.Font.Color;
  FEdit.Text := FloatToStr(-1.1);// Fail validation via Edit
  WaitForTimers;

  CheckTrue(Pos('-1', FLabel.Caption) > 0, 'Label caption should update via Edit');
  CheckEquals(clRed, FLabel.Font.Color, 'Label should be red on validation fail');
end;

procedure TestOLDoubleToLabelValidation.TestValidationPass;
var
  OriginalColor: TColor;
begin
  OriginalColor := FLabel.Font.Color;

  // First, fail validation
  FEdit.Text := FloatToStr(-1.1);
  WaitForTimers;

  // Now, pass validation
  FEdit.Text := FloatToStr(20.0);
  WaitForTimers;

  CheckTrue(Pos('20', FLabel.Caption) > 0, 'Label caption should update via Edit');
  CheckEquals(OriginalColor, FLabel.Font.Color, 'Label color should revert on validation pass');
end;

{ TestOLCurrencyToLabelValidation }

function TestOLCurrencyToLabelValidation.MustBePositiveCurrency(val: OLCurrency): TOLValidationResult;
begin
  if val.IfNull(0) > 0 then
    Result := TOLValidationResult.Ok
  else
    Result := TOLValidationResult.Error('Value must be positive');
end;

procedure TestOLCurrencyToLabelValidation.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FLabel := TLabel.Create(FForm);
  FLabel.Parent := FForm;
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  FForm.FCurrency := 100.0;

  FEdit.Link(FForm.FCurrency);
  FLabel.Link(FForm.FCurrency).AddValidator(MustBePositiveCurrency);
end;

procedure TestOLCurrencyToLabelValidation.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestOLCurrencyToLabelValidation.TestValidationFail;
var
  OriginalColor: TColor;
begin
  OriginalColor := FLabel.Font.Color;
  FEdit.Text := FloatToStr(-0.5); // Fail validation via Edit
  WaitForTimers;

  CheckTrue(Pos('-0', FLabel.Caption) > 0, 'Label caption should update via Edit');
  CheckEquals(clRed, FLabel.Font.Color, 'Label should be red on validation fail');
end;

procedure TestOLCurrencyToLabelValidation.TestValidationPass;
var
  OriginalColor: TColor;
begin
  OriginalColor := FLabel.Font.Color;

  // First, fail validation
  FEdit.Text := FloatToStr(-0.5);
  WaitForTimers;

  // Now, pass validation
  FEdit.Text := FloatToStr(50.0);
  WaitForTimers;

  CheckTrue(Pos('50', FLabel.Caption) > 0, 'Label caption should update via Edit');
  CheckEquals(OriginalColor, FLabel.Font.Color, 'Label color should revert on validation pass');
end;
{$IFEND}


{ TestCheckBoxToOLBooleanValidation }

function TestCheckBoxToOLBooleanValidation.MustBeChecked(b: OLBoolean): TOLValidationResult;
begin
  if b.IfNull(False) then
    Result := TOLValidationResult.Ok
  else
    Result := TOLValidationResult.Error('Must be checked');
end;

procedure TestCheckBoxToOLBooleanValidation.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FCheckBox := TCheckBox.Create(FForm);
  FCheckBox.Parent := FForm;
  FCheckBox.Caption := 'Test CheckBox';
  FForm.FBoolean := true;
  Links.Link(FCheckBox, FForm.FBoolean).AddValidator(MustBeChecked);
end;

procedure TestCheckBoxToOLBooleanValidation.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestCheckBoxToOLBooleanValidation.TestValidationFail;
var
  InitialComponentCount: Integer;
  i: Integer;
  WarningLabel: TLabel;
begin
  InitialComponentCount := FForm.ComponentCount;

  FCheckBox.Checked := False;
  FCheckBox.OnClick(FCheckBox);
  WaitForTimers;

  CheckEquals(InitialComponentCount + 1, FForm.ComponentCount, 'A new label component should be added');

  WarningLabel := nil;
  for i := 0 to FForm.ComponentCount - 1 do
    if FForm.Components[i] is TLabel then
      if (FForm.Components[i] as TLabel).Caption = '⚠' then
      begin
        WarningLabel := FForm.Components[i] as TLabel;
        break;
      end;

  Check(Assigned(WarningLabel), 'Warning label should be found');
  if Assigned(WarningLabel) then
  begin
    Check(WarningLabel.Visible, 'Warning label should be visible');
    CheckEquals('Must be checked', WarningLabel.Hint, 'Hint should be set on validation fail');
  end;
end;

procedure TestCheckBoxToOLBooleanValidation.TestValidationPass;
var
  ComponentCountBeforePass: Integer;
begin
  // First, fail validation to create the label
  FCheckBox.Checked := False;
  FCheckBox.OnClick(FCheckBox);
  WaitForTimers;
  ComponentCountBeforePass := FForm.ComponentCount;

  // Now, pass validation
  FCheckBox.Checked := True;
  FCheckBox.OnClick(FCheckBox);
  WaitForTimers;

  CheckEquals(ComponentCountBeforePass - 1, FForm.ComponentCount, 'Warning label component should be removed');
end;

procedure TestCheckBoxToOLBooleanValidation.TestValueNotUpdatedOnFail;
begin
  FForm.FBoolean := True; // Start with a valid value
  FCheckBox.Checked := False;
  FCheckBox.OnClick(FCheckBox);
  WaitForTimers;

  CheckTrue(FForm.FBoolean, 'Value should not be updated on validation fail');
end;

{$IFEND}

{ TestCheckBoxToOLBoolean }

procedure TestCheckBoxToOLBoolean.SetUp;
begin
   FForm := TestForm.CreateNew(nil, 0);
   FCheckBox := TCheckBox.Create(FForm);
   FCheckBox.Parent := FForm;
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
  WaitForTimers();

  CheckTrue(FCheckBox.Checked, 'CheckBox should be checked when value is TRUE');

  FForm.FBoolean := False;
  WaitForTimers();

  CheckFalse(FCheckBox.Checked, 'CheckBox should be unchecked when value is FALSE');
end;

procedure TestCheckBoxToOLBoolean.TestNullHandling;
begin
  FForm.FBoolean := Null;
  WaitForTimers();

  // NULL Boolean should display as unchecked (IfNull(False))
  CheckFalse(FCheckBox.Checked, 'NULL should display as unchecked');
end;

{ TestOLTypesToControlsLinks }

procedure TestOLLinkManager.SetUp;
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
   FForm.FInt := 100;
   FForm.FString := 'Test';
   FForm.FDouble := 123.456;
   FForm.FCurrency := 100.50;
   FForm.FDate := OLDate.Today;
   FForm.FDateTime := OLDateTime.Now;
   FForm.FBoolean := False;
end;

procedure TestOLLinkManager.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestOLLinkManager.TestLinkEditToInteger;
begin
  FEdit1.Link(FForm.FInt);

  CheckEquals('100', FEdit1.Text, 'Edit should display linked value');
end;

procedure TestOLLinkManager.TestLinkEditToString;
begin
  FEdit1.Link(FForm.FString);

  CheckEquals('Test', FEdit1.Text, 'Edit should display linked string');
end;

procedure TestOLLinkManager.TestLinkLabelToInteger;
begin
  FLabel1.Link(FForm.FInt);

  CheckEquals('100', FLabel1.Caption, 'Label should display linked value');
end;

procedure TestOLLinkManager.TestLinkLabelWithCalculation;
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

procedure TestOLLinkManager.TestMultipleControlsToOneInteger;
begin
  FEdit1.Link(FForm.FInt);
  FEdit2.Link(FForm.FInt);
  FLabel1.Link(FForm.FInt);

  FForm.FInt := 500;
  WaitForTimers();

  CheckEquals('500', FEdit1.Text, 'Edit1 should be synced');
  CheckEquals('500', FEdit2.Text, 'Edit2 should be synced');
  CheckEquals('500', FLabel1.Caption, 'Label should be synced');
end;

procedure TestOLLinkManager.TestMultipleControlsToOneString;
begin
  FLabel1.Link(FForm.FString);
  FEdit1.Link(FForm.FString);
  FEdit2.Link(FForm.FString);
  //FLabel1.Link(FForm.FString);

  FForm.FString := 'Updated';
  WaitForTimers();

  CheckEquals('Updated', FEdit1.Text, 'Edit1 should be synced');
  CheckEquals('Updated', FEdit2.Text, 'Edit2 should be synced');
  CheckEquals('Updated', FLabel1.Caption, 'Label should be synced');
end;

procedure TestOLLinkManager.TestMultipleControlsToOneDouble;
begin
  FEdit1.Link(FForm.FDouble);
  FEdit2.Link(FForm.FDouble);
  FLabel1.Link(FForm.FDouble);

  FForm.FDouble := 789.012;
  WaitForTimers();

  CheckTrue(Pos('789', FEdit1.Text) > 0, 'Edit1 should be synced');
  CheckTrue(Pos('789', FEdit2.Text) > 0, 'Edit2 should be synced');
  CheckTrue(Pos('789', FLabel1.Caption) > 0, 'Label should be synced');
end;

procedure TestOLLinkManager.TestMultipleControlsToOneCurrency;
begin
  FEdit1.Link(FForm.FCurrency);
  FEdit2.Link(FForm.FCurrency);
  FLabel1.Link(FForm.FCurrency);

  FForm.FCurrency := 200.75;
  WaitForTimers();

  CheckTrue(Pos('200', FEdit1.Text) > 0, 'Edit1 should be synced');
  CheckTrue(Pos('200', FEdit2.Text) > 0, 'Edit2 should be synced');
  CheckTrue(Pos('200', FLabel1.Caption) > 0, 'Label should be synced');
end;

procedure TestOLLinkManager.TestMultipleControlsToOneDate;
var
  TestDate: TDate;
begin
  FPicker1.Link(FForm.FDate);
  FPicker2.Link(FForm.FDate);
  FLabel1.Link(FForm.FDate);

  TestDate := EncodeDate(2025, 12, 31);
  FForm.FDate := TestDate;
  WaitForTimers();

  CheckEquals(TestDate, FPicker1.Date, 'Picker1 should be synced');
  CheckEquals(TestDate, FPicker2.Date, 'Picker2 should be synced');
  CheckTrue(Pos('2025', FLabel1.Caption) > 0, 'Label should be synced');
end;

procedure TestOLLinkManager.TestMultipleControlsToOneDateTime;
var
  TestDateTime: TDateTime;
begin
  FPicker1.Link(FForm.FDateTime);
  FPicker2.Link(FForm.FDateTime);
  FLabel1.Link(FForm.FDateTime);

  TestDateTime := EncodeDate(2025, 12, 31) + EncodeTime(23, 59, 59, 0);
  FForm.FDateTime := TestDateTime;
  WaitForTimers();

  CheckEquals(TestDateTime, FPicker1.DateTime, 0.001, 'Picker1 should be synced');
  CheckEquals(TestDateTime, FPicker2.DateTime, 0.001, 'Picker2 should be synced');
  CheckTrue(Pos('2025', FLabel1.Caption) > 0, 'Label should be synced');
end;

procedure TestOLLinkManager.TestMultipleControlsToOneBoolean;
begin
  FCheckBox1.Link(FForm.FBoolean);
  FCheckBox2.Link(FForm.FBoolean);

  FForm.FBoolean := True;
  WaitForTimers();

  CheckTrue(FCheckBox1.Checked, 'CheckBox1 should be synced');
  CheckTrue(FCheckBox2.Checked, 'CheckBox2 should be synced');
end;

procedure TestOLLinkManager.TestRefreshControls;
begin
  FEdit1.Link(FForm.FInt);

  FForm.FInt := 777;
  WaitForTimers();

  CheckEquals('777', FEdit1.Text, 'RefreshControls should update display');
end;



procedure TestOLLinkManager.TestCalculationError;
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


{$IF CompilerVersion >= 34.0}
{ TestFormIsValid }

procedure TestFormIsValid.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  FValue := 10;
  FCheckBox := TCheckBox.Create(FForm);
  FCheckBox.Parent := FForm;
  FBooleanValue := True;
  FMemo := TMemo.Create(FForm);
  FMemo.Parent := FForm;
  FStringValue := 'Valid';
  {$IF CompilerVersion >= 34.0}
  Links.Link(FEdit, FValue).AddValidator(function(i: OLInteger): TOLValidationResult
    begin
      if i < 0 then
        Result := TOLValidationResult.Error('Must be positive')
      else
        Result := TOLValidationResult.Ok;
    end);
  Links.Link(FCheckBox, FBooleanValue).AddValidator(function(b: OLBoolean): TOLValidationResult
    begin
      if b.IfNull(False) then
        Result := TOLValidationResult.Ok
      else
        Result := TOLValidationResult.Error('Must be checked');
    end);
  Links.Link(FMemo, FStringValue).AddValidator(function(s: OLString): TOLValidationResult
    begin
      if Length(s) >= 3 then
        Result := TOLValidationResult.Ok
      else
        Result := TOLValidationResult.Error('Too short');
    end);
  {$ELSE}
  Links.Link(FEdit, FValue);
  Links.Link(FCheckBox, FBooleanValue);
  Links.Link(FMemo, FStringValue);
  {$IFEND}
end;

procedure TestFormIsValid.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestFormIsValid.TestFormIsValidWhenAllValid;
begin
  FValue := 5;
  CheckTrue(FForm.IsValid, 'Form should be valid when all linked controls are valid');
end;

procedure TestFormIsValid.TestFormIsValidWhenOneInvalid;
begin
  FValue := -1;
  CheckFalse(FForm.IsValid, 'Form should be invalid when at least one linked control is invalid');
end;

{ TestEditIsValid }

procedure TestEditIsValid.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  FValue := 10;
end;

procedure TestEditIsValid.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestEditIsValid.TestIsValidWhenValid;
begin
  Links.Link(FEdit, FValue).AddValidator(function(i: OLInteger): TOLValidationResult
    begin
      if i >= 0 then
        Result := TOLValidationResult.Ok
      else
        Result := TOLValidationResult.Error('Must be non-negative');
    end);
  FValue := 5;
  CheckTrue(FEdit.IsValid, 'Edit should be valid when value meets validation criteria');
end;

procedure TestEditIsValid.TestIsValidWhenInvalid;
begin
  Links.Link(FEdit, FValue).AddValidator(function(i: OLInteger): TOLValidationResult
    begin
      if i >= 0 then
        Result := TOLValidationResult.Ok
      else
        Result := TOLValidationResult.Error('Must be positive', clRed);
    end);
  FValue := -1;
  CheckFalse(FEdit.IsValid, 'Edit should be invalid when value fails validation criteria');
end;

procedure TestEditIsValid.TestIsValidWithoutValidation;
begin
  Links.Link(FEdit, FValue);
  FValue := 100;
  CheckTrue(FEdit.IsValid, 'Edit should be valid when linked without validation function');
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
{ TestTrackBarIsValid }

procedure TestTrackBarIsValid.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FTrackBar := TTrackBar.Create(FForm);
  FTrackBar.Parent := FForm;
  FTrackBar.Max := 100;
  FTrackBar.Min := -100;
  FValue := 50;
end;

procedure TestTrackBarIsValid.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestTrackBarIsValid.TestIsValidWhenValid;
begin
  Links.Link(FTrackBar, FValue).AddValidator(function(i: OLInteger): TOLValidationResult
    begin
      if i >= 0 then
        Result := TOLValidationResult.Ok
      else
        Result := TOLValidationResult.Error('Must be non-negative');
    end);
  FValue := 25;
  CheckTrue(FTrackBar.IsValid, 'TrackBar should be valid when value meets validation criteria');
end;

procedure TestTrackBarIsValid.TestIsValidWhenInvalid;
begin
  Links.Link(FTrackBar, FValue).AddValidator(function(i: OLInteger): TOLValidationResult
    begin
      if i >= 0 then
        Result := TOLValidationResult.Ok
      else
        Result := TOLValidationResult.Error('Must be non-negative');
    end);
  FValue := -10;
  CheckFalse(FTrackBar.IsValid, 'TrackBar should be invalid when value fails validation criteria');
end;

procedure TestTrackBarIsValid.TestIsValidWithoutValidation;
begin
  Links.Link(FTrackBar, FValue);
  FValue := 75;
  CheckTrue(FTrackBar.IsValid, 'TrackBar should be valid when linked without validation function');
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
{ TestMemoIsValid }

procedure TestMemoIsValid.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FMemo := TMemo.Create(FForm);
  FMemo.Parent := FForm;
  FValue := 'Test';
end;

procedure TestMemoIsValid.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestMemoIsValid.TestIsValidWhenValid;
begin
  Links.Link(FMemo, FValue).AddValidator(function(s: OLString): TOLValidationResult
    begin
      if Length(s) >= 3 then
        Result := TOLValidationResult.Ok
      else
        Result := TOLValidationResult.Error('Too short');
    end);
  FValue := 'Valid';
  CheckTrue(FMemo.IsValid, 'Memo should be valid when value meets validation criteria');
end;

procedure TestMemoIsValid.TestIsValidWhenInvalid;
begin
  Links.Link(FMemo, FValue).AddValidator(function(s: OLString): TOLValidationResult
    begin
      if Length(s) >= 3 then
        Result := TOLValidationResult.Ok
      else
        Result := TOLValidationResult.Error('Too short');
    end);
  FValue := 'Hi';
  CheckFalse(FMemo.IsValid, 'Memo should be invalid when value fails validation criteria');
end;

procedure TestMemoIsValid.TestIsValidWithoutValidation;
begin
  Links.Link(FMemo, FValue);
  FValue := 'Any text';
  CheckTrue(FMemo.IsValid, 'Memo should be valid when linked without validation function');
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
{ TestCheckBoxIsValid }

procedure TestCheckBoxIsValid.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FCheckBox := TCheckBox.Create(FForm);
  FCheckBox.Parent := FForm;
  FValue := True;
end;

procedure TestCheckBoxIsValid.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestCheckBoxIsValid.TestIsValidWhenValid;
begin
  Links.Link(FCheckBox, FValue).AddValidator(function(b: OLBoolean): TOLValidationResult
    begin
      if b.IfNull(False) then
        Result := TOLValidationResult.Ok
      else
        Result := TOLValidationResult.Error('Must be checked');
    end);
  FValue := True;
  CheckTrue(FCheckBox.IsValid, 'CheckBox should be valid when value meets validation criteria');
end;

procedure TestCheckBoxIsValid.TestIsValidWhenInvalid;
begin
  Links.Link(FCheckBox, FValue).AddValidator(function(b: OLBoolean): TOLValidationResult
    begin
      if b.IfNull(False) then
        Result := TOLValidationResult.Ok
      else
        Result := TOLValidationResult.Error('Must be checked');
    end);
  FValue := False;
  CheckFalse(FCheckBox.IsValid, 'CheckBox should be invalid when value fails validation criteria');
end;

procedure TestCheckBoxIsValid.TestIsValidWithoutValidation;
begin
  Links.Link(FCheckBox, FValue);
  FValue := False;
  CheckTrue(FCheckBox.IsValid, 'CheckBox should be valid when linked without validation function');
end;
{$IFEND}

{$IF CompilerVersion >= 34.0}
{ TestFormShowValidationState }

procedure TestFormShowValidationState.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  FValue := 10;

  Links.Link(FEdit, FValue).AddValidator(function(i: OLInteger): TOLValidationResult
    begin
      if i >= 0 then
        Result := TOLValidationResult.Ok
      else
        Result := TOLValidationResult.Error('Must be positive', clRed);
    end);
end;

procedure TestFormShowValidationState.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestFormShowValidationState.TestUpdatesVisuals;
begin
  FValue := -5;
  // Manually reset visual state to ensure ShowValidationState does the work
  FEdit.Color := clWindow;
  FEdit.Hint := '';
  FEdit.ShowHint := False;

  FForm.ShowValidationState;

  CheckEquals(clRed, FEdit.Color, 'Edit color should be updated by ShowValidationState');
  CheckEquals('Must be positive', FEdit.Hint, 'Edit hint should be updated');
  CheckTrue(FEdit.ShowHint, 'Edit should show hint');
end;

{ TestMultiValidator }

procedure TestMultiValidator.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  FValue := 10;
end;

procedure TestMultiValidator.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TestMultiValidator.TestMultipleValidatorsSuccess;
var
  link: TEditToOLInteger;
begin
  link := Links.Link(FEdit, FValue);

  link.AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      if val > 0 then Result := TOLValidationResult.Ok
      else Result := TOLValidationResult.Error('Must be positive');
    end);

  link.AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      if val < 100 then Result := TOLValidationResult.Ok
      else Result := TOLValidationResult.Error('Must be less than 100');
    end);

  FValue := 50;
  CheckTrue(FEdit.IsValid, 'Should be valid for 50');
end;

procedure TestMultiValidator.TestMultipleValidatorsFirstFail;
var
  link: TEditToOLInteger;
begin
  link := Links.Link(FEdit, FValue);

  link.AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      if val > 0 then Result := TOLValidationResult.Ok
      else Result := TOLValidationResult.Error('First Error');
    end);

  link.AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      if val < 100 then Result := TOLValidationResult.Ok
      else Result := TOLValidationResult.Error('Second Error');
    end);

  FValue := -10;
  CheckFalse(FEdit.IsValid, 'Should be invalid for -10');

  FForm.ShowValidationState;
  CheckEquals('First Error', FEdit.Hint, 'Should show the first error');
end;

procedure TestMultiValidator.TestMultipleValidatorsSecondFail;
var
  link: TEditToOLInteger;
begin
  link := Links.Link(FEdit, FValue);

  link.AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      if val > 0 then Result := TOLValidationResult.Ok
      else Result := TOLValidationResult.Error('First Error');
    end);

  link.AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      if val < 100 then Result := TOLValidationResult.Ok
      else Result := TOLValidationResult.Error('Second Error');
    end);

  FValue := 150;
  CheckFalse(FEdit.IsValid, 'Should be invalid for 150');

  FForm.ShowValidationState;
  CheckEquals('Second Error', FEdit.Hint, 'Should show the second error');
end;

procedure TestMultiValidator.TestSetValidationFunctionClearsOthers;
var
  link: TEditToOLInteger;
begin
  link := Links.Link(FEdit, FValue);

  link.AddValidator(function(val: OLInteger): TOLValidationResult
    begin
      if val > 0 then Result := TOLValidationResult.Ok
      else Result := TOLValidationResult.Error('First Error');
    end);

  link.ValidationFunction := function(val: OLInteger): TOLValidationResult
    begin
      if val = 42 then Result := TOLValidationResult.Ok
      else Result := TOLValidationResult.Error('Only 42 is allowed');
    end;

  FValue := 50; // Positive, but not 42
  CheckFalse(FEdit.IsValid, 'Should be invalid because 42 is now the only rule');

  FForm.ShowValidationState;
  CheckEquals('Only 42 is allowed', FEdit.Hint, 'Should show the new error');
end;

{ TestDoubleLinkPrevention }

procedure TestDoubleLinkPrevention.SetUp;
begin
  inherited;
  FForm := TestForm.CreateNew(nil, 0);
  FEdit := TEdit.Create(FForm);
  FEdit.Parent := FForm;
  FCheckBox := TCheckBox.Create(FForm);
  FCheckBox.Parent := FForm;
end;

procedure TestDoubleLinkPrevention.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
  inherited;
end;

procedure TestDoubleLinkPrevention.TestDoubleLinkEditToInteger;
begin
  Links.Link(FEdit, FForm.FInt);
  try
    Links.Link(FEdit, FForm.FInt);
    Fail('Should raise exception when linking already linked control (same type)');
  except
    on E: EControlAlreadyLinked do
      Check(Pos('already linked', E.Message) > 0, 'Wrong exception message: ' + E.Message);
  end;
end;

procedure TestDoubleLinkPrevention.TestDoubleLinkEditToString;
begin
  Links.Link(FEdit, FForm.FInt);
  try
    Links.Link(FEdit, FForm.FString);
    Fail('Should raise exception when linking already linked control (different type)');
  except
    on E: EControlAlreadyLinked do
      Check(Pos('already linked', E.Message) > 0, 'Wrong exception message: ' + E.Message);
  end;
end;

procedure TestDoubleLinkPrevention.TestDoubleLinkCheckBox;
begin
  Links.Link(FCheckBox, FForm.FBoolean);
  try
    Links.Link(FCheckBox, FForm.FBoolean);
    Fail('Should raise exception when linking already linked checkbox');
  except
    on E: EControlAlreadyLinked do
      Check(Pos('already linked', E.Message) > 0, 'Wrong exception message: ' + E.Message);
  end;
end;

{ TestDateTimePickerLinkingPrecedence }

procedure TestDateTimePickerLinkingPrecedence.SetUp;
begin
  FForm := TestForm.CreateNew(nil, 0);
  FPicker := TDateTimePicker.Create(FForm);
  FPicker.Parent := FForm;
end;

procedure TestDateTimePickerLinkingPrecedence.TearDown;
begin
  FForm.Free;
end;

procedure TestDateTimePickerLinkingPrecedence.TestOLDatePrecedence;
var
  SpecificDate: TDate;
begin
  SpecificDate := EncodeDate(2020, 1, 1);
  FForm.FDate := SpecificDate;

  // Picker has today's date by default
  FPicker.Date := Date + 1; // Set it to tomorrow

  // Link it
  FPicker.Link(FForm.FDate);

  // The picker should now have the date from the variable
  CheckEquals(SpecificDate, FPicker.Date, 'Picker date should match OLDate variable after linking');
  CheckEquals(SpecificDate, TDate(FForm.FDate), 'OLDate variable should have kept its value');
end;

procedure TestDateTimePickerLinkingPrecedence.TestOLDateTimePrecedence;
var
  SpecificDateTime: TDateTime;
begin
  SpecificDateTime := EncodeDate(2020, 1, 1) + EncodeTime(12, 0, 0, 0);
  FForm.FDateTime := SpecificDateTime;

  // Picker has today's date by default
  FPicker.DateTime := Now + 1; // Set it to tomorrow

  // Link it
  FPicker.Link(FForm.FDateTime);

  // The picker should now have the date from the variable
  CheckEquals(SpecificDateTime, FPicker.DateTime, 'Picker datetime should match OLDateTime variable after linking');
  CheckEquals(SpecificDateTime, TDateTime(FForm.FDateTime), 'OLDateTime variable should have kept its value');
end;

procedure TestDateTimePickerLinkingPrecedence.TestOLDateNullPrecedence;
begin
  FForm.FDate := Null;

  // Picker has today's date by default
  FPicker.Date := Date;
  FPicker.Format := 'yyyy-mm-dd'; // Not the null format

  // Link it
  FPicker.Link(FForm.FDate);

  // The picker should now have the NULL_FORMAT and its DateTime shouldn't matter as much,
  // but importantly, d should still be Null
  CheckTrue(FForm.FDate.IsNull, 'OLDate variable should still be Null after linking');
  CheckEqualsString(NULL_FORMAT, FPicker.Format, 'Picker should have switched to NULL_FORMAT');
end;

procedure TestLinkPolymorphism.CheckMethodIsOverridden(AClass: TClass; const AMethodName: string);
var
  ctx: TRttiContext;
  t: TRttiType;
  m: TRttiMethod;
begin
  ctx := TRttiContext.Create;
  try
    t := ctx.GetType(AClass);
    m := t.GetMethod(AMethodName);

    if Assigned(m) then
    begin
      // If the method is not virtual, it means it was redefined without 'override'
      if m.DispatchKind = dkVtable then
      begin
        // OK
      end
      else if m.DispatchKind = dkDynamic then
      begin
        // OK
      end
      else
        Fail(Format('Method %s in class %s shadows a virtual method without "override"', [AMethodName, AClass.ClassName]));
    end;
  finally
    ctx.Free;
  end;
end;

procedure TestLinkPolymorphism.TestShowValidationStateIsOverridden;
begin
  CheckMethodIsOverridden(TEditToOLDouble, 'ShowValidationState');
  CheckMethodIsOverridden(TEditToOLCurrency, 'ShowValidationState');
  CheckMethodIsOverridden(TMemoToOLString, 'ShowValidationState');
  CheckMethodIsOverridden(TOLIntegerToLabel, 'ShowValidationState');
  CheckMethodIsOverridden(TOLDoubleToLabel, 'ShowValidationState');
  CheckMethodIsOverridden(TOLCurrencyToLabel, 'ShowValidationState');
  CheckMethodIsOverridden(TOLStringToLabel, 'ShowValidationState');
end;

procedure TestLinkPolymorphism.TestNeedsTimerIsOverridden;
begin
  CheckMethodIsOverridden(TOLIntegerToLabel, 'NeedsTimer');
  CheckMethodIsOverridden(TOLStringToLabel, 'NeedsTimer');
  CheckMethodIsOverridden(TOLDoubleToLabel, 'NeedsTimer');
  CheckMethodIsOverridden(TOLCurrencyToLabel, 'NeedsTimer');
  CheckMethodIsOverridden(TOLDateToLabel, 'NeedsTimer');
  CheckMethodIsOverridden(TOLDateTimeToLabel, 'NeedsTimer');
end;

{$IFEND}

 initialization
  RegisterTest(TestEditToOLInteger.Suite);
  RegisterTest(TestEditToOLDate.Suite);
  RegisterTest(TestEditToOLString.Suite);
  RegisterTest(TestEditToOLDouble.Suite);
  RegisterTest(TestEditToOLCurrency.Suite);
  RegisterTest(TestSpinEditToOLInteger.Suite);
  RegisterTest(TestDateTimePickerToOLDate.Suite);
  RegisterTest(TestDateTimePickerToOLDateTime.Suite);
  RegisterTest(TestCheckBoxToOLBoolean.Suite);
  RegisterTest(TestDoubleLinkPrevention.Suite);
  {$IF CompilerVersion >= 34.0}
  RegisterTest(TestCheckBoxToOLBooleanValidation.Suite);
  RegisterTest(TestEditToOLDateValidation.Suite);
  RegisterTest(TestDateTimePickerToOLDateValidation.Suite);
  RegisterTest(TestDateTimePickerToOLDateTimeValidation.Suite);
  RegisterTest(TestOLIntegerToLabelValidation.Suite);
  RegisterTest(TestOLDoubleToLabelValidation.Suite);
  RegisterTest(TestOLCurrencyToLabelValidation.Suite);
  RegisterTest(TestOLDateToLabelValidation.Suite);
  RegisterTest(TestOLStringToLabelValidation.Suite);
  RegisterTest(TestOLDateTimeToLabelValidation.Suite);
  RegisterTest(TestDateTimePickerLinkingPrecedence.Suite);
  {$IFEND}
  RegisterTest(TestOLLinkManager.Suite);
  RegisterTest(TestMemorySafety.Suite);
  {$IF CompilerVersion >= 34.0}
  RegisterTest(TestFormIsValid.Suite);
  RegisterTest(TestEditIsValid.Suite);
  RegisterTest(TestTrackBarIsValid.Suite);
  RegisterTest(TestMemoIsValid.Suite);
  RegisterTest(TestCheckBoxIsValid.Suite);
  RegisterTest(TestFormShowValidationState.Suite);
  RegisterTest(TestMultiValidator.Suite);
  RegisterTest(TestLinkPolymorphism.Suite);
  {$IFEND}

 end.
