object Database__Informations_Modify_F_Frame: TDatabase__Informations_Modify_F_Frame
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
    object Log_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 146
      Width = 183
      Height = 6
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitLeft = -4
      ExplicitTop = 191
    end
    object Distance_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 1
      Width = 163
      Height = 30
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
    end
    object Log_Memo: TMemo
      AlignWithMargins = True
      Left = 11
      Top = 155
      Width = 163
      Height = 421
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
      Hint = 'Refresh.'#13#10#13#10'[Ctrl + R]'
      Anchors = [akTop, akRight]
      ImageIndex = 3
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Refresh_ButtonClick
      OnKeyUp = Key_Up_Common
    end
    object Search_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 11
      Top = 36
      Width = 163
      Height = 105
      Margins.Left = 10
      Margins.Top = 5
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
        Hint = 'Page down - search next;'#13#10'Page up - search prior.'
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnChange = Search_Change
        OnKeyDown = Search_EditKeyDown
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
    object Database_Description_Memo_Horizontal_Splitter: TSplitter
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
      OnKeyDown = Metadata_StringGridKeyDown
      OnKeyUp = Key_Up_Common
    end
    object Database_Description_GroupBox: TGroupBox
      Left = 1
      Top = 499
      Width = 447
      Height = 80
      Align = alBottom
      Caption = 'Database description'
      TabOrder = 1
      object Database_Description_Memo: TMemo
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
        OnKeyDown = Database_Description_MemoKeyDown
        OnKeyUp = Key_Up_Common
      end
    end
  end
  object Metadata_PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 535
    Top = 160
    object Database__Description__Set_MenuItem: TMenuItem
      Caption = 'Database description edit'
      ImageIndex = 1
      OnClick = Database__Description__Set_MenuItemClick
    end
    object Database__Description__Drop_MenuItem: TMenuItem
      Caption = 'Database description delete'
      ImageIndex = 2
      OnClick = Database__Description__Drop_MenuItemClick
    end
  end
end
