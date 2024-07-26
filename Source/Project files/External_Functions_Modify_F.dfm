object External_Functions_Modify_F_Frame: TExternal_Functions_Modify_F_Frame
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
    object External_Function_Name_Etiquette_Label: TLabel
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
      Caption = 'External function name'
      ParentShowHint = False
      ShowHint = False
      ExplicitWidth = 122
    end
    object Log_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 244
      Width = 183
      Height = 6
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitTop = 264
    end
    object External_Function_Name_DBEdit: TDBEdit
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
      DataSource = External_Functions_DataSource
      ReadOnly = True
      TabOrder = 0
      OnChange = External_Function_Name_DBEditChange
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
      Height = 75
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Modify'
      TabOrder = 2
      DesignSize = (
        163
        75)
      object Modify__Add_Button: TButton
        Left = 10
        Top = 20
        Width = 25
        Height = 25
        Hint = 'Add new external function.'#13#10#13#10'[Insert]'
        ImageIndex = 0
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = Modify__Add_ButtonClick
      end
      object Modify__Edit_Button: TButton
        Left = 45
        Top = 20
        Width = 25
        Height = 25
        Hint = 'Edit selected external function.'#13#10#13#10'[Enter, Double-click]'
        ImageIndex = 1
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Modify__Edit_ButtonClick
      end
      object Modify__Delete_Button: TButton
        Left = 80
        Top = 20
        Width = 25
        Height = 25
        Hint = 'Delete selected external function.'#13#10#13#10'[Delete]'
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
      object Edit_In_Modal_View_CheckBox: TCheckBox
        Left = 10
        Top = 55
        Width = 97
        Height = 17
        Hint = 'Edit external function in modal view.'
        Caption = 'E. modal'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 4
      end
    end
    object Log_Memo: TMemo
      AlignWithMargins = True
      Left = 11
      Top = 253
      Width = 163
      Height = 193
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
  object External_Functions_DBGrid: TDBGrid
    Left = 191
    Top = 0
    Width = 449
    Height = 480
    Align = alClient
    DataSource = External_Functions_DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = External_Functions_PopupMenu
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = External_Functions_DBGridDrawColumnCell
    OnDblClick = Modify__Edit_ButtonClick
    OnKeyDown = External_Functions_DBGridKeyDown
    OnTitleClick = External_Functions_DBGridTitleClick
  end
  object External_Functions_DataSource: TDataSource
    Left = 530
    Top = 45
  end
  object External_Functions_PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 520
    Top = 160
    object External_Function__Delete_MenuItem: TMenuItem
      Caption = 'Delete'
      ImageIndex = 2
      OnClick = Modify__Delete_ButtonClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object External_Function__Description__Set_MenuItem: TMenuItem
      Caption = 'Description edit'
      ImageIndex = 1
      OnClick = External_Function__Description__Set_MenuItemClick
    end
    object External_Function__Description__Drop_MenuItem: TMenuItem
      Caption = 'Description delete'
      ImageIndex = 2
      OnClick = External_Function__Description__Drop_MenuItemClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object External_Function__Description__Write_In_Log_MenuItem: TMenuItem
      Caption = 'External function description write in log'
      ImageIndex = 15
      OnClick = External_Function__Description__Write_In_Log_MenuItemClick
    end
  end
end
