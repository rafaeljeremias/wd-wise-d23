unit BancoBrasilUnit;

{$IOCHECKS ON}

interface

uses Alconversao, Controls, Contnrs, AlComum;

const
  quebra_linha = #13#10;

  TOcorrenciaBBString : array[0..135] of array [0..3] of String =
  (('00', 'CRÉDITO OU DÉBITO EFETIVADO', '0', '00'),
   ('01', 'INSUFICIÊNCIA DE FUNDOS - DÉBITO NÃO EFETUADO', '1', 'RJ'),
   ('02', 'CRÉDITO OU DÉBITO CANCELADO PELO PAGADOR/CREDOR', '0', 'RJ'),
   ('03', 'DÉBITO AUTORIZADO PELA AGÊNCIA - EFETUADO', '0', 'BD'),
   ('AA', 'CONTROLE INVÁLIDO', '1', 'RJ'),
   ('AB', 'TIPO DE OPERAÇÃO INVÁLIDO', '1', 'RJ'),
   ('AC', 'TIPO DE SERVIÇO INVÁLIDO', '1', 'RJ'),
   ('AD', 'FORMA DE LANÇAMENTO INVÁLIDA', '1', 'RJ'),
   ('AE', 'TIPO/NÚMERO DE INSCRIÇÃO INVÁLIDO', '1', 'RJ'),
   ('AF', 'CÓDIGO DE CONVÊNIO INVÁLIDO', '1', 'RJ'),
   ('AG', 'AGÊNCIA/CONTA CORRENTE/DV INVÁLIDO', '1', 'RJ'),
   ('AH', 'Nº SEQÜENCIAL DO REGISTRO NO LOTE INVÁLIDO', '1', 'RJ'),
   ('AI', 'CÓDIGO DE SEGMENTO DE DETALHE INVÁLIDO', '1', 'RJ'),
   ('AJ', 'TIPO DE MOVIMENTO INVÁLIDO', '1', 'RJ'),
   ('AK', 'CÓDIGO DA CÂMARA DE COMPENSAÇÃO DO BANCO FAVORECIDO/DEPOSITÁRIO INVÁLIDO', '1', 'RJ'),
   ('AL', 'CÓDIGO DO BANCO FAVORECIDO OU DEPOSITÁRIO INVÁLIDO', '1', 'RJ'),
   ('AM', 'AGÊNCIA MANTENEDORA DA CONTA CORRENTE DO FAVORECIDO INVÁLIDA', '1', 'RJ'),
   ('AN', 'CONTA CORRENTE/DV DO FAVORECIDO INVÁLIDO', '1', 'RJ'),
   ('AO', 'NOME DO FAVORECIDO NÃO INFORMADO', '1', 'RJ'),
   ('AP', 'DATA LANÇAMENTO INVÁLIDO', '1', 'RJ'),
   ('AQ', 'TIPO/QUANTIDADE DA MOEDA INVÁLIDO', '1', 'RJ'),
   ('AR', 'VALOR DO LANÇAMENTO INVÁLIDO', '1', 'RJ'),
   ('AS', 'AVISO AO FAVORECIDO - IDENTIFICAÇÃO INVÁLIDA', '1', 'RJ'),
   ('AT', 'TIPO/NÚMERO DE INSCRIÇÃO DO FAVORECIDO INVÁLIDO', '1', 'RJ'),
   ('AU', 'LOGRADOURO DO FAVORECIDO NÃO INFORMADO', '1', 'RJ'),
   ('AV', 'Nº DO LOCAL DO FAVORECIDO NÃO INFORMADO', '1', 'RJ'),
   ('AW', 'CIDADE DO FAVORECIDO NÃO INFORMADA', '1', 'RJ'),
   ('AX', 'CEP/COMPLEMENTO DO FAVORECIDO INVÁLIDO', '1', 'RJ'),
   ('AY', 'SIGLA DO ESTADO DO FAVORECIDO INVÁLIDA', '1', 'RJ'),
   ('AZ', 'CÓDIGO/NOME DO BANCO DEPOSITÁRIO INVÁLIDO', '1', 'RJ'),
   ('BA', 'CÓDIGO/NOME DA AGÊNCIA DEPOSITÁRIA NÃO INFORMADO', '1', 'RJ'),
   ('BB', 'SEU NÚMERO INVÁLIDO', '1', 'RJ'),
   ('BC', 'NOSSO NÚMERO INVÁLIDO', '1', 'RJ'),
   ('BD', 'INCLUSÃO EFETUADA COM SUCESSO', '0', 'BD'),
   ('BE', 'ALTERAÇÃO EFETUADA COM SUCESSO', '0', 'BD'),
   ('BF', 'EXCLUSÃO EFETUADA COM SUCESSO', '0', 'CE'),
   ('BG', 'AGÊNCIA/CONTA IMPEDIDA LEGALMENTE', '1', 'RJ'),
   ('BH', 'EMPRESA NÃO PAGOU SALÁRIO', '1', 'RJ'),
   ('BI', 'FALECIMENTO DO MUTUÁRIO', '1', 'RJ'),
   ('BJ', 'EMPRESA NÃO ENVIOU REMESSA DO MUTUÁRIO', '1', 'RJ'),
   ('BK', 'EMPRESA NÃO ENVIOU REMESSA NO VENCIMENTO', '1', 'RJ'),
   ('BL', 'VALOR DA PARCELA INVÁLIDA', '1', 'RJ'),
   ('BM', 'IDENTIFICAÇÃO DO CONTRATO INVÁLIDA', '1', 'RJ'),
   ('BN', 'OPERAÇÃO DE CONSIGNAÇÃO INCLUÍDA COM SUCESSO', '0', 'BD'),
   ('BO', 'OPERAÇÃO DE CONSIGNAÇÃO ALTERADA COM SUCESSO', '0', 'BD'),
   ('BP', 'OPERAÇÃO DE CONSIGNAÇÃO EXCLUÍDA COM SUCESSO', '0', 'CE'),
   ('BQ', 'OPERAÇÃO DE CONSIGNAÇÃO LIQUIDADA COM SUCESSO', '0', '00'),
   ('BR', 'REATIVAÇÃO EFETUADA COM SUCESSO', '0', 'BD'),
   ('BS', 'SUSPENSÃO EFETUADA COM SUCESSO', '0', 'CE'),
   ('CA', 'CÓDIGO DE BARRAS - CÓDIGO DO BANCO INVÁLIDO', '1', 'RJ'),
   ('CB', 'CÓDIGO DE BARRAS - CÓDIGO DA MOEDA INVÁLIDO', '1', 'RJ'),
   ('CC', 'CÓDIGO DE BARRAS - DÍGITO VERIFICADOR GERAL INVÁLIDO', '1', 'RJ'),
   ('CD', 'CÓDIGO DE BARRAS - VALOR DO TÍTULO INVÁLIDO', '1', 'RJ'),
   ('CE', 'CÓDIGO DE BARRAS - CAMPO LIVRE INVÁLIDO', '1', 'RJ'),
   ('CF', 'VALOR DO DOCUMENTO INVÁLIDO', '1', 'RJ'),
   ('CG', 'VALOR DO ABATIMENTO INVÁLIDO', '1', 'RJ'),
   ('CH', 'VALOR DO DESCONTO INVÁLIDO', '1', 'RJ'),
   ('CI', 'VALOR DE MORA INVÁLIDO', '1', 'RJ'),
   ('CJ', 'VALOR DA MULTA INVÁLIDO', '1', 'RJ'),
   ('CK', 'VALOR DO IR INVÁLIDO', '1', 'RJ'),
   ('CL', 'VALOR DO ISS INVÁLIDO', '1', 'RJ'),
   ('CM', 'VALOR DO IOF INVÁLIDO', '1', 'RJ'),
   ('CN', 'VALOR DE OUTRAS DEDUÇÕES INVÁLIDO', '1', 'RJ'),
   ('CO', 'VALOR DE OUTROS ACRÉSCIMOS INVÁLIDO', '1', 'RJ'),
   ('CP', 'VALOR DO INSS INVÁLIDO', '1', 'RJ'),
   ('HA', 'LOTE NÃO ACEITO', '1', 'RJ'),
   ('HB', 'INSCRIÇÃO DA EMPRESA INVÁLIDA PARA O CONTRATO', '1', 'RJ'),
   ('HC', 'CONVÊNIO COM A EMPRESA INEXISTENTE/INVÁLIDO PARA O CONTRATO', '1', 'RJ'),
   ('HD', 'AGÊNCIA/CONTA CORRENTE DA EMPRESA INEXISTENTE/INVÁLIDO PARA O CONTRATO', '1', 'RJ'),
   ('HE', 'TIPO DE SERVIÇO INVÁLIDO PARA O CONTRATO', '1', 'RJ'),
   ('HF', 'CONTA CORRENTE DA EMPRESA COM SALDO INSUFICIENTE', '1', 'RJ'),
   ('HG', 'LOTE DE SERVIÇO FORA DE SEQÜÊNCIA', '1', 'RJ'),
   ('HH', 'LOTE DE SERVIÇO INVÁLIDO', '1', 'RJ'),
   ('HI', 'ARQUIVO NÃO ACEITO', '1', 'RJ'),
   ('HJ', 'TIPO DE REGISTRO INVÁLIDO', '1', 'RJ'),
   ('HK', 'CÓDIGO REMESSA / RETORNO INVÁLIDO', '1', 'RJ'),
   ('HL', 'VERSÃO DE LAYOUT INVÁLIDA', '1', 'RJ'),
   ('HM', 'MUTUÁRIO NÃO IDENTIFICADO', '1', 'RJ'),
   ('HN', 'TIPO DO BENEFICIO NÃO PERMITE EMPRÉSTIMO', '1', 'RJ'),
   ('HO', 'BENEFICIO CESSADO/SUSPENSO', '1', 'RJ'),
   ('HP', 'BENEFICIO POSSUI REPRESENTANTE LEGAL', '1', 'RJ'),
   ('HQ', 'BENEFICIO É DO TIPO PA (PENSÃO ALIMENTÍCIA)', '1', 'RJ'),
   ('HR', 'QUANTIDADE DE CONTRATOS PERMITIDA EXCEDIDA', '1', 'RJ'),
   ('HS', 'BENEFICIO NÃO PERTENCE AO BANCO INFORMADO', '1', 'RJ'),
   ('HT', 'INÍCIO DO DESCONTO INFORMADO JÁ ULTRAPASSADO', '1', 'RJ'),
   ('HU', 'NÚMERO DA PARCELA INVÁLIDA', '1', 'RJ'),
   ('HV', 'QUANTIDADE DE PARCELA INVÁLIDA', '1', 'RJ'),
   ('HW', 'MARGEM CONSIGNÁVEL EXCEDIDA PARA O MUTUÁRIO DENTRO DO PRAZO DO CONTRATO', '1', 'RJ'),
   ('HX', 'EMPRÉSTIMO JÁ CADASTRADO', '1', 'RJ'),
   ('HY', 'EMPRÉSTIMO INEXISTENTE', '1', 'RJ'),
   ('HZ', 'EMPRÉSTIMO JÁ ENCERRADO', '1', 'RJ'),
   ('H1', 'ARQUIVO SEM TRAILER', '1', 'RJ'),
   ('H2', 'MUTUÁRIO SEM CRÉDITO NA COMPETÊNCIA', '1', 'RJ'),
   ('H3', 'NÃO DESCONTADO – OUTROS MOTIVOS', '1', 'RJ'),
   ('H4', 'RETORNO DE CRÉDITO NÃO PAGO', '1', 'RJ'),
   ('H5', 'CANCELAMENTO DE EMPRÉSTIMO RETROATIVO', '1', 'RJ'),
   ('H6', 'OUTROS MOTIVOS DE GLOSA', '1', 'RJ'),
   ('H7', 'MARGEM CONSIGNÁVEL EXCEDIDA PARA O MUTUÁRIO ACIMA DO PRAZO DO CONTRATO', '1', 'RJ'),
   ('H8', 'MUTUÁRIO DESLIGADO DO EMPREGADOR', '1', 'RJ'),
   ('H9', 'MUTUÁRIO AFASTADO POR LICENÇA', '1', 'RJ'),
   ('IA', 'PRIMEIRO NOME DO MUTUÁRIO DIFERENTE DO PRIMEIRO NOME DO MOVIMENTO DO CENSO OU DIFERENTE DA BASE DE TITULAR DO BENEFÍCIO', '1', 'RJ'),
   ('IB', 'BENEFÍCIO SUSPENSO/CESSADO PELA APS OU SISOBI', '1', 'RJ'),
   ('IC', 'BENEFÍCIO SUSPENSO POR DEPENDÊNCIA DE CÁLCULO', '1', 'RJ'),
   ('ID', 'BENEFÍCIO SUSPENSO/CESSADO PELA INSPETORIA/AUDITORIA', '1', 'RJ'),
   ('IE', 'BENEFÍCIO BLOQUEADO PARA EMPRÉSTIMO PELO BENEFICIÁRIO', '1', 'RJ'),
   ('IF', 'BENEFÍCIO BLOQUEADO PARA EMPRÉSTIMO POR TBM', '1', 'RJ'),
   ('IG', 'BENEFÍCIO ESTÁ EM FASE DE CONCESSÃO DE PA OU DESDOBRAMENTO', '1', 'RJ'),
   ('IH', 'BENEFÍCIO CESSADO POR ÓBITO', '1', 'RJ'),
   ('II', 'BENEFÍCIO CESSADO POR FRAUDE', '1', 'RJ'),
   ('IJ', 'BENEFÍCIO CESSADO POR CONCESSÃO DE OUTRO BENEFÍCIO', '1', 'RJ'),
   ('IK', 'BENEFÍCIO CESSADO: ESTATUTÁRIO TRANSFERIDO PARA ÓRGÃO DE ORIGEM', '1', 'RJ'),
   ('IL', 'EMPRÉSTIMO SUSPENSO PELA APS', '1', 'RJ'),
   ('IM', 'EMPRÉSTIMO CANCELADO PELO BANCO', '1', 'RJ'),
   ('IN', 'CRÉDITO TRANSFORMADO EM PAB', '1', 'RJ'),
   ('IO', 'TÉRMINO DA CONSIGNAÇÃO FOI ALTERADO', '1', 'RJ'),
   ('IP', 'FIM DO EMPRÉSTIMO OCORREU DURANTE PERÍODO DE SUSPENSÃO OU CONCESSÃO', '1', 'RJ'),
   ('IQ', 'EMPRÉSTIMO SUSPENSO PELO BANCO', '1', 'RJ'),
   ('IR', 'NÃO AVERBAÇÃO DE CONTRATO – QUANTIDADE DE PARCELAS/COMPETÊNCIAS INFORMADAS ULTRAPASSOU A DATA LIMITE DA EXTINÇÃO DE COTA DO DEPENDENTE TITULAR DE BENEFÍCIOS', '1', 'RJ'),
   ('TA', 'LOTE NÃO ACEITO - TOTAIS DO LOTE COM DIFERENÇA', '1', 'RJ'),
   ('YA', 'TÍTULO NÃO ENCONTRADO', '1', 'RJ'),
   ('YB', 'IDENTIFICADOR REGISTRO OPCIONAL INVÁLIDO', '1', 'RJ'),
   ('YC', 'CÓDIGO PADRÃO INVÁLIDO', '1', 'RJ'),
   ('YD', 'CÓDIGO DE OCORRÊNCIA INVÁLIDO', '1', 'RJ'),
   ('YE', 'COMPLEMENTO DE OCORRÊNCIA INVÁLIDO', '1', 'RJ'),
   ('YF', 'ALEGAÇÃO JÁ INFORMADA OBSERVAÇÃO: AS OCORRÊNCIAS INICIADAS COM "ZA" TEM CARÁTER INFORMATIVO PARA O CLIENTE', '1', 'RJ'),
   ('ZA', 'AGÊNCIA / CONTA DO FAVORECIDO SUBSTITUÍDA', '0', 'BD'),
   ('ZB', 'DIVERGÊNCIA ENTRE O PRIMEIRO E ÚLTIMO NOME DO BENEFICIÁRIO VERSUS PRIMEIRO E ÚLTIMO NOME NA RECEITA FEDERAL', '1', 'RJ'),
   ('ZC', 'CONFIRMAÇÃO DE ANTECIPAÇÃO DE VALOR', '1', 'RJ'),
   ('ZD', 'ANTECIPAÇÃO PARCIAL DE VALOR', '0', '00'),
   ('ZE', 'TÍTULO BLOQUEADO NA BASE', '1', 'RJ'),
   ('ZF', 'SISTEMA EM CONTINGÊNCIA – TÍTULO VALOR MAIOR QUE REFERÊNCIA', '1', 'RJ'),
   ('ZG', 'SISTEMA EM CONTINGÊNCIA – TÍTULO VENCIDO', '1', 'RJ'),
   ('ZH', 'SISTEMA EM CONTINGÊNCIA – TÍTULO INDEXADO', '1', 'RJ'),
   ('ZI', 'BENEFICIÁRIO DIVERGENTE', '1', 'RJ'),
   ('ZJ', 'LIMITE DE PAGAMENTOS PARCIAIS EXCEDIDO', '1', 'RJ'),
   ('ZK', 'BOLETO JÁ LIQUIDADO', '1', 'RJ'));

type
  TSegmentoAList = class;
  TSegmentoJList = class;
  TSegmentoJ52List = class;
  TSegmentoNList = class;
  TSegmentoOList = class;
  TLoteListBB = class;
  TLoteBB = class;
  TSegmentoA = class;
  TSegmentoJ = class;
  TSegmentoN = class;
  TSegmentoO = class;

  TArquivoBB = class(TInterfacedObject, IArquivo)
  private
    fARQUIVO : String;
    fTP_INSCRICAO : TTipoInsALPagtoE;
    fINSCRICAO : String;
    fAGENCIA : String;
    fCONTA : String;
    fDAC_AGENCIA_CONTA : String;
    fNOME_EMPRESA : String;
    fTP_ARQUIVO : TTipoArquivoAlPagtoE;
    fDATA_GERACAO : TDate;
    fHORA_GERACAO : TTime;
    fDENSIDADE : integer;
    fLoteListBB: TLoteListBB;
    fLinhas : integer;
    fRetorno : TPagamentoList;
    fCODIGO_CONVENIO: String;
    fCODIGO_REMESSA: Integer;
    fDIGITO_AGENCIA: String;
    fDIGITO_CONTA: String;
    fUltimoProcessadoJ: Boolean;

    procedure validaTipoForm(tipo : TTipoPagALPagtoE; forma :TFormaPagALPagtoE);
    procedure popularRetorno;
  public
    constructor Create;
    property ARQUIVO : String read fARQUIVO write fARQUIVO;
    property TP_INSCRICAO : TTipoInsALPagtoE read fTP_INSCRICAO write fTP_INSCRICAO;
    property INSCRICAO : String read fINSCRICAO write fINSCRICAO;
    property AGENCIA : String read fAGENCIA write fAGENCIA;
    property CONTA : String read fCONTA write fCONTA;
    property DIGITO_AGENCIA: String read fDIGITO_AGENCIA write fDIGITO_AGENCIA;
    property DAC_AGENCIA_CONTA : String read fDAC_AGENCIA_CONTA write fDAC_AGENCIA_CONTA;
    property NOME_EMPRESA : String read fNOME_EMPRESA write fNOME_EMPRESA;
    property TP_ARQUIVO : TTipoArquivoAlPagtoE read fTP_ARQUIVO write fTP_ARQUIVO;
    property DATA_GERACAO : TDate read fDATA_GERACAO write fDATA_GERACAO;
    property HORA_GERACAO : TTime read fHORA_GERACAO write fHORA_GERACAO;
    property DENSIDADE : integer read fDENSIDADE write fDENSIDADE;
    property LOTELISTBB : TLoteListBB read fLoteListBB write fLoteListBB;
    property CODIGO_CONVENIO: String read fCODIGO_CONVENIO write fCODIGO_CONVENIO;
    property CODIGO_REMESSA: Integer read fCODIGO_REMESSA write fCODIGO_REMESSA;
    property DIGITO_CONTA: String read fDIGITO_CONTA write fDIGITO_CONTA;

    function retornaLote(pagamento: TPagamentoAlPagtoE): TLoteBB;
    function getLote(codigo : integer) : TLoteBB;
    function getLinhaLayout : String;
    function getLinhaTrailer : String;
    function CarregarArquivo(nome_arquivo : string) : boolean;
    function GerarArquivo(nome_arquivo : string) : boolean;
    function getRetorno(pos : integer): TPagamentoAlPagtoE;
    function contaRetorno : integer;
    function segmentoAToPagamento(segmento : TSegmentoA) : TPagamentoAlPagtoE;
    function segmentoJToPagamento(segmento : TSegmentoJ) : TPagamentoAlPagtoE;
    function segmentoNToPagamento(segmento : TSegmentoN) : TPagamentoAlPagtoE;
    function segmentoOToPagamento(segmento : TSegmentoO) : TPagamentoAlPagtoE;
    function StrToAResultado(Ocorrencias :String) : TAResultadoAlPagto;
    function OcorrenciasToResultado(Ocorrencias : TAResultadoAlPagto) : integer;
    function TipoMoedaToStr(const t: TTipoMoedaAlPagtoE): string;
    function StrToTipoMoeda(var ok: boolean; const s: string): TTipoMoedaAlPagtoE;
    function OcorrenciaStringToResultado(pSigla : String): TResultadoALPagto;

    procedure addPagamento(pagamento: TPagamentoAlPagtoE; TP_INSCRICAO : TTipoInsALPagtoE;
                           INSCRICAOMATRIZ, fAGENCIA, fCONTA, fDAC_AGENCIA_CONTA, fNOME_EMPRESA, pCODIGO_CONVENIO : String;
                           pCODIGO_REMESSA: Integer; pDT_GERACAO: TDate; pHR_GERACAO: TTime; pDIGITO_AGENCIA, pDIGITO_CONTA: String);

    procedure addLinha(linha : String);
    procedure addLinhaArquivo(linha : String);
    procedure addLinhaLote(linha : String);
    procedure addLinhaSegmento(linha : String);
    procedure addLinhaSegmentoA(linha : String);
    procedure addLinhaSegmentoJ(linha : String);
    procedure addLinhaSegmentoN(linha : String);
    procedure addLinhaSegmentoO(linha : String);
    procedure clearPagamento;
    procedure atualizarDadosLote(var pagamento: TPagamentoAlPagtoE; lote : TLoteBB);

    destructor Destroy; override;
  end;

  TLoteBB = class
  private
    fCODIGO : integer;
    fTP_PAGAMENTO : TTipoPagALPagtoE;
    fFORMA_PAGAMENTO : TFormaPagALPagtoE;
    fTP_INSCRICAO : TTipoInsALPagtoE;
    fINSCRICAO : String;
    fIDENTIFICA_EXTRATO : boolean; ///informar 1707 se sim - tipo 20,01 outros nos segmento A - tipo 30,31,01,60 fFINALIDADE DETALHE
    fAGENCIA : String;
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
    fOCORRENCIAS : String;
    fLISTSEGMENTOA : TSegmentoAList;
    fLISTSEGMENTOJ : TSegmentoJList;
    fLISTSEGMENTOJ52 : TSegmentoJ52List;
    fLISTSEGMENTON : TSegmentoNList;
    fLISTSEGMENTOO : TSegmentoOList;

    fSEGMENTO_SEQ : integer;
    fLayoutBB: TArquivoBB;
  public
    constructor Create(AOwner: TArquivoBB);

    property CODIGO : integer read fCODIGO write fCODIGO;
    property TP_PAGAMENTO : TTipoPagALPagtoE read fTP_PAGAMENTO write fTP_PAGAMENTO;
    property FORMA_PAGAMENTO : TFormaPagALPagtoE read fFORMA_PAGAMENTO write fFORMA_PAGAMENTO;
    property TP_INSCRICAO : TTipoInsALPagtoE read fTP_INSCRICAO write fTP_INSCRICAO;
    property INSCRICAO : String read fINSCRICAO write fINSCRICAO;
    property IDENTIFICA_EXTRATO : boolean read fIDENTIFICA_EXTRATO write fIDENTIFICA_EXTRATO; ///informar 1707 se sim - tipo 20,01 outros nos segmento A - tipo 30,31,01,60 fFINALIDADE DETALHE
    property AGENCIA : String read fAGENCIA write fAGENCIA;
    property CONTA : String read fCONTA write fCONTA;
    property DAC_AGENCIA_CONTA : String read fDAC_AGENCIA_CONTA write fDAC_AGENCIA_CONTA;
    property NOME_EMPRESA : String read fNOME_EMPRESA write fNOME_EMPRESA;
    property FINALIDADE_LOTE : String read fFINALIDADE_LOTE write fFINALIDADE_LOTE;
    property FINALIDADE_LOTE_PREFIXO : TFinalidadeLoteAlPagtoE read fFINALIDADE_LOTE_PREFIXO write fFINALIDADE_LOTE_PREFIXO default flNaoContratada; ///posicao 103,104 na conta investimento ou pagamento Salarios
    property HISTORICOC_CC : String read fHISTORICOC_CC write fHISTORICOC_CC;
    property ENDERECO : String read fENDERECO write fENDERECO;
    property NUMERO : String read fNUMERO write fNUMERO;
    property COMPLEMENTO : String read fCOMPLEMENTO write fCOMPLEMENTO;
    property CIDADE : String read fCIDADE write fCIDADE;
    property CEP : String read fCEP write fCEP;
    property ESTADO : String read fESTADO write fESTADO;
    property OCORRENCIAS : String read fOCORRENCIAS write fOCORRENCIAS;
    property LISTSEGMENTOA : TSegmentoAList read fLISTSEGMENTOA write fLISTSEGMENTOA;
    property LISTSEGMENTOJ : TSegmentoJList read fLISTSEGMENTOJ write fLISTSEGMENTOJ;
    property LISTSEGMENTOJ52 : TSegmentoJ52List read fLISTSEGMENTOJ52 write fLISTSEGMENTOJ52;
    property LISTSEGMENTON : TSegmentoNList read fLISTSEGMENTON write fLISTSEGMENTON;
    property LISTSEGMENTOO : TSegmentoOList read fLISTSEGMENTOO write fLISTSEGMENTOO;
    property LAYOUTITAU: TArquivoBB read fLayoutBB;

    function getLinhaLayout : String;
    function getLinhaTrailer : String;
    function incSegmentoSeq(incremento : integer = 1) : integer;
    procedure addSegmento(const pagamento: TPagamentoAlPagtoE);
    procedure AddSegmentoA(const pagamento: TPagamentoAlPagtoE);
    procedure AddSegmentoJ(const pagamento: TPagamentoAlPagtoE);
    procedure AddSegmentoJ52(const pagamento: TPagamentoAlPagtoE);
    procedure AddSegmentoN(const pagamento: TPagamentoAlPagtoE);
    procedure AddSegmentoO(const pagamento: TPagamentoAlPagtoE);

    destructor Destroy; override;
  end;

  ITributo = interface
    function getIdentificacaoTributo : String;
    function getValorPrincipal : double;
    function getValorOutrasEntidades : double;
    function getValorAcrescimos : double;
    function getValorArrecadado :double;
    procedure setTributoStr(identificacao : String);
    procedure setPagamento(const pagamento: TPagamentoAlPagtoE);
    procedure getPagamento(const pagamento: TPagamentoAlPagtoE);
  end;

  TTributoFGTS =  class(TInterfacedObject, ITributo)
  private
    fRECEITA : integer;
    fTP_INSCRICAO : TTipoInsALPagtoE;
    fINSCRICAO : String;
    fCOD_BARRAS : String;
    fIDENTIFICADOR  : String;
    fLACRE : String;
    fLACRE_DIGITO : String;
    fNOME_CONTRIBUINTE : String;
    fDATA_PAGAMENTO : TDate;
    fVALOR_PAGAMENTO : double;
  public
    property RECEITA : integer read fRECEITA write fRECEITA;
    property TP_INSCRICAO : TTipoInsALPagtoE read fTP_INSCRICAO write fTP_INSCRICAO;
    property INSCRICAO : String read fINSCRICAO write fINSCRICAO;
    property COD_BARRAS : String read fCOD_BARRAS write fCOD_BARRAS;
    property IDENTIFICADOR  : String read fIDENTIFICADOR write fIDENTIFICADOR;
    property LACRE : String read fLACRE write fLACRE;
    property LACRE_DIGITO : String read fLACRE_DIGITO write fLACRE_DIGITO;
    property NOME_CONTRIBUINTE : String read fNOME_CONTRIBUINTE write fNOME_CONTRIBUINTE;
    property DATA_PAGAMENTO : TDate read fDATA_PAGAMENTO write fDATA_PAGAMENTO;
    property VALOR_PAGAMENTO : double read fVALOR_PAGAMENTO write fVALOR_PAGAMENTO;

    function getIdentificacaoTributo : String;
    function getValorPrincipal : double;
    function getValorOutrasEntidades : double;
    function getValorAcrescimos : double;
    function getValorArrecadado :double;
    procedure setTributoStr(identificacao : String);
    procedure setPagamento(const pagamento: TPagamentoAlPagtoE);
    procedure getPagamento(const pagamento: TPagamentoAlPagtoE);
  end;


  TTributoGPS =  class(TInterfacedObject, ITributo)
  private
    fCOD_PAGAMENTO :  TGPSPagamento;
    fMES_COMPETENCIA : integer;
    fANO_COMPETENCIA : integer;
    fIDENTIFICADOR : String;
    fVALOR_TRIBUTO : double;
    fVALOR_OUTRA : double;
    fATUALIZACAO_MONETARIA : double;
    fVALOR_ARRECADADO : double;
    fDATA_ARRECADACAO : Tdate;
    fUSO_EMPRESA : String;
    fCONTRIBUINTE : String;
  public
    property COD_PAGAMENTO :  TGPSPagamento read fCOD_PAGAMENTO write fCOD_PAGAMENTO;
    property MES_COMPETENCIA : integer read fMES_COMPETENCIA write fMES_COMPETENCIA;
    property ANO_COMPETENCIA : integer read fANO_COMPETENCIA write fANO_COMPETENCIA;
    property IDENTIFICADOR : String read fIDENTIFICADOR write fIDENTIFICADOR;
    property VALOR_TRIBUTO : double read fVALOR_TRIBUTO write fVALOR_TRIBUTO;
    property VALOR_OUTRA : double read fVALOR_OUTRA write fVALOR_OUTRA;
    property ATUALIZACAO_MONETARIA : double read fATUALIZACAO_MONETARIA write fATUALIZACAO_MONETARIA;
    property VALOR_ARRECADADO : double read fVALOR_ARRECADADO write fVALOR_ARRECADADO;
    property DATA_ARRECADACAO : Tdate read fDATA_ARRECADACAO write fDATA_ARRECADACAO;
    property USO_EMPRESA : String read fUSO_EMPRESA write fUSO_EMPRESA;
    property CONTRIBUINTE : String read fCONTRIBUINTE write fCONTRIBUINTE;

    function getIdentificacaoTributo : String;
    function getValorPrincipal : double;
    function getValorOutrasEntidades : double;
    function getValorAcrescimos : double;
    function getValorArrecadado :double;
    procedure setTributoStr(identificacao : String);
    procedure setPagamento(const pagamento: TPagamentoAlPagtoE);
    procedure getPagamento(const pagamento: TPagamentoAlPagtoE);
  end;

  TSegmentoA = class
  private
    fREGISTRO : integer;
    fTP_MOVIMENTO :  TTipoMovALPagtoE;
    fBANCO_FAVORECIDO : integer;
    fAGENCIA_FAVORECIDO : String;
    fDAC_AGENCIA_FAVORECIDO : String;
    fCONTA_FAVORECIDO : String;
    fNOME_FAVORECIDO : String;
    fSEU_NUMERO : String;
    fDATA_PAGTO : TDate;
    fTP_MOEDA : TTipoMoedaAlPagtoE;
    fISPB : String;
    fVALOR_PAGTO : double;
    fNOSSO_NUMERO : String;
    fDATA_EFETIVA : TDate;
    fVALOR_EFETIVO : double;
    fFINALIDADE_DETALHE : THistoricoVarAlPagtoE;
    fFINALIDADE_DETALHE_OUTRO : String;
    fNR_NOTA_CNPJ : String;
    fDOCUMENTO : String;
    fCPF_CNPJ : String;
    fFINALIDADE_DOC : TFinalidadeDocAlPagtoE;
    fSTATUS_FUNCIONARIO : TStatusFuncionarioAlPagtoE;
    fFINALIDADE_TED : TFinalidadeTedAlPagtoE;
    fTIPO_IDENTIFICACAO : TTipoIdentificacaoAlPagtoE;
    fAVISO : TAvisoAgendamentoAlPagtoE;
    fOCORRENCIAS : String;
    fLoteBB: TLoteBB;

  public
    constructor Create(AOwner: TLoteBB); virtual; /// Create
    property REGISTRO :  integer read fREGISTRO write fREGISTRO;
    property TP_MOVIMENTO :  TTipoMovALPagtoE read fTP_MOVIMENTO write fTP_MOVIMENTO;
    property BANCO_FAVORECIDO : integer read fBANCO_FAVORECIDO write fBANCO_FAVORECIDO;
    property AGENCIA_FAVORECIDO : String read fAGENCIA_FAVORECIDO write fAGENCIA_FAVORECIDO;
    property DAC_AGENCIA_FAVORECIDO : String read fDAC_AGENCIA_FAVORECIDO write fDAC_AGENCIA_FAVORECIDO;
    property CONTA_FAVORECIDO : String read fCONTA_FAVORECIDO write fCONTA_FAVORECIDO;
    property NOME_FAVORECIDO : String read fNOME_FAVORECIDO write fNOME_FAVORECIDO;
    property SEU_NUMERO : String read fSEU_NUMERO write fSEU_NUMERO;
    property DATA_PAGTO : TDate read fDATA_PAGTO write fDATA_PAGTO;
    property TP_MOEDA : TTipoMoedaAlPagtoE read fTP_MOEDA write fTP_MOEDA;
    property ISPB : String read fISPB write fISPB;
    property VALOR_PAGTO : double read fVALOR_PAGTO write fVALOR_PAGTO;
    property NOSSO_NUMERO : String read fNOSSO_NUMERO write fNOSSO_NUMERO;
    property DATA_EFETIVA : TDate read fDATA_EFETIVA write fDATA_EFETIVA;
    property VALOR_EFETIVO : double read fVALOR_EFETIVO write fVALOR_EFETIVO;
    property FINALIDADE_DETALHE : THistoricoVarAlPagtoE read fFINALIDADE_DETALHE write fFINALIDADE_DETALHE;
    property FINALIDADE_DETALHE_OUTRO: String read fFINALIDADE_DETALHE_OUTRO write fFINALIDADE_DETALHE_OUTRO;
    property DOCUMENTO : String read fDOCUMENTO write fDOCUMENTO;
    property NR_NOTA_CNPJ : String read fNR_NOTA_CNPJ write fNR_NOTA_CNPJ;
    property CPF_CNPJ : String read fCPF_CNPJ write fCPF_CNPJ;
    property FINALIDADE_DOC: TFinalidadeDocAlPagtoE read fFINALIDADE_DOC write fFINALIDADE_DOC;
    property STATUS_FUNCIONARIO : TStatusFuncionarioAlPagtoE read fSTATUS_FUNCIONARIO write fSTATUS_FUNCIONARIO;
    property FINALIDADE_TED : TFinalidadeTedAlPagtoE read fFINALIDADE_TED write fFINALIDADE_TED;
    property TIPO_IDENTIFICACAO : TTipoIdentificacaoAlPagtoE read fTIPO_IDENTIFICACAO write fTIPO_IDENTIFICACAO;
    property AVISO : TAvisoAgendamentoAlPagtoE read fAVISO write fAVISO;
    property OCORRENCIAS : String read fOCORRENCIAS write fOCORRENCIAS;
    property LOTEBB: TLoteBB read fLoteBB;

    function getLinhaLayout : String;
    function getAgenciaConta : String;
    function getFinalidadeDetalhe : String;
    function getFinalidadeDocStatusFuncionario : String;
  end;


  TSegmentoJ = class
  private
    fREGISTRO : integer;
    fTP_MOVIMENTO :  TTipoMovALPagtoE;
    fBANCO_BARRAS : String;
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
    fDATA_PAGAMENTO : TDate;
    fVALOR_PAGAMENTO : double;
    fSEU_NUMERO : String;
    fNOSSO_NUMERO : String;
    fOCORRENCIAS : String;
    fAOwner : TLoteBB;
  public
    constructor Create(AOwner: TLoteBB); virtual; /// Create

    property REGISTRO : integer read fREGISTRO write fREGISTRO;
    property TP_MOVIMENTO :  TTipoMovALPagtoE read fTP_MOVIMENTO write fTP_MOVIMENTO;
    property BANCO_BARRAS : String read fBANCO_BARRAS write fBANCO_BARRAS;
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
    property DATA_PAGAMENTO : TDate read fDATA_PAGAMENTO write fDATA_PAGAMENTO;
    property VALOR_PAGAMENTO : double read fVALOR_PAGAMENTO write fVALOR_PAGAMENTO;
    property SEU_NUMERO : String read fSEU_NUMERO write fSEU_NUMERO;
    property NOSSO_NUMERO : String read fNOSSO_NUMERO write fNOSSO_NUMERO;
    property OCORRENCIAS : String read fOCORRENCIAS write fOCORRENCIAS;

    function getLinhaLayout : String;
  end;

  TSegmentoJ52 = class
  private
    fREGISTRO : integer;
    fTP_MOVIMENTO :  TTipoMovALPagtoE;
    fTP_INSCRICAO_PAGADOR : TTipoInsALPagtoE;
    fINSCRICAO_PAGADOR : String;
    fNOME_PAGADOR : String;
    fTP_INSCRICAO_BENEFICIARIO : TTipoInsALPagtoE;
    fINSCRICAO_BENEFICIARIO : String;
    fNOME_BENEFICIARIO : String;
    fTP_INSCRICAO_AVALISTA : TTipoInsALPagtoE;
    fINSCRICAO_AVALISTA : String;
    fNOME_AVALISTA : String;
    fAOwner : TLoteBB;
  public
    constructor Create(AOwner: TLoteBB); virtual; /// Create

    property REGISTRO : integer read fREGISTRO write fREGISTRO;
    property TP_MOVIMENTO :  TTipoMovALPagtoE read fTP_MOVIMENTO write fTP_MOVIMENTO;
    property TP_INSCRICAO_PAGADOR : TTipoInsALPagtoE read fTP_INSCRICAO_PAGADOR write fTP_INSCRICAO_PAGADOR;
    property INSCRICAO_PAGADOR : String read fINSCRICAO_PAGADOR write fINSCRICAO_PAGADOR;
    property NOME_PAGADOR : String read fNOME_PAGADOR write fNOME_PAGADOR;
    property TP_INSCRICAO_BENEFICIARIO : TTipoInsALPagtoE read fTP_INSCRICAO_BENEFICIARIO write fTP_INSCRICAO_BENEFICIARIO;
    property INSCRICAO_BENEFICIARIO : String read fINSCRICAO_BENEFICIARIO write fINSCRICAO_BENEFICIARIO;
    property NOME_BENEFICIARIO : String read fNOME_BENEFICIARIO write fNOME_BENEFICIARIO;
    property TP_INSCRICAO_AVALISTA : TTipoInsALPagtoE read fTP_INSCRICAO_AVALISTA write fTP_INSCRICAO_AVALISTA;
    property INSCRICAO_AVALISTA : String read fINSCRICAO_AVALISTA write fINSCRICAO_AVALISTA;
    property NOME_AVALISTA : String read fNOME_AVALISTA write fNOME_AVALISTA;

    function getLinhaLayout : String;
  end;

  TSegmentoN = class
  private
    fREGISTRO : integer;
    fTP_MOVIMENTO :  TTipoMovALPagtoE;
    fDADOS_TRIBUTO : ITributo;
    fSEU_NUMERO : String;
    fNOSSO_NUMERO : String;
    fOCORRENCIAS : String;
    fAOwner : TLoteBB;
  public
    constructor Create(AOwner: TLoteBB); virtual; /// Create

    property REGISTRO : integer read fREGISTRO write fREGISTRO;
    property TP_MOVIMENTO :  TTipoMovALPagtoE read fTP_MOVIMENTO write fTP_MOVIMENTO;
    property DADOS_TRIBUTO : ITributo read fDADOS_TRIBUTO write fDADOS_TRIBUTO;
    property SEU_NUMERO : String read fSEU_NUMERO write fSEU_NUMERO;
    property OCORRENCIAS : String read fOCORRENCIAS write fOCORRENCIAS;
    property NOSSO_NUMERO : String read fNOSSO_NUMERO write fNOSSO_NUMERO;
    function getLinhaLayout : String;
  end;

  TSegmentoO = class
  private
    fREGISTRO : integer;
    fTP_MOVIMENTO :  TTipoMovALPagtoE;
    fCOD_BARRA : String;
    fNOME : String;
    fDATA_VENCIMENTO : TDate;
    fVALOR_PAGAR : double;
    fDATA_PAGAMENTO : double;
    fVALOR_PAGO : double;
    fNOTA_FISCAL : String;
    fSEU_NUMERO : String;
    fNOSSO_NUMERO : String;
    fOCORRENCIAS : String;
    fAOwner : TLoteBB;
  public
    constructor Create(AOwner: TLoteBB); virtual; /// Create

    property REGISTRO : integer read fREGISTRO write fREGISTRO;
    property TP_MOVIMENTO :  TTipoMovALPagtoE read fTP_MOVIMENTO write fTP_MOVIMENTO;
    property COD_BARRA : String read fCOD_BARRA write fCOD_BARRA;
    property NOME : String read fNOME write fNOME;
    property DATA_VENCIMENTO : TDate read fDATA_VENCIMENTO write fDATA_VENCIMENTO;
    property VALOR_PAGAR : double read fVALOR_PAGAR write fVALOR_PAGAR;
    property DATA_PAGAMENTO : double read fDATA_PAGAMENTO write fDATA_PAGAMENTO;
    property VALOR_PAGO : double read fVALOR_PAGO write fVALOR_PAGO;
    property NOTA_FISCAL : String read fNOTA_FISCAL write fNOTA_FISCAL;
    property SEU_NUMERO : String read fSEU_NUMERO write fSEU_NUMERO;
    property OCORRENCIAS : String read fOCORRENCIAS write fOCORRENCIAS;
    property NOSSO_NUMERO : String read fNOSSO_NUMERO write fNOSSO_NUMERO;
    function getLinhaLayout : String;
  end;

  TSegmentoAList = class(TObjectList)
  private
    function GetItem(Index: Integer): TSegmentoA;
    procedure SetItem(Index: Integer; const Value: TSegmentoA);
  public
    function New(AOwner: TLoteBB): TSegmentoA;
    function LocalizaRegistro(Registro: integer): boolean;
    function ValorPagamentos : double;
    property Items[Index: Integer]: TSegmentoA read GetItem write SetItem;
  end;

  TSegmentoJList = class(TObjectList)
  private
    function GetItem(Index: Integer): TSegmentoJ;
    procedure SetItem(Index: Integer; const Value: TSegmentoJ);
  public
    function New(AOwner: TLoteBB): TSegmentoJ;
    function LocalizaRegistro(Registro: integer): boolean;
    function ValorPagamentos : double;
    property Items[Index: Integer]: TSegmentoJ read GetItem write SetItem;
  end;

  TSegmentoJ52List = class(TObjectList)
  private
    function GetItem(Index: Integer): TSegmentoJ52;
    procedure SetItem(Index: Integer; const Value: TSegmentoJ52);
  public
    function New(AOwner: TLoteBB): TSegmentoJ52;
    property Items[Index: Integer]: TSegmentoJ52 read GetItem write SetItem;
  end;

  TSegmentoNList = class(TObjectList)
  private
    function GetItem(Index: Integer): TSegmentoN;
    procedure SetItem(Index: Integer; const Value: TSegmentoN);
  public
    function New(AOwner: TLoteBB): TSegmentoN;
    function ValorPrincipal : double;
    function ValorOutrasEntidades : double;
    function ValorAcrescimos : double;
    function ValorArrecadado : double;
    property Items[Index: Integer]: TSegmentoN read GetItem write SetItem;
  end;

  TSegmentoOList = class(TObjectList)
  private
    function GetItem(Index: Integer): TSegmentoO;
    procedure SetItem(Index: Integer; const Value: TSegmentoO);
  public
    function New(AOwner: TLoteBB): TSegmentoO;
    function ValorPagamentos : double;
    property Items[Index: Integer]: TSegmentoO read GetItem write SetItem;
  end;

  TLoteListBB = class(TObjectList)
  private
    function GetItem(Index: Integer): TLoteBB;
    procedure SetItem(Index: Integer; const Value: TLoteBB);
  public
    function New(AOwner: TArquivoBB): TLoteBB;
    function LocalizaRegistro(Codigo: integer): boolean;
    property Items[Index: Integer]: TLoteBB read GetItem write SetItem;
  end;

implementation

uses StrUtils, SysUtils, Classes, DateUtils;

{ TSegmentoAList }

function TSegmentoAList.GetItem(Index: Integer): TSegmentoA;
begin
  Result :=  TSegmentoA(Inherited Items[Index]);
end;

function TSegmentoAList.LocalizaRegistro(Registro : integer): boolean;
var
  intFor: integer;
begin
   Result := false;
   for intFor := 0 to Self.Count - 1 do
   begin
     if Self.Items[intFor].fREGISTRO = Registro then
     begin
       Result := true;
       Break;
     end;
   end;
end;

function TSegmentoAList.New(AOwner: TLoteBB): TSegmentoA;
begin
  Result := TSegmentoA.Create(AOwner);
  Add(Result);
end;

procedure TSegmentoAList.SetItem(Index: Integer; const Value: TSegmentoA);
begin
  Put(Index, Value);
end;

function TSegmentoAList.ValorPagamentos: double;
var
  i : integer;
  soma : double;
begin
  soma := 0;
  for i:= 0 to self.Count - 1 do
    if self.Items[i].fTP_MOVIMENTO in [tmInclusaoPagamento, tmCpf, tmCnpjCompleto, tmCnpjRaiz] then
      soma := soma + self.Items[i].VALOR_PAGTO;
  result := soma;
end;

{ TSegmentoA }

constructor TSegmentoA.Create(AOwner: TLoteBB);
begin
  fLoteBB := AOwner;
end;

function TSegmentoA.getAgenciaConta: String;
begin
  if (fBANCO_FAVORECIDO = 001) or (fBANCO_FAVORECIDO = 409) then
    result := '0' +
      formataNumero(fAGENCIA_FAVORECIDO,4) +
      ' ' +
      DupeString('0',6) +
      formataNumero(fCONTA_FAVORECIDO,6) +
      ' ' +
      formataNumero(fDAC_AGENCIA_FAVORECIDO, 1)
  else
    result := formataNumero(fAGENCIA_FAVORECIDO,5) +
      ' ' +
      formataNumero(fCONTA_FAVORECIDO,12) +
      ' ' +
      formataAlfa(fDAC_AGENCIA_FAVORECIDO, 1)
end;

function TSegmentoA.getFinalidadeDetalhe: String;
begin
  if (fLoteBB.fTP_PAGAMENTO = tpFornecedores)and(fLoteBB.fFORMA_PAGAMENTO = fpCreditoContaCorrenteBanco) then
    result := fFINALIDADE_DETALHE_OUTRO
  else
    if(fLoteBB.fIDENTIFICA_EXTRATO) and
      (fLoteBB.fTP_PAGAMENTO in [tpSalarios, tpSalariosPublico])and
      (fLoteBB.fFORMA_PAGAMENTO in [fpCreditoContaCorrenteBanco, fpCartaoSalario]) then
        result := HistoricoVarToStr(fFINALIDADE_DETALHE)
  else
    result := ''
end;

function TSegmentoA.getFinalidadeDocStatusFuncionario: String;
begin
  if fLoteBB.fFORMA_PAGAMENTO = fpDocC then
    result := FinalidadeDocToStr(fFINALIDADE_DOC)
  else
    if (fLoteBB.fTP_PAGAMENTO = tpSalarios) and (fLoteBB.FORMA_PAGAMENTO = fpCreditoContaCorrenteBanco) then
      result := StatusFuncionarioToStr(fSTATUS_FUNCIONARIO)
    else
      result := '';
end;

function TSegmentoA.getLinhaLayout: String;
begin
  if (fLoteBB.FORMA_PAGAMENTO in [fpCreditoContaCorrenteBanco, fpChequePagamento, fpDocC,
      fpCreditoContaPoupancaBanco, fpCreditoContaCorrenteTitular, fpDocD, fpTedOutroTitular,
      fpTedMesmoTitular]) then
    result := '001' +
      formataNumero(fLoteBB.fCODIGO, 4) +
      '3' +
      formataNumero(fREGISTRO, 5) +
      'A' +
      formataNumero(TipoMovToStr(fTP_MOVIMENTO),3) +
      formataNumero(0, 3) +
      formataNumero(fBANCO_FAVORECIDO, 3) +
      formataAlfa(getAgenciaConta, 20) +
      formataAlfa(fNOME_FAVORECIDO, 30) +
      formataAlfa(fSEU_NUMERO, 20) +
      formataData(fDATA_PAGTO) +
      formataAlfa(fLoteBB.LayoutItau.TipoMoedaToStr(fTP_MOEDA),3) +
      formataNumero(fISPB,8) +
      DupeString('0',7) +
      formataNumero(fVALOR_PAGTO, 15, 2) +
      formataAlfa(fNOSSO_NUMERO, 15) +
      DupeString(' ',5) +
      DupeString('0',8) +
      DupeString('0',15) +
      formataAlfa(getFinalidadeDetalhe, 18) +
      '  ' +
      DupeString('0',6) +
      formataNumero(fCPF_CNPJ, 14) +
      formataAlfa(getFinalidadeDocStatusFuncionario, 2) +
      formataAlfa(FinalidadeTedToStr(fFINALIDADE_TED),5) +
      DupeString(' ',5) +
      formataAlfa(AvisoAgendamentoToStr(fAVISO),1) +
      DupeString(' ',10) +
      quebra_linha
  else
    if (fLoteBB.FORMA_PAGAMENTO = fpNotaFiscal) then
    begin
      result := '001' +
        formataNumero(fLoteBB.fCODIGO, 4) +
        '3' +
        formataNumero(fREGISTRO, 5) +
        'A' +
        formataNumero(TipoMovToStr(fTP_MOVIMENTO),3) +
        DupeString('0',3) +
        formataNumero(fBANCO_FAVORECIDO, 3) +
        formataAlfa(getAgenciaConta, 20) +
        formataAlfa(fNOME_FAVORECIDO, 30) +
        formataAlfa(fSEU_NUMERO, 20) +
        formataData(fDATA_PAGTO) +
        formataAlfa(fLoteBB.fLayoutBB.TipoMoedaToStr(fTP_MOEDA),3) +
        DupeString('0',15) +
        formataNumero(fVALOR_PAGTO, 15, 2) +
        formataAlfa(fNOSSO_NUMERO, 15)+
        DupeString(' ',5) +
        formataData(fDATA_EFETIVA) +
        formataNumero(fVALOR_EFETIVO, 15, 2) +
        ifthen(length(fNR_NOTA_CNPJ) <= 8,formataNumero(fNR_NOTA_CNPJ, 8)+DupeString('0',6), formataNumero(fNR_NOTA_CNPJ, 14)) +
        DupeString(' ',6) +
        DupeString('0',6) +
        formataNumero(fCPF_CNPJ, 14) +
        formataNumero(TipoIdentificacaoToStr(fTIPO_IDENTIFICACAO), 1) +
        DupeString(' ',11) +
        formataAlfa(AvisoAgendamentoToStr(fAVISO),1) +
        DupeString(' ',10) +
        quebra_linha;
    end
    else
      result := '';
end;

{ TLoteBB }

procedure TLoteBB.addSegmento(const pagamento: TPagamentoAlPagtoE);
begin
  if self.FORMA_PAGAMENTO in [fpCreditoContaCorrenteBanco, fpDocC,
     fpCreditoContaPoupancaBanco, fpCreditoContaCorrenteTitular, fpDocD, fpOrdemPagamentoDisposicao,
     fpOrdemPagamentoAcerto, fpTedOutroTitular, fpTedMesmoTitular] then
  begin
    AddSegmentoA(pagamento);
  end
  else
    if self.FORMA_PAGAMENTO in [fpCobrancaBanco, fpCobrancaOutrosBancos] then
    begin
      AddSegmentoJ(pagamento);
      AddSegmentoJ52(pagamento);
    end
    else
    if self.FORMA_PAGAMENTO in [fpGPS, fpFgtsGfip] then
      AddSegmentoN(pagamento)
    else
      if self.FORMA_PAGAMENTO in [fpPagamentoConcessionarias, fpGnreTributosBarras] then
        AddSegmentoO(pagamento)
      else
        Raise Exception.Create('Forma de pagamento não implementada');
end;

procedure TLoteBB.AddSegmentoA(const pagamento: TPagamentoAlPagtoE);
begin
  with fLISTSEGMENTOA.New(Self) do
  begin
    REGISTRO := incSegmentoSeq(1);
    TP_MOVIMENTO := pagamento.TP_MOVIMENTO;
    BANCO_FAVORECIDO := pagamento.BANCO_FAVORECIDO;
    AGENCIA_FAVORECIDO := pagamento.AGENCIA_FAVORECIDO;
    NOME_FAVORECIDO := pagamento.NOME_FAVORECIDO;
    CONTA_FAVORECIDO := pagamento.CONTA_FAVORECIDO;
    DAC_AGENCIA_FAVORECIDO := pagamento.DAC_AGENCIA_FAVORECIDO;
    SEU_NUMERO := pagamento.SEU_NUMERO;
    DATA_PAGTO := pagamento.DATA_PAGTO;
    TP_MOEDA := pagamento.TP_MOEDA;
    ISPB := pagamento.ISPB;
    VALOR_PAGTO := pagamento.VALOR_PAGTO;
    FINALIDADE_DETALHE := pagamento.FINALIDADE_DETALHE;
    FINALIDADE_DETALHE_OUTRO := pagamento.FINALIDADE_DETALHE_OUTRO;
    CPF_CNPJ := pagamento.CPF_CNPJ;
    FINALIDADE_DOC := pagamento.FINALIDADE_DOC;
    STATUS_FUNCIONARIO := pagamento.STATUS_FUNCIONARIO;
    FINALIDADE_TED := pagamento.FINALIDADE_TED;
    NOSSO_NUMERO := pagamento.NOSSO_NUMERO;
    AVISO := pagamento.AVISO;
  end
end;

procedure TLoteBB.AddSegmentoJ(const pagamento: TPagamentoAlPagtoE);
begin
  with fLISTSEGMENTOJ.New(self) do
  begin
    REGISTRO := incSegmentoSeq(1);
    TP_MOVIMENTO := pagamento.TP_MOVIMENTO;
    BANCO_BARRAS := intToStr(pagamento.BANCO_FAVORECIDO);
    MOEDA_BARRAS := pagamento.MOEDA_BARRAS;
    DV_BARRAS := pagamento.DV_BARRAS;
    VENCIMENTO_BARRAS := pagamento.VENCIMENTO_BARRAS;
    VALOR_BARRAS := pagamento.VALOR_BARRAS;
    CAMPO_LIVRE := pagamento.CAMPO_LIVRE;
    NOME_FAVORECIDO := pagamento.NOME_FAVORECIDO;
    DATA_VENCIMENTO := pagamento.DATA_VENCIMENTO;
    VALOR_TITULO := pagamento.VALOR_TITULO;
    DESCONTOS := pagamento.DESCONTOS;
    ACRESCIMOS := pagamento.ACRESCIMOS;
    DATA_PAGAMENTO := pagamento.DATA_PAGTO;
    VALOR_PAGAMENTO := pagamento.VALOR_PAGTO;
    SEU_NUMERO := pagamento.SEU_NUMERO;
    NOSSO_NUMERO := pagamento.NOSSO_NUMERO;
  end
end;

procedure TLoteBB.AddSegmentoJ52(const pagamento: TPagamentoAlPagtoE);
begin
  with fLISTSEGMENTOJ52.New(self) do
  begin
    REGISTRO := incSegmentoSeq(0);
    TP_MOVIMENTO := pagamento.TP_MOVIMENTO;
    TP_INSCRICAO_PAGADOR := pagamento.TP_INSCRICAO;
    INSCRICAO_PAGADOR := pagamento.INSCRICAO;
    NOME_PAGADOR := pagamento.NOME_EMPRESA;
    TP_INSCRICAO_BENEFICIARIO := pagamento.TP_INSCRICAO_FAVORECIDO;
    INSCRICAO_BENEFICIARIO := pagamento.CPF_CNPJ;
    NOME_BENEFICIARIO := pagamento.NOME_FAVORECIDO;
  end
end;

procedure TLoteBB.AddSegmentoN(const pagamento: TPagamentoAlPagtoE);
begin
  with fLISTSEGMENTON.New(self) do
  begin
    REGISTRO := incSegmentoSeq(1);
    TP_MOVIMENTO := pagamento.TP_MOVIMENTO;
    if pagamento.FORMA_PAGAMENTO = fpGPS then
    begin
      DADOS_TRIBUTO := TTributoGPS.Create;
      DADOS_TRIBUTO.getPagamento(pagamento);
    end
    else
    begin
      DADOS_TRIBUTO := TTributoFGTS.Create;
      DADOS_TRIBUTO.getPagamento(pagamento);
    end;
    SEU_NUMERO := pagamento.SEU_NUMERO;
    NOSSO_NUMERO := pagamento.NOSSO_NUMERO;
  end;
end;

procedure TLoteBB.AddSegmentoO(const pagamento: TPagamentoAlPagtoE);
begin
  with fLISTSEGMENTOO.New(self) do
  begin
    REGISTRO := incSegmentoSeq(1);
    TP_MOVIMENTO := pagamento.TP_MOVIMENTO;
    COD_BARRA := pagamento.CAMPO_LIVRE;
    NOME := pagamento.NOME_FAVORECIDO;
    DATA_VENCIMENTO := pagamento.DATA_VENCIMENTO;
    VALOR_PAGAR := pagamento.VALOR_PAGTO;
    DATA_PAGAMENTO := pagamento.DATA_PAGTO;
    SEU_NUMERO := pagamento.SEU_NUMERO;
    NOSSO_NUMERO := pagamento.NOSSO_NUMERO;
  end
end;

constructor TLoteBB.Create(AOwner: TArquivoBB);
begin
  fSEGMENTO_SEQ := 0;
  fLISTSEGMENTOA := TSegmentoAList.Create;
  fLISTSEGMENTOJ := TSegmentoJList.Create;
  fLISTSEGMENTOJ52 := TSegmentoJ52List.Create;
  fLISTSEGMENTON := TSegmentoNList.Create;
  fLISTSEGMENTOO := TSegmentoOList.Create;
  fLayoutBB := AOwner;
end;

destructor TLoteBB.Destroy;
begin
  fLISTSEGMENTOA.Clear;
  fLISTSEGMENTOA.Free;
  fLISTSEGMENTOJ.Clear;
  fLISTSEGMENTOJ.Free;
  fLISTSEGMENTOJ52.Clear;
  fLISTSEGMENTOJ52.Free;
  fLISTSEGMENTON.Clear;
  fLISTSEGMENTON.Free;
  fLISTSEGMENTOO.Clear;
  fLISTSEGMENTOO.Free;
end;

function TLoteBB.getLinhaLayout: String;
begin
  result := '001' +
    formataNumero(fCODIGO, 4) +                                                                            // 4
    '1C' +                                                                                                 // 8
    formataNumero(TipoPagToStr(fTP_PAGAMENTO),2) +                                                         // 10
    formataNumero(FormaPagToStr(fFORMA_PAGAMENTO),2) +                                                     // 12
    ifthen((fFORMA_PAGAMENTO in [fpCreditoContaCorrenteBanco, fpChequePagamento, fpDocC,
      fpCreditoContaPoupancaBanco, fpCreditoContaCorrenteTitular, fpDocD, fpTedOutroTitular,
      fpTedMesmoTitular, fpNotaFiscal]), '040', '040') +
    ' '+
    formataNumero(TipoInsToStr(fTP_INSCRICAO),1) +                                                         // 18
    formataNumero(fINSCRICAO, 14) +                                                                        // 19
    formataAlfa(formataNumero(fLayoutBB.fCODIGO_CONVENIO, 13), 20) +                                       // 33
    formataNumero(fAGENCIA, 5) +
    formataAlfa(fLayoutBB.fDIGITO_AGENCIA, 1) +
    formataNumero(fCONTA, 12) +
    formataAlfa(Copy(fLayoutBB.fDIGITO_CONTA, 1, 1), 1) +
    formataAlfa(ifThen(Length(fLayoutBB.fDIGITO_CONTA) > 1, Copy(fLayoutBB.fDIGITO_CONTA, 2, 1), '0'), 1) +
    formataAlfa(fNOME_EMPRESA, 30) +
    DupeString(' ', 40) +
//    formataAlfa(FinalidadeLoteToStr(fFINALIDADE_LOTE_PREFIXO),2)+
//    formataAlfa(fFINALIDADE_LOTE,28) +
//    formataAlfa(fHISTORICOC_CC, 10) +
    formataAlfa(fENDERECO, 30) +
    formataNumero(fNUMERO, 5) +
    formataAlfa(fCOMPLEMENTO, 15) +
    formataAlfa(fCIDADE,20) +
    formataNumero(fCEP,8)+
    formataAlfa(fESTADO,2) +
    DupeString(' ', 8) +
    DupeString('0', 10)+
    quebra_linha;
end;

function TLoteBB.getLinhaTrailer: String;
begin
  if (fFORMA_PAGAMENTO in [fpCreditoContaCorrenteBanco, fpChequePagamento, fpDocC,
      fpCreditoContaPoupancaBanco, fpCreditoContaCorrenteTitular, fpDocD, fpTedOutroTitular,
      fpTedMesmoTitular, fpNotaFiscal, fpCobrancaBanco, fpCobrancaOutrosBancos,
      fpPagamentoConcessionarias, fpGnreTributosBarras]) then
    Result := '001'+
      formataNumero(fCODIGO,4)+
      '5'+
      DupeString(' ',9)+
      formataNumero(fLISTSEGMENTOA.Count + fLISTSEGMENTOJ.Count + fLISTSEGMENTOJ52.Count + fLISTSEGMENTON.Count + fLISTSEGMENTOO.Count+2, 6) +
      formataNumero(fLISTSEGMENTOA.ValorPagamentos + fLISTSEGMENTOJ.ValorPagamentos + fLISTSEGMENTOO.ValorPagamentos , 18,2)+
      formataNumero('0', 18) +
      formataNumero('0', 6) +
      formataAlfa('', 165) +
      DupeString('0', 10) +
      quebra_linha
  else
    if (fFORMA_PAGAMENTO in [fpGPS, fpFgtsGfip]) then
      Result := '001'+
      formataNumero(fCODIGO,4)+
      '5'+
      DupeString(' ',9)+
      formataNumero(fLISTSEGMENTON.Count + 2, 6) +
      formataNumero(fLISTSEGMENTON.ValorPrincipal , 14,2)+
      formataNumero(fLISTSEGMENTON.ValorOutrasEntidades , 14,2)+
      formataNumero(fLISTSEGMENTON.ValorAcrescimos , 14,2)+
      formataNumero(fLISTSEGMENTON.ValorArrecadado , 14,2)+
      DupeString(' ',151)+
      DupeString('0',10)+
      quebra_linha;
end;

function TLoteBB.incSegmentoSeq(incremento: integer): integer;
begin
  fSEGMENTO_SEQ := fSEGMENTO_SEQ + incremento;
  Result := fSEGMENTO_SEQ;
end;

{ TLoteListBB }

function TLoteListBB.GetItem(Index: Integer): TLoteBB;
begin
  Result :=  TLoteBB(Inherited Items[Index]);
end;

function TLoteListBB.LocalizaRegistro(Codigo: integer): boolean;
var
  intFor: integer;
begin
   Result := false;
   for intFor := 0 to Self.Count - 1 do
   begin
     if Self.Items[intFor].fCODIGO = Codigo then
     begin
       Result := true;
       Break;
     end;
   end;
end;

function TLoteListBB.New(AOwner: TArquivoBB): TLoteBB;
begin
  Result := TLoteBB.Create(AOwner);
  Add(Result);
end;

procedure TLoteListBB.SetItem(Index: Integer; const Value: TLoteBB);
begin
  Put(Index, Value);
end;

{ TArquivoBB }

procedure TArquivoBB.addLinha(linha: String);
var
  tipo : String;
begin
  tipo := copy(linha, 8, 1);
  if tipo = '0' then
    addLinhaArquivo(linha)
  else
    if tipo = '1' then
      addLinhaLote(linha)
    else
      if tipo = '3' then
        addLinhaSegmento(linha);
end;

procedure TArquivoBB.addLinhaArquivo(linha: String);
var
  ok : boolean;
begin
  fTP_INSCRICAO := StrToTipoIns(ok, copy(linha, 18, 1));
  fINSCRICAO := copy(linha,19,14);
  fAGENCIA := copy(linha,53,5);
  fCONTA := copy(linha,59,12);
  fDAC_AGENCIA_CONTA := copy(linha,72, 1);
  fNOME_EMPRESA := copy(linha,73,30);
  fDATA_GERACAO := paraData(copy(linha,144,8));

  if Trim(copy(linha,152,6)) <> '' then
    fHORA_GERACAO := paraHora(copy(linha,152,6));
end;

procedure TArquivoBB.addLinhaLote(linha: String);
var
  ok : boolean;
begin
  with fLoteListBB.New(self) do
  begin
    CODIGO := StrToInt(copy(linha, 4, 4));
    TP_PAGAMENTO := StrToTipoPag(ok, copy(linha, 10, 2));
    FORMA_PAGAMENTO := StrToFormaPag(ok, copy(linha, 12, 2));
    TP_INSCRICAO := StrToTipoIns(ok, copy(linha, 18, 1));
    INSCRICAO := copy(linha, 19, 14);
    AGENCIA := copy(linha, 53, 5);
    CONTA := copy(linha, 59, 12);
    DAC_AGENCIA_CONTA := copy(linha, 72, 1);
    NOME_EMPRESA := copy(linha, 73, 30);
    FINALIDADE_LOTE_PREFIXO := StrToFinalidadeLote(ok, copy(linha, 103, 2));
    FINALIDADE_LOTE := copy(linha, 105, 28);
    HISTORICOC_CC := copy(linha, 133, 10);
    ENDERECO := copy(linha, 143, 30);
    NUMERO := copy(linha, 173, 5);
    COMPLEMENTO := copy(linha, 178, 15);
    CIDADE := copy(linha, 193, 20);
    CEP := copy(linha, 213, 8);
    ESTADO := copy(linha, 221, 2);
  end;
end;

procedure TArquivoBB.addLinhaSegmento(linha: String);
var
  segmento : string;
begin
  segmento := copy(linha,  14, 1);
  if segmento = 'A' then
  begin
    addLinhaSegmentoA(linha);
    fUltimoProcessadoJ := False;
  end
  else
    if segmento = 'J' then
    begin
      if not fUltimoProcessadoJ or (copy(linha, 18, 2) <> '52') then
        addLinhaSegmentoJ(linha)
      else
        fUltimoProcessadoJ := False;
    end
    else
    begin
      fUltimoProcessadoJ := False;

      if segmento = 'N' then
        addLinhaSegmentoN(linha)
      else
        if segmento = 'O' then
        addLinhaSegmentoO(linha)
    end;
end;

procedure TArquivoBB.addLinhaSegmentoA(linha: String);
var
  lote : TLoteBB;
  segmentoA : TSegmentoA;
  ok : boolean;
begin
  lote := getLote(StrToInt(copy(linha, 4, 4)));
  if lote <> nil then
  begin
    segmentoA := TSegmentoA.Create(lote);
    segmentoA.REGISTRO := StrToInt(copy(linha,9,5));
    segmentoA.TP_MOVIMENTO := StrToTipoMov(ok, copy(linha, 15, 3));
    segmentoA.BANCO_FAVORECIDO := StrToInt(copy(linha, 21, 3));
    segmentoA.AGENCIA_FAVORECIDO := getAgencia(segmentoA.BANCO_FAVORECIDO, copy(linha, 24,20));
    segmentoA.CONTA_FAVORECIDO := getConta(segmentoA.BANCO_FAVORECIDO, copy(linha, 24,20));
    segmentoA.DAC_AGENCIA_FAVORECIDO := copy(linha, 43, 1);
    segmentoA.NOME_FAVORECIDO := copy(linha, 44, 30);
    segmentoA.SEU_NUMERO := copy(linha, 74, 20);
    segmentoA.DATA_PAGTO := paraData(copy(linha, 94, 8));
    segmentoA.TP_MOEDA := StrToTipoMoeda(ok, copy(linha, 102, 3));
    segmentoA.VALOR_PAGTO := paraDouble(copy(linha, 120, 15), 2);
    segmentoA.NOSSO_NUMERO := copy(linha, 135, 15);
    segmentoA.DATA_EFETIVA := paraData(copy(linha, 155, 8));
    segmentoA.VALOR_EFETIVO := paraDouble(copy(linha, 163, 15), 2);
    segmentoA.DOCUMENTO := copy(linha, 198, 6);
    segmentoA.CPF_CNPJ := copy(linha, 204, 14);
    segmentoA.AVISO := StrToAvisoAgendamento(ok, copy(linha, 230, 1));
    segmentoA.OCORRENCIAS := copy(linha, 231, 10);
    if (lote.FORMA_PAGAMENTO in [fpCreditoContaCorrenteBanco, fpChequePagamento, fpDocC,
      fpCreditoContaPoupancaBanco, fpCreditoContaCorrenteTitular, fpDocD, fpTedOutroTitular,
      fpTedMesmoTitular]) then
    begin
      segmentoA.ISPB := copy(linha, 105, 8);
      segmentoA.FINALIDADE_DETALHE := StrToHistoricoVar(ok, copy(linha, 178, 4));
      segmentoA.FINALIDADE_DETALHE_OUTRO := copy(linha, 182, 14);
      if lote.FORMA_PAGAMENTO = fpDocC then
        segmentoA.FINALIDADE_DOC := StrToFinalidadeDoc(ok, copy(linha, 218, 2))
      else
        if (lote.TP_PAGAMENTO = tpSalarios) and (lote.FORMA_PAGAMENTO = fpCreditoContaCorrenteBanco) then
          segmentoA.STATUS_FUNCIONARIO := StrToStatusFuncionario(ok, copy(linha, 218, 2));
      segmentoA.FINALIDADE_TED := StrToFinalidadeTed(ok, copy(linha, 220, 5));
    end
    else
      if (lote.FORMA_PAGAMENTO = fpNotaFiscal) then
      begin
        segmentoA.NR_NOTA_CNPJ := copy(linha, 178, 14);
        segmentoA.TIPO_IDENTIFICACAO := StrToTipoIdentificacao(ok, copy(linha, 128, 1));
      end;

    lote.LISTSEGMENTOA.Add(segmentoA);
  end;
end;

procedure TArquivoBB.addLinhaSegmentoJ(linha: String);
var
  lote : TLoteBB;
  segmentoJ : TSegmentoJ;
  ok : boolean;
begin
  lote := getLote(StrToInt(copy(linha, 4, 4)));
  if lote <> nil then
  begin
    segmentoJ := TSegmentoJ.Create(lote);
    segmentoJ.REGISTRO := StrToInt(copy(linha,9,5));
    segmentoJ.TP_MOVIMENTO := StrToTipoMov(ok, copy(linha, 15, 3));
    segmentoJ.BANCO_BARRAS := copy(linha, 18, 3);
    segmentoJ.MOEDA_BARRAS := copy(linha, 21, 1);
    segmentoJ.DV_BARRAS := copy(linha, 22, 1);
    segmentoJ.VENCIMENTO_BARRAS := copy(linha, 23, 4);
    segmentoJ.VALOR_BARRAS := paraDouble(copy(linha, 18, 3), 2);
    segmentoJ.CAMPO_LIVRE := copy(linha, 37, 25);
    segmentoJ.NOME_FAVORECIDO := copy(linha, 62, 30);
    segmentoJ.DATA_VENCIMENTO := paraData(copy(linha, 92, 8));
    segmentoJ.VALOR_TITULO := paraDouble(copy(linha, 100, 15), 2);
    segmentoJ.DESCONTOS := paraDouble(copy(linha, 115, 15), 2);
    segmentoJ.ACRESCIMOS := paraDouble(copy(linha, 130, 15), 2);
    segmentoJ.DATA_PAGAMENTO := paraData(copy(linha, 145, 8));
    segmentoJ.VALOR_PAGAMENTO := paraDouble(copy(linha, 153, 15), 2);
    segmentoJ.SEU_NUMERO := copy(linha, 183, 20);
    segmentoJ.NOSSO_NUMERO := copy(linha, 216, 15);
    segmentoJ.OCORRENCIAS := copy(linha, 231, 10);
    lote.LISTSEGMENTOJ.Add(segmentoJ);

    fUltimoProcessadoJ := True;
  end;
end;

procedure TArquivoBB.addLinhaSegmentoN(linha: String);
var
  lote : TLoteBB;
  segmentoN : TSegmentoN;
  ok : boolean;
begin
  lote := getLote(StrToInt(copy(linha, 4, 4)));
  if lote <> nil then
  begin
    segmentoN := TSegmentoN.Create(lote);
    segmentoN.REGISTRO := StrToInt(copy(linha,9,5));
    segmentoN.TP_MOVIMENTO := StrToTipoMov(ok, copy(linha, 15, 3));
    if lote.FORMA_PAGAMENTO = fpGPS then
      segmentoN.DADOS_TRIBUTO := TTributoGPS.Create
    else
      if lote.FORMA_PAGAMENTO = fpFgtsGfip then
        segmentoN.DADOS_TRIBUTO := TTributoFGTS.Create
      else
        raise Exception.Create('forma de pagamento nao disponivel no segmento N');
    segmentoN.DADOS_TRIBUTO.setTributoStr(copy(linha, 18,178));
    segmentoN.SEU_NUMERO := copy(linha, 196, 20);
    segmentoN.NOSSO_NUMERO := copy(linha, 216,15);
    segmentoN.OCORRENCIAS := copy(linha, 231, 10);
    lote.LISTSEGMENTON.Add(segmentoN);
  end
end;

procedure TArquivoBB.addLinhaSegmentoO(linha: String);
var
  lote : TLoteBB;
  segmentoO : TSegmentoO;
  ok : boolean;
begin
  lote := getLote(StrToInt(copy(linha, 4, 4)));
  if lote <> nil then
  begin
    segmentoO := TSegmentoO.Create(lote);
    segmentoO.REGISTRO := StrToInt(copy(linha,9,5));
    segmentoO.TP_MOVIMENTO := StrToTipoMov(ok, copy(linha, 15, 3));
    segmentoO.COD_BARRA := copy(linha, 18, 48);
    segmentoO.NOME := copy(linha, 66, 30);
    segmentoO.DATA_VENCIMENTO := paraData(copy(linha, 96, 8));
    segmentoO.VALOR_PAGAR := paraDouble(copy(linha, 122, 15), 2);
    segmentoO.DATA_PAGAMENTO := paraData(copy(linha, 137, 8));
    segmentoO.VALOR_PAGO := paraDouble(copy(linha, 145,15), 2);
    segmentoO.SEU_NUMERO := copy(linha, 175, 20);
    segmentoO.NOSSO_NUMERO := copy(linha, 216,15);
    segmentoO.OCORRENCIAS := copy(linha, 231, 10);
    lote.LISTSEGMENTOO.Add(segmentoO);
  end
end;

procedure TArquivoBB.addPagamento(pagamento: TPagamentoAlPagtoE; TP_INSCRICAO : TTipoInsALPagtoE;
                                  INSCRICAOMATRIZ, fAGENCIA, fCONTA, fDAC_AGENCIA_CONTA, fNOME_EMPRESA, pCODIGO_CONVENIO: String;
                                  pCODIGO_REMESSA: Integer; pDT_GERACAO: TDate; pHR_GERACAO: TTime; pDIGITO_AGENCIA, pDIGITO_CONTA: String);
var
  lote : TLoteBB;

begin
  validaTipoForm(pagamento.TP_PAGAMENTO, pagamento.FORMA_PAGAMENTO);

  self.fTP_INSCRICAO := TP_INSCRICAO;
  self.fINSCRICAO := INSCRICAOMATRIZ;
  self.fAGENCIA := fAGENCIA;
  self.fCONTA := fCONTA;
  self.fDAC_AGENCIA_CONTA := fDAC_AGENCIA_CONTA;
  self.fNOME_EMPRESA := fNOME_EMPRESA;
  self.fCODIGO_CONVENIO := pCODIGO_CONVENIO;
  self.fCODIGO_REMESSA := pCODIGO_REMESSA;
  self.DATA_GERACAO := pDT_GERACAO;
  self.HORA_GERACAO := pHR_GERACAO;
  self.DIGITO_AGENCIA := pDIGITO_AGENCIA;
  self.DIGITO_CONTA := pDIGITO_CONTA;

  lote := retornaLote(pagamento);
  lote.addSegmento(pagamento);
end;

procedure TArquivoBB.atualizarDadosLote(var pagamento: TPagamentoAlPagtoE; lote: TLoteBB);
begin
  pagamento.TP_PAGAMENTO := lote.TP_PAGAMENTO;
  pagamento.FORMA_PAGAMENTO :=  lote.fFORMA_PAGAMENTO;
  pagamento.TP_INSCRICAO := lote.TP_INSCRICAO;
  pagamento.INSCRICAO :=  lote.INSCRICAO ;
  pagamento.AGENCIA := lote.AGENCIA  ;
  pagamento.CONTA := lote.CONTA ;
  pagamento.DAC_AGENCIA_CONTA := lote.DAC_AGENCIA_CONTA ;
  pagamento.NOME_EMPRESA := lote.NOME_EMPRESA ;
  pagamento.FINALIDADE_LOTE_PREFIXO := lote.FINALIDADE_LOTE_PREFIXO ;
  pagamento.FINALIDADE_LOTE := lote.FINALIDADE_LOTE ;
  pagamento.HISTORICOC_CC := lote.HISTORICOC_CC ;
  pagamento.ENDERECO := lote.ENDERECO ;
  pagamento.NUMERO := lote.NUMERO ;
  pagamento.COMPLEMENTO := lote.COMPLEMENTO ;
  pagamento.CIDADE := lote.CIDADE ;
  pagamento.CEP := lote.CEP ;
  pagamento.ESTADO := lote.ESTADO ;
end;

function TArquivoBB.CarregarArquivo(nome_arquivo: string): boolean;
var
  layout : TextFile;
  linha : String;

begin
  try
    AssignFile(layout, nome_arquivo);
    reset(layout);
    while not eof(layout) do
    begin
      Readln(layout, linha);
      addLinha(linha);
    end;
    CloseFile(layout);
    popularRetorno;
    result := true;
  Except
    raise
  end;
end;

procedure TArquivoBB.clearPagamento;
begin
  fLoteListBB.Clear;
  fRetorno.Clear;
end;

function TArquivoBB.contaRetorno: integer;
begin
  result := fRetorno.Count;
end;

constructor TArquivoBB.Create;
begin
  fLoteListBB := TLoteListBB.Create;
  fRetorno := TPagamentoList.Create;
  fDENSIDADE := 1600;
end;

destructor TArquivoBB.Destroy;
begin
  fLoteListBB.Free;
  fRetorno.Free;
end;

function TArquivoBB.GerarArquivo(nome_arquivo:string) : boolean;
var
  iLote, iSeg : integer;
  layout : TextFile;

begin
  try
    AssignFile(layout, nome_arquivo);
    rewrite(layout);

    //arquivo
    write(layout, getLinhaLayout);
    fLinhas :=1;

    //lotes
    for iLote := 0 to fLoteListBB.Count - 1 do
    begin
      write(layout, fLoteListBB.Items[iLote].getLinhaLayout);
      inc(fLinhas);
      //segmento A
      for iSeg := 0 to fLoteListBB.Items[iLote].fLISTSEGMENTOA.Count - 1 do
        write(layout, fLoteListBB.Items[iLote].LISTSEGMENTOA.Items[iSeg].getLinhaLayout);

      //segmento J e J52
      for iSeg := 0 to fLoteListBB.Items[iLote].fLISTSEGMENTOJ.Count - 1 do
      begin
        write(layout, fLoteListBB.Items[iLote].LISTSEGMENTOJ.Items[iSeg].getLinhaLayout);
        write(layout, fLoteListBB.Items[iLote].LISTSEGMENTOJ52.Items[iSeg].getLinhaLayout);
      end;

      //segmento N
     for iSeg := 0 to fLoteListBB.Items[iLote].fLISTSEGMENTON.Count - 1 do
        write(layout, fLoteListBB.Items[iLote].LISTSEGMENTON.Items[iSeg].getLinhaLayout);
      //segmento O
      for iSeg := 0 to fLoteListBB.Items[iLote].fLISTSEGMENTOO.Count - 1 do
        write(layout, fLoteListBB.Items[iLote].LISTSEGMENTOO.Items[iSeg].getLinhaLayout);

      inc(fLinhas, fLoteListBB.Items[iLote].fLISTSEGMENTOA.Count);
      inc(fLinhas, fLoteListBB.Items[iLote].fLISTSEGMENTOJ.Count);
      inc(fLinhas, fLoteListBB.Items[iLote].fLISTSEGMENTON.Count);
      inc(fLinhas, fLoteListBB.Items[iLote].fLISTSEGMENTOO.Count);

      write(layout, fLoteListBB.Items[iLote].getLinhaTrailer);
      inc(fLinhas);
    end;

    write(layout, getlinhaTrailer);
    inc(fLinhas);

//    write(layout, quebra_linha);
    CloseFile(layout);
    result := true;
  Except
    raise
  end;
end;

function TArquivoBB.getLinhaLayout: String;
var
  i : integer;
  ins_verifica : String;
  inscricao_util, agencia_util, conta_util, dac_util, empresa_util : String;
  tipo_util : TTipoInsALPagtoE;

begin
  //verificar se a inscricao de todos os lotes sao a mesma. Se for utilizar, senao utilizar a da matriz;
  tipo_util := fTP_INSCRICAO;

  ins_verifica := '';
  for i:= 0 to Self.LOTELISTBB.Count - 1 do
  begin
    if (ins_verifica <> '')and(ins_verifica <> self.LOTELISTBB.Items[i].INSCRICAO) then
    begin
      inscricao_util := fINSCRICAO;
      tipo_util := fTP_INSCRICAO;
      agencia_util := fAGENCIA;
      conta_util := fCONTA;
      dac_util := ifThen(Length(fDAC_AGENCIA_CONTA) > 1, Copy(fDAC_AGENCIA_CONTA, 2, 1), '0');
      empresa_util := fNOME_EMPRESA;
      break;
    end
    else
    begin
      inscricao_util := self.LOTELISTBB.Items[i].INSCRICAO;
      tipo_util := self.LOTELISTBB.Items[i].TP_INSCRICAO;
      agencia_util := self.LOTELISTBB.Items[i].AGENCIA;
      conta_util := self.LOTELISTBB.Items[i].CONTA;
      dac_util := ifThen(Length(self.LOTELISTBB.Items[i].DAC_AGENCIA_CONTA) > 1, Copy(self.LOTELISTBB.Items[i].DAC_AGENCIA_CONTA, 2, 1), '0');
      empresa_util := self.LOTELISTBB.Items[i].NOME_EMPRESA;
    end;
    ins_verifica := self.LOTELISTBB.Items[i].INSCRICAO;
  end;

  Result := '00100000         ' +
      FormataNumero(TipoInsToStr(tipo_util), 1) +                  //18
      formataNumero(inscricao_util, 14) +                          //19
      formataAlfa(formataNumero(fCODIGO_CONVENIO, 13), 20) +       //33
      formataNumero(agencia_util, 5) +                             //53
      formataAlfa(digito_agencia, 1) +                             //58
      formataNumero(conta_util, 12) +                              //59
      formataAlfa(Copy(fdigito_conta, 1, 1), 1) +                  //71
      formataAlfa(dac_util, 1) +                                   //72
      formataAlfa(empresa_util, 30) +                              //73
      formataAlfa('BANCO DO BRASIL S.A.', 30) +                    //103
      DupeString(' ', 10) +                                        //133
      FormataNumero(TipoArquivoToStr(fTP_ARQUIVO), 1) +            //143
      formataData(fDATA_GERACAO) +                                 //144
      formataHora(fHORA_GERACAO) +                                 //152
      formataNumero(fCODIGO_REMESSA, 6) +                          //158
      formataNumero('101', 3) +                                    //164
      formataNumero(fDENSIDADE, 5) +                               //167
      DupeString(' ', 54) +                                        //172
      DupeString('0', 15) +                                        //226
      quebra_linha;
end;

function TArquivoBB.getLinhaTrailer: String;
var
  lx: Integer;
  lTotal: Integer;

begin
  lTotal := 0;

  for lX := 0 to Pred(fLoteListBB.Count) do
  begin
    lTotal := lTotal + fLoteListBB.Items[lX].LISTSEGMENTOA.Count +
              fLoteListBB.Items[lX].LISTSEGMENTOJ.Count +
              fLoteListBB.Items[lX].LISTSEGMENTOJ52.Count +
              fLoteListBB.Items[lX].LISTSEGMENTON.Count +
              fLoteListBB.Items[lX].LISTSEGMENTOO.Count + 2;
  end;

  lTotal := lTotal + 2;

  result :=  '00199999' +
    DupeString(' ',9) +
    formataNumero(fLoteListBB.Count, 6) +
    formataNumero(intToStr(lTotal), 6)+
    DupeString('0', 6) +
    DupeString(' ', 205);
end;

function TArquivoBB.getLote(codigo : integer): TLoteBB;
var
  iLote : integer;
begin
  for iLote := 0 to fLoteListBB.Count - 1 do
  begin
    if fLoteListBB.GetItem(iLote).CODIGO = codigo then
    begin
      result := fLoteListBB.GetItem(iLote);
      exit;
    end
  end;
  result := nil;
end;

function TArquivoBB.getRetorno(pos : integer): TPagamentoAlPagtoE;
begin
  Result := fRetorno.Items[pos];
end;

function TArquivoBB.OcorrenciasToResultado(Ocorrencias: TAResultadoAlPagto): integer;
var
  ct, cf, i, resultado : integer;
begin
  ct := 0;
  cf := 0;
  for i := 1 to length(Ocorrencias) do
  begin
    if Ocorrencias[i].codigo <> '' then
    begin
      if Ocorrencias[i].resultado then
        inc(ct)
      else
        inc(cf);
    end;
  end;
  if (ct > 0) and (cf = 0) then
    RESULTADO := 0
  else
    if (ct > 0) and (cf > 0) then
      RESULTADO := 1
    else
      RESULTADO := 2;
  result := resultado;
end;

function TArquivoBB.OcorrenciaStringToResultado(pSigla: String): TResultadoALPagto;
var
  i : integer;
  r : TResultadoALPagto;

begin
  for i := 0 to High(TOcorrenciaBBString) do
  begin
    if pSigla = TOcorrenciaBBString[i,0] then
    begin
       r.codigo := pSigla;
       r.descricao := TOcorrenciaBBString[i, 1];
       r.resultado := TOcorrenciaBBString[i, 2] = '0';
       r.tagERP := TOcorrenciaBBString[i, 3];
       Result := r;
       exit;
    end
  end;
  r.codigo := 'XXX';
  r.descricao := 'Ocorrencia não encontrada';
  r.resultado := false;
  result := r;
end;

procedure TArquivoBB.popularRetorno;
var
  i, j : integer;
begin
  for i := 0 to fLoteListBB.Count - 1 do
  begin
    for j := 0 to fLoteListBB.Items[i].fLISTSEGMENTOA.Count - 1 do
      fRetorno.Add(segmentoAToPagamento(fLoteListBB.Items[i].fLISTSEGMENTOA.Items[j]));
    for j := 0 to fLoteListBB.Items[i].fLISTSEGMENTOJ.Count - 1 do
      fRetorno.Add(segmentoJToPagamento(fLoteListBB.Items[i].fLISTSEGMENTOJ.Items[j]));
    for j := 0 to fLoteListBB.Items[i].fLISTSEGMENTON.Count - 1 do
      fRetorno.Add(segmentoNToPagamento(fLoteListBB.Items[i].fLISTSEGMENTON.Items[j]));
    for j := 0 to fLoteListBB.Items[i].fLISTSEGMENTOO.Count - 1 do
      fRetorno.Add(segmentoOToPagamento(fLoteListBB.Items[i].fLISTSEGMENTOO.Items[j]));
  end;
end;

function TArquivoBB.retornaLote(pagamento: TPagamentoAlPagtoE): TLoteBB;
var
  iLote, n : integer;
begin

  for iLote := 0 to fLoteListBB.Count - 1 do
  begin
    if (fLoteListBB.Items[iLote].TP_PAGAMENTO = pagamento.TP_PAGAMENTO) and
       (fLoteListBB.Items[iLote].fFORMA_PAGAMENTO = pagamento.FORMA_PAGAMENTO) and
       (fLoteListBB.Items[iLote].INSCRICAO = pagamento.INSCRICAO) and
       (fLoteListBB.Items[iLote].AGENCIA = pagamento.AGENCIA) and
       (fLoteListBB.Items[iLote].CONTA = pagamento.CONTA) and
       (fLoteListBB.Items[iLote].DAC_AGENCIA_CONTA = pagamento.DAC_AGENCIA_CONTA) and
       (fLoteListBB.Items[iLote].FINALIDADE_LOTE_PREFIXO = pagamento.FINALIDADE_LOTE_PREFIXO) and
       (fLoteListBB.Items[iLote].FINALIDADE_LOTE = pagamento.FINALIDADE_LOTE) and
       (fLoteListBB.Items[iLote].HISTORICOC_CC = pagamento.HISTORICOC_CC) then
    begin
      result := fLoteListBB.Items[iLote];
      exit;
    end
  end;
  n := fLoteListBB.Count + 1;
  with fLoteListBB.New(self) do
  begin
    fCODIGO := n;
    TP_PAGAMENTO := pagamento.TP_PAGAMENTO;
    FORMA_PAGAMENTO := pagamento.FORMA_PAGAMENTO;
    TP_INSCRICAO := pagamento.TP_INSCRICAO;
    INSCRICAO := pagamento.INSCRICAO;
    AGENCIA := pagamento.AGENCIA;
    CONTA := pagamento.CONTA;
    DAC_AGENCIA_CONTA := pagamento.DAC_AGENCIA_CONTA;
    NOME_EMPRESA := pagamento.NOME_EMPRESA;
    FINALIDADE_LOTE_PREFIXO := pagamento.FINALIDADE_LOTE_PREFIXO;
    FINALIDADE_LOTE := pagamento.FINALIDADE_LOTE;
    HISTORICOC_CC := pagamento.HISTORICOC_CC;
    ENDERECO := pagamento.ENDERECO;
    NUMERO := pagamento.NUMERO;
    COMPLEMENTO := pagamento.COMPLEMENTO;
    CIDADE := pagamento.CIDADE;
    CEP := pagamento.CEP;
    ESTADO := pagamento.ESTADO;
    result := fLoteListBB.Items[fLoteListBB.count - 1];
  end;
end;

function TArquivoBB.segmentoAToPagamento(segmento: TSegmentoA): TPagamentoAlPagtoE;
var
  pagamento : TPagamentoAlPagtoE;

begin
  pagamento := TPagamentoAlPagtoE.Create;
  atualizarDadosLote(pagamento, segmento.fLoteBB);

  pagamento.TP_MOVIMENTO := segmento.TP_MOVIMENTO;
  pagamento.BANCO_FAVORECIDO := segmento.BANCO_FAVORECIDO;
  pagamento.AGENCIA_FAVORECIDO := segmento.AGENCIA_FAVORECIDO;
  pagamento.NOME_FAVORECIDO := segmento.NOME_FAVORECIDO;
  pagamento.SEU_NUMERO := segmento.SEU_NUMERO;
  pagamento.DATA_PAGTO := segmento.DATA_PAGTO;
  pagamento.TP_MOEDA := segmento.TP_MOEDA;
  pagamento.VALOR_PAGTO := segmento.VALOR_PAGTO;
  pagamento.NOSSO_NUMERO := segmento.NOSSO_NUMERO;
  pagamento.DATA_EFETIVA := segmento.DATA_EFETIVA;
  pagamento.VALOR_EFETIVO := segmento.VALOR_EFETIVO;
  pagamento.DOCUMENTO := segmento.DOCUMENTO;
  pagamento.CPF_CNPJ := segmento.CPF_CNPJ;
  pagamento.AVISO := segmento.AVISO;
  pagamento.Ocorrencias := StrToAResultado(segmento.OCORRENCIAS);
  pagamento.RESULTADO := OcorrenciasToResultado(pagamento.Ocorrencias);

  if (segmento.LOTEBB.FORMA_PAGAMENTO in [fpCreditoContaCorrenteBanco, fpChequePagamento, fpDocC,
      fpCreditoContaPoupancaBanco, fpCreditoContaCorrenteTitular, fpDocD, fpTedOutroTitular,
      fpTedMesmoTitular]) then
  begin
    pagamento.ISPB := segmento.ISPB;
    pagamento.FINALIDADE_DETALHE := segmento.FINALIDADE_DETALHE;
    pagamento.FINALIDADE_DETALHE_OUTRO := segmento.FINALIDADE_DETALHE_OUTRO;
    if segmento.LOTEBB.FORMA_PAGAMENTO = fpDocC then
      pagamento.FINALIDADE_DOC := segmento.FINALIDADE_DOC
    else
      if (segmento.LOTEBB.TP_PAGAMENTO = tpSalarios) and (segmento.LOTEBB.FORMA_PAGAMENTO = fpCreditoContaCorrenteBanco) then
        pagamento.STATUS_FUNCIONARIO := segmento.STATUS_FUNCIONARIO;
    pagamento.FINALIDADE_TED := segmento.FINALIDADE_TED;
  end
  else
    if (segmento.LOTEBB.FORMA_PAGAMENTO = fpNotaFiscal) then
    begin
      pagamento.NR_NOTA_CNPJ := segmento.NR_NOTA_CNPJ;
      pagamento.TIPO_IDENTIFICACAO := segmento.TIPO_IDENTIFICACAO;
    end;
  result := pagamento;
end;

function TArquivoBB.segmentoJToPagamento(Segmento: TSegmentoJ): TPagamentoAlPagtoE;
var
  pagamento : TPagamentoAlPagtoE;
begin
  pagamento := TPagamentoAlPagtoE.Create;
  atualizarDadosLote(pagamento, segmento.fAOwner);
  pagamento.TP_MOVIMENTO := segmento.TP_MOVIMENTO;
  pagamento.BANCO_FAVORECIDO := STrToInt(segmento.BANCO_BARRAS);
  pagamento.MOEDA_BARRAS := segmento.MOEDA_BARRAS;
  pagamento.DV_BARRAS := segmento.DV_BARRAS;
  pagamento.VENCIMENTO_BARRAS := segmento.VENCIMENTO_BARRAS;
  pagamento.VALOR_BARRAS := segmento.VALOR_BARRAS;
  pagamento.CAMPO_LIVRE := segmento.CAMPO_LIVRE;
  pagamento.NOME_FAVORECIDO := segmento.NOME_FAVORECIDO;
  pagamento.DATA_VENCIMENTO := segmento.DATA_VENCIMENTO;
  pagamento.VALOR_TITULO := segmento.VALOR_TITULO;
  pagamento.DESCONTOS := segmento.DESCONTOS;
  pagamento.ACRESCIMOS := segmento.ACRESCIMOS;
  pagamento.DATA_PAGTO := segmento.DATA_PAGAMENTO;
  pagamento.VALOR_PAGTO :=segmento.VALOR_PAGAMENTO;
  pagamento.SEU_NUMERO := segmento.SEU_NUMERO;
  pagamento.Ocorrencias := StrToAResultado(segmento.OCORRENCIAS);
  pagamento.NOSSO_NUMERO := segmento.NOSSO_NUMERO;
  pagamento.RESULTADO := OcorrenciasToResultado(pagamento.Ocorrencias);
  result := pagamento;
end;

function TArquivoBB.segmentoNToPagamento(segmento: TSegmentoN): TPagamentoAlPagtoE;
var
  pagamento : TPagamentoAlPagtoE;

begin
  pagamento := TPagamentoAlPagtoE.Create;
  atualizarDadosLote(pagamento, segmento.fAOwner);
  pagamento.TP_MOVIMENTO := segmento.TP_MOVIMENTO;
  segmento.DADOS_TRIBUTO.setPagamento(pagamento);
  pagamento.SEU_NUMERO := segmento.SEU_NUMERO;
  pagamento.Ocorrencias := StrToAResultado(segmento.OCORRENCIAS);
  pagamento.NOSSO_NUMERO := segmento.NOSSO_NUMERO;
  pagamento.RESULTADO := OcorrenciasToResultado(pagamento.Ocorrencias);
  result := pagamento;
end;

function TArquivoBB.segmentoOToPagamento(segmento: TSegmentoO): TPagamentoAlPagtoE;
var
  pagamento : TPagamentoAlPagtoE;
begin
  pagamento := TPagamentoAlPagtoE.Create;
  atualizarDadosLote(pagamento, segmento.fAOwner);
  pagamento.TP_MOVIMENTO := segmento.TP_MOVIMENTO;
  pagamento.CAMPO_LIVRE := segmento.COD_BARRA;
  pagamento.NOME_FAVORECIDO := segmento.NOME;
  pagamento.DATA_VENCIMENTO := segmento.DATA_VENCIMENTO;
  pagamento.VALOR_PAGTO := segmento.VALOR_PAGAR;
  pagamento.DATA_PAGTO := segmento.DATA_PAGAMENTO;
  pagamento.SEU_NUMERO := segmento.SEU_NUMERO;
  pagamento.Ocorrencias := StrToAResultado(segmento.OCORRENCIAS);
  pagamento.NOSSO_NUMERO := segmento.NOSSO_NUMERO;
  pagamento.RESULTADO := OcorrenciasToResultado(pagamento.Ocorrencias);
  result := pagamento;
end;

function TArquivoBB.StrToAResultado(Ocorrencias: String): TAResultadoAlPagto;
var
  i : integer;
  aResult : TAResultadoAlPagto;
  sigla : string;
begin
  for i := 1 to 5 do
  begin
    sigla := trim(copy(Ocorrencias, i*2-1, 2));
    if sigla <> '' then
    begin
      aResult[i] := OcorrenciaStringToResultado(sigla);
    end
    else
    begin
      aResult[i].codigo := '';
      aResult[i].descricao := '';
      aResult[i].resultado := true;
    end
  end;
  result := aResult;
end;

function TArquivoBB.StrToTipoMoeda(var ok: boolean; const s: string): TTipoMoedaAlPagtoE;
begin
  result := StrToEnumerado(ok, s, ['REA','009'], [tmReal, tmOutros]);
end;

function TArquivoBB.TipoMoedaToStr(const t: TTipoMoedaAlPagtoE): string;
begin
  result := EnumeradoToStr(t, ['REA','009'], [tmReal, tmOutros]);
end;

procedure TArquivoBB.validaTipoForm(tipo: TTipoPagALPagtoE; forma: TFormaPagALPagtoE);
begin
  if (forma = fpCreditoContaCorrenteBanco) and not(tipo in [tpDividendos, tpDebentures, tpFornecedores, tpSalarios,
                                                     tpSalariosPublico, tpFundosInvestimentos, tpSinistrosSeguros,
                                                     tpDespesasViajante, tpRepresentatesAutorizados, tpBeneficios,
                                                     tpDiversos]) then
    raise Exception.create('tipo invalido para credito em conta corrente no banco!');
  if (forma = fpCreditoContaCorrenteTitular) and not(tipo in [tpFornecedores,  tpDiversos]) then
    raise Exception.create('tipo invalido para credito em conta corrente mesmo titular!');
  if (forma = fpCreditoContaPoupancaBanco) and not(tipo in [tpDividendos, tpFornecedores, tpSinistrosSeguros,
                                                     tpBeneficios, tpDiversos]) then
    raise Exception.create('tipo invalido para credito em poupanca!');
  if (forma =  fpChequePagamento) and not(tipo in [tpDividendos, tpDebentures, tpFornecedores, tpSalarios,
                                                     tpSalariosPublico, tpFundosInvestimentos, tpSinistrosSeguros,
                                                     tpDespesasViajante, tpRepresentatesAutorizados, tpBeneficios,
                                                     tpDiversos]) then
    raise Exception.create('tipo invalido para cheque de pagamento!');
  if (forma = fpDocC) and not(tipo in [tpDividendos, tpDebentures, tpFornecedores, tpSalarios,
                                                     tpSalariosPublico,  tpSinistrosSeguros, tpDespesasViajante,
                                                     tpRepresentatesAutorizados, tpBeneficios, tpDiversos]) then
    raise Exception.create('tipo invalido para DOC''C''!');
  if (forma = fpDocD) and not(tipo in [tpFornecedores, tpDiversos]) then
    raise Exception.create('tipo invalido para DOC''D''!');
  if (forma = fpOrdemPagamentoDisposicao) and not(tipo in [tpDividendos, tpDebentures, tpFornecedores, tpSalarios,
                                                     tpSalariosPublico, tpFundosInvestimentos, tpSinistrosSeguros,
                                                     tpDespesasViajante, tpRepresentatesAutorizados, tpBeneficios,
                                                     tpDiversos]) then
    raise Exception.create('tipo invalido para OP - Ordem de Pagamento!');
  if (forma in [fpCobrancaBanco,fpCobrancaOutrosBancos,fpNotaFiscal, fpPagamentoConcessionarias]) and
    not(tipo in [tpFornecedores, tpDiversos]) then
    raise Exception.create('tipo invalido para forma de pagamento!');
  if (forma in [fpDarfNormal, fpGPS, fpDarfSimples, fpTributosMunicipais, fpDarj, fpGare, fpIpva, fpDpvat,
                fpFgtsGfip, fpGnreTributosBarras]) and (tipo <> tpTributos) then
    raise Exception.create('para essa forma de pagamento o tipo deve ser tributo!');
  if (forma = fpTedOutroTitular) and not(tipo in [tpDividendos, tpDebentures, tpFornecedores, tpSalarios,
                                                     tpSalariosPublico, tpSinistrosSeguros, tpDespesasViajante,
                                                     tpRepresentatesAutorizados, tpBeneficios, tpDiversos]) then
    raise Exception.create('tipo invalido para TED - Outro Titular!');
  if (forma = fpTedMesmoTitular) and not(tipo in [tpFornecedores, tpDiversos]) then
    raise Exception.create('tipo invalido para TED - Mesmo Titular!');
end;

{ TSegmentoJList }

function TSegmentoJList.GetItem(Index: Integer): TSegmentoJ;
begin
  Result :=  TSegmentoJ(Inherited Items[Index]);
end;

function TSegmentoJList.LocalizaRegistro(Registro: integer): boolean;
var
  intFor: integer;
begin
   Result := false;
   for intFor := 0 to Self.Count - 1 do
   begin
     if Self.Items[intFor].fREGISTRO = Registro then
     begin
       Result := true;
       Break;
     end;
   end;
end;

function TSegmentoJList.New(AOwner: TLoteBB): TSegmentoJ;
begin
  Result := TSegmentoJ.Create(AOwner);
  Add(Result);
end;

procedure TSegmentoJList.SetItem(Index: Integer; const Value: TSegmentoJ);
begin
  Put(Index, Value);
end;

function TSegmentoJList.ValorPagamentos: double;
var
  i : integer;
  soma : double;
begin
  soma := 0;
  for i:= 0 to self.Count -1 do
    if self.Items[i].fTP_MOVIMENTO in [tmInclusaoPagamento, tmCpf, tmCnpjCompleto, tmCnpjRaiz] then
      soma := soma + self.Items[i].VALOR_PAGAMENTO;
  result := soma;
end;

{ TSegmentoJ }

constructor TSegmentoJ.Create(AOwner: TLoteBB);
begin
  self.fAOwner := AOwner;
end;

function TSegmentoJ.getLinhaLayout: String;
begin
  result := '001' +
    formataNumero(fAOwner.fCODIGO, 4) +
    '3' +
    formataNumero(fREGISTRO, 5) +
    'J' +
    formataNumero(TipoMovToStr(fTP_MOVIMENTO),3) +
    formataNumero(fBANCO_BARRAS, 3) +
    formataNumero(fMOEDA_BARRAS, 1) +
    formataNumero(fDV_BARRAS, 1) +
    formataNumero(VENCIMENTO_BARRAS, 4) +
    formataNumero(fVALOR_BARRAS, 10, 2) +
    formataNumero(fCAMPO_LIVRE, 25) +
    formataAlfa(fNOME_FAVORECIDO, 30) +
    formataData(fDATA_VENCIMENTO) +
    formataNumero(fVALOR_TITULO, 15, 2) +
    formataNumero(fDESCONTOS, 15, 2) +
    formataNumero(fACRESCIMOS, 15, 2) +
    formataData(fDATA_PAGAMENTO) +
    formataNumero(fVALOR_PAGAMENTO, 15, 2) +
    DupeString('0',15) +
    formataAlfa(fSEU_NUMERO, 20) +
    formataAlfa(fNOSSO_NUMERO,20) +
    formataNumero(fMOEDA_BARRAS, 2) +
    DupeString(' ',6) +
    DupeString('0',10) +
    quebra_linha
end;

{ TSegmentoJ52 }

constructor TSegmentoJ52.Create(AOwner: TLoteBB);
begin
  self.fAOwner := AOwner;
end;

function TSegmentoJ52.getLinhaLayout: String;
begin
  Result := '001'+
    formataNumero(fAOwner.fCODIGO, 4) +
    '3' +                                                           // 8
    formataNumero(fREGISTRO, 5) +
    'J' +                                                           // 14
    ' ' +                                                           // 15
    formataNumero(TipoMovToStr(fTP_MOVIMENTO),2) +
    '52' +                                                          // 18
    formataNumero(TipoInsToStr(fTP_INSCRICAO_PAGADOR),1)+           // 20
    formataNumero(INSCRICAO_PAGADOR,15)+                            // 21
    formataAlfa(NOME_PAGADOR, 40)+                                  // 36
    formataNumero(TipoInsToStr(fTP_INSCRICAO_BENEFICIARIO),1)+      // 76
    formataNumero(INSCRICAO_BENEFICIARIO,15)+                       // 77
    formataAlfa(NOME_BENEFICIARIO, 40)+                             // 92
    ifThen(Trim(INSCRICAO_AVALISTA) = '', '0',
           formataNumero(TipoInsToStr(fTP_INSCRICAO_AVALISTA),1)) + // 132
    formataNumero(INSCRICAO_AVALISTA,15)+
    formataAlfa(NOME_AVALISTA, 40)+
    DupeString(' ',53)+
    quebra_linha;
end;

{ TSegmentoJ52List }

function TSegmentoJ52List.GetItem(Index: Integer): TSegmentoJ52;
begin
  Result :=  TSegmentoJ52(Inherited Items[Index]);
end;

function TSegmentoJ52List.New(AOwner: TLoteBB): TSegmentoJ52;
begin
  Result := TSegmentoJ52.Create(AOwner);
  Add(Result);
end;

procedure TSegmentoJ52List.SetItem(Index: Integer; const Value: TSegmentoJ52);
begin
  Put(Index, Value);
end;

{ TTributoGPS }

function TTributoGPS.getIdentificacaoTributo: String;
begin
  Result := '01'+
    formataNumero(GPSPagamentoToStr(fCOD_PAGAMENTO),4)+
    formataNumero(fMES_COMPETENCIA,2)+
    formataNumero(fANO_COMPETENCIA,4)+
    formataNumero(fIDENTIFICADOR, 14)+
    formataNumero(fVALOR_TRIBUTO, 14, 2)+
    formataNumero(fVALOR_OUTRA, 14, 2)+
    formataNumero(fATUALIZACAO_MONETARIA, 14, 2)+
    formataNumero(fVALOR_ARRECADADO, 14, 2)+
    formataData(fDATA_ARRECADACAO)+
    DupeString(' ', 8)+
    formataAlfa(fUSO_EMPRESA, 50)+
    formataAlfa(fCONTRIBUINTE, 30);
end;

procedure TTributoGPS.getPagamento(const pagamento: TPagamentoAlPagtoE);
begin
  fCOD_PAGAMENTO := pagamento.COD_PAGAMENTO;
  fMES_COMPETENCIA := MonthOf(IncMonth(pagamento.DATA_VENCIMENTO, -1));
  fANO_COMPETENCIA := YearOf(IncMonth(pagamento.DATA_VENCIMENTO, -1));
  fIDENTIFICADOR := pagamento.IDENTIFICADOR;
  fVALOR_TRIBUTO := pagamento.VALOR_TITULO;
  fVALOR_OUTRA := pagamento.VALOR_OUTRO;
  fATUALIZACAO_MONETARIA := pagamento.ACRESCIMOS;
  fVALOR_ARRECADADO := pagamento.VALOR_PAGTO;
  fDATA_ARRECADACAO := pagamento.DATA_PAGTO;
  fUSO_EMPRESA := pagamento.USO_EMPRESA;
  fCONTRIBUINTE := pagamento.NOME_FAVORECIDO;
end;

function TTributoGPS.getValorAcrescimos: double;
begin
  result := 0;
end;

function TTributoGPS.getValorArrecadado: double;
begin
  result := fVALOR_ARRECADADO;
end;

function TTributoGPS.getValorOutrasEntidades: double;
begin
  result := fVALOR_OUTRA;
end;

function TTributoGPS.getValorPrincipal: double;
begin
  result := fVALOR_TRIBUTO;
end;

procedure TTributoGPS.setPagamento(const pagamento: TPagamentoAlPagtoE);
begin
  pagamento.COD_PAGAMENTO := fCOD_PAGAMENTO;
  pagamento.DATA_VENCIMENTO := IncMonth(EncodeDateTime(fANO_COMPETENCIA, fMES_COMPETENCIA, 20, 0, 0, 0, 0),1);
  pagamento.IDENTIFICADOR := fIDENTIFICADOR;
  pagamento.VALOR_TITULO := fVALOR_TRIBUTO;
  pagamento.VALOR_OUTRO := fVALOR_OUTRA;
  pagamento.ATUALIZACAO_MONETARIA := fATUALIZACAO_MONETARIA;
  pagamento.VALOR_PAGTO := fVALOR_ARRECADADO;
  pagamento.DATA_PAGTO := fDATA_ARRECADACAO;
  pagamento.USO_EMPRESA := fUSO_EMPRESA;
  pagamento.NOME_FAVORECIDO := fCONTRIBUINTE;
end;

procedure TTributoGPS.setTributoStr(identificacao: String);
var
  ok : boolean;
begin
  fCOD_PAGAMENTO := StrToGPSPagamento(ok, copy(identificacao, 3, 4));
  fMES_COMPETENCIA := StrToInt(copy(identificacao, 7, 2));
  fANO_COMPETENCIA := StrToInt(copy(identificacao, 9, 4));
  fIDENTIFICADOR :=  copy(identificacao, 13, 14);
  fVALOR_TRIBUTO := paraDouble(copy(identificacao, 27, 14), 2);
  fVALOR_OUTRA := paraDouble(copy(identificacao, 41, 14), 2);
  fATUALIZACAO_MONETARIA := paraDouble(copy(identificacao, 55, 14), 2);
  fVALOR_ARRECADADO := paraDouble(copy(identificacao, 69, 14), 2);
  fDATA_ARRECADACAO := paraData(copy(identificacao, 83, 8));
  fUSO_EMPRESA := copy(identificacao, 99, 50);
  fCONTRIBUINTE := copy(identificacao, 149, 30);
end;

{ TSegmentoN }

constructor TSegmentoN.Create(AOwner: TLoteBB);
begin
  self.fAOwner := AOwner;
end;

function TSegmentoN.getLinhaLayout: String;
begin
  Result := '001'+
    formataNumero(fAOwner.fCODIGO, 4) +
    '3' +
    formataNumero(fREGISTRO, 5) +
    'N' +
    formataNumero(TipoMovToStr(fTP_MOVIMENTO),3) +
    formataAlfa(fDADOS_TRIBUTO.getIdentificacaoTributo, 178) +
    formataAlfa(fSEU_NUMERO, 20)+
    formataAlfa(fNOSSO_NUMERO, 15) +
    DupeString(' ', 10) +
    quebra_linha;
end;

{ TSegmentoNList }

function TSegmentoNList.GetItem(Index: Integer): TSegmentoN;
begin
  Result :=  TSegmentoN(Inherited Items[Index]);
end;

function TSegmentoNList.New(AOwner: TLoteBB): TSegmentoN;
begin
  Result := TSegmentoN.Create(AOwner);
  Add(Result);
end;

procedure TSegmentoNList.SetItem(Index: Integer; const Value: TSegmentoN);
begin
  Put(Index, Value);
end;

function TSegmentoNList.ValorAcrescimos: double;
var
  i : integer;
  soma : double;
begin
  soma := 0;
  for i:= 0 to self.Count -1 do
    if self.Items[i].fTP_MOVIMENTO in [tmInclusaoPagamento, tmCpf, tmCnpjCompleto, tmCnpjRaiz] then
      soma := soma + self.Items[i].DADOS_TRIBUTO.getValorAcrescimos;
  result := soma;
end;

function TSegmentoNList.ValorArrecadado: double;
var
  i : integer;
  soma : double;
begin
  soma := 0;
  for i:= 0 to self.Count -1 do
    if self.Items[i].fTP_MOVIMENTO in [tmInclusaoPagamento, tmCpf, tmCnpjCompleto, tmCnpjRaiz] then
      soma := soma + self.Items[i].DADOS_TRIBUTO.getValorArrecadado;
  result := soma;
end;

function TSegmentoNList.ValorOutrasEntidades: double;
var
  i : integer;
  soma : double;
begin
  soma := 0;
  for i:= 0 to self.Count -1 do
    if self.Items[i].fTP_MOVIMENTO in [tmInclusaoPagamento, tmCpf, tmCnpjCompleto, tmCnpjRaiz] then
      soma := soma + self.Items[i].DADOS_TRIBUTO.getValorOutrasEntidades;
  result := soma;
end;

function TSegmentoNList.ValorPrincipal: double;
var
  i : integer;
  soma : double;
begin
  soma := 0;
  for i:= 0 to self.Count -1 do
    if self.Items[i].fTP_MOVIMENTO in [tmInclusaoPagamento, tmCpf, tmCnpjCompleto, tmCnpjRaiz] then
      soma := soma + self.Items[i].DADOS_TRIBUTO.getValorPrincipal;
  result := soma;
end;

{ TSegmentoO }

constructor TSegmentoO.Create(AOwner: TLoteBB);
begin
  fAOwner := AOwner;
end;

function TSegmentoO.getLinhaLayout: String;
begin
  Result := '001'+
    formataNumero(fAOwner.fCODIGO, 4) +
    '3' +
    formataNumero(fREGISTRO, 5) +
    'O' +
    formataNumero(TipoMovToStr(fTP_MOVIMENTO),3) +
    formataAlfa(fCOD_BARRA, 48) +
    formataAlfa(fNOME, 30) +
    formataData(fDATA_VENCIMENTO) +
    'REA' +
    DupeString('0',15) +
    formataNumero(fVALOR_PAGAR, 15, 2) +
    formataData(fDATA_PAGAMENTO) +
    DupeString('0',15) +
    DupeString(' ', 3) +
    DupeString(' ', 9) +
    DupeString(' ', 3) +
    formataAlfa(fSEU_NUMERO, 20)+
    DupeString(' ', 21) +
    formataAlfa(fNOSSO_NUMERO, 15) +
    DupeString(' ', 10) +
    quebra_linha;
end;

{ TSegmentoOList }

function TSegmentoOList.GetItem(Index: Integer): TSegmentoO;
begin
  Result :=  TSegmentoO(Inherited Items[Index]);
end;

function TSegmentoOList.New(AOwner: TLoteBB): TSegmentoO;
begin
  Result := TSegmentoO.Create(AOwner);
  Add(Result);
end;

procedure TSegmentoOList.SetItem(Index: Integer; const Value: TSegmentoO);
begin
  Put(Index, Value);
end;

function TSegmentoOList.ValorPagamentos: double;
var
  i : integer;
  soma : double;
begin
  soma := 0;
  for i:= 0 to self.Count - 1 do
    if self.Items[i].fTP_MOVIMENTO in [tmInclusaoPagamento, tmCpf, tmCnpjCompleto, tmCnpjRaiz] then
      soma := soma + self.Items[i].VALOR_PAGAR;
  result := soma;
end;

{ TTributoFGTS }

function TTributoFGTS.getIdentificacaoTributo: String;
begin
  Result := '11'+
    formataNumero(fRECEITA,4)+
    formataNumero(TipoInsToStr(fTP_INSCRICAO),1)+
    formataNumero(fINSCRICAO,14)+
    formataAlfa(fCOD_BARRAS, 48)+
    formataNumero(fIDENTIFICADOR, 16)+
    formataNumero(fLACRE, 9)+
    formataNumero(fLACRE_DIGITO, 2)+
    formataAlfa(fNOME_CONTRIBUINTE, 30)+
    formataData(fDATA_PAGAMENTO)+
    formataNumero(fVALOR_PAGAMENTO, 14, 2) +
    DupeString(' ', 30);
end;

procedure TTributoFGTS.getPagamento(const pagamento: TPagamentoAlPagtoE);
begin
  fRECEITA := pagamento.RECEITA;
  fTP_INSCRICAO := pagamento.TP_INSCRICAO;
  fINSCRICAO := pagamento.INSCRICAO;
  fCOD_BARRAS := pagamento.CAMPO_LIVRE;
  fIDENTIFICADOR := pagamento.IDENTIFICADOR;
  fLACRE := pagamento.LACRE;
  fLACRE_DIGITO := pagamento.LACRE_DIGITO;
  fNOME_CONTRIBUINTE := pagamento.NOME_EMPRESA;
  fDATA_PAGAMENTO := pagamento.DATA_PAGTO;
  fVALOR_PAGAMENTO := pagamento.VALOR_PAGTO;
end;

function TTributoFGTS.getValorAcrescimos: double;
begin
  result := 0;
end;

function TTributoFGTS.getValorArrecadado: double;
begin
  result := fVALOR_PAGAMENTO;
end;

function TTributoFGTS.getValorOutrasEntidades: double;
begin
  result := 0;
end;

function TTributoFGTS.getValorPrincipal: double;
begin
  result := 0;
end;

procedure TTributoFGTS.setPagamento(const pagamento: TPagamentoAlPagtoE);
begin
  pagamento.RECEITA := fRECEITA;
  pagamento.TP_INSCRICAO := fTP_INSCRICAO;
  pagamento.INSCRICAO := fINSCRICAO;
  pagamento.CAMPO_LIVRE := fCOD_BARRAS;
  pagamento.IDENTIFICADOR := fIDENTIFICADOR;
  pagamento.LACRE := fLACRE ;
  pagamento.LACRE_DIGITO := fLACRE_DIGITO;
  pagamento.NOME_EMPRESA := fNOME_CONTRIBUINTE;
  pagamento.DATA_PAGTO := fDATA_PAGAMENTO;
  pagamento.VALOR_PAGTO := fVALOR_PAGAMENTO;
end;

procedure TTributoFGTS.setTributoStr(identificacao: String);
var
  ok : boolean;
begin
  fRECEITA := StrToInt(copy(identificacao, 3, 4));
  fTP_INSCRICAO := StrToTipoIns(ok, copy(identificacao, 7, 1));
  fINSCRICAO := copy(identificacao, 8, 14);
  fCOD_BARRAS := copy(identificacao, 22, 48);
  fIDENTIFICADOR := copy(identificacao, 70, 16);
  fLACRE := copy(identificacao, 86, 9);
  fLACRE_DIGITO := copy(identificacao, 95, 2);
  fNOME_CONTRIBUINTE := copy(identificacao, 97, 30);
  fDATA_PAGAMENTO := paraData(copy(identificacao, 127, 8));
  fVALOR_PAGAMENTO := paraDouble(copy(identificacao, 135, 14),2);
end;

end.
