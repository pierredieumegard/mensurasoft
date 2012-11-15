//unité u_chargebibdyn_base.pas : partie du logiciel Mensurasoft_lz
 //charge les bibliothèques dynamiques
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

unit u_chargebibdyn_base_cdecl;

{$mode objfpc}{$H+}

interface

uses
{$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes ,Dynlibs

  , SysUtils;
   var  stdnead,basestdneadp,basestdneada,basestdneads:function(n:longint):pchar;cdecl;
    var basestdnsaf:function(n:longint):pchar; cdecl;
    var basestdnsav:function(n:longint):pchar;cdecl;
var  stdead,basestdeadp,basestdeada,basestdeads:function(n:longint):double;cdecl;
var basestdsaf:function(n:longint;valeur:double):double;cdecl;
var basestdsav:function(n:longint;valeur:double):double;cdecl;
var stdsad:function(n:longint ; valeur:double):double;cdecl;

var stdnsad:function(n:longint):pchar;cdecl;
var stdeb:function(n:longint):longint;cdecl;
var stdneb:function(n:longint):pchar;cdecl;
var stdsb:function(n:longint;valeur:longint):longint;cdecl;
var stdnsb:function(n:longint):pchar; cdecl;
var basestdsb:function(n:longint;valeur:longint):longint;cdecl;
var basestdnsb:function(n:longint):pchar;cdecl;
var stddetail,basestddetailp,basestddetaila,basestddetails:function:pchar; cdecl;
var stdtitre,basestdtitrep,basestdtitrea,basestdtitres:function:pchar;cdecl;
var basestdtitresaf,basestddetailsaf:function:pchar;cdecl;
var basestdtitresav,basestddetailsav:function:pchar;cdecl;
var basestdtitresb,basestddetailsb:function:pchar;cdecl;
var mabibdyn,basemabibdynp,basemabibdyna,basemabibdyns,basemabibdynsaf:TlibHandle;
var basemabibdynsb,basemabibdynsav:Tlibhandle;
procedure chargebibdyn(nomfich:string);
procedure  basechargebibdynp(nomfich:string);
procedure basechargebibdyna(nomfich:string);
procedure basechargebibdyns(nomfich:string);
procedure basechargebibdynsaf(nomfich:string);
procedure basechargebibdynsav(nomfich:string);
procedure basechargebibdynsb(nomfich:string);

implementation



procedure  chargebibdyn(nomfich:string);
begin
pointer(stdead):=nil; pointer(stdnead):=nil;
 pointer(stdsad):=nil; pointer(stdnsad):=nil;
 pointer(stdeb):=nil; pointer(stdneb):=nil;
 pointer(stdsb):=nil;pointer(stdnsb):=nil;
 pointer(stddetail):=nil;pointer(stdtitre):=nil;

mabibdyn:=LoadLibrary(nomfich);
  pointer(stdnead):=getprocaddress(mabibdyn,'cnead');
  pointer(stdead):=getprocaddress(mabibdyn,'cead');
  pointer(stdsad):=getprocaddress(mabibdyn,'csad');
  pointer(stdnsad):=getprocaddress(mabibdyn,'cnsad');
    pointer(stdeb):=getprocaddress(mabibdyn,'ceb');
      pointer(stdneb):=getprocaddress(mabibdyn,'cneb');
  pointer(stdsb):=getprocaddress(mabibdyn,'csb');
    pointer(stdnsb):=getprocaddress(mabibdyn,'cnsb');
      pointer(stddetail):=getprocaddress(mabibdyn,'cdetail');
      pointer(stdtitre):=getprocaddress(mabibdyn,'ctitre');
      end;

procedure  basechargebibdynp(nomfich:string);
begin
pointer(basestdeadp):=nil; pointer(basestdneadp):=nil;
 pointer(basestddetailp):=nil;pointer(basestdtitrep):=nil;
basemabibdynp:=LoadLibrary(nomfich);
  pointer(basestdneadp):=getprocaddress(basemabibdynp,'cnead');
  pointer(basestdeadp):=getprocaddress(basemabibdynp,'cead');
      pointer(basestddetailp):=getprocaddress(basemabibdynp,'cdetail');
      pointer(basestdtitrep):=getprocaddress(basemabibdynp,'ctitre');
      end;

procedure  basechargebibdyna(nomfich:string);
begin
pointer(basestdeada):=nil; pointer(basestdneada):=nil;
 pointer(basestddetaila):=nil;pointer(basestdtitrea):=nil;
basemabibdyna:=LoadLibrary(nomfich);
  pointer(basestdneada):=getprocaddress(basemabibdyna,'cnead');
  pointer(basestdeada):=getprocaddress(basemabibdyna,'cead');
      pointer(basestddetaila):=getprocaddress(basemabibdyna,'cdetail');
      pointer(basestdtitrea):=getprocaddress(basemabibdyna,'ctitre');
      end;



procedure  basechargebibdyns(nomfich:string);
begin
pointer(basestdeads):=nil; pointer(basestdneads):=nil;
 pointer(basestddetails):=nil;pointer(basestdtitres):=nil;
basemabibdyns:=LoadLibrary(nomfich);
  pointer(basestdneads):=getprocaddress(basemabibdyns,'cnead');
  pointer(basestdeads):=getprocaddress(basemabibdyns,'cead');
      pointer(basestddetails):=getprocaddress(basemabibdyns,'cdetail');
      pointer(basestdtitres):=getprocaddress(basemabibdyns,'ctitre');
      end;

procedure  basechargebibdynsaf(nomfich:string);
begin
pointer(basestdsaf):=nil; pointer(basestdnsaf):=nil;
 pointer(basestddetailsaf):=nil;pointer(basestdtitresaf):=nil;
basemabibdynsaf:=LoadLibrary(nomfich);
  pointer(basestdnsaf):=getprocaddress(basemabibdynsaf,'cnsad');
  pointer(basestdsaf):=getprocaddress(basemabibdynsaf,'csad');
      pointer(basestddetailsaf):=getprocaddress(basemabibdynsaf,'cdetail');
      pointer(basestdtitresaf):=getprocaddress(basemabibdynsaf,'ctitre');
      end;

procedure  basechargebibdynsav(nomfich:string);
begin
pointer(basestdsav):=nil; pointer(basestdnsav):=nil;
 pointer(basestddetailsav):=nil;pointer(basestdtitresav):=nil;
basemabibdynsav:=LoadLibrary(nomfich);
  pointer(basestdnsav):=getprocaddress(basemabibdynsav,'cnsad');
  pointer(basestdsav):=getprocaddress(basemabibdynsav,'csad');
      pointer(basestddetailsav):=getprocaddress(basemabibdynsav,'cdetail');
      pointer(basestdtitresav):=getprocaddress(basemabibdynsav,'ctitre');
      end;


procedure basechargebibdynsb(nomfich:string);
begin
pointer(basestdsb):=nil;pointer(basestdnsb):=nil;
pointer(basestddetailsb):=nil;pointer(basestdtitresb):=nil;
basemabibdynsb:=loadlibrary(nomfich);
pointer(basestdnsb):=getprocaddress(basemabibdynsb,'cnsb');
pointer(basestdsb):=getprocaddress(basemabibdynsb,'csb');
pointer(basestddetailsb):=getprocaddress (basemabibdynsb,'cdetail');
pointer(basestdtitresb):=getprocaddress(basemabibdynsb,'ctitre');

end;

end.

