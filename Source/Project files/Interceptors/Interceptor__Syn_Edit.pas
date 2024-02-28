unit Interceptor__Syn_Edit;{16.Lut.2024}

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,

  SynEdit;

type
  TSynEdit = class( SynEdit.TSynEdit )
    procedure SynEditSpecialLineColors( Sender: TObject; Line: Integer; var Special: Boolean; var FG, BG: Vcl.Graphics.TColor );
  public
    lines_color__number_t : array of integer;
    lines_color__color_t : array of Vcl.Graphics.TColor;

    constructor Create( AOwner: System.Classes.TComponent ); override;
    destructor Destroy(); override;

    procedure Lines_Color__Add( const line_number_f : integer );
    procedure Lines_Color__Change( const line_number_f : integer );
    function Lines_Color__Check( const line_number_f : integer ) : boolean; overload;
    function Lines_Color__Check( const line_number_f : integer; var color_f : Vcl.Graphics.TColor ) : boolean; overload;
    procedure Lines_Color__Choose( const line_number_f : integer );
    procedure Lines_Color__Clear( const line_number_f : integer );
    procedure Lines_Color__Clear__All();
  end;

const
  highlights__color__default_c : Vcl.Graphics.TColor = $00FFC7C7; // Violet.

implementation

constructor TSynEdit.Create( AOwner: System.Classes.TComponent );
begin

  inherited Create( AOwner );


  Self.Lines_Color__Clear__All();

  Self.OnSpecialLineColors := Self.SynEditSpecialLineColors;

end;

destructor TSynEdit.Destroy();
begin

  Self.Lines_Color__Clear__All();


  inherited;

end;

procedure TSynEdit.Lines_Color__Add( const line_number_f : integer );
var
  i : integer;
begin

  for i := 0 to Length( Self.lines_color__number_t ) - 1 do
    if Self.lines_color__number_t[ i ] = line_number_f then
      Exit;


  i := Length( Self.lines_color__number_t );

  SetLength( Self.lines_color__color_t, i + 1 );
  SetLength( Self.lines_color__number_t, i + 1 );

  Self.lines_color__color_t[ i ] := highlights__color__default_c;
  Self.lines_color__number_t[ i ] := line_number_f;

end;

procedure TSynEdit.Lines_Color__Change( const line_number_f : integer );
var
  i : integer;
begin

  for i := 0 to Length( Self.lines_color__number_t ) - 1 do
    if Self.lines_color__number_t[ i ] = line_number_f then
      begin

        if Self.lines_color__color_t[ i ] = highlights__color__default_c then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clSkyBlue
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clSkyBlue then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clHighlight
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clHighlight then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clHotLight
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clHotLight then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clBackground
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clBackground then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clTeal
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clTeal then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clMoneyGreen
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clMoneyGreen then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clOlive
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clOlive then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clGreen
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clGreen then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clActiveCaption
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clActiveCaption then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clSilver
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clSilver then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clGray
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clGray then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clPurple
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clPurple then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clFuchsia
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clFuchsia then
          Self.lines_color__color_t[ i ] := highlights__color__default_c;


        Exit;

      end;

end;

function TSynEdit.Lines_Color__Check( const line_number_f : integer ) : boolean;
var
  color_l : Vcl.Graphics.TColor;
begin

  Result := Self.Lines_Color__Check( line_number_f, color_l );

end;

function TSynEdit.Lines_Color__Check( const line_number_f : integer; var color_f : Vcl.Graphics.TColor ) : boolean;
var
  i : integer;
begin

  Result := false;


  for i := 0 to Length( Self.lines_color__number_t ) - 1 do
    if Self.lines_color__number_t[ i ] = line_number_f then
      begin

        Result := true;

        color_f := Self.lines_color__color_t[ i ];


        Exit;

      end;

end;

procedure TSynEdit.Lines_Color__Choose( const line_number_f : integer );
var
  ztb : boolean;

  i : integer;

  color_dialog_l : Vcl.Dialogs.TColorDialog;
begin

  color_dialog_l := Vcl.Dialogs.TColorDialog.Create( Vcl.Forms.Application );
  color_dialog_l.Options := color_dialog_l.Options + [ cdFullOpen ];


  if color_dialog_l.Execute() then
    begin

      ztb := false;

      for i := 0 to Length( Self.lines_color__number_t ) - 1 do
        if Self.lines_color__number_t[ i ] = line_number_f then
          begin

            ztb := true;

            Break;

          end;


      if not ztb then
        begin

          Self.Lines_Color__Add( Self.CaretY );

          i := Length( Self.lines_color__number_t ) - 1;

        end;



      Self.lines_color__color_t[ i ] := color_dialog_l.Color;


      Self.Refresh();

    end;


  System.SysUtils.FreeAndNil( color_dialog_l );

end;

procedure TSynEdit.Lines_Color__Clear( const line_number_f : integer );
var
  ztb : boolean;

  i : integer;
begin

  ztb := false;

  for i := 0 to Length( Self.lines_color__number_t ) - 1 do
    if Self.lines_color__number_t[ i ] = line_number_f then
      begin

        ztb := true;

        Break;

      end;


  if ztb then
    begin

      for i := i to Length( Self.lines_color__number_t ) - 2 do
        begin

          Self.lines_color__color_t[ i ] := Self.lines_color__color_t[ i + 1 ];
          Self.lines_color__number_t[ i ] := Self.lines_color__number_t[ i + 1 ];

        end;


      SetLength(  Self.lines_color__color_t, Length( Self.lines_color__color_t ) - 1  );
      SetLength(  Self.lines_color__number_t, Length( Self.lines_color__number_t ) - 1  );

    end;

end;

procedure TSynEdit.Lines_Color__Clear__All();
begin

  SetLength( Self.lines_color__color_t, 0 );
  SetLength( Self.lines_color__number_t, 0 );

end;

procedure TSynEdit.SynEditSpecialLineColors( Sender: TObject; Line: Integer; var Special: Boolean; var FG, BG: Vcl.Graphics.TColor );
var
  color_l : Vcl.Graphics.TColor;
begin

  if Self.Lines_Color__Check( Line, color_l ) then
    begin

      Special := true;

      BG := color_l;

    end;

end;

end.

