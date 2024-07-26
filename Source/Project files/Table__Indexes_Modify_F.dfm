object Table__Indexes_Modify_F_Frame: TTable__Indexes_Modify_F_Frame
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
    object Index_Name_Etiquette_Label: TLabel
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
      Caption = 'Index name'
      ParentShowHint = False
      ShowHint = False
      ExplicitWidth = 61
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
    object Index_Name_DBEdit: TDBEdit
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
      DataSource = Indexes_DataSource
      ReadOnly = True
      TabOrder = 0
      OnChange = Index_Name_DBEditChange
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
    object Modify_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 11
      Top = 164
      Width = 163
      Height = 285
      Hint = 'Create default index name.'
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
      object Modify__Parameter_Additional_Etiquette_Label: TLabel
        AlignWithMargins = True
        Left = 12
        Top = 85
        Width = 139
        Height = 15
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Additional parameter'
        ExplicitWidth = 112
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
      object Modify__Columns_Name_Etiquette_Label: TLabel
        AlignWithMargins = True
        Left = 12
        Top = 143
        Width = 139
        Height = 15
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Columns'
        ExplicitWidth = 48
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
        TabOrder = 2
      end
      object Modify__Add_Button: TButton
        Left = 10
        Top = 255
        Width = 25
        Height = 25
        Hint = 'Add new index <name>.'
        Anchors = [akLeft, akBottom]
        ImageIndex = 0
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = Modify__Add_ButtonClick
      end
      object Modify__Delete_Button: TButton
        Left = 120
        Top = 255
        Width = 25
        Height = 25
        Hint = 'Delete selected index.'#13#10#13#10'[Delete]'
        Anchors = [akLeft, akBottom]
        ImageIndex = 2
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        OnClick = Modify__Delete_ButtonClick
      end
      object Refresh_Button: TButton
        Left = 125
        Top = 15
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
      object Modify__Parameter_Additional_ComboBox: TComboBox
        AlignWithMargins = True
        Left = 12
        Top = 105
        Width = 139
        Height = 23
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        DropDownCount = 40
        TabOrder = 3
      end
      object Modify__Columns_Name_CheckListBox: TCheckListBox
        AlignWithMargins = True
        Left = 12
        Top = 163
        Width = 139
        Height = 85
        Hint = 
          'Enter - add new index'#13#10'Ctrl + A - select all'#13#10'Ctrl + D - create ' +
          'default index name'#13#10'Ctrl + I - invert selection'#13#10'Ctrl + N - unse' +
          'lect all'
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Anchors = [akLeft, akTop, akRight, akBottom]
        ItemHeight = 15
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnKeyDown = Modify__Columns_Name_CheckListBoxKeyDown
      end
      object Modify__Columns_Name__Hide_Indexed_CheckBox: TCheckBox
        Left = 105
        Top = 140
        Width = 97
        Height = 17
        Hint = 'Hide indexed columns.'
        Anchors = [akTop, akRight]
        Caption = 'Hide'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 4
        OnClick = Refresh_ButtonClick
      end
      object Modify__Name__Create_Default_Button: TButton
        Left = 90
        Top = 15
        Width = 25
        Height = 25
        Hint = 'Create default index name.'
        Anchors = [akTop, akRight]
        Caption = 'D.'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Modify__Name__Create_Default_ButtonClick
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
  object Indexes_DBGrid: TDBGrid
    Left = 191
    Top = 0
    Width = 449
    Height = 580
    Align = alClient
    DataSource = Indexes_DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = Indexes_PopupMenu
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = Indexes_DBGridDrawColumnCell
    OnKeyDown = Indexes_DBGridKeyDown
    OnKeyUp = Key_Up_Common
    OnTitleClick = Indexes_DBGridTitleClick
  end
  object Indexes_DataSource: TDataSource
    Left = 545
    Top = 45
  end
  object Indexes_PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 535
    Top = 160
    object Index__Delete_MenuItem: TMenuItem
      Caption = 'Delete'
      ImageIndex = 2
      OnClick = Modify__Delete_ButtonClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Index__Description__Set_MenuItem: TMenuItem
      Caption = 'Description edit'
      ImageIndex = 1
      OnClick = Index__Description__Set_MenuItemClick
    end
    object Index__Description__Drop_MenuItem: TMenuItem
      Caption = 'Description delete'
      ImageIndex = 2
      OnClick = Index__Description__Drop_MenuItemClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Index__Description__Write_In_Log_MenuItem: TMenuItem
      Caption = 'Index description write in log'
      ImageIndex = 15
      OnClick = Index__Description__Write_In_Log_MenuItemClick
    end
  end
end
