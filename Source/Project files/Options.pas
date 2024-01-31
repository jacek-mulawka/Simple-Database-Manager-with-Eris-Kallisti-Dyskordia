unit Options;{20.Cze.2023}

  // It seems ini file trim spaces (' ').  //!!!

interface

uses
  Text__Search_Replace,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls, Vcl.ComCtrls,
  SynEdit, SynCompletionProposal, Vcl.CheckLst;

type
  TOptions_Form = class( TForm )
    Apply_Hint_Label: TLabel;
    Basic_TabSheet: TTabSheet;
    Bottom_Panel: TPanel;
    Cancel_Button: TButton;
    Caret_Position_Label: TLabel;
    Csv__File_GroupBox: TGroupBox;
    Csv__File__Data_Separator_Edit: TEdit;
    Csv__File__Data_Separator_GroupBox: TGroupBox;
    Csv__File__Text_Qualifier_Edit: TEdit;
    Csv__File__Text_Qualifier_GroupBox: TGroupBox;
    Data_Presentation_TabSheet: TTabSheet;
    Data_Presentation__Data_Value_Format_GroupBox: TGroupBox;
    Data_Presentation__Data_Value_Format__Date_Edit: TEdit;
    Data_Presentation__Data_Value_Format__Date_GroupBox: TGroupBox;
    Data_Presentation__Data_Value_Format__Date__Use_CheckBox: TCheckBox;
    Data_Presentation__Data_Value_Format__Date_Time_Edit: TEdit;
    Data_Presentation__Data_Value_Format__Date_Time_GroupBox: TGroupBox;
    Data_Presentation__Data_Value_Format__Date_Time__Use_CheckBox: TCheckBox;
    Data_Presentation__Data_Value_Format__Numbers_GroupBox: TGroupBox;
    Data_Presentation__Data_Value_Format__Numbers_Edit: TEdit;
    Data_Presentation__Data_Value_Format__Numbers__Use_CheckBox: TCheckBox;
    Data_Presentation__Data_Value_Format__Real_Numbers_Edit: TEdit;
    Data_Presentation__Data_Value_Format__Real_Numbers_GroupBox: TGroupBox;
    Data_Presentation__Data_Value_Format__Real_Numbers__Use_CheckBox: TCheckBox;
    Data_Presentation__Data_Value_Format__Time_Edit: TEdit;
    Data_Presentation__Data_Value_Format__Time_GroupBox: TGroupBox;
    Data_Presentation__Data_Value_Format__Time__Use_CheckBox: TCheckBox;
    Database__Backup_Restore_TabSheet: TTabSheet;
    Database__Backup__Application__File_Path__Find_Button: TButton;
    Database__Backup__Application__File_Path_Edit: TEdit;
    Database__Backup__Application__File_Path_GroupBox: TGroupBox;
    Database__Backup__File_Name__Suffix_Default_RadioGroup: TRadioGroup;
    Database__Correctness_Check_Text_GroupBox: TGroupBox;
    Database__Correctness_Check_Text__Backup_Edit: TEdit;
    Database__Correctness_Check_Text__Backup_Etiquette_Label: TLabel;
    Database__Correctness_Check_Text__Restore_Edit: TEdit;
    Database__Correctness_Check_Text__Restore_Etiquette_Label: TLabel;
    Database__Create__Application__File_Path_Edit: TEdit;
    Database__Create__Application__File_Path_GroupBox: TGroupBox;
    Database__Create__Application__File_Path__Find_Button: TButton;
    Fire_Dac__Querry__Fetch_Options_GroupBox: TGroupBox;
    Fire_Dac__Query__Fetch_Options__Mode_ComboBox: TComboBox;
    Fire_Dac__Query__Fetch_Options__Mode_Etiquette_Label: TLabel;
    Fire_Dac__Query__Fetch_Options__Record_Count_Mode_ComboBox: TComboBox;
    Fire_Dac__Query__Fetch_Options__Record_Count_Mode_Etiquette_Label: TLabel;
    Fire_Dac__Query__Fetch_Options__Rowset_Size_Etiquette_Label: TLabel;
    Fire_Dac__Query__Fetch_Options__Rowset_Size_SpinEdit: TSpinEdit;
    Fire_Dac_TabSheet: TTabSheet;
    FontDialog1: TFontDialog;
    Form_View__Additional_Component_Show_CheckBox: TCheckBox;
    Language_ComboBox: TComboBox;
    Language_Etiquette_Label: TLabel;
    Load_Button: TButton;
    Log__Auto_Scroll__GroupBox: TGroupBox;
    Log__Auto_Scroll__Seconds_SpinEdit: TSpinEdit;
    Ok_Button: TButton;
    OpenDialog1: TOpenDialog;
    Options_PageControl: TPageControl;
    Queries_Open_In_Background_CheckBox: TCheckBox;
    Save_Button: TButton;
    Splitter_Show_CheckBox: TCheckBox;
    Sql__Command_Separator_Edit: TEdit;
    Sql__Command_Separator_GroupBox: TGroupBox;
    Sql__External_Function__Parameter_Separator_GroupBox: TGroupBox;
    Sql__External_Function__Parameter_Separator_Memo: TMemo;
    Sql__Quotation_Sign__Use_CheckBox: TCheckBox;
    Sql__View__Parameter_Separator_GroupBox: TGroupBox;
    Sql__View__Parameter_Separator_Memo: TMemo;
    Sql_Editor_TabSheet: TTabSheet;
    Sql_Editor__Close_Prompt_CheckBox: TCheckBox;
    Sql_Editor__Code__Completion_Window_GroupBox: TGroupBox;
    Sql_Editor__Code__Completion_Window__Default__Lines_In_Window_GroupBox: TGroupBox;
    Sql_Editor__Code__Completion_Window__Default__Lines_In_Window_SpinEdit: TSpinEdit;
    Sql_Editor__Code__Completion_Window__Default__Width_GroupBox: TGroupBox;
    Sql_Editor__Code__Completion_Window__Default__Width_SpinEdit: TSpinEdit;
    Sql_Editor__Code__Dent_Width_GroupBox: TGroupBox;
    Sql_Editor__Code__Dent_Width_SpinEdit: TSpinEdit;
    Sql_Editor__Comments_Delete_CheckBox: TCheckBox;
    Sql_Editor__Execute_Automatic_Detection_CheckBox: TCheckBox;
    Sql_Editor__Font_Button: TButton;
    Sql_Editor__Left_Panel: TPanel;
    Sql_Editor__Query_Output_Save_Field_Format_GroupBox: TGroupBox;
    Sql_Editor__Query_Output_Save_Field_Format__Date_Edit: TEdit;
    Sql_Editor__Query_Output_Save_Field_Format__Date_Etiquette_Label: TLabel;
    Sql_Editor__Query_Output_Save_Field_Format__Real_Numbers_Edit: TEdit;
    Sql_Editor__Query_Output_Save_Field_Format__Real_Numbers_Etiquette_Label: TLabel;
    Sql_Editor__Query_Output_Save_Field_Format__Separator__Date_Time_Edit: TEdit;
    Sql_Editor__Query_Output_Save_Field_Format__Separator__Date_Time_GroupBox: TGroupBox;
    Sql_Editor__Query_Output_Save_Field_Format__Separator__Decimal_Edit: TEdit;
    Sql_Editor__Query_Output_Save_Field_Format__Separator__Decimal_GroupBox: TGroupBox;
    Sql_Editor__Query_Output_Save_Field_Format__Separators_GroupBox: TGroupBox;
    Sql_Editor__Query_Output_Save_Field_Format__Time_Edit: TEdit;
    Sql_Editor__Query_Output_Save_Field_Format__Time_Etiquette_Label: TLabel;
    Sql_Editor__Right_Panel: TPanel;
    Sql_Editor__Transactions_Automatic_CheckBox: TCheckBox;
    Sql_Editor__Words_Highlight_GroupBox: TGroupBox;
    Sql_Editor__Words_Highlight__Color__Background_ColorBox: TColorBox;
    Sql_Editor__Words_Highlight__Color__Background_Etiquette_Label: TLabel;
    Sql_Editor__Words_Highlight__Color__Border_ColorBox: TColorBox;
    Sql_Editor__Words_Highlight__Color__Border_Etiquette_Label: TLabel;
    Sql_Text_Memo: TMemo;
    Sql_Text_SynEdit: TSynEdit;
    Sql_Text__SynCompletionProposal: TSynCompletionProposal;
    Syn_Editor_Options_GroupBox: TGroupBox;
    Syn_Editor_Options_CheckListBox: TCheckListBox;
    System_Tables_Visible_CheckBox: TCheckBox;
    Table__Data_Filter_TabSheet: TTabSheet;
    Table__Data_Filter__Field_Dedicated__Default_Use_CheckBox: TCheckBox;
    Table__Data_Filter__Filter__Dedicated_Value_Format_GroupBox: TGroupBox;
    Table__Data_Filter__Filter__Dedicated_Value_Format__Date_Edit: TEdit;
    Table__Data_Filter__Filter__Dedicated_Value_Format__Date_Etiquette_Label: TLabel;
    Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Date_Time_Edit: TEdit;
    Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Date_Time_GroupBox: TGroupBox;
    Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Decimal_Edit: TEdit;
    Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Decimal_GroupBox: TGroupBox;
    Table__Data_Filter__Filter__Dedicated_Value_Format__Separators_GroupBox: TGroupBox;
    Table__Data_Filter__Filter__Dedicated_Value_Format__Time_Edit: TEdit;
    Table__Data_Filter__Filter__Dedicated_Value_Format__Time_Etiquette_Label: TLabel;
    Table__Data_Filter__Quotation_Sign__Use_CheckBox: TCheckBox;
    Table__Data_Modify__Editing__Default_State_CheckBox: TCheckBox;
    Text__Search__History_Save_To_File__Items_Count_Etiquette_Label: TLabel;
    Text__Search__History_Save_To_File__Items_Count_SpinEdit: TSpinEdit;
    Text__Search__History_Save_To_File_CheckBox: TCheckBox;
    Text__Search_Window_TabSheet: TTabSheet;
    Text__Search__Window__One_Common_CheckBox: TCheckBox;
    Translation_TabSheet: TTabSheet;

    procedure FormCreate( Sender: TObject );
    procedure FormDestroy( Sender: TObject );

    procedure Ok_ButtonClick( Sender: TObject );

    procedure Load_Save_ButtonClick( Sender: TObject );

    procedure File_Path_EditExit( Sender: TObject );
    procedure File_Path__Find_ButtonClick( Sender: TObject );
    procedure Sql_Editor__Font_ButtonClick( Sender: TObject );
    procedure Language_ComboBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Sql_Text_MemoClick( Sender: TObject );
    procedure Sql_Text_MemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Syn_Editor_Options_CheckListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Sql_Text_SynEditEnter( Sender: TObject );
    procedure Sql_Text_SynEditClick( Sender: TObject );
    procedure Sql_Text_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Sql_Text_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Sql_Text_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );

    procedure Sql_Text__SynCompletionProposalCodeCompletion( Sender: TObject; var Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
    procedure Sql_Text__SynCompletionProposalAfterCodeCompletion( Sender: TObject; const Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );

    function Syn_Edit_Keystrokes_Get() : string;
  private
    { Private declarations }
    code_completion__cursor_position_g,
    sql_editor__words_highlight__color__background__copy_g,
    sql_editor__words_highlight__color__border__copy_g
      : integer;

    text__search_replace_form : Text__Search_Replace.TText__Search_Replace_Form;

    procedure Caret_Position_Display();
    procedure Components_Value_Set();
    procedure Translation__List_Load();
    procedure Translation__Save_Load( const load_button_f : boolean = false; const save_f : boolean = false );
    procedure Variables_Value_Set();
  public
    { Public declarations }
  end;

const
  languages__file__name_c : string = 'Language.ini';
  options__file_name_c : string = 'Simple_Database_Manager.ini';

var
  Options_Form: TOptions_Form;

implementation

uses
  FireDAC.Stan.Option,
  System.IniFiles,
  System.IOUtils,
  System.StrUtils,
  System.TypInfo,

  Common,
  Shared,
  Translation;

{$R *.dfm}

procedure TOptions_Form.Caret_Position_Display();
begin

  //Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Sql_Text_Memo.CaretPos.Y + 1 )  ) + ' / ' + Trim(   FormatFloat( '### ### ### ### ### ### ##0', Sql_Text_Memo.CaretPos.X + 1 ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Sql_Text_Memo.Lines.Text.Length )  )   );
  Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Sql_Text_SynEdit.CaretY )  ) + ' / ' + Trim(   FormatFloat( '### ### ### ### ### ### ##0', Sql_Text_SynEdit.CaretX ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Sql_Text_SynEdit.Lines.Text.Length )  )   );

end;

procedure TOptions_Form.Components_Value_Set();
var
  i : integer;
begin

  Csv__File__Data_Separator_Edit.Text := Common.csv__file__data_separator;
  Csv__File__Text_Qualifier_Edit.Text := Common.csv__file__text_qualifier;
  Data_Presentation__Data_Value_Format__Date_Edit.Text := Common.data_presentation__data_value_format__date;
  Data_Presentation__Data_Value_Format__Date__Use_CheckBox.Checked := Common.data_presentation__data_value_format__date__use;
  Data_Presentation__Data_Value_Format__Date_Time_Edit.Text := Common.data_presentation__data_value_format__date_time;
  Data_Presentation__Data_Value_Format__Date_Time__Use_CheckBox.Checked := Common.data_presentation__data_value_format__date_time__use;
  Data_Presentation__Data_Value_Format__Numbers_Edit.Text := Common.data_presentation__data_value_format__numbers;
  Data_Presentation__Data_Value_Format__Numbers__Use_CheckBox.Checked := Common.data_presentation__data_value_format__numbers__use;
  Data_Presentation__Data_Value_Format__Real_Numbers_Edit.Text := Common.data_presentation__data_value_format__real_numbers;
  Data_Presentation__Data_Value_Format__Real_Numbers__Use_CheckBox.Checked := Common.data_presentation__data_value_format__real_numbers__use;
  Data_Presentation__Data_Value_Format__Time_Edit.Text := Common.data_presentation__data_value_format__time;
  Data_Presentation__Data_Value_Format__Time__Use_CheckBox.Checked := Common.data_presentation__data_value_format__time__use;
  Database__Backup__Application__File_Path_Edit.Text := Common.database__backup__application__file_path;

  if    ( Database__Backup__File_Name__Suffix_Default_RadioGroup.Items.Count > 0 )
    and ( Common.database__backup__file_name__suffix_default__item_index >= 0 )
    and ( Common.database__backup__file_name__suffix_default__item_index <= Database__Backup__File_Name__Suffix_Default_RadioGroup.Items.Count - 1 ) then
    Database__Backup__File_Name__Suffix_Default_RadioGroup.ItemIndex := Common.database__backup__file_name__suffix_default__item_index;

  Database__Correctness_Check_Text__Backup_Edit.Text := Common.database__correctness_check_text__backup;
  Database__Correctness_Check_Text__Restore_Edit.Text := Common.database__correctness_check_text__restore;
  Database__Create__Application__File_Path_Edit.Text := Common.database__create__application__file_path;

  if    ( Fire_Dac__Query__Fetch_Options__Mode_ComboBox.Items.Count > 0 )
    and ( integer(Common.fire_dac__fetch_options__mode) >= 0 )
    and ( integer(Common.fire_dac__fetch_options__mode) <= Fire_Dac__Query__Fetch_Options__Mode_ComboBox.Items.Count - 1 ) then
    Fire_Dac__Query__Fetch_Options__Mode_ComboBox.ItemIndex := integer(Common.fire_dac__fetch_options__mode);

  if    ( Fire_Dac__Query__Fetch_Options__Record_Count_Mode_ComboBox.Items.Count > 0 )
    and ( integer(Common.fire_dac__fetch_options__record_count_mode) >= 0 )
    and ( integer(Common.fire_dac__fetch_options__record_count_mode) <= Fire_Dac__Query__Fetch_Options__Record_Count_Mode_ComboBox.Items.Count - 1 ) then
    Fire_Dac__Query__Fetch_Options__Record_Count_Mode_ComboBox.ItemIndex := integer(Common.fire_dac__fetch_options__record_count_mode);

  Fire_Dac__Query__Fetch_Options__Rowset_Size_SpinEdit.Value := Common.fire_dac__fetch_options__rowset_size;

  Form_View__Additional_Component_Show_CheckBox.Checked := Common.form_view__additional_component_show;
  Log__Auto_Scroll__Seconds_SpinEdit.Value := Common.log__auto_scroll__seconds;

  Queries_Open_In_Background_CheckBox.Checked := Common.queries_open_in_background;
  Sql_Editor__Close_Prompt_CheckBox.Checked := Common.sql_editor__close_prompt;
  Sql_Editor__Code__Completion_Window__Default__Lines_In_Window_SpinEdit.Value := Common.sql_editor__code__completion_window__default__lines_in_window;
  Sql_Editor__Code__Completion_Window__Default__Width_SpinEdit.Value := Common.sql_editor__code__completion_window__default__width;
  Sql_Editor__Code__Dent_Width_SpinEdit.Value := Common.sql_editor__code__dent_width;
  Sql_Editor__Comments_Delete_CheckBox.Checked := Common.sql_editor__comments_delete;
  Sql_Editor__Execute_Automatic_Detection_CheckBox.Checked := Common.sql_editor__execute_automatic_detection;
  Sql_Editor__Transactions_Automatic_CheckBox.Checked := Common.sql_editor__transactions_automatic;
  Sql_Editor__Query_Output_Save_Field_Format__Date_Edit.Text := Common.sql_editor__query_output_save_field_format__date;
  Sql_Editor__Query_Output_Save_Field_Format__Real_Numbers_Edit.Text := Common.sql_editor__query_output_save_field_format__real_numbers;
  Sql_Editor__Query_Output_Save_Field_Format__Separator__Date_Time_Edit.Text := Common.sql_editor__query_output_save_field_format__separator__date_time;
  Sql_Editor__Query_Output_Save_Field_Format__Separator__Decimal_Edit.Text := Common.sql_editor__query_output_save_field_format__separator__decimal;
  Sql_Editor__Query_Output_Save_Field_Format__Time_Edit.Text := Common.sql_editor__query_output_save_field_format__time;
  Sql_Editor__Words_Highlight__Color__Background_ColorBox.Selected := Common.sql_editor__words_highlight__color__background;
  Sql_Editor__Words_Highlight__Color__Border_ColorBox.Selected := Common.sql_editor__words_highlight__color__border;
  //Common.Font__Set( Sql_Text_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Sql_Text_SynEdit.Font, Common.sql_editor__font );
  Common.Font__Set( FontDialog1.Font, Common.sql_editor__font );
  Sql__Command_Separator_Edit.Text := Common.sql__command_separator;
  Sql__External_Function__Parameter_Separator_Memo.Lines.Text := Common.sql__external_function__parameter_separator;
  Sql__Quotation_Sign__Use_CheckBox.Checked := Common.sql__quotation_sign__use;
  Sql__View__Parameter_Separator_Memo.Lines.Text := Common.sql__view__parameter_separator;
  Splitter_Show_CheckBox.Checked := Common.splitter_show;

  for i := 0 to Syn_Editor_Options_CheckListBox.Items.Count - 1 do
    if SynEdit.TSynEditorOption(i) in Common.syn_editor_options then
      Syn_Editor_Options_CheckListBox.Checked[ i ] := true;

  System_Tables_Visible_CheckBox.Checked := Common.system_tables_visible;
  Table__Data_Filter__Field_Dedicated__Default_Use_CheckBox.Checked := Common.table__data_filter__field_dedicated__default_use;
  Table__Data_Filter__Filter__Dedicated_Value_Format__Date_Edit.Text := Common.table__data_filter__filter__dedicated_value_format__date;
  Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Date_Time_Edit.Text := Common.table__data_filter__filter__dedicated_value_format__separator__date_time;
  Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Decimal_Edit.Text := Common.table__data_filter__filter__dedicated_value_format__separator__decimal;
  Table__Data_Filter__Filter__Dedicated_Value_Format__Time_Edit.Text := Common.table__data_filter__filter__dedicated_value_format__time;
  Table__Data_Filter__Quotation_Sign__Use_CheckBox.Checked := Common.table__data_filter__quotation_sign__use;
  Table__Data_Modify__Editing__Default_State_CheckBox.Checked := Common.table__data_modify__editing__default_state;
  Text__Search__History_Save_To_File_CheckBox.Checked := Common.text__search__history_save_to_file;
  Text__Search__History_Save_To_File__Items_Count_SpinEdit.Value := Common.text__search__history_save_to_file__items_count;
  Text__Search__Window__One_Common_CheckBox.Checked := Common.text__search__window__one_common;

end;

function TOptions_Form.Syn_Edit_Keystrokes_Get() : string;
var
  i,
  j
    : integer;

  zts_1,
  zts_2
    : string;
begin

  Result := '';

  for i := 0 to Sql_Text_SynEdit.Keystrokes.Count - 1 do
    begin

      zts_1 := Sql_Text_SynEdit.Keystrokes.Items[ i ].DisplayName; // ecActName - KeyName

      if Trim( zts_1 ) <> '' then
        begin

          Delete( zts_1, 1, 2 );
          zts_2 := '';

          for j := 1 to Length( zts_1 ) do
            begin

              if zts_1[ j ] = ' ' then
                begin

                  zts_2 := '    ' + zts_2 + Copy(  zts_1, j, Length( zts_1 )  );
                  Break;

                end;

              if    ( j > 1 )
                and (  zts_1[ j ] = AnsiUpperCase( zts_1[ j ] )  ) then
                zts_2 := zts_2 + ' ';

              zts_2 := zts_2 + zts_1[ j ];

            end;


          if Trim( Result ) <> '' then
            Result := Result + #13 + #10;

          Result := Result + zts_2;

        end;

    end;


  if Trim( Result ) <> '' then
    Result := Translation.translation__messages_r.sql_editor_default_keystrokes + #13 + #10 + Result;

end;

procedure TOptions_Form.Translation__List_Load();
var
  i : integer;

  zts,
  language_name_copy_l
    : string;

  search_rec : TSearchRec;
begin

  language_name_copy_l := Language_ComboBox.Text;
  Language_ComboBox.Items.Clear();
  Language_ComboBox.Items.Add( Translation.translation__differentiator__default_sign_c + Translation.translation__messages_r.default + '>' );
  Language_ComboBox.ItemIndex := 0;

  if FindFirst(  ExtractFilePath( Application.ExeName ) + Common.languages__directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + '*' + Common.languages__file__extension_c, faAnyFile, search_rec  ) = 0 then
    begin

      repeat

        // Adds file names without extension.

        zts := search_rec.Name;
        zts := System.StrUtils.ReverseString( zts );
        Delete(  zts, 1, Pos( '.', zts )  );
        zts := System.StrUtils.ReverseString( zts );

        Language_ComboBox.Items.Add( zts );

      until FindNext( search_rec ) <> 0

    end;

  FindClose( search_rec );

  if Trim( language_name_copy_l ) <> '' then
    for i := Language_ComboBox.Items.Count - 1 downto 0 do
      if   ( Language_ComboBox.Items[ i ] = language_name_copy_l )
        or (
                 (  Pos( Translation.translation__differentiator__default_sign_c, language_name_copy_l ) > 0  )
             and (  Pos( Translation.translation__differentiator__default_sign_c, Language_ComboBox.Items[ i ] ) > 0  )
           ) then
        begin

          Language_ComboBox.ItemIndex := i;
          Break;

        end;

end;

procedure TOptions_Form.Translation__Save_Load( const load_button_f : boolean = false; const save_f : boolean = false );
var
  i : integer;

  zts : string;

  tekst_string_list : TStringList;
begin

  zts := ExtractFilePath( Application.ExeName ) + Common.languages__directory_name_c;

  if not DirectoryExists( zts ) then
    begin

      Application.MessageBox( PChar(Translation.translation__messages_r.languages_directory_does_not_exist + #13 + #13 + zts + #13 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

    end
  else
    begin

      tekst_string_list := TStringList.Create();

      zts := ExtractFilePath( Application.ExeName ) + Common.languages__directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + languages__file__name_c;

      if   (  save_f )
        or (  not FileExists( zts )  ) then
        begin

          if    ( Language_ComboBox.ItemIndex >= 0 )
            and ( Language_ComboBox.ItemIndex <= Language_ComboBox.Items.Count - 1 ) then
            tekst_string_list.Text := Language_ComboBox.Items[ Language_ComboBox.ItemIndex ];

          if Trim( tekst_string_list.Text ) = '' then
            tekst_string_list.Text := Translation.translation__differentiator__default_sign_c + Translation.translation__messages_r.default + '>';

          tekst_string_list.SaveToFile( zts, System.SysUtils.TEncoding.UTF8 );

        end
      else
        begin

          if   (  load_button_f )
            or (  Trim( Common.language__selected ) = ''  ) then
            begin

              tekst_string_list.LoadFromFile( zts );
              zts := tekst_string_list.Text;
              zts := StringReplace( zts, #$D#$A, '', [ rfReplaceAll ] );

            end
          else
            zts := Common.language__selected;


          if    (  Pos( Translation.translation__differentiator__default_sign_c, zts ) > 0  )
            and ( Language_ComboBox.Items.Count > 0 ) then
            Language_ComboBox.ItemIndex := 0
          else
            for i := Language_ComboBox.Items.Count - 1 downto 0 do
              if Language_ComboBox.Items[ i ] = zts then
                begin

                  Language_ComboBox.ItemIndex := i;
                  Break;

                end;

        end;

      FreeAndNil( tekst_string_list );

    end;

end;

procedure TOptions_Form.Variables_Value_Set();
var
  i : integer;
begin

  Common.csv__file__data_separator := Csv__File__Data_Separator_Edit.Text;
  Common.csv__file__text_qualifier := Csv__File__Text_Qualifier_Edit.Text;
  Common.data_presentation__data_value_format__date := Data_Presentation__Data_Value_Format__Date_Edit.Text;
  Common.data_presentation__data_value_format__date__use := Data_Presentation__Data_Value_Format__Date__Use_CheckBox.Checked;
  Common.data_presentation__data_value_format__date_time := Data_Presentation__Data_Value_Format__Date_Time_Edit.Text;
  Common.data_presentation__data_value_format__date_time__use := Data_Presentation__Data_Value_Format__Date_Time__Use_CheckBox.Checked;
  Common.data_presentation__data_value_format__numbers := Data_Presentation__Data_Value_Format__Numbers_Edit.Text;
  Common.data_presentation__data_value_format__numbers__use := Data_Presentation__Data_Value_Format__Numbers__Use_CheckBox.Checked;
  Common.data_presentation__data_value_format__real_numbers := Data_Presentation__Data_Value_Format__Real_Numbers_Edit.Text;
  Common.data_presentation__data_value_format__real_numbers__use := Data_Presentation__Data_Value_Format__Real_Numbers__Use_CheckBox.Checked;
  Common.data_presentation__data_value_format__time := Data_Presentation__Data_Value_Format__Time_Edit.Text;
  Common.data_presentation__data_value_format__time__use := Data_Presentation__Data_Value_Format__Time__Use_CheckBox.Checked;
  Common.database__backup__application__file_path := Database__Backup__Application__File_Path_Edit.Text;
  Common.database__backup__file_name__suffix_default__item_index := Database__Backup__File_Name__Suffix_Default_RadioGroup.ItemIndex;
  Common.database__correctness_check_text__backup := Database__Correctness_Check_Text__Backup_Edit.Text;
  Common.database__correctness_check_text__restore := Database__Correctness_Check_Text__Restore_Edit.Text;
  Common.database__create__application__file_path := Database__Create__Application__File_Path_Edit.Text;

  Common.fire_dac__fetch_options__mode := TFDFetchMode(Fire_Dac__Query__Fetch_Options__Mode_ComboBox.ItemIndex);
  Common.fire_dac__fetch_options__record_count_mode := TFDRecordCountMode(Fire_Dac__Query__Fetch_Options__Record_Count_Mode_ComboBox.ItemIndex);
  Common.fire_dac__fetch_options__rowset_size := Fire_Dac__Query__Fetch_Options__Rowset_Size_SpinEdit.Value;

  Common.form_view__additional_component_show := Form_View__Additional_Component_Show_CheckBox.Checked;

  Common.language__selected := Language_ComboBox.Text;
  Common.log__auto_scroll__seconds := Log__Auto_Scroll__Seconds_SpinEdit.Value;
  Common.queries_open_in_background := Queries_Open_In_Background_CheckBox.Checked;
  Common.sql_editor__close_prompt := Sql_Editor__Close_Prompt_CheckBox.Checked;
  Common.sql_editor__code__completion_window__default__lines_in_window := Sql_Editor__Code__Completion_Window__Default__Lines_In_Window_SpinEdit.Value;
  Common.sql_editor__code__completion_window__default__width := Sql_Editor__Code__Completion_Window__Default__Width_SpinEdit.Value;
  Common.sql_editor__code__dent_width := Sql_Editor__Code__Dent_Width_SpinEdit.Value;
  Common.sql_editor__comments_delete := Sql_Editor__Comments_Delete_CheckBox.Checked;
  Common.sql_editor__execute_automatic_detection := Sql_Editor__Execute_Automatic_Detection_CheckBox.Checked;
  //Common.Font__Set( Common.sql_editor__font, Sql_Text_Memo.Font );
  Common.Font__Set( Common.sql_editor__font, Sql_Text_SynEdit.Font );
  Common.sql_editor__transactions_automatic := Sql_Editor__Transactions_Automatic_CheckBox.Checked;
  Common.sql_editor__query_output_save_field_format__date := Sql_Editor__Query_Output_Save_Field_Format__Date_Edit.Text;
  Common.sql_editor__query_output_save_field_format__real_numbers := Sql_Editor__Query_Output_Save_Field_Format__Real_Numbers_Edit.Text;
  Common.sql_editor__query_output_save_field_format__separator__date_time := Sql_Editor__Query_Output_Save_Field_Format__Separator__Date_Time_Edit.Text;
  Common.sql_editor__query_output_save_field_format__separator__decimal := Sql_Editor__Query_Output_Save_Field_Format__Separator__Decimal_Edit.Text;
  Common.sql_editor__query_output_save_field_format__time := Sql_Editor__Query_Output_Save_Field_Format__Time_Edit.Text;
  Common.sql_editor__words_highlight__color__background := Sql_Editor__Words_Highlight__Color__Background_ColorBox.Selected;
  Common.sql_editor__words_highlight__color__border := Sql_Editor__Words_Highlight__Color__Border_ColorBox.Selected;
  Common.sql__command_separator := Sql__Command_Separator_Edit.Text;
  Common.sql__external_function__parameter_separator := Sql__External_Function__Parameter_Separator_Memo.Lines.Text;
  Common.sql__quotation_sign__use := Sql__Quotation_Sign__Use_CheckBox.Checked;
  Common.sql__view__parameter_separator := Sql__View__Parameter_Separator_Memo.Lines.Text;
  Common.splitter_show := Splitter_Show_CheckBox.Checked;
  Common.system_tables_visible := System_Tables_Visible_CheckBox.Checked;

  Common.syn_editor_options := [];

  for i := 0 to Syn_Editor_Options_CheckListBox.Items.Count - 1 do
    if Syn_Editor_Options_CheckListBox.Checked[ i ] then
      Common.syn_editor_options := Common.syn_editor_options + [ SynEdit.TSynEditorOption(i) ];

  Common.table__data_filter__field_dedicated__default_use := Table__Data_Filter__Field_Dedicated__Default_Use_CheckBox.Checked;
  Common.table__data_filter__filter__dedicated_value_format__date := Table__Data_Filter__Filter__Dedicated_Value_Format__Date_Edit.Text;
  Common.table__data_filter__filter__dedicated_value_format__separator__date_time := Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Date_Time_Edit.Text;
  Common.table__data_filter__filter__dedicated_value_format__separator__decimal := Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Decimal_Edit.Text;
  Common.table__data_filter__filter__dedicated_value_format__time := Table__Data_Filter__Filter__Dedicated_Value_Format__Time_Edit.Text;
  Common.table__data_filter__quotation_sign__use := Table__Data_Filter__Quotation_Sign__Use_CheckBox.Checked;
  Common.table__data_modify__editing__default_state := Table__Data_Modify__Editing__Default_State_CheckBox.Checked;
  Common.text__search__history_save_to_file := Text__Search__History_Save_To_File_CheckBox.Checked;
  Common.text__search__history_save_to_file__items_count := Text__Search__History_Save_To_File__Items_Count_SpinEdit.Value;
  Common.text__search__window__one_common := Text__Search__Window__One_Common_CheckBox.Checked;


  Common.Syn_Completion_Proposal__Parameters__Set( Sql_Text__SynCompletionProposal );

  Common.Syn_Edit__Parameters__Set( Sql_Text_SynEdit );

end;

procedure TOptions_Form.FormCreate( Sender: TObject );
var
  zti_1,
  zti_2
    : integer;

  zts_1,
  zts_2
    : string;

  fetch_options__mode_l : TFDFetchMode;
  fetch_options__record_count_mode_l : TFDRecordCountMode;
  syn_editor_option_l : SynEdit.TSynEditorOption;
begin

  code_completion__cursor_position_g := -1;
  sql_editor__words_highlight__color__background__copy_g := Common.sql_editor__words_highlight__color__background;
  sql_editor__words_highlight__color__border__copy_g := Common.sql_editor__words_highlight__color__border;

  text__search_replace_form := nil;


  Apply_Hint_Label.Hint := Apply_Hint_Label.Caption;

  Options_PageControl.ActivePage := Basic_TabSheet;

  OpenDialog1.Filter := Translation.translation__messages_r.application_files + '|*' + Common.exe__file__default_extension + '|' + Translation.translation__messages_r.all_files + '|' + Common.all_files_find__filter;


  Fire_Dac__Query__Fetch_Options__Mode_ComboBox.Items.Clear();
  Fire_Dac__Query__Fetch_Options__Record_Count_Mode_ComboBox.Items.Clear();


  for fetch_options__mode_l := Low( TFDFetchMode ) to High( TFDFetchMode ) do
    Fire_Dac__Query__Fetch_Options__Mode_ComboBox.Items.Add(   System.TypInfo.GetEnumName(  System.TypeInfo(TFDFetchMode), Ord( fetch_options__mode_l )  )   );

  for fetch_options__record_count_mode_l := Low( TFDRecordCountMode ) to High( TFDRecordCountMode ) do
    Fire_Dac__Query__Fetch_Options__Record_Count_Mode_ComboBox.Items.Add(   System.TypInfo.GetEnumName(  System.TypeInfo(TFDRecordCountMode), Ord( fetch_options__record_count_mode_l )  )   );


  Syn_Editor_Options_CheckListBox.Items.Clear();

  for syn_editor_option_l := Low( SynEdit.TSynEditorOption ) to High( SynEdit.TSynEditorOption ) do
    Syn_Editor_Options_CheckListBox.Items.Add(   System.TypInfo.GetEnumName(  System.TypeInfo(SynEdit.TSynEditorOption), Ord( syn_editor_option_l )  )   );


  Translation__List_Load();

  Translation__Save_Load();


  Components_Value_Set();


  File_Path_EditExit( Database__Backup__Application__File_Path_Edit );
  File_Path_EditExit( Database__Create__Application__File_Path_Edit );


  Common.Syn_Completion_Proposal__Parameters__Set( Sql_Text__SynCompletionProposal );

  Common.Syn_Edit__Parameters__Set( Sql_Text_SynEdit );


  zts_1 := Common.sql_editor__code_completion_list_c;
  zts_1 := StringReplace( zts_1, Translation.translation__code_completion__sql_c, Translation.translation__messages_r.code_completion__sql, [ rfReplaceAll ] );

  zti_1 := Pos( #13 + #10, zts_1 );

  while zti_1 > 1 do
    begin

      zts_2 := Copy( zts_1, 1, zti_1 - 1 );

      zti_2 := Pos( Common.code_completion__caption_value_separator_c, zts_1 );


      Sql_Text__SynCompletionProposal.ItemList.Add(  Copy( zts_2, 1, zti_2 - 1 )  );

      Delete(  zts_2, 1, zti_2 + Length( Common.code_completion__caption_value_separator_c ) - 1  );
      zts_2 := StringReplace( zts_2, Common.newline_symbol_c, #13 + #10, [ rfReplaceAll ] );

      Sql_Text__SynCompletionProposal.InsertList.Add( zts_2 );


      Delete( zts_1, 1, zti_1 + 1 );


      zti_1 := Pos( #13 + #10, zts_1 );

    end;

  for zti_1 := 1 to 100 do
    begin

      Sql_Text__SynCompletionProposal.InsertList.Add(   translation__messages_r.word__name + '_' + Trim(  FormatFloat( '000', zti_1 )  )   );
      Sql_Text__SynCompletionProposal.ItemList.Add(   '\color{clHighlight}' + Translation.translation__messages_r.code_completion__table + ' \color{clWindowText}\column{}\style{+B}' + translation__messages_r.word__name + '_' + Trim(  FormatFloat( '000', zti_1 )  ) + '\style{-B}'   );

    end;


  Common.Syn_Edit__Search_Text_Hightlighter_Syn_Edit_Plugin__Create( Sql_Text_SynEdit );


  Translation.Translation__Apply( Self );


  Common.Text__Search_Replace__Hide( text__search_replace_form );

end;

procedure TOptions_Form.FormDestroy( Sender: TObject );
begin

  Syn_Editor_Options_CheckListBox.Items.Clear();


  Common.Text__Search_Replace__Syn_Edit__Set( nil, text__search_replace_form );
  Common.Text__Search_Replace__Hide( text__search_replace_form );


  if text__search_replace_form <> nil then
    FreeAndNil( text__search_replace_form );

end;

procedure TOptions_Form.Ok_ButtonClick( Sender: TObject );
begin

  Variables_Value_Set();

  Translation.Translation__Default_Set(); // If something is missing from the translation then the default value will remain.
  Translation.Translation__Load();

  ModalResult := mrOk;

end;

procedure TOptions_Form.Load_Save_ButtonClick( Sender: TObject );

  procedure Font__To_Stream__Save( stream_f : TStream; font_f : TFont );
  var
    zt_log_font : TLogFont;
    zt_color : TColor;
  begin

    // https://stackoverflow.com/questions/19163832/how-to-convert-a-fontfontstyle-fontcolor-fontsize-to-a-string

    if GetObject(  font_f.Handle, SizeOf( zt_log_font ), @zt_log_font  ) = 0 then
      RaiseLastOSError();

    stream_f.WriteBuffer(  zt_log_font, SizeOf( zt_log_font )  );
    zt_color := font_f.Color;
    stream_f.WriteBuffer(  zt_color, SizeOf( zt_color )  );

  end;

  procedure Font__From_Stream__Load( stream_f : TStream; font_f : TFont );
  var
    zt_log_font : TLogFont;
    zt_hfont : HFONT;
    zt_color : TColor;
  begin

    // https://stackoverflow.com/questions/19163832/how-to-convert-a-fontfontstyle-fontcolor-fontsize-to-a-string

    stream_f.ReadBuffer(  zt_log_font, SizeOf( zt_log_font )  );
    zt_hfont := CreateFontIndirect( zt_log_font );

    if zt_hfont = 0 then
      RaiseLastOSError();

    font_f.Handle := zt_hfont;
    stream_f.ReadBuffer(  zt_color, SizeOf( zt_color )  );
    font_f.Color := zt_color;

  end;

var
  save_l : boolean;

  zti : integer;

  zts : string;

  file_ini : System.IniFiles.TIniFile;

  zt_string_stream : TStringStream;
begin

  if    ( Sender <> nil )
    and ( TComponent(Sender).Name = Save_Button.Name ) then
    save_l := true
  else
    save_l := false;


  file_ini := System.IniFiles.TIniFile.Create(  ExtractFilePath( Application.ExeName ) + options__file_name_c  );

  zt_string_stream := TStringStream.Create();


  {$region 'Ini file.'}
  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'csv__file__data_separator' )  ) then
    file_ini.WriteString( 'Options', 'csv__file__data_separator', Csv__File__Data_Separator_Edit.Text )
  else
    Csv__File__Data_Separator_Edit.Text := file_ini.ReadString( 'Options', 'csv__file__data_separator', Csv__File__Data_Separator_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'csv__file__text_qualifier' )  ) then
    file_ini.WriteString( 'Options', 'csv__file__text_qualifier', Csv__File__Text_Qualifier_Edit.Text )
  else
    Csv__File__Text_Qualifier_Edit.Text := file_ini.ReadString( 'Options', 'csv__file__text_qualifier', Csv__File__Text_Qualifier_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'data_presentation__data_value_format__date' )  ) then
    file_ini.WriteString( 'Options', 'data_presentation__data_value_format__date', Data_Presentation__Data_Value_Format__Date_Edit.Text )
  else
    Data_Presentation__Data_Value_Format__Date_Edit.Text := file_ini.ReadString( 'Options', 'data_presentation__data_value_format__date', Data_Presentation__Data_Value_Format__Date_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'data_presentation__data_value_format__date__use' )  ) then
    file_ini.WriteBool( 'Options', 'data_presentation__data_value_format__date__use', Data_Presentation__Data_Value_Format__Date__Use_CheckBox.Checked )
  else
    Data_Presentation__Data_Value_Format__Date__Use_CheckBox.Checked := file_ini.ReadBool( 'Options', 'data_presentation__data_value_format__date__use', Data_Presentation__Data_Value_Format__Date__Use_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'data_presentation__data_value_format__date_time' )  ) then
    file_ini.WriteString( 'Options', 'data_presentation__data_value_format__date_time', Data_Presentation__Data_Value_Format__Date_Time_Edit.Text )
  else
    Data_Presentation__Data_Value_Format__Date_Time_Edit.Text := file_ini.ReadString( 'Options', 'data_presentation__data_value_format__date_time', Data_Presentation__Data_Value_Format__Date_Time_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'data_presentation__data_value_format__date_time__use' )  ) then
    file_ini.WriteBool( 'Options', 'data_presentation__data_value_format__date_time__use', Data_Presentation__Data_Value_Format__Date_Time__Use_CheckBox.Checked )
  else
    Data_Presentation__Data_Value_Format__Date_Time__Use_CheckBox.Checked := file_ini.ReadBool( 'Options', 'data_presentation__data_value_format__date_time__use', Data_Presentation__Data_Value_Format__Date_Time__Use_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'data_presentation__data_value_format__numbers' )  ) then
    file_ini.WriteString( 'Options', 'data_presentation__data_value_format__numbers', Data_Presentation__Data_Value_Format__Numbers_Edit.Text )
  else
    Data_Presentation__Data_Value_Format__Numbers_Edit.Text := file_ini.ReadString( 'Options', 'data_presentation__data_value_format__numbers', Data_Presentation__Data_Value_Format__Numbers_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'data_presentation__data_value_format__numbers__use' )  ) then
    file_ini.WriteBool( 'Options', 'data_presentation__data_value_format__numbers__use', Data_Presentation__Data_Value_Format__Numbers__Use_CheckBox.Checked )
  else
    Data_Presentation__Data_Value_Format__Numbers__Use_CheckBox.Checked := file_ini.ReadBool( 'Options', 'data_presentation__data_value_format__numbers__use', Data_Presentation__Data_Value_Format__Numbers__Use_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'data_presentation__data_value_format__real_numbers' )  ) then
    file_ini.WriteString( 'Options', 'data_presentation__data_value_format__real_numbers', Data_Presentation__Data_Value_Format__Real_Numbers_Edit.Text )
  else
    Data_Presentation__Data_Value_Format__Real_Numbers_Edit.Text := file_ini.ReadString( 'Options', 'data_presentation__data_value_format__real_numbers', Data_Presentation__Data_Value_Format__Real_Numbers_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'data_presentation__data_value_format__real_numbers__use' )  ) then
    file_ini.WriteBool( 'Options', 'data_presentation__data_value_format__real_numbers__use', Data_Presentation__Data_Value_Format__Real_Numbers__Use_CheckBox.Checked )
  else
    Data_Presentation__Data_Value_Format__Real_Numbers__Use_CheckBox.Checked := file_ini.ReadBool( 'Options', 'data_presentation__data_value_format__real_numbers__use', Data_Presentation__Data_Value_Format__Real_Numbers__Use_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'data_presentation__data_value_format__time' )  ) then
    file_ini.WriteString( 'Options', 'data_presentation__data_value_format__time', Data_Presentation__Data_Value_Format__Time_Edit.Text )
  else
    Data_Presentation__Data_Value_Format__Time_Edit.Text := file_ini.ReadString( 'Options', 'data_presentation__data_value_format__time', Data_Presentation__Data_Value_Format__Time_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'data_presentation__data_value_format__time__use' )  ) then
    file_ini.WriteBool( 'Options', 'data_presentation__data_value_format__time__use', Data_Presentation__Data_Value_Format__Time__Use_CheckBox.Checked )
  else
    Data_Presentation__Data_Value_Format__Time__Use_CheckBox.Checked := file_ini.ReadBool( 'Options', 'data_presentation__data_value_format__time__use', Data_Presentation__Data_Value_Format__Time__Use_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'database__backup__application__file_path' )  ) then
    file_ini.WriteString( 'Options', 'database__backup__application__file_path', Database__Backup__Application__File_Path_Edit.Text )
  else
    Database__Backup__Application__File_Path_Edit.Text := file_ini.ReadString( 'Options', 'database__backup__application__file_path', Database__Backup__Application__File_Path_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'database__backup__file_name__suffix_default__item_index' )  ) then
    file_ini.WriteInteger( 'Options', 'database__backup__file_name__suffix_default__item_index', Database__Backup__File_Name__Suffix_Default_RadioGroup.ItemIndex )
  else
    begin

      zti := file_ini.ReadInteger( 'Options', 'database__backup__file_name__suffix_default__item_index', Database__Backup__File_Name__Suffix_Default_RadioGroup.ItemIndex );

      if    ( Database__Backup__File_Name__Suffix_Default_RadioGroup.Items.Count > 0 )
        and ( zti >= 0 )
        and ( zti <= Database__Backup__File_Name__Suffix_Default_RadioGroup.Items.Count - 1 ) then
        Database__Backup__File_Name__Suffix_Default_RadioGroup.ItemIndex := zti;


    end;


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'database__correctness_check_text__backup' )  ) then
    file_ini.WriteString( 'Options', 'database__correctness_check_text__backup', Database__Correctness_Check_Text__Backup_Edit.Text )
  else
    Database__Correctness_Check_Text__Backup_Edit.Text := file_ini.ReadString( 'Options', 'database__correctness_check_text__backup', Database__Correctness_Check_Text__Backup_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'database__correctness_check_text__restore' )  ) then
    file_ini.WriteString( 'Options', 'database__correctness_check_text__restore', Database__Correctness_Check_Text__Restore_Edit.Text )
  else
    Database__Correctness_Check_Text__Restore_Edit.Text := file_ini.ReadString( 'Options', 'database__correctness_check_text__restore', Database__Correctness_Check_Text__Restore_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'database__create__application__file_path' )  ) then
    file_ini.WriteString( 'Options', 'database__create__application__file_path', Database__Create__Application__File_Path_Edit.Text )
  else
    Database__Create__Application__File_Path_Edit.Text := file_ini.ReadString( 'Options', 'database__create__application__file_path', Database__Create__Application__File_Path_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'fire_dac__fetch_options__mode' )  ) then
    file_ini.WriteInteger( 'Options', 'fire_dac__fetch_options__mode', Fire_Dac__Query__Fetch_Options__Mode_ComboBox.ItemIndex )
  else
    begin

      zti := file_ini.ReadInteger( 'Options', 'fire_dac__fetch_options__mode', Fire_Dac__Query__Fetch_Options__Mode_ComboBox.ItemIndex );

      if    (  zti >= integer(Low( TFDFetchMode ))  )
        and (  zti <= integer(High( TFDFetchMode ))  )
        and ( Fire_Dac__Query__Fetch_Options__Mode_ComboBox.Items.Count > 0 )
        and ( zti >= 0 )
        and ( zti <= Fire_Dac__Query__Fetch_Options__Mode_ComboBox.Items.Count - 1 ) then
        Fire_Dac__Query__Fetch_Options__Mode_ComboBox.ItemIndex := zti;

    end;


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'fire_dac__fetch_options__record_count_mode' )  ) then
    file_ini.WriteInteger( 'Options', 'fire_dac__fetch_options__record_count_mode', Fire_Dac__Query__Fetch_Options__Record_Count_Mode_ComboBox.ItemIndex )
  else
    begin

      zti := file_ini.ReadInteger( 'Options', 'fire_dac__fetch_options__record_count_mode', Fire_Dac__Query__Fetch_Options__Record_Count_Mode_ComboBox.ItemIndex );

      if    (  zti >= integer(Low( TFDRecordCountMode ))  )
        and (  zti <= integer(High( TFDRecordCountMode ))  )
        and ( Fire_Dac__Query__Fetch_Options__Record_Count_Mode_ComboBox.Items.Count > 0 )
        and ( zti >= 0 )
        and ( zti <= Fire_Dac__Query__Fetch_Options__Record_Count_Mode_ComboBox.Items.Count - 1 ) then
        Fire_Dac__Query__Fetch_Options__Record_Count_Mode_ComboBox.ItemIndex := zti;

    end;


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'fire_dac__fetch_options__rowset_size' )  ) then
    file_ini.WriteInteger( 'Options', 'fire_dac__fetch_options__rowset_size', Fire_Dac__Query__Fetch_Options__Rowset_Size_SpinEdit.Value )
  else
    Fire_Dac__Query__Fetch_Options__Rowset_Size_SpinEdit.Value := file_ini.ReadInteger( 'Options', 'fire_dac__fetch_options__rowset_size', Fire_Dac__Query__Fetch_Options__Rowset_Size_SpinEdit.Value );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'form_view__additional_component_show' )  ) then
    file_ini.WriteBool( 'Options', 'form_view__additional_component_show', Form_View__Additional_Component_Show_CheckBox.Checked )
  else
    Form_View__Additional_Component_Show_CheckBox.Checked := file_ini.ReadBool( 'Options', 'form_view__additional_component_show', Form_View__Additional_Component_Show_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'log__auto_scroll__seconds' )  ) then
    file_ini.WriteInteger( 'Options', 'log__auto_scroll__seconds', Log__Auto_Scroll__Seconds_SpinEdit.Value )
  else
    begin

      Log__Auto_Scroll__Seconds_SpinEdit.Value := file_ini.ReadInteger( 'Options', 'log__auto_scroll__seconds', Log__Auto_Scroll__Seconds_SpinEdit.Value );

      if Log__Auto_Scroll__Seconds_SpinEdit.Value < -1 then
        Log__Auto_Scroll__Seconds_SpinEdit.Value := -1;

    end;


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'queries_open_in_background' )  ) then
    file_ini.WriteBool( 'Options', 'queries_open_in_background', Queries_Open_In_Background_CheckBox.Checked )
  else
    Queries_Open_In_Background_CheckBox.Checked := file_ini.ReadBool( 'Options', 'queries_open_in_background', Queries_Open_In_Background_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'splitter_show' )  ) then
    file_ini.WriteBool( 'Options', 'splitter_show', Splitter_Show_CheckBox.Checked )
  else
    Splitter_Show_CheckBox.Checked := file_ini.ReadBool( 'Options', 'splitter_show', Splitter_Show_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__close_prompt' )  ) then
    file_ini.WriteBool( 'Options', 'sql_editor__close_prompt', Sql_Editor__Close_Prompt_CheckBox.Checked )
  else
    Sql_Editor__Close_Prompt_CheckBox.Checked := file_ini.ReadBool( 'Options', 'sql_editor__close_prompt', Sql_Editor__Close_Prompt_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__code__completion_window__default__lines_in_window' )  ) then
    file_ini.WriteInteger( 'Options', 'sql_editor__code__completion_window__default__lines_in_window', Sql_Editor__Code__Completion_Window__Default__Lines_In_Window_SpinEdit.Value )
  else
    begin

      Sql_Editor__Code__Completion_Window__Default__Lines_In_Window_SpinEdit.Value := file_ini.ReadInteger( 'Options', 'sql_editor__code__completion_window__default__lines_in_window', Sql_Editor__Code__Completion_Window__Default__Lines_In_Window_SpinEdit.Value );

      if Sql_Editor__Code__Completion_Window__Default__Lines_In_Window_SpinEdit.Value < 1 then
        Sql_Editor__Code__Completion_Window__Default__Lines_In_Window_SpinEdit.Value := 1;

    end;


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__code__completion_window__default__width' )  ) then
    file_ini.WriteInteger( 'Options', 'sql_editor__code__completion_window__default__width', Sql_Editor__Code__Completion_Window__Default__Width_SpinEdit.Value )
  else
    begin

      Sql_Editor__Code__Completion_Window__Default__Width_SpinEdit.Value := file_ini.ReadInteger( 'Options', 'sql_editor__code__completion_window__default__width', Sql_Editor__Code__Completion_Window__Default__Width_SpinEdit.Value );

      if Sql_Editor__Code__Completion_Window__Default__Width_SpinEdit.Value < 1 then
        Sql_Editor__Code__Completion_Window__Default__Width_SpinEdit.Value := 1;

    end;


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__code__dent_width' )  ) then
    file_ini.WriteInteger( 'Options', 'sql_editor__code__dent_width', Sql_Editor__Code__Dent_Width_SpinEdit.Value )
  else
    begin

      Sql_Editor__Code__Dent_Width_SpinEdit.Value := file_ini.ReadInteger( 'Options', 'sql_editor__code__dent_width', Sql_Editor__Code__Dent_Width_SpinEdit.Value );

      if Sql_Editor__Code__Dent_Width_SpinEdit.Value < 1 then
        Sql_Editor__Code__Dent_Width_SpinEdit.Value := 1;

    end;


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__comments_delete' )  ) then
    file_ini.WriteBool( 'Options', 'sql_editor__comments_delete', Sql_Editor__Comments_Delete_CheckBox.Checked )
  else
    Sql_Editor__Comments_Delete_CheckBox.Checked := file_ini.ReadBool( 'Options', 'sql_editor__comments_delete', Sql_Editor__Comments_Delete_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__execute_automatic_detection' )  ) then
    file_ini.WriteBool( 'Options', 'sql_editor__execute_automatic_detection', Sql_Editor__Execute_Automatic_Detection_CheckBox.Checked )
  else
    Sql_Editor__Execute_Automatic_Detection_CheckBox.Checked := file_ini.ReadBool( 'Options', 'sql_editor__execute_automatic_detection', Sql_Editor__Execute_Automatic_Detection_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__font' )  ) then
    begin

      zt_string_stream.Clear();
      //Font__To_Stream__Save( zt_string_stream, Sql_Text_Memo.Font );
      Font__To_Stream__Save( zt_string_stream, Sql_Text_SynEdit.Font );
      zt_string_stream.Position := 0;

      file_ini.WriteBinaryStream( 'Options', 'sql_editor__font', zt_string_stream );

      zt_string_stream.Clear();

    end
  else
    begin

      zt_string_stream.Clear();

      file_ini.ReadBinaryStream( 'Options', 'sql_editor__font', zt_string_stream );

      zt_string_stream.Position := 0;
      //Font__From_Stream__Load( zt_string_stream, Sql_Text_Memo.Font );
      Font__From_Stream__Load( zt_string_stream, Sql_Text_SynEdit.Font );
      zt_string_stream.Clear();


      Common.Font__Set( FontDialog1.Font, Sql_Text_SynEdit.Font );

    end;


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__transactions_automatic' )  ) then
    file_ini.WriteBool( 'Options', 'sql_editor__transactions_automatic', Sql_Editor__Transactions_Automatic_CheckBox.Checked )
  else
    Sql_Editor__Transactions_Automatic_CheckBox.Checked := file_ini.ReadBool( 'Options', 'sql_editor__transactions_automatic', Sql_Editor__Transactions_Automatic_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__query_output_save_field_format__date' )  ) then
    file_ini.WriteString( 'Options', 'sql_editor__query_output_save_field_format__date', Sql_Editor__Query_Output_Save_Field_Format__Date_Edit.Text )
  else
    Sql_Editor__Query_Output_Save_Field_Format__Date_Edit.Text := file_ini.ReadString( 'Options', 'sql_editor__query_output_save_field_format__date', Sql_Editor__Query_Output_Save_Field_Format__Date_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__query_output_save_field_format__real_numbers' )  ) then
    file_ini.WriteString( 'Options', 'sql_editor__query_output_save_field_format__real_numbers', Sql_Editor__Query_Output_Save_Field_Format__Real_Numbers_Edit.Text )
  else
    Sql_Editor__Query_Output_Save_Field_Format__Real_Numbers_Edit.Text := file_ini.ReadString( 'Options', 'sql_editor__query_output_save_field_format__real_numbers', Sql_Editor__Query_Output_Save_Field_Format__Real_Numbers_Edit.Text );


  // It seems ini file trim spaces (' ').
  //if   (  save_l )
  //  or (  not file_ini.ValueExists( 'Options', 'sql_editor__query_output_save_field_format__separator__date_time' )  ) then
  //  file_ini.WriteString( 'Options', 'sql_editor__query_output_save_field_format__separator__date_time', Sql_Editor__Query_Output_Save_Field_Format__Separator__Date_Time_Edit.Text )
  //else
  //  Sql_Editor__Query_Output_Save_Field_Format__Separator__Date_Time_Edit.Text := file_ini.ReadString( 'Options', 'sql_editor__query_output_save_field_format__separator__date_time', Sql_Editor__Query_Output_Save_Field_Format__Separator__Date_Time_Edit.Text );
  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__query_output_save_field_format__separator__date_time' )  ) then
    begin

      zt_string_stream.Clear();
      zt_string_stream.WriteString( Sql_Editor__Query_Output_Save_Field_Format__Separator__Date_Time_Edit.Text );
      zt_string_stream.Position := 0;

      file_ini.WriteBinaryStream( 'Options', 'sql_editor__query_output_save_field_format__separator__date_time', zt_string_stream );

      zt_string_stream.Clear();

    end
  else
    begin

      zt_string_stream.Clear();

      file_ini.ReadBinaryStream( 'Options', 'sql_editor__query_output_save_field_format__separator__date_time', zt_string_stream );

      Sql_Editor__Query_Output_Save_Field_Format__Separator__Date_Time_Edit.Text := zt_string_stream.DataString;
      zt_string_stream.Clear();

    end;


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__query_output_save_field_format__separator__decimal' )  ) then
    file_ini.WriteString( 'Options', 'sql_editor__query_output_save_field_format__separator__decimal', Sql_Editor__Query_Output_Save_Field_Format__Separator__Decimal_Edit.Text )
  else
    Sql_Editor__Query_Output_Save_Field_Format__Separator__Decimal_Edit.Text := file_ini.ReadString( 'Options', 'sql_editor__query_output_save_field_format__separator__decimal', Sql_Editor__Query_Output_Save_Field_Format__Separator__Decimal_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__query_output_save_field_format__time' )  ) then
    file_ini.WriteString( 'Options', 'sql_editor__query_output_save_field_format__time', Sql_Editor__Query_Output_Save_Field_Format__Time_Edit.Text )
  else
    Sql_Editor__Query_Output_Save_Field_Format__Time_Edit.Text := file_ini.ReadString( 'Options', 'sql_editor__query_output_save_field_format__time', Sql_Editor__Query_Output_Save_Field_Format__Time_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__words_highlight__color__background' )  ) then
    file_ini.WriteString(  'Options', 'sql_editor__words_highlight__color__background', Vcl.Graphics.ColorToString( Sql_Editor__Words_Highlight__Color__Background_ColorBox.Selected )  )
  else
    Sql_Editor__Words_Highlight__Color__Background_ColorBox.Selected := Vcl.Graphics.StringToColor(   file_ini.ReadString(  'Options', 'sql_editor__words_highlight__color__background', Vcl.Graphics.ColorToString( Sql_Editor__Words_Highlight__Color__Background_ColorBox.Selected )  )   );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql_editor__words_highlight__color__border' )  ) then
    file_ini.WriteString(  'Options', 'sql_editor__words_highlight__color__border', Vcl.Graphics.ColorToString( Sql_Editor__Words_Highlight__Color__Border_ColorBox.Selected )  )
  else
    Sql_Editor__Words_Highlight__Color__Border_ColorBox.Selected := Vcl.Graphics.StringToColor(   file_ini.ReadString(  'Options', 'sql_editor__words_highlight__color__border', Vcl.Graphics.ColorToString( Sql_Editor__Words_Highlight__Color__Border_ColorBox.Selected )  )   );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql__command_separator' )  ) then
    file_ini.WriteString( 'Options', 'sql__command_separator', Sql__Command_Separator_Edit.Text )
  else
    Sql__Command_Separator_Edit.Text := file_ini.ReadString( 'Options', 'sql__command_separator', Sql__Command_Separator_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql__external_function__parameter_separator' )  ) then
    begin

      // It seems ini file trim spaces (' ').

      zt_string_stream.Clear();
      zt_string_stream.WriteString( Sql__External_Function__Parameter_Separator_Memo.Lines.Text );
      zt_string_stream.Position := 0;

      file_ini.WriteBinaryStream( 'Options', 'sql__external_function__parameter_separator', zt_string_stream );

      zt_string_stream.Clear();

    end
  else
    begin

      zt_string_stream.Clear();

      file_ini.ReadBinaryStream( 'Options', 'sql__external_function__parameter_separator', zt_string_stream );

      Sql__External_Function__Parameter_Separator_Memo.Lines.Text := zt_string_stream.DataString;
      zt_string_stream.Clear();

    end;


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql__quotation_sign__use' )  ) then
    file_ini.WriteBool( 'Options', 'sql__quotation_sign__use', Sql__Quotation_Sign__Use_CheckBox.Checked )
  else
    Sql__Quotation_Sign__Use_CheckBox.Checked := file_ini.ReadBool( 'Options', 'sql__quotation_sign__use', Sql__Quotation_Sign__Use_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'sql__view__parameter_separator' )  ) then
    begin

      // It seems ini file trim spaces (' ').

      zt_string_stream.Clear();
      zt_string_stream.WriteString( Sql__View__Parameter_Separator_Memo.Lines.Text );
      zt_string_stream.Position := 0;

      file_ini.WriteBinaryStream( 'Options', 'sql__view__parameter_separator', zt_string_stream );

      zt_string_stream.Clear();

    end
  else
    begin

      zt_string_stream.Clear();

      file_ini.ReadBinaryStream( 'Options', 'sql__view__parameter_separator', zt_string_stream );

      Sql__View__Parameter_Separator_Memo.Lines.Text := zt_string_stream.DataString;
      zt_string_stream.Clear();

    end;


  zts := '';

  for zti := 0 to Syn_Editor_Options_CheckListBox.Items.Count - 1 do
    if Syn_Editor_Options_CheckListBox.Checked[ zti ] then
      begin

        if Trim( zts ) <> '' then
          zts := zts +
            ', ';

        zts := zts +
          Syn_Editor_Options_CheckListBox.Items[ zti ];

      end;

  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'syn_editor_options' )  ) then
    begin

      file_ini.WriteString( 'Options', 'syn_editor_options', zts );

    end
  else
    begin

      zts := file_ini.ReadString( 'Options', 'syn_editor_options', zts );

      Syn_Editor_Options_CheckListBox.CheckAll( cbUnchecked, false, false );

      for zti := 0 to Syn_Editor_Options_CheckListBox.Items.Count - 1 do
        if Pos( ', ' + Syn_Editor_Options_CheckListBox.Items[ zti ] + ',', ', ' + zts + ',' ) > 0 then
          Syn_Editor_Options_CheckListBox.Checked[ zti ] := true;

    end;


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'system_tables_visible' )  ) then
    file_ini.WriteBool( 'Options', 'system_tables_visible', System_Tables_Visible_CheckBox.Checked )
  else
    System_Tables_Visible_CheckBox.Checked := file_ini.ReadBool( 'Options', 'system_tables_visible', System_Tables_Visible_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'table__data_filter__field_dedicated__default_use' )  ) then
    file_ini.WriteBool( 'Options', 'table__data_filter__field_dedicated__default_use', Table__Data_Filter__Field_Dedicated__Default_Use_CheckBox.Checked )
  else
    Table__Data_Filter__Field_Dedicated__Default_Use_CheckBox.Checked := file_ini.ReadBool( 'Options', 'table__data_filter__field_dedicated__default_use', Table__Data_Filter__Field_Dedicated__Default_Use_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'table__data_filter__filter__dedicated_value_format__date' )  ) then
    file_ini.WriteString( 'Options', 'table__data_filter__filter__dedicated_value_format__date', Table__Data_Filter__Filter__Dedicated_Value_Format__Date_Edit.Text )
  else
    Table__Data_Filter__Filter__Dedicated_Value_Format__Date_Edit.Text := file_ini.ReadString( 'Options', 'table__data_filter__filter__dedicated_value_format__date', Table__Data_Filter__Filter__Dedicated_Value_Format__Date_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'table__data_filter__filter__dedicated_value_format__separator__date_time' )  ) then
    begin

      zt_string_stream.Clear();
      zt_string_stream.WriteString( Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Date_Time_Edit.Text );
      zt_string_stream.Position := 0;

      file_ini.WriteBinaryStream( 'Options', 'table__data_filter__filter__dedicated_value_format__separator__date_time', zt_string_stream );

      zt_string_stream.Clear();

    end
  else
    begin

      zt_string_stream.Clear();

      file_ini.ReadBinaryStream( 'Options', 'table__data_filter__filter__dedicated_value_format__separator__date_time', zt_string_stream );

      Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Date_Time_Edit.Text := zt_string_stream.DataString;
      zt_string_stream.Clear();

    end;


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'table__data_filter__filter__dedicated_value_format__separator__decimal' )  ) then
    file_ini.WriteString( 'Options', 'table__data_filter__filter__dedicated_value_format__separator__decimal', Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Decimal_Edit.Text )
  else
    Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Decimal_Edit.Text := file_ini.ReadString( 'Options', 'table__data_filter__filter__dedicated_value_format__separator__decimal', Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Decimal_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'table__data_filter__filter__dedicated_value_format__time' )  ) then
    file_ini.WriteString( 'Options', 'table__data_filter__filter__dedicated_value_format__time', Table__Data_Filter__Filter__Dedicated_Value_Format__Time_Edit.Text )
  else
    Table__Data_Filter__Filter__Dedicated_Value_Format__Time_Edit.Text := file_ini.ReadString( 'Options', 'table__data_filter__filter__dedicated_value_format__time', Table__Data_Filter__Filter__Dedicated_Value_Format__Time_Edit.Text );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'table__data_filter__quotation_sign__use' )  ) then
    file_ini.WriteBool( 'Options', 'table__data_filter__quotation_sign__use', Table__Data_Filter__Quotation_Sign__Use_CheckBox.Checked )
  else
    Table__Data_Filter__Quotation_Sign__Use_CheckBox.Checked := file_ini.ReadBool( 'Options', 'table__data_filter__quotation_sign__use', Table__Data_Filter__Quotation_Sign__Use_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'table__data_modify__editing__default_state' )  ) then
    file_ini.WriteBool( 'Options', 'table__data_modify__editing__default_state', Table__Data_Modify__Editing__Default_State_CheckBox.Checked )
  else
    Table__Data_Modify__Editing__Default_State_CheckBox.Checked := file_ini.ReadBool( 'Options', 'table__data_modify__editing__default_state', Table__Data_Modify__Editing__Default_State_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'text__search__history_save_to_file' )  ) then
    file_ini.WriteBool( 'Options', 'text__search__history_save_to_file', Text__Search__History_Save_To_File_CheckBox.Checked )
  else
    Text__Search__History_Save_To_File_CheckBox.Checked := file_ini.ReadBool( 'Options', 'text__search__history_save_to_file', Text__Search__History_Save_To_File_CheckBox.Checked );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'text__search__history_save_to_file__items_count' )  ) then
    file_ini.WriteInteger( 'Options', 'text__search__history_save_to_file__items_count', Text__Search__History_Save_To_File__Items_Count_SpinEdit.Value )
  else
    begin

      Text__Search__History_Save_To_File__Items_Count_SpinEdit.Value := file_ini.ReadInteger( 'Options', 'text__search__history_save_to_file__items_count', Text__Search__History_Save_To_File__Items_Count_SpinEdit.Value );

      if Text__Search__History_Save_To_File__Items_Count_SpinEdit.Value < 0 then
        Text__Search__History_Save_To_File__Items_Count_SpinEdit.Value := 0;

    end;


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Options', 'text__search__window__one_common' )  ) then
    file_ini.WriteBool( 'Options', 'text__search__window__one_common', Text__Search__Window__One_Common_CheckBox.Checked )
  else
    Text__Search__Window__One_Common_CheckBox.Checked := file_ini.ReadBool( 'Options', 'text__search__window__one_common', Text__Search__Window__One_Common_CheckBox.Checked );



  if   (  save_l )
    or (  not file_ini.ValueExists( 'Settings', 'all_files_find__filter' )  ) then
    file_ini.WriteString( 'Settings', 'all_files_find__filter', Common.all_files_find__filter )
  else
    Common.all_files_find__filter := file_ini.ReadString( 'Settings', 'all_files_find__filter', Common.all_files_find__filter );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Settings', 'csv__file__default_extension' )  ) then
    file_ini.WriteString( 'Settings', 'csv__file__default_extension', Common.csv__file__default_extension )
  else
    Common.csv__file__default_extension := file_ini.ReadString( 'Settings', 'csv__file__default_extension', Common.csv__file__default_extension );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Settings', 'database__backup_restore__quotation_sign' )  ) then
    file_ini.WriteString( 'Settings', 'database__backup_restore__quotation_sign', Common.database__backup_restore__quotation_sign )
  else
    Common.database__backup_restore__quotation_sign := file_ini.ReadString( 'Settings', 'database__backup_restore__quotation_sign', Common.database__backup_restore__quotation_sign );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Settings', 'database__backup__file__default_extension' )  ) then
    file_ini.WriteString( 'Settings', 'database__backup__file__default_extension', Common.database__backup__file__default_extension )
  else
    Common.database__backup__file__default_extension := file_ini.ReadString( 'Settings', 'database__backup__file__default_extension', Common.database__backup__file__default_extension );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Settings', 'database__file__default_extension' )  ) then
    file_ini.WriteString( 'Settings', 'database__file__default_extension', Common.database__file__default_extension )
  else
    Common.database__file__default_extension := file_ini.ReadString( 'Settings', 'database__file__default_extension', Common.database__file__default_extension );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Settings', 'exe__file__default_extension' )  ) then
    file_ini.WriteString( 'Settings', 'exe__file__default_extension', Common.exe__file__default_extension )
  else
    Common.exe__file__default_extension := file_ini.ReadString( 'Settings', 'exe__file__default_extension', Common.exe__file__default_extension );


  //if   (  save_l )
  //  or (  not file_ini.ValueExists( 'Settings', 'fd_connection__format_options__max_string_size' )  ) then
  //  file_ini.WriteInteger( 'Settings', 'fd_connection__format_options__max_string_size', Common.fd_connection__format_options__max_string_size )
  //else
  //  Common.fd_connection__format_options__max_string_size := file_ini.ReadInteger( 'Settings', 'fd_connection__format_options__max_string_size', Common.fd_connection__format_options__max_string_size );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Settings', 'sql__comment__begin' )  ) then
    file_ini.WriteString( 'Settings', 'sql__comment__begin', Common.sql__comment__begin )
  else
    Common.sql__comment__begin := file_ini.ReadString( 'Settings', 'sql__comment__begin', Common.sql__comment__begin );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Settings', 'sql__comment__end' )  ) then
    file_ini.WriteString( 'Settings', 'sql__comment__end', Common.sql__comment__end )
  else
    Common.sql__comment__end := file_ini.ReadString( 'Settings', 'sql__comment__end', Common.sql__comment__end );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Settings', 'sql__comment__line' )  ) then
    file_ini.WriteString( 'Settings', 'sql__comment__line', Common.sql__comment__line )
  else
    Common.sql__comment__line := file_ini.ReadString( 'Settings', 'sql__comment__line', Common.sql__comment__line );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Settings', 'sql__names_separator' )  ) then
    file_ini.WriteString( 'Settings', 'sql__names_separator', Common.sql__names_separator )
  else
    Common.sql__names_separator := file_ini.ReadString( 'Settings', 'sql__names_separator', Common.sql__names_separator );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Settings', 'sql__text_separator' )  ) then
    file_ini.WriteString( 'Settings', 'sql__text_separator', Common.sql__text_separator )
  else
    Common.sql__text_separator := file_ini.ReadString( 'Settings', 'sql__text_separator', Common.sql__text_separator );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Settings', 'table__data_modify__filter__height_keeper__top' )  ) then
    file_ini.WriteInteger( 'Settings', 'table__data_modify__filter__height_keeper__top', Common.table__data_modify__filter__height_keeper__top )
  else
    Common.table__data_modify__filter__height_keeper__top := file_ini.ReadInteger( 'Settings', 'table__data_modify__filter__height_keeper__top', Common.table__data_modify__filter__height_keeper__top );


  if   (  save_l )
    or (  not file_ini.ValueExists( 'Settings', 'txt__file__default_extension' )  ) then
    file_ini.WriteString( 'Settings', 'txt__file__default_extension', Common.txt__file__default_extension )
  else
    Common.txt__file__default_extension := file_ini.ReadString( 'Settings', 'txt__file__default_extension', Common.txt__file__default_extension );
  {$endregion 'Ini file.'}


  file_ini.Free();


  zt_string_stream.Clear();
  FreeAndNil( zt_string_stream );


  Translation__Save_Load( true, save_l );


  File_Path_EditExit( Database__Backup__Application__File_Path_Edit );
  File_Path_EditExit( Database__Create__Application__File_Path_Edit );


  if Self.Visible then
    Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

end;

procedure TOptions_Form.File_Path_EditExit( Sender: TObject );
begin

  if    ( Sender <> nil )
    and ( Sender is TEdit )then
    if    (  Trim( TEdit(Sender).Text ) <> ''  )
      and (  not FileExists( TEdit(Sender).Text )  ) then
      TEdit(Sender).Color := Common.color__red__light_c
    else
      TEdit(Sender).Color := clWindow;

end;

procedure TOptions_Form.File_Path__Find_ButtonClick( Sender: TObject );
var
  zt_edit : TEdit;
begin

  if Sender <> nil then
    begin

      zt_edit := nil;


      if TComponent(Sender).Name = Database__Create__Application__File_Path__Find_Button.Name then
        begin

          zt_edit := Database__Create__Application__File_Path_Edit;

        end
      else
        begin

          zt_edit := Database__Backup__Application__File_Path_Edit;

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

procedure TOptions_Form.Sql_Editor__Font_ButtonClick( Sender: TObject );
begin

  if FontDialog1.Execute() then
    begin

      //Common.Font__Set( Sql_Text_Memo.Font, FontDialog1.Font );
      Common.Font__Set( Sql_Text_SynEdit.Font, FontDialog1.Font );

    end;

end;

procedure TOptions_Form.Language_ComboBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
var
  language_selected_copy_l : string;
begin

  {$IFNDEF DEBUG}
  Exit; // For test only (confusing effect for the OK button).
  {$ENDIF}


  if Key = VK_RETURN then
    begin

      Translation.Translation__Default_Set();


      language_selected_copy_l := Common.language__selected;

      Common.language__selected := Language_ComboBox.Text;


      Translation.Translation__Load();


      Common.language__selected := language_selected_copy_l;


      Translation.Translation__Apply( Self );


      OpenDialog1.Filter := Translation.translation__messages_r.application_files + '|*' + Common.exe__file__default_extension + '|' + Translation.translation__messages_r.all_files + '|' + Common.all_files_find__filter;

    end;

end;

procedure TOptions_Form.Sql_Text_MemoClick( Sender: TObject );
begin

  Caret_Position_Display();

end;

procedure TOptions_Form.Sql_Text_MemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

end;

procedure TOptions_Form.Syn_Editor_Options_CheckListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
var
  i : integer;
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Syn_Editor_Options_CheckListBox.CheckAll( cbChecked, false, false )
  else
  // N.
  if    ( Key = 78 )
    and ( Shift = [ ssCtrl ] ) then
    Syn_Editor_Options_CheckListBox.CheckAll( cbUnchecked, false, false )
  else
  // I.
  if    ( Key = 73 )
    and ( Shift = [ ssCtrl ] ) then
    for i := 0 to Syn_Editor_Options_CheckListBox.Items.Count - 1 do
      Syn_Editor_Options_CheckListBox.Checked[ i ] := not Syn_Editor_Options_CheckListBox.Checked[ i ];

end;

procedure TOptions_Form.Sql_Text_SynEditEnter( Sender: TObject );
var
  i : integer;
begin

  Common.Text__Search_Replace__Syn_Edit__Set( Sql_Text_SynEdit, text__search_replace_form );


  if Sql_Text__SynCompletionProposal.NbLinesInWindow <> Sql_Editor__Code__Completion_Window__Default__Lines_In_Window_SpinEdit.Value then
    Sql_Text__SynCompletionProposal.NbLinesInWindow := Sql_Editor__Code__Completion_Window__Default__Lines_In_Window_SpinEdit.Value;

  if Sql_Text__SynCompletionProposal.Width <> Sql_Editor__Code__Completion_Window__Default__Width_SpinEdit.Value then
    Sql_Text__SynCompletionProposal.Width := Sql_Editor__Code__Completion_Window__Default__Width_SpinEdit.Value;


  if Sql_Text_SynEdit.TabWidth <> Sql_Editor__Code__Dent_Width_SpinEdit.Value then
    Sql_Text_SynEdit.TabWidth := Sql_Editor__Code__Dent_Width_SpinEdit.Value;


  if   ( sql_editor__words_highlight__color__background__copy_g <> Sql_Editor__Words_Highlight__Color__Background_ColorBox.Selected )
    or ( sql_editor__words_highlight__color__border__copy_g <> Sql_Editor__Words_Highlight__Color__Border_ColorBox.Selected ) then
    begin

      // Here probably should free TSearchTextHightlighterSynEditPlugin (do not know how). //???

      sql_editor__words_highlight__color__background__copy_g := Sql_Editor__Words_Highlight__Color__Background_ColorBox.Selected;
      sql_editor__words_highlight__color__border__copy_g := Sql_Editor__Words_Highlight__Color__Border_ColorBox.Selected;


      Common.Syn_Edit__Search_Text_Hightlighter_Syn_Edit_Plugin__Create( Sql_Text_SynEdit, sql_editor__words_highlight__color__background__copy_g, sql_editor__words_highlight__color__border__copy_g );

    end;


  Sql_Text_SynEdit.Options := [];

  for i := 0 to Syn_Editor_Options_CheckListBox.Items.Count - 1 do
    if Syn_Editor_Options_CheckListBox.Checked[ i ] then
      Sql_Text_SynEdit.Options := Sql_Text_SynEdit.Options + [ SynEdit.TSynEditorOption(i) ];

end;

procedure TOptions_Form.Sql_Text_SynEditClick( Sender: TObject );
begin

  Caret_Position_Display();

  Common.Syn_Edit__Words_Highlight( Sql_Text_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( Sql_Text_SynEdit, text__search_replace_form );

end;

procedure TOptions_Form.Sql_Text_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Common.Syn_Edit_Key_Down( Sql_Text_SynEdit, Sender, Key, Shift );

end;

procedure TOptions_Form.Sql_Text_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

  Common.Syn_Edit__Words_Highlight( Sql_Text_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( Sql_Text_SynEdit, text__search_replace_form );

end;

procedure TOptions_Form.Sql_Text_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );
begin

  Common.Syn_Edit__On_Replace_Text(  Sql_Text_SynEdit, ASearch, AReplace, Line, Column, Action, ClientToScreen( Self.ClientRect )  );

end;

procedure TOptions_Form.Sql_Text__SynCompletionProposalCodeCompletion( Sender: TObject; var Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
begin

  Common.Syn_Completion_Proposal_Code_Completion( code_completion__cursor_position_g, Value );

end;

procedure TOptions_Form.Sql_Text__SynCompletionProposalAfterCodeCompletion( Sender: TObject; const Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
begin

  Common.Syn_Completion_Proposal_After_Code_Completion( Sql_Text_SynEdit, code_completion__cursor_position_g );

end;

end.
