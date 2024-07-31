unit Translation;{15.Lis.2023}

  // Do not translate

  // Translation file format:
  //unit name
  //component name=caption
  //component name-->Hint=Abc#13#10def 123.
  //component name-->Items=Item 1;Item 2;Item 3;
  //translation__table__data_filter_r.name=
  //translation__messages_r.message name=

{$I Definitions.inc}

interface

uses
  Vcl.Controls;

type
  TTranslation_Apply_Kind = ( tak_All, tak_Grid, tak_Self );

  TTranslation__Component_r = record
    caption,
    component_name,
    hint,
    items
      : string;
  end;

  TTranslation__Messages_r = record
    add_exception,
    add_generator,
    add_index_on_columns__1,
    add_index_on_columns__2,
    add_role,
    add_the_column_not_null_attribute,
    add_user,
    alias_should_not_be_empty,
    all_files,
    application_files,
    automatically_block_execute_detection_words_list,
    automatically_execute_detection_words_list,
    automatically_transaction_begining_words_list,
    backup_file_path_should_not_be_empty,
    caret_position_label__hint,
    clear_all_lines_color_,
    close_all_connections_,
    code_completion__column,
    code_completion__sql,
    code_completion__stored_procedure,
    code_completion__table,
    code_completion__trigger,
    column_name_should_not_be_empty,
    column_names_should_be_unique,
    column_type_should_not_be_empty,
    columns_must_be_selected,
    confirmation,
    connection_successful,
    continue_,
    csv_files,
    database_create_application_file_path_should_not_be_empty,
    database_create__hint__ib_database,
    database_create__hint__isql,
    database_create__hint__sql,
    database_file_path_should_not_be_empty,
    database_type_should_not_be_empty,
    databases_list_changed__save_,
    default,
    default__with_a_capital_letter,
    delete_exception,
    delete_external_function,
    delete_generator,
    delete_index,
    delete_role,
    delete_selected_parameter_,
    delete_stored_procedure,
    delete_table,
    delete_the_column,
    delete_the_column_default_value,
    delete_the_column_description,
    delete_the_column_not_null_attribute,
    delete_the_database_description_,
    delete_the_database_from_the_list_,
    delete_the_exception_description,
    delete_the_external_function_description,
    delete_the_generator_description,
    delete_the_index_description,
    delete_the_role_description,
    delete_the_stored_procedure_description,
    delete_the_stored_procedure_parameter_description,
    delete_the_table_description,
    delete_the_trigger_description,
    delete_the_user_description,
    delete_the_view_description,
    delete_the_view_parameter_description,
    delete_user,
    delete_trigger,
    delete_view,
    delete_visible_records_,
    depended_on_type,
    depended_type,
    dependencies__items_,
    dependencies__nodes_,
    directory_does_not_exist,
    done,
    drop_privileges_from_role,
    error,
    errors_were_encountered,
    exception_message_should_not_be_empty,
    exception_name_should_not_be_empty,
    exit_,
    external_function_entry_point_should_not_be_empty,
    external_function_module__library__name_should_not_be_empty,
    external_function_name_should_not_be_empty,
    failed_to_add_exception,
    failed_to_add_generator,
    failed_to_add_index,
    failed_to_add_role,
    failed_to_add_the_column_not_null_attribute,
    failed_to_add_user,
    failed_to_copy_value_to_clipboard,
    failed_to_create_database,
    failed_to_create_table,
    failed_to_delete_exception,
    failed_to_delete_external_function,
    failed_to_delete_generator,
    failed_to_delete_index,
    failed_to_delete_role,
    failed_to_delete_stored_procedure_,
    failed_to_delete_table_,
    failed_to_delete_the_column,
    failed_to_delete_the_column_default_value,
    failed_to_delete_the_column_description,
    failed_to_delete_the_column_not_null_attribute,
    failed_to_delete_the_database_description,
    failed_to_delete_the_exception_description,
    failed_to_delete_the_external_function_description,
    failed_to_delete_the_generator_description,
    failed_to_delete_the_index_description,
    failed_to_delete_the_role_description,
    failed_to_delete_the_stored_procedure_description,
    failed_to_delete_the_stored_procedure_parameter_description,
    failed_to_delete_the_table_description,
    failed_to_delete_the_trigger_description,
    failed_to_delete_the_user_description,
    failed_to_delete_the_view_description,
    failed_to_delete_the_view_parameter_description,
    failed_to_delete_trigger,
    failed_to_delete_user,
    failed_to_delete_view_,
    failed_to_drop_privileges_from_role,
    failed_to_execute_command,
    failed_to_grant_privileges,
    failed_to_load_columns_list,
    failed_to_load_dependencies_list,
    failed_to_load_stored_procedures_list_,
    failed_to_load_tables_list_,
    failed_to_load_the_file,
    failed_to_load_views_list_,
    failed_to_modify_column,
    failed_to_modify_external_function,
    failed_to_modify_stored_procedure,
    failed_to_modify_trigger,
    failed_to_modify_view,
    failed_to_open_collates_list,
    failed_to_open_columns_list,
    failed_to_open_database_connection__ADO_,
    failed_to_open_database_connection__FireDAC__,
    failed_to_open_database_description,
    failed_to_open_database_informations,
    failed_to_open_exceptions_list,
    failed_to_open_external_function_data,
    failed_to_open_external_functions_list,
    failed_to_open_generator_description,
    failed_to_open_generators_list,
    failed_to_open_indexes_list,
    failed_to_open_parameters_list,
    failed_to_open_permissions_list,
    failed_to_open_primary_key_name,
    failed_to_open_query,
    failed_to_open_stored_procedure_data,
    failed_to_open_stored_procedure_metadata,
    failed_to_open_roles_list,
    failed_to_open_table,
    failed_to_open_table_description,
    failed_to_open_table_owner_name,
    failed_to_open_trigger_data,
    failed_to_open_triggers_list,
    failed_to_open_unique_check_query,
    failed_to_open_users_list,
    failed_to_open_view_data,
    failed_to_open_view_metadata,
    failed_to_paste_value_from_clipboard,
    failed_to_preview_value,
    failed_to_read_activity_column_name,
    failed_to_read_collate_name,
    failed_to_read_column_name,
    failed_to_read_column_value_as_a_number,
    failed_to_read_columns,
    failed_to_read_database_description,
    failed_to_read_dependencies_names,
    failed_to_read_description_column_name,
    failed_to_read_event_column_name,
    failed_to_read_events_column_name,
    failed_to_read_exception_message,
    failed_to_read_exception_name,
    failed_to_read_external_function_name,
    failed_to_read_generator_description,
    failed_to_read_generator_name,
    failed_to_read_generator_value,
    failed_to_read_index_name,
    failed_to_read_parameter_name,
    failed_to_read_parameter_number,
    failed_to_read_parameter_type_input_column_name,
    failed_to_read_permission_symbol__column_name,
    failed_to_read_permissions_user_name,
    failed_to_read_primary_key_name,
    failed_to_read_role_name,
    failed_to_read_sequence_column_name,
    failed_to_read_source_column_name,
    failed_to_read_stored_procedure_description_column_name,
    failed_to_read_stored_procedure_name_,
    failed_to_read_stored_procedure_owner_column_name,
    failed_to_read_stored_procedure_source_column_name,
    failed_to_read_table_description,
    failed_to_read_table_name_,
    failed_to_read_table_owner_name,
    failed_to_read_trigger_name,
    failed_to_read_type_column_name,
    failed_to_read_unique_check_query_column_name,
    failed_to_read_user_activity,
    failed_to_read_user_administrator_privilege,
    failed_to_read_user_name,
    failed_to_read_view_description_column_name,
    failed_to_read_view_name_,
    failed_to_read_view_owner_column_name,
    failed_to_read_view_source_column_name,
    failed_to_revoke_privileges,
    failed_to_set_command_parameter,
    failed_to_set_exception,
    failed_to_set_generator,
    failed_to_set_query_parameter,
    failed_to_set_role_privileges,
    failed_to_set_sql_dialect,
    failed_to_set_the_column_default_value,
    failed_to_set_the_column_description,
    failed_to_set_the_column_new_name,
    failed_to_set_the_column_position,
    failed_to_set_the_column_primary_key_attribute,
    failed_to_set_the_database_description,
    failed_to_set_the_exception_description,
    failed_to_set_the_external_function_description,
    failed_to_set_the_generator_description,
    failed_to_set_the_index_description,
    failed_to_set_the_role_description,
    failed_to_set_the_stored_procedure_description,
    failed_to_set_the_stored_procedure_parameter_description,
    failed_to_set_the_table_description,
    failed_to_set_the_trigger_description,
    failed_to_set_the_user_description,
    failed_to_set_the_view_description,
    failed_to_set_the_view_parameter_description,
    failed_to_set_user,
    failed_to_set_value_format___field,
    file_changed_,
    file_not_found,
    file_not_found___default_value_used,
    filter_value,
    firebird_backup_files,
    firebird_database_files,
    firebird_example_employee_fdb__fdac_,
    firedac_driver_id_should_not_be_empty,
    force_close_,
    generator_name_should_not_be_empty,
    generators_must_be_selected,
    grant_all_on_all_privileges_to_user,
    grant_privileges_on__1,
    grant_privileges_on__2,
    grant_privileges_on__3,
    grant_privileges_on_selected_generators_to_selected_users_,
    help__keyboard_shortcuts,
    index_name_should_not_be_empty__set_default_index_name_,
    information,
    language_file_does_not_exist,
    languages_directory_does_not_exist,
    object_not_found___default_value_used__collate_,
    parameter_name_should_be_unique,
    parameter_name_should_not_be_empty,
    point_the_database_file___e_g___c___program_files_firebird_examples_empbuild_employee_fdb,
    privileges_must_be_selected,
    query_output_count_,
    record_number__records_count_label__hint,
    replace_this_occurrence_of,
    reset_search_from_the_beginning_,
    reset_search_from_the_end_,
    revoke_all_on_all_privileges_from_user,
    revoke_privileges_on__1,
    revoke_privileges_on__2,
    revoke_privileges_on__3,
    revoke_privileges_on_selected_generators_from_selected_users_,
    role_and_user_name_should_be_unique,
    role_name_should_not_be_empty,
    save_columns_positions__table,
    save_table_data_to_file__no____display_in_log__,
    save_the_list_,
    search_string_not_found__1,
    search_string_not_found__2,
    set_exception,
    set_generator,
    set_role,
    set_the_column_primary_key_attribute,
    set_user_values__1,
    set_user_values__2,
    sql_editor_contains_data__continue_,
    sql_editor_default_keystrokes,
    sql_no_,
    stored_procedure_code_example,
    stored_procedure_name_should_not_be_empty,
    stored_procedure_not_found,
    stored_procedure_source_should_not_be_empty,
    table_name_should_not_be_empty,
    task_is_still_running_wait_until_finish,
    tasks_are_still_running_wait_until_finish,
    text_files,
    text__edit_memo__text__edit_memo_form__hint_,
    the_search_and_replace_strings_cannot_be_equal,
    the_search_string_cannot_be_blank,
    the_text_is_read_only,
    trigger_activity_should_not_be_empty,
    trigger_code_example,
    trigger_event_should_not_be_empty,
    trigger_events_must_be_selected,
    trigger_name_should_not_be_empty,
    trigger_not_found,
    trigger_source_should_not_be_empty,
    trigger_type_should_not_be_empty,
    user_name_should_not_be_empty,
    user_password_should_not_be_empty,
    users_must_be_selected,
    view_code_example,
    view_name_should_not_be_empty,
    view_not_found,
    view_source_should_not_be_empty,
    warning,

    word__active,
    word__administrator,
    word__allow_nulls,
    word__attribute_name,
    word__attribute_value,
    word__backup_state,
    word__character_set,
    word__check_constraint,
    word__close,
    word__collation,
    word__collation__with_a_capital_letter,
    word__column,
    word__column__name,
    word__columns,
    word__computed_column,
    word__connected,
    word__ctrl___o,
    word__database,
    word__database_path_or_alias,
    word__default__character_set,
    word__default__value,
    word__description,
    word__description___column,
    word__description___database,
    word__description___exception,
    word__description___external_function,
    word__description___generator,
    word__description___index,
    word__description___role,
    word__description___stored_procedure,
    word__description___stored_procedure_parameter,
    word__description___table,
    word__description___trigger,
    word__description___user,
    word__description___view,
    word__description___view_parameter,
    word__disconnected,
    word__done,
    word__error,
    word__exception,
    word__filling_database_pages,
    word__first_name,
    word__full_shutdown,
    word__generator__sequence_,
    word__generators,
    word__id_name,
    word__index,
    word__index__expression,
    word__index__name,
    items_count,
    word__last_name,
    word__length,
    word__merge,
    word__message,
    word__message__with_a_capital_letter,
    word__middle_name,
    word__multi_user_shutdown,
    word__name,
    word__no_,
    word__none,
    word__normal,
    word__open,
    word__owner,
    word__owner_name,
    word__package__body,
    word__package__header,
    word__page_size,
    word__parameter__name,
    word__parameter__number,
    word__primary_key,
    word__privilege,
    word__procedure,
    word__procedure___or_its_parameter_s__,
    word__read__only,
    word__read__write,
    word__reading_mode,
    word__re_creation_date,
    word__reserve_space,
    word__role_name,
    word__segment_length,
    word__shared,
    word__shutdown_mode,
    word__single_user_shutdown,
    word__sql_dialect,
    word__stalled,
    word__stored_function,
    word__table,
    word__table___or_a_column_in_it_,
    word__the_database_is_online,
    word__time__shortcut__days,
    word__time__shortcut__hours,
    word__time__shortcut__milliseconds,
    word__time__shortcut__minutes,
    word__time__shortcut__seconds,
    word__total,
    word__trigger,
    word__trigger__name,
    word__trigger_sequence,
    word__trigger_type,
    word__type,
    word__udf_or_stored_function,
    word__use_all_space,
    word__user,
    word__stored_procedure__name,
    word__user__name,
    word__user__names,
    word__value,
    word__value_to,
    word__view
      : string;
  end;

  TTranslation__Table__Data_Filter_r = record // And other parameters.
    automatically_use_quotation_sign,
    automatically_use_quotation_sign__hint,
    buttons_panel__hint,
    case_insensitive,
    case_insensitive__hint,
    double_click___copy_the_field_name_to_clipboard,
    correct_align,
    correct_align__hint,
    delete_filter__hint,
    disable_filter,
    disable_filter__hint,
    field_name_etiquette_label__hint,
    field_value__dedicated__use_check_box__hint,
    move_left__hint,
    move_right__hint,
    parameter_by,
    parameter_data_type,
    parameter_default_value,
    parameter_description,
    parameter_value,
    sql_parameter_1,
    sql_parameter_2,
    type_input,
    type_input__hint,
    use_additional_value
      : string;
  end;

  TTranslation_Unit_r = record
    unit_name : string;
    components_r_t : array of TTranslation__Component_r;
  end;


procedure Translation__Default_Set();
procedure Translation__Load();
procedure Translation__Apply( target_f : Vcl.Controls.TWinControl );


const
  translation__code_completion__column_c : string = '__column__';
  translation__code_completion__sql_c : string = '__sql__';
  translation__code_completion__stored_procedure_c : string = '__stored_procedure__';
  translation__code_completion__table_c : string = '__table__';
  translation__code_completion__trigger_c : string = '__trigger__';
  translation__differentiator__caption__form_c : string = 'Caption';
  translation__differentiator__default_sign_c : string = '<';
  translation__differentiator__items__file_c : string = '-->Items';
  translation__differentiator__items__record_c : string = ';';
  translation__differentiator__hint_c : string = '-->Hint';
  translation__messages_c : string = 'translation__messages_r.';
  translation__owner_label_name_c : string = 'Owner_Label';
  translation__table__data_filter_c : string = 'translation__table__data_filter_r.';

var
  translation__messages_r : TTranslation__Messages_r;
  translation__table__data_filter_r : TTranslation__Table__Data_Filter_r;
  translation__units_r_t : array of TTranslation_Unit_r;

implementation

uses
  {$IFDEF JVCL__use}
  JvDBControls,
  JvDBDateTimePicker,
  JvDBSpinEdit,
  {$ENDIF}
  System.Classes,
  System.IOUtils,
  System.Rtti,
  System.SysUtils,
  System.TypInfo,
  Vcl.Buttons,
  Vcl.CheckLst,
  Vcl.ComCtrls,
  Vcl.DBCtrls,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.Menus,
  Vcl.Samples.Spin,
  Vcl.StdCtrls,
  Vcl.WinXPickers,
  Winapi.Windows,

  Common;

procedure Translation__Default_Set();
var
  unit_index : integer;

  procedure Translation__Component__Add( const component_name_f, caption_f : string; const hint_f : string = ''; const items_f : string = '' );
  var
    i_l : integer;
  begin

    i_l := Length( translation__units_r_t[ unit_index ].components_r_t );
    SetLength( translation__units_r_t[ unit_index ].components_r_t, i_l + 1 );

    translation__units_r_t[ unit_index ].components_r_t[ i_l ].caption := caption_f;
    translation__units_r_t[ unit_index ].components_r_t[ i_l ].component_name := component_name_f;
    translation__units_r_t[ unit_index ].components_r_t[ i_l ].hint := hint_f;
    translation__units_r_t[ unit_index ].components_r_t[ i_l ].items := items_f;

  end;

  procedure Translation__Unit__Add( const nit_name_f : string );
  begin

    unit_index := Length( translation__units_r_t );
    SetLength( translation__units_r_t, unit_index + 1 );
    translation__units_r_t[ unit_index ].unit_name := nit_name_f;

  end;

var
  i : integer;
begin

  for i := 0 to Length( translation__units_r_t ) - 1 do
    SetLength( translation__units_r_t[ i ].components_r_t, 0 );

  SetLength( translation__units_r_t, 0 );

  {$region 'Visual components.'}
  Translation__Unit__Add( 'TAbout_Form' );
    Translation__Component__Add( 'Caption', 'About' );

  Translation__Unit__Add( 'TDatabase__Backup_Restore_Form' );
    Translation__Component__Add( 'Caption', 'Database backup / restore' );
    Translation__Component__Add( 'Command_Prepare_Button', 'Prepare', 'Command prepare.' );
    Translation__Component__Add( 'Command_TabSheet', 'Command' );
    Translation__Component__Add( 'Database__Alias_Etiquette_Label', 'Alias' );
    Translation__Component__Add( 'Database__Backup__Application__File_Path__Find_Button', '', 'Find file.' );
    Translation__Component__Add( 'Database__Backup__Application__File_Path_GroupBox', 'Database backup application file path', 'E.g.:' + #13 + #10 + 'C:\Program Files\Firebird\Firebird_3_0\gbak.exe' );
    Translation__Component__Add( 'Database__Backup__File_Name__Date_Time_RadioGroup', 'Date time', '', 'none;date;date time;' );
    Translation__Component__Add( 'Database__Backup__File_Name__Set_Button', '', 'File name set.' );
    Translation__Component__Add( 'Database__Backup__File_Path_GroupBox', 'Backup file path', 'E.g.:' + #13 + #10 + 'C:\F1\database_file.fbk' );
    Translation__Component__Add( 'Database__Backup__File_Path__Find_Button', '', 'Find file.' );
    Translation__Component__Add( 'Database__File_Path_GroupBox', 'Database file path', 'E.g.:' + #13 + #10 + 'C:\F1\database_file.fdb' );
    Translation__Component__Add( 'Database__File_Path__Find_Button', '', 'Find file.' );
    Translation__Component__Add( 'Database_GroupBox', 'Database' );
    Translation__Component__Add( 'Database_Type_GroupBox', 'Database type' );
    Translation__Component__Add( 'Execute_Button', 'Execute', 'Command execute.' );
    Translation__Component__Add( 'Execute_Button_Works_As_Prepare_Execute_CheckBox', 'P + E', 'Execute button works as Prepare + Execute.' );
    Translation__Component__Add( 'Log_TabSheet', 'Log' );
    Translation__Component__Add( 'Log__Auto_Scroll__Seconds_SpinEdit', '', 'Log automatic scrolling:' + #13 + #10 + '< 0 - disabled;' + #13 + #10 + '= 0 - always;' + #13 + #10 + '> 0 - every <value> seconds.' );
    Translation__Component__Add( 'Parameter__Align_Correct_Button', 'a', 'Correct align.' );
    Translation__Component__Add( 'Parameters__Backup_TabSheet', 'Backup' );
    Translation__Component__Add( 'Parameters__General_GroupBox', 'General' );
    Translation__Component__Add( 'Parameters__Refresh_Button', '', 'Refresh parameters.' + #13 + #10 + #13 + #10 + '[Enter]' );
    Translation__Component__Add( 'Parameters__Restore_TabSheet', 'Restore' );
    Translation__Component__Add( 'Parameters_GroupBox', 'Parameters' );
    Translation__Component__Add( 'Password_Etiquette_Label', 'Password' );
    Translation__Component__Add( 'Quotation_Sign__Use_CheckBox', 'SQL quotation sign use', 'Use quotation sign:' + #13 + #10 + 'backup application file path,' + #13 + #10 + 'backup file path,' + #13 + #10 + 'database file path.' );
    Translation__Component__Add( 'User_Name_Etiquette_Label', 'User name' );

  Translation__Unit__Add( 'TDatabase__Create_Form' );
    Translation__Component__Add( 'Caption', 'Database create' );
    Translation__Component__Add( 'Command_Prepare_Button', 'Prepare', 'Command prepare.' );
    Translation__Component__Add( 'Command_TabSheet', 'Command' );
    Translation__Component__Add( 'Creation_Method_RadioGroup', 'Creation method', '', 'IBDatabase component;isql.exe;SQL;' );
    Translation__Component__Add( 'Database__Collation_Etiquette_Label', 'Collation' );
    Translation__Component__Add( 'Database__Create__Application__File_Path_GroupBox', 'Database create application file path', 'E.g.:' + #13 + #10 + 'C:\Program Files\Firebird\Firebird_3_0\isql.exe' );
    Translation__Component__Add( 'Database__Create__Application__File_Path__Find_Button', '', 'Find file.' );
    Translation__Component__Add( 'Database__Default_Character_Set_Etiquette_Label', 'Default character set' );
    Translation__Component__Add( 'Database__File_Path__Find_Button', '', 'Find file.' );
    Translation__Component__Add( 'Database__File_Path_GroupBox', 'Database file path', 'E.g.:' + #13 + #10 + 'C:\F1\database_file.fdb' );
    Translation__Component__Add( 'Database__Page_Size_Etiquette_Label', 'Page size' );
    Translation__Component__Add( 'Database__Sql_Dialect_Etiquette_Label', 'SQL dialect' );
    Translation__Component__Add( 'Database_GroupBox', 'Database' );
    Translation__Component__Add( 'Database_Type__Refresh_Button', '', 'Refresh parameters.' + #13 + #10 + #13 + #10 + '[Enter]' );
    Translation__Component__Add( 'Database_Type_GroupBox', 'Database type' );
    Translation__Component__Add( 'Execute_Button', 'Execute', 'Command execute.' );
    Translation__Component__Add( 'Execute_Button_Works_As_Prepare_Execute_CheckBox', 'P + E', 'Execute button works as Prepare + Execute.' );
    Translation__Component__Add( 'Help_Button', '' );
    Translation__Component__Add( 'Log_TabSheet', 'Log' );
    Translation__Component__Add( 'Password_Etiquette_Label', 'Password' );
    Translation__Component__Add( 'Quotation_Sign__Use_CheckBox', 'SQL quotation sign use', 'Use quotation sign:' + #13 + #10 + 'create application file path.' );
    Translation__Component__Add( 'User_Name_Etiquette_Label', 'User name' );

  Translation__Unit__Add( 'TDatabase__Informations_F_Frame' );
    Translation__Component__Add( 'Informations_TabSheet', 'Informations' );
    Translation__Component__Add( 'Triggers_TabSheet', 'Triggers' );

  Translation__Unit__Add( 'TDatabase__Informations_Modify_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Database_Description_GroupBox', 'Database description' );
    Translation__Component__Add( 'Database__Description__Drop_MenuItem', 'Database description delete' );
    Translation__Component__Add( 'Database__Description__Set_MenuItem', 'Database description edit' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );

  Translation__Unit__Add( 'TDatabase__List_Modify_Form' );
    Translation__Component__Add( 'Caption', 'Database connection' );
    Translation__Component__Add( 'Ado__Connection_String_Etiquette_Label', 'Connection string (ADO)', 'E.g.:' + #13 + #10 + 'Provider=MSDASQL.1;Persist Security Info=False;Data Source=database_odbc_name' );
    Translation__Component__Add( 'Alias_Etiquette_Label', 'Alias' );
    Translation__Component__Add( 'Cancel_Button', 'Cancel' );
    Translation__Component__Add( 'Component_Type_Etiquette_Label', 'Preferred component type' );
    Translation__Component__Add( 'Connection__Example_Button', 'Example', 'Set parameters to connect to the sample FireBird database.' );
    Translation__Component__Add( 'Connection__Test__Type_RadioGroup', 'Connection test' );
    Translation__Component__Add( 'Connection__Test_Button', 'Test', 'Connection test.' );
    Translation__Component__Add( 'Database_Type_Etiquette_Label', 'Database type' );
    Translation__Component__Add( 'Fire_Dac__Driver_Id_Etiquette_Label', 'Driver id (FireDAC)', 'E.g.:' + #13 + #10 + 'FB for FireBird.' );
    Translation__Component__Add( 'Fire_Dac__File_Path__Find_Button', '', 'Find file.' );
    Translation__Component__Add( 'Fire_Dac__File_Path_GroupBox', 'File path (FireDAC, database file to backup / restore)', 'E.g.:' + #13 + #10 + 'C:\F1\database_file.fdb' + #13 + #10 + #13 + #10 + 'C:\Program Files\Firebird\examples\empbuild\EMPLOYEE.FDB' );
    Translation__Component__Add( 'Fire_Dac__Parameters_Etiquette_Label', 'Parameters (FireDAC, optional)', 'E.g.:' + #13 + #10 + 'Server=123.456.7.8' + #13 + #10 + 'CharacterSet=utf8' );
    Translation__Component__Add( 'Login_Prompt_CheckBox', 'Login prompt' );
    Translation__Component__Add( 'Ok_Button', 'OK' );
    Translation__Component__Add( 'Password_Etiquette_Label', 'Password (optional)' );
    Translation__Component__Add( 'Sql__Parameter_Sign_Etiquette_Label', 'SQL parameter sign' );
    Translation__Component__Add( 'Sql__Quotation_Sign_Etiquette_Label', 'SQL quotation sign (optional)' );
    Translation__Component__Add( 'User_Name_Etiquette_Label', 'User name (optional)' );

  Translation__Unit__Add( 'TDatabase__Modify_Form' );
    Translation__Component__Add( 'Caption', 'Database' );
    Translation__Component__Add( 'Component_Type_Etiquette_Label', 'Component type' );
    Translation__Component__Add( 'Component_Type_TabSheet', 'C. T.' );
    Translation__Component__Add( 'Connect_Button', '(Re)Connect' );
    Translation__Component__Add( 'Connection_Status_Etiquette_Label', 'Connection status' );
    Translation__Component__Add( 'Database_Name_Label', 'Database: ' );
    Translation__Component__Add( 'Database__Informations_TabSheet', 'Info' );
    Translation__Component__Add( 'Exceptions_TabSheet', 'Exceptions' );
    Translation__Component__Add( 'External_Functions_TabSheet', 'External functions' );
    Translation__Component__Add( 'Form_View__Additional_Component_Show_CheckBox', 'Form view - show additional components' );
    Translation__Component__Add( 'Generators_List_TabSheet', 'Generators' );
    Translation__Component__Add( 'Queries_Open_In_Background_CheckBox', 'Queries (some) open in the background' );
    Translation__Component__Add( 'Roles_List_TabSheet', 'Roles' );
    Translation__Component__Add( 'Splitter_Show_CheckBox', 'Show splitters (e.g. form view, stored procedure parameters)' );
    Translation__Component__Add( 'Sql_Editor_TabSheet', 'SQL' );
    Translation__Component__Add( 'Sql_Editor__Database_Connection__Separated_CheckBox', 'SQL editor - separated database connection', 'Every tab has own database connection.' );
    Translation__Component__Add( 'Sql_Editor__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Sql_Editor__Move__Left_Button', '', 'Move the tab left.' );
    Translation__Component__Add( 'Sql_Editor__Move__Right_Button', '', 'Move the tab right.' );
    Translation__Component__Add( 'Sql_Editor__Page__Close__All_Button', '', 'Close all.' );
    Translation__Component__Add( 'Sql_Editor__Page__Close__One_Button', '', 'Close one.' );
    Translation__Component__Add( 'Sql_Editor__Page__New_Button', '', 'New tab.' );
    Translation__Component__Add( 'Sql__Quotation_Sign__Use_CheckBox', 'SQL quotation sign use' );
    Translation__Component__Add( 'Stored_Procedures_List_Count_Etiquette_Label', 'Stored procedures' );
    Translation__Component__Add( 'Stored_Procedures_List_TabSheet', 'Stored procedures' );
    Translation__Component__Add( 'Stored_Procedures_List__Close__All_MenuItem', 'Close all' );
    Translation__Component__Add( 'Stored_Procedures_List__Close__One_MenuItem', 'Close one' );
    Translation__Component__Add( 'Stored_Procedures_List__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Stored_Procedures_List__Move__Left_Button', '', 'Move the tab left.' );
    Translation__Component__Add( 'Stored_Procedures_List__Move__Right_Button', '', 'Move the tab right.' );
    Translation__Component__Add( 'Stored_Procedures_List__Page__Close__All_Button', '', 'Close all.' );
    Translation__Component__Add( 'Stored_Procedures_List__Page__Close__One_Button', '', 'Close one.' );
    Translation__Component__Add( 'Stored_Procedures_List__Page__New_Button', '', 'Open stored procedure.' );
    Translation__Component__Add( 'Stored_Procedures_List__Page__New_MenuItem', 'Open stored procedure [Enter, Double-click]' );
    Translation__Component__Add( 'Stored_Procedures_List__Refresh_MenuItem', 'Refresh [Ctrl + R]' );
    Translation__Component__Add( 'Stored_Procedures_List__Search_Edit', '', 'Enter - open;' + #13 + #10 + 'Page down - search next;' + #13 + #10 + 'Page up - search prior;' + #13 + #10 + 'Shift + Enter - open and edit.' );
    Translation__Component__Add( 'Stored_Procedures_List__Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Stored_Procedures_List__Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Stored_Procedures_List__Search__Next_Button', '', 'Search next.' + #13 + #10 + #13 + #10 + '[Ctrl + Shift + Enter - open and edit]' + #13 + #10 + '[Shift + Enter - open]' );
    Translation__Component__Add( 'Stored_Procedures_List__Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Stored_Procedures_List__Search__Prior_Button', '', 'Search prior.' + #13 + #10 + #13 + #10 + '[Ctrl + Shift + Enter - open and edit]' + #13 + #10 + '[Shift + Enter - open]' );
    Translation__Component__Add( 'Stored_Procedures_List__Stored_Procedure__Add__MenuItem', 'Add stored procedure [Ctrl + Insert]' );
    Translation__Component__Add( 'Stored_Procedures_List__Stored_Procedure__Add__Modal__MenuItem', 'Add stored procedure (modal) [Insert]' );
    Translation__Component__Add( 'Stored_Procedures_List__Stored_Procedure__Delete__MenuItem', 'Delete stored procedure [Ctrl + Delete]' );
    Translation__Component__Add( 'Tables_List_Count_Etiquette_Label', 'Tables' );
    Translation__Component__Add( 'Tables_List_TabSheet', 'Tables' );
    Translation__Component__Add( 'Tables_List__Close__All_MenuItem', 'Close all' );
    Translation__Component__Add( 'Tables_List__Close__One_MenuItem', 'Close one' );
    Translation__Component__Add( 'Tables_List__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Tables_List__Move__Left_Button', '', 'Move the tab left.' );
    Translation__Component__Add( 'Tables_List__Move__Right_Button', '', 'Move the tab right.' );
    Translation__Component__Add( 'Tables_List__Page__Close__All_Button', '', 'Close all.' );
    Translation__Component__Add( 'Tables_List__Page__Close__One_Button', '', 'Close one.' );
    Translation__Component__Add( 'Tables_List__Page__New_Button', '', 'Open table.' + #13 + #10 + #13 + #10 + '[Enter, Double-click]' );
    Translation__Component__Add( 'Tables_List__Page__New_MenuItem', 'Open table [Enter, Double-click]' );
    Translation__Component__Add( 'Tables_List__Refresh_MenuItem', 'Refresh [Ctrl + R]' );
    Translation__Component__Add( 'Tables_List__Search_Edit', '', 'Ctrl + Enter - open table and open table data;' + #13 + #10 + 'Enter - open table;' + #13 + #10 + 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Tables_List__Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Tables_List__Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Tables_List__Search__Next_Button', '', 'Search next.' + #13 + #10 + #13 + #10 + '[Ctrl + Enter - open table and open table data]' + #13 + #10 + '[Shift + Enter - open table]' );
    Translation__Component__Add( 'Tables_List__Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Tables_List__Search__Prior_Button', '', 'Search prior.' + #13 + #10 + #13 + #10 + '[Ctrl + Enter - open table and open table data]' + #13 + #10 + '[Shift + Enter - open table]' );
    Translation__Component__Add( 'Tables_List__Table__Add_MenuItem', 'Add table [Insert]' );
    Translation__Component__Add( 'Tables_List__Table__Delete_MenuItem', 'Delete table [Ctrl + Delete]' );
    Translation__Component__Add( 'Users_List_TabSheet', 'Users' );
    Translation__Component__Add( 'Views_List_Count_Etiquette_Label', 'Views' );
    Translation__Component__Add( 'Views_List_TabSheet', 'Views' );
    Translation__Component__Add( 'Views_List__Close__All_MenuItem', 'Close all' );
    Translation__Component__Add( 'Views_List__Close__One_MenuItem', 'Close one' );
    Translation__Component__Add( 'Views_List__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Views_List__Move__Left_Button', '', 'Move the tab left.' );
    Translation__Component__Add( 'Views_List__Move__Right_Button', '', 'Move the tab right.' );
    Translation__Component__Add( 'Views_List__Page__Close__All_Button', '', 'Close all.' );
    Translation__Component__Add( 'Views_List__Page__Close__One_Button', '', 'Close one.' );
    Translation__Component__Add( 'Views_List__Page__New_Button', '', 'Open view.' );
    Translation__Component__Add( 'Views_List__Page__New_MenuItem', 'Open view [Enter, Double-click]' );
    Translation__Component__Add( 'Views_List__Refresh_MenuItem', 'Refresh [Ctrl + R]' );
    Translation__Component__Add( 'Views_List__Search_Edit', '', 'Ctrl + Enter - open and open view data;' + #13 + #10 + 'Enter - open;' + #13 + #10 + 'Page down - search next;' + #13 + #10 + 'Page up - search prior;' + #13 + #10 + 'Shift + Enter - open and edit.' );
    Translation__Component__Add( 'Views_List__Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Views_List__Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Views_List__Search__Next_Button', '', 'Search next.' + #13 + #10 + #13 + #10 + '[Ctrl + Enter - open and open view data]' + #13 + #10 + '[Ctrl + Shift + Enter - open and edit]' + #13 + #10 + '[Shift + Enter - open]' );
    Translation__Component__Add( 'Views_List__Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Views_List__Search__Prior_Button', '', 'Search prior.' + #13 + #10 + #13 + #10 + '[Ctrl + Enter - open and open view data]' + #13 + #10 + '[Ctrl + Shift + Enter - open and edit]' + #13 + #10 + '[Shift + Enter - open]' );
    Translation__Component__Add( 'Views_List__View__Add__MenuItem', 'Add view [Ctrl + Insert]' );
    Translation__Component__Add( 'Views_List__View__Add__Modal__MenuItem', 'Add view (modal) [Insert]' );
    Translation__Component__Add( 'Views_List__View__Delete__MenuItem', 'Delete view [Ctrl + Delete]' );

  Translation__Unit__Add( 'TDatabase__Trigger_Modify_Form' );
    Translation__Component__Add( 'Caption', 'Trigger - database' );
    Translation__Component__Add( 'Close_Button', 'Close' );
    Translation__Component__Add( 'Code_Examples_Button', 'Code', 'Code examples.' );
    Translation__Component__Add( 'Execute_Button', 'Execute', 'Command execute.' + #13 + #10 + #13 + #10 + '[Ctrl + E]' );
    Translation__Component__Add( 'Execute_Button_Works_As_Prepare_Execute_CheckBox', 'P + E', 'Execute button works as Prepare + Execute.' + #13 + #10 + #13 + #10 + '[Ctrl + +]' );
    Translation__Component__Add( 'Log_TabSheet', 'Log' );
    Translation__Component__Add( 'Sql_Prepare_Button', 'Prepare', 'Command prepare.' + #13 + #10 + #13 + #10 + '[Ctrl + P]' );
    Translation__Component__Add( 'Sql_TabSheet', 'SQL' );
    Translation__Component__Add( 'Trigger_Activity_Etiquette_Label', 'Activity', 'active - active' + #13 + #10 + 'inactive - inactive.' );
    Translation__Component__Add( 'Trigger_Event_Etiquette_Label', 'Event' );
    Translation__Component__Add( 'Trigger_Name_Etiquette_Label', 'Name' );
    Translation__Component__Add( 'Trigger_Sequence_Etiquette_Label', 'Sequence' );
    Translation__Component__Add( 'Trigger_Source_Etiquette_Label', 'Source', 'as' + #13 + #10 + 'BEGIN' + #13 + #10 + #13 + #10 + '  /* Code here. */' + #13 + #10 + #13 + #10 + 'END' );

  Translation__Unit__Add( 'TDependencies_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Dependencies_Description_GroupBox', 'Dependencies description' );
    Translation__Component__Add( 'Dependencies_Type_RadioGroup', 'Type', '', 'Dependent objects;Depended on objects;' );
    Translation__Component__Add( 'Nodes__Collapse_Button', '', 'Collapse nodes.' );
    Translation__Component__Add( 'Nodes__Expand_Button', '', 'Expand  nodes.' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );
    Translation__Component__Add( 'Search__Set_Focus_CheckBox', 'Set focus', 'Set the focus on the tree when searching.' );

  Translation__Unit__Add( 'TExceptions_Modify_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Exception_Name_Etiquette_Label', 'Exception name' );
    Translation__Component__Add( 'Exception__Delete_MenuItem', 'Delete' );
    Translation__Component__Add( 'Exception__Description__Drop_MenuItem', 'Description delete' );
    Translation__Component__Add( 'Exception__Description__Set_MenuItem', 'Description edit' );
    Translation__Component__Add( 'Exception__Description__Write_In_Log_MenuItem', 'Exception description write in log' );
    Translation__Component__Add( 'Exception__Message__Write_In_Log_MenuItem', 'Exception message write in log' );
    Translation__Component__Add( 'Modify_GroupBox', 'Modify' );
    Translation__Component__Add( 'Modify__Add_Button', '', 'Add new exception <name> <message>.' );
    Translation__Component__Add( 'Modify__Delete_Button', '', 'Delete selected exception.' + #13 + #10 + #13 + #10 + '[Delete]' );
    Translation__Component__Add( 'Modify__Edit_Button', '', 'Set <message> to selected exception.' + #13 + #10 + #13 + #10 + '[Enter]' );
    Translation__Component__Add( 'Modify__Message_Etiquette_Label', 'Message' );
    Translation__Component__Add( 'Modify__Message_Memo__Update_CheckBox', 'M. u.', 'Update text in the message memo.' );
    Translation__Component__Add( 'Modify__Name_Etiquette_Label', 'Name' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' + #13 + #10 + #13 + #10 + '[Ctrl + R]' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );

  Translation__Unit__Add( 'TExternal_Function__Modify_Form' );
    Translation__Component__Add( 'Caption', 'External function' );
    Translation__Component__Add( 'Close_Button', 'Close' );
    Translation__Component__Add( 'Execute_Button', 'Execute', 'Command execute.' );
    Translation__Component__Add( 'Execute_Button_Works_As_Prepare_Execute_CheckBox', 'P + E', 'Execute button works as Prepare + Execute.' );
    Translation__Component__Add( 'External_Function_Entry_Point_Etiquette_Label', 'Entry point' );
    Translation__Component__Add( 'External_Function_Module_Name_Etiquette_Label', 'Module (library) name' );
    Translation__Component__Add( 'External_Function_Name_Etiquette_Label', 'Name' );
    Translation__Component__Add( 'External_Function_Parameters_GroupBox', 'Parameters' );
    Translation__Component__Add( 'External_Function__Delete_MenuItem', 'Delete' );
    Translation__Component__Add( 'External_Function__Description__Drop_MenuItem', 'Description delete' );
    Translation__Component__Add( 'External_Function__Description__Set_MenuItem', 'Description edit' );
    Translation__Component__Add( 'External_Function__Description__Write_In_Log_MenuItem', 'External function description write in log' );
    Translation__Component__Add( 'External_Function__Parameter__Align_Correct_Button', 'a', 'Correct align.' );
    Translation__Component__Add( 'Log_TabSheet', 'Log' );
    Translation__Component__Add( 'Modify__Parameter__Add_Button', '', 'Add parameter.' );
    Translation__Component__Add( 'Modify__Parameter__Delete_Button', '', 'Delete selected parameter.' );
    Translation__Component__Add( 'Parameter__Move__Down_Button', '', 'Move selected parameter down.' );
    Translation__Component__Add( 'Parameter__Move__Up_Button', '', 'Move selected parameter up.' );
    Translation__Component__Add( 'Sql_Prepare_Button', 'Prepare', 'Command prepare.' );
    Translation__Component__Add( 'Sql_TabSheet', 'SQL' );

  Translation__Unit__Add( 'TExternal_Functions_Modify_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Edit_In_Modal_View_CheckBox', 'E. modal', 'Edit external function in modal view.' );
    Translation__Component__Add( 'External_Function_Name_Etiquette_Label', 'External function name' );
    Translation__Component__Add( 'External_Function__Delete_MenuItem', 'Delete' );
    Translation__Component__Add( 'External_Function__Description__Drop_MenuItem', 'Description delete' );
    Translation__Component__Add( 'External_Function__Description__Set_MenuItem', 'Description edit' );
    Translation__Component__Add( 'External_Function__Description__Write_In_Log_MenuItem', 'External function description write in log' );
    Translation__Component__Add( 'Modify_GroupBox', 'Modify' );
    Translation__Component__Add( 'Modify__Add_Button', '', 'Add new external function.' + #13 + #10 + #13 + #10 + '[Insert]' );
    Translation__Component__Add( 'Modify__Delete_Button', '', 'Delete selected external function.' + #13 + #10 + #13 + #10 + '[Delete]' );
    Translation__Component__Add( 'Modify__Edit_Button', '', 'Edit selected external function.' + #13 + #10 + #13 + #10 + '[Enter, Double-click]' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' + #13 + #10 + #13 + #10 + '[Ctrl + R]' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );

  Translation__Unit__Add( 'TGenerators_Modify_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Generator_Name_Etiquette_Label', 'Generator name' );
    Translation__Component__Add( 'Generator__Delete_MenuItem', 'Delete' );
    Translation__Component__Add( 'Generator__Description__Drop_MenuItem', 'Description delete' );
    Translation__Component__Add( 'Generator__Description__Set_MenuItem', 'Description edit' );
    Translation__Component__Add( 'Generator__Description__Write_In_Log_MenuItem', 'Generator description write in log' );
    Translation__Component__Add( 'Modify_GroupBox', 'Modify' );
    Translation__Component__Add( 'Modify__Add_Button', '', 'Add new generator <name>.' );
    Translation__Component__Add( 'Modify__Delete_Button', '', 'Delete selected generator.' + #13 + #10 + #13 + #10 + '[Delete]' );
    Translation__Component__Add( 'Modify__Edit_Button', '', 'Set <value> to selected generator.' + #13 + #10 + #13 + #10 + '[Enter]' );
    Translation__Component__Add( 'Modify__Name_Etiquette_Label', 'Name' );
    Translation__Component__Add( 'Modify__Value_Etiquette_Label', 'Value' );
    Translation__Component__Add( 'Modify__Values_Fields__Update_CheckBox', 'V. u.', 'Update value in the value field.' );
    Translation__Component__Add( 'Permissions_GroupBox', 'Permissions' );
    Translation__Component__Add( 'Permissions__Filter__Users__Apply_Button', '', 'Users filter apply.' );
    Translation__Component__Add( 'Permissions__Filter__Users__Cancel_Button', '', 'Users filter cancel.' );
    Translation__Component__Add( 'Permissions__Grant_Button', '', 'Grant permission.' );
    Translation__Component__Add( 'Permissions__Refresh_Button', '', 'Refresh.' + #13 + #10 + #13 + #10 + '[Ctrl + R]' );
    Translation__Component__Add( 'Permissions__Revoke_Button', '', 'Revoke permission.' );
    Translation__Component__Add( 'Permissions__User_Names_CheckListBox', '', 'Ctrl + A - select all' + #13 + #10 + 'Ctrl + I - invert selection' + #13 + #10 + 'Ctrl + N - unselect all' + #13 + #10 + 'Ctrl + R - refresh' + #13 + #10 + 'Ctrl + Enter - users filter cancel' + #13 + #10 + 'Enter - users filter apply' );
    Translation__Component__Add( 'Permissions__User_Names_Etiquette_Label', 'Users' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' + #13 + #10 + #13 + #10 + '[Ctrl + R]' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );

  Translation__Unit__Add( 'TOptions_Form' );
    Translation__Component__Add( 'Caption', 'Options' );
    Translation__Component__Add( 'Apply_Hint_Label', 'To apply settings in all open windows use the reconnect option.' );
    Translation__Component__Add( 'Basic_TabSheet', 'Basic' );
    Translation__Component__Add( 'Cancel_Button', 'Cancel' );
    Translation__Component__Add( 'Csv__File_GroupBox', 'Csv file' );
    Translation__Component__Add( 'Csv__File__Data_Separator_GroupBox', 'Data separator', 'Data separator.' );
    Translation__Component__Add( 'Csv__File__Text_Qualifier_GroupBox', 'Text qualifier', 'Text qualifier.' );
    Translation__Component__Add( 'Data_Presentation_TabSheet', 'Data presentation' );
    Translation__Component__Add( 'Data_Presentation__Data_Value_Format_GroupBox', 'Data value format' );
    Translation__Component__Add( 'Data_Presentation__Data_Value_Format__Date_GroupBox', 'Date', 'E.g.:' + #13 + #10 + 'dd.mm.yyyy' + #13 + #10 + 'dd-mm-yyyy' + #13 + #10 + 'yyyy-mm-dd' + #13 + #10 + 'yy mmm ddd' + #13 + #10 + 'd dddd mmmm y' );
    Translation__Component__Add( 'Data_Presentation__Data_Value_Format__Date__Use_CheckBox', 'Use' );
    Translation__Component__Add( 'Data_Presentation__Data_Value_Format__Date_Time_GroupBox', 'Date time', 'E.g.:' + #13 + #10 + 'dd.mm.yyyy hh:mm:ss' );
    Translation__Component__Add( 'Data_Presentation__Data_Value_Format__Date_Time__Use_CheckBox', 'Use' );
    Translation__Component__Add( 'Data_Presentation__Data_Value_Format__Numbers_GroupBox', 'Numbers', 'E.g.:' + #13 + #10 + '### ### ### ### ### ### ##0' + #13 + #10 + '0' + #13 + #10 + '000000' );
    Translation__Component__Add( 'Data_Presentation__Data_Value_Format__Numbers__Use_CheckBox', 'Use' );
    Translation__Component__Add( 'Data_Presentation__Data_Value_Format__Real_Numbers_GroupBox', 'Real numbers', 'E.g.:' + #13 + #10 + '### ### ### ### ### ### ##0.###' + #13 + #10 + '0.##############' + #13 + #10 + '### ### ##0.### ### ###' );
    Translation__Component__Add( 'Data_Presentation__Data_Value_Format__Real_Numbers__Use_CheckBox', 'Use' );
    Translation__Component__Add( 'Data_Presentation__Data_Value_Format__Time_GroupBox', 'Time', 'E.g.:' + #13 + #10 + 'hh:mm:ss' + #13 + #10 + 'hh mm ss.zzz' + #13 + #10 + 'h m s am/pm' + #13 + #10 + 'hh-m a/p' );
    Translation__Component__Add( 'Data_Presentation__Data_Value_Format__Time__Use_CheckBox', 'Use' );
    Translation__Component__Add( 'Data_Presentation__First_Rows_Etiquette_Label', 'First rows (table data)', 'Display first <value> rows only.' + #13 + #10 + 'Negative value = disabled.' );
    Translation__Component__Add( 'Database__Backup_Restore_TabSheet', 'Database backup / restore' );
    Translation__Component__Add( 'Database__Backup__Application__File_Path__Find_Button', '', 'Find file.' );
    Translation__Component__Add( 'Database__Backup__Application__File_Path_GroupBox', 'Database backup application file path', 'E.g.:' + #13 + #10 + 'C:\Program Files\Firebird\Firebird_3_0\gbak.exe' );
    Translation__Component__Add( 'Database__Backup__File_Name__Suffix_Default_RadioGroup', 'Database backup file name default suffix', '', 'none;date;date time;' );
    Translation__Component__Add( 'Database__Correctness_Check_Text_GroupBox', 'Correctness check text' );
    Translation__Component__Add( 'Database__Correctness_Check_Text__Backup_Etiquette_Label', 'Backup' );
    Translation__Component__Add( 'Database__Correctness_Check_Text__Restore_Etiquette_Label', 'Restore' );
    Translation__Component__Add( 'Database__Create__Application__File_Path__Find_Button', '', 'Find file.' );
    Translation__Component__Add( 'Database__Create__Application__File_Path_GroupBox', 'Database create application file path', 'E.g.:' + #13 + #10 + 'C:\Program Files\Firebird\Firebird_3_0\isql.exe' );
    Translation__Component__Add( 'Database__Modify__Window__Maximized_CheckBox', 'Database modify window maximized' );
    Translation__Component__Add( 'Fire_Dac__Querry__Fetch_Options_GroupBox', 'Querry fetch options' );
    Translation__Component__Add( 'Fire_Dac__Query__Fetch_Options__Mode_Etiquette_Label', 'Mode' );
    Translation__Component__Add( 'Fire_Dac__Query__Fetch_Options__Record_Count_Mode_Etiquette_Label', 'Record count mode' );
    Translation__Component__Add( 'Fire_Dac__Query__Fetch_Options__Rowset_Size_Etiquette_Label', 'Rowset size' );
    Translation__Component__Add( 'Fire_Dac_TabSheet', 'FireDac' );
    Translation__Component__Add( 'Form_View__Additional_Component_Show_CheckBox', 'Form view - show additional components' );
    Translation__Component__Add( 'Language_Etiquette_Label', 'Language' );
    Translation__Component__Add( 'Load_Button', 'Load' );
    Translation__Component__Add( 'Log__Auto_Scroll__GroupBox', 'Log automatic scrolling', 'Log automatic scrolling:' + #13 + #10 + '< 0 - disabled;' + #13 + #10 + '= 0 - always;' + #13 + #10 + '> 0 - every <value> seconds.' );
    Translation__Component__Add( 'Ok_Button', 'OK' );
    Translation__Component__Add( 'Queries_Open_In_Background_CheckBox', 'Queries (some) open in the background' );
    Translation__Component__Add( 'Save_Button', 'Save' );
    Translation__Component__Add( 'Splitter_Show_CheckBox', 'Show splitters (e.g. form view, stored procedure parameters)' );
    Translation__Component__Add( 'Sql__Command_Separator_GroupBox', 'SQL command separator' );
    Translation__Component__Add( 'Sql__External_Function__Parameter_Separator_GroupBox', 'SQL external function parameter separator' );
    Translation__Component__Add( 'Sql__Quotation_Sign__Use_CheckBox', 'SQL quotation sign use' );
    Translation__Component__Add( 'Sql__View__Parameter_Separator_GroupBox', 'SQL view parameter separator' );
    Translation__Component__Add( 'Sql_Editor_TabSheet', 'SQL editor' );
    Translation__Component__Add( 'Sql_Editor__Block_Execute__Automatic_Detection_CheckBox', 'Automatically ''block execute'' detection' );
    Translation__Component__Add( 'Sql_Editor__Bookmarks__Toggle__With__Line_Color_CheckBox', 'Toggle bookmarks with line color' );
    Translation__Component__Add( 'Sql_Editor__Close_Prompt_CheckBox', 'Close prompt', 'Prompt before closing SQL editor if text or data are not empty.' );
    Translation__Component__Add( 'Sql_Editor__Code__Completion_Window__Default__Lines_In_Window_GroupBox', 'Lines in window' );
    Translation__Component__Add( 'Sql_Editor__Code__Completion_Window__Default__Width_GroupBox', 'Default width' );
    Translation__Component__Add( 'Sql_Editor__Code__Completion_Window_GroupBox', 'Code completion window' );
    Translation__Component__Add( 'Sql_Editor__Code__Dent_Width_GroupBox', 'Code dent width', 'Indents / outdents a selected code line or block by width (characters count).' );
    Translation__Component__Add( 'Sql_Editor__Comments_Delete_CheckBox', 'Delete comments', 'Delete comments from SQL commands.' );
    Translation__Component__Add( 'Sql_Editor__Database_Connection__Separated_CheckBox', 'Separated database connection', 'Every tab has own database connection.' );
    Translation__Component__Add( 'Sql_Editor__Execute__Automatic_Detection_CheckBox', 'Automatically command execute detection', 'Automatically detect whether to use ''Query execute'' or ''Command execute'' button.' + #13 + #10 + 'Will use ''Command execute'' when the SQL text contains words like: alter, create, delete, drop, insert, recreate, set, update etc.' );
    Translation__Component__Add( 'Sql_Editor__Execute__Selected_CheckBox', 'Execute selected SQL only', 'Execute only the selected part of the SQL command (if the selection is not empty).' );
    Translation__Component__Add( 'Sql_Editor__Font_Button', 'Font' );
    Translation__Component__Add( 'Sql_Editor__Font__Use_In_Other_Components_CheckBox', 'Use SQL editor font in other components' );
    Translation__Component__Add( 'Sql_Editor__Highlights_GroupBox', 'Highlights' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Brackets_TabSheet', 'Brackets' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Brackets__Color__Background_Etiquette_Label', 'Background' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Brackets__Color__Border_Etiquette_Label', 'Border' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Lines_TabSheet', 'Lines' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Lines__Active__Color_Etiquette_Label', 'Active line' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Syntax_Etiquette_Label', 'Syntax' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Syntax_TabSheet', 'Syntax' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Syntax__Brackets__All_Pairs_CheckBox', 'All pairs', 'Highlight all selected brackets pairs.' + #13 + #10 + #13 + #10 + 'When a text is long it may work slowly.' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Syntax__Brackets__Angle_CheckBox', '< >', 'Highlight angle brackets.' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Syntax__Brackets__Curly_CheckBox', '{ }', 'Highlight curly brackets.' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Syntax__Brackets__Marked_Only_CheckBox', 'Marked only', 'Highlight only marked brackets.' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Syntax__Brackets__Round_CheckBox', '( )', 'Highlight round brackets.' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Syntax__Brackets__Square_CheckBox', '[ ]', 'Highlight square brackets.' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Words_TabSheet', 'Words' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Words__Color__Background_Etiquette_Label', 'Background' );
    Translation__Component__Add( 'Sql_Editor__Highlights__Words__Color__Border_Etiquette_Label', 'Border' );
    Translation__Component__Add( 'Sql_Editor__Keyboard__Shortcuts__Switch__Output_Save__With__Text_File_Save_CheckBox', 'Switch keyboard shortcuts ''Save query output as csv'' with ''Save file''' );
    Translation__Component__Add( 'Sql_Editor__Query_Output_Save_Field_Format__Date_Etiquette_Label', 'Date', 'E.g.:' + #13 + #10 + 'dd.mm.yyyy' + #13 + #10 + 'dd-mm-yyyy' + #13 + #10 + 'yyyy-mm-dd' + #13 + #10 + 'yy mmm ddd' + #13 + #10 + 'd dddd mmmm y' );
    Translation__Component__Add( 'Sql_Editor__Query_Output_Save_Field_Format__Real_Numbers_Etiquette_Label', 'Real numbers', 'E.g.:' + #13 + #10 + '### ### ### ### ### ### ##0.###' + #13 + #10 + '0.##############' + #13 + #10 + '### ### ##0.### ### ###' );
    Translation__Component__Add( 'Sql_Editor__Query_Output_Save_Field_Format__Separator__Date_Time_GroupBox', 'Date time' );
    Translation__Component__Add( 'Sql_Editor__Query_Output_Save_Field_Format__Separator__Decimal_GroupBox', 'Decimal' );
    Translation__Component__Add( 'Sql_Editor__Query_Output_Save_Field_Format__Separators_GroupBox', 'Separators' );
    Translation__Component__Add( 'Sql_Editor__Query_Output_Save_Field_Format__Time_Etiquette_Label', 'Time', 'E.g.:' + #13 + #10 + 'hh:mm:ss' + #13 + #10 + 'hh mm ss.zzz' + #13 + #10 + 'h m s am/pm' + #13 + #10 + 'hh-m a/p' );
    Translation__Component__Add( 'Sql_Editor__Query_Output_Save_Field_Format_GroupBox', 'Query output save field format' );
    Translation__Component__Add( 'Sql_Editor__Transactions_Automatic_CheckBox', 'Automatically transaction begining', 'Automatically begin transaction (if there is no active transaction) when the SQL text contains words like: delete, insert, update etc.' );
    Translation__Component__Add( 'Syn_Editor_Options_GroupBox', 'Editor options' );
    Translation__Component__Add( 'Syn_Editor_Options_CheckListBox', '', 'Ctrl + A - select all' + #13 + #10 + 'Ctrl + I - invert selection' + #13 + #10 + 'Ctrl + N - unselect all' );
    Translation__Component__Add( 'System_Tables_Visible_CheckBox', 'System tables, roles visible' );
    Translation__Component__Add( 'Table__Data_Filter_TabSheet', 'Table data filter' );
    Translation__Component__Add( 'Table__Data_Filter__Field_Dedicated__Default_Use_CheckBox', 'Use additional value as default', 'Use dedicated value as default in table data filter.' );
    Translation__Component__Add( 'Table__Data_Filter__Filter__Dedicated_Value_Format_GroupBox', 'Filter value format' );
    Translation__Component__Add( 'Table__Data_Filter__Filter__Dedicated_Value_Format__Date_Etiquette_Label', 'Date', 'E.g.:' + #13 + #10 + 'dd.mm.yyyy' );
    Translation__Component__Add( 'Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Date_Time_GroupBox', 'Date time' );
    Translation__Component__Add( 'Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Decimal_GroupBox', 'Decimal' );
    Translation__Component__Add( 'Table__Data_Filter__Filter__Dedicated_Value_Format__Separators_GroupBox', 'Separators' );
    Translation__Component__Add( 'Table__Data_Filter__Filter__Dedicated_Value_Format__Time_Etiquette_Label', 'Time', 'E.g.:' + #13 + #10 + 'hh:mm:ss' );
    Translation__Component__Add( 'Table__Data_Filter__Quotation_Sign__Use_CheckBox', 'Quotation sign use', 'Automatically use quotation sign in table data filter e.g. for text fields.' );
    Translation__Component__Add( 'Table__Data_Modify__Editing__Default_State_CheckBox', 'Table data editing default state', 'Data in the tables defaults to edit mode.' );
    Translation__Component__Add( 'Text__Search__History_Save_To_File__Items_Count_Etiquette_Label', 'Saved search and replace history items count' );
    Translation__Component__Add( 'Text__Search__History_Save_To_File_CheckBox', 'Save search and replace history to file' );
    Translation__Component__Add( 'Text__Search__Window__One_Common_CheckBox', 'One common window', 'One common search window for the entire application.' );
    Translation__Component__Add( 'Text__Search_Window_TabSheet', 'Text search' );
    Translation__Component__Add( 'Translation_TabSheet', 'Languages' );

  Translation__Unit__Add( 'TPermissions_Modify_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Modify_GroupBox', 'Modify' );
    Translation__Component__Add( 'Modify__Grant__All_Button', '', 'Grant all privileges.' );
    Translation__Component__Add( 'Modify__Grant__All_Button_MenuItem', 'Grant all privileges' );
    Translation__Component__Add( 'Modify__Grant_Button', '', 'Grant privileges.' );
    Translation__Component__Add( 'Modify__Grant_MenuItem', 'Grant privileges' );
    Translation__Component__Add( 'Modify__Permissions__Row_One_CheckBox', 'One row', 'Show permissions in one row.' );
    Translation__Component__Add( 'Modify__Permissions__Show_All_Users_CheckBox', 'Show all users' );
    Translation__Component__Add( 'Modify__Privileges_Name_CheckListBox', '', 'Ctrl + A - select all' + #13 + #10 + 'Ctrl + I - invert selection' + #13 + #10 + 'Ctrl + N - unselect all' );
    Translation__Component__Add( 'Modify__Privileges_Name_Etiquette_Label', 'Privileges' );
    Translation__Component__Add( 'Modify__Revoke__All_Button', '', 'Revoke all on all privileges.' + #13 + #10 + #13 + #10 + '[Ctrl + Delete]' );
    Translation__Component__Add( 'Modify__Revoke__All_MenuItem', 'Revoke all on all privileges' );
    Translation__Component__Add( 'Modify__Revoke_Button', '', 'Revoke privileges.' );
    Translation__Component__Add( 'Modify__Revoke_MenuItem', 'Revoke privileges' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );
    Translation__Component__Add( 'User_Name_Etiquette_Label', 'User name' );

  Translation__Unit__Add( 'TRoles_Modify_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Modify_GroupBox', 'Modify' );
    Translation__Component__Add( 'Modify__Add_Button', '', 'Add new role <name>.' );
    Translation__Component__Add( 'Modify__Delete_Button', '', 'Delete selected role.' + #13 + #10 + #13 + #10 + '[Delete]' );
    Translation__Component__Add( 'Modify__Edit_Button', '', 'Set <privileges> to selected role.' + #13 + #10 + #13 + #10 + '[Enter]' );
    Translation__Component__Add( 'Modify__Name_Etiquette_Label', 'Name' );
    Translation__Component__Add( 'Modify__Privileges_Name_CheckListBox', '', 'Ctrl + A - select all' + #13 + #10 + 'Ctrl + I - invert selection' + #13 + #10 + 'Ctrl + N - unselect all' );
    Translation__Component__Add( 'Modify__Privileges_Name_Etiquette_Label', 'Privileges' );
    Translation__Component__Add( 'Modify__Revoke_Button', '', 'Drop privileges from selected role.' + #13 + #10 + #13 + #10 + '[Backspace]' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' + #13 + #10 + #13 + #10 + '[Ctrl + R]' );
    Translation__Component__Add( 'Role_Name_Etiquette_Label', 'Role name' );
    Translation__Component__Add( 'Role__Delete_MenuItem', 'Delete' );
    Translation__Component__Add( 'Role__Description__Drop_MenuItem', 'Description delete' );
    Translation__Component__Add( 'Role__Description__Set_MenuItem', 'Description edit' );
    Translation__Component__Add( 'Role__Description__Write_In_Log_MenuItem', 'Role description write in log' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );

  Translation__Unit__Add( 'TSimple_Database_Manager_Form' );
    Translation__Component__Add( 'Caption', 'Simple database manager' );
    Translation__Component__Add( 'Database__Backup_Restore_2_MenuItem', 'Database backup / restore [Ctrl + B]' );
    Translation__Component__Add( 'Database__Backup_Restore_MenuItem', 'Database backup / restore [Ctrl + B]' );
    Translation__Component__Add( 'Database__Create_2_MenuItem', 'Database create [Ctrl + Insert]' );
    Translation__Component__Add( 'Database__Create_MenuItem', 'Database create [Ctrl + Insert]' );
    Translation__Component__Add( 'Databases__Add_MenuItem', 'Add to list [Insert]' );
    Translation__Component__Add( 'Databases__Add_2_MenuItem', 'Add to list [Insert]' );
    Translation__Component__Add( 'Databases__Close__All_MenuItem', 'Close all' );
    Translation__Component__Add( 'Databases__Close__All_2_MenuItem', 'Close all' );
    Translation__Component__Add( 'Databases__Close__One_MenuItem', 'Close one' );
    Translation__Component__Add( 'Databases__Close__One_2_MenuItem', 'Close one' );
    Translation__Component__Add( 'Databases__Close__Selected_MenuItem', 'Close selected' );
    Translation__Component__Add( 'Databases__Close__Selected_2_MenuItem', 'Close selected' );
    Translation__Component__Add( 'Databases__Copy_MenuItem', 'Copy [Ctrl + C]' );
    Translation__Component__Add( 'Databases__Copy_2_MenuItem', 'Copy [Ctrl + C]' );
    Translation__Component__Add( 'Databases__Delete_MenuItem', 'Delete from list [Delete]' );
    Translation__Component__Add( 'Databases__Delete_2_MenuItem', 'Delete from list [Delete]' );
    Translation__Component__Add( 'Databases__Edit_MenuItem', 'Edit list [Spacebar, Ctrl + Enter]' );
    Translation__Component__Add( 'Databases__Edit_2_MenuItem', 'Edit list [Spacebar, Ctrl + Enter]' );
    Translation__Component__Add( 'Databases__Exit_MenuItem', 'Exit' );
    Translation__Component__Add( 'Databases__Exit_2_MenuItem', 'Exit' );
    Translation__Component__Add( 'Databases__Hide_Show_Databases_MenuItem', 'Hide / show databases' );
    Translation__Component__Add( 'Databases__Hide_Show_Databases_2_MenuItem', 'Hide / show databases' );
    Translation__Component__Add( 'Databases__Move__Down_MenuItem', 'Move down [Ctrl + Down arrow]' );
    Translation__Component__Add( 'Databases__Move__Down_2_MenuItem', 'Move down [Ctrl + Down arrow]' );
    Translation__Component__Add( 'Databases__Move__Up_MenuItem', 'Move up [Ctrl + Up arrow]' );
    Translation__Component__Add( 'Databases__Move__Up_2_MenuItem', 'Move up [Ctrl + Up arrow]' );
    Translation__Component__Add( 'Databases__Open_MenuItem', 'Open [Enter]' );
    Translation__Component__Add( 'Databases__Open_2_MenuItem', 'Open [Enter]' );
    Translation__Component__Add( 'Databases__Refresh_MenuItem', 'Refresh list [Ctrl + R]' );
    Translation__Component__Add( 'Databases__Refresh_2_MenuItem', 'Refresh list [Ctrl + R]' );
    Translation__Component__Add( 'Databases__Save_MenuItem', 'Save list [Ctrl + S]' );
    Translation__Component__Add( 'Databases__Save_2_MenuItem', 'Save list [Ctrl + S]' );
    Translation__Component__Add( 'Databases_MenuItem', 'Databases' );
    Translation__Component__Add( 'Help__About_MenuItem', 'About' );
    Translation__Component__Add( 'Help__Keyboard_Shortcuts_MenuItem', 'Keyboard shortcuts' );
    Translation__Component__Add( 'Help_MenuItem', 'Help' );
    Translation__Component__Add( 'Options_MenuItem', 'Options' );

  Translation__Unit__Add( 'TSql_Editor_F_Frame' );
    Translation__Component__Add( 'Ado_Command_Param_Check_CheckBox', 'P.', 'Query parameters check (ADO command).' );
    Translation__Component__Add( 'Ado_Command_Param_Check_MenuItem', 'Query parameters check (ADO command)' );
    Translation__Component__Add( 'Block_Execute__Automatic_Detection_MenuItem', 'Automatically ''block execute'' detection' );
    Translation__Component__Add( 'Bookmarks__Clear__All_MenuItem', 'Clear bookmarks' );
    Translation__Component__Add( 'Bookmarks__Go_To_MenuItem', 'Go to bookmark [Ctrl + 0 ... 9]' );
    Translation__Component__Add( 'Bookmarks__Toggle_MenuItem', 'Toggle bookmark [Ctrl + Shift + 0 ... 9]' );
    Translation__Component__Add( 'Bookmarks__Toggle__With__Line_Color_MenuItem', 'Toggle bookmarks with line color' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Close_Button', '', 'Query close.' );
    Translation__Component__Add( 'Close_MenuItem', 'Query close' );
    Translation__Component__Add( 'Comment_Invert_Alternatively_MenuItem', 'Comment invert alternatively [Ctrl + Shift + \]' );
    Translation__Component__Add( 'Comment_Uncomment_Alternatively_MenuItem', 'Comment / uncomment alternatively [Ctrl + \, Ctrl + Shift + \]' );
    Translation__Component__Add( 'Comment_Uncomment_MenuItem', 'Comment / uncomment [Ctrl + /, Ctrl + Shift + /]' );
    Translation__Component__Add( 'Comments_Delete_CheckBox', 'Delete comments', 'Delete comments from SQL commands.' );
    Translation__Component__Add( 'Comments_Delete_MenuItem', 'Delete comments' );
    Translation__Component__Add( 'Copy_MenuItem', 'Copy [Ctrl + C]' );
    Translation__Component__Add( 'Cut_MenuItem', 'Cut [Ctrl + X]' );
    Translation__Component__Add( 'Csv__File__Data_Separator_Edit', '', 'Csv data separator.' );
    Translation__Component__Add( 'Csv__File__Text_Qualifier_Edit', '', 'Csv text qualifier.' );
    Translation__Component__Add( 'Data_Value_Format__Disabled_CheckBox', 'Data value format disabled' );
    Translation__Component__Add( 'Data_Value_Format__Disabled_MenuItem', 'Data value format disabled' );
    Translation__Component__Add( 'Database__Reconnect_MenuItem', 'Database reconnect' );
    Translation__Component__Add( 'Execute_Button', '', 'Command execute.' + #13 + #10 + #13 + #10 + '[Ctrl + Shift + E]' );
    Translation__Component__Add( 'Execute_MenuItem', 'Command execute [Ctrl + Shift + E]' );
    Translation__Component__Add( 'Execute__Automatic_Detection_CheckBox', 'E.', 'Automatically detect whether to use ''Query execute'' or ''Command execute'' button.' + #13 + #10 + #13 + #10 + 'Will use ''Command execute'' when the SQL text contains words like: alter, create, delete, drop, insert, recreate, set, update etc.' );
    Translation__Component__Add( 'Execute__Automatic_Detection_MenuItem', 'Automatically detect ''Query'' or ''Command'' execute' );
    Translation__Component__Add( 'Execute__Selected_MenuItem', 'Execute selected SQL only' );
    Translation__Component__Add( 'Find_MenuItem', 'Find [Ctrl + F]' );
    Translation__Component__Add( 'Highlights__Brackets_MenuItem', 'Brackets highlights' );
    Translation__Component__Add( 'Highlights__Brackets__All_Pairs_MenuItem', 'All pairs' );
    Translation__Component__Add( 'Highlights__Brackets__Angle_MenuItem', '< >' );
    Translation__Component__Add( 'Highlights__Brackets__Curly_MenuItem', '{ }' );
    Translation__Component__Add( 'Highlights__Brackets__Marked_Only_MenuItem', 'Marked only' );
    Translation__Component__Add( 'Highlights__Brackets__Round_MenuItem', '( )' );
    Translation__Component__Add( 'Highlights__Brackets__Square_MenuItem', '[ ]' );
    Translation__Component__Add( 'Highlighter__Syntax_MenuItem', 'Syntax highlighter' );
    Translation__Component__Add( 'Keyboard__Shortcuts__Switch__Output_Save__With__Text_File_Save_MenuItem', 'Switch keyboard shortcuts ''Save query output as csv'' with ''Save file''' );
    Translation__Component__Add( 'Lines_Color__Change_MenuItem', 'Change line color [F6]' );
    Translation__Component__Add( 'Lines_Color__Choose_MenuItem', 'Choose line color [F7]' );
    Translation__Component__Add( 'Lines_Color__Clear__All_MenuItem', 'Clear all lines color [Shift + F5]' );
    Translation__Component__Add( 'Lines_Color__Toggle_MenuItem', 'Toggle line color [F5]' );
    Translation__Component__Add( 'Open_Button', '', 'Query execute.' + #13 + #10 + #13 + #10 + '[Ctrl + E]' );
    Translation__Component__Add( 'Open_MenuItem', 'Query execute [Ctrl + E]' );
    Translation__Component__Add( 'Output_Save_Button', '', 'Save query output as csv.' + #13 + #10 + #13 + #10 + '[Ctrl + S]' );
    Translation__Component__Add( 'Output_Save_MenuItem', 'Save query output as csv [Ctrl + S]' );
    Translation__Component__Add( 'Paste_MenuItem', 'Paste [Ctrl + V]' );
    Translation__Component__Add( 'Query_Output_Save_Field_Format_GroupBox', 'Query output save field format' );
    Translation__Component__Add( 'Query_Output_Save_Field_Format__Date__Use_CheckBox', '', 'Use formatting.' );
    Translation__Component__Add( 'Query_Output_Save_Field_Format__Date_GroupBox', 'Date', 'E.g.:' + #13 + #10 + 'dd.mm.yyyy' + #13 + #10 + 'dd-mm-yyyy' + #13 + #10 + 'yyyy-mm-dd' + #13 + #10 + 'yy mmm ddd' + #13 + #10 + 'd dddd mmmm y' );
    Translation__Component__Add( 'Query_Output_Save_Field_Format__Real_Numbers__Use_CheckBox', '', 'Use formatting.' );
    Translation__Component__Add( 'Query_Output_Save_Field_Format__Real_Numbers_GroupBox', 'Real numbers', 'E.g.:' + #13 + #10 + '### ### ### ### ### ### ##0.###' + #13 + #10 + '0.##############' + #13 + #10 + '### ### ##0.### ### ###' );
    Translation__Component__Add( 'Query_Output_Save_Field_Format__Separator__Date_Time_GroupBox', 'Date time' );
    Translation__Component__Add( 'Query_Output_Save_Field_Format__Separator__Decimal_GroupBox', 'Decimal' );
    Translation__Component__Add( 'Query_Output_Save_Field_Format__Separators_GroupBox', 'Separators' );
    Translation__Component__Add( 'Query_Output_Save_Field_Format__Time__Use_CheckBox', '', 'Use formatting.' );
    Translation__Component__Add( 'Query_Output_Save_Field_Format__Time_GroupBox', 'Time', 'E.g.:' + #13 + #10 + 'hh:mm:ss' + #13 + #10 + 'hh mm ss.zzz' + #13 + #10 + 'h m s am/pm' + #13 + #10 + 'hh-m a/p' );
    Translation__Component__Add( 'Queries_Open_In_Background_MenuItem', 'Queries (some) open in the background' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' + #13 + #10 + #13 + #10 + '[Ctrl + R]' );
    Translation__Component__Add( 'Refresh_MenuItem', 'Refresh [Ctrl + R]' );
    Translation__Component__Add( 'Replace_MenuItem', 'Replace [Ctrl + H]' );
    Translation__Component__Add( 'Search_Edit', '', 'Ctrl + Enter - add all columns sign (*) and add table;' + #13 + #10 + 'Enter - add column / table;' + #13 + #10 + 'Page down - search next;' + #13 + #10 + 'Page up - search prior;' + #13 + #10 + 'Shift + Enter - add all columns.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search_In_RadioGroup', 'Search in', 'Columns list' + #13 + #10 + 'Query output' + #13 + #10 + 'Tables list', 'Col;Que;Tbl;' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' + #13 + #10 + #13 + #10 + '[Ctrl + Enter - add all columns sign (*) and add table]' + #13 + #10 + '[Shift + Enter - add table]' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' + #13 + #10 + #13 + #10 + '[Ctrl + Enter - add all columns sign (*) and add table]' + #13 + #10 + '[Shift + Enter - add table]' );
    Translation__Component__Add( 'Select_All_MenuItem', 'Select all [Ctrl + A]' );
    Translation__Component__Add( 'Sql__Next_Button', '', 'Next SQL text.' + #13 + #10 + #13 + #10 + '[Ctrl + N]' );
    Translation__Component__Add( 'Sql__Next_MenuItem', 'Next SQL text [Ctrl + N]' );
    Translation__Component__Add( 'Sql__Prior_Button', '', 'Prior SQL text.' + #13 + #10 + #13 + #10 + '[Ctrl + P]' );
    Translation__Component__Add( 'Sql__Prior_MenuItem', 'Prior SQL text [Ctrl + P]' );
    Translation__Component__Add( 'Sql_GroupBox', 'SQL' );
    Translation__Component__Add( 'Tab_Name__Set_Button', '', 'Set tab name.' + #13 + #10 + #13 + #10 + '[Enter]' );
    Translation__Component__Add( 'Tab_Name_GroupBox', 'Tab name' );
    Translation__Component__Add( 'Text__File_GroupBox', 'Text file' );
    Translation__Component__Add( 'Text__File__Encoding_ComboBox', '', 'File encoding.' + #13 + #10 + #13 + #10 + 'If empty and file loaded while saving the file will use encoding from the source file.' );
    Translation__Component__Add( 'Text__File__Find_Button', '', 'Find file.' + #13 + #10 + #13 + #10 + '[Ctrl + O]' );
    Translation__Component__Add( 'Text__File__Find_MenuItem', 'Find file [Ctrl + O]' );
    Translation__Component__Add( 'Text__File__Load_Button', '', 'Load file.' + #13 + #10 + #13 + #10 + '[Ctrl + L]' );
    Translation__Component__Add( 'Text__File__Load_MenuItem', 'Load file [Ctrl + L]' );
    Translation__Component__Add( 'Text__File__Path_Edit', '', 'File path.' );
    Translation__Component__Add( 'Text__File__Save_Button', '', 'Save file.' + #13 + #10 + #13 + #10 + 'To ''save file as'' change the ''file path''.' + #13 + #10 + #13 + #10 + '[Ctrl + Shift + S]' );
    Translation__Component__Add( 'Text__File__Save_MenuItem', 'Save file [Ctrl + Shift + S]' );
    Translation__Component__Add( 'Transaction__Begin_Button', '', 'Begin transaction.' );
    Translation__Component__Add( 'Transaction__Begin_MenuItem', 'Begin transaction' );
    Translation__Component__Add( 'Transaction__Commit_Button', '', 'Commit transaction.' );
    Translation__Component__Add( 'Transaction__Commit_MenuItem', 'Commit transaction' );
    Translation__Component__Add( 'Transaction__Rollback_Button', '', 'Rollback transaction.' );
    Translation__Component__Add( 'Transaction__Rollback_MenuItem', 'Rollback transaction' );
    Translation__Component__Add( 'Transactions_Automatic_CheckBox', 'T.', 'Automatically begin transaction (if there is no active transaction) when the SQL text contains words like: delete, insert, update etc.' );
    Translation__Component__Add( 'Transactions_Automatic_MenuItem', 'Automatically begin transaction' );
    Translation__Component__Add( 'Transactions_Count_Label', '<?>', 'Transactions count.' + #13 + #10 + #13 + #10 + 'Does not count the global value, there is only a common transaction.' );

  Translation__Unit__Add( 'TStored_Procedure_Modify_F_Frame' );
    Translation__Component__Add( 'Edit_Execute_TabSheet', 'Edit execute' );
    Translation__Component__Add( 'Dependencies_TabSheet', 'Dependencies' );
    Translation__Component__Add( 'Permissions_TabSheet', 'Permissions' );

  Translation__Unit__Add( 'TStored_Procedure__Edit_Execute_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Close_Button', '', 'Query close.' );
    Translation__Component__Add( 'Edit_In_Modal_View_CheckBox', 'E. modal', 'Edit stored procedure in modal view.' );
    Translation__Component__Add( 'Modify__Edit_Button', '', 'Edit selected stored procedure.' );
    Translation__Component__Add( 'Modify_GroupBox', 'Modify' );
    Translation__Component__Add( 'Open_Button', '', 'Query execute.' + #13 + #10 + #13 + #10 + '[Ctrl + E]' );
    Translation__Component__Add( 'Owner_Etiquette_Label', 'Owner', 'Double-click - copy the stored procedure name to clipboard.' );
    Translation__Component__Add( 'Owner_Label', '<?>', 'Double-click - copy the owner name to clipboard.' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' + #13 + #10 + #13 + #10 + '[Ctrl + R]' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search_In_RadioGroup', 'Search in', 'Output' + #13 + #10 + 'Parameters', 'Output;Param;' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );
    Translation__Component__Add( 'Stored_Procedure__Description__Drop_MenuItem', 'Description delete' );
    Translation__Component__Add( 'Stored_Procedure__Description__Set_MenuItem', 'Description edit' );
    Translation__Component__Add( 'Stored_Procedure__Description_TabSheet', 'Description' );
    Translation__Component__Add( 'Stored_Procedure__Edit_MenuItem', 'Edit' );
    Translation__Component__Add( 'Stored_Procedure__Output_TabSheet', 'Output' );
    Translation__Component__Add( 'Stored_Procedure__Parameter__Description__Drop_MenuItem', 'Parameter description delete' );
    Translation__Component__Add( 'Stored_Procedure__Parameter__Description__Set_MenuItem', 'Parameter description edit' );
    Translation__Component__Add( 'Stored_Procedure__Parameters__Description_GroupBox', 'Parameter description' );
    Translation__Component__Add( 'Stored_Procedure__Parameters_As_Query_Parameters_CheckBox', 'Q. param.', 'Treat stored procedure parameters as query parameters.' );
    Translation__Component__Add( 'Stored_Procedure__Source_TabSheet', 'Source' );

  Translation__Unit__Add( 'TStored_Procedure__Modify_Form' );
    Translation__Component__Add( 'Caption', 'Stored procedure' );
    Translation__Component__Add( 'Close_Button', 'Close' );
    Translation__Component__Add( 'Code_Examples_Button', 'Code', 'Code examples.' );
    Translation__Component__Add( 'Execute_Button', 'Execute', 'Command execute.' + #13 + #10 + #13 + #10 + '[Ctrl + E]' );
    Translation__Component__Add( 'Execute_Button_Works_As_Prepare_Execute_CheckBox', 'P + E', 'Execute button works as Prepare + Execute.' + #13 + #10 + #13 + #10 + '[Ctrl + +]' );
    Translation__Component__Add( 'Log_TabSheet', 'Log' );
    Translation__Component__Add( 'Modify__Parameter__Add_Button', '', 'Add parameter.' );
    Translation__Component__Add( 'Modify__Parameter__Delete_Button', '', 'Delete selected parameter.' );
    Translation__Component__Add( 'Modify__Parameter__Name_Set_Button', '', 'Set selected parameter name.' );
    Translation__Component__Add( 'Parameter__Move__Down_Button', '', 'Move selected parameter down.' );
    Translation__Component__Add( 'Parameter__Move__Up_Button', '', 'Move selected parameter up.' );
    Translation__Component__Add( 'Parameter_Name_Etiquette_Label', 'Parameter name' );
    Translation__Component__Add( 'Sql_Prepare_Button', 'Prepare', 'Command prepare.' + #13 + #10 + #13 + #10 + '[Ctrl + P]' );
    Translation__Component__Add( 'Sql_TabSheet', 'SQL' );
    Translation__Component__Add( 'Stored_Procedure__Name_Etiquette_Label', 'Name' );
    Translation__Component__Add( 'Stored_Procedure__Parameter__Align_Correct_Button', 'a', 'Correct align.' );
    Translation__Component__Add( 'Stored_Procedure__Parameters_GroupBox', 'Parameters' );
    Translation__Component__Add( 'Stored_Procedure__Source_GroupBox', 'Source' );

  Translation__Unit__Add( 'TTable_Add_Form' );
    Translation__Component__Add( 'Caption', 'Table add' );
    Translation__Component__Add( 'Close_Button', 'Close' );
    Translation__Component__Add( 'Column__Add_MenuItem', 'Column add [Insert]' );
    Translation__Component__Add( 'Column__Add_ToolButton', '', 'Column add.' + #13 + #10 + #13 + #10 + '[Insert]' );
    Translation__Component__Add( 'Column__Delete_MenuItem', 'Column delete [Delete]' );
    Translation__Component__Add( 'Column__Delete_ToolButton', '', 'Column delete.' + #13 + #10 + #13 + #10 + '[Delete]' );
    Translation__Component__Add( 'Column__Edit_MenuItem', 'Column name edit [Enter]' );
    Translation__Component__Add( 'Column__Edit_ToolButton', '', 'Column name edit.' + #13 + #10 + #13 + #10 + '[Enter]' );
    Translation__Component__Add( 'Column__Move__Down_MenuItem', 'Column move down' );
    Translation__Component__Add( 'Column__Move__Down_ToolButton', '', 'Column move down.' );
    Translation__Component__Add( 'Column__Move__Up_MenuItem', 'Column move up' );
    Translation__Component__Add( 'Column__Move__Up_ToolButton', '', 'Column move up.' );
    Translation__Component__Add( 'Execute_Button', 'Execute', 'Command execute.' );
    Translation__Component__Add( 'Execute_Button_Works_As_Prepare_Execute_CheckBox', 'P + E', 'Execute button works as Prepare + Execute.' );
    Translation__Component__Add( 'Log_TabSheet', 'Log' );
    Translation__Component__Add( 'Primary_Key__Delete_MenuItem', 'Primary key delete' );
    Translation__Component__Add( 'Primary_Key__Delete_ToolButton', '', 'Primary key delete.' );
    Translation__Component__Add( 'Primary_Key__Set_MenuItem', 'Primary key set' );
    Translation__Component__Add( 'Primary_Key__Set_ToolButton', '', 'Primary key set.' );
    Translation__Component__Add( 'Sql_Prepare_Button', 'Prepare', 'Command prepare.' );
    Translation__Component__Add( 'Sql_TabSheet', 'SQL' );
    Translation__Component__Add( 'Table_Name_Etiquette_Label', 'Name' );

  Translation__Unit__Add( 'TTable_Column__Modify_Form' );
    Translation__Component__Add( 'Caption', 'Column' );
    Translation__Component__Add( 'Close_Button', 'Close' );
    Translation__Component__Add( 'Collate_Etiquette_Label', 'Collate' );
    Translation__Component__Add( 'Column_Name_Etiquette_Label', 'Name' );
    Translation__Component__Add( 'Column_Position_CheckBox', 'Set' );
    Translation__Component__Add( 'Column_Position_GroupBox', 'Position' );
    Translation__Component__Add( 'Column_Type_Etiquette_Label', 'Type' );
    Translation__Component__Add( 'Default_Value_CheckBox', 'Set' );
    Translation__Component__Add( 'Default_Value_GroupBox', 'Default value' );
    Translation__Component__Add( 'Execute_Button', 'Execute', 'Command execute.' );
    Translation__Component__Add( 'Execute_Button_Works_As_Prepare_Execute_CheckBox', 'P + E', 'Execute button works as Prepare + Execute.' );
    Translation__Component__Add( 'Log_TabSheet', 'Log' );
    Translation__Component__Add( 'Not_Null_CheckBox', 'Not null' );
    Translation__Component__Add( 'Ok_Button', 'OK' );
    Translation__Component__Add( 'Sql_Prepare_Button', 'Prepare', 'Command prepare.' );
    Translation__Component__Add( 'Sql_TabSheet', 'SQL' );

  Translation__Unit__Add( 'TTable_Column__Values_Distinct_Form' );
    Translation__Component__Add( 'Caption', 'Column distinct values' );
    Translation__Component__Add( 'Close_Button', '', 'Close.' + #13 + #10 + #13 + #10 + '[Esc]' );
    Translation__Component__Add( 'Ok_Button', '', 'Select value.' + #13 + #10 + #13 + #10 + '[Enter]' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' + #13 + #10 + #13 + #10 + '[Ctrl + R]' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );

  Translation__Unit__Add( 'TTable_Modify_F_Frame' );
    Translation__Component__Add( 'Data_TabSheet', 'Data' );
    Translation__Component__Add( 'Indexes_TabSheet', 'Indexes' );
    Translation__Component__Add( 'Metadata_TabSheet', 'Metadata' );
    Translation__Component__Add( 'Columns_Sort_TabSheet', 'Columns sort' );
    Translation__Component__Add( 'Dependencies_TabSheet', 'Dependencies' );
    Translation__Component__Add( 'Permissions_TabSheet', 'Permissions' );
    Translation__Component__Add( 'Triggers_TabSheet', 'Triggers' );

  Translation__Unit__Add( 'TTable__Columns_Sort_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Columns_Sort_ListView', '', '', 'Column name;Column position;' );
    Translation__Component__Add( 'Execute_Button', '', 'Save changes.' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' );
    Translation__Component__Add( 'Sort_Button', '', 'Sort columns.' );

  Translation__Unit__Add( 'TTable__Data_Modify_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Data_Filter_TabSheet', 'Filter' );
    Translation__Component__Add( 'Data_Filter__Activate__All_Button', '', 'Activate all filters.' + #13 + #10 + #13 + #10 + '[Enter]' );
    Translation__Component__Add( 'Data_Filter__Add_Button', '', 'Add filter.' + #13 + #10 + #13 + #10 + '[Ctrl + F]' );
    Translation__Component__Add( 'Data_Filter__Buttons_GroupBox', 'Filter' );
    Translation__Component__Add( 'Data_Filter__Deactivate__All_Button', '', 'Deactivate all filters.' + #13 + #10 + #13 + #10 + '[Ctrl + Enter]' );
    Translation__Component__Add( 'Data_Filter__Delete__All_Button', '', 'Delete all filters.' );
    Translation__Component__Add( 'Data_Filter__Show_Button', '', 'Show filter value in log.' );
    Translation__Component__Add( 'Data_Preview_TabSheet', 'Preview' );
    Translation__Component__Add( 'Data_Value_Format__Disabled_CheckBox', 'Data value format disabled' );
    Translation__Component__Add( 'Delete_Visible_Records_Button', '', 'Delete visible records.' );
    Translation__Component__Add( 'Duplicate_Record_Button', '', 'Duplicate record.' );
    Translation__Component__Add( 'Editing_CheckBox', 'Editing', 'Allow data changes.' );
    Translation__Component__Add( 'Extract_Table_Data_Button', '', 'Extract table data to log / file.' );
    Translation__Component__Add( 'First_Rows_Etiquette_Label', 'First rows', 'Display first <value> rows only.' + #13 + #10 + 'Negative value = disabled.' );
    Translation__Component__Add( 'First_Rows_SpinEdit', '', 'Ctrl + N - negate value;' + #13 + #10 + 'Ctrl + O - open.' );
    Translation__Component__Add( 'Grid_View_CheckBox', 'Grid view', 'Switch grid / form view.' );
    Translation__Component__Add( 'Height_Keeper_Label', '^- height keeper -v' );
    Translation__Component__Add( 'Open_Close_Button', '', 'Open.' + #13 + #10 + #13 + #10 + '[Ctrl + O]' );
    Translation__Component__Add( 'Primary_Key_Value_Etiquette_Label', 'Primary key value (probably)' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' + #13 + #10 + #13 + #10 + '[Ctrl + R]' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );
    Translation__Component__Add( 'Table_Column__Values_Distinct_Button', '', 'Column distinct values.' + #13 + #10 + #13 + #10 + '[Ctrl + D]' );
    Translation__Component__Add( 'Width_Keeper_Label', '<-- width keeper -->' );
    Translation__Component__Add( 'Width_Keeper__Move__Left_Button', '', 'Move the width keeper left.' );
    Translation__Component__Add( 'Width_Keeper__Move__Right_Button', '', 'Move the width keeper right.' );

  Translation__Unit__Add( 'TTable__Indexes_Modify_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Index_Name_Etiquette_Label', 'Index name' );
    Translation__Component__Add( 'Index__Delete_MenuItem', 'Delete' );
    Translation__Component__Add( 'Index__Description__Drop_MenuItem', 'Description delete' );
    Translation__Component__Add( 'Index__Description__Set_MenuItem', 'Description edit' );
    Translation__Component__Add( 'Index__Description__Write_In_Log_MenuItem', 'Index description write in log' );
    Translation__Component__Add( 'Modify_GroupBox', 'Modify' );
    Translation__Component__Add( 'Modify__Add_Button', '', 'Add new index <name>.' );
    Translation__Component__Add( 'Modify__Columns_Name__Hide_Indexed_CheckBox', 'Hide', 'Hide indexed columns.' );
    Translation__Component__Add( 'Modify__Columns_Name_CheckListBox', '', 'Enter - add new index' + #13 + #10 + 'Ctrl + A - select all' + #13 + #10 + 'Ctrl + D - create default index name' + #13 + #10 + 'Ctrl + I - invert selection' + #13 + #10 + 'Ctrl + N - unselect all' );
    Translation__Component__Add( 'Modify__Columns_Name_Etiquette_Label', 'Columns' );
    Translation__Component__Add( 'Modify__Delete_Button', '', 'Delete selected index.' + #13 + #10 + #13 + #10 + '[Delete]' );
    Translation__Component__Add( 'Modify__Name_Etiquette_Label', 'Name' );
    Translation__Component__Add( 'Modify__Name__Create_Default_Button', 'D.', 'Create default index name.' );
    Translation__Component__Add( 'Modify__Parameter_Additional_Etiquette_Label', 'Additional parameter' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );

  Translation__Unit__Add( 'TTable__Metadata_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Column__Add_MenuItem', 'Column add [Insert]' );
    Translation__Component__Add( 'Column__Default_Value__Drop_MenuItem', 'Column default value delete' );
    Translation__Component__Add( 'Column__Default_Value__Set_MenuItem', 'Column default value edit' );
    Translation__Component__Add( 'Column__Delete_MenuItem', 'Column delete [Delete]' );
    Translation__Component__Add( 'Column__Description__Drop_MenuItem', 'Column description delete' );
    Translation__Component__Add( 'Column__Description__Set_MenuItem', 'Column description edit' );
    Translation__Component__Add( 'Column__Description__Write_In_Log_MenuItem', 'Column description write in log' );
    Translation__Component__Add( 'Column__Name_Edit_MenuItem', 'Column name edit [Ctrl + Enter]' );
    Translation__Component__Add( 'Column__Not_Null__Add_MenuItem', 'Column not null add' );
    Translation__Component__Add( 'Column__Not_Null__Delete_MenuItem', 'Column not null delete' );
    Translation__Component__Add( 'Column__Type_Edit_MenuItem', 'Column type edit [Enter]' );
    Translation__Component__Add( 'Metadata__Write_In_Log__As_Create_Table_MenuItem', 'Metadata write in log as create table' );
    Translation__Component__Add( 'Metadata__Write_In_Log_MenuItem', 'Metadata write in log' );
    Translation__Component__Add( 'Owner_Etiquette_Label', 'Owner', 'Double-click - copy the table name to clipboard.' );
    Translation__Component__Add( 'Owner_Label', '<?>', 'Double-click - copy the owner name to clipboard.' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );
    Translation__Component__Add( 'Table_Column__Values_Distinct_MenuItem', 'Column distinct values' );
    Translation__Component__Add( 'Table_Description_GroupBox', 'Table description' );
    Translation__Component__Add( 'Table__Description__Drop_MenuItem', 'Table description delete' );
    Translation__Component__Add( 'Table__Description__Set_MenuItem', 'Table description edit' );
    Translation__Component__Add( 'Table__Primary_Key_Set_MenuItem', 'Table primary key set' );

  Translation__Unit__Add( 'TTable__Trigger_Modify_Form' );
    Translation__Component__Add( 'Caption', 'Trigger - table' );
    Translation__Component__Add( 'Close_Button', 'Close' );
    Translation__Component__Add( 'Code_Examples_Button', 'Code', 'Code examples.' );
    Translation__Component__Add( 'Execute_Button', 'Execute', 'Command execute.' + #13 + #10 + #13 + #10 + '[Ctrl + E]' );
    Translation__Component__Add( 'Execute_Button_Works_As_Prepare_Execute_CheckBox', 'P + E', 'Execute button works as Prepare + Execute.' + #13 + #10 + #13 + #10 + '[Ctrl + +]' );
    Translation__Component__Add( 'Log_TabSheet', 'Log' );
    Translation__Component__Add( 'Sql_Prepare_Button', 'Prepare', 'Command prepare.' + #13 + #10 + #13 + #10 + '[Ctrl + P]' );
    Translation__Component__Add( 'Sql_TabSheet', 'SQL' );
    Translation__Component__Add( 'Trigger_Activity_Etiquette_Label', 'Activity', 'active - active' + #13 + #10 + 'inactive - inactive.' );
    Translation__Component__Add( 'Trigger_Events_CheckListBox', '', 'Ctrl + A - select all' + #13 + #10 + 'Ctrl + I - invert selection' + #13 + #10 + 'Ctrl + N - unselect all' );
    Translation__Component__Add( 'Trigger_Events_GroupBox', 'Events' );
    Translation__Component__Add( 'Trigger_Name_Etiquette_Label', 'Name' );
    Translation__Component__Add( 'Trigger_Sequence_Etiquette_Label', 'Sequence' );
    Translation__Component__Add( 'Trigger_Source_Etiquette_Label', 'Source', 'as' + #13 + #10 + 'BEGIN' + #13 + #10 + #13 + #10 + '  /* Code here. */' + #13 + #10 + #13 + #10 + 'END' );
    Translation__Component__Add( 'Trigger_Type_Etiquette_Label', 'Type' );

  Translation__Unit__Add( 'TText__Edit_Memo_Form' );
    Translation__Component__Add( 'Caption', 'Text edit' );
    Translation__Component__Add( 'Cancel_Button', 'Cancel' );
    Translation__Component__Add( 'Hint_Button', '', 'Hint.' );
    Translation__Component__Add( 'Ok_Button', 'OK' );
    Translation__Component__Add( 'Use_RadioGroup', 'Use', 'Use the value from the ''edit'' or ''memo''.' );

  Translation__Unit__Add( 'TText__Search_Replace_Form' );
    Translation__Component__Add( 'Caption', 'Search' );
    Translation__Component__Add( 'Replace_Button', '', 'Replace.' );
    Translation__Component__Add( 'Replace_Etiquette_Label', 'Replace' );
    Translation__Component__Add( 'Replace__All_Button', '', 'Replace all.' );
    Translation__Component__Add( 'Replace__Prompt_CheckBox', 'Prompt', 'Replace prompt.' );
    Translation__Component__Add( 'Search_Etiquette_Label', 'Search' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Close_Button', '', 'Close.' );
    Translation__Component__Add( 'Search__Direction_RadioGroup', 'Direction', '', 'Backward;Forward;' );
    Translation__Component__Add( 'Search__Find_Next_Button', '', 'Find next.' );
    Translation__Component__Add( 'Search__From_Cursor_CheckBox', 'Search from cursor' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Regular_Expression_CheckBox', 'Regular expression' );
    Translation__Component__Add( 'Search__Selected_Text_Only_CheckBox', 'Selected text only' );

  Translation__Unit__Add( 'TText__Search_Replace__Prompt_Form' );
    Translation__Component__Add( 'Caption', 'Confirm' );
    Translation__Component__Add( 'Cancel_Button', '', 'Cancel.' + #13 + #10 + #13 + #10 + '[Backspace]' );
    Translation__Component__Add( 'No_Button', '', 'No.' + #13 + #10 + #13 + #10 + '[Esc]' );
    Translation__Component__Add( 'Yes_Button', '', 'Yes.' );
    Translation__Component__Add( 'Yes_To_All_Button', '', 'Yes to all.' + #13 + #10 + #13 + #10 + '[A]' );

  Translation__Unit__Add( 'TTriggers_Modify_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Modify_GroupBox', 'Modify' );
    Translation__Component__Add( 'Modify__Add_Button', '', 'Add new trigger.' + #13 + #10 + #13 + #10 + '[Insert]' );
    Translation__Component__Add( 'Modify__Delete_Button', '', 'Delete selected trigger.' + #13 + #10 + #13 + #10 + '[Delete]' );
    Translation__Component__Add( 'Modify__Edit_Button', '', 'Edit selected trigger.' + #13 + #10 + #13 + #10 + '[Enter]' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' + #13 + #10 + #13 + #10 + '[Ctrl + R]' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );
    Translation__Component__Add( 'Trigger_Name_Etiquette_Label', 'Trigger name' );
    Translation__Component__Add( 'Trigger_Source_GroupBox', 'Trigger source' );
    Translation__Component__Add( 'Trigger__Add_MenuItem', 'Add' );
    Translation__Component__Add( 'Trigger__Delete_MenuItem', 'Delete' );
    Translation__Component__Add( 'Trigger__Description__Drop_MenuItem', 'Description delete' );
    Translation__Component__Add( 'Trigger__Description__Set_MenuItem', 'Description edit' );
    Translation__Component__Add( 'Trigger__Description__Write_In_Log_MenuItem', 'Trigger description write in log' );
    Translation__Component__Add( 'Trigger__Edit_MenuItem', 'Edit' );

  Translation__Unit__Add( 'TUsers_Modify_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Modify_GroupBox', 'Modify' );
    Translation__Component__Add( 'Modify__Active_CheckBox', 'Active' );
    Translation__Component__Add( 'Modify__Add_Button', '', 'Add new user <name> <values>.' );
    Translation__Component__Add( 'Modify__Administrator_CheckBox', 'Administrator', 'Checked - grant admin role.' + #13 + #10 + 'Unchecked - revoke admin role.' );
    Translation__Component__Add( 'Modify__Administrator_GroupBox', 'Administrator' );
    Translation__Component__Add( 'Modify__Administrator__Change_CheckBox', '', 'Checked - set value.' );
    Translation__Component__Add( 'Modify__Delete_Button', '', 'Delete selected user.' + #13 + #10 + #13 + #10 + '[Delete]' );
    Translation__Component__Add( 'Modify__Edit_Button', '', 'Set <values> to selected user.' + #13 + #10 + #13 + #10 + '[Enter]' );
    Translation__Component__Add( 'Modify__Name_Etiquette_Label', 'Name' );
    Translation__Component__Add( 'Modify__Name__First_CheckBox', '', 'Checked - set value.' );
    Translation__Component__Add( 'Modify__Name__First_GroupBox', 'First name' );
    Translation__Component__Add( 'Modify__Name__Last_CheckBox', '', 'Checked - set value.' );
    Translation__Component__Add( 'Modify__Name__Last_GroupBox', 'Last name' );
    Translation__Component__Add( 'Modify__Name__Middle_CheckBox', '', 'Checked - set value.' );
    Translation__Component__Add( 'Modify__Name__Middle_GroupBox', 'Middle name' );
    Translation__Component__Add( 'Modify__Password_CheckBox', '', 'Checked - set value.' );
    Translation__Component__Add( 'Modify__Password_GroupBox', 'Password' );
    Translation__Component__Add( 'Modify__Select_All_Button', '+', 'Select all.' );
    Translation__Component__Add( 'Modify__Unselect_All_Button', '-', 'Unselect all.' );
    Translation__Component__Add( 'Modify__Values_Fields__Update_CheckBox', 'V. u.', 'Update values in the value fields.' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' + #13 + #10 + #13 + #10 + '[Ctrl + R]' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );
    Translation__Component__Add( 'User_Name_Etiquette_Label', 'User name' );
    Translation__Component__Add( 'User__Delete_MenuItem', 'Delete' );
    Translation__Component__Add( 'User__Description__Drop_MenuItem', 'Description delete' );
    Translation__Component__Add( 'User__Description__Set_MenuItem', 'Description edit' );
    Translation__Component__Add( 'User__Description__Write_In_Log_MenuItem', 'User description write in log' );

  Translation__Unit__Add( 'TView_Modify_F_Frame' );
    Translation__Component__Add( 'Permissions_TabSheet', 'Permissions' );
    Translation__Component__Add( 'Dependencies_TabSheet', 'Dependencies' );
    Translation__Component__Add( 'Edit_Execute_TabSheet', 'Edit execute' );

  Translation__Unit__Add( 'TView__Edit_Execute_F_Frame' );
    Translation__Component__Add( 'Buttons_Panel__Hide_Button', '', 'Hide panel.' );
    Translation__Component__Add( 'Close_Button', '', 'Query close.' );
    Translation__Component__Add( 'Edit_In_Modal_View_CheckBox', 'E. modal', 'Edit view in modal view.' );
    Translation__Component__Add( 'Modify__Edit_Button', '', 'Edit selected view.' );
    Translation__Component__Add( 'Modify_GroupBox', 'Modify' );
    Translation__Component__Add( 'Open_Button', '', 'Query execute.' + #13 + #10 + #13 + #10 + '[Ctrl + E]' );
    Translation__Component__Add( 'Owner_Etiquette_Label', 'Owner', 'Double-click - copy the view name to clipboard.' );
    Translation__Component__Add( 'Owner_Label', '<?>', 'Double-click - copy the owner name to clipboard.' );
    Translation__Component__Add( 'Refresh_Button', '', 'Refresh.' + #13 + #10 + #13 + #10 + '[Ctrl + R]' );
    Translation__Component__Add( 'Search_Edit', '', 'Page down - search next;' + #13 + #10 + 'Page up - search prior.' );
    Translation__Component__Add( 'Search_GroupBox', 'Search' );
    Translation__Component__Add( 'Search_In_RadioGroup', 'Search in', 'Output' + #13 + #10 + 'Parameters', 'Output;Param;' );
    Translation__Component__Add( 'Search__Case_Insensitive_CheckBox', 'Case insensitive' );
    Translation__Component__Add( 'Search__Next_Button', '', 'Search next.' );
    Translation__Component__Add( 'Search__Partial_Key_CheckBox', 'Partial key' );
    Translation__Component__Add( 'Search__Prior_Button', '', 'Search prior.' );
    Translation__Component__Add( 'View__Description__Drop_MenuItem', 'Description delete' );
    Translation__Component__Add( 'View__Description__Set_MenuItem', 'Description edit' );
    Translation__Component__Add( 'View__Description_TabSheet', 'Description' );
    Translation__Component__Add( 'View__Edit_MenuItem', 'Edit' );
    Translation__Component__Add( 'View__Output_TabSheet', 'Output' );
    Translation__Component__Add( 'View__Parameter__Description__Drop_MenuItem', 'Parameter description delete' );
    Translation__Component__Add( 'View__Parameter__Description__Set_MenuItem', 'Parameter description edit' );
    Translation__Component__Add( 'View__Parameters__Description_GroupBox', 'Parameter description' );
    Translation__Component__Add( 'View__Source_TabSheet', 'Source' );

  Translation__Unit__Add( 'TView__Modify_Form' );
    Translation__Component__Add( 'Caption', 'View' );
    Translation__Component__Add( 'Close_Button', 'Close' );
    Translation__Component__Add( 'Code_Examples_Button', 'Code', 'Code examples.' );
    Translation__Component__Add( 'Execute_Button', 'Execute', 'Command execute.' + #13 + #10 + #13 + #10 + '[Ctrl + E]' );
    Translation__Component__Add( 'Execute_Button_Works_As_Prepare_Execute_CheckBox', 'P + E', 'Execute button works as Prepare + Execute.' + #13 + #10 + #13 + #10 + '[Ctrl + +]' );
    Translation__Component__Add( 'Log_TabSheet', 'Log' );
    Translation__Component__Add( 'Modify__Parameter__Add_Button', '', 'Add parameter.' );
    Translation__Component__Add( 'Modify__Parameter__Delete_Button', '', 'Delete selected parameter.' );
    Translation__Component__Add( 'Modify__Parameter__Name_Set_Button', '', 'Set selected parameter name.' );
    Translation__Component__Add( 'Parameter__Move__Down_Button', '', 'Move selected parameter down.' );
    Translation__Component__Add( 'Parameter__Move__Up_Button', '', 'Move selected parameter up.' );
    Translation__Component__Add( 'Parameter_Name_Etiquette_Label', 'Parameter name' );
    Translation__Component__Add( 'Sql_Prepare_Button', 'Prepare', 'Command prepare.' + #13 + #10 + #13 + #10 + '[Ctrl + P]' );
    Translation__Component__Add( 'Sql_TabSheet', 'SQL' );
    Translation__Component__Add( 'View_Name_Etiquette_Label', 'Name' );
    Translation__Component__Add( 'View_Parameters_GroupBox', 'Parameters' );
    Translation__Component__Add( 'View_Source_GroupBox', 'Source' );
    Translation__Component__Add( 'View__Parameter__Align_Correct_Button', 'a', 'Correct align.' );
  {$endregion 'Visual components.'}

  {$region 'translation__messages_r.'}
  translation__messages_r.add_exception := 'Add exception';
  translation__messages_r.add_generator := 'Add generator';
  translation__messages_r.add_index_on_columns__1 := 'Add index';
  translation__messages_r.add_index_on_columns__2 := 'on columns';
  translation__messages_r.add_role := 'Add role';
  translation__messages_r.add_the_column_not_null_attribute := 'Add the column ''not null'' attribute';
  translation__messages_r.add_user := 'Add user';
  translation__messages_r.alias_should_not_be_empty := 'Alias should not be empty.';
  translation__messages_r.all_files := 'All files';
  translation__messages_r.application_files := 'Application files';
  translation__messages_r.automatically_block_execute_detection_words_list := 'Automatically block execute detection words list:';
  translation__messages_r.automatically_execute_detection_words_list := 'Automatically command execute detection words list:';
  translation__messages_r.automatically_transaction_begining_words_list := 'Automatically transaction begining words list:';
  translation__messages_r.backup_file_path_should_not_be_empty := 'Backup file path should not be empty.';
  translation__messages_r.caret_position_label__hint := 'Caret position, text length.';
  translation__messages_r.clear_all_lines_color_ := 'Clear all lines color?';
  translation__messages_r.close_all_connections_ := 'Close all connections?';
  translation__messages_r.code_completion__column := 'column';
  translation__messages_r.code_completion__sql := 'sql';
  translation__messages_r.code_completion__stored_procedure := 'stored procedure';
  translation__messages_r.code_completion__table := 'table';
  translation__messages_r.code_completion__trigger := 'trigger';
  translation__messages_r.column_name_should_not_be_empty := 'Column name should not be empty.';
  translation__messages_r.column_names_should_be_unique := 'Column names should be unique.';
  translation__messages_r.column_type_should_not_be_empty := 'Column type should not be empty.';
  translation__messages_r.columns_must_be_selected := 'Columns must be selected.';
  translation__messages_r.confirmation := 'Confirmation';
  translation__messages_r.connection_successful := 'Connection successful.';
  translation__messages_r.continue_ := 'Continue?';
  translation__messages_r.csv_files := 'Csv files';
  translation__messages_r.database_create_application_file_path_should_not_be_empty := 'Database create application file path should not be empty.';
  translation__messages_r.database_create__hint__ib_database := 'It may be better to create a database using ''IBDatabase component'' in the 32 bit version of this application (SDBM x32).';
  translation__messages_r.database_create__hint__isql :=
    'To create a database using isql.exe, run the command line (cmd.exe) and from there run the isql.exe program, e.g. with the following command:' + #13 + #10 +
    #13 + #10 +
    '"C:\Program Files\Firebird\isql.exe"' + #13 + #10 +
    #13 + #10 +
    #13 + #10 +
    'If the isql.exe program starts correctly, a prompt should appear at the beginning of the line:' + #13 + #10 +
    #13 + #10 +
    'SQL>' + #13 + #10 +
    #13 + #10 +
    #13 + #10 +
    'Type or paste the command to create a database (and confirm with the Enter key) e.g.:' + #13 + #10 +
    #13 + #10 +
    'create database "C:database_file.fdb" user SYSDBA password ''masterkey'' page_size 8192;' + #13 + #10 +
    #13 + #10 +
    #13 + #10 +
    'To exit type:' + #13 + #10 +
    #13 + #10 +
    'exit;' + #13 + #10 +
    #13 + #10 +
    'and confirm with the Enter key.' + #13 + #10 +
    #13 + #10 +
    #13 + #10 +
    'It is possible that the commands for setting the default character set will not work.' + #13 + #10 +
    #13 + #10 +
    #13 + #10 +
    'If the prompt appears:' + #13 + #10 +
    #13 + #10 +
    'CON>' + #13 + #10 +
    #13 + #10 +
    'enter e.g.:' + #13 + #10 +
    #13 + #10 +
    'user SYSDBA password ''masterkey'';';
  translation__messages_r.database_create__hint__sql :=
    'To create a database using the SQL command, connect to a database, go to the SQL editor and execute the command, e.g.:' + #13 + #10 +
    #13 + #10 +
    'create database ''C:\F1\database_file.fdb''' + #13 + #10 +
    'user SYSDBA password ''masterkey''' + #13 + #10 +
    'page_size 8192' + #13 + #10 +
    'default character set WIN1250' + #13 + #10 +
    'collation PXW_PLK';
  translation__messages_r.database_file_path_should_not_be_empty := 'Database file path should not be empty.';
  translation__messages_r.database_type_should_not_be_empty := 'Database type should not be empty.';
  translation__messages_r.databases_list_changed__save_ := 'Databases list changed.' + #13 + #13 + 'Save?';
  translation__messages_r.default := 'default';
  translation__messages_r.default__with_a_capital_letter := 'Default';
  translation__messages_r.delete_exception := 'Delete exception';
  translation__messages_r.delete_external_function := 'Delete external function';
  translation__messages_r.delete_generator := 'Delete generator';
  translation__messages_r.delete_index := 'Delete index';
  translation__messages_r.delete_role := 'Delete role';
  translation__messages_r.delete_selected_parameter_ := 'Delete selected parameter?';
  translation__messages_r.delete_stored_procedure := 'Delete stored procedure';
  translation__messages_r.delete_table := 'Delete table';
  translation__messages_r.delete_the_column := 'Delete the column';
  translation__messages_r.delete_the_column_default_value := 'Delete the column default value';
  translation__messages_r.delete_the_column_description := 'Delete the column description';
  translation__messages_r.delete_the_column_not_null_attribute := 'Delete the column ''not null'' attribute';
  translation__messages_r.delete_the_database_description_ := 'Delete the database description?';
  translation__messages_r.delete_the_database_from_the_list_ := 'Delete the database from the list?';
  translation__messages_r.delete_the_exception_description := 'Delete the exception description';
  translation__messages_r.delete_the_external_function_description := 'Delete the external function description';
  translation__messages_r.delete_the_generator_description := 'Delete the generator description';
  translation__messages_r.delete_the_index_description := 'Delete the index description';
  translation__messages_r.delete_the_role_description := 'Delete the role description';
  translation__messages_r.delete_the_stored_procedure_description := 'Delete the stored procedure description';
  translation__messages_r.delete_the_stored_procedure_parameter_description := 'Delete the stored procedure parameter description';
  translation__messages_r.delete_the_table_description := 'Delete the table description';
  translation__messages_r.delete_the_trigger_description := 'Delete the trigger description';
  translation__messages_r.delete_the_user_description := 'Delete the user description';
  translation__messages_r.delete_the_view_description := 'Delete the view description';
  translation__messages_r.delete_the_view_parameter_description := 'Delete the view parameter description';
  translation__messages_r.delete_user := 'Delete user';
  translation__messages_r.delete_trigger := 'Delete trigger';
  translation__messages_r.delete_view := 'Delete view';
  translation__messages_r.delete_visible_records_ := 'Delete visible records?';
  translation__messages_r.depended_on_type := 'Depended on type';
  translation__messages_r.depended_type := 'Depended type';
  translation__messages_r.dependencies__items_ := 'Dependencies (items)';
  translation__messages_r.dependencies__nodes_ := 'Dependencies (nodes)';
  translation__messages_r.directory_does_not_exist := 'Directory does not exist';
  translation__messages_r.done := 'Done.';
  translation__messages_r.drop_privileges_from_role := 'Drop privileges from role';
  translation__messages_r.error := 'Error';
  translation__messages_r.errors_were_encountered := 'Errors were encountered.';
  translation__messages_r.exception_message_should_not_be_empty := 'Exception message should not be empty.';
  translation__messages_r.exception_name_should_not_be_empty := 'Exception name should not be empty.';
  translation__messages_r.exit_ := 'Exit?';
  translation__messages_r.external_function_entry_point_should_not_be_empty := 'External function entry point should not be empty.';
  translation__messages_r.external_function_module__library__name_should_not_be_empty := 'External function module (library) name should not be empty.';
  translation__messages_r.external_function_name_should_not_be_empty := 'External function name should not be empty.';
  translation__messages_r.failed_to_add_exception := 'Failed to add exception:';
  translation__messages_r.failed_to_add_generator := 'Failed to add generator:';
  translation__messages_r.failed_to_add_index := 'Failed to add index:';
  translation__messages_r.failed_to_add_role := 'Failed to add role:';
  translation__messages_r.failed_to_add_the_column_not_null_attribute := 'Failed to add the column ''not null'' attribute:';
  translation__messages_r.failed_to_add_user := 'Failed to add user:';
  translation__messages_r.failed_to_copy_value_to_clipboard := 'Failed to copy value to clipboard.';
  translation__messages_r.failed_to_create_database := 'Failed to create database:';
  translation__messages_r.failed_to_create_table := 'Failed to create table:';
  translation__messages_r.failed_to_delete_exception := 'Failed to delete exception:';
  translation__messages_r.failed_to_delete_external_function := 'Failed to delete external function:';
  translation__messages_r.failed_to_delete_generator := 'Failed to delete generator:';
  translation__messages_r.failed_to_delete_index := 'Failed to delete index:';
  translation__messages_r.failed_to_delete_role := 'Failed to delete role:';
  translation__messages_r.failed_to_delete_stored_procedure_ := 'Failed to delete stored procedure:';
  translation__messages_r.failed_to_delete_table_ := 'Failed to delete table:';
  translation__messages_r.failed_to_delete_the_column := 'Failed to delete the column:';
  translation__messages_r.failed_to_delete_the_column_default_value := 'Failed to delete the column default value:';
  translation__messages_r.failed_to_delete_the_column_description := 'Failed to delete the column description:';
  translation__messages_r.failed_to_delete_the_column_not_null_attribute := 'Failed to delete the column ''not null'' attribute:';
  translation__messages_r.failed_to_delete_the_database_description := 'Failed to delete the database description:';
  translation__messages_r.failed_to_delete_the_exception_description := 'Failed to delete the exception description:';
  translation__messages_r.failed_to_delete_the_external_function_description := 'Failed to delete the external function description:';
  translation__messages_r.failed_to_delete_the_generator_description := 'Failed to delete the generator description:';
  translation__messages_r.failed_to_delete_the_index_description := 'Failed to delete the index description:';
  translation__messages_r.failed_to_delete_the_role_description := 'Failed to delete the role description:';
  translation__messages_r.failed_to_delete_the_stored_procedure_description := 'Failed to delete the stored procedure description:';
  translation__messages_r.failed_to_delete_the_stored_procedure_parameter_description := 'Failed to delete the stored procedure parameter description:';
  translation__messages_r.failed_to_delete_the_table_description := 'Failed to delete the table description:';
  translation__messages_r.failed_to_delete_the_trigger_description := 'Failed to delete the trigger description:';
  translation__messages_r.failed_to_delete_the_user_description := 'Failed to delete the user description:';
  translation__messages_r.failed_to_delete_the_view_description := 'Failed to delete the view description:';
  translation__messages_r.failed_to_delete_the_view_parameter_description := 'Failed to delete the view parameter description:';
  translation__messages_r.failed_to_delete_trigger := 'Failed to delete trigger:';
  translation__messages_r.failed_to_delete_user := 'Failed to delete user:';
  translation__messages_r.failed_to_delete_view_ := 'Failed to delete view:';
  translation__messages_r.failed_to_drop_privileges_from_role := 'Failed to drop privileges from role:';
  translation__messages_r.failed_to_execute_command := 'Failed to execute command.';
  translation__messages_r.failed_to_grant_privileges := 'Failed to grant privileges:';
  translation__messages_r.failed_to_load_columns_list := 'Failed to load columns list:';
  translation__messages_r.failed_to_load_dependencies_list := 'Failed to load dependencies list:';
  translation__messages_r.failed_to_load_stored_procedures_list_ := 'Failed to load stored procedures list:';
  translation__messages_r.failed_to_load_tables_list_ := 'Failed to load tables list:';
  translation__messages_r.failed_to_load_the_file := 'Failed to load the file:';
  translation__messages_r.failed_to_load_views_list_ := 'Failed to load views list:';
  translation__messages_r.failed_to_modify_column := 'Failed to modify column:';
  translation__messages_r.failed_to_modify_external_function := 'Failed to modify external function:';
  translation__messages_r.failed_to_modify_stored_procedure := 'Failed to modify stored procedure:';
  translation__messages_r.failed_to_modify_trigger := 'Failed to modify trigger:';
  translation__messages_r.failed_to_modify_view := 'Failed to modify view:';
  translation__messages_r.failed_to_open_collates_list := 'Failed to open collates list:';
  translation__messages_r.failed_to_open_columns_list := 'Failed to open columns list:';
  translation__messages_r.failed_to_open_database_connection__ADO_ := 'Failed to open database connection (ADO):';
  translation__messages_r.failed_to_open_database_connection__FireDAC__ := 'Failed to open database connection (FireDAC):';
  translation__messages_r.failed_to_open_database_description := 'Failed to open database description:';
  translation__messages_r.failed_to_open_database_informations := 'Failed to open database informations:';
  translation__messages_r.failed_to_open_exceptions_list := 'Failed to open exceptions list:';
  translation__messages_r.failed_to_open_external_function_data := 'Failed to open external function data:';
  translation__messages_r.failed_to_open_external_functions_list := 'Failed to open external functions list:';
  translation__messages_r.failed_to_open_generator_description := 'Failed to open generator description:';
  translation__messages_r.failed_to_open_generators_list := 'Failed to open generators list:';
  translation__messages_r.failed_to_open_indexes_list := 'Failed to open indexes list:';
  translation__messages_r.failed_to_open_parameters_list := 'Failed to open parameters list:';
  translation__messages_r.failed_to_open_permissions_list := 'Failed to open permissions list:';
  translation__messages_r.failed_to_open_primary_key_name := 'Failed to open primary key name:';
  translation__messages_r.failed_to_open_query := 'Failed to open query.';
  translation__messages_r.failed_to_open_stored_procedure_data := 'Failed to open stored procedure data:';
  translation__messages_r.failed_to_open_stored_procedure_metadata := 'Failed to open stored procedure metadata:';
  translation__messages_r.failed_to_open_roles_list := 'Failed to open roles list:';
  translation__messages_r.failed_to_open_table := 'Failed to open table.';
  translation__messages_r.failed_to_open_table_description := 'Failed to open table description:';
  translation__messages_r.failed_to_open_table_owner_name := 'Failed to open table owner name:';
  translation__messages_r.failed_to_open_trigger_data := 'Failed to open trigger data:';
  translation__messages_r.failed_to_open_triggers_list := 'Failed to open triggers list:';
  translation__messages_r.failed_to_open_unique_check_query := 'Failed to open unique check query:';
  translation__messages_r.failed_to_open_users_list := 'Failed to open users list:';
  translation__messages_r.failed_to_open_view_data := 'Failed to open view data:';
  translation__messages_r.failed_to_open_view_metadata := 'Failed to open view metadata:';
  translation__messages_r.failed_to_paste_value_from_clipboard := 'Failed to paste value from clipboard.';
  translation__messages_r.failed_to_preview_value := 'Failed to preview value.';
  translation__messages_r.failed_to_read_activity_column_name := 'Failed to read activity column name:';
  translation__messages_r.failed_to_read_collate_name := 'Failed to read collate name:';
  translation__messages_r.failed_to_read_column_name := 'Failed to read column name:';
  translation__messages_r.failed_to_read_column_value_as_a_number := 'Failed to read column value as a number.';
  translation__messages_r.failed_to_read_columns := 'Failed to read columns:';
  translation__messages_r.failed_to_read_database_description := 'Failed to read database description:';
  translation__messages_r.failed_to_read_dependencies_names := 'Failed to read dependencies names:';
  translation__messages_r.failed_to_read_description_column_name := 'Failed to read description column name:';
  translation__messages_r.failed_to_read_event_column_name := 'Failed to read event column name:';
  translation__messages_r.failed_to_read_events_column_name := 'Failed to read events column name:';
  translation__messages_r.failed_to_read_exception_message := 'Failed to read exception message:';
  translation__messages_r.failed_to_read_exception_name := 'Failed to read exception name:';
  translation__messages_r.failed_to_read_external_function_name := 'Failed to read external function name:';
  translation__messages_r.failed_to_read_generator_description := 'Failed to read generator description:';
  translation__messages_r.failed_to_read_generator_name := 'Failed to read generator name:';
  translation__messages_r.failed_to_read_generator_value := 'Failed to read generator value:';
  translation__messages_r.failed_to_read_index_name := 'Failed to read index name:';
  translation__messages_r.failed_to_read_parameter_name := 'Failed to read parameter name:';
  translation__messages_r.failed_to_read_parameter_number := 'Failed to read parameter number:';
  translation__messages_r.failed_to_read_parameter_type_input_column_name := 'Failed to read parameter type input column name:';
  translation__messages_r.failed_to_read_permission_symbol__column_name := 'Failed to read permission symbol (column name';
  translation__messages_r.failed_to_read_permissions_user_name := 'Failed to read permissions user name:';
  translation__messages_r.failed_to_read_primary_key_name := 'Failed to read primary key name:';
  translation__messages_r.failed_to_read_role_name := 'Failed to read role name:';
  translation__messages_r.failed_to_read_sequence_column_name := 'Failed to read sequence column name:';
  translation__messages_r.failed_to_read_source_column_name := 'Failed to read source column name:';
  translation__messages_r.failed_to_read_stored_procedure_description_column_name := 'Failed to read stored procedure description column name:';
  translation__messages_r.failed_to_read_stored_procedure_name_ := 'Failed to read stored procedure name:';
  translation__messages_r.failed_to_read_stored_procedure_owner_column_name := 'Failed to read stored procedure owner column name:';
  translation__messages_r.failed_to_read_stored_procedure_source_column_name := 'Failed to read stored procedure source column name:';
  translation__messages_r.failed_to_read_table_description := 'Failed to read table description:';
  translation__messages_r.failed_to_read_table_name_ := 'Failed to read table name:';
  translation__messages_r.failed_to_read_table_owner_name := 'Failed to read table owner name:';
  translation__messages_r.failed_to_read_trigger_name := 'Failed to read trigger name:';
  translation__messages_r.failed_to_read_type_column_name := 'Failed to read type column name:';
  translation__messages_r.failed_to_read_unique_check_query_column_name := 'Failed to read unique check query column name:';
  translation__messages_r.failed_to_read_user_activity := 'Failed to read user activity:';
  translation__messages_r.failed_to_read_user_administrator_privilege := 'Failed to read user administrator privilege:';
  translation__messages_r.failed_to_read_user_name := 'Failed to read user name:';
  translation__messages_r.failed_to_read_view_description_column_name := 'Failed to read view description column name:';
  translation__messages_r.failed_to_read_view_name_ := 'Failed to read view name:';
  translation__messages_r.failed_to_read_view_owner_column_name := 'Failed to read view owner column name:';
  translation__messages_r.failed_to_read_view_source_column_name := 'Failed to read view source column name:';
  translation__messages_r.failed_to_revoke_privileges := 'Failed to revoke privileges:';
  translation__messages_r.failed_to_set_command_parameter := 'Failed to set command parameter.';
  translation__messages_r.failed_to_set_exception := 'Failed to set exception:';
  translation__messages_r.failed_to_set_generator := 'Failed to set generator:';
  translation__messages_r.failed_to_set_query_parameter := 'Failed to set query parameter.';
  translation__messages_r.failed_to_set_role_privileges := 'Failed to set role privileges:';
  translation__messages_r.failed_to_set_sql_dialect := 'Failed to set SQL dialect:';
  translation__messages_r.failed_to_set_the_column_default_value := 'Failed to set the column default value:';
  translation__messages_r.failed_to_set_the_column_description := 'Failed to set the column description:';
  translation__messages_r.failed_to_set_the_column_new_name := 'Failed to set the column new name:';
  translation__messages_r.failed_to_set_the_column_position := 'Failed to set the column position:';
  translation__messages_r.failed_to_set_the_column_primary_key_attribute := 'Failed to set the column ''primary key'' attribute:';
  translation__messages_r.failed_to_set_the_database_description := 'Failed to set the database description:';
  translation__messages_r.failed_to_set_the_exception_description := 'Failed to set the exception description:';
  translation__messages_r.failed_to_set_the_external_function_description := 'Failed to set the external function description:';
  translation__messages_r.failed_to_set_the_generator_description := 'Failed to set the generator description:';
  translation__messages_r.failed_to_set_the_index_description := 'Failed to set the index description:';
  translation__messages_r.failed_to_set_the_role_description := 'Failed to set the role description:';
  translation__messages_r.failed_to_set_the_stored_procedure_description := 'Failed to set the stored procedure description:';
  translation__messages_r.failed_to_set_the_stored_procedure_parameter_description := 'Failed to set the stored procedure parameter description:';
  translation__messages_r.failed_to_set_the_table_description := 'Failed to set the table description:';
  translation__messages_r.failed_to_set_the_trigger_description := 'Failed to set the trigger description:';
  translation__messages_r.failed_to_set_the_user_description := 'Failed to set the user description:';
  translation__messages_r.failed_to_set_the_view_description := 'Failed to set the view description:';
  translation__messages_r.failed_to_set_the_view_parameter_description := 'Failed to set the view parameter description:';
  translation__messages_r.failed_to_set_user := 'Failed to set user:';
  translation__messages_r.failed_to_set_value_format___field := 'Failed to set value format - field:';
  translation__messages_r.file_changed_ := 'File changed.';
  translation__messages_r.file_not_found := 'File not found';
  translation__messages_r.file_not_found___default_value_used := 'File not found - default value used';
  translation__messages_r.filter_value := 'Filter value:';
  translation__messages_r.firebird_backup_files := 'FireBird backup files';
  translation__messages_r.firebird_database_files := 'FireBird database files';
  translation__messages_r.firebird_example_employee_fdb__fdac_ := 'FireBird example Employee.fdb (FDac)';
  translation__messages_r.firedac_driver_id_should_not_be_empty := 'FireDAC driver id should not be empty.';
  translation__messages_r.force_close_ := 'Force close?';
  translation__messages_r.generator_name_should_not_be_empty := 'Generator name should not be empty.';
  translation__messages_r.generators_must_be_selected := 'Generators must be selected.';
  translation__messages_r.grant_all_on_all_privileges_to_user := 'Grant all on all privileges to user';
  translation__messages_r.grant_privileges_on__1 := 'Grant privileges';
  translation__messages_r.grant_privileges_on__2 := 'on';
  translation__messages_r.grant_privileges_on__3 := 'to user';
  translation__messages_r.grant_privileges_on_selected_generators_to_selected_users_ := 'Grant privileges on selected generators to selected users?';
  translation__messages_r.help__keyboard_shortcuts :=
    'Databases:' + #13 +
    '    Ctrl + R - refresh' + #13 +
    '    Ctrl + S - save' + #13 +
    '    Delete - delete' + #13 +
    '    Down arrow - move down' + #13 +
    '    Enter - open database' + #13 +
    '    Insert - add' + #13 +
    '    Spacebar, Ctrl + Enter - edit' + #13 +
    '    Up arrow - move up' + #13 +
    'Others' + #13 +
    '    Ctrl + /, Ctrl + Shift + / - comment / uncomment line / block' + #13 +
    '    Ctrl + \, Ctrl + Shift + \ - comment / uncomment line / block alternatively' + #13 +
    '    Ctrl + Shift + \ - invert comment alternatively (block only)' + #13 +
    '    Ctrl + C - copy to clipboard (e.g. column name, query value, table name)' + #13 +
    '    Ctrl + D - show column distinct values' + #13 +
    '    Ctrl + Enter, Ctrl + Double-click - open table, view and open table, view data' + #13 +
    '    Ctrl + F - add table filter' + #13 +
    '    Ctrl + S, Shift + S - sum indicated column values' + #13 +
    '    Ctrl + Shift + A - correct align' + #13 +
    '    Ctrl + Tab, Ctrl + Shift + Tab - switch tab' + #13 +
    '    Enter, Double-click - open stored procedure, table, view etc.' + #13 +
    '    Shift + Enter, Shift + Double-click - open and edit stored procedure, view' + #13 +
    'SQL editor' + #13 +
    '    Ctrl + 0 ... 9 - go to bookmark' + #13 +
    '    Ctrl + . - code completion' + #13 +
    '    Ctrl + D - display indicated column distinct values' + #13 +
    '    Ctrl + Enter - add all columns sign (*) and add table in the SQL editor' + #13 +
    '    Ctrl + F - find (search) text' + #13 +
    '    Ctrl + H - replace text' + #13 +
    '    Ctrl + L - load text file' + #13 +
    '    Ctrl + O - find text file' + #13 +
    '    Ctrl + S - save query output as csv' + #13 +
    '    Ctrl + T - toggle text editor mode' + #13 +
    '    Ctrl + Shift + 0 ... 9 - set / clear bookmark' + #13 +
    '    Ctrl + Shift + S - save text file' + #13 +
    '    Ctrl + Spacebar - add all columns sign (*) in the SQL editor' + #13 +
    '    Enter, Double-click - add column / table in the SQL editor' + #13 +
    '    F3 - find (search) / replace text' + #13 +
    '    F5 - set / clear line color' + #13 +
    '    F6 - change line color' + #13 +
    '    F7 - choose line color' + #13 +
    '    Shift + Enter - add all columns in the SQL editor' + #13 +
    '    Shift + F5 - clear all lines color' + #13 +
    '    Shift + S - sum indicated column values';
  translation__messages_r.index_name_should_not_be_empty__set_default_index_name_ := 'Index name should not be empty.' + #13 + #10 + #13 + #10 + 'Set default index name?';
  translation__messages_r.information := 'Information';
  translation__messages_r.language_file_does_not_exist := 'Language file does not exist';
  translation__messages_r.languages_directory_does_not_exist := 'Languages directory does not exist';
  translation__messages_r.object_not_found___default_value_used__collate_ := 'Object not found - default value used (collate).';
  translation__messages_r.parameter_name_should_be_unique := 'Parameter name should be unique.';
  translation__messages_r.parameter_name_should_not_be_empty := 'Parameter name should not be empty.';
  translation__messages_r.point_the_database_file___e_g___c___program_files_firebird_examples_empbuild_employee_fdb := 'Point the database file.' + #13 + #13 + 'E.g.:' + #13 + #13 + 'C:\Program Files\Firebird\examples\empbuild\EMPLOYEE.FDB';
  translation__messages_r.privileges_must_be_selected := 'Privileges must be selected.';
  translation__messages_r.query_output_count_ := ', query output count';
  translation__messages_r.record_number__records_count_label__hint := 'Record number / records count.';
  translation__messages_r.replace_this_occurrence_of := 'Replace this occurrence of';
  translation__messages_r.reset_search_from_the_beginning_ := 'Reset search from the beginning?';
  translation__messages_r.reset_search_from_the_end_ := 'Reset search from the end?';
  translation__messages_r.revoke_all_on_all_privileges_from_user := 'Revoke all on all privileges from user ';
  translation__messages_r.revoke_privileges_on__1 := 'Revoke privileges';
  translation__messages_r.revoke_privileges_on__2 := 'on';
  translation__messages_r.revoke_privileges_on__3 := 'from user';
  translation__messages_r.revoke_privileges_on_selected_generators_from_selected_users_ := 'Revoke privileges on selected generators from selected users?';
  translation__messages_r.role_and_user_name_should_be_unique := 'Role and user name should be unique.';
  translation__messages_r.role_name_should_not_be_empty := 'Role name should not be empty.';
  translation__messages_r.save_columns_positions__table := 'Save columns positions (table';
  translation__messages_r.save_table_data_to_file__no____display_in_log__ := 'Save table data to file (''NO'' = display in log)?';
  translation__messages_r.save_the_list_ := 'Save the list?';
  translation__messages_r.search_string_not_found__1 := 'Search string';
  translation__messages_r.search_string_not_found__2 := 'not found.';
  translation__messages_r.set_exception := 'Set exception';
  translation__messages_r.set_generator := 'Set generator';
  translation__messages_r.set_role := 'Set role';
  translation__messages_r.set_the_column_primary_key_attribute := 'Set the column ''primary key'' attribute';
  translation__messages_r.set_user_values__1 := 'Set user';
  translation__messages_r.set_user_values__2 := 'values';
  translation__messages_r.sql_editor_contains_data__continue_ := 'SQL editor contains data. Continue?';
  translation__messages_r.sql_editor_default_keystrokes := 'SQL editor default keystrokes';
  translation__messages_r.sql_no_ := 'SQL no.';
  translation__messages_r.stored_procedure_code_example := '/* Stored procedure code example: */';
  translation__messages_r.stored_procedure_name_should_not_be_empty := 'Stored procedure name should not be empty.';
  translation__messages_r.stored_procedure_not_found := 'Stored procedure not found:';
  translation__messages_r.stored_procedure_source_should_not_be_empty := 'Stored procedure source should not be empty.';
  translation__messages_r.table_name_should_not_be_empty := 'Table name should not be empty.';
  translation__messages_r.task_is_still_running_wait_until_finish := 'Task is still running wait until finish.';
  translation__messages_r.tasks_are_still_running_wait_until_finish := 'Tasks are still running wait until finish.';
  translation__messages_r.text_files := 'Text files';
  translation__messages_r.text__edit_memo__text__edit_memo_form__hint_ :=
    'For text values use apostrophe marks ('') e.g.: ''Abc.''.' + #13 +
    #13 +
    'Apostrophe marks inside the text should be duplicated.' + #13 +
    #13 +
    'Probably sometimes need to delete the word ''default''.';
  translation__messages_r.the_search_and_replace_strings_cannot_be_equal := 'The search and replace strings cannot be equal.';
  translation__messages_r.the_search_string_cannot_be_blank := 'The search string cannot be blank.';
  translation__messages_r.the_text_is_read_only := 'The text is read only.';
  translation__messages_r.trigger_activity_should_not_be_empty := 'Trigger activity should not be empty.';
  translation__messages_r.trigger_code_example := '/* Trigger code example: */';
  translation__messages_r.trigger_event_should_not_be_empty := 'Trigger event should not be empty.';
  translation__messages_r.trigger_events_must_be_selected := 'Trigger events must be selected.';
  translation__messages_r.trigger_name_should_not_be_empty := 'Trigger name should not be empty.';
  translation__messages_r.trigger_not_found := 'Trigger not found:';
  translation__messages_r.trigger_source_should_not_be_empty := 'Trigger source should not be empty.';
  translation__messages_r.trigger_type_should_not_be_empty := 'Trigger type should not be empty.';
  translation__messages_r.user_name_should_not_be_empty := 'User name should not be empty.';
  translation__messages_r.user_password_should_not_be_empty := 'User password should not be empty.';
  translation__messages_r.users_must_be_selected := 'Users must be selected.';
  translation__messages_r.view_code_example := '/* View code example: */';
  translation__messages_r.view_name_should_not_be_empty := 'View name should not be empty.';
  translation__messages_r.view_not_found := 'View not found:';
  translation__messages_r.view_source_should_not_be_empty := 'View source should not be empty.';
  translation__messages_r.warning := 'Warning';

  translation__messages_r.word__active := 'Active';
  translation__messages_r.word__administrator := 'Administrator';
  translation__messages_r.word__allow_nulls := 'Allow nulls';
  translation__messages_r.word__attribute_name := 'Attribute name';
  translation__messages_r.word__attribute_value := 'Attribute value';
  translation__messages_r.word__backup_state := 'Backup state';
  translation__messages_r.word__character_set := 'Character set';
  translation__messages_r.word__check_constraint := 'CHECK constraint';
  translation__messages_r.word__close := 'Close.';
  translation__messages_r.word__collation := 'collation';
  translation__messages_r.word__collation__with_a_capital_letter := 'Collation';
  translation__messages_r.word__column := 'column';
  translation__messages_r.word__column__name := 'Column name';
  translation__messages_r.word__columns := 'Columns';
  translation__messages_r.word__computed_column := 'computed column';
  translation__messages_r.word__connected := 'connected';
  translation__messages_r.word__ctrl___o := #13 + #10 + #13 + #10 + '[Ctrl + O]';
  translation__messages_r.word__database := 'Database';
  translation__messages_r.word__database_path_or_alias := 'Database path or alias';
  translation__messages_r.word__default__character_set := 'Default character set';
  translation__messages_r.word__default__value := 'Default value';
  translation__messages_r.word__description := 'Description';
  translation__messages_r.word__description___column := 'Description - column';
  translation__messages_r.word__description___database := 'Description - database';
  translation__messages_r.word__description___exception := 'Description - exception';
  translation__messages_r.word__description___external_function := 'Description - external function';
  translation__messages_r.word__description___generator := 'Description - generator';
  translation__messages_r.word__description___index := 'Description - index';
  translation__messages_r.word__description___role := 'Description - role';
  translation__messages_r.word__description___stored_procedure := 'Description - stored procedure';
  translation__messages_r.word__description___stored_procedure_parameter := 'Description - stored procedure parameter';
  translation__messages_r.word__description___table := 'Description - table';
  translation__messages_r.word__description___trigger := 'Description - trigger';
  translation__messages_r.word__description___user := 'Description - user';
  translation__messages_r.word__description___view := 'Description - view';
  translation__messages_r.word__description___view_parameter := 'Description - view parameter';
  translation__messages_r.word__disconnected := 'disconnected';
  translation__messages_r.word__done := 'done';
  translation__messages_r.word__error := 'error';
  translation__messages_r.word__exception := 'exception';
  translation__messages_r.word__filling_database_pages := 'Filling database pages';
  translation__messages_r.word__first_name := 'First name';
  translation__messages_r.word__full_shutdown := 'Full shutdown';
  translation__messages_r.word__generator__sequence_ := 'generator (sequence)';
  translation__messages_r.word__generators := 'generators';
  translation__messages_r.word__id_name := 'Id name';
  translation__messages_r.word__index := 'index';
  translation__messages_r.word__index__expression := 'index expression';
  translation__messages_r.word__index__name := 'Index name';
  translation__messages_r.items_count := 'Items count';
  translation__messages_r.word__last_name := 'Last name';
  translation__messages_r.word__length := 'Length';
  translation__messages_r.word__merge := 'Merge';
  translation__messages_r.word__message := 'message';
  translation__messages_r.word__message__with_a_capital_letter := 'Message';
  translation__messages_r.word__middle_name := 'Middle name';
  translation__messages_r.word__multi_user_shutdown := 'Multi-user shutdown';
  translation__messages_r.word__name := 'Name';
  translation__messages_r.word__no_ := 'No.';
  translation__messages_r.word__none := '<none>';
  translation__messages_r.word__normal := 'Normal';
  translation__messages_r.word__open := 'Open.';
  translation__messages_r.word__owner := 'Owner';
  translation__messages_r.word__owner_name := 'Owner name';
  translation__messages_r.word__package__body := 'package body';
  translation__messages_r.word__package__header := 'package header';
  translation__messages_r.word__page_size := 'Page size';
  translation__messages_r.word__parameter__name := 'Parameter name';
  translation__messages_r.word__parameter__number := 'Parameter number';
  translation__messages_r.word__primary_key := 'Primary key';
  translation__messages_r.word__privilege := 'Privilege';
  translation__messages_r.word__procedure := 'procedure';
  translation__messages_r.word__procedure___or_its_parameter_s__ := 'procedure (or its parameter(s))';
  translation__messages_r.word__read__only := 'Read only';
  translation__messages_r.word__read__write := 'Read write';
  translation__messages_r.word__reading_mode := 'Reading mode';
  translation__messages_r.word__re_creation_date := '(Re)creation date';
  translation__messages_r.word__reserve_space := 'Reserve space';
  translation__messages_r.word__role_name := 'Role name';
  translation__messages_r.word__segment_length := 'Segment length';
  translation__messages_r.word__shared := 'shared';
  translation__messages_r.word__shutdown_mode := 'Shutdown mode';
  translation__messages_r.word__single_user_shutdown := 'Single-user shutdown';
  translation__messages_r.word__sql_dialect := 'SQL dialect';
  translation__messages_r.word__stalled := 'Stalled';
  translation__messages_r.word__stored_function := 'stored function';
  translation__messages_r.word__table := 'table';
  translation__messages_r.word__table___or_a_column_in_it_ := 'table (or a column in it)';
  translation__messages_r.word__the_database_is_online := 'The database is online';
  translation__messages_r.word__time__shortcut__days := 'd';
  translation__messages_r.word__time__shortcut__hours := 'h';
  translation__messages_r.word__time__shortcut__milliseconds := 'ms';
  translation__messages_r.word__time__shortcut__minutes := 'm';
  translation__messages_r.word__time__shortcut__seconds := 's';
  translation__messages_r.word__total := 'total';
  translation__messages_r.word__trigger := 'trigger';
  translation__messages_r.word__trigger__name := 'Trigger name';
  translation__messages_r.word__trigger_sequence := 'Trigger sequence';
  translation__messages_r.word__trigger_type := 'Trigger type';
  translation__messages_r.word__type := 'Type';
  translation__messages_r.word__udf_or_stored_function := 'UDF or stored function';
  translation__messages_r.word__use_all_space := 'Use all space';
  translation__messages_r.word__user := 'user';
  translation__messages_r.word__user__name := 'User name';
  translation__messages_r.word__user__names := 'User names';
  translation__messages_r.word__value := 'Value';
  translation__messages_r.word__value_to := 'value to';
  translation__messages_r.word__view := 'view';
  {$endregion 'translation__messages_r.'}

  {$region 'translation__table__data_filter_r.'}
  translation__table__data_filter_r.automatically_use_quotation_sign := 'a.''';
  translation__table__data_filter_r.automatically_use_quotation_sign__hint := 'Automatically use quotation sign.';
  translation__table__data_filter_r.buttons_panel__hint :=
    'Enter - activate all filters' + #13 +
    'Ctrl + D - show column distinct values' + #13 +
    'Ctrl + Enter - deactivate all filters' + #13 +
    'Ctrl + ?, Ctrl + / - show filter value';
  translation__table__data_filter_r.case_insensitive := 'c.i.';
  translation__table__data_filter_r.case_insensitive__hint := 'Case insensitive.';
  translation__table__data_filter_r.double_click___copy_the_field_name_to_clipboard := 'Double-click - copy the field name to clipboard.';
  translation__table__data_filter_r.correct_align := 'a';
  translation__table__data_filter_r.correct_align__hint := 'Correct align.';
  translation__table__data_filter_r.delete_filter__hint := 'Delete filter.';
  translation__table__data_filter_r.disable_filter := 'd.';
  translation__table__data_filter_r.disable_filter__hint := 'Disable filter.';
  translation__table__data_filter_r.field_name_etiquette_label__hint :=
    'Double-click - copy the field name to clipboard.' + #13 +
    'Ctrl + + - increase height.' + #13 +
    'Ctrl + - - decrease height.' + #13 +
    'Ctrl + Shift + A - correct splitters align.';
  translation__table__data_filter_r.field_value__dedicated__use_check_box__hint :=
    'Use the value of additional components.' + #13 + #13 +
    'Enter - activate all filters' + #13 +
    'Ctrl + D - show column distinct values' + #13 +
    'Ctrl + Enter - deactivate all filters' + #13 +
    'Ctrl + ?, Ctrl + / - show filter value';
  translation__table__data_filter_r.move_left__hint := 'Move left.';
  translation__table__data_filter_r.move_right__hint := 'Move right.';
  translation__table__data_filter_r.parameter_by := 'Parameter by.';
  translation__table__data_filter_r.parameter_data_type := 'Parameter data type.';
  translation__table__data_filter_r.parameter_default_value := 'Parameter default value.';
  translation__table__data_filter_r.parameter_description := 'Parameter description.';
  translation__table__data_filter_r.parameter_value := 'Parameter value.';
  translation__table__data_filter_r.sql_parameter_1 := 'SQL parameter';
  translation__table__data_filter_r.sql_parameter_2 := 'Ctrl + E, Enter - query execute.';
  translation__table__data_filter_r.type_input := 'I.';
  translation__table__data_filter_r.type_input__hint := 'Type input.';
  translation__table__data_filter_r.use_additional_value := 'Use additional value';
  {$endregion 'translation__table__data_filter_r.'}

end;

procedure Translation__Load();
var
  items_translation_l, // Whether the translation applies to component elements (e.g., drop-down list items).
  hint_translation_l // Does the translation apply to the component prompts.
    : boolean;

  i,
  j,
  k,
  zti
    : integer;

  zts_1,
  zts_2,
  component_name_l,
  unit_name_l
    : string;

  rtti_field : System.Rtti.TRttiField;

  rtti_type__messages,
  rtti_type__table__data_filter
    : System.Rtti.TRttiType;

  zt_string_list_l : System.Classes.TStringList;
begin

  // Translations from files applies only to elements added in the function Translation__Default_Set().

  zts_1 := ExtractFilePath( Application.ExeName ) + Common.languages__directory_name_c + System.IOUtils.TPath.DirectorySeparatorChar + Common.language__selected + Common.languages__file__extension_c;

  if not System.SysUtils.FileExists( zts_1 ) then
    begin

      Translation__Default_Set();

      if Pos( translation__differentiator__default_sign_c, zts_1 ) <= 0 then // Does not display message when '<default>' translation is selected.
        Application.MessageBox( PChar(translation__messages_r.language_file_does_not_exist + #13 + #13 + zts_1 + #13 + '.'), PChar(translation__messages_r.error), Winapi.Windows.MB_OK + Winapi.Windows.MB_ICONEXCLAMATION );

      Exit;

    end;


  Vcl.Forms.Screen.Cursor := Vcl.Controls.crHourGlass;

  zt_string_list_l := TStringList.Create();
  zt_string_list_l.LoadFromFile( zts_1 );


  if zt_string_list_l.Count > 0 then
    begin

      rtti_type__messages := System.Rtti.TRTTIContext.Create.GetType(  System.TypeInfo( TTranslation__Messages_r )  );
      rtti_type__table__data_filter := System.Rtti.TRTTIContext.Create.GetType(  System.TypeInfo( TTranslation__Table__Data_Filter_r )  );

    end;


  unit_name_l := '';

  for i := 0 to zt_string_list_l.Count - 1 do
    begin

      zts_1 := zt_string_list_l[ i ];

      if Trim( zts_1 ) <> '' then
        begin

          // Comments '**(...)', '    **(...)'.
          zts_2 := Trim( zts_1 );

          if    ( Length( zts_2 ) > 1 )
            and ( zts_2[ 1 ] = '*' )
            and ( zts_2[ 2 ] = '*' ) then
            Continue;


          zti := Pos( '=', zts_1 );

          if zti <= 0 then
            begin

              unit_name_l := zts_1;

              Continue;

            end;


          // These components are not subject to translation.
          if   ( // Do not translate items.
                     (  Pos( translation__differentiator__items__file_c + '=', zts_1 ) > 0  )
                 and (
                           ( unit_name_l = 'TOptions_Form' )
                       and (
                                (  Pos( 'Fire_Dac__Query__Fetch_Options__Mode_ComboBox', zts_1 ) > 0  )
                             or (  Pos( 'Fire_Dac__Query__Fetch_Options__Record_Count_Mode_ComboBox', zts_1 ) > 0  )
                             or (  Pos( 'Language_ComboBox', zts_1 ) > 0  )
                             or (  Pos( 'Sql_Editor__Highlights__Syntax_ComboBox', zts_1 ) > 0  )
                           )
                    )
               )
            //or ( // Do not translate captions.
            //         (  Pos( translation__differentiator__items__file_c + '=', zts_1 ) <= 0  )
            //     and (  Pos( translation__differentiator__hint_c + '=', zts_1 ) <= 0  )
            //     and (
            //              (  Pos( '1_Edit.Name', zts_1 ) > 0  )
            //           or (  Pos( '1_Label.Name', zts_1 ) > 0  )
            //        )
            //   )
            // Do not translate components.
            or (
                     ( unit_name_l = 'TAbout_Form' )
                 and (  Pos( 'Caption', zts_1 ) <> 1  )
               )
            or (
                     ( unit_name_l = 'TOptions_Form' )
                 and (  Pos( 'Sql__External_Function__Parameter_Separator_Memo', zts_1 ) > 0  )
               )
            //or (  Pos( '1_Image.Name', zts_1 ) > 0  )
            //or (  Pos( '1_SpinEdit.Name', zts_1 ) > 0  )
            then
            zti := -1;



          if zti > 1 then
            begin

              if Pos( translation__messages_c, zts_1 ) > 0 then
                begin

                  {$region 'Messages.'}
                  component_name_l := Copy( zts_1, 1, zti - 1 ); // Here as a messages name.
                  Delete( zts_1, 1, zti );

                  component_name_l := StringReplace( component_name_l, translation__messages_c, '', [ rfReplaceAll ] );
                  zts_1 := StringReplace( zts_1, Common.newline_symbol_c, #13 + #10, [ rfReplaceAll ] );

                  for rtti_field in rtti_type__messages.GetFields do
                    if rtti_field.Name = component_name_l then
                      begin

                        if rtti_field.GetValue( @translation__messages_r ).Kind in [ System.TypInfo.tkString, System.TypInfo.tkLString, System.TypInfo.tkUString, System.TypInfo.tkWString ] then
                          rtti_field.SetValue( @translation__messages_r, zts_1 );

                        Break;

                      end;
                  {$endregion 'Messages.'}

                end
              else
              if Pos( translation__table__data_filter_c, zts_1 ) > 0 then
                begin

                  {$region 'Table data filter.'}
                  component_name_l := Copy( zts_1, 1, zti - 1 ); // Here as a name.
                  Delete( zts_1, 1, zti );

                  component_name_l := StringReplace( component_name_l, translation__table__data_filter_c, '', [ rfReplaceAll ] );
                  zts_1 := StringReplace( zts_1, Common.newline_symbol_c, #13 + #10, [ rfReplaceAll ] );

                  for rtti_field in rtti_type__table__data_filter.GetFields do
                    if rtti_field.Name = component_name_l then
                      begin

                        if rtti_field.GetValue( @translation__table__data_filter_r ).Kind in [ System.TypInfo.tkString, System.TypInfo.tkLString, System.TypInfo.tkUString, System.TypInfo.tkWString ] then
                          rtti_field.SetValue( @translation__table__data_filter_r, zts_1 );

                        Break;

                      end;
                  {$endregion 'Table data filter.'}

                end
              else
                begin

                  {$region 'Components.'}
                  if Pos( translation__differentiator__hint_c + '=', zts_1 ) > 0 then
                    begin

                      hint_translation_l := true;
                      zts_1 := StringReplace( zts_1, translation__differentiator__hint_c, '', [] );
                      zti := Pos( '=', zts_1 );

                    end
                  else
                    hint_translation_l := false;

                  if Pos( translation__differentiator__items__file_c + '=', zts_1 ) > 0 then
                    begin

                      items_translation_l := true;
                      zts_1 := StringReplace( zts_1, translation__differentiator__items__file_c, '', [] );
                      zti := Pos( '=', zts_1 );

                    end
                  else
                    items_translation_l := false;


                  component_name_l := Copy( zts_1, 1, zti - 1 );
                  Delete( zts_1, 1, zti );


                  if Trim( component_name_l ) <> '' then
                    for j := 0 to Length( translation__units_r_t ) - 1 do
                      if translation__units_r_t[ j ].unit_name = unit_name_l then
                        begin

                          for k := 0 to Length( translation__units_r_t[ j ].components_r_t ) - 1 do
                            if translation__units_r_t[ j ].components_r_t[ k ].component_name = component_name_l then
                              begin

                                zts_1 := StringReplace( zts_1, Common.newline_symbol_c, #13 + #10, [ rfReplaceAll ] );


                                if not hint_translation_l then
                                  begin

                                    if not items_translation_l then
                                      translation__units_r_t[ j ].components_r_t[ k ].caption := zts_1
                                    else
                                      begin

                                        translation__units_r_t[ j ].components_r_t[ k ].items := zts_1;

                                      end;

                                  end
                                else
                                  translation__units_r_t[ j ].components_r_t[ k ].hint := zts_1;

                              end;


                          Break;

                        end;
                  {$endregion 'Components.'}

                end;

            end;

        end;

    end;

  zt_string_list_l.Clear();
  FreeAndNil( zt_string_list_l );


  Vcl.Forms.Screen.Cursor := Vcl.Controls.crDefault;

end;

procedure Translation__Apply( target_f : Vcl.Controls.TWinControl );
const
  name_end_safeguard_c_l : string = '* _ ! _ *'; // To make sure it compares the end of the names ('_Edit' is part of 'Sql_Editor_TabSheet').

var
  hint_translation_locked_l : boolean;

  i,
  j,
  zti_1,
  zti_2
    : integer;

  zts_1,
  zts_2,
  unit_name_l,
  name_l
    : string;

  zt_component : System.Classes.TComponent;
begin

  if target_f = nil then
    Exit;


  Vcl.Forms.Screen.Cursor := Vcl.Controls.crHourGlass;

  hint_translation_locked_l := false; //???

  unit_name_l := target_f.ClassName();


  zt_component := target_f.FindComponent( 'Caret_Position_Label' );

  if zt_component <> nil then
    TLabel(zt_component).Hint := translation__messages_r.caret_position_label__hint;


  zt_component := target_f.FindComponent( 'Record_Number__Records_Count_Label' );

  if zt_component <> nil then
    TLabel(zt_component).Hint := translation__messages_r.record_number__records_count_label__hint;


  zt_component := nil;


  for i := 0 to Length( translation__units_r_t ) - 1 do
    if translation__units_r_t[ i ].unit_name = unit_name_l then
      begin

        for j := 0 to Length( translation__units_r_t[ i ].components_r_t ) - 1 do
          begin

            name_l := translation__units_r_t[ i ].components_r_t[ j ].component_name;

            if Trim( name_l ) <> '' then
              begin

                {$region 'Components.'}
                zt_component := nil;


                if    ( name_l = translation__differentiator__caption__form_c )
                  and ( target_f is TForm ) then
                  TForm(target_f).Caption := translation__units_r_t[ i ].components_r_t[ j ].caption
                else
                  zt_component := target_f.FindComponent( name_l );


                if zt_component <> nil then
                  begin

                    // These menu item hints are not subject to translation.
                    //if   (  Pos( '1_MenuItem', name_l ) > 0  )
                    //  or (  Pos( '1_MenuItem', name_l ) > 0  ) then
                    //  hint_translation_locked_l := true
                    //else
                    //  hint_translation_locked_l := false;


                    if Pos( '_BitBtn' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        Vcl.Buttons.TBitBtn(zt_component).Caption := translation__units_r_t[ i ].components_r_t[ j ].caption;

                        if not hint_translation_locked_l then
                          begin

                            Vcl.Buttons.TBitBtn(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.Buttons.TBitBtn(zt_component).Hint ) <> ''  )
                              and ( not Vcl.Buttons.TBitBtn(zt_component).ShowHint ) then
                              Vcl.Buttons.TBitBtn(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_Button' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        Vcl.StdCtrls.TButton(zt_component).Caption := translation__units_r_t[ i ].components_r_t[ j ].caption;

                        if not hint_translation_locked_l then
                          begin

                            Vcl.StdCtrls.TButton(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.StdCtrls.TButton(zt_component).Hint ) <> ''  )
                              and ( not Vcl.StdCtrls.TButton(zt_component).ShowHint ) then
                              Vcl.StdCtrls.TButton(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_CheckBox' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        Vcl.StdCtrls.TCheckBox(zt_component).Caption := translation__units_r_t[ i ].components_r_t[ j ].caption;

                        if not hint_translation_locked_l then
                          begin

                            Vcl.StdCtrls.TCheckBox(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.StdCtrls.TCheckBox(zt_component).Hint ) <> ''  )
                              and ( not Vcl.StdCtrls.TCheckBox(zt_component).ShowHint ) then
                              Vcl.StdCtrls.TCheckBox(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_CheckListBox' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            Vcl.CheckLst.TCheckListBox(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.CheckLst.TCheckListBox(zt_component).Hint ) <> ''  )
                              and ( not Vcl.CheckLst.TCheckListBox(zt_component).ShowHint ) then
                              Vcl.CheckLst.TCheckListBox(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_ComboBox' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            Vcl.StdCtrls.TComboBox(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.StdCtrls.TComboBox(zt_component).Hint ) <> ''  )
                              and ( not Vcl.StdCtrls.TComboBox(zt_component).ShowHint ) then
                              Vcl.StdCtrls.TComboBox(zt_component).ShowHint := true;

                          end;


                          if   ( unit_name_l <> 'TSql_Editor_F_Frame' ) // Do not translate items.
                            or (
                                     ( unit_name_l = 'TSql_Editor_F_Frame' )
                                 and ( name_l <> 'Text__File__Encoding_ComboBox' )
                               ) then
                          if Trim( translation__units_r_t[ i ].components_r_t[ j ].items ) <> '' then
                            begin

                              zti_2 := Vcl.StdCtrls.TComboBox(zt_component).ItemIndex;

                              Vcl.StdCtrls.TComboBox(zt_component).Items.Clear();

                              zts_1 := translation__units_r_t[ i ].components_r_t[ j ].items;

                              zti_1 := Pos( translation__differentiator__items__record_c, zts_1 );

                              while zti_1 > 0 do
                                begin

                                  zts_2 := Copy( zts_1, 1, zti_1 - 1 );
                                  Delete( zts_1, 1, zti_1 );

                                  zts_2 := StringReplace( zts_2, #13, '', [ rfReplaceAll ] );

                                  Vcl.StdCtrls.TComboBox(zt_component).Items.Add( zts_2 );

                                  zti_1 := Pos( translation__differentiator__items__record_c, zts_1 );

                                end;

                              if    ( zti_2 >= 0 )
                                and ( zti_2 <= Vcl.StdCtrls.TComboBox(zt_component).Items.Count - 1 ) then
                                Vcl.StdCtrls.TComboBox(zt_component).ItemIndex := zti_2;

                            end;

                      end
                    else
                    if Pos( '_DatePicker' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            Vcl.WinXPickers.TDatePicker(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.WinXPickers.TDatePicker(zt_component).Hint ) <> ''  )
                              and ( not Vcl.WinXPickers.TDatePicker(zt_component).ShowHint ) then
                              Vcl.WinXPickers.TDatePicker(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_DateTimePicker' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            Vcl.ComCtrls.TDateTimePicker(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.ComCtrls.TDateTimePicker(zt_component).Hint ) <> ''  )
                              and ( not Vcl.ComCtrls.TDateTimePicker(zt_component).ShowHint ) then
                              Vcl.ComCtrls.TDateTimePicker(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_DBEdit' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            Vcl.DBCtrls.TDBEdit(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.DBCtrls.TDBEdit(zt_component).Hint ) <> ''  )
                              and ( not Vcl.DBCtrls.TDBEdit(zt_component).ShowHint ) then
                              Vcl.DBCtrls.TDBEdit(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_DBGrid' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            Vcl.DBGrids.TDBGrid(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.DBGrids.TDBGrid(zt_component).Hint ) <> ''  )
                              and ( not Vcl.DBGrids.TDBGrid(zt_component).ShowHint ) then
                              Vcl.DBGrids.TDBGrid(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_DBMemo' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            Vcl.DBCtrls.TDBMemo(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.DBCtrls.TDBMemo(zt_component).Hint ) <> ''  )
                              and ( not Vcl.DBCtrls.TDBMemo(zt_component).ShowHint ) then
                              Vcl.DBCtrls.TDBMemo(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_DBNavigator' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            Vcl.DBCtrls.TDBNavigator(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.DBCtrls.TDBNavigator(zt_component).Hint ) <> ''  )
                              and ( not Vcl.DBCtrls.TDBNavigator(zt_component).ShowHint ) then
                              Vcl.DBCtrls.TDBNavigator(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_Edit' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            Vcl.StdCtrls.TEdit(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.StdCtrls.TEdit(zt_component).Hint ) <> ''  )
                              and ( not Vcl.StdCtrls.TEdit(zt_component).ShowHint ) then
                              Vcl.StdCtrls.TEdit(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_GroupBox' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        Vcl.StdCtrls.TGroupBox(zt_component).Caption := translation__units_r_t[ i ].components_r_t[ j ].caption;

                        if not hint_translation_locked_l then
                          begin

                            Vcl.StdCtrls.TGroupBox(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.StdCtrls.TGroupBox(zt_component).Hint ) <> ''  )
                              and ( not Vcl.StdCtrls.TGroupBox(zt_component).ShowHint ) then
                              Vcl.StdCtrls.TGroupBox(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    {$IFDEF JVCL__use}
                    if Pos( '_JvDBDateEdit' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            JvDBControls.TJvDBDateEdit(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( JvDBControls.TJvDBDateEdit(zt_component).Hint ) <> ''  )
                              and ( not JvDBControls.TJvDBDateEdit(zt_component).ShowHint ) then
                              JvDBControls.TJvDBDateEdit(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_JvDBDateTimePicker' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            JvDBDateTimePicker.TJvDBDateTimePicker(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( JvDBDateTimePicker.TJvDBDateTimePicker(zt_component).Hint ) <> ''  )
                              and ( not JvDBDateTimePicker.TJvDBDateTimePicker(zt_component).ShowHint ) then
                              JvDBDateTimePicker.TJvDBDateTimePicker(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_JvDBSpinEdit' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            JvDBSpinEdit.TJvDBSpinEdit(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( JvDBSpinEdit.TJvDBSpinEdit(zt_component).Hint ) <> ''  )
                              and ( not JvDBSpinEdit.TJvDBSpinEdit(zt_component).ShowHint ) then
                              JvDBSpinEdit.TJvDBSpinEdit(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    {$ENDIF}
                    if Pos( '_Label' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if Vcl.StdCtrls.TLabel(zt_component).Name <> translation__owner_label_name_c then
                          Vcl.StdCtrls.TLabel(zt_component).Caption := translation__units_r_t[ i ].components_r_t[ j ].caption;

                        if not hint_translation_locked_l then
                          begin

                            Vcl.StdCtrls.TLabel(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.StdCtrls.TLabel(zt_component).Hint ) <> ''  )
                              and ( not Vcl.StdCtrls.TLabel(zt_component).ShowHint ) then
                              Vcl.StdCtrls.TLabel(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_ListView' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            Vcl.ComCtrls.TListView(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.ComCtrls.TListView(zt_component).Hint ) <> ''  )
                              and ( not Vcl.ComCtrls.TListView(zt_component).ShowHint ) then
                              Vcl.ComCtrls.TListView(zt_component).ShowHint := true;

                          end;

                          if Trim( translation__units_r_t[ i ].components_r_t[ j ].items ) <> '' then
                            begin

                              zti_2 := -1;

                              zts_1 := translation__units_r_t[ i ].components_r_t[ j ].items;

                              zti_1 := Pos( translation__differentiator__items__record_c, zts_1 );

                              while ( zti_1 > 0 )
                                and ( Vcl.ComCtrls.TListView(zt_component).Columns.Count > 0 )
                                and ( zti_2 < Vcl.ComCtrls.TListView(zt_component).Columns.Count - 1 ) do
                                begin

                                  inc( zti_2 );


                                  zts_2 := Copy( zts_1, 1, zti_1 - 1 );
                                  Delete( zts_1, 1, zti_1 );

                                  zts_2 := StringReplace( zts_2, #13, '', [ rfReplaceAll ] );

                                  Vcl.ComCtrls.TListView(zt_component).Column[ zti_2 ].Caption := zts_2;

                                  zti_1 := Pos( translation__differentiator__items__record_c, zts_1 );

                                end;

                            end;

                      end
                    else
                    if Pos( '_Memo' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            Vcl.StdCtrls.TMemo(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.StdCtrls.TMemo(zt_component).Hint ) <> ''  )
                              and ( not Vcl.StdCtrls.TMemo(zt_component).ShowHint ) then
                              Vcl.StdCtrls.TMemo(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_MenuItem' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        Vcl.Menus.TMenuItem(zt_component).Caption := translation__units_r_t[ i ].components_r_t[ j ].caption;

                        if not hint_translation_locked_l then
                          Vcl.Menus.TMenuItem(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                      end
                    else
                    if Pos( '_Panel' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        Vcl.ExtCtrls.TPanel(zt_component).Caption := translation__units_r_t[ i ].components_r_t[ j ].caption;

                        if not hint_translation_locked_l then
                          begin

                            Vcl.ExtCtrls.TPanel(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.ExtCtrls.TPanel(zt_component).Hint ) <> ''  )
                              and ( not Vcl.ExtCtrls.TPanel(zt_component).ShowHint ) then
                              Vcl.ExtCtrls.TPanel(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_RadioButton' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        Vcl.StdCtrls.TRadioButton(zt_component).Caption := translation__units_r_t[ i ].components_r_t[ j ].caption;

                        if not hint_translation_locked_l then
                          begin

                            Vcl.StdCtrls.TRadioButton(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.StdCtrls.TRadioButton(zt_component).Hint ) <> ''  )
                              and ( not Vcl.StdCtrls.TRadioButton(zt_component).ShowHint ) then
                              Vcl.StdCtrls.TRadioButton(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_RadioGroup' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        Vcl.ExtCtrls.TRadioGroup(zt_component).Caption := translation__units_r_t[ i ].components_r_t[ j ].caption;

                        if not hint_translation_locked_l then
                          begin

                            Vcl.ExtCtrls.TRadioGroup(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.ExtCtrls.TRadioGroup(zt_component).Hint ) <> ''  )
                              and ( not Vcl.ExtCtrls.TRadioGroup(zt_component).ShowHint ) then
                              Vcl.ExtCtrls.TRadioGroup(zt_component).ShowHint := true;

                          end;

                          if Trim( translation__units_r_t[ i ].components_r_t[ j ].items ) <> '' then
                            begin

                              zti_2 := Vcl.ExtCtrls.TRadioGroup(zt_component).ItemIndex;

                              Vcl.ExtCtrls.TRadioGroup(zt_component).Items.Clear();

                              zts_1 := translation__units_r_t[ i ].components_r_t[ j ].items;

                              zti_1 := Pos( translation__differentiator__items__record_c, zts_1 );

                              while zti_1 > 0 do
                                begin

                                  zts_2 := Copy( zts_1, 1, zti_1 - 1 );
                                  Delete( zts_1, 1, zti_1 );

                                  zts_2 := StringReplace( zts_2, #13, '', [ rfReplaceAll ] );

                                  Vcl.ExtCtrls.TRadioGroup(zt_component).Items.Add( zts_2 );

                                  zti_1 := Pos( translation__differentiator__items__record_c, zts_1 );

                                end;

                              if    ( zti_2 >= 0 )
                                and ( zti_2 <= Vcl.ExtCtrls.TRadioGroup(zt_component).Items.Count - 1 ) then
                                Vcl.ExtCtrls.TRadioGroup(zt_component).ItemIndex := zti_2;

                            end;

                      end
                    else
                    if Pos( '_SpinEdit' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            Vcl.Samples.Spin.TSpinEdit(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.Samples.Spin.TSpinEdit(zt_component).Hint ) <> ''  )
                              and ( not Vcl.Samples.Spin.TSpinEdit(zt_component).ShowHint ) then
                              Vcl.Samples.Spin.TSpinEdit(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_StringGrid' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            Vcl.Grids.TStringGrid(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.Grids.TStringGrid(zt_component).Hint ) <> ''  )
                              and ( not Vcl.Grids.TStringGrid(zt_component).ShowHint ) then
                              Vcl.Grids.TStringGrid(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_TabSheet' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        Vcl.ComCtrls.TTabSheet(zt_component).Caption := translation__units_r_t[ i ].components_r_t[ j ].caption;

                        if not hint_translation_locked_l then
                          begin

                            Vcl.ComCtrls.TTabSheet(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.ComCtrls.TTabSheet(zt_component).Hint ) <> ''  )
                              and ( not Vcl.ComCtrls.TTabSheet(zt_component).ShowHint ) then
                              Vcl.ComCtrls.TTabSheet(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_TimePicker' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        if not hint_translation_locked_l then
                          begin

                            Vcl.WinXPickers.TTimePicker(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.WinXPickers.TTimePicker(zt_component).Hint ) <> ''  )
                              and ( not Vcl.WinXPickers.TTimePicker(zt_component).ShowHint ) then
                              Vcl.WinXPickers.TTimePicker(zt_component).ShowHint := true;

                          end;

                      end
                    else
                    if Pos( '_ToolButton' + name_end_safeguard_c_l, name_l + name_end_safeguard_c_l ) > 0 then
                      begin

                        Vcl.ComCtrls.TToolButton(zt_component).Caption := translation__units_r_t[ i ].components_r_t[ j ].caption;

                        if not hint_translation_locked_l then
                          begin

                            Vcl.ComCtrls.TToolButton(zt_component).Hint := translation__units_r_t[ i ].components_r_t[ j ].hint;

                            if    (  Trim( Vcl.ComCtrls.TToolButton(zt_component).Hint ) <> ''  )
                              and ( not Vcl.ComCtrls.TToolButton(zt_component).ShowHint ) then
                              Vcl.ComCtrls.TToolButton(zt_component).ShowHint := true;

                          end;

                      end;

                  end;
                {$endregion 'Components.'}

              end;

          end;


        Break;

      end;

  Vcl.Forms.Screen.Cursor := Vcl.Controls.crDefault;

end;

end.
