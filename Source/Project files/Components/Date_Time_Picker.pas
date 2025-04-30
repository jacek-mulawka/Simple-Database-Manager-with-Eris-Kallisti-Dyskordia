unit Date_Time_Picker;{16.Kwi.2025}

interface

uses
  System.Classes,
  System.DateUtils,
  System.Math,
  System.SysUtils,
  Vcl.Clipbrd,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Winapi.Windows,

  Interceptor__Spin_Edit;

type
  TDate_Time_Picker = class( Vcl.ExtCtrls.TPanel )
  private
    { Private declarations }
    change__block,
    FEnabled,
    FRead_Only
      : boolean;

    FColor : Vcl.Graphics.TColor;

    FKind : Vcl.ComCtrls.TDateTimeKind;

    FDate_Time : TDateTime;

    calendar_date_time_picker
      : Vcl.ComCtrls.TDateTimePicker;

    date_panel,
    time_panel
      : Vcl.ExtCtrls.TPanel;

    day_spin_edit,
    hour_spin_edit,
    milli_second_spin_edit,
    minute_spin_edit,
    month_spin_edit,
    second_spin_edit,
    year_spin_edit
      : Interceptor__Spin_Edit.TSpinEdit;

    procedure calendar_date_time_picker_Close_Up( Sender : TObject );
    procedure Calendar_Date_Time_Picker__Hint__Set();

    procedure Change( Sender : TObject );
    procedure Color__Set( const color_f : Vcl.Graphics.TColor );

    function Date__Get() : TDate;
    procedure Date__Set( const date_f : TDate );
    procedure Date_Time__Set( const date_time_f : TDateTime );
    procedure Enabled__Set( const enabled_f : boolean );

    procedure Exit_( Sender : TObject );

    procedure Key_Down( Sender : TObject; var Key : Word; Shift : System.Classes.TShiftState );
    procedure Key_Press( Sender : TObject; var Key : Char );
    procedure Key_Up( Sender : TObject; var Key : Word; Shift : System.Classes.TShiftState );

    procedure Kind__Set( const kind_f : Vcl.ComCtrls.TDateTimeKind );

    procedure Read_Only__Set( const read_only_f : boolean );

    procedure Spin_Edits__Value__Set();

    function Time__Get() : TTime;
    procedure Time__Set( const time_f : TTime );
  public
    { Public declarations }
    date_format : TFormatSettings;

    date_time__format__hint__translation,
    failed_to_paste_value_from_clipboard__translation,
    error__translation
      : string;

    OnChange : System.Classes.TNotifyEvent;

    OnKeyDown,
    OnKeyUp
      : Vcl.Controls.TKeyEvent;

    constructor Create( AOwner : System.Classes.TComponent );
    destructor Destroy(); override;

    function Focused() : boolean; override;
    procedure Translation__Apply__DTP();
  published
    property Color : Vcl.Graphics.TColor read FColor write Color__Set;
    property Date : TDate read Date__Get write Date__Set;
    property Date_Time : TDateTime read FDate_Time write Date_Time__Set;
    property Enabled : boolean read FEnabled write Enabled__Set;
    property Kind : Vcl.ComCtrls.TDateTimeKind read FKind write Kind__Set;
    property ReadOnly : boolean read FRead_Only write Read_Only__Set;
    property Time : TTime read Time__Get write Time__Set;
  const
    date_panel__width : integer = 210;
    max_year_c : integer = 9999; // Some system functions limits.
  end;

implementation

constructor TDate_Time_Picker.Create( AOwner : System.Classes.TComponent );
begin

  inherited Create( Vcl.Forms.Application );


  Self.change__block := true;
  Self.FColor := Vcl.Graphics.clWindow;
  Self.date_format.ShortDateFormat := 'dd.mm.yyyy';
  Self.date_format.ShortTimeFormat := 'hh:mm:ss:zzz';
  Self.date_format.DateSeparator := '.';
  Self.date_format.TimeSeparator := ':';
  Self.date_format.DecimalSeparator := '.';
  Self.date_time__format__hint__translation := 'day - month - year   hour : minute : second . millisecond';
  Self.FEnabled := true;
  Self.failed_to_paste_value_from_clipboard__translation := 'Failed to paste value from clipboard.';

  Self.FKind := Vcl.ComCtrls.dtkDateTime;
  Self.FRead_Only := false;
  Self.error__translation := 'Error';

  Self.OnChange := nil;
  Self.OnKeyDown := nil;
  Self.OnKeyUp := nil;


  Self.Height := 22;
  Self.Width := 385;


  Self.date_panel := Vcl.ExtCtrls.TPanel.Create( Self );
  Self.date_panel.Parent := Self;
  Self.date_panel.Left := 0;
  Self.date_panel.Height := Self.Height;
  Self.date_panel.Width := Self.date_panel__width;

  Self.time_panel := Vcl.ExtCtrls.TPanel.Create( Self );
  Self.time_panel.Parent := Self;
  Self.time_panel.Left := Self.date_panel.Left + Self.date_panel.Width;
  Self.time_panel.Height := Self.Height;
  Self.time_panel.Width := 170;


  Self.day_spin_edit := Interceptor__Spin_Edit.TSpinEdit.Create( Self );
  Self.day_spin_edit.Parent := Self.date_panel;
  Self.day_spin_edit.Check_Value__Min := true;
  Self.day_spin_edit.Check_Value__Max := true;
  Self.day_spin_edit.Left := 0;
  Self.day_spin_edit.MaxValue := 31;
  Self.day_spin_edit.MinValue := 1;
  Self.day_spin_edit.Width := 40;
  Self.day_spin_edit.OnChange := Change;
  Self.day_spin_edit.OnExit := Exit_;
  Self.day_spin_edit.OnKeyDown := Key_Down;
  Self.day_spin_edit.OnKeyPress := Key_Press;
  Self.day_spin_edit.OnKeyUp := Key_Up;

  Self.month_spin_edit := Interceptor__Spin_Edit.TSpinEdit.Create( Self );
  Self.month_spin_edit.Parent := Self.date_panel;
  Self.month_spin_edit.Check_Value__Min := true;
  Self.month_spin_edit.Check_Value__Max := true;
  Self.month_spin_edit.Left := Self.day_spin_edit.Left + Self.day_spin_edit.Width;
  Self.month_spin_edit.MaxValue := 12;
  Self.month_spin_edit.MinValue := 1;
  Self.month_spin_edit.Width := 40;
  Self.month_spin_edit.OnChange := Change;
  Self.month_spin_edit.OnExit := Exit_;
  Self.month_spin_edit.OnKeyDown := Key_Down;
  Self.month_spin_edit.OnKeyPress := Key_Press;
  Self.month_spin_edit.OnKeyUp := Key_Up;

  Self.year_spin_edit := Interceptor__Spin_Edit.TSpinEdit.Create( Self );
  Self.year_spin_edit.Parent := Self.date_panel;
  Self.year_spin_edit.Check_Value__Min := true;
  Self.year_spin_edit.Left := Self.month_spin_edit.Left + Self.month_spin_edit.Width;
  Self.year_spin_edit.MinValue := 1;
  Self.year_spin_edit.Width := 100;
  Self.year_spin_edit.OnChange := Change;
  Self.year_spin_edit.OnExit := Exit_;
  Self.year_spin_edit.OnKeyDown := Key_Down;
  Self.year_spin_edit.OnKeyPress := Key_Press;
  Self.year_spin_edit.OnKeyUp := Key_Up;


  Self.calendar_date_time_picker := Vcl.ComCtrls.TDateTimePicker.Create( Self );
  Self.calendar_date_time_picker.Parent := Self.date_panel;
  Self.calendar_date_time_picker.Hint := '<?>';
  Self.calendar_date_time_picker.Left := Self.year_spin_edit.Left + 30;
  Self.calendar_date_time_picker.ShowHint := true;;
  Self.calendar_date_time_picker.Width := 100;
  Self.calendar_date_time_picker.SendToBack();
  Self.calendar_date_time_picker.OnCloseUp := calendar_date_time_picker_Close_Up;
  Self.calendar_date_time_picker.OnKeyDown := Key_Down;
  Self.calendar_date_time_picker.OnKeyPress := Key_Press;
  Self.calendar_date_time_picker.OnKeyUp := Key_Up;


  Self.hour_spin_edit := Interceptor__Spin_Edit.TSpinEdit.Create( Self );
  Self.hour_spin_edit.Parent := Self.time_panel;
  Self.hour_spin_edit.Check_Value__Min := true;
  Self.hour_spin_edit.Check_Value__Max := true;
  Self.hour_spin_edit.Left := 0;
  Self.hour_spin_edit.MaxValue := 23;
  Self.hour_spin_edit.MinValue := 0;
  Self.hour_spin_edit.Width := 40;
  Self.hour_spin_edit.OnChange := Change;
  Self.hour_spin_edit.OnExit := Exit_;
  Self.hour_spin_edit.OnKeyDown := Key_Down;
  Self.hour_spin_edit.OnKeyPress := Key_Press;
  Self.hour_spin_edit.OnKeyUp := Key_Up;

  Self.minute_spin_edit := Interceptor__Spin_Edit.TSpinEdit.Create( Self );
  Self.minute_spin_edit.Parent := Self.time_panel;
  Self.minute_spin_edit.Check_Value__Min := true;
  Self.minute_spin_edit.Check_Value__Max := true;
  Self.minute_spin_edit.Left := Self.hour_spin_edit.Left + Self.hour_spin_edit.Width;
  Self.minute_spin_edit.MaxValue := 59;
  Self.minute_spin_edit.MinValue := 0;
  Self.minute_spin_edit.Width := 40;
  Self.minute_spin_edit.OnChange := Change;
  Self.minute_spin_edit.OnExit := Exit_;
  Self.minute_spin_edit.OnKeyDown := Key_Down;
  Self.minute_spin_edit.OnKeyPress := Key_Press;
  Self.minute_spin_edit.OnKeyUp := Key_Up;

  Self.second_spin_edit := Interceptor__Spin_Edit.TSpinEdit.Create( Self );
  Self.second_spin_edit.Parent := Self.time_panel;
  Self.second_spin_edit.Check_Value__Min := true;
  Self.second_spin_edit.Check_Value__Max := true;
  Self.second_spin_edit.Left := Self.minute_spin_edit.Left + Self.minute_spin_edit.Width;
  Self.second_spin_edit.MaxValue := 59;
  Self.second_spin_edit.MinValue := 0;
  Self.second_spin_edit.Width := 40;
  Self.second_spin_edit.OnChange := Change;
  Self.second_spin_edit.OnExit := Exit_;
  Self.second_spin_edit.OnKeyDown := Key_Down;
  Self.second_spin_edit.OnKeyPress := Key_Press;
  Self.second_spin_edit.OnKeyUp := Key_Up;

  Self.milli_second_spin_edit := Interceptor__Spin_Edit.TSpinEdit.Create( Self );
  Self.milli_second_spin_edit.Parent := Self.time_panel;
  Self.milli_second_spin_edit.Check_Value__Min := true;
  Self.milli_second_spin_edit.Check_Value__Max := true;
  Self.milli_second_spin_edit.Left := Self.second_spin_edit.Left + Self.second_spin_edit.Width;
  Self.milli_second_spin_edit.MaxValue := 999;
  Self.milli_second_spin_edit.MinValue := 0;
  Self.milli_second_spin_edit.Width := 50;
  Self.milli_second_spin_edit.OnChange := Change;
  Self.milli_second_spin_edit.OnExit := Exit_;
  Self.milli_second_spin_edit.OnKeyDown := Key_Down;
  Self.milli_second_spin_edit.OnKeyPress := Key_Press;
  Self.milli_second_spin_edit.OnKeyUp := Key_Up;


  Self.Date_Time := Now();


  Self.change__block := false;

end;

destructor TDate_Time_Picker.Destroy();
begin

  System.SysUtils.FreeAndNil( Self.calendar_date_time_picker );
  System.SysUtils.FreeAndNil( Self.day_spin_edit );
  System.SysUtils.FreeAndNil( Self.hour_spin_edit );
  System.SysUtils.FreeAndNil( Self.milli_second_spin_edit );
  System.SysUtils.FreeAndNil( Self.minute_spin_edit );
  System.SysUtils.FreeAndNil( Self.month_spin_edit );
  System.SysUtils.FreeAndNil( Self.second_spin_edit );
  System.SysUtils.FreeAndNil( Self.year_spin_edit );

  System.SysUtils.FreeAndNil( Self.time_panel );
  System.SysUtils.FreeAndNil( Self.date_panel );

  inherited;

end;

procedure TDate_Time_Picker.calendar_date_time_picker_Close_Up( Sender : TObject );
begin

  Self.change__block := true;


  Self.day_spin_edit.value := System.DateUtils.DayOf( Self.calendar_date_time_picker.Date );
  Self.month_spin_edit.value := System.DateUtils.MonthOf( Self.calendar_date_time_picker.Date );
  Self.year_spin_edit.value := System.DateUtils.YearOf( Self.calendar_date_time_picker.Date );


  Self.change__block := false;


  Self.Change( nil );

end;

procedure TDate_Time_Picker.Calendar_Date_Time_Picker__Hint__Set();
var
  zts : string;
begin

  DateTimeToString( zts, 'dd-mm-yyyy hh:mm:ss.zzz', Self.FDate_Time );

  Self.calendar_date_time_picker.Hint :=
    zts + #13 +
    Self.date_time__format__hint__translation;

end;

procedure TDate_Time_Picker.Change( Sender : TObject );

  function Is_Leap_Year_l( const year_f : integer ) : boolean;
  begin

    Result := (year_f mod 4 = 0) and ((year_f mod 100 <> 0) or (year_f mod 400 = 0));

  end;

var
  zti,
  day_l,
  day_copy_l,
  hour_l,
  milli_second_l,
  minute_l,
  month_l,
  second_l,
  year_l
   : integer;

  ztdt : TDateTime;
begin

  if Self.change__block then
    Exit;



  if System.Math.Floor( Self.year_spin_edit.value ) >= 1 then
    year_l := System.Math.Floor( Self.year_spin_edit.value )
  else
    year_l := 1;


  if    (  System.Math.Floor( Self.month_spin_edit.value ) >= 1  )
    and (  System.Math.Floor( Self.month_spin_edit.value ) <= 12  ) then
    month_l := System.Math.Floor( Self.month_spin_edit.value )
  else
    month_l := 1;


  if year_l <= Winapi.Windows.MAXWORD then
    begin

      day_l := System.DateUtils.DaysInAMonth
          (
            year_l,
            month_l
          );

    end
  else
    begin

      if month_l = 2 then
        begin

          if Is_Leap_Year_l( year_l ) then
            day_l := 29
          else
            day_l := 28;

        end
      else
      if month_l in [ 1, 3, 5, 7, 8, 10, 12 ] then
        day_l := 31
      else
        day_l := 30;

    end;

  if    (  System.Math.Floor( Self.day_spin_edit.value ) >= 1  )
    and (  System.Math.Floor( Self.day_spin_edit.value ) <= day_l  ) then
    day_l := System.Math.Floor( Self.day_spin_edit.value );


  if    (  System.Math.Floor( Self.hour_spin_edit.value ) >= 0  )
    and (  System.Math.Floor( Self.hour_spin_edit.value ) <= 23  ) then
    hour_l := System.Math.Floor( Self.hour_spin_edit.value )
  else
    hour_l := 0;


  if    (  System.Math.Floor( Self.minute_spin_edit.value ) >= 0  )
    and (  System.Math.Floor( Self.minute_spin_edit.value ) <= 59  ) then
    minute_l := System.Math.Floor( Self.minute_spin_edit.value )
  else
    minute_l := 0;

  if    (  System.Math.Floor( Self.second_spin_edit.value ) >= 0  )
    and (  System.Math.Floor( Self.second_spin_edit.value ) <= 59  ) then
    second_l := System.Math.Floor( Self.second_spin_edit.value )
  else
    second_l := 0;


  if    (  System.Math.Floor( Self.milli_second_spin_edit.value ) >= 0  )
    and (  System.Math.Floor( Self.milli_second_spin_edit.value ) <= 999  ) then
    milli_second_l := System.Math.Floor( Self.milli_second_spin_edit.value )
  else
    milli_second_l := 0;


  //ztdt := System.DateUtils.EncodeDateTime
  //  (
  //    year_l, // Max year = 9999 (Self.max_year_c). //????
  //    month_l,
  //    day_l,
  //
  //    hour_l,
  //    minute_l,
  //    second_l,
  //
  //    milli_second_l
  //  );
  if year_l > Self.max_year_c then
    begin

      zti := year_l;
      year_l := Self.max_year_c;
      day_copy_l := 1;

    end
  else
    begin

      day_copy_l := day_l;
      zti := 0;

    end;

  ztdt := System.DateUtils.EncodeDateTime
    (
      year_l, // Max year = 9999 (Self.max_year_c). //????
      month_l,
      day_copy_l,

      hour_l,
      minute_l,
      second_l,

      milli_second_l
    );

  if zti > Self.max_year_c then
    begin

      while year_l < zti do
        begin

          inc( year_l );


          if Is_Leap_Year_l( year_l ) then
            ztdt := System.DateUtils.IncDay( ztdt, 366 )
          else
            ztdt := System.DateUtils.IncDay( ztdt, 365 );

        end;


      while System.DateUtils.DayOf( ztdt ) < day_l do
        ztdt := System.DateUtils.IncDay( ztdt, 1 );

    end;

  Self.Date_Time__Set( ztdt );


  if @Self.OnChange <> nil then
    Self.OnChange( Sender );

end;

procedure TDate_Time_Picker.Color__Set( const color_f : Vcl.Graphics.TColor );
begin

  Self.FColor := color_f;


  Self.day_spin_edit.Color := Self.FColor;
  Self.hour_spin_edit.Color := Self.FColor;
  Self.milli_second_spin_edit.Color := Self.FColor;
  Self.minute_spin_edit.Color := Self.FColor;
  Self.month_spin_edit.Color := Self.FColor;
  Self.second_spin_edit.Color := Self.FColor;
  Self.year_spin_edit.Color := Self.FColor;

end;

function TDate_Time_Picker.Date__Get() : TDate;
begin

  //Result := System.SysUtils.EncodeDate
  //  (
  //    System.DateUtils.YearOf( Self.FDate_Time ), // Max year = 9999 (Self.max_year_c). //????
  //    System.DateUtils.MonthOf( Self.FDate_Time ),
  //    System.DateUtils.DayOf( Self.FDate_Time )
  //  );
  Result := Self.FDate_Time;

end;

procedure TDate_Time_Picker.Date__Set( const date_f : TDate );
var
  ztdt : TDateTime;
begin

  ztdt := System.DateUtils.EncodeDateTime
    (
      System.DateUtils.YearOf( date_f ),
      System.DateUtils.MonthOf( date_f ),
      System.DateUtils.DayOf( date_f ),

      System.DateUtils.HourOf( Self.FDate_Time ),
      System.DateUtils.MinuteOf( Self.FDate_Time ),
      System.DateUtils.SecondOf( Self.FDate_Time ),

      System.DateUtils.MilliSecondOf( Self.FDate_Time )
    );


  Self.Date_Time__Set( ztdt );

end;

procedure TDate_Time_Picker.Date_Time__Set( const date_time_f : TDateTime );
begin

  Self.FDate_Time := date_time_f;


  Self.Spin_Edits__Value__Set();


  Self.Calendar_Date_Time_Picker__Hint__Set();

  try
    Self.calendar_date_time_picker.DateTime := Self.FDate_Time;
  except
    try
      Self.calendar_date_time_picker.DateTime := EncodeDate( 1601, 1, 1 ); // TDateTimePicker gives error 'Failed to set calendar date or time' if date is earlier than '01.01.1601'.
    except
      Self.calendar_date_time_picker.DateTime := 0;
    end;
  end;

end;

procedure TDate_Time_Picker.Enabled__Set( const enabled_f : boolean );
begin

  Self.FEnabled := enabled_f;


  Self.calendar_date_time_picker.Enabled := Self.FEnabled;
  Self.day_spin_edit.Enabled := Self.FEnabled;
  Self.hour_spin_edit.Enabled := Self.FEnabled;
  Self.milli_second_spin_edit.Enabled := Self.FEnabled;
  Self.minute_spin_edit.Enabled := Self.FEnabled;
  Self.month_spin_edit.Enabled := Self.FEnabled;
  Self.second_spin_edit.Enabled := Self.FEnabled;
  Self.year_spin_edit.Enabled := Self.FEnabled;

end;

function TDate_Time_Picker.Focused() : boolean;
begin

  if   ( Self.calendar_date_time_picker.Focused() )
    or ( Self.day_spin_edit.Focused() )
    or ( Self.hour_spin_edit.Focused() )
    or ( Self.milli_second_spin_edit.Focused() )
    or ( Self.minute_spin_edit.Focused() )
    or ( Self.month_spin_edit.Focused() )
    or ( Self.second_spin_edit.Focused() )
    or ( Self.year_spin_edit.Focused() ) then
    Result := true
  else
    Result := false;

end;

procedure TDate_Time_Picker.Exit_( Sender : TObject );
begin

  Self.Change( Sender );

end;

procedure TDate_Time_Picker.Key_Down( Sender : TObject; var Key : Word; Shift : System.Classes.TShiftState );

  procedure Spin_Edit__Set_Focus( const spin_edit_f : Interceptor__Spin_Edit.TSpinEdit );
  begin

    if   ( spin_edit_f = nil )
      or (  not ( spin_edit_f is Interceptor__Spin_Edit.TSpinEdit )  ) then
      Exit;


    spin_edit_f.SetFocus();
    spin_edit_f.SelLength := 0;

  end;

begin

  if Sender <> nil then
    begin

      if Key = Winapi.Windows.VK_LEFT then
        begin

          if   (
                     ( Sender is Interceptor__Spin_Edit.TSpinEdit )
                 and ( Interceptor__Spin_Edit.TSpinEdit(Sender).SelStart <= 0 )
               )
            or ( Sender is Vcl.ComCtrls.TDateTimePicker ) then
            begin

              if Sender = Self.day_spin_edit then
                begin

                  if Self.FKind in [ Vcl.ComCtrls.dtkDateTime, Vcl.ComCtrls.dtkTime ] then
                    Spin_Edit__Set_Focus( Self.milli_second_spin_edit )
                  else
                    Spin_Edit__Set_Focus( Self.year_spin_edit );

                end
              else
              if Sender = Self.month_spin_edit then
                Spin_Edit__Set_Focus( Self.day_spin_edit )
              else
              if Sender = Self.year_spin_edit then
                Spin_Edit__Set_Focus( Self.month_spin_edit )
              else
              if Sender = Self.hour_spin_edit then
                begin

                  if Self.FKind in [ Vcl.ComCtrls.dtkDate, Vcl.ComCtrls.dtkDateTime ] then
                    Spin_Edit__Set_Focus( Self.year_spin_edit )
                  else
                    Spin_Edit__Set_Focus( Self.milli_second_spin_edit );

                end
              else
              if Sender = Self.minute_spin_edit then
                Spin_Edit__Set_Focus( Self.hour_spin_edit )
              else
              if Sender = Self.second_spin_edit then
                Spin_Edit__Set_Focus( Self.minute_spin_edit )
              else
              if Sender = Self.milli_second_spin_edit then
                Spin_Edit__Set_Focus( Self.second_spin_edit )
              else
              if Sender = Self.calendar_date_time_picker then
                Spin_Edit__Set_Focus( Self.year_spin_edit );

            end;

        end
      else
      if Key = Winapi.Windows.VK_RETURN then
        Self.Change( Sender )
      else
      if Key = Winapi.Windows.VK_RIGHT then
        begin

          if   (
                     ( Sender is Interceptor__Spin_Edit.TSpinEdit )
                 and (  Interceptor__Spin_Edit.TSpinEdit(Sender).SelStart >= Length( Interceptor__Spin_Edit.TSpinEdit(Sender).Text )  )
               )
            or ( Sender is Vcl.ComCtrls.TDateTimePicker ) then
            begin

              if Sender = Self.day_spin_edit then
                Spin_Edit__Set_Focus( Self.month_spin_edit )
              else
              if Sender = Self.month_spin_edit then
                Spin_Edit__Set_Focus( Self.year_spin_edit )
              else
              if Sender = Self.year_spin_edit then
                begin

                  if Self.FKind in [ Vcl.ComCtrls.dtkDateTime ] then
                    Spin_Edit__Set_Focus( Self.hour_spin_edit )
                  else
                    Spin_Edit__Set_Focus( Self.day_spin_edit );

                end
              else
              if Sender = Self.hour_spin_edit then
                Spin_Edit__Set_Focus( Self.minute_spin_edit )
              else
              if Sender = Self.minute_spin_edit then
                Spin_Edit__Set_Focus( Self.second_spin_edit )
              else
              if Sender = Self.second_spin_edit then
                Spin_Edit__Set_Focus( Self.milli_second_spin_edit )
              else
              if Sender = Self.milli_second_spin_edit then
                begin

                  if Self.FKind in [ Vcl.ComCtrls.dtkDate, Vcl.ComCtrls.dtkDateTime ] then
                    Spin_Edit__Set_Focus( Self.day_spin_edit )
                  else
                    Spin_Edit__Set_Focus( Self.hour_spin_edit );

                end
              else
              if Sender = Self.calendar_date_time_picker then
                begin

                  if Self.FKind in [ Vcl.ComCtrls.dtkDateTime, Vcl.ComCtrls.dtkTime ] then
                    Spin_Edit__Set_Focus( Self.hour_spin_edit )
                  else
                    Spin_Edit__Set_Focus( Self.day_spin_edit );

                end;

            end;

        end;

    end;


  if @Self.OnKeyDown <> nil then
    Self.OnKeyDown( Sender, Key, Shift );

end;

procedure TDate_Time_Picker.Key_Press( Sender : TObject; var Key : Char );
var
  ztdt : TDateTime;
begin

  if    ( Self.FEnabled )
    and ( not Self.FRead_Only ) then
    begin

      if Key in [ '0'..'9' ] then
        begin

          // Self.Change() (and thousand separators) shifts SelStart (cursor position).

          Self.change__block := true;

          Interceptor__Spin_Edit.TSpinEdit(Sender).SelText := Key;

          Self.change__block := false;


          Key := #0;

        end;


      if    ( Key = ^V ) // Ctrl + V.
        and ( Sender <> nil )
        and ( Sender is Interceptor__Spin_Edit.TSpinEdit ) then
        begin

          Key := #0;


          if Length( Interceptor__Spin_Edit.TSpinEdit(Sender).SelText ) <= 0 then
            begin

              try
                ztdt := StrToDateTime( Vcl.Clipbrd.Clipboard.AsText, date_format );

                if Self.Kind = Vcl.ComCtrls.dtkDateTime then
                  Self.Date_Time := ztdt
                else
                if Self.Kind = Vcl.ComCtrls.dtkTime then
                  Self.Time := System.DateUtils.TimeOf( ztdt )
                else
                  Self.Date := System.DateUtils.DateOf( ztdt );


                Self.Change( Sender );
              except
                on E : Exception do
                  Application.MessageBox(  PChar(failed_to_paste_value_from_clipboard__translation + #13 + #13 + E.Message + ' ' + IntToStr( E.HelpContext )), PChar(error__translation), MB_OK + MB_ICONEXCLAMATION  );
              end;

            end
          else
            begin

              Self.change__block := true;

              Interceptor__Spin_Edit.TSpinEdit(Sender).SelText := Vcl.Clipbrd.Clipboard.AsText;

              Self.change__block := false;


              Self.Change( Sender );

            end;

        end;

    end;

end;

procedure TDate_Time_Picker.Key_Up( Sender : TObject; var Key : Word; Shift : System.Classes.TShiftState );
begin

  if @Self.OnKeyUp <> nil then
    Self.OnKeyUp( Sender, Key, Shift );

end;

procedure TDate_Time_Picker.Kind__Set( const kind_f : Vcl.ComCtrls.TDateTimeKind );
begin

  Self.FKind := kind_f;


  Self.date_panel.Visible := Self.FKind in [ Vcl.ComCtrls.dtkDate, Vcl.ComCtrls.dtkDateTime ];
  Self.time_panel.Visible := Self.FKind in [ Vcl.ComCtrls.dtkDateTime, Vcl.ComCtrls.dtkTime ];

  if Self.date_panel.Visible then
    begin

      Self.date_panel.Width := Self.date_panel__width;

      if Self.time_panel.Visible then
        Self.date_panel.Width := Self.date_panel.Width + 5;


      Self.time_panel.Left := Self.date_panel.Left + Self.date_panel.Width;


      Self.Width := Self.date_panel.Width;

      if Self.time_panel.Visible then
        Self.Width := Self.Width + Self.time_panel.Width;

    end
  else
    begin

      Self.time_panel.Left := 0;

      Self.Width := Self.time_panel.Width;

    end;

end;

procedure TDate_Time_Picker.Read_Only__Set( const read_only_f : boolean );
begin

  Self.FRead_Only := read_only_f;


  Self.calendar_date_time_picker.Enabled := not Self.FRead_Only;
  Self.day_spin_edit.ReadOnly := Self.FRead_Only;
  Self.hour_spin_edit.ReadOnly := Self.FRead_Only;
  Self.milli_second_spin_edit.ReadOnly := Self.FRead_Only;
  Self.minute_spin_edit.ReadOnly := Self.FRead_Only;
  Self.month_spin_edit.ReadOnly := Self.FRead_Only;
  Self.second_spin_edit.ReadOnly := Self.FRead_Only;
  Self.year_spin_edit.ReadOnly := Self.FRead_Only;

end;

procedure TDate_Time_Picker.Spin_Edits__Value__Set();
begin

  Self.change__block := true;


  Self.day_spin_edit.value := System.DateUtils.DayOf( Self.FDate_Time );
  Self.month_spin_edit.value := System.DateUtils.MonthOf( Self.FDate_Time );
  Self.year_spin_edit.value := System.DateUtils.YearOf( Self.FDate_Time );

  Self.hour_spin_edit.value := System.DateUtils.HourOf( Self.FDate_Time );
  Self.minute_spin_edit.value := System.DateUtils.MinuteOf( Self.FDate_Time );
  Self.second_spin_edit.value := System.DateUtils.SecondOf( Self.FDate_Time );

  Self.milli_second_spin_edit.value := System.DateUtils.MilliSecondOf( Self.FDate_Time );


  Self.change__block := false;

end;

function TDate_Time_Picker.Time__Get() : TTime;
begin

  Result := System.SysUtils.EncodeTime
    (
      System.DateUtils.HourOf( Self.FDate_Time ),
      System.DateUtils.MinuteOf( Self.FDate_Time ),
      System.DateUtils.SecondOf( Self.FDate_Time ),

      System.DateUtils.MilliSecondOf( Self.FDate_Time )
    );

end;

procedure TDate_Time_Picker.Time__Set( const time_f : TTime );
var
  ztdt : TDateTime;
begin

  ztdt := System.DateUtils.EncodeDateTime
    (
      System.DateUtils.YearOf( Self.FDate_Time ),
      System.DateUtils.MonthOf( Self.FDate_Time ),
      System.DateUtils.DayOf( Self.FDate_Time ),

      System.DateUtils.HourOf( time_f ),
      System.DateUtils.MinuteOf( time_f ),
      System.DateUtils.SecondOf( time_f ),

      System.DateUtils.MilliSecondOf( time_f )
    );


  Self.Date_Time__Set( ztdt );

end;

procedure TDate_Time_Picker.Translation__Apply__DTP();
begin

  Self.Calendar_Date_Time_Picker__Hint__Set();

end;

end.
