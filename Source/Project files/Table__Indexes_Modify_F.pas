unit Table__Indexes_Modify_F;{04.Lip.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Translation,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Menus, Vcl.CheckLst;

type
  TTable__Indexes_Modify_F_Frame = class( TFrame )
    Buttons_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    Index_Name_DBEdit: TDBEdit;
    Index_Name_Etiquette_Label: TLabel;
    Indexes_DataSource: TDataSource;
    Indexes_DBGrid: TDBGrid;
    Log_Memo: TMemo;
    Modify_GroupBox: TGroupBox;
    Modify__Add_Button: TButton;
    Modify__Delete_Button: TButton;
    Modify__Name_Edit: TEdit;
    Modify__Name_Etiquette_Label: TLabel;
    Modify__Parameter_Additional_Etiquette_Label: TLabel;
    Record_Number__Records_Count_Label: TLabel;
    Refresh_Button: TButton;
    Search_Edit: TEdit;
    Search_GroupBox: TGroupBox;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Next_Button: TButton;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Prior_Button: TButton;
    Vertical_Splitter: TSplitter;
    Modify__Parameter_Additional_ComboBox: TComboBox;
    Modify__Columns_Name_CheckListBox: TCheckListBox;
    Modify__Columns_Name_Etiquette_Label: TLabel;
    Log_Horizontal_Splitter: TSplitter;
    Modify__Columns_Name__Hide_Indexed_CheckBox: TCheckBox;
    Indexes_PopupMenu: TPopupMenu;
    Index__Delete_MenuItem: TMenuItem;
    N1: TMenuItem;
    Index__Description__Set_MenuItem: TMenuItem;
    Index__Description__Drop_MenuItem: TMenuItem;
    N2: TMenuItem;
    Index__Description__Write_In_Log_MenuItem: TMenuItem;
    Modify__Name__Create_Default_Button: TButton;

    procedure Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );

    procedure Index_Name_DBEditChange( Sender: TObject );
    procedure Search_Change( Sender: TObject );
    procedure Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );

    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Modify__Add_ButtonClick( Sender: TObject );
    procedure Modify__Delete_ButtonClick( Sender: TObject );
    procedure Modify__Name__Create_Default_ButtonClick( Sender: TObject );

    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );
    procedure Modify__Columns_Name_CheckListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Index__Description__Set_MenuItemClick( Sender: TObject );
    procedure Index__Description__Drop_MenuItemClick( Sender: TObject );
    procedure Index__Description__Write_In_Log_MenuItemClick( Sender: TObject );

    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Indexes_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
    procedure Indexes_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Indexes_DBGridTitleClick( Column: TColumn );
  private
    { Private declarations }
    sort__direction_ascending_g,
    sql__quotation_sign__use__timf_g
      : boolean;

    database_type__timf_g,
    sort__column_name_g,
    sql__quotation_sign__timf_g,
    table_name__timf_g,
    word__default_name__index_prefix_g
      : string;

    indexes_sdbm : Common.TSDBM;

    procedure Columns_List_Read( const sql_text_log_f : boolean = false );
    procedure Parent_Tab_Switch( const prior_f : boolean = false );
    function Quotation_Sign__TIMF() : string;
  public
    { Public declarations }
    parent_supreme_tab_sheet : Vcl.Controls.TWinControl;

    procedure Data_Open__TIMF( const force_refresh_f : boolean = false );
    procedure Finish__TIMF();
    procedure Highlight__Font__Set__TIMF();
    procedure Options_Set__TIMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
    procedure Prepare__TIMF( const table_name_f, database_type_f, sql__quotation_sign_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
    procedure Translation__Apply__TIMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
  end;

const
  indexes_list__file_name_c : string = 'Table__Indexes_List__sql.txt';
  indexes_list__parameter_additional__file_name_c : string = 'Table__Indexes__Parameter_Additional_List.txt';
  indexes_list__parameter_additional__name_c : string = 'PARAMETER_ADDITIONAL';
  indexes_list__column__column_name_c : string = 'COLUMN_NAME';
  indexes_list__column__index_name_c : string = 'INDEX_NAME';
  indexes_list__sql__description__drop__file_name_c : string = 'Table__Index__Description__Drop__sql.txt';
  indexes_list__sql__description__set__file_name_c : string = 'Table__Index__Description__Set__sql.txt';
  indexes_list__sql__index_create__file_name_c : string = 'Table__Index__Create__sql.txt';
  indexes_list__sql__index_drop__file_name_c : string = 'Table__Index__Drop__sql.txt';
  indexes_list__sql__default_name__index_prefix__file_name_c : string = 'Table__Index__Default_Name__Index_Prefix__sql.txt';

implementation

uses
  Vcl.Clipbrd,
  Vcl.ComCtrls,

  Shared,
  Text__Edit_Memo;

{$R *.dfm}

procedure TTable__Indexes_Modify_F_Frame.Data_Open__TIMF( const force_refresh_f : boolean = false );
var
  i : integer;

  zts : string;
begin

  if   ( indexes_sdbm = nil )
    or ( indexes_sdbm.component_type__sdbm = Common.ct_none )
    or (
             ( not force_refresh_f )
         and ( indexes_sdbm.Query__Active() )
       ) then
    Exit;


  Screen.Cursor := crHourGlass;

  zts := Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + indexes_list__sql__default_name__index_prefix__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + indexes_list__sql__default_name__index_prefix__file_name_c + ').' );

      word__default_name__index_prefix_g := 'IDX_';

    end
  else
    begin

      word__default_name__index_prefix_g := Common.Text__File_Load( zts );

      word__default_name__index_prefix_g := StringReplace( word__default_name__index_prefix_g, #10, '', [] );
      word__default_name__index_prefix_g := StringReplace( word__default_name__index_prefix_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Index prefix: ' + word__default_name__index_prefix_g + '.' );


  if indexes_sdbm.Query__Active() then
    indexes_sdbm.Query__Close();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + indexes_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + indexes_list__file_name_c + ').' );

      zts :=
        //'select RDB$INDICES.RDB$INDEX_NAME as INDEX_NAME ' + // Single column indexes.
        ////'/*     , RDB$INDICES.RDB$RELATION_NAME as TABLE_NAME*/ ' +
        //'     , RDB$INDEX_SEGMENTS.RDB$FIELD_NAME as COLUMN_NAME ' +
        //'     , cast(  substring( RDB$INDICES.RDB$DESCRIPTION from 1 for 2000 ) as varchar( 2000 )  ) as DESCRIPTION_VALUE__CAST ' +
        //'     , RDB$INDICES.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
        //'from RDB$INDICES ' +
        //'left join RDB$INDEX_SEGMENTS on RDB$INDEX_SEGMENTS.RDB$INDEX_NAME = RDB$INDICES.RDB$INDEX_NAME ' +
        //'where RDB$INDICES.RDB$RELATION_NAME = :table_name ';
        'select RDB$INDICES.RDB$INDEX_NAME as INDEX_NAME ' + // Multiple column indexes.
        ' ' +
        '     , ( ' +
        '         select cast(     substring(    trim(   list(  '' '' || trim( RDB$INDEX_SEGMENTS.RDB$FIELD_NAME )  )   ) from 1 for 2000    ) as varchar( 2000 )     ) ' +
        '         from RDB$INDEX_SEGMENTS ' +
        '         where RDB$INDEX_SEGMENTS.RDB$INDEX_NAME = RDB$INDICES.RDB$INDEX_NAME ' +
        '       ) as COLUMN_NAME ' +
        ' ' +
        '     , cast(  substring( RDB$INDICES.RDB$DESCRIPTION from 1 for 2000 ) as varchar( 2000 )  ) as DESCRIPTION_VALUE__CAST ' +
        '     , RDB$INDICES.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
        ' ' +
        'from RDB$INDICES ' +
        'where RDB$INDICES.RDB$RELATION_NAME = :table_name ';

    end;

  indexes_sdbm.Query__Sql__Set( zts );


  Log_Memo.Lines.Add( zts );


  indexes_sdbm.Query__Param_By_Name__Set( Common.name__table__small_letters_c, table_name__timf_g, Log_Memo );

  try
    indexes_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_indexes_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;


  Screen.Cursor := crDefault;



  if indexes_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( indexes_sdbm.Operation_Duration_Get() );


      try
        indexes_sdbm.Query__Field_By_Name( indexes_list__column__index_name_c ).AsString;
        Index_Name_DBEdit.DataField := indexes_list__column__index_name_c;
        indexes_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );
      except
        on E : Exception do
          begin

            indexes_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_index_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;


      if indexes_sdbm.Query__Active() then
        try
          indexes_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
        except
          on E : Exception do
            begin

              indexes_sdbm.Query__Close();

              Log_Memo.Lines.Add( E.Message );

              Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_description_column_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            end;
        end;


      for i := 0 to Indexes_DBGrid.Columns.Count - 1 do
        if Indexes_DBGrid.Columns.Items[ i ].FieldName = indexes_list__column__column_name_c then
          begin

            if Indexes_DBGrid.Columns.Items[ i ].Width > 500 then
              Indexes_DBGrid.Columns.Items[ i ].Width := 500;

          end
        else
        if Indexes_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value__cast_c then
          begin

            if Indexes_DBGrid.Columns.Items[ i ].Width > 500 then
              Indexes_DBGrid.Columns.Items[ i ].Width := 500;

          end
        else
        if Indexes_DBGrid.Columns.Items[ i ].FieldName = indexes_list__column__index_name_c then
          begin

            if Indexes_DBGrid.Columns.Items[ i ].Width < 300 then
              Indexes_DBGrid.Columns.Items[ i ].Width := 300;

          end
        else
          begin

            if Indexes_DBGrid.Columns.Items[ i ].Width > 200 then
              Indexes_DBGrid.Columns.Items[ i ].Width := 200;

          end;


      Self.Translation__Apply__TIMF( Translation.tak_Grid );


      Self.Columns_List_Read( true );


      Common.Data_Value_Format__Set( indexes_sdbm, Log_Memo );

    end;

end;

procedure TTable__Indexes_Modify_F_Frame.Columns_List_Read( const sql_text_log_f : boolean = false );
var
  item_index_copy_l : integer;

  zts,
  primary_key_value_l
    : string;

  zt_sdbm : Common.TSDBM;
begin

  if   ( indexes_sdbm = nil )
    or ( not indexes_sdbm.Query__Active() ) then
    Exit;

  Screen.Cursor := crHourGlass;

  item_index_copy_l := Modify__Columns_Name_CheckListBox.ItemIndex;
  Modify__Columns_Name_CheckListBox.Items.Clear();

  zt_sdbm := Common.TSDBM.Create( indexes_sdbm );
  zt_sdbm.Component_Type_Set( indexes_sdbm.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + Common.table_columns_list__sql__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + Common.table_columns_list__sql__file_name_c + ').' );

      zts := Common.table_columns_list__sql_c;

    end;

  zt_sdbm.Query__Sql__Set( zts );


  if sql_text_log_f then
    Log_Memo.Lines.Add( zts );


  zt_sdbm.Query__Param_By_Name__Set( Common.name__table__small_letters_c, table_name__timf_g, Log_Memo );

  try
    zt_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_columns_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;

  if zt_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( zt_sdbm.Operation_Duration_Get() );


      try
        zt_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString;
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            zt_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_column_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;


      if zt_sdbm.Query__Active() then
        begin

          indexes_sdbm.Query__Disable_Controls();

          primary_key_value_l := indexes_sdbm.Query__Field_By_Name( indexes_list__column__index_name_c ).AsString;


          while not zt_sdbm.Query__Eof() do
            begin

              // Single column indexes.
              //if   ( not Modify__Columns_Name__Hide_Indexed_CheckBox.Checked )
              //  or (
              //           ( Modify__Columns_Name__Hide_Indexed_CheckBox.Checked )
              //       and (    not indexes_sdbm.Query__Locate(   indexes_list__column__column_name_c, Trim(  zt_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString  ), [ Data.DB.loCaseInsensitive ]   )    )
              //     ) then
              //  Modify__Columns_Name_CheckListBox.Items.Add(   Trim(  zt_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString  )   ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

              // Multiple column indexes.
              zts := '';

              if not Modify__Columns_Name__Hide_Indexed_CheckBox.Checked then
                zts := 'Add'
              else
                begin

                  indexes_sdbm.Query__First();

                  zts := 'Add';

                  while not indexes_sdbm.Query__Eof() do
                    begin

                      if Pos(   ', ' + Trim(  zt_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString  ) + ',', ', ' + Trim(  indexes_sdbm.Query__Field_By_Name( indexes_list__column__column_name_c ).AsString  ) + ','   ) > 0 then
                        begin

                          zts := '';

                          Break;

                        end;

                      indexes_sdbm.Query__Next();

                    end;

                end;


              if zts <> '' then
                Modify__Columns_Name_CheckListBox.Items.Add(   Trim(  zt_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString  )   ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.


              zt_sdbm.Query__Next();

            end;


          indexes_sdbm.Query__Locate( indexes_list__column__index_name_c, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );

          indexes_sdbm.Query__Enable_Controls();

        end;

    end;

  if zt_sdbm.Query__Active() then
    zt_sdbm.Query__Close();

  FreeAndNil( zt_sdbm );


  if Modify__Columns_Name_CheckListBox.Items.Count > 0 then
    begin

      if item_index_copy_l < Modify__Columns_Name_CheckListBox.Items.Count then
        Modify__Columns_Name_CheckListBox.ItemIndex := item_index_copy_l
      else
      if item_index_copy_l - 1 < Modify__Columns_Name_CheckListBox.Items.Count then
        Modify__Columns_Name_CheckListBox.ItemIndex := item_index_copy_l - 1
      else
        Modify__Columns_Name_CheckListBox.ItemIndex := 0;

    end;


  Screen.Cursor := crDefault;

end;

procedure TTable__Indexes_Modify_F_Frame.Finish__TIMF();
begin

  FreeAndNil( indexes_sdbm );

end;

procedure TTable__Indexes_Modify_F_Frame.Highlight__Font__Set__TIMF();
begin

  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    begin

      Common.Font__Set( Indexes_DBGrid.Font, Common.sql_editor__font );
      Common.Font__Set( Modify__Columns_Name_CheckListBox.Font, Common.sql_editor__font );

    end;

end;

procedure TTable__Indexes_Modify_F_Frame.Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );
begin

  if    ( Key = VK_TAB )
    and ( Shift = [ ssCtrl, ssShift ] ) then
    begin

      Self.Parent_Tab_Switch( true );
      Key := 0;

    end
  else
  if    ( Key = VK_TAB )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Self.Parent_Tab_Switch();
      Key := 0;

    end;

end;

procedure TTable__Indexes_Modify_F_Frame.Options_Set__TIMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
begin

  sql__quotation_sign__use__timf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__timf_g := sql__quotation_sign_f;


  if indexes_sdbm <> nil then
    begin

      indexes_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

      indexes_sdbm.Data_Source__Data_Set__Set( Indexes_DataSource );

    end;


  Self.Translation__Apply__TIMF( Translation.tak_Self );

end;

procedure TTable__Indexes_Modify_F_Frame.Parent_Tab_Switch( const prior_f : boolean = false );
var
  zti : integer;
begin

  if    ( parent_supreme_tab_sheet <> nil )
    and ( parent_supreme_tab_sheet is TTabSheet )
    and ( parent_supreme_tab_sheet.Parent <> nil )
    and ( parent_supreme_tab_sheet.Parent is TPageControl )
    and ( TPageControl(parent_supreme_tab_sheet.Parent).PageCount > 1 ) then
    begin

      zti := TPageControl(parent_supreme_tab_sheet.Parent).ActivePageIndex;


      if not prior_f then
        begin

          // Next.

          inc( zti );

          if zti > TPageControl(parent_supreme_tab_sheet.Parent).PageCount - 1 then
            zti := 0;

        end
      else
        begin

          // Prior.

          dec( zti );

          if zti < 0 then
            zti := TPageControl(parent_supreme_tab_sheet.Parent).PageCount - 1;

        end;


      TPageControl(parent_supreme_tab_sheet.Parent).ActivePageIndex := zti;

    end;

end;

procedure TTable__Indexes_Modify_F_Frame.Prepare__TIMF( const table_name_f, database_type_f, sql__quotation_sign_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
var
  zts : string;
begin

  Self.Name := '';

  database_type__timf_g := database_type_f;
  table_name__timf_g := table_name_f;
  sort__column_name_g := indexes_list__column__index_name_c;
  sort__direction_ascending_g := true;


  Log_Memo.Lines.Add( table_name__timf_g );


  indexes_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Self.Options_Set__TIMF( component_type_f, sql__quotation_sign_f, sql__quotation_sign__use_f );



  Modify__Parameter_Additional_ComboBox.Items.Clear();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + indexes_list__parameter_additional__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + indexes_list__parameter_additional__file_name_c + ').' );

      zts :=
        '' + #13 + #10 +
        'ascending' + #13 + #10 +
        'descending' +  #13 + #10;

    end;

  Common.Items_From_Text_Add( Modify__Parameter_Additional_ComboBox.Items, zts );


  Highlight__Font__Set__TIMF();

end;

function TTable__Indexes_Modify_F_Frame.Quotation_Sign__TIMF() : string;
begin

  if sql__quotation_sign__use__timf_g then
    begin

      Result := sql__quotation_sign__timf_g;

    end
  else
    Result := '';

end;

procedure TTable__Indexes_Modify_F_Frame.Translation__Apply__TIMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
var
  i : integer;
begin

  if tak_f in [ Translation.tak_All, Translation.tak_Self ] then
    Translation.Translation__Apply( Self );


  if tak_f in [ Translation.tak_All, Translation.tak_Grid ] then
    for i := 0 to Indexes_DBGrid.Columns.Count - 1 do
      if Indexes_DBGrid.Columns.Items[ i ].FieldName = indexes_list__column__column_name_c then
        Indexes_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__columns
      else
      if Indexes_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value__cast_c then
        Indexes_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__description
      else
      if Indexes_DBGrid.Columns.Items[ i ].FieldName = indexes_list__column__index_name_c then
        Indexes_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__index__name
      else
        Indexes_DBGrid.Columns.Items[ i ].Title.Caption := Common.Column__Name_To_Grid_Caption( Indexes_DBGrid.Columns.Items[ i ].FieldName );

end;

procedure TTable__Indexes_Modify_F_Frame.Index_Name_DBEditChange( Sender: TObject );
begin

  if    ( indexes_sdbm <> nil )
    and ( indexes_sdbm.Query__Active() ) then
    Record_Number__Records_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', indexes_sdbm.Query__Record_Number() )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', indexes_sdbm.Query__Record_Count() )  )
  else
    Record_Number__Records_Count_Label.Caption := '0 / 0';

end;

procedure TTable__Indexes_Modify_F_Frame.Search_Change( Sender: TObject );
var
  locate_options : Data.DB.TLocateOptions;
begin

  if   ( indexes_sdbm = nil )
    or ( not indexes_sdbm.Query__Active() ) then
    Exit;


  locate_options := [];

  if Search__Case_Insensitive_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loCaseInsensitive ];

  if Search__Partial_Key_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loPartialKey ];


  if indexes_sdbm.Query__Locate( sort__column_name_g, Search_Edit.Text, locate_options ) then
    Search_Edit.Color := clWindow
  else
    begin

      Search_Edit.Color := Common.color__red__light_c;


      indexes_sdbm.Query__Disable_Controls();

      indexes_sdbm.Query__First();

      while not indexes_sdbm.Query__Eof do
        begin

          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  indexes_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

          indexes_sdbm.Query__Next();

        end;

      indexes_sdbm.Query__Enable_Controls();

    end;

end;

procedure TTable__Indexes_Modify_F_Frame.Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_PRIOR then
    Search__Prior_ButtonClick( Sender )
  else
  if Key = VK_NEXT then
    Search__Next_ButtonClick( Sender );

end;

procedure TTable__Indexes_Modify_F_Frame.Search__Next_ButtonClick( Sender: TObject );
begin

  if   ( indexes_sdbm = nil )
    or ( not indexes_sdbm.Query__Active() ) then
    Exit;


  indexes_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not indexes_sdbm.Query__Eof do
    begin

      indexes_sdbm.Query__Next();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  indexes_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  indexes_sdbm.Query__Enable_Controls();

end;

procedure TTable__Indexes_Modify_F_Frame.Search__Prior_ButtonClick( Sender: TObject );
begin

  if   ( indexes_sdbm = nil )
    or ( not indexes_sdbm.Query__Active() ) then
    Exit;


  indexes_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not indexes_sdbm.Query__Bof do
    begin

      indexes_sdbm.Query__Prior();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  indexes_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  indexes_sdbm.Query__Enable_Controls();

end;

procedure TTable__Indexes_Modify_F_Frame.Refresh_ButtonClick( Sender: TObject );
var
  primary_key_value_l : string;
begin

  if   ( indexes_sdbm = nil )
    or ( not indexes_sdbm.Query__Active() ) then
    begin

      Self.Data_Open__TIMF( true );

      Exit;

    end;


  primary_key_value_l := indexes_sdbm.Query__Field_By_Name( indexes_list__column__index_name_c ).AsString;

  indexes_sdbm.Query__Requery();


  if    ( Sender <> nil )
    and (
             ( Sender = Modify__Columns_Name__Hide_Indexed_CheckBox )
          or ( Sender = Refresh_Button )
        ) then
    begin

      Log_Memo.Lines.Add( indexes_sdbm.Operation_Duration_Get() );

    end;


  indexes_sdbm.Query__Locate( indexes_list__column__index_name_c, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );


  Self.Columns_List_Read();

end;

procedure TTable__Indexes_Modify_F_Frame.Modify__Add_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  i : integer;

  zts,
  column_name_l,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( indexes_sdbm = nil )
    or ( not indexes_sdbm.Query__Active() ) then
    Exit;


  if Trim( Modify__Name_Edit.Text ) = '' then
    begin

      if Application.MessageBox( PChar(Translation.translation__messages_r.index_name_should_not_be_empty__set_default_index_name_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON1 + MB_ICONQUESTION ) = IDYES then
        Modify__Name__Create_Default_ButtonClick( Sender )
      else
        begin

          Modify__Name_Edit.SetFocus();

          Exit;

        end

    end;


  column_name_l := '';

  for i := 0 to Modify__Columns_Name_CheckListBox.Items.Count - 1 do
    if Modify__Columns_Name_CheckListBox.Checked[ i ] then
      begin

        if column_name_l <> '' then
          column_name_l := column_name_l + ', ';

        column_name_l := column_name_l + Modify__Columns_Name_CheckListBox.Items[ i ];

      end;


  if Trim( column_name_l ) = '' then
    begin

      Modify__Columns_Name_CheckListBox.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.columns_must_be_selected), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + indexes_list__sql__index_create__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + indexes_list__sql__index_create__file_name_c + ').' );

      zts :=
        'create index ' +
        Self.Quotation_Sign__TIMF() + Modify__Name_Edit.Text + Self.Quotation_Sign__TIMF() +
        ' on ' +
        Self.Quotation_Sign__TIMF() + table_name__timf_g + Self.Quotation_Sign__TIMF() +
        ' ' +
        Self.Quotation_Sign__TIMF() + column_name_l + Self.Quotation_Sign__TIMF() + ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + indexes_list__column__column_name_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TIMF() + column_name_l + Self.Quotation_Sign__TIMF(), [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + indexes_list__column__index_name_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TIMF() + Modify__Name_Edit.Text + Self.Quotation_Sign__TIMF(), [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + indexes_list__parameter_additional__name_c + Common.sql__word_replace_separator_c, Modify__Parameter_Additional_ComboBox.Text, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TIMF() + table_name__timf_g + Self.Quotation_Sign__TIMF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.add_index_on_columns__1 + ' ''' + Self.Quotation_Sign__TIMF() + Modify__Name_Edit.Text + Self.Quotation_Sign__TIMF() + ''' ' + Translation.translation__messages_r.add_index_on_columns__2 + ' ''' + Self.Quotation_Sign__TIMF() + column_name_l + Self.Quotation_Sign__TIMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  Screen.Cursor := crSQLWait;


  ztb := indexes_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_add_index );


  Screen.Cursor := crDefault;


  if ztb then
    begin

      Log_Memo.Lines.Add( indexes_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      indexes_sdbm.Query__Locate( indexes_list__column__index_name_c, Modify__Name_Edit.Text, [ Data.DB.loCaseInsensitive ] );


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Indexes_Modify_F_Frame.Modify__Delete_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( indexes_sdbm = nil )
    or ( not indexes_sdbm.Query__Active() )
    or ( indexes_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + indexes_list__sql__index_drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + indexes_list__sql__index_drop__file_name_c + ').' );

      zts :=
        'drop index ' +
        Self.Quotation_Sign__TIMF() + indexes_sdbm.Query__Field_By_Name( indexes_list__column__index_name_c ).AsString + Self.Quotation_Sign__TIMF() +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + indexes_list__column__index_name_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TIMF() + indexes_sdbm.Query__Field_By_Name( indexes_list__column__index_name_c ).AsString + Self.Quotation_Sign__TIMF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_index + ' ''' + Self.Quotation_Sign__TIMF() + indexes_sdbm.Query__Field_By_Name( indexes_list__column__index_name_c ).AsString + Self.Quotation_Sign__TIMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  Screen.Cursor := crSQLWait;


  ztb := indexes_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_index );


  Screen.Cursor := crDefault;


  if ztb then
    begin

      Log_Memo.Lines.Add( indexes_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Indexes_Modify_F_Frame.Modify__Name__Create_Default_ButtonClick( Sender: TObject );
var
  i : integer;

  zts_1,
  zts_2
    : string;
begin

  if   ( indexes_sdbm = nil )
    or ( not indexes_sdbm.Query__Active() ) then
    Exit;


  zts_1 := Copy( word__default_name__index_prefix_g + table_name__timf_g, 1, indexes_sdbm.Query__Field_By_Name( indexes_list__column__index_name_c ).Size - 3 ) + '_';

  for i := 1 to 99 do
    begin

      zts_2 := zts_1 + FormatFloat( '00', i );

      if not indexes_sdbm.Query__Locate( indexes_list__column__index_name_c, zts_2, [ Data.DB.loCaseInsensitive ] ) then
        begin

          zts_1 := '';

          Break;

        end;

    end;


  if zts_1 = '' then
    Modify__Name_Edit.Text := zts_2
  else
    Modify__Name_Edit.Text := zts_1;

end;

procedure TTable__Indexes_Modify_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Buttons_Panel.Width := 1;

end;

procedure TTable__Indexes_Modify_F_Frame.Modify__Columns_Name_CheckListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
var
  i : integer;
begin

  // Enter.
  if Key = VK_RETURN then
    Modify__Add_ButtonClick( Sender )
  else
  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Modify__Columns_Name_CheckListBox.CheckAll( cbChecked, false, false )
  else
  // D.
  if    ( Key = 68 )
    and ( Shift = [ ssCtrl ] ) then
    Modify__Name__Create_Default_ButtonClick( Sender )
  else
  // N.
  if    ( Key = 78 )
    and ( Shift = [ ssCtrl ] ) then
    Modify__Columns_Name_CheckListBox.CheckAll( cbUnchecked, false, false )
  else
  // I.
  if    ( Key = 73 )
    and ( Shift = [ ssCtrl ] ) then
    for i := 0 to Modify__Columns_Name_CheckListBox.Items.Count - 1 do
      Modify__Columns_Name_CheckListBox.Checked[ i ] := not Modify__Columns_Name_CheckListBox.Checked[ i ];

end;

procedure TTable__Indexes_Modify_F_Frame.Index__Description__Set_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  modal_result : TModalResult;

  zts,
  description_value_l,
  error_message_l,
  index_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( indexes_sdbm = nil )
    or ( not indexes_sdbm.Query__Active() )
    or ( indexes_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Text__Edit_Memo.Text__Edit_Memo_Form := Text__Edit_Memo.TText__Edit_Memo_Form.Create( Application );
  Text__Edit_Memo.Text__Edit_Memo_Form.text_value := indexes_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
  Text__Edit_Memo.Text__Edit_Memo_Form.quotation_mark_duplicate := true;
  Text__Edit_Memo.Text__Edit_Memo_Form.Caption := Translation.translation__messages_r.word__description___index;
  Text__Edit_Memo.Text__Edit_Memo_Form.Text_Type_Set( Text__Edit_Memo.tt_Memo );
  modal_result := Text__Edit_Memo.Text__Edit_Memo_Form.ShowModal();

  if modal_result = mrOk then
    description_value_l := Text__Edit_Memo.Text__Edit_Memo_Form.text_value;

  FreeAndNil( Text__Edit_Memo.Text__Edit_Memo_Form );


  index_name_l := Self.Quotation_Sign__TIMF() + Trim(  indexes_sdbm.Query__Field_By_Name( indexes_list__column__index_name_c ).AsString  ) + Self.Quotation_Sign__TIMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + indexes_list__sql__description__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + indexes_list__sql__description__set__file_name_c + ').' );

      zts :=
        'comment on index ' +
        index_name_l +
        ' is ''' + description_value_l + ''' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + indexes_list__column__index_name_c + Common.sql__word_replace_separator_c, index_name_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if modal_result <> mrOk then
    Exit;


  ztb := indexes_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_index_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( indexes_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Indexes_Modify_F_Frame.Index__Description__Drop_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l,
  index_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( indexes_sdbm = nil )
    or ( not indexes_sdbm.Query__Active() )
    or ( indexes_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  index_name_l := Self.Quotation_Sign__TIMF() + Trim(  indexes_sdbm.Query__Field_By_Name( indexes_list__column__index_name_c ).AsString  ) + Self.Quotation_Sign__TIMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + indexes_list__sql__description__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__timf_g ) + indexes_list__sql__description__drop__file_name_c + ').' );

      zts :=
        'comment on index ' +
        index_name_l +
        ' is null ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + indexes_list__column__index_name_c + Common.sql__word_replace_separator_c, index_name_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_index_description + ' ''' + Self.Quotation_Sign__TIMF() + index_name_l + Self.Quotation_Sign__TIMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := indexes_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_index_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( indexes_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Indexes_Modify_F_Frame.Index__Description__Write_In_Log_MenuItemClick( Sender: TObject );
begin

  if   ( indexes_sdbm = nil )
    or ( not indexes_sdbm.Query__Active() )
    or ( indexes_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Log_Memo.Lines.Add( '' );
  Log_Memo.Lines.Add(  indexes_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString  );

end;

procedure TTable__Indexes_Modify_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TTable__Indexes_Modify_F_Frame.Indexes_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
begin

  Common.DB_Grid_Draw_Column_Cell( sort__column_name_g, Indexes_DBGrid, Rect, DataCol, Column, State );

end;

procedure TTable__Indexes_Modify_F_Frame.Indexes_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_DELETE then
    Modify__Delete_ButtonClick( Sender )
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( indexes_sdbm.Query__Active() )
    and ( indexes_sdbm.Query__Record_Count > 0 )
    and ( Indexes_DBGrid.SelectedField <> nil ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Indexes_DBGrid.SelectedField.Value;
    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end;

end;

procedure TTable__Indexes_Modify_F_Frame.Indexes_DBGridTitleClick( Column: TColumn );
begin

  if Column.Field = nil then
    Exit;


  if sort__column_name_g = Column.Field.FieldName then
    sort__direction_ascending_g := not sort__direction_ascending_g
  else
    sort__column_name_g := Column.Field.FieldName;

  indexes_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );


  Index_Name_DBEditChange( nil ); // For FireDAC.

end;

end.
