unit Table__Data_Filter;{11.Lip.2023}

interface

uses
  Common,
  Shared,
  Table_Column__Values_Distinct,
  Translation,

  Data.DB,
  System.Classes,
  System.IOUtils,
  System.SysUtils,
  Winapi.Windows,
  Vcl.Clipbrd,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls,

  JvSpin;

type
  TTable__Data_Filter = class( Vcl.ExtCtrls.TPanel )
  private
    { Private declarations }
    queries_open_in_background_g,
    sql__quotation_sign__use__tdf
      : boolean;

    database_type__tdf,
    sql__case_insensitive__tdf,
    sql__quotation_sign__tdf,
    table_name__tdf
      : string;

    align_correct_button,
    delete_button,
    move_left_button,
    move_right_button
      : Vcl.StdCtrls.TButton;

    buttons_panel : Vcl.ExtCtrls.TPanel;

    field_dedicated__data_type : Data.DB.TFieldType;

    field_name_combo_box,
    logical_sign_combo_box,
    operators_combo_box
      : Vcl.StdCtrls.TComboBox;

    field_value__dedicated__1,
    field_value__dedicated__2
      : Vcl.Controls.TWinControl;

    case_insensitive_check_box,
    field_value__dedicated__use_check_box,
    inactive_check_box
      : Vcl.StdCtrls.TCheckBox;

    field_value__universal_edit : Vcl.StdCtrls.TEdit;

    vertical_splitter : Vcl.ExtCtrls.TSplitter;

    table__data_filter__table_column__values_distinct_sdbm : Common.TSDBM;

    procedure align_correct_buttonClick( Sender : TObject );
    procedure delete_buttonClick( Sender : TObject );
    procedure move_left_buttonClick( Sender : TObject );
    procedure move_right_buttonClick( Sender : TObject );

    procedure filterKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    function Quotation_Sign__TDF() : string;
  public
    { Public declarations }
    Filter__Activate_wsk : procedure( Sender : TObject ) of object;
    Filter__Deactivate_wsk : procedure( Sender : TObject ) of object;
    Filter__Show_wsk : procedure( Sender : TObject ) of object;

    constructor Create( parent_f : Vcl.Controls.TWinControl; const database_type_f, table_name_f, sql__quotation_sign__tdf_f : string; const queries_open_in_background_f : boolean; field_f : TField; sdbm_f : Common.TSDBM; log_memo_f : TMemo );
    destructor Destroy(); override;

    procedure Align_Correct__DTF();
    function Filter_Value__Get( const sql__quotation_sign__use__tdf_f : boolean ) : string;
    procedure Positions_Swap( const direction_f : TAlign );
  end;

  TTable__Data_Filter_t = array of TTable__Data_Filter;



function Filters_From_Left_To_Right__Get( parent_f : Vcl.Controls.TWinControl ) : TTable__Data_Filter_t;


implementation


constructor TTable__Data_Filter.Create( parent_f : Vcl.Controls.TWinControl; const database_type_f, table_name_f, sql__quotation_sign__tdf_f : string; const queries_open_in_background_f : boolean; field_f : TField; sdbm_f : Common.TSDBM; log_memo_f : TMemo );

  function Parent_Has_Filters() : boolean;
  var
    i_l : integer;
  begin

    // Return true if parent has TTable__Data_Filter objects.

    Result := false;


    if Self.Parent = nil then
      Exit;


    for i_l := Self.Parent.ControlCount - 1 downto 0 do
      if    ( Self.Parent.Controls[ i_l ].ClassType = TTable__Data_Filter )
        and ( Self.Parent.Controls[ i_l ] <> Self ) then
        begin

          Result := true;
          Exit;

        end;

  end;

const
  case_insensitive__file_name_c : string = 'Table__Data_Filter__Case_Insensitive__sql.txt';
  margin_c : integer = 5;
  logical_signs_list__file_name_c : string = 'Table__Data_Filter__Logical_Signs_List.txt';
  operators_list__file_name_c : string = 'Table__Data_Filter__Operators_List.txt';

var
  zts : string;

  zt_sdbm : Common.TSDBM;
begin

  inherited Create( Application );

  database_type__tdf := database_type_f;
  queries_open_in_background_g := queries_open_in_background_f;
  table_name__tdf := table_name_f;

  Self.field_dedicated__data_type := ftUnknown;
  Self.field_name_combo_box := nil;
  Self.field_value__dedicated__use_check_box := nil;
  Self.field_value__dedicated__1 := nil;
  Self.field_value__dedicated__2 := nil;
  Self.field_value__universal_edit := nil;
  Self.logical_sign_combo_box := nil;
  Self.operators_combo_box := nil;
  Self.sql__quotation_sign__tdf := sql__quotation_sign__tdf_f;
  Self.sql__quotation_sign__use__tdf := false;


  Self.Parent := parent_f;
  Self.Align := alRight;
  Self.Align := alLeft;
  Self.Width := 205;


  Self.vertical_splitter := Vcl.ExtCtrls.TSplitter.Create( Application );
  Self.vertical_splitter.Parent := parent_f;
  Self.vertical_splitter.Align := alRight;
  Self.vertical_splitter.Align := alLeft;
  Self.vertical_splitter.AutoSnap := false;
  Self.vertical_splitter.Width := 6;
  Self.vertical_splitter.MinSize := 1;
  Self.vertical_splitter.Color := Vcl.Graphics.clSkyBlue;


  Self.logical_sign_combo_box := Vcl.StdCtrls.TComboBox.Create( Application );
  Self.logical_sign_combo_box.Parent := Self;
  Self.logical_sign_combo_box.AlignWithMargins := true;
  Self.logical_sign_combo_box.Align := alTop; // Do not work well.
  Self.logical_sign_combo_box.DropDownCount := 40;
  Self.logical_sign_combo_box.Margins.Bottom := margin_c;
  Self.logical_sign_combo_box.Margins.Left := margin_c;
  Self.logical_sign_combo_box.Margins.Right := margin_c;
  Self.logical_sign_combo_box.Margins.Top := margin_c;
  Self.logical_sign_combo_box.OnKeyDown := filterKeyDown;

  {$region 'Add logical signs.'}
  Self.logical_sign_combo_box.Items.Clear();

  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__tdf + System.IOUtils.TPath.DirectorySeparatorChar + logical_signs_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      if log_memo_f <> nil then
        log_memo_f.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + logical_signs_list__file_name_c + ').' );

      zts :=
        '' + #13 + #10 +
        'and' + #13 + #10 +
        'or' + #13 + #10;

    end;

  Common.Items_From_Text_Add( Self.logical_sign_combo_box.Items, zts );

  if    ( Parent_Has_Filters() )
    and ( Self.logical_sign_combo_box.Items.Count > 1 ) then
    Self.logical_sign_combo_box.ItemIndex := 1;
  {$endregion 'Add logical signs.'}


  Self.field_name_combo_box := Vcl.StdCtrls.TComboBox.Create( Application );
  Self.field_name_combo_box.Parent := Self;
  Self.field_name_combo_box.AlignWithMargins := true;
  Self.field_name_combo_box.Align := alTop; // Do not work well.
  Self.field_name_combo_box.DropDownCount := 40;
  Self.field_name_combo_box.Margins.Bottom := margin_c;
  Self.field_name_combo_box.Margins.Left := margin_c;
  Self.field_name_combo_box.Margins.Right := margin_c;
  Self.field_name_combo_box.Margins.Top := margin_c;
  Self.field_name_combo_box.Style := csOwnerDrawFixed;
  Self.field_name_combo_box.OnKeyDown := filterKeyDown;

  {$region 'Add columns.'}
  Self.field_name_combo_box.Items.Add( '' );


  zt_sdbm := Common.TSDBM.Create( sdbm_f );
  zt_sdbm.Component_Type_Set( sdbm_f.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__tdf + System.IOUtils.TPath.DirectorySeparatorChar + Common.table_columns_list__sql__file_name_c  );

  if Trim( zts ) = '' then
    begin

      if log_memo_f <> nil then
        log_memo_f.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.table_columns_list__sql__file_name_c + ').' );

      zts := Common.table_columns_list__sql_c;

    end;

  zt_sdbm.Query__Sql__Set( zts );

  zt_sdbm.Query__Param_By_Name__Set( Common.name__table__small_letters_c, table_name__tdf, log_memo_f );

  try
    zt_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        if log_memo_f <> nil then
          log_memo_f.Lines.Add( 'Failed to open columns list:' + #13 + #13 + E.Message + #13 + #13 + zts + '.' );

      end;
  end;

  if zt_sdbm.Query__Active() then
    begin

      try
        zt_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString;
      except
        on E : Exception do
          begin

            zt_sdbm.Query__Close();

            if log_memo_f <> nil then
              log_memo_f.Lines.Add( 'Failed to read column name:' + #13 + #13 + E.Message + #13 + #13 + zts + '.' );

          end;
      end;


      if zt_sdbm.Query__Active() then
        while not zt_sdbm.Query__Eof() do
          begin

            Self.field_name_combo_box.Items.Add(   Trim(  zt_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString  )   ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.


            if    ( field_f <> nil )
              and ( field_f.FieldName = Self.field_name_combo_box.Items[ Self.field_name_combo_box.Items.Count - 1 ] ) then
              Self.field_name_combo_box.ItemIndex := Self.field_name_combo_box.Items.Count - 1;


            zt_sdbm.Query__Next();

          end;

    end;

  if zt_sdbm.Query__Active() then
    zt_sdbm.Query__Close();

  FreeAndNil( zt_sdbm );


  if    ( Self.field_name_combo_box.ItemIndex < 0 )
    and ( Self.field_name_combo_box.Items.Count > 0 ) then
    Self.field_name_combo_box.ItemIndex := 0;
  {$endregion 'Add columns.'}


  Self.operators_combo_box := Vcl.StdCtrls.TComboBox.Create( Application );
  Self.operators_combo_box.Parent := Self;
  Self.operators_combo_box.AlignWithMargins := true;
  Self.operators_combo_box.Align := alTop; // Do not work well.
  Self.operators_combo_box.DropDownCount := 40;
  Self.operators_combo_box.Margins.Bottom := margin_c;
  Self.operators_combo_box.Margins.Left := margin_c;
  Self.operators_combo_box.Margins.Right := margin_c;
  Self.operators_combo_box.Margins.Top := margin_c;
  Self.operators_combo_box.OnKeyDown := filterKeyDown;

  {$region 'Add operators.'}
  Self.operators_combo_box.Items.Clear();

  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__tdf + System.IOUtils.TPath.DirectorySeparatorChar + operators_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      if log_memo_f <> nil then
        log_memo_f.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + operators_list__file_name_c + ').' );

      zts :=
        '' + #13 + #10 +
        '=' + #13 + #10 +
        '<>' +  #13 + #10 +
        '>' + #13 + #10 +
        '>=' + #13 + #10 +
        '<' + #13 + #10 +
        '<=' + #13 + #10 +
        'is null' + #13 + #10 +
        'is not null' + #13 + #10 +
        'like' + #13 + #10 +
        'not like' + #13 + #10 +
        '(' + #13 + #10 +
        ')' + #13 + #10;

    end;

  Common.Items_From_Text_Add( Self.operators_combo_box.Items, zts );

  if Self.operators_combo_box.Items.Count > 1 then
    Self.operators_combo_box.ItemIndex := 1;
  {$endregion 'Add operators.'}


  Self.field_value__universal_edit := Vcl.StdCtrls.TEdit.Create( Application );
  Self.field_value__universal_edit.Parent := Self;
  Self.field_value__universal_edit.AlignWithMargins := true;
  Self.field_value__universal_edit.Align := alBottom;
  Self.field_value__universal_edit.Align := alTop; // Do not work well.
  Self.field_value__universal_edit.Margins.Bottom := margin_c;
  Self.field_value__universal_edit.Margins.Left := margin_c;
  Self.field_value__universal_edit.Margins.Right := margin_c;
  Self.field_value__universal_edit.Margins.Top := margin_c;
  Self.field_value__universal_edit.OnKeyDown := filterKeyDown;

  Self.field_value__dedicated__use_check_box := Vcl.StdCtrls.TCheckBox.Create( Application );
  Self.field_value__dedicated__use_check_box.Parent := Self;
  Self.field_value__dedicated__use_check_box.AlignWithMargins := true;
  Self.field_value__dedicated__use_check_box.Align := alBottom;
  Self.field_value__dedicated__use_check_box.Align := alTop; // Do not work well.
  Self.field_value__dedicated__use_check_box.Caption := Translation.translation__table__data_filter_r.use_additional_value;
  Self.field_value__dedicated__use_check_box.Hint := Translation.translation__table__data_filter_r.field_value__dedicated__use_check_box__hint;
  Self.field_value__dedicated__use_check_box.Margins.Bottom := margin_c;
  Self.field_value__dedicated__use_check_box.Margins.Left := margin_c;
  Self.field_value__dedicated__use_check_box.Margins.Right := margin_c;
  Self.field_value__dedicated__use_check_box.Margins.Top := margin_c;
  Self.field_value__dedicated__use_check_box.ShowHint := true;
  Self.field_value__dedicated__use_check_box.Visible := false;


  if field_f <> nil then
    if field_f.DataType in [ ftDate, ftDateTime, ftTime, ftTimeStamp, ftTimeStampOffset, ftOraTimeStamp ] then
      begin

        Self.field_dedicated__data_type := ftDate;
        Self.field_value__dedicated__use_check_box.Visible := true;


        Self.field_value__dedicated__1 := TDateTimePicker.Create( Application );
        Self.field_value__dedicated__1.Parent := Self;
        Self.field_value__dedicated__1.AlignWithMargins := true;
        Self.field_value__dedicated__1.Align := alBottom;
        Self.field_value__dedicated__1.Align := alTop; // Do not work well.
        Self.field_value__dedicated__1.Margins.Bottom := margin_c;
        Self.field_value__dedicated__1.Margins.Left := margin_c;
        Self.field_value__dedicated__1.Margins.Right := margin_c;
        Self.field_value__dedicated__1.Margins.Top := margin_c;
        TDateTimePicker(Self.field_value__dedicated__1).Kind := Vcl.ComCtrls.dtkDate;
        TDateTimePicker(Self.field_value__dedicated__1).OnKeyDown := filterKeyDown;

        if field_f.DataType in [ ftDateTime, ftTimeStamp, ftTimeStampOffset, ftOraTimeStamp ] then
          begin

            Self.field_value__dedicated__2 := TDateTimePicker.Create( Application );
            Self.field_value__dedicated__2.Parent := Self.field_value__dedicated__1.Parent;
            Self.field_value__dedicated__2.AlignWithMargins := Self.field_value__dedicated__1.AlignWithMargins;
            Self.field_value__dedicated__2.Align := alBottom;
            Self.field_value__dedicated__2.Align := Self.field_value__dedicated__1.Align; // Do not work well.
            Self.field_value__dedicated__2.Margins.Bottom := Self.field_value__dedicated__1.Margins.Bottom;
            Self.field_value__dedicated__2.Margins.Left := Self.field_value__dedicated__1.Margins.Left;
            Self.field_value__dedicated__2.Margins.Right := Self.field_value__dedicated__1.Margins.Right;
            Self.field_value__dedicated__2.Margins.Top := Self.field_value__dedicated__1.Margins.Top;
            TDateTimePicker(Self.field_value__dedicated__2).Kind := Vcl.ComCtrls.dtkTime;
            TDateTimePicker(Self.field_value__dedicated__2).OnKeyDown := filterKeyDown;

          end
        else
        if field_f.DataType in [ ftTime ] then
          begin

            Self.field_dedicated__data_type := ftTime;

            TDateTimePicker(Self.field_value__dedicated__1).Kind := Vcl.ComCtrls.dtkTime;

          end;

      end
    else
    if field_f.DataType in
         [
           ftAutoInc, ftByte, ftBytes, ftInteger, ftLargeint, ftLongWord, ftShortint, ftSmallint, ftWord,
           ftBCD, ftCurrency, ftExtended, ftFloat, ftFMTBcd, ftSingle, ftVarBytes
         ] then
      begin

        Self.field_dedicated__data_type := ftInteger;
        Self.field_value__dedicated__use_check_box.Visible := true;


        Self.field_value__dedicated__1 := JvSpin.TJvSpinEdit.Create( Application );
        Self.field_value__dedicated__1.Parent := Self;
        JvSpin.TJvSpinEdit(Self.field_value__dedicated__1).Thousands := true;

        if field_f.DataType in [ ftBCD, ftCurrency, ftExtended, ftFloat, ftFMTBcd, ftSingle, ftVarBytes ] then
          begin

            JvSpin.TJvSpinEdit(Self.field_value__dedicated__1).ValueType := JvSpin.vtFloat;
            JvSpin.TJvSpinEdit(Self.field_value__dedicated__1).Decimal := field_f.Size;

          end
        else
          JvSpin.TJvSpinEdit(Self.field_value__dedicated__1).ValueType := JvSpin.vtInteger;

        Self.field_value__dedicated__1.AlignWithMargins := true;
        Self.field_value__dedicated__1.Align := alBottom;
        Self.field_value__dedicated__1.Align := alTop; // Do not work well.
        Self.field_value__dedicated__1.Margins.Bottom := margin_c;
        Self.field_value__dedicated__1.Margins.Left := margin_c * 2;
        Self.field_value__dedicated__1.Margins.Right := margin_c * 2;
        Self.field_value__dedicated__1.Margins.Top := margin_c;
        JvSpin.TJvSpinEdit(Self.field_value__dedicated__1).OnKeyDown := filterKeyDown;

      end;
    //else
    //  begin
    //
    //    Self.field_dedicated__data_type := ftUnknown;
    //    Self.field_value__dedicated__1 := nil;
    //
    //  end;


  if    ( not Self.field_value__dedicated__use_check_box.Visible )
    and ( Self.field_value__dedicated__use_check_box.Checked ) then
    Self.field_value__dedicated__use_check_box.Checked := false;


  Self.buttons_panel := Vcl.ExtCtrls.TPanel.Create( Application );
  Self.buttons_panel.Parent := Self;
  Self.buttons_panel.AlignWithMargins := true;
  Self.buttons_panel.Align := alBottom;
  Self.buttons_panel.Align := alTop; // Do not work well.
  Self.buttons_panel.Height := 25 + margin_c * 2;
  Self.buttons_panel.Hint := Translation.translation__table__data_filter_r.buttons_panel__hint;
  Self.buttons_panel.Margins.Bottom := margin_c;
  Self.buttons_panel.Margins.Left := margin_c;
  Self.buttons_panel.Margins.Right := margin_c;
  Self.buttons_panel.Margins.Top := margin_c;
  Self.buttons_panel.ShowHint := true;

  Self.delete_button := Vcl.StdCtrls.TButton.Create( Application );
  Self.delete_button.Parent := Self.buttons_panel;
  Self.delete_button.Caption := '';
  Self.delete_button.Height := 25;
  Self.delete_button.Hint := Translation.translation__table__data_filter_r.delete_filter__hint;
  Self.delete_button.Images := Shared.Shared_DataModule.ImageList1;
  Self.delete_button.ImageIndex := 12;
  Self.delete_button.Left := margin_c;
  Self.delete_button.ShowHint := true;
  Self.delete_button.Top := margin_c;
  Self.delete_button.Width := Self.delete_button.Height;
  Self.delete_button.OnClick := delete_buttonClick;

  Self.case_insensitive_check_box := Vcl.StdCtrls.TCheckBox.Create( Application );
  Self.case_insensitive_check_box.Parent := Self.buttons_panel;
  Self.case_insensitive_check_box.Caption := Translation.translation__table__data_filter_r.case_insensitive;
  Self.case_insensitive_check_box.Hint := Translation.translation__table__data_filter_r.case_insensitive__hint;
  Self.case_insensitive_check_box.Left := Self.delete_button.Left + Self.delete_button.Width + margin_c * 2;
  Self.case_insensitive_check_box.ShowHint := true;
  Self.case_insensitive_check_box.Top := margin_c;
  Self.case_insensitive_check_box.Width := 40;

  Self.inactive_check_box := Vcl.StdCtrls.TCheckBox.Create( Application );
  Self.inactive_check_box.Parent := Self.buttons_panel;
  Self.inactive_check_box.Caption := Translation.translation__table__data_filter_r.disable_filter;
  Self.inactive_check_box.Hint := Translation.translation__table__data_filter_r.disable_filter__hint;
  Self.inactive_check_box.Left := Self.case_insensitive_check_box.Left + Self.case_insensitive_check_box.Width + margin_c;
  Self.inactive_check_box.ShowHint := true;
  Self.inactive_check_box.Top := margin_c;
  Self.inactive_check_box.Width := 40;

  Self.move_left_button := Vcl.StdCtrls.TButton.Create( Application );
  Self.move_left_button.Parent := Self.buttons_panel;
  Self.move_left_button.Caption := '';
  Self.move_left_button.Height := Self.delete_button.Height;
  Self.move_left_button.Hint := Translation.translation__table__data_filter_r.move_left__hint;
  Self.move_left_button.Images := Shared.Shared_DataModule.ImageList1;
  Self.move_left_button.ImageIndex := 15;
  Self.move_left_button.Left := Self.inactive_check_box.Left + Self.inactive_check_box.Width + margin_c;
  Self.move_left_button.ShowHint := true;
  Self.move_left_button.Top := margin_c;
  Self.move_left_button.Width := Self.move_left_button.Height;
  Self.move_left_button.OnClick := move_left_buttonClick;

  Self.move_right_button := Vcl.StdCtrls.TButton.Create( Application );
  Self.move_right_button.Parent := Self.buttons_panel;
  Self.move_right_button.Caption := '';
  Self.move_right_button.Height := Self.delete_button.Height;
  Self.move_right_button.Hint := Translation.translation__table__data_filter_r.move_right__hint;
  Self.move_right_button.Images := Shared.Shared_DataModule.ImageList1;
  Self.move_right_button.ImageIndex := 16;
  Self.move_right_button.Left := Self.move_left_button.Left + Self.move_left_button.Width + margin_c;
  Self.move_right_button.ShowHint := true;
  Self.move_right_button.Top := margin_c;
  Self.move_right_button.Width := Self.move_right_button.Height;
  Self.move_right_button.OnClick := move_right_buttonClick;

  Self.align_correct_button := Vcl.StdCtrls.TButton.Create( Application );
  Self.align_correct_button.Parent := Self.buttons_panel;
  Self.align_correct_button.Caption := Translation.translation__table__data_filter_r.correct_align;
  Self.align_correct_button.Height := 20;
  Self.align_correct_button.Hint := Translation.translation__table__data_filter_r.correct_align__hint;
  Self.align_correct_button.Left := Self.move_right_button.Left + Self.move_right_button.Width + margin_c * 2;
  Self.align_correct_button.ShowHint := true;
  Self.align_correct_button.Top := margin_c;
  Self.align_correct_button.Width := Self.align_correct_button.Height;
  Self.align_correct_button.OnClick := align_correct_buttonClick;


  sql__case_insensitive__tdf := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__tdf + System.IOUtils.TPath.DirectorySeparatorChar + case_insensitive__file_name_c  );

  if Trim( sql__case_insensitive__tdf ) = '' then
    begin

      if log_memo_f <> nil then
        log_memo_f.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + case_insensitive__file_name_c + ').' );

      sql__case_insensitive__tdf :=
        'lower(__COLUMN_NAME__)';

    end
  else
    begin

      sql__case_insensitive__tdf := StringReplace( sql__case_insensitive__tdf, #10, '', [] );
      sql__case_insensitive__tdf := StringReplace( sql__case_insensitive__tdf, #13, '', [] );

    end;


  table__data_filter__table_column__values_distinct_sdbm := Common.TSDBM.Create( sdbm_f );
  table__data_filter__table_column__values_distinct_sdbm.Component_Type_Set( sdbm_f.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

end;

destructor TTable__Data_Filter.Destroy();
begin

  if table__data_filter__table_column__values_distinct_sdbm <> nil then
    begin

      if table__data_filter__table_column__values_distinct_sdbm.Query__Active() then
        table__data_filter__table_column__values_distinct_sdbm.Query__Close();


      FreeAndNil( table__data_filter__table_column__values_distinct_sdbm );

    end;


  Self.field_name_combo_box.Items.Clear();
  Self.logical_sign_combo_box.Clear();
  Self.operators_combo_box.Items.Clear();

  FreeAndNil( Self.field_name_combo_box );

  if Self.field_value__dedicated__use_check_box <> nil then
    FreeAndNil( Self.field_value__dedicated__use_check_box );

  FreeAndNil( Self.field_value__universal_edit );
  FreeAndNil( Self.logical_sign_combo_box );
  FreeAndNil( Self.operators_combo_box );


  if Self.field_value__dedicated__1 <> nil then
    if Self.field_dedicated__data_type in [ ftDate, ftTime ] then
      begin

        FreeAndNil( TDateTimePicker(Self.field_value__dedicated__1) );

        if Self.field_value__dedicated__2 <> nil then
          FreeAndNil( TDateTimePicker(Self.field_value__dedicated__2) );

      end
    else
    if Self.field_dedicated__data_type = ftInteger then
      FreeAndNil( JvSpin.TJvSpinEdit(Self.field_value__dedicated__1) );


  FreeAndNil( Self.align_correct_button );
  FreeAndNil( Self.delete_button );
  FreeAndNil( Self.case_insensitive_check_box );
  FreeAndNil( Self.inactive_check_box );
  FreeAndNil( Self.move_left_button );
  FreeAndNil( Self.move_right_button );
  FreeAndNil( Self.buttons_panel );


  //if Self.vertical_splitter <> nil then
  //  FreeAndNil( Self.vertical_splitter ); // Do not free here.

  inherited;

end;

procedure TTable__Data_Filter.align_correct_buttonClick( Sender : TObject );
begin

  Self.Align_Correct__DTF();

end;

procedure TTable__Data_Filter.delete_buttonClick( Sender : TObject );
begin

  if Self.vertical_splitter <> nil then
    FreeAndNil( Self.vertical_splitter );

  FreeAndNil( Self );

end;

procedure TTable__Data_Filter.move_left_buttonClick( Sender : TObject );
begin

  Self.Positions_Swap( alLeft );

end;

procedure TTable__Data_Filter.move_right_buttonClick( Sender : TObject );
begin

  Self.Positions_Swap( alRight );

end;

procedure TTable__Data_Filter.filterKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
var
  i : integer;

  zts : string;

  table_column__values_distinct_form_l : Table_Column__Values_Distinct.TTable_Column__Values_Distinct_Form;
begin

  if    ( Key = VK_RETURN )
    and ( ssCtrl in Shift )
    and ( @Filter__Deactivate_wsk <> nil ) then
    Filter__Deactivate_wsk( Sender )
  else
  if    ( Key = VK_RETURN )
    and ( @Filter__Activate_wsk <> nil ) then
    Filter__Activate_wsk( Sender )
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( Sender <> nil ) then
  begin

    if    ( Sender is Vcl.StdCtrls.TComboBox )
      and ( Vcl.StdCtrls.TComboBox(Sender).Items.Count > 0 )
      and ( Vcl.StdCtrls.TComboBox(Sender).ItemIndex >= 0 )
      and ( Vcl.StdCtrls.TComboBox(Sender).ItemIndex < Vcl.StdCtrls.TComboBox(Sender).Items.Count ) then
      try
        Vcl.Clipbrd.Clipboard.AsText := Vcl.StdCtrls.TComboBox(Sender).Items[ Vcl.StdCtrls.TComboBox(Sender).ItemIndex ];
      except
        on E : Exception do
          Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
      end
    else
    if Sender is TDateTimePicker then
      try

        if TDateTimePicker(Self.field_value__dedicated__1).Kind = Vcl.ComCtrls.dtkDateTime then
          Vcl.Clipbrd.Clipboard.AsText := DateTimeToStr( TDateTimePicker(Sender).DateTime )
        else
        if TDateTimePicker(Self.field_value__dedicated__1).Kind = Vcl.ComCtrls.dtkTime then
          Vcl.Clipbrd.Clipboard.AsText := TimeToStr( TDateTimePicker(Sender).Time )
        else
          Vcl.Clipbrd.Clipboard.AsText := DateToStr( TDateTimePicker(Sender).Date );

      except
        on E : Exception do
          Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
      end;

  end
  else
  // D.
  if    ( Key = 68 )
    and ( ssCtrl in Shift )
    and ( Self.field_name_combo_box <> nil )
    and (  Trim( Self.field_name_combo_box.Text ) <> ''  ) then
    begin

      {$region 'Column distinct values.'}
      table_column__values_distinct_form_l := Table_Column__Values_Distinct.TTable_Column__Values_Distinct_Form.Create( Application, table__data_filter__table_column__values_distinct_sdbm );
      table_column__values_distinct_form_l.column_name__tcvd := Self.field_name_combo_box.Text;
      table_column__values_distinct_form_l.database_type__tcvd := database_type__tdf;
      table_column__values_distinct_form_l.sql__quotation_sign__tcvd := sql__quotation_sign__tdf;
      table_column__values_distinct_form_l.sql__quotation_sign__use__tcvd := sql__quotation_sign__use__tdf;
      table_column__values_distinct_form_l.table_name__tcvd := table_name__tdf;
      table_column__values_distinct_form_l.queries_open_in_background_g := queries_open_in_background_g;

      if table_column__values_distinct_form_l.ShowModal() = mrOk then
        begin

          if Self.field_value__universal_edit <> nil then
            Self.field_value__universal_edit.Text := table_column__values_distinct_form_l.value_selected__tcvd;


          if    ( Self.field_dedicated__data_type = ftDate )
            and ( Self.field_value__dedicated__1 <> nil ) then
            begin

              zts := Trim( table_column__values_distinct_form_l.value_selected__tcvd );

              for i := Length( zts ) downto 1 do
                if zts[ i ] = ' ' then
                  begin

                    zts := Trim(  Copy( zts, 1, i )  );
                    Break;

                  end;

              try
                TDateTimePicker(Self.field_value__dedicated__1).Date := StrToDate( zts );
              except
              end;


              if Self.field_value__dedicated__2 <> nil then
                begin

                  zts := Trim( table_column__values_distinct_form_l.value_selected__tcvd );

                  for i := Length( zts ) downto 1 do
                    if zts[ i ] = ' ' then
                      begin

                        zts := Trim(   Copy(  zts, i, Length( zts )  )   );
                        Break;

                      end;

                  zts := StringReplace( zts, ' ', '', [ rfReplaceAll ] );

                  try
                    TDateTimePicker(Self.field_value__dedicated__2).Time := StrToTime( zts );
                  except
                    TDateTimePicker(Self.field_value__dedicated__2).Time := 0;
                  end;

                end;

            end
          else
          if    ( Self.field_dedicated__data_type = ftInteger )
            and ( Self.field_value__dedicated__1 <> nil ) then
            begin

              zts := Trim( table_column__values_distinct_form_l.value_selected__tcvd );
              zts := StringReplace( zts, ' ', '', [ rfReplaceAll ] );
              zts := StringReplace( zts, '.', ',', [ rfReplaceAll ] ) ;

              try
                JvSpin.TJvSpinEdit(Self.field_value__dedicated__1).Value := StrToFloat( zts );
              except
                JvSpin.TJvSpinEdit(Self.field_value__dedicated__1).Value := 0;
              end;

            end
          else
          if    ( Self.field_dedicated__data_type = ftTime )
            and ( Self.field_value__dedicated__1 <> nil ) then
            begin

              zts := Trim( table_column__values_distinct_form_l.value_selected__tcvd );
              zts := StringReplace( zts, ' ', '', [ rfReplaceAll ] );

              try
                TDateTimePicker(Self.field_value__dedicated__1).Time := StrToTime( zts );
              except
              end;

            end;

        end;

      FreeAndNil( table_column__values_distinct_form_l );
      {$endregion 'Column distinct values.'}

    end
  else
  // /, ?.
  if    ( Key = 191 )
    and ( ssCtrl in Shift )
    and ( @Filter__Show_wsk <> nil ) then
    Filter__Show_wsk( nil );

end;

procedure TTable__Data_Filter.Align_Correct__DTF();
begin

  if Self.logical_sign_combo_box <> nil then
    Self.logical_sign_combo_box.Align := alBottom;

  if Self.field_name_combo_box <> nil then
    Self.field_name_combo_box.Align := alBottom;

  if Self.operators_combo_box <> nil then
    Self.operators_combo_box.Align := alBottom;

  if Self.field_value__universal_edit <> nil then
    Self.field_value__universal_edit.Align := alBottom;

  if Self.field_value__dedicated__use_check_box <> nil then
    Self.field_value__dedicated__use_check_box.Align := alBottom;

  if Self.field_value__dedicated__1 <> nil then
    Self.field_value__dedicated__1.Align := alBottom;

  if Self.field_value__dedicated__2 <> nil then
    Self.field_value__dedicated__2.Align := alBottom;

  if Self.buttons_panel <> nil then
    Self.buttons_panel.Align := alBottom;



  if Self.logical_sign_combo_box <> nil then
    Self.logical_sign_combo_box.Align := alTop;

  if Self.field_name_combo_box <> nil then
    Self.field_name_combo_box.Align := alTop;

  if Self.operators_combo_box <> nil then
    Self.operators_combo_box.Align := alTop;

  if Self.field_value__universal_edit <> nil then
    Self.field_value__universal_edit.Align := alTop;

  if Self.field_value__dedicated__use_check_box <> nil then
    Self.field_value__dedicated__use_check_box.Align := alTop;

  if Self.field_value__dedicated__1 <> nil then
    Self.field_value__dedicated__1.Align := alTop;

  if Self.field_value__dedicated__2 <> nil then
    Self.field_value__dedicated__2.Align := alTop;

  if Self.buttons_panel <> nil then
    Self.buttons_panel.Align := alTop;

end;

function TTable__Data_Filter.Filter_Value__Get( const sql__quotation_sign__use__tdf_f : boolean ) : string;
var
  zts : string;
begin

  Result := '';


  if Self.inactive_check_box.Checked then
    Exit;


  Self.sql__quotation_sign__use__tdf := sql__quotation_sign__use__tdf_f;


  if    ( Self.logical_sign_combo_box <> nil )
    and (  Trim( Self.logical_sign_combo_box.Text ) <> ''  ) then
    Result := Result + ' ' + Self.logical_sign_combo_box.Text + ' ';

  if    ( Self.field_name_combo_box <> nil )
    and (  Trim( Self.field_name_combo_box.Text ) <> ''  ) then
    begin

      zts := ' ' + Self.Quotation_Sign__TDF() + table_name__tdf + Self.Quotation_Sign__TDF() + Common.sql__names_separator + Self.Quotation_Sign__TDF() + Self.field_name_combo_box.Text + Self.Quotation_Sign__TDF() + ' ';

      if Self.case_insensitive_check_box.Checked then
        zts := StringReplace( sql__case_insensitive__tdf, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, zts, [ rfReplaceAll ] );

      Result := Result + zts;

    end;

  if    ( Self.operators_combo_box <> nil )
    and (  Trim( Self.operators_combo_box.Text ) <> ''  ) then
    Result := Result + ' ' + Self.operators_combo_box.Text + ' ';

  if    ( Self.field_value__dedicated__use_check_box <> nil )
    and ( Self.field_value__dedicated__use_check_box.Checked )
    and ( Self.field_value__dedicated__1 <> nil ) then
    begin

      zts := '0';


      if Self.field_dedicated__data_type = ftDate then
        begin

          zts := DateToStr( TDateTimePicker(Self.field_value__dedicated__1).Date );


          if Self.field_value__dedicated__2 <> nil then
            zts := zts + ' ' + TimeToStr( TDateTimePicker(Self.field_value__dedicated__2).Time );

          zts := '''' + zts + '''';

        end
      else
      if Self.field_dedicated__data_type = ftInteger then
        begin

          zts := FloatToStr( JvSpin.TJvSpinEdit(Self.field_value__dedicated__1).Value );
          zts := StringReplace( zts, ',', '.', [ rfReplaceAll ] );

        end
      else
      if Self.field_dedicated__data_type = ftTime then
        begin

          zts := TimeToStr( TDateTimePicker(Self.field_value__dedicated__1).Time );
          zts := '''' + zts + '''';

        end;


      Result := Result + zts;

    end
  else
    if Self.field_value__universal_edit <> nil then
      Result := Result + Self.field_value__universal_edit.Text;

end;

function TTable__Data_Filter.Quotation_Sign__TDF() : string;
begin

  if Self.sql__quotation_sign__use__tdf then
    begin

      Result := Self.sql__quotation_sign__tdf;

    end
  else
    Result := '';

end;

procedure TTable__Data_Filter.Positions_Swap( const direction_f : TAlign );
var
  i : integer;

  table__data_filter_t : TTable__Data_Filter_t;
begin

  if Self.Parent = nil then
    Exit;


  table__data_filter_t := Filters_From_Left_To_Right__Get( Self.Parent );


  if   (
             ( direction_f = alLeft )
         and ( table__data_filter_t[ 0 ] = Self )
       )
    or (
             ( direction_f = alRight )
         and ( table__data_filter_t[ Length( table__data_filter_t ) - 1 ] = Self )
       ) then
    begin

      SetLength( table__data_filter_t, 0 );
      Exit;

    end;


  // Swap positions.
  for i := Length( table__data_filter_t ) - 1 downto 0 do
    begin

      if table__data_filter_t[ i ].vertical_splitter <> nil then
        table__data_filter_t[ i ].vertical_splitter.Align := alRight;

      table__data_filter_t[ i ].Align := alRight;


      if direction_f = alLeft then
        begin

          if    (  i < Length( table__data_filter_t ) - 1  )
            and ( table__data_filter_t[ i + 1 ] = Self ) then
            Break;

        end
      else
        begin

          if table__data_filter_t[ i ] = Self then
            begin

              if i < Length( table__data_filter_t ) - 1 then
                begin

                  table__data_filter_t[ i + 1 ].Align := alLeft;

                  if table__data_filter_t[ i + 1 ].vertical_splitter <> nil then
                    table__data_filter_t[ i + 1 ].vertical_splitter.Align := alLeft;

                end;


              Break;

            end;

        end;

    end;


  Self.Align := alLeft;

  if Self.vertical_splitter <> nil then
    Self.vertical_splitter.Align := alLeft;
  //---// Swap positions.


  // Restore align.
  for i := 0 to Length( table__data_filter_t ) - 1 do
    begin

      if table__data_filter_t[ i ].Align <> alLeft then
        table__data_filter_t[ i ].Align := alLeft;

      if    ( table__data_filter_t[ i ].vertical_splitter <> nil )
        and ( table__data_filter_t[ i ].vertical_splitter.Align <> alLeft ) then
        table__data_filter_t[ i ].vertical_splitter.Align := alLeft;

    end;
  //---// Restore align.


  SetLength( table__data_filter_t, 0 );

end;

function Filters_From_Left_To_Right__Get( parent_f : Vcl.Controls.TWinControl ) : TTable__Data_Filter_t;
var
  i,
  index_analyzed,
  left_min,
  parent__table__data_filter__objects__count
    : integer;
begin

  // Find objects in order from left to right.

  if parent_f = nil then
    Exit;


  parent__table__data_filter__objects__count := 0;
  SetLength( Result, 0 );
  SetLength( Result, 1 );
  index_analyzed := 0;


  for i := 0 to parent_f.ControlCount - 1 do
    if parent_f.Controls[ i ].ClassType = TTable__Data_Filter then
      begin

        inc( parent__table__data_filter__objects__count );

        if parent__table__data_filter__objects__count = 1 then
          begin

            left_min := parent_f.Controls[ i ].Left;
            Result[ index_analyzed ] := TTable__Data_Filter(parent_f.Controls[ i ]);

          end
        else
          if left_min > parent_f.Controls[ i ].Left then
            begin

              left_min := parent_f.Controls[ i ].Left;
              Result[ index_analyzed ] := TTable__Data_Filter(parent_f.Controls[ i ]);

            end;

      end;


  SetLength( Result, parent__table__data_filter__objects__count );

  inc( index_analyzed );


  while index_analyzed < parent__table__data_filter__objects__count do
    begin

      for i := 0 to parent_f.ControlCount - 1 do
        if parent_f.Controls[ i ].ClassType = TTable__Data_Filter then
          begin

            if parent_f.Controls[ i ].Left > Result[ index_analyzed - 1 ].Left then
              if left_min = Result[ index_analyzed - 1 ].Left then
                begin

                  left_min := parent_f.Controls[ i ].Left;
                  Result[ index_analyzed ] := TTable__Data_Filter(parent_f.Controls[ i ]);

                end
              else
                if left_min > parent_f.Controls[ i ].Left then
                  begin

                    left_min := parent_f.Controls[ i ].Left;
                    Result[ index_analyzed ] := TTable__Data_Filter(parent_f.Controls[ i ]);

                  end;

          end;


      inc( index_analyzed );

    end;

end;

end.
