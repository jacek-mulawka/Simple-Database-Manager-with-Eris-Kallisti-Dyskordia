unit Text__Search_Replace__Prompt;{10.Lis.2023}

  // mrYes = replace and continue
  // mrCancel = do not replace and break
  // mrNo = do not replace and continue
  // mrYesToAll = replace all

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TSet_Of_TMsgDlgBtn = set of TMsgDlgBtn;

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
    procedure Caption_Text__Replace__Set( const caption_text_f : string );
    procedure Caption_Text__Set( const caption_text_f : string );

    function Modal_Result__Get( const caption_text_f : string; buttons_f : TSet_Of_TMsgDlgBtn = [ TMsgDlgBtn.mbYes, TMsgDlgBtn.mbCancel, TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYesToAll ] ) : TModalResult;
  end;

var
  Text__Search_Replace__Prompt_Form: TText__Search_Replace__Prompt_Form;

implementation

uses
  Shared,
  Translation;

{$R *.dfm}

procedure TText__Search_Replace__Prompt_Form.Caption_Text__Replace__Set( const caption_text_f : string );
begin

  Message_Panel.Caption := Translation.translation__messages_r.replace_this_occurrence_of + ' ''' +  caption_text_f + '''?';

end;

procedure TText__Search_Replace__Prompt_Form.Caption_Text__Set( const caption_text_f : string );
begin

  Message_Panel.Caption := caption_text_f;

end;

function TText__Search_Replace__Prompt_Form.Modal_Result__Get( const caption_text_f : string; buttons_f : TSet_Of_TMsgDlgBtn = [ TMsgDlgBtn.mbYes, TMsgDlgBtn.mbCancel, TMsgDlgBtn.mbNo, TMsgDlgBtn.mbYesToAll ] ) : TModalResult;
var
  text__search_replace__prompt_form_l : TText__Search_Replace__Prompt_Form;
begin

  text__search_replace__prompt_form_l := Text__Search_Replace__Prompt.TText__Search_Replace__Prompt_Form.Create( Application );
  text__search_replace__prompt_form_l.Caption_Text__Set( caption_text_f );
  text__search_replace__prompt_form_l.Position := poScreenCenter;

  text__search_replace__prompt_form_l.Yes_Button.Visible := TMsgDlgBtn.mbYes in buttons_f;
  text__search_replace__prompt_form_l.No_Button.Visible := TMsgDlgBtn.mbNo in buttons_f;
  text__search_replace__prompt_form_l.Cancel_Button.Visible := TMsgDlgBtn.mbCancel in buttons_f;
  text__search_replace__prompt_form_l.Yes_To_All_Button.Visible := TMsgDlgBtn.mbYesToAll in buttons_f;

  Result := text__search_replace__prompt_form_l.ShowModal();
  FreeAndNil( text__search_replace__prompt_form_l );

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
