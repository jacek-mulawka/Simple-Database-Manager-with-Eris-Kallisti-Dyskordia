unit Stored_Procedure__Parameter;{30.Sie.2023}

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

  TStored_Procedure__Parameter = class( Vcl.ExtCtrls.TPanel )
  private
    { Private declarations }
    stored_procedure__parameter_id : integer;

    align_correct_button : Vcl.StdCtrls.TButton;

    parameter_data_type : Vcl.StdCtrls.TComboBox;

    parameter_default_value,
    parameter_description
      : Vcl.StdCtrls.TEdit;

    parameter_name_etiquette_label : Vcl.StdCtrls.TLabel;

    parameter_type_input : Vcl.StdCtrls.TCheckBox;

    parameter_data_type__vertical_splitter,
    parameter_default_value__vertical_splitter,
    parameter_description__vertical_splitter,
    parameter_name_etiquette__vertical_splitter
      : Vcl.ExtCtrls.TSplitter;

    procedure align_correct_buttonClick( Sender : TObject );
    procedure type_input_checkboxClick( Sender : TObject );
    procedure field_name_etiquette_labelDblClick( Sender : TObject );
  public
    { Public declarations }
    constructor Create( parent_f : Vcl.Controls.TWinControl; var stored_procedure__parameter_id_f : integer; const parameter__name_f, parameter__data_type_f, parameter__default_value_f, parameter__description_f, parameter__type_input_f, data_types_list_f : string; const splitter_show_f : boolean; on_click_wsk_f : TOn_Click_wsk );
    destructor Destroy(); override;

    procedure Align_Correct__SPP();
    function Data_Type_Get__SPP() : string;
    function Default_Value_Get__SPP() : string;
    function Description_Get__SPP() : string;
    function Name_Get__SPP() : string;
    procedure Name_Set__SPP( const name_f : string );
    procedure Positions_Swap__SPP( const direction_f : TAlign );
    function Stored_Procedure__Parameter_Id__Get() : integer;
    procedure Selected__Notification_Set__SPP( const selected_f : boolean = false );
    function Type_Input__Get__SPP() : boolean;
  end;

  TStored_Procedure__Parameter_t = array of TStored_Procedure__Parameter;


function Stored_Procedure__Parameters_From_Top_To_Bottom__Get( parent_f : Vcl.Controls.TWinControl ) : TStored_Procedure__Parameter_t;


implementation


uses
  Common,
  Translation;

constructor TStored_Procedure__Parameter.Create( parent_f : Vcl.Controls.TWinControl; var stored_procedure__parameter_id_f : integer; const parameter__name_f, parameter__data_type_f, parameter__default_value_f, parameter__description_f, parameter__type_input_f, data_types_list_f : string; const splitter_show_f : boolean; on_click_wsk_f : TOn_Click_wsk );
const
  margin_c : integer = 5;
begin

  inherited Create( Vcl.Forms.Application );

  inc( stored_procedure__parameter_id_f );
  Self.stored_procedure__parameter_id := stored_procedure__parameter_id_f;

  Self.parameter_data_type := nil;
  Self.parameter_data_type__vertical_splitter := nil;
  Self.parameter_default_value := nil;
  Self.parameter_default_value__vertical_splitter := nil;
  Self.parameter_description := nil;
  Self.parameter_description__vertical_splitter := nil;
  Self.parameter_name_etiquette_label := nil;
  Self.parameter_name_etiquette__vertical_splitter := nil;
  Self.parameter_type_input := nil;


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
  Self.Name_Set__SPP( parameter__name_f );
  Self.parameter_name_etiquette_label.AutoSize := false; // After 'Caption := '.
  Self.parameter_name_etiquette_label.Hint :=
    Self.Name_Get__SPP() + #13 + #13 +
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


  Self.parameter_type_input := Vcl.StdCtrls.TCheckBox.Create( Vcl.Forms.Application );
  Self.parameter_type_input.Parent := Self;
  Self.parameter_type_input.AlignWithMargins := true;
  Self.parameter_type_input.Align := alRight;
  Self.parameter_type_input.Align := alLeft; // Do not work well.
  Self.parameter_type_input.Caption := Translation.translation__table__data_filter_r.type_input;
  Self.parameter_type_input.Checked := parameter__type_input_f = Common.db_grid__positive_value_c;
  Self.parameter_type_input.Hint := Translation.translation__table__data_filter_r.type_input__hint;
  Self.parameter_type_input.Margins.Bottom := margin_c;
  Self.parameter_type_input.Margins.Left := margin_c * 2;
  Self.parameter_type_input.Margins.Right := margin_c * 2;
  Self.parameter_type_input.Margins.Top := margin_c;
  Self.parameter_type_input.ShowHint := true;
  Self.parameter_type_input.Width := 50;
  Self.parameter_type_input.OnClick := Self.type_input_checkboxClick;


  Self.parameter_data_type := Vcl.StdCtrls.TComboBox.Create( Vcl.Forms.Application );
  Self.parameter_data_type.Parent := Self;
  Self.parameter_data_type.AlignWithMargins := true;
  Self.parameter_data_type.Align := alRight;
  Self.parameter_data_type.Align := alLeft; // Do not work well.
  Self.parameter_data_type.DropDownCount := 40;
  Self.parameter_data_type.Hint := Translation.translation__table__data_filter_r.parameter_data_type;
  Self.parameter_data_type.Margins.Bottom := margin_c;
  Self.parameter_data_type.Margins.Left := margin_c * 2;
  Self.parameter_data_type.Margins.Right := margin_c * 2;
  Self.parameter_data_type.Margins.Top := margin_c;
  Self.parameter_data_type.ShowHint := true;
  Self.parameter_data_type.Width := 200;
  Common.Items_From_Text_Add( Self.parameter_data_type.Items, data_types_list_f );
  Self.parameter_data_type.Text := parameter__data_type_f;
  Self.parameter_data_type.OnEnter := on_click_wsk_f; // OnClick do not work.

  if splitter_show_f then
    begin

      Self.parameter_data_type__vertical_splitter := Vcl.ExtCtrls.TSplitter.Create( Vcl.Forms.Application );
      Self.parameter_data_type__vertical_splitter.Parent := Self;
      Self.parameter_data_type__vertical_splitter.Align := alRight;
      Self.parameter_data_type__vertical_splitter.Align := alLeft; // Do not work well.
      Self.parameter_data_type__vertical_splitter.AutoSnap := false;
      Self.parameter_data_type__vertical_splitter.Color := Vcl.Graphics.clSkyBlue;
      Self.parameter_data_type__vertical_splitter.MinSize := 1;
      Self.parameter_data_type__vertical_splitter.Width := 6;

    end;


  Self.parameter_default_value := Vcl.StdCtrls.TEdit.Create( Vcl.Forms.Application );
  Self.parameter_default_value.Parent := Self;
  Self.parameter_default_value.AlignWithMargins := true;
  Self.parameter_default_value.Align := alRight;
  Self.parameter_default_value.Align := alLeft; // Do not work well.
  Self.parameter_default_value.Hint := Translation.translation__table__data_filter_r.parameter_default_value;
  Self.parameter_default_value.Margins.Bottom := margin_c;
  Self.parameter_default_value.Margins.Left := margin_c * 2;
  Self.parameter_default_value.Margins.Right := margin_c * 2;
  Self.parameter_default_value.Margins.Top := margin_c;
  Self.parameter_default_value.ShowHint := true;
  Self.parameter_default_value.Text := parameter__default_value_f;
  Self.parameter_default_value.Width := 200;
  Self.parameter_default_value.OnClick := on_click_wsk_f;

  if splitter_show_f then
    begin

      Self.parameter_default_value__vertical_splitter := Vcl.ExtCtrls.TSplitter.Create( Vcl.Forms.Application );
      Self.parameter_default_value__vertical_splitter.Parent := Self;
      Self.parameter_default_value__vertical_splitter.Align := alRight;
      Self.parameter_default_value__vertical_splitter.Align := alLeft; // Do not work well.
      Self.parameter_default_value__vertical_splitter.AutoSnap := false;
      Self.parameter_default_value__vertical_splitter.Color := Vcl.Graphics.clSkyBlue;
      Self.parameter_default_value__vertical_splitter.MinSize := 1;
      Self.parameter_default_value__vertical_splitter.Width := 6;

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


  Self.type_input_checkboxClick( nil );


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

destructor TStored_Procedure__Parameter.Destroy();
begin

  System.SysUtils.FreeAndNil( Self.parameter_name_etiquette_label );
  System.SysUtils.FreeAndNil( Self.parameter_name_etiquette__vertical_splitter );
  System.SysUtils.FreeAndNil( Self.parameter_type_input );
  System.SysUtils.FreeAndNil( Self.parameter_data_type );

  if Self.parameter_data_type__vertical_splitter <> nil then
    System.SysUtils.FreeAndNil( Self.parameter_data_type__vertical_splitter );

  if Self.parameter_default_value <> nil then
    System.SysUtils.FreeAndNil( Self.parameter_default_value );

  if Self.parameter_default_value__vertical_splitter <> nil then
    System.SysUtils.FreeAndNil( Self.parameter_default_value__vertical_splitter );


  System.SysUtils.FreeAndNil( Self.parameter_description );

  if Self.parameter_description__vertical_splitter <> nil then
    System.SysUtils.FreeAndNil( Self.parameter_description__vertical_splitter );


  FreeAndNil( Self.align_correct_button );


  inherited;

end;

procedure TStored_Procedure__Parameter.align_correct_buttonClick( Sender : TObject );
begin

  Self.Align_Correct__SPP();

end;

procedure TStored_Procedure__Parameter.type_input_checkboxClick( Sender : TObject );
begin

  if    ( Self.parameter_default_value <> nil )
    and ( Self.parameter_type_input <> nil ) then
    Self.parameter_default_value.Enabled := Self.parameter_type_input.Checked;


  if Self.parameter_name_etiquette_label <> nil then
    Self.parameter_name_etiquette_label.OnClick( Self.parameter_name_etiquette_label );

end;

procedure TStored_Procedure__Parameter.field_name_etiquette_labelDblClick( Sender : TObject );
begin

  Vcl.Clipbrd.Clipboard.AsText := Self.parameter_name_etiquette_label.Caption;

end;

procedure TStored_Procedure__Parameter.Align_Correct__SPP();
begin

  if Self.parameter_description__vertical_splitter <> nil then
    Self.parameter_description__vertical_splitter.Align := alRight;

  if Self.parameter_description <> nil then
    Self.parameter_description.Align := alRight;

  if Self.parameter_default_value__vertical_splitter <> nil then
    Self.parameter_default_value__vertical_splitter.Align := alRight;

  if Self.parameter_default_value <> nil then
    Self.parameter_default_value.Align := alRight;

  if Self.parameter_data_type__vertical_splitter <> nil then
    Self.parameter_data_type__vertical_splitter.Align := alRight;

  if Self.parameter_data_type <> nil then
    Self.parameter_data_type.Align := alRight;

  if Self.parameter_type_input <> nil then
    Self.parameter_type_input.Align := alRight;

  if Self.parameter_name_etiquette__vertical_splitter <> nil then
    Self.parameter_name_etiquette__vertical_splitter.Align := alRight;



  if Self.parameter_name_etiquette__vertical_splitter <> nil then
    Self.parameter_name_etiquette__vertical_splitter.Align := alLeft;

  if Self.parameter_type_input <> nil then
    Self.parameter_type_input.Align := alLeft;

  if Self.parameter_data_type <> nil then
    Self.parameter_data_type.Align := alLeft;

  if Self.parameter_data_type__vertical_splitter <> nil then
    Self.parameter_data_type__vertical_splitter.Align := alLeft;

  if Self.parameter_default_value <> nil then
    Self.parameter_default_value.Align := alLeft;

  if Self.parameter_default_value__vertical_splitter <> nil then
    Self.parameter_default_value__vertical_splitter.Align := alLeft;

  if Self.parameter_description <> nil then
    Self.parameter_description.Align := alLeft;

  if Self.parameter_description__vertical_splitter <> nil then
    Self.parameter_description__vertical_splitter.Align := alLeft;

end;

function TStored_Procedure__Parameter.Data_Type_Get__SPP() : string;
begin

  if Self.parameter_data_type <> nil then
    Result := Self.parameter_data_type.Text
  else
    Result := '';

end;

function TStored_Procedure__Parameter.Default_Value_Get__SPP() : string;
begin

  if Self.parameter_default_value <> nil then
    Result := Self.parameter_default_value.Text
  else
    Result := '';

end;

function TStored_Procedure__Parameter.Description_Get__SPP() : string;
begin

  if Self.parameter_description <> nil then
    Result := Self.parameter_description.Text
  else
    Result := '';

end;

function TStored_Procedure__Parameter.Name_Get__SPP() : string;
begin

  if Self.parameter_name_etiquette_label <> nil then
    Result := Self.parameter_name_etiquette_label.Caption
  else
    Result := '';

end;

procedure TStored_Procedure__Parameter.Name_Set__SPP( const name_f : string );
begin

  if Self.parameter_name_etiquette_label <> nil then
    Self.parameter_name_etiquette_label.Caption := name_f;

end;

procedure TStored_Procedure__Parameter.Positions_Swap__SPP( const direction_f : TAlign );
var
  i : integer;

  stored_procedure__parameter_t : TStored_Procedure__Parameter_t;
begin

  if Self.Parent = nil then
    Exit;


  stored_procedure__parameter_t := Stored_Procedure__Parameters_From_Top_To_Bottom__Get( Self.Parent );


  if   (
             ( direction_f = alTop )
         and ( stored_procedure__parameter_t[ 0 ] = Self )
       )
    or (
             ( direction_f = alBottom )
         and ( stored_procedure__parameter_t[ Length( stored_procedure__parameter_t ) - 1 ] = Self )
       ) then
    begin

      SetLength( stored_procedure__parameter_t, 0 );
      Exit;

    end;


  // Swap positions.
  for i := Length( stored_procedure__parameter_t ) - 1 downto 0 do
    begin

      stored_procedure__parameter_t[ i ].Align := alBottom;


      if direction_f = alTop then
        begin

          if    (  i < Length( stored_procedure__parameter_t ) - 1  )
            and ( stored_procedure__parameter_t[ i + 1 ] = Self ) then
            Break;

        end
      else
        begin

          if stored_procedure__parameter_t[ i ] = Self then
            begin

              if i < Length( stored_procedure__parameter_t ) - 1 then
                begin

                  stored_procedure__parameter_t[ i + 1 ].Align := alTop;

                end;


              Break;

            end;

        end;

    end;


  Self.Align := alTop;
  //---// Swap positions.


  // Restore align.
  for i := 0 to Length( stored_procedure__parameter_t ) - 1 do
    begin

      if stored_procedure__parameter_t[ i ].Align <> alTop then
        stored_procedure__parameter_t[ i ].Align := alTop;

    end;
  //---// Restore align.


  SetLength( stored_procedure__parameter_t, 0 );

end;

function TStored_Procedure__Parameter.Stored_Procedure__Parameter_Id__Get() : integer;
begin

  Result := Self.stored_procedure__parameter_id;

end;

procedure TStored_Procedure__Parameter.Selected__Notification_Set__SPP( const selected_f : boolean = false );
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

function TStored_Procedure__Parameter.Type_Input__Get__SPP() : boolean;
begin

  if    ( Self.parameter_type_input <> nil )
    and ( Self.parameter_type_input.Checked ) then
    Result := true
  else
    Result := false;

end;

function Stored_Procedure__Parameters_From_Top_To_Bottom__Get( parent_f : Vcl.Controls.TWinControl ) : TStored_Procedure__Parameter_t;
var
  i,
  index_analyzed,
  parent__stored_procedure__parameter__objects__count,
  top_min
    : integer;
begin

  // Find objects in order from top to bottom.

  if parent_f = nil then
    Exit;


  parent__stored_procedure__parameter__objects__count := 0;
  SetLength( Result, 0 );
  SetLength( Result, 1 );
  index_analyzed := 0;


  for i := 0 to parent_f.ControlCount - 1 do
    if parent_f.Controls[ i ].ClassType = TStored_Procedure__Parameter then
      begin

        inc( parent__stored_procedure__parameter__objects__count );

        if parent__stored_procedure__parameter__objects__count = 1 then
          begin

            top_min := parent_f.Controls[ i ].Top;
            Result[ index_analyzed ] := TStored_Procedure__Parameter(parent_f.Controls[ i ]);

          end
        else
          if top_min > parent_f.Controls[ i ].Top then
            begin

              top_min := parent_f.Controls[ i ].Top;
              Result[ index_analyzed ] := TStored_Procedure__Parameter(parent_f.Controls[ i ]);

            end;

      end;


  SetLength( Result, parent__stored_procedure__parameter__objects__count );

  inc( index_analyzed );


  while index_analyzed < parent__stored_procedure__parameter__objects__count do
    begin

      for i := 0 to parent_f.ControlCount - 1 do
        if parent_f.Controls[ i ].ClassType = TStored_Procedure__Parameter then
          begin

            if parent_f.Controls[ i ].Top > Result[ index_analyzed - 1 ].Top then
              if top_min = Result[ index_analyzed - 1 ].Top then
                begin

                  top_min := parent_f.Controls[ i ].Top;
                  Result[ index_analyzed ] := TStored_Procedure__Parameter(parent_f.Controls[ i ]);

                end
              else
                if top_min > parent_f.Controls[ i ].Top then
                  begin

                    top_min := parent_f.Controls[ i ].Top;
                    Result[ index_analyzed ] := TStored_Procedure__Parameter(parent_f.Controls[ i ]);

                  end;

          end;


      inc( index_analyzed );

    end;

end;

end.
