unit View__Modify;{06.Wrz.2023}

interface

uses
  Common,
  Text__Search_Replace,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, JvExMask,
  JvSpin, Vcl.ComCtrls, Vcl.CheckLst, SynEdit, SynCompletionProposal;

type
  TView__Modify_Form = class( TForm )
    Execute_Button: TButton;
    Close_Button: TButton;
    Sql_Memo: TMemo;
    Sql_Prepare_Button: TButton;
    View_Name_Edit: TEdit;
    View_Name_Etiquette_Label: TLabel;
    PageControl1: TPageControl;
    Log_TabSheet: TTabSheet;
    Sql_TabSheet: TTabSheet;
    Log_Memo: TMemo;
    View__Source_Memo: TMemo;
    View_Parameters_GroupBox: TGroupBox;
    View_Parameter_Panel: TPanel;
    Type_Vertical_Splitter: TSplitter;
    Bottom_Panel: TPanel;
    Centre_Panel_Horizontal_Splitter: TSplitter;
    Code_Examples_Button: TButton;
    Centre_Panel: TPanel;
    View_Source_Horizontal_Splitter: TSplitter;
    View_Source_GroupBox: TGroupBox;
    View_Parameters__List_ScrollBox: TScrollBox;
    View__Parameter__Align_Correct_Button: TButton;
    Parameter_Name_Etiquette_Label: TLabel;
    Parameter_Name_Edit: TEdit;
    Modify__Parameter__Add_Button: TButton;
    Modify__Parameter__Name_Set_Button: TButton;
    Parameter__Move__Up_Button: TButton;
    Parameter__Move__Down_Button: TButton;
    Modify__Parameter__Delete_Button: TButton;
    Execute_Button_Works_As_Prepare_Execute_CheckBox: TCheckBox;
    Caret_Position_Label: TLabel;
    View__Source_SynEdit: TSynEdit;
    View_Source__SynCompletionProposal: TSynCompletionProposal;

    procedure View__Parameter_On_Click( Sender : TObject );

    procedure FormCreate( Sender: TObject );
    procedure FormShow( Sender: TObject );
    procedure FormClose( Sender: TObject; var Action: TCloseAction );
    procedure FormDestroy( Sender: TObject );

    procedure Sql_Prepare_ButtonClick( Sender: TObject );
    procedure Execute_ButtonClick( Sender: TObject );

    procedure Code_Examples_ButtonClick( Sender: TObject );
    procedure View__Parameter__Align_Correct_ButtonClick( Sender: TObject );
    procedure Modify__Parameter__Add_ButtonClick( Sender: TObject );
    procedure Modify__Parameter__Name_Set_ButtonClick( Sender: TObject );
    procedure Modify__Parameter__Delete_ButtonClick( Sender: TObject );
    procedure Parameter__Move__Up_ButtonClick( Sender: TObject );
    procedure Parameter__Move__Down_ButtonClick( Sender: TObject );
    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Sql_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure View__Source_MemoClick( Sender: TObject );
    procedure View__Source_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure View__Source_MemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure View__Source_SynEditEnter( Sender: TObject );
    procedure View__Source_SynEditClick( Sender: TObject );
    procedure View__Source_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure View__Source_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure View__Source_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );

    procedure View_Source__SynCompletionProposalCodeCompletion( Sender: TObject; var Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
    procedure View_Source__SynCompletionProposalAfterCodeCompletion( Sender: TObject; const Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
  private
    { Private declarations }
    sql_prepared_correctly_g : boolean;

    code_completion__cursor_position_g,
    view__parameter_id_g,
    view__parameter_selected_id_g
      : integer;

    sql__as_g,
    sql__recreate_g
      : string;

    view_modify_sdbm : Common.TSDBM;

    text__search_replace_form : Text__Search_Replace.TText__Search_Replace_Form;

    procedure Caret_Position_Display();
    function Quotation_Sign__VM() : string;
    procedure View__Parameter__Free( const view__parameter_selected_id_f : integer = 0 );
    function View__Parameter__Name_Unique( const parameter_name_f : string; const view__parameter_selected_id_f : integer = 0 ) : boolean;
    procedure View__Parameter__Selected__Notification_Set( const view__parameter_selected_id_f : integer = 0 );
  public
    { Public declarations }
    modified__vm,
    show_modal__vm,
    sql__quotation_sign__use__vm,
    splitter_show__vm,
    view__edit__vm
      : boolean;

    database_type__vm,
    sql__quotation_sign__vm,
    view__description_value__vm,
    view__name__vm
      : string;

    constructor Create( AOwner : TComponent; sdbm_f : Common.TSDBM ); overload;
  end;

const
  view__modify__code_examples__file_name_c : string = 'View__Modify__Code_Examples.txt';
  view__modify__sql__parameters_list__file_name_c : string = 'View__Modify__Parameters_List__sql.txt';
  view__modify__sql__view__recreate__file_name_c : string = 'View__Modify__View__Recreate__sql.txt';
  view__modify__sql__view__recreate__as__file_name_c : string = 'View__Modify__View__Recreate__As__sql.txt';

var
  View__Modify_Form: TView__Modify_Form;

implementation

uses
  System.IOUtils,
  Vcl.Clipbrd,

  Shared,
  Translation,
  View__Parameter;

{$R *.dfm}

procedure TView__Modify_Form.Caret_Position_Display();
begin

  //Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Source_Memo.CaretPos.Y + 1 )  ) + ' / ' + Trim(   FormatFloat( '### ### ### ### ### ### ##0', View__Source_Memo.CaretPos.X + 1 ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Source_Memo.Lines.Text.Length )  )   );
  Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Source_SynEdit.CaretY )  ) + ' / ' + Trim(   FormatFloat( '### ### ### ### ### ### ##0', View__Source_SynEdit.CaretX ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Source_SynEdit.Lines.Text.Length )  )   );

end;

procedure TView__Modify_Form.View__Parameter_On_Click( Sender : TObject );
begin

  if Sender <> nil then
    begin

      if Sender is View__Parameter.TView__Parameter then
        view__parameter_selected_id_g := View__Parameter.TView__Parameter(Sender).View__Parameter_Id__Get()
      else
        if    ( TWinControl(Sender).Parent <> nil )
          and ( TWinControl(Sender).Parent is View__Parameter.TView__Parameter ) then
          view__parameter_selected_id_g := View__Parameter.TView__Parameter(TWinControl(Sender).Parent).View__Parameter_Id__Get();

    end;


  View__Parameter__Selected__Notification_Set( view__parameter_selected_id_g );

end;

function TView__Modify_Form.Quotation_Sign__VM() : string;
begin

  if sql__quotation_sign__use__vm then
    begin

      Result := sql__quotation_sign__vm;

    end
  else
    Result := '';

end;

procedure TView__Modify_Form.View__Parameter__Free( const view__parameter_selected_id_f : integer = 0 );
var
  i : integer;
begin

  View_Parameters__List_ScrollBox.Visible := false;


  for i := View_Parameters__List_ScrollBox.ControlCount - 1 downto 0 do
    if    ( View_Parameters__List_ScrollBox.Controls[ i ].ClassType = View__Parameter.TView__Parameter )
      and (
               ( view__parameter_selected_id_f = 0 )
            or ( View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).View__Parameter_Id__Get() = view__parameter_selected_id_f )
          ) then
      FreeAndNil( View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]) );


  View_Parameters__List_ScrollBox.Visible := true;


  if view__parameter_selected_id_g = view__parameter_selected_id_f then
    view__parameter_selected_id_g := 0;


  View__Parameter__Selected__Notification_Set( view__parameter_selected_id_g );

end;

function TView__Modify_Form.View__Parameter__Name_Unique( const parameter_name_f : string; const view__parameter_selected_id_f : integer = 0 ) : boolean;
var
  i : integer;
begin

  Result := true;

  for i := View_Parameters__List_ScrollBox.ControlCount - 1 downto 0 do
    if View_Parameters__List_ScrollBox.Controls[ i ].ClassType = View__Parameter.TView__Parameter then
      if    ( View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).Name_Get__VP() = parameter_name_f )
        and (
                 ( view__parameter_selected_id_f <= 0 )
              or ( View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).View__Parameter_Id__Get() <> view__parameter_selected_id_f )
            ) then
        begin

          Result := false;
          Exit;

        end;

end;

procedure TView__Modify_Form.View__Parameter__Selected__Notification_Set( const view__parameter_selected_id_f : integer = 0 );
var
  i : integer;
begin

  for i := View_Parameters__List_ScrollBox.ControlCount - 1 downto 0 do
    if View_Parameters__List_ScrollBox.Controls[ i ].ClassType = View__Parameter.TView__Parameter then
      if View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).View__Parameter_Id__Get() = view__parameter_selected_id_f then
        begin

          View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).Selected__Notification_Set__VP( true );
          Parameter_Name_Edit.Text := View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).Name_Get__VP();

        end
      else
        View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).Selected__Notification_Set__VP();

end;

constructor TView__Modify_Form.Create( AOwner : TComponent; sdbm_f : Common.TSDBM );
begin

  inherited Create( AOwner );


  view_modify_sdbm := Common.TSDBM.Create( sdbm_f );
  view_modify_sdbm.Component_Type_Set( sdbm_f.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

end;

procedure TView__Modify_Form.FormCreate( Sender: TObject );
begin

  code_completion__cursor_position_g := -1;
  database_type__vm := '';
  modified__vm := false;
  show_modal__vm := true;
  splitter_show__vm := true;
  sql_prepared_correctly_g := false;
  text__search_replace_form := nil;
  view__description_value__vm := '';
  view__edit__vm := false;
  view__name__vm := '';
  view__parameter_id_g := 0;
  view__parameter_selected_id_g := 0;

  Common.Text__Search_Replace__Hide( text__search_replace_form );


  Translation.Translation__Apply( Self );

end;

procedure TView__Modify_Form.FormShow( Sender: TObject );
var
  zti_1,
  zti_2
    : integer;

  zts_1,
  zts_2
    : string;
begin

  PageControl1.ActivePage := Log_TabSheet;


  if view__edit__vm then
    begin

      View_Name_Edit.Enabled := false;
      View_Name_Edit.Text := view__name__vm;

    end
  else
    //Code_Examples_ButtonClick( View__Source_Memo );
    Code_Examples_ButtonClick( View__Source_SynEdit );



  zts_1 := '';

  zts_2 := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__vm + System.IOUtils.TPath.DirectorySeparatorChar + Common.sql_editor__code_completion_list__file_name_c  );

  if Trim( zts_2 ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.sql_editor__code_completion_list__file_name_c + ').' );


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


      View_Source__SynCompletionProposal.ItemList.Add(  Copy( zts_2, 1, zti_2 - 1 )  );

      Delete(  zts_2, 1, zti_2 + Length( Common.code_completion__caption_value_separator_c ) - 1  );
      zts_2 := StringReplace( zts_2, Common.newline_symbol_c, #13 + #10, [ rfReplaceAll ] );

      View_Source__SynCompletionProposal.InsertList.Add( zts_2 );


      Delete( zts_1, 1, zti_1 + 1 );


      zti_1 := Pos( #13 + #10, zts_1 );

    end;


  sql__as_g := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__vm + System.IOUtils.TPath.DirectorySeparatorChar + view__modify__sql__view__recreate__as__file_name_c  );

  if Trim( sql__as_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + view__modify__sql__view__recreate__as__file_name_c + ').' );

      sql__as_g :=
        #13 + #10 +
        'as' +
        #13 + #10;

    end
  else
    begin

      sql__as_g := StringReplace( sql__as_g, #10, '', [] );
      sql__as_g := StringReplace( sql__as_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'As: ' + sql__as_g + '.' );


  sql__recreate_g := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__vm + System.IOUtils.TPath.DirectorySeparatorChar + view__modify__sql__view__recreate__file_name_c  );

  if Trim( sql__recreate_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + view__modify__sql__view__recreate__file_name_c + ').' );

      sql__recreate_g :=
        'recreate view __VIEW_NAME__ ' +
        '  ( ' +
        '    __COLUMN_NAME__ ' +
        '  ) ' +
        sql__as_g +
        '__VIEW_SOURCE__ ';

    end
  else
    begin

      sql__recreate_g := StringReplace( sql__recreate_g, #10, '', [] );
      sql__recreate_g := StringReplace( sql__recreate_g, #13, '', [] );

    end;


  if view__edit__vm then
    begin

      Screen.Cursor := crHourGlass;


      if view_modify_sdbm.Query__Active() then
        view_modify_sdbm.Query__Close();

      zts_1 := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__vm + System.IOUtils.TPath.DirectorySeparatorChar + Common.view__sql__metadata__file_name_c  );

      if Trim( zts_1 ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.view__sql__metadata__file_name_c + ').' );

          zts_1 := Common.view__sql__metadata_c;

        end;

      view_modify_sdbm.Query__Sql__Set( zts_1 );


      Log_Memo.Lines.Add( zts_1 );


      view_modify_sdbm.Query__Param_By_Name__Set( Common.name__view__small_letters_c, View_Name_Edit.Text, Log_Memo );

      try
        view_modify_sdbm.Query__Open();
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_view_metadata + #13 + #13 + E.Message + #13 + #13 + zts_1 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            Screen.Cursor := crHourGlass;

          end;
      end;



      if view_modify_sdbm.Query__Active() then
        begin

          Log_Memo.Lines.Add( view_modify_sdbm.Operation_Duration_Get() );


          if view_modify_sdbm.Query__Record_Count() <> 1 then
            begin

              Screen.Cursor := crDefault;

              Application.MessageBox( PChar(Translation.translation__messages_r.view_not_found + #13 + #13 + zts_1 + #13 + #13 + View_Name_Edit.Text + Translation.translation__messages_r.query_output_count_ + ' ' + view_modify_sdbm.Query__Record_Count().ToString() + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

              view_modify_sdbm.Query__Close();

              Screen.Cursor := crHourGlass;

            end;

        end;



      if view_modify_sdbm.Query__Active() then
        begin

          Log_Memo.Lines.Add( view_modify_sdbm.Operation_Duration_Get() );

          try
            //View__Source_Memo.Lines.Text := view_modify_sdbm.Query__Field_By_Name( Common.name__view__source_c ).AsString;
            View__Source_SynEdit.Lines.Text := view_modify_sdbm.Query__Field_By_Name( Common.name__view__source_c ).AsString;
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_view_source_column_name + #13 + #13 + E.Message + #13 + #13 + zts_1 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

                Screen.Cursor := crHourGlass;

              end;
          end;

        end;



      if view_modify_sdbm.Query__Active() then
        view_modify_sdbm.Query__Close();

      zts_1 := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__vm + System.IOUtils.TPath.DirectorySeparatorChar + view__modify__sql__parameters_list__file_name_c  );

      if Trim( zts_1 ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + view__modify__sql__parameters_list__file_name_c + ').' );

          zts_1 :=
            'select RDB$RELATION_FIELDS.RDB$FIELD_NAME as COLUMN_NAME ' +
            '     , cast(  substring( RDB$RELATION_FIELDS.RDB$DESCRIPTION from 1 for 2000 ) as varchar( 2000 )  ) as DESCRIPTION_VALUE__CAST ' +
            '     , RDB$RELATION_FIELDS.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
            '     , RDB$RELATION_FIELDS.RDB$FIELD_POSITION as PARAMETER_NUMBER ' +
            'from RDB$RELATION_FIELDS ' +
            'where RDB$RELATION_FIELDS.RDB$RELATION_NAME = :view_name ' +
            'order by RDB$RELATION_FIELDS.RDB$FIELD_POSITION ';

        end;

      view_modify_sdbm.Query__Sql__Set( zts_1 );


      Log_Memo.Lines.Add( zts_1 );


      view_modify_sdbm.Query__Param_By_Name__Set( Common.name__view__small_letters_c, View_Name_Edit.Text, Log_Memo );

      try
        view_modify_sdbm.Query__Open();
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_view_data + #13 + #13 + E.Message + #13 + #13 + zts_1 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            Screen.Cursor := crHourGlass;

          end;
      end;


      if view_modify_sdbm.Query__Active() then
        begin

          View_Parameters__List_ScrollBox.Visible := false;

          while not view_modify_sdbm.Query__Eof() do
            begin

              View__Parameter.TView__Parameter.Create
                (
                  View_Parameters__List_ScrollBox,
                  view__parameter_id_g,
                  Trim( view_modify_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString ), // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.
                  view_modify_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString,
                  splitter_show__vm,
                  View__Parameter_On_Click
                );


              view_modify_sdbm.Query__Next();

            end;

          View_Parameters__List_ScrollBox.Visible := true;

        end;


      if view_modify_sdbm.Query__Active() then
        view_modify_sdbm.Query__Close();


      Screen.Cursor := crDefault;

    end;


  view__parameter_selected_id_g := 0;

  View__Parameter__Selected__Notification_Set();


  Caret_Position_Display();


  View_Source__SynCompletionProposal.NbLinesInWindow := Common.sql_editor__code_completion_window__default__lines_in_window;
  View_Source__SynCompletionProposal.Width := Common.sql_editor__code_completion_window__default__width;


  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Sql_Memo.Font, Common.sql_editor__font );
  //Common.Font__Set( View__Source_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( View__Source_SynEdit.Font, Common.sql_editor__font );


  Common.Syn_Edit__Search_Text_Hightlighter_Syn_Edit_Plugin__Create( View__Source_SynEdit );

end;

procedure TView__Modify_Form.FormClose( Sender: TObject; var Action: TCloseAction );
begin

  if not show_modal__vm then
    FreeAndNil( Self );

end;

procedure TView__Modify_Form.FormDestroy( Sender: TObject );
begin

  Common.Text__Search_Replace__Syn_Edit__Set( nil, text__search_replace_form );
  Common.Text__Search_Replace__Hide( text__search_replace_form );


  if view_modify_sdbm <> nil then
    FreeAndNil( view_modify_sdbm );

  if text__search_replace_form <> nil then
    FreeAndNil( text__search_replace_form );


  View__Parameter__Free();

end;

procedure TView__Modify_Form.Sql_Prepare_ButtonClick( Sender: TObject );
var
  i : integer;

  zts_1,
  zts_2
    : string;
begin

  sql_prepared_correctly_g := false;


  if Trim( View_Name_Edit.Text ) = '' then
    begin

      if View_Name_Edit.Enabled then
        View_Name_Edit.SetFocus();

      Application.MessageBox( PChar(Translation.translation__messages_r.view_name_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  //if Trim( View__Source_Memo.Text ) = '' then
  if Trim( View__Source_SynEdit.Text ) = '' then
    begin

      //View__Source_Memo.SetFocus();
      View__Source_SynEdit.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.view_source_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  PageControl1.ActivePage := Sql_TabSheet;


  zts_1 := sql__recreate_g;

  zts_1 := StringReplace( zts_1, Common.sql__word_replace_separator_c + Common.name__view__big_letters_c + Common.sql__word_replace_separator_c, Quotation_Sign__VM() + View_Name_Edit.Text + Quotation_Sign__VM(), [ rfReplaceAll ] );


  zts_2 := '';

  for i := 0 to View_Parameters__List_ScrollBox.ControlCount - 1 do
    if View_Parameters__List_ScrollBox.Controls[ i ].ClassType = View__Parameter.TView__Parameter then
      begin

        if zts_2 <> '' then
          zts_2 := zts_2 + Common.sql__view__parameter_separator;

        zts_2 := zts_2 +
          View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).Name_Get__VP();

      end;

  zts_1 := StringReplace( zts_1, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, zts_2, [ rfReplaceAll ] );


  //zts_1 := StringReplace( zts_1, Common.sql__word_replace_separator_c + Common.name__view__source_c + Common.sql__word_replace_separator_c, View__Source_Memo.Lines.Text, [ rfReplaceAll ] );
  zts_1 := StringReplace( zts_1, Common.sql__word_replace_separator_c + Common.name__view__source_c + Common.sql__word_replace_separator_c, View__Source_SynEdit.Lines.Text, [ rfReplaceAll ] );


  Sql_Memo.Lines.Clear();
  Sql_Memo.Lines.Add( zts_1 );


  sql_prepared_correctly_g := true;

end;

procedure TView__Modify_Form.Execute_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  i : integer;

  zts,
  description_value_l,
  error_message_l,
  view__parameter_name_l
    : string;
begin

  if view_modify_sdbm = nil then
    Exit;


  sql_prepared_correctly_g := false;


  if Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked then
    begin

      Sql_Prepare_ButtonClick( Sender );

      if not sql_prepared_correctly_g then
        Exit;

      sql_prepared_correctly_g := false;

    end;


  ztb := view_modify_sdbm.Sql_Command_Execute( Sql_Memo.Lines.Text, error_message_l, Translation.translation__messages_r.failed_to_modify_view, false );


  if ztb then
    begin

      if not modified__vm then
        modified__vm := true;


      if View_Name_Edit.Enabled then
        view__name__vm := View_Name_Edit.Text;


      Log_Memo.Lines.Add( view_modify_sdbm.Operation_Duration_Get() );



      if Trim( view__description_value__vm ) <> '' then
        begin

          description_value_l := Common.Sql_Special_Characters_Protect( view__description_value__vm );


          zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__vm + System.IOUtils.TPath.DirectorySeparatorChar + Common.view__sql__description__set__file_name_c  );

          if Trim( zts ) = '' then
            begin

              Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.view__sql__description__set__file_name_c + ').' );

              zts := Common.view__sql__description__set_c;

            end;

          zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );
          zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__view__big_letters_c + Common.sql__word_replace_separator_c, Quotation_Sign__VM() + View_Name_Edit.Text + Quotation_Sign__VM(), [ rfReplaceAll ] );


          Log_Memo.Lines.Add( zts );


          ztb := view_modify_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_view_description );


          if not ztb then
            begin

              if Trim( error_message_l ) <> '' then
                Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

            end;

        end;



      for i := 0 to View_Parameters__List_ScrollBox.ControlCount - 1 do
        if    ( View_Parameters__List_ScrollBox.Controls[ i ].ClassType = View__Parameter.TView__Parameter )
          and (  Trim( View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).Description_Get__VP() ) <> ''  ) then
          begin

            description_value_l := View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).Description_Get__VP();
            description_value_l := Common.Sql_Special_Characters_Protect( description_value_l );

            view__parameter_name_l := Quotation_Sign__VM() + View_Name_Edit.Text + Quotation_Sign__VM() + Common.sql__names_separator + Quotation_Sign__VM() + View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).Name_Get__VP() + Quotation_Sign__VM();

            zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__vm + System.IOUtils.TPath.DirectorySeparatorChar + Common.view__sql__parameter__description__set__file_name_c  );

            if Trim( zts ) = '' then
              begin

                Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.view__sql__parameter__description__set__file_name_c + ').' );

                zts := Common.view__sql__parameter__description__set_c;

              end;

            zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, view__parameter_name_l, [ rfReplaceAll ] );
            zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );


            Log_Memo.Lines.Add( zts );


            ztb := view_modify_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_view_parameter_description );


            if not ztb then
              begin

                if Trim( error_message_l ) <> '' then
                  Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

              end;

          end;


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TView__Modify_Form.Code_Examples_ButtonClick( Sender: TObject );
var
  zts : string;
begin

  PageControl1.ActivePage := Log_TabSheet;

  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__vm + System.IOUtils.TPath.DirectorySeparatorChar + view__modify__code_examples__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + view__modify__code_examples__file_name_c + ').' );

      zts :=
        Translation.translation__messages_r.view_code_example + #13 + #10 +
        'select T1.C1' + #13 + #10 +
        '     , T1.C2' + #13 + #10 +
        'from T1' + #13 + #10 +
        'where T1.C2 = 123' + #13 + #10 +
        #13 + #10 +
        'union all' + #13 + #10 +
        #13 + #10 +
        'select T2.C1' + #13 + #10 +
        '     , T2.C2' + #13 + #10 +
        'from T2' + #13 + #10 +
        'where T2.C2 = 456';

    end
  else
    zts :=
      Translation.translation__messages_r.view_code_example + #13 + #10 +
      zts;


  if    ( Sender <> nil )
    //and ( TComponent(Sender).Name = View__Source_Memo.Name ) then
    and ( TComponent(Sender).Name = View__Source_SynEdit.Name ) then
    //View__Source_Memo.Lines.Text := zts
    View__Source_SynEdit.Lines.Text := zts
  else
    Log_Memo.Lines.Add( zts );

end;

procedure TView__Modify_Form.View__Parameter__Align_Correct_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  for i := 0 to View_Parameters__List_ScrollBox.ControlCount - 1 do
    if View_Parameters__List_ScrollBox.Controls[ i ].ClassType = View__Parameter.TView__Parameter then
      View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).Align_Correct__VP();

end;

procedure TView__Modify_Form.Modify__Parameter__Add_ButtonClick( Sender: TObject );
begin

  if Trim( Parameter_Name_Edit.Text ) = '' then
    begin

      if Parameter_Name_Edit.Enabled then
        Parameter_Name_Edit.SetFocus();

      Application.MessageBox( PChar(Translation.translation__messages_r.parameter_name_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;

  if not View__Parameter__Name_Unique( Parameter_Name_Edit.Text ) then
    begin

      if Parameter_Name_Edit.Enabled then
        Parameter_Name_Edit.SetFocus();

      if Application.MessageBox( PChar(Translation.translation__messages_r.parameter_name_should_be_unique + #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES then
        Exit;

    end;


  View__Parameter.TView__Parameter.Create
    (
      View_Parameters__List_ScrollBox,
      view__parameter_id_g,
      Parameter_Name_Edit.Text,
      '',
      splitter_show__vm,
      View__Parameter_On_Click
    );

end;

procedure TView__Modify_Form.Modify__Parameter__Name_Set_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  if view__parameter_selected_id_g <= 0 then
    Exit;


  if not View__Parameter__Name_Unique( Parameter_Name_Edit.Text, view__parameter_selected_id_g ) then
    begin

      if Parameter_Name_Edit.Enabled then
        Parameter_Name_Edit.SetFocus();

      if Application.MessageBox( PChar(Translation.translation__messages_r.parameter_name_should_be_unique + #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES then
        Exit;

    end;


  for i := 0 to View_Parameters__List_ScrollBox.ControlCount - 1 do
    if View_Parameters__List_ScrollBox.Controls[ i ].ClassType = View__Parameter.TView__Parameter then
      if View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).View__Parameter_Id__Get() = view__parameter_selected_id_g then
        begin

          View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).Name_Set__VP( Parameter_Name_Edit.Text );

          view__parameter_selected_id_g := View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).View__Parameter_Id__Get();

        end;

end;

procedure TView__Modify_Form.Modify__Parameter__Delete_ButtonClick( Sender: TObject );
begin

  if view__parameter_selected_id_g <= 0 then
    Exit;


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_selected_parameter_), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES then
    Exit;


  View__Parameter__Free( view__parameter_selected_id_g );

end;

procedure TView__Modify_Form.Parameter__Move__Up_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  if view__parameter_selected_id_g <= 0 then
    Exit;


  for i := 0 to View_Parameters__List_ScrollBox.ControlCount - 1 do
    if View_Parameters__List_ScrollBox.Controls[ i ].ClassType = View__Parameter.TView__Parameter then
      if View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).View__Parameter_Id__Get() = view__parameter_selected_id_g then
        begin

          View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).Positions_Swap__VP( alTop );

          Break;

        end;

end;

procedure TView__Modify_Form.Parameter__Move__Down_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  if view__parameter_selected_id_g <= 0 then
    Exit;


  for i := 0 to View_Parameters__List_ScrollBox.ControlCount - 1 do
    if View_Parameters__List_ScrollBox.Controls[ i ].ClassType = View__Parameter.TView__Parameter then
      if View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).View__Parameter_Id__Get() = view__parameter_selected_id_g then
        begin

          View__Parameter.TView__Parameter(View_Parameters__List_ScrollBox.Controls[ i ]).Positions_Swap__VP( alBottom );

          Break;

        end;

end;

procedure TView__Modify_Form.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( ssCtrl in Shift )
    and (  not ( ssAlt in Shift )  ) then
    Log_Memo.SelectAll();

end;

procedure TView__Modify_Form.Sql_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( ssCtrl in Shift )
    and (  not ( ssAlt in Shift )  ) then
    Sql_Memo.SelectAll();

end;

procedure TView__Modify_Form.View__Source_MemoClick( Sender: TObject );
begin

  Caret_Position_Display();

end;

procedure TView__Modify_Form.View__Source_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_ADD )
    and ( ssCtrl in Shift ) then
     Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked := not Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked
  else
  // A.
  if    ( Key = 65 )
    and ( ssCtrl in Shift )
    and (  not ( ssAlt in Shift )  ) then
    View__Source_Memo.SelectAll()
  else
  // E.
  if    ( Key = 69 )
    and ( ssCtrl in Shift ) then
    Execute_ButtonClick( Sender )
  else
  // P.
  if    ( Key = 80 )
    and ( ssCtrl in Shift ) then
    Sql_Prepare_ButtonClick( Sender );

end;

procedure TView__Modify_Form.View__Source_MemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

end;

procedure TView__Modify_Form.View__Source_SynEditEnter( Sender: TObject );
begin

  Common.Text__Search_Replace__Syn_Edit__Set( View__Source_SynEdit, text__search_replace_form );

end;

procedure TView__Modify_Form.View__Source_SynEditClick( Sender: TObject );
begin

  Caret_Position_Display();

  Common.Syn_Edit__Words_Highlight( View__Source_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( View__Source_SynEdit, text__search_replace_form );

end;

procedure TView__Modify_Form.View__Source_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_F3 then
    begin

      if Common.Text__Search_Replace__Is_Nil( text__search_replace_form ) then
        Common.Text__Search_Replace__Window_Show( View__Source_SynEdit, text__search_replace_form )
      else
        begin

          if ssShift in Shift then
            Common.Text__Search_Replace__Direction__Invert( text__search_replace_form );


          Common.Text__Search_Replace__Do( View__Source_SynEdit, text__search_replace_form );

        end;

    end
  else
  if    ( Key = VK_ADD )
    and ( ssCtrl in Shift ) then
     Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked := not Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and (  Trim( View__Source_SynEdit.SelText ) = ''  ) then
    begin
      Vcl.Clipbrd.Clipboard.AsText := Common.Syn_Edit__CharScan( View__Source_SynEdit );
    end
  else
  // E.
  if    ( Key = 69 )
    and ( ssCtrl in Shift ) then
    Execute_ButtonClick( Sender )
  else
  // F.
  if    ( Key = 70 )
    and ( ssCtrl in Shift ) then
    Common.Text__Search_Replace__Window_Show( View__Source_SynEdit, text__search_replace_form )
  else
  // H.
  if    ( Key = 72 )
    and ( ssCtrl in Shift ) then
    Common.Text__Search_Replace__Window_Show( View__Source_SynEdit, text__search_replace_form, true )
  else
  // P.
  if    ( Key = 80 )
    and ( ssCtrl in Shift ) then
    Sql_Prepare_ButtonClick( Sender );

end;

procedure TView__Modify_Form.View__Source_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

  Common.Syn_Edit__Words_Highlight( View__Source_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( View__Source_SynEdit, text__search_replace_form );

end;

procedure TView__Modify_Form.View__Source_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );
begin

  Common.Syn_Edit__On_Replace_Text(  View__Source_SynEdit, ASearch, AReplace, Line, Column, Action, ClientToScreen( Self.ClientRect )  );

end;

procedure TView__Modify_Form.View_Source__SynCompletionProposalCodeCompletion( Sender: TObject; var Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
begin

  Common.Syn_Completion_Proposal_Code_Completion( code_completion__cursor_position_g, Value );

end;

procedure TView__Modify_Form.View_Source__SynCompletionProposalAfterCodeCompletion( Sender: TObject; const Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
begin

  Common.Syn_Completion_Proposal_After_Code_Completion( View__Source_SynEdit, code_completion__cursor_position_g );

end;

end.
