unit Migawka_Prostokat_Tabela_2_SDBM;{15.Kwi.2022, 05.Lip.2023}

  //
  // MIT License
  //
  // Copyright (c) 2022 Jacek Mulawka
  //
  // j.mulawka@interia.pl
  //
  // https://github.com/jacek-mulawka
  //

  // Chyba nie nad��a z obliczeniami za pozosta�ymi rodzajami migawek.

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;


const czerwie�_poziom_najmniejszy_c : integer = 128;
const czerwie�_poziom_najwi�kszy_c : integer = 255;

const rozja�nianie_szybko��_c : integer = 10;
const wygaszaniey_szybko��_c : integer = 2;


type
  TMigawka_Prostokat_Tabela_2_Tryb = ( mpt2_Brak, mpt2_Migaj, mpt2_Mignij, mpt2_Wy��cz, mpt2_Za�wie� );
  T�wiate�ko_Stan = ( �s_Mignij, �s_Nie_�wieci, �s_�wieci, �s_Wy��cz, �s_Za�wie� );

  TMigawka_Prostokat_Tabela_2 = class( TPanel )
  private
    { Private declarations }
    kierunek_w_prawo : boolean; // Diody zapalaj� si� wzgl�dem indeksu tabeli: false - malej�co; true - rosn�co.

    pozycja_�wiec�ca,
    pr�dko��, // 100.
    pr�dko��_licznik
      : integer;

    �wiate�ko_panel__kolor_aktualny_t : array of integer;
    �wiate�ko_panel__stan_t : array of T�wiate�ko_Stan;

    migawka_prostokat_tabela_2_tryb : TMigawka_Prostokat_Tabela_2_Tryb;

    zegar_Timer : TTimer;

    �wiate�ko_panel_t : array of TPanel;

    procedure ZegarTimerTimer( Sender: TObject );
  public
    { Public declarations }
    constructor Create( rodzic_f : TWinControl );
    destructor Destroy(); override;

    procedure Kierunek_Losuj();
    procedure Predko��_Ustaw( pr�dko��_f : integer );
    procedure Szeroko��_Koryguj();
    procedure Tryb_Ustaw( migawka_prostokat_tabela_2_tryb_f : TMigawka_Prostokat_Tabela_2_Tryb );
  end;

implementation

uses
  System.Math;

//Konstruktor klasy TMigawka_Prostokat_Tabela_2.
constructor TMigawka_Prostokat_Tabela_2.Create( rodzic_f : TWinControl );
var
  i,
  elementy_ilo��_l
    : integer;
begin

  //migawka_prostok�t_tabela := TMigawka_Prostokat_Tabela_2.Create( Form1, 10, 20, 10, 50 ); // Przyk�ad.

  inherited Create( Application );

  Self.Parent := rodzic_f;
  Self.Align := alBottom;
  Self.Height := 10;
  Self.Visible := false;

  elementy_ilo��_l := Floor(   Self.Width / (  ( Self.Height - 2 ) * 3  )   );

  Self.migawka_prostokat_tabela_2_tryb := mpt2_Brak;

  SetLength( Self.�wiate�ko_panel__kolor_aktualny_t, elementy_ilo��_l );
  SetLength( Self.�wiate�ko_panel__stan_t, elementy_ilo��_l );

  // Dodawanie elementu.
  for i := 0 to elementy_ilo��_l - 1 do
    begin

      SetLength( Self.�wiate�ko_panel_t, i + 1 );
      Self.�wiate�ko_panel_t[ i ] := TPanel.Create( Application );
      Self.�wiate�ko_panel_t[ i ].Parent := Self;
      Self.�wiate�ko_panel_t[ i ].Align := alLeft;
      Self.�wiate�ko_panel_t[ i ].Width := Self.�wiate�ko_panel_t[ i ].Height * 3;
      Self.�wiate�ko_panel_t[ i ].Caption := '';
      Self.�wiate�ko_panel_t[ i ].Color := czerwie�_poziom_najmniejszy_c;
      Self.�wiate�ko_panel_t[ i ].ParentBackground := false;

      Self.�wiate�ko_panel__kolor_aktualny_t[ i ] := czerwie�_poziom_najmniejszy_c;
      Self.�wiate�ko_panel__stan_t[ i ] := �s_Wy��cz;

    end;
  //---//for i := 0 to elementy_ilo��_l - 1 do


  Randomize();
  Self.Kierunek_Losuj();


  Self.zegar_Timer := TTimer.Create( Application );
  Self.zegar_Timer.Enabled := false;
  Self.zegar_Timer.Interval := 10;
  Self.zegar_Timer.OnTimer := ZegarTimerTimer;

  Self.Predko��_Ustaw( 50 );


  //Self.Visible := true;


  //if Length( Self.�wiate�ko_panel_t ) > 0 then
  //  Self.zegar_Timer.Enabled := true
  //else//if Length( Self.�wiate�ko_panel_t ) > 0 then
  //  Self.zegar_Timer.Enabled := false;

end;//---//Konstruktor klasy TMigawka_Prostokat_Tabela_2.

//Destruktor klasy TMigawka_Prostokat_Tabela_2.
destructor TMigawka_Prostokat_Tabela_2.Destroy();
var
  i : integer;
begin

  SetLength( Self.�wiate�ko_panel__kolor_aktualny_t, 0 );
  SetLength( Self.�wiate�ko_panel__stan_t, 0 );

  // Zwalnianie elementu.
  for i := 0 to Length( Self.�wiate�ko_panel_t ) - 1 do
    begin

      Self.�wiate�ko_panel_t[ i ].Free();
      Self.�wiate�ko_panel_t[ i ] := nil;

    end;
  //---//for i := 0 to Length( Self.�wiate�ko_panel_t ) - 1 do

  SetLength( Self.�wiate�ko_panel_t, 0 );

  Self.zegar_Timer.Free();


  inherited;

end;//---//Destruktor klasy TMigawka_Prostokat_Tabela_2.

//ZegarTimerTimer().
procedure TMigawka_Prostokat_Tabela_2.ZegarTimerTimer( Sender: TObject );
var
  i : integer;
begin

  Self.zegar_Timer.Enabled := false;


  if Self.migawka_prostokat_tabela_2_tryb = mpt2_Migaj then
    begin

      {$region 'mpt2_Migaj.'}
      Self.pr�dko��_licznik := Self.pr�dko��_licznik + Self.zegar_Timer.Interval;

      if Self.pr�dko��_licznik >= Self.pr�dko�� then
        begin

          Self.pr�dko��_licznik := 0;


          Self.�wiate�ko_panel__stan_t[ Self.pozycja_�wiec�ca ] := �s_Mignij;


          if Self.kierunek_w_prawo then
            begin

              if Self.pozycja_�wiec�ca >= Length( Self.�wiate�ko_panel_t ) - 1 then
                begin

                  // Zmiana kierunku.

                  Self.kierunek_w_prawo := false;

                  dec( Self.pozycja_�wiec�ca ); // Skrajny element ju� si� �wieci i nie jest po raz kolejny roz�wietlany.

                end
              else//if Self.pozycja_�wiec�ca >= Length( Self.�wiate�ko_panel_t ) - 1 then
                inc( Self.pozycja_�wiec�ca );

            end
          else//if Self.kierunek_w_prawo then
            begin

              if Self.pozycja_�wiec�ca <= 0 then
                begin

                  // Zmiana kierunku.

                  Self.kierunek_w_prawo := true;

                  inc( Self.pozycja_�wiec�ca ); // Skrajny element ju� si� �wieci i nie jest po raz kolejny roz�wietlany.

                end
              else//if Self.pozycja_�wiec�ca <= 0 then
                dec( Self.pozycja_�wiec�ca );

            end;
          //---//if Self.kierunek_w_prawo then

        end;
      //---//if Self.pr�dko��_licznik >= Self.pr�dko�� then
      {$endregion 'mpt2_Migaj.'}

    end
  else//if Self.migawka_prostokat_tabela_2_tryb = mpt2_Migaj then
  if Self.migawka_prostokat_tabela_2_tryb in [ mpt2_Mignij, mpt2_Wy��cz, mpt2_Za�wie� ] then
    begin

      for i := 0 to Length( Self.�wiate�ko_panel__stan_t ) - 1 do
        case Self.migawka_prostokat_tabela_2_tryb of
            mpt2_Mignij : Self.�wiate�ko_panel__stan_t[ i ] := �s_Mignij;
            mpt2_Wy��cz : Self.�wiate�ko_panel__stan_t[ i ] := �s_Wy��cz;
            mpt2_Za�wie� : Self.�wiate�ko_panel__stan_t[ i ] := �s_Za�wie�;
          end;
        //---//case Self.migawka_prostokat_tabela_2_tryb of


      if Self.migawka_prostokat_tabela_2_tryb = mpt2_Mignij then
        Self.migawka_prostokat_tabela_2_tryb := mpt2_Brak;

    end;
  //---//if Self.migawka_prostokat_tabela_2_tryb in [ mpt2_Mignij, mpt2_Wy��cz, mpt2_Za�wie� ] then


  for i := 0 to Length( Self.�wiate�ko_panel_t ) - 1 do
    begin

      if Self.�wiate�ko_panel__stan_t[ i ] in [ �s_Mignij, �s_Za�wie� ] then
        begin

          if Self.�wiate�ko_panel__kolor_aktualny_t[ i ] < czerwie�_poziom_najwi�kszy_c then
            Self.�wiate�ko_panel__kolor_aktualny_t[ i ] := Self.�wiate�ko_panel__kolor_aktualny_t[ i ] + rozja�nianie_szybko��_c;

          if Self.�wiate�ko_panel__kolor_aktualny_t[ i ] > czerwie�_poziom_najwi�kszy_c then
            Self.�wiate�ko_panel__kolor_aktualny_t[ i ] := czerwie�_poziom_najwi�kszy_c;

          if Self.�wiate�ko_panel__kolor_aktualny_t[ i ] = czerwie�_poziom_najwi�kszy_c then
            begin

              if Self.�wiate�ko_panel__stan_t[ i ] = �s_Mignij then
                Self.�wiate�ko_panel__stan_t[ i ] := �s_Wy��cz
              else//if Self.�wiate�ko_panel__stan_t[ i ] = �s_Mignij then
              if Self.�wiate�ko_panel__stan_t[ i ] = �s_Za�wie� then
                Self.�wiate�ko_panel__stan_t[ i ] := �s_�wieci;

            end;
          //---//if Self.�wiate�ko_panel__kolor_aktualny_t[ i ] = czerwie�_poziom_najwi�kszy_c then

        end
      else//if Self.�wiate�ko_panel__stan_t[ i ] in [ �s_Mignij, �s_Za�wie� ] then
      if Self.�wiate�ko_panel__stan_t[ i ] = �s_Wy��cz then
        begin

          if Self.�wiate�ko_panel__kolor_aktualny_t[ i ] > czerwie�_poziom_najmniejszy_c then
            Self.�wiate�ko_panel__kolor_aktualny_t[ i ] := Self.�wiate�ko_panel__kolor_aktualny_t[ i ] - wygaszaniey_szybko��_c;

          if Self.�wiate�ko_panel__kolor_aktualny_t[ i ] < czerwie�_poziom_najmniejszy_c then
            Self.�wiate�ko_panel__kolor_aktualny_t[ i ] := czerwie�_poziom_najmniejszy_c;

          if Self.�wiate�ko_panel__kolor_aktualny_t[ i ] = czerwie�_poziom_najmniejszy_c then
            Self.�wiate�ko_panel__stan_t[ i ] := �s_Nie_�wieci;

        end;
      //---//if Self.�wiate�ko_panel__stan_t[ i ] = �s_Wy��cz then


      Self.�wiate�ko_panel_t[ i ].Color := Self.�wiate�ko_panel__kolor_aktualny_t[ i ];

    end;
  //---//for i := 0 to Length( Self.�wiate�ko_panel_t ) - 1 do


  if Self.migawka_prostokat_tabela_2_tryb <> mpt2_Brak then
    Self.zegar_Timer.Enabled := true
  else//if Self.migawka_prostokat_tabela_2_tryb <> mpt2_Brak then
    for i := 0 to Length( Self.�wiate�ko_panel_t ) - 1 do
      if Self.�wiate�ko_panel__stan_t[ i ] <> �s_Nie_�wieci then
        begin

          Self.zegar_Timer.Enabled := true;
          Break;

        end;
      //---//if Self.�wiate�ko_panel__stan_t[ i ] <> �s_Nie_�wieci then


  if not Self.zegar_Timer.Enabled then
    Self.Visible := false;

end;//---//ZegarTimerTimer().

//Kierunek_Losuj().
procedure TMigawka_Prostokat_Tabela_2.Kierunek_Losuj();
begin

  Self.kierunek_w_prawo := Random( 2 ) = 1;
  Self.pr�dko��_licznik := 0;

  if Self.kierunek_w_prawo then
    Self.pozycja_�wiec�ca := 0
  else//if Self.kierunek_w_prawo then
    Self.pozycja_�wiec�ca := Length( Self.�wiate�ko_panel_t ) - 1;

end;//---//Kierunek_Losuj().

//Predko��_Ustaw().
procedure TMigawka_Prostokat_Tabela_2.Predko��_Ustaw( pr�dko��_f : integer );
begin

  if pr�dko��_f < Self.zegar_Timer.Interval then
    pr�dko��_f := Self.zegar_Timer.Interval;

  Self.pr�dko�� := pr�dko��_f;

end;//---//Predko��_Ustaw().

//Szeroko��_Koryguj().
procedure TMigawka_Prostokat_Tabela_2.Szeroko��_Koryguj();
var
  widoczno��_kopia_l : boolean;
  i,
  szeroko��_l
    : integer;
begin

  if Length( Self.�wiate�ko_panel_t ) <= 0 then
    Exit;


  widoczno��_kopia_l := Self.Visible;


  // Aby (od�wie�y�) odczyta� aktualn� warto�� szeroko�ci.
  Self.Visible := false;
  Self.Visible := true;
  Self.Visible := false;
  //---// Aby (od�wie�y�) odczyta� aktualn� warto�� szeroko�ci.


  //if Self.Visible then
  //  Self.Visible := false;


  szeroko��_l := Floor(  Self.Width / Length( Self.�wiate�ko_panel_t )  );

  for i := 0 to Length( Self.�wiate�ko_panel_t ) - 1 do
    begin

      Self.�wiate�ko_panel_t[ i ].Width := szeroko��_l;

    end;
  //---//for i := 0 to Length( Self.�wiate�ko_panel_t ) - 1 do


  if widoczno��_kopia_l then
    Self.Visible := true;

end;//---//Szeroko��_Koryguj().

//Tryb_Ustaw().
procedure TMigawka_Prostokat_Tabela_2.Tryb_Ustaw( migawka_prostokat_tabela_2_tryb_f : TMigawka_Prostokat_Tabela_2_Tryb );
begin

  if    ( migawka_prostokat_tabela_2_tryb_f <> mpt2_Mignij )
    and ( Self.migawka_prostokat_tabela_2_tryb = migawka_prostokat_tabela_2_tryb_f ) then
    Exit;


  if    ( migawka_prostokat_tabela_2_tryb_f = mpt2_Migaj )
    and ( Self.migawka_prostokat_tabela_2_tryb <> mpt2_Migaj ) then
    Self.Kierunek_Losuj();


  Self.migawka_prostokat_tabela_2_tryb := migawka_prostokat_tabela_2_tryb_f;

  Self.Visible := true;

  Self.ZegarTimerTimer( nil );

end;//---//Tryb_Ustaw().

end.
