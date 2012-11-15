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


unit u_chargebibdyn_base_stdcall;

{$mode objfpc}{$H+}

interface

uses
{$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes ,Dynlibs

  , SysUtils;
   var  stdnead,basestdneadp,basestdneada,basestdneads:function(n:longint):pchar;stdcall;
    var basestdnsaf:function(n:longint):pchar; stdcall;
    var basestdnsav:function(n:longint):pchar;stdcall;
var  stdead,basestdeadp,basestdeada,basestdeads:function(n:longint):double;stdcall;
var basestdsaf:function(n:longint;valeur:double):double;stdcall;
var basestdsav:function(n:longint;valeur:double):double;stdcall;
var stdsad:function(n:longint ; valeur:double):double;stdcall;

var stdnsad:function(n:longint):pchar;stdcall;
var stdeb:function(n:longint):longint;stdcall;
var stdneb:function(n:longint):pchar;stdcall;
var stdsb:function(n:longint;valeur:longint):longint;stdcall;
var stdnsb:function(n:longint):pchar; stdcall;
var basestdsb:function(n:longint;valeur:longint):longint;stdcall;
var basestdnsb:function(n:longint):pchar;stdcall;
var stddetail,basestddetailp,basestddetaila,basestddetails:function:pchar; stdcall;
var stdtitre,basestdtitrep,basestdtitrea,basestdtitres:function:pchar;stdcall;
var basestdtitresaf,basestddetailsaf:function:pchar;stdcall;
var basestdtitresav,basestddetailsav:function:pchar;stdcall;
var basestdtitresb,basestddetailsb:function:pchar;stdcall;
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
  pointer(stdnead):=getprocaddress(mabibdyn,'stdnead');
  pointer(stdead):=getprocaddress(mabibdyn,'stdead');
  pointer(stdsad):=getprocaddress(mabibdyn,'stdsad');
  pointer(stdnsad):=getprocaddress(mabibdyn,'stdnsad');
    pointer(stdeb):=getprocaddress(mabibdyn,'stdeb');
      pointer(stdneb):=getprocaddress(mabibdyn,'stdneb');
  pointer(stdsb):=getprocaddress(mabibdyn,'stdsb');
    pointer(stdnsb):=getprocaddress(mabibdyn,'stdnsb');
      pointer(stddetail):=getprocaddress(mabibdyn,'stddetail');
      pointer(stdtitre):=getprocaddress(mabibdyn,'stdtitre');
      end;

procedure  basechargebibdynp(nomfich:string);
begin
pointer(basestdeadp):=nil; pointer(basestdneadp):=nil;
 pointer(basestddetailp):=nil;pointer(basestdtitrep):=nil;
basemabibdynp:=LoadLibrary(nomfich);
  pointer(basestdneadp):=getprocaddress(basemabibdynp,'stdnead');
  pointer(basestdeadp):=getprocaddress(basemabibdynp,'stdead');
      pointer(basestddetailp):=getprocaddress(basemabibdynp,'stddetail');
      pointer(basestdtitrep):=getprocaddress(basemabibdynp,'stdtitre');
      end;

procedure  basechargebibdyna(nomfich:string);
begin
pointer(basestdeada):=nil; pointer(basestdneada):=nil;
 pointer(basestddetaila):=nil;pointer(basestdtitrea):=nil;
basemabibdyna:=LoadLibrary(nomfich);
  pointer(basestdneada):=getprocaddress(basemabibdyna,'stdnead');
  pointer(basestdeada):=getprocaddress(basemabibdyna,'stdead');
      pointer(basestddetaila):=getprocaddress(basemabibdyna,'stddetail');
      pointer(basestdtitrea):=getprocaddress(basemabibdyna,'stdtitre');
      end;



procedure  basechargebibdyns(nomfich:string);
begin
pointer(basestdeads):=nil; pointer(basestdneads):=nil;
 pointer(basestddetails):=nil;pointer(basestdtitres):=nil;
basemabibdyns:=LoadLibrary(nomfich);
  pointer(basestdneads):=getprocaddress(basemabibdyns,'stdnead');
  pointer(basestdeads):=getprocaddress(basemabibdyns,'stdead');
      pointer(basestddetails):=getprocaddress(basemabibdyns,'stddetail');
      pointer(basestdtitres):=getprocaddress(basemabibdyns,'stdtitre');
      end;

procedure  basechargebibdynsaf(nomfich:string);
begin
pointer(basestdsaf):=nil; pointer(basestdnsaf):=nil;
 pointer(basestddetailsaf):=nil;pointer(basestdtitresaf):=nil;
basemabibdynsaf:=LoadLibrary(nomfich);
  pointer(basestdnsaf):=getprocaddress(basemabibdynsaf,'stdnsad');
  pointer(basestdsaf):=getprocaddress(basemabibdynsaf,'stdsad');
      pointer(basestddetailsaf):=getprocaddress(basemabibdynsaf,'stddetail');
      pointer(basestdtitresaf):=getprocaddress(basemabibdynsaf,'stdtitre');
      end;

procedure  basechargebibdynsav(nomfich:string);
begin
pointer(basestdsav):=nil; pointer(basestdnsav):=nil;
 pointer(basestddetailsav):=nil;pointer(basestdtitresav):=nil;
basemabibdynsav:=LoadLibrary(nomfich);
  pointer(basestdnsav):=getprocaddress(basemabibdynsav,'stdnsad');
  pointer(basestdsav):=getprocaddress(basemabibdynsav,'stdsad');
      pointer(basestddetailsav):=getprocaddress(basemabibdynsav,'stddetail');
      pointer(basestdtitresav):=getprocaddress(basemabibdynsav,'stdtitre');
      end;


procedure basechargebibdynsb(nomfich:string);
begin
pointer(basestdsb):=nil;pointer(basestdnsb):=nil;
pointer(basestddetailsb):=nil;pointer(basestdtitresb):=nil;
basemabibdynsb:=loadlibrary(nomfich);
pointer(basestdnsb):=getprocaddress(basemabibdynsb,'stdnsb');
pointer(basestdsb):=getprocaddress(basemabibdynsb,'stdsb');
pointer(basestddetailsb):=getprocaddress (basemabibdynsb,'stddetail');
pointer(basestdtitresb):=getprocaddress(basemabibdynsb,'stdtitre');

end;

end.

