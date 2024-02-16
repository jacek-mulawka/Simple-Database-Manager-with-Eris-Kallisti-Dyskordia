unit Table__Trigger_Modify;{17.Sie.2023}

interface

uses
  Common,
  Text__Search_Replace,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, JvExMask,
  JvSpin, Vcl.ComCtrls, Vcl.CheckLst, SynEdit, SynCompletionProposal;

type
  TTable__Trigger_Modify_Form = class( TForm )
    Execute_Button: TButton;
    Close_Button: TButton;
    Sql_Memo: TMemo;
    Sql_Prepare_Button: TButton;
    Trigger_Name_Edit: TEdit;
    Trigger_Name_Etiquette_Label: TLabel;
    Trigger_Type_Etiquette_Label: TLabel;
    Trigger_Type_ComboBox: TComboBox;
    PageControl1: TPageControl;
    Log_TabSheet: TTabSheet;
    Sql_TabSheet: TTabSheet;
    Log_Memo: TMemo;
    Trigger_Activity_Etiquette_Label: TLabel;
    Trigger_Activity_ComboBox: TComboBox;
    Trigger_Sequence_Etiquette_Label: TLabel;
    Trigger_Sequence_JvSpinEdit: TJvSpinEdit;
    Trigger_Source_Memo: TMemo;
    Trigger_Source_Etiquette_Label: TLabel;
    Type_Panel: TPanel;
    Type__Left_Panel: TPanel;
    Trigger_Events_GroupBox: TGroupBox;
    Type_Vertical_Splitter: TSplitter;
    Trigger_Events_CheckListBox: TCheckListBox;
    Bottom_Panel: TPanel;
    Trigger_Source_Memo_Horizontal_Splitter: TSplitter;
    Code_Examples_Button: TButton;
    Execute_Button_Works_As_Prepare_Execute_CheckBox: TCheckBox;
    Trigger_Source__SynCompletionProposal: TSynCompletionProposal;
    Trigger_Source_SynEdit: TSynEdit;
    Caret_Position_Label: TLabel;
    procedure FormCreate( Sender: TObject );
    procedure FormShow( Sender: TObject );
    procedure FormDestroy( Sender: TObject );

    procedure Sql_Prepare_ButtonClick( Sender: TObject );
    procedure Execute_ButtonClick( Sender: TObject );

    procedure Code_Examples_ButtonClick( Sender: TObject );
    procedure Trigger_Events_CheckListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Sql_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Trigger_Source_MemoClick( Sender: TObject );
    procedure Trigger_Source_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Trigger_Source_MemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Trigger_Source_SynEditEnter( Sender: TObject );
    procedure Trigger_Source_SynEditClick( Sender: TObject );
    procedure Trigger_Source_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Trigger_Source_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Trigger_Source_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );

    procedure Trigger_Source__SynCompletionProposalCodeCompletion( Sender: TObject; var Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
    procedure Trigger_Source__SynCompletionProposalAfterCodeCompletion( Sender: TObject; const Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
  private
    { Private declarations }
    sql_prepared_correctly_g : boolean;

    code_completion__cursor_position_g : integer;

    sql__recreate_g,
    word__or_g
      : string;

    trigger_modify_sdbm : Common.TSDBM;

    text__search_replace_form : Text__Search_Replace.TText__Search_Replace_Form;

    procedure Caret_Position_Display();
    function Quotation_Sign__TTM() : string;
  public
    { Public declarations }
    modified__ttm,
    sql__quotation_sign__use__ttm,
    trigger_edit__ttm
      : boolean;

    trigger_name__ttm,
    database_type__ttm,
    sql__quotation_sign__ttm,
    table_name__ttm
      : string;

    constructor Create( AOwner : TComponent; sdbm_f : Common.TSDBM ); overload;
  end;

const
  table__trigger_modify__events_c : string = 'TRIGGER_EVENTS';
  table__trigger_modify__events_list__file_name_c : string = 'Table__Trigger_Modify__Events_List.txt';
  table__trigger_modify__sql__or__file_name_c : string = 'Table__Trigger_Modify__Or__sql.txt';
  table__trigger_modify__sql__trigger__data__file_name_c : string = 'Table__Trigger_Modify__Trigger__Data__sql.txt';
  table__trigger_modify__sql__trigger__recreate__file_name_c : string = 'Table__Trigger_Modify__Trigger__Recreate__sql.txt';
  table__trigger_modify__type_c : string = 'TRIGGER_TYPE';
  table__trigger_modify__types_list__file_name_c : string = 'Table__Trigger_Modify__Types__List.txt';

var
  Table__Trigger_Modify_Form: TTable__Trigger_Modify_Form;

implementation

uses
  System.StrUtils,

  Shared,
  Translation;

{$R *.dfm}

procedure TTable__Trigger_Modify_Form.Caret_Position_Display();
begin

  //Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Trigger_Source_Memo.CaretPos.Y + 1 )  ) + ' / ' + Trim(   FormatFloat( '### ### ### ### ### ### ##0', Trigger_Source_Memo.CaretPos.X + 1 ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Trigger_Source_Memo.Lines.Text.Length )  )   );
  Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Trigger_Source_SynEdit.CaretY )  ) + ' / ' + Trim(   FormatFloat( '### ### ### ### ### ### ##0', Trigger_Source_SynEdit.CaretX ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Trigger_Source_SynEdit.Lines.Text.Length )  )   );

end;


function TTable__Trigger_Modify_Form.Quotation_Sign__TTM() : string;
begin

  if sql__quotation_sign__use__ttm then
    begin

      Result := sql__quotation_sign__ttm;

    end
  else
    Result := '';

end;

constructor TTable__Trigger_Modify_Form.Create( AOwner : TComponent; sdbm_f : Common.TSDBM );
begin

  inherited Create( AOwner );


  trigger_modify_sdbm := Common.TSDBM.Create( sdbm_f );
  trigger_modify_sdbm.Component_Type_Set( sdbm_f.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

end;

procedure TTable__Trigger_Modify_Form.FormCreate( Sender: TObject );
begin

  code_completion__cursor_position_g := -1;
  database_type__ttm := '';
  modified__ttm := false;
  sql_prepared_correctly_g := false;
  table_name__ttm := '';
  text__search_replace_form := nil;
  trigger_edit__ttm := false;
  trigger_name__ttm := '';

  Common.Text__Search_Replace__Hide( text__search_replace_form );


  Translation.Translation__Apply( Self );

end;

procedure TTable__Trigger_Modify_Form.FormShow( Sender: TObject );
var
  zti_1,
  zti_2
    : integer;

  zts_1,
  zts_2
    : string;
begin

  PageControl1.ActivePage := Log_TabSheet;


  if trigger_edit__ttm then
    begin

      Trigger_Name_Edit.Enabled := false;
      Trigger_Name_Edit.Text := trigger_name__ttm;

    end
  else
    //Trigger_Source_Memo.Lines.Add( Trigger_Source_Etiquette_Label.Hint );
    Trigger_Source_SynEdit.Text := Trigger_Source_Etiquette_Label.Hint;



  zts_1 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + Common.trigger_modify__code_completion_list__file_name_c  );

  if Trim( zts_1 ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + Common.trigger_modify__code_completion_list__file_name_c + ').' );

      zts_1 := Common.trigger_modify__code_completion_list_c

    end;

  zts_1 := StringReplace( zts_1, Translation.translation__code_completion__trigger_c, Translation.translation__messages_r.code_completion__trigger, [ rfReplaceAll ] );

  zts_2 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + Common.sql_editor__code_completion_list__file_name_c  );

  if Trim( zts_2 ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + Common.sql_editor__code_completion_list__file_name_c + ').' );


      zts_2 := Common.sql_editor__code_completion_list_c;

    end;

  if Trim( zts_2 ) <> '' then
    begin

      zts_2 := StringReplace( zts_2, Translation.translation__code_completion__sql_c, Translation.translation__messages_r.code_completion__sql, [ rfReplaceAll ] );

      zts_1 := zts_1 + zts_2;

    end;

  zti_1 := Pos( #13 + #10, zts_1 );

  while zti_1 > 1 do
    begin

      zts_2 := Copy( zts_1, 1, zti_1 - 1 );

      zti_2 := Pos( Common.code_completion__caption_value_separator_c, zts_1 );


      Trigger_Source__SynCompletionProposal.ItemList.Add(  Copy( zts_2, 1, zti_2 - 1 )  );

      Delete(  zts_2, 1, zti_2 + Length( Common.code_completion__caption_value_separator_c ) - 1  );
      zts_2 := StringReplace( zts_2, Common.newline_symbol_c, #13 + #10, [ rfReplaceAll ] );

      Trigger_Source__SynCompletionProposal.InsertList.Add( zts_2 );


      Delete( zts_1, 1, zti_1 + 1 );


      zti_1 := Pos( #13 + #10, zts_1 );

    end;


  sql__recreate_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + table__trigger_modify__sql__trigger__recreate__file_name_c  );

  if Trim( sql__recreate_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + table__trigger_modify__sql__trigger__recreate__file_name_c + ').' );

      sql__recreate_g :=
        'recreate trigger __TRIGGER_NAME__ for __TABLE_NAME__ ' +
        '__TRIGGER_ACTIVITY__ ' +
        '__TRIGGER_TYPE__ ' +
        '__TRIGGER_EVENTS__ ' +
        'position __TRIGGER_SEQUENCE__ ' +
        '__TRIGGER_SOURCE__ ';

    end
  else
    begin

      sql__recreate_g := StringReplace( sql__recreate_g, #10, '', [] );
      sql__recreate_g := StringReplace( sql__recreate_g, #13, '', [] );

    end;



  zts_1 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + Common.trigger_modify__activity_list__file_name_c  );

  if Trim( zts_1 ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + Common.trigger_modify__activity_list__file_name_c + ').' );

      zts_1 := Common.trigger_modify__activity_list_c;

    end;

  Common.Items_From_Text_Add( Trigger_Activity_ComboBox.Items, zts_1 );

  if Trigger_Activity_ComboBox.Items.Count > 0 then
    Trigger_Activity_ComboBox.ItemIndex := 0;



  zts_1 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + table__trigger_modify__events_list__file_name_c  );

  if Trim( zts_1 ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + table__trigger_modify__events_list__file_name_c + ').' );

      zts_1 :=
        'delete' + #13 + #10 +
        'insert' + #13 + #10 +
        'update' + #13 + #10;

    end;

  Common.Items_From_Text_Add( Trigger_Events_CheckListBox.Items, zts_1 );

  if Trigger_Events_CheckListBox.Items.Count > 0 then
    Trigger_Events_CheckListBox.ItemIndex := 0;



  zts_1 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + table__trigger_modify__types_list__file_name_c  );

  if Trim( zts_1 ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + table__trigger_modify__types_list__file_name_c + ').' );

      zts_1 :=
        'after' + #13 + #10 +
        'before' + #13 + #10;

    end;

  Common.Items_From_Text_Add( Trigger_Type_ComboBox.Items, zts_1 );

  if Trigger_Type_ComboBox.Items.Count > 0 then
    Trigger_Type_ComboBox.ItemIndex := 0;


  zts_1 := Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + table__trigger_modify__sql__or__file_name_c;

  if not FileExists( zts_1 ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + table__trigger_modify__sql__or__file_name_c + ').' );

      word__or_g := ' or ';

    end
  else
    begin

      word__or_g := Common.Text__File_Load( zts_1 );

      word__or_g := StringReplace( word__or_g, #10, '', [] );
      word__or_g := StringReplace( word__or_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Or: ' + word__or_g + '.' );



  if trigger_edit__ttm then
    begin

      Screen.Cursor := crHourGlass;


      Trigger_Activity_ComboBox.ItemIndex := -1;
      Trigger_Type_ComboBox.ItemIndex := -1;


      if trigger_modify_sdbm.Query__Active() then
        trigger_modify_sdbm.Query__Close();

      zts_1 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + table__trigger_modify__sql__trigger__data__file_name_c  );

      if Trim( zts_1 ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + table__trigger_modify__sql__trigger__data__file_name_c + ').' );

          zts_1 :=
            'select RDB$TRIGGERS.RDB$TRIGGER_NAME as TRIGGER_NAME ' +
            '     , iif( RDB$TRIGGERS.RDB$TRIGGER_INACTIVE = 0, ''active'', ''inactive'' ) as TRIGGER_ACTIVE ' +
            '     , RDB$TRIGGERS.RDB$TRIGGER_SEQUENCE as TRIGGER_SEQUENCE ' +
            '     , RDB$TRIGGERS.RDB$TRIGGER_SOURCE as TRIGGER_SOURCE ' +
            ' ' +
            '     , (case ' +
            '         RDB$TRIGGERS.RDB$TRIGGER_TYPE ' +
            '         when 1 then ' +
            '           ''before insert'' ' +
            ' ' +
            '         when 2 then ' +
            '           ''after insert'' ' +
            ' ' +
            '         when 3 then ' +
            '           ''before update'' ' +
            ' ' +
            '         when 4 then ' +
            '           ''after update'' ' +
            ' ' +
            '         when 5 then ' +
            '           ''before delete'' ' +
            ' ' +
            '         when 6 then ' +
            '           ''after delete'' ' +
            ' ' +
            '         when 17 then ' +
            '           ''before insert or update'' ' +
            ' ' +
            '         when 18 then ' +
            '           ''after insert or update'' ' +
            ' ' +
            '         when 25 then ' +
            '           ''before delete or insert'' ' +
            ' ' +
            '         when 26 then ' +
            '           ''after delete or insert'' ' +
            ' ' +
            '         when 27 then ' +
            '           ''before delete or update'' ' +
            ' ' +
            '         when 28 then ' +
            '           ''after delete or update'' ' +
            ' ' +
            '         when 77 then ' +
            '           ''before delete or insert or update'' ' +
            ' ' +
            '         when 78 then ' +
            '           ''after delete or insert or update'' ' +
            ' ' +
            '         when 113 then ' +
            '           ''before delete or insert or update'' ' +
            ' ' +
            '         when 114 then ' +
            '           ''after delete or insert or update'' ' +
            ' ' +
            '         when 8192 then ' +
            '           ''on connect'' ' +
            ' ' +
            '         when 8193 then ' +
            '           ''on disconnect'' ' +
            ' ' +
            '         when 8194 then ' +
            '           ''on transaction start'' ' +
            ' ' +
            '         when 8195 then ' +
            '           ''on transaction commit'' ' +
            ' ' +
            '         when 8196 then ' +
            '           ''on transaction rollback'' ' +
            ' ' +
            '         else ' +
            '           RDB$TRIGGERS.RDB$TRIGGER_TYPE||'' <?>'' ' +
            '       end) as TRIGGER_TYPE ' +
            ' ' +
            'from RDB$TRIGGERS ' +
            'where RDB$TRIGGERS.RDB$RELATION_NAME = :table_name ' +
            '  and RDB$TRIGGERS.RDB$TRIGGER_NAME = :trigger_name ';

        end;

      trigger_modify_sdbm.Query__Sql__Set( zts_1 );


      Log_Memo.Lines.Add( zts_1 );


      trigger_modify_sdbm.Query__Param_By_Name__Set( Common.name__table__small_letters_c, table_name__ttm, Log_Memo );
      trigger_modify_sdbm.Query__Param_By_Name__Set( Common.name__trigger__name__small_letters_c, trigger_name__ttm, Log_Memo );

      try
        trigger_modify_sdbm.Query__Open();
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_trigger_data + #13 + #13 + E.Message + #13 + #13 + zts_1 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;



      if trigger_modify_sdbm.Query__Active() then
        begin

          Log_Memo.Lines.Add( trigger_modify_sdbm.Operation_Duration_Get() );


          if trigger_modify_sdbm.Query__Record_Count() <> 1 then
            begin

              Screen.Cursor := crDefault;

              Application.MessageBox( PChar(Translation.translation__messages_r.trigger_not_found + #13 + #13 + table_name__ttm + ' - ' + trigger_name__ttm + Translation.translation__messages_r.query_output_count_ + ' ' + trigger_modify_sdbm.Query__Record_Count().ToString() + #13 + #13 + zts_1 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

              trigger_modify_sdbm.Query__Close();

              Screen.Cursor := crHourGlass;

            end;

        end;


      if trigger_modify_sdbm.Query__Active() then
        begin

          try
            trigger_modify_sdbm.Query__Field_By_Name( Common.name__trigger__name__big_letters_c ).AsString;
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_trigger_name + #13 + #13 + E.Message + #13 + #13 + zts_1 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

                Screen.Cursor := crHourGlass;

              end;
          end;


          try
            trigger_modify_sdbm.Query__Field_By_Name( Common.name__trigger__active_c ).AsString;

            for zti_1 := 0 to Trigger_Activity_ComboBox.Items.Count - 1 do
              if Trim( Trigger_Activity_ComboBox.Items[ zti_1 ] ) = Trim( trigger_modify_sdbm.Query__Field_By_Name( Common.name__trigger__active_c ).AsString ) then
                begin

                  Trigger_Activity_ComboBox.ItemIndex := zti_1;

                  Break;

                end;

          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_activity_column_name + #13 + #13 + E.Message + #13 + #13 + zts_1 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

                Screen.Cursor := crHourGlass;

              end;
          end;


          try
            trigger_modify_sdbm.Query__Field_By_Name( table__trigger_modify__type_c ).AsString;

            for zti_1 := 0 to Trigger_Events_CheckListBox.Items.Count - 1 do
              if Pos( Trigger_Events_CheckListBox.Items[ zti_1 ], trigger_modify_sdbm.Query__Field_By_Name( table__trigger_modify__type_c ).AsString ) > 0 then
                begin

                  Trigger_Events_CheckListBox.Checked[ zti_1 ] := true;

                end;

          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_events_column_name + #13 + #13 + E.Message + #13 + #13 + zts_1 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

                Screen.Cursor := crHourGlass;

              end;
          end;


          try
            trigger_modify_sdbm.Query__Field_By_Name( table__trigger_modify__type_c ).AsString;

            for zti_1 := 0 to Trigger_Type_ComboBox.Items.Count - 1 do
              if Pos( Trigger_Type_ComboBox.Items[ zti_1 ], trigger_modify_sdbm.Query__Field_By_Name( table__trigger_modify__type_c ).AsString ) > 0 then
                begin

                  Trigger_Type_ComboBox.ItemIndex := zti_1;

                  Break;

                end;

          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_type_column_name + #13 + #13 + E.Message + #13 + #13 + zts_1 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

                Screen.Cursor := crHourGlass;

              end;
          end;


          try
            trigger_modify_sdbm.Query__Field_By_Name( Common.trigger_modify__sequence_c ).AsString;

            Trigger_Sequence_JvSpinEdit.Value := trigger_modify_sdbm.Query__Field_By_Name( Common.trigger_modify__sequence_c ).AsInteger;
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_sequence_column_name + #13 + #13 + E.Message + #13 + #13 + zts_1 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

                Screen.Cursor := crHourGlass;

              end;
          end;


          try
            trigger_modify_sdbm.Query__Field_By_Name( Common.name__trigger__source_c ).AsString;

            //Trigger_Source_Memo.Lines.Text := trigger_modify_sdbm.Query__Field_By_Name( Common.name__trigger__source_c ).AsString;
            Trigger_Source_SynEdit.Lines.Text := trigger_modify_sdbm.Query__Field_By_Name( Common.name__trigger__source_c ).AsString;
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_source_column_name + #13 + #13 + E.Message + #13 + #13 + zts_1 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

                Screen.Cursor := crHourGlass;

              end;
          end;

        end;


      if trigger_modify_sdbm.Query__Active() then
        trigger_modify_sdbm.Query__Close();

      Screen.Cursor := crDefault;

    end;


  Caret_Position_Display();


  Common.Syn_Completion_Proposal__Parameters__Set( Trigger_Source__SynCompletionProposal );


  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Sql_Memo.Font, Common.sql_editor__font );
  //Common.Font__Set( Trigger_Source_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Trigger_Source_SynEdit.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    Common.Font__Set( Trigger_Events_CheckListBox.Font, Common.sql_editor__font );

  Common.Syn_Edit__Parameters__Set( Trigger_Source_SynEdit );


  Common.Syn_Edit__Search_Text_Hightlighter_Syn_Edit_Plugin__Create( Trigger_Source_SynEdit );

end;

procedure TTable__Trigger_Modify_Form.FormDestroy( Sender: TObject );
begin

  Common.Text__Search_Replace__Syn_Edit__Set( nil, text__search_replace_form );
  Common.Text__Search_Replace__Hide( text__search_replace_form );


  if trigger_modify_sdbm <> nil then
    FreeAndNil( trigger_modify_sdbm );

  if text__search_replace_form <> nil then
    FreeAndNil( text__search_replace_form );

end;

procedure TTable__Trigger_Modify_Form.Sql_Prepare_ButtonClick( Sender: TObject );
var
  i : integer;

  zts,
  events_list_l
    : string;
begin

  sql_prepared_correctly_g := false;


  if Trim( Trigger_Name_Edit.Text ) = '' then
    begin

      if Trigger_Name_Edit.Enabled then
        Trigger_Name_Edit.SetFocus();

      Application.MessageBox( PChar(Translation.translation__messages_r.trigger_name_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;

  if Trim( Trigger_Type_ComboBox.Text ) = '' then
    begin

      Trigger_Type_ComboBox.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.trigger_type_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;

  if Trim( Trigger_Activity_ComboBox.Text ) = '' then
    begin

      Trigger_Activity_ComboBox.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.trigger_activity_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  events_list_l := '';

  for i := 0 to Trigger_Events_CheckListBox.Items.Count - 1 do
    if Trigger_Events_CheckListBox.Checked[ i ] then
      begin

        if events_list_l <> '' then
          events_list_l := events_list_l + word__or_g;

        events_list_l := events_list_l + Trigger_Events_CheckListBox.Items[ i ];

      end;


  if Trim( events_list_l ) = '' then
    begin

      Trigger_Events_CheckListBox.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.trigger_events_must_be_selected), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  //if Trim( Trigger_Source_Memo.Text ) = '' then
  if Trim( Trigger_Source_SynEdit.Text ) = '' then
    begin

      //Trigger_Source_Memo.SetFocus();
      Trigger_Source_SynEdit.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.trigger_source_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  PageControl1.ActivePage := Sql_TabSheet;


  zts := sql__recreate_g;

  zts := StringReplace( zts, Common.sql__word_replace_separator_c + table__trigger_modify__events_c + Common.sql__word_replace_separator_c, events_list_l, [ rfReplaceAll ] );
  zts := StringReplace( zts, Common.sql__word_replace_separator_c + table__trigger_modify__type_c + Common.sql__word_replace_separator_c, Trigger_Type_ComboBox.Text, [ rfReplaceAll ] );
  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TTM() + table_name__ttm + Self.Quotation_Sign__TTM(), [ rfReplaceAll ] );
  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__trigger__name__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TTM() + Trigger_Name_Edit.Text + Self.Quotation_Sign__TTM(), [ rfReplaceAll ] );
  //zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__trigger__source_c + Common.sql__word_replace_separator_c, Trigger_Source_Memo.Lines.Text, [ rfReplaceAll ] );
  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__trigger__source_c + Common.sql__word_replace_separator_c, Trigger_Source_SynEdit.Lines.Text, [ rfReplaceAll ] );
  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.trigger_modify__activity_c + Common.sql__word_replace_separator_c, Trigger_Activity_ComboBox.Text, [ rfReplaceAll ] );
  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.trigger_modify__sequence_c + Common.sql__word_replace_separator_c, Trigger_Sequence_JvSpinEdit.Value.ToString(), [ rfReplaceAll ] );


  Sql_Memo.Lines.Clear();
  Sql_Memo.Lines.Add( zts );


  sql_prepared_correctly_g := true;

end;

procedure TTable__Trigger_Modify_Form.Execute_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  error_message_l : string;
begin

  if trigger_modify_sdbm = nil then
    Exit;


  sql_prepared_correctly_g := false;


  if Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked then
    begin

      Sql_Prepare_ButtonClick( Sender );

      if not sql_prepared_correctly_g then
        Exit;

      sql_prepared_correctly_g := false;

    end;


  ztb := trigger_modify_sdbm.Sql_Command_Execute( Sql_Memo.Lines.Text, error_message_l, Translation.translation__messages_r.failed_to_modify_trigger, false );


  if ztb then
    begin

      if not modified__ttm then
        modified__ttm := true;


      Log_Memo.Lines.Add( trigger_modify_sdbm.Operation_Duration_Get() );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable__Trigger_Modify_Form.Code_Examples_ButtonClick( Sender: TObject );
var
  zts : string;
begin

  PageControl1.ActivePage := Log_TabSheet;

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + Common.trigger_modify__code_examples__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ttm ) + Common.trigger_modify__code_examples__file_name_c + ').' );

      zts :=
        Translation.translation__messages_r.trigger_code_example + #13 + #10 +
        Common.trigger_modify__code_examples_c;

    end
  else
    zts :=
      Translation.translation__messages_r.trigger_code_example + #13 + #10 +
      zts;


  Log_Memo.Lines.Add( zts );

end;

procedure TTable__Trigger_Modify_Form.Trigger_Events_CheckListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
var
  i : integer;
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Trigger_Events_CheckListBox.CheckAll( cbChecked, false, false )
  else
  // N.
  if    ( Key = 78 )
    and ( Shift = [ ssCtrl ] ) then
    Trigger_Events_CheckListBox.CheckAll( cbUnchecked, false, false )
  else
  // I.
  if    ( Key = 73 )
    and ( Shift = [ ssCtrl ] ) then
    for i := 0 to Trigger_Events_CheckListBox.Items.Count - 1 do
      Trigger_Events_CheckListBox.Checked[ i ] := not Trigger_Events_CheckListBox.Checked[ i ];

end;

procedure TTable__Trigger_Modify_Form.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TTable__Trigger_Modify_Form.Sql_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Sql_Memo.SelectAll();

end;

procedure TTable__Trigger_Modify_Form.Trigger_Source_MemoClick( Sender: TObject );
begin

  Caret_Position_Display();

end;

procedure TTable__Trigger_Modify_Form.Trigger_Source_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_ADD )
    and ( Shift = [ ssCtrl ] ) then
     Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked := not Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked
  else
  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Trigger_Source_Memo.SelectAll()
  else
  // E.
  if    ( Key = 69 )
    and ( Shift = [ ssCtrl ] ) then
    Execute_ButtonClick( Sender )
  else
  // P.
  if    ( Key = 80 )
    and ( Shift = [ ssCtrl ] ) then
    Sql_Prepare_ButtonClick( Sender );

end;

procedure TTable__Trigger_Modify_Form.Trigger_Source_MemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

end;

procedure TTable__Trigger_Modify_Form.Trigger_Source_SynEditEnter( Sender: TObject );
begin

  Common.Text__Search_Replace__Syn_Edit__Set( Trigger_Source_SynEdit, text__search_replace_form );

end;

procedure TTable__Trigger_Modify_Form.Trigger_Source_SynEditClick( Sender: TObject );
begin

  Caret_Position_Display();

  Common.Syn_Edit__Highlight__Text( Trigger_Source_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( Trigger_Source_SynEdit, text__search_replace_form );

end;

procedure TTable__Trigger_Modify_Form.Trigger_Source_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if not Common.Syn_Edit_Key_Down( Trigger_Source_SynEdit, Sender, Key, Shift ) then
    if    ( Key = VK_ADD )
      and ( Shift = [ ssCtrl ] ) then
       Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked := not Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked
    else
    // E.
    if    ( Key = 69 )
      and ( Shift = [ ssCtrl ] ) then
      Execute_ButtonClick( Sender )
    else
    // P.
    if    ( Key = 80 )
      and ( Shift = [ ssCtrl ] ) then
      Sql_Prepare_ButtonClick( Sender );

end;

procedure TTable__Trigger_Modify_Form.Trigger_Source_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

  Common.Syn_Edit__Highlight__Text( Trigger_Source_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( Trigger_Source_SynEdit, text__search_replace_form );

end;

procedure TTable__Trigger_Modify_Form.Trigger_Source_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );
begin

  Common.Syn_Edit__On_Replace_Text(  Trigger_Source_SynEdit, ASearch, AReplace, Line, Column, Action, ClientToScreen( Self.ClientRect )  );

end;

procedure TTable__Trigger_Modify_Form.Trigger_Source__SynCompletionProposalCodeCompletion( Sender: TObject; var Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
begin

  Common.Syn_Completion_Proposal_Code_Completion( code_completion__cursor_position_g, Value );

end;

procedure TTable__Trigger_Modify_Form.Trigger_Source__SynCompletionProposalAfterCodeCompletion( Sender: TObject; const Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
begin

  Common.Syn_Completion_Proposal_After_Code_Completion( Trigger_Source_SynEdit, code_completion__cursor_position_g );

end;

end.
