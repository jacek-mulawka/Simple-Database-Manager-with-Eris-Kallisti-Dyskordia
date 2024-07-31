object Table__Data_Modify_F_Frame: TTable__Data_Modify_F_Frame
  Left = 0
  Top = 0
  Width = 800
  Height = 480
  TabOrder = 0
  PixelsPerInch = 96
  object Buttons_Vertical_Splitter: TSplitter
    Left = 185
    Top = 30
    Width = 6
    Height = 450
    AutoSnap = False
    Color = clSkyBlue
    MinSize = 1
    ParentColor = False
    ExplicitLeft = 220
    ExplicitTop = 40
  end
  object Top_Panel: TPanel
    Left = 0
    Top = 0
    Width = 800
    Height = 30
    Align = alTop
    TabOrder = 0
    DesignSize = (
      800
      30)
    object Record_Number__Records_Count_Label: TLabel
      AlignWithMargins = True
      Left = 676
      Top = 5
      Width = 53
      Height = 15
      Hint = 'Record number / records count.'
      Margins.Left = 0
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 0
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = '<?> / <?>'
      ParentShowHint = False
      ShowHint = True
    end
    object Width_Keeper__Move__Right_Button: TButton
      Left = 770
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Move the width keeper right.'
      Anchors = [akTop, akRight]
      ImageIndex = 16
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 11
      OnClick = Width_Keeper__Move_ButtonClick
    end
    object Width_Keeper__Move__Left_Button: TButton
      Left = 739
      Top = -1
      Width = 25
      Height = 25
      Hint = 'Move the width keeper left.'
      Anchors = [akTop, akRight]
      ImageIndex = 15
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 10
      OnClick = Width_Keeper__Move_ButtonClick
    end
    object Open_Close_Button: TButton
      Left = 5
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Open.'#13#10#13#10'[Ctrl + O]'
      ImageIndex = 6
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Open_Close_ButtonClick
    end
    object Refresh_Button: TButton
      Left = 35
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Refresh.'#13#10#13#10'[Ctrl + R]'
      Enabled = False
      ImageIndex = 3
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Refresh_ButtonClick
    end
    object Data_DBNavigator: TDBNavigator
      Left = 65
      Top = 0
      Width = 216
      Height = 25
      DataSource = Data_DataSource
      VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbDelete, nbEdit, nbPost, nbCancel]
      TabOrder = 2
    end
    object Duplicate_Record_Button: TButton
      Left = 290
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Duplicate record.'
      Enabled = False
      ImageIndex = 20
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Duplicate_Record_ButtonClick
    end
    object Grid_View_CheckBox: TCheckBox
      Left = 770
      Top = 0
      Width = 130
      Height = 17
      Hint = 'Switch grid / form view.'
      Caption = 'Grid view'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 9
      OnClick = Grid_View_CheckBoxClick
    end
    object Extract_Table_Data_Button: TButton
      Left = 320
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Extract table data to log / file.'
      Enabled = False
      ImageIndex = 14
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = Extract_Table_Data_ButtonClick
    end
    object Delete_Visible_Records_Button: TButton
      Left = 395
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Delete visible records.'
      Enabled = False
      ImageIndex = 11
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = Delete_Visible_Records_ButtonClick
    end
    object Table_Column__Values_Distinct_Button: TButton
      Left = 350
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Column distinct values.'#13#10#13#10'[Ctrl + D]'
      Enabled = False
      ImageIndex = 34
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = Table_Column__Values_Distinct_ButtonClick
    end
    object Editing_CheckBox: TCheckBox
      Left = 440
      Top = 0
      Width = 110
      Height = 17
      Hint = 'Allow data changes.'
      Caption = 'Editing'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = Editing_CheckBoxClick
    end
    object Data_Value_Format__Disabled_CheckBox: TCheckBox
      Left = 560
      Top = 0
      Width = 200
      Height = 17
      Caption = 'Data value format disabled'
      TabOrder = 8
      OnClick = Data_Value_Format__Disabled_CheckBoxClick
    end
  end
  object Buttons_Panel: TPanel
    Left = 0
    Top = 30
    Width = 185
    Height = 450
    Align = alLeft
    TabOrder = 1
    DesignSize = (
      185
      450)
    object Primary_Key_Value_Etiquette_Label: TLabel
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
      Caption = 'Primary key value (probably)'
      ParentShowHint = False
      ShowHint = False
      ExplicitWidth = 151
    end
    object Caret_Position_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 213
      Width = 163
      Height = 15
      Hint = 'Caret position, text length.'
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = '<?> / <?> : <?>'
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
      ExplicitWidth = 83
    end
    object First_Rows_Etiquette_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 54
      Width = 163
      Height = 15
      Hint = 'Display first <value> rows only.'#13#10'Negative value = disabled.'
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'First rows'
      ParentShowHint = False
      ShowHint = True
      ExplicitWidth = 50
    end
    object Data_DBEdit: TDBEdit
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
      DataSource = Data_DataSource
      ReadOnly = True
      TabOrder = 0
      OnChange = Data_DBEditChange
    end
    object Search_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 11
      Top = 103
      Width = 163
      Height = 105
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Search'
      TabOrder = 3
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
      Top = 231
      Width = 163
      Height = 198
      Margins.Left = 10
      Margins.Right = 10
      Align = alClient
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
    object Data_ProgressBar: TProgressBar
      Left = 1
      Top = 432
      Width = 183
      Height = 17
      Align = alBottom
      Step = 1
      TabOrder = 5
      Visible = False
    end
    object First_Rows_SpinEdit: TSpinEdit
      AlignWithMargins = True
      Left = 11
      Top = 74
      Width = 163
      Height = 24
      Hint = 'Ctrl + N - negate value;'#13#10'Ctrl + O - open.'
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Value = 0
      OnChange = First_Rows_SpinEditChange
      OnKeyDown = First_Rows_SpinEditKeyDown
    end
  end
  object Data_Panel: TPanel
    Left = 191
    Top = 30
    Width = 609
    Height = 450
    Align = alClient
    TabOrder = 2
    object Data_Filter_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 293
      Width = 607
      Height = 6
      Cursor = crVSplit
      Align = alBottom
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitLeft = -16
      ExplicitTop = 88
      ExplicitWidth = 447
    end
    object Data_DBGrid: TDBGrid
      Left = 20
      Top = 20
      Width = 100
      Height = 100
      DataSource = Data_DataSource
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnCellClick = Data_DBGridCellClick
      OnDrawColumnCell = Data_DBGridDrawColumnCell
      OnKeyDown = Data_DBGridKeyDown
      OnKeyUp = Data_DBGridKeyUp
      OnTitleClick = Data_DBGridTitleClick
    end
    object Data_ScrollBox: TScrollBox
      Left = 130
      Top = 20
      Width = 100
      Height = 100
      TabOrder = 1
      OnDragOver = Data_ScrollBoxDragOver
      object Width_Keeper_Label: TLabel
        Left = 60
        Top = 5
        Width = 110
        Height = 15
        Hint = 'Move me to change the width.'
        Caption = '<-- width keeper -->'
        ParentShowHint = False
        ShowHint = True
        OnMouseDown = Width_Keeper_LabelMouseDown
      end
    end
    object Data_PageControl: TPageControl
      Left = 1
      Top = 299
      Width = 607
      Height = 150
      ActivePage = Data_Filter_TabSheet
      Align = alBottom
      MultiLine = True
      TabOrder = 2
      TabPosition = tpLeft
      object Data_Filter_TabSheet: TTabSheet
        Caption = 'Filter'
        object Data_Filter__Buttons_Vertical_Splitter: TSplitter
          Left = 80
          Top = 0
          Width = 6
          Height = 142
          AutoSnap = False
          MinSize = 1
          ExplicitLeft = 220
          ExplicitTop = 40
          ExplicitHeight = 148
        end
        object Data_Filter__Buttons_GroupBox: TGroupBox
          Left = 0
          Top = 0
          Width = 80
          Height = 142
          Align = alLeft
          Caption = 'Filter'
          TabOrder = 0
          object Data_Filter__Add_Button: TButton
            Left = 10
            Top = 20
            Width = 25
            Height = 25
            Hint = 'Add filter.'#13#10'[Ctrl + F]'
            ImageIndex = 0
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = Data_Filter__Add_ButtonClick
          end
          object Data_Filter__Delete__All_Button: TButton
            Left = 10
            Top = 80
            Width = 25
            Height = 25
            Hint = 'Delete all filters.'
            ImageIndex = 11
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = Data_Filter__Delete__All_ButtonClick
          end
          object Data_Filter__Show_Button: TButton
            Left = 10
            Top = 110
            Width = 25
            Height = 25
            Hint = 'Show filter value in log.'
            ImageIndex = 17
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            OnClick = Data_Filter__Activate__All_ButtonClick
          end
          object Data_Filter__Deactivate__All_Button: TButton
            Left = 40
            Top = 50
            Width = 25
            Height = 25
            Hint = 'Deactivate all filters.'#13#10#13#10'[Ctrl + Enter]'
            ImageIndex = 19
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = Data_Filter__Deactivate__All_ButtonClick
          end
          object Data_Filter__Activate__All_Button: TButton
            Left = 10
            Top = 50
            Width = 25
            Height = 25
            Hint = 'Activate all filters.'#13#10#13#10'[Enter]'
            ImageIndex = 4
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = Data_Filter__Activate__All_ButtonClick
          end
        end
        object Data_Filter_ScrollBox: TScrollBox
          Left = 86
          Top = 0
          Width = 490
          Height = 142
          Align = alClient
          TabOrder = 1
          object Height_Keeper_Label: TLabel
            Left = 0
            Top = 50
            Width = 102
            Height = 15
            Caption = '^- height keeper -v'
          end
        end
      end
      object Data_Preview_TabSheet: TTabSheet
        Caption = 'Preview'
        ImageIndex = 1
        object Data_Preview_DBMemo: TDBMemo
          Left = 0
          Top = 0
          Width = 576
          Height = 142
          Align = alClient
          DataSource = Data_DataSource
          ScrollBars = ssVertical
          TabOrder = 0
          OnChange = Data_Preview_DBMemoChange
          OnClick = Data_Preview_DBMemoClick
          OnKeyUp = Data_Preview_DBMemoKeyUp
        end
      end
    end
  end
  object Data_DataSource: TDataSource
    Left = 545
    Top = 45
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'txt'
    Filter = 'txt|*.txt|All files|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 545
    Top = 106
  end
end
