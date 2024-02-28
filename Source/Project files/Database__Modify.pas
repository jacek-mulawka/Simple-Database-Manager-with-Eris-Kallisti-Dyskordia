unit Database__Modify;{19.Cze.2023}

interface

uses
  Common,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus,

  Data.DB, Data.Win.ADODB,

  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.Phys.MSAccDef,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.ADSDef, FireDAC.Phys.FBDef, FireDAC.Phys.PGDef, FireDAC.Phys.IBDef,
  FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.Phys.SQLiteDef, FireDAC.Phys.SQLite, FireDAC.Phys.IB,
  FireDAC.Phys.PG, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Phys.ADS, FireDAC.Phys.MySQL, FireDAC.Phys.ODBCBase,
  FireDAC.Phys.MSAcc, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TConnection_Status_Caption = ( csc_Connected, csc_Disconnected, csc_Error );

  TDatabase__Modify_Form = class( TForm )
    ADOConnection1: TADOConnection;
    FDConnection1: TFDConnection;
    ADOQuery1: TADOQuery;
    FDQuery1: TFDQuery;
    FDPhysMSAccessDriverLink1: TFDPhysMSAccessDriverLink;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDPhysADSDriverLink1: TFDPhysADSDriverLink;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    FDTransaction1: TFDTransaction;
    Main_PageControl: TPageControl;
    Component_Type_TabSheet: TTabSheet;
    Component_Type_Etiquette_Label: TLabel;
    Component_Type_ComboBox: TComboBox;
    Connect_Button: TButton;
    Component_Type_Default_Label: TLabel;
    Connection_Status_Etiquette_Label: TLabel;
    Connection_Status_Label: TLabel;
    Form_View__Additional_Component_Show_CheckBox: TCheckBox;
    Splitter_Show_CheckBox: TCheckBox;
    Queries_Open_In_Background_CheckBox: TCheckBox;
    Sql__Quotation_Sign__Use_CheckBox: TCheckBox;
    Exceptions_TabSheet: TTabSheet;
    External_Functions_TabSheet: TTabSheet;
    Generators_List_TabSheet: TTabSheet;
    Roles_List_TabSheet: TTabSheet;
    Stored_Procedures_List_TabSheet: TTabSheet;
    Stored_Procedures_List__ListBox: TListBox;
    Stored_Procedures__List_Vertical_Splitter: TSplitter;
    Stored_Procedures_List_Count_Etiquette_Label: TLabel;
    Stored_Procedures_List_Count_Label: TLabel;
    Tables_List_Count_Etiquette_Label: TLabel;
    Tables_List_Count_Label: TLabel;
    Tables_List_TabSheet: TTabSheet;
    Tables_List__Left_Panel: TPanel;
    Tables_List__Vertical_Splitter: TSplitter;
    Tables_List__ListBox: TListBox;
    Tables_List__Buttons_Panel: TPanel;
    Tables_List__Page__Close__One_Button: TButton;
    Tables_List__Page__Close__All_Button: TButton;
    Tables_List__PageControl: TPageControl;
    Tables_List__Move__Left_Button: TButton;
    Tables_List__Move__Right_Button: TButton;
    Tables_List__Hide_Button: TButton;
    Tables_List__Page__New_Button: TButton;
    Tables_List__Search_GroupBox: TGroupBox;
    Tables_List__Search_Edit: TEdit;
    Tables_List__Search__Case_Insensitive_CheckBox: TCheckBox;
    Tables_List__Search__Partial_Key_CheckBox: TCheckBox;
    Tables_List__Search__Prior_Button: TButton;
    Tables_List__Search__Next_Button: TButton;
    Tables_List__Buttons_Panel_Horizontal_Splitter: TSplitter;
    Tables_List__PopupMenu: TPopupMenu;
    Tables_List__Page__New_MenuItem: TMenuItem;
    N1: TMenuItem;
    Tables_List__Table__Add_MenuItem: TMenuItem;
    Tables_List__Table__Delete_MenuItem: TMenuItem;
    N2: TMenuItem;
    Tables_List__Refresh_MenuItem: TMenuItem;
    N3: TMenuItem;
    Tables_List__Close__One_MenuItem: TMenuItem;
    Tables_List__Close__All_MenuItem: TMenuItem;
    Sql_Editor__Database_Connection__Separated_CheckBox: TCheckBox;
    Sql_Editor_TabSheet: TTabSheet;
    Sql_Editor__Vertical_Splitter: TSplitter;
    Sql_Editor__PageControl: TPageControl;
    Sql_Editor__Buttons_Panel: TPanel;
    Sql_Editor__Page__Close__One_Button: TButton;
    Sql_Editor__Page__Close__All_Button: TButton;
    Sql_Editor__Move__Left_Button: TButton;
    Sql_Editor__Move__Right_Button: TButton;
    Sql_Editor__Page__New_Button: TButton;
    Stored_Procedures_List__Left_Panel: TPanel;
    Stored_Procedures_List__Buttons_Panel: TPanel;
    Stored_Procedures_List__Page__Close__One_Button: TButton;
    Stored_Procedures_List__Page__Close__All_Button: TButton;
    Stored_Procedures_List__Move__Left_Button: TButton;
    Stored_Procedures_List__Move__Right_Button: TButton;
    Stored_Procedures_List__Hide_Button: TButton;
    Stored_Procedures_List__Page__New_Button: TButton;
    Stored_Procedures_List__Search_GroupBox: TGroupBox;
    Stored_Procedures_List__Search_Edit: TEdit;
    Stored_Procedures_List__Search__Case_Insensitive_CheckBox: TCheckBox;
    Stored_Procedures_List__Search__Partial_Key_CheckBox: TCheckBox;
    Stored_Procedures_List__Search__Prior_Button: TButton;
    Stored_Procedures_List__Search__Next_Button: TButton;
    Stored_Procedures_List__Buttons_Panel_Horizontal_Splitter: TSplitter;
    Stored_Procedures_List__PageControl: TPageControl;
    Stored_Procedures_List__PopupMenu: TPopupMenu;
    Stored_Procedures_List__Page__New_MenuItem: TMenuItem;
    N4: TMenuItem;
    Stored_Procedures_List__Stored_Procedure__Add__Modal__MenuItem: TMenuItem;
    Stored_Procedures_List__Stored_Procedure__Add__MenuItem: TMenuItem;
    Stored_Procedures_List__Stored_Procedure__Delete__MenuItem: TMenuItem;
    N5: TMenuItem;
    Stored_Procedures_List__Refresh_MenuItem: TMenuItem;
    N6: TMenuItem;
    Stored_Procedures_List__Close__One_MenuItem: TMenuItem;
    Stored_Procedures_List__Close__All_MenuItem: TMenuItem;
    Sql_Editor__Hide_Button: TButton;
    Log_Memo: TMemo;
    Component_Type_Log_Horizontal_Splitter: TSplitter;
    Views_List_TabSheet: TTabSheet;
    Views__List_Vertical_Splitter: TSplitter;
    Views_List__PageControl: TPageControl;
    Views_List__Left_Panel: TPanel;
    Views_List__Buttons_Panel_Horizontal_Splitter: TSplitter;
    Views_List__Buttons_Panel: TPanel;
    Views_List__Page__Close__One_Button: TButton;
    Views_List__Page__Close__All_Button: TButton;
    Views_List__Move__Left_Button: TButton;
    Views_List__Move__Right_Button: TButton;
    Views_List__Page__New_Button: TButton;
    Views_List__Hide_Button: TButton;
    Views_List__Search_GroupBox: TGroupBox;
    Views_List__Search_Edit: TEdit;
    Views_List__Search__Case_Insensitive_CheckBox: TCheckBox;
    Views_List__Search__Partial_Key_CheckBox: TCheckBox;
    Views_List__Search__Prior_Button: TButton;
    Views_List__Search__Next_Button: TButton;
    Views_List__ListBox: TListBox;
    Views_List__PopupMenu: TPopupMenu;
    Views_List__Page__New_MenuItem: TMenuItem;
    N7: TMenuItem;
    Views_List__View__Add__Modal__MenuItem: TMenuItem;
    Views_List__View__Add__MenuItem: TMenuItem;
    Views_List__View__Delete__MenuItem: TMenuItem;
    N8: TMenuItem;
    Views_List__Refresh_MenuItem: TMenuItem;
    N9: TMenuItem;
    Views_List__Close__One_MenuItem: TMenuItem;
    Views_List__Close__All_MenuItem: TMenuItem;
    Views_List_Count_Etiquette_Label: TLabel;
    Views_List_Count_Label: TLabel;
    Database__Informations_TabSheet: TTabSheet;
    Users_List_TabSheet: TTabSheet;
    Database_Name_Label: TLabel;
    Component_Type_Top_Panel: TPanel;
    procedure FormCreate( Sender: TObject );
    procedure FormShow( Sender: TObject );
    procedure FormClose( Sender: TObject; var Action: TCloseAction );

    procedure Main_PageControlChange( Sender: TObject );
    procedure Connect_ButtonClick( Sender: TObject );
    procedure Component_Type_ComboBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );

    procedure Sql_Editor__Page__New_ButtonClick( Sender: TObject );
    procedure Sql_Editor__Page__Close__One_ButtonClick( Sender: TObject );
    procedure Sql_Editor__Page__Close__All_ButtonClick( Sender: TObject );
    procedure Sql_Editor__Move__Right_ButtonClick( Sender: TObject );
    procedure Sql_Editor__Move__Left_ButtonClick( Sender: TObject );
    procedure Sql_Editor__Hide_ButtonClick( Sender: TObject );
    procedure Sql_Editor__PageControlMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
    procedure Sql_Editor__PageControlDragOver( Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean );
    procedure Sql_Editor__PageControlDragDrop( Sender, Source: TObject; X, Y: Integer );

    procedure Stored_Procedures_List__ListBoxClick( Sender: TObject );
    procedure Stored_Procedures_List__ListBoxDblClick( Sender: TObject );
    procedure Stored_Procedures_List__ListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Stored_Procedures_List__Page__Close__One_ButtonClick( Sender: TObject );
    procedure Stored_Procedures_List__Page__Close__All_ButtonClick( Sender: TObject );
    procedure Stored_Procedures_List__Move__Left_ButtonClick( Sender: TObject );
    procedure Stored_Procedures_List__Move__Right_ButtonClick( Sender: TObject );
    procedure Stored_Procedures_List__Refresh_MenuItemClick( Sender: TObject );
    procedure Stored_Procedures_List__Hide_ButtonClick( Sender: TObject );
    procedure Stored_Procedures_List__Search_Change( Sender: TObject );
    procedure Stored_Procedures_List__Search__Next_ButtonClick( Sender: TObject );
    procedure Stored_Procedures_List__Search__Prior_ButtonClick( Sender: TObject );
    procedure Stored_Procedures_List__Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Stored_Procedures_List__Search_ButtonKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Stored_Procedures_List__Stored_Procedure__Add__Modal__MenuItemClick( Sender: TObject );
    procedure Stored_Procedures_List__Stored_Procedure__Delete__MenuItemClick( Sender: TObject );
    procedure Stored_Procedures_List__PageControlMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
    procedure Stored_Procedures_List__PageControlDragOver( Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean );
    procedure Stored_Procedures_List__PageControlDragDrop( Sender, Source: TObject; X, Y: Integer );

    procedure Tables_List__ListBoxClick( Sender: TObject );
    procedure Tables_List__ListBoxDblClick( Sender: TObject );
    procedure Tables_List__ListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Tables_List__Page__Close__One_ButtonClick( Sender: TObject );
    procedure Tables_List__Page__Close__All_ButtonClick( Sender: TObject );
    procedure Tables_List__Move__Right_ButtonClick( Sender: TObject );
    procedure Tables_List__Move__Left_ButtonClick( Sender: TObject );
    procedure Tables_List__Refresh_MenuItemClick( Sender: TObject );
    procedure Tables_List__Hide_ButtonClick( Sender: TObject );
    procedure Tables_List__Search_Change( Sender: TObject );
    procedure Tables_List__Search__Next_ButtonClick( Sender: TObject );
    procedure Tables_List__Search__Prior_ButtonClick( Sender: TObject );
    procedure Tables_List__Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Tables_List__Search_ButtonKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Tables_List__Table__Add_MenuItemClick( Sender: TObject );
    procedure Tables_List__Table__Delete_MenuItemClick( Sender: TObject );
    procedure Tables_List__PageControlMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
    procedure Tables_List__PageControlDragOver( Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean );
    procedure Tables_List__PageControlDragDrop( Sender, Source: TObject; X, Y: Integer );

    procedure Views_List__ListBoxClick( Sender: TObject );
    procedure Views_List__ListBoxDblClick( Sender: TObject );
    procedure Views_List__ListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Views_List__Page__Close__One_ButtonClick( Sender: TObject );
    procedure Views_List__Page__Close__All_ButtonClick( Sender: TObject );
    procedure Views_List__Move__Left_ButtonClick( Sender: TObject );
    procedure Views_List__Move__Right_ButtonClick( Sender: TObject );
    procedure Views_List__Refresh_MenuItemClick( Sender: TObject );
    procedure Views_List__Hide_ButtonClick( Sender: TObject );
    procedure Views_List__Search_Change( Sender: TObject );
    procedure Views_List__Search__Next_ButtonClick( Sender: TObject );
    procedure Views_List__Search__Prior_ButtonClick( Sender: TObject );
    procedure Views_List__Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Views_List__Search_ButtonKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Views_List__View__Add__Modal__MenuItemClick( Sender: TObject );
    procedure Views_List__View__Delete__MenuItemClick( Sender: TObject );
    procedure Views_List__PageControlMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
    procedure Views_List__PageControlDragOver( Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean );
    procedure Views_List__PageControlDragDrop( Sender, Source: TObject; X, Y: Integer );
  private
    { Private declarations }
    close_can__checked__dm : boolean;

    id_search__stored_procedures_list_g,
    id_search__tables_list_g,
    id_search__views__list_g,
    sql_editor__tabs__count_total_g
      : integer;

    stored_procedure_name_g,
    table_name_g,
    view_name_g
      : string;

    connection_status_caption_g : TConnection_Status_Caption;

    sdbm : Common.TSDBM;

    function Additional_Component_Show__Get() : boolean;
    function Component_Type_Get() : Common.TComponent_Type;
    procedure Connection_Status_Label__Translation__Apply();
    function Connection__Open( const component_type_f : Common.TComponent_Type = Common.ct_ADO ) : boolean;
    procedure Connections__Close();
    procedure Database__Data_Load();
    function Page_Control_Children_Find( page_control_f : TPageControl; const pccff_f : Common.TPage_Control_Children_Find_Function ) : boolean;
    function Quotation_Sign__DM() : string;
    function Splitter_Show__Get() : boolean;
    function Sql_Editor__Page__Close__One( const modal_result_f : TModalResult = mrNone ) : TModalResult;
    procedure Stored_Procedures_List__Stored_Procedure__Open__DM();
    procedure Stored_Procedures_List__Stored_Procedure__Open__Edit__DM();
    procedure Tables_List__Table__Open__DM();
    procedure Tables_List__Table__Data_Open__DM();
    procedure Views_List__View__Open__DM();
    procedure Views_List__View__Data_Open__DM();
    procedure Views_List__View__Open__Edit__DM();
  public
    { Public declarations }
    item_index_g : integer;
    databases_r__dm_g : Common.TDatabases_r;

    function Close_Can__Checked__Get() : boolean;
    procedure Close_Can__Checked__Set( const close_can__checked_f : boolean );
    function Connection_Test__DM( const component_type_f : Common.TComponent_Type = Common.ct_ADO ) : boolean;
    procedure Highlight__Font__Set__DM();
    procedure Options_Set__DM();
    procedure Prepare__DM( const connect_f : boolean = true );
    function Sql_Editor__Page__Close__All( const modal_result_f : TModalResult = mrNone ) : TModalResult;
    function Sql_Editor__Page__Count__Get() : integer;
    function Task_Running_Check__DM( var task_is_running_f : boolean ) : boolean;
  end;

const
  stored_procedure__drop__file_name_c : string = 'Stored_Procedure__Drop__sql.txt';
  stored_procedures_list__file_name_c : string = 'Stored_Procedures_List__sql.txt';
  table__drop__file_name_c : string = 'Table__Drop__sql.txt';
  view__drop__file_name_c : string = 'View__Drop__sql.txt';
  views_list__file_name_c : string = 'Views_List__sql.txt';

var
  Database__Modify_Form: TDatabase__Modify_Form;

implementation

uses
  System.TypInfo,
  Vcl.Clipbrd,

  Database__Informations_F,
  Exceptions_Modify_F,
  External_Functions_Modify_F,
  Generators_Modify_F,
  Roles_Modify_F,
  Shared,
  Sql_Editor_F,
  Stored_Procedure_Modify_F,
  Stored_Procedure__Modify,
  Table_Add,
  Table_Modify_F,
  Translation,
  Users_Modify_F,
  View_Modify_F,
  View__Modify;

{$R *.dfm}

function TDatabase__Modify_Form.Additional_Component_Show__Get() : boolean;
begin

  Result := Form_View__Additional_Component_Show_CheckBox.Checked;

end;

function TDatabase__Modify_Form.Close_Can__Checked__Get() : boolean;
begin

  Result := close_can__checked__dm;

end;

procedure TDatabase__Modify_Form.Close_Can__Checked__Set( const close_can__checked_f : boolean );
begin

  close_can__checked__dm := close_can__checked_f;

end;

function TDatabase__Modify_Form.Component_Type_Get() : Common.TComponent_Type;
begin

  if    (  Component_Type_ComboBox.ItemIndex >= integer(Low( Common.TComponent_Type ))  )
    and (  Component_Type_ComboBox.ItemIndex <= integer(High( Common.TComponent_Type ))  ) then
    Result := Common.TComponent_Type(Component_Type_ComboBox.ItemIndex)
  else
    Result := Common.ct_none;

end;

procedure TDatabase__Modify_Form.Connection_Status_Label__Translation__Apply();
begin

  case connection_status_caption_g of
      csc_Connected :
        Connection_Status_Label.Caption := Translation.translation__messages_r.word__connected;

      csc_Error :
        Connection_Status_Label.Caption := Translation.translation__messages_r.word__error;

      else
        Connection_Status_Label.Caption := Translation.translation__messages_r.word__disconnected;
    end;

end;

function TDatabase__Modify_Form.Connection__Open( const component_type_f : Common.TComponent_Type = Common.ct_ADO ) : boolean;
begin

  Result := false;

  if component_type_f = Common.ct_none then
    Exit;


  sdbm.component_type__sdbm := component_type_f;



  if Common.Database__Connection__Open( ADOConnection1, FDConnection1, databases_r__dm_g, Log_Memo, component_type_f ) = mrCancel then
    Exit;


  Result := true;


  if component_type_f = Common.ct_ADO then
    begin

      if ADOConnection1.Connected then
        begin

          connection_status_caption_g := csc_Connected;
          Connection_Status_Label.Font.Color := clGreen;

        end
      else
        begin

          Result := false;


          connection_status_caption_g := csc_Error;
          Connection_Status_Label.Font.Color := clRed;

        end;

    end
  else
  if component_type_f = Common.ct_FireDAC then
    begin

      if FDConnection1.Connected then
        begin

          connection_status_caption_g := csc_Connected;
          Connection_Status_Label.Font.Color := clGreen;

        end
      else
        begin

          Result := false;


          connection_status_caption_g := csc_Error;
          Connection_Status_Label.Font.Color := clRed;

        end;

    end;


  Connection_Status_Label__Translation__Apply();

end;

procedure TDatabase__Modify_Form.Connections__Close();
begin

  Common.Database__Connections__Close( ADOConnection1, FDConnection1 );


  connection_status_caption_g := csc_Disconnected;
  Connection_Status_Label.Font.Color := clWindowText;


  Connection_Status_Label__Translation__Apply();

end;

function TDatabase__Modify_Form.Connection_Test__DM( const component_type_f : Common.TComponent_Type = Common.ct_ADO ) : boolean;
begin

  Result := false;


  if component_type_f = Common.ct_none then
    Exit;


  Stored_Procedures_List__ListBox.Items.Clear();
  Tables_List__ListBox.Items.Clear();
  Views_List__ListBox.Items.Clear();


  Connections__Close();

  Result := Connection__Open( component_type_f );

  Connections__Close();

end;

procedure TDatabase__Modify_Form.Database__Data_Load();
var
  zti : integer;

  zts : string;

  database__informations_f_frame_l : Database__Informations_F.TDatabase__Informations_F_Frame;
  exceptions_modify_f_frame_l : Exceptions_Modify_F.TExceptions_Modify_F_Frame;
  external_functions_modify_f_frame_l : External_Functions_Modify_F.TExternal_Functions_Modify_F_Frame;
  generators_modify_f_frame_l : Generators_Modify_F.TGenerators_Modify_F_Frame;
  roles_modify_f_frame_l : Roles_Modify_F.TRoles_Modify_F_Frame;
  users_modify_f_frame_l : Users_Modify_F.TUsers_Modify_F_Frame;
begin

  if Main_PageControl.ActivePage = Database__Informations_TabSheet then
    begin

      if Database__Informations_TabSheet.ControlCount <= 0 then
        begin

          database__informations_f_frame_l := Database__Informations_F.TDatabase__Informations_F_Frame.Create( Application );
          database__informations_f_frame_l.Parent := Database__Informations_TabSheet;
          database__informations_f_frame_l.Align := alClient;
          database__informations_f_frame_l.Prepare__DIF( databases_r__dm_g, Component_Type_Get(), ADOConnection1, FDConnection1, Sql__Quotation_Sign__Use_CheckBox.Checked );

        end;

    end
  else
  if Main_PageControl.ActivePage = Exceptions_TabSheet then
    begin

      if Exceptions_TabSheet.ControlCount <= 0 then
        begin

          exceptions_modify_f_frame_l := Exceptions_Modify_F.TExceptions_Modify_F_Frame.Create( Application );
          exceptions_modify_f_frame_l.Parent := Exceptions_TabSheet;
          exceptions_modify_f_frame_l.Align := alClient;
          exceptions_modify_f_frame_l.Prepare__EMF( databases_r__dm_g, Component_Type_Get(), ADOConnection1, FDConnection1, Sql__Quotation_Sign__Use_CheckBox.Checked );

        end;

      if    ( Exceptions_TabSheet.ControlCount > 0 )
        and ( Exceptions_TabSheet.Controls[ 0 ].ClassType = Exceptions_Modify_F.TExceptions_Modify_F_Frame )
        and ( not Exceptions_Modify_F.TExceptions_Modify_F_Frame(Exceptions_TabSheet.Controls[ 0 ]).Data_Active__EMF() ) then
        Exceptions_Modify_F.TExceptions_Modify_F_Frame(Exceptions_TabSheet.Controls[ 0 ]).Data_Open__EMF();

    end
  else
  if Main_PageControl.ActivePage = External_Functions_TabSheet then
    begin

      if External_Functions_TabSheet.ControlCount <= 0 then
        begin

          external_functions_modify_f_frame_l := External_Functions_Modify_F.TExternal_Functions_Modify_F_Frame.Create( Application );
          external_functions_modify_f_frame_l.Parent := External_Functions_TabSheet;
          external_functions_modify_f_frame_l.Align := alClient;
          external_functions_modify_f_frame_l.Prepare__EFMF( databases_r__dm_g, Component_Type_Get(), ADOConnection1, FDConnection1, Splitter_Show_CheckBox.Checked, Sql__Quotation_Sign__Use_CheckBox.Checked );

        end;

      if    ( External_Functions_TabSheet.ControlCount > 0 )
        and ( External_Functions_TabSheet.Controls[ 0 ].ClassType = External_Functions_Modify_F.TExternal_Functions_Modify_F_Frame )
        and ( not External_Functions_Modify_F.TExternal_Functions_Modify_F_Frame(External_Functions_TabSheet.Controls[ 0 ]).Data_Active__EFMF() ) then
        External_Functions_Modify_F.TExternal_Functions_Modify_F_Frame(External_Functions_TabSheet.Controls[ 0 ]).Data_Open__EFMF();

    end
  else
  if Main_PageControl.ActivePage = Generators_List_TabSheet then
    begin

      if Generators_List_TabSheet.ControlCount <= 0 then
        begin

          generators_modify_f_frame_l := Generators_Modify_F.TGenerators_Modify_F_Frame.Create( Application );
          generators_modify_f_frame_l.Parent := Generators_List_TabSheet;
          generators_modify_f_frame_l.Align := alClient;
          generators_modify_f_frame_l.Prepare__GMF( databases_r__dm_g, Component_Type_Get(), ADOConnection1, FDConnection1, Sql__Quotation_Sign__Use_CheckBox.Checked );

        end;

      if    ( Generators_List_TabSheet.ControlCount > 0 )
        and ( Generators_List_TabSheet.Controls[ 0 ].ClassType = Generators_Modify_F.TGenerators_Modify_F_Frame )
        and ( not Generators_Modify_F.TGenerators_Modify_F_Frame(Generators_List_TabSheet.Controls[ 0 ]).Data_Active__GMF() ) then
        Generators_Modify_F.TGenerators_Modify_F_Frame(Generators_List_TabSheet.Controls[ 0 ]).Data_Open__GMF();

    end
  else
  if Main_PageControl.ActivePage = Roles_List_TabSheet then
    begin

      if Roles_List_TabSheet.ControlCount <= 0 then
        begin

          roles_modify_f_frame_l := Roles_Modify_F.TRoles_Modify_F_Frame.Create( Application );
          roles_modify_f_frame_l.Parent := Roles_List_TabSheet;
          roles_modify_f_frame_l.Align := alClient;
          roles_modify_f_frame_l.Prepare__RMF( databases_r__dm_g, Component_Type_Get(), ADOConnection1, FDConnection1, Sql__Quotation_Sign__Use_CheckBox.Checked );

        end;

      if    ( Roles_List_TabSheet.ControlCount > 0 )
        and ( Roles_List_TabSheet.Controls[ 0 ].ClassType = Roles_Modify_F.TRoles_Modify_F_Frame )
        and ( not Roles_Modify_F.TRoles_Modify_F_Frame(Roles_List_TabSheet.Controls[ 0 ]).Data_Active__RMF() ) then
        Roles_Modify_F.TRoles_Modify_F_Frame(Roles_List_TabSheet.Controls[ 0 ]).Data_Open__RMF();

    end
  else
  if    ( Main_PageControl.ActivePage = Sql_Editor_TabSheet )
    and ( Sql_Editor__PageControl.PageCount <= 0 ) then
    begin

      Sql_Editor__Page__New_ButtonClick( nil );

    end
  else
  if    ( Main_PageControl.ActivePage = Stored_Procedures_List_TabSheet )
    and ( Stored_Procedures_List__ListBox.Items.Count <= 0 ) then
    begin

      {$region 'Stored procedures.'}
      Screen.Cursor := crHourGlass;


      Stored_Procedures_List__ListBox.Items.Clear();

      zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + stored_procedures_list__file_name_c  );

      if Trim( zts ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + stored_procedures_list__file_name_c + ').' );

          zts :=
            'select RDB$PROCEDURES.RDB$PROCEDURE_NAME as STORED_PROCEDURE_NAME ' +
            '     , RDB$PROCEDURES.RDB$PROCEDURE_ID ' +
            'from RDB$PROCEDURES ' +
            'order by RDB$PROCEDURES.RDB$PROCEDURE_NAME ';

        end;


      if sdbm.Query__Active() then
        sdbm.Query__Close();

      sdbm.Query__Sql__Set( zts );


      Log_Memo.Lines.Add( zts );


      try
        sdbm.Query__Open();
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_load_stored_procedures_list_ + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;

      if sdbm.Query__Active() then
        begin

          Log_Memo.Lines.Add( sdbm.Operation_Duration_Get() );


          try
            sdbm.Query__Field_By_Name( Common.name__stored_procedure__big_letters_c ).AsString;
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                sdbm.Query__Close();

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_stored_procedure_name_ + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

              end;
          end;


          if sdbm.Query__Active() then
            begin

              while not sdbm.Query__Eof() do
                begin

                  Stored_Procedures_List__ListBox.Items.Add(   Trim(  sdbm.Query__Field_By_Name( Common.name__stored_procedure__big_letters_c ).AsString  )   ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

                  sdbm.Query__Next();

                end;


              Stored_Procedures_List_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', sdbm.Query__Record_Count() )  ); // FireDAC RowsetSize.

            end;

        end;


      if stored_procedure_name_g <> '' then
        begin

          for zti := 0 to Stored_Procedures_List__ListBox.Items.Count - 1 do
            if Stored_Procedures_List__ListBox.Items[ zti ] = stored_procedure_name_g then
              begin

                Stored_Procedures_List__ListBox.ItemIndex := zti;

                Break;

              end;

          stored_procedure_name_g := '';

        end
      else
        if Stored_Procedures_List__ListBox.Items.Count > 0 then
          Stored_Procedures_List__ListBox.ItemIndex := 0;


      Screen.Cursor := crDefault;
      {$endregion 'Stored procedures.'}

    end
  else
  if    ( Main_PageControl.ActivePage = Tables_List_TabSheet )
    and ( Tables_List__ListBox.Items.Count <= 0 ) then
    begin

      {$region 'Tables.'}
      Screen.Cursor := crHourGlass;


      Tables_List__ListBox.Items.Clear();

      zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + Common.tables_list__file_name_c  );

      if Trim( zts ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + Common.tables_list__file_name_c + ').' );

          zts :=
            'select RDB$RELATIONS.RDB$RELATION_NAME as TABLE_NAME ' +
            '     , RDB$RELATIONS.RDB$SECURITY_CLASS ' +
            '     , cast(  substring( RDB$RELATIONS.RDB$SECURITY_CLASS from 5 for 5 ) as integer  ) as ID ' +
            'from RDB$RELATIONS ' +
            'where RDB$RELATIONS.RDB$SECURITY_CLASS is not null ' +
            '  and RDB$RELATIONS.RDB$SECURITY_CLASS <> ''SQL$1'' ' +
            '  and RDB$RELATIONS.RDB$SECURITY_CLASS <> ''SQL$2'' ' +
            '  and RDB$RELATIONS.RDB$SECURITY_CLASS <> ''SQL$3'' ' +
            '  and RDB$RELATIONS.RDB$VIEW_BLR is null ' +
            '  and ( ' +
            '           RDB$RELATIONS.RDB$RELATION_NAME not like ''%$%'' ' +
            '        or 1 = :system_tables_visible ' +
            '      ) ' +
            'order by RDB$RELATIONS.RDB$RELATION_NAME ';

        end;


      if sdbm.Query__Active() then
        sdbm.Query__Close();

      sdbm.Query__Sql__Set( zts );


      Log_Memo.Lines.Add( zts );


      if Common.system_tables_visible then
        zti := 1
      else
        zti := 0;

      sdbm.Query__Param_By_Name__Set( Common.tables_list__system_tables_visible__parameter_name_c, zti, Log_Memo );

      try
        sdbm.Query__Open();
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_load_tables_list_ + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;

      if sdbm.Query__Active() then
        begin

          Log_Memo.Lines.Add( sdbm.Operation_Duration_Get() );


          try
            sdbm.Query__Field_By_Name( Common.name__table__big_letters_c ).AsString;
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                sdbm.Query__Close();

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_table_name_ + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

              end;
          end;


          if sdbm.Query__Active() then
            begin

              while not sdbm.Query__Eof() do
                begin

                  Tables_List__ListBox.Items.Add(   Trim(  sdbm.Query__Field_By_Name( Common.name__table__big_letters_c ).AsString  )   ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

                  sdbm.Query__Next();

                end;


              Tables_List_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', sdbm.Query__Record_Count() )  ); // FireDAC RowsetSize.

            end;

        end;



      if table_name_g <> '' then
        begin

          for zti := 0 to Tables_List__ListBox.Items.Count - 1 do
            if Tables_List__ListBox.Items[ zti ] = table_name_g then
              begin

                Tables_List__ListBox.ItemIndex := zti;

                Break;

              end;

          table_name_g := '';

        end
      else
      if Tables_List__ListBox.Items.Count > 0 then
        Tables_List__ListBox.ItemIndex := 0;


      Screen.Cursor := crDefault;
      {$endregion 'Tables.'}

    end
  else
  if Main_PageControl.ActivePage = Users_List_TabSheet then
    begin

      if Users_List_TabSheet.ControlCount <= 0 then
        begin

          users_modify_f_frame_l := Users_Modify_F.TUsers_Modify_F_Frame.Create( Application );
          users_modify_f_frame_l.Parent := Users_List_TabSheet;
          users_modify_f_frame_l.Align := alClient;
          users_modify_f_frame_l.Prepare__UMF( databases_r__dm_g, Component_Type_Get(), ADOConnection1, FDConnection1, Sql__Quotation_Sign__Use_CheckBox.Checked );

        end;

      if    ( Users_List_TabSheet.ControlCount > 0 )
        and ( Users_List_TabSheet.Controls[ 0 ].ClassType = Users_Modify_F.TUsers_Modify_F_Frame )
        and ( not Users_Modify_F.TUsers_Modify_F_Frame(Users_List_TabSheet.Controls[ 0 ]).Data_Active__UMF() ) then
        Users_Modify_F.TUsers_Modify_F_Frame(Users_List_TabSheet.Controls[ 0 ]).Data_Open__UMF();

    end
  else
  if    ( Main_PageControl.ActivePage = Views_List_TabSheet )
    and ( Views_List__ListBox.Items.Count <= 0 ) then
    begin

      {$region 'Views.'}
      Screen.Cursor := crHourGlass;


      Views_List__ListBox.Items.Clear();

      zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + views_list__file_name_c  );

      if Trim( zts ) = '' then
        begin

          Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + views_list__file_name_c + ').' );

          zts :=
            'select RDB$RELATIONS.RDB$RELATION_NAME as VIEW_NAME ' +
            '     , RDB$RELATIONS.RDB$SECURITY_CLASS ' +
            '     , cast(  substring( RDB$RELATIONS.RDB$SECURITY_CLASS from 5 for 5 ) as integer  ) as ID ' +
            'from RDB$RELATIONS ' +
            'where RDB$RELATIONS.RDB$VIEW_BLR is not null ' +
            '  and ( ' +
            '           RDB$RELATIONS.RDB$SYSTEM_FLAG is null ' +
            '        or RDB$RELATIONS.RDB$SYSTEM_FLAG = 0 ' +
            '        or 1 = :system_tables_visible ' +
            '      ) ' +
            'order by RDB$RELATIONS.RDB$RELATION_NAME ';

        end;


      if sdbm.Query__Active() then
        sdbm.Query__Close();

      sdbm.Query__Sql__Set( zts );


      Log_Memo.Lines.Add( zts );


      if Common.system_tables_visible then
        zti := 1
      else
        zti := 0;

      sdbm.Query__Param_By_Name__Set( Common.tables_list__system_tables_visible__parameter_name_c, zti, Log_Memo );

      try
        sdbm.Query__Open();
      except
        on E : Exception do
          begin

            Screen.Cursor := crDefault;

            Log_Memo.Lines.Add( E.Message );

            Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_load_views_list_ + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

          end;
      end;

      if sdbm.Query__Active() then
        begin

          Log_Memo.Lines.Add( sdbm.Operation_Duration_Get() );


          try
            sdbm.Query__Field_By_Name( Common.name__view__big_letters_c ).AsString;
          except
            on E : Exception do
              begin

                Screen.Cursor := crDefault;

                sdbm.Query__Close();

                Log_Memo.Lines.Add( E.Message );

                Application.MessageBox( PChar(Translation.translation__messages_r.failed_to_read_view_name_ + #13 + #13 + E.Message + #13 + #13 + zts + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

              end;
          end;


          if sdbm.Query__Active() then
            begin

              while not sdbm.Query__Eof() do
                begin

                  Views_List__ListBox.Items.Add(   Trim(  sdbm.Query__Field_By_Name( Common.name__view__big_letters_c ).AsString  )   ); // ADO add spaces at the end to 32 characters e.g. 'COLUMN_NAME_1                  '.

                  sdbm.Query__Next();

                end;


              Views_List_Count_Label.Caption := Trim(  FormatFloat( '### ### ### ### ### ### ##0', sdbm.Query__Record_Count() )  ); // FireDAC RowsetSize.

            end;

        end;



      if view_name_g <> '' then
        begin

          for zti := 0 to Views_List__ListBox.Items.Count - 1 do
            if Views_List__ListBox.Items[ zti ] = view_name_g then
              begin

                Views_List__ListBox.ItemIndex := zti;

                Break;

              end;

          view_name_g := '';

        end
      else
      if Views_List__ListBox.Items.Count > 0 then
        Views_List__ListBox.ItemIndex := 0;


      Screen.Cursor := crDefault;
      {$endregion 'Views.'}

    end;


  if sdbm.Query__Active() then
    sdbm.Query__Close();

  sdbm.Query__Sql__Set( '' );

end;

procedure TDatabase__Modify_Form.Highlight__Font__Set__DM();
begin

  Common.Font__Set( Log_Memo.Font, Common.sql_editor__font );

  if Common.sql_editor__font__use_in_other_components then
    begin

      Common.Font__Set( Stored_Procedures_List__ListBox.Font, Common.sql_editor__font );
      Common.Font__Set( Tables_List__ListBox.Font, Common.sql_editor__font );
      Common.Font__Set( Views_List__ListBox.Font, Common.sql_editor__font );

    end;

end;

procedure TDatabase__Modify_Form.Options_Set__DM();
begin

  FDQuery1.FetchOptions.Mode := Common.fire_dac__fetch_options__mode;
  FDQuery1.FetchOptions.RecordCountMode := Common.fire_dac__fetch_options__record_count_mode;
  FDQuery1.FetchOptions.RowsetSize := Common.fire_dac__fetch_options__rowset_size;


  Translation.Translation__Apply( Self );

  Self.Caption := Self.Caption + ' - ' + databases_r__dm_g.alias;
  Component_Type_Default_Label.Caption := Translation.translation__messages_r.default__with_a_capital_letter + ': ' + StringReplace(  System.TypInfo.GetEnumName( System.TypeInfo(Common.TComponent_Type), integer(databases_r__dm_g.component_type) ), 'ct_', '', [ rfReplaceAll ]  );
  Database_Name_Label.Caption := Database_Name_Label.Caption + ' ' + databases_r__dm_g.alias;
  Sql_Editor__Database_Connection__Separated_CheckBox.Checked := Common.sql_editor__database_connection__separated;

  Connection_Status_Label__Translation__Apply();


  Highlight__Font__Set__DM();


  Page_Control_Children_Find( Main_PageControl, Common.pccff_Highlight_Font_Set );

  Page_Control_Children_Find( Main_PageControl, Common.pccff_Translation__Apply );

end;

function TDatabase__Modify_Form.Page_Control_Children_Find( page_control_f : TPageControl; const pccff_f : Common.TPage_Control_Children_Find_Function ) : boolean;
var
  i,
  j
    : integer;
begin

  Result := false;


  for i := 0 to page_control_f.PageCount - 1 do
    for j := 0 to page_control_f.Pages[ i ].ControlCount - 1 do
      if page_control_f.Pages[ i ].Controls[ j ].ClassType = TPageControl then
        begin

          Result := Page_Control_Children_Find( TPageControl(page_control_f.Pages[ i ].Controls[ j ]), pccff_f );

          if    ( pccff_f in [ Common.pccff_Task_Running_Check ] )
            and ( Result ) then
            Exit;

        end
      else
        case pccff_f of
            Common.pccff_Highlight_Font_Set :
              begin

                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Database__Informations_F.TDatabase__Informations_F_Frame then
                  Database__Informations_F.TDatabase__Informations_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Highlight__Font__Set__DIF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Exceptions_Modify_F.TExceptions_Modify_F_Frame then
                  Exceptions_Modify_F.TExceptions_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Highlight__Font__Set__EMF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = External_Functions_Modify_F.TExternal_Functions_Modify_F_Frame then
                  External_Functions_Modify_F.TExternal_Functions_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Highlight__Font__Set__EFMF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Generators_Modify_F.TGenerators_Modify_F_Frame then
                  Generators_Modify_F.TGenerators_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Highlight__Font__Set__GMF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Roles_Modify_F.TRoles_Modify_F_Frame then
                  Roles_Modify_F.TRoles_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Highlight__Font__Set__RMF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Sql_Editor_F.TSql_Editor_F_Frame then
                  Sql_Editor_F.TSql_Editor_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Highlight__Font__Set__SEF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame then
                  Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Highlight__Font__Set__SPMF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Table_Modify_F.TTable_Modify_F_Frame then
                  Table_Modify_F.TTable_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Highlight__Font__Set__TMoF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Users_Modify_F.TUsers_Modify_F_Frame then
                  Users_Modify_F.TUsers_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Highlight__Font__Set__UMF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = View_Modify_F.TView_Modify_F_Frame then
                  View_Modify_F.TView_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Highlight__Font__Set__VMF();

              end;

            Common.pccff_Options_Set :
              begin

                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Database__Informations_F.TDatabase__Informations_F_Frame then
                  Database__Informations_F.TDatabase__Informations_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Options_Set__DIF( Component_Type_Get(), databases_r__dm_g.sql__quotation_sign, Sql__Quotation_Sign__Use_CheckBox.Checked )
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Exceptions_Modify_F.TExceptions_Modify_F_Frame then
                  Exceptions_Modify_F.TExceptions_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Options_Set__EMF( Component_Type_Get(), databases_r__dm_g.sql__quotation_sign, Sql__Quotation_Sign__Use_CheckBox.Checked )
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = External_Functions_Modify_F.TExternal_Functions_Modify_F_Frame then
                  External_Functions_Modify_F.TExternal_Functions_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Options_Set__EFMF( Component_Type_Get(), databases_r__dm_g.sql__quotation_sign, Splitter_Show_CheckBox.Checked, Sql__Quotation_Sign__Use_CheckBox.Checked )
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Generators_Modify_F.TGenerators_Modify_F_Frame then
                  Generators_Modify_F.TGenerators_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Options_Set__GMF( Component_Type_Get(), databases_r__dm_g.sql__quotation_sign, Sql__Quotation_Sign__Use_CheckBox.Checked )
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Roles_Modify_F.TRoles_Modify_F_Frame then
                  Roles_Modify_F.TRoles_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Options_Set__RMF( Component_Type_Get(), databases_r__dm_g.sql__quotation_sign, Sql__Quotation_Sign__Use_CheckBox.Checked )
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Sql_Editor_F.TSql_Editor_F_Frame then
                  Sql_Editor_F.TSql_Editor_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Options_Set__SEF( Component_Type_Get(), databases_r__dm_g.sql__quotation_sign, Queries_Open_In_Background_CheckBox.Checked, Sql__Quotation_Sign__Use_CheckBox.Checked )
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame then
                  Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Options_Set__SPMF( Component_Type_Get(), databases_r__dm_g.sql__quotation_sign, Queries_Open_In_Background_CheckBox.Checked, Splitter_Show_CheckBox.Checked, Sql__Quotation_Sign__Use_CheckBox.Checked )
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Table_Modify_F.TTable_Modify_F_Frame then
                  Table_Modify_F.TTable_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Options_Set__TMoF( Component_Type_Get(), databases_r__dm_g.sql__quotation_sign, Form_View__Additional_Component_Show_CheckBox.Checked, Queries_Open_In_Background_CheckBox.Checked, Splitter_Show_CheckBox.Checked, Sql__Quotation_Sign__Use_CheckBox.Checked )
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Users_Modify_F.TUsers_Modify_F_Frame then
                  Users_Modify_F.TUsers_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Options_Set__UMF( Component_Type_Get(), databases_r__dm_g.sql__quotation_sign, Sql__Quotation_Sign__Use_CheckBox.Checked )
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = View_Modify_F.TView_Modify_F_Frame then
                  View_Modify_F.TView_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Options_Set__VMF( Component_Type_Get(), databases_r__dm_g.sql__quotation_sign, Queries_Open_In_Background_CheckBox.Checked, Splitter_Show_CheckBox.Checked, Sql__Quotation_Sign__Use_CheckBox.Checked );

              end;

            Common.pccff_Task_Running_Check :
              begin

                if   (
                           ( page_control_f.Pages[ i ].Controls[ j ].ClassType = Sql_Editor_F.TSql_Editor_F_Frame )
                       and (  Sql_Editor_F.TSql_Editor_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Task_Running_Check__SEF( false )  )
                     )
                  or (
                           ( page_control_f.Pages[ i ].Controls[ j ].ClassType = Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame )
                       and (  Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Task_Running_Check__SPMF( false )  )
                     )
                  or (
                           ( page_control_f.Pages[ i ].Controls[ j ].ClassType = Table_Modify_F.TTable_Modify_F_Frame )
                       and (  Table_Modify_F.TTable_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Task_Running_Check__TMoF( false )  )
                     )
                  or (
                           ( page_control_f.Pages[ i ].Controls[ j ].ClassType = View_Modify_F.TView_Modify_F_Frame )
                       and (  View_Modify_F.TView_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Task_Running_Check__VMF( false )  )
                     ) then
                  begin

                    Result := true;
                    Exit;

                  end;

              end;

            Common.pccff_Translation__Apply :
              begin

                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Database__Informations_F.TDatabase__Informations_F_Frame then
                  Database__Informations_F.TDatabase__Informations_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Translation__Apply__DIF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Exceptions_Modify_F.TExceptions_Modify_F_Frame then
                  Exceptions_Modify_F.TExceptions_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Translation__Apply__EMF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = External_Functions_Modify_F.TExternal_Functions_Modify_F_Frame then
                  External_Functions_Modify_F.TExternal_Functions_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Translation__Apply__EFMF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Generators_Modify_F.TGenerators_Modify_F_Frame then
                  Generators_Modify_F.TGenerators_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Translation__Apply__GMF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Roles_Modify_F.TRoles_Modify_F_Frame then
                  Roles_Modify_F.TRoles_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Translation__Apply__RMF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Sql_Editor_F.TSql_Editor_F_Frame then
                  Sql_Editor_F.TSql_Editor_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Translation__Apply__SEF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame then
                  Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Translation__Apply__SPMF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Table_Modify_F.TTable_Modify_F_Frame then
                  Table_Modify_F.TTable_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Translation__Apply__TMoF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = Users_Modify_F.TUsers_Modify_F_Frame then
                  Users_Modify_F.TUsers_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Translation__Apply__UMF()
                else
                if page_control_f.Pages[ i ].Controls[ j ].ClassType = View_Modify_F.TView_Modify_F_Frame then
                  View_Modify_F.TView_Modify_F_Frame(page_control_f.Pages[ i ].Controls[ j ]).Translation__Apply__VMF();

              end;
          end;

end;

procedure TDatabase__Modify_Form.Prepare__DM( const connect_f : boolean = true );
var
  component_type_l : Common.TComponent_Type;
begin

  Self.Options_Set__DM();


  sdbm := Common.TSDBM.Create( ADOConnection1, FDConnection1, ADOQuery1, FDQuery1 );
  sdbm.component_type__sdbm := databases_r__dm_g.component_type;


  Component_Type_ComboBox.Clear();

  for component_type_l := Low( Common.TComponent_Type ) to High( Common.TComponent_Type ) do
    begin

      Component_Type_ComboBox.Items.Add(   StringReplace(  System.TypInfo.GetEnumName( System.TypeInfo(Common.TComponent_Type), integer(component_type_l) ), 'ct_', '', [ rfReplaceAll ]  )   );


      if component_type_l = databases_r__dm_g.component_type then
        Component_Type_ComboBox.ItemIndex := Component_Type_ComboBox.Items.Count - 1;

    end;


  Form_View__Additional_Component_Show_CheckBox.Checked := Common.form_view__additional_component_show;
  Splitter_Show_CheckBox.Checked := Common.splitter_show;

  Queries_Open_In_Background_CheckBox.Checked := Common.queries_open_in_background;
  Sql__Quotation_Sign__Use_CheckBox.Checked := Common.sql__quotation_sign__use;


  if connect_f then
    Connection__Open( Component_Type_Get() );


  //???
  //Database__Informations_TabSheet.TabVisible := FileExists(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + Common.database__informations__attributes_list__file_name_c  ); // If need move the declaration database__informations__attributes_list__file_name_c from Database__Informations_Modify_F to Common.
  //Exceptions_TabSheet.TabVisible := FileExists(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + Exceptions_Modify_F.exceptions_list__file_name_c  );
  //External_Functions_TabSheet.TabVisible := FileExists(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + External_Functions_Modify_F.external_functions_list__file_name_c  );
  //Generators_List_TabSheet.TabVisible := FileExists(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + Generators_Modify_F.generators_list__file_name_c  );
  //Roles_List_TabSheet.TabVisible := FileExists(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + Roles_Modify_F.roles_list__file_name_c  );
  //Stored_Procedures_List_TabSheet.TabVisible := FileExists(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + stored_procedures_list__file_name_c  );
  //Tables_List_TabSheet.TabVisible := FileExists(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + Common.tables_list__file_name_c  );
  //Users_List_TabSheet.TabVisible := FileExists(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + Users_Modify_F.users_list__file_name_c  );
  //Views_List_TabSheet.TabVisible := FileExists(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + views_list__file_name_c  );

end;

function TDatabase__Modify_Form.Quotation_Sign__DM() : string;
begin

  if Sql__Quotation_Sign__Use_CheckBox.Checked then
    begin

      Result := databases_r__dm_g.sql__quotation_sign;

    end
  else
    Result := '';

end;

function TDatabase__Modify_Form.Splitter_Show__Get() : boolean;
begin

  Result := Splitter_Show_CheckBox.Checked;

end;

function TDatabase__Modify_Form.Sql_Editor__Page__Close__All( const modal_result_f : TModalResult = mrNone ) : TModalResult;
var
  i : integer;
begin

  if modal_result_f = mrYesToAll then
    Result := mrYesToAll
  else
    Result := mrNone;


  for i := Sql_Editor__PageControl.PageCount - 1 downto 0 do
    begin

      Sql_Editor__PageControl.ActivePageIndex := i;

      Result := Sql_Editor__Page__Close__One( Result );


      if Result = mrCancel then
        Break;

    end;

end;

function TDatabase__Modify_Form.Sql_Editor__Page__Close__One( const modal_result_f : TModalResult = mrNone ) : TModalResult;
var
  last_tab_is_closing_l : boolean;
begin

  if modal_result_f = mrYesToAll then
    Result := mrYesToAll
  else
    Result := mrNone;


  if    ( Sql_Editor__PageControl.PageCount > 0 )
    and ( Sql_Editor__PageControl.ActivePageIndex >= 0 )
    and ( Sql_Editor__PageControl.Pages[ Sql_Editor__PageControl.ActivePageIndex ].PageIndex <= Sql_Editor__PageControl.PageCount - 1 )
    and ( Sql_Editor__PageControl.Pages[ Sql_Editor__PageControl.ActivePageIndex ].ControlCount > 0 )
    and ( Sql_Editor__PageControl.Pages[ Sql_Editor__PageControl.ActivePageIndex ].Controls[ 0 ].ClassType = Sql_Editor_F.TSql_Editor_F_Frame )
    and (  Sql_Editor_F.TSql_Editor_F_Frame(Sql_Editor__PageControl.Pages[ Sql_Editor__PageControl.ActivePageIndex ].Controls[ 0 ]).Finish__SEF( Result )  ) then
    begin

      last_tab_is_closing_l :=
            ( Sql_Editor__PageControl.PageCount > 1 )
        and ( Sql_Editor__PageControl.ActivePageIndex = Sql_Editor__PageControl.PageCount - 1 );


      FreeAndNil( Sql_Editor__PageControl.Pages[ Sql_Editor__PageControl.ActivePageIndex ] );


      if last_tab_is_closing_l then
        Sql_Editor__PageControl.ActivePageIndex := Sql_Editor__PageControl.PageCount - 1;


      if Sql_Editor__PageControl.PageCount <= 0 then
        sql_editor__tabs__count_total_g := 0;

    end;

end;

function TDatabase__Modify_Form.Sql_Editor__Page__Count__Get() : integer;
begin

  Result := Sql_Editor__PageControl.PageCount;

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Stored_Procedure__Open__DM();
var
  tab_sheet_l : TTabSheet;
  stored_procedure_modify_f_frame_l : Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame;
begin

  if   ( Stored_Procedures_List__ListBox.Items.Count <= 0 )
    or ( Stored_Procedures_List__ListBox.ItemIndex < 0 )
    or ( Stored_Procedures_List__ListBox.ItemIndex >= Stored_Procedures_List__ListBox.Items.Count ) then
    Exit;


  tab_sheet_l := TTabSheet.Create( Application );
  tab_sheet_l.Caption := Stored_Procedures_List__ListBox.Items[ Stored_Procedures_List__ListBox.ItemIndex ];
  tab_sheet_l.PageControl := Stored_Procedures_List__PageControl;
  Stored_Procedures_List__PageControl.ActivePageIndex := Stored_Procedures_List__PageControl.PageCount - 1;


  stored_procedure_modify_f_frame_l := Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame.Create( Application );
  stored_procedure_modify_f_frame_l.Parent := tab_sheet_l;
  stored_procedure_modify_f_frame_l.Align := alClient;
  stored_procedure_modify_f_frame_l.Additional_Component_Show__Get_wsk := Additional_Component_Show__Get;
  stored_procedure_modify_f_frame_l.Splitter_Show__Get_wsk := Splitter_Show__Get;
  stored_procedure_modify_f_frame_l.Prepare__SPMF( databases_r__dm_g, Stored_Procedures_List__ListBox.Items[ Stored_Procedures_List__ListBox.ItemIndex ], Component_Type_Get(), ADOConnection1, FDConnection1, Queries_Open_In_Background_CheckBox.Checked, Splitter_Show_CheckBox.Checked, Sql__Quotation_Sign__Use_CheckBox.Checked );

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Stored_Procedure__Open__Edit__DM();
begin

  Stored_Procedures_List__Stored_Procedure__Open__DM();


  if    ( Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.PageCount - 1 ].ControlCount > 0 )
    and ( Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.PageCount - 1 ].Controls[ Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.PageCount - 1 ].ControlCount - 1 ].ClassType = Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame ) then
    Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame(Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.PageCount - 1 ].Controls[ Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.PageCount - 1 ].ControlCount - 1 ]).Stored_Procedure__Edit__SPMF();

end;

procedure TDatabase__Modify_Form.Tables_List__Table__Open__DM();
var
  tab_sheet_l : TTabSheet;
  table_modify_f_frame_l : Table_Modify_F.TTable_Modify_F_Frame;
begin

  if   ( Tables_List__ListBox.Items.Count <= 0 )
    or ( Tables_List__ListBox.ItemIndex < 0 )
    or ( Tables_List__ListBox.ItemIndex >= Tables_List__ListBox.Items.Count ) then
    Exit;


  tab_sheet_l := TTabSheet.Create( Application );
  tab_sheet_l.Caption := Tables_List__ListBox.Items[ Tables_List__ListBox.ItemIndex ];
  tab_sheet_l.PageControl := Tables_List__PageControl;
  Tables_List__PageControl.ActivePageIndex := Tables_List__PageControl.PageCount - 1;


  table_modify_f_frame_l := Table_Modify_F.TTable_Modify_F_Frame.Create( Application );
  table_modify_f_frame_l.Parent := tab_sheet_l;
  table_modify_f_frame_l.Align := alClient;
  table_modify_f_frame_l.Additional_Component_Show__Get_wsk := Additional_Component_Show__Get;
  table_modify_f_frame_l.Splitter_Show__Get_wsk := Splitter_Show__Get;
  table_modify_f_frame_l.Prepare__TMoF( databases_r__dm_g, Tables_List__ListBox.Items[ Tables_List__ListBox.ItemIndex ], Component_Type_Get(), ADOConnection1, FDConnection1, Form_View__Additional_Component_Show_CheckBox.Checked, Queries_Open_In_Background_CheckBox.Checked, Splitter_Show_CheckBox.Checked, Sql__Quotation_Sign__Use_CheckBox.Checked );

end;

procedure TDatabase__Modify_Form.Tables_List__Table__Data_Open__DM();
begin

  Tables_List__Table__Open__DM();


  if    ( Tables_List__PageControl.Pages[ Tables_List__PageControl.PageCount - 1 ].ControlCount > 0 )
    and ( Tables_List__PageControl.Pages[ Tables_List__PageControl.PageCount - 1 ].Controls[ Tables_List__PageControl.Pages[ Tables_List__PageControl.PageCount - 1 ].ControlCount - 1 ].ClassType = Table_Modify_F.TTable_Modify_F_Frame ) then
    Table_Modify_F.TTable_Modify_F_Frame(Tables_List__PageControl.Pages[ Tables_List__PageControl.PageCount - 1 ].Controls[ Tables_List__PageControl.Pages[ Tables_List__PageControl.PageCount - 1 ].ControlCount - 1 ]).Table__Data_Open__TMoF();

end;

function TDatabase__Modify_Form.Task_Running_Check__DM( var task_is_running_f : boolean ) : boolean;
begin

  Result := Page_Control_Children_Find( Main_PageControl, Common.pccff_Task_Running_Check );

  task_is_running_f := Result;

end;

procedure TDatabase__Modify_Form.Views_List__View__Open__DM();
var
  tab_sheet_l : TTabSheet;
  view_modify_f_frame_l : View_Modify_F.TView_Modify_F_Frame;
begin

  if   ( Views_List__ListBox.Items.Count <= 0 )
    or ( Views_List__ListBox.ItemIndex < 0 )
    or ( Views_List__ListBox.ItemIndex >= Views_List__ListBox.Items.Count ) then
    Exit;


  tab_sheet_l := TTabSheet.Create( Application );
  tab_sheet_l.Caption := Views_List__ListBox.Items[ Views_List__ListBox.ItemIndex ];
  tab_sheet_l.PageControl := Views_List__PageControl;
  Views_List__PageControl.ActivePageIndex := Views_List__PageControl.PageCount - 1;


  view_modify_f_frame_l := View_Modify_F.TView_Modify_F_Frame.Create( Application );
  view_modify_f_frame_l.Parent := tab_sheet_l;
  view_modify_f_frame_l.Align := alClient;
  view_modify_f_frame_l.Additional_Component_Show__Get_wsk := Additional_Component_Show__Get;
  view_modify_f_frame_l.Splitter_Show__Get_wsk := Splitter_Show__Get;
  view_modify_f_frame_l.Prepare__VMF( databases_r__dm_g, Views_List__ListBox.Items[ Views_List__ListBox.ItemIndex ], Component_Type_Get(), ADOConnection1, FDConnection1, Queries_Open_In_Background_CheckBox.Checked, Splitter_Show_CheckBox.Checked, Sql__Quotation_Sign__Use_CheckBox.Checked );

end;

procedure TDatabase__Modify_Form.Views_List__View__Data_Open__DM();
begin

  Views_List__View__Open__DM();


  if    ( Views_List__PageControl.Pages[ Views_List__PageControl.PageCount - 1 ].ControlCount > 0 )
    and ( Views_List__PageControl.Pages[ Views_List__PageControl.PageCount - 1 ].Controls[ Views_List__PageControl.Pages[ Views_List__PageControl.PageCount - 1 ].ControlCount - 1 ].ClassType = View_Modify_F.TView_Modify_F_Frame ) then
    View_Modify_F.TView_Modify_F_Frame(Views_List__PageControl.Pages[ Views_List__PageControl.PageCount - 1 ].Controls[ Views_List__PageControl.Pages[ Views_List__PageControl.PageCount - 1 ].ControlCount - 1 ]).View__Data_Open__VMF();

end;

procedure TDatabase__Modify_Form.Views_List__View__Open__Edit__DM();
begin

  Views_List__View__Open__DM();


  if    ( Views_List__PageControl.Pages[ Views_List__PageControl.PageCount - 1 ].ControlCount > 0 )
    and ( Views_List__PageControl.Pages[ Views_List__PageControl.PageCount - 1 ].Controls[ Views_List__PageControl.Pages[ Views_List__PageControl.PageCount - 1 ].ControlCount - 1 ].ClassType = View_Modify_F.TView_Modify_F_Frame ) then
    View_Modify_F.TView_Modify_F_Frame(Views_List__PageControl.Pages[ Views_List__PageControl.PageCount - 1 ].Controls[ Views_List__PageControl.Pages[ Views_List__PageControl.PageCount - 1 ].ControlCount - 1 ]).View__Edit__VMF();

end;

procedure TDatabase__Modify_Form.FormCreate( Sender: TObject );
begin

  id_search__stored_procedures_list_g := -1;
  id_search__tables_list_g := -1;
  id_search__views__list_g := -1;
  connection_status_caption_g := csc_Disconnected;
  item_index_g := -1;
  sql_editor__tabs__count_total_g := 0;
  stored_procedure_name_g := '';
  table_name_g := '';
  view_name_g := '';

  Close_Can__Checked__Set( false );

  //FDConnection1.FormatOptions.MaxStringSize := Common.fd_connection__format_options__max_string_size;

end;

procedure TDatabase__Modify_Form.FormShow( Sender: TObject );
begin

  Main_PageControl.Align := alClient;
  Main_PageControl.ActivePage := Component_Type_TabSheet;

end;

procedure TDatabase__Modify_Form.FormClose( Sender: TObject; var Action: TCloseAction );
var
  i,
  j
    : integer;
begin

  if Page_Control_Children_Find( Main_PageControl, Common.pccff_Task_Running_Check ) then
    begin

      Action := TCloseAction.caNone;

      Application.MessageBox( PChar(Translation.translation__messages_r.tasks_are_still_running_wait_until_finish), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );

      Exit;

    end;


  for i := 0 to Main_PageControl.PageCount - 1 do
    for j := 0 to Main_PageControl.Pages[ i ].ControlCount - 1 do
      if Main_PageControl.Pages[ i ].Controls[ j ].ClassType = Database__Informations_F.TDatabase__Informations_F_Frame then
        Database__Informations_F.TDatabase__Informations_F_Frame(Main_PageControl.Pages[ i ].Controls[ j ]).Finish__DIF();

  for i := 0 to Main_PageControl.PageCount - 1 do
    for j := 0 to Main_PageControl.Pages[ i ].ControlCount - 1 do
      if Main_PageControl.Pages[ i ].Controls[ j ].ClassType = Exceptions_Modify_F.TExceptions_Modify_F_Frame then
        Exceptions_Modify_F.TExceptions_Modify_F_Frame(Main_PageControl.Pages[ i ].Controls[ j ]).Finish__EMF();

  for i := 0 to Main_PageControl.PageCount - 1 do
    for j := 0 to Main_PageControl.Pages[ i ].ControlCount - 1 do
      if Main_PageControl.Pages[ i ].Controls[ j ].ClassType = External_Functions_Modify_F.TExternal_Functions_Modify_F_Frame then
        External_Functions_Modify_F.TExternal_Functions_Modify_F_Frame(Main_PageControl.Pages[ i ].Controls[ j ]).Finish__EFMF();

  for i := 0 to Main_PageControl.PageCount - 1 do
    for j := 0 to Main_PageControl.Pages[ i ].ControlCount - 1 do
      if Main_PageControl.Pages[ i ].Controls[ j ].ClassType = Generators_Modify_F.TGenerators_Modify_F_Frame then
        Generators_Modify_F.TGenerators_Modify_F_Frame(Main_PageControl.Pages[ i ].Controls[ j ]).Finish__GMF();

  for i := 0 to Main_PageControl.PageCount - 1 do
    for j := 0 to Main_PageControl.Pages[ i ].ControlCount - 1 do
      if Main_PageControl.Pages[ i ].Controls[ j ].ClassType = Roles_Modify_F.TRoles_Modify_F_Frame then
        Roles_Modify_F.TRoles_Modify_F_Frame(Main_PageControl.Pages[ i ].Controls[ j ]).Finish__RMF();

  for i := 0 to Main_PageControl.PageCount - 1 do
    for j := 0 to Main_PageControl.Pages[ i ].ControlCount - 1 do
      if Main_PageControl.Pages[ i ].Controls[ j ].ClassType = Users_Modify_F.TUsers_Modify_F_Frame then
        Users_Modify_F.TUsers_Modify_F_Frame(Main_PageControl.Pages[ i ].Controls[ j ]).Finish__UMF();


  Tables_List__Page__Close__All_ButtonClick( Sender );
  Sql_Editor__Page__Close__All();
  Stored_Procedures_List__Page__Close__All_ButtonClick( Sender );
  Views_List__Page__Close__All_ButtonClick( Sender );


  if   ( Sql_Editor__PageControl.PageCount > 0 )
    or ( Stored_Procedures_List__PageControl.PageCount > 0 )
    or ( Tables_List__PageControl.PageCount > 0 )
    or ( Views_List__PageControl.PageCount > 0 ) then
    begin

      Action := TCloseAction.caNone;
      Exit;
      
    end;
  

  FreeAndNil( sdbm );


  Connections__Close();


  Action := TCloseAction.caFree;

end;

procedure TDatabase__Modify_Form.Main_PageControlChange( Sender: TObject );
begin

  Database__Data_Load();

end;

procedure TDatabase__Modify_Form.Connect_ButtonClick( Sender: TObject );
begin

  if Page_Control_Children_Find( Main_PageControl, Common.pccff_Task_Running_Check ) then
    begin

      Application.MessageBox( PChar(Translation.translation__messages_r.task_is_still_running_wait_until_finish), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;
      
    end;


  if Application.MessageBox( PChar(Translation.translation__messages_r.close_all_connections_), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;


  Stored_Procedures_List_Count_Label.Caption := '<?>';
  Tables_List_Count_Label.Caption := '<?>';
  Views_List_Count_Label.Caption := '<?>';

  Stored_Procedures_List__ListBox.Items.Clear();
  Tables_List__ListBox.Items.Clear();
  Views_List__ListBox.Items.Clear();


  Connections__Close();

  Connection__Open( Component_Type_Get() );


  Page_Control_Children_Find( Main_PageControl, Common.pccff_Options_Set );

end;

procedure TDatabase__Modify_Form.Component_Type_ComboBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_RETURN then
    begin

      Key := 0;
      Connect_ButtonClick( Sender );

    end;

end;

procedure TDatabase__Modify_Form.Log_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Log_Memo.SelectAll();

end;

procedure TDatabase__Modify_Form.Sql_Editor__Page__New_ButtonClick( Sender: TObject );
var
  tab_sheet_l : TTabSheet;
  sql_editor_f_frame_l : Sql_Editor_F.TSql_Editor_F_Frame;
begin

  inc( sql_editor__tabs__count_total_g );

  tab_sheet_l := TTabSheet.Create( Application );
  tab_sheet_l.Caption := 'SQL ' + sql_editor__tabs__count_total_g.ToString;
  tab_sheet_l.PageControl := Sql_Editor__PageControl;
  Sql_Editor__PageControl.ActivePageIndex := Sql_Editor__PageControl.PageCount - 1;


  sql_editor_f_frame_l := Sql_Editor_F.TSql_Editor_F_Frame.Create( Application );
  sql_editor_f_frame_l.Parent := tab_sheet_l;
  sql_editor_f_frame_l.Align := alClient;
  sql_editor_f_frame_l.Prepare__SEF( databases_r__dm_g, Component_Type_Get(), ADOConnection1, FDConnection1, Sql_Editor__Database_Connection__Separated_CheckBox.Checked, Queries_Open_In_Background_CheckBox.Checked, Sql__Quotation_Sign__Use_CheckBox.Checked );

end;

procedure TDatabase__Modify_Form.Sql_Editor__Page__Close__One_ButtonClick( Sender: TObject );
begin

  Sql_Editor__Page__Close__One();

end;

procedure TDatabase__Modify_Form.Sql_Editor__Page__Close__All_ButtonClick( Sender: TObject );
begin

  Sql_Editor__Page__Close__All();

end;

procedure TDatabase__Modify_Form.Sql_Editor__Move__Left_ButtonClick( Sender: TObject );
begin

  if    ( Sql_Editor__PageControl.ActivePageIndex > 0  )
    and ( Sql_Editor__PageControl.Pages[ Sql_Editor__PageControl.ActivePageIndex ].PageIndex > 0 ) then
    Sql_Editor__PageControl.Pages[ Sql_Editor__PageControl.ActivePageIndex ].PageIndex := Sql_Editor__PageControl.Pages[ Sql_Editor__PageControl.ActivePageIndex ].PageIndex - 1;

end;

procedure TDatabase__Modify_Form.Sql_Editor__Move__Right_ButtonClick( Sender: TObject );
begin

  if    ( Sql_Editor__PageControl.ActivePageIndex >= 0  )
    and ( Sql_Editor__PageControl.Pages[ Sql_Editor__PageControl.ActivePageIndex ].PageIndex < Sql_Editor__PageControl.PageCount - 1 ) then
    Sql_Editor__PageControl.Pages[ Sql_Editor__PageControl.ActivePageIndex ].PageIndex := Sql_Editor__PageControl.Pages[ Sql_Editor__PageControl.ActivePageIndex ].PageIndex + 1;

end;

procedure TDatabase__Modify_Form.Sql_Editor__Hide_ButtonClick( Sender: TObject );
begin

  Sql_Editor__Buttons_Panel.Width := 1;

end;

procedure TDatabase__Modify_Form.Sql_Editor__PageControlMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin

  if    ( Sql_Editor__PageControl.ActivePageIndex >= 0  )
    and ( Sql_Editor__PageControl.Pages[ Sql_Editor__PageControl.ActivePageIndex ].PageIndex <= Sql_Editor__PageControl.PageCount - 1 ) then
    Sql_Editor__PageControl.Pages[ Sql_Editor__PageControl.ActivePageIndex ].BeginDrag( false );

end;

procedure TDatabase__Modify_Form.Sql_Editor__PageControlDragOver( Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean );
var
  zt_form_1,
  zt_form_2
    : TForm;
begin

  Accept := false;

  if not ( Source is TTabSheet ) then
    Exit;


  // Accept only within the same window.

  zt_form_1 := Common.Parent_Form_Find( Sender );
  zt_form_2 := Common.Parent_Form_Find( Source );

  if    ( zt_form_1 <> nil )
    and ( zt_form_2 <> nil )
    and ( zt_form_1 = zt_form_2 ) then
    Accept := true;

end;

procedure TDatabase__Modify_Form.Sql_Editor__PageControlDragDrop( Sender, Source: TObject; X, Y: Integer );
begin

  if Source is TTabSheet then
    TTabSheet(Source).PageIndex := Sql_Editor__PageControl.IndexOfTabAt( X, Y );

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__ListBoxClick( Sender: TObject );
begin

  id_search__stored_procedures_list_g := Stored_Procedures_List__ListBox.ItemIndex;

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__ListBoxDblClick( Sender: TObject );
begin

  if GetKeyState( VK_SHIFT ) < 0 then
    Stored_Procedures_List__Stored_Procedure__Open__Edit__DM()
  else
    Stored_Procedures_List__Stored_Procedure__Open__DM();

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__ListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  id_search__stored_procedures_list_g := Stored_Procedures_List__ListBox.ItemIndex;


  if    ( Key = VK_DELETE )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Key := 0;
      Stored_Procedures_List__Stored_Procedure__Delete__MenuItemClick( Sender );

    end
  else
  if    ( Key = VK_INSERT )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Key := 0;
      Stored_Procedures_List__Stored_Procedure__Add__Modal__MenuItemClick( Stored_Procedures_List__Stored_Procedure__Add__MenuItem );

    end
  else
  if Key = VK_INSERT then
    begin

      Key := 0;
      Stored_Procedures_List__Stored_Procedure__Add__Modal__MenuItemClick( Sender );

    end
  else
  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Key := 0;
      Stored_Procedures_List__Stored_Procedure__Open__Edit__DM();

    end
  else
  if Key = VK_RETURN then
    begin

      Key := 0;
      Stored_Procedures_List__Stored_Procedure__Open__DM();

    end
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( Stored_Procedures_List__ListBox.Items.Count > 0 )
    and ( Stored_Procedures_List__ListBox.ItemIndex >= 0 )
    and ( Stored_Procedures_List__ListBox.ItemIndex < Stored_Procedures_List__ListBox.Items.Count ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Stored_Procedures_List__ListBox.Items[ Stored_Procedures_List__ListBox.ItemIndex ];
    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end
  else
  // R.
  if    ( Key = 82 )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Stored_Procedures_List__Refresh_MenuItemClick( Sender );

    end;

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Page__Close__One_ButtonClick( Sender: TObject );
var
  ztb,
  last_tab_is_closing_l
    : boolean;

  i : integer;
begin

  if    ( Stored_Procedures_List__PageControl.PageCount > 0 )
    and ( Stored_Procedures_List__PageControl.ActivePageIndex >= 0 )
    and ( Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.ActivePageIndex ].PageIndex <= Stored_Procedures_List__PageControl.PageCount - 1 ) then
    begin

      ztb := true;

      for i := 0 to Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.ActivePageIndex ].ControlCount - 1 do
        if Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.ActivePageIndex ].Controls[ i ].ClassType = Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame then
          if    ( not Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame(Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.ActivePageIndex ].Controls[ i ]).Finish__SPMF() )
            and ( ztb ) then
            ztb := false;


      if ztb then
        begin

          last_tab_is_closing_l :=
                ( Stored_Procedures_List__PageControl.PageCount > 1 )
            and ( Stored_Procedures_List__PageControl.ActivePageIndex = Stored_Procedures_List__PageControl.PageCount - 1 );


          FreeAndNil( Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.ActivePageIndex ] );


          if last_tab_is_closing_l then
            Stored_Procedures_List__PageControl.ActivePageIndex := Stored_Procedures_List__PageControl.PageCount - 1;

        end;

    end;

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Page__Close__All_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  for i := Stored_Procedures_List__PageControl.PageCount - 1 downto 0 do
    begin

      Stored_Procedures_List__PageControl.ActivePageIndex := i;
      Stored_Procedures_List__Page__Close__One_ButtonClick( Sender );

    end;

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Move__Left_ButtonClick( Sender: TObject );
begin

  if    ( Stored_Procedures_List__PageControl.ActivePageIndex > 0  )
    and ( Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.ActivePageIndex ].PageIndex > 0 ) then
    Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.ActivePageIndex ].PageIndex := Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.ActivePageIndex ].PageIndex - 1;

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Move__Right_ButtonClick( Sender: TObject );
begin

  if    ( Stored_Procedures_List__PageControl.ActivePageIndex >= 0  )
    and ( Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.ActivePageIndex ].PageIndex < Stored_Procedures_List__PageControl.PageCount - 1 ) then
    Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.ActivePageIndex ].PageIndex := Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.ActivePageIndex ].PageIndex + 1;

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Refresh_MenuItemClick( Sender: TObject );
begin

  if    (  Trim( stored_procedure_name_g ) = ''  )
    and ( Stored_Procedures_List__ListBox.Items.Count > 0 )
    and ( Stored_Procedures_List__ListBox.ItemIndex >= 0 )
    and ( Stored_Procedures_List__ListBox.ItemIndex < Stored_Procedures_List__ListBox.Items.Count ) then
    stored_procedure_name_g := Stored_Procedures_List__ListBox.Items[ Stored_Procedures_List__ListBox.ItemIndex ];


  Stored_Procedures_List__ListBox.Items.Clear();

  Database__Data_Load();

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Hide_ButtonClick( Sender: TObject );
begin

  Stored_Procedures_List__Left_Panel.Width := 1;

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Search_Change( Sender: TObject );
begin

  id_search__stored_procedures_list_g := -1;

  Stored_Procedures_List__Search__Next_ButtonClick( Sender );

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Search__Next_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  Stored_Procedures_List__Search_Edit.Color := Common.color__red__light_c;


  id_search__stored_procedures_list_g := id_search__stored_procedures_list_g + 1;

  if id_search__stored_procedures_list_g < 0 then
    id_search__stored_procedures_list_g := 0;


  for i := id_search__stored_procedures_list_g to Stored_Procedures_List__ListBox.Items.Count - 1 do
    if   (
               ( not Stored_Procedures_List__Search__Partial_Key_CheckBox.Checked )
           and (  Common.Case_Insensitive_To_String( Stored_Procedures_List__Search_Edit.Text, Stored_Procedures_List__Search__Case_Insensitive_CheckBox.Checked ) = Common.Case_Insensitive_To_String( Stored_Procedures_List__ListBox.Items[ i ], Stored_Procedures_List__Search__Case_Insensitive_CheckBox.Checked )  )
         )
      or (
               ( Stored_Procedures_List__Search__Partial_Key_CheckBox.Checked )
           and (   Pos(  Common.Case_Insensitive_To_String( Stored_Procedures_List__Search_Edit.Text, Stored_Procedures_List__Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String( Stored_Procedures_List__ListBox.Items[ i ], Stored_Procedures_List__Search__Case_Insensitive_CheckBox.Checked )  ) > 0   )
         ) then
      begin

        Stored_Procedures_List__ListBox.ItemIndex := i;

        id_search__stored_procedures_list_g := i;

        Stored_Procedures_List__Search_Edit.Color := clWindow;

        Break;

      end;

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Search__Prior_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  Stored_Procedures_List__Search_Edit.Color := Common.color__red__light_c;


  id_search__stored_procedures_list_g := id_search__stored_procedures_list_g - 1;

  if id_search__stored_procedures_list_g > Stored_Procedures_List__ListBox.Items.Count - 1 then
    id_search__stored_procedures_list_g := Stored_Procedures_List__ListBox.Items.Count - 1;


  for i := id_search__stored_procedures_list_g downto 0 do
    if   (
               ( not Stored_Procedures_List__Search__Partial_Key_CheckBox.Checked )
           and (  Common.Case_Insensitive_To_String( Stored_Procedures_List__Search_Edit.Text, Stored_Procedures_List__Search__Case_Insensitive_CheckBox.Checked ) = Common.Case_Insensitive_To_String( Stored_Procedures_List__ListBox.Items[ i ], Stored_Procedures_List__Search__Case_Insensitive_CheckBox.Checked )  )
         )
      or (
               ( Stored_Procedures_List__Search__Partial_Key_CheckBox.Checked )
           and (   Pos(  Common.Case_Insensitive_To_String( Stored_Procedures_List__Search_Edit.Text, Stored_Procedures_List__Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String( Stored_Procedures_List__ListBox.Items[ i ], Stored_Procedures_List__Search__Case_Insensitive_CheckBox.Checked )  ) > 0   )
         ) then
      begin

        Stored_Procedures_List__ListBox.ItemIndex := i;

        id_search__stored_procedures_list_g := i;

        Stored_Procedures_List__Search_Edit.Color := clWindow;

        Break;

      end;

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_RETURN )
    and ( Shift = [ ssShift ] ) then
    Stored_Procedures_List__Stored_Procedure__Open__Edit__DM()
  else
  if Key = VK_RETURN then
    Stored_Procedures_List__Stored_Procedure__Open__DM();

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Search_ButtonKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl, ssShift ] ) then
    Stored_Procedures_List__Stored_Procedure__Open__Edit__DM()
  else
  if    ( Key = VK_RETURN )
    and ( Shift = [ ssShift ] ) then
    Stored_Procedures_List__Stored_Procedure__Open__DM();

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Stored_Procedure__Add__Modal__MenuItemClick( Sender: TObject );
var
  modified_l : boolean;

  stored_procedure__modify_form_l : Stored_Procedure__Modify.TStored_Procedure__Modify_Form;
begin

  if sdbm = nil then
    Exit;


  stored_procedure__modify_form_l := Stored_Procedure__Modify.TStored_Procedure__Modify_Form.Create( Application, sdbm );
  stored_procedure__modify_form_l.database_type__spm := databases_r__dm_g.database_type;
  stored_procedure__modify_form_l.splitter_show__spm := Splitter_Show_CheckBox.Checked;
  stored_procedure__modify_form_l.sql__quotation_sign__spm := databases_r__dm_g.sql__quotation_sign;
  stored_procedure__modify_form_l.sql__quotation_sign__use__spm := Sql__Quotation_Sign__Use_CheckBox.Checked;

  if    ( Sender <> nil )
    and ( Sender = Stored_Procedures_List__Stored_Procedure__Add__MenuItem ) then
    begin

      stored_procedure__modify_form_l.show_modal__spm := false;
      stored_procedure__modify_form_l.Show();

      Exit;

    end;

  stored_procedure__modify_form_l.ShowModal();
  modified_l := stored_procedure__modify_form_l.modified__spm;
  stored_procedure_name_g := stored_procedure__modify_form_l.stored_procedure__name__spm;
  FreeAndNil( stored_procedure__modify_form_l );


  if modified_l then
    begin

      Stored_Procedures_List__Refresh_MenuItemClick( Sender );

    end;

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__Stored_Procedure__Delete__MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  i,
  item_index_copy_l
    : integer;

  zts,
  error_message_l,
  stored_procedures_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( Stored_Procedures_List__ListBox.Items.Count <= 0 )
    or ( Stored_Procedures_List__ListBox.ItemIndex < 0 )
    or ( Stored_Procedures_List__ListBox.ItemIndex >= Stored_Procedures_List__ListBox.Items.Count ) then
    Exit;


  stored_procedures_name_l := Self.Quotation_Sign__DM() + Stored_Procedures_List__ListBox.Items[ Stored_Procedures_List__ListBox.ItemIndex ] + Self.Quotation_Sign__DM();
  item_index_copy_l := Stored_Procedures_List__ListBox.ItemIndex;

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + stored_procedure__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + stored_procedure__drop__file_name_c + ').' );

      zts :=
        'drop procedure ' +
        stored_procedures_name_l +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__stored_procedure__big_letters_c + Common.sql__word_replace_separator_c, stored_procedures_name_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_stored_procedure + ' ''' + stored_procedures_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;



  for i := Stored_Procedures_List__PageControl.PageCount - 1 downto 0 do
    if    ( Stored_Procedures_List__PageControl.Pages[ i ].ControlCount > 0 )
      and ( Stored_Procedures_List__PageControl.Pages[ i ].Controls[ 0 ].ClassType = Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame )
      and ( Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame(Stored_Procedures_List__PageControl.Pages[ i ].Controls[ 0 ]).Stored_Procedure__Name__Get__SPMF() = stored_procedures_name_l ) then
      begin

        Stored_Procedures_List__PageControl.ActivePageIndex := i;
        Stored_Procedures_List__Page__Close__One_ButtonClick( Sender );

      end;


  ztb := false;

  for i := Stored_Procedures_List__PageControl.PageCount - 1 downto 0 do
    if    ( Stored_Procedures_List__PageControl.Pages[ i ].ControlCount > 0 )
      and ( Stored_Procedures_List__PageControl.Pages[ i ].Controls[ 0 ].ClassType = Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame )
      and ( Stored_Procedure_Modify_F.TStored_Procedure_Modify_F_Frame(Stored_Procedures_List__PageControl.Pages[ i ].Controls[ 0 ]).Stored_Procedure__Name__Get__SPMF() = stored_procedures_name_l ) then
        begin

          ztb := true;
          Break;

        end;


  if ztb then
    begin

      Application.MessageBox( PChar(Translation.translation__messages_r.task_is_still_running_wait_until_finish), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;



  Screen.Cursor := crSQLWait;


  ztb := sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_stored_procedure_ );


  Screen.Cursor := crDefault;


  if ztb then
    begin

      Log_Memo.Lines.Add( sdbm.Operation_Duration_Get() );


      Stored_Procedures_List__Refresh_MenuItemClick( Sender );


      if    ( Stored_Procedures_List__ListBox.Items.Count > 0 )
        and ( item_index_copy_l - 1 >= 0 )
        and ( item_index_copy_l - 1 < Stored_Procedures_List__ListBox.Items.Count ) then
        Stored_Procedures_List__ListBox.ItemIndex := item_index_copy_l - 1
      else
      if    ( Stored_Procedures_List__ListBox.Items.Count > 0 )
        and ( item_index_copy_l >= 0 )
        and ( item_index_copy_l < Stored_Procedures_List__ListBox.Items.Count ) then
        Stored_Procedures_List__ListBox.ItemIndex := item_index_copy_l;


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__PageControlMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin

  if    ( Stored_Procedures_List__PageControl.ActivePageIndex >= 0  )
    and ( Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.ActivePageIndex ].PageIndex <= Stored_Procedures_List__PageControl.PageCount - 1 ) then
    Stored_Procedures_List__PageControl.Pages[ Stored_Procedures_List__PageControl.ActivePageIndex ].BeginDrag( false );

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__PageControlDragOver( Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean );
var
  zt_form_1,
  zt_form_2
    : TForm;
begin

  Accept := false;

  if not ( Source is TTabSheet ) then
    Exit;


  // Accept only within the same window.

  zt_form_1 := Common.Parent_Form_Find( Sender );
  zt_form_2 := Common.Parent_Form_Find( Source );

  if    ( zt_form_1 <> nil )
    and ( zt_form_2 <> nil )
    and ( zt_form_1 = zt_form_2 ) then
    Accept := true;

end;

procedure TDatabase__Modify_Form.Stored_Procedures_List__PageControlDragDrop( Sender, Source: TObject; X, Y: Integer );
begin

  if Source is TTabSheet then
    TTabSheet(Source).PageIndex := Stored_Procedures_List__PageControl.IndexOfTabAt( X, Y );

end;

procedure TDatabase__Modify_Form.Tables_List__ListBoxClick( Sender: TObject );
begin

  id_search__tables_list_g := Tables_List__ListBox.ItemIndex;

end;

procedure TDatabase__Modify_Form.Tables_List__ListBoxDblClick( Sender: TObject );
begin

  if    (  GetKeyState( VK_CONTROL ) < 0  )
    and (  GetKeyState( VK_MENU ) >= 0  ) then
    Tables_List__Table__Data_Open__DM()
  else
    Tables_List__Table__Open__DM();

end;

procedure TDatabase__Modify_Form.Tables_List__ListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  id_search__tables_list_g := Tables_List__ListBox.ItemIndex;


  if    ( Key = VK_DELETE )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Key := 0;
      Tables_List__Table__Delete_MenuItemClick( Sender );

    end
  else
  if Key = VK_INSERT then
    begin

      Key := 0;
      Tables_List__Table__Add_MenuItemClick( Sender );

    end
  else
  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Key := 0;
      Tables_List__Table__Data_Open__DM();

    end
  else
  if Key = VK_RETURN then
    begin

      Key := 0;
      Tables_List__Table__Open__DM();

    end
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( Tables_List__ListBox.Items.Count > 0 )
    and ( Tables_List__ListBox.ItemIndex >= 0 )
    and ( Tables_List__ListBox.ItemIndex < Tables_List__ListBox.Items.Count ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Tables_List__ListBox.Items[ Tables_List__ListBox.ItemIndex ];
    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end
  else
  // R.
  if    ( Key = 82 )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Tables_List__Refresh_MenuItemClick( Sender );

    end;

end;

procedure TDatabase__Modify_Form.Tables_List__Page__Close__One_ButtonClick( Sender: TObject );
var
  ztb,
  last_tab_is_closing_l
    : boolean;

  i : integer;
begin

  if    ( Tables_List__PageControl.PageCount > 0 )
    and ( Tables_List__PageControl.ActivePageIndex >= 0 )
    and ( Tables_List__PageControl.Pages[ Tables_List__PageControl.ActivePageIndex ].PageIndex <= Tables_List__PageControl.PageCount - 1 ) then
    begin

      ztb := true;

      for i := 0 to Tables_List__PageControl.Pages[ Tables_List__PageControl.ActivePageIndex ].ControlCount - 1 do
        if Tables_List__PageControl.Pages[ Tables_List__PageControl.ActivePageIndex ].Controls[ i ].ClassType = Table_Modify_F.TTable_Modify_F_Frame then
          if    ( not Table_Modify_F.TTable_Modify_F_Frame(Tables_List__PageControl.Pages[ Tables_List__PageControl.ActivePageIndex ].Controls[ i ]).Finish__TMoF() )
            and ( ztb ) then
            ztb := false;


      if ztb then
        begin

          last_tab_is_closing_l :=
                ( Tables_List__PageControl.PageCount > 1 )
            and ( Tables_List__PageControl.ActivePageIndex = Tables_List__PageControl.PageCount - 1 );


          FreeAndNil( Tables_List__PageControl.Pages[ Tables_List__PageControl.ActivePageIndex ] );


          if last_tab_is_closing_l then
            Tables_List__PageControl.ActivePageIndex := Tables_List__PageControl.PageCount - 1;

        end;

    end;

end;

procedure TDatabase__Modify_Form.Tables_List__Page__Close__All_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  for i := Tables_List__PageControl.PageCount - 1 downto 0 do
    begin

      Tables_List__PageControl.ActivePageIndex := i;
      Tables_List__Page__Close__One_ButtonClick( Sender );

    end;

end;

procedure TDatabase__Modify_Form.Tables_List__Move__Left_ButtonClick( Sender: TObject );
begin

  if    ( Tables_List__PageControl.ActivePageIndex > 0  )
    and ( Tables_List__PageControl.Pages[ Tables_List__PageControl.ActivePageIndex ].PageIndex > 0 ) then
    Tables_List__PageControl.Pages[ Tables_List__PageControl.ActivePageIndex ].PageIndex := Tables_List__PageControl.Pages[ Tables_List__PageControl.ActivePageIndex ].PageIndex - 1;

end;

procedure TDatabase__Modify_Form.Tables_List__Move__Right_ButtonClick( Sender: TObject );
begin

  if    ( Tables_List__PageControl.ActivePageIndex >= 0  )
    and ( Tables_List__PageControl.Pages[ Tables_List__PageControl.ActivePageIndex ].PageIndex < Tables_List__PageControl.PageCount - 1 ) then
    Tables_List__PageControl.Pages[ Tables_List__PageControl.ActivePageIndex ].PageIndex := Tables_List__PageControl.Pages[ Tables_List__PageControl.ActivePageIndex ].PageIndex + 1;

end;

procedure TDatabase__Modify_Form.Tables_List__Refresh_MenuItemClick( Sender: TObject );
begin

  if    (  Trim( table_name_g ) = ''  )
    and ( Tables_List__ListBox.Items.Count > 0 )
    and ( Tables_List__ListBox.ItemIndex >= 0 )
    and ( Tables_List__ListBox.ItemIndex < Tables_List__ListBox.Items.Count ) then
    table_name_g := Tables_List__ListBox.Items[ Tables_List__ListBox.ItemIndex ];


  Tables_List__ListBox.Items.Clear();

  Database__Data_Load();

end;

procedure TDatabase__Modify_Form.Tables_List__Hide_ButtonClick( Sender: TObject );
begin

  Tables_List__Left_Panel.Width := 1;

end;

procedure TDatabase__Modify_Form.Tables_List__Search_Change( Sender: TObject );
begin

  id_search__tables_list_g := -1;

  Tables_List__Search__Next_ButtonClick( Sender )

end;

procedure TDatabase__Modify_Form.Tables_List__Search__Next_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  Tables_List__Search_Edit.Color := Common.color__red__light_c;


  id_search__tables_list_g := id_search__tables_list_g + 1;

  if id_search__tables_list_g < 0 then
    id_search__tables_list_g := 0;


  for i := id_search__tables_list_g to Tables_List__ListBox.Items.Count - 1 do
    if   (
               ( not Tables_List__Search__Partial_Key_CheckBox.Checked )
           and (  Common.Case_Insensitive_To_String( Tables_List__Search_Edit.Text, Tables_List__Search__Case_Insensitive_CheckBox.Checked ) = Common.Case_Insensitive_To_String( Tables_List__ListBox.Items[ i ], Tables_List__Search__Case_Insensitive_CheckBox.Checked )  )
         )
      or (
               ( Tables_List__Search__Partial_Key_CheckBox.Checked )
           and (   Pos(  Common.Case_Insensitive_To_String( Tables_List__Search_Edit.Text, Tables_List__Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String( Tables_List__ListBox.Items[ i ], Tables_List__Search__Case_Insensitive_CheckBox.Checked )  ) > 0   )
         ) then
      begin

        Tables_List__ListBox.ItemIndex := i;

        id_search__tables_list_g := i;

        Tables_List__Search_Edit.Color := clWindow;

        Break;

      end;

end;

procedure TDatabase__Modify_Form.Tables_List__Search__Prior_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  Tables_List__Search_Edit.Color := Common.color__red__light_c;


  id_search__tables_list_g := id_search__tables_list_g - 1;

  if id_search__tables_list_g > Tables_List__ListBox.Items.Count - 1 then
    id_search__tables_list_g := Tables_List__ListBox.Items.Count - 1;


  for i := id_search__tables_list_g downto 0 do
    if   (
               ( not Tables_List__Search__Partial_Key_CheckBox.Checked )
           and (  Common.Case_Insensitive_To_String( Tables_List__Search_Edit.Text, Tables_List__Search__Case_Insensitive_CheckBox.Checked ) = Common.Case_Insensitive_To_String( Tables_List__ListBox.Items[ i ], Tables_List__Search__Case_Insensitive_CheckBox.Checked )  )
         )
      or (
               ( Tables_List__Search__Partial_Key_CheckBox.Checked )
           and (   Pos(  Common.Case_Insensitive_To_String( Tables_List__Search_Edit.Text, Tables_List__Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String( Tables_List__ListBox.Items[ i ], Tables_List__Search__Case_Insensitive_CheckBox.Checked )  ) > 0   )
         ) then
      begin

        Tables_List__ListBox.ItemIndex := i;

        id_search__tables_list_g := i;

        Tables_List__Search_Edit.Color := clWindow;

        Break;

      end;

end;

procedure TDatabase__Modify_Form.Tables_List__Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl ] ) then
    Tables_List__Table__Data_Open__DM()
  else
  if Key = VK_RETURN then
    Tables_List__Table__Open__DM();

end;

procedure TDatabase__Modify_Form.Tables_List__Search_ButtonKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl ] ) then
    Tables_List__Table__Data_Open__DM()
  else
  if    ( Key = VK_RETURN )
    and ( Shift = [ ssShift ] ) then
    Tables_List__Table__Open__DM();

end;

procedure TDatabase__Modify_Form.Tables_List__Table__Add_MenuItemClick( Sender: TObject );
var
  modified_l : boolean;
begin

  if sdbm = nil then
    Exit;


  Table_Add.Table_Add_Form := Table_Add.TTable_Add_Form.Create( Application, sdbm );
  Table_Add.Table_Add_Form.database_type__ta := databases_r__dm_g.database_type;
  Table_Add.Table_Add_Form.sql__quotation_sign__ta := databases_r__dm_g.sql__quotation_sign;
  Table_Add.Table_Add_Form.sql__quotation_sign__use__ta := Sql__Quotation_Sign__Use_CheckBox.Checked;
  Table_Add.Table_Add_Form.ShowModal();
  modified_l := Table_Add.Table_Add_Form.modified__ta;
  table_name_g := Table_Add.Table_Add_Form.table_name__ta;
  FreeAndNil( Table_Add.Table_Add_Form );


  if modified_l then
    begin

      Tables_List__Refresh_MenuItemClick( Sender );

    end;

end;

procedure TDatabase__Modify_Form.Tables_List__Table__Delete_MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  i,
  item_index_copy_l
    : integer;

  zts,
  error_message_l,
  table_name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( Tables_List__ListBox.Items.Count <= 0 )
    or ( Tables_List__ListBox.ItemIndex < 0 )
    or ( Tables_List__ListBox.ItemIndex >= Tables_List__ListBox.Items.Count ) then
    Exit;


  table_name_l := Self.Quotation_Sign__DM() + Tables_List__ListBox.Items[ Tables_List__ListBox.ItemIndex ] + Self.Quotation_Sign__DM();
  item_index_copy_l := Tables_List__ListBox.ItemIndex;

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + table__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + table__drop__file_name_c + ').' );

      zts :=
        'drop table ' +
        table_name_l +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__table__big_letters_c + Common.sql__word_replace_separator_c, table_name_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_table + ' ''' + table_name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;



  for i := Tables_List__PageControl.PageCount - 1 downto 0 do
    if    ( Tables_List__PageControl.Pages[ i ].ControlCount > 0 )
      and ( Tables_List__PageControl.Pages[ i ].Controls[ 0 ].ClassType = Table_Modify_F.TTable_Modify_F_Frame )
      and ( Table_Modify_F.TTable_Modify_F_Frame(Tables_List__PageControl.Pages[ i ].Controls[ 0 ]).Table__Name__Get__TMoF() = table_name_l ) then
      begin

        Tables_List__PageControl.ActivePageIndex := i;
        Tables_List__Page__Close__One_ButtonClick( Sender );

      end;


  ztb := false;

  for i := Tables_List__PageControl.PageCount - 1 downto 0 do
    if    ( Tables_List__PageControl.Pages[ i ].ControlCount > 0 )
      and ( Tables_List__PageControl.Pages[ i ].Controls[ 0 ].ClassType = Table_Modify_F.TTable_Modify_F_Frame )
      and ( Table_Modify_F.TTable_Modify_F_Frame(Tables_List__PageControl.Pages[ i ].Controls[ 0 ]).Table__Name__Get__TMoF() = table_name_l ) then
        begin

          ztb := true;
          Break;

        end;


  if ztb then
    begin

      Application.MessageBox( PChar(Translation.translation__messages_r.task_is_still_running_wait_until_finish), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;



  ztb := sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_table_ );


  if ztb then
    begin

      Log_Memo.Lines.Add( sdbm.Operation_Duration_Get() );


      Tables_List__Refresh_MenuItemClick( Sender );


      if    ( Tables_List__ListBox.Items.Count > 0 )
        and ( item_index_copy_l - 1 >= 0 )
        and ( item_index_copy_l - 1 < Tables_List__ListBox.Items.Count ) then
        Tables_List__ListBox.ItemIndex := item_index_copy_l - 1
      else
      if    ( Tables_List__ListBox.Items.Count > 0 )
        and ( item_index_copy_l >= 0 )
        and ( item_index_copy_l < Tables_List__ListBox.Items.Count ) then
        Tables_List__ListBox.ItemIndex := item_index_copy_l;


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TDatabase__Modify_Form.Tables_List__PageControlMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin

  if    ( Tables_List__PageControl.ActivePageIndex >= 0  )
    and ( Tables_List__PageControl.Pages[ Tables_List__PageControl.ActivePageIndex ].PageIndex <= Tables_List__PageControl.PageCount - 1 ) then
    Tables_List__PageControl.Pages[ Tables_List__PageControl.ActivePageIndex ].BeginDrag( false );

end;

procedure TDatabase__Modify_Form.Tables_List__PageControlDragOver( Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean );
var
  zt_form_1,
  zt_form_2
    : TForm;
begin

  Accept := false;

  if not ( Source is TTabSheet ) then
    Exit;


  // Accept only within the same window.

  zt_form_1 := Common.Parent_Form_Find( Sender );
  zt_form_2 := Common.Parent_Form_Find( Source );

  if    ( zt_form_1 <> nil )
    and ( zt_form_2 <> nil )
    and ( zt_form_1 = zt_form_2 ) then
    Accept := true;

end;

procedure TDatabase__Modify_Form.Tables_List__PageControlDragDrop( Sender, Source: TObject; X, Y: Integer );
begin

  if Source is TTabSheet then
    TTabSheet(Source).PageIndex := Tables_List__PageControl.IndexOfTabAt( X, Y );

end;

procedure TDatabase__Modify_Form.Views_List__ListBoxClick( Sender: TObject );
begin

  id_search__views__list_g := Views_List__ListBox.ItemIndex;

end;

procedure TDatabase__Modify_Form.Views_List__ListBoxDblClick( Sender: TObject );
begin

  if GetKeyState( VK_SHIFT ) < 0 then
    Views_List__View__Open__Edit__DM()
  else
  if    (  GetKeyState( VK_CONTROL ) < 0  )
    and (  GetKeyState( VK_MENU ) >= 0  ) then
    Views_List__View__Data_Open__DM()
  else
    Views_List__View__Open__DM();

end;

procedure TDatabase__Modify_Form.Views_List__ListBoxKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  id_search__views__list_g := Views_List__ListBox.ItemIndex;


  if    ( Key = VK_DELETE )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Key := 0;
      Views_List__View__Delete__MenuItemClick( Sender );

    end
  else
  if    ( Key = VK_INSERT )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Key := 0;
      Views_List__View__Add__Modal__MenuItemClick( Views_List__View__Add__MenuItem );

    end
  else
  if Key = VK_INSERT then
    begin

      Key := 0;
      Views_List__View__Add__Modal__MenuItemClick( Sender );

    end
  else
  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Key := 0;
      Views_List__View__Open__Edit__DM();

    end
  else
  if Key = VK_RETURN then
    begin

      Key := 0;
      Views_List__View__Open__DM();

    end
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( Views_List__ListBox.Items.Count > 0 )
    and ( Views_List__ListBox.ItemIndex >= 0 )
    and ( Views_List__ListBox.ItemIndex < Views_List__ListBox.Items.Count ) then
    try
      Vcl.Clipbrd.Clipboard.AsText := Views_List__ListBox.Items[ Views_List__ListBox.ItemIndex ];
    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end
  else
  // R.
  if    ( Key = 82 )
    and ( Shift = [ ssCtrl ] ) then
    begin

      Views_List__Refresh_MenuItemClick( Sender );

    end;

end;

procedure TDatabase__Modify_Form.Views_List__Page__Close__One_ButtonClick( Sender: TObject );
var
  ztb,
  last_tab_is_closing_l
    : boolean;

  i : integer;
begin

  if    ( Views_List__PageControl.PageCount > 0 )
    and ( Views_List__PageControl.ActivePageIndex >= 0 )
    and ( Views_List__PageControl.Pages[ Views_List__PageControl.ActivePageIndex ].PageIndex <= Views_List__PageControl.PageCount - 1 ) then
    begin

      ztb := true;

      for i := 0 to Views_List__PageControl.Pages[ Views_List__PageControl.ActivePageIndex ].ControlCount - 1 do
        if Views_List__PageControl.Pages[ Views_List__PageControl.ActivePageIndex ].Controls[ i ].ClassType = View_Modify_F.TView_Modify_F_Frame then
          if    ( not View_Modify_F.TView_Modify_F_Frame(Views_List__PageControl.Pages[ Views_List__PageControl.ActivePageIndex ].Controls[ i ]).Finish__VMF() )
            and ( ztb ) then
            ztb := false;


      if ztb then
        begin

          last_tab_is_closing_l :=
                ( Views_List__PageControl.PageCount > 1 )
            and ( Views_List__PageControl.ActivePageIndex = Views_List__PageControl.PageCount - 1 );


          FreeAndNil( Views_List__PageControl.Pages[ Views_List__PageControl.ActivePageIndex ] );


          if last_tab_is_closing_l then
            Views_List__PageControl.ActivePageIndex := Views_List__PageControl.PageCount - 1;

        end;

    end;

end;

procedure TDatabase__Modify_Form.Views_List__Page__Close__All_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  for i := Views_List__PageControl.PageCount - 1 downto 0 do
    begin

      Views_List__PageControl.ActivePageIndex := i;
      Views_List__Page__Close__One_ButtonClick( Sender );

    end;

end;

procedure TDatabase__Modify_Form.Views_List__Move__Left_ButtonClick( Sender: TObject );
begin

  if    ( Views_List__PageControl.ActivePageIndex > 0  )
    and ( Views_List__PageControl.Pages[ Views_List__PageControl.ActivePageIndex ].PageIndex > 0 ) then
    Views_List__PageControl.Pages[ Views_List__PageControl.ActivePageIndex ].PageIndex := Views_List__PageControl.Pages[ Views_List__PageControl.ActivePageIndex ].PageIndex - 1;

end;

procedure TDatabase__Modify_Form.Views_List__Move__Right_ButtonClick( Sender: TObject );
begin

  if    ( Views_List__PageControl.ActivePageIndex >= 0  )
    and ( Views_List__PageControl.Pages[ Views_List__PageControl.ActivePageIndex ].PageIndex < Views_List__PageControl.PageCount - 1 ) then
    Views_List__PageControl.Pages[ Views_List__PageControl.ActivePageIndex ].PageIndex := Views_List__PageControl.Pages[ Views_List__PageControl.ActivePageIndex ].PageIndex + 1;

end;

procedure TDatabase__Modify_Form.Views_List__Refresh_MenuItemClick( Sender: TObject );
begin

  if    (  Trim( view_name_g ) = ''  )
    and ( Views_List__ListBox.Items.Count > 0 )
    and ( Views_List__ListBox.ItemIndex >= 0 )
    and ( Views_List__ListBox.ItemIndex < Views_List__ListBox.Items.Count ) then
    view_name_g := Views_List__ListBox.Items[ Views_List__ListBox.ItemIndex ];


  Views_List__ListBox.Items.Clear();

  Database__Data_Load();

end;

procedure TDatabase__Modify_Form.Views_List__Hide_ButtonClick( Sender: TObject );
begin

  Views_List__Left_Panel.Width := 1;

end;

procedure TDatabase__Modify_Form.Views_List__Search_Change( Sender: TObject );
begin

  id_search__views__list_g := -1;

  Views_List__Search__Next_ButtonClick( Sender );

end;

procedure TDatabase__Modify_Form.Views_List__Search__Next_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  Views_List__Search_Edit.Color := Common.color__red__light_c;


  id_search__views__list_g := id_search__views__list_g + 1;

  if id_search__views__list_g < 0 then
    id_search__views__list_g := 0;


  for i := id_search__views__list_g to Views_List__ListBox.Items.Count - 1 do
    if   (
               ( not Views_List__Search__Partial_Key_CheckBox.Checked )
           and (  Common.Case_Insensitive_To_String( Views_List__Search_Edit.Text, Views_List__Search__Case_Insensitive_CheckBox.Checked ) = Common.Case_Insensitive_To_String( Views_List__ListBox.Items[ i ], Views_List__Search__Case_Insensitive_CheckBox.Checked )  )
         )
      or (
               ( Views_List__Search__Partial_Key_CheckBox.Checked )
           and (   Pos(  Common.Case_Insensitive_To_String( Views_List__Search_Edit.Text, Views_List__Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String( Views_List__ListBox.Items[ i ], Views_List__Search__Case_Insensitive_CheckBox.Checked )  ) > 0   )
         ) then
      begin

        Views_List__ListBox.ItemIndex := i;

        id_search__views__list_g := i;

        Views_List__Search_Edit.Color := clWindow;

        Break;

      end;

end;

procedure TDatabase__Modify_Form.Views_List__Search__Prior_ButtonClick( Sender: TObject );
var
  i : integer;
begin

  Views_List__Search_Edit.Color := Common.color__red__light_c;


  id_search__views__list_g := id_search__views__list_g - 1;

  if id_search__views__list_g > Views_List__ListBox.Items.Count - 1 then
    id_search__views__list_g := Views_List__ListBox.Items.Count - 1;


  for i := id_search__views__list_g downto 0 do
    if   (
               ( not Views_List__Search__Partial_Key_CheckBox.Checked )
           and (  Common.Case_Insensitive_To_String( Views_List__Search_Edit.Text, Views_List__Search__Case_Insensitive_CheckBox.Checked ) = Common.Case_Insensitive_To_String( Views_List__ListBox.Items[ i ], Views_List__Search__Case_Insensitive_CheckBox.Checked )  )
         )
      or (
               ( Views_List__Search__Partial_Key_CheckBox.Checked )
           and (   Pos(  Common.Case_Insensitive_To_String( Views_List__Search_Edit.Text, Views_List__Search__Case_Insensitive_CheckBox.Checked ), Common.Case_Insensitive_To_String( Views_List__ListBox.Items[ i ], Views_List__Search__Case_Insensitive_CheckBox.Checked )  ) > 0   )
         ) then
      begin

        Views_List__ListBox.ItemIndex := i;

        id_search__views__list_g := i;

        Views_List__Search_Edit.Color := clWindow;

        Break;

      end;

end;

procedure TDatabase__Modify_Form.Views_List__Search_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl ] ) then
      Views_List__View__Data_Open__DM()
  else
  if    ( Key = VK_RETURN )
    and ( Shift = [ ssShift ] ) then
      Views_List__View__Open__Edit__DM()
  else
  if Key = VK_RETURN then
    Views_List__View__Open__DM();

end;

procedure TDatabase__Modify_Form.Views_List__Search_ButtonKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl, ssShift ] ) then
    Views_List__View__Open__Edit__DM()
  else
  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl ] ) then
    Views_List__View__Data_Open__DM()
  else
  if    ( Key = VK_RETURN )
    and ( Shift = [ ssShift ] ) then
    Views_List__View__Open__DM();

end;

procedure TDatabase__Modify_Form.Views_List__View__Add__Modal__MenuItemClick( Sender: TObject );
var
  modified_l : boolean;

  view__modify_form_l : View__Modify.TView__Modify_Form;
begin

  if sdbm = nil then
    Exit;


  view__modify_form_l := View__Modify.TView__Modify_Form.Create( Application, sdbm );
  view__modify_form_l.database_type__vm := databases_r__dm_g.database_type;
  view__modify_form_l.splitter_show__vm := Splitter_Show_CheckBox.Checked;
  view__modify_form_l.sql__quotation_sign__vm := databases_r__dm_g.sql__quotation_sign;
  view__modify_form_l.sql__quotation_sign__use__vm := Sql__Quotation_Sign__Use_CheckBox.Checked;

  if    ( Sender <> nil )
    and ( Sender = Views_List__View__Add__MenuItem ) then
    begin

      view__modify_form_l.show_modal__vm := false;
      view__modify_form_l.Show();

      Exit;

    end;

  view__modify_form_l.ShowModal();
  modified_l := view__modify_form_l.modified__vm;
  view_name_g := view__modify_form_l.view__name__vm;
  FreeAndNil( view__modify_form_l );


  if modified_l then
    begin

      Views_List__Refresh_MenuItemClick( Sender );

    end;

end;

procedure TDatabase__Modify_Form.Views_List__View__Delete__MenuItemClick( Sender: TObject );
var
  ztb : boolean;

  i,
  item_index_copy_l
    : integer;

  zts,
  error_message_l,
  views__name_l
    : string;
begin

  // Parameters in SQL commands do not work here.

  if   ( Views_List__ListBox.Items.Count <= 0 )
    or ( Views_List__ListBox.ItemIndex < 0 )
    or ( Views_List__ListBox.ItemIndex >= Views_List__ListBox.Items.Count ) then
    Exit;


  views__name_l := Self.Quotation_Sign__DM() + Views_List__ListBox.Items[ Views_List__ListBox.ItemIndex ] + Self.Quotation_Sign__DM();
  item_index_copy_l := Views_List__ListBox.ItemIndex;

  zts := Common.Text__File_Load(  Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + view__drop__file_name_c  );

  if Trim( zts ) = '' then
    begin

      Log_Memo.Lines.Add( Translation.translation__messages_r.file_not_found___default_value_used + ' (' + Common.Databases_Type__Directory_Path__Get( databases_r__dm_g.database_type ) + view__drop__file_name_c + ').' );

      zts :=
        'drop view ' +
        views__name_l +
        ' ';

    end
  else
    begin

      zts := StringReplace( zts, Common.sql__word_replace_separator_c + Common.name__view__big_letters_c + Common.sql__word_replace_separator_c, views__name_l, [ rfReplaceAll ] );

    end;


  Log_Memo.Lines.Add( zts );


  if Application.MessageBox( PChar(Translation.translation__messages_r.delete_view + ' ''' + views__name_l + '''?'), PChar(Translation.translation__messages_r.confirmation), MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION ) <> IDYES then
    Exit;



  for i := Views_List__PageControl.PageCount - 1 downto 0 do
    if    ( Views_List__PageControl.Pages[ i ].ControlCount > 0 )
      and ( Views_List__PageControl.Pages[ i ].Controls[ 0 ].ClassType = View_Modify_F.TView_Modify_F_Frame )
      and ( View_Modify_F.TView_Modify_F_Frame(Views_List__PageControl.Pages[ i ].Controls[ 0 ]).View__Name__Get__VMF() = views__name_l ) then
      begin

        Views_List__PageControl.ActivePageIndex := i;
        Views_List__Page__Close__One_ButtonClick( Sender );

      end;


  ztb := false;

  for i := Views_List__PageControl.PageCount - 1 downto 0 do
    if    ( Views_List__PageControl.Pages[ i ].ControlCount > 0 )
      and ( Views_List__PageControl.Pages[ i ].Controls[ 0 ].ClassType = View_Modify_F.TView_Modify_F_Frame )
      and ( View_Modify_F.TView_Modify_F_Frame(Views_List__PageControl.Pages[ i ].Controls[ 0 ]).View__Name__Get__VMF() = views__name_l ) then
        begin

          ztb := true;
          Break;

        end;


  if ztb then
    begin

      Application.MessageBox( PChar(Translation.translation__messages_r.task_is_still_running_wait_until_finish), PChar(Translation.translation__messages_r.warning), MB_OK + MB_ICONEXCLAMATION );
      Exit;

    end;



  Screen.Cursor := crSQLWait;


  ztb := sdbm.Sql_Command_Execute( zts, error_message_l, Translation.translation__messages_r.failed_to_delete_view_ );


  Screen.Cursor := crDefault;


  if ztb then
    begin

      Log_Memo.Lines.Add( sdbm.Operation_Duration_Get() );


      Views_List__Refresh_MenuItemClick( Sender );


      if    ( Views_List__ListBox.Items.Count > 0 )
        and ( item_index_copy_l - 1 >= 0 )
        and ( item_index_copy_l - 1 < Views_List__ListBox.Items.Count ) then
        Views_List__ListBox.ItemIndex := item_index_copy_l - 1
      else
      if    ( Views_List__ListBox.Items.Count > 0 )
        and ( item_index_copy_l >= 0 )
        and ( item_index_copy_l < Views_List__ListBox.Items.Count ) then
        Views_List__ListBox.ItemIndex := item_index_copy_l;


      Application.MessageBox( PChar(Translation.translation__messages_r.done), PChar(Translation.translation__messages_r.information), MB_OK + MB_ICONINFORMATION );

    end
  else
    begin

      if Trim( error_message_l ) <> '' then
        Log_Memo.Lines.Add(  StringReplace( error_message_l, #10, #13 + #10, [ rfReplaceAll ] )  );

    end;

end;

procedure TDatabase__Modify_Form.Views_List__PageControlMouseDown( Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer );
begin

  if    ( Views_List__PageControl.ActivePageIndex >= 0  )
    and ( Views_List__PageControl.Pages[ Views_List__PageControl.ActivePageIndex ].PageIndex <= Views_List__PageControl.PageCount - 1 ) then
    Views_List__PageControl.Pages[ Views_List__PageControl.ActivePageIndex ].BeginDrag( false );

end;

procedure TDatabase__Modify_Form.Views_List__PageControlDragOver( Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean );
var
  zt_form_1,
  zt_form_2
    : TForm;
begin

  Accept := false;

  if not ( Source is TTabSheet ) then
    Exit;


  // Accept only within the same window.

  zt_form_1 := Common.Parent_Form_Find( Sender );
  zt_form_2 := Common.Parent_Form_Find( Source );

  if    ( zt_form_1 <> nil )
    and ( zt_form_2 <> nil )
    and ( zt_form_1 = zt_form_2 ) then
    Accept := true;

end;

procedure TDatabase__Modify_Form.Views_List__PageControlDragDrop( Sender, Source: TObject; X, Y: Integer );
begin

  if Source is TTabSheet then
    TTabSheet(Source).PageIndex := Views_List__PageControl.IndexOfTabAt( X, Y );

end;

end.
