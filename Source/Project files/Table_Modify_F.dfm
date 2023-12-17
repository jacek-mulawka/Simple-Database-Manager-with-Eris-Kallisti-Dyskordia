object Table_Modify_F_Frame: TTable_Modify_F_Frame
  Left = 0
  Top = 0
  Width = 640
  Height = 480
  TabOrder = 0
  PixelsPerInch = 96
  object Table_Modify_PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 640
    Height = 480
    ActivePage = Triggers_TabSheet
    Align = alClient
    TabOrder = 0
    OnChange = Table_Modify_PageControlChange
    object Data_TabSheet: TTabSheet
      Caption = 'Data'
    end
    object Indexes_TabSheet: TTabSheet
      Caption = 'Indexes'
      ImageIndex = 1
    end
    object Metadata_TabSheet: TTabSheet
      Caption = 'Metadata'
      ImageIndex = 2
    end
    object Columns_Sort_TabSheet: TTabSheet
      Caption = 'Columns sort'
      ImageIndex = 3
    end
    object Dependencies_TabSheet: TTabSheet
      Caption = 'Dependencies'
      ImageIndex = 4
    end
    object Permissions_TabSheet: TTabSheet
      Caption = 'Permissions'
      ImageIndex = 5
    end
    object Triggers_TabSheet: TTabSheet
      Caption = 'Triggers'
      ImageIndex = 6
    end
  end
end
