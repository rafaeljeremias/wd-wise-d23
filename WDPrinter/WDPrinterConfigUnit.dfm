object WDPrinterConfigForm: TWDPrinterConfigForm
  Left = 290
  Top = 188
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Impress'#227'o'
  ClientHeight = 276
  ClientWidth = 440
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 13
  object OKButton: TButton
    Left = 276
    Top = 249
    Width = 75
    Height = 24
    HelpContext = 998
    Caption = '&OK'
    TabOrder = 2
    OnClick = OKButtonClick
  end
  object CancelarButton: TButton
    Tag = 1
    Left = 359
    Top = 249
    Width = 75
    Height = 24
    HelpContext = 999
    Caption = '&Cancelar'
    TabOrder = 3
    OnClick = CancelarButtonClick
  end
  object ImpressoraGroup: TGroupBox
    Left = 5
    Top = 3
    Width = 430
    Height = 118
    Caption = ' Impressora '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TipoLabel: TLabel
      Left = 373
      Top = 47
      Width = 49
      Height = 13
      Caption = 'Matricial'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LocalRedeLabel: TLabel
      Left = 373
      Top = 19
      Width = 32
      Height = 13
      Caption = 'Local'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 37
      Top = 19
      Width = 29
      Height = 13
      Caption = 'Local:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 28
      Top = 47
      Width = 38
      Height = 13
      Caption = 'Modelo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object DriverComboBox: TComboBox
      Left = 75
      Top = 42
      Width = 292
      Height = 22
      HelpContext = 991
      Style = csDropDownList
      DropDownCount = 14
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object ArquivoEdit: TEdit
      Left = 145
      Top = 88
      Width = 160
      Height = 22
      HelpContext = 994
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
    end
    object VideoCheck: TCheckBox
      Left = 11
      Top = 72
      Width = 122
      Height = 17
      HelpContext = 992
      Caption = 'Imprimir para &v'#237'deo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object ArquivoCheck: TCheckBox
      Left = 11
      Top = 91
      Width = 122
      Height = 17
      HelpContext = 993
      Caption = 'Imprimir para &arquivo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = ArquivoCheckClick
    end
    object InstaladasComboBox: TComboBox
      Left = 75
      Top = 14
      Width = 292
      Height = 22
      HelpContext = 990
      Style = csDropDownList
      DropDownCount = 14
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnChange = InstaladasComboBoxChange
    end
    object ProcurarBtn: TButton
      Left = 312
      Top = 87
      Width = 75
      Height = 25
      Caption = 'Procurar...'
      TabOrder = 5
      OnClick = ProcurarBtnClick
    end
  end
  object IntervaloGroup: TGroupBox
    Left = 5
    Top = 122
    Width = 260
    Height = 126
    HelpContext = 995
    Caption = ' Intervalo de P'#225'ginas '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object DescricaoLabel: TLabel
      Left = 8
      Top = 93
      Width = 241
      Height = 27
      AutoSize = False
      Caption = 
        'Separe com [,] ou [;] os n'#250'meros e/ou intervalos de p'#225'ginas a se' +
        'rem impressos. Ex.: 1-3;5;10;8'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 5329233
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object TodosCheck: TRadioButton
      Left = 7
      Top = 19
      Width = 113
      Height = 17
      HelpContext = 995
      Caption = '&Todos'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object IntervaloCheck: TRadioButton
      Left = 7
      Top = 71
      Width = 113
      Height = 17
      HelpContext = 995
      Caption = 'P'#225'ginas:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object IntervaloEdit: TEdit
      Left = 115
      Top = 68
      Width = 136
      Height = 22
      HelpContext = 996
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = IntervaloEditChange
    end
    object ParesCheck: TRadioButton
      Left = 7
      Top = 36
      Width = 113
      Height = 17
      HelpContext = 995
      Caption = 'P'#225'ginas &Pares'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object ImparesCheck: TRadioButton
      Left = 7
      Top = 53
      Width = 101
      Height = 17
      HelpContext = 995
      Caption = 'P'#225'gi&nas Impares'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  object OpcoesGroup: TGroupBox
    Left = 271
    Top = 122
    Width = 164
    Height = 126
    Caption = ' Op'#231#245'es '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    object Label1: TLabel
      Left = 11
      Top = 21
      Width = 90
      Height = 13
      Caption = '&N'#250'mero de C'#243'pias:'
      Enabled = False
      FocusControl = CopiasEdit
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object TesteImpressaoButton: TButton
      Left = 11
      Top = 93
      Width = 141
      Height = 25
      HelpContext = 998
      Caption = '&Fazer teste de impress'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = TesteImpressaoButtonClick
    end
    object CopiasEdit: TSpinEdit
      Left = 11
      Top = 37
      Width = 141
      Height = 22
      HelpContext = 989
      Color = clBtnFace
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxValue = 0
      MinValue = 0
      ParentFont = False
      TabOrder = 0
      Value = 1
    end
    object InverteCheck: TCheckBox
      Left = 12
      Top = 69
      Width = 97
      Height = 17
      Caption = '&Ordem inversa'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'txt'
    FileName = 'Impressao.txt'
    Filter = 'Arquivos Texto (*.txt)|*.txt|Todos os Arquivos (*.*)|*.*'
    Left = 349
    Top = 123
  end
end
