object Users_Modify_F_Frame: TUsers_Modify_F_Frame
  Left = 0
  Top = 0
  Width = 640
  Height = 700
  TabOrder = 0
  PixelsPerInch = 96
  object Vertical_Splitter: TSplitter
    Left = 185
    Top = 0
    Width = 6
    Height = 700
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
    Height = 700
    Align = alLeft
    TabOrder = 0
    DesignSize = (
      185
      700)
    object Record_Number__Records_Count_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 674
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
      Top = 504
      Width = 183
      Height = 6
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitTop = 499
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
      DataSource = Users_DataSource
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
      Height = 335
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Modify'
      TabOrder = 2
      DesignSize = (
        163
        335)
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
        Margins.Bottom = 0
        Align = alTop
        TabOrder = 3
      end
      object Modify__Add_Button: TButton
        Left = 10
        Top = 305
        Width = 25
        Height = 25
        Hint = 'Add new user <name> <values>.'
        Anchors = [akLeft, akBottom]
        ImageIndex = 0
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 10
        OnClick = Modify__Add_ButtonClick
      end
      object Modify__Edit_Button: TButton
        Left = 45
        Top = 305
        Width = 25
        Height = 25
        Hint = 'Set <values> to selected user.'#13#10#13#10'[Enter]'
        Anchors = [akLeft, akBottom]
        ImageIndex = 1
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
        OnClick = Modify__Edit_ButtonClick
      end
      object Modify__Delete_Button: TButton
        Left = 120
        Top = 305
        Width = 25
        Height = 25
        Hint = 'Delete selected user.'#13#10#13#10'[Delete]'
        Anchors = [akLeft, akBottom]
        ImageIndex = 2
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 13
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
        Top = 310
        Width = 45
        Height = 17
        Hint = 'Update values in the value fields.'
        Anchors = [akLeft, akBottom]
        Caption = 'V. u.'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 12
      end
      object Modify__Name__First_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 7
        Top = 175
        Width = 149
        Height = 42
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alTop
        Caption = 'First name'
        TabOrder = 7
        object Modify__Name__First_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 17
          Width = 20
          Height = 23
          Hint = 'Checked - set value.'
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object Modify__Name__First_Edit: TEdit
          AlignWithMargins = True
          Left = 32
          Top = 17
          Width = 110
          Height = 23
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 5
          Margins.Bottom = 0
          Align = alClient
          TabOrder = 1
        end
      end
      object Modify__Active_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 12
        Top = 75
        Width = 139
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Active'
        Enabled = False
        TabOrder = 4
      end
      object Modify__Name__Middle_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 7
        Top = 217
        Width = 149
        Height = 42
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Middle name'
        TabOrder = 8
        object Modify__Name__Middle_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 17
          Width = 20
          Height = 23
          Hint = 'Checked - set value.'
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object Modify__Name__Middle_Edit: TEdit
          AlignWithMargins = True
          Left = 32
          Top = 17
          Width = 110
          Height = 23
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 5
          Margins.Bottom = 0
          Align = alClient
          TabOrder = 1
        end
      end
      object Modify__Name__Last_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 7
        Top = 259
        Width = 149
        Height = 42
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Last name'
        TabOrder = 9
        object Modify__Name__Last_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 17
          Width = 20
          Height = 23
          Hint = 'Checked - set value.'
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object Modify__Name__Last_Edit: TEdit
          AlignWithMargins = True
          Left = 32
          Top = 17
          Width = 110
          Height = 23
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 5
          Margins.Bottom = 0
          Align = alClient
          TabOrder = 1
        end
      end
      object Modify__Password_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 7
        Top = 133
        Width = 149
        Height = 42
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Password'
        TabOrder = 6
        object Modify__Password_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 17
          Width = 20
          Height = 23
          Hint = 'Checked - set value.'
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object Modify__Password_Edit: TEdit
          AlignWithMargins = True
          Left = 32
          Top = 17
          Width = 110
          Height = 23
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 5
          Margins.Bottom = 0
          Align = alClient
          PasswordChar = '*'
          TabOrder = 1
        end
      end
      object Modify__Select_All_Button: TButton
        Left = 48
        Top = 15
        Width = 25
        Height = 15
        Hint = 'Select all.'
        Caption = '+'
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Modify__Select_Unselect_All_ButtonClick
      end
      object Modify__Unselect_All_Button: TButton
        Left = 78
        Top = 15
        Width = 25
        Height = 15
        Hint = 'Unselect all.'
        Caption = '-'
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Modify__Select_Unselect_All_ButtonClick
      end
      object Modify__Administrator_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 7
        Top = 97
        Width = 149
        Height = 36
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 5
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Administrator'
        TabOrder = 5
        object Modify__Administrator__Change_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 7
          Top = 17
          Width = 20
          Height = 17
          Hint = 'Checked - set value.'
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
        object Modify__Administrator_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 37
          Top = 17
          Width = 100
          Height = 17
          Hint = 'Checked - grant admin role.'#13#10'Unchecked - revoke admin role.'
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alClient
          Caption = 'Administrator'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
      end
    end
    object Log_Memo: TMemo
      AlignWithMargins = True
      Left = 11
      Top = 513
      Width = 163
      Height = 153
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
  object Users_DBGrid: TDBGrid
    Left = 191
    Top = 0
    Width = 449
    Height = 700
    Align = alClient
    DataSource = Users_DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    PopupMenu = Users_PopupMenu
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = Users_DBGridDrawColumnCell
    OnKeyDown = Users_DBGridKeyDown
    OnTitleClick = Users_DBGridTitleClick
  end
  object Users_DataSource: TDataSource
    Left = 545
    Top = 45
  end
  object Users_PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 535
    Top = 160
    object User__Delete_MenuItem: TMenuItem
      Caption = 'Delete'
      ImageIndex = 2
      OnClick = Modify__Delete_ButtonClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object User__Description__Set_MenuItem: TMenuItem
      Caption = 'Description edit'
      ImageIndex = 1
      OnClick = User__Description__Set_MenuItemClick
    end
    object User__Description__Drop_MenuItem: TMenuItem
      Caption = 'Description delete'
      ImageIndex = 2
      OnClick = User__Description__Drop_MenuItemClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object User__Description__Write_In_Log_MenuItem: TMenuItem
      Caption = 'User description write in log'
      ImageIndex = 15
      OnClick = User__Description__Write_In_Log_MenuItemClick
    end
  end
end
