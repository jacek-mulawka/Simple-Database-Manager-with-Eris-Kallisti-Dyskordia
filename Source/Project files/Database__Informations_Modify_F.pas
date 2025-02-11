unit Database__Informations_Modify_F;{11.Paü.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Translation,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus;

type
  TDatabase__Informations_Modify_F_Frame = class( TFrame )
    Buttons_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    Log_Memo: TMemo;
    Vertical_Splitter: TSplitter;
    Log_Horizontal_Splitter: TSplitter;
    Metadata_StringGrid: TStringGrid;
    Refresh_Button: TButton;
    Metadata_PopupMenu: TPopupMenu;
    Database__Description__Set_MenuItem: TMenuItem;
    Database__Description__Drop_MenuItem: TMenuItem;
    Database_Description_Memo: TMemo;
    Metadata_Panel: TPanel;
    Database_Description_Memo_Horizontal_Splitter: TSplitter;
    Database_Description_GroupBox: TGroupBox;
    Distance_Label: TLabel;
    Search_GroupBox: TGroupBox;
    Search_Edit: TEdit;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Prior_Button: TButton;
    Search__Next_Button: TButton;

    procedure Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );

    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );
    procedure Search_Change( Sender: TObject );
    procedure Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );
    procedure Database__Description__Set_MenuItemClick( Sender: TObject );
    procedure Database__Description__Drop_MenuItemClick( Sender: TObject );
    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Database_Description_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Metadata_StringGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
  private
    { Private declarations }
    sql__quotation_sign__use__dimf_g,
    values_logged_g // Values log only once.
      : boolean;

    database_type__dimf_g,
    sql__quotation_sign__dimf_g
      : string;

    database_informations_sdbm : Common.TSDBM;

    function Quotation_Sign__DIMF() : string;
  public
    { Public declarations }
    parent_supreme_tab_sheet__dimf : Vcl.Controls.TWinControl;

    procedure Data_Open__DIMF();
    procedure Finish__DIMF();
    procedure Highlight__Font__Set__DIMF();
    procedure Options_Set__DIMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
    procedure Parent_Tab_Switch( const prior_f : boolean = false );
    procedure Prepare__DIMF( const database_type_f, sql__quotation_sign_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
    procedure Translation__Apply__DIMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
  end;

const
  database__informations__attributes_list__file_name_c : string = 'Database__Informations__Attributes_List__sql.txt';
  database__informations__column__attribute__name_c : string = 'ATTRIBUTE_NAME';
  database__informations__column__attribute__value_c : string = 'ATTRIBUTE_VALUE';
  database__informations__column_number__attribute__name_c : integer = 1;
  database__informations__column_number__attribute__value_c : integer = 2;
  database__informations__database__description__file_name_c : string = 'Database__Informations__Database__Description__sql.txt';
  database__informations__sql__description__drop__file_name_c : string = 'Database__Informations__Description__Drop__sql.txt';
  database__informations__sql__description__set__file_name_c : string = 'Database__Informations__Description__Set__sql.txt';

implementation

uses
  Vcl.Clipbrd,
  Vcl.ComCtrls,

  Text__Edit_Memo,
  Shared;

{$R *.dfm}

procedure TDatabase__Informations_Modify_F_Frame.Data_Open__DIMF();

  function Translation__Apply__L( const name_f : string ) : string;
  begin

    if AnsiUpperCase( name_f ) = 'BACKUP STATE' then
      begin

        Result := Translation.translation__messages_r.word__backup_state;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'DATABASE PATH OR ALIAS' then
      begin

        Result := Translation.translation__messages_r.word__database_path_or_alias;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'DEFAULT CHARACTER SET' then
      begin

        Result := Translation.translation__messages_r.word__default__character_set;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'DESCRIPTION' then
      begin

        Result := Translation.translation__messages_r.word__description;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'FILLING DATABASE PAGES' then
      begin

        Result := Translation.translation__messages_r.word__filling_database_pages;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'FULL SHUTDOWN' then
      begin

        Result := Translation.translation__messages_r.word__full_shutdown;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'MERGE' then
      begin

        Result := Translation.translation__messages_r.word__merge;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'MULTI-USER SHUTDOWN' then
      begin

        Result := Translation.translation__messages_r.word__multi_user_shutdown;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'NORMAL' then
      begin

        Result := Translation.translation__messages_r.word__normal;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'OWNER' then
      begin

        Result := Translation.translation__messages_r.word__owner;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'PAGE SIZE' then
      begin

        Result := Translation.translation__messages_r.word__page_size;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'READ ONLY' then
      begin

        Result := Translation.translation__messages_r.word__read__only;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'READ WRITE' then
      begin

        Result := Translation.translation__messages_r.word__read__write;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'READING MODE' then
      begin

        Result := Translation.translation__messages_r.word__reading_mode;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = '(RE)CREATION DATE' then
      begin

        Result := Translation.translation__messages_r.word__re_creation_date;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'RESERVE SPACE' then
      begin

        Result := Translation.translation__messages_r.word__reserve_space;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'SHUTDOWN MODE' then
      begin

        Result := Translation.translation__messages_r.word__shutdown_mode;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'SINGLE-USER SHUTDOWN' then
      begin

        Result := Translation.translation__messages_r.word__single_user_shutdown;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'SQL DIALECT' then
      begin

        Result := Translation.translation__messages_r.word__sql_dialect;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'STALLED' then
      begin

        Result := Translation.translation__messages_r.word__stalled;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'THE DATABASE IS ONLINE' then
      begin

        Result := Translation.translation__messages_r.word__the_database_is_online;
        Exit;

      end
    else
    if AnsiUpperCase( name_f ) = 'USE ALL SPACE' then
      begin

        Result := Translation.translation__messages_r.word__use_all_space;
        Exit;

      end
    else
      Result := name_f;

  end;

var
  i : integer;

  zts : string;
begin

  if   ( database_informations_sdbm = nil )
    or ( database_informations_sdbm.component_type__sdbm = Common.ct_none ) then
    Exit;


  Screen.Cursor := crHourGlass;


  if database_informations_sdbm.Query__Active() then
    database_informations_sdbm.Query__Close();


  if Metadata_StringGrid.ColCount < 3 then
    Metadata_StringGrid.ColCount := 3;

  Metadata_StringGrid.RowCount := 2;

  for i := 1 to Metadata_StringGrid.ColCount - 1 do
    Metadata_StringGrid.Rows[ i ].Clear();

  if Metadata_StringGrid.Cells[ 0, 0 ] = '' then
    begin

      Metadata_StringGrid.ColWidths[ database__informations__column_number__attribute__name_c ] := 300;
      Metadata_StringGrid.ColWidths[ database__informations__column_number__attribute__value_c ] := 500;

    end;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__dimf_g ) + database__informations__attributes_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__dimf_g ) + database__informations__attributes_list__file_name_c + ').' );

      zts :=
        'select ''Backup state'' as ATTRIBUTE_NAME ' +
        '     , (case ' +
        '         MON$DATABASE.MON$BACKUP_STATE ' +
        '         when 0 then ' +
        '           ''Normal'' ' +
        ' ' +
        '         when 1 then ' +
        '           ''Stalled'' ' +
        ' ' +
        '         when 2 then ' +
        '           ''Merge'' ' +
        ' ' +
        '         else ' +
        '           MON$DATABASE.MON$BACKUP_STATE ' +
        '       end) as ATTRIBUTE_VALUE ' +
        'from MON$DATABASE ' +
        ' ' +
        ' ' +
        'select ''(Re)creation date'' as ATTRIBUTE_NAME ' +
        '     , MON$DATABASE.MON$CREATION_DATE as ATTRIBUTE_VALUE ' +
        'from MON$DATABASE ' +
        ' ' +
        ' ' +
        'union all ' +
        ' ' +
        ' ' +
        'select ''Database path or alias'' as ATTRIBUTE_NAME ' +
        '     , MON$DATABASE.MON$DATABASE_NAME as ATTRIBUTE_VALUE ' +
        'from MON$DATABASE ' +
        ' ' +
        ' ' +
        'union all ' +
        ' ' +
        ' ' +
        'select ''Default character set'' as ATTRIBUTE_NAME ' +
        '     , RDB$DATABASE.RDB$CHARACTER_SET_NAME as ATTRIBUTE_VALUE ' +
        'from RDB$DATABASE ' +
        ' ' +
        ' ' +
        'union all ' +
        ' ' +
        ' ' +
        'select ''Description'' as ATTRIBUTE_NAME ' +
        '     , RDB$DATABASE.RDB$DESCRIPTION as ATTRIBUTE_VALUE ' +
        'from RDB$DATABASE ' +
        ' ' +
        ' ' +
        'union all ' +
        ' ' +
        ' ' +
        'union all ' +
        ' ' +
        ' ' +
        'select ''Filling database pages'' as ATTRIBUTE_NAME ' +
        '     , (case ' +
        '         MON$DATABASE.MON$RESERVE_SPACE ' +
        '         when 0 then ' +
        '           ''Use all space'' ' +
        ' ' +
        '         when 1 then ' +
        '           ''Reserve space'' ' +
        ' ' +
        '         else ' +
        '           MON$DATABASE.MON$RESERVE_SPACE ' +
        '       end) as ATTRIBUTE_VALUE ' +
        'from MON$DATABASE ' +
        ' ' +
        ' ' +
        'union all ' +
        ' ' +
        ' ' +
        'select ''Owner'' as ATTRIBUTE_NAME ' +
        '     , MON$DATABASE.MON$OWNER as ATTRIBUTE_VALUE ' +
        'from MON$DATABASE ' +
        ' ' +
        ' ' +
        'union all ' +
        ' ' +
        ' ' +
        'select ''Page size'' as ATTRIBUTE_NAME ' +
        '     , MON$DATABASE.MON$PAGE_SIZE as ATTRIBUTE_VALUE ' +
        'from MON$DATABASE ' +
        ' ' +
        ' ' +
        'union all ' +
        ' ' +
        ' ' +
        'select ''Reading mode'' as ATTRIBUTE_NAME ' +
        '     , (case ' +
        '         MON$DATABASE.MON$READ_ONLY ' +
        '         when 0 then ' +
        '           ''Read write'' ' +
        ' ' +
        '         when 1 then ' +
        '           ''Read only'' ' +
        ' ' +
        '         else ' +
        '           MON$DATABASE.MON$READ_ONLY ' +
        '       end) as ATTRIBUTE_VALUE ' +
        'from MON$DATABASE ' +
        ' ' +
        ' ' +
        'union all ' +
        ' ' +
        ' ' +
        'select ''Shutdown mode'' as ATTRIBUTE_NAME ' +
        '     , (case ' +
        '         MON$DATABASE.MON$SHUTDOWN_MODE ' +
        '         when 0 then ' +
        '           ''The database is online'' ' +
        ' ' +
        '         when 1 then ' +
        '           ''Multi-user shutdown'' ' +
        ' ' +
        '         when 2 then ' +
        '           ''Single-user shutdown'' ' +
        ' ' +
        '         when 3 then ' +
        '           ''Full shutdown'' ' +
        ' ' +
        '         else ' +
        '           MON$DATABASE.MON$SHUTDOWN_MODE ' +
        '       end) as ATTRIBUTE_VALUE ' +
        'from MON$DATABASE ' +
        ' ' +
        ' ' +
        'union all ' +
        ' ' +
        ' ' +
        'select ''SQL dialect'' as ATTRIBUTE_NAME ' +
        '     , MON$DATABASE.MON$SQL_DIALECT as ATTRIBUTE_VALUE ' +
        'from MON$DATABASE ';

    end;

  database_informations_sdbm.Query__Sql__Set( zts );


  if not values_logged_g then
    Log_Memo.Lines.Add( zts );


  try
    database_informations_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_database_informations + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

        Screen.Cursor := crHourGlass;

      end;
  end;

  if database_informations_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( database_informations_sdbm.Operation_Duration_Get() );


      try
        database_informations_sdbm.Query__Field_By_Name( database__informations__column__attribute__name_c ).AsString;
        database_informations_sdbm.Query__Field_By_Name( database__informations__column__attribute__value_c ).AsString;
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            database_informations_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_columns + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            Screen.Cursor := crHourGlass;

          end;
      end;


      if database_informations_sdbm.Query__Active() then
        begin

          if database_informations_sdbm.component_type__sdbm = Common.TComponent_Type.ct_FireDAC then
            begin

              // FireDAC may not give total record count.

              database_informations_sdbm.Query__Last();
              database_informations_sdbm.Query__First();

            end;


          if Metadata_StringGrid.RowCount < database_informations_sdbm.Query__Record_Count() + 1 then
            Metadata_StringGrid.RowCount := database_informations_sdbm.Query__Record_Count() + 1;


          while not database_informations_sdbm.Query__Eof() do
            begin

              // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

              Metadata_StringGrid.Cells[ 0, database_informations_sdbm.Query__Record_Number() ] := Trim(  FormatFloat( '### ### ### ### ### ### ##0', database_informations_sdbm.Query__Record_Number() )  );
              Metadata_StringGrid.Cells[ database__informations__column_number__attribute__name_c, database_informations_sdbm.Query__Record_Number() ] := Translation__Apply__L(   Trim(  database_informations_sdbm.Query__Field_By_Name( database__informations__column__attribute__name_c ).AsString  )   );
              Metadata_StringGrid.Cells[ database__informations__column_number__attribute__value_c, database_informations_sdbm.Query__Record_Number() ] := Translation__Apply__L(   Trim(  database_informations_sdbm.Query__Field_By_Name( database__informations__column__attribute__value_c ).AsString  )   );

              database_informations_sdbm.Query__Next();

            end;


          Self.Translation__Apply__DIMF( Translation.tak_Grid );

        end;

    end;


  if database_informations_sdbm.Query__Active() then
    database_informations_sdbm.Query__Close();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__dimf_g ) + database__informations__database__description__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__dimf_g ) + database__informations__database__description__file_name_c + ').' );

      zts :=
        'select RDB$DATABASE.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
        'from RDB$DATABASE ';

    end;

  database_informations_sdbm.Query__Sql__Set( zts );


  if not values_logged_g then
    Log_Memo.Lines.Add( zts );


  try
    database_informations_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_database_description + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

        Screen.Cursor := crHourGlass;

      end;
  end;


  if database_informations_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( database_informations_sdbm.Operation_Duration_Get() );


      try
        Database_Description_Memo.Lines.Text := database_informations_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_database_description + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            Screen.Cursor := crHourGlass;

          end;
      end;

    end;


  if database_informations_sdbm.Query__Active() then
    database_informations_sdbm.Query__Close();

  database_informations_sdbm.Query__Sql__Set( '' );


  if not values_logged_g then
    values_logged_g := true;


  Screen.Cursor := crDefault;

end;

procedure TDatabase__Informations_Modify_F_Frame.Finish__DIMF();
begin

  FreeAndNil( database_informations_sdbm );

end;

procedure TDatabase__Informations_Modify_F_Frame.Highlight__Font__Set__DIMF();
begin

  Common.Font__Set( Database_Description_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    Common.Font__Set( Metadata_StringGrid.Font, Common.sql_editor__font );

end;

procedure TDatabase__Informations_Modify_F_Frame.Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );
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

procedure TDatabase__Informations_Modify_F_Frame.Options_Set__DIMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
begin

  sql__quotation_sign__use__dimf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__dimf_g := sql__quotation_sign_f;


  if database_informations_sdbm <> nil then
    begin

      database_informations_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

    end;


  Self.Translation__Apply__DIMF( Translation.tak_Self );

end;

procedure TDatabase__Informations_Modify_F_Frame.Parent_Tab_Switch( const prior_f : boolean = false );
var
  zti : integer;
begin

  if    ( parent_supreme_tab_sheet__dimf <> nil )
    and ( parent_supreme_tab_sheet__dimf is TTabSheet )
    and ( parent_supreme_tab_sheet__dimf.Parent <> nil )
    and ( parent_supreme_tab_sheet__dimf.Parent is TPageControl )
    and ( TPageControl(parent_supreme_tab_sheet__dimf.Parent).PageCount > 1 ) then
    begin

      zti := TPageControl(parent_supreme_tab_sheet__dimf.Parent).ActivePageIndex;


      if not prior_f then
        begin

          // Next.

          inc( zti );

          if zti > TPageControl(parent_supreme_tab_sheet__dimf.Parent).PageCount - 1 then
            zti := 0;

        end
      else
        begin

          // Prior.

          dec( zti );

          if zti < 0 then
            zti := TPageControl(parent_supreme_tab_sheet__dimf.Parent).PageCount - 1;

        end;


      TPageControl(parent_supreme_tab_sheet__dimf.Parent).ActivePageIndex := zti;


      if Assigned( TPageControl(parent_supreme_tab_sheet__dimf.Parent).OnChange ) then
        TPageControl(parent_supreme_tab_sheet__dimf.Parent).OnChange( nil );

    end;

end;

procedure TDatabase__Informations_Modify_F_Frame.Prepare__DIMF( const database_type_f, sql__quotation_sign_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
begin

  Self.Name := '';

  database_type__dimf_g := database_type_f;
  values_logged_g := false;


  database_informations_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Self.Options_Set__DIMF( component_type_f, sql__quotation_sign_f, sql__quotation_sign__use_f );


  Metadata_StringGrid.ColCount := 2;


  Highlight__Font__Set__DIMF();

end;

function TDatabase__Informations_Modify_F_Frame.Quotation_Sign__DIMF() : string;
begin

  // Unused.

  if sql__quotation_sign__use__dimf_g then
    begin

      Result := sql__quotation_sign__dimf_g;

    end
  else
    Result := '';

end;

procedure TDatabase__Informations_Modify_F_Frame.Translation__Apply__DIMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
begin

  if tak_f in [ Translation.tak_All, Translation.tak_Self ] then
    Translation.Translation__Apply( Self );


  if tak_f in [ Translation.tak_All ] then
    Self.Data_Open__DIMF() // Call Self.Translation__Apply__DIMF( Translation.tak_Grid );.
  else
    if tak_f in [ Translation.tak_Grid ] then
      begin

        Metadata_StringGrid.Cells[ 0, 0 ] := Translation.translation__messages_r.word__no_;
        Metadata_StringGrid.Cells[ database__informations__column_number__attribute__name_c, 0 ] := Translation.translation__messages_r.word__attribute_name;
        Metadata_StringGrid.Cells[ database__informations__column_number__attribute__value_c, 0 ] := Translation.translation__messages_r.word__attribute_value;

      end;

end;

procedure TDatabase__Informations_Modify_F_Frame.Refresh_ButtonClick( Sender: TObject );
var
  col_number_copy,
  row_number_copy
    : integer;
begin

  col_number_copy := Metadata_StringGrid.Col;
  row_number_copy := Metadata_StringGrid.Row;


  Self.Data_Open__DIMF();


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

procedure TDatabase__Informations_Modify_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Buttons_Panel.Width := 1;

end;

procedure TDatabase__Informations_Modify_F_Frame.Search_Change( Sender: TObject );
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

procedure TDatabase__Informations_Modify_F_Frame.Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_PRIOR then
    Search__Prior_ButtonClick( Sender )
  else
  if Key = VK_NEXT then
    Search__Next_ButtonClick( Sender );

end;

procedure TDatabase__Informations_Modify_F_Frame.Search__Next_ButtonClick( Sender: TObject );
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

procedure TDatabase__Informations_Modify_F_Frame.Search__Prior_ButtonClick( Sender: TObject );
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

procedure TDatabase__Informations_Modify_F_Frame.Database__Description__Set_MenuItemClick( Sender: TObject );
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
  Text__Edit_Memo.Text__Edit_Memo_Form.text_value := Database_Description_Memo.Lines.Text;
  Text__Edit_Memo.Text__Edit_Memo_Form.quotation_mark_duplicate := true;
  Text__Edit_Memo.Text__Edit_Memo_Form.Caption := Translation.translation__messages_r.word__description___database;
  Text__Edit_Memo.Text__Edit_Memo_Form.Text_Type_Set( Text__Edit_Memo.tt_Memo );
  modal_result := Text__Edit_Memo.Text__Edit_Memo_Form.ShowModal();

  if modal_result = mrOk then
    description_value_l := Text__Edit_Memo.Text__Edit_Memo_Form.text_value;

  FreeAndNil( Text__Edit_Memo.Text__Edit_Memo_Form );


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__dimf_g ) + database__informations__sql__description__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__dimf_g ) + database__informations__sql__description__set__file_name_c + ').' );

      zts :=
        'comment on database is ''' + description_value_l + ''' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if modal_result <> mrOk then
    Exit;


  ztb := database_informations_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_database_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( database_informations_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TDatabase__Informations_Modify_F_Frame.Database__Description__Drop_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if Metadata_StringGrid.Row < 1 then
    Exit;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__dimf_g ) + database__informations__sql__description__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__dimf_g ) + database__informations__sql__description__drop__file_name_c + ').' );

      zts :=
        'comment on database is null ';

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_database_description_), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := database_informations_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_database_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( database_informations_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TDatabase__Informations_Modify_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TDatabase__Informations_Modify_F_Frame.Database_Description_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Database_Description_Memo.SelectAll();

end;

procedure TDatabase__Informations_Modify_F_Frame.Metadata_StringGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

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
  // R.
  if    ( Key = 82 )
    and ( Shift = [ ssCtrl ] ) then
    Refresh_ButtonClick( Sender );

end;

end.
