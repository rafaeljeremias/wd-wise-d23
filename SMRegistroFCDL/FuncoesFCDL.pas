unit FuncoesFCDL;

interface

Uses StrUtils, SysUtils, Generics.Collections;

const
  STR_SIM = 'S';
  STR_NAO = 'N';
  STR_ESPECIE_TITULO = 'DM';
  QUEBRA_LINHA = #13#10;

type
  TTelefone = record
  strict private
    FDDD: String;
    FNumero: String;

    procedure SetDDD(const pDDD: String);
    procedure SetNumero(const pNumero: String);
  public
    property DDD: String read FDDD write SetDDD;
    property Numero: String read FNumero write SetNumero;

    function IsValido(const pNumero: String): boolean;
  end;

  TTipoSexo = (tsMasculino, tsFeminino, tsIndefinido);

  TTipoEstadoCivil = (tecSolteiro, tecCasado, tecViuvo, tecDivorciado);

  TTipoAtualizacao = (taInclusao, taProtestar, taProtestarExecutado, taIncluirRegistroGeraBoleto,
                      taGerarBoletoExecutado, taExcluirRegistro, taNaoInformado);

  TDocumentosAdicionais = (daInscricaoRegistroComercio, daCarteiraProfissional,
                           daTituloEleitor, daCertificadoReservista, daForcaMilitar,
                           daConselhoRegionalMedicina, daOrdemAdvogadosBrasil, daCarteiraEstrangeiro,
                           daIdentidadeMilitar, daCarteiraNacionalHabilitacao, daCarteiraFuncional,
                           daConselhoRegionalContabilidade, daPassaporte, daRegistroNacionalEstrangeiro,
                           daNaoInformado);

  TPaisNacionalidade = (pnAfeganistao, pnAndorra, pnAntiguaeBarbuda, pnArgentina, pnAustria, pnBangladesh, pnBelize,
                        pnBosniaHerzegovina, pnBulgaria, pnCaboVerde, pnCazaquistao, pnChipre, pnCorreiaNorte, pnCroazia,
                        pnDominica, pnEquador, pnEspanha, pnFederacaoRussa, pnFranca, pnGeorgia, pnGrecia, pnGuatemala,
                        pnGuine, pnHolanda, pnIemen, pnIlhaPitcairn, pnIlhaCocos, pnAfricaSul, pnAngola, pnAntilhasHolandesas,
                        pnArmenia, pnAzerbajao, pnBarbados, pnBenin, pnBotsuana, pnBurkinaFasso, pnCamaroes, pnChade, pnCingapura,
                        pnCorreiaSul, pnCuba, pnEgito, pnEritreia, pnEstadosUnidos, pnFiji, pnGabao, pnGibratar, pnGroelandia,
                        pnGuernsey, pnGuineEquatorial, pnHonduras, pnIlhaBouvet, pnIlhaReuniao, pnIlhasComores, pnAlbania, pnAnguilla,
                        pnArabiaSaldita, pnAruba, pnBahamas, pnBelarus, pnBermudas, pnBrasil, pnBurundi, pnCamboja, pnChile, pnColombia,
                        pnCostaMarfim, pnDinamarca, pnElSavador, pnEslovaquia, pnEstonia, pnFlipinas, pnGambia, pnGraBetenha, pnGuadalupe,
                        pnGuiana, pnGuineBissau, pnHongKong, pnIlhaHomen, pnIlhasAland, pnIlhasCook, pnAlemanha, pnAntartida, pnArgelia,
                        pnAustralia, pnBahrein, pnBelgica, pnBolivia, pnBrunei, pnButao, pnCanada, pnChina, pnCongo, pnCostaRica,
                        pnDjibuti, pnEmiradosArabesUnidos, pnEslovenia, pnEtiopia, pnFinlandia, pnGana, pnGranada, pnQuam,
                        pnGuianaFrancesa, pnHaiti, pnHungria, pnIlhaNatal, pnIlhasCayman, pnIlhasFaroes, pnIlhasFalkland,
                        pnIlhasMarshall, pnIlhasSalomao, pnIlhasVirgens, pnIndonesia, pnIslandia, pnJapao, pnKiribati, pnLesoto,
                        pnLechtenstein, pnMacedonia, pnMaldivas, pnMartinica, pnMexico, pnMonaco, pnMyanma, pnNicaragua, pnNoruega,
                        pnPalau, pnParaguai, pnPortoRico, pnRepublicaCentroAfricana, pnRomenia, pnSamoaOcidental, pnSaoBartolomeu,
                        pnSenegal, pnSomalia, pnSuazilandia, pnSuriname, pnTanzania, pnIlhasGeorgiaSul, pnIlhasMenoresUSA,
                        pnIlhasSvalbardeJanMayen, pnIlhasVirgensGBR, pnIra, pnIsrael, pnJersey, pnKuait, pnLibano, pnLituania,
                        pnMadasgacar, pnMali, pnMauricio, pnMicronesia, pnMongolia, pnNamibia, pnNiger, pnNovaCaledonia,
                        pnPanama, pnPeru, pnPortugal, pnRepublicaCongo, pnRuanda, pnSanMarino, pnSaoCristovaoeNevis, pnSerraLeoa,
                        pnSiriLanka, pnSudao, pnTadjiquistao, pnTerraBritanicoOceanoIndico, pnIlhasHeardMcdonald, pnIlhasNorfolk,
                        pnIlhasTokelau, pnIlhasWalliseFutura, pnIraque, pnItalia, pnJordania, pnLaos, pnLiberia, pnLuxemburgo,
                        pnMalasia, pnMalta, pnMauritania, pnMocambique, pnMontenegro, pnNauru, pnNigeria, pnNovaZelandia,
                        pnPapuaNovaGuine, pnPolinesiaFrancesa, pnQatar, pnRepublicaDominicana, pnSaaraOcidental, pnSantaHelena,
                        pnSaoMartin, pnServia, pnStPierreAndMiquelon, pnSuecia, pnTailandia, pnTerraSulFranca, pnIlhasMarianasNorte,
                        pnIlhasSeychelles, pnIndia, pnIrlanda, pnJamaica, pnKenia, pnLatvia, pnLibia, pnMacau, pnLalaui, pnMarrocos,
                        pnMayotte, pnMoldova, pnMontSerrat, pnNepal, pnNiue, pnOma, pnPaquistao, pnPolonia, pnQuirguistao,
                        pnRepublicaTcheca, pnSamoaOcidental2, pnSantaLucia, pnSaoTomeePrincipe, pnSiria, pnStVincenteeGranadianas,
                        pnSuica, pnTaiwan, pnTerraPalestinosOcupados, pnTimorLeste, pnTunisia, pnUcrania, pnVanuatu, pnZambia, pnTogo,
                        pnTurcomenistao, pnUganda, pnVaticano, pnZimbabue, pnTonga, pnTurquia, pnUruguai, pnVenezuela, pnThinidadAndTobago,
                        pnTuvalu, pnUzbequuistao, pnVietna);

  TMoedaTipo = (mtReal, mtDolar, mtEuro);

  TLiquidacaoTipo = (ltEstornoDia, ltRegistroIndevidos, ltRenegociacao, ltPagamentoLiquidacao, ltOrdemJudicial,
                     ltTransferenciaCredito, ltDevolucaoCartaAviso, ltDeterminacaoDepartamento, ltNaoInformado);

  TMotivoDebito = (mdComprador, mdAvalista, mdFiador, mdEndossante, mdNaoInformado);

  TMotivoRegistroCheque = (mrcSemFundos, mrcContaEncerrada, mrcPraticaEspuria, mrcContraOrdem, mrcNaoInformado);

  function TiraAcentos(const Texto: string): String;
  function SomenteNumeros(const pValor: string): string;
  function TiraCaracteresEspeciais(const pTexto:String): String;
  function AlinhaEsq(const Palavra: string; Tamanho: Integer; Caracter: Char = #32): string;
  function AlinhaDir(const Palavra: string; Tamanho: Integer; Caracter: Char = #32): string;
  function AlinhaCentro(const Palavra: string; Tamanho: Integer; Caracter: Char = #32): string;

  function EnumeradoToStr(const t: variant; const AString: array of string; const AEnumerados: array of variant): variant;

  function StrToEnumerado(var ok: boolean; const s: string; const AString: array of string; const AEnumerados: array of variant): variant;

  function TipoMovimentoAtualizacaoToStr(const tipo: TTipoAtualizacao): String;
  function TipoMovimentoAtualizacaoToStr2(const tipo: TTipoAtualizacao): String;
  function StrToTipoMovimentoAtualizacao(var ok: boolean; s: string): TTipoAtualizacao;

  function TipoDocumentoAdicionalToStr(const pDocumento: TDocumentosAdicionais): String;
  function StrToTipoDocumentoAdicional(var pOK: Boolean; pStr: String): TDocumentosAdicionais;

  function TipoSexoToStr(const pTipo: TTipoSexo): String;
  function StrToTipoSexo(var pOK: Boolean; pStr: String): TTipoSexo;

  function TipoEstadoCivilToStr(const pTipo: TTipoEstadoCivil): String;
  function StrToTipoEstadoCivil(var pOK: Boolean; pStr: String): TTipoEstadoCivil;

  function PaisNacionalidadeToStr(const pNacionalidade: TPaisNacionalidade): String;
  function StrToPaisNacionalidade(var pOK: Boolean; pStr: String): TPaisNacionalidade;
  function Str2ToPaisNacionalidade(var pOK: Boolean; pStr: String): TPaisNacionalidade;

  function MoedaTipoToStr(const pTipo: TMoedaTipo): String;
  function StrToMoedaTipo(var pOK: Boolean; const pStr: String): TMoedaTipo;

  function LiquidacaoTipoToStr(const pTipo: TLiquidacaoTipo): String;
  function LiquidacaoTipoToStr2(const pTipo: TLiquidacaoTipo): String;
  function StrToLiquidacaoTipo(var pOK: Boolean; const pStr: String): TLiquidacaoTipo;
  function GetLiquidacaoTipoList: TList<TLiquidacaoTipo>;

  function MotivoDebitoToStr(const pMotivo: TMotivoDebito): String;
  function StrToMotivoDebito(var pOK: Boolean; const pStr: String): TMotivoDebito;

  function MotivoRegistroChequeToStr(const pMotivo: TMotivoRegistroCheque): String;
  function StrToMotivoRegistroCheque(var pOK: Boolean; const pStr: String): TMotivoRegistroCheque;

implementation

function AlinhaEsq(const Palavra: string; Tamanho: Integer; Caracter: Char = #32): String;
var
  S: String;
  i: Integer;

begin
  S := Palavra;
  For i := 1 to (Tamanho - Length(Palavra)) do
    S := S + Caracter;

  If Length(Palavra) > Tamanho then
    Delete(S, Tamanho + 1, Length(Palavra) - Tamanho);

  Result := S;
end;

function AlinhaDir(const Palavra: string; Tamanho: Integer; Caracter: Char = #32): String;
var
  S: String;
  i: Integer;

begin
  S := Palavra;

  For i := 1 to (Tamanho - Length(Palavra)) do
    S := Caracter + S;

  If Length(Palavra) > Tamanho then
    Delete(S, Tamanho + 1, Length(Palavra) - Tamanho);

  Result := S;
end;

function AlinhaCentro(const Palavra: string; Tamanho: Integer; Caracter: Char = #32): String;
var
  S: string;
  i: Integer;

begin
  S := Palavra;
  i := 0;
  while Length(S) < Tamanho do
  begin
    Inc(i);

    if Odd(i) then
      S := S + Caracter
    else
      S := Caracter + S;
  end;

  while Length(S) > Tamanho do
  begin
    Inc(i);
    if Odd(i) then
      Delete(S, 1, 1)
    else
      Delete(S, Length(S), 1);
  end;

  Result := S;
end;

function TiraAcentos(const Texto: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Texto) do
    case Texto[i] of
      'á', 'à', 'ä', 'â', 'ã':
        Result := Result + 'a';
      'Á', 'À', 'Ä', 'Â', 'Ã':
        Result := Result + 'A';
      'é', 'è', 'ë', 'ê':
        Result := Result + 'e';
      'É', 'È', 'Ë', 'Ê':
        Result := Result + 'E';
      'í', 'ì', 'ï', 'î':
        Result := Result + 'i';
      'Í', 'Ì', 'Ï', 'Î':
        Result := Result + 'I';
      'ó', 'ò', 'ö', 'ô', 'õ':
        Result := Result + 'o';
      'Ó', 'Ò', 'Ö', 'Ô', 'Õ':
        Result := Result + 'O';
      'ú', 'ù', 'ü', 'û':
        Result := Result + 'u';
      'Ú', 'Ù', 'Ü', 'Û':
        Result := Result + 'U';
      'Ç':
        Result := Result + 'C';
      'ç':
        Result := Result + 'c';
      'ñ':
        Result := Result + 'n';
      'Ñ':
        Result := Result + 'N';
      'ª':
        Result := Result + 'a';
      'º':
        Result := Result + 'o';
    else
      Result := Result + Texto[i];
    end;
end;

function TiraCaracteresEspeciais(const pTexto:String): String;
begin
  Result := AnsiReplaceStr(pTexto, '#', '');
  Result := AnsiReplaceStr(Result, '$', '');
  Result := AnsiReplaceStr(Result, '*', '');
  Result := AnsiReplaceStr(Result, '!', '');
  Result := AnsiReplaceStr(Result, '-', '');
end;

function EnumeradoToStr(const t: variant; const AString: array of string; const AEnumerados: array of variant): variant;
var
  i: integer;

begin
  result := '';
  for i := Low(AEnumerados) to High(AEnumerados) do
    if t = AEnumerados[i] then
      result := AString[i];
end;

function StrToEnumerado(var ok: boolean; const s: string; const AString: array of string; const AEnumerados: array of variant): variant;
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

function TipoMovimentoAtualizacaoToStr(const tipo: TTipoAtualizacao): String;
begin
  result := EnumeradoToStr(tipo, ['I', 'P', 'T', 'C', 'B', 'E', ''],
                           [taInclusao, taProtestar, taProtestarExecutado, taIncluirRegistroGeraBoleto,
                           taGerarBoletoExecutado, taExcluirRegistro, taNaoInformado]);
end;

function TipoMovimentoAtualizacaoToStr2(const tipo: TTipoAtualizacao): String;
begin
  result := EnumeradoToStr(tipo, ['Incluir', 'Prostetar', 'Protestar já Executado', 'Incluir e Gerar Boleto',
                                  'Gerar Boleto já Executado', 'Excluir', ''],
                                 [taInclusao, taProtestar, taProtestarExecutado, taIncluirRegistroGeraBoleto,
                                  taGerarBoletoExecutado, taExcluirRegistro, taNaoInformado]);
end;

function StrToTipoMovimentoAtualizacao(var ok: boolean; s: string): TTipoAtualizacao;
begin
  result := StrToEnumerado(ok, s, ['I', 'P', 'T', 'C', 'B', 'E', ''],
                                  [taInclusao, taProtestar, taProtestarExecutado, taIncluirRegistroGeraBoleto,
                                   taGerarBoletoExecutado, taExcluirRegistro, taNaoInformado]);
end;

function TipoDocumentoAdicionalToStr(const pDocumento: TDocumentosAdicionais): String;
begin
  result := EnumeradoToStr(pDocumento, ['NIRE', 'CP', 'TE', 'CR', 'RE', 'CRM', 'OAB', 'CIE', 'IM', 'CNH', 'CF', 'CRC', 'PAS', 'RNE', ''],
                           [daInscricaoRegistroComercio, daCarteiraProfissional,
                           daTituloEleitor, daCertificadoReservista, daForcaMilitar,
                           daConselhoRegionalMedicina, daOrdemAdvogadosBrasil, daCarteiraEstrangeiro,
                           daIdentidadeMilitar, daCarteiraNacionalHabilitacao, daCarteiraFuncional,
                           daConselhoRegionalContabilidade, daPassaporte, daRegistroNacionalEstrangeiro,
                           daNaoInformado]);
end;

function StrToTipoDocumentoAdicional(var pOK: Boolean; pStr: String): TDocumentosAdicionais;
begin
  result := StrToEnumerado(pOK, pStr, ['NIRE', 'CP', 'TE', 'CR', 'RE', 'CRM', 'OAB', 'CIE', 'IM', 'CNH', 'CF', 'CRC', 'PAS', 'RNE', ''],
                           [daInscricaoRegistroComercio, daCarteiraProfissional,
                           daTituloEleitor, daCertificadoReservista, daForcaMilitar,
                           daConselhoRegionalMedicina, daOrdemAdvogadosBrasil, daCarteiraEstrangeiro,
                           daIdentidadeMilitar, daCarteiraNacionalHabilitacao, daCarteiraFuncional,
                           daConselhoRegionalContabilidade, daPassaporte, daRegistroNacionalEstrangeiro,
                           daNaoInformado]);
end;

function TipoSexoToStr(const pTipo: TTipoSexo): String;
begin
  result := EnumeradoToStr(pTipo, ['M', 'F', 'I'], [tsMasculino, tsFeminino, tsIndefinido]);
end;

function StrToTipoSexo(var pOK: Boolean; pStr: String): TTipoSexo;
begin
  result := StrToEnumerado(pOK, pStr, ['M', 'F', 'I'], [tsMasculino, tsFeminino, tsIndefinido]);
end;

function TipoEstadoCivilToStr(const pTipo: TTipoEstadoCivil): String;
begin
  result := EnumeradoToStr(pTipo, ['S', 'C', 'V', 'D'], [tecSolteiro, tecCasado, tecViuvo, tecDivorciado]);
end;

function StrToTipoEstadoCivil(var pOK: Boolean; pStr: String): TTipoEstadoCivil;
begin
  result := StrToEnumerado(pOK, pStr, ['S', 'C', 'V', 'D'], [tecSolteiro, tecCasado, tecViuvo, tecDivorciado]);
end;

function PaisNacionalidadeToStr(const pNacionalidade: TPaisNacionalidade): String;
begin
  result := EnumeradoToStr(pNacionalidade,
                           ['AFG', 'AND', 'ATG', 'ARG', 'AUT', 'BGD', 'BLZ', 'BIH', 'BGR', 'CPV', 'KAZ', 'CYP', 'PRK', 'HRV',
                            'DMA', 'ECU', 'ESP', 'RUS', 'FRA', 'GEO', 'GRC', 'GTM', 'GIN', 'NLD', 'YEM', 'PCN', 'CCK', 'ZAF', 'AGO', 'ANT',
                            'ARM', 'AZE', 'BRB', 'BEN', 'BWA', 'BFA', 'CMR', 'TCD', 'SGP', 'KOR', 'CUB', 'EGY', 'ERI', 'USA', 'FJI', 'GAB', 'GIB', 'GRL',
                            'GGY', 'GNQ', 'HND', 'BVT', 'REU', 'COM', 'ALB', 'AIA', 'SAU', 'ABW', 'BHS', 'BLR', 'BMU', 'BRA', 'BDI', 'KHM', 'CHL', 'COL',
                            'CIV', 'DNK', 'SLV', 'SVK', 'EST', 'PHL', 'GMB', 'GBR', 'GLP', 'GUY', 'GNB', 'HKG', 'IMN', 'ALA', 'COK', 'DEU', 'ATA', 'DZA',
                            'AUS', 'BHR', 'BEL', 'BOL', 'BRN', 'BTN', 'CAN', 'CHN', 'COG', 'CRI', 'DJI', 'ARE', 'SVN', 'ETH', 'FIN', 'GHA', 'GRD', 'GUM',
                            'GUF', 'HTI', 'HUN', 'CXR', 'CYM', 'FRO', 'FLK', 'MHL', 'SLB', 'VIR', 'IDN', 'ISL', 'JPN', 'KIR', 'LSO',
                            'LIE', 'MKD', 'MDV', 'MTQ', 'MEX', 'MCO', 'MMR', 'NIC', 'NOR', 'PLW', 'PRY', 'PRI', 'CAF', 'ROM', 'WSM', 'BLM',
                            'SEN', 'SOM', 'SWZ', 'SUR', 'TZA', 'SGS', 'UMI', 'SJM', 'VGB', 'IRN', 'ISR', 'JEY', 'KWT', 'LBN', 'LTU',
                            'MDG', 'MLI', 'MUS', 'FSM', 'MNG', 'NAM', 'NER', 'NCL', 'PAN', 'PER', 'PRT', 'COD', 'RWA', 'SMR', 'KNA', 'SLE',
                            'LKA', 'SDN', 'TJK', 'IOT', 'KMD', 'NFK', 'TKL', 'WLF', 'IRQ', 'ITA', 'JOR', 'LAO', 'LBR', 'LUX',
                            'MYS', 'MLT', 'MRT', 'MOZ', 'MNE', 'NRU', 'NGA', 'NZL', 'PNG', 'PYF', 'QAT', 'DOM', 'ESH', 'SHN',
                            'MAF', 'SRB', 'SPM', 'SWE', 'THA', 'ATF', 'MNP', 'SYC', 'TCA', 'IND', 'IRL', 'JAM', 'KEN', 'LVA', 'LBY', 'MAC', 'MWI', 'MAR',
                            'MYT', 'MDA', 'MSR', 'NPL', 'NIU', 'OMN', 'PAK', 'POL', 'KGZ', 'CZE', 'ASM', 'LCA', 'STP', 'SYR', 'VCT',
                            'CHE', 'TWN', 'PSE', 'TMP', 'TUN', 'UKR', 'VUT', 'ZMB', 'TGO', 'TKM', 'UGA', 'VAT', 'ZWE', 'TON', 'TUR', 'URY', 'VEN', 'TTO',
                            'TUV', 'UZB', 'VNM'],
                           [pnAfeganistao, pnAndorra, pnAntiguaeBarbuda, pnArgentina, pnAustria, pnBangladesh, pnBelize,
                            pnBosniaHerzegovina, pnBulgaria, pnCaboVerde, pnCazaquistao, pnChipre, pnCorreiaNorte, pnCroazia,
                            pnDominica, pnEquador, pnEspanha, pnFederacaoRussa, pnFranca, pnGeorgia, pnGrecia, pnGuatemala,
                            pnGuine, pnHolanda, pnIemen, pnIlhaPitcairn, pnIlhaCocos, pnAfricaSul, pnAngola, pnAntilhasHolandesas,
                            pnArmenia, pnAzerbajao, pnBarbados, pnBenin, pnBotsuana, pnBurkinaFasso, pnCamaroes, pnChade, pnCingapura,
                            pnCorreiaSul, pnCuba, pnEgito, pnEritreia, pnEstadosUnidos, pnFiji, pnGabao, pnGibratar, pnGroelandia,
                            pnGuernsey, pnGuineEquatorial, pnHonduras, pnIlhaBouvet, pnIlhaReuniao, pnIlhasComores, pnAlbania, pnAnguilla,
                            pnArabiaSaldita, pnAruba, pnBahamas, pnBelarus, pnBermudas, pnBrasil, pnBurundi, pnCamboja, pnChile, pnColombia,
                            pnCostaMarfim, pnDinamarca, pnElSavador, pnEslovaquia, pnEstonia, pnFlipinas, pnGambia, pnGraBetenha, pnGuadalupe,
                            pnGuiana, pnGuineBissau, pnHongKong, pnIlhaHomen, pnIlhasAland, pnIlhasCook, pnAlemanha, pnAntartida, pnArgelia,
                            pnAustralia, pnBahrein, pnBelgica, pnBolivia, pnBrunei, pnButao, pnCanada, pnChina, pnCongo, pnCostaRica,
                            pnDjibuti, pnEmiradosArabesUnidos, pnEslovenia, pnEtiopia, pnFinlandia, pnGana, pnGranada, pnQuam,
                            pnGuianaFrancesa, pnHaiti, pnHungria, pnIlhaNatal, pnIlhasCayman, pnIlhasFaroes, pnIlhasFalkland,
                            pnIlhasMarshall, pnIlhasSalomao, pnIlhasVirgens, pnIndonesia, pnIslandia, pnJapao, pnKiribati, pnLesoto,
                            pnLechtenstein, pnMacedonia, pnMaldivas, pnMartinica, pnMexico, pnMonaco, pnMyanma, pnNicaragua, pnNoruega,
                            pnPalau, pnParaguai, pnPortoRico, pnRepublicaCentroAfricana, pnRomenia, pnSamoaOcidental, pnSaoBartolomeu,
                            pnSenegal, pnSomalia, pnSuazilandia, pnSuriname, pnTanzania, pnIlhasGeorgiaSul, pnIlhasMenoresUSA,
                            pnIlhasSvalbardeJanMayen, pnIlhasVirgensGBR, pnIra, pnIsrael, pnJersey, pnKuait, pnLibano, pnLituania,
                            pnMadasgacar, pnMali, pnMauricio, pnMicronesia, pnMongolia, pnNamibia, pnNiger, pnNovaCaledonia,
                            pnPanama, pnPeru, pnPortugal, pnRepublicaCongo, pnRuanda, pnSanMarino, pnSaoCristovaoeNevis, pnSerraLeoa,
                            pnSiriLanka, pnSudao, pnTadjiquistao, pnTerraBritanicoOceanoIndico, pnIlhasHeardMcdonald, pnIlhasNorfolk,
                            pnIlhasTokelau, pnIlhasWalliseFutura, pnIraque, pnItalia, pnJordania, pnLaos, pnLiberia, pnLuxemburgo,
                            pnMalasia, pnMalta, pnMauritania, pnMocambique, pnMontenegro, pnNauru, pnNigeria, pnNovaZelandia,
                            pnPapuaNovaGuine, pnPolinesiaFrancesa, pnQatar, pnRepublicaDominicana, pnSaaraOcidental, pnSantaHelena,
                            pnSaoMartin, pnServia, pnStPierreAndMiquelon, pnSuecia, pnTailandia, pnTerraSulFranca, pnIlhasMarianasNorte,
                            pnIlhasSeychelles, pnIndia, pnIrlanda, pnJamaica, pnKenia, pnLatvia, pnLibia, pnMacau, pnLalaui, pnMarrocos,
                            pnMayotte, pnMoldova, pnMontSerrat, pnNepal, pnNiue, pnOma, pnPaquistao, pnPolonia, pnQuirguistao,
                            pnRepublicaTcheca, pnSamoaOcidental2, pnSantaLucia, pnSaoTomeePrincipe, pnSiria, pnStVincenteeGranadianas,
                            pnSuica, pnTaiwan, pnTerraPalestinosOcupados, pnTimorLeste, pnTunisia, pnUcrania, pnVanuatu, pnZambia, pnTogo,
                            pnTurcomenistao, pnUganda, pnVaticano, pnZimbabue, pnTonga, pnTurquia, pnUruguai, pnVenezuela, pnThinidadAndTobago,
                            pnTuvalu, pnUzbequuistao, pnVietna]);
end;

function StrToPaisNacionalidade(var pOK: Boolean; pStr: String): TPaisNacionalidade;
begin
  result := StrToEnumerado(pOK, pStr,
                           ['AFG', 'AND', 'ATG', 'ARG', 'AUT', 'BGD', 'BLZ', 'BIH', 'BGR', 'CPV', 'KAZ', 'CYP', 'PRK', 'HRV',
                            'DMA', 'ECU', 'ESP', 'RUS', 'FRA', 'GEO', 'GRC', 'GTM', 'GIN', 'NLD', 'YEM', 'PCN', 'CCK', 'ZAF', 'AGO', 'ANT',
                            'ARM', 'AZE', 'BRB', 'BEN', 'BWA', 'BFA', 'CMR', 'TCD', 'SGP', 'KOR', 'CUB', 'EGY', 'ERI', 'USA', 'FJI', 'GAB', 'GIB', 'GRL',
                            'GGY', 'GNQ', 'HND', 'BVT', 'REU', 'COM', 'ALB', 'AIA', 'SAU', 'ABW', 'BHS', 'BLR', 'BMU', 'BRA', 'BDI', 'KHM', 'CHL', 'COL',
                            'CIV', 'DNK', 'SLV', 'SVK', 'EST', 'PHL', 'GMB', 'GBR', 'GLP', 'GUY', 'GNB', 'HKG', 'IMN', 'ALA', 'COK', 'DEU', 'ATA', 'DZA',
                            'AUS', 'BHR', 'BEL', 'BOL', 'BRN', 'BTN', 'CAN', 'CHN', 'COG', 'CRI', 'DJI', 'ARE', 'SVN', 'ETH', 'FIN', 'GHA', 'GRD', 'GUM',
                            'GUF', 'HTI', 'HUN', 'CXR', 'CYM', 'FRO', 'FLK', 'MHL', 'SLB', 'VIR', 'IDN', 'ISL', 'JPN', 'KIR', 'LSO',
                            'LIE', 'MKD', 'MDV', 'MTQ', 'MEX', 'MCO', 'MMR', 'NIC', 'NOR', 'PLW', 'PRY', 'PRI', 'CAF', 'ROM', 'WSM', 'BLM',
                            'SEN', 'SOM', 'SWZ', 'SUR', 'TZA', 'SGS', 'UMI', 'SJM', 'VGB', 'IRN', 'ISR', 'JEY', 'KWT', 'LBN', 'LTU',
                            'MDG', 'MLI', 'MUS', 'FSM', 'MNG', 'NAM', 'NER', 'NCL', 'PAN', 'PER', 'PRT', 'COD', 'RWA', 'SMR', 'KNA', 'SLE',
                            'LKA', 'SDN', 'TJK', 'IOT', 'KMD', 'NFK', 'TKL', 'WLF', 'IRQ', 'ITA', 'JOR', 'LAO', 'LBR', 'LUX',
                            'MYS', 'MLT', 'MRT', 'MOZ', 'MNE', 'NRU', 'NGA', 'NZL', 'PNG', 'PYF', 'QAT', 'DOM', 'ESH', 'SHN',
                            'MAF', 'SRB', 'SPM', 'SWE', 'THA', 'ATF', 'MNP', 'SYC', 'TCA', 'IND', 'IRL', 'JAM', 'KEN', 'LVA', 'LBY', 'MAC', 'MWI', 'MAR',
                            'MYT', 'MDA', 'MSR', 'NPL', 'NIU', 'OMN', 'PAK', 'POL', 'KGZ', 'CZE', 'ASM', 'LCA', 'STP', 'SYR', 'VCT',
                            'CHE', 'TWN', 'PSE', 'TMP', 'TUN', 'UKR', 'VUT', 'ZMB', 'TGO', 'TKM', 'UGA', 'VAT', 'ZWE', 'TON', 'TUR', 'URY', 'VEN', 'TTO',
                            'TUV', 'UZB', 'VNM'],
                           [pnAfeganistao, pnAndorra, pnAntiguaeBarbuda, pnArgentina, pnAustria, pnBangladesh, pnBelize,
                            pnBosniaHerzegovina, pnBulgaria, pnCaboVerde, pnCazaquistao, pnChipre, pnCorreiaNorte, pnCroazia,
                            pnDominica, pnEquador, pnEspanha, pnFederacaoRussa, pnFranca, pnGeorgia, pnGrecia, pnGuatemala,
                            pnGuine, pnHolanda, pnIemen, pnIlhaPitcairn, pnIlhaCocos, pnAfricaSul, pnAngola, pnAntilhasHolandesas,
                            pnArmenia, pnAzerbajao, pnBarbados, pnBenin, pnBotsuana, pnBurkinaFasso, pnCamaroes, pnChade, pnCingapura,
                            pnCorreiaSul, pnCuba, pnEgito, pnEritreia, pnEstadosUnidos, pnFiji, pnGabao, pnGibratar, pnGroelandia,
                            pnGuernsey, pnGuineEquatorial, pnHonduras, pnIlhaBouvet, pnIlhaReuniao, pnIlhasComores, pnAlbania, pnAnguilla,
                            pnArabiaSaldita, pnAruba, pnBahamas, pnBelarus, pnBermudas, pnBrasil, pnBurundi, pnCamboja, pnChile, pnColombia,
                            pnCostaMarfim, pnDinamarca, pnElSavador, pnEslovaquia, pnEstonia, pnFlipinas, pnGambia, pnGraBetenha, pnGuadalupe,
                            pnGuiana, pnGuineBissau, pnHongKong, pnIlhaHomen, pnIlhasAland, pnIlhasCook, pnAlemanha, pnAntartida, pnArgelia,
                            pnAustralia, pnBahrein, pnBelgica, pnBolivia, pnBrunei, pnButao, pnCanada, pnChina, pnCongo, pnCostaRica,
                            pnDjibuti, pnEmiradosArabesUnidos, pnEslovenia, pnEtiopia, pnFinlandia, pnGana, pnGranada, pnQuam,
                            pnGuianaFrancesa, pnHaiti, pnHungria, pnIlhaNatal, pnIlhasCayman, pnIlhasFaroes, pnIlhasFalkland,
                            pnIlhasMarshall, pnIlhasSalomao, pnIlhasVirgens, pnIndonesia, pnIslandia, pnJapao, pnKiribati, pnLesoto,
                            pnLechtenstein, pnMacedonia, pnMaldivas, pnMartinica, pnMexico, pnMonaco, pnMyanma, pnNicaragua, pnNoruega,
                            pnPalau, pnParaguai, pnPortoRico, pnRepublicaCentroAfricana, pnRomenia, pnSamoaOcidental, pnSaoBartolomeu,
                            pnSenegal, pnSomalia, pnSuazilandia, pnSuriname, pnTanzania, pnIlhasGeorgiaSul, pnIlhasMenoresUSA,
                            pnIlhasSvalbardeJanMayen, pnIlhasVirgensGBR, pnIra, pnIsrael, pnJersey, pnKuait, pnLibano, pnLituania,
                            pnMadasgacar, pnMali, pnMauricio, pnMicronesia, pnMongolia, pnNamibia, pnNiger, pnNovaCaledonia,
                            pnPanama, pnPeru, pnPortugal, pnRepublicaCongo, pnRuanda, pnSanMarino, pnSaoCristovaoeNevis, pnSerraLeoa,
                            pnSiriLanka, pnSudao, pnTadjiquistao, pnTerraBritanicoOceanoIndico, pnIlhasHeardMcdonald, pnIlhasNorfolk,
                            pnIlhasTokelau, pnIlhasWalliseFutura, pnIraque, pnItalia, pnJordania, pnLaos, pnLiberia, pnLuxemburgo,
                            pnMalasia, pnMalta, pnMauritania, pnMocambique, pnMontenegro, pnNauru, pnNigeria, pnNovaZelandia,
                            pnPapuaNovaGuine, pnPolinesiaFrancesa, pnQatar, pnRepublicaDominicana, pnSaaraOcidental, pnSantaHelena,
                            pnSaoMartin, pnServia, pnStPierreAndMiquelon, pnSuecia, pnTailandia, pnTerraSulFranca, pnIlhasMarianasNorte,
                            pnIlhasSeychelles, pnIndia, pnIrlanda, pnJamaica, pnKenia, pnLatvia, pnLibia, pnMacau, pnLalaui, pnMarrocos,
                            pnMayotte, pnMoldova, pnMontSerrat, pnNepal, pnNiue, pnOma, pnPaquistao, pnPolonia, pnQuirguistao,
                            pnRepublicaTcheca, pnSamoaOcidental2, pnSantaLucia, pnSaoTomeePrincipe, pnSiria, pnStVincenteeGranadianas,
                            pnSuica, pnTaiwan, pnTerraPalestinosOcupados, pnTimorLeste, pnTunisia, pnUcrania, pnVanuatu, pnZambia, pnTogo,
                            pnTurcomenistao, pnUganda, pnVaticano, pnZimbabue, pnTonga, pnTurquia, pnUruguai, pnVenezuela, pnThinidadAndTobago,
                            pnTuvalu, pnUzbequuistao, pnVietna]);
end;

function Str2ToPaisNacionalidade(var pOK: Boolean; pStr: String): TPaisNacionalidade;
begin
  result := StrToEnumerado(pOK, UpperCase(pStr),
                           ['AFEGANISTAO', 'ARGENTINA', 'AUSTRIA', 'BULGARIA', 'CORREIA NORTE', 'CROAZIA',
                            'DOMINICA', 'EQUADOR', 'ESPANHA', 'FEDERACAO RUSSA', 'FRANCA', 'GEORGIA', 'GRECIA', 'GUATEMALA',
                            'GUINE', 'HOLANDA', 'ANGOLA', 'ARMENIA', 'AZERBAJAO', 'BARBADOS', 'CAMAROES', 'CINGAPURA',
                            'CORREIA DO SUL', 'CUBA', 'EGITO', 'ESTADOS UNIDOS', 'HONDURAS', 'BRASIL', 'CHILE', 'COLOMBIA',
                            'COSTA DO MARFIM', 'DINAMARCA', 'ELSAVADOR', 'HONG KONG', 'ALEMANHA', 'AUSTRALIA', 'BELGICA', 'BOLIVIA',
                            'CANADA', 'CHINA', 'COSTA RICA', 'HAITI', 'HUNGRIA', 'ILHAS MARSHALL', 'INDONESIA', 'ISLANDIA', 'JAPAO',
                            'MACEDONIA', 'MALDIVAS', 'MEXICO', 'NICARAGUA', 'NORUEGA', 'PARAGUAI', 'PORTO RICO', 'ROMENIA',
                            'SOMALIA', 'IRA', 'ISRAEL', 'LIBANO', 'PANAMA', 'PERU', 'PORTUGAL', 'IRAQUE', 'ITALIA',
                            'MALASIA', 'NIGERIA', 'NOVA ZELANDIA', 'SERVIA', 'SUECIA', 'TAILANDIA', 'INDIA', 'IRLANDA', 'JAMAICA',
                            'LIBIA', 'MARROCOS', 'NEPAL', 'PAQUISTAO', 'POLONIA', 'SIRIA', 'SUICA', 'TAIWAN', 'VATICANO',
                            'ZIMBABUE', 'TURQUIA', 'URUGUAI', 'VENEZUELA', 'VIETNA'],
                           [PNAFEGANISTAO, PNARGENTINA, PNAUSTRIA, PNBULGARIA, PNCORREIANORTE, PNCROAZIA,
                            PNDOMINICA, PNEQUADOR, PNESPANHA, PNFEDERACAORUSSA, PNFRANCA, PNGEORGIA, PNGRECIA, PNGUATEMALA,
                            PNGUINE, PNHOLANDA, PNANGOLA, PNARMENIA, PNAZERBAJAO, PNBARBADOS, PNCAMAROES, PNCINGAPURA,
                            PNCORREIASUL, PNCUBA, PNEGITO, PNESTADOSUNIDOS, PNHONDURAS, PNBRASIL, PNCHILE, PNCOLOMBIA,
                            PNCOSTAMARFIM, PNDINAMARCA, PNELSAVADOR, PNHONGKONG, PNALEMANHA, PNAUSTRALIA, PNBELGICA, PNBOLIVIA,
                            PNCANADA, PNCHINA, PNCOSTARICA, PNHAITI, PNHUNGRIA, PNILHASMARSHALL, PNINDONESIA, PNISLANDIA, PNJAPAO,
                            PNMACEDONIA, PNMALDIVAS, PNMEXICO, PNNICARAGUA, PNNORUEGA, PNPARAGUAI, PNPORTORICO, PNROMENIA,
                            PNSOMALIA, PNIRA, PNISRAEL, PNLIBANO, PNPANAMA, PNPERU, PNPORTUGAL, PNIRAQUE, PNITALIA,
                            PNMALASIA, PNNIGERIA, PNNOVAZELANDIA, PNSERVIA, PNSUECIA, PNTAILANDIA, PNINDIA, PNIRLANDA, PNJAMAICA,
                            PNLIBIA, PNMARROCOS, PNNEPAL, PNPAQUISTAO, PNPOLONIA, PNSIRIA, PNSUICA, PNTAIWAN, PNVATICANO,
                            PNZIMBABUE, PNTURQUIA, PNURUGUAI, PNVENEZUELA, PNVIETNA]);
end;

function MoedaTipoToStr(const pTipo: TMoedaTipo): String;
begin
  result := EnumeradoToStr(pTipo, ['REAL', 'DOLAR', 'EURO'], [mtReal, mtDolar, mtEuro]);
end;

function StrToMoedaTipo(var pOK: Boolean; const pStr: String): TMoedaTipo;
begin
  result := StrToEnumerado(pOK, pStr, ['REAL', 'DOLAR', 'EURO'], [mtReal, mtDolar, mtEuro]);
end;

function LiquidacaoTipoToStr(const pTipo: TLiquidacaoTipo): String;
begin
  result := EnumeradoToStr(pTipo, ['A', 'B', 'D', 'E', 'F', 'G', 'J', 'K', ''],
                           [ltEstornoDia, ltRegistroIndevidos, ltRenegociacao, ltPagamentoLiquidacao, ltOrdemJudicial,
                            ltTransferenciaCredito, ltDevolucaoCartaAviso, ltDeterminacaoDepartamento, ltNaoInformado]);
end;

function LiquidacaoTipoToStr2(const pTipo: TLiquidacaoTipo): String;
begin
  result := EnumeradoToStr(pTipo, ['Estorno no Dia', 'Registros Indevidos', 'Renegociação', 'Pagamento/Liquidação',
                                   'Ordem Judicial', 'Transferência de Crédito', 'Devolução de Carta Aviso', 'Determinação do Departamento', ''],
                                  [ltEstornoDia, ltRegistroIndevidos, ltRenegociacao, ltPagamentoLiquidacao, ltOrdemJudicial,
                                   ltTransferenciaCredito, ltDevolucaoCartaAviso, ltDeterminacaoDepartamento, ltNaoInformado]);
end;

function StrToLiquidacaoTipo(var pOK: Boolean; const pStr: String): TLiquidacaoTipo;
begin
  result := StrToEnumerado(pOK, pStr, ['A', 'B', 'D', 'E', 'F', 'G', 'J', 'K', ''],
                           [ltEstornoDia, ltRegistroIndevidos, ltRenegociacao, ltPagamentoLiquidacao, ltOrdemJudicial,
                            ltTransferenciaCredito, ltDevolucaoCartaAviso, ltDeterminacaoDepartamento, ltNaoInformado]);
end;

function GetLiquidacaoTipoList: TList<TLiquidacaoTipo>;
begin
  result := TList<TLiquidacaoTipo>.Create;
  result.Add(ltEstornoDia);
  result.Add(ltRegistroIndevidos);
  result.Add(ltRenegociacao);
  result.Add(ltPagamentoLiquidacao);
  result.Add(ltOrdemJudicial);
  result.Add(ltTransferenciaCredito);
  result.Add(ltDevolucaoCartaAviso);
  result.Add(ltDeterminacaoDepartamento);
  result.Add(ltNaoInformado);
end;

function MotivoDebitoToStr(const pMotivo: TMotivoDebito): String;
begin
  result := EnumeradoToStr(pMotivo, ['C', 'A', 'F', 'E', ''], [mdComprador, mdAvalista, mdFiador, mdEndossante, mdNaoInformado]);
end;

function StrToMotivoDebito(var pOK: Boolean; const pStr: String): TMotivoDebito;
begin
  result := StrToEnumerado(pOK, pStr, ['C', 'A', 'F', 'E', ''], [mdComprador, mdAvalista, mdFiador, mdEndossante, mdNaoInformado]);
end;

function MotivoRegistroChequeToStr(const pMotivo: TMotivoRegistroCheque): String;
begin
  result := EnumeradoToStr(pMotivo, ['12', '13', '14', '21', ''], [mrcSemFundos, mrcContaEncerrada, mrcPraticaEspuria, mrcContraOrdem, mrcNaoInformado]);
end;

function StrToMotivoRegistroCheque(var pOK: Boolean; const pStr: String): TMotivoRegistroCheque;
begin
  result := StrToEnumerado(pOK, pStr, ['12', '13', '14', '21', ''], [mrcSemFundos, mrcContaEncerrada, mrcPraticaEspuria, mrcContraOrdem, mrcNaoInformado]);
end;

function SomenteNumeros(const pValor: string): string;
var
  S: string;
  i: Integer;

begin
  S := Trim(pValor);

  for i := Length(S) downto 1 do
    if not CharInSet(S[i], ['0' .. '9', FormatSettings.DecimalSeparator]) then
      Delete(S, i, 1);
  Result := S;
end;

{ TTelefone }

function TTelefone.IsValido(const pNumero: String): boolean;
var
  lPar: Boolean;

begin
  result := False;
  FDDD := '';
  FNumero := '';

  if pNumero <> '' then
  begin
    lPar := copy(Trim(pNumero), 1, 1) = '(';

    if lPar then
    begin
      FDDD := copy(pNumero, 2, pos(')', pNumero) + 1);
      FNumero := copy(pNumero, pos(')', pNumero) + 1, Length(pNumero));
      Result := True;
    end
    else
    begin
      lPar := (copy(Trim(pNumero), 1, 3) = '047') or
              (copy(Trim(pNumero), 1, 3) = '048') or
              (copy(Trim(pNumero), 1, 3) = '049');

      if lPar then
      begin
        FDDD := copy(Trim(pNumero), 1, 3);
        FNumero := copy(pNumero, 4, Length(pNumero));
        Result := True;
      end
      else
      begin
        lPar := (copy(Trim(pNumero), 1, 2) = '47') or
                (copy(Trim(pNumero), 1, 2) = '48') or
                (copy(Trim(pNumero), 1, 2) = '49');

        if lPar then
        begin
          FDDD := copy(Trim(pNumero), 1, 2);
          FNumero := copy(pNumero, 3, Length(pNumero));
          Result := True;
        end
        else
        begin
          FDDD := '000';
          FNumero := pNumero;
          Result := True;
        end;
      end;
    end;
  end;
end;

procedure TTelefone.SetDDD(const pDDD: String);
begin
  FDDD := pDDD;
end;

procedure TTelefone.SetNumero(const pNumero: String);
begin
  FNumero := pNumero;
end;

end.
