object Text__Search_Replace__Prompt_Form: TText__Search_Replace__Prompt_Form
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'Confirm'
  ClientHeight = 87
  ClientWidth = 384
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Message_Panel: TPanel
    Left = 50
    Top = 0
    Width = 334
    Height = 52
    Align = alClient
    Caption = '<?>'
    TabOrder = 2
  end
  object Buttons_Panel: TPanel
    Left = 0
    Top = 52
    Width = 384
    Height = 35
    Align = alBottom
    TabOrder = 0
    object Yes_Button: TButton
      Left = 15
      Top = 5
      Width = 50
      Height = 25
      Hint = 'Yes.'
      Default = True
      ImageAlignment = iaCenter
      ImageIndex = 4
      Images = Shared_DataModule.ImageList1
      ModalResult = 6
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnKeyDown = ButtonKeyDown
    end
    object No_Button: TButton
      Left = 80
      Top = 5
      Width = 50
      Height = 25
      Hint = 'No.'#13#10#13#10'[Esc]'
      Cancel = True
      ImageAlignment = iaCenter
      ImageIndex = 5
      Images = Shared_DataModule.ImageList1
      ModalResult = 7
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnKeyDown = ButtonKeyDown
    end
    object Cancel_Button: TButton
      Left = 145
      Top = 5
      Width = 50
      Height = 25
      Hint = 'Cancel.'#13#10#13#10'[Backspace]'
      ImageAlignment = iaCenter
      ImageIndex = 7
      Images = Shared_DataModule.ImageList1
      ModalResult = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnKeyDown = ButtonKeyDown
    end
    object Yes_To_All_Button: TButton
      Left = 210
      Top = 5
      Width = 50
      Height = 25
      Hint = 'Yes to all.'#13#10#13#10'[A]'
      ImageAlignment = iaCenter
      ImageIndex = 20
      Images = Shared_DataModule.ImageList1
      ModalResult = 14
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnKeyDown = ButtonKeyDown
    end
  end
  object Icon_Panel: TPanel
    Left = 0
    Top = 0
    Width = 50
    Height = 52
    Align = alLeft
    TabOrder = 1
    object Icon_Image: TImage
      Left = 10
      Top = 10
      Width = 32
      Height = 32
    end
  end
end
