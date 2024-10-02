object Generators_Modify_F_Frame: TGenerators_Modify_F_Frame
  Left = 0
  Top = 0
  Width = 640
  Height = 600
  TabOrder = 0
  PixelsPerInch = 96
  object Vertical_Splitter: TSplitter
    Left = 185
    Top = 0
    Width = 6
    Height = 600
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
    Height = 600
    Align = alLeft
    TabOrder = 0
    DesignSize = (
      185
      600)
    object Record_Number__Records_Count_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 574
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
    object Generator_Name_Etiquette_Label: TLabel
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
      Caption = 'Generator name'
      ParentShowHint = False
      ShowHint = False
      ExplicitWidth = 85
    end
    object Log_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 519
      Width = 183
      Height = 6
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitTop = 364
    end
    object Generator_Name_DBEdit: TDBEdit
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
      DataSource = Generators_DataSource
      ReadOnly = True
      TabOrder = 0
      OnChange = Generator_Name_DBEditChange
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
      Height = 160
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Modify'
      TabOrder = 2
      DesignSize = (
        163
        160)
      object Modify__Value_Etiquette_Label: TLabel
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
        Caption = 'Value'
        ExplicitWidth = 29
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
      object Modify__Value_SpinEdit: TSpinEdit
        AlignWithMargins = True
        Left = 12
        Top = 95
        Width = 139
        Height = 24
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 0
        OnKeyDown = Modify__Value_SpinEditKeyDown
      end
      object Modify__Add_Button: TButton
        Left = 10
        Top = 125
        Width = 25
        Height = 25
        Hint = 'Add new generator <name>.'
        ImageIndex = 0
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Modify__Add_ButtonClick
      end
      object Modify__Edit_Button: TButton
        Left = 45
        Top = 125
        Width = 25
        Height = 25
        Hint = 'Set <value> to selected generators.'#13#10#13#10'[Enter]'
        ImageIndex = 1
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = Modify__Edit_ButtonClick
      end
      object Modify__Delete_Button: TButton
        Left = 120
        Top = 125
        Width = 25
        Height = 25
        Hint = 'Delete selected generator.'#13#10#13#10'[Delete]'
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
      object Modify__Values_Fields__Update_CheckBox: TCheckBox
        Left = 75
        Top = 130
        Width = 45
        Height = 17
        Hint = 'Update value in the value field.'
        Caption = 'V. u.'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 5
      end
    end
    object Log_Memo: TMemo
      AlignWithMargins = True
      Left = 11
      Top = 528
      Width = 163
      Height = 38
      Margins.Left = 10
      Margins.Right = 10
      Align = alClient
      Lines.Strings = (
        'Log')
      ScrollBars = ssVertical
      TabOrder = 4
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
      TabOrder = 5
      OnClick = Buttons_Panel__Hide_ButtonClick
    end
    object Permissions_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 11
      Top = 329
      Width = 163
      Height = 185
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Permissions'
      TabOrder = 3
      DesignSize = (
        163
        185)
      object Permissions__User_Names_Etiquette_Label: TLabel
        AlignWithMargins = True
        Left = 12
        Top = 22
        Width = 139
        Height = 15
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Users'
        ExplicitWidth = 28
      end
      object Permissions__User_Names_CheckListBox: TCheckListBox
        AlignWithMargins = True
        Left = 12
        Top = 42
        Width = 139
        Height = 110
        Hint = 
          'Ctrl + A - select all'#13#10'Ctrl + I - invert selection'#13#10'Ctrl + N - u' +
          'nselect all'#13#10'Ctrl + R - refresh'#13#10'Ctrl + Enter - users filter can' +
          'cel'#13#10'Enter - users filter apply '
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 15
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnKeyDown = Permissions__User_Names_CheckListBoxKeyDown
      end
      object Permissions__Grant_Button: TButton
        Left = 10
        Top = 155
        Width = 25
        Height = 25
        Hint = 'Grant permission.'
        Anchors = [akLeft, akBottom]
        ImageIndex = 0
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Permissions__Grant_ButtonClick
      end
      object Permissions__Revoke_Button: TButton
        Left = 45
        Top = 155
        Width = 25
        Height = 25
        Hint = 'Revoke permission.'
        Anchors = [akLeft, akBottom]
        ImageIndex = 10
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Permissions__Revoke_ButtonClick
      end
      object Permissions__Refresh_Button: TButton
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
        OnClick = Permissions__Refresh_ButtonClick
      end
      object Permissions__Filter__Users__Apply_Button: TButton
        Left = 90
        Top = 155
        Width = 25
        Height = 25
        Hint = 'Users filter apply.'
        Anchors = [akRight, akBottom]
        ImageIndex = 4
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = Permissions__Filter__Users__Apply_ButtonClick
      end
      object Permissions__Filter__Users__Cancel_Button: TButton
        Left = 125
        Top = 155
        Width = 25
        Height = 25
        Hint = 'Users filter cancel.'
        Anchors = [akRight, akBottom]
        ImageIndex = 2
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = Permissions__Filter__Users__Cancel_ButtonClick
      end
    end
  end
  object Generators_DBGrid: TDBGrid
    Left = 191
    Top = 0
    Width = 449
    Height = 600
    Align = alClient
    DataSource = Generators_DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    PopupMenu = Generators_PopupMenu
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = Generators_DBGridDrawColumnCell
    OnKeyDown = Generators_DBGridKeyDown
    OnTitleClick = Generators_DBGridTitleClick
  end
  object Generators_DataSource: TDataSource
    Left = 545
    Top = 45
  end
  object Generators_PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 535
    Top = 160
    object Generator__Delete_MenuItem: TMenuItem
      Caption = 'Delete'
      ImageIndex = 2
      OnClick = Modify__Delete_ButtonClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Generator__Description__Set_MenuItem: TMenuItem
      Caption = 'Description edit'
      ImageIndex = 1
      OnClick = Generator__Description__Set_MenuItemClick
    end
    object Generator__Description__Drop_MenuItem: TMenuItem
      Caption = 'Description delete'
      ImageIndex = 2
      OnClick = Generator__Description__Drop_MenuItemClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Generator__Description__Write_In_Log_MenuItem: TMenuItem
      Caption = 'Generator description write in log'
      ImageIndex = 15
      OnClick = Generator__Description__Write_In_Log_MenuItemClick
    end
  end
end
