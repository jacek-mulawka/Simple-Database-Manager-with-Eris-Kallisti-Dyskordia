unit Table_Column__Values_Distinct;{08.Lis.2023}

interface

uses
  Common,
  Migawka_Prostokat_Tabela_2_SDBM,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.Grids,
  Vcl.DBGrids, Data.DB;

type
  TTable_Column__Values_Distinct_Form = class( TForm )
    Value_DBEdit: TDBEdit;
    Search_GroupBox: TGroupBox;
    Search_Edit: TEdit;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Prior_Button: TButton;
    Search__Next_Button: TButton;
    Record_Number__Records_Count_Label: TLabel;
    Log_Memo: TMemo;
    Log_Horizontal_Splitter: TSplitter;
    Refresh_Button: TButton;
    Table_Column__Values_Distinct_DBGrid: TDBGrid;
    Table_Column__Values_Distinct_DataSource: TDataSource;
    No_Thread_Timer: TTimer;
    Ok_Button: TButton;
    Close_Button: TButton;
    procedure FormCreate( Sender: TObject );
    procedure FormShow( Sender: TObject );
    procedure FormClose( Sender: TObject; var Action: TCloseAction );
    procedure FormDestroy( Sender: TObject );

    procedure Value_DBEditChange( Sender: TObject );
    procedure Search_Change( Sender: TObject );
    procedure Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );

    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Ok_ButtonClick( Sender: TObject );
    procedure Close_ButtonClick( Sender: TObject );

    procedure No_Thread_TimerTimer( Sender: TObject );

    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Table_Column__Values_Distinct_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
    procedure Table_Column__Values_Distinct_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Table_Column__Values_Distinct_DBGridTitleClick( Column: TColumn );
  private
    { Private declarations }
    sort__direction_ascending_g,
    task_is_running_g
      : boolean;

    table_column__values_distinct_sdbm : Common.TSDBM;

    busy_notification__knight_rider_equalizer : Migawka_Prostokat_Tabela_2_SDBM.TMigawka_Prostokat_Tabela_2;

    procedure Busy_Notification_Set( const busy_f : boolean );
    function Quotation_Sign__TCVD() : string;
  public
    { Public declarations }
    queries_open_in_background_g,
    sql__quotation_sign__use__tcvd
      : boolean;

    column_name__tcvd,
    database_type__tcvd,
    sql__quotation_sign__tcvd,
    table_name__tcvd,
    value_selected__tcvd
      : string;

    table_column__values_distinct_form_list : TList;

    constructor Create( AOwner : TComponent; sdbm_f : Common.TSDBM ); overload;

    function Task_Running_Check__TCVD( const message_show_f : boolean = true ) : boolean;
  end;

const
  table_column__values_distinct__sql__file_name_c : string = 'Table_Column__Values_Distinct__sql.txt';

var
  Table_Column__Values_Distinct_Form: TTable_Column__Values_Distinct_Form;

implementation

uses
  System.Threading,
  Vcl.Clipbrd,

  Shared,
  Translation;

{$R *.dfm}

procedure TTable_Column__Values_Distinct_Form.Busy_Notification_Set( const busy_f : boolean );
begin

  // Nested functions not allowed in threads.

  if    ( busy_f )
    and (  Pos( Common.notification__sign__busy_c, Self.Caption ) <= 0  ) then
    Self.Caption := Self.Caption + Common.notification__sign__busy_c
  else
  if    ( not busy_f )
    and (  Pos( Common.notification__sign__busy_c, Self.Caption ) > 0  ) then
    Self.Caption := StringReplace( Self.Caption, Common.notification__sign__busy_c, '', [ rfReplaceAll ] );


  if busy_f then
    begin

      busy_notification__knight_rider_equalizer.Szerokoœæ_Koryguj();
      busy_notification__knight_rider_equalizer.Tryb_Ustaw( Migawka_Prostokat_Tabela_2_SDBM.mpt2_Migaj );

    end
  else
    busy_notification__knight_rider_equalizer.Tryb_Ustaw( Migawka_Prostokat_Tabela_2_SDBM.mpt2_Mignij );


  Value_DBEditChange( nil );

end;

function TTable_Column__Values_Distinct_Form.Quotation_Sign__TCVD() : string;
begin

  if sql__quotation_sign__use__tcvd then
    begin

      Result := sql__quotation_sign__tcvd;

    end
  else
    Result := '';

end;

function TTable_Column__Values_Distinct_Form.Task_Running_Check__TCVD( const message_show_f : boolean = true ) : boolean;
begin

  Result := task_is_running_g;


  if    ( Result )
    and ( message_show_f ) then
    Application.MessageBox( PChar(Translation.translation__messages_r.task_is_still_running_wait_until_finish), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );

end;

constructor TTable_Column__Values_Distinct_Form.Create( AOwner : TComponent; sdbm_f : Common.TSDBM );
begin

  inherited Create( AOwner );


  table_column__values_distinct_sdbm := Common.TSDBM.Create( sdbm_f );
  table_column__values_distinct_sdbm.Component_Type_Set( sdbm_f.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

end;

procedure TTable_Column__Values_Distinct_Form.FormCreate( Sender: TObject );
begin

  column_name__tcvd := '';
  queries_open_in_background_g := true;
  sort__direction_ascending_g := true;
  table_column__values_distinct_form_list := nil;
  table_name__tcvd := '';
  task_is_running_g := false;
  value_selected__tcvd := '';


  Translation.Translation__Apply( Self );

end;

procedure TTable_Column__Values_Distinct_Form.FormShow( Sender: TObject );
var
  zts : string;
begin

  Search_GroupBox.Caption := Search_GroupBox.Caption +
    ' ' +
    Self.Quotation_Sign__TCVD() + table_name__tcvd + Self.Quotation_Sign__TCVD() +
    Common.sql__names_separator +
    Self.Quotation_Sign__TCVD() + column_name__tcvd + Self.Quotation_Sign__TCVD();


  Log_Memo.Height := 1;

  Log_Memo.Lines.Add( table_name__tcvd );
  Log_Memo.Lines.Add( column_name__tcvd );


  Ok_Button.Visible := fsModal in Self.FormState;

  //Ok_Button.Default := Ok_Button.Visible;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tcvd ) + table_column__values_distinct__sql__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tcvd ) + table_column__values_distinct__sql__file_name_c + ').' );

      zts :=
        'select distinct ' +
        Self.Quotation_Sign__TCVD() + table_name__tcvd + Self.Quotation_Sign__TCVD() +
        Common.sql__names_separator +
        Self.Quotation_Sign__TCVD() + column_name__tcvd + Self.Quotation_Sign__TCVD() +
        ' from ' +
        Self.Quotation_Sign__TCVD() + table_name__tcvd + Self.Quotation_Sign__TCVD() + ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TCVD() + column_name__tcvd + Self.Quotation_Sign__TCVD(), [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TCVD() + table_name__tcvd + Self.Quotation_Sign__TCVD(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if table_column__values_distinct_sdbm.Query__Active() then
    table_column__values_distinct_sdbm.Query__Close();


  table_column__values_distinct_sdbm.Query__Sql__Set( zts );


  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    Common.Font__Set( Table_Column__Values_Distinct_DBGrid.Font, Common.sql_editor__font );


  busy_notification__knight_rider_equalizer := Migawka_Prostokat_Tabela_2_SDBM.TMigawka_Prostokat_Tabela_2.Create( Self );


  table_column__values_distinct_sdbm.Data_Source__Data_Set__Set( Table_Column__Values_Distinct_DataSource );
  Value_DBEdit.DataField := column_name__tcvd;


  if queries_open_in_background_g then
    Refresh_ButtonClick( Sender )
  else
    No_Thread_Timer.Enabled := true;

end;

procedure TTable_Column__Values_Distinct_Form.FormClose( Sender: TObject; var Action: TCloseAction );
begin

  if Self.Task_Running_Check__TCVD() then
    begin

      Action := TCloseAction.caNone;
      Exit;

    end;


  if table_column__values_distinct_form_list <> nil then
    table_column__values_distinct_form_list.Remove( Self );


  if not ( fsModal in Self.FormState ) then
    Action := TCloseAction.caFree;

end;

procedure TTable_Column__Values_Distinct_Form.FormDestroy( Sender: TObject );
begin

  if table_column__values_distinct_sdbm <> nil then
    begin

      if table_column__values_distinct_sdbm.Query__Active() then
        table_column__values_distinct_sdbm.Query__Close();


      FreeAndNil( table_column__values_distinct_sdbm );

    end;


  FreeAndNil( busy_notification__knight_rider_equalizer );

end;

procedure TTable_Column__Values_Distinct_Form.Value_DBEditChange( Sender: TObject );
begin

  if Self.Task_Running_Check__TCVD( false ) then
    Exit;


  if    ( table_column__values_distinct_sdbm <> nil )
    and ( table_column__values_distinct_sdbm.Query__Active() ) then
    begin

      Record_Number__Records_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', table_column__values_distinct_sdbm.Query__Record_Number() )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', table_column__values_distinct_sdbm.Query__Record_Count() )  );

    end
  else
    Record_Number__Records_Count_Label.Caption := '0 / 0';

end;

procedure TTable_Column__Values_Distinct_Form.Search_Change( Sender: TObject );
var
  locate_options : Data.DB.TLocateOptions;
begin

  if Self.Task_Running_Check__TCVD() then
    Exit;


  if   ( table_column__values_distinct_sdbm = nil )
    or ( not table_column__values_distinct_sdbm.Query__Active() ) then
    Exit;


  locate_options := [];

  if Search__Case_Insensitive_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loCaseInsensitive ];

  if Search__Partial_Key_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loPartialKey ];


  if table_column__values_distinct_sdbm.Query__Locate( column_name__tcvd, Search_Edit.Text, locate_options ) then
    Search_Edit.Color := clWindow
  else
    begin

      Search_Edit.Color := Common.color__red__light_c;


      table_column__values_distinct_sdbm.Query__Disable_Controls();

      table_column__values_distinct_sdbm.Query__First();

      while not table_column__values_distinct_sdbm.Query__Eof do
        begin

          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  table_column__values_distinct_sdbm.Query__Field_By_Name( column_name__tcvd ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

          table_column__values_distinct_sdbm.Query__Next();

        end;

      table_column__values_distinct_sdbm.Query__Enable_Controls();

    end;

end;

procedure TTable_Column__Values_Distinct_Form.Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_PRIOR then
    Search__Prior_ButtonClick( Sender )
  else
  if Key = VK_NEXT then
    Search__Next_ButtonClick( Sender );

end;

procedure TTable_Column__Values_Distinct_Form.Search__Next_ButtonClick( Sender: TObject );
begin

  if Self.Task_Running_Check__TCVD() then
    Exit;


  if   ( table_column__values_distinct_sdbm = nil )
    or ( not table_column__values_distinct_sdbm.Query__Active() ) then
    Exit;


  table_column__values_distinct_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not table_column__values_distinct_sdbm.Query__Eof do
    begin

      table_column__values_distinct_sdbm.Query__Next();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  table_column__values_distinct_sdbm.Query__Field_By_Name( column_name__tcvd ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  table_column__values_distinct_sdbm.Query__Enable_Controls();

end;

procedure TTable_Column__Values_Distinct_Form.Search__Prior_ButtonClick( Sender: TObject );
begin

  if Self.Task_Running_Check__TCVD() then
    Exit;


  if   ( table_column__values_distinct_sdbm = nil )
    or ( not table_column__values_distinct_sdbm.Query__Active() ) then
    Exit;


  table_column__values_distinct_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not table_column__values_distinct_sdbm.Query__Bof do
    begin

      table_column__values_distinct_sdbm.Query__Prior();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  table_column__values_distinct_sdbm.Query__Field_By_Name( column_name__tcvd ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  table_column__values_distinct_sdbm.Query__Enable_Controls();

end;

procedure TTable_Column__Values_Distinct_Form.Refresh_ButtonClick( Sender: TObject );
var
  ztb,
  locate_skip_l
    : boolean;

  primary_key_value_l : string;
begin

  if Self.Task_Running_Check__TCVD() then
    Exit;


  if table_column__values_distinct_sdbm = nil then
    Exit;


  ztb := true; // False = error occurred.


  if not queries_open_in_background_g then
    begin

      Screen.Cursor := crSQLWait;

      Busy_Notification_Set( true );

      Application.ProcessMessages();

      try
        if not table_column__values_distinct_sdbm.Query__Active() then
          table_column__values_distinct_sdbm.Query__Open()
        else
          begin

            if    ( table_column__values_distinct_sdbm.component_type__sdbm = Common.ct_FireDAC )
              and ( table_column__values_distinct_sdbm.Query__Field_By_Name( column_name__tcvd ).IsNull ) then
              locate_skip_l := true // If the value is null FireDac throw error 'Invalid value for field FIELD_NAME'.
            else
              begin

                locate_skip_l := false;

                primary_key_value_l := table_column__values_distinct_sdbm.Query__Field_By_Name( column_name__tcvd ).AsString;

              end;


            primary_key_value_l := table_column__values_distinct_sdbm.Query__Field_By_Name( column_name__tcvd ).AsString;

            table_column__values_distinct_sdbm.Query__Requery();

            table_column__values_distinct_sdbm.Query__Sort(  column_name__tcvd + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );

            if not locate_skip_l then
              table_column__values_distinct_sdbm.Query__Locate( column_name__tcvd, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );

          end;
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            ztb := false;

            Log_Memo.Lines.Add(  StringReplace( E.Message, #10, #13 + #10, [ rfReplaceAll ] )  );

            Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_open_query + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );

          end;
      end;

      if ztb then
        Log_Memo.Lines.Add( table_column__values_distinct_sdbm.Operation_Duration_Get() );

      Busy_Notification_Set( false );

      Screen.Cursor := crDefault;

    end
  else
    begin

      task_is_running_g := true;

      Table_Column__Values_Distinct_DBGrid.DataSource := nil; // Sometimes there is an error 'Canvas does not allow drawing' in the line sql_editor_sdbm.Query__Open().


      Busy_Notification_Set( true );


      System.Threading.TTask.Run
        (
          procedure
            begin

              try
                if not table_column__values_distinct_sdbm.Query__Active() then
                  table_column__values_distinct_sdbm.Query__Open()
                else
                  begin

                    if    ( table_column__values_distinct_sdbm.component_type__sdbm = Common.ct_FireDAC )
                      and ( table_column__values_distinct_sdbm.Query__Field_By_Name( column_name__tcvd ).IsNull ) then
                      locate_skip_l := true // If the value is null FireDac throw error 'Invalid value for field FIELD_NAME'.
                    else
                      begin

                        locate_skip_l := false;

                        primary_key_value_l := table_column__values_distinct_sdbm.Query__Field_By_Name( column_name__tcvd ).AsString;

                      end;


                    table_column__values_distinct_sdbm.Query__Requery();

                    table_column__values_distinct_sdbm.Query__Sort(  column_name__tcvd + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );

                    if not locate_skip_l then
                      table_column__values_distinct_sdbm.Query__Locate( column_name__tcvd, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );

                  end;
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


                      if ztb then
                        Log_Memo.Lines.Add( table_column__values_distinct_sdbm.Operation_Duration_Get() );


                      Table_Column__Values_Distinct_DBGrid.DataSource := Table_Column__Values_Distinct_DataSource;


                      Table_Column__Values_Distinct_DBGrid.Repaint();

                      Busy_Notification_Set( false );

                    end
                );

            end
        );

    end;

end;

procedure TTable_Column__Values_Distinct_Form.Ok_ButtonClick( Sender: TObject );
begin

  if not Ok_Button.Visible then
    Exit;


  if Self.Task_Running_Check__TCVD() then
    Exit;


  if   ( table_column__values_distinct_sdbm = nil )
    or ( not table_column__values_distinct_sdbm.Query__Active() ) then
    Exit;


  value_selected__tcvd := table_column__values_distinct_sdbm.Query__Field_By_Name( column_name__tcvd ).AsString;


  ModalResult :=  mrOk;

end;

procedure TTable_Column__Values_Distinct_Form.Close_ButtonClick( Sender: TObject );
begin

  ModalResult :=  mrClose;
  Close();

end;

procedure TTable_Column__Values_Distinct_Form.No_Thread_TimerTimer( Sender: TObject );
begin

  // Query is not open in background.

  No_Thread_Timer.Enabled := false;

  Refresh_ButtonClick( Sender );

end;

procedure TTable_Column__Values_Distinct_Form.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TTable_Column__Values_Distinct_Form.Table_Column__Values_Distinct_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
begin

  Common.DB_Grid_Draw_Column_Cell( column_name__tcvd, Table_Column__Values_Distinct_DBGrid, Rect, DataCol, Column, State );

end;

procedure TTable_Column__Values_Distinct_Form.Table_Column__Values_Distinct_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_RETURN then
    Ok_ButtonClick( Refresh_Button )
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( table_column__values_distinct_sdbm.Query__Active() )
    and ( table_column__values_distinct_sdbm.Query__Record_Count > 0 )
    and ( Table_Column__Values_Distinct_DBGrid.SelectedField <> nil ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Table_Column__Values_Distinct_DBGrid.SelectedField.Value;
    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end
  else
  // R.
  if    ( Key = 82 )
    and ( Shift = [ ssCtrl ] ) then
    Refresh_ButtonClick( Refresh_Button );

end;

procedure TTable_Column__Values_Distinct_Form.Table_Column__Values_Distinct_DBGridTitleClick( Column: TColumn );
begin

  if Column.Field = nil then
    Exit;


  if column_name__tcvd = Column.Field.FieldName then
    sort__direction_ascending_g := not sort__direction_ascending_g
  else
    column_name__tcvd := Column.Field.FieldName;

  table_column__values_distinct_sdbm.Query__Sort(  column_name__tcvd + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );


  Value_DBEditChange( nil ); // For FireDAC.

end;

end.
