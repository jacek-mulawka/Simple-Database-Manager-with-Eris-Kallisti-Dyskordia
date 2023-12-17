object Stored_Procedure_Modify_F_Frame: TStored_Procedure_Modify_F_Frame
  Left = 0
  Top = 0
  Width = 640
  Height = 480
  TabOrder = 0
  PixelsPerInch = 96
  object Stored_Procedure_Modify_PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 640
    Height = 480
    ActivePage = Edit_Execute_TabSheet
    Align = alClient
    TabOrder = 0
    OnChange = Stored_Procedure_Modify_PageControlChange
    object Edit_Execute_TabSheet: TTabSheet
      Caption = 'Edit execute'
    end
    object Dependencies_TabSheet: TTabSheet
      Caption = 'Dependencies'
      ImageIndex = 4
    end
    object Permissions_TabSheet: TTabSheet
      Caption = 'Permissions'
      ImageIndex = 5
    end
  end
end
