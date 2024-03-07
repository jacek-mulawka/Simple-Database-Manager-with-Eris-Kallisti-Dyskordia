unit Sql_Editor_F;{21.Lip.2023}

  // Dynamically created menu items will not be translated because they have empty names (inside Highlighter__Syntax_MenuItem, Bookmarks__Go_To_MenuItem).

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client, Vcl.ComCtrls,

  Common,
  Migawka_Prostokat_Tabela_2_SDBM,
  Text__Search_Replace,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Menus, SynEdit, SynCompletionProposal,

  Interceptor__Syn_Edit;

type
  TSql_Editor_F_Frame = class( TFrame )
    Buttons_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    Sql_Editor_Column_DBEdit: TDBEdit;
    Sql_Editor_DataSource: TDataSource;
    Sql_Editor_DBGrid: TDBGrid;
    Log_Memo: TMemo;
    Sql_GroupBox: TGroupBox;
    Output_Save_Button: TButton;
    Record_Number__Records_Count_Label: TLabel;
    Refresh_Button: TButton;
    Search_Edit: TEdit;
    Search_GroupBox: TGroupBox;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Next_Button: TButton;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Prior_Button: TButton;
    Vertical_Splitter: TSplitter;
    Tab_Name_GroupBox: TGroupBox;
    Tab_Name_Edit: TEdit;
    Tab_Name__Set_Button: TButton;
    Open_Button: TButton;
    Sql__Next_Button: TButton;
    Sql__Prior_Button: TButton;
    Csv__File__Data_Separator_Edit: TEdit;
    Csv__File__Text_Qualifier_Edit: TEdit;
    Middle_Panel: TPanel;
    Sql_Text_Panel: TPanel;
    Sql_Text_Horizontal_Splitter: TSplitter;
    Left_Panel: TPanel;
    Buttons_Panel_Horizontal_Splitter: TSplitter;
    Log_Horizontal_Splitter: TSplitter;
    Tables_Columns_List_Panel: TPanel;
    Tables_List_ListBox: TListBox;
    Tables_List_Horizontal_Splitter: TSplitter;
    Columns_List_ListBox: TListBox;
    Sql_Text_Memo: TMemo;
    Close_Button: TButton;
    Transaction__Rollback_Button: TButton;
    Transaction__Commit_Button: TButton;
    Transaction__Begin_Button: TButton;
    Caret_Position_Label: TLabel;
    Transactions_Count_Label: TLabel;
    SaveDialog1: TSaveDialog;
    Middle_Panel__Bottom_Panel: TPanel;
    Data_Preview_Memo_Horizontal_Splitter: TSplitter;
    Data_Preview_DBMemo: TDBMemo;
    Sql_Parameters_Vertical_Splitter: TSplitter;
    Sql_Parameters_ScrollBox: TScrollBox;
    Sql_Text__Code_Completion_PopupMenu: TPopupMenu;
    Execute_Button: TButton;
    Search_In_RadioGroup: TRadioGroup;
    Ado_Command_Param_Check_CheckBox: TCheckBox;
    Execute__Automatic_Detection_CheckBox: TCheckBox;
    Transactions_Automatic_CheckBox: TCheckBox;
    Query_Output_Save_Field_Format_GroupBox: TGroupBox;
    Query_Output_Save_Field_Format__Date_GroupBox: TGroupBox;
    Query_Output_Save_Field_Format__Date__Use_CheckBox: TCheckBox;
    Query_Output_Save_Field_Format__Date_Edit: TEdit;
    Query_Output_Save_Field_Format__Real_Numbers_GroupBox: TGroupBox;
    Query_Output_Save_Field_Format__Real_Numbers__Use_CheckBox: TCheckBox;
    Query_Output_Save_Field_Format__Real_Numbers_Edit: TEdit;
    Query_Output_Save_Field_Format__Time_GroupBox: TGroupBox;
    Query_Output_Save_Field_Format__Time__Use_CheckBox: TCheckBox;
    Query_Output_Save_Field_Format__Time_Edit: TEdit;
    Query_Output_Save_Field_Format__Separators_GroupBox: TGroupBox;
    Query_Output_Save_Field_Format__Separator__Decimal_GroupBox: TGroupBox;
    Query_Output_Save_Field_Format__Separator__Decimal_Edit: TEdit;
    Query_Output_Save_Field_Format__Separator__Date_Time_GroupBox: TGroupBox;
    Query_Output_Save_Field_Format__Separator__Date_Time_Edit: TEdit;
    Sql_Text_SynEdit: TSynEdit;
    Sql_Text__SynCompletionProposal: TSynCompletionProposal;
    Sql_ProgressBar: TProgressBar;
    Data_Value_Format__Disabled_CheckBox: TCheckBox;
    Comments_Delete_CheckBox: TCheckBox;
    Text__File_GroupBox: TGroupBox;
    Text__File__Buttons_Panel: TPanel;
    Text__File__Encoding_ComboBox: TComboBox;
    Text__File__Find_Button: TButton;
    Text__File__Load_Button: TButton;
    Text__File__Path_Edit: TEdit;
    Text__File__Save_Button: TButton;
    OpenDialog1: TOpenDialog;
    Sql_Text_PopupMenu: TPopupMenu;
    Open_MenuItem: TMenuItem;
    Execute_MenuItem: TMenuItem;
    Refresh_MenuItem: TMenuItem;
    Close_MenuItem: TMenuItem;
    N1: TMenuItem;
    Transaction__Begin_MenuItem: TMenuItem;
    Transaction__Commit_MenuItem: TMenuItem;
    Transaction__Rollback_MenuItem: TMenuItem;
    N2: TMenuItem;
    Sql__Prior_MenuItem: TMenuItem;
    Sql__Next_MenuItem: TMenuItem;
    N3: TMenuItem;
    Find_MenuItem: TMenuItem;
    Replace_MenuItem: TMenuItem;
    N4: TMenuItem;
    Bookmarks__Toggle_MenuItem: TMenuItem;
    Bookmarks__Go_To_MenuItem: TMenuItem;
    Bookmarks__Clear__All_MenuItem: TMenuItem;
    N5: TMenuItem;
    Highlights__Brackets_MenuItem: TMenuItem;
    Highlights__Brackets__All_Pairs_MenuItem: TMenuItem;
    Highlights__Brackets__Marked_Only_MenuItem: TMenuItem;
    N6: TMenuItem;
    Highlights__Brackets__Angle_MenuItem: TMenuItem;
    Highlights__Brackets__Curly_MenuItem: TMenuItem;
    Highlights__Brackets__Round_MenuItem: TMenuItem;
    Highlights__Brackets__Square_MenuItem: TMenuItem;
    Highlighter__Syntax_MenuItem: TMenuItem;
    N7: TMenuItem;
    Lines_Color__Toggle_MenuItem: TMenuItem;
    Lines_Color__Change_MenuItem: TMenuItem;
    Lines_Color__Choose_MenuItem: TMenuItem;
    Lines_Color__Clear__All_MenuItem: TMenuItem;
    N8: TMenuItem;
    Comment_Uncomment_MenuItem: TMenuItem;
    Comment_Uncomment_Alternatively_MenuItem: TMenuItem;
    Comment_Invert_Alternatively_MenuItem: TMenuItem;
    N9: TMenuItem;
    Output_Save_MenuItem: TMenuItem;
    N10: TMenuItem;
    Text__File__Find_MenuItem: TMenuItem;
    Text__File__Load_MenuItem: TMenuItem;
    Text__File__Save_MenuItem: TMenuItem;
    N11: TMenuItem;
    Cut_MenuItem: TMenuItem;
    Copy_MenuItem: TMenuItem;
    Paste_MenuItem: TMenuItem;
    Select_All_MenuItem: TMenuItem;
    N12: TMenuItem;
    Database__Reconnect_MenuItem: TMenuItem;
    N13: TMenuItem;
    Transactions_Automatic_MenuItem: TMenuItem;
    Block_Execute__Automatic_Detection_MenuItem: TMenuItem;
    Execute__Automatic_Detection_MenuItem: TMenuItem;
    Data_Value_Format__Disabled_MenuItem: TMenuItem;
    Comments_Delete_MenuItem: TMenuItem;
    Execute__Selected_MenuItem: TMenuItem;
    Ado_Command_Param_Check_MenuItem: TMenuItem;
    Queries_Open_In_Background_MenuItem: TMenuItem;
    Keyboard__Shortcuts__Switch__Output_Save__With__Text_File_Save_MenuItem: TMenuItem;
    Bookmarks__Toggle__With__Line_Color_MenuItem: TMenuItem;

    procedure Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );

    procedure Sql_Editor_Column_DBEditChange( Sender: TObject );

    procedure Tables_List_ListBoxClick( Sender: TObject );
    procedure Tables_List_ListBoxDblClick( Sender: TObject );
    procedure Columns_List_ListBoxClick( Sender: TObject );
    procedure Columns_List_ListBoxDblClick( Sender: TObject );
    procedure Tables_List_ListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Columns_List_ListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Open_ButtonClick( Sender: TObject );
    procedure Close_ButtonClick( Sender: TObject );
    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Output_Save_ButtonClick( Sender: TObject );
    procedure Sql__Prior_ButtonClick( Sender: TObject );
    procedure Sql__Next_ButtonClick( Sender: TObject );
    procedure Transaction__Begin_ButtonClick( Sender: TObject );
    procedure Transaction__Commit_ButtonClick( Sender: TObject );
    procedure Transaction__Rollback_ButtonClick( Sender: TObject );

    procedure Search_Change( Sender: TObject );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );
    procedure Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Search_ButtonKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Ado_Command_Param_Check_CheckBoxClick( Sender: TObject );
    procedure Comments_Delete_CheckBoxClick( Sender: TObject );
    procedure Data_Value_Format__Disabled_CheckBoxClick( Sender: TObject );
    procedure Execute__Automatic_Detection_CheckBoxClick( Sender: TObject );
    procedure Transactions_Automatic_CheckBoxClick( Sender: TObject );

    procedure Tab_Name__Set_ButtonClick( Sender: TObject );
    procedure Tab_Name_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );
    procedure Bookmarks__Clear__All_MenuItemClick( Sender: TObject );
    procedure Database__Reconnect_MenuItemClick( Sender: TObject );

    procedure File_Path_EditExit( Sender: TObject );

    procedure Text__File__Find_ButtonClick( Sender: TObject );
    procedure Text__File__Load_ButtonClick( Sender: TObject );
    procedure Text__File__Save_ButtonClick( Sender: TObject );
    procedure Text__FileKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Sql_Text_MemoClick( Sender: TObject );
    procedure Sql_Text_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Sql_Text_MemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Sql_Text_MemoMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );

    procedure Sql_Text_SynEditEnter( Sender: TObject );
    procedure Sql_Text_SynEditClick( Sender: TObject );
    procedure Sql_Text_SynEditDropFiles( Sender: TObject; X, Y: Integer; AFiles: TStrings );
    procedure Sql_Text_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Sql_Text_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Sql_Text_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );

    procedure Sql_Text__Highlighter__Syntax__SetMenuItemClick( Sender: TObject );
    procedure Sql_Text__Highlights__Brackets__SetMenuItemClick( Sender: TObject );

    procedure Sql_Text__SynCompletionProposalCodeCompletion( Sender: TObject; var Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
    procedure Sql_Text__SynCompletionProposalAfterCodeCompletion( Sender: TObject; const Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );

    procedure Sql_Text_PopupMenu__MenuItemClick_Common( Sender: TObject );

    procedure Query_Output_Save_Field_FormatKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Data_Preview_DBMemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Sql_Text_PopupMenuPopup( Sender: TObject );

    procedure Sql_Editor_DBGridCellClick( Column: TColumn );
    procedure Sql_Editor_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
    procedure Sql_Editor_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Sql_Editor_DBGridKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Sql_Editor_DBGridTitleClick( Column: TColumn );
  private
    { Private declarations }
    busy_g,
    sql__quotation_sign__use__sef_g,
    sort__direction_ascending_g,
    task_is_running_g
      : boolean;

    code_completion__cursor_position_g,
    id_search__columns_list_g,
    id_search__tablse_list_g,
    sql_editor_db_grid__selected_index_copy_g,
    sql_text_history__index_current_g,
    transactions_count_g
      : integer;

    code_completion__column_list__clear_symbol_g,
    code_completion__column_list__style_g,
    code_completion__table_list_style_g,
    csv__file__name_saved_g,
    database_type__sef_g,
    parent_caption_copy_g,
    sort__column_name_g,
    sql_editor__column_name_add_text__1_g,
    sql_editor__column_name_add_text__2_g,
    sql_editor__select_all_columns_text_g,
    sql_editor__table_name_add_text__1_g,
    sql_editor__table_name_add_text__2_a_g,
    sql_editor__table_name_add_text__2_b_g,
    sql__quotation_sign__sef_g,
    text__file_group_box_caption_copy_g,
    text__file__name_saved_g,
    text__file__path_copy_g,
    text__file__text_copy_g
      : string;

    databases_r_copy_g : Common.TDatabases_r;

    sql_editor__sql_special_word__block_execute__automatic_detection__list_g_t,
    sql_editor__sql_special_word__execute__automatic_detection__list_g_t,
    sql_editor__sql_special_word__transactions_automatic__list_g_t,
    sql_text_history_g_t
      : array of string;

    sql_editor_sdbm : Common.TSDBM;

    busy_notification__knight_rider_equalizer : Migawka_Prostokat_Tabela_2_SDBM.TMigawka_Prostokat_Tabela_2;

    text__search_replace_form : Text__Search_Replace.TText__Search_Replace_Form;

    procedure Busy_Notification_Set( const busy_f : boolean );
    procedure Caret_Position_Display();
    function Close_Block_Check__SEF( var modal_result_f : TModalResult; const message_show_f : boolean = true ) : boolean;
    procedure Column__Values__Distinct();
    procedure Column__Values__Sum();
    procedure Columns_List__All();
    procedure Columns_List__Star( const shift_f : TShiftState );
    procedure Data_Preview();
    procedure Key_Down_Common( Sender : TObject; var Key : Word; Shift : TShiftState );
    procedure Highlights__Brackets_MenuItem__Enabled__Correct();
    procedure Highlighter__Syntax_MenuItem__Check__Correct();
    function Open_Execute( const command_execute_f : boolean; var history_text_f : string; command_execute_parameters_t_f : array of string ) : boolean; overload;
    function Open_Execute( const command_execute_f : boolean; var history_text_f : string; command_execute_parameters_t_f : array of const ) : boolean; overload; //????
    function Parent_Caption__Get() : string;
    procedure Parent_Caption__Set( const text_f : string );
    procedure Parent_Tab_Switch( const prior_f : boolean = false );
    procedure Primary_Column_Find();
    procedure Query_Active_Notification_Set( history_text_f : string = '' );
    function Quotation_Sign__SEF() : string;
    procedure sql__parameterKeyDown( Sender : TObject; var Key : Word; Shift : TShiftState );
    procedure Sql__Parameters__Free();
    procedure sql__text_popup_menuClick( Sender : TObject );
    procedure Transaction_Active_Notification_Set();
  public
    { Public declarations }
    function Finish__SEF( var modal_result_f : TModalResult ) : boolean;
    procedure Highlight__Font__Set__SEF();
    procedure Options_Set__SEF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const queries_open_in_background_f, sql__quotation_sign__use_f : boolean );
    procedure Prepare__SEF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const database_connection__separated_f, queries_open_in_background_f, sql__quotation_sign__use_f : boolean );
    function Task_Running_Check__SEF( const message_show_f : boolean = true ) : boolean;
    procedure Translation__Apply__SEF();
  end;

const
  sql_editor__code_completion__column_list_style__file_name_c : string = 'Sql_Editor__Code_Completion__Column_List__Style.txt';
  sql_editor__code_completion__column_list__clear_symbol__file_name_c : string = 'Sql_Editor__Code_Completion__Column_List__Clear_Symbol.txt';
  sql_editor__code_completion__table_list_style__file_name_c : string = 'Sql_Editor__Code_Completion__Table_List_Style.txt';
  sql_editor__column_name_add_text__1__file_name_c : string = 'Sql_Editor__Column_Name_Add_Text__1.txt';
  sql_editor__column_name_add_text__2__file_name_c : string = 'Sql_Editor__Column_Name_Add_Text__2.txt';
  sql_editor__notification__sign__file_changed_c : string = '*';
  sql_editor__select_all_columns_text__file_name_c : string = 'Sql_Editor__Select_All_Columns_Text.txt';
  sql_editor__sql_special_word__block_execute__automatic_detection__file_name_c : string = 'Sql_Editor__Sql_Special_Word__Block_Execute__Automatic_Detection_List.txt';
  sql_editor__sql_special_word__execute__automatic_detection__file_name_c : string = 'Sql_Editor__Sql_Special_Word__Execute__Automatic_Detection_List.txt';
  sql_editor__sql_special_word__transactions_automatic__file_name_c : string = 'Sql_Editor__Sql_Special_Word__Transactions_Automatic_List.txt';
  sql_editor__table_name_add_text__1__file_name_c : string = 'Sql_Editor__Table_Name_Add_Text__1.txt';
  sql_editor__table_name_add_text__2__a__file_name_c : string = 'Sql_Editor__Table_Name_Add_Text__2__A.txt';
  sql_editor__table_name_add_text__2__b__file_name_c : string = 'Sql_Editor__Table_Name_Add_Text__2__B.txt';

implementation

uses
  System.StrUtils,
  System.Threading,
  System.TypInfo,
  Vcl.Clipbrd,
  Winapi.ShellAPI,

  Shared,
  Text__Search_Replace__Prompt,
  Translation;

{$R *.dfm}

procedure TSql_Editor_F_Frame.Busy_Notification_Set( const busy_f : boolean );
begin

  busy_g := busy_f;


  Caret_Position_Display();


  if busy_f then
    begin

      busy_notification__knight_rider_equalizer.Szerokoœæ_Koryguj();
      busy_notification__knight_rider_equalizer.Tryb_Ustaw( Migawka_Prostokat_Tabela_2_SDBM.mpt2_Migaj );

    end
  else
    busy_notification__knight_rider_equalizer.Tryb_Ustaw( Migawka_Prostokat_Tabela_2_SDBM.mpt2_Mignij );


  Transaction_Active_Notification_Set();

end;

procedure TSql_Editor_F_Frame.Caret_Position_Display();
var
  zts : string;
begin

  if    ( Data_Preview_DBMemo.Height > 1 )
    and (
             ( Data_Preview_DBMemo.Focused )
          or ( Sql_Editor_DBGrid.Focused )
        ) then
    Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Data_Preview_DBMemo.CaretPos.Y + 1 )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Data_Preview_DBMemo.CaretPos.X + 1 )  ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Data_Preview_DBMemo.Lines.Text.Length )  )
  else
    begin

      //Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Sql_Text_Memo.CaretPos.Y + 1 )  ) + ' / ' + Trim(   FormatFloat( '### ### ### ### ### ### ##0', Sql_Text_Memo.CaretPos.X + 1 ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Sql_Text_Memo.Lines.Text.Length )  )   );
      Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Sql_Text_SynEdit.CaretY )  ) + ' / ' + Trim(   FormatFloat( '### ### ### ### ### ### ##0', Sql_Text_SynEdit.CaretX ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Sql_Text_SynEdit.Lines.Text.Length )  )   );

    end;



  if busy_g then
    zts := Common.notification__sign__busy_c
  else
    zts := '';


  if Left_Panel.Width <= 1 then
    zts := ' | ' + Caret_Position_Label.Caption + zts;


  if    (  Trim( text__file__path_copy_g ) <> ''  )
    and ( text__file__text_copy_g <> Sql_Text_SynEdit.Lines.Text ) then
    begin

      zts := zts + sql_editor__notification__sign__file_changed_c;


      if Text__File_GroupBox.Caption <> text__file_group_box_caption_copy_g + Common.notification__sign__busy_c then
        Text__File_GroupBox.Caption := text__file_group_box_caption_copy_g + Common.notification__sign__busy_c;

    end
  else
    if Text__File_GroupBox.Caption <> text__file_group_box_caption_copy_g then
      Text__File_GroupBox.Caption := text__file_group_box_caption_copy_g;


  Parent_Caption__Set( parent_caption_copy_g + zts );

end;

function TSql_Editor_F_Frame.Close_Block_Check__SEF( var modal_result_f : TModalResult; const message_show_f : boolean = true ) : boolean;
begin

  // Result = false - can close, true - should not close.

  if   ( not Common.sql_editor__close_prompt )
    or ( modal_result_f = mrYesToAll ) then
    begin

      Result := false;

      Exit;

    end;



  if   (  Trim( Sql_Text_SynEdit.Lines.Text ) <> ''  )
    //or (
    //         (  Trim( text__file__path_copy_g ) <> ''  )
    //     and ( text__file__text_copy_g <> Sql_Text_SynEdit.Lines.Text )
    //   )
    or (
             ( sql_editor_sdbm <> nil )
         and ( sql_editor_sdbm.Query__Active() )
         and ( sql_editor_sdbm.Query__Record_Count() > 0 )
       ) then
    Result := true
  else
    Result := false;


  if    ( Result )
    and ( message_show_f ) then
    begin

      modal_result_f := Text__Search_Replace__Prompt.Text__Search_Replace__Prompt_Form.Modal_Result__Get( Translation.translation__messages_r.sql_editor_contains_data__continue_ );


      if modal_result_f in [ mrYes, mrYesToAll ] then
        Result := false;

    end;

end;

procedure TSql_Editor_F_Frame.Column__Values__Distinct();
var
  items_count_l : integer;

  zts : string;
begin

  if Self.Task_Running_Check__SEF() then
    Exit;


  if   ( sql_editor_sdbm = nil )
    or ( not sql_editor_sdbm.Query__Active() )
    or ( sql_editor_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  if not Queries_Open_In_Background_MenuItem.Checked then
    begin

      Screen.Cursor := crSQLWait;

      Busy_Notification_Set( true );

      Application.ProcessMessages();


      zts := Common.Column__Values__Distinct__Processing( sql_editor_sdbm, Sql_Editor_DBGrid, items_count_l, Sql_ProgressBar, true );


      Sql_Editor_DBGrid.SetFocus();


      Log_Memo.Lines.Add(   Translation.translation__messages_r.items_count + ' ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', items_count_l )  ) + ':'   );
      Log_Memo.Lines.AddStrings( zts );


      Busy_Notification_Set( false );

      Screen.Cursor := crDefault;


      ShowMessage(  Translation.translation__messages_r.items_count + ' ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', items_count_l )  ) + ':' + #13 + zts   );

    end
  else
    begin

      task_is_running_g := true;


      Busy_Notification_Set( true );


      System.Threading.TTask.Run
        (
          procedure
            begin

              zts := Common.Column__Values__Distinct__Processing( sql_editor_sdbm, Sql_Editor_DBGrid, items_count_l, Sql_ProgressBar );


              TThread.Synchronize
                (
                  TThread.Current,
                  procedure
                    begin

                      Sql_Editor_DBGrid.SetFocus();


                      Log_Memo.Lines.Add(   Translation.translation__messages_r.items_count + ' ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', items_count_l )  ) + ':'   );
                      Log_Memo.Lines.AddStrings( zts );


                      task_is_running_g := false;

                      Busy_Notification_Set( false );


                      ShowMessage(  Translation.translation__messages_r.items_count + ' ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', items_count_l )  ) + ':' + #13 + zts   );

                    end
                );

            end
        );

    end;

end;

procedure TSql_Editor_F_Frame.Column__Values__Sum();
var
  ztc : currency;

  error_message_l : string;
begin

  if Self.Task_Running_Check__SEF() then
    Exit;


  if   ( sql_editor_sdbm = nil )
    or ( not sql_editor_sdbm.Query__Active() )
    or ( sql_editor_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  //try
  //  sql_editor_sdbm.Query__Field_By_Name( Sql_Editor_DBGrid.SelectedField.FieldName ).AsCurrency;
  //except
  //  on E : Exception do
  //    begin
  //
  //      Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_read_column_value_as_a_number + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
  //      Exit;
  //
  //    end;
  //end;


  if not Queries_Open_In_Background_MenuItem.Checked then
    begin

      Screen.Cursor := crSQLWait;

      Busy_Notification_Set( true );

      Application.ProcessMessages();


      ztc := Common.Column__Values__Sum__Processing( sql_editor_sdbm, Sql_Editor_DBGrid, error_message_l, Sql_ProgressBar, true );


      Sql_Editor_DBGrid.SetFocus();


      Log_Memo.Lines.Add(  FloatToStr(  ztc )  );
      Log_Memo.Lines.Add(   Trim(  FormatFloat( '### ### ### ### ### ### ##0.##############', ztc )  )   );


      Busy_Notification_Set( false );

      Screen.Cursor := crDefault;


      if Trim( error_message_l ) <> '' then
        ShowMessage( Translation.translation__messages_r.failed_to_read_column_value_as_a_number + #13 + error_message_l + '.' );

    end
  else
    begin

      task_is_running_g := true;


      Busy_Notification_Set( true );


      System.Threading.TTask.Run
        (
          procedure
            begin

              ztc := Common.Column__Values__Sum__Processing( sql_editor_sdbm, Sql_Editor_DBGrid, error_message_l, Sql_ProgressBar );


              TThread.Synchronize
                (
                  TThread.Current,
                  procedure
                    begin

                      Sql_Editor_DBGrid.SetFocus();


                      Log_Memo.Lines.Add(  FloatToStr(  ztc )  );
                      Log_Memo.Lines.Add(   Trim(  FormatFloat( '### ### ### ### ### ### ##0.##############', ztc )  )   );


                      task_is_running_g := false;

                      Busy_Notification_Set( false );


                      if Trim( error_message_l ) <> '' then
                        ShowMessage( Translation.translation__messages_r.failed_to_read_column_value_as_a_number + #13 + error_message_l + '.' );

                    end
                );

            end
        );

    end;

end;

procedure TSql_Editor_F_Frame.Columns_List__All();
var
  i : integer;
begin

  for i := 0 to Columns_List_ListBox.Items.Count - 1 do
    begin

      Columns_List_ListBox.ItemIndex := i;


      if Columns_List_ListBox.Items[ i ] <> sql_editor__select_all_columns_text_g then
        Columns_List_ListBoxDblClick( nil );

    end;

end;

procedure TSql_Editor_F_Frame.Columns_List__Star( const shift_f : TShiftState );
begin

  Columns_List_ListBox.ItemIndex := 0;

  Columns_List_ListBoxDblClick( nil );


  if shift_f = [ ssCtrl ] then
    Tables_List_ListBoxDblClick( nil );

end;

procedure TSql_Editor_F_Frame.Data_Preview();
begin

  Sql_Editor_Column_DBEditChange( nil ); // If the 'primary column' has the same values.


  if Data_Preview_DBMemo.Height <= 1 then
    Exit;


  if    ( sql_editor_sdbm <> nil )
    and ( sql_editor_sdbm.Query__Active() )
    and ( sql_editor_sdbm.Query__Record_Count > 0 )
    and ( Sql_Editor_DBGrid.SelectedField <> nil ) then
    try
      Data_Preview_DBMemo.DataField := Sql_Editor_DBGrid.SelectedField.FieldName;
    except
      on E : Exception do
        Log_Memo.Lines.Text := Translation.translation__messages_r.failed_to_preview_value + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext );
    end;

end;

function TSql_Editor_F_Frame.Finish__SEF( var modal_result_f : TModalResult ) : boolean;
begin

  if Self.Task_Running_Check__SEF() then
    begin

      Result := false;

      Exit;

    end
  else
    Result := not Close_Block_Check__SEF( modal_result_f );

  if not Result then
    Exit;


  Common.Text__Search_Replace__Syn_Edit__Set( nil, text__search_replace_form );
  Common.Text__Search_Replace__Hide( text__search_replace_form );


  SetLength( sql_text_history_g_t, 0 );

  FreeAndNil( sql_editor_sdbm );

  FreeAndNil( busy_notification__knight_rider_equalizer );

  if text__search_replace_form <> nil then
    FreeAndNil( text__search_replace_form );


  Sql__Parameters__Free();


  Winapi.ShellAPI.DragAcceptFiles( Sql_Text_SynEdit.Handle, false );

end;

procedure TSql_Editor_F_Frame.Highlight__Font__Set__SEF();
begin

  Common.Font__Set( Data_Preview_DBMemo.Font, Common.sql_editor__font );
  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );
  //Common.Font__Set( Sql_Text_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Sql_Text_SynEdit.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    begin

      Common.Font__Set( Columns_List_ListBox.Font, Common.sql_editor__font );
      Common.Font__Set( Sql_Editor_DBGrid.Font, Common.sql_editor__font );
      Common.Font__Set( Tables_List_ListBox.Font, Common.sql_editor__font );

    end;

  Common.Syn_Edit__Parameters__Set( Sql_Text_SynEdit );

  Common.Syn_Edit__Search_Text_Hightlighter_Syn_Edit_Plugin__Create( Sql_Text_SynEdit );


  Highlights__Brackets__All_Pairs_MenuItem.Checked := Common.sql_editor__highlights__syntax__brackets__all_pairs;
  Highlights__Brackets__Angle_MenuItem.Checked := Common.sql_editor__highlights__syntax__brackets__angle;
  Highlights__Brackets__Curly_MenuItem.Checked := Common.sql_editor__highlights__syntax__brackets__curly;
  Highlights__Brackets__Marked_Only_MenuItem.Checked := Common.sql_editor__highlights__syntax__brackets__marked_only;
  Highlights__Brackets__Round_MenuItem.Checked := Common.sql_editor__highlights__syntax__brackets__round;
  Highlights__Brackets__Square_MenuItem.Checked := Common.sql_editor__highlights__syntax__brackets__square;

  Highlights__Brackets_MenuItem__Enabled__Correct();
  Highlighter__Syntax_MenuItem__Check__Correct();

end;

procedure TSql_Editor_F_Frame.Key_Down_Common( Sender : TObject; var Key : Word; Shift : TShiftState );
begin

  // E.
  if    ( Key = 69 )
    and ( Shift = [ ssCtrl, ssShift ] ) then
    Open_ButtonClick( Execute_Button )
  else
  // E.
  if    ( Key = 69 )
    and ( Shift = [ ssCtrl ] ) then
    Open_ButtonClick( Sender )
  else
  // L.
  if    ( Key = 76 )
    and ( Shift = [ ssCtrl ] ) then
    Text__File__Load_ButtonClick( Sender )
  else
  // N.
  if    ( Key = 78 )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Key := 0;

      Sql__Next_ButtonClick( Sender );

    end
  else
  // O.
  if    ( Key = 79 )
    and ( Shift = [ ssCtrl ] ) then
    Text__File__Find_ButtonClick( Sender )
  else
  // P.
  if    ( Key = 80 )
    and ( Shift = [ ssCtrl ] ) then
    Sql__Prior_ButtonClick( Sender )
  else
  // R.
  if    ( Key = 82 )
    and ( Shift = [ ssCtrl ] ) then
    Refresh_ButtonClick( Sender )
  else
  // S.
  if    ( Key = 83 )
    and ( Shift = [ ssCtrl, ssShift ] ) then
    begin

      if not Keyboard__Shortcuts__Switch__Output_Save__With__Text_File_Save_MenuItem.Checked then
        Text__File__Save_ButtonClick( Sender )
      else
        Output_Save_ButtonClick( Sender );

    end
  else
  // S.
  if    ( Key = 83 )
    and ( Shift = [ ssCtrl ] ) then
    begin

      if not Keyboard__Shortcuts__Switch__Output_Save__With__Text_File_Save_MenuItem.Checked then
        Output_Save_ButtonClick( Sender )
      else
        Text__File__Save_ButtonClick( Sender );

    end
  else
  // T.
  if    ( Key = 84 )
    and ( Shift = [ ssCtrl ] ) then
    begin

      if Left_Panel.Width <= 1 then
        begin

          Left_Panel.Width := 185;

          Sql_Text_Panel.Height := 300;

        end
      else
        begin

          Buttons_Panel__Hide_ButtonClick( Sender );

          Sql_Text_Panel.Height := Self.Height - Sql_Text_Horizontal_Splitter.Height;

        end;

    end;

end;

procedure TSql_Editor_F_Frame.Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );
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

procedure TSql_Editor_F_Frame.Highlights__Brackets_MenuItem__Enabled__Correct();
begin

  Highlights__Brackets__All_Pairs_MenuItem.Enabled := not Highlights__Brackets__Marked_Only_MenuItem.Checked;
  Highlights__Brackets__Angle_MenuItem.Enabled := not Highlights__Brackets__Marked_Only_MenuItem.Checked;
  Highlights__Brackets__Curly_MenuItem.Enabled := not Highlights__Brackets__Marked_Only_MenuItem.Checked;
  Highlights__Brackets__Round_MenuItem.Enabled := not Highlights__Brackets__Marked_Only_MenuItem.Checked;
  Highlights__Brackets__Square_MenuItem.Enabled := not Highlights__Brackets__Marked_Only_MenuItem.Checked;

end;

procedure TSql_Editor_F_Frame.Highlighter__Syntax_MenuItem__Check__Correct();
var
  i : integer;
begin

  for i := 0 to Highlighter__Syntax_MenuItem.Count - 1 do
    Highlighter__Syntax_MenuItem.Items[ i ].Checked := false;


  if Sql_Text_SynEdit.Highlighter <> nil then
    begin

      for i := 0 to Highlighter__Syntax_MenuItem.Count - 1 do
        if Highlighter__Syntax_MenuItem.Items[ i ].Hint = Sql_Text_SynEdit.Highlighter.Name then
          begin

            Highlighter__Syntax_MenuItem.Items[ i ].Checked := true;

            Break;

          end;

    end
  else
    if Highlighter__Syntax_MenuItem.Count > 0 then
      Highlighter__Syntax_MenuItem.Items[ 0 ].Checked := true;

end;

function TSql_Editor_F_Frame.Open_Execute( const command_execute_f : boolean; var history_text_f : string; command_execute_parameters_t_f : array of string ) : boolean;

  function Sql__Block_Execute_Check( const sql_text_f : string ) : boolean;
  var
    i_l : integer;
  begin

    Result := false;


    if not Block_Execute__Automatic_Detection_MenuItem.Checked then
      Exit;


    for i_l := 0 to Length( sql_editor__sql_special_word__block_execute__automatic_detection__list_g_t ) - 1 do
      if Pos( sql_editor__sql_special_word__block_execute__automatic_detection__list_g_t[ i_l ], sql_text_f ) > 0 then
        begin

          Result := true;

          Exit;

        end;

  end;

  function Sql__Command__Comments_Delete( sql_text_f : string ) : string;
  var
    sql__comment_occurred_l,
    sql__text_separator_occurred_l
      : boolean;

    i_l : integer;
  begin

    // Result is the sql command without comments.

    Result := '';

    sql__comment_occurred_l := false;
    sql__text_separator_occurred_l := false;

    while Length( sql_text_f ) > 0 do
      begin

        if    ( not sql__text_separator_occurred_l )
          and ( not sql__comment_occurred_l )
          and (  Pos( Common.sql__comment__line, sql_text_f ) = 1  ) then
          begin

            i_l := Pos( #10, sql_text_f );

            if Pos( #13, sql_text_f ) > i_l then
              i_l := Pos( #13, sql_text_f );

            if i_l > 0 then
              Delete( sql_text_f, 1, i_l ) // Delete whole line.
            else
              Exit;

          end
        else
        if Pos( Common.sql__text_separator, sql_text_f ) = 1 then
          begin

            sql__text_separator_occurred_l := not sql__text_separator_occurred_l;

            Result := Result + Copy(  sql_text_f, 1, Length( Common.sql__text_separator )  );

            Delete(  sql_text_f, 1, Length( Common.sql__text_separator )  );

          end
        else
        if    ( not sql__text_separator_occurred_l )
          and ( not sql__comment_occurred_l )
          and (  Pos( Common.sql__comment__begin, sql_text_f ) = 1  ) then
          begin

            sql__comment_occurred_l := true;

            Delete(  sql_text_f, 1, Length( Common.sql__comment__begin )  );

          end
        else
        if    ( not sql__text_separator_occurred_l )
          and ( sql__comment_occurred_l )
          and (  Pos( Common.sql__comment__end, sql_text_f ) = 1  ) then
          begin

            sql__comment_occurred_l := false;

            Delete(  sql_text_f, 1, Length( Common.sql__comment__end )  );

          end
        else
          begin

            if not sql__comment_occurred_l then
              Result := Result + sql_text_f[ 1 ];


            Delete( sql_text_f, 1, 1 );

          end;

      end;

  end;

  function Sql__Command__Divide_By_Separator( sql_text_f : string ) : integer;
  var
    sql_text_separator_occurred_l : boolean;

    i_l : integer;
  begin

    // Result is the position of the separator.

    Result := -1; // Sql has only one command.


    if Sql__Block_Execute_Check( sql_text_f ) then
      Exit;


    i_l := 0;
    sql_text_separator_occurred_l := false;

    while Length( sql_text_f ) > 0 do
      begin

        inc( i_l );

        if    ( not sql_text_separator_occurred_l )
          and (  Pos( Common.sql__command_separator, sql_text_f ) = 1  ) then
          begin

            // Sql separated command.

            if Trim(   Copy(  sql_text_f, 2, Length( sql_text_f )  )   ) <> '' then
              Result := i_l
            else
              Break; // Only one sql command with the separator at the end.


            Exit;

          end
        else
          if Pos( Common.sql__text_separator, sql_text_f ) = 1 then
            sql_text_separator_occurred_l := not sql_text_separator_occurred_l;


        Delete( sql_text_f, 1, 1 );

      end;

  end;

var
  error_occurred : boolean;

  i : integer;

  error_message_l,
  sql_command_copy_l,
  sql_command_copy__for_history_text_l
    : string;
begin

  Result := true; // Result is true if no errors occurred.

  history_text_f := '';


  if not command_execute_f then
    sql_editor_sdbm.Query__Open()
  else
    begin

      // It works to execute only one command at a time. //???
      //sql_editor_sdbm.Sql_Command_Execute( sql_editor_sdbm.Query__Sql__Get(), zt_var_rec_t, 'Failed to execute command.' );


      sql_command_copy_l := sql_editor_sdbm.Query__Sql__Get();

      sql_command_copy__for_history_text_l := sql_command_copy_l;

      if Comments_Delete_CheckBox.Checked then
        sql_command_copy_l := Sql__Command__Comments_Delete( sql_command_copy_l );

      i := Sql__Command__Divide_By_Separator( sql_command_copy_l );

      if i <= 0 then
        begin

          // Sql has only one command.

          Result := sql_editor_sdbm.Sql_Command_Execute( sql_editor_sdbm.Query__Sql__Get(), command_execute_parameters_t_f, error_message_l, Translation.translation__messages_r.failed_to_execute_command, Ado_Command_Param_Check_CheckBox.Checked );

          if Result then
            history_text_f := sql_editor_sdbm.Query__Sql__Get()
          else
            begin

              if Trim( error_message_l ) <> '' then
                Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

            end;

        end
      else
        begin

          // Sql has multiple commands.

          error_occurred := false;


          sql_editor_sdbm.Operation_Duration__Calculating_Type__Set( Common.odct_multi_command );


          while i > 0 do
            begin

              error_message_l := Copy( sql_command_copy_l, 1, i ); // Here temporarily as the sql command.

              Delete( sql_command_copy_l, 1, i );


              sql_editor_sdbm.Query__Sql__Set( error_message_l );

              if not sql_editor_sdbm.Sql_Command_Execute( sql_editor_sdbm.Query__Sql__Get(), command_execute_parameters_t_f, error_message_l, Translation.translation__messages_r.failed_to_execute_command, Ado_Command_Param_Check_CheckBox.Checked ) then
                begin

                  if not error_occurred then
                    error_occurred := true;


                  if Trim( error_message_l ) <> '' then
                    Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

                end;


              i := Sql__Command__Divide_By_Separator( sql_command_copy_l );

            end;


          if Trim( sql_command_copy_l ) <> '' then
            begin

              sql_editor_sdbm.Query__Sql__Set( sql_command_copy_l );

              if not sql_editor_sdbm.Sql_Command_Execute( sql_editor_sdbm.Query__Sql__Get(), command_execute_parameters_t_f, error_message_l, Translation.translation__messages_r.failed_to_execute_command, Ado_Command_Param_Check_CheckBox.Checked ) then
                begin

                  if not error_occurred then
                    error_occurred := true;


                  if Trim( error_message_l ) <> '' then
                    Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

                end;

            end;


          sql_editor_sdbm.Query__Sql__Set( '' );


          if not error_occurred then
            history_text_f := sql_command_copy__for_history_text_l
          else
            Result := false;

        end;

    end;

end;

function TSql_Editor_F_Frame.Open_Execute( const command_execute_f : boolean; var history_text_f : string; command_execute_parameters_t_f : array of const ) : boolean;

  function Sql__Command__Comments_Delete( sql_text_f : string ) : string;
  var
    sql__comment_occurred_l,
    sql__text_separator_occurred_l
      : boolean;

    i_l : integer;
  begin

    // Result is the sql command without comments.

    Result := '';

    sql__comment_occurred_l := false;
    sql__text_separator_occurred_l := false;

    while Length( sql_text_f ) > 0 do
      begin

        if    ( not sql__text_separator_occurred_l )
          and ( not sql__comment_occurred_l )
          and (  Pos( Common.sql__comment__line, sql_text_f ) = 1  ) then
          begin

            i_l := Pos( #10, sql_text_f );

            if Pos( #13, sql_text_f ) > i_l then
              i_l := Pos( #13, sql_text_f );

            if i_l > 0 then
              Delete( sql_text_f, 1, i_l ) // Delete whole line.
            else
              Exit;

          end
        else
        if Pos( Common.sql__text_separator, sql_text_f ) = 1 then
          begin

            sql__text_separator_occurred_l := not sql__text_separator_occurred_l;

            Result := Result + Copy(  sql_text_f, 1, Length( Common.sql__text_separator )  );

            Delete(  sql_text_f, 1, Length( Common.sql__text_separator )  );

          end
        else
        if    ( not sql__text_separator_occurred_l )
          and ( not sql__comment_occurred_l )
          and (  Pos( Common.sql__comment__begin, sql_text_f ) = 1  ) then
          begin

            sql__comment_occurred_l := true;

            Delete(  sql_text_f, 1, Length( Common.sql__comment__begin )  );

          end
        else
        if    ( not sql__text_separator_occurred_l )
          and ( sql__comment_occurred_l )
          and (  Pos( Common.sql__comment__end, sql_text_f ) = 1  ) then
          begin

            sql__comment_occurred_l := false;

            Delete(  sql_text_f, 1, Length( Common.sql__comment__end )  );

          end
        else
          begin

            if not sql__comment_occurred_l then
              Result := Result + sql_text_f[ 1 ];


            Delete( sql_text_f, 1, 1 );

          end;

      end;

  end;

  function Sql__Command__Divide_By_Separator( sql_text_f : string ) : integer;
  var
    sql_text_separator_occurred_l : boolean;

    i_l : integer;
  begin

    // Result is the position of the separator.

    Result := -1; // Sql has only one command.

    i_l := 0;
    sql_text_separator_occurred_l := false;

    while Length( sql_text_f ) > 0 do
      begin

        inc( i_l );

        if    ( not sql_text_separator_occurred_l )
          and (  Pos( Common.sql__command_separator, sql_text_f ) = 1  ) then
          begin

            // Sql separated command.

            if Trim(   Copy(  sql_text_f, 2, Length( sql_text_f )  )   ) <> '' then
              Result := i_l
            else
              Break; // Only one sql command with the separator at the end.


            Exit;

          end
        else
          if Pos( Common.sql__text_separator, sql_text_f ) = 1 then
            sql_text_separator_occurred_l := not sql_text_separator_occurred_l;


        Delete( sql_text_f, 1, 1 );

      end;

  end;

var
  error_occurred : boolean;

  i : integer;

  error_message_l,
  sql_command_copy_l,
  sql_command_copy__for_history_text_l
    : string;
begin

  // Unused.

  Result := true; // Result is true if no errors occurred.

  history_text_f := '';


  if not command_execute_f then
    sql_editor_sdbm.Query__Open()
  else
    begin

      // It works to execute only one command at a time. //???
      //sql_editor_sdbm.Sql_Command_Execute( sql_editor_sdbm.Query__Sql__Get(), zt_var_rec_t, 'Failed to execute command.' );


      sql_command_copy_l := sql_editor_sdbm.Query__Sql__Get();

      sql_command_copy__for_history_text_l := sql_command_copy_l;

      if Comments_Delete_CheckBox.Checked then
        sql_command_copy_l := Sql__Command__Comments_Delete( sql_command_copy_l );

      i := Sql__Command__Divide_By_Separator( sql_command_copy_l );

      if i <= 0 then
        begin

          // Sql has only one command.

          Result := sql_editor_sdbm.Sql_Command_Execute( sql_editor_sdbm.Query__Sql__Get(), command_execute_parameters_t_f, error_message_l, Translation.translation__messages_r.failed_to_execute_command, Ado_Command_Param_Check_CheckBox.Checked );

          if Result then
            history_text_f := sql_editor_sdbm.Query__Sql__Get()
          else
            begin

              if Trim( error_message_l ) <> '' then
                Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

            end;

        end
      else
        begin

          // Sql has multiple commands.

          error_occurred := false;


          sql_editor_sdbm.Operation_Duration__Calculating_Type__Set( Common.odct_multi_command );


          while i > 0 do
            begin

              error_message_l := Copy( sql_command_copy_l, 1, i ); // Here temporarily as the sql command.

              Delete( sql_command_copy_l, 1, i );


              sql_editor_sdbm.Query__Sql__Set( error_message_l );

              if not sql_editor_sdbm.Sql_Command_Execute( sql_editor_sdbm.Query__Sql__Get(), command_execute_parameters_t_f, error_message_l, Translation.translation__messages_r.failed_to_execute_command, Ado_Command_Param_Check_CheckBox.Checked ) then
                begin

                  if not error_occurred then
                    error_occurred := true;


                  if Trim( error_message_l ) <> '' then
                    Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

                end;


              i := Sql__Command__Divide_By_Separator( sql_command_copy_l );

            end;


          if Trim( sql_command_copy_l ) <> '' then
            begin

              sql_editor_sdbm.Query__Sql__Set( sql_command_copy_l );

              if not sql_editor_sdbm.Sql_Command_Execute( sql_editor_sdbm.Query__Sql__Get(), command_execute_parameters_t_f, error_message_l, Translation.translation__messages_r.failed_to_execute_command, Ado_Command_Param_Check_CheckBox.Checked ) then
                begin

                  if not error_occurred then
                    error_occurred := true;


                  if Trim( error_message_l ) <> '' then
                    Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

                end;

            end;


          sql_editor_sdbm.Query__Sql__Set( '' );


          if not error_occurred then
            history_text_f := sql_command_copy__for_history_text_l
          else
            Result := false;

        end;

    end;

end;

procedure TSql_Editor_F_Frame.Options_Set__SEF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const queries_open_in_background_f, sql__quotation_sign__use_f : boolean );
var
  zti : integer;

  zts : string;

  zt_sdbm : Common.TSDBM;
begin

  sql__quotation_sign__use__sef_g := sql__quotation_sign__use_f;
  sql__quotation_sign__sef_g := sql__quotation_sign_f;

  Ado_Command_Param_Check_CheckBox.Visible := component_type_f = Common.ct_ADO;
  Ado_Command_Param_Check_MenuItem.Visible := Ado_Command_Param_Check_CheckBox.Visible;
  Queries_Open_In_Background_MenuItem.Checked := queries_open_in_background_f;


  if sql_editor_sdbm <> nil then
    begin

      sql_editor_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

      sql_editor_sdbm.Data_Source__Data_Set__Set( Sql_Editor_DataSource );


      if not sql_editor_sdbm.Connected() then // E.g. when the connection type changes.
        Database__Reconnect_MenuItemClick( nil );


      {$region 'Tables.'}
      Screen.Cursor := crHourGlass;


      Tables_List_ListBox.Items.Clear();
      Columns_List_ListBox.Items.Clear();

      zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + Common.tables_list__file_name_c  );

      if Trim( zts ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + Common.tables_list__file_name_c + ').' );

          zts :=
            'select RDB$RELATIONS.RDB$RELATION_NAME as TABLE_NAME ' +
            '     , RDB$RELATIONS.RDB$SECURITY_CLASS ' +
            '     , cast(  substring( RDB$RELATIONS.RDB$SECURITY_CLASS from 5 for 5 ) as integer  ) as ID ' +
            'from RDB$RELATIONS ' +
            'where RDB$RELATIONS.RDB$SECURITY_CLASS is not null ' +
            '  and RDB$RELATIONS.RDB$SECURITY_CLASS <> ''SQL$1'' ' +
            '  and RDB$RELATIONS.RDB$SECURITY_CLASS <> ''SQL$2'' ' +
            '  and RDB$RELATIONS.RDB$SECURITY_CLASS <> ''SQL$3'' ' +
            '  and RDB$RELATIONS.RDB$VIEW_BLR is null ' +
            '  and ( ' +
            '           RDB$RELATIONS.RDB$RELATION_NAME not like ''%$%'' ' +
            '        or 1 = :system_tables_visible ' +
            '      ) ' +
            'order by RDB$RELATIONS.RDB$RELATION_NAME ';

        end;


      zt_sdbm := Common.TSDBM.Create( sql_editor_sdbm );
      zt_sdbm.Component_Type_Set( sql_editor_sdbm.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

      zt_sdbm.Query__Sql__Set( zts );

      if Common.system_tables_visible then
        zti := 1
      else
        zti := 0;

      zt_sdbm.Query__Param_By_Name__Set( Common.tables_list__system_tables_visible__parameter_name_c, zti, Log_Memo );

      try
        zt_sdbm.Query__Open();
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_load_tables_list_ + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;

      if zt_sdbm.Query__Active() then
        begin

          try
            zt_sdbm.Query__Field_By_Name( Common.name__table__big_letters_c ).AsString;
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                zt_sdbm.Query__Close();

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_table_name_ + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

              end;
          end;


          if zt_sdbm.Query__Active() then
            begin

              while not zt_sdbm.Query__Eof() do
                begin

                  Tables_List_ListBox.Items.Add(   Trim(  zt_sdbm.Query__Field_By_Name( Common.name__table__big_letters_c ).AsString  )   ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

                  zt_sdbm.Query__Next();

                end;

            end;


          zt_sdbm.Query__Close();

        end;


      if zt_sdbm.Query__Active() then
        zt_sdbm.Query__Close();

      FreeAndNil( zt_sdbm );


      if Tables_List_ListBox.Items.Count > 0 then
        Tables_List_ListBox.ItemIndex := 0;


      Screen.Cursor := crDefault;
      {$endregion 'Tables.'}


      Tables_List_ListBoxClick( nil );

    end;


  Query_Active_Notification_Set();


  Self.Translation__Apply__SEF();

end;

function TSql_Editor_F_Frame.Parent_Caption__Get() : string;
begin

  if    ( Self.Parent <> nil )
    and ( Self.Parent is TTabSheet ) then
    Result := TTabSheet(Self.Parent).Caption
  else
    Result := '';

end;

procedure TSql_Editor_F_Frame.Parent_Caption__Set( const text_f : string );
begin

  if    ( Self.Parent <> nil )
    and ( Self.Parent is TTabSheet ) then
    TTabSheet(Self.Parent).Caption := text_f;

end;

procedure TSql_Editor_F_Frame.Parent_Tab_Switch( const prior_f : boolean = false );
var
  zti : integer;
begin

  if    ( Self.Parent <> nil )
    and ( Self.Parent is TTabSheet )
    and ( Self.Parent.Parent <> nil )
    and ( Self.Parent.Parent is TPageControl )
    and ( TPageControl(Self.Parent.Parent).PageCount > 1 ) then
    begin

      zti := TPageControl(Self.Parent.Parent).ActivePageIndex;


      if not prior_f then
        begin

          // Next.

          inc( zti );

          if zti > TPageControl(Self.Parent.Parent).PageCount - 1 then
            zti := 0;

        end
      else
        begin

          // Prior.

          dec( zti );

          if zti < 0 then
            zti := TPageControl(Self.Parent.Parent).PageCount - 1;

        end;


      TPageControl(Self.Parent.Parent).ActivePageIndex := zti;

    end;

end;

procedure TSql_Editor_F_Frame.Prepare__SEF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const database_connection__separated_f, queries_open_in_background_f, sql__quotation_sign__use_f : boolean );

  function Newline_Characters_Delete( const text_f : string ) : string;
  begin

    Result := System.StrUtils.ReverseString( text_f );


    while (  Length( Result ) > 0  )
      and (
               ( Result[ 1 ] = #10 )
            or ( Result[ 1 ] = #13 )
          ) do
      Delete( Result, 1, 1 );


    Result := System.StrUtils.ReverseString( Result );

  end;

var
  zti_1,
  zti_2
    : integer;

  zts_1,
  zts_2
    : string;

  zt_string_list : TStringList;

  zt_menu_item : TMenuItem;
begin

  Self.Name := '';

  code_completion__cursor_position_g := -1;
  csv__file__name_saved_g := '';
  id_search__columns_list_g := -1;
  id_search__tablse_list_g := -1;
  database_type__sef_g := databases_r_f.database_type;
  busy_g := false;
  sort__column_name_g := '';
  sort__direction_ascending_g := true;
  sql_editor_db_grid__selected_index_copy_g := 0;
  SetLength( sql_editor__sql_special_word__block_execute__automatic_detection__list_g_t, 0 );
  SetLength( sql_editor__sql_special_word__execute__automatic_detection__list_g_t, 0 );
  SetLength( sql_editor__sql_special_word__transactions_automatic__list_g_t, 0 );
  SetLength( sql_text_history_g_t, 0 );
  sql_text_history__index_current_g := -1;
  task_is_running_g := false;
  text__file_group_box_caption_copy_g := '';
  text__file__name_saved_g := '';
  text__file__path_copy_g := '';
  text__file__text_copy_g := '';
  text__search_replace_form := nil;
  transactions_count_g := 0;


  Bookmarks__Toggle__With__Line_Color_MenuItem.Checked := Common.sql_editor__bookmarks__toggle__with__line_color;
  Comments_Delete_CheckBox.Checked := Common.sql_editor__comments_delete;
  Comments_Delete_MenuItem.Checked := Comments_Delete_CheckBox.Checked;
  Csv__File__Data_Separator_Edit.Text := Common.csv__file__data_separator;
  Csv__File__Text_Qualifier_Edit.Text := Common.csv__file__text_qualifier;
  Data_Preview_DBMemo.Height := 1;
  Database__Reconnect_MenuItem.Visible := database_connection__separated_f;
  Keyboard__Shortcuts__Switch__Output_Save__With__Text_File_Save_MenuItem.Checked := Common.sql_editor__keyboard__shortcuts__switch__output_save__with__text_file_save;
  Queries_Open_In_Background_MenuItem.Checked := queries_open_in_background_f;
  Sql_Parameters_ScrollBox.Width := 1;
  Tables_List_ListBox.Height := Round( Tables_Columns_List_Panel.Height * 0.5 ) - Tables_List_Horizontal_Splitter.Height;

  Ado_Command_Param_Check_MenuItem.Checked := Ado_Command_Param_Check_CheckBox.Checked;
  Block_Execute__Automatic_Detection_MenuItem.Checked := Common.sql_editor__block_execute__automatic_detection;
  Execute__Automatic_Detection_CheckBox.Checked := Common.sql_editor__execute__automatic_detection;
  Execute__Automatic_Detection_MenuItem.Checked := Execute__Automatic_Detection_CheckBox.Checked;
  Execute__Selected_MenuItem.Checked := Common.sql_editor__execute__selected;
  Query_Output_Save_Field_Format__Date_Edit.Text := Common.sql_editor__query_output_save_field_format__date;
  Query_Output_Save_Field_Format__Date__Use_CheckBox.Checked := Trim( Query_Output_Save_Field_Format__Date_Edit.Text ) <> '';
  Query_Output_Save_Field_Format__Real_Numbers_Edit.Text := Common.sql_editor__query_output_save_field_format__real_numbers;
  Query_Output_Save_Field_Format__Real_Numbers__Use_CheckBox.Checked := Trim( Query_Output_Save_Field_Format__Real_Numbers_Edit.Text ) <> '';
  Query_Output_Save_Field_Format__Separator__Date_Time_Edit.Text := Common.sql_editor__query_output_save_field_format__separator__date_time;
  Query_Output_Save_Field_Format__Separator__Decimal_Edit.Text := Common.sql_editor__query_output_save_field_format__separator__decimal;
  Query_Output_Save_Field_Format__Time_Edit.Text := Common.sql_editor__query_output_save_field_format__time;
  Query_Output_Save_Field_Format__Time__Use_CheckBox.Checked := Trim( Query_Output_Save_Field_Format__Time_Edit.Text ) <> '';
  Transactions_Automatic_CheckBox.Checked := Common.sql_editor__transactions_automatic;
  Transactions_Automatic_MenuItem.Checked := Transactions_Automatic_CheckBox.Checked;


  busy_notification__knight_rider_equalizer := Migawka_Prostokat_Tabela_2_SDBM.TMigawka_Prostokat_Tabela_2.Create( Self );


  sql_editor_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f, database_connection__separated_f );

  if database_connection__separated_f then
    begin

      sql_editor_sdbm.Connection__Open( databases_r_f, Log_Memo, component_type_f );

      databases_r_copy_g := databases_r_f;

    end;


  sql_editor__select_all_columns_text_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__select_all_columns_text__file_name_c  );
  sql_editor__select_all_columns_text_g := Newline_Characters_Delete( sql_editor__select_all_columns_text_g );

  if Trim( sql_editor__select_all_columns_text_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__select_all_columns_text__file_name_c + ').' );

      sql_editor__select_all_columns_text_g := '*';

    end;

  Log_Memo.Lines.Add( 'Select all columns text: ' + sql_editor__select_all_columns_text_g + '.' );


  parent_caption_copy_g := Parent_Caption__Get();
  Tab_Name_Edit.Text := parent_caption_copy_g;



  for zti_1 := 0 to 9 do
    begin

      zt_menu_item := TMenuItem.Create( Application );
      zt_menu_item.Caption := zti_1.ToString();
      zt_menu_item.OnClick := Sql_Text_PopupMenu__MenuItemClick_Common;

      Bookmarks__Toggle_MenuItem.Add( zt_menu_item );


      zt_menu_item := TMenuItem.Create( Application );
      zt_menu_item.Caption := zti_1.ToString();
      zt_menu_item.OnClick := Sql_Text_PopupMenu__MenuItemClick_Common;

      Bookmarks__Go_To_MenuItem.Add( zt_menu_item );

    end;



  Self.Options_Set__SEF( component_type_f, databases_r_f.sql__quotation_sign, Queries_Open_In_Background_MenuItem.Checked, sql__quotation_sign__use_f );


  zts_1 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__sql_special_word__block_execute__automatic_detection__file_name_c  );


  if Trim( zts_1 ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__sql_special_word__block_execute__automatic_detection__file_name_c + ').' );

      zts_1 :=
        'execute block' + #13 + #10 +

        'EXECUTE BLOCK ' + #13 + #10;

    end;

  Log_Memo.Lines.Add( Translation.translation__messages_r.automatically_block_execute_detection_words_list );

  zti_1 := Pos( #13 + #10, zts_1 );

  while zti_1 > 0 do
    begin

      zts_2 := Copy( zts_1, 1, zti_1 - 1 );

      if Trim( zts_2 ) <> '' then
        begin

          zti_2 := Length( sql_editor__sql_special_word__block_execute__automatic_detection__list_g_t );
          SetLength( sql_editor__sql_special_word__block_execute__automatic_detection__list_g_t, zti_2 + 1 );
          sql_editor__sql_special_word__block_execute__automatic_detection__list_g_t[ zti_2 ] := zts_2;

          Log_Memo.Lines.Add( sql_editor__sql_special_word__block_execute__automatic_detection__list_g_t[ zti_2 ] );

        end;

      Delete( zts_1, 1, zti_1 + 1 );


      zti_1 := Pos( #13 + #10, zts_1 );

    end;


  zts_1 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__sql_special_word__execute__automatic_detection__file_name_c  );


  if Trim( zts_1 ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__sql_special_word__execute__automatic_detection__file_name_c + ').' );

      zts_1 :=
        'alter ' + #13 + #10 +
        'create ' + #13 + #10 +
        'delete from ' + #13 + #10 +
        'drop ' + #13 + #10 +
        'insert into ' + #13 + #10 +
        'recreate ' + #13 + #10 +
        'set ' + #13 + #10 +
        'update ' + #13 + #10 +

        'ALTER ' + #13 + #10 +
        'CREATE ' + #13 + #10 +
        'DELETE FROM ' + #13 + #10 +
        'DROP ' + #13 + #10 +
        'INSERT INTO ' + #13 + #10 +
        'RECREATE ' + #13 + #10 +
        'SET ' + #13 + #10 +
        'UPDATE ' + #13 + #10;

    end;

  Log_Memo.Lines.Add( Translation.translation__messages_r.automatically_execute_detection_words_list );

  zti_1 := Pos( #13 + #10, zts_1 );

  while zti_1 > 0 do
    begin

      zts_2 := Copy( zts_1, 1, zti_1 - 1 );

      if Trim( zts_2 ) <> '' then
        begin

          zti_2 := Length( sql_editor__sql_special_word__execute__automatic_detection__list_g_t );
          SetLength( sql_editor__sql_special_word__execute__automatic_detection__list_g_t, zti_2 + 1 );
          sql_editor__sql_special_word__execute__automatic_detection__list_g_t[ zti_2 ] := zts_2;

          Log_Memo.Lines.Add( sql_editor__sql_special_word__execute__automatic_detection__list_g_t[ zti_2 ] );

        end;

      Delete( zts_1, 1, zti_1 + 1 );


      zti_1 := Pos( #13 + #10, zts_1 );

    end;


  zts_1 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__sql_special_word__transactions_automatic__file_name_c  );


  if Trim( zts_1 ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__sql_special_word__transactions_automatic__file_name_c + ').' );

      zts_1 :=
        'delete from ' + #13 + #10 +
        'insert into ' + #13 + #10 +
        'update ' + #13 + #10 +

        'DELETE FROM ' + #13 + #10 +
        'INSERT INTO ' + #13 + #10 +
        'UPDATE ' + #13 + #10;


    end;

  Log_Memo.Lines.Add( Translation.translation__messages_r.automatically_transaction_begining_words_list );

  zti_1 := Pos( #13 + #10, zts_1 );

  while zti_1 > 0 do
    begin

      zts_2 := Copy( zts_1, 1, zti_1 - 1 );

      if Trim( zts_2 ) <> '' then
        begin

          zti_2 := Length( sql_editor__sql_special_word__transactions_automatic__list_g_t );
          SetLength( sql_editor__sql_special_word__transactions_automatic__list_g_t, zti_2 + 1 );
          sql_editor__sql_special_word__transactions_automatic__list_g_t[ zti_2 ] := zts_2;

          Log_Memo.Lines.Add( sql_editor__sql_special_word__transactions_automatic__list_g_t[ zti_2 ] );

        end;

      Delete( zts_1, 1, zti_1 + 1 );


      zti_1 := Pos( #13 + #10, zts_1 );

    end;


  code_completion__column_list__clear_symbol_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__code_completion__column_list__clear_symbol__file_name_c  );
  code_completion__column_list__clear_symbol_g := Newline_Characters_Delete( code_completion__column_list__clear_symbol_g );

  if Trim( code_completion__column_list__clear_symbol_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__code_completion__column_list__clear_symbol__file_name_c + ').' );

      code_completion__column_list__clear_symbol_g := 'column \';

    end;

  Log_Memo.Lines.Add( 'Code completion column list clear symbol: ' + code_completion__column_list__clear_symbol_g + '.' );


  code_completion__column_list__style_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__code_completion__column_list_style__file_name_c  );
  code_completion__column_list__style_g := Newline_Characters_Delete( code_completion__column_list__style_g );

  if Trim( code_completion__column_list__style_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__code_completion__column_list_style__file_name_c + ').' );

      code_completion__column_list__style_g := '\color{$000456FF}' + Translation.translation__code_completion__column_c + ' \color{clWindowText}\column{}\style{+B}' + Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c + '\style{-B}';

    end;

  code_completion__column_list__style_g := StringReplace( code_completion__column_list__style_g, Translation.translation__code_completion__column_c, Translation.translation__messages_r.code_completion__column, [ rfReplaceAll ] );

  Log_Memo.Lines.Add( 'Code completion column list style: ' + code_completion__column_list__style_g + '.' );


  code_completion__table_list_style_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__code_completion__table_list_style__file_name_c  );
  code_completion__table_list_style_g := Newline_Characters_Delete( code_completion__table_list_style_g );

  if Trim( code_completion__table_list_style_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__code_completion__table_list_style__file_name_c + ').' );

      code_completion__table_list_style_g := '\color{clHighlight}' + Translation.translation__code_completion__table_c + ' \color{clWindowText}\column{}\style{+B}' + Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c + '\style{-B}';

    end;

  code_completion__table_list_style_g := StringReplace( code_completion__table_list_style_g, Translation.translation__code_completion__table_c, Translation.translation__messages_r.code_completion__table, [ rfReplaceAll ] );

  Log_Memo.Lines.Add( 'Code completion table list style: ' + code_completion__table_list_style_g + '.' );


  zts_1 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + Common.sql_editor__code_completion_list__file_name_c  );

  if Trim( zts_1 ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + Common.sql_editor__code_completion_list__file_name_c + ').' );


      zts_1 := Common.sql_editor__code_completion_list_c;

    end;

  zts_1 := StringReplace( zts_1, Translation.translation__code_completion__sql_c, Translation.translation__messages_r.code_completion__sql, [ rfReplaceAll ] );

  zti_1 := Pos( #13 + #10, zts_1 );

  while zti_1 > 1 do
    begin

      zts_2 := Copy( zts_1, 1, zti_1 - 1 );

      // For TMemo.
      //zt_menu_item := TMenuItem.Create( Application );
      //zt_menu_item.Caption := zts_2;
      //zt_menu_item.Hint := zt_menu_item.Caption;
      //zt_menu_item.Caption := StringReplace( zt_menu_item.Caption, Common.newline_symbol_c, '\n', [ rfReplaceAll ] );
      //zt_menu_item.OnClick := sql__text_popup_menuClick;
      //
      //Sql_Text__Code_Completion_PopupMenu.Items.Add( zt_menu_item );
      //---// For TMemo.

      zti_2 := Pos( Common.code_completion__caption_value_separator_c, zts_1 );


      Sql_Text__SynCompletionProposal.ItemList.Add(  Copy( zts_2, 1, zti_2 - 1 )  );

      Delete(  zts_2, 1, zti_2 + Length( Common.code_completion__caption_value_separator_c ) - 1  );
      zts_2 := StringReplace( zts_2, Common.newline_symbol_c, #13 + #10, [ rfReplaceAll ] );

      Sql_Text__SynCompletionProposal.InsertList.Add( zts_2 );


      Delete( zts_1, 1, zti_1 + 1 );


      zti_1 := Pos( #13 + #10, zts_1 );

    end;


  sql_editor__column_name_add_text__1_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__column_name_add_text__1__file_name_c  );
  sql_editor__column_name_add_text__1_g := Newline_Characters_Delete( sql_editor__column_name_add_text__1_g );

  if Trim( sql_editor__column_name_add_text__1_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__column_name_add_text__1__file_name_c + ').' );

      sql_editor__column_name_add_text__1_g := 'select ';

    end;

  Log_Memo.Lines.Add( 'Column name add text 1: ' + sql_editor__column_name_add_text__1_g + '.' );


  sql_editor__column_name_add_text__2_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__column_name_add_text__2__file_name_c  );
  sql_editor__column_name_add_text__2_g := Newline_Characters_Delete( sql_editor__column_name_add_text__2_g );

  if Trim( sql_editor__column_name_add_text__2_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__column_name_add_text__2__file_name_c + ').' );

      sql_editor__column_name_add_text__2_g := '     , ';

    end;

  Log_Memo.Lines.Add( 'Column name add text 2: ' + sql_editor__column_name_add_text__2_g + '.' );


  sql_editor__table_name_add_text__1_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__table_name_add_text__1__file_name_c  );
  sql_editor__table_name_add_text__1_g := Newline_Characters_Delete( sql_editor__table_name_add_text__1_g );

  if Trim( sql_editor__table_name_add_text__1_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__table_name_add_text__1__file_name_c + ').' );

      sql_editor__table_name_add_text__1_g := 'from ';

    end;

  Log_Memo.Lines.Add( 'Table name add text 1: ' + sql_editor__table_name_add_text__1_g + '.' );


  sql_editor__table_name_add_text__2_a_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__table_name_add_text__2__a__file_name_c  );
  sql_editor__table_name_add_text__2_a_g := Newline_Characters_Delete( sql_editor__table_name_add_text__2_a_g );

  if Trim( sql_editor__table_name_add_text__2_a_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__table_name_add_text__2__a__file_name_c + ').' );

      sql_editor__table_name_add_text__2_a_g := 'left join ';

    end;

  Log_Memo.Lines.Add( 'Table name add text 2 a: ' + sql_editor__table_name_add_text__2_a_g + '.' );


  sql_editor__table_name_add_text__2_b_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__table_name_add_text__2__b__file_name_c  );
  sql_editor__table_name_add_text__2_b_g := Newline_Characters_Delete( sql_editor__table_name_add_text__2_b_g );

  if Trim( sql_editor__table_name_add_text__2_b_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + sql_editor__table_name_add_text__2__b__file_name_c + ').' );

      sql_editor__table_name_add_text__2_b_g := ' on  = ';

    end;

  Log_Memo.Lines.Add( 'Table name add text 2 b: ' + sql_editor__table_name_add_text__2_b_g + '.' );


  Common.Syn_Completion_Proposal__Parameters__Set( Sql_Text__SynCompletionProposal );


  Highlight__Font__Set__SEF();



  zt_string_list := TStringList.Create();

  Shared.Shared_DataModule.Syn_Edit__Highlight__Manager_Names__Get( zt_string_list );


  zt_menu_item := TMenuItem.Create( Application );
  zt_menu_item.AutoCheck := true;
  zt_menu_item.Caption := Translation.translation__messages_r.word__none;
  zt_menu_item.Hint := Shared.sql_editor__highlights__syntax__none_c;
  zt_menu_item.RadioItem := true;
  zt_menu_item.OnClick := Sql_Text__Highlighter__Syntax__SetMenuItemClick;

  if Sql_Text_SynEdit.Highlighter = nil then
    zt_menu_item.Checked := true;

  Highlighter__Syntax_MenuItem.Add( zt_menu_item );


  zti_1 := 0;

  while zti_1 <= zt_string_list.Count - 2 do
    begin

      zt_menu_item := TMenuItem.Create( Application );
      zt_menu_item.AutoCheck := true;
      zt_menu_item.Caption := zt_string_list[ zti_1 ];
      zt_menu_item.Hint := zt_string_list[ zti_1 + 1 ];
      zt_menu_item.RadioItem := true;
      zt_menu_item.OnClick := Sql_Text__Highlighter__Syntax__SetMenuItemClick;

      if    ( Sql_Text_SynEdit.Highlighter <> nil )
        and ( Sql_Text_SynEdit.Highlighter.Name = zt_menu_item.Hint ) then
        zt_menu_item.Checked := true;

      Highlighter__Syntax_MenuItem.Add( zt_menu_item );

      zti_1 := zti_1 + 2;

    end;

  zt_string_list.Clear();
  FreeAndNil( zt_string_list );


  for zti_1 := 0 to Tables_List_ListBox.Items.Count - 1 do
    begin

      Sql_Text__SynCompletionProposal.InsertList.Add( Self.Quotation_Sign__SEF() + Tables_List_ListBox.Items[ zti_1 ] + Self.Quotation_Sign__SEF() );
      Sql_Text__SynCompletionProposal.ItemList.Add(  StringReplace( code_completion__table_list_style_g, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Tables_List_ListBox.Items[ zti_1 ], [ rfReplaceAll ] )  );

    end;

  Tables_List_ListBoxClick( nil ); // To correct code completion (columns list).


  Winapi.ShellAPI.DragAcceptFiles( Sql_Text_SynEdit.Handle, true );

end;

procedure TSql_Editor_F_Frame.Primary_Column_Find();
begin

  // Nested functions not allowed in threads.

  if    ( sql_editor_sdbm.Query__Active() )
    and ( sql_editor_sdbm.Query__Field_Count > 0 ) then
    begin

      Sql_Editor_Column_DBEdit.DataField := sql_editor_sdbm.Query__Fields( 0 ).FieldName;


      if sort__column_name_g = '' then
        sort__column_name_g := Sql_Editor_Column_DBEdit.DataField;

    end;

end;

procedure TSql_Editor_F_Frame.Query_Active_Notification_Set( history_text_f : string = '' );
var
  zti : integer;
begin

  if sql_editor_sdbm = nil then
    Exit;


  if    ( sql_editor_sdbm.Query__Active() )
    and (  Trim( history_text_f ) = ''  ) then
    history_text_f := sql_editor_sdbm.Query__Sql__Get();


  if Trim( history_text_f ) <> '' then
    begin

      Close_Button.Enabled := true;
      Refresh_Button.Enabled := true;


      zti := Length( sql_text_history_g_t );

      if   ( zti <= 0 )
        or (
                 ( zti > 0 )
             and ( sql_text_history_g_t[ zti - 1 ] <> history_text_f )
           )
        then
        begin

          SetLength( sql_text_history_g_t, zti + 1 );
          sql_text_history__index_current_g := zti;
          sql_text_history_g_t[ sql_text_history__index_current_g ] := history_text_f;

        end;

    end;


  if sql_editor_sdbm.Query__Active() then
    begin

      Close_Button.Enabled := true;
      Refresh_Button.Enabled := true;

    end
  else
    begin

      Close_Button.Enabled := false;
      Refresh_Button.Enabled := false;


      Sql_Editor_Column_DBEdit.DataField := '';
      sort__column_name_g := '';
      sort__direction_ascending_g := true;

    end;


  Close_MenuItem.Enabled := Close_Button.Enabled;
  Refresh_MenuItem.Enabled := Refresh_Button.Enabled;


  Caret_Position_Display();

end;

function TSql_Editor_F_Frame.Quotation_Sign__SEF() : string;
begin

  if sql__quotation_sign__use__sef_g then
    begin

      Result := sql__quotation_sign__sef_g;

    end
  else
    Result := '';

end;

procedure TSql_Editor_F_Frame.sql__parameterKeyDown( Sender : TObject; var Key : Word; Shift : TShiftState );
begin

  // E.
  if    ( Key = 69 )
    and ( Shift = [ ssCtrl, ssShift ] ) then
    Open_ButtonClick( Execute_Button )
  else
  // E.
  if   (
             ( Key = 69 )
         and ( Shift = [ ssCtrl ] )
       )
    or ( Key = VK_RETURN ) then
    Open_ButtonClick( Sender );

end;

procedure TSql_Editor_F_Frame.Sql__Parameters__Free();
var
  i : integer;
begin

  for i := Sql_Parameters_ScrollBox.ControlCount - 1 downto 0 do
    if Sql_Parameters_ScrollBox.Controls[ i ].ClassType = Common.TSql_Parameter then
      FreeAndNil( Common.TSql_Parameter(Sql_Parameters_ScrollBox.Controls[ i ]) );

end;

procedure TSql_Editor_F_Frame.sql__text_popup_menuClick( Sender : TObject );
var
  zti : integer;
  zts : string;
begin

  // Unused.

  if    ( Sender <> nil )
    and ( Sender is TMenuItem ) then
    begin

      zts := TMenuItem(Sender).Hint;
      zti := Pos(  Common.sql_editor__column_replace_sign_c, System.StrUtils.ReverseString( zts )  );

      zts := StringReplace( zts, Common.newline_symbol_c, #13 + #10, [ rfReplaceAll ] );


      Sql_Text_Memo.SelText := zts;


      if zti > 0 then
        Sql_Text_Memo.SelStart := Sql_Text_Memo.SelStart - zti;

    end;

end;

function TSql_Editor_F_Frame.Task_Running_Check__SEF( const message_show_f : boolean = true ) : boolean;
begin

  Result := task_is_running_g;


  if    ( Result )
    and ( message_show_f ) then
    Application.MessageBox( PChar(Translation.translation__messages_r.task_is_still_running_wait_until_finish), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );

end;

procedure TSql_Editor_F_Frame.Transaction_Active_Notification_Set();
begin

  if sql_editor_sdbm = nil then
    Exit;


  if sql_editor_sdbm.Transaction__In() then
    begin

      Transaction__Commit_Button.Enabled := true;

    end
  else
    begin

      Transaction__Commit_Button.Enabled := false;


      if transactions_count_g <> 0 then
        transactions_count_g := 0;

    end;


  Transaction__Commit_MenuItem.Enabled := Transaction__Commit_Button.Enabled;
  Transaction__Rollback_Button.Enabled := Transaction__Commit_Button.Enabled;
  Transaction__Rollback_MenuItem.Enabled := Transaction__Commit_Button.Enabled;

  Transactions_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', transactions_count_g )  );

end;

procedure TSql_Editor_F_Frame.Translation__Apply__SEF();
begin

  Translation.Translation__Apply( Self );


  text__file_group_box_caption_copy_g := Text__File_GroupBox.Caption;

  OpenDialog1.Filter := Translation.translation__messages_r.text_files + '|*' + Common.txt__file__default_extension + '|' + Translation.translation__messages_r.all_files + '|' + Common.all_files_find__filter;


  Caret_Position_Display();

end;

procedure TSql_Editor_F_Frame.Sql_Editor_Column_DBEditChange( Sender: TObject );
begin

  if Self.Task_Running_Check__SEF( false ) then
    Exit;


  if    ( sql_editor_sdbm <> nil )
    and ( sql_editor_sdbm.Query__Active() ) then
    Record_Number__Records_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', sql_editor_sdbm.Query__Record_Number() )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', sql_editor_sdbm.Query__Record_Count() )  )
  else
    Record_Number__Records_Count_Label.Caption := '0 / 0';

end;

procedure TSql_Editor_F_Frame.Tables_List_ListBoxClick( Sender: TObject );
var
  i : integer;

  zts : string;

  zt_sdbm : Common.TSDBM;
begin

  id_search__tablse_list_g := Tables_List_ListBox.ItemIndex;


  if   ( Tables_List_ListBox.Items.Count <= 0 )
    or ( Tables_List_ListBox.ItemIndex < 0 )
    or ( Tables_List_ListBox.ItemIndex >= Tables_List_ListBox.Items.Count ) then
    Exit;


  if sql_editor_sdbm <> nil then
    begin

      for i := Sql_Text__SynCompletionProposal.ItemList.Count - 1 downto 0 do
        if Pos( code_completion__column_list__clear_symbol_g, Sql_Text__SynCompletionProposal.ItemList[ i ] ) = 1 then
          begin

            Sql_Text__SynCompletionProposal.InsertList.Delete( i );
            Sql_Text__SynCompletionProposal.ItemList.Delete( i );

          end;
        //else
        //  Break;


      {$region 'Columns.'}
      Screen.Cursor := crHourGlass;


      Columns_List_ListBox.Items.Clear();

      Columns_List_ListBox.Items.Add( sql_editor__select_all_columns_text_g );

      zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + Common.table_columns_list__sql__file_name_c  );

      if Trim( zts ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__sef_g ) + Common.table_columns_list__sql__file_name_c + ').' );

          zts := Common.table_columns_list__sql_c;

        end;


      zt_sdbm := Common.TSDBM.Create( sql_editor_sdbm );
      zt_sdbm.Component_Type_Set( sql_editor_sdbm.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

      zt_sdbm.Query__Sql__Set( zts );

      zt_sdbm.Query__Param_By_Name__Set( Common.name__table__small_letters_c, Tables_List_ListBox.Items[ Tables_List_ListBox.ItemIndex ], Log_Memo );

      try
        zt_sdbm.Query__Open();
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_load_columns_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;

      if zt_sdbm.Query__Active() then
        begin

          try
            zt_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString;
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                zt_sdbm.Query__Close();

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_column_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

              end;
          end;


          if zt_sdbm.Query__Active() then
            begin

              while not zt_sdbm.Query__Eof() do
                begin

                  Columns_List_ListBox.Items.Add(   Trim(  zt_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString  )   ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

                  zt_sdbm.Query__Next();

                end;

            end;


          zt_sdbm.Query__Close();

        end;


      if zt_sdbm.Query__Active() then
        zt_sdbm.Query__Close();

      FreeAndNil( zt_sdbm );


      if Columns_List_ListBox.Items.Count > 0 then
        Columns_List_ListBox.ItemIndex := 0;


      Screen.Cursor := crDefault;
      {$endregion 'Columns.'}


      if Sql_Text__SynCompletionProposal.InsertList.Count > 0 then
        for i := 1 to Columns_List_ListBox.Items.Count - 1 do
          begin

            Sql_Text__SynCompletionProposal.InsertList.Add( Self.Quotation_Sign__SEF() + Columns_List_ListBox.Items[ i ] + Self.Quotation_Sign__SEF() );
            Sql_Text__SynCompletionProposal.ItemList.Add(  StringReplace( code_completion__column_list__style_g, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, Columns_List_ListBox.Items[ i ], [ rfReplaceAll ] )  );

          end;

    end;

end;

procedure TSql_Editor_F_Frame.Tables_List_ListBoxDblClick( Sender: TObject );
var
  i : integer;

  zts : string;

  zt_strings : TStrings;
begin

  if   ( Tables_List_ListBox.Items.Count <= 0 )
    or ( Tables_List_ListBox.ItemIndex < 0 )
    or ( Tables_List_ListBox.ItemIndex >= Tables_List_ListBox.Items.Count ) then
    Exit;


  //zt_strings := Sql_Text_Memo.Lines;
  zt_strings := Sql_Text_SynEdit.Lines;


  zts := Self.Quotation_Sign__SEF() + Tables_List_ListBox.Items[ Tables_List_ListBox.ItemIndex ] + Self.Quotation_Sign__SEF();

  if Pos(   AnsiLowerCase(  Trim( sql_editor__table_name_add_text__1_g )  ), AnsiLowerCase( zt_strings.Text )   ) <= 0 then
    zts := sql_editor__table_name_add_text__1_g + zts
  else
    zts := sql_editor__table_name_add_text__2_a_g + zts + sql_editor__table_name_add_text__2_b_g;


  zt_strings.Add( zts );


  if    (  Pos( 'from', zts ) > 0  )
    and (   Pos(  'join ', AnsiLowerCase( zt_strings.Text )  ) > 0   ) then
    for i := 0 to zt_strings.Count - 2 do
      if Pos(  'join ', AnsiLowerCase( zt_strings[ i ] )  ) > 0 then
        begin

          zt_strings.Move( zt_strings.Count - 1, i );
          Break;

        end;


  if    (  Pos( 'join', zts ) > 0  )
    and (   Pos(  'from', AnsiLowerCase( zt_strings.Text )  ) > 0   ) then
    for i := zt_strings.Count - 2 downto 1 do
      if Pos(  'join ', AnsiLowerCase( zt_strings[ i ] )  ) > 0 then
        begin

          zt_strings.Move( zt_strings.Count - 1, i + 1 );
          Break;

        end;

end;

procedure TSql_Editor_F_Frame.Columns_List_ListBoxClick( Sender: TObject );
begin

  id_search__columns_list_g := Columns_List_ListBox.ItemIndex;

end;

procedure TSql_Editor_F_Frame.Columns_List_ListBoxDblClick( Sender: TObject );
var
  i : integer;

  zts : string;
begin

  if   ( Columns_List_ListBox.Items.Count <= 0 )
    or ( Columns_List_ListBox.ItemIndex < 0 )
    or ( Columns_List_ListBox.ItemIndex >= Columns_List_ListBox.Items.Count ) then
    Exit;


  if Columns_List_ListBox.Items[ Columns_List_ListBox.ItemIndex ] <> sql_editor__select_all_columns_text_g then
    zts := Self.Quotation_Sign__SEF() + Columns_List_ListBox.Items[ Columns_List_ListBox.ItemIndex ] + Self.Quotation_Sign__SEF()
  else
    zts := Columns_List_ListBox.Items[ Columns_List_ListBox.ItemIndex ];


  if    ( Tables_List_ListBox.Items.Count > 0 )
    and ( Tables_List_ListBox.ItemIndex >= 0 )
    and ( Tables_List_ListBox.ItemIndex < Tables_List_ListBox.Items.Count ) then
    zts := Self.Quotation_Sign__SEF() + Tables_List_ListBox.Items[ Tables_List_ListBox.ItemIndex ] + Self.Quotation_Sign__SEF() + Common.sql__names_separator + zts;


  if   ( Sql_Text_SynEdit.SelText = Common.sql_editor__column_replace_sign_c )
    or (
             ( Sql_Text_SynEdit.Lines.Text.Length > Sql_Text_SynEdit.SelStart )
         and ( Sql_Text_SynEdit.Lines.Text[ Sql_Text_SynEdit.SelStart + 1 ] = Common.sql_editor__column_replace_sign_c )
         and ( // Skip concatenation (||).
                  ( Sql_Text_SynEdit.Lines.Text.Length = Sql_Text_SynEdit.SelStart + 1 )
               or (
                        ( Sql_Text_SynEdit.Lines.Text.Length > Sql_Text_SynEdit.SelStart + 1 )
                    and ( Sql_Text_SynEdit.Lines.Text[ Sql_Text_SynEdit.SelStart + 2 ] <> Common.sql_editor__column_replace_sign_c )
                  )
             )
       ) then
    begin

      if    ( Sql_Text_SynEdit.SelLength <= 0 )
        and ( Sql_Text_SynEdit.Lines.Text.Length > Sql_Text_SynEdit.SelStart )
        and ( Sql_Text_SynEdit.Lines.Text[ Sql_Text_SynEdit.SelStart + 1 ] = Common.sql_editor__column_replace_sign_c ) then
        begin

          Sql_Text_SynEdit.SelLength := 1;
          Sql_Text_SynEdit.SelText := '';

        end;

      Sql_Text_SynEdit.SelText := zts;

      Sql_Text_SynEdit.SetFocus();

      Exit;

    end;


  if Pos(   AnsiLowerCase(  Trim( sql_editor__column_name_add_text__1_g )  ), AnsiLowerCase( Sql_Text_SynEdit.Lines.Text )   ) <= 0 then
    zts := sql_editor__column_name_add_text__1_g + zts
  else
    zts := sql_editor__column_name_add_text__2_g + zts;


  Sql_Text_SynEdit.Lines.Add( zts );


  if    ( Sql_Text_SynEdit.Lines.Count > 1 )
    and (  Pos( 'select', zts ) > 0  ) then
    Sql_Text_SynEdit.Lines.Move( Sql_Text_SynEdit.Lines.Count - 1, 0 )
  else
  if Pos(  'from', AnsiLowerCase( Sql_Text_SynEdit.Lines.Text )  ) > 0 then
    for i := 0 to Sql_Text_SynEdit.Lines.Count - 2 do
      if Pos(  'from', AnsiLowerCase( Sql_Text_SynEdit.Lines[ i ] )  ) > 0 then
        begin

          Sql_Text_SynEdit.Lines.Move( Sql_Text_SynEdit.Lines.Count - 1, i );
          Break;

        end;


  {$region 'Sql_Text_Memo.'}
  //if   ( Sql_Text_Memo.SelText = Common.sql_editor__column_replace_sign_c )
  //  or (
  //           ( Sql_Text_Memo.Lines.Text.Length > Sql_Text_Memo.SelStart )
  //       and ( Sql_Text_Memo.Lines.Text[ Sql_Text_Memo.SelStart + 1 ] = Common.sql_editor__column_replace_sign_c )
  //       and ( // Skip concatenation (||).
  //                ( Sql_Text_Memo.Lines.Text.Length = Sql_Text_Memo.SelStart + 1 )
  //             or (
  //                      ( Sql_Text_Memo.Lines.Text.Length > Sql_Text_Memo.SelStart + 1 )
  //                  and ( Sql_Text_Memo.Lines.Text[ Sql_Text_Memo.SelStart + 2 ] <> Common.sql_editor__column_replace_sign_c )
  //                )
  //           )
  //     ) then
  //  begin
  //
  //    if    ( Sql_Text_Memo.SelLength <= 0 )
  //      and ( Sql_Text_Memo.Lines.Text.Length > Sql_Text_Memo.SelStart )
  //      and ( Sql_Text_Memo.Lines.Text[ Sql_Text_Memo.SelStart + 1 ] = Common.sql_editor__column_replace_sign_c ) then
  //      begin
  //
  //        Sql_Text_Memo.SelLength := 1;
  //        Sql_Text_Memo.SelText := '';
  //
  //      end;
  //
  //    Sql_Text_Memo.SelText := zts;
  //
  //    Sql_Text_Memo.SetFocus();
  //
  //    Exit;
  //
  //  end;
  //
  //
  //if Pos(   AnsiLowerCase(  Trim( sql_editor__column_name_add_text__1_g )  ), AnsiLowerCase( Sql_Text_Memo.Lines.Text )   ) <= 0 then
  //  zts := sql_editor__column_name_add_text__1_g + zts
  //else
  //  zts := sql_editor__column_name_add_text__2_g + zts;
  //
  //
  //Sql_Text_Memo.Lines.Add( zts );
  //
  //
  //if    ( Sql_Text_Memo.Lines.Count > 1 )
  //  and (  Pos( 'select', zts ) > 0  ) then
  //  Sql_Text_Memo.Lines.Move( Sql_Text_Memo.Lines.Count - 1, 0 )
  //else
  //if Pos(  'from', AnsiLowerCase( Sql_Text_Memo.Lines.Text )  ) > 0 then
  //  for i := 0 to Sql_Text_Memo.Lines.Count - 2 do
  //    if Pos(  'from', AnsiLowerCase( Sql_Text_Memo.Lines[ i ] )  ) > 0 then
  //      begin
  //
  //        Sql_Text_Memo.Lines.Move( Sql_Text_Memo.Lines.Count - 1, i );
  //        Break;
  //
  //      end;
  {$endregion 'Sql_Text_Memo.'}

end;

procedure TSql_Editor_F_Frame.Tables_List_ListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    (
             (
                   ( Key = VK_RETURN )
               and ( Shift = [ ssCtrl ] )
             )
          or (
                   ( Key = VK_SPACE )
               and ( Shift = [ ssCtrl ] )
             )
        )
    and ( Columns_List_ListBox.Items.Count > 0 ) then
    Columns_List__Star( Shift )
  else
  if    ( Key = VK_RETURN )
    and ( Shift = [ ssShift ] ) then
    Columns_List__All()
  else
  if Key = VK_RETURN then
    Tables_List_ListBoxDblClick( Sender )
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( Tables_List_ListBox.Items.Count > 0 )
    and ( Tables_List_ListBox.ItemIndex >= 0 )
    and ( Tables_List_ListBox.ItemIndex < Tables_List_ListBox.Items.Count ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Self.Quotation_Sign__SEF() + Tables_List_ListBox.Items[ Tables_List_ListBox.ItemIndex ] + Self.Quotation_Sign__SEF();
    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end
  else
  // R.
  if    ( Key = 82 )
    and ( Shift = [ ssCtrl ] ) then
    Self.Options_Set__SEF( sql_editor_sdbm.component_type__sdbm, sql__quotation_sign__sef_g, Queries_Open_In_Background_MenuItem.Checked, sql__quotation_sign__use__sef_g )
  else
    Key_Down_Common( Sender, Key, Shift );

end;

procedure TSql_Editor_F_Frame.Columns_List_ListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  id_search__columns_list_g := Columns_List_ListBox.ItemIndex;


  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl ] ) then
    Columns_List__All()
  else
  if Key = VK_RETURN then
    Columns_List_ListBoxDblClick( Sender )
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( Columns_List_ListBox.Items.Count > 0 )
    and ( Columns_List_ListBox.ItemIndex >= 0 )
    and ( Columns_List_ListBox.ItemIndex < Columns_List_ListBox.Items.Count ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Self.Quotation_Sign__SEF() + Columns_List_ListBox.Items[ Columns_List_ListBox.ItemIndex ] + Self.Quotation_Sign__SEF();
    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end
  else
  // R.
  if    ( Key = 82 )
    and ( Shift = [ ssCtrl ] ) then
    Tables_List_ListBoxClick( Sender )
  else
    Key_Down_Common( Sender, Key, Shift );

end;

procedure TSql_Editor_F_Frame.Open_ButtonClick( Sender: TObject );

  function Sql__Special_Word_Check( const sql_text_f : string; transactions_automatic_f : boolean ) : boolean;
  var
    i_l : integer;
  begin

    Result := false;


    if transactions_automatic_f then
      begin

        for i_l := 0 to Length( sql_editor__sql_special_word__transactions_automatic__list_g_t ) - 1 do
          if Pos( sql_editor__sql_special_word__transactions_automatic__list_g_t[ i_l ], sql_text_f ) > 0 then
            begin

              Result := true;

              Exit;

            end;

      end
    else
      for i_l := 0 to Length( sql_editor__sql_special_word__execute__automatic_detection__list_g_t ) - 1 do
        if Pos( sql_editor__sql_special_word__execute__automatic_detection__list_g_t[ i_l ], sql_text_f ) > 0 then
          begin

            Result := true;

            Exit;

          end;

  end;

var
  ztb,
  command_execute_l,
  parameters_changed
    : boolean;

  i,
  j,
  k
    : integer;

  history_text_l,
  sql_text_l
    : string;

  command_execute_parameters_t : array of string;
  //command_execute_parameters_var_rec_t : array of TVarRec; //????

  sql_parameters__new_string_list,
  sql_parameters__old_string_list
    : TStringList;
begin

  if sql_editor_sdbm = nil then
    Exit;


  if Self.Task_Running_Check__SEF() then
    Exit;


  history_text_l := '';

  sql_parameters__new_string_list := TStringList.Create();
  sql_parameters__old_string_list := TStringList.Create();


  Data_Preview_DBMemo.DataField := '';


  if    ( Execute__Selected_MenuItem.Checked )
    //and ( Sql_Text_Memo.SelText <> '' ) then
    and ( Sql_Text_SynEdit.SelText <> '' ) then
    //sql_text_l := Sql_Text_Memo.SelText
    sql_text_l := Sql_Text_SynEdit.SelText
  else
    //sql_text_l := Sql_Text_Memo.Lines.Text;
    sql_text_l := Sql_Text_SynEdit.Lines.Text;


  if   (
             ( Sender <> nil )
         and (
                  ( Sender = Execute_Button )
               or ( Sender = Execute_MenuItem )
             )
       )
    or (
             ( Execute__Automatic_Detection_CheckBox.Checked )
         and (  Sql__Special_Word_Check( sql_text_l, false )  )
       ) then
    command_execute_l := true
  else
    command_execute_l := false;


  if sql_editor_sdbm.Query__Active() then
    Close_ButtonClick( Sender );


  if not sql_editor_sdbm.Query__Active() then
    begin

      parameters_changed := false;

      Sql_Parameters_ScrollBox.Color := clBtnFace;


      if   ( not Ado_Command_Param_Check_CheckBox.Visible )
        or (
                 ( Ado_Command_Param_Check_CheckBox.Visible )
             and (
                       ( not command_execute_l )
                   or  (
                             ( command_execute_l )
                         and ( Ado_Command_Param_Check_CheckBox.Checked )
                       )
                 )
           ) then
        begin

          for i := 0 to sql_editor_sdbm.Query__Parameters_Count() - 1 do
            begin

              // Unique only.

              if not sql_parameters__old_string_list.Find( sql_editor_sdbm.Query__Param_By_Index__Name__Get( i ), j ) then
                begin

                  ztb := false;

                  for k := Sql_Parameters_ScrollBox.ControlCount - 1 downto 0 do
                    if    ( Sql_Parameters_ScrollBox.Controls[ k ].ClassType = Common.TSql_Parameter )
                      and ( Common.TSql_Parameter(Sql_Parameters_ScrollBox.Controls[ k ]).Parameter_Name_Get() = sql_editor_sdbm.Query__Param_By_Index__Name__Get( i ) ) then
                      begin

                        // Command (ADO) execute may clear the parameters list (objects - Sql_Parameters_ScrollBox.ControlCount) and query (ADO) may has parameters (Query__Parameters).

                        ztb := true;

                        Break;

                      end;


                  if ztb then
                    begin

                      sql_parameters__old_string_list.Add(  sql_editor_sdbm.Query__Param_By_Index__Name__Get( i )  );

                      sql_parameters__old_string_list.Sort();

                    end;

                end;

            end;


          sql_editor_sdbm.Query__Sql__Set( sql_text_l );


          for i := 0 to sql_editor_sdbm.Query__Parameters_Count() - 1 do
            begin

              // Unique only.

              if not sql_parameters__new_string_list.Find(  sql_editor_sdbm.Query__Param_By_Index__Name__Get( i ), j  ) then
                begin

                  sql_parameters__new_string_list.Add(  sql_editor_sdbm.Query__Param_By_Index__Name__Get( i )  );

                  sql_parameters__new_string_list.Sort();

                end;

            end;


          for i := sql_parameters__old_string_list.Count - 1 downto 0 do
            begin

              ztb := false;


              for j := 0 to sql_parameters__new_string_list.Count - 1 do
                if sql_parameters__old_string_list[ i ] = sql_parameters__new_string_list[ j ] then
                  begin

                    ztb := true; // Parameter exists.
                    Break;

                  end;


              if not ztb then
                begin

                  if not parameters_changed then
                    parameters_changed := true;


                  for k := Sql_Parameters_ScrollBox.ControlCount - 1 downto 0 do
                    if    ( Sql_Parameters_ScrollBox.Controls[ k ].ClassType = Common.TSql_Parameter )
                      and ( Common.TSql_Parameter(Sql_Parameters_ScrollBox.Controls[ k ]).Parameter_Name_Get() = sql_parameters__old_string_list[ i ] ) then
                      FreeAndNil( Common.TSql_Parameter(Sql_Parameters_ScrollBox.Controls[ k ]) );


                  sql_parameters__old_string_list.Delete( i );

                end;

            end;


          for i := 0 to sql_parameters__new_string_list.Count - 1 do
            if not sql_parameters__old_string_list.Find( sql_parameters__new_string_list[ i ], j ) then
              begin

                if not parameters_changed then
                  parameters_changed := true;


                Common.TSql_Parameter.Create( Sql_Parameters_ScrollBox, sql_parameters__new_string_list[ i ], sql__parameterKeyDown );

              end;


          // Correct sorting.
          for i := Sql_Parameters_ScrollBox.ControlCount - 1 downto 0 do
            if Sql_Parameters_ScrollBox.Controls[ i ].ClassType = Common.TSql_Parameter then
              Common.TSql_Parameter(Sql_Parameters_ScrollBox.Controls[ i ]).Align := alBottom;

          for i := 0 to sql_parameters__new_string_list.Count - 1 do
            for j := 0 to Sql_Parameters_ScrollBox.ControlCount - 1 do
              if    ( Sql_Parameters_ScrollBox.Controls[ j ].ClassType = Common.TSql_Parameter )
                and ( Common.TSql_Parameter(Sql_Parameters_ScrollBox.Controls[ j ]).Parameter_Name_Get() = sql_parameters__new_string_list[ i ] ) then
                Common.TSql_Parameter(Sql_Parameters_ScrollBox.Controls[ j ]).Align := alTop;
          //---// Correct sorting.

        end
      else
        begin

          sql_editor_sdbm.Query__Sql__Set( sql_text_l );

          for i := Sql_Parameters_ScrollBox.ControlCount - 1 downto 0 do
            if Sql_Parameters_ScrollBox.Controls[ i ].ClassType = Common.TSql_Parameter then
              FreeAndNil( Common.TSql_Parameter(Sql_Parameters_ScrollBox.Controls[ i ]) );

        end;


      sql_parameters__new_string_list.Clear();
      sql_parameters__old_string_list.Clear();

      FreeAndNil( sql_parameters__new_string_list );
      FreeAndNil( sql_parameters__old_string_list );


      if parameters_changed then
        begin

          if    ( Sql_Parameters_ScrollBox.ControlCount > 0 )
            and ( Sql_Parameters_ScrollBox.Width <= 1 ) then
            begin

              Sql_Parameters_ScrollBox.Width := Round( Sql_Text_Panel.Width * 0.3 );

              if Sql_Parameters_ScrollBox.Width <= 1 then
                Sql_Parameters_ScrollBox.Width := 2;

            end;


          Sql_Parameters_ScrollBox.Color := clMoneyGreen;


          if Sql_Parameters_ScrollBox.ControlCount > 0 then
            begin

              for i := 0 to Sql_Parameters_ScrollBox.ControlCount - 1 do
                if Sql_Parameters_ScrollBox.Controls[ i ].ClassType = Common.TSql_Parameter then
                  begin

                    try
                      Common.TSql_Parameter(Sql_Parameters_ScrollBox.Controls[ i ]).Parameter_SetFocus();
                    except
                    end;


                    Break;

                  end;


              Exit;

            end;

        end;


      for i := 0 to Sql_Parameters_ScrollBox.ControlCount - 1 do
        if Sql_Parameters_ScrollBox.Controls[ i ].ClassType = Common.TSql_Parameter then
          sql_editor_sdbm.Query__Param_By_Name__Set( Common.TSql_Parameter(Sql_Parameters_ScrollBox.Controls[ i ]).Parameter_Name_Get(), Common.TSql_Parameter(Sql_Parameters_ScrollBox.Controls[ i ]).Parameter_Value_Get(), Log_Memo );


      if command_execute_l then
        begin

          //SetLength( command_execute_parameters_var_rec_t, sql_editor_sdbm.Query__Parameters_Count() * 2 );
          SetLength( command_execute_parameters_t, sql_editor_sdbm.Query__Parameters_Count() * 2 );

          for i := 0 to sql_editor_sdbm.Query__Parameters_Count() - 1 do
            begin

              //string(command_execute_parameters_var_rec_t[ i * 2 ].VString) := sql_editor_sdbm.Query__Param_By_Index__Name__Get( i );
              //
              //if sql_editor_sdbm.Query__Param_By_Index__Value__Get( i ) <> System.Variants.Null() then
              //  try
              //    command_execute_parameters_var_rec_t[ i * 2 + 1 ].VVariant^ := sql_editor_sdbm.Query__Param_By_Index__Value__Get( i ); // I do not know how to correctly set the value here. //????
              //  except
              //    on E : Exception do
              //      begin
              //
              //        Log_Memo.Lines.Add(  StringReplace( E.Message, #10, #13 + #10, [ rfReplaceAll ] )  );
              //
              //        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_set_command_parameter + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
              //
              //      end;
              //  end;
              //
              //string(command_execute_parameters_var_rec_t[ i * 2 + 1 ].VString) := VarToStr( sql_editor_sdbm.Query__Param_By_Index__Value__Get( i ) ); // Instead of 'array of TVarRec' here can be just 'array of string'.



              command_execute_parameters_t[ i * 2 ] := sql_editor_sdbm.Query__Param_By_Index__Name__Get( i );
              command_execute_parameters_t[ i * 2 + 1 ] := VarToStr(  sql_editor_sdbm.Query__Param_By_Index__Value__Get( i )  );

            end;

        end;


      ztb := true; // False = error occurred.

      if not Queries_Open_In_Background_MenuItem.Checked then
        begin

          Screen.Cursor := crSQLWait;

          Busy_Notification_Set( true );

          Application.ProcessMessages();


          if    ( Transactions_Automatic_CheckBox.Checked )
            and ( not sql_editor_sdbm.Transaction__In() )
            and (  Sql__Special_Word_Check( sql_text_l, true )  ) then
            Transaction__Begin_ButtonClick( Sender );


          try
            ztb := Open_Execute( command_execute_l, history_text_l, command_execute_parameters_t );
            //ztb := Open_Execute( command_execute_l, history_text_l, command_execute_parameters_var_rec_t );
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                ztb := false;

                Log_Memo.Lines.Add(  StringReplace( E.Message, #10, #13 + #10, [ rfReplaceAll ] )  );

                Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_open_query + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );

              end;
          end;


          sql_editor_sdbm.Operation_Duration__Calculating_Type__Set( Common.odct_single_command );


          if ztb then
            Log_Memo.Lines.Add( sql_editor_sdbm.Operation_Duration_Get() );


          Query_Active_Notification_Set( history_text_l );


          Primary_Column_Find();

          Data_Value_Format__Disabled_CheckBoxClick( Sender );

          Busy_Notification_Set( false );

          Sql_Editor_DBGrid.SelectedIndex := sql_editor_db_grid__selected_index_copy_g;

          Screen.Cursor := crDefault;

        end
      else
        begin

          task_is_running_g := true;

          Sql_Editor_DBGrid.DataSource := nil; // Sometimes there is an error 'Canvas does not allow drawing' in the line sql_editor_sdbm.Query__Open().


          Busy_Notification_Set( true );


          if    ( Transactions_Automatic_CheckBox.Checked )
            and ( not sql_editor_sdbm.Transaction__In() )
            and (  Sql__Special_Word_Check( sql_text_l, true )  ) then
            Transaction__Begin_ButtonClick( Sender );


          System.Threading.TTask.Run
            (
              procedure
                begin

                  try
                    ztb := Open_Execute( command_execute_l, history_text_l, command_execute_parameters_t );
                    //ztb := Open_Execute( command_execute_l, history_text_l, command_execute_parameters_var_rec_t );
                  except
                    on E : Exception do
                      TThread.Synchronize
                        (
                          TThread.Current,
                          procedure
                            begin

                              ztb := false;

                              Log_Memo.Lines.Add(  StringReplace( E.Message, #10, #13 + #10, [ rfReplaceAll ] )  );

                              Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_open_query + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );

                            end
                        );

                  end;


                  TThread.Synchronize
                    (
                      TThread.Current,
                      procedure
                        begin

                          task_is_running_g := false;


                          sql_editor_sdbm.Operation_Duration__Calculating_Type__Set( Common.odct_single_command );


                          if ztb then
                            Log_Memo.Lines.Add( sql_editor_sdbm.Operation_Duration_Get() );


                          Sql_Editor_DBGrid.DataSource := Sql_Editor_DataSource;


                          Query_Active_Notification_Set( history_text_l );


                          Primary_Column_Find();


                          Data_Value_Format__Disabled_CheckBoxClick( Sender );

                          Sql_Editor_DBGrid.Repaint();

                          Busy_Notification_Set( false );

                          Sql_Editor_DBGrid.SelectedIndex := sql_editor_db_grid__selected_index_copy_g;

                        end
                    );

                end
            );

        end;

    end
  else
    begin

      FreeAndNil( sql_parameters__new_string_list );
      FreeAndNil( sql_parameters__old_string_list );

    end;

end;

procedure TSql_Editor_F_Frame.Close_ButtonClick( Sender: TObject );
begin

  if sql_editor_sdbm = nil then
    Exit;


  if Self.Task_Running_Check__SEF() then
    Exit;


  if sql_editor_sdbm.Query__Active() then
    begin

      sql_editor_db_grid__selected_index_copy_g := Sql_Editor_DBGrid.SelectedIndex;


      sql_editor_sdbm.Query__Close();

      Query_Active_Notification_Set();


      if   ( Sender = nil )
        or (
                ( Sender <> nil )
            and (
                     ( Sender = Close_Button )
                  or ( Sender = Close_MenuItem )
                )
          ) then
        Sql__Parameters__Free();

    end;


  Transaction_Active_Notification_Set();

end;

procedure TSql_Editor_F_Frame.Refresh_ButtonClick( Sender: TObject );
var
  primary_key_name_l,
  primary_key_value_l
    : string;
begin

  if Self.Task_Running_Check__SEF() then
    Exit;


  if   ( sql_editor_sdbm = nil )
    or ( not sql_editor_sdbm.Query__Active() ) then
    Exit;


  if Trim( Sql_Editor_Column_DBEdit.DataField ) <> '' then
    begin

      primary_key_name_l := Sql_Editor_Column_DBEdit.DataField;
      primary_key_value_l := Sql_Editor_Column_DBEdit.Text;

    end
  else
  if sql_editor_sdbm.Query__Field_Count() >  0 then
    begin

      primary_key_name_l := sql_editor_sdbm.Query__Fields( 0 ).FieldName;
      primary_key_value_l := sql_editor_sdbm.Query__Fields( 0 ).AsString;

    end
  else
    primary_key_name_l := '';


  if not Queries_Open_In_Background_MenuItem.Checked then
    begin

      Screen.Cursor := crSQLWait;

      Busy_Notification_Set( true );

      Application.ProcessMessages();


      sql_editor_sdbm.Query__Requery();


      Log_Memo.Lines.Add( sql_editor_sdbm.Operation_Duration_Get() );


      if Trim( primary_key_name_l ) <> '' then
        sql_editor_sdbm.Query__Locate( primary_key_name_l, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );


      Busy_Notification_Set( false );

      Screen.Cursor := crDefault;

    end
  else
    begin

      task_is_running_g := true;


      Busy_Notification_Set( true );


      System.Threading.TTask.Run
        (
          procedure
            begin

              sql_editor_sdbm.Query__Requery();


              TThread.Synchronize
                (
                  TThread.Current,
                  procedure
                    begin

                      task_is_running_g := false;


                      Log_Memo.Lines.Add( sql_editor_sdbm.Operation_Duration_Get() );


                      if Trim( primary_key_name_l ) <> '' then
                        sql_editor_sdbm.Query__Locate( primary_key_name_l, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );


                      Busy_Notification_Set( false );

                    end
                );

            end
        );

    end;

end;

procedure TSql_Editor_F_Frame.Output_Save_ButtonClick( Sender: TObject );

  function Csv__Value_Prepare( const text_f : string ) : string;
  begin

    Result := text_f;


    while Pos( #10, Result ) > 0 do
      Result := StringReplace( Result, #10, '', [ rfReplaceAll ] );

    while Pos( #13, Result ) > 0 do
      Result := StringReplace( Result, #13, '', [ rfReplaceAll ] );


    if Pos( Csv__File__Text_Qualifier_Edit.Text, Result ) > 0 then
      Result := StringReplace( Result, Csv__File__Text_Qualifier_Edit.Text, Csv__File__Text_Qualifier_Edit.Text + Csv__File__Text_Qualifier_Edit.Text, [ rfReplaceAll ] );


    if   (  Pos( Csv__File__Data_Separator_Edit.Text, Result ) > 0  )
      or (  Pos( Csv__File__Text_Qualifier_Edit.Text, Result ) > 0  ) then
      Result :=
        Csv__File__Text_Qualifier_Edit.Text +
        Result +
        Csv__File__Text_Qualifier_Edit.Text;

  end;

  function Csv__Value_Format( const field_f : TField ) : string;
  var
    zts_l : string;
  begin

    if field_f.IsNull then
      Result := ''
    else
      try

        // Conflict between Data.DB and System.TypInfo.

        if    ( Query_Output_Save_Field_Format__Real_Numbers__Use_CheckBox.Checked )
          and ( field_f.DataType in [ Data.DB.ftBCD, Data.DB.ftCurrency, Data.DB.ftExtended, Data.DB.ftFloat, Data.DB.ftFMTBcd, Data.DB.ftSingle, Data.DB.ftVarBytes ] ) then
          begin

            Result := FormatFloat( Query_Output_Save_Field_Format__Real_Numbers_Edit.Text, field_f.AsFloat );

            if    ( Query_Output_Save_Field_Format__Separator__Decimal_Edit.Text <> '.' )
              and (  Pos( '.', Result ) > 0  ) then
              Result := StringReplace( Result, '.', Query_Output_Save_Field_Format__Separator__Decimal_Edit.Text, [ rfReplaceAll ] )
            else
            if    ( Query_Output_Save_Field_Format__Separator__Decimal_Edit.Text <> ',' )
              and (  Pos( ',', Result ) > 0  ) then
              Result := StringReplace( Result, ',', Query_Output_Save_Field_Format__Separator__Decimal_Edit.Text, [ rfReplaceAll ] )
            else
              Result := StringReplace( Result, '.', ',', [ rfReplaceAll ] );

          end
        else
        if    ( Query_Output_Save_Field_Format__Date__Use_CheckBox.Checked )
          and ( field_f.DataType in [ Data.DB.ftDate ] ) then
          begin

            DateTimeToString( zts_l, Query_Output_Save_Field_Format__Date_Edit.Text, field_f.AsDateTime );
            Result := zts_l;

          end
        else
        if    ( Query_Output_Save_Field_Format__Time__Use_CheckBox.Checked )
          and ( field_f.DataType in [ Data.DB.ftTime ] ) then
          begin

            DateTimeToString( zts_l, Query_Output_Save_Field_Format__Time_Edit.Text, field_f.AsDateTime );
            Result := zts_l;

          end
        else
        if    ( Query_Output_Save_Field_Format__Date__Use_CheckBox.Checked )
          and ( Query_Output_Save_Field_Format__Time__Use_CheckBox.Checked )
          and ( field_f.DataType in [ Data.DB.ftDateTime, Data.DB.ftTimeStamp, Data.DB.ftTimeStampOffset, Data.DB.ftOraTimeStamp ] ) then
          begin

            DateTimeToString( zts_l, Query_Output_Save_Field_Format__Date_Edit.Text, field_f.AsDateTime );
            Result := zts_l;

            DateTimeToString( zts_l, Query_Output_Save_Field_Format__Time_Edit.Text, field_f.AsDateTime );
            Result := Result + Query_Output_Save_Field_Format__Separator__Date_Time_Edit.Text + zts_l;

          end
        else
          Result := field_f.AsString;

      except
        on E : Exception do
          begin

            Result := field_f.AsString;

            Log_Memo.Lines.Add(  Translation.translation__messages_r.failed_to_set_value_format___field + ' ' + field_f.FieldName + ' = ' + field_f.AsString + ' : ' + StringReplace( E.Message, #10, #13 + #10, [ rfReplaceAll ] ) + '.'  );

          end
      end;

  end;

var
  i : integer;

  zts : string;

  zt_string_list : TStringList;
begin

  if   ( sql_editor_sdbm = nil )
    or ( not sql_editor_sdbm.Query__Active() ) then
    Exit;


  SaveDialog1.Filter := Translation.translation__messages_r.csv_files + '|*' + Common.csv__file__default_extension + '|' + Translation.translation__messages_r.all_files + '|' + Common.all_files_find__filter;


  if Trim( csv__file__name_saved_g ) = '' then
    csv__file__name_saved_g := Tab_Name_Edit.Text + Common.csv__file__default_extension;

  SaveDialog1.FileName := csv__file__name_saved_g;


  if SaveDialog1.Execute() then
    begin

      csv__file__name_saved_g := SaveDialog1.FileName;


      sql_editor_sdbm.Query__Disable_Controls();


      zt_string_list := TStringList.Create();


      // Header.
      zts := '';

      for i := 0 to sql_editor_sdbm.Query__Field_Count() - 1 do
        begin

          if i > 0 then
            zts := zts + Csv__File__Data_Separator_Edit.Text;

          zts := zts + Csv__Value_Prepare(  sql_editor_sdbm.Query__Fields( i ).FieldName  );

        end;

      zt_string_list.Add( zts );
      //---// Header.


      sql_editor_sdbm.Query__First();

      while not sql_editor_sdbm.Query__Eof() do
        begin

          zts := '';

          for i := 0 to sql_editor_sdbm.Query__Field_Count() - 1 do
            begin

              if i > 0 then
                zts := zts + Csv__File__Data_Separator_Edit.Text;

              zts := zts + Csv__Value_Prepare(   Csv__Value_Format(  sql_editor_sdbm.Query__Fields( i )  )   );

            end;

          zt_string_list.Add( zts );


          sql_editor_sdbm.Query__Next();

        end;


      sql_editor_sdbm.Query__First();

      sql_editor_sdbm.Query__Enable_Controls();


      zt_string_list.SaveToFile( SaveDialog1.FileName, TEncoding.UTF8 );

      zt_string_list.Clear();
      FreeAndNil( zt_string_list );

    end;

end;

procedure TSql_Editor_F_Frame.Sql__Prior_ButtonClick( Sender: TObject );
begin

  if sql_text_history__index_current_g > 0 then
    dec( sql_text_history__index_current_g );


  if    ( sql_text_history__index_current_g >= 0 )
    and (  sql_text_history__index_current_g < Length( sql_text_history_g_t )  ) then
    //Sql_Text_Memo.Lines.Text := sql_text_history_g_t[ sql_text_history__index_current_g ];
    Sql_Text_SynEdit.Lines.Text := sql_text_history_g_t[ sql_text_history__index_current_g ];

end;

procedure TSql_Editor_F_Frame.Sql__Next_ButtonClick( Sender: TObject );
begin

  if sql_text_history__index_current_g < Length( sql_text_history_g_t ) then
    inc( sql_text_history__index_current_g );


  if    ( sql_text_history__index_current_g >= 0 )
    and (  sql_text_history__index_current_g < Length( sql_text_history_g_t )  ) then
    //Sql_Text_Memo.Lines.Text := sql_text_history_g_t[ sql_text_history__index_current_g ]
    Sql_Text_SynEdit.Lines.Text := sql_text_history_g_t[ sql_text_history__index_current_g ]
  else
  if sql_text_history__index_current_g >= Length( sql_text_history_g_t ) then
    //Sql_Text_Memo.Lines.Text := '';
    Sql_Text_SynEdit.Lines.Text := '';

end;

procedure TSql_Editor_F_Frame.Transaction__Begin_ButtonClick( Sender: TObject );
begin

  if sql_editor_sdbm = nil then
    Exit;


  try
    sql_editor_sdbm.Transaction__Begin();

    Log_Memo.Lines.Add( sql_editor_sdbm.Operation_Duration_Get() );

    inc( transactions_count_g );
  except
    on E : Exception do
      begin

        Log_Memo.Lines.Add(  StringReplace( E.Message, #10, #13 + #10, [ rfReplaceAll ] )  );

        Application.MessageBox(  PChar(E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );

      end;
  end;

  Transaction_Active_Notification_Set();

end;

procedure TSql_Editor_F_Frame.Transaction__Commit_ButtonClick( Sender: TObject );
begin

  if sql_editor_sdbm = nil then
    Exit;


  try
    sql_editor_sdbm.Transaction__Commit();

    Log_Memo.Lines.Add( sql_editor_sdbm.Operation_Duration_Get() );

    dec( transactions_count_g );
  except
    on E : Exception do
      begin

        Log_Memo.Lines.Add(  StringReplace( E.Message, #10, #13 + #10, [ rfReplaceAll ] )  );

        Application.MessageBox(  PChar(E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );

      end;
  end;

  Transaction_Active_Notification_Set();

end;

procedure TSql_Editor_F_Frame.Transaction__Rollback_ButtonClick( Sender: TObject );
begin

  if sql_editor_sdbm = nil then
    Exit;


  try
    sql_editor_sdbm.Transaction__Rollback();

    Log_Memo.Lines.Add( sql_editor_sdbm.Operation_Duration_Get() );

    dec( transactions_count_g );
  except
    on E : Exception do
      begin

        Log_Memo.Lines.Add(  StringReplace( E.Message, #10, #13 + #10, [ rfReplaceAll ] )  );

        Application.MessageBox(  PChar(E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );

      end;
  end;

  Transaction_Active_Notification_Set();

end;

procedure TSql_Editor_F_Frame.Search_Change( Sender: TObject );
var
  locate_options : Data.DB.TLocateOptions;
begin

  id_search__columns_list_g := -1;
  id_search__tablse_list_g := -1;


  if Search_In_RadioGroup.ItemIndex in [ 0, 2 ] then // Columns list, Tables list.
    Search__Next_ButtonClick( Sender )
  else
  if Search_In_RadioGroup.ItemIndex = 1 then // Query output.
    begin

      if Self.Task_Running_Check__SEF() then
        Exit;


      if   ( sql_editor_sdbm = nil )
        or ( not sql_editor_sdbm.Query__Active() ) then
        Exit;


      locate_options := [];

      if Search__Case_Insensitive_CheckBox.Checked then
        locate_options := locate_options + [ Data.DB.loCaseInsensitive ];

      if Search__Partial_Key_CheckBox.Checked then
        locate_options := locate_options + [ Data.DB.loPartialKey ];


      if sql_editor_sdbm.Query__Locate( sort__column_name_g, Search_Edit.Text, locate_options ) then
        Search_Edit.Color := clWindow
      else
        if not Search__Partial_Key_CheckBox.Checked then
          Search_Edit.Color := Common.color__red__light_c
        else
          begin

            Search_Edit.Color := Common.color__red__light_c;


            sql_editor_sdbm.Query__Disable_Controls();

            sql_editor_sdbm.Query__First();

            while not sql_editor_sdbm.Query__Eof do
              begin

                if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  sql_editor_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
                  begin

                    Search_Edit.Color := clWindow;

                    Break;

                  end;

                sql_editor_sdbm.Query__Next();

              end;

            sql_editor_sdbm.Query__Enable_Controls();

          end;

    end;

end;

procedure TSql_Editor_F_Frame.Search__Next_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  if Search_In_RadioGroup.ItemIndex = 0 then // Columns list.
    begin

      Search_Edit.Color := Common.color__red__light_c;


      id_search__columns_list_g := id_search__columns_list_g + 1;

      if id_search__columns_list_g < 0 then
        id_search__columns_list_g := 0;


      for i := id_search__columns_list_g to Columns_List_ListBox.Items.Count - 1 do
        if   (
                   ( not Search__Partial_Key_CheckBox.Checked )
               and (  Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ) = Common.Case_Insensitive_To_String( Columns_List_ListBox.Items[ i ], Search__Case_Insensitive_CheckBox.Checked )  )
             )
          or (
                   ( Search__Partial_Key_CheckBox.Checked )
               and (   Pos(  Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String( Columns_List_ListBox.Items[ i ], Search__Case_Insensitive_CheckBox.Checked )  ) > 0   )
             ) then
          begin

            Columns_List_ListBox.ItemIndex := i;

            id_search__columns_list_g := i;

            Search_Edit.Color := clWindow;

            Break;

          end;

    end
  else
  if Search_In_RadioGroup.ItemIndex = 1 then // Query output.
    begin

      if Self.Task_Running_Check__SEF() then
        Exit;


      if   ( sql_editor_sdbm = nil )
        or ( not sql_editor_sdbm.Query__Active() ) then
        Exit;


      sql_editor_sdbm.Query__Disable_Controls();


      Search_Edit.Color := Common.color__red__light_c;


      while not sql_editor_sdbm.Query__Eof do
        begin

          sql_editor_sdbm.Query__Next();


          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  sql_editor_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

        end;


      sql_editor_sdbm.Query__Enable_Controls();

    end
  else
  if Search_In_RadioGroup.ItemIndex = 2 then // Tables list.
    begin

      Search_Edit.Color := Common.color__red__light_c;


      id_search__tablse_list_g := id_search__tablse_list_g + 1;

      if id_search__tablse_list_g < 0 then
        id_search__tablse_list_g := 0;


      for i := id_search__tablse_list_g to Tables_List_ListBox.Items.Count - 1 do
        if   (
                   ( not Search__Partial_Key_CheckBox.Checked )
               and (  Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ) = Common.Case_Insensitive_To_String( Tables_List_ListBox.Items[ i ], Search__Case_Insensitive_CheckBox.Checked )  )
             )
          or (
                   ( Search__Partial_Key_CheckBox.Checked )
               and (   Pos(  Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String( Tables_List_ListBox.Items[ i ], Search__Case_Insensitive_CheckBox.Checked )  ) > 0   )
             ) then
          begin

            Tables_List_ListBox.ItemIndex := i;

            id_search__tablse_list_g := i;

            Search_Edit.Color := clWindow;

            Tables_List_ListBoxClick( Sender );

            Break;

          end;

    end;

end;

procedure TSql_Editor_F_Frame.Search__Prior_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  if Search_In_RadioGroup.ItemIndex = 0 then // Columns list.
    begin

      Search_Edit.Color := Common.color__red__light_c;


      id_search__columns_list_g := id_search__columns_list_g - 1;

      if id_search__columns_list_g > Columns_List_ListBox.Items.Count - 1 then
        id_search__columns_list_g := Columns_List_ListBox.Items.Count - 1;


      for i := id_search__columns_list_g downto 0 do
        if   (
                   ( not Search__Partial_Key_CheckBox.Checked )
               and (  Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ) = Common.Case_Insensitive_To_String( Columns_List_ListBox.Items[ i ], Search__Case_Insensitive_CheckBox.Checked )  )
             )
          or (
                   ( Search__Partial_Key_CheckBox.Checked )
               and (   Pos(  Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String( Columns_List_ListBox.Items[ i ], Search__Case_Insensitive_CheckBox.Checked )  ) > 0   )
             ) then
          begin

            Columns_List_ListBox.ItemIndex := i;

            id_search__columns_list_g := i;

            Search_Edit.Color := clWindow;

            Break;

          end;

    end
  else
  if Search_In_RadioGroup.ItemIndex = 1 then // Query output.
    begin

      if Self.Task_Running_Check__SEF() then
        Exit;


      if   ( sql_editor_sdbm = nil )
        or ( not sql_editor_sdbm.Query__Active() ) then
        Exit;


      sql_editor_sdbm.Query__Disable_Controls();


      Search_Edit.Color := Common.color__red__light_c;


      while not sql_editor_sdbm.Query__Bof do
        begin

          sql_editor_sdbm.Query__Prior();


          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  sql_editor_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

        end;


      sql_editor_sdbm.Query__Enable_Controls();

    end
  else
  if Search_In_RadioGroup.ItemIndex = 2 then // Tables list.
    begin

      Search_Edit.Color := Common.color__red__light_c;


      id_search__tablse_list_g := id_search__tablse_list_g - 1;

      if id_search__tablse_list_g > Tables_List_ListBox.Items.Count - 1 then
        id_search__tablse_list_g := Tables_List_ListBox.Items.Count - 1;


      for i := id_search__tablse_list_g downto 0 do
        if   (
                   ( not Search__Partial_Key_CheckBox.Checked )
               and (  Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ) = Common.Case_Insensitive_To_String( Tables_List_ListBox.Items[ i ], Search__Case_Insensitive_CheckBox.Checked )  )
             )
          or (
                   ( Search__Partial_Key_CheckBox.Checked )
               and (   Pos(  Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String( Tables_List_ListBox.Items[ i ], Search__Case_Insensitive_CheckBox.Checked )  ) > 0   )
             ) then
          begin

            Tables_List_ListBox.ItemIndex := i;

            id_search__tablse_list_g := i;

            Search_Edit.Color := clWindow;

            Tables_List_ListBoxClick( Sender );

            Break;

          end;

    end;

end;

procedure TSql_Editor_F_Frame.Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl ] )
    and ( Search_In_RadioGroup.ItemIndex <> 1 ) // Query output.
    and ( Columns_List_ListBox.Items.Count > 0 ) then
    Columns_List__Star( Shift )
  else
  if    ( Key = VK_RETURN )
    and ( Shift = [ ssShift ] )
    and ( Search_In_RadioGroup.ItemIndex <> 1 ) then // Query output.
    Columns_List__All()
  else
  if Key = VK_RETURN then
    begin

      if Search_In_RadioGroup.ItemIndex = 0 then // Columns list.
        begin

          Columns_List_ListBoxDblClick( Sender );

        end
      else
      if Search_In_RadioGroup.ItemIndex = 2 then // Tables list.
        begin

          Tables_List_ListBoxDblClick( Sender );

        end;

    end
  else
    Key_Down_Common( Sender, Key, Shift );

end;

procedure TSql_Editor_F_Frame.Search_ButtonKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_RETURN )
    and ( Shift = [ ssShift ] ) then
    Search_EditKeyDown( Sender, Key, Shift )
  else
  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl ] )
    and ( Columns_List_ListBox.Items.Count > 0 ) then
    Columns_List__Star( Shift )
  else
    Key_Down_Common( Sender, Key, Shift );

end;

procedure TSql_Editor_F_Frame.Ado_Command_Param_Check_CheckBoxClick( Sender: TObject );
begin

  if    ( Sender <> nil )
    and ( Sender = Ado_Command_Param_Check_MenuItem ) then
    begin

      Ado_Command_Param_Check_CheckBox.OnClick := nil; // To avoid double function call.

      Ado_Command_Param_Check_CheckBox.Checked := Ado_Command_Param_Check_MenuItem.Checked;

      Ado_Command_Param_Check_CheckBox.OnClick := Ado_Command_Param_Check_CheckBoxClick;

    end
  else
    Ado_Command_Param_Check_MenuItem.Checked := Ado_Command_Param_Check_CheckBox.Checked;

end;

procedure TSql_Editor_F_Frame.Comments_Delete_CheckBoxClick( Sender: TObject );
begin

  if    ( Sender <> nil )
    and ( Sender = Comments_Delete_MenuItem ) then
    begin

      Comments_Delete_CheckBox.OnClick := nil; // To avoid double function call.

      Comments_Delete_CheckBox.Checked := Comments_Delete_MenuItem.Checked;

      Comments_Delete_CheckBox.OnClick := Comments_Delete_CheckBoxClick;

    end
  else
    Comments_Delete_MenuItem.Checked := Comments_Delete_CheckBox.Checked;

end;

procedure TSql_Editor_F_Frame.Data_Value_Format__Disabled_CheckBoxClick( Sender: TObject );
begin

  if    ( Sender <> nil )
    and ( Sender = Data_Value_Format__Disabled_MenuItem ) then
    begin

      Data_Value_Format__Disabled_CheckBox.OnClick := nil; // To avoid double function call.

      Data_Value_Format__Disabled_CheckBox.Checked := Data_Value_Format__Disabled_MenuItem.Checked;

      Data_Value_Format__Disabled_CheckBox.OnClick := Data_Value_Format__Disabled_CheckBoxClick;

    end
  else
    Data_Value_Format__Disabled_MenuItem.Checked := Data_Value_Format__Disabled_CheckBox.Checked;


  Common.Data_Value_Format__Set( sql_editor_sdbm, Log_Memo, Data_Value_Format__Disabled_CheckBox.Checked );

end;

procedure TSql_Editor_F_Frame.Execute__Automatic_Detection_CheckBoxClick( Sender: TObject );
begin

  if    ( Sender <> nil )
    and ( Sender = Execute__Automatic_Detection_MenuItem ) then
    begin

      Execute__Automatic_Detection_CheckBox.OnClick := nil; // To avoid double function call.

      Execute__Automatic_Detection_CheckBox.Checked := Execute__Automatic_Detection_MenuItem.Checked;

      Execute__Automatic_Detection_CheckBox.OnClick := Execute__Automatic_Detection_CheckBoxClick;

    end
  else
    Execute__Automatic_Detection_MenuItem.Checked := Execute__Automatic_Detection_CheckBox.Checked;

end;

procedure TSql_Editor_F_Frame.Transactions_Automatic_CheckBoxClick( Sender: TObject );
begin

  if    ( Sender <> nil )
    and ( Sender = Transactions_Automatic_MenuItem ) then
    begin

      Transactions_Automatic_CheckBox.OnClick := nil; // To avoid double function call.

      Transactions_Automatic_CheckBox.Checked := Transactions_Automatic_MenuItem.Checked;

      Transactions_Automatic_CheckBox.OnClick := Transactions_Automatic_CheckBoxClick;

    end
  else
    Transactions_Automatic_MenuItem.Checked := Transactions_Automatic_CheckBox.Checked;

end;

procedure TSql_Editor_F_Frame.Tab_Name__Set_ButtonClick( Sender: TObject );
begin

  parent_caption_copy_g := Tab_Name_Edit.Text;


  Caret_Position_Display();

end;

procedure TSql_Editor_F_Frame.Tab_Name_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_RETURN then
    Tab_Name__Set_ButtonClick( Sender )
  else
    Key_Down_Common( Sender, Key, Shift );

end;

procedure TSql_Editor_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Left_Panel.Width := 1;


  Caret_Position_Display();

end;

procedure TSql_Editor_F_Frame.Bookmarks__Clear__All_MenuItemClick( Sender: TObject );
var
  i,
  x,
  y
    : integer;
begin

  if Bookmarks__Toggle__With__Line_Color_MenuItem.Checked then
    begin

      for i := 0 to 9 do
        if Sql_Text_SynEdit.GetBookMark( i, x, y ) then
          Sql_Text_SynEdit.Lines_Color__Clear( y );


      Sql_Text_SynEdit.Refresh();

    end;


  for i := 0 to 9 do
    if Sql_Text_SynEdit.IsBookmark( i ) then
      Sql_Text_SynEdit.ClearBookMark( i );

end;

procedure TSql_Editor_F_Frame.Database__Reconnect_MenuItemClick( Sender: TObject );
begin

  if Sender <> nil then
    begin

      if    (  Self.Task_Running_Check__SEF( false )  )
        and (  Application.MessageBox( PChar(Translation.translation__messages_r.task_is_still_running_wait_until_finish + #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES  ) then
        Exit;


      if Application.MessageBox( PChar(Translation.translation__messages_r.close_all_connections_), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
        Exit;

    end;


  if sql_editor_sdbm.Connected() then
    sql_editor_sdbm.Connection__Close();


  sql_editor_sdbm.Connection__Open( databases_r_copy_g, Log_Memo, sql_editor_sdbm.component_type__sdbm );


  Log_Memo.Lines.Add(    StringReplace(   System.TypInfo.GetEnumName(  System.TypeInfo(Common.TComponent_Type), Ord( sql_editor_sdbm.component_type__sdbm )  ), 'ct_', '', [ rfReplaceAll ]   )    );


  if    ( Sender <> nil )
    and ( sql_editor_sdbm.Connected() ) then
    Application.MessageBox( PChar(Translation.translation__messages_r.connection_successful), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

end;

procedure TSql_Editor_F_Frame.File_Path_EditExit( Sender: TObject );
begin

  if    ( Sender <> nil )
    and ( Sender is TEdit )then
    if    (  Trim( TEdit(Sender).Text ) <> ''  )
      and (  not FileExists( TEdit(Sender).Text )  ) then
      TEdit(Sender).Color := Common.color__red__light_c
    else
      TEdit(Sender).Color := clWindow;

end;

procedure TSql_Editor_F_Frame.Text__File__Find_ButtonClick( Sender: TObject );
begin

  if Trim( Text__File__Path_Edit.Text ) <> '' then
    begin

      OpenDialog1.InitialDir := ExtractFilePath( Text__File__Path_Edit.Text );

      OpenDialog1.FileName := ExtractFileName( Text__File__Path_Edit.Text )

    end;


  if OpenDialog1.Execute() then
    Text__File__Path_Edit.Text := OpenDialog1.FileName;


  File_Path_EditExit( Text__File__Path_Edit );

end;

procedure TSql_Editor_F_Frame.Text__File__Load_ButtonClick( Sender: TObject );
var
  line_number_copy_l : integer;
  file_name_copy_l : string;
begin

  if Trim( Text__File__Path_Edit.Text ) = '' then
    begin

      Text__File__Find_ButtonClick( Sender );


      if Trim( Text__File__Path_Edit.Text ) = '' then
        Exit;

    end;


  if not FileExists( Text__File__Path_Edit.Text ) then
    begin

      Application.MessageBox( PChar(Translation.translation__messages_r.file_not_found + ':' + #13 + #13 + Text__File__Path_Edit.Text + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  if    (  Trim( text__file__path_copy_g ) <> ''  )
    and ( text__file__text_copy_g <> Sql_Text_SynEdit.Lines.Text )
    and (  Application.MessageBox( PChar(Translation.translation__messages_r.file_changed_ + #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) = IDNO  ) then
    Exit;


  line_number_copy_l := Sql_Text_SynEdit.CaretY;
  file_name_copy_l := ExtractFileName( text__file__path_copy_g );


  Sql_Text_SynEdit.Lines.LoadFromFile( Text__File__Path_Edit.Text );

  text__file__path_copy_g := Text__File__Path_Edit.Text;
  text__file__text_copy_g := Sql_Text_SynEdit.Lines.Text;


  Tab_Name_Edit.Text := ExtractFileName( Text__File__Path_Edit.Text );

  Tab_Name__Set_ButtonClick( Sender ); // Call Caret_Position_Display().


  if    ( Sql_Text_SynEdit.Lines.Count >= line_number_copy_l )
    and (  ExtractFileName( text__file__path_copy_g ) = file_name_copy_l  ) then
    Sql_Text_SynEdit.GotoLineAndCenter( line_number_copy_l );

end;

procedure TSql_Editor_F_Frame.Text__File__Save_ButtonClick( Sender: TObject );
var
  text_file__path_copy_l : string;

  zt_encoding : System.SysUtils.TEncoding;
begin

  text_file__path_copy_l := '';


  if    ( text__file__path_copy_g = Text__File__Path_Edit.Text )
    and (  FileExists( Text__File__Path_Edit.Text )  ) then
    begin

      text_file__path_copy_l := text__file__path_copy_g;

    end
  else
    begin

      SaveDialog1.Filter := Translation.translation__messages_r.text_files + '|*' + Common.txt__file__default_extension + '|' + Translation.translation__messages_r.all_files + '|' + Common.all_files_find__filter;


      if DirectoryExists(  ExtractFilePath( Text__File__Path_Edit.Text )  ) then
        SaveDialog1.InitialDir := ExtractFilePath( Text__File__Path_Edit.Text )
      else
        Application.MessageBox(  PChar(Translation.translation__messages_r.directory_does_not_exist + ':' + #13 + #13 + ExtractFilePath( Text__File__Path_Edit.Text ) + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );


      if Trim( text__file__name_saved_g ) = '' then
        text__file__name_saved_g := Tab_Name_Edit.Text + Common.txt__file__default_extension;


      if text__file__path_copy_g <> Text__File__Path_Edit.Text then
        SaveDialog1.FileName := ExtractFileName( Text__File__Path_Edit.Text )
      else
        SaveDialog1.FileName := text__file__name_saved_g;


      if SaveDialog1.Execute() then
        text_file__path_copy_l := SaveDialog1.FileName;

    end;


  if Trim( text_file__path_copy_l ) <> '' then
    begin

      if Trim( Text__File__Encoding_ComboBox.Text ) <> '' then
        begin

          if Text__File__Encoding_ComboBox.Text = 'ANSI' then
            zt_encoding := System.SysUtils.TEncoding.ANSI
          else
          if Text__File__Encoding_ComboBox.Text = 'Unicode' then
            zt_encoding := System.SysUtils.TEncoding.Unicode
          else
          if Text__File__Encoding_ComboBox.Text = 'UTF8' then
            zt_encoding := System.SysUtils.TEncoding.UTF8
          else
            zt_encoding := nil;

        end
      else
        zt_encoding := nil;


      if Trim( Text__File__Path_Edit.Text ) = '' then
        Text__File__Path_Edit.Text := text_file__path_copy_l;


      if    (  Trim( Text__File__Encoding_ComboBox.Text ) <> ''  )
        and ( zt_encoding <> nil ) then
        begin

          Sql_Text_SynEdit.Lines.SaveToFile( Text__File__Path_Edit.Text, zt_encoding );

        end
      else
        Sql_Text_SynEdit.Lines.SaveToFile( Text__File__Path_Edit.Text );


      text__file__name_saved_g := ExtractFileName( text_file__path_copy_l );
      text__file__path_copy_g := text_file__path_copy_l;
      text__file__text_copy_g := Sql_Text_SynEdit.Lines.Text;

      Text__File__Path_Edit.Text := text_file__path_copy_l;


      Caret_Position_Display();

    end;

end;

procedure TSql_Editor_F_Frame.Text__FileKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Key_Down_Common( Sender, Key, Shift );

end;

procedure TSql_Editor_F_Frame.Sql_Text_MemoClick( Sender: TObject );
begin

  Caret_Position_Display();

end;

procedure TSql_Editor_F_Frame.Sql_Text_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_SPACE )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Sql_Text__Code_Completion_PopupMenu.Popup( 0, 0 );

      Key := 0;

    end
  else
  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Sql_Text_Memo.SelectAll()
  else
    Key_Down_Common( Sender, Key, Shift );

end;

procedure TSql_Editor_F_Frame.Sql_Text_MemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

  Key_Up_Common( Sender, Key, Shift );

end;

procedure TSql_Editor_F_Frame.Sql_Text_MemoMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin

  if    ( Button = mbRight )
    and ( Shift = [ ssCtrl ] ) then
    Sql_Text__Code_Completion_PopupMenu.Popup( 0, 0 );

end;

procedure TSql_Editor_F_Frame.Sql_Text_SynEditEnter( Sender: TObject );
begin

  Common.Text__Search_Replace__Syn_Edit__Set( Sql_Text_SynEdit, text__search_replace_form );

end;

procedure TSql_Editor_F_Frame.Sql_Text_SynEditClick( Sender: TObject );
begin

  Caret_Position_Display();

  Common.Syn_Edit__Highlight__Text( Sql_Text_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( Sql_Text_SynEdit, text__search_replace_form );

end;

procedure TSql_Editor_F_Frame.Sql_Text_SynEditDropFiles( Sender: TObject; X, Y: Integer; AFiles: TStrings );
begin

  if    ( AFiles <> nil  )
    and ( AFiles.Count > 0  )
    and (  FileExists( AFiles[ 0 ] )  ) then
    begin

      Text__File__Path_Edit.Text := AFiles[ 0 ];

      Text__File__Load_ButtonClick( Sender );

    end;

end;

procedure TSql_Editor_F_Frame.Sql_Text_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Common.Syn_Edit_Key_Down( Sql_Text_SynEdit, Sender, Key, Shift, Bookmarks__Toggle__With__Line_Color_MenuItem.Checked );


  Key_Down_Common( Sender, Key, Shift );

end;

procedure TSql_Editor_F_Frame.Sql_Text_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

  Common.Syn_Edit__Highlight__Text( Sql_Text_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( Sql_Text_SynEdit, text__search_replace_form );

  Key_Up_Common( Sender, Key, Shift );

end;

procedure TSql_Editor_F_Frame.Sql_Text_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );
begin

  Common.Syn_Edit__On_Replace_Text(  Sql_Text_SynEdit, ASearch, AReplace, Line, Column, Action, ClientToScreen( Self.ClientRect )  );

end;

procedure TSql_Editor_F_Frame.Sql_Text__Highlighter__Syntax__SetMenuItemClick( Sender: TObject );
begin

  if    ( Sender <> nil )
    and ( Sender is TMenuItem )
    and ( TMenuItem(Sender).GetParentComponent = Highlighter__Syntax_MenuItem ) then
    begin

      Sql_Text_SynEdit.Highlighter := Shared.Shared_DataModule.Syn_Edit__Highlighter__Get( TMenuItem(Sender).Hint );


      if   (
                 ( TMenuItem(Sender).Hint <> Shared.sql_editor__highlights__syntax__none_c )
             and ( Sql_Text_SynEdit.Highlighter = nil )
           )
        or (
                 ( TMenuItem(Sender).Hint <> Shared.sql_editor__highlights__syntax__none_c )
             and ( Sql_Text_SynEdit.Highlighter <> nil )
             and ( Sql_Text_SynEdit.Highlighter.Name <> TMenuItem(Sender).Hint )
           ) then
        Highlighter__Syntax_MenuItem__Check__Correct();

    end;

end;

procedure TSql_Editor_F_Frame.Sql_Text__Highlights__Brackets__SetMenuItemClick( Sender: TObject );
begin

  Highlights__Brackets_MenuItem__Enabled__Correct();


  Sql_Text_SynEdit.Plugin__Search_Highlighter__Brackets__Set
    (
      Highlights__Brackets__All_Pairs_MenuItem.Checked,
      Highlights__Brackets__Angle_MenuItem.Checked,
      Highlights__Brackets__Curly_MenuItem.Checked,
      Highlights__Brackets__Marked_Only_MenuItem.Checked,
      Highlights__Brackets__Round_MenuItem.Checked,
      Highlights__Brackets__Square_MenuItem.Checked
    );


  Common.Syn_Edit__Highlight__Text( Sql_Text_SynEdit );

end;

procedure TSql_Editor_F_Frame.Sql_Text__SynCompletionProposalCodeCompletion( Sender: TObject; var Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
begin

  Common.Syn_Completion_Proposal_Code_Completion( code_completion__cursor_position_g, Value );

end;

procedure TSql_Editor_F_Frame.Sql_Text__SynCompletionProposalAfterCodeCompletion( Sender: TObject; const Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
begin

  Common.Syn_Completion_Proposal_After_Code_Completion( Sql_Text_SynEdit, code_completion__cursor_position_g );

end;

procedure TSql_Editor_F_Frame.Sql_Text_PopupMenu__MenuItemClick_Common( Sender: TObject );
var
  do_refresh_l : boolean;

  key_l : word;

  shift_state_l : TShiftState;
begin

  do_refresh_l := false;
  key_l := 0;
  shift_state_l := [];


  if Sender <> nil then
    begin

      if Sender = Comment_Invert_Alternatively_MenuItem then
        begin

          shift_state_l := [ ssCtrl, ssShift ];

          key_l := VK_OEM_5; // \.

        end
      else
      if Sender = Comment_Uncomment_MenuItem then
        begin

          shift_state_l := [ ssCtrl ];

          key_l := VK_OEM_2; // /.


        end
      else
      if Sender = Comment_Uncomment_Alternatively_MenuItem then
        begin

          shift_state_l := [ ssCtrl ];

          key_l := VK_OEM_5; // \.

        end
      else
      if Sender = Copy_MenuItem then
        begin

          if Sql_Text_PopupMenu.PopupComponent = Sql_Editor_DBGrid then
            begin

              shift_state_l := [ ssCtrl ];

              key_l := 67; // C.

              Sql_Editor_DBGridKeyDown( Sender, key_l, shift_state_l );

              key_l := 0;

            end
          else
            begin

              if Sql_Text_SynEdit.SelText <> '' then
                Sql_Text_SynEdit.CopyToClipboard()
              else
                begin

                  shift_state_l := [ ssCtrl ];

                  key_l := 67; // C.

                end;

            end;

        end
      else
      if Sender = Cut_MenuItem then
        begin

          if Sql_Text_SynEdit.SelText <> '' then
            Sql_Text_SynEdit.CutToClipboard()
          else
            begin

              shift_state_l := [ ssCtrl ];

              key_l := 88; // X.

            end;

        end
      else
      if Sender = Find_MenuItem then
        begin

          shift_state_l := [ ssCtrl ];

          key_l := 70; // F.

        end
      else
      if Sender = Lines_Color__Toggle_MenuItem then
        begin

          key_l := VK_F5;

          do_refresh_l := true;

        end
      else
      if Sender = Lines_Color__Change_MenuItem then
        begin

          key_l := VK_F6;

          do_refresh_l := true;

        end
      else
      if Sender = Lines_Color__Choose_MenuItem then
        key_l := VK_F7
      else
      if Sender = Lines_Color__Clear__All_MenuItem then
        begin

          shift_state_l := [ ssShift ];

          key_l := VK_F5;

          do_refresh_l := true;

        end
      else
      if Sender = Paste_MenuItem then
        Sql_Text_SynEdit.PasteFromClipboard()
      else
      if Sender = Replace_MenuItem then
        begin

          shift_state_l := [ ssCtrl ];

          key_l := 72; // H.

        end
      else
      if Sender = Select_All_MenuItem then
        begin

          shift_state_l := [ ssCtrl ];

          key_l := 65; // A.

        end
      else
        if    ( Sender is TMenuItem )
          and ( TMenuItem(Sender).GetParentComponent = Bookmarks__Go_To_MenuItem )
          and (  Length( TMenuItem(Sender).MenuIndex.ToString() ) > 0  ) then
          begin

            shift_state_l := [ ssCtrl ];

            key_l := Ord( TMenuItem(Sender).MenuIndex.ToString()[ 1 ] );

          end
        else
        if    ( Sender is TMenuItem )
          and ( TMenuItem(Sender).GetParentComponent = Bookmarks__Toggle_MenuItem )
          and (  Length( TMenuItem(Sender).MenuIndex.ToString() ) > 0  )  then
          begin

            shift_state_l := [ ssCtrl, ssShift ];

            key_l := Ord( TMenuItem(Sender).MenuIndex.ToString()[ 1 ] );

          end;

    end;


  if key_l <> 0 then
    Common.Syn_Edit_Key_Down( Sql_Text_SynEdit, Sender, key_l, shift_state_l, Bookmarks__Toggle__With__Line_Color_MenuItem.Checked );


  if do_refresh_l then
    Sql_Text_SynEdit.Refresh();

end;

procedure TSql_Editor_F_Frame.Query_Output_Save_Field_FormatKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Key_Down_Common( Sender, Key, Shift );

end;

procedure TSql_Editor_F_Frame.Data_Preview_DBMemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Key_Down_Common( Sender, Key, Shift );

end;

procedure TSql_Editor_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TSql_Editor_F_Frame.Sql_Text_PopupMenuPopup( Sender: TObject );
var
  ztb : boolean;
begin

  if Sql_Text_PopupMenu.PopupComponent = Sql_Text_SynEdit then
    ztb := true
  else
    ztb := false;


  Bookmarks__Toggle_MenuItem.Enabled := ztb;
  Comment_Invert_Alternatively_MenuItem.Enabled := ztb;
  Comment_Uncomment_Alternatively_MenuItem.Enabled := ztb;
  Comment_Uncomment_MenuItem.Enabled := ztb;
  Cut_MenuItem.Enabled := ztb;
  Lines_Color__Change_MenuItem.Enabled := ztb;
  Lines_Color__Choose_MenuItem.Enabled := ztb;
  Lines_Color__Toggle_MenuItem.Enabled := ztb;
  Paste_MenuItem.Enabled := ztb;
  Select_All_MenuItem.Enabled := ztb;

end;

procedure TSql_Editor_F_Frame.Sql_Editor_DBGridCellClick( Column: TColumn );
begin

  Data_Preview();

  Caret_Position_Display();

end;

procedure TSql_Editor_F_Frame.Sql_Editor_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
begin

  Common.DB_Grid_Draw_Column_Cell( sort__column_name_g, Sql_Editor_DBGrid, Rect, DataCol, Column, State );

end;

procedure TSql_Editor_F_Frame.Sql_Editor_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( sql_editor_sdbm <> nil )
    and ( sql_editor_sdbm.Query__Active() )
    and ( sql_editor_sdbm.Query__Record_Count > 0 )
    and ( Sql_Editor_DBGrid.SelectedField <> nil ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Sql_Editor_DBGrid.SelectedField.Value;
    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end
  else
  // D.
  if    ( Key = 68 )
    and (
             ( Shift = [ ssCtrl ] )
          or ( Shift = [ ssShift ] )
        ) then
    Column__Values__Distinct()
  else
  // S.
  if    ( Key = 83 )
    and ( Shift = [ ssShift ] ) then // Ctrl + S is for Output_Save_Button.
    Column__Values__Sum()
  else
    Key_Down_Common( Sender, Key, Shift );

end;

procedure TSql_Editor_F_Frame.Sql_Editor_DBGridKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Data_Preview();

  Key_Up_Common( Sender, Key, Shift );

end;

procedure TSql_Editor_F_Frame.Sql_Editor_DBGridTitleClick( Column: TColumn );
begin

  if Column.Field = nil then
    Exit;


  if sort__column_name_g = Column.Field.FieldName then
    sort__direction_ascending_g := not sort__direction_ascending_g
  else
    sort__column_name_g := Column.Field.FieldName;

  sql_editor_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );


  Sql_Editor_Column_DBEditChange( nil ); // For FireDAC.

end;

end.
