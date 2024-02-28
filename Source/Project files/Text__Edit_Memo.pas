unit Text__Edit_Memo;{03.Sie.2023}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TText_Type = ( tt_none, tt_Edit, tt_Memo );

  TText__Edit_Memo_Form = class( TForm )
    Ok_Button: TButton;
    Cancel_Button: TButton;
    Description_Memo: TMemo;
    Hint_Button: TButton;
    Use_RadioGroup: TRadioGroup;
    Description_Edit: TEdit;
    procedure FormCreate( Sender: TObject );
    procedure FormShow( Sender: TObject );

    procedure Ok_ButtonClick( Sender: TObject );

    procedure Hint_ButtonClick( Sender: TObject );
    procedure Use_RadioGroupClick( Sender: TObject );

    procedure Description_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
    procedure Description_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
  private
    { Private declarations }
  public
    { Public declarations }
    quotation_mark_duplicate : boolean;
    hint_,
    text_value
      : string;

    procedure Text_Type_Set( const text_type_f : TText_Type );
  end;

var
  Text__Edit_Memo_Form: TText__Edit_Memo_Form;

implementation

uses
  Common,
  Shared,
  Translation;

{$R *.dfm}

procedure TText__Edit_Memo_Form.Text_Type_Set( const text_type_f : TText_Type );
var
  zti : integer;
begin

  zti := integer(text_type_f) - 1;


  if    ( zti >= 0 )
    and ( Use_RadioGroup.Items.Count > 0 )
    and ( zti < Use_RadioGroup.Items.Count ) then
    Use_RadioGroup.ItemIndex := zti;

end;


procedure TText__Edit_Memo_Form.FormCreate( Sender: TObject );
begin

  hint_ := '';
  quotation_mark_duplicate := true;
  text_value := '';

  Translation.Translation__Apply( Self );

end;

procedure TText__Edit_Memo_Form.FormShow( Sender: TObject );
begin

  Description_Edit.Text := text_value;
  Description_Memo.Lines.Text := text_value;

  Hint_Button.Visible := Trim( hint_ ) <> '';
  Hint_Button.Hint := hint_;

  Use_RadioGroupClick( Sender );


  Common.Font__Set( Description_Memo.Font, Common.sql_editor__font );


  if Description_Edit.Enabled then
    Description_Edit.SetFocus()
  else
    if Description_Memo.Enabled then
      Description_Memo.SetFocus();

end;

procedure TText__Edit_Memo_Form.Ok_ButtonClick( Sender: TObject );
begin

  if Use_RadioGroup.ItemIndex = 0 then // Edit.
    text_value := Description_Edit.Text
  else
    text_value := Description_Memo.Lines.Text;


  if quotation_mark_duplicate then
    text_value := Common.Sql_Special_Characters_Protect( text_value );


  ModalResult := mrOk;

end;

procedure TText__Edit_Memo_Form.Hint_ButtonClick( Sender: TObject );
begin

  ShowMessage( hint_ );

end;

procedure TText__Edit_Memo_Form.Use_RadioGroupClick( Sender: TObject );
begin

  Description_Edit.Enabled := Use_RadioGroup.ItemIndex = 0; // Edit.

  Description_Memo.Enabled := not Description_Edit.Enabled;

end;

procedure TText__Edit_Memo_Form.Description_EditKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl ] ) then
    Ok_ButtonClick( Sender );

end;

procedure TText__Edit_Memo_Form.Description_MemoKeyDown( Sender: TObject; var Key: Word; Shift: TShiftState );
begin

  if    ( Key = VK_RETURN )
    and ( Shift = [ ssCtrl ] ) then
    Ok_ButtonClick( Sender )
  else
  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Description_Memo.SelectAll();

end;

end.
