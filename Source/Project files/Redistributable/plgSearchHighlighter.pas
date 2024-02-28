unit plgSearchHighlighter;

interface

uses
  Windows, Classes, Graphics, SynEdit, SynEditTypes, SynEditHighlighter;

type
  TSearchTextHightlighterSynEditPlugin = class(TSynEditPlugin)
  private
    FAttribute: TSynHighlighterAttributes;
  protected
    procedure AfterPaint(ACanvas: TCanvas; const AClip: TRect;
      FirstLine, LastLine: Integer); override;
  public
    procedure AfterConstruction; override;
    destructor Destroy; override;

    property Attribute: TSynHighlighterAttributes read FAttribute write FAttribute;
  end;

  TSearchTextHightlighterSynEditPlugin__Brackets = class( TSynEditPlugin ) // Jacek Mulawka (12.Feb.2023).
  private
    FAttribute: TSynHighlighterAttributes;
  protected
    procedure AfterPaint( ACanvas: TCanvas; const AClip: TRect; FirstLine, LastLine: Integer ); override;
  public
    brackets__all_pairs,
    brackets__angle,
    brackets__curly,
    brackets__marked_only,
    brackets__round,
    brackets__squareg
      : boolean;

    procedure AfterConstruction(); override;
    destructor Destroy; override;

    property Attribute: TSynHighlighterAttributes read FAttribute write FAttribute;
  end;

const
  margin_c: Integer = 2; // Jacek Mulawka (09.Nov.2023).

implementation

{ TEditorFrameSynEditPlugin }

procedure TSearchTextHightlighterSynEditPlugin.AfterConstruction;
begin
  inherited;
  FAttribute := TSynHighlighterAttributes.Create('SearchText', 'Search Text Highlighter');
end;

destructor TSearchTextHightlighterSynEditPlugin.Destroy;
begin
  FAttribute.Free;
  inherited;
end;

procedure TSearchTextHightlighterSynEditPlugin.AfterPaint(ACanvas: TCanvas;
  const AClip: TRect; FirstLine, LastLine: Integer);
var
  SearchText, SearchResultText: string;
  Pt: TPoint;
  Rct: TRect;
  OldFont: TFont;
  LineIndex, Count, ItemIndex: Integer;
  CurrCoord: TBufferCoord;
begin
  inherited;

  if not Assigned(Editor.SearchEngine) then
    Exit;

  SearchText := Editor.SearchEngine.Pattern;
  if SearchText = '' then
    Exit;

  OldFont := TFont.Create;
  try
    OldFont.Assign(ACanvas.Font);

    if Attribute.Background <> clNone then
    begin
      ACanvas.Brush.Color := Attribute.Background;
      ACanvas.Brush.Style := bsSolid
    end
    else
      ACanvas.Brush.Style := bsClear;

    if Attribute.Foreground <> clNone then
    begin
      ACanvas.Pen.Color := Attribute.Foreground;
      ACanvas.Pen.Style := psSolid;
    end
    else
      ACanvas.Pen.Style := psClear;

    for LineIndex := FirstLine to LastLine do
    begin
      Count := Editor.SearchEngine.FindAll(Editor.Lines[LineIndex - 1]);
      for ItemIndex := 0 to Count - 1 do
      begin
        CurrCoord := BufferCoord(Editor.SearchEngine.Results[ItemIndex], LineIndex);
        if CurrCoord = Editor.BlockBegin then
          Continue;

        SearchResultText := Copy(Editor.Lines[LineIndex - 1], Editor.SearchEngine.Results[ItemIndex],
          Editor.SearchEngine.Lengths[ItemIndex]);

        Pt := Editor.RowColumnToPixels(Editor.BufferToDisplayPos(CurrCoord));
        Rct := Rect(Pt.X, Pt.Y, Pt.X + Editor.CharWidth * Length(SearchResultText),
          Pt.Y + Editor.LineHeight);

        ACanvas.FillRect(Rct);
        ACanvas.Rectangle( Rct.Left - margin_c, Rct.Top - margin_c, Rct.Right + margin_c, Rct.Bottom + margin_c ); // Jacek Mulawka (09.Nov.2023).
        ACanvas.Font := Editor.Font; // Jacek Mulawka (09.Nov.2023).
        ACanvas.TextRect(Rct, Pt.X, Pt.Y, SearchResultText);
      end
    end;

    ACanvas.Font.Assign(OldFont);
  finally
    OldFont.Free;
  end;
end;

procedure TSearchTextHightlighterSynEditPlugin__Brackets.AfterConstruction();
begin

  inherited;

  FAttribute := TSynHighlighterAttributes.Create( 'SearchText', 'Search Text Highlighter' );

  Self.brackets__all_pairs := false;
  Self.brackets__angle := false;
  Self.brackets__curly := false;
  Self.brackets__marked_only := false;
  Self.brackets__round := false;
  Self.brackets__squareg := false;

end;

destructor TSearchTextHightlighterSynEditPlugin__Brackets.Destroy;
begin
  FAttribute.Free;
  inherited;
end;

procedure TSearchTextHightlighterSynEditPlugin__Brackets.AfterPaint( ACanvas: TCanvas; const AClip: TRect; FirstLine, LastLine: Integer );

  function Highlight_L( canvas_f : TCanvas; const buffer_coord_f : TBufferCoord ) : boolean;
  var
    zt_point : TPoint;

    zt_rect : TRect;

    zts : string;
  begin

    if    ( buffer_coord_f.Line <> 0 )
      and ( buffer_coord_f.Char <> 0 ) then
      begin

        zts := Editor.Lines[ buffer_coord_f.Line - 1 ][ buffer_coord_f.Char ];

        zt_point := Editor.RowColumnToPixels(  Editor.BufferToDisplayPos( buffer_coord_f )  );

        zt_rect := Rect(  zt_point.X, zt_point.Y, zt_point.X + Editor.CharWidth * Length( zts ), zt_point.Y + Editor.LineHeight  );

        canvas_f.FillRect( zt_rect );
        canvas_f.Rectangle( zt_rect.Left - margin_c, zt_rect.Top - margin_c, zt_rect.Right + margin_c, zt_rect.Bottom + margin_c );
        canvas_f.Font := Editor.Font;
        canvas_f.TextRect( zt_rect, zt_point.X, zt_point.Y, zts );


        Result := true;

      end
    else
      Result := false;

  end;

  function In_View_Check( const brackets_open_counter_f, line_f : integer ) : boolean;
  var
    zt_display_coord : TDisplayCoord;
  begin

    if brackets_open_counter_f = 0 then
      begin

        zt_display_coord.Column := 1;
        zt_display_coord.Row := line_f;

        if Editor.RowColumnInView( zt_display_coord ) then
          Result := true
        else
          Result := false;

      end
    else
      Result := true;

  end;

var
  i,
  zti,
  brackets__angle__open_counter, // < >
  brackets__curly__open_counter, // { }
  brackets__round__open_counter, // ( )
  brackets__square__open_counter // [ ]
    : integer;

  zts : string;

  old_font : TFont;

  zt_buffer_coord_1,
  zt_buffer_coord_2
   : TBufferCoord;
begin

  inherited;

  if not Assigned( Editor.SearchEngine ) then
    Exit;


  if    ( not Self.brackets__angle )
    and ( not Self.brackets__curly )
    and ( not Self.brackets__round )
    and ( not Self.brackets__squareg ) then
    Exit;


  old_font := TFont.Create();

  try
    old_font.Assign( ACanvas.Font );

    if Attribute.Background <> clNone then
      begin

        ACanvas.Brush.Color := Attribute.Background;
        ACanvas.Brush.Style := bsSolid

      end
    else
      ACanvas.Brush.Style := bsClear;

    if Attribute.Foreground <> clNone then
      begin

        ACanvas.Pen.Color := Attribute.Foreground;
        ACanvas.Pen.Style := psSolid;

      end
    else
      ACanvas.Pen.Style := psClear;


    if Self.brackets__marked_only then
      begin

        zt_buffer_coord_1 := Editor.GetMatchingBracket();

        if Highlight_L( ACanvas, zt_buffer_coord_1 ) then
          begin

            zt_buffer_coord_1 := Editor.GetMatchingBracketEx( zt_buffer_coord_1 );

            Highlight_L( ACanvas, zt_buffer_coord_1 );

          end;

      end
    else
      begin

        zts := '';

        if Self.brackets__angle then
          zts := zts + '<>';

        if Self.brackets__curly then
          zts := zts + '{}';

        if Self.brackets__round then
          zts := zts + '()';

        if Self.brackets__squareg then
          zts := zts + '[]';


        zt_buffer_coord_1 := Editor.GetMatchingBracketEx( Editor.CaretXY, zts );

        if   ( zt_buffer_coord_1.Line = 0 )
          or ( zt_buffer_coord_1.Char = 0 ) then
          begin

            if   (  Pos( '<', Editor.Text ) > 0  )
              or (  Pos( '>', Editor.Text ) > 0  ) then
              brackets__angle__open_counter := 0
            else
              brackets__angle__open_counter := -1;

            if   (  Pos( '{', Editor.Text ) > 0  )
              or (  Pos( '}', Editor.Text ) > 0  ) then
              brackets__curly__open_counter := 0
            else
              brackets__curly__open_counter := -1;

            if   (  Pos( '(', Editor.Text ) > 0  )
              or (  Pos( ')', Editor.Text ) > 0  ) then
              brackets__round__open_counter := 0
            else
              brackets__round__open_counter := -1;

            if   (  Pos( '[', Editor.Text ) > 0  )
              or (  Pos( ']', Editor.Text ) > 0  ) then
              brackets__square__open_counter := 0
            else
              brackets__square__open_counter := -1;


            zti := Editor.RowColToCharIndex( Editor.CaretXY );
            zt_buffer_coord_2 := Editor.CharIndexToRowCol( zti );

            if zt_buffer_coord_2.Line <> Editor.CaretY then
              begin

                // If caret X is outside the editor current line length the TBufferCoord.Line indicates next lines.

                zti := 0;

                for i := 1 to Editor.CaretY do
                  begin

                    zti := zti + Length( Editor.Lines[ i - 1 ] );

                    if i > 1 then
                      zti := zti + 2;

                  end;

              end;


            for i := zti to Length( Editor.Text ) - 1 do
              begin

                zt_buffer_coord_2 := Editor.CharIndexToRowCol( i );


                if zt_buffer_coord_2.Char <= Length( Editor.Lines[ zt_buffer_coord_2.Line - 1 ] ) then
                  begin

                    if    ( Self.brackets__angle )
                      and ( brackets__angle__open_counter <> -1 ) then
                      begin

                        if    ( brackets__angle__open_counter = 0 )
                          and ( Editor.Lines[ zt_buffer_coord_2.Line - 1 ][ zt_buffer_coord_2.Char ] = '>' ) then
                          begin

                            brackets__angle__open_counter := -1;

                            zt_buffer_coord_1 := Editor.CharIndexToRowCol( i );


                            if Highlight_L( ACanvas, zt_buffer_coord_1 ) then
                              begin

                                zt_buffer_coord_1 := Editor.GetMatchingBracketEx( zt_buffer_coord_1 );

                                Highlight_L( ACanvas, zt_buffer_coord_1 );

                              end;


                            if not Self.brackets__all_pairs then
                              Break;

                          end
                        else
                        if    ( brackets__angle__open_counter <> -1 )
                          and ( Editor.Lines[ zt_buffer_coord_2.Line - 1 ][ zt_buffer_coord_2.Char ] = '<' ) then
                          begin

                            if not In_View_Check( brackets__angle__open_counter, zt_buffer_coord_2.Line - 1 ) then
                              begin

                                brackets__angle__open_counter := -1;

                                if not Self.brackets__all_pairs then
                                  Break;

                              end
                            else
                              inc( brackets__angle__open_counter );

                          end
                        else
                        if    ( brackets__angle__open_counter <> -1 )
                          and ( Editor.Lines[ zt_buffer_coord_2.Line - 1 ][ zt_buffer_coord_2.Char ] = '>' ) then
                          dec( brackets__angle__open_counter )

                      end;


                    if    ( Self.brackets__curly )
                      and ( brackets__curly__open_counter <> -1 ) then
                      begin

                        if    ( brackets__curly__open_counter = 0 )
                          and ( Editor.Lines[ zt_buffer_coord_2.Line - 1 ][ zt_buffer_coord_2.Char ] = '}' ) then
                          begin

                            brackets__curly__open_counter := -1;

                            zt_buffer_coord_1 := Editor.CharIndexToRowCol( i );


                            if Highlight_L( ACanvas, zt_buffer_coord_1 ) then
                              begin

                                zt_buffer_coord_1 := Editor.GetMatchingBracketEx( zt_buffer_coord_1 );

                                Highlight_L( ACanvas, zt_buffer_coord_1 );

                              end;


                            if not Self.brackets__all_pairs then
                              Break;

                          end
                        else
                        if    ( brackets__curly__open_counter <> -1 )
                          and ( Editor.Lines[ zt_buffer_coord_2.Line - 1 ][ zt_buffer_coord_2.Char ] = '{' ) then
                          begin

                            if not In_View_Check( brackets__curly__open_counter, zt_buffer_coord_2.Line - 1 ) then
                              begin

                                brackets__curly__open_counter := -1;

                                if not Self.brackets__all_pairs then
                                  Break;

                              end
                            else
                              inc( brackets__curly__open_counter );

                          end
                        else
                        if    ( brackets__curly__open_counter <> -1 )
                          and ( Editor.Lines[ zt_buffer_coord_2.Line - 1 ][ zt_buffer_coord_2.Char ] = '}' ) then
                          dec( brackets__curly__open_counter )

                      end;


                    if    ( Self.brackets__round )
                      and ( brackets__round__open_counter <> -1 ) then
                      begin

                        if    ( brackets__round__open_counter = 0 )
                          and ( Editor.Lines[ zt_buffer_coord_2.Line - 1 ][ zt_buffer_coord_2.Char ] = ')' ) then
                          begin

                            brackets__round__open_counter := -1;

                            zt_buffer_coord_1 := Editor.CharIndexToRowCol( i );


                            if Highlight_L( ACanvas, zt_buffer_coord_1 ) then
                              begin

                                zt_buffer_coord_1 := Editor.GetMatchingBracketEx( zt_buffer_coord_1 );

                                Highlight_L( ACanvas, zt_buffer_coord_1 );

                              end;


                            if not Self.brackets__all_pairs then
                              Break;

                          end
                        else
                        if    ( brackets__round__open_counter <> -1 )
                          and ( Editor.Lines[ zt_buffer_coord_2.Line - 1 ][ zt_buffer_coord_2.Char ] = '(' ) then
                          begin

                            if not In_View_Check( brackets__round__open_counter, zt_buffer_coord_2.Line - 1 ) then
                              begin

                                brackets__round__open_counter := -1;

                                if not Self.brackets__all_pairs then
                                  Break;

                              end
                            else
                              inc( brackets__round__open_counter );

                          end
                        else
                        if    ( brackets__round__open_counter <> -1 )
                          and ( Editor.Lines[ zt_buffer_coord_2.Line - 1 ][ zt_buffer_coord_2.Char ] = ')' ) then
                          dec( brackets__round__open_counter )

                      end;


                    if    ( Self.brackets__squareg )
                      and ( brackets__square__open_counter <> -1 ) then
                      begin

                        if    ( brackets__square__open_counter = 0 )
                          and ( Editor.Lines[ zt_buffer_coord_2.Line - 1 ][ zt_buffer_coord_2.Char ] = ']' ) then
                          begin

                            brackets__square__open_counter := -1;

                            zt_buffer_coord_1 := Editor.CharIndexToRowCol( i );


                            if Highlight_L( ACanvas, zt_buffer_coord_1 ) then
                              begin

                                zt_buffer_coord_1 := Editor.GetMatchingBracketEx( zt_buffer_coord_1 );

                                Highlight_L( ACanvas, zt_buffer_coord_1 );

                              end;


                            if not Self.brackets__all_pairs then
                              Break;

                          end
                        else
                        if    ( brackets__square__open_counter <> -1 )
                          and ( Editor.Lines[ zt_buffer_coord_2.Line - 1 ][ zt_buffer_coord_2.Char ] = '[' ) then
                          begin

                            if not In_View_Check( brackets__square__open_counter, zt_buffer_coord_2.Line - 1 ) then
                              begin

                                brackets__square__open_counter := -1;

                                if not Self.brackets__all_pairs then
                                  Break;

                              end
                            else
                              inc( brackets__square__open_counter );

                          end
                        else
                        if    ( brackets__square__open_counter <> -1 )
                          and ( Editor.Lines[ zt_buffer_coord_2.Line - 1 ][ zt_buffer_coord_2.Char ] = ']' ) then
                          dec( brackets__square__open_counter );

                      end;

                  end;

              end;

          end
        else
          if Highlight_L( ACanvas, zt_buffer_coord_1 ) then
            begin

              zt_buffer_coord_1 := Editor.GetMatchingBracketEx( zt_buffer_coord_1 );

              Highlight_L( ACanvas, zt_buffer_coord_1 );

            end;

      end;

    ACanvas.Font.Assign( old_font );
  finally
    old_font.Free();
  end;

end;

end.
