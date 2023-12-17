unit Text__Search_Replace;{09.Lis.2023}

interface

uses
  SynEdit,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TText__Search_Replace_Form = class( TForm )
    Replace_Button: TButton;
    Search__Find_Next_Button: TButton;
    Search_ComboBox: TComboBox;
    Search__Case_Insensitive_CheckBox: TCheckBox;
    Search__Partial_Key_CheckBox: TCheckBox;
    Search__Close_Button: TButton;
    Replace__All_Button: TButton;
    Search__From_Cursor_CheckBox: TCheckBox;
    Search__Selected_Text_Only_CheckBox: TCheckBox;
    Search__Regular_Expression_CheckBox: TCheckBox;
    Search_Etiquette_Label: TLabel;
    Replace_Etiquette_Label: TLabel;
    Replace_ComboBox: TComboBox;
    Search_Options_Panel: TPanel;
    Search__Direction_RadioGroup: TRadioGroup;
    Centre_Panel: TPanel;
    Buttons_Panel: TPanel;
    Replace__Prompt_CheckBox: TCheckBox;
    procedure FormCreate( Sender: TObject );
    procedure FormShow( Sender: TObject );
    procedure FormDestroy( Sender: TObject );

    procedure Search_Replace_ButtonClick( Sender: TObject );
    procedure Search__Close_ButtonClick( Sender: TObject );

    procedure Search_Replace_ComboBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Search_ComboBoxEnter( Sender: TObject );
    procedure Replace_ComboBoxEnter( Sender: TObject );
  private
    { Private declarations }
    first_search_g,
    not_found_message_displayed_g,
    search_direction__invert__temporary_g,
    search_text_found_g,
    shared_window_g
      : boolean;

    previous_search_text_g : string;

    syn_edit : TSynEdit;

    procedure History__Items_Update();
    procedure History__Load();
    procedure History__Save();
  public
    { Public declarations }
    replace : boolean;

    procedure Search__Direction__Invert();
    procedure Search__Text_Set( const search_text_f : string );
    procedure Shared_Notification_Set();
    procedure Syn_Edit__Set( syn_edit_f : TSynEdit );
  end;

const
  text__search_replace__history__replace__file_name_c : string = 'Text__Search_Replace__History__Replace.txt';
  text__search_replace__history__search__file_name_c : string = 'Text__Search_Replace__History__Search.txt';

var
  Text__Search_Replace_Form: TText__Search_Replace_Form;

implementation

uses
  SynEditTypes,

  Common,
  Shared,
  Translation;

{$R *.dfm}

procedure TText__Search_Replace_Form.History__Items_Update();

  procedure History_Combo_Box_Items_Update( combo_box_f : TComboBox );
  var
    ztb : boolean;

    i : integer;

    zts : string;
  begin

    if combo_box_f = nil then
      Exit;

    zts := combo_box_f.Text;

    if zts <> '' then
      begin

        //i := combo_box_f.Items.IndexOf( zts ); // Is not case sensitive.

        ztb := false;

        for i := 0 to combo_box_f.Items.Count - 1 do
          if combo_box_f.Items[ i ] = zts then
            begin

              ztb := true;
              Break;

            end;

        //if i > -1 then
        if ztb then
          begin

            // Shift the item to the top.

            combo_box_f.Items.Delete( i );
            combo_box_f.Items.Insert( 0, zts );
            combo_box_f.Text := zts;

          end
        else
          combo_box_f.Items.Insert( 0, zts ); // Add new item.


        while ( combo_box_f.Items.Count > 0 )
          and ( combo_box_f.Items.Count > Common.text__search__history_save_to_file__items_count ) do
          combo_box_f.Items.Delete( combo_box_f.Items.Count - 1 );

      end;

  end;

begin

  History_Combo_Box_Items_Update( Search_ComboBox );
  History_Combo_Box_Items_Update( Replace_ComboBox );

end;

procedure TText__Search_Replace_Form.History__Load();
var
  zts : string;
begin

  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + text__search_replace__history__replace__file_name_c  );
  Common.Items_From_Text_Add( Replace_ComboBox.Items, zts );

  zts := Common.Text__File_Load(  ExtractFilePath( Application.ExeName ) + text__search_replace__history__search__file_name_c  );
  Common.Items_From_Text_Add( Search_ComboBox.Items, zts );

end;

procedure TText__Search_Replace_Form.History__Save();
begin

  if not Common.text__search__history_save_to_file then
    Exit;


  Replace_ComboBox.Items.SaveToFile(  ExtractFilePath( Application.ExeName ) + text__search_replace__history__replace__file_name_c, TEncoding.UTF8  );
  Search_ComboBox.Items.SaveToFile(  ExtractFilePath( Application.ExeName ) + text__search_replace__history__search__file_name_c, TEncoding.UTF8  );

end;

procedure TText__Search_Replace_Form.Search__Direction__Invert();
begin

  search_direction__invert__temporary_g := true;

end;

procedure TText__Search_Replace_Form.Search__Text_Set( const search_text_f : string );
begin

  Search_ComboBox.Text := search_text_f;

end;

procedure TText__Search_Replace_Form.Shared_Notification_Set();
begin

  shared_window_g := true;
  Self.Caption := Self.Caption + ' (' + Translation.translation__messages_r.word__shared + ')';

end;

procedure TText__Search_Replace_Form.Syn_Edit__Set( syn_edit_f : TSynEdit );
begin

  if syn_edit <> syn_edit_f then
    search_text_found_g := false;


  syn_edit := syn_edit_f;

end;

procedure TText__Search_Replace_Form.FormCreate( Sender: TObject );
begin

  first_search_g := true;
  not_found_message_displayed_g := false;
  previous_search_text_g := '';
  replace := false;
  search_direction__invert__temporary_g := false;
  search_text_found_g := false;
  shared_window_g := false;

  Syn_Edit__Set( nil );


  History__Load();


  Translation.Translation__Apply( Self );

end;

procedure TText__Search_Replace_Form.FormShow( Sender: TObject );
begin

  Search_ComboBox.SetFocus();

end;

procedure TText__Search_Replace_Form.FormDestroy( Sender: TObject );
begin

  History__Save();

end;

procedure TText__Search_Replace_Form.Search_Replace_ButtonClick( Sender: TObject );
var
  replace_l,
  search_direction_backward_l,
  search_again_l
    : boolean;

  syn_search_options_l : SynEditTypes.TSynSearchOptions;
begin

  if syn_edit = nil then
    Exit;


  if Trim( Search_ComboBox.Text ) = '' then
    begin

      if Self.Visible then
        Search_ComboBox.SetFocus();

      Application.MessageBox( PChar(Translation.translation__messages_r.the_search_string_cannot_be_blank), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  if Sender = nil then
    replace_l := replace
  else
    replace_l :=
         ( TComponent(Sender).Name = Replace_Button.Name )
      or ( TComponent(Sender).Name = Replace__All_Button.Name );


  if    ( replace_l )
    and ( syn_edit.ReadOnly ) then
    begin

      Application.MessageBox( PChar(Translation.translation__messages_r.the_text_is_read_only), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  if    ( replace_l)
    and ( Search_ComboBox.Text = Replace_ComboBox.Text ) then
    begin

      if    ( Self.Visible )
        and ( Replace_ComboBox.Enabled ) then
        Replace_ComboBox.SetFocus();

      Application.MessageBox( PChar(Translation.translation__messages_r.the_search_and_replace_strings_cannot_be_equal), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;


  search_direction_backward_l := Search__Direction_RadioGroup.ItemIndex = 0; // Backward.


  if search_direction__invert__temporary_g then
    search_direction_backward_l := not search_direction_backward_l;


  if previous_search_text_g <> Search_ComboBox.Text then
    begin

      if not first_search_g then
        first_search_g := true;

      if not_found_message_displayed_g then
        not_found_message_displayed_g := false;

      previous_search_text_g := Search_ComboBox.Text;

      if search_text_found_g then
        search_text_found_g := false;

    end;


  search_again_l := false;


  History__Items_Update();


  if replace_l then
    begin

      if search_text_found_g then
        search_text_found_g := false;

      syn_search_options_l := [ SynEditTypes.ssoReplace ];


      if    ( Replace__Prompt_CheckBox.Checked )
        and (
                 ( Sender = nil )
              or (
                       ( Sender <> nil )
                   and ( TComponent(Sender).Name <> Replace__All_Button.Name )
                 )
            ) then
        Include( syn_search_options_l, SynEditTypes.ssoPrompt );


      if   ( Replace__Prompt_CheckBox.Checked )
        or (
                 ( Sender <> nil )
             and ( TComponent(Sender).Name = Replace__All_Button.Name )
           ) then
        Include( syn_search_options_l, SynEditTypes.ssoReplaceAll );

    end
  else
    syn_search_options_l := [];


  if not Search__Case_Insensitive_CheckBox.Checked then
    Include( syn_search_options_l, SynEditTypes.ssoMatchCase );

  if not Search__Partial_Key_CheckBox.Checked then
    Include( syn_search_options_l, SynEditTypes.ssoWholeWord );

  if not Search__From_Cursor_CheckBox.Checked then
    Include( syn_search_options_l, SynEditTypes.ssoEntireScope );

  if Search__Selected_Text_Only_CheckBox.Checked then
    Include( syn_search_options_l, SynEditTypes.ssoSelectedOnly );


  if search_direction_backward_l then
    Include( syn_search_options_l, SynEditTypes.ssoBackwards );



  if Search__Regular_Expression_CheckBox.Checked then
    begin

      if syn_edit.SearchEngine <> Shared.Shared_DataModule.SynEditRegexSearch1 then
        syn_edit.SearchEngine := Shared.Shared_DataModule.SynEditRegexSearch1;

    end
  else
    if syn_edit.SearchEngine <> Shared.Shared_DataModule.SynEditSearch1 then
      syn_edit.SearchEngine := Shared.Shared_DataModule.SynEditSearch1;


  if syn_edit.SearchReplace( Search_ComboBox.Text, Replace_ComboBox.Text, syn_search_options_l ) = 0 then
    begin

      if    ( not first_search_g )
        and ( not not_found_message_displayed_g )
        and ( not search_text_found_g ) then
        begin

          not_found_message_displayed_g := true;

          Application.MessageBox( PChar(Translation.translation__messages_r.search_string_not_found__1  + ' ''' + Search_ComboBox.Text + ''' ' + Translation.translation__messages_r.search_string_not_found__2), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

        end
      else
        if search_direction_backward_l then
          begin

            if   ( first_search_g )
              or (  Application.MessageBox( PChar(Translation.translation__messages_r.reset_search_from_the_end), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON1 + MB_ICONQUESTION ) = IDYES  ) then
              begin

                if not_found_message_displayed_g then
                  not_found_message_displayed_g := false;

                syn_edit.CaretY := syn_edit.Lines.Count;
                syn_edit.CaretX := Length( syn_edit.Lines[ syn_edit.Lines.Count - 1 ] ) + 1;

                search_again_l := true;

              end;

          end
        else
          begin

            if   ( first_search_g )
              or (  Application.MessageBox( PChar(Translation.translation__messages_r.reset_search_from_the_beginning), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON1 + MB_ICONQUESTION ) = IDYES  ) then
              begin

                if not_found_message_displayed_g then
                  not_found_message_displayed_g := false;

                syn_edit.CaretX := 1;
                syn_edit.CaretY := 1;

                search_again_l := true;

              end;

          end;

    end
  else
    if    ( not replace_l )
      and ( not search_text_found_g ) then
      search_text_found_g := true;


  if first_search_g then
    first_search_g := false;


  syn_edit.Refresh();


  if search_again_l then
    Search_Replace_ButtonClick( Sender );


  if search_direction__invert__temporary_g then
    search_direction__invert__temporary_g := false;

end;

procedure TText__Search_Replace_Form.Search__Close_ButtonClick( Sender: TObject );
begin

  //Self.Hide(); // Do not call FormClose().
  Self.Close();

end;

procedure TText__Search_Replace_Form.Search_Replace_ComboBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_RETURN then
    if    ( Sender <> nil )
      and ( TComponent(Sender).Name = Replace_ComboBox.Name ) then
      Search_Replace_ButtonClick( Replace_Button  )
    else
      Search_Replace_ButtonClick( Search__Find_Next_Button  );

end;

procedure TText__Search_Replace_Form.Search_ComboBoxEnter( Sender: TObject );
begin

  Search_ComboBox.SelectAll();

end;

procedure TText__Search_Replace_Form.Replace_ComboBoxEnter( Sender: TObject );
begin

  Replace_ComboBox.SelectAll();

end;

end.
