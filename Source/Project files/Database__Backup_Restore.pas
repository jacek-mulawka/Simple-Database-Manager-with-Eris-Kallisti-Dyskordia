unit Database__Backup_Restore;{06.Paü.2023}

interface

uses
  Common,
  Text__Search_Replace,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin, Vcl.ExtCtrls, Vcl.ComCtrls,
  DosCommand, SynEdit;

type
  TDatabase__Backup_Restore_Form = class( TForm )
    Database_GroupBox: TGroupBox;
    Database__Alias_Etiquette_Label: TLabel;
    Database__Alias_ComboBox: TComboBox;
    Database__Backup__Application__File_Path_GroupBox: TGroupBox;
    Database__Backup__Application__File_Path__Find_Button: TButton;
    Database__Backup__Application__File_Path_Edit: TEdit;
    OpenDialog1: TOpenDialog;
    Database__File_Path_GroupBox: TGroupBox;
    Database__File_Path__Find_Button: TButton;
    Database__File_Path_Edit: TEdit;
    Database__Backup__File_Path_GroupBox: TGroupBox;
    Database__Backup__File_Path__Find_Button: TButton;
    Database__Backup__File_Path_Edit: TEdit;
    User_Name_Etiquette_Label: TLabel;
    User_Name_Edit: TEdit;
    Password_Etiquette_Label: TLabel;
    Password_Edit: TEdit;
    Database__Backup__File_Name__Set_Button: TButton;
    Database__Backup__File_Path__Top_Panel: TPanel;
    Database__Backup__File_Name__Date_Time_RadioGroup: TRadioGroup;
    Parameters_GroupBox: TGroupBox;
    Parameters__General_GroupBox: TGroupBox;
    Parameters__General_ScrollBox: TScrollBox;
    Parameters__General_Vertical_Splitter: TSplitter;
    Bottom_Panel: TPanel;
    Log_Memo_Horizontal_Splitter: TSplitter;
    Buttons_Panel: TPanel;
    Database_Type_ComboBox: TComboBox;
    Database_Type_GroupBox: TGroupBox;
    Parameters__Refresh_Button: TButton;
    Command_Prepare_Button: TButton;
    Execute_Button: TButton;
    Execute_Button_Works_As_Prepare_Execute_CheckBox: TCheckBox;
    Parameters__Backup_Restore_PageControl: TPageControl;
    Parameters__Backup_TabSheet: TTabSheet;
    Parameters__Restore_TabSheet: TTabSheet;
    Parameters__Restore_ScrollBox: TScrollBox;
    Parameters__Backup_ScrollBox: TScrollBox;
    Log_PageControl: TPageControl;
    Log_TabSheet: TTabSheet;
    Log_Memo: TMemo;
    Command_TabSheet: TTabSheet;
    Command_Memo: TMemo;
    Quotation_Sign__Use_CheckBox: TCheckBox;
    Execute_Label: TLabel;
    Database_Memo_Horizontal_Splitter: TSplitter;
    Parameter__Align_Correct_Button: TButton;
    DosCommand1: TDosCommand;
    Log_SynEdit: TSynEdit;
    Log__Auto_Scroll__Seconds_SpinEdit: TSpinEdit;
    procedure FormCreate( Sender: TObject );
    procedure FormShow( Sender: TObject );
    procedure FormActivate( Sender: TObject );
    procedure FormDestroy( Sender: TObject );

    procedure Command_Prepare_ButtonClick( Sender: TObject );
    procedure Execute_ButtonClick( Sender: TObject );

    procedure Database__Backup__File_Name__Set_ButtonClick( Sender: TObject );
    procedure Parameters__Refresh_ButtonClick( Sender: TObject );
    procedure File_Path_EditExit( Sender: TObject );
    procedure File_Path__Find_ButtonClick( Sender: TObject );
    procedure Database__Alias_ComboBoxChange( Sender: TObject );
    procedure Parameter__Align_Correct_ButtonClick( Sender: TObject );
    procedure Parameters__Backup_Restore_PageControlChange( Sender: TObject );

    procedure DosCommand1NewLine( ASender: TObject; const ANewLine: string; AOutputType: TOutputType );
    procedure DosCommand1Terminated( Sender: TObject );

    procedure Log_SynEditEnter( Sender: TObject );
    procedure Log_SynEditClick( Sender: TObject );
    procedure Log_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Log_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Log_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );

    procedure Database_Type_ComboBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Command_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
  private
    { Private declarations }
    command_prepared_correctly_g,
    done_correctly_g,
    form_activate_done_g
      : boolean;

    begin_date_time_g,
    end_date_time_g,
    log__auto_scroll__date_time_g
      : TDateTime;

    correctness_check_text_g : string;

    text__search_replace_form : Text__Search_Replace.TText__Search_Replace_Form;

    procedure Database__Backup_Restore__Parameter__Free();
  public
    { Public declarations }
    splitter_show__dbr : boolean;

    alias_initialize : string;

    databases_r_t : array of Common.TDatabases_r;
  end;

const
  database__backup_restore__parameters__backup_list__file_name_c : string = 'Database__Backup_Restore__Parameters__Backup_List.txt';
  database__backup_restore__parameters__general_list__file_name_c : string = 'Database__Backup_Restore__Parameters__General_List.txt';
  database__backup_restore__parameters__restore_list__file_name_c : string = 'Database__Backup_Restore__Parameters__Restore_List.txt';
  database__backup_restore__parameters__value__date_time_c : string = '<date_time>';
  database__backup_restore__parameters__value__password_c : string = '<password>';
  database__backup_restore__parameters__value__quotation_sign_c : string = '<quotation_sign>';
  database__backup_restore__parameters__value__user_name_c : string = '<user_name>';

var
  Database__Backup_Restore_Form: TDatabase__Backup_Restore_Form;

implementation

uses
  System.DateUtils,
  System.IOUtils,
  System.TypInfo,
  System.UITypes,
  //Winapi.ShellAPI,

  Database__Backup_Restore__Parameter,
  Shared,
  Translation;

{$R *.dfm}

procedure TDatabase__Backup_Restore_Form.Database__Backup_Restore__Parameter__Free();
var
  i : integer;
begin

  for i := Parameters__General_ScrollBox.ControlCount - 1 downto 0 do
    if Parameters__General_ScrollBox.Controls[ i ].ClassType = Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter then
      FreeAndNil( Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter(Parameters__General_ScrollBox.Controls[ i ]) );

  for i := Parameters__Backup_ScrollBox.ControlCount - 1 downto 0 do
    if Parameters__Backup_ScrollBox.Controls[ i ].ClassType = Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter then
      FreeAndNil( Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter(Parameters__Backup_ScrollBox.Controls[ i ]) );

  for i := Parameters__Restore_ScrollBox.ControlCount - 1 downto 0 do
    if Parameters__Restore_ScrollBox.Controls[ i ].ClassType = Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter then
      FreeAndNil( Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter(Parameters__Restore_ScrollBox.Controls[ i ]) );

end;

procedure TDatabase__Backup_Restore_Form.FormCreate( Sender: TObject );
var
  search_rec : TSearchRec;
begin

  alias_initialize := '';
  command_prepared_correctly_g := false;
  form_activate_done_g := false;
  log__auto_scroll__date_time_g := Now();
  splitter_show__dbr := true;
  text__search_replace_form := nil;

  Database__Backup__Application__File_Path_Edit.Text := Common.database__backup__application__file_path;

  if    ( Database__Backup__File_Name__Date_Time_RadioGroup.Items.Count > 0 )
    and ( Common.database__backup__file_name__suffix_default__item_index >= 0 )
    and ( Common.database__backup__file_name__suffix_default__item_index <= Database__Backup__File_Name__Date_Time_RadioGroup.Items.Count - 1 ) then
    Database__Backup__File_Name__Date_Time_RadioGroup.ItemIndex := Common.database__backup__file_name__suffix_default__item_index;

  Log__Auto_Scroll__Seconds_SpinEdit.Value := Common.log__auto_scroll__seconds;


  Database_Type_ComboBox.Items.Clear();

  if FindFirst(  Common.Databases_Type__Directory_Path__Get( '' ) + '*.*', faDirectory, search_rec  ) = 0 then
    begin

      repeat

        if    ( search_rec.Attr = faDirectory )
          and ( search_rec.Name <> '.' )
          and ( search_rec.Name <> '..' ) then
          Database_Type_ComboBox.Items.Add( search_rec.Name );

      until FindNext( search_rec ) <> 0;

    end;

  FindClose( search_rec );


  Log_PageControl.ActivePage := Log_TabSheet;
  Parameters__Backup_Restore_PageControl.ActivePage := Parameters__Backup_TabSheet;


  Translation.Translation__Apply( Self );


  Parameters__Backup_Restore_PageControlChange( Sender );

  //Log_Memo.Lines.Add( 'Hints and descriptions source: http://www.destructor.de/firebird/gbak.htm' );
  Log_SynEdit.Lines.Add( 'Hints and descriptions source: http://www.destructor.de/firebird/gbak.htm' );

end;

procedure TDatabase__Backup_Restore_Form.FormShow( Sender: TObject );
var
  i : integer;
begin

  Database__Alias_ComboBox.Items.Clear();
  Database__Alias_ComboBox.Items.Add( '' );

  for i := 0 to Length( databases_r_t ) - 1 do
    begin

      Database__Alias_ComboBox.Items.Add( databases_r_t[ i ].alias );

    end;


  File_Path_EditExit( Database__Backup__Application__File_Path_Edit );
  File_Path_EditExit( Database__File_Path_Edit );
  File_Path_EditExit( Database__Backup__File_Path_Edit );


  Common.Font__Set( Command_Memo.Font, Common.sql_editor__font );
  //Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Log_SynEdit.Font, Common.sql_editor__font );

  Common.Syn_Edit__Parameters__Set( Log_SynEdit );


  Common.Syn_Edit__Search_Text_Hightlighter_Syn_Edit_Plugin__Create( Log_SynEdit );

end;

procedure TDatabase__Backup_Restore_Form.FormActivate( Sender: TObject );
var
  i : integer;
begin

  if form_activate_done_g then
    Exit;


  form_activate_done_g := true;


  if Parameters__General_GroupBox.Width < Round( Self.Width * 0.5 ) then
    Parameters__General_GroupBox.Width := Round( Self.Width * 0.5 );


  if Trim( alias_initialize ) <> '' then
    for i := 0 to Database__Alias_ComboBox.Items.Count - 1 do
      if Database__Alias_ComboBox.Items[ i ] = alias_initialize then
        begin

          Database__Alias_ComboBox.ItemIndex := i;
          Database__Alias_ComboBoxChange( Sender );
          Database__Backup__File_Name__Set_ButtonClick( Sender );

          Break;

        end;

end;

procedure TDatabase__Backup_Restore_Form.FormDestroy( Sender: TObject );
begin

  Database__Backup_Restore__Parameter__Free();


  Common.Text__Search_Replace__Syn_Edit__Set( nil, text__search_replace_form );
  Common.Text__Search_Replace__Hide( text__search_replace_form );


  if text__search_replace_form <> nil then
    FreeAndNil( text__search_replace_form );

end;

procedure TDatabase__Backup_Restore_Form.Command_Prepare_ButtonClick( Sender: TObject );

  function Quotation_Sign__DBR_L() : string;
  begin

    if Quotation_Sign__Use_CheckBox.Checked then
      begin

        Result := Common.database__backup_restore__quotation_sign;

      end
    else
      Result := '';

  end;

var
  i : integer;

  zts_1,
  zts_2
    : string;
begin

  command_prepared_correctly_g := false;


  if Trim( Database__File_Path_Edit.Text ) = '' then
    begin

      Database__File_Path_Edit.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.database_file_path_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;

  if Trim( Database__Backup__File_Path_Edit.Text ) = '' then
    begin

      Database__Backup__File_Path_Edit.SetFocus();
      Application.MessageBox( PChar(Translation.translation__messages_r.backup_file_path_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  Log_PageControl.ActivePage := Command_TabSheet;


  zts_1 := '';


  for i := 0 to Parameters__General_ScrollBox.ControlCount - 1 do
    if Parameters__General_ScrollBox.Controls[ i ].ClassType = Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter then
      zts_1 := zts_1 + Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter(Parameters__General_ScrollBox.Controls[ i ]).Parameter_Get__DBRP();

  if Parameters__Backup_Restore_PageControl.ActivePage = Parameters__Backup_TabSheet then
    begin

      for i := 0 to Parameters__Backup_ScrollBox.ControlCount - 1 do
        if Parameters__Backup_ScrollBox.Controls[ i ].ClassType = Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter then
          zts_1 := zts_1 + Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter(Parameters__Backup_ScrollBox.Controls[ i ]).Parameter_Get__DBRP();

    end
  else
  if Parameters__Backup_Restore_PageControl.ActivePage = Parameters__Restore_TabSheet then
    begin

      for i := 0 to Parameters__Restore_ScrollBox.ControlCount - 1 do
        if Parameters__Restore_ScrollBox.Controls[ i ].ClassType = Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter then
          zts_1 := zts_1 + Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter(Parameters__Restore_ScrollBox.Controls[ i ]).Parameter_Get__DBRP();

    end;


  DateTimeToString( zts_2, 'yyyy mm dd hh mm ss', Now() );

  zts_1 := StringReplace( zts_1, database__backup_restore__parameters__value__date_time_c, zts_2, [ rfReplaceAll ] );
  zts_1 := StringReplace( zts_1, database__backup_restore__parameters__value__password_c, Password_Edit.Text, [ rfReplaceAll ] );
  zts_1 := StringReplace( zts_1, database__backup_restore__parameters__value__quotation_sign_c, Common.database__backup_restore__quotation_sign, [ rfReplaceAll ] );
  zts_1 := StringReplace( zts_1, database__backup_restore__parameters__value__user_name_c, User_Name_Edit.Text, [ rfReplaceAll ] );


  if Parameters__Backup_Restore_PageControl.ActivePage = Parameters__Backup_TabSheet then
    begin

      zts_1 := zts_1 +
        ' ' + Quotation_Sign__DBR_L() + Database__File_Path_Edit.Text + Quotation_Sign__DBR_L() +
        ' ' + Quotation_Sign__DBR_L() + Database__Backup__File_Path_Edit.Text + Quotation_Sign__DBR_L();

    end
  else
  if Parameters__Backup_Restore_PageControl.ActivePage = Parameters__Restore_TabSheet then
    begin

      zts_1 := zts_1 +
        ' ' + Quotation_Sign__DBR_L() + Database__Backup__File_Path_Edit.Text + Quotation_Sign__DBR_L() +
        ' ' + Quotation_Sign__DBR_L() + Database__File_Path_Edit.Text + Quotation_Sign__DBR_L();

    end;


  Command_Memo.Lines.Clear();
  Command_Memo.Lines.Add( Quotation_Sign__DBR_L() + Database__Backup__Application__File_Path_Edit.Text + Quotation_Sign__DBR_L() );
  Command_Memo.Lines.Add( zts_1 );


  command_prepared_correctly_g := true;

end;

procedure TDatabase__Backup_Restore_Form.Execute_ButtonClick( Sender: TObject );
var
  zti : integer;

  zts,
  application__file_path_l,
  application__parameters_l
    : string;
begin

  command_prepared_correctly_g := false;


  if Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked then
    begin

      Command_Prepare_ButtonClick( Sender );

      if not command_prepared_correctly_g then
        Exit;

      command_prepared_correctly_g := false;

    end;


  application__file_path_l := Command_Memo.Lines.Text;

  zti := Pos( #13 + #10, application__file_path_l );

  if zti > 0 then
    begin

      application__parameters_l := Copy(  application__file_path_l, zti + 2, Length( application__file_path_l )  );
      Delete(  application__file_path_l, zti, Length( application__file_path_l )  );

      application__parameters_l := StringReplace( application__parameters_l, #13 + #10, '', [ rfReplaceAll ] );

    end;


  //Winapi.ShellAPI.ShellExecute
  //  (
  //    0, nil,
  //    PChar(application__file_path_l),
  //    PChar(application__parameters_l),
  //    nil, SW_SHOW
  //  );
  //
  //Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );
  //
  //File_Path_EditExit( Backup__File_Path_Edit );


  done_correctly_g := false;


  if Parameters__Backup_Restore_PageControl.ActivePage = Parameters__Backup_TabSheet then
    begin

      correctness_check_text_g := Common.database__correctness_check_text__backup;

    end
  else
  if Parameters__Backup_Restore_PageControl.ActivePage = Parameters__Restore_TabSheet then
    begin

      correctness_check_text_g := Common.database__correctness_check_text__restore;

    end
  else
    correctness_check_text_g := '';


  Log_PageControl.ActivePage := Log_TabSheet;

  //Log_Memo.Lines.Add( '' );
  //Log_Memo.Lines.Add( '***' );
  //Log_Memo.Lines.Add( '' );
  Log_SynEdit.Lines.Add( '' );
  Log_SynEdit.Lines.Add( '***' );
  Log_SynEdit.Lines.Add( '' );

  begin_date_time_g := Now();

  DateTimeToString( zts, 'yyyy mm dd hh:mm:ss', begin_date_time_g );

  //Log_Memo.Lines.Add( Execute_Label.Caption + ' ' + zts );
  Log_SynEdit.Lines.Add( Execute_Label.Caption + ' ' + zts );
  log__auto_scroll__date_time_g := Now();


  //DosCommand1.CommandLine := Command_Memo.Lines.Text;
  DosCommand1.CommandLine := application__file_path_l + application__parameters_l;
  DosCommand1.CurrentDir := '';
  DosCommand1.Execute();

end;

procedure TDatabase__Backup_Restore_Form.Database__Backup__File_Name__Set_ButtonClick( Sender: TObject );
var
  zts : string;
begin

  if Trim( Database__File_Path_Edit.Text ) = '' then
    Exit;


  Database__Backup__File_Path_Edit.Text :=
    ExtractFilePath( Database__File_Path_Edit.Text ) +
    System.IOUtils.TPath.GetFileNameWithoutExtension( Database__File_Path_Edit.Text );


  if Database__Backup__File_Name__Date_Time_RadioGroup.ItemIndex = 1 then // date.
    begin

      DateTimeToString( zts, 'yyyy mm dd', Now() );

      Database__Backup__File_Path_Edit.Text := Database__Backup__File_Path_Edit.Text +
        ' ' + zts;

    end
  else
  if Database__Backup__File_Name__Date_Time_RadioGroup.ItemIndex = 2 then // time.
    begin

      DateTimeToString( zts, 'yyyy mm dd hh mm ss', Now() );

      Database__Backup__File_Path_Edit.Text := Database__Backup__File_Path_Edit.Text +
        ' ' + zts;

    end;


  Database__Backup__File_Path_Edit.Text := Database__Backup__File_Path_Edit.Text +
    Common.database__backup__file__default_extension;


  File_Path_EditExit( Database__Backup__File_Path_Edit );

end;

procedure TDatabase__Backup_Restore_Form.Parameters__Refresh_ButtonClick( Sender: TObject );

  procedure Active_Page_Index__Inc();
  begin

    if Parameters__Backup_Restore_PageControl.PageCount <= 0 then
      Exit;


    if Parameters__Backup_Restore_PageControl.ActivePageIndex < Parameters__Backup_Restore_PageControl.PageCount - 1 then
      Parameters__Backup_Restore_PageControl.ActivePageIndex := Parameters__Backup_Restore_PageControl.ActivePageIndex + 1
    else
      Parameters__Backup_Restore_PageControl.ActivePageIndex := 0;

  end;

  procedure Parameters__Refresh( parent_f : Vcl.Controls.TWinControl; const file_name_f : string );
  var
    checked_l : boolean;

    zti : integer;

    zts_1,
    zts_2,
    parameter__description_l,
    parameter__hint_l,
    parameter__name_l,
    parameter__values_l
      : string;
  begin

    zts_1 := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( Database_Type_ComboBox.Text ) + file_name_f  );


    if Trim( zts_1 ) = '' then
      begin

        //Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( Database_Type_ComboBox.Text ) + file_name_f + ').' );
        Log_SynEdit.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( Database_Type_ComboBox.Text ) + file_name_f + ').' );

        // checked_l|parameter__name_l|parameter__description_l|parameter__hint_l|parameter__values_l
        //
        // checked_l = Common.db_grid__positive_value_c -> true
        // parameter__values_l
        //   <password>
        //   <user_name>
        //   abc|def|ghi|

        // http://www.destructor.de/firebird/gbak.htm

        if file_name_f = database__backup_restore__parameters__backup_list__file_name_c then
          zts_1 :=
            '|-CONVERT|Backup external files as tables.|Converts external tables to internal tables.|' + #13 + #10 +
            '|-EXPAND|No data compression.|Creates an uncompressed backup.|' + #13 + #10 +
            '|-FACTOR|Blocking factor.|Blocking factor for tape device.|' + #13 + #10 +
            'V|-GARBAGE_COLLECT|Inhibit garbage collection.|Does not perform garbage collection during backup, so the backup will be faster. When you plan to da a Restore or Sweep anyway after the backup.|' + #13 + #10 +
            '|-IGNORE|Ignore bad checksums.|Ignores checksum errors while backing up.|' + #13 + #10 +
            '|-LIMBO|Ignore transactions in limbo.|Ignores limbo transactions while backing up.|' + #13 + #10 +
            '|-NODBTRIGGERS|Do not run database triggers.|Suppresses Database Triggers from running [Firebird 2.1].|' + #13 + #10 +
            '|-NT|Non-Transportable backup file format.|Non-transportable format (use only when you know you will restore on same platform and database version).|' + #13 + #10 +
            '|-OLD_DESCRIPTIONS|Save old style metadata descriptions.||' + #13 + #10 +
            'V|-TRANSPORTABLE|Transportable backup -- data in XDR format.|Creates a transportable backup (transportable between platforms and server versions). This is the default.|' + #13 + #10
        else
        if file_name_f = database__backup_restore__parameters__restore_list__file_name_c then
          zts_1 :=
            '|-BUFFERS|Override page buffers default.|Set cache size for restored database.|' + #13 + #10 +
            '|-FIX_FSS_DATA|Fix malformed UNICODE_FSS data.|Repair malformed UNICODE_FSS data during Restore [Firebird 2.5].|<charset>|' + #13 + #10 +
            '|-FIX_FSS_METADATA|Fix malformed UNICODE_FSS metadata.|Repair malformed UNICODE_FSS metadata during Restore [Firebird 2.5].|<charset>|' + #13 + #10 +
            '|-INACTIVE|Deactivate indexes during restore.|All indexes will be restored as INACTIVE.|' + #13 + #10 +
            '|-KILL|Restore without creating shadows.|Does not create shadows that are defined in the backup.|' + #13 + #10 +
            '|-MODE|"Read_only" or "read_write" access.|read_write - Restores to a read/write database (This is the default). read_only - restores to a read-only database.|read_write|read_only|' + #13 + #10 +
            '|-NO_VALIDITY|Do not restore database validity conditions.|Does not restore validity constraints. So you can restore data that does not meet these constraints and could not be restored otherwise.|' + #13 + #10 +
            '|-ONE_AT_A_TIME|Restore one table at a time.|Usually the restore takes place in one single transaction for the whole database. This switch puts a commit after each table. So you can use this to partially restore databases with corrupt table data.|' + #13 + #10 +
            '|-PAGE_SIZE|Override default page size.|Sets page size of new database. <size> can be one of 1024, 2048, 4096, 8192. Default is 1024.|4096|1024|2048|4096|8192|' + #13 + #10 +
            'V|-REPLACE_DATABASE|Replace database from backup file restore.|Restores over an existing database. This can only be performed by SYSDBA or the owner of the database that is overwritten. Do NOT restore over a database that is in use! [Firebird 1.0, 1.5].|' + #13 + #10 +
            '|-USE_ALL_SPACE|Do not reserve space for record versions.|Normally, on restore, database pages will be filled to about 80 %. With the use_all_space option, database pages will be filled to 100 %.' +
              ' (Useful for read-only databases which will see no more modifications.)|' + #13 + #10
        else
        if file_name_f = database__backup_restore__parameters__general_list__file_name_c then
          zts_1 :=
            '|-FETCH_PASSWORD|Fetch password from file.|Instead of -password: Fetch password from the file so it is not visible in the command line. When <filename> is stdin, the user will be prompted for the password. [Firebird 2.5].|' + database__backup_restore__parameters__value__quotation_sign_c + '<filename>' + database__backup_restore__parameters__value__quotation_sign_c + '|' + #13 + #10 +
            '|-META_DATA|Backup or restore metadata only.|Only backs up/restores metadata (schema). No table data will be re/stored.|' + #13 + #10 +
            'V|-PASSWORD <password>|Firebird password.|Database password.|' + #13 + #10 +
            '|-ROLE|Firebird SQL role.|Connect as role.|<role>|' + #13 + #10 +
            '|-SERVICE|Use services manager.|Backup: Creates the backup file on the database server, using the Service Manager. Restore: Creates the database from a backup file on the server, using the Service Manager. The backup file, database file, and log file all' +
              ' must reside on the filesystem of this server. So all path names (for database file, backup file, log file) must be specified as viewed from the server''s perspective, even when this is called from a remote machine.|' + #13 + #10 +
            '|-SKIP_DATA|Skip data for table.||' + #13 + #10 +
            '|-STATISTICS TDRW|Show statistics: T - time from start, D - delta time, R - page reads, W - page writes.||' + #13 + #10 +
            '|-TRUSTED|Use trusted authentication.||' + #13 + #10 +
            'V|-USER <user_name>|Firebird user name.|Database user name.|' + #13 + #10 +
            'V|-VERIFY|Report each action taken.|Verbose (verify) output of what GBAK is doing.|' + #13 + #10 +
            '|-VERBINT|Verbose information with explicit interval (min 100).||<n>|' + #13 + #10 +
            '|-Y|Redirect/suppress status message output.|Create Logfile: Redirect all output messages to <filename> The file must not exist before running GBAK! So you have to delete it before the GBAK call. When you use -se (Service Manager), the logfile will' +
              ' (can only) reside on the server''s filesystem. |' + database__backup_restore__parameters__value__quotation_sign_c + '<path>' + database__backup_restore__parameters__value__date_time_c + database__backup_restore__parameters__value__quotation_sign_c + '|' + #13 + #10 +
            '|-Z|Print version number.|Show GBAK version and server version.|' + #13 + #10;

      end;


    zti := Pos( #13 + #10, zts_1 );

    while zti > 1 do
      begin

        checked_l := false;
        parameter__description_l := '';
        parameter__hint_l := '';
        parameter__name_l := '';
        parameter__values_l := '';


        zts_2 := Copy( zts_1, 1, zti );
        Delete( zts_1, 1, zti + 1 );


        zti := Pos( Common.database__backup_restore__parameters__separator_c, zts_2 );

        if zti > 0 then
          begin

            checked_l := Pos( Common.db_grid__positive_value_c, zts_2 ) = 1;

            Delete( zts_2, 1, zti );


            zti := Pos( Common.database__backup_restore__parameters__separator_c, zts_2 );

            if zti > 0 then
              begin

                parameter__name_l := Copy( zts_2, 1, zti - 1 );

                Delete( zts_2, 1, zti );


                zti := Pos( Common.database__backup_restore__parameters__separator_c, zts_2 );

                if zti > 0 then
                  begin

                    parameter__description_l := Copy( zts_2, 1, zti - 1 );

                    Delete( zts_2, 1, zti );


                    zti := Pos( Common.database__backup_restore__parameters__separator_c, zts_2 );

                    if zti > 0 then
                      begin

                        parameter__hint_l := Copy( zts_2, 1, zti - 1 );

                        Delete( zts_2, 1, zti );


                        zti := Pos( Common.database__backup_restore__parameters__separator_c, zts_2 );

                        if zti > 0 then
                          begin

                            parameter__values_l := zts_2;

                          end;

                      end;

                  end;

              end;


            Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter.Create
              (
                parent_f,
                checked_l,
                parameter__name_l,
                parameter__description_l,
                parameter__hint_l,
                parameter__values_l,
                splitter_show__dbr
              ).Align_Correct__DBRP();

          end;


        zti := Pos( #13 + #10, zts_1 );

      end;

  end;

var
  zti : integer;
begin

  Database__Backup_Restore__Parameter__Free();


  Parameters__Refresh( Parameters__General_ScrollBox, database__backup_restore__parameters__general_list__file_name_c );
  Parameters__Refresh( Parameters__Backup_ScrollBox, database__backup_restore__parameters__backup_list__file_name_c );
  Parameters__Refresh( Parameters__Restore_ScrollBox, database__backup_restore__parameters__restore_list__file_name_c );


  zti := Parameters__Backup_Restore_PageControl.ActivePageIndex;

  Parameter__Align_Correct_ButtonClick( Sender );

  Active_Page_Index__Inc();


  while zti <> Parameters__Backup_Restore_PageControl.ActivePageIndex do
    begin

      Parameter__Align_Correct_ButtonClick( Sender );

      Active_Page_Index__Inc();

    end;

end;

procedure TDatabase__Backup_Restore_Form.File_Path_EditExit( Sender: TObject );
begin

  if    ( Sender <> nil )
    and ( Sender is TEdit )then
    if    (  Trim( TEdit(Sender).Text ) <> ''  )
      and (  not FileExists( TEdit(Sender).Text )  ) then
      TEdit(Sender).Color := Common.color__red__light_c
    else
      TEdit(Sender).Color := clWindow;

end;

procedure TDatabase__Backup_Restore_Form.File_Path__Find_ButtonClick( Sender: TObject );
var
  zt_edit : TEdit;
begin

  if Sender <> nil then
    begin

      zt_edit := nil;


      if TComponent(Sender).Name = Database__Backup__Application__File_Path__Find_Button.Name then
        begin

          zt_edit := Database__Backup__Application__File_Path_Edit;

          OpenDialog1.DefaultExt := Common.exe__file__default_extension;
          OpenDialog1.Filter := Translation.translation__messages_r.application_files + '|*' + Common.exe__file__default_extension + '|' + Translation.translation__messages_r.all_files + '|' + Common.all_files_find__filter;
          OpenDialog1.Options := OpenDialog1.Options + [ System.UITypes.TOpenOption.ofFileMustExist ];

        end
      else
        begin

          if TComponent(Sender).Name = Database__Backup__File_Path__Find_Button.Name then
            begin

              zt_edit := Database__Backup__File_Path_Edit;

              OpenDialog1.DefaultExt := Common.database__backup__file__default_extension;
              OpenDialog1.Filter := Translation.translation__messages_r.firebird_backup_files + '|*' + Common.database__backup__file__default_extension + '|' + Translation.translation__messages_r.firebird_database_files + '|*' + Common.database__file__default_extension + '|' + Translation.translation__messages_r.all_files + '|' + Common.all_files_find__filter;

            end
          else
            begin

              zt_edit := Database__File_Path_Edit;

              OpenDialog1.DefaultExt := Common.database__file__default_extension;
              OpenDialog1.Filter := Translation.translation__messages_r.firebird_database_files + '|*' + Common.database__file__default_extension + '|' + Translation.translation__messages_r.firebird_backup_files + '|*' + Common.database__backup__file__default_extension + '|' + Translation.translation__messages_r.all_files + '|' + Common.all_files_find__filter;

            end;

          OpenDialog1.Options := OpenDialog1.Options - [ System.UITypes.TOpenOption.ofFileMustExist ];

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

procedure TDatabase__Backup_Restore_Form.Database__Alias_ComboBoxChange( Sender: TObject );
var
  i : integer;
begin

  if Database__Alias_ComboBox.ItemIndex = 0 then
    begin

      Database__File_Path_Edit.Text := '';
      Exit;

    end;


  if   ( Database__Alias_ComboBox.ItemIndex < 1 )
    or (  Database__Alias_ComboBox.ItemIndex > Length( databases_r_t )  ) then
    Exit;


  Database__File_Path_Edit.Text := databases_r_t[ Database__Alias_ComboBox.ItemIndex - 1 ].fire_dac__file_path;

  for i := 0 to Database_Type_ComboBox.Items.Count - 1 do
    if Database_Type_ComboBox.Items[ i ] = databases_r_t[ Database__Alias_ComboBox.ItemIndex - 1 ].database_type then
      begin

        Database_Type_ComboBox.ItemIndex := i;

        if Parameters__General_ScrollBox.ControlCount <= 0 then
          Parameters__Refresh_ButtonClick( Sender );

        Break;

      end;


  Password_Edit.Text := databases_r_t[ Database__Alias_ComboBox.ItemIndex - 1 ].password;
  User_Name_Edit.Text := databases_r_t[ Database__Alias_ComboBox.ItemIndex - 1 ].user_name;


  File_Path_EditExit( Database__File_Path_Edit );

end;

procedure TDatabase__Backup_Restore_Form.Parameter__Align_Correct_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  for i := 0 to Parameters__General_ScrollBox.ControlCount - 1 do
    if Parameters__General_ScrollBox.Controls[ i ].ClassType = Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter then
      Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter(Parameters__General_ScrollBox.Controls[ i ]).Align_Correct__DBRP();

  for i := 0 to Parameters__Backup_ScrollBox.ControlCount - 1 do
    if Parameters__Backup_ScrollBox.Controls[ i ].ClassType = Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter then
      Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter(Parameters__Backup_ScrollBox.Controls[ i ]).Align_Correct__DBRP();

  for i := 0 to Parameters__Restore_ScrollBox.ControlCount - 1 do
    if Parameters__Restore_ScrollBox.Controls[ i ].ClassType = Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter then
      Database__Backup_Restore__Parameter.TDatabase__Backup_Restore__Parameter(Parameters__Restore_ScrollBox.Controls[ i ]).Align_Correct__DBRP();

end;

procedure TDatabase__Backup_Restore_Form.Parameters__Backup_Restore_PageControlChange( Sender: TObject );
begin

  Execute_Label.Caption := Parameters__Backup_Restore_PageControl.ActivePage.Caption;

end;

procedure TDatabase__Backup_Restore_Form.DosCommand1NewLine( ASender: TObject; const ANewLine: string; AOutputType: TOutputType );
begin

  if AOutputType = DosCommand.otEntireLine then
    begin

      if    ( not done_correctly_g )
        and (  Length( correctness_check_text_g ) > 0  )
        and (  Pos( correctness_check_text_g, ANewLine ) = 1  ) then
        done_correctly_g := true;


      //Log_Memo.Lines.Add( ANewLine );
      Log_SynEdit.Lines.Add( ANewLine );


      if   ( Log__Auto_Scroll__Seconds_SpinEdit.Value = 0 )
        or (
                 ( Log__Auto_Scroll__Seconds_SpinEdit.Value > 0 )
             and (  System.DateUtils.SecondsBetween( Now(), log__auto_scroll__date_time_g ) >= Log__Auto_Scroll__Seconds_SpinEdit.Value  )
           ) then
        begin

          Log_SynEdit.GotoLineAndCenter( Log_SynEdit.Lines.Count );

          if Log__Auto_Scroll__Seconds_SpinEdit.Value > 0 then
            log__auto_scroll__date_time_g := Now();

        end;

    end;

end;

procedure TDatabase__Backup_Restore_Form.DosCommand1Terminated( Sender: TObject );
var
  zts_1,
  zts_2
    : string;
begin

  end_date_time_g := Now();

  DateTimeToString( zts_1, 'yyyy mm dd hh:mm:ss', begin_date_time_g );
  DateTimeToString( zts_2, 'yyyy mm dd hh:mm:ss', end_date_time_g );

  //Log_Memo.Lines.Add(  Translation.translation__messages_r.done + ' ' + zts_1 + ' -> ' + zts_2 + ' (' + Common.TSDBM.Duration_To_String( begin_date_time_g, end_date_time_g ) + ')'  );
  Log_SynEdit.Lines.Add(  Translation.translation__messages_r.done + ' ' + zts_1 + ' -> ' + zts_2 + ' (' + Common.TSDBM.Duration_To_String( begin_date_time_g, end_date_time_g ) + ')'  );
  Log_SynEdit.GotoLineAndCenter( Log_SynEdit.Lines.Count );

  File_Path_EditExit( Database__Backup__File_Path_Edit );


  if done_correctly_g then
    Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION )
  else
    Application.MessageBox( PChar(Translation.translation__messages_r.errors_were_encountered), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONEXCLAMATION );

end;

procedure TDatabase__Backup_Restore_Form.Log_SynEditEnter( Sender: TObject );
begin

  Common.Text__Search_Replace__Syn_Edit__Set( Log_SynEdit, text__search_replace_form );

end;

procedure TDatabase__Backup_Restore_Form.Log_SynEditClick( Sender: TObject );
begin

  Common.Syn_Edit__Words_Highlight( Log_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( Log_SynEdit, text__search_replace_form );

end;

procedure TDatabase__Backup_Restore_Form.Log_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Common.Syn_Edit_Key_Down( Log_SynEdit, Sender, Key, Shift );

end;

procedure TDatabase__Backup_Restore_Form.Log_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Common.Syn_Edit__Words_Highlight( Log_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( Log_SynEdit, text__search_replace_form );

end;

procedure TDatabase__Backup_Restore_Form.Log_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );
begin

  Common.Syn_Edit__On_Replace_Text(  Log_SynEdit, ASearch, AReplace, Line, Column, Action, ClientToScreen( Self.ClientRect )  );

end;

procedure TDatabase__Backup_Restore_Form.Database_Type_ComboBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_RETURN then
    Parameters__Refresh_ButtonClick( Sender );

end;

procedure TDatabase__Backup_Restore_Form.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TDatabase__Backup_Restore_Form.Command_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Command_Memo.SelectAll();

end;

end.
