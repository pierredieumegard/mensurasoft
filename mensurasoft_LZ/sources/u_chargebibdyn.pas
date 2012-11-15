//unité u_chargebibdyn.pas : partie du logiciel Mensurasoft_lz
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


unit U_chargebibdyn;

{$mode objfpc}{$H+}

interface

uses
{$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes ,Dynlibs

  , SysUtils;
   var  stdnead :function(n:word):pchar;stdcall;
var  stdead:function(n:word):double;stdcall;
var stdsad:function(n:word ; valeur:double):double;stdcall;
var stdnsad:function(n:word):pchar;stdcall;
var stdeb:function(n:word):word;stdcall;
var stdneb:function(n:word):pchar;stdcall;
var stdsb:function(n:word;valeur:word):word;stdcall;
var stdnsb:function(n:word):pchar; stdcall;
var stddetail:function:pchar; stdcall;

var mabibdyn:TlibHandle;
implementation


begin
pointer(stdead):=nil; pointer(stdnead):=nil;
 pointer(stdsad):=nil; pointer(stdnsad):=nil;
 pointer(stdeb):=nil; pointer(stdneb):=nil;
 pointer(stdsb):=nil;pointer(stdnsb):=nil;
 stddetail:=nil;

mabibdyn:=LoadLibrary('xdllvide2010.dll');
//writeln('adresse:',longint(mabibdyn));
  pointer(stdnead):=getprocaddress(mabibdyn,'stdnead');
  pointer(stdead):=getprocaddress(mabibdyn,'stdead');
  pointer(stdsad):=getprocaddress(mabibdyn,'stdsad');
  pointer(stdnsad):=getprocaddress(mabibdyn,'stdnsad');
    pointer(stdeb):=getprocaddress(mabibdyn,'stdeb');
      pointer(stdneb):=getprocaddress(mabibdyn,'stdneb');
  pointer(stdsb):=getprocaddress(mabibdyn,'stdsb');
    pointer(stdnsb):=getprocaddress(mabibdyn,'stdnsb');
      pointer(stddetail):=getprocaddress(mabibdyn,'stddetail');
end.

