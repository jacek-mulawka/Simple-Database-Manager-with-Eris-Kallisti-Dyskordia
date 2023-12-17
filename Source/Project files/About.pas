unit About;{16.Cze.2023}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TAbout_Form = class( TForm )
    About_1_Label: TLabel;
    About_2_Label: TLabel;
    E_Mail_LinkLabel: TLinkLabel;
    Www_LinkLabel: TLinkLabel;
    Logo_Image: TImage;
    Project_Used_Label: TLabel;
    TurboPack__SynEdit_LinkLabel: TLinkLabel;
    TurboPack__DOSCommand_LinkLabel: TLinkLabel;
    procedure FormCreate( Sender: TObject );
    procedure LinkLabelLinkClick( Sender: TObject; const Link: string; LinkType: TSysLinkType );
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  About_Form: TAbout_Form;

implementation

uses
  Winapi.ShellAPI,

  Translation;

{$R *.dfm}

procedure TAbout_Form.FormCreate( Sender: TObject );
begin

  Translation.Translation__Apply( Self );

end;

procedure TAbout_Form.LinkLabelLinkClick( Sender: TObject; const Link: string; LinkType: TSysLinkType );
begin

  if Trim( Link ) <> '' then
    ShellExecuteW( 0, 'Open', PWideChar(Link), nil, nil, SW_SHOWDEFAULT );

end;

end.
