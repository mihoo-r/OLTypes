unit OLThreadRunner;

interface

uses
  Classes, SysUtils;

type
  TOLThreadRuner = class(TThread)
  private
    AsyncProcedure: TProc;
    OnFinnishProcedure: TProc;
    procedure SynchronizedFinnish();
  protected
    procedure Execute; override;
  public
    class procedure Run(AsyncProc: TProc; OnFinnishProc: TProc = nil);
  end;

implementation


procedure TOLThreadRuner.Execute;
begin
  AsyncProcedure();
  if Assigned(OnFinnishProcedure) then
    Synchronize(SynchronizedFinnish);
end;

class procedure TOLThreadRuner.Run(AsyncProc, OnFinnishProc: TProc);
begin
  with TOLThreadRuner.Create(true) do
  begin
    FreeOnTerminate := true;
    AsyncProcedure := AsyncProc;
    OnFinnishProcedure := OnFinnishProc;
    Start;
  end;
end;

procedure TOLThreadRuner.SynchronizedFinnish;
begin
  OnFinnishProcedure();
end;

end.
