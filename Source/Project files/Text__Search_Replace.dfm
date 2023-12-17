object Text__Search_Replace_Form: TText__Search_Replace_Form
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'Search'
  ClientHeight = 272
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Search_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 5
    Width = 364
    Height = 15
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Search'
    ParentShowHint = False
    ShowHint = False
    ExplicitWidth = 35
  end
  object Replace_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 58
    Width = 364
    Height = 15
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Replace'
    ParentShowHint = False
    ShowHint = False
    ExplicitWidth = 41
  end
  object Search_ComboBox: TComboBox
    AlignWithMargins = True
    Left = 10
    Top = 25
    Width = 364
    Height = 23
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    DropDownCount = 40
    TabOrder = 0
    OnEnter = Search_ComboBoxEnter
    OnKeyDown = Search_Replace_ComboBoxKeyDown
  end
  object Replace_ComboBox: TComboBox
    AlignWithMargins = True
    Left = 10
    Top = 78
    Width = 364
    Height = 23
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    DropDownCount = 40
    TabOrder = 1
    OnEnter = Replace_ComboBoxEnter
    OnKeyDown = Search_Replace_ComboBoxKeyDown
  end
  object Centre_Panel: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 111
    Width = 364
    Height = 156
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alClient
    TabOrder = 2
    object Search_Options_Panel: TPanel
      AlignWithMargins = True
      Left = 11
      Top = 6
      Width = 177
      Height = 144
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alClient
      TabOrder = 0
      object Search__Case_Insensitive_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 11
        Top = 6
        Width = 155
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Case insensitive'
        Checked = True
        State = cbChecked
        TabOrder = 0
      end
      object Search__Partial_Key_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 11
        Top = 33
        Width = 155
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Partial key'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
      object Search__From_Cursor_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 11
        Top = 60
        Width = 155
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Search from cursor'
        Checked = True
        State = cbChecked
        TabOrder = 2
      end
      object Search__Selected_Text_Only_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 11
        Top = 87
        Width = 155
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Selected text only'
        TabOrder = 3
      end
      object Search__Regular_Expression_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 11
        Top = 114
        Width = 155
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Regular expression'
        TabOrder = 4
      end
    end
    object Buttons_Panel: TPanel
      AlignWithMargins = True
      Left = 198
      Top = 6
      Width = 155
      Height = 144
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Align = alRight
      TabOrder = 1
      object Search__Direction_RadioGroup: TRadioGroup
        AlignWithMargins = True
        Left = 11
        Top = 6
        Width = 133
        Height = 75
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Direction'
        ItemIndex = 1
        Items.Strings = (
          'Backward'
          'Forward')
        TabOrder = 0
      end
      object Search__Find_Next_Button: TButton
        Left = 10
        Top = 89
        Width = 25
        Height = 25
        Hint = 'Find next.'
        ImageIndex = 15
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Search_Replace_ButtonClick
      end
      object Replace_Button: TButton
        Left = 45
        Top = 90
        Width = 25
        Height = 25
        Hint = 'Replace.'
        ImageIndex = 4
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Search_Replace_ButtonClick
      end
      object Replace__All_Button: TButton
        Left = 80
        Top = 90
        Width = 25
        Height = 25
        Hint = 'Replace all.'
        ImageIndex = 20
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = Search_Replace_ButtonClick
      end
      object Search__Close_Button: TButton
        Left = 115
        Top = 90
        Width = 25
        Height = 25
        Hint = 'Close.'
        Cancel = True
        ImageIndex = 7
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = Search__Close_ButtonClick
      end
      object Replace__Prompt_CheckBox: TCheckBox
        Left = 50
        Top = 120
        Width = 80
        Height = 17
        Hint = 'Replace prompt.'
        Caption = 'Prompt'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 2
      end
    end
  end
end
