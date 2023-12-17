unit Text__Search_Replace__Prompt;{10.Lis.2023}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TText__Search_Replace__Prompt_Form = class( TForm )
    Icon_Image: TImage;
    Message_Panel: TPanel;
    Buttons_Panel: TPanel;
    Icon_Panel: TPanel;
    Yes_Button: TButton;
    No_Button: TButton;
    Cancel_Button: TButton;
    Yes_To_All_Button: TButton;
    procedure FormCreate( Sender: TObject );
    procedure ButtonKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Caption_Text_Set( const caption_text_f : string );
  end;

var
  Text__Search_Replace__Prompt_Form: TText__Search_Replace__Prompt_Form;

implementation

uses
  Shared,
  Translation;

{$R *.dfm}

procedure TText__Search_Replace__Prompt_Form.Caption_Text_Set( const caption_text_f : string );
begin

  Message_Panel.Caption := Translation.translation__messages_r.replace_this_occurrence_of + ' ''' +  caption_text_f + '''?';

end;

procedure TText__Search_Replace__Prompt_Form.FormCreate( Sender: TObject );
begin

  Icon_Image.Picture.Icon.Handle := LoadIcon( 0, IDI_QUESTION );


  Translation.Translation__Apply( Self );

end;

procedure TText__Search_Replace__Prompt_Form.ButtonKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if Key = VK_BACK then
    ModalResult := Cancel_Button.ModalResult
  else
  // A.
  if Key = 65 then
    ModalResult := Yes_To_All_Button.ModalResult;

end;

end.
