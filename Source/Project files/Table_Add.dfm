object Table_Add_Form: TTable_Add_Form
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'Table add'
  ClientHeight = 547
  ClientWidth = 784
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
  object Table_Name_Etiquette_Label: TLabel
    AlignWithMargins = True
    Left = 10
    Top = 5
    Width = 764
    Height = 15
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alTop
    Caption = 'Name'
    ExplicitWidth = 32
  end
  object Table_Source_Memo_Horizontal_Splitter: TSplitter
    Left = 0
    Top = 356
    Width = 784
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
  object Table_Name_Edit: TEdit
    AlignWithMargins = True
    Left = 10
    Top = 25
    Width = 764
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
    Width = 784
    Height = 185
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      784
      185)
    object Close_Button: TButton
      Left = 695
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
      Width = 764
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
          Width = 733
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
          Width = 733
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
  object Table_Columns_StringGrid: TStringGrid
    AlignWithMargins = True
    Left = 10
    Top = 83
    Width = 764
    Height = 268
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alClient
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowMoving, goFixedRowDefAlign]
    PopupMenu = Table_Columns_PopupMenu
    TabOrder = 1
    OnDrawCell = Table_Columns_StringGridDrawCell
    OnKeyDown = Table_Columns_StringGridKeyDown
  end
  object Table_Columns_CoolBar: TCoolBar
    Left = 0
    Top = 53
    Width = 784
    Height = 30
    Bands = <
      item
        Control = Table_Columns_ToolBar
        ImageIndex = -1
        Width = 778
      end>
    object Table_Columns_ToolBar: TToolBar
      Left = 11
      Top = 0
      Width = 769
      Height = 25
      Caption = 'Table_Columns_ToolBar'
      Images = Shared_DataModule.ImageList1
      TabOrder = 0
      object Column__Add_ToolButton: TToolButton
        Left = 0
        Top = 0
        Hint = 'Column add [Insert].'
        Caption = 'Column__Add_ToolButton'
        ImageIndex = 20
        ParentShowHint = False
        ShowHint = True
        OnClick = Column__Add_MenuItemClick
      end
      object Column__Edit_ToolButton: TToolButton
        Left = 23
        Top = 0
        Hint = 'Column name edit [Enter].'
        Caption = 'Column__Edit_ToolButton'
        ImageIndex = 1
        ParentShowHint = False
        ShowHint = True
        OnClick = Column__Edit_MenuItemClick
      end
      object Column__Delete_ToolButton: TToolButton
        Left = 46
        Top = 0
        Hint = 'Column delete [Delete].'
        Caption = 'Column__Delete_ToolButton'
        ImageIndex = 2
        ParentShowHint = False
        ShowHint = True
        OnClick = Column__Delete_MenuItemClick
      end
      object ToolButton4: TToolButton
        Left = 69
        Top = 0
        Width = 8
        Caption = 'ToolButton4'
        ImageIndex = 3
        Style = tbsSeparator
      end
      object Primary_Key__Set_ToolButton: TToolButton
        Left = 77
        Top = 0
        Hint = 'Primary key set.'
        Caption = 'Primary_Key__Set_ToolButton'
        ImageIndex = 4
        ParentShowHint = False
        ShowHint = True
        OnClick = Primary_Key__Set_MenuItemClick
      end
      object Primary_Key__Delete_ToolButton: TToolButton
        Left = 100
        Top = 0
        Hint = 'Primary key delete.'
        Caption = 'Primary_Key__Delete_ToolButton'
        ImageIndex = 5
        ParentShowHint = False
        ShowHint = True
        OnClick = Primary_Key__Delete_MenuItemClick
      end
      object ToolButton7: TToolButton
        Left = 123
        Top = 0
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object Column__Move__Up_ToolButton: TToolButton
        Left = 131
        Top = 0
        Hint = 'Column move up.'
        Caption = 'Column__Move__Up_ToolButton'
        ImageIndex = 13
        ParentShowHint = False
        ShowHint = True
        OnClick = Column__Move__Up_MenuItemClick
      end
      object Column__Move__Down_ToolButton: TToolButton
        Left = 154
        Top = 0
        Hint = 'Column move down.'
        Caption = 'Column__Move__Down_ToolButton'
        ImageIndex = 14
        ParentShowHint = False
        ShowHint = True
        OnClick = Column__Move__Down_MenuItemClick
      end
    end
  end
  object Table_Columns_PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 660
    Top = 160
    object Column__Add_MenuItem: TMenuItem
      Caption = 'Column add [Insert]'
      ImageIndex = 20
      OnClick = Column__Add_MenuItemClick
    end
    object Column__Edit_MenuItem: TMenuItem
      Caption = 'Column name edit [Enter]'
      ImageIndex = 1
      OnClick = Column__Edit_MenuItemClick
    end
    object Column__Delete_MenuItem: TMenuItem
      Caption = 'Column delete [Delete]'
      ImageIndex = 2
      OnClick = Column__Delete_MenuItemClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Primary_Key__Set_MenuItem: TMenuItem
      Caption = 'Primary key set'
      ImageIndex = 4
      OnClick = Primary_Key__Set_MenuItemClick
    end
    object Primary_Key__Delete_MenuItem: TMenuItem
      Caption = 'Primary key delete'
      ImageIndex = 5
      OnClick = Primary_Key__Delete_MenuItemClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Column__Move__Up_MenuItem: TMenuItem
      Caption = 'Column move up'
      ImageIndex = 13
      OnClick = Column__Move__Up_MenuItemClick
    end
    object Column__Move__Down_MenuItem: TMenuItem
      Caption = 'Column move down'
      ImageIndex = 14
      OnClick = Column__Move__Down_MenuItemClick
    end
  end
end
