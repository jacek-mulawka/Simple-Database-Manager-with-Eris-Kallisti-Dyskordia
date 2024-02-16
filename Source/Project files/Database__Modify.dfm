object Database__Modify_Form: TDatabase__Modify_Form
  Left = 0
  Top = 0
  Caption = 'Database'
  ClientHeight = 562
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object Main_PageControl: TPageControl
    Left = 5
    Top = 5
    Width = 580
    Height = 550
    ActivePage = Component_Type_TabSheet
    Images = Shared_DataModule.ImageList1
    MultiLine = True
    TabOrder = 0
    TabPosition = tpLeft
    OnChange = Main_PageControlChange
    object Component_Type_TabSheet: TTabSheet
      Caption = 'C. T.'
      ImageIndex = -1
      object Component_Type_Log_Horizontal_Splitter: TSplitter
        Left = 0
        Top = 450
        Width = 526
        Height = 6
        Cursor = crVSplit
        Align = alBottom
        Color = clSkyBlue
        MinSize = 1
        ParentColor = False
        ExplicitTop = 242
        ExplicitWidth = 549
      end
      object Log_Memo: TMemo
        AlignWithMargins = True
        Left = 10
        Top = 459
        Width = 506
        Height = 80
        Margins.Left = 10
        Margins.Right = 10
        Align = alBottom
        Lines.Strings = (
          'Log')
        ScrollBars = ssVertical
        TabOrder = 1
        OnKeyDown = Log_MemoKeyDown
      end
      object Component_Type_Top_Panel: TPanel
        Left = 0
        Top = 0
        Width = 526
        Height = 450
        Align = alClient
        TabOrder = 0
        object Database_Name_Label: TLabel
          AlignWithMargins = True
          Left = 11
          Top = 11
          Width = 504
          Height = 15
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Database: '
          ExplicitWidth = 54
        end
        object Component_Type_Etiquette_Label: TLabel
          AlignWithMargins = True
          Left = 11
          Top = 41
          Width = 504
          Height = 15
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Component type'
          ExplicitWidth = 90
        end
        object Component_Type_Default_Label: TLabel
          AlignWithMargins = True
          Left = 11
          Top = 87
          Width = 504
          Height = 15
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Default: '
          ExplicitWidth = 44
        end
        object Connection_Status_Etiquette_Label: TLabel
          AlignWithMargins = True
          Left = 11
          Top = 117
          Width = 504
          Height = 15
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Connection status'
          ExplicitWidth = 96
        end
        object Connection_Status_Label: TLabel
          AlignWithMargins = True
          Left = 11
          Top = 137
          Width = 504
          Height = 15
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 10
          Align = alTop
          Caption = '<?>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 21
        end
        object Stored_Procedures_List_Count_Etiquette_Label: TLabel
          Left = 10
          Top = 355
          Width = 96
          Height = 15
          Caption = 'Stored procedures'
        end
        object Stored_Procedures_List_Count_Label: TLabel
          Left = 140
          Top = 355
          Width = 21
          Height = 15
          Caption = '<?>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Tables_List_Count_Etiquette_Label: TLabel
          Left = 10
          Top = 375
          Width = 34
          Height = 15
          Caption = 'Tables'
        end
        object Tables_List_Count_Label: TLabel
          Left = 140
          Top = 375
          Width = 21
          Height = 15
          Caption = '<?>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Views_List_Count_Etiquette_Label: TLabel
          Left = 10
          Top = 395
          Width = 30
          Height = 15
          Caption = 'Views'
        end
        object Views_List_Count_Label: TLabel
          Left = 140
          Top = 395
          Width = 21
          Height = 15
          Caption = '<?>'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Component_Type_ComboBox: TComboBox
          AlignWithMargins = True
          Left = 11
          Top = 61
          Width = 504
          Height = 21
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Style = csOwnerDrawFixed
          DropDownCount = 40
          ItemHeight = 15
          TabOrder = 0
          OnKeyDown = Component_Type_ComboBoxKeyDown
        end
        object Form_View__Additional_Component_Show_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 167
          Width = 504
          Height = 17
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Form view - show additional components'
          TabOrder = 1
        end
        object Queries_Open_In_Background_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 194
          Width = 504
          Height = 17
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Queries (some) open in the background'
          TabOrder = 2
        end
        object Splitter_Show_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 221
          Width = 504
          Height = 17
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Show splitters (e.g. form view, stored procedure parameters)'
          TabOrder = 3
        end
        object Sql__Quotation_Sign__Use_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 275
          Width = 504
          Height = 17
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'SQL quotation sign use'
          TabOrder = 5
        end
        object Connect_Button: TButton
          Left = 10
          Top = 310
          Width = 100
          Height = 25
          Caption = '(Re)Connect'
          ImageIndex = 3
          Images = Shared_DataModule.ImageList1
          TabOrder = 6
          OnClick = Connect_ButtonClick
        end
        object Sql_Editor__Database_Connection__Separated_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 248
          Width = 504
          Height = 17
          Hint = 'Every tab has own database connection.'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'SQL editor - separated database connection'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
        end
      end
    end
    object Exceptions_TabSheet: TTabSheet
      Caption = 'Exceptions'
      ImageIndex = 22
    end
    object External_Functions_TabSheet: TTabSheet
      Caption = 'External functions'
      ImageIndex = 23
    end
    object Generators_List_TabSheet: TTabSheet
      Caption = 'Generators'
      ImageIndex = 24
    end
    object Database__Informations_TabSheet: TTabSheet
      Caption = 'Info'
      ImageIndex = 32
    end
    object Roles_List_TabSheet: TTabSheet
      Caption = 'Roles'
      ImageIndex = 25
    end
    object Sql_Editor_TabSheet: TTabSheet
      Caption = 'SQL'
      ImageIndex = 28
      object Sql_Editor__Vertical_Splitter: TSplitter
        Left = 35
        Top = 0
        Width = 6
        Height = 542
        AutoSnap = False
        Color = clSkyBlue
        MinSize = 1
        ParentColor = False
        ExplicitLeft = 205
        ExplicitHeight = 427
      end
      object Sql_Editor__PageControl: TPageControl
        Left = 41
        Top = 0
        Width = 485
        Height = 542
        Align = alClient
        TabOrder = 0
        OnDragDrop = Sql_Editor__PageControlDragDrop
        OnDragOver = Sql_Editor__PageControlDragOver
        OnMouseDown = Sql_Editor__PageControlMouseDown
      end
      object Sql_Editor__Buttons_Panel: TPanel
        Left = 0
        Top = 0
        Width = 35
        Height = 542
        Align = alLeft
        TabOrder = 1
        DesignSize = (
          35
          542)
        object Sql_Editor__Page__Close__One_Button: TButton
          Left = 5
          Top = 80
          Width = 25
          Height = 25
          Hint = 'Close one.'
          ImageIndex = 10
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = Sql_Editor__Page__Close__One_ButtonClick
        end
        object Sql_Editor__Page__Close__All_Button: TButton
          Left = 5
          Top = 110
          Width = 25
          Height = 25
          Hint = 'Close all.'
          ImageIndex = 11
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = Sql_Editor__Page__Close__All_ButtonClick
        end
        object Sql_Editor__Move__Left_Button: TButton
          Left = 5
          Top = 170
          Width = 25
          Height = 25
          Hint = 'Move the tab left.'
          ImageIndex = 15
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = Sql_Editor__Move__Left_ButtonClick
        end
        object Sql_Editor__Move__Right_Button: TButton
          Left = 5
          Top = 200
          Width = 25
          Height = 25
          Hint = 'Move the tab right.'
          ImageIndex = 16
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 5
          OnClick = Sql_Editor__Move__Right_ButtonClick
        end
        object Sql_Editor__Page__New_Button: TButton
          Left = 5
          Top = 20
          Width = 25
          Height = 25
          Hint = 'New tab.'
          ImageIndex = 0
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = Sql_Editor__Page__New_ButtonClick
        end
        object Sql_Editor__Hide_Button: TButton
          Left = 10
          Top = 0
          Width = 25
          Height = 15
          Hint = 'Hide panel.'
          Anchors = [akTop, akRight]
          ImageIndex = 19
          Images = Shared_DataModule.ImageList1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = Sql_Editor__Hide_ButtonClick
        end
      end
    end
    object Stored_Procedures_List_TabSheet: TTabSheet
      Caption = 'Stored procedures'
      ImageIndex = 26
      object Stored_Procedures__List_Vertical_Splitter: TSplitter
        Left = 200
        Top = 0
        Width = 6
        Height = 542
        Color = clSkyBlue
        ParentColor = False
        ExplicitLeft = 460
        ExplicitTop = 1
        ExplicitHeight = 427
      end
      object Stored_Procedures_List__Left_Panel: TPanel
        Left = 0
        Top = 0
        Width = 200
        Height = 542
        Align = alLeft
        TabOrder = 0
        object Stored_Procedures_List__Buttons_Panel_Horizontal_Splitter: TSplitter
          Left = 1
          Top = 136
          Width = 198
          Height = 6
          Cursor = crVSplit
          Align = alTop
          AutoSnap = False
          Color = clSkyBlue
          MinSize = 1
          ParentColor = False
          ExplicitTop = 186
        end
        object Stored_Procedures_List__Buttons_Panel: TPanel
          Left = 1
          Top = 1
          Width = 198
          Height = 135
          Align = alTop
          TabOrder = 0
          DesignSize = (
            198
            135)
          object Stored_Procedures_List__Page__Close__One_Button: TButton
            Left = 5
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Close one.'
            ImageIndex = 10
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = Stored_Procedures_List__Page__Close__One_ButtonClick
          end
          object Stored_Procedures_List__Page__Close__All_Button: TButton
            Left = 40
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Close all.'
            ImageIndex = 11
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = Stored_Procedures_List__Page__Close__All_ButtonClick
          end
          object Stored_Procedures_List__Move__Left_Button: TButton
            Left = 80
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Move the tab left.'
            Anchors = [akTop, akRight]
            ImageIndex = 15
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = Stored_Procedures_List__Move__Left_ButtonClick
          end
          object Stored_Procedures_List__Move__Right_Button: TButton
            Left = 110
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Move the tab right.'
            Anchors = [akTop, akRight]
            ImageIndex = 16
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = Stored_Procedures_List__Move__Right_ButtonClick
          end
          object Stored_Procedures_List__Page__New_Button: TButton
            Left = 170
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Open stored procedure.'
            Anchors = [akTop, akRight]
            ImageIndex = 0
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = Stored_Procedures_List__ListBoxDblClick
          end
          object Stored_Procedures_List__Hide_Button: TButton
            Left = 140
            Top = 0
            Width = 25
            Height = 15
            Hint = 'Hide panel.'
            Anchors = [akTop, akRight]
            ImageIndex = 19
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            OnClick = Stored_Procedures_List__Hide_ButtonClick
          end
          object Stored_Procedures_List__Search_GroupBox: TGroupBox
            AlignWithMargins = True
            Left = 11
            Top = 31
            Width = 176
            Height = 100
            Margins.Left = 10
            Margins.Top = 30
            Margins.Right = 10
            Margins.Bottom = 5
            Align = alTop
            Caption = 'Search'
            TabOrder = 6
            DesignSize = (
              176
              100)
            object Stored_Procedures_List__Search_Edit: TEdit
              AlignWithMargins = True
              Left = 12
              Top = 17
              Width = 152
              Height = 23
              Hint = 'Shift + Enter - open and edit;'#13#10'Enter - open.'
              Margins.Left = 10
              Margins.Top = 0
              Margins.Right = 10
              Margins.Bottom = 5
              Align = alTop
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnChange = Stored_Procedures_List__Search_Change
              OnKeyDown = Stored_Procedures_List__Search_EditKeyDown
            end
            object Stored_Procedures_List__Search__Case_Insensitive_CheckBox: TCheckBox
              AlignWithMargins = True
              Left = 12
              Top = 50
              Width = 152
              Height = 17
              Margins.Left = 10
              Margins.Top = 5
              Margins.Right = 10
              Margins.Bottom = 5
              Align = alTop
              Caption = 'Case insensitive'
              Checked = True
              State = cbChecked
              TabOrder = 1
              OnClick = Stored_Procedures_List__Search_Change
            end
            object Stored_Procedures_List__Search__Partial_Key_CheckBox: TCheckBox
              AlignWithMargins = True
              Left = 12
              Top = 77
              Width = 152
              Height = 17
              Margins.Left = 10
              Margins.Top = 5
              Margins.Right = 10
              Margins.Bottom = 5
              Align = alTop
              Caption = 'Partial key'
              Checked = True
              State = cbChecked
              TabOrder = 2
              OnClick = Stored_Procedures_List__Search_Change
            end
            object Stored_Procedures_List__Search__Prior_Button: TButton
              Left = 138
              Top = 45
              Width = 25
              Height = 25
              Hint = 
                'Search prior.'#13#10#13#10'[Ctrl + Shift + Enter - open and edit]'#13#10'[Shift ' +
                '+ Enter - open]'
              Anchors = [akTop, akRight]
              ImageIndex = 13
              Images = Shared_DataModule.ImageList1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              OnClick = Stored_Procedures_List__Search__Prior_ButtonClick
              OnKeyDown = Stored_Procedures_List__Search_ButtonKeyDown
            end
            object Stored_Procedures_List__Search__Next_Button: TButton
              Left = 138
              Top = 70
              Width = 25
              Height = 25
              Hint = 
                'Search next.'#13#10#13#10'[Ctrl + Shift + Enter - open and edit]'#13#10'[Shift +' +
                ' Enter - open]'
              Anchors = [akTop, akRight]
              ImageIndex = 14
              Images = Shared_DataModule.ImageList1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              OnClick = Stored_Procedures_List__Search__Next_ButtonClick
              OnKeyDown = Stored_Procedures_List__Search_ButtonKeyDown
            end
          end
        end
        object Stored_Procedures_List__ListBox: TListBox
          Left = 1
          Top = 142
          Width = 198
          Height = 399
          Align = alClient
          ItemHeight = 15
          PopupMenu = Stored_Procedures_List__PopupMenu
          TabOrder = 1
          OnClick = Stored_Procedures_List__ListBoxClick
          OnDblClick = Stored_Procedures_List__ListBoxDblClick
          OnKeyDown = Stored_Procedures_List__ListBoxKeyDown
        end
      end
      object Stored_Procedures_List__PageControl: TPageControl
        Left = 206
        Top = 0
        Width = 320
        Height = 542
        Align = alClient
        TabOrder = 1
        OnDragDrop = Stored_Procedures_List__PageControlDragDrop
        OnDragOver = Stored_Procedures_List__PageControlDragOver
        OnMouseDown = Stored_Procedures_List__PageControlMouseDown
      end
    end
    object Tables_List_TabSheet: TTabSheet
      Caption = 'Tables'
      ImageIndex = 27
      object Tables_List__Vertical_Splitter: TSplitter
        Left = 200
        Top = 0
        Width = 6
        Height = 542
        AutoSnap = False
        Color = clSkyBlue
        MinSize = 1
        ParentColor = False
        ExplicitLeft = 250
        ExplicitTop = -10
        ExplicitHeight = 427
      end
      object Tables_List__Left_Panel: TPanel
        Left = 0
        Top = 0
        Width = 200
        Height = 542
        Align = alLeft
        TabOrder = 0
        object Tables_List__Buttons_Panel_Horizontal_Splitter: TSplitter
          Left = 1
          Top = 136
          Width = 198
          Height = 6
          Cursor = crVSplit
          Align = alTop
          AutoSnap = False
          Color = clSkyBlue
          MinSize = 1
          ParentColor = False
          ExplicitTop = 186
        end
        object Tables_List__Buttons_Panel: TPanel
          Left = 1
          Top = 1
          Width = 198
          Height = 135
          Align = alTop
          TabOrder = 0
          DesignSize = (
            198
            135)
          object Tables_List__Page__Close__One_Button: TButton
            Left = 5
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Close one.'
            ImageIndex = 10
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = Tables_List__Page__Close__One_ButtonClick
          end
          object Tables_List__Page__Close__All_Button: TButton
            Left = 40
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Close all.'
            ImageIndex = 11
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = Tables_List__Page__Close__All_ButtonClick
          end
          object Tables_List__Move__Left_Button: TButton
            Left = 80
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Move the tab left.'
            Anchors = [akTop, akRight]
            ImageIndex = 15
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = Tables_List__Move__Left_ButtonClick
          end
          object Tables_List__Move__Right_Button: TButton
            Left = 110
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Move the tab right.'
            Anchors = [akTop, akRight]
            ImageIndex = 16
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = Tables_List__Move__Right_ButtonClick
          end
          object Tables_List__Page__New_Button: TButton
            Left = 170
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Open table.'#13#10#13#10'[Enter, Double-click]'
            Anchors = [akTop, akRight]
            ImageIndex = 0
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = Tables_List__ListBoxDblClick
          end
          object Tables_List__Hide_Button: TButton
            Left = 140
            Top = 0
            Width = 25
            Height = 15
            Hint = 'Hide panel.'
            Anchors = [akTop, akRight]
            ImageIndex = 19
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            OnClick = Tables_List__Hide_ButtonClick
          end
          object Tables_List__Search_GroupBox: TGroupBox
            AlignWithMargins = True
            Left = 11
            Top = 31
            Width = 176
            Height = 100
            Margins.Left = 10
            Margins.Top = 30
            Margins.Right = 10
            Margins.Bottom = 5
            Align = alTop
            Caption = 'Search'
            TabOrder = 6
            DesignSize = (
              176
              100)
            object Tables_List__Search_Edit: TEdit
              AlignWithMargins = True
              Left = 12
              Top = 17
              Width = 152
              Height = 23
              Hint = 'Ctrl + Enter - open table and open table data;'#13#10'Enter - open.'
              Margins.Left = 10
              Margins.Top = 0
              Margins.Right = 10
              Margins.Bottom = 5
              Align = alTop
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnChange = Tables_List__Search_Change
              OnKeyDown = Tables_List__Search_EditKeyDown
            end
            object Tables_List__Search__Case_Insensitive_CheckBox: TCheckBox
              AlignWithMargins = True
              Left = 12
              Top = 50
              Width = 152
              Height = 17
              Margins.Left = 10
              Margins.Top = 5
              Margins.Right = 10
              Margins.Bottom = 5
              Align = alTop
              Caption = 'Case insensitive'
              Checked = True
              State = cbChecked
              TabOrder = 1
              OnClick = Tables_List__Search_Change
            end
            object Tables_List__Search__Partial_Key_CheckBox: TCheckBox
              AlignWithMargins = True
              Left = 12
              Top = 77
              Width = 152
              Height = 17
              Margins.Left = 10
              Margins.Top = 5
              Margins.Right = 10
              Margins.Bottom = 5
              Align = alTop
              Caption = 'Partial key'
              Checked = True
              State = cbChecked
              TabOrder = 2
              OnClick = Tables_List__Search_Change
            end
            object Tables_List__Search__Prior_Button: TButton
              Left = 138
              Top = 45
              Width = 25
              Height = 25
              Hint = 
                'Search prior.'#13#10#13#10'[Ctrl + Enter - open table and open table data]' +
                #13#10'[Shift + Enter - open table]'
              Anchors = [akTop, akRight]
              ImageIndex = 13
              Images = Shared_DataModule.ImageList1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              OnClick = Tables_List__Search__Prior_ButtonClick
              OnKeyDown = Tables_List__Search_ButtonKeyDown
            end
            object Tables_List__Search__Next_Button: TButton
              Left = 138
              Top = 70
              Width = 25
              Height = 25
              Hint = 
                'Search next.'#13#10#13#10'[Ctrl + Enter - open table and open table data]'#13 +
                #10'[Shift + Enter - open table]'
              Anchors = [akTop, akRight]
              ImageIndex = 14
              Images = Shared_DataModule.ImageList1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              OnClick = Tables_List__Search__Next_ButtonClick
              OnKeyDown = Tables_List__Search_ButtonKeyDown
            end
          end
        end
        object Tables_List__ListBox: TListBox
          Left = 1
          Top = 142
          Width = 198
          Height = 399
          Align = alClient
          ItemHeight = 15
          PopupMenu = Tables_List__PopupMenu
          TabOrder = 1
          OnClick = Tables_List__ListBoxClick
          OnDblClick = Tables_List__ListBoxDblClick
          OnKeyDown = Tables_List__ListBoxKeyDown
        end
      end
      object Tables_List__PageControl: TPageControl
        Left = 206
        Top = 0
        Width = 320
        Height = 542
        Align = alClient
        TabOrder = 1
        OnDragDrop = Tables_List__PageControlDragDrop
        OnDragOver = Tables_List__PageControlDragOver
        OnMouseDown = Tables_List__PageControlMouseDown
      end
    end
    object Users_List_TabSheet: TTabSheet
      Caption = 'Users'
      ImageIndex = 33
    end
    object Views_List_TabSheet: TTabSheet
      Caption = 'Views'
      ImageIndex = 29
      object Views__List_Vertical_Splitter: TSplitter
        Left = 200
        Top = 0
        Width = 6
        Height = 542
        Color = clSkyBlue
        ParentColor = False
        ExplicitLeft = 5
        ExplicitHeight = 492
      end
      object Views_List__PageControl: TPageControl
        Left = 206
        Top = 0
        Width = 320
        Height = 542
        Align = alClient
        TabOrder = 1
        OnDragDrop = Views_List__PageControlDragDrop
        OnDragOver = Views_List__PageControlDragOver
        OnMouseDown = Views_List__PageControlMouseDown
      end
      object Views_List__Left_Panel: TPanel
        Left = 0
        Top = 0
        Width = 200
        Height = 542
        Align = alLeft
        TabOrder = 0
        object Views_List__Buttons_Panel_Horizontal_Splitter: TSplitter
          Left = 1
          Top = 136
          Width = 198
          Height = 6
          Cursor = crVSplit
          Align = alTop
          AutoSnap = False
          Color = clSkyBlue
          MinSize = 1
          ParentColor = False
          ExplicitTop = 186
        end
        object Views_List__Buttons_Panel: TPanel
          Left = 1
          Top = 1
          Width = 198
          Height = 135
          Align = alTop
          TabOrder = 0
          DesignSize = (
            198
            135)
          object Views_List__Page__Close__One_Button: TButton
            Left = 5
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Close one.'
            ImageIndex = 10
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = Views_List__Page__Close__One_ButtonClick
          end
          object Views_List__Page__Close__All_Button: TButton
            Left = 40
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Close all.'
            ImageIndex = 11
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = Views_List__Page__Close__All_ButtonClick
          end
          object Views_List__Move__Left_Button: TButton
            Left = 80
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Move the tab left.'
            Anchors = [akTop, akRight]
            ImageIndex = 15
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = Views_List__Move__Left_ButtonClick
          end
          object Views_List__Move__Right_Button: TButton
            Left = 110
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Move the tab right.'
            Anchors = [akTop, akRight]
            ImageIndex = 16
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 3
            OnClick = Views_List__Move__Right_ButtonClick
          end
          object Views_List__Page__New_Button: TButton
            Left = 170
            Top = 5
            Width = 25
            Height = 25
            Hint = 'Open view.'
            Anchors = [akTop, akRight]
            ImageIndex = 0
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 5
            OnClick = Views_List__ListBoxDblClick
          end
          object Views_List__Hide_Button: TButton
            Left = 140
            Top = 0
            Width = 25
            Height = 15
            Hint = 'Hide panel.'
            Anchors = [akTop, akRight]
            ImageIndex = 19
            Images = Shared_DataModule.ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            OnClick = Views_List__Hide_ButtonClick
          end
          object Views_List__Search_GroupBox: TGroupBox
            AlignWithMargins = True
            Left = 11
            Top = 31
            Width = 176
            Height = 100
            Margins.Left = 10
            Margins.Top = 30
            Margins.Right = 10
            Margins.Bottom = 5
            Align = alTop
            Caption = 'Search'
            TabOrder = 6
            DesignSize = (
              176
              100)
            object Views_List__Search_Edit: TEdit
              AlignWithMargins = True
              Left = 12
              Top = 17
              Width = 152
              Height = 23
              Hint = 
                'Ctrl + Enter - open and open view data;'#13#10'Shift + Enter - open an' +
                'd edit;'#13#10'Enter - open.'
              Margins.Left = 10
              Margins.Top = 0
              Margins.Right = 10
              Margins.Bottom = 5
              Align = alTop
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnChange = Views_List__Search_Change
              OnKeyDown = Views_List__Search_EditKeyDown
            end
            object Views_List__Search__Case_Insensitive_CheckBox: TCheckBox
              AlignWithMargins = True
              Left = 12
              Top = 50
              Width = 152
              Height = 17
              Margins.Left = 10
              Margins.Top = 5
              Margins.Right = 10
              Margins.Bottom = 5
              Align = alTop
              Caption = 'Case insensitive'
              Checked = True
              State = cbChecked
              TabOrder = 1
              OnClick = Views_List__Search_Change
            end
            object Views_List__Search__Partial_Key_CheckBox: TCheckBox
              AlignWithMargins = True
              Left = 12
              Top = 77
              Width = 152
              Height = 17
              Margins.Left = 10
              Margins.Top = 5
              Margins.Right = 10
              Margins.Bottom = 5
              Align = alTop
              Caption = 'Partial key'
              Checked = True
              State = cbChecked
              TabOrder = 2
              OnClick = Views_List__Search_Change
            end
            object Views_List__Search__Prior_Button: TButton
              Left = 138
              Top = 45
              Width = 25
              Height = 25
              Hint = 
                'Search prior.'#13#10#13#10'[Ctrl + Enter - open and open view data]'#13#10'[Ctrl' +
                ' + Shift + Enter - open and edit]'#13#10'[Shift + Enter - open]'
              Anchors = [akTop, akRight]
              ImageIndex = 13
              Images = Shared_DataModule.ImageList1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              OnClick = Views_List__Search__Prior_ButtonClick
              OnKeyDown = Views_List__Search_ButtonKeyDown
            end
            object Views_List__Search__Next_Button: TButton
              Left = 138
              Top = 70
              Width = 25
              Height = 25
              Hint = 
                'Search next.'#13#10#13#10'[Ctrl + Enter - open and open view data]'#13#10'[Ctrl ' +
                '+ Shift + Enter - open and edit]'#13#10'[Shift + Enter - open]'
              Anchors = [akTop, akRight]
              ImageIndex = 14
              Images = Shared_DataModule.ImageList1
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              OnClick = Views_List__Search__Next_ButtonClick
              OnKeyDown = Views_List__Search_ButtonKeyDown
            end
          end
        end
        object Views_List__ListBox: TListBox
          Left = 1
          Top = 142
          Width = 198
          Height = 399
          Align = alClient
          ItemHeight = 15
          PopupMenu = Views_List__PopupMenu
          TabOrder = 1
          OnClick = Views_List__ListBoxClick
          OnDblClick = Views_List__ListBoxDblClick
          OnKeyDown = Views_List__ListBoxKeyDown
        end
      end
    end
  end
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Left = 60
    Top = 20
  end
  object FDConnection1: TFDConnection
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 60
    Top = 90
  end
  object FDPhysMSAccessDriverLink1: TFDPhysMSAccessDriverLink
    Left = 70
    Top = 225
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    Left = 225
    Top = 225
  end
  object FDPhysADSDriverLink1: TFDPhysADSDriverLink
    Left = 55
    Top = 170
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 185
    Top = 170
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    Left = 360
    Top = 225
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 305
    Top = 170
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 60
    Top = 285
  end
  object FDTransaction1: TFDTransaction
    Connection = FDConnection1
    Left = 160
    Top = 90
  end
  object ADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 257
    Top = 20
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 257
    Top = 90
  end
  object Tables_List__PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 472
    Top = 80
    object Tables_List__Page__New_MenuItem: TMenuItem
      Caption = 'Open table [Enter, Double-click]'
      ImageIndex = 0
      OnClick = Tables_List__ListBoxDblClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Tables_List__Table__Add_MenuItem: TMenuItem
      Caption = 'Add table [Insert]'
      ImageIndex = 20
      OnClick = Tables_List__Table__Add_MenuItemClick
    end
    object Tables_List__Table__Delete_MenuItem: TMenuItem
      Caption = 'Delete table [Ctrl + Delete]'
      ImageIndex = 2
      OnClick = Tables_List__Table__Delete_MenuItemClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Tables_List__Refresh_MenuItem: TMenuItem
      Caption = 'Refresh [Ctrl + R]'
      ImageIndex = 3
      OnClick = Tables_List__Refresh_MenuItemClick
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Tables_List__Close__One_MenuItem: TMenuItem
      Caption = 'Close one'
      ImageIndex = 10
      OnClick = Tables_List__Page__Close__One_ButtonClick
    end
    object Tables_List__Close__All_MenuItem: TMenuItem
      Caption = 'Close all'
      ImageIndex = 11
      OnClick = Tables_List__Page__Close__All_ButtonClick
    end
  end
  object Stored_Procedures_List__PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 472
    Top = 20
    object Stored_Procedures_List__Page__New_MenuItem: TMenuItem
      Caption = 'Open stored procedure [Enter, Double-click]'
      ImageIndex = 0
      OnClick = Stored_Procedures_List__ListBoxDblClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object Stored_Procedures_List__Stored_Procedure__Add__Modal__MenuItem: TMenuItem
      Caption = 'Add stored procedure (modal) [Insert]'
      ImageIndex = 20
      OnClick = Stored_Procedures_List__Stored_Procedure__Add__Modal__MenuItemClick
    end
    object Stored_Procedures_List__Stored_Procedure__Add__MenuItem: TMenuItem
      Caption = 'Add stored procedure [Ctrl + Insert]'
      ImageIndex = 20
      OnClick = Stored_Procedures_List__Stored_Procedure__Add__Modal__MenuItemClick
    end
    object Stored_Procedures_List__Stored_Procedure__Delete__MenuItem: TMenuItem
      Caption = 'Delete stored procedure [Ctrl + Delete]'
      ImageIndex = 2
      OnClick = Stored_Procedures_List__Stored_Procedure__Delete__MenuItemClick
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Stored_Procedures_List__Refresh_MenuItem: TMenuItem
      Caption = 'Refresh [Ctrl + R]'
      ImageIndex = 3
      OnClick = Stored_Procedures_List__Refresh_MenuItemClick
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object Stored_Procedures_List__Close__One_MenuItem: TMenuItem
      Caption = 'Close one'
      ImageIndex = 10
      OnClick = Stored_Procedures_List__Page__Close__One_ButtonClick
    end
    object Stored_Procedures_List__Close__All_MenuItem: TMenuItem
      Caption = 'Close all'
      ImageIndex = 11
      OnClick = Stored_Procedures_List__Page__Close__All_ButtonClick
    end
  end
  object Views_List__PopupMenu: TPopupMenu
    Images = Shared_DataModule.ImageList1
    Left = 472
    Top = 140
    object Views_List__Page__New_MenuItem: TMenuItem
      Caption = 'Open view [Enter, Double-click]'
      ImageIndex = 0
      OnClick = Views_List__ListBoxDblClick
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object Views_List__View__Add__Modal__MenuItem: TMenuItem
      Caption = 'Add view (modal) [Insert]'
      ImageIndex = 20
      OnClick = Views_List__View__Add__Modal__MenuItemClick
    end
    object Views_List__View__Add__MenuItem: TMenuItem
      Caption = 'Add view [Ctrl + Insert]'
      ImageIndex = 20
      OnClick = Views_List__View__Add__Modal__MenuItemClick
    end
    object Views_List__View__Delete__MenuItem: TMenuItem
      Caption = 'Delete view [Ctrl + Delete]'
      ImageIndex = 2
      OnClick = Views_List__View__Delete__MenuItemClick
    end
    object N8: TMenuItem
      Caption = '-'
    end
    object Views_List__Refresh_MenuItem: TMenuItem
      Caption = 'Refresh [Ctrl + R]'
      ImageIndex = 3
      OnClick = Views_List__Refresh_MenuItemClick
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object Views_List__Close__One_MenuItem: TMenuItem
      Caption = 'Close one'
      ImageIndex = 10
      OnClick = Views_List__Page__Close__One_ButtonClick
    end
    object Views_List__Close__All_MenuItem: TMenuItem
      Caption = 'Close all'
      ImageIndex = 11
      OnClick = Views_List__Page__Close__All_ButtonClick
    end
  end
end
