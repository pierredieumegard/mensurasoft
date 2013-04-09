unit ucommun;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils  ,
  //windows,
  dynlibs,
  dialogs;
  var l:thandle;         var i:integer;
var repchar : pchar ;//array[0..80] of char;
var cdetail:function : pchar ;cdecl;
var cneap : function(n:longint):pchar;cdecl;
var cneadp :function(n:longint):pchar;cdecl;
var ceap : function(n:longint):longint;cdecl;
var ceadp:function(n:longint):double;cdecl;
var ccapture1:function(numvoie:longint;n:longint;intervalle:double):pchar;cdecl;
var ccapture1t:function(numvoie:longint;n:longint;intervalle:double):pchar;cdecl;
var cncapture1:function(numvoie:longint):pchar;cdecl;
var cncapture1t:function(numvoie:longint):pchar;cdecl;

var nompilote:string;
var ouipilote:boolean;
var numvoiep:integer;
const bavard : boolean = false ;
function chargebibdyn(ch:string):boolean;


implementation
function chargebibdyn(ch:string):boolean;
var repchar:pchar;
begin
pointer(cdetail):=nil ; pointer(ceadp):=nil; pointer(cneadp):=nil;
pointer(ccapture1t):=nil; pointer(cncapture1t):=nil;
repchar:=pchar(ch);
 L:=loadlibrary(repchar);
  pointer(cdetail):=getprocaddress(L,'cdetail');
  if bavard then if pointer(cdetail)=nil then showmessage('cdetail non chargé !')
                                         else showmessage('cdetail chargé');

  pointer(cneadp):=getprocaddress(L,'cnead');
 pointer(ceadp):=getprocaddress(L,'cead');
 pointer(ccapture1t):=getprocaddress(L,'ccapture1t');
 if bavard then if pointer(ccapture1t)<>nil then showmessage('ccapture1t chargé')
                                            else showmessage('ccapture1t non chargé');
 pointer(cncapture1t):=getprocaddress(L,'cncapture1t');
 if bavard then if pointer(cncapture1t)<>nil then showmessage('cncapture1t chargé')
                                             else showmessage('cncapture1t non chargé');
 if (pointer(cdetail)<>nil) and //(pointer(cneadp)<>nil) and (pointer(ceadp)<>nil)and
 (pointer(ccapture1t)<>nil) and(pointer(cncapture1t)<>nil)
    then begin chargebibdyn:=true ; ouipilote:=true;end
        else begin chargebibdyn:=false; ouipilote:=false; end;
end;


begin //initialisation de l'unité
pointer(cdetail):=nil ; pointer(ceadp):=nil; pointer(cneadp):=nil;
pointer(ccapture1t):=nil; pointer(cncapture1t):=nil;
ouipilote:=false;
numvoiep:=0;


end.

