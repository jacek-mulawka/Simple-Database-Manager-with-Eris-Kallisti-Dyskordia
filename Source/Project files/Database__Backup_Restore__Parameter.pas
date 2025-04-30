unit Database__Backup_Restore__Parameter;{09.Paü.2023}

interface

uses
  System.SysUtils,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls;

type
  TDatabase__Backup_Restore__Parameter = class( Vcl.ExtCtrls.TPanel )
  private
    { Private declarations }
    align_correct_button : Vcl.StdCtrls.TButton;

    parameter_description : Vcl.StdCtrls.TLabel;

    parameter_code : Vcl.StdCtrls.TCheckBox;

    parameter_values : Vcl.StdCtrls.TComboBox;

    parameter_values__vertical_splitter : Vcl.ExtCtrls.TSplitter;

    procedure align_correct_buttonClick( Sender : TObject );
  public
    { Public declarations }
    constructor Create( parent_f : Vcl.Controls.TWinControl; const checked_f : boolean; const parameter__name_f, parameter__description_f, parameter__hint_f, parameter__values_f : string; const splitter_show_f : boolean );
    destructor Destroy(); override;

    procedure Align_Correct__DBRP();
    function Parameter_Get__DBRP() : string;
  end;

implementation

uses
  Common,
  Translation;

constructor TDatabase__Backup_Restore__Parameter.Create( parent_f : Vcl.Controls.TWinControl; const checked_f : boolean; const parameter__name_f, parameter__description_f, parameter__hint_f, parameter__values_f : string; const splitter_show_f : boolean );
const
  margin_c : integer = 5;
begin

  inherited Create( Vcl.Forms.Application );


  Self.parameter_code := nil;
  Self.parameter_description := nil;
  Self.parameter_values := nil;
  Self.parameter_values__vertical_splitter := nil;


  Self.Parent := parent_f;
  Self.Align := alBottom;
  Self.Align := alTop;
  Self.Height := margin_c * 5;
  Self.ParentBackground := false;


  Self.parameter_code := Vcl.StdCtrls.TCheckBox.Create( Vcl.Forms.Application );
  Self.parameter_code.Parent := Self;
  Self.parameter_code.AlignWithMargins := true;
  Self.parameter_code.Align := alLeft;
  Self.parameter_code.Caption := parameter__name_f;
  Self.parameter_code.Checked := checked_f;

  if Trim( parameter__hint_f ) <> '' then
    begin

      Self.parameter_code.Hint := parameter__hint_f;
      Self.parameter_code.ShowHint := true;

    end;

  Self.parameter_code.Margins.Bottom := 0;
  Self.parameter_code.Margins.Left := margin_c * 2;
  Self.parameter_code.Margins.Right := margin_c * 2;
  Self.parameter_code.Margins.Top := 0;

  if Self.parameter_code.Width < 200 then
    Self.parameter_code.Width := 200;


  if Trim( parameter__values_f ) <> '' then
    begin

      Self.parameter_values := Vcl.StdCtrls.TComboBox.Create( Vcl.Forms.Application );
      Self.parameter_values.Parent := Self;
      Self.parameter_values.AlignWithMargins := true;
      Self.parameter_values.Align := alRight;
      Self.parameter_values.Align := alLeft; // Do not work well.
      Self.parameter_values.DropDownCount := 40;
      Self.parameter_values.Hint := Translation.translation__table__data_filter_r.parameter_value;
      Self.parameter_values.Margins.Bottom := margin_c;
      Self.parameter_values.Margins.Left := margin_c * 2;
      Self.parameter_values.Margins.Right := margin_c * 2;
      Self.parameter_values.Margins.Top := 0;
      Self.parameter_values.ShowHint := true;
      Self.parameter_values.Width := 100;
      Common.Items_From_Text_Add(  Self.parameter_values.Items, StringReplace( parameter__values_f, Common.database__backup_restore__parameters__separator_c, #13 + #10, [ rfReplaceAll ] )  );

      if Self.parameter_values.Items.Count > 0 then
        Self.parameter_values.ItemIndex := 0;

      if splitter_show_f then
        begin

          Self.parameter_values__vertical_splitter := Vcl.ExtCtrls.TSplitter.Create( Vcl.Forms.Application );
          Self.parameter_values__vertical_splitter.Parent := Self;
          Self.parameter_values__vertical_splitter.Align := alRight;
          Self.parameter_values__vertical_splitter.Align := alLeft; // Do not work well.
          Self.parameter_values__vertical_splitter.AutoSnap := false;
          Self.parameter_values__vertical_splitter.Color := Vcl.Graphics.clSkyBlue;
          Self.parameter_values__vertical_splitter.MinSize := 1;
          Self.parameter_values__vertical_splitter.Width := 6;

        end;

    end;


  Self.parameter_description := Vcl.StdCtrls.TLabel.Create( Vcl.Forms.Application );
  Self.parameter_description.Parent := Self;
  Self.parameter_description.AlignWithMargins := true;
  Self.parameter_description.Align := alRight;
  Self.parameter_description.Align := alLeft; // Do not work well.
  Self.parameter_description.AutoSize := true;
  Self.parameter_description.Caption := parameter__description_f;

  if Trim( parameter__hint_f ) <> '' then
    Self.parameter_description.Hint := parameter__hint_f
  else
    Self.parameter_description.Hint := Self.parameter_description.Caption;

  Self.parameter_description.Margins.Bottom := margin_c;
  Self.parameter_description.Margins.Left := margin_c * 2;
  Self.parameter_description.Margins.Right := margin_c * 2;
  Self.parameter_description.Margins.Top := margin_c;
  Self.parameter_description.ShowHint := true;


  Self.align_correct_button := Vcl.StdCtrls.TButton.Create( Application );
  Self.align_correct_button.Parent := Self;
  Self.align_correct_button.Align := alRight;
  Self.align_correct_button.AlignWithMargins := true;
  Self.align_correct_button.Caption := Translation.translation__table__data_filter_r.correct_align;
  Self.align_correct_button.Height := 20;
  Self.align_correct_button.Hint := Translation.translation__table__data_filter_r.correct_align__hint;
  Self.align_correct_button.Margins.Bottom := margin_c;
  Self.align_correct_button.Margins.Left := margin_c * 2;
  Self.align_correct_button.Margins.Right := margin_c * 2;
  Self.align_correct_button.Margins.Top := margin_c;
  Self.align_correct_button.ShowHint := true;
  Self.align_correct_button.Visible := false;
  Self.align_correct_button.Width := Self.align_correct_button.Height;
  Self.align_correct_button.OnClick := align_correct_buttonClick;

end;

destructor TDatabase__Backup_Restore__Parameter.Destroy();
begin

  System.SysUtils.FreeAndNil( Self.parameter_code );

  if Self.parameter_values <> nil then
    System.SysUtils.FreeAndNil( Self.parameter_values );

  if Self.parameter_values__vertical_splitter <> nil then
    System.SysUtils.FreeAndNil( Self.parameter_values__vertical_splitter );

  System.SysUtils.FreeAndNil( Self.parameter_description );


  FreeAndNil( Self.align_correct_button );


  inherited;

end;

procedure TDatabase__Backup_Restore__Parameter.align_correct_buttonClick( Sender : TObject );
begin

  Self.Align_Correct__DBRP();

end;

procedure TDatabase__Backup_Restore__Parameter.Align_Correct__DBRP();
begin

  if Self.parameter_description <> nil then
    Self.parameter_description.Align := alRight;

  if Self.parameter_values__vertical_splitter <> nil then
    Self.parameter_values__vertical_splitter.Align := alRight;

  if Self.parameter_values <> nil then
    Self.parameter_values.Align := alRight;



  if Self.parameter_values <> nil then
    Self.parameter_values.Align := alLeft;

  if Self.parameter_values__vertical_splitter <> nil then
    Self.parameter_values__vertical_splitter.Align := alLeft;

  if Self.parameter_description <> nil then
    Self.parameter_description.Align := alLeft;

end;

function TDatabase__Backup_Restore__Parameter.Parameter_Get__DBRP() : string;
begin

  Result := '';

  if Self.parameter_code.Checked then
    begin

      Result := Result + ' ' + Self.parameter_code.Caption;

      if    ( Self.parameter_values <> nil )
        and (  Trim( Self.parameter_values.Text ) <> ''  ) then
        Result := Result + ' ' + Self.parameter_values.Text;

    end;

end;

end.
