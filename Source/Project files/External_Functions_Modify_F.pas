unit External_Functions_Modify_F;{12.Wrz.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Translation,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Mask, Vcl.DBCtrls, Vcl.Samples.Spin, Vcl.Menus;

type
  TExternal_Functions_Modify_F_Frame = class( TFrame )
    Buttons_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    External_Function_Name_DBEdit: TDBEdit;
    External_Function_Name_Etiquette_Label: TLabel;
    External_Functions_DataSource: TDataSource;
    External_Functions_DBGrid: TDBGrid;
    Log_Memo: TMemo;
    Modify_GroupBox: TGroupBox;
    Modify__Add_Button: TButton;
    Modify__Delete_Button: TButton;
    Modify__Edit_Button: TButton;
    Record_Number__Records_Count_Label: TLabel;
    Refresh_Button: TButton;
    Search_Edit: TEdit;
    Search_GroupBox: TGroupBox;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Next_Button: TButton;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Prior_Button: TButton;
    Vertical_Splitter: TSplitter;
    External_Functions_PopupMenu: TPopupMenu;
    External_Function__Delete_MenuItem: TMenuItem;
    N1: TMenuItem;
    External_Function__Description__Set_MenuItem: TMenuItem;
    External_Function__Description__Drop_MenuItem: TMenuItem;
    N2: TMenuItem;
    External_Function__Description__Write_In_Log_MenuItem: TMenuItem;
    Edit_In_Modal_View_CheckBox: TCheckBox;
    Log_Horizontal_Splitter: TSplitter;

    procedure External_Function_Name_DBEditChange( Sender: TObject );
    procedure Search_Change( Sender: TObject );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );

    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Modify__Add_ButtonClick( Sender: TObject );
    procedure Modify__Edit_ButtonClick( Sender: TObject );
    procedure Modify__Delete_ButtonClick( Sender: TObject );

    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );

    procedure External_Function__Description__Set_MenuItemClick( Sender: TObject );
    procedure External_Function__Description__Drop_MenuItemClick( Sender: TObject );
    procedure External_Function__Description__Write_In_Log_MenuItemClick( Sender: TObject );

    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure External_Functions_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
    procedure External_Functions_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure External_Functions_DBGridTitleClick( Column: TColumn );
  private
    { Private declarations }
    sort__direction_ascending_g,
    splitter_show__efmf_g,
    sql__quotation_sign__use__efmf_g
      : boolean;

    database_type__efmf_g,
    sort__column_name_g,
    sql__quotation_sign__efmf_g
      : string;

    external_functions__modify_sdbm : Common.TSDBM;

    function Quotation_Sign__EFMF() : string;
  public
    { Public declarations }
    function Data_Active__EFMF() : boolean;
    procedure Data_Open__EFMF();
    procedure Finish__EFMF();
    procedure Highlight__Font__Set__EFMF();
    procedure Options_Set__EFMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const splitter_show_f, sql__quotation_sign__use_f : boolean );
    procedure Prepare__EFMF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const splitter_show_f, sql__quotation_sign__use_f : boolean );
    procedure Translation__Apply__EFMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
  end;

const
  external_functions_list__column__parameters__cast_c : string = 'PARAMETERS__CAST';
  external_functions_list__file_name_c : string = 'External_Functions_List__sql.txt';
  external_functions_list__sql__description__drop__file_name_c : string = 'External_Function__Description__Drop__sql.txt';
  external_functions_list__sql__external_function__drop__file_name_c : string = 'External_Function__Drop__sql.txt';

implementation

uses
  Vcl.Clipbrd,

  External_Function__Modify,
  Shared,
  Text__Edit_Memo;

{$R *.dfm}

function TExternal_Functions_Modify_F_Frame.Data_Active__EFMF() : boolean;
begin

  Result :=
        ( external_functions__modify_sdbm <> nil )
    and ( external_functions__modify_sdbm.Query__Active() );

end;

procedure TExternal_Functions_Modify_F_Frame.Data_Open__EFMF();
var
  i : integer;

  zts : string;
begin

  if   ( external_functions__modify_sdbm = nil )
    or ( external_functions__modify_sdbm.component_type__sdbm = Common.ct_none ) then
    Exit;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__efmf_g ) + external_functions_list__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__efmf_g ) + external_functions_list__file_name_c + ').' );

      zts :=
        'select RDB$FUNCTIONS.RDB$FUNCTION_NAME as EXTERNAL_FUNCTION_NAME ' +
        '     , RDB$FUNCTIONS.RDB$MODULE_NAME ' +
        '     , RDB$FUNCTIONS.RDB$ENTRYPOINT ' +
        //'     , cast(  substring( RDB$FUNCTIONS.RDB$DESCRIPTION from 1 for 10000 ) as varchar( 10000 )  ) as DESCRIPTION_VALUE__CAST ' +
        '     , cast(  substring( RDB$FUNCTIONS.RDB$DESCRIPTION from 1 for 8191 ) as varchar( 8191 )  ) as DESCRIPTION_VALUE__CAST ' + // FireDAC limit default - FDConnection1.FormatOptions.MaxStringSize = 32767 bytes ( / 4 = 8191,75 ).
        ' ' +
        '     , ( ' +
        '         select cast ' +
        '                  ( ' +
        '                      substring ' +
        '                        ( ' +
        '                          list( '' '' || t.FIELD_TYPE ) ' +
        '                          from 1 for 255 ' +
        '                        ) ' +
        '                    as varchar( 255 ) ' +
        '                  ) ' +
        '         from ' +
        '           ( ' +
        '             select (case ' +
        '                      RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE ' +
        '                      when 7 then ' +
        '                        (case ' +
        '                          RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE ' +
        '                          when 1 then ' +
        '                            ''Numeric'' ' +
        ' ' +
        '                          when 2 then ' +
        '                            ''Decimal'' ' +
        ' ' +
        '                          else ' +
        '                            ''Smallint'' ' +
        '                        end) ' +
        ' ' +
        '                      when 8 then ' +
        '                        (case ' +
        '                          RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE ' +
        '                          when 1 then ' +
        '                            ''Numeric'' ' +
        ' ' +
        '                          when 2 then ' +
        '                            ''Decimal'' ' +
        ' ' +
        '                          else ' +
        '                            ''Integer'' ' +
        '                        end) ' +
        ' ' +
        '                      when 9 then ' +
        '                        ''Quad'' ' +
        ' ' +
        '                      when 10 then ' +
        '                        ''Float'' ' +
        ' ' +
        '                      when 12 then ' +
        '                        ''Date'' ' +
        ' ' +
        '                      when 13 then ' +
        '                        ''Time'' ' +
        ' ' +
        '                      when 14 then ' +
        '                        ''Char'' ' +
        ' ' +
        '                      when 16 then ' +
        '                        (case ' +
        '                          RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE ' +
        '                          when 1 then ' +
        '                            ''Numeric'' ' +
        ' ' +
        '                          when 2 then ' +
        '                            ''Decimal'' ' +
        ' ' +
        '                          else ' +
        '                            ''Bigint'' ' +
        '                        end) ' +
        ' ' +
        '                      when 23 then ' +
        '                        ''Boolean'' ' +
        ' ' +
        '                      when 27 then ' +
        '                        ''Double precision'' ' +
        ' ' +
        '                      when 35 then ' +
        '                        ''Timestamp'' ' +
        ' ' +
        '                      when 37 then ' +
        '                        ''Varchar'' ' +
        ' ' +
        '                      when 40 then ' +
        '                        ''Cstring'' ' +
        ' ' +
        '                      when 45 then ' +
        '                        ''Blob_Id'' ' +
        ' ' +
        '                      when 261 then ' +
        '                       ''Blob'' ' +
        ' ' +
        '                      else ' +
        '                        RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE||'' <?>'' ' +
        '                    end)|| ' +
        '                    iif(   RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE in ( 37 ) or ( RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE in ( 7, 8, 16, 27 ) and RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE = 2  ), ''( ''||' +
          'coalesce( RDB$FUNCTION_ARGUMENTS.RDB$CHARACTER_LENGTH, RDB$FUNCTION_ARGUMENTS.RDB$FIELD_PRECISION, '''' )||' +
          'iif(  RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE in ( 7, 8, 16 ) and RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE = 2 and RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SCALE is not null, '', ''||' +
          'cast(  abs( RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SCALE ) as smallint  ), ''''  )||'' )'', ''''   )|| ' +
        '                    iif(  RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE in ( 40 ), ''( ''||RDB$FUNCTION_ARGUMENTS.RDB$FIELD_LENGTH||'' )'', ''''  )|| ' +
        '                    cast(   substring(  coalesce( '' ''||RDB$FUNCTION_ARGUMENTS.RDB$DEFAULT_SOURCE, '''' ) from 1 for 255  ) as varchar( 255 )   )|| ' +
        '                    iif(  RDB$FUNCTION_ARGUMENTS.RDB$NULL_FLAG = 1, '' not null'', trim( '''' )  )|| ' +
        '                    coalesce(  '' collate ''||trim( RDB$COLLATIONS.RDB$COLLATION_NAME ), ''''  ) ' +
        '                    as FIELD_TYPE ' +
        ' ' +
        '             from RDB$FUNCTION_ARGUMENTS ' +
        '             left join RDB$COLLATIONS on RDB$COLLATIONS.RDB$COLLATION_ID = RDB$FUNCTION_ARGUMENTS.RDB$COLLATION_ID ' +
        '             where RDB$FUNCTION_ARGUMENTS.RDB$FUNCTION_NAME = RDB$FUNCTIONS.RDB$FUNCTION_NAME ' +
        '             order by RDB$FUNCTION_ARGUMENTS.RDB$ARGUMENT_POSITION ' +
        '           ) as t ' +
        '       ) as PARAMETERS__CAST ' +
        ' ' +
        '     , RDB$FUNCTIONS.RDB$OWNER_NAME as OWNER_NAME ' +
        '     , RDB$FUNCTIONS.RDB$FUNCTION_ID ' +
        '     , RDB$FUNCTIONS.RDB$DESCRIPTION as DESCRIPTION_VALUE ' +
        ' ' +
        '     , ( ' +
        '         select list( '' '' || t.FIELD_TYPE ) ' +
        '         from ' +
        '           ( ' +
        '             select (case ' +
        '                      RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE ' +
        '                      when 7 then ' +
        '                        (case ' +
        '                          RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE ' +
        '                          when 1 then ' +
        '                            ''Numeric'' ' +
        ' ' +
        '                          when 2 then ' +
        '                            ''Decimal'' ' +
        ' ' +
        '                          else ' +
        '                            ''Smallint'' ' +
        '                        end) ' +
        ' ' +
        '                      when 8 then ' +
        '                        (case ' +
        '                          RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE ' +
        '                          when 1 then ' +
        '                            ''Numeric'' ' +
        ' ' +
        '                          when 2 then ' +
        '                            ''Decimal'' ' +
        ' ' +
        '                          else ' +
        '                            ''Integer'' ' +
        '                        end) ' +
        ' ' +
        '                      when 9 then ' +
        '                        ''Quad'' ' +
        ' ' +
        '                      when 10 then ' +
        '                        ''Float'' ' +
        ' ' +
        '                      when 12 then ' +
        '                        ''Date'' ' +
        ' ' +
        '                      when 13 then ' +
        '                        ''Time'' ' +
        ' ' +
        '                      when 14 then ' +
        '                        ''Char'' ' +
        ' ' +
        '                      when 16 then ' +
        '                        (case ' +
        '                          RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE ' +
        '                          when 1 then ' +
        '                            ''Numeric'' ' +
        ' ' +
        '                          when 2 then ' +
        '                            ''Decimal'' ' +
        ' ' +
        '                          else ' +
        '                            ''Bigint'' ' +
        '                        end) ' +
        ' ' +
        '                      when 23 then ' +
        '                        ''Boolean'' ' +
        ' ' +
        '                      when 27 then ' +
        '                        ''Double precision'' ' +
        ' ' +
        '                      when 35 then ' +
        '                        ''Timestamp'' ' +
        ' ' +
        '                      when 37 then ' +
        '                        ''Varchar'' ' +
        ' ' +
        '                      when 40 then ' +
        '                        ''Cstring'' ' +
        ' ' +
        '                      when 45 then ' +
        '                        ''Blob_Id'' ' +
        ' ' +
        '                      when 261 then ' +
        '                       ''Blob'' ' +
        ' ' +
        '                      else ' +
        '                        RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE||'' <?>'' ' +
        '                    end)|| ' +
        '                    iif(   RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE in ( 37 ) or ( RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE in ( 7, 8, 16, 27 ) and RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE = 2  ), ''( ''||' +
          'coalesce( RDB$FUNCTION_ARGUMENTS.RDB$CHARACTER_LENGTH, RDB$FUNCTION_ARGUMENTS.RDB$FIELD_PRECISION, '''' )||' +
          'iif(  RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE in ( 7, 8, 16 ) and RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SUB_TYPE = 2 and RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SCALE is not null, '', ''||' +
          'cast(  abs( RDB$FUNCTION_ARGUMENTS.RDB$FIELD_SCALE ) as smallint  ), ''''  )||'' )'', ''''   )|| ' +
        '                    iif(  RDB$FUNCTION_ARGUMENTS.RDB$FIELD_TYPE in ( 40 ), ''( ''||RDB$FUNCTION_ARGUMENTS.RDB$FIELD_LENGTH||'' )'', ''''  )|| ' +
        '                    cast(   substring(  coalesce( '' ''||RDB$FUNCTION_ARGUMENTS.RDB$DEFAULT_SOURCE, '''' ) from 1 for 255  ) as varchar( 255 )   )|| ' +
        '                    iif(  RDB$FUNCTION_ARGUMENTS.RDB$NULL_FLAG = 1, '' not null'', trim( '''' )  )|| ' +
        '                    coalesce(  '' collate ''||trim( RDB$COLLATIONS.RDB$COLLATION_NAME ), ''''  ) ' +
        '                    as FIELD_TYPE ' +
        ' ' +
        '             from RDB$FUNCTION_ARGUMENTS ' +
        '             left join RDB$COLLATIONS on RDB$COLLATIONS.RDB$COLLATION_ID = RDB$FUNCTION_ARGUMENTS.RDB$COLLATION_ID ' +
        '             where RDB$FUNCTION_ARGUMENTS.RDB$FUNCTION_NAME = RDB$FUNCTIONS.RDB$FUNCTION_NAME ' +
        '             order by RDB$FUNCTION_ARGUMENTS.RDB$ARGUMENT_POSITION ' +
        '           ) as t ' +
        '       ) as PARAMETERS ' +
        ' ' +
        'from RDB$FUNCTIONS ' +
        'order by RDB$FUNCTIONS.RDB$FUNCTION_NAME ';

    end;


  Screen.Cursor := crHourGlass;


  if external_functions__modify_sdbm.Query__Active() then
    external_functions__modify_sdbm.Query__Close();

  external_functions__modify_sdbm.Query__Sql__Set( zts );


  Log_Memo.Lines.Add( zts );


  try
    external_functions__modify_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_open_external_functions_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;


  Screen.Cursor := crDefault;


  if external_functions__modify_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( external_functions__modify_sdbm.Operation_Duration_Get() );


      try
        External_Function_Name_DBEdit.DataField := Common.external_functions__column__external_functions_name__big_letter_c;
        external_functions__modify_sdbm.Query__Field_By_Name( Common.external_functions__column__external_functions_name__big_letter_c ).AsString;
        external_functions__modify_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );
      except
        on E : Exception do
          begin

            external_functions__modify_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_external_function_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;


      for i := 0 to External_Functions_DBGrid.Columns.Count - 1 do
        if External_Functions_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value__cast_c then
          begin

            if External_Functions_DBGrid.Columns.Items[ i ].Width > 500 then
              External_Functions_DBGrid.Columns.Items[ i ].Width := 500;

          end
        else
          begin

            if External_Functions_DBGrid.Columns.Items[ i ].FieldName = external_functions_list__column__parameters__cast_c then
              begin

                if External_Functions_DBGrid.Columns.Items[ i ].Width > 400 then
                  External_Functions_DBGrid.Columns.Items[ i ].Width := 400;

              end
            else
              if External_Functions_DBGrid.Columns.Items[ i ].Width > 200 then
                External_Functions_DBGrid.Columns.Items[ i ].Width := 200;

          end;


      Self.Translation__Apply__EFMF( Translation.tak_Grid );


      Common.Data_Value_Format__Set( external_functions__modify_sdbm, Log_Memo );

    end;

end;

procedure TExternal_Functions_Modify_F_Frame.Finish__EFMF();
begin

  FreeAndNil( external_functions__modify_sdbm );

end;

procedure TExternal_Functions_Modify_F_Frame.Highlight__Font__Set__EFMF();
begin

  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    Common.Font__Set( External_Functions_DBGrid.Font, Common.sql_editor__font );

end;

function TExternal_Functions_Modify_F_Frame.Quotation_Sign__EFMF() : string;
begin

  if sql__quotation_sign__use__efmf_g then
    begin

      Result := sql__quotation_sign__efmf_g;

    end
  else
    Result := '';

end;

procedure TExternal_Functions_Modify_F_Frame.Options_Set__EFMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const splitter_show_f, sql__quotation_sign__use_f : boolean );
begin

  splitter_show__efmf_g := splitter_show_f;
  sql__quotation_sign__use__efmf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__efmf_g := sql__quotation_sign_f;


  if external_functions__modify_sdbm <> nil then
    begin

      external_functions__modify_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

      external_functions__modify_sdbm.Data_Source__Data_Set__Set( External_Functions_DataSource );

    end;


  Self.Translation__Apply__EFMF( Translation.tak_Self );

end;

procedure TExternal_Functions_Modify_F_Frame.Prepare__EFMF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const splitter_show_f, sql__quotation_sign__use_f : boolean );
begin

  Self.Name := '';

  database_type__efmf_g := databases_r_f.database_type;
  sort__column_name_g := Common.external_functions__column__external_functions_name__big_letter_c;
  sort__direction_ascending_g := true;


  external_functions__modify_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Self.Options_Set__EFMF( component_type_f, databases_r_f.sql__quotation_sign, splitter_show_f, sql__quotation_sign__use_f );


  Highlight__Font__Set__EFMF();

end;

procedure TExternal_Functions_Modify_F_Frame.Translation__Apply__EFMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
var
  i : integer;
begin

  if tak_f in [ Translation.tak_All, Translation.tak_Self ] then
    Translation.Translation__Apply( Self );


  if tak_f in [ Translation.tak_All, Translation.tak_Grid ] then
    for i := 0 to External_Functions_DBGrid.Columns.Count - 1 do
      if External_Functions_DBGrid.Columns.Items[ i ].FieldName = Common.external_functions__column__external_functions_name__big_letter_c then
        External_Functions_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__name
      else
      if External_Functions_DBGrid.Columns.Items[ i ].FieldName = Common.name__description_value__cast_c then
        External_Functions_DBGrid.Columns.Items[ i ].Title.Caption := Translation.translation__messages_r.word__description
      else
        External_Functions_DBGrid.Columns.Items[ i ].Title.Caption := Common.Column__Name_To_Grid_Caption( External_Functions_DBGrid.Columns.Items[ i ].FieldName );

end;

procedure TExternal_Functions_Modify_F_Frame.External_Function_Name_DBEditChange( Sender: TObject );
begin

  if    ( external_functions__modify_sdbm <> nil )
    and ( external_functions__modify_sdbm.Query__Active() ) then
    Record_Number__Records_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', external_functions__modify_sdbm.Query__Record_Number() )  ) + ' / ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', external_functions__modify_sdbm.Query__Record_Count() )  )
  else
    Record_Number__Records_Count_Label.Caption := '0 / 0';

end;

procedure TExternal_Functions_Modify_F_Frame.Search_Change( Sender: TObject );
var
  locate_options : Data.DB.TLocateOptions;
begin

  if   ( external_functions__modify_sdbm = nil )
    or ( not external_functions__modify_sdbm.Query__Active() ) then
    Exit;


  locate_options := [];

  if Search__Case_Insensitive_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loCaseInsensitive ];

  if Search__Partial_Key_CheckBox.Checked then
    locate_options := locate_options + [ Data.DB.loPartialKey ];


  if external_functions__modify_sdbm.Query__Locate( sort__column_name_g, Search_Edit.Text, locate_options ) then
    Search_Edit.Color := clWindow
  else
    begin

      Search_Edit.Color := Common.color__red__light_c;


      external_functions__modify_sdbm.Query__Disable_Controls();

      external_functions__modify_sdbm.Query__First();

      while not external_functions__modify_sdbm.Query__Eof do
        begin

          if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  external_functions__modify_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
            begin

              Search_Edit.Color := clWindow;

              Break;

            end;

          external_functions__modify_sdbm.Query__Next();

        end;

      external_functions__modify_sdbm.Query__Enable_Controls();

    end;

end;

procedure TExternal_Functions_Modify_F_Frame.Search__Next_ButtonClick( Sender: TObject );
begin

  if   ( external_functions__modify_sdbm = nil )
    or ( not external_functions__modify_sdbm.Query__Active() ) then
    Exit;


  external_functions__modify_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not external_functions__modify_sdbm.Query__Eof do
    begin

      external_functions__modify_sdbm.Query__Next();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  external_functions__modify_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  external_functions__modify_sdbm.Query__Enable_Controls();

end;

procedure TExternal_Functions_Modify_F_Frame.Search__Prior_ButtonClick( Sender: TObject );
begin

  if   ( external_functions__modify_sdbm = nil )
    or ( not external_functions__modify_sdbm.Query__Active() ) then
    Exit;


  external_functions__modify_sdbm.Query__Disable_Controls();


  Search_Edit.Color := Common.color__red__light_c;


  while not external_functions__modify_sdbm.Query__Bof do
    begin

      external_functions__modify_sdbm.Query__Prior();


      if Pos(   Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String(  external_functions__modify_sdbm.Query__Field_By_Name( sort__column_name_g ).AsString, Search__Case_Insensitive_CheckBox.Checked  )   ) > 0 then
        begin

          Search_Edit.Color := clWindow;

          Break;

        end;

    end;


  external_functions__modify_sdbm.Query__Enable_Controls();

end;

procedure TExternal_Functions_Modify_F_Frame.Refresh_ButtonClick( Sender: TObject );
var
  primary_key_value_l : string;
begin

  if   ( external_functions__modify_sdbm = nil )
    or ( not external_functions__modify_sdbm.Query__Active() ) then
    Exit;


  primary_key_value_l := external_functions__modify_sdbm.Query__Field_By_Name( Common.external_functions__column__external_functions_name__big_letter_c ).AsString;

  external_functions__modify_sdbm.Query__Requery();


  if    ( Sender <> nil )
    and ( Sender = Refresh_Button ) then
    begin

      Log_Memo.Lines.Add( external_functions__modify_sdbm.Operation_Duration_Get() );

    end;


  external_functions__modify_sdbm.Query__Locate( Common.external_functions__column__external_functions_name__big_letter_c, primary_key_value_l, [ Data.DB.loCaseInsensitive ] );

end;

procedure TExternal_Functions_Modify_F_Frame.Modify__Add_ButtonClick( Sender: TObject );
var
  modified_l : boolean;

  external_function_name_l : string;

  external_function__modify_form_l : External_Function__Modify.TExternal_Function__Modify_Form;
begin

  if external_functions__modify_sdbm = nil then
    Exit;


  external_function__modify_form_l := External_Function__Modify.TExternal_Function__Modify_Form.Create( Application, external_functions__modify_sdbm );
  external_function__modify_form_l.database_type__efm := database_type__efmf_g;
  external_function__modify_form_l.splitter_show__efm := splitter_show__efmf_g;
  external_function__modify_form_l.sql__quotation_sign__efm := sql__quotation_sign__efmf_g;
  external_function__modify_form_l.sql__quotation_sign__use__efm := sql__quotation_sign__use__efmf_g;

  if not Edit_In_Modal_View_CheckBox.Checked then
    begin

      external_function__modify_form_l.show_modal__efm := false;
      external_function__modify_form_l.Show();

      Exit;

    end;

  external_function__modify_form_l.ShowModal();
  modified_l := external_function__modify_form_l.modified__efm;
  external_function_name_l := external_function__modify_form_l.external_function__name__efm;
  FreeAndNil( external_function__modify_form_l );


  if modified_l then
    begin

      Refresh_ButtonClick( Sender );
      external_functions__modify_sdbm.Query__Locate( Common.external_functions__column__external_functions_name__big_letter_c, external_function_name_l, [ Data.DB.loCaseInsensitive ] );

    end;

end;

procedure TExternal_Functions_Modify_F_Frame.Modify__Edit_ButtonClick( Sender: TObject );
var
  modified_l : boolean;

  external_function__modify_form_l : External_Function__Modify.TExternal_Function__Modify_Form;
begin

  if   ( external_functions__modify_sdbm = nil )
    or ( not external_functions__modify_sdbm.Query__Active() )
    or ( external_functions__modify_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  external_function__modify_form_l := External_Function__Modify.TExternal_Function__Modify_Form.Create( Application, external_functions__modify_sdbm );
  external_function__modify_form_l.database_type__efm := database_type__efmf_g;
  external_function__modify_form_l.splitter_show__efm := splitter_show__efmf_g;
  external_function__modify_form_l.sql__quotation_sign__efm := sql__quotation_sign__efmf_g;
  external_function__modify_form_l.sql__quotation_sign__use__efm := sql__quotation_sign__use;
  external_function__modify_form_l.external_function__description_value__efm := external_functions__modify_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
  external_function__modify_form_l.external_function__name__efm := external_functions__modify_sdbm.Query__Field_By_Name( Common.external_functions__column__external_functions_name__big_letter_c ).AsString;
  external_function__modify_form_l.external_function__edit__efm := true;

  if not Edit_In_Modal_View_CheckBox.Checked then
    begin

      external_function__modify_form_l.show_modal__efm := false;
      external_function__modify_form_l.Show();

      Exit;

    end;

  external_function__modify_form_l.ShowModal();
  modified_l := external_function__modify_form_l.modified__efm;
  FreeAndNil( external_function__modify_form_l );


  if modified_l then
    begin

      Refresh_ButtonClick( Sender );

    end;

end;

procedure TExternal_Functions_Modify_F_Frame.Modify__Delete_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l
    : string;
begin

  // Parameters in SQL commands do not work here.


  if   ( external_functions__modify_sdbm = nil )
    or ( not external_functions__modify_sdbm.Query__Active() )
    or ( external_functions__modify_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__efmf_g ) + external_functions_list__sql__external_function__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__efmf_g ) + external_functions_list__sql__external_function__drop__file_name_c + ').' );

      zts :=
        'drop external function ' +
        Self.Quotation_Sign__EFMF() + external_functions__modify_sdbm.Query__Field_By_Name( Common.external_functions__column__external_functions_name__big_letter_c ).AsString + Self.Quotation_Sign__EFMF() +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.external_functions__column__external_functions_name__big_letter_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__EFMF() + external_functions__modify_sdbm.Query__Field_By_Name( Common.external_functions__column__external_functions_name__big_letter_c ).AsString + Self.Quotation_Sign__EFMF(), [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_external_function + ' ''' + Self.Quotation_Sign__EFMF() + external_functions__modify_sdbm.Query__Field_By_Name( Common.external_functions__column__external_functions_name__big_letter_c ).AsString + Self.Quotation_Sign__EFMF() + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := external_functions__modify_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_external_function );


  if ztb then
    begin

      Log_Memo.Lines.Add( external_functions__modify_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TExternal_Functions_Modify_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Buttons_Panel.Width := 1;

end;

procedure TExternal_Functions_Modify_F_Frame.External_Function__Description__Set_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  modal_result : TModalResult;

  zts,
  description_value_l,
  error_message_l,
  external_function_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( external_functions__modify_sdbm = nil )
    or ( not external_functions__modify_sdbm.Query__Active() )
    or ( external_functions__modify_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Text__Edit_Memo.Text__Edit_Memo_Form := Text__Edit_Memo.TText__Edit_Memo_Form.Create( Application );
  Text__Edit_Memo.Text__Edit_Memo_Form.text_value := external_functions__modify_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString;
  Text__Edit_Memo.Text__Edit_Memo_Form.quotation_mark_duplicate := true;
  Text__Edit_Memo.Text__Edit_Memo_Form.Caption := Translation.translation__messages_r.word__description___external_function;
  Text__Edit_Memo.Text__Edit_Memo_Form.Text_Type_Set( Text__Edit_Memo.tt_Memo );
  modal_result := Text__Edit_Memo.Text__Edit_Memo_Form.ShowModal();

  if modal_result = mrOk then
    description_value_l := Text__Edit_Memo.Text__Edit_Memo_Form.text_value;

  FreeAndNil( Text__Edit_Memo.Text__Edit_Memo_Form );


  external_function_name_l := Self.Quotation_Sign__EFMF() + Trim(  external_functions__modify_sdbm.Query__Field_By_Name( Common.external_functions__column__external_functions_name__big_letter_c ).AsString  ) + Self.Quotation_Sign__EFMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.


  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__efmf_g ) + Common.external_functions__sql__description__set__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__efmf_g ) + Common.external_functions__sql__description__set__file_name_c + ').' );

      zts := Common.external_functions__sql__description__set_c;

    end;

  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__description_value_c + Common.sql__word_replace_separator_c, description_value_l, [ rfReplaceAll ] );
  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.external_functions__column__external_functions_name__big_letter_c + Common.sql__word_replace_separator_c, external_function_name_l, [ rfReplaceAll ] );


  Log_Memo.Lines.Add( zts );


  if modal_result <> mrOk then
    Exit;


  ztb := external_functions__modify_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_external_function_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( external_functions__modify_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TExternal_Functions_Modify_F_Frame.External_Function__Description__Drop_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  zts,
  error_message_l,
  external_function_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( external_functions__modify_sdbm = nil )
    or ( not external_functions__modify_sdbm.Query__Active() )
    or ( external_functions__modify_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  external_function_name_l := Self.Quotation_Sign__EFMF() + Trim(  external_functions__modify_sdbm.Query__Field_By_Name( Common.external_functions__column__external_functions_name__big_letter_c ).AsString  ) + Self.Quotation_Sign__EFMF(); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__efmf_g ) + external_functions_list__sql__description__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__efmf_g ) + external_functions_list__sql__description__drop__file_name_c + ').' );

      zts :=
        'comment on function ' +
        external_function_name_l +
        ' is null ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.external_functions__column__external_functions_name__big_letter_c + Common.sql__word_replace_separator_c, external_function_name_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_external_function_description + ' ''' + external_function_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  ztb := external_functions__modify_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_the_external_function_description );


  if ztb then
    begin

      Log_Memo.Lines.Add( external_functions__modify_sdbm.Operation_Duration_Get() );


      Refresh_ButtonClick( Sender );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TExternal_Functions_Modify_F_Frame.External_Function__Description__Write_In_Log_MenuItemClick( Sender: TObject );
begin

  if   ( external_functions__modify_sdbm = nil )
    or ( not external_functions__modify_sdbm.Query__Active() )
    or ( external_functions__modify_sdbm.Query__Record_Count() <= 0 ) then
    Exit;


  Log_Memo.Lines.Add( '' );
  Log_Memo.Lines.Add(  external_functions__modify_sdbm.Query__Field_By_Name( Common.name__description_value_c ).AsString  );

end;

procedure TExternal_Functions_Modify_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TExternal_Functions_Modify_F_Frame.External_Functions_DBGridDrawColumnCell( Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState );
begin

  Common.DB_Grid_Draw_Column_Cell( sort__column_name_g, External_Functions_DBGrid, Rect, DataCol, Column, State );

end;

procedure TExternal_Functions_Modify_F_Frame.External_Functions_DBGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_INSERT then
    Modify__Add_ButtonClick( Sender )
  else
  if Key = VK_DELETE then
    Modify__Delete_ButtonClick( Sender )
  else
  if Key = VK_RETURN then
    Modify__Edit_ButtonClick( Sender )
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( external_functions__modify_sdbm.Query__Active() )
    and ( external_functions__modify_sdbm.Query__Record_Count > 0 )
    and ( External_Functions_DBGrid.SelectedField <> nil ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := External_Functions_DBGrid.SelectedField.Value;
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

procedure TExternal_Functions_Modify_F_Frame.External_Functions_DBGridTitleClick( Column: TColumn );
begin

  if Column.Field = nil then
    Exit;


  if sort__column_name_g = Column.Field.FieldName then
    sort__direction_ascending_g := not sort__direction_ascending_g
  else
    sort__column_name_g := Column.Field.FieldName;

  external_functions__modify_sdbm.Query__Sort(  sort__column_name_g + Common.Sort_Direction_Symbol( sort__direction_ascending_g )  );


  External_Function_Name_DBEditChange( nil ); // For FireDAC.

end;

end.
