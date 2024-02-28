unit Table_Column__Modify;{08.Sie.2023}

interface

uses
  Common,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Samples.Spin,

  Interceptor__Spin_Edit;

type
  TTable_Column__Modify_Form = class( TForm )
    Execute_Button: TButton;
    Close_Button: TButton;
    Sql_Memo: TMemo;
    Sql_Prepare_Button: TButton;
    Column_Name_Edit: TEdit;
    Column_Name_Etiquette_Label: TLabel;
    Column_Type_Etiquette_Label: TLabel;
    Column_Type_ComboBox: TComboBox;
    Default_Value_GroupBox: TGroupBox;
    Default_Value_Edit: TEdit;
    Default_Value_CheckBox: TCheckBox;
    Not_Null_CheckBox: TCheckBox;
    Collate_Etiquette_Label: TLabel;
    Collate_ComboBox: TComboBox;
    Column_Position_GroupBox: TGroupBox;
    Column_Position_CheckBox: TCheckBox;
    PageControl1: TPageControl;
    Log_TabSheet: TTabSheet;
    Sql_TabSheet: TTabSheet;
    Log_Memo: TMemo;
    Execute_Button_Works_As_Prepare_Execute_CheckBox: TCheckBox;
    Ok_Button: TButton;
    Column_Position_SpinEdit: TSpinEdit;
    procedure FormCreate( Sender: TObject );
    procedure FormShow( Sender: TObject );
    procedure FormDestroy( Sender: TObject );

    procedure Sql_Prepare_ButtonClick( Sender: TObject );
    procedure Execute_ButtonClick( Sender: TObject );

    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Sql_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
  private
    { Private declarations }
    sql_prepared_correctly_g : boolean;

    sql__add_g,
    sql__position_set_g,
    sql__type_set_g,

    word__collate__tcm_g,
    word__command_end_char__tcm_g,
    word__default__tcm_g,
    word__not_null__tcm_g
      : string;

    table_column__modify_sdbm : Common.TSDBM;

    function Quotation_Sign__TCM() : string;
  public
    { Public declarations }
    from_table_add_tcm,
    modified__tcm,
    sql__quotation_sign__use__tcm,
    type_edit__tcm // Only column type edit.
      : boolean;

    column__position__tcm,
    column__position__out__tcm
      : integer;

    column__collate__tcm,
    column__name__tcm,
    column__type__tcm,
    database_type__tcm,
    sql__quotation_sign__tcm,
    table_name__tcm
      : string;

    constructor Create( AOwner : TComponent; sdbm_f : Common.TSDBM ); overload;
  end;

const
  table_column__modify__column_name__collation_name_c : string = 'COLLATION_NAME';
  table_column__modify__column__types_list__file_name_c : string = 'Table_Column__Modify__Column__Types_List.txt';
  table_column__modify__sql__column__add__file_name_c : string = 'Table_Column__Modify__Column__Add__sql.txt';
  table_column__modify__sql__column__default__file_name_c : string = 'Table_Column__Modify__Column__Default__sql.txt';
  table_column__modify__sql__column__collate__file_name_c : string = 'Table_Column__Modify__Column__Collate__sql.txt';
  table_column__modify__sql__column__collates_list__file_name_c : string = 'Table_Column__Modify__Column__Collates_List__sql.txt';
  table_column__modify__sql__column__not_null__file_name_c : string = 'Table_Column__Modify__Column__Not_Null__sql.txt';
  table_column__modify__sql__column__type_set__file_name_c : string = 'Table_Column__Modify__Column__Type_Set__sql.txt';
  table_column__modify__sql__command_end_char__file_name_c : string = 'Table_Column__Modify__Command_End_Char.txt';

var
  Table_Column__Modify_Form: TTable_Column__Modify_Form;

implementation

uses
  Shared,
  Translation;

{$R *.dfm}

function TTable_Column__Modify_Form.Quotation_Sign__TCM() : string;
begin

  if sql__quotation_sign__use__tcm then
    begin

      Result := sql__quotation_sign__tcm;

    end
  else
    Result := '';

end;

constructor TTable_Column__Modify_Form.Create( AOwner : TComponent; sdbm_f : Common.TSDBM );
begin

  inherited Create( AOwner );


  table_column__modify_sdbm := Common.TSDBM.Create( sdbm_f );
  table_column__modify_sdbm.Component_Type_Set( sdbm_f.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

end;

procedure TTable_Column__Modify_Form.FormCreate( Sender: TObject );
begin

  column__collate__tcm := '';
  column__name__tcm := '';
  column__position__tcm := 1;
  column__position__out__tcm := -99;
  column__type__tcm := '';
  database_type__tcm := '';
  from_table_add_tcm := false;
  modified__tcm := false;
  sql_prepared_correctly_g := false;
  table_name__tcm := '';
  type_edit__tcm := false;


  Translation.Translation__Apply( Self );


  Column_Position_SpinEdit.check_value__min := true;

end;

procedure TTable_Column__Modify_Form.FormShow( Sender: TObject );
var
  i : integer;
  zts : string;
begin

  PageControl1.ActivePage := Log_TabSheet;


  sql__add_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__sql__column__add__file_name_c  );

  if Trim( sql__add_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__sql__column__add__file_name_c + ').' );

      sql__add_g :=
        'alter table __TABLE_NAME__ add __COLUMN_NAME__ ';

    end
  else
    begin

      sql__add_g := StringReplace( sql__add_g, #10, '', [] );
      sql__add_g := StringReplace( sql__add_g, #13, '', [] );

    end;



  zts := Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__sql__column__collate__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__sql__column__collate__file_name_c + ').' );

      word__collate__tcm_g := ' collate ';

    end
  else
    begin

      word__collate__tcm_g := Common.Text__File_Load( zts );

      word__collate__tcm_g := StringReplace( word__collate__tcm_g, #10, '', [] );
      word__collate__tcm_g := StringReplace( word__collate__tcm_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Collate: ' + word__collate__tcm_g + '.' );



  zts := Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__sql__column__default__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__sql__column__default__file_name_c + ').' );

      word__default__tcm_g := ' default ';

    end
  else
    begin

      word__default__tcm_g := Common.Text__File_Load( zts );

      word__default__tcm_g := StringReplace( word__default__tcm_g, #10, '', [] );
      word__default__tcm_g := StringReplace( word__default__tcm_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Default: ' + word__default__tcm_g + '.' );



  zts := Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__sql__column__not_null__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__sql__column__not_null__file_name_c + ').' );

      word__not_null__tcm_g := ' not null ';

    end
  else
    begin

      word__not_null__tcm_g := Common.Text__File_Load( zts );

      word__not_null__tcm_g := StringReplace( word__not_null__tcm_g, #10, '', [] );
      word__not_null__tcm_g := StringReplace( word__not_null__tcm_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Not null: ' + word__not_null__tcm_g + '.' );



  sql__type_set_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__sql__column__type_set__file_name_c  );

  if Trim( sql__type_set_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__sql__column__type_set__file_name_c + ').' );

      sql__type_set_g :=
        'alter table __TABLE_NAME__ alter __COLUMN_NAME__ type ';

    end
  else
    begin

      sql__type_set_g := StringReplace( sql__type_set_g, #10, '', [] );
      sql__type_set_g := StringReplace( sql__type_set_g, #13, '', [] );

    end;



  zts := Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__sql__command_end_char__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__sql__command_end_char__file_name_c + ').' );

      word__command_end_char__tcm_g := ';';

    end
  else
    begin

      word__command_end_char__tcm_g := Common.Text__File_Load( zts );

      word__command_end_char__tcm_g := StringReplace( word__command_end_char__tcm_g, #10, '', [] );
      word__command_end_char__tcm_g := StringReplace( word__command_end_char__tcm_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Command end char: ' + word__command_end_char__tcm_g + '.' );



  sql__position_set_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + Common.table_column__position_set__sql__file_name_c  );

  if Trim( sql__position_set_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + Common.table_column__position_set__sql__file_name_c + ').' );

      sql__position_set_g := Common.table_column__position_set__sql_c;

    end
  else
    begin

      sql__position_set_g := StringReplace( sql__position_set_g, #10, '', [] );
      sql__position_set_g := StringReplace( sql__position_set_g, #13, '', [] );

    end;



  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__column__types_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__column__types_list__file_name_c + ').' );

      zts :=
        #13 + #10 +
        'Blob' + #13 + #10 +
        'Char ( 10 )' + #13 + #10 +
        'Date' + #13 + #10 +
        'Decimal ( 12, 2 )' + #13 + #10 +
        'Double precision' + #13 + #10 +
        'Float' + #13 + #10 +
        'Integer' + #13 + #10 +
        'Numeric' + #13 + #10 +
        'Smallint' + #13 + #10 +
        'Time' + #13 + #10 +
        'Timestamp' + #13 + #10 +
        'Varchar ( 50 )' + #13 + #10;

    end;

  Common.Items_From_Text_Add( Column_Type_ComboBox.Items, zts );

  if Column_Type_ComboBox.Items.Count > 0 then
    Column_Type_ComboBox.ItemIndex := 0;



  if table_column__modify_sdbm <> nil then
    begin

      Screen.Cursor := crHourGlass;

      Collate_ComboBox.Items.Clear();
      Collate_ComboBox.Items.Add( '' );


      if table_column__modify_sdbm.Query__Active() then
        table_column__modify_sdbm.Query__Close();

      zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__sql__column__collates_list__file_name_c  );

      if Trim( zts ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tcm ) + table_column__modify__sql__column__collates_list__file_name_c + ').' );

          zts :=
            'select RDB$COLLATIONS.RDB$COLLATION_NAME as COLLATION_NAME ' +
            'from RDB$COLLATIONS ' +
            'order by RDB$COLLATIONS.RDB$COLLATION_NAME ';

        end;

      table_column__modify_sdbm.Query__Sql__Set( zts );


      Log_Memo.Lines.Add( zts );


      try
        table_column__modify_sdbm.Query__Open();
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_collates_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            Screen.Cursor := crHourGlass;

          end;
      end;


      if table_column__modify_sdbm.Query__Active() then
        begin

          Log_Memo.Lines.Add( table_column__modify_sdbm.Operation_Duration_Get() );


          try
            table_column__modify_sdbm.Query__Field_By_Name( table_column__modify__column_name__collation_name_c ).AsString;
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_collate_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

                Screen.Cursor := crHourGlass;

              end;
          end;

        end;


      if table_column__modify_sdbm.Query__Active() then
        begin

          Log_Memo.Lines.Add( table_column__modify_sdbm.Operation_Duration_Get() );


          while not table_column__modify_sdbm.Query__Eof() do
            begin

              Collate_ComboBox.Items.Add(   Trim(  table_column__modify_sdbm.Query__Field_By_Name( table_column__modify__column_name__collation_name_c ).AsString  )   ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.


              table_column__modify_sdbm.Query__Next();

            end;

        end;


      if table_column__modify_sdbm.Query__Active() then
        table_column__modify_sdbm.Query__Close();

      Screen.Cursor := crDefault;

    end
  else
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.object_not_found___default_value_used__collate_ );


      zts :=
        #13 + #10 +
        'PXW_PLK' + #13 + #10;

      Common.Items_From_Text_Add( Collate_ComboBox.Items, zts );

      if Collate_ComboBox.Items.Count > 0 then
        Collate_ComboBox.ItemIndex := 0;

    end;



  if from_table_add_tcm then
    begin

      Column_Position_CheckBox.Visible := false;
      Default_Value_CheckBox.Visible := false;
      Execute_Button.Visible := false;
      Execute_Button_Works_As_Prepare_Execute_CheckBox.Visible := false;
      Ok_Button.Visible := true;
      Sql_Prepare_Button.Visible := false;
      Sql_TabSheet.TabVisible := false;

      if  Trim( column__collate__tcm ) <> '' then
        Collate_ComboBox.Text := column__collate__tcm;

      Column_Type_ComboBox.Text := column__type__tcm;

    end
  else
  if type_edit__tcm then
    begin

      Column_Name_Edit.Enabled := false;
      Default_Value_GroupBox.Enabled := false;
      Not_Null_CheckBox.Enabled := false;
      Collate_ComboBox.Enabled := false;


      for i := 0 to Default_Value_GroupBox.ControlCount - 1 do
        Vcl.Controls.TWinControl(Default_Value_GroupBox.Controls[ i ]).Enabled := false;


      Column_Name_Edit.Text := column__name__tcm;
      Column_Type_ComboBox.Text := column__type__tcm;

    end;


  Column_Position_SpinEdit.Value := column__position__tcm;


  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Sql_Memo.Font, Common.sql_editor__font );

end;

procedure TTable_Column__Modify_Form.FormDestroy( Sender: TObject );
begin

  if table_column__modify_sdbm <> nil then
    FreeAndNil( table_column__modify_sdbm );

end;

procedure TTable_Column__Modify_Form.Sql_Prepare_ButtonClick( Sender: TObject );
var
  zts : string;
begin

  sql_prepared_correctly_g := false;


  if Trim( Column_Name_Edit.Text ) = '' then
    begin

      if Column_Name_Edit.Enabled then
        Column_Name_Edit.SetFocus();

      Application.MessageBox( PChar(Translation.translation__messages_r.column_name_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;

  if Trim( Column_Type_ComboBox.Text ) = '' then
    begin

      Column_Type_ComboBox.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.column_type_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  if    ( Sender <> nil )
    and ( Sender = Ok_Button ) then
    begin

      ModalResult := mrOk;
      Exit;

    end;


  PageControl1.ActivePage := Sql_TabSheet;


  if type_edit__tcm then
    zts := sql__type_set_g
  else
    zts := sql__add_g;

  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TCM() + Column_Name_Edit.Text + Self.Quotation_Sign__TCM(), [ rfReplaceAll ] );
  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TCM() + table_name__tcm + Self.Quotation_Sign__TCM(), [ rfReplaceAll ] );


  zts := zts +
    Column_Type_ComboBox.Text;


  if Default_Value_CheckBox.Checked then
    zts := zts + word__default__tcm_g + Default_Value_Edit.Text;


  if Not_Null_CheckBox.Checked then
    zts := zts + word__not_null__tcm_g;


  if Collate_ComboBox.Text <> '' then
    zts := zts + word__collate__tcm_g + Collate_ComboBox.Text;


  zts := zts + word__command_end_char__tcm_g;



  Sql_Memo.Lines.Clear();
  Sql_Memo.Lines.Add( zts );


  if Column_Position_CheckBox.Checked then
    begin

      zts := sql__position_set_g;

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TCM() + Column_Name_Edit.Text + Self.Quotation_Sign__TCM(), [ rfReplaceAll ] );
      zts := StringReplace(   zts, Common.sql__word_replace_separator_c + Common.name__position_value_c + Common.sql__word_replace_separator_c, IntToStr(  Trunc( Column_Position_SpinEdit.Value )  ), [ rfReplaceAll ]   );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TCM() + table_name__tcm + Self.Quotation_Sign__TCM(), [ rfReplaceAll ] );

      Sql_Memo.Lines.Add( zts );

    end;


  sql_prepared_correctly_g := true;

end;

procedure TTable_Column__Modify_Form.Execute_ButtonClick( Sender: TObject );
var
  ztb,
  error_occurred
    : boolean;

  zti,
  sql_count_l
    : integer;

  zts_1,
  zts_2,
  error_message_l
    : string;
begin

  if table_column__modify_sdbm = nil then
    Exit;


  sql_prepared_correctly_g := false;


  if Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked then
    begin

      Sql_Prepare_ButtonClick( Sender );

      if not sql_prepared_correctly_g then
        Exit;

      sql_prepared_correctly_g := false;

    end;


  error_occurred := false;
  sql_count_l := 0;

  zts_1 := Sql_Memo.Lines.Text;

  zti := Pos( #13 + #10, zts_1 );

  while zti > 0 do
    begin

      inc( sql_count_l );


      zts_2 := Copy( zts_1, 1, zti - 1 );
      Delete( zts_1, 1, zti + 1 );

      zti := Pos( #13 + #10, zts_1 );


      if Trim( zts_2 ) <> '' then
        begin

          ztb := table_column__modify_sdbm.Sql_Command_Execute( zts_2, error_message_l, Translation.translation__messages_r.failed_to_modify_column );


          if ztb then
            begin

              if not modified__tcm then
                modified__tcm := true;


              Log_Memo.Lines.Add( table_column__modify_sdbm.Operation_Duration_Get() );
              Log_Memo.Lines.Add(   Trim(  Translation.translation__messages_r.sql_no_ + ' ' + FormatFloat( '### ### ### ### ### ### ##0', sql_count_l )  ) + ' - ' + Translation.translation__messages_r.word__done + '.'   );

            end
          else
            begin

              if not error_occurred then
                error_occurred := true;


              if Trim( error_message_l ) <> '' then
                Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );


              Break;

            end;

        end;

    end;


  if not error_occurred then
    begin

      if Column_Position_CheckBox.Checked then
        column__position__out__tcm := Trunc( Column_Position_SpinEdit.Value )
      else
        column__position__out__tcm := column__position__tcm;


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end;


  // It works to execute only one command at a time. //???
  //ztb := table_column__modify_sdbm.Sql_Command_Execute( Sql_Memo.Lines.Text, error_message_l, Translation.translation__messages_r.failed_to_modify_column );
  //
  //
  //if ztb then
  //  begin
  //
  //    if not modified__tcm then
  //      modified__tcm := true;
  //
  //
  //    Log_Memo.Lines.Add( table_column__modify_sdbm.Operation_Duration_Get() );
  //
  //    Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );
  //
  //  end
  //else
  //  begin
  //
  //    if Trim( error_message_l ) <> '' then
  //      Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );
  //
  //  end;

end;

procedure TTable_Column__Modify_Form.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TTable_Column__Modify_Form.Sql_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Sql_Memo.SelectAll();

end;

end.
