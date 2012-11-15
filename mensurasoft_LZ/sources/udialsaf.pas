//unité udialsaf.pas : partie du logiciel Mensurasoft_lz
 //dialogue des sorties analogiques fixes
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

unit udialsaf;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics,
  Dialogs,
  Buttons, StdCtrls, Spin,ucommun,uchaines;

type

  { TFSAF }

  TFSAF = class(TForm)
    BBok: TBitBtn;
    BBhelp: TBitBtn;
    BBabandon: TBitBtn;
    B_choixpiloteSAF: TButton;
    FSE_SAD3: TFloatSpinEdit;
    FSE_SAD2: TFloatSpinEdit;
    FSE_SAD1: TFloatSpinEdit;
    FSE_SAD0: TFloatSpinEdit;
    L_nomSAD3: TLabel;
    L_nomSAD2: TLabel;
    L_nomSAD1: TLabel;
    L_nomSAD0: TLabel;
    L_detailSAF: TLabel;
    OD_choixpilsaf: TOpenDialog;
    procedure BBabandonClick(Sender: TObject);
    procedure BBhelpClick(Sender: TObject);
    procedure BBokClick(Sender: TObject);
    procedure B_choixpiloteSAFClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FSAF: TFSAF;

implementation

{ TFSAF }

procedure TFSAF.B_choixpiloteSAFClick(Sender: TObject);
var longintloc:integer;
begin
   od_choixpilsaf.execute;
  if (od_choixpilsaf.filename <>'')
  then begin
         longintloc:=ucommun.chargebibdynsaf(od_choixpilsaf.filename);
         if @stddetailsaf<>nil then
          begin
          ouipilotesaf:=true;
          l_detailSAF.caption:=stddetailsaf();
          ch_saf_detailsaf:=stddetailsaf();
          if length(stdnsaf(0))>1 then
             begin
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

             if length(stdnsaf(1))>1 then
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
             if length(stdnsaf(2))>1 then
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
            if length(stdnsaf(3))>1 then
             begin
                l_nomsad3.caption:=stdnsaf(3);
                FSE_SAD3.visible:=true;
                l_nomsad3.visible:=true;
             end
             else begin
                l_nomsad3.caption:=ch_saf_nomsad3;
                FSE_SAD3.visible:=false;
                l_nomsad3.visible:=false;
             end;
          end
          else ouipilotesaf:=false;
    end;
end;

procedure TFSAF.BBabandonClick(Sender: TObject);
begin
  close;
end;

procedure TFSAF.BBhelpClick(Sender: TObject);
begin
  aide(ch_html,'mensurasoft_lz_saf.html');
end;

procedure TFSAF.BBokClick(Sender: TObject);
begin
 if ouipilotesaf
   then begin
        valsaf0:=FSE_SAD0.value;
        valsaf1:=FSE_SAD1.value;
        valsaf2:=FSE_SAD2.value;
        valsaf3:=FSE_SAD3.value;
        stdsaf(0,valsaf0);
        stdsaf(1,valsaf1);
        stdsaf(2,valsaf2);
        stdsaf(3,valsaf3);
        nompilotesaf:=od_choixpilsaf.filename;
        end;
close
end;

initialization
  {$I udialsaf.lrs}

end.

