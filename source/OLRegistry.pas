unit OLRegistry;

interface

uses Registry, OLTypes, OLStringType;

type
  TOLRegistry = class
  private
    class function KeyName(): OLString;
    class function GetSettingsName(const SettingsName: string): OLString; static;
    class procedure SetSettingsName(const SettingsName: string; const Value: OLString); static;
  public
    class property Settings[const SettingsName: string]: OLString read
        GetSettingsName write SetSettingsName;
  end;

implementation

uses
  Vcl.Forms;

var
  reg: TRegistry;


class function TOLRegistry.GetSettingsName(const SettingsName: string): OLString;
begin
  Result := reg.ReadString(SettingsName);
end;

class function TOLRegistry.KeyName: OLString;
begin
  Result := OLType(Application.ExeName).Replaced('/','_').Replaced('\','_').Replaced(':', '');
end;

class procedure TOLRegistry.SetSettingsName(const SettingsName: string; const Value: OLString);
begin
  reg.WriteString(SettingsName, Value.ToString());
end;

initialization
  reg := TRegistry.Create();
  reg.OpenKey(TOLRegistry.KeyName(), true);

finalization
  reg.Free();

end.
