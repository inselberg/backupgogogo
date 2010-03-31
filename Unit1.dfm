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
    TabOrder = 0
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
  end
  object JvMemo1: TJvMemo
    Left = 0
    Top = 0
    Width = 473
    Height = 218
    Align = alClient
    TabOrder = 2
    Visible = False
    WordWrap = False
    OnClick = JvMemo1Click
  end
  object JvxCheckListBox1: TJvxCheckListBox
    Left = 0
    Top = 0
    Width = 473
    Height = 218
    Align = alClient
    ItemHeight = 13
    TabOrder = 3
    OnClickCheck = JvxCheckListBox1ClickCheck
    OnKeyDown = JvxCheckListBox1KeyDown
    InternalVersion = 202
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
    object miHilfe: TMenuItem
      Caption = 'Hilfe'
      object miAbout: TMenuItem
        Caption = #252'ber...'
        OnClick = miAboutClick
      end
      object miC4U: TMenuItem
        Caption = 'auf updates '#252'berpr'#252'fen'
        OnClick = miC4UClick
      end
    end
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 352
    Top = 88
  end
end
