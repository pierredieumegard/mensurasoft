//unité umglzrep.pas : partie du logiciel Mensurasoft_lz
// création des fenêtres graphiques
// Mensurasoft-LZ : logiciel polyvalent de mesure et d'expérimentation par ordinateur
// à compiler avec le langage de programmation Lazarus/FreePascal
//
// Système Mensurasoft : http://sciencexp.free.fr
// C'est un système de pilotes d'appareils de mesure et d'expérimentation par ordinateur
// (Linux et Windows), de façon à pouvoir faire des logiciels dans différents langages
// de programmation, indépendamment des langages de réalisation des pilotes.

// logiciel libre  // free software // libera programaro
// Copyright (C) 2012 Pierre Dieumegard (pierre.dieumegard@free.fr)

//Ce programme est libre, vous pouvez le redistribuer et/ou le modifier selon les termes de la Licence
//Publique Générale GNU publiée par la Free Software Foundation (version 2 ou bien toute autre
//version ultérieure choisie par vous).
//Ce programme est distribué car potentiellement utile, mais SANS AUCUNE GARANTIE, ni
//explicite ni implicite, y compris les garanties de commercialisation ou d'adaptation dans un but
//spécifique. Reportez-vous à la Licence Publique Générale GNU pour plus de détails.
//Vous devez avoir reçu une copie de la Licence Publique Générale GNU en même temps que ce
//programme ; sinon, consultez  http://www.gnu.org/licenses/
//==============================
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.

//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.

//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.


unit umglz_rep;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Menus, ucommun, TAGraph, TASeries,ueval_0130,
  clipbrd, Buttons,

   {$IFDEF WINDOWS} Windows,     {$ENDIF}
{$IFDEF LINUX} Linux, {$ENDIF}


  uchaines;

type

  { TFrepere }

  TFrepere = class(TForm)
     Chart1: TChart;
     CLSP: TLineSeries;
     CLSA: TLineSeries;
     CLSS: TLineSeries;
     MainMenu1: TMainMenu;
     mrep_aide: TMenuItem;
     mrep_titreaxea: TMenuItem;
     mrep_titreaxep: TMenuItem;
     mrep_titreaxex: TMenuItem;
     mrep_copiegraphique: TMenuItem;
     mrep__copievirgpointpv: TMenuItem;
     mrep_regcsvsanstitres: TMenuItem;
     mrep_titregen: TMenuItem;
     mrep_enjoliver: TMenuItem;
     mrep_copietitretabvirg: TMenuItem;
     mrep_copietitretabpoint: TMenuItem;
     mrep_stop: TMenuItem;
     mrep_mesures: TMenuItem;
     mrep_copietabvirg: TMenuItem;
     mrep_copietabpoint: TMenuItem;
     mrep_clipboard: TMenuItem;
     mrep_regpvv: TMenuItem;
     mrep_regtabvirg: TMenuItem;
     mrep_regtabpoint: TMenuItem;
     mrep_regcsv: TMenuItem;
     mrep_fichiers: TMenuItem;
     SDfichier: TSaveDialog;
    Timerrepere: TTimer;
    procedure CLSPDrawPointer(ASender: TChartSeries;
      ACanvas: TCanvas; AIndex: Integer; ACenter: TPoint);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure mrep_aideClick(Sender: TObject);
    procedure mrep_copiegraphiqueClick(Sender: TObject);
    procedure mrep_copietitretabpointClick(Sender: TObject);
    procedure mrep_copietitretabvirgClick(Sender: TObject);
    procedure mrep_copietabpointClick(Sender: TObject);
    procedure mrep_copietabvirgClick(Sender: TObject);
    procedure mrep_regcsvClick(Sender: TObject);
    procedure mrep_regcsvsanstitresClick(Sender: TObject);
    procedure mrep_regpvvClick(Sender: TObject);
    procedure mrep_regtabpointClick(Sender: TObject);
    procedure mrep_regtabvirgClick(Sender: TObject);
    procedure mrep_stopClick(Sender: TObject);
    procedure mrep_titreaxeaClick(Sender: TObject);
    procedure mrep_titreaxepClick(Sender: TObject);
    procedure mrep_titreaxexClick(Sender: TObject);
    procedure mrep_titregenClick(Sender: TObject);
    procedure mrep__copievirgpointpvClick(Sender: TObject);
    procedure TimerrepereTimer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
    localouifaitmesures:boolean;   localnbmaxmesures:word;
       localtitrep,localneadp,localneada,localneads :string;
  localeadp,localeada,localeads:function(n:longint):double;stdcall;
  localintervalle:double;   localnbmesures:word;
  ouicopiertitres:boolean; ouiversfichier:boolean;
    tabtemps,tabP,tabA,tabS:array of double;
    tdepart:double;
    sep,sepdec:char;

  end; 

var
  Frepere: TFrepere;

implementation

{ TFrepere }

procedure TFrepere.FormResize(Sender: TObject);
begin
   chart1.left:=3;
   chart1.width:=Frepere.width-6;
   chart1.height:=Frepere.height-24;
end;

procedure TFrepere.mrep_aideClick(Sender: TObject);
begin
  aide(ch_html,'mensurasoft_lz_repere.html');
end;

procedure TFrepere.mrep_copiegraphiqueClick(Sender: TObject);
begin
  Chart1.copyToClipboardBitmap   ;
end;


procedure envoie_presse_papier;
var grossechaine,petitechaine:widestring;
    i:longint;
    var seplignes:string=chr(13)+chr(10);
begin
grossechaine:='';
if Frepere.sep=',' then seplignes:=';';
if Frepere.ouicopiertitres then
   begin
        grossechaine:=Frepere.caption+chr(13)+chr(10);
        petitechaine:='t(s) '+Frepere.sep;
        petitechaine:=petitechaine+Frepere.localneadp;
        if ouipilotea then petitechaine:=petitechaine+Frepere.sep+Frepere.localneada;
        if ouipilotes then petitechaine:=petitechaine+Frepere.sep+Frepere.localneads;
        petitechaine:=petitechaine+chr(13)+chr(10);
        grossechaine:=grossechaine+petitechaine;
   end;
if Frepere.CLSP.count>0
  then begin
       for i:=0 to Frepere.CLSP.count-1 do
           begin
            petitechaine:=floattostr(Frepere.CLSP.getxvalue(i))+Frepere.sep+floattostr(Frepere.CLSP.getyvalue(i));
            if ouipilotea then petitechaine:=petitechaine+Frepere.sep+floattostr(Frepere.CLSA.getyvalue(i));
            if ouipilotes then petitechaine:=petitechaine+Frepere.sep+floattostr(Frepere.CLSS.getyvalue(i));
            petitechaine:=petitechaine+seplignes;
            if Frepere.sepdec=',' then petitechaine:=stringreplace(petitechaine,'.',',',[rfReplaceAll]);
            grossechaine:=grossechaine+petitechaine;
           end;
        clipboard.AsText:=grossechaine;
       end;
end;


procedure TFrepere.mrep_copietitretabpointClick(Sender: TObject);
begin
sep:=chr(9);sepdec:='.';ouicopiertitres:=true;
envoie_presse_papier;
end;

procedure TFrepere.mrep_copietitretabvirgClick(Sender: TObject);
begin
sep:=chr(9);sepdec:='.';ouicopiertitres:=true;
envoie_presse_papier;
end;

procedure TFrepere.mrep_copietabpointClick(Sender: TObject);
begin
sep:=chr(9);sepdec:='.';ouicopiertitres:=false;
envoie_presse_papier;
end;

procedure TFrepere.mrep_copietabvirgClick(Sender: TObject);
begin
 sep:=chr(9);sepdec:=',';ouicopiertitres:=false;
envoie_presse_papier;
end;


procedure TFrepere.mrep__copievirgpointpvClick(Sender: TObject);
begin
 sep:=',';sepdec:='.';ouicopiertitres:=false;
 envoie_presse_papier;
end;

procedure enregistrefichier;
var grossechaine,petitechaine:widestring;
    i:longint;
    f:textfile;
begin
//messagebox(0,'au début de enregistrefichier',pchar(Frepere.SDfichier.filename),0);
grossechaine:='';
if Frepere.ouicopiertitres then
   begin
      // grossechaine:=Frepere.caption+'||';
        petitechaine:=Frepere.localtitrep+'||t(s) '+Frepere.sep;
       // messagebox(0,'après stdtitrep',pchar(petitechaine),0);
        petitechaine:=petitechaine+Frepere.Chart1.LeftAxis.title.caption;
       // messagebox(0,'après ajout de localneadp',pchar(petitechaine),0);
        //if ouipilotea then petitechaine:=petitechaine+Frepere.sep+Frepere.localneada+'||'+chfonctiona;
       if ouipilotea then petitechaine:=petitechaine+Frepere.sep+Frepere.Chart1.AxisList[2].title.caption;

        if ouipilotes then petitechaine:=petitechaine+Frepere.sep+Frepere.localneads+'||'+chfonctions;
        petitechaine:=petitechaine+Frepere.sep+Frepere.caption+chr(13)+chr(10);
        grossechaine:=grossechaine+petitechaine;
   end;
//messagebox(0,'après écriture des titres','qlsdj',0);
if Frepere.CLSP.count>0
  then begin
       for i:=0 to Frepere.CLSP.count-1 do
           begin
            petitechaine:=floattostr(Frepere.CLSP.getxvalue(i))+Frepere.sep+floattostr(Frepere.CLSP.getyvalue(i));
            if ouipilotea then petitechaine:=petitechaine+Frepere.sep+floattostr(Frepere.CLSA.getyvalue(i));
            if ouipilotes then petitechaine:=petitechaine+Frepere.sep+floattostr(Frepere.CLSS.getyvalue(i));
            petitechaine:=petitechaine+chr(13)+chr(10);
            if Frepere.sepdec=',' then petitechaine:=stringreplace(petitechaine,'.',',',[rfReplaceAll]);
            grossechaine:=grossechaine+petitechaine;
           end;
     //   clipboard.AsText:=grossechaine;
  //   messagebox(0,'juste avant d''ouvrir le fichier de sauvegarde','Frepere.SDfichier.filename',0);
     assignfile(f,Frepere.SDfichier.filename);
     rewrite(f);
     writeln(f,grossechaine);
     closefile(f);
       end;
end;


procedure TFrepere.mrep_regcsvClick(Sender: TObject);
begin
sep:=',';sepdec:='.';
ouicopiertitres:=not(mrep_regcsvsanstitres.checked);
SDfichier.DefaultExt:='csv';
SDfichier.Filter := 'Fichier CSV|*.csv';
SDfichier.execute;
if SDfichier.filename <>''
then enregistrefichier;

end;

procedure TFrepere.mrep_regcsvsanstitresClick(Sender: TObject);
begin
  mrep_regcsvsanstitres.checked:=not(mrep_regcsvsanstitres.checked);
end;

procedure TFrepere.mrep_regpvvClick(Sender: TObject);
begin
 sep:=';';sepdec:=',';
 ouicopiertitres:=not(mrep_regcsvsanstitres.checked);
SDfichier.DefaultExt:='csv';
SDfichier.Filter := 'Fichier texte ;,|*.csv';
SDfichier.execute;
if SDfichier.filename <>''
then enregistrefichier;
end;

procedure TFrepere.mrep_regtabpointClick(Sender: TObject);
begin
  sep:=chr(9);sepdec:='.';
  ouicopiertitres:=not(mrep_regcsvsanstitres.checked);
SDfichier.DefaultExt:='tab';
SDfichier.Filter := 'Fichier TAB.|*.tab';
SDfichier.execute;
if SDfichier.filename <>''
then enregistrefichier;
end;

procedure TFrepere.mrep_regtabvirgClick(Sender: TObject);
begin
  sep:=chr(9);sepdec:=',';
  ouicopiertitres:=not(mrep_regcsvsanstitres.checked);
SDfichier.DefaultExt:='tab';
SDfichier.Filter := 'Fichier TAB,|*.tab';
SDfichier.execute;
if SDfichier.filename <>''
then enregistrefichier;
end;

procedure TFrepere.mrep_stopClick(Sender: TObject);
begin
    localouifaitmesures:=false;
end;

procedure TFrepere.mrep_titreaxeaClick(Sender: TObject);
var chloc:string;
begin
  chloc:=chart1.axislist[2].title.caption;
  chloc:=inputbox(ch_mrep_titreaxea,chloc,chloc);
  chart1.axislist[2].title.caption:=chloc;
end;

procedure TFrepere.mrep_titreaxepClick(Sender: TObject);
var chloc:string;
begin
   chloc:=chart1.leftaxis.title.caption;
   chloc:=inputbox(ch_mrep_titreaxep,chloc,chloc);
   Chart1.leftaxis.title.caption:=chloc;
end;

procedure TFrepere.mrep_titreaxexClick(Sender: TObject);
var chloc:string ;
begin
   chloc:=Chart1.Bottomaxis.title.Caption ;
   chloc:=inputbox(ch_mrep_titreaxex,chloc,chloc);
   Chart1.Bottomaxis.title.Caption:=chloc;
end;

procedure TFrepere.mrep_titregenClick(Sender: TObject);
var chloc:string;
begin
   chloc:=caption;
   chloc:= inputbox(ch_mrep_titregen,caption,caption);
   caption:=chloc;
end;


procedure TFrepere.TimerrepereTimer(Sender: TObject);
var tempsmesure:double;
var chloc,chlocp,chloca,chlocs,chlocsav:string;
var valeadp,valeada,valeads,valsav:double;
begin
  tempsmesure:=now-tdepart;
  if localouifaitmesures and (self.CLSP.count  <localnbmaxmesures)
    then begin    valeadp:=beadp;valeada:=beada;valeads:=beads;
          chlocp:= stringreplace(chfonctionp,'xp',floattostr(valeadp),[rfReplaceAll, rfIgnoreCase]);
    chlocp:= stringreplace(chlocp,'xa',floattostr(valeada),[rfReplaceAll, rfIgnoreCase]);
    chlocp:= stringreplace(chlocp,'xs',floattostr(valeads),[rfReplaceAll, rfIgnoreCase]);
    chloca:= stringreplace(chfonctiona,'xp',floattostr(valeadp),[rfReplaceAll, rfIgnoreCase]);
    chloca:= stringreplace(chloca,'xa',floattostr(valeada),[rfReplaceAll, rfIgnoreCase]);
    chloca:= stringreplace(chloca,'xs',floattostr(valeads),[rfReplaceAll, rfIgnoreCase]);
    chlocs:= stringreplace(chfonctions,'xp',floattostr(valeadp),[rfReplaceAll, rfIgnoreCase]);
    chlocs:= stringreplace(chlocs,'xa',floattostr(valeada),[rfReplaceAll, rfIgnoreCase]);
    chlocs:= stringreplace(chlocs,'xs',floattostr(valeads),[rfReplaceAll, rfIgnoreCase]);

         if ouipilotep then self.CLSP.AddXY(tempsmesure*86400,evaluechaine(chlocp),'',clred);
         if ouipilotea then self.CLSA.AddXY(tempsmesure*86400,evaluechaine(chloca),'',clgreen);
         if ouipilotes then self.CLSS.AddXY(tempsmesure*86400,evaluechaine(chlocs),'',clblue);

    if ouipilotesav and ouipecsav and (numvoiesav>-1)
      then begin
           chlocsav:=stringreplace(chfonctionsav,'xp',floattostr(valeadp),[rfReplaceAll, rfIgnoreCase]);
           chlocsav:=stringreplace(chlocsav,'xa',floattostr(valeada),[rfReplaceAll, rfIgnoreCase]);
           chlocsav:=stringreplace(chlocsav,'xs',floattostr(valeads),[rfReplaceAll, rfIgnoreCase]);
           chlocsav:=stringreplace(chlocsav,'xt',floattostr(tempsmesure*86400),[rfReplaceAll, rfIgnoreCase]);
           stdsav(numvoiesav,evaluechaine(chlocsav));
           end;
    end;
end;

procedure TFrepere.CLSPDrawPointer(ASender: TChartSeries;
  ACanvas: TCanvas; AIndex: Integer; ACenter: TPoint);
begin

end;

procedure TFrepere.FormCreate(Sender: TObject);
begin
   mrep_fichiers.caption:=ch_mrep_fichiers;
   mrep_regcsv.caption:=ch_mrep_regcsv;
   mrep_regpvv.caption:=ch_mrep_regpvv;
   mrep_regtabpoint.caption:=ch_mrep_regtabpoint;
   mrep_regtabvirg.caption:=ch_mrep_regtabvirg;
   mrep_regcsvsanstitres.caption:=ch_mrep_regcsvsanstitres;
   mrep_enjoliver.caption:=ch_mrep_enjoliver;
   mrep_titregen.caption:=ch_mrep_titregen;
   mrep_titreaxex.caption:=ch_mrep_titreaxex;
   mrep_titreaxep.caption:=ch_mrep_titreaxep;
   mrep_titreaxea.caption:=ch_mrep_titreaxea;
   mrep_clipboard.caption:=ch_mrep_clipboard;
   mrep_copietabpoint.caption:=ch_mrep_copietabpoint;
   mrep_copietabvirg.caption:=ch_mrep_copietabvirg;
   mrep_copietitretabpoint.caption:=ch_mrep_copietitretabpoint;
   mrep_copietitretabvirg.caption:=ch_mrep_copietitretabvirg;
   mrep_copiegraphique.caption:=ch_mrep_copiegraphique;
   mrep_mesures.caption:=ch_mrep_mesures;
   mrep_stop.caption:=ch_mrep_stop;
end;

initialization
  {$I umglz_rep.lrs}
 //chart1.bottomaxis.
end.


