object Permissions_Modify_F_Frame: TPermissions_Modify_F_Frame
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
    object User_Name_Etiquette_Label: TLabel
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
      Caption = 'User name'
      ParentShowHint = False
      ShowHint = False
      ExplicitWidth = 56
    end
    object Log_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 454
      Width = 183
      Height = 6
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitTop = 469
    end
    object User_Name_DBEdit: TDBEdit
      AlignWithMargins = True
      Left = 11
      Top = 26
      Width = 163
      Height = 23
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      DataSource = Permissions_DataSource
      ReadOnly = True
      TabOrder = 0
      OnChange = User_Name_DBEditChange
    end
    object Search_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 11
      Top = 54
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
    object Modify_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 11
      Top = 164
      Width = 163
      Height = 285
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Modify'
      TabOrder = 3
      DesignSize = (
        163
        285)
      object Modify__Privileges_Name_Etiquette_Label: TLabel
        AlignWithMargins = True
        Left = 12
        Top = 76
        Width = 139
        Height = 15
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Privileges'
        ExplicitWidth = 50
      end
      object Modify__Permissions__Row_One_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 12
        Top = 22
        Width = 139
        Height = 17
        Hint = 'Show permissions in one row.'
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'One row'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 0
        OnClick = Refresh_ButtonClick
      end
      object Modify__Privileges_Name_CheckListBox: TCheckListBox
        AlignWithMargins = True
        Left = 12
        Top = 96
        Width = 139
        Height = 155
        Hint = 
          'Ctrl + A - select all'#13#10'Ctrl + I - invert selection'#13#10'Ctrl + N - u' +
          'nselect all'
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 15
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnKeyDown = Modify__Privileges_Name_CheckListBoxKeyDown
      end
      object Modify__Grant__All_Button: TButton
        Left = 45
        Top = 255
        Width = 25
        Height = 25
        Hint = 'Grant all privileges.'
        Anchors = [akLeft, akBottom]
        ImageIndex = 20
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        Visible = False
        OnClick = Modify__Grant__All_ButtonClick
      end
      object Modify__Revoke__All_Button: TButton
        Left = 125
        Top = 255
        Width = 25
        Height = 25
        Hint = 'Revoke all on all privileges.'#13#10#13#10'[Ctrl + Delete]'
        Anchors = [akRight, akBottom]
        ImageIndex = 11
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = Modify__Revoke__All_ButtonClick
      end
      object Modify__Permissions__Show_All_Users_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 12
        Top = 49
        Width = 139
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Show all users'
        TabOrder = 1
        OnClick = Refresh_ButtonClick
      end
      object Modify__Grant_Button: TButton
        Left = 10
        Top = 255
        Width = 25
        Height = 25
        Hint = 'Grant privileges.'
        Anchors = [akLeft, akBottom]
        ImageIndex = 0
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = Modify__Grant_ButtonClick
      end
      object Modify__Revoke_Button: TButton
        Left = 90
        Top = 255
        Width = 25
        Height = 25
        Hint = 'Revoke privileges.'
        Anchors = [akRight, akBottom]
        ImageIndex = 10
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = Modify__Revoke_ButtonClick
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
        TabOrder = 2
        OnClick = Refresh_ButtonClick
      end
    end
    object Log_Memo: TMemo
      AlignWithMargins = True
      Left = 11
      Top = 463
      Width = 163
      Height = 83
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
  end
  object Permissions_DBGrid: TDBGrid
    Left = 191
    Top = 0
    Width = 449
    Height = 580
    Align = alClient
    DataSource = Permissions_DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    PopupMenu = Permissions_PopupMenu
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = Permissions_DBGridDrawColumnCell
    OnKeyDown = Permissions_DBGridKeyDown
    OnKeyUp = Key_Up_Common
    OnTitleClick = Permissions_DBGridTitleClick
  end
  object Permissions_DataSource: TDataSource
    Left = 545
    Top = 45
  end
  object Permissions_PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 535
    Top = 160
    object Modify__Grant_MenuItem: TMenuItem
      Caption = 'Grant privileges'
      ImageIndex = 0
      OnClick = Modify__Grant_ButtonClick
    end
    object Modify__Grant__All_Button_MenuItem: TMenuItem
      Caption = 'Grant all privileges'
      ImageIndex = 20
      Visible = False
      OnClick = Modify__Grant__All_ButtonClick
    end
    object Modify__Revoke_MenuItem: TMenuItem
      Caption = 'Revoke privileges'
      ImageIndex = 10
      OnClick = Modify__Revoke_ButtonClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Modify__Revoke__All_MenuItem: TMenuItem
      Caption = 'Revoke all on all privileges'
      ImageIndex = 11
      OnClick = Modify__Revoke__All_ButtonClick
    end
  end
end
