unit Dependencies_F;{10.Sie.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TNode_Data_r = record
    id_node__nd,
    id_search_nd,
    depended_on__type__nd,
    dependent__type__nd
      : integer;

    name__nd,
    depended_on__description__nd,
    dependent__description__nd,
    etiquette___nd
      : string;
  end;

  TNode_Data_r_wsk = ^TNode_Data_r;

  TDependencies_F_Frame = class( TFrame )
    Left_Panel: TPanel;
    Buttons_Panel__Hide_Button: TButton;
    Log_Memo: TMemo;
    Vertical_Splitter: TSplitter;
    Log_Horizontal_Splitter: TSplitter;
    Refresh_Button: TButton;
    Table_Description_Panel: TPanel;
    Buttons_Panel: TPanel;
    Dependencies_TreeView: TTreeView;
    Dependencies_Type_RadioGroup: TRadioGroup;
    Nodes__Expand_Button: TButton;
    Nodes__Collapse_Button: TButton;
    Dependencies_Description_GroupBox: TGroupBox;
    Dependencies_Description_Memo: TMemo;
    Dependencies_Description_Memo_Horizontal_Splitter: TSplitter;
    Search_GroupBox: TGroupBox;
    Search_Edit: TEdit;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Prior_Button: TButton;
    Search__Next_Button: TButton;
    Search__Set_Focus_CheckBox: TCheckBox;

    procedure Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );

    procedure Refresh_ButtonClick( Sender: TObject );
    procedure Buttons_Panel__Hide_ButtonClick( Sender: TObject );
    procedure Nodes__Expand_ButtonClick( Sender: TObject );
    procedure Nodes__Collapse_ButtonClick( Sender: TObject );

    procedure Search_Change( Sender: TObject );
    procedure Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Search__Next_ButtonClick( Sender: TObject );
    procedure Search__Prior_ButtonClick( Sender: TObject );

    procedure Dependencies_TreeViewClick( Sender: TObject );
    procedure Dependencies_TreeViewChange( Sender: TObject; Node: TTreeNode );
    procedure Dependencies_TreeViewKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Dependencies_Description_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
  private
    { Private declarations }
    values_logged__depended_on_g, // Values log only once.
    values_logged__dependent_g // Values log only once.
      : boolean;

    id_search_g : integer;

    database_type__df_g,
    table_name__df_g
      : string;

    dependencies_sdbm : Common.TSDBM;

    function Search__Check( value_f : string ) : boolean;
    procedure Search__Notification_Clear();
  public
    { Public declarations }
    parent_supreme_tab_sheet : Vcl.Controls.TWinControl;

    procedure Data_Open__DF();
    procedure Finish__DF();
    procedure Highlight__Font__Set__DF();
    procedure Options_Set__DF( const component_type_f : Common.TComponent_Type );
    procedure Parent_Tab_Switch( const prior_f : boolean = false );
    procedure Prepare__DF( const table_name_f, database_type_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection );
    procedure Translation__Apply__DF();
    procedure Tree_Nodes_Dispose();
  end;

const
  notification__sign__found_c : string = '--> ';

implementation

uses
  Vcl.Clipbrd,

  Shared,
  Translation;

{$R *.dfm}

procedure TDependencies_F_Frame.Data_Open__DF();

  procedure Node_Data__Set( node_data_r_wsk_f : TNode_Data_r_wsk );

    function Translation__Apply__L( const name_f : string ) : string;
    begin

      if AnsiUpperCase( name_f ) = 'CHECK CONSTRAINT' then
        begin

          Result := Translation.translation__messages_r.word__check_constraint;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'COLLATION' then
        begin

          Result := Translation.translation__messages_r.word__collation;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'COLUMN' then
        begin

          Result := Translation.translation__messages_r.word__column;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'COMPUTED COLUMN' then
        begin

          Result := Translation.translation__messages_r.word__computed_column;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'EXCEPTION' then
        begin

          Result := Translation.translation__messages_r.word__exception;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'GENERATOR (SEQUENCE)' then
        begin

          Result := Translation.translation__messages_r.word__generator__sequence_;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'INDEX' then
        begin

          Result := Translation.translation__messages_r.word__index;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'INDEX EXPRESSION' then
        begin

          Result := Translation.translation__messages_r.word__index__expression;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'PACKAGE BODY' then
        begin

          Result := Translation.translation__messages_r.word__package__body;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'PACKAGE HEADER' then
        begin

          Result := Translation.translation__messages_r.word__package__header;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'PROCEDURE' then
        begin

          Result := Translation.translation__messages_r.word__procedure;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'PROCEDURE (OR ITS PARAMETER(S))' then
        begin

          Result := Translation.translation__messages_r.word__procedure___or_its_parameter_s__;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'STORED FUNCTION' then
        begin

          Result := Translation.translation__messages_r.word__stored_function;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'TABLE' then
        begin

          Result := Translation.translation__messages_r.word__table;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'TABLE (OR A COLUMN IN IT)' then
        begin

          Result := Translation.translation__messages_r.word__table___or_a_column_in_it_;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'TRIGGER' then
        begin

          Result := Translation.translation__messages_r.word__trigger;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'USER' then
        begin

          Result := Translation.translation__messages_r.word__user;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'UDF OR STORED FUNCTION' then
        begin

          Result := Translation.translation__messages_r.word__udf_or_stored_function;
          Exit;

        end
      else
      if AnsiUpperCase( name_f ) = 'VIEW' then
        begin

          Result := Translation.translation__messages_r.word__view;
          Exit;

        end
      else
        Result := name_f;

    end;

  begin

    inc( id_search_g );

    node_data_r_wsk_f.id_search_nd := id_search_g;
    node_data_r_wsk_f.depended_on__type__nd := dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__depended_on__type_c ).AsInteger;
    node_data_r_wsk_f.depended_on__description__nd := dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__depended_on__type_name_c ).AsString;
    node_data_r_wsk_f.dependent__type__nd := dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__dependent__type_c ).AsInteger;
    node_data_r_wsk_f.dependent__description__nd := dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__dependent__type_name_c ).AsString;

    if Dependencies_Type_RadioGroup.ItemIndex = 0 then // Dependent objects.
      begin

        node_data_r_wsk_f.etiquette___nd := dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__dependent__type_name_c ).AsString;
        node_data_r_wsk_f.name__nd := Trim(  dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__dependent__name_c ).AsString  ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

      end
    else
      begin

        node_data_r_wsk_f.etiquette___nd := dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__depended_on__type_name_c ).AsString;
        node_data_r_wsk_f.name__nd := Trim(  dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__depended_on__name_c ).AsString  ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

      end;


    node_data_r_wsk_f.etiquette___nd := node_data_r_wsk_f.name__nd + ' - ' + Translation__Apply__L( node_data_r_wsk_f.etiquette___nd );

  end;

  procedure Tree_Node_Add( node_data_r_wsk_f : TNode_Data_r_wsk; id_node_parent_f : integer = -99 );
  var
    i_l : integer;
    zt_tree_node : TTreeNode;
  begin

    if node_data_r_wsk_f = nil then
      Exit;


    if id_node_parent_f <> -99 then
      for i_l := 0 to Dependencies_TreeView.Items.Count - 1 do
        if    ( Dependencies_TreeView.Items[ i_l ].Data <> nil )
          and ( id_node_parent_f = TNode_Data_r_wsk(Dependencies_TreeView.Items[ i_l ].Data).id_node__nd ) then
          begin

            zt_tree_node := Dependencies_TreeView.Items.AddChildObject(  Dependencies_TreeView.Items[ i_l ], node_data_r_wsk_f.name__nd, node_data_r_wsk_f  );
            zt_tree_node.StateIndex := 1;

            Exit;

          end;


    zt_tree_node := Dependencies_TreeView.Items.AddObject( nil, node_data_r_wsk_f.etiquette___nd, node_data_r_wsk_f );
    zt_tree_node.StateIndex := 0;

  end;

var
  zti,
  dependencies_count_l
    : integer;

  zts : string;

  root_none_string_list : TStringList; // Dependence objects with no 'root' - the column Common.dependencies_list__column__field_name_c is never null.

  node_data_r_wsk_l : TNode_Data_r_wsk;
begin

  if   ( dependencies_sdbm = nil )
    or ( dependencies_sdbm.component_type__sdbm = Common.ct_none ) then
    Exit;


  id_search_g := 0;


  Tree_Nodes_Dispose();


  if Dependencies_Type_RadioGroup.ItemIndex = 0 then // Dependent objects.
    zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__df_g ) + Common.dependencies_list__depended_on__file_name_c  )
  else
    zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( database_type__df_g ) + Common.dependencies_list__dependent__file_name_c  );


  if Trim( zts ) = '' then
    begin

      if Dependencies_Type_RadioGroup.ItemIndex = 0 then // Dependent objects.
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__df_g ) + Common.dependencies_list__depended_on__file_name_c + ').' );

          zts := Common.dependencies_list__depended_on__sql_c;

        end
      else
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( database_type__df_g ) + Common.dependencies_list__dependent__file_name_c + ').' );

          zts := Common.dependencies_list__dependent__sql_c;

        end;

    end;


  dependencies_sdbm.Query__Sql__Set( zts );


  if   (
             ( Dependencies_Type_RadioGroup.ItemIndex = 0 ) // Dependent objects.
         and ( not values_logged__dependent_g )
       )
    or (
             ( Dependencies_Type_RadioGroup.ItemIndex = 1 ) // Depended on objects.
         and ( not values_logged__depended_on_g )
       ) then
    Log_Memo.Lines.Add( zts );


  dependencies_sdbm.Query__Param_By_Name__Set( Common.name__table__small_letters_c, table_name__df_g, Log_Memo );

  try
    dependencies_sdbm.Query__Open();
  except
    on E : Exception do
      begin

        Screen.Cursor := crDefault;

        Log_Memo.Lines.Add( E.Message );

        Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_load_dependencies_list + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

      end;
  end;

  if dependencies_sdbm.Query__Active() then
    begin

      Log_Memo.Lines.Add( dependencies_sdbm.Operation_Duration_Get() );


      try
        dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__depended_on__name_c ).AsString;
        dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__depended_on__type_c ).AsString;
        dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__depended_on__type_name_c ).AsString;
        dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__dependent__name_c ).AsString;
        dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__dependent__type_c ).AsString;
        dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__dependent__type_name_c ).AsString;
        dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__field_name_c ).AsString;
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            dependencies_sdbm.Query__Close();

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_dependencies_names + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;


      if dependencies_sdbm.Query__Active() then
        begin

          root_none_string_list := TStringList.Create();


          while not dependencies_sdbm.Query__Eof() do
            begin

              if dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__field_name_c ).IsNull then
                begin

                  if not root_none_string_list.Find( dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__dependent__name_c ).AsString, zti ) then
                    begin

                      root_none_string_list.Add(  dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__dependent__name_c ).AsString  );
                      root_none_string_list.Sort();

                    end;

                end;


              dependencies_sdbm.Query__Next();

            end;


          dependencies_count_l := 0;

          dependencies_sdbm.Query__First();

          while not dependencies_sdbm.Query__Eof() do
            begin

              if not dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__field_name_c ).IsNull then
                begin

                  if not root_none_string_list.Find( dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__dependent__name_c ).AsString, zti ) then
                    zti := 0
                  else
                    zti := 1;

                  if zti = 0 then
                    begin

                      root_none_string_list.Add(  dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__dependent__name_c ).AsString  );
                      root_none_string_list.Sort();

                      inc( dependencies_count_l );


                      New( node_data_r_wsk_l );

                      node_data_r_wsk_l.id_node__nd := dependencies_count_l;
                      Node_Data__Set( node_data_r_wsk_l );

                      Tree_Node_Add( node_data_r_wsk_l );

                    end;

                end;



              New( node_data_r_wsk_l );

              Node_Data__Set( node_data_r_wsk_l );


              if dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__field_name_c ).IsNull then
                begin

                  inc( dependencies_count_l );


                  node_data_r_wsk_l.id_node__nd := dependencies_count_l;

                  Tree_Node_Add( node_data_r_wsk_l );

                end
              else
                begin

                  node_data_r_wsk_l.id_node__nd := -99;
                  node_data_r_wsk_l.name__nd := Trim(  dependencies_sdbm.Query__Field_By_Name( Common.dependencies_list__column__field_name_c ).AsString  ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.


                  Tree_Node_Add( node_data_r_wsk_l, dependencies_count_l );

                end;


              dependencies_sdbm.Query__Next();

            end;


          root_none_string_list.Clear();
          FreeAndNil( root_none_string_list );

        end;


      dependencies_sdbm.Query__Close();

    end;


  if dependencies_sdbm.Query__Active() then
    dependencies_sdbm.Query__Close();


  id_search_g := -1;


  if    ( Dependencies_Type_RadioGroup.ItemIndex = 0 ) // Dependent objects.
    and ( not values_logged__dependent_g ) then
    values_logged__dependent_g := true
  else
    if    ( Dependencies_Type_RadioGroup.ItemIndex = 1 ) // Depended on objects.
      and ( not values_logged__depended_on_g ) then
    values_logged__depended_on_g := true;


  Log_Memo.Lines.Add(   Translation.translation__messages_r.dependencies__nodes_ + ' ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', dependencies_count_l )  ) + '.'   );
  Log_Memo.Lines.Add(   Translation.translation__messages_r.dependencies__items_ + ' ' + Trim(  FormatFloat( '### ### ### ### ### ### ##0', Dependencies_TreeView.Items.Count - dependencies_count_l )  ) + '.'   );

end;

procedure TDependencies_F_Frame.Finish__DF();
begin

  Tree_Nodes_Dispose();


  FreeAndNil( dependencies_sdbm );

end;

procedure TDependencies_F_Frame.Highlight__Font__Set__DF();
begin

  Common.Font__Set( Dependencies_Description_Memo.Font, Common.sql_editor__font );
  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    Common.Font__Set( Dependencies_TreeView.Font, Common.sql_editor__font );

end;

procedure TDependencies_F_Frame.Key_Up_Common( Sender : TObject; var Key : Word; Shift : TShiftState );
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

procedure TDependencies_F_Frame.Options_Set__DF( const component_type_f : Common.TComponent_Type );
begin

  if dependencies_sdbm <> nil then
    begin

      dependencies_sdbm.Component_Type_Set( component_type_f, Common.fire_dac__fetch_options__mode, Common.fire_dac__fetch_options__record_count_mode, Common.fire_dac__fetch_options__rowset_size );

    end;


  Self.Translation__Apply__DF();

end;

procedure TDependencies_F_Frame.Parent_Tab_Switch( const prior_f : boolean = false );
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

procedure TDependencies_F_Frame.Prepare__DF( const table_name_f, database_type_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection );
begin

  Self.Name := '';

  id_search_g := -1;
  database_type__df_g := database_type_f;
  table_name__df_g := table_name_f;
  values_logged__depended_on_g := false;
  values_logged__dependent_g := false;


  Log_Memo.Lines.Add( table_name__df_g );


  Dependencies_Description_GroupBox.Height := 1;


  dependencies_sdbm := Common.TSDBM.Create( ado_connection_f, fd_connection_f );

  Self.Options_Set__DF( component_type_f );


  Highlight__Font__Set__DF();

end;

function TDependencies_F_Frame.Search__Check( value_f : string ) : boolean;
var
  search_text_l : string;
begin

  value_f := Common.Case_Insensitive_To_String( value_f, Search__Case_Insensitive_CheckBox.Checked );
  search_text_l := Common.Case_Insensitive_To_String( Search_Edit.Text, Search__Case_Insensitive_CheckBox.Checked );


  if not Search__Partial_Key_CheckBox.Checked then
    begin

      Result := search_text_l = value_f;

    end
  else
    begin

      Result := Pos( search_text_l, value_f ) > 0;

    end;

end;

procedure TDependencies_F_Frame.Search__Notification_Clear();
var
  i : integer;
begin

  for i := 0 to Dependencies_TreeView.Items.Count - 1 do
    if Pos( notification__sign__found_c, Dependencies_TreeView.Items.Item[ i ].Text ) = 1 then
      Dependencies_TreeView.Items.Item[ i ].Text := StringReplace( Dependencies_TreeView.Items.Item[ i ].Text, notification__sign__found_c, '', [] );

end;

procedure TDependencies_F_Frame.Translation__Apply__DF();
begin

  Translation.Translation__Apply( Self );

end;

procedure TDependencies_F_Frame.Tree_Nodes_Dispose();
var
  i : integer;
begin

  for i := Dependencies_TreeView.Items.Count - 1 downto 0 do
    if Dependencies_TreeView.Items.Item[ i ].Data <> nil then
      Dispose( TNode_Data_r_wsk(Dependencies_TreeView.Items.Item[ i ].Data) );

  Dependencies_TreeView.Items.Clear();

end;

procedure TDependencies_F_Frame.Refresh_ButtonClick( Sender: TObject );
begin

  Self.Data_Open__DF();

end;

procedure TDependencies_F_Frame.Buttons_Panel__Hide_ButtonClick( Sender: TObject );
begin

  Left_Panel.Width := 1;

end;

procedure TDependencies_F_Frame.Nodes__Expand_ButtonClick( Sender: TObject );
begin

  Dependencies_TreeView.FullExpand();

end;

procedure TDependencies_F_Frame.Nodes__Collapse_ButtonClick( Sender: TObject );
begin

  Dependencies_TreeView.FullCollapse();

end;

procedure TDependencies_F_Frame.Search_Change( Sender: TObject );
var
  i : integer;
begin

  id_search_g := -1;


  Search__Notification_Clear();

  Search_Edit.Color := Common.color__red__light_c;


  for i := 0 to Dependencies_TreeView.Items.Count - 1 do
    if    ( Dependencies_TreeView.Items.Item[ i ] <> nil )
      and ( Dependencies_TreeView.Items.Item[ i ].Data <> nil )
      and ( TNode_Data_r_wsk(Dependencies_TreeView.Items.Item[ i ].Data).id_search_nd > id_search_g )
      and (  Search__Check( TNode_Data_r_wsk(Dependencies_TreeView.Items.Item[ i ].Data).name__nd )  ) then
      begin

        id_search_g := TNode_Data_r_wsk(Dependencies_TreeView.Items.Item[ i ].Data).id_search_nd;

        Dependencies_TreeView.Items.Item[ i ].Text := notification__sign__found_c + Dependencies_TreeView.Items.Item[ i ].Text;

        Dependencies_TreeView.Selected := Dependencies_TreeView.Items.Item[ i ];

        Search_Edit.Color := clWindow;

        if Search__Set_Focus_CheckBox.Checked then
          Dependencies_TreeView.SetFocus();

        Break;

      end;

end;

procedure TDependencies_F_Frame.Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_PRIOR then
    Search__Prior_ButtonClick( Sender )
  else
  if Key = VK_NEXT then
    Search__Next_ButtonClick( Sender );

end;

procedure TDependencies_F_Frame.Search__Next_ButtonClick( Sender: TObject );
var
  found_l : boolean;

  i : integer;
begin

  found_l := false;

  Search__Notification_Clear();

  Search_Edit.Color := Common.color__red__light_c;


  for i := 0 to Dependencies_TreeView.Items.Count - 1 do
    if    ( Dependencies_TreeView.Items.Item[ i ] <> nil )
      and ( Dependencies_TreeView.Items.Item[ i ].Data <> nil )
      and ( TNode_Data_r_wsk(Dependencies_TreeView.Items.Item[ i ].Data).id_search_nd > id_search_g )
      and (  Search__Check( TNode_Data_r_wsk(Dependencies_TreeView.Items.Item[ i ].Data).name__nd )  ) then
      begin

        id_search_g := TNode_Data_r_wsk(Dependencies_TreeView.Items.Item[ i ].Data).id_search_nd;

        found_l := true;

        Dependencies_TreeView.Items.Item[ i ].Text := notification__sign__found_c + Dependencies_TreeView.Items.Item[ i ].Text;

        Dependencies_TreeView.Selected := Dependencies_TreeView.Items.Item[ i ];

        Search_Edit.Color := clWindow;

        if Search__Set_Focus_CheckBox.Checked then
          Dependencies_TreeView.SetFocus();

        Break;

      end;


  if not found_l then
    id_search_g := i + 1;

end;

procedure TDependencies_F_Frame.Search__Prior_ButtonClick( Sender: TObject );
var
  found_l : boolean;

  i : integer;
begin

  found_l := false;

  Search__Notification_Clear();

  Search_Edit.Color := Common.color__red__light_c;


  for i := Dependencies_TreeView.Items.Count - 1 downto 0 do
    if    ( Dependencies_TreeView.Items.Item[ i ] <> nil )
      and ( Dependencies_TreeView.Items.Item[ i ].Data <> nil )
      and ( TNode_Data_r_wsk(Dependencies_TreeView.Items.Item[ i ].Data).id_search_nd < id_search_g )
      and (  Search__Check( TNode_Data_r_wsk(Dependencies_TreeView.Items.Item[ i ].Data).name__nd )  ) then
      begin

        id_search_g := TNode_Data_r_wsk(Dependencies_TreeView.Items.Item[ i ].Data).id_search_nd;

        found_l := true;

        Dependencies_TreeView.Items.Item[ i ].Text := notification__sign__found_c + Dependencies_TreeView.Items.Item[ i ].Text;

        Dependencies_TreeView.Selected := Dependencies_TreeView.Items.Item[ i ];

        Search_Edit.Color := clWindow;

        if Search__Set_Focus_CheckBox.Checked then
          Dependencies_TreeView.SetFocus();

        Break;

      end;


  if not found_l then
    id_search_g := i;

end;

procedure TDependencies_F_Frame.Dependencies_TreeViewClick( Sender: TObject );
begin

  if    ( Dependencies_TreeView.Selected <> nil )
    and ( Dependencies_TreeView.Selected.Data <> nil ) then
    begin

      Dependencies_Description_Memo.Lines.Text :=
        Translation.translation__messages_r.word__name + '   ' + TNode_Data_r_wsk(Dependencies_TreeView.Selected.Data).name__nd +
        #13 + #10 +
        Translation.translation__messages_r.depended_on_type + '   (' + TNode_Data_r_wsk(Dependencies_TreeView.Selected.Data).depended_on__type__nd.ToString() + ')   ' + TNode_Data_r_wsk(Dependencies_TreeView.Selected.Data).depended_on__description__nd +
        #13 + #10 +
        Translation.translation__messages_r.depended_type +'    (' + TNode_Data_r_wsk(Dependencies_TreeView.Selected.Data).dependent__type__nd.ToString() + ')   ' + TNode_Data_r_wsk(Dependencies_TreeView.Selected.Data).dependent__description__nd;

      id_search_g := TNode_Data_r_wsk(Dependencies_TreeView.Selected.Data).id_search_nd;

    end;

end;

procedure TDependencies_F_Frame.Dependencies_TreeViewChange( Sender: TObject; Node: TTreeNode );
begin

  Dependencies_TreeViewClick( Sender );

end;

procedure TDependencies_F_Frame.Dependencies_TreeViewKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( Dependencies_TreeView.Selected <> nil )
    and ( Dependencies_TreeView.Selected.Data <> nil ) then
    Vcl.Clipbrd.Clipboard.AsText := TNode_Data_r_wsk(Dependencies_TreeView.Selected.Data).name__nd;

end;

procedure TDependencies_F_Frame.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TDependencies_F_Frame.Dependencies_Description_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Dependencies_Description_Memo.SelectAll();

end;

end.
