unit External_Function__Modify;{14.Wrz.2023}

interface

uses
  Common,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, JvExMask,
  JvSpin, Vcl.ComCtrls, Vcl.CheckLst;

type
  TExternal_Function__Modify_Form = class( TForm )
    Execute_Button: TButton;
    Close_Button: TButton;
    Sql_Memo: TMemo;
    Sql_Prepare_Button: TButton;
    External_Function_Name_Edit: TEdit;
    External_Function_Name_Etiquette_Label: TLabel;
    PageControl1: TPageControl;
    Log_TabSheet: TTabSheet;
    Sql_TabSheet: TTabSheet;
    Log_Memo: TMemo;
    External_Function_Parameters_GroupBox: TGroupBox;
    External_Function_Parameter_Panel: TPanel;
    Type_Vertical_Splitter: TSplitter;
    Bottom_Panel: TPanel;
    Centre_Panel_Horizontal_Splitter: TSplitter;
    External_Function_Parameters__List_ScrollBox: TScrollBox;
    External_Function__Parameter__Align_Correct_Button: TButton;
    Modify__Parameter__Add_Button: TButton;
    Parameter__Move__Up_Button: TButton;
    Parameter__Move__Down_Button: TButton;
    Modify__Parameter__Delete_Button: TButton;
    Execute_Button_Works_As_Prepare_Execute_CheckBox: TCheckBox;
    External_Function_Entry_Point_Etiquette_Label: TLabel;
    External_Function_Entry_Point_ComboBox: TComboBox;
    External_Function_Module_Name_Etiquette_Label: TLabel;
    External_Function_Module_Name_ComboBox: TComboBox;

    procedure External_Function__Parameter_On_Click( Sender : TObject );

    procedure FormCreate( Sender: TObject );
    procedure FormShow( Sender: TObject );
    procedure FormClose( Sender: TObject; var Action: TCloseAction );
    procedure FormDestroy( Sender: TObject );

    procedure Sql_Prepare_ButtonClick( Sender: TObject );
    procedure Execute_ButtonClick( Sender: TObject );

    procedure External_Function__Parameter__Align_Correct_ButtonClick( Sender: TObject );
    procedure Modify__Parameter__Add_ButtonClick( Sender: TObject );
    procedure Modify__Parameter__Delete_ButtonClick( Sender: TObject );
    procedure Parameter__Move__Up_ButtonClick( Sender: TObject );
    procedure Parameter__Move__Down_ButtonClick( Sender: TObject );

    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Sql_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
  private
    { Private declarations }
    sql_prepared_correctly_g : boolean;

    external_function__parameter_id_g,
    external_function__parameter_selected_id_g
      : integer;

    data_types_list_g,
    parameter_by_list_g,
    sql__declare_g,
    sql__entry_point_g,
    sql__module_name_g,
    sql__returns_g
      : string;

    external_function_modify_sdbm : Common.TSDBM;

    function Quotation_Sign__EFM() : string;
    procedure External_Function__Parameter__Free( const external_function__parameter_selected_id_f : integer = 0 );
    procedure External_Function__Parameter__Selected__Notification_Set( const external_function__parameter_selected_id_f : integer = 0 );
  public
    { Public declarations }
    modified__efm,
    show_modal__efm,
    sql__quotation_sign__use__efm,
    splitter_show__efm,
    external_function__edit__efm
      : boolean;

    database_type__efm,
    sql__quotation_sign__efm,
    external_function__description_value__efm,
    external_function__name__efm
      : string;

    constructor Create( AOwner : TComponent; sdbm_f : Common.TSDBM ); overload;
  end;

const
  external_function__column__external_functions_name__small_letter_c : string = 'external_function_name';
  external_function__column__mechanism_c : string = 'MECHANISM';
  external_function__modify__parameters__parameter_by_list__file_name_c : string = 'External_Function__Modify__Parameters__Parameter_By_List.txt';
  external_function__modify__parameters__types_list__file_name_c : string = 'External_Function__Modify__Parameters__Types_List.txt';
  external_function__modify__sql__external_function__declare__entry_point__file_name_c : string = 'External_Function__Modify__External_Function__Declare__Entry_Point__sql.txt';
  external_function__modify__sql__external_function__declare__entry_point_list__file_name_c : string = 'External_Function__Modify__External_Function__Declare__Entry_Point_List__sql.txt';
  external_function__modify__sql__external_function__declare__file_name_c : string = 'External_Function__Modify__External_Function__Declare__sql.txt';
  external_function__modify__sql__external_function__declare__module_name__file_name_c : string = 'External_Function__Modify__External_Function__Declare__Module_Name__sql.txt';
  external_function__modify__sql__external_function__declare__module_name_list__file_name_c : string = 'External_Function__Modify__External_Function__Declare__Module_Name_List__sql.txt';
  external_function__modify__sql__external_function__declare__returns__file_name_c : string = 'External_Function__Modify__External_Function__Declare__Returns__sql.txt';
  external_function__modify__sql__external_function__declare__entry_point_c : string = 'EXTERNAL_FUNCTION_ENTRY_POINT';
  external_function__modify__sql__external_function__declare__module_name_c : string = 'EXTERNAL_FUNCTION_MODULE_NAME';
  external_function__modify__sql__external_function__declare__parameters_c : string = 'EXTERNAL_FUNCTION_PARAMETERS';
  external_function__modify__sql__external_function__declare__returns_c : string = 'EXTERNAL_FUNCTION_RETURNS';
  external_function__modify__sql__parameters_list__file_name_c : string = 'External_Function__Modify__Parameters_List__sql.txt';

var
  External_Function__Modify_Form: TExternal_Function__Modify_Form;

implementation

uses
  System.IOUtils,

  External_Function__Parameter,
  Shared,
  Translation;

{$R *.dfm}

procedure TExternal_Function__Modify_Form.External_Function__Parameter_On_Click( Sender : TObject );
begin

  if Sender <> nil then
    begin

      if Sender is External_Function__Parameter.TExternal_Function__Parameter then
        external_function__parameter_selected_id_g := External_Function__Parameter.TExternal_Function__Parameter(Sender).External_Function__Parameter_Id__Get()
      else
        if    ( TWinControl(Sender).Parent <> nil )
          and ( TWinControl(Sender).Parent is External_Function__Parameter.TExternal_Function__Parameter ) then
          external_function__parameter_selected_id_g := External_Function__Parameter.TExternal_Function__Parameter(TWinControl(Sender).Parent).External_Function__Parameter_Id__Get();

    end;


  External_Function__Parameter__Selected__Notification_Set( external_function__parameter_selected_id_g );

end;

function TExternal_Function__Modify_Form.Quotation_Sign__EFM() : string;
begin

  if sql__quotation_sign__use__efm then
    begin

      Result := sql__quotation_sign__efm;

    end
  else
    Result := '';

end;

procedure TExternal_Function__Modify_Form.External_Function__Parameter__Free( const external_function__parameter_selected_id_f : integer = 0 );
var
  i : integer;
begin

  External_Function_Parameters__List_ScrollBox.Visible := false;


  for i := External_Function_Parameters__List_ScrollBox.ControlCount - 1 downto 0 do
    if    ( External_Function_Parameters__List_ScrollBox.Controls[ i ].ClassType = External_Function__Parameter.TExternal_Function__Parameter )
      and (
               ( external_function__parameter_selected_id_f = 0 )
            or ( External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).External_Function__Parameter_Id__Get() = external_function__parameter_selected_id_f )
          ) then
      FreeAndNil( External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]) );


  External_Function_Parameters__List_ScrollBox.Visible := true;


  if external_function__parameter_selected_id_g = external_function__parameter_selected_id_f then
    external_function__parameter_selected_id_g := 0;


  External_Function__Parameter__Selected__Notification_Set( external_function__parameter_selected_id_g );

end;

procedure TExternal_Function__Modify_Form.External_Function__Parameter__Selected__Notification_Set( const external_function__parameter_selected_id_f : integer = 0 );
var
  i : integer;
begin

  for i := External_Function_Parameters__List_ScrollBox.ControlCount - 1 downto 0 do
    if External_Function_Parameters__List_ScrollBox.Controls[ i ].ClassType = External_Function__Parameter.TExternal_Function__Parameter then
      if External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).External_Function__Parameter_Id__Get() = external_function__parameter_selected_id_f then
        begin

          External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).Selected__Notification_Set__EFP( true );

        end
      else
        External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).Selected__Notification_Set__EFP();

end;

constructor TExternal_Function__Modify_Form.Create( AOwner : TComponent; sdbm_f : Common.TSDBM );
begin

  inherited Create( AOwner );


  external_function_modify_sdbm := Common.TSDBM.Create( sdbm_f );
  external_function_modify_sdbm.Component_Type_Set( sdbm_f.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

end;

procedure TExternal_Function__Modify_Form.FormCreate( Sender: TObject );
begin

  database_type__efm := '';
  modified__efm := false;
  show_modal__efm := true;
  splitter_show__efm := true;
  sql_prepared_correctly_g := false;
  external_function__description_value__efm := '';
  external_function__edit__efm := false;
  external_function__name__efm := '';
  external_function__parameter_id_g := 0;
  external_function__parameter_selected_id_g := 0;


  Translation.Translation__Apply( Self );

end;

procedure TExternal_Function__Modify_Form.FormShow( Sender: TObject );
var
  i : integer;

  zts,
  parameter_default_value_l
    : string;
begin

  PageControl1.ActivePage := Log_TabSheet;


  if external_function__edit__efm then
    begin

      External_Function_Name_Edit.Enabled := false;
      External_Function_Name_Edit.Text := external_function__name__efm;

    end;


  data_types_list_g := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__efm + System.IOUtils.TPath.DirectorySeparatorChar + external_function__modify__parameters__types_list__file_name_c  );

  if Trim( data_types_list_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + external_function__modify__parameters__types_list__file_name_c + ').' );

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


  parameter_by_list_g := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__efm + System.IOUtils.TPath.DirectorySeparatorChar + external_function__modify__parameters__parameter_by_list__file_name_c  );

  if Trim( parameter_by_list_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + external_function__modify__parameters__parameter_by_list__file_name_c + ').' );

      parameter_by_list_g :=
        #13 + #10 +
        'by BLOB descriptor' + #13 + #10 +
        'by descriptor' + #13 + #10 +
        'by reference' + #13 + #10 +
        'by value' + #13 + #10;

    end;


  sql__entry_point_g := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__efm + System.IOUtils.TPath.DirectorySeparatorChar + external_function__modify__sql__external_function__declare__entry_point__file_name_c  );

  if Trim( sql__entry_point_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + external_function__modify__sql__external_function__declare__entry_point__file_name_c + ').' );

      sql__entry_point_g :=
        #13 + #10 +
        'entry_point ';

    end
  else
    begin

      sql__entry_point_g := StringReplace( sql__entry_point_g, #10, '', [] );
      sql__entry_point_g := StringReplace( sql__entry_point_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Entry point: ' + sql__entry_point_g + '.' );


  sql__module_name_g := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__efm + System.IOUtils.TPath.DirectorySeparatorChar + external_function__modify__sql__external_function__declare__module_name__file_name_c  );

  if Trim( sql__module_name_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + external_function__modify__sql__external_function__declare__module_name__file_name_c + ').' );

      sql__module_name_g :=
        ' module_name ';

    end
  else
    begin

      sql__module_name_g := StringReplace( sql__module_name_g, #10, '', [] );
      sql__module_name_g := StringReplace( sql__module_name_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Module name: ' + sql__module_name_g + '.' );


  sql__returns_g := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__efm + System.IOUtils.TPath.DirectorySeparatorChar + external_function__modify__sql__external_function__declare__returns__file_name_c  );

  if Trim( sql__returns_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + external_function__modify__sql__external_function__declare__returns__file_name_c + ').' );

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


  sql__declare_g := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__efm + System.IOUtils.TPath.DirectorySeparatorChar + external_function__modify__sql__external_function__declare__file_name_c  );

  if Trim( sql__declare_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + external_function__modify__sql__external_function__declare__file_name_c + ').' );

      sql__declare_g :=
        'declare external function __EXTERNAL_FUNCTION_NAME__ ' +
        '__EXTERNAL_FUNCTION_PARAMETERS__ ' +
        '__EXTERNAL_FUNCTION_RETURNS__ ' +
        '__EXTERNAL_FUNCTION_ENTRY_POINT__ __EXTERNAL_FUNCTION_MODULE_NAME__ ';

    end
  else
    begin

      sql__declare_g := StringReplace( sql__declare_g, #10, '', [] );
      sql__declare_g := StringReplace( sql__declare_g, #13, '', [] );

    end;


  External_Function_Entry_Point_ComboBox.Items.Clear();

  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__efm + System.IOUtils.TPath.DirectorySeparatorChar + external_function__modify__sql__external_function__declare__entry_point_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + external_function__modify__sql__external_function__declare__entry_point_list__file_name_c + ').' );

      zts :=
        '' + #13 + #10 +
        '''IB_UDF_abs''' + #13 + #10 +
        '''IB_UDF_acos''' + #13 + #10 +
        '''IB_UDF_ascii_char''' + #13 + #10 +
        '''IB_UDF_ascii_val''' + #13 + #10 +
        '''IB_UDF_asin''' + #13 + #10 +
        '''IB_UDF_atan''' + #13 + #10 +
        '''IB_UDF_atan2''' + #13 + #10 +
        '''IB_UDF_bin_and''' + #13 + #10 +
        '''IB_UDF_bin_or''' + #13 + #10 +
        '''IB_UDF_bin_xor''' + #13 + #10 +
        '''IB_UDF_ceiling''' + #13 + #10 +
        '''IB_UDF_cos''' + #13 + #10 +
        '''IB_UDF_cosh''' + #13 + #10 +
        '''IB_UDF_cot''' + #13 + #10 +
        '''IB_UDF_div''' + #13 + #10 +
        '''IB_UDF_floor''' + #13 + #10 +
        '''IB_UDF_ln''' + #13 + #10 +
        '''IB_UDF_log''' + #13 + #10 +
        '''IB_UDF_log10''' + #13 + #10 +
        '''IB_UDF_lower''' + #13 + #10 +
        '''IB_UDF_lpad''' + #13 + #10 +
        '''IB_UDF_ltrim''' + #13 + #10 +
        '''IB_UDF_mod''' + #13 + #10 +
        '''IB_UDF_pi''' + #13 + #10 +
        '''IB_UDF_rand''' + #13 + #10 +
        '''IB_UDF_rpad''' + #13 + #10 +
        '''IB_UDF_rtrim''' + #13 + #10 +
        '''IB_UDF_sign''' + #13 + #10 +
        '''IB_UDF_sin''' + #13 + #10 +
        '''IB_UDF_sinh''' + #13 + #10 +
        '''IB_UDF_sqrt''' + #13 + #10 +
        '''IB_UDF_strlen''' + #13 + #10 +
        '''IB_UDF_substr''' + #13 + #10 +
        '''IB_UDF_substrlen''' + #13 + #10 +
        '''IB_UDF_tan''' + #13 + #10 +
        '''IB_UDF_tanh''' +  #13 + #10;

    end;

  Common.Items_From_Text_Add( External_Function_Entry_Point_ComboBox.Items, zts );

  if External_Function_Entry_Point_ComboBox.Items.Count > 1 then
    External_Function_Entry_Point_ComboBox.ItemIndex := 1;


  External_Function_Module_Name_ComboBox.Items.Clear();

  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__efm + System.IOUtils.TPath.DirectorySeparatorChar + external_function__modify__sql__external_function__declare__module_name_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + external_function__modify__sql__external_function__declare__module_name_list__file_name_c + ').' );

      zts :=
        '' + #13 + #10 +
        '''ib_udf''' +  #13 + #10;

    end;

  Common.Items_From_Text_Add( External_Function_Module_Name_ComboBox.Items, zts );

  if External_Function_Module_Name_ComboBox.Items.Count > 1 then
    External_Function_Module_Name_ComboBox.ItemIndex := 1;


  if external_function__edit__efm then
    begin

      Screen.Cursor := crHourGlass;


      if external_function_modify_sdbm.Query__Active() then
        external_function_modify_sdbm.Query__Close();

      zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__efm + System.IOUtils.TPath.DirectorySeparatorChar + external_function__modify__sql__parameters_list__file_name_c  );

      if Trim( zts ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + external_function__modify__sql__parameters_list__file_name_c + ').' );

          zts :=
            'select RDB$FUNCTION_ARGUMENTS.RDB$ARGUMENT_POSITION ' +
            '     , iif( RDB$FUNCTION_ARGUMENTS.RDB$ARGUMENT_POSITION = 0, '''', ''' + Common.db_grid__positive_value_c + ''' ) as PARAMETER_TYPE_INPUT ' +
            '     , RDB$FUNCTION_ARGUMENTS.RDB$DEFAULT_SOURCE ' +
            ' ' +
            '     , (case ' +
            '         RDB$FUNCTION_ARGUMENTS.RDB$ARGUMENT_MECHANISM ' +
            '         when 0 then ' +
            '           ''by value'' ' +
            ' ' +
            '         when 1 then ' +
            '           ''by reference'' ' +
            ' ' +
            '         when 2 then ' +
            '           ''by descriptor'' ' +
            ' ' +
            '         when 3 then ' +
            '           ''by BLOB descriptor'' ' +
            ' ' +
            '         else ' +
            '           RDB$FUNCTION_ARGUMENTS.RDB$ARGUMENT_MECHANISM||'' <?>'' ' +
            '       end) ' +
            '       as ARGUMENT_MECHANISM ' +
            ' ' +
            '     , (case ' +
            '         RDB$FUNCTION_ARGUMENTS.RDB$MECHANISM ' +
            '         when -1 then ' +
            '           '''' ' +
            ' ' +
            '         when 0 then ' +
            '           ''by value'' ' +
            ' ' +
            '         when 1 then ' +
            '           ''by reference'' ' +
            ' ' +
            '         when 2 then ' +
            '           ''by descriptor'' ' +
            ' ' +
            '         when 3 then ' +
            '           ''by BLOB descriptor'' ' +
            ' ' +
            '         else ' +
            '           RDB$FUNCTION_ARGUMENTS.RDB$MECHANISM||'' <?>'' ' +
            '       end) ' +
            '       as MECHANISM ' +
            ' ' +
            '     , (case ' +
            '         RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE ' +
            '         when 7 then ' +
            '           (case ' +
            '             RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE ' +
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
            '             RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE ' +
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
            '             RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE ' +
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
            '         when 23 then ' +
            '           ''Boolean'' ' +
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
            '           RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE||'' <?>'' ' +
            '       end)|| ' +
            '       iif(   RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE in ( 37 ) or ( RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE in ( 7, 8, 16, 27 ) and RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE = 2  ), ''( ''||' +
              'coalesce( RDB$FUNCTION_ARGUMENTS.RDB$CHARACTER_LENGTH, RDB$FUNCTION_ARGUMENTS.RDB$FIELD_PRECISION, '''' )||' +
              'iif(  RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE in ( 7, 8, 16 ) and RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE = 2 and RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SCALE is not null, '', ''||' +
              'cast(  abs( RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SCALE ) as smallint  ), ''''  )||'' )'', ''''   )|| ' +
            '       iif(  RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE in ( 40 ), ''( ''||RDB$FUNCTION_ARGUMENTS.RDB$FIELD_LENGTH||'' )'', ''''  )||' +
            '       cast(   substring(  coalesce( '' ''||RDB$FUNCTION_ARGUMENTS.RDB$DEFAULT_SOURCE, '''' ) from 1 for 255  ) as varchar( 255 )   )|| ' +
            '       iif(  RDB$FUNCTION_ARGUMENTS.RDB$NULL_FLAG = 1, '' not null'', trim( '''' )  )|| ' +
            '       coalesce(  '' collate ''||trim( RDB$COLLATIONS.RDB$COLLATION_NAME ), ''''  ) ' +
            '       as FIELD_TYPE ' +
            ' ' +
            'from RDB$FUNCTION_ARGUMENTS ' +
            'left join RDB$COLLATIONS on RDB$COLLATIONS.RDB$COLLATION_ID = RDB$FUNCTION_ARGUMENTS.RDB$COLLATION_ID ' +
            'where RDB$FUNCTION_ARGUMENTS.RDB$FUNCTION_NAME = :external_function_name ' +
            'order by RDB$FUNCTION_ARGUMENTS.RDB$ARGUMENT_POSITION ';

        end;

      external_function_modify_sdbm.Query__Sql__Set( zts );


      Log_Memo.Lines.Add( zts );


      external_function_modify_sdbm.Query__Param_By_Name__Set( external_function__column__external_functions_name__small_letter_c, External_Function_Name_Edit.Text, Log_Memo );

      try
        external_function_modify_sdbm.Query__Open();
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_external_function_data + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            Screen.Cursor := crHourGlass;

          end;
      end;


      if external_function_modify_sdbm.Query__Active() then
        begin

          External_Function_Parameters__List_ScrollBox.Visible := false;

          while not external_function_modify_sdbm.Query__Eof() do
            begin

              External_Function__Parameter.TExternal_Function__Parameter.Create
                (
                  External_Function_Parameters__List_ScrollBox,
                  external_function__parameter_id_g,
                  external_function_modify_sdbm.Query__Field_By_Name( external_function__column__mechanism_c ).AsString,
                  external_function_modify_sdbm.Query__Field_By_Name( Common.column_name__field_type_c ).AsString,
                  external_function_modify_sdbm.Query__Field_By_Name( Common.stored_procedure__column__parameter_type_input_c ).AsString,
                  data_types_list_g,
                  parameter_by_list_g,
                  splitter_show__efm,
                  External_Function__Parameter_On_Click
                );


              external_function_modify_sdbm.Query__Next();

            end;

          External_Function_Parameters__List_ScrollBox.Visible := true;


          for i := External_Function_Parameters__List_ScrollBox.ControlCount - 1 downto 0 do
            if External_Function_Parameters__List_ScrollBox.Controls[ i ].ClassType = External_Function__Parameter.TExternal_Function__Parameter then
              External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).Align_Correct__EFP();

        end;


      if external_function_modify_sdbm.Query__Active() then
        external_function_modify_sdbm.Query__Close();


      Screen.Cursor := crDefault;

    end;


  external_function__parameter_selected_id_g := 0;

  External_Function__Parameter__Selected__Notification_Set();


  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Sql_Memo.Font, Common.sql_editor__font );

end;

procedure TExternal_Function__Modify_Form.FormClose( Sender: TObject; var Action: TCloseAction );
begin

  if not show_modal__efm then
    FreeAndNil( Self );

end;

procedure TExternal_Function__Modify_Form.FormDestroy( Sender: TObject );
begin

  if external_function_modify_sdbm <> nil then
    FreeAndNil( external_function_modify_sdbm );


  External_Function__Parameter__Free();

end;

procedure TExternal_Function__Modify_Form.Sql_Prepare_ButtonClick( Sender: TObject );
var
  i : integer;

  zts_1,
  zts_2
    : string;
begin

  sql_prepared_correctly_g := false;


  if Trim( External_Function_Name_Edit.Text ) = '' then
    begin

      if External_Function_Name_Edit.Enabled then
        External_Function_Name_Edit.SetFocus();

      Application.MessageBox( PChar(Translation.translation__messages_r.external_function_name_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  if Trim( External_Function_Entry_Point_ComboBox.Text ) = '' then
    begin

      if External_Function_Entry_Point_ComboBox.Enabled then
        External_Function_Entry_Point_ComboBox.SetFocus();

      Application.MessageBox( PChar(Translation.translation__messages_r.external_function_entry_point_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  if Trim( External_Function_Module_Name_ComboBox.Text ) = '' then
    begin

      if External_Function_Module_Name_ComboBox.Enabled then
        External_Function_Module_Name_ComboBox.SetFocus();

      Application.MessageBox( PChar(Translation.translation__messages_r.external_function_module__library__name_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  PageControl1.ActivePage := Sql_TabSheet;


  zts_1 := sql__declare_g;

  zts_1 := StringReplace( zts_1, Common.sql__word_replace_separator_c + Common.external_function__column__external_functions_name__big_letter_c + Common.sql__word_replace_separator_c, Quotation_Sign__EFM() + External_Function_Name_Edit.Text + Quotation_Sign__EFM(), [ rfReplaceAll ] );


  zts_2 := '';

  for i := 0 to External_Function_Parameters__List_ScrollBox.ControlCount - 1 do
    if    ( External_Function_Parameters__List_ScrollBox.Controls[ i ].ClassType = External_Function__Parameter.TExternal_Function__Parameter )
      and ( External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).Type_Input__Get__EFP() ) then
      begin

        if zts_2 <> '' then
          zts_2 := zts_2 + Common.sql__external_function__parameter_separator
        else
          zts_2 := zts_2 + #13 + #10;

        zts_2 := zts_2 +
          External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).Data_Type_Get__EFP() +
          ' ' +
          External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).Parameter_By_Get__EFP();

      end;

  if zts_2 <> '' then
    zts_2 := ' ' + zts_2;

  zts_1 := StringReplace( zts_1, Common.sql__word_replace_separator_c + external_function__modify__sql__external_function__declare__parameters_c + Common.sql__word_replace_separator_c, zts_2, [ rfReplaceAll ] );


  zts_2 := '';

  for i := 0 to External_Function_Parameters__List_ScrollBox.ControlCount - 1 do
    if    ( External_Function_Parameters__List_ScrollBox.Controls[ i ].ClassType = External_Function__Parameter.TExternal_Function__Parameter )
      and ( not External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).Type_Input__Get__EFP() ) then
      begin

        if zts_2 <> '' then
          zts_2 := zts_2 + Common.sql__external_function__parameter_separator;

        zts_2 := zts_2 +
          External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).Data_Type_Get__EFP() +
          ' ' +
          External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).Parameter_By_Get__EFP();

      end;

  if zts_2 <> '' then
    zts_2 := sql__returns_g + zts_2;

  zts_1 := StringReplace( zts_1, Common.sql__word_replace_separator_c + external_function__modify__sql__external_function__declare__returns_c + Common.sql__word_replace_separator_c, zts_2, [ rfReplaceAll ] );


  zts_1 := StringReplace( zts_1, Common.sql__word_replace_separator_c + external_function__modify__sql__external_function__declare__entry_point_c + Common.sql__word_replace_separator_c, sql__entry_point_g + External_Function_Entry_Point_ComboBox.Text , [ rfReplaceAll ] );
  zts_1 := StringReplace( zts_1, Common.sql__word_replace_separator_c + external_function__modify__sql__external_function__declare__module_name_c + Common.sql__word_replace_separator_c, sql__module_name_g + External_Function_Module_Name_ComboBox.Text, [ rfReplaceAll ] );


  Sql_Memo.Lines.Clear();
  Sql_Memo.Lines.Add( zts_1 );


  sql_prepared_correctly_g := true;

end;

procedure TExternal_Function__Modify_Form.Execute_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  i : integer;

  zts,
  description_value_l,
  error_message_l,
  external_function__parameter_name_l
    : string;
begin

  if external_function_modify_sdbm = nil then
    Exit;


  sql_prepared_correctly_g := false;


  if Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked then
    begin

      Sql_Prepare_ButtonClick( Sender );

      if not sql_prepared_correctly_g then
        Exit;

      sql_prepared_correctly_g := false;

    end;


  ztb := external_function_modify_sdbm.Sql_Command_Execute( Sql_Memo.Lines.Text, error_message_l, Translation.translation__messages_r.failed_to_modify_external_function, false );


  if ztb then
    begin

      if not modified__efm then
        modified__efm := true;


      if External_Function_Name_Edit.Enabled then
        external_function__name__efm := External_Function_Name_Edit.Text;


      Log_Memo.Lines.Add( external_function_modify_sdbm.Operation_Duration_Get() );



      if Trim( external_function__description_value__efm ) <> '' then
        begin

          description_value_l := Common.Sql_Special_Characters_Protect( external_function__description_value__efm );


          zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + Common.databases_type_directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + database_type__efm + System.IOUtils.TPath.DirectorySeparatorChar + Common.external_function__sql__description__set__file_name_c  );

          if Trim( zts ) = '' then
            begin

              Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.external_function__sql__description__set__file_name_c + ').' );

              zts := Common.external_function__sql__description__set_c;

            end;

          zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.external_function__column__external_functions_name__big_letter_c + Common.sql__word_replace_separator_c, Quotation_Sign__EFM() + External_Function_Name_Edit.Text + Quotation_Sign__EFM(), [ rfReplaceAll ] );
          zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );


          Log_Memo.Lines.Add( zts );


          ztb := external_function_modify_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_external_function_description );


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

procedure TExternal_Function__Modify_Form.External_Function__Parameter__Align_Correct_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  for i := 0 to External_Function_Parameters__List_ScrollBox.ControlCount - 1 do
    if External_Function_Parameters__List_ScrollBox.Controls[ i ].ClassType = External_Function__Parameter.TExternal_Function__Parameter then
      External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).Align_Correct__EFP();

end;

procedure TExternal_Function__Modify_Form.Modify__Parameter__Add_ButtonClick( Sender: TObject );
begin

  External_Function__Parameter.TExternal_Function__Parameter.Create
    (
      External_Function_Parameters__List_ScrollBox,
      external_function__parameter_id_g,
      '',
      '',
      '',
      data_types_list_g,
      parameter_by_list_g,
      splitter_show__efm,
      External_Function__Parameter_On_Click
    ).Align_Correct__EFP();

end;

procedure TExternal_Function__Modify_Form.Modify__Parameter__Delete_ButtonClick( Sender: TObject );
begin

  if external_function__parameter_selected_id_g <= 0 then
    Exit;


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_selected_parameter_), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES then
    Exit;


  External_Function__Parameter__Free( external_function__parameter_selected_id_g );

end;

procedure TExternal_Function__Modify_Form.Parameter__Move__Up_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  if external_function__parameter_selected_id_g <= 0 then
    Exit;


  for i := 0 to External_Function_Parameters__List_ScrollBox.ControlCount - 1 do
    if External_Function_Parameters__List_ScrollBox.Controls[ i ].ClassType = External_Function__Parameter.TExternal_Function__Parameter then
      if External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).External_Function__Parameter_Id__Get() = external_function__parameter_selected_id_g then
        begin

          External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).Positions_Swap__EFP( alTop );

          Break;

        end;

end;

procedure TExternal_Function__Modify_Form.Parameter__Move__Down_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  if external_function__parameter_selected_id_g <= 0 then
    Exit;


  for i := 0 to External_Function_Parameters__List_ScrollBox.ControlCount - 1 do
    if External_Function_Parameters__List_ScrollBox.Controls[ i ].ClassType = External_Function__Parameter.TExternal_Function__Parameter then
      if External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).External_Function__Parameter_Id__Get() = external_function__parameter_selected_id_g then
        begin

          External_Function__Parameter.TExternal_Function__Parameter(External_Function_Parameters__List_ScrollBox.Controls[ i ]).Positions_Swap__EFP( alBottom );

          Break;

        end;

end;

procedure TExternal_Function__Modify_Form.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( ssCtrl in Shift )
    and (  not ( ssAlt in Shift )  ) then
    Log_Memo.SelectAll();

end;

procedure TExternal_Function__Modify_Form.Sql_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( ssCtrl in Shift )
    and (  not ( ssAlt in Shift )  ) then
    Sql_Memo.SelectAll();

end;

end.
