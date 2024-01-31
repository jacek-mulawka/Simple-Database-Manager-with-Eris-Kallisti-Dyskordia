object External_Function__Modify_Form: TExternal_Function__Modify_Form
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'External function'
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
  ExplicitHeight = 480
  PixelsPerInch = 96
  TextHeight = 15
  object External_Function_Name_Etiquette_Label: TLabel
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
  object External_Function_Entry_Point_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 53
    Width = 604
    Height = 15
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Entry point'
    ParentShowHint = False
    ShowHint = False
    ExplicitWidth = 58
  end
  object External_Function_Module_Name_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 101
    Width = 604
    Height = 15
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Module (library) name'
    ExplicitWidth = 118
  end
  object External_Function_Name_Edit: TEdit
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
    TabOrder = 4
    DesignSize = (
      624
      185)
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
      TabOrder = 3
    end
    object Execute_Button: TButton
      Left = 145
      Top = 10
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
    object Sql_Prepare_Button: TButton
      Left = 15
      Top = 10
      Width = 75
      Height = 25
      Hint = 'Command prepare.'
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
      TabOrder = 4
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
    object Execute_Button_Works_As_Prepare_Execute_CheckBox: TCheckBox
      Left = 230
      Top = 10
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
  end
  object External_Function_Entry_Point_ComboBox: TComboBox
    AlignWithMargins = True
    Left = 10
    Top = 73
    Width = 604
    Height = 23
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    DropDownCount = 40
    TabOrder = 1
  end
  object External_Function_Module_Name_ComboBox: TComboBox
    AlignWithMargins = True
    Left = 10
    Top = 121
    Width = 604
    Height = 23
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    DropDownCount = 40
    TabOrder = 2
  end
  object External_Function_Parameters_GroupBox: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 149
    Width = 604
    Height = 207
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alClient
    Caption = 'Parameters'
    TabOrder = 3
    object Type_Vertical_Splitter: TSplitter
      Left = 486
      Top = 17
      Width = 6
      Height = 188
      Align = alRight
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitLeft = 200
      ExplicitTop = 1
      ExplicitHeight = 442
    end
    object External_Function_Parameter_Panel: TPanel
      Left = 492
      Top = 17
      Width = 110
      Height = 188
      Align = alRight
      TabOrder = 1
      object External_Function__Parameter__Align_Correct_Button: TButton
        Left = 10
        Top = 5
        Width = 20
        Height = 20
        Hint = 'Correct align.'
        Caption = 'a'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = External_Function__Parameter__Align_Correct_ButtonClick
      end
      object Modify__Parameter__Add_Button: TButton
        Left = 5
        Top = 35
        Width = 25
        Height = 25
        Hint = 'Add parameter.'
        ImageIndex = 20
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Modify__Parameter__Add_ButtonClick
      end
      object Parameter__Move__Up_Button: TButton
        Left = 5
        Top = 65
        Width = 25
        Height = 25
        Hint = 'Move selected parameter up.'
        ImageIndex = 13
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Parameter__Move__Up_ButtonClick
      end
      object Parameter__Move__Down_Button: TButton
        Left = 5
        Top = 90
        Width = 25
        Height = 25
        Hint = 'Move selected parameter down.'
        ImageIndex = 14
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = Parameter__Move__Down_ButtonClick
      end
      object Modify__Parameter__Delete_Button: TButton
        Left = 80
        Top = 35
        Width = 25
        Height = 25
        Hint = 'Delete selected parameter.'
        ImageIndex = 2
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Modify__Parameter__Delete_ButtonClick
      end
    end
    object External_Function_Parameters__List_ScrollBox: TScrollBox
      Left = 2
      Top = 17
      Width = 484
      Height = 188
      Align = alClient
      TabOrder = 0
    end
  end
end
