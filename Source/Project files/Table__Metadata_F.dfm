object Table__Metadata_F_Frame: TTable__Metadata_F_Frame
  Left = 0
  Top = 0
  Width = 640
  Height = 580
  TabOrder = 0
  PixelsPerInch = 96
  object Vertical_Splitter: TSplitter
    Left = 185
    Top = 0
    Width = 6
    Height = 580
    AutoSnap = False
    Color = clSkyBlue
    MinSize = 1
    ParentColor = False
    ExplicitLeft = 200
    ExplicitHeight = 442
  end
  object Buttons_Panel: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 580
    Align = alLeft
    TabOrder = 0
    DesignSize = (
      185
      580)
    object Owner_Etiquette_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 6
      Width = 163
      Height = 15
      Hint = 'Double-click - copy the table name to clipboard.'
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Owner'
      ParentShowHint = False
      ShowHint = True
      OnDblClick = Owner_Etiquette_LabelDblClick
      ExplicitWidth = 35
    end
    object Log_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 156
      Width = 183
      Height = 6
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitLeft = 3
      ExplicitTop = 191
    end
    object Owner_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 26
      Width = 163
      Height = 15
      Hint = 'Double-click - copy the owner name to clipboard.'
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = '<?>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnDblClick = Owner_LabelDblClick
      ExplicitWidth = 21
    end
    object Log_Memo: TMemo
      AlignWithMargins = True
      Left = 11
      Top = 165
      Width = 163
      Height = 411
      Margins.Left = 10
      Margins.Right = 10
      Align = alClient
      Anchors = [akLeft, akRight, akBottom]
      Lines.Strings = (
        'Log')
      ScrollBars = ssVertical
      TabOrder = 3
      OnKeyDown = Log_MemoKeyDown
      OnKeyUp = Key_Up_Common
    end
    object Buttons_Panel__Hide_Button: TButton
      Left = 155
      Top = 0
      Width = 25
      Height = 15
      Hint = 'Hide panel.'
      Anchors = [akTop, akRight]
      ImageIndex = 19
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Buttons_Panel__Hide_ButtonClick
    end
    object Refresh_Button: TButton
      Left = 110
      Top = 5
      Width = 25
      Height = 25
      Hint = 'Refresh.'
      Anchors = [akTop, akRight]
      ImageIndex = 3
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Refresh_ButtonClick
    end
    object Search_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 11
      Top = 46
      Width = 163
      Height = 105
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Search'
      TabOrder = 2
      DesignSize = (
        163
        105)
      object Search_Edit: TEdit
        AlignWithMargins = True
        Left = 12
        Top = 17
        Width = 139
        Height = 23
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        TabOrder = 0
        OnChange = Search_Change
      end
      object Search__Case_Insensitive_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 12
        Top = 50
        Width = 139
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Case insensitive'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = Search_Change
      end
      object Search__Partial_Key_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 12
        Top = 77
        Width = 139
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Partial key'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = Search_Change
      end
      object Search__Prior_Button: TButton
        Left = 125
        Top = 45
        Width = 25
        Height = 25
        Hint = 'Search prior.'
        Anchors = [akTop, akRight]
        ImageIndex = 13
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Search__Prior_ButtonClick
      end
      object Search__Next_Button: TButton
        Left = 125
        Top = 70
        Width = 25
        Height = 25
        Hint = 'Search next.'
        Anchors = [akTop, akRight]
        ImageIndex = 14
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = Search__Next_ButtonClick
      end
    end
  end
  object Metadata_Panel: TPanel
    Left = 191
    Top = 0
    Width = 449
    Height = 580
    Align = alClient
    TabOrder = 1
    object Table_Description_Memo_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 493
      Width = 447
      Height = 6
      Cursor = crVSplit
      Align = alBottom
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitTop = 1
    end
    object Metadata_StringGrid: TStringGrid
      Left = 1
      Top = 1
      Width = 447
      Height = 492
      Align = alClient
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowMoving, goFixedRowDefAlign]
      PopupMenu = Metadata_PopupMenu
      TabOrder = 0
      OnDrawCell = Metadata_StringGridDrawCell
      OnKeyDown = Metadata_StringGridKeyDown
      OnKeyUp = Key_Up_Common
    end
    object Table_Description_GroupBox: TGroupBox
      Left = 1
      Top = 499
      Width = 447
      Height = 80
      Align = alBottom
      Caption = 'Table description'
      TabOrder = 1
      object Table_Description_Memo: TMemo
        AlignWithMargins = True
        Left = 12
        Top = 20
        Width = 423
        Height = 55
        Margins.Left = 10
        Margins.Right = 10
        Align = alClient
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        OnKeyDown = Table_Description_MemoKeyDown
        OnKeyUp = Key_Up_Common
      end
    end
  end
  object Metadata_PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 535
    Top = 160
    object Column__Add_MenuItem: TMenuItem
      Caption = 'Column add [Insert]'
      ImageIndex = 20
      OnClick = Column__Add_MenuItemClick
    end
    object Column__Delete_MenuItem: TMenuItem
      Caption = 'Column delete [Delete]'
      ImageIndex = 2
      OnClick = Column__Delete_MenuItemClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Column__Name_Edit_MenuItem: TMenuItem
      Caption = 'Column name edit [Ctrl + Enter]'
      ImageIndex = 1
      OnClick = Column__Name_Edit_MenuItemClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Column__Type_Edit_MenuItem: TMenuItem
      Caption = 'Column type edit [Enter]'
      ImageIndex = 1
      OnClick = Column__Type_Edit_MenuItemClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Column__Default_Value__Set_MenuItem: TMenuItem
      Caption = 'Column default value edit'
      ImageIndex = 1
      OnClick = Column__Default_Value__Set_MenuItemClick
    end
    object Column__Default_Value__Drop_MenuItem: TMenuItem
      Caption = 'Column default value delete'
      ImageIndex = 2
      OnClick = Column__Default_Value__Drop_MenuItemClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Column__Description__Set_MenuItem: TMenuItem
      Caption = 'Column description edit'
      ImageIndex = 1
      OnClick = Column__Description__Set_MenuItemClick
    end
    object Column__Description__Drop_MenuItem: TMenuItem
      Caption = 'Column description delete'
      ImageIndex = 2
      OnClick = Column__Description__Drop_MenuItemClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Column__Description__Write_In_Log_MenuItem: TMenuItem
      Caption = 'Column description write in log'
      ImageIndex = 15
      OnClick = Column__Description__Write_In_Log_MenuItemClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object Column__Not_Null__Add_MenuItem: TMenuItem
      Caption = 'Column not null add'
      ImageIndex = 0
      OnClick = Column__Not_Null__Add_MenuItemClick
    end
    object Column__Not_Null__Delete_MenuItem: TMenuItem
      Caption = 'Column not null delete'
      ImageIndex = 2
      OnClick = Column__Not_Null__Delete_MenuItemClick
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object Table__Description__Set_MenuItem: TMenuItem
      Caption = 'Table description edit'
      ImageIndex = 1
      OnClick = Table__Description__Set_MenuItemClick
    end
    object Table__Description__Drop_MenuItem: TMenuItem
      Caption = 'Table description delete'
      ImageIndex = 2
      OnClick = Table__Description__Drop_MenuItemClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object Table__Primary_Key_Set_MenuItem: TMenuItem
      Caption = 'Table primary key set'
      ImageIndex = 0
      OnClick = Table__Primary_Key_Set_MenuItemClick
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object Metadata__Write_In_Log_MenuItem: TMenuItem
      Caption = 'Metadata write in log'
      ImageIndex = 15
      OnClick = Metadata__Write_In_Log_MenuItemClick
    end
    object Metadata__Write_In_Log__As_Create_Table_MenuItem: TMenuItem
      Caption = 'Metadata write in log as create table'
      ImageIndex = 15
      OnClick = Metadata__Write_In_Log__As_Create_Table_MenuItemClick
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object Table_Column__Values_Distinct_MenuItem: TMenuItem
      Caption = 'Column distinct values'
      ImageIndex = 34
      OnClick = Table_Column__Values_Distinct_MenuItemClick
    end
  end
end
