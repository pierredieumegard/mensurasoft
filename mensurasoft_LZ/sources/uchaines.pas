//unité uchaines.pas : partie du logiciel Mensurasoft_lz
//déclaration des chaînes de caractères pour les dialogues
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


unit uchaines;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils,ucommun,dialogs;

  const
  ch_bbok:string='OK';
  ch_bbhelp:string='Aide';
  ch_bbabort:string='Abandonner';
  ch_html:string='HTML';

ch_titreG:string='Mensurasoft-LZ';
ch_menufichier:string='Fichiers';
ch_mf_ouvrir:string='Ouvrir';
ch_mf_quitter:string='Quitter';
ch_menureglages:string='Réglages';
ch_mr_temps:string='Régl. temps';
ch_mr_cadrages:string='Cadrages';
ch_mr_matprinc:string='Matériel principal';
ch_mr_mataux:string='Matériel auxiliaire';
ch_mr_matsup:string='Matériel supplémentaire';
ch_mr_savariable:string='Sortie analogique variable';
ch_mr_safixe:string='Sortie analogique fixe';
ch_mr_sbin:string='Sortie binaire';
ch_menumesures:string='Mesures';
ch_mm_acquisition:string='Fait mesures !';
ch_ma_aide:string='Aide' ;
ch_ma_langue:string='Choix de la langue';
ch_ma_apropos:string='A propos de Mensurasoft-LZ';
ch_ma_sauveconfig:string='sauve config.';
ch_ma_chargeconfig:string='charge config.dd';

// chaînes pour la fenêtre graphique du repère
ch_mrep_fichiers:string='Fichiers';
ch_mrep_regcsv:string='Sauver CSV (.,)';
ch_mrep_regpvv:string='Sauver     (,;)';
ch_mrep_regtabpoint:string='Sauver (.TAB)';
ch_mrep_regtabvirg:string='Sauver (,TAB)';
ch_mrep_regcsvsanstitres:string='Sauver CSV sans titres';
ch_mrep_enjoliver:string='Enjoliver'    ;
ch_mrep_titregen:string='Titre général';
ch_mrep_titreaxex:string='Titre axe x';
ch_mrep_titreaxep:string='titre axe p';
ch_mrep_titreaxea:string='titre axe a';
ch_mrep_clipboard:string='Presse-papier';
ch_mrep_copietabpoint:string='Copier nombres (.TAB)';
ch_mrep_copietabvirg:string='Copier nombres (,TAB)';
ch_mrep_copietitretabpoint:string='Copier tout (.TAB)';
ch_mrep_copietitretabvirg:string='Copier tout (,TAB)';
ch_mrep_copiegraphique:string='Copier graphique';
ch_mrep_mesures:string='Mesures';
ch_mrep_stop:string='Stop !';

// chaînes pour le dialogue temporel
ch_fdialtemps:string='réglages du temps';
ch_dt_intervallemesures:string='intervalle entre mesures (s)';
ch_dt_nombremesures:string='nombre de mesures par série';
ch_dt_intervallebandeau:string='délai d''affichage pour bandeau (s)';

//chaînes pour le dialogue matériel de mesure
ch_fdialmatp:string='Matériel principal';
ch_fdialmata:string='Matériel auxiliaire';
ch_fdialmats:string='Matériel supplémentaire';
ch_lcm_detailpilote:string='(pilote indisponible)';
ch_dm_choixvoie:string='Choix de la voie de mesure';
ch_dm_boutonpilote:string='Choix du pilote';
ch_dm_boutoncalibration:string='Calibration ?';
ch_dm_fonctransf:string='Fonction de transformation = f(xp,xa,xs)';
// chaînes pour le dialogue des sorties analogiques fixes
ch_fsaf:string='Sorties analogiques fixes';
ch_saf_detailsaf:string='Pas de pilote chargé';
ch_saf_nomsad0:string='(sad0)';
ch_saf_nomsad1:string='(sad1)';
ch_saf_nomsad2:string='(sad2)';
ch_saf_nomsad3:string='(sad3)';
ch_saf_choixpilotesaf:string='Choix du pilote SAF';

// chaînes pour le dialogue des sorties binaires
ch_fdialsbin:string='Sorties binaires';
ch_fbin_labeldetailpilotesbin:string='(Pilote sorties binaires indisponible)';
ch_fbin_labelchoixvoies:string='Cochez les sorties à activer';
ch_fbin_boutonpilotesbin:string='Choix du pilote sorties binaires';
ch_fbin_cb_sbin0:string='(sortie binaire 0)';
ch_fbin_cb_sbin1:string='(sortie binaire 1)';
ch_fbin_cb_sbin2:string='(sortie binaire 2)';
ch_fbin_cb_sbin3:string='(sortie binaire 3)';
ch_fbin_cb_sbin4:string='(sortie binaire 4)';
ch_fbin_cb_sbin5:string='(sortie binaire 5)';
ch_fbin_cb_sbin6:string='(sortie binaire 6)';
ch_fbin_cb_sbin7:string='(sortie binaire 7)';

// chaînes pour le dialogue de la sortie analogique variable
ch_fsav:string='Sortie analogique variable';
ch_lsav_detailpilotesav:string='(pilote SAV non chargé)';
ch_lsav_listesad:string='choisissez la voie';
ch_bsav_choixpilotesav:string='Choix du pilote SAV';
ch_lsav_fonctransav:string='Fonction de transformation f(xP,xA,xS,xT)';
ch_cbsav_priseencompte:string='Prise en compte ?';



procedure chargelangue(nf:string);

implementation
procedure chargelangue(nf:string);
var f:textfile;
var chainelue:string;
begin
assignfile(f,nf);
reset(f);
while not eof(f) do
    begin
    readln(f,chainelue);
    if debutdechaine(chainelue,'=')='html'
       then ch_html:=findechaine(chainelue,'=');
    if debutdechaine(chainelue,'=')='bbok'
       then ch_bbok:=findechaine(chainelue,'=');
    if debutdechaine(chainelue,'=')='bbhelp'
       then ch_bbhelp:=findechaine(chainelue,'=');
    if debutdechaine(chainelue,'=')='bbabort'
       then ch_bbabort:=findechaine(chainelue,'=');

    if debutdechaine(chainelue,'=')='menufichier'
       then ch_menufichier:=findechaine(chainelue,'=');
   if debutdechaine(chainelue,'=')='mf_ouvrir'
       then ch_mf_ouvrir:=findechaine(chainelue,'=');
    if debutdechaine(chainelue,'=')='mf_quitter'
       then ch_mf_quitter:=findechaine(chainelue,'=');
   if debutdechaine(chainelue,'=') ='menureglages'
       then ch_menureglages:=findechaine(chainelue,'=');
     if debutdechaine(chainelue,'=') ='mr_temps'
       then ch_mr_temps:=findechaine(chainelue,'=');
      if debutdechaine(chainelue,'=') ='mr_cadrages'
       then ch_mr_cadrages:=findechaine(chainelue,'=');
      if debutdechaine(chainelue,'=') ='mr_matprinc'
       then ch_mr_matprinc:=findechaine(chainelue,'=');
       if debutdechaine(chainelue,'=') ='mr_mataux'
       then ch_mr_mataux:=findechaine(chainelue,'=');
       if debutdechaine(chainelue,'=') ='mr_matsup'
       then ch_mr_matsup:=findechaine(chainelue,'=');
      if debutdechaine(chainelue,'=') ='mr_savariable'
       then ch_mr_savariable:=findechaine(chainelue,'=');
      if debutdechaine(chainelue,'=') ='mr_safixe'
       then ch_mr_safixe:=findechaine(chainelue,'=');
      if debutdechaine(chainelue,'=') ='mr_sbin'
       then ch_mr_sbin:=findechaine(chainelue,'=');
       if debutdechaine(chainelue,'=') ='menumesures'
       then ch_menumesures:=findechaine(chainelue,'=');
       if debutdechaine(chainelue,'=') ='mm_acquisition'
       then ch_mm_acquisition:=findechaine(chainelue,'=');
       if debutdechaine(chainelue,'=') ='ma_aide'
       then ch_ma_aide:=findechaine(chainelue,'=');
       if debutdechaine(chainelue,'=') ='ma_langue'
       then ch_ma_langue:=findechaine(chainelue,'=');
       if debutdechaine(chainelue,'=') ='ma_apropos'
       then ch_ma_apropos:=findechaine(chainelue,'=');
       if debutdechaine(chainelue,'=') ='ma_sauveconfig'
       then ch_ma_sauveconfig:=findechaine(chainelue,'=');
       if debutdechaine(chainelue,'=') ='ma_chargeconfig'
       then ch_ma_chargeconfig:=findechaine(chainelue,'=');



       //chaînes du repère cartésien
        if debutdechaine(chainelue,'=') ='mrep_fichiers'
       then ch_mrep_fichiers:=findechaine(chainelue,'=');
        if debutdechaine(chainelue,'=') ='mrep_regcsv'
       then ch_mrep_regcsv:=findechaine(chainelue,'=');
        if debutdechaine(chainelue,'=') ='mrep_regpvv'
       then ch_mrep_regpvv:=findechaine(chainelue,'=');
        if debutdechaine(chainelue,'=') ='mrep_regtabpoint'
       then ch_mrep_regtabpoint:=findechaine(chainelue,'=');
        if debutdechaine(chainelue,'=') ='mrep_regtabvirg'
       then ch_mrep_regtabvirg:=findechaine(chainelue,'=');
               if debutdechaine(chainelue,'=') ='mrep_regcsvsanstitres'
       then ch_mrep_regcsvsanstitres:=findechaine(chainelue,'=');

        if debutdechaine(chainelue,'=') ='mrep_clipboard'
       then ch_mrep_clipboard:=findechaine(chainelue,'=');
        if debutdechaine(chainelue,'=') ='mrep_copietabpoint'
       then ch_mrep_copietabpoint:=findechaine(chainelue,'=');
         if debutdechaine(chainelue,'=') ='mrep_copietabvirg'
       then ch_mrep_copietabvirg:=findechaine(chainelue,'=');
        if debutdechaine(chainelue,'=') ='mrep_copietitretabpoint'
       then ch_mrep_copietitretabpoint:=findechaine(chainelue,'=');
        if debutdechaine(chainelue,'=') ='mrep_copietitretabvirg'
       then ch_mrep_copietitretabvirg:=findechaine(chainelue,'=');
          if debutdechaine(chainelue,'=') ='mrep_copiegraphique'
       then ch_mrep_copiegraphique:=findechaine(chainelue,'=');

        if debutdechaine(chainelue,'=') ='mrep_mesures'
       then ch_mrep_mesures:=findechaine(chainelue,'=');
        if debutdechaine(chainelue,'=') ='mrep_stop'
       then ch_mrep_stop:=findechaine(chainelue,'=');
         if debutdechaine(chainelue,'=') ='mrep_enjoliver'
       then ch_mrep_enjoliver:=findechaine(chainelue,'=');
         if debutdechaine(chainelue,'=') ='mrep_titregen'
       then ch_mrep_titregen:=findechaine(chainelue,'=');
           if debutdechaine(chainelue,'=') ='mrep_titreaxex'
       then ch_mrep_titreaxex:=findechaine(chainelue,'=');
               if debutdechaine(chainelue,'=') ='mrep_titreaxep'
       then ch_mrep_titreaxep:=findechaine(chainelue,'=');
           if debutdechaine(chainelue,'=') ='mrep_titreaxea'
       then ch_mrep_titreaxea:=findechaine(chainelue,'=');


       // dialogue du temps
          if debutdechaine(chainelue,'=') ='fdialtemps'
       then ch_fdialtemps:=findechaine(chainelue,'=');
          if debutdechaine(chainelue,'=') ='dt_intervallemesures'
       then ch_dt_intervallemesures:=findechaine(chainelue,'=');
          if debutdechaine(chainelue,'=') ='dt_nombremesures'
       then ch_dt_nombremesures:=findechaine(chainelue,'=');
          if debutdechaine(chainelue,'=') ='dt_intervallebandeau'
       then ch_dt_intervallebandeau:=findechaine(chainelue,'=');

       //dialogue matériel de mesure
          if debutdechaine(chainelue,'=') ='fdialmatp'
       then ch_fdialmatp:=findechaine(chainelue,'=');
           if debutdechaine(chainelue,'=') ='fdialmata'
       then ch_fdialmata:=findechaine(chainelue,'=');
           if debutdechaine(chainelue,'=') ='fdialmats'
       then ch_fdialmats:=findechaine(chainelue,'=');
            if debutdechaine(chainelue,'=') ='lcm_detailpilote'
       then ch_lcm_detailpilote:=findechaine(chainelue,'=');

           if debutdechaine(chainelue,'=') ='dm_boutonpilote'
       then ch_dm_boutonpilote:=findechaine(chainelue,'=');
           if debutdechaine(chainelue,'=') ='dm_choixvoie'
       then ch_dm_choixvoie:=findechaine(chainelue,'=');
            if debutdechaine(chainelue,'=') ='dm_boutoncalibration'
       then ch_dm_boutoncalibration:=findechaine(chainelue,'=');
            if debutdechaine(chainelue,'=') ='dm_fonctransf'
       then ch_dm_fonctransf:=findechaine(chainelue,'=');

       // dialogue sortie analogique fixe
            if debutdechaine(chainelue,'=') ='fsaf'
       then ch_fsaf:=findechaine(chainelue,'=');
             if debutdechaine(chainelue,'=') ='saf_detailsaf'
       then ch_saf_detailsaf:=findechaine(chainelue,'=');
              if debutdechaine(chainelue,'=') ='saf_nomsad0'
       then ch_saf_nomsad0:=findechaine(chainelue,'=');
             if debutdechaine(chainelue,'=') ='saf_nomsad1'
       then ch_saf_nomsad1:=findechaine(chainelue,'=');
             if debutdechaine(chainelue,'=') ='saf_nomsad2'
       then ch_saf_nomsad2:=findechaine(chainelue,'=');
        if debutdechaine(chainelue,'=') ='saf_nomsad3'
       then ch_saf_nomsad3:=findechaine(chainelue,'=');
             if debutdechaine(chainelue,'=') ='saf_choixpilotesaf'
       then ch_saf_choixpilotesaf:=findechaine(chainelue,'=');

      // dialogue sortie binaire
               if debutdechaine(chainelue,'=') ='fdialsbin'
       then ch_fdialsbin:=findechaine(chainelue,'=');
                 if debutdechaine(chainelue,'=') ='fbin_labeldetailpilotesbin'
       then ch_fbin_labeldetailpilotesbin:=findechaine(chainelue,'=');
                 if debutdechaine(chainelue,'=') ='fbin_labelchoixvoies'
       then ch_fbin_labelchoixvoies:=findechaine(chainelue,'=');
                 if debutdechaine(chainelue,'=') ='fbin_boutonpilotesbin'
       then ch_fbin_boutonpilotesbin:=findechaine(chainelue,'=');
                   if debutdechaine(chainelue,'=') ='fbin_cb_sbin0'
       then ch_fbin_cb_sbin0:=findechaine(chainelue,'=');
                 if debutdechaine(chainelue,'=') ='fbin_cb_sbin1'
       then ch_fbin_cb_sbin1:=findechaine(chainelue,'=');
                 if debutdechaine(chainelue,'=') ='fbin_cb_sbin2'
       then ch_fbin_cb_sbin2:=findechaine(chainelue,'=');
                 if debutdechaine(chainelue,'=') ='fbin_cb_sbin3'
       then ch_fbin_cb_sbin3:=findechaine(chainelue,'=');
                 if debutdechaine(chainelue,'=') ='fbin_cb_sbin4'
       then ch_fbin_cb_sbin4:=findechaine(chainelue,'=');
                 if debutdechaine(chainelue,'=') ='fbin_cb_sbin5'
       then ch_fbin_cb_sbin5:=findechaine(chainelue,'=');
                 if debutdechaine(chainelue,'=') ='fbin_cb_sbin6'
       then ch_fbin_cb_sbin6:=findechaine(chainelue,'=');
                 if debutdechaine(chainelue,'=') ='fbin_cb_sbin7'
       then ch_fbin_cb_sbin7:=findechaine(chainelue,'=');


       //dialogue sortie analogique variable
                  if debutdechaine(chainelue,'=') ='fsav'
       then ch_fsav:=findechaine(chainelue,'=');
                   if debutdechaine(chainelue,'=') ='lsav_detailpilotesav'
       then ch_lsav_detailpilotesav:=findechaine(chainelue,'=');
                   if debutdechaine(chainelue,'=') ='lsav_listesad'
       then ch_lsav_listesad:=findechaine(chainelue,'=');
                   if debutdechaine(chainelue,'=') ='bsav_choixpilotesav'
       then ch_bsav_choixpilotesav:=findechaine(chainelue,'=');
                   if debutdechaine(chainelue,'=') ='lsav_fonctransav'
       then ch_lsav_fonctransav:=findechaine(chainelue,'=');
                    if debutdechaine(chainelue,'=') ='cbsav_priseencompte'
       then ch_cbsav_priseencompte:=findechaine(chainelue,'=');



    end;
//    MessageDlg('Caption','Text',mtInformation,[mbOk,mbCancel],0);
closefile(f);
end;

begin
end.

