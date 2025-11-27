unit OLFormHelper;

interface

uses
   Vcl.Forms, OLTypes, System.Classes, System.Generics.Collections;

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
