object Stored_Procedure__Modify_Form: TStored_Procedure__Modify_Form
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'Stored procedure'
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
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Stored_Procedure__Name_Etiquette_Label: TLabel
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
  object Centre_Panel_Horizontal_Splitter: TSplitter
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
  object Stored_Procedure__Name_Edit: TEdit
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
  object Bottom_Panel: TPanel
    Left = 0
    Top = 362
    Width = 624
    Height = 185
    Align = alBottom
    TabOrder = 2
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
  object Centre_Panel: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 53
    Width = 604
    Height = 298
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alClient
    TabOrder = 1
    object Stored_Procedure__Source_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 171
      Width = 602
      Height = 6
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitWidth = 622
    end
    object Stored_Procedure__Parameters_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 11
      Top = 1
      Width = 582
      Height = 170
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Parameters'
      TabOrder = 0
      object Type_Vertical_Splitter: TSplitter
        Left = 464
        Top = 17
        Width = 6
        Height = 151
        Align = alRight
        AutoSnap = False
        Color = clSkyBlue
        MinSize = 1
        ParentColor = False
        ExplicitLeft = 200
        ExplicitTop = 1
        ExplicitHeight = 442
      end
      object Stored_Procedure__Parameter_Panel: TPanel
        Left = 470
        Top = 17
        Width = 110
        Height = 151
        Align = alRight
        TabOrder = 1
        DesignSize = (
          110
          151)
        object Parameter_Name_Etiquette_Label: TLabel
          Left = 40
          Top = 10
          Width = 87
          Height = 15
          Caption = 'Parameter name'
        end
        object Stored_Procedure__Parameter__Align_Correct_Button: TButton
          Left = 10
          Top = 5
          Width = 20
          Height = 20
          Hint = 'Correct align.'
          Caption = 'a'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = Stored_Procedure__Parameter__Align_Correct_ButtonClick
        end
        object Modify__Parameter__Add_Button: TButton
          Left = 5
          Top = 60
          Width = 25
          Height = 25
          Hint = 'Add parameter.'
          ImageIndex = 20
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = Modify__Parameter__Add_ButtonClick
        end
        object Parameter__Move__Up_Button: TButton
          Left = 5
          Top = 90
          Width = 25
          Height = 25
          Hint = 'Move selected parameter up.'
          ImageIndex = 13
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = Parameter__Move__Up_ButtonClick
        end
        object Parameter__Move__Down_Button: TButton
          Left = 5
          Top = 115
          Width = 25
          Height = 25
          Hint = 'Move selected parameter down.'
          ImageIndex = 14
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          OnClick = Parameter__Move__Down_ButtonClick
        end
        object Parameter_Name_Edit: TEdit
          Left = 5
          Top = 30
          Width = 100
          Height = 23
          Anchors = [akLeft, akTop, akRight]
          TabOrder = 1
        end
        object Modify__Parameter__Name_Set_Button: TButton
          Left = 40
          Top = 60
          Width = 25
          Height = 25
          Hint = 'Set selected parameter name.'
          ImageIndex = 1
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = Modify__Parameter__Name_Set_ButtonClick
        end
        object Modify__Parameter__Delete_Button: TButton
          Left = 80
          Top = 60
          Width = 25
          Height = 25
          Hint = 'Delete selected parameter.'
          ImageIndex = 2
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = Modify__Parameter__Delete_ButtonClick
        end
      end
      object Stored_Procedure__Parameters__List_ScrollBox: TScrollBox
        Left = 2
        Top = 17
        Width = 462
        Height = 151
        Align = alClient
        TabOrder = 0
      end
    end
    object Stored_Procedure__Source_GroupBox: TGroupBox
      Left = 1
      Top = 177
      Width = 602
      Height = 120
      Align = alClient
      Caption = 'Source'
      ParentShowHint = False
      ShowHint = False
      TabOrder = 1
      object Stored_Procedure__Source_Memo: TMemo
        AlignWithMargins = True
        Left = 12
        Top = 17
        Width = 200
        Height = 50
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        ParentShowHint = False
        ScrollBars = ssVertical
        ShowHint = False
        TabOrder = 0
        Visible = False
        OnClick = Stored_Procedure__Source_MemoClick
        OnKeyDown = Stored_Procedure__Source_MemoKeyDown
        OnKeyUp = Stored_Procedure__Source_MemoKeyUp
      end
      object Stored_Procedure__Source_SynEdit: TSynEdit
        AlignWithMargins = True
        Left = 12
        Top = 17
        Width = 578
        Height = 96
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
        Options = [eoAutoIndent, eoDisableScrollArrows, eoDragDropEditing, eoDropFiles, eoEnhanceHomeKey, eoEnhanceEndKey, eoGroupUndo, eoHideShowScrollbars, eoKeepCaretX, eoShowScrollHint, eoSmartTabDelete, eoTabIndent, eoTabsToSpaces, eoShowLigatures, eoCopyPlainText]
        RightEdge = 255
        SelectedColor.Alpha = 0.400000005960464500
        TabWidth = 2
        WantTabs = True
        OnReplaceText = Stored_Procedure__Source_SynEditReplaceText
      end
    end
  end
  object Stored_Procedure__Source__SynCompletionProposal: TSynCompletionProposal
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
    Editor = Stored_Procedure__Source_SynEdit
    OnAfterCodeCompletion = Stored_Procedure__Source__SynCompletionProposalAfterCodeCompletion
    OnCodeCompletion = Stored_Procedure__Source__SynCompletionProposalCodeCompletion
    Left = 457
    Top = 241
  end
end
