unit Users_Modify_F;{12.PaŸ.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Translation,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Samples.Spin, Vcl.Menus;

type
  TUsers_Modify_F_Frame = class( TFrame )
    Buttons_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    User_Name_DBEdit: TDBEdit;
    User_Name_Etiquette_Label: TLabel;
    Users_DataSource: TDataSource;
    Users_DBGrid: TDBGrid;
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
    Users_PopupMenu: TPopupMenu;
    User__Delete_MenuItem: TMenuItem;
    N1: TMenuItem;
    User__Description__Set_MenuItem: TMenuItem;
    User__Description__Drop_MenuItem: TMenuItem;
    N2: TMenuItem;
    User__Description__Write_In_Log_MenuItem: TMenuItem;
    Modify__Values_Fields__Update_CheckBox: TCheckBox;
    Modify__Name__First_GroupBox: TGroupBox;
    Modify__Name__First_CheckBox: TCheckBox;
    Modify__Name__First_Edit: TEdit;
    Modify__Active_CheckBox: TCheckBox;
    Modify__Administrator_CheckBox: TCheckBox;
    Modify__Name__Middle_GroupBox: TGroupBox;
    Modify__Name__Middle_CheckBox: TCheckBox;
    Modify__Name__Middle_Edit: TEdit;
    Modify__Name__Last_GroupBox: TGroupBox;
    Modify__Name__Last_CheckBox: TCheckBox;
    Modify__Name__Last_Edit: TEdit;
    Log_Horizontal_Splitter: TSplitter;
    Modify__Password_GroupBox: TGroupBox;
    Modify__Password_CheckBox: TCheckBox;
    Modify__Password_Edit: TEdit;
    Modify__Select_All_Button: TButton;
    Modify__Unselect_All_Button: TButton;
    Modify__Administrator_GroupBox: TGroupBox;
    Modify__Administrator__Change_CheckBox: TCheckBox;

    procedure User_Name_DBEditChange( Sender: TObject );
    procedure Search_Change( Sender: TObject );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );

    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Modify__Select_Unselect_All_ButtonClick( Sender: TObject );
    procedure Modify__Add_ButtonClick( Sender: TObject );
    procedure Modify__Edit_ButtonClick( Sender: TObject );
    procedure Modify__Delete_ButtonClick( Sender: TObject );

    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );

    procedure User__Description__Set_MenuItemClick( Sender: TObject );
    procedure User__Description__Drop_MenuItemClick( Sender: TObject );
    procedure User__Description__Write_In_Log_MenuItemClick( Sender: TObject );

    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Users_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
    procedure Users_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Users_DBGridTitleClick( Column: TColumn );
  private
    { Private declarations }
    sort__direction_ascending_g,
    sql__quotation_sign__use__umf_g
      : boolean;

    database_type__umf_g,
    sort__column_name_g,
    sql__quotation_sign__umf_g,
    //word__active_g, //???
    word__administrator__grant_g,
    word__administrator__revoke_g,
    word__name__first_g,
    word__name__last_g,
    word__name__middle_g,
    word__password_g,
    word__user__alter_g,
    word__user__create_g
      : string;

    users_sdbm : Common.TSDBM;

    function Quotation_Sign__UMF() : string;
  public
    { Public declarations }
    procedure Data_Open__UMF();
    procedure Finish__UMF();
    procedure Options_Set__UMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
    procedure Prepare__UMF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
    procedure Translation__Apply__UMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
  end;

const
  users_list__file_name_c : string = 'Users_List__sql.txt';
  users_list__column__user__active_c : string = 'USER_ACTIVE';
  users_list__column__user__is_administrator_c : string = 'USER_IS_ADMINISTRATOR';
  users_list__column__user__name__first_c : string = 'USER__NAME__FIRST';
  users_list__column__user__name__last_c : string = 'USER__NAME__LAST';
  users_list__column__user__name__middle_c : string = 'USER__NAME__MIDDLE';
  //users_list__sql__active__file_name_c : string = 'User__Active__sql.txt';
  users_list__sql__administrator__grant__file_name_c : string = 'User__Administrator__Grant__sql.txt';
  users_list__sql__administrator__revoke__file_name_c : string = 'User__Administrator__Revoke__sql.txt';
  users_list__sql__description__drop__file_name_c : string = 'User__Description__Drop__sql.txt';
  users_list__sql__description__set__file_name_c : string = 'User__Description__Set__sql.txt';
  users_list__sql__name__first__file_name_c : string = 'User__Name__First__sql.txt';
  users_list__sql__name__last__file_name_c : string = 'User__Name__Last__sql.txt';
  users_list__sql__name__middle__file_name_c : string = 'User__Name__Middle__sql.txt';
  users_list__sql__password__file_name_c : string = 'User__Password__sql.txt';
  users_list__sql__user__alter__file_name_c : string = 'User__Alter__sql.txt';
  users_list__sql__user__create__file_name_c : string = 'User__Create__sql.txt';
  users_list__sql__user__drop__file_name_c : string = 'User__Drop__sql.txt';

implementation

uses
  Vcl.Clipbrd,

  Shared,
  Text__Edit_Memo;

{$R *.dfm}

procedure TUsers_Modify_F_Frame.Data_Open__UMF();
var
  i : integer;

  zts : string;
begin

  if   ( users_sdbm = nil )
    or ( users_sdbm.component_type__sdbm = Common.ct_none ) then
    Exit;


  //zts := Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__active__file_name_c;
  //
  //if not FileExists( zts ) then
  //  begin
  //
  //    Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__active__file_name_c + ').' );
  //
  //    word__active_g := ' __USER_ACTIVE__ ';
  //
  //  end
  //else
  //  begin
  //
  //    word__active_g := Common.Text__File_Load( zts );
  //
  //    word__active_g := StringReplace( word__active_g, #10, '', [] );
  //    word__active_g := StringReplace( word__active_g, #13, '', [] );
  //
  //  end;
  //
  //Log_Memo.Lines.Add( 'Active: ' + word__active_g + '.' );


  zts := Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__administrator__grant__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__administrator__grant__file_name_c + ').' );

      word__administrator__grant_g := 'grant admin role ';

    end
  else
    begin

      word__administrator__grant_g := Common.Text__File_Load( zts );

      word__administrator__grant_g := StringReplace( word__administrator__grant_g, #10, '', [] );
      word__administrator__grant_g := StringReplace( word__administrator__grant_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Administrator grant: ' + word__administrator__grant_g + '.' );


  zts := Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__administrator__revoke__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__administrator__revoke__file_name_c + ').' );

      word__administrator__revoke_g := 'revoke admin role ';

    end
  else
    begin

      word__administrator__revoke_g := Common.Text__File_Load( zts );

      word__administrator__revoke_g := StringReplace( word__administrator__revoke_g, #10, '', [] );
      word__administrator__revoke_g := StringReplace( word__administrator__revoke_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Administrator revoke: ' + word__administrator__revoke_g + '.' );


  zts := Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__name__first__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__name__first__file_name_c + ').' );

      word__name__first_g := 'firstname ''__USER__NAME__FIRST__'' ';

    end
  else
    begin

      word__name__first_g := Common.Text__File_Load( zts );

      word__name__first_g := StringReplace( word__name__first_g, #10, '', [] );
      word__name__first_g := StringReplace( word__name__first_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'First name: ' + word__name__first_g + '.' );


  zts := Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__name__last__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__name__last__file_name_c + ').' );

      word__name__last_g := 'lastname ''__USER__NAME__LAST__'' ';

    end
  else
    begin

      word__name__last_g := Common.Text__File_Load( zts );

      word__name__last_g := StringReplace( word__name__last_g, #10, '', [] );
      word__name__last_g := StringReplace( word__name__last_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Last name: ' + word__name__last_g + '.' );


  zts := Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__name__middle__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__name__middle__file_name_c + ').' );

      word__name__middle_g := 'middlename ''__USER__NAME__MIDDLE__'' ';

    end
  else
    begin

      word__name__middle_g := Common.Text__File_Load( zts );

      word__name__middle_g := StringReplace( word__name__middle_g, #10, '', [] );
      word__name__middle_g := StringReplace( word__name__middle_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Middle name: ' + word__name__middle_g + '.' );


  zts := Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__password__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__password__file_name_c + ').' );

      word__password_g := 'password ''__USER__PASSWORD__'' ';

    end
  else
    begin

      word__password_g := Common.Text__File_Load( zts );

      word__password_g := StringReplace( word__password_g, #10, '', [] );
      word__password_g := StringReplace( word__password_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Password: ' + word__password_g + '.' );


  zts := Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__user__alter__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__user__alter__file_name_c + ').' );

      word__user__alter_g := 'alter user ';

    end
  else
    begin

      word__user__alter_g := Common.Text__File_Load( zts );

      word__user__alter_g := StringReplace( word__user__alter_g, #10, '', [] );
      word__user__alter_g := StringReplace( word__user__alter_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'User alter: ' + word__user__alter_g + '.' );


  zts := Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__user__create__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__user__create__file_name_c + ').' );

      word__user__create_g := 'create user ';

    end
  else
    begin

      word__user__create_g := Common.Text__File_Load( zts );

      word__user__create_g := StringReplace( word__user__create_g, #10, '', [] );
      word__user__create_g := StringReplace( word__user__create_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'User create: ' + word__user__create_g + '.' );


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__file_name_c + ').' );

      zts :=
        'select SEC$USERS.SEC$USER_NAME as USER_NAME ' +
        '     , SEC$USERS.SEC$FIRST_NAME as USER__NAME__FIRST ' +
        '     , SEC$USERS.SEC$MIDDLE_NAME as USER__NAME__MIDDLE ' +
        '     , SEC$USERS.SEC$LAST_NAME as USER__NAME__LAST ' +
        '     , iif( SEC$USERS.SEC$ACTIVE = true, ''' + Common.db_grid__positive_value_c + ''', '''' ) as USER_ACTIVE ' +
        '     , iif( SEC$USERS.SEC$ADMIN = true, ''' + Common.db_grid__positive_value_c + ''', '''' ) as USER_IS_ADMINISTRATOR ' +
        //'     , cast(  substring( SEC$USERS.SEC$DESCRIPTION from 1 for 10000 ) as varchar( 10000 )  ) as DESCRIPTION_VALUE__CAST ' +
        '     , cast(  substring( SEC$USERS.SEC$DESCRIPTION from 1 for 8191 ) as varchar( 8191 )  ) as DESCRIPTION_VALUE__CAST ' + // FireDAC limit default - FDConnection1.FormatOptions.MaxStringSize = 32767 bytes ( / 4 = 8191,75 ).
        '     , SEC$USERS.SEC$DESCRIPTION as DESCRIPTION_VALUE ' +
        '     , SEC$USERS.SEC$PLUGIN ' +
        'from SEC$USERS ';

    end;


  Screen.Cursor := crHourGlass;


  if users_sdbm.Query__Active() then
    users_sdbm.Query__Close();

  users_sdbm.Query__Sql__Set( zts );


  Log_Memo.Lines.Add( zts );


  try
    users_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_users_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;


  Screen.Cursor := crDefault;


  if users_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( users_sdbm.Operation_Duration_Get() );


      try
        users_sdbm.Query__Field_By_Name( users_list__column__user__active_c ).AsString;
      except
        on E : Exception do
          begin

            users_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_user_activity + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;

      if users_sdbm.Query__Active() then
        try
          users_sdbm.Query__Field_By_Name( users_list__column__user__is_administrator_c ).AsString;
        except
          on E : Exception do
            begin

              users_sdbm.Query__Close();

              Log_Memo.Lines.Add( E.Message );

              Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_user_administrator_privilege + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            end;
        end;

        if users_sdbm.Query__Active() then
          try
            User_Name_DBEdit.DataField := Common.name__user__name__big_letters_c;
            users_sdbm.Query__Field_By_Name( Common.name__user__name__big_letters_c ).AsString;
            users_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );
          except
            on E : Exception do
              begin

                users_sdbm.Query__Close();

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_user_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

              end;
          end;


      for i := 0 to Users_DBGrid.Columns.Count - 1 do
        begin

          if   ( Users_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value_c )
            or ( Users_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value__cast_c ) then
            begin

              if Users_DBGrid.Columns.Items[ i ].Width > 500 then
                Users_DBGrid.Columns.Items[ i ].Width := 500;

            end
          else
            if Users_DBGrid.Columns.Items[ i ].Width > 200 then
              Users_DBGrid.Columns.Items[ i ].Width := 200;

        end;


      Self.Translation__Apply__UMF( Translation.tak_Grid );


      Common.Data_Value_Format__Set( users_sdbm, Log_Memo );

    end;

end;

procedure TUsers_Modify_F_Frame.Finish__UMF();
begin

  FreeAndNil( users_sdbm );

end;

function TUsers_Modify_F_Frame.Quotation_Sign__UMF() : string;
begin

  if sql__quotation_sign__use__umf_g then
    begin

      Result := sql__quotation_sign__umf_g;

    end
  else
    Result := '';

end;

procedure TUsers_Modify_F_Frame.Options_Set__UMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
begin

  sql__quotation_sign__use__umf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__umf_g := sql__quotation_sign_f;


  if users_sdbm <> nil then
    begin

      users_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

      users_sdbm.Data_Source__Data_Set__Set( Users_DataSource );

    end;


  Self.Translation__Apply__UMF( Translation.tak_Self );

end;

procedure TUsers_Modify_F_Frame.Prepare__UMF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
begin

  Self.Name := '';

  database_type__umf_g := databases_r_f.database_type;
  sort__column_name_g := Common.name__user__name__big_letters_c;
  sort__direction_ascending_g := true;


  users_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Self.Options_Set__UMF( component_type_f, databases_r_f.sql__quotation_sign, sql__quotation_sign__use_f );


  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );

end;

procedure TUsers_Modify_F_Frame.Translation__Apply__UMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
var
  i : integer;
begin

  if tak_f in [ Translation.tak_All, Translation.tak_Self ] then
    Translation.Translation__Apply( Self );


  if tak_f in [ Translation.tak_All, Translation.tak_Grid ] then
    for i := 0 to Users_DBGrid.Columns.Count - 1 do
      if Users_DBGrid.Columns.Items[ i ].FieldName = Common.name__user__name__big_letters_c then
        Users_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__user__name
      else
      if Users_DBGrid.Columns.Items[ i ].FieldName = users_list__column__user__name__first_c then
        Users_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__first_name
      else
      if Users_DBGrid.Columns.Items[ i ].FieldName = users_list__column__user__name__middle_c then
        Users_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__middle_name
      else
      if Users_DBGrid.Columns.Items[ i ].FieldName = users_list__column__user__name__last_c then
        Users_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__last_name
      else
      if Users_DBGrid.Columns.Items[ i ].FieldName = users_list__column__user__active_c then
        Users_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__active
      else
      if Users_DBGrid.Columns.Items[ i ].FieldName = users_list__column__user__is_administrator_c then
        Users_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__administrator
      else
      if Users_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value__cast_c then
        Users_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__description
      else
        Users_DBGrid.Columns.Items[ i ].Title.Caption := Common.Column__Name_To_Grid_Caption( Users_DBGrid.Columns.Items[ i ].FieldName );

end;

procedure TUsers_Modify_F_Frame.User_Name_DBEditChange( Sender: TObject );
begin

  if    ( users_sdbm <> nil )
    and ( users_sdbm.Query__Active() ) then
    begin

      Record_Number__Records_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', users_sdbm.Query__Record_Number() )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', users_sdbm.Query__Record_Count() )  );

      if Modify__Values_Fields__Update_CheckBox.Checked then
        begin

          try
            Modify__Active_CheckBox.Checked := users_sdbm.Query__Field_By_Name( users_list__column__user__active_c ).AsString = Common.db_grid__positive_value_c;
          except
          end;

          try
            Modify__Administrator_CheckBox.Checked := users_sdbm.Query__Field_By_Name( users_list__column__user__is_administrator_c ).AsString = Common.db_grid__positive_value_c;
          except
          end;

          try
            Modify__Name__First_Edit.Text := users_sdbm.Query__Field_By_Name( users_list__column__user__name__first_c ).AsString;
          except
          end;

          try
            Modify__Name__Last_Edit.Text := users_sdbm.Query__Field_By_Name( users_list__column__user__name__last_c ).AsString;
          except
          end;

          try
            Modify__Name__Middle_Edit.Text := users_sdbm.Query__Field_By_Name( users_list__column__user__name__middle_c ).AsString;
          except
          end;

        end;

    end
  else
    Record_Number__Records_Count_Label.Caption := '0 / 0';

end;

procedure TUsers_Modify_F_Frame.Search_Change( Sender: TObject );
var
  locate_options : Data.DB.TLocateOptions;
begin

  if   ( users_sdbm = nil )
    or ( not users_sdbm.Query__Active() ) then
    Exit;


  locate_options := [];

  if Search__Case_Insensitive_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loCaseInsensitive ];

  if Search__Partial_Key_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loPartialKey ];


  if users_sdbm.Query__Locate( sort__column_name_g, Search_Edit.Text, locate_options ) then
    Search_Edit.Color := clWindow
  else
    begin

      Search_Edit.Color := Common.color__red__light_c;


      users_sdbm.Query__Disable_Controls();

      users_sdbm.Query__First();

      while not users_sdbm.Query__Eof do
        begin

          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  users_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

          users_sdbm.Query__Next();

        end;

      users_sdbm.Query__Enable_Controls();

    end;

end;

procedure TUsers_Modify_F_Frame.Search__Next_ButtonClick( Sender: TObject );
begin

  if   ( users_sdbm = nil )
    or ( not users_sdbm.Query__Active() ) then
    Exit;


  users_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not users_sdbm.Query__Eof do
    begin

      users_sdbm.Query__Next();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  users_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  users_sdbm.Query__Enable_Controls();

end;

procedure TUsers_Modify_F_Frame.Search__Prior_ButtonClick( Sender: TObject );
begin

  if   ( users_sdbm = nil )
    or ( not users_sdbm.Query__Active() ) then
    Exit;


  users_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not users_sdbm.Query__Bof do
    begin

      users_sdbm.Query__Prior();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  users_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  users_sdbm.Query__Enable_Controls();

end;

procedure TUsers_Modify_F_Frame.Refresh_ButtonClick( Sender: TObject );
var
  primary_key_value_l : string;
begin

  if   ( users_sdbm = nil )
    or ( not users_sdbm.Query__Active() ) then
    Exit;


  primary_key_value_l := users_sdbm.Query__Field_By_Name( Common.name__user__name__big_letters_c ).AsString;

  users_sdbm.Query__Requery();


  if    ( Sender <> nil )
    and ( TComponent(Sender).Name = Refresh_Button.Name ) then
    begin

      Log_Memo.Lines.Add( users_sdbm.Operation_Duration_Get() );

    end;


  users_sdbm.Query__Locate( Common.name__user__name__big_letters_c, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );

end;

procedure TUsers_Modify_F_Frame.Modify__Select_Unselect_All_ButtonClick( Sender: TObject );
var
  select_all_l : boolean;
begin

  if    ( Sender <> nil )
    and ( TComponent(Sender).Name = Modify__Unselect_All_Button.Name ) then
    select_all_l := false
  else
    select_all_l := true;


  //Modify__Active_CheckBox.Checked := select_all_l;

  if not select_all_l then
    Modify__Administrator_CheckBox.Checked := select_all_l;

  Modify__Name__First_CheckBox.Checked := select_all_l;
  Modify__Name__Last_CheckBox.Checked := select_all_l;
  Modify__Name__Middle_CheckBox.Checked := select_all_l;
  Modify__Password_CheckBox.Checked := select_all_l;

end;

procedure TUsers_Modify_F_Frame.Modify__Add_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  information_l,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( users_sdbm = nil )
    or ( not users_sdbm.Query__Active() ) then
    Exit;


  if Trim( Modify__Name_Edit.Text ) = '' then
    begin

      Modify__Name_Edit.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.user_name_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;

  if Trim( Modify__Password_Edit.Text ) = '' then
    begin

      Modify__Password_Edit.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.user_password_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  zts :=
    word__user__create_g +
    Self.Quotation_Sign__UMF() + Modify__Name_Edit.Text + Self.Quotation_Sign__UMF() + ' ' +
    StringReplace( word__password_g, Common.sql__word_replace_separator_c + Common.name__user__password_c + Common.sql__word_replace_separator_c, Modify__Password_Edit.Text, [ rfReplaceAll ] );

  information_l := '';


  //if Modify__Active_CheckBox.Checked then
  //  begin
  //
  //    zts := zts +
  //      StringReplace( word__active_g, Common.sql__word_replace_separator_c + users_list__column__user__active_c + Common.sql__word_replace_separator_c, Modify__Active_CheckBox, [ rfReplaceAll ] );
  //
  //    information_l := information_l +
  //      #13 + ' + ' + Modify__Active_CheckBox.Caption + #13;
  //
  //  end;

  if    ( Modify__Administrator__Change_CheckBox.Checked )
    and ( Modify__Administrator_CheckBox.Checked ) then
    begin

      zts := zts +
        word__administrator__grant_g;

      information_l := information_l +
        #13 + ' + ' + Modify__Administrator_CheckBox.Caption + #13;

    end;


  if Modify__Name__First_CheckBox.Checked then
    begin

      zts := zts +
        StringReplace( word__name__first_g, Common.sql__word_replace_separator_c + users_list__column__user__name__first_c + Common.sql__word_replace_separator_c, Modify__Name__First_Edit.Text, [ rfReplaceAll ] );

      information_l := information_l +
        ' ' + Modify__Name__First_Edit.Text;

    end;


  if Modify__Name__Last_CheckBox.Checked then
    begin

      zts := zts +
        StringReplace( word__name__last_g, Common.sql__word_replace_separator_c + users_list__column__user__name__last_c + Common.sql__word_replace_separator_c, Modify__Name__Last_Edit.Text, [ rfReplaceAll ] );

      information_l := information_l +
        ' ' + Modify__Name__Last_Edit.Text;

    end;

  if Modify__Name__Middle_CheckBox.Checked then
    begin

      zts := zts +
        StringReplace( word__name__middle_g, Common.sql__word_replace_separator_c + users_list__column__user__name__middle_c + Common.sql__word_replace_separator_c, Modify__Name__Middle_Edit.Text, [ rfReplaceAll ] );

      information_l := information_l +
        ' ' + Modify__Name__Middle_Edit.Text;

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.add_user + ' ''' + Self.Quotation_Sign__UMF() + Modify__Name_Edit.Text + Self.Quotation_Sign__UMF() + ''' ' + information_l + '?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := users_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_add_user );


  if ztb then
    begin

      Log_Memo.Lines.Add( users_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      users_sdbm.Query__Locate( Common.name__user__name__big_letters_c, Modify__Name_Edit.Text, [ Data.DB.loCaseInsensitive ] );


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TUsers_Modify_F_Frame.Modify__Edit_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  information_l,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( users_sdbm = nil )
    or ( not users_sdbm.Query__Active() )
    or ( users_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  if    (  Modify__Password_CheckBox.Checked )
    and (  Trim( Modify__Password_Edit.Text ) = ''  ) then
    begin

      Modify__Password_Edit.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.user_password_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  zts :=
    word__user__alter_g +
    Self.Quotation_Sign__UMF() + users_sdbm.Query__Field_By_Name( Common.name__user__name__big_letters_c ).AsString + Self.Quotation_Sign__UMF() + ' ';

  information_l := '';

  //if Modify__Active_CheckBox.Checked then
  //  begin
  //
  //    zts := zts +
  //      StringReplace( word__active_g, Common.sql__word_replace_separator_c + users_list__column__user__active_c + Common.sql__word_replace_separator_c, Modify__Active_CheckBox, [ rfReplaceAll ] );
  //
  //    if users_sdbm.Query__Field_By_Name( users_list__column__user__active_c ).AsString <> Common.db_grid__positive_value_c then
  //      information_l := information_l +
  //        #13 + ' + ' + Modify__Administrator_CheckBox.Caption + #13;
  //
  //  end
  //else
  //  begin
  //
  //    zts := zts +
  //      StringReplace( word__active_g, Common.sql__word_replace_separator_c + users_list__column__user__active_c + Common.sql__word_replace_separator_c, Modify__Active_CheckBox, [ rfReplaceAll ] );
  //
  //
  //    if users_sdbm.Query__Field_By_Name( users_list__column__user__active_c ).AsString = Common.db_grid__positive_value_c then
  //      information_l := information_l +
  //        #13 + ' - ' + Modify__Active_CheckBox.Caption + #13;
  //
  //  end;

  if Modify__Administrator__Change_CheckBox.Checked then
    if Modify__Administrator_CheckBox.Checked then
      begin

        zts := zts +
          word__administrator__grant_g;

        if users_sdbm.Query__Field_By_Name( users_list__column__user__is_administrator_c ).AsString <> Common.db_grid__positive_value_c then
          information_l := information_l +
            #13 + ' + ' + Modify__Administrator_CheckBox.Caption + #13;

      end
    else
      begin

        zts := zts +
          word__administrator__revoke_g;


        if users_sdbm.Query__Field_By_Name( users_list__column__user__is_administrator_c ).AsString = Common.db_grid__positive_value_c then
          information_l := information_l +
            #13 + ' - ' + Modify__Administrator_CheckBox.Caption + #13;

      end;

  if Modify__Name__First_CheckBox.Checked then
    begin

      zts := zts +
        StringReplace( word__name__first_g, Common.sql__word_replace_separator_c + users_list__column__user__name__first_c + Common.sql__word_replace_separator_c, Modify__Name__First_Edit.Text, [ rfReplaceAll ] );

      information_l := information_l +
        ' ' + Modify__Name__First_Edit.Text;

    end;

  if Modify__Name__Last_CheckBox.Checked then
    begin

      zts := zts +
        StringReplace( word__name__last_g, Common.sql__word_replace_separator_c + users_list__column__user__name__last_c + Common.sql__word_replace_separator_c, Modify__Name__Last_Edit.Text, [ rfReplaceAll ] );

      information_l := information_l +
        ' ' + Modify__Name__Last_Edit.Text;

    end;

  if Modify__Name__Middle_CheckBox.Checked then
    begin

      zts := zts +
        StringReplace( word__name__middle_g, Common.sql__word_replace_separator_c + users_list__column__user__name__middle_c + Common.sql__word_replace_separator_c, Modify__Name__Middle_Edit.Text, [ rfReplaceAll ] );

      information_l := information_l +
        ' ' + Modify__Name__Middle_Edit.Text;

    end;

  if Modify__Password_CheckBox.Checked then
    begin

      zts := zts +
        StringReplace( word__password_g, Common.sql__word_replace_separator_c + Common.name__user__password_c + Common.sql__word_replace_separator_c, Modify__Password_Edit.Text, [ rfReplaceAll ] );

      information_l := information_l +
        #13 + Modify__Password_GroupBox.Caption;

    end;


  Log_Memo.Lines.Add( zts );


                                                                                                                             // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.
  if Application.MessageBox(  PChar(Translation.translation__messages_r.set_user_values__1 + ' ''' + Self.Quotation_Sign__UMF() + Trim( users_sdbm.Query__Field_By_Name( Common.name__user__name__big_letters_c ).AsString ) + Self.Quotation_Sign__UMF() + ''' ' + Translation.translation__messages_r.set_user_values__2 + ' ' + information_l + '?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION  ) <> IDYES then
    Exit;


  ztb := users_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_user );


  if ztb then
    begin

      Log_Memo.Lines.Add( users_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TUsers_Modify_F_Frame.Modify__Delete_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( users_sdbm = nil )
    or ( not users_sdbm.Query__Active() )
    or ( users_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__user__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__user__drop__file_name_c + ').' );

      zts :=
        'drop user ' +
        Self.Quotation_Sign__UMF() + users_sdbm.Query__Field_By_Name( Common.name__user__name__big_letters_c ).AsString + Self.Quotation_Sign__UMF() +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__user__name__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__UMF() + users_sdbm.Query__Field_By_Name( Common.name__user__name__big_letters_c ).AsString + Self.Quotation_Sign__UMF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_user + ' ''' + Self.Quotation_Sign__UMF() + users_sdbm.Query__Field_By_Name( Common.name__user__name__big_letters_c ).AsString + Self.Quotation_Sign__UMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := users_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_user );


  if ztb then
    begin

      Log_Memo.Lines.Add( users_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TUsers_Modify_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Buttons_Panel.Width := 1;

end;

procedure TUsers_Modify_F_Frame.User__Description__Set_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  modal_result : TModalResult;

  zts,
  description_value_l,
  error_message_l,
  user_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( users_sdbm = nil )
    or ( not users_sdbm.Query__Active() )
    or ( users_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Text__Edit_Memo.Text__Edit_Memo_Form := Text__Edit_Memo.TText__Edit_Memo_Form.Create( Application );
  Text__Edit_Memo.Text__Edit_Memo_Form.text_value := users_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
  Text__Edit_Memo.Text__Edit_Memo_Form.quotation_mark_duplicate := true;
  Text__Edit_Memo.Text__Edit_Memo_Form.Caption := Translation.translation__messages_r.word__description___user;
  Text__Edit_Memo.Text__Edit_Memo_Form.Text_Type_Set( Text__Edit_Memo.tt_Memo );
  modal_result := Text__Edit_Memo.Text__Edit_Memo_Form.ShowModal();

  if modal_result = mrOk then
    description_value_l := Text__Edit_Memo.Text__Edit_Memo_Form.text_value;

  FreeAndNil( Text__Edit_Memo.Text__Edit_Memo_Form );


  user_name_l := Self.Quotation_Sign__UMF() + Trim(  users_sdbm.Query__Field_By_Name( Common.name__user__name__big_letters_c ).AsString  ) + Self.Quotation_Sign__UMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__description__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__description__set__file_name_c + ').' );

      zts :=
        'comment on user ' +
        user_name_l +
        ' is ''' + description_value_l + ''' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__user__name__big_letters_c + Common.sql__word_replace_separator_c, user_name_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if modal_result <> mrOk then
    Exit;


  ztb := users_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_user_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( users_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TUsers_Modify_F_Frame.User__Description__Drop_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l,
  user_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( users_sdbm = nil )
    or ( not users_sdbm.Query__Active() )
    or ( users_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  user_name_l := Self.Quotation_Sign__UMF() + Trim(  users_sdbm.Query__Field_By_Name( Common.name__user__name__big_letters_c ).AsString  ) + Self.Quotation_Sign__UMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__description__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__umf_g ) + users_list__sql__description__drop__file_name_c + ').' );

      zts :=
        'comment on user ' +
        user_name_l +
        ' is null ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__user__name__big_letters_c + Common.sql__word_replace_separator_c, user_name_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_user_description + ' ''' + user_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := users_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_user_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( users_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TUsers_Modify_F_Frame.User__Description__Write_In_Log_MenuItemClick( Sender: TObject );
begin

  if   ( users_sdbm = nil )
    or ( not users_sdbm.Query__Active() )
    or ( users_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Log_Memo.Lines.Add( '' );
  Log_Memo.Lines.Add(  users_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString  );

end;

procedure TUsers_Modify_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TUsers_Modify_F_Frame.Users_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
begin

  if    (
          not (
                   ( gdFocused in State )
                or ( gdSelected in State )
              )
        )
    and ( Column.Field <> nil )
    and ( Column.Field.FullName = users_list__column__user__active_c )
    and (  (Sender as TDBGrid).DataSource.DataSet.FieldByName( users_list__column__user__active_c ).AsString = Common.db_grid__positive_value_c  ) then
    begin

      Users_DBGrid.Canvas.Brush.Color := clMoneyGreen;

      Users_DBGrid.DefaultDrawColumnCell( Rect, DataCol, Column, State );

    end;

  if    (
          not (
                   ( gdFocused in State )
                or ( gdSelected in State )
              )
        )
    and ( Column.Field <> nil )
    and ( Column.Field.FullName = users_list__column__user__is_administrator_c )
    and (  (Sender as TDBGrid).DataSource.DataSet.FieldByName( users_list__column__user__is_administrator_c ).AsString = Common.db_grid__positive_value_c  ) then
    begin

      Users_DBGrid.Canvas.Brush.Color := Common.color__red__light_c;

      Users_DBGrid.DefaultDrawColumnCell( Rect, DataCol, Column, State );

    end;


  Common.DB_Grid_Draw_Column_Cell( sort__column_name_g, Users_DBGrid, Rect, DataCol, Column, State );

end;

procedure TUsers_Modify_F_Frame.Users_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_DELETE then
    Modify__Delete_ButtonClick( Sender )
  else
  if Key = VK_RETURN then
    Modify__Edit_ButtonClick( Sender )
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( users_sdbm.Query__Active() )
    and ( users_sdbm.Query__Record_Count > 0 )
    and ( Users_DBGrid.SelectedField <> nil ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Users_DBGrid.SelectedField.Value;
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

procedure TUsers_Modify_F_Frame.Users_DBGridTitleClick( Column: TColumn );
begin

  if Column.Field = nil then
    Exit;


  if sort__column_name_g = Column.Field.FieldName then
    sort__direction_ascending_g := not sort__direction_ascending_g
  else
    sort__column_name_g := Column.Field.FieldName;

  users_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );


  User_Name_DBEditChange( nil ); // For FireDAC.

end;

end.
