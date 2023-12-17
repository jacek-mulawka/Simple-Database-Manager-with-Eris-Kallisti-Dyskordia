object Table_Column__Values_Distinct_Form: TTable_Column__Values_Distinct_Form
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'Column distinct values'
  ClientHeight = 562
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Log_Horizontal_Splitter: TSplitter
    Left = 0
    Top = 506
    Width = 299
    Height = 6
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    Color = clSkyBlue
    MinSize = 1
    ParentColor = False
    ExplicitTop = 446
    ExplicitWidth = 624
  end
  object Value_DBEdit: TDBEdit
    Left = 0
    Top = 0
    Width = 299
    Height = 23
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    DataSource = Table_Column__Values_Distinct_DataSource
    ReadOnly = True
    TabOrder = 2
    Visible = False
    OnChange = Value_DBEditChange
  end
  object Search_GroupBox: TGroupBox
    Left = 0
    Top = 23
    Width = 299
    Height = 75
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Search'
    TabOrder = 3
    DesignSize = (
      299
      75)
    object Record_Number__Records_Count_Label: TLabel
      AlignWithMargins = True
      Left = 120
      Top = 40
      Width = 53
      Height = 15
      Hint = 'Record number / records count.'
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Caption = '<?> / <?>'
      ParentShowHint = False
      ShowHint = True
    end
    object Search_Edit: TEdit
      AlignWithMargins = True
      Left = 2
      Top = 17
      Width = 295
      Height = 23
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 5
      Align = alTop
      TabOrder = 0
      OnChange = Search_Change
    end
    object Search__Case_Insensitive_CheckBox: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 40
      Width = 110
      Height = 17
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Case insensitive'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = Search_Change
    end
    object Search__Partial_Key_CheckBox: TCheckBox
      AlignWithMargins = True
      Left = 5
      Top = 55
      Width = 110
      Height = 17
      Margins.Left = 10
      Margins.Top = 5
      Margins.Right = 10
      Margins.Bottom = 5
      Caption = 'Partial key'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = Search_Change
    end
    object Search__Prior_Button: TButton
      Left = 215
      Top = 45
      Width = 25
      Height = 25
      Hint = 'Search prior.'
      Anchors = [akTop, akRight]
      ImageIndex = 13
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = Search__Prior_ButtonClick
    end
    object Search__Next_Button: TButton
      Left = 240
      Top = 45
      Width = 25
      Height = 25
      Hint = 'Search next.'
      Anchors = [akTop, akRight]
      ImageIndex = 14
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = Search__Next_ButtonClick
    end
    object Refresh_Button: TButton
      Left = 270
      Top = 45
      Width = 25
      Height = 25
      Hint = 'Refresh.'#13#10#13#10'[Ctrl + R]'
      Anchors = [akTop, akRight]
      ImageIndex = 3
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = Refresh_ButtonClick
    end
    object Ok_Button: TButton
      Left = 185
      Top = 45
      Width = 25
      Height = 25
      Hint = 'Select value.'#13#10#13#10'[Enter]'
      Anchors = [akTop, akRight]
      ImageIndex = 4
      Images = Shared_DataModule.ImageList1
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = Ok_ButtonClick
    end
  end
  object Log_Memo: TMemo
    Left = 0
    Top = 512
    Width = 299
    Height = 50
    Margins.Left = 10
    Margins.Right = 10
    Align = alBottom
    Lines.Strings = (
      'Log')
    ScrollBars = ssVertical
    TabOrder = 1
    OnKeyDown = Log_MemoKeyDown
  end
  object Table_Column__Values_Distinct_DBGrid: TDBGrid
    Left = 0
    Top = 98
    Width = 299
    Height = 408
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alClient
    DataSource = Table_Column__Values_Distinct_DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = Table_Column__Values_Distinct_DBGridDrawColumnCell
    OnKeyDown = Table_Column__Values_Distinct_DBGridKeyDown
    OnTitleClick = Table_Column__Values_Distinct_DBGridTitleClick
  end
  object Table_Column__Values_Distinct_DataSource: TDataSource
    Left = 125
    Top = 180
  end
  object No_Thread_Timer: TTimer
    Enabled = False
    Interval = 100
    OnTimer = No_Thread_TimerTimer
    Left = 125
    Top = 300
  end
end
