unit View__Parameter;{06.Wrz.2023}

interface

uses
  System.SysUtils,
  Vcl.Clipbrd,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls;

type
  TOn_Click_wsk = procedure( Sender : TObject ) of object;

  TView__Parameter = class( Vcl.ExtCtrls.TPanel )
  private
    { Private declarations }
    view__parameter_id : integer;

    align_correct_button : Vcl.StdCtrls.TButton;

    parameter_description : Vcl.StdCtrls.TEdit;

    parameter_name_etiquette_label : Vcl.StdCtrls.TLabel;

    parameter_description__vertical_splitter,
    parameter_name_etiquette__vertical_splitter
      : Vcl.ExtCtrls.TSplitter;

    procedure align_correct_buttonClick( Sender : TObject );
    procedure field_name_etiquette_labelDblClick( Sender : TObject );
  public
    { Public declarations }
    constructor Create( parent_f : Vcl.Controls.TWinControl; var view__parameter_id_f : integer; const parameter__name_f, parameter__description_f : string; const splitter_show_f : boolean; on_click_wsk_f : TOn_Click_wsk );
    destructor Destroy(); override;

    procedure Align_Correct__VP();
    function Description_Get__VP() : string;
    function Name_Get__VP() : string;
    procedure Name_Set__VP( const name_f : string );
    procedure Positions_Swap__VP( const direction_f : TAlign );
    function View__Parameter_Id__Get() : integer;
    procedure Selected__Notification_Set__VP( const selected_f : boolean = false );
  end;

  TView__Parameter_t = array of TView__Parameter;


function View__Parameters_From_Top_To_Bottom__Get( parent_f : Vcl.Controls.TWinControl ) : TView__Parameter_t;


implementation


uses
  Class_Helper__Win_Control,
  Translation;

constructor TView__Parameter.Create( parent_f : Vcl.Controls.TWinControl; var view__parameter_id_f : integer; const parameter__name_f, parameter__description_f : string; const splitter_show_f : boolean; on_click_wsk_f : TOn_Click_wsk );
const
  margin_c : integer = 5;
begin

  inherited Create( Vcl.Forms.Application );

  inc( view__parameter_id_f );
  Self.view__parameter_id := view__parameter_id_f;

  Self.parameter_description := nil;
  Self.parameter_description__vertical_splitter := nil;
  Self.parameter_name_etiquette_label := nil;
  Self.parameter_name_etiquette__vertical_splitter := nil;


  Self.Parent := parent_f;
  Self.Align := alBottom;
  Self.Align := alTop;
  Self.Height := margin_c * 7;
  Self.ParentBackground := false;
  Self.OnClick := on_click_wsk_f;


  Self.parameter_name_etiquette_label := Vcl.StdCtrls.TLabel.Create( Vcl.Forms.Application );
  Self.parameter_name_etiquette_label.Parent := Self;
  Self.parameter_name_etiquette_label.AlignWithMargins := true;
  Self.parameter_name_etiquette_label.Align := alLeft;
  Self.Name_Set__VP( parameter__name_f );
  Self.parameter_name_etiquette_label.AutoSize := false; // After 'Caption := '.
  Self.parameter_name_etiquette_label.Hint :=
    Self.Name_Get__VP() + #13 + #13 +
    Translation.translation__table__data_filter_r.double_click___copy_the_field_name_to_clipboard;
  Self.parameter_name_etiquette_label.Layout := tlCenter;
  Self.parameter_name_etiquette_label.Margins.Bottom := 0;
  Self.parameter_name_etiquette_label.Margins.Left := margin_c * 2;
  Self.parameter_name_etiquette_label.Margins.Right := margin_c * 2;
  Self.parameter_name_etiquette_label.Margins.Top := 0;
  Self.parameter_name_etiquette_label.ShowHint := true;

  if Self.parameter_name_etiquette_label.Width < 200 then
    Self.parameter_name_etiquette_label.Width := 200;

  Self.parameter_name_etiquette_label.OnClick := on_click_wsk_f;
  Self.parameter_name_etiquette_label.OnDblClick := Self.field_name_etiquette_labelDblClick;

  if splitter_show_f then
    begin

      Self.parameter_name_etiquette__vertical_splitter := Vcl.ExtCtrls.TSplitter.Create( Vcl.Forms.Application );
      Self.parameter_name_etiquette__vertical_splitter.Parent := Self;
      Self.parameter_name_etiquette__vertical_splitter.Align := alRight;
      Self.parameter_name_etiquette__vertical_splitter.Align := alLeft; // Do not work well.
      Self.parameter_name_etiquette__vertical_splitter.AutoSnap := false;
      Self.parameter_name_etiquette__vertical_splitter.Color := Vcl.Graphics.clSkyBlue;
      Self.parameter_name_etiquette__vertical_splitter.MinSize := 1;
      Self.parameter_name_etiquette__vertical_splitter.Width := 6;

    end;


  Self.parameter_description := Vcl.StdCtrls.TEdit.Create( Vcl.Forms.Application );
  Self.parameter_description.Parent := Self;
  Self.parameter_description.AlignWithMargins := true;
  Self.parameter_description.Align := alRight;
  Self.parameter_description.Align := alLeft; // Do not work well.
  Self.parameter_description.Hint := Translation.translation__table__data_filter_r.parameter_description;
  Self.parameter_description.Margins.Bottom := margin_c;
  Self.parameter_description.Margins.Left := margin_c * 2;
  Self.parameter_description.Margins.Right := margin_c * 2;
  Self.parameter_description.Margins.Top := margin_c;
  Self.parameter_description.ShowHint := true;
  Self.parameter_description.Text := parameter__description_f;
  Self.parameter_description.Width := 200;
  Self.parameter_description.OnClick := on_click_wsk_f;

  if splitter_show_f then
    begin

      Self.parameter_description__vertical_splitter := Vcl.ExtCtrls.TSplitter.Create( Vcl.Forms.Application );
      Self.parameter_description__vertical_splitter.Parent := Self;
      Self.parameter_description__vertical_splitter.Align := alRight;
      Self.parameter_description__vertical_splitter.Align := alLeft; // Do not work well.
      Self.parameter_description__vertical_splitter.AutoSnap := false;
      Self.parameter_description__vertical_splitter.Color := Vcl.Graphics.clSkyBlue;
      Self.parameter_description__vertical_splitter.MinSize := 1;
      Self.parameter_description__vertical_splitter.Width := 6;

    end;


  Self.align_correct_button := Vcl.StdCtrls.TButton.Create( Application );
  Self.align_correct_button.Parent := Self;
  Self.align_correct_button.Align := alRight;
  Self.align_correct_button.AlignWithMargins := true;
  Self.align_correct_button.Caption := Translation.translation__table__data_filter_r.correct_align;
  Self.align_correct_button.Height := 20;
  Self.align_correct_button.Hint := Translation.translation__table__data_filter_r.correct_align__hint;
  Self.align_correct_button.Margins.Bottom := margin_c;
  Self.align_correct_button.Margins.Left := margin_c * 2;
  Self.align_correct_button.Margins.Right := margin_c * 2;
  Self.align_correct_button.Margins.Top := margin_c;
  Self.align_correct_button.ShowHint := true;
  Self.align_correct_button.Visible := false;
  Self.align_correct_button.Width := Self.align_correct_button.Height;
  Self.align_correct_button.OnClick := align_correct_buttonClick;

end;

destructor TView__Parameter.Destroy();
begin

  System.SysUtils.FreeAndNil( Self.parameter_name_etiquette_label );
  System.SysUtils.FreeAndNil( Self.parameter_name_etiquette__vertical_splitter );

  System.SysUtils.FreeAndNil( Self.parameter_description );

  if Self.parameter_description__vertical_splitter <> nil then
    System.SysUtils.FreeAndNil( Self.parameter_description__vertical_splitter );


  FreeAndNil( Self.align_correct_button );


  inherited;

end;

procedure TView__Parameter.align_correct_buttonClick( Sender : TObject );
begin

  Self.Align_Correct__VP();

end;

procedure TView__Parameter.field_name_etiquette_labelDblClick( Sender : TObject );
begin

  Vcl.Clipbrd.Clipboard.AsText := Self.parameter_name_etiquette_label.Caption;

end;

procedure TView__Parameter.Align_Correct__VP();
begin

  if Self.parameter_description__vertical_splitter <> nil then
    Self.parameter_description__vertical_splitter.Align := alRight;

  if Self.parameter_description <> nil then
    Self.parameter_description.Align := alRight;

  if Self.parameter_name_etiquette__vertical_splitter <> nil then
    Self.parameter_name_etiquette__vertical_splitter.Align := alRight;



  if Self.parameter_name_etiquette__vertical_splitter <> nil then
    Self.parameter_name_etiquette__vertical_splitter.Align := alLeft;

  if Self.parameter_description <> nil then
    Self.parameter_description.Align := alLeft;

  if Self.parameter_description__vertical_splitter <> nil then
    Self.parameter_description__vertical_splitter.Align := alLeft;

end;

function TView__Parameter.Description_Get__VP() : string;
begin

  if Self.parameter_description <> nil then
    Result := Self.parameter_description.Text
  else
    Result := '';

end;

function TView__Parameter.Name_Get__VP() : string;
begin

  if Self.parameter_name_etiquette_label <> nil then
    Result := Self.parameter_name_etiquette_label.Caption
  else
    Result := '';

end;

procedure TView__Parameter.Name_Set__VP( const name_f : string );
begin

  if Self.parameter_name_etiquette_label <> nil then
    Self.parameter_name_etiquette_label.Caption := name_f;

end;

procedure TView__Parameter.Positions_Swap__VP( const direction_f : TAlign );
var
  i : integer;

  view__parameter_t : TView__Parameter_t;
begin

  if Self.Parent = nil then
    Exit;


  view__parameter_t := View__Parameters_From_Top_To_Bottom__Get( Self.Parent );


  if   (
             ( direction_f = alTop )
         and ( view__parameter_t[ 0 ] = Self )
       )
    or (
             ( direction_f = alBottom )
         and ( view__parameter_t[ Length( view__parameter_t ) - 1 ] = Self )
       ) then
    begin

      SetLength( view__parameter_t, 0 );
      Exit;

    end;


  // Swap positions.
  for i := Length( view__parameter_t ) - 1 downto 0 do
    begin

      if view__parameter_t[ i ] = Self then
        if direction_f = alTop then
          Self.Parent.SetChildOrder( view__parameter_t[ i ], i - 1 )
        else
          Self.Parent.SetChildOrder( view__parameter_t[ i ], i + 1 );


      view__parameter_t[ i ].Align := alBottom;


      if direction_f = alTop then
        begin

          if    (  i < Length( view__parameter_t ) - 1  )
            and ( view__parameter_t[ i + 1 ] = Self ) then
            Break;

        end
      else
        begin

          if view__parameter_t[ i ] = Self then
            begin

              if i < Length( view__parameter_t ) - 1 then
                begin

                  view__parameter_t[ i + 1 ].Align := alTop;

                end;


              Break;

            end;

        end;

    end;


  Self.Align := alTop;
  //---// Swap positions.


  // Restore align.
  for i := 0 to Length( view__parameter_t ) - 1 do
    begin

      if view__parameter_t[ i ].Align <> alTop then
        view__parameter_t[ i ].Align := alTop;

    end;
  //---// Restore align.


  SetLength( view__parameter_t, 0 );

end;

function TView__Parameter.View__Parameter_Id__Get() : integer;
begin

  Result := Self.view__parameter_id;

end;

procedure TView__Parameter.Selected__Notification_Set__VP( const selected_f : boolean = false );
begin

  if Self.parameter_name_etiquette_label <> nil then
    if selected_f then
      Self.parameter_name_etiquette_label.Font.Style := [ TFontStyle.fsBold ]
    else
      Self.parameter_name_etiquette_label.Font.Style := [];


  if selected_f then
    Self.Color := clMoneyGreen
  else
    Self.Color := clBtnFace;

end;

function View__Parameters_From_Top_To_Bottom__Get( parent_f : Vcl.Controls.TWinControl ) : TView__Parameter_t;
var
  i,
  index_analyzed,
  parent__view__parameter__objects__count,
  top_min
    : integer;
begin

  // Find objects in order from top to bottom.

  if parent_f = nil then
    Exit;


  parent__view__parameter__objects__count := 0;
  SetLength( Result, 0 );
  SetLength( Result, 1 );
  index_analyzed := 0;


  for i := 0 to parent_f.ControlCount - 1 do
    if parent_f.Controls[ i ].ClassType = TView__Parameter then
      begin

        inc( parent__view__parameter__objects__count );

        if parent__view__parameter__objects__count = 1 then
          begin

            top_min := parent_f.Controls[ i ].Top;
            Result[ index_analyzed ] := TView__Parameter(parent_f.Controls[ i ]);

          end
        else
          if top_min > parent_f.Controls[ i ].Top then
            begin

              top_min := parent_f.Controls[ i ].Top;
              Result[ index_analyzed ] := TView__Parameter(parent_f.Controls[ i ]);

            end;

      end;


  SetLength( Result, parent__view__parameter__objects__count );

  inc( index_analyzed );


  while index_analyzed < parent__view__parameter__objects__count do
    begin

      for i := 0 to parent_f.ControlCount - 1 do
        if parent_f.Controls[ i ].ClassType = TView__Parameter then
          begin

            if parent_f.Controls[ i ].Top > Result[ index_analyzed - 1 ].Top then
              if top_min = Result[ index_analyzed - 1 ].Top then
                begin

                  top_min := parent_f.Controls[ i ].Top;
                  Result[ index_analyzed ] := TView__Parameter(parent_f.Controls[ i ]);

                end
              else
                if top_min > parent_f.Controls[ i ].Top then
                  begin

                    top_min := parent_f.Controls[ i ].Top;
                    Result[ index_analyzed ] := TView__Parameter(parent_f.Controls[ i ]);

                  end;

          end;


      inc( index_analyzed );

    end;

end;

end.
