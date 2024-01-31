unit Stored_Procedure_Modify_F;{22.Sie.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Dependencies_F,
  Permissions_Modify_F,
  Stored_Procedure__Edit_Execute_F,
  Translation,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls;

type
  TStored_Procedure_Modify_F_Frame = class( TFrame )
    Stored_Procedure_Modify_PageControl: TPageControl;
    Edit_Execute_TabSheet: TTabSheet;
    Dependencies_TabSheet: TTabSheet;
    Permissions_TabSheet: TTabSheet;

    procedure Stored_Procedure_Modify_PageControlChange( Sender: TObject );
  private
    { Private declarations }
    sql__quotation_sign__use__spmf_g : boolean;

    database_type__spmf__g,
    sql__quotation_sign__spmf_g,
    stored_procedure_name__spmf__g
      : string;

    ado_connection_g : Data.Win.ADODB.TADOConnection;
    fd_connection_g : FireDAC.Comp.Client.TFDConnection;

    component_type_g : Common.TComponent_Type;

    dependencies_f_frame_g : Dependencies_F.TDependencies_F_Frame;
    permissions_modify_f_frame_g : Permissions_Modify_F.TPermissions_Modify_F_Frame;
    stored_procedure__edit_execute_f_frame_g : Stored_Procedure__Edit_Execute_F.TStored_Procedure__Edit_Execute_F_Frame;
  public
    { Public declarations }
    Additional_Component_Show__Get_wsk : function() : boolean of object;
    Splitter_Show__Get_wsk : function() : boolean of object;

    function Finish__SPMF() : boolean;
    procedure Options_Set__SPMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
    procedure Prepare__SPMF( const databases_r_f : Common.TDatabases_r; const stored_procedure_name_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
    procedure Stored_Procedure__Edit__SPMF();
    function Stored_Procedure__Name__Get__SPMF() : string;
    function Task_Running_Check__SPMF( const message_show_f : boolean = true ) : boolean;
    procedure Translation__Apply__SPMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
  end;

implementation

{$R *.dfm}

function TStored_Procedure_Modify_F_Frame.Finish__SPMF() : boolean;
begin

  if Self.Task_Running_Check__SPMF() then
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


  stored_procedure__edit_execute_f_frame_g.Finish__SPEEF();
  FreeAndNil( stored_procedure__edit_execute_f_frame_g );

end;

procedure TStored_Procedure_Modify_F_Frame.Options_Set__SPMF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
begin

  sql__quotation_sign__use__spmf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__spmf_g := sql__quotation_sign_f;


  if dependencies_f_frame_g <> nil then
    dependencies_f_frame_g.Options_Set__DF( component_type_f );


  if permissions_modify_f_frame_g <> nil then
    permissions_modify_f_frame_g.Options_Set__PMF( component_type_f, sql__quotation_sign__spmf_g, sql__quotation_sign__use__spmf_g );


  stored_procedure__edit_execute_f_frame_g.Options_Set__SPEEF( component_type_f, sql__quotation_sign__spmf_g, queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use__spmf_g );


  Self.Translation__Apply__SPMF();

end;

procedure TStored_Procedure_Modify_F_Frame.Prepare__SPMF( const databases_r_f : Common.TDatabases_r; const stored_procedure_name_f : string; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use_f : boolean );
begin

  Self.Name := '';

  Stored_Procedure_Modify_PageControl.ActivePage := Edit_Execute_TabSheet;


  ado_connection_g := ado_connection_f;
  component_type_g := component_type_f;
  database_type__spmf__g := databases_r_f.database_type;
  fd_connection_g := fd_connection_f;
  sql__quotation_sign__use__spmf_g := sql__quotation_sign__use_f;
  sql__quotation_sign__spmf_g := databases_r_f.sql__quotation_sign;
  stored_procedure_name__spmf__g := stored_procedure_name_f;


  dependencies_f_frame_g := nil;


  permissions_modify_f_frame_g := nil;


  stored_procedure__edit_execute_f_frame_g := Stored_Procedure__Edit_Execute_F.TStored_Procedure__Edit_Execute_F_Frame.Create( Application );
  stored_procedure__edit_execute_f_frame_g.Parent := Edit_Execute_TabSheet;
  stored_procedure__edit_execute_f_frame_g.Align := alClient;
  stored_procedure__edit_execute_f_frame_g.parent_supreme_tab_sheet := Self.Parent;
  stored_procedure__edit_execute_f_frame_g.Prepare__SPEEF( databases_r_f, stored_procedure_name__spmf__g, component_type_g, ado_connection_g, fd_connection_g, queries_open_in_background_f, splitter_show_f, sql__quotation_sign__use__spmf_g );
  stored_procedure__edit_execute_f_frame_g.Data_Open__SPEEF();


  Self.Translation__Apply__SPMF();

end;

procedure TStored_Procedure_Modify_F_Frame.Stored_Procedure__Edit__SPMF();
begin

  Stored_Procedure_Modify_PageControl.ActivePage := Edit_Execute_TabSheet;

  Stored_Procedure_Modify_PageControlChange( nil );

  if stored_procedure__edit_execute_f_frame_g <> nil then
    stored_procedure__edit_execute_f_frame_g.Stored_Procedure__Edit_Execute_F__Edit__SPEEF();

end;

function TStored_Procedure_Modify_F_Frame.Stored_Procedure__Name__Get__SPMF() : string;
begin

  Result := stored_procedure_name__spmf__g;

end;

function TStored_Procedure_Modify_F_Frame.Task_Running_Check__SPMF( const message_show_f : boolean = true ) : boolean;
begin

  if stored_procedure__edit_execute_f_frame_g.Task_Running_Check__SPEEF( message_show_f ) then
    Result := true
  else
    Result := false;

end;

procedure TStored_Procedure_Modify_F_Frame.Translation__Apply__SPMF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
begin

  Translation.Translation__Apply( Self );


  if dependencies_f_frame_g <> nil then
    dependencies_f_frame_g.Translation__Apply__DF();


  if permissions_modify_f_frame_g <> nil then
    permissions_modify_f_frame_g.Translation__Apply__PMF( tak_f );


  stored_procedure__edit_execute_f_frame_g.Translation__Apply__SPEEF( tak_f );

end;

procedure TStored_Procedure_Modify_F_Frame.Stored_Procedure_Modify_PageControlChange( Sender: TObject );
begin

  if    ( Stored_Procedure_Modify_PageControl.ActivePage = Dependencies_TabSheet )
    and ( dependencies_f_frame_g = nil ) then
    begin

      dependencies_f_frame_g := Dependencies_F.TDependencies_F_Frame.Create( Application );
      dependencies_f_frame_g.Parent := Dependencies_TabSheet;
      dependencies_f_frame_g.Align := alClient;
      dependencies_f_frame_g.parent_supreme_tab_sheet := Self.Parent;
      dependencies_f_frame_g.Prepare__DF( stored_procedure_name__spmf__g, database_type__spmf__g, component_type_g, ado_connection_g, fd_connection_g );
      dependencies_f_frame_g.Data_Open__DF();

    end
  else
  if    ( Stored_Procedure_Modify_PageControl.ActivePage = Permissions_TabSheet )
    and ( permissions_modify_f_frame_g = nil ) then
    begin

      permissions_modify_f_frame_g := Permissions_Modify_F.TPermissions_Modify_F_Frame.Create( Application );
      permissions_modify_f_frame_g.Parent := Permissions_TabSheet;
      permissions_modify_f_frame_g.Align := alClient;
      permissions_modify_f_frame_g.parent_supreme_tab_sheet := Self.Parent;
      permissions_modify_f_frame_g.Prepare__PMF( stored_procedure_name__spmf__g, database_type__spmf__g, sql__quotation_sign__spmf_g, component_type_g, ado_connection_g, fd_connection_g, Permissions_Modify_F.pot_procedure_stored, sql__quotation_sign__use__spmf_g );
      permissions_modify_f_frame_g.Data_Open__PMF();

    end;

end;

end.
