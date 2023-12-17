unit Generators_Modify_F;{21.Cze.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Samples.Spin, Vcl.Menus;

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

    procedure Generator_Name_DBEditChange( Sender: TObject );
    procedure Search_Change( Sender: TObject );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );

    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Modify__Add_ButtonClick( Sender: TObject );
    procedure Modify__Edit_ButtonClick( Sender: TObject );
    procedure Modify__Delete_ButtonClick( Sender: TObject );

    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );

    procedure Generator__Description__Set_MenuItemClick( Sender: TObject );
    procedure Generator__Description__Drop_MenuItemClick( Sender: TObject );
    procedure Generator__Description__Write_In_Log_MenuItemClick( Sender: TObject );

    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Generators_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
    procedure Generators_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Generators_DBGridTitleClick( Column: TColumn );
  private
    { Private declarations }
    sort__direction_ascending_g,
    sql__quotation_sign__use__gmf_g
      : boolean;

    database_type__gmf_g,
    sort__column_name_g,
    sql__quotation_sign__gmf_g
      : string;

    generators_sdbm : Common.TSDBM;

    function Description_Get__GMF() : string;
    function Quotation_Sign__GMF() : string;
  public
    { Public declarations }
    procedure Data_Open__GMF( const force_refresh_f : boolean = false );
    procedure Finish__GMF();
    procedure Options_Set__GMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
    procedure Prepare__GMF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
  end;

const
  generator_list__sql__description__drop__file_name_c : string = 'Generator__Description__Drop__sql.txt';
  generator_list__sql__description__get__file_name_c : string = 'Generator__Description__Get__sql.txt';
  generator_list__sql__description__set__file_name_c : string = 'Generator__Description__Set__sql.txt';
  generators_list__file_name_c : string = 'Generators_List__sql.txt';
  generators_list__column__generator_name__big_letter_c : string = 'GENERATOR_NAME';
  generators_list__column__generator_name__small_letter_c : string = 'generator_name';
  generators_list__column__generator_value_c : string = 'GENERATOR_VALUE';
  generators_list__sql__generator__create__file_name_c : string = 'Generator__Create__sql.txt';
  generators_list__sql__generator__drop__file_name_c : string = 'Generator__Drop__sql.txt';
  generators_list__sql__generator__set__file_name_c : string = 'Generator__Set__sql.txt';

implementation

uses
  System.IOUtils,
  Vcl.Clipbrd,

  Shared,
  Text__Edit_Memo,
  Translation;

{$R *.dfm}

procedure TGenerators_Modify_F_Frame.Data_Open__GMF( const force_refresh_f : boolean = false );
var
  i : integer;

  zts : string;
begin

  if   ( generators_sdbm = nil )
    or ( generators_sdbm.component_type__sdbm = Common.ct_none )
    or (
             ( not force_refresh_f )
         and ( generators_sdbm.Query__Active() )
       ) then
    Exit;


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__gmf_g + System.IOUtils.TPath.DirectorySeparatorChar + generators_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + generators_list__file_name_c + ').' );

      zts :=
        'execute block ' +
        //'returns (  GENERATOR_NAME varchar( 100 ), GENERATOR_VALUE bigint, DESCRIPTION_VALUE varchar( 10000 )  ) ' +
        'returns (  GENERATOR_NAME varchar( 100 ), GENERATOR_VALUE bigint, DESCRIPTION_VALUE varchar( 8191 )  ) ' + // FireDAC limit default - FDConnection1.FormatOptions.MaxStringSize = 32767 bytes ( / 4 = 8191,75 ).
        'as ' +
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
        '      begin ' +
        ' ' +
        '        execute statement ' +
        //'          ''select gen_id( '' || GENERATOR_NAME || '', 0 ) from RDB$DATABASE '' ' +
        //'          ''select gen_id( ' + Quotation_Sign__GMF() + ''' || GENERATOR_NAME || ''' + Quotation_Sign__GMF() + ', 0 ) from RDB$DATABASE '' ' +
        '          ''select gen_id( "'' || GENERATOR_NAME || ''", 0 ) from RDB$DATABASE '' ' +
        '          into GENERATOR_VALUE; ' +
        ' ' +
        '        suspend; ' +
        ' ' +
        '      end ' +
        'end ';

    end;


  Screen.Cursor := crHourGlass;


  if generators_sdbm.Query__Active() then
    generators_sdbm.Query__Close();

  generators_sdbm.Query__Sql__Set( zts );


  Log_Memo.Lines.Add( zts );


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
        if Generators_DBGrid.Columns.Items[ i ].FieldName = generators_list__column__generator_name__big_letter_c then
          Generators_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__name
        else
        if Generators_DBGrid.Columns.Items[ i ].FieldName = generators_list__column__generator_value_c then
          Generators_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__value
        else
          begin

            Generators_DBGrid.Columns.Items[ i ].Title.Caption := Common.Column_Name_To_Grid_Caption( Generators_DBGrid.Columns.Items[ i ].Title.Caption );


            if Generators_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value_c then
              begin

                if Generators_DBGrid.Columns.Items[ i ].Width > 500 then
                  Generators_DBGrid.Columns.Items[ i ].Width := 500;

              end
            else
              if Generators_DBGrid.Columns.Items[ i ].Width > 200 then
                Generators_DBGrid.Columns.Items[ i ].Width := 200;

          end;

    end;

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


  generator_name_l := Quotation_Sign__GMF() + Trim(  generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString  ) + Quotation_Sign__GMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__gmf_g + System.IOUtils.TPath.DirectorySeparatorChar + generator_list__sql__description__get__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + generator_list__sql__description__get__file_name_c + ').' );

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

  FreeAndNil( generators_sdbm );

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


  Translation.Translation__Apply( Self );

end;

procedure TGenerators_Modify_F_Frame.Prepare__GMF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
begin

  Self.Name := '';

  database_type__gmf_g := databases_r_f.database_type;
  sort__column_name_g := generators_list__column__generator_name__big_letter_c;
  sort__direction_ascending_g := true;


  generators_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Options_Set__GMF( component_type_f, databases_r_f.sql__quotation_sign, sql__quotation_sign__use_f );


  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );

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
    and ( TComponent(Sender).Name = Refresh_Button.Name ) then
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


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__gmf_g + System.IOUtils.TPath.DirectorySeparatorChar + generators_list__sql__generator__create__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + generators_list__sql__generator__create__file_name_c + ').' );

      zts :=
        'create generator ' +
        Quotation_Sign__GMF() + Modify__Name_Edit.Text + Quotation_Sign__GMF() +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + generators_list__column__generator_name__big_letter_c + Common.sql__word_replace_separator_c, Quotation_Sign__GMF() + Modify__Name_Edit.Text + Quotation_Sign__GMF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.add_generator + ' ''' + Quotation_Sign__GMF() + Modify__Name_Edit.Text + Quotation_Sign__GMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
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


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__gmf_g + System.IOUtils.TPath.DirectorySeparatorChar + generators_list__sql__generator__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + generators_list__sql__generator__set__file_name_c + ').' );

      zts :=
        'set generator ' +
        Quotation_Sign__GMF() + generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString + Quotation_Sign__GMF() +
        ' to ' +
        IntToStr( Modify__Value_SpinEdit.Value ) +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + generators_list__column__generator_name__big_letter_c + Common.sql__word_replace_separator_c, Quotation_Sign__GMF() + generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString + Quotation_Sign__GMF(), [ rfReplaceAll ] );
      zts := StringReplace(  zts, Common.sql__word_replace_separator_c + generators_list__column__generator_value_c + Common.sql__word_replace_separator_c, IntToStr( Modify__Value_SpinEdit.Value ), [ rfReplaceAll ]  );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.set_generator + ' ''' + Quotation_Sign__GMF() + generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString + Quotation_Sign__GMF() + ''' ' + Translation.translation__messages_r.word__value_to + ' ''' + IntToStr( Modify__Value_SpinEdit.Value ) + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := generators_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_generator );


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


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__gmf_g + System.IOUtils.TPath.DirectorySeparatorChar + generators_list__sql__generator__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + generators_list__sql__generator__drop__file_name_c + ').' );

      zts :=
        'drop generator ' +
        Quotation_Sign__GMF() + generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString + Quotation_Sign__GMF() +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + generators_list__column__generator_name__big_letter_c + Common.sql__word_replace_separator_c, Quotation_Sign__GMF() + generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString + Quotation_Sign__GMF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_generator + ' ''' + Quotation_Sign__GMF() + generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString + Quotation_Sign__GMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
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

procedure TGenerators_Modify_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Buttons_Panel.Width := 1;

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


  generator_name_l := Quotation_Sign__GMF() + Trim(  generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString  ) + Quotation_Sign__GMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__gmf_g + System.IOUtils.TPath.DirectorySeparatorChar + generator_list__sql__description__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + generator_list__sql__description__set__file_name_c + ').' );

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


  generator_name_l := Quotation_Sign__GMF() + Trim(  generators_sdbm.Query__Field_By_Name( generators_list__column__generator_name__big_letter_c ).AsString  ) + Quotation_Sign__GMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__gmf_g + System.IOUtils.TPath.DirectorySeparatorChar + generator_list__sql__description__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + generator_list__sql__description__drop__file_name_c + ').' );

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

procedure TGenerators_Modify_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( ssCtrl in Shift )
    and (  not ( ssAlt in Shift )  ) then
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
