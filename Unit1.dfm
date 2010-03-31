object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 294
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = JvMainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object JvPanel1: TJvPanel
    Left = 0
    Top = 0
    Width = 473
    Height = 218
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
    Align = alClient
    Caption = 'JvPanel1'
    TabOrder = 0
    ExplicitWidth = 225
    ExplicitHeight = 224
    object JvxCheckListBox1: TJvxCheckListBox
      Left = 1
      Top = 1
      Width = 471
      Height = 216
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnClickCheck = JvxCheckListBox1ClickCheck
      OnKeyDown = JvxCheckListBox1KeyDown
      ExplicitLeft = 0
      ExplicitTop = -4
      InternalVersion = 202
    end
  end
  object JvPanel3: TJvPanel
    Left = 0
    Top = 218
    Width = 473
    Height = 57
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = -8
    ExplicitTop = 227
    ExplicitWidth = 596
    object JvLabel1: TJvLabel
      Left = 8
      Top = 11
      Width = 77
      Height = 13
      Caption = 'Backup Ordner:'
      Transparent = True
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'Tahoma'
      HotTrackFont.Style = []
    end
    object bDoBackup: TButton
      Left = 351
      Top = 24
      Width = 75
      Height = 27
      Caption = 'backup'
      TabOrder = 0
      OnClick = bDoBackupClick
    end
    object JvDirectoryEdit1: TJvDirectoryEdit
      Left = 8
      Top = 30
      Width = 337
      Height = 21
      DialogKind = dkWin32
      TabOrder = 1
      Text = '<Zielordner ausw'#228'hlen>'
      OnChange = JvDirectoryEdit1Change
    end
  end
  object JvStatusBar1: TJvStatusBar
    Left = 0
    Top = 275
    Width = 473
    Height = 19
    Panels = <>
    SimplePanel = True
    ExplicitTop = 281
    ExplicitWidth = 635
  end
  object JvMemo1: TJvMemo
    Left = 225
    Top = 0
    Width = 410
    Height = 224
    Lines.Strings = (
      'JvMemo1')
    TabOrder = 3
    Visible = False
    WordWrap = False
  end
  object JvSelectDirectory1: TJvSelectDirectory
    Left = 504
    Top = 16
  end
  object xml: TJvSimpleXML
    IndentString = '  '
    Left = 560
    Top = 16
  end
  object JvMainMenu1: TJvMainMenu
    ImageMargin.Left = 0
    ImageMargin.Top = 0
    ImageMargin.Right = 0
    ImageMargin.Bottom = 0
    ImageSize.Height = 0
    ImageSize.Width = 0
    Left = 344
    Top = 32
    object miVerzeichnisAdd: TMenuItem
      Caption = 'Verzeichnis hinzuf'#252'gen'
      OnClick = miVerzeichnisAddClick
    end
  end
end
