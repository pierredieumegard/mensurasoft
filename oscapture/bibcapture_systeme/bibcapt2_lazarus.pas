//Pilote (bibliothèque dynamique) pour constituants du système de l'ordinateur
// logiciel libre // libera programaro // free software
// Copyright (C) 2011 Pierre Dieumegard (pierre.dieumegard@free.fr)
// à compiler par Lazarus/FreePascal
//   http://sciencexp.free.fr
// (exemples de programmes d'application de la famille Mensurasoft )



//Ce logiciel est un logiciel libre au sens LGPL3 (http://www.gnu.org/licenses/lgpl.txt)


//Tous droits réservés.
//Cette bibliothèque est un logiciel libre ; vous pouvez la redistribuer ou
//la modifier suivant les termes de la Licence Générale Publique Limitée
//GNU telle que publiée par la Free Software Foundation ; soit la
//version 3 de la License, soit (à votre gré) toute version ultérieure.
//Cette bibliothèque est distribuée dans l'espoir qu'elle sera utile, mais
//SANS AUCUNE GARANTIE : sans même la garantie implicite de
//COMMERCIALISABILITÉ ou d'ADÉQUATION À UN OBJECTIF PARTICULIER. Consultez
//la Licence Générale Publique Limitée pour plus de détails.
//Vous devriez avoir reçu une copie de la Licence Générale Publique Limitée
//GNU avec cette bibliothèque ; si ce n'est pas le cas, écrivez à la :
//Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//MA 02110-1301, USA.
//
// This program is free software// you can redistribute it And/Or
// modify it under the terms of the GNU Lesser General Public
// License As published by the Free Software Foundation// either
// version 3 of the License, Or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY// without even the implied warranty of
// MERCHANTABILITY Or FITNESS For A PARTICULAR PURPOSE. See the GNU
// Lesser General Public License For more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along With this program// If Not, write To the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA


library bibcapt2_lazarus;

{$mode objfpc}{$H+}

uses
  Classes , sysutils,epiktimer,dateutils,keyboard,
 // windows,
  Interfaces,
  Dialogs
  { you can add units after this };

type pdouble=^double;
     psingle=^single;
var memosb:array[0..3]of boolean;
    memosa:word;
    memosad:double;
    K : TkeyEvent ;
    et:tepiktimer;diskaccesstime:timerdata;moncomposant:tcomponent;

 procedure ajoutephrase(ch:string);
 var f:textfile;
 begin
   assignfile (f, 'phrase.txt');
   append(f);
   writeln(f,ch);
   closefile(f);
   end;


function ea(n:longint):longint;
begin (*on suppose 4 voies d''entrée analogique*)
  ea:=777;
  case n of
     0 : ea:= secondoftheminute(time);
     1 : ea:=secondoftheday(time);
     2 : ea:=222;
     3 : ea:=333;

  end;
end;

function nea(n:longint):pchar;
begin
  case n of
    0 :nea:=pchar('seconde dans min');
    1 :nea:=pchar('secondes dans jour');
    2 :nea:=pchar('nombre 222');
    3 : nea:=pchar('nombre 333');
    else nea:=pchar('');
    end;
end;


function ead(n:longint):double;
begin
  //if (n=0) or (n=1)or (n=2) or (n=3) then ead:=n*5.555 else ead:=n;
  ead:=-777;
  case n of
     0 : ead:=secondoftheminute(time);
     1 : ead:=secondoftheday(time);
     2 : ead:=now;
     3 : ead:=333.33
    end;
end;

function nead(n:longint):pchar;
begin
case n of
  0 : nead:=pchar('seconde dans min');
  1 : nead:=pchar('seconde dans jour');
  2 : nead:=pchar('date (fraction de jour)');
  3 : nead:=pchar('nombre 333.33');
  else nead:=pchar('');
  end;
end;

function sa(n:longint; valeur:longint):longint;
begin (*une seule sortie analogique*)
if n=0 then begin memosa:=n ; sa:=n end else sa:=777;
end;

function nsa(n:longint):pchar;
begin
if n=0 then  nsa:=pchar('SA fictive') else nsa:=pchar('');
end;

function sad(n:longint ; valeur:double):double;
begin
if n=0 then begin memosad:=valeur; sad:=valeur;end
       else sad:=-777;
end;

function nsad(n:longint):pchar;
begin
   if n=0 then nsad:=pchar('SA fictive')else nsad:=pchar('');
end;

function rsa(n:longint):longint;
begin       (*état de la sortie analogique fictive*)
if n=0 then rsa:=memosa else rsa:=777;
end;

function rsad(n:longint):double;
begin
  if n=0 then rsad:=memosad else rsad:=-777;
end;

function eb(n:longint):longint;
begin  (*2 entrées logiques fictives*)
 if n=0 then eb:=0 else if n=1 then eb:=1 else eb:=777;
end;

function neb(n:longint):pchar;
begin
 if n=0 then neb:=pchar('EB fictive 0')
        else if n=1 then neb:=pchar('EB fictive 1')
                    else neb:=pchar('');
end;

function sb(n:longint; etat:longint):longint;
begin
 case n of
   0..3 : begin  sb:=etat; memosb[n]:=(etat=1); end;
   else sb:=777;
    end;
end;

function nsb(n:longint):pchar;
begin
nsb:=pchar('');
if n=0 then nsb:=pchar('relais A');
if n=1 then nsb:=pchar('relais B');
if n=2 then nsb:=pchar('relais C');
if n=3 then nsb:=pchar('relais D');
end;

function rsb(n:longint):longint;
begin
  if n in [0..3] then if memosb[n] then rsb:=1 else rsb:=0
                else rsb:=777;
end;

function titre : pchar;export;
begin titre:=pchar('Appareil fictif');end;

function detail : pchar;      export;
begin detail:=pchar('bibliothèque dynamique (32 bits)pour appareil fictif, par P. Dieumegard, 16 mars 2012');end;

(*les deux fonctions qui suivent sont pour EXCEL*)
function pead(n:longint):pdouble; export;
var dloc:double;
begin dloc:=ead(n);pead:=@dloc;end;

function psad(n:longint;valeur:pdouble):pdouble;export;
var dloc1,dloc2:double;
begin dloc1:=valeur^;dloc2:=sad(n,dloc1);psad:=@dloc2;end;
function pstdead(n:longint):pdouble;stdcall;export;
begin pstdead:=pead(n);end;

    (*les fonctions "std" qui suivent sont pour
    C++Builder, MSWLogo, VisualBasic, etc*)
function stdea(x:longint):longint;stdcall;export;
begin stdea:=ea(x);end;
function stdnea(x:longint):pchar;stdcall;export;
begin stdnea:=nea(x);end;
function stdnead(x:longint):pchar;stdcall; export;
begin stdnead:=nead(x);end;
function stdead(x:longint):double;stdcall;export;
begin stdead:=ead(x); end;
function stdsa(n:longint;valeur:longint):longint;stdcall;export;
begin stdsa:=sa(n,valeur);end;
function stdnsa(n:longint):pchar; stdcall;export;
begin stdnsa:=nsa(n);end;
function stdrsa(n:longint):longint; stdcall;export;
begin stdrsa:=rsa(n);end;

function stdsad(n:longint ; valeur:double):double; stdcall;export;

begin stdsad:=sad(n,valeur);end;
function stdnsad(n:longint):pchar;stdcall;export;
begin stdnsad:=nsad(n);end;
function stdrsad(n:longint):double ; stdcall;export;
begin stdrsad:=rsad(n);end;
function stdeb(n:longint):longint;stdcall;export;
begin stdeb:=eb(n);end;
function stdneb(n:longint):pchar;stdcall;export;
begin stdneb:=neb(n);end;
function stdsb(n:longint; valeur:longint):longint;stdcall;export;
begin stdsb:=sb(n,valeur);end;
function stdnsb(n:longint):pchar;stdcall;export;
begin stdnsb:=nsb(n);end;
function stdrsb(n:longint):longint;stdcall;export;
begin stdrsb:=rsb(n);end;
function stdtitre:pchar;stdcall;export;
begin stdtitre:=titre;end;
function stddetail:pchar;stdcall;export;
begin stddetail:=detail;end;

function stdeas(n:longint):single;stdcall;export;
begin stdeas:=77.77;end;
function stdsas(n:longint;val:single):single;stdcall;export;
begin stdsas:=stdsad(n,val);end;
function stdrsas(n:longint):single;stdcall;export;
begin stdrsas:=stdrsad(n);end;

function pstdeas(n:longint):psingle;stdcall;
var varloc:single;
begin varloc:=stdead(n);pstdeas:=@varloc;end;
    (*les fonctions " double " qui suivent sont pour StarOffice*)
function eadouble(x:double):double;    export;
begin  eadouble:=ead(round(x));  end;

function neadouble(x:double):pchar;
begin    neadouble:=nead(round(x));end;

function sadouble(x:double;xval:double):double;
begin sadouble:=sad(round(x),xval);end;

function nsadouble(x:double):pchar;
begin nsadouble:=nsad(round(x));end;

function rsadouble(x:double):double;
begin rsadouble:=rsad(round(x));end;

function ebdouble(x:double):double;
begin ebdouble:=eb(round(x));end;

function nebdouble(x:double):pchar;
begin nebdouble:=neb(round(x));end;

function sbdouble(n:double;etat:double):double;
begin sbdouble:=sb(round(n),round(etat));end;

function nsbdouble(n:double):pchar;
begin nsbdouble:=nsb(round(n));end;

function rsbdouble(n:double):double;
begin rsbdouble:=rsb(round(n));end;

function stdeadouble(x:double):double;stdcall;export;
begin  stdeadouble:=ead(round(x));  end;

function stdneadouble(x:double):pchar;stdcall;export;
begin    stdneadouble:=nead(round(x));end;

function stdsadouble(x:double;xval:double):double;stdcall;export;
begin stdsadouble:=sad(round(x),xval);end;

function stdnsadouble(x:double):pchar;stdcall;export;
begin stdnsadouble:=nsad(round(x));end;

function stdrsadouble(x:double):double;stdcall;export;
begin stdrsadouble:=rsad(round(x));end;

function stdebdouble(x:double):double;stdcall;export;
begin stdebdouble:=eb(round(x));end;

function stdnebdouble(x:double):pchar;stdcall;export;
begin stdnebdouble:=neb(round(x));end;

function stdsbdouble(n:double;etat:double):double;stdcall;export;
begin stdsbdouble:=sb(round(n),round(etat));end;

function stdnsbdouble(n:double):pchar;stdcall;export;
begin stdnsbdouble:=nsb(round(n));end;

function stdrsbdouble(n:double):double;stdcall;export;
begin stdrsbdouble:=rsb(round(n));end;

function titreparamdouble(n:double):pchar;stdcall;export;
begin titreparamdouble:=titre;end;

function detailparamdouble(n:double):pchar;stdcall;export;
begin detailparamdouble:=detail;end;
function titreparam(n:longint):pchar;stdcall;export;
begin titreparam:=titre;end;

function detailparam(n:longint):pchar;stdcall;export;
begin detailparam:=detail;end;

function cea(x:longint):longint;cdecl;export; alias : 'cea';
begin cea:=ea(x);end;
function cnea(x:longint):pchar;cdecl;export; alias : 'cnea';
begin cnea:=nea(x);end;
function cnead(x:longint):pchar;cdecl; export;  alias : 'cnead';
begin cnead:=nead(x);end;
function cead(x:longint):double;cdecl;export;  alias : 'cead';
begin cead:=ead(x); end;
function csa(n:longint;valeur:longint):longint;cdecl;export;alias : 'csa';
begin csa:=sa(n,valeur);end;
function cnsa(n:longint):pchar; cdecl;export;   alias :'cnsa';
begin cnsa:=nsa(n);end;
function crsa(n:longint):longint; cdecl;export;   alias :'crsa';
begin crsa:=rsa(n);end;

function csad(n:longint ; valeur:double):double; cdecl;export; alias :'csad';
begin csad:=sad(n,valeur);end;
function cnsad(n:longint):pchar;cdecl;export;   alias :'cnsad';
begin cnsad:=nsad(n);end;
function crsad(n:longint):double ; cdecl;export; alias :'crsad';
begin crsad:=rsad(n);end;
function ceb(n:longint):longint;cdecl;export;   alias : 'ceb';
begin ceb:=eb(n);end;
function cneb(n:longint):pchar;cdecl;export; alias : 'cneb';
begin cneb:=neb(n);end;
function csb(n:longint; valeur:longint):longint;cdecl;export;alias : 'csb';
begin csb:=sb(n,valeur);end;
function cnsb(n:longint):pchar;cdecl;export;  alias : 'cnsb';
begin cnsb:=nsb(n);end;
function crsb(n:longint):longint;cdecl;export; alias : 'crsb';
begin crsb:=rsb(n);end;
function ctitre:pchar;cdecl;export; alias : 'ctitre';
begin ctitre:=titre;end;
function cdetail:pchar;cdecl;export; alias :'cdetail';
begin cdetail:=detail;end;

function ceas(n:longint):single;cdecl;export; alias : 'ceas';
begin ceas:=77.77;end;
function csas(n:longint;val:single):single;cdecl;export;  alias :'csas';
begin csas:=csad(n,val);end;
function crsas(n:longint):single;cdecl;export; alias :'crsas';
begin crsas:=crsad(n);end;

function pceas(n:longint):psingle;cdecl;  export;  alias:'pceas';
var varloc:single;
begin varloc:=cead(n);pceas:=@varloc;end;
function ceadouble(x:double):double;cdecl;export;  alias:'ceadouble';
begin  ceadouble:=ead(round(x));  end;

function cneadouble(x:double):pchar;cdecl;export;  alias:'cneadouble';
begin    cneadouble:=nead(round(x));end;

function csadouble(x:double;xval:double):double;cdecl;export; alias:'csadouble';
begin csadouble:=sad(round(x),xval);end;

function cnsadouble(x:double):pchar;cdecl;export;   alias :'cnsadouble';
begin cnsadouble:=nsad(round(x));end;

function crsadouble(x:double):double;cdecl;export; alias : 'crsadouble';
begin crsadouble:=rsad(round(x));end;

function cebdouble(x:double):double;cdecl;export; alias :'cebdouble';
begin cebdouble:=eb(round(x));end;

function cnebdouble(x:double):pchar;cdecl;export;        alias :'cnebdouble';
begin cnebdouble:=neb(round(x));end;

function csbdouble(n:double;etat:double):double;cdecl;export;  alias:'csbdouble';
begin csbdouble:=sb(round(n),round(etat));end;

function cnsbdouble(n:double):pchar;cdecl;export;   alias:'cnsbdouble';
begin cnsbdouble:=nsb(round(n));end;

function crsbdouble(n:double):double;cdecl;export; alias : 'crsbdouble';
begin crsbdouble:=rsb(round(n));end;


function chainedenombre(x:double):string;
var chloc:string;
begin
   str(x,chloc);
   chainedenombre:=chloc;
   end;

function nombredechaine(ch:string):double;
var err:integer;doubleloc:double;
begin
  val(ch,doubleloc,err);
  nombredechaine:=doubleloc;
  end;

function stdeadstr(x:pchar):pchar;stdcall;export;
begin  stdeadstr:=pchar(chainedenombre(eadouble(nombredechaine(string(x)))));  end;

function stdneadstr(x:pchar):pchar;stdcall;export;
begin    stdneadstr:=neadouble(nombredechaine(string(x)));end;

function stdsadstr(x:pchar;xval:pchar):pchar;stdcall;export;
begin stdsadstr:=pchar(chainedenombre(sadouble(nombredechaine(string(x)),nombredechaine(string(xval)))));end;

function stdnsadstr(x:pchar):pchar;stdcall;export;
begin stdnsadstr:=nsadouble(nombredechaine(string(x)));end;

function stdebstr(x:pchar):pchar;stdcall;export;
begin stdebstr:=pchar(chainedenombre(ebdouble(nombredechaine(string(x)))));end;

function stdnebstr(x:pchar):pchar;stdcall;export;
begin stdnebstr:=nebdouble(nombredechaine(string(x)));end;

function stdsbstr(n:pchar;etat:pchar):pchar;stdcall;export;
begin stdsbstr:=pchar(chainedenombre(sbdouble(nombredechaine(string(n)),nombredechaine(string((etat))))));end;

function stdnsbstr(n:pchar):pchar;stdcall;export;
begin stdnsbstr:=nsbdouble(nombredechaine(string((n))));end;


function ceadstr(x:pchar):pchar;cdecl;export;        alias:'ceadstr';
begin  ceadstr:=pchar(chainedenombre(eadouble(nombredechaine(string(x)))));  end;

function cneadstr(x:pchar):pchar;cdecl;export;                         alias:'cneadstr';
begin    cneadstr:=neadouble(nombredechaine(string(x)));end;

function csadstr(x:pchar;xval:pchar):pchar;cdecl;export;      alias:'csadstr';
begin csadstr:=pchar(chainedenombre(sadouble(nombredechaine(string(x)),nombredechaine(string(xval)))));end;

function cnsadstr(x:pchar):pchar;cdecl;export;               alias:'cnsadstr';
begin cnsadstr:=nsadouble(nombredechaine(string(x)));end;

function cebstr(x:pchar):pchar;cdecl;export;         alias:'cebstr';
begin cebstr:=pchar(chainedenombre(ebdouble(nombredechaine(string(x)))));end;

function cnebstr(x:pchar):pchar;cdecl;export;  alias:'cnebstr';
begin cnebstr:=nebdouble(nombredechaine(string(x)));end;

function csbstr(n:pchar;etat:pchar):pchar;cdecl;export;  alias :'csbstr';
begin csbstr:=pchar(chainedenombre(sbdouble(nombredechaine(string(n)),nombredechaine(string((etat))))));end;

function cnsbstr(n:pchar):pchar;cdecl;export;            alias:'cnsbstr';
begin cnsbstr:=nsbdouble(nombredechaine(string((n))));end;


// Fonctions capture pour oscillo rapide

// Fonctions capture pour oscillo rapide
function chrono_us : double;
 var
  (*ctr1,ctr2,overhead,freq:int64;
  doubleloc:double;  *)
  i:integer;
begin
 (* QueryPerformanceFrequency(freq); {Get frequency}
  QueryPerformanceCounter(ctr1); {Get initial count}
  QueryPerformanceCounter(ctr2); {Get 1st end count}
  doubleloc:=ctr1/freq;
  chrono_us:=doubleloc*1000000;*)

 chrono_us:=et.elapsed(diskaccesstime)*1000000.0;
  end;


(*function chainedenombre(x:double):string;
var chloc:ansistring;
begin
  chloc:=floattostr(x);
  for i:=1 to length(chloc) do if chloc[i]=',' then chloc[i]:='.';
  chainedenombre:=chloc;
end;
*)
function stdcapture1(numvoie:longint ; n : longint;intervalle:double):pchar;stdcall;export;
var text:string;       var iloc:integer;
var tactuel,tdepart:double;
    tabmes:array [1..1000]of double;
begin
  text:='';
  //setlength(tabmes ,n);
  et.clear( diskaccesstime);
  tdepart:=chrono_us;tactuel:=chrono_us;
  if (numvoie=0)or(numvoie=1) then
     begin
     if numvoie=0 then tabmes[1]:=tactuel-int(tactuel/1000)*1000 ;
     if  numvoie=1 then tabmes[1]:=1000*sin((tactuel-tdepart)/1000);
     for iloc:=1 to n-1 do
        begin
           repeat until chrono_us>tdepart+iloc*intervalle;
           tactuel:=chrono_us;
           if numvoie=0 then tabmes[iloc+1]:=tactuel-int(tactuel/1000)*1000;
           if numvoie=1 then tabmes[iloc+1]:=1000*sin((tactuel-tdepart)/1000);
           end;
     for iloc:=1 to n do
       begin
         text:=text+chainedenombre(tabmes[iloc]);
         if iloc<n then text:=text+chr(13)+chr(10);
        end;
     end;
  //setlength(tabmes,0);
  stdcapture1:=pchar(text);
end;

function  stdncapture1 (numvoie:longint):pchar;stdcall;export;
begin
case numvoie of
   0 : stdncapture1:=pchar('gettickcount');
   1 : stdncapture1:=pchar('1000*sin(ms)');
   else stdncapture1:=pchar('');
end;
end;

function ccapture1(numvoie:longint ; n : longint;intervalle:double):pchar;alias :'ccapture1';cdecl;export;
begin ccapture1:=stdcapture1(numvoie,n,intervalle);end;

function  cncapture1 (numvoie:longint):pchar;cdecl;alias : 'cncapture1';export;
begin cncapture1:=stdncapture1(numvoie);end;

function stdcapture1t(numvoie:longint ; n : longint;intervalle:double):pchar;stdcall;export;
var text:ansistring;       var iloc:integer;
var tactuel,tdepart:double;
    tabmes:array [1..1000]of double; tabtemps:array[1..1000] of double;
    var pcharloc:pchar;

begin
  text:='';
 // setlength(tabmes ,n);  setlength(tabtemps,n);
  tdepart:=chrono_us;tactuel:=chrono_us;
  if (numvoie=0)or(numvoie=1) then
     begin
     tabtemps[1]:=tactuel-tdepart;
     if numvoie=0 then tabmes[1]:=tactuel-int(tactuel/1000)*1000 ;
     if  numvoie=1 then tabmes[1]:=1000*sin((tactuel-tdepart)/1000);
     for iloc:=1 to n-1 do
        begin
           repeat until chrono_us>tdepart+iloc*intervalle;
           tactuel:=chrono_us;  tabtemps[iloc+1]:=tactuel-tdepart;
           if numvoie=0 then tabmes[iloc+1]:=tactuel-int(tactuel/1000)*1000;
           if numvoie=1 then tabmes[iloc+1]:=1000*sin((tactuel-tdepart)/1000);
           end;
  //  (*
    text:='';
    for iloc:=1 to n do
       begin
         text:=text+floattostr(1.0*tabtemps[iloc]*1.0)+','+floattostr(tabmes[iloc]);
         if iloc<n then text:=text+chr(13)+chr(10);
        end;
      //  *)

     end;
  //setlength(tabmes,0);  setlength(tabtemps,0);
  //stdcapture1t:=pchar(text);

       pcharloc:=pchar(text);
       stdcapture1t:=pcharloc;
  //stdcapture1t:=pchar('0,3'+chr(13)+chr(10)+'5,10'+chr(13)+chr(10)+'8,10');
end;

function  stdncapture1t (numvoie:longint):pchar;stdcall;export;
begin
case numvoie of
   0 : stdncapture1t:=pchar('µs dans ms');
   1 : stdncapture1t:=pchar('1000*sin(ms)');
   else stdncapture1t:=pchar('');
end;
end;

function ccapture1t(numvoie:longint ; n : longint;intervalle:double):pchar;cdecl;export; alias : 'ccapture1t';
begin ccapture1t:=stdcapture1t(numvoie,n,intervalle);end;

function  cncapture1t (numvoie:longint):pchar;cdecl;export;   alias:'cncapture1t';
begin cncapture1t:=stdncapture1t(numvoie);end;

function ccalcapture1(ch:pchar):pchar;cdecl;export;alias:'ccalcapture1';
begin
  ShowMessage('Fenêtre fictive de réglage de l''interface');
end;

function stdcapture2(numvoie:longint ; n : longint;intervalle:longint):pchar;stdcall;export;
var text:string;       var iloc:integer;
var tactuel,tdepart:double;
    tabmes0,tabmes1:array [1..1000]of double;
begin
  text:='';
  tdepart:=chrono_us;tactuel:=chrono_us;
  if (numvoie=0) then
     begin
    // setlength(tabmes0 ,n); setlength(tabmes1,n);
     tabmes0[1]:=tactuel-round(tactuel/1000)*1000 ;
     tabmes1[1]:=1000*sin((tactuel-tdepart)/1000);
     for iloc:=1 to n-1 do
        begin
           repeat until chrono_us>tdepart+iloc*intervalle;
           tactuel:=chrono_us;
           tabmes0[iloc+1]:=tactuel-round(tactuel/1000)*1000;
           tabmes1[iloc+1]:=1000*sin((tactuel-tdepart)/1000);
           end;
     for iloc:=1 to n do
       begin
         text:=text+floattostr(tabmes0[iloc])+','+floattostr(tabmes1[iloc]);
         if iloc<n then text:=text+chr(13)+chr(10);
        end;
     end;
  //setlength(tabmes0,0); setlength(tabmes1,0);
  stdcapture2:=pchar(text);
end;

function  stdncapture2 (numvoie:longint):pchar;stdcall;export;
begin
case numvoie of
   0 : stdncapture2:=pchar('µs dans ms | 1000*sin(ms)');
   else stdncapture2:=pchar('');
end;
end;

function ccapture2(numvoie:longint ; n : longint;intervalle:longint):pchar;cdecl;export;alias:'ccapture2';
begin ccapture2:=stdcapture2(numvoie,n,intervalle);end;

function  cncapture2 (numvoie:longint):pchar;cdecl;export; alias:'cncapture2';
begin cncapture2:=stdncapture2(numvoie);end;

function stdcapture2t(numvoie:longint ; n : longint;intervalle:longint):pchar;stdcall;export;
var text:string;       var iloc:integer;
var tactuel,tdepart:double;
    tabmes0,tabmes1:array [1..1000]of double; tabtemps:array [1..1000]of double;
begin
  text:='';
  //setlength(tabmes0 ,n);setlength(tabmes1,n);  setlength(tabtemps,n);
  tdepart:=chrono_us;tactuel:=chrono_us;
  if (numvoie=0) then
     begin
     tabtemps[1]:=tactuel-tdepart;
     tabmes0[1]:=tactuel-round(tactuel/1000)*1000 ;
     tabmes1[1]:=1000*sin((tactuel-tdepart)/1000);
     for iloc:=1 to n-1 do
        begin
           repeat until chrono_us>tdepart+iloc*intervalle;
           tactuel:=chrono_us;  tabtemps[iloc+1]:=tactuel-tdepart;
           tabmes0[iloc+1]:=tactuel-round(tactuel/1000)*1000;
           tabmes1[iloc+1]:=1000*sin((tactuel-tdepart)/1000);
           end;
     for iloc:=1 to n do
       begin
         text:=text+floattostr(tabtemps[iloc])+','+floattostr(tabmes0[iloc])+','+floattostr(tabmes1[iloc]);
         if iloc<n then text:=text+chr(13)+chr(10);
        end;
     end;
  //setlength(tabmes0,0); setlength(tabmes1,0); setlength(tabtemps,0);
  stdcapture2t:=pchar(text);
end;

function  stdncapture2t (numvoie:longint):pchar;stdcall;export;
begin
case numvoie of
   0 : stdncapture2t:=pchar('µs dans ms | sin(ms)*1000');
   else stdncapture2t:=pchar('');
end;
end;

function ccapture2t(numvoie:longint ; n : longint;intervalle:longint):pchar;cdecl;export;  alias : 'ccapture2t';
begin ccapture2t:=stdcapture2t(numvoie,n,intervalle);end;

function  cncapture2t (numvoie:longint):pchar;cdecl;export; alias:'cncapture2t';
begin cncapture2t:=stdncapture2t(numvoie);end;


exports
  ea ,  nea ,  ead ,  nead,   sa ,  nsa,  sad ,  nsad ,  rsa ,  rsad ,
  eb ,neb ,sb ,nsb ,rsb ,titre ,detail,pead ,    psad ,  pstdead, pstdeas,
  eadouble ,  neadouble ,sadouble,nsadouble,rsadouble,
  ebdouble,nebdouble, sbdouble, nsbdouble,rsbdouble,
  stdea, stdnea,stdead,stdnead, stdsa,stdnsa,
  stdsad,stdnsad,stdeb,stdneb,stdsb,stdnsb,stdrsad,stdrsb,
  stdtitre,stddetail, stdeas,stdsas,stdrsas,
    stdeadouble,stdneadouble,stdsadouble,stdnsadouble,stdrsadouble,
  stdebdouble,stdnebdouble,stdsbdouble,stdnsbdouble,stdrsbdouble,

  cea, cnea,cead,cnead,csa,cnsa,crsa,csad,cnsad,crsad,ceb,cneb,csb,cnsb,crsb,
  ctitre,cdetail, ceas,csas,crsas,pceas,
  ceadouble,cneadouble,csadouble,cnsadouble,crsadouble,
  cebdouble,cnebdouble,csbdouble,cnsbdouble,crsbdouble,

  titreparam,detailparam,titreparamdouble,detailparamdouble,
  stdeadstr,stdneadstr,stdsadstr,stdnsadstr,stdebstr,stdnebstr,stdsbstr,stdnsbstr,
  ceadstr,cneadstr,csadstr,cnsadstr,cebstr,cnebstr,csbstr,cnsbstr,

  stdcapture1,stdncapture1,ccapture1,cncapture1,stdcapture1t,stdncapture1t,ccapture1t,cncapture1t,
  stdcapture2,stdncapture2,ccapture2,cncapture2,stdcapture2t,stdncapture2t,ccapture2t,cncapture2t;



begin
//initialisation éventuelle de l'appareil
 ET := TEpikTimer.Create(moncomposant);
  et.clear(diskaccesstime);
  et.start(diskaccesstime);

end.



