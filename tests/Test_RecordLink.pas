unit Test_RecordLink;

interface

uses
  TestFramework, Forms, StdCtrls, Classes, OLTypes, OLTypesToEdits;

type
  TTestRecord = record
    FString: OLString;
    FInteger: OLInteger;
  end;

  TTestRecordForm = class(TForm)
  public
    FRec: TTestRecord;
    FLabelStr: TLabel;
    FLabelInt: TLabel;
    constructor CreateNew(AOwner: TComponent; Dummy: Integer); override;
  end;

  TTestRecordLink = class(TTestCase)
  private
    FForm: TTestRecordForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestRecordFieldLinking;
  end;

implementation

uses
  SysUtils;

{ TTestRecordForm }

constructor TTestRecordForm.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  inherited CreateNew(AOwner, Dummy);
  FLabelStr := TLabel.Create(Self);
  FLabelStr.Parent := Self;
  FLabelInt := TLabel.Create(Self);
  FLabelInt.Parent := Self;

  // Link components to record fields
  FLabelStr.Link(FRec.FString);
  FLabelInt.Link(FRec.FInteger);
end;

{ TTestRecordLink }

procedure TTestRecordLink.SetUp;
begin
  FForm := TTestRecordForm.CreateNew(nil, 0);
end;

procedure TTestRecordLink.TearDown;
begin
  Links.RemoveLinks(FForm);
  FForm.Free;
end;

procedure TTestRecordLink.TestRecordFieldLinking;
begin
  // 4. We set the fields' values
  FForm.FRec.FString := 'Test String';
  FForm.FRec.FInteger := 123;

  // Wait for synchronizers (Labels usually sync via timer or immediate if possible)
  // In OLTypes, labels often need a small delay if updated via TThread.Queue/Timer
  // Let's force a refresh or wait
  Application.ProcessMessages();
  Sleep(150); // Small delay for OLTypes internal timers
  Application.ProcessMessages();

  // 5. check if Labels' captions changed
  CheckEquals('Test String', FForm.FLabelStr.Caption, 'Label (String) should be updated from record field');
  CheckEquals('123', FForm.FLabelInt.Caption, 'Label (Integer) should be updated from record field');
end;

initialization
  RegisterTest(TTestRecordLink.Suite);

end.
