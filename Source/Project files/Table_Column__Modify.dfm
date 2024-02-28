object Table_Column__Modify_Form: TTable_Column__Modify_Form
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'Column'
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
  DesignSize = (
    624
    547)
  TextHeight = 15
  object Column_Name_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 10
    Width = 604
    Height = 15
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Name'
    ExplicitWidth = 32
  end
  object Column_Type_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 63
    Width = 604
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
  object Collate_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 228
    Width = 604
    Height = 15
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Collate'
    ExplicitWidth = 37
  end
  object Execute_Button: TButton
    Left = 145
    Top = 365
    Width = 75
    Height = 25
    Hint = 'Command execute.'
    Caption = 'Execute'
    ImageIndex = 21
    Images = Shared_DataModule.ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 7
    OnClick = Execute_ButtonClick
  end
  object Close_Button: TButton
    Left = 535
    Top = 365
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Close'
    ImageIndex = 7
    Images = Shared_DataModule.ImageList1
    ModalResult = 2
    TabOrder = 10
  end
  object Sql_Prepare_Button: TButton
    Left = 15
    Top = 365
    Width = 75
    Height = 25
    Hint = 'Command prepare.'
    Caption = 'Prepare'
    ImageIndex = 0
    Images = Shared_DataModule.ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnClick = Sql_Prepare_ButtonClick
  end
  object Column_Name_Edit: TEdit
    AlignWithMargins = True
    Left = 10
    Top = 30
    Width = 604
    Height = 23
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    TabOrder = 0
  end
  object Column_Type_ComboBox: TComboBox
    AlignWithMargins = True
    Left = 10
    Top = 83
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
  object Default_Value_GroupBox: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 116
    Width = 604
    Height = 75
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Default value'
    TabOrder = 2
    object Default_Value_Edit: TEdit
      AlignWithMargins = True
      Left = 12
      Top = 22
      Width = 580
      Height = 23
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      TabOrder = 0
    end
    object Default_Value_CheckBox: TCheckBox
      AlignWithMargins = True
      Left = 12
      Top = 50
      Width = 580
      Height = 17
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Set'
      TabOrder = 1
    end
  end
  object Not_Null_CheckBox: TCheckBox
    AlignWithMargins = True
    Left = 10
    Top = 201
    Width = 604
    Height = 17
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Not null'
    TabOrder = 3
  end
  object Collate_ComboBox: TComboBox
    AlignWithMargins = True
    Left = 10
    Top = 248
    Width = 604
    Height = 23
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    DropDownCount = 40
    TabOrder = 4
  end
  object Column_Position_GroupBox: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 281
    Width = 604
    Height = 75
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Position'
    TabOrder = 5
    object Column_Position_CheckBox: TCheckBox
      AlignWithMargins = True
      Left = 12
      Top = 51
      Width = 580
      Height = 17
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      Caption = 'Set'
      TabOrder = 1
    end
    object Column_Position_SpinEdit: TSpinEdit
      AlignWithMargins = True
      Left = 12
      Top = 22
      Width = 580
      Height = 24
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alTop
      MaxValue = 0
      MinValue = 1
      TabOrder = 0
      Value = 0
    end
  end
  object PageControl1: TPageControl
    Left = 10
    Top = 395
    Width = 604
    Height = 145
    ActivePage = Log_TabSheet
    Anchors = [akLeft, akTop, akRight, akBottom]
    MultiLine = True
    TabOrder = 11
    TabPosition = tpLeft
    object Log_TabSheet: TTabSheet
      Caption = 'Log'
      object Log_Memo: TMemo
        Left = 0
        Top = 0
        Width = 573
        Height = 137
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
        Height = 137
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
        OnKeyDown = Sql_MemoKeyDown
      end
    end
  end
  object Execute_Button_Works_As_Prepare_Execute_CheckBox: TCheckBox
    Left = 230
    Top = 365
    Width = 50
    Height = 17
    Hint = 'Execute button works as Prepare + Execute.'
    Caption = 'P + E'
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 8
  end
  object Ok_Button: TButton
    Left = 445
    Top = 365
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'OK'
    ImageIndex = 4
    Images = Shared_DataModule.ImageList1
    TabOrder = 9
    Visible = False
    OnClick = Sql_Prepare_ButtonClick
  end
end
