unit fenetre_dialogue_bibcapt2_lazarus;

{$mode delphi}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls,
  Graphics, Dialogs;

type
  TForm1 = class(TForm)
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 

implementation

initialization
  {$I fenetre_dialogue_bibcapt2_lazarus.lrs}
  Application.initialize;
  Application.Createform(Tform1,Form1);
  //Application.run;
end.

