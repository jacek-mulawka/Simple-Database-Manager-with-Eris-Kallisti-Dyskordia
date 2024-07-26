unit Triggers_Modify_F;{16.Sie.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Text__Search_Replace,
  Translation,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Menus, SynEdit,

  Interceptor__Syn_Edit;

type
  TTriggers_Type = ( tt_none, tt_database, tt_table );

  TTriggers_Modify_F_Frame = class( TFrame )
    Buttons_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    Trigger_Name_DBEdit: TDBEdit;
    Trigger_Name_Etiquette_Label: TLabel;
    Triggers_DataSource: TDataSource;
    Triggers_DBGrid: TDBGrid;
    Log_Memo: TMemo;
    Record_Number__Records_Count_Label: TLabel;
    Search_Edit: TEdit;
    Search_GroupBox: TGroupBox;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Next_Button: TButton;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Prior_Button: TButton;
    Vertical_Splitter: TSplitter;
    Triggers_PopupMenu: TPopupMenu;
    Trigger__Add_MenuItem: TMenuItem;
    Trigger__Edit_MenuItem: TMenuItem;
    Trigger__Delete_MenuItem: TMenuItem;
    N1: TMenuItem;
    Trigger__Description__Set_MenuItem: TMenuItem;
    Trigger__Description__Drop_MenuItem: TMenuItem;
    N2: TMenuItem;
    Trigger__Description__Write_In_Log_MenuItem: TMenuItem;
    Modify_GroupBox: TGroupBox;
    Modify__Add_Button: TButton;
    Modify__Edit_Button: TButton;
    Modify__Delete_Button: TButton;
    Refresh_Button: TButton;
    Triggers_Panel: TPanel;
    Trigger_Source_GroupBox: TGroupBox;
    Trigger_Source_Memo_Horizontal_Splitter: TSplitter;
    Trigger_Source_DBMemo: TDBMemo;
    Trigger_Source_SynEdit: TSynEdit;
    Caret_Position_Label: TLabel;
    Log_Horizontal_Splitter: TSplitter;

    procedure Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );

    procedure Trigger_Name_DBEditChange( Sender: TObject );
    procedure Search_Change( Sender: TObject );
    procedure Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );

    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Modify__Add_ButtonClick( Sender: TObject );
    procedure Modify__Edit_ButtonClick( Sender: TObject );
    procedure Modify__Delete_ButtonClick( Sender: TObject );

    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );

    procedure Trigger__Description__Set_MenuItemClick( Sender: TObject );
    procedure Trigger__Description__Drop_MenuItemClick( Sender: TObject );
    procedure Trigger__Description__Write_In_Log_MenuItemClick( Sender: TObject );

    procedure Trigger_Source_DBMemoClick( Sender: TObject );
    procedure Trigger_Source_DBMemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Trigger_Source_SynEditEnter( Sender: TObject );
    procedure Trigger_Source_SynEditClick( Sender: TObject );
    procedure Trigger_Source_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Trigger_Source_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Trigger_Source_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );

    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Triggers_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
    procedure Triggers_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Triggers_DBGridTitleClick( Column: TColumn );
  private
    { Private declarations }
    sort__direction_ascending_g,
    sql__quotation_sign__use__trmf_g
      : boolean;

    database_type__trmf_g,
    sort__column_name_g,
    sql__quotation_sign__trmf_g,
    table_name__trmf_g
      : string;

    triggers_type_g : TTriggers_Type;

    triggers_sdbm : Common.TSDBM;

    procedure Caret_Position_Display();
    procedure Trigger__Description__Set__Sql_Execute( const sql_text_f : string; const show_message_f : boolean = true );
    function Trigger__Description__Set__Sql_Prepare( const trigger_name_f, description_value_f : string ) : string;
    procedure Parent_Tab_Switch( const prior_f : boolean = false );
    function Quotation_Sign__TrMF() : string;
  public
    { Public declarations }
    parent_supreme_tab_sheet__trmf : Vcl.Controls.TWinControl;

    text__search_replace_form : Text__Search_Replace.TText__Search_Replace_Form;

    procedure Data_Open__TrMF();
    procedure Finish__TrMF();
    procedure Highlight__Font__Set__TrMF();
    procedure Options_Set__TrMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
    procedure Prepare__TrMF( const triggers_type_f : TTriggers_Type; const table_name_f, database_type_f, sql__quotation_sign_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
    procedure Translation__Apply__TrMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
  end;

const
  table__triggers_list__file_name_c : string = 'Table__Triggers_List__sql.txt';
  database__triggers_list__file_name_c : string = 'Database__Triggers_List__sql.txt';
  triggers_list__sql__description__drop__file_name_c : string = 'Trigger__Description__Drop__sql.txt';
  triggers_list__sql__description__set__file_name_c : string = 'Trigger__Description__Set__sql.txt';
  triggers_list__sql__trigger_drop__file_name_c : string = 'Trigger__Drop__sql.txt';

implementation

uses
  Vcl.Clipbrd,
  Vcl.ComCtrls,

  Database__Trigger_Modify,
  Shared,
  Table__Trigger_Modify,
  Text__Edit_Memo;

{$R *.dfm}

procedure TTriggers_Modify_F_Frame.Caret_Position_Display();
begin

  //Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Trigger_Source_DBMemo.CaretPos.Y + 1 )  ) + ' / ' + Trim(   FormatFloat( '### ### ### ### ### ### ##0', Trigger_Source_DBMemo.CaretPos.X + 1 ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Trigger_Source_DBMemo.Lines.Text.Length )  )   );
  Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Trigger_Source_SynEdit.CaretY )  ) + ' / ' + Trim(   FormatFloat( '### ### ### ### ### ### ##0', Trigger_Source_SynEdit.CaretX ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Trigger_Source_SynEdit.Lines.Text.Length )  )   );

end;

procedure TTriggers_Modify_F_Frame.Data_Open__TrMF();
var
  i : integer;

  zts,
  triggers_list__file_name_l
    : string;
begin

  if   ( triggers_sdbm = nil )
    or ( triggers_sdbm.component_type__sdbm = Common.ct_none ) then
    Exit;


  Screen.Cursor := crHourGlass;

  if triggers_sdbm.Query__Active() then
    triggers_sdbm.Query__Close();


  if triggers_type_g = tt_database then
    triggers_list__file_name_l := database__triggers_list__file_name_c
  else
    triggers_list__file_name_l := table__triggers_list__file_name_c;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__trmf_g ) + triggers_list__file_name_l  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__trmf_g ) + triggers_list__file_name_l + ').' );

      zts :=
        'select RDB$TRIGGERS.RDB$TRIGGER_NAME as TRIGGER_NAME ' +
        '     , iif( RDB$TRIGGERS.RDB$TRIGGER_INACTIVE = 0, ''' + Common.db_grid__positive_value_c + ''', '''' ) as TRIGGER_ACTIVE ' +
        '     , RDB$TRIGGERS.RDB$TRIGGER_SEQUENCE as TRIGGER_SEQUENCE ' +
        ' ' +
        '     , (case ' +
        '         RDB$TRIGGERS.RDB$TRIGGER_TYPE ' +
        '         when 1 then ' +
        '           ''before insert'' ' +
        ' ' +
        '         when 2 then ' +
        '           ''after insert'' ' +
        ' ' +
        '         when 3 then ' +
        '           ''before update'' ' +
        ' ' +
        '         when 4 then ' +
        '           ''after update'' ' +
        ' ' +
        '         when 5 then ' +
        '           ''before delete'' ' +
        ' ' +
        '         when 6 then ' +
        '           ''after delete'' ' +
        ' ' +
        '         when 17 then ' +
        '           ''before insert or update'' ' +
        ' ' +
        '         when 18 then ' +
        '           ''after insert or update'' ' +
        ' ' +
        '         when 25 then ' +
        '           ''before delete or insert'' ' +
        ' ' +
        '         when 26 then ' +
        '           ''after delete or insert'' ' +
        ' ' +
        '         when 27 then ' +
        '           ''before delete or update'' ' +
        ' ' +
        '         when 28 then ' +
        '           ''after delete or update'' ' +
        ' ' +
        '         when 77 then ' +
        '           ''before delete or insert or update'' ' +
        ' ' +
        '         when 78 then ' +
        '           ''after delete or insert or update'' ' +
        ' ' +
        '         when 113 then ' +
        '           ''before delete or insert or update'' ' +
        ' ' +
        '         when 114 then ' +
        '           ''after delete or insert or update'' ' +
        ' ' +
        '         when 8192 then ' +
        '           ''on connect'' ' +
        ' ' +
        '         when 8193 then ' +
        '           ''on disconnect'' ' +
        ' ' +
        '         when 8194 then ' +
        '           ''on transaction start'' ' +
        ' ' +
        '         when 8195 then ' +
        '           ''on transaction commit'' ' +
        ' ' +
        '         when 8196 then ' +
        '           ''on transaction rollback'' ' +
        ' ' +
        '         else ' +
        '           RDB$TRIGGERS.RDB$TRIGGER_TYPE||'' <?>'' ' +
        '       end) as TRIGGER_TYPE ' +
        ' ' +
        //'     , cast(  substring( RDB$TRIGGERS.RDB$DESCRIPTION from 1 for 10000 ) as varchar( 10000 )  ) as DESCRIPTION_VALUE__CAST ' +
        '     , cast(  substring( RDB$TRIGGERS.RDB$DESCRIPTION from 1 for 8191 ) as varchar( 8191 )  ) as DESCRIPTION_VALUE__CAST ' + // FireDAC limit default - FDConnection1.FormatOptions.MaxStringSize = 32767 bytes ( / 4 = 8191,75 ).
        '     , RDB$TRIGGERS.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
        '     , RDB$TRIGGERS.RDB$TRIGGER_SOURCE as TRIGGER_SOURCE ' +
        '     , RDB$TRIGGERS.RDB$TRIGGER_TYPE as TRIGGER_TYPE_NUMBER ' +
        'from RDB$TRIGGERS ' +
        'where RDB$TRIGGERS.RDB$RELATION_NAME ';

      if triggers_type_g = tt_database then
        zts := zts +
          ' is null'
      else
        zts := zts +
          '= :table_name';

      zts := zts +
        ' order by RDB$TRIGGERS.RDB$TRIGGER_SEQUENCE ';

    end;

  triggers_sdbm.Query__Sql__Set( zts );


  Log_Memo.Lines.Add( zts );


  if triggers_type_g = tt_table then
    triggers_sdbm.Query__Param_By_Name__Set( Common.name__table__small_letters_c, table_name__trmf_g, Log_Memo );

  try
    triggers_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_triggers_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;


  Screen.Cursor := crDefault;



  if triggers_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( triggers_sdbm.Operation_Duration_Get() );


      try
        triggers_sdbm.Query__Field_By_Name( Common.name__trigger__name__big_letters_c ).AsString;
        Trigger_Name_DBEdit.DataField := Common.name__trigger__name__big_letters_c;
        triggers_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );
      except
        on E : Exception do
          begin

            triggers_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_trigger_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;


      if triggers_sdbm.Query__Active() then
        try
          triggers_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
        except
          on E : Exception do
            begin

              triggers_sdbm.Query__Close();

              Log_Memo.Lines.Add( E.Message );

              Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_description_column_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            end;
        end;


      if triggers_sdbm.Query__Active() then
        try
          triggers_sdbm.Query__Field_By_Name( Common.name__trigger__source_c ).AsString;
          Trigger_Source_DBMemo.DataField := Common.name__trigger__source_c;
        except
          on E : Exception do
            begin

              triggers_sdbm.Query__Close();

              Log_Memo.Lines.Add( E.Message );

              Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_source_column_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            end;
        end;


      for i := 0 to Triggers_DBGrid.Columns.Count - 1 do
        if Triggers_DBGrid.Columns.Items[ i ].FieldName = Common.name__trigger__active_c then
          begin

            if Triggers_DBGrid.Columns.Items[ i ].Width < 50 then
              Triggers_DBGrid.Columns.Items[ i ].Width := 50;

          end
        else
        if Triggers_DBGrid.Columns.Items[ i ].FieldName = Common.name__trigger__name__big_letters_c then
          begin

            if Triggers_DBGrid.Columns.Items[ i ].Width > 500 then
              Triggers_DBGrid.Columns.Items[ i ].Width := 500;

          end
        else
        if Triggers_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value__cast_c then
          begin

            if Triggers_DBGrid.Columns.Items[ i ].Width > 500 then
              Triggers_DBGrid.Columns.Items[ i ].Width := 500;

          end
        else
          begin

            if Triggers_DBGrid.Columns.Items[ i ].Width > 200 then
              Triggers_DBGrid.Columns.Items[ i ].Width := 200;

          end;


      Self.Translation__Apply__TrMF( Translation.tak_Grid );


      Common.Data_Value_Format__Set( triggers_sdbm, Log_Memo );

    end;


  Trigger_Source_SynEdit.Lines.Text := Trigger_Source_DBMemo.Lines.Text;

end;

procedure TTriggers_Modify_F_Frame.Trigger__Description__Set__Sql_Execute( const sql_text_f : string; const show_message_f : boolean = true );
var
  ztb : boolean;

  error_message_l : string;
begin

  ztb := triggers_sdbm.Sql_Command_Execute( sql_text_f, error_message_l, Translation.translation__messages_r.failed_to_set_the_trigger_description );


  if ztb then
    begin

      if show_message_f then
        begin

          Log_Memo.Lines.Add( triggers_sdbm.Operation_Duration_Get() );


          Refresh_ButtonClick( nil );

          Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

        end;

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

function TTriggers_Modify_F_Frame.Trigger__Description__Set__Sql_Prepare( const trigger_name_f, description_value_f : string ) : string;
begin

  Result := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__trmf_g ) + triggers_list__sql__description__set__file_name_c  );

  if Trim( Result ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__trmf_g ) + triggers_list__sql__description__set__file_name_c + ').' );

      Result :=
        'comment on trigger ' +
        trigger_name_f +
        ' is ''' + description_value_f + ''' ';

    end
  else
    begin

      Result := StringReplace( Result, Common.sql__word_replace_separator_c + Common.name__trigger__name__big_letters_c + Common.sql__word_replace_separator_c, trigger_name_f, [ rfReplaceAll ] );
      Result := StringReplace( Result, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_f, [ rfReplaceAll ] );

    end;

end;

procedure TTriggers_Modify_F_Frame.Finish__TrMF();
begin

  Common.Text__Search_Replace__Syn_Edit__Set( nil, text__search_replace_form );
  Common.Text__Search_Replace__Hide( text__search_replace_form );


  FreeAndNil( triggers_sdbm );

  if text__search_replace_form <> nil then
    FreeAndNil( text__search_replace_form );

end;

procedure TTriggers_Modify_F_Frame.Highlight__Font__Set__TrMF();
begin

  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );
  //Common.Font__Set( Trigger_Source_DBMemo.Font, Common.sql_editor__font );
  Common.Font__Set( Trigger_Source_SynEdit.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    Common.Font__Set( Triggers_DBGrid.Font, Common.sql_editor__font );

  Common.Syn_Edit__Parameters__Set( Trigger_Source_SynEdit );


  Common.Syn_Edit__Search_Text_Hightlighter_Syn_Edit_Plugin__Create( Trigger_Source_SynEdit );

end;

procedure TTriggers_Modify_F_Frame.Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );
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

procedure TTriggers_Modify_F_Frame.Options_Set__TrMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
begin

  sql__quotation_sign__use__trmf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__trmf_g := sql__quotation_sign_f;


  if triggers_sdbm <> nil then
    begin

      triggers_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

      triggers_sdbm.Data_Source__Data_Set__Set( Triggers_DataSource );

    end;


  Self.Translation__Apply__TrMF( Translation.tak_Self );

end;

procedure TTriggers_Modify_F_Frame.Parent_Tab_Switch( const prior_f : boolean = false );
var
  zti : integer;
begin

  if    ( parent_supreme_tab_sheet__trmf <> nil )
    and ( parent_supreme_tab_sheet__trmf is TTabSheet )
    and ( parent_supreme_tab_sheet__trmf.Parent <> nil )
    and ( parent_supreme_tab_sheet__trmf.Parent is TPageControl )
    and ( TPageControl(parent_supreme_tab_sheet__trmf.Parent).PageCount > 1 ) then
    begin

      zti := TPageControl(parent_supreme_tab_sheet__trmf.Parent).ActivePageIndex;


      if not prior_f then
        begin

          // Next.

          inc( zti );

          if zti > TPageControl(parent_supreme_tab_sheet__trmf.Parent).PageCount - 1 then
            zti := 0;

        end
      else
        begin

          // Prior.

          dec( zti );

          if zti < 0 then
            zti := TPageControl(parent_supreme_tab_sheet__trmf.Parent).PageCount - 1;

        end;


      TPageControl(parent_supreme_tab_sheet__trmf.Parent).ActivePageIndex := zti;

    end;

end;

procedure TTriggers_Modify_F_Frame.Prepare__TrMF( const triggers_type_f : TTriggers_Type; const table_name_f, database_type_f, sql__quotation_sign_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
begin

  Self.Name := '';

  database_type__trmf_g := database_type_f;
  sort__column_name_g := Common.name__trigger__name__big_letters_c;
  //sort__column_name_g := ''; // RDB$TRIGGERS.RDB$TRIGGER_SEQUENCE probably is more important.
  sort__direction_ascending_g := true;
  table_name__trmf_g := table_name_f;
  text__search_replace_form := nil;

  if triggers_type_f = tt_database then
    begin

      triggers_type_g := tt_database;

      Log_Memo.Lines.Add( Translation.translation__messages_r.word__database );

    end
  else
    begin

      triggers_type_g := tt_table;

      Log_Memo.Lines.Add( table_name__trmf_g );

    end;


  triggers_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Self.Options_Set__TrMF( component_type_f, sql__quotation_sign_f, sql__quotation_sign__use_f );


  Highlight__Font__Set__TrMF();

end;

function TTriggers_Modify_F_Frame.Quotation_Sign__TrMF() : string;
begin

  if sql__quotation_sign__use__trmf_g then
    begin

      Result := sql__quotation_sign__trmf_g;

    end
  else
    Result := '';

end;

procedure TTriggers_Modify_F_Frame.Translation__Apply__TrMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
var
  i : integer;
begin

  if tak_f in [ Translation.tak_All, Translation.tak_Self ] then
    Translation.Translation__Apply( Self );


  if tak_f in [ Translation.tak_All, Translation.tak_Grid ] then
    for i := 0 to Triggers_DBGrid.Columns.Count - 1 do
      if Triggers_DBGrid.Columns.Items[ i ].FieldName = Common.name__trigger__active_c then
        Triggers_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__active
      else
      if Triggers_DBGrid.Columns.Items[ i ].FieldName = Common.name__trigger__name__big_letters_c then
        Triggers_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__trigger__name
      else
      if Triggers_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value__cast_c then
        Triggers_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__description
      else
        Triggers_DBGrid.Columns.Items[ i ].Title.Caption := Common.Column__Name_To_Grid_Caption( Triggers_DBGrid.Columns.Items[ i ].FieldName );

end;

procedure TTriggers_Modify_F_Frame.Trigger_Name_DBEditChange( Sender: TObject );
begin

  if    ( triggers_sdbm <> nil )
    and ( triggers_sdbm.Query__Active() ) then
    Record_Number__Records_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', triggers_sdbm.Query__Record_Number() )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', triggers_sdbm.Query__Record_Count() )  )
  else
    Record_Number__Records_Count_Label.Caption := '0 / 0';


  Trigger_Source_SynEdit.Lines.Text := Trigger_Source_DBMemo.Lines.Text;


  Caret_Position_Display();

end;

procedure TTriggers_Modify_F_Frame.Search_Change( Sender: TObject );
var
  locate_options : Data.DB.TLocateOptions;
begin

  if   ( triggers_sdbm = nil )
    or ( not triggers_sdbm.Query__Active() ) then
    Exit;


  locate_options := [];

  if Search__Case_Insensitive_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loCaseInsensitive ];

  if Search__Partial_Key_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loPartialKey ];


  if triggers_sdbm.Query__Locate( sort__column_name_g, Search_Edit.Text, locate_options ) then
    Search_Edit.Color := clWindow
  else
    begin

      Search_Edit.Color := Common.color__red__light_c;


      triggers_sdbm.Query__Disable_Controls();

      triggers_sdbm.Query__First();

      while not triggers_sdbm.Query__Eof do
        begin

          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  triggers_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

          triggers_sdbm.Query__Next();

        end;

      triggers_sdbm.Query__Enable_Controls();

    end;

end;

procedure TTriggers_Modify_F_Frame.Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_PRIOR then
    Search__Prior_ButtonClick( Sender )
  else
  if Key = VK_NEXT then
    Search__Next_ButtonClick( Sender );

end;

procedure TTriggers_Modify_F_Frame.Search__Next_ButtonClick( Sender: TObject );
begin

  if   ( triggers_sdbm = nil )
    or ( not triggers_sdbm.Query__Active() ) then
    Exit;


  triggers_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not triggers_sdbm.Query__Eof do
    begin

      triggers_sdbm.Query__Next();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  triggers_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  triggers_sdbm.Query__Enable_Controls();

end;

procedure TTriggers_Modify_F_Frame.Search__Prior_ButtonClick( Sender: TObject );
begin

  if   ( triggers_sdbm = nil )
    or ( not triggers_sdbm.Query__Active() ) then
    Exit;


  triggers_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not triggers_sdbm.Query__Bof do
    begin

      triggers_sdbm.Query__Prior();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  triggers_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  triggers_sdbm.Query__Enable_Controls();

end;

procedure TTriggers_Modify_F_Frame.Refresh_ButtonClick( Sender: TObject );
var
  primary_key_value_l : string;
begin

  if   ( triggers_sdbm = nil )
    or ( not triggers_sdbm.Query__Active() ) then
    begin

      Self.Data_Open__TrMF();

      Exit;

    end;


  primary_key_value_l := triggers_sdbm.Query__Field_By_Name( Common.name__trigger__name__big_letters_c ).AsString;

  triggers_sdbm.Query__Requery();


  if    ( Sender <> nil )
    and ( Sender = Refresh_Button ) then
    begin

      Log_Memo.Lines.Add( triggers_sdbm.Operation_Duration_Get() );

    end;


  triggers_sdbm.Query__Locate( Common.name__trigger__name__big_letters_c, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );


  Trigger_Name_DBEditChange( Sender );

end;

procedure TTriggers_Modify_F_Frame.Modify__Add_ButtonClick( Sender: TObject );
var
  modified_l,
  trigger_edit_l
    : boolean;

  description_value_l,
  trigger_name_l
    : string;
begin

  if   ( triggers_sdbm = nil )
    or ( not triggers_sdbm.Query__Active() ) then
    Exit;


  if triggers_type_g = tt_database then
    begin

      Database__Trigger_Modify.Database__Trigger_Modify_Form := Database__Trigger_Modify.TDatabase__Trigger_Modify_Form.Create( Application, triggers_sdbm );
      Database__Trigger_Modify.Database__Trigger_Modify_Form.database_type__dtm := database_type__trmf_g;
      Database__Trigger_Modify.Database__Trigger_Modify_Form.sql__quotation_sign__dtm := sql__quotation_sign__trmf_g;
      Database__Trigger_Modify.Database__Trigger_Modify_Form.sql__quotation_sign__use__dtm := sql__quotation_sign__use__trmf_g;

    end
  else
    begin

      Table__Trigger_Modify.Table__Trigger_Modify_Form := Table__Trigger_Modify.TTable__Trigger_Modify_Form.Create( Application, triggers_sdbm );
      Table__Trigger_Modify.Table__Trigger_Modify_Form.database_type__ttm := database_type__trmf_g;
      Table__Trigger_Modify.Table__Trigger_Modify_Form.sql__quotation_sign__ttm := sql__quotation_sign__trmf_g;
      Table__Trigger_Modify.Table__Trigger_Modify_Form.sql__quotation_sign__use__ttm := sql__quotation_sign__use__trmf_g;
      Table__Trigger_Modify.Table__Trigger_Modify_Form.table_name__ttm := table_name__trmf_g;

    end;


  if    ( Sender <> nil )
    and (
             ( Sender = Modify__Edit_Button )
          or ( Sender = Trigger__Edit_MenuItem )
        ) then
    begin

      trigger_edit_l := true;


      if triggers_type_g = tt_database then
        begin

          Database__Trigger_Modify.Database__Trigger_Modify_Form.trigger_name__dtm := triggers_sdbm.Query__Field_By_Name( Common.name__trigger__name__big_letters_c ).AsString;

          Database__Trigger_Modify.Database__Trigger_Modify_Form.trigger_edit__dtm := true;

        end
      else
        begin

          Table__Trigger_Modify.Table__Trigger_Modify_Form.trigger_name__ttm := triggers_sdbm.Query__Field_By_Name( Common.name__trigger__name__big_letters_c ).AsString;

          Table__Trigger_Modify.Table__Trigger_Modify_Form.trigger_edit__ttm := true;

        end;


      description_value_l := triggers_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;

    end
  else
    begin

      trigger_edit_l := false;

      description_value_l := '';

    end;

  if triggers_type_g = tt_database then
    begin

      Database__Trigger_Modify.Database__Trigger_Modify_Form.ShowModal();

      modified_l := Database__Trigger_Modify.Database__Trigger_Modify_Form.modified__dtm;
      trigger_name_l := Database__Trigger_Modify.Database__Trigger_Modify_Form.Trigger_Name_Edit.Text;

      FreeAndNil( Database__Trigger_Modify.Database__Trigger_Modify_Form );

    end
  else
    begin

      Table__Trigger_Modify.Table__Trigger_Modify_Form.ShowModal();

      modified_l := Table__Trigger_Modify.Table__Trigger_Modify_Form.modified__ttm;
      trigger_name_l := Table__Trigger_Modify.Table__Trigger_Modify_Form.Trigger_Name_Edit.Text;

      FreeAndNil( Table__Trigger_Modify.Table__Trigger_Modify_Form );

    end;


  if modified_l then
    begin

      if trigger_edit_l then
        Trigger__Description__Set__Sql_Execute(  Trigger__Description__Set__Sql_Prepare( Self.Quotation_Sign__TrMF() + triggers_sdbm.Query__Field_By_Name( Common.name__trigger__name__big_letters_c ).AsString + Self.Quotation_Sign__TrMF(), description_value_l ), false  );


      Refresh_ButtonClick( Sender );


      if not trigger_edit_l then
        triggers_sdbm.Query__Locate( Common.name__trigger__name__big_letters_c, trigger_name_l, [ Data.DB.loCaseInsensitive ] );

    end;

end;

procedure TTriggers_Modify_F_Frame.Modify__Edit_ButtonClick( Sender: TObject );
begin

  if   ( triggers_sdbm = nil )
    or ( not triggers_sdbm.Query__Active() )
    or ( triggers_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Modify__Add_ButtonClick( Sender );

end;

procedure TTriggers_Modify_F_Frame.Modify__Delete_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( triggers_sdbm = nil )
    or ( not triggers_sdbm.Query__Active() )
    or ( triggers_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__trmf_g ) + triggers_list__sql__trigger_drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__trmf_g ) + triggers_list__sql__trigger_drop__file_name_c + ').' );

      zts :=
        'drop trigger ' +
        Self.Quotation_Sign__TrMF() + triggers_sdbm.Query__Field_By_Name( Common.name__trigger__name__big_letters_c ).AsString + Self.Quotation_Sign__TrMF() +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__trigger__name__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TrMF() + triggers_sdbm.Query__Field_By_Name( Common.name__trigger__name__big_letters_c ).AsString + Self.Quotation_Sign__TrMF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_trigger + ' ''' + Self.Quotation_Sign__TrMF() + triggers_sdbm.Query__Field_By_Name( Common.name__trigger__name__big_letters_c ).AsString + Self.Quotation_Sign__TrMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  Screen.Cursor := crSQLWait;


  ztb := triggers_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_trigger );


  Screen.Cursor := crDefault;


  if ztb then
    begin

      Log_Memo.Lines.Add( triggers_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTriggers_Modify_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Buttons_Panel.Width := 1;

end;

procedure TTriggers_Modify_F_Frame.Trigger__Description__Set_MenuItemClick( Sender: TObject );
var
  modal_result : TModalResult;

  zts,
  description_value_l,
  trigger_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( triggers_sdbm = nil )
    or ( not triggers_sdbm.Query__Active() )
    or ( triggers_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Text__Edit_Memo.Text__Edit_Memo_Form := Text__Edit_Memo.TText__Edit_Memo_Form.Create( Application );
  Text__Edit_Memo.Text__Edit_Memo_Form.text_value := triggers_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
  Text__Edit_Memo.Text__Edit_Memo_Form.quotation_mark_duplicate := true;
  Text__Edit_Memo.Text__Edit_Memo_Form.Caption := Translation.translation__messages_r.word__description___trigger;
  Text__Edit_Memo.Text__Edit_Memo_Form.Text_Type_Set( Text__Edit_Memo.tt_Memo );
  modal_result := Text__Edit_Memo.Text__Edit_Memo_Form.ShowModal();

  if modal_result = mrOk then
    description_value_l := Text__Edit_Memo.Text__Edit_Memo_Form.text_value;

  FreeAndNil( Text__Edit_Memo.Text__Edit_Memo_Form );


  trigger_name_l := Self.Quotation_Sign__TrMF() + Trim(  triggers_sdbm.Query__Field_By_Name( Common.name__trigger__name__big_letters_c ).AsString  ) + Self.Quotation_Sign__TrMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.


  zts := Trigger__Description__Set__Sql_Prepare( trigger_name_l, description_value_l );


  Log_Memo.Lines.Add( zts );


  if modal_result <> mrOk then
    Exit;


  Trigger__Description__Set__Sql_Execute( zts );

end;

procedure TTriggers_Modify_F_Frame.Trigger__Description__Drop_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l,
  trigger_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( triggers_sdbm = nil )
    or ( not triggers_sdbm.Query__Active() )
    or ( triggers_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  trigger_name_l := Self.Quotation_Sign__TrMF() + Trim(  triggers_sdbm.Query__Field_By_Name( Common.name__trigger__name__big_letters_c ).AsString  ) + Self.Quotation_Sign__TrMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__trmf_g ) + triggers_list__sql__description__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__trmf_g ) + triggers_list__sql__description__drop__file_name_c + ').' );

      zts :=
        'comment on trigger ' +
        trigger_name_l +
        ' is null ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__trigger__name__big_letters_c + Common.sql__word_replace_separator_c, trigger_name_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_trigger_description + ' ''' + trigger_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := triggers_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_trigger_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( triggers_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTriggers_Modify_F_Frame.Trigger__Description__Write_In_Log_MenuItemClick( Sender: TObject );
begin

  if   ( triggers_sdbm = nil )
    or ( not triggers_sdbm.Query__Active() )
    or ( triggers_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Log_Memo.Lines.Add( '' );
  Log_Memo.Lines.Add(  triggers_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString  );

end;

procedure TTriggers_Modify_F_Frame.Trigger_Source_DBMemoClick( Sender: TObject );
begin

  Caret_Position_Display();

end;

procedure TTriggers_Modify_F_Frame.Trigger_Source_DBMemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

  Key_Up_Common( Sender, Key, Shift );

end;

procedure TTriggers_Modify_F_Frame.Trigger_Source_SynEditEnter( Sender: TObject );
begin

  Common.Text__Search_Replace__Syn_Edit__Set( Trigger_Source_SynEdit, text__search_replace_form );

end;

procedure TTriggers_Modify_F_Frame.Trigger_Source_SynEditClick( Sender: TObject );
begin

  Caret_Position_Display();

  Common.Syn_Edit__Highlight__Text( Trigger_Source_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( Trigger_Source_SynEdit, text__search_replace_form );

end;

procedure TTriggers_Modify_F_Frame.Trigger_Source_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Common.Syn_Edit_Key_Down( Trigger_Source_SynEdit, Sender, Key, Shift );

end;

procedure TTriggers_Modify_F_Frame.Trigger_Source_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

  Common.Syn_Edit__Highlight__Text( Trigger_Source_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( Trigger_Source_SynEdit, text__search_replace_form );

  Key_Up_Common( Sender, Key, Shift );

end;

procedure TTriggers_Modify_F_Frame.Trigger_Source_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );
begin

  Common.Syn_Edit__On_Replace_Text(  Trigger_Source_SynEdit, ASearch, AReplace, Line, Column, Action, ClientToScreen( Self.ClientRect )  );

end;

procedure TTriggers_Modify_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TTriggers_Modify_F_Frame.Triggers_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
begin

  if    (
          not (
                   ( gdFocused in State )
                or ( gdSelected in State )
              )
        )
    and ( Column.Field <> nil )
    and ( Column.Field.FullName = Common.name__trigger__active_c )
    and (  (Sender as TDBGrid).DataSource.DataSet.FieldByName( Common.name__trigger__active_c ).AsString = Common.db_grid__positive_value_c  ) then
    begin

      Triggers_DBGrid.Canvas.Brush.Color := clMoneyGreen;

      Triggers_DBGrid.DefaultDrawColumnCell( Rect, DataCol, Column, State );

    end;


  Common.DB_Grid_Draw_Column_Cell( sort__column_name_g, Triggers_DBGrid, Rect, DataCol, Column, State );

end;

procedure TTriggers_Modify_F_Frame.Triggers_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_DELETE then
    Modify__Delete_ButtonClick( Sender )
  else
  if Key = VK_INSERT then
    Modify__Add_ButtonClick( Sender )
  else
  if Key = VK_RETURN then
    Modify__Edit_ButtonClick( Modify__Edit_Button )
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( triggers_sdbm.Query__Active() )
    and ( triggers_sdbm.Query__Record_Count > 0 )
    and ( Triggers_DBGrid.SelectedField <> nil ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Triggers_DBGrid.SelectedField.Value;
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

procedure TTriggers_Modify_F_Frame.Triggers_DBGridTitleClick( Column: TColumn );
begin

  if Column.Field = nil then
    Exit;


  if sort__column_name_g = Column.Field.FieldName then
    sort__direction_ascending_g := not sort__direction_ascending_g
  else
    sort__column_name_g := Column.Field.FieldName;

  triggers_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );


  Trigger_Name_DBEditChange( nil ); // For FireDAC.

end;

end.
