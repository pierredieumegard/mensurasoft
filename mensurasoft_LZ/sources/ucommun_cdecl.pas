//unité ucommun.pas : partie du logiciel Mensurasoft_lz
//déclaration des variables communes
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

unit ucommun_cdecl;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Dos,
   {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  dynlibs,
{$IFDEF WINDOWS} Windows,     {$ENDIF}
{$IFDEF LINUX} Linux, {$ENDIF}

  Dialogs, //Uentrees,
  u_chargebibdyn_base;

const
  typedialmat: integer   = 0;
  ouipilotep: boolean    = False;
  ouipilotea: boolean    = False;
  ouipilotes: boolean    = False;
  ouipilotesav:boolean=false;
  ouipilotesaf: boolean  = False;
  ouipilotesbin: boolean = False;
  ouipecsav:boolean=false;
  nompilotep:string='';nompilotea:string='';nompilotes:string='';
  nompilotesaf:string='';nompilotesav:string='';nompilotesbin:string='';
  detailpilotep:string='';detailpilotea:string='';detailpilotes:string='';
  ouifaitmesures: boolean = False;
  numvoiep: integer = -1;
  numvoiea: integer = -1;
  numvoies: integer = -1;
  numvoiesav:integer=-1;
  chfonctionp: string = 'xP';
  chfonctiona: string = 'xA';
  chfonctions: string = 'xS';
  chfonctionsav:string='0';
  nbmaxmesures: integer = 100;
  intervalle: double = 1;
  intervalle_bandeau: integer = 1;
  valsaf0: double   = 0;
  valsaf1: double   = 0;
  valsaf2: double   = 0;
  valsaf3:double = 0;
  valsbin0: boolean = False;
  valsbin1: boolean = False;
  valsbin2: boolean = False;
  valsbin3: boolean = False;
  valsbin4: boolean = False;
  valsbin5: boolean = False;
  valsbin6: boolean = False;
  valsbin7: boolean = False;

var
  stdneadp, stdneada, stdneads: function(n: longint): PChar; cdecl;

var
  stdeadp, stdeada, stdeads: function(n: longint): double; cdecl;

var
  stdsad: function(n: longint; valeur: double): double; cdecl;

var
  stdsaf: function(n: longint; valeur: double): double; cdecl;
  var stdsav : function (n:longint;valeur:double):double;cdecl;

var
  stdnsad: function(n: longint): PChar; cdecl;

var
  stdeb: function(n: longint): longint; cdecl;

var
  stdneb: function(n: longint): PChar; cdecl;

var
  stdsb: function(n: longint; valeur: longint): longint; cdecl;

var
  stdnsb: function(n: longint): PChar; cdecl;

var
  stdnsaf: function(n: longint): PChar; cdecl;
  var stdnsav:function(n:longint):pchar;cdecl;

var
  stddetailp, stddetaila, stddetails, stddetailsaf: function(): PChar; cdecl;
  stddetailsb:function():pchar;cdecl;
  stdtitresb:function():pchar;cdecl;
  stdtitresav:function():pchar;cdecl;
  stddetailsav:function():pchar;cdecl;
var
  stdtitrep, stdtitrea, stdtitres, stdtitresaf: function(): PChar; cdecl;
 //var fonctionp,fonctiona,fonctions:fonction;
 //var stdtitrep:function():ansistring;cdecl;
function chargebibdynp(nomfich: string): longint;
function chargebibdyna(nomfich: string): longint;
function chargebibdyns(nomfich: string): longint;
function chargebibdynsav(nomfich:string):longint;
function chargebibdynsaf(nomfich: string): longint;
function chargebibdynsbin(nomfich: string): longint;
function beadp: double;
function beada: double;
function beads: double;
function debutdechaine(ch: string; sep: char): string;
function findechaine(ch: string; sep: char): string;
function osversion:string;
procedure Aide(Rep,Fch:string);

implementation
{$IFDEF UNIX}
uses
//{$IF (lcl_major = 0) and (lcl_minor = 9) and (lcl_release < 27)}
  Process;
//{$ELSE}
 // UTF8Process;
//{$ENDIF}
{$ENDIF}
function chargebibdynp(nomfich: string): longint;
var
  i: integer;
var
  mabibdynp: TlibHandle;

begin
  basechargebibdynp(nomfich);
  stddetailp := basestddetailp;
  stdtitrep  := basestdtitrep;
  stdeadp    := basestdeadp;
  stdneadp   := basestdneadp;
  //  messagebox(0,'detail dans chargebibdynp:',stddetailp(),0);
  //messagebox(0,'ctitrep dans chargebibdynp:',ctitrep(),0);
end;


function chargebibdyna(nomfich: string): longint;
var
  i: integer;
var
  mabibdyna: TlibHandle;

begin
  basechargebibdyna(nomfich);
  stddetaila := basestddetaila;
  stdtitrea  := basestdtitrea;
  stdeada    := basestdeada;
  stdneada   := basestdneada;
  //messagebox(0,'detail dans chargebibdyna:',stddetaila(),0);
end;

function chargebibdyns(nomfich: string): longint;
var
  i: integer;
var
  mabibdyns: TlibHandle;
begin
  basechargebibdyns(nomfich);
  stddetails := basestddetails;
  stdtitres  := basestdtitres;
  stdeads    := basestdeads;
  stdneads   := basestdneads;
  //messagebox(0,'detail dans chargebibdyns:',stddetails(),0);
end;

function chargebibdynsav(nomfich:string):longint;
begin
basechargebibdynsav(nomfich);
stddetailsav:=basestddetailsav;
stdtitresav:=basestdtitresav;
stdsav:=basestdsav;
stdnsav:=basestdnsav;
end;

function chargebibdynsaf(nomfich: string): longint;
begin
  basechargebibdynsaf(nomfich);
  stddetailsaf := basestddetailsaf;
  stdtitresaf := basestdtitresaf;
  stdsaf  := basestdsaf;
  stdnsaf := basestdnsaf;
end;

function chargebibdynsbin(nomfich: string): longint;
begin
  basechargebibdynsb(nomfich);
  stddetailsb := basestddetailsb;
  stdtitresb:=basestdtitresb;
  stdsb:=basestdsb;
  stdnsb:=basestdnsb;
end;

function beadp: double;
begin
  if ouipilotep and (numvoiep > -1) then
    beadp := stdeadp(numvoiep)
  else
    beadp := 0;
end;

function beada: double;
begin
  if ouipilotea and (numvoiea > -1) then
    beada := stdeada(numvoiea)
  else
    beada := 0;
end;

function beads: double;
begin
  if ouipilotes and (numvoies > -1) then
    beads := stdeads(numvoies)
  else
    beads := 0;
end;


function debutdechaine(ch: string; sep: char): string;
begin
  if pos(sep, ch) = 0 then
    debutdechaine := ch
  else
    debutdechaine := copy(ch, 1, pos(sep, ch) - 1);
end;

function findechaine(ch: string; sep: char): string;
begin
  if pos(sep, ch) = 0 then
    findechaine := ''
  else
    findechaine := copy(ch, pos(sep, ch) + 1, length(ch));
end;

function osversion:string;
var
  OS      : string[32];
  Version : word;
begin
{$IFDEF LINUX} OS:='Linux'; {$ENDIF}
{$ifdef FreeBSD}  OS:='FreeBSD';{$endif}
{$ifdef NetBSD}  OS:='NetBSD';{$endif}
{$ifdef Solaris}  OS:='Solaris';{$endif}
{$ifdef QNX}  OS:='QNX';{$endif}
{$IFDEF DOS}  OS:='Dos';{$ENDIF}
{$IFDEF WINDOWS} OS:= 'Windows ';  {$ENDIF}
  Version:=DosVersion;
osversion:=OS;
end;

procedure Aide(Rep, Fch: string);
{$IFDEF UNIX}
var
//{$IF (lcl_major = 0) and (lcl_minor = 9) and (lcl_release < 27)}
 Prc: TProcess;
//{$ELSE}
 // Prc: TProcessUTF8;
//{$ENDIF}
{$ENDIF}
begin
{$IFDEF UNIX}
//{$IF (lcl_major = 0) and (lcl_minor = 9) and (lcl_release < 27)}
 Prc:= TProcess.Create(nil);
//{$ELSE}
  //Prc:= TProcessUTF8.Create(nil);
//{$ENDIF}
  Prc.CurrentDirectory:= Rep;
  Prc.CommandLine:= 'xdg-open '+Fch;
  Prc.Execute;
  if Prc.ExitStatus <> 0 then
   Showmessage(Fch);// MessageErreur(Fch);
  Prc.Free;
{$ENDIF}
{$IFDEF WIN32}
  if ShellExecute(0, 'open', PChar(Fch), nil, PChar(Rep), SW_SHOWNORMAL) <= 32 then
    showmessage('Absent : '+Fch);
{$ENDIF}
end;

begin
  //definis_fonction('PAST',chfonctionP,fonctionp);
  //definis_fonction('PAST',chfonctionA,fonctiona);
  //definis_fonction('PAST',chfonctionS,fonctions);

end.

