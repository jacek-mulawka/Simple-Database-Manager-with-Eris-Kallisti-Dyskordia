unit Table_Add;{04.Wrz.2023}

interface

uses
  Common,
  Table_Column__Modify,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.Menus,
  Vcl.ToolWin;

type
  TTable_Add_Form = class( TForm )
    Execute_Button: TButton;
    Close_Button: TButton;
    Sql_Memo: TMemo;
    Sql_Prepare_Button: TButton;
    Table_Name_Edit: TEdit;
    Table_Name_Etiquette_Label: TLabel;
    PageControl1: TPageControl;
    Log_TabSheet: TTabSheet;
    Sql_TabSheet: TTabSheet;
    Log_Memo: TMemo;
    Bottom_Panel: TPanel;
    Table_Source_Memo_Horizontal_Splitter: TSplitter;
    Table_Columns_StringGrid: TStringGrid;
    Table_Columns_PopupMenu: TPopupMenu;
    Column__Add_MenuItem: TMenuItem;
    Column__Edit_MenuItem: TMenuItem;
    Column__Delete_MenuItem: TMenuItem;
    N1: TMenuItem;
    Primary_Key__Set_MenuItem: TMenuItem;
    Primary_Key__Delete_MenuItem: TMenuItem;
    N2: TMenuItem;
    Column__Move__Up_MenuItem: TMenuItem;
    Column__Move__Down_MenuItem: TMenuItem;
    Table_Columns_CoolBar: TCoolBar;
    Table_Columns_ToolBar: TToolBar;
    Column__Add_ToolButton: TToolButton;
    Column__Edit_ToolButton: TToolButton;
    Column__Delete_ToolButton: TToolButton;
    ToolButton4: TToolButton;
    Primary_Key__Set_ToolButton: TToolButton;
    Primary_Key__Delete_ToolButton: TToolButton;
    ToolButton7: TToolButton;
    Column__Move__Up_ToolButton: TToolButton;
    Column__Move__Down_ToolButton: TToolButton;
    Execute_Button_Works_As_Prepare_Execute_CheckBox: TCheckBox;
    procedure FormCreate( Sender: TObject );
    procedure FormShow( Sender: TObject );
    procedure FormDestroy( Sender: TObject );

    procedure Column__Add_MenuItemClick( Sender: TObject );
    procedure Column__Edit_MenuItemClick( Sender: TObject );
    procedure Column__Delete_MenuItemClick( Sender: TObject );
    procedure Primary_Key__Set_MenuItemClick( Sender: TObject );
    procedure Primary_Key__Delete_MenuItemClick( Sender: TObject );
    procedure Column__Move__Up_MenuItemClick( Sender: TObject );
    procedure Column__Move__Down_MenuItemClick( Sender: TObject );

    procedure Sql_Prepare_ButtonClick( Sender: TObject );
    procedure Execute_ButtonClick( Sender: TObject );

    procedure Table_Columns_StringGridDrawCell( Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState );
    procedure Table_Columns_StringGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Sql_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
  private
    { Private declarations }
    sql_prepared_correctly_g : boolean;

    sql__create_g,
    sql__primary_key_g,

    word__collate__ta_g,
    word__columns_separator__ta_g,
    word__default__ta_g,
    word__not_null__ta_g
      : string;

    table_add_sdbm : Common.TSDBM;

    procedure Grid_Values__Set( table_column__modify_form_f : Table_Column__Modify.TTable_Column__Modify_Form; row_f : integer = -1 );
    function Quotation_Sign__TA() : string;
    procedure Row_Position_Adjust( const row__current_f : integer; row__destinated_f : integer );
  public
    { Public declarations }
    modified__ta,
    sql__quotation_sign__use__ta
      : boolean;

    database_type__ta,
    sql__quotation_sign__ta,
    table_name__ta
      : string;

    constructor Create( AOwner : TComponent; sdbm_f : Common.TSDBM ); overload;
  end;

const
  table_columns__column_number__allow_nulls_c : integer = 3;
  table_columns__column_number__collation_c : integer = 5;
  table_columns__column_number__default_c : integer = 4;
  table_columns__column_number__name_c : integer = 1;
  table_columns__column_number__primary_key_c : integer = 6;
  table_columns__column_number__type_c : integer = 2;
  table_add__primary_key_name_c : string = 'PRIMARY_KEY_NAME';

var
  Table_Add_Form: TTable_Add_Form;

implementation

uses
  Vcl.Clipbrd,

  Shared,
  Translation;

{$R *.dfm}

procedure TTable_Add_Form.Grid_Values__Set( table_column__modify_form_f : Table_Column__Modify.TTable_Column__Modify_Form; row_f : integer = -1 );
begin

  if table_column__modify_form_f = nil then
    Exit;


  if row_f < 0 then
    begin

      if Trim( Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, 1 ] ) <> '' then
        Table_Columns_StringGrid.RowCount := Table_Columns_StringGrid.RowCount + 1;

      row_f := Table_Columns_StringGrid.RowCount - 1;

    end;


  Table_Columns_StringGrid.Cells[ 0, row_f ] := Trim(  FormatFloat( '### ### ### ### ### ### ##0', row_f )  );

  if table_column__modify_form_f.Not_Null_CheckBox.Checked then
    Table_Columns_StringGrid.Cells[ table_columns__column_number__allow_nulls_c, row_f ] := ''
  else
    Table_Columns_StringGrid.Cells[ table_columns__column_number__allow_nulls_c, row_f ] := Common.db_grid__positive_value_c;

  Table_Columns_StringGrid.Cells[ table_columns__column_number__collation_c, row_f ] := table_column__modify_form_f.Collate_ComboBox.Text;
  Table_Columns_StringGrid.Cells[ table_columns__column_number__default_c, row_f ] := table_column__modify_form_f.Default_Value_Edit.Text;
  Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, row_f ] := table_column__modify_form_f.Column_Name_Edit.Text;
  Table_Columns_StringGrid.Cells[ table_columns__column_number__type_c, row_f ] := table_column__modify_form_f.Column_Type_ComboBox.Text;


  if table_column__modify_form_f.Column_Position_CheckBox.Checked then
    table_column__modify_form_f.Column_Position_JvSpinEdit.Value;

end;

function TTable_Add_Form.Quotation_Sign__TA() : string;
begin

  if sql__quotation_sign__use__ta then
    begin

      Result := sql__quotation_sign__ta;

    end
  else
    Result := '';

end;

procedure TTable_Add_Form.Row_Position_Adjust( const row__current_f : integer; row__destinated_f : integer );
begin

  if row__destinated_f < 1 then
    row__destinated_f := 1
  else
    if row__destinated_f > Table_Columns_StringGrid.RowCount - 1 then
      row__destinated_f := Table_Columns_StringGrid.RowCount - 1;


  if   ( row__current_f = row__destinated_f )
    or ( row__destinated_f < 1 )
    or ( row__destinated_f > Table_Columns_StringGrid.RowCount - 1 ) then
    Exit;


  if row__current_f < row__destinated_f then
    Column__Move__Down_MenuItemClick( nil )
  else
    Column__Move__Up_MenuItemClick( nil );


  Row_Position_Adjust( Table_Columns_StringGrid.Row, row__destinated_f  );

end;

constructor TTable_Add_Form.Create( AOwner : TComponent; sdbm_f : Common.TSDBM );
begin

  inherited Create( AOwner );


  table_add_sdbm := Common.TSDBM.Create( sdbm_f );
  table_add_sdbm.Component_Type_Set( sdbm_f.component_type__sdbm, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );


  Translation.Translation__Apply( Self );

end;

procedure TTable_Add_Form.FormCreate( Sender: TObject );
begin

  database_type__ta := '';
  modified__ta := false;
  sql_prepared_correctly_g := false;
  table_name__ta := '';

end;

procedure TTable_Add_Form.FormShow( Sender: TObject );
var
  i : integer;

  zts : string;
begin

  PageControl1.ActivePage := Log_TabSheet;


  if Table_Columns_StringGrid.ColCount < 7 then
    Table_Columns_StringGrid.ColCount := 7;

  Table_Columns_StringGrid.RowCount := 2;

  for i := 1 to Table_Columns_StringGrid.ColCount - 1 do
    Table_Columns_StringGrid.Rows[ i ].Clear();

  Table_Columns_StringGrid.Cells[ 0, 0 ] := Translation.translation__messages_r.word__no_;
  Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, 0 ] := Translation.translation__messages_r.word__column__name;
    Table_Columns_StringGrid.ColWidths[ table_columns__column_number__name_c ] := 200;
  Table_Columns_StringGrid.Cells[ table_columns__column_number__type_c, 0 ] := Translation.translation__messages_r.word__type;
    Table_Columns_StringGrid.ColWidths[ table_columns__column_number__type_c ] := 100;
  Table_Columns_StringGrid.Cells[ table_columns__column_number__allow_nulls_c, 0 ] := Translation.translation__messages_r.word__allow_nulls;
  Table_Columns_StringGrid.Cells[ table_columns__column_number__default_c, 0 ] := Translation.translation__messages_r.word__default__value;
    Table_Columns_StringGrid.ColWidths[ table_columns__column_number__default_c ] := 100;
  Table_Columns_StringGrid.Cells[ table_columns__column_number__collation_c, 0 ] := Translation.translation__messages_r.word__collation__with_a_capital_letter;
    Table_Columns_StringGrid.ColWidths[ table_columns__column_number__collation_c ] := 100;
  Table_Columns_StringGrid.Cells[ table_columns__column_number__primary_key_c, 0 ] := Translation.translation__messages_r.word__primary_key;
    Table_Columns_StringGrid.ColWidths[ table_columns__column_number__primary_key_c ] := 80;



  sql__create_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__ta ) + Common.table_add__sql__table__create__file_name_c  );

  if Trim( sql__create_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ta ) + Common.table_add__sql__table__create__file_name_c + ').' );

      sql__create_g :=
        'create table __TABLE_NAME__ ' +
        '  ( ' +
        '__COLUMN_NAME__ ' +
        '__PRIMARY_KEY__ ' +
        '  ) ';

    end;



  sql__primary_key_g := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__ta ) + Common.table_add__sql__primary_key__file_name_c  );

  if Trim( sql__primary_key_g ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ta ) + Common.table_add__sql__primary_key__file_name_c + ').' );

      sql__primary_key_g :=
        #13 + '    , primary key ( __COLUMN_NAME__ )';

    end;



  zts := Common.Databases_Type__Directory_Path__Get( database_type__ta ) + Table_Column__Modify.table_column__modify__sql__column__collate__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ta ) + Table_Column__Modify.table_column__modify__sql__column__collate__file_name_c + ').' );

      word__collate__ta_g := ' collate ';

    end
  else
    begin

      word__collate__ta_g := Common.Text__File_Load( zts );

      word__collate__ta_g := StringReplace( word__collate__ta_g, #10, '', [] );
      word__collate__ta_g := StringReplace( word__collate__ta_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Collate: ' + word__collate__ta_g + '.' );



  zts := Common.Databases_Type__Directory_Path__Get( database_type__ta ) + Common.table_add__sql__column__columns_separator__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ta ) + Common.table_add__sql__column__columns_separator__file_name_c + ').' );

      word__columns_separator__ta_g := #13 + #10 + '    , ';

    end
  else
    begin

      word__columns_separator__ta_g := Common.Text__File_Load( zts );

      word__columns_separator__ta_g := StringReplace( word__columns_separator__ta_g, #10, '', [] );
      word__columns_separator__ta_g := StringReplace( word__columns_separator__ta_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Columns separator: ' + word__columns_separator__ta_g + '.' );



  zts := Common.Databases_Type__Directory_Path__Get( database_type__ta ) + Table_Column__Modify.table_column__modify__sql__column__default__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ta ) + Table_Column__Modify.table_column__modify__sql__column__default__file_name_c + ').' );

      word__default__ta_g := ' default ';

    end
  else
    begin

      word__default__ta_g := Common.Text__File_Load( zts );

      word__default__ta_g := StringReplace( word__default__ta_g, #10, '', [] );
      word__default__ta_g := StringReplace( word__default__ta_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Default: ' + word__default__ta_g + '.' );



  zts := Common.Databases_Type__Directory_Path__Get( database_type__ta ) + Table_Column__Modify.table_column__modify__sql__column__not_null__file_name_c;

  if not FileExists( zts ) then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__ta ) + Table_Column__Modify.table_column__modify__sql__column__not_null__file_name_c + ').' );

      word__not_null__ta_g := ' not null ';

    end
  else
    begin

      word__not_null__ta_g := Common.Text__File_Load( zts );

      word__not_null__ta_g := StringReplace( word__not_null__ta_g, #10, '', [] );
      word__not_null__ta_g := StringReplace( word__not_null__ta_g, #13, '', [] );

    end;

  Log_Memo.Lines.Add( 'Not null: ' + word__not_null__ta_g + '.' );


  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Sql_Memo.Font, Common.sql_editor__font );

end;

procedure TTable_Add_Form.FormDestroy( Sender: TObject );
begin

  if table_add_sdbm <> nil then
    FreeAndNil( table_add_sdbm );

end;

procedure TTable_Add_Form.Column__Add_MenuItemClick( Sender: TObject );
var
  modal_result : TModalResult;
begin

  Table_Column__Modify.Table_Column__Modify_Form := Table_Column__Modify.TTable_Column__Modify_Form.Create( Application, table_add_sdbm );
  Table_Column__Modify.Table_Column__Modify_Form.database_type__tcm := database_type__ta;
  Table_Column__Modify.Table_Column__Modify_Form.from_table_add_tcm := true;

  if Trim( Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, 1 ] ) = '' then
    Table_Column__Modify.Table_Column__Modify_Form.Column_Position_JvSpinEdit.Value := Table_Columns_StringGrid.RowCount - 1
  else
    Table_Column__Modify.Table_Column__Modify_Form.Column_Position_JvSpinEdit.Value := Table_Columns_StringGrid.RowCount;

  modal_result := Table_Column__Modify.Table_Column__Modify_Form.ShowModal();

  if modal_result = mrOk then
    begin

      Grid_Values__Set( Table_Column__Modify.Table_Column__Modify_Form );

      Table_Columns_StringGrid.Row := Table_Columns_StringGrid.RowCount - 1;

      Row_Position_Adjust(  Table_Columns_StringGrid.Row, Round( Table_Column__Modify.Table_Column__Modify_Form.Column_Position_JvSpinEdit.Value )  );

    end;

  FreeAndNil( Table_Column__Modify.Table_Column__Modify_Form );

end;

procedure TTable_Add_Form.Column__Edit_MenuItemClick( Sender: TObject );
var
  modal_result : TModalResult;
begin

  if   ( Table_Columns_StringGrid.Row < 1 )
    or (  Trim( Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, 1 ] ) = ''  ) then
    Exit;


  Table_Column__Modify.Table_Column__Modify_Form := Table_Column__Modify.TTable_Column__Modify_Form.Create( Application, table_add_sdbm );
  Table_Column__Modify.Table_Column__Modify_Form.database_type__tcm := database_type__ta;
  Table_Column__Modify.Table_Column__Modify_Form.from_table_add_tcm := true;
  Table_Column__Modify.Table_Column__Modify_Form.Not_Null_CheckBox.Checked := Table_Columns_StringGrid.Cells[ table_columns__column_number__allow_nulls_c, Table_Columns_StringGrid.Row ] <> Common.db_grid__positive_value_c;
  Table_Column__Modify.Table_Column__Modify_Form.column_collate__tcm := Table_Columns_StringGrid.Cells[ table_columns__column_number__collation_c, Table_Columns_StringGrid.Row ];
  Table_Column__Modify.Table_Column__Modify_Form.Default_Value_Edit.Text := Table_Columns_StringGrid.Cells[ table_columns__column_number__default_c, Table_Columns_StringGrid.Row ];
  Table_Column__Modify.Table_Column__Modify_Form.Column_Name_Edit.Text := Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, Table_Columns_StringGrid.Row ];
  Table_Column__Modify.Table_Column__Modify_Form.column_type__tcm := Table_Columns_StringGrid.Cells[ table_columns__column_number__type_c, Table_Columns_StringGrid.Row ];
  Table_Column__Modify.Table_Column__Modify_Form.Column_Position_JvSpinEdit.Value := Table_Columns_StringGrid.Row;
  modal_result := Table_Column__Modify.Table_Column__Modify_Form.ShowModal();

  if modal_result = mrOk then
    begin

      Grid_Values__Set( Table_Column__Modify.Table_Column__Modify_Form, Table_Columns_StringGrid.Row );

      Row_Position_Adjust(  Table_Columns_StringGrid.Row, Round( Table_Column__Modify.Table_Column__Modify_Form.Column_Position_JvSpinEdit.Value )  );

    end;

  FreeAndNil( Table_Column__Modify.Table_Column__Modify_Form );

end;

procedure TTable_Add_Form.Column__Delete_MenuItemClick( Sender: TObject );
var
  i : integer;
begin

  if   ( Table_Columns_StringGrid.Row < 1 )
    or (
             ( Table_Columns_StringGrid.RowCount = 2 )
         and (  Trim( Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, 1 ] ) = ''  )
       ) then
    Exit;


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_column + ' ''' + Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, Table_Columns_StringGrid.Row ] + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  for i := Table_Columns_StringGrid.Row to Table_Columns_StringGrid.RowCount - 2 do
    begin

      Table_Columns_StringGrid.Rows[ i ] := Table_Columns_StringGrid.Rows[ i + 1 ];
      Table_Columns_StringGrid.Cells[ 0, i ] := Trim(  FormatFloat( '### ### ### ### ### ### ##0', i )  );

    end;


  if Table_Columns_StringGrid.RowCount > 2 then
    Table_Columns_StringGrid.RowCount := Table_Columns_StringGrid.RowCount - 1
  else
    Table_Columns_StringGrid.Rows[ 1 ].Clear();

end;

procedure TTable_Add_Form.Primary_Key__Set_MenuItemClick( Sender: TObject );
begin

  if   ( Table_Columns_StringGrid.Row < 1 )
    or (  Trim( Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, 1 ] ) = ''  ) then
    Exit;


  Primary_Key__Delete_MenuItemClick( Sender );

  Table_Columns_StringGrid.Cells[ table_columns__column_number__primary_key_c, Table_Columns_StringGrid.Row ] := Common.db_grid__positive_value_c;

end;

procedure TTable_Add_Form.Primary_Key__Delete_MenuItemClick( Sender: TObject );
var
  i : integer;
begin

  for i := 1 to Table_Columns_StringGrid.RowCount - 1 do
    Table_Columns_StringGrid.Cells[ table_columns__column_number__primary_key_c, i ] := '';

end;

procedure TTable_Add_Form.Column__Move__Up_MenuItemClick( Sender: TObject );
begin

  if   ( Table_Columns_StringGrid.Row < 2 )
    or (  Trim( Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, 1 ] ) = ''  ) then
    Exit;


  Table_Columns_StringGrid.RowCount := Table_Columns_StringGrid.RowCount + 1;


  Table_Columns_StringGrid.Rows[ Table_Columns_StringGrid.RowCount - 1 ] := Table_Columns_StringGrid.Rows[ Table_Columns_StringGrid.Row - 1 ];
  Table_Columns_StringGrid.Rows[ Table_Columns_StringGrid.Row - 1 ] := Table_Columns_StringGrid.Rows[ Table_Columns_StringGrid.Row ];
  Table_Columns_StringGrid.Rows[ Table_Columns_StringGrid.Row ] := Table_Columns_StringGrid.Rows[ Table_Columns_StringGrid.RowCount - 1 ];

  Table_Columns_StringGrid.Cells[ 0, Table_Columns_StringGrid.Row ] := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Table_Columns_StringGrid.Row )  );
  Table_Columns_StringGrid.Cells[ 0, Table_Columns_StringGrid.Row - 1 ] := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Table_Columns_StringGrid.Row - 1 )  );


  Table_Columns_StringGrid.RowCount := Table_Columns_StringGrid.RowCount - 1;


  Table_Columns_StringGrid.Row := Table_Columns_StringGrid.Row - 1;

end;

procedure TTable_Add_Form.Column__Move__Down_MenuItemClick( Sender: TObject );
begin

  if   ( Table_Columns_StringGrid.Row < 1 )
    or ( Table_Columns_StringGrid.Row >= Table_Columns_StringGrid.RowCount - 1 )
    or (  Trim( Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, 1 ] ) = ''  ) then
    Exit;


  Table_Columns_StringGrid.RowCount := Table_Columns_StringGrid.RowCount + 1;


  Table_Columns_StringGrid.Rows[ Table_Columns_StringGrid.RowCount - 1 ] := Table_Columns_StringGrid.Rows[ Table_Columns_StringGrid.Row + 1 ];
  Table_Columns_StringGrid.Rows[ Table_Columns_StringGrid.Row + 1 ] := Table_Columns_StringGrid.Rows[ Table_Columns_StringGrid.Row ];
  Table_Columns_StringGrid.Rows[ Table_Columns_StringGrid.Row ] := Table_Columns_StringGrid.Rows[ Table_Columns_StringGrid.RowCount - 1 ];

  Table_Columns_StringGrid.Cells[ 0, Table_Columns_StringGrid.Row ] := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Table_Columns_StringGrid.Row )  );
  Table_Columns_StringGrid.Cells[ 0, Table_Columns_StringGrid.Row + 1 ] := Trim(  FormatFloat( '### ### ### ### ### ### ##0', Table_Columns_StringGrid.Row + 1 )  );


  Table_Columns_StringGrid.RowCount := Table_Columns_StringGrid.RowCount - 1;


  Table_Columns_StringGrid.Row := Table_Columns_StringGrid.Row + 1;

end;

procedure TTable_Add_Form.Sql_Prepare_ButtonClick( Sender: TObject );
var
  i,
  j
    : integer;

  zts,
  columns_list_l,
  primary_key_l
    : string;
begin

  sql_prepared_correctly_g := false;


  if Trim( Table_Name_Edit.Text ) = '' then
    begin

      if Table_Name_Edit.Enabled then
        Table_Name_Edit.SetFocus();

      Application.MessageBox( PChar(Translation.translation__messages_r.table_name_should_not_be_empty), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  zts := '';

  for i := 1 to Table_Columns_StringGrid.RowCount - 1 do
    for j := i + 1 to Table_Columns_StringGrid.RowCount - 1 do
      if AnsiLowerCase( Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, i ] ) = AnsiLowerCase( Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, j ] ) then
        begin

          if zts <> '' then
            zts := zts + #13;

          zts := zts + Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, i ] + ' ' + Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, j ];

        end;


  if Trim( zts ) <> '' then
    begin

      if Application.MessageBox( PChar(Translation.translation__messages_r.column_names_should_be_unique + #13 + #13 + zts + #13 + #13 + Translation.translation__messages_r.continue_), PChar(Translation.translation__messages_r.warning), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> ID_YES then
        Exit;

    end;



  PageControl1.ActivePage := Sql_TabSheet;


  columns_list_l := '';
  primary_key_l := '';

  for i := 1 to Table_Columns_StringGrid.RowCount - 1 do
    if Trim( Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, i ] ) <> '' then
      begin

        if columns_list_l <> '' then
          columns_list_l := columns_list_l +
            word__columns_separator__ta_g;


        columns_list_l := columns_list_l +
          Self.Quotation_Sign__TA() + Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, i ] + Self.Quotation_Sign__TA() +
          ' ' + Table_Columns_StringGrid.Cells[ table_columns__column_number__type_c, i ];

        if Table_Columns_StringGrid.Cells[ table_columns__column_number__default_c, i ] <> '' then
          columns_list_l := columns_list_l +
            word__default__ta_g + Table_Columns_StringGrid.Cells[ table_columns__column_number__default_c, i ];

        if Table_Columns_StringGrid.Cells[ table_columns__column_number__allow_nulls_c, i ] <> Common.db_grid__positive_value_c then
          columns_list_l := columns_list_l +
            word__not_null__ta_g;

        if Table_Columns_StringGrid.Cells[ table_columns__column_number__collation_c, i ] <> '' then
          columns_list_l := columns_list_l +
             word__collate__ta_g + Table_Columns_StringGrid.Cells[ table_columns__column_number__collation_c, i ];


        if Table_Columns_StringGrid.Cells[ table_columns__column_number__primary_key_c, i ] = Common.db_grid__positive_value_c then
          primary_key_l := StringReplace( sql__primary_key_g, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TA() + Table_Columns_StringGrid.Cells[ table_columns__column_number__name_c, i ] + Self.Quotation_Sign__TA(), [ rfReplaceAll ] );

      end;


  zts := sql__create_g;

  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TA() + Table_Name_Edit.Text + Self.Quotation_Sign__TA(), [ rfReplaceAll ] );
  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, columns_list_l, [ rfReplaceAll ] );
  zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.table_add__primary_key_c + Common.sql__word_replace_separator_c, primary_key_l, [ rfReplaceAll ] );


  Sql_Memo.Lines.Clear();
  Sql_Memo.Lines.Add( zts );


  sql_prepared_correctly_g := true;

end;

procedure TTable_Add_Form.Execute_ButtonClick( Sender: TObject );
var
  ztb : boolean;

  error_message_l : string;
begin

  if table_add_sdbm = nil then
    Exit;


  sql_prepared_correctly_g := false;


  if Execute_Button_Works_As_Prepare_Execute_CheckBox.Checked then
    begin

      Sql_Prepare_ButtonClick( Sender );

      if not sql_prepared_correctly_g then
        Exit;

      sql_prepared_correctly_g := false;

    end;


  ztb := table_add_sdbm.Sql_Command_Execute( Sql_Memo.Lines.Text, error_message_l, Translation.translation__messages_r.failed_to_create_table, false );


  if ztb then
    begin

      if not modified__ta then
        modified__ta := true;


      if Table_Name_Edit.Enabled then
        table_name__ta := Table_Name_Edit.Text;


      Log_Memo.Lines.Add( table_add_sdbm.Operation_Duration_Get() );

      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TTable_Add_Form.Table_Columns_StringGridDrawCell( Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState );
begin

  if    ( ACol in [ table_columns__column_number__allow_nulls_c ] )
    and ( ARow > 0 )
    and (  Trim( TStringGrid(Sender).Cells[ table_columns__column_number__allow_nulls_c, ARow ] ) <> ''  ) then
    begin

      if TStringGrid(Sender).Cells[ table_columns__column_number__allow_nulls_c, ARow ] = Common.db_grid__positive_value_c then
        TStringGrid(Sender).Canvas.Brush.Color := clInfoBk;

      TStringGrid(Sender).Canvas.FillRect( Rect );
      TStringGrid(Sender).Canvas.TextOut(   Rect.Left + 2, Rect.Top + Round( Rect.Height * 0.5 ) - Round(  TStringGrid(Sender).Canvas.TextHeight( 'I' ) * 0.5  ), TStringGrid(Sender).Cells[ ACol, ARow ]   );

    end;


  if    ( ACol in [ table_columns__column_number__primary_key_c ] )
    and ( ARow > 0 )
    and (  Trim( TStringGrid(Sender).Cells[ table_columns__column_number__primary_key_c, ARow ] ) <> ''  ) then
    begin

      if TStringGrid(Sender).Cells[ table_columns__column_number__primary_key_c, ARow ] = Common.db_grid__positive_value_c then
        TStringGrid(Sender).Canvas.Brush.Color := clMoneyGreen;

      TStringGrid(Sender).Canvas.FillRect( Rect );
      TStringGrid(Sender).Canvas.TextOut(   Rect.Left + 2, Rect.Top + Round( Rect.Height * 0.5 ) - Round(  TStringGrid(Sender).Canvas.TextHeight( 'I' ) * 0.5  ), TStringGrid(Sender).Cells[ ACol, ARow ]   );

    end;

end;

procedure TTable_Add_Form.Table_Columns_StringGridKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_DELETE then
    Column__Delete_MenuItemClick( Sender )
  else
  if Key = VK_INSERT then
    Column__Add_MenuItemClick( Sender )
  else
  if Key = VK_RETURN then
    Column__Edit_MenuItemClick( Sender )
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Table_Columns_StringGrid.Cells[ Table_Columns_StringGrid.Col, Table_Columns_StringGrid.Row ];
    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end;

end;

procedure TTable_Add_Form.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TTable_Add_Form.Sql_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Sql_Memo.SelectAll();

end;

end.
