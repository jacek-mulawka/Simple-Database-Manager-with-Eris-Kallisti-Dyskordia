unit Table__Metadata_F;{26.Lip.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Translation,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus;

type
  TTable__Metadata_F_Frame = class( TFrame )
    Buttons_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    Owner_Etiquette_Label: TLabel;
    Log_Memo: TMemo;
    Vertical_Splitter: TSplitter;
    Log_Horizontal_Splitter: TSplitter;
    Owner_Label: TLabel;
    Metadata_StringGrid: TStringGrid;
    Refresh_Button: TButton;
    Metadata_PopupMenu: TPopupMenu;
    Column__Add_MenuItem: TMenuItem;
    Column__Delete_MenuItem: TMenuItem;
    N1: TMenuItem;
    Column__Name_Edit_MenuItem: TMenuItem;
    N2: TMenuItem;
    Column__Type_Edit_MenuItem: TMenuItem;
    N3: TMenuItem;
    Column__Default_Value__Set_MenuItem: TMenuItem;
    Column__Default_Value__Drop_MenuItem: TMenuItem;
    N4: TMenuItem;
    Column__Description__Set_MenuItem: TMenuItem;
    Column__Description__Drop_MenuItem: TMenuItem;
    N5: TMenuItem;
    Column__Description__Write_In_Log_MenuItem: TMenuItem;
    N6: TMenuItem;
    Column__Not_Null__Add_MenuItem: TMenuItem;
    Column__Not_Null__Delete_MenuItem: TMenuItem;
    N7: TMenuItem;
    Table__Description__Set_MenuItem: TMenuItem;
    Table__Description__Drop_MenuItem: TMenuItem;
    N8: TMenuItem;
    Table__Primary_Key_Set_MenuItem: TMenuItem;
    N9: TMenuItem;
    Metadata__Write_In_Log_MenuItem: TMenuItem;
    Metadata__Write_In_Log__As_Create_Table_MenuItem: TMenuItem;
    N10: TMenuItem;
    Table_Column__Values_Distinct_MenuItem: TMenuItem;
    Table_Description_Memo: TMemo;
    Metadata_Panel: TPanel;
    Table_Description_Memo_Horizontal_Splitter: TSplitter;
    Table_Description_GroupBox: TGroupBox;
    Search_GroupBox: TGroupBox;
    Search_Edit: TEdit;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Prior_Button: TButton;
    Search__Next_Button: TButton;

    procedure Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );

    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );
    procedure Owner_Etiquette_LabelDblClick( Sender: TObject );
    procedure Owner_LabelDblClick( Sender: TObject );
    procedure Search_Change( Sender: TObject );
    procedure Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );
    procedure Column__Add_MenuItemClick( Sender: TObject );
    procedure Column__Delete_MenuItemClick( Sender: TObject );
    procedure Column__Name_Edit_MenuItemClick( Sender: TObject );
    procedure Column__Type_Edit_MenuItemClick( Sender: TObject );
    procedure Column__Default_Value__Set_MenuItemClick( Sender: TObject );
    procedure Column__Default_Value__Drop_MenuItemClick( Sender: TObject );
    procedure Column__Description__Set_MenuItemClick( Sender: TObject );
    procedure Column__Description__Drop_MenuItemClick( Sender: TObject );
    procedure Column__Description__Write_In_Log_MenuItemClick( Sender: TObject );
    procedure Column__Not_Null__Add_MenuItemClick( Sender: TObject );
    procedure Column__Not_Null__Delete_MenuItemClick( Sender: TObject );
    procedure Table__Description__Set_MenuItemClick( Sender: TObject );
    procedure Table__Description__Drop_MenuItemClick( Sender: TObject );
    procedure Table__Primary_Key_Set_MenuItemClick( Sender: TObject );
    procedure Metadata__Write_In_Log_MenuItemClick( Sender: TObject );
    procedure Metadata__Write_In_Log__As_Create_Table_MenuItemClick( Sender: TObject );
    procedure Table_Column__Values_Distinct_MenuItemClick( Sender: TObject );
    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Table_Description_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Metadata_StringGridDrawCell( Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState );
    procedure Metadata_StringGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
  private
    { Private declarations }
    queries_open_in_background_g,
    primary_key__unknown_g,
    sql__quotation_sign__use__tmef_g,
    values_logged_g // Values log only once.
      : boolean;

    database_type__tmef_g,
    default_replace_g, // Database return default value as 'default default_value'.
    primary_key__name_g,
    sql__table__create_g,
    sql__table__primary_key_g,
    sql__quotation_sign__tmef_g,
    table_name__tmef_g,
    word__columns_separator__tmef_g
      : string;

    table_column__values_distinct_form_list__tmef_g : TList;

    metadata_sdbm : Common.TSDBM;

    metadata_log_t : array of string;

    procedure Free_All__Table_Column__Values_Distinct();
    function Quotation_Sign__TMeF() : string;
  public
    { Public declarations }
    parent_supreme_tab_sheet : Vcl.Controls.TWinControl;

    procedure Data_Open__TMeF( const refresh_all_f : boolean = false );
    procedure Finish__TMeF();
    procedure Highlight__Font__Set__TMeF();
    procedure Options_Set__TMeF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const queries_open_in_background_f, sql__quotation_sign__use_f : boolean );
    procedure Parent_Tab_Switch( const prior_f : boolean = false );
    procedure Prepare__TMeF( const table_name_f, database_type_f, sql__quotation_sign_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const queries_open_in_background_f, sql__quotation_sign__use_f : boolean );
    function Task_Running_Check__TMeF( const message_show_f : boolean = true ) : boolean;
    procedure Translation__Apply__TMeF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
  end;

const
  metadata__column_number__allow_nulls_c : integer = 4;
  metadata__column_number__character_set_c : integer = 6;
  metadata__column_number__collation_c : integer = 7;
  metadata__column_number__default_c : integer = 5;
  metadata__column_number__description_c : integer = 11;
  metadata__column_number__id_name_c : integer = 10;
  metadata__column_number__length_c : integer = 3;
  metadata__column_number__name_c : integer = 1;
  metadata__column_number__no_c : integer = 0;
  metadata__column_number__owner_c : integer = 9;
  metadata__column_number__primary_key_c : integer = 12;
  metadata__column_number__segment_length_c : integer = 8;
  metadata__column_number__type_c : integer = 2;
  metadata__column__base_collation_name_c : string = 'BASE_COLLATION_NAME';
  metadata__column__character_set_name_c : string = 'CHARACTER_SET_NAME';
  metadata__column__collation_name_c : string = 'COLLATION_NAME';
  metadata__column__id_field_source_name_c : string = 'ID_FIELD_SOURCE_NAME';
  metadata__column__length_c : string = 'FIELD_LENGTH';
  metadata__column__metadata_log_c : string = 'METADATA_LOG';
  metadata__column__not_null_c : string = 'NOT_NULL';
  metadata__column__scale_c : string = 'FIELD_SCALE';
  metadata__column__segment_length_c : string = 'SEGMENT_LENGTH';
  metadata__column__sql__column__drop__file_name_c : string = 'Table__Column__Drop__sql.txt';
  metadata__column__sql__default_value__drop__file_name_c : string = 'Column__Default_Value__Drop__sql.txt';
  metadata__column__sql__default_value__set__file_name_c : string = 'Column__Default_Value__Set__sql.txt';
  metadata__column__sql__description__drop__file_name_c : string = 'Column__Description__Drop__sql.txt';
  metadata__column__sql__description__set__file_name_c : string = 'Column__Description__Set__sql.txt';
  metadata__column__sql__name__set__file_name_c : string = 'Column__Name__Set__sql.txt';
  metadata__column__sql__not_null__drop__file_name_c : string = 'Column__Not_Null__Drop__sql.txt';
  metadata__column__sql__not_null__set__file_name_c : string = 'Column__Not_Null__Set__sql.txt';
  metadata__column__sql__primary_key__set__file_name_c : string = 'Column__Primary_Key__Set__sql.txt';
  metadata__column__type_c : string = 'FIELD_TYPE';
  metadata__column__name_new_c : string = 'COLUMN_NAME_NEW';
  metadata__default_replace__file_name_c = 'Table__Default_Replace.txt';
  metadata__default_value_c : string = 'DEFAULT_VALUE';
  metadata__table__column_name_c : string = 'TABLE_COLUMN_NAME';
  metadata__table__columns_list__file_name_c : string = 'Table__Columns__Metadata_List__sql.txt';
  metadata__table__description__file_name_c : string = 'Table__Description__sql.txt';
  metadata__table__owner__file_name_c : string = 'Table__Owner__sql.txt';
  metadata__table__sql__description__drop__file_name_c : string = 'Table__Description__Drop__sql.txt';
  metadata__table__sql__description__set__file_name_c : string = 'Table__Description__Set__sql.txt';

implementation

uses
  Vcl.Clipbrd,
  Vcl.ComCtrls,

  Table_Column__Modify,
  Table_Column__Values_Distinct,
  Text__Edit_Memo,
  Shared;

{$R *.dfm}

procedure TTable__Metadata_F_Frame.Data_Open__TMeF( const refresh_all_f : boolean = false );
var
  i : integer;

  zts : string;
begin

  if   ( metadata_sdbm = nil )
    or ( metadata_sdbm.component_type__sdbm = Common.ct_none ) then
    Exit;


  Screen.Cursor := crHourGlass;


  if refresh_all_f then
    begin

      zts := Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__default_replace__file_name_c;

      if not FileExists( zts ) then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__default_replace__file_name_c + ').' );

          default_replace_g := 'default ';

        end
      else
        begin

          default_replace_g := Common.Text__File_Load( zts );

          default_replace_g := StringReplace( default_replace_g, #10, '', [] );
          default_replace_g := StringReplace( default_replace_g, #13, '', [] );

        end;

      Log_Memo.Lines.Add( 'Default replace: ' + default_replace_g + '.' );


      if metadata_sdbm.Query__Active() then
        metadata_sdbm.Query__Close();

      zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__table__owner__file_name_c  );

      if Trim( zts ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__table__owner__file_name_c + ').' );

          zts :=
            'select RDB$RELATIONS.RDB$OWNER_NAME as OWNER_NAME ' +
            'from RDB$RELATIONS ' +
            'where RDB$RELATIONS.RDB$RELATION_NAME = :table_name ';

        end;

      metadata_sdbm.Query__Sql__Set( zts );


      if not values_logged_g then
        Log_Memo.Lines.Add( zts );


      metadata_sdbm.Query__Param_By_Name__Set( Common.name__table__small_letters_c, table_name__tmef_g, Log_Memo );

      try
        metadata_sdbm.Query__Open();
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_table_owner_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            Screen.Cursor := crHourGlass;

          end;
      end;


      if metadata_sdbm.Query__Active() then
        begin

          Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


          try
            Owner_Label.Caption := Trim( metadata_sdbm.Query__Field_By_Name( Common.name__owner_name_c ).AsString ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_table_owner_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

                Screen.Cursor := crHourGlass;

              end;
          end;

        end;


      if metadata_sdbm.Query__Active() then
        metadata_sdbm.Query__Close();

      zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + Common.primary_key__file_name_c  );

      if Trim( zts ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + Common.primary_key__file_name_c + ').' );

          zts :=
            'select RDB$INDEX_SEGMENTS.RDB$FIELD_NAME as PRIMARY_KEY_NAME ' +
            'from RDB$INDICES ' +
            'left join RDB$INDEX_SEGMENTS on RDB$INDEX_SEGMENTS.RDB$INDEX_NAME = RDB$INDICES.RDB$INDEX_NAME ' +
            'left join RDB$RELATION_CONSTRAINTS on RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME = RDB$INDICES.RDB$INDEX_NAME ' +
            'where RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' ' +
            '  and RDB$RELATION_CONSTRAINTS.RDB$RELATION_NAME = :table_name ';

        end;

      metadata_sdbm.Query__Sql__Set( zts );


      if not values_logged_g then
        Log_Memo.Lines.Add( zts );


      metadata_sdbm.Query__Param_By_Name__Set( Common.name__table__small_letters_c, table_name__tmef_g, Log_Memo );

      try
        metadata_sdbm.Query__Open();
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_primary_key_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;

      if metadata_sdbm.Query__Active() then
        begin

          Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


          try
            primary_key__name_g := Trim( metadata_sdbm.Query__Field_By_Name( Common.column_name__primary_key_c ).AsString ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.
          except
            on E : Exception do
              begin

                metadata_sdbm.Query__Close();

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_primary_key_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

              end;
          end;


          if Trim( primary_key__name_g ) = '' then
            begin

              primary_key__unknown_g := true;

              primary_key__name_g := '';

            end
          else
            primary_key__unknown_g := false;

        end;

    end;


  if metadata_sdbm.Query__Active() then
    metadata_sdbm.Query__Close();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__table__description__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__table__description__file_name_c + ').' );

      zts :=
        'select RDB$RELATIONS.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
        'from RDB$RELATIONS ' +
        'where RDB$RELATIONS.RDB$RELATION_NAME = :table_name ';

    end;

  metadata_sdbm.Query__Sql__Set( zts );


  if not values_logged_g then
    Log_Memo.Lines.Add( zts );


  metadata_sdbm.Query__Param_By_Name__Set( Common.name__table__small_letters_c, table_name__tmef_g, Log_Memo );

  try
    metadata_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_table_description + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

        Screen.Cursor := crHourGlass;

      end;
  end;


  if metadata_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


      try
        Table_Description_Memo.Lines.Text := metadata_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_table_description + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            Screen.Cursor := crHourGlass;

          end;
      end;

    end;


  if metadata_sdbm.Query__Active() then
    metadata_sdbm.Query__Close();


  SetLength( metadata_log_t, 0 );

  if Metadata_StringGrid.ColCount < 13 then
    Metadata_StringGrid.ColCount := 13;

  Metadata_StringGrid.RowCount := 2;

  for i := 1 to Metadata_StringGrid.ColCount - 1 do
    Metadata_StringGrid.Rows[ i ].Clear();

  if Metadata_StringGrid.Cells[ 0, 0 ] = '' then
    begin

      Metadata_StringGrid.ColWidths[ metadata__column_number__name_c ] := 200;
      Metadata_StringGrid.ColWidths[ metadata__column_number__type_c ] := 100;
      Metadata_StringGrid.ColWidths[ metadata__column_number__default_c ] := 100;
      Metadata_StringGrid.ColWidths[ metadata__column_number__character_set_c ] := 100;
      Metadata_StringGrid.ColWidths[ metadata__column_number__collation_c ] := 100;
      Metadata_StringGrid.ColWidths[ metadata__column_number__id_name_c ] := 100;
      Metadata_StringGrid.ColWidths[ metadata__column_number__description_c ] := 400;
      Metadata_StringGrid.ColWidths[ metadata__column_number__primary_key_c ] := 80;

    end;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__table__columns_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__table__columns_list__file_name_c + ').' );

      zts :=
        'select RDB$RELATION_FIELDS.RDB$FIELD_SOURCE as ID_FIELD_SOURCE_NAME ' +
        ' ' +
        '     , RDB$COLLATIONS.RDB$BASE_COLLATION_NAME as BASE_COLLATION_NAME ' +
        '     , RDB$CHARACTER_SETS.RDB$CHARACTER_SET_NAME as CHARACTER_SET_NAME ' +
        '     , RDB$COLLATIONS.RDB$COLLATION_NAME as COLLATION_NAME ' +
        '     , RDB$RELATION_FIELDS.RDB$FIELD_NAME as COLUMN_NAME ' +
        '     , cast(   substring(  coalesce( RDB$RELATION_FIELDS.RDB$DEFAULT_SOURCE, RDB$FIELDS.RDB$DEFAULT_SOURCE ) from 1 for 255  ) as varchar( 255 )   ) as DEFAULT_VALUE__CAST ' +
        '     , coalesce( RDB$RELATION_FIELDS.RDB$DEFAULT_SOURCE, RDB$FIELDS.RDB$DEFAULT_SOURCE ) as DEFAULT_VALUE ' +
        '     , RDB$RELATION_FIELDS.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
        '     , iif( RDB$FIELDS.RDB$CHARACTER_LENGTH is not null, RDB$FIELDS.RDB$CHARACTER_LENGTH, RDB$FIELDS.RDB$FIELD_PRECISION ) as FIELD_LENGTH ' +
        '     , iif(  RDB$FIELDS.RDB$FIELD_TYPE in ( 7, 8, 16 ) and RDB$FIELDS.RDB$FIELD_SUB_TYPE = 2, abs( RDB$FIELDS.RDB$FIELD_SCALE ), null  ) as FIELD_SCALE ' +
        ' ' +
        '     , (case ' +
        '         RDB$FIELDS.RDB$FIELD_TYPE ' +
        '         when 7 then ' +
        '           (case ' +
        '             RDB$FIELDS.RDB$FIELD_SUB_TYPE ' +
        '             when 1 then ' +
        '               ''Numeric'' ' +
        ' ' +
        '             when 2 then ' +
        '               ''Decimal'' ' +
        ' ' +
        '             else ' +
        '               ''Smallint'' ' +
        '           end) ' +
        ' ' +
        '         when 8 then ' +
        '           (case ' +
        '             RDB$FIELDS.RDB$FIELD_SUB_TYPE ' +
        '             when 1 then ' +
        '               ''Numeric'' ' +
        ' ' +
        '             when 2 then ' +
        '               ''Decimal'' ' +
        ' ' +
        '             else ' +
        '               ''Integer'' ' +
        '           end) ' +
        ' ' +
        '         when 9 then ' +
        '           ''Quad'' ' +
        ' ' +
        '         when 10 then ' +
        '           ''Float'' ' +
        ' ' +
        '         when 12 then ' +
        '           ''Date'' ' +
        ' ' +
        '         when 13 then ' +
        '           ''Time'' ' +
        ' ' +
        '         when 14 then ' +
        '           ''Char'' ' +
        ' ' +
        '         when 16 then ' +
        '           (case ' +
        '             RDB$FIELDS.RDB$FIELD_SUB_TYPE ' +
        '             when 1 then ' +
        '               ''Numeric'' ' +
        ' ' +
        '             when 2 then ' +
        '               ''Decimal'' ' +
        ' ' +
        '             else ' +
        '               ''Bigint'' ' +
        '           end) ' +
        ' ' +
        '         when 27 then ' +
        '           ''Double precision'' ' +
        ' ' +
        '         when 35 then ' +
        '           ''Timestamp'' ' +
        ' ' +
        '         when 37 then ' +
        '           ''Varchar'' ' +
        ' ' +
        '         when 40 then ' +
        '           ''Cstring'' ' +
        ' ' +
        '         when 45 then ' +
        '           ''Blob_Id'' ' +
        ' ' +
        '         when 261 then ' +
        '           ''Blob'' ' +
        ' ' +
        '         else ' +
        '           RDB$FIELDS.RDB$FIELD_TYPE||'' <?>'' ' +
        '       end) as FIELD_TYPE ' +
        ' ' +
        '     , iif( RDB$RELATION_FIELDS.RDB$NULL_FLAG = 1, 1, null ) as NOT_NULL ' +
        '     , RDB$FIELDS.RDB$OWNER_NAME as OWNER_NAME ' +
        '     , iif(  RDB$FIELDS.RDB$FIELD_TYPE = 261, abs( RDB$FIELDS.RDB$SEGMENT_LENGTH ), null  ) as SEGMENT_LENGTH ' +
        ' ' +
        '     , (case ' +
        '         RDB$FIELDS.RDB$FIELD_TYPE ' +
        '         when 7 then ' +
        '           (case ' +
        '             RDB$FIELDS.RDB$FIELD_SUB_TYPE ' +
        '             when 1 then ' +
        '               ''Numeric'' ' +
        ' ' +
        '             when 2 then ' +
        '               ''Decimal'' ' +
        ' ' +
        '             else ' +
        '               ''Smallint'' ' +
        '           end) ' +
        ' ' +
        '         when 8 then ' +
        '           (case ' +
        '             RDB$FIELDS.RDB$FIELD_SUB_TYPE ' +
        '             when 1 then ' +
        '               ''Numeric'' ' +
        ' ' +
        '             when 2 then ' +
        '               ''Decimal'' ' +
        ' ' +
        '             else ' +
        '               ''Integer'' ' +
        '           end) ' +
        ' ' +
        '         when 9 then ' +
        '           ''Quad'' ' +
        ' ' +
        '         when 10 then ' +
        '           ''Float'' ' +
        ' ' +
        '         when 12 then ' +
        '           ''Date'' ' +
        ' ' +
        '         when 13 then ' +
        '           ''Time'' ' +
        ' ' +
        '         when 14 then ' +
        '           ''Char'' ' +
        ' ' +
        '         when 16 then ' +
        '           (case ' +
        '             RDB$FIELDS.RDB$FIELD_SUB_TYPE ' +
        '             when 1 then ' +
        '               ''Numeric'' ' +
        ' ' +
        '             when 2 then ' +
        '               ''Decimal'' ' +
        ' ' +
        '             else ' +
        '               ''Bigint'' ' +
        '           end) ' +
        ' ' +
        '         when 27 then ' +
        '           ''Double precision'' ' +
        ' ' +
        '         when 35 then ' +
        '           ''Timestamp'' ' +
        ' ' +
        '         when 37 then ' +
        '           ''Varchar'' ' +
        ' ' +
        '         when 40 then ' +
        '           ''Cstring'' ' +
        ' ' +
        '         when 45 then ' +
        '           ''Blob_Id'' ' +
        ' ' +
        '         when 261 then ' +
        '           ''Blob'' ' +
        ' ' +
        '         else ' +
        '           RDB$FIELDS.RDB$FIELD_TYPE||'' <?>'' ' +
        '       end)|| ' +
        '       iif(   RDB$FIELDS.RDB$FIELD_TYPE in ( 37 ) or ( RDB$FIELDS.RDB$FIELD_TYPE in ( 7, 8, 16, 27 ) and RDB$FIELDS.RDB$FIELD_SUB_TYPE = 2  ), ''( ''||coalesce( RDB$FIELDS.RDB$CHARACTER_LENGTH, RDB$FIELDS.RDB$FIELD_PRECISION, '''' )||' +
          'iif(  RDB$FIELDS.RDB$FIELD_TYPE in ( 7, 8, 16 ) and RDB$FIELDS.RDB$FIELD_SUB_TYPE = 2 and RDB$FIELDS.RDB$FIELD_SCALE is not null, '', ''||cast(  abs( RDB$FIELDS.RDB$FIELD_SCALE ) as smallint  ), ''''  )||'' )'', ''''   )|| ' +
        '       cast(   substring(  coalesce( '' ''||RDB$RELATION_FIELDS.RDB$DEFAULT_SOURCE, '' ''||RDB$FIELDS.RDB$DEFAULT_SOURCE, '''' ) from 1 for 255  ) as varchar( 255 )   )|| ' +
        '       iif(  RDB$RELATION_FIELDS.RDB$NULL_FLAG = 1, '' not null'', trim( '''' )  )|| ' +
        '       coalesce(  '' collate ''||trim( RDB$COLLATIONS.RDB$COLLATION_NAME ), ''''  ) ' +
        '       as METADATA_LOG ' +
        ' ' +
        'from RDB$RELATION_FIELDS ' +
        'left join RDB$RELATIONS on RDB$RELATION_FIELDS.RDB$RELATION_NAME = RDB$RELATIONS.RDB$RELATION_NAME ' +
        'left join RDB$FIELDS on RDB$FIELDS.RDB$FIELD_NAME = RDB$RELATION_FIELDS.RDB$FIELD_SOURCE ' +
        'left join RDB$CHARACTER_SETS on RDB$CHARACTER_SETS.RDB$CHARACTER_SET_ID = RDB$FIELDS.RDB$CHARACTER_SET_ID ' +
        'left join RDB$COLLATIONS on RDB$COLLATIONS.RDB$COLLATION_ID = RDB$FIELDS.RDB$COLLATION_ID and RDB$COLLATIONS.RDB$CHARACTER_SET_ID = RDB$FIELDS.RDB$CHARACTER_SET_ID ' +
        'where RDB$RELATION_FIELDS.RDB$RELATION_NAME = :table_name ' +
        'order by RDB$RELATION_FIELDS.RDB$RELATION_NAME, RDB$RELATION_FIELDS.RDB$FIELD_POSITION ';

    end;

  metadata_sdbm.Query__Sql__Set( zts );


  if not values_logged_g then
    Log_Memo.Lines.Add( zts );


  metadata_sdbm.Query__Param_By_Name__Set( Common.name__table__small_letters_c, table_name__tmef_g, Log_Memo);

  try
    metadata_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_columns_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

        Screen.Cursor := crHourGlass;

      end;
  end;

  if metadata_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


      try
        metadata_sdbm.Query__Field_By_Name( metadata__column__base_collation_name_c ).AsString;
        metadata_sdbm.Query__Field_By_Name( metadata__column__character_set_name_c ).AsString;
        metadata_sdbm.Query__Field_By_Name( metadata__column__collation_name_c ).AsString;
        metadata_sdbm.Query__Field_By_Name( metadata__column__id_field_source_name_c ).AsString;
        metadata_sdbm.Query__Field_By_Name( metadata__column__length_c ).AsString;
        metadata_sdbm.Query__Field_By_Name( metadata__column__metadata_log_c ).AsString;
        metadata_sdbm.Query__Field_By_Name( metadata__column__not_null_c ).AsString;
        metadata_sdbm.Query__Field_By_Name( metadata__column__scale_c ).AsString;
        metadata_sdbm.Query__Field_By_Name( metadata__column__segment_length_c ).AsString;
        metadata_sdbm.Query__Field_By_Name( metadata__column__type_c ).AsString;
        metadata_sdbm.Query__Field_By_Name( Common.column_name__default_value_c ).AsString;
        metadata_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString;
        metadata_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
        metadata_sdbm.Query__Field_By_Name( Common.name__owner_name_c ).AsString;
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            metadata_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_columns + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            Screen.Cursor := crHourGlass;

          end;
      end;


      if metadata_sdbm.Query__Active() then
        begin

          if metadata_sdbm.component_type__sdbm = Common.TComponent_Type.ct_FireDAC then
            begin

              // FireDAC may not give total record count.

              metadata_sdbm.Query__Last();
              metadata_sdbm.Query__First();

            end;


          SetLength( metadata_log_t, metadata_sdbm.Query__Record_Count() );

          if Metadata_StringGrid.RowCount < metadata_sdbm.Query__Record_Count() + 1 then
            Metadata_StringGrid.RowCount := metadata_sdbm.Query__Record_Count() + 1;


          while not metadata_sdbm.Query__Eof() do
            begin

              // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

              metadata_log_t[ metadata_sdbm.Query__Record_Number() - 1 ] := Self.Quotation_Sign__TMeF() + Trim(  metadata_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString  ) + Self.Quotation_Sign__TMeF() + ' ' + metadata_sdbm.Query__Field_By_Name( metadata__column__metadata_log_c ).AsString;


              Metadata_StringGrid.Cells[ metadata__column_number__no_c, metadata_sdbm.Query__Record_Number() ] := Trim(  FormatFloat( '### ### ### ### ### ### ##0', metadata_sdbm.Query__Record_Number() )  );
              Metadata_StringGrid.Cells[ metadata__column_number__name_c, metadata_sdbm.Query__Record_Number() ] := Trim(  metadata_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString  );
              Metadata_StringGrid.Cells[ metadata__column_number__type_c, metadata_sdbm.Query__Record_Number() ] := Trim(  metadata_sdbm.Query__Field_By_Name( metadata__column__type_c ).AsString  );


              zts := Trim(  FormatFloat( '### ### ### ### ### ### ##0', metadata_sdbm.Query__Field_By_Name( metadata__column__length_c ).AsInteger )  );

              if not metadata_sdbm.Query__Field_By_Name( metadata__column__scale_c ).IsNull then
                zts := zts + ', ' +
                Trim(  FormatFloat( '### ### ### ### ### ### ##0', metadata_sdbm.Query__Field_By_Name( metadata__column__scale_c ).AsInteger )  );

              Metadata_StringGrid.Cells[ metadata__column_number__length_c, metadata_sdbm.Query__Record_Number() ] := zts;


              if metadata_sdbm.Query__Field_By_Name( metadata__column__not_null_c ).IsNull then
                zts := Common.db_grid__positive_value_c
              else
                zts := '';

              Metadata_StringGrid.Cells[ metadata__column_number__allow_nulls_c, metadata_sdbm.Query__Record_Number() ] := zts;


              Metadata_StringGrid.Cells[ metadata__column_number__default_c, metadata_sdbm.Query__Record_Number() ] := Trim(  metadata_sdbm.Query__Field_By_Name( Common.column_name__default_value_c ).AsString  );
              Metadata_StringGrid.Cells[ metadata__column_number__character_set_c, metadata_sdbm.Query__Record_Number() ] := Trim(  metadata_sdbm.Query__Field_By_Name( metadata__column__character_set_name_c ).AsString  );
              Metadata_StringGrid.Cells[ metadata__column_number__collation_c, metadata_sdbm.Query__Record_Number() ] := Trim(  metadata_sdbm.Query__Field_By_Name( metadata__column__base_collation_name_c ).AsString + ' ' + metadata_sdbm.Query__Field_By_Name( metadata__column__collation_name_c ).AsString  );
              Metadata_StringGrid.Cells[ metadata__column_number__segment_length_c, metadata_sdbm.Query__Record_Number() ] := Trim(  metadata_sdbm.Query__Field_By_Name( metadata__column__segment_length_c ).AsString  );
              Metadata_StringGrid.Cells[ metadata__column_number__owner_c, metadata_sdbm.Query__Record_Number() ] := Trim(  metadata_sdbm.Query__Field_By_Name( Common.name__owner_name_c ).AsString  );
              Metadata_StringGrid.Cells[ metadata__column_number__id_name_c, metadata_sdbm.Query__Record_Number() ] := Trim(  metadata_sdbm.Query__Field_By_Name( metadata__column__id_field_source_name_c ).AsString  );
              Metadata_StringGrid.Cells[ metadata__column_number__description_c, metadata_sdbm.Query__Record_Number() ] := metadata_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;

              if    ( not primary_key__unknown_g )
                and ( Metadata_StringGrid.Cells[ metadata__column_number__name_c, metadata_sdbm.Query__Record_Number() ] = primary_key__name_g ) then
                Metadata_StringGrid.Cells[ metadata__column_number__primary_key_c, metadata_sdbm.Query__Record_Number() ] := Common.db_grid__positive_value_c;


              metadata_sdbm.Query__Next();

            end;


          Self.Translation__Apply__TMeF( Translation.tak_Grid );

        end;

    end;

  if metadata_sdbm.Query__Active() then
    metadata_sdbm.Query__Close();

  metadata_sdbm.Query__Sql__Set( '' );


  if not values_logged_g then
    begin

      if not primary_key__unknown_g then
        zts := primary_key__name_g
      else
        zts := Translation.translation__messages_r.word__none;


      Log_Memo.Lines.Add( Translation.translation__messages_r.word__primary_key + ': ' + zts + '.' );

    end;


  if not values_logged_g then
    values_logged_g := true;


  Screen.Cursor := crDefault;

end;

procedure TTable__Metadata_F_Frame.Finish__TMeF();
begin

  SetLength( metadata_log_t, 0 );


  Free_All__Table_Column__Values_Distinct();
  FreeAndNil( table_column__values_distinct_form_list__tmef_g );


  FreeAndNil( metadata_sdbm );

end;

procedure TTable__Metadata_F_Frame.Free_All__Table_Column__Values_Distinct();
var
  i : integer;
begin

  if   ( table_column__values_distinct_form_list__tmef_g = nil )
    or (  not Assigned( table_column__values_distinct_form_list__tmef_g )  ) then
    Exit;


  for i := table_column__values_distinct_form_list__tmef_g.Count - 1 downto 0 do
    begin

      Table_Column__Values_Distinct.TTable_Column__Values_Distinct_Form(table_column__values_distinct_form_list__tmef_g[ i ]).Free();
      table_column__values_distinct_form_list__tmef_g.Delete( i );

    end;

end;

procedure TTable__Metadata_F_Frame.Highlight__Font__Set__TMeF();
begin

  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Table_Description_Memo.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    Common.Font__Set( Metadata_StringGrid.Font, Common.sql_editor__font );

end;

procedure TTable__Metadata_F_Frame.Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );
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

procedure TTable__Metadata_F_Frame.Options_Set__TMeF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const queries_open_in_background_f, sql__quotation_sign__use_f : boolean );
begin

  queries_open_in_background_g := queries_open_in_background_f;
  sql__quotation_sign__use__tmef_g := sql__quotation_sign__use_f;
  sql__quotation_sign__tmef_g := sql__quotation_sign_f;


  if metadata_sdbm <> nil then
    begin

      metadata_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

    end;


  Self.Translation__Apply__TMeF( Translation.tak_Self );

end;

procedure TTable__Metadata_F_Frame.Parent_Tab_Switch( const prior_f : boolean = false );
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

procedure TTable__Metadata_F_Frame.Prepare__TMeF( const table_name_f, database_type_f, sql__quotation_sign_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const queries_open_in_background_f, sql__quotation_sign__use_f : boolean );
var
  zts : string;
begin

  Self.Name := '';

  database_type__tmef_g := database_type_f;
  primary_key__name_g := '';
  primary_key__unknown_g := true;
  queries_open_in_background_g := queries_open_in_background_f;
  table_name__tmef_g := table_name_f;
  values_logged_g := false;


  Log_Memo.Lines.Add( table_name__tmef_g );


  table_column__values_distinct_form_list__tmef_g := TList.Create();

  metadata_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Self.Options_Set__TMeF( component_type_f, sql__quotation_sign_f, queries_open_in_background_f, sql__quotation_sign__use_f );


  sql__table__create_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + Common.table_add__sql__table__create__file_name_c  );

  if Trim( sql__table__create_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + Common.table_add__sql__table__create__file_name_c + ').' );

      sql__table__create_g :=
        'create table __TABLE_NAME__ ' +
        '  ( ' +
        '__COLUMN_NAME__ ' +
        '__PRIMARY_KEY__ ' +
        '  ) ';

    end;


  sql__table__primary_key_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + Common.table_add__sql__primary_key__file_name_c  );

  if Trim( sql__table__primary_key_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + Common.table_add__sql__primary_key__file_name_c + ').' );

      sql__table__primary_key_g :=
        #13 + '    , primary key ( __COLUMN_NAME__ )';

    end;


  zts := Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + Common.table_add__sql__column__columns_separator__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + Common.table_add__sql__column__columns_separator__file_name_c + ').' );

      word__columns_separator__tmef_g := #13 + #10 + '    , ';

    end
  else
    begin

      word__columns_separator__tmef_g := Common.Text__File_Load( zts );

      word__columns_separator__tmef_g := StringReplace( word__columns_separator__tmef_g, #10, '', [] );
      word__columns_separator__tmef_g := StringReplace( word__columns_separator__tmef_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Columns separator: ' + word__columns_separator__tmef_g + '.' );


  Highlight__Font__Set__TMeF();

end;

function TTable__Metadata_F_Frame.Quotation_Sign__TMeF() : string;
begin

  if sql__quotation_sign__use__tmef_g then
    begin

      Result := sql__quotation_sign__tmef_g;

    end
  else
    Result := '';

end;

function TTable__Metadata_F_Frame.Task_Running_Check__TMeF( const message_show_f : boolean = true ) : boolean;
var
  i : integer;
begin

  Result := false;


  if   ( table_column__values_distinct_form_list__tmef_g = nil )
    or (  not Assigned( table_column__values_distinct_form_list__tmef_g )  ) then
    Exit;


  for i := 0 to table_column__values_distinct_form_list__tmef_g.Count - 1 do
    if Table_Column__Values_Distinct.TTable_Column__Values_Distinct_Form(table_column__values_distinct_form_list__tmef_g[ i ]).Task_Running_Check__TCVD( message_show_f ) then
      begin

        Result := true;
        Break;

      end;


  if    ( Result )
    and ( message_show_f ) then
    Application.MessageBox( PChar(Translation.translation__messages_r.task_is_still_running_wait_until_finish), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );

end;

procedure TTable__Metadata_F_Frame.Translation__Apply__TMeF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
begin

  if tak_f in [ Translation.tak_All, Translation.tak_Self ] then
    Translation.Translation__Apply( Self );


  if tak_f in [ Translation.tak_All, Translation.tak_Grid ] then
    begin

      Metadata_StringGrid.Cells[ metadata__column_number__no_c, 0 ] := Translation.translation__messages_r.word__no_;
      Metadata_StringGrid.Cells[ metadata__column_number__name_c, 0 ] := Translation.translation__messages_r.word__column__name;
      Metadata_StringGrid.Cells[ metadata__column_number__type_c, 0 ] := Translation.translation__messages_r.word__type;
      Metadata_StringGrid.Cells[ metadata__column_number__length_c, 0 ] := Translation.translation__messages_r.word__length;
      Metadata_StringGrid.Cells[ metadata__column_number__allow_nulls_c, 0 ] := Translation.translation__messages_r.word__allow_nulls;
      Metadata_StringGrid.Cells[ metadata__column_number__default_c, 0 ] := Translation.translation__messages_r.word__default__value;
      Metadata_StringGrid.Cells[ metadata__column_number__character_set_c, 0 ] := Translation.translation__messages_r.word__character_set;
      Metadata_StringGrid.Cells[ metadata__column_number__collation_c, 0 ] := Translation.translation__messages_r.word__collation__with_a_capital_letter;
      Metadata_StringGrid.Cells[ metadata__column_number__segment_length_c, 0 ] := Translation.translation__messages_r.word__segment_length;
      Metadata_StringGrid.Cells[ metadata__column_number__owner_c, 0 ] := Translation.translation__messages_r.word__owner;
      Metadata_StringGrid.Cells[ metadata__column_number__id_name_c, 0 ] := Translation.translation__messages_r.word__id_name;
      Metadata_StringGrid.Cells[ metadata__column_number__description_c, 0 ] := Translation.translation__messages_r.word__description;
      Metadata_StringGrid.Cells[ metadata__column_number__primary_key_c, 0 ] := Translation.translation__messages_r.word__primary_key;

    end;

end;

procedure TTable__Metadata_F_Frame.Refresh_ButtonClick( Sender: TObject );
var
  col_number_copy,
  row_number_copy
    : integer;
begin

  col_number_copy := Metadata_StringGrid.Col;
  row_number_copy := Metadata_StringGrid.Row;


  Self.Data_Open__TMeF();


  if    ( col_number_copy > 0 )
    and ( col_number_copy < Metadata_StringGrid.ColCount ) then
    Metadata_StringGrid.Col := col_number_copy;

  if    ( row_number_copy > 0 )
    and ( row_number_copy < Metadata_StringGrid.RowCount ) then
    Metadata_StringGrid.Row := row_number_copy
  else
    if    ( row_number_copy > 0 )
      and ( Metadata_StringGrid.RowCount > 1 ) then
      Metadata_StringGrid.Row := Metadata_StringGrid.RowCount - 1;

end;

procedure TTable__Metadata_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Buttons_Panel.Width := 1;

end;

procedure TTable__Metadata_F_Frame.Owner_Etiquette_LabelDblClick( Sender: TObject );
begin

  Vcl.Clipbrd.Clipboard.AsText := table_name__tmef_g;

end;

procedure TTable__Metadata_F_Frame.Owner_LabelDblClick( Sender: TObject );
begin

  Vcl.Clipbrd.Clipboard.AsText := Owner_Label.Caption;

end;

procedure TTable__Metadata_F_Frame.Search_Change( Sender: TObject );
var
  col_l,
  row_l
    : integer;
begin

  for col_l := Metadata_StringGrid.FixedCols to Metadata_StringGrid.ColCount - 1 do
    for row_l := Metadata_StringGrid.FixedRows to Metadata_StringGrid.RowCount - 1 do
      if   (
                 ( Search__Partial_Key_CheckBox.Checked )
             and (   Pos(  Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String( Metadata_StringGrid.Cells[ col_l, row_l ], Search__Case_Insensitive_CheckBox.Checked )  ) > 0   )
           )
        or (
                 ( not Search__Partial_Key_CheckBox.Checked )
             and (  Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ) = Common.Case_Insensitive_To_String( Metadata_StringGrid.Cells[ col_l, row_l ], Search__Case_Insensitive_CheckBox.Checked )  )
           ) then
        begin

          Metadata_StringGrid.Col := col_l;
          Metadata_StringGrid.Row := row_l;

          Exit;

        end;

end;

procedure TTable__Metadata_F_Frame.Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_PRIOR then
    Search__Prior_ButtonClick( Sender )
  else
  if Key = VK_NEXT then
    Search__Next_ButtonClick( Sender );

end;

procedure TTable__Metadata_F_Frame.Search__Next_ButtonClick( Sender: TObject );
var
  col_l,
  col__focused_l,
  row_l,
  row__focused_l
    : integer;
begin

  col__focused_l := Metadata_StringGrid.Col;
  row__focused_l := Metadata_StringGrid.Row;


  for col_l := Metadata_StringGrid.FixedCols to Metadata_StringGrid.ColCount - 1 do
    for row_l := Metadata_StringGrid.FixedRows to Metadata_StringGrid.RowCount - 1 do
      if    (
                 ( col_l > col__focused_l )
              or (
                       ( col_l = col__focused_l )
                   and ( row_l > row__focused_l )
                 )
            )
        and (
               (
                       ( Search__Partial_Key_CheckBox.Checked )
                   and (   Pos(  Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String( Metadata_StringGrid.Cells[ col_l, row_l ], Search__Case_Insensitive_CheckBox.Checked )  ) > 0   )
                 )
              or (
                       ( not Search__Partial_Key_CheckBox.Checked )
                   and (  Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ) = Common.Case_Insensitive_To_String( Metadata_StringGrid.Cells[ col_l, row_l ], Search__Case_Insensitive_CheckBox.Checked )  )
                 )
            ) then
        begin

          Metadata_StringGrid.Col := col_l;
          Metadata_StringGrid.Row := row_l;

          Exit;

        end;

end;

procedure TTable__Metadata_F_Frame.Search__Prior_ButtonClick( Sender: TObject );
var
  col_l,
  col__focused_l,
  row_l,
  row__focused_l
    : integer;
begin

  col__focused_l := Metadata_StringGrid.Col;
  row__focused_l := Metadata_StringGrid.Row;


  for col_l := Metadata_StringGrid.ColCount - 1 downto Metadata_StringGrid.FixedCols do
    for row_l := Metadata_StringGrid.RowCount - 1 downto Metadata_StringGrid.FixedRows do
      if    (
                 ( col_l < col__focused_l )
              or (
                       ( col_l = col__focused_l )
                   and ( row_l < row__focused_l )
                 )
            )
        and (
               (
                       ( Search__Partial_Key_CheckBox.Checked )
                   and (   Pos(  Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String( Metadata_StringGrid.Cells[ col_l, row_l ], Search__Case_Insensitive_CheckBox.Checked )  ) > 0   )
                 )
              or (
                       ( not Search__Partial_Key_CheckBox.Checked )
                   and (  Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ) = Common.Case_Insensitive_To_String( Metadata_StringGrid.Cells[ col_l, row_l ], Search__Case_Insensitive_CheckBox.Checked )  )
                 )
            ) then
        begin

          Metadata_StringGrid.Col := col_l;
          Metadata_StringGrid.Row := row_l;

          Exit;

        end;

end;

procedure TTable__Metadata_F_Frame.Column__Add_MenuItemClick( Sender: TObject );
var
  ztb,
  modified_l
    : boolean;

  zti,
  row_l
    : integer;
begin

  if Metadata_StringGrid.Row < 1 then
    Exit;


  Table_Column__Modify.Table_Column__Modify_Form := Table_Column__Modify.TTable_Column__Modify_Form.Create( Application, metadata_sdbm );
  Table_Column__Modify.Table_Column__Modify_Form.database_type__tcm := database_type__tmef_g;
  Table_Column__Modify.Table_Column__Modify_Form.sql__quotation_sign__tcm := sql__quotation_sign__tmef_g;
  Table_Column__Modify.Table_Column__Modify_Form.sql__quotation_sign__use__tcm := sql__quotation_sign__use__tmef_g;
  Table_Column__Modify.Table_Column__Modify_Form.table_name__tcm := table_name__tmef_g;

  if    ( Sender <> nil )
    and ( Sender = Column__Type_Edit_MenuItem ) then
    begin

      Table_Column__Modify.Table_Column__Modify_Form.column__name__tcm := Metadata_StringGrid.Cells[ metadata__column_number__name_c, Metadata_StringGrid.Row ];
      Table_Column__Modify.Table_Column__Modify_Form.column__position__tcm := StrToIntDef( Metadata_StringGrid.Cells[ metadata__column_number__no_c, Metadata_StringGrid.Row ], 1 );
      Table_Column__Modify.Table_Column__Modify_Form.column__type__tcm := Metadata_StringGrid.Cells[ metadata__column_number__type_c, Metadata_StringGrid.Row ];

      if Metadata_StringGrid.Cells[ metadata__column_number__length_c, Metadata_StringGrid.Row ] <> '0' then
        Table_Column__Modify.Table_Column__Modify_Form.column__type__tcm := Table_Column__Modify.Table_Column__Modify_Form.column__type__tcm +
          ' ( ' +
          Metadata_StringGrid.Cells[ metadata__column_number__length_c, Metadata_StringGrid.Row ] +
          ' )';

      Table_Column__Modify.Table_Column__Modify_Form.type_edit__tcm := true;

    end
  else
    Table_Column__Modify.Table_Column__Modify_Form.column__position__tcm := Metadata_StringGrid.RowCount;

  Table_Column__Modify.Table_Column__Modify_Form.ShowModal();

  modified_l := Table_Column__Modify.Table_Column__Modify_Form.modified__tcm;

  if modified_l then
    zti := Table_Column__Modify.Table_Column__Modify_Form.column__position__out__tcm
  else
    zti := -99;

  FreeAndNil( Table_Column__Modify.Table_Column__Modify_Form );


  if modified_l then
    begin

      Refresh_ButtonClick( Sender );


      if    ( zti <> -99 )
        and (  IntToStr( zti ) <> Metadata_StringGrid.Cells[ metadata__column_number__no_c, Metadata_StringGrid.Row ]  ) then
        begin

          ztb := false;

          for row_l := Metadata_StringGrid.FixedRows to Metadata_StringGrid.RowCount - 1 do
            if IntToStr( zti ) = Metadata_StringGrid.Cells[ metadata__column_number__no_c, row_l ] then
              begin

                Metadata_StringGrid.Row := row_l;

                ztb := true;

                Break;

              end;


          if not ztb then
            Metadata_StringGrid.Row := Metadata_StringGrid.RowCount - 1;

        end;

    end;

end;

procedure TTable__Metadata_F_Frame.Column__Delete_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  column_name_l,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if Metadata_StringGrid.Row < 1 then
    Exit;


  column_name_l := Self.Quotation_Sign__TMeF() + Metadata_StringGrid.Cells[ metadata__column_number__name_c, Metadata_StringGrid.Row ] + Self.Quotation_Sign__TMeF();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__column__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__column__drop__file_name_c + ').' );

      zts :=
        'alter table ' +
        Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() +
        ' drop ' +
        column_name_l +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, column_name_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_column + ' ''' + Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() + Common.sql__names_separator + column_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := metadata_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_column );


  if ztb then
    begin

      Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Metadata_F_Frame.Column__Name_Edit_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  modal_result : TModalResult;

  zts,
  column_name_l,
  column_name__new_l,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if Metadata_StringGrid.Row < 1 then
    Exit;


  Text__Edit_Memo.Text__Edit_Memo_Form := Text__Edit_Memo.TText__Edit_Memo_Form.Create( Application );
  Text__Edit_Memo.Text__Edit_Memo_Form.text_value := Metadata_StringGrid.Cells[ metadata__column_number__name_c, Metadata_StringGrid.Row ];
  Text__Edit_Memo.Text__Edit_Memo_Form.quotation_mark_duplicate := false;
  Text__Edit_Memo.Text__Edit_Memo_Form.Caption := Translation.translation__messages_r.word__column__name;
  Text__Edit_Memo.Text__Edit_Memo_Form.Text_Type_Set( Text__Edit_Memo.tt_Edit );
  modal_result := Text__Edit_Memo.Text__Edit_Memo_Form.ShowModal();

  if modal_result = mrOk then
    column_name__new_l := Text__Edit_Memo.Text__Edit_Memo_Form.text_value;

  FreeAndNil( Text__Edit_Memo.Text__Edit_Memo_Form );


  column_name_l := Self.Quotation_Sign__TMeF() + Metadata_StringGrid.Cells[ metadata__column_number__name_c, Metadata_StringGrid.Row ] + Self.Quotation_Sign__TMeF();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__name__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__name__set__file_name_c + ').' );

      zts :=
        'alter table ' +
        Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() +
        ' alter ' +
        column_name_l +
        ' to ' + Self.Quotation_Sign__TMeF() + column_name__new_l + Self.Quotation_Sign__TMeF() + ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, column_name_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF(), [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + metadata__column__name_new_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TMeF() + column_name__new_l + Self.Quotation_Sign__TMeF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if modal_result <> mrOk then
    Exit;


  ztb := metadata_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_column_new_name );


  if ztb then
    begin

      Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Metadata_F_Frame.Column__Type_Edit_MenuItemClick( Sender: TObject );
begin

  if Metadata_StringGrid.Row < 1 then
    Exit;


  Column__Add_MenuItemClick( Sender );

end;

procedure TTable__Metadata_F_Frame.Column__Default_Value__Set_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  modal_result : TModalResult;

  zts,
  column_name_l,
  default_value_l,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if Metadata_StringGrid.Row < 1 then
    Exit;


  Text__Edit_Memo.Text__Edit_Memo_Form := Text__Edit_Memo.TText__Edit_Memo_Form.Create( Application );
  Text__Edit_Memo.Text__Edit_Memo_Form.text_value := Metadata_StringGrid.Cells[ metadata__column_number__default_c, Metadata_StringGrid.Row ];

  if default_replace_g <> '' then
    Text__Edit_Memo.Text__Edit_Memo_Form.text_value := StringReplace( Text__Edit_Memo.Text__Edit_Memo_Form.text_value, default_replace_g, '', [ rfReplaceAll ] );

  Text__Edit_Memo.Text__Edit_Memo_Form.quotation_mark_duplicate := false;
  Text__Edit_Memo.Text__Edit_Memo_Form.Caption := Translation.translation__messages_r.word__default__value;

  Text__Edit_Memo.Text__Edit_Memo_Form.hint_ := Translation.translation__messages_r.text__edit_memo__text__edit_memo_form__hint_;

  Text__Edit_Memo.Text__Edit_Memo_Form.Text_Type_Set( Text__Edit_Memo.tt_Edit );
  modal_result := Text__Edit_Memo.Text__Edit_Memo_Form.ShowModal();

  if modal_result = mrOk then
    default_value_l := Text__Edit_Memo.Text__Edit_Memo_Form.text_value;

  FreeAndNil( Text__Edit_Memo.Text__Edit_Memo_Form );


  column_name_l := Self.Quotation_Sign__TMeF() + Metadata_StringGrid.Cells[ metadata__column_number__name_c, Metadata_StringGrid.Row ] + Self.Quotation_Sign__TMeF();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__default_value__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__default_value__set__file_name_c + ').' );

      zts :=
        'alter table ' +
        Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() +
        ' alter ' +
        column_name_l +
        ' set default ' + default_value_l + ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, column_name_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF(), [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + metadata__default_value_c + Common.sql__word_replace_separator_c, default_value_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if modal_result <> mrOk then
    Exit;


  ztb := metadata_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_column_default_value );


  if ztb then
    begin

      Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Metadata_F_Frame.Column__Default_Value__Drop_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  column_name_l,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if Metadata_StringGrid.Row < 1 then
    Exit;


  column_name_l := Self.Quotation_Sign__TMeF() + Metadata_StringGrid.Cells[ metadata__column_number__name_c, Metadata_StringGrid.Row ] + Self.Quotation_Sign__TMeF();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__default_value__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__default_value__drop__file_name_c + ').' );

      zts :=
        'alter table ' +
        Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() +
        ' alter ' +
        column_name_l +
        ' drop default ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, column_name_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_column_default_value + ' ''' + Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() + Common.sql__names_separator + column_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := metadata_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_column_default_value );


  if ztb then
    begin

      Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Metadata_F_Frame.Column__Description__Set_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  modal_result : TModalResult;

  zts,
  description_value_l,
  error_message_l,
  table_column_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if Metadata_StringGrid.Row < 1 then
    Exit;


  Text__Edit_Memo.Text__Edit_Memo_Form := Text__Edit_Memo.TText__Edit_Memo_Form.Create( Application );
  Text__Edit_Memo.Text__Edit_Memo_Form.text_value := Metadata_StringGrid.Cells[ metadata__column_number__description_c, Metadata_StringGrid.Row ];
  Text__Edit_Memo.Text__Edit_Memo_Form.quotation_mark_duplicate := true;
  Text__Edit_Memo.Text__Edit_Memo_Form.Caption := Translation.translation__messages_r.word__description___column;
  Text__Edit_Memo.Text__Edit_Memo_Form.Text_Type_Set( Text__Edit_Memo.tt_Memo );
  modal_result := Text__Edit_Memo.Text__Edit_Memo_Form.ShowModal();

  if modal_result = mrOk then
    description_value_l := Text__Edit_Memo.Text__Edit_Memo_Form.text_value;

  FreeAndNil( Text__Edit_Memo.Text__Edit_Memo_Form );


  table_column_name_l := Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() + Common.sql__names_separator + Self.Quotation_Sign__TMeF() + Metadata_StringGrid.Cells[ metadata__column_number__name_c, Metadata_StringGrid.Row ] + Self.Quotation_Sign__TMeF();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__description__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__description__set__file_name_c + ').' );

      zts :=
        'comment on column ' +
        table_column_name_l +
        ' is ''' + description_value_l + ''' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + metadata__table__column_name_c + Common.sql__word_replace_separator_c, table_column_name_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if modal_result <> mrOk then
    Exit;


  ztb := metadata_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_column_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Metadata_F_Frame.Column__Description__Drop_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l,
  table_column_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if Metadata_StringGrid.Row < 1 then
    Exit;


  table_column_name_l := Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() + Common.sql__names_separator + Self.Quotation_Sign__TMeF() + Metadata_StringGrid.Cells[ metadata__column_number__name_c, Metadata_StringGrid.Row ] + Self.Quotation_Sign__TMeF();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__description__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__description__drop__file_name_c + ').' );

      zts :=
        'comment on column ' +
        table_column_name_l +
        ' is null ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + metadata__table__column_name_c + Common.sql__word_replace_separator_c, table_column_name_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_column_description + ' ''' + table_column_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := metadata_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_column_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Metadata_F_Frame.Column__Description__Write_In_Log_MenuItemClick( Sender: TObject );
begin

  if Metadata_StringGrid.Row < 1 then
    Exit;

  Log_Memo.Lines.Add( '' );
  Log_Memo.Lines.Add( Metadata_StringGrid.Cells[ metadata__column_number__description_c, Metadata_StringGrid.Row ] );

end;

procedure TTable__Metadata_F_Frame.Column__Not_Null__Add_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  column_name_l,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if Metadata_StringGrid.Row < 1 then
    Exit;


  column_name_l := Self.Quotation_Sign__TMeF() + Metadata_StringGrid.Cells[ metadata__column_number__name_c, Metadata_StringGrid.Row ] + Self.Quotation_Sign__TMeF();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__not_null__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__not_null__set__file_name_c + ').' );

      zts :=
        'alter table ' +
        Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() +
        ' alter ' +
        column_name_l +
        ' set not null ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, column_name_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_add_the_column_not_null_attribute + ' ''' + Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() + Common.sql__names_separator + column_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := metadata_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_add_the_column_not_null_attribute );


  if ztb then
    begin

      Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Metadata_F_Frame.Column__Not_Null__Delete_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  column_name_l,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if Metadata_StringGrid.Row < 1 then
    Exit;


  column_name_l := Self.Quotation_Sign__TMeF() + Metadata_StringGrid.Cells[ metadata__column_number__name_c, Metadata_StringGrid.Row ] + Self.Quotation_Sign__TMeF();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__not_null__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__not_null__drop__file_name_c + ').' );

      zts :=
        'alter table ' +
        Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() +
        ' alter ' +
        column_name_l +
        ' drop not null ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, column_name_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_column_not_null_attribute + ' ''' + Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() + Common.sql__names_separator + column_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := metadata_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_column_not_null_attribute );


  if ztb then
    begin

      Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Metadata_F_Frame.Table__Description__Set_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  modal_result : TModalResult;

  zts,
  description_value_l,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if Metadata_StringGrid.Row < 1 then
    Exit;


  Text__Edit_Memo.Text__Edit_Memo_Form := Text__Edit_Memo.TText__Edit_Memo_Form.Create( Application );
  Text__Edit_Memo.Text__Edit_Memo_Form.text_value := Table_Description_Memo.Lines.Text;
  Text__Edit_Memo.Text__Edit_Memo_Form.quotation_mark_duplicate := true;
  Text__Edit_Memo.Text__Edit_Memo_Form.Caption := Translation.translation__messages_r.word__description___table;
  Text__Edit_Memo.Text__Edit_Memo_Form.Text_Type_Set( Text__Edit_Memo.tt_Memo );
  modal_result := Text__Edit_Memo.Text__Edit_Memo_Form.ShowModal();

  if modal_result = mrOk then
    description_value_l := Text__Edit_Memo.Text__Edit_Memo_Form.text_value;

  FreeAndNil( Text__Edit_Memo.Text__Edit_Memo_Form );


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__table__sql__description__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__table__sql__description__set__file_name_c + ').' );

      zts :=
        'comment on table ' +
        Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() +
        ' is ''' + description_value_l + ''' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF(), [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if modal_result <> mrOk then
    Exit;


  ztb := metadata_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_table_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Metadata_F_Frame.Table__Description__Drop_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if Metadata_StringGrid.Row < 1 then
    Exit;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__table__sql__description__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__table__sql__description__drop__file_name_c + ').' );

      zts :=
        'comment on table ' +
        Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() +
        ' is null ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_table_description + ' ''' + Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := metadata_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_table_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Metadata_F_Frame.Table__Primary_Key_Set_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  column_name_l,
  error_message_l
    : string;
begin

  // Do not work.

  // Parameters in SQL commands do not work here.

  if Metadata_StringGrid.Row < 1 then
    Exit;


  column_name_l := Self.Quotation_Sign__TMeF() + Metadata_StringGrid.Cells[ metadata__column_number__name_c, Metadata_StringGrid.Row ] + Self.Quotation_Sign__TMeF();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__primary_key__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tmef_g ) + metadata__column__sql__primary_key__set__file_name_c + ').' );

      zts :=
        'alter table ' +
        Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() +
        ' add primary key ( ' +
        column_name_l +
        ' ) ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, column_name_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.set_the_column_primary_key_attribute + ' ''' + Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() + Common.sql__names_separator + column_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := metadata_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_column_primary_key_attribute );


  if ztb then
    begin

      Log_Memo.Lines.Add( metadata_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Metadata_F_Frame.Metadata__Write_In_Log_MenuItemClick( Sender: TObject );
var
  i : integer;

  zts : string;
begin

  Log_Memo.Lines.Add( '' );
  Log_Memo.Lines.Add( Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() );
  Log_Memo.Lines.Add( Self.Quotation_Sign__TMeF() + primary_key__name_g + Self.Quotation_Sign__TMeF() );

  zts := '';

  for i := 0 to Length( metadata_log_t ) - 1 do
    zts := zts +
      metadata_log_t[ i ] + word__columns_separator__tmef_g;

  Log_Memo.Lines.Add( zts );

end;

procedure TTable__Metadata_F_Frame.Metadata__Write_In_Log__As_Create_Table_MenuItemClick( Sender: TObject );
var
  i : integer;

  zts,
  columns_list_l,
  primary_key_l
    : string;
begin

  Log_Memo.Lines.Add( '' );

  columns_list_l := '';

  for i := 0 to Length( metadata_log_t ) - 1 do
    begin

      if i > 0 then
        columns_list_l := columns_list_l +
          word__columns_separator__tmef_g;


      columns_list_l := columns_list_l +
        metadata_log_t[ i ];

    end;


  if not primary_key__unknown_g then
    begin

      primary_key_l := sql__table__primary_key_g;
      primary_key_l := StringReplace( primary_key_l, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TMeF() + primary_key__name_g + Self.Quotation_Sign__TMeF(), [ rfReplaceAll ] );

    end
  else
    primary_key_l := '';


  zts := sql__table__create_g;

  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TMeF() + table_name__tmef_g + Self.Quotation_Sign__TMeF() , [ rfReplaceAll ] );
  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, columns_list_l, [ rfReplaceAll ] );
  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.table_add__primary_key_c + Common.sql__word_replace_separator_c, primary_key_l, [ rfReplaceAll ] );

  Log_Memo.Lines.Add( zts );

end;

procedure TTable__Metadata_F_Frame.Table_Column__Values_Distinct_MenuItemClick( Sender: TObject );
var
  table_column__values_distinct_form_l : Table_Column__Values_Distinct.TTable_Column__Values_Distinct_Form;
begin

  if Metadata_StringGrid.Row < 1 then
    Exit;


  if   ( table_column__values_distinct_form_list__tmef_g = nil )
    or (  not Assigned( table_column__values_distinct_form_list__tmef_g )  ) then
    Exit;


  table_column__values_distinct_form_l := Table_Column__Values_Distinct.TTable_Column__Values_Distinct_Form.Create( Application, metadata_sdbm );
  table_column__values_distinct_form_l.column_name__tcvd := Metadata_StringGrid.Cells[ metadata__column_number__name_c, Metadata_StringGrid.Row ];
  table_column__values_distinct_form_l.database_type__tcvd := database_type__tmef_g;
  table_column__values_distinct_form_l.sql__quotation_sign__tcvd := sql__quotation_sign__tmef_g;
  table_column__values_distinct_form_l.sql__quotation_sign__use__tcvd := sql__quotation_sign__use__tmef_g;
  table_column__values_distinct_form_l.table_name__tcvd := table_name__tmef_g;
  table_column__values_distinct_form_l.queries_open_in_background_g := queries_open_in_background_g;
  table_column__values_distinct_form_l.table_column__values_distinct_form_list := table_column__values_distinct_form_list__tmef_g;
  table_column__values_distinct_form_l.Show();


  table_column__values_distinct_form_list__tmef_g.Add( table_column__values_distinct_form_l );

end;

procedure TTable__Metadata_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TTable__Metadata_F_Frame.Table_Description_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Table_Description_Memo.SelectAll();

end;

procedure TTable__Metadata_F_Frame.Metadata_StringGridDrawCell( Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState );
begin

  if    ( ACol in [ metadata__column_number__allow_nulls_c ] )
    and ( ARow > 0 )
    and (  Trim( TStringGrid(Sender).Cells[ metadata__column_number__allow_nulls_c, ARow ] ) <> ''  ) then
    begin

      if TStringGrid(Sender).Cells[ metadata__column_number__allow_nulls_c, ARow ] = Common.db_grid__positive_value_c then
        TStringGrid(Sender).Canvas.Brush.Color := clInfoBk;

      TStringGrid(Sender).Canvas.FillRect( Rect );
      TStringGrid(Sender).Canvas.TextOut(   Rect.Left + 2, Rect.Top + Round( Rect.Height * 0.5 ) - Round(  TStringGrid(Sender).Canvas.TextHeight( 'I' ) * 0.5  ), TStringGrid(Sender).Cells[ ACol, ARow ]   );

    end;


  if    ( ACol in [ metadata__column_number__primary_key_c ] )
    and ( ARow > 0 )
    and (  Trim( TStringGrid(Sender).Cells[ metadata__column_number__primary_key_c, ARow ] ) <> ''  ) then
    begin

      if TStringGrid(Sender).Cells[ metadata__column_number__primary_key_c, ARow ] = Common.db_grid__positive_value_c then
        TStringGrid(Sender).Canvas.Brush.Color := clMoneyGreen;

      TStringGrid(Sender).Canvas.FillRect( Rect );
      TStringGrid(Sender).Canvas.TextOut(   Rect.Left + 2, Rect.Top + Round( Rect.Height * 0.5 ) - Round(  TStringGrid(Sender).Canvas.TextHeight( 'I' ) * 0.5  ), TStringGrid(Sender).Cells[ ACol, ARow ]   );

    end;

end;

procedure TTable__Metadata_F_Frame.Metadata_StringGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_DELETE then
    Column__Delete_MenuItemClick( Sender )
  else
  if Key = VK_INSERT then
    Column__Add_MenuItemClick( Sender )
  else
  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl ] ) then
    Column__Name_Edit_MenuItemClick( Sender )
  else
  if Key = VK_RETURN then
    Column__Type_Edit_MenuItemClick( Column__Type_Edit_MenuItem )
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Metadata_StringGrid.Cells[ Metadata_StringGrid.Col, Metadata_StringGrid.Row ];
    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end
  else
  // D.
  if    ( Key = 68 )
    and ( Shift = [ ssCtrl ] ) then // Due to writing capitals without ssShift.
    Table_Column__Values_Distinct_MenuItemClick( Sender );

end;

end.
