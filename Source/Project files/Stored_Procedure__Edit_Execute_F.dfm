object Stored_Procedure__Edit_Execute_F_Frame: TStored_Procedure__Edit_Execute_F_Frame
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
  object Stored_Procedure_Panel: TPanel
    Left = 191
    Top = 0
    Width = 449
    Height = 580
    Align = alClient
    TabOrder = 1
    object Stored_Procedure_PageControl_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 301
      Width = 447
      Height = 6
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitTop = 1
    end
    object Stored_Procedure__Parameters_Panel: TPanel
      Left = 1
      Top = 1
      Width = 447
      Height = 300
      Align = alTop
      TabOrder = 0
      object Stored_Procedure__Parameters_Vertical_Splitter: TSplitter
        Left = 390
        Top = 1
        Width = 6
        Height = 298
        Align = alRight
        AutoSnap = False
        Color = clSkyBlue
        MinSize = 1
        ParentColor = False
        ExplicitLeft = 300
        ExplicitTop = -4
        ExplicitHeight = 170
      end
      object Stored_Procedure__Parameters_ScrollBox: TScrollBox
        Left = 396
        Top = 1
        Width = 50
        Height = 298
        Align = alRight
        TabOrder = 1
      end
      object Stored_Procedure__Parameters_Left_Panel: TPanel
        Left = 1
        Top = 1
        Width = 389
        Height = 298
        Align = alClient
        TabOrder = 0
        object Stored_Procedure__Parameters__Description_Memo_Horizontal_Splitter: TSplitter
          Left = 1
          Top = 211
          Width = 387
          Height = 6
          Cursor = crVSplit
          Align = alBottom
          AutoSnap = False
          Color = clSkyBlue
          MinSize = 1
          ParentColor = False
          ExplicitTop = 1
        end
        object Stored_Procedure__Parameters_DBGrid: TDBGrid
          Left = 1
          Top = 1
          Width = 387
          Height = 210
          Align = alClient
          DataSource = Stored_Procedure__Parameters_DataSource
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          PopupMenu = Stored_Procedure_PopupMenu
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          OnCellClick = Stored_Procedure__Parameters_DBGridCellClick
          OnDrawColumnCell = Stored_Procedure__Parameters_DBGridDrawColumnCell
          OnKeyDown = Stored_Procedure__Parameters_DBGridKeyDown
          OnKeyUp = Stored_Procedure__Parameters_DBGridKeyUp
          OnTitleClick = Stored_Procedure__Parameters_DBGridTitleClick
        end
        object Stored_Procedure__Parameters__Description_GroupBox: TGroupBox
          Left = 1
          Top = 217
          Width = 387
          Height = 80
          Align = alBottom
          Caption = 'Parameter description'
          TabOrder = 1
          object Stored_Procedure__Parameters__Description_DBMemo: TDBMemo
            Left = 2
            Top = 17
            Width = 383
            Height = 61
            Align = alClient
            DataSource = Stored_Procedure__Parameters_DataSource
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
            OnClick = Stored_Procedure__Parameters__Description_DBMemoClick
            OnKeyUp = Stored_Procedure__Parameters__Description_DBMemoKeyUp
          end
        end
      end
    end
    object PageControl1: TPageControl
      Left = 1
      Top = 307
      Width = 447
      Height = 272
      ActivePage = Stored_Procedure__Source_TabSheet
      Align = alClient
      TabOrder = 1
      object Stored_Procedure__Output_TabSheet: TTabSheet
        Caption = 'Output'
        object Data_Preview_Memo_Horizontal_Splitter: TSplitter
          Left = 0
          Top = 186
          Width = 439
          Height = 6
          Cursor = crVSplit
          Align = alBottom
          AutoSnap = False
          Color = clSkyBlue
          MinSize = 1
          ParentColor = False
          ExplicitTop = 0
        end
        object Stored_Procedure__Output_DBGrid: TDBGrid
          Left = 0
          Top = 0
          Width = 439
          Height = 186
          Align = alClient
          DataSource = Stored_Procedure__Output_DataSource
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          PopupMenu = Stored_Procedure_PopupMenu
          ReadOnly = True
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          OnCellClick = Stored_Procedure__Output_DBGridCellClick
          OnDrawColumnCell = Stored_Procedure__Output_DBGridDrawColumnCell
          OnKeyDown = Stored_Procedure__Output_DBGridKeyDown
          OnKeyUp = Stored_Procedure__Output_DBGridKeyUp
          OnTitleClick = Stored_Procedure__Output_DBGridTitleClick
        end
        object Data_Preview_DBMemo: TDBMemo
          Left = 0
          Top = 192
          Width = 439
          Height = 50
          Align = alBottom
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
          OnChange = Data_Preview_DBMemoChange
          OnClick = Data_Preview_DBMemoClick
          OnKeyUp = Data_Preview_DBMemoKeyUp
        end
      end
      object Stored_Procedure__Source_TabSheet: TTabSheet
        Caption = 'Source'
        ImageIndex = 1
        object Stored_Procedure__Source_Memo: TMemo
          Left = 10
          Top = 3
          Width = 200
          Height = 150
          Margins.Left = 10
          Margins.Right = 10
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          Visible = False
          OnClick = Stored_Procedure__Source_MemoClick
          OnKeyDown = Memo_KeyDown
          OnKeyUp = Stored_Procedure__Source_MemoKeyUp
        end
        object Stored_Procedure__Source_SynEdit: TSynEdit
          Left = 0
          Top = 0
          Width = 439
          Height = 242
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Font.Quality = fqClearTypeNatural
          TabOrder = 1
          OnClick = Stored_Procedure__Source_SynEditClick
          OnEnter = Stored_Procedure__Source_SynEditEnter
          OnKeyDown = Stored_Procedure__Source_SynEditKeyDown
          OnKeyUp = Stored_Procedure__Source_SynEditKeyUp
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
          Highlighter = Shared_DataModule.Sql_Text__SynSQLSyn
          Options = [eoAutoIndent, eoDisableScrollArrows, eoDragDropEditing, eoDropFiles, eoEnhanceHomeKey, eoEnhanceEndKey, eoGroupUndo, eoHideShowScrollbars, eoKeepCaretX, eoShowScrollHint, eoSmartTabDelete, eoTabIndent, eoTabsToSpaces, eoShowLigatures, eoCopyPlainText]
          ReadOnly = True
          RightEdge = 255
          SelectedColor.Alpha = 0.400000005960464500
          TabWidth = 2
          OnReplaceText = Stored_Procedure__Source_SynEditReplaceText
        end
      end
      object Stored_Procedure__Description_TabSheet: TTabSheet
        Caption = 'Description'
        ImageIndex = 2
        object Stored_Procedure__Description_Memo: TMemo
          AlignWithMargins = True
          Left = 10
          Top = 3
          Width = 419
          Height = 236
          Margins.Left = 10
          Margins.Right = 10
          Align = alClient
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
          OnClick = Stored_Procedure__Description_MemoClick
          OnKeyDown = Memo_KeyDown
          OnKeyUp = Stored_Procedure__Description_MemoKeyUp
        end
      end
    end
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
      Top = 281
      Width = 183
      Height = 6
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitLeft = -19
      ExplicitTop = 283
    end
    object Record_Number__Records_Count_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 559
      Width = 163
      Height = 15
      Hint = 'Record number / records count.'
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alBottom
      Caption = '<?> / <?>'
      ParentShowHint = False
      ShowHint = True
      ExplicitWidth = 53
    end
    object Caret_Position_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 539
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
    object Buttons_Panel: TPanel
      Left = 1
      Top = 1
      Width = 183
      Height = 280
      Align = alTop
      TabOrder = 0
      DesignSize = (
        183
        280)
      object Owner_Etiquette_Label: TLabel
        AlignWithMargins = True
        Left = 11
        Top = 6
        Width = 161
        Height = 15
        Hint = 'Double-click - copy the stored procedure name to clipboard.'
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Owner'
        ParentShowHint = False
        ShowHint = True
        OnDblClick = Owner_Etiquette_LabelDblClick
        ExplicitWidth = 35
      end
      object Owner_Label: TLabel
        AlignWithMargins = True
        Left = 11
        Top = 26
        Width = 161
        Height = 15
        Hint = 'Double-click - copy the owner name to clipboard.'
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = '<?>'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnDblClick = Owner_LabelDblClick
        ExplicitWidth = 21
      end
      object Stored_Procedure__Parameter__Name_DBEdit: TDBEdit
        AlignWithMargins = True
        Left = 11
        Top = 291
        Width = 161
        Height = 23
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        DataSource = Stored_Procedure__Parameters_DataSource
        ReadOnly = True
        TabOrder = 3
        OnChange = Stored_Procedure__Parameter__Name_DBEditChange
      end
      object Search_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 11
        Top = 126
        Width = 161
        Height = 150
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Search'
        TabOrder = 2
        DesignSize = (
          161
          150)
        object Search_Edit: TEdit
          AlignWithMargins = True
          Left = 12
          Top = 17
          Width = 137
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
          TabOrder = 3
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
          TabOrder = 4
          OnClick = Search__Next_ButtonClick
        end
        object Search_In_RadioGroup: TRadioGroup
          AlignWithMargins = True
          Left = 12
          Top = 104
          Width = 137
          Height = 40
          Hint = 'Output'#13#10'Parameters'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Search in'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Output'
            'Param')
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
        end
      end
      object Buttons_Panel__Hide_Button: TButton
        Left = 153
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
        Top = 46
        Width = 161
        Height = 75
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Modify'
        TabOrder = 0
        object Refresh_Button: TButton
          Left = 80
          Top = 20
          Width = 25
          Height = 25
          Hint = 'Refresh.'#13#10#13#10'[Ctrl + R]'
          ImageIndex = 3
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = Refresh_ButtonClick
        end
        object Modify__Edit_Button: TButton
          Left = 125
          Top = 20
          Width = 25
          Height = 25
          Hint = 'Edit selected stored procedure.'
          ImageIndex = 1
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = Modify__Edit_ButtonClick
        end
        object Open_Button: TButton
          Left = 10
          Top = 20
          Width = 25
          Height = 25
          Hint = 'Query execute.'#13#10#13#10'[Ctrl + E]'
          ImageIndex = 6
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = Open_ButtonClick
        end
        object Close_Button: TButton
          Left = 45
          Top = 20
          Width = 25
          Height = 25
          Hint = 'Query close.'
          Enabled = False
          ImageIndex = 7
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = Close_ButtonClick
        end
        object Stored_Procedure__Parameters_As_Query_Parameters_CheckBox: TCheckBox
          Left = 10
          Top = 55
          Width = 70
          Height = 17
          Hint = 'Treat stored procedure parameters as query parameters.'
          Caption = 'Q. param.'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
        end
        object Edit_In_Modal_View_CheckBox: TCheckBox
          Left = 90
          Top = 55
          Width = 97
          Height = 17
          Hint = 'Edit stored procedure in modal view.'
          Caption = 'E. modal'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 5
        end
      end
      object Stored_Procedure__Output_DBEdit: TDBEdit
        AlignWithMargins = True
        Left = 11
        Top = 319
        Width = 161
        Height = 23
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        DataSource = Stored_Procedure__Output_DataSource
        ReadOnly = True
        TabOrder = 4
        OnChange = Stored_Procedure__Output_DBEditChange
      end
    end
    object Log_Memo: TMemo
      AlignWithMargins = True
      Left = 11
      Top = 290
      Width = 163
      Height = 246
      Margins.Left = 10
      Margins.Right = 10
      Align = alClient
      Anchors = [akLeft, akRight, akBottom]
      Lines.Strings = (
        'Log')
      ScrollBars = ssVertical
      TabOrder = 1
      OnKeyDown = Memo_KeyDown
      OnKeyUp = Key_Up_Common
    end
  end
  object Stored_Procedure__Parameters_DataSource: TDataSource
    Left = 495
    Top = 45
  end
  object Stored_Procedure_PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 535
    Top = 160
    object Stored_Procedure__Edit_MenuItem: TMenuItem
      Caption = 'Edit'
      ImageIndex = 1
      OnClick = Modify__Edit_ButtonClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Stored_Procedure__Parameter__Description__Set_MenuItem: TMenuItem
      Caption = 'Parameter description edit'
      ImageIndex = 1
      OnClick = Stored_Procedure__Parameter__Description__Set_MenuItemClick
    end
    object Stored_Procedure__Parameter__Description__Drop_MenuItem: TMenuItem
      Caption = 'Parameter description delete'
      ImageIndex = 2
      OnClick = Stored_Procedure__Parameter__Description__Drop_MenuItemClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Stored_Procedure__Description__Set_MenuItem: TMenuItem
      Caption = 'Description edit'
      ImageIndex = 1
      OnClick = Stored_Procedure__Description__Set_MenuItemClick
    end
    object Stored_Procedure__Description__Drop_MenuItem: TMenuItem
      Caption = 'Description delete'
      ImageIndex = 2
      OnClick = Stored_Procedure__Description__Drop_MenuItemClick
    end
  end
  object Stored_Procedure__Output_DataSource: TDataSource
    Left = 477
    Top = 504
  end
end
