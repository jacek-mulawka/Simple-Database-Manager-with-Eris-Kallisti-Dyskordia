object Sql_Editor_F_Frame: TSql_Editor_F_Frame
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
  object Middle_Panel: TPanel
    Left = 191
    Top = 0
    Width = 449
    Height = 480
    Align = alClient
    TabOrder = 0
    object Sql_Text_Horizontal_Splitter: TSplitter
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
      ExplicitLeft = 16
      ExplicitTop = 208
    end
    object Sql_Text_Panel: TPanel
      Left = 1
      Top = 1
      Width = 447
      Height = 300
      Align = alTop
      TabOrder = 0
      object Sql_Parameters_Vertical_Splitter: TSplitter
        Left = 390
        Top = 1
        Width = 6
        Height = 298
        Align = alRight
        AutoSnap = False
        Color = clSkyBlue
        MinSize = 1
        ParentColor = False
        ExplicitLeft = 6
        ExplicitTop = 2
      end
      object Sql_Text_Memo: TMemo
        Left = 1
        Top = 1
        Width = 200
        Height = 150
        ScrollBars = ssBoth
        TabOrder = 0
        Visible = False
        OnClick = Sql_Text_MemoClick
        OnKeyDown = Sql_Text_MemoKeyDown
        OnKeyUp = Sql_Text_MemoKeyUp
        OnMouseDown = Sql_Text_MemoMouseDown
      end
      object Sql_Parameters_ScrollBox: TScrollBox
        Left = 396
        Top = 1
        Width = 50
        Height = 298
        Align = alRight
        TabOrder = 1
      end
      object Sql_Text_SynEdit: TSynEdit
        Left = 1
        Top = 1
        Width = 389
        Height = 298
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        Font.Quality = fqClearTypeNatural
        TabOrder = 2
        OnClick = Sql_Text_SynEditClick
        OnEnter = Sql_Text_SynEditEnter
        OnKeyDown = Sql_Text_SynEditKeyDown
        OnKeyUp = Sql_Text_SynEditKeyUp
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
        RightEdge = 255
        SelectedColor.Alpha = 0.400000005960464500
        TabWidth = 2
        OnReplaceText = Sql_Text_SynEditReplaceText
      end
    end
    object Middle_Panel__Bottom_Panel: TPanel
      Left = 1
      Top = 307
      Width = 447
      Height = 172
      Align = alClient
      TabOrder = 1
      object Data_Preview_Memo_Horizontal_Splitter: TSplitter
        Left = 1
        Top = 115
        Width = 445
        Height = 6
        Cursor = crVSplit
        Align = alBottom
        AutoSnap = False
        Color = clSkyBlue
        MinSize = 1
        ParentColor = False
        ExplicitTop = 71
      end
      object Sql_Editor_DBGrid: TDBGrid
        Left = 1
        Top = 1
        Width = 445
        Height = 114
        Align = alClient
        DataSource = Sql_Editor_DataSource
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnCellClick = Sql_Editor_DBGridCellClick
        OnDrawColumnCell = Sql_Editor_DBGridDrawColumnCell
        OnKeyDown = Sql_Editor_DBGridKeyDown
        OnKeyUp = Sql_Editor_DBGridKeyUp
        OnTitleClick = Sql_Editor_DBGridTitleClick
      end
      object Data_Preview_DBMemo: TDBMemo
        Left = 1
        Top = 121
        Width = 445
        Height = 50
        Align = alBottom
        DataSource = Sql_Editor_DataSource
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
        OnChange = Sql_Text_MemoClick
        OnClick = Sql_Text_MemoClick
        OnKeyDown = Data_Preview_DBMemoKeyDown
        OnKeyUp = Sql_Text_MemoKeyUp
      end
    end
  end
  object Left_Panel: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 480
    Align = alLeft
    TabOrder = 1
    object Buttons_Panel_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 291
      Width = 183
      Height = 6
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitTop = 186
    end
    object Record_Number__Records_Count_Label: TLabel
      AlignWithMargins = True
      Left = 11
      Top = 459
      Width = 163
      Height = 15
      Hint = 'Record number / records count.'
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alBottom
      Caption = '<?> / <?>'
      ParentShowHint = False
      ShowHint = True
      ExplicitWidth = 53
    end
    object Log_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 398
      Width = 183
      Height = 6
      Cursor = crVSplit
      Align = alBottom
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitTop = 192
    end
    object Buttons_Panel: TPanel
      Left = 1
      Top = 1
      Width = 183
      Height = 290
      Align = alTop
      TabOrder = 0
      DesignSize = (
        183
        290)
      object Caret_Position_Label: TLabel
        AlignWithMargins = True
        Left = 11
        Top = 1
        Width = 161
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
      object Sql_Editor_Column_DBEdit: TDBEdit
        AlignWithMargins = True
        Left = 11
        Top = 526
        Width = 161
        Height = 23
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        DataSource = Sql_Editor_DataSource
        ReadOnly = True
        TabOrder = 4
        OnChange = Sql_Editor_Column_DBEditChange
      end
      object Search_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 11
        Top = 121
        Width = 161
        Height = 150
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Search'
        TabOrder = 1
        DesignSize = (
          161
          150)
        object Search_Edit: TEdit
          AlignWithMargins = True
          Left = 12
          Top = 17
          Width = 137
          Height = 23
          Hint = 'Enter - add.'
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
          Hint = 'Search prior.'#13#10#13#10'[Ctrl + Enter - add]'
          Anchors = [akTop, akRight]
          ImageIndex = 13
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = Search__Prior_ButtonClick
          OnKeyDown = Search_ButtonKeyDown
        end
        object Search__Next_Button: TButton
          Left = 123
          Top = 70
          Width = 25
          Height = 25
          Hint = 'Search next.'#13#10#13#10'[Ctrl + Enter - add]'
          Anchors = [akTop, akRight]
          ImageIndex = 14
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = Search__Next_ButtonClick
          OnKeyDown = Search_ButtonKeyDown
        end
        object Search_In_RadioGroup: TRadioGroup
          AlignWithMargins = True
          Left = 12
          Top = 104
          Width = 137
          Height = 40
          Hint = 'Columns list'#13#10'Query output'#13#10'Tables list'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Search in'
          Columns = 3
          ItemIndex = 2
          Items.Strings = (
            'Col'
            'Que'
            'Tbl')
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
        end
      end
      object Sql_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 11
        Top = 16
        Width = 161
        Height = 105
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alTop
        Caption = 'SQL'
        TabOrder = 0
        object Transactions_Count_Label: TLabel
          Left = 74
          Top = 45
          Width = 21
          Height = 15
          Hint = 
            'Transactions count.'#13#10#13#10'Does not count the global value, there is' +
            ' only a common transaction.'
          Alignment = taRightJustify
          Caption = '<?>'
          ParentShowHint = False
          ShowHint = True
        end
        object Output_Save_Button: TButton
          Left = 130
          Top = 75
          Width = 25
          Height = 25
          Hint = 'Save query output as csv.'#13#10#13#10'[Ctrl + S]'
          ImageIndex = 8
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 14
          OnClick = Output_Save_ButtonClick
        end
        object Refresh_Button: TButton
          Left = 5
          Top = 45
          Width = 25
          Height = 25
          Hint = 'Refresh.'#13#10#13#10'[Ctrl + R]'
          ImageIndex = 3
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = Refresh_ButtonClick
        end
        object Open_Button: TButton
          Left = 5
          Top = 15
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
        object Sql__Next_Button: TButton
          Left = 130
          Top = 45
          Width = 25
          Height = 25
          Hint = 'Next SQL text.'#13#10#13#10'[Ctrl + N]'
          ImageIndex = 16
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          OnClick = Sql__Next_ButtonClick
        end
        object Sql__Prior_Button: TButton
          Left = 100
          Top = 45
          Width = 25
          Height = 25
          Hint = 'Prior SQL text.'#13#10#13#10'[Ctrl + P]'
          ImageIndex = 15
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
          OnClick = Sql__Prior_ButtonClick
        end
        object Csv_File__Data_Separator_Edit: TEdit
          Left = 70
          Top = 75
          Width = 20
          Height = 23
          Hint = 'Csv data separator.'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
          OnKeyDown = Query_Output_Save_Field_FormatKeyDown
        end
        object Csv_File__Text_Qualifier_Edit: TEdit
          Left = 100
          Top = 75
          Width = 20
          Height = 23
          Hint = 'Csv text qualifier.'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 13
          OnKeyDown = Query_Output_Save_Field_FormatKeyDown
        end
        object Close_Button: TButton
          Left = 5
          Top = 75
          Width = 25
          Height = 25
          Hint = 'Query close.'
          ImageIndex = 7
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 10
          OnClick = Close_ButtonClick
        end
        object Transaction__Rollback_Button: TButton
          Left = 130
          Top = 15
          Width = 25
          Height = 25
          Hint = 'Rollback transaction.'
          Enabled = False
          ImageIndex = 5
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = Transaction__Rollback_ButtonClick
        end
        object Transaction__Commit_Button: TButton
          Left = 100
          Top = 15
          Width = 25
          Height = 25
          Hint = 'Commit transaction.'
          Enabled = False
          ImageIndex = 4
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = Transaction__Commit_ButtonClick
        end
        object Transaction__Begin_Button: TButton
          Left = 65
          Top = 15
          Width = 25
          Height = 25
          Hint = 'Begin transaction.'
          ImageIndex = 0
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = Transaction__Begin_ButtonClick
        end
        object Execute_Button: TButton
          Left = 35
          Top = 15
          Width = 25
          Height = 25
          Hint = 'Command execute.'#13#10#13#10'[Ctrl + Shift + E]'
          ImageIndex = 21
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = Open_ButtonClick
        end
        object Ado_Command_Param_Check_CheckBox: TCheckBox
          Left = 35
          Top = 80
          Width = 25
          Height = 17
          Hint = 'Query parameters check (ADO command).'
          Caption = 'P.'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 11
        end
        object Execute_Automatic_Detection_CheckBox: TCheckBox
          Left = 35
          Top = 45
          Width = 25
          Height = 17
          Hint = 
            'Automatically detect whether to use '#39'Query execute'#39' or '#39'Command ' +
            'execute'#39' button.'#13#10#13#10'Will use '#39'Command execute'#39' when the SQL text' +
            ' contains words like: alter, create, delete, drop, insert, recre' +
            'ate, set, update etc.'
          Caption = 'E.'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 6
        end
        object Transactions_Automatic_CheckBox: TCheckBox
          Left = 35
          Top = 60
          Width = 25
          Height = 17
          Hint = 
            'Automatically begin transaction (if there is no active transacti' +
            'on) when the SQL text contains words like: delete, insert, updat' +
            'e etc.'
          Caption = 'T.'
          Checked = True
          ParentShowHint = False
          ShowHint = True
          State = cbChecked
          TabOrder = 7
        end
      end
      object Buttons_Panel__Hide_Button: TButton
        Left = 153
        Top = 5
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
      object Tab_Name_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 11
        Top = 476
        Width = 161
        Height = 50
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Tab name'
        TabOrder = 3
        DesignSize = (
          161
          50)
        object Tab_Name_Edit: TEdit
          AlignWithMargins = True
          Left = 10
          Top = 20
          Width = 108
          Height = 23
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 5
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 0
          OnKeyDown = Tab_Name_EditKeyDown
        end
        object Tab_Name__Set_Button: TButton
          Left = 128
          Top = 15
          Width = 25
          Height = 25
          Hint = 'Set tab name.'#13#10#13#10'[Enter]'
          Anchors = [akTop, akRight]
          ImageIndex = 4
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = Tab_Name__Set_ButtonClick
        end
      end
      object Query_Output_Save_Field_Format_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 11
        Top = 271
        Width = 161
        Height = 200
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Query output save field format'
        TabOrder = 2
        object Query_Output_Save_Field_Format__Date_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 17
          Width = 155
          Height = 40
          Hint = 
            'E.g.:'#13#10'dd.mm.yyyy'#13#10'dd-mm-yyyy'#13#10'yyyy-mm-dd'#13#10'yy mmm ddd'#13#10'd dddd mm' +
            'mm y'
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Date'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object Query_Output_Save_Field_Format__Date__Use_CheckBox: TCheckBox
            AlignWithMargins = True
            Left = 7
            Top = 17
            Width = 20
            Height = 16
            Hint = 'Use formatting.'
            Margins.Left = 5
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 5
            Align = alLeft
            TabOrder = 0
            OnKeyDown = Query_Output_Save_Field_FormatKeyDown
          end
          object Query_Output_Save_Field_Format__Date_Edit: TEdit
            AlignWithMargins = True
            Left = 32
            Top = 17
            Width = 116
            Height = 21
            Margins.Left = 5
            Margins.Top = 0
            Margins.Right = 5
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 1
            OnKeyDown = Query_Output_Save_Field_FormatKeyDown
            ExplicitHeight = 23
          end
        end
        object Query_Output_Save_Field_Format__Real_Numbers_GroupBox: TGroupBox
          Left = 2
          Top = 57
          Width = 157
          Height = 40
          Hint = 
            'E.g.:'#13#10'### ### ### ### ### ### ##0.###'#13#10'0.##############'#13#10'### ##' +
            '# ##0.### ### ###'
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Real numbers'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          object Query_Output_Save_Field_Format__Real_Numbers__Use_CheckBox: TCheckBox
            AlignWithMargins = True
            Left = 7
            Top = 17
            Width = 20
            Height = 16
            Hint = 'Use formatting.'
            Margins.Left = 5
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 5
            Align = alLeft
            TabOrder = 0
            OnKeyDown = Query_Output_Save_Field_FormatKeyDown
          end
          object Query_Output_Save_Field_Format__Real_Numbers_Edit: TEdit
            AlignWithMargins = True
            Left = 32
            Top = 17
            Width = 118
            Height = 21
            Margins.Left = 5
            Margins.Top = 0
            Margins.Right = 5
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 1
            OnKeyDown = Query_Output_Save_Field_FormatKeyDown
            ExplicitHeight = 23
          end
        end
        object Query_Output_Save_Field_Format__Time_GroupBox: TGroupBox
          Left = 2
          Top = 97
          Width = 157
          Height = 40
          Hint = 'E.g.:'#13#10'hh:mm:ss'#13#10'hh mm ss.zzz'#13#10'h m s am/pm'#13#10'hh-m a/p'
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Time'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          object Query_Output_Save_Field_Format__Time__Use_CheckBox: TCheckBox
            AlignWithMargins = True
            Left = 7
            Top = 17
            Width = 20
            Height = 16
            Hint = 'Use formatting.'
            Margins.Left = 5
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 5
            Align = alLeft
            TabOrder = 0
            OnKeyDown = Query_Output_Save_Field_FormatKeyDown
          end
          object Query_Output_Save_Field_Format__Time_Edit: TEdit
            AlignWithMargins = True
            Left = 32
            Top = 17
            Width = 118
            Height = 21
            Margins.Left = 5
            Margins.Top = 0
            Margins.Right = 5
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 1
            OnKeyDown = Query_Output_Save_Field_FormatKeyDown
            ExplicitHeight = 23
          end
        end
        object Query_Output_Save_Field_Format__Separators_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 137
          Width = 155
          Height = 59
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 1
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Separators'
          TabOrder = 3
          object Query_Output_Save_Field_Format__Separator__Decimal_GroupBox: TGroupBox
            AlignWithMargins = True
            Left = 73
            Top = 17
            Width = 80
            Height = 40
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alRight
            Caption = 'Decimal'
            TabOrder = 1
            object Query_Output_Save_Field_Format__Separator__Decimal_Edit: TEdit
              AlignWithMargins = True
              Left = 7
              Top = 17
              Width = 66
              Height = 21
              Margins.Left = 5
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 0
              Align = alClient
              TabOrder = 0
              OnKeyDown = Query_Output_Save_Field_FormatKeyDown
              ExplicitHeight = 23
            end
          end
          object Query_Output_Save_Field_Format__Separator__Date_Time_GroupBox: TGroupBox
            AlignWithMargins = True
            Left = 2
            Top = 17
            Width = 71
            Height = 40
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            Caption = 'Date time'
            TabOrder = 0
            object Query_Output_Save_Field_Format__Separator__Date_Time_Edit: TEdit
              AlignWithMargins = True
              Left = 7
              Top = 17
              Width = 57
              Height = 21
              Margins.Left = 5
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 0
              Align = alClient
              TabOrder = 0
              OnKeyDown = Query_Output_Save_Field_FormatKeyDown
              ExplicitHeight = 23
            end
          end
        end
      end
    end
    object Log_Memo: TMemo
      AlignWithMargins = True
      Left = 11
      Top = 404
      Width = 163
      Height = 50
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alBottom
      Lines.Strings = (
        'Log')
      ScrollBars = ssVertical
      TabOrder = 1
      OnKeyDown = Log_MemoKeyDown
      OnKeyUp = Key_Up_Common
    end
    object Tables_Columns_List_Panel: TPanel
      Left = 1
      Top = 297
      Width = 183
      Height = 101
      Align = alClient
      TabOrder = 2
      object Tables_List_Horizontal_Splitter: TSplitter
        Left = 1
        Top = 31
        Width = 181
        Height = 6
        Cursor = crVSplit
        Align = alTop
        AutoSnap = False
        Color = clSkyBlue
        MinSize = 1
        ParentColor = False
      end
      object Tables_List_ListBox: TListBox
        Left = 1
        Top = 1
        Width = 181
        Height = 30
        Align = alTop
        ItemHeight = 15
        TabOrder = 0
        OnClick = Tables_List_ListBoxClick
        OnDblClick = Tables_List_ListBoxDblClick
        OnKeyDown = Tables_List_ListBoxKeyDown
        OnKeyUp = Key_Up_Common
      end
      object Columns_List_ListBox: TListBox
        Left = 1
        Top = 37
        Width = 181
        Height = 63
        Align = alClient
        ItemHeight = 15
        TabOrder = 1
        OnClick = Columns_List_ListBoxClick
        OnDblClick = Columns_List_ListBoxDblClick
        OnKeyDown = Columns_List_ListBoxKeyDown
        OnKeyUp = Key_Up_Common
      end
    end
  end
  object Sql_Editor_DataSource: TDataSource
    Left = 545
    Top = 45
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'csv'
    Filter = 'csv|*.csv|All files|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 545
    Top = 106
  end
  object Sql_Text_PopupMenu: TPopupMenu
    Left = 545
    Top = 171
  end
  object Sql_Text__SynCompletionProposal: TSynCompletionProposal
    Options = [scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText, scoUseBuiltInTimer, scoEndCharCompletion, scoCompleteWithTab, scoCompleteWithEnter]
    EndOfTokenChr = '()[]. '
    TriggerChars = '.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = [fsBold]
    Columns = <>
    Resizeable = True
    ShortCut = 16416
    Editor = Sql_Text_SynEdit
    OnAfterCodeCompletion = Sql_Text__SynCompletionProposalAfterCodeCompletion
    OnCodeCompletion = Sql_Text__SynCompletionProposalCodeCompletion
    Left = 517
    Top = 241
  end
end
