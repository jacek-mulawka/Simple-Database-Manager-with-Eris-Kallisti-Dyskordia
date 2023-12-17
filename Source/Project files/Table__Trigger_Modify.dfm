object Table__Trigger_Modify_Form: TTable__Trigger_Modify_Form
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'Trigger - table'
  ClientHeight = 547
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Trigger_Name_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 5
    Width = 604
    Height = 15
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Name'
    ExplicitWidth = 32
  end
  object Trigger_Source_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 228
    Width = 604
    Height = 15
    Hint = 'as'#13#10'BEGIN'#13#10#13#10'  /* Code here. */'#13#10#13#10'END'
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Source'
    ParentShowHint = False
    ShowHint = True
    ExplicitWidth = 36
  end
  object Trigger_Source_Memo_Horizontal_Splitter: TSplitter
    Left = 0
    Top = 356
    Width = 624
    Height = 6
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    Color = clSkyBlue
    MinSize = 1
    ParentColor = False
    ExplicitLeft = 1
    ExplicitTop = 1
    ExplicitWidth = 447
  end
  object Trigger_Name_Edit: TEdit
    AlignWithMargins = True
    Left = 10
    Top = 25
    Width = 604
    Height = 23
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    TabOrder = 0
  end
  object Trigger_Source_Memo: TMemo
    AlignWithMargins = True
    Left = 10
    Top = 248
    Width = 200
    Height = 50
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    ScrollBars = ssVertical
    TabOrder = 2
    Visible = False
    OnClick = Trigger_Source_MemoClick
    OnKeyDown = Trigger_Source_MemoKeyDown
    OnKeyUp = Trigger_Source_MemoKeyUp
  end
  object Type_Panel: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 53
    Width = 604
    Height = 170
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alTop
    TabOrder = 1
    object Type_Vertical_Splitter: TSplitter
      Left = 251
      Top = 1
      Width = 6
      Height = 168
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitLeft = 200
      ExplicitHeight = 442
    end
    object Type__Left_Panel: TPanel
      Left = 1
      Top = 1
      Width = 250
      Height = 168
      Align = alLeft
      TabOrder = 0
      object Trigger_Type_Etiquette_Label: TLabel
        AlignWithMargins = True
        Left = 11
        Top = 6
        Width = 228
        Height = 15
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Type'
        ParentShowHint = False
        ShowHint = False
        ExplicitWidth = 26
      end
      object Trigger_Activity_Etiquette_Label: TLabel
        AlignWithMargins = True
        Left = 11
        Top = 59
        Width = 228
        Height = 15
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Activity'
        ParentShowHint = False
        ShowHint = False
        ExplicitWidth = 40
      end
      object Trigger_Sequence_Etiquette_Label: TLabel
        AlignWithMargins = True
        Left = 11
        Top = 112
        Width = 228
        Height = 15
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Sequence'
        ParentShowHint = False
        ShowHint = False
        ExplicitWidth = 51
      end
      object Trigger_Type_ComboBox: TComboBox
        AlignWithMargins = True
        Left = 11
        Top = 26
        Width = 228
        Height = 23
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        DropDownCount = 40
        TabOrder = 0
      end
      object Trigger_Activity_ComboBox: TComboBox
        AlignWithMargins = True
        Left = 11
        Top = 79
        Width = 228
        Height = 23
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        DropDownCount = 40
        TabOrder = 1
      end
      object Trigger_Sequence_JvSpinEdit: TJvSpinEdit
        AlignWithMargins = True
        Left = 11
        Top = 137
        Width = 228
        Height = 23
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        CheckMinValue = True
        Align = alTop
        Thousands = True
        Value = 1.000000000000000000
        TabOrder = 2
      end
    end
    object Trigger_Events_GroupBox: TGroupBox
      Left = 257
      Top = 1
      Width = 346
      Height = 168
      Align = alClient
      Caption = 'Events'
      TabOrder = 1
      object Trigger_Events_CheckListBox: TCheckListBox
        Left = 2
        Top = 17
        Width = 342
        Height = 149
        Hint = 
          'Ctrl + A - select all'#13#10'Ctrl + I - invert selection'#13#10'Ctrl + N - u' +
          'nselect all'
        Align = alClient
        ItemHeight = 15
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnKeyDown = Trigger_Events_CheckListBoxKeyDown
      end
    end
  end
  object Bottom_Panel: TPanel
    Left = 0
    Top = 362
    Width = 624
    Height = 185
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      624
      185)
    object Caret_Position_Label: TLabel
      Left = 415
      Top = 10
      Width = 83
      Height = 15
      Hint = 'Caret position, text length.'
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Caption = '<?> / <?> : <?>'
      ParentShowHint = False
      ShowHint = True
      Layout = tlCenter
    end
    object Close_Button: TButton
      Left = 535
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      ImageIndex = 7
      Images = Shared_DataModule.ImageList1
      ModalResult = 2
      TabOrder = 4
    end
    object Execute_Button: TButton
      Left = 145
      Top = 10
      Width = 75
      Height = 25
      Hint = 'Command execute.'#13#10#13#10'[Ctrl + E]'
      Caption = 'Execute'
      ImageIndex = 21
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Execute_ButtonClick
    end
    object Sql_Prepare_Button: TButton
      Left = 15
      Top = 10
      Width = 75
      Height = 25
      Hint = 'Command prepare.'#13#10#13#10'[Ctrl + P]'
      Caption = 'Prepare'
      ImageIndex = 0
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Sql_Prepare_ButtonClick
    end
    object PageControl1: TPageControl
      Left = 10
      Top = 40
      Width = 604
      Height = 140
      ActivePage = Log_TabSheet
      Anchors = [akLeft, akTop, akRight, akBottom]
      MultiLine = True
      TabOrder = 5
      TabPosition = tpLeft
      object Log_TabSheet: TTabSheet
        Caption = 'Log'
        object Log_Memo: TMemo
          Left = 0
          Top = 0
          Width = 573
          Height = 132
          Margins.Left = 10
          Margins.Right = 10
          Align = alClient
          Anchors = [akLeft, akRight, akBottom]
          Lines.Strings = (
            'Log')
          ScrollBars = ssVertical
          TabOrder = 0
          OnKeyDown = Log_MemoKeyDown
        end
      end
      object Sql_TabSheet: TTabSheet
        Caption = 'SQL'
        ImageIndex = 1
        object Sql_Memo: TMemo
          Left = 0
          Top = 0
          Width = 573
          Height = 132
          Align = alClient
          ScrollBars = ssVertical
          TabOrder = 0
          OnKeyDown = Sql_MemoKeyDown
        end
      end
    end
    object Code_Examples_Button: TButton
      Left = 315
      Top = 10
      Width = 75
      Height = 25
      Hint = 'Code examples.'
      Caption = 'Code'
      ImageIndex = 17
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Code_Examples_ButtonClick
    end
    object Execute_Button_Works_As_Prepare_Execute_CheckBox: TCheckBox
      Left = 230
      Top = 10
      Width = 50
      Height = 17
      Hint = 'Execute button works as Prepare + Execute.'#13#10#13#10'[Ctrl + +]'
      Caption = 'P + E'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 2
    end
  end
  object Trigger_Source_SynEdit: TSynEdit
    AlignWithMargins = True
    Left = 10
    Top = 248
    Width = 604
    Height = 103
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Consolas'
    Font.Style = []
    Font.Quality = fqClearTypeNatural
    TabOrder = 4
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
    Highlighter = Shared_DataModule.Sql_Text__SynSQLSyn
    Options = [eoAutoIndent, eoDisableScrollArrows, eoDragDropEditing, eoDropFiles, eoEnhanceHomeKey, eoEnhanceEndKey, eoGroupUndo, eoHideShowScrollbars, eoKeepCaretX, eoShowScrollHint, eoSmartTabDelete, eoTabIndent, eoTabsToSpaces, eoShowLigatures, eoCopyPlainText]
    RightEdge = 255
    SelectedColor.Alpha = 0.400000005960464500
    TabWidth = 2
    OnReplaceText = Trigger_Source_SynEditReplaceText
  end
  object Trigger_Source__SynCompletionProposal: TSynCompletionProposal
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
    Editor = Trigger_Source_SynEdit
    OnAfterCodeCompletion = Trigger_Source__SynCompletionProposalAfterCodeCompletion
    OnCodeCompletion = Trigger_Source__SynCompletionProposalCodeCompletion
    Left = 487
    Top = 241
  end
end
