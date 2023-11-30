unit ALConversao;

interface

type
  TLayoutALPagtoE = (lyItau, lyBradesco, lySafra, lySicredi, lySantander, lyBancoBrasil);
  TTipoOpALPagtoE = (toCredito, toFinanciamento);
  TTipoPagALPagtoE = (tpBloquetoEletronico, tpDividendos, tpDebentures, tpFornecedores, tpTributos, tpSalarios,
    tpSalariosPublico, tpFundosInvestimentos, tpSinistrosSeguros, tpDespesasViajante,
    tpRepresentatesAutorizados, tpBeneficios, tpDiversos);
  TFormaPagALPagtoE = (fpCreditoContaCorrenteBanco, fpChequePagamento, fpDocC,
    fpCreditoContaPoupancaBanco, fpCreditoContaCorrenteTitular, fpDocD, fpOrdemPagamentoDisposicao,
    fpOrdemPagamentoAcerto, fpPagamentoConcessionarias, fpDarfNormal, fpGPS, fpDarfSimples,
    fpTributosMunicipais, fpDarj, fpGare, fpIpva, fpDpvat, fpCobrancaBanco, fpCobrancaOutrosBancos,
    fpNotaFiscal, fpFgtsGfip, fpTedOutroTitular, fpTedMesmoTitular, fpCartaoSalario, fpGnreTributosBarras);
  TTipoInsALPagtoE = (tiCpf, tiCNPJ, tiNaoInformado);

  TTipoMovALPagtoE = (tmInclusaoPagamento, tmCpf, tmCnpjCompleto, tmCnpjRaiz, tmInclusaoDemonstrativo,
    tmInclusaoRegistroBloqueado, tmAlteracaoPagtoLiberado, tmAlteracaoPagtoBloqueado, tmAlteracaoDemonstrativo,
    tmAlteracaoValor, tmAlteracaoData, tmExclusaoDemonstrativo, tmExclusaoPagamento);

  TCamaraCentralizadoraTipoPagtoE = (cctDOC, cctTED, cctTED_ISPB);

  THistoricoVarAlPagtoE = (hvSalario, hvFerias, hv13Salario, hvBonus, hvComissoes, hvAdiantamento,
    hvRescisao, hvValeTransporte, hvAuxilioAlim, hvPensaoAlim, hvBolsaEstagio, hvBolsaAuxilio,
    hvContaCorrente, hvRemuneracao, hvLivre);
  TFinalidadeDocAlPagtoE = (fdCreditoConta, fdPagAluguel, fdPagDuplicata, fdPagDividendos,
    fdPagMensalidadeEscolar, fdPagSalario, fdPagFornecedor, fdOpCambioFundos, fdRepasseArrecadacaoPagTrib,
    fdTransfInternacional, fdDocPoupanca, fdDocDepositoJudicial, fdPensaoAlim, fdOutros);
  TStatusFuncionarioAlPagtoE = (sfEfetivoPrivado, sfEfetivoPublicoEstatutario, sfPublicoClt,
    sfEfetivoMilitar, sfAutonomoPrivado, sfAutonomoPublico, sfTempPrivado, sfTempPublicoEstaturario,
    sfTempPublicoClt, sfTempPublicoDesvinculado, sfTempMilitar, sfEstagiarioPrivado,
    sfEstagiarioPublico, sfAposentadoPrivado, sfAposentadoMilitar, sfAposentadoPublico,
    sfPensionistaPrivado, sfPensionistaMilitar, sfPensionistaPublico, sfComissionadoPrivado,
    sfComissionadoPublicoEstatutario, sfComissionadoPublicoCLT, sfComissionadoPublicoDesvinculado,
    sfComissionadoPublicoMilitar, sfComissionadoPublicoInativo);
  TFinalidadeTedAlPagtoE = (ftImpostosTributosTaxas, ftConcessionarias, ftDividendos, ftSalarios, ftFornecedores,
    ftHonorarios, ftAlugueisCondominio, ftDuplicatasTitulos, ftHonorarios2, ftCreditoConta,
    ftPagamentoCorretora, ftCreditoContaInvestimento, ftDepositoJudicial, ftPensaoAlimenticia,
    ftTransfInternacional, ftAjusteMercadoFuturo, ftCompraVendaAcoes, ftContratoRefAcoes,
    ftRestituicaoImpostoRenda, ftRestituicaoSeguro, ftPagamentoIndenizacaoSeguro, ftPagamentoPremioCoseguro,
    ftRestituicaoPremioCoseguro, ftPagamentoIndenizacaoCoseguro, ftPagamentoPremioResseguro,
    ftRestituicaoPremioResseguro, ftPagamentoIndenizacaoReseguro, ftRestituicaoIndenizacaoResseguro,
    ftPagamentoDespesasSinistros, ftPagamentoInspecoes, ftPagamentoResgateTituloCap,
    ftPagamentoSorteioTituloCap, ftPagamentoDevolucaoTituloCap, ftRestituicaoPrevi,
    ftPagamentoPreviPeculio, ftPagamentoPreviPensao, ftPagamentoPreviAposentadoria,
    ftPagamentoResgatePrevi, ftPagamentoComissaoCorretagem, ftPagmentoTransferenciaSeguroPrevi);
  TAvisoAgendamentoAlPagtoE = (avSemAviso, avAvisoRemetente, avNoAgendamento, avPosAgendamento,
                               avAvisoFavorecido, avAvisoFavorecido2v, avNoPosAgendamento);
  TTipoIdentificacaoAlPagtoE = (tiCnpjBeneficiario, tiNumeroNotaFiscal, tiCnpjTerceirosFilial);
  TFinalidadeLoteAlPagtoE = (flNaoContratada, flNenhum, flFolhaMensal, flFolhaQuinzenal, flFolhaComplementar,
    flSalario13, flParticipacaoResultados, flInformeRendimentos, flFerias, flRescisao, flRescisaocomplementar,
    flOutros, flDebitoContaInvestimento);
  TTipoArquivoAlPagtoE = (taRemessa, taRetorno);
  TTipoMoedaAlPagtoE = (tmReal, tmOutros);
  TGPSPagamento = (gpIndividualMensal, gpIndividualTrimestral, gpFacultativoMensal, gpFacultativoTrimestral,
    gpEspecialMensal, gpEspecialTrimestral, gpOptanteSimples, gpEmpresaCnpj, gpEmpresaCei, gpNota, gpReclamatoria);
  TTipoMovimentoRemessa = (tmrEntradaTitulos, tmrPedidoBaixa, tmrConcessaoAbataimento, tmrCancelamentoAbatimento,
                         tmrAlteracaoVencimento, tmrConcessaoDesconto, tmrCancelamentoDesconto, tmrProtestar,
                         tmrSustarProtestoBaixarTitulo,  tmrSustarProtestoManterCarteira, tmrAlteracaoJurosMora,
                         tmrDispensarCobrancaJurosMora, tmrAlteracaoDesconto, tmrNaoConcederDesconto,
                         tmrAleracaoOutrosDados, tmrNegativacaoProtesto, tmrExcluirNegativacaoManterCarteira,
                         tmrExcluirNegativacaoBaixa);
  TResultadoALPagto = record
    codigo : String;
    descricao : String;
    resultado : boolean;
    tagERP: String;
  end;

Const

TIdentificacaoLiquidacaoString : array[0..2] of array [0..1] of String =
  (('1', 'Identificação por CNPJ do beneficiário'),
   ('2', 'Identificação por número de nota fiscal'),
   ('3', 'Identificação por CNPJ de Terceiros/Filial') );

TFinalidadeTEDString : array[0..39] of array [0..1] of String =
 (('00001', 'Pagamento de Impostos, Tributos e Taxas'),
  ('00002', 'Pagamento a Concessionárias de Serviço Público'),
  ('00003', 'Pagamento de Dividendos'),
  ('00004', 'Pagamento de Salários'),
  ('00005', 'Pagamento de Fornecedores'),
  ('00006', 'Pagamento de Honorários'),
  ('00007', 'Pagamento de Aluguéis e Taxas e Condomínio'),
  ('00008', 'Pagamento de Duplicatas e Títulos'),
  ('00009', 'Pagamento de Honorários'),
  ('00010', 'Crédito em Conta'),
  ('00011', 'Pagamento a Corretoras'),
  ('00016', 'Crédito em Conta Investimento'),
  ('00100', 'Depósito Judicial'),
  ('00101', 'Pensão Alimentícia'),
  ('00200', 'Transferência Internacional de Reais'),
  ('00201', 'Ajuste Posição Mercado Futuro'),
  ('00204', 'Compra/Venda de Ações – Bolsas de Valores e Mercado de Balcão'),
  ('00205', 'Contrato referenciado em Ações/Índices de Ações – BV/BMF'),
  ('00300', 'Restituição de Imposto de Renda'),
  ('00500', 'Restituição de Prêmio de Seguros'),
  ('00501', 'Pagamento de indenização de Sinistro de Seguro'),
  ('00502', 'Pagamento de Prêmio de Co-seguro'),
  ('00503', 'Restituição de prêmio de Co-seguro'),
  ('00504', 'Pagamento de indenização de Co-seguro'),
  ('00505', 'Pagamento de prêmio de Resseguro'),
  ('00506', 'Restituição de prêmio de Resseguro'),
  ('00507', 'Pagamento de Indenização de Sinistro de Resseguro'),
  ('00508', 'Restituição de Indenização de Sinistro de Resseguro'),
  ('00509', 'Pagamento de Despesas com Sinistros'),
  ('00510', 'Pagamento de Inspeções/Vistorias Prévias'),
  ('00511', 'Pagamento de Resgate de Título de Capitalização'),
  ('00512', 'Pagamento de Sorteio de Título de Capitalização'),
  ('00513', 'Pagamento de Devolução de Mensalidade de Título de Capitalização'),
  ('00514', 'Restituição de Contribuição de Plano Previdenciário'),
  ('00515', 'Pagamento de Benefício Previdenciário de Pecúlio'),
  ('00516', 'Pagamento de Benefício Previdenciário de Pensão'),
  ('00517', 'Pagamento de Benefício Previdenciário de Aposentadoria'),
  ('00518', 'Pagamento de Resgate Previdenciário'),
  ('00519', 'Pagamento de Comissão de Corretagem'),
  ('00520', 'Pagamento de Transferências/Portabilidade de Reserva de Seguro/Previdência') );

TFinalidadeDOCString : array[0..13] of array [0..1] of String =
  (('01', 'Crédito em Conta'),
   ('02', 'Pagamento de Aluguel / Condomínio'),
   ('03', 'Pagamento de Duplicata / Títulos'),
   ('04', 'Pagamento de Dividendos'),
   ('05', 'Pagamento de Mensalidade Escolar'),
   ('06', 'Pagamento de Salários'),
   ('07', 'Pagamento de Fornecedores / Honorários'),
   ('08', 'Operações de Câmbio / Fundos'),
   ('09', 'Repasse de Arrecadação / Pagamento de Tributos'),
   ('10', 'Transferência Internacional de Reais'),
   ('11', 'DOC para Poupança'),
   ('12', 'DOC para Depósito Judicial'),
   ('13', 'Pensão Alimentícia'),
   ('99', 'Outros') );

TStatusFuncionarioString : array [0..24] of array [0..1] of String =
  (('21', 'Efetivo Privado'),
   ('22', 'Efetivo Público Estatutário'),
   ('23', 'Efetivo Público CLT'),
   ('25', 'Efetivo Militar'),
   ('31', 'Autônomo Privado'),
   ('34', 'Autônomo Público Desvinculado'),
   ('41', 'Temporário Privado'),
   ('42', 'Temporário Público Estatutário'),
   ('43', 'Temporário Público CLT'),
   ('44', 'Temporário e Público Desvinculado'),
   ('45', 'Temporário Militar'),
   ('51', 'Estagiário Privado'),
   ('54', 'Estagiário Público Desvinculado'),
   ('61', 'Aposentado Privado'),
   ('65', 'Aposentado Militar'),
   ('66', 'Aposentado Público Inativo'),
   ('71', 'Pensionista Privado'),
   ('75', 'Pensionista Militar'),
   ('76', 'Pensionista Público Inativo'),
   ('81', 'Comissionado e Privado'),
   ('82', 'Comissionado e Público Estatutário'),
   ('83', 'Comissionado e Público CLT'),
   ('84', 'Comissionado e Público Desvinculado'),
   ('85', 'Comissionado e Público Militar'),
   ('86', 'Comissionado e Público Inativo') );

function StrToEnumerado(var ok: boolean; const s: string; const AString: array of string;
  const AEnumerados: array of variant): variant;
function EnumeradoToStr(const t: variant; const AString:
  array of string; const AEnumerados: array of variant): variant;

function TipoOpToStr(const t: TTipoOpALPagtoE): string;
function StrToTipoOP(var ok: boolean; const s: string): TTipoOpALPagtoE;

function TipoPagToStr(const t: TTipoPagALPagtoE): string;
function StrToTipoPag(var ok: boolean; const s: string): TTipoPagALPagtoE;

function FormaPagToStr(const t: TFormaPagALPagtoE): string;
function StrToFormaPag(var ok: boolean; const s: string): TFormaPagALPagtoE;

function TipoInsToStr(const t: TTipoInsALPagtoE): string;
function StrToTipoIns(var ok: boolean; const s: string): TTipoInsALPagtoE;

function TipoMovToStr(const t: TTipoMovALPagtoE): string;
function StrToTipoMov(var ok: boolean; const s: string): TTipoMovALPagtoE;

function HistoricoVarToStr(const t: THistoricoVarAlPagtoE): string;
function StrToHistoricoVar(var ok: boolean; const s: string): THistoricoVarAlPagtoE;

function FinalidadeDocToStr(const t: TFinalidadeDocAlPagtoE): string;
function StrToFinalidadeDoc(var ok: boolean; const s: string): TFinalidadeDocAlPagtoE;

function StatusFuncionarioToStr(const t: TStatusFuncionarioAlPagtoE): string;
function StrToStatusFuncionario(var ok: boolean; const s: string): TStatusFuncionarioAlPagtoE;

function FinalidadeTedToStr(const t: TFinalidadeTedAlPagtoE): string;
function StrToFinalidadeTed(var ok: boolean; const s: string): TFinalidadeTedAlPagtoE;

function AvisoAgendamentoToStr(const t: TAvisoAgendamentoAlPagtoE): string;
function StrToAvisoAgendamento(var ok: boolean; const s: string): TAvisoAgendamentoAlPagtoE;

function TipoIdentificacaoToStr(const t: TTipoIdentificacaoAlPagtoE): string;
function StrToTipoIdentificacao(var ok: boolean; const s: string): TTipoIdentificacaoAlPagtoE;

function FinalidadeLoteToStr(const t: TFinalidadeLoteAlPagtoE): string;
function StrToFinalidadeLote(var ok: boolean; const s: string): TFinalidadeLoteAlPagtoE;

function CamaraCentralizadoraTipoToStr(const pTipo: TCamaraCentralizadoraTipoPagtoE): String;
function StrToCamaraCentralizadoraTipo(var pOK: Boolean; const pStr: String): TCamaraCentralizadoraTipoPagtoE;

function TipoArquivoToStr(const t: TTipoArquivoAlPagtoE): string;
function StrToTipoArquivo(var ok: boolean; const s: string): TTipoArquivoAlPagtoE;

//function TipoMoedaToStr(const t: TTipoMoedaAlPagtoE): string;
//function StrToTipoMoeda(var ok: boolean; const s: string): TTipoMoedaAlPagtoE;

function LayoutToStr(const t: TLayoutALPagtoE): string;
function StrToLayout(var ok: boolean; const s: string): TLayoutALPagtoE;

function GPSPagamentoToStr(const t: TGPSPagamento): string;
function StrToGPSPagamento(var ok: boolean; const s: string): TGPSPagamento;

function getAgencia(banco: integer; AgenciaContaStr: String) : String;
function getConta(banco: integer; AgenciaContaStr: String) : String;

function getMesSicred(const pDataRemessa: TDateTime): String;

function TipoMovimentoRemessaToStr(const pValue: TTipoMovimentoRemessa): String;
function StrToTipoMovimentoRemessa(var ok: boolean; const s: string): TTipoMovimentoRemessa;

implementation


uses StrUtils, sysUtils, DateUtils;


function EnumeradoToStr(const t: variant; const AString:
  array of string; const AEnumerados: array of variant): variant;
var
  i: integer;
begin
  result := '';
  for i := Low(AEnumerados) to High(AEnumerados) do
    if t = AEnumerados[i] then
      result := AString[i];
end;


function StrToEnumerado(var ok: boolean; const s: string; const AString:
  array of string; const AEnumerados: array of variant): variant;
var
  i: integer;
begin
  result := -1;
  for i := Low(AString) to High(AString) do
    if AnsiSameText(s, AString[i]) then
      result := AEnumerados[i];
  ok := result <> -1;
  if not ok then
    result := AEnumerados[0];
end;


function TipoOpToStr(const t: TTipoOpALPagtoE): string;
begin
  result := EnumeradoToStr(t, ['C','F'], [toCredito, toFinanciamento]);
end;


function StrToTipoOp(var ok: boolean; const s: string): TTipoOpALPagtoE;
begin
  result := StrToEnumerado(ok, s,  ['C','F'], [toCredito, toFinanciamento]);
end;


function TipoPagToStr(const t: TTipoPagALPagtoE): string;
begin
  result := EnumeradoToStr(t,
    ['03', '10','15','20','22', '30', '31', '40', '50', '60', '80', '90', '98'],
    [tpBloquetoEletronico, tpDividendos, tpDebentures, tpFornecedores, tpTributos, tpSalarios,
    tpSalariosPublico, tpFundosInvestimentos, tpSinistrosSeguros, tpDespesasViajante,
    tpRepresentatesAutorizados, tpBeneficios, tpDiversos]);
end;

function StrToTipoPag(var ok: boolean; const s: string): TTipoPagALPagtoE;
begin
  result := StrToEnumerado(ok, s,
    ['03', '10','15','20','22', '30', '31', '40', '50', '60', '80', '90', '98'],
    [tpBloquetoEletronico, tpDividendos, tpDebentures, tpFornecedores, tpTributos, tpSalarios,
    tpSalariosPublico, tpFundosInvestimentos, tpSinistrosSeguros, tpDespesasViajante,
    tpRepresentatesAutorizados, tpBeneficios, tpDiversos]);
end;

function FormaPagToStr(const t: TFormaPagALPagtoE): string;
begin
  result := EnumeradoToStr(t,
    ['01','02','03','05','06','07','10','11','13','16','17','18','19','21',
    '22','25','27','30','31','32','35','41','43','60','91'],
    [fpCreditoContaCorrenteBanco, fpChequePagamento, fpDocC, fpCreditoContaPoupancaBanco,
    fpCreditoContaCorrenteTitular, fpDocD, fpOrdemPagamentoDisposicao, fpOrdemPagamentoAcerto,
    fpPagamentoConcessionarias, fpDarfNormal, fpGPS, fpDarfSimples, fpTributosMunicipais,
    fpDarj, fpGare, fpIpva, fpDpvat, fpCobrancaBanco, fpCobrancaOutrosBancos, fpNotaFiscal,
    fpFgtsGfip, fpTedOutroTitular, fpTedMesmoTitular, fpCartaoSalario, fpGnreTributosBarras]);
end;

function StrToFormaPag(var ok: boolean; const s: string): TFormaPagALPagtoE;
begin
  result := StrToEnumerado(ok, s,
    ['01','02','03','05','06','07','10','11','13','16','17','18','19','21',
    '22','25','27','30','31','32','35','41','43','60','91'],
    [fpCreditoContaCorrenteBanco, fpChequePagamento, fpDocC, fpCreditoContaPoupancaBanco,
    fpCreditoContaCorrenteTitular, fpDocD, fpOrdemPagamentoDisposicao, fpOrdemPagamentoAcerto,
    fpPagamentoConcessionarias, fpDarfNormal, fpGPS, fpDarfSimples, fpTributosMunicipais,
    fpDarj, fpGare, fpIpva, fpDpvat, fpCobrancaBanco, fpCobrancaOutrosBancos, fpNotaFiscal,
    fpFgtsGfip, fpTedOutroTitular, fpTedMesmoTitular, fpCartaoSalario, fpGnreTributosBarras]);
end;

function TipoInsToStr(const t: TTipoInsALPagtoE): string;
begin
  result := EnumeradoToStr(t, ['0', '1','2'], [tiNaoInformado, tiCpf, tiCNPJ]);
end;

function StrToTipoIns(var ok: boolean; const s: string): TTipoInsALPagtoE;
begin
  result := StrToEnumerado(ok, s, ['0', '1','2'], [tiNaoInformado, tiCpf, tiCNPJ]);
end;

function TipoMovToStr(const t: TTipoMovALPagtoE): string;
begin
  result := EnumeradoToStr(t,
    ['000','001','002','003','004','009','510','511','512','517','519','998','999'],
    [tmInclusaoPagamento, tmCpf, tmCnpjCompleto, tmCnpjRaiz, tmInclusaoDemonstrativo,
    tmInclusaoRegistroBloqueado, tmAlteracaoPagtoLiberado, tmAlteracaoPagtoBloqueado,
    tmAlteracaoDemonstrativo, tmAlteracaoValor, tmAlteracaoData, tmExclusaoDemonstrativo,
    tmExclusaoPagamento]);
end;

function StrToTipoMov(var ok: boolean; const s: string): TTipoMovALPagtoE;
begin
  result := StrToEnumerado(ok, s,
    ['000','001','002','003','004','009','510','511','512','517','519','998','999'],
    [tmInclusaoPagamento, tmCpf, tmCnpjCompleto, tmCnpjRaiz, tmInclusaoDemonstrativo,
    tmInclusaoRegistroBloqueado, tmAlteracaoPagtoLiberado, tmAlteracaoPagtoBloqueado,
    tmAlteracaoDemonstrativo, tmAlteracaoValor, tmAlteracaoData, tmExclusaoDemonstrativo,
    tmExclusaoPagamento]);
end;

function HistoricoVarToStr(const t: THistoricoVarAlPagtoE): string;
begin
  result := EnumeradoToStr(t,
    ['HP01','HP02','HP03','HP04','HP05','HP06','HP07','HP08','HP09','HP10',
    'HP11','HP12','HP13','HP14','9999'],
    [hvSalario, hvFerias, hv13Salario, hv13Salario, hvBonus, hvComissoes,
    hvAdiantamento, hvRescisao, hvValeTransporte, hvAuxilioAlim, hvPensaoAlim,
    hvBolsaEstagio, hvBolsaAuxilio, hvContaCorrente, hvRemuneracao, hvLivre])
end;

function StrToHistoricoVar(var ok: boolean; const s: string): THistoricoVarAlPagtoE;
begin
  result := StrToEnumerado(ok, s,
    ['HP01','HP02','HP03','HP04','HP05','HP06','HP07','HP08','HP09','HP10',
    'HP11','HP12','HP13','HP14','9999'],
    [hvSalario, hvFerias, hv13Salario, hv13Salario, hvBonus, hvComissoes,
    hvAdiantamento, hvRescisao, hvValeTransporte, hvAuxilioAlim, hvPensaoAlim,
    hvBolsaEstagio, hvBolsaAuxilio, hvContaCorrente, hvRemuneracao, hvLivre])
end;

function FinalidadeDocToStr(const t: TFinalidadeDocAlPagtoE): string;
begin
  result := EnumeradoToStr(t,
    ['01','02','03','04','05','06','07','08','09','10','11','12','13','99'],
    [fdCreditoConta, fdPagAluguel, fdPagDuplicata, fdPagDividendos,
    fdPagMensalidadeEscolar, fdPagSalario, fdPagFornecedor, fdOpCambioFundos,
    fdRepasseArrecadacaoPagTrib, fdTransfInternacional, fdDocPoupanca,
    fdDocDepositoJudicial, fdPensaoAlim, fdOutros])
end;

function StrToFinalidadeDoc(var ok: boolean; const s: string): TFinalidadeDocAlPagtoE;
begin
  result := StrToEnumerado(ok, s,
    ['01','02','03','04','05','06','07','08','09','10','11','12','13','99'],
    [fdCreditoConta, fdPagAluguel, fdPagDuplicata, fdPagDividendos,
    fdPagMensalidadeEscolar, fdPagSalario, fdPagFornecedor, fdOpCambioFundos,
    fdRepasseArrecadacaoPagTrib, fdTransfInternacional, fdDocPoupanca,
    fdDocDepositoJudicial, fdPensaoAlim, fdOutros])
end;

function StatusFuncionarioToStr(const t: TStatusFuncionarioAlPagtoE): string;
begin
  result := EnumeradoToStr(t,
    ['21','22','23','25','31','34','41','42','43','44','45','51','54','61','65',
    '66','71','75','76','81','82','83','84','85','86'],
    [sfEfetivoPrivado, sfEfetivoPublicoEstatutario, sfPublicoClt,
    sfEfetivoMilitar, sfAutonomoPrivado, sfAutonomoPublico, sfTempPrivado, sfTempPublicoEstaturario,
    sfTempPublicoClt, sfTempPublicoDesvinculado, sfTempMilitar, sfEstagiarioPrivado,
    sfEstagiarioPublico, sfAposentadoPrivado, sfAposentadoMilitar, sfAposentadoPublico,
    sfPensionistaPrivado, sfPensionistaMilitar, sfPensionistaPublico, sfComissionadoPrivado,
    sfComissionadoPublicoEstatutario, sfComissionadoPublicoCLT, sfComissionadoPublicoDesvinculado,
    sfComissionadoPublicoMilitar, sfComissionadoPublicoInativo]);
end;

function StrToStatusFuncionario(var ok: boolean; const s: string): TStatusFuncionarioAlPagtoE;
begin
  result := StrToEnumerado(ok, s,
    ['21','22','23','25','31','34','41','42','43','44','45','51','54','61','65',
    '66','71','75','76','81','82','83','84','85','86'],
    [sfEfetivoPrivado, sfEfetivoPublicoEstatutario, sfPublicoClt,
    sfEfetivoMilitar, sfAutonomoPrivado, sfAutonomoPublico, sfTempPrivado, sfTempPublicoEstaturario,
    sfTempPublicoClt, sfTempPublicoDesvinculado, sfTempMilitar, sfEstagiarioPrivado,
    sfEstagiarioPublico, sfAposentadoPrivado, sfAposentadoMilitar, sfAposentadoPublico,
    sfPensionistaPrivado, sfPensionistaMilitar, sfPensionistaPublico, sfComissionadoPrivado,
    sfComissionadoPublicoEstatutario, sfComissionadoPublicoCLT, sfComissionadoPublicoDesvinculado,
    sfComissionadoPublicoMilitar, sfComissionadoPublicoInativo]);
end;

function FinalidadeTedToStr(const t: TFinalidadeTedAlPagtoE): string;
begin
  result := EnumeradoToStr(t,
    ['00001','00002','00003','00004','00005','00006','00007','00008','00009',
    '00010','00011','00016','00100','00101','00200','00201','00204','00205',
    '00300','00500','00501','00502','00503','00504','00505','00506','00507',
    '00508','00509','00510','00511','00512','00513','00514','00515','00516',
    '00517','00518','00519','00520'],
    [ftImpostosTributosTaxas, ftConcessionarias, ftDividendos, ftSalarios, ftFornecedores,
    ftHonorarios, ftAlugueisCondominio, ftDuplicatasTitulos, ftHonorarios2, ftCreditoConta,
    ftPagamentoCorretora, ftCreditoContaInvestimento, ftDepositoJudicial, ftPensaoAlimenticia,
    ftTransfInternacional, ftAjusteMercadoFuturo, ftCompraVendaAcoes, ftContratoRefAcoes,
    ftRestituicaoImpostoRenda, ftRestituicaoSeguro, ftPagamentoIndenizacaoSeguro, ftPagamentoPremioCoseguro,
    ftRestituicaoPremioCoseguro, ftPagamentoIndenizacaoCoseguro, ftPagamentoPremioResseguro,
    ftRestituicaoPremioResseguro, ftPagamentoIndenizacaoReseguro, ftRestituicaoIndenizacaoResseguro,
    ftPagamentoDespesasSinistros, ftPagamentoInspecoes, ftPagamentoResgateTituloCap,
    ftPagamentoSorteioTituloCap, ftPagamentoDevolucaoTituloCap, ftRestituicaoPrevi,
    ftPagamentoPreviPeculio, ftPagamentoPreviPensao, ftPagamentoPreviAposentadoria,
    ftPagamentoResgatePrevi, ftPagamentoComissaoCorretagem, ftPagmentoTransferenciaSeguroPrevi])
end;

function StrToFinalidadeTed(var ok: boolean; const s: string): TFinalidadeTedAlPagtoE;
begin
  result := StrToEnumerado(ok, s,
    ['00001','00002','00003','00004','00005','00006','00007','00008','00009',
    '00010','00011','00016','00100','00101','00200','00201','00204','00205',
    '00300','00500','00501','00502','00503','00504','00505','00506','00507',
    '00508','00509','00510','00511','00512','00513','00514','00515','00516',
    '00517','00518','00519','00520'],
    [ftImpostosTributosTaxas, ftConcessionarias, ftDividendos, ftSalarios, ftFornecedores,
    ftHonorarios, ftAlugueisCondominio, ftDuplicatasTitulos, ftHonorarios2, ftCreditoConta,
    ftPagamentoCorretora, ftCreditoContaInvestimento, ftDepositoJudicial, ftPensaoAlimenticia,
    ftTransfInternacional, ftAjusteMercadoFuturo, ftCompraVendaAcoes, ftContratoRefAcoes,
    ftRestituicaoImpostoRenda, ftRestituicaoSeguro, ftPagamentoIndenizacaoSeguro, ftPagamentoPremioCoseguro,
    ftRestituicaoPremioCoseguro, ftPagamentoIndenizacaoCoseguro, ftPagamentoPremioResseguro,
    ftRestituicaoPremioResseguro, ftPagamentoIndenizacaoReseguro, ftRestituicaoIndenizacaoResseguro,
    ftPagamentoDespesasSinistros, ftPagamentoInspecoes, ftPagamentoResgateTituloCap,
    ftPagamentoSorteioTituloCap, ftPagamentoDevolucaoTituloCap, ftRestituicaoPrevi,
    ftPagamentoPreviPeculio, ftPagamentoPreviPensao, ftPagamentoPreviAposentadoria,
    ftPagamentoResgatePrevi, ftPagamentoComissaoCorretagem, ftPagmentoTransferenciaSeguroPrevi])
end;

function AvisoAgendamentoToStr(const t: TAvisoAgendamentoAlPagtoE): string;
begin
  result := EnumeradoToStr(t,
    ['0','2','3','5','6','7','9'],
    [avSemAviso, avAvisoRemetente, avNoAgendamento, avPosAgendamento, avAvisoFavorecido, avAvisoFavorecido2v, avNoPosAgendamento])
end;

function StrToAvisoAgendamento(var ok: boolean; const s: string): TAvisoAgendamentoAlPagtoE;
begin
  result := StrToEnumerado(ok, s,
    ['0','2','3','5','6','7','9'],
    [avSemAviso, avAvisoRemetente, avNoAgendamento, avPosAgendamento, avAvisoFavorecido, avAvisoFavorecido2v, avNoPosAgendamento])
end;

function TipoIdentificacaoToStr(const t: TTipoIdentificacaoAlPagtoE): string;
begin
  result := EnumeradoToStr(t,
    ['1','2','3'],
    [tiCnpjBeneficiario, tiNumeroNotaFiscal, tiCnpjTerceirosFilial])
end;

function StrToTipoIdentificacao(var ok: boolean; const s: string): TTipoIdentificacaoAlPagtoE;
begin
  result := StrToEnumerado(ok, s,
    ['1','2','3'],
    [tiCnpjBeneficiario, tiNumeroNotaFiscal, tiCnpjTerceirosFilial])
end;

function FinalidadeLoteToStr(const t: TFinalidadeLoteAlPagtoE): string;
begin
  result := EnumeradoToStr(t,
    ['  ','00','01','02','03','04','05','06','07','08','09','10','85'],
    [flNaoContratada, flNenhum, flFolhaMensal, flFolhaQuinzenal, flFolhaComplementar, flSalario13,
    flParticipacaoResultados, flInformeRendimentos, flFerias, flRescisao, flRescisaocomplementar,
    flOutros, flDebitoContaInvestimento])
end;

function StrToFinalidadeLote(var ok: boolean; const s: string): TFinalidadeLoteAlPagtoE;
begin
  result := StrToEnumerado(ok, s,
    ['  ','00','01','02','03','04','05','06','07','08','09','10','85'],
    [flNaoContratada, flNenhum, flFolhaMensal, flFolhaQuinzenal, flFolhaComplementar, flSalario13,
    flParticipacaoResultados, flInformeRendimentos, flFerias, flRescisao, flRescisaocomplementar,
    flOutros, flDebitoContaInvestimento])
end;

function TipoArquivoToStr(const t: TTipoArquivoAlPagtoE): string;
begin
  result := EnumeradoToStr(t,
    ['1','2'],
    [taRemessa, taRetorno])
end;

function StrToTipoArquivo(var ok: boolean; const s: string): TTipoArquivoAlPagtoE;
begin
  result := StrToEnumerado(ok, s,
    ['1','2'],
    [taRemessa, taRetorno])
end;
 {
function TipoMoedaToStr(const t: TTipoMoedaAlPagtoE): string;
begin
  result := EnumeradoToStr(t,
    ['REA','009'],
    [tmReal, tmOutros])
end;

function StrToTipoMoeda(var ok: boolean; const s: string): TTipoMoedaAlPagtoE;
begin
  result := StrToEnumerado(ok, s,
    ['REA','009'],
    [tmReal, tmOutros]);
end;
}

function LayoutToStr(const t: TLayoutALPagtoE): string;
begin
  result := EnumeradoToStr(t,
    ['341','237', '074', '748', '033', '001'],
    [lyItau, lyBradesco, lySafra, lySicredi, lySantander, lyBancoBrasil])
end;

function StrToLayout(var ok: boolean; const s: string): TLayoutALPagtoE;
begin
  result := StrToEnumerado(ok, s,
    ['341','237', '074', '748', '033', '001'],
    [lyItau, lyBradesco, lySafra, lySicredi, lySantander, lyBancoBrasil])
end;

function GPSPagamentoToStr(const t: TGPSPagamento): string;
begin
  result := EnumeradoToStr(t,
    ['1007', '1104','1406','1457','1503','1554','2003','2100','2208','2631','2909'],
    [gpIndividualMensal, gpIndividualTrimestral, gpFacultativoMensal, gpFacultativoTrimestral,
    gpEspecialMensal, gpEspecialTrimestral, gpOptanteSimples, gpEmpresaCnpj, gpEmpresaCei, gpNota, gpReclamatoria])
end;

function StrToGPSPagamento(var ok: boolean; const s: string): TGPSPagamento;
begin
  result := StrToEnumerado(ok, s,
    ['1007', '1104','1406','1457','1503','1554','2003','2100','2208','2631','2909'],
    [gpIndividualMensal, gpIndividualTrimestral, gpFacultativoMensal, gpFacultativoTrimestral,
    gpEspecialMensal, gpEspecialTrimestral, gpOptanteSimples, gpEmpresaCnpj, gpEmpresaCei, gpNota, gpReclamatoria])
end;

function getAgencia(banco: integer; AgenciaContaStr: String) : String;
begin
  if (banco = 341) or (banco = 409) then
    result := copy(AgenciaContaStr,2,4)
  else
    result := copy(AgenciaContaStr,1,5)
end;

function getConta(banco: integer; AgenciaContaStr: String) : String;
begin
  if (banco = 341) or (banco = 409) then
    result := copy(AgenciaContaStr,13,6)
  else
    result := copy(AgenciaContaStr,7,12)
end;

function getMesSicred(const pDataRemessa: TDateTime): String;
begin
  case MonthOf(pDataRemessa) of
    1: result := '1';
    2: result := '2';
    3: result := '3';
    4: result := '4';
    5: result := '5';
    6: result := '6';
    7: result := '7';
    8: result := '8';
    9: result := '9';
    10: result := 'O';
    11: result := 'N';
    12: result := 'D';
  end;
end;

function CamaraCentralizadoraTipoToStr(const pTipo: TCamaraCentralizadoraTipoPagtoE): String;
begin
  result := EnumeradoToStr(pTipo, ['700','018','888'], [cctDOC, cctTED, cctTED_ISPB]);
end;

function StrToCamaraCentralizadoraTipo(var pOK: Boolean; const pStr: String): TCamaraCentralizadoraTipoPagtoE;
begin
  result := StrToEnumerado(pOK, pStr,['700','018','888'], [cctDOC, cctTED, cctTED_ISPB]);
end;

function TipoMovimentoRemessaToStr(const pValue: TTipoMovimentoRemessa): String;
begin
  result := EnumeradoToStr(pValue,
                           ['01','02','04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '16', '17',
                            '31', '45', '75', '76'],
                           [tmrEntradaTitulos, tmrPedidoBaixa, tmrConcessaoAbataimento, tmrCancelamentoAbatimento,
                            tmrAlteracaoVencimento, tmrConcessaoDesconto, tmrCancelamentoDesconto, tmrProtestar,
                            tmrSustarProtestoBaixarTitulo, tmrSustarProtestoManterCarteira, tmrAlteracaoJurosMora,
                            tmrDispensarCobrancaJurosMora, tmrAlteracaoDesconto, tmrNaoConcederDesconto,
                            tmrAleracaoOutrosDados, tmrNegativacaoProtesto, tmrExcluirNegativacaoManterCarteira,
                            tmrExcluirNegativacaoBaixa]);
end;

function StrToTipoMovimentoRemessa(var ok: boolean; const s: string): TTipoMovimentoRemessa;
begin
  result := StrToEnumerado(ok, s,
                           ['01','02','04', '05', '06', '07', '08', '09', '10', '11', '12', '13', '16', '17',
                            '31', '45', '75', '76'],
                           [tmrEntradaTitulos, tmrPedidoBaixa, tmrConcessaoAbataimento, tmrCancelamentoAbatimento,
                            tmrAlteracaoVencimento, tmrConcessaoDesconto, tmrCancelamentoDesconto, tmrProtestar,
                            tmrSustarProtestoBaixarTitulo, tmrSustarProtestoManterCarteira, tmrAlteracaoJurosMora,
                            tmrDispensarCobrancaJurosMora, tmrAlteracaoDesconto, tmrNaoConcederDesconto,
                            tmrAleracaoOutrosDados, tmrNegativacaoProtesto, tmrExcluirNegativacaoManterCarteira,
                            tmrExcluirNegativacaoBaixa]);
end;

end.
