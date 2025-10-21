unit View__Edit_Execute_F;{05.Wrz.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Migawka_Prostokat_Tabela_2_SDBM,
  Text__Search_Replace,
  Translation,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Menus, Vcl.ComCtrls, SynEdit,

  Interceptor__Syn_Edit;

type
  TView__Edit_Execute_F_Frame = class( TFrame )
    Buttons_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    View__Parameter__Name_DBEdit: TDBEdit;
    View__Output_DBEdit: TDBEdit;
    Owner_Etiquette_Label: TLabel;
    View__Parameters_DataSource: TDataSource;
    View__Parameters_DBGrid: TDBGrid;
    Log_Memo: TMemo;
    Record_Number__Records_Count_Label: TLabel;
    Search_Edit: TEdit;
    Search_GroupBox: TGroupBox;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Next_Button: TButton;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Prior_Button: TButton;
    Vertical_Splitter: TSplitter;
    Log_Horizontal_Splitter: TSplitter;
    View_PopupMenu: TPopupMenu;
    View__Edit_MenuItem: TMenuItem;
    N1: TMenuItem;
    View__Parameter__Description__Set_MenuItem: TMenuItem;
    View__Parameter__Description__Drop_MenuItem: TMenuItem;
    N2: TMenuItem;
    View__Description__Set_MenuItem: TMenuItem;
    View__Description__Drop_MenuItem: TMenuItem;
    Modify_GroupBox: TGroupBox;
    Modify__Edit_Button: TButton;
    Refresh_Button: TButton;
    View_Panel: TPanel;
    View_PageControl_Horizontal_Splitter: TSplitter;
    View__Parameters_Panel: TPanel;
    Open_Button: TButton;
    Close_Button: TButton;
    View__Output_DataSource: TDataSource;
    PageControl1: TPageControl;
    View__Output_TabSheet: TTabSheet;
    View__Source_TabSheet: TTabSheet;
    View__Description_TabSheet: TTabSheet;
    View__Description_Memo: TMemo;
    View__Output_DBGrid: TDBGrid;
    Owner_Label: TLabel;
    View__Source_Memo: TMemo;
    View__Parameters__Description_GroupBox: TGroupBox;
    View__Parameters_Left_Panel: TPanel;
    View__Parameters__Description_Memo_Horizontal_Splitter: TSplitter;
    View__Parameters__Description_DBMemo: TDBMemo;
    Data_Preview_DBMemo: TDBMemo;
    Data_Preview_Memo_Horizontal_Splitter: TSplitter;
    Caret_Position_Label: TLabel;
    Left_Panel: TPanel;
    Search_In_RadioGroup: TRadioGroup;
    Edit_In_Modal_View_CheckBox: TCheckBox;
    View__Source_SynEdit: TSynEdit;

    procedure Key_Down_Common( Sender : TObject; var Key : Word; Shift : TShiftState );
    procedure Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );

    procedure View__Parameter__Name_DBEditChange( Sender: TObject );
    procedure View__Output_DBEditChange( Sender: TObject );
    procedure Search_Change( Sender: TObject );
    procedure Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );

    procedure Open_ButtonClick( Sender: TObject );
    procedure Close_ButtonClick( Sender: TObject );
    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Modify__Edit_ButtonClick( Sender: TObject );

    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );
    procedure Owner_Etiquette_LabelDblClick( Sender: TObject );
    procedure Owner_LabelDblClick( Sender: TObject );

    procedure View__Description__Set_MenuItemClick( Sender: TObject );
    procedure View__Description__Drop_MenuItemClick( Sender: TObject );
    procedure View__Parameter__Description__Set_MenuItemClick( Sender: TObject );
    procedure View__Parameter__Description__Drop_MenuItemClick( Sender: TObject );

    procedure Data_Preview_DBMemoChange( Sender: TObject );
    procedure Data_Preview_DBMemoClick( Sender: TObject );
    procedure Data_Preview_DBMemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Memo_KeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure View__Source_MemoClick( Sender: TObject );
    procedure View__Source_MemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure View__Source_SynEditEnter( Sender: TObject );
    procedure View__Source_SynEditClick( Sender: TObject );
    procedure View__Source_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure View__Source_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure View__Source_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );

    procedure View__Description_MemoClick( Sender: TObject );
    procedure View__Description_MemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure View__Parameters__Description_DBMemoClick( Sender: TObject );
    procedure View__Parameters__Description_DBMemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure View__Parameters_DBGridCellClick( Column: TColumn );
    procedure View__Parameters_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
    procedure View__Parameters_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure View__Parameters_DBGridKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure View__Parameters_DBGridTitleClick( Column: TColumn );

    procedure View__Output_DBGridCellClick( Column: TColumn );
    procedure View__Output_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
    procedure View__Output_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure View__Output_DBGridKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure View__Output_DBGridTitleClick( Column: TColumn );
  private
    { Private declarations }
    sql__quotation_sign__use__veef_g : boolean;

    output_tab_sheet_switched_g, // Tab switch only once.
    queries_open_in_background_g,
    splitter_show_g,
    view__output__sort__direction_ascending_g,
    view__parameters__sort__direction_ascending_g,
    task_is_running_g,
    values_logged_g // Values log only once.
      : boolean;

    view__output_db_grid__selected_index_copy_g : integer;

    database_type__veef_g,
    sql__parameter_sign__veef_g,
    sql__quotation_sign__veef_g,
    view__output__sort__column_name_g,
    view__parameters__sort__column_name_g,
    view_name__veef_g
      : string;

    view__output_sdbm,
    view__columns_sdbm
      : Common.TSDBM;

    busy_notification__knight_rider_equalizer : Migawka_Prostokat_Tabela_2_SDBM.TMigawka_Prostokat_Tabela_2;

    text__search_replace_form : Text__Search_Replace.TText__Search_Replace_Form;

    procedure Busy_Notification_Set( const busy_f : boolean );
    procedure Caret_Position_Display();
    procedure Column__Values__Distinct();
    procedure Column__Values__Sum();
    procedure Data_Preview( const view__parameters_f : boolean = false );
    procedure Data_Refresh();
    function Parent_Caption__Get() : string;
    procedure Parent_Caption__Set( const text_f : string );
    procedure Parent_Tab_Switch( const prior_f : boolean = false );
    function Parent__Extended_Caption__Get() : string;
    procedure Parent__Extended_Caption__Set( const text_f : string );
    procedure Primary_Column_Find();
    procedure Query_Active_Notification_Set();
    function Quotation_Sign__VEEF() : string;
    procedure View__Description__Set__Sql_Execute( const sql_text_f : string; const show_message_f : boolean = true );
    function View__Description__Set__Sql_Prepare( const view_name_f, description_value_f : string ) : string;
  public
    { Public declarations }
    parent_supreme_tab_sheet : Vcl.Controls.TWinControl;

    procedure Data_Open__VEEF();
    function Finish__VEEF() : boolean;
    procedure Highlight__Font__Set__VEEF();
    procedure Options_Set__VEEF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
    procedure Prepare__VEEF( const databases_r_f : Common.TDatabases_r; const view_name_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
    function Task_Running_Check__VEEF( const message_show_f : boolean = true ) : boolean;
    procedure Translation__Apply__VEEF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
    procedure View__Edit_Execute_F__Data_Open__VEEF();
    procedure View__Edit_Execute_F__Edit__VEEF();
  end;

const
  view__columns__sql__metadata__file_name_c : string = 'View__Columns__Metadata_List__sql.txt';
  view__sql__description__drop__file_name_c : string = 'View__Description__Drop__sql.txt';
  view__sql__parameter__description__drop__file_name_c : string = 'View__Parameter__Description__Drop__sql.txt';
  view__sql__select__file_name_c : string = 'View__Select__sql.txt';

implementation

uses
  System.Threading,
  Vcl.Clipbrd,

  Shared,
  View__Modify,
  Text__Edit_Memo;

{$R *.dfm}

procedure TView__Edit_Execute_F_Frame.Busy_Notification_Set( const busy_f : boolean );
begin

  if    ( busy_f )
    and (  Pos( Common.notification__sign__busy_c, Parent_Caption__Get() ) <= 0  ) then
    Parent_Caption__Set( Parent_Caption__Get() + Common.notification__sign__busy_c )
  else
  if    ( not busy_f )
    and (  Pos( Common.notification__sign__busy_c, Parent_Caption__Get() ) > 0  ) then
    Parent_Caption__Set(  StringReplace( Parent_Caption__Get(), Common.notification__sign__busy_c, '', [ rfReplaceAll ] )  );


  if    ( busy_f )
    and (  Pos( Common.notification__sign__busy_c, Parent__Extended_Caption__Get() ) <= 0  ) then
    Parent__Extended_Caption__Set( Parent__Extended_Caption__Get() + Common.notification__sign__busy_c )
  else
  if    ( not busy_f )
    and (  Pos( Common.notification__sign__busy_c, Parent__Extended_Caption__Get() ) > 0  ) then
    Parent__Extended_Caption__Set(  StringReplace( Parent__Extended_Caption__Get(), Common.notification__sign__busy_c, '', [ rfReplaceAll ] )  );


  Common.Busy_Notification__Knight_Rider_Equalizer__Set( busy_f, busy_notification__knight_rider_equalizer );

end;

procedure TView__Edit_Execute_F_Frame.Data_Open__VEEF();
var
  i : integer;

  zts : string;
begin

  if   ( view__columns_sdbm = nil )
    or ( view__columns_sdbm.component_type__sdbm = Common.ct_none ) then
    Exit;


  Screen.Cursor := crHourGlass;

  if view__columns_sdbm.Query__Active() then
    view__columns_sdbm.Query__Close();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__veef_g ) + view__columns__sql__metadata__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__veef_g ) + view__columns__sql__metadata__file_name_c + ').' );

      zts :=
        'select RDB$RELATION_FIELDS.RDB$FIELD_NAME as COLUMN_NAME ' +
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
          'iif(  RDB$FIELDS.RDB$FIELD_TYPE in ( 7, 8, 16 ) and RDB$FIELDS.RDB$FIELD_SUB_TYPE = 2 and RDB$FIELDS.RDB$FIELD_SCALE is not null, '', ''||cast(  abs( RDB$FIELDS.RDB$FIELD_SCALE ) as smallint  ), ''''  )||'' )'', ''''   )|| ' +
        '       cast(   substring(  coalesce( '' ''||RDB$RELATION_FIELDS.RDB$DEFAULT_SOURCE, '' ''||RDB$FIELDS.RDB$DEFAULT_SOURCE, '''' ) from 1 for 255  ) as varchar( 255 )   )|| ' +
        '       iif(  RDB$RELATION_FIELDS.RDB$NULL_FLAG = 1, '' not null'', trim( '''' )  )|| ' +
        '       coalesce(  '' collate ''||trim( RDB$COLLATIONS.RDB$COLLATION_NAME ), ''''  ) ' +
        '       as FIELD_TYPE ' +
        ' ' +
        '     , cast(  substring( RDB$RELATION_FIELDS.RDB$DESCRIPTION from 1 for 2000 ) as varchar( 2000 )  ) as DESCRIPTION_VALUE__CAST ' +
        '     , RDB$RELATION_FIELDS.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
        '     , RDB$FIELDS.RDB$OWNER_NAME as OWNER_NAME ' +
        '     , RDB$RELATION_FIELDS.RDB$FIELD_POSITION as PARAMETER_NUMBER ' +
        '     , RDB$RELATION_FIELDS.RDB$FIELD_SOURCE as ID_FIELD_SOURCE_NAME ' +
        ' ' +
        '     , RDB$COLLATIONS.RDB$BASE_COLLATION_NAME as BASE_COLLATION_NAME ' +
        '     , RDB$CHARACTER_SETS.RDB$CHARACTER_SET_NAME as CHARACTER_SET_NAME ' +
        '     , RDB$COLLATIONS.RDB$COLLATION_NAME as COLLATION_NAME ' +
        '     , iif( RDB$FIELDS.RDB$CHARACTER_LENGTH is not null, RDB$FIELDS.RDB$CHARACTER_LENGTH, RDB$FIELDS.RDB$FIELD_PRECISION ) as FIELD_LENGTH ' +
        '     , iif(  RDB$FIELDS.RDB$FIELD_TYPE in ( 7, 8, 16 ) and RDB$FIELDS.RDB$FIELD_SUB_TYPE = 2, abs( RDB$FIELDS.RDB$FIELD_SCALE ), null  ) as FIELD_SCALE ' +
        '     , iif(  RDB$FIELDS.RDB$FIELD_TYPE = 261, abs( RDB$FIELDS.RDB$SEGMENT_LENGTH ), null  ) as SEGMENT_LENGTH ' +
        ' ' +
        'from RDB$RELATION_FIELDS ' +
        'left join RDB$RELATIONS on RDB$RELATION_FIELDS.RDB$RELATION_NAME = RDB$RELATIONS.RDB$RELATION_NAME ' +
        'left join RDB$FIELDS on RDB$FIELDS.RDB$FIELD_NAME = RDB$RELATION_FIELDS.RDB$FIELD_SOURCE ' +
        'left join RDB$CHARACTER_SETS on RDB$CHARACTER_SETS.RDB$CHARACTER_SET_ID = RDB$FIELDS.RDB$CHARACTER_SET_ID ' +
        'left join RDB$COLLATIONS on RDB$COLLATIONS.RDB$COLLATION_ID = RDB$FIELDS.RDB$COLLATION_ID and RDB$COLLATIONS.RDB$CHARACTER_SET_ID = RDB$FIELDS.RDB$CHARACTER_SET_ID ' +
        'where RDB$RELATION_FIELDS.RDB$RELATION_NAME = :view_name ' +
        'order by RDB$RELATION_FIELDS.RDB$RELATION_NAME, RDB$RELATION_FIELDS.RDB$FIELD_POSITION ';

    end;

  view__columns_sdbm.Query__Sql__Set( zts );


  Log_Memo.Lines.Add( zts );


  view__columns_sdbm.Query__Param_By_Name__Set( Common.name__view__small_letters_c, view_name__veef_g, Log_Memo );

  try
    view__columns_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_parameters_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;


  Screen.Cursor := crDefault;



  if view__columns_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( view__columns_sdbm.Operation_Duration_Get() );


      if    ( view__parameters__sort__column_name_g = '' )
        and ( view__columns_sdbm.Query__Active() )
        and ( view__columns_sdbm.Query__Field_Count > 0 ) then
        view__parameters__sort__column_name_g := view__columns_sdbm.Query__Fields( 0 ).FieldName;


      try
        view__columns_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString;
        View__Parameter__Name_DBEdit.DataField := Common.name__column__big_letters_c;
      except
        on E : Exception do
          begin

            view__columns_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_parameter_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;


      if view__columns_sdbm.Query__Active() then
        try
          view__columns_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
          View__Parameters__Description_DBMemo.DataField := Common.name__description_value_c;
        except
          on E : Exception do
            begin

              view__columns_sdbm.Query__Close();

              Log_Memo.Lines.Add( E.Message );

              Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_description_column_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            end;
        end;


      if view__columns_sdbm.Query__Active() then
        try
          view__columns_sdbm.Query__Field_By_Name( Common.name__parameter_number_c ).AsInteger;
        except
          on E : Exception do
            begin

              view__columns_sdbm.Query__Close();

              Log_Memo.Lines.Add( E.Message );

              Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_parameter_number + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

            end;
        end;


      for i := 0 to View__Parameters_DBGrid.Columns.Count - 1 do
        if View__Parameters_DBGrid.Columns.Items[ i ].FieldName = Common.name__column__big_letters_c then
          begin

            if View__Parameters_DBGrid.Columns.Items[ i ].Width < 400 then
              View__Parameters_DBGrid.Columns.Items[ i ].Width := 400;

          end
        else
        if View__Parameters_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value__cast_c then
          begin

            if View__Parameters_DBGrid.Columns.Items[ i ].Width > 500 then
              View__Parameters_DBGrid.Columns.Items[ i ].Width := 500;

          end
        else
          begin

            if View__Parameters_DBGrid.Columns.Items[ i ].Width > 200 then
              View__Parameters_DBGrid.Columns.Items[ i ].Width := 200;

          end;


      Self.Translation__Apply__VEEF( Translation.tak_Grid );


      Common.Data_Value_Format__Set( view__columns_sdbm, Log_Memo );

    end;


  Data_Refresh();

end;

procedure TView__Edit_Execute_F_Frame.Caret_Position_Display();
begin

  if    ( PageControl1.Height > 1 )
    and ( PageControl1.ActivePage = View__Description_TabSheet )
    and ( View__Description_Memo.Focused ) then
    begin

      Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Description_Memo.CaretPos.Y + 1 )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Description_Memo.CaretPos.X + 1 )  ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Description_Memo.Lines.Text.Length )  );

      if not Caret_Position_Label.Visible then
        Caret_Position_Label.Visible := true;

    end
  else
  if    ( View__Parameters__Description_GroupBox.Height > 1 )
    and ( View__Parameters__Description_DBMemo.Focused ) then
    begin

      Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Parameters__Description_DBMemo.CaretPos.Y + 1 )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Parameters__Description_DBMemo.CaretPos.X + 1 )  ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Parameters__Description_DBMemo.Lines.Text.Length )  );

      if not Caret_Position_Label.Visible then
        Caret_Position_Label.Visible := true;

    end
  else
  if    ( PageControl1.Height > 1 )
    and ( Data_Preview_DBMemo.Height > 1 )
    and ( PageControl1.ActivePage = View__Output_TabSheet )
    and (
             ( Data_Preview_DBMemo.Focused )
          or ( View__Output_DBGrid.Focused )
          or ( View__Parameters_DBGrid.Focused )
        ) then
    begin

      Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Data_Preview_DBMemo.CaretPos.Y + 1 )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Data_Preview_DBMemo.CaretPos.X + 1 )  ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Data_Preview_DBMemo.Lines.Text.Length )  );

      if not Caret_Position_Label.Visible then
        Caret_Position_Label.Visible := true;

    end
  else
  if    ( PageControl1.Height > 1 )
    and ( PageControl1.ActivePage = View__Source_TabSheet )
    //and ( View__Source_Memo.Focused ) then
    and ( View__Source_SynEdit.Focused ) then
    begin

      //Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Source_Memo.CaretPos.Y + 1 )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Source_Memo.CaretPos.X + 1 )  ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Source_Memo.Lines.Text.Length )  );
      Caret_Position_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Source_SynEdit.CaretY )  ) + ' / ' + Trim(   FormatFloat( '### ### ### ### ### ### ##0', View__Source_SynEdit.CaretX ) + ' : ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', View__Source_SynEdit.Lines.Text.Length )  )   );

      if not Caret_Position_Label.Visible then
        Caret_Position_Label.Visible := true;

    end
  else
  if Caret_Position_Label.Visible then
    Caret_Position_Label.Visible := false;

end;

procedure TView__Edit_Execute_F_Frame.Column__Values__Distinct();
var
  items_count_l : integer;

  zts : string;
begin

  if Self.Task_Running_Check__VEEF() then
    Exit;


  if   ( view__output_sdbm = nil )
    or ( not view__output_sdbm.Query__Active() )
    or ( view__output_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  if not queries_open_in_background_g then
    begin

      Screen.Cursor := crSQLWait;

      Busy_Notification_Set( true );

      Application.ProcessMessages();


      zts := Common.Column__Values__Distinct__Processing( view__output_sdbm, View__Output_DBGrid, items_count_l );


      View__Output_DBGrid.SetFocus();


      Log_Memo.Lines.Add(   Translation.translation__messages_r.items_count + ' ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', items_count_l )  ) + ':'   );
      Log_Memo.Lines.AddStrings( zts );


      Busy_Notification_Set( false );

      Screen.Cursor := crDefault;


      ShowMessage(  Translation.translation__messages_r.items_count + ' ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', items_count_l )  ) + ':' + #13 + zts   );

    end
  else
    begin

      task_is_running_g := true;


      Busy_Notification_Set( true );


      System.Threading.TTask.Run
        (
          procedure
            begin

              zts := Common.Column__Values__Distinct__Processing( view__output_sdbm, View__Output_DBGrid, items_count_l );


              TThread.Synchronize
                (
                  TThread.Current,
                  procedure
                    begin

                      View__Output_DBGrid.SetFocus();


                      Log_Memo.Lines.Add(   Translation.translation__messages_r.items_count + ' ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', items_count_l )  ) + ':'   );
                      Log_Memo.Lines.AddStrings( zts );


                      task_is_running_g := false;

                      Busy_Notification_Set( false );


                      ShowMessage(  Translation.translation__messages_r.items_count + ' ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', items_count_l )  ) + ':' + #13 + zts   );

                    end
                );

            end
        );

    end;

end;

procedure TView__Edit_Execute_F_Frame.Column__Values__Sum();
var
  ztc : currency;

  error_message_l : string;
begin

  if Self.Task_Running_Check__VEEF() then
    Exit;


  if   ( view__output_sdbm = nil )
    or ( not view__output_sdbm.Query__Active() )
    or ( view__output_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  //try
  //  view__output_sdbm.Query__Field_By_Name( Sql_Editor_DBGrid.SelectedField.FieldName ).AsCurrency;
  //except
  //  on E : Exception do
  //    begin
  //
  //      Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_read_column_value_as_a_number + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
  //      Exit;
  //
  //    end;
  //end;


  if not queries_open_in_background_g then
    begin

      Screen.Cursor := crSQLWait;

      Busy_Notification_Set( true );

      Application.ProcessMessages();


      ztc := Common.Column__Values__Sum__Processing( view__output_sdbm, View__Output_DBGrid, error_message_l );

      View__Output_DBGrid.SetFocus();


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

              ztc := Common.Column__Values__Sum__Processing( view__output_sdbm, View__Output_DBGrid, error_message_l );


              TThread.Synchronize
                (
                  TThread.Current,
                  procedure
                    begin

                      View__Output_DBGrid.SetFocus();


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

procedure TView__Edit_Execute_F_Frame.Data_Preview( const view__parameters_f : boolean = false );
begin

  if   ( PageControl1.Height <= 1 )
    or ( Data_Preview_DBMemo.Height <= 1 )
    or ( PageControl1.ActivePage <> View__Output_TabSheet ) then
    begin

      Caret_Position_Display();

      Exit;

    end;


  if not view__parameters_f then
    begin

      if    ( view__output_sdbm <> nil )
        and ( view__output_sdbm.Query__Active() )
        and ( view__output_sdbm.Query__Record_Count > 0 )
        and ( View__Output_DBGrid.SelectedField <> nil ) then
        try
          Data_Preview_DBMemo.DataField := '';
          Data_Preview_DBMemo.DataSource := View__Output_DataSource;
          Data_Preview_DBMemo.DataField := View__Output_DBGrid.SelectedField.FieldName;
        except
          on E : Exception do
            Log_Memo.Lines.Text := Translation.translation__messages_r.failed_to_preview_value + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext );
        end;

    end
  else
    begin

      if    ( view__columns_sdbm <> nil )
        and ( view__columns_sdbm.Query__Active() )
        and ( view__columns_sdbm.Query__Record_Count > 0 )
        and ( View__Parameters_DBGrid.SelectedField <> nil ) then
        try
          Data_Preview_DBMemo.DataField := '';
          Data_Preview_DBMemo.DataSource := View__Parameters_DataSource;
          Data_Preview_DBMemo.DataField := View__Parameters_DBGrid.SelectedField.FieldName;
        except
          on E : Exception do
            Log_Memo.Lines.Text := Translation.translation__messages_r.failed_to_preview_value + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext );
        end;

    end;

end;

procedure TView__Edit_Execute_F_Frame.Data_Refresh();
var
  zts : string;

  zt_sdbm : Common.TSDBM;
begin

  zt_sdbm := Common.TSDBM.Create( view__columns_sdbm );
  zt_sdbm.Component_Type_Set( view__columns_sdbm.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__veef_g ) + Common.view__sql__metadata__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__veef_g ) + Common.view__sql__metadata__file_name_c + ').' );

      zts := Common.view__sql__metadata_c;

    end;

  zt_sdbm.Query__Sql__Set( zts );


  if not values_logged_g then
    begin

      values_logged_g := true;
      Log_Memo.Lines.Add( zts );

    end;


  zt_sdbm.Query__Param_By_Name__Set( Common.name__view__small_letters_c, view_name__veef_g, Log_Memo );

  try
    zt_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_view_metadata + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;


  if zt_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( zt_sdbm.Operation_Duration_Get() );


      try
        View__Description_Memo.Lines.Text := zt_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
      except
        on E : Exception do
          begin

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_view_description_column_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;


      try
        Owner_Label.Caption := Trim( zt_sdbm.Query__Field_By_Name( Common.name__owner_name_c ).AsString ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.
      except
        on E : Exception do
          begin

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_view_owner_column_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;


      try
        //View__Source_Memo.Lines.Text := zt_sdbm.Query__Field_By_Name( Common.name__view__source_c ).AsString;
        View__Source_SynEdit.Lines.Text := zt_sdbm.Query__Field_By_Name( Common.name__view__source_c ).AsString;
      except
        on E : Exception do
          begin

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_view_source_column_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;

    end;


  if zt_sdbm.Query__Active() then
    zt_sdbm.Query__Close();

  FreeAndNil( zt_sdbm );

end;

function TView__Edit_Execute_F_Frame.Finish__VEEF() : boolean;
begin

  if Self.Task_Running_Check__VEEF() then
    begin

      Result := false;

      Exit;

    end
  else
    Result := true;


  Common.Text__Search_Replace__Syn_Edit__Set( nil, text__search_replace_form );
  Common.Text__Search_Replace__Hide( text__search_replace_form );


  FreeAndNil( view__output_sdbm );
  FreeAndNil( view__columns_sdbm );

  if text__search_replace_form <> nil then
    FreeAndNil( text__search_replace_form );


  FreeAndNil( busy_notification__knight_rider_equalizer );

end;

procedure TView__Edit_Execute_F_Frame.Highlight__Font__Set__VEEF();
begin

  Common.Font__Set( Data_Preview_DBMemo.Font, Common.sql_editor__font );
  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( View__Description_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( View__Parameters__Description_DBMemo.Font, Common.sql_editor__font );
  //Common.Font__Set( View__Source_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( View__Source_SynEdit.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    begin

      Common.Font__Set( View__Output_DBGrid.Font, Common.sql_editor__font );
      Common.Font__Set( View__Parameters_DBGrid.Font, Common.sql_editor__font );

    end;

  Common.Syn_Edit__Parameters__Set( View__Source_SynEdit );


  Common.Syn_Edit__Search_Text_Hightlighter_Syn_Edit_Plugin__Create( View__Source_SynEdit );

end;

procedure TView__Edit_Execute_F_Frame.Key_Down_Common( Sender : TObject; var Key : Word; Shift : TShiftState );
begin

  // E.
  if    ( Key = 69 )
    and ( Shift = [ ssCtrl ] ) then
    Open_ButtonClick( Sender )
  else
  // R.
  if    ( Key = 82 )
    and ( Shift = [ ssCtrl ] ) then
    Refresh_ButtonClick( Refresh_Button );

end;

procedure TView__Edit_Execute_F_Frame.Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );
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

procedure TView__Edit_Execute_F_Frame.Options_Set__VEEF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
begin

  queries_open_in_background_g := queries_open_in_background_f;
  splitter_show_g := splitter_show_f;
  sql__quotation_sign__use__veef_g := sql__quotation_sign__use_f;
  sql__quotation_sign__veef_g := sql__quotation_sign_f;


  if view__output_sdbm <> nil then
    begin

      view__output_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

      view__output_sdbm.Data_Source__Data_Set__Set( View__Output_DataSource );

    end;


  if view__columns_sdbm <> nil then
    begin

      view__columns_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

      view__columns_sdbm.Data_Source__Data_Set__Set( View__Parameters_DataSource );

    end;


  Self.Translation__Apply__VEEF( Translation.tak_Self );


  Query_Active_Notification_Set();

end;

function TView__Edit_Execute_F_Frame.Parent_Caption__Get() : string;
begin

  if    ( Self.Parent <> nil )
    and ( Self.Parent is TTabSheet ) then
    Result := TTabSheet(Self.Parent).Caption
  else
    Result := '';

end;

procedure TView__Edit_Execute_F_Frame.Parent_Caption__Set( const text_f : string );
begin

  if    ( Self.Parent <> nil )
    and ( Self.Parent is TTabSheet ) then
    TTabSheet(Self.Parent).Caption := text_f;

end;

procedure TView__Edit_Execute_F_Frame.Parent_Tab_Switch( const prior_f : boolean = false );
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

function TView__Edit_Execute_F_Frame.Parent__Extended_Caption__Get() : string;
begin

  if    ( Self.Parent <> nil )
    and ( Self.Parent.Parent <> nil )
    and ( Self.Parent.Parent.Parent <> nil )
    and ( Self.Parent.Parent.Parent.Parent <> nil )
    and ( Self.Parent.Parent.Parent.Parent is TTabSheet ) then
    Result := TTabSheet(Self.Parent.Parent.Parent.Parent).Caption
  else
    Result := '';

end;

procedure TView__Edit_Execute_F_Frame.Parent__Extended_Caption__Set( const text_f : string );
begin

  if    ( Self.Parent <> nil )
    and ( Self.Parent.Parent <> nil )
    and ( Self.Parent.Parent.Parent <> nil )
    and ( Self.Parent.Parent.Parent.Parent <> nil )
    and ( Self.Parent.Parent.Parent.Parent is TTabSheet ) then
    TTabSheet(Self.Parent.Parent.Parent.Parent).Caption := text_f;

end;

procedure TView__Edit_Execute_F_Frame.Prepare__VEEF( const databases_r_f : Common.TDatabases_r; const view_name_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
begin

  Self.Name := '';

  database_type__veef_g := databases_r_f.database_type;
  output_tab_sheet_switched_g := false;
  queries_open_in_background_g := queries_open_in_background_f;
  sql__parameter_sign__veef_g := databases_r_f.sql__parameter_sign;
  splitter_show_g := splitter_show_f;
  text__search_replace_form := nil;
  view__output_db_grid__selected_index_copy_g := 0;
  view__output__sort__column_name_g := '';
  view__output__sort__direction_ascending_g := true;
  view_name__veef_g := view_name_f;
  view__parameters__sort__column_name_g := '';
  view__parameters__sort__direction_ascending_g := true;
  task_is_running_g := false;
  values_logged_g := false;


  Data_Preview_DBMemo.Height := 1;
  PageControl1.ActivePage := View__Source_TabSheet;


  Log_Memo.Lines.Add( view_name__veef_g );

  busy_notification__knight_rider_equalizer := Migawka_Prostokat_Tabela_2_SDBM.TMigawka_Prostokat_Tabela_2.Create( Self );

  view__output_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );
  view__columns_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Self.Options_Set__VEEF( component_type_f, databases_r_f.sql__quotation_sign, queries_open_in_background_g, splitter_show_g, sql__quotation_sign__use_f );


  Highlight__Font__Set__VEEF();

end;

procedure TView__Edit_Execute_F_Frame.Primary_Column_Find();
begin

  if    ( view__output_sdbm.Query__Active() )
    and ( view__output_sdbm.Query__Field_Count > 0 ) then
    begin

      View__Output_DBEdit.DataField := view__output_sdbm.Query__Fields( 0 ).FieldName;


      if view__output__sort__column_name_g = '' then
        view__output__sort__column_name_g := View__Output_DBEdit.DataField;

    end;

end;

procedure TView__Edit_Execute_F_Frame.Query_Active_Notification_Set();
begin

  if view__output_sdbm = nil then
    Exit;


  if view__output_sdbm.Query__Active() then
    begin

      Close_Button.Enabled := true;

    end
  else
    begin

      Close_Button.Enabled := false;


      View__Output_DBEdit.DataField := '';
      view__output__sort__column_name_g := '';
      view__output__sort__direction_ascending_g := true;

    end;


  Caret_Position_Display();

end;

function TView__Edit_Execute_F_Frame.Quotation_Sign__VEEF() : string;
begin

  if sql__quotation_sign__use__veef_g then
    begin

      Result := sql__quotation_sign__veef_g;

    end
  else
    Result := '';

end;

function TView__Edit_Execute_F_Frame.Task_Running_Check__VEEF( const message_show_f : boolean = true ) : boolean;
begin

  Result := task_is_running_g;


  if    ( Result )
    and ( message_show_f ) then
    Application.MessageBox( PChar(Translation.translation__messages_r.task_is_still_running_wait_until_finish), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );

end;

procedure TView__Edit_Execute_F_Frame.Translation__Apply__VEEF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
var
  i : integer;
begin

  if tak_f in [ Translation.tak_All, Translation.tak_Self ] then
    Translation.Translation__Apply( Self );


  if tak_f in [ Translation.tak_All, Translation.tak_Grid ] then
    for i := 0 to View__Parameters_DBGrid.Columns.Count - 1 do
      if View__Parameters_DBGrid.Columns.Items[ i ].FieldName = Common.name__column__big_letters_c then
        View__Parameters_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__parameter__name
      else
      if View__Parameters_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value__cast_c then
        View__Parameters_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__description
      else
        View__Parameters_DBGrid.Columns.Items[ i ].Title.Caption := Common.Column__Name_To_Grid_Caption( View__Parameters_DBGrid.Columns.Items[ i ].FieldName );

end;

procedure TView__Edit_Execute_F_Frame.View__Description__Set__Sql_Execute( const sql_text_f : string; const show_message_f : boolean = true );
var
  ztb : boolean;

  error_message_l : string;
begin

  ztb := view__output_sdbm.Sql_Command_Execute( sql_text_f, error_message_l, Translation.translation__messages_r.failed_to_set_the_view_description );


  if ztb then
    begin

      if show_message_f then
        begin

          Log_Memo.Lines.Add( view__output_sdbm.Operation_Duration_Get() );


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

function TView__Edit_Execute_F_Frame.View__Description__Set__Sql_Prepare( const view_name_f, description_value_f : string ) : string;
begin

  Result := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__veef_g ) + Common.view__sql__description__set__file_name_c  );

  if Trim( Result ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__veef_g ) + Common.view__sql__description__set__file_name_c + ').' );

      Result := Common.view__sql__description__set_c;

    end;

  Result := StringReplace( Result, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_f, [ rfReplaceAll ] );
  Result := StringReplace( Result, Common.sql__word_replace_separator_c + Common.name__view__big_letters_c + Common.sql__word_replace_separator_c, view_name_f, [ rfReplaceAll ] );

end;

procedure TView__Edit_Execute_F_Frame.View__Edit_Execute_F__Data_Open__VEEF();
begin

  Open_ButtonClick( nil );

end;

procedure TView__Edit_Execute_F_Frame.View__Edit_Execute_F__Edit__VEEF();
begin

  Modify__Edit_ButtonClick( nil );

end;

procedure TView__Edit_Execute_F_Frame.View__Parameter__Name_DBEditChange( Sender: TObject );
begin

  if    ( view__columns_sdbm <> nil )
    and ( view__columns_sdbm.Query__Active() ) then
    Record_Number__Records_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', view__columns_sdbm.Query__Record_Number() )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', view__columns_sdbm.Query__Record_Count() )  )
  else
    Record_Number__Records_Count_Label.Caption := '0 / 0';

end;

procedure TView__Edit_Execute_F_Frame.View__Output_DBEditChange( Sender: TObject );
begin

  if Self.Task_Running_Check__VEEF( false ) then
    Exit;


  if    ( view__output_sdbm <> nil )
    and ( view__output_sdbm.Query__Active() ) then
    Record_Number__Records_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', view__output_sdbm.Query__Record_Number() )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', view__output_sdbm.Query__Record_Count() )  )
  else
    Record_Number__Records_Count_Label.Caption := '0 / 0';

end;

procedure TView__Edit_Execute_F_Frame.Search_Change( Sender: TObject );
var
  locate_options : Data.DB.TLocateOptions;
begin

  locate_options := [];

  if Search__Case_Insensitive_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loCaseInsensitive ];

  if Search__Partial_Key_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loPartialKey ];


  if Search_In_RadioGroup.ItemIndex = 0 then // Output
    begin

      if Self.Task_Running_Check__VEEF() then
        Exit;


      if   ( view__output_sdbm = nil )
        or ( not view__output_sdbm.Query__Active() ) then
        Exit;


      if view__output_sdbm.Query__Locate( view__output__sort__column_name_g, Search_Edit.Text, locate_options ) then
        Search_Edit.Color := clWindow
      else
        begin

          Search_Edit.Color := Common.color__red__light_c;


          view__output_sdbm.Query__Disable_Controls();

          view__output_sdbm.Query__First();

          while not view__output_sdbm.Query__Eof do
            begin

              if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  view__output_sdbm.Query__Field_By_Name( view__output__sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
                begin

                  Search_Edit.Color := clWindow;

                  Break;

                end;

              view__output_sdbm.Query__Next();

            end;

          view__output_sdbm.Query__Enable_Controls();

        end;

    end
  else
    begin

      if   ( view__columns_sdbm = nil )
        or ( not view__columns_sdbm.Query__Active() ) then
        Exit;


      if view__columns_sdbm.Query__Locate( view__parameters__sort__column_name_g, Search_Edit.Text, locate_options ) then
        Search_Edit.Color := clWindow
      else
        begin

          Search_Edit.Color := Common.color__red__light_c;


          view__columns_sdbm.Query__Disable_Controls();

          view__columns_sdbm.Query__First();

          while not view__columns_sdbm.Query__Eof do
            begin

              if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  view__columns_sdbm.Query__Field_By_Name( view__parameters__sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
                begin

                  Search_Edit.Color := clWindow;

                  Break;

                end;

              view__columns_sdbm.Query__Next();

            end;

          view__columns_sdbm.Query__Enable_Controls();

        end;

    end;

end;

procedure TView__Edit_Execute_F_Frame.Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_PRIOR then
    Search__Prior_ButtonClick( Sender )
  else
  if Key = VK_NEXT then
    Search__Next_ButtonClick( Sender );

end;

procedure TView__Edit_Execute_F_Frame.Search__Next_ButtonClick( Sender: TObject );
begin

  if Search_In_RadioGroup.ItemIndex = 0 then // Output
    begin

      if Self.Task_Running_Check__VEEF() then
        Exit;


      if   ( view__output_sdbm = nil )
        or ( not view__output_sdbm.Query__Active() ) then
        Exit;


      view__output_sdbm.Query__Disable_Controls();


      Search_Edit.Color := Common.color__red__light_c;


      while not view__output_sdbm.Query__Eof do
        begin

          view__output_sdbm.Query__Next();


          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  view__output_sdbm.Query__Field_By_Name( view__output__sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

        end;


      view__output_sdbm.Query__Enable_Controls();

    end
  else
    begin

      if   ( view__columns_sdbm = nil )
        or ( not view__columns_sdbm.Query__Active() ) then
        Exit;


      view__columns_sdbm.Query__Disable_Controls();


      Search_Edit.Color := Common.color__red__light_c;


      while not view__columns_sdbm.Query__Eof do
        begin

          view__columns_sdbm.Query__Next();


          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  view__columns_sdbm.Query__Field_By_Name( view__parameters__sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

        end;


      view__columns_sdbm.Query__Enable_Controls();

    end;

end;

procedure TView__Edit_Execute_F_Frame.Search__Prior_ButtonClick( Sender: TObject );
begin

  if Search_In_RadioGroup.ItemIndex = 0 then // Output
    begin

      if Self.Task_Running_Check__VEEF() then
        Exit;


      if   ( view__output_sdbm = nil )
        or ( not view__output_sdbm.Query__Active() ) then
        Exit;


      view__output_sdbm.Query__Disable_Controls();


      Search_Edit.Color := Common.color__red__light_c;


      while not view__output_sdbm.Query__Bof do
        begin

          view__output_sdbm.Query__Prior();


          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  view__output_sdbm.Query__Field_By_Name( view__output__sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

        end;


      view__output_sdbm.Query__Enable_Controls();

    end
  else
    begin

      if   ( view__columns_sdbm = nil )
        or ( not view__columns_sdbm.Query__Active() ) then
        Exit;


      view__columns_sdbm.Query__Disable_Controls();


      Search_Edit.Color := Common.color__red__light_c;


      while not view__columns_sdbm.Query__Bof do
        begin

          view__columns_sdbm.Query__Prior();


          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  view__columns_sdbm.Query__Field_By_Name( view__parameters__sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

        end;


      view__columns_sdbm.Query__Enable_Controls();

    end;

end;

procedure TView__Edit_Execute_F_Frame.Open_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts : string;
begin

  if view__output_sdbm = nil then
    Exit;


  if Self.Task_Running_Check__VEEF() then
    Exit;


  if   ( view__columns_sdbm = nil )
    or ( not view__columns_sdbm.Query__Active() ) then
    begin

      Self.Data_Open__VEEF();

      Exit;

    end;


  Data_Preview_DBMemo.DataField := '';


  if view__output_sdbm.Query__Active() then
    Close_ButtonClick( Sender );


  if not view__output_sdbm.Query__Active() then
    begin

      if not output_tab_sheet_switched_g then
        begin

          PageControl1.ActivePage := View__Output_TabSheet;

          output_tab_sheet_switched_g := true;

        end;


      zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__veef_g ) + view__sql__select__file_name_c  );

      if Trim( zts ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__veef_g ) + view__sql__select__file_name_c + ').' );

          zts := 'select * from ' + Self.Quotation_Sign__VEEF() + view_name__veef_g + Self.Quotation_Sign__VEEF();

        end
      else
        begin

          zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__view__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__VEEF() + view_name__veef_g + Self.Quotation_Sign__VEEF(), [ rfReplaceAll ] );

        end;


      Log_Memo.Lines.Add( zts );


      view__output_sdbm.Query__Sql__Set( zts );


      ztb := false;

      if not queries_open_in_background_g then
        begin

          Screen.Cursor := crSQLWait;

          Busy_Notification_Set( true );

          Application.ProcessMessages();


          try
            view__output_sdbm.Query__Open();
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                ztb := true;

                Log_Memo.Lines.Add(  StringReplace( E.Message, #10, #13 + #10, [ rfReplaceAll ] )  );

                Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_open_query + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );

              end;
          end;


          if not ztb then
            Log_Memo.Lines.Add( view__output_sdbm.Operation_Duration_Get() );


          Query_Active_Notification_Set();


          Primary_Column_Find();


          Common.Data_Value_Format__Set( view__output_sdbm, Log_Memo );

          Busy_Notification_Set( false );

          View__Output_DBGrid.SelectedIndex := view__output_db_grid__selected_index_copy_g;

          Screen.Cursor := crDefault;

        end
      else
        begin

          task_is_running_g := true;

          View__Output_DBGrid.DataSource := nil; // Sometimes there is an error 'Canvas does not allow drawing' in the line view__output_sdbm.Query__Open().


          Busy_Notification_Set( true );


          System.Threading.TTask.Run
            (
              procedure
                begin

                  try
                    view__output_sdbm.Query__Open();
                  except
                    on E : Exception do
                      TThread.Synchronize
                        (
                          TThread.Current,
                          procedure
                            begin

                              ztb := true;

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


                          if not ztb then
                            Log_Memo.Lines.Add( view__output_sdbm.Operation_Duration_Get() );


                          View__Output_DBGrid.DataSource := View__Output_DataSource;


                          Query_Active_Notification_Set();


                          Primary_Column_Find();


                          Common.Data_Value_Format__Set( view__output_sdbm, Log_Memo );

                          View__Output_DBGrid.Repaint();

                          Busy_Notification_Set( false );

                          View__Output_DBGrid.SelectedIndex := view__output_db_grid__selected_index_copy_g;

                        end
                    );

                end
            );

        end;

    end;

end;

procedure TView__Edit_Execute_F_Frame.Close_ButtonClick( Sender: TObject );
begin

  if view__output_sdbm = nil then
    Exit;


  if Self.Task_Running_Check__VEEF() then
    Exit;


  if view__output_sdbm.Query__Active() then
    begin

      Data_Preview_DBMemo.DataField := '';


      view__output_db_grid__selected_index_copy_g := View__Output_DBGrid.SelectedIndex;


      view__output_sdbm.Query__Close();

      Query_Active_Notification_Set();

    end;

end;

procedure TView__Edit_Execute_F_Frame.Refresh_ButtonClick( Sender: TObject );
var
  display_format__copy_l,
  primary_key_name_l,
  primary_key_value_l
    : string;
begin

  if Self.Task_Running_Check__VEEF() then
    Exit;


  if    ( view__columns_sdbm <> nil )
    and ( view__columns_sdbm.Query__Active() ) then
    begin

      if view__columns_sdbm.Query__Field_Count() >  0 then
        begin

          primary_key_name_l := view__columns_sdbm.Query__Fields( 0 ).FieldName;
          primary_key_value_l := view__columns_sdbm.Query__Fields( 0 ).AsString;

        end
      else
        primary_key_name_l := '';


      view__columns_sdbm.Query__Requery();


      Log_Memo.Lines.Add( view__columns_sdbm.Operation_Duration_Get() );


      if Trim( primary_key_name_l ) <> '' then
        view__columns_sdbm.Query__Locate( primary_key_name_l, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );

    end
  else
    begin

      Self.Data_Open__VEEF();

      Exit;

    end;


  Data_Refresh();


  if   ( view__output_sdbm = nil )
    or ( not view__output_sdbm.Query__Active() ) then
    Exit;


  if Trim( View__Output_DBEdit.DataField ) <> '' then
    begin

      primary_key_name_l := View__Output_DBEdit.DataField;


      if    ( View__Output_DBEdit.DataSource.DataSet <> nil )
        and ( View__Output_DBEdit.DataSource.DataSet.FieldByName( View__Output_DBEdit.DataField ) is TNumericField ) then
        begin

          display_format__copy_l := TFloatField(View__Output_DBEdit.DataSource.DataSet.FieldByName( View__Output_DBEdit.DataField )).DisplayFormat;
          TFloatField(View__Output_DBEdit.DataSource.DataSet.FieldByName( View__Output_DBEdit.DataField )).DisplayFormat := '';

        end;


      primary_key_value_l := View__Output_DBEdit.Text;


      if    ( View__Output_DBEdit.DataSource.DataSet <> nil )
        and ( View__Output_DBEdit.DataSource.DataSet.FieldByName( View__Output_DBEdit.DataField ) is TNumericField ) then
        TFloatField(View__Output_DBEdit.DataSource.DataSet.FieldByName( View__Output_DBEdit.DataField )).DisplayFormat := display_format__copy_l;

    end
  else
  if view__output_sdbm.Query__Field_Count() >  0 then
    begin

      primary_key_name_l := view__output_sdbm.Query__Fields( 0 ).FieldName;
      primary_key_value_l := view__output_sdbm.Query__Fields( 0 ).AsString;

    end
  else
    primary_key_name_l := '';


  if not queries_open_in_background_g then
    begin

      Screen.Cursor := crSQLWait;

      Busy_Notification_Set( true );

      Application.ProcessMessages();


      view__output_sdbm.Query__Requery();


      Log_Memo.Lines.Add( view__output_sdbm.Operation_Duration_Get() );


      if Trim( primary_key_name_l ) <> '' then
        view__output_sdbm.Query__Locate( primary_key_name_l, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );


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

              view__output_sdbm.Query__Requery();


              TThread.Synchronize
                (
                  TThread.Current,
                  procedure
                    begin

                      task_is_running_g := false;


                      Log_Memo.Lines.Add( view__output_sdbm.Operation_Duration_Get() );


                      if Trim( primary_key_name_l ) <> '' then
                        view__output_sdbm.Query__Locate( primary_key_name_l, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );


                      Busy_Notification_Set( false );

                    end
                );

            end
        );

    end;

end;

procedure TView__Edit_Execute_F_Frame.Modify__Edit_ButtonClick( Sender: TObject );
var
  modified_l : boolean;

  view__modify_form_l : View__Modify.TView__Modify_Form;
begin

  if Self.Task_Running_Check__VEEF() then
    Exit;


  if view__columns_sdbm = nil then
    Exit;


  view__modify_form_l := View__Modify.TView__Modify_Form.Create( Application, view__columns_sdbm );
  view__modify_form_l.database_type__vm := database_type__veef_g;
  view__modify_form_l.splitter_show__vm := splitter_show_g;
  view__modify_form_l.sql__quotation_sign__vm := sql__quotation_sign__veef_g;
  view__modify_form_l.sql__quotation_sign__use__vm := sql__quotation_sign__use__veef_g;
  view__modify_form_l.view__description_value__vm := View__Description_Memo.Lines.Text;
  view__modify_form_l.view__name__vm := view_name__veef_g;
  view__modify_form_l.view__edit__vm := true;

  if not Edit_In_Modal_View_CheckBox.Checked then
    begin

      view__modify_form_l.show_modal__vm := false;
      view__modify_form_l.Show();

      Exit;

    end;

  view__modify_form_l.ShowModal();
  modified_l := view__modify_form_l.modified__vm;
  FreeAndNil( view__modify_form_l );


  if modified_l then
    begin

      Refresh_ButtonClick( Sender );

    end;

end;

procedure TView__Edit_Execute_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Left_Panel.Width := 1;

end;

procedure TView__Edit_Execute_F_Frame.Owner_Etiquette_LabelDblClick( Sender: TObject );
begin

  Vcl.Clipbrd.Clipboard.AsText := view_name__veef_g;

end;

procedure TView__Edit_Execute_F_Frame.Owner_LabelDblClick( Sender: TObject );
begin

  Vcl.Clipbrd.Clipboard.AsText := Owner_Label.Caption;

end;

procedure TView__Edit_Execute_F_Frame.View__Description__Set_MenuItemClick( Sender: TObject );
var
  modal_result : TModalResult;

  zts,
  description_value_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if view__columns_sdbm = nil then
    Exit;


  Text__Edit_Memo.Text__Edit_Memo_Form := Text__Edit_Memo.TText__Edit_Memo_Form.Create( Application );
  Text__Edit_Memo.Text__Edit_Memo_Form.text_value := View__Description_Memo.Lines.Text;
  Text__Edit_Memo.Text__Edit_Memo_Form.quotation_mark_duplicate := true;
  Text__Edit_Memo.Text__Edit_Memo_Form.Caption := Translation.translation__messages_r.word__description___view;
  Text__Edit_Memo.Text__Edit_Memo_Form.Text_Type_Set( Text__Edit_Memo.tt_Memo );
  modal_result := Text__Edit_Memo.Text__Edit_Memo_Form.ShowModal();

  if modal_result = mrOk then
    description_value_l := Text__Edit_Memo.Text__Edit_Memo_Form.text_value;

  FreeAndNil( Text__Edit_Memo.Text__Edit_Memo_Form );


  zts := View__Description__Set__Sql_Prepare( Self.Quotation_Sign__VEEF() + view_name__veef_g + Self.Quotation_Sign__VEEF(), description_value_l );


  Log_Memo.Lines.Add( zts );


  if modal_result <> mrOk then
    Exit;


  View__Description__Set__Sql_Execute( zts );

end;

procedure TView__Edit_Execute_F_Frame.View__Description__Drop_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if view__columns_sdbm = nil then
    Exit;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__veef_g ) + view__sql__description__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__veef_g ) + view__sql__description__drop__file_name_c + ').' );

      zts :=
        'comment on view ' +
        Self.Quotation_Sign__VEEF() + view_name__veef_g + Self.Quotation_Sign__VEEF() +
        ' is null ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__view__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__VEEF() + view_name__veef_g + Self.Quotation_Sign__VEEF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_view_description + ' ''' + Self.Quotation_Sign__VEEF() + view_name__veef_g + Self.Quotation_Sign__VEEF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := view__columns_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_view_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( view__columns_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TView__Edit_Execute_F_Frame.View__Parameter__Description__Set_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  modal_result : TModalResult;

  zts,
  description_value_l,
  error_message_l,
  view__parameter_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( view__columns_sdbm = nil )
    or ( not view__columns_sdbm.Query__Active() )
    or ( view__columns_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Text__Edit_Memo.Text__Edit_Memo_Form := Text__Edit_Memo.TText__Edit_Memo_Form.Create( Application );
  Text__Edit_Memo.Text__Edit_Memo_Form.text_value := view__columns_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
  Text__Edit_Memo.Text__Edit_Memo_Form.quotation_mark_duplicate := true;
  Text__Edit_Memo.Text__Edit_Memo_Form.Caption := Translation.translation__messages_r.word__description___view_parameter;
  Text__Edit_Memo.Text__Edit_Memo_Form.Text_Type_Set( Text__Edit_Memo.tt_Memo );
  modal_result := Text__Edit_Memo.Text__Edit_Memo_Form.ShowModal();

  if modal_result = mrOk then
    description_value_l := Text__Edit_Memo.Text__Edit_Memo_Form.text_value;

  FreeAndNil( Text__Edit_Memo.Text__Edit_Memo_Form );


  view__parameter_name_l := Self.Quotation_Sign__VEEF() + view_name__veef_g + Self.Quotation_Sign__VEEF() + Common.sql__names_separator + Self.Quotation_Sign__VEEF() + Trim(  view__columns_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString  ) + Self.Quotation_Sign__VEEF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__veef_g ) + Common.view__sql__parameter__description__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__veef_g ) + Common.view__sql__parameter__description__set__file_name_c + ').' );

      zts := Common.view__sql__parameter__description__set_c;

    end;

  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, view__parameter_name_l, [ rfReplaceAll ] );
  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );


  Log_Memo.Lines.Add( zts );


  if modal_result <> mrOk then
    Exit;


  ztb := view__columns_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_view_parameter_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( view__columns_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TView__Edit_Execute_F_Frame.View__Parameter__Description__Drop_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l,
  view__parameter_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( view__columns_sdbm = nil )
    or ( not view__columns_sdbm.Query__Active() )
    or ( view__columns_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  view__parameter_name_l := Self.Quotation_Sign__VEEF() + view_name__veef_g + Self.Quotation_Sign__VEEF() + Common.sql__names_separator + Self.Quotation_Sign__VEEF() + Trim(  view__columns_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString  ) + Self.Quotation_Sign__VEEF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__veef_g ) + view__sql__parameter__description__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__veef_g ) + view__sql__parameter__description__drop__file_name_c + ').' );

      zts :=
        'comment on column ' +
        view__parameter_name_l +
        ' is null ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, view__parameter_name_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_view_parameter_description + ' ''' + view__parameter_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := view__columns_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_view_parameter_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( view__columns_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TView__Edit_Execute_F_Frame.Data_Preview_DBMemoChange( Sender: TObject );
begin

  Caret_Position_Display();

end;

procedure TView__Edit_Execute_F_Frame.Data_Preview_DBMemoClick( Sender: TObject );
begin

  Caret_Position_Display();

end;

procedure TView__Edit_Execute_F_Frame.Data_Preview_DBMemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

  Key_Up_Common( Sender, Key, Shift );

end;

procedure TView__Edit_Execute_F_Frame.Memo_KeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] )
    and ( Sender <> nil ) then
    if Sender = Log_Memo then
      Log_Memo.SelectAll()
    else
    if Sender = View__Description_Memo then
      View__Description_Memo.SelectAll();
    //else
    //if Sender = View__Source_Memo then
    //  View__Source_Memo.SelectAll();

end;

procedure TView__Edit_Execute_F_Frame.View__Source_MemoClick( Sender: TObject );
begin

  Caret_Position_Display();

end;

procedure TView__Edit_Execute_F_Frame.View__Source_MemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

  Key_Up_Common( Sender, Key, Shift );

end;

procedure TView__Edit_Execute_F_Frame.View__Source_SynEditEnter( Sender: TObject );
begin

  Common.Text__Search_Replace__Syn_Edit__Set( View__Source_SynEdit, text__search_replace_form );

end;

procedure TView__Edit_Execute_F_Frame.View__Source_SynEditClick( Sender: TObject );
begin

  Caret_Position_Display();

  Common.Syn_Edit__Highlight__Text( View__Source_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( View__Source_SynEdit, text__search_replace_form );

end;

procedure TView__Edit_Execute_F_Frame.View__Source_SynEditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Common.Syn_Edit_Key_Down( View__Source_SynEdit, Sender, Key, Shift );


  Key_Down_Common( Sender, Key, Shift );

end;

procedure TView__Edit_Execute_F_Frame.View__Source_SynEditKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

  Common.Syn_Edit__Highlight__Text( View__Source_SynEdit );

  Common.Text__Search_Replace__Syn_Edit__Set( View__Source_SynEdit, text__search_replace_form );

  Key_Up_Common( Sender, Key, Shift );

end;

procedure TView__Edit_Execute_F_Frame.View__Source_SynEditReplaceText( Sender: TObject; const ASearch, AReplace: string; Line, Column: Integer; var Action: TSynReplaceAction );
begin

  Common.Syn_Edit__On_Replace_Text(  View__Source_SynEdit, ASearch, AReplace, Line, Column, Action, ClientToScreen( Self.ClientRect )  );

end;

procedure TView__Edit_Execute_F_Frame.View__Description_MemoClick( Sender: TObject );
begin

  Caret_Position_Display();

end;

procedure TView__Edit_Execute_F_Frame.View__Description_MemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

  Key_Up_Common( Sender, Key, Shift );

end;

procedure TView__Edit_Execute_F_Frame.View__Parameters__Description_DBMemoClick( Sender: TObject );
begin

  Caret_Position_Display();

end;

procedure TView__Edit_Execute_F_Frame.View__Parameters__Description_DBMemoKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Caret_Position_Display();

  Key_Up_Common( Sender, Key, Shift );

end;

procedure TView__Edit_Execute_F_Frame.View__Parameters_DBGridCellClick( Column: TColumn );
begin

  Data_Preview( true );

end;

procedure TView__Edit_Execute_F_Frame.View__Parameters_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
begin

  if Self.Task_Running_Check__VEEF( false ) then
    Exit;


  Common.DB_Grid_Draw_Column_Cell( view__parameters__sort__column_name_g, View__Parameters_DBGrid, Rect, DataCol, Column, State );

end;

procedure TView__Edit_Execute_F_Frame.View__Parameters_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Self.Task_Running_Check__VEEF() then
    Exit;


  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( view__columns_sdbm.Query__Active() )
    and ( view__columns_sdbm.Query__Record_Count > 0 )
    and ( View__Parameters_DBGrid.SelectedField <> nil ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := View__Parameters_DBGrid.SelectedField.Value;
    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end
  else
    Key_Down_Common( Sender, Key, Shift );

end;

procedure TView__Edit_Execute_F_Frame.View__Parameters_DBGridKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Data_Preview( true );

  Key_Up_Common( Sender, Key, Shift );

end;

procedure TView__Edit_Execute_F_Frame.View__Parameters_DBGridTitleClick( Column: TColumn );
begin

  if Self.Task_Running_Check__VEEF() then
    Exit;


  if Column.Field = nil then
    Exit;


  if view__parameters__sort__column_name_g = Column.Field.FieldName then
    view__parameters__sort__direction_ascending_g := not view__parameters__sort__direction_ascending_g
  else
    view__parameters__sort__column_name_g := Column.Field.FieldName;

  view__columns_sdbm.Query__Sort(  view__parameters__sort__column_name_g + Common.Sort_Direction_Symbol( view__parameters__sort__direction_ascending_g )  );

end;

procedure TView__Edit_Execute_F_Frame.View__Output_DBGridCellClick( Column: TColumn );
begin

  Data_Preview();

end;

procedure TView__Edit_Execute_F_Frame.View__Output_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
begin

  if Self.Task_Running_Check__VEEF( false ) then
    Exit;


  Common.DB_Grid_Draw_Column_Cell( view__output__sort__column_name_g, View__Output_DBGrid, Rect, DataCol, Column, State );

end;

procedure TView__Edit_Execute_F_Frame.View__Output_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Self.Task_Running_Check__VEEF() then
    Exit;


  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( view__output_sdbm.Query__Active() )
    and ( view__output_sdbm.Query__Record_Count > 0 )
    and ( View__Output_DBGrid.SelectedField <> nil ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := View__Output_DBGrid.SelectedField.Value;
    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end
  else
  // D.
  if    ( Key = 68 )
    and ( Shift = [ ssCtrl ] ) then // Due to writing capitals without ssShift.
    Column__Values__Distinct()
  else
  // S.
  if    ( Key = 83 )
    and (
             ( Shift = [ ssCtrl ] )
          or ( Shift = [ ssShift ] )
        ) then
    Column__Values__Sum()
  else
    Key_Down_Common( Sender, Key, Shift );

end;

procedure TView__Edit_Execute_F_Frame.View__Output_DBGridKeyUp( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  Data_Preview();

  Key_Up_Common( Sender, Key, Shift );

end;

procedure TView__Edit_Execute_F_Frame.View__Output_DBGridTitleClick( Column: TColumn );
begin

  if Self.Task_Running_Check__VEEF() then
    Exit;


  if Column.Field = nil then
    Exit;


  if view__output__sort__column_name_g = Column.Field.FieldName then
    view__output__sort__direction_ascending_g := not view__output__sort__direction_ascending_g
  else
    view__output__sort__column_name_g := Column.Field.FieldName;

  view__output_sdbm.Query__Sort(  view__output__sort__column_name_g + Common.Sort_Direction_Symbol( view__output__sort__direction_ascending_g )  );


  View__Output_DBEditChange( nil ); // For FireDAC.

end;

end.
