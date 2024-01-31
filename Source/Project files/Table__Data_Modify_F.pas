unit Table__Data_Modify_F;{26.Cze.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Migawka_Prostokat_Tabela_2_SDBM,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Samples.Spin, Vcl.ComCtrls;

type
  TTable__Data_Modify_F_Frame = class( TFrame )
    Buttons_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    Duplicate_Record_Button: TButton;
    Data_DataSource: TDataSource;
    Data_DBEdit: TDBEdit;
    Data_DBGrid: TDBGrid;
    Data_DBNavigator: TDBNavigator;
    Log_Memo: TMemo;
    Open_Close_Button: TButton;
    Primary_Key_Value_Etiquette_Label: TLabel;
    Record_Number__Records_Count_Label: TLabel;
    Refresh_Button: TButton;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Next_Button: TButton;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Prior_Button: TButton;
    Search_Edit: TEdit;
    Search_GroupBox: TGroupBox;
    Top_Panel: TPanel;
    Buttons_Vertical_Splitter: TSplitter;
    Grid_View_CheckBox: TCheckBox;
    Data_ScrollBox: TScrollBox;
    Width_Keeper_Label: TLabel;
    Width_Keeper__Move__Right_Button: TButton;
    Width_Keeper__Move__Left_Button: TButton;
    Data_Filter_ScrollBox: TScrollBox;
    Data_Panel: TPanel;
    Data_Filter_Horizontal_Splitter: TSplitter;
    Data_Filter__Buttons_GroupBox: TGroupBox;
    Data_Filter__Add_Button: TButton;
    Data_Filter__Delete__All_Button: TButton;
    Data_Filter__Show_Button: TButton;
    Data_Filter__Deactivate__All_Button: TButton;
    Data_Filter__Activate__All_Button: TButton;
    Data_Filter__Buttons_Vertical_Splitter: TSplitter;
    Height_Keeper_Label: TLabel;
    Data_PageControl: TPageControl;
    Data_Filter_TabSheet: TTabSheet;
    Data_Preview_TabSheet: TTabSheet;
    Data_Preview_DBMemo: TDBMemo;
    Caret_Position_Label: TLabel;
    Extract_Table_Data_Button: TButton;
    Data_ProgressBar: TProgressBar;
    Delete_Visible_Records_Button: TButton;
    Table_Column__Values_Distinct_Button: TButton;
    Editing_CheckBox: TCheckBox;
    SaveDialog1: TSaveDialog;
    Data_Value_Format__Disabled_CheckBox: TCheckBox;

    procedure Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );

    procedure Data_DBEditChange( Sender: TObject );
    procedure Open_Close_ButtonClick( Sender: TObject );
    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Duplicate_Record_ButtonClick( Sender: TObject );
    procedure Extract_Table_Data_ButtonClick( Sender: TObject );
    procedure Table_Column__Values_Distinct_ButtonClick( Sender: TObject );
    procedure Delete_Visible_Records_ButtonClick( Sender: TObject );

    procedure Editing_CheckBoxClick( Sender: TObject );
    procedure Grid_View_CheckBoxClick( Sender: TObject );

    procedure Search_Change( Sender: TObject );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );

    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );

    procedure Width_Keeper__Move_ButtonClick( Sender: TObject );

    procedure Width_Keeper_LabelMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
    procedure Data_ScrollBoxDragOver( Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean );

    procedure Data_Filter__Activate__All_ButtonClick( Sender: TObject );
    procedure Data_Filter__Add_ButtonClick( Sender: TObject );
    procedure Data_Filter__Deactivate__All_ButtonClick( Sender: TObject );
    procedure Data_Filter__Delete__All_ButtonClick( Sender: TObject );

    procedure Data_Value_Format__Disabled_CheckBoxClick( Sender: TObject );

    procedure Data_Preview_DBMemoChange( Sender: TObject );
    procedure Data_Preview_DBMemoClick( Sender: TObject );
    procedure Data_Preview_DBMemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Data_DBGridCellClick( Column: TColumn );
    procedure Data_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
    procedure Data_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Data_DBGridKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Data_DBGridTitleClick( Column: TColumn );
  private
    { Private declarations }
    additional_component_show_g,
    data__sort__direction_ascending_g,
    editing_checkboxclick__block_g,
    queries_open_in_background_g,
    splitter_show_g,
    task_is_running_g,
    sql__quotation_sign__use__tdmf_g,
    values_logged_g // Values log only once.
      : boolean;

    data_db_grid__selected_index_copy_g : integer;

    database_type__tdmf_g,
    data__filter_value_g,
    data__sort__column_name_g,
    field_name_selected_g,
    table_name__tdmf_g,
    sql__quotation_sign__tdmf_g
      : string;

    table_column__values_distinct_form_list__tdmf_g : TList;

    data__sdbm : Common.TSDBM;

    busy_notification__knight_rider_equalizer : Migawka_Prostokat_Tabela_2_SDBM.TMigawka_Prostokat_Tabela_2;

    procedure Busy_Notification_Set( const busy_f : boolean );
    procedure Caret_Position_Display();
    procedure Column__Values__Sum();
    procedure Data_Preview();
    function Extract_Table_Data( const progres_show_f : boolean = false ) : string;
    procedure Field_Name_Selected_From_Form_View__Set();
    procedure Form_View_Field__Free();
    procedure Free_All__Table_Column__Values_Distinct();
    procedure Parent_Tab_Switch( const prior_f : boolean = false );
    procedure Primary_Key_Find();
    procedure Query_Active_Notification_Set();
    function Quotation_Sign__TDMF() : string;
    procedure Save_Table_Data_To_File( const table_data_f : string );
    procedure Table__Data_Filter__Free();
  public
    { Public declarations }
    parent_supreme_tab_sheet : Vcl.Controls.TWinControl;

    Additional_Component_Show__Get_wsk : function() : boolean of object;
    Splitter_Show__Get_wsk : function() : boolean of object;

    function Finish__TDMF() : boolean;
    procedure Options_Set__TDMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const additional_component_show_f, queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
    procedure Prepare__TDMF( const databases_r_f : Common.TDatabases_r; const table_name_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const additional_component_show_f, queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
    function Table__Data_Modify_F__Data__Close__TDMF() : boolean;
    procedure Table__Data_Modify_F__Data__Open_Refresh__TDMF();
    function Task_Running_Check__TDMF( const message_show_f : boolean = true ) : boolean;
    procedure Translation__Apply__TDMF();
  end;

const
  table__insert_into__a__file_name_c : string = 'Table__Insert_Into__A__sql.txt';
  table__insert_into__b__file_name_c : string = 'Table__Insert_Into__B__sql.txt';
  table__insert_into__c__file_name_c : string = 'Table__Insert_Into__C__sql.txt';
  table__insert_into__d__file_name_c : string = 'Table__Insert_Into__D__sql.txt';
  table__select__file_name_c : string = 'Table__Select__sql.txt';

implementation

uses
  System.Threading,
  System.StrUtils,
  Vcl.Clipbrd,

  Form_View_Field,
  Shared,
  Table_Column__Values_Distinct,
  Table__Data_Filter,
  Translation;

{$R *.dfm}

procedure TTable__Data_Modify_F_Frame.Busy_Notification_Set( const busy_f : boolean );
begin

  if    ( parent_supreme_tab_sheet <> nil )
    and ( parent_supreme_tab_sheet is TTabSheet ) then
    begin

      if    ( busy_f )
        and (  Pos( Common.notification__sign__busy_c, TTabSheet(parent_supreme_tab_sheet).Caption ) <= 0  ) then
        TTabSheet(parent_supreme_tab_sheet).Caption := TTabSheet(parent_supreme_tab_sheet).Caption + Common.notification__sign__busy_c
      else
      if    ( not busy_f )
        and (  Pos( Common.notification__sign__busy_c, TTabSheet(parent_supreme_tab_sheet).Caption ) > 0  ) then
        TTabSheet(parent_supreme_tab_sheet).Caption := StringReplace( TTabSheet(parent_supreme_tab_sheet).Caption, Common.notification__sign__busy_c, '', [ rfReplaceAll ] );

    end;


  if busy_f then
    begin

      busy_notification__knight_rider_equalizer.Szerokoœæ_Koryguj();
      busy_notification__knight_rider_equalizer.Tryb_Ustaw( Migawka_Prostokat_Tabela_2_SDBM.mpt2_Migaj );

    end
  else
    busy_notification__knight_rider_equalizer.Tryb_Ustaw( Migawka_Prostokat_Tabela_2_SDBM.mpt2_Mignij );

end;

procedure TTable__Data_Modify_F_Frame.Caret_Position_Display();
begin

  if    ( Data_PageControl.Height > 1 )
    and ( Data_Preview_DBMemo.Height > 1 )
    and ( Data_PageControl.ActivePage = Data_Preview_TabSheet )
    and (
             ( Data_Preview_DBMemo.Focused )
          or ( Data_DBGrid.Focused )
        ) then
    begin

      Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Data_Preview_DBMemo.CaretPos.Y + 1 )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Data_Preview_DBMemo.CaretPos.X + 1 )  ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Data_Preview_DBMemo.Lines.Text.Length )  );

      if not Caret_Position_Label.Visible then
        Caret_Position_Label.Visible := true;

    end
  else
  if Caret_Position_Label.Visible then
    Caret_Position_Label.Visible := false;

end;

procedure TTable__Data_Modify_F_Frame.Column__Values__Sum();
var
  ztc : currency;

  error_message_l : string;
begin

  if Self.Task_Running_Check__TDMF() then
    Exit;


  if   ( data__sdbm = nil )
    or ( not data__sdbm.Query__Active() )
    or ( data__sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  //try
  //  data__sdbm.Query__Field_By_Name( Sql_Editor_DBGrid.SelectedField.FieldName ).AsCurrency;
  //except
  //  on E : Exception do
  //    begin
  //
  //      Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_read_column_value_as_a_number + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
  //      Exit;
  //
  //    end;
  //end;


  Field_Name_Selected_From_Form_View__Set();


  if not queries_open_in_background_g then
    begin

      Screen.Cursor := crSQLWait;

      Busy_Notification_Set( true );

      Application.ProcessMessages();


      ztc := Common.Column__Values__Sum__Processing( data__sdbm, Data_DBGrid, error_message_l, Data_ProgressBar, true );

      if Grid_View_CheckBox.Checked then // Grid.
        Data_DBGrid.SetFocus();


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

              ztc := Common.Column__Values__Sum__Processing( data__sdbm, Data_DBGrid, error_message_l, Data_ProgressBar );


              TThread.Synchronize
                (
                  TThread.Current,
                  procedure
                    begin

                      if Grid_View_CheckBox.Checked then // Grid.
                        Data_DBGrid.SetFocus();


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

procedure TTable__Data_Modify_F_Frame.Data_Preview();
begin

  if   ( Data_PageControl.Height <= 1 )
    or ( Data_PageControl.ActivePage <> Data_Preview_TabSheet ) then
    begin

      Caret_Position_Display();

      Exit;

    end;


  if    ( data__sdbm <> nil )
    and ( data__sdbm.Query__Active() )
    and ( data__sdbm.Query__Record_Count > 0 )
    and ( Data_DBGrid.SelectedField <> nil ) then
    try
      Data_Preview_DBMemo.DataField := Data_DBGrid.SelectedField.FieldName;
    except
      on E : Exception do
        Log_Memo.Lines.Text := Translation.translation__messages_r.failed_to_preview_value + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext );
    end;

end;

function TTable__Data_Modify_F_Frame.Extract_Table_Data( const progres_show_f : boolean = false ) : string;
var
  i,
  progress_bar_step_distance
    : integer;

  zts,
  insert_into_sql__a_l,
  insert_into_sql__b_l,
  insert_into_sql__c_l,
  insert_into_sql__d_l,
  insert_into_sql_l,
  values_l
    : string;
begin

  data__sdbm.Query__Disable_Controls();


  //Log_Memo.Lines.BeginUpdate();
  Result := '';


  if data__sdbm.component_type__sdbm = Common.TComponent_Type.ct_FireDAC then
    begin

      // FireDAC may not give total record count.

      data__sdbm.Query__Last();

    end;


  if progres_show_f then
    begin

      if data__sdbm.Query__Record_Count() <= 99 then
        progress_bar_step_distance := 1
      else
      if data__sdbm.Query__Record_Count() <= 999 then
        progress_bar_step_distance := 10
      else
      if data__sdbm.Query__Record_Count() <= 9999 then
        progress_bar_step_distance := 100
      else
        progress_bar_step_distance := 1000;


      Data_ProgressBar.Position := 0; // May case the application to freeze.
      Data_ProgressBar.Max := data__sdbm.Query__Record_Count();
      Data_ProgressBar.Step := progress_bar_step_distance;
      Data_ProgressBar.Visible := true;

    end;


  data__sdbm.Query__First();


  Log_Memo.Lines.Clear();


  {$region 'Files read.'}
  insert_into_sql__a_l := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tdmf_g ) + table__insert_into__a__file_name_c  );

  if Trim( insert_into_sql__a_l ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tdmf_g ) + table__insert_into__a__file_name_c + ').' );

      insert_into_sql__a_l := 'insert into ';

    end
  else
    begin

      insert_into_sql__a_l := StringReplace( insert_into_sql__a_l, #10, '', [] );
      insert_into_sql__a_l := StringReplace( insert_into_sql__a_l, #13, '', [] );

    end;


  insert_into_sql__b_l := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tdmf_g ) + table__insert_into__b__file_name_c  );

  if Trim( insert_into_sql__b_l ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tdmf_g ) + table__insert_into__b__file_name_c + ').' );

      insert_into_sql__b_l := ' ) values ( ';

    end
  else
    begin

      insert_into_sql__b_l := StringReplace( insert_into_sql__b_l, #10, '', [] );
      insert_into_sql__b_l := StringReplace( insert_into_sql__b_l, #13, '', [] );

    end;


  insert_into_sql__c_l := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tdmf_g ) + table__insert_into__c__file_name_c  );

  if Trim( insert_into_sql__c_l ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tdmf_g ) + table__insert_into__c__file_name_c + ').' );

      insert_into_sql__c_l := ', ';

    end
  else
    begin

      insert_into_sql__c_l := StringReplace( insert_into_sql__c_l, #10, '', [] );
      insert_into_sql__c_l := StringReplace( insert_into_sql__c_l, #13, '', [] );

    end;


  insert_into_sql__d_l := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tdmf_g ) + table__insert_into__d__file_name_c  );

  if Trim( insert_into_sql__d_l ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tdmf_g ) + table__insert_into__d__file_name_c + ').' );

      insert_into_sql__d_l := ' );';

    end
  else
    begin

      insert_into_sql__d_l := StringReplace( insert_into_sql__d_l, #10, '', [] );
      insert_into_sql__d_l := StringReplace( insert_into_sql__d_l, #13, '', [] );

    end;
  {$endregion 'Files read.'}


  insert_into_sql_l :=
    insert_into_sql__a_l + Self.Quotation_Sign__TDMF() + table_name__tdmf_g + Self.Quotation_Sign__TDMF() + ' ( ';


  for i := 0 to data__sdbm.Query__Field_Count() - 1 do
    begin

      if i > 0 then
        insert_into_sql_l := insert_into_sql_l +
          insert_into_sql__c_l;

      insert_into_sql_l := insert_into_sql_l +
        Self.Quotation_Sign__TDMF() + data__sdbm.Query__Fields( i ).FieldName + Self.Quotation_Sign__TDMF();

    end;


  insert_into_sql_l := insert_into_sql_l +
    insert_into_sql__b_l;


  while not data__sdbm.Query__Eof() do
    begin

      values_l := '';


      for i := 0 to data__sdbm.Query__Field_Count() - 1 do
        begin

          if i > 0 then
            values_l := values_l +
              insert_into_sql__c_l;

          if data__sdbm.Query__Fields( i ).IsNull then
            values_l := values_l + 'null'
          else
            begin

              zts := data__sdbm.Query__Fields( i ).AsString;


              if data__sdbm.Query__Fields( i ).DataType in
                   [
                     ftAutoInc, ftByte, ftBytes, ftInteger, ftLargeint, ftLongWord, ftShortint, ftSmallint, ftWord,
                     ftBCD, ftCurrency, ftExtended, ftFloat, ftFMTBcd, ftSingle, ftVarBytes
                   ] then
                begin

                  zts := StringReplace( zts, ' ', '', [ rfReplaceAll ] );
                  zts := StringReplace( zts, ',', '.', [ rfReplaceAll ] );

                end
              else
              if data__sdbm.Query__Fields( i ).DataType in [ ftDate, ftDateTime, ftTime, ftTimeStamp, ftOraTimeStamp ] then
                begin

                  zts := StringReplace( zts, '-', '.', [ rfReplaceAll ] );

                  zts := '''' + zts + '''';

                end
              else
                begin

                  zts := StringReplace( zts, '''', '''''', [ rfReplaceAll ] );

                  zts := '''' + zts + '''';


                  zts := StringReplace( zts, #9, '''||ascii_char( 9 )||''', [ rfReplaceAll ] );
                  zts := StringReplace( zts, #10, '''||ascii_char( 10 )||''', [ rfReplaceAll ] );
                  zts := StringReplace( zts, #13, '''||ascii_char( 13 )||''', [ rfReplaceAll ] );


                  if Pos( '''''||', zts ) = 1 then
                    zts := StringReplace( zts, '''''||', '', [] );


                  zts := System.StrUtils.ReverseString( zts );

                  if Pos( '''''||', zts ) = 1 then
                    zts := StringReplace( zts, '''''||', '', [] );

                  zts := System.StrUtils.ReverseString( zts );

                end;



              values_l := values_l +
                zts;

            end;

        end;


      //Log_Memo.Lines.Add
      //  (
      //    insert_into_sql_l +
      //    values_l +
      //    insert_into_sql__d_l
      //  );
      Result := Result +
        insert_into_sql_l +
        values_l +
        insert_into_sql__d_l +
        #13 + #10;


      if    ( progres_show_f )
        and ( data__sdbm.Query__Record_Number() mod progress_bar_step_distance = 0 ) then
        begin

          Data_ProgressBar.StepIt();

          Application.ProcessMessages();

        end;


      data__sdbm.Query__Next();

    end;


  if progres_show_f then
    Data_ProgressBar.Position := Data_ProgressBar.Max;


  data__sdbm.Query__Enable_Controls();


  //Log_Memo.Lines.EndUpdate();

  if progres_show_f then
    Data_ProgressBar.Visible := false;

end;

function TTable__Data_Modify_F_Frame.Finish__TDMF() : boolean;
begin

  if Self.Task_Running_Check__TDMF() then
    begin

      Result := false;

      Exit;

    end
  else
    Result := true;


  Free_All__Table_Column__Values_Distinct();
  FreeAndNil( table_column__values_distinct_form_list__tdmf_g );


  FreeAndNil( data__sdbm );

  FreeAndNil( busy_notification__knight_rider_equalizer );

  Form_View_Field__Free();

  Table__Data_Filter__Free();

end;

procedure TTable__Data_Modify_F_Frame.Field_Name_Selected_From_Form_View__Set();
var
  i : integer;
begin

  if    ( not Grid_View_CheckBox.Checked )
    and (  Trim( field_name_selected_g ) <> ''  )
    and ( Data_DBGrid.SelectedField.FieldName <> field_name_selected_g ) then
    for i := 0 to Data_DBGrid.FieldCount - 1 do
       if Data_DBGrid.Fields[ i ].FieldName = field_name_selected_g then
         begin

           Data_DBGrid.SelectedIndex := i;
           Break;

         end;

end;

procedure TTable__Data_Modify_F_Frame.Form_View_Field__Free();
var
  visible_copy_l : boolean;
  i : integer;
begin

  field_name_selected_g := '';

  visible_copy_l := Data_ScrollBox.Visible;

  if Data_ScrollBox.Visible then
    Data_ScrollBox.Visible := false;


  for i := Data_ScrollBox.ControlCount - 1 downto 0 do
    if Data_ScrollBox.Controls[ i ].ClassType = Form_View_Field.TForm_View_Field then
      FreeAndNil( Form_View_Field.TForm_View_Field(Data_ScrollBox.Controls[ i ]) )
    else
    if Data_ScrollBox.Controls[ i ].ClassType = TSplitter then
      FreeAndNil( TSplitter(Data_ScrollBox.Controls[ i ]) );


  if visible_copy_l then
    Data_ScrollBox.Visible := true;

end;

procedure TTable__Data_Modify_F_Frame.Free_All__Table_Column__Values_Distinct();
var
  i : integer;
begin

  if   ( table_column__values_distinct_form_list__tdmf_g = nil )
    or (  not Assigned( table_column__values_distinct_form_list__tdmf_g )  ) then
    Exit;


  for i := table_column__values_distinct_form_list__tdmf_g.Count - 1 downto 0 do
    begin

      Table_Column__Values_Distinct.TTable_Column__Values_Distinct_Form(table_column__values_distinct_form_list__tdmf_g[ i ]).Free();
      table_column__values_distinct_form_list__tdmf_g.Delete( i );

    end;

end;

procedure TTable__Data_Modify_F_Frame.Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );
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

procedure TTable__Data_Modify_F_Frame.Options_Set__TDMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const additional_component_show_f, queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
begin

  additional_component_show_g := additional_component_show_f;
  queries_open_in_background_g := queries_open_in_background_f;
  splitter_show_g := splitter_show_f;
  sql__quotation_sign__use__tdmf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__tdmf_g := sql__quotation_sign_f;


  if data__sdbm <> nil then
    begin

      data__sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

      data__sdbm.Data_Source__Data_Set__Set( Data_DataSource );

    end;


  Self.Translation__Apply__TDMF();


  Query_Active_Notification_Set();

end;

procedure TTable__Data_Modify_F_Frame.Parent_Tab_Switch( const prior_f : boolean = false );
var
  zti : integer;
begin

  if    ( parent_supreme_tab_sheet <> nil )
    and ( parent_supreme_tab_sheet is TTabSheet )
    and ( parent_supreme_tab_sheet.Parent <> nil )
    and ( parent_supreme_tab_sheet.Parent is TPageControl )
    and ( TPageControl(parent_supreme_tab_sheet.Parent).PageCount > 1 ) then
    begin

      zti := TPageControl(parent_supreme_tab_sheet.Parent).ActivePageIndex;


      if not prior_f then
        begin

          // Next.

          inc( zti );

          if zti > TPageControl(parent_supreme_tab_sheet.Parent).PageCount - 1 then
            zti := 0;

        end
      else
        begin

          // Prior.

          dec( zti );

          if zti < 0 then
            zti := TPageControl(parent_supreme_tab_sheet.Parent).PageCount - 1;

        end;


      TPageControl(parent_supreme_tab_sheet.Parent).ActivePageIndex := zti;

    end;

end;

procedure TTable__Data_Modify_F_Frame.Prepare__TDMF( const databases_r_f : Common.TDatabases_r; const table_name_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const additional_component_show_f, queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
begin

  Self.Name := '';

  additional_component_show_g := additional_component_show_f;
  data_db_grid__selected_index_copy_g := 0;
  data__filter_value_g := '';
  data__sort__column_name_g := '';
  data__sort__direction_ascending_g := true;
  database_type__tdmf_g := databases_r_f.database_type;
  field_name_selected_g := '';
  queries_open_in_background_g := queries_open_in_background_f;
  splitter_show_g := splitter_show_f;
  table_name__tdmf_g := table_name_f;
  task_is_running_g := false;
  values_logged_g := false;


  Data_DBGrid.Align := alClient;
  Data_ScrollBox.Align := alClient;
  Data_PageControl.ActivePage := Data_Filter_TabSheet;
  Data_PageControl.Height := 1;

  Log_Memo.Lines.Add( table_name__tdmf_g );


  table_column__values_distinct_form_list__tdmf_g := TList.Create();

  busy_notification__knight_rider_equalizer := Migawka_Prostokat_Tabela_2_SDBM.TMigawka_Prostokat_Tabela_2.Create( Self );

  data__sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Self.Options_Set__TDMF( component_type_f, databases_r_f.sql__quotation_sign, additional_component_show_g, queries_open_in_background_g, splitter_show_g, sql__quotation_sign__use_f );


  editing_checkboxclick__block_g := true;
  Editing_CheckBox.Checked := Common.table__data_modify__editing__default_state;
  editing_checkboxclick__block_g := false;

  Grid_View_CheckBoxClick( nil );
  Editing_CheckBoxClick( nil );


  Common.Font__Set( Data_Preview_DBMemo.Font, Common.sql_editor__font );


  Height_Keeper_Label.Top := Common.table__data_modify__filter__height_keeper__top;
  Width_Keeper_Label.Left := Data_ScrollBox.Width - Width_Keeper_Label.Width;


  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );

end;

procedure TTable__Data_Modify_F_Frame.Primary_Key_Find();
var
  zts : string;

  zt_sdbm : Common.TSDBM;
begin

  zt_sdbm := Common.TSDBM.Create( data__sdbm );
  zt_sdbm.Component_Type_Set( data__sdbm.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tdmf_g ) + Common.primary_key__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tdmf_g ) + Common.primary_key__file_name_c + ').' );

      zts :=
        'select RDB$INDEX_SEGMENTS.RDB$FIELD_NAME as PRIMARY_KEY_NAME ' +
        'from RDB$INDICES ' +
        'left join RDB$INDEX_SEGMENTS on RDB$INDEX_SEGMENTS.RDB$INDEX_NAME = RDB$INDICES.RDB$INDEX_NAME ' +
        'left join RDB$RELATION_CONSTRAINTS on RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME = RDB$INDICES.RDB$INDEX_NAME ' +
        'where RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_TYPE = ''PRIMARY KEY'' ' +
        '  and RDB$RELATION_CONSTRAINTS.RDB$RELATION_NAME = :table_name ';

    end;

  zt_sdbm.Query__Sql__Set( zts );


  if not values_logged_g then
    Log_Memo.Lines.Add( zts );


  zt_sdbm.Query__Param_By_Name__Set( Common.name__table__small_letters_c, table_name__tdmf_g, Log_Memo );

  try
    zt_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_primary_key_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;

  if zt_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( zt_sdbm.Operation_Duration_Get() );


      try
        Data_DBEdit.DataField := Trim( zt_sdbm.Query__Field_By_Name( Common.column_name__primary_key_c ).AsString ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.
      except
        on E : Exception do
          begin

            Data_DBEdit.DataField := '';

            zt_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_primary_key_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;


      if Trim( Data_DBEdit.DataField ) = '' then
        zts := Translation.translation__messages_r.word__none
      else
        zts := Data_DBEdit.DataField;


      if not values_logged_g then
        Log_Memo.Lines.Add( Translation.translation__messages_r.word__primary_key + ': ' + zts + '.' );

    end;

  if zt_sdbm.Query__Active() then
    zt_sdbm.Query__Close();

  FreeAndNil( zt_sdbm );


  if    (  Trim( Data_DBEdit.DataField ) = ''  )
    and ( data__sdbm.Query__Active() )
    and ( data__sdbm.Query__Field_Count() > 0 ) then
    begin

      Data_DBEdit.DataField := data__sdbm.Query__Fields( 0 ).FieldName;

    end;


  data__sort__column_name_g := Data_DBEdit.DataField;


  if not values_logged_g then
    values_logged_g := true;

end;

procedure TTable__Data_Modify_F_Frame.Query_Active_Notification_Set();
begin

  if data__sdbm = nil then
    Exit;


  if data__sdbm.Query__Active() then
    begin

      Open_Close_Button.Hint := Translation.translation__messages_r.word__close + Translation.translation__messages_r.word__ctrl___o;
      Open_Close_Button.ImageIndex := 7;

      Refresh_Button.Enabled := true;

    end
  else
    begin

      Open_Close_Button.Hint := Translation.translation__messages_r.word__open + Translation.translation__messages_r.word__ctrl___o;
      Open_Close_Button.ImageIndex := 6;

      Refresh_Button.Enabled := false;


      Data_DBEdit.DataField := '';
      data__sort__column_name_g := '';
      data__sort__direction_ascending_g := true;

    end;


  Delete_Visible_Records_Button.Enabled := Refresh_Button.Enabled;
  Duplicate_Record_Button.Enabled := Refresh_Button.Enabled;
  Extract_Table_Data_Button.Enabled := Refresh_Button.Enabled;
  Table_Column__Values_Distinct_Button.Enabled := Refresh_Button.Enabled;

end;

function TTable__Data_Modify_F_Frame.Quotation_Sign__TDMF() : string;
begin

  if sql__quotation_sign__use__tdmf_g then
    begin

      Result := sql__quotation_sign__tdmf_g;

    end
  else
    Result := '';

end;

procedure TTable__Data_Modify_F_Frame.Save_Table_Data_To_File( const table_data_f : string );
var
  zt_string_list : TStringList;
begin

  if   Trim( table_data_f ) = '' then
    Exit;


  if Trim( SaveDialog1.FileName ) = '' then
    SaveDialog1.FileName := table_name__tdmf_g + '.txt';


  if SaveDialog1.Execute() then
    begin

      zt_string_list := TStringList.Create();

      zt_string_list.Add( table_data_f );

      zt_string_list.SaveToFile( SaveDialog1.FileName, System.SysUtils.TEncoding.UTF8 );

      FreeAndNil( zt_string_list );


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end;

end;

procedure TTable__Data_Modify_F_Frame.Table__Data_Filter__Free();
var
  i : integer;
begin

  for i := Data_Filter_ScrollBox.ControlCount - 1 downto 0 do
    if Data_Filter_ScrollBox.Controls[ i ].ClassType = Table__Data_Filter.TTable__Data_Filter then
      FreeAndNil( Table__Data_Filter.TTable__Data_Filter(Data_Filter_ScrollBox.Controls[ i ]) )
    else
    if Data_Filter_ScrollBox.Controls[ i ].ClassType = TSplitter then
      FreeAndNil( TSplitter(Data_Filter_ScrollBox.Controls[ i ]) );

end;

function TTable__Data_Modify_F_Frame.Table__Data_Modify_F__Data__Close__TDMF() : boolean;
begin

  if Self.Task_Running_Check__TDMF( false ) then
    Result := false
  else
    begin

      if data__sdbm.Query__Active() then
        Open_Close_ButtonClick( nil );

      Result := not data__sdbm.Query__Active();

    end;

end;

procedure TTable__Data_Modify_F_Frame.Table__Data_Modify_F__Data__Open_Refresh__TDMF();
begin

  if not data__sdbm.Query__Active() then
    Open_Close_ButtonClick( nil )
  else
    Refresh_ButtonClick( nil );

end;

function TTable__Data_Modify_F_Frame.Task_Running_Check__TDMF( const message_show_f : boolean = true ) : boolean;
var
  i : integer;
begin

  Result := task_is_running_g;


  if    ( not Result )
    and ( table_column__values_distinct_form_list__tdmf_g <> nil )
    and (  Assigned( table_column__values_distinct_form_list__tdmf_g )  ) then
    for i := 0 to table_column__values_distinct_form_list__tdmf_g.Count - 1 do
      if Table_Column__Values_Distinct.TTable_Column__Values_Distinct_Form(table_column__values_distinct_form_list__tdmf_g[ i ]).Task_Running_Check__TCVD( message_show_f ) then
        begin

          Result := true;
          Break;

        end;


  if    ( Result )
    and ( message_show_f ) then
    Application.MessageBox( PChar(Translation.translation__messages_r.task_is_still_running_wait_until_finish), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );

end;

procedure TTable__Data_Modify_F_Frame.Translation__Apply__TDMF();
var
  i : integer;
begin

  Translation.Translation__Apply( Self );

  SaveDialog1.Filter := 'txt|*.txt|' + Translation.translation__messages_r.all_files + '|' + Common.all_files_find__filter;

  for i := 0 to Data_Filter_ScrollBox.ControlCount - 1 do
    if Data_Filter_ScrollBox.Controls[ i ].ClassType = Table__Data_Filter.TTable__Data_Filter then
      Table__Data_Filter.TTable__Data_Filter(Data_Filter_ScrollBox.Controls[ i ]).Translation__Apply__TDF();

end;

procedure TTable__Data_Modify_F_Frame.Data_DBEditChange( Sender: TObject );
begin

  if Self.Task_Running_Check__TDMF( false ) then
    Exit;


  if    ( data__sdbm <> nil )
    and ( data__sdbm.Query__Active() ) then
    Record_Number__Records_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', data__sdbm.Query__Record_Number() )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', data__sdbm.Query__Record_Count() )  )
  else
    Record_Number__Records_Count_Label.Caption := '0 / 0';

end;

procedure TTable__Data_Modify_F_Frame.Open_Close_ButtonClick( Sender: TObject );
var
  zts : string;
begin

  if data__sdbm = nil then
    Exit;


  if Self.Task_Running_Check__TDMF() then
    Exit;


  Data_Preview_DBMemo.DataField := '';


  if not data__sdbm.Query__Active() then
    begin

      zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tdmf_g ) + table__select__file_name_c  );

      if Trim( zts ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tdmf_g ) + table__select__file_name_c + ').' );

          zts :=
            'select * from ' + Self.Quotation_Sign__TDMF() + table_name__tdmf_g + Self.Quotation_Sign__TDMF() + ' ';

        end
      else
        begin

          zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TDMF() + table_name__tdmf_g + Self.Quotation_Sign__TDMF(), [ rfReplaceAll ] );

        end;


      data__sdbm.Query__Sql__Set( zts + data__filter_value_g );


      if not values_logged_g then
        Log_Memo.Lines.Add( zts );


      if not queries_open_in_background_g then
        begin

          Screen.Cursor := crSQLWait;

          Busy_Notification_Set( true );

          Application.ProcessMessages();


          try
            data__sdbm.Query__Open();
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_open_table + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );

              end;
          end;


          Log_Memo.Lines.Add( data__sdbm.Operation_Duration_Get() );


          Query_Active_Notification_Set();


          Primary_Key_Find();


          if data__sdbm.Query__Active() then
            data__sdbm.Query__Sort(  data__sort__column_name_g + Common.Sort_Direction_Symbol( data__sort__direction_ascending_g )  );


          Data_Value_Format__Disabled_CheckBoxClick( Self );

          Grid_View_CheckBoxClick( Sender );

          Busy_Notification_Set( false );

          Data_DBGrid.SelectedIndex := data_db_grid__selected_index_copy_g;

          Screen.Cursor := crDefault;

        end
      else
        begin

          task_is_running_g := true;

          Data_DBGrid.DataSource := nil; // Sometimes there is an error 'Canvas does not allow drawing' in the line data__sdbm.Query__Open().


          Busy_Notification_Set( true );


          System.Threading.TTask.Run
            (
              procedure
                begin

                  try
                    data__sdbm.Query__Open();
                  except
                    on E : Exception do
                      TThread.Synchronize
                        (
                          TThread.Current,
                          procedure
                            begin

                              Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_open_table + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );

                            end
                        );

                  end;


                  TThread.Synchronize
                    (
                      TThread.Current,
                      procedure
                        begin

                          task_is_running_g := false;


                          Log_Memo.Lines.Add( data__sdbm.Operation_Duration_Get() );


                          Data_DBGrid.DataSource := Data_DataSource;


                          Query_Active_Notification_Set();


                          Primary_Key_Find();


                          if data__sdbm.Query__Active() then
                            data__sdbm.Query__Sort(  data__sort__column_name_g + Common.Sort_Direction_Symbol( data__sort__direction_ascending_g )  );


                          Data_Value_Format__Disabled_CheckBoxClick( Self );

                          Data_DBGrid.Repaint();

                          Grid_View_CheckBoxClick( Sender );

                          Busy_Notification_Set( false );

                          Data_DBGrid.SelectedIndex := data_db_grid__selected_index_copy_g;

                        end
                    );

                end
            );

        end;

    end
  else
    begin

      data_db_grid__selected_index_copy_g := Data_DBGrid.SelectedIndex;


      data__sdbm.Query__Close();

      Query_Active_Notification_Set();

      Form_View_Field__Free();

    end;

end;

procedure TTable__Data_Modify_F_Frame.Refresh_ButtonClick( Sender: TObject );
var
  primary_key_name_l,
  primary_key_value_l
    : string;
begin

  if Self.Task_Running_Check__TDMF() then
    Exit;


  if   ( data__sdbm = nil )
    or ( not data__sdbm.Query__Active() ) then
    Exit;


  if Trim( Data_DBEdit.DataField ) <> '' then
    begin

      primary_key_name_l := Data_DBEdit.DataField;
      primary_key_value_l := Data_DBEdit.Text;

    end
  else
  if data__sdbm.Query__Field_Count() >  0 then
    begin

      primary_key_name_l := data__sdbm.Query__Fields( 0 ).FieldName;
      primary_key_value_l := data__sdbm.Query__Fields( 0 ).AsString;

    end
  else
    primary_key_name_l := '';


  if not queries_open_in_background_g then
    begin

      Screen.Cursor := crSQLWait;

      Busy_Notification_Set( true );

      Application.ProcessMessages();


      data__sdbm.Query__Requery();


      Log_Memo.Lines.Add( data__sdbm.Operation_Duration_Get() );


      if Trim( primary_key_name_l ) <> '' then
        data__sdbm.Query__Locate( primary_key_name_l, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );


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

              data__sdbm.Query__Requery();


              TThread.Synchronize
                (
                  TThread.Current,
                  procedure
                    begin

                      task_is_running_g := false;


                      Log_Memo.Lines.Add( data__sdbm.Operation_Duration_Get() );


                      if Trim( primary_key_name_l ) <> '' then
                        data__sdbm.Query__Locate( primary_key_name_l, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );


                      Busy_Notification_Set( false );

                    end
                );

            end
        );

    end;

end;

procedure TTable__Data_Modify_F_Frame.Duplicate_Record_ButtonClick( Sender: TObject );
var
  i : integer;

  fields_t : array of variant;
begin

  if Self.Task_Running_Check__TDMF() then
    Exit;


  if   ( data__sdbm = nil )
    or ( not data__sdbm.Query__Active() )
    or ( data__sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  SetLength( fields_t, 0 );
  SetLength( fields_t, data__sdbm.Query__Field_Count() );

  for i := 0 to data__sdbm.Query__Field_Count() - 1 do
    begin

      fields_t[ i ] := data__sdbm.Query__Fields( i ).AsVariant;

    end;


  data__sdbm.Query__Insert();


  for i := 0 to data__sdbm.Query__Field_Count() - 1 do
    begin

      data__sdbm.Query__Fields( i ).AsVariant := fields_t[ i ];

    end;


  SetLength( fields_t, 0 );

end;

procedure TTable__Data_Modify_F_Frame.Extract_Table_Data_ButtonClick( Sender: TObject );
var
  zti : integer;

  zts : string;
begin

  if Self.Task_Running_Check__TDMF() then
    Exit;


  if   ( data__sdbm = nil )
    or ( not data__sdbm.Query__Active() )
    or ( data__sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  if not queries_open_in_background_g then
    begin

      Screen.Cursor := crSQLWait;

      Busy_Notification_Set( true );

      Application.ProcessMessages();


      zts := Extract_Table_Data( true );


      zti := Application.MessageBox( PChar(Translation.translation__messages_r.save_table_data_to_file__no____display_in_log__), PChar(Translation.translation__messages_r.confirmation), MB_YESNOCANCEL + MB_DEFBUTTON1 + MB_ICONQUESTION );

      if zti = ID_YES then
        Save_Table_Data_To_File( zts )
      else
      if zti = ID_NO then
        Log_Memo.Lines.Add( zts );



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

              zts := Extract_Table_Data();


              TThread.Synchronize
                (
                  TThread.Current,
                  procedure
                    begin

                      zti := Application.MessageBox( PChar(Translation.translation__messages_r.save_table_data_to_file__no____display_in_log__), PChar(Translation.translation__messages_r.confirmation), MB_YESNOCANCEL + MB_DEFBUTTON1 + MB_ICONQUESTION );

                      if zti = ID_YES then
                        Save_Table_Data_To_File( zts )
                      else
                      if zti = ID_NO then
                        Log_Memo.Lines.Add( zts );


                      task_is_running_g := false;

                      Busy_Notification_Set( false );

                    end
                );

            end
        );

    end;

end;

procedure TTable__Data_Modify_F_Frame.Table_Column__Values_Distinct_ButtonClick( Sender: TObject );
var
  table_column__values_distinct_form_l : Table_Column__Values_Distinct.TTable_Column__Values_Distinct_Form;
begin

  if Self.Task_Running_Check__TDMF() then
    Exit;


  if   ( data__sdbm = nil )
    or ( not data__sdbm.Query__Active() )
    or ( data__sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  if   ( table_column__values_distinct_form_list__tdmf_g = nil )
    or (  not Assigned( table_column__values_distinct_form_list__tdmf_g )  ) then
    Exit;


  table_column__values_distinct_form_l := Table_Column__Values_Distinct.TTable_Column__Values_Distinct_Form.Create( Application, data__sdbm );

  if  ( Grid_View_CheckBox.Checked ) // Grid.
   or (  Trim( field_name_selected_g ) = ''  ) then
    table_column__values_distinct_form_l.column_name__tcvd := Data_DBGrid.SelectedField.FieldName
  else
    table_column__values_distinct_form_l.column_name__tcvd := field_name_selected_g; // Form.

  table_column__values_distinct_form_l.database_type__tcvd := database_type__tdmf_g;
  table_column__values_distinct_form_l.sql__quotation_sign__tcvd := sql__quotation_sign__tdmf_g;
  table_column__values_distinct_form_l.sql__quotation_sign__use__tcvd := sql__quotation_sign__use__tdmf_g;
  table_column__values_distinct_form_l.table_name__tcvd := table_name__tdmf_g;
  table_column__values_distinct_form_l.queries_open_in_background_g := queries_open_in_background_g;
  table_column__values_distinct_form_l.table_column__values_distinct_form_list := table_column__values_distinct_form_list__tdmf_g;
  table_column__values_distinct_form_l.Show();


  table_column__values_distinct_form_list__tdmf_g.Add( table_column__values_distinct_form_l );

end;

procedure TTable__Data_Modify_F_Frame.Delete_Visible_Records_ButtonClick( Sender: TObject );
begin

  if Self.Task_Running_Check__TDMF() then
    Exit;


  if   ( data__sdbm = nil )
    or ( not data__sdbm.Query__Active() )
    or ( data__sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_visible_records_), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  data__sdbm.Query__First();

  while data__sdbm.Query__Record_Count() > 0 do
    data__sdbm.Query__Delete();

end;

procedure TTable__Data_Modify_F_Frame.Editing_CheckBoxClick( Sender: TObject );
var
  i : integer;
begin

  if editing_checkboxclick__block_g then
    Exit;


  if Editing_CheckBox.Checked then
    Data_DBGrid.Options := Data_DBGrid.Options + [ dgEditing ]
  else
    Data_DBGrid.Options := Data_DBGrid.Options - [ dgEditing ];


  for i := 0 to Data_ScrollBox.ControlCount - 1 do
    if Data_ScrollBox.Controls[ i ].ClassType = Form_View_Field.TForm_View_Field then
      Form_View_Field.TForm_View_Field(Data_ScrollBox.Controls[ i ]).Editing__Set__FVF( Editing_CheckBox.Checked );

end;

procedure TTable__Data_Modify_F_Frame.Grid_View_CheckBoxClick( Sender: TObject );
var
  i : integer;
begin

  Data_DBGrid.Visible := Grid_View_CheckBox.Checked;
  Data_ScrollBox.Visible := not Data_DBGrid.Visible;


  if Grid_View_CheckBox.Checked then
    begin

      // Grid.

    end
  else
    begin

      // Form.

      if Data_ScrollBox.ControlCount <= 1 then // Width_Keeper_Label.
        begin

          if @Additional_Component_Show__Get_wsk <> nil then
            additional_component_show_g := Additional_Component_Show__Get_wsk();

          if @Splitter_Show__Get_wsk <> nil then
            splitter_show_g := Splitter_Show__Get_wsk();


          Data_ScrollBox.Visible := false;

          for i := 0 to data__sdbm.Query__Field_Count() - 1 do
            begin

              Form_View_Field.TForm_View_Field.Create(  Data_ScrollBox, Data_DataSource, data__sdbm.Query__Fields( i ), additional_component_show_g, Editing_CheckBox.Checked, splitter_show_g, @field_name_selected_g, Data_DBGridKeyDown, Key_Up_Common  );

            end;

          Data_ScrollBox.Visible := true;


          for i := Data_ScrollBox.ControlCount - 1 downto 0 do
            if Data_ScrollBox.Controls[ i ].ClassType = Form_View_Field.TForm_View_Field then
              Form_View_Field.TForm_View_Field(Data_ScrollBox.Controls[ i ]).Align_Correct__FVF();


          //Width_Keeper_Label.BringToFront();

        end;

    end;

end;

procedure TTable__Data_Modify_F_Frame.Search_Change( Sender: TObject );
var
  locate_options : Data.DB.TLocateOptions;
begin

  if Self.Task_Running_Check__TDMF() then
    Exit;


  if   ( data__sdbm = nil )
    or ( not data__sdbm.Query__Active() ) then
    Exit;


  if data__sort__column_name_g = '' then
    data__sort__column_name_g := Data_DBEdit.DataField;


  locate_options := [];

  if Search__Case_Insensitive_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loCaseInsensitive ];

  if Search__Partial_Key_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loPartialKey ];


  if data__sdbm.Query__Locate( data__sort__column_name_g, Search_Edit.Text, locate_options ) then
    Search_Edit.Color := clWindow
  else
    begin

      Search_Edit.Color := Common.color__red__light_c;


      data__sdbm.Query__Disable_Controls();

      data__sdbm.Query__First();

      while not data__sdbm.Query__Eof do
        begin

          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  data__sdbm.Query__Field_By_Name( data__sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

          data__sdbm.Query__Next();

        end;

      data__sdbm.Query__Enable_Controls();

    end;

end;

procedure TTable__Data_Modify_F_Frame.Search__Next_ButtonClick( Sender: TObject );
begin

  if Self.Task_Running_Check__TDMF() then
    Exit;


  if   ( data__sdbm = nil )
    or ( not data__sdbm.Query__Active() ) then
    Exit;


  if data__sort__column_name_g = '' then
    data__sort__column_name_g := Data_DBEdit.DataField;


  data__sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not data__sdbm.Query__Eof do
    begin

      data__sdbm.Query__Next();

      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  data__sdbm.Query__Field_By_Name( data__sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  data__sdbm.Query__Enable_Controls();

end;

procedure TTable__Data_Modify_F_Frame.Search__Prior_ButtonClick( Sender: TObject );
begin

  if Self.Task_Running_Check__TDMF() then
    Exit;


  if   ( data__sdbm = nil )
    or ( not data__sdbm.Query__Active() ) then
    Exit;


  if data__sort__column_name_g = '' then
    data__sort__column_name_g := Data_DBEdit.DataField;


  data__sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not data__sdbm.Query__Bof do
    begin

      data__sdbm.Query__Prior();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  data__sdbm.Query__Field_By_Name( data__sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  data__sdbm.Query__Enable_Controls();

end;

procedure TTable__Data_Modify_F_Frame.Width_Keeper__Move_ButtonClick( Sender: TObject );
var
  zti : integer;
begin

  if    ( Sender <> nil )
    and ( TComponent(Sender).Name = Width_Keeper__Move__Left_Button.Name ) then
    zti := -1
  else
    zti := 1;


  Width_Keeper_Label.Left := Width_Keeper_Label.Left + zti * Width_Keeper_Label.Width;

end;

procedure TTable__Data_Modify_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Buttons_Panel.Width := 1;

end;

procedure TTable__Data_Modify_F_Frame.Width_Keeper_LabelMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin

  Width_Keeper_Label.BeginDrag( false );

end;

procedure TTable__Data_Modify_F_Frame.Data_ScrollBoxDragOver( Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean );
begin

  Width_Keeper_Label.Left := X;

end;

procedure TTable__Data_Modify_F_Frame.Data_Filter__Activate__All_ButtonClick( Sender: TObject );
var
  i : integer;

  zts : string;

  table__data_filter_t : Table__Data_Filter.TTable__Data_Filter_t;
begin

  table__data_filter_t := Table__Data_Filter.Filters_From_Left_To_Right__Get( Data_Filter_ScrollBox );

  zts := '';

  //for i := 0 to Data_Filter_ScrollBox.ControlCount - 1 do
  //  if Data_Filter_ScrollBox.Controls[ i ].ClassType = Table__Data_Filter.TTable__Data_Filter then
  //    zts := zts +
  //      Table__Data_Filter.TTable__Data_Filter(Data_Filter_ScrollBox.Controls[ i ]).Filter_Value__Get( sql__quotation_sign__use__tdmf_g );

  for i := 0 to Length( table__data_filter_t ) - 1 do
    zts := zts +
      table__data_filter_t[ i ].Filter_Value__Get( sql__quotation_sign__use__tdmf_g );


  SetLength( table__data_filter_t, 0 );


  if Trim( zts ) <> '' then
    zts := ' where ' + zts;


  if   ( Sender = nil )
    or (
             ( Sender <> nil )
         and ( TComponent(Sender).Name = Data_Filter__Show_Button.Name )
       ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.filter_value );
      Log_Memo.Lines.Add( zts );

      Exit;

    end;


  data__filter_value_g := zts;


  if data__sdbm.Query__Active() then
    Open_Close_ButtonClick( Sender );

  if not data__sdbm.Query__Active() then
    Open_Close_ButtonClick( Sender );

end;

procedure TTable__Data_Modify_F_Frame.Data_Filter__Add_ButtonClick( Sender: TObject );
var
  zt_table__data_filter : Table__Data_Filter.TTable__Data_Filter;
begin

  Field_Name_Selected_From_Form_View__Set();


  zt_table__data_filter := Table__Data_Filter.TTable__Data_Filter.Create( Data_Filter_ScrollBox, database_type__tdmf_g, table_name__tdmf_g, sql__quotation_sign__tdmf_g, queries_open_in_background_g, Data_DBGrid.SelectedField, data__sdbm, Log_Memo );
  zt_table__data_filter.Align_Correct__DTF();
  zt_table__data_filter.Filter__Activate_wsk := Data_Filter__Activate__All_ButtonClick;
  zt_table__data_filter.Filter__Deactivate_wsk := Data_Filter__Deactivate__All_ButtonClick;
  zt_table__data_filter.Filter__Show_wsk := Data_Filter__Activate__All_ButtonClick;

end;

procedure TTable__Data_Modify_F_Frame.Data_Filter__Deactivate__All_ButtonClick( Sender: TObject );
begin

  data__filter_value_g := '';


  if data__sdbm.Query__Active() then
    begin

      Open_Close_ButtonClick( Sender );

      if not data__sdbm.Query__Active() then
        Open_Close_ButtonClick( Sender );

    end;

end;

procedure TTable__Data_Modify_F_Frame.Data_Filter__Delete__All_ButtonClick( Sender: TObject );
begin

  Table__Data_Filter__Free();

end;

procedure TTable__Data_Modify_F_Frame.Data_Value_Format__Disabled_CheckBoxClick( Sender: TObject );
begin

  Common.Data_Value_Format__Set( data__sdbm, Log_Memo, Data_Value_Format__Disabled_CheckBox.Checked );

end;

procedure TTable__Data_Modify_F_Frame.Data_Preview_DBMemoChange( Sender: TObject );
begin

  Caret_Position_Display();

end;

procedure TTable__Data_Modify_F_Frame.Data_Preview_DBMemoClick( Sender: TObject );
begin

  Caret_Position_Display();

end;

procedure TTable__Data_Modify_F_Frame.Data_Preview_DBMemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

  Key_Up_Common( Sender, Key, Shift );

end;

procedure TTable__Data_Modify_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TTable__Data_Modify_F_Frame.Data_DBGridCellClick( Column: TColumn );
begin

  Data_Preview();

end;

procedure TTable__Data_Modify_F_Frame.Data_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
begin

  if Self.Task_Running_Check__TDMF( false ) then
    Exit;


  Common.DB_Grid_Draw_Column_Cell( data__sort__column_name_g, Data_DBGrid, Rect, DataCol, Column, State );

end;

procedure TTable__Data_Modify_F_Frame.Data_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
var
  i : integer;
begin

  if Self.Task_Running_Check__TDMF() then
    Exit;


  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl, ssShift ] )
    and ( not Grid_View_CheckBox.Checked ) then // Form.
    begin

      for i := 0 to Data_ScrollBox.ControlCount - 1 do
        if Data_ScrollBox.Controls[ i ].ClassType = Form_View_Field.TForm_View_Field then
          Form_View_Field.TForm_View_Field(Data_ScrollBox.Controls[ i ]).Align_Correct__FVF();
    end
  else
  if Key = VK_F5 then
    Refresh_ButtonClick( Sender )
  else
  // D.
  if    ( Key = 68 )
    and (
             ( Shift = [ ssCtrl ] )
          or ( Shift = [ ssShift ] )
        ) then
    Table_Column__Values_Distinct_ButtonClick( Sender )
  else
  // F.
  if    ( Key = 70 )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Data_Filter__Add_ButtonClick( Sender );

      if Data_PageControl.Height <= 1 then
        Data_PageControl.Height := 300;

    end
  else
  // O.
  if    ( Key = 79 )
    and ( Shift = [ ssCtrl ] ) then
    Open_Close_ButtonClick( Refresh_Button )
  else
  // R.
  if    ( Key = 82 )
    and ( Shift = [ ssCtrl ] ) then
    Refresh_ButtonClick( Refresh_Button )
  else
  // S.
  if    ( Key = 83 )
    and (
             ( Shift = [ ssCtrl ] )
          or ( Shift = [ ssShift ] )
        ) then
    Column__Values__Sum()
  else
  if Grid_View_CheckBox.Checked then
    // C.
    if    ( Key = 67 )
      and ( Shift = [ ssCtrl ] )
      and ( data__sdbm.Query__Active() )
      and ( data__sdbm.Query__Record_Count > 0 )
      and ( Data_DBGrid.SelectedField <> nil ) then
      try
        Vcl.Clipbrd.Clipboard.AsText := Data_DBGrid.SelectedField.Value;
      except
        on E : Exception do
          Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
      end;

end;

procedure TTable__Data_Modify_F_Frame.Data_DBGridKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Data_Preview();

  Key_Up_Common( Sender, Key, Shift );

end;

procedure TTable__Data_Modify_F_Frame.Data_DBGridTitleClick( Column: TColumn );
begin

  if Self.Task_Running_Check__TDMF() then
    Exit;


  if Column.Field = nil then
    Exit;


  if data__sort__column_name_g = Column.Field.FieldName then
    data__sort__direction_ascending_g := not data__sort__direction_ascending_g
  else
    data__sort__column_name_g := Column.Field.FieldName;

  data__sdbm.Query__Sort(  data__sort__column_name_g + Common.Sort_Direction_Symbol( data__sort__direction_ascending_g )  );


  Data_DBEditChange( nil ); // For FireDAC.

end;

end.
