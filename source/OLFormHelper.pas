unit OLFormHelper;

interface

uses
   {$IF CompilerVersion >= 23.0}
   Vcl.Forms,
   System.Classes,
   System.Generics.Collections,
   {$ELSE}
   Forms,
   Classes,
   Generics.Collections,
   {$IFEND}
   OLTypes;

type

   TOLFormHelper = class helper for TForm
     procedure RefreshControls();
     procedure RemoveLinks();
   end;

implementation

uses OLTypesToEdits;

{ TOLFormHelper }

procedure TOLFormHelper.RefreshControls;
begin
   Links.RefreshControls(Self);
end;

procedure TOLFormHelper.RemoveLinks;
begin
   Links.RemoveLinks(Self);
end;

end.
