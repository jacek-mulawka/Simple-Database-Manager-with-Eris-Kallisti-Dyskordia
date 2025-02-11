unit Class_Helper__Win_Control;{11.Lut.2025}

interface

uses
  System.Classes,
  Vcl.Controls;

type
  TWinControl_Helper = class helper for Vcl.Controls.TWinControl
    procedure SetChildOrder( Child : TComponent; Order : Integer );
  end;

implementation

procedure TWinControl_Helper.SetChildOrder( Child : TComponent; Order : Integer );
begin

  inherited SetChildOrder( Child, Order );

end;

end.

