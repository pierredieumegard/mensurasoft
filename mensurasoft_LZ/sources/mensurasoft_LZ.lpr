//logiciel Mensurasoft_lz

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


program mensurasoft_LZ;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces,SysUtils, // this includes the LCL widgetset
  Forms, umglz, LResources, TAChartLazarusPkg, umglz_rep, udialmat,
  dialogs,
  udialtemps,

   //ucommun,
    uchaines, udialsaf, udialsbin, udialsav, uconfig//, udialtemps
  { you can add units after this };

{$IFDEF WINDOWS}{$R mensurasoft_LZ.rc}{$ENDIF}
var i:integer;
begin
  {$I mensurasoft_LZ.lrs}
  Application.Initialize;
  Application.CreateForm(TFmglz, Fmglz);
  Application.CreateForm(tf_dialmat, f_dialmat);
  Application.CreateForm(Tfdialtemps, fdialtemps);
  Application.CreateForm(TFSAF, FSAF);
  Application.CreateForm(Tfdialsbin, fdialsbin);
  Application.CreateForm(TFSAV, FSAV);
  //MessageDlg (paramstr(1),paramstr(2), mtConfirmation,[mbYes, mbNo, mbIgnore],0) ;
  //messagedlg(extractfileext(paramstr(1)),extractfileext(paramstr(2)),mtconfirmation,[mbYes],0);
  if paramcount >0
      then
          for i:=1 to paramcount do
             begin
              if uppercase(extractfileext(paramstr(i)))='.LNG'
                     then begin
                       chargelangue(paramstr(i));
                       fmglz.mi_changelangue;
                     end;
              if uppercase(extractfileext(paramstr(i)))='.CFG'
                      then begin
                         chargeconfig(paramstr(i));

                      end;
              end;
  if fileexists('mensurasoft_LZ.cfg') then  chargeconfig('mensurasoft_LZ.cfg');
  if fileexists('mensurasoft_LZ.lng') then
      begin
      chargelangue('mensurasoft_LZ.lng');
      fmglz.mi_changelangue;
      end;
  Application.Run;
end.

