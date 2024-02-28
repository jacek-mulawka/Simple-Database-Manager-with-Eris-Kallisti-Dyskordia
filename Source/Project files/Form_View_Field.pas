unit Form_View_Field;{05.Lip.2023}

{$I Definitions.inc}

interface

uses
  Data.DB,
  System.Classes,
  System.SysUtils,
  Vcl.Clipbrd,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.DBCtrls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.StdCtrls,
  Winapi.Windows

 {$IFDEF JVCL__use}
  ,
  //JvDBControls,
  JvDBDateTimePicker,
  JvDBSpinEdit,
  JvSpin
  {$ENDIF}
  ;

type
  TKeyDown_wsk = procedure( Sender : TObject; var Key : Word; Shift : TShiftState ) of object;
  TKey_Up_wsk = procedure( Sender : TObject; var Key : Word; Shift : TShiftState ) of object;

  TForm_View_Field = class( Vcl.ExtCtrls.TPanel )
  private
    { Private declarations }
    field_name_selected_wsk_g : ^string;

    key_down_wsk_g : TKeyDown_wsk;

    field_dedicated__data_type : Data.DB.TFieldType;

    field_name_etiquette_label : Vcl.StdCtrls.TLabel;

    field_value__dedicated : Vcl.Controls.TWinControl;

    field_value__universal_db_edit : Vcl.DBCtrls.TDBEdit;

    field_name_etiquette__vertical_splitter,
    //field_value__dedicated__horizontal_splitter,
    field_value__dedicated__vertical_splitter,
    field_value__universal__vertical_splitter
      : Vcl.ExtCtrls.TSplitter;

    procedure field_name_etiquette_labelDblClick( Sender : TObject );
    procedure field_Enter( Sender : TObject );
    procedure field_KeyDown( Sender : TObject; var Key : Word; Shift : TShiftState );
  public
    { Public declarations }
    constructor Create( parent_f : Vcl.Controls.TWinControl; data_source_f : TDataSource; field_f : TField; const additional_component_show_f, editing_f, splitter_show_f : boolean; field_name_selected_pointer_f : Pointer; key_down_wsk_f : TKeyDown_wsk; key_up_wsk_f : TKey_Up_wsk );
    destructor Destroy(); override;

    procedure Align_Correct__FVF();
    procedure Editing__Set__FVF( const editing_f : boolean );
  end;

const
  margin_c : integer = 5;

implementation

uses
  Common,
  Translation;

constructor TForm_View_Field.Create( parent_f : Vcl.Controls.TWinControl; data_source_f : TDataSource; field_f : TField; const additional_component_show_f, editing_f, splitter_show_f : boolean; field_name_selected_pointer_f : Pointer; key_down_wsk_f : TKeyDown_wsk; key_up_wsk_f : TKey_Up_wsk );
begin

  inherited Create( Vcl.Forms.Application );

  Self.field_dedicated__data_type := ftUnknown;
  Self.field_name_etiquette_label := nil;
  Self.field_name_etiquette__vertical_splitter := nil;
  Self.field_name_selected_wsk_g := field_name_selected_pointer_f;
  Self.field_value__dedicated := nil;
  //Self.field_value__dedicated__horizontal_splitter := nil;
  Self.field_value__dedicated__vertical_splitter := nil;
  Self.field_value__universal_db_edit := nil;
  Self.field_value__universal__vertical_splitter := nil;
  Self.key_down_wsk_g := key_down_wsk_f;


  Self.Parent := parent_f;
  Self.Align := alBottom;
  Self.Align := alTop;
  Self.Height := margin_c * 7;


  Self.field_name_etiquette_label := Vcl.StdCtrls.TLabel.Create( Vcl.Forms.Application );
  Self.field_name_etiquette_label.Parent := Self;
  Self.field_name_etiquette_label.AlignWithMargins := true;
  Self.field_name_etiquette_label.Align := alLeft;
  Self.field_name_etiquette_label.Caption := field_f.FieldName;
  Self.field_name_etiquette_label.AutoSize := false; // After 'Caption := '.
  Self.field_name_etiquette_label.Hint :=
    Self.field_name_etiquette_label.Caption + #13 + #13 +
    Translation.translation__table__data_filter_r.field_name_etiquette_label__hint;
  Self.field_name_etiquette_label.Layout := tlCenter;
  Self.field_name_etiquette_label.Margins.Bottom := 0;
  Self.field_name_etiquette_label.Margins.Left := margin_c * 2;
  Self.field_name_etiquette_label.Margins.Right := margin_c * 2;
  Self.field_name_etiquette_label.Margins.Top := 0;
  Self.field_name_etiquette_label.ShowHint := true;

  if Self.field_name_etiquette_label.Width < 350 then
    Self.field_name_etiquette_label.Width := 350;

  Self.field_name_etiquette_label.OnDblClick := field_name_etiquette_labelDblClick;

  if splitter_show_f then
    begin

      Self.field_name_etiquette__vertical_splitter := Vcl.ExtCtrls.TSplitter.Create( Vcl.Forms.Application );
      Self.field_name_etiquette__vertical_splitter.Parent := Self;
      Self.field_name_etiquette__vertical_splitter.Align := alRight;
      Self.field_name_etiquette__vertical_splitter.Align := alLeft; // Do not work well.
      Self.field_name_etiquette__vertical_splitter.AutoSnap := false;
      Self.field_name_etiquette__vertical_splitter.Color := Vcl.Graphics.clSkyBlue;
      Self.field_name_etiquette__vertical_splitter.MinSize := 1;
      Self.field_name_etiquette__vertical_splitter.Width := 6;

    end;


  Self.field_value__universal_db_edit := Vcl.DBCtrls.TDBEdit.Create( Vcl.Forms.Application );
  Self.field_value__universal_db_edit.Parent := Self;
  Self.field_value__universal_db_edit.AlignWithMargins := true;
  Self.field_value__universal_db_edit.Align := alRight;
  Self.field_value__universal_db_edit.Align := alLeft; // Do not work well.
  Self.field_value__universal_db_edit.Margins.Bottom := margin_c;
  Self.field_value__universal_db_edit.Margins.Left := margin_c * 2;
  Self.field_value__universal_db_edit.Margins.Right := margin_c * 2;
  Self.field_value__universal_db_edit.Margins.Top := margin_c;
  Self.field_value__universal_db_edit.Width := 200;
  Self.field_value__universal_db_edit.OnEnter := field_Enter;
  Self.field_value__universal_db_edit.OnKeyDown := field_KeyDown;
  Self.field_value__universal_db_edit.OnKeyUp := key_up_wsk_f;

  Self.field_value__universal_db_edit.DataSource := data_source_f; // At the end.
  Self.field_value__universal_db_edit.DataField := field_f.FieldName;


  if splitter_show_f then
    begin

      Self.field_value__universal__vertical_splitter := Vcl.ExtCtrls.TSplitter.Create( Vcl.Forms.Application );
      Self.field_value__universal__vertical_splitter.Parent := Self;
      Self.field_value__universal__vertical_splitter.Align := alRight;
      Self.field_value__universal__vertical_splitter.Align := alLeft; // Do not work well.
      Self.field_value__universal__vertical_splitter.AutoSnap := false;
      Self.field_value__universal__vertical_splitter.Color := Vcl.Graphics.clSkyBlue;
      Self.field_value__universal__vertical_splitter.MinSize := 1;
      Self.field_value__universal__vertical_splitter.Width := 6;

    end;


  if additional_component_show_f then
    if field_f.DataType in [ ftBlob, ftMemo, ftOraBlob ] then
      begin

        Self.field_dedicated__data_type := ftBlob;

        Self.field_value__dedicated := Vcl.DBCtrls.TDBMemo.Create( Vcl.Forms.Application );
        Self.field_value__dedicated.Parent := Self;
        Self.field_value__dedicated.AlignWithMargins := true;
        Self.field_value__dedicated.Align := alRight;
        Self.field_value__dedicated.Align := alLeft; // Do not work well.
        Self.field_value__dedicated.Margins.Bottom := margin_c;
        Self.field_value__dedicated.Margins.Left := margin_c * 2;
        Self.field_value__dedicated.Margins.Right := margin_c * 2;
        Self.field_value__dedicated.Margins.Top := margin_c;
        Self.field_value__dedicated.Width := 400;
        Vcl.DBCtrls.TDBMemo(Self.field_value__dedicated).ScrollBars := TScrollStyle.ssVertical;
        Vcl.DBCtrls.TDBMemo(Self.field_value__dedicated).OnEnter := field_Enter;
        Vcl.DBCtrls.TDBMemo(Self.field_value__dedicated).OnKeyDown := field_KeyDown;
        Vcl.DBCtrls.TDBMemo(Self.field_value__dedicated).OnKeyUp := key_up_wsk_f;

        Vcl.DBCtrls.TDBMemo(Self.field_value__dedicated).DataSource := data_source_f; // At the end.
        Vcl.DBCtrls.TDBMemo(Self.field_value__dedicated).DataField := field_f.FieldName;

        Common.Font__Set( Vcl.DBCtrls.TDBMemo(Self.field_value__dedicated).Font, Common.sql_editor__font );


        //if splitter_show_f then
        //  begin
        //
        //    Self.field_value__dedicated__horizontal_splitter := Vcl.ExtCtrls.TSplitter.Create( Vcl.Forms.Application );
        //    Self.field_value__dedicated__horizontal_splitter.Parent := parent_f;
        //    Self.field_value__dedicated__horizontal_splitter.Align := alBottom;
        //    Self.field_value__dedicated__horizontal_splitter.Align := alTop;
        //    Self.field_value__dedicated__horizontal_splitter.AutoSnap := false;
        //    Self.field_value__dedicated__horizontal_splitter.Height := 6;
        //    Self.field_value__dedicated__horizontal_splitter.MinSize := margin_c * 2 + Self.field_value__universal_db_edit.Height;
        //    Self.field_value__dedicated__horizontal_splitter.Color := Vcl.Graphics.clMoneyGreen;
        //
        //  end
        //else
        //  Self.Height := 400;

      end
    {$IFDEF JVCL__use}
    else
    //if field_f.DataType in [ ftDate, ftTime ] then
    //  begin
    //
    //    Self.field_dedicated__data_type := ftDate;
    //
    //    Self.field_value__dedicated := JvDBControls.TJvDBDateEdit.Create( Vcl.Forms.Application );
    //    Self.field_value__dedicated.Parent := Self;
    //    Self.field_value__dedicated.AlignWithMargins := true;
    //    Self.field_value__dedicated.Align := alRight;
    //    Self.field_value__dedicated.Align := alLeft; // Do not work well.
    //    Self.field_value__dedicated.Margins.Bottom := margin_c;
    //    Self.field_value__dedicated.Margins.Left := margin_c * 2;
    //    Self.field_value__dedicated.Margins.Right := margin_c * 2;
    //    Self.field_value__dedicated.Margins.Top := margin_c;
    //    JvDBControls.TJvDBDateEdit(Self.field_value__dedicated).OnEnter := field_Enter;
    //    JvDBControls.TJvDBDateEdit(Self.field_value__dedicated).OnKeyDown := field_KeyDown;
    //    JvDBControls.TJvDBDateEdit(Self.field_value__dedicated).OnKeyUp := key_up_wsk;
    //
    //    JvDBControls.TJvDBDateEdit(Self.field_value__dedicated).DataSource := data_source_f; // At the end.
    //    JvDBControls.TJvDBDateEdit(Self.field_value__dedicated).DataField := field_f.FieldName;
    //
    //  end
    //else
    //if field_f.DataType in [ ftDate, ftDateTime, ftTime, ftTimeStamp, ftOraTimeStamp ] then
    if field_f.DataType in [ ftDate, ftTime ] then
      begin

        Self.field_dedicated__data_type := ftDate;

        Self.field_value__dedicated := JvDBDateTimePicker.TJvDBDateTimePicker.Create( Vcl.Forms.Application );
        Self.field_value__dedicated.Parent := Self;
        //JvDBDateTimePicker.TJvDBDateTimePicker(Self.field_value__dedicated).ShowCheckbox := true;
        Self.field_value__dedicated.AlignWithMargins := true;
        Self.field_value__dedicated.Align := alRight;
        Self.field_value__dedicated.Align := alLeft; // Do not work well.
        Self.field_value__dedicated.Margins.Bottom := margin_c;
        Self.field_value__dedicated.Margins.Left := margin_c * 2;
        Self.field_value__dedicated.Margins.Right := margin_c * 2;
        Self.field_value__dedicated.Margins.Top := margin_c;

        if field_f.DataType in [ ftDate ] then
          JvDBDateTimePicker.TJvDBDateTimePicker(Self.field_value__dedicated).Kind := Vcl.ComCtrls.dtkDate
        else
        if field_f.DataType in [ ftTime ] then
          JvDBDateTimePicker.TJvDBDateTimePicker(Self.field_value__dedicated).Kind := Vcl.ComCtrls.dtkTime;
        //else
        //if field_f.DataType in [ ftDateTime, ftTimeStamp, ftOraTimeStamp ] then
        //  JvDBDateTimePicker.TJvDBDateTimePicker(Self.field_value__dedicated).Kind := Vcl.ComCtrls.dtkDateTime;

        JvDBDateTimePicker.TJvDBDateTimePicker(Self.field_value__dedicated).OnEnter := field_Enter;
        JvDBDateTimePicker.TJvDBDateTimePicker(Self.field_value__dedicated).OnKeyDown := field_KeyDown;
        JvDBDateTimePicker.TJvDBDateTimePicker(Self.field_value__dedicated).OnKeyUp := key_up_wsk_f;

        JvDBDateTimePicker.TJvDBDateTimePicker(Self.field_value__dedicated).DataSource := data_source_f; // At the end.
        JvDBDateTimePicker.TJvDBDateTimePicker(Self.field_value__dedicated).DataField := field_f.FieldName;

      end
    else
    if field_f.DataType in
         [
           ftAutoInc, ftByte, ftBytes, ftInteger, ftLargeint, ftLongWord, ftShortint, ftSmallint, ftWord,
           ftBCD, ftCurrency, ftExtended, ftFloat, ftFMTBcd, ftSingle, ftVarBytes
         ] then
      begin

        Self.field_dedicated__data_type := ftInteger;

        Self.field_value__dedicated := JvDBSpinEdit.TJvDBSpinEdit.Create( Vcl.Forms.Application );
        Self.field_value__dedicated.Parent := Self;
        JvDBSpinEdit.TJvDBSpinEdit(Self.field_value__dedicated).Thousands := true;

        if field_f.DataType in [ ftBCD, ftCurrency, ftExtended, ftFloat, ftFMTBcd, ftSingle, ftVarBytes ] then
          begin

            JvDBSpinEdit.TJvDBSpinEdit(Self.field_value__dedicated).ValueType := JvSpin.vtFloat;
            JvDBSpinEdit.TJvDBSpinEdit(Self.field_value__dedicated).Decimal := field_f.Size;

          end
        else
          JvDBSpinEdit.TJvDBSpinEdit(Self.field_value__dedicated).ValueType := JvSpin.vtInteger;

        Self.field_value__dedicated.AlignWithMargins := true;
        Self.field_value__dedicated.Align := alRight;
        Self.field_value__dedicated.Align := alLeft; // Do not work well.
        Self.field_value__dedicated.Margins.Bottom := margin_c;
        Self.field_value__dedicated.Margins.Left := margin_c * 2;
        Self.field_value__dedicated.Margins.Right := margin_c * 2;
        Self.field_value__dedicated.Margins.Top := margin_c;
        JvDBSpinEdit.TJvDBSpinEdit(Self.field_value__dedicated).OnEnter := field_Enter;
        JvDBSpinEdit.TJvDBSpinEdit(Self.field_value__dedicated).OnKeyDown := field_KeyDown;
        JvDBSpinEdit.TJvDBSpinEdit(Self.field_value__dedicated).OnKeyUp := key_up_wsk_f;

        JvDBSpinEdit.TJvDBSpinEdit(Self.field_value__dedicated).DataSource := data_source_f; // At the end.
        JvDBSpinEdit.TJvDBSpinEdit(Self.field_value__dedicated).DataField := field_f.FieldName;

      end;
    {$ELSE JVCL__use}
    ;
    {$ENDIF}
    //else
    //  begin
    //
    //    Self.field_dedicated__data_type := ftUnknown;
    //    Self.field_value__dedicated := nil;
    //
    //  end;


  if    ( splitter_show_f )
    and ( Self.field_value__dedicated <> nil ) then
    begin

      Self.field_value__dedicated__vertical_splitter := Vcl.ExtCtrls.TSplitter.Create( Vcl.Forms.Application );
      Self.field_value__dedicated__vertical_splitter.Parent := Self;
      Self.field_value__dedicated__vertical_splitter.Align := alRight;
      Self.field_value__dedicated__vertical_splitter.Align := alLeft; // Do not work well.
      Self.field_value__dedicated__vertical_splitter.AutoSnap := false;
      Self.field_value__dedicated__vertical_splitter.Color := Vcl.Graphics.clSkyBlue;
      Self.field_value__dedicated__vertical_splitter.MinSize := 1;
      Self.field_value__dedicated__vertical_splitter.Width := 6;

    end;


  Self.Editing__Set__FVF( editing_f );

end;

destructor TForm_View_Field.Destroy();
begin

  FreeAndNil( Self.field_name_etiquette_label );
  FreeAndNil( Self.field_name_etiquette__vertical_splitter );


  if Self.field_value__dedicated <> nil then
    if Self.field_dedicated__data_type = ftBlob then
      FreeAndNil( Vcl.DBCtrls.TDBMemo(Self.field_value__dedicated) )
    {$IFDEF JVCL__use}
    //else
    //if Self.field_dedicated__data_type = ftDate then
    //  FreeAndNil( JvDBControls.TJvDBDateEdit(Self.field_value__dedicated) );
    else
    if Self.field_dedicated__data_type = ftDate then
      FreeAndNil( JvDBDateTimePicker.TJvDBDateTimePicker(Self.field_value__dedicated) )
    else
    if Self.field_dedicated__data_type = ftInteger then
      FreeAndNil( JvDBSpinEdit.TJvDBSpinEdit(Self.field_value__dedicated) );
    {$ELSE JVCL__use}
    ;
    {$ENDIF}


  //if Self.field_value__dedicated__horizontal_splitter <> nil then
  //  FreeAndNil( Self.field_value__dedicated__horizontal_splitter ); // Do not free here.

  if Self.field_value__dedicated__vertical_splitter <> nil then
    FreeAndNil( Self.field_value__dedicated__vertical_splitter );

  FreeAndNil( Self.field_value__universal_db_edit );
  FreeAndNil( Self.field_value__universal__vertical_splitter );

  inherited;

end;

procedure TForm_View_Field.field_name_etiquette_labelDblClick( Sender : TObject );
begin

  Vcl.Clipbrd.Clipboard.AsText := Self.field_name_etiquette_label.Caption;

end;

procedure TForm_View_Field.field_Enter( Sender : TObject );
begin

  field_name_selected_wsk_g^ := Self.field_name_etiquette_label.Caption;

end;

procedure TForm_View_Field.field_KeyDown( Sender : TObject; var Key : Word; Shift : TShiftState );
var
  zti : integer;
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl, ssShift ] ) then
    Self.Align_Correct__FVF()
  else
  if    ( Sender <> nil )
    and ( TWinControl(Sender).Parent <> nil ) then
    begin

      if    ( Key = Winapi.Windows.VK_ADD )
        and ( Shift = [ ssCtrl ] ) then
        TWinControl(Sender).Parent.Height := TWinControl(Sender).Parent.Height * 2
      else
      if    ( Key = Winapi.Windows.VK_SUBTRACT )
        and ( Shift = [ ssCtrl ] ) then
        begin

          zti := Round( TWinControl(Sender).Parent.Height * 0.5 );

          if zti < margin_c * 7 then
            zti := margin_c * 7;

          TWinControl(Sender).Parent.Height := zti;

        end;

    end;


  if @Self.key_down_wsk_g <> nil then
    Self.key_down_wsk_g( Sender, Key, Shift );

end;

procedure TForm_View_Field.Align_Correct__FVF();
begin

  if Self.field_name_etiquette__vertical_splitter = nil then
    Exit;



  if Self.field_value__dedicated__vertical_splitter <> nil then
    Self.field_value__dedicated__vertical_splitter.Align := alRight;

  if Self.field_value__dedicated <> nil then
    Self.field_value__dedicated.Align := alRight;

  if Self.field_value__universal__vertical_splitter <> nil then
    Self.field_value__universal__vertical_splitter.Align := alRight;

  if Self.field_value__universal_db_edit <> nil then
    Self.field_value__universal_db_edit.Align := alRight;

  if Self.field_name_etiquette__vertical_splitter <> nil then
    Self.field_name_etiquette__vertical_splitter.Align := alRight;



  if Self.field_name_etiquette__vertical_splitter <> nil then
    Self.field_name_etiquette__vertical_splitter.Align := alLeft;

  if Self.field_value__universal_db_edit <> nil then
    Self.field_value__universal_db_edit.Align := alLeft;

  if Self.field_value__universal__vertical_splitter <> nil then
    Self.field_value__universal__vertical_splitter.Align := alLeft;

  if Self.field_value__dedicated <> nil then
    Self.field_value__dedicated.Align := alLeft;

  if Self.field_value__dedicated__vertical_splitter <> nil then
    Self.field_value__dedicated__vertical_splitter.Align := alLeft;

end;

procedure TForm_View_Field.Editing__Set__FVF( const editing_f : boolean );
begin

  if Self.field_value__universal_db_edit <> nil then
    Self.field_value__universal_db_edit.ReadOnly := not editing_f;


  if Self.field_value__dedicated <> nil then
    begin

      {$IFDEF JVCL__use}
      //if Self.field_value__dedicated is JvDBControls.TJvDBDateEdit then
      //  JvDBControls.TJvDBDateEdit(Self.field_value__dedicated).ReadOnly := not editing_f
      //else
      if Self.field_value__dedicated is JvDBDateTimePicker.TJvDBDateTimePicker then
        JvDBDateTimePicker.TJvDBDateTimePicker(Self.field_value__dedicated).ReadOnly := not editing_f
      else
      if Self.field_value__dedicated is JvDBSpinEdit.TJvDBSpinEdit then
        JvDBSpinEdit.TJvDBSpinEdit(Self.field_value__dedicated).ReadOnly := not editing_f
      else
     {$ENDIF}
      if Self.field_value__dedicated is Vcl.DBCtrls.TDBMemo then
        Vcl.DBCtrls.TDBMemo(Self.field_value__dedicated).ReadOnly := not editing_f;

    end;

end;

end.
