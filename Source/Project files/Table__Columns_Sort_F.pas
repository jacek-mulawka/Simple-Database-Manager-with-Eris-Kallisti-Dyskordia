unit Table__Columns_Sort_F;{09.Sie.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TTable__Data_Modify_F__Data_Close__TCSF_wsk = function() : boolean of object;

  TTable__Columns_Sort_F_Frame = class( TFrame )
    Buttons_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    Column__Move__Down_Button: TButton;
    Column__Move__Up_Button: TButton;
    Columns_Sort_ListView: TListView;
    Columns_Sort_Panel: TPanel;
    Execute_Button: TButton;
    Keyboard_Select_CheckBox: TCheckBox;
    Left_Panel: TPanel;
    Log_Horizontal_Splitter: TSplitter;
    Log_Memo: TMemo;
    Refresh_Button: TButton;
    Sort_Button: TButton;
    Vertical_Splitter: TSplitter;

    procedure Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );

    procedure Sort_ButtonClick( Sender: TObject );
    procedure Column__Move__Down_ButtonClick( Sender: TObject );
    procedure Column__Move__Up_ButtonClick( Sender: TObject );
    procedure Execute_ButtonClick( Sender: TObject );
    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );
    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Columns_Sort_ListViewCustomDrawItem( Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean );
    procedure Columns_Sort_ListViewDragDrop( Sender, Source: TObject; X, Y: Integer );
    procedure Columns_Sort_ListViewDragOver( Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean );
    procedure Columns_Sort_ListViewKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Columns_Sort_ListViewMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
    procedure Keyboard_Select_CheckBoxClick( Sender: TObject );
  private
    { Private declarations }
    sql__quotation_sign__use__tcsf_g : boolean;

    database_type__tcsf_g,
    sql__quotation_sign__tcsf_g,
    table_name__tcsf_g
      : string;

    selected_indexes_t_g : array of integer;

    columns_sort_sdbm : Common.TSDBM;

    table__data_modify_f__data_close__tcsf_wsk_g : TTable__Data_Modify_F__Data_Close__TCSF_wsk;

    procedure Column_Move( const up_f : boolean = false );
    procedure Positions_Number_Write();
    function Quotation_Sign__TCSF() : string;
    procedure Selected_Indexes___Forget_All();
    procedure Selected_Indexes___Remember( const index_f : integer );
  public
    { Public declarations }
    parent_supreme_tab_sheet : Vcl.Controls.TWinControl;

    procedure Data_Open__TCSF();
    procedure Finish__TCSF();
    procedure Highlight__Font__Set__TCSF();
    procedure Options_Set__TCSF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
    procedure Parent_Tab_Switch( const prior_f : boolean = false );
    procedure Prepare__TCSF( const table_name_f, database_type_f, sql__quotation_sign_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean; table__data_modify_f__data_close__tcsf_wsk_f : TTable__Data_Modify_F__Data_Close__TCSF_wsk );
    procedure Translation__Apply__TCSF();
  end;

implementation

uses
  Shared,
  Translation;

{$R *.dfm}

procedure TTable__Columns_Sort_F_Frame.Column_Move( const up_f : boolean = false );

  procedure Column_Move__One( const up_f_f : boolean = false );
  var
    current_index,
    step
      : integer;

    zt_list_item : TListItem;
  begin

    if   ( Columns_Sort_ListView.Selected = nil )
      or ( Columns_Sort_ListView.Items.Count < 2 ) then
      Exit;


    current_index := Columns_Sort_ListView.Selected.Index;

    if   (
               ( not up_f_f )
           and ( current_index > Columns_Sort_ListView.Items.Count - 2 )
         )
      or (
               ( up_f_f )
           and ( current_index < 1 )
         ) then
      Exit;


    if not up_f_f then
      step := 1
    else
      step := -1;


    Columns_Sort_ListView.Items.BeginUpdate();


    zt_list_item := TListItem.Create( Columns_Sort_ListView.Items );

    zt_list_item.Assign( Columns_Sort_ListView.Items.Item[ current_index ] );

    Columns_Sort_ListView.Items.Item[ current_index ].Assign( Columns_Sort_ListView.Items.Item[ current_index + step ] );
    Columns_Sort_ListView.Items.Item[ current_index + step ].Assign( zt_list_item );

    FreeAndNil( zt_list_item );


    Columns_Sort_ListView.Items.EndUpdate();


    Columns_Sort_ListView.Selected := nil;

    Columns_Sort_ListView.ItemIndex := current_index + step;

  end;

var
  selected_indexes_t_g__mode : boolean;

  i,
  zti
    : integer;

  selected_indexes_t : array of integer;
begin

  if Length( selected_indexes_t_g ) > 0 then
    begin

      selected_indexes_t_g__mode := true;


      Columns_Sort_ListView.Selected := nil;

      for i := 0 to Length( selected_indexes_t_g ) - 1 do
        Columns_Sort_ListView.Items[  selected_indexes_t_g[ i ]  ].Selected := true;

    end
  else
    selected_indexes_t_g__mode := false;


  if   ( Columns_Sort_ListView.Selected = nil )
    or ( Columns_Sort_ListView.Items.Count < 2 ) then
    Exit;


  SetLength( selected_indexes_t, 0 );


  for i := 0 to Columns_Sort_ListView.Items.Count - 1 do
    if Columns_Sort_ListView.Items[ i ].Selected then
      begin

        zti := Length( selected_indexes_t );
        SetLength( selected_indexes_t, zti + 1 );
        selected_indexes_t[ zti ] := i;

      end;


  if Length( selected_indexes_t ) <= 0 then
    Exit;


  if up_f then
    begin

      if selected_indexes_t[ 0 ] <= 0 then
        begin

          SetLength( selected_indexes_t, 0 );

          Exit;

        end;

    end
  else
    begin

      if selected_indexes_t[ Length( selected_indexes_t ) - 1 ] >= Columns_Sort_ListView.Items.Count - 1 then
        begin

          SetLength( selected_indexes_t, 0 );

          Exit;

        end;

    end;


  Columns_Sort_ListView.Selected := nil;


  if up_f then
    begin

      for i := 0 to Length( selected_indexes_t ) - 1 do
        begin

          Columns_Sort_ListView.Items[  selected_indexes_t[ i ]  ].Selected := true;

          Column_Move__One( up_f );

          selected_indexes_t[ i ] := selected_indexes_t[ i ] - 1;

          Columns_Sort_ListView.Selected := nil;

        end;

    end
  else
    begin

      for i := Length( selected_indexes_t ) - 1 downto 0 do
        begin

          Columns_Sort_ListView.Items[  selected_indexes_t[ i ]  ].Selected := true;

          Column_Move__One( up_f );

          selected_indexes_t[ i ] := selected_indexes_t[ i ] + 1;

          Columns_Sort_ListView.Selected := nil;

        end;

    end;


  for i := 0 to Length( selected_indexes_t ) - 1 do
    begin

      Columns_Sort_ListView.Items[  selected_indexes_t[ i ]  ].Selected := true;


      if selected_indexes_t_g__mode then
        selected_indexes_t_g[ i ] := selected_indexes_t[ i ];

    end;


  SetLength( selected_indexes_t, 0 );

end;

procedure TTable__Columns_Sort_F_Frame.Data_Open__TCSF();
var
  zts : string;
begin

  SetLength( selected_indexes_t_g, 0 );


  if   ( columns_sort_sdbm = nil )
    or ( columns_sort_sdbm.component_type__sdbm = Common.ct_none ) then
    Exit;


  Columns_Sort_ListView.Items.BeginUpdate();

  Columns_Sort_ListView.Items.Clear();

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tcsf_g ) + Common.table_columns_list__sql__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tcsf_g ) + Common.table_columns_list__sql__file_name_c + ').' );

      zts := Common.table_columns_list__sql_c;

    end;


  columns_sort_sdbm.Query__Sql__Set( zts );

  columns_sort_sdbm.Query__Param_By_Name__Set( Common.name__table__small_letters_c, table_name__tcsf_g, Log_Memo );

  try
    columns_sort_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_load_columns_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;

  if columns_sort_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( columns_sort_sdbm.Operation_Duration_Get() );


      try
        columns_sort_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString;
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            columns_sort_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_column_name + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;


      if columns_sort_sdbm.Query__Active() then
        begin

          while not columns_sort_sdbm.Query__Eof() do
            begin

              with Columns_Sort_ListView.Items.Add do
                begin

                  Caption := Trim(  columns_sort_sdbm.Query__Field_By_Name( Common.name__column__big_letters_c ).AsString  ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.
                  SubItems.Add( columns_sort_sdbm.Query__Record_Number().ToString() );

                end;


              columns_sort_sdbm.Query__Next();

            end;

        end;


      columns_sort_sdbm.Query__Close();

    end;


  Columns_Sort_ListView.Items.EndUpdate();


  if columns_sort_sdbm.Query__Active() then
    columns_sort_sdbm.Query__Close();

end;

procedure TTable__Columns_Sort_F_Frame.Finish__TCSF();
begin

  SetLength( selected_indexes_t_g, 0 );


  FreeAndNil( columns_sort_sdbm );

end;

procedure TTable__Columns_Sort_F_Frame.Highlight__Font__Set__TCSF();
begin

  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    Common.Font__Set( Columns_Sort_ListView.Font, Common.sql_editor__font );

end;

procedure TTable__Columns_Sort_F_Frame.Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );
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

procedure TTable__Columns_Sort_F_Frame.Options_Set__TCSF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
begin

  sql__quotation_sign__use__tcsf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__tcsf_g := sql__quotation_sign_f;


  if columns_sort_sdbm <> nil then
    begin

      columns_sort_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

    end;


  Self.Translation__Apply__TCSF();

end;

procedure TTable__Columns_Sort_F_Frame.Parent_Tab_Switch( const prior_f : boolean = false );
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

procedure TTable__Columns_Sort_F_Frame.Positions_Number_Write();
var
  i : integer;
begin

  for i := 0 to Columns_Sort_ListView.Items.Count - 1 do
    Columns_Sort_ListView.Items[ i ].SubItems[ 0 ] := IntToStr( i + 1 );

end;

procedure TTable__Columns_Sort_F_Frame.Prepare__TCSF( const table_name_f, database_type_f, sql__quotation_sign_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean; table__data_modify_f__data_close__tcsf_wsk_f : TTable__Data_Modify_F__Data_Close__TCSF_wsk );
begin

  Self.Name := '';

  database_type__tcsf_g := database_type_f;
  table_name__tcsf_g := table_name_f;
  table__data_modify_f__data_close__tcsf_wsk_g := table__data_modify_f__data_close__tcsf_wsk_f;


  Log_Memo.Lines.Add( table_name__tcsf_g );


  columns_sort_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Self.Options_Set__TCSF( component_type_f, sql__quotation_sign_f, sql__quotation_sign__use_f );


  Highlight__Font__Set__TCSF();

end;

function TTable__Columns_Sort_F_Frame.Quotation_Sign__TCSF() : string;
begin

  if sql__quotation_sign__use__tcsf_g then
    begin

      Result := sql__quotation_sign__tcsf_g;

    end
  else
    Result := '';

end;

procedure TTable__Columns_Sort_F_Frame.Selected_Indexes___Forget_All();
begin

  SetLength( selected_indexes_t_g, 0 );
  Columns_Sort_ListView.Repaint();

end;

procedure TTable__Columns_Sort_F_Frame.Selected_Indexes___Remember( const index_f : integer );
var
  ztb : boolean;

  i,
  zti
    : integer;
begin

  if not Keyboard_Select_CheckBox.Checked then
    Exit;


  ztb := false;

  for i := 0 to Length( selected_indexes_t_g ) - 1 do
    if selected_indexes_t_g[ i ] = index_f then
      begin

        ztb := true;
        zti := i;

        Break;

      end;


  if not ztb then
    begin

      i := Length( selected_indexes_t_g );
      SetLength( selected_indexes_t_g, i + 1 );
      selected_indexes_t_g[ i ] := index_f;

    end
  else
    begin

      for i := zti to Length( selected_indexes_t_g ) - 2 do
        selected_indexes_t_g[ i ] := selected_indexes_t_g[ i + 1 ];

      i := Length( selected_indexes_t_g );
      SetLength( selected_indexes_t_g, i - 1 );

    end;

end;

procedure TTable__Columns_Sort_F_Frame.Translation__Apply__TCSF();
begin

  Translation.Translation__Apply( Self );

end;

procedure TTable__Columns_Sort_F_Frame.Sort_ButtonClick( Sender: TObject );
begin

  Columns_Sort_ListView.SortType := stText;
  Columns_Sort_ListView.SortType := stNone;


  Positions_Number_Write();

end;

procedure TTable__Columns_Sort_F_Frame.Column__Move__Down_ButtonClick( Sender: TObject );
begin

  Column_Move();

end;

procedure TTable__Columns_Sort_F_Frame.Column__Move__Up_ButtonClick( Sender: TObject );
begin

  Column_Move( true );

end;

procedure TTable__Columns_Sort_F_Frame.Execute_ButtonClick( Sender: TObject );
var
  ztb,
  error_occurred
    : boolean;

  i : integer;

  zts,
  error_message_l,
  sql__position_set_l
    : string;
begin

  if    ( @table__data_modify_f__data_close__tcsf_wsk_g <> nil )
    and ( not table__data_modify_f__data_close__tcsf_wsk_g() ) then
    Exit; // If the dataset is open sorting the columns may cause errors (e.g. access violation).


  if Application.MessageBox( PChar(Translation.translation__messages_r.save_columns_positions__table + ' ''' + Self.Quotation_Sign__TCSF() + table_name__tcsf_g + Self.Quotation_Sign__TCSF() + ''')?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  error_occurred := false;


  sql__position_set_l := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__tcsf_g ) + Common.table_column__position_set__sql__file_name_c  );

  if Trim( sql__position_set_l ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__tcsf_g ) + Common.table_column__position_set__sql__file_name_c + ').' );

      sql__position_set_l := Common.table_column__position_set__sql_c;

    end
  else
    begin

      sql__position_set_l := StringReplace( sql__position_set_l, #10, '', [] );
      sql__position_set_l := StringReplace( sql__position_set_l, #13, '', [] );

    end;


  Log_Memo.Lines.BeginUpdate();


  for i := 0 to Columns_Sort_ListView.Items.Count - 1 do
    begin

      zts := sql__position_set_l;

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__column__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TCSF() + Columns_Sort_ListView.Items[ i ].Caption + Self.Quotation_Sign__TCSF(), [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__position_value_c + Common.sql__word_replace_separator_c, ( i + 1 ).ToString(), [ rfReplaceAll ] );
      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, Self.Quotation_Sign__TCSF() + table_name__tcsf_g + Self.Quotation_Sign__TCSF(), [ rfReplaceAll ] );

      Log_Memo.Lines.Add( zts );


      ztb := columns_sort_sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_set_the_column_position );


      if ztb then
        begin

          Log_Memo.Lines.Add( columns_sort_sdbm.Operation_Duration_Get() );

          Log_Memo.Lines.Add( ' - ' + Translation.translation__messages_r.word__done + '.' );

        end
      else
        begin

          if not error_occurred then
            error_occurred := true;


          if Trim( error_message_l ) <> '' then
            Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

        end;

    end;


  Log_Memo.Lines.EndUpdate();


  Refresh_ButtonClick( Sender );


  if not error_occurred then
    Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION )
  else
    Application.MessageBox( PChar(Translation.translation__messages_r.errors_were_encountered), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONEXCLAMATION );

end;

procedure TTable__Columns_Sort_F_Frame.Refresh_ButtonClick( Sender: TObject );
begin

  Self.Data_Open__TCSF();

end;

procedure TTable__Columns_Sort_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Left_Panel.Width := 1;

end;

procedure TTable__Columns_Sort_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TTable__Columns_Sort_F_Frame.Columns_Sort_ListViewCustomDrawItem( Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean );
var
  ztb : boolean;

  i : integer;
begin

  ztb := false;

  for i := 0 to Length( selected_indexes_t_g ) - 1 do
    if selected_indexes_t_g[ i ] = Item.Index then
      begin

        ztb := true;

        Break;

      end;


  if ztb then
    Columns_Sort_ListView.Canvas.Brush.Color := clSkyBlue
  else
    Columns_Sort_ListView.Canvas.Brush.Color := clWindow;

end;

procedure TTable__Columns_Sort_F_Frame.Columns_Sort_ListViewDragDrop( Sender, Source: TObject; X, Y: Integer );
var
  current_item_list_item,
  drag_item_list_item,
  drop_item_list_item,
  next_item_list_item
    : TListItem;
begin

  if Sender = Source then
    begin

      drop_item_list_item := TListView( Source ).GetItemAt( X, Y );
      current_item_list_item := TListView( Source ).Selected;

      while current_item_list_item <> nil do
        begin

          next_item_list_item := TListView( Source ).GetNextItem( current_item_list_item, SdAll, [ IsSelected ] );

          if drop_item_list_item = nil then
            drag_item_list_item := TListView( Source ).Items.Add()
          else
            drag_item_list_item := TListView( Source ).Items.Insert( drop_item_list_item.Index );

          drag_item_list_item.Assign( current_item_list_item );
          current_item_list_item.Free();
          current_item_list_item := next_item_list_item;

        end;


      Positions_Number_Write();

    end;

end;

procedure TTable__Columns_Sort_F_Frame.Columns_Sort_ListViewDragOver( Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean  );
begin

  Accept := Source = Columns_Sort_ListView;

end;

procedure TTable__Columns_Sort_F_Frame.Columns_Sort_ListViewKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // K.
  if    ( Key = 75 )
    and ( Shift = [ ssCtrl ] ) then
    Keyboard_Select_CheckBox.Checked := not Keyboard_Select_CheckBox.Checked
  else
  // R.
  if    ( Key = 82 )
    and ( Shift = [ ssCtrl ] ) then
    Refresh_ButtonClick( Sender )
  else
  if Key = VK_BACK then
    begin

      Key := 0;
      Selected_Indexes___Forget_All();

    end
  else
  if    ( Key = VK_UP )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Key := 0;
      Column__Move__Up_ButtonClick( Sender );

    end
  else
  if    ( Key = VK_DOWN )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Key := 0;
      Column__Move__Down_ButtonClick( Sender );

    end
  else
  if Key = VK_SPACE then
    begin

      Key := 0;
      Selected_Indexes___Remember( Columns_Sort_ListView.ItemIndex );

    end;

end;

procedure TTable__Columns_Sort_F_Frame.Columns_Sort_ListViewMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
var
  i : integer;
begin

  if    ( Keyboard_Select_CheckBox.Checked )
    and ( ssLeft in Shift )
    and (
             ( ssCtrl in Shift )
          or ( ssShift in Shift )
        ) then
    begin

      for i := 0 to Length( selected_indexes_t_g ) - 1 do
        Columns_Sort_ListView.Items[  selected_indexes_t_g[ i ]  ].Selected := true;

      SetLength( selected_indexes_t_g, 0 );


      for i := 0 to Columns_Sort_ListView.Items.Count - 1 do
        if Columns_Sort_ListView.Items[ i ].Selected then
          Selected_Indexes___Remember( i );

    end;

end;

procedure TTable__Columns_Sort_F_Frame.Keyboard_Select_CheckBoxClick( Sender: TObject );
begin

  if not Keyboard_Select_CheckBox.Checked then
    Selected_Indexes___Forget_All();

end;

end.
