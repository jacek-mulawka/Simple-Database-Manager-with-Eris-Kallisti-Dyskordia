unit Generators_Modify_F;{21.Cze.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Translation,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Menus, Vcl.CheckLst, Vcl.Samples.Spin, Vcl.Mask, Vcl.DBCtrls,

  Interceptor__Spin_Edit;

type
  TGenerators_Modify_F_Frame = class( TFrame )
    Buttons_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    Generator_Name_DBEdit: TDBEdit;
    Generator_Name_Etiquette_Label: TLabel;
    Generators_DataSource: TDataSource;
    Generators_DBGrid: TDBGrid;
    Log_Memo: TMemo;
    Modify_GroupBox: TGroupBox;
    Modify__Add_Button: TButton;
    Modify__Delete_Button: TButton;
    Modify__Edit_Button: TButton;
    Modify__Name_Edit: TEdit;
    Modify__Name_Etiquette_Label: TLabel;
    Modify__Value_Etiquette_Label: TLabel;
    Modify__Value_SpinEdit: TSpinEdit;
    Record_Number__Records_Count_Label: TLabel;
    Refresh_Button: TButton;
    Search_Edit: TEdit;
    Search_GroupBox: TGroupBox;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Next_Button: TButton;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Prior_Button: TButton;
    Vertical_Splitter: TSplitter;
    Generators_PopupMenu: TPopupMenu;
    Generator__Delete_MenuItem: TMenuItem;
    N1: TMenuItem;
    Generator__Description__Set_MenuItem: TMenuItem;
    Generator__Description__Drop_MenuItem: TMenuItem;
    N2: TMenuItem;
    Generator__Description__Write_In_Log_MenuItem: TMenuItem;
    Modify__Values_Fields__Update_CheckBox: TCheckBox;
    Log_Horizontal_Splitter: TSplitter;
    Permissions_GroupBox: TGroupBox;
    Permissions__Filter__Users__Apply_Button: TButton;
    Permissions__Filter__Users__Cancel_Button: TButton;
    Permissions__Grant_Button: TButton;
    Permissions__Refresh_Button: TButton;
    Permissions__Revoke_Button: TButton;
    Permissions__User_Names_CheckListBox: TCheckListBox;
    Permissions__User_Names_Etiquette_Label: TLabel;

    procedure Generator_Name_DBEditChange( Sender: TObject );
    procedure Search_Change( Sender: TObject );
    procedure Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );

    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Modify__Add_ButtonClick( Sender: TObject );
    procedure Modify__Edit_ButtonClick( Sender: TObject );
    procedure Modify__Delete_ButtonClick( Sender: TObject );

    procedure Permissions__Refresh_ButtonClick( Sender: TObject );
    procedure Permissions__Grant_ButtonClick( Sender: TObject );
    procedure Permissions__Revoke_ButtonClick( Sender: TObject );
    procedure Permissions__Filter__Users__Apply_ButtonClick( Sender: TObject );
    procedure Permissions__Filter__Users__Cancel_ButtonClick( Sender: TObject );

    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );
    procedure Permissions__User_Names_CheckListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Generator__Description__Set_MenuItemClick( Sender: TObject );
    procedure Generator__Description__Drop_MenuItemClick( Sender: TObject );
    procedure Generator__Description__Write_In_Log_MenuItemClick( Sender: TObject );

    procedure Modify__Value_SpinEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Generators_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
    procedure Generators_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Generators_DBGridTitleClick( Column: TColumn );
  private
    { Private declarations }
    sort__direction_ascending_g,
    sql__quotation_sign__use__gmf_g,
    values_logged_g, // Values log only once.
    values_logged__grant_g, // Values log only once.
    values_logged__revoke_g // Values log only once.
      : boolean;

    database_type__gmf_g,
    sort__column_name_g,
    sql__quotation_sign__gmf_g,
    user_names__filter_g
      : string;

    generators_sdbm : Common.TSDBM;

    function Description_Get__GMF() : string;
    procedure Permissions__User_Names_Items_Free();
    function Quotation_Sign__GMF() : string;
  public
    { Public declarations }
    function Data_Active__GMF() : boolean;
    procedure Data_Open__GMF( const filter_apply_f : boolean = false );
    procedure Finish__GMF();
    procedure Highlight__Font__Set__GMF();
    procedure Options_Set__GMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
    procedure Prepare__GMF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
    procedure Translation__Apply__GMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
  end;

const
  generators_list__file_name_c : string = 'Generators_List__sql.txt';
  generators_list__column__generator_name__big_letter_c : string = 'GENERATOR_NAME';
  generators_list__column__generator_name__small_letter_c : string = 'generator_name';
  generators_list__column__generator_value_c : string = 'GENERATOR_VALUE';
  generators_list__column__user__names_c : string = 'USER_NAMES';
  generators_list__sql__description__drop__file_name_c : string = 'Generator__Description__Drop__sql.txt';
  generators_list__sql__description__get__file_name_c : string = 'Generator__Description__Get__sql.txt';
  generators_list__sql__description__set__file_name_c : string = 'Generator__Description__Set__sql.txt';
  generators_list__sql__generator__create__file_name_c : string = 'Generator__Create__sql.txt';
  generators_list__sql__generator__drop__file_name_c : string = 'Generator__Drop__sql.txt';
  generators_list__sql__generator__set__file_name_c : string = 'Generator__Set__sql.txt';
  generators_list__sql__permissions__grant__file_name_c : string = 'Generator__Permissions__Grant__sql.txt';
  generators_list__sql__permissions__revoke__file_name_c : string = 'Generator__Permissions__Revoke__sql.txt';
  generators_list__sql__users_list__file_name_c : string = 'Generator__Users_List__sql.txt';

implementation

uses
  Vcl.Clipbrd,

  Shared,
  Text__Edit_Memo;

{$R *.dfm}

function TGenerators_Modify_F_Frame.Data_Active__GMF() : boolean;
begin

  Result :=
        ( generators_sdbm <> nil )
    and ( generators_sdbm.Query__Active() );

end;

procedure TGenerators_Modify_F_Frame.Data_Open__GMF( const filter_apply_f : boolean = false );
var
  i : integer;

  zts : string;
begin

  if   ( generators_sdbm = nil )
    or ( generators_sdbm.component_type__sdbm = Common.ct_none ) then
    Exit;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__file_name_c + ').' );

      zts :=
        'execute block (  USER_NAMES__FILTER varchar( 5000 ) = :user_names__filter  ) ' +
        //'returns (  GENERATOR_NAME varchar( 100 ), GENERATOR_VALUE bigint, USER_NAMES varchar( 5000 ), DESCRIPTION_VALUE varchar( 10000 )  ) ' +
        'returns (  GENERATOR_NAME varchar( 100 ), GENERATOR_VALUE bigint, USER_NAMES varchar( 5000 ), DESCRIPTION_VALUE varchar( 8191 )  ) ' + // FireDAC limit default - FDConnection1.FormatOptions.MaxStringSize = 32767 bytes ( / 4 = 8191,75 ).
        'as ' +
        '  declare variable ZTB boolean; ' +
        ' ' +
        '  declare variable ZTS varchar( 1000 ); ' +
        'begin ' +
        ' ' +
        '  for ' +
        '    select trim( RDB$GENERATORS.RDB$GENERATOR_NAME ) ' +
        '         , RDB$GENERATORS.RDB$DESCRIPTION ' +
        '    from RDB$GENERATORS ' +
        '    where RDB$GENERATORS.RDB$SYSTEM_FLAG is distinct from 1 ' +
        '    into GENERATOR_NAME ' +
        '       , DESCRIPTION_VALUE ' +
        '  do ' +
        '    begin ' +
        ' ' +
        '      execute statement ' +
        //'        ''select gen_id( '' || GENERATOR_NAME || '', 0 ) from RDB$DATABASE '' ' +
        //'        ''select gen_id( ' + Self.Quotation_Sign__GMF() + ''' || GENERATOR_NAME || ''' + Self.Quotation_Sign__GMF() + ', 0 ) from RDB$DATABASE '' ' +
        '        ''select gen_id( "'' || GENERATOR_NAME || ''", 0 ) from RDB$DATABASE '' ' +
        '        into GENERATOR_VALUE; ' +
        ' ' +
        ' ' +
        '      ZTB = false; ' +
        '      ZTS = ''''; ' +
        '      USER_NAMES = ''''; ' +
        ' ' +
        '      for ' +
        '        execute statement ' +
        '          ''select RDB$USER_PRIVILEGES.RDB$USER ' +
        '           from RDB$USER_PRIVILEGES ' +
        '           where RDB$USER_PRIVILEGES.RDB$RELATION_NAME = ''''''||GENERATOR_NAME||'''''' ' +
        '           order by RDB$USER_PRIVILEGES.RDB$USER '' ' +
        '        into ZTS ' +
        '      do ' +
        '        begin ' +
        ' ' +
        '          if (  trim( USER_NAMES ) <> ''''  ) then ' +
        '            USER_NAMES = USER_NAMES||'', ''; ' +
        ' ' +
        '          USER_NAMES = USER_NAMES||trim( ZTS ); ' +
        ' ' +
        ' ' +
        '          if ( ' +
        '                   ( not ZTB ) ' +
        '               and (  position( '', ''||trim( ZTS )||'','', '', ''||USER_NAMES__FILTER||'','' ) > 0  ) ' +
        '             ) then ' +
        '            ZTB = true; ' +
        ' ' +
        '        end ' +
        ' ' +
        ' ' +
        '      if ( ' +
        '              (  trim( USER_NAMES__FILTER ) = ''''  ) ' +
        '           or ( USER_NAMES__FILTER is null ) ' +
        '           or ( ZTB ) ' +
        '         ) then ' +
        '        suspend; ' +
        ' ' +
        '    end ' +
        ' ' +
        'end ';

    end;


  Screen.Cursor := crHourGlass;


  if generators_sdbm.Query__Active() then
    generators_sdbm.Query__Close();

  generators_sdbm.Query__Sql__Set( zts );


  for i := 0 to generators_sdbm.Query__Parameters_Count() - 1 do
    //generators_sdbm.Query__Param_By_Name__Set( generators_sdbm.Query__Param_By_Index__Name__Get( i ), user_names__filter_g, Log_Memo );
    generators_sdbm.Query__Param_By_Index__Set( i, user_names__filter_g, Log_Memo );


  if not values_logged_g then
    begin

      values_logged_g := true;
      Log_Memo.Lines.Add( zts );

    end;


  try
    generators_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_generators_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;


  Screen.Cursor := crDefault;


  if generators_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( generators_sdbm.Operation_Duration_Get() );


      try
        Generator_Name_DBEdit.DataField := generators_list__column__generator_name__big_letter_c;
        generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString;
        generators_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );
      except
        on E : Exception do
          begin

            generators_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_generator_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;


      Common.Data_Value_Format__Set( generators_sdbm, Log_Memo );


      if generators_sdbm.Query__Active() then
        try
          generators_sdbm.Query__Display_Format( generators_list__column__generator_value_c, '### ### ### ### ### ### ##0' );
        except
          on E : Exception do
            begin

              generators_sdbm.Query__Close();

              Log_Memo.Lines.Add( E.Message );

              Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_generator_value + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            end;
        end;


      for i := 0 to Generators_DBGrid.Columns.Count - 1 do
        begin

          if Generators_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value_c then
            begin

              if Generators_DBGrid.Columns.Items[ i ].Width > 500 then
                Generators_DBGrid.Columns.Items[ i ].Width := 500;

            end
          else
            if Generators_DBGrid.Columns.Items[ i ].Width > 200 then
              Generators_DBGrid.Columns.Items[ i ].Width := 200;

        end;


      Self.Translation__Apply__GMF( Translation.tak_Grid );

    end;


  if not filter_apply_f then
    Permissions__Refresh_ButtonClick( nil );

end;

function TGenerators_Modify_F_Frame.Description_Get__GMF() : string;
var
  zts,
  generator_name_l
    : string;

  zt_sdbm : Common.TSDBM;
begin

  Result := '';


  if   ( generators_sdbm = nil )
    or ( not generators_sdbm.Query__Active() )
    or ( generators_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  generator_name_l := Self.Quotation_Sign__GMF() + Trim(  generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString  ) + Self.Quotation_Sign__GMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__description__get__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__description__get__file_name_c + ').' );

      zts :=
        'select RDB$GENERATORS.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
        'from RDB$GENERATORS ' +
        'where RDB$GENERATORS.RDB$GENERATOR_NAME = :generator_name ';

    end;


  Log_Memo.Lines.Add( zts );


  zt_sdbm := Common.TSDBM.Create( generators_sdbm );
  zt_sdbm.Component_Type_Set( generators_sdbm.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

  zt_sdbm.Query__Sql__Set( zts );

  zt_sdbm.Query__Param_By_Name__Set(  generators_list__column__generator_name__small_letter_c, generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString, Log_Memo  );

  try
    zt_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_generator_description + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;


  if zt_sdbm.Query__Active() then
    try
      zt_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
    except
      on E : Exception do
        begin

          zt_sdbm.Query__Close();

          Log_Memo.Lines.Add( E.Message );

          Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_generator_description + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

        end;
    end;


  if zt_sdbm.Query__Active() then
    begin

      Result := zt_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;

      zt_sdbm.Query__Close();

    end
  else
    Result := generators_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;


  FreeAndNil( zt_sdbm );

end;

procedure TGenerators_Modify_F_Frame.Finish__GMF();
begin

  Permissions__User_Names_Items_Free();


  FreeAndNil( generators_sdbm );

end;

procedure TGenerators_Modify_F_Frame.Highlight__Font__Set__GMF();
begin

  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    begin

      Common.Font__Set( Generators_DBGrid.Font, Common.sql_editor__font );
      Common.Font__Set( Permissions__User_Names_CheckListBox.Font, Common.sql_editor__font );

    end;

end;

procedure TGenerators_Modify_F_Frame.Permissions__User_Names_Items_Free();
var
  i : integer;
begin

  for i := 0 to Permissions__User_Names_CheckListBox.Items.Count - 1 do
    Common.TObject_Id_Caption(Permissions__User_Names_CheckListBox.Items.Objects[ i ]).Free();

  Permissions__User_Names_CheckListBox.Items.Clear();

end;

function TGenerators_Modify_F_Frame.Quotation_Sign__GMF() : string;
begin

  if sql__quotation_sign__use__gmf_g then
    begin

      Result := sql__quotation_sign__gmf_g;

    end
  else
    Result := '';

end;

procedure TGenerators_Modify_F_Frame.Options_Set__GMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
begin

  sql__quotation_sign__use__gmf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__gmf_g := sql__quotation_sign_f;


  if generators_sdbm <> nil then
    begin

      generators_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

      generators_sdbm.Data_Source__Data_Set__Set( Generators_DataSource );

    end;


  Self.Translation__Apply__GMF( Translation.tak_Self );

end;

procedure TGenerators_Modify_F_Frame.Prepare__GMF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
begin

  Self.Name := '';

  database_type__gmf_g := databases_r_f.database_type;
  sort__column_name_g := generators_list__column__generator_name__big_letter_c;
  sort__direction_ascending_g := true;
  user_names__filter_g := '';
  values_logged_g := false;
  values_logged__grant_g := false;
  values_logged__revoke_g := false;


  generators_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Self.Options_Set__GMF( component_type_f, databases_r_f.sql__quotation_sign, sql__quotation_sign__use_f );


  Highlight__Font__Set__GMF();

end;

procedure TGenerators_Modify_F_Frame.Translation__Apply__GMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
var
  i : integer;
begin

  if tak_f in [ Translation.tak_All, Translation.tak_Self ] then
    Translation.Translation__Apply( Self );


  if tak_f in [ Translation.tak_All, Translation.tak_Grid ] then
    for i := 0 to Generators_DBGrid.Columns.Count - 1 do
      if Generators_DBGrid.Columns.Items[ i ].FieldName = generators_list__column__generator_name__big_letter_c then
        Generators_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__name
      else
      if Generators_DBGrid.Columns.Items[ i ].FieldName = generators_list__column__generator_value_c then
        Generators_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__value
      else
      if Generators_DBGrid.Columns.Items[ i ].FieldName = generators_list__column__user__names_c then
        Generators_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__user__names
      else
        Generators_DBGrid.Columns.Items[ i ].Title.Caption := Common.Column__Name_To_Grid_Caption( Generators_DBGrid.Columns.Items[ i ].FieldName );

end;

procedure TGenerators_Modify_F_Frame.Generator_Name_DBEditChange( Sender: TObject );
begin

  if    ( generators_sdbm <> nil )
    and ( generators_sdbm.Query__Active() ) then
    begin

      Record_Number__Records_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', generators_sdbm.Query__Record_Number() )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', generators_sdbm.Query__Record_Count() )  );

      if Modify__Values_Fields__Update_CheckBox.Checked then
        try
          Modify__Value_SpinEdit.Value := generators_sdbm.Query__Field_By_Name( generators_list__column__generator_value_c ).AsInteger;
        except
        end;

    end
  else
    Record_Number__Records_Count_Label.Caption := '0 / 0';

end;

procedure TGenerators_Modify_F_Frame.Search_Change( Sender: TObject );
var
  locate_options : Data.DB.TLocateOptions;
begin

  if   ( generators_sdbm = nil )
    or ( not generators_sdbm.Query__Active() ) then
    Exit;


  locate_options := [];

  if Search__Case_Insensitive_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loCaseInsensitive ];

  if Search__Partial_Key_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loPartialKey ];


  if generators_sdbm.Query__Locate( sort__column_name_g, Search_Edit.Text, locate_options ) then
    Search_Edit.Color := clWindow
  else
    begin

      Search_Edit.Color := Common.color__red__light_c;


      generators_sdbm.Query__Disable_Controls();

      generators_sdbm.Query__First();

      while not generators_sdbm.Query__Eof do
        begin

          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  generators_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

          generators_sdbm.Query__Next();

        end;

      generators_sdbm.Query__Enable_Controls();

    end;

end;

procedure TGenerators_Modify_F_Frame.Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_PRIOR then
    Search__Prior_ButtonClick( Sender )
  else
  if Key = VK_NEXT then
    Search__Next_ButtonClick( Sender );

end;

procedure TGenerators_Modify_F_Frame.Search__Next_ButtonClick( Sender: TObject );
begin

  if   ( generators_sdbm = nil )
    or ( not generators_sdbm.Query__Active() ) then
    Exit;


  generators_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not generators_sdbm.Query__Eof do
    begin

      generators_sdbm.Query__Next();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  generators_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  generators_sdbm.Query__Enable_Controls();

end;

procedure TGenerators_Modify_F_Frame.Search__Prior_ButtonClick( Sender: TObject );
begin

  if   ( generators_sdbm = nil )
    or ( not generators_sdbm.Query__Active() ) then
    Exit;


  generators_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not generators_sdbm.Query__Bof do
    begin

      generators_sdbm.Query__Prior();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  generators_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  generators_sdbm.Query__Enable_Controls();

end;

procedure TGenerators_Modify_F_Frame.Refresh_ButtonClick( Sender: TObject );
var
  primary_key_value_l : string;
begin

  if   ( generators_sdbm = nil )
    or ( not generators_sdbm.Query__Active() ) then
    Exit;


  primary_key_value_l := generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString;

  generators_sdbm.Query__Requery();


  if    ( Sender <> nil )
    and ( Sender = Refresh_Button ) then
    begin

      Log_Memo.Lines.Add( generators_sdbm.Operation_Duration_Get() );

    end;


  generators_sdbm.Query__Locate( generators_list__column__generator_name__big_letter_c, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );

end;

procedure TGenerators_Modify_F_Frame.Modify__Add_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( generators_sdbm = nil )
    or ( not generators_sdbm.Query__Active() ) then
    Exit;


  if Trim( Modify__Name_Edit.Text ) = '' then
    begin

      Modify__Name_Edit.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.generator_name_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__generator__create__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__generator__create__file_name_c + ').' );

      zts :=
        'create generator ' +
        Self.Quotation_Sign__GMF() + Modify__Name_Edit.Text + Self.Quotation_Sign__GMF() +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + generators_list__column__generator_name__big_letter_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__GMF() + Modify__Name_Edit.Text + Self.Quotation_Sign__GMF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.add_generator + ' ''' + Self.Quotation_Sign__GMF() + Modify__Name_Edit.Text + Self.Quotation_Sign__GMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := generators_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_add_generator );


  if ztb then
    begin

      Log_Memo.Lines.Add( generators_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      generators_sdbm.Query__Locate( generators_list__column__generator_name__big_letter_c, Modify__Name_Edit.Text, [ Data.DB.loCaseInsensitive ] );


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TGenerators_Modify_F_Frame.Modify__Edit_ButtonClick( Sender: TObject );
var
  ztb,
  error_occurred
    : boolean;

  i,
  value_l
    : integer;

  zts,
  error_message_l,
  sql_pattern_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( generators_sdbm = nil )
    or ( not generators_sdbm.Query__Active() )
    or ( generators_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  sql_pattern_l := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__generator__set__file_name_c  );

  if Trim( sql_pattern_l ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__generator__set__file_name_c + ').' );

      sql_pattern_l :=
        'set generator __GENERATOR_NAME__ to __GENERATOR_VALUE__ ';

    end;


  Log_Memo.Lines.Add( sql_pattern_l );


  if Generators_DBGrid.SelectedRows.Count <= 0 then
    begin

      Generators_DBGrid.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.generators_must_be_selected), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  value_l := Trunc( Modify__Value_SpinEdit.Value );

  zts := '';

  for i := 0 to Generators_DBGrid.SelectedRows.Count - 1 do
    begin

      Generators_DBGrid.DataSource.DataSet.GotoBookmark( Generators_DBGrid.SelectedRows.Items[ i ] );

      if i > 0 then
        zts := zts +
          ', ';

      zts := zts +
        Generators_DBGrid.DataSource.DataSet.FieldByName( generators_list__column__generator_name__big_letter_c ).AsString;

    end;


  if Application.MessageBox(   PChar(Translation.translation__messages_r.set_selected_generators + ' (' + zts + ') ' + Translation.translation__messages_r.word__value_to + ' ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', value_l )  ) + '?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION   ) <> IDYES then
    Exit;


  Screen.Cursor := crSQLWait;


  generators_sdbm.Operation_Duration__Calculating_Type__Set( Common.odct_multi_command );

  error_occurred := false;


  for i := 0 to Generators_DBGrid.SelectedRows.Count - 1 do
    begin

      Generators_DBGrid.DataSource.DataSet.GotoBookmark( Generators_DBGrid.SelectedRows.Items[ i ] );


      zts := sql_pattern_l;

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + generators_list__column__generator_name__big_letter_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__GMF() + generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString + Self.Quotation_Sign__GMF(), [ rfReplaceAll ] );
      zts := StringReplace(  zts, Common.sql__word_replace_separator_c + generators_list__column__generator_value_c + Common.sql__word_replace_separator_c, IntToStr( value_l ), [ rfReplaceAll ]  );

      Log_Memo.Lines.Add( zts );


      ztb := generators_sdbm.Sql_Command_Execute(  zts, error_message_l, Translation.translation__messages_r.failed_to_set_generator + ' (' + Generators_DBGrid.DataSource.DataSet.FieldByName( generators_list__column__generator_name__big_letter_c ).AsString + ')'  );

      if    ( not ztb )
        and ( not error_occurred ) then
        error_occurred := true;


      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add
          (
            Translation.translation__messages_r.failed_to_set_generator + ' (' +
            Generators_DBGrid.DataSource.DataSet.FieldByName( generators_list__column__generator_name__big_letter_c ).AsString + ') ' +
            error_message_l
          );

    end;


  generators_sdbm.Operation_Duration__Calculating_Type__Set( Common.odct_single_command );


  Screen.Cursor := crDefault;


  Refresh_ButtonClick( Sender );


  if error_occurred then
    begin

      Application.MessageBox( PChar(Translation.translation__messages_r.errors_were_encountered), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

    end
  else
    begin

      Log_Memo.Lines.Add( generators_sdbm.Operation_Duration_Get() );


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end;

end;

procedure TGenerators_Modify_F_Frame.Modify__Delete_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( generators_sdbm = nil )
    or ( not generators_sdbm.Query__Active() )
    or ( generators_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__generator__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__generator__drop__file_name_c + ').' );

      zts :=
        'drop generator ' +
        Self.Quotation_Sign__GMF() + generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString + Self.Quotation_Sign__GMF() +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + generators_list__column__generator_name__big_letter_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__GMF() + generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString + Self.Quotation_Sign__GMF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_generator + ' ''' + Self.Quotation_Sign__GMF() + generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString + Self.Quotation_Sign__GMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := generators_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_generator );


  if ztb then
    begin

      Log_Memo.Lines.Add( generators_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TGenerators_Modify_F_Frame.Permissions__Refresh_ButtonClick( Sender: TObject );
var
  i : integer;

  zts,
  user_name_copy_l
    : string;

  zt_object_id_caption : Common.TObject_Id_Caption;

  zt_sdbm : Common.TSDBM;
begin

  if generators_sdbm = nil then
    Exit;


  if    ( Permissions__User_Names_CheckListBox.ItemIndex >= 0 )
    and ( Permissions__User_Names_CheckListBox.Items.Count > 0 )
    and ( Permissions__User_Names_CheckListBox.ItemIndex <= Permissions__User_Names_CheckListBox.Items.Count - 1 ) then
    user_name_copy_l := Permissions__User_Names_CheckListBox.Items[ Permissions__User_Names_CheckListBox.ItemIndex ]
  else
    user_name_copy_l := '';


  Permissions__User_Names_Items_Free();


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__users_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__users_list__file_name_c + ').' );

      zts :=
        'select distinct tt.USER_NAME ' +
        ' ' +
        '     , SEC$USERS.SEC$FIRST_NAME as USER__NAME__FIRST ' +
        '     , SEC$USERS.SEC$MIDDLE_NAME as USER__NAME__MIDDLE ' +
        '     , SEC$USERS.SEC$LAST_NAME as USER__NAME__LAST ' +
        '     , iif( SEC$USERS.SEC$ACTIVE = true, ''V'', '''' ) as USER_ACTIVE ' +
        '     , iif( SEC$USERS.SEC$ADMIN = true, ''V'', '''' ) as USER_IS_ADMINISTRATOR ' +
        '     , SEC$USERS.SEC$DESCRIPTION as DESCRIPTION_VALUE ' +
        ' ' +
        'from ' +
        '  ( ' +
        ' ' +
        '    select SEC$USERS.SEC$USER_NAME as USER_NAME ' +
        '    from SEC$USERS ' +
        ' ' +
        '    union all ' +
        ' ' +
        '    select distinct RDB$USER_PRIVILEGES.RDB$USER as USER_NAME ' +
        '    from RDB$USER_PRIVILEGES ' +
        '    where RDB$USER_PRIVILEGES.RDB$RELATION_NAME in ' +
        '            ( ' +
        '              select RDB$GENERATORS.RDB$GENERATOR_NAME ' +
        '              from RDB$GENERATORS ' +
        '              where RDB$GENERATORS.RDB$SYSTEM_FLAG is distinct from 1 ' +
        '            ) ' +
        '      and RDB$USER_PRIVILEGES.RDB$RELATION_NAME not in ' +
        '            ( ' +
        '              select SEC$USERS.SEC$USER_NAME ' +
        '              from SEC$USERS ' +
        '            ) ' +
        ' ' +
        '  ) as tt ' +
        'left join SEC$USERS on SEC$USERS.SEC$USER_NAME = tt.USER_NAME ' +
        'order by tt.USER_NAME ';

    end;


  Screen.Cursor := crHourGlass;


  zt_sdbm := Common.TSDBM.Create( generators_sdbm );
  zt_sdbm.Component_Type_Set( generators_sdbm.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

  zt_sdbm.Query__Sql__Set( zts );


  Log_Memo.Lines.Add( zts );


  try
    zt_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_users_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;


  Screen.Cursor := crDefault;


  if zt_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( zt_sdbm.Operation_Duration_Get() );


      try
        zt_sdbm.Query__Field_By_Name( Common.name__user__name__big_letters_c ).AsString;
      except
        on E : Exception do
          begin

            zt_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_user_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;


      if zt_sdbm.Query__Active() then
        begin

          while not zt_sdbm.Query__Eof() do
            begin

              zt_object_id_caption := Common.TObject_Id_Caption.Create();
              zt_object_id_caption.name := Trim( zt_sdbm.Query__Field_By_Name( Common.name__user__name__big_letters_c ).AsString ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

              zt_object_id_caption.caption := zt_object_id_caption.name;


              try
                zt_sdbm.Query__Field_By_Name( 'USER__NAME__FIRST' ).AsString;

                if Trim( zt_object_id_caption.caption ) <> '' then
                  zt_object_id_caption.caption := zt_object_id_caption.caption + ' - ';

                zt_object_id_caption.caption := zt_object_id_caption.caption + zt_sdbm.Query__Field_By_Name( 'USER__NAME__FIRST' ).AsString;
              except
              end;

              try
                zt_sdbm.Query__Field_By_Name( 'USER__NAME__MIDDLE' ).AsString;

                if Trim( zt_object_id_caption.caption ) <> '' then
                  zt_object_id_caption.caption := zt_object_id_caption.caption + ' ';

                zt_object_id_caption.caption := zt_object_id_caption.caption + zt_sdbm.Query__Field_By_Name( 'USER__NAME__MIDDLE' ).AsString;
              except
              end;

              try
                zt_sdbm.Query__Field_By_Name( 'USER__NAME__LAST' ).AsString;

                if Trim( zt_object_id_caption.caption ) <> '' then
                  zt_object_id_caption.caption := zt_object_id_caption.caption + ' ';

                zt_object_id_caption.caption := zt_object_id_caption.caption + zt_sdbm.Query__Field_By_Name( 'USER__NAME__LAST' ).AsString;
              except
              end;


              try
                if zt_sdbm.Query__Field_By_Name( 'USER_IS_ADMINISTRATOR' ).AsString = Common.db_grid__positive_value_c then
                  zt_object_id_caption.caption := zt_object_id_caption.caption + ' (' + Translation.translation__messages_r.word__administrator + ')';
              except
              end;

              try
                if zt_sdbm.Query__Field_By_Name( 'USER_ACTIVE' ).AsString = Common.db_grid__positive_value_c then
                  zt_object_id_caption.caption := zt_object_id_caption.caption + ' : ' + Translation.translation__messages_r.word__active;
              except
              end;


              Permissions__User_Names_CheckListBox.Items.AddObject( zt_object_id_caption.caption, zt_object_id_caption );


              zt_sdbm.Query__Next();

            end;

          zt_sdbm.Query__Close();

        end;

    end;


  FreeAndNil( zt_sdbm );


  if Trim( user_name_copy_l ) <> '' then
    for i := 0 to Permissions__User_Names_CheckListBox.Items.Count - 1 do
      if Permissions__User_Names_CheckListBox.Items[ i ] = user_name_copy_l then
        begin

          Permissions__User_Names_CheckListBox.ItemIndex := i;

          Break

        end;

end;

procedure TGenerators_Modify_F_Frame.Permissions__Grant_ButtonClick( Sender: TObject );
var
  ztb,
  error_occurred
    : boolean;

  i,
  j
    : integer;

  zts,
  error_message_l,
  sql_pattern_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( generators_sdbm = nil )
    or ( not generators_sdbm.Query__Active() )
    or ( generators_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  sql_pattern_l := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__permissions__grant__file_name_c  );

  if Trim( sql_pattern_l ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__permissions__grant__file_name_c + ').' );


      sql_pattern_l :=
        'grant USAGE on sequence __GENERATOR_NAME__ to user __USER_NAME__ ';

    end;

  if not values_logged__grant_g then
    begin

      values_logged__grant_g := true;
      Log_Memo.Lines.Add( sql_pattern_l );

    end;


  if Generators_DBGrid.SelectedRows.Count <= 0 then
    begin

      Generators_DBGrid.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.generators_must_be_selected), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  ztb := false;

  for i := 0 to Permissions__User_Names_CheckListBox.Items.Count - 1 do
    if Permissions__User_Names_CheckListBox.Checked[ i ] then
      begin

        ztb := true;

        Break;

      end;


  if not ztb then
    begin

      Permissions__User_Names_CheckListBox.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.users_must_be_selected), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  zts := '';

  for i := 0 to Permissions__User_Names_CheckListBox.Items.Count - 1 do
    if Permissions__User_Names_CheckListBox.Checked[ i ] then
      begin

        if Trim( zts ) <> '' then
          zts := zts +
            ', ';

        zts := zts +
          Common.TObject_Id_Caption(Permissions__User_Names_CheckListBox.Items.Objects[ i ]).name

      end;

  zts :=
    #13 +
    #13 +
    Translation.translation__messages_r.word__user__names + ': ' +
    zts + ';' +
    #13 +
    #13 +
    Translation.translation__messages_r.word__generators + ': ';


  for i := 0 to Generators_DBGrid.SelectedRows.Count - 1 do
    begin

      Generators_DBGrid.DataSource.DataSet.GotoBookmark( Generators_DBGrid.SelectedRows.Items[ i ] );

      if i > 0 then
        zts := zts +
          ', ';

      zts := zts +
        Generators_DBGrid.DataSource.DataSet.FieldByName( generators_list__column__generator_name__big_letter_c ).AsString;

    end;

  zts := zts +
    '.';


  if Application.MessageBox( PChar(Translation.translation__messages_r.grant_privileges_on_selected_generators_to_selected_users_ + zts), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  Screen.Cursor := crSQLWait;


  generators_sdbm.Operation_Duration__Calculating_Type__Set( Common.odct_multi_command );

  error_occurred := false;


  for i := 0 to Generators_DBGrid.SelectedRows.Count - 1 do
    begin

      Generators_DBGrid.DataSource.DataSet.GotoBookmark( Generators_DBGrid.SelectedRows.Items[ i ] );


      for j := 0 to Permissions__User_Names_CheckListBox.Items.Count - 1 do
        if Permissions__User_Names_CheckListBox.Checked[ j ] then
          begin

            zts := sql_pattern_l;

            zts := StringReplace(  zts, Common.sql__word_replace_separator_c + generators_list__column__generator_name__big_letter_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__GMF() + Generators_DBGrid.DataSource.DataSet.FieldByName( generators_list__column__generator_name__big_letter_c ).AsString + Self.Quotation_Sign__GMF(), [ rfReplaceAll ]  );
            zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__user__name__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__GMF() + Common.TObject_Id_Caption(Permissions__User_Names_CheckListBox.Items.Objects[ j ]).name + Self.Quotation_Sign__GMF(), [ rfReplaceAll ] );

            Log_Memo.Lines.Add( zts );


            ztb := generators_sdbm.Sql_Command_Execute(  zts, error_message_l, Translation.translation__messages_r.failed_to_grant_privileges + ' (' + Generators_DBGrid.DataSource.DataSet.FieldByName( generators_list__column__generator_name__big_letter_c ).AsString + ')'  );

            if    ( not ztb )
              and ( not error_occurred ) then
              error_occurred := true;


            if Trim( error_message_l ) <> '' then
              Log_Memo.Lines.Add
                (
                  Translation.translation__messages_r.failed_to_grant_privileges + ' (' +
                  Generators_DBGrid.DataSource.DataSet.FieldByName( generators_list__column__generator_name__big_letter_c ).AsString + ') ' +
                  error_message_l
                );

          end;

    end;


  generators_sdbm.Operation_Duration__Calculating_Type__Set( Common.odct_single_command );


  Screen.Cursor := crDefault;


  Refresh_ButtonClick( Sender );


  if error_occurred then
    begin

      Application.MessageBox( PChar(Translation.translation__messages_r.errors_were_encountered), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

    end
  else
    begin

      Log_Memo.Lines.Add( generators_sdbm.Operation_Duration_Get() );


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end;

end;

procedure TGenerators_Modify_F_Frame.Permissions__Revoke_ButtonClick( Sender: TObject );
var
  ztb,
  error_occurred
    : boolean;

  i,
  j
    : integer;

  zts,
  sql_pattern_l,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( generators_sdbm = nil )
    or ( not generators_sdbm.Query__Active() )
    or ( generators_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  sql_pattern_l := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__permissions__revoke__file_name_c  );

  if Trim( sql_pattern_l ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__permissions__revoke__file_name_c + ').' );


      sql_pattern_l :=
        'revoke USAGE on sequence __GENERATOR_NAME__ from user __USER_NAME__ ';


    end;

  if not values_logged__revoke_g then
    begin

      values_logged__revoke_g := true;
      Log_Memo.Lines.Add( sql_pattern_l );

    end;


  if Generators_DBGrid.SelectedRows.Count <= 0 then
    begin

      Generators_DBGrid.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.generators_must_be_selected), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  ztb := false;

  for i := 0 to Permissions__User_Names_CheckListBox.Items.Count - 1 do
    if Permissions__User_Names_CheckListBox.Checked[ i ] then
      begin

        ztb := true;

        Break;

      end;


  if not ztb then
    begin

      Permissions__User_Names_CheckListBox.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.users_must_be_selected), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  zts := '';

  for i := 0 to Permissions__User_Names_CheckListBox.Items.Count - 1 do
    if Permissions__User_Names_CheckListBox.Checked[ i ] then
      begin

        if Trim( zts ) <> '' then
          zts := zts +
            ', ';

        zts := zts +
          Common.TObject_Id_Caption(Permissions__User_Names_CheckListBox.Items.Objects[ i ]).name

      end;

  zts :=
    #13 +
    #13 +
    Translation.translation__messages_r.word__user__names + ': ' +
    zts + ';' +
    #13 +
    #13 +
    Translation.translation__messages_r.word__generators + ': ';


  for i := 0 to Generators_DBGrid.SelectedRows.Count - 1 do
    begin

      Generators_DBGrid.DataSource.DataSet.GotoBookmark( Generators_DBGrid.SelectedRows.Items[ i ] );

      if i > 0 then
        zts := zts +
          ', ';

      zts := zts +
        Generators_DBGrid.DataSource.DataSet.FieldByName( generators_list__column__generator_name__big_letter_c ).AsString;

    end;

  zts := zts +
    '.';


  if Application.MessageBox( PChar(Translation.translation__messages_r.revoke_privileges_on_selected_generators_from_selected_users_ + zts), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  Screen.Cursor := crSQLWait;


  generators_sdbm.Operation_Duration__Calculating_Type__Set( Common.odct_multi_command );

  error_occurred := false;


  for i := 0 to Generators_DBGrid.SelectedRows.Count - 1 do
    begin

      Generators_DBGrid.DataSource.DataSet.GotoBookmark( Generators_DBGrid.SelectedRows.Items[ i ] );


      for j := 0 to Permissions__User_Names_CheckListBox.Items.Count - 1 do
        if Permissions__User_Names_CheckListBox.Checked[ j ] then
          begin

            zts := sql_pattern_l;

            zts := StringReplace(  zts, Common.sql__word_replace_separator_c + generators_list__column__generator_name__big_letter_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__GMF() + Generators_DBGrid.DataSource.DataSet.FieldByName( generators_list__column__generator_name__big_letter_c ).AsString + Self.Quotation_Sign__GMF(), [ rfReplaceAll ]  );
            zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__user__name__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__GMF() + Common.TObject_Id_Caption(Permissions__User_Names_CheckListBox.Items.Objects[ j ]).name + Self.Quotation_Sign__GMF(), [ rfReplaceAll ] );

            Log_Memo.Lines.Add( zts );


            ztb := generators_sdbm.Sql_Command_Execute(  zts, error_message_l, Translation.translation__messages_r.failed_to_revoke_privileges + ' (' + Generators_DBGrid.DataSource.DataSet.FieldByName( generators_list__column__generator_name__big_letter_c ).AsString + ')'  );

            if    ( not ztb )
              and ( not error_occurred ) then
              error_occurred := true;


            if Trim( error_message_l ) <> '' then
              Log_Memo.Lines.Add
                (
                  Translation.translation__messages_r.failed_to_revoke_privileges + ' (' +
                  Generators_DBGrid.DataSource.DataSet.FieldByName( generators_list__column__generator_name__big_letter_c ).AsString + ') ' +
                  error_message_l
                );

          end;

    end;


  generators_sdbm.Operation_Duration__Calculating_Type__Set( Common.odct_single_command );


  Screen.Cursor := crDefault;


  Refresh_ButtonClick( Sender );


  if error_occurred then
    begin

      Application.MessageBox( PChar(Translation.translation__messages_r.errors_were_encountered), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

    end
  else
    begin

      Log_Memo.Lines.Add( generators_sdbm.Operation_Duration_Get() );


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end;

end;

procedure TGenerators_Modify_F_Frame.Permissions__Filter__Users__Apply_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  user_names__filter_g := '';

  for i := 0 to Permissions__User_Names_CheckListBox.Items.Count - 1 do
    if Permissions__User_Names_CheckListBox.Checked[ i ] then
      begin

        if Trim( user_names__filter_g ) <> '' then
          user_names__filter_g := user_names__filter_g +
            ', ';

        user_names__filter_g := user_names__filter_g +
          Common.TObject_Id_Caption(Permissions__User_Names_CheckListBox.Items.Objects[ i ]).name;

      end;


  if Trim( user_names__filter_g ) = '' then
    begin

      Permissions__User_Names_CheckListBox.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.users_must_be_selected), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;



  Self.Data_Open__GMF( true );

end;

procedure TGenerators_Modify_F_Frame.Permissions__Filter__Users__Cancel_ButtonClick( Sender: TObject );
begin

  user_names__filter_g := '';

  Self.Data_Open__GMF( true );

end;

procedure TGenerators_Modify_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Buttons_Panel.Width := 1;

end;

procedure TGenerators_Modify_F_Frame.Permissions__User_Names_CheckListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
var
  i : integer;
begin

  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl ] ) then
    Permissions__Filter__Users__Cancel_ButtonClick( Sender )
  else
  if Key = VK_RETURN then
    Permissions__Filter__Users__Apply_ButtonClick( Sender )
  else
  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Permissions__User_Names_CheckListBox.CheckAll( cbChecked, false, false )
  else
  // N.
  if    ( Key = 78 )
    and ( Shift = [ ssCtrl ] ) then
    Permissions__User_Names_CheckListBox.CheckAll( cbUnchecked, false, false )
  else
  // I.
  if    ( Key = 73 )
    and ( Shift = [ ssCtrl ] ) then
    begin

      for i := 0 to Permissions__User_Names_CheckListBox.Items.Count - 1 do
        Permissions__User_Names_CheckListBox.Checked[ i ] := not Permissions__User_Names_CheckListBox.Checked[ i ];

    end
  else
  // R.
  if    ( Key = 82 )
    and ( Shift = [ ssCtrl ] ) then
    Permissions__Refresh_ButtonClick( Sender );

end;

procedure TGenerators_Modify_F_Frame.Generator__Description__Set_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  modal_result : TModalResult;

  zts,
  description_value_l,
  error_message_l,
  generator_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( generators_sdbm = nil )
    or ( not generators_sdbm.Query__Active() )
    or ( generators_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Text__Edit_Memo.Text__Edit_Memo_Form := Text__Edit_Memo.TText__Edit_Memo_Form.Create( Application );
  //Text__Edit_Memo.Text__Edit_Memo_Form.text_value := generators_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
  Text__Edit_Memo.Text__Edit_Memo_Form.text_value := Description_Get__GMF();
  Text__Edit_Memo.Text__Edit_Memo_Form.quotation_mark_duplicate := true;
  Text__Edit_Memo.Text__Edit_Memo_Form.Caption := Translation.translation__messages_r.word__description___generator;
  Text__Edit_Memo.Text__Edit_Memo_Form.Text_Type_Set( Text__Edit_Memo.tt_Memo );
  modal_result := Text__Edit_Memo.Text__Edit_Memo_Form.ShowModal();

  if modal_result = mrOk then
    description_value_l := Text__Edit_Memo.Text__Edit_Memo_Form.text_value;

  FreeAndNil( Text__Edit_Memo.Text__Edit_Memo_Form );


  generator_name_l := Self.Quotation_Sign__GMF() + Trim(  generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString  ) + Self.Quotation_Sign__GMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__description__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__description__set__file_name_c + ').' );

      zts :=
        'comment on generator ' +
        generator_name_l +
        ' is ''' + description_value_l + ''' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + generators_list__column__generator_name__big_letter_c + Common.sql__word_replace_separator_c, generator_name_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if modal_result <> mrOk then
    Exit;


  ztb := generators_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_generator_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( generators_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TGenerators_Modify_F_Frame.Generator__Description__Drop_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l,
  generator_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( generators_sdbm = nil )
    or ( not generators_sdbm.Query__Active() )
    or ( generators_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  generator_name_l := Self.Quotation_Sign__GMF() + Trim(  generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString  ) + Self.Quotation_Sign__GMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__description__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__gmf_g ) + generators_list__sql__description__drop__file_name_c + ').' );

      zts :=
        'comment on generator ' +
        generator_name_l +
        ' is null ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + generators_list__column__generator_name__big_letter_c + Common.sql__word_replace_separator_c, generator_name_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_generator_description + ' ''' + generator_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := generators_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_generator_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( generators_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TGenerators_Modify_F_Frame.Generator__Description__Write_In_Log_MenuItemClick( Sender: TObject );
begin

  if   ( generators_sdbm = nil )
    or ( not generators_sdbm.Query__Active() )
    or ( generators_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Log_Memo.Lines.Add( '' );
  //Log_Memo.Lines.Add(  generators_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString  );
  Log_Memo.Lines.Add( Description_Get__GMF() );

end;

procedure TGenerators_Modify_F_Frame.Modify__Value_SpinEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_RETURN then
    Modify__Edit_ButtonClick( Sender );

end;

procedure TGenerators_Modify_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TGenerators_Modify_F_Frame.Generators_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
begin

  Common.DB_Grid_Draw_Column_Cell( sort__column_name_g, Generators_DBGrid, Rect, DataCol, Column, State );

end;

procedure TGenerators_Modify_F_Frame.Generators_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_DELETE then
    Modify__Delete_ButtonClick( Sender )
  else
  if Key = VK_RETURN then
    Modify__Edit_ButtonClick( Sender )
  else
  if Key = VK_SPACE then
    Generators_DBGrid.SelectedRows.CurrentRowSelected := not Generators_DBGrid.SelectedRows.CurrentRowSelected
  else
  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Common.DB_Grid_Select( Generators_DBGrid, true )
  else
  // N.
  if    ( Key = 78 )
    and ( Shift = [ ssCtrl ] ) then
    Common.DB_Grid_Select( Generators_DBGrid, false )
  else
  // I.
  if    ( Key = 73 )
    and ( Shift = [ ssCtrl ] ) then
    Common.DB_Grid_Select( Generators_DBGrid, false, true )
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( generators_sdbm.Query__Active() )
    and ( generators_sdbm.Query__Record_Count > 0 )
    and ( Generators_DBGrid.SelectedField <> nil ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Generators_DBGrid.SelectedField.Value;
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

procedure TGenerators_Modify_F_Frame.Generators_DBGridTitleClick( Column: TColumn );
begin

  if Column.Field = nil then
    Exit;


  if sort__column_name_g = Column.Field.FieldName then
    sort__direction_ascending_g := not sort__direction_ascending_g
  else
    sort__column_name_g := Column.Field.FieldName;

  generators_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );


  Generator_Name_DBEditChange( nil ); // For FireDAC.

end;

end.
