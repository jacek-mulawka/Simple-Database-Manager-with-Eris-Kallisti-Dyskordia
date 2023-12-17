unit Table_Modify_F;{26.Cze.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Dependencies_F,
  Permissions_Modify_F,
  Table__Columns_Sort_F,
  Table__Data_Modify_F,
  Table__Indexes_Modify_F,
  Table__Metadata_F,
  Triggers_Modify_F,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls;

type
  TTable_Modify_F_Frame = class( TFrame )
    Table_Modify_PageControl: TPageControl;
    Data_TabSheet: TTabSheet;
    Indexes_TabSheet: TTabSheet;
    Metadata_TabSheet: TTabSheet;
    Columns_Sort_TabSheet: TTabSheet;
    Dependencies_TabSheet: TTabSheet;
    Permissions_TabSheet: TTabSheet;
    Triggers_TabSheet: TTabSheet;

    procedure Table_Modify_PageControlChange( Sender: TObject );
  private
    { Private declarations }
    additional_component_show__tmof_g,
    queries_open_in_background__tmof_g,
    splitter_show__tmof_g,
    sql__quotation_sign__use__tmof_g
      : boolean;

    sql__quotation_sign__tmof_g,
    table_name__tmof_g
      : string;

    databases__tmof_g : Common.TDatabases_r;

    ado_connection_g : Data.Win.ADODB.TADOConnection;
    fd_connection_g : FireDAC.Comp.Client.TFDConnection;

    component_type_g : Common.TComponent_Type;

    dependencies_f_frame_g : Dependencies_F.TDependencies_F_Frame;
    permissions_modify_f_frame_g : Permissions_Modify_F.TPermissions_Modify_F_Frame;
    table__columns_sort_f_frame_g : Table__Columns_Sort_F.TTable__Columns_Sort_F_Frame;
    table__data_modify_f_frame_g : Table__Data_Modify_F.TTable__Data_Modify_F_Frame;
    table__indexes_modify_f_frame_g : Table__Indexes_Modify_F.TTable__Indexes_Modify_F_Frame;
    table__metadata_f_frame_g : Table__Metadata_F.TTable__Metadata_F_Frame;
    triggers_modify_f_frame_g : Triggers_Modify_F.TTriggers_Modify_F_Frame;

    function Table__Data_Modify_F__Data_Close__TMoF() : boolean;
  public
    { Public declarations }
    Additional_Component_Show__Get_wsk : function() : boolean of object;
    Splitter_Show__Get_wsk : function() : boolean of object;

    function Finish__TMoF() : boolean;
    procedure Options_Set__TMoF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const additional_component_show_f, queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
    procedure Prepare__TMoF( const databases_r_f : Common.TDatabases_r; const table_name_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const additional_component_show_f, queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
    function Table_Name__Get__TMoF() : string;
    function Task_Running_Check__TMoF( const message_show_f : boolean = true ) : boolean;
  end;

implementation

uses
 Translation;

{$R *.dfm}

function TTable_Modify_F_Frame.Finish__TMoF() : boolean;
begin

  if Task_Running_Check__TMoF() then
    begin

      Result := false;

      Exit;

    end
  else
    Result := true;


  if  dependencies_f_frame_g <> nil then
    begin

      dependencies_f_frame_g.Finish__DF();
      FreeAndNil( dependencies_f_frame_g );

    end;


  if  permissions_modify_f_frame_g <> nil then
    begin

      permissions_modify_f_frame_g.Finish__PMF();
      FreeAndNil( permissions_modify_f_frame_g );

    end;


  if table__columns_sort_f_frame_g <> nil then
    begin

      table__columns_sort_f_frame_g.Finish__TCSF();
      FreeAndNil( table__columns_sort_f_frame_g );

    end;


  if table__data_modify_f_frame_g <> nil then
    begin

      table__data_modify_f_frame_g.Finish__TDMF();
      FreeAndNil( table__data_modify_f_frame_g );

    end;


  if table__indexes_modify_f_frame_g <> nil then
    begin

      table__indexes_modify_f_frame_g.Finish__TIMF();
      FreeAndNil( table__indexes_modify_f_frame_g );

    end;


  if table__metadata_f_frame_g <> nil then
    begin

      table__metadata_f_frame_g.Finish__TMeF();
      FreeAndNil( table__metadata_f_frame_g );

    end;


  if triggers_modify_f_frame_g <> nil then
    begin

      triggers_modify_f_frame_g.Finish__TrMF();
      FreeAndNil( triggers_modify_f_frame_g );

    end;

end;

procedure TTable_Modify_F_Frame.Options_Set__TMoF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const additional_component_show_f, queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
begin

  sql__quotation_sign__tmof_g := sql__quotation_sign_f;
  sql__quotation_sign__use__tmof_g := sql__quotation_sign__use_f;


  if dependencies_f_frame_g <> nil then
    dependencies_f_frame_g.Options_Set__DF( component_type_f );


  if permissions_modify_f_frame_g <> nil then
    permissions_modify_f_frame_g.Options_Set__PMF( component_type_f, sql__quotation_sign__tmof_g, sql__quotation_sign__use__tmof_g );


  if table__columns_sort_f_frame_g <> nil then
    table__columns_sort_f_frame_g.Options_Set__TCSF( component_type_f, sql__quotation_sign__tmof_g, sql__quotation_sign__use__tmof_g );


  if table__data_modify_f_frame_g <> nil then
    table__data_modify_f_frame_g.Options_Set__TDMF( component_type_f, sql__quotation_sign__tmof_g, additional_component_show_f, queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use__tmof_g );


  if table__indexes_modify_f_frame_g <> nil then
    table__indexes_modify_f_frame_g.Options_Set__TIMF( component_type_f, sql__quotation_sign__tmof_g, sql__quotation_sign__use__tmof_g );


  if table__metadata_f_frame_g <> nil then
    table__metadata_f_frame_g.Options_Set__TMeF( component_type_f, sql__quotation_sign__tmof_g, queries_open_in_background_f, sql__quotation_sign__use__tmof_g );


  if triggers_modify_f_frame_g <> nil then
    triggers_modify_f_frame_g.Options_Set__TrMF( component_type_f, sql__quotation_sign__tmof_g, sql__quotation_sign__use__tmof_g );


  Translation.Translation__Apply( Self );

end;

procedure TTable_Modify_F_Frame.Prepare__TMoF( const databases_r_f : Common.TDatabases_r; const table_name_f: string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const additional_component_show_f, queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
begin

  Self.Name := '';

  Table_Modify_PageControl.ActivePage := Metadata_TabSheet;


  additional_component_show__tmof_g := additional_component_show_f;
  ado_connection_g := ado_connection_f;
  component_type_g := component_type_f;
  databases__tmof_g := databases_r_f;
  fd_connection_g := fd_connection_f;
  queries_open_in_background__tmof_g := queries_open_in_background_f;
  splitter_show__tmof_g := splitter_show_f;
  sql__quotation_sign__tmof_g := databases_r_f.sql__quotation_sign;
  sql__quotation_sign__use__tmof_g := sql__quotation_sign__use_f;
  table_name__tmof_g := table_name_f;


  dependencies_f_frame_g := nil;


  permissions_modify_f_frame_g := nil;


  table__columns_sort_f_frame_g := nil;


  table__data_modify_f_frame_g := nil;


  table__indexes_modify_f_frame_g := nil;


  table__metadata_f_frame_g := nil;


  triggers_modify_f_frame_g := nil;


  Table_Modify_PageControlChange( nil );


  Translation.Translation__Apply( Self );

end;

function TTable_Modify_F_Frame.Table__Data_Modify_F__Data_Close__TMoF() : boolean;
begin

  if table__data_modify_f_frame_g <> nil then
    begin

      if table__data_modify_f_frame_g.Task_Running_Check__TDMF() then
        Result := false
      else
        Result := table__data_modify_f_frame_g.Table__Data_Modify_F__Data_Close__TDMF();

    end
  else
    Result := true;

end;

function TTable_Modify_F_Frame.Table_Name__Get__TMoF() : string;
begin

  Result := table_name__tmof_g;

end;

function TTable_Modify_F_Frame.Task_Running_Check__TMoF( const message_show_f : boolean = true ) : boolean;
begin

  Result := false;


  if    ( table__data_modify_f_frame_g <> nil )
    and (  table__data_modify_f_frame_g.Task_Running_Check__TDMF( message_show_f )  ) then
    Result := true
  else
  if    ( table__metadata_f_frame_g <> nil )
    and (  table__metadata_f_frame_g.Task_Running_Check__TMeF( message_show_f )  ) then
    Result := true;

end;

procedure TTable_Modify_F_Frame.Table_Modify_PageControlChange( Sender: TObject );
begin

  if    ( Table_Modify_PageControl.ActivePage = Dependencies_TabSheet )
    and ( dependencies_f_frame_g = nil ) then
    begin

      dependencies_f_frame_g := Dependencies_F.TDependencies_F_Frame.Create( Application );
      dependencies_f_frame_g.Parent := Dependencies_TabSheet;
      dependencies_f_frame_g.Align := alClient;
      dependencies_f_frame_g.parent_supreme_tab_sheet := Self.Parent;
      dependencies_f_frame_g.Prepare__DF( table_name__tmof_g, databases__tmof_g.database_type, component_type_g, ado_connection_g, fd_connection_g );
      dependencies_f_frame_g.Data_Open__DF();

    end
  else
  if    ( Table_Modify_PageControl.ActivePage = Permissions_TabSheet )
    and ( permissions_modify_f_frame_g = nil ) then
    begin

      permissions_modify_f_frame_g := Permissions_Modify_F.TPermissions_Modify_F_Frame.Create( Application );
      permissions_modify_f_frame_g.Parent := Permissions_TabSheet;
      permissions_modify_f_frame_g.Align := alClient;
      permissions_modify_f_frame_g.parent_supreme_tab_sheet := Self.Parent;
      permissions_modify_f_frame_g.Prepare__PMF( table_name__tmof_g, databases__tmof_g.database_type, sql__quotation_sign__tmof_g, component_type_g, ado_connection_g, fd_connection_g, Permissions_Modify_F.pot_table, sql__quotation_sign__use__tmof_g );
      permissions_modify_f_frame_g.Data_Open__PMF();

    end
  else
  if    ( Table_Modify_PageControl.ActivePage = Columns_Sort_TabSheet )
    and ( table__columns_sort_f_frame_g = nil ) then
    begin

      table__columns_sort_f_frame_g := Table__Columns_Sort_F.TTable__Columns_Sort_F_Frame.Create( Application );
      table__columns_sort_f_frame_g.Parent := Columns_Sort_TabSheet;
      table__columns_sort_f_frame_g.Align := alClient;
      table__columns_sort_f_frame_g.parent_supreme_tab_sheet := Self.Parent;
      table__columns_sort_f_frame_g.Prepare__TCSF( table_name__tmof_g, databases__tmof_g.database_type, sql__quotation_sign__tmof_g, component_type_g, ado_connection_g, fd_connection_g, sql__quotation_sign__use__tmof_g, Table__Data_Modify_F__Data_Close__TMoF );
      table__columns_sort_f_frame_g.Data_Open__TCSF();

    end
  else
  if    ( Table_Modify_PageControl.ActivePage = Data_TabSheet )
    and ( table__data_modify_f_frame_g = nil ) then
    begin

      table__data_modify_f_frame_g := Table__Data_Modify_F.TTable__Data_Modify_F_Frame.Create( Application );
      table__data_modify_f_frame_g.Parent := Data_TabSheet;
      table__data_modify_f_frame_g.Align := alClient;
      table__data_modify_f_frame_g.parent_supreme_tab_sheet := Self.Parent;
      table__data_modify_f_frame_g.Additional_Component_Show__Get_wsk := Additional_Component_Show__Get_wsk;
      table__data_modify_f_frame_g.Splitter_Show__Get_wsk := Splitter_Show__Get_wsk;
      table__data_modify_f_frame_g.Prepare__TDMF( databases__tmof_g, table_name__tmof_g, component_type_g, ado_connection_g, fd_connection_g, additional_component_show__tmof_g, queries_open_in_background__tmof_g, splitter_show__tmof_g, sql__quotation_sign__use__tmof_g );

    end
  else
  if    ( Table_Modify_PageControl.ActivePage = Indexes_TabSheet )
    and ( table__indexes_modify_f_frame_g = nil ) then
    begin

      table__indexes_modify_f_frame_g := Table__Indexes_Modify_F.TTable__Indexes_Modify_F_Frame.Create( Application );
      table__indexes_modify_f_frame_g.Parent := Indexes_TabSheet;
      table__indexes_modify_f_frame_g.Align := alClient;
      table__indexes_modify_f_frame_g.parent_supreme_tab_sheet := Self.Parent;
      table__indexes_modify_f_frame_g.Prepare__TIMF( table_name__tmof_g, databases__tmof_g.database_type, sql__quotation_sign__tmof_g, component_type_g, ado_connection_g, fd_connection_g, sql__quotation_sign__use__tmof_g );
      table__indexes_modify_f_frame_g.Data_Open__TIMF();

    end
  else
  if    ( Table_Modify_PageControl.ActivePage = Metadata_TabSheet )
    and ( table__metadata_f_frame_g = nil ) then
    begin

      table__metadata_f_frame_g := Table__Metadata_F.TTable__Metadata_F_Frame.Create( Application );
      table__metadata_f_frame_g.Parent := Metadata_TabSheet;
      table__metadata_f_frame_g.Align := alClient;
      table__metadata_f_frame_g.parent_supreme_tab_sheet := Self.Parent;
      table__metadata_f_frame_g.Prepare__TMeF( table_name__tmof_g, databases__tmof_g.database_type, sql__quotation_sign__tmof_g, component_type_g, ado_connection_g, fd_connection_g, queries_open_in_background__tmof_g, sql__quotation_sign__use__tmof_g );
      table__metadata_f_frame_g.Data_Open__TMeF( true );

    end
  else
  if    ( Table_Modify_PageControl.ActivePage = Triggers_TabSheet )
    and ( triggers_modify_f_frame_g = nil ) then
    begin

      triggers_modify_f_frame_g := Triggers_Modify_F.TTriggers_Modify_F_Frame.Create( Application );
      triggers_modify_f_frame_g.Parent := Triggers_TabSheet;
      triggers_modify_f_frame_g.Align := alClient;
      triggers_modify_f_frame_g.parent_supreme_tab_sheet := Self.Parent;
      triggers_modify_f_frame_g.Prepare__TrMF( Triggers_Modify_F.tt_table, table_name__tmof_g, databases__tmof_g.database_type, sql__quotation_sign__tmof_g, component_type_g, ado_connection_g, fd_connection_g, sql__quotation_sign__use__tmof_g );
      triggers_modify_f_frame_g.Data_Open__TrMF( true );

    end;

end;

end.
