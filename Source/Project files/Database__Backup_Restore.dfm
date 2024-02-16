object Database__Backup_Restore_Form: TDatabase__Backup_Restore_Form
  Left = 0
  Top = 0
  Margins.Bottom = 5
  Caption = 'Database backup / restore'
  ClientHeight = 762
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Database_Memo_Horizontal_Splitter: TSplitter
    Left = 0
    Top = 395
    Width = 784
    Height = 6
    Cursor = crVSplit
    Align = alTop
    AutoSnap = False
    Color = clSkyBlue
    MinSize = 1
    ParentColor = False
    ExplicitLeft = 6
    ExplicitTop = 245
    ExplicitWidth = 602
  end
  object Database_GroupBox: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 50
    Width = 764
    Height = 345
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Database'
    TabOrder = 1
    object Database__Alias_Etiquette_Label: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 22
      Width = 25
      Height = 15
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Alias'
      ParentShowHint = False
      ShowHint = False
    end
    object User_Name_Etiquette_Label: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 203
      Width = 56
      Height = 15
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'User name'
    end
    object Password_Etiquette_Label: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 251
      Width = 50
      Height = 15
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Password'
    end
    object Database__Alias_ComboBox: TComboBox
      AlignWithMargins = True
      Left = 12
      Top = 42
      Width = 740
      Height = 21
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Style = csOwnerDrawFixed
      DropDownCount = 40
      ItemHeight = 15
      TabOrder = 0
      OnChange = Database__Alias_ComboBoxChange
    end
    object Database__File_Path_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 12
      Top = 68
      Width = 740
      Height = 40
      Hint = 'E.g.:'#13#10'C:\F1\database_file.fdb'
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Database file path'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      object Database__File_Path__Find_Button: TButton
        AlignWithMargins = True
        Left = 698
        Top = 17
        Width = 30
        Height = 21
        Hint = 'Find file.'
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alRight
        ImageAlignment = iaCenter
        ImageIndex = 6
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = File_Path__Find_ButtonClick
      end
      object Database__File_Path_Edit: TEdit
        AlignWithMargins = True
        Left = 12
        Top = 17
        Width = 671
        Height = 21
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alClient
        TabOrder = 0
        OnExit = File_Path_EditExit
        ExplicitHeight = 23
      end
    end
    object Database__Backup__File_Path_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 12
      Top = 113
      Width = 740
      Height = 85
      Hint = 'E.g.:'#13#10'C:\F1\database_file.fbk'
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Backup file path'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      object Database__Backup__File_Path__Top_Panel: TPanel
        Left = 2
        Top = 17
        Width = 736
        Height = 21
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Database__Backup__File_Name__Set_Button: TButton
          AlignWithMargins = True
          Left = 651
          Top = 0
          Width = 30
          Height = 21
          Hint = 'File name set.'
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alRight
          ImageAlignment = iaCenter
          ImageIndex = 15
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = Database__Backup__File_Name__Set_ButtonClick
        end
        object Database__Backup__File_Path__Find_Button: TButton
          AlignWithMargins = True
          Left = 696
          Top = 0
          Width = 30
          Height = 21
          Hint = 'Find file.'
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alRight
          ImageAlignment = iaCenter
          ImageIndex = 6
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = File_Path__Find_ButtonClick
        end
        object Database__Backup__File_Path_Edit: TEdit
          AlignWithMargins = True
          Left = 10
          Top = 0
          Width = 626
          Height = 21
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alClient
          TabOrder = 0
          OnExit = File_Path_EditExit
          ExplicitHeight = 23
        end
      end
      object Database__Backup__File_Name__Date_Time_RadioGroup: TRadioGroup
        AlignWithMargins = True
        Left = 12
        Top = 43
        Width = 716
        Height = 40
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alClient
        Caption = 'Date time'
        Columns = 3
        ItemIndex = 1
        Items.Strings = (
          'none'
          'date'
          'date time')
        TabOrder = 1
      end
    end
    object User_Name_Edit: TEdit
      AlignWithMargins = True
      Left = 12
      Top = 223
      Width = 740
      Height = 23
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 3
    end
    object Password_Edit: TEdit
      AlignWithMargins = True
      Left = 12
      Top = 271
      Width = 740
      Height = 23
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      PasswordChar = '*'
      TabOrder = 4
    end
    object Database_Type_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 12
      Top = 299
      Width = 740
      Height = 40
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Database type'
      ParentShowHint = False
      ShowHint = False
      TabOrder = 5
      object Parameters__Refresh_Button: TButton
        AlignWithMargins = True
        Left = 698
        Top = 17
        Width = 30
        Height = 21
        Hint = 'Refresh parameters.'#13#10#13#10'[Enter]'
        Margins.Left = 5
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alRight
        ImageAlignment = iaCenter
        ImageIndex = 3
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Parameters__Refresh_ButtonClick
      end
      object Database_Type_ComboBox: TComboBox
        AlignWithMargins = True
        Left = 12
        Top = 17
        Width = 671
        Height = 21
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alClient
        Style = csOwnerDrawFixed
        DropDownCount = 40
        ItemHeight = 15
        TabOrder = 0
        OnKeyDown = Database_Type_ComboBoxKeyDown
      end
    end
  end
  object Database__Backup__Application__File_Path_GroupBox: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 5
    Width = 764
    Height = 40
    Hint = 'E.g.:'#13#10'C:\Program Files\Firebird\Firebird_3_0\gbak.exe'
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Database backup application file path'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object Database__Backup__Application__File_Path__Find_Button: TButton
      AlignWithMargins = True
      Left = 722
      Top = 17
      Width = 30
      Height = 21
      Hint = 'Find file.'
      Margins.Left = 5
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alRight
      ImageAlignment = iaCenter
      ImageIndex = 6
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = File_Path__Find_ButtonClick
    end
    object Database__Backup__Application__File_Path_Edit: TEdit
      AlignWithMargins = True
      Left = 12
      Top = 17
      Width = 695
      Height = 21
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alClient
      TabOrder = 0
      OnExit = File_Path_EditExit
      ExplicitHeight = 23
    end
  end
  object Bottom_Panel: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 401
    Width = 764
    Height = 326
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alClient
    TabOrder = 2
    object Log_Memo_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 244
      Width = 762
      Height = 6
      Cursor = crVSplit
      Align = alBottom
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitTop = 101
      ExplicitWidth = 602
    end
    object Parameters_GroupBox: TGroupBox
      Left = 1
      Top = 1
      Width = 762
      Height = 243
      Align = alClient
      Caption = 'Parameters'
      TabOrder = 0
      object Parameters__General_Vertical_Splitter: TSplitter
        Left = 302
        Top = 17
        Width = 6
        Height = 224
        AutoSnap = False
        Color = clSkyBlue
        MinSize = 1
        ParentColor = False
        ExplicitLeft = 147
        ExplicitTop = 19
        ExplicitHeight = 245
      end
      object Parameters__General_GroupBox: TGroupBox
        Left = 2
        Top = 17
        Width = 300
        Height = 224
        Align = alLeft
        Caption = 'General'
        TabOrder = 0
        object Parameters__General_ScrollBox: TScrollBox
          Left = 2
          Top = 17
          Width = 296
          Height = 205
          Align = alClient
          TabOrder = 0
        end
      end
      object Parameters__Backup_Restore_PageControl: TPageControl
        Left = 308
        Top = 17
        Width = 452
        Height = 224
        ActivePage = Parameters__Backup_TabSheet
        Align = alClient
        TabOrder = 1
        OnChange = Parameters__Backup_Restore_PageControlChange
        object Parameters__Backup_TabSheet: TTabSheet
          Caption = 'Backup'
          object Parameters__Backup_ScrollBox: TScrollBox
            Left = 0
            Top = 0
            Width = 444
            Height = 194
            Align = alClient
            TabOrder = 0
          end
        end
        object Parameters__Restore_TabSheet: TTabSheet
          Caption = 'Restore'
          ImageIndex = 1
          object Parameters__Restore_ScrollBox: TScrollBox
            Left = 0
            Top = 0
            Width = 444
            Height = 194
            Align = alClient
            TabOrder = 0
            ExplicitWidth = 284
          end
        end
      end
    end
    object Log_PageControl: TPageControl
      Left = 1
      Top = 250
      Width = 762
      Height = 75
      ActivePage = Log_TabSheet
      Align = alBottom
      MultiLine = True
      TabOrder = 1
      TabPosition = tpLeft
      object Log_TabSheet: TTabSheet
        Caption = 'Log'
        object Log_Memo: TMemo
          Left = 0
          Top = 0
          Width = 200
          Height = 50
          Margins.Left = 10
          Margins.Right = 10
          Lines.Strings = (
            'Log')
          ScrollBars = ssVertical
          TabOrder = 0
          Visible = False
          OnKeyDown = Log_MemoKeyDown
        end
        object Log_SynEdit: TSynEdit
          Left = 0
          Top = 0
          Width = 708
          Height = 67
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Font.Quality = fqClearTypeNatural
          TabOrder = 1
          OnClick = Log_SynEditClick
          OnEnter = Log_SynEditEnter
          OnKeyDown = Log_SynEditKeyDown
          OnKeyUp = Log_SynEditKeyUp
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
          OnReplaceText = Log_SynEditReplaceText
        end
      end
      object Command_TabSheet: TTabSheet
        Caption = 'Command'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = False
        object Command_Memo: TMemo
          Left = 0
          Top = 0
          Width = 708
          Height = 67
          Align = alClient
          ScrollBars = ssVertical
          TabOrder = 0
          OnKeyDown = Command_MemoKeyDown
          ExplicitWidth = 548
        end
      end
    end
  end
  object Buttons_Panel: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 727
    Width = 764
    Height = 35
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      764
      35)
    object Execute_Label: TLabel
      Left = 10
      Top = 5
      Width = 21
      Height = 15
      Caption = '<?>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Command_Prepare_Button: TButton
      Left = 100
      Top = 5
      Width = 75
      Height = 25
      Hint = 'Command prepare.'
      Caption = 'Prepare'
      ImageIndex = 0
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = Command_Prepare_ButtonClick
    end
    object Execute_Button: TButton
      Left = 230
      Top = 5
      Width = 75
      Height = 25
      Hint = 'Command execute.'
      Caption = 'Execute'
      ImageIndex = 21
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Execute_ButtonClick
    end
    object Execute_Button_Works_As_Prepare_Execute_CheckBox: TCheckBox
      Left = 315
      Top = 5
      Width = 50
      Height = 17
      Hint = 'Execute button works as Prepare + Execute.'
      Caption = 'P + E'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 2
    end
    object Quotation_Sign__Use_CheckBox: TCheckBox
      AlignWithMargins = True
      Left = 390
      Top = 5
      Width = 200
      Height = 17
      Hint = 
        'Use quotation sign:'#13#10'backup application file path,'#13#10'backup file ' +
        'path,'#13#10'database file path.'
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'SQL quotation sign use'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 3
    end
    object Parameter__Align_Correct_Button: TButton
      Left = 735
      Top = 5
      Width = 20
      Height = 20
      Hint = 'Correct align.'
      Anchors = [akTop, akRight]
      Caption = 'a'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = Parameter__Align_Correct_ButtonClick
    end
    object Log__Auto_Scroll__Seconds_SpinEdit: TSpinEdit
      Left = 645
      Top = 5
      Width = 70
      Height = 24
      Hint = 
        'Log automatic scrolling:'#13#10'< 0 - disabled;'#13#10'= 0 - always;'#13#10'> 0 - ' +
        'every <value> seconds.'
      Anchors = [akTop, akRight]
      MaxValue = 0
      MinValue = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Value = 5
    end
  end
  object OpenDialog1: TOpenDialog
    Options = [ofEnableSizing]
    Left = 440
    Top = 8
  end
  object DosCommand1: TDosCommand
    InputToOutput = False
    MaxTimeAfterBeginning = 0
    MaxTimeAfterLastOutput = 0
    OnNewLine = DosCommand1NewLine
    OnTerminated = DosCommand1Terminated
    Left = 340
    Top = 8
  end
end
