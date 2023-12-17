unit Database__Create;{10.Paü.2023}

interface

uses
  Common,

  Data.DB, IBX.IBDatabase,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls, Vcl.ComCtrls,
  DosCommand;

type
  TDatabase__Create_Form = class( TForm )
    Database_GroupBox: TGroupBox;
    Database__Default_Character_Set_ComboBox: TComboBox;
    Database__Create__Application__File_Path_GroupBox: TGroupBox;
    Database__Create__Application__File_Path__Find_Button: TButton;
    Database__Create__Application__File_Path_Edit: TEdit;
    OpenDialog1: TOpenDialog;
    Database__File_Path_GroupBox: TGroupBox;
    Database__File_Path__Find_Button: TButton;
    Database__File_Path_Edit: TEdit;
    User_Name_Etiquette_Label: TLabel;
    User_Name_Edit: TEdit;
    Password_Etiquette_Label: TLabel;
    Password_Edit: TEdit;
    Buttons_Panel: TPanel;
    Command_Prepare_Button: TButton;
    Execute_Button: TButton;
    Execute_Button_Works_As_Prepare_Execute_CheckBox: TCheckBox;
    Memos_PageControl: TPageControl;
    Log_TabSheet: TTabSheet;
    Log_Memo: TMemo;
    Command_TabSheet: TTabSheet;
    Command_Memo: TMemo;
    Quotation_Sign__Use_CheckBox: TCheckBox;
    Database_Memo_Horizontal_Splitter: TSplitter;
    Database__Default_Character_Set_Etiquette_Label: TLabel;
    Database__Page_Size_Etiquette_Label: TLabel;
    Database__Page_Size_ComboBox: TComboBox;
    Database__Sql_Dialect_Etiquette_Label: TLabel;
    Database__Sql_Dialect_ComboBox: TComboBox;
    Database_Type_GroupBox: TGroupBox;
    Database_Type_ComboBox: TComboBox;
    Creation_Method_RadioGroup: TRadioGroup;
    Database__Collation_Etiquette_Label: TLabel;
    Database__Collation_ComboBox: TComboBox;
    Help_Button: TButton;
    Database_Type__Refresh_Button: TButton;
    DosCommand1: TDosCommand;
    procedure FormCreate( Sender: TObject );
    procedure FormShow( Sender: TObject );
    procedure FormDestroy( Sender: TObject );

    procedure Command_Prepare_ButtonClick( Sender: TObject );
    procedure Execute_ButtonClick( Sender: TObject );

    procedure File_Path_EditExit( Sender: TObject );
    procedure File_Path__Find_ButtonClick( Sender: TObject );
    procedure Database_Type_ComboBoxChange( Sender: TObject );
    procedure Database_Type_ComboBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Creation_Method_RadioGroupClick( Sender: TObject );
    procedure Help_ButtonClick( Sender: TObject );

    procedure DosCommand1NewLine( ASender: TObject; const ANewLine: string; AOutputType: TOutputType );
    procedure DosCommand1Terminated( Sender: TObject );

    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Command_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
  private
    { Private declarations }
    command_prepared_correctly_g : boolean;

    hint__ib_database_g,
    hint__isql_g,
    hint__sql_g,
    ib_database__parameters_g,
    word__collation__isql_g,
    word__collation__sql_g,
    word__database_create__isql_g,
    word__database_create__sql_g,
    word__default_character_set__isql_g,
    word__default_character_set__sql_g,
    word__exit__isql_g,
    word__page_size__isql_g,
    word__page_size__sql_g,
    word__password__isql_g,
    word__password__sql_g,
    word__user_name__isql_g,
    word__user_name__sql_g
      : string;

    ib_database_g : IBX.IBDatabase.TIBDatabase;
  public
    { Public declarations }
    splitter_show__dbr : boolean;

    procedure Password__Set( const password_f : string );
    procedure User_Name__Set( const user_name_f : string );
  end;

const
  database__create__hint__ib_database__file_name_c : string = 'Database__Create__Hint__IB_Database.txt';
  database__create__hint__isql__file_name_c : string = 'Database__Create__Hint__Isql.txt';
  database__create__hint__sql__file_name_c : string = 'Database__Create__Hint__Sql.txt';
  database__create__ib_database__parameters_list__file_name_c : string = 'Database__Create__IB_Database__Parameters_List.txt';
  database__create__isql__collation__isql__file_name_c : string = 'Database__Create__Collation__Isql.txt';
  database__create__isql__database_create__isql__file_name_c : string = 'Database__Create__Database_Create__Isql.txt';
  database__create__isql__default_character_set__isql__file_name_c : string = 'Database__Create__Default_Character_Set__Isql.txt';
  database__create__isql__exit__isql__file_name_c : string = 'Database__Create__Exit__Isql.txt';
  database__create__isql__page_size__isql__file_name_c : string = 'Database__Create__Page_Size__Isql.txt';
  database__create__isql__password__isql__file_name_c : string = 'Database__Create__Password__Isql.txt';
  database__create__isql__user_name__isql__file_name_c : string = 'Database__Create__User_Name__Isql.txt';
  database__create__parameters__collation_list__file_name_c : string = 'Database__Create__Parameters__Collation_List.txt';
  database__create__parameters__default_character_set_list__file_name_c : string = 'Database__Create__Parameters__Default_Character_Set_List.txt';
  database__create__parameters__page_size_list__file_name_c : string = 'Database__Create__Parameters__Page_Size_List.txt';
  database__create__parameters__sql_dialect_list__file_name_c : string = 'Database__Create__Sql_Dialect_List.txt';
  database__create__parameters__value__collation_c : string = 'COLLATION';
  database__create__parameters__value__database_file_path_c : string = 'DATABASE_FILE_PATH';
  database__create__parameters__value__default_character_set_c : string = 'DEFAULT_CHARACTER_SET';
  database__create__parameters__value__page_size_c : string = 'PAGE_SIZE';
  database__create__sql__collation__sql__file_name_c : string = 'Database__Create__Collation__Sql__sql.txt';
  database__create__sql__database_create__sql__file_name_c : string = 'Database__Create__Database_Create__Sql__sql.txt';
  database__create__sql__default_character_set__sql__file_name_c : string = 'Database__Create__Default_Character_Set__Sql__sql.txt';
  database__create__sql__page_size__sql__file_name_c : string = 'Database__Create__Page_Size__Sql__sql.txt';
  database__create__sql__password__sql__file_name_c : string = 'Database__Create__Password__Sql__sql.txt';
  database__create__sql__user_name__sql__file_name_c : string = 'Database__Create__User_Name__Sql__sql.txt';

var
  Database__Create_Form: TDatabase__Create_Form;

implementation

uses
  System.IOUtils,
  System.TypInfo,
  System.UITypes,
  //Winapi.ShellAPI,

  Shared,
  Translation;

{$R *.dfm}

procedure TDatabase__Create_Form.Password__Set( const password_f : string );
begin

  Password_Edit.Text := password_f;

end;

procedure TDatabase__Create_Form.User_Name__Set( const user_name_f : string );
begin

  User_Name_Edit.Text := user_name_f;

end;

procedure TDatabase__Create_Form.FormCreate( Sender: TObject );
var
  search_rec : TSearchRec;
begin

  command_prepared_correctly_g := false;
  splitter_show__dbr := true;

  ib_database_g := nil;

  Database__Create__Application__File_Path_Edit.Text := Common.database__create__application__file_path;

  File_Path_EditExit( Sender );


  Database_Type_ComboBox.Items.Clear();

  if FindFirst(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + '\*.*', faDirectory, search_rec  ) = 0 then
    begin

      repeat

        if    ( search_rec.Attr = faDirectory )
          and ( search_rec.Name <> '.' )
          and ( search_rec.Name <> '..' ) then
          Database_Type_ComboBox.Items.Add( search_rec.Name );

      until FindNext( search_rec ) <> 0;

    end;

  FindClose( search_rec );


  Memos_PageControl.ActivePage := Log_TabSheet;


  Translation.Translation__Apply( Self );

end;

procedure TDatabase__Create_Form.FormShow( Sender: TObject );
begin

  if Database_Type_ComboBox.Items.Count > 0 then
    Database_Type_ComboBox.ItemIndex := 0;

  Database_Type_ComboBoxChange( Sender );
  //Creation_Method_RadioGroupClick( Sender ); // Is inside Database_Type_ComboBoxChange().


  Common.Font__Set( Command_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );

end;

procedure TDatabase__Create_Form.FormDestroy( Sender: TObject );
begin

  if ib_database_g <> nil then
    FreeAndNil( ib_database_g );

end;

procedure TDatabase__Create_Form.Command_Prepare_ButtonClick( Sender: TObject );

  function Quotation_Sign__DBC() : string;
  begin

    if Quotation_Sign__Use_CheckBox.Checked then
      begin

        Result := Common.database__backup_restore__quotation_sign;

      end
    else
      Result := '';

  end;

var
  i : integer;

  zts : string;
begin

  command_prepared_correctly_g := false;


  if Trim( Database__File_Path_Edit.Text ) = '' then
    begin

      Database__File_Path_Edit.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.database_file_path_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;

  if Trim( Database__Create__Application__File_Path_Edit.Text ) = '' then
    begin

      Database__Create__Application__File_Path_Edit.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.database_create_application_file_path_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;

  if Trim( User_Name_Edit.Text ) = '' then
    begin

      User_Name_Edit.SetFocus();

      if Application.MessageBox( PChar(Translation.translation__messages_r.user_name_should_not_be_empty+ #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES then
        Exit;

    end;

  if Trim( Password_Edit.Text ) = '' then
    begin

      Password_Edit.SetFocus();

      if Application.MessageBox( PChar(Translation.translation__messages_r.user_password_should_not_be_empty+ #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES then
        Exit;

    end;


  Memos_PageControl.ActivePage := Command_TabSheet;

  Command_Memo.Lines.Clear();

  if Creation_Method_RadioGroup.ItemIndex = 0 then // IBDatabase component.
    begin

      if    ( ib_database_g <> nil )
        and (  Assigned( ib_database_g )  ) then
        begin

          zts := ib_database__parameters_g;

          zts := StringReplace( zts, Common.sql__word_replace_separator_c + database__create__parameters__value__collation_c + Common.sql__word_replace_separator_c, Database__Collation_ComboBox.Text, [ rfReplaceAll ] );
          zts := StringReplace( zts, Common.sql__word_replace_separator_c + database__create__parameters__value__database_file_path_c + Common.sql__word_replace_separator_c, Database__File_Path_Edit.Text, [ rfReplaceAll ] );
          zts := StringReplace( zts, Common.sql__word_replace_separator_c + database__create__parameters__value__default_character_set_c + Common.sql__word_replace_separator_c, Database__Default_Character_Set_ComboBox.Text, [ rfReplaceAll ] );
          zts := StringReplace( zts, Common.sql__word_replace_separator_c + database__create__parameters__value__page_size_c + Common.sql__word_replace_separator_c, Database__Page_Size_ComboBox.Text, [ rfReplaceAll ] );
          zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__user__name__big_letters_c + Common.sql__word_replace_separator_c, User_Name_Edit.Text, [ rfReplaceAll ] );
          zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__user__password_c + Common.sql__word_replace_separator_c, Password_Edit.Text, [ rfReplaceAll ] );


          i := Pos( #13 + #10, zts );

          while i > 0 do
            begin

              if Trim(  Copy( zts, 1, i - 1 )  ) <> '' then
                Command_Memo.Lines.Add(  Copy( zts, 1, i - 1 )  );

              Delete( zts, 1, i + 1 );

              i := Pos( #13 + #10, zts );

            end;

        end;

    end
  else
  if Creation_Method_RadioGroup.ItemIndex = 1 then // isql.exe.
    begin

      Command_Memo.Lines.Add( Quotation_Sign__DBC() + Database__Create__Application__File_Path_Edit.Text + Quotation_Sign__DBC() );

      zts :=
        StringReplace( word__database_create__isql_g, Common.sql__word_replace_separator_c + database__create__parameters__value__database_file_path_c + Common.sql__word_replace_separator_c, Database__File_Path_Edit.Text, [ rfReplaceAll ] );

      zts := zts +
        StringReplace( word__user_name__isql_g, Common.sql__word_replace_separator_c + Common.name__user__name__big_letters_c + Common.sql__word_replace_separator_c, User_Name_Edit.Text, [ rfReplaceAll ] );

      zts := zts +
        StringReplace( word__password__isql_g, Common.sql__word_replace_separator_c + Common.name__user__password_c + Common.sql__word_replace_separator_c, Password_Edit.Text, [ rfReplaceAll ] );

      if Trim( Database__Page_Size_ComboBox.Text ) <> '' then
        zts := zts +
          StringReplace( word__page_size__isql_g, Common.sql__word_replace_separator_c + database__create__parameters__value__page_size_c + Common.sql__word_replace_separator_c, Database__Page_Size_ComboBox.Text, [ rfReplaceAll ] );

      if    (  Trim( Database__Collation_ComboBox.Text ) <> ''  )
        and (  Trim( word__collation__isql_g ) <> ''  ) then
        zts := zts +
          StringReplace( word__collation__isql_g, Common.sql__word_replace_separator_c + database__create__parameters__value__collation_c + Common.sql__word_replace_separator_c, Database__Collation_ComboBox.Text, [ rfReplaceAll ] );

      if    (  Trim( Database__Default_Character_Set_ComboBox.Text ) <> ''  )
        and (  Trim( word__default_character_set__isql_g ) <> ''  ) then
        zts := zts +
          StringReplace( word__default_character_set__isql_g, Common.sql__word_replace_separator_c + database__create__parameters__value__default_character_set_c + Common.sql__word_replace_separator_c, Database__Default_Character_Set_ComboBox.Text, [ rfReplaceAll ] );

      zts := zts +
        ';';

      zts := zts +
        word__exit__isql_g;


      Command_Memo.Lines.Add( zts );

    end
  else
  if Creation_Method_RadioGroup.ItemIndex = 2 then // SQL.
    begin

      zts :=
        StringReplace( word__database_create__sql_g, Common.sql__word_replace_separator_c + database__create__parameters__value__database_file_path_c + Common.sql__word_replace_separator_c, Database__File_Path_Edit.Text, [ rfReplaceAll ] ) + #13 + #10;

      zts := zts +
        StringReplace( word__user_name__sql_g, Common.sql__word_replace_separator_c + Common.name__user__name__big_letters_c + Common.sql__word_replace_separator_c, User_Name_Edit.Text, [ rfReplaceAll ] ) + #13 + #10;

      zts := zts +
        StringReplace( word__password__sql_g, Common.sql__word_replace_separator_c + Common.name__user__password_c + Common.sql__word_replace_separator_c, Password_Edit.Text, [ rfReplaceAll ] ) + #13 + #10;

      if Trim( Database__Page_Size_ComboBox.Text ) <> '' then
        zts := zts +
          StringReplace( word__page_size__sql_g, Common.sql__word_replace_separator_c + database__create__parameters__value__page_size_c + Common.sql__word_replace_separator_c, Database__Page_Size_ComboBox.Text, [ rfReplaceAll ] ) + #13 + #10;

      if Trim( Database__Default_Character_Set_ComboBox.Text ) <> '' then
        zts := zts +
          StringReplace( word__default_character_set__sql_g, Common.sql__word_replace_separator_c + database__create__parameters__value__default_character_set_c + Common.sql__word_replace_separator_c, Database__Default_Character_Set_ComboBox.Text, [ rfReplaceAll ] ) + #13 + #10;

      if Trim( Database__Collation_ComboBox.Text ) <> '' then
        zts := zts +
          StringReplace( word__collation__sql_g, Common.sql__word_replace_separator_c + database__create__parameters__value__collation_c + Common.sql__word_replace_separator_c, Database__Collation_ComboBox.Text, [ rfReplaceAll ] ) + #13 + #10;


      Command_Memo.Lines.Add( zts );

    end;


  command_prepared_correctly_g := true;

end;

procedure TDatabase__Create_Form.Execute_ButtonClick( Sender: TObject );
var
  zti : integer;

  application__file_path_l,
  application__parameters_l
    : string;
begin

  command_prepared_correctly_g := false;


  if Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked then
    begin

      Command_Prepare_ButtonClick( Sender );

      if not command_prepared_correctly_g then
        Exit;

      command_prepared_correctly_g := false;

    end;



  if Creation_Method_RadioGroup.ItemIndex = 0 then // IBDatabase component.
    begin

      if    ( ib_database_g <> nil )
        and (  Assigned( ib_database_g )  ) then
        begin

          ib_database_g.Params.Clear();

          ib_database_g.DatabaseName := Database__File_Path_Edit.Text;

          try
            ib_database_g.SQLDialect := StrToInt( Database__Sql_Dialect_ComboBox.Text );
          except
            on E : Exception do
              begin

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_set_sql_dialect + #13 + #13 + E.Message + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );
                Exit;

              end;
          end;


          for zti := 0 to Command_Memo.Lines.Count - 1 do
            if Trim( Command_Memo.Lines[ zti ] ) <> '' then
              ib_database_g.Params.Add( Command_Memo.Lines[ zti ] );


          try
            ib_database_g.CreateDatabase();
          except
            on E : Exception do
              begin

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_create_database + #13 + #13 + E.Message + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );
                Exit;

              end;
          end;

        end;

    end
  else
  if Creation_Method_RadioGroup.ItemIndex = 1 then // isql.exe.
    begin

      application__file_path_l := Command_Memo.Lines.Text;

      zti := Pos( #13 + #10, application__file_path_l );

      if zti > 0 then
        begin

          application__parameters_l := Copy(  application__file_path_l, zti + 2, Length( application__file_path_l )  );
          Delete(  application__file_path_l, zti, Length( application__file_path_l )  );

          application__parameters_l := StringReplace( application__parameters_l, #13 + #10, '', [ rfReplaceAll ] );

        end;


      //Winapi.ShellAPI.ShellExecute
      //  (
      //    0, nil,
      //    PChar(application__file_path_l),
      //    PChar(application__parameters_l),
      //    nil, SW_SHOW
      //  );


      Memos_PageControl.ActivePage := Log_TabSheet;


      DosCommand1.CommandLine := application__file_path_l;
      DosCommand1.CurrentDir := '';
      DosCommand1.Execute();
      DosCommand1.SendLine( application__parameters_l, true );

    end;


  Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

end;

procedure TDatabase__Create_Form.File_Path_EditExit( Sender: TObject );
begin

  if    ( Sender <> nil )
    and ( Sender is TEdit )then
    if    (  Trim( TEdit(Sender).Text ) <> ''  )
      and (  not FileExists( TEdit(Sender).Text )  ) then
      TEdit(Sender).Color := Common.color__red__light_c
    else
      TEdit(Sender).Color := clWindow;

end;

procedure TDatabase__Create_Form.File_Path__Find_ButtonClick( Sender: TObject );
var
  zt_edit : TEdit;
begin

  if Sender <> nil then
    begin

      zt_edit := nil;


      if TComponent(Sender).Name = Database__Create__Application__File_Path__Find_Button.Name then
        begin

          zt_edit := Database__Create__Application__File_Path_Edit;

          OpenDialog1.DefaultExt := Common.exe__file_default_extension;
          OpenDialog1.Filter := Translation.translation__messages_r.application_files + '|*' + Common.exe__file_default_extension + '|' + Translation.translation__messages_r.all_files + '|' + Common.all_files_find__filter;
          OpenDialog1.Options := OpenDialog1.Options + [ System.UITypes.TOpenOption.ofFileMustExist ];

        end
      else
        begin

          zt_edit := Database__File_Path_Edit;

          OpenDialog1.DefaultExt := Common.database__file_default_extension;
          OpenDialog1.Filter := Translation.translation__messages_r.firebird_database_files + '|*' + Common.database__file_default_extension + '|' + Translation.translation__messages_r.all_files + '|' + Common.all_files_find__filter;

          OpenDialog1.Options := OpenDialog1.Options - [ System.UITypes.TOpenOption.ofFileMustExist ];

        end;


      if zt_edit <> nil then
        begin

          if Trim( zt_edit.Text ) <> '' then
            OpenDialog1.InitialDir := ExtractFilePath( zt_edit.Text );


          if OpenDialog1.Execute() then
            zt_edit.Text := OpenDialog1.FileName;


          File_Path_EditExit( zt_edit );

        end;

    end;

end;

procedure TDatabase__Create_Form.Database_Type_ComboBoxChange( Sender: TObject );
var
  zts : string;
begin

  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__ib_database__parameters_list__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__ib_database__parameters_list__file_name_c + ').' );

      ib_database__parameters_g :=
        'user ''__USER_NAME__''' + #13 + #10 +
        'password ''__USER__PASSWORD__''' + #13 + #10 +
        'page_size __PAGE_SIZE__' + #13 + #10 +
        'default character set __DEFAULT_CHARACTER_SET__' + #13 + #10 +
        'collation __COLLATION__' + #13 + #10;

    end
  else
    begin

      ib_database__parameters_g := Common.Text__File_Load( zts );

    end;

  Log_Memo.Lines.Add( 'IBDatabase parameters: ' + ib_database__parameters_g + '.' );


  {$region 'Isql.'}
  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__isql__collation__isql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__isql__collation__isql__file_name_c + ').' );

      //word__collation__isql_g := 'collation __COLLATION__ ';
      word__collation__isql_g := '';

    end
  else
    begin

      word__collation__isql_g := Common.Text__File_Load( zts );

      word__collation__isql_g := StringReplace( word__collation__isql_g, #10, '', [] );
      word__collation__isql_g := StringReplace( word__collation__isql_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Collation isql: ' + word__collation__isql_g + '.' );


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__isql__database_create__isql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__isql__database_create__isql__file_name_c + ').' );

      word__database_create__isql_g := 'create database "__DATABASE_FILE_PATH__" ';

    end
  else
    begin

      word__database_create__isql_g := Common.Text__File_Load( zts );

      word__database_create__isql_g := StringReplace( word__database_create__isql_g, #10, '', [] );
      word__database_create__isql_g := StringReplace( word__database_create__isql_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Database create isql: ' + word__database_create__isql_g + '.' );


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__isql__default_character_set__isql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__isql__default_character_set__isql__file_name_c + ').' );

      //word__default_character_set__isql_g := 'default character set __DEFAULT_CHARACTER_SET__ ';
      word__default_character_set__isql_g := '';

    end
  else
    begin

      word__default_character_set__isql_g := Common.Text__File_Load( zts );

      word__default_character_set__isql_g := StringReplace( word__default_character_set__isql_g, #10, '', [] );
      word__default_character_set__isql_g := StringReplace( word__default_character_set__isql_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Default character set isql: ' + word__default_character_set__isql_g + '.' );


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__isql__exit__isql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__isql__exit__isql__file_name_c + ').' );

      word__exit__isql_g := ' exit;';

    end
  else
    begin

      word__exit__isql_g := Common.Text__File_Load( zts );

      word__exit__isql_g := StringReplace( word__exit__isql_g, #10, '', [] );
      word__exit__isql_g := StringReplace( word__exit__isql_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Exit isql: ' + word__exit__isql_g + '.' );


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__isql__page_size__isql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__isql__page_size__isql__file_name_c + ').' );

      word__page_size__isql_g := 'page_size __PAGE_SIZE__ ';

    end
  else
    begin

      word__page_size__isql_g := Common.Text__File_Load( zts );

      word__page_size__isql_g := StringReplace( word__page_size__isql_g, #10, '', [] );
      word__page_size__isql_g := StringReplace( word__page_size__isql_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Page size isql: ' + word__page_size__isql_g + '.' );


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__isql__password__isql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__isql__password__isql__file_name_c + ').' );

      word__password__isql_g := 'password ''__USER__PASSWORD__'' ';

    end
  else
    begin

      word__password__isql_g := Common.Text__File_Load( zts );

      word__password__isql_g := StringReplace( word__password__isql_g, #10, '', [] );
      word__password__isql_g := StringReplace( word__password__isql_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Password isql: ' + word__password__isql_g + '.' );


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__isql__user_name__isql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__isql__user_name__isql__file_name_c + ').' );

      word__user_name__isql_g := 'user __USER_NAME__ ';

    end
  else
    begin

      word__user_name__isql_g := Common.Text__File_Load( zts );

      word__user_name__isql_g := StringReplace( word__user_name__isql_g, #10, '', [] );
      word__user_name__isql_g := StringReplace( word__user_name__isql_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'User name isql: ' + word__user_name__isql_g + '.' );
  {$endregion 'Isql.'}


  {$region 'Sql.'}
  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__sql__collation__sql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__sql__collation__sql__file_name_c + ').' );

      word__collation__sql_g := 'collation __COLLATION__ ';

    end
  else
    begin

      word__collation__sql_g := Common.Text__File_Load( zts );

      word__collation__sql_g := StringReplace( word__collation__sql_g, #10, '', [] );
      word__collation__sql_g := StringReplace( word__collation__sql_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Collation sql: ' + word__collation__sql_g + '.' );


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__sql__database_create__sql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__sql__database_create__sql__file_name_c + ').' );

      word__database_create__sql_g := 'create database ''__DATABASE_FILE_PATH__'' ';

    end
  else
    begin

      word__database_create__sql_g := Common.Text__File_Load( zts );

      word__database_create__sql_g := StringReplace( word__database_create__sql_g, #10, '', [] );
      word__database_create__sql_g := StringReplace( word__database_create__sql_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Database create sql: ' + word__database_create__sql_g + '.' );


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__sql__default_character_set__sql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__sql__default_character_set__sql__file_name_c + ').' );

      word__default_character_set__sql_g := 'default character set __DEFAULT_CHARACTER_SET__ ';

    end
  else
    begin

      word__default_character_set__sql_g := Common.Text__File_Load( zts );

      word__default_character_set__sql_g := StringReplace( word__default_character_set__sql_g, #10, '', [] );
      word__default_character_set__sql_g := StringReplace( word__default_character_set__sql_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Default character set sql: ' + word__default_character_set__sql_g + '.' );


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__sql__page_size__sql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__sql__page_size__sql__file_name_c + ').' );

      word__page_size__sql_g := 'page_size __PAGE_SIZE__ ';

    end
  else
    begin

      word__page_size__sql_g := Common.Text__File_Load( zts );

      word__page_size__sql_g := StringReplace( word__page_size__sql_g, #10, '', [] );
      word__page_size__sql_g := StringReplace( word__page_size__sql_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Page size sql: ' + word__page_size__sql_g + '.' );


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__sql__password__sql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__sql__password__sql__file_name_c + ').' );

      word__password__sql_g := 'password ''__USER__PASSWORD__'' ';

    end
  else
    begin

      word__password__sql_g := Common.Text__File_Load( zts );

      word__password__sql_g := StringReplace( word__password__sql_g, #10, '', [] );
      word__password__sql_g := StringReplace( word__password__sql_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Password sql: ' + word__password__sql_g + '.' );


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__sql__user_name__sql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__sql__user_name__sql__file_name_c + ').' );

      word__user_name__sql_g := 'user __USER_NAME__ ';

    end
  else
    begin

      word__user_name__sql_g := Common.Text__File_Load( zts );

      word__user_name__sql_g := StringReplace( word__user_name__sql_g, #10, '', [] );
      word__user_name__sql_g := StringReplace( word__user_name__sql_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'User name sql: ' + word__user_name__sql_g + '.' );
  {$endregion 'Sql.'}


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__parameters__collation_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__parameters__collation_list__file_name_c + ').' );

      zts :=
        'PXW_PLK' + #13 + #10 +
        {$region 'Collations.'}
        'ASCII' + #13 + #10 +
        'BIG_5' + #13 + #10 +
        'BS_BA' + #13 + #10 +
        'CP943C' + #13 + #10 +
        'CP943C_UNICODE' + #13 + #10 +
        'CS_CZ' + #13 + #10 +
        'CYRL' + #13 + #10 +
        'DA_DA' + #13 + #10 +
        'DB_CSY' + #13 + #10 +
        'DB_DAN865' + #13 + #10 +
        'DB_DEU437' + #13 + #10 +
        'DB_DEU850' + #13 + #10 +
        'DB_ESP437' + #13 + #10 +
        'DB_ESP850' + #13 + #10 +
        'DB_FIN437' + #13 + #10 +
        'DB_FRA437' + #13 + #10 +
        'DB_FRA850' + #13 + #10 +
        'DB_FRC850' + #13 + #10 +
        'DB_FRC863' + #13 + #10 +
        'DB_ITA437' + #13 + #10 +
        'DB_ITA850' + #13 + #10 +
        'DB_NLD437' + #13 + #10 +
        'DB_NLD850' + #13 + #10 +
        'DB_NOR865' + #13 + #10 +
        'DB_PLK' + #13 + #10 +
        'DB_PTB850' + #13 + #10 +
        'DB_PTG860' + #13 + #10 +
        'DB_RUS' + #13 + #10 +
        'DB_SLO' + #13 + #10 +
        'DB_SVE437' + #13 + #10 +
        'DB_SVE850' + #13 + #10 +
        'DB_TRK' + #13 + #10 +
        'DB_UK437' + #13 + #10 +
        'DB_UK850' + #13 + #10 +
        'DB_US437' + #13 + #10 +
        'DB_US850' + #13 + #10 +
        'DE_DE' + #13 + #10 +
        'DOS437' + #13 + #10 +
        'DOS737' + #13 + #10 +
        'DOS775' + #13 + #10 +
        'DOS850' + #13 + #10 +
        'DOS852' + #13 + #10 +
        'DOS857' + #13 + #10 +
        'DOS858' + #13 + #10 +
        'DOS860' + #13 + #10 +
        'DOS861' + #13 + #10 +
        'DOS862' + #13 + #10 +
        'DOS863' + #13 + #10 +
        'DOS864' + #13 + #10 +
        'DOS865' + #13 + #10 +
        'DOS866' + #13 + #10 +
        'DOS869' + #13 + #10 +
        'DU_NL' + #13 + #10 +
        'EN_UK' + #13 + #10 +
        'EN_US' + #13 + #10 +
        'ES_ES' + #13 + #10 +
        'ES_ES_CI_AI' + #13 + #10 +
        'EUCJ_0208' + #13 + #10 +
        'FI_FI' + #13 + #10 +
        'FR_CA' + #13 + #10 +
        'FR_CA_CI_AI' + #13 + #10 +
        'FR_FR' + #13 + #10 +
        'FR_FR_CI_AI' + #13 + #10 +
        'GB18030' + #13 + #10 +
        'GB18030_UNICODE' + #13 + #10 +
        'GBK' + #13 + #10 +
        'GBK_UNICODE' + #13 + #10 +
        'GB_2312' + #13 + #10 +
        'ISO8859_1' + #13 + #10 +
        'ISO8859_13' + #13 + #10 +
        'ISO8859_2' + #13 + #10 +
        'ISO8859_3' + #13 + #10 +
        'ISO8859_4' + #13 + #10 +
        'ISO8859_5' + #13 + #10 +
        'ISO8859_6' + #13 + #10 +
        'ISO8859_7' + #13 + #10 +
        'ISO8859_8' + #13 + #10 +
        'ISO8859_9' + #13 + #10 +
        'ISO_HUN' + #13 + #10 +
        'ISO_PLK' + #13 + #10 +
        'IS_IS' + #13 + #10 +
        'IT_IT' + #13 + #10 +
        'KOI8R' + #13 + #10 +
        'KOI8R_RU' + #13 + #10 +
        'KOI8U' + #13 + #10 +
        'KOI8U_UA' + #13 + #10 +
        'KSC_5601' + #13 + #10 +
        'KSC_DICTIONARY' + #13 + #10 +
        'LT_LT' + #13 + #10 +
        'NEXT' + #13 + #10 +
        'NONE' + #13 + #10 +
        'NO_NO' + #13 + #10 +
        'NXT_DEU' + #13 + #10 +
        'NXT_ESP' + #13 + #10 +
        'NXT_FRA' + #13 + #10 +
        'NXT_ITA' + #13 + #10 +
        'NXT_US' + #13 + #10 +
        'OCTETS' + #13 + #10 +
        'PDOX_ASCII' + #13 + #10 +
        'PDOX_CSY' + #13 + #10 +
        'PDOX_CYRL' + #13 + #10 +
        'PDOX_HUN' + #13 + #10 +
        'PDOX_INTL' + #13 + #10 +
        'PDOX_ISL' + #13 + #10 +
        'PDOX_NORDAN4' + #13 + #10 +
        'PDOX_PLK' + #13 + #10 +
        'PDOX_SLO' + #13 + #10 +
        'PDOX_SWEDFIN' + #13 + #10 +
        'PT_BR' + #13 + #10 +
        'PT_PT' + #13 + #10 +
        'PXW_CSY' + #13 + #10 +
        'PXW_CYRL' + #13 + #10 +
        'PXW_GREEK' + #13 + #10 +
        'PXW_HUN' + #13 + #10 +
        'PXW_HUNDC' + #13 + #10 +
        'PXW_INTL' + #13 + #10 +
        'PXW_INTL850' + #13 + #10 +
        'PXW_NORDAN4' + #13 + #10 +
        'PXW_PLK' + #13 + #10 +
        'PXW_SLOV' + #13 + #10 +
        'PXW_SPAN' + #13 + #10 +
        'PXW_SWEDFIN' + #13 + #10 +
        'PXW_TURK' + #13 + #10 +
        'SJIS_0208' + #13 + #10 +
        'SV_SV' + #13 + #10 +
        'TIS620' + #13 + #10 +
        'TIS620_UNICODE' + #13 + #10 +
        'UCS_BASIC' + #13 + #10 +
        'UNICODE' + #13 + #10 +
        'UNICODE_CI' + #13 + #10 +
        'UNICODE_CI_AI' + #13 + #10 +
        'UNICODE_FSS' + #13 + #10 +
        'UTF8' + #13 + #10 +
        'WIN1250' + #13 + #10 +
        'WIN1251' + #13 + #10 +
        'WIN1251_UA' + #13 + #10 +
        'WIN1252' + #13 + #10 +
        'WIN1253' + #13 + #10 +
        'WIN1254' + #13 + #10 +
        'WIN1255' + #13 + #10 +
        'WIN1256' + #13 + #10 +
        'WIN1257' + #13 + #10 +
        'WIN1257_EE' + #13 + #10 +
        'WIN1257_LT' + #13 + #10 +
        'WIN1257_LV' + #13 + #10 +
        'WIN1258' + #13 + #10 +
        'WIN_CZ' + #13 + #10 +
        'WIN_CZ_CI_AI' + #13 + #10 +
        {$endregion 'Collations.'}
        'WIN_PTBR' + #13 + #10;

    end;

  Database__Collation_ComboBox.Items.Clear();

  Common.Items_From_Text_Add( Database__Collation_ComboBox.Items, zts );

  if Database__Collation_ComboBox.Items.Count > 0 then
    Database__Collation_ComboBox.ItemIndex := 0;


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__parameters__default_character_set_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__parameters__default_character_set_list__file_name_c + ').' );

      zts :=
        'WIN1250' + #13 + #10 +
        {$region 'Character sets.'}
        'ASCII' + #13 + #10 +
        'BIG_5' + #13 + #10 +
        'CP943C' + #13 + #10 +
        'CYRL' + #13 + #10 +
        'DOS437' + #13 + #10 +
        'DOS737' + #13 + #10 +
        'DOS775' + #13 + #10 +
        'DOS850' + #13 + #10 +
        'DOS852' + #13 + #10 +
        'DOS857' + #13 + #10 +
        'DOS858' + #13 + #10 +
        'DOS860' + #13 + #10 +
        'DOS861' + #13 + #10 +
        'DOS862' + #13 + #10 +
        'DOS863' + #13 + #10 +
        'DOS864' + #13 + #10 +
        'DOS865' + #13 + #10 +
        'DOS866' + #13 + #10 +
        'DOS869' + #13 + #10 +
        'EUCJ_0208' + #13 + #10 +
        'GB18030' + #13 + #10 +
        'GBK' + #13 + #10 +
        'GB_2312' + #13 + #10 +
        'ISO8859_1' + #13 + #10 +
        'ISO8859_13' + #13 + #10 +
        'ISO8859_2' + #13 + #10 +
        'ISO8859_3' + #13 + #10 +
        'ISO8859_4' + #13 + #10 +
        'ISO8859_5' + #13 + #10 +
        'ISO8859_6' + #13 + #10 +
        'ISO8859_7' + #13 + #10 +
        'ISO8859_8' + #13 + #10 +
        'ISO8859_9' + #13 + #10 +
        'KOI8R' + #13 + #10 +
        'KOI8U' + #13 + #10 +
        'KSC_5601' + #13 + #10 +
        'NEXT' + #13 + #10 +
        'NONE' + #13 + #10 +
        'OCTETS' + #13 + #10 +
        'SJIS_0208' + #13 + #10 +
        'TIS620' + #13 + #10 +
        'UNICODE_FSS' + #13 + #10 +
        'UTF8' + #13 + #10 +
        'WIN1250' + #13 + #10 +
        'WIN1251' + #13 + #10 +
        'WIN1252' + #13 + #10 +
        'WIN1253' + #13 + #10 +
        'WIN1254' + #13 + #10 +
        'WIN1255' + #13 + #10 +
        'WIN1256' + #13 + #10 +
        'WIN1257' + #13 + #10 +
        {$endregion 'Character sets.'}
        'WIN1258' + #13 + #10;

    end;

  Database__Default_Character_Set_ComboBox.Items.Clear();

  Common.Items_From_Text_Add( Database__Default_Character_Set_ComboBox.Items, zts );

  if Database__Default_Character_Set_ComboBox.Items.Count > 0 then
    Database__Default_Character_Set_ComboBox.ItemIndex := 0;


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__parameters__page_size_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__parameters__page_size_list__file_name_c + ').' );

      zts :=
        '8192' + #13 + #10 +
        '4096' + #13 + #10 +
        '8192' + #13 + #10 +
        '16384' + #13 + #10;

    end;

  Database__Page_Size_ComboBox.Items.Clear();

  Common.Items_From_Text_Add( Database__Page_Size_ComboBox.Items, zts );

  if Database__Page_Size_ComboBox.Items.Count > 0 then
    Database__Page_Size_ComboBox.ItemIndex := 0;


  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__parameters__sql_dialect_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__parameters__sql_dialect_list__file_name_c + ').' );

      zts :=
        '3' + #13 + #10 +
        '1' + #13 + #10 +
        '3' + #13 + #10;

    end;

  Database__Sql_Dialect_ComboBox.Items.Clear();

  Common.Items_From_Text_Add( Database__Sql_Dialect_ComboBox.Items, zts );

  if Database__Sql_Dialect_ComboBox.Items.Count > 0 then
    Database__Sql_Dialect_ComboBox.ItemIndex := 0;


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__hint__ib_database__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__hint__ib_database__file_name_c + ').' );

      hint__ib_database_g := '';

    end
  else
    begin

      hint__ib_database_g := Common.Text__File_Load( zts );

      if Trim( hint__ib_database_g ) <> '' then
        hint__ib_database_g := hint__ib_database_g + #13 + #10

    end;

  hint__ib_database_g := hint__ib_database_g +
    Translation.translation__messages_r.database_create__hint__ib_database;


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__hint__isql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__hint__isql__file_name_c + ').' );

      hint__isql_g := '';

    end
  else
    begin

      hint__isql_g := Common.Text__File_Load( zts );

      if Trim( hint__isql_g ) <> '' then
        hint__isql_g := hint__isql_g + #13 + #10

    end;

  hint__isql_g := hint__isql_g +
    Translation.translation__messages_r.database_create__hint__isql;


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Database_Type_ComboBox.Text + System.IOUtils.TPath.DirectorySeparatorChar + database__create__hint__sql__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + database__create__hint__sql__file_name_c + ').' );

      hint__sql_g := '';

    end
  else
    begin

      hint__sql_g := Common.Text__File_Load( zts );

      if Trim( hint__sql_g ) <> '' then
        hint__sql_g := hint__sql_g + #13 + #10

    end;

  hint__sql_g := hint__sql_g +
    Translation.translation__messages_r.database_create__hint__sql;


  Creation_Method_RadioGroupClick( Sender );

end;

procedure TDatabase__Create_Form.Database_Type_ComboBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_RETURN then
    Database_Type_ComboBoxChange( Sender );

end;

procedure TDatabase__Create_Form.Creation_Method_RadioGroupClick( Sender: TObject );
begin

  Execute_Button.Enabled := Creation_Method_RadioGroup.ItemIndex in [ 0, 1 ]; // IBDatabase component, isql.exe.
  Execute_Button_Works_As_Prepare_Execute_CheckBox.Enabled := Execute_Button.Enabled;


  if Creation_Method_RadioGroup.ItemIndex in [ 0 ] then // IBDatabase component.
    Help_Button.Hint := hint__ib_database_g
  else
  if Creation_Method_RadioGroup.ItemIndex in [ 1 ] then // isql.exe.
    Help_Button.Hint := hint__isql_g
  else
    Help_Button.Hint := hint__sql_g;


  if    ( Creation_Method_RadioGroup.ItemIndex in [ 0 ] ) // IBDatabase component.
    and ( ib_database_g = nil ) then
    ib_database_g := IBX.IBDatabase.TIBDatabase.Create( Application );

end;

procedure TDatabase__Create_Form.Help_ButtonClick( Sender: TObject );
begin

  Memos_PageControl.ActivePage := Log_TabSheet;

  Log_Memo.Lines.Add( '' );
  Log_Memo.Lines.Add( '' );
  Log_Memo.Lines.Add( Help_Button.Hint );

end;

procedure TDatabase__Create_Form.DosCommand1NewLine( ASender: TObject; const ANewLine: string; AOutputType: TOutputType );
begin

  if AOutputType = DosCommand.otEntireLine then
    begin

      Log_Memo.Lines.Add( ANewLine );

    end;

end;

procedure TDatabase__Create_Form.DosCommand1Terminated( Sender: TObject );
begin

  File_Path_EditExit( Database__File_Path_Edit );

  Log_Memo.Lines.Add( Translation.translation__messages_r.done );

end;

procedure TDatabase__Create_Form.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( ssCtrl in Shift )
    and (  not ( ssAlt in Shift )  ) then
    Log_Memo.SelectAll();

end;

procedure TDatabase__Create_Form.Command_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( ssCtrl in Shift )
    and (  not ( ssAlt in Shift )  ) then
    Command_Memo.SelectAll();

end;

end.
