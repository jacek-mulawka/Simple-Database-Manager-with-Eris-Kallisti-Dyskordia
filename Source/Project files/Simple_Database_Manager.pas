unit Simple_Database_Manager;{16.Cze.2023}

  //
  // MIT License
  //
  // Copyright (c) 2023 Jacek Mulawka
  //
  // j.mulawka@interia.pl
  //
  // https://github.com/jacek-mulawka
  //

interface

uses
  Common,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ExtCtrls, Vcl.StdCtrls, System.ImageList, Vcl.ImgList;

type
  TSimple_Database_Manager_Form = class( TForm )
    MainMenu1: TMainMenu;
    Options_MenuItem: TMenuItem;
    Help_MenuItem: TMenuItem;
    Help__About_MenuItem: TMenuItem;
    Help__Keyboard_Shortcuts_MenuItem: TMenuItem;
    Databases_List_ListBox: TListBox;
    Databases_Vertical_Splitter: TSplitter;
    Databases_MenuItem: TMenuItem;
    Databases__Hide_Show_Databases_MenuItem: TMenuItem;
    N1: TMenuItem;
    Databases__Add_MenuItem: TMenuItem;
    Databases__Edit_MenuItem: TMenuItem;
    Databases__Copy_MenuItem: TMenuItem;
    Databases__Delete_MenuItem: TMenuItem;
    N2: TMenuItem;
    Databases__Refresh_MenuItem: TMenuItem;
    N3: TMenuItem;
    Databases__Save_MenuItem: TMenuItem;
    N4: TMenuItem;
    Databases__Move__Up_MenuItem: TMenuItem;
    Databases__Move__Down_MenuItem: TMenuItem;
    N5: TMenuItem;
    Databases__Open_MenuItem: TMenuItem;
    Databases__Close__One_MenuItem: TMenuItem;
    Databases__Close__Selected_MenuItem: TMenuItem;
    Databases__Close__All_MenuItem: TMenuItem;
    N6: TMenuItem;
    Database__Backup_Restore_MenuItem: TMenuItem;
    N7: TMenuItem;
    Databases__Exit_MenuItem: TMenuItem;
    Window__Previous_MenuItem: TMenuItem;
    Window__Next_MenuItem: TMenuItem;
    Databases_List_PopupMenu: TPopupMenu;
    Databases__Hide_Show_Databases_2_MenuItem: TMenuItem;
    N8: TMenuItem;
    Databases__Add_2_MenuItem: TMenuItem;
    Databases__Edit_2_MenuItem: TMenuItem;
    Databases__Copy_2_MenuItem: TMenuItem;
    Databases__Delete_2_MenuItem: TMenuItem;
    N9: TMenuItem;
    Databases__Refresh_2_MenuItem: TMenuItem;
    N10: TMenuItem;
    Databases__Save_2_MenuItem: TMenuItem;
    N11: TMenuItem;
    Databases__Move__Up_2_MenuItem: TMenuItem;
    Databases__Move__Down_2_MenuItem: TMenuItem;
    N12: TMenuItem;
    Databases__Open_2_MenuItem: TMenuItem;
    Databases__Close__One_2_MenuItem: TMenuItem;
    Databases__Close__Selected_2_MenuItem: TMenuItem;
    Databases__Close__All_2_MenuItem: TMenuItem;
    N13: TMenuItem;
    Database__Backup_Restore_2_MenuItem: TMenuItem;
    N14: TMenuItem;
    Databases__Exit_2_MenuItem: TMenuItem;
    Database__Create_MenuItem: TMenuItem;
    Database__Create_2_MenuItem: TMenuItem;
    procedure FormShow( Sender: TObject );
    procedure FormClose( Sender: TObject; var Action: TCloseAction );

    procedure Options_MenuItemClick( Sender: TObject );
    procedure Help__About_MenuItemClick( Sender: TObject );
    procedure Databases__Hide_Show_Databases_MenuItemClick( Sender: TObject );
    procedure Help__Keyboard_Shortcuts_MenuItemClick( Sender: TObject );
    procedure Window__Previous_MenuItemClick( Sender: TObject );
    procedure Window__Next_MenuItemClick( Sender: TObject );
    procedure Databases__Add_MenuItemClick( Sender: TObject );
    procedure Databases__Edit_MenuItemClick( Sender: TObject );
    procedure Databases__Copy_MenuItemClick( Sender: TObject );
    procedure Databases__Refresh_MenuItemClick( Sender: TObject );
    procedure Databases__Save_MenuItemClick( Sender: TObject );
    procedure Databases__Delete_MenuItemClick( Sender: TObject );
    procedure Databases__Move__Up_MenuItemClick( Sender: TObject );
    procedure Databases__Move__Down_MenuItemClick( Sender: TObject );
    procedure Databases__Open_MenuItemClick( Sender: TObject );
    procedure Databases__Close__One_MenuItemClick( Sender: TObject );
    procedure Databases__Close__Selected_MenuItemClick( Sender: TObject );
    procedure Databases__Close__All_MenuItemClick( Sender: TObject );
    procedure Database__Backup_Restore_MenuItemClick( Sender: TObject );
    procedure Database__Create_MenuItemClick( Sender: TObject );
    procedure Databases__Exit_MenuItemClick( Sender: TObject );
    procedure Databases_List_ListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Databases_List_ListBoxDragDrop( Sender, Source: TObject; X, Y: Integer );
    procedure Databases_List_ListBoxDragOver( Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean );
  private
    { Private declarations }
    syn_edit_keystrokes_list_g : string;

    databases_r_t : array of Common.TDatabases_r;

    databases_list_box__width_default_g : integer;

    procedure Databases__Modified_Notification_Set( modified_f : boolean );
  public
    { Public declarations }
  end;

var
  Simple_Database_Manager_Form: TSimple_Database_Manager_Form;

implementation

uses
  FireDAC.Stan.Option,

  Xml.XMLDoc,
  Xml.XMLIntf,
  System.IOUtils,
  System.TypInfo,

  About,
  Database__Backup_Restore,
  Database__Create,
  Database__Modify,
  Database__List_Modify,
  Options,
  Shared,
  Translation;

{$R *.dfm}

procedure TSimple_Database_Manager_Form.Databases__Modified_Notification_Set( modified_f : boolean );
begin

  if    ( modified_f )
    and (  Pos( Common.notification__sign__modified_c, Databases_MenuItem.Caption ) <= 0  ) then
    Databases_MenuItem.Caption := Databases_MenuItem.Caption + Common.notification__sign__modified_c
  else
  if    ( not modified_f )
    and (  Pos( Common.notification__sign__modified_c, Databases_MenuItem.Caption ) > 0  ) then
    Databases_MenuItem.Caption := StringReplace( Databases_MenuItem.Caption, Common.notification__sign__modified_c, '', [ rfReplaceAll ] );

end;

procedure TSimple_Database_Manager_Form.FormShow( Sender: TObject );
begin

  Common.all_files_find__filter := '*.*';
  Common.csv_file__data_separator := ',';
  Common.csv_file__text_qualifier := '"';
  Common.database__backup_restore__quotation_sign := '"';
  Common.database__backup__application__file_path:= 'C:\Program Files\Firebird\gbak.exe';
  Common.database__correctness_check_text__backup := 'gbak:closing file, committing, and finishing.';
  Common.database__correctness_check_text__restore := 'gbak:finishing, closing, and going home';
  Common.database__backup__file_default_extension := '.fbk';
  Common.database__backup__file_name__suffix_default__item_index := 1;
  Common.database__create__application__file_path := 'C:\Program Files\Firebird\isql.exe';
  Common.database__file_default_extension := '.fdb';
  Common.exe__file_default_extension := '.exe';

  Common.fire_dac__fetch_options__mode := fmOnDemand;
  Common.fire_dac__fetch_options__record_count_mode := cmVisible;
  Common.fire_dac__fetch_options__rowset_size := 50;

  Common.form_view__additional_component_show := true;

  Common.language__selected := '';
  Common.log__auto_scroll__seconds := 5;
  Common.queries_open_in_background := true;
  Common.splitter_show := true;
  Common.sql_editor__code_completion_window__default__lines_in_window := 70;
  Common.sql_editor__code_completion_window__default__width := 800;
  Common.sql_editor__execute_automatic_detection := true;
  Common.sql_editor__transactions_automatic := true;
  Common.sql_editor__query_output_save_field_format__date := 'dd.mm.yyyy';
  Common.sql_editor__query_output_save_field_format__real_numbers := '0.##########';
  Common.sql_editor__query_output_save_field_format__separator__date_time := ' ';
  Common.sql_editor__query_output_save_field_format__separator__decimal := '.';
  Common.sql_editor__query_output_save_field_format__time := 'hh:mm:ss';
  Common.sql_editor__words_highlight__color__background := $0080DDFF; // Yellow / orange.
  Common.sql_editor__words_highlight__color__border := $00226DA8; // Brown.
  Common.sql__command_separator := ';';
  Common.sql__external_function__parameter_separator := ', ';
  Common.sql__names_separator := '.';
  Common.sql__quotation_sign__use := false;
  Common.sql__text_separator := '''';
  Common.sql__view__parameter_separator := #13 + #10 + '  , ';
  Common.system_tables_visible := false;
  Common.table__data_modify__editing__default_state := false;
  Common.text__search__history_save_to_file := true;
  Common.text__search__history_save_to_file__items_count := 40;
  Common.text__search__window__one_common := true;

  //Common.fd_connection__format_options__max_string_size := 32767;
  Common.table__data_modify__filter__height_keeper__top := 270;

  Common.sql_editor__font := Vcl.Graphics.TFont.Create();
  Common.Font__Set( Common.sql_editor__font, Self.Font );

  databases_list_box__width_default_g := Databases_List_ListBox.Width;


  Shared.Shared_DataModule := Shared.TShared_DataModule.Create( Application );


  Options.Options_Form := Options.TOptions_Form.Create( Application );
  Options.Options_Form.Load_Save_ButtonClick( Options.Options_Form.Load_Button );
  Options.Options_Form.Ok_ButtonClick( Options.Options_Form.Ok_Button );
  syn_edit_keystrokes_list_g := Options.Options_Form.Syn_Edit_Keystrokes_Get();
  FreeAndNil( Options.Options_Form );


  Databases__Refresh_MenuItemClick( Sender );


  Databases_List_ListBox.SetFocus();


  Translation.Translation__Apply( Self );

end;

procedure TSimple_Database_Manager_Form.FormClose( Sender: TObject; var Action: TCloseAction );
begin

  if Pos( '*', Databases_MenuItem.Caption ) > 0 then
    begin

      case Application.MessageBox( PChar(Translation.translation__messages_r.databases_list_changed__save_), PChar(Translation.translation__messages_r.confirmation), MB_YESNOCANCEL + MB_DEFBUTTON3 + MB_ICONQUESTION ) of
          IDYES : Databases__Save_MenuItemClick( Sender );

          IDCANCEL :
            begin

              Action := TCloseAction.caNone;
              Exit;

            end;
        end;

    end;


  Databases__Close__All_MenuItemClick( Sender );


  if Self.MDIChildCount > 0 then
    begin

      Action := TCloseAction.caNone;
      Exit;

    end;


  {$IFNDEF DEBUG}
  if Application.MessageBox( PChar(Translation.translation__messages_r.exit_), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    begin

      Action := TCloseAction.caNone;
      Exit;

    end;
  {$ENDIF}


  SetLength( databases_r_t, 0 );


  FreeAndNil( Shared.Shared_DataModule );

  FreeAndNil( Common.sql_editor__font );

end;

procedure TSimple_Database_Manager_Form.Options_MenuItemClick( Sender: TObject );
var
  i : integer;

  modal_result : TModalResult;

  syn_edit_keystrokes_list_l : string;
begin

  Options.Options_Form := Options.TOptions_Form.Create( Application );
  modal_result := Options.Options_Form.ShowModal();
  syn_edit_keystrokes_list_l := Options.Options_Form.Syn_Edit_Keystrokes_Get();
  FreeAndNil( Options.Options_Form );


  if modal_result = mrOk then
    begin

      for i := 0 to Self.MDIChildCount - 1  do
        if    ( Self.MDIChildren[ i ] is Database__Modify.TDatabase__Modify_Form )
          and ( Database__Modify.TDatabase__Modify_Form(Self.MDIChildren[ i ]).item_index_g = Databases_List_ListBox.ItemIndex ) then
          Database__Modify.TDatabase__Modify_Form(Self.MDIChildren[ i ]).Options_Set__DM();


      Translation.Translation__Apply( Self );

      syn_edit_keystrokes_list_g := syn_edit_keystrokes_list_l;

    end;

end;

procedure TSimple_Database_Manager_Form.Help__About_MenuItemClick( Sender: TObject );
begin

  About.About_Form := About.TAbout_Form.Create( Application );
  About.About_Form.ShowModal();
  FreeAndNil( About.About_Form );

end;

procedure TSimple_Database_Manager_Form.Databases__Hide_Show_Databases_MenuItemClick( Sender: TObject );
begin

  if Databases_List_ListBox.Width > 1 then
    Databases_List_ListBox.Width := 1
  else
    Databases_List_ListBox.Width := databases_list_box__width_default_g;

end;

procedure TSimple_Database_Manager_Form.Help__Keyboard_Shortcuts_MenuItemClick( Sender: TObject );
begin

  ShowMessage( Translation.translation__messages_r.help__keyboard_shortcuts + #13 + #10 + syn_edit_keystrokes_list_g );

end;

procedure TSimple_Database_Manager_Form.Window__Previous_MenuItemClick( Sender: TObject );
begin

  Self.Next();

end;

procedure TSimple_Database_Manager_Form.Window__Next_MenuItemClick( Sender: TObject );
begin

  Self.Previous();

end;

procedure TSimple_Database_Manager_Form.Databases__Add_MenuItemClick( Sender: TObject );
var
  zti : integer;
begin

  Database__List_Modify.Database__List_Modify_Form := Database__List_Modify.TDatabase__List_Modify_Form.Create( Application );
  Database__List_Modify.Database__List_Modify_Form.mode_add := true;

  if Database__List_Modify.Database__List_Modify_Form.ShowModal() = mrOk then
    begin

      zti := Length( databases_r_t );
      SetLength( databases_r_t, zti + 1 );

      databases_r_t[ zti ] := Database__List_Modify.Database__List_Modify_Form.databases_r__lm_g;


      Databases_List_ListBox.Items.Add( databases_r_t[ zti ].alias );

      if    ( Databases_List_ListBox.Items.Count > 0 )
        and ( zti >= 0 )
        and ( zti <= Databases_List_ListBox.Items.Count - 1 ) then
        Databases_List_ListBox.ItemIndex := zti;


      Databases__Modified_Notification_Set( true );

    end;

  FreeAndNil( Database__List_Modify.Database__List_Modify_Form );

end;

procedure TSimple_Database_Manager_Form.Databases__Edit_MenuItemClick( Sender: TObject );
var
  zti : integer;
begin

  if   ( Databases_List_ListBox.Items.Count <= 0 )
    or ( Databases_List_ListBox.ItemIndex < 0 )
    or ( Databases_List_ListBox.ItemIndex > Databases_List_ListBox.Items.Count - 1 ) then
    Exit;


  zti := Databases_List_ListBox.ItemIndex;


  Database__List_Modify.Database__List_Modify_Form := Database__List_Modify.TDatabase__List_Modify_Form.Create( Application );
  Database__List_Modify.Database__List_Modify_Form.databases_r__lm_g := databases_r_t[ zti ];

  if Database__List_Modify.Database__List_Modify_Form.ShowModal() = mrOk then
    begin

      databases_r_t[ zti ] := Database__List_Modify.Database__List_Modify_Form.databases_r__lm_g;


      Databases_List_ListBox.Items[ zti ] := databases_r_t[ zti ].alias;


      Databases__Modified_Notification_Set( true );

    end;

  FreeAndNil( Database__List_Modify.Database__List_Modify_Form );


  if    ( Databases_List_ListBox.Items.Count > 0 )
    and ( zti >= 0 )
    and ( zti <= Databases_List_ListBox.Items.Count - 1 ) then
    Databases_List_ListBox.ItemIndex := zti;

end;

procedure TSimple_Database_Manager_Form.Databases__Copy_MenuItemClick( Sender: TObject );
var
  zti : integer;
begin

  if   ( Databases_List_ListBox.Items.Count <= 0 )
    or ( Databases_List_ListBox.ItemIndex < 0 )
    or ( Databases_List_ListBox.ItemIndex > Databases_List_ListBox.Items.Count - 1 ) then
    Exit;


  zti := Databases_List_ListBox.ItemIndex;


  Database__List_Modify.Database__List_Modify_Form := Database__List_Modify.TDatabase__List_Modify_Form.Create( Application );
  //Database__List_Modify.Database__List_Modify_Form.mode_add := true;
  Database__List_Modify.Database__List_Modify_Form.databases_r__lm_g := databases_r_t[ zti ];

  if Database__List_Modify.Database__List_Modify_Form.ShowModal() = mrOk then
    begin

      zti := Length( databases_r_t );
      SetLength( databases_r_t, zti + 1 );

      databases_r_t[ zti ] := Database__List_Modify.Database__List_Modify_Form.databases_r__lm_g;


      Databases_List_ListBox.Items.Add( databases_r_t[ zti ].alias );

      if    ( Databases_List_ListBox.Items.Count > 0 )
        and ( zti >= 0 )
        and ( zti <= Databases_List_ListBox.Items.Count - 1 ) then
        Databases_List_ListBox.ItemIndex := zti;


      Databases__Modified_Notification_Set( true );

    end;

  FreeAndNil( Database__List_Modify.Database__List_Modify_Form );

end;

procedure TSimple_Database_Manager_Form.Databases__Delete_MenuItemClick( Sender: TObject );
var
  zti : integer;
begin

  if   ( Databases_List_ListBox.Items.Count <= 0 )
    or ( Databases_List_ListBox.ItemIndex < 0 )
    or ( Databases_List_ListBox.ItemIndex > Databases_List_ListBox.Items.Count - 1 ) then
    Exit;

  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_the_database_from_the_list_), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;

  zti := Databases_List_ListBox.ItemIndex;


  Databases_List_ListBox.DeleteSelected();

  Delete( databases_r_t, zti, 1 );


  Databases__Modified_Notification_Set( true );

end;

procedure TSimple_Database_Manager_Form.Databases__Refresh_MenuItemClick( Sender: TObject );
var
  i,
  j,
  zti,
  item_index_copy
    : integer;

  zts : string;

  zt_xml_document : TXMLDocument; // uses Xml.XMLDoc.

  component_type_l : Common.TComponent_Type;
begin

  item_index_copy := Databases_List_ListBox.ItemIndex;

  Databases_List_ListBox.Items.Clear();
  SetLength( databases_r_t, 0 );


  zts := ExtractFilePath( Application.ExeName ) + Common.databases_list_file_name_c;

  if not FileExists( zts ) then
    Exit;


  zt_xml_document := TXMLDocument.Create( Self );

  zt_xml_document.Options := zt_xml_document.Options + [ doNodeAutoIndent ]; // uses Xml.XMLIntf.

  try
    zt_xml_document.LoadFromFile( zts );
  except
    on E : Exception do
      Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_load_the_file + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );
  end;



  if zt_xml_document.Active then
    for i := 0 to zt_xml_document.DocumentElement.ChildNodes.Count - 1 do
      begin

        if zt_xml_document.DocumentElement.ChildNodes[ i ].LocalName = 'database' then
          begin

            zti := Length( databases_r_t );
            SetLength( databases_r_t, zti + 1 );

            for j := 0 to zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes.Count - 1 do
              if Trim( zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].LocalName ) <> '' then // Skip comments.
                begin

                  if zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].LocalName = 'alias' then
                    databases_r_t[ zti ].alias := zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].Text
                  else
                  if zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].LocalName = 'ado__connection_string' then
                    databases_r_t[ zti ].ado__connection_string := zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].Text
                  else
                  if zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].LocalName = 'component_type' then
                    begin

                      for component_type_l := Low( Common.TComponent_Type ) to High( Common.TComponent_Type ) do
                        if zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].Text = GetEnumName( TypeInfo(Common.TComponent_Type), integer(component_type_l) ) then
                          begin

                            databases_r_t[ zti ].component_type := component_type_l;
                            Break;

                          end;

                    end
                  else
                  if zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].LocalName = 'database_type' then
                    databases_r_t[ zti ].database_type := zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].Text
                  else
                  if zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].LocalName = 'fire_dac__driver_id' then
                    databases_r_t[ zti ].fire_dac__driver_id := zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].Text
                  else
                  if zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].LocalName = 'fire_dac__file_path' then
                    databases_r_t[ zti ].fire_dac__file_path := zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].Text
                  else
                  if zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].LocalName = 'fire_dac__parameters' then
                    databases_r_t[ zti ].fire_dac__parameters := zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].Text
                  else
                  if zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].LocalName = 'login_prompt' then
                    databases_r_t[ zti ].login_prompt := zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].Text = '1'
                  else
                  if zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].LocalName = 'password' then
                    databases_r_t[ zti ].password := zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].Text
                  else
                  if zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].LocalName = 'sql__quotation_sign' then
                    databases_r_t[ zti ].sql__quotation_sign := zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].Text
                  else
                  if zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].LocalName = 'sql__parameter_sign' then
                    databases_r_t[ zti ].sql__parameter_sign := zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].Text
                  else
                  if zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].LocalName = 'user_name' then
                    databases_r_t[ zti ].user_name := zt_xml_document.DocumentElement.ChildNodes[ i ].ChildNodes[ j ].Text;

                end;


            Databases_List_ListBox.Items.Add( databases_r_t[ zti ].alias );

          end;

      end;


  zt_xml_document.Free();


  if    ( Databases_List_ListBox.Items.Count > 0 )
    and ( item_index_copy >= 0 )
    and ( item_index_copy <= Databases_List_ListBox.Items.Count - 1 ) then
    Databases_List_ListBox.ItemIndex := item_index_copy
  else
    if    ( Databases_List_ListBox.ItemIndex < 0 )
      and ( Databases_List_ListBox.Items.Count > 0 ) then
      Databases_List_ListBox.ItemIndex := 0;


  Databases__Modified_Notification_Set( false );


  {$region 'Xml example.'}
{
<databases>
  <database>
    <alias>database 123</alias>
    <ado__connection_string>Provider=MSDASQL.1;Persist Security Info=False;Data Source=database_odbc_name</ado__connection_string>
    <component_type>ct_ADO</component_type>
    <database_type>FireBird 3.0</database_type>
    <fire_dac__driver_id>FB</fire_dac__driver_id>
    <fire_dac__file_path>C:\F1\database_file.fdb</fire_dac__file_path>
    <fire_dac__parameters>Server=123.456.7.8
CharacterSet=utf8</fire_dac__parameters>
    <login_prompt>no</login_prompt>
    <password>masterkey</password>
    <sql__parameter_sign>:</sql__parameter_sign>
    <sql__quotation_sign>"</sql__quotation_sign>
    <user_name>SYSDBA</user_name>
  </database>
</databases>
}
  {$endregion 'Xml example.'}

end;

procedure TSimple_Database_Manager_Form.Databases__Save_MenuItemClick( Sender: TObject );
var
  i : integer;

  zts : string;

  zt_xml_document : TXMLDocument; // uses Xml.XMLDoc.

  databases__xml_node,
  zt__xml_node
    : IXMLNode; // uses Xml.XMLIntf.
begin

  if   ( Sender = nil )
    or (
             ( Sender <> nil )
         and ( TComponent(Sender).Name <> Self.Name )
       ) then
    if Application.MessageBox( PChar(Translation.translation__messages_r.save_the_list_), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
      Exit;


  zt_xml_document := TXMLDocument.Create( Self );

  zt_xml_document.Options := zt_xml_document.Options + [ doNodeAutoIndent ]; // uses Xml.XMLIntf.

  zt_xml_document.Active := true;

  zt_xml_document.Encoding := 'utf-8';

  databases__xml_node := zt_xml_document.AddChild( 'databases' );


  for i := 0 to Databases_List_ListBox.Items.Count - 1 do
    begin

      zt__xml_node := databases__xml_node.AddChild( 'database' );

      zt__xml_node.AddChild( 'alias' ).Text := databases_r_t[ i ].alias;
      zt__xml_node.AddChild( 'ado__connection_string' ).Text := databases_r_t[ i ].ado__connection_string;
      zt__xml_node.AddChild( 'component_type' ).Text := GetEnumName( TypeInfo(Common.TComponent_Type), integer(databases_r_t[ i ].component_type) );
      zt__xml_node.AddChild( 'database_type' ).Text := databases_r_t[ i ].database_type;
      zt__xml_node.AddChild( 'fire_dac__driver_id' ).Text := databases_r_t[ i ].fire_dac__driver_id;
      zt__xml_node.AddChild( 'fire_dac__file_path' ).Text := databases_r_t[ i ].fire_dac__file_path;
      zt__xml_node.AddChild( 'fire_dac__parameters' ).Text := databases_r_t[ i ].fire_dac__parameters;

      if databases_r_t[ i ].login_prompt then
        zts := '1'
      else
        zts := '0';

      zt__xml_node.AddChild( 'login_prompt' ).Text := zts;
      zt__xml_node.AddChild( 'password' ).Text := databases_r_t[ i ].password;
      zt__xml_node.AddChild( 'sql__parameter_sign' ).Text := databases_r_t[ i ].sql__parameter_sign;
      zt__xml_node.AddChild( 'sql__quotation_sign' ).Text := databases_r_t[ i ].sql__quotation_sign;
      zt__xml_node.AddChild( 'user_name' ).Text := databases_r_t[ i ].user_name;

    end;


  zt_xml_document.SaveToFile(  ExtractFilePath( Application.ExeName ) + Common.databases_list_file_name_c  );


  zt_xml_document.Active := false;

  zt_xml_document.Free();


  Databases__Modified_Notification_Set( false );

end;

procedure TSimple_Database_Manager_Form.Databases__Move__Up_MenuItemClick( Sender: TObject );
var
  zti : integer;
  databases_r_l : Common.TDatabases_r;
begin

  if   ( Databases_List_ListBox.Items.Count <= 0 )
    or ( Databases_List_ListBox.ItemIndex <= 0 )
    or ( Databases_List_ListBox.ItemIndex > Databases_List_ListBox.Items.Count - 1 ) then
    Exit;

  zti := Databases_List_ListBox.ItemIndex;

  databases_r_l := databases_r_t[ zti - 1 ];
  databases_r_t[ zti - 1 ] := databases_r_t[ zti ];
  databases_r_t[ zti ] := databases_r_l;

  Databases_List_ListBox.Items[ zti - 1 ] := databases_r_t[ zti - 1 ].alias;
  Databases_List_ListBox.Items[ zti ] := databases_r_t[ zti ].alias;

  Databases_List_ListBox.ItemIndex := zti - 1;


  Databases__Modified_Notification_Set( true );

end;

procedure TSimple_Database_Manager_Form.Databases__Move__Down_MenuItemClick( Sender: TObject );
var
  zti : integer;
  databases_r_l : Common.TDatabases_r;
begin

  if   ( Databases_List_ListBox.Items.Count <= 0 )
    or ( Databases_List_ListBox.ItemIndex < 0 )
    or ( Databases_List_ListBox.ItemIndex >= Databases_List_ListBox.Items.Count - 1 ) then
    Exit;

  zti := Databases_List_ListBox.ItemIndex;

  databases_r_l := databases_r_t[ zti + 1 ];
  databases_r_t[ zti + 1 ] := databases_r_t[ zti ];
  databases_r_t[ zti ] := databases_r_l;

  Databases_List_ListBox.Items[ zti + 1 ] := databases_r_t[ zti + 1 ].alias;
  Databases_List_ListBox.Items[ zti ] := databases_r_t[ zti ].alias;

  Databases_List_ListBox.ItemIndex := zti + 1;


  Databases__Modified_Notification_Set( true );

end;

procedure TSimple_Database_Manager_Form.Databases__Open_MenuItemClick( Sender: TObject );
begin

  if   ( Databases_List_ListBox.Items.Count <= 0 )
    or ( Databases_List_ListBox.ItemIndex < 0 )
    or ( Databases_List_ListBox.ItemIndex > Databases_List_ListBox.Items.Count - 1 ) then
    Exit;


  with Database__Modify.TDatabase__Modify_Form.Create( Application ) do
    begin

      databases_r__dm_g := databases_r_t[ Databases_List_ListBox.ItemIndex ];
      item_index_g := Databases_List_ListBox.ItemIndex;
      Name := '';
      Prepare__DM();

    end;

end;

procedure TSimple_Database_Manager_Form.Databases__Close__One_MenuItemClick( Sender: TObject );
begin

  if Self.MDIChildCount > 0 then
    begin

      if    ( Self.MDIChildren[ 0 ] is Database__Modify.TDatabase__Modify_Form )
        and ( Database__Modify.TDatabase__Modify_Form(Self.MDIChildren[ 0 ]).Task_Running_Check__DM() ) then
        begin

          Application.MessageBox( PChar(Translation.translation__messages_r.tasks_are_still_running_wait_until_finish), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
          Exit;

        end;


      Self.MDIChildren[ 0 ].Close();
      Self.MDIChildren[ 0 ].Free();

    end;

end;

procedure TSimple_Database_Manager_Form.Databases__Close__Selected_MenuItemClick( Sender: TObject );
var
  ztb : boolean;
  i : integer;
begin

  if   ( Databases_List_ListBox.Items.Count <= 0 )
    or ( Databases_List_ListBox.ItemIndex < 0 )
    or ( Databases_List_ListBox.ItemIndex > Databases_List_ListBox.Items.Count - 1 ) then
    Exit;


  ztb := true;

  for i := Self.MDIChildCount - 1 downto 0 do
    if    ( Self.MDIChildren[ i ] is Database__Modify.TDatabase__Modify_Form )
      and ( Database__Modify.TDatabase__Modify_Form(Self.MDIChildren[ i ]).item_index_g = Databases_List_ListBox.ItemIndex ) then
      begin

        if not Database__Modify.TDatabase__Modify_Form(Self.MDIChildren[ i ]).Task_Running_Check__DM() then
          begin

            Self.MDIChildren[ i ].Close();
            Self.MDIChildren[ i ].Free();

          end
        else
          if ztb then
            ztb := false;

      end;


  if not ztb then
    Application.MessageBox( PChar(Translation.translation__messages_r.tasks_are_still_running_wait_until_finish), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );

end;

procedure TSimple_Database_Manager_Form.Databases__Close__All_MenuItemClick( Sender: TObject );
var
  ztb : boolean;
  i : integer;
begin

  if   ( Databases_List_ListBox.Items.Count <= 0 )
    or ( Databases_List_ListBox.ItemIndex < 0 )
    or ( Databases_List_ListBox.ItemIndex > Databases_List_ListBox.Items.Count - 1 ) then
    Exit;


  ztb := true;

  for i := Self.MDIChildCount - 1 downto 0 do
    if Self.MDIChildren[ i ] is Database__Modify.TDatabase__Modify_Form then
      begin

        if   ( not Database__Modify.TDatabase__Modify_Form(Self.MDIChildren[ i ]).Task_Running_Check__DM() )
          or (  Application.MessageBox( PChar(Translation.translation__messages_r.force_close_), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) = IDYES  ) then
          begin

            Self.MDIChildren[ i ].Close();
            Self.MDIChildren[ i ].Free();

          end
        else
          if ztb then
            ztb := false;

      end
    else
      begin

        Self.MDIChildren[ i ].Close();
        Self.MDIChildren[ i ].Free();

      end;


  if not ztb then
    Application.MessageBox( PChar(Translation.translation__messages_r.tasks_are_still_running_wait_until_finish), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );

end;

procedure TSimple_Database_Manager_Form.Database__Backup_Restore_MenuItemClick( Sender: TObject );
var
  i,
  zti
    : integer;
begin

  Database__Backup_Restore.Database__Backup_Restore_Form := Database__Backup_Restore.TDatabase__Backup_Restore_Form.Create( Application );
  //Database__Backup_Restore.Database__Backup_Restore_Form.Quotation_Sign__Use_CheckBox.Checked := Common.sql__quotation_sign__use;
  Database__Backup_Restore.Database__Backup_Restore_Form.splitter_show__dbr := Common.splitter_show;


  if    ( Databases_List_ListBox.Items.Count > 0 )
    and ( Databases_List_ListBox.ItemIndex >= 0 )
    and ( Databases_List_ListBox.ItemIndex <= Databases_List_ListBox.Items.Count - 1 ) then
    zti := Databases_List_ListBox.ItemIndex
  else
    zti := -99;


  SetLength(  Database__Backup_Restore.Database__Backup_Restore_Form.databases_r_t, Length( databases_r_t )  );

  for i := 0 to Length( databases_r_t ) - 1 do
    begin

      Database__Backup_Restore.Database__Backup_Restore_Form.databases_r_t[ i ].alias := databases_r_t[ i ].alias;
      Database__Backup_Restore.Database__Backup_Restore_Form.databases_r_t[ i ].database_type := databases_r_t[ i ].database_type;
      Database__Backup_Restore.Database__Backup_Restore_Form.databases_r_t[ i ].fire_dac__file_path := databases_r_t[ i ].fire_dac__file_path;
      Database__Backup_Restore.Database__Backup_Restore_Form.databases_r_t[ i ].password := databases_r_t[ i ].password;
      Database__Backup_Restore.Database__Backup_Restore_Form.databases_r_t[ i ].user_name := databases_r_t[ i ].user_name;

      if i = zti then
        Database__Backup_Restore.Database__Backup_Restore_Form.alias_initialize := Database__Backup_Restore.Database__Backup_Restore_Form.databases_r_t[ i ].alias;

    end;

  Database__Backup_Restore.Database__Backup_Restore_Form.ShowModal();
  FreeAndNil( Database__Backup_Restore.Database__Backup_Restore_Form );

end;

procedure TSimple_Database_Manager_Form.Database__Create_MenuItemClick( Sender: TObject );
begin

  Database__Create.Database__Create_Form := Database__Create.TDatabase__Create_Form.Create( Application );
  //Database__Create.Database__Create_Form.Quotation_Sign__Use_CheckBox.Checked := Common.sql__quotation_sign__use;
  Database__Create.Database__Create_Form.splitter_show__dbr := Common.splitter_show;

  if    ( Databases_List_ListBox.Items.Count > 0 )
    and ( Databases_List_ListBox.ItemIndex >= 0 )
    and ( Databases_List_ListBox.ItemIndex <= Databases_List_ListBox.Items.Count - 1 ) then
    begin

      Database__Create.Database__Create_Form.Password__Set( databases_r_t[ Databases_List_ListBox.ItemIndex ].password );
      Database__Create.Database__Create_Form.User_Name__Set( databases_r_t[ Databases_List_ListBox.ItemIndex ].user_name );

    end;

  Database__Create.Database__Create_Form.ShowModal();
  FreeAndNil( Database__Create.Database__Create_Form );

end;

procedure TSimple_Database_Manager_Form.Databases__Exit_MenuItemClick( Sender: TObject );
begin

  Close();

end;

procedure TSimple_Database_Manager_Form.Databases_List_ListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_INSERT )
    and ( ssCtrl in Shift ) then
    begin

      Key := 0;
      Database__Create_MenuItemClick( Sender );
      Databases_List_ListBox.SetFocus();

    end;

  if Key = VK_INSERT then
    begin

      Key := 0;
      Databases__Add_MenuItemClick( Sender );
      Databases_List_ListBox.SetFocus();

    end;

  if   ( Key = VK_SPACE )
    or (
             ( Key = VK_RETURN )
         and ( ssCtrl in Shift )
       ) then
    begin

      Key := 0;
      Databases__Edit_MenuItemClick( Sender );
      Databases_List_ListBox.SetFocus();

    end;

  if Key = VK_DELETE then
    begin

      Key := 0;
      Databases__Delete_MenuItemClick( Sender );
      Databases_List_ListBox.SetFocus();

    end;

  // B.
  if    ( Key = 66 )
    and ( ssCtrl in Shift ) then
    begin

      Key := 0;
      Database__Backup_Restore_MenuItemClick( Sender );
      Databases_List_ListBox.SetFocus();

    end;

  // C.
  if    ( Key = 67 )
    and ( ssCtrl in Shift ) then
    begin

      Key := 0;
      Databases__Copy_MenuItemClick( Sender );
      Databases_List_ListBox.SetFocus();

    end;

  // R.
  if    ( Key = 82 )
    and ( ssCtrl in Shift ) then
    begin

      Key := 0;
      Databases__Refresh_MenuItemClick( Sender );
      Databases_List_ListBox.SetFocus();

    end;

  // S.
  if    ( Key = 83 )
    and ( ssCtrl in Shift ) then
    begin

      Key := 0;
      Databases__Save_MenuItemClick( Sender );
      Databases_List_ListBox.SetFocus();

    end;

  if    ( Key = VK_UP )
    and ( ssCtrl in Shift ) then
    begin

      Key := 0;
      Databases__Move__Up_MenuItemClick( Sender );

    end;

  if    ( Key = VK_DOWN )
    and ( ssCtrl in Shift ) then
    begin

      Key := 0;
      Databases__Move__Down_MenuItemClick( Sender );

    end;

  if Key = VK_RETURN then
    begin

      Key := 0;
      Databases__Open_MenuItemClick( Sender );
      Databases_List_ListBox.SetFocus();

    end;

  // W.
  if    ( Key = 87 )
    and ( ssCtrl in Shift )
    and ( ssShift in Shift ) then
    begin

      Key := 0;
      Databases__Close__All_MenuItemClick( Sender );
      Databases_List_ListBox.SetFocus();

    end;

  // W.
  if    ( Key = 87 )
    and ( ssCtrl in Shift ) then
    begin

      Key := 0;
      Databases__Close__One_MenuItemClick( Sender );
      Databases_List_ListBox.SetFocus();

    end;

end;

procedure TSimple_Database_Manager_Form.Databases_List_ListBoxDragDrop( Sender, Source: TObject; X, Y: Integer );
var
  i,
  index__drop_l,
  steps_l
    : integer;

  zt_point : TPoint;
begin

  // Set Databases_List_ListBox.DragMode = TDragMode.dmAutomatic.

  steps_l := 0;

  zt_point.x := x;
  zt_point.y := y;


  for i := 0 to TListBox(Source).Items.Count - 1 do
    begin

      if TListBox(Source).Selected[ i ] then
        begin

          index__drop_l := TListBox(Source).ItemAtPos( zt_point, true );


          if index__drop_l = -1 then
            index__drop_l := Length( databases_r_t ) - 1;


          if    (  Length( databases_r_t ) > 0  )
            and ( i >= 0 )
            and (  i <= Length( databases_r_t ) - 1  )
            and ( index__drop_l >= 0 )
            and (  index__drop_l <= Length( databases_r_t ) - 1  ) then
            begin

              steps_l := index__drop_l - i;

            end;


          Break;

        end;

    end;


  for i := 1 to Abs( steps_l ) do
    if steps_l < 0 then
      Databases__Move__Up_MenuItemClick( Sender )
    else
      Databases__Move__Down_MenuItemClick( Sender );

end;

procedure TSimple_Database_Manager_Form.Databases_List_ListBoxDragOver( Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean  );
begin

  Accept := Source = Databases_List_ListBox;

end;

end.
