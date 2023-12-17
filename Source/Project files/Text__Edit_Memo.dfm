object Text__Edit_Memo_Form: TText__Edit_Memo_Form
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'Text edit'
  ClientHeight = 547
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  DesignSize = (
    624
    547)
  TextHeight = 15
  object Ok_Button: TButton
    Left = 440
    Top = 510
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ImageIndex = 4
    Images = Shared_DataModule.ImageList1
    TabOrder = 3
    OnClick = Ok_ButtonClick
  end
  object Cancel_Button: TButton
    Left = 540
    Top = 510
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ImageIndex = 5
    Images = Shared_DataModule.ImageList1
    ModalResult = 2
    TabOrder = 4
  end
  object Description_Memo: TMemo
    Left = 10
    Top = 80
    Width = 604
    Height = 420
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 2
    OnKeyDown = Description_MemoKeyDown
  end
  object Hint_Button: TButton
    Left = 15
    Top = 510
    Width = 25
    Height = 25
    Hint = 'Hint.'
    Anchors = [akLeft, akBottom]
    ImageIndex = 17
    Images = Shared_DataModule.ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    Visible = False
    OnClick = Hint_ButtonClick
  end
  object Use_RadioGroup: TRadioGroup
    AlignWithMargins = True
    Left = 10
    Top = 5
    Width = 604
    Height = 40
    Hint = 'Use the value from the '#39'edit'#39' or '#39'memo'#39'.'
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Use'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Edit'
      'Memo')
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
    OnClick = Use_RadioGroupClick
  end
  object Description_Edit: TEdit
    AlignWithMargins = True
    Left = 10
    Top = 50
    Width = 604
    Height = 23
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    TabOrder = 1
    OnKeyDown = Description_EditKeyDown
  end
end
