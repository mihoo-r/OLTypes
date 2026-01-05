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
    class procedure ClearSettings; static;
  end;

implementation

uses
   {$IF CompilerVersion >= 23.0} Vcl.Forms {$ELSE} Forms{$IFEND};

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

class procedure TOLRegistry.ClearSettings;
begin
  reg.CloseKey;
  reg.DeleteKey(TOLRegistry.KeyName());
  // Re-open key so subsequent saves work
  reg.OpenKey(TOLRegistry.KeyName(), True);
end;

initialization
  reg := TRegistry.Create();
  reg.OpenKey(TOLRegistry.KeyName(), true);

finalization
  reg.Free();

end.
