unit Permissions_Modify_F;{11.Sie.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Translation,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Samples.Spin, Vcl.CheckLst, Vcl.Menus;

type
  TPermissions_Object_Type = ( pot_function, pot_procedure_stored, pot_table );

  TPermissions_Modify_F_Frame = class( TFrame )
    Buttons_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    User_Name_DBEdit: TDBEdit;
    User_Name_Etiquette_Label: TLabel;
    Permissions_DataSource: TDataSource;
    Permissions_DBGrid: TDBGrid;
    Log_Memo: TMemo;
    Modify_GroupBox: TGroupBox;
    Modify__Grant_Button: TButton;
    Modify__Grant__All_Button: TButton;
    Modify__Revoke_Button: TButton;
    Modify__Revoke__All_Button: TButton;
    Record_Number__Records_Count_Label: TLabel;
    Refresh_Button: TButton;
    Search_Edit: TEdit;
    Search_GroupBox: TGroupBox;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Next_Button: TButton;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Prior_Button: TButton;
    Vertical_Splitter: TSplitter;
    Modify__Privileges_Name_Etiquette_Label: TLabel;
    Modify__Privileges_Name_CheckListBox: TCheckListBox;
    Log_Horizontal_Splitter: TSplitter;
    Permissions_PopupMenu: TPopupMenu;
    Modify__Grant_MenuItem: TMenuItem;
    Modify__Grant__All_Button_MenuItem: TMenuItem;
    Modify__Revoke_MenuItem: TMenuItem;
    N1: TMenuItem;
    Modify__Revoke__All_MenuItem: TMenuItem;
    Modify__Permissions__Row_One_CheckBox: TCheckBox;
    Modify__Permissions__Show_All_Users_CheckBox: TCheckBox;

    procedure Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );

    procedure User_Name_DBEditChange( Sender: TObject );
    procedure Search_Change( Sender: TObject );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );

    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Modify__Grant_ButtonClick( Sender: TObject );
    procedure Modify__Grant__All_ButtonClick( Sender: TObject );
    procedure Modify__Revoke_ButtonClick( Sender: TObject );
    procedure Modify__Revoke__All_ButtonClick( Sender: TObject );

    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );
    procedure Modify__Privileges_Name_CheckListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Permissions_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
    procedure Permissions_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Permissions_DBGridTitleClick( Column: TColumn );
  private
    { Private declarations }
    sort__direction_ascending_g,
    sql__quotation_sign__use__pmf_g,
    values_logged_g, // Values log only once.
    values_logged__row_one_g // Values log only once.
      : boolean;

    database_type__pmf_g,
    sort__column_name_g,
    sql__quotation_sign__pmf_g,
    table_name__pmf_g
      : string;

    permissions_object_type_g : TPermissions_Object_Type;

    permissions_sdbm : Common.TSDBM;

    procedure Parent_Tab_Switch( const prior_f : boolean = false );
    function Quotation_Sign__PMF() : string;
  public
    { Public declarations }
    parent_supreme_tab_sheet : Vcl.Controls.TWinControl;

    procedure Data_Open__PMF();
    procedure Finish__PMF();
    procedure Highlight__Font__Set__PMF();
    procedure Options_Set__PMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
    procedure Prepare__PMF( const table_name_f, database_type_f, sql__quotation_sign_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const permissions_object_type_f : TPermissions_Object_Type; const sql__quotation_sign__use_f : boolean );
    procedure Translation__Apply__PMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
  end;

const
  permissions_list__column__privilege_symbol_c : string = 'PRIVILEGE';
  permissions_list__file_name_c : string = 'Table__Permissions_List__sql.txt';
  permissions_list__parameter__all_users_c : string = 'all_users';
  permissions_list__privileges_list__name_c : string = 'PERMISSIONS_LIST';
  permissions_list__sql__privileges__grant__all_on_all__file_name_c : string = 'Table__Permissions__Privileges__Grant__All_On_All__sql.txt';
  permissions_list__sql__privileges__grant__function__file_name_c : string = 'Table__Permissions__Privileges__Grant__Function__sql.txt';
  permissions_list__sql__privileges__grant__procedure__file_name_c : string = 'Table__Permissions__Privileges__Grant__Procedure__sql.txt';
  permissions_list__sql__privileges__grant__table__file_name_c : string = 'Table__Permissions__Privileges__Grant__Table__sql.txt';
  permissions_list__sql__privileges__revoke__all_on_all__file_name_c : string = 'Table__Permissions__Privileges__Revoke__All_On_All__sql.txt';
  permissions_list__sql__privileges__revoke__function__file_name_c : string = 'Table__Permissions__Privileges__Revoke__Function__sql.txt';
  permissions_list__sql__privileges__revoke__procedure__file_name_c : string = 'Table__Permissions__Privileges__Revoke__Procedure__sql.txt';
  permissions_list__sql__privileges__revoke__table__file_name_c : string = 'Table__Permissions__Privileges__Revoke__Table__sql.txt';
  permissions_list__row_one__file_name_c : string = 'Table__Permissions_List__Row_One__sql.txt';
  permissions__privileges_list__procedure__file_name_c : string = 'Table__Permissions__Privileges_List__Procedure.txt';
  permissions__privileges_list__table__file_name_c : string = 'Table__Permissions__Privileges_List__Table.txt';

implementation

uses
  Vcl.Clipbrd,
  Vcl.ComCtrls,

  Shared;

{$R *.dfm}

procedure TPermissions_Modify_F_Frame.Data_Open__PMF();
var
  i : integer;

  zts : string;
begin

  if   ( permissions_sdbm = nil )
    or ( permissions_sdbm.component_type__sdbm = Common.ct_none ) then
    Exit;


  Screen.Cursor := crHourGlass;

  if permissions_sdbm.Query__Active() then
    permissions_sdbm.Query__Close();

  if Modify__Permissions__Row_One_CheckBox.Checked then
    zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__row_one__file_name_c  )
  else
    zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      if Modify__Permissions__Row_One_CheckBox.Checked then
        Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__row_one__file_name_c + ').' )
      else
        Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__file_name_c + ').' );

      if Modify__Permissions__Row_One_CheckBox.Checked then
        zts :=
          'select t_t.USER_NAME ' +
          ' ' +
          '     , ( ' +
          '         select iif(  count( RDB$USER_PRIVILEGES.RDB$USER ) > 0, ''' + Common.db_grid__positive_value_c + ''', ''''  ) ' +
          '         from RDB$USER_PRIVILEGES ' +
          '         where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '           and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '           and RDB$USER_PRIVILEGES.RDB$PRIVILEGE = ''A'' ' +
          '       ) as ALL_ ' +
          ' ' +
          '     , ( ' +
          '         select iif(  count( RDB$USER_PRIVILEGES.RDB$USER ) > 0, ''' + Common.db_grid__positive_value_c + ''', ''''  ) ' +
          '         from RDB$USER_PRIVILEGES ' +
          '         where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '           and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '           and RDB$USER_PRIVILEGES.RDB$PRIVILEGE = ''S'' ' +
          '       ) as SELECT_ ' +
          ' ' +
          '     , ( ' +
          '         select iif(  count( RDB$USER_PRIVILEGES.RDB$USER ) > 0, ''' + Common.db_grid__positive_value_c + ''', ''''  ) ' +
          '         from RDB$USER_PRIVILEGES ' +
          '         where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '           and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '           and RDB$USER_PRIVILEGES.RDB$PRIVILEGE = ''I'' ' +
          '       ) as INSERT_ ' +
          ' ' +
          '     , ( ' +
          '         select iif(  count( RDB$USER_PRIVILEGES.RDB$USER ) > 0, ''' + Common.db_grid__positive_value_c + ''', ''''  ) ' +
          '         from RDB$USER_PRIVILEGES ' +
          '         where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '           and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '           and RDB$USER_PRIVILEGES.RDB$PRIVILEGE = ''U'' ' +
          '       ) as UPDATE_ ' +
          ' ' +
          '     , ( ' +
          '         select iif(  count( RDB$USER_PRIVILEGES.RDB$USER ) > 0, ''' + Common.db_grid__positive_value_c + ''', ''''  ) ' +
          '         from RDB$USER_PRIVILEGES ' +
          '         where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '           and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '           and RDB$USER_PRIVILEGES.RDB$PRIVILEGE = ''D'' ' +
          '       ) as DELETE_ ' +
          ' ' +
          '     , ( ' +
          '         select iif(  count( RDB$USER_PRIVILEGES.RDB$USER ) > 0, ''' + Common.db_grid__positive_value_c + ''', ''''  ) ' +
          '         from RDB$USER_PRIVILEGES ' +
          '         where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '           and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '           and RDB$USER_PRIVILEGES.RDB$PRIVILEGE = ''X'' ' +
          '       ) as EXECUTING_ ' +
          ' ' +
          ' ' +
          '     , ( ' +
          '         select iif(  count( RDB$USER_PRIVILEGES.RDB$USER ) > 0, ''' + Common.db_grid__positive_value_c + ''', ''''  ) ' +
          '         from RDB$USER_PRIVILEGES ' +
          '         where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '           and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '           and RDB$USER_PRIVILEGES.RDB$PRIVILEGE = ''R'' ' +
          '       ) as REFERENCES_ ' +
          ' ' +
          '     , ( ' +
          '         select iif(  count( RDB$USER_PRIVILEGES.RDB$USER ) > 0, ''' + Common.db_grid__positive_value_c + ''', ''''  ) ' +
          '         from RDB$USER_PRIVILEGES ' +
          '         where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '           and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '           and RDB$USER_PRIVILEGES.RDB$PRIVILEGE = ''G'' ' +
          '       ) as USAGE_ ' +
          ' ' +
          '     , ( ' +
          '         select iif(  count( RDB$USER_PRIVILEGES.RDB$USER ) > 0, ''' + Common.db_grid__positive_value_c + ''', ''''  ) ' +
          '         from RDB$USER_PRIVILEGES ' +
          '         where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '           and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '           and RDB$USER_PRIVILEGES.RDB$PRIVILEGE = ''M'' ' +
          '       ) as ROLE_MEMBERSHIP ' +
          ' ' +
          '     , ( ' +
          '         select iif(  count( RDB$USER_PRIVILEGES.RDB$USER ) > 0, ''' + Common.db_grid__positive_value_c + ''', ''''  ) ' +
          '         from RDB$USER_PRIVILEGES ' +
          '         where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '           and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '           and RDB$USER_PRIVILEGES.RDB$PRIVILEGE = ''C'' ' +
          '       ) as DDL_CREATE_ ' +
          ' ' +
          '     , ( ' +
          '         select iif(  count( RDB$USER_PRIVILEGES.RDB$USER ) > 0, ''' + Common.db_grid__positive_value_c + ''', ''''  ) ' +
          '         from RDB$USER_PRIVILEGES ' +
          '         where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '           and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '           and RDB$USER_PRIVILEGES.RDB$PRIVILEGE = ''L'' ' +
          '       ) as DDL_ALTER_ ' +
          ' ' +
          '     , ( ' +
          '         select iif(  count( RDB$USER_PRIVILEGES.RDB$USER ) > 0, ''' + Common.db_grid__positive_value_c + ''', ''''  ) ' +
          '         from RDB$USER_PRIVILEGES ' +
          '         where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '           and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '           and RDB$USER_PRIVILEGES.RDB$PRIVILEGE = ''O'' ' +
          '       ) as DDL_DROP_ ' +
          ' ' +
          ' ' +
          '     , ( ' +
          '         select count( RDB$USER_PRIVILEGES.RDB$USER ) ' +
          '         from RDB$USER_PRIVILEGES ' +
          '         where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '           and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '       ) as PRIVILEGES_COUNT ' +
          ' ' +
          'from ' +
          '  ( ' +
          '    select distinct t.USER_NAME ' +
          '    from ' +
          '      ( ' +
          ' ' +
          '        select distinct RDB$USER_PRIVILEGES.RDB$USER as USER_NAME ' +
          '        from RDB$USER_PRIVILEGES ' +
          '        where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          ' ' +
          '        union all ' +
          ' ' +
          '        select SEC$USERS.SEC$USER_NAME as USER_NAME ' +
          '        from SEC$USERS ' +
          ' ' +
          '      ) as t ' +
          '  ) as t_t ' +
          'where ( ' +
          '        select count( RDB$USER_PRIVILEGES.RDB$USER ) ' +
          '        from RDB$USER_PRIVILEGES ' +
          '        where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '          and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '      ) >= :all_users ' +
          'order by t_t.USER_NAME '
      else
        zts :=
          'select distinct t_t.USER_NAME ' +
          ' ' +
          '     , RDB$USER_PRIVILEGES.RDB$PRIVILEGE as PRIVILEGE ' +
          ' ' +
          '     , ( ' +
          '         select cast(    substring(   trim(  list( t.PRIVILEGE )  ) from 1 for 25   ) as varchar( 25 )    ) ' +
          '         from ' +
          '           ( ' +
          '             select '' ''||trim( RDB$USER_PRIVILEGES.RDB$PRIVILEGE ) as PRIVILEGE ' +
          '             from RDB$USER_PRIVILEGES ' +
          '             where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '               and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '             order by t_t.USER_NAME, RDB$USER_PRIVILEGES.RDB$PRIVILEGE ' +
          '           ) as t ' +
          '       ) as PRIVILEGES_SYMBOLS_LIST ' +
          ' ' +
          '     , RDB$USER_PRIVILEGES.RDB$GRANTOR as GRANTOR ' +
          ' ' +
          '     , ( ' +
          '         select count( RDB$USER_PRIVILEGES.RDB$USER ) ' +
          '         from RDB$USER_PRIVILEGES ' +
          '         where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '           and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '       ) as PRIVILEGES_COUNT ' +
          ' ' +
          '     , (case ' +
          '         RDB$USER_PRIVILEGES.RDB$OBJECT_TYPE ' +
          '         when 0 then ' +
          '           ''table'' ' +
          ' ' +
          '         when 1 then ' +
          '           ''view'' ' +
          ' ' +
          '         when 2 then ' +
          '           ''trigger'' ' +
          ' ' +
          '         when 5 then ' +
          '           ''procedure'' ' +
          ' ' +
          '         when 7 then ' +
          '           ''exception'' ' +
          ' ' +
          '         when 8 then ' +
          '           ''user'' ' +
          ' ' +
          '         when 9 then ' +
          '           ''domain'' ' +
          ' ' +
          '         when 11 then ' +
          '           ''character set'' ' +
          ' ' +
          '         when 13 then ' +
          '           ''role'' ' +
          ' ' +
          '         when 14 then ' +
          '           ''generator (sequence)'' ' +
          ' ' +
          '         when 15 then ' +
          '           ''function'' ' +
          ' ' +
          '         when 16 then ' +
          '           ''BLOB filter'' ' +
          ' ' +
          '         when 17 then ' +
          '           ''collation'' ' +
          ' ' +
          '         when 18 then ' +
          '           ''package'' ' +
          ' ' +
          '         else ' +
          '           RDB$USER_PRIVILEGES.RDB$OBJECT_TYPE||'' <?>'' ' +
          '       end) as PRIVILEGES_OBJECT_TYPE_NAME ' +
          ' ' +
          'from ' +
          '  ( ' +
          '    select distinct t.USER_NAME ' +
          '    from ' +
          '      ( ' +
          ' ' +
          '        select distinct RDB$USER_PRIVILEGES.RDB$USER as USER_NAME ' +
          '        from RDB$USER_PRIVILEGES ' +
          '        where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          ' ' +
          '        union all ' +
          ' ' +
          '        select SEC$USERS.SEC$USER_NAME as USER_NAME ' +
          '        from SEC$USERS ' +
          ' ' +
          '      ) as t ' +
          '  ) as t_t ' +
          'left join RDB$USER_PRIVILEGES on RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          'where ( ' +
          '        select count( RDB$USER_PRIVILEGES.RDB$USER ) ' +
          '        from RDB$USER_PRIVILEGES ' +
          '        where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = :table_name ' +
          '          and RDB$USER_PRIVILEGES.RDB$USER = t_t.USER_NAME ' +
          '      ) >= :all_users ' +
          'order by t_t.USER_NAME, RDB$USER_PRIVILEGES.RDB$PRIVILEGE ';

    end;

  permissions_sdbm.Query__Sql__Set( zts );


  if   (
             ( Modify__Permissions__Row_One_CheckBox.Checked )
         and ( not values_logged__row_one_g )
       )
    or (
             ( not Modify__Permissions__Row_One_CheckBox.Checked )
         and ( not values_logged_g )
       ) then
    Log_Memo.Lines.Add( zts );


  permissions_sdbm.Query__Param_By_Name__Set( Common.name__table__small_letters_c, table_name__pmf_g, Log_Memo );

  if Modify__Permissions__Show_All_Users_CheckBox.Checked then
    permissions_sdbm.Query__Param_By_Name__Set( permissions_list__parameter__all_users_c, 0, Log_Memo )
  else
    permissions_sdbm.Query__Param_By_Name__Set( permissions_list__parameter__all_users_c, 1, Log_Memo );

  try
    permissions_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_permissions_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;


  Screen.Cursor := crDefault;



  if permissions_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( permissions_sdbm.Operation_Duration_Get() );


      try
        permissions_sdbm.Query__Field_By_Name( Common.name__user__name__big_letters_c ).AsString;
        User_Name_DBEdit.DataField := Common.name__user__name__big_letters_c;
        permissions_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );
      except
        on E : Exception do
          begin

            permissions_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_permissions_user_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;


      for i := 0 to Permissions_DBGrid.Columns.Count - 1 do
        begin

          if Permissions_DBGrid.Columns.Items[ i ].Width < 50 then
            Permissions_DBGrid.Columns.Items[ i ].Width := 50;

        end;


      Self.Translation__Apply__PMF( Translation.tak_Grid );


      Common.Data_Value_Format__Set( permissions_sdbm, Log_Memo );

    end;


  if    ( Modify__Permissions__Row_One_CheckBox.Checked )
    and ( not values_logged__row_one_g ) then
    values_logged__row_one_g := true
  else
    if    ( not Modify__Permissions__Row_One_CheckBox.Checked )
      and ( not values_logged_g ) then
    values_logged_g := true;

end;

procedure TPermissions_Modify_F_Frame.Finish__PMF();
begin

  FreeAndNil( permissions_sdbm );

end;

procedure TPermissions_Modify_F_Frame.Highlight__Font__Set__PMF();
begin

  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    begin

      Common.Font__Set( Permissions_DBGrid.Font, Common.sql_editor__font );
      Common.Font__Set( Modify__Privileges_Name_CheckListBox.Font, Common.sql_editor__font );

    end;

end;

procedure TPermissions_Modify_F_Frame.Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );
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

procedure TPermissions_Modify_F_Frame.Options_Set__PMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
begin

  sql__quotation_sign__use__pmf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__pmf_g := sql__quotation_sign_f;


  if permissions_sdbm <> nil then
    begin

      permissions_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

      permissions_sdbm.Data_Source__Data_Set__Set( Permissions_DataSource );

    end;


  Self.Translation__Apply__PMF( Translation.tak_Self );

end;

procedure TPermissions_Modify_F_Frame.Parent_Tab_Switch( const prior_f : boolean = false );
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

procedure TPermissions_Modify_F_Frame.Prepare__PMF( const table_name_f, database_type_f, sql__quotation_sign_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const permissions_object_type_f : TPermissions_Object_Type; const sql__quotation_sign__use_f : boolean );
var
  zts : string;
begin

  Self.Name := '';

  database_type__pmf_g := database_type_f;
  permissions_object_type_g := permissions_object_type_f;
  table_name__pmf_g := table_name_f;
  sort__column_name_g := Common.name__user__name__big_letters_c;
  sort__direction_ascending_g := true;
  values_logged_g := false;
  values_logged__row_one_g := false;


  Log_Memo.Lines.Add( table_name__pmf_g );


  permissions_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Self.Options_Set__PMF( component_type_f, sql__quotation_sign_f, sql__quotation_sign__use_f );



  Modify__Privileges_Name_CheckListBox.Items.Clear();

  if permissions_object_type_g in [ pot_function, pot_procedure_stored ] then
    zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions__privileges_list__procedure__file_name_c  )
  else
    zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions__privileges_list__table__file_name_c  );

  if Trim( zts ) = '' then
    begin

      if permissions_object_type_g in [ pot_function, pot_procedure_stored ] then
        Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions__privileges_list__procedure__file_name_c + ').' )
      else
        Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions__privileges_list__table__file_name_c + ').' );

      if permissions_object_type_g in [ pot_function, pot_procedure_stored ] then
        zts :=
          'EXECUTE' + #13 + #10
      else
        zts :=
          'ALL' + #13 + #10 +
          'DELETE' + #13 + #10 +
          'INSERT' + #13 + #10 +
          'REFERENCES' + #13 + #10 +
          'SELECT' + #13 + #10 +
          'UPDATE' +  #13 + #10;

    end;

  Common.Items_From_Text_Add( Modify__Privileges_Name_CheckListBox.Items, zts );


  Highlight__Font__Set__PMF();

end;

function TPermissions_Modify_F_Frame.Quotation_Sign__PMF() : string;
begin

  if sql__quotation_sign__use__pmf_g then
    begin

      Result := sql__quotation_sign__pmf_g;

    end
  else
    Result := '';

end;

procedure TPermissions_Modify_F_Frame.Translation__Apply__PMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
var
  i : integer;
begin

  if tak_f in [ Translation.tak_All, Translation.tak_Self ] then
    Translation.Translation__Apply( Self );


  if tak_f in [ Translation.tak_All, Translation.tak_Grid ] then
    for i := 0 to Permissions_DBGrid.Columns.Count - 1 do
      if Permissions_DBGrid.Columns.Items[ i ].FieldName = Common.name__user__name__big_letters_c then
        Permissions_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__user__name
      else
        Permissions_DBGrid.Columns.Items[ i ].Title.Caption := Common.Column__Name_To_Grid_Caption( Permissions_DBGrid.Columns.Items[ i ].FieldName );

end;

procedure TPermissions_Modify_F_Frame.User_Name_DBEditChange( Sender: TObject );
begin

  if    ( permissions_sdbm <> nil )
    and ( permissions_sdbm.Query__Active() ) then
    Record_Number__Records_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', permissions_sdbm.Query__Record_Number() )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', permissions_sdbm.Query__Record_Count() )  )
  else
    Record_Number__Records_Count_Label.Caption := '0 / 0';

end;

procedure TPermissions_Modify_F_Frame.Search_Change( Sender: TObject );
var
  locate_options : Data.DB.TLocateOptions;
begin

  if   ( permissions_sdbm = nil )
    or ( not permissions_sdbm.Query__Active() ) then
    Exit;


  locate_options := [];

  if Search__Case_Insensitive_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loCaseInsensitive ];

  if Search__Partial_Key_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loPartialKey ];


  if permissions_sdbm.Query__Locate( sort__column_name_g, Search_Edit.Text, locate_options ) then
    Search_Edit.Color := clWindow
  else
    begin

      Search_Edit.Color := Common.color__red__light_c;


      permissions_sdbm.Query__Disable_Controls();

      permissions_sdbm.Query__First();

      while not permissions_sdbm.Query__Eof do
        begin

          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  permissions_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

          permissions_sdbm.Query__Next();

        end;

      permissions_sdbm.Query__Enable_Controls();

    end;

end;

procedure TPermissions_Modify_F_Frame.Search__Next_ButtonClick( Sender: TObject );
begin

  if   ( permissions_sdbm = nil )
    or ( not permissions_sdbm.Query__Active() ) then
    Exit;


  permissions_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not permissions_sdbm.Query__Eof do
    begin

      permissions_sdbm.Query__Next();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  permissions_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  permissions_sdbm.Query__Enable_Controls();

end;

procedure TPermissions_Modify_F_Frame.Search__Prior_ButtonClick( Sender: TObject );
begin

  if   ( permissions_sdbm = nil )
    or ( not permissions_sdbm.Query__Active() ) then
    Exit;


  permissions_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not permissions_sdbm.Query__Bof do
    begin

      permissions_sdbm.Query__Prior();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  permissions_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  permissions_sdbm.Query__Enable_Controls();

end;

procedure TPermissions_Modify_F_Frame.Refresh_ButtonClick( Sender: TObject );
var
  primary_key_value__1_l,
  primary_key_value__2_l
    : string;
begin

  if permissions_sdbm = nil then
    Exit;


  if    (
             ( Sender = nil )
          or (
                    ( Sender <> nil )
                and ( Sender <> Modify__Permissions__Row_One_CheckBox )
             )
        )
    and ( permissions_sdbm.Query__Active() ) then
    begin

      primary_key_value__1_l := permissions_sdbm.Query__Field_By_Name( Common.name__user__name__big_letters_c ).AsString;


      if not Modify__Permissions__Row_One_CheckBox.Checked then
        try
          primary_key_value__2_l := permissions_sdbm.Query__Field_By_Name( permissions_list__column__privilege_symbol_c ).AsString;
        except
          on E : Exception do
            begin

              primary_key_value__2_l := '';

              Log_Memo.Lines.Add( Translation.translation__messages_r.failed_to_read_permission_symbol__column_name + ' ''' + permissions_list__column__privilege_symbol_c + '''): ' + E.Message + '.');

            end;
        end;

    end
  else
    begin

      primary_key_value__1_l := '';
      primary_key_value__2_l := '';

    end;


  Self.Data_Open__PMF();


  if    ( permissions_sdbm.Query__Active() )
    and ( Sender <> nil )
    and (
             ( Sender = Modify__Permissions__Row_One_CheckBox )
          or ( Sender = Refresh_Button )
        ) then
    begin

      Log_Memo.Lines.Add( permissions_sdbm.Operation_Duration_Get() );

    end;


  if    ( primary_key_value__1_l <> '' )
    and ( permissions_sdbm.Query__Active() ) then
    if    ( not Modify__Permissions__Row_One_CheckBox.Checked )
      and ( primary_key_value__2_l <> '' ) then
      permissions_sdbm.Query__Locate(  Common.name__user__name__big_letters_c + '; ' + permissions_list__column__privilege_symbol_c, VarArrayOf( [ primary_key_value__1_l, primary_key_value__2_l ] ), [ Data.DB.loCaseInsensitive ]  )
    else
      permissions_sdbm.Query__Locate( Common.name__user__name__big_letters_c, primary_key_value__1_l, [ Data.DB.loCaseInsensitive ] );

end;

procedure TPermissions_Modify_F_Frame.Modify__Grant_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  i : integer;

  zts,
  object_name_l,
  privileges_list_l,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( permissions_sdbm = nil )
    or ( not permissions_sdbm.Query__Active() )
    or ( permissions_sdbm.Query__Record_Count() <= 0 ) then
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


  if permissions_object_type_g in [ pot_function ] then
    object_name_l := 'function'
  else
  if permissions_object_type_g in [ pot_procedure_stored ] then
    object_name_l := 'procedure'
  else
    object_name_l := 'table';


  if permissions_object_type_g in [ pot_function ] then
    zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__grant__function__file_name_c  )
  else
  if permissions_object_type_g in [ pot_procedure_stored ] then
    zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__grant__procedure__file_name_c  )
  else
    zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__grant__table__file_name_c  );

  if Trim( zts ) = '' then
    begin

      if permissions_object_type_g in [ pot_function ] then
        Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__grant__function__file_name_c + ').' )
      else
      if permissions_object_type_g in [ pot_procedure_stored ] then
        Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__grant__procedure__file_name_c + ').' )
      else
        Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__grant__table__file_name_c + ').' );


      zts :=
        'grant ' +
        privileges_list_l +
        ' on ' +
        object_name_l +
        ' ' +
        Self.Quotation_Sign__PMF() + table_name__pmf_g + Self.Quotation_Sign__PMF() +
        ' to user ' +
        Self.Quotation_Sign__PMF() + User_Name_DBEdit.Text + Self.Quotation_Sign__PMF() + ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + permissions_list__privileges_list__name_c + Common.sql__word_replace_separator_c, privileges_list_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__user__name__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__PMF() + User_Name_DBEdit.Text + Self.Quotation_Sign__PMF(), [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__PMF() + table_name__pmf_g + Self.Quotation_Sign__PMF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.grant_privileges_on__1 + ' ''' + privileges_list_l + ''' ' + Translation.translation__messages_r.grant_privileges_on__2 + ' ' + object_name_l + ' ''' + Self.Quotation_Sign__PMF() + table_name__pmf_g + Self.Quotation_Sign__PMF() + ''' ' + Translation.translation__messages_r.grant_privileges_on__3 + ' ''' + Self.Quotation_Sign__PMF() + User_Name_DBEdit.Text + Self.Quotation_Sign__PMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  Screen.Cursor := crSQLWait;


  ztb := permissions_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_grant_privileges );


  Screen.Cursor := crDefault;


  if ztb then
    begin

      Log_Memo.Lines.Add( permissions_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TPermissions_Modify_F_Frame.Modify__Grant__All_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( permissions_sdbm = nil )
    or ( not permissions_sdbm.Query__Active() )
    or ( permissions_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__grant__all_on_all__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__grant__all_on_all__file_name_c + ').' );

      zts :=
        'grant ALL on ALL to user ' + //???
        User_Name_DBEdit.Text + ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__user__name__big_letters_c + Common.sql__word_replace_separator_c, User_Name_DBEdit.Text, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.grant_all_on_all_privileges_to_user + ' ''' + User_Name_DBEdit.Text + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  Screen.Cursor := crSQLWait;


  ztb := permissions_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_grant_privileges );


  Screen.Cursor := crDefault;


  if ztb then
    begin

      Log_Memo.Lines.Add( permissions_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TPermissions_Modify_F_Frame.Modify__Revoke_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  i : integer;

  zts,
  object_name_l,
  privileges_list_l,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( permissions_sdbm = nil )
    or ( not permissions_sdbm.Query__Active() )
    or ( permissions_sdbm.Query__Record_Count() <= 0 ) then
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


  if permissions_object_type_g in [ pot_function ] then
    object_name_l := 'function'
  else
  if permissions_object_type_g in [ pot_procedure_stored ] then
    object_name_l := 'procedure'
  else
    object_name_l := 'table';


  if permissions_object_type_g in [ pot_function ] then
    zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__revoke__function__file_name_c  )
  else
  if permissions_object_type_g in [ pot_procedure_stored ] then
    zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__revoke__procedure__file_name_c  )
  else
    zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__revoke__table__file_name_c  );

  if Trim( zts ) = '' then
    begin

      if permissions_object_type_g in [ pot_function ] then
        Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__revoke__function__file_name_c + ').' )
      else
      if permissions_object_type_g in [ pot_procedure_stored ] then
        Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__revoke__procedure__file_name_c + ').' )
      else
        Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__revoke__table__file_name_c + ').' );


      zts :=
        'revoke ' +
        privileges_list_l +
        ' on ' +
        object_name_l +
        ' ' +
        Self.Quotation_Sign__PMF() + table_name__pmf_g + Self.Quotation_Sign__PMF() +
        ' from user ' +
        Self.Quotation_Sign__PMF() + User_Name_DBEdit.Text + Self.Quotation_Sign__PMF() + ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + permissions_list__privileges_list__name_c + Common.sql__word_replace_separator_c, privileges_list_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__user__name__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__PMF() + User_Name_DBEdit.Text + Self.Quotation_Sign__PMF(), [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__PMF() + table_name__pmf_g + Self.Quotation_Sign__PMF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.revoke_privileges_on__1 + ' ''' + privileges_list_l + ''' ' + Translation.translation__messages_r.revoke_privileges_on__2 + ' ' + object_name_l + ' ''' + Self.Quotation_Sign__PMF() + table_name__pmf_g + Self.Quotation_Sign__PMF() + ''' ' + Translation.translation__messages_r.revoke_privileges_on__3 + ' ''' + Self.Quotation_Sign__PMF() + User_Name_DBEdit.Text + Self.Quotation_Sign__PMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  Screen.Cursor := crSQLWait;


  ztb := permissions_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_revoke_privileges );


  Screen.Cursor := crDefault;


  if ztb then
    begin

      Log_Memo.Lines.Add( permissions_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TPermissions_Modify_F_Frame.Modify__Revoke__All_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( permissions_sdbm = nil )
    or ( not permissions_sdbm.Query__Active() )
    or ( permissions_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__revoke__all_on_all__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__pmf_g ) + permissions_list__sql__privileges__revoke__all_on_all__file_name_c + ').' );

      zts :=
        'revoke ALL on ALL from user ' +
        Self.Quotation_Sign__PMF() + User_Name_DBEdit.Text + Self.Quotation_Sign__PMF() + ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__user__name__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__PMF() + User_Name_DBEdit.Text + Self.Quotation_Sign__PMF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.revoke_all_on_all_privileges_from_user + ' ''' + Self.Quotation_Sign__PMF() + User_Name_DBEdit.Text + Self.Quotation_Sign__PMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  Screen.Cursor := crSQLWait;


  ztb := permissions_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_revoke_privileges );


  Screen.Cursor := crDefault;


  if ztb then
    begin

      Log_Memo.Lines.Add( permissions_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TPermissions_Modify_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Buttons_Panel.Width := 1;

end;

procedure TPermissions_Modify_F_Frame.Modify__Privileges_Name_CheckListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
var
  i : integer;
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Modify__Privileges_Name_CheckListBox.CheckAll( cbChecked, false, false )
  else
  // N.
  if    ( Key = 78 )
    and ( Shift = [ ssCtrl ] ) then
    Modify__Privileges_Name_CheckListBox.CheckAll( cbUnchecked, false, false )
  else
  // I.
  if    ( Key = 73 )
    and ( Shift = [ ssCtrl ] ) then
    for i := 0 to Modify__Privileges_Name_CheckListBox.Items.Count - 1 do
      Modify__Privileges_Name_CheckListBox.Checked[ i ] := not Modify__Privileges_Name_CheckListBox.Checked[ i ];

end;

procedure TPermissions_Modify_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TPermissions_Modify_F_Frame.Permissions_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
begin

  if    (
          not (
                   ( gdFocused in State )
                or ( gdSelected in State )
              )
        )
    and ( Column.Field <> nil )
    and (  (Sender as TDBGrid).DataSource.DataSet.FieldByName( Column.Field.FullName ).AsString = Common.db_grid__positive_value_c  ) then
    begin

      Permissions_DBGrid.Canvas.Brush.Color := clMoneyGreen;

      Permissions_DBGrid.DefaultDrawColumnCell( Rect, DataCol, Column, State );

    end;


  Common.DB_Grid_Draw_Column_Cell( sort__column_name_g, Permissions_DBGrid, Rect, DataCol, Column, State );

end;

procedure TPermissions_Modify_F_Frame.Permissions_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_DELETE )
    and ( Shift = [ ssCtrl ] ) then
    Modify__Revoke__All_ButtonClick( Sender )
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( permissions_sdbm.Query__Active() )
    and ( permissions_sdbm.Query__Record_Count > 0 )
    and ( Permissions_DBGrid.SelectedField <> nil ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Permissions_DBGrid.SelectedField.Value;
    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end;

end;

procedure TPermissions_Modify_F_Frame.Permissions_DBGridTitleClick( Column: TColumn );
begin

  if Column.Field = nil then
    Exit;


  if sort__column_name_g = Column.Field.FieldName then
    sort__direction_ascending_g := not sort__direction_ascending_g
  else
    sort__column_name_g := Column.Field.FieldName;

  permissions_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );


  User_Name_DBEditChange( nil ); // For FireDAC.

end;

end.
