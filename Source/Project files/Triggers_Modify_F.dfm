object Triggers_Modify_F_Frame: TTriggers_Modify_F_Frame
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
    object Record_Number__Records_Count_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 554
      Width = 163
      Height = 15
      Hint = 'Record number / records count.'
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alBottom
      Caption = '<?> / <?>'
      ParentShowHint = False
      ShowHint = True
      ExplicitWidth = 53
    end
    object Trigger_Name_Etiquette_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 6
      Width = 163
      Height = 15
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Trigger name'
      ParentShowHint = False
      ShowHint = False
      ExplicitWidth = 71
    end
    object Caret_Position_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 534
      Width = 163
      Height = 15
      Hint = 'Caret position, text length.'
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alBottom
      Caption = '<?> / <?> : <?>'
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
      ExplicitWidth = 83
    end
    object Log_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 219
      Width = 183
      Height = 6
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
    end
    object Trigger_Name_DBEdit: TDBEdit
      AlignWithMargins = True
      Left = 11
      Top = 26
      Width = 163
      Height = 23
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      DataSource = Triggers_DataSource
      ReadOnly = True
      TabOrder = 0
      OnChange = Trigger_Name_DBEditChange
      OnKeyUp = Key_Up_Common
    end
    object Search_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 11
      Top = 54
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
    object Log_Memo: TMemo
      AlignWithMargins = True
      Left = 11
      Top = 228
      Width = 163
      Height = 303
      Margins.Left = 10
      Margins.Right = 10
      Align = alClient
      Anchors = [akLeft, akRight, akBottom]
      Lines.Strings = (
        'Log')
      ScrollBars = ssVertical
      TabOrder = 4
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
    object Modify_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 11
      Top = 164
      Width = 163
      Height = 50
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Modify'
      TabOrder = 3
      DesignSize = (
        163
        50)
      object Modify__Add_Button: TButton
        Left = 10
        Top = 20
        Width = 25
        Height = 25
        Hint = 'Add new trigger.'#13#10#13#10'[Insert]'
        ImageIndex = 0
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = Modify__Add_ButtonClick
      end
      object Modify__Delete_Button: TButton
        Left = 85
        Top = 20
        Width = 25
        Height = 25
        Hint = 'Delete selected trigger.'#13#10#13#10'[Delete]'
        ImageIndex = 2
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Modify__Delete_ButtonClick
      end
      object Refresh_Button: TButton
        Left = 125
        Top = 20
        Width = 25
        Height = 25
        Hint = 'Refresh.'#13#10#13#10'[Ctrl + R]'
        Anchors = [akTop, akRight]
        ImageIndex = 3
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Refresh_ButtonClick
      end
      object Modify__Edit_Button: TButton
        Left = 45
        Top = 20
        Width = 25
        Height = 25
        Hint = 'Edit selected trigger.'#13#10#13#10'[Enter]'
        ImageIndex = 1
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Modify__Edit_ButtonClick
      end
    end
  end
  object Triggers_Panel: TPanel
    Left = 191
    Top = 0
    Width = 449
    Height = 580
    Align = alClient
    TabOrder = 1
    object Trigger_Source_Memo_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 173
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
    object Triggers_DBGrid: TDBGrid
      Left = 1
      Top = 1
      Width = 447
      Height = 172
      Align = alClient
      DataSource = Triggers_DataSource
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      PopupMenu = Triggers_PopupMenu
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDrawColumnCell = Triggers_DBGridDrawColumnCell
      OnKeyDown = Triggers_DBGridKeyDown
      OnKeyUp = Key_Up_Common
      OnTitleClick = Triggers_DBGridTitleClick
    end
    object Trigger_Source_GroupBox: TGroupBox
      Left = 1
      Top = 179
      Width = 447
      Height = 400
      Align = alBottom
      Caption = 'Trigger source'
      TabOrder = 1
      object Trigger_Source_DBMemo: TDBMemo
        Left = 2
        Top = 17
        Width = 200
        Height = 150
        DataSource = Triggers_DataSource
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
        Visible = False
        OnClick = Trigger_Source_DBMemoClick
        OnKeyUp = Trigger_Source_DBMemoKeyUp
      end
      object Trigger_Source_SynEdit: TSynEdit
        Left = 2
        Top = 17
        Width = 443
        Height = 381
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        TabOrder = 1
        OnClick = Trigger_Source_SynEditClick
        OnEnter = Trigger_Source_SynEditEnter
        OnKeyDown = Trigger_Source_SynEditKeyDown
        OnKeyUp = Trigger_Source_SynEditKeyUp
        UseCodeFolding = False
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Consolas'
        Gutter.Font.Style = []
        Gutter.ShowLineNumbers = True
        Gutter.Bands = <
          item
            Kind = gbkMarks
            Width = 13
          end
          item
            Kind = gbkLineNumbers
          end
          item
            Kind = gbkFold
          end
          item
            Kind = gbkTrackChanges
          end
          item
            Kind = gbkMargin
            Width = 3
          end>
        Options = [eoAutoIndent, eoDisableScrollArrows, eoDragDropEditing, eoDropFiles, eoEnhanceHomeKey, eoEnhanceEndKey, eoGroupUndo, eoHideShowScrollbars, eoKeepCaretX, eoShowScrollHint, eoSmartTabDelete, eoTabIndent, eoTabsToSpaces, eoShowLigatures, eoCopyPlainText]
        ReadOnly = True
        RightEdge = 255
        SelectedColor.Alpha = 0.400000005960464500
        TabWidth = 2
        WantTabs = True
        OnReplaceText = Trigger_Source_SynEditReplaceText
      end
    end
  end
  object Triggers_DataSource: TDataSource
    Left = 545
    Top = 45
  end
  object Triggers_PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 535
    Top = 160
    object Trigger__Add_MenuItem: TMenuItem
      Caption = 'Add'
      ImageIndex = 0
      OnClick = Modify__Add_ButtonClick
    end
    object Trigger__Edit_MenuItem: TMenuItem
      Caption = 'Edit'
      ImageIndex = 1
      OnClick = Modify__Edit_ButtonClick
    end
    object Trigger__Delete_MenuItem: TMenuItem
      Caption = 'Delete'
      ImageIndex = 2
      OnClick = Modify__Delete_ButtonClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Trigger__Description__Set_MenuItem: TMenuItem
      Caption = 'Description edit'
      ImageIndex = 1
      OnClick = Trigger__Description__Set_MenuItemClick
    end
    object Trigger__Description__Drop_MenuItem: TMenuItem
      Caption = 'Description delete'
      ImageIndex = 2
      OnClick = Trigger__Description__Drop_MenuItemClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Trigger__Description__Write_In_Log_MenuItem: TMenuItem
      Caption = 'Trigger description write in log'
      ImageIndex = 15
      OnClick = Trigger__Description__Write_In_Log_MenuItemClick
    end
  end
end
