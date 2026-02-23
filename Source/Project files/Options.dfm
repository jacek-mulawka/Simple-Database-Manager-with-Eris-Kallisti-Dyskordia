object Options_Form: TOptions_Form
  Left = 0
  Top = 0
  Margins.Bottom = 5
  Caption = 'Options'
  ClientHeight = 762
  ClientWidth = 984
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object Bottom_Panel: TPanel
    AlignWithMargins = True
    Left = 10
    Top = 697
    Width = 964
    Height = 60
    Margins.Left = 10
    Margins.Top = 0
    Margins.Right = 10
    Margins.Bottom = 5
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      964
      60)
    object Apply_Hint_Label: TLabel
      Left = 611
      Top = 5
      Width = 335
      Height = 15
      Alignment = taRightJustify
      Anchors = [akTop, akRight]
      Caption = 'To apply settings in all open windows use the reconnect option.'
      ParentShowHint = False
      ShowHint = True
      ExplicitLeft = 511
    end
    object Cancel_Button: TButton
      Left = 879
      Top = 30
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancel'
      ImageIndex = 5
      Images = Shared_DataModule.ImageList1
      ModalResult = 2
      TabOrder = 3
    end
    object Load_Button: TButton
      Left = 100
      Top = 30
      Width = 75
      Height = 25
      Caption = 'Load'
      ImageIndex = 9
      Images = Shared_DataModule.ImageList1
      TabOrder = 1
      OnClick = Load_Save_ButtonClick
    end
    object Ok_Button: TButton
      Left = 790
      Top = 30
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'OK'
      ImageIndex = 4
      Images = Shared_DataModule.ImageList1
      TabOrder = 2
      OnClick = Ok_ButtonClick
    end
    object Save_Button: TButton
      Left = 5
      Top = 30
      Width = 75
      Height = 25
      Caption = 'Save'
      ImageIndex = 8
      Images = Shared_DataModule.ImageList1
      TabOrder = 0
      OnClick = Load_Save_ButtonClick
    end
  end
  object Options_PageControl: TPageControl
    AlignWithMargins = True
    Left = 10
    Top = 5
    Width = 964
    Height = 687
    Margins.Left = 10
    Margins.Top = 5
    Margins.Right = 10
    Margins.Bottom = 5
    ActivePage = Sql_Editor_TabSheet
    Align = alClient
    TabOrder = 0
    object Basic_TabSheet: TTabSheet
      Caption = 'Basic'
      object Form_View__Additional_Component_Show_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 59
        Width = 936
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Form view - show additional components'
        TabOrder = 2
      end
      object Queries_Open_In_Background_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 136
        Width = 936
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Queries (some) open in the background'
        TabOrder = 4
      end
      object System_Tables_Visible_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 447
        Width = 936
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'System tables, roles visible'
        TabOrder = 10
      end
      object Splitter_Show_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 163
        Width = 936
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Show splitters (e.g. form view, stored procedure parameters)'
        TabOrder = 5
      end
      object Sql__Quotation_Sign__Use_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 420
        Width = 936
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'SQL quotation sign use'
        TabOrder = 9
      end
      object Sql__Command_Separator_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 10
        Top = 190
        Width = 936
        Height = 40
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'SQL command separator'
        TabOrder = 6
        object Sql__Command_Separator_Edit: TEdit
          AlignWithMargins = True
          Left = 7
          Top = 17
          Width = 922
          Height = 21
          Margins.Left = 5
          Margins.Top = 0
          Margins.Right = 5
          Margins.Bottom = 0
          Align = alClient
          TabOrder = 0
          ExplicitHeight = 23
        end
      end
      object Sql__External_Function__Parameter_Separator_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 10
        Top = 240
        Width = 936
        Height = 80
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'SQL external function parameter separator'
        TabOrder = 7
        object Sql__External_Function__Parameter_Separator_Memo: TMemo
          Left = 2
          Top = 17
          Width = 932
          Height = 61
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
      object Sql__View__Parameter_Separator_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 10
        Top = 330
        Width = 936
        Height = 80
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'SQL view parameter separator'
        TabOrder = 8
        object Sql__View__Parameter_Separator_Memo: TMemo
          Left = 2
          Top = 17
          Width = 932
          Height = 61
          Align = alClient
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
      object Table__Data_Modify__Editing__Default_State_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 501
        Width = 936
        Height = 17
        Hint = 'Data in the tables defaults to edit mode.'
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Table data editing default state'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 12
      end
      object Log__Auto_Scroll__GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 10
        Top = 86
        Width = 936
        Height = 40
        Hint = 
          'Log automatic scrolling:'#13#10'< 0 - disabled;'#13#10'= 0 - always;'#13#10'> 0 - ' +
          'every <value> seconds.'
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Log automatic scrolling'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        DesignSize = (
          936
          40)
        object Log__Auto_Scroll__Seconds_SpinEdit: TSpinEdit
          Left = 810
          Top = 12
          Width = 120
          Height = 24
          Anchors = [akTop, akRight]
          MaxValue = 0
          MinValue = 0
          ParentShowHint = False
          ShowHint = False
          TabOrder = 0
          Value = 5
        end
      end
      object Sql_Editor__Font__Use_In_Other_Components_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 528
        Width = 936
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Use SQL editor font in other components'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 13
      end
      object Database__Modify__Window__Maximized_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 32
        Width = 936
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Database modify window maximized'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
      end
      object Busy_Notification__Knight_Rider_Equalizer__Disabled_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 5
        Width = 936
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Busy notification ('#39'Knight Rider'#39' equalizer) disabled'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 0
      end
      object Table__Columns_Sort__Keyboard_Select_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 474
        Width = 936
        Height = 17
        Hint = 'Select rows using the keyboard in the table column sorting tab.'
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Table columns sort - keyboard rows select'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 11
      end
    end
    object Data_Presentation_TabSheet: TTabSheet
      Caption = 'Data presentation'
      ImageIndex = 7
      object Data_Presentation__First_Rows_Etiquette_Label: TLabel
        AlignWithMargins = True
        Left = 10
        Top = 260
        Width = 936
        Height = 15
        Hint = 'Display first <value> rows only.'#13#10'Negative value = disabled.'
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'First rows (table data)'
        ParentShowHint = False
        ShowHint = True
        ExplicitWidth = 113
      end
      object Data_Presentation__Data_Value_Format_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 10
        Top = 5
        Width = 936
        Height = 245
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Data value format'
        TabOrder = 0
        object Data_Presentation__Data_Value_Format__Time_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 12
          Top = 202
          Width = 912
          Height = 40
          Hint = 'E.g.:'#13#10'hh:mm:ss'#13#10'hh mm ss.z'#13#10'hh mm ss.zzz'#13#10'h m s am/pm'#13#10'hh-m a/p'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Time'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          object Data_Presentation__Data_Value_Format__Time__Use_CheckBox: TCheckBox
            Left = 710
            Top = 17
            Width = 200
            Height = 21
            Align = alRight
            Caption = 'Use'
            TabOrder = 1
          end
          object Data_Presentation__Data_Value_Format__Time_Edit: TEdit
            AlignWithMargins = True
            Left = 12
            Top = 17
            Width = 688
            Height = 21
            Margins.Left = 10
            Margins.Top = 0
            Margins.Right = 10
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 23
          end
        end
        object Data_Presentation__Data_Value_Format__Real_Numbers_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 12
          Top = 157
          Width = 912
          Height = 40
          Hint = 
            'E.g.:'#13#10'### ### ### ### ### ### ##0.###'#13#10'0.##############'#13#10'### ##' +
            '# ##0.### ### ###'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Real numbers'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          object Data_Presentation__Data_Value_Format__Real_Numbers__Use_CheckBox: TCheckBox
            Left = 710
            Top = 17
            Width = 200
            Height = 21
            Align = alRight
            Caption = 'Use'
            TabOrder = 1
          end
          object Data_Presentation__Data_Value_Format__Real_Numbers_Edit: TEdit
            AlignWithMargins = True
            Left = 12
            Top = 17
            Width = 688
            Height = 21
            Margins.Left = 10
            Margins.Top = 0
            Margins.Right = 10
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 23
          end
        end
        object Data_Presentation__Data_Value_Format__Date_Time_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 12
          Top = 67
          Width = 912
          Height = 40
          Hint = 'E.g.:'#13#10'dd.mm.yyyy hh:mm:ss.zzz'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Date time'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          object Data_Presentation__Data_Value_Format__Date_Time__Use_CheckBox: TCheckBox
            Left = 710
            Top = 17
            Width = 200
            Height = 21
            Align = alRight
            Caption = 'Use'
            TabOrder = 1
          end
          object Data_Presentation__Data_Value_Format__Date_Time_Edit: TEdit
            AlignWithMargins = True
            Left = 12
            Top = 17
            Width = 688
            Height = 21
            Margins.Left = 10
            Margins.Top = 0
            Margins.Right = 10
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 23
          end
        end
        object Data_Presentation__Data_Value_Format__Date_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 12
          Top = 22
          Width = 912
          Height = 40
          Hint = 
            'E.g.:'#13#10'dd.mm.yyyy'#13#10'dd-mm-yyyy'#13#10'yyyy-mm-dd'#13#10'yy mmm ddd'#13#10'd dddd mm' +
            'mm y'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Date'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object Data_Presentation__Data_Value_Format__Date__Use_CheckBox: TCheckBox
            Left = 710
            Top = 17
            Width = 200
            Height = 21
            Align = alRight
            Caption = 'Use'
            TabOrder = 1
          end
          object Data_Presentation__Data_Value_Format__Date_Edit: TEdit
            AlignWithMargins = True
            Left = 12
            Top = 17
            Width = 688
            Height = 21
            Margins.Left = 10
            Margins.Top = 0
            Margins.Right = 10
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 23
          end
        end
        object Data_Presentation__Data_Value_Format__Numbers_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 12
          Top = 112
          Width = 912
          Height = 40
          Hint = 'E.g.:'#13#10'### ### ### ### ### ### ##0'#13#10'0'#13#10'000000'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Numbers'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          object Data_Presentation__Data_Value_Format__Numbers__Use_CheckBox: TCheckBox
            Left = 710
            Top = 17
            Width = 200
            Height = 21
            Align = alRight
            Caption = 'Use'
            TabOrder = 1
          end
          object Data_Presentation__Data_Value_Format__Numbers_Edit: TEdit
            AlignWithMargins = True
            Left = 12
            Top = 17
            Width = 688
            Height = 21
            Margins.Left = 10
            Margins.Top = 0
            Margins.Right = 10
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 23
          end
        end
      end
      object Data_Presentation__First_Rows_SpinEdit: TSpinEdit
        AlignWithMargins = True
        Left = 10
        Top = 280
        Width = 936
        Height = 24
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        MaxValue = 0
        MinValue = 0
        TabOrder = 1
        Value = 0
      end
    end
    object Database__Backup_Restore_TabSheet: TTabSheet
      Caption = 'Database backup / restore'
      ImageIndex = 5
      object Database__Backup__Application__File_Path_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 10
        Top = 5
        Width = 936
        Height = 40
        Hint = 'E.g.:'#13#10'C:\Program Files\Firebird\Firebird_3_0\gbak.exe'
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Database backup application file path'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        object Database__Backup__Application__File_Path__Find_Button: TButton
          AlignWithMargins = True
          Left = 894
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
          OnClick = File_Path__Find_ButtonClick
        end
        object Database__Backup__Application__File_Path_Edit: TEdit
          AlignWithMargins = True
          Left = 12
          Top = 17
          Width = 867
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
      object Database__Create__Application__File_Path_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 10
        Top = 50
        Width = 936
        Height = 40
        Hint = 'E.g.:'#13#10'C:\Program Files\Firebird\Firebird_3_0\isql.exe'
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Database create application file path'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        object Database__Create__Application__File_Path__Find_Button: TButton
          AlignWithMargins = True
          Left = 894
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
          OnClick = File_Path__Find_ButtonClick
        end
        object Database__Create__Application__File_Path_Edit: TEdit
          AlignWithMargins = True
          Left = 12
          Top = 17
          Width = 867
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
      object Database__Correctness_Check_Text_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 10
        Top = 95
        Width = 936
        Height = 110
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Correctness check text'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 2
        object Database__Correctness_Check_Text__Backup_Etiquette_Label: TLabel
          AlignWithMargins = True
          Left = 12
          Top = 22
          Width = 912
          Height = 15
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Backup'
          ParentShowHint = False
          ShowHint = False
          ExplicitWidth = 39
        end
        object Database__Correctness_Check_Text__Restore_Etiquette_Label: TLabel
          AlignWithMargins = True
          Left = 12
          Top = 65
          Width = 912
          Height = 15
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Restore'
          ParentShowHint = False
          ShowHint = False
          ExplicitWidth = 39
        end
        object Database__Correctness_Check_Text__Backup_Edit: TEdit
          AlignWithMargins = True
          Left = 12
          Top = 37
          Width = 912
          Height = 23
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          TabOrder = 0
        end
        object Database__Correctness_Check_Text__Restore_Edit: TEdit
          AlignWithMargins = True
          Left = 12
          Top = 80
          Width = 912
          Height = 23
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          TabOrder = 1
        end
      end
      object Database__Backup__File_Name__Suffix_Default_RadioGroup: TRadioGroup
        AlignWithMargins = True
        Left = 10
        Top = 210
        Width = 936
        Height = 40
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Database backup file name default suffix'
        Columns = 3
        Items.Strings = (
          'none'
          'date'
          'date time')
        TabOrder = 3
      end
    end
    object Fire_Dac_TabSheet: TTabSheet
      Caption = 'FireDac'
      ImageIndex = 2
      object Fire_Dac__Querry__Fetch_Options_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 10
        Top = 5
        Width = 936
        Height = 200
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Querry fetch options'
        TabOrder = 0
        object Fire_Dac__Query__Fetch_Options__Mode_Etiquette_Label: TLabel
          AlignWithMargins = True
          Left = 12
          Top = 27
          Width = 912
          Height = 15
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Mode'
          ParentShowHint = False
          ShowHint = False
          ExplicitWidth = 31
        end
        object Fire_Dac__Query__Fetch_Options__Record_Count_Mode_Etiquette_Label: TLabel
          AlignWithMargins = True
          Left = 12
          Top = 83
          Width = 912
          Height = 15
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Record count mode'
          ExplicitWidth = 105
        end
        object Fire_Dac__Query__Fetch_Options__Rowset_Size_Etiquette_Label: TLabel
          AlignWithMargins = True
          Left = 12
          Top = 139
          Width = 912
          Height = 15
          Margins.Left = 10
          Margins.Top = 10
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Rowset size'
          ExplicitWidth = 60
        end
        object Fire_Dac__Query__Fetch_Options__Mode_ComboBox: TComboBox
          AlignWithMargins = True
          Left = 12
          Top = 47
          Width = 912
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
        end
        object Fire_Dac__Query__Fetch_Options__Record_Count_Mode_ComboBox: TComboBox
          AlignWithMargins = True
          Left = 12
          Top = 103
          Width = 912
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
        object Fire_Dac__Query__Fetch_Options__Rowset_Size_SpinEdit: TSpinEdit
          AlignWithMargins = True
          Left = 12
          Top = 159
          Width = 912
          Height = 24
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
        end
      end
    end
    object Translation_TabSheet: TTabSheet
      Caption = 'Languages'
      ImageIndex = 4
      object Language_Etiquette_Label: TLabel
        AlignWithMargins = True
        Left = 10
        Top = 10
        Width = 936
        Height = 15
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Language'
        ParentShowHint = False
        ShowHint = False
        ExplicitWidth = 52
      end
      object Language_ComboBox: TComboBox
        AlignWithMargins = True
        Left = 10
        Top = 30
        Width = 936
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
        OnKeyDown = Language_ComboBoxKeyDown
      end
    end
    object Sql_Editor_TabSheet: TTabSheet
      Caption = 'SQL editor'
      ImageIndex = 1
      object Sql_Editor__Right_Vertical_Splitter: TSplitter
        Left = 595
        Top = 0
        Width = 6
        Height = 657
        Align = alRight
        AutoSnap = False
        Color = clSkyBlue
        MinSize = 1
        ParentColor = False
        ExplicitLeft = 147
        ExplicitTop = 19
        ExplicitHeight = 245
      end
      object Sql_Editor__Left_Panel: TPanel
        Left = 0
        Top = 0
        Width = 595
        Height = 657
        Align = alClient
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        DesignSize = (
          595
          657)
        object Caret_Position_Label: TLabel
          AlignWithMargins = True
          Left = 11
          Top = 379
          Width = 573
          Height = 15
          Hint = 'Caret position, text length.'
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = '<?> / <?> : <?>'
          ParentShowHint = False
          ShowHint = True
          Layout = tlCenter
          ExplicitTop = 352
          ExplicitWidth = 83
        end
        object Sql_Editor__Code__Completion_Window_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 11
          Top = 72
          Width = 573
          Height = 66
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Code completion window'
          TabOrder = 4
          object Sql_Editor__Code__Completion_Window__Default__Width_GroupBox: TGroupBox
            AlignWithMargins = True
            Left = 421
            Top = 17
            Width = 150
            Height = 47
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alRight
            Caption = 'Default width'
            TabOrder = 1
            object Sql_Editor__Code__Completion_Window__Default__Width_SpinEdit: TSpinEdit
              AlignWithMargins = True
              Left = 7
              Top = 17
              Width = 136
              Height = 24
              Margins.Left = 5
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alClient
              MaxValue = 0
              MinValue = 0
              TabOrder = 0
              Value = 0
            end
          end
          object Sql_Editor__Code__Completion_Window__Default__Lines_In_Window_GroupBox: TGroupBox
            AlignWithMargins = True
            Left = 2
            Top = 17
            Width = 419
            Height = 47
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            Caption = 'Lines in window'
            TabOrder = 0
            object Sql_Editor__Code__Completion_Window__Default__Lines_In_Window_SpinEdit: TSpinEdit
              AlignWithMargins = True
              Left = 7
              Top = 17
              Width = 405
              Height = 24
              Margins.Left = 5
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 5
              Align = alClient
              MaxValue = 0
              MinValue = 0
              TabOrder = 0
              Value = 0
            end
          end
        end
        object Sql_Editor__Execute__Automatic_Detection_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 28
          Width = 573
          Height = 17
          Hint = 
            'Automatically detect whether to use '#39'Query execute'#39' or '#39'Command ' +
            'execute'#39' button.'#13#10#13#10'Will use '#39'Command execute'#39' when the SQL text' +
            ' contains words like: alter, create, delete, drop, insert, recre' +
            'ate, set, update etc.'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Automatically execute detection'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
        end
        object Sql_Editor__Transactions_Automatic_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 50
          Width = 573
          Height = 17
          Hint = 
            'Automatically begin transaction (if there is no active transacti' +
            'on) when the SQL text contains words like: delete, insert, updat' +
            'e etc.'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Automatically transaction begining'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
        end
        object Sql_Text_Memo: TMemo
          Left = 5
          Top = 445
          Width = 200
          Height = 150
          Lines.Strings = (
            'select COUNTRY.COUNTRY'
            '     , COUNTRY.CURRENCY'
            ''
            '     , CUSTOMER.CUST_NO'
            '     , CUSTOMER.CUSTOMER'
            '     , CUSTOMER.POSTAL_CODE'
            '     '
            '     , ('
            '         select count( COUNTRY.COUNTRY ) '
            '         from COUNTRY'
            '       ) as COUNTRY__COUNT'
            ''
            'from COUNTRY'
            'left join CUSTOMER on CUSTOMER.COUNTRY = COUNTRY.COUNTRY'
            'where CUSTOMER.CUST_NO is not null'
            'order by CUSTOMER.POSTAL_CODE')
          ScrollBars = ssBoth
          TabOrder = 13
          Visible = False
          OnClick = Sql_Text_MemoClick
          OnKeyUp = Sql_Text_MemoKeyUp
        end
        object Sql_Text_SynEdit: TSynEdit
          Left = 1
          Top = 394
          Width = 593
          Height = 262
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Consolas'
          Font.Style = []
          Font.Quality = fqClearTypeNatural
          TabOrder = 14
          OnClick = Sql_Text_SynEditClick
          OnEnter = Sql_Text_SynEditEnter
          OnKeyDown = Sql_Text_SynEditKeyDown
          OnKeyUp = Sql_Text_SynEditKeyUp
          UseCodeFolding = False
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -11
          Gutter.Font.Name = 'Consolas'
          Gutter.Font.Style = []
          Gutter.ShowLineNumbers = True
          Gutter.Bands = <
            item
              Kind = gbkMarks
              Width = 13
            end
            item
              Kind = gbkLineNumbers
            end
            item
              Kind = gbkFold
            end
            item
              Kind = gbkTrackChanges
            end
            item
              Kind = gbkMargin
              Width = 3
            end>
          Lines.Strings = (
            'select COUNTRY.COUNTRY'
            '     , COUNTRY.CURRENCY'
            ''
            '     , CUSTOMER.CUST_NO'
            '     , CUSTOMER.CUSTOMER'
            '     , CUSTOMER.POSTAL_CODE'
            '     '
            '     , ('
            '         select count( COUNTRY.COUNTRY ) '
            '         from COUNTRY'
            '       ) as COUNTRY__COUNT'
            ''
            'from COUNTRY'
            'left join CUSTOMER on CUSTOMER.COUNTRY = COUNTRY.COUNTRY'
            'where CUSTOMER.CUST_NO is not null'
            'order by CUSTOMER.POSTAL_CODE')
          RightEdge = 255
          ScrollbarAnnotations = <>
          TabWidth = 2
          WantTabs = True
          OnReplaceText = Sql_Text_SynEditReplaceText
          ExplicitTop = 550
          ExplicitHeight = 106
        end
        object Sql_Editor__Comments_Delete_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 222
          Width = 573
          Height = 17
          Hint = 'Delete comments from SQL commands.'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Delete comments'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
        end
        object Sql_Editor__Code__Dent_Width_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 11
          Top = 143
          Width = 573
          Height = 47
          Hint = 
            'Indents / outdents a selected code line or block by width (chara' +
            'cters count).'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Code dent width'
          TabOrder = 5
          object Sql_Editor__Code__Dent_Width_SpinEdit: TSpinEdit
            AlignWithMargins = True
            Left = 7
            Top = 17
            Width = 559
            Height = 24
            Margins.Left = 5
            Margins.Top = 0
            Margins.Right = 5
            Margins.Bottom = 5
            Align = alClient
            MaxValue = 0
            MinValue = 0
            TabOrder = 0
            Value = 0
          end
        end
        object Sql_Editor__Close_Prompt_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 195
          Width = 573
          Height = 17
          Hint = 'Prompt before closing SQL editor if text or data are not empty.'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Close prompt'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
        end
        object Sql_Editor__Database_Connection__Separated_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 303
          Width = 573
          Height = 17
          Hint = 'Every tab has own database connection.'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Separated database connection'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 10
          ExplicitTop = 276
        end
        object Sql_Editor__Execute__Selected_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 249
          Width = 573
          Height = 17
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Execute selected SQL only'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 8
        end
        object Sql_Editor__Keyboard__Shortcuts__Switch__Output_Save__With__Text_File_Save_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 330
          Width = 573
          Height = 17
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 
            'Switch keyboard shortcuts '#39'Save query output as csv'#39' with '#39'Save ' +
            'file'#39
          ParentShowHint = False
          ShowHint = True
          TabOrder = 11
          ExplicitTop = 303
        end
        object Sql_Editor__Bookmarks__Toggle__With__Line_Color_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 357
          Width = 573
          Height = 17
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Toggle bookmarks with line color'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 12
          ExplicitTop = 330
        end
        object Sql_Editor__Block_Execute__Automatic_Detection_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 6
          Width = 573
          Height = 17
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Automatically '#39'block execute'#39' detection'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
        object Sql_Editor__Font_Button: TButton
          Left = 504
          Top = 5
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Font'
          TabOrder = 0
          OnClick = Sql_Editor__Font_ButtonClick
        end
        object Sql_Editor__Error__Caret_Position__Set_CheckBox: TCheckBox
          AlignWithMargins = True
          Left = 11
          Top = 276
          Width = 573
          Height = 17
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Indicate error locations with caret'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 9
          ExplicitLeft = 9
        end
      end
      object Sql_Editor__Right_Panel: TPanel
        Left = 601
        Top = 0
        Width = 355
        Height = 657
        Align = alRight
        TabOrder = 1
        object Sql_Editor__Query_Output_Save_Field_Format_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 11
          Top = 70
          Width = 333
          Height = 215
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Query output save field format'
          TabOrder = 1
          object Sql_Editor__Query_Output_Save_Field_Format__Date_Etiquette_Label: TLabel
            AlignWithMargins = True
            Left = 12
            Top = 22
            Width = 309
            Height = 15
            Hint = 
              'E.g.:'#13#10'dd.mm.yyyy'#13#10'dd-mm-yyyy'#13#10'yyyy-mm-dd'#13#10'yy mmm ddd'#13#10'd dddd mm' +
              'mm y'
            Margins.Left = 10
            Margins.Top = 5
            Margins.Right = 10
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Date'
            ParentShowHint = False
            ShowHint = True
            ExplicitWidth = 24
          end
          object Sql_Editor__Query_Output_Save_Field_Format__Real_Numbers_Etiquette_Label: TLabel
            AlignWithMargins = True
            Left = 12
            Top = 65
            Width = 309
            Height = 15
            Hint = 
              'E.g.:'#13#10'### ### ### ### ### ### ##0.###'#13#10'0.##############'#13#10'### ##' +
              '# ##0.### ### ###'
            Margins.Left = 10
            Margins.Top = 5
            Margins.Right = 10
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Real numbers'
            ParentShowHint = False
            ShowHint = True
            ExplicitWidth = 72
          end
          object Sql_Editor__Query_Output_Save_Field_Format__Time_Etiquette_Label: TLabel
            AlignWithMargins = True
            Left = 12
            Top = 108
            Width = 309
            Height = 15
            Hint = 'E.g.:'#13#10'hh:mm:ss'#13#10'hh mm ss.zzz'#13#10'h m s am/pm'#13#10'hh-m a/p'
            Margins.Left = 10
            Margins.Top = 5
            Margins.Right = 10
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Time'
            ParentShowHint = False
            ShowHint = True
            ExplicitWidth = 27
          end
          object Sql_Editor__Query_Output_Save_Field_Format__Date_Edit: TEdit
            AlignWithMargins = True
            Left = 12
            Top = 37
            Width = 309
            Height = 23
            Margins.Left = 10
            Margins.Top = 0
            Margins.Right = 10
            Margins.Bottom = 0
            Align = alTop
            TabOrder = 0
          end
          object Sql_Editor__Query_Output_Save_Field_Format__Real_Numbers_Edit: TEdit
            AlignWithMargins = True
            Left = 12
            Top = 80
            Width = 309
            Height = 23
            Margins.Left = 10
            Margins.Top = 0
            Margins.Right = 10
            Margins.Bottom = 0
            Align = alTop
            TabOrder = 1
          end
          object Sql_Editor__Query_Output_Save_Field_Format__Time_Edit: TEdit
            AlignWithMargins = True
            Left = 12
            Top = 123
            Width = 309
            Height = 23
            Margins.Left = 10
            Margins.Top = 0
            Margins.Right = 10
            Margins.Bottom = 0
            Align = alTop
            TabOrder = 2
          end
          object Sql_Editor__Query_Output_Save_Field_Format__Separators_GroupBox: TGroupBox
            AlignWithMargins = True
            Left = 12
            Top = 151
            Width = 309
            Height = 59
            Margins.Left = 10
            Margins.Top = 5
            Margins.Right = 10
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Separators'
            TabOrder = 3
            object Sql_Editor__Query_Output_Save_Field_Format__Separator__Decimal_GroupBox: TGroupBox
              AlignWithMargins = True
              Left = 227
              Top = 17
              Width = 80
              Height = 40
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              Align = alRight
              Caption = 'Decimal'
              TabOrder = 1
              object Sql_Editor__Query_Output_Save_Field_Format__Separator__Decimal_Edit: TEdit
                AlignWithMargins = True
                Left = 7
                Top = 17
                Width = 66
                Height = 21
                Margins.Left = 5
                Margins.Top = 0
                Margins.Right = 5
                Margins.Bottom = 0
                Align = alClient
                TabOrder = 0
                ExplicitHeight = 23
              end
            end
            object Sql_Editor__Query_Output_Save_Field_Format__Separator__Date_Time_GroupBox: TGroupBox
              AlignWithMargins = True
              Left = 2
              Top = 17
              Width = 225
              Height = 40
              Margins.Left = 0
              Margins.Top = 0
              Margins.Right = 0
              Margins.Bottom = 0
              Align = alClient
              Caption = 'Date time'
              TabOrder = 0
              object Sql_Editor__Query_Output_Save_Field_Format__Separator__Date_Time_Edit: TEdit
                AlignWithMargins = True
                Left = 7
                Top = 17
                Width = 211
                Height = 21
                Margins.Left = 5
                Margins.Top = 0
                Margins.Right = 5
                Margins.Bottom = 0
                Align = alClient
                TabOrder = 0
                ExplicitHeight = 23
              end
            end
          end
        end
        object Sql_Editor__Highlights_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 11
          Top = 290
          Width = 333
          Height = 145
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Highlights'
          TabOrder = 2
          object Sql_Editor__Highlights_PageControl: TPageControl
            Left = 2
            Top = 17
            Width = 329
            Height = 126
            ActivePage = Sql_Editor__Highlights__Syntax_TabSheet
            Align = alClient
            TabOrder = 0
            object Sql_Editor__Highlights__Brackets_TabSheet: TTabSheet
              Caption = 'Brackets'
              ImageIndex = 1
              object Sql_Editor__Highlights__Brackets__Color__Background_Etiquette_Label: TLabel
                AlignWithMargins = True
                Left = 10
                Top = 5
                Width = 301
                Height = 15
                Margins.Left = 10
                Margins.Top = 5
                Margins.Right = 10
                Margins.Bottom = 0
                Align = alTop
                Caption = 'Background'
                ParentShowHint = False
                ShowHint = False
                ExplicitWidth = 64
              end
              object Sql_Editor__Highlights__Brackets__Color__Border_Etiquette_Label: TLabel
                AlignWithMargins = True
                Left = 10
                Top = 53
                Width = 301
                Height = 15
                Margins.Left = 10
                Margins.Top = 5
                Margins.Right = 10
                Margins.Bottom = 0
                Align = alTop
                Caption = 'Border'
                ParentShowHint = False
                ShowHint = False
                ExplicitWidth = 35
              end
              object Sql_Editor__Highlights__Brackets__Color__Background_ColorBox: TColorBox
                AlignWithMargins = True
                Left = 10
                Top = 23
                Width = 301
                Height = 22
                Margins.Left = 10
                Margins.Right = 10
                Align = alTop
                Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbCustomColor, cbPrettyNames, cbCustomColors]
                DropDownCount = 40
                TabOrder = 0
              end
              object Sql_Editor__Highlights__Brackets__Color__Border_ColorBox: TColorBox
                AlignWithMargins = True
                Left = 10
                Top = 71
                Width = 301
                Height = 22
                Margins.Left = 10
                Margins.Right = 10
                Align = alTop
                Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbCustomColor, cbPrettyNames, cbCustomColors]
                DropDownCount = 40
                TabOrder = 1
              end
            end
            object Sql_Editor__Highlights__Lines_TabSheet: TTabSheet
              Caption = 'Lines'
              ImageIndex = 3
              object Sql_Editor__Highlights__Lines__Active__Color_Etiquette_Label: TLabel
                AlignWithMargins = True
                Left = 10
                Top = 5
                Width = 301
                Height = 15
                Margins.Left = 10
                Margins.Top = 5
                Margins.Right = 10
                Margins.Bottom = 0
                Align = alTop
                Caption = 'Active line'
                ParentShowHint = False
                ShowHint = False
                ExplicitWidth = 55
              end
              object Sql_Editor__Highlights__Lines__Active__Color__ColorBox: TColorBox
                AlignWithMargins = True
                Left = 10
                Top = 23
                Width = 301
                Height = 22
                Margins.Left = 10
                Margins.Right = 10
                Align = alTop
                Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbCustomColor, cbPrettyNames, cbCustomColors]
                DropDownCount = 40
                TabOrder = 0
              end
            end
            object Sql_Editor__Highlights__Syntax_TabSheet: TTabSheet
              Caption = 'Syntax'
              ImageIndex = 2
              object Sql_Editor__Highlights__Syntax_Etiquette_Label: TLabel
                AlignWithMargins = True
                Left = 10
                Top = 5
                Width = 301
                Height = 15
                Margins.Left = 10
                Margins.Top = 5
                Margins.Right = 10
                Margins.Bottom = 5
                Align = alTop
                Caption = 'Syntax'
                ParentShowHint = False
                ShowHint = False
                ExplicitWidth = 34
              end
              object Sql_Editor__Highlights__Syntax_ComboBox: TComboBox
                AlignWithMargins = True
                Left = 10
                Top = 25
                Width = 301
                Height = 21
                Margins.Left = 10
                Margins.Top = 0
                Margins.Right = 10
                Margins.Bottom = 5
                Align = alTop
                Style = csOwnerDrawFixed
                DropDownCount = 40
                DropDownWidth = 400
                ItemHeight = 15
                TabOrder = 0
              end
              object Sql_Editor__Highlights__Syntax__Brackets__Angle_CheckBox: TCheckBox
                Left = 10
                Top = 55
                Width = 40
                Height = 17
                Hint = 'Highlight angle brackets.'
                Caption = '< >'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 1
              end
              object Sql_Editor__Highlights__Syntax__Brackets__Curly_CheckBox: TCheckBox
                Left = 65
                Top = 55
                Width = 40
                Height = 17
                Hint = 'Highlight curly brackets.'
                Caption = '{ }'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 2
              end
              object Sql_Editor__Highlights__Syntax__Brackets__Round_CheckBox: TCheckBox
                Left = 115
                Top = 55
                Width = 40
                Height = 17
                Hint = 'Highlight round brackets.'
                Caption = '( )'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 3
              end
              object Sql_Editor__Highlights__Syntax__Brackets__Square_CheckBox: TCheckBox
                Left = 170
                Top = 55
                Width = 40
                Height = 17
                Hint = 'Highlight square brackets.'
                Caption = '[ ]'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 4
              end
              object Sql_Editor__Highlights__Syntax__Brackets__All_Pairs_CheckBox: TCheckBox
                Left = 5
                Top = 75
                Width = 110
                Height = 17
                Hint = 
                  'Highlight all selected brackets pairs.'#13#10#13#10'When a text is long it' +
                  ' may works slowly.'
                Caption = 'All pairs'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 5
              end
              object Sql_Editor__Highlights__Syntax__Brackets__Marked_Only_CheckBox: TCheckBox
                Left = 120
                Top = 75
                Width = 100
                Height = 17
                Hint = 'Highlight only marked brackets.'
                Caption = 'Marked only'
                ParentShowHint = False
                ShowHint = True
                TabOrder = 6
              end
            end
            object Sql_Editor__Highlights__Words_TabSheet: TTabSheet
              Caption = 'Words'
              object Sql_Editor__Highlights__Words__Color__Background_Etiquette_Label: TLabel
                AlignWithMargins = True
                Left = 10
                Top = 5
                Width = 301
                Height = 15
                Margins.Left = 10
                Margins.Top = 5
                Margins.Right = 10
                Margins.Bottom = 0
                Align = alTop
                Caption = 'Background'
                ParentShowHint = False
                ShowHint = False
                ExplicitWidth = 64
              end
              object Sql_Editor__Highlights__Words__Color__Border_Etiquette_Label: TLabel
                AlignWithMargins = True
                Left = 10
                Top = 53
                Width = 301
                Height = 15
                Margins.Left = 10
                Margins.Top = 5
                Margins.Right = 10
                Margins.Bottom = 0
                Align = alTop
                Caption = 'Border'
                ParentShowHint = False
                ShowHint = False
                ExplicitWidth = 35
              end
              object Sql_Editor__Highlights__Words__Color__Background_ColorBox: TColorBox
                AlignWithMargins = True
                Left = 10
                Top = 23
                Width = 301
                Height = 22
                Margins.Left = 10
                Margins.Right = 10
                Align = alTop
                Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbCustomColor, cbPrettyNames, cbCustomColors]
                DropDownCount = 40
                TabOrder = 0
              end
              object Sql_Editor__Highlights__Words__Color__Border_ColorBox: TColorBox
                AlignWithMargins = True
                Left = 10
                Top = 71
                Width = 301
                Height = 22
                Margins.Left = 10
                Margins.Right = 10
                Align = alTop
                Style = [cbStandardColors, cbExtendedColors, cbSystemColors, cbIncludeNone, cbCustomColor, cbPrettyNames, cbCustomColors]
                DropDownCount = 40
                TabOrder = 1
              end
            end
          end
        end
        object Csv__File_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 11
          Top = 6
          Width = 333
          Height = 59
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Csv file'
          TabOrder = 0
          object Csv__File__Text_Qualifier_GroupBox: TGroupBox
            AlignWithMargins = True
            Left = 251
            Top = 17
            Width = 80
            Height = 40
            Hint = 'Csv text qualifier.'
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alRight
            Caption = 'Text qualifier'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            object Csv__File__Text_Qualifier_Edit: TEdit
              AlignWithMargins = True
              Left = 7
              Top = 17
              Width = 66
              Height = 21
              Margins.Left = 5
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 0
              Align = alClient
              ParentShowHint = False
              ShowHint = False
              TabOrder = 0
              ExplicitHeight = 23
            end
          end
          object Csv__File__Data_Separator_GroupBox: TGroupBox
            AlignWithMargins = True
            Left = 2
            Top = 17
            Width = 249
            Height = 40
            Hint = 'Csv data separator.'
            Margins.Left = 0
            Margins.Top = 0
            Margins.Right = 0
            Margins.Bottom = 0
            Align = alClient
            Caption = 'Data separator'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            object Csv__File__Data_Separator_Edit: TEdit
              AlignWithMargins = True
              Left = 7
              Top = 17
              Width = 235
              Height = 21
              Margins.Left = 5
              Margins.Top = 0
              Margins.Right = 5
              Margins.Bottom = 0
              Align = alClient
              ParentShowHint = False
              ShowHint = False
              TabOrder = 0
              ExplicitHeight = 23
            end
          end
        end
        object Syn_Editor__Options_PageControl: TPageControl
          AlignWithMargins = True
          Left = 11
          Top = 440
          Width = 333
          Height = 211
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 5
          ActivePage = Syn_Editor__Options_TabSheet
          Align = alClient
          TabOrder = 3
          object Syn_Editor__Options_TabSheet: TTabSheet
            Caption = 'Editor options'
            object Syn_Editor__Options_CheckListBox: TCheckListBox
              Left = 0
              Top = 0
              Width = 325
              Height = 181
              Align = alClient
              ItemHeight = 15
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnKeyDown = Syn_Editor__Options_CheckListBoxKeyDown
            end
          end
          object Syn_Editor__Options__Scroll_TabSheet: TTabSheet
            Caption = 'Editor scroll options'
            ImageIndex = 1
            ParentShowHint = False
            ShowHint = False
            object Syn_Editor__Options__Scroll_CheckListBox: TCheckListBox
              Left = 0
              Top = 0
              Width = 325
              Height = 181
              Align = alClient
              ItemHeight = 15
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnKeyDown = Syn_Editor__Options_CheckListBoxKeyDown
            end
          end
          object Syn_Editor__Options__Hint_TabSheet: TTabSheet
            Caption = 'Hint'
            ImageIndex = 2
            object Syn_Editor__Options__Hint_ScrollBox: TScrollBox
              Left = 0
              Top = 0
              Width = 325
              Height = 181
              Align = alClient
              TabOrder = 0
              object Syn_Editor__Options__Hint_Label: TLabel
                Left = 0
                Top = 0
                Width = 127
                Height = 45
                Caption = 
                  'Ctrl + A - select all'#13#10'Ctrl + I - invert selection'#13#10'Ctrl + N - u' +
                  'nselect all'
                ParentShowHint = False
                ShowHint = True
              end
            end
          end
        end
      end
    end
    object Table__Data_Filter_TabSheet: TTabSheet
      Caption = 'Table data filter'
      ImageIndex = 6
      object Table__Data_Filter__Field_Dedicated__Default_Use_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 366
        Width = 936
        Height = 17
        Hint = 'Use additional value as default in table data filter.'
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Use additional value as default'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 4
      end
      object Table__Data_Filter__Quotation_Sign__Use_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 339
        Width = 936
        Height = 17
        Hint = 
          'Automatically use quotation sign in table data filter e.g. for t' +
          'ext fields.'
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Quotation sign use'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
      end
      object Table__Data_Filter__Filter__Dedicated_Value_Format_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 10
        Top = 155
        Width = 936
        Height = 110
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Filter value format'
        TabOrder = 1
        object Table__Data_Filter__Filter__Dedicated_Value_Format__Date_Etiquette_Label: TLabel
          AlignWithMargins = True
          Left = 12
          Top = 22
          Width = 912
          Height = 15
          Hint = 'E.g.:'#13#10'dd.mm.yyyy'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Date'
          ParentShowHint = False
          ShowHint = True
          ExplicitWidth = 24
        end
        object Table__Data_Filter__Filter__Dedicated_Value_Format__Time_Etiquette_Label: TLabel
          AlignWithMargins = True
          Left = 12
          Top = 65
          Width = 912
          Height = 15
          Hint = 'E.g.:'#13#10'hh:mm:ss.zzz'
          Margins.Left = 10
          Margins.Top = 5
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Time'
          ParentShowHint = False
          ShowHint = True
          ExplicitWidth = 27
        end
        object Table__Data_Filter__Filter__Dedicated_Value_Format__Date_Edit: TEdit
          AlignWithMargins = True
          Left = 12
          Top = 37
          Width = 912
          Height = 23
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          TabOrder = 0
        end
        object Table__Data_Filter__Filter__Dedicated_Value_Format__Time_Edit: TEdit
          AlignWithMargins = True
          Left = 12
          Top = 80
          Width = 912
          Height = 23
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 0
          Align = alTop
          TabOrder = 1
        end
      end
      object Table__Data_Filter__Filter__Dedicated_Value_Format__Separators_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 10
        Top = 270
        Width = 936
        Height = 59
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Separators'
        TabOrder = 2
        object Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Decimal_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 202
          Top = 17
          Width = 100
          Height = 40
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Decimal'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          object Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Decimal_Edit: TEdit
            AlignWithMargins = True
            Left = 7
            Top = 17
            Width = 86
            Height = 21
            Margins.Left = 5
            Margins.Top = 0
            Margins.Right = 5
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 23
          end
        end
        object Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Date_Time_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 102
          Top = 17
          Width = 100
          Height = 40
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Date time'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          object Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Date_Time_Edit: TEdit
            AlignWithMargins = True
            Left = 7
            Top = 17
            Width = 86
            Height = 21
            Margins.Left = 5
            Margins.Top = 0
            Margins.Right = 5
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 23
          end
        end
        object Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Date_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 2
          Top = 17
          Width = 100
          Height = 40
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Date'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          object Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Date_Edit: TEdit
            AlignWithMargins = True
            Left = 7
            Top = 17
            Width = 86
            Height = 21
            Margins.Left = 5
            Margins.Top = 0
            Margins.Right = 5
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 23
          end
        end
        object Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Time_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 302
          Top = 17
          Width = 100
          Height = 40
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alLeft
          Caption = 'Time'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          object Table__Data_Filter__Filter__Dedicated_Value_Format__Separator__Time_Edit: TEdit
            AlignWithMargins = True
            Left = 7
            Top = 17
            Width = 86
            Height = 21
            Margins.Left = 5
            Margins.Top = 0
            Margins.Right = 5
            Margins.Bottom = 0
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 23
          end
        end
      end
      object Component_GroupBox: TGroupBox
        AlignWithMargins = True
        Left = 10
        Top = 5
        Width = 936
        Height = 145
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Component'
        TabOrder = 0
        object Component__Date_Time_GroupBox: TGroupBox
          AlignWithMargins = True
          Left = 12
          Top = 17
          Width = 912
          Height = 120
          Margins.Left = 10
          Margins.Top = 0
          Margins.Right = 10
          Margins.Bottom = 5
          Align = alTop
          Caption = 'Date time'
          TabOrder = 0
          object Component__Date_Time__Conventional__Use_CheckBox: TCheckBox
            AlignWithMargins = True
            Left = 12
            Top = 17
            Width = 888
            Height = 17
            Hint = 
              'Use a conventional component to handling date and time.'#13#10'Support' +
              's dates range only: 01.01.1601 - 31.12.9999.'
            Margins.Left = 10
            Margins.Top = 0
            Margins.Right = 10
            Margins.Bottom = 0
            Align = alTop
            Caption = 'Conventional use'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = Component__Date_Time__Conventional__Use_CheckBoxClick
          end
          object Component__Date_Time__Conventional__Use__Example_Panel: TPanel
            Left = 2
            Top = 34
            Width = 908
            Height = 84
            Align = alClient
            TabOrder = 1
            DesignSize = (
              908
              84)
            object Component__Date_Time__Conventional__Use__Example__Mode_RadioGroup: TRadioGroup
              AlignWithMargins = True
              Left = 11
              Top = 6
              Width = 200
              Height = 72
              Margins.Left = 10
              Margins.Top = 5
              Margins.Right = 10
              Margins.Bottom = 5
              Align = alLeft
              Caption = 'Example mode'
              ItemIndex = 1
              Items.Strings = (
                'date'
                'date time'
                'time')
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              OnClick = Component__Date_Time__Conventional__Use__Example__Mode_RadioGroupClick
            end
            object Component__Date_Time__Conventional__Use__Example__Color_Panel: TPanel
              Left = 230
              Top = 10
              Width = 200
              Height = 35
              Color = clWindow
              ParentBackground = False
              TabOrder = 1
              object Component__Date_Time__Conventional__Use__Example__DateTimePicker: TDateTimePicker
                Left = 5
                Top = 5
                Width = 190
                Height = 23
                Date = 45771.000000000000000000
                Time = 0.543136284723004800
                ParentShowHint = False
                ShowHint = True
                TabOrder = 0
              end
            end
            object Component__Date_Time__Conventional__Date_Time__Format_GroupBox: TGroupBox
              Left = 435
              Top = 0
              Width = 465
              Height = 45
              Hint = 'E.g.:'#13#10'dd.MM.yyyy HH:mm:ss'
              Anchors = [akLeft, akTop, akRight]
              Caption = 'Conventional component date time format'
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              object Component__Date_Time__Conventional__Date_Time__Format_Edit: TEdit
                Left = 2
                Top = 17
                Width = 461
                Height = 23
                Align = alTop
                TabOrder = 0
                OnChange = Component__Date_Time__Conventional__Use__Example__Mode_RadioGroupClick
              end
            end
          end
        end
      end
    end
    object Text__Search_Window_TabSheet: TTabSheet
      Caption = 'Text search'
      ImageIndex = 3
      object Text__Search__History_Save_To_File__Items_Count_Etiquette_Label: TLabel
        AlignWithMargins = True
        Left = 10
        Top = 64
        Width = 936
        Height = 15
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Saved search and replace history items count'
        ParentShowHint = False
        ShowHint = False
        ExplicitWidth = 237
      end
      object Text__Search__History_Save_To_File_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 32
        Width = 936
        Height = 17
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'Save search and replace history to file'
        ParentShowHint = False
        ShowHint = False
        TabOrder = 1
      end
      object Text__Search__Window__One_Common_CheckBox: TCheckBox
        AlignWithMargins = True
        Left = 10
        Top = 5
        Width = 936
        Height = 17
        Hint = 'One common search window for the entire application.'
        Margins.Left = 10
        Margins.Top = 5
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        Caption = 'One common window'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
      end
      object Text__Search__History_Save_To_File__Items_Count_SpinEdit: TSpinEdit
        AlignWithMargins = True
        Left = 10
        Top = 84
        Width = 936
        Height = 24
        Margins.Left = 10
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 5
        Align = alTop
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Application files|*.exe|All files|*.*'
    Options = [ofFileMustExist, ofEnableSizing]
    Left = 360
    Top = 33
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Left = 260
    Top = 33
  end
  object Sql_Text__SynCompletionProposal: TSynCompletionProposal
    Options = [scoLimitToMatchedText, scoUseInsertList, scoUsePrettyText, scoUseBuiltInTimer, scoEndCharCompletion, scoCompleteWithTab, scoCompleteWithEnter]
    EndOfTokenChr = '()[]. '
    TriggerChars = '.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Shell Dlg 2'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Shell Dlg 2'
    TitleFont.Style = [fsBold]
    GripperFont.Charset = DEFAULT_CHARSET
    GripperFont.Color = clBtnText
    GripperFont.Height = -12
    GripperFont.Name = 'Segoe UI'
    GripperFont.Style = []
    Columns = <>
    Resizeable = True
    ShortCut = 16416
    Editor = Sql_Text_SynEdit
    OnAfterCodeCompletion = Sql_Text__SynCompletionProposalAfterCodeCompletion
    OnCodeCompletion = Sql_Text__SynCompletionProposalCodeCompletion
    Left = 517
    Top = 33
  end
end
