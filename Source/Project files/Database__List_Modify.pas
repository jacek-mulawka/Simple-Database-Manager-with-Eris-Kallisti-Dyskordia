unit Database__List_Modify;{16.Cze.2023}

interface

uses
  Common,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TDatabase__List_Modify_Form = class( TForm )
    Ado__Connection_String_Etiquette_Label: TLabel;
    Ado__Connection_String_Edit: TEdit;
    Alias_Etiquette_Label: TLabel;
    Alias_Edit: TEdit;
    Database_Type_Etiquette_Label: TLabel;
    Database_Type_ComboBox: TComboBox;
    Fire_Dac__Driver_Id_Etiquette_Label: TLabel;
    Fire_Dac__Driver_Id_ComboBox: TComboBox;
    Fire_Dac__File_Path_Edit: TEdit;
    Password_Etiquette_Label: TLabel;
    Password_Edit: TEdit;
    Sql__Quotation_Sign_Etiquette_Label: TLabel;
    Sql__Quotation_Sign_Edit: TEdit;
    Sql__Parameter_Sign_Etiquette_Label: TLabel;
    Sql__Parameter_Sign_Edit: TEdit;
    User_Name_Etiquette_Label: TLabel;
    User_Name_Edit: TEdit;
    Ok_Button: TButton;
    Cancel_Button: TButton;
    Connection__Test__Type_RadioGroup: TRadioGroup;
    Connection__Test_Button: TButton;
    Component_Type_Etiquette_Label: TLabel;
    Component_Type_ComboBox: TComboBox;
    Login_Prompt_CheckBox: TCheckBox;
    Fire_Dac__Parameters_Memo: TMemo;
    Fire_Dac__Parameters_Etiquette_Label: TLabel;
    Fire_Dac__File_Path_GroupBox: TGroupBox;
    Fire_Dac__File_Path__Find_Button: TButton;
    OpenDialog1: TOpenDialog;
    Connection__Example_Button: TButton;
    procedure FormCreate( Sender: TObject );
    procedure FormShow( Sender: TObject );

    procedure Ok_ButtonClick( Sender: TObject );

    procedure Connection__Test_ButtonClick( Sender: TObject );
    procedure Connection__Example_ButtonClick( Sender: TObject );
    procedure Fire_Dac__File_Path__Find_ButtonClick( Sender: TObject );
    procedure File_Path_EditExit( Sender: TObject );

    procedure ComboBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Fire_Dac__Parameters_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
  private
    { Private declarations }
  public
    { Public declarations }
    login_prompt_input, // true = as username and password input.
    mode_add // false = edit, true = add;
      : boolean;

    databases_r__lm_g : Common.TDatabases_r;
  end;

const
  database__list_modify__fire_dac__driver_id__file_name_c : string = 'Database__List_Modify__Fire_Dac__Driver_Id.txt';

var
  Database__List_Modify_Form: TDatabase__List_Modify_Form;

implementation

uses
  System.TypInfo,

  Database__Modify,
  Shared,
  Translation;

{$R *.dfm}

procedure TDatabase__List_Modify_Form.FormCreate( Sender: TObject );
var
  zts : string;
  search_rec : TSearchRec;
  component_type_l : Common.TComponent_Type;
begin

  login_prompt_input := false;
  mode_add := false;

  Component_Type_ComboBox.Clear();
  Database_Type_ComboBox.Items.Clear();
  Fire_Dac__Driver_Id_ComboBox.Items.Clear();

  for component_type_l := Low( Common.TComponent_Type ) to High( Common.TComponent_Type ) do
    Component_Type_ComboBox.Items.Add(   StringReplace(  System.TypInfo.GetEnumName( System.TypeInfo(Common.TComponent_Type), integer(component_type_l) ), 'ct_', '', [ rfReplaceAll ]  )   );

  if Component_Type_ComboBox.Items.Count > 0 then
    Component_Type_ComboBox.ItemIndex := 0;


  if FindFirst(  Common.Databases_Type__Directory_Path__Get( '' ) + '*.*', faDirectory, search_rec  ) = 0 then
    begin

      repeat

        if    ( search_rec.Attr = faDirectory )
          and ( search_rec.Name <> '.' )
          and ( search_rec.Name <> '..' ) then
          Database_Type_ComboBox.Items.Add( search_rec.Name );

      until FindNext( search_rec ) <> 0;

    end;

  FindClose( search_rec );


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( '' ) + database__list_modify__fire_dac__driver_id__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Application.MessageBox( PChar(Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( '' ) + database__list_modify__fire_dac__driver_id__file_name_c + ').'), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );

      zts :=
        'ADS' + #13 + #10 +
        'FB' + #13 + #10 +
        'IB' + #13 + #10 +
        'MSAcc' + #13 + #10 +
        'MySQL' + #13 + #10 +
        'PG' + #13 + #10 +
        'SQLite' + #13 + #10;

    end;

  Common.Items_From_Text_Add( Fire_Dac__Driver_Id_ComboBox.Items, zts );


  OpenDialog1.Filter := Translation.translation__messages_r.firebird_database_files + '|*' + Common.database__file__default_extension + '|' + Translation.translation__messages_r.all_files + '|' + Common.all_files_find__filter;


  Translation.Translation__Apply( Self );

end;

procedure TDatabase__List_Modify_Form.FormShow( Sender: TObject );
var
  i : integer;
begin

  if mode_add then
    begin

      Ado__Connection_String_Edit.Text := 'Provider=MSDASQL.1;Persist Security Info=False;Data Source=database_odbc_name';
      Fire_Dac__Parameters_Memo.Lines.Add( 'CharacterSet=utf8' );
      Sql__Parameter_Sign_Edit.Text := ':';
      Sql__Quotation_Sign_Edit.Text := '"';

    end
  else
    begin

      Alias_Edit.Text := databases_r__lm_g.alias;
      Ado__Connection_String_Edit.Text := databases_r__lm_g.ado__connection_string;


      if    ( Component_Type_ComboBox.Items.Count > 0 )
        and ( integer(databases_r__lm_g.component_type) >= 0 )
        and ( integer(databases_r__lm_g.component_type) <= Component_Type_ComboBox.Items.Count - 1 ) then
        Component_Type_ComboBox.ItemIndex := integer(databases_r__lm_g.component_type);

      for i := 0 to Database_Type_ComboBox.Items.Count - 1 do
        if Database_Type_ComboBox.Items[ i ] = databases_r__lm_g.database_type then
          begin

            Database_Type_ComboBox.ItemIndex := i;
            Break;

          end;

      for i := 0 to Fire_Dac__Driver_Id_ComboBox.Items.Count - 1 do
        if Fire_Dac__Driver_Id_ComboBox.Items[ i ] = databases_r__lm_g.fire_dac__driver_id then
          begin

            Fire_Dac__Driver_Id_ComboBox.ItemIndex := i;
            Break;

          end;

      Fire_Dac__File_Path_Edit.Text := databases_r__lm_g.fire_dac__file_path;
      Fire_Dac__Parameters_Memo.Lines.Text := databases_r__lm_g.fire_dac__parameters;
      Login_Prompt_CheckBox.Checked := databases_r__lm_g.login_prompt;
      Password_Edit.Text := databases_r__lm_g.password;
      Sql__Parameter_Sign_Edit.Text := databases_r__lm_g.sql__parameter_sign;
      Sql__Quotation_Sign_Edit.Text := databases_r__lm_g.sql__quotation_sign;
      User_Name_Edit.Text := databases_r__lm_g.user_name;


      if Trim(  ExtractFilePath( Fire_Dac__File_Path_Edit.Text )  ) <> '' then
        OpenDialog1.InitialDir := ExtractFilePath( Fire_Dac__File_Path_Edit.Text );

    end;


  if Component_Type_ComboBox.ItemIndex = integer(Common.ct_FireDAC) then
    Connection__Test__Type_RadioGroup.ItemIndex := 1;


  File_Path_EditExit( Fire_Dac__File_Path_Edit );


  if login_prompt_input then
    begin

      for i := 0 to Self.ControlCount - 1 do
        if    ( Self.Controls[ i ].Name <> Password_Etiquette_Label.Name )
          and ( Self.Controls[ i ].Name <> Password_Edit.Name )
          and ( Self.Controls[ i ].Name <> User_Name_Etiquette_Label.Name )
          and ( Self.Controls[ i ].Name <> User_Name_Edit.Name )
          and ( Self.Controls[ i ].Name <> Ok_Button.Name )
          and ( Self.Controls[ i ].Name <> Cancel_Button.Name ) then
          begin

            Self.Controls[ i ].Visible := false;
            Self.Controls[ i ].Align := alBottom;

          end;

      Self.Height := 200;

    end;


  Common.Font__Set( Fire_Dac__Parameters_Memo.Font, Common.sql_editor__font );

end;

procedure TDatabase__List_Modify_Form.Ok_ButtonClick( Sender: TObject );
begin

  if not login_prompt_input then
    begin

      if Trim( Alias_Edit.Text ) = '' then
        begin

          Alias_Edit.SetFocus();
          Application.MessageBox( PChar(Translation.translation__messages_r.alias_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
          Exit;

        end;

      if Trim( Database_Type_ComboBox.Text ) = '' then
        begin

          Database_Type_ComboBox.SetFocus();

          if Application.MessageBox( PChar(Translation.translation__messages_r.database_type_should_not_be_empty + #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES then
            Exit;

        end;

    end;


  databases_r__lm_g.alias := Alias_Edit.Text;
  databases_r__lm_g.ado__connection_string := Ado__Connection_String_Edit.Text;
  databases_r__lm_g.component_type := Common.TComponent_Type(Component_Type_ComboBox.ItemIndex);
  databases_r__lm_g.database_type := Database_Type_ComboBox.Text;
  databases_r__lm_g.fire_dac__driver_id := Fire_Dac__Driver_Id_ComboBox.Text;
  databases_r__lm_g.fire_dac__file_path := Fire_Dac__File_Path_Edit.Text;
  databases_r__lm_g.fire_dac__parameters := Fire_Dac__Parameters_Memo.Lines.Text;
  databases_r__lm_g.login_prompt := Login_Prompt_CheckBox.Checked;
  databases_r__lm_g.password := Password_Edit.Text;
  databases_r__lm_g.sql__parameter_sign := Sql__Parameter_Sign_Edit.Text;
  databases_r__lm_g.sql__quotation_sign := Sql__Quotation_Sign_Edit.Text;
  databases_r__lm_g.user_name := User_Name_Edit.Text;


  ModalResult := mrOk;

end;

procedure TDatabase__List_Modify_Form.Connection__Test_ButtonClick( Sender: TObject );
var
  component_type_l : Common.TComponent_Type;
  database__modify_form_l : Database__Modify.TDatabase__Modify_Form;
begin

  {$region 'Checking the values.'}
  if Connection__Test__Type_RadioGroup.ItemIndex <> 0 then // ADO.
    begin

      if    ( Fire_Dac__Driver_Id_ComboBox.ItemIndex <= 0 )
        and (  Application.MessageBox( PChar(Translation.translation__messages_r.firedac_driver_id_should_not_be_empty + #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES  ) then
        begin

          Fire_Dac__Driver_Id_ComboBox.SetFocus();

          Exit;

        end;

      if    (  Trim( User_Name_Edit.Text ) = '' )
        and (  Application.MessageBox( PChar(Translation.translation__messages_r.user_name_should_not_be_empty + #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES  ) then
        begin

          User_Name_Edit.SetFocus();

          Exit;

        end;

      if    (  Trim( Password_Edit.Text ) = '' )
        and (  Application.MessageBox( PChar(Translation.translation__messages_r.user_password_should_not_be_empty + #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES  ) then
        begin

          Password_Edit.SetFocus();

          Exit;

        end;

    end;
  {$endregion 'Checking the values.'}


  database__modify_form_l := Database__Modify.TDatabase__Modify_Form.Create( Application );
  database__modify_form_l.databases_r__dm_g.ado__connection_string := Ado__Connection_String_Edit.Text;
  database__modify_form_l.databases_r__dm_g.component_type := Common.TComponent_Type(Component_Type_ComboBox.ItemIndex);
  database__modify_form_l.databases_r__dm_g.fire_dac__driver_id := Fire_Dac__Driver_Id_ComboBox.Text;
  database__modify_form_l.databases_r__dm_g.fire_dac__file_path := Fire_Dac__File_Path_Edit.Text;
  database__modify_form_l.databases_r__dm_g.fire_dac__parameters := Fire_Dac__Parameters_Memo.Lines.Text;
  database__modify_form_l.databases_r__dm_g.login_prompt := Login_Prompt_CheckBox.Checked;
  database__modify_form_l.databases_r__dm_g.password := Password_Edit.Text;
  database__modify_form_l.databases_r__dm_g.sql__parameter_sign := Sql__Parameter_Sign_Edit.Text;
  database__modify_form_l.databases_r__dm_g.sql__quotation_sign := Sql__Quotation_Sign_Edit.Text;
  database__modify_form_l.databases_r__dm_g.user_name := User_Name_Edit.Text;


  case Connection__Test__Type_RadioGroup.ItemIndex of
      0 : component_type_l := Common.ct_ADO // ADO.
      else
        component_type_l := Common.ct_FireDAC
    end;


  if database__modify_form_l.Connection_Test__DM( component_type_l ) then
    Application.MessageBox( PChar(Translation.translation__messages_r.connection_successful), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

  database__modify_form_l.Close();
  FreeAndNil( database__modify_form_l );

end;

procedure TDatabase__List_Modify_Form.Connection__Example_ButtonClick( Sender: TObject );
var
  i : integer;
  zts : string;
begin

  if Trim( Alias_Edit.Text ) = '' then
    Alias_Edit.Text := Translation.translation__messages_r.firebird_example_employee_fdb__fdac_;

  if    ( Database_Type_ComboBox.Items.Count > 0 )
    and ( Database_Type_ComboBox.ItemIndex < 0 ) then
    Database_Type_ComboBox.ItemIndex := 0;

  if Ado__Connection_String_Edit.Text <> '' then
    Ado__Connection_String_Edit.Text := '';

  for i := 0 to Fire_Dac__Driver_Id_ComboBox.Items.Count - 1 do
    if Fire_Dac__Driver_Id_ComboBox.Items[ i ] = 'FB' then
      begin

        Fire_Dac__Driver_Id_ComboBox.ItemIndex := i;

        Break;

      end;

  Fire_Dac__File_Path_Edit.Text := 'C:\Program Files\Firebird\examples\empbuild\EMPLOYEE.FDB';

  if Login_Prompt_CheckBox.Checked then
    Login_Prompt_CheckBox.Checked := false;

  User_Name_Edit.Text := 'SYSDBA';

  Password_Edit.Text := 'masterkey';

  Component_Type_ComboBox.ItemIndex := integer(Common.ct_FireDAC);

  Fire_Dac__Parameters_Memo.Lines.Clear();
  Fire_Dac__Parameters_Memo.Lines.Add( 'CharacterSet=utf8' );

  Connection__Test__Type_RadioGroup.ItemIndex := 1; // FireDAC.


  File_Path_EditExit( Fire_Dac__File_Path_Edit );


  if not FileExists( Fire_Dac__File_Path_Edit.Text ) then
    begin

      Application.MessageBox( PChar(Translation.translation__messages_r.point_the_database_file___e_g___c___program_files_firebird_examples_empbuild_employee_fdb), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

      zts := ExtractFilePath( Fire_Dac__File_Path_Edit.Text );

      if DirectoryExists( zts ) then
        OpenDialog1.InitialDir := zts;

      Fire_Dac__File_Path__Find_ButtonClick( Sender );

    end;

end;

procedure TDatabase__List_Modify_Form.Fire_Dac__File_Path__Find_ButtonClick( Sender: TObject );
begin

  if OpenDialog1.Execute() then
    begin

      Fire_Dac__File_Path_Edit.Text := OpenDialog1.FileName;

      File_Path_EditExit( Fire_Dac__File_Path_Edit );

    end;

end;

procedure TDatabase__List_Modify_Form.File_Path_EditExit( Sender: TObject );
begin

  if    ( Sender <> nil )
    and ( Sender is TEdit )then
    if    (  Trim( TEdit(Sender).Text ) <> ''  )
      and (  not FileExists( TEdit(Sender).Text )  ) then
      TEdit(Sender).Color := Common.color__red__light_c
    else
      TEdit(Sender).Color := clWindow;

end;

procedure TDatabase__List_Modify_Form.ComboBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Sender <> nil )
    and ( Sender is TComboBox )
    and ( Key = VK_DELETE ) then
    TComboBox(Sender).ItemIndex := -1;

end;

procedure TDatabase__List_Modify_Form.Fire_Dac__Parameters_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Fire_Dac__Parameters_Memo.SelectAll();

end;

end.
