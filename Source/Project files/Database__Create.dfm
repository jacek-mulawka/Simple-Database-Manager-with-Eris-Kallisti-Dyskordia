object Database__Create_Form: TDatabase__Create_Form
  Left = 0
  Top = 0
  Margins.Bottom = 5
  Caption = 'Database create'
  ClientHeight = 762
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
  object Database_Memo_Horizontal_Splitter: TSplitter
    Left = 0
    Top = 450
    Width = 624
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
    Width = 604
    Height = 400
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Database'
    TabOrder = 1
    object User_Name_Etiquette_Label: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 259
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
      Top = 307
      Width = 50
      Height = 15
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Password'
    end
    object Database__Default_Character_Set_Etiquette_Label: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 115
      Width = 108
      Height = 15
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Default character set'
      ParentShowHint = False
      ShowHint = False
    end
    object Database__Page_Size_Etiquette_Label: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 163
      Width = 48
      Height = 15
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Page size'
      ParentShowHint = False
      ShowHint = False
    end
    object Database__Sql_Dialect_Etiquette_Label: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 211
      Width = 59
      Height = 15
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'SQL dialect'
      ParentShowHint = False
      ShowHint = False
    end
    object Database__Collation_Etiquette_Label: TLabel
      AlignWithMargins = True
      Left = 12
      Top = 67
      Width = 48
      Height = 15
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Collation'
      ParentShowHint = False
      ShowHint = False
    end
    object Database__Default_Character_Set_ComboBox: TComboBox
      AlignWithMargins = True
      Left = 12
      Top = 135
      Width = 580
      Height = 23
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      DropDownCount = 40
      TabOrder = 2
    end
    object Database__File_Path_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 12
      Top = 22
      Width = 580
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
      TabOrder = 0
      object Database__File_Path__Find_Button: TButton
        AlignWithMargins = True
        Left = 538
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
        Width = 511
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
    object User_Name_Edit: TEdit
      AlignWithMargins = True
      Left = 12
      Top = 279
      Width = 580
      Height = 23
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      TabOrder = 5
    end
    object Password_Edit: TEdit
      AlignWithMargins = True
      Left = 12
      Top = 327
      Width = 580
      Height = 23
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      PasswordChar = '*'
      TabOrder = 6
    end
    object Database__Page_Size_ComboBox: TComboBox
      AlignWithMargins = True
      Left = 12
      Top = 183
      Width = 580
      Height = 23
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      DropDownCount = 40
      TabOrder = 3
    end
    object Database__Sql_Dialect_ComboBox: TComboBox
      AlignWithMargins = True
      Left = 12
      Top = 231
      Width = 580
      Height = 23
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      DropDownCount = 40
      TabOrder = 4
    end
    object Database_Type_GroupBox: TGroupBox
      AlignWithMargins = True
      Left = 12
      Top = 355
      Width = 580
      Height = 40
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Database type'
      ParentShowHint = False
      ShowHint = False
      TabOrder = 7
      object Database_Type_ComboBox: TComboBox
        AlignWithMargins = True
        Left = 12
        Top = 17
        Width = 511
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
        OnChange = Database_Type_ComboBoxChange
        OnKeyDown = Database_Type_ComboBoxKeyDown
      end
      object Database_Type__Refresh_Button: TButton
        AlignWithMargins = True
        Left = 538
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
        OnClick = Database_Type_ComboBoxChange
      end
    end
    object Database__Collation_ComboBox: TComboBox
      AlignWithMargins = True
      Left = 12
      Top = 87
      Width = 580
      Height = 23
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      DropDownCount = 40
      TabOrder = 1
    end
  end
  object Database__Create__Application__File_Path_GroupBox: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 5
    Width = 604
    Height = 40
    Hint = 'E.g.:'#13#10'C:\Program Files\Firebird\Firebird_3_0\isql.exe'
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Database create application file path'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    object Database__Create__Application__File_Path__Find_Button: TButton
      AlignWithMargins = True
      Left = 562
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
    object Database__Create__Application__File_Path_Edit: TEdit
      AlignWithMargins = True
      Left = 12
      Top = 17
      Width = 535
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
  object Buttons_Panel: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 662
    Width = 604
    Height = 100
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      604
      100)
    object Command_Prepare_Button: TButton
      Left = 100
      Top = 65
      Width = 75
      Height = 25
      Hint = 'Command prepare.'
      Caption = 'Prepare'
      ImageIndex = 0
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = Command_Prepare_ButtonClick
    end
    object Execute_Button: TButton
      Left = 230
      Top = 65
      Width = 75
      Height = 25
      Hint = 'Command execute.'
      Caption = 'Execute'
      ImageIndex = 21
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Execute_ButtonClick
    end
    object Execute_Button_Works_As_Prepare_Execute_CheckBox: TCheckBox
      Left = 315
      Top = 65
      Width = 50
      Height = 17
      Hint = 'Execute button works as Prepare + Execute.'
      Caption = 'P + E'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 4
    end
    object Quotation_Sign__Use_CheckBox: TCheckBox
      AlignWithMargins = True
      Left = 390
      Top = 65
      Width = 200
      Height = 17
      Hint = 'Use quotation sign:'#13#10'create application file path.'
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'SQL quotation sign use'
      Checked = True
      ParentShowHint = False
      ShowHint = True
      State = cbChecked
      TabOrder = 5
    end
    object Creation_Method_RadioGroup: TRadioGroup
      AlignWithMargins = True
      Left = 11
      Top = 6
      Width = 582
      Height = 50
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Creation method'
      Columns = 3
      ItemIndex = 2
      Items.Strings = (
        'IBDatabase component'
        'isql.exe'
        'SQL')
      TabOrder = 0
      OnClick = Creation_Method_RadioGroupClick
    end
    object Help_Button: TButton
      Left = 10
      Top = 65
      Width = 25
      Height = 25
      Anchors = [akLeft, akBottom]
      ImageIndex = 17
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = Help_ButtonClick
    end
  end
  object Memos_PageControl: TPageControl
    AlignWithMargins = True
    Left = 10
    Top = 456
    Width = 604
    Height = 206
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 0
    ActivePage = Log_TabSheet
    Align = alClient
    MultiLine = True
    TabOrder = 2
    TabPosition = tpLeft
    object Log_TabSheet: TTabSheet
      Caption = 'Log'
      object Log_Memo: TMemo
        Left = 0
        Top = 0
        Width = 573
        Height = 198
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
    object Command_TabSheet: TTabSheet
      Caption = 'Command'
      ImageIndex = 1
      ParentShowHint = False
      ShowHint = False
      object Command_Memo: TMemo
        Left = 0
        Top = 0
        Width = 573
        Height = 198
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
        OnKeyDown = Command_MemoKeyDown
      end
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
