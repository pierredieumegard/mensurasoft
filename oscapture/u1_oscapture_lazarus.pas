unit u1_oscapture_lazarus;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, Spin, TAGraph, TASeries
   ,ucommun
   ,clipbrd, Buttons
   ;

type

  { TForm1 }

  TForm1 = class(TForm)
    Bchargepilote: TButton;
    bcapture: TButton;
    BBaide: TBitBtn;
    bsauve: TButton;
    bcopie: TButton;
    CBcapturecontinue: TCheckBox;
    Chart1: TChart;
    Chart1LineSeries1: TLineSeries;
    IdleTimer1: TIdleTimer;
    Labelintervalle: TLabel;
    labelnbmesures: TLabel;
    ListBox1: TListBox;
    ODchargebibdyn: TOpenDialog;
    SDsauvefichier: TSaveDialog;
    SEnbmesures: TSpinEdit;
    SEintervalle: TSpinEdit;
    procedure BBaideClick(Sender: TObject);
    procedure bcaptureClick(Sender: TObject);
    procedure BchargepiloteClick(Sender: TObject);
    procedure bcopieClick(Sender: TObject);
    procedure bsauveClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure IdleTimer1Timer(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure ODchargebibdynShow(Sender: TObject);
    procedure SEnbmesuresChange(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1;

const mesurescontinues:boolean=false;


implementation

{ TForm1 }

procedure TForm1.BchargepiloteClick(Sender: TObject);
var nomfichier,chloc : string;   iloc:integer;
begin
 {$ifdef window}
ODchargebibdyn.Filter := 'Bibliothèque dynamique(*.dll)|*.dll';
{$endif}
{$ifdef unix}
ODchargebibdyn.Filter := 'Bibliothèque dynamique(*.so)|*.so';
{$endif}
  if ODchargebibdyn.execute
       then nomfichier:=odchargebibdyn.FileName
       else nomfichier:='';
   if bavard then showmessage(nomfichier);
   ouipilote:=false;
   if nomfichier<>'' then ouipilote:=chargebibdyn(nomfichier);

   if ouipilote then    begin
                   chloc:=string(cdetail())  ;
                    showmessage('pilote chargé, detail='+chloc)
                    end
                else showmessage ('pilote non chargé');
   //   Chart1S1.AddXY(0,0);
//Chart1S1.addXY(3,3);
  listbox1.clear;
  iloc:=0;
 if ouipilote then
     while length(cncapture1t(iloc))>2 do
      begin listbox1.items.add(cncapture1t(iloc)) ;
            iloc:=iloc+1;
      end;
      if ouipilote then begin form1.caption:='Oscapture-Mensurasoft';end
             else form1.caption:='(bibdyn non chargée)';

end;

procedure TForm1.bcopieClick(Sender: TObject);
var chloc:string;  var iloc:integer;
begin
   chloc:='';
    //clipboard.astext:=pchar('blabla'+inttostr(Chart1S1.count));
   for iloc:=0 to Chart1lineseries1.source.count-1 do
      begin
      chloc:=chloc+floattostr(Chart1lineseries1.source.item[iloc]^.x)+chr(9);
      chloc:=chloc+floattostr(Chart1lineseries1.source.item[iloc]^.y);
     if iloc<Chart1lineseries1.source.count-1 then chloc:=chloc+chr(13)+chr(10);
      end;
      clipboard.astext:=pchar(chloc);

  //showmessage('dans copieclick');
end;

procedure TForm1.bsauveClick(Sender: TObject);
var nomfichier : string;   iloc:integer;    chloc:string;  f:textfile;
begin
  if SDsauvefichier.execute
       then nomfichier:=SDsauvefichier.FileName
       else nomfichier:='';
  if bavard then showmessage(nomfichier);
   chloc:='';
   if length(nomfichier)>1 then
    begin
   assignfile(f,nomfichier);rewrite(f);
   for iloc:=0 to Chart1lineseries1.source.count-1 do
      begin
      chloc:=chloc+floattostr(Chart1lineseries1.source.item[iloc]^.x)+',';
      chloc:=chloc+floattostr(Chart1lineseries1.source.item[iloc]^.y);
     if iloc<Chart1lineseries1.source.count-1 then chloc:=chloc+chr(13)+chr(10);
      end;
      write(f,chloc);closefile(f);
      end
end;

function debutdechaine(ch:string ;sep:string):string;
var iloc:integer;
begin
  iloc:=pos(sep,ch);
  debutdechaine:=copy(ch,1,iloc-1);
end;
function findechaine(ch:string ;sep:string):string;
var iloc:integer;
begin
  iloc:=pos(sep,ch);
  if iloc=0 then findechaine:=''
             else findechaine:=copy(ch,iloc+length(sep),length(ch));
end;

procedure TForm1.bcaptureClick(Sender: TObject);
var chloc,ch1,ch2:string;
    xloc,yloc:double;
begin
  if ouipilote then
    begin

      chloc:=ccapture1t(numvoiep,SEnbmesures.value,SEintervalle.value);
     if bavard then  showmessage('numvoiep:'+inttostr(numvoiep)+'/nb:'+inttostr(SEnbmesures.value)+'/intervalle:'+inttostr(SEintervalle.value)+chr(13)+chr(10)+chloc);
     Chart1lineseries1.clear;
      ch1:='';ch2:='';
      while length(chloc)>1 do
          begin
            // showmessage(debutdechaine(chloc,chr(13)+chr(10)));
             ch1:=debutdechaine(chloc,chr(13)+chr(10));
             if length(ch1)>1
               then begin
               xloc:=strtofloat(debutdechaine(ch1,','));
               yloc:=strtofloat(findechaine(ch1,','));
             Chart1lineseries1.addxy(xloc,yloc);
             chloc:=findechaine(chloc,chr(13)+chr(10));
             end
             else chloc:='';
         end
    end;
end;

procedure TForm1.BBaideClick(Sender: TObject);
begin
  showmessage('Oscapture-Mensurasoft'
      +chr(13)+chr(13)+'Oscilloscope utilisant les fonctions "Capture1" '
      +chr(13)+'(il FAUT les fonctions cdetail,ccapture1t,cncapture1t)'
      +chr(13)+chr(13)+'Logiciel libre GPL'
      +chr(13)+chr(13)+'Pierre DIEUMEGARD (pierre.dieumegard@free.fr)'
      );

end;

procedure TForm1.FormResize(Sender: TObject);
begin
  chart1.width:= width -200;
  chart1.height:=height-15;
  bchargepilote.Left:=width-180;
   BBaide.left:=width-80;
  listbox1.left:=width-182;
   SEnbmesures.left:=width-180;
   labelnbmesures.left:=width-180;
   SEintervalle.left:=width-180;
   labelintervalle.left:=width-180;
   bsauve.left:=width-180;
   bcopie.left:=width-180;
      bcapture.left:=width-160;
      CBcapturecontinue.left:=width-160;
end;

procedure TForm1.IdleTimer1Timer(Sender: TObject);
var chloc,ch1,ch2:string;
    xloc,yloc:double;

begin
 if ouipilote then form1.caption:=cdetail();//+'/'+cneadp(numvoiep)+floattostr(ceadp(numvoiep));
 idletimer1.enabled:=false;
if ouipilote and cbcapturecontinue.checked then
    begin

      chloc:=ccapture1t(numvoiep,SEnbmesures.value,SEintervalle.value);
     if bavard then  showmessage('numvoiep:'+inttostr(numvoiep)+'/nb:'+inttostr(SEnbmesures.value)+'/intervalle:'+inttostr(SEintervalle.value)+chr(13)+chr(10)+chloc);
    Chart1lineseries1.clear;
      ch1:='';ch2:='';
      while length(chloc)>1 do
          begin
            // showmessage(debutdechaine(chloc,chr(13)+chr(10)));
             ch1:=debutdechaine(chloc,chr(13)+chr(10));
             if length(ch1)>1
               then begin
               xloc:=strtofloat(debutdechaine(ch1,','));
               yloc:=strtofloat(findechaine(ch1,','));
             Chart1lineseries1.addxy(xloc,yloc);
             chloc:=findechaine(chloc,chr(13)+chr(10));
             end
             else chloc:='';
         end
    end;
    idletimer1.enabled:=true;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
   //showmessage(inttostr(listbox1.ItemIndex));
  numvoiep:=listbox1.itemindex;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin

end;

procedure TForm1.ODchargebibdynShow(Sender: TObject);
begin

end;


procedure TForm1.SEnbmesuresChange(Sender: TObject);
begin

end;

initialization
  {$I u1_oscapture_lazarus.lrs}

begin

  //ODchargebibdyn.Filter := 'Bibliothèque dynamique(*.dll)|*.dll';
end;

i:=3;
end.

