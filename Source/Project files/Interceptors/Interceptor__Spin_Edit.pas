unit Interceptor__Spin_Edit;{21.Lut.2024}

  // After setting the value in the object inspector the value may be outside the min-max range.

interface

uses
  System.Classes,
  System.Math,
  System.SysUtils,
  Vcl.Clipbrd,
  Vcl.Controls,
  Vcl.Samples.Spin,
  Vcl.StdCtrls,
  Winapi.Messages,
  Winapi.Windows;

type
  TSpinEdit = class( Vcl.Samples.Spin.TSpinEdit )
  private
    FIncrement : currency;
    FMinValue : currency;
    FMaxValue : currency;

    function CheckValue( NewValue : currency ) : currency;
    procedure CMExit( var Message : Vcl.Controls.TCMExit ); message Vcl.Controls.CM_EXIT;
    function GetValue() : currency;
    procedure SetValue( NewValue : currency );

    function Increment_Value_Calculate() : currency;
  protected
    procedure DownClick( Sender : TObject ); override;
    function IsValidChar( Key : Char ) : Boolean; virtual;
    procedure KeyDown( var Key : Word; Shift : System.Classes.TShiftState ); override;
    procedure KeyPress( var Key : Char ); override;
    procedure UpClick( Sender : TObject ); override;
  public
    check_value__max,
    check_value__min,
    value_type_float
      : boolean;

    constructor Create( AOwner: System.Classes.TComponent ); override;
  published
    property Increment : currency read FIncrement write FIncrement;
    property MaxValue : currency read FMaxValue write FMaxValue;
    property MinValue : currency read FMinValue write FMinValue;
    property Value : currency read GetValue write SetValue;
  end;

  TCustomEdit_Helper = class helper for Vcl.StdCtrls.TCustomEdit
    procedure KeyDown( var Key : Word; Shift : TShiftState );
    procedure KeyPress( var Key : Char );
  end;

implementation

uses
  Common;

constructor TSpinEdit.Create( AOwner: System.Classes.TComponent );
begin

  inherited Create( AOwner );


  Self.check_value__max := false;
  Self.check_value__min := false;
  Self.Increment := 1;
  Self.value_type_float := false;

end;

function TSpinEdit.CheckValue( NewValue : currency ) : currency;
begin

  Result := NewValue;

  if   ( Self.check_value__min )
   and ( NewValue < Self.MinValue ) then
   Result := Self.MinValue;

  if   ( Self.check_value__max )
   and ( NewValue > Self.MaxValue  ) then
   Result := Self.MaxValue;

end;

procedure TSpinEdit.CMExit( var Message : TCMExit );
var
  ztr : currency;
begin

  ztr := Self.Value;

  inherited; // To call TCustomEdit.CMExit().

  Self.SetValue( ztr ); // To keep text formatting.

end;

procedure TSpinEdit.DownClick( Sender : TObject );
var
  zti_1 : integer;

  ztr : currency;
begin

  if Self.ReadOnly then
    Winapi.Windows.MessageBeep( 0 )
  else
    begin

      zti_1 := Self.SelStart;

      ztr := Self.Value;

      Self.Value := Self.Value - Increment_Value_Calculate();

      if    ( ztr >= 0 )
        and ( Self.Value < 0 ) then
        Self.SelStart := zti_1 + 1
      else
        Self.SelStart := zti_1;

    end;

end;

function TSpinEdit.GetValue() : currency;
var
  zts : string;
begin

  zts := Self.Text;
  zts := System.SysUtils.StringReplace( zts, ' ', '', [ rfReplaceAll ] );

  Result := System.SysUtils.StrToFloatDef( zts, Self.FMinValue );

end;

function TSpinEdit.Increment_Value_Calculate() : currency;
var
  zti_1,
  zti_2,
  spaces_count
    : integer;
begin

  if Self.FIncrement <> 1 then
    begin

      Result := Self.FIncrement;

      Exit;

    end;


  zti_1 := System.Math.Max(  Pos( ',', Self.Text ), Pos( '.', Self.Text )  );

  if    ( zti_1 > 0 )
    and ( Self.SelStart >= zti_1 ) then
    begin

      zti_2 := Self.SelStart - zti_1 + 1;

      Result := System.Math.Power( 10, -zti_2 );

    end
  else
    begin

      spaces_count := 0;

      for zti_2 := Self.SelStart + 1 to Length( Self.Text ) - 1 do
        if    ( Self.Text[ zti_2 ] = ' ' )
          and (
                   (
                         ( zti_2 > 1 )
                     and ( Self.Text[ zti_2 - 1 ] <> ' ' )
                   )
                or ( zti_2 = 1 )
              ) then
          inc( spaces_count );


      zti_1 := zti_1 - spaces_count;


      zti_2 := Self.SelStart;

      if    ( Self.Value < 0 )
        and ( zti_2 = 0 )
        and (  Length( Self.Text ) > 1 ) then
        zti_2 := 1;


      if Self.value_type_float then
        begin

          if Self.Value < 0 then
            begin

              dec( zti_1 );
              dec( zti_2 );

            end;

          if zti_2 < zti_1 then
            begin

              if zti_2 = zti_1 - 1 then
                zti_2 := 0
              else
                zti_2 := zti_1 - zti_2 - 2;

            end;

        end
      else
        begin

          zti_2 := Length( Self.Text ) - zti_2 - 1 - spaces_count;

          if zti_2 < 0 then
            zti_2 := 0;

        end;


      Result := Self.FIncrement * System.Math.Power( 10, zti_2 );

    end;

end;

function TSpinEdit.IsValidChar( Key : Char ) : Boolean;
begin

  Result := inherited;

  if    ( Result )
    and (
             ( Key = #10 )
          or ( Key = #13 )
          or (
                   ( not Self.value_type_float )
               and (
                        ( Key = ',' )
                     or ( Key = '.' )
                   )
             )
         ) then
    Result := false;

end;

procedure TSpinEdit.KeyDown( var Key : Word; Shift : TShiftState );
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl ] ) then
    Self.SelectAll()
  else
  if Key = VK_UP then
    Self.UpClick( Self )
  else
    if Key = VK_DOWN then
      Self.DownClick( Self );


  Vcl.StdCtrls.TCustomEdit(Self).KeyDown( Key, Shift ); // To call TCustomEdit.KeyDown().

end;

procedure TSpinEdit.KeyPress( var Key : Char );
begin

  if not Self.IsValidChar( Key ) then
    begin

      Key := #0;
      MessageBeep( 0 );

    end;

  if Key <> #0 then
    Vcl.StdCtrls.TCustomEdit(Self).KeyPress( Key );

end;

procedure TSpinEdit.SetValue( NewValue : currency );
var
  ztr : currency;
begin

  ztr := Self.CheckValue( NewValue );


  if Self.value_type_float then
    Self.Text := System.SysUtils.Trim(   System.SysUtils.FormatFloat(  '### ### ### ### ### ### ##0.0#############', Abs( ztr )  )   )
  else
    Self.Text := System.SysUtils.Trim(   System.SysUtils.FormatFloat(  '### ### ### ### ### ### ##0', Abs( ztr )  )   );


  if ztr < 0 then
    Self.Text := Common.minus_sign_s_c + Self.Text;

end;

procedure TSpinEdit.UpClick( Sender : TObject );
var
  zti_1 : integer;

  ztr : currency;
begin

  if Self.ReadOnly then
    Winapi.Windows.MessageBeep( 0 )
  else
    begin

      zti_1 := Self.SelStart;

      ztr := Self.Value;

      Self.Value := Self.Value + Increment_Value_Calculate();

      if    ( ztr < 0 )
        and ( Self.Value >= 0 ) then
        Self.SelStart := zti_1 - 1
      else
        Self.SelStart := zti_1;

    end;

end;

procedure TCustomEdit_Helper.KeyDown( var Key : Word; Shift : TShiftState );
begin

  inherited KeyDown( Key, Shift ); // Call TCustomEdit.KeyDown().

end;

procedure TCustomEdit_Helper.KeyPress( var Key : Char );
begin

  inherited KeyPress( Key );

end;

end.
