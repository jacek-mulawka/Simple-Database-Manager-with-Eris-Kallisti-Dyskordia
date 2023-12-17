object Simple_Database_Manager_Form: TSimple_Database_Manager_Form
  Left = 0
  Top = 0
  Caption = 'Simple database manager'
  ClientHeight = 642
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Databases_Vertical_Splitter: TSplitter
    Left = 200
    Top = 0
    Width = 6
    Height = 642
    AutoSnap = False
    Color = clMoneyGreen
    MinSize = 1
    ParentColor = False
    ExplicitHeight = 442
  end
  object Databases_List_ListBox: TListBox
    Left = 0
    Top = 0
    Width = 200
    Height = 642
    Align = alLeft
    DragMode = dmAutomatic
    ItemHeight = 15
    PopupMenu = Databases_List_PopupMenu
    TabOrder = 0
    OnDblClick = Databases__Open_MenuItemClick
    OnDragDrop = Databases_List_ListBoxDragDrop
    OnDragOver = Databases_List_ListBoxDragOver
    OnKeyDown = Databases_List_ListBoxKeyDown
  end
  object MainMenu1: TMainMenu
    Images = Shared_DataModule.ImageList1
    Left = 565
    Top = 15
    object Databases_MenuItem: TMenuItem
      Caption = 'Databases'
      object Databases__Hide_Show_Databases_MenuItem: TMenuItem
        Caption = 'Hide / show databases'
        ImageIndex = 19
        OnClick = Databases__Hide_Show_Databases_MenuItemClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Databases__Add_MenuItem: TMenuItem
        Caption = 'Add to list [Insert]'
        ImageIndex = 0
        OnClick = Databases__Add_MenuItemClick
      end
      object Databases__Edit_MenuItem: TMenuItem
        Caption = 'Edit list [Space, Ctrl + Enter]'
        ImageIndex = 1
        OnClick = Databases__Edit_MenuItemClick
      end
      object Databases__Copy_MenuItem: TMenuItem
        Caption = 'Copy [Ctrl + C]'
        ImageIndex = 20
        OnClick = Databases__Copy_MenuItemClick
      end
      object Databases__Delete_MenuItem: TMenuItem
        Caption = 'Delete from list [Delete]'
        ImageIndex = 2
        OnClick = Databases__Delete_MenuItemClick
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Databases__Refresh_MenuItem: TMenuItem
        Caption = 'Refresh list [Ctrl + R]'
        ImageIndex = 3
        OnClick = Databases__Refresh_MenuItemClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Databases__Save_MenuItem: TMenuItem
        Caption = 'Save list [Ctrl + S]'
        ImageIndex = 8
        OnClick = Databases__Save_MenuItemClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Databases__Move__Up_MenuItem: TMenuItem
        Caption = 'Move up [Ctrl + Up arrow]'
        ImageIndex = 13
        OnClick = Databases__Move__Up_MenuItemClick
      end
      object Databases__Move__Down_MenuItem: TMenuItem
        Caption = 'Move down [Ctrl + Down arrow]'
        ImageIndex = 14
        OnClick = Databases__Move__Down_MenuItemClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Databases__Open_MenuItem: TMenuItem
        Caption = 'Open [Enter]'
        ImageIndex = 6
        OnClick = Databases__Open_MenuItemClick
      end
      object Databases__Close__One_MenuItem: TMenuItem
        Caption = 'Close one [Ctrl + W]'
        ImageIndex = 10
        OnClick = Databases__Close__One_MenuItemClick
      end
      object Databases__Close__Selected_MenuItem: TMenuItem
        Caption = 'Close selected'
        ImageIndex = 12
        OnClick = Databases__Close__Selected_MenuItemClick
      end
      object Databases__Close__All_MenuItem: TMenuItem
        Caption = 'Close all [Ctrl + Shift + W]'
        Hint = 'Open table.'
        ImageIndex = 11
        OnClick = Databases__Close__All_MenuItemClick
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Database__Backup_Restore_MenuItem: TMenuItem
        Caption = 'Database backup / restore [Ctrl + B]'
        ImageIndex = 30
        OnClick = Database__Backup_Restore_MenuItemClick
      end
      object Database__Create_MenuItem: TMenuItem
        Caption = 'Database create [Ctrl + Insert]'
        ImageIndex = 31
        OnClick = Database__Create_MenuItemClick
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Databases__Exit_MenuItem: TMenuItem
        Caption = 'Exit'
        ImageIndex = 7
        OnClick = Databases__Exit_MenuItemClick
      end
    end
    object Options_MenuItem: TMenuItem
      Caption = 'Options'
      OnClick = Options_MenuItemClick
    end
    object Help_MenuItem: TMenuItem
      Caption = 'Help'
      object Help__About_MenuItem: TMenuItem
        Caption = 'About'
        ImageIndex = 17
        OnClick = Help__About_MenuItemClick
      end
      object Help__Keyboard_Shortcuts_MenuItem: TMenuItem
        Caption = 'Keyboard shortcuts'
        ImageIndex = 18
        OnClick = Help__Keyboard_Shortcuts_MenuItemClick
      end
    end
    object Window__Previous_MenuItem: TMenuItem
      Caption = '<'
      OnClick = Window__Previous_MenuItemClick
    end
    object Window__Next_MenuItem: TMenuItem
      Caption = '>'
      OnClick = Window__Next_MenuItemClick
    end
  end
  object Databases_List_PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 75
    Top = 25
    object Databases__Hide_Show_Databases_2_MenuItem: TMenuItem
      Caption = 'Hide / show databases'
      ImageIndex = 19
      OnClick = Databases__Hide_Show_Databases_MenuItemClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object Databases__Add_2_MenuItem: TMenuItem
      Caption = 'Add to list [Insert]'
      ImageIndex = 0
      OnClick = Databases__Add_MenuItemClick
    end
    object Databases__Edit_2_MenuItem: TMenuItem
      Caption = 'Edit list [Space, Ctrl + Enter]'
      ImageIndex = 1
      OnClick = Databases__Edit_MenuItemClick
    end
    object Databases__Copy_2_MenuItem: TMenuItem
      Caption = 'Copy [Ctrl + C]'
      ImageIndex = 20
      OnClick = Databases__Copy_MenuItemClick
    end
    object Databases__Delete_2_MenuItem: TMenuItem
      Caption = 'Delete from list [Delete]'
      ImageIndex = 2
      OnClick = Databases__Delete_MenuItemClick
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object Databases__Refresh_2_MenuItem: TMenuItem
      Caption = 'Refresh list [Ctrl + R]'
      ImageIndex = 3
      OnClick = Databases__Refresh_MenuItemClick
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object Databases__Save_2_MenuItem: TMenuItem
      Caption = 'Save list [Ctrl + S]'
      ImageIndex = 8
      OnClick = Databases__Save_MenuItemClick
    end
    object N11: TMenuItem
      Caption = '-'
    end
    object Databases__Move__Up_2_MenuItem: TMenuItem
      Caption = 'Move up [Ctrl + Up arrow]'
      ImageIndex = 13
      OnClick = Databases__Move__Up_MenuItemClick
    end
    object Databases__Move__Down_2_MenuItem: TMenuItem
      Caption = 'Move down [Ctrl + Down arrow]'
      ImageIndex = 14
      OnClick = Databases__Move__Down_MenuItemClick
    end
    object N12: TMenuItem
      Caption = '-'
    end
    object Databases__Open_2_MenuItem: TMenuItem
      Caption = 'Open [Enter]'
      ImageIndex = 6
      OnClick = Databases__Open_MenuItemClick
    end
    object Databases__Close__One_2_MenuItem: TMenuItem
      Caption = 'Close one [Ctrl + W]'
      ImageIndex = 10
      OnClick = Databases__Close__One_MenuItemClick
    end
    object Databases__Close__Selected_2_MenuItem: TMenuItem
      Caption = 'Close selected'
      ImageIndex = 12
      OnClick = Databases__Close__Selected_MenuItemClick
    end
    object Databases__Close__All_2_MenuItem: TMenuItem
      Caption = 'Close all [Ctrl + Shift + W]'
      ImageIndex = 11
      OnClick = Databases__Close__All_MenuItemClick
    end
    object N13: TMenuItem
      Caption = '-'
    end
    object Database__Backup_Restore_2_MenuItem: TMenuItem
      Caption = 'Database backup / restore [Ctrl + B]'
      ImageIndex = 30
      OnClick = Database__Backup_Restore_MenuItemClick
    end
    object Database__Create_2_MenuItem: TMenuItem
      Caption = 'Database create [Ctrl + Insert]'
      ImageIndex = 31
      OnClick = Database__Create_MenuItemClick
    end
    object N14: TMenuItem
      Caption = '-'
    end
    object Databases__Exit_2_MenuItem: TMenuItem
      Caption = 'Exit'
      ImageIndex = 7
      OnClick = Databases__Exit_MenuItemClick
    end
  end
end
