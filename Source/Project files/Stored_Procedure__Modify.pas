unit Stored_Procedure__Modify;{25.Sie.2023}

interface

uses
  Common,
  Text__Search_Replace,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, SynEdit, SynCompletionProposal,

  Interceptor__Syn_Edit;

type
  TStored_Procedure__Modify_Form = class( TForm )
    Execute_Button: TButton;
    Close_Button: TButton;
    Sql_Memo: TMemo;
    Sql_Prepare_Button: TButton;
    Stored_Procedure__Name_Edit: TEdit;
    Stored_Procedure__Name_Etiquette_Label: TLabel;
    PageControl1: TPageControl;
    Log_TabSheet: TTabSheet;
    Sql_TabSheet: TTabSheet;
    Log_Memo: TMemo;
    Stored_Procedure__Source_Memo: TMemo;
    Stored_Procedure__Parameters_GroupBox: TGroupBox;
    Stored_Procedure__Parameter_Panel: TPanel;
    Type_Vertical_Splitter: TSplitter;
    Bottom_Panel: TPanel;
    Centre_Panel_Horizontal_Splitter: TSplitter;
    Code_Examples_Button: TButton;
    Centre_Panel: TPanel;
    Stored_Procedure__Source_Horizontal_Splitter: TSplitter;
    Stored_Procedure__Source_GroupBox: TGroupBox;
    Stored_Procedure__Parameters__List_ScrollBox: TScrollBox;
    Stored_Procedure__Parameter__Align_Correct_Button: TButton;
    Parameter_Name_Etiquette_Label: TLabel;
    Parameter_Name_Edit: TEdit;
    Modify__Parameter__Add_Button: TButton;
    Modify__Parameter__Name_Set_Button: TButton;
    Parameter__Move__Up_Button: TButton;
    Parameter__Move__Down_Button: TButton;
    Modify__Parameter__Delete_Button: TButton;
    Execute_Button_Works_As_Prepare_Execute_CheckBox: TCheckBox;
    Stored_Procedure__Source__SynCompletionProposal: TSynCompletionProposal;
    Stored_Procedure__Source_SynEdit: TSynEdit;
    Caret_Position_Label: TLabel;
    Lines_Break_CheckBox: TCheckBox;

    procedure Stored_Procedure__Parameter_On_Click( Sender : TObject );

    procedure FormCreate( Sender: TObject );
    procedure FormShow( Sender: TObject );
    procedure FormClose( Sender: TObject; var Action: TCloseAction );
    procedure FormDestroy( Sender: TObject );

    procedure Sql_Prepare_ButtonClick( Sender: TObject );
    procedure Execute_ButtonClick( Sender: TObject );

    procedure Code_Examples_ButtonClick( Sender: TObject );
    procedure Stored_Procedure__Parameter__Align_Correct_ButtonClick( Sender: TObject );
    procedure Modify__Parameter__Add_ButtonClick( Sender: TObject );
    procedure Modify__Parameter__Name_Set_ButtonClick( Sender: TObject );
    procedure Modify__Parameter__Delete_ButtonClick( Sender: TObject );
    procedure Parameter__Move__Up_ButtonClick( Sender: TObject );
    procedure Parameter__Move__Down_ButtonClick( Sender: TObject );
    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Sql_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Stored_Procedure__Source_MemoClick( Sender: TObject );
    procedure Stored_Procedure__Source_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Stored_Procedure__Source_MemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Stored_Procedure__Source_SynEditEnter( Sender: TObject );
    procedure Stored_Procedure__Source_SynEditClick( Sender: TObject );
    procedure Stored_Procedure__Source_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Stored_Procedure__Source_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Stored_Procedure__Source_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );

    procedure Stored_Procedure__Source__SynCompletionProposalCodeCompletion( Sender: TObject; var Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
    procedure Stored_Procedure__Source__SynCompletionProposalAfterCodeCompletion( Sender: TObject; const Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
  private
    { Private declarations }
    sql_prepared_correctly_g : boolean;

    code_completion__cursor_position_g,
    stored_procedure__parameter_id_g,
    stored_procedure__parameter_selected_id_g
      : integer;

    data_types_list_g,
    default_replace_g, // Database return default value as 'default default_value'.
    sql__as_g,
    sql__default_g,
    sql__recreate_g,
    sql__returns_g
      : string;

    stored_procedure_modify_sdbm : Common.TSDBM;

    text__search_replace_form : Text__Search_Replace.TText__Search_Replace_Form;

    procedure Caret_Position_Display();
    function Quotation_Sign__SPM() : string;
    procedure Stored_Procedure__Parameter__Free( const stored_procedure__parameter_selected_id_f : integer = 0 );
    function Stored_Procedure__Parameter__Name_Unique( const parameter_name_f : string; const stored_procedure__parameter_selected_id_f : integer = 0 ) : boolean;
    procedure Stored_Procedure__Parameter__Selected__Notification_Set( const stored_procedure__parameter_selected_id_f : integer = 0 );
  public
    { Public declarations }
    modified__spm,
    show_modal__spm,
    sql__quotation_sign__use__spm,
    splitter_show__spm,
    stored_procedure__edit__spm
      : boolean;

    database_type__spm,
    sql__quotation_sign__spm,
    stored_procedure__description_value__spm,
    stored_procedure__name__spm
      : string;

    constructor Create( AOwner : TComponent; sdbm_f : Common.TSDBM ); overload;
  end;

const
  stored_procedure__modify__code_completion_list__file_name_c : string = 'Stored_Procedure__Modify__Code_Completion_List.txt';
  stored_procedure__modify__code_examples__file_name_c : string = 'Stored_Procedure__Modify__Code_Examples.txt';
  stored_procedure__modify__parameters__types_list__file_name_c : string = 'Stored_Procedure__Modify__Parameters__Types_List.txt';
  stored_procedure__modify__sql__parameters_list__file_name_c : string = 'Stored_Procedure__Modify__Parameters_List__sql.txt';
  stored_procedure__modify__sql__stored_procedure__recreate__file_name_c : string = 'Stored_Procedure__Modify__Stored_Procedure__Recreate__sql.txt';
  stored_procedure__modify__sql__stored_procedure__recreate__as__file_name_c : string = 'Stored_Procedure__Modify__Stored_Procedure__Recreate__As__sql.txt';
  stored_procedure__modify__sql__stored_procedure__recreate__default__file_name_c : string = 'Stored_Procedure__Modify__Stored_Procedure__Recreate__Default__sql.txt';
  stored_procedure__modify__sql__stored_procedure__recreate__returns__file_name_c : string = 'Stored_Procedure__Modify__Stored_Procedure__Recreate__Returns__sql.txt';
  stored_procedure__modify__sql__stored_procedure__recreate__parameters_c : string = 'STORED_PROCEDURE_PARAMETERS';
  stored_procedure__modify__sql__stored_procedure__recreate__returns_c : string = 'STORED_PROCEDURE_RETURNS';

var
  Stored_Procedure__Modify_Form: TStored_Procedure__Modify_Form;

implementation

uses
  Shared,
  Stored_Procedure__Parameter,
  Translation;

{$R *.dfm}

procedure TStored_Procedure__Modify_Form.Caret_Position_Display();
begin

  //Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Stored_Procedure__Source_Memo.CaretPos.Y + 1 )  ) + ' / ' + Trim(   FormatFloat( '### ### ### ### ### ### ##0', Stored_Procedure__Source_Memo.CaretPos.X + 1 ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Stored_Procedure__Source_Memo.Lines.Text.Length )  )   );
  Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Stored_Procedure__Source_SynEdit.CaretY )  ) + ' / ' + Trim(   FormatFloat( '### ### ### ### ### ### ##0', Stored_Procedure__Source_SynEdit.CaretX ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Stored_Procedure__Source_SynEdit.Lines.Text.Length )  )   );

end;

procedure TStored_Procedure__Modify_Form.Stored_Procedure__Parameter_On_Click( Sender : TObject );
begin

  if Sender <> nil then
    begin

      if Sender is Stored_Procedure__Parameter.TStored_Procedure__Parameter then
        stored_procedure__parameter_selected_id_g := Stored_Procedure__Parameter.TStored_Procedure__Parameter(Sender).Stored_Procedure__Parameter_Id__Get()
      else
        if    ( TWinControl(Sender).Parent <> nil )
          and ( TWinControl(Sender).Parent is Stored_Procedure__Parameter.TStored_Procedure__Parameter ) then
          stored_procedure__parameter_selected_id_g := Stored_Procedure__Parameter.TStored_Procedure__Parameter(TWinControl(Sender).Parent).Stored_Procedure__Parameter_Id__Get();

    end;


  Stored_Procedure__Parameter__Selected__Notification_Set( stored_procedure__parameter_selected_id_g );

end;

function TStored_Procedure__Modify_Form.Quotation_Sign__SPM() : string;
begin

  if sql__quotation_sign__use__spm then
    begin

      Result := sql__quotation_sign__spm;

    end
  else
    Result := '';

end;

procedure TStored_Procedure__Modify_Form.Stored_Procedure__Parameter__Free( const stored_procedure__parameter_selected_id_f : integer = 0 );
var
  i : integer;
begin

  Stored_Procedure__Parameters__List_ScrollBox.Visible := false;


  for i := Stored_Procedure__Parameters__List_ScrollBox.ControlCount - 1 downto 0 do
    if    ( Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ].ClassType = Stored_Procedure__Parameter.TStored_Procedure__Parameter )
      and (
               ( stored_procedure__parameter_selected_id_f = 0 )
            or ( Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Stored_Procedure__Parameter_Id__Get() = stored_procedure__parameter_selected_id_f )
          ) then
      FreeAndNil( Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]) );


  Stored_Procedure__Parameters__List_ScrollBox.Visible := true;


  if stored_procedure__parameter_selected_id_g = stored_procedure__parameter_selected_id_f then
    stored_procedure__parameter_selected_id_g := 0;


  Stored_Procedure__Parameter__Selected__Notification_Set( stored_procedure__parameter_selected_id_g );

end;

function TStored_Procedure__Modify_Form.Stored_Procedure__Parameter__Name_Unique( const parameter_name_f : string; const stored_procedure__parameter_selected_id_f : integer = 0 ) : boolean;
var
  i : integer;
begin

  Result := true;

  for i := Stored_Procedure__Parameters__List_ScrollBox.ControlCount - 1 downto 0 do
    if Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ].ClassType = Stored_Procedure__Parameter.TStored_Procedure__Parameter then
      if    ( Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Name_Get__SPP() = parameter_name_f )
        and (
                 ( stored_procedure__parameter_selected_id_f <= 0 )
              or ( Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Stored_Procedure__Parameter_Id__Get() <> stored_procedure__parameter_selected_id_f )
            ) then
        begin

          Result := false;
          Exit;

        end;

end;

procedure TStored_Procedure__Modify_Form.Stored_Procedure__Parameter__Selected__Notification_Set( const stored_procedure__parameter_selected_id_f : integer = 0 );
var
  i : integer;
begin

  for i := Stored_Procedure__Parameters__List_ScrollBox.ControlCount - 1 downto 0 do
    if Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ].ClassType = Stored_Procedure__Parameter.TStored_Procedure__Parameter then
      if Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Stored_Procedure__Parameter_Id__Get() = stored_procedure__parameter_selected_id_f then
        begin

          Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Selected__Notification_Set__SPP( true );
          Parameter_Name_Edit.Text := Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Name_Get__SPP();

        end
      else
        Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Selected__Notification_Set__SPP();

end;

constructor TStored_Procedure__Modify_Form.Create( AOwner : TComponent; sdbm_f : Common.TSDBM );
begin

  inherited Create( AOwner );


  stored_procedure_modify_sdbm := Common.TSDBM.Create( sdbm_f );
  stored_procedure_modify_sdbm.Component_Type_Set( sdbm_f.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

end;

procedure TStored_Procedure__Modify_Form.FormCreate( Sender: TObject );
begin

  code_completion__cursor_position_g := -1;
  database_type__spm := '';
  modified__spm := false;
  show_modal__spm := true;
  splitter_show__spm := true;
  sql_prepared_correctly_g := false;
  stored_procedure__description_value__spm := '';
  stored_procedure__edit__spm := false;
  stored_procedure__name__spm := '';
  stored_procedure__parameter_id_g := 0;
  stored_procedure__parameter_selected_id_g := 0;
  text__search_replace_form := nil;

  Common.Text__Search_Replace__Hide( text__search_replace_form );


  Translation.Translation__Apply( Self );

end;

procedure TStored_Procedure__Modify_Form.FormShow( Sender: TObject );
var
  zti_1,
  zti_2
    : integer;

  zts_1,
  zts_2,
  parameter_default_value_l
    : string;
begin

  PageControl1.ActivePage := Log_TabSheet;


  if stored_procedure__edit__spm then
    begin

      Stored_Procedure__Name_Edit.Enabled := false;
      Stored_Procedure__Name_Edit.Text := stored_procedure__name__spm;

    end
  else
    //Code_Examples_ButtonClick( Stored_Procedure__Source_Memo );
    Code_Examples_ButtonClick( Stored_Procedure__Source_SynEdit );



  zts_1 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__code_completion_list__file_name_c  );

  if Trim( zts_1 ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__code_completion_list__file_name_c + ').' );

      {$region 'Code completion list.'}
      zts_1 :=
        '\color{clHotLight}__stored_procedure__ \color{clWindowText}\column{}\style{+B}begin else begin \style{-B}-->begin~#13#10  begin#13#10#13#10#13#10#13#10    end#13#10  else#13#10    begin#13#10#13#10#13#10    end' + #13 + #10 +
        '\color{clHotLight}__stored_procedure__ \color{clWindowText}\column{}\style{+B}declare variable ;\style{-B}-->declare variable ;' + #13 + #10 +
        '\color{clHotLight}__stored_procedure__ \color{clWindowText}\column{}\style{+B}execute statement :zts\style{-B}-->execute statement :zts#13#10  into :zm_1;#13#10#13#10  if ( :zm_1 null ) then#13#10    zm_1 = 0;' + #13 + #10 +
        '\color{clHotLight}__stored_procedure__ \color{clWindowText}\column{}\style{+B}execute statement :ZTS\style{-B}-->execute~#13#10ZTS =#13#10    ''select T1.C1#13#10          , ''''Abc'''' as ABC_1#13#10    from T1#13#10#13#10    where T1.C2 = ' +
          '''||:zm_4||''#13#10      and T1.C3 = ''''||:zm_4||'''' '';#13#10#13#10  for execute statement :ZTS#13#10  into :zm_1,#13#10       :zm_2;' + #13 + #10 +
        '\color{clHotLight}__stored_procedure__ \color{clWindowText}\column{}\style{+B}for into do begin end\style{-B}-->for select T1.C1#13#10         , T1.C2#13#10    from T1#13#10    into :zt1,#13#10         :zt2#13#10  do#13#10    ' +
          'begin#13#10#13#10#13#10    end' + #13 + #10 +
        '\color{clHotLight}__stored_procedure__ \color{clWindowText}\column{}\style{+B}if ( and ) then-->if (     :zm_1 is not null#13#10     and :zm_1 <> 0 ) then' + #13 + #10 +
        '\color{clHotLight}__stored_procedure__ \color{clWindowText}\column{}\style{+B}if (  (  ) or (  )  ) then-->if (    (  )#13#10     or (  )  ) then' + #13 + #10 +
        '\color{clHotLight}__stored_procedure__ \color{clWindowText}\column{}\style{+B}suspend;\style{-B}-->suspend;' + #13 + #10;
      {$endregion 'Code completion list.'}

    end;

  zts_1 := StringReplace( zts_1, Translation.translation__code_completion__stored_procedure_c, Translation.translation__messages_r.code_completion__stored_procedure, [ rfReplaceAll ] );

  zts_2 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__spm ) + Common.sql_editor__code_completion_list__file_name_c  );

  if Trim( zts_2 ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__spm ) + Common.sql_editor__code_completion_list__file_name_c + ').' );


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


      Stored_Procedure__Source__SynCompletionProposal.ItemList.Add(  Copy( zts_2, 1, zti_2 - 1 )  );

      Delete(  zts_2, 1, zti_2 + Length( Common.code_completion__caption_value_separator_c ) - 1  );
      zts_2 := StringReplace( zts_2, Common.newline_symbol_c, #13 + #10, [ rfReplaceAll ] );

      Stored_Procedure__Source__SynCompletionProposal.InsertList.Add( zts_2 );


      Delete( zts_1, 1, zti_1 + 1 );


      zti_1 := Pos( #13 + #10, zts_1 );

    end;


  data_types_list_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__parameters__types_list__file_name_c  );

  if Trim( data_types_list_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__parameters__types_list__file_name_c + ').' );

      data_types_list_g :=
        #13 + #10 +
        'Char ( 10 )' + #13 + #10 +
        'Date' + #13 + #10 +
        'Decimal ( 12, 2 )' + #13 + #10 +
        'Double precision' + #13 + #10 +
        'Float' + #13 + #10 +
        'Integer' + #13 + #10 +
        'Integer not null' + #13 + #10 +
        'Numeric' + #13 + #10 +
        'Smallint' + #13 + #10 +
        'Time' + #13 + #10 +
        'Timestamp' + #13 + #10 +
        'Varchar ( 50 )' + #13 + #10 +
        'Varchar ( 50 ) collate PXW_PLK' + #13 + #10;

    end;


  zts_1 := Common.Databases_Type__Directory_Path__Get( database_type__spm ) + Common.stored_procedure__parameter__default_replace__file_name_c;

  if not FileExists( zts_1 ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__spm ) + Common.stored_procedure__parameter__default_replace__file_name_c + ').' );

      default_replace_g := 'default ';

    end
  else
    begin

      default_replace_g := Common.Text__File_Load( zts_1 );

      default_replace_g := StringReplace( default_replace_g, #10, '', [] );
      default_replace_g := StringReplace( default_replace_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Default replace: ' + default_replace_g + '.' );


  sql__as_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__sql__stored_procedure__recreate__as__file_name_c  );

  if Trim( sql__as_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__sql__stored_procedure__recreate__as__file_name_c + ').' );

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


  sql__default_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__sql__stored_procedure__recreate__default__file_name_c  );

  if Trim( sql__default_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__sql__stored_procedure__recreate__default__file_name_c + ').' );

      sql__default_g :=
        ' default ';

    end
  else
    begin

      sql__default_g := StringReplace( sql__default_g, #10, '', [] );
      sql__default_g := StringReplace( sql__default_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Default: ' + sql__default_g + '.' );


  sql__returns_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__sql__stored_procedure__recreate__returns__file_name_c  );

  if Trim( sql__returns_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__sql__stored_procedure__recreate__returns__file_name_c + ').' );

      sql__returns_g :=
        #13 + #10 +
        'returns ';

    end
  else
    begin

      sql__returns_g := StringReplace( sql__returns_g, #10, '', [] );
      sql__returns_g := StringReplace( sql__returns_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Returns: ' + sql__returns_g + '.' );


  sql__recreate_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__sql__stored_procedure__recreate__file_name_c  );

  if Trim( sql__recreate_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__sql__stored_procedure__recreate__file_name_c + ').' );

      sql__recreate_g :=
        'recreate procedure __STORED_PROCEDURE_NAME__ ' +
        '__STORED_PROCEDURE_PARAMETERS__ ' +
        '__STORED_PROCEDURE_RETURNS__ ' +
        sql__as_g +
        '__STORED_PROCEDURE_SOURCE__ ';

    end
  else
    begin

      sql__recreate_g := StringReplace( sql__recreate_g, #10, '', [] );
      sql__recreate_g := StringReplace( sql__recreate_g, #13, '', [] );

    end;


  if stored_procedure__edit__spm then
    begin

      Screen.Cursor := crHourGlass;


      if stored_procedure_modify_sdbm.Query__Active() then
        stored_procedure_modify_sdbm.Query__Close();

      zts_1 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__spm ) + Common.stored_procedure__sql__metadata__file_name_c  );

      if Trim( zts_1 ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__spm ) + Common.stored_procedure__sql__metadata__file_name_c + ').' );

          zts_1 := Common.stored_procedure__sql__metadata_c;

        end;

      stored_procedure_modify_sdbm.Query__Sql__Set( zts_1 );


      Log_Memo.Lines.Add( zts_1 );


      stored_procedure_modify_sdbm.Query__Param_By_Name__Set( Common.name__stored_procedure__small_letters_c, Stored_Procedure__Name_Edit.Text, Log_Memo );

      try
        stored_procedure_modify_sdbm.Query__Open();
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_stored_procedure_metadata + #13 + #13 + E.Message + #13 + #13 + zts_1 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            Screen.Cursor := crHourGlass;

          end;
      end;



      if stored_procedure_modify_sdbm.Query__Active() then
        begin

          Log_Memo.Lines.Add( stored_procedure_modify_sdbm.Operation_Duration_Get() );


          if stored_procedure_modify_sdbm.Query__Record_Count() <> 1 then
            begin

              Screen.Cursor := crDefault;

              Application.MessageBox( PChar(Translation.translation__messages_r.stored_procedure_not_found + #13 + #13 + zts_1 + #13 + #13 + Stored_Procedure__Name_Edit.Text + Translation.translation__messages_r.query_output_count_ + ' ' + stored_procedure_modify_sdbm.Query__Record_Count().ToString() + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

              stored_procedure_modify_sdbm.Query__Close();

              Screen.Cursor := crHourGlass;

            end;

        end;



      if stored_procedure_modify_sdbm.Query__Active() then
        begin

          Log_Memo.Lines.Add( stored_procedure_modify_sdbm.Operation_Duration_Get() );

          try
            //Stored_Procedure__Source_Memo.Lines.Text := stored_procedure_modify_sdbm.Query__Field_By_Name( Common.name__stored_procedure__source_c ).AsString;
            Stored_Procedure__Source_SynEdit.Lines.Text := stored_procedure_modify_sdbm.Query__Field_By_Name( Common.name__stored_procedure__source_c ).AsString;
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_stored_procedure_source_column_name + #13 + #13 + E.Message + #13 + #13 + zts_1 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

                Screen.Cursor := crHourGlass;

              end;
          end;

        end;



      if stored_procedure_modify_sdbm.Query__Active() then
        stored_procedure_modify_sdbm.Query__Close();

      zts_1 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__sql__parameters_list__file_name_c  );

      if Trim( zts_1 ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__sql__parameters_list__file_name_c + ').' );

          zts_1 :=
            'select RDB$PROCEDURE_PARAMETERS.RDB$PARAMETER_NAME as PARAMETER_NAME ' +
            '     , iif( RDB$PROCEDURE_PARAMETERS.RDB$PARAMETER_TYPE = 0, ''' + Common.db_grid__positive_value_c + ''', '''' ) as PARAMETER_TYPE_INPUT ' +
            ' ' +
            '     , (case ' +
            '         RDB$FIELDS.RDB$FIELD_TYPE ' +
            '         when 7 then ' +
            '           (case ' +
            '             RDB$FIELDS.RDB$FIELD_SUB_TYPE ' +
            '             when 1 then ' +
            '               ''Numeric'' ' +
            ' ' +
            '             when 2 then ' +
            '               ''Decimal'' ' +
            ' ' +
            '             else ' +
            '               ''Smallint'' ' +
            '           end) ' +
            ' ' +
            '         when 8 then ' +
            '           (case ' +
            '             RDB$FIELDS.RDB$FIELD_SUB_TYPE ' +
            '             when 1 then ' +
            '               ''Numeric'' ' +
            ' ' +
            '             when 2 then ' +
            '               ''Decimal'' ' +
            ' ' +
            '             else ' +
            '               ''Integer'' ' +
            '           end) ' +
            ' ' +
            '         when 9 then ' +
            '           ''Quad'' ' +
            ' ' +
            '         when 10 then ' +
            '           ''Float'' ' +
            ' ' +
            '         when 12 then ' +
            '           ''Date'' ' +
            ' ' +
            '         when 13 then ' +
            '           ''Time'' ' +
            ' ' +
            '         when 14 then ' +
            '           ''Char'' ' +
            ' ' +
            '         when 16 then ' +
            '           (case ' +
            '             RDB$FIELDS.RDB$FIELD_SUB_TYPE ' +
            '             when 1 then ' +
            '               ''Numeric'' ' +
            ' ' +
            '             when 2 then ' +
            '               ''Decimal'' ' +
            ' ' +
            '             else ' +
            '               ''Bigint'' ' +
            '           end) ' +
            ' ' +
            '         when 27 then ' +
            '           ''Double precision'' ' +
            ' ' +
            '         when 35 then ' +
            '           ''Timestamp'' ' +
            ' ' +
            '         when 37 then ' +
            '           ''Varchar'' ' +
            ' ' +
            '         when 40 then ' +
            '           ''Cstring'' ' +
            ' ' +
            '         when 45 then ' +
            '           ''Blob_Id'' ' +
            ' ' +
            '         when 261 then ' +
            '           ''Blob'' ' +
            ' ' +
            '         else ' +
            '           RDB$FIELDS.RDB$FIELD_TYPE||'' <?>'' ' +
            '       end)|| ' +
            '       iif(   RDB$FIELDS.RDB$FIELD_TYPE in ( 37 ) or ( RDB$FIELDS.RDB$FIELD_TYPE in ( 7, 8, 16, 27 ) and RDB$FIELDS.RDB$FIELD_SUB_TYPE = 2  ), ''( ''||coalesce( RDB$FIELDS.RDB$CHARACTER_LENGTH, RDB$FIELDS.RDB$FIELD_PRECISION, '''' )||' +
              'iif(  RDB$FIELDS.RDB$FIELD_TYPE in ( 7, 8, 16 ) and RDB$FIELDS.RDB$FIELD_SUB_TYPE = 2 and RDB$FIELDS.RDB$FIELD_SCALE is not null, '', ''||cast(  abs( RDB$FIELDS.RDB$FIELD_SCALE ) as smallint  ), ''''  )||'' )'', ''''   ) ' +
            '       as FIELD_TYPE ' +
            ' ' +
            '     , cast(  substring( RDB$PROCEDURE_PARAMETERS.RDB$DEFAULT_SOURCE from 1 for 255 ) as varchar( 255 )  ) as DEFAULT_VALUE__CAST ' +
            '     , RDB$PROCEDURE_PARAMETERS.RDB$DEFAULT_SOURCE as DEFAULT_VALUE ' +
            ' ' +
            '     , RDB$PROCEDURE_PARAMETERS.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
            '     , RDB$PROCEDURE_PARAMETERS.RDB$PARAMETER_TYPE ' + // Indicates whether the parameter is for input (value 0) or output (value 1).
            ' ' +
            '     , RDB$FIELDS.RDB$FIELD_TYPE ' +
            ' ' +
            'from RDB$PROCEDURE_PARAMETERS ' +
            'left join RDB$FIELDS on RDB$FIELDS.RDB$FIELD_NAME = RDB$PROCEDURE_PARAMETERS.RDB$FIELD_SOURCE ' +
            'left join RDB$RELATION_FIELDS on RDB$RELATION_FIELDS.RDB$FIELD_SOURCE = RDB$PROCEDURE_PARAMETERS.RDB$FIELD_SOURCE ' +
            'left join RDB$COLLATIONS on RDB$COLLATIONS.RDB$COLLATION_ID = RDB$FIELDS.RDB$COLLATION_ID and RDB$COLLATIONS.RDB$CHARACTER_SET_ID = RDB$FIELDS.RDB$CHARACTER_SET_ID ' +
            'where RDB$PROCEDURE_PARAMETERS.RDB$PROCEDURE_NAME = :stored_procedure_name ' +
            'order by RDB$PROCEDURE_PARAMETERS.RDB$PARAMETER_TYPE, RDB$PROCEDURE_PARAMETERS.RDB$PARAMETER_NUMBER ';

        end;

      stored_procedure_modify_sdbm.Query__Sql__Set( zts_1 );


      Log_Memo.Lines.Add( zts_1 );


      stored_procedure_modify_sdbm.Query__Param_By_Name__Set( Common.name__stored_procedure__small_letters_c, Stored_Procedure__Name_Edit.Text, Log_Memo );

      try
        stored_procedure_modify_sdbm.Query__Open();
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_stored_procedure_data + #13 + #13 + E.Message + #13 + #13 + zts_1 + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            Screen.Cursor := crHourGlass;

          end;
      end;


      if stored_procedure_modify_sdbm.Query__Active() then
        begin

          Stored_Procedure__Parameters__List_ScrollBox.Visible := false;

          while not stored_procedure_modify_sdbm.Query__Eof() do
            begin

              parameter_default_value_l := stored_procedure_modify_sdbm.Query__Field_By_Name( Common.column_name__default_value_c ).AsString;

              if default_replace_g <> '' then
                parameter_default_value_l := StringReplace( parameter_default_value_l, default_replace_g, '', [ rfReplaceAll ] );


              Stored_Procedure__Parameter.TStored_Procedure__Parameter.Create
                (
                  Stored_Procedure__Parameters__List_ScrollBox,
                  stored_procedure__parameter_id_g,
                  Trim( stored_procedure_modify_sdbm.Query__Field_By_Name( Common.stored_procedure__column__parameter_name_c ).AsString ), // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.
                  stored_procedure_modify_sdbm.Query__Field_By_Name( Common.column_name__field_type_c ).AsString,
                  parameter_default_value_l,
                  stored_procedure_modify_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString,
                  stored_procedure_modify_sdbm.Query__Field_By_Name( Common.stored_procedure__column__parameter_type_input_c ).AsString,
                  data_types_list_g,
                  splitter_show__spm,
                  Stored_Procedure__Parameter_On_Click
                );


              stored_procedure_modify_sdbm.Query__Next();

            end;

          Stored_Procedure__Parameters__List_ScrollBox.Visible := true;


          for zti_1 := Stored_Procedure__Parameters__List_ScrollBox.ControlCount - 1 downto 0 do
            if Stored_Procedure__Parameters__List_ScrollBox.Controls[ zti_1 ].ClassType = Stored_Procedure__Parameter.TStored_Procedure__Parameter then
              Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ zti_1 ]).Align_Correct__SPP();

        end;


      if stored_procedure_modify_sdbm.Query__Active() then
        stored_procedure_modify_sdbm.Query__Close();


      Screen.Cursor := crDefault;

    end;


  stored_procedure__parameter_selected_id_g := 0;

  Stored_Procedure__Parameter__Selected__Notification_Set();


  Caret_Position_Display();


  Common.Syn_Completion_Proposal__Parameters__Set( Stored_Procedure__Source__SynCompletionProposal );


  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Sql_Memo.Font, Common.sql_editor__font );
  //Common.Font__Set( Stored_Procedure__Source_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Stored_Procedure__Source_SynEdit.Font, Common.sql_editor__font );

  Common.Syn_Edit__Parameters__Set( Stored_Procedure__Source_SynEdit );


  Common.Syn_Edit__Search_Text_Hightlighter_Syn_Edit_Plugin__Create( Stored_Procedure__Source_SynEdit );

end;

procedure TStored_Procedure__Modify_Form.FormClose( Sender: TObject; var Action: TCloseAction );
begin

  if not show_modal__spm then
    FreeAndNil( Self );

end;

procedure TStored_Procedure__Modify_Form.FormDestroy( Sender: TObject );
begin

  Common.Text__Search_Replace__Syn_Edit__Set( nil, text__search_replace_form );
  Common.Text__Search_Replace__Hide( text__search_replace_form );


  if stored_procedure_modify_sdbm <> nil then
    FreeAndNil( stored_procedure_modify_sdbm );

  if text__search_replace_form <> nil then
    FreeAndNil( text__search_replace_form );


  Stored_Procedure__Parameter__Free();

end;

procedure TStored_Procedure__Modify_Form.Sql_Prepare_ButtonClick( Sender: TObject );
var
  i : integer;

  zts_1,
  zts_2
    : string;
begin

  sql_prepared_correctly_g := false;


  if Trim( Stored_Procedure__Name_Edit.Text ) = '' then
    begin

      if Stored_Procedure__Name_Edit.Enabled then
        Stored_Procedure__Name_Edit.SetFocus();

      Application.MessageBox( PChar(Translation.translation__messages_r.stored_procedure_name_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  //if Trim( Stored_Procedure__Source_Memo.Text ) = '' then
  if Trim( Stored_Procedure__Source_SynEdit.Text ) = '' then
    begin

      //Stored_Procedure__Source_Memo.SetFocus();
      Stored_Procedure__Source_SynEdit.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.stored_procedure_source_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  PageControl1.ActivePage := Sql_TabSheet;


  zts_1 := sql__recreate_g;

  zts_1 := StringReplace( zts_1, Common.sql__word_replace_separator_c + Common.name__stored_procedure__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__SPM() + Stored_Procedure__Name_Edit.Text + Self.Quotation_Sign__SPM(), [ rfReplaceAll ] );


  zts_2 := '';

  for i := 0 to Stored_Procedure__Parameters__List_ScrollBox.ControlCount - 1 do
    if    ( Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ].ClassType = Stored_Procedure__Parameter.TStored_Procedure__Parameter )
      and ( Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Type_Input__Get__SPP() ) then
      begin

        if zts_2 <> '' then
          zts_2 := zts_2 + ', ';

        if Lines_Break_CheckBox.Checked then
          zts_2 := zts_2 + Common.newline_c;


        zts_2 := zts_2 +
          Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Name_Get__SPP() +
          ' ' +
          Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Data_Type_Get__SPP();


        if Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Default_Value_Get__SPP() <> '' then
          zts_2 := zts_2 +
            sql__default_g +
            Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Default_Value_Get__SPP();

      end;

  if zts_2 <> '' then
    zts_2 := '( ' + zts_2 + ' )';

  zts_1 := StringReplace( zts_1, Common.sql__word_replace_separator_c + stored_procedure__modify__sql__stored_procedure__recreate__parameters_c + Common.sql__word_replace_separator_c, zts_2, [ rfReplaceAll ] );


  zts_2 := '';

  for i := 0 to Stored_Procedure__Parameters__List_ScrollBox.ControlCount - 1 do
    if    ( Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ].ClassType = Stored_Procedure__Parameter.TStored_Procedure__Parameter )
      and ( not Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Type_Input__Get__SPP() ) then
      begin

        if zts_2 <> '' then
          zts_2 := zts_2 + ', ';

        if Lines_Break_CheckBox.Checked then
          zts_2 := zts_2 + Common.newline_c;


        zts_2 := zts_2 +
          Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Name_Get__SPP() +
          ' ' +
          Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Data_Type_Get__SPP();

      end;

  if zts_2 <> '' then
    zts_2 := sql__returns_g + '( ' + zts_2 + ' )';

  zts_1 := StringReplace( zts_1, Common.sql__word_replace_separator_c + stored_procedure__modify__sql__stored_procedure__recreate__returns_c + Common.sql__word_replace_separator_c, zts_2, [ rfReplaceAll ] );


  //zts_1 := StringReplace( zts_1, Common.sql__word_replace_separator_c + Common.name__stored_procedure__source_c + Common.sql__word_replace_separator_c, Stored_Procedure__Source_Memo.Lines.Text, [ rfReplaceAll ] );
  zts_1 := StringReplace( zts_1, Common.sql__word_replace_separator_c + Common.name__stored_procedure__source_c + Common.sql__word_replace_separator_c, Stored_Procedure__Source_SynEdit.Lines.Text, [ rfReplaceAll ] );


  Sql_Memo.Lines.Clear();
  Sql_Memo.Lines.Add( zts_1 );


  sql_prepared_correctly_g := true;

end;

procedure TStored_Procedure__Modify_Form.Execute_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  i : integer;

  zts,
  description_value_l,
  error_message_l,
  stored_procedure__parameter_name_l
    : string;
begin

  if stored_procedure_modify_sdbm = nil then
    Exit;


  sql_prepared_correctly_g := false;


  if Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked then
    begin

      Sql_Prepare_ButtonClick( Sender );

      if not sql_prepared_correctly_g then
        Exit;

      sql_prepared_correctly_g := false;

    end;


  ztb := stored_procedure_modify_sdbm.Sql_Command_Execute( Sql_Memo.Lines.Text, error_message_l, Translation.translation__messages_r.failed_to_modify_stored_procedure, false );


  if ztb then
    begin

      if not modified__spm then
        modified__spm := true;


      if Stored_Procedure__Name_Edit.Enabled then
        stored_procedure__name__spm := Stored_Procedure__Name_Edit.Text;


      Log_Memo.Lines.Add( stored_procedure_modify_sdbm.Operation_Duration_Get() );



      if Trim( stored_procedure__description_value__spm ) <> '' then
        begin

          description_value_l := Common.Sql_Special_Characters_Protect( stored_procedure__description_value__spm );


          zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__spm ) + Common.stored_procedure__sql__description__set__file_name_c  );

          if Trim( zts ) = '' then
            begin

              Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__spm ) + Common.stored_procedure__sql__description__set__file_name_c + ').' );

              zts := Common.stored_procedure__sql__description__set_c;

            end;

          zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );
          zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__stored_procedure__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__SPM() + Stored_Procedure__Name_Edit.Text + Self.Quotation_Sign__SPM(), [ rfReplaceAll ] );


          Log_Memo.Lines.Add( zts );


          ztb := stored_procedure_modify_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_stored_procedure_description );


          if not ztb then
            begin

              if Trim( error_message_l ) <> '' then
                Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

            end;

        end;



      for i := 0 to Stored_Procedure__Parameters__List_ScrollBox.ControlCount - 1 do
        if    ( Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ].ClassType = Stored_Procedure__Parameter.TStored_Procedure__Parameter )
          and (  Trim( Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Description_Get__SPP() ) <> ''  ) then
          begin

            description_value_l := Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Description_Get__SPP();
            description_value_l := Common.Sql_Special_Characters_Protect( description_value_l );

            stored_procedure__parameter_name_l := Self.Quotation_Sign__SPM() + Stored_Procedure__Name_Edit.Text + Self.Quotation_Sign__SPM() + Common.sql__names_separator + Self.Quotation_Sign__SPM() + Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Name_Get__SPP() + Self.Quotation_Sign__SPM();

            zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__spm ) + Common.stored_procedure__sql__parameter__description__set__file_name_c  );

            if Trim( zts ) = '' then
              begin

                Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__spm ) + Common.stored_procedure__sql__parameter__description__set__file_name_c + ').' );

                zts := Common.stored_procedure__sql__parameter__description__set_c;

              end;

            zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.stored_procedure__column__parameter_name_c + Common.sql__word_replace_separator_c, stored_procedure__parameter_name_l, [ rfReplaceAll ] );
            zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );


            Log_Memo.Lines.Add( zts );


            ztb := stored_procedure_modify_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_stored_procedure_parameter_description );


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
        begin

          Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

          Common.Syn_Edit__SQL__Error__Caret_Position__Set( Stored_Procedure__Source_SynEdit, error_message_l );

        end;

    end;

end;

procedure TStored_Procedure__Modify_Form.Code_Examples_ButtonClick( Sender: TObject );
var
  zts : string;
begin

  PageControl1.ActivePage := Log_TabSheet;

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__code_examples__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__spm ) + stored_procedure__modify__code_examples__file_name_c + ').' );

      zts :=
        Translation.translation__messages_r.stored_procedure_code_example + #13 + #10 +
        '  declare variable ZTI integer;' + #13 + #10 +
        '  declare variable ZTD decimal( 12, 2 );' + #13 + #10 +
        '  declare variable ZTS varchar( 1000 );' + #13 + #10 +
        'BEGIN' + #13 + #10 +
        #13 + #10 +
        '  ZTS = ''select T1.C1' + #13 + #10 +
        '              , T1.C2' + #13 + #10 +
        '         from T1' + #13 + #10 +
        '         where T1.C2 = 123 '';' + #13 + #10 +
         #13 + #10 +
        '  ZTS = ZTS||'' order by T1.C3 '';' + #13 + #10 +
        #13 + #10 +
        #13 + #10 +
        '  for execute statement :ZTS' + #13 + #10 +
        '  into :ZTI,' + #13 + #10 +
        '       :ZTD' + #13 + #10 +
        '  do' + #13 + #10 +
        '    begin' + #13 + #10 +
        #13 + #10 +
        '      if ( ZTI is null ) then' + #13 + #10 +
        '        ZTI = 0;' + #13 + #10 +
        #13 + #10 +
        '      suspend;' + #13 + #10 +
        #13 + #10 +
        '    end' + #13 + #10 +
        #13 + #10 +
        'END';

    end
  else
    zts :=
      Translation.translation__messages_r.stored_procedure_code_example + #13 + #10 +
      zts;


  if    ( Sender <> nil )
    //and ( Sender = Stored_Procedure__Source_Memo ) then
    and ( Sender = Stored_Procedure__Source_SynEdit ) then
    //Stored_Procedure__Source_Memo.Lines.Text := zts
    Stored_Procedure__Source_SynEdit.Lines.Text := zts
  else
    Log_Memo.Lines.Add( zts );

end;

procedure TStored_Procedure__Modify_Form.Stored_Procedure__Parameter__Align_Correct_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  for i := 0 to Stored_Procedure__Parameters__List_ScrollBox.ControlCount - 1 do
    if Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ].ClassType = Stored_Procedure__Parameter.TStored_Procedure__Parameter then
      Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Align_Correct__SPP();

end;

procedure TStored_Procedure__Modify_Form.Modify__Parameter__Add_ButtonClick( Sender: TObject );
begin

  if Trim( Parameter_Name_Edit.Text ) = '' then
    begin

      if Parameter_Name_Edit.Enabled then
        Parameter_Name_Edit.SetFocus();

      Application.MessageBox( PChar(Translation.translation__messages_r.parameter_name_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;

  if not Stored_Procedure__Parameter__Name_Unique( Parameter_Name_Edit.Text ) then
    begin

      if Parameter_Name_Edit.Enabled then
        Parameter_Name_Edit.SetFocus();

      if Application.MessageBox( PChar(Translation.translation__messages_r.parameter_name_should_be_unique + #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES then
        Exit;

    end;


  Stored_Procedure__Parameter.TStored_Procedure__Parameter.Create
    (
      Stored_Procedure__Parameters__List_ScrollBox,
      stored_procedure__parameter_id_g,
      Parameter_Name_Edit.Text,
      '',
      '',
      '',
      '',
      data_types_list_g,
      splitter_show__spm,
      Stored_Procedure__Parameter_On_Click
    ).Align_Correct__SPP();

end;

procedure TStored_Procedure__Modify_Form.Modify__Parameter__Name_Set_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  if stored_procedure__parameter_selected_id_g <= 0 then
    Exit;


  if not Stored_Procedure__Parameter__Name_Unique( Parameter_Name_Edit.Text, stored_procedure__parameter_selected_id_g ) then
    begin

      if Parameter_Name_Edit.Enabled then
        Parameter_Name_Edit.SetFocus();

      if Application.MessageBox( PChar(Translation.translation__messages_r.parameter_name_should_be_unique + #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES then
        Exit;

    end;


  for i := 0 to Stored_Procedure__Parameters__List_ScrollBox.ControlCount - 1 do
    if Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ].ClassType = Stored_Procedure__Parameter.TStored_Procedure__Parameter then
      if Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Stored_Procedure__Parameter_Id__Get() = stored_procedure__parameter_selected_id_g then
        begin

          Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Name_Set__SPP( Parameter_Name_Edit.Text );

          stored_procedure__parameter_selected_id_g := Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Stored_Procedure__Parameter_Id__Get();

        end;

end;

procedure TStored_Procedure__Modify_Form.Modify__Parameter__Delete_ButtonClick( Sender: TObject );
begin

  if stored_procedure__parameter_selected_id_g <= 0 then
    Exit;


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_selected_parameter_), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES then
    Exit;


  Stored_Procedure__Parameter__Free( stored_procedure__parameter_selected_id_g );

end;

procedure TStored_Procedure__Modify_Form.Parameter__Move__Up_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  if stored_procedure__parameter_selected_id_g <= 0 then
    Exit;


  for i := 0 to Stored_Procedure__Parameters__List_ScrollBox.ControlCount - 1 do
    if Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ].ClassType = Stored_Procedure__Parameter.TStored_Procedure__Parameter then
      if Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Stored_Procedure__Parameter_Id__Get() = stored_procedure__parameter_selected_id_g then
        begin

          Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Positions_Swap__SPP( alTop );

          Break;

        end;

end;

procedure TStored_Procedure__Modify_Form.Parameter__Move__Down_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  if stored_procedure__parameter_selected_id_g <= 0 then
    Exit;


  for i := 0 to Stored_Procedure__Parameters__List_ScrollBox.ControlCount - 1 do
    if Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ].ClassType = Stored_Procedure__Parameter.TStored_Procedure__Parameter then
      if Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Stored_Procedure__Parameter_Id__Get() = stored_procedure__parameter_selected_id_g then
        begin

          Stored_Procedure__Parameter.TStored_Procedure__Parameter(Stored_Procedure__Parameters__List_ScrollBox.Controls[ i ]).Positions_Swap__SPP( alBottom );

          Break;

        end;

end;

procedure TStored_Procedure__Modify_Form.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TStored_Procedure__Modify_Form.Sql_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Sql_Memo.SelectAll();

end;

procedure TStored_Procedure__Modify_Form.Stored_Procedure__Source_MemoClick( Sender: TObject );
begin

  Caret_Position_Display();

end;

procedure TStored_Procedure__Modify_Form.Stored_Procedure__Source_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_ADD )
    and ( Shift = [ ssCtrl ] ) then
     Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked := not Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked
  else
  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Stored_Procedure__Source_Memo.SelectAll()
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

procedure TStored_Procedure__Modify_Form.Stored_Procedure__Source_MemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

end;

procedure TStored_Procedure__Modify_Form.Stored_Procedure__Source_SynEditEnter( Sender: TObject );
begin

  Common.Text__Search_Replace__Syn_Edit__Set( Stored_Procedure__Source_SynEdit, text__search_replace_form );

end;

procedure TStored_Procedure__Modify_Form.Stored_Procedure__Source_SynEditClick( Sender: TObject );
begin

  Caret_Position_Display();

  Common.Syn_Edit__Highlight__Text( Stored_Procedure__Source_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( Stored_Procedure__Source_SynEdit, text__search_replace_form );

end;

procedure TStored_Procedure__Modify_Form.Stored_Procedure__Source_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if not Common.Syn_Edit_Key_Down( Stored_Procedure__Source_SynEdit, Sender, Key, Shift ) then
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

procedure TStored_Procedure__Modify_Form.Stored_Procedure__Source_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

  Common.Syn_Edit__Highlight__Text( Stored_Procedure__Source_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( Stored_Procedure__Source_SynEdit, text__search_replace_form );

end;

procedure TStored_Procedure__Modify_Form.Stored_Procedure__Source_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );
begin

  Common.Syn_Edit__On_Replace_Text(  Stored_Procedure__Source_SynEdit, ASearch, AReplace, Line, Column, Action, ClientToScreen( Self.ClientRect )  );

end;

procedure TStored_Procedure__Modify_Form.Stored_Procedure__Source__SynCompletionProposalCodeCompletion( Sender: TObject; var Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
begin

  Common.Syn_Completion_Proposal_Code_Completion( code_completion__cursor_position_g, Value );

end;

procedure TStored_Procedure__Modify_Form.Stored_Procedure__Source__SynCompletionProposalAfterCodeCompletion( Sender: TObject; const Value: string; Shift: TShiftState; Index: Integer; EndToken: Char );
begin

  Common.Syn_Completion_Proposal_After_Code_Completion( Stored_Procedure__Source_SynEdit, code_completion__cursor_position_g );

end;

end.
