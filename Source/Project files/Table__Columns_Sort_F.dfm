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
      Top = 36
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
      Top = 45
      Width = 163
      Height = 531
      Margins.Left = 10
      Margins.Right = 10
      Align = alClient
      Lines.Strings = (
        'Log')
      ScrollBars = ssVertical
      TabOrder = 1
      OnKeyDown = Log_MemoKeyDown
      OnKeyUp = Key_Up_Common
    end
    object Buttons_Panel: TPanel
      Left = 1
      Top = 1
      Width = 183
      Height = 35
      Align = alTop
      TabOrder = 0
      DesignSize = (
        183
        35)
      object Execute_Button: TButton
        Left = 50
        Top = 5
        Width = 25
        Height = 25
        Hint = 'Save changes.'
        ImageIndex = 21
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = Execute_ButtonClick
      end
      object Sort_Button: TButton
        Left = 5
        Top = 5
        Width = 25
        Height = 25
        Hint = 'Sort columns.'
        ImageIndex = 14
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = Sort_ButtonClick
      end
      object Refresh_Button: TButton
        Left = 110
        Top = 5
        Width = 25
        Height = 25
        Hint = 'Refresh.'#13#10#13#10'[Ctrl + R]'
        Anchors = [akTop, akRight]
        ImageIndex = 3
        Images = Shared_DataModule.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
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
        TabOrder = 3
        OnClick = Buttons_Panel__Hide_ButtonClick
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
      OnDragDrop = Columns_Sort_ListViewDragDrop
      OnDragOver = Columns_Sort_ListViewDragOver
      OnKeyDown = Columns_Sort_ListViewKeyDown
      OnKeyUp = Key_Up_Common
    end
  end
end
