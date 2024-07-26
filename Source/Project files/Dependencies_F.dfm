object Dependencies_F_Frame: TDependencies_F_Frame
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
  object Left_Panel: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 580
    Align = alLeft
    TabOrder = 0
    object Log_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 241
      Width = 183
      Height = 6
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitLeft = -14
      ExplicitTop = 96
    end
    object Log_Memo: TMemo
      AlignWithMargins = True
      Left = 11
      Top = 250
      Width = 163
      Height = 326
      Margins.Left = 10
      Margins.Right = 10
      Align = alClient
      Lines.Strings = (
        'Log')
      ScrollBars = ssVertical
      TabOrder = 1
      OnKeyDown = Log_MemoKeyDown
      OnKeyUp = Key_Up_Common
    end
    object Buttons_Panel: TPanel
      Left = 1
      Top = 1
      Width = 183
      Height = 240
      Align = alTop
      TabOrder = 0
      DesignSize = (
        183
        240)
      object Dependencies_Type_RadioGroup: TRadioGroup
        AlignWithMargins = True
        Left = 11
        Top = 31
        Width = 161
        Height = 70
        Margins.Left = 10
        Margins.Top = 30
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Type'
        ItemIndex = 0
        Items.Strings = (
          'Dependent objects'
          'Depended on objects')
        TabOrder = 4
        OnClick = Refresh_ButtonClick
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
        TabOrder = 2
        OnClick = Refresh_ButtonClick
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
        TabOrder = 3
        OnClick = Buttons_Panel__Hide_ButtonClick
      end
      object Nodes__Expand_Button: TButton
        Left = 5
        Top = 5
        Width = 25
        Height = 25
        Hint = 'Expand  nodes.'
        ImageIndex = 14
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = Nodes__Expand_ButtonClick
      end
      object Nodes__Collapse_Button: TButton
        Left = 35
        Top = 5
        Width = 25
        Height = 25
        Hint = 'Collapse nodes.'
        ImageIndex = 13
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Nodes__Collapse_ButtonClick
      end
      object Search_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 11
        Top = 106
        Width = 161
        Height = 130
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Search'
        TabOrder = 5
        DesignSize = (
          161
          130)
        object Search_Edit: TEdit
          AlignWithMargins = True
          Left = 12
          Top = 17
          Width = 137
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
          Width = 137
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
          Width = 137
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
          Left = 123
          Top = 45
          Width = 25
          Height = 25
          Hint = 'Search prior.'
          Anchors = [akTop, akRight]
          ImageIndex = 13
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = Search__Prior_ButtonClick
        end
        object Search__Next_Button: TButton
          Left = 123
          Top = 70
          Width = 25
          Height = 25
          Hint = 'Search next.'
          Anchors = [akTop, akRight]
          ImageIndex = 14
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = Search__Next_ButtonClick
        end
        object Search__Set_Focus_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 12
          Top = 104
          Width = 137
          Height = 17
          Hint = 'Set the focus on the tree when searching.'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Set focus'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
      end
    end
  end
  object Table_Description_Panel: TPanel
    Left = 191
    Top = 0
    Width = 449
    Height = 580
    Align = alClient
    TabOrder = 1
    object Dependencies_Description_Memo_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 483
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
    object Dependencies_TreeView: TTreeView
      Left = 1
      Top = 1
      Width = 447
      Height = 482
      Align = alClient
      Indent = 19
      ReadOnly = True
      TabOrder = 0
      OnChange = Dependencies_TreeViewChange
      OnClick = Dependencies_TreeViewClick
      OnKeyDown = Dependencies_TreeViewKeyDown
      OnKeyUp = Key_Up_Common
    end
    object Dependencies_Description_GroupBox: TGroupBox
      Left = 1
      Top = 489
      Width = 447
      Height = 90
      Align = alBottom
      Caption = 'Dependencies description'
      TabOrder = 1
      object Dependencies_Description_Memo: TMemo
        AlignWithMargins = True
        Left = 12
        Top = 20
        Width = 423
        Height = 65
        Margins.Left = 10
        Margins.Right = 10
        Align = alClient
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        OnKeyDown = Dependencies_Description_MemoKeyDown
      end
    end
  end
end
