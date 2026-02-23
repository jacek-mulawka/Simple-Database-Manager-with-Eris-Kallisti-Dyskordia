object Table__Columns_Sort_F_Frame: TTable__Columns_Sort_F_Frame
  Left = 0
  Top = 0
  Width = 640
  Height = 580
  TabOrder = 0
  PixelsPerInch = 96
  object Vertical_Splitter: TSplitter
    Left = 185
    Top = 0
    Width = 6
    Height = 580
    AutoSnap = False
    Color = clSkyBlue
    MinSize = 1
    ParentColor = False
    ExplicitLeft = 200
    ExplicitHeight = 442
  end
  object Left_Panel: TPanel
    Left = 0
    Top = 0
    Width = 185
    Height = 580
    Align = alLeft
    TabOrder = 0
    object Log_Horizontal_Splitter: TSplitter
      Left = 1
      Top = 61
      Width = 183
      Height = 6
      Cursor = crVSplit
      Align = alTop
      AutoSnap = False
      Color = clSkyBlue
      MinSize = 1
      ParentColor = False
      ExplicitLeft = -14
      ExplicitTop = 96
    end
    object Log_Memo: TMemo
      AlignWithMargins = True
      Left = 11
      Top = 70
      Width = 163
      Height = 506
      Margins.Left = 10
      Margins.Right = 10
      Align = alClient
      Lines.Strings = (
        'Log')
      ScrollBars = ssVertical
      TabOrder = 1
      OnKeyDown = Log_MemoKeyDown
      OnKeyUp = Key_Up_Common
      ExplicitTop = 45
      ExplicitHeight = 531
    end
    object Buttons_Panel: TPanel
      Left = 1
      Top = 1
      Width = 183
      Height = 60
      Align = alTop
      TabOrder = 0
      DesignSize = (
        183
        60)
      object Execute_Button: TButton
        Left = 95
        Top = 5
        Width = 25
        Height = 25
        Hint = 'Save changes.'
        ImageIndex = 21
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = Execute_ButtonClick
      end
      object Sort_Button: TButton
        Left = 5
        Top = 5
        Width = 25
        Height = 25
        Hint = 'Sort columns.'
        ImageIndex = 30
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = Sort_ButtonClick
      end
      object Refresh_Button: TButton
        Left = 130
        Top = 5
        Width = 25
        Height = 25
        Hint = 'Refresh.'#13#10#13#10'[Ctrl + R]'
        Anchors = [akTop, akRight]
        ImageIndex = 3
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
        OnClick = Refresh_ButtonClick
      end
      object Buttons_Panel__Hide_Button: TButton
        Left = 155
        Top = 0
        Width = 25
        Height = 15
        Hint = 'Hide panel.'
        Anchors = [akTop, akRight]
        ImageIndex = 19
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = Buttons_Panel__Hide_ButtonClick
      end
      object Column__Move__Up_Button: TButton
        Left = 35
        Top = 5
        Width = 25
        Height = 25
        Hint = 'Move selected column up.'#13#10#13#10'[Ctrl + Up arrow]'
        ImageIndex = 13
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Column__Move__Up_ButtonClick
      end
      object Column__Move__Down_Button: TButton
        Left = 60
        Top = 5
        Width = 25
        Height = 25
        Hint = 'Move selected column down.'#13#10#13#10'[Ctrl + Down arrow]'
        ImageIndex = 14
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = Column__Move__Down_ButtonClick
      end
      object Keyboard_Select_CheckBox: TCheckBox
        Left = 5
        Top = 35
        Width = 170
        Height = 17
        Hint = 
          'Select rows using the keyboard.'#13#10#13#10'[Ctrl + K]'#13#10#13#10'Backspace - uns' +
          'elect all'#13#10'Space - select one'
        Caption = 'Keyboard rows select'
        Checked = True
        ParentShowHint = False
        ShowHint = True
        State = cbChecked
        TabOrder = 6
        OnClick = Keyboard_Select_CheckBoxClick
      end
    end
  end
  object Columns_Sort_Panel: TPanel
    Left = 191
    Top = 0
    Width = 449
    Height = 580
    Align = alClient
    TabOrder = 1
    object Columns_Sort_ListView: TListView
      Left = 1
      Top = 1
      Width = 447
      Height = 578
      Align = alClient
      Columns = <
        item
          Caption = 'Column name'
          Width = 600
        end
        item
          Caption = 'Column position'
          Width = 150
        end>
      DragMode = dmAutomatic
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnCustomDrawItem = Columns_Sort_ListViewCustomDrawItem
      OnDragDrop = Columns_Sort_ListViewDragDrop
      OnDragOver = Columns_Sort_ListViewDragOver
      OnKeyDown = Columns_Sort_ListViewKeyDown
      OnKeyUp = Key_Up_Common
      OnMouseDown = Columns_Sort_ListViewMouseDown
    end
  end
end
