unit WDPrinterConfigUnit;

interface

uses
  Spin,
  Mask,
  Forms,
  Classes,
  Dialogs,
  Funcoes,
  StdCtrls,
  Controls,
  SysUtils;

type
  TWDPrinterConfigForm = class(TForm)
    OKButton: TButton;
    CancelarButton: TButton;
    ImpressoraGroup: TGroupBox;
    DriverComboBox: TComboBox;
    TipoLabel: TLabel;
    IntervaloGroup: TGroupBox;
    ArquivoEdit: TEdit;
    VideoCheck: TCheckBox;
    ArquivoCheck: TCheckBox;
    TodosCheck: TRadioButton;
    IntervaloCheck: TRadioButton;
    IntervaloEdit: TEdit;
    ParesCheck: TRadioButton;
    ImparesCheck: TRadioButton;
    OpcoesGroup: TGroupBox;
    TesteImpressaoButton: TButton;
    Label1: TLabel;
    CopiasEdit: TSpinEdit;
    DescricaoLabel: TLabel;
    InstaladasComboBox: TComboBox;
    InverteCheck: TCheckBox;
    LocalRedeLabel: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ProcurarBtn: TButton;
    OpenDialog: TOpenDialog;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OKButtonClick(Sender: TObject);
    procedure TesteImpressaoButtonClick(Sender: TObject);
    procedure ArquivoCheckClick(Sender: TObject);
    procedure IntervaloEditChange(Sender: TObject);
    procedure InstaladasComboBoxChange(Sender: TObject);
    procedure CancelarButtonClick(Sender: TObject);
    procedure ProcurarBtnClick(Sender: TObject);
  public
    OK, TesteImp: Boolean;
    procedure AtualizaCaption;
  end;

const
  Chave = 'Software\WDPrinter\Impressora';

var
  WDPrinterConfigForm   : TWDPrinterConfigForm;
  ImpressorasInstaladas: array[0..2, 0..9] of string; // máximo de 10 impressoras!

implementation

{$R *.DFM}



procedure TWDPrinterConfigForm.AtualizaCaption;
begin
  Caption := 'Impressão em ' + ImpressorasInstaladas[ 1, InstaladasComboBox.ItemIndex];
  LocalRedeLabel.Caption := ImpressorasInstaladas[ 2, InstaladasComboBox.ItemIndex];
end;

procedure TWDPrinterConfigForm.FormShow(Sender: TObject);
var
  I: Integer;
begin
  DriverComboBox.Items.Add('EPSON LQ');
  DriverComboBox.Items.Add('EPSON FX');
  DriverComboBox.Items.Add('EPSON LX');

  for I := 0 to 9 do
  begin
    if ImpressorasInstaladas[0,I] = '' then Break;
    InstaladasComboBox.Items.Add( ImpressorasInstaladas[0,I] );
  end;
  OK           := False;
  TesteImp     := False;

  VideoCheck.Checked    := LerReg(Chave,'ParaVideo'  ,'S') = 'S';
  ArquivoCheck.Checked  := LerReg(Chave,'ParaArquivo','N') = 'S';
  ArquivoEdit.Text      := LerReg(Chave, 'Arquivo', 'C:\Imprimir.txt');
  DriverComboBox.ItemIndex := StrToIntDef(LerReg(Chave,'Driver','1'),1);
  ArquivoEdit.Enabled   := ArquivoCheck.Checked;
  ProcurarBtn.Enabled   := ArquivoCheck.Checked;

  I := StrToIntDef(LerReg(Chave, 'PrinterIndex', '0'),0);
  if I > 9 then InstaladasComboBox.ItemIndex := 0 else
  try
    InstaladasComboBox.ItemIndex := I;
  except
    InstaladasComboBox.ItemIndex := 0;
  end;
  OKButton.SetFocus;
  AtualizaCaption;
end;

procedure TWDPrinterConfigForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GravaReg(Chave,'Driver', IntToStr(DriverComboBox.ItemIndex));
  if VideoCheck.Checked   then
    GravaReg(Chave, 'ParaVideo'  , 'S')
  else
    GravaReg(Chave, 'ParaVideo'  , 'N');
  if ArquivoCheck.Checked then
    GravaReg(Chave, 'ParaArquivo', 'S')
  else
    GravaReg(Chave, 'ParaArquivo', 'N');
  GravaReg(Chave, 'Arquivo', ArquivoEdit.Text);
  GravaReg(Chave, 'PrinterIndex', IntToStr(InstaladasComboBox.ItemIndex));
end;


procedure TWDPrinterConfigForm.OKButtonClick(Sender: TObject);
begin
  if not TodosCheck.Checked then
  begin
    ShowMessage('Impressão de intervalos esta em desenvolvimento');
    abort;
  end;
  OK := True;
  Close;
end;

procedure TWDPrinterConfigForm.CancelarButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TWDPrinterConfigForm.TesteImpressaoButtonClick(Sender: TObject);
begin
  TesteImp := True;
  Close;
end;

procedure TWDPrinterConfigForm.InstaladasComboBoxChange(Sender: TObject);
begin
  AtualizaCaption;
end;

procedure TWDPrinterConfigForm.ArquivoCheckClick(Sender: TObject);
begin
  ArquivoEdit.Enabled := ArquivoCheck.Checked;
  ProcurarBtn.Enabled := ArquivoCheck.Checked;
  if ArquivoEdit.Enabled then
    ArquivoEdit.SetFocus;
  VideoCheck.Enabled  := not ArquivoCheck.Checked;
end;

procedure TWDPrinterConfigForm.IntervaloEditChange(Sender: TObject);
begin
  IntervaloCheck.Checked := (IntervaloEdit.Text <> '');
  TodosCheck.Checked     := (IntervaloEdit.Text = '' );
end;

procedure TWDPrinterConfigForm.ProcurarBtnClick(Sender: TObject);
begin
  OpenDialog.InitialDir := ExtractFileDir(ArquivoEdit.Text);
  if FileExists(ArquivoEdit.Text) then
    OpenDialog.FileName := ArquivoEdit.Text;
  if OpenDialog.Execute then
    ArquivoEdit.Text := OpenDialog.FileNAme;
end;

end.
