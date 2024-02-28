unit Exceptions_Modify_F;{18.Wrz.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Translation,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Menus;

type
  TExceptions_Modify_F_Frame = class( TFrame )
    Buttons_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    Exception_Name_DBEdit: TDBEdit;
    Exception_Name_Etiquette_Label: TLabel;
    Exceptions_DataSource: TDataSource;
    Exceptions_DBGrid: TDBGrid;
    Log_Memo: TMemo;
    Modify_GroupBox: TGroupBox;
    Modify__Add_Button: TButton;
    Modify__Delete_Button: TButton;
    Modify__Edit_Button: TButton;
    Modify__Name_Edit: TEdit;
    Modify__Name_Etiquette_Label: TLabel;
    Modify__Message_Etiquette_Label: TLabel;
    Record_Number__Records_Count_Label: TLabel;
    Refresh_Button: TButton;
    Search_Edit: TEdit;
    Search_GroupBox: TGroupBox;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Next_Button: TButton;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Prior_Button: TButton;
    Vertical_Splitter: TSplitter;
    Exceptions_PopupMenu: TPopupMenu;
    Exception__Delete_MenuItem: TMenuItem;
    N1: TMenuItem;
    Exception__Description__Set_MenuItem: TMenuItem;
    Exception__Description__Drop_MenuItem: TMenuItem;
    N2: TMenuItem;
    Exception__Description__Write_In_Log_MenuItem: TMenuItem;
    Modify__Message_Memo: TMemo;
    Log_Horizontal_Splitter: TSplitter;
    Exception__Message__Write_In_Log_MenuItem: TMenuItem;
    Modify__Message_Memo__Update_CheckBox: TCheckBox;

    procedure Exception_Name_DBEditChange( Sender: TObject );
    procedure Search_Change( Sender: TObject );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );

    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Modify__Add_ButtonClick( Sender: TObject );
    procedure Modify__Edit_ButtonClick( Sender: TObject );
    procedure Modify__Delete_ButtonClick( Sender: TObject );

    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );

    procedure Exception__Description__Set_MenuItemClick( Sender: TObject );
    procedure Exception__Description__Drop_MenuItemClick( Sender: TObject );
    procedure Exception__Description__Write_In_Log_MenuItemClick( Sender: TObject );
    procedure Exception__Message__Write_In_Log_MenuItemClick( Sender: TObject );

    procedure Modify__Message_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Exceptions_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
    procedure Exceptions_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Exceptions_DBGridTitleClick( Column: TColumn );
  private
    { Private declarations }
    sort__direction_ascending_g,
    sql__quotation_sign__use__emf_g
      : boolean;

    database_type__emf_g,
    sort__column_name_g,
    sql__quotation_sign__emf_g
      : string;

    exceptions_sdbm : Common.TSDBM;

    function Quotation_Sign__EMF() : string;
  public
    { Public declarations }
    function Data_Active__EMF() : boolean;
    procedure Data_Open__EMF();
    procedure Finish__EMF();
    procedure Highlight__Font__Set__EMF();
    procedure Options_Set__EMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
    procedure Prepare__EMF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
    procedure Translation__Apply__EMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
  end;

const
  exceptions_list__file_name_c : string = 'Exceptions_List__sql.txt';
  exceptions_list__column__exception_message_c : string = 'EXCEPTION_MESSAGE_VALUE';
  exceptions_list__column__exception_message__cast_c : string = 'EXCEPTION_MESSAGE_VALUE__CAST';
  exceptions_list__column__exception_name__big_letter_c : string = 'EXCEPTION_NAME';
  exceptions_list__sql__description__drop__file_name_c : string = 'Exception__Description__Drop__sql.txt';
  exceptions_list__sql__description__set__file_name_c : string = 'Exception__Description__Set__sql.txt';
  exceptions_list__sql__exception__alter__file_name_c : string = 'Exception__Alter__sql.txt';
  exceptions_list__sql__exception__create__file_name_c : string = 'Exception__Create__sql.txt';
  exceptions_list__sql__exception__drop__file_name_c : string = 'Exception__Drop__sql.txt';

implementation

uses
  Vcl.Clipbrd,

  Shared,
  Text__Edit_Memo;

{$R *.dfm}

function TExceptions_Modify_F_Frame.Data_Active__EMF() : boolean;
begin

  Result :=
        ( exceptions_sdbm <> nil )
    and ( exceptions_sdbm.Query__Active() );

end;

procedure TExceptions_Modify_F_Frame.Data_Open__EMF();
var
  i : integer;

  zts : string;
begin

  if   ( exceptions_sdbm = nil )
    or ( exceptions_sdbm.component_type__sdbm = Common.ct_none ) then
    Exit;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__emf_g ) + exceptions_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__emf_g ) + exceptions_list__file_name_c + ').' );

      zts :=
        'select RDB$EXCEPTIONS.RDB$EXCEPTION_NAME as EXCEPTION_NAME ' +
        //'     , cast(  substring( RDB$EXCEPTIONS.RDB$MESSAGE from 1 for 10000 ) as varchar( 10000 )  ) as EXCEPTION_MESSAGE_VALUE__CAST ' +
        '     , cast(  substring( RDB$EXCEPTIONS.RDB$MESSAGE from 1 for 8191 ) as varchar( 8191 )  ) as EXCEPTION_MESSAGE_VALUE__CAST ' + // FireDAC limit default - FDConnection1.FormatOptions.MaxStringSize = 32767 bytes ( / 4 = 8191,75 ).
        //'     , cast(  substring( RDB$EXCEPTIONS.RDB$DESCRIPTION from 1 for 10000 ) as varchar( 10000 )  ) as DESCRIPTION_VALUE__CAST ' +
        '     , cast(  substring( RDB$EXCEPTIONS.RDB$DESCRIPTION from 1 for 8191 ) as varchar( 8191 )  ) as DESCRIPTION_VALUE__CAST ' + // FireDAC limit default - FDConnection1.FormatOptions.MaxStringSize = 32767 bytes ( / 4 = 8191,75 ).
        '     , RDB$EXCEPTIONS.RDB$OWNER_NAME as OWNER_NAME ' +
        '     , RDB$EXCEPTIONS.RDB$EXCEPTION_NUMBER ' +
        '     , RDB$EXCEPTIONS.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
        '     , RDB$EXCEPTIONS.RDB$MESSAGE as EXCEPTION_MESSAGE_VALUE ' +
        '     , RDB$EXCEPTIONS.RDB$SYSTEM_FLAG ' +
        '     , RDB$EXCEPTIONS.RDB$SECURITY_CLASS ' +
        'from RDB$EXCEPTIONS ';

    end;


  Screen.Cursor := crHourGlass;


  if exceptions_sdbm.Query__Active() then
    exceptions_sdbm.Query__Close();

  exceptions_sdbm.Query__Sql__Set( zts );


  Log_Memo.Lines.Add( zts );


  try
    exceptions_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_exceptions_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;


  Screen.Cursor := crDefault;


  if exceptions_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( exceptions_sdbm.Operation_Duration_Get() );


      try
        Exception_Name_DBEdit.DataField := exceptions_list__column__exception_name__big_letter_c;
        exceptions_sdbm.Query__Field_By_Name( exceptions_list__column__exception_name__big_letter_c ).AsString;
        exceptions_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );
      except
        on E : Exception do
          begin

            exceptions_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_exception_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;

      if exceptions_sdbm.Query__Active() then
        try
          exceptions_sdbm.Query__Field_By_Name( exceptions_list__column__exception_message_c ).AsString;
        except
          on E : Exception do
            begin

              exceptions_sdbm.Query__Close();

              Log_Memo.Lines.Add( E.Message );

              Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_exception_message + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            end;
        end;


      for i := 0 to Exceptions_DBGrid.Columns.Count - 1 do
        if Exceptions_DBGrid.Columns.Items[ i ].FieldName = exceptions_list__column__exception_message__cast_c then
          begin

            if Exceptions_DBGrid.Columns.Items[ i ].Width > 500 then
              Exceptions_DBGrid.Columns.Items[ i ].Width := 500;

          end
        else
        if Exceptions_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value__cast_c then
          begin

            if Exceptions_DBGrid.Columns.Items[ i ].Width > 500 then
              Exceptions_DBGrid.Columns.Items[ i ].Width := 500;

          end
        else
          begin

            if Exceptions_DBGrid.Columns.Items[ i ].Width > 200 then
              Exceptions_DBGrid.Columns.Items[ i ].Width := 200;

          end;


      Self.Translation__Apply__EMF( Translation.tak_Grid );


      Common.Data_Value_Format__Set( exceptions_sdbm, Log_Memo );

    end;

end;

procedure TExceptions_Modify_F_Frame.Finish__EMF();
begin

  FreeAndNil( exceptions_sdbm );

end;

procedure TExceptions_Modify_F_Frame.Highlight__Font__Set__EMF();
begin

  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Modify__Message_Memo.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    Common.Font__Set( Exceptions_DBGrid.Font, Common.sql_editor__font );

end;

function TExceptions_Modify_F_Frame.Quotation_Sign__EMF() : string;
begin

  if sql__quotation_sign__use__emf_g then
    begin

      Result := sql__quotation_sign__emf_g;

    end
  else
    Result := '';

end;

procedure TExceptions_Modify_F_Frame.Options_Set__EMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
begin

  sql__quotation_sign__use__emf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__emf_g := sql__quotation_sign_f;


  if exceptions_sdbm <> nil then
    begin

      exceptions_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

      exceptions_sdbm.Data_Source__Data_Set__Set( Exceptions_DataSource );

    end;


  Self.Translation__Apply__EMF( Translation.tak_Self );

end;

procedure TExceptions_Modify_F_Frame.Prepare__EMF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
begin

  Self.Name := '';

  database_type__emf_g := databases_r_f.database_type;
  sort__column_name_g := exceptions_list__column__exception_name__big_letter_c;
  sort__direction_ascending_g := true;


  exceptions_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Self.Options_Set__EMF( component_type_f, databases_r_f.sql__quotation_sign, sql__quotation_sign__use_f );


  Highlight__Font__Set__EMF();

end;

procedure TExceptions_Modify_F_Frame.Translation__Apply__EMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
var
  i : integer;
begin

  if tak_f in [ Translation.tak_All, Translation.tak_Self ] then
    Translation.Translation__Apply( Self );


  if tak_f in [ Translation.tak_All, Translation.tak_Grid ] then
    for i := 0 to Exceptions_DBGrid.Columns.Count - 1 do
      if Exceptions_DBGrid.Columns.Items[ i ].FieldName = exceptions_list__column__exception_name__big_letter_c then
        Exceptions_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__name
      else
      if Exceptions_DBGrid.Columns.Items[ i ].FieldName = exceptions_list__column__exception_message__cast_c then
        Exceptions_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__message__with_a_capital_letter
      else
      if Exceptions_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value__cast_c then
        Exceptions_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__description
      else
        Exceptions_DBGrid.Columns.Items[ i ].Title.Caption := Common.Column__Name_To_Grid_Caption( Exceptions_DBGrid.Columns.Items[ i ].FieldName );

end;

procedure TExceptions_Modify_F_Frame.Exception_Name_DBEditChange( Sender: TObject );
begin

  if    ( exceptions_sdbm <> nil )
    and ( exceptions_sdbm.Query__Active() ) then
    begin

      Record_Number__Records_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', exceptions_sdbm.Query__Record_Number() )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', exceptions_sdbm.Query__Record_Count() )  );

      if Modify__Message_Memo__Update_CheckBox.Checked then
        try
          Modify__Message_Memo.Lines.Text := exceptions_sdbm.Query__Field_By_Name( exceptions_list__column__exception_message_c ).AsString;
        except
        end;

    end
  else
    Record_Number__Records_Count_Label.Caption := '0 / 0';

end;

procedure TExceptions_Modify_F_Frame.Search_Change( Sender: TObject );
var
  locate_options : Data.DB.TLocateOptions;
begin

  if   ( exceptions_sdbm = nil )
    or ( not exceptions_sdbm.Query__Active() ) then
    Exit;


  locate_options := [];

  if Search__Case_Insensitive_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loCaseInsensitive ];

  if Search__Partial_Key_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loPartialKey ];


  if exceptions_sdbm.Query__Locate( sort__column_name_g, Search_Edit.Text, locate_options ) then
    Search_Edit.Color := clWindow
  else
    begin

      Search_Edit.Color := Common.color__red__light_c;


      exceptions_sdbm.Query__Disable_Controls();

      exceptions_sdbm.Query__First();

      while not exceptions_sdbm.Query__Eof do
        begin

          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  exceptions_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

          exceptions_sdbm.Query__Next();

        end;

      exceptions_sdbm.Query__Enable_Controls();

    end;

end;

procedure TExceptions_Modify_F_Frame.Search__Next_ButtonClick( Sender: TObject );
begin

  if   ( exceptions_sdbm = nil )
    or ( not exceptions_sdbm.Query__Active() ) then
    Exit;


  exceptions_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not exceptions_sdbm.Query__Eof do
    begin

      exceptions_sdbm.Query__Next();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  exceptions_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  exceptions_sdbm.Query__Enable_Controls();

end;

procedure TExceptions_Modify_F_Frame.Search__Prior_ButtonClick( Sender: TObject );
begin

  if   ( exceptions_sdbm = nil )
    or ( not exceptions_sdbm.Query__Active() ) then
    Exit;


  exceptions_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not exceptions_sdbm.Query__Bof do
    begin

      exceptions_sdbm.Query__Prior();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  exceptions_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  exceptions_sdbm.Query__Enable_Controls();

end;

procedure TExceptions_Modify_F_Frame.Refresh_ButtonClick( Sender: TObject );
var
  primary_key_value_l : string;
begin

  if   ( exceptions_sdbm = nil )
    or ( not exceptions_sdbm.Query__Active() ) then
    Exit;


  primary_key_value_l := exceptions_sdbm.Query__Field_By_Name( exceptions_list__column__exception_name__big_letter_c ).AsString;

  exceptions_sdbm.Query__Requery();


  if    ( Sender <> nil )
    and ( Sender = Refresh_Button ) then
    begin

      Log_Memo.Lines.Add( exceptions_sdbm.Operation_Duration_Get() );

    end;


  exceptions_sdbm.Query__Locate( exceptions_list__column__exception_name__big_letter_c, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );

end;

procedure TExceptions_Modify_F_Frame.Modify__Add_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( exceptions_sdbm = nil )
    or ( not exceptions_sdbm.Query__Active() ) then
    Exit;


  if Trim( Modify__Name_Edit.Text ) = '' then
    begin

      Modify__Name_Edit.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.exception_name_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;

  if Trim( Modify__Message_Memo.Lines.Text ) = '' then
    begin

      Modify__Message_Memo.SetFocus();

      if Application.MessageBox( PChar(Translation.translation__messages_r.exception_message_should_not_be_empty + #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES then
        Exit;

    end;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__emf_g ) + exceptions_list__sql__exception__create__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__emf_g ) + exceptions_list__sql__exception__create__file_name_c + ').' );

      zts :=
        'create exception ' +
        Self.Quotation_Sign__EMF() + Modify__Name_Edit.Text + Self.Quotation_Sign__EMF() +
        ' ''' + Common.Sql_Special_Characters_Protect( Modify__Message_Memo.Lines.Text ) + ''' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + exceptions_list__column__exception_name__big_letter_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__EMF() + Modify__Name_Edit.Text + Self.Quotation_Sign__EMF(), [ rfReplaceAll ] );
      zts := StringReplace(  zts, Common.sql__word_replace_separator_c + exceptions_list__column__exception_message_c + Common.sql__word_replace_separator_c, Common.Sql_Special_Characters_Protect( Modify__Message_Memo.Lines.Text ), [ rfReplaceAll ]  );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.add_exception + ' ''' + Self.Quotation_Sign__EMF() + Modify__Name_Edit.Text + Self.Quotation_Sign__EMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := exceptions_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_add_exception );


  if ztb then
    begin

      Log_Memo.Lines.Add( exceptions_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      exceptions_sdbm.Query__Locate( exceptions_list__column__exception_name__big_letter_c, Modify__Name_Edit.Text, [ Data.DB.loCaseInsensitive ] );


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TExceptions_Modify_F_Frame.Modify__Edit_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( exceptions_sdbm = nil )
    or ( not exceptions_sdbm.Query__Active() )
    or ( exceptions_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  if Trim( Modify__Message_Memo.Lines.Text ) = '' then
    begin

      Modify__Message_Memo.SetFocus();

      if Application.MessageBox( PChar(Translation.translation__messages_r.exception_message_should_not_be_empty + #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES then
        Exit;

    end;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__emf_g ) + exceptions_list__sql__exception__alter__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__emf_g ) + exceptions_list__sql__exception__alter__file_name_c + ').' );

      zts :=
        'alter exception ' +
        Self.Quotation_Sign__EMF() + exceptions_sdbm.Query__Field_By_Name( exceptions_list__column__exception_name__big_letter_c ).AsString + Self.Quotation_Sign__EMF() +
        ' ''' + Common.Sql_Special_Characters_Protect( Modify__Message_Memo.Lines.Text ) + ''' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + exceptions_list__column__exception_name__big_letter_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__EMF() + exceptions_sdbm.Query__Field_By_Name( exceptions_list__column__exception_name__big_letter_c ).AsString + Self.Quotation_Sign__EMF(), [ rfReplaceAll ] );
      zts := StringReplace(  zts, Common.sql__word_replace_separator_c + exceptions_list__column__exception_message_c + Common.sql__word_replace_separator_c, Common.Sql_Special_Characters_Protect( Modify__Message_Memo.Lines.Text ), [ rfReplaceAll ]  );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.set_exception + ' ''' + Self.Quotation_Sign__EMF() + exceptions_sdbm.Query__Field_By_Name( exceptions_list__column__exception_name__big_letter_c ).AsString + Self.Quotation_Sign__EMF() + ''' ' + Translation.translation__messages_r.word__message + '?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := exceptions_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_exception );


  if ztb then
    begin

      Log_Memo.Lines.Add( exceptions_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TExceptions_Modify_F_Frame.Modify__Delete_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( exceptions_sdbm = nil )
    or ( not exceptions_sdbm.Query__Active() )
    or ( exceptions_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__emf_g ) + exceptions_list__sql__exception__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__emf_g ) + exceptions_list__sql__exception__drop__file_name_c + ').' );

      zts :=
        'drop exception ' +
        Self.Quotation_Sign__EMF() + exceptions_sdbm.Query__Field_By_Name( exceptions_list__column__exception_name__big_letter_c ).AsString + Self.Quotation_Sign__EMF() +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + exceptions_list__column__exception_name__big_letter_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__EMF() + exceptions_sdbm.Query__Field_By_Name( exceptions_list__column__exception_name__big_letter_c ).AsString + Self.Quotation_Sign__EMF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_exception + ' ''' + Self.Quotation_Sign__EMF() + exceptions_sdbm.Query__Field_By_Name( exceptions_list__column__exception_name__big_letter_c ).AsString + Self.Quotation_Sign__EMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := exceptions_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_exception );


  if ztb then
    begin

      Log_Memo.Lines.Add( exceptions_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TExceptions_Modify_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Buttons_Panel.Width := 1;

end;

procedure TExceptions_Modify_F_Frame.Exception__Description__Set_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  modal_result : TModalResult;

  zts,
  description_value_l,
  error_message_l,
  exception_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( exceptions_sdbm = nil )
    or ( not exceptions_sdbm.Query__Active() )
    or ( exceptions_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Text__Edit_Memo.Text__Edit_Memo_Form := Text__Edit_Memo.TText__Edit_Memo_Form.Create( Application );
  Text__Edit_Memo.Text__Edit_Memo_Form.text_value := exceptions_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
  Text__Edit_Memo.Text__Edit_Memo_Form.quotation_mark_duplicate := true;
  Text__Edit_Memo.Text__Edit_Memo_Form.Caption := Translation.translation__messages_r.word__description___exception;
  Text__Edit_Memo.Text__Edit_Memo_Form.Text_Type_Set( Text__Edit_Memo.tt_Memo );
  modal_result := Text__Edit_Memo.Text__Edit_Memo_Form.ShowModal();

  if modal_result = mrOk then
    description_value_l := Text__Edit_Memo.Text__Edit_Memo_Form.text_value;

  FreeAndNil( Text__Edit_Memo.Text__Edit_Memo_Form );


  exception_name_l := Self.Quotation_Sign__EMF() + Trim(  exceptions_sdbm.Query__Field_By_Name( exceptions_list__column__exception_name__big_letter_c ).AsString  ) + Self.Quotation_Sign__EMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__emf_g ) + exceptions_list__sql__description__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__emf_g ) + exceptions_list__sql__description__set__file_name_c + ').' );

      zts :=
        'comment on exception ' +
        exception_name_l +
        ' is ''' + description_value_l + ''' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + exceptions_list__column__exception_name__big_letter_c + Common.sql__word_replace_separator_c, exception_name_l, [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if modal_result <> mrOk then
    Exit;


  ztb := exceptions_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_exception_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( exceptions_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TExceptions_Modify_F_Frame.Exception__Description__Drop_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l,
  exception_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( exceptions_sdbm = nil )
    or ( not exceptions_sdbm.Query__Active() )
    or ( exceptions_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  exception_name_l := Self.Quotation_Sign__EMF() + Trim(  exceptions_sdbm.Query__Field_By_Name( exceptions_list__column__exception_name__big_letter_c ).AsString  ) + Self.Quotation_Sign__EMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__emf_g ) + exceptions_list__sql__description__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__emf_g ) + exceptions_list__sql__description__drop__file_name_c + ').' );

      zts :=
        'comment on exception ' +
        exception_name_l +
        ' is null ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + exceptions_list__column__exception_name__big_letter_c + Common.sql__word_replace_separator_c, exception_name_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_exception_description + ' ''' + exception_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := exceptions_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_exception_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( exceptions_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TExceptions_Modify_F_Frame.Exception__Description__Write_In_Log_MenuItemClick( Sender: TObject );
begin

  if   ( exceptions_sdbm = nil )
    or ( not exceptions_sdbm.Query__Active() )
    or ( exceptions_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Log_Memo.Lines.Add( '' );
  Log_Memo.Lines.Add(  exceptions_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString  );

end;

procedure TExceptions_Modify_F_Frame.Exception__Message__Write_In_Log_MenuItemClick( Sender: TObject );
begin

  if   ( exceptions_sdbm = nil )
    or ( not exceptions_sdbm.Query__Active() )
    or ( exceptions_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Log_Memo.Lines.Add( '' );
  Log_Memo.Lines.Add(  exceptions_sdbm.Query__Field_By_Name( exceptions_list__column__exception_message_c ).AsString  );

end;

procedure TExceptions_Modify_F_Frame.Modify__Message_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Modify__Message_Memo.SelectAll();

end;

procedure TExceptions_Modify_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TExceptions_Modify_F_Frame.Exceptions_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
begin

  Common.DB_Grid_Draw_Column_Cell( sort__column_name_g, Exceptions_DBGrid, Rect, DataCol, Column, State );

end;

procedure TExceptions_Modify_F_Frame.Exceptions_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
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
    and ( exceptions_sdbm.Query__Active() )
    and ( exceptions_sdbm.Query__Record_Count > 0 )
    and ( Exceptions_DBGrid.SelectedField <> nil ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Exceptions_DBGrid.SelectedField.Value;
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

procedure TExceptions_Modify_F_Frame.Exceptions_DBGridTitleClick( Column: TColumn );
begin

  if Column.Field = nil then
    Exit;


  if sort__column_name_g = Column.Field.FieldName then
    sort__direction_ascending_g := not sort__direction_ascending_g
  else
    sort__column_name_g := Column.Field.FieldName;

  exceptions_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );


  Exception_Name_DBEditChange( nil ); // For FireDAC.

end;

end.
