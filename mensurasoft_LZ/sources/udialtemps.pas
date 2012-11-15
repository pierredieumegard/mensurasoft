unit udialtemps;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls,
  Graphics, Dialogs,
  StdCtrls, Spin, Buttons, uchaines
  , ucommun;

type

  { Tfdialtemps }

  Tfdialtemps = class(TForm)
    BitBtn1:      TBitBtn;
    BitBtn2:      TBitBtn;
    BitBtn3:      TBitBtn;
    FSE_intervallemesures: TFloatSpinEdit;
    dt_intervallebandeau: TLabel;
    SEnbmesures:  TSpinEdit;
    SE_intervallebandeau: TSpinEdit;
    dt_nbmesures:  TStaticText;
    dt_intervallemesures: TStaticText;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FSE_intervallemesuresChange(Sender: TObject);
    procedure labelintervalleClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  fdialtemps: Tfdialtemps;

implementation

uses umglz;

{ Tfdialtemps }

procedure Tfdialtemps.labelintervalleClick(Sender: TObject);
begin

end;

procedure Tfdialtemps.BitBtn3Click(Sender: TObject);
begin
  Close;
end;

procedure Tfdialtemps.FormCreate(Sender: TObject);
begin
   (*caption:=ch_fdialtemps;
   dt_intervallemesures.caption:=ch_dt_intervallemesures;
   dt_intervallebandeau.caption:=ch_dt_intervallebandeau;
   dt_nbmesures.caption:=ch_dt_nombremesures;*)
end;

procedure Tfdialtemps.FSE_intervallemesuresChange(Sender: TObject);
begin

end;

procedure Tfdialtemps.BitBtn1Click(Sender: TObject);
begin
  intervalle   := FSE_intervallemesures.Value;
  nbmaxmesures := senbmesures.Value;
  intervalle_bandeau := SE_intervallebandeau.Value;

  Close;
end;

initialization
  {$I udialtemps.lrs}

end.

