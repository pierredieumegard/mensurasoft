unit udialsbin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  StdCtrls, Buttons,ucommun,uchaines;

type

  { Tfdialsbin }

  Tfdialsbin = class(TForm)
    fbin_bbhelp: TBitBtn;
    fbin_bbabort: TBitBtn;
    fbin_bbok: TBitBtn;
    fbin_cb_sbin7: TCheckBox;
    fbin_cb_sbin6: TCheckBox;
    fbin_cb_sbin5: TCheckBox;
    fbin_cb_sbin4: TCheckBox;
    fbin_cb_sbin3: TCheckBox;
    fbin_cb_sbin2: TCheckBox;
    fbin_cb_sbin1: TCheckBox;
    fbin_cb_sbin0: TCheckBox;
    fbin_boutonpilotesbin: TButton;
    fbin_labeldetailpilotesbin: TLabel;
    fbin_labelchoixvoies: TLabel;
    od_choixpilsbin: TOpenDialog;
    procedure fbin_bbabortClick(Sender: TObject);
    procedure fbin_bbhelpClick(Sender: TObject);
    procedure fbin_bbokClick(Sender: TObject);
    procedure fbin_boutonpilotesbinClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  fdialsbin: Tfdialsbin;

implementation

{ Tfdialsbin }

procedure Tfdialsbin.fbin_boutonpilotesbinClick(Sender: TObject);
var longintloc:longint;
begin
    od_choixpilsbin.execute;
  if (od_choixpilsbin.filename <>'')
  then begin
         longintloc:=ucommun.chargebibdynsbin(od_choixpilsbin.filename);
         if @stddetailsb<>nil then
          begin
          ouipilotesbin:=true;
          //ch_fbin_labeldetailpilotesbin:=stddetailsb();
          end
          else begin
               ouipilotesbin:=false;
               end;
        end;
        Formpaint(sender);
end;

procedure Tfdialsbin.fbin_bbabortClick(Sender: TObject);
begin
   close;
end;

procedure Tfdialsbin.fbin_bbhelpClick(Sender: TObject);
begin
  aide(ch_html,'mensurasoft_lz_sbin.html');
end;

procedure Tfdialsbin.fbin_bbokClick(Sender: TObject);
begin
  if ouipilotesbin
   then begin
   valsbin0:=fbin_cb_sbin0.Checked;valsbin1:=fbin_cb_sbin1.checked;
   valsbin2:=fbin_cb_sbin2.checked;valsbin3:=fbin_cb_sbin3.checked;
   valsbin4:=fbin_cb_sbin4.checked;valsbin5:=fbin_cb_sbin5.checked;
   valsbin6:=fbin_cb_sbin6.checked;valsbin7:=fbin_cb_sbin7.checked;
   if valsbin0 then stdsb(0,1)else stdsb(0,0);
   if valsbin1 then stdsb(1,1)else stdsb(1,0);
   if valsbin2 then stdsb(2,1)else stdsb(2,0);
   if valsbin3 then stdsb(3,1)else stdsb(3,0);
   if valsbin4 then stdsb(4,1)else stdsb(4,0);
   if valsbin5 then stdsb(5,1)else stdsb(5,0);
   if valsbin6 then stdsb(6,1)else stdsb(6,0);
   if valsbin7 then stdsb(7,1)else stdsb(7,0);
   nompilotesbin:=od_choixpilsbin.filename;
        end;
close
end;

procedure Tfdialsbin.FormPaint(Sender: TObject);
begin
  if ouipilotesbin
     then begin
        fbin_labeldetailpilotesbin.caption:=stddetailsb();
          if length(stdnsb(0))>1 then
             begin
                fbin_cb_sbin0.caption:=stdnsb(0);
                fbin_cb_sbin0.enabled:=true;
                fbin_cb_sbin0.visible:=true;
             end
             else begin
                fbin_cb_sbin0.caption:=ch_fbin_cb_sbin0;
                fbin_cb_sbin0.enabled:=false;
                fbin_cb_sbin0.enabled:=false;

             end;
          if length(stdnsb(1))>1 then
             begin
             fbin_cb_sbin1.caption:=stdnsb(1);
             fbin_cb_sbin1.visible:=true;
             end
             else begin
             fbin_cb_sbin1.caption:=ch_fbin_cb_sbin1;
             fbin_cb_sbin1.visible:=false;
             end;
           if length(stdnsb(2))>1 then
             begin
             fbin_cb_sbin2.caption:=stdnsb(2);
             fbin_cb_sbin2.visible:=true;
             end
             else begin
             fbin_cb_sbin2.caption:=ch_fbin_cb_sbin2;
             fbin_cb_sbin2.visible:=false;
             end;
           if length(stdnsb(3))>1 then
             begin
             fbin_cb_sbin3.caption:=stdnsb(3);
             fbin_cb_sbin3.visible:=true;
             end
             else begin
             fbin_cb_sbin3.caption:=ch_fbin_cb_sbin3;
             fbin_cb_sbin3.visible:=false;
             end;
           if length(stdnsb(4))>1 then
             begin
             fbin_cb_sbin4.caption:=stdnsb(4);
             fbin_cb_sbin4.visible:=true;
             end
             else begin
             fbin_cb_sbin4.caption:=ch_fbin_cb_sbin4;
             fbin_cb_sbin4.visible:=false;
             end;
            if length(stdnsb(5))>1 then
             begin
             fbin_cb_sbin5.caption:=stdnsb(5);
             fbin_cb_sbin5.visible:=true;
             end
             else begin
             fbin_cb_sbin5.caption:=ch_fbin_cb_sbin5;
             fbin_cb_sbin5.visible:=false;
             end;
            if length(stdnsb(6))>1 then
             begin
             fbin_cb_sbin6.caption:=stdnsb(6);
             fbin_cb_sbin6.visible:=true;
             end
             else begin
             fbin_cb_sbin6.caption:=ch_fbin_cb_sbin6;
             fbin_cb_sbin6.visible:=false;
             end;
            if length(stdnsb(7))>1 then
             begin
             fbin_cb_sbin7.caption:=stdnsb(7);
             fbin_cb_sbin7.visible:=true;
             end
             else begin
             fbin_cb_sbin7.caption:=ch_fbin_cb_sbin7;
             fbin_cb_sbin7.visible:=false;
             end;





          end
     else begin  //si pas de pilote sbin


     end;
end;

initialization
  {$I udialsbin.lrs}

end.

