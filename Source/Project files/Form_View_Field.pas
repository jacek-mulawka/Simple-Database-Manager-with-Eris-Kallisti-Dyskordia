unit Form_View_Field;{05.Lip.2023}

interface

uses
  Data.DB,
  System.Classes,
  System.DateUtils,
  System.SysUtils,
  Vcl.Clipbrd,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.DBCtrls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.Samples.Spin,
  Vcl.StdCtrls,
  Winapi.Windows,

  Interceptor__Spin_Edit;

type
  TKeyDown_wsk = procedure( Sender : TObject; var Key : Word; Shift : TShiftState ) of object;
  TKey_Up_wsk = procedure( Sender : TObject; var Key : Word; Shift : TShiftState ) of object;

  TForm_View_Field = class( Vcl.ExtCtrls.TPanel )
  private
    { Private declarations }
    field_name_selected_wsk_g : ^string;

    key_down_wsk_g : TKeyDown_wsk;

    component__date_time__conventional__use__fvf,
    field_value__dedicated_db_edit__on_change__block,
    field_value__universal_db_edit__on_change__block
      : boolean;

    field_dedicated__data_type : Data.DB.TFieldType;

    field_name_etiquette_label : Vcl.StdCtrls.TLabel;

    field_value__dedicated : Vcl.Controls.TWinControl;

    field_value__universal_db_edit : Vcl.DBCtrls.TDBEdit;

    field_name_etiquette__vertical_splitter,
    //field_value__dedicated__horizontal_splitter,
    field_value__dedicated__vertical_splitter,
    field_value__universal__vertical_splitter
      : Vcl.ExtCtrls.TSplitter;

    log_memo_shared : TMemo;

    procedure field_name_etiquette_label_DblClick( Sender : TObject );
    procedure field_Enter( Sender : TObject );
    procedure field_KeyDown( Sender : TObject; var Key : Word; Shift : TShiftState );

    procedure Field_Value__Dedicated_Db_Edit__On_Change( Sender : TObject );
    procedure Field_Value__Universal_Db_Edit__On_Change( Sender : TObject );
    procedure Field_Value__Universal_Db_Edit__On_Exit( Sender : TObject );
  public
    { Public declarations }
    data_value_format__disabled__fvf : boolean;


    constructor Create( parent_f : Vcl.Controls.TWinControl; data_source_f : TDataSource; field_f : TField; const additional_component_show_f, component__date_time__conventional__use_f, data_value_format__disabled__f, editing_f, splitter_show_f : boolean; field_name_selected_pointer_f : Pointer; key_down_wsk_f : TKeyDown_wsk; key_up_wsk_f : TKey_Up_wsk; log_memo_f : TMemo = nil );
    destructor Destroy(); override;

    procedure Align_Correct__FVF();
    procedure Editing__Set__FVF( const editing_f : boolean );
    procedure Translation__Apply__FVF();
  end;

const
  margin_c : integer = 5;

implementation

uses
  Common,
  Date_Time_Picker,
  Translation;

constructor TForm_View_Field.Create( parent_f : Vcl.Controls.TWinControl; data_source_f : TDataSource; field_f : TField; const additional_component_show_f, component__date_time__conventional__use_f, data_value_format__disabled__f, editing_f, splitter_show_f : boolean; field_name_selected_pointer_f : Pointer; key_down_wsk_f : TKeyDown_wsk; key_up_wsk_f : TKey_Up_wsk; log_memo_f : TMemo = nil );
begin

  inherited Create( Vcl.Forms.Application );


  Self.component__date_time__conventional__use__fvf := component__date_time__conventional__use_f;
  Self.data_value_format__disabled__fvf := data_value_format__disabled__f;
  Self.field_dedicated__data_type := ftUnknown;
  Self.field_name_etiquette_label := nil;
  Self.field_name_etiquette__vertical_splitter := nil;
  Self.field_name_selected_wsk_g := field_name_selected_pointer_f;
  Self.field_value__dedicated := nil;
  //Self.field_value__dedicated__horizontal_splitter := nil;
  Self.field_value__dedicated_db_edit__on_change__block := true;
  Self.field_value__universal_db_edit__on_change__block := true;
  Self.field_value__dedicated__vertical_splitter := nil;
  Self.field_value__universal_db_edit := nil;
  Self.field_value__universal__vertical_splitter := nil;
  Self.key_down_wsk_g := key_down_wsk_f;
  log_memo_shared := log_memo_f;


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
  Self.field_name_etiquette_label.Layout := tlCenter;
  Self.field_name_etiquette_label.Margins.Bottom := 0;
  Self.field_name_etiquette_label.Margins.Left := margin_c * 2;
  Self.field_name_etiquette_label.Margins.Right := margin_c * 2;
  Self.field_name_etiquette_label.Margins.Top := 0;
  Self.field_name_etiquette_label.ShowHint := true;

  if Self.field_name_etiquette_label.Width < 350 then
    Self.field_name_etiquette_label.Width := 350;

  Self.field_name_etiquette_label.OnDblClick := field_name_etiquette_label_DblClick;

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
  Self.field_value__universal_db_edit.OnChange := Self.Field_Value__Universal_Db_Edit__On_Change;
  Self.field_value__universal_db_edit.OnExit := Self.Field_Value__Universal_Db_Edit__On_Exit;

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
    else
    if field_f.DataType in [ ftDate, ftDateTime, ftTime, ftOraTimeStamp, ftTimeStamp, ftTimeStampOffset ] then
      begin

        Self.field_dedicated__data_type := ftDate;

        if Self.component__date_time__conventional__use__fvf then
          Self.field_value__dedicated := Vcl.ComCtrls.TDateTimePicker.Create( Vcl.Forms.Application )
        else
          Self.field_value__dedicated := Date_Time_Picker.TDate_Time_Picker.Create( Vcl.Forms.Application );

        Self.field_value__dedicated.Parent := Self;
        //Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).ShowCheckbox := true;
        Self.field_value__dedicated.AlignWithMargins := true;
        Self.field_value__dedicated.Align := alRight;
        Self.field_value__dedicated.Align := alLeft; // Do not work well.
        Self.field_value__dedicated.Margins.Bottom := margin_c;
        Self.field_value__dedicated.Margins.Left := margin_c * 2;
        Self.field_value__dedicated.Margins.Right := margin_c * 2;
        Self.field_value__dedicated.Margins.Top := margin_c;

        if Self.component__date_time__conventional__use__fvf then
          begin

            if field_f.DataType in [ ftDate ] then
              Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Kind := Vcl.ComCtrls.dtkDate
            else
            if field_f.DataType in [ ftTime ] then
              Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Kind := Vcl.ComCtrls.dtkTime
            else
            if field_f.DataType in [ ftDateTime, ftOraTimeStamp, ftTimeStamp, ftTimeStampOffset ] then
              begin

                Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Kind := Vcl.ComCtrls.dtkDateTime;

                Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Format :=
                  Common.component__date_time__conventional__date_time__format;

              end;

            Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).OnEnter := field_Enter;
            Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).OnKeyDown := field_KeyDown;
            Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).OnKeyUp := key_up_wsk_f;
            Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).OnChange := Field_Value__Dedicated_Db_Edit__On_Change;

          end
        else
          begin

            if field_f.DataType in [ ftDate ] then
              Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Kind := Vcl.ComCtrls.dtkDate
            else
            if field_f.DataType in [ ftTime ] then
              Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Kind := Vcl.ComCtrls.dtkTime
            else
            if field_f.DataType in [ ftDateTime, ftOraTimeStamp, ftTimeStamp, ftTimeStampOffset ] then
              Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Kind := Vcl.ComCtrls.dtkDateTime;

            Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).OnEnter := field_Enter;
            Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).OnKeyDown := field_KeyDown;
            Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).OnKeyUp := key_up_wsk_f;
            Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).OnChange := Field_Value__Dedicated_Db_Edit__On_Change;

          end;

        Self.Field_Value__Universal_Db_Edit__On_Exit( nil );

      end
    else
    if field_f.DataType in
         [
           ftAutoInc, ftByte, ftBytes, ftInteger, ftLargeint, ftLongWord, ftShortint, ftSmallint, ftWord,
           ftBCD, ftCurrency, ftExtended, ftFloat, ftFMTBcd, ftSingle, ftVarBytes
         ] then
      begin

        Self.field_dedicated__data_type := ftInteger;

        Self.field_value__dedicated := Interceptor__Spin_Edit.TSpinEdit.Create( Application );
        Self.field_value__dedicated.Parent := Self;

        if field_f.DataType in [ ftBCD, ftCurrency, ftExtended, ftFloat, ftFMTBcd, ftSingle, ftVarBytes ] then
          begin

            Interceptor__Spin_Edit.TSpinEdit(Self.field_value__dedicated).Value_Type_Float := true;
            Interceptor__Spin_Edit.TSpinEdit(Self.field_value__dedicated).Decimal := field_f.Size;

          end;

        Self.field_value__dedicated.AlignWithMargins := true;
        Self.field_value__dedicated.Align := alRight;
        Self.field_value__dedicated.Align := alLeft; // Do not work well.
        Self.field_value__dedicated.Margins.Bottom := margin_c;
        Self.field_value__dedicated.Margins.Left := margin_c * 2;
        Self.field_value__dedicated.Margins.Right := margin_c * 2;
        Self.field_value__dedicated.Margins.Top := margin_c;
        Interceptor__Spin_Edit.TSpinEdit(Self.field_value__dedicated).OnEnter := field_Enter;
        Interceptor__Spin_Edit.TSpinEdit(Self.field_value__dedicated).OnKeyDown := field_KeyDown;
        Interceptor__Spin_Edit.TSpinEdit(Self.field_value__dedicated).OnKeyUp := key_up_wsk_f;
        Interceptor__Spin_Edit.TSpinEdit(Self.field_value__dedicated).OnChange := Field_Value__Dedicated_Db_Edit__On_Change;

        Self.Field_Value__Universal_Db_Edit__On_Exit( nil );

      end;
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


  Self.field_value__dedicated_db_edit__on_change__block := false;
  Self.field_value__universal_db_edit__on_change__block := false;


  Self.Editing__Set__FVF( editing_f );

  Self.Translation__Apply__FVF();

end;

destructor TForm_View_Field.Destroy();
begin

  FreeAndNil( Self.field_name_etiquette_label );
  FreeAndNil( Self.field_name_etiquette__vertical_splitter );


  if Self.field_value__dedicated <> nil then
    if Self.field_dedicated__data_type = ftBlob then
      FreeAndNil( Vcl.DBCtrls.TDBMemo(Self.field_value__dedicated) )
    else
    if Self.field_dedicated__data_type = ftDate then
      begin

        if Self.component__date_time__conventional__use__fvf then
          FreeAndNil( Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated) )
        else
          FreeAndNil( Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated) );

      end
    else
    if Self.field_dedicated__data_type = ftInteger then
      FreeAndNil( Interceptor__Spin_Edit.TSpinEdit(Self.field_value__dedicated) );


  //if Self.field_value__dedicated__horizontal_splitter <> nil then
  //  FreeAndNil( Self.field_value__dedicated__horizontal_splitter ); // Do not free here.

  if Self.field_value__dedicated__vertical_splitter <> nil then
    FreeAndNil( Self.field_value__dedicated__vertical_splitter );

  FreeAndNil( Self.field_value__universal_db_edit );
  FreeAndNil( Self.field_value__universal__vertical_splitter );

  inherited;

end;

procedure TForm_View_Field.field_name_etiquette_label_DblClick( Sender : TObject );
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

  ztdt : TDateTime;

  zts : string;

  date_format : TFormatSettings;
begin

  // A.
  if    ( Key = 65 )
    and ( Shift = [ ssCtrl, ssShift ] ) then
    Self.Align_Correct__FVF()
  else
  // C.
  if    ( Key = 67 )
    and ( Shift = [ ssCtrl ] )
    and ( Sender <> nil ) then
  begin

    if Sender is Vcl.DBCtrls.TDBEdit then
      begin

        if Vcl.DBCtrls.TDBEdit(Sender).SelText <> '' then
          Vcl.Clipbrd.Clipboard.AsText := Vcl.DBCtrls.TDBEdit(Sender).SelText
        else
        if Self.data_value_format__disabled__fvf then
          Vcl.Clipbrd.Clipboard.AsText := Vcl.DBCtrls.TDBEdit(Sender).Field.AsString
        else
          Vcl.Clipbrd.Clipboard.AsText := Vcl.DBCtrls.TDBEdit(Sender).Text;

      end
    else
    if    ( Self.component__date_time__conventional__use__fvf )
      and ( Sender is Vcl.ComCtrls.TDateTimePicker ) then
      begin

        try
          if Vcl.ComCtrls.TDateTimePicker(Sender).Kind = Vcl.ComCtrls.dtkDateTime then
            DateTimeToString( zts, Common.table__data_filter__filter__dedicated_value_format__date + Common.table__data_filter__filter__dedicated_value_format__separator__date_time + Common.table__data_filter__filter__dedicated_value_format__time, Vcl.ComCtrls.TDateTimePicker(Sender).DateTime )
          else
          if Vcl.ComCtrls.TDateTimePicker(Sender).Kind = Vcl.ComCtrls.dtkTime then
            DateTimeToString( zts, Common.table__data_filter__filter__dedicated_value_format__time, Vcl.ComCtrls.TDateTimePicker(Sender).Time )
          else
            DateTimeToString( zts, Common.table__data_filter__filter__dedicated_value_format__date, Vcl.ComCtrls.TDateTimePicker(Sender).Date );

          Vcl.Clipbrd.Clipboard.AsText := zts;
        except
          on E : Exception do
            Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
        end;

      end
    else
    if    ( not Self.component__date_time__conventional__use__fvf )
      and ( Sender is Interceptor__Spin_Edit.TSpinEdit )
      and ( Interceptor__Spin_Edit.TSpinEdit(Sender).Parent <> nil )
      and ( Interceptor__Spin_Edit.TSpinEdit(Sender).Parent.Parent <> nil )
      and ( Interceptor__Spin_Edit.TSpinEdit(Sender).Parent.Parent is Date_Time_Picker.TDate_Time_Picker ) then
      begin

        try
          if Date_Time_Picker.TDate_Time_Picker(Interceptor__Spin_Edit.TSpinEdit(Sender).Parent.Parent).Kind = Vcl.ComCtrls.dtkDateTime then
            DateTimeToString( zts, Common.table__data_filter__filter__dedicated_value_format__date + Common.table__data_filter__filter__dedicated_value_format__separator__date_time + Common.table__data_filter__filter__dedicated_value_format__time, Date_Time_Picker.TDate_Time_Picker(Interceptor__Spin_Edit.TSpinEdit(Sender).Parent.Parent).Date_Time )
          else
          if Date_Time_Picker.TDate_Time_Picker(Interceptor__Spin_Edit.TSpinEdit(Sender).Parent.Parent).Kind = Vcl.ComCtrls.dtkTime then
            DateTimeToString( zts, Common.table__data_filter__filter__dedicated_value_format__time, Date_Time_Picker.TDate_Time_Picker(Interceptor__Spin_Edit.TSpinEdit(Sender).Parent.Parent).Time )
          else
            DateTimeToString( zts, Common.table__data_filter__filter__dedicated_value_format__date, Date_Time_Picker.TDate_Time_Picker(Interceptor__Spin_Edit.TSpinEdit(Sender).Parent.Parent).Date );

          Vcl.Clipbrd.Clipboard.AsText := zts;
        except
          on E : Exception do
            Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_copy_value_to_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
        end;

      end;

  end
  else
  // Q.
  if    ( Key = 81 )
    and ( Shift = [ ssCtrl, ssShift ] ) then
    Self.Align_Correct__FVF()
  else
  // V.
  if    ( Key = 86 )
    and ( Shift = [ ssCtrl ] )
    and ( Sender <> nil ) then
  begin

    try
      if Self.component__date_time__conventional__use__fvf then
        begin

          date_format.ShortDateFormat := Common.table__data_filter__filter__dedicated_value_format__date;
          date_format.ShortTimeFormat := Common.table__data_filter__filter__dedicated_value_format__time;

          if Length( Common.table__data_filter__filter__dedicated_value_format__separator__date ) > 0 then
            date_format.DateSeparator := Common.table__data_filter__filter__dedicated_value_format__separator__date[ 1 ];

          if Length( Common.table__data_filter__filter__dedicated_value_format__separator__decimal ) > 0 then
            date_format.DecimalSeparator := Common.table__data_filter__filter__dedicated_value_format__separator__decimal[ 1 ];

          if Length( Common.table__data_filter__filter__dedicated_value_format__separator__time ) > 0 then
            date_format.TimeSeparator := Common.table__data_filter__filter__dedicated_value_format__separator__time[ 1 ];

          ztdt := StrToDateTime( Vcl.Clipbrd.Clipboard.AsText, date_format );


          if Sender is Vcl.ComCtrls.TDateTimePicker then
            begin

              if Vcl.ComCtrls.TDateTimePicker(Sender).Kind = Vcl.ComCtrls.dtkDateTime then
                Vcl.ComCtrls.TDateTimePicker(Sender).DateTime := ztdt
              else
              if Vcl.ComCtrls.TDateTimePicker(Sender).Kind = Vcl.ComCtrls.dtkTime then
                Vcl.ComCtrls.TDateTimePicker(Sender).Time := System.DateUtils.TimeOf( ztdt )
              else
                Vcl.ComCtrls.TDateTimePicker(Sender).Date := System.DateUtils.DateOf( ztdt );

            end;


          Field_Value__Dedicated_Db_Edit__On_Change( Sender );

        end;

      // Date_Time_Picker.TDate_Time_Picker supports 'paste' on its own.

    except
      on E : Exception do
        Application.MessageBox(  PChar(Translation.translation__messages_r.failed_to_paste_value_from_clipboard + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION  );
    end;

  end
  else
  if    ( Sender <> nil )
    and ( TWinControl(Sender).Parent <> nil ) then
    begin

      // At the end.

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

      if    ( Self.component__date_time__conventional__use__fvf )
        and ( Self.field_value__dedicated is Vcl.ComCtrls.TDateTimePicker ) then
        Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Enabled := editing_f
      else
      if    ( not Self.component__date_time__conventional__use__fvf )
        and ( Self.field_value__dedicated is Date_Time_Picker.TDate_Time_Picker ) then
        Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).ReadOnly := not editing_f
      else
      if Self.field_value__dedicated is Interceptor__Spin_Edit.TSpinEdit then
        Interceptor__Spin_Edit.TSpinEdit(Self.field_value__dedicated).ReadOnly := not editing_f
      else
      if Self.field_value__dedicated is Vcl.DBCtrls.TDBMemo then
        Vcl.DBCtrls.TDBMemo(Self.field_value__dedicated).ReadOnly := not editing_f;

    end;

end;

procedure TForm_View_Field.Field_Value__Dedicated_Db_Edit__On_Change( Sender : TObject );
begin

  if   ( Self.field_value__dedicated_db_edit__on_change__block )
    or ( Self.field_value__dedicated = nil )
    or ( Self.field_value__universal_db_edit = nil )
    or ( Self.field_value__universal_db_edit.Field = nil )
    or ( not Self.field_value__dedicated.Focused() )
    or ( Self.field_value__universal_db_edit.ReadOnly ) then
    Exit;


  Self.field_value__universal_db_edit__on_change__block := true;


  if Self.field_value__universal_db_edit.Field.DataType in [ ftDate, ftDateTime, ftTime, ftOraTimeStamp, ftTimeStamp, ftTimeStampOffset ] then
    begin

      if not ( Self.field_value__universal_db_edit.DataSource.DataSet.State in [ Data.DB.dsEdit, Data.DB.dsInsert ] ) then
        Self.field_value__universal_db_edit.DataSource.DataSet.Edit();


      if Self.field_value__dedicated is Vcl.ComCtrls.TDateTimePicker then
        begin

          if Self.field_value__universal_db_edit.Field.DataType in [ ftDateTime, ftOraTimeStamp, ftTimeStamp, ftTimeStampOffset ] then
            Self.field_value__universal_db_edit.Field.AsDateTime := Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).DateTime
          else
          if Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Kind = Vcl.ComCtrls.dtkDate then
            Self.field_value__universal_db_edit.Field.AsDateTime := Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Date
          else
          if Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Kind = Vcl.ComCtrls.dtkTime then
            Self.field_value__universal_db_edit.Field.AsDateTime := Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Time;

        end
      else
      if Self.field_value__dedicated is Date_Time_Picker.TDate_Time_Picker then
        begin

          if Self.field_value__universal_db_edit.Field.DataType in [ ftDateTime, ftOraTimeStamp, ftTimeStamp, ftTimeStampOffset ] then
            Self.field_value__universal_db_edit.Field.AsDateTime := Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Date_Time
          else
          if Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Kind = Vcl.ComCtrls.dtkDate then
            Self.field_value__universal_db_edit.Field.AsDateTime := Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Date
          else
          if Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Kind = Vcl.ComCtrls.dtkTime then
            Self.field_value__universal_db_edit.Field.AsDateTime := Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Time;

        end;

    end
  else
  if Self.field_value__universal_db_edit.Field.DataType in
       [
         ftAutoInc, ftByte, ftBytes, ftInteger, ftLargeint, ftLongWord, ftShortint, ftSmallint, ftWord,
         ftBCD, ftCurrency, ftExtended, ftFloat, ftFMTBcd, ftSingle, ftVarBytes
       ] then
    begin

      if not ( Self.field_value__universal_db_edit.DataSource.DataSet.State in [ Data.DB.dsEdit, Data.DB.dsInsert ] ) then
        Self.field_value__universal_db_edit.DataSource.DataSet.Edit();


      Self.field_value__universal_db_edit.Field.AsCurrency := Interceptor__Spin_Edit.TSpinEdit(Self.field_value__dedicated).Value;

    end;


  Self.field_value__universal_db_edit__on_change__block := false;

end;

procedure TForm_View_Field.Field_Value__Universal_Db_Edit__On_Change( Sender : TObject );
var
  zts : string;
begin

  if   ( Self.field_value__universal_db_edit__on_change__block )
    or ( Self.field_value__dedicated = nil )
    or ( Self.field_value__universal_db_edit = nil )
    or ( Self.field_value__universal_db_edit.Field = nil ) then
    Exit;


  Self.field_value__dedicated_db_edit__on_change__block := true;


  if Self.field_value__universal_db_edit.Field.DataType in [ ftDate, ftDateTime, ftTime, ftOraTimeStamp, ftTimeStamp, ftTimeStampOffset ] then
    begin

      if Self.field_value__dedicated is Vcl.ComCtrls.TDateTimePicker then
        begin

          try

            // TDateTimePicker gives error 'Failed to set calendar date or time' if date is earlier than '01.01.1601'.

            if Self.field_value__universal_db_edit.Field.DataType in [ ftDateTime, ftOraTimeStamp, ftTimeStamp, ftTimeStampOffset ] then
              Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).DateTime := StrToDateTimeDef( Self.field_value__universal_db_edit.Text, 0 )
            else
            if Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Kind = Vcl.ComCtrls.dtkDate then
              Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Date := StrToDateDef( Self.field_value__universal_db_edit.Text, 0 )
            else
            if Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Kind = Vcl.ComCtrls.dtkTime then
              Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Time := StrToTimeDef( Self.field_value__universal_db_edit.Text, 0 );

          except
            on E : Exception do
              begin

                if log_memo_shared <> nil then
                  log_memo_shared.Lines.Add( Self.field_value__universal_db_edit.Field.FieldName + ' (' + Self.field_value__universal_db_edit.Text + ') - ' + E.Message + '.' )
                else
                  Application.MessageBox( PChar(Self.field_value__universal_db_edit.Field.FieldName + ' (' + Self.field_value__universal_db_edit.Text + ') - ' + E.Message + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

              end;
          end;

        end
      else
      if Self.field_value__dedicated is Date_Time_Picker.TDate_Time_Picker then
        begin

          if Self.field_value__universal_db_edit.Field.DataType in [ ftDateTime, ftOraTimeStamp, ftTimeStamp, ftTimeStampOffset ] then
            Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Date_Time := StrToDateTimeDef( Self.field_value__universal_db_edit.Text, 0 )
          else
          if Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Kind = Vcl.ComCtrls.dtkDate then
            Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Date := StrToDateDef( Self.field_value__universal_db_edit.Text, 0 )
          else
          if Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Kind = Vcl.ComCtrls.dtkTime then
            Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Time := StrToTimeDef( Self.field_value__universal_db_edit.Text, 0 );

        end;

    end
  else
  if Self.field_value__universal_db_edit.Field.DataType in
       [
         ftAutoInc, ftByte, ftBytes, ftInteger, ftLargeint, ftLongWord, ftShortint, ftSmallint, ftWord,
         ftBCD, ftCurrency, ftExtended, ftFloat, ftFMTBcd, ftSingle, ftVarBytes
       ] then
    begin

      zts := Self.field_value__universal_db_edit.Text;
      zts := StringReplace( zts, ' ', '', [ rfReplaceAll ] );
      zts := StringReplace( zts, '.', ',', [ rfReplaceAll ] );
      Interceptor__Spin_Edit.TSpinEdit(Self.field_value__dedicated).Value := StrToCurrDef( zts, Self.field_value__universal_db_edit.Field.AsCurrency );

    end;


  Self.field_value__dedicated_db_edit__on_change__block := false;

end;

procedure TForm_View_Field.Field_Value__Universal_Db_Edit__On_Exit( Sender : TObject );
begin

  if   ( Self.field_value__dedicated = nil )
    or ( Self.field_value__universal_db_edit = nil )
    or ( Self.field_value__universal_db_edit.Field = nil ) then
    Exit;


  Self.field_value__dedicated_db_edit__on_change__block := true;


  if Self.field_value__universal_db_edit.Field.DataType in [ ftDate, ftDateTime, ftTime, ftOraTimeStamp, ftTimeStamp, ftTimeStampOffset ] then
    begin

      if Self.field_value__dedicated is Vcl.ComCtrls.TDateTimePicker then
        begin

          try

            // TDateTimePicker gives error 'Failed to set calendar date or time' if date is earlier than '01.01.1601'.

            if Self.field_value__universal_db_edit.Field.DataType in [ ftDateTime, ftOraTimeStamp, ftTimeStamp, ftTimeStampOffset ] then
              Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).DateTime := Self.field_value__universal_db_edit.Field.AsDateTime
            else
            if Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Kind = Vcl.ComCtrls.dtkDate then
              Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Date := System.DateUtils.DateOf( Self.field_value__universal_db_edit.Field.AsDateTime )
            else
            if Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Kind = Vcl.ComCtrls.dtkTime then
              Vcl.ComCtrls.TDateTimePicker(Self.field_value__dedicated).Time := System.DateUtils.TimeOf( Self.field_value__universal_db_edit.Field.AsDateTime );

          except
            on E : Exception do
              begin

                if log_memo_shared <> nil then
                  log_memo_shared.Lines.Add( Self.field_value__universal_db_edit.Field.FieldName + ' (' + Self.field_value__universal_db_edit.Text + ') - ' + E.Message + '.' )
                else
                  Application.MessageBox( PChar(Self.field_value__universal_db_edit.Field.FieldName + ' (' + Self.field_value__universal_db_edit.Text + ') - ' + E.Message + '.'), PChar(Translation.translation__messages_r.error), MB_OK + MB_ICONEXCLAMATION );

              end;
          end;

        end
      else
      if Self.field_value__dedicated is Date_Time_Picker.TDate_Time_Picker then
        begin

          if Self.field_value__universal_db_edit.Field.DataType in [ ftDateTime, ftOraTimeStamp, ftTimeStamp, ftTimeStampOffset ] then
            Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Date_Time := Self.field_value__universal_db_edit.Field.AsDateTime
          else
          if Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Kind = Vcl.ComCtrls.dtkDate then
            Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Date := System.DateUtils.DateOf( Self.field_value__universal_db_edit.Field.AsDateTime )
          else
          if Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Kind = Vcl.ComCtrls.dtkTime then
            Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Time := System.DateUtils.TimeOf( Self.field_value__universal_db_edit.Field.AsDateTime );

        end;

    end
  else
  if Self.field_value__universal_db_edit.Field.DataType in
       [
         ftAutoInc, ftByte, ftBytes, ftInteger, ftLargeint, ftLongWord, ftShortint, ftSmallint, ftWord,
         ftBCD, ftCurrency, ftExtended, ftFloat, ftFMTBcd, ftSingle, ftVarBytes
       ] then
    Interceptor__Spin_Edit.TSpinEdit(Self.field_value__dedicated).Value := Self.field_value__universal_db_edit.Field.AsCurrency;


  Self.field_value__dedicated_db_edit__on_change__block := false;

end;

procedure TForm_View_Field.Translation__Apply__FVF();
begin

  if Self.field_name_etiquette_label <> nil then
    Self.field_name_etiquette_label.Hint :=
      Self.field_name_etiquette_label.Caption + #13 + #13 +
      Translation.translation__table__data_filter_r.field_name_etiquette_label__hint;


  if    ( Self.field_value__dedicated <> nil )
    and ( Self.field_value__dedicated is Date_Time_Picker.TDate_Time_Picker ) then
    begin

      Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).date_time__format__hint__translation := Translation.translation__table__data_filter_r.day___month___year___hour___minute___second___milli_second;
      Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).failed_to_paste_value_from_clipboard__translation := Translation.translation__messages_r.failed_to_paste_value_from_clipboard;
      Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).error__translation := Translation.translation__messages_r.error;

      Date_Time_Picker.TDate_Time_Picker(Self.field_value__dedicated).Translation__Apply__DTP();

    end;

end;

end.
