unit Roles_Modify_F;{15.Wrz.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Samples.Spin, Vcl.Menus, Vcl.CheckLst;

type
  TRoles_Modify_F_Frame = class( TFrame )
    Buttons_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    Role_Name_DBEdit: TDBEdit;
    Role_Name_Etiquette_Label: TLabel;
    Roles_DataSource: TDataSource;
    Roles_DBGrid: TDBGrid;
    Log_Memo: TMemo;
    Modify_GroupBox: TGroupBox;
    Modify__Add_Button: TButton;
    Modify__Delete_Button: TButton;
    Modify__Edit_Button: TButton;
    Modify__Name_Edit: TEdit;
    Modify__Name_Etiquette_Label: TLabel;
    Record_Number__Records_Count_Label: TLabel;
    Refresh_Button: TButton;
    Search_Edit: TEdit;
    Search_GroupBox: TGroupBox;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Next_Button: TButton;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Prior_Button: TButton;
    Vertical_Splitter: TSplitter;
    Roles_PopupMenu: TPopupMenu;
    Role__Delete_MenuItem: TMenuItem;
    N1: TMenuItem;
    Role__Description__Set_MenuItem: TMenuItem;
    Role__Description__Drop_MenuItem: TMenuItem;
    N2: TMenuItem;
    Role__Description__Write_In_Log_MenuItem: TMenuItem;
    Modify__Privileges_Name_Etiquette_Label: TLabel;
    Modify__Privileges_Name_CheckListBox: TCheckListBox;
    Log_Horizontal_Splitter: TSplitter;
    Modify__Revoke_Button: TButton;

    procedure Role_Name_DBEditChange( Sender: TObject );
    procedure Search_Change( Sender: TObject );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );

    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Modify__Add_ButtonClick( Sender: TObject );
    procedure Modify__Edit_ButtonClick( Sender: TObject );
    procedure Modify__Revoke_ButtonClick( Sender: TObject );
    procedure Modify__Delete_ButtonClick( Sender: TObject );

    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );
    procedure Modify__Privileges_Name_CheckListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Role__Description__Set_MenuItemClick( Sender: TObject );
    procedure Role__Description__Drop_MenuItemClick( Sender: TObject );
    procedure Role__Description__Write_In_Log_MenuItemClick( Sender: TObject );

    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Roles_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
    procedure Roles_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Roles_DBGridTitleClick( Column: TColumn );
  private
    { Private declarations }
    sort__direction_ascending_g,
    sql__quotation_sign__use__rmf_g
      : boolean;

    database_type__rmf_g,
    sort__column_name_g,
    sql__drop_system_privileges_g,
    sql__quotation_sign__rmf_g,
    sql__set_system_privileges_to_g
      : string;

    roles_sdbm : Common.TSDBM;

    function Quotation_Sign__RMF() : string;
  public
    { Public declarations }
    procedure Data_Open__RMF( const force_refresh_f : boolean = false );
    procedure Finish__RMF();
    procedure Options_Set__RMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
    procedure Prepare__RMF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
  end;

const
  role_list__sql__description__drop__file_name_c : string = 'Role__Description__Drop__sql.txt';
  role_list__sql__description__set__file_name_c : string = 'Role__Description__Set__sql.txt';
  roles_list__file_name_c : string = 'Roles_List__sql.txt';
  roles_list__column__role_name__big_letter_c : string = 'ROLE_NAME';
  roles_list__privileges_list_c : string = 'PRIVILEGES_LIST';
  roles_list__privileges_list__file_name_c : string = 'Role__Permissions__Privileges_List.txt';
  roles_list__sql__role__alter__file_name_c : string = 'Role__Alter__sql.txt';
  roles_list__sql__role__alter__set_system_privileges_to__file_name_c : string = 'Role__Role__Alter__Set_System_Privileges_To__sql.txt';
  roles_list__sql__role__alter__drop_system_privileges__file_name_c : string = 'Role__Role__Alter__Drop_System_Privileges__sql.txt';
  roles_list__sql__role__create__file_name_c : string = 'Role__Create__sql.txt';
  roles_list__sql__role__drop__file_name_c : string = 'Role__Drop__sql.txt';

implementation

uses
  System.IOUtils,
  Vcl.Clipbrd,

  Shared,
  Text__Edit_Memo,
  Translation;

{$R *.dfm}

procedure TRoles_Modify_F_Frame.Data_Open__RMF( const force_refresh_f : boolean = false );
var
  i : integer;

  zts : string;
begin

  if   ( roles_sdbm = nil )
    or ( roles_sdbm.component_type__sdbm = Common.ct_none )
    or (
             ( not force_refresh_f )
         and ( roles_sdbm.Query__Active() )
       ) then
    Exit;


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__rmf_g + System.IOUtils.TPath.DirectorySeparatorChar + roles_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + roles_list__file_name_c + ').' );

      zts :=
        'select RDB$ROLES.RDB$ROLE_NAME as ROLE_NAME ' +
        '     , RDB$ROLES.RDB$OWNER_NAME as OWNER_NAME ' +
        //'     , cast(  substring( RDB$ROLES.RDB$DESCRIPTION from 1 for 10000 ) as varchar( 10000 )  ) as DESCRIPTION_VALUE__CAST ' +
        '     , cast(  substring( RDB$ROLES.RDB$DESCRIPTION from 1 for 8191 ) as varchar( 8191 )  ) as DESCRIPTION_VALUE__CAST ' + // FireDAC limit default - FDConnection1.FormatOptions.MaxStringSize = 32767 bytes ( / 4 = 8191,75 ).
        '     , RDB$ROLES.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
        '     , RDB$ROLES.RDB$SYSTEM_FLAG ' +
        '     , RDB$ROLES.RDB$SECURITY_CLASS ' +
        'from RDB$ROLES ' +
        'where ( ' +
        '           RDB$ROLES.RDB$SYSTEM_FLAG = 0 ' +
        '        or 1 = :system_tables_visible ' +
        '      ) ';

    end;


  Screen.Cursor := crHourGlass;


  if roles_sdbm.Query__Active() then
    roles_sdbm.Query__Close();

  roles_sdbm.Query__Sql__Set( zts );


  if Common.system_tables_visible then
    i := 1
  else
    i := 0;

  roles_sdbm.Query__Param_By_Name__Set( Common.tables_list__system_tables_visible__parameter_name_c, i, Log_Memo );



  Log_Memo.Lines.Add( zts );


  try
    roles_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_roles_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;


  Screen.Cursor := crDefault;


  if roles_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( roles_sdbm.Operation_Duration_Get() );


      try
        Role_Name_DBEdit.DataField := roles_list__column__role_name__big_letter_c;
        roles_sdbm.Query__Field_By_Name( roles_list__column__role_name__big_letter_c ).AsString;
        roles_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );
      except
        on E : Exception do
          begin

            roles_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_role_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;


      for i := 0 to Roles_DBGrid.Columns.Count - 1 do
        if Roles_DBGrid.Columns.Items[ i ].FieldName = roles_list__column__role_name__big_letter_c then
          Roles_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__role_name
        else
        if Roles_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value__cast_c then
          begin

            Roles_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__description;

            if Roles_DBGrid.Columns.Items[ i ].Width > 500 then
              Roles_DBGrid.Columns.Items[ i ].Width := 500;

          end
        else
          begin

            Roles_DBGrid.Columns.Items[ i ].Title.Caption := Common.Column_Name_To_Grid_Caption( Roles_DBGrid.Columns.Items[ i ].Title.Caption );


            if Roles_DBGrid.Columns.Items[ i ].Width > 200 then
              Roles_DBGrid.Columns.Items[ i ].Width := 200;

          end;

    end;

end;

procedure TRoles_Modify_F_Frame.Finish__RMF();
begin

  FreeAndNil( roles_sdbm );

end;

function TRoles_Modify_F_Frame.Quotation_Sign__RMF() : string;
begin

  if sql__quotation_sign__use__rmf_g then
    begin

      Result := sql__quotation_sign__rmf_g;

    end
  else
    Result := '';

end;

procedure TRoles_Modify_F_Frame.Options_Set__RMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
begin

  sql__quotation_sign__use__rmf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__rmf_g := sql__quotation_sign_f;


  if roles_sdbm <> nil then
    begin

      roles_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

      roles_sdbm.Data_Source__Data_Set__Set( Roles_DataSource );

    end;


  Translation.Translation__Apply( Self );

end;

procedure TRoles_Modify_F_Frame.Prepare__RMF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
var
  zts : string;
begin

  Self.Name := '';

  database_type__rmf_g := databases_r_f.database_type;
  sort__column_name_g := roles_list__column__role_name__big_letter_c;
  sort__direction_ascending_g := true;


  roles_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Options_Set__RMF( component_type_f, databases_r_f.sql__quotation_sign, sql__quotation_sign__use_f );


  sql__drop_system_privileges_g := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__rmf_g + System.IOUtils.TPath.DirectorySeparatorChar + roles_list__sql__role__alter__drop_system_privileges__file_name_c  );

  if Trim( sql__drop_system_privileges_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + roles_list__sql__role__alter__drop_system_privileges__file_name_c + ').' );

      sql__drop_system_privileges_g :=
        #13 + #10 +
        'drop system privileges';

    end
  else
    begin

      sql__drop_system_privileges_g := StringReplace( sql__drop_system_privileges_g, #10, '', [] );
      sql__drop_system_privileges_g := StringReplace( sql__drop_system_privileges_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Drop system privileges: ' + sql__drop_system_privileges_g + '.' );


  sql__set_system_privileges_to_g := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__rmf_g + System.IOUtils.TPath.DirectorySeparatorChar + roles_list__sql__role__alter__set_system_privileges_to__file_name_c  );

  if Trim( sql__set_system_privileges_to_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + roles_list__sql__role__alter__set_system_privileges_to__file_name_c + ').' );

      sql__set_system_privileges_to_g :=
        #13 + #10 +
        'set system privileges to ';

    end
  else
    begin

      sql__set_system_privileges_to_g := StringReplace( sql__set_system_privileges_to_g, #10, '', [] );
      sql__set_system_privileges_to_g := StringReplace( sql__set_system_privileges_to_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Set system privileges to: ' + sql__set_system_privileges_to_g + '.' );


  Modify__Privileges_Name_CheckListBox.Items.Clear();

  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__rmf_g + System.IOUtils.TPath.DirectorySeparatorChar + roles_list__privileges_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + roles_list__privileges_list__file_name_c + ').' );

      zts :=
        'DROP AUTO ADMIN MAPPING' + #13 + #10 +
        'SET AUTO ADMIN MAPPING' + #13 + #10 +
        'ACCESS_ANY_OBJECT_IN_DATABASE' + #13 + #10 +
        'ACCESS_SHUTDOWN_DATABASE' + #13 + #10 +
        'CHANGE_HEADER_SETTINGS' + #13 + #10 +
        'CHANGE_MAPPING_RULES' + #13 + #10 +
        'CHANGE_SHUTDOWN_MODE' + #13 + #10 +
        'CREATE_DATABASE' + #13 + #10 +
        'CREATE_PRIVILEGED_ROLES' + #13 + #10 +
        'CREATE_USER_TYPES' + #13 + #10 +
        'DROP_DATABASE' + #13 + #10 +
        'GET_DBCRYPT_INFO' + #13 + #10 +
        'GRANT_REVOKE_ANY_DDL_RIGHT' + #13 + #10 +
        'GRANT_REVOKE_ON_ANY_OBJECT' + #13 + #10 +
        'IGNORE_DB_TRIGGERS' + #13 + #10 +
        'MODIFY_ANY_OBJECT_IN_DATABASE' + #13 + #10 +
        'MODIFY_EXT_CONN_POOL' + #13 + #10 +
        'MONITOR_ANY_ATTACHMENT' + #13 + #10 +
        'READ_RAW_PAGES' + #13 + #10 +
        'REPLICATE_INTO_DATABASE' + #13 + #10 +
        'SELECT_ANY_OBJECT_IN_DATABASE' + #13 + #10 +
        'TRACE_ANY_ATTACHMENT' + #13 + #10 +
        'USE_GBAK_UTILITY' + #13 + #10 +
        'USE_GFIX_UTILITY' + #13 + #10 +
        'USE_GRANTED_BY_CLAUSE' + #13 + #10 +
        'USE_GSTAT_UTILITY' + #13 + #10 +
        'USE_NBACKUP_UTILITY' + #13 + #10 +
        'USER_MANAGEMENT' +  #13 + #10;

    end;

  Common.Items_From_Text_Add( Modify__Privileges_Name_CheckListBox.Items, zts );


  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );

end;

procedure TRoles_Modify_F_Frame.Role_Name_DBEditChange( Sender: TObject );
begin

  if    ( roles_sdbm <> nil )
    and ( roles_sdbm.Query__Active() ) then
    Record_Number__Records_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', roles_sdbm.Query__Record_Number() )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', roles_sdbm.Query__Record_Count() )  )
  else
    Record_Number__Records_Count_Label.Caption := '0 / 0';

end;

procedure TRoles_Modify_F_Frame.Search_Change( Sender: TObject );
var
  locate_options : Data.DB.TLocateOptions;
begin

  if   ( roles_sdbm = nil )
    or ( not roles_sdbm.Query__Active() ) then
    Exit;


  locate_options := [];

  if Search__Case_Insensitive_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loCaseInsensitive ];

  if Search__Partial_Key_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loPartialKey ];


  if roles_sdbm.Query__Locate( sort__column_name_g, Search_Edit.Text, locate_options ) then
    Search_Edit.Color := clWindow
  else
    begin

      Search_Edit.Color := Common.color__red__light_c;


      roles_sdbm.Query__Disable_Controls();

      roles_sdbm.Query__First();

      while not roles_sdbm.Query__Eof do
        begin

          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  roles_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

          roles_sdbm.Query__Next();

        end;

      roles_sdbm.Query__Enable_Controls();

    end;

end;

procedure TRoles_Modify_F_Frame.Search__Next_ButtonClick( Sender: TObject );
begin

  if   ( roles_sdbm = nil )
    or ( not roles_sdbm.Query__Active() ) then
    Exit;


  roles_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not roles_sdbm.Query__Eof do
    begin

      roles_sdbm.Query__Next();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  roles_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  roles_sdbm.Query__Enable_Controls();

end;

procedure TRoles_Modify_F_Frame.Search__Prior_ButtonClick( Sender: TObject );
begin

  if   ( roles_sdbm = nil )
    or ( not roles_sdbm.Query__Active() ) then
    Exit;


  roles_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not roles_sdbm.Query__Bof do
    begin

      roles_sdbm.Query__Prior();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  roles_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  roles_sdbm.Query__Enable_Controls();

end;

procedure TRoles_Modify_F_Frame.Refresh_ButtonClick( Sender: TObject );
var
  primary_key_value_l : string;
begin

  if   ( roles_sdbm = nil )
    or ( not roles_sdbm.Query__Active() ) then
    Exit;


  primary_key_value_l := roles_sdbm.Query__Field_By_Name( roles_list__column__role_name__big_letter_c ).AsString;

  roles_sdbm.Query__Requery();


  if    ( Sender <> nil )
    and ( TComponent(Sender).Name = Refresh_Button.Name ) then
    begin

      Log_Memo.Lines.Add( roles_sdbm.Operation_Duration_Get() );

    end;


  roles_sdbm.Query__Locate( roles_list__column__role_name__big_letter_c, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );

end;

procedure TRoles_Modify_F_Frame.Modify__Add_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  i : integer;

  zts,
  error_message_l,
  privileges_list_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( roles_sdbm = nil )
    or ( not roles_sdbm.Query__Active() ) then
    Exit;


  if Trim( Modify__Name_Edit.Text ) = '' then
    begin

      Modify__Name_Edit.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.role_name_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  if not Common.User_Role__Name_Unique( Modify__Name_Edit.Text, database_type__rmf_g, roles_sdbm, Log_Memo ) then
    begin

      if Modify__Name_Edit.Enabled then
        Modify__Name_Edit.SetFocus();

      if Application.MessageBox( PChar(Translation.translation__messages_r.role_and_user_name_should_be_unique + #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES then
        Exit;

    end;


  privileges_list_l := '';

  for i := 0 to Modify__Privileges_Name_CheckListBox.Items.Count - 1 do
    if Modify__Privileges_Name_CheckListBox.Checked[ i ] then
      begin

        if privileges_list_l <> '' then
          privileges_list_l := privileges_list_l + ', ';

        privileges_list_l := privileges_list_l + Modify__Privileges_Name_CheckListBox.Items[ i ];

      end;

  if privileges_list_l <> '' then
    privileges_list_l := sql__set_system_privileges_to_g + privileges_list_l;


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__rmf_g + System.IOUtils.TPath.DirectorySeparatorChar + roles_list__sql__role__create__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + roles_list__sql__role__create__file_name_c + ').' );

      zts :=
        'create role ' +
        Quotation_Sign__RMF() + Modify__Name_Edit.Text + Quotation_Sign__RMF() +
        privileges_list_l +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + roles_list__column__role_name__big_letter_c + Common.sql__word_replace_separator_c, Quotation_Sign__RMF() + Modify__Name_Edit.Text + Quotation_Sign__RMF(), [ rfReplaceAll ] );
      zts := StringReplace(  zts, Common.sql__word_replace_separator_c + roles_list__privileges_list_c + Common.sql__word_replace_separator_c, privileges_list_l, [ rfReplaceAll ]  );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.add_role + ' ''' + Quotation_Sign__RMF() + Modify__Name_Edit.Text + Quotation_Sign__RMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := roles_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_add_role );


  if ztb then
    begin

      Log_Memo.Lines.Add( roles_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      roles_sdbm.Query__Locate( roles_list__column__role_name__big_letter_c, Modify__Name_Edit.Text, [ Data.DB.loCaseInsensitive ] );


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TRoles_Modify_F_Frame.Modify__Edit_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  i : integer;

  zts,
  error_message_l,
  privileges_list_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( roles_sdbm = nil )
    or ( not roles_sdbm.Query__Active() )
    or ( roles_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  privileges_list_l := '';

  for i := 0 to Modify__Privileges_Name_CheckListBox.Items.Count - 1 do
    if Modify__Privileges_Name_CheckListBox.Checked[ i ] then
      begin

        if privileges_list_l <> '' then
          privileges_list_l := privileges_list_l + ', ';

        privileges_list_l := privileges_list_l + Modify__Privileges_Name_CheckListBox.Items[ i ];

      end;


  if Trim( privileges_list_l ) = '' then
    begin

      Modify__Privileges_Name_CheckListBox.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.privileges_must_be_selected), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  if privileges_list_l <> '' then
    privileges_list_l := sql__set_system_privileges_to_g + privileges_list_l;


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__rmf_g + System.IOUtils.TPath.DirectorySeparatorChar + roles_list__sql__role__alter__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + roles_list__sql__role__alter__file_name_c + ').' );

      zts :=
        'alter role ' +
        Quotation_Sign__RMF() + roles_sdbm.Query__Field_By_Name( roles_list__column__role_name__big_letter_c ).AsString + Quotation_Sign__RMF() +
        privileges_list_l +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + roles_list__column__role_name__big_letter_c + Common.sql__word_replace_separator_c, Quotation_Sign__RMF() + roles_sdbm.Query__Field_By_Name( roles_list__column__role_name__big_letter_c ).AsString + Quotation_Sign__RMF(), [ rfReplaceAll ] );
      zts := StringReplace(  zts, Common.sql__word_replace_separator_c + roles_list__privileges_list_c + Common.sql__word_replace_separator_c, privileges_list_l, [ rfReplaceAll ]  );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.set_role + ' ''' + Quotation_Sign__RMF() + roles_sdbm.Query__Field_By_Name( roles_list__column__role_name__big_letter_c ).AsString + Quotation_Sign__RMF() + ''' privileges?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := roles_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_role_privileges );


  if ztb then
    begin

      Log_Memo.Lines.Add( roles_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TRoles_Modify_F_Frame.Modify__Revoke_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( roles_sdbm = nil )
    or ( not roles_sdbm.Query__Active() )
    or ( roles_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__rmf_g + System.IOUtils.TPath.DirectorySeparatorChar + roles_list__sql__role__alter__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + roles_list__sql__role__alter__file_name_c + ').' );

      zts :=
        'alter role ' +
        Quotation_Sign__RMF() + roles_sdbm.Query__Field_By_Name( roles_list__column__role_name__big_letter_c ).AsString + Quotation_Sign__RMF() +
        sql__drop_system_privileges_g +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + roles_list__column__role_name__big_letter_c + Common.sql__word_replace_separator_c, Quotation_Sign__RMF() + roles_sdbm.Query__Field_By_Name( roles_list__column__role_name__big_letter_c ).AsString + Quotation_Sign__RMF(), [ rfReplaceAll ] );
      zts := StringReplace(  zts, Common.sql__word_replace_separator_c + roles_list__privileges_list_c + Common.sql__word_replace_separator_c, sql__drop_system_privileges_g, [ rfReplaceAll ]  );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.drop_privileges_from_role + ' ''' + Quotation_Sign__RMF() + roles_sdbm.Query__Field_By_Name( roles_list__column__role_name__big_letter_c ).AsString + Quotation_Sign__RMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := roles_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_drop_privileges_from_role );


  if ztb then
    begin

      Log_Memo.Lines.Add( roles_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;
end;

procedure TRoles_Modify_F_Frame.Modify__Delete_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( roles_sdbm = nil )
    or ( not roles_sdbm.Query__Active() )
    or ( roles_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__rmf_g + System.IOUtils.TPath.DirectorySeparatorChar + roles_list__sql__role__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + roles_list__sql__role__drop__file_name_c + ').' );

      zts :=
        'drop role ' +
        Quotation_Sign__RMF() + roles_sdbm.Query__Field_By_Name( roles_list__column__role_name__big_letter_c ).AsString + Quotation_Sign__RMF() +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + roles_list__column__role_name__big_letter_c + Common.sql__word_replace_separator_c, Quotation_Sign__RMF() + roles_sdbm.Query__Field_By_Name( roles_list__column__role_name__big_letter_c ).AsString + Quotation_Sign__RMF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_role + ' ''' + Quotation_Sign__RMF() + roles_sdbm.Query__Field_By_Name( roles_list__column__role_name__big_letter_c ).AsString + Quotation_Sign__RMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := roles_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_role );


  if ztb then
    begin

      Log_Memo.Lines.Add( roles_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TRoles_Modify_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Buttons_Panel.Width := 1;

end;

procedure TRoles_Modify_F_Frame.Modify__Privileges_Name_CheckListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
var
  i : integer;
begin

  // A.
  if    ( Key = 65 )
    and ( ssCtrl in Shift )
    and (  not ( ssAlt in Shift )  ) then
    Modify__Privileges_Name_CheckListBox.CheckAll( cbChecked, false, false )
  else
  // N.
  if    ( Key = 78 )
    and ( ssCtrl in Shift ) then
    Modify__Privileges_Name_CheckListBox.CheckAll( cbUnchecked, false, false )
  else
  // I.
  if    ( Key = 73 )
    and ( ssCtrl in Shift ) then
    for i := 0 to Modify__Privileges_Name_CheckListBox.Items.Count - 1 do
      Modify__Privileges_Name_CheckListBox.Checked[ i ] := not Modify__Privileges_Name_CheckListBox.Checked[ i ];

end;

procedure TRoles_Modify_F_Frame.Role__Description__Set_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  modal_result : TModalResult;

  zts,
  description_value_l,
  error_message_l,
  role_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( roles_sdbm = nil )
    or ( not roles_sdbm.Query__Active() )
    or ( roles_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Text__Edit_Memo.Text__Edit_Memo_Form := Text__Edit_Memo.TText__Edit_Memo_Form.Create( Application );
  Text__Edit_Memo.Text__Edit_Memo_Form.text_value := roles_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
  Text__Edit_Memo.Text__Edit_Memo_Form.quotation_mark_duplicate := true;
  Text__Edit_Memo.Text__Edit_Memo_Form.Caption := Translation.translation__messages_r.word__description___role;
  Text__Edit_Memo.Text__Edit_Memo_Form.Text_Type_Set( Text__Edit_Memo.tt_Memo );
  modal_result := Text__Edit_Memo.Text__Edit_Memo_Form.ShowModal();

  if modal_result = mrOk then
    description_value_l := Text__Edit_Memo.Text__Edit_Memo_Form.text_value;

  FreeAndNil( Text__Edit_Memo.Text__Edit_Memo_Form );


  role_name_l := Quotation_Sign__RMF() + Trim(  roles_sdbm.Query__Field_By_Name( roles_list__column__role_name__big_letter_c ).AsString  ) + Quotation_Sign__RMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__rmf_g + System.IOUtils.TPath.DirectorySeparatorChar + role_list__sql__description__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + role_list__sql__description__set__file_name_c + ').' );

      zts :=
        'comment on role ' +
        role_name_l +
        ' is ''' + description_value_l + ''' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + roles_list__column__role_name__big_letter_c + Common.sql__word_replace_separator_c, role_name_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if modal_result <> mrOk then
    Exit;


  ztb := roles_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_role_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( roles_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TRoles_Modify_F_Frame.Role__Description__Drop_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l,
  role_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( roles_sdbm = nil )
    or ( not roles_sdbm.Query__Active() )
    or ( roles_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  role_name_l := Quotation_Sign__RMF() + Trim(  roles_sdbm.Query__Field_By_Name( roles_list__column__role_name__big_letter_c ).AsString  ) + Quotation_Sign__RMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__rmf_g + System.IOUtils.TPath.DirectorySeparatorChar + role_list__sql__description__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + role_list__sql__description__drop__file_name_c + ').' );

      zts :=
        'comment on role ' +
        role_name_l +
        ' is null ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + roles_list__column__role_name__big_letter_c + Common.sql__word_replace_separator_c, role_name_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_role_description + ' ''' + role_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := roles_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_role_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( roles_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TRoles_Modify_F_Frame.Role__Description__Write_In_Log_MenuItemClick( Sender: TObject );
begin

  if   ( roles_sdbm = nil )
    or ( not roles_sdbm.Query__Active() )
    or ( roles_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Log_Memo.Lines.Add( '' );
  Log_Memo.Lines.Add(  roles_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString  );

end;

procedure TRoles_Modify_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( ssCtrl in Shift )
    and (  not ( ssAlt in Shift )  ) then
    Log_Memo.SelectAll();

end;

procedure TRoles_Modify_F_Frame.Roles_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
begin

  Common.DB_Grid_Draw_Column_Cell( sort__column_name_g, Roles_DBGrid, Rect, DataCol, Column, State );

end;

procedure TRoles_Modify_F_Frame.Roles_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_BACK then
    Modify__Revoke_ButtonClick( Sender )
  else
  if Key = VK_DELETE then
    Modify__Delete_ButtonClick( Sender )
  else
  if Key = VK_RETURN then
    Modify__Edit_ButtonClick( Sender )
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( roles_sdbm.Query__Active() )
    and ( roles_sdbm.Query__Record_Count > 0 )
    and ( Roles_DBGrid.SelectedField <> nil ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Roles_DBGrid.SelectedField.Value;
    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end
  else
  // R.
  if    ( Key = 82 )
    and ( Shift = [ ssCtrl ] ) then
    Refresh_ButtonClick( Refresh_Button );

end;

procedure TRoles_Modify_F_Frame.Roles_DBGridTitleClick( Column: TColumn );
begin

  if Column.Field = nil then
    Exit;


  if sort__column_name_g = Column.Field.FieldName then
    sort__direction_ascending_g := not sort__direction_ascending_g
  else
    sort__column_name_g := Column.Field.FieldName;

  roles_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );


  Role_Name_DBEditChange( nil ); // For FireDAC.

end;

end.
