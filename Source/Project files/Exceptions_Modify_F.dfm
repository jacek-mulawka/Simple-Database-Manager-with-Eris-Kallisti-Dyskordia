object Exceptions_Modify_F_Frame: TExceptions_Modify_F_Frame
  Left = 0
  Top = 0
  Width = 640
  Height = 480
  TabOrder = 0
  PixelsPerInch = 96
  object Vertical_Splitter: TSplitter
    Left = 185
    Top = 0
    Width = 6
    Height = 480
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
    Height = 480
    Align = alLeft
    TabOrder = 0
    DesignSize = (
      185
      480)
    object Record_Number__Records_Count_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 454
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
    object Exception_Name_Etiquette_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 6
      Width = 163
      Height = 15
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 10
      Align = alTop
      Caption = 'Exception name'
      ParentShowHint = False
      ShowHint = False
      ExplicitWidth = 84
    end
    object Log_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 354
      Width = 183
      Height = 6
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitTop = 369
    end
    object Exception_Name_DBEdit: TDBEdit
      AlignWithMargins = True
      Left = 11
      Top = 31
      Width = 163
      Height = 23
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      DataSource = Exceptions_DataSource
      ReadOnly = True
      TabOrder = 0
      OnChange = Exception_Name_DBEditChange
    end
    object Search_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 11
      Top = 64
      Width = 163
      Height = 105
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Search'
      TabOrder = 1
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
    object Modify_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 11
      Top = 174
      Width = 163
      Height = 175
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Modify'
      TabOrder = 2
      DesignSize = (
        163
        175)
      object Modify__Message_Etiquette_Label: TLabel
        AlignWithMargins = True
        Left = 12
        Top = 75
        Width = 139
        Height = 15
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Message'
        ExplicitWidth = 46
      end
      object Modify__Name_Etiquette_Label: TLabel
        AlignWithMargins = True
        Left = 12
        Top = 27
        Width = 139
        Height = 15
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Name'
        ExplicitWidth = 32
      end
      object Modify__Name_Edit: TEdit
        AlignWithMargins = True
        Left = 12
        Top = 47
        Width = 139
        Height = 23
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        TabOrder = 1
      end
      object Modify__Add_Button: TButton
        Left = 10
        Top = 145
        Width = 25
        Height = 25
        Hint = 'Add new exception <name> <message>.'
        Anchors = [akLeft, akBottom]
        ImageIndex = 0
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Modify__Add_ButtonClick
      end
      object Modify__Edit_Button: TButton
        Left = 45
        Top = 145
        Width = 25
        Height = 25
        Hint = 'Set <message> to selected exception.'#13#10#13#10'[Enter]'
        Anchors = [akLeft, akBottom]
        ImageIndex = 1
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = Modify__Edit_ButtonClick
      end
      object Modify__Delete_Button: TButton
        Left = 125
        Top = 145
        Width = 25
        Height = 25
        Hint = 'Delete selected exception.'#13#10#13#10'[Delete]'
        Anchors = [akLeft, akBottom]
        ImageIndex = 2
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = Modify__Delete_ButtonClick
      end
      object Refresh_Button: TButton
        Left = 125
        Top = 15
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
      end
      object Modify__Message_Memo: TMemo
        AlignWithMargins = True
        Left = 10
        Top = 95
        Width = 140
        Height = 45
        Anchors = [akLeft, akTop, akRight, akBottom]
        ScrollBars = ssVertical
        TabOrder = 2
        OnKeyDown = Modify__Message_MemoKeyDown
      end
      object Modify__Message_Memo__Update_CheckBox: TCheckBox
        Left = 75
        Top = 150
        Width = 45
        Height = 17
        Hint = 'Update text in the message memo.'
        Anchors = [akLeft, akBottom]
        Caption = 'M. u.'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 5
        OnClick = Exception_Name_DBEditChange
      end
    end
    object Log_Memo: TMemo
      AlignWithMargins = True
      Left = 11
      Top = 363
      Width = 163
      Height = 83
      Margins.Left = 10
      Margins.Right = 10
      Align = alClient
      Lines.Strings = (
        'Log')
      ScrollBars = ssVertical
      TabOrder = 3
      OnKeyDown = Log_MemoKeyDown
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
      TabOrder = 4
      OnClick = Buttons_Panel__Hide_ButtonClick
    end
  end
  object Exceptions_DBGrid: TDBGrid
    Left = 191
    Top = 0
    Width = 449
    Height = 480
    Align = alClient
    DataSource = Exceptions_DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = Exceptions_PopupMenu
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = Exceptions_DBGridDrawColumnCell
    OnKeyDown = Exceptions_DBGridKeyDown
    OnTitleClick = Exceptions_DBGridTitleClick
  end
  object Exceptions_DataSource: TDataSource
    Left = 545
    Top = 45
  end
  object Exceptions_PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 535
    Top = 160
    object Exception__Delete_MenuItem: TMenuItem
      Caption = 'Delete'
      ImageIndex = 2
      OnClick = Modify__Delete_ButtonClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Exception__Description__Set_MenuItem: TMenuItem
      Caption = 'Description edit'
      ImageIndex = 1
      OnClick = Exception__Description__Set_MenuItemClick
    end
    object Exception__Description__Drop_MenuItem: TMenuItem
      Caption = 'Description delete'
      ImageIndex = 2
      OnClick = Exception__Description__Drop_MenuItemClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Exception__Description__Write_In_Log_MenuItem: TMenuItem
      Caption = 'Exception description write in log'
      ImageIndex = 15
      OnClick = Exception__Description__Write_In_Log_MenuItemClick
    end
    object Exception__Message__Write_In_Log_MenuItem: TMenuItem
      Caption = 'Exception message write in log'
      ImageIndex = 15
      OnClick = Exception__Message__Write_In_Log_MenuItemClick
    end
  end
end
