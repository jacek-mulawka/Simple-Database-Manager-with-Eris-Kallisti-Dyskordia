program Simple_Database_Manager_pr;

uses
  Vcl.Forms,
  About in 'Project files\About.pas' {About_Form},
  Common in 'Project files\Common.pas',
  Database__Backup_Restore in 'Project files\Database__Backup_Restore.pas' {Database__Backup_Restore_Form},
  Database__Backup_Restore__Parameter in 'Project files\Database__Backup_Restore__Parameter.pas',
  Database__Create in 'Project files\Database__Create.pas' {Database__Create_Form},
  Database__Informations_F in 'Project files\Database__Informations_F.pas' {Database__Informations_F_Frame},
  Database__Informations_Modify_F in 'Project files\Database__Informations_Modify_F.pas' {Database__Informations_Modify_F_Frame},
  Database__List_Modify in 'Project files\Database__List_Modify.pas' {Database__List_Modify_Form},
  Database__Modify in 'Project files\Database__Modify.pas' {Database__Modify_Form},
  Database__Trigger_Modify in 'Project files\Database__Trigger_Modify.pas' {Database__Trigger_Modify_Form},
  Dependencies_F in 'Project files\Dependencies_F.pas' {TDependencies_F_Frame},
  Exceptions_Modify_F in 'Project files\Exceptions_Modify_F.pas' {Exceptions_Modify_F_Frame},
  External_Function__Modify in 'Project files\External_Function__Modify.pas' {External_Function__Modify_Form},
  External_Functions_Modify_F in 'Project files\External_Functions_Modify_F.pas' {External_Functions_Modify_F_Frame},
  External_Function__Parameter in 'Project files\External_Function__Parameter.pas',
  Form_View_Field in 'Project files\Form_View_Field.pas',
  Generators_Modify_F in 'Project files\Generators_Modify_F.pas' {Generators_Modify_F_Frame},
  Interceptor__Spin_Edit in 'Project files\Interceptors\Interceptor__Spin_Edit.pas',
  Interceptor__Syn_Edit in 'Project files\Interceptors\Interceptor__Syn_Edit.pas',
  Migawka_Prostokat_Tabela_2_SDBM in 'Project files\Migawka_Prostokat_Tabela_2_SDBM.pas',
  Options in 'Project files\Options.pas' {Options_Form},
  Permissions_Modify_F in 'Project files\Permissions_Modify_F.pas' {Permissions_Modify_F_Frame},
  Roles_Modify_F in 'Project files\Roles_Modify_F.pas' {Roles_Modify_F_Frame},
  Simple_Database_Manager in 'Project files\Simple_Database_Manager.pas' {Simple_Database_Manager_Form},
  Shared in 'Project files\Shared.pas' {Shared_DataModule: TDataModule},
  Sql_Editor_F in 'Project files\Sql_Editor_F.pas' {Sql_Editor_F_Frame},
  Stored_Procedure_Modify_F in 'Project files\Stored_Procedure_Modify_F.pas' {Stored_Procedure_Modify_F_Frame},
  Stored_Procedure__Edit_Execute_F in 'Project files\Stored_Procedure__Edit_Execute_F.pas' {Stored_Procedure__Edit_Execute_F_Frame},
  Stored_Procedure__Modify in 'Project files\Stored_Procedure__Modify.pas' {Stored_Procedure__Modify_Form},
  Stored_Procedure__Parameter in 'Project files\Stored_Procedure__Parameter.pas',  
  Table_Add in 'Project files\Table_Add.pas' {Table_Add_Form},
  Table_Column__Modify in 'Project files\Table_Column__Modify.pas' {Table_Column__Modify_Form},
  Table_Column__Values_Distinct in 'Project files\Table_Column__Values_Distinct.pas' {Table_Column__Values_Distinct_Form},
  Table_Modify_F in 'Project files\Table_Modify_F.pas' {TTable_Modify_F_Frame},
  Table__Columns_Sort_F in 'Project files\Table__Columns_Sort_F.pas' {TTable__Columns_Sort_F_Frame},
  Table__Data_Modify_F in 'Project files\Table__Data_Modify_F.pas' {TTable__Data_Modify_F_Frame},
  Table__Data_Filter in 'Project files\Table__Data_Filter.pas',
  Table__Indexes_Modify_F in 'Project files\Table__Indexes_Modify_F.pas' {TTable__Indexes_Modify_F_Frame},
  Table__Metadata_F in 'Project files\Table__Metadata_F.pas' {TTable__Metadata_F_Frame},
  Table__Trigger_Modify in 'Project files\Table__Trigger_Modify.pas' {Table__Trigger_Modify_Form},
  Text__Edit_Memo in 'Project files\Text__Edit_Memo.pas' {Text__Edit_Memo_Form},
  Text__Search_Replace in 'Project files\Text__Search_Replace.pas' {Text__Search_Replace_Form},
  Text__Search_Replace__Prompt in 'Project files\Text__Search_Replace__Prompt.pas' {Text__Search_Replace__Prompt_Form},
  Translation in 'Project files\Translation.pas',
  Triggers_Modify_F in 'Project files\Triggers_Modify_F.pas' {TTriggers_Modify_F_Frame},
  Users_Modify_F in 'Project files\Users_Modify_F.pas' {Users_Modify_F_Frame},
  View_Modify_F in 'Project files\View_Modify_F.pas' {View_Modify_F_Frame},
  View__Edit_Execute_F in 'Project files\View__Edit_Execute_F.pas' {View__Edit_Execute_F_Frame},
  View__Modify in 'Project files\View__Modify.pas' {View__Modify_Form},
  View__Parameter in 'Project files\View__Parameter.pas',

  plgSearchHighlighter in 'Project files\Redistributable\plgSearchHighlighter.pas'; // From SynEdit SearchReplaceDemo.

{$R *.res}

begin

  ReportMemoryLeaksOnShutdown := DebugHook <> 0;

  Application.Initialize();
  Application.MainFormOnTaskbar := True;
  Application.HintHidePause := 30000;

  Application.CreateForm( TSimple_Database_Manager_Form, Simple_Database_Manager_Form );

  Application.Run();

end.
