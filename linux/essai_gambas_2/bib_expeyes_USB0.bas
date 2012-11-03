  rem Pilote (bibliothèque dynamique) pour constituants du système de l'ordinateur
rem à compiler avec FreeBasicr
rem logiciel libre // libera programaro // free software
rem Copyright (C) 2011 Pierre Dieumegard (pierre.dieumegard@free.fr)
rem    http://sciencexp.free.fr
rem (exemples de programmes d'application de la famille Mensurasoft)
rem 
rem Ce logiciel est un logiciel libre au sens LGPL3 (http://www.gnu.org/licenses/lgpl.txt)


rem Tous droits réservés.
rem Cette bibliothèque est un logiciel libre ; vous pouvez la redistribuer ou
rem la modifier suivant les termes de la Licence Générale Publique Limitée
rem GNU telle que publiée par la Free Software Foundation ; soit la
rem version 3 de la License, soit (à votre gré) toute version ultérieure.
rem Cette bibliothèque est distribuée dans l’espoir qu’elle sera utile, mais
rem SANS AUCUNE GARANTIE : sans même la garantie implicite de
rem COMMERCIALISABILITÉ ou d’ADÉQUATION À UN OBJECTIF PARTICULIER. Consultez
rem la Licence Générale Publique Limitée pour plus de détails.
rem Vous devriez avoir reçu une copie de la Licence Générale Publique Limitée
rem GNU avec cette bibliothèque ; si ce n’est pas le cas, écrivez à la :
rem Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
rem MA 02110-1301, USA.
rem 
rem This program is free software; you can redistribute it and/or
rem modify it under the terms of the GNU Lesser General Public
rem License As published by the Free Software Foundation; either
rem version 3 of the License, Or (at your option) any later version.
rem 
rem This program is distributed in the hope that it will be useful,
rem but WITHOUT ANY WARRANTY; without even the implied warranty of
rem MERCHANTABILITY Or FITNESS For A PARTICULAR PURPOSE. See the GNU
rem Lesser General Public License For more details.
rem 
rem You should have received a copy of the GNU Lesser General Public
rem License along With this program; if not, write to the Free Software
rem Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA


'#include once "windows.bi"  ' pour la dll de windows
'pour être "stdcall", il faut déclarer les fonctions de type "stdcall"  !
' (ou bien ne pas déclarer le type, qui est par défaut de type stdcall
rem ne pas oublier de mettre dans Voir | paramètres | FreeBasic que la destination
rem doit être une bibliothèque dynamique par -dll ou -dylib
rem par exemple "<$fbc>"  -dll  "<$file>"

dim shared memosa (0 to 5) as integer
dim shared memosad (0 to 5) as double
dim shared memosb0 as integer=0
dim shared memosb1 as integer=0
dim shared memosb (0 to 5) as integer
dim shared octet1 as byte
dim shared octet2 as byte
dim shared octet3 as byte


dim shared monport as string


dim as unsigned byte octetglob,i
dim chglob as string
dim nblu as uinteger
dim valeurlue as integer


function reponsedechaine(s as string) as string
dim chloc as string
dim octetloc as unsigned byte
dim nbluloc as uinteger
dim iloc as integer
dim longueur as integer

print #1,s
sleep(100)
chloc=""
for iloc=1 to 10
   get #1,,octetloc,,nbluloc
   if nbluloc > 0 then chloc = chloc + chr$(octetloc)
   next iloc
longueur=len(chloc)   
reponsedechaine = left(chloc,longueur-1)

end function

public function ea stdcall alias "ea"(byval n as integer)as integer export
dim chloc as string

    if n= 0 then 
          chloc=reponsedechaine(chr$(43)+str$(0))
          function=asc(mid(chloc,3,1))*256 + asc(mid(chloc,2,1))
      elseif n=1 then
            chloc=reponsedechaine(chr$(43)+str$(1))
          function=asc(mid(chloc,3,1))*256 + asc(mid(chloc,2,1))
        elseif n =2 then 
            chloc=reponsedechaine(chr$(43)+str$(2))
          function=asc(mid(chloc,3,1))*256 + asc(mid(chloc,2,1))
             elseif n=3 then 
               chloc=reponsedechaine(chr$(43)+str$(4))
          function=asc(mid(chloc,3,1))*256 + asc(mid(chloc,2,1))
          else
              function=-777
        endif
end function

public function nea stdcall alias "nea" (byval n as integer) as zstring  pointer export
    if n=0 then
       function=@"EA0 = A0"
    elseif n=1 then
           function=@"EA1 =A1"
           elseif n=2 then function=@"EA2 = A2"
           elseif n=3 then function=@"EA3 = SEN"
       else 
           function=@""
       endif
end function

public function ead stdcall alias "ead"  (byval n as integer) as double export
    if n=0 then 
          function= (ea(0)-2048)*10/4096
      elseif n=1 then
            function= (ea(1)-2048)*10/4096
            elseif n=2 then function = ea(2)*5/4096
            elseif n=3 then function=ea(3)
        else 
            function=-777
            endif
end function

public function nead stdcall alias "nead" (byval n as integer) as zstring pointer export
    if n=0 then
       function=@"EA0 = A0 "
       elseif n=1 then function=@"EA1 = A1"
       elseif n=2 then function=@"EA2 = A2"
       elseif n=3 then function=@"EA3 = SEN"
       else function=@""
       endif
end function

public function sa stdcall alias "sa" (byval n as integer , byval valeur as integer) as integer export
dim nlourd as unsigned byte
dim nleger as unsigned byte
dim chloc as string
nlourd=int(valeur/256)
nleger=valeur mod 256
if n=0 then
    print #1,(chr(121)+"0"+chr(nleger)+chr(nlourd))
    function=valeur : memosa(0)=valeur
elseif n=1 then
    print #1,(chr(121)+"1"+chr(nleger)+chr(nlourd))
    function=valeur:memosa(1)=valeur
elseif n=2 then
    nlourd=valeur
    print #1,(chr(58)+chr(valeur))
     'chloc=reponsedechaine(chr(58)+chr(valeur))
   
    function=valeur:memosa(2)=valeur
   end if
end function

public function nsa stdcall alias "nsa" (byval n as integer) as zstring pointer export
if n=0 then
    function=@"SA0 0..4095 BPV"
elseif n=1 then
    function=@"SA1 0..4095 UPV"
elseif n=2 then
    function=@"PWM 0..255 Pulse"
    else function=@""
end if
end function

public function rsa stdcall alias "rsa" (byval n as integer) as integer export
if n=0 then 
      function=memosa(0)
  elseif n=1 then 
      function=memosa(1)
  elseif n=2 then
      function=memosa(2)
      else function=-777
end if
end function

public function sad stdcall alias "sad" (byval n as integer , byval valeur as double) as double export
dim monresultat as double
monresultat=-777.89
'print "n=",n
if n=0 then 
     sa(0,int(4095*(valeur+5)/10))
     memosad(0)=valeur
     monresultat=valeur
     end if
     
if n=1 then
     sa(1,int(4095*valeur/5))
     memosad(1)=valeur:
     monresultat=valeur
     end if
     
 if n=2 then
     sa(2,int(2.5*valeur))
     memosad(2)=valeur : 
     monresultat=valeur
 end if
 function=monresultat
end function

public function nsad stdcall alias "nsad" (byval n as integer) as zstring pointer export
if n=0 then 
      function=@"SA0 -5V..+5V BPV"
  elseif n=1 then
      function=@"SA1 0..+5V UPV"
  elseif n=2 then 
      function=@"PWM 0..100 Pulse"
      else function=@""
  end if
end function


public function rsad stdcall alias "rsad" (byval n as integer) as double export
if n=0 then
     function= memosad(0)
 elseif n=1 then
     function=memosad(1)
 elseif n=2 then
     function=memosad(2)
     else function=-777
 end if
end function

public function eb stdcall alias "eb" (byval n as integer) as integer export
dim resultat as integer
resultat = asc(mid(reponsedechaine(chr(2)),2,1))
if n=0 then 
    if (resultat=11)or(resultat=9) then
        function=1
    else
        function=0
    end if
end if
if n=1 then
    if (resultat=11)or(resultat=10) then
        function=1
    else
        function = 0
    end if
end if
if n>1 then function=-777
end function

public function neb stdcall alias "neb" (byval n as integer) as zstring pointer export
if n=0 then function=@"EB 0"
if n=1 then function=@"EB 1"
if n>1 then function=@""
if n<0 then function=@""
end function


public function sb stdcall alias "sb" (byval n as integer , byval etat as integer) as integer export
dim aenvoyer as integer
dim reponse as string
if n=0 then memosb(n)=etat : function=etat end if
if n=1 then memosb(n)=etat : function = etat end if
if memosb(0) and memosb(1) then aenvoyer=3 end if
if memosb(0) and (not memosb(1)) then aenvoyer=1 end if
if (not memosb(0)) and memosb(1) then aenvoyer=2 end if
if (not memosb(0)) and (not memosb(1)) then aenvoyer=4 end if
if (n=0)or(n=1) then reponse=reponsedechaine(chr(56)+chr(aenvoyer)) end if
if n>1 then function=-777
end function

public function nsb stdcall alias "nsb" (byval n as integer) as zstring pointer export
if n=0 then nsb=@"sortie binaire 0" 
if n=1 then nsb=@"sortie binaire 1"
if n>1 then nsb=@""
if n<0 then nsb=@""
end function

public function rsb stdcall alias "rsb" (byval n as integer) as integer export
if n=0 then rsb=memosb(0)
if n=1 then rsb=memosb(1)
if n>1 then rsb=-777
end function



public function titre stdcall alias "titre"  ()  as zstring pointer export
  dim chloc as string
dim pcharloc as zstring pointer
pcharloc=allocate(50)
chloc="Expeyes en "+monport+chr$(0)
*pcharloc=chloc
    function = pcharloc
end function

public function detail stdcall alias "detail"  ()  as zstring pointer export
    dim chloc as string
dim pcharloc as zstring pointer
chloc="ExpEYES en "+monport+", P. Dieumegard le 28 juillet 2012"+chr$(0)
pcharloc = Allocate(100)
    *pcharloc = chloc
    function=pcharloc
end function

public function stdea stdcall alias "stdea" (byval n as integer) as integer export
    function = ea(n)
end function

public function stdnea stdcall alias "stdnea"  (byval n as integer) as zstring pointer export
    function = nea(n)
end function

public function stdead  stdcall alias "stdead" (byval n as integer) as double export
    function = ead(n)
end function

public function stdnead stdcall alias "stdnead"  (byval n as integer) as zstring pointer export
    function = nead(n)
end function

public function stdsa stdcall alias "stdsa" (byval n as integer,valeur as integer) as integer export
function=sa(n,valeur)
end function

public function stdnsa stdcall alias "stdnsa" (byval n as integer) as zstring pointer export
function=nsa(n)
end function

public function stdrsa stdcall alias "stdrsa" (byval n as integer) as integer export
function = rsa(n)
end function

public function stdsad stdcall alias "stdsad" (byval n as integer , byval valeur as double) as double export
function = sad(n,valeur)
end function

public function stdnsad stdcall alias "stdnsad" (byval n as integer) as zstring pointer export
function = nsad(n)
end function 

public function stdrsad stdcall alias "stdrsad" (byval n as integer) as double export
function=rsad(n)
end function


public function stdeb stdcall alias "stdeb" (byval n as integer) as integer export
function = eb(n)
end function

public function stdneb stdcall alias "stdneb" (byval n as integer) as zstring pointer export
function = neb(n)
end function

public function stdsb stdcall alias "stdsb" (byval n as integer , valeur as integer) as integer export
function = sb(n, valeur)
end function

public function stdnsb stdcall alias "stdnsb" (byval n as integer) as zstring pointer export
function = nsb(n)
end function

public function stdrsb stdcall alias "stdrsb" (byval n as integer) as integer export
function = rsb(n)
end function


public function stddetail stdcall alias "stddetail" ()as zstring pointer export
    function=detail()
end function

public function stdtitre stdcall alias "stdtitre" () as zstring pointer export
    function=titre()
end function



'public function stdcalibration stdcall alias "stdcalibration" (ch as zstring) as zstring pointer export
'dim chloc as zstring pointer
'MessageBox NULL, "ch", "Caption", MB_ICONINFORMATION + MB_SYSTEMMODAL
'function=@chloc
'chloc=@"blabla"
'function=chloc
'end function

public function stdeadouble stdcall alias "stdeadouble" (byval n as double) as double export
function=stdead(cint(n))
end function

public function stdneadouble stdcall alias "stdneadouble" (byval n as double) as zstring pointer export 
function = stdnead(n)
end function

public function stdebdouble stdcall alias "stdebdouble" (byval n as double) as double export

function = stdeb(cint(n))
end function

public function stdnebdouble stdcall alias "stdnebdouble" (byval n as double) as zstring pointer export
function = stdneb(cint(n))
end function

public function stdsadouble stdcall alias "stdsadouble" (byval n as double, v as double) as double export
function = stdsad(cint(n),v)
end function

public function stdnsadouble stdcall alias "stdnsadouble" (byval n as double) as zstring pointer export
function = stdnsad(cint(n))
end function

public function stdsbdouble stdcall alias "stdsbdouble" (byval n as double, v as double) as double export
function = stdsb(cint(n),cint(v))
end function

public function stdnsbdouble stdcall alias "stdnsbdouble" (byval n as double)as  zstring pointer  export 
function = stdnsb(cint(n))
end function



public function stdeadstr stdcall alias "stdeadstr" (byval n as  zstring pointer ) as  zstring pointer  export
dim nloc  as  integer
dim ch as zstring *20
dim chloc as zstring pointer
dim rloc as double
nloc=valint(*n)
rloc=stdead(nloc)
ch=str(rloc)
chloc=@ch
function=chloc
end function

public function stdneadstr stdcall alias "stdneadstr" (byval n as  zstring pointer ) as zstring pointer export 
function = stdnead(valint(*n))
end function

public function stdebstr stdcall alias "stdebstr" (byval n as  zstring pointer ) as  zstring pointer  export
dim chloc as zstring *20
chloc=str(stdeb(valint(*n)))
function = @chloc
end function

public function stdnebstr stdcall alias "stdnebstr" (byval n as  zstring pointer ) as zstring pointer export
function = stdneb(valint(*n))
end function

public function stdsadstr stdcall alias "stdsadstr" (byval n as  zstring pointer , v as  zstring pointer ) as  zstring pointer  export
dim chloc as zstring *20
chloc=str(stdsad(valint(*n),val(*v)))
function = @chloc
end function

public function stdnsadstr stdcall alias "stdnsadstr" (byval n as  zstring pointer ) as zstring pointer export
function = stdnsad(valint(*n))
end function

public function stdsbstr stdcall alias "stdsbstr" (byval n as zstring pointer, v as zstring pointer) as zstring pointer export
dim chloc as zstring *20
chloc = str(stdsb(valint(*n),valint(*v)))
function = @chloc
end function


public function stdnsbstr stdcall alias "stdnsbstr" (byval n as zstring pointer) as  zstring pointer  export 
function = stdnsb(valint(*n))
end function




rem fonctions cdecl


public function cea  cdecl alias "cea" (byval n as integer) as integer export
    function = ea(n)
end function

public function cnea  cdecl alias "cnea"  (byval n as integer) as zstring pointer export
    function = nea(n)
end function

public function cead   cdecl alias "cead" (byval n as integer) as double export
    function = ead(n)
end function

public function cnead  cdecl alias "cnead"  (byval n as integer) as zstring pointer export
    function = nead(n)
end function

public function ceb  cdecl alias "ceb" (byval n as integer) as integer export
function=eb(n)
end function

public function cneb cdecl alias "cneb" (byval n as integer) as zstring pointer export
function=neb(n)
end function

public function csa cdecl alias "csa" (byval n as integer, byval v as integer) as integer export
function=sa(n,v)
end function

public function cnsa cdecl alias "cnsa" (byval n as integer) as zstring pointer export
function = nsa(n)
end function

public function csad cdecl alias "csad" (byval n as integer, byval v as double) as double export
function = sad(n,v)
end function

public function cnsad cdecl alias "cnsad" (byval n as integer) as zstring pointer export
function = nsad(n)
end function

public function csb cdecl alias "csb" (byval n as integer, byval v as integer) as integer export
function = sb(n,v)
end function

public function cnsb cdecl alias "cnsb" (byval n as integer) as zstring pointer export
function = nsb(n)
end function


public function cdetail cdecl alias "cdetail" ()as zstring pointer export
    function=detail()
end function

public function ctitre cdecl alias "ctitre" () as zstring pointer export
    function=titre()
end function


'public function ccalibration cdecl alias "ccalibration" (ch as zstring) as zstring pointer export
'dim chloc as zstring *100
'MessageBox NULL, "ch", "Caption", MB_ICONINFORMATION + MB_SYSTEMMODAL
'function=@chloc
'chloc="blabla"
'function=@chloc
'end function



public function ceadouble cdecl alias "ceadouble" (byval n as double) as double export
function=cead(cint(n))
end function

public function cneadouble cdecl alias "cneadouble" (byval n as double) as zstring pointer export 
function = cnead(n)
end function

public function cebdouble cdecl alias "cebdouble" (byval n as double) as double export
function = ceb(cint(n))
end function

public function cnebdouble cdecl alias "cnebdouble" (byval n as double) as zstring pointer export
function = cneb(cint(n))
end function

public function csadouble cdecl alias "csadouble" (byval n as double, v as double) as double export
function = csad(cint(n),v)
end function

public function cnsadouble cdecl alias "cnsadouble" (byval n as double) as zstring pointer export
function = cnsad(cint(n))
end function

public function csbdouble cdecl alias "csbdouble" (byval n as double, v as double) as double export
function = csb(cint(n),cint(v))
end function


public function cnsbdouble cdecl alias "cnsbdouble" (byval n as double)as  zstring pointer  export 
function = stdnsb(cint(n))
end function



public function ceadstr cdecl alias "ceadstr" (byval n as  zstring pointer ) as  zstring pointer  export
dim nloc as integer 
dim chloc as zstring *30
nloc= valint(*n)
chloc=str(stdead(nloc))
function=@chloc
end function

public function cneadstr cdecl alias "cneadstr" (byval n as  zstring pointer ) as zstring pointer export 
function = stdnead(valint(*n))
end function

public function cebstr cdecl alias "cebstr" (byval n as  zstring pointer ) as  zstring pointer  export
dim chloc as zstring *10
chloc=str(stdeb(valint(*n)))
function = @chloc
end function

public function cnebstr cdecl alias "cnebstr" (byval n as  zstring pointer ) as zstring pointer export
function = stdneb(valint(*n))
end function

public function csadstr cdecl alias "csadstr" (byval n as  zstring pointer , v as  zstring pointer ) as  zstring pointer  export
dim chloc as zstring *30
chloc=str(stdsad(valint(*n),val(*v)))
function = @chloc
end function

public function cnsadstr cdecl alias "cnsadstr" (byval n as  zstring pointer ) as zstring pointer export
function = stdnsad(valint(*n))
end function

public function csbstr cdecl alias "csbstr" (byval n as zstring pointer, v as zstring pointer) as zstring pointer export
dim chloc as zstring *20
chloc=str(stdsb(valint(*n),valint(*v)))
function = @chloc
end function


public function cnsbstr cdecl alias "cnsbstr" (byval n as zstring pointer) as  zstring pointer  export 
dim chloc as zstring *20
chloc=str(stdnsb(valint(*n)))
function = @chloc
end function


 monport="/dev/ttyUSB0"
 open com monport+":38400,E,8,1,cs0,cd0,ds0," as #1

