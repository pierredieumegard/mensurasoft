unit Wutil;

interface
uses QDialogs;
(*Uses
  windos,Winprocs; *)
type str20=string[20];
     str80=string[80];
procedure messagechaine(ch:string);

function itos(n:longint):str20;
function btos(b:boolean):str20;
function rtos(x:double ; prec:word):str20;
function rtoscourt(x:double;prec:word):str20;
function InPort(PortAddr: word): byte;
procedure OutPort(PortAddr: word; Databyte: byte);

implementation
procedure messagechaine(ch:string);
 begin messagedlg(ch,mtconfirmation,[mbyes],0);end;

 function itos(n:longint):str20;
var chaux:str20;
begin
str(n,chaux);
itos:=chaux;
end;
function btos(b:boolean):str20;
begin if b then btos:='vrai' else btos:='false';end;

function rtos(x:double ; prec:word):str20;
var s:str20;
begin
  str(x:10:prec,s);
  rtos:=s;
end;
function rtoscourt(x:double;prec:word):str20;
var s:str20;

begin
  str(x:20:10,s);
  while s[1]=' ' do s:=copy(s,2,length(s)-1);
  rtoscourt:=copy(s,1,prec+1);
end;

function InPort(PortAddr: word): byte;
assembler;
asm
        mov dx,PortAddr
        in al,dx
end;

procedure OutPort(PortAddr: word; Databyte: byte);
assembler; 
asm
   mov al,Databyte
   mov dx,PortAddr
   out dx,al
end;


end.
