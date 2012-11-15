unit udialsav;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms,
  Controls, Graphics, Dialogs,uchaines,ucommun,
  StdCtrls, Buttons;

type

  { TFSAV }

  TFSAV = class(TForm)
    bbsav_ok: TBitBtn;
    bbsav_help: TBitBtn;
    bbsav_abort: TBitBtn;
    Bsav_choixpilotesav: TButton;
    cbsav_priseencompte: TCheckBox;
    Esav_fonctransav: TEdit;
    lsav_fonctransav: TLabel;
    Lsav_listesad: TLabel;
    lsav_detailpilotesav: TLabel;
    ListBox1: TListBox;
    od_choixpilsav: TOpenDialog;
    procedure bbsav_abortClick(Sender: TObject);
    procedure bbsav_helpClick(Sender: TObject);
    procedure bbsav_okClick(Sender: TObject);
    procedure Bsav_choixpilotesavClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  FSAV: TFSAV;

implementation

{ TFSAV }

procedure TFSAV.bbsav_abortClick(Sender: TObject);
begin
  close;
end;

procedure TFSAV.bbsav_helpClick(Sender: TObject);
begin
  aide(ch_html,'mensurasoft_lz_sav.html');
end;

procedure TFSAV.bbsav_okClick(Sender: TObject);
begin
  ouipecsav:=cbsav_priseencompte.checked;
  numvoiesav:=Listbox1.itemindex;
  chfonctionsav:=Esav_fonctransav.text;
  nompilotesav:=od_choixpilsav.filename
end;

procedure TFSAV.Bsav_choixpilotesavClick(Sender: TObject);
var chloc:string;
ch1,ch2:pchar;
iloc:integer;
longintloc:longint;
begin
  listbox1.items.clear;
  od_choixpilsav.execute;
  if (od_choixpilsav.filename <>'')
  then begin
         longintloc:=ucommun.chargebibdynsav(od_choixpilsav.filename);
         if @stddetailsav<>nil then
          begin
          ouipilotesav:=true;
          lsav_detailpilotesav.caption:=stddetailsav();
          iloc:=0;
          while length(stdnsav(iloc))>1 do
             begin
               listbox1.items.add(stdnsav(iloc));
               iloc:=iloc+1;
             end;
          end
          else ouipilotesav:=false;
    end; //voie principale

end;

initialization
  {$I udialsav.lrs}

end.

