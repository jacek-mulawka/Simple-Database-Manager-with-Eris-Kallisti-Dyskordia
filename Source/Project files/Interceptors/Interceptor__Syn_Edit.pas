unit Interceptor__Syn_Edit;{16.Lut.2024}

interface

uses
  System.Classes,
  System.SysUtils,
  Vcl.Dialogs,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.GraphUtil,

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
    procedure Lines_Color__Add__All_Colors( const line_number_f : integer );
    procedure Lines_Color__Change( const line_number_f : integer );
    function Lines_Color__Check( const line_number_f : integer ) : boolean; overload;
    function Lines_Color__Check( const line_number_f : integer; var color_f : Vcl.Graphics.TColor ) : boolean; overload;
    procedure Lines_Color__Choose( const line_number_f : integer );
    procedure Lines_Color__Clear( const line_number_f : integer );
    procedure Lines_Color__Clear__All();
    procedure Lines_Color__Update__Line_Numbers();
  end;

  TSynEditMark__Extended = class( TSynEditMark )
  private
    line_number__old : integer;
  end;

const
  highlights__color__default_c : Vcl.Graphics.TColor = $00FFC7C7; // Violet.
  lines_color__mark__tag : integer = -99;

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

  zt_syn_edit_mark : TSynEditMark__Extended;
begin

  for i := 0 to Length( Self.lines_color__number_t ) - 1 do
    if Self.lines_color__number_t[ i ] = line_number_f then
      Exit;


  i := Length( Self.lines_color__number_t );

  SetLength( Self.lines_color__color_t, i + 1 );
  SetLength( Self.lines_color__number_t, i + 1 );

  Self.lines_color__color_t[ i ] := highlights__color__default_c;
  Self.lines_color__number_t[ i ] := line_number_f;


  zt_syn_edit_mark := TSynEditMark__Extended.Create( Self );
  zt_syn_edit_mark.Line := line_number_f;
  zt_syn_edit_mark.line_number__old := zt_syn_edit_mark.Line;
  zt_syn_edit_mark.Tag := lines_color__mark__tag;
  zt_syn_edit_mark.Visible := false;

  Self.Marks.Add( zt_syn_edit_mark );

end;

procedure TSynEdit.Lines_Color__Add__All_Colors( const line_number_f : integer );
var
  ztb : boolean;

  i,
  j,
  zti,
  colors__count_l, // 14.
  color__first__index_l
    : integer;

  zt_color,
  color__current_l,
  color__first_l
    : Vcl.Graphics.TColor;
begin

  ztb := Self.Lines_Color__Check( line_number_f, color__first_l );

  if not ztb then
    Self.Lines_Color__Add( line_number_f );


  color__first__index_l := -1;


  Self.Lines_Color__Check( line_number_f, color__first_l );

  Self.Lines_Color__Clear( line_number_f );

  Self.Lines_Color__Add( line_number_f );


  // Counts the number of predefined colors.
  colors__count_l := 1;

  Self.Lines_Color__Change( line_number_f );

  Self.Lines_Color__Check( line_number_f, zt_color );

  Self.Lines_Color__Check( line_number_f, color__current_l );

  if color__first_l = color__current_l then
    color__first__index_l := 1;

  zti := 0;

  while ( zti = 0 )
     or ( zt_color <> color__current_l ) do
    begin

      inc( zti );

      Self.Lines_Color__Change( line_number_f );

      Self.Lines_Color__Check( line_number_f, color__current_l );


      if    ( color__first__index_l = -1 )
        and ( color__first_l = color__current_l ) then
        color__first__index_l := zti + 1;


      if zt_color = color__current_l then
        Break
      else
        inc( colors__count_l );


      if zti > 500 then // Security interruption.
        Break;

    end;
  //---// Counts the number of predefined colors.


  for i := 0 to Length( Self.lines_color__number_t ) - 1 do
    if Self.lines_color__number_t[ i ] = line_number_f then
      begin

        Self.lines_color__color_t[ i ] := color__first_l; // Restores the original color.

        Break;

      end;


  if color__first__index_l < 1 then
    j := 0
  else
    j := 1;

  zti := 0;


  for i := line_number_f + 1 to line_number_f + colors__count_l - j do
    begin

      inc( zti );


      if Self.Lines_Color__Check( i ) then
        Self.Lines_Color__Clear( i );

      Self.Lines_Color__Add( i );


      if color__first__index_l < 1 then
        begin

          for j := 2 to zti do
            Self.Lines_Color__Change( i );

        end
      else
        begin

          for j := 1 to color__first__index_l + zti do
            Self.Lines_Color__Change( i );

        end;

    end;

end;

procedure TSynEdit.Lines_Color__Change( const line_number_f : integer );

  function Color__Lightness__Change( const color_f : TColor; const percent_f : Single ) : TColor;
  var
    hue_l,
    lightness_l,
    saturation_l
     : word;
  begin

    Result := color_f;

    Vcl.GraphUtil.ColorRGBToHLS(  Vcl.Graphics.ColorToRGB( color_f ), hue_l, lightness_l, saturation_l  );

    lightness_l := Round( lightness_l * percent_f * 0.01 );

    if lightness_l > 240 then // 240 = Vcl.GraphUtil.HLSMAX
      lightness_l := 240
    else
    if lightness_l < 0 then
      lightness_l := 0;

    Result := ColorHLSToRGB( hue_l, lightness_l, saturation_l );

  end;

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
          Self.lines_color__color_t[ i ] := Color__Lightness__Change( Vcl.Graphics.clHighlight, 200 )
        else
        if Self.lines_color__color_t[ i ] = Color__Lightness__Change( Vcl.Graphics.clHighlight, 200 ) then
          Self.lines_color__color_t[ i ] := Color__Lightness__Change( Vcl.Graphics.clHotLight, 200 )
        else
        if Self.lines_color__color_t[ i ] = Color__Lightness__Change( Vcl.Graphics.clHotLight, 200 ) then
          Self.lines_color__color_t[ i ] := Color__Lightness__Change( Vcl.Graphics.clBackground, 200 )
        else
        if Self.lines_color__color_t[ i ] = Color__Lightness__Change( Vcl.Graphics.clBackground, 200 ) then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clMoneyGreen
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clMoneyGreen then
          Self.lines_color__color_t[ i ] := Color__Lightness__Change( Vcl.Graphics.clTeal, 350 )
        else
          if Self.lines_color__color_t[ i ] = Color__Lightness__Change( Vcl.Graphics.clTeal, 350 ) then
          Self.lines_color__color_t[ i ] := Color__Lightness__Change( Vcl.Graphics.clOlive, 330 )
        else
        if Self.lines_color__color_t[ i ] = Color__Lightness__Change( Vcl.Graphics.clOlive, 330 ) then
          Self.lines_color__color_t[ i ] := Color__Lightness__Change( Vcl.Graphics.clGreen, 370 )
        else
        if Self.lines_color__color_t[ i ] = Color__Lightness__Change( Vcl.Graphics.clGreen, 370 ) then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clActiveCaption
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clActiveCaption then
          Self.lines_color__color_t[ i ] := Vcl.Graphics.clSilver
        else
        if Self.lines_color__color_t[ i ] = Vcl.Graphics.clSilver then
          Self.lines_color__color_t[ i ] := Color__Lightness__Change( Vcl.Graphics.clGray, 160 )
        else
        if Self.lines_color__color_t[ i ] = Color__Lightness__Change( Vcl.Graphics.clGray, 160 ) then
          Self.lines_color__color_t[ i ] := Color__Lightness__Change( Vcl.Graphics.clFuchsia, 180 )
        else
        if Self.lines_color__color_t[ i ] = Color__Lightness__Change( Vcl.Graphics.clFuchsia, 180 ) then
          Self.lines_color__color_t[ i ] := Color__Lightness__Change( Vcl.Graphics.clPurple, 330 )
        else
        if Self.lines_color__color_t[ i ] = Color__Lightness__Change( Vcl.Graphics.clPurple, 330 ) then
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


      for i := Self.Marks.Count - 1 downto 0 do
        if    ( Self.Marks.Items[ i ] is TSynEditMark__Extended )
          and ( Self.Marks.Items[ i ].Tag = lines_color__mark__tag )
          and (
                   ( Self.Marks.Items[ i ].Line = line_number_f )
                or (  Self.Marks.Count > Length( Self.lines_color__number_t )  )
              ) then
          Self.Marks.Delete( i );

    end;

end;

procedure TSynEdit.Lines_Color__Clear__All();
var
  i : integer;
begin

  SetLength( Self.lines_color__color_t, 0 );
  SetLength( Self.lines_color__number_t, 0 );


  for i := Self.Marks.Count - 1 downto 0 do
    if    ( Self.Marks.Items[ i ] is TSynEditMark__Extended )
      and ( Self.Marks.Items[ i ].Tag = lines_color__mark__tag ) then
      Self.Marks.Delete( i );

end;

procedure TSynEdit.Lines_Color__Update__Line_Numbers();
var
  i,
  j
    : integer;
begin

  for i := Length( Self.lines_color__number_t ) - 1 downto 0 do
    if Self.lines_color__number_t[ i ] > Self.Lines.Count then
      Self.Lines_Color__Clear( Self.lines_color__number_t [ i ] );


  for i := 0 to Self.Marks.Count - 1 do
    begin

        if    ( Self.Marks.Items[ i ] is TSynEditMark__Extended )
          and ( Self.Marks.Items[ i ].Tag = lines_color__mark__tag ) then
          begin

            for j := 0 to Length( Self.lines_color__number_t ) - 1 do
              if    ( lines_color__number_t[ j ] = TSynEditMark__Extended(Self.Marks.Items[ i ]).line_number__old )
                and ( lines_color__number_t[ j ] <> Self.Marks.Items[ i ].Line )
                and ( Self.Marks.Items[ i ].Line > 0 ) then
                begin

                  lines_color__number_t[ j ] := Self.Marks.Items[ i ].Line;

                  Break;

                end;


            TSynEditMark__Extended(Self.Marks.Items[ i ]).line_number__old := Self.Marks.Items[ i ].Line;

          end;

    end;

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

