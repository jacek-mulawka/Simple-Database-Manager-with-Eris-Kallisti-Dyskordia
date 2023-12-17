object Database__List_Modify_Form: TDatabase__List_Modify_Form
  Left = 0
  Top = 0
  Caption = 'Database connection'
  ClientHeight = 662
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
    662)
  TextHeight = 15
  object Alias_Etiquette_Label: TLabel
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
    Caption = 'Alias'
    ExplicitWidth = 25
  end
  object User_Name_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 285
    Width = 604
    Height = 15
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'User name (optional)'
    ExplicitWidth = 111
  end
  object Password_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 338
    Width = 604
    Height = 15
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Password (optional)'
    ExplicitWidth = 105
  end
  object Fire_Dac__Driver_Id_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 162
    Width = 604
    Height = 15
    Hint = 'E.g.:'#13#10'FB for FireBird.'
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Driver id (FireDAC)'
    ParentShowHint = False
    ShowHint = True
    ExplicitWidth = 98
  end
  object Database_Type_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 58
    Width = 604
    Height = 15
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Database type'
    ExplicitWidth = 74
  end
  object Ado__Connection_String_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 109
    Width = 604
    Height = 15
    Hint = 
      'E.g.:'#13#10'Provider=MSDASQL.1;Persist Security Info=False;Data Sourc' +
      'e=database_odbc_name'
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Connection string (ADO)'
    ParentShowHint = False
    ShowHint = True
    ExplicitWidth = 131
  end
  object Component_Type_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 391
    Width = 604
    Height = 15
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Preferred component type'
    ExplicitWidth = 139
  end
  object Fire_Dac__Parameters_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 548
    Width = 604
    Height = 15
    Hint = 'E.g.:'#13#10'Server=123.456.7.8'#13#10'CharacterSet=utf8'
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Parameters (FireDAC, optional)'
    ParentShowHint = False
    ShowHint = True
    ExplicitWidth = 163
  end
  object Sql__Parameter_Sign_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 495
    Width = 604
    Height = 15
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'SQL parameter sign'
    ExplicitWidth = 103
  end
  object Sql__Quotation_Sign_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 442
    Width = 604
    Height = 15
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'SQL quotation sign (optional)'
    ExplicitWidth = 156
  end
  object Password_Edit: TEdit
    AlignWithMargins = True
    Left = 10
    Top = 358
    Width = 604
    Height = 23
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    PasswordChar = '*'
    TabOrder = 7
  end
  object User_Name_Edit: TEdit
    AlignWithMargins = True
    Left = 10
    Top = 305
    Width = 604
    Height = 23
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    TabOrder = 6
  end
  object Fire_Dac__Driver_Id_ComboBox: TComboBox
    AlignWithMargins = True
    Left = 10
    Top = 182
    Width = 604
    Height = 21
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Style = csOwnerDrawFixed
    DropDownCount = 40
    ItemHeight = 15
    TabOrder = 3
    OnKeyDown = ComboBoxKeyDown
  end
  object Database_Type_ComboBox: TComboBox
    AlignWithMargins = True
    Left = 10
    Top = 78
    Width = 604
    Height = 21
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Style = csOwnerDrawFixed
    DropDownCount = 40
    ItemHeight = 15
    TabOrder = 1
  end
  object Ado__Connection_String_Edit: TEdit
    AlignWithMargins = True
    Left = 10
    Top = 129
    Width = 604
    Height = 23
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    TabOrder = 2
  end
  object Alias_Edit: TEdit
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
  object Ok_Button: TButton
    Left = 440
    Top = 625
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ImageIndex = 4
    Images = Shared_DataModule.ImageList1
    TabOrder = 15
    OnClick = Ok_ButtonClick
  end
  object Cancel_Button: TButton
    Left = 540
    Top = 625
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ImageIndex = 5
    Images = Shared_DataModule.ImageList1
    ModalResult = 2
    TabOrder = 16
  end
  object Connection__Test__Type_RadioGroup: TRadioGroup
    Left = 120
    Top = 612
    Width = 200
    Height = 40
    Anchors = [akLeft, akBottom]
    Caption = 'Connection test'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'ADO'
      'FireDAC')
    TabOrder = 13
  end
  object Connection__Test_Button: TButton
    Left = 325
    Top = 625
    Width = 75
    Height = 25
    Hint = 'Connection test.'
    Anchors = [akLeft, akBottom]
    Caption = 'Test'
    ImageIndex = 17
    Images = Shared_DataModule.ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    OnClick = Connection__Test_ButtonClick
  end
  object Component_Type_ComboBox: TComboBox
    AlignWithMargins = True
    Left = 10
    Top = 411
    Width = 604
    Height = 21
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Style = csOwnerDrawFixed
    DropDownCount = 40
    ItemHeight = 15
    TabOrder = 8
    OnKeyDown = ComboBoxKeyDown
  end
  object Login_Prompt_CheckBox: TCheckBox
    AlignWithMargins = True
    Left = 10
    Top = 258
    Width = 604
    Height = 17
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Login prompt'
    TabOrder = 5
  end
  object Fire_Dac__Parameters_Memo: TMemo
    Left = 10
    Top = 575
    Width = 604
    Height = 30
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 11
    OnKeyDown = Fire_Dac__Parameters_MemoKeyDown
  end
  object Sql__Parameter_Sign_Edit: TEdit
    AlignWithMargins = True
    Left = 10
    Top = 515
    Width = 604
    Height = 23
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    TabOrder = 10
  end
  object Sql__Quotation_Sign_Edit: TEdit
    AlignWithMargins = True
    Left = 10
    Top = 462
    Width = 604
    Height = 23
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    TabOrder = 9
  end
  object Fire_Dac__File_Path_GroupBox: TGroupBox
    AlignWithMargins = True
    Left = 10
    Top = 213
    Width = 604
    Height = 40
    Hint = 
      'E.g.:'#13#10'C:\F1\database_file.fdb'#13#10#13#10'C:\Program Files\Firebird\exam' +
      'ples\empbuild\EMPLOYEE.FDB'
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 0
    Align = alTop
    Caption = 'File path (FireDAC, database file to backup / restore)'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    object Fire_Dac__File_Path__Find_Button: TButton
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
      OnClick = Fire_Dac__File_Path__Find_ButtonClick
    end
    object Fire_Dac__File_Path_Edit: TEdit
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
  object Connection__Example_Button: TButton
    Left = 10
    Top = 625
    Width = 75
    Height = 25
    Hint = 'Set parameters to connect to the sample FireBird database.'
    Anchors = [akLeft, akBottom]
    Caption = 'Example'
    ImageIndex = 1
    Images = Shared_DataModule.ImageList1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 12
    OnClick = Connection__Example_ButtonClick
  end
  object OpenDialog1: TOpenDialog
    Options = [ofFileMustExist, ofEnableSizing]
    Left = 440
    Top = 223
  end
end
