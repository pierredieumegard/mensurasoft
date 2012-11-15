//unité umglz.pas : partie du logiciel Mensurasoft_lz
// unité principale du logiciel
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


unit umglz;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  umglz_rep, udialmat, ucommun,
  {$IFDEF WINDOWS} Windows,     {$ENDIF}
{$IFDEF LINUX} Linux, {$ENDIF}

   uchaines, udialtemps, ueval_0130,udialsaf,udialsbin,udialsav,
   uconfig, //uevalexpr,
  StdCtrls, Menus, ExtCtrls, LazHelpHTML;

type

  { TFmglz }

  TFmglz = class(TForm)
    Button1: TButton;
    IdleTimer1: TIdleTimer;
    MainMenu1: TMainMenu;
    MI_chargeconfig: TMenuItem;
    MI_sauveconfig: TMenuItem;
    MI_apropos: TMenuItem;
    MI_interro: TMenuItem;
    MI_aide: TMenuItem;
    MI_choixlangue: TMenuItem;
    MI_Cadrages: TMenuItem;
    MI_temporel: TMenuItem;
    MI_Faitmesures: TMenuItem;
    mi_quitter: TMenuItem;
    mi_Reglages:TMenuItem;
    mi_mesures: TMenuItem;
    mi_sav: TMenuItem;
    ODchangelangue: TOpenDialog;
    mi_sbin: TMenuItem;
    mi_SAF: TMenuItem;
    mi_supplement: TMenuItem;
    mi_auxiliaire: TMenuItem;
    mi_principal: TMenuItem;
    mi_fichier: TMenuItem;
    mi_ouvrir: TMenuItem;
    ODchargeconfig: TOpenDialog;
    ODlitfichier: TOpenDialog;
    SDsauveconfig: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure assignechaines(sender:tobject);
    procedure IdleTimer1Timer(Sender: TObject);
    procedure MI_aideClick(Sender: TObject);
    procedure MI_aproposClick(Sender: TObject);
    procedure MI_chargeconfigClick(Sender: TObject);
    procedure MI_choixlangueClick(Sender: TObject);
    procedure MI_changelangue;
    procedure MI_interroClick(Sender: TObject);
    procedure MI_FaitmesuresClick(Sender: TObject);
    procedure MI_sauveconfigClick(Sender: TObject);
    procedure MI_temporelClick(Sender: TObject);
    procedure mi_auxiliaireClick(Sender: TObject);
    procedure mi_experienceClick(Sender: TObject);
    procedure mi_ouvrirClick(Sender: TObject);
    procedure mi_principalClick(Sender: TObject);
    procedure mi_ReglagesClick(sender : tobject);
    procedure mi_quitterClick(Sender: TObject);
    procedure mi_SAFClick(Sender: TObject);
    procedure mi_savClick(Sender: TObject);
    procedure mi_supplementClick(Sender: TObject);
    procedure MI_CadragesClick(Sender : Tobject);
    procedure mi_sbinClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Fmglz: TFmglz;

implementation

{ TFmglz }

procedure TFmglz.Button1Click(Sender: TObject);
begin
  Application.CreateForm(TFrepere, Frepere);
  Frepere.show;
end;

procedure TFmglz.FormCreate(Sender: TObject);
begin
  //self.assignechaines(sender);
  assignechaines(Sender);
end;

procedure tfmglz.assignechaines(sender:tobject);
begin
fmglz.caption:=ch_titreG;
 mi_fichier.caption:= ch_menufichier;
 mi_ouvrir.caption:=ch_mf_ouvrir;
 mi_quitter.caption:=ch_mf_quitter;

   mi_Reglages.caption:=ch_menureglages;
  // mi_experience.caption:=ch_menuexperience;
  mi_temporel.Caption:=ch_mr_temps;
  mi_cadrages.caption:=ch_mr_cadrages;
  mi_principal.caption:=ch_mr_matprinc;
  mi_auxiliaire.caption:=ch_mr_mataux;
  mi_supplement.caption:=ch_mr_matsup;
  mi_sav.Caption:=ch_mr_savariable;
  mi_saf.caption:=ch_mr_safixe;
  mi_sbin.caption:=ch_mr_sbin;
   mi_mesures.caption:=ch_menumesures;
   mi_faitmesures.caption:=ch_mm_acquisition;
   mi_aide.caption:=ch_ma_aide;
   mi_choixlangue.caption:=ch_ma_langue;
    mi_apropos.caption:=ch_ma_apropos;
    mi_sauveconfig.caption:=ch_ma_sauveconfig;
    mi_chargeconfig.caption:=ch_ma_chargeconfig;
end;

procedure TFmglz.IdleTimer1Timer(Sender: TObject);
var chloc,chlocp,chloca,chlocs:string;
var valeadp,valeada,valeads:double;
begin
    Fmglz.idletimer1.interval:=intervalle_bandeau*1000;
    valeadp:=beadp;valeada:=beada;valeads:=beads;
    chloc:='Mensurasoft-lz ';
    chlocp:= stringreplace(chfonctionp,'xp',floattostr(valeadp),[rfReplaceAll, rfIgnoreCase]);
    chlocp:= stringreplace(chlocp,'xa',floattostr(valeada),[rfReplaceAll, rfIgnoreCase]);
    chlocp:= stringreplace(chlocp,'xs',floattostr(valeads),[rfReplaceAll, rfIgnoreCase]);
    chloca:= stringreplace(chfonctiona,'xp',floattostr(valeadp),[rfReplaceAll, rfIgnoreCase]);
    chloca:= stringreplace(chloca,'xa',floattostr(valeada),[rfReplaceAll, rfIgnoreCase]);
    chloca:= stringreplace(chloca,'xs',floattostr(valeads),[rfReplaceAll, rfIgnoreCase]);
    chlocs:= stringreplace(chfonctions,'xp',floattostr(valeadp),[rfReplaceAll, rfIgnoreCase]);
    chlocs:= stringreplace(chlocs,'xa',floattostr(valeada),[rfReplaceAll, rfIgnoreCase]);
    chlocs:= stringreplace(chlocs,'xs',floattostr(valeads),[rfReplaceAll, rfIgnoreCase]);

    (*if ouipilotep and (numvoiep>-1)
       then chloc:=chloc+stdtitrep()+stdneadp(numvoiep)+':'+floattostr(stdeadp(numvoiep));
    if ouipilotea and (numvoiea>-1)
       then chloc:=chloc+'||'+stdtitrea()+stdneada(numvoiea)+':'+floattostr(stdeada(numvoiea));
    if ouipilotes and (numvoies>-1)
       then chloc:=chloc+'||'+stdtitres()+stdneads(numvoies)+':'+floattostr(stdeads(numvoies));*)
    if ouipilotep and (numvoiep>-1)
       then chloc:=chloc+stdneadp(numvoiep)+':'+floattostrf(evaluechaine(chlocp),FFfixed,7,3);
    if ouipilotea and (numvoiea>-1)
       then chloc:=chloc+'||'+stdneada(numvoiea)+':'+floattostrF(evaluechaine(chloca),FFfixed,7,3);
    if ouipilotes and (numvoies>-1)
       then chloc:=chloc+'||'+stdneads(numvoies)+':'+floattostrf(evaluechaine(chlocs),FFfixed,7,3);

fmglz.caption:=chloc;
end;

procedure TFmglz.MI_aideClick(Sender: TObject);
begin
  aide(ch_html,'mensurasoft_lz_general.html');
end;

procedure TFmglz.MI_aproposClick(Sender: TObject);
var chloc:string;
begin
chloc:='Mensurasoft-LZ'+chr(13);
chloc:=chloc+'(c) Pierre Dieumegard, 2012-10-29'+chr(13);
chloc:=chloc+'pierre.dieumegard@free.fr';

  showmessage(chloc);
end;

procedure TFmglz.MI_chargeconfigClick(Sender: TObject);
begin
   if  ODchargeconfig.execute then chargeconfig(ODchargeconfig.FileName);
end;

procedure TFmglz.MI_changelangue;
begin
    mi_fichier.caption:=ch_menufichier;
    mi_ouvrir.caption:=ch_mf_ouvrir;
    mi_quitter.caption:=ch_mf_quitter;
    mi_reglages.caption:=ch_menureglages;
    mi_temporel.caption:=ch_mr_temps;
    mi_cadrages.caption:=ch_mr_cadrages;
    mi_principal.caption:=ch_mr_matprinc;
    mi_auxiliaire.caption:=ch_mr_mataux;
    mi_supplement.caption:=ch_mr_matsup;
    mi_sav.caption:=ch_mr_savariable;
    mi_saf.caption:=ch_mr_safixe;
    mi_sbin.caption:=ch_mr_sbin;
    mi_mesures.caption:=ch_menumesures;
    mi_faitmesures.caption:=ch_mm_acquisition;
    //mi_interro
    mi_aide.caption:=ch_ma_aide;
    mi_choixlangue.caption:=ch_ma_langue;
    mi_apropos.caption:=ch_ma_apropos;
    mi_sauveconfig.caption:=ch_ma_sauveconfig;
    mi_chargeconfig.caption:=ch_ma_chargeconfig;

end;

procedure TFmglz.MI_choixlangueClick(Sender: TObject);
begin
  if ODchangelangue.execute
    then chargelangue(ODchangelangue.Filename);
         mi_changelangue;
    end;

procedure TFmglz.MI_interroClick(Sender: TObject);
begin

end;

procedure TFmglz.MI_FaitmesuresClick(Sender: TObject);
begin
   Application.CreateForm(TFrepere, Frepere);
   Frepere.Chart1.Bottomaxis.title.Caption:='t(s)';
    Frepere.Timerrepere.interval:=round(intervalle*1000);
   setlength(Frepere.tabtemps,nbmaxmesures);
   setlength(Frepere.tabP,nbmaxmesures);
   setlength(Frepere.tabA,nbmaxmesures);
   setlength(Frepere.tabS,nbmaxmesures);
  Frepere.show;
  Frepere.localouifaitmesures:=true;
  Frepere.tdepart:=now();
  Frepere.localnbmaxmesures:=nbmaxmesures;
  if ouipiloteP then begin
                     Frepere.localneadp:=stdneadp(numvoieP);
                     Frepere.localtitrep:=string(stdtitrep());
                     Frepere.Chart1.LeftAxis.title.caption:=stdneadp(numvoieP)+'||'+chfonctionp;
                     end;
  if ouipiloteA then begin
                       Frepere.localneada:=stdneada(numvoieA);
                       Frepere.Chart1.AxisList[2].title.caption:=stdneada(numvoieA)+'||'+chfonctiona;
                       Frepere.Chart1.Axislist[2].visible:=true;
                       Frepere.Chart1.Axislist[2].Title.font.color:=clgreen;
                       Frepere.Chart1.Axislist[2].Title.visible:=true;
                       end;

  if ouipiloteS then Frepere.localneads:=stdneads(numvoieS);
end;

procedure TFmglz.MI_sauveconfigClick(Sender: TObject);
begin
  if SDsauveconfig.Execute then sauveconfig(SDsauveconfig.FileName);
    //Memo1.Lines.SaveToFile( SaveDialog1.Filename );
end;



procedure TFmglz.mi_ReglagesClick(sender:tobject);
begin
end;



procedure TFmglz.mi_principalClick(Sender: TObject);
var iloc:integer;
begin
  // Application.CreateForm(TFrepere, Frepere);
  typedialmat:=1;
  f_dialmat.listbox1.items.clear  ;
  f_dialmat.editfonction.text:=chfonctionp;
  f_dialmat.caption:=ch_fdialmatp;
  f_dialmat.dm_choixvoie.caption:=ch_dm_choixvoie;
  f_dialmat.dm_boutonpilote.caption:=ch_dm_boutonpilote;
  f_dialmat.dm_boutoncalibration.caption:=ch_dm_boutoncalibration;
  f_dialmat.dm_boutoncalibration.enabled:=ouicalibrationp;
  f_dialmat.dm_fonctransf.caption:=ch_dm_fonctransf;
  //f_dialmat.lcm_detailpilote.caption:=ch_lcm_detailpilote;
  f_dialmat.lcm_detailpilote.caption:=detailpilotep;
 // messagebox(0,pchar('//'+uppercase(osversion)+'//'),'',0);
  //if uppercase(osversion)='WINDOWS'
        if osversion[1]='W'
        then f_dialmat.od_choixpil.filter:='pilote= *.dll |*.dll'
        else f_dialmat.od_choixpil.filter:='pilote= *.so |*.so';

  if ouipilotep
       then begin
        f_dialmat.lcm_detailpilote.caption:=detailpilotep;
          iloc:=0;
          while length(stdneadp(iloc))>1 do
             begin
               f_dialmat.listbox1.items.add(stdneadp(iloc));
               iloc:=iloc+1;
             end;
             f_dialmat.listbox1.itemindex:=numvoiep;
          end;
  f_dialmat.showmodal;
end;

procedure TFmglz.mi_auxiliaireClick(Sender: TObject);
var iloc:integer;
begin
  typedialmat:=2;
  f_dialmat.listbox1.items.clear;
  f_dialmat.editfonction.text:=chfonctiona;
   f_dialmat.caption:=ch_fdialmata;
  f_dialmat.dm_choixvoie.caption:=ch_dm_choixvoie;
  f_dialmat.dm_boutonpilote.caption:=ch_dm_boutonpilote;
  f_dialmat.dm_boutoncalibration.caption:=ch_dm_boutoncalibration;
  f_dialmat.dm_boutoncalibration.enabled:=ouicalibrationa;
   //f_dialmat.dm_boutoncalibration.visible:=ouicalibrationa;

  f_dialmat.dm_fonctransf.caption:=ch_dm_fonctransf;
  f_dialmat.lcm_detailpilote.caption:=detailpilotea;
   if osversion[1]='W'
        then f_dialmat.od_choixpil.filter:='pilote= *.dll |*.dll'
        else f_dialmat.od_choixpil.filter:='pilote= *.so |*.so';
  if ouipilotea
     then  begin
     f_dialmat.lcm_detailpilote.caption:=detailpilotea;
          iloc:=0;
          while length(stdneada(iloc))>1 do
             begin
               f_dialmat.listbox1.items.add(stdneada(iloc));
               iloc:=iloc+1;
             end;
              f_dialmat.listbox1.itemindex:=numvoiea;
          end;
  f_dialmat.showmodal;
end;

procedure TFmglz.mi_experienceClick(Sender: TObject);
begin

end;

procedure TFmglz.mi_ouvrirClick(Sender: TObject);
var ch_alpha:string;
const ouititres:boolean=false;
var f:textfile;
    chlue,petitechaine:string;
    sep:char;
    i:integer;
    xloc,ploc,aloc,sloc:double;
function metspoint(ch:string):string;
var iloc:integer;
var chloc:string;
begin
chloc:=ansitoutf8(ch);
  for iloc:=1 to length(chloc) do
        if chloc[iloc]=',' then chloc[iloc]:='.';

  metspoint:=chloc;
  //showmessage('après metspoint : '+ chloc);
end;
function evaluechaine(ch:string):double;
var iloc:integer;
var chloc:string;
begin
chloc:=ch;
for iloc:=1 to length(chloc) do
   if not (chloc[i] in ['0'..'9']) then chloc[i]:='.';

//showmessage(chloc);
evaluechaine:=strtofloat(chloc);
end;

begin
  if ODlitfichier.execute
    then begin
    Application.CreateForm(TFrepere, Frepere);
   setlength(Frepere.tabtemps,nbmaxmesures);
   setlength(Frepere.tabP,nbmaxmesures);
   setlength(Frepere.tabA,nbmaxmesures);
   setlength(Frepere.tabS,nbmaxmesures);
    Frepere.Chart1.Axislist[2].visible:=true;
                       Frepere.Chart1.Axislist[2].Title.font.color:=clgreen;
                       Frepere.Chart1.Axislist[2].Title.visible:=true;

  Frepere.show;
  Frepere.localouifaitmesures:=false;
  ch_alpha:='ABCDFGHIJKLMNOPQRSTUVWXYZ';
  Frepere.localnbmaxmesures:=nbmaxmesures;
          assignfile(f,ODlitfichier.filename);
        reset(f);
        if not eof(f) then
           begin
           readln(f,chlue);
           if pos(chr(9),chlue)>0 then sep:=chr(9)
                   else if pos(';',chlue)>0 then sep:=';'
                        else sep:=',';
           for i:=1 to length(ch_alpha) do
                    if pos(ch_alpha[i],upcase(chlue))>0 then ouititres:=true;
          // showmessage(chlue);
           if ouititres
               then begin
                  Frepere.Chart1.Bottomaxis.title.Caption:=debutdechaine(chlue,sep);
                  chlue:=findechaine(chlue,sep);
                  Frepere.Chart1.LeftAxis.title.caption:=debutdechaine(chlue,sep);
                  chlue:=findechaine(chlue,sep);
                  Frepere.Chart1.Axislist[2].title.caption:=debutdechaine(chlue,sep);
                  end
               else if length(chlue)>2 then begin
                 //showmessage('debut xloc:'+debutdechaine(chlue,sep));
                 xloc:=strtofloat(metspoint(debutdechaine(chlue,sep)));
                 chlue:=findechaine(chlue,sep);
                 //showmessage('debut ploc:'+debutdechaine(chlue,sep));
                 ploc:=strtofloat(metspoint(debutdechaine(chlue,sep)));
                 chlue:=findechaine(chlue,sep);
                 Frepere.CLSP.AddXY(xloc,ploc,'',clred);
                 if length(chlue)>0
                       then begin
                            chlue:=findechaine(chlue,sep);
                            aloc:=strtofloat(metspoint(debutdechaine(chlue,sep)));
                            Frepere.CLSP.AddXY(xloc,aloc,'',clgreen);
                            chlue:=findechaine(chlue,sep);
                            if length(chlue)>0
                               then begin
                                  sloc:=strtofloat(metspoint(debutdechaine(chlue,sep)));
                                  Frepere.CLSP.AddXY(xloc,aloc,'',clblue);
                               end;
                       end;
               end;
           end;
        while not eof(f) do
          begin
          readln(f,chlue);
          if length(chlue)>2
             then begin
          xloc:=strtofloat(metspoint(debutdechaine(chlue,sep)));
          //xloc:=evaluechaine(debutdechaine(chlue,sep));
                 chlue:=findechaine(chlue,sep);
                 ploc:=strtofloat(metspoint(debutdechaine(chlue,sep)));
                 //ploc:=evaluechaine(debutdechaine(chlue,sep));
                 chlue:=findechaine(chlue,sep);
                 Frepere.CLSP.AddXY(xloc,ploc,'',clred);
                 if length(chlue)>0
                       then begin
                            //chlue:=findechaine(chlue,sep);
                            aloc:=strtofloat(metspoint(debutdechaine(chlue,sep)));
                            Frepere.CLSA.AddXY(xloc,aloc,'',clgreen);
                            chlue:=findechaine(chlue,sep);
                            if length(chlue)>0
                               then begin
                                  sloc:=strtofloat(metspoint(debutdechaine(chlue,sep)));
                                  Frepere.CLSS.AddXY(xloc,sloc,'',clblue);
                               end;
                       end;

             end;
          end;
        closefile(f);
    end;
  //ShowMessage('Mensurasoft-lz  : fichier || ouvrir :fonction inexistante');
end;


procedure TFmglz.mi_supplementClick(Sender: TObject);
var iloc:integer;
begin
 typedialmat:=3;
 f_dialmat.listbox1.items.clear;
 f_dialmat.editfonction.text:=chfonctions;
  f_dialmat.caption:=ch_fdialmats;
  f_dialmat.dm_choixvoie.caption:=ch_dm_choixvoie;
  f_dialmat.dm_boutonpilote.caption:=ch_dm_boutonpilote;
  f_dialmat.dm_boutoncalibration.caption:=ch_dm_boutoncalibration;
   f_dialmat.dm_boutoncalibration.enabled:=ouicalibrations;
   //f_dialmat.dm_boutoncalibration.visible:=ouicalibrations;
  f_dialmat.dm_fonctransf.caption:=ch_dm_fonctransf;
  f_dialmat.lcm_detailpilote.caption:=detailpilotes;
   if osversion[1]='W'
        then f_dialmat.od_choixpil.filter:='pilote= *.dll |*.dll'
        else f_dialmat.od_choixpil.filter:='pilote= *.so |*.so';
 if ouipilotes
     then begin
     f_dialmat.lcm_detailpilote.caption:=detailpilotes;
          iloc:=0;
          while length(stdneads(iloc))>1 do
             begin
               f_dialmat.listbox1.items.add(stdneads(iloc));
               iloc:=iloc+1;
             end;
              f_dialmat.listbox1.itemindex:=numvoies;
          end;
 f_dialmat.showmodal;
end;

procedure TFmglz.MI_CadragesClick(Sender: Tobject);
begin
  ShowMessage('Fonction encore inexistante : Mensurasoft-lz : Réglages Cadrages');
end;

procedure TFmglz.mi_sbinClick(Sender: TObject);
begin
  //messagebox(0,'Fonction encore inexistante','Mensurasoft lz : sorties binaires fixes',0);
  fdialsbin.Caption:=ch_fdialsbin;
  fdialsbin.fbin_labeldetailpilotesbin.caption:=ch_fbin_labeldetailpilotesbin;
  fdialsbin.fbin_labelchoixvoies.caption:=ch_fbin_labelchoixvoies;
  fdialsbin.fbin_boutonpilotesbin.caption:=ch_fbin_boutonpilotesbin;
   if osversion[1]='W'
        then fdialsbin.od_choixpilsbin.filter:='pilote= *.dll |*.dll'
        else fdialsbin.od_choixpilsbin.filter:='pilote= *.so |*.so';
  with fdialsbin do
    begin
      fbin_cb_sbin0.checked:=valsbin0;
  fbin_cb_sbin1.checked:=valsbin1;
  fbin_cb_sbin2.checked:=valsbin2;
  fbin_cb_sbin3.checked:=valsbin3;
  fbin_cb_sbin4.checked:=valsbin4;
  fbin_cb_sbin5.checked:=valsbin5;
  fbin_cb_sbin6.checked:=valsbin6;
  fbin_cb_sbin7.checked:=valsbin7;
    end;


  fdialsbin.showmodal;


end;


procedure TFmglz.MI_temporelClick(Sender : Tobject);
begin
fdialtemps.SEnbmesures.value:=nbmaxmesures;
fdialtemps.FSE_intervallemesures.value:=intervalle;
fdialtemps.SE_intervallebandeau.value:=intervalle_bandeau;
fdialtemps.caption:=ch_fdialtemps;
   fdialtemps.dt_intervallemesures.caption:=ch_dt_intervallemesures;
   fdialtemps.dt_intervallebandeau.caption:=ch_dt_intervallebandeau;
   fdialtemps.dt_nbmesures.caption:=ch_dt_nombremesures;
fdialtemps.showmodal;
end;

procedure TFmglz.mi_quitterClick(Sender: TObject);
begin
   close;
end;

procedure TFmglz.mi_SAFClick(Sender: TObject);
begin
  FSAF.Caption:=ch_fsaf;
  FSAF.L_detailSAF.caption:=ch_saf_detailsaf;
  FSAF.L_nomSAD0.caption:=ch_saf_nomsad0;
  FSAF.L_nomSAD1.caption:=ch_saf_nomsad1;
  FSAF.L_nomSAD2.caption:=ch_saf_nomsad2;
  FSAF.B_choixpiloteSAF.caption:=ch_saf_choixpilotesaf;
  FSAF.FSE_sad0.value:=valsaf0;
  FSAF.FSE_sad1.value:=valsaf1;
  FSAF.FSE_sad2.value:=valsaf2;
  //showmessage('dans safclick');
  with FSAF do
  begin
  //showmessage('début de fsaf');
  //if ouipilotesaf then showmessage('ouipilotesaf !');
  if ouipilotesaf  and (length(stdnsaf(0))>1) then
             begin
             //showmessage('safclick ouipilotesaf');
                l_nomsad0.caption:=stdnsaf(0);
                ch_saf_nomsad0:=stdnsaf(0);
                FSE_SAD0.visible:=true;
                l_nomsad0.visible:=true;
             end
             else begin
                l_nomsad0.caption:=ch_saf_nomsad0;
                FSE_SAD0.visible:=false;
                l_nomsad0.visible:=false;
             end;

             if ouipilotesaf and (length(stdnsaf(1))>1) then
             begin
                l_nomsad1.caption:=stdnsaf(1);
                FSE_SAD1.visible:=true;
                l_nomsad1.visible:=true;
             end
             else begin
                l_nomsad1.caption:=ch_saf_nomsad1;
                FSE_SAD1.visible:=false;
                l_nomsad1.visible:=false;
             end;
             if ouipilotesaf and (length(stdnsaf(2))>1) then
             begin
                l_nomsad2.caption:=stdnsaf(2);
                FSE_SAD2.visible:=true;
                l_nomsad2.visible:=true;
             end
             else begin
                l_nomsad2.caption:=ch_saf_nomsad2;
                FSE_SAD2.visible:=false;
                l_nomsad2.visible:=false;

             end;
  end;
  //showmessage('avant osversion');
   if osversion[1]='W'
        then fsaf.od_choixpilsaf.filter:='pilote= *.dll |*.dll'
        else fsaf.od_choixpilsaf.filter:='pilote= *.so |*.so';
  FSAF.showmodal;
 //messagebox(0,'Fonction encore inexistante','Mensurasoft-lz : sortie analogique fixe',0);
end;

procedure TFmglz.mi_savClick(Sender: TObject);
var iloc:integer;
begin
  //messagebox(0,'Fonction encore inexistante','Mensurasoft-lz : sortie analogique variable',0);
  with fsav do
       begin
       caption:=ch_fsav;
       lsav_detailpilotesav.caption:=ch_lsav_detailpilotesav;
       lsav_listesad.caption:=ch_lsav_listesad;
       bsav_choixpilotesav.caption:=ch_bsav_choixpilotesav;
       lsav_fonctransav.Caption:=ch_lsav_fonctransav;
       Esav_fonctransav.text:=chfonctionsav;
       cbsav_priseencompte.caption:=ch_cbsav_priseencompte;
       cbsav_priseencompte.checked:=ouipecsav;
       Listbox1.itemindex:=numvoiesav;
       listbox1.items.clear;
        if osversion[1]='W'
        then fsav.od_choixpilsav.filter:='pilote= *.dll |*.dll'
        else fsav.od_choixpilsav.filter:='pilote= *.so |*.so';
       end;

       if ouipilotesav
       then begin
       fsav.lsav_detailpilotesav.caption:=stddetailsav();
          iloc:=0;
          while length(stdnsav(iloc))>1 do
             begin
               fsav.listbox1.items.add(stdnsav(iloc));
               iloc:=iloc+1;
             end;
             fsav.listbox1.itemindex:=numvoiesav;
          end;
       fsav.showmodal;
end;

initialization
  {$I umglz.lrs}

end.

