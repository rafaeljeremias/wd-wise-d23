unit ALComum;

interface

uses
  Controls, AlConversao, Contnrs, Classes;

type
  ISegmentoJ56 = interface
    ['{493AA0AB-D04F-4AE1-8911-1E442F15E9AD}']
    function CodigoTipoMovimentoRemessa: TTipoMovimentoRemessa; overload;
    function CodigoTipoMovimentoRemessa(const pValue: TTipoMovimentoRemessa): ISegmentoJ56; overload;
  end;

  TAResultadoAlPagto = array[1..5] of TResultadoALPagto;


  TPagamentoAlPagtoE = class(TInterfacedObject, ISegmentoJ56)
  private
    fTP_PAGAMENTO : TTipoPagALPagtoE;
    fFORMA_PAGAMENTO : TFormaPagALPagtoE;
    fTP_INSCRICAO : TTipoInsALPagtoE;
    fINSCRICAO : String;
    fIDENTIFICA_EXTRATO : boolean; ///informar 1707 se sim - tipo 20,01 outros nos segmento A - tipo 30,31,01,60 fFINALIDADE DETALHE
    fAGENCIA : String;
    fDIGITO_AGENCIA: String;
    fCONTA : String;
    fDAC_AGENCIA_CONTA : String;
    fNOME_EMPRESA : String;
    fFINALIDADE_LOTE : String;
    fFINALIDADE_LOTE_PREFIXO : TFinalidadeLoteAlPagtoE; ///posicao 103,104 na conta investimento ou pagamento Salarios
    fHISTORICOC_CC : String;
    fENDERECO : String;
    fNUMERO : String;
    fCOMPLEMENTO : String;
    fCIDADE : String;
    fCEP : String;
    fESTADO : String;
    fTP_MOVIMENTO :  TTipoMovALPagtoE;
    fBANCO_FAVORECIDO : integer;
    fAGENCIA_FAVORECIDO : String;
    fDAC_AGENCIA_FAVORECIDO : String;
    fCONTA_FAVORECIDO : String;
    fMOEDA_BARRAS : String;
    fDV_BARRAS : String;
    fVENCIMENTO_BARRAS : String;
    fVALOR_BARRAS : double;
    fCAMPO_LIVRE : String;
    fNOME_FAVORECIDO : String;
    fDATA_VENCIMENTO : TDate;
    fVALOR_TITULO : double;
    fDESCONTOS : double;
    fACRESCIMOS : double;
    fSEU_NUMERO : String;
    fDATA_PAGTO : TDate;
    fTP_MOEDA : TTipoMoedaAlPagtoE;
    fISPB : String;
    fVALOR_PAGTO : double;
    fFINALIDADE_DETALHE : THistoricoVarAlPagtoE;
    fFINALIDADE_DETALHE_OUTRO : String;
    fNR_NOTA_CNPJ : String;
    fDOCUMENTO : String;
    fTP_INSCRICAO_FAVORECIDO: TTipoInsALPagtoE;
    fCPF_CNPJ : String;
    fFINALIDADE_DOC : TFinalidadeDocAlPagtoE;
    fSTATUS_FUNCIONARIO : TStatusFuncionarioAlPagtoE;
    fFINALIDADE_TED : TFinalidadeTedAlPagtoE;
    fTIPO_IDENTIFICACAO : TTipoIdentificacaoAlPagtoE;
    fAVISO : TAvisoAgendamentoAlPagtoE;
    fCOD_PAGAMENTO : TGPSPagamento;
    fVALOR_OUTRO : double;
    fATUALIZACAO_MONETARIA : double;
    fUSO_EMPRESA : String;
    fNOSSO_NUMERO : String;
    fDATA_EFETIVA : Tdate;
    fVALOR_EFETIVO : double;
    fRESULTADO : integer;
    fIDENTIFICADOR : String;
    fOcorrencias : TAResultadoALPagto;
    fRECEITA : integer;
    fLACRE : String;
    fLACRE_DIGITO : String;
    fCODIGO_BARRA: String;

    FCodigoTipoMovimentoRemessa: TTipoMovimentoRemessa;
  public
    property TP_PAGAMENTO : TTipoPagALPagtoE read fTP_PAGAMENTO write fTP_PAGAMENTO;
    property FORMA_PAGAMENTO : TFormaPagALPagtoE read fFORMA_PAGAMENTO write fFORMA_PAGAMENTO;
    property TP_INSCRICAO : TTipoInsALPagtoE read fTP_INSCRICAO write fTP_INSCRICAO;
    property INSCRICAO : String read fINSCRICAO write fINSCRICAO;
    property IDENTIFICA_EXTRATO : boolean read fIDENTIFICA_EXTRATO write fIDENTIFICA_EXTRATO; ///informar 1707 se sim - tipo 20,01 outros nos segmento A - tipo 30,31,01,60 fFINALIDADE DETALHE
    property AGENCIA : String read fAGENCIA write fAGENCIA;
    property DIGITO_AGENCIA: String read fDIGITO_AGENCIA write fDIGITO_AGENCIA;
    property CONTA : String read fCONTA write fCONTA;
    property DAC_AGENCIA_CONTA : String read fDAC_AGENCIA_CONTA write fDAC_AGENCIA_CONTA;
    property NOME_EMPRESA : String read fNOME_EMPRESA write fNOME_EMPRESA;
    property FINALIDADE_LOTE : String read fFINALIDADE_LOTE write fFINALIDADE_LOTE;
    property FINALIDADE_LOTE_PREFIXO : TFinalidadeLoteAlPagtoE read fFINALIDADE_LOTE_PREFIXO write fFINALIDADE_LOTE_PREFIXO; ///posicao 103,104 na conta investimento ou pagamento Salarios
    property HISTORICOC_CC : String read fHISTORICOC_CC write fHISTORICOC_CC;
    property ENDERECO : String read fENDERECO write fENDERECO;
    property NUMERO : String read fNUMERO write fNUMERO;
    property COMPLEMENTO : String read fCOMPLEMENTO write fCOMPLEMENTO;
    property CIDADE : String read fCIDADE write fCIDADE;
    property CEP : String read fCEP write fCEP;
    property ESTADO : String read fESTADO write fESTADO;
    property TP_MOVIMENTO :  TTipoMovALPagtoE read fTP_MOVIMENTO write fTP_MOVIMENTO;
    property BANCO_FAVORECIDO : integer read fBANCO_FAVORECIDO write fBANCO_FAVORECIDO;
    property AGENCIA_FAVORECIDO : String read fAGENCIA_FAVORECIDO write fAGENCIA_FAVORECIDO;
    property DAC_AGENCIA_FAVORECIDO : String read fDAC_AGENCIA_FAVORECIDO write fDAC_AGENCIA_FAVORECIDO;
    property CONTA_FAVORECIDO : String read fCONTA_FAVORECIDO write fCONTA_FAVORECIDO;
    property MOEDA_BARRAS : String read fMOEDA_BARRAS write fMOEDA_BARRAS;
    property DV_BARRAS : String read fDV_BARRAS write fDV_BARRAS;
    property VENCIMENTO_BARRAS : String read fVENCIMENTO_BARRAS write fVENCIMENTO_BARRAS;
    property VALOR_BARRAS : double read fVALOR_BARRAS write fVALOR_BARRAS;
    property CAMPO_LIVRE : String read fCAMPO_LIVRE write fCAMPO_LIVRE;
    property NOME_FAVORECIDO : String read fNOME_FAVORECIDO write fNOME_FAVORECIDO;
    property DATA_VENCIMENTO : TDate read fDATA_VENCIMENTO write fDATA_VENCIMENTO;
    property VALOR_TITULO : double read fVALOR_TITULO write fVALOR_TITULO;
    property DESCONTOS : double read fDESCONTOS write fDESCONTOS;
    property ACRESCIMOS : double read fACRESCIMOS write fACRESCIMOS;
    property SEU_NUMERO : String read fSEU_NUMERO write fSEU_NUMERO;
    property DATA_PAGTO : TDate read fDATA_PAGTO write fDATA_PAGTO;
    property TP_MOEDA : TTipoMoedaAlPagtoE read fTP_MOEDA write fTP_MOEDA;
    property ISPB : String read fISPB write fISPB;
    property VALOR_PAGTO : double read fVALOR_PAGTO write fVALOR_PAGTO;
    property FINALIDADE_DETALHE : THistoricoVarAlPagtoE read fFINALIDADE_DETALHE write fFINALIDADE_DETALHE;
    property FINALIDADE_DETALHE_OUTRO : String read fFINALIDADE_DETALHE_OUTRO write fFINALIDADE_DETALHE_OUTRO;
    property NR_NOTA_CNPJ : String read fNR_NOTA_CNPJ write fNR_NOTA_CNPJ;
    property DOCUMENTO : String read fDOCUMENTO write fDOCUMENTO;
    property TP_INSCRICAO_FAVORECIDO: TTipoInsALPagtoE read fTP_INSCRICAO_FAVORECIDO write fTP_INSCRICAO_FAVORECIDO;
    property CPF_CNPJ : String read fCPF_CNPJ write fCPF_CNPJ;
    property FINALIDADE_DOC : TFinalidadeDocAlPagtoE read fFINALIDADE_DOC write fFINALIDADE_DOC;
    property STATUS_FUNCIONARIO : TStatusFuncionarioAlPagtoE read fSTATUS_FUNCIONARIO write fSTATUS_FUNCIONARIO;
    property FINALIDADE_TED : TFinalidadeTedAlPagtoE read fFINALIDADE_TED write fFINALIDADE_TED;
    property TIPO_IDENTIFICACAO : TTipoIdentificacaoAlPagtoE read fTIPO_IDENTIFICACAO write fTIPO_IDENTIFICACAO;
    property AVISO : TAvisoAgendamentoAlPagtoE read fAVISO write fAVISO;
    property COD_PAGAMENTO : TGPSPagamento read fCOD_PAGAMENTO write fCOD_PAGAMENTO;
    property VALOR_OUTRO : double read fVALOR_OUTRO write fVALOR_OUTRO;
    property ATUALIZACAO_MONETARIA : double read fATUALIZACAO_MONETARIA write fATUALIZACAO_MONETARIA;
    property USO_EMPRESA : String read fUSO_EMPRESA write fUSO_EMPRESA;
    property NOSSO_NUMERO : String read fNOSSO_NUMERO write fNOSSO_NUMERO;
    property DATA_EFETIVA : Tdate read fDATA_EFETIVA write fDATA_EFETIVA;
    property VALOR_EFETIVO : double read fVALOR_EFETIVO write fVALOR_EFETIVO;
    property RESULTADO : integer read fRESULTADO write fRESULTADO;
    property IDENTIFICADOR : String read fIDENTIFICADOR write fIDENTIFICADOR;
    property RECEITA : integer read fRECEITA write fRECEITA;
    property LACRE : String read fLACRE write fLACRE;
    property LACRE_DIGITO : String read FLACRE_DIGITO write FLACRE_DIGITO;
    property Ocorrencias : TAResultadoALPagto read fOcorrencias write fOcorrencias;
    property CODIGO_BARRA: String read fCODIGO_BARRA write fCODIGO_BARRA;

    function SegmentoJ56: ISegmentoJ56;
    function CodigoTipoMovimentoRemessa: TTipoMovimentoRemessa; overload;
    function CodigoTipoMovimentoRemessa(const pValue: TTipoMovimentoRemessa): ISegmentoJ56; overload;
  end;

  TPagamentoList = class(TObjectList)
  private
    function GetItem(Index: Integer): TPagamentoAlPagtoE;
    procedure SetItem(Index: Integer; const Value: TPagamentoAlPagtoE);
  public
    function New(AOwner: TComponent): TPagamentoAlPagtoE;
    property Items[Index: Integer]: TPagamentoAlPagtoE read GetItem write SetItem;
  end;

  IArquivo = interface
    procedure addPagamento(pagamento: TPagamentoAlPagtoE; TP_INSCRICAO : TTipoInsALPagtoE;
                           INSCRICAOMATRIZ, fAGENCIA, fCONTA, fDAC_AGENCIA_CONTA, fNOME_EMPRESA, pCODIGO_CONVENIO : String;
                           pCODIGO_REMESSA: Integer; pDT_GERACAO: TDate; pHR_GERACAO: TTime; pDIGITO_AGENCIA, pDIGITO_CONTA: String);

    procedure clearPagamento;
    function gerarArquivo(nome_arquivo : String): boolean;
    function carregarArquivo(nome_arquivo : String): boolean;
    function getretorno(pos : integer): TPagamentoAlPagtoE;
    function contaRetorno : integer;

    function TipoMoedaToStr(const t: TTipoMoedaAlPagtoE): string;
    function StrToTipoMoeda(var ok: boolean; const s: string): TTipoMoedaAlPagtoE;
    function OcorrenciaStringToResultado(pSigla : String): TResultadoALPagto;
  end;


function formataNumero(numero : String; tamanho:integer) : String; overload;
function formataNumero(numero : integer; tamanho:integer) : String; overload;
function formataNumero(numero : double; tamanho, decimais:integer) : String; overload;
function formataAlfa(palavra : String; tamanho:integer) : String;
function formataData(data : TDate) : String;
function formataHora(hora : TTime) : String;
function AlinhaEsq(const Palavra:string; Tamanho: Integer; Caracter: char = #32):String;
function AlinhaDir(const Palavra:string; Tamanho: Integer; Caracter: char = #32):String;
function paraData(data : String) : TDate;
function paraHora(hora : String) : TTime;
function paraDouble(valor : String; decimais : integer) : double;

implementation

uses SysUtils, StrUtils;

function AlinhaEsq(const Palavra:string; Tamanho: Integer; Caracter: char = #32):String;
var
  S:String;
  I:Integer;
begin
  S := Palavra;
  For I:=1 to (Tamanho-Length(Palavra)) do S := S + Caracter;
  If Length(Palavra) > Tamanho then Delete(S,Tamanho+1,Length(Palavra)-Tamanho);
  Result := S;
end;

function AlinhaDir(const Palavra:string; Tamanho: Integer; Caracter: char = #32):String;
var
  S:String;
  I:Integer;
begin
  S := Palavra;
  For I:=1 to (Tamanho-Length(Palavra)) do S := Caracter + S;
  If Length(Palavra) > Tamanho then Delete(S,Tamanho+1,Length(Palavra)-Tamanho);
  Result := S;
end;

function formataNumero(numero : String; tamanho:integer) : String;
begin
  result := AlinhaDir(numero, tamanho, '0')
end;

function formataNumero(numero : integer; tamanho:integer) : String;
begin
  result := AlinhaDir(intToStr(numero), tamanho, '0')
end;

function formataNumero(numero : double; tamanho, decimais:integer) : String; overload;
var
  mascara : string;
begin
  mascara := '0';
  if decimais > 0 then
    mascara := mascara + '.'+DupeString('0',decimais);
  result :=  AlinhaDir(AnsiReplaceStr(FormatFloat(mascara, numero), FormatSettings.DecimalSeparator,''), tamanho, '0');
end;

function formataAlfa(palavra : String; tamanho:integer) : String;
begin
  result := AlinhaEsq(palavra, tamanho, ' ');
end;

function formataData(data : TDate) : String;
begin
  result := FormatDateTime('DDMMYYYY', data);
end;

function formataHora(hora : TTime) : String;
begin
  result := FormatDateTime('HHNNSS', hora);
end;

function paraData(data : String) : TDate;
begin
  result := EncodeDate(StrToInt(copy(data,5,4)), StrToInt(copy(data,3,2)), StrToInt(copy(data,1,2)));
end;

function paraHora(hora : String) : TTime;
begin
  result := EncodeTime(StrToInt(copy(hora,1,2)),StrToInt(copy(hora,3,2)),StrToInt(copy(hora,5,2)), 0)
end;

function paraDouble(valor : String; decimais : integer) : double;
begin
  result := StrToFloat(copy(valor, 1, length(valor) - decimais) + FormatSettings.DecimalSeparator + copy(valor, length(valor) - decimais + 1, decimais));
end;

{ TPagamentoList }

function TPagamentoList.GetItem(Index: Integer): TPagamentoAlPagtoE;
begin
  Result :=  TPagamentoAlPagtoE(Inherited Items[Index]);
end;

function TPagamentoList.New(AOwner: TComponent): TPagamentoAlPagtoE;
begin
  Result := TPagamentoAlPagtoE.Create;
  Add(Result);
end;

procedure TPagamentoList.SetItem(Index: Integer;
  const Value: TPagamentoAlPagtoE);
begin
  Put(Index, Value);
end;

{ TPagamentoAlPagtoE }

function TPagamentoAlPagtoE.CodigoTipoMovimentoRemessa: TTipoMovimentoRemessa;
begin
  result := FCodigoTipoMovimentoRemessa;
end;

function TPagamentoAlPagtoE.CodigoTipoMovimentoRemessa(
  const pValue: TTipoMovimentoRemessa): ISegmentoJ56;
begin
  result := Self;

  FCodigoTipoMovimentoRemessa := pValue;
end;

function TPagamentoAlPagtoE.SegmentoJ56: ISegmentoJ56;
begin
  result := Self;
end;

end.
