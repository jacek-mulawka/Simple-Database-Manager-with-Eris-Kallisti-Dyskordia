unit Database__Informations_F;{11.Paü.2023}

interface

uses
  Data.Win.ADODB, FireDAC.Comp.Client,

  Common,
  Database__Informations_Modify_F,
  Translation,
  Triggers_Modify_F,

  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls;

type
  TDatabase__Informations_F_Frame = class( TFrame )
    Database__Informations_PageControl: TPageControl;
    Informations_TabSheet: TTabSheet;
    Triggers_TabSheet: TTabSheet;

    procedure Database__Informations_PageControlChange( Sender: TObject );
  private
    { Private declarations }
    sql__quotation_sign__use__dif_g : boolean;

    database_type__dif_g,
    sql__quotation_sign__dif_g
      : string;

    ado_connection_g : Data.Win.ADODB.TADOConnection;
    fd_connection_g : FireDAC.Comp.Client.TFDConnection;

    component_type_g : Common.TComponent_Type;

    database__informations_f_frame_g : Database__Informations_Modify_F.TDatabase__Informations_Modify_F_Frame;
    triggers_modify_f_frame_g : Triggers_Modify_F.TTriggers_Modify_F_Frame;
  public
    { Public declarations }
    procedure Finish__DIF();
    procedure Highlight__Font__Set__DIF();
    procedure Options_Set__DIF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
    procedure Prepare__DIF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
    procedure Translation__Apply__DIF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
  end;

implementation

{$R *.dfm}

procedure TDatabase__Informations_F_Frame.Finish__DIF();
begin

  database__informations_f_frame_g.Finish__DIMF();
  FreeAndNil( database__informations_f_frame_g );


  if triggers_modify_f_frame_g <> nil then
    begin

      triggers_modify_f_frame_g.Finish__TrMF();
      FreeAndNil( triggers_modify_f_frame_g );

    end;

end;

procedure TDatabase__Informations_F_Frame.Highlight__Font__Set__DIF();
begin

  database__informations_f_frame_g.Highlight__Font__Set__DIMF();


  if triggers_modify_f_frame_g <> nil then
    triggers_modify_f_frame_g.Highlight__Font__Set__TrMF();

end;

procedure TDatabase__Informations_F_Frame.Options_Set__DIF( const component_type_f : Common.TComponent_Type; const sql__quotation_sign_f : string; const sql__quotation_sign__use_f : boolean );
begin

  sql__quotation_sign__dif_g := sql__quotation_sign_f;
  sql__quotation_sign__use__dif_g := sql__quotation_sign__use_f;


  database__informations_f_frame_g.Options_Set__DIMF( component_type_f, sql__quotation_sign__dif_g, sql__quotation_sign__use__dif_g );


  if triggers_modify_f_frame_g <> nil then
    triggers_modify_f_frame_g.Options_Set__TrMF( component_type_f, sql__quotation_sign__dif_g, sql__quotation_sign__use__dif_g );


  Self.Translation__Apply__DIF();

end;

procedure TDatabase__Informations_F_Frame.Prepare__DIF( const databases_r_f : Common.TDatabases_r; const component_type_f : Common.TComponent_Type; ado_connection_f : Data.Win.ADODB.TADOConnection; fd_connection_f : FireDAC.Comp.Client.TFDConnection; const sql__quotation_sign__use_f : boolean );
begin

  Self.Name := '';

  Database__Informations_PageControl.ActivePage := Informations_TabSheet;


  ado_connection_g := ado_connection_f;
  component_type_g := component_type_f;
  database_type__dif_g := databases_r_f.database_type;
  fd_connection_g := fd_connection_f;
  sql__quotation_sign__dif_g := databases_r_f.sql__quotation_sign;
  sql__quotation_sign__use__dif_g := sql__quotation_sign__use_f;


  database__informations_f_frame_g := Database__Informations_Modify_F.TDatabase__Informations_Modify_F_Frame.Create( Application );
  database__informations_f_frame_g.Parent := Informations_TabSheet;
  database__informations_f_frame_g.Align := alClient;
  database__informations_f_frame_g.parent_supreme_tab_sheet__dimf := Informations_TabSheet;
  database__informations_f_frame_g.Prepare__DIMF( database_type__dif_g, sql__quotation_sign__dif_g, component_type_g, ado_connection_g, fd_connection_g, sql__quotation_sign__use__dif_g );
  database__informations_f_frame_g.Data_Open__DIMF();


  triggers_modify_f_frame_g := nil;

end;

procedure TDatabase__Informations_F_Frame.Translation__Apply__DIF( const tak_f : Translation.TTranslation_Apply_Kind = Translation.tak_All );
begin

  Translation.Translation__Apply( Self );


  database__informations_f_frame_g.Translation__Apply__DIMF( tak_f );


  if triggers_modify_f_frame_g <> nil then
    triggers_modify_f_frame_g.Translation__Apply__TrMF( tak_f );

end;

procedure TDatabase__Informations_F_Frame.Database__Informations_PageControlChange( Sender: TObject );
begin

  if    ( Database__Informations_PageControl.ActivePage = Triggers_TabSheet )
    and ( triggers_modify_f_frame_g = nil ) then
    begin

      triggers_modify_f_frame_g := Triggers_Modify_F.TTriggers_Modify_F_Frame.Create( Application );
      triggers_modify_f_frame_g.Parent := Triggers_TabSheet;
      triggers_modify_f_frame_g.Align := alClient;
      triggers_modify_f_frame_g.parent_supreme_tab_sheet__trmf := Triggers_TabSheet;
      triggers_modify_f_frame_g.Prepare__TrMF( Triggers_Modify_F.tt_database, '', database_type__dif_g, sql__quotation_sign__dif_g, component_type_g, ado_connection_g, fd_connection_g, sql__quotation_sign__use__dif_g );
      triggers_modify_f_frame_g.Data_Open__TrMF();

    end;

end;

end.
