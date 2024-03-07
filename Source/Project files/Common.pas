unit Common;{16.Cze.2023}

interface

uses
  Data.DB,
  Data.Win.ADODB,
  FireDAC.Comp.Client,
  FireDAC.Stan.Option,
  SynEdit,
  System.Classes,
  System.Variants,
  Vcl.DBGrids,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Grids,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.StdCtrls,
  Winapi.Windows,

  SynCompletionProposal,

  Text__Search_Replace,

  Interceptor__Syn_Edit;

type
  TComponent_Type = ( ct_none, ct_ADO, ct_FireDAC );
  TOperation_Duration_Calculating_Type = ( odct_multi_command, odct_multi_command__initialization, odct_single_command );
  TPage_Control_Children_Find_Function = ( pccff_none, pccff_Highlight_Font_Set, pccff_Options_Set, pccff_Task_Running_Check, pccff_Translation__Apply );

  TKey_Down_wsk = procedure( Sender : TObject; var Key : Word; Shift : TShiftState ) of object;

  TDatabases_r = record
    login_prompt : boolean;

    alias,
    ado__connection_string,
    database_type, // The same as the database types directory names.
    fire_dac__driver_id,
    fire_dac__file_path,
    fire_dac__parameters,
    password,
    sql__parameter_sign,
    sql__quotation_sign,
    user_name
      : string;

    component_type : TComponent_Type;
  end;

  TCustomSynEdit_Helper = class helper for SynEdit.TCustomSynEdit
    procedure Plugin__Search_Highlighter__Brackets__Set( const brackets__all_pairs_f, brackets__angle_f, brackets__curly_f, brackets__marked_only_f, brackets__round_f, brackets__square_f : boolean );
    procedure Plugin__Search_Highlighter__Destroy();
  end;

  TObject_Id_Caption = class
    id : integer;

    caption,
    name
      : string;
  end;

  TSDBM = class
  private
    { Private declarations }
    ado_query__manage, // Whether create and free.
    database_connection__manage, // Whether create and free.
    fd_query__manage // Whether create and free.
      : boolean;

    ado_connection__sdbm : Data.Win.ADODB.TADOConnection;
    fd_connection__sdbm : FireDAC.Comp.Client.TFDConnection;

    ado_query__sdbm : TADOQuery;
    fd_query__sdbm : TFDQuery;

    operation__begin_date_time,
    operation__end_date_time
      : TDateTime;

    operation_duration__calculating_type : TOperation_Duration_Calculating_Type;

    procedure Operation__Begin_Date_Time__Set();
  public
    { Public declarations }
    component_type__sdbm : TComponent_Type;

    constructor Create( sdbm_f : TSDBM ); overload;
    constructor Create( ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const database_connection__separated_f : boolean = false ); overload;
    constructor Create( ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; ado_query_f : TADOQuery; fd_query_f : TFDQuery; const database_connection__separated_f : boolean = false ); overload;
    destructor Destroy(); override;

    procedure Component_Type_Set( const component_type_f : TComponent_Type; const fire_dac__fetch_options__mode_f : TFDFetchMode; const fire_dac__fetch_options__record_count_mode_f : TFDRecordCountMode; const fire_dac__fetch_options__rowset_size_f : integer );

    //procedure Connections_Assign_To( sdbm_f : TSDBM );

    function Connected() : boolean;
    procedure Connection__Close();
    procedure Connection__Open( const databases_r_f : TDatabases_r; log_memo_f : TMemo; const component_type_f : Common.TComponent_Type = Common.ct_ADO );

    procedure Data_Source__Data_Set__Set( data_source_f : TDataSource );

    class function Duration_To_String( const begin_date_time_f, end_date_time_f : TDateTime ) : string;

    procedure Operation_Duration__Calculating_Type__Set( const operation_duration__calculating_type_f : TOperation_Duration_Calculating_Type );
    function Operation_Duration_Get() : string;

    procedure Queries__Manage( const do_create_f : boolean );
    procedure Queries__Recreate();

    function Query__Active() : boolean;
    function Query__Bof() : boolean;
    procedure Query__Close();
    procedure Query__Disable_Controls();
    procedure Query__Display_Format( const field_name_f, display_format_f : string );
    procedure Query__Delete();
    procedure Query__Enable_Controls();
    function Query__Eof() : boolean;
    procedure Query__Fetch_Options__Mode( const mode_f : TFDFetchMode );
    procedure Query__Fetch_Options__Record_Count_Mode( const record_count_mode_f : TFDRecordCountMode );
    procedure Query__Fetch_Options__Rowset_Size( const rowset_size_f : integer );
    function Query__Field_By_Name( const field_name_f : string ) : TField;
    function Query__Field_Count() : integer;
    function Query__Fields( const field_number_f : integer ) : TField;
    procedure Query__First();
    procedure Query__Insert();
    procedure Query__Last();
    function Query__Locate( const key_fields_f : string; const key_values_f : Variant; options_f : Data.DB.TLocateOptions) : boolean;
    procedure Query__Next();
    procedure Query__Open();
    function Query__Param_By_Index__Name__Get( const parameter_number_f : integer ) : string;
    function Query__Param_By_Index__Value__Get( const parameter_number_f : integer ) : variant;
    procedure Query__Param_By_Index__Set( const index_f : integer; const value_f : variant; log_memo_f : TMemo = nil );
    procedure Query__Param_By_Name__Set( const name_f : string; const value_f : variant; log_memo_f : TMemo = nil );
    function Query__Parameters_Count() : integer;
    procedure Query__Prior();
    function Query__Record_Count() : integer;
    function Query__Record_Number() : integer;
    procedure Query__Record_Number__Set( const query_record_number_copy_f : integer );
    procedure Query__Requery();
    procedure Query__Sort( sort_string_f : string );
    function Query__Sql__Get() : string;
    procedure Query__Sql__Set( const sql_f : string );

    function Sql_Command_Execute( const sql_f : string; error_message_f : string = '' ) : boolean; overload;
    function Sql_Command_Execute( const sql_f : string; out error_message_out_f : string; error_message_f : string = ''; const ado_command_param_check_f : boolean = true ) : boolean; overload;
    function Sql_Command_Execute( const sql_f : string; const parameters_t_f : array of string; out error_message_out_f : string; error_message_f : string = ''; const ado_command_param_check_f : boolean = true ) : boolean; overload;
    function Sql_Command_Execute( const sql_f : string; const parameters_t_f : array of const; out error_message_out_f : string; error_message_f : string = ''; const ado_command_param_check_f : boolean = true ) : boolean; overload; //????

    procedure Transaction__Begin();
    procedure Transaction__Commit();
    function Transaction__In() : boolean;
    procedure Transaction__Rollback();
  end;

  TSql_Parameter = class( Vcl.StdCtrls.TGroupBox )
  private
    { Private declarations }
    parameter_number : integer;
    parameter_name : string;
  public
    { Public declarations }
    value_edit : Vcl.StdCtrls.TEdit;

    constructor Create( parent_f : Vcl.Controls.TWinControl; const caption_f : string; key_down_wsk_f : TKey_Down_wsk );
    destructor Destroy(); override;

    function Parameter_Name_Get() : string;
    function Parameter_Number_Get() : integer;
    procedure Parameter_Number_Set( const parameter_number_f : integer );
    procedure Parameter_SetFocus();
    function Parameter_Value_Get() : string;
    procedure Parameter_Value_Set( const value_f : string );
  end;


function Case_Insensitive_To_String( const value_f : string; const case_insensitive_f : boolean ) : string;
function Column__Name_To_Grid_Caption( const column_name_f : string ) : string;
function Column__Values__Distinct__Processing( sdbm_f : TSDBM; db_grid_f : Vcl.DBGrids.TDBGrid; var items_count_f : integer; progress_bar_f : Vcl.ComCtrls.TProgressBar = nil; progres_show_f : boolean = false ) : string;
function Column__Values__Sum__Processing( sdbm_f : TSDBM; db_grid_f : Vcl.DBGrids.TDBGrid; var error_message_f : string; progress_bar_f : Vcl.ComCtrls.TProgressBar = nil; progres_show_f : boolean = false ) : currency;
procedure Comment__Uncomment_Line( syn_edit_f : TSynEdit; const go_up_f : boolean = false );
procedure Comment__Uncomment_Line__Slash( syn_edit_f : TSynEdit; const go_up__or__invert_f : boolean = false );
procedure Data_Value_Format__Set( sdbm_f : TSDBM; log_memo_f : TMemo; const display_format__disabled_f: boolean = false );
function Database__Connection__Open( ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const databases_r_f : TDatabases_r; log_memo_f : TMemo; const component_type_f : Common.TComponent_Type = Common.ct_ADO ) : TModalResult;
procedure Database__Connections__Close( ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection );
function Databases_Type__Directory_Path__Get( const database_type_f : string ) : string;
procedure DB_Grid_Draw_Column_Cell( const sort__column_name_f : string; db_grid_f : Vcl.DBGrids.TDBGrid; const Rect : Winapi.Windows.TRect; DataCol : Integer; Column : Vcl.DBGrids.TColumn; State : Vcl.Grids.TGridDrawState );
procedure DB_Grid_Select( db_grid_f : Vcl.DBGrids.TDBGrid; const selected_f : boolean; const invertf : boolean = false );
procedure Font__Set( font__to_f, font__from_f : TFont );
procedure Items_From_Text_Add( items_f : System.Classes.TStrings; text_f : string );
function Parent_Form_Find( object_f : TObject ) : TForm;
function Sort_Direction_Symbol( const ascending_f : boolean = true ) : string;
function Sql_Special_Characters_Protect( const text_f : string ) : string;
procedure Syn_Completion_Proposal_After_Code_Completion( syn_edit_f : TSynEdit; var code_completion__cursor_position_f : integer );
procedure Syn_Completion_Proposal_Code_Completion( var code_completion__cursor_position_f : integer; var value_f : string );
procedure Syn_Completion_Proposal__Parameters__Set( syn_completion_proposal_f : SynCompletionProposal.TSynCompletionProposal );
function Syn_Edit__CharScan( syn_edit_f : TSynEdit; const do_delete_f : boolean = false ) : string;
procedure Syn_Edit__Highlight__Text( syn_edit_f : TSynEdit );
function Syn_Edit_Key_Down( syn_edit_f : TSynEdit; Sender: TObject; var Key: Word; Shift: TShiftState ) : boolean; overload;
function Syn_Edit_Key_Down( syn_edit_f : TSynEdit; Sender: TObject; var Key: Word; Shift: TShiftState; const bookmarks__toggle__with__line_color_f : boolean ) : boolean; overload;
procedure Syn_Edit__On_Replace_Text( syn_edit_f : TSynEdit; ASearch, AReplace : string; Line, Column : Integer; var Action : TSynReplaceAction; AClientRect : TRect );
procedure Syn_Edit__Parameters__Set( syn_edit_f : TSynEdit );
procedure Syn_Edit__Search_Text_Hightlighter_Syn_Edit_Plugin__Create( syn_edit_f : TSynEdit ); overload;
procedure Syn_Edit__Search_Text_Hightlighter_Syn_Edit_Plugin__Create( syn_edit_f : TSynEdit; const color__brackets__background_f, color__brackets__border_f, color__words__background_f, color__words__border_f : integer; const brackets__all_pairs_f, brackets__angle_f, brackets__curly_f, brackets__marked_only_f, brackets__round_f, brackets__square_f : boolean ); overload;
function Text__File_Load( const file_path_f : string ) : string;
function Text__Search_Replace__Is_Nil( text__search_replace_form_f : Text__Search_Replace.TText__Search_Replace_Form ) : boolean;
procedure Text__Search_Replace__Direction__Invert( text__search_replace_form_f : Text__Search_Replace.TText__Search_Replace_Form );
procedure Text__Search_Replace__Do( syn_edit_f : TSynEdit; text__search_replace_form_f : Text__Search_Replace.TText__Search_Replace_Form );
procedure Text__Search_Replace__Hide( text__search_replace_form_f : Text__Search_Replace.TText__Search_Replace_Form );
procedure Text__Search_Replace__Syn_Edit__Set( syn_edit_f : TSynEdit; text__search_replace_form_f : Text__Search_Replace.TText__Search_Replace_Form );
procedure Text__Search_Replace__Window_Show( syn_edit_f : TSynEdit; var text__search_replace_form_f : Text__Search_Replace.TText__Search_Replace_Form; const replace_f : boolean = false );
function User_Role__Name_Unique( const name_f, database_type_f : string; sdbm_f : TSDBM; log_memo_f : TMemo ) : boolean;


const
  code_completion__caption_value_separator_c : string = '-->';
  //code_completion__cursor_position__symbol_c : string = '|'; //???

  color__blue__light_c : integer = $00FFF7F7;
  color__red__light_c : integer = $00EAEAFF;
  column_name__default_value_c : string = 'DEFAULT_VALUE';
  column_name__default_value__cast_c : string = 'DEFAULT_VALUE__CAST';
  column_name__field_type_c : string = 'FIELD_TYPE';
  column_name__primary_key_c : string = 'PRIMARY_KEY_NAME';

  databases_list_file_name_c : string = 'databases list.xml';
  databases_type_directory_name_c : string = 'Database types';

  database__backup_restore__parameters__separator_c : string = '|';

  db_grid__positive_value_c : string = 'V';

  dependencies_list__column__depended_on__name_c : string = 'DEPENDED_ON_NAME'; // They depend on him [od niego zale¿¹].
  dependencies_list__column__depended_on__type_c : string = 'DEPENDED_ON_TYPE';
  dependencies_list__column__depended_on__type_name_c : string = 'DEPENDED_ON_TYPE_NAME';
  dependencies_list__column__dependent__name_c : string = 'DEPENDENT_NAME'; // Depends on [zale¿y od].
  dependencies_list__column__dependent__type_c : string = 'DEPENDENT_TYPE';
  dependencies_list__column__dependent__type_name_c : string = 'DEPENDENT_TYPE_NAME';
  dependencies_list__column__field_name_c : string = 'FIELD_NAME';
  dependencies_list__depended_on__file_name_c : string = 'Table__Dependencies_List__Depended_On__sql.txt';
  dependencies_list__depended_on__sql_c : string =
    {$region 'Sql text.'}
    'select RDB$DEPENDENCIES.RDB$DEPENDED_ON_NAME as DEPENDED_ON_NAME ' +
    '     , RDB$DEPENDENCIES.RDB$DEPENDED_ON_TYPE as DEPENDED_ON_TYPE ' +
    '     , RDB$DEPENDENCIES.RDB$DEPENDENT_NAME as DEPENDENT_NAME ' +
    '     , RDB$DEPENDENCIES.RDB$DEPENDENT_TYPE as DEPENDENT_TYPE ' +
    '     , RDB$DEPENDENCIES.RDB$FIELD_NAME as FIELD_NAME ' +
    ' ' +
    '     , (case ' +
    '         RDB$DEPENDENCIES.RDB$DEPENDED_ON_TYPE ' +
    '         when 0 then ' +
    '           ''table (or a column in it)'' ' +
    ' ' +
    '         when 1 then ' +
    '           ''view'' ' +
    ' ' +
    '         when 2 then ' +
    '           ''trigger'' ' +
    ' ' +
    '         when 3 then ' +
    '           ''computed column'' ' +
    ' ' +
    '         when 4 then ' +
    '           ''CHECK constraint'' ' +
    ' ' +
    '         when 5 then ' +
    '           ''procedure (or its parameter(s))'' ' +
    ' ' +
    '         when 6 then ' +
    '           ''index expression'' ' +
    ' ' +
    '         when 7 then ' +
    '           ''exception'' ' +
    ' ' +
    '         when 8 then ' +
    '           ''user'' ' +
    ' ' +
    '         when 9 then ' +
    '           ''column'' ' +
    ' ' +
    '         when 10 then ' +
    '           ''index'' ' +
    ' ' +
    '         when 14 then ' +
    '           ''generator (sequence)'' ' +
    ' ' +
    '         when 15 then ' +
    '           ''UDF or stored function'' ' +
    ' ' +
    '         when 17 then ' +
    '           ''collation'' ' +
    ' ' +
    '         when 18 then ' +
    '           ''package header'' ' +
    ' ' +
    '         when 19 then ' +
    '           ''package body'' ' +
    ' ' +
    '         else ' +
    '           RDB$DEPENDENCIES.RDB$DEPENDED_ON_TYPE||'' <?>'' ' +
    '       end) as DEPENDED_ON_TYPE_NAME ' +
    ' ' +
    ' ' +
    '     , (case ' +
    '         RDB$DEPENDENCIES.RDB$DEPENDENT_TYPE ' +
    '         when 0 then ' +
    '           ''table'' ' +
    ' ' +
    '         when 1 then ' +
    '           ''view'' ' +
    ' ' +
    '         when 2 then ' +
    '           ''trigger'' ' +
    ' ' +
    '         when 3 then ' +
    '           ''computed column'' ' +
    ' ' +
    '         when 4 then ' +
    '           ''CHECK constraint'' ' +
    ' ' +
    '         when 5 then ' +
    '           ''procedure'' ' +
    ' ' +
    '         when 6 then ' +
    '           ''index expression'' ' +
    ' ' +
    '         when 7 then ' +
    '           ''exception'' ' +
    ' ' +
    '         when 8 then ' +
    '           ''user'' ' +
    ' ' +
    '         when 9 then ' +
    '           ''column'' ' +
    ' ' +
    '         when 10 then ' +
    '           ''index'' ' +
    ' ' +
    '         when 15 then ' +
    '           ''stored function'' ' +
    ' ' +
    '         when 18 then ' +
    '           ''package header'' ' +
    ' ' +
    '         when 19 then ' +
    '           ''package body'' ' +
    ' ' +
    '         else ' +
    '           RDB$DEPENDENCIES.RDB$DEPENDENT_TYPE||'' <?>'' ' +
    '       end) as DEPENDENT_TYPE_NAME ' +
    ' ' +
    'from RDB$DEPENDENCIES ' +
    'where RDB$DEPENDENCIES.RDB$DEPENDED_ON_NAME = :table_name ' +
    'order by RDB$DEPENDENCIES.RDB$DEPENDENT_NAME, RDB$DEPENDENCIES.RDB$DEPENDED_ON_NAME, RDB$DEPENDENCIES.RDB$FIELD_NAME ';
    {$endregion 'Sql text.'}
  dependencies_list__dependent__file_name_c : string = 'Table__Dependencies_List__Dependent__sql.txt';
  dependencies_list__dependent__sql_c : string =
    {$region 'Sql text.'}
    'select RDB$DEPENDENCIES.RDB$DEPENDED_ON_NAME as DEPENDED_ON_NAME ' +
    '     , RDB$DEPENDENCIES.RDB$DEPENDED_ON_TYPE as DEPENDED_ON_TYPE ' +
    '     , RDB$DEPENDENCIES.RDB$DEPENDENT_NAME as DEPENDENT_NAME ' +
    '     , RDB$DEPENDENCIES.RDB$DEPENDENT_TYPE as DEPENDENT_TYPE ' +
    '     , RDB$DEPENDENCIES.RDB$FIELD_NAME as FIELD_NAME ' +
    ' ' +
    '     , (case ' +
    '         RDB$DEPENDENCIES.RDB$DEPENDED_ON_TYPE ' +
    '         when 0 then ' +
    '           ''table (or a column in it)'' ' +
    ' ' +
    '         when 1 then ' +
    '           ''view'' ' +
    ' ' +
    '         when 2 then ' +
    '           ''trigger'' ' +
    ' ' +
    '         when 3 then ' +
    '           ''computed column'' ' +
    ' ' +
    '         when 4 then ' +
    '           ''CHECK constraint'' ' +
    ' ' +
    '         when 5 then ' +
    '           ''procedure (or its parameter(s))'' ' +
    ' ' +
    '         when 6 then ' +
    '           ''index expression'' ' +
    ' ' +
    '         when 7 then ' +
    '           ''exception'' ' +
    ' ' +
    '         when 8 then ' +
    '           ''user'' ' +
    ' ' +
    '         when 9 then ' +
    '           ''column'' ' +
    ' ' +
    '         when 10 then ' +
    '           ''index'' ' +
    ' ' +
    '         when 14 then ' +
    '           ''generator (sequence)'' ' +
    ' ' +
    '         when 15 then ' +
    '           ''UDF or stored function'' ' +
    ' ' +
    '         when 17 then ' +
    '           ''collation'' ' +
    ' ' +
    '         when 18 then ' +
    '           ''package header'' ' +
    ' ' +
    '         when 19 then ' +
    '           ''package body'' ' +
    ' ' +
    '         else ' +
    '           RDB$DEPENDENCIES.RDB$DEPENDED_ON_TYPE||'' <?>'' ' +
    '       end) as DEPENDED_ON_TYPE_NAME ' +
    ' ' +
    ' ' +
    '     , (case ' +
    '         RDB$DEPENDENCIES.RDB$DEPENDENT_TYPE ' +
    '         when 0 then ' +
    '           ''table'' ' +
    ' ' +
    '         when 1 then ' +
    '           ''view'' ' +
    ' ' +
    '         when 2 then ' +
    '           ''trigger'' ' +
    ' ' +
    '         when 3 then ' +
    '           ''computed column'' ' +
    ' ' +
    '         when 4 then ' +
    '           ''CHECK constraint'' ' +
    ' ' +
    '         when 5 then ' +
    '           ''procedure'' ' +
    ' ' +
    '         when 6 then ' +
    '           ''index expression'' ' +
    ' ' +
    '         when 7 then ' +
    '           ''exception'' ' +
    ' ' +
    '         when 8 then ' +
    '           ''user'' ' +
    ' ' +
    '         when 9 then ' +
    '           ''column'' ' +
    ' ' +
    '         when 10 then ' +
    '           ''index'' ' +
    ' ' +
    '         when 15 then ' +
    '           ''stored function'' ' +
    ' ' +
    '         when 18 then ' +
    '           ''package header'' ' +
    ' ' +
    '         when 19 then ' +
    '           ''package body'' ' +
    ' ' +
    '         else ' +
    '           RDB$DEPENDENCIES.RDB$DEPENDENT_TYPE||'' <?>'' ' +
    '       end) as DEPENDENT_TYPE_NAME ' +
    ' ' +
    'from RDB$DEPENDENCIES ' +
    'where RDB$DEPENDENCIES.RDB$DEPENDENT_NAME = :table_name ' +
    'order by RDB$DEPENDENCIES.RDB$DEPENDENT_NAME, RDB$DEPENDENCIES.RDB$DEPENDED_ON_NAME, RDB$DEPENDENCIES.RDB$FIELD_NAME ';
    {$endregion 'Sql text.'}

  external_functions__column__external_functions_name__big_letter_c : string = 'EXTERNAL_FUNCTION_NAME';
  external_functions__sql__description__set_c : string = 'comment on function __EXTERNAL_FUNCTION_NAME__ is ''__DESCRIPTION_VALUE__'' ';
  external_functions__sql__description__set__file_name_c : string = 'External_Function__Description__Set__sql.txt';

  languages__directory_name_c : string = 'Languages';
  languages__file__extension_c : string = '.txt';

  minus_sign_s_c : string = '-';

  name__column__big_letters_c : string = 'COLUMN_NAME';
  name__description_value_c : string = 'DESCRIPTION_VALUE';
  name__description_value__cast_c : string = 'DESCRIPTION_VALUE__CAST';
  name__owner_name_c : string = 'OWNER_NAME';
  name__parameter_number_c : string = 'PARAMETER_NUMBER';
  name__position_value_c : string = 'POSITION_VALUE';
  name__stored_procedure__big_letters_c : string = 'STORED_PROCEDURE_NAME';
  name__stored_procedure__small_letters_c : string = 'stored_procedure_name';
  name__stored_procedure__source_c : string = 'STORED_PROCEDURE_SOURCE';
  name__table__big_letters_c : string = 'TABLE_NAME';
  name__table__small_letters_c : string = 'table_name';
  name__trigger__active_c : string = 'TRIGGER_ACTIVE';
  name__trigger__name__big_letters_c : string = 'TRIGGER_NAME';
  name__trigger__name__small_letters_c : string = 'trigger_name';
  name__trigger__source_c : string = 'TRIGGER_SOURCE';
  name__user__name__big_letters_c : string = 'USER_NAME';
  name__user__name__small_letters_c : string = 'user_name';
  name__user__password_c : string = 'USER__PASSWORD';
  name__view__big_letters_c : string = 'VIEW_NAME';
  name__view__small_letters_c : string = 'view_name';
  name__view__source_c : string = 'VIEW_SOURCE';

  newline_symbol_c : string = '#13#10';

  notification__sign__busy_c : string = ' ...';
  notification__sign__modified_c : string = '*';
  notification__sign__null_c : string = '<null>';

  primary_key__file_name_c : string = 'Table__Primary_Key__sql.txt';

  query__sort__ascending_c : string = '__*asc@_v ! '' __';
  query__sort__descending_c : string = '__*desc@_^ ! '' __';

  sql_editor__code_completion_list_c : string =
    {$region 'Code completion list.'}
    //code_completion__caption_value_separator_c //???
    //code_completion__cursor_position__symbol_c //???
    //'count( | )' + #13 + #10 + // For TMemo.
    //'distinct ' + #13 + #10 +
    //'first ' + #13 + #10 +
    //'max( | )' + #13 + #10 +
    //'min( | )' + #13 + #10 +
    //'order by ' + #13 + #10;

    // For TSynEdit.
    //'\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}count\style{-B}-->count( | )' + #13 + #10 +
    //'\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}distinct\style{-B}-->distinct ' + #13 + #10 +
    //'\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}first\style{-B}-->first ' + #13 + #10 +
    //'\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}max\style{-B}-->max( | )' + #13 + #10 +
    //'\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}min\style{-B}-->min( | )' + #13 + #10 +
    //'\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}order by\style{-B}-->order by ' + #13 + #10;
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}     , \style{-B}-->     , ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}#13#10\style{-B}-->#13#10' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}     , (case(...)\style{-B}-->case~#13#10     , (case#13#10         when ( T1.C1 > 3320 ) then#13#10           T1.C1#13#10         else#13#10           T1.C2#13#10       end) as ALIAS' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}abs( | )\style{-B}-->abs( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}and \style{-B}-->and ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}as \style{-B}-->as ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}asc\style{-B}-->asc' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}ascii_char( 13 )||ascii_char( 10 )\style{-B}-->ascii_char( 13 )||ascii_char( 10 )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}boolean \style{-B}-->boolean ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}cast( ''NOW'' as timestamp )\style{-B}-->cast( ''NOW'' as timestamp )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}cast(  ''13'' as varchar( 3 )  )\style{-B}-->cast(  ''13'' as varchar( 3 )  )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}cast(  substring( | from 1 for 50 ) as varchar( 50 )  )\style{-B}-->cast(  substring( | from 1 for 50 ) as varchar( 50 )  )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}char \style{-B}-->char ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}char_length( | )\style{-B}-->char_length( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}ceil( | )\style{-B}-->ceil( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}character_length( | )\style{-B}-->character_length( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}coalesce( T1.C1, T1.C2, T1.C3 )\style{-B}-->coalesce( |, ,  )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}collate PXW_PLK\style{-B}-->collate PXW_PLK' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}count( | )\style{-B}-->count( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}CURRENT_DATE\style{-B}-->CURRENT_DATE' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}CURRENT_TIME\style{-B}-->CURRENT_TIME' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}CURRENT_TIMESTAMP\style{-B}-->CURRENT_TIMESTAMP' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}date \style{-B}-->date ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}dateadd( 2 year to | )\style{-B}-->dateadd( 2 year to | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}dateadd: month, day, hour, minute, second, millisecond\style{-B}-->dateadd: month, day, hour, minute, second, millisecond' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}datediff( month, |, | )\style{-B}-->datediff( month, |, | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}datediff: year, month, week, day, hour, minute, second, millisecond\style{-B}-->datediff: year, month, week, day, hour, minute, second, millisecond' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}decimal( 12, 4 ); \style{-B}-->decimal( 12, 4 ) ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}declare variable \style{-B}-->declare variable ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}delete from \style{-B}-->delete from ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}desc\style{-B}-->desc' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}distinct \style{-B}-->distinct ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}extract( year from | )\style{-B}-->extract( year from | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}extract: month, day, hour, minute, second, millisecond\style{-B}-->extract: month, day, hour, minute, second, millisecond' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}first \style{-B}-->first ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}floor( | )\style{-B}-->floor( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}from\style{-B}-->from ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}group by \style{-B}-->group by ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}iif( | = ''M'', ''Yes'', ''No'' )\style{-B}-->iif( | = ''M'', ''Yes'', ''No'' )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}insert into  values \style{-B}-->insert into  values ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}insert into table(...)\style{-B}-->insert into tabela#13#10    (#13#10        C1#13#10      , C2#13#10    )#13#10  values#13#10    (#13#10        v_c1#13#10      ' +
      ', ( select C2 from T2 where ... )#13#10    )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}integer \style{-B}-->integer ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}is null \style{-B}-->is null ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}is not null \style{-B}-->is not null ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}join\style{-B}-->join ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}left join | on  = \style{-B}-->left join | on  = ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}list (select)\style{-B}-->list~#13#10select cast#13#10         (#13#10           substring#13#10             (#13#10               list( ''(id: '' || T1.C1 || ''; name: '' || T1.C2 || '')'' )' +
      '#13#10               from 1 for 50#13#10             )#13#10           as varchar( 50 )#13#10         )#13#10from T1' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}list (     , )\style{-B}-->list~#13#10     , (#13#10         select cast#13#10                  (#13#10                    substring#13#10                      (#13#10' +
      '                        list( T1.C1 || '' '' )#13#10                        /* list( T1.C1, '', '' )  // Or. */#13#10                        /* list(  all T1.C1, ascii_char( 13 )  )  // Or. */#13#10' +
      '                        /* list( distinct T1.C1, '', '' )  // Or. */#13#10                        from 1 for 50#13#10                      )#13#10                    as varchar( 50 )#13#10                  )#13#10         from T1#13#10' +
      '         where T1 = 1#13#10       )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}lower( | )\style{-B}-->lower( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}lpad( | , 6, 0 )\style{-B}-->lpad( | , 6, 0 )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}max( | )\style{-B}-->max( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}min( | )\style{-B}-->min( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}not \style{-B}-->not ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}not null \style{-B}-->not null ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}null \style{-B}-->null ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}or \style{-B}-->or ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}order by\style{-B}-->order by ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}position( ''pattern'', T1.C1 )\style{-B}-->position( ''pattern'', T1.C1 )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}RDB$DATABASE\style{-B}-->RDB$DATABASE' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}replace( |, ''old_pattern'', ''new_pattern'' )\style{-B}-->replace( |, ''old_pattern'', ''new_pattern'' )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}right join | on  = \style{-B}-->right join |  on = ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}round( | )\style{-B}-->round( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}round( |, 0 )\style{-B}-->round( |, 0 )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}rpad( | , 6, 0 )\style{-B}-->rpad( | , 6, 0 )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}select \style{-B}-->select ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}set \style{-B}-->set ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}smallint \style{-B}-->smallint ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}strlen( | )\style{-B}-->strlen( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}substr( | , 6, 7 )\style{-B}-->substr( | , 6, 7 )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}substring( | from 2 )\style{-B}-->substring( | from 2 )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}substring( | from 1 for 2 )\style{-B}-->substring( | from 1 for 2 )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}sum( | )\style{-B}-->sum( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}time \style{-B}-->time ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}timestamp \style{-B}-->timestamp ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}trim( | )\style{-B}-->trim( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}trunc( | )\style{-B}-->trunc( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}union \style{-B}-->union ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}update \style{-B}-->update ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}upper( | )\style{-B}-->upper( | )' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}values \style{-B}-->values ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}varchar( 100 ) \style{-B}-->varchar( 100 ) ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}where \style{-B}-->where ' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}/*\style{-B}-->/*' + #13 + #10 +
    '\color{clGreen}__sql__ \color{clWindowText}\column{}\style{+B}*/\style{-B}-->*/' + #13 + #10;
    {$endregion 'Code completion list.'}
  sql_editor__code_completion_list__file_name_c : string = 'Sql_Editor__Code_Completion_List.txt';
  sql_editor__column_replace_sign_c : string = '|';

  sql__word_replace_separator_c : string = '__';

  stored_procedure__column__parameter_name_c : string = 'PARAMETER_NAME';
  stored_procedure__column__parameter_type_input_c : string = 'PARAMETER_TYPE_INPUT';
  stored_procedure__parameter__default_replace__file_name_c = 'Stored_Procedure__Parameter__Default_Replace.txt';
  stored_procedure__sql__description__set__file_name_c : string = 'Stored_Procedure__Description__Set__sql.txt';
  stored_procedure__sql__description__set_c : string = 'comment on procedure __STORED_PROCEDURE_NAME__ is ''__DESCRIPTION_VALUE__'' ';
  stored_procedure__sql__metadata_c : string =
    'select RDB$PROCEDURES.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
    '     , RDB$PROCEDURES.RDB$OWNER_NAME as OWNER_NAME ' +
    '     , RDB$PROCEDURES.RDB$PROCEDURE_ID ' +
    '     , RDB$PROCEDURES.RDB$PROCEDURE_SOURCE as STORED_PROCEDURE_SOURCE ' +
    'from RDB$PROCEDURES ' +
    'where RDB$PROCEDURES.RDB$PROCEDURE_NAME = :stored_procedure_name ';
  stored_procedure__sql__metadata__file_name_c : string = 'Stored_Procedure__Metadata__sql.txt';
  stored_procedure__sql__parameter__description__set_c : string = 'comment on parameter __PARAMETER_NAME__ is ''__DESCRIPTION_VALUE__'' ';
  stored_procedure__sql__parameter__description__set__file_name_c : string = 'Stored_Procedure__Parameter__Description__Set__sql.txt';

  table_add__primary_key_c : string = 'PRIMARY_KEY';
  table_add__sql__column__columns_separator__file_name_c : string = 'Table_Add__Columns_Separator__sql.txt';
  table_add__sql__primary_key__file_name_c : string = 'Table_Add__Primary_Key__sql.txt';
  table_add__sql__table__create__file_name_c : string = 'Table_Add__Table__Create__sql.txt';

  table_column__position_set__sql_c : string = 'alter table __TABLE_NAME__ alter __COLUMN_NAME__ position __POSITION_VALUE__; ';
  table_column__position_set__sql__file_name_c : string = 'Table__Column__Position_Set__sql.txt';

  table_columns_list__sql_c : string =
    'select RDB$RELATION_FIELDS.RDB$FIELD_NAME as COLUMN_NAME ' +
    '     , RDB$RELATION_FIELDS.RDB$FIELD_POSITION ' +
    'from RDB$RELATION_FIELDS ' +
    'left join RDB$RELATIONS on RDB$RELATION_FIELDS.RDB$RELATION_NAME = RDB$RELATIONS.RDB$RELATION_NAME and RDB$RELATIONS.RDB$VIEW_BLR is null and ( RDB$RELATIONS.RDB$SYSTEM_FLAG is null or RDB$RELATIONS.RDB$SYSTEM_FLAG = 0 ) ' +
    'where RDB$RELATION_FIELDS.RDB$RELATION_NAME = :table_name ' +
    'order by RDB$RELATION_FIELDS.RDB$RELATION_NAME, RDB$RELATION_FIELDS.RDB$FIELD_POSITION ';
  table_columns_list__sql__file_name_c : string = 'Table__Columns_List__sql.txt';
  tables_list__file_name_c : string = 'Tables_List__sql.txt';
  tables_list__system_tables_visible__parameter_name_c : string = 'system_tables_visible';

  trigger_modify__code_completion_list_c : string =
    {$region 'Trigger code completion list.'}
    //code_completion__caption_value_separator_c //???
    //code_completion__cursor_position__symbol_c //???
    '\color{$00004080}__trigger__ \color{clWindowText}\column{}\style{+B}begin else begin \style{-B}-->begin~#13#10  begin#13#10#13#10#13#10#13#10    end#13#10  else#13#10    begin#13#10#13#10#13#10    end' + #13 + #10 +
    '\color{$00004080}__trigger__ \color{clWindowText}\column{}\style{+B}declare variable ;\style{-B}-->declare variable ;' + #13 + #10 +
    '\color{$00004080}__trigger__ \color{clWindowText}\column{}\style{+B}if ( and ) then-->if (     :zm_1 is not null#13#10     and :zm_1 <> 0 ) then' + #13 + #10 +
    '\color{$00004080}__trigger__ \color{clWindowText}\column{}\style{+B}if (  (  ) or (  )  ) then-->if (    (  )#13#10     or (  )  ) then' + #13 + #10 +
    '\color{$00004080}__trigger__ \color{clWindowText}\column{}\style{+B}NEW.|;\style{-B}-->NEW.|;' + #13 + #10 +
    '\color{$00004080}__trigger__ \color{clWindowText}\column{}\style{+B}NEW.COLUMN_1 = 123;\style{-B}-->NEW.COLUMN_1 = 123;' + #13 + #10 +
    '\color{$00004080}__trigger__ \color{clWindowText}\column{}\style{+B}NEW.COLUMN_3 = OLD.COLUMN_2;\style{-B}-->NEW.COLUMN_3 = OLD.COLUMN_2;' + #13 + #10 +
    '\color{$00004080}__trigger__ \color{clWindowText}\column{}\style{+B}OLD.|;\style{-B}-->OLD.|;' + #13 + #10 +
    '\color{$00004080}__trigger__ \color{clWindowText}\column{}\style{+B}update (...)\style{-B}-->update~#13#10  if ( current_user = ''SYSDBA'' ) then#13#10    begin#13#10#13#10      update TABLE_2 set#13#10             TABLE_2.COLUMN_1 = NEW.COLUMN_2#13#10' +
      '      where TABLE_2.COLUMN_2 = NEW.COLUMN_1;#13#10#13#10    end' + #13 + #10;
    {$endregion 'Trigger code completion list.'}
  trigger_modify__code_completion_list__file_name_c : string = 'Trigger_Modify__Code_Completion_List.txt';
  trigger_modify__activity_c : string = 'TRIGGER_ACTIVITY';
  trigger_modify__activity_list_c : string =
    'active' + #13 + #10 +
    'inactive' + #13 + #10;
  trigger_modify__activity_list__file_name_c : string = 'Trigger_Modify__Activity_List.txt';
  trigger_modify__code_examples_c : string =
    'as' + #13 + #10 +
    '  declare variable ZTI integer;' + #13 + #10 +
    'BEGIN' + #13 + #10 +
    #13 + #10 +
    '  /* TABLE_1.COLUMN_1 */' + #13 + #10 +
    '  /* TABLE_1.COLUMN_2 */' + #13 + #10 +
    '  /* TABLE_1.COLUMN_3 */' + #13 + #10 +
    #13 + #10 +
    '  ZTI = 0;' + #13 + #10 +
    #13 + #10 +
    '  NEW.COLUMN_1 = 123;' + #13 + #10 +
    '  NEW.COLUMN_3 = OLD.COLUMN_2;' + #13 + #10 +
    #13 + #10 +
    '  if ( current_user = ''SYSDBA'' ) then' + #13 + #10 +
    '    begin' + #13 + #10 +
    #13 + #10 +
    '      update TABLE_2 set' + #13 + #10 +
    '             TABLE_2.COLUMN_1 = NEW.COLUMN_2' + #13 + #10 +
    '      where TABLE_2.COLUMN_2 = NEW.COLUMN_1;' + #13 + #10 +
    #13 + #10 +
    '    end' + #13 + #10 +
    #13 + #10 +
    'END';
  trigger_modify__code_examples__file_name_c : string = 'Trigger_Modify__Code_Examples.txt';
  trigger_modify__sequence_c : string = 'TRIGGER_SEQUENCE';

  user_role__name_unique__file_name_c : string = 'User_Role__Name_Unique__sql.txt';

  view__sql__description__set_c : string = 'comment on view __VIEW_NAME__ is ''__DESCRIPTION_VALUE__'' ';
  view__sql__description__set__file_name_c : string = 'View__Description__Set__sql.txt';
  view__sql__metadata_c : string =
    'select RDB$RELATIONS.RDB$RELATION_NAME as VIEW_NAME ' +
    '     , RDB$RELATIONS.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
    '     , RDB$RELATIONS.RDB$OWNER_NAME as OWNER_NAME ' +
    '     , RDB$RELATIONS.RDB$VIEW_SOURCE as VIEW_SOURCE ' +
    '     , cast(  substring( RDB$RELATIONS.RDB$SECURITY_CLASS from 5 for 5 ) as integer  ) as ID ' +
    'from RDB$RELATIONS ' +
    'where RDB$RELATIONS.RDB$RELATION_NAME = :view_name ';
  view__sql__metadata__file_name_c : string = 'View_Metadata__sql.txt';
  view__sql__parameter__description__set_c : string = 'comment on column __COLUMN_NAME__ is ''__DESCRIPTION_VALUE__'' ';
  view__sql__parameter__description__set__file_name_c : string = 'View__Parameter__Description__Set__sql.txt';

var
  fire_dac__fetch_options__mode : TFDFetchMode;
  fire_dac__fetch_options__record_count_mode : TFDRecordCountMode;
  fire_dac__fetch_options__rowset_size : integer;

  data_presentation__data_value_format__date__use,
  data_presentation__data_value_format__date_time__use,
  data_presentation__data_value_format__numbers__use,
  data_presentation__data_value_format__real_numbers__use,
  data_presentation__data_value_format__time__use,
  database__modify__window__maximized,
  form_view__additional_component_show,
  queries_open_in_background,
  sql_editor__block_execute__automatic_detection,
  sql_editor__bookmarks__toggle__with__line_color,
  sql_editor__close_prompt,
  sql_editor__comments_delete,
  sql_editor__database_connection__separated,
  sql_editor__execute__automatic_detection,
  sql_editor__execute__selected,
  sql_editor__font__use_in_other_components,
  sql_editor__highlights__syntax__brackets__all_pairs,
  sql_editor__highlights__syntax__brackets__angle,
  sql_editor__highlights__syntax__brackets__curly,
  sql_editor__highlights__syntax__brackets__marked_only,
  sql_editor__highlights__syntax__brackets__round,
  sql_editor__highlights__syntax__brackets__square,
  sql_editor__keyboard__shortcuts__switch__output_save__with__text_file_save,
  sql_editor__transactions_automatic,
  sql__quotation_sign__use,
  splitter_show,
  system_tables_visible,
  table__data_filter__field_dedicated__default_use,
  table__data_filter__quotation_sign__use,
  table__data_modify__editing__default_state,
  text__search__history_save_to_file,
  text__search__window__one_common
    : boolean;

  database__backup__file_name__suffix_default__item_index,
  log__auto_scroll__seconds,
  sql_editor__code__completion_window__default__lines_in_window,
  sql_editor__code__completion_window__default__width,
  sql_editor__code__dent_width,
  sql_editor__highlights__brackets__color__background,
  sql_editor__highlights__brackets__color__border,
  sql_editor__highlights__lines__active__color,
  sql_editor__highlights__words__color__background,
  sql_editor__highlights__words__color__border,
  //fd_connection__format_options__max_string_size, // Do not work. //????
  table__data_modify__filter__height_keeper__top,
  text__search__history_save_to_file__items_count
    : integer;

  all_files_find__filter,
  csv__file__data_separator,
  csv__file__default_extension,
  csv__file__text_qualifier,
  data_presentation__data_value_format__date,
  data_presentation__data_value_format__date_time,
  data_presentation__data_value_format__numbers,
  data_presentation__data_value_format__real_numbers,
  data_presentation__data_value_format__time,
  database__backup_restore__quotation_sign,
  database__backup__application__file_path,
  database__backup__file__default_extension,
  database__correctness_check_text__backup,
  database__correctness_check_text__restore,
  database__create__application__file_path,
  database__file__default_extension,
  exe__file__default_extension,
  language__selected,
  sql_editor__highlights__syntax,
  sql_editor__query_output_save_field_format__date,
  sql_editor__query_output_save_field_format__real_numbers,
  sql_editor__query_output_save_field_format__separator__date_time,
  sql_editor__query_output_save_field_format__separator__decimal,
  sql_editor__query_output_save_field_format__time,
  sql__command_separator,
  sql__comment__begin,
  sql__comment__end,
  sql__comment__line,
  sql__external_function__parameter_separator,
  sql__names_separator,
  sql__text_separator,
  sql__view__parameter_separator,
  table__data_filter__filter__dedicated_value_format__date,
  table__data_filter__filter__dedicated_value_format__separator__date_time,
  table__data_filter__filter__dedicated_value_format__separator__decimal,
  table__data_filter__filter__dedicated_value_format__time,
  txt__file__default_extension
    : string;

  sql_editor__font : Vcl.Graphics.TFont;

  syn_editor_options : SynEdit.TSynEditorOptions;


implementation

uses
  SynEditTypes,
  System.DateUtils,
  System.Math,
  System.IOUtils,
  System.StrUtils,
  System.SysUtils,
  Vcl.Clipbrd,

  plgSearchHighlighter,

  Database__List_Modify,
  Shared,
  Text__Search_Replace__Prompt,
  Translation;

procedure TCustomSynEdit_Helper.Plugin__Search_Highlighter__Brackets__Set( const brackets__all_pairs_f, brackets__angle_f, brackets__curly_f, brackets__marked_only_f, brackets__round_f, brackets__square_f : boolean );
var
  i : integer;
begin

  //if Self.fPlugins <> nil then // Do not work - cannot access private symbol TCustomSynEdit.fPlugins

  with Self do // But it works.
    begin

      if fPlugins <> nil then
        for i := 0 to fPlugins.Count - 1 do
          if SynEdit.TSynEditPlugin(fPlugins[ i ]) is plgSearchHighlighter.TSearchTextHightlighterSynEditPlugin__Brackets then
            begin

              plgSearchHighlighter.TSearchTextHightlighterSynEditPlugin__Brackets(fPlugins[ i ]).brackets__all_pairs := brackets__all_pairs_f;
              plgSearchHighlighter.TSearchTextHightlighterSynEditPlugin__Brackets(fPlugins[ i ]).brackets__angle := brackets__angle_f;
              plgSearchHighlighter.TSearchTextHightlighterSynEditPlugin__Brackets(fPlugins[ i ]).brackets__curly := brackets__curly_f;
              plgSearchHighlighter.TSearchTextHightlighterSynEditPlugin__Brackets(fPlugins[ i ]).brackets__marked_only := brackets__marked_only_f;
              plgSearchHighlighter.TSearchTextHightlighterSynEditPlugin__Brackets(fPlugins[ i ]).brackets__round := brackets__round_f;
              plgSearchHighlighter.TSearchTextHightlighterSynEditPlugin__Brackets(fPlugins[ i ]).brackets__squareg := brackets__square_f;

            end;

    end;

end;

procedure TCustomSynEdit_Helper.Plugin__Search_Highlighter__Destroy();
var
  i : integer;
begin

  //if Self.fPlugins <> nil then // Do not work - cannot access private symbol TCustomSynEdit.fPlugins

  with Self do // But it works.
    begin

      if fPlugins <> nil then
        for i := fPlugins.Count - 1 downto 0 do
          if   ( SynEdit.TSynEditPlugin(fPlugins[ i ]) is plgSearchHighlighter.TSearchTextHightlighterSynEditPlugin )
            or ( SynEdit.TSynEditPlugin(fPlugins[ i ]) is plgSearchHighlighter.TSearchTextHightlighterSynEditPlugin__Brackets ) then
            SynEdit.TSynEditPlugin(fPlugins[ i ]).Destroy();

    end;

end;

constructor TSDBM.Create( sdbm_f : TSDBM );
begin

  //sdbm_f.Connections_Assign_To( Self );
  //Self.Create( Self.ado_connection__sdbm, Self.fd_connection__sdbm, nil, nil );

  Self.Create( sdbm_f.ado_connection__sdbm, sdbm_f.fd_connection__sdbm, nil, nil );

end;

constructor TSDBM.Create( ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const database_connection__separated_f : boolean = false );
begin

  Self.Create( ado_connection_f, fd_connection_f, nil, nil, database_connection__separated_f );

end;

constructor TSDBM.Create( ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; ado_query_f : TADOQuery; fd_query_f : TFDQuery; const database_connection__separated_f : boolean = false );
begin

  Self.component_type__sdbm := ct_none;


  Self.database_connection__manage := database_connection__separated_f;

  if not Self.database_connection__manage then
    begin

      Self.ado_connection__sdbm := ado_connection_f;
      Self.fd_connection__sdbm := fd_connection_f;

    end
  else
    begin

      Self.ado_connection__sdbm := Data.Win.ADODB.TADOConnection.Create( Application );
      Self.ado_connection__sdbm.LoginPrompt := false;

      Self.fd_connection__sdbm := FireDAC.Comp.Client.TFDConnection.Create( Application );
      Self.fd_connection__sdbm.LoginPrompt := false;

    end;


  Self.ado_query__sdbm := ado_query_f;
  Self.fd_query__sdbm := fd_query_f;

  Self.ado_query__manage := Self.ado_query__sdbm = nil;
  Self.fd_query__manage := Self.fd_query__sdbm = nil;

  Self.operation_duration__calculating_type := odct_single_command;


  Queries__Manage( true );

end;

destructor TSDBM.Destroy();
begin

  Queries__Manage( false );


  if Self.database_connection__manage then
    begin

      Database__Connections__Close( Self.ado_connection__sdbm, Self.fd_connection__sdbm );


      if Self.ado_connection__sdbm <> nil then
        System.SysUtils.FreeAndNil( Self.ado_connection__sdbm );


      if Self.fd_connection__sdbm <> nil then
        System.SysUtils.FreeAndNil( Self.fd_connection__sdbm );

    end;


  inherited;

end;

procedure TSDBM.Component_Type_Set( const component_type_f : TComponent_Type; const fire_dac__fetch_options__mode_f : TFDFetchMode; const fire_dac__fetch_options__record_count_mode_f : TFDRecordCountMode; const fire_dac__fetch_options__rowset_size_f : integer );
begin

  if Self.component_type__sdbm <> component_type_f then
    begin

      Self.component_type__sdbm := component_type_f;

      Self.Queries__Recreate();

    end;


  if Self.component_type__sdbm = ct_FireDAC then
    begin

      Self.Query__Fetch_Options__Mode( fire_dac__fetch_options__mode_f );
      Self.Query__Fetch_Options__Record_Count_Mode( fire_dac__fetch_options__record_count_mode_f );
      Self.Query__Fetch_Options__Rowset_Size( fire_dac__fetch_options__rowset_size_f );

    end;

end;

//procedure TSDBM.Connections_Assign_To( sdbm_f : TSDBM );
//begin
//
//  if sdbm_f = nil then
//    Exit;
//
//
//  sdbm_f.ado_connection__sdbm := Self.ado_connection__sdbm;
//  sdbm_f.fd_connection__sdbm := Self.fd_connection__sdbm;
//
//end;

function TSDBM.Connected() : boolean;
begin

  Result := false;


  if Self.component_type__sdbm = ct_ADO then
    Result := Self.ado_connection__sdbm.Connected
  else
  if Self.component_type__sdbm = ct_FireDAC then
    Result := Self.fd_connection__sdbm.Connected;

end;

procedure TSDBM.Connection__Close();
begin

  Database__Connections__Close( Self.ado_connection__sdbm, Self.fd_connection__sdbm );

end;

procedure TSDBM.Connection__Open( const databases_r_f : TDatabases_r; log_memo_f : TMemo; const component_type_f : Common.TComponent_Type = Common.ct_ADO );
begin

  Database__Connection__Open( Self.ado_connection__sdbm, Self.fd_connection__sdbm, databases_r_f, log_memo_f, component_type_f );

end;

procedure TSDBM.Data_Source__Data_Set__Set( data_source_f : TDataSource );
begin

  if data_source_f = nil then
    Exit;


  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    data_source_f.DataSet := Self.ado_query__sdbm
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    data_source_f.DataSet := Self.fd_query__sdbm
  else
    data_source_f.DataSet := nil;

end;

class function TSDBM.Duration_To_String( const begin_date_time_f, end_date_time_f : TDateTime ) : string;
var
  days,
  hours,
  milliseconds,
  minutes,
  seconds
    : real;
begin

  milliseconds := Abs(  System.DateUtils.MilliSecondsBetween( begin_date_time_f, end_date_time_f )  );

  Result := Trim(  FormatFloat( '### ### ### ### ### ### ##0', milliseconds )  ) + ' [' + Translation.translation__messages_r.word__time__shortcut__milliseconds + ']';

  if milliseconds <> 0 then
    Result := ': ' + Translation.translation__messages_r.word__total + ' ' + Result;


  days := 0;    // 86400000 ms.
  hours := 0;   //  3600000 ms.
  minutes := 0; //    60000 ms.
  seconds := 0; //     1000 ms.


  if milliseconds >= 1000 then
    begin

      seconds := milliseconds * 0.001; // Trunc( milliseconds * 0.001 ) <> Trunc( seconds ) //???
      seconds := Trunc( seconds );

      milliseconds := milliseconds - seconds * 1000;


        if seconds >= 60 then
          begin

            minutes := seconds / 60;
            minutes := Trunc( minutes );

            seconds := seconds - minutes * 60;


            if minutes >= 60 then
              begin

                hours := minutes / 60;
                hours := Trunc( hours );

                minutes := minutes - hours * 60;


                if hours >= 24 then
                  begin

                    days := hours / 24;
                    days := Trunc( days );

                    hours := hours - days * 24;

                  end;

              end;

          end;

    end;


  if milliseconds > 0 then
    Result := Trim(  FormatFloat( '### ### ### ### ### ### ##0', milliseconds )  ) + ' [' + Translation.translation__messages_r.word__time__shortcut__milliseconds + '] ' + Result;

  if seconds > 0 then
    Result := Trim(  FormatFloat( '### ### ### ### ### ### ##0', seconds )  ) + ' [' + Translation.translation__messages_r.word__time__shortcut__seconds + '] ' + Result;

  if minutes > 0 then
    Result := Trim(  FormatFloat( '### ### ### ### ### ### ##0', minutes )  ) + ' [' + Translation.translation__messages_r.word__time__shortcut__minutes + '] ' + Result;

  if hours > 0 then
    Result := Trim(  FormatFloat( '### ### ### ### ### ### ##0', hours )  ) + ' [' + Translation.translation__messages_r.word__time__shortcut__hours + '] ' + Result;

  if days > 0 then
    Result := Trim(  FormatFloat( '### ### ### ### ### ### ##0', days )  ) + ' [' + Translation.translation__messages_r.word__time__shortcut__days + '] ' + Result;

end;

procedure TSDBM.Operation__Begin_Date_Time__Set();
begin

  if Self.operation_duration__calculating_type in [ odct_multi_command__initialization, odct_single_command ] then
    Self.operation__begin_date_time := Now();


  if Self.operation_duration__calculating_type in [ odct_multi_command__initialization ] then
    Self.operation_duration__calculating_type := odct_multi_command;

end;

procedure TSDBM.Operation_Duration__Calculating_Type__Set( const operation_duration__calculating_type_f : TOperation_Duration_Calculating_Type );
begin

  if operation_duration__calculating_type_f in [ odct_multi_command ] then
    Self.operation_duration__calculating_type := odct_multi_command__initialization
  else
    Self.operation_duration__calculating_type := operation_duration__calculating_type_f;

end;

function TSDBM.Operation_Duration_Get() : string;
begin

  Result := Self.Duration_To_String( Self.operation__end_date_time, Self.operation__begin_date_time );

end;

procedure TSDBM.Queries__Manage( const do_create_f : boolean );
begin

  if do_create_f then
    begin

      if    ( Self.component_type__sdbm = ct_ADO )
        and ( Self.ado_query__manage )
        and ( Self.ado_query__sdbm = nil ) then
        begin

          Self.ado_query__sdbm := TADOQuery.Create( nil );
          Self.ado_query__sdbm.Connection := Self.ado_connection__sdbm;

        end;


      if    ( Self.component_type__sdbm = ct_FireDAC )
        and ( Self.fd_query__manage )
        and ( Self.fd_query__sdbm = nil ) then
        begin

          Self.fd_query__sdbm := TFDQuery.Create( nil );
          Self.fd_query__sdbm.Connection := Self.fd_connection__sdbm;

        end;

    end
  else
    begin

      if    ( Self.ado_query__manage )
        and ( Self.ado_query__sdbm <> nil ) then
        begin

          if Self.ado_query__sdbm.Active then
            Self.ado_query__sdbm.Close();


          System.SysUtils.FreeAndNil( Self.ado_query__sdbm );

        end;


      if    ( Self.fd_query__manage )
        and ( Self.fd_query__sdbm <> nil ) then
        begin

          if Self.fd_query__sdbm.Active then
            Self.fd_query__sdbm.Close();


          System.SysUtils.FreeAndNil( Self.fd_query__sdbm );

        end;

    end;

end;

procedure TSDBM.Queries__Recreate();
begin

  Self.Queries__Manage( false );
  Self.Queries__Manage( true );

end;

function TSDBM.Query__Active() : boolean;
begin

  Result := false;


  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Result := Self.ado_query__sdbm.Active
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Result := Self.fd_query__sdbm.Active;

end;

function TSDBM.Query__Bof() : boolean;
begin

  Result := true;


  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Result := Self.ado_query__sdbm.Bof
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Result := Self.fd_query__sdbm.Bof;

end;

procedure TSDBM.Query__Close();
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Self.ado_query__sdbm.Close()
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.Close();

end;

procedure TSDBM.Query__Disable_Controls();
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Self.ado_query__sdbm.DisableControls()
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.DisableControls();

end;

procedure TSDBM.Query__Display_Format( const field_name_f, display_format_f : string );
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    TFloatField(ado_query__sdbm.FieldByName( field_name_f )).DisplayFormat := display_format_f
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    TFloatField(fd_query__sdbm.FieldByName( field_name_f )).DisplayFormat := display_format_f;

end;

procedure TSDBM.Query__Delete();
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Self.ado_query__sdbm.Delete()
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.Delete();

end;

procedure TSDBM.Query__Enable_Controls();
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Self.ado_query__sdbm.EnableControls()
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.EnableControls();

end;

function TSDBM.Query__Eof() : boolean;
begin

  Result := true;


  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Result := Self.ado_query__sdbm.Eof
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Result := Self.fd_query__sdbm.Eof;

end;

procedure TSDBM.Query__Fetch_Options__Mode( const mode_f : TFDFetchMode );
begin

  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.FetchOptions.Mode := mode_f;

end;

procedure TSDBM.Query__Fetch_Options__Record_Count_Mode( const record_count_mode_f : TFDRecordCountMode );
begin

  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.FetchOptions.RecordCountMode := record_count_mode_f;

end;

procedure TSDBM.Query__Fetch_Options__Rowset_Size( const rowset_size_f : integer );
begin

  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.FetchOptions.RowsetSize := rowset_size_f;

end;

function TSDBM.Query__Field_By_Name( const field_name_f : string ) : TField;
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Result := Self.ado_query__sdbm.FieldByName( field_name_f )
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Result := Self.fd_query__sdbm.FieldByName( field_name_f );

end;

function TSDBM.Query__Field_Count() : integer;
begin

  Result := -1;


  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Result := Self.ado_query__sdbm.FieldCount
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Result := Self.fd_query__sdbm.FieldCount;

end;

function TSDBM.Query__Fields( const field_number_f : integer ) : TField;
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Result := Self.ado_query__sdbm.Fields[ field_number_f ]
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Result := Self.fd_query__sdbm.Fields[ field_number_f ];

end;

procedure TSDBM.Query__First();
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Self.ado_query__sdbm.First()
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.First();

end;

procedure TSDBM.Query__Insert();
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Self.ado_query__sdbm.Insert()
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.Insert();

end;

procedure TSDBM.Query__Last();
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Self.ado_query__sdbm.Last()
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.Last();

end;

function TSDBM.Query__Locate(const key_fields_f: string; const key_values_f: Variant; options_f: Data.DB.TLocateOptions): boolean;
begin

  Result := false;


  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Result := Self.ado_query__sdbm.Locate( key_fields_f, key_values_f, options_f )  // Do not work well for texts without 'loCaseInsensitive' option.
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Result := Self.fd_query__sdbm.Locate( key_fields_f, key_values_f, options_f );

end;

procedure TSDBM.Query__Next();
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Self.ado_query__sdbm.Next()
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.Next();

end;

procedure TSDBM.Query__Open();
begin

  Self.Operation__Begin_Date_Time__Set();


  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Self.ado_query__sdbm.Open()
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.Open();


  Self.operation__end_date_time := Now();

end;

function TSDBM.Query__Param_By_Index__Name__Get( const parameter_number_f : integer ) : string;
begin

  Result := '';


  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Result := Self.ado_query__sdbm.Parameters.Items[ parameter_number_f ].Name
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Result := Self.fd_query__sdbm.Params.Items[ parameter_number_f ].Name;

end;

function TSDBM.Query__Param_By_Index__Value__Get( const parameter_number_f : integer ) : variant;
begin

  Result := System.Variants.Unassigned();


  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Result := Self.ado_query__sdbm.Parameters.Items[ parameter_number_f ].Value
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Result := Self.fd_query__sdbm.Params.Items[ parameter_number_f ].Value;

end;

procedure TSDBM.Query__Param_By_Index__Set( const index_f : integer; const value_f : variant; log_memo_f : TMemo = nil );
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    begin

      if    ( index_f >= 0 )
        and ( Self.ado_query__sdbm.Parameters.Count > index_f ) then
        try
          Self.ado_query__sdbm.Parameters.Items[ index_f ].Value := value_f;
        except
          on E : Exception do
            begin

              if log_memo_f <> nil then
                log_memo_f.Lines.Add(  StringReplace( E.Message, #10, #13 + #10, [ rfReplaceAll ] )  );

              Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_set_query_parameter + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );

            end;
        end;

    end
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil )
    and ( index_f >= 0 )
    and ( Self.fd_query__sdbm.Params.Count > index_f ) then
      try
        Self.fd_query__sdbm.Params.Items[ index_f ].Value := value_f;
      except
        on E : Exception do
          begin

            if log_memo_f <> nil then
              log_memo_f.Lines.Add(  StringReplace( E.Message, #10, #13 + #10, [ rfReplaceAll ] )  );

            Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_set_query_parameter + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );

          end;
      end;

end;

procedure TSDBM.Query__Param_By_Name__Set( const name_f : string; const value_f : variant; log_memo_f : TMemo = nil );
var
  i : integer;
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    begin

      for i := 0 to Self.ado_query__sdbm.Parameters.Count - 1 do
        if Self.ado_query__sdbm.Parameters.Items[ i ].Name = name_f then
          try
            Self.ado_query__sdbm.Parameters.Items[ i ].Value := value_f;
          except
            on E : Exception do
              begin

                if log_memo_f <> nil then
                  log_memo_f.Lines.Add(  StringReplace( E.Message, #10, #13 + #10, [ rfReplaceAll ] )  );

                Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_set_query_parameter + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );

              end;
          end;

    end
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    for i := 0 to Self.fd_query__sdbm.Params.Count - 1 do
      if AnsiLowerCase( Self.fd_query__sdbm.Params.Items[ i ].Name ) = AnsiLowerCase( name_f ) then
        try
          Self.fd_query__sdbm.Params.Items[ i ].Value := value_f;
        except
          on E : Exception do
            begin

              if log_memo_f <> nil then
                log_memo_f.Lines.Add(  StringReplace( E.Message, #10, #13 + #10, [ rfReplaceAll ] )  );

              Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_set_query_parameter + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );

            end;
        end;

end;

function TSDBM.Query__Parameters_Count() : integer;
begin

  Result := -1;


  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Result := Self.ado_query__sdbm.Parameters.Count
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Result := Self.fd_query__sdbm.ParamCount;

end;

procedure TSDBM.Query__Prior();
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Self.ado_query__sdbm.Prior()
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.Prior();

end;

function TSDBM.Query__Record_Count() : integer;
begin

  Result := -1;


  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Result := Self.ado_query__sdbm.RecordCount
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Result := Self.fd_query__sdbm.RecordCount;

end;

function TSDBM.Query__Record_Number() : integer;
begin

  Result := -1;


  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Result := Self.ado_query__sdbm.RecNo
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Result := Self.fd_query__sdbm.RecNo;

end;

procedure TSDBM.Query__Record_Number__Set( const query_record_number_copy_f : integer );
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Self.ado_query__sdbm.RecNo := query_record_number_copy_f
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.RecNo := query_record_number_copy_f;

end;

procedure TSDBM.Query__Requery();
begin

  Self.Operation__Begin_Date_Time__Set();


  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Self.ado_query__sdbm.Requery()
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.Refresh();


  Self.operation__end_date_time := Now();

end;

procedure TSDBM.Query__Sort( sort_string_f : string );
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    begin

      sort_string_f := StringReplace( sort_string_f, query__sort__ascending_c, ' ASC', [ rfReplaceAll ] );
      sort_string_f := StringReplace( sort_string_f, query__sort__descending_c, ' DESC', [ rfReplaceAll ] );

      Self.ado_query__sdbm.Sort := sort_string_f; // 'C1 ASC' 'C2 DESC'

    end
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    begin

      sort_string_f := StringReplace( sort_string_f, query__sort__ascending_c, ':A', [ rfReplaceAll ] );
      sort_string_f := StringReplace( sort_string_f, query__sort__descending_c, ':D', [ rfReplaceAll ] );

      Self.fd_query__sdbm.IndexFieldNames := sort_string_f; // 'C1:A' 'C1:D'

    end;

end;

function TSDBM.Query__Sql__Get() : string;
begin

  Result := '';


  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Result := Self.ado_query__sdbm.SQL.Text
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Result := Self.fd_query__sdbm.SQL.Text;

end;

procedure TSDBM.Query__Sql__Set( const sql_f : string );
begin

  if    ( Self.component_type__sdbm = ct_ADO )
    and ( Self.ado_query__sdbm <> nil ) then
    Self.ado_query__sdbm.SQL.Text := sql_f
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_query__sdbm <> nil ) then
    Self.fd_query__sdbm.SQL.Text := sql_f;

end;

function TSDBM.Sql_Command_Execute( const sql_f : string; error_message_f : string = '' ) : boolean;
var
  error_message_l : string;
  parameters_t : array of string;
begin

  //Result := Sql_Command_Execute( sql_f, [], error_message_f );
  Result := Sql_Command_Execute( sql_f, parameters_t, error_message_l, error_message_f );

end;

function TSDBM.Sql_Command_Execute( const sql_f : string; out error_message_out_f : string; error_message_f : string = ''; const ado_command_param_check_f : boolean = true ) : boolean;
var
  parameters_t : array of string;
begin

  //Result := Sql_Command_Execute( sql_f, [], error_message_f );
  Result := Sql_Command_Execute( sql_f, parameters_t, error_message_out_f, error_message_f, ado_command_param_check_f );

end;

function TSDBM.Sql_Command_Execute( const sql_f : string; const parameters_t_f : array of string; out error_message_out_f : string; error_message_f : string = ''; const ado_command_param_check_f : boolean = true ) : boolean;
var
  i,
  j
    : integer;

  ado_command_l : TADOCommand;

  fd_command_l : TFDCommand;
begin

  // parameters_t_f : [ parameter 1 name, parameter 1 value, parameter 2 name, parameter 2 value ].


  Result := false; // Result is true if no errors occurred.

  error_message_out_f := '';


  if Trim( error_message_f ) <> '' then
    error_message_f := error_message_f + #13 + #13;


  if Self.component_type__sdbm = ct_ADO then
    begin

      ado_command_l := TADOCommand.Create( Application );
      ado_command_l.Connection := Self.ado_connection__sdbm;
      ado_command_l.ParamCheck := ado_command_param_check_f; // Otherwise do not work command 'recreate procedure' (false).
      ado_command_l.CommandText := sql_f;


      i := 0;

      while i <= Length( parameters_t_f ) - 2 do
        begin

          for j := 0 to ado_command_l.Parameters.Count - 1 do
            if ado_command_l.Parameters.Items[ j ].Name = parameters_t_f[ i ] then
              ado_command_l.Parameters.Items[ j ].Value := parameters_t_f[ i + 1 ];

          i := i + 2;

        end;

    end
  else
    begin

      fd_command_l := TFDCommand.Create( Application );
      fd_command_l.Connection := Self.fd_connection__sdbm;
      fd_command_l.CommandText.Text := sql_f;


      i := 0;

      while i <= Length( parameters_t_f ) - 2 do
        begin

          for j := 0 to fd_command_l.Params.Count - 1 do
            if fd_command_l.Params.Items[ j ].Name = parameters_t_f[ i ] then
              fd_command_l.Params.Items[ j ].Value := parameters_t_f[ i + 1 ];

          i := i + 2;

        end;

    end;


  try

    Self.Operation__Begin_Date_Time__Set();


    if Self.component_type__sdbm = ct_ADO then
      ado_command_l.Execute()
    else
    if Self.component_type__sdbm = ct_FireDAC then
      fd_command_l.Execute();


    Self.operation__end_date_time := Now();


    if Self.component_type__sdbm in [ ct_ADO, ct_FireDAC ] then
      Result := true;

  except
    on E : Exception do
      begin

        error_message_out_f := E.Message;

        Application.MessageBox( PChar(error_message_f + E.Message + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONSTOP );

      end;
  end;


  if Self.component_type__sdbm = ct_ADO then
    begin

      System.SysUtils.FreeAndNil( ado_command_l );

    end
  else
    begin

      System.SysUtils.FreeAndNil( fd_command_l );

    end;

end;

function TSDBM.Sql_Command_Execute( const sql_f : string; const parameters_t_f : array of const; out error_message_out_f : string; error_message_f : string = ''; const ado_command_param_check_f : boolean = true ) : boolean;
var
  i,
  j
    : integer;

  ado_command_l : TADOCommand;

  fd_command_l : TFDCommand;
begin

  // Unused.

  // parameters_t_f : [ parameter 1 name, parameter 1 value, parameter 2 name, parameter 2 value ].


  Result := false; // Result is true if no errors occurred.

  error_message_out_f := '';


  if Trim( error_message_f ) <> '' then
    error_message_f := error_message_f + #13 + #13;


  if Self.component_type__sdbm = ct_ADO then
    begin

      ado_command_l := TADOCommand.Create( Application );
      ado_command_l.Connection := Self.ado_connection__sdbm;
      ado_command_l.ParamCheck := ado_command_param_check_f; // Otherwise do not work command 'recreate procedure' (false).
      ado_command_l.CommandText := sql_f;


      i := 0;

      while i <= Length( parameters_t_f ) - 2 do
        begin

          if parameters_t_f[ i ].VType in [ vtInteger{//???}, vtString, vtUnicodeString ] then
            for j := 0 to ado_command_l.Parameters.Count - 1 do
              if ado_command_l.Parameters.Items[ j ].Name = string(parameters_t_f[ i ].VString) then
                if parameters_t_f[ i + 1 ].VType = vtBoolean then
                  ado_command_l.Parameters.Items[ j ].Value := parameters_t_f[ i + 1 ].VBoolean
                else
                if parameters_t_f[ i + 1 ].VType = vtCurrency then
                  {$IFDEF WIN32}
                  ado_command_l.Parameters.Items[ j ].Value := parameters_t_f[ i + 1 ].VCurrency^
                  {$ELSE WIN32}
                  ado_command_l.Parameters.Items[ j ].Value := currency(parameters_t_f[ i + 1 ].VCurrency)
                  {$ENDIF}
                else
                if parameters_t_f[ i + 1 ].VType = vtInteger then
                  ado_command_l.Parameters.Items[ j ].Value := parameters_t_f[ i + 1 ].VInteger
                else
                if parameters_t_f[ i + 1 ].VType = vtInt64 then
                  ado_command_l.Parameters.Items[ j ].Value := Int64(parameters_t_f[ i + 1 ].VInt64)
                else
                if parameters_t_f[ i + 1 ].VType = vtExtended then
                  {$IFDEF WIN32}
                  ado_command_l.Parameters.Items[ j ].Value := parameters_t_f[ i + 1 ].VExtended^
                  {$ELSE WIN32}
                  ado_command_l.Parameters.Items[ j ].Value := Extended(parameters_t_f[ i + 1 ].VExtended)
                  {$ENDIF}
                else
                if parameters_t_f[ i + 1 ].VType = vtVariant then
                  ado_command_l.Parameters.Items[ j ].Value := parameters_t_f[ i + 1 ].VVariant^
                else
                  ado_command_l.Parameters.Items[ j ].Value := string(parameters_t_f[ i + 1 ].VString);

          i := i + 2;

        end;

    end
  else
    begin

      fd_command_l := TFDCommand.Create( Application );
      fd_command_l.Connection := Self.fd_connection__sdbm;
      fd_command_l.CommandText.Text := sql_f;


      i := 0;

      while i <= Length( parameters_t_f ) - 2 do
        begin

          if parameters_t_f[ i ].VType in [ vtString, vtUnicodeString ] then
            for j := 0 to fd_command_l.Params.Count - 1 do
              if fd_command_l.Params.Items[ j ].Name = string(parameters_t_f[ i ].VString) then
                if parameters_t_f[ i + 1 ].VType = vtBoolean then
                  fd_command_l.Params.Items[ j ].Value := parameters_t_f[ i + 1 ].VBoolean
                else
                if parameters_t_f[ i + 1 ].VType = vtCurrency then
                  {$IFDEF WIN32}
                  fd_command_l.Params.Items[ j ].Value := parameters_t_f[ i + 1 ].VCurrency^
                  {$ELSE WIN32}
                  fd_command_l.Params.Items[ j ].Value := currency(parameters_t_f[ i + 1 ].VCurrency)
                  {$ENDIF}
                else
                if parameters_t_f[ i + 1 ].VType = vtInteger then
                  fd_command_l.Params.Items[ j ].Value := parameters_t_f[ i + 1 ].VInteger
                else
                if parameters_t_f[ i + 1 ].VType = vtInt64 then
                  fd_command_l.Params.Items[ j ].Value := Int64(parameters_t_f[ i + 1 ].VInt64)
                else
                if parameters_t_f[ i + 1 ].VType = vtExtended then
                  {$IFDEF WIN32}
                  fd_command_l.Params.Items[ j ].Value := parameters_t_f[ i + 1 ].VExtended^
                  {$ELSE WIN32}
                  fd_command_l.Params.Items[ j ].Value := Extended(parameters_t_f[ i + 1 ].VExtended)
                  {$ENDIF}
                else
                if parameters_t_f[ i + 1 ].VType = vtVariant then
                  fd_command_l.Params.Items[ j ].Value := parameters_t_f[ i + 1 ].VVariant^
                else
                  fd_command_l.Params.Items[ j ].Value := string(parameters_t_f[ i + 1 ].VString);

          i := i + 2;

        end;

    end;


  try

    Self.Operation__Begin_Date_Time__Set();


    if Self.component_type__sdbm = ct_ADO then
      ado_command_l.Execute()
    else
    if Self.component_type__sdbm = ct_FireDAC then
      fd_command_l.Execute();


    Self.operation__end_date_time := Now();


    if Self.component_type__sdbm in [ ct_ADO, ct_FireDAC ] then
      Result := true;

  except
    on E : Exception do
      begin

        error_message_out_f := E.Message;

        Application.MessageBox( PChar(error_message_f + E.Message + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONSTOP );

      end;
  end;


  if Self.component_type__sdbm = ct_ADO then
    begin

      System.SysUtils.FreeAndNil( ado_command_l );

    end
  else
    begin

      System.SysUtils.FreeAndNil( fd_command_l );

    end;

end;

procedure TSDBM.Transaction__Begin();
begin

  Self.Operation__Begin_Date_Time__Set();


  if Self.component_type__sdbm = ct_ADO then
    Self.ado_connection__sdbm.BeginTrans()
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_connection__sdbm.Transaction <> nil ) then
    Self.fd_connection__sdbm.Transaction.StartTransaction();


  Self.operation__end_date_time := Now();

end;

procedure TSDBM.Transaction__Commit();
begin

  Self.Operation__Begin_Date_Time__Set();


  if Self.component_type__sdbm = ct_ADO then
    Self.ado_connection__sdbm.CommitTrans()
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_connection__sdbm.Transaction <> nil ) then
    Self.fd_connection__sdbm.Transaction.Commit();


  Self.operation__end_date_time := Now();

end;

function TSDBM.Transaction__In() : boolean;
begin

  Result := false;


  if Self.component_type__sdbm = ct_ADO then
    Result := Self.ado_connection__sdbm.InTransaction
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_connection__sdbm.Transaction <> nil ) then
    Result := Self.fd_connection__sdbm.Transaction.Active;

end;

procedure TSDBM.Transaction__Rollback();
begin

  Self.Operation__Begin_Date_Time__Set();


  if Self.component_type__sdbm = ct_ADO then
    Self.ado_connection__sdbm.RollbackTrans()
  else
  if    ( Self.component_type__sdbm = ct_FireDAC )
    and ( Self.fd_connection__sdbm.Transaction <> nil ) then
    Self.fd_connection__sdbm.Transaction.Rollback();


  Self.operation__end_date_time := Now();

end;

constructor TSql_Parameter.Create( parent_f : Vcl.Controls.TWinControl; const caption_f : string; key_down_wsk_f : TKey_Down_wsk );
begin

  inherited Create( parent_f );

  Self.parameter_name := caption_f;
  Self.Parameter_Number_Set( -1 );

  Self.Parent := parent_f;
  Self.Align := alBottom;
  Self.Align := alTop;
  Self.Caption := Self.parameter_name;
  Self.Height := 40;
  Self.Hint :=
    Translation.translation__table__data_filter_r.sql_parameter_1 + ' ''' + Self.parameter_name + '''.' + #13 + #13 +
    Translation.translation__table__data_filter_r.sql_parameter_2;
  Self.ShowHint := true;


  Self.value_edit := TEdit.Create( Application );
  Self.value_edit.Parent := Self;
  Self.value_edit.Align := alClient;
  Self.value_edit.OnKeyDown := key_down_wsk_f;

end;

destructor TSql_Parameter.Destroy();
begin

  System.SysUtils.FreeAndNil( Self.value_edit );


  inherited;

end;

function TSql_Parameter.Parameter_Name_Get() : string;
begin

  Result := Self.parameter_name;

end;

function TSql_Parameter.Parameter_Number_Get() : integer;
begin

  Result := Self.parameter_number;

end;

procedure TSql_Parameter.Parameter_Number_Set( const parameter_number_f : integer );
begin

  Self.parameter_number := parameter_number_f;

end;

procedure TSql_Parameter.Parameter_SetFocus();
begin

  if Self.value_edit <> nil then
    Self.value_edit.SetFocus();

end;

function TSql_Parameter.Parameter_Value_Get() : string;
begin

  if Self.value_edit <> nil then
    Result := Self.value_edit.Text;

end;

procedure TSql_Parameter.Parameter_Value_Set( const value_f : string );
begin

  if Self.value_edit <> nil then
    Self.value_edit.Text := value_f;

end;

function Case_Insensitive_To_String( const value_f : string; const case_insensitive_f : boolean ) : string;
begin

  if not case_insensitive_f then
    Result := value_f
  else
    Result := AnsiLowerCase( value_f );

end;

function Column__Name_To_Grid_Caption( const column_name_f : string ) : string;
begin

  if AnsiUpperCase( column_name_f ) = 'DEFAULT_VALUE' then
    begin

      Result := Translation.translation__messages_r.word__default__value;
      Exit;

    end
  else
  if AnsiUpperCase( column_name_f ) = 'DESCRIPTION_VALUE' then
    begin

      Result := Translation.translation__messages_r.word__description;
      Exit;

    end
  else
  if AnsiUpperCase( column_name_f ) = 'FIELD_TYPE' then
    begin

      Result := Translation.translation__messages_r.word__type;
      Exit;

    end
  else
  if AnsiUpperCase( column_name_f ) = 'OWNER_NAME' then
    begin

      Result := Translation.translation__messages_r.word__owner_name;
      Exit;

    end
  else
  if AnsiUpperCase( column_name_f ) = 'PARAMETER_NUMBER' then
    begin

      Result := Translation.translation__messages_r.word__parameter__number;
      Exit;

    end
  else
  if AnsiUpperCase( column_name_f ) = 'PRIVILEGE' then
    begin

      Result := Translation.translation__messages_r.word__privilege;
      Exit;

    end
  else
  if AnsiUpperCase( column_name_f ) = 'TRIGGER_SEQUENCE' then
    begin

      Result := Translation.translation__messages_r.word__trigger_sequence;
      Exit;

    end
  else
  if AnsiUpperCase( column_name_f ) = 'TRIGGER_TYPE' then
    begin

      Result := Translation.translation__messages_r.word__trigger_type;
      Exit;

    end;


  Result := Trim(  StringReplace( column_name_f, '_', ' ', [ rfReplaceAll ] )  );
  Result := AnsiLowerCase( Result );

  if Length( Result ) > 0 then
    Result[ 1 ] := AnsiUpperCase( Result )[ 1 ];

end;

function Column__Values__Distinct__Processing( sdbm_f : TSDBM; db_grid_f : Vcl.DBGrids.TDBGrid; var items_count_f : integer; progress_bar_f : Vcl.ComCtrls.TProgressBar = nil; progres_show_f : boolean = false ) : string;
var
  was_null_l : boolean;

  zti,
  progress_bar_step_distance_l,
  query_record_number_copy_l
    : integer;

  zt_string_list : TStringList;
begin

  // Nested functions not allowed in threads.

  Result := '';
  items_count_f := -1;
  was_null_l := false;


  if   ( sdbm_f = nil )
    or ( not sdbm_f.Query__Active() ) then
    Exit;


  sdbm_f.Query__Disable_Controls(); // Do not work well here.
  db_grid_f.Enabled := false;

  query_record_number_copy_l := sdbm_f.Query__Record_Number();


  if    ( progres_show_f )
    and ( progress_bar_f = nil ) then
    progres_show_f := false;


  if sdbm_f.component_type__sdbm = Common.TComponent_Type.ct_FireDAC then
    begin

      // FireDAC may not give total record count.

      sdbm_f.Query__Last();

    end;


  sdbm_f.Query__First();


  zt_string_list := TStringList.Create();


  if progres_show_f then
    begin

      if sdbm_f.Query__Record_Count() <= 99 then
        progress_bar_step_distance_l := 1
      else
      if sdbm_f.Query__Record_Count() <= 999 then
        progress_bar_step_distance_l := 10
      else
      if sdbm_f.Query__Record_Count() <= 9999 then
        progress_bar_step_distance_l := 100
      else
        progress_bar_step_distance_l := 1000;


      progress_bar_f.Position := 0; // May case the application to freeze.
      progress_bar_f.Max := sdbm_f.Query__Record_Count();
      progress_bar_f.Step := progress_bar_step_distance_l;
      progress_bar_f.Visible := true;

    end;


  while not sdbm_f.Query__Eof() do
    begin

      if    ( not was_null_l )
        and ( sdbm_f.Query__Field_By_Name( db_grid_f.SelectedField.FieldName ).IsNull ) then
        begin

          was_null_l := true;

          zt_string_list.Add( Common.notification__sign__null_c );
          zt_string_list.Sort();

        end
      else
      if    ( not sdbm_f.Query__Field_By_Name( db_grid_f.SelectedField.FieldName ).IsNull )
        and (  not zt_string_list.Find( sdbm_f.Query__Field_By_Name( db_grid_f.SelectedField.FieldName ).AsString, zti )  ) then
        begin

          zt_string_list.Add( sdbm_f.Query__Field_By_Name( db_grid_f.SelectedField.FieldName ).AsString );
          zt_string_list.Sort();

        end;


      if    ( progres_show_f )
        and ( sdbm_f.Query__Record_Number() mod progress_bar_step_distance_l = 0 ) then
        begin

          progress_bar_f.StepIt();


          if progress_bar_f.Visible then
            Application.ProcessMessages();

        end;


      sdbm_f.Query__Next();

    end;


  Result := zt_string_list.Text;
  items_count_f := zt_string_list.Count;


  zt_string_list.Clear();
  System.SysUtils.FreeAndNil( zt_string_list );


  sdbm_f.Query__Record_Number__Set( query_record_number_copy_l );


  db_grid_f.Enabled := true;
  sdbm_f.Query__Enable_Controls();


  if progres_show_f then
    begin

      progress_bar_f.Position := progress_bar_f.Max;


      if progress_bar_f.Visible then
        progress_bar_f.Visible := false;

    end;

end;

function Column__Values__Sum__Processing( sdbm_f : TSDBM; db_grid_f : Vcl.DBGrids.TDBGrid; var error_message_f : string; progress_bar_f : Vcl.ComCtrls.TProgressBar = nil; progres_show_f : boolean = false ) : currency;
var
  progress_bar_step_distance_l,
  query_record_number_copy_l
    : integer;
begin

  // Nested functions not allowed in threads.

  Result := 0;
  error_message_f := '';


  if   ( sdbm_f = nil )
    or ( not sdbm_f.Query__Active() ) then
    Exit;


  sdbm_f.Query__Disable_Controls(); // Do not work well here.
  db_grid_f.Enabled := false;

  query_record_number_copy_l := sdbm_f.Query__Record_Number();


  if    ( progres_show_f )
    and ( progress_bar_f = nil ) then
    progres_show_f := false;


  if sdbm_f.component_type__sdbm = TComponent_Type.ct_FireDAC then
    begin

      // FireDAC may not give total record count.

      sdbm_f.Query__Last();

    end;


  sdbm_f.Query__First();


  if progres_show_f then
    begin

      if sdbm_f.Query__Record_Count() <= 99 then
        progress_bar_step_distance_l := 1
      else
      if sdbm_f.Query__Record_Count() <= 999 then
        progress_bar_step_distance_l := 10
      else
      if sdbm_f.Query__Record_Count() <= 9999 then
        progress_bar_step_distance_l := 100
      else
        progress_bar_step_distance_l := 1000;


      progress_bar_f.Position := 0; // May case the application to freeze.
      progress_bar_f.Max := sdbm_f.Query__Record_Count();
      progress_bar_f.Step := progress_bar_step_distance_l;
      progress_bar_f.Visible := true;

    end;


  while not sdbm_f.Query__Eof() do
    begin

      try
        Result := Result + sdbm_f.Query__Field_By_Name( db_grid_f.SelectedField.FieldName ).AsCurrency;
      except
        on E : Exception do
          begin

            if    ( progres_show_f )
              and ( not progress_bar_f.Visible ) then
              progress_bar_f.Visible := true;


            if Pos( E.Message, error_message_f ) <= 0 then
              error_message_f := error_message_f + #13 + E.Message;

          end;
      end;


      if    ( progres_show_f )
        and ( sdbm_f.Query__Record_Number() mod progress_bar_step_distance_l = 0 ) then
        begin

          progress_bar_f.StepIt();


          if progress_bar_f.Visible then
            Application.ProcessMessages();

        end;


      sdbm_f.Query__Next();

    end;


  sdbm_f.Query__Record_Number__Set( query_record_number_copy_l );


  db_grid_f.Enabled := true;
  sdbm_f.Query__Enable_Controls();


  if progres_show_f then
    begin

      progress_bar_f.Position := progress_bar_f.Max;


      if progress_bar_f.Visible then
        progress_bar_f.Visible := false;

    end;

end;

procedure Comment__Uncomment_Line( syn_edit_f : TSynEdit; const go_up_f : boolean = false );
var
  block__comment_l : boolean;

  line__number_l,
  line__number__start_l,
  line__number__end_l
    : integer;

  zt_buffer_coord : SynEditTypes.TBufferCoord;
begin

  if syn_edit_f = nil then
    Exit;


  block__comment_l := false;


  if    ( syn_edit_f.Lines.Count > 0 )
    and ( syn_edit_f.SelStart < syn_edit_f.SelEnd ) then
    begin

      zt_buffer_coord := syn_edit_f.CharIndexToRowCol( syn_edit_f.SelStart );

      line__number__start_l := zt_buffer_coord.Line - 1;


      zt_buffer_coord := syn_edit_f.CharIndexToRowCol( syn_edit_f.SelEnd );

      line__number__end_l := zt_buffer_coord.Line - 1;


      line__number_l := line__number__end_l - line__number__start_l;

      if line__number_l > 0 then
        block__comment_l := true;

    end;


  if not block__comment_l then
    begin

      // Line comment.

      //line__number_l := memo_f.CaretPos.Y;
      line__number_l := syn_edit_f.CaretY - 1;


      if   ( syn_edit_f.Lines.Count < 0 )
        or ( syn_edit_f.Lines.Count < line__number_l )
        or ( line__number_l < 0 ) then
        //or (  Trim( syn_edit_f.Lines[ line__number_l ] ) = ''  ) then
        Exit;


      if Pos(  Common.sql__comment__begin, Trim( syn_edit_f.Lines[ line__number_l ] )  ) = 1 then
        begin

          // Uncomment.

          syn_edit_f.Lines[ line__number_l ] := StringReplace( syn_edit_f.Lines[ line__number_l ], Common.sql__comment__begin, '', [] );
          syn_edit_f.Lines[ line__number_l ] := StringReplace( syn_edit_f.Lines[ line__number_l ], Common.sql__comment__end, '', [] );

        end
      else
        begin

          // Comment.

          syn_edit_f.Lines[ line__number_l ] :=
            Common.sql__comment__begin +
            syn_edit_f.Lines[ line__number_l ] +
            Common.sql__comment__end;

        end;


      if not go_up_f then
        begin

          // Go to the next line.

          //if line__number_l < memo_f.Lines.Count then
          //  memo_f.CaretPos := Point( 0,  memo_f.CaretPos.Y + 1 );
          if line__number_l < syn_edit_f.Lines.Count - 1 then
            syn_edit_f.CaretY := syn_edit_f.CaretY + 1;

        end
      else
        begin

          // Go to the previous line.

          //if line__number_l > 0 then
          //  memo_f.CaretPos := Point( 0,  memo_f.CaretPos.Y - 1 );
          if line__number_l > 0 then
            syn_edit_f.CaretY := syn_edit_f.CaretY - 1;

        end;

    end
  else
    begin

      // Block comment.

      if Pos(  Common.sql__comment__begin, Trim( syn_edit_f.Lines[ line__number__start_l ] )  ) = 1 then
        begin

          // Uncomment.

          syn_edit_f.Lines[ line__number__start_l ] := StringReplace( syn_edit_f.Lines[ line__number__start_l ], Common.sql__comment__begin, '', [] );
          syn_edit_f.Lines[ line__number__end_l ] := StringReplace( syn_edit_f.Lines[ line__number__end_l ], Common.sql__comment__end, '', [] );

        end
      else
        begin

          // Comment.

          syn_edit_f.Lines[ line__number__start_l ] :=
            Common.sql__comment__begin +
            syn_edit_f.Lines[ line__number__start_l ];

          syn_edit_f.Lines[ line__number__end_l ] :=
            syn_edit_f.Lines[ line__number__end_l ] +
            Common.sql__comment__end;

        end;

    end;

end;

procedure Comment__Uncomment_Line__Slash( syn_edit_f : TSynEdit; const go_up__or__invert_f : boolean = false );

  function Apply_Comment( text_f : string; const do__comment_f : boolean ) : string;
  begin

    if do__comment_f then
      Result := // Comment.
        Common.sql__comment__line +
        text_f
    else
      Result := StringReplace( text_f, Common.sql__comment__line, '', [] ); // Uncomment.

  end;

var
  block__comment_l,
  do__uncomment_l
    : boolean;

  line__number_l,
  line__number__start_l,
  line__number__end_l
    : integer;

  zt_buffer_coord : SynEditTypes.TBufferCoord;
begin

  if syn_edit_f = nil then
    Exit;


  block__comment_l := false;


  if    ( syn_edit_f.Lines.Count > 0 )
    and ( syn_edit_f.SelStart < syn_edit_f.SelEnd ) then
    begin

      zt_buffer_coord := syn_edit_f.CharIndexToRowCol( syn_edit_f.SelStart );

      line__number__start_l := zt_buffer_coord.Line - 1;


      zt_buffer_coord := syn_edit_f.CharIndexToRowCol( syn_edit_f.SelEnd );

      line__number__end_l := zt_buffer_coord.Line - 1;


      line__number_l := line__number__end_l - line__number__start_l;

      if line__number_l > 0 then
        block__comment_l := true;

    end;


  if not block__comment_l then
    begin

      // Line comment.

      //line__number_l := memo_f.CaretPos.Y;
      line__number_l := syn_edit_f.CaretY - 1;


      if   ( syn_edit_f.Lines.Count < 0 )
        or ( syn_edit_f.Lines.Count < line__number_l )
        or ( line__number_l < 0 ) then
        //or (  Trim( syn_edit_f.Lines[ line__number_l ] ) = ''  ) then
        Exit;


      if Pos(  Common.sql__comment__line, Trim( syn_edit_f.Lines[ line__number_l ] )  ) = 1 then
        syn_edit_f.Lines[ line__number_l ] := Apply_Comment( syn_edit_f.Lines[ line__number_l ], false ) // Uncomment.
      else
        syn_edit_f.Lines[ line__number_l ] := Apply_Comment( syn_edit_f.Lines[ line__number_l ], true ); // Comment.


      if not go_up__or__invert_f then
        begin

          // Go to the next line.

          //if line__number_l < memo_f.Lines.Count then
          //  memo_f.CaretPos := Point( 0,  memo_f.CaretPos.Y + 1 );
          if line__number_l < syn_edit_f.Lines.Count - 1 then
            syn_edit_f.CaretY := syn_edit_f.CaretY + 1;

        end
      else
        begin

          // Go to the previous line.

          //if line__number_l > 0 then
          //  memo_f.CaretPos := Point( 0,  memo_f.CaretPos.Y - 1 );
          if line__number_l > 0 then
            syn_edit_f.CaretY := syn_edit_f.CaretY - 1;

        end;

    end
  else
    begin

      // Block comment.

      if not go_up__or__invert_f then
        begin

          // Not invert.

          do__uncomment_l := Pos(  Common.sql__comment__line, Trim( syn_edit_f.Lines[ line__number__start_l ] )  ) = 1;


          for line__number_l := line__number__start_l to line__number__end_l do
            if do__uncomment_l then
              syn_edit_f.Lines[ line__number_l ] := Apply_Comment( syn_edit_f.Lines[ line__number_l ], false ) // Uncomment.
            else
              syn_edit_f.Lines[ line__number_l ] := Apply_Comment( syn_edit_f.Lines[ line__number_l ], true ); // Comment.

        end
      else
        begin

          // Invert.

          for line__number_l := line__number__start_l to line__number__end_l do
            if Pos(  Common.sql__comment__line, Trim( syn_edit_f.Lines[ line__number_l ] )  ) = 1 then
              syn_edit_f.Lines[ line__number_l ] := Apply_Comment( syn_edit_f.Lines[ line__number_l ], false ) // Uncomment.
            else
              syn_edit_f.Lines[ line__number_l ] := Apply_Comment( syn_edit_f.Lines[ line__number_l ], true ); // Comment.

        end;

    end;

end;

procedure Data_Value_Format__Set( sdbm_f : TSDBM; log_memo_f : TMemo; const display_format__disabled_f : boolean = false );

  procedure Format__Set( const field_name_f_f, display_format_f_f : string; log_memo_f_F : TMemo; const display_format__disabled_f_f: boolean );
  begin

    try
      if display_format__disabled_f_f then
        sdbm_f.Query__Display_Format( field_name_f_f, '' )
      else
        sdbm_f.Query__Display_Format( field_name_f_f, display_format_f_f );
    except
      on E : Exception do
        begin

          if log_memo_f <> nil then
            log_memo_f.Lines.Add( Translation.translation__messages_r.failed_to_read_generator_value + #13 + #13 + E.Message + ').' );

        end;
    end;

  end;

var
  i : integer;
begin

  if    ( sdbm_f <> nil )
    and ( sdbm_f.Query__Active() ) then
    for i := 0 to sdbm_f.Query__Field_Count() - 1 do
      if    ( data_presentation__data_value_format__date__use )
        and ( sdbm_f.Query__Fields( i ).DataType in [ ftDate ] ) then
        Format__Set( sdbm_f.Query__Fields( i ).FieldName, data_presentation__data_value_format__date, log_memo_f, display_format__disabled_f )
      else
      if    ( data_presentation__data_value_format__date_time__use )
        and ( sdbm_f.Query__Fields( i ).DataType in [ ftDateTime, ftTimeStamp, ftTimeStampOffset, ftOraTimeStamp ] ) then
        Format__Set( sdbm_f.Query__Fields( i ).FieldName, data_presentation__data_value_format__date_time, log_memo_f, display_format__disabled_f )
      else
      if    ( data_presentation__data_value_format__numbers__use )
        and ( sdbm_f.Query__Fields( i ).DataType in [ ftAutoInc, ftByte, ftBytes, ftInteger, ftLargeint, ftLongWord, ftShortint, ftSmallint, ftWord ] ) then
        Format__Set( sdbm_f.Query__Fields( i ).FieldName, data_presentation__data_value_format__numbers, log_memo_f, display_format__disabled_f )
      else
      if    ( data_presentation__data_value_format__real_numbers__use )
        and ( sdbm_f.Query__Fields( i ).DataType in [ ftBCD, ftCurrency, ftExtended, ftFloat, ftFMTBcd, ftSingle, ftVarBytes ] ) then
        Format__Set( sdbm_f.Query__Fields( i ).FieldName, data_presentation__data_value_format__real_numbers, log_memo_f, display_format__disabled_f )
      else
      if    ( data_presentation__data_value_format__time__use )
        and ( sdbm_f.Query__Fields( i ).DataType in [ ftTime ] ) then
        Format__Set( sdbm_f.Query__Fields( i ).FieldName, data_presentation__data_value_format__time, log_memo_f, display_format__disabled_f );

end;

function Database__Connection__Open( ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const databases_r_f : TDatabases_r; log_memo_f : TMemo; const component_type_f : Common.TComponent_Type = Common.ct_ADO ) : TModalResult;
var
  zti : integer;

  modal_result_l : TModalResult;

  zts_1,
  zts_2,
  user_name_l,
  password_l
    : string;

  database__list_modify_form_l : Database__List_Modify.TDatabase__List_Modify_Form;
begin

  // mrCancel = connection attempt aborted.
  // mrNo = error, not connected.
  // mrYes = connected.


  Result := mrNone;


  if component_type_f = Common.ct_none then
    Exit;


  password_l := databases_r_f.password;
  user_name_l := databases_r_f.user_name;


  if databases_r_f.login_prompt then
    begin

      database__list_modify_form_l := Database__List_Modify.TDatabase__List_Modify_Form.Create( Application );
      database__list_modify_form_l.login_prompt_input := true;
      database__list_modify_form_l.databases_r__lm_g := databases_r_f;

      modal_result_l := database__list_modify_form_l.ShowModal();

      if modal_result_l = mrOk then
        begin

          password_l := database__list_modify_form_l.Password_Edit.Text;
          user_name_l := database__list_modify_form_l.User_Name_Edit.Text;

        end;

      System.SysUtils.FreeAndNil( database__list_modify_form_l );


      if modal_result_l <> mrOk then
        begin

          Result := mrCancel;

          Exit;

        end;

    end;


  Result := mrYes;


  if component_type_f = Common.ct_ADO then
    begin

      ado_connection_f.ConnectionString := databases_r_f.ado__connection_string;

      try
        if databases_r_f.login_prompt then
          ado_connection_f.Open( user_name_l, password_l )
        else
          ado_connection_f.Open();
      except
        on E : Exception do
          begin

            Result := mrNo;

            if log_memo_f <> nil then
              log_memo_f.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_database_connection__ADO_ + #13 + #13 + E.Message + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;

    end
  else
  if component_type_f = Common.ct_FireDAC then
    begin

      fd_connection_f.Params.Clear();
      fd_connection_f.Params.Add( 'DriverID=' + databases_r_f.fire_dac__driver_id );
      fd_connection_f.Params.Add( 'Database=' + databases_r_f.fire_dac__file_path );
      fd_connection_f.Params.Add( 'User_Name=' + user_name_l );
      fd_connection_f.Params.Add( 'Password=' + password_l );

      zts_1 := databases_r_f.fire_dac__parameters;
      zts_1 := StringReplace( zts_1, #13, '', [ rfReplaceAll ] );

      if    (  Length( zts_1 ) > 0  )
        and (  zts_1[ Length( zts_1 ) ] <> #10  ) then
        zts_1 := zts_1 + #10;

      zti := Pos( #10 , zts_1 );

      while zti > 0 do
        begin

          zts_2 := Copy( zts_1, 1, zti - 1 );
          Delete( zts_1, 1, zti );

          if Trim( zts_2 ) <> '' then
            fd_connection_f.Params.Add( zts_2 );

          zti := Pos( #10 , zts_1 );

        end;


      try
        fd_connection_f.Open();
      except
        on E : Exception do
          begin

            Result := mrNo;

            if log_memo_f <> nil then
              log_memo_f.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_database_connection__FireDAC__ + #13 + #13 + E.Message + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;

    end;

end;

procedure Database__Connections__Close( ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection );
begin

  if    ( ado_connection_f <> nil )
    and ( ado_connection_f.Connected ) then
    begin

      while ado_connection_f.InTransaction do
        ado_connection_f.RollbackTrans();

      ado_connection_f.Close();

    end;


  if    ( fd_connection_f <> nil )
    and ( fd_connection_f.Connected ) then
    begin

      if fd_connection_f.Transaction <> nil then
        while fd_connection_f.Transaction.Active do
          fd_connection_f.Transaction.Rollback();

      fd_connection_f.Close();

    end;

end;

function Databases_Type__Directory_Path__Get( const database_type_f : string ) : string;
begin

  Result := ExtractFilePath( Application.ExeName ) + databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar;

  if Trim( database_type_f ) <> '' then
    Result := Result +
      database_type_f + System.IOUtils.TPath.DirectorySeparatorChar;

end;

procedure DB_Grid_Draw_Column_Cell( const sort__column_name_f : string; db_grid_f : Vcl.DBGrids.TDBGrid; const Rect : Winapi.Windows.TRect; DataCol : Integer; Column : Vcl.DBGrids.TColumn; State : Vcl.Grids.TGridDrawState );
begin

  if Column <> nil then
    begin

      // Sorting column color.
      if    ( Column.Field <> nil )
        and ( Column.Field.FullName = sort__column_name_f ) then
        begin

          Column.Font.Color := Vcl.Graphics.clNavy;

          if db_grid_f <> nil then
            begin

              db_grid_f.Canvas.Brush.Color := color__blue__light_c;

              db_grid_f.DefaultDrawColumnCell( Rect, DataCol, Column, State );

            end;

        end
      else
        Column.Font.Color := Vcl.Graphics.clWindowText;


      if    ( Column.Field <> nil )
        and ( Column.Field.IsNull ) then
        begin

          if Column.Field.FullName = sort__column_name_f  then
            db_grid_f.Canvas.Brush.Color := color__blue__light_c
          else
            db_grid_f.Canvas.Brush.Color := Vcl.Graphics.clWhite;

          db_grid_f.Canvas.Rectangle( Rect ); // For 'Memo' fields word '(Memo)' is longer than word 'null' and is visible behind.


          db_grid_f.Canvas.Font.Color := clBlue;
          db_grid_f.Canvas.TextOut( Rect.Left, Rect.Top, notification__sign__null_c );

        end;

    end;

end;

procedure DB_Grid_Select( db_grid_f : Vcl.DBGrids.TDBGrid; const selected_f : boolean; const invertf : boolean = false );
var
  zti : integer;
begin

  if   ( db_grid_f = nil )
    or ( db_grid_f.DataSource = nil )
    or ( db_grid_f.DataSource.DataSet = nil )
    or ( not db_grid_f.DataSource.DataSet.Active ) then
    Exit;


  db_grid_f.DataSource.DataSet.DisableControls();


  zti := db_grid_f.DataSource.DataSet.RecNo;


  db_grid_f.DataSource.DataSet.First();

  while not db_grid_f.DataSource.DataSet.Eof do
    begin

      if not invertf then
        db_grid_f.SelectedRows.CurrentRowSelected := selected_f
      else
        db_grid_f.SelectedRows.CurrentRowSelected := not db_grid_f.SelectedRows.CurrentRowSelected;


      db_grid_f.DataSource.DataSet.Next();

    end;


  db_grid_f.DataSource.DataSet.RecNo := zti;


  db_grid_f.DataSource.DataSet.EnableControls();

end;

procedure Font__Set( font__to_f, font__from_f : TFont );
var
  zt_log_font : TLogFont;
  zt_hfont : HFONT;
begin

  if GetObject(  font__from_f.Handle, SizeOf( zt_log_font ), @zt_log_font  ) = 0 then
    RaiseLastOSError();

  zt_hfont := CreateFontIndirect( zt_log_font );

  if zt_hfont = 0 then
    RaiseLastOSError();

  font__to_f.Handle := zt_hfont;
  font__to_f.Color := font__from_f.Color;

end;

procedure Items_From_Text_Add( items_f : System.Classes.TStrings; text_f : string );
var
  zti : integer;
begin

  if items_f = nil then
    Exit;


  zti := Pos( #13 + #10, text_f );

  while zti > 0 do
    begin

      items_f.Add(  Copy( text_f, 1, zti - 1 )  );
      Delete( text_f, 1, zti + 1 );

      zti := Pos( #13 + #10, text_f );

    end;

end;

function Parent_Form_Find( object_f : TObject ) : TForm;
begin

  Result := nil;


  if   ( object_f = nil )
    or ( Vcl.Controls.TWinControl(object_f).Parent = nil ) then
    Exit;

  if Vcl.Controls.TWinControl(object_f).Parent is TForm then
    Result := TForm(Vcl.Controls.TWinControl(object_f).Parent)
  else
    Result := Parent_Form_Find( Vcl.Controls.TWinControl(object_f).Parent );

end;

function Sort_Direction_Symbol( const ascending_f : boolean = true ) : string;
begin

  if ascending_f then
    Result := query__sort__ascending_c
  else
    Result := query__sort__descending_c;

end;

function Sql_Special_Characters_Protect( const text_f : string ) : string;
begin

  Result := StringReplace( text_f, '''', '''''', [ rfReplaceAll ] ); // '.

end;

procedure Syn_Completion_Proposal_After_Code_Completion( syn_edit_f : TSynEdit; var code_completion__cursor_position_f : integer );
begin

  if syn_edit_f = nil then
    Exit;


  if code_completion__cursor_position_f > -1 then
    begin

      syn_edit_f.SelStart := syn_edit_f.SelStart - code_completion__cursor_position_f + 1;

      code_completion__cursor_position_f := -1;

    end;

end;

procedure Syn_Completion_Proposal_Code_Completion( var code_completion__cursor_position_f : integer; var value_f : string );
var
  zti : integer;

  zts : string;
begin

  code_completion__cursor_position_f := -1;


  //zti := Pos(  sql_editor__column_replace_sign_c, System.StrUtils.ReverseString( value_f )  );
  zts := System.StrUtils.ReverseString( value_f );
  zti := Pos(  sql_editor__column_replace_sign_c, zts );

  if    ( zti > 0 )
    and (
             (  zti = Length( value_f )  )
          or ( // Skip concatenation (||).
                   (  zti < Length( zts )  )
               and ( zts[ zti + 1 ] <> sql_editor__column_replace_sign_c )
             )
        ) then
    begin

      code_completion__cursor_position_f := zti;

      Delete(  value_f, Length( value_f ) - code_completion__cursor_position_f + 1, 1  );

    end;

end;

procedure Syn_Completion_Proposal__Parameters__Set( syn_completion_proposal_f : SynCompletionProposal.TSynCompletionProposal );
begin

  if syn_completion_proposal_f = nil then
    Exit;


  if syn_completion_proposal_f.NbLinesInWindow <> sql_editor__code__completion_window__default__lines_in_window then
    syn_completion_proposal_f.NbLinesInWindow := sql_editor__code__completion_window__default__lines_in_window;

  if syn_completion_proposal_f.Width <> sql_editor__code__completion_window__default__width then
    syn_completion_proposal_f.Width := sql_editor__code__completion_window__default__width;

end;

function Syn_Edit__CharScan( syn_edit_f : TSynEdit; const do_delete_f : boolean = false ) : string;
var
  cRun,
  vBlockEnd_Char,
  vBlockBegin_Char,
  Value_Char
   : Integer;

  zts : string;
begin

  // Based on: SynEdit.pas - TCustomSynEdit.SetWordBlock.

  Result := '';


  if syn_edit_f = nil then
    Exit;


  Value_Char := syn_edit_f.CaretX;

  if Value_Char > Length( syn_edit_f.LineText ) then
    Exit;

  Result := syn_edit_f.LineText + #0;


  Value_Char := System.Math.Max( Value_Char, 1 );
  { search BlockEnd }
  vBlockEnd_Char := Length(Result);
  for cRun := Value_Char to Length(Result) do
    if not syn_edit_f.IsIdentChar(Result[cRun]) then
    begin
      vBlockEnd_Char := cRun;
      Break;
    end;
  { search BlockBegin }
  vBlockBegin_Char := 1;
  for cRun := Value_Char - 1 downto 1 do
    if not syn_edit_f.IsIdentChar(Result[cRun]) then
    begin
      vBlockBegin_Char := cRun + 1;
      Break;
    end;


  Result := Copy( syn_edit_f.LineText, vBlockBegin_Char, vBlockEnd_Char - vBlockBegin_Char );


  if    ( do_delete_f )
    and ( Result = '' )
    and ( vBlockBegin_Char > 0 )
    and ( vBlockBegin_Char = vBlockEnd_Char )
    and (  vBlockBegin_Char < Length( syn_edit_f.LineText )  )
    and ( syn_edit_f.LineText[ vBlockBegin_Char ] = ' ' ) then
    begin

      while (  vBlockEnd_Char <= Length( syn_edit_f.LineText )  )
        and ( syn_edit_f.LineText[ vBlockEnd_Char ] = ' ' ) do
        inc( vBlockEnd_Char );


      Result := Copy( syn_edit_f.LineText, vBlockBegin_Char, vBlockEnd_Char - vBlockBegin_Char );

    end;


  if    ( do_delete_f )
    and ( Result <> '' )
    and ( vBlockEnd_Char > vBlockBegin_Char ) then
    begin

      zts := syn_edit_f.LineText;
      syn_edit_f.CaretX := vBlockBegin_Char;

      Delete( zts, vBlockBegin_Char, vBlockEnd_Char - vBlockBegin_Char );

      syn_edit_f.LineText := zts;

    end;

end;

procedure Syn_Edit__Highlight__Text( syn_edit_f : TSynEdit );
var
  whole_word_l : boolean;

  zts : string;

  syn_search_options : SynEditTypes.TSynSearchOptions;
begin

  if syn_edit_f = nil then
    Exit;


  zts := syn_edit_f.SelText;

  if Trim( zts ) = '' then
    begin

      whole_word_l := true;

      zts := Syn_Edit__CharScan( syn_edit_f );

    end
  else
    whole_word_l := false;


  if syn_edit_f.SearchEngine <> Shared.Shared_DataModule.SynEditSearch1 then // To highlight brackets.
    syn_edit_f.SearchEngine := Shared.Shared_DataModule.SynEditSearch1;


  if Trim( zts ) <> '' then
    begin

      //if syn_edit_f.SearchEngine <> Shared.Shared_DataModule.SynEditSearch1 then
      //  syn_edit_f.SearchEngine := Shared.Shared_DataModule.SynEditSearch1;

      if whole_word_l then
        syn_search_options := [ SynEditTypes.ssoWholeWord ]
      else
        syn_search_options := [];

      syn_edit_f.SearchEngine.Pattern := zts;
      syn_edit_f.SearchEngine.Options := syn_search_options;
      syn_edit_f.SearchEngine.FindAll( zts );

    end
  else
    if syn_edit_f.SearchEngine <> nil then
      //syn_edit_f.SearchEngine := nil;
      syn_edit_f.SearchEngine.Pattern := '';


  syn_edit_f.Refresh();

end;

function Syn_Edit_Key_Down( syn_edit_f : TSynEdit; Sender: TObject; var Key: Word; Shift: TShiftState ) : boolean;
begin

  Result := Syn_Edit_Key_Down( syn_edit_f, Sender, Key, Shift, sql_editor__bookmarks__toggle__with__line_color );

end;

function Syn_Edit_Key_Down( syn_edit_f : TSynEdit; Sender: TObject; var Key: Word; Shift: TShiftState; const bookmarks__toggle__with__line_color_f : boolean ) : boolean;

  procedure Select_All_L( syn_edit_f_f : TSynEdit );
  var
    carret_position_buffer_coord_l,
    selection_end_buffer_coord_l
      : SynEditTypes.TBufferCoord;
  begin

    if syn_edit_f_f = nil then
      Exit;


    carret_position_buffer_coord_l.Char := syn_edit_f_f.CaretX;
    carret_position_buffer_coord_l.Line := syn_edit_f_f.CaretY;


    selection_end_buffer_coord_l.Char := 1;
    selection_end_buffer_coord_l.Line := syn_edit_f_f.Lines.Count;

    if selection_end_buffer_coord_l.Line > 0 then
      inc(  selection_end_buffer_coord_l.Char, Length( syn_edit_f_f.Lines[ selection_end_buffer_coord_l.Line - 1 ] )  )
    else
      selection_end_buffer_coord_l.Line := 1;


    syn_edit_f_f.SetCaretAndSelection(  carret_position_buffer_coord_l, SynEditTypes.BufferCoord( 1, 1 ), selection_end_buffer_coord_l  );

  end;

var
  i,
  x,
  y,
  zti
    : integer;

  zts : string;
begin

  Result := false;


  if syn_edit_f = nil then
    Exit;


  if    ( not syn_edit_f.ReadOnly )
    and ( Key = VK_DELETE )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Common.Syn_Edit__CharScan( syn_edit_f, true );

      Result := true;

    end
  else
  if Key = VK_F3 then
    begin

      if Common.Text__Search_Replace__Is_Nil( text__search_replace_form ) then
        Common.Text__Search_Replace__Window_Show( syn_edit_f, text__search_replace_form )
      else
        begin

          if ssShift in Shift then
            Common.Text__Search_Replace__Direction__Invert( text__search_replace_form );


          Common.Text__Search_Replace__Do( syn_edit_f, text__search_replace_form );

        end;


       Result := true;

    end
  else
  if    ( Key = VK_F5 )
    and ( Shift = [ ssShift ] ) then
    begin

      if Application.MessageBox( PChar(Translation.translation__messages_r.clear_all_lines_color_), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) = IDYES then
        syn_edit_f.Lines_Color__Clear__All();

      Result := true;

    end
  else
  if Key = VK_F5 then
    begin

      if not syn_edit_f.Lines_Color__Check( syn_edit_f.CaretY ) then
        syn_edit_f.Lines_Color__Add( syn_edit_f.CaretY )
      else
        syn_edit_f.Lines_Color__Clear( syn_edit_f.CaretY );


      Result := true;

    end
  else
  if Key = VK_F6 then
    begin

      if not syn_edit_f.Lines_Color__Check( syn_edit_f.CaretY ) then
        syn_edit_f.Lines_Color__Add( syn_edit_f.CaretY );

      syn_edit_f.Lines_Color__Change( syn_edit_f.CaretY );


      Result := true;

    end
  else
  if Key = VK_F7 then
    begin

      syn_edit_f.Lines_Color__Choose( syn_edit_f.CaretY );


      Result := true;

    end
  else
  // 0 - 9.
  if    ( Key  in [ 48..57 ] )
    and ( Shift = [ ssCtrl, ssShift ] ) then
    begin

      zti := Key - 48;
      Key := 0;


      if not syn_edit_f.IsBookmark( zti ) then
        begin

          syn_edit_f.SetBookMark( zti, syn_edit_f.CaretX, syn_edit_f.CaretY );


          if bookmarks__toggle__with__line_color_f then
            begin

              if syn_edit_f.Lines_Color__Check( syn_edit_f.CaretY ) then
                syn_edit_f.Lines_Color__Clear( syn_edit_f.CaretY );

              syn_edit_f.Lines_Color__Add( syn_edit_f.CaretY );


              for i := 0 to zti do
                syn_edit_f.Lines_Color__Change( syn_edit_f.CaretY );

            end;

        end
      else
        begin

          syn_edit_f.ClearBookMark( zti );

          if bookmarks__toggle__with__line_color_f then
            begin

              if syn_edit_f.Lines_Color__Check( syn_edit_f.CaretY ) then
                syn_edit_f.Lines_Color__Clear( syn_edit_f.CaretY );


              // When a line has a few bookmarks restore line color.
              for i := 0 to 9 do
                if    (  syn_edit_f.GetBookMark( i, x, y )  )
                  and ( y = syn_edit_f.CaretY ) then
                  begin

                    syn_edit_f.Lines_Color__Add( syn_edit_f.CaretY );

                    for x := 0 to i do
                      syn_edit_f.Lines_Color__Change( syn_edit_f.CaretY );


                    Break;

                  end;

            end;

        end;


      Result := true;

    end
  else
  // 0 - 9.
  if    ( Key  in [ 48..57 ] )
    and ( Shift = [ ssCtrl ] ) then
    begin

      zti := Key - 48;


      if syn_edit_f.IsBookmark( zti ) then
        syn_edit_f.GotoBookMark( zti );


      Result := true;

    end
  else
  // /.
  if    ( not syn_edit_f.ReadOnly )
    and ( Key = VK_OEM_2 )
    and ( Shift = [ ssCtrl, ssShift ] ) then
    begin

      Common.Comment__Uncomment_Line( syn_edit_f, true );

      Result := true;

    end
  else
  // /.
  if    ( not syn_edit_f.ReadOnly )
    and ( Key = VK_OEM_2 )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Common.Comment__Uncomment_Line( syn_edit_f );

      Result := true;

    end
  else
  // \.
  if    ( not syn_edit_f.ReadOnly )
    and ( Key = VK_OEM_5 )
    and ( Shift = [ ssCtrl, ssShift ] ) then
    begin

      Common.Comment__Uncomment_Line__Slash( syn_edit_f, true );

      Result := true;

    end
  else
  // \.
  if    ( not syn_edit_f.ReadOnly )
    and ( Key = VK_OEM_5 )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Common.Comment__Uncomment_Line__Slash( syn_edit_f );

      Result := true;

    end
  else
  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Key := 0;

      Select_All_L( syn_edit_f );


      Result := true;

    end
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( syn_edit_f.SelText = '' ) then
    begin

      zts := Common.Syn_Edit__CharScan( syn_edit_f );

      if zts <> '' then
        Vcl.Clipbrd.Clipboard.AsText := zts;


      Result := true;

    end
  else
  // F.
  if    ( Key = 70 )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Common.Text__Search_Replace__Window_Show( syn_edit_f, text__search_replace_form );

      Result := true;

    end
  else
  // H.
  if    ( Key = 72 )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Common.Text__Search_Replace__Window_Show( syn_edit_f, text__search_replace_form, true );

      Result := true;

    end
  else
  // X.
  if    ( not syn_edit_f.ReadOnly )
    and ( Key = 88 )
    and ( Shift = [ ssCtrl ] )
    and ( syn_edit_f.SelText = '' ) then
    begin

      zts := Common.Syn_Edit__CharScan( syn_edit_f, true );

      if zts <> '' then
        Vcl.Clipbrd.Clipboard.AsText := zts;


      Result := true;

    end;

end;

procedure Syn_Edit__On_Replace_Text( syn_edit_f : TSynEdit; ASearch, AReplace : string; Line, Column : Integer; var Action : TSynReplaceAction; AClientRect : TRect );
var
  line_height_l : integer;
  modal_result :  TModalResult;
  zt_point: TPoint;
  text__search_replace__prompt_form_l : Text__Search_Replace__Prompt.TText__Search_Replace__Prompt_Form;
begin

  // Based on SynEdit SearchReplaceDemo.

  if syn_edit_f = nil then
    Exit;


  if ASearch = AReplace then
    Action := raSkip
  else
    begin

      if syn_edit_f.Lines.Count > 1 then
        begin

          zt_point := syn_edit_f.ClientToScreen
            (
              syn_edit_f.RowColumnToPixels
                (
                  syn_edit_f.BufferToDisplayPos
                    (
                      BufferCoord( 1, 1 )
                    )
                )
            );

          line_height_l := zt_point.Y;

          zt_point := syn_edit_f.ClientToScreen
            (
              syn_edit_f.RowColumnToPixels
                (
                  syn_edit_f.BufferToDisplayPos
                    (
                      BufferCoord( 1, 2 )
                    )
                )
            );

          line_height_l := Abs( zt_point.Y - line_height_l );

        end
      else
        line_height_l := 0;


      zt_point := syn_edit_f.ClientToScreen
        (
          syn_edit_f.RowColumnToPixels
            (
              syn_edit_f.BufferToDisplayPos
                (
                  BufferCoord( Column, Line )
                )
            )
        );


      text__search_replace__prompt_form_l := Text__Search_Replace__Prompt.TText__Search_Replace__Prompt_Form.Create( Application );
      text__search_replace__prompt_form_l.Caption_Text__Replace__Set( ASearch );

      text__search_replace__prompt_form_l.Left := zt_point.X;
      text__search_replace__prompt_form_l.Top := zt_point.Y + line_height_l;

      if text__search_replace__prompt_form_l.Left < 0 then
        text__search_replace__prompt_form_l.Left := 0
      else
      if text__search_replace__prompt_form_l.Left > Screen.Width - text__search_replace__prompt_form_l.Width then
        text__search_replace__prompt_form_l.Left := Screen.Width - text__search_replace__prompt_form_l.Width;

      if text__search_replace__prompt_form_l.Top < 0 then
        text__search_replace__prompt_form_l.Top := 0
      else
      if text__search_replace__prompt_form_l.Top > Screen.Height - text__search_replace__prompt_form_l.Height then
        text__search_replace__prompt_form_l.Top := Screen.Height - text__search_replace__prompt_form_l.Height * 2;

      modal_result := text__search_replace__prompt_form_l.ShowModal();
      System.SysUtils.FreeAndNil( text__search_replace__prompt_form_l );

      case modal_result of
          mrYes : Action := raReplace;
          mrYesToAll : Action := raReplaceAll;
          mrNo : Action := raSkip;
          else
            Action := raCancel;
        end;

   end;

end;

procedure Syn_Edit__Parameters__Set( syn_edit_f : TSynEdit );
begin

  // The same in: Common.Syn_Edit__Parameters__Set(), TOptions_Form.Sql_Text_SynEditEnter().


  if syn_edit_f = nil then
    Exit;


  syn_edit_f.ActiveLineColor := sql_editor__highlights__lines__active__color;

  syn_edit_f.Highlighter := Shared.Shared_DataModule.Syn_Edit__Highlighter__Get( Common.sql_editor__highlights__syntax );

  syn_edit_f.Options := syn_editor_options;

  if syn_edit_f.TabWidth <> Common.sql_editor__code__dent_width then
    syn_edit_f.TabWidth := Common.sql_editor__code__dent_width;

end;

procedure Syn_Edit__Search_Text_Hightlighter_Syn_Edit_Plugin__Create( syn_edit_f : TSynEdit );
begin

  if syn_edit_f = nil then
    Exit;


  Syn_Edit__Search_Text_Hightlighter_Syn_Edit_Plugin__Create
    (
      syn_edit_f,
      sql_editor__highlights__brackets__color__background, sql_editor__highlights__brackets__color__border,
      sql_editor__highlights__words__color__background, sql_editor__highlights__words__color__border,
      sql_editor__highlights__syntax__brackets__all_pairs,
      sql_editor__highlights__syntax__brackets__angle,
      sql_editor__highlights__syntax__brackets__curly,
      sql_editor__highlights__syntax__brackets__marked_only,
      sql_editor__highlights__syntax__brackets__round,
      sql_editor__highlights__syntax__brackets__square
    );

end;

procedure Syn_Edit__Search_Text_Hightlighter_Syn_Edit_Plugin__Create( syn_edit_f : TSynEdit; const color__brackets__background_f, color__brackets__border_f, color__words__background_f, color__words__border_f : integer; const brackets__all_pairs_f, brackets__angle_f, brackets__curly_f, brackets__marked_only_f, brackets__round_f, brackets__square_f : boolean );
begin

  if syn_edit_f = nil then
    Exit;


  syn_edit_f.Plugin__Search_Highlighter__Destroy();


  if   ( color__words__background_f <> clNone )
    or ( color__words__border_f <> clNone ) then
    with plgSearchHighlighter.TSearchTextHightlighterSynEditPlugin.Create( syn_edit_f ) do
      begin

        Attribute.Background := color__words__background_f;
        Attribute.Foreground := color__words__border_f;

      end;


  // Create always (even if the global settings 'switch off' brackets highlights) so that can change the settings from a local context (e.g. SQL editor tabs).
  if   ( color__brackets__background_f <> clNone )
    or ( color__brackets__border_f <> clNone ) then
    with plgSearchHighlighter.TSearchTextHightlighterSynEditPlugin__Brackets.Create( syn_edit_f ) do
      begin

        Attribute.Background := color__brackets__background_f;
        Attribute.Foreground := color__brackets__border_f;

        brackets__all_pairs := brackets__all_pairs_f;
        brackets__angle := brackets__angle_f;
        brackets__curly := brackets__curly_f;
        brackets__marked_only := brackets__marked_only_f;
        brackets__round := brackets__round_f;
        brackets__squareg := brackets__square_f;

      end;

end;

function Text__File_Load( const file_path_f : string ) : string;
var
  zt_string_list : TStringList;
begin

  Result := '';


  if not FileExists( file_path_f ) then
    Exit;


  zt_string_list := TStringList.Create();

  zt_string_list.LoadFromFile( file_path_f, System.SysUtils.TEncoding.UTF8 );
  Result := zt_string_list.Text;

  zt_string_list.Clear();
  System.SysUtils.FreeAndNil( zt_string_list );

end;

function Text__Search_Replace__Is_Nil( text__search_replace_form_f : Text__Search_Replace.TText__Search_Replace_Form ) : boolean;
begin

  if Common.text__search__window__one_common then
    Result := Shared.Shared_DataModule.text__search_replace_form__shared = nil
  else
    Result := text__search_replace_form_f = nil;

end;

procedure Text__Search_Replace__Direction__Invert( text__search_replace_form_f : Text__Search_Replace.TText__Search_Replace_Form );
var
  text__search_replace_form_l : Text__Search_Replace.TText__Search_Replace_Form;
begin

  if Common.text__search__window__one_common then
    text__search_replace_form_l := Shared.Shared_DataModule.text__search_replace_form__shared
  else
    text__search_replace_form_l := text__search_replace_form_f;


  text__search_replace_form_l.Search__Direction__Invert();

end;

procedure Text__Search_Replace__Do( syn_edit_f : TSynEdit; text__search_replace_form_f : Text__Search_Replace.TText__Search_Replace_Form );
var
  text__search_replace_form_l : Text__Search_Replace.TText__Search_Replace_Form;
begin

  if Common.text__search__window__one_common then
    text__search_replace_form_l := Shared.Shared_DataModule.text__search_replace_form__shared
  else
    text__search_replace_form_l := text__search_replace_form_f;


  text__search_replace_form_l.Syn_Edit__Set( syn_edit_f );


  text__search_replace_form_l.Search_Replace_ButtonClick( nil );

end;

procedure Text__Search_Replace__Hide( text__search_replace_form_f : Text__Search_Replace.TText__Search_Replace_Form );
begin

  if    ( Shared.Shared_DataModule <> nil )
    and ( Shared.Shared_DataModule.text__search_replace_form__shared <> nil ) then
    Shared.Shared_DataModule.text__search_replace_form__shared.Hide();

  if text__search_replace_form_f <> nil then
    text__search_replace_form_f.Hide();

end;

procedure Text__Search_Replace__Syn_Edit__Set( syn_edit_f : TSynEdit; text__search_replace_form_f : Text__Search_Replace.TText__Search_Replace_Form );
begin

  if Shared.Shared_DataModule.text__search_replace_form__shared <> nil then
    Shared.Shared_DataModule.text__search_replace_form__shared.Syn_Edit__Set( syn_edit_f );

  if text__search_replace_form_f <> nil then
    text__search_replace_form_f.Syn_Edit__Set( syn_edit_f );

end;

procedure Text__Search_Replace__Window_Show( syn_edit_f : TSynEdit; var text__search_replace_form_f : Text__Search_Replace.TText__Search_Replace_Form; const replace_f : boolean = false );
var
  zts : string;

  text__search_replace_form_l : Text__Search_Replace.TText__Search_Replace_Form;
begin

  if syn_edit_f = nil then
    Exit;


  if Common.text__search__window__one_common then
    text__search_replace_form_l := Shared.Shared_DataModule.text__search_replace_form__shared
  else
    text__search_replace_form_l := text__search_replace_form_f;


  if text__search_replace_form_l = nil then
    begin

      text__search_replace_form_l := Text__Search_Replace.TText__Search_Replace_Form.Create( Application );


      if Common.text__search__window__one_common then
        begin

          Shared.Shared_DataModule.text__search_replace_form__shared := text__search_replace_form_l;
          Shared.Shared_DataModule.text__search_replace_form__shared.Shared_Notification_Set();

        end
      else
        text__search_replace_form_f := text__search_replace_form_l;

    end;


  text__search_replace_form_l.Syn_Edit__Set( syn_edit_f );


  if   ( not text__search_replace_form_l.Focused )
    or ( not text__search_replace_form_l.Visible ) then
    begin

      if syn_edit_f.SelText <> '' then
        zts := syn_edit_f.SelText
      else
        zts := Common.Syn_Edit__CharScan( syn_edit_f );

      if zts <> '' then
        text__search_replace_form_l.Search__Text_Set( zts );

    end;


  text__search_replace_form_l.replace := replace_f;


  if not text__search_replace_form_l.Visible then
    text__search_replace_form_l.Show()
  else
    if not text__search_replace_form_l.Focused then
      text__search_replace_form_l.SetFocus();


  if text__search_replace_form_l.WindowState = TWindowState.wsMinimized then
    text__search_replace_form_l.WindowState := TWindowState.wsNormal;

end;

function User_Role__Name_Unique( const name_f, database_type_f : string; sdbm_f : TSDBM; log_memo_f : TMemo ) : boolean;
var
  zts : string;

  zt_sdbm : Common.TSDBM;
begin

  Result := false;


  zt_sdbm := Common.TSDBM.Create( sdbm_f );
  zt_sdbm.Component_Type_Set( sdbm_f.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

  zts := Text__File_Load(  Databases_Type__Directory_Path__Get( database_type_f ) + user_role__name_unique__file_name_c  );

  if Trim( zts ) = '' then
    begin

      if log_memo_f <> nil then
        log_memo_f.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Databases_Type__Directory_Path__Get( database_type_f ) + user_role__name_unique__file_name_c + ').' );

      zts :=
        'select count( distinct t.USER_NAME ) as USER_NAME ' +
        'from ' +
        '  ( ' +
        '    select distinct RDB$USER_PRIVILEGES.RDB$USER as USER_NAME ' +
        '    from RDB$USER_PRIVILEGES ' +
        ' ' +
        '    union ' +
        ' ' +
        '    select SEC$USERS.SEC$USER_NAME as USER_NAME ' +
        '    from SEC$USERS ' +
        ' ' +
        '    union ' +
        ' ' +
        '    select RDB$ROLES.RDB$ROLE_NAME as USER_NAME ' +
        '    from RDB$ROLES ' +
        '  ) as t ' +
        'where lower( t.USER_NAME ) = :user_name ';

    end;

  zt_sdbm.Query__Sql__Set( zts );


  if log_memo_f <> nil then
    log_memo_f.Lines.Add( zts );


  zt_sdbm.Query__Param_By_Name__Set(  name__user__name__small_letters_c, AnsiLowerCase( name_f ), log_memo_f  );

  try
    zt_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        if log_memo_f <> nil then
          log_memo_f.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_unique_check_query + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;


  if zt_sdbm.Query__Active() then
    begin

      if log_memo_f <> nil then
        log_memo_f.Lines.Add( zt_sdbm.Operation_Duration_Get() );


      try
        zt_sdbm.Query__Field_By_Name( name__user__name__big_letters_c ).AsInteger;
      except
        on E : Exception do
          begin

            zt_sdbm.Query__Close();

            if log_memo_f <> nil then
              log_memo_f.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_unique_check_query_column_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;

    end;


  if zt_sdbm.Query__Active() then
    begin

      if log_memo_f <> nil then
        log_memo_f.Lines.Add( zt_sdbm.Operation_Duration_Get() );


      Result := zt_sdbm.Query__Field_By_Name( name__user__name__big_letters_c ).AsInteger <= 0;

      zt_sdbm.Query__Close();

    end;


  System.SysUtils.FreeAndNil( zt_sdbm );

end;

end.
