unit AlPagtoEUnit;

interface

uses
  SysUtils, Classes, ALConversao, AlComum, dialogs;

type

  TAlPagtoE = class(TComponent)
  private
    fLAYOUT : TLayoutALPagtoE;
    fTP_INSCRICAO : TTipoInsALPagtoE;
    fINSCRICAOMATRIZ : String;
    fAGENCIA : String;
    fCONTA : String;
    fDAC_AGENCIA_CONTA : String;
    fNOME_EMPRESA : String;
    fNOME_ARQUIVO : String;
    fCODIGO_CONVENIO: String;
    fCODIGO_REMESSA: Integer;
    fDT_GERACAO: TDate;
    fHR_GERACAO: TTime;
    fDIGITO_AGENCIA: String;
    fDIGITO_CONTA: String;

    fArquivo : IArquivo;

    procedure criaArquivo;
  public
    procedure addPagamento(pagamento: TPagamentoAlPagtoE);
    procedure clearPagamento;
    function gerarArquivo : boolean;
    function carregarArquivo : boolean;
    function ContaRetorno : integer;
    function getRetorno(pos : integer):TPagamentoAlPagtoE;
  published
    property Layout : TLayoutALPagtoE read fLAYOUT write fLAYOUT default lyItau;
    property TpInscricao : TTipoInsALPagtoE read fTP_INSCRICAO write fTP_INSCRICAO default tiCNPJ;
    property InscricaoMatriz : String read fINSCRICAOMATRIZ write fINSCRICAOMATRIZ;
    property NomeArquivo : String read fNOME_ARQUIVO write fNOME_ARQUIVO;
    property Agencia : String read fAGENCIA write fAGENCIA;
    property DIGITO_AGENCIA: String read fDIGITO_AGENCIA write FDIGITO_AGENCIA;
    property DIGITO_CONTA: String read fDIGITO_CONTA write fDIGITO_CONTA;
    property Conta : String read fCONTA write fCONTA;
    property DAC : String read fDAC_AGENCIA_CONTA write fDAC_AGENCIA_CONTA;
    property NomeEmpresa :String read fNOME_EMPRESA write fNOME_EMPRESA;
    property CODIGO_CONVENIO: String read fCODIGO_CONVENIO write fCODIGO_CONVENIO;
    property CODIGO_REMESSA: Integer read fCODIGO_REMESSA write fCODIGO_REMESSA;
    property DT_GERACAO: TDate read fDT_GERACAO write fDT_GERACAO;
    property HR_GERACAO: TTime read fHR_GERACAO write fHR_GERACAO;
  end;

procedure Register;

implementation

uses
  ItauUnit,
  SafraUnit,
  SicrediUnit,
  SantanderUnit,
  BancoBrasilUnit;

procedure Register;
begin
  RegisterComponents('Wise Developer', [TAlPagtoE]);
end;

{ TAlPagtoE }

procedure TAlPagtoE.addPagamento(pagamento: TPagamentoAlPagtoE);
begin
  criaArquivo;
  fArquivo.addPagamento(pagamento, fTP_INSCRICAO, fINSCRICAOMATRIZ, fAGENCIA, fCONTA,
                        fDAC_AGENCIA_CONTA, fNOME_EMPRESA, fCODIGO_CONVENIO, fCODIGO_REMESSA,
                        fDT_GERACAO, fHR_GERACAO, fDIGITO_AGENCIA, fDIGITO_CONTA);
end;

function TAlPagtoE.carregarArquivo: boolean;
begin
  criaArquivo;
  result := fArquivo.carregarArquivo(fNOME_ARQUIVO);
end;

procedure TAlPagtoE.clearPagamento;
begin
  criaArquivo;
  fArquivo.clearPagamento;
end;

function TAlPagtoE.ContaRetorno: integer;
begin
  result := fArquivo.contaRetorno;
end;

procedure TAlPagtoE.criaArquivo;
begin
  if fArquivo = nil then
  begin
    case fLAYOUT of
      lyItau: fArquivo := TArquivoItau.Create;
      lySafra: FArquivo := TArquivoSafra.Create;
      lySicredi: fArquivo := TArquivoSicredi.Create;
      lySantander: fArquivo := TArquivoSantander.Create;
      lyBancoBrasil: fArquivo := TArquivoBB.Create;
    else
      ShowMessage('Layout não Implementado');
    end;
  end;
end;

function TAlPagtoE.gerarArquivo : boolean;
begin
  result := fArquivo.gerarArquivo(fNOME_ARQUIVO);;
end;

function TAlPagtoE.getRetorno(pos: integer): TPagamentoAlPagtoE;
begin
  Result := fArquivo.getretorno(pos);
end;

end.
