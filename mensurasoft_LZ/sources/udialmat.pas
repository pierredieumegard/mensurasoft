unit udialmat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons,
  {$IFDEF WINDOWS} Windows,     {$ENDIF}
{$IFDEF LINUX} Linux, {$ENDIF}

  //uentrees,
  ucommun;

type

  { Tf_dialmat }

  Tf_dialmat = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    dm_boutoncalibration: TButton;
    dm_boutonpilote: TButton;
    Editfonction: TEdit;
    dm_choixvoie: TLabel;
    dm_fonctransf: TLabel;
    lcm_detailpilote: TLabel;
    ListBox1: TListBox;
    od_choixpil: TOpenDialog;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure dm_boutoncalibrationClick(Sender: TObject);
    procedure dm_boutonpiloteClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  f_dialmat: Tf_dialmat;

implementation

{ Tf_dialmat }

procedure Tf_dialmat.dm_boutonpiloteClick(Sender: TObject);
var chloc:string;
ch1,ch2:pchar;
iloc:integer;
longintloc:longint;
begin
  listbox1.items.clear;
  od_choixpil.execute;
  if (od_choixpil.filename <>'') and (typedialmat=1)
  then begin
         longintloc:=ucommun.chargebibdynp(od_choixpil.filename);
         if @stddetailp<>nil then
          begin

          detailpilotep:=stddetailp();
          lcm_detailpilote.caption:=detailpilotep;
          iloc:=0;
          while length(stdneadp(iloc))>1 do
             begin
               listbox1.items.add(stdneadp(iloc));
               iloc:=iloc+1;
             end;
          end;
    end; //voie principale
     if (od_choixpil.filename <>'') and (typedialmat=2)
  then begin
         longintloc:=ucommun.chargebibdyna(od_choixpil.filename);
         if @stddetaila<>nil then
          begin
          //dm_choixvoie.caption:=stddetaila();

          detailpilotea:=stddetaila();
           lcm_detailpilote.caption:=detailpilotea;
          iloc:=0;
          while length(stdneada(iloc))>1 do
             begin
               listbox1.items.add(stdneada(iloc));
               iloc:=iloc+1;
             end;
          end;
    end;     // voie aux
     if (od_choixpil.filename <>'') and (typedialmat=3)
  then begin
         longintloc:=ucommun.chargebibdyns(od_choixpil.filename);
         if @stddetails<>nil then
          begin
          //dm_choixvoie.caption:=stddetails();
          detailpilotes:=stddetails();
           lcm_detailpilote.caption:=detailpilotes;
          iloc:=0;
          while length(stdneads(iloc))>1 do
             begin
               listbox1.items.add(stdneads(iloc));
               iloc:=iloc+1;
             end;
          end;
    end;     // voie sup
end;

procedure Tf_dialmat.BitBtn1Click(Sender: TObject);
begin

 //messagebox(0,pchar(inttostr(listbox1.itemindex)),'choisi',0);
 if typedialmat=1 then
    begin
    numvoiep:=listbox1.itemindex;
    if numvoiep>-1
       then ouipilotep:=true
       else ouipilotep:=false;
     chfonctionp:=f_dialmat.Editfonction.text;
     nompilotep:=od_choixpil.filename;

     //definis_fonction('PAST',chfonctionp,fonctionp);
    end;

 if typedialmat=2 then
    begin
    numvoiea:=listbox1.itemindex;
    if numvoiea>-1
       then ouipilotea:=true
       else ouipilotea:=false;
    chfonctiona:=f_dialmat.editfonction.text;
    nompilotea:=od_choixpil.filename;
    //definis_fonction('PAST',chfonctiona,fonctiona);
    end;
if typedialmat=3 then
    begin
    numvoies:=listbox1.itemindex;
    if numvoies>-1
       then ouipilotes:=true
       else ouipilotes:=false;
    chfonctions:=f_dialmat.editfonction.text;
    nompilotes:=od_choixpil.filename;
    //definis_fonction('PAST',chfonctions,fonctions);
    end;
 close;
end;

procedure Tf_dialmat.BitBtn2Click(Sender: TObject);
begin
  Aide('HTML','mensurasoft_lz_drivers_pas.html');
end;

procedure Tf_dialmat.BitBtn3Click(Sender: TObject);
begin
  if typedialmat=1 then begin ouipilotep:=false; numvoiep:=-1;nompilotep:='';
     detailpilotep:='';end;
  if typedialmat=2 then begin ouipilotea:=false;numvoiea:=-1;nompilotea:='';
     detailpilotea:='';end;
  if typedialmat=3 then begin ouipilotes:=false;numvoies:=-1;nompilotes:='';
     detailpilotes:='';end;
  close;
end;

procedure Tf_dialmat.dm_boutoncalibrationClick(Sender: TObject);
begin
   if (typedialmat=1)and(ouicalibrationp) then stdcalibrationp('qlsj');

end;

initialization
  {$I udialmat.lrs}

end.

