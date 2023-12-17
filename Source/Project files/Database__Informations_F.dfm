object Database__Informations_F_Frame: TDatabase__Informations_F_Frame
  Left = 0
  Top = 0
  Width = 640
  Height = 480
  TabOrder = 0
  PixelsPerInch = 96
  object Database__Informations_PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 640
    Height = 480
    ActivePage = Informations_TabSheet
    Align = alClient
    TabOrder = 0
    OnChange = Database__Informations_PageControlChange
    object Informations_TabSheet: TTabSheet
      Caption = 'Informations'
    end
    object Triggers_TabSheet: TTabSheet
      Caption = 'Triggers'
      ImageIndex = 6
    end
  end
end
