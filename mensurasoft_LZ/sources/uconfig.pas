//unité uconfig.pas : partie du logiciel Mensurasoft_lz
// configuration personnalisée du logiciel
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


unit uconfig;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,ucommun,Dialogs,uchaines;

  procedure sauveconfig(nomfich:string);
  procedure chargeconfig(nomfich:string);

implementation
procedure sauveconfig(nomfich:string);
var f:textfile;
begin
assignfile(f,nomfich);
rewrite(f);
    if ouipilotep then
            begin writeln(f,'pilotep='+nompilotep);
                  writeln(f,'numvoiep='+inttostr(numvoiep));
                  writeln(f,'chfonctionp='+chfonctionp);
            end;
    if ouipilotea then
                  begin
                  writeln(f,'pilotea='+nompilotea);
                  writeln(f,'numvoiea='+inttostr(numvoiea));
                  writeln(f,'chfonctiona='+chfonctiona);
                  end;
    if ouipilotes then begin
                   writeln(f,'pilotes='+nompilotes);
                   writeln(f,'numvoies='+inttostr(numvoies));
                   writeln(f,'chfonctions='+chfonctions);
                   end;
    if ouipilotesaf then begin
                  writeln(f,'pilotesaf='+nompilotesaf);
                  writeln(f,'valsaf0='+floattostr(valsaf0));
                  writeln(f,'valsaf1='+floattostr(valsaf1));
                  writeln(f,'valsaf2='+floattostr(valsaf2));
                  end;
    if ouipilotesav then begin
               writeln(f,'pilotesav='+nompilotesav);
                writeln(f,'numvoiesav='+inttostr(numvoiesav));
                writeln(f,'chfonctionsav='+chfonctionsav);
                if ouipecsav then writeln(f,'pecsav=1')
                          else writeln(f,'pecsav=0');
               end;
    if ouipilotesbin then begin
             writeln(f,'pilotesbin='+nompilotesbin);
             if valsbin0 then writeln(f,'valsbin0=1')
                         else writeln(f,'valsbin0=0');
             if valsbin1 then writeln(f,'valsbin1=1')
                         else writeln(f,'valsbin1=0');
             if valsbin2 then writeln(f,'valsbin2=1')
                         else writeln(f,'valsbin2=0');
             if valsbin3 then writeln(f,'valsbin3=1')
                         else writeln(f,'valsbin3=0');
             if valsbin4 then writeln(f,'valsbin4=1')
                         else writeln(f,'valsbin4=0');
             if valsbin5 then writeln(f,'valsbin5=1')
                         else writeln(f,'valsbin5=0');
             if valsbin6 then writeln(f,'valsbin6=1')
                         else writeln(f,'valsbin6=0');
             if valsbin7 then writeln(f,'valsbin7=1')
                         else writeln(f,'valsbin7=0');

              end;
    writeln(f,'nbmaxmesures='+inttostr(nbmaxmesures));
    writeln(f,'intervalle='+floattostr(intervalle));
closefile(f);

end;

procedure chargeconfig(nomfich:string);
var f:textfile;
    chainelue:string;
    longintloc:longint;
begin
assignfile(f,nomfich);
reset(f);
while not eof(f) do
  begin
  readln(f,chainelue);
  if debutdechaine(chainelue,'=')='pilotep'
     then begin
       nompilotep:=findechaine(chainelue,'=');
       longintloc:=ucommun.chargebibdynp(nompilotep);
       ouipilotep:=true;
     end;
  if debutdechaine(chainelue,'=')='numvoiep'
     then numvoiep:=strtoint(findechaine(chainelue,'='));
  if debutdechaine(chainelue,'=')='chfonctionp'
     then chfonctionp:=findechaine(chainelue,'=');
  if debutdechaine(chainelue,'=')='pilotea'
     then begin
        nompilotea:=findechaine(chainelue,'=');
        longintloc:=ucommun.chargebibdyna(nompilotea);
        ouipilotea:=true;
     end;
   if debutdechaine(chainelue,'=')='numvoiea'
     then numvoiea:=strtoint(findechaine(chainelue,'='));
   if debutdechaine(chainelue,'=')='chfonctiona'
     then chfonctiona:=findechaine(chainelue,'=');

   if debutdechaine(chainelue,'=')='pilotes'
     then begin
        nompilotes:=findechaine(chainelue,'=');
        longintloc:=ucommun.chargebibdyns(nompilotes);
        ouipilotes:=true;
     end;
   if debutdechaine(chainelue,'=')='numvoies'
     then numvoies:=strtoint(findechaine(chainelue,'='));
   if debutdechaine(chainelue,'=')='chfonctions'
     then chfonctions:=findechaine(chainelue,'=');

      if debutdechaine(chainelue,'=')='pilotesaf'
     then begin
        nompilotesaf:=findechaine(chainelue,'=');
        longintloc:=ucommun.chargebibdynsaf(nompilotesaf);
        ouipilotesaf:=true;
         ch_saf_detailsaf:=stddetailsaf();

       // showmessage('nompilotesaf:'+nompilotesaf);
     end;
   if debutdechaine(chainelue,'=')='valsaf0'
     then valsaf0:=strtofloat(findechaine(chainelue,'='));
   if debutdechaine(chainelue,'=')='valsaf1'
     then valsaf1:=strtofloat(findechaine(chainelue,'='));
   if debutdechaine(chainelue,'=')='valsaf2'
     then valsaf2:=strtofloat(findechaine(chainelue,'='));

       if debutdechaine(chainelue,'=')='pilotesav'
     then begin
        nompilotesav:=findechaine(chainelue,'=');
        longintloc:=ucommun.chargebibdynsav(nompilotesav);
        ouipilotesav:=true;
     end;
       if debutdechaine(chainelue,'=')='numvoiesav'
     then numvoiesav:=strtoint(findechaine(chainelue,'='));
   if debutdechaine(chainelue,'=')='chfonctionsav'
     then chfonctionsav:=findechaine(chainelue,'=');
    if chainelue='pecsav=1' then ouipecsav:=true;
    if chainelue='pecsav=0'then ouipecsav:=false;


       if debutdechaine(chainelue,'=')='pilotesbin'
     then begin
        nompilotesbin:=findechaine(chainelue,'=');
        longintloc:=ucommun.chargebibdynsbin(nompilotesbin);
        ouipilotesbin:=true;
     end;
       if chainelue='valsbin0=1'   then valsbin0:=true;
       if chainelue='valsbin0=0'   then valsbin0:=false;
       if chainelue='valsbin1=1'   then valsbin1:=true ;
       if chainelue='valsbin1=0'   then valsbin1:=false;
       if chainelue='valsbin2=1'   then valsbin2:=true ;
       if chainelue='valsbin2=0'   then valsbin2:=false;
        if chainelue='valsbin3=1'   then valsbin3:=true ;
       if chainelue='valsbin3=0'   then valsbin3:=false;
        if chainelue='valsbin4=1'   then valsbin4:=true ;
       if chainelue='valsbin4=0'   then valsbin4:=false;
        if chainelue='valsbin5=1'   then valsbin5:=true ;
       if chainelue='valsbin5=0'   then valsbin5:=false;
         if chainelue='valsbin6=1'   then valsbin6:=true ;
       if chainelue='valsbin6=0'   then valsbin6:=false;
        if chainelue='valsbin7=1'   then valsbin7:=true ;
       if chainelue='valsbin7=0'   then valsbin7:=false;
       if debutdechaine(chainelue,'=')='nbmaxmesures'
               then nbmaxmesures:=strtoint(findechaine(chainelue,'='));
       if debutdechaine(chainelue,'=')='intervalle'
               then intervalle:=strtofloat(findechaine(chainelue,'='));




  end; //while not eof(f)
closefile(f);
end;


begin
end.

