unit Interceptor__Spin_Edit;{21.Lut.2024}

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
    FCheck_Value__Max,
    FCheck_Value__Min,
    FValue_Type_Float
      : boolean;

    FDecimal : integer; // Number of digits after the decimal point.

    FIncrement,
    FMaxValue,
    FMinValue
      : currency;

    function CheckValue( NewValue : currency ) : currency;

    procedure Check_Value__Max__Set( const check_value__max_f : boolean );
    procedure Check_Value__Min__Set( const check_value__min_f : boolean );

    procedure CMExit( var Message : Vcl.Controls.TCMExit ); message Vcl.Controls.CM_EXIT;
    function GetValue() : currency; overload;
    function GetValue( const value__default_f : currency ) : currency; overload;

    procedure Decimal__Set( const decimal_f : integer );

    function Increment_Value_Calculate() : currency;

    procedure Max__Value__Set( const new_value__max_f : currency );
    procedure Min__Value__Set( const new_value__min_f : currency );

    procedure Sel__Start__Set( increment_value_f : currency );

    procedure SetValue( NewValue : currency );

    procedure Value_Type_Float__Set( const value_type_float_f : boolean );
  protected
    procedure DownClick( Sender : TObject ); override;
    function IsValidChar( Key : Char ) : Boolean; virtual;
    procedure KeyDown( var Key : Word; Shift : System.Classes.TShiftState ); override;
    procedure KeyPress( var Key : Char ); override;
    procedure UpClick( Sender : TObject ); override;
  public
    increment__smart : boolean;

    constructor Create( AOwner: System.Classes.TComponent ); override;
  published
    property Check_Value__Max : boolean read FCheck_Value__Max write Check_Value__Max__Set;
    property Check_Value__Min : boolean read FCheck_Value__Min write Check_Value__Min__Set;

    property Decimal : integer read FDecimal write Decimal__Set;

    property Increment : currency read FIncrement write FIncrement;

    property MaxValue : currency read FMaxValue write Max__Value__Set;
    property MinValue : currency read FMinValue write Min__Value__Set;

    property Value : currency read GetValue write SetValue;
    property Value_Type_Float : boolean read FValue_Type_Float write Value_Type_Float__Set;
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


  Self.FCheck_Value__Max := false;
  Self.FCheck_Value__Min := false;
  Self.FDecimal := 0; // No limits for Table__Data_Filter.
  Self.FIncrement := 1;
  Self.FMinValue := 0;
  Self.FMaxValue := 0;
  Self.FValue_Type_Float := false;
  Self.increment__smart := true;

  Self.SetValue( Self.GetValue() );  // To set display format.

end;

function TSpinEdit.CheckValue( NewValue : currency ) : currency;
begin

  Result := NewValue;


  if    ( Self.FValue_Type_Float )
    and ( Self.FDecimal >= 0 ) then
    Result := System.Math.RoundTo( Result, -Self.FDecimal );


  if   ( Self.FCheck_Value__Min )
   and ( NewValue < Self.MinValue ) then
   Result := Self.MinValue;

  if   ( Self.FCheck_Value__Max )
   and ( NewValue > Self.MaxValue  ) then
   Result := Self.MaxValue;

end;

procedure TSpinEdit.Check_Value__Max__Set( const check_value__max_f : boolean );
begin

  Self.FCheck_Value__Max := check_value__max_f;

  Self.SetValue( Self.GetValue() );

end;

procedure TSpinEdit.Check_Value__Min__Set( const check_value__min_f : boolean );
begin

  Self.FCheck_Value__Min := check_value__min_f;

  Self.SetValue( Self.GetValue() );

end;

procedure TSpinEdit.CMExit( var Message : TCMExit );
var
  ztr : currency;
begin

  ztr := Self.Value;

  inherited; // To call TCustomEdit.CMExit().

  Self.SetValue( ztr ); // To keep text formatting.

end;

procedure TSpinEdit.Decimal__Set( const decimal_f : integer );
begin

  Self.FDecimal := decimal_f;

  Self.SetValue( Self.GetValue() ); // To correct number of digits after the decimal point.

end;

procedure TSpinEdit.DownClick( Sender : TObject );
var
  zti_1 : integer;

  ztc_1,
  ztc_2
    : currency;
begin

  if Self.ReadOnly then
    Winapi.Windows.MessageBeep( 0 )
  else
    begin

      zti_1 := Self.SelStart;

      ztc_1 := Self.Value;

      ztc_2 := Increment_Value_Calculate();
      Self.Value := Self.Value - ztc_2;


      if Self.increment__smart then
        if Abs( ztc_2 ) >= 1 then
          Sel__Start__Set( ztc_2 )
        else
          if    ( ztc_1 >= 0 )
            and ( Self.Value < 0 ) then
            Self.SelStart := zti_1 + 1
          else
            Self.SelStart := zti_1;

    end;

end;

function TSpinEdit.GetValue() : currency;
begin

  Result := Self.GetValue( Self.FMinValue );

end;

function TSpinEdit.GetValue( const value__default_f : currency ) : currency;
var
  zts : string;
begin

  zts := Self.Text;
  zts := System.SysUtils.StringReplace( zts, ' ', '', [ rfReplaceAll ] );

  Result := System.SysUtils.StrToFloatDef( zts, value__default_f );

end;

function TSpinEdit.Increment_Value_Calculate() : currency;
var
  zti_1,
  zti_2,
  spaces_count
    : integer;
begin

  if not Self.increment__smart then
    begin

      Result := Self.FIncrement;

      Exit;

    end;


  zti_1 := System.Math.Max(  Pos( ',', Self.Text ), Pos( '.', Self.Text )  );
  zti_1 := System.Math.Max(  zti_1, Pos( FormatSettings.DecimalSeparator, Self.Text )  );

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


      if Self.FValue_Type_Float then
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


      Result := System.Math.Power( 10, zti_2 );

    end;

end;

function TSpinEdit.IsValidChar( Key : Char ) : Boolean;

  function Decimal_Length_Check() : boolean;
  var
    zti : integer;

    zts : string;
  begin

    Result := true;


    if Self.FDecimal < 0 then
      Exit;


    zti := System.Math.Max(  Pos( ',', Self.Text ), Pos( '.', Self.Text )  );
    zti := System.Math.Max(  zti, Pos( FormatSettings.DecimalSeparator, Self.Text )  );


    if    ( zti <= 0 )
      and (  Length( Self.Text ) > 0  )
      and (
               ( Key = ',' )
            or ( Key = '.' )
            or ( Key = FormatSettings.DecimalSeparator )
          ) then
      begin

         // No decimal separator and the char is decimal separator.

        zts := Copy(  Self.Text, Self.SelStart + 1, Length( Self.Text )  );

        if Length( zts ) > Self.FDecimal then
          begin

            Result := false;

            Exit;

          end;

      end;


    if   ( zti <= 0 ) // No decimal separator.
      or ( Self.SelStart < zti ) then // Char before the decimal separator.
      Exit;


    zts := Copy(  Self.Text, zti + 1, Length( Self.Text )  );

    if    ( Length( zts ) >= Self.FDecimal  )
      and (  Key in [ '0'..'9' ] ) then
      Result := false;

  end;

begin

  Result := inherited;


  if    ( Result )
    and (
             ( Key = #10 )
          or ( Key = #13 )
          or (
                   ( not Self.FValue_Type_Float )
               and (
                        ( Key = ',' )
                     or ( Key = '.' )
                     or ( Key = FormatSettings.DecimalSeparator )
                   )
             )
          or (
                   ( Self.FValue_Type_Float )
               and (
                        (
                              ( Key = ',' )
                          and (  Pos( ',', Self.Text ) > 0  )
                        )
                     or (
                              ( Key = '.' )
                          and (  Pos( '.', Self.Text ) > 0  )
                        )
                     or (
                              ( Key = FormatSettings.DecimalSeparator )
                          and (  Pos( FormatSettings.DecimalSeparator, Self.Text ) > 0  )
                        )
                     or ( not Decimal_Length_Check() )
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
var
  zti : integer;
  ztc : currency;
  zts : string;
begin

  if not Self.IsValidChar( Key ) then
    begin

      Key := #0;
      MessageBeep( 0 );

    end;


  //if Key = ^V then // Ctrl + V.
  //  begin
  //
  //    // Check paste values. //????
  //
  //    Key := #0;
  //
  //    ztc := Self.GetValue();
  //    zti := Self.SelStart;
  //
  //    if Length( Self.SelText ) > 0 then
  //      begin
  //
  //        Self.SelText := Vcl.Clipbrd.Clipboard.AsText;
  //        zts := Self.Text;
  //
  //      end
  //    else
  //      begin
  //
  //        zts := Self.Text;
  //        Insert( Vcl.Clipbrd.Clipboard.AsText, zts, Self.SelStart + 1 );
  //
  //      end;
  //
  //    zts := Trim(  StringReplace( zts, ' ', '', [ rfReplaceAll ] )  );
  //    Self.Text := zts;
  //    Self.SetValue(  Self.GetValue( ztc )  );
  //
  //    Self.SelStart := zti;
  //
  //  end;


  if Key <> #0 then
    Vcl.StdCtrls.TCustomEdit(Self).KeyPress( Key );

end;

procedure TSpinEdit.Max__Value__Set( const new_value__max_f : currency );
begin

  Self.FMaxValue := new_value__max_f;

  Self.SetValue( Self.GetValue() );

end;

procedure TSpinEdit.Min__Value__Set( const new_value__min_f : currency );
begin

  Self.FMinValue := new_value__min_f;

  Self.SetValue( Self.GetValue() );

end;

procedure TSpinEdit.Sel__Start__Set( increment_value_f : currency );
var
  zti : integer;

  ztc : currency;

  zts : string;
begin

  if    ( Self.increment__smart )
    and ( increment_value_f >= 1 ) then
    begin

      zts := System.SysUtils.Trim(  System.SysUtils.FormatFloat( '### ### ### ### ### ### ##0', increment_value_f )  );
      zti := Length( zts );

      if zti <= Length( Self.Text ) then
        Self.SelStart := Length( Self.Text ) - zti
      else
        Self.SelStart := 0;


      if    ( Self.SelStart = 0 )
        and ( Self.Value < 0 ) then
        Self.SelStart := Self.SelStart + 1;


      if Self.SelStart > 0 then
        begin

          zti := System.Math.Max(  Pos( ',', Self.Text ), Pos( '.', Self.Text )  );
          zti := System.Math.Max(  zti, Pos( FormatSettings.DecimalSeparator, Self.Text )  );

          if zti > 0 then
            begin

              zti := Length( Self.Text ) - zti + 1;

              if zti <= Self.SelStart then
                Self.SelStart := Self.SelStart - zti
              else
                Self.SelStart := 0;


              if    ( Self.SelStart = 0 )
                and ( Self.Value < 0 ) then
                Self.SelStart := Self.SelStart + 1;

            end;

        end;

    end;

end;

procedure TSpinEdit.SetValue( NewValue : currency );
var
  ztc : currency;
begin

  ztc := Self.CheckValue( NewValue );


  if Self.FValue_Type_Float then
    Self.Text := System.SysUtils.Trim(   System.SysUtils.FormatFloat(  '### ### ### ### ### ### ##0.0#############', Abs( ztc )  )   )
  else
    Self.Text := System.SysUtils.Trim(   System.SysUtils.FormatFloat(  '### ### ### ### ### ### ##0', Abs( ztc )  )   );


  if ztc < 0 then
    Self.Text := Common.minus_sign_s_c + Self.Text;

end;

procedure TSpinEdit.UpClick( Sender : TObject );
var
  zti_1 : integer;

  ztc_1,
  ztc_2
    : currency;
begin

  if Self.ReadOnly then
    Winapi.Windows.MessageBeep( 0 )
  else
    begin

      zti_1 := Self.SelStart;

      ztc_1 := Self.Value;

      ztc_2 := Increment_Value_Calculate();
      Self.Value := Self.Value + ztc_2;


      if Self.increment__smart then
        if Abs( ztc_2 ) >= 1 then
          Sel__Start__Set( ztc_2 )
        else
          if    ( ztc_1 < 0 )
            and ( Self.Value >= 0 ) then
            Self.SelStart := zti_1 - 1
          else
            Self.SelStart := zti_1;

    end;

end;

procedure TSpinEdit.Value_Type_Float__Set( const value_type_float_f : boolean );
begin

  Self.FValue_Type_Float := value_type_float_f;

  Self.SetValue( Self.GetValue() );  // To set display format.

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
