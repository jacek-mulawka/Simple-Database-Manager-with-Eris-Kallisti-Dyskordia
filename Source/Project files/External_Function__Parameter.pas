unit External_Function__Parameter;{14.Wrz.2023}

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

  TExternal_Function__Parameter = class( Vcl.ExtCtrls.TPanel )
  private
    { Private declarations }
    external_function__parameter_id : integer;

    align_correct_button : Vcl.StdCtrls.TButton;

    parameter_by,
    parameter_data_type
      : Vcl.StdCtrls.TComboBox;

    parameter_type_input : Vcl.StdCtrls.TCheckBox;

    parameter_by__vertical_splitter,
    parameter_data_type__vertical_splitter
      : Vcl.ExtCtrls.TSplitter;

    procedure align_correct_buttonClick( Sender : TObject );
  public
    { Public declarations }
    constructor Create( parent_f : Vcl.Controls.TWinControl; var external_function__parameter_id_f : integer; const parameter_by_f, parameter_data_type_f, parameter_type_input_f, data_types_list_f, parameter_by_list_f : string; const splitter_show_f : boolean; on_click_wsk_f : TOn_Click_wsk );
    destructor Destroy(); override;

    procedure Align_Correct__EFP();
    function Data_Type_Get__EFP() : string;
    function Parameter_By_Get__EFP() : string;
    procedure Positions_Swap__EFP( const direction_f : TAlign );
    function External_Function__Parameter_Id__Get() : integer;
    procedure Selected__Notification_Set__EFP( const selected_f : boolean = false );
    function Type_Input__Get__EFP() : boolean;
  end;

  TExternal_Function__Parameter_t = array of TExternal_Function__Parameter;


function External_Function__Parameters_From_Top_To_Bottom__Get( parent_f : Vcl.Controls.TWinControl ) : TExternal_Function__Parameter_t;


implementation


uses
  Common,
  Translation;

constructor TExternal_Function__Parameter.Create( parent_f : Vcl.Controls.TWinControl; var external_function__parameter_id_f : integer; const parameter_by_f, parameter_data_type_f, parameter_type_input_f, data_types_list_f, parameter_by_list_f : string; const splitter_show_f : boolean; on_click_wsk_f : TOn_Click_wsk );
const
  margin_c : integer = 5;

var
  zti : integer;
begin

  inherited Create( Vcl.Forms.Application );

  inc( external_function__parameter_id_f );
  Self.external_function__parameter_id := external_function__parameter_id_f;

  Self.parameter_by := nil;
  Self.parameter_by__vertical_splitter := nil;
  Self.parameter_data_type := nil;
  Self.parameter_data_type__vertical_splitter := nil;
  Self.parameter_type_input := nil;


  Self.Parent := parent_f;
  Self.Align := alBottom;
  Self.Align := alTop;
  Self.Height := margin_c * 7;
  Self.ParentBackground := false;
  Self.OnClick := on_click_wsk_f;


  Self.parameter_type_input := Vcl.StdCtrls.TCheckBox.Create( Vcl.Forms.Application );
  Self.parameter_type_input.Parent := Self;
  Self.parameter_type_input.AlignWithMargins := true;
  Self.parameter_type_input.Align := alRight;
  Self.parameter_type_input.Align := alLeft; // Do not work well.
  Self.parameter_type_input.Caption := Translation.translation__table__data_filter_r.type_input;
  Self.parameter_type_input.Checked := parameter_type_input_f = Common.db_grid__positive_value_c;
  Self.parameter_type_input.Hint := Translation.translation__table__data_filter_r.type_input__hint;
  Self.parameter_type_input.Margins.Bottom := margin_c;
  Self.parameter_type_input.Margins.Left := margin_c * 2;
  Self.parameter_type_input.Margins.Right := margin_c * 2;
  Self.parameter_type_input.Margins.Top := margin_c;
  Self.parameter_type_input.ShowHint := true;
  Self.parameter_type_input.Width := 50;


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
  Self.parameter_data_type.Text := parameter_data_type_f;
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

  Self.parameter_by := Vcl.StdCtrls.TComboBox.Create( Vcl.Forms.Application );
  Self.parameter_by.Parent := Self;
  Self.parameter_by.AlignWithMargins := true;
  Self.parameter_by.Align := alRight;
  Self.parameter_by.Align := alLeft; // Do not work well.
  Self.parameter_by.DropDownCount := 40;
  Self.parameter_by.Hint := Translation.translation__table__data_filter_r.parameter_by;
  Self.parameter_by.Margins.Bottom := margin_c;
  Self.parameter_by.Margins.Left := margin_c * 2;
  Self.parameter_by.Margins.Right := margin_c * 2;
  Self.parameter_by.Margins.Top := margin_c;
  Self.parameter_by.ShowHint := true;
  Self.parameter_by.Width := 200;
  Common.Items_From_Text_Add( Self.parameter_by.Items, parameter_by_list_f );
  Self.parameter_by.Text := parameter_by_f;
  Self.parameter_by.OnEnter := on_click_wsk_f; // OnClick do not work.

  if splitter_show_f then
    begin

      Self.parameter_by__vertical_splitter := Vcl.ExtCtrls.TSplitter.Create( Vcl.Forms.Application );
      Self.parameter_by__vertical_splitter.Parent := Self;
      Self.parameter_by__vertical_splitter.Align := alRight;
      Self.parameter_by__vertical_splitter.Align := alLeft; // Do not work well.
      Self.parameter_by__vertical_splitter.AutoSnap := false;
      Self.parameter_by__vertical_splitter.Color := Vcl.Graphics.clSkyBlue;
      Self.parameter_by__vertical_splitter.MinSize := 1;
      Self.parameter_by__vertical_splitter.Width := 6;

    end;

end;

destructor TExternal_Function__Parameter.Destroy();
begin

  if Self.parameter_by__vertical_splitter <> nil then
    System.SysUtils.FreeAndNil( Self.parameter_by__vertical_splitter );

  System.SysUtils.FreeAndNil( Self.parameter_by );

  if Self.parameter_data_type__vertical_splitter <> nil then
    System.SysUtils.FreeAndNil( Self.parameter_data_type__vertical_splitter );

  System.SysUtils.FreeAndNil( Self.parameter_data_type );

  System.SysUtils.FreeAndNil( Self.parameter_type_input );

  FreeAndNil( Self.align_correct_button );


  inherited;

end;

procedure TExternal_Function__Parameter.align_correct_buttonClick( Sender : TObject );
begin

  Self.Align_Correct__EFP();

end;

procedure TExternal_Function__Parameter.Align_Correct__EFP();
begin

  if Self.parameter_by__vertical_splitter <> nil then
    Self.parameter_by__vertical_splitter.Align := alRight;

  if Self.parameter_by <> nil then
    Self.parameter_by.Align := alRight;

  if Self.parameter_data_type__vertical_splitter <> nil then
    Self.parameter_data_type__vertical_splitter.Align := alRight;

  if Self.parameter_data_type <> nil then
    Self.parameter_data_type.Align := alRight;

  if Self.parameter_type_input <> nil then
    Self.parameter_type_input.Align := alRight;



  if Self.parameter_type_input <> nil then
    Self.parameter_type_input.Align := alLeft;

  if Self.parameter_data_type <> nil then
    Self.parameter_data_type.Align := alLeft;

  if Self.parameter_data_type__vertical_splitter <> nil then
    Self.parameter_data_type__vertical_splitter.Align := alLeft;

  if Self.parameter_by <> nil then
    Self.parameter_by.Align := alLeft;

  if Self.parameter_by__vertical_splitter <> nil then
    Self.parameter_by__vertical_splitter.Align := alLeft;

end;

function TExternal_Function__Parameter.Data_Type_Get__EFP() : string;
begin

  if Self.parameter_data_type <> nil then
    Result := Self.parameter_data_type.Text
  else
    Result := '';

end;

function TExternal_Function__Parameter.Parameter_By_Get__EFP() : string;
begin

  if Self.parameter_by <> nil then
    Result := Self.parameter_by.Text
  else
    Result := '';

end;

procedure TExternal_Function__Parameter.Positions_Swap__EFP( const direction_f : TAlign );
var
  i : integer;

  external_function__parameter_t : TExternal_Function__Parameter_t;
begin

  if Self.Parent = nil then
    Exit;


  external_function__parameter_t := External_Function__Parameters_From_Top_To_Bottom__Get( Self.Parent );


  if   (
             ( direction_f = alTop )
         and ( external_function__parameter_t[ 0 ] = Self )
       )
    or (
             ( direction_f = alBottom )
         and ( external_function__parameter_t[ Length( external_function__parameter_t ) - 1 ] = Self )
       ) then
    begin

      SetLength( external_function__parameter_t, 0 );
      Exit;

    end;


  // Swap positions.
  for i := Length( external_function__parameter_t ) - 1 downto 0 do
    begin

      external_function__parameter_t[ i ].Align := alBottom;


      if direction_f = alTop then
        begin

          if    (  i < Length( external_function__parameter_t ) - 1  )
            and ( external_function__parameter_t[ i + 1 ] = Self ) then
            Break;

        end
      else
        begin

          if external_function__parameter_t[ i ] = Self then
            begin

              if i < Length( external_function__parameter_t ) - 1 then
                begin

                  external_function__parameter_t[ i + 1 ].Align := alTop;

                end;


              Break;

            end;

        end;

    end;


  Self.Align := alTop;
  //---// Swap positions.


  // Restore align.
  for i := 0 to Length( external_function__parameter_t ) - 1 do
    begin

      if external_function__parameter_t[ i ].Align <> alTop then
        external_function__parameter_t[ i ].Align := alTop;

    end;
  //---// Restore align.


  SetLength( external_function__parameter_t, 0 );

end;

function TExternal_Function__Parameter.External_Function__Parameter_Id__Get() : integer;
begin

  Result := Self.external_function__parameter_id;

end;

procedure TExternal_Function__Parameter.Selected__Notification_Set__EFP( const selected_f : boolean = false );
begin

  if selected_f then
    Self.Color := clMoneyGreen
  else
    Self.Color := clBtnFace;

end;

function TExternal_Function__Parameter.Type_Input__Get__EFP() : boolean;
begin

  if    ( Self.parameter_type_input <> nil )
    and ( Self.parameter_type_input.Checked ) then
    Result := true
  else
    Result := false;

end;

function External_Function__Parameters_From_Top_To_Bottom__Get( parent_f : Vcl.Controls.TWinControl ) : TExternal_Function__Parameter_t;
var
  i,
  index_analyzed,
  parent__external_function__parameter__objects__count,
  top_min
    : integer;
begin

  // Find objects in order from top to bottom.

  if parent_f = nil then
    Exit;


  parent__external_function__parameter__objects__count := 0;
  SetLength( Result, 0 );
  SetLength( Result, 1 );
  index_analyzed := 0;


  for i := 0 to parent_f.ControlCount - 1 do
    if parent_f.Controls[ i ].ClassType = TExternal_Function__Parameter then
      begin

        inc( parent__external_function__parameter__objects__count );

        if parent__external_function__parameter__objects__count = 1 then
          begin

            top_min := parent_f.Controls[ i ].Top;
            Result[ index_analyzed ] := TExternal_Function__Parameter(parent_f.Controls[ i ]);

          end
        else
          if top_min > parent_f.Controls[ i ].Top then
            begin

              top_min := parent_f.Controls[ i ].Top;
              Result[ index_analyzed ] := TExternal_Function__Parameter(parent_f.Controls[ i ]);

            end;

      end;


  SetLength( Result, parent__external_function__parameter__objects__count );

  inc( index_analyzed );


  while index_analyzed < parent__external_function__parameter__objects__count do
    begin

      for i := 0 to parent_f.ControlCount - 1 do
        if parent_f.Controls[ i ].ClassType = TExternal_Function__Parameter then
          begin

            if parent_f.Controls[ i ].Top > Result[ index_analyzed - 1 ].Top then
              if top_min = Result[ index_analyzed - 1 ].Top then
                begin

                  top_min := parent_f.Controls[ i ].Top;
                  Result[ index_analyzed ] := TExternal_Function__Parameter(parent_f.Controls[ i ]);

                end
              else
                if top_min > parent_f.Controls[ i ].Top then
                  begin

                    top_min := parent_f.Controls[ i ].Top;
                    Result[ index_analyzed ] := TExternal_Function__Parameter(parent_f.Controls[ i ]);

                  end;

          end;


      inc( index_analyzed );

    end;

end;

end.
