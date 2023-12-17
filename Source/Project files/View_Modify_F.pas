unit View_Modify_F;{05.Wrz.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Dependencies_F,
  Permissions_Modify_F,
  View__Edit_Execute_F,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls;

type
  TView_Modify_F_Frame = class( TFrame )
    Views_Modify_PageControl: TPageControl;
    Edit_Execute_TabSheet: TTabSheet;
    Dependencies_TabSheet: TTabSheet;
    Permissions_TabSheet: TTabSheet;

    procedure Views_Modify_PageControlChange( Sender: TObject );
  private
    { Private declarations }
    sql__quotation_sign__use__vmf_g : boolean;

    database_type__vmf__g,
    sql__quotation_sign__vmf_g,
    view_name__vmf__g
      : string;

    ado_connection_g : Data.Win.ADODB.TADOConnection;
    fd_connection_g : FireDAC.Comp.Client.TFDConnection;

    component_type_g : Common.TComponent_Type;

    dependencies_f_frame_g : Dependencies_F.TDependencies_F_Frame;
    permissions_modify_f_frame_g : Permissions_Modify_F.TPermissions_Modify_F_Frame;
    view__edit_execute_f_frame_g : View__Edit_Execute_F.TView__Edit_Execute_F_Frame;
  public
    { Public declarations }
    Additional_Component_Show__Get_wsk : function() : boolean of object;
    Splitter_Show__Get_wsk : function() : boolean of object;

    function Finish__VMF() : boolean;
    procedure Options_Set__VMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
    procedure Prepare__VMF( const databases_r_f : Common.TDatabases_r; const view_name_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
    function View_Name__Get__VMF() : string;
    function Task_Running_Check__VMF( const message_show_f : boolean = true ) : boolean;
  end;

implementation

uses
 Translation;

{$R *.dfm}

function TView_Modify_F_Frame.Finish__VMF() : boolean;
begin

  if Task_Running_Check__VMF() then
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


  view__edit_execute_f_frame_g.Finish__VEEF();
  FreeAndNil( view__edit_execute_f_frame_g );

end;

procedure TView_Modify_F_Frame.Options_Set__VMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
begin

  sql__quotation_sign__use__vmf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__vmf_g := sql__quotation_sign_f;


  if dependencies_f_frame_g <> nil then
    dependencies_f_frame_g.Options_Set__DF( component_type_f );


  if permissions_modify_f_frame_g <> nil then
    permissions_modify_f_frame_g.Options_Set__PMF( component_type_f, sql__quotation_sign__vmf_g, sql__quotation_sign__use__vmf_g );


  view__edit_execute_f_frame_g.Options_Set__VEEF( component_type_f, sql__quotation_sign__vmf_g, queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use__vmf_g );


  Translation.Translation__Apply( Self );

end;

procedure TView_Modify_F_Frame.Prepare__VMF( const databases_r_f : Common.TDatabases_r; const view_name_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
begin

  Self.Name := '';

  Views_Modify_PageControl.ActivePage := Edit_Execute_TabSheet;


  ado_connection_g := ado_connection_f;
  component_type_g := component_type_f;
  database_type__vmf__g := databases_r_f.database_type;
  fd_connection_g := fd_connection_f;
  sql__quotation_sign__use__vmf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__vmf_g := databases_r_f.sql__quotation_sign;
  view_name__vmf__g := view_name_f;


  dependencies_f_frame_g := nil;


  permissions_modify_f_frame_g := nil;


  view__edit_execute_f_frame_g := View__Edit_Execute_F.TView__Edit_Execute_F_Frame.Create( Application );
  view__edit_execute_f_frame_g.Parent := Edit_Execute_TabSheet;
  view__edit_execute_f_frame_g.Align := alClient;
  view__edit_execute_f_frame_g.parent_supreme_tab_sheet := Self.Parent;
  view__edit_execute_f_frame_g.Prepare__VEEF( databases_r_f, view_name__vmf__g, component_type_g, ado_connection_g, fd_connection_g, queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use__vmf_g );
  view__edit_execute_f_frame_g.Data_Open__VEEF();


  Translation.Translation__Apply( Self );

end;

function TView_Modify_F_Frame.View_Name__Get__VMF() : string;
begin

  Result := view_name__vmf__g;

end;

function TView_Modify_F_Frame.Task_Running_Check__VMF( const message_show_f : boolean = true ) : boolean;
begin

  if view__edit_execute_f_frame_g.Task_Running_Check__VEEF( message_show_f ) then
    Result := true
  else
    Result := false;

end;

procedure TView_Modify_F_Frame.Views_Modify_PageControlChange( Sender: TObject );
begin

  if    ( Views_Modify_PageControl.ActivePage = Dependencies_TabSheet )
    and ( dependencies_f_frame_g = nil ) then
    begin

      dependencies_f_frame_g := Dependencies_F.TDependencies_F_Frame.Create( Application );
      dependencies_f_frame_g.Parent := Dependencies_TabSheet;
      dependencies_f_frame_g.Align := alClient;
      dependencies_f_frame_g.parent_supreme_tab_sheet := Self.Parent;
      dependencies_f_frame_g.Prepare__DF( view_name__vmf__g, database_type__vmf__g, component_type_g, ado_connection_g, fd_connection_g );
      dependencies_f_frame_g.Data_Open__DF();

    end
  else
  if    ( Views_Modify_PageControl.ActivePage = Permissions_TabSheet )
    and ( permissions_modify_f_frame_g = nil ) then
    begin

      permissions_modify_f_frame_g := Permissions_Modify_F.TPermissions_Modify_F_Frame.Create( Application );
      permissions_modify_f_frame_g.Parent := Permissions_TabSheet;
      permissions_modify_f_frame_g.Align := alClient;
      permissions_modify_f_frame_g.parent_supreme_tab_sheet := Self.Parent;
      permissions_modify_f_frame_g.Prepare__PMF( view_name__vmf__g, database_type__vmf__g, sql__quotation_sign__vmf_g, component_type_g, ado_connection_g, fd_connection_g, Permissions_Modify_F.pot_table, sql__quotation_sign__use__vmf_g );
      permissions_modify_f_frame_g.Data_Open__PMF();

    end;

end;

end.
