unit RegistroSPC;

interface

uses FuncoesFCDL, SysUtils, StrUtils, math, TraillerFCDL;

type
  TDevedor = class
  strict private
    FCPF: String;
    FRG: String;
    FUnidadeFederacao: String;
    FDocumentoAdicional: String;
    FTipoDocumentoAdicional: TDocumentosAdicionais;
    FNome: String;
    FDataNascimento: TDate;
    FSexo: TTipoSexo;
    FEstadoCivil: TTipoEstadoCivil;
    FNaturalidade: String;
    FUnidadeFederacaoNaturalidade: String;
    FNomePai: String;
    FNomeMae: String;
    FNomeConjuge: String;
    FDataNascimentoConjuge: TDate;
    FEndereco: String;
    FComplemento: String;
    FNumero: Integer;
    FBairro: String;
    FCEP: Integer;
    FCidade: String;
    FUnidadeFederativaEndereco: String;
    FDDD: String;
    FFone: String;
    FEmail: String;
    FLocalDeTrabalho: String;
    FDDD_Celular: String;
    FCelular: String;
    FPaisNacionalidade: TPaisNacionalidade;
  public
    property CPF: String read FCPF write FCPF; // Numero do CPF / CNPJ, exemplo: "1212111212 "
    property RG: String read FRG write FRG; // Número do RG, exemplo: "4545454   "
    property UnidadeFederacao: String read FUnidadeFederacao write FUnidadeFederacao; // UF do RG
    property DocumentoAdicional: String read FDocumentoAdicional write FDocumentoAdicional; // Número do Documento Adicional
    property TipoDocumentoAdicional: TDocumentosAdicionais read FTipoDocumentoAdicional write FTipoDocumentoAdicional; //Tipo do Docto Adicional cfme Anexo 1.9
    property Nome: String read FNome write FNome; // Nome
    property DataNascimento: TDate read FDataNascimento write FDataNascimento; // Data de Nascimento (DDMMAAAA)
    property Sexo: TTipoSexo read FSexo write FSexo; // Cfme Anexo 1.5
    property EstadoCivil: TTipoEstadoCivil read FEstadoCivil write FEstadoCivil; // Cfme Anexo 1.6
    property Naturalidade: String read FNaturalidade write FNaturalidade; // Naturalidade
    property UnidadeFederacaoNaturalidade: String read FUnidadeFederacaoNaturalidade write FUnidadeFederacaoNaturalidade; // UF da Naturalidade
    property NomePai: String read FNomePai write FNomePai; // Filiação Pai
    property NomeMae: String read FNomeMae write FNomeMae; // Filiação Mãe
    property NomeConjuge: String read FNomeConjuge write FNomeConjuge; // Nome do Conjuge
    property DataNascimentoConjuge: TDate read FDataNascimentoConjuge write FDataNascimentoConjuge; // Data de Nascimento do Conjuge
    property Endereco: String read FEndereco write FEndereco; // Rua da Residencia
    property Complemento: String read FComplemento write FComplemento; // Complemento do Endereco
    property Numero: Integer read FNumero write FNumero; // Número da Residëncia
    property Bairro: String read FBairro write FBairro; // Nome do Bairro
    property CEP: Integer read FCEP write FCEP; // CEP
    property Cidade: String read FCidade write FCidade; // Nome da Cidade
    property UnidadeFederativaEndereco: String read FUnidadeFederativaEndereco write FUnidadeFederativaEndereco; // UF do Endereço
    property DDD: String read FDDD write FDDD; // Código de Área do Telefone
    property Fone: String read FFone write FFone; // Número do Telefone
    property Email: String read FEmail write FEmail; // Endereço de E-mail
    property LocalDeTrabalho: String read FLocalDeTrabalho write FLocalDeTrabalho; // Cidade em que Trabalha
    property DDD_Celular: String read FDDD_Celular write FDDD_Celular; // Código DDD do Celular para envio de SMS
    property Celular: String read FCelular write FCelular; // Número do Celular para envio de SMS
    property PaisNacionalidade: TPaisNacionalidade read FPaisNacionalidade write FPaisNacionalidade; // País em que a Pessoa Nasceu - Cfme anexo 1.12
  end;

  TDadosRelativoDebito = class
  strict private
    FCodigoDoInformante: String;
    FDataCompra: TDate;
    FDataVencimento: TDate;
    FDataRegistro: TDate;
    FNumeroContrato: String;
    FNumeroParcela: Integer;
    FMoeda: TMoedaTipo;
    FValor: Double;
    FTipoLiquidacao: TLiquidacaoTipo;
    FMotivoDebito: TMotivoDebito;
    FValorBoleto: Double;
    FDataVencimentoBoleto: TDate;
    FPercentualMulta: Double;
    FPercentualJurosMensal: Double;
    FCobrarRegistroCancelamento: Boolean;
    FPracaProtesto: String;
    FValorProtesto: Double;
    FEspecieTitulo: String;
    FMensagemRetorno: String;

    procedure SetEspecieTitulo(const pEspecie: String);
  public
    constructor Create;

    property CodigoDoInformante: String read FCodigoDoInformante write FCodigoDoInformante; // Código do Sócio que está incluindo o registro
    property DataCompra: TDate read FDataCompra write FDataCompra; // Data da Compra (ddmmaaaa)
    property DataVencimento: TDate read FDataVencimento write FDataVencimento; // Dta do Vencimento (ddmmaaaa)
    property DataRegistro: TDate read FDataRegistro write FDataRegistro; // Data do Registro (ddmmaaaa)
    property NumeroContrato: String read FNumeroContrato write FNumeroContrato; // Número do Contrato, para compras parceladas informar codigo de registro da parcela
    property NumeroParcela: Integer read FNumeroParcela write FNumeroParcela; // Número da Parcela a ser registrada
    property Moeda: TMoedaTipo read FMoeda write FMoeda; // Cfome Anexo 1.8 (moedas)
    property Valor: Double read FValor write FValor; // Valor do Debito
    property TipoLiquidacao: TLiquidacaoTipo read FTipoLiquidacao write FTipoLiquidacao; // cfome anexo 1.4
    property MotivoDebito: TMotivoDebito read FMotivoDebito write FMotivoDebito; // Cfome anexo 1.7
    property ValorBoleto: Double read FValorBoleto write FValorBoleto; // Valor que deverá constar no boleto a ser impresso juntamente com a carta.
                                                                       // Se não for informado valor neste campo, o sistema utilizará o informado no campo
                                                                       // Valor do Registro
    property DataVencimentoBoleto: TDate read FDataVencimentoBoleto write FDataVencimentoBoleto; // Data de Vencimento do boleto. Na inclusão de registro com
                                                                                                 // cobrança, se não for informada data de vencimento para o
                                                                                                 // boleto, o sistema irá defini-lo para 30 dias após a data do
                                                                                                 // registro. Na geração de boleto de registro já executado o
                                                                                                 // vencimento não pode ser superior a 30 dias desta inclusão.
    property PercentualMulta: Double read FPercentualMulta write FPercentualMulta; // Percentual da multa (Considerar 2 casas decimais sem vírgula
                                                                                   // ou ponto decimal) Pode ser no máximo 2,00%. Neste Caso
                                                                                   // informar 0200. Se não utilizar informar zeros.
    property PercentualJurosMensal: Double read FPercentualJurosMensal write FPercentualJurosMensal; // Percentual de juros mensal para atualização da dívida.
                                                                                                     // (Considerar 2 casas decimais sem vírgula ou ponto decimal)
                                                                                                     // Pode ser no máximo 1,00% ao mês. Neste caso informar
                                                                                                     // 0100, Se não utilizar informar zeros
    property CobrarRegistroCancelamento: Boolean read FCobrarRegistroCancelamento write FCobrarRegistroCancelamento; // S/N
    property PracaProtesto: String read FPracaProtesto write FPracaProtesto; // Comarca para execução do protesto
    property ValorProtesto: Double read FValorProtesto write FValorProtesto; // Valor para protesto. Se não informado, será assumido o
                                                                             // conteudo do campo Valor
    property EspecieTitulo: String read FEspecieTitulo write SetEspecieTitulo; // Enviar: DM
    property MensagemRetorno: String read FMensagemRetorno write FMensagemRetorno;
  end;

  TDadosRelativosCheque = class
  private
    FCodigoDoInformante: String;
    FDataEmissao: TDate;
    FDataVencimento: TDate;
    FDataRegistro: TDate;
    FBanco: Integer;
    FAgencia: Integer;
    FContaCorrente: String;
    FDV_ContaCorrente: String;
    FMoeda: TMoedaTipo;
    FValor: Double;
    FTipoLiquidacao: TLiquidacaoTipo;
    FMotivoRegistro: TMotivoRegistroCheque;
    FCheque: Integer;
    FValorBoleto: Double;
    FVencimentoBoleto: TDate;
    FPercentualMulta: Double;
    FPercentualJurosMensal: double;
    FCobrarRegistroCancelamento: Boolean;
    FPracaProtesto: String;
    FValorProtesto: Double;
    FEspecieTitulo: String;
    FMensagemRetorno: String;

    procedure SetEspecieTitulo(const pEspecie: String);
  public
    constructor Create;

    property CodigoDoInformante: String read FCodigoDoInformante write FCodigoDoInformante; // Código do Sócio que está incluindo o registro
    property DataEmissao: TDate read FDataEmissao write FDataEmissao; // Data de Emissão do cheque (ddmmaaaa)
    property DataVencimento: TDate read FDataVencimento write FDataVencimento; // Data do Vencimento do Cheque (ddmmaaaa)
    property DataRegistro: TDate read FDataRegistro write FDataRegistro; // Data do Registro do Cheque (ddmmaaaa)
    property Banco: Integer read FBanco write FBanco; // Código do Banco
    property Agencia: Integer read FAgencia write FAgencia; // Número da Agência
    property ContaCorrente: String read FContaCorrente write FContaCorrente; // Número da Conta Corrente
    property DV_ContaCorrente: String read FDV_ContaCorrente write FDV_ContaCorrente; // Dígito Verificador da Conta Corrente
    property Moeda: TMoedaTipo read FMoeda write FMoeda; // Moeda utilizada
    property Valor: Double read FValor write FValor; // Valor do Cheque
    property TipoLiquidacao: TLiquidacaoTipo read FTipoLiquidacao write FTipoLiquidacao; // cfome anexo 1.4
    property MotivoRegistro: TMotivoRegistroCheque read FMotivoRegistro write FMotivoRegistro; // cfome anexo 1.11
    property Cheque: Integer read FCheque write FCheque; // Número do Cheque + DV
    property ValorBoleto: Double read FValorBoleto write FValorBoleto; // Valor que deverá constar no boleto a ser impresso
                                                                       // juntamente com a carta. Se não for informado valor
                                                                       // neste campo, o sistema utilizará o informado no valor
                                                                       // do registro
    property DataVencimentoBoleto: TDate read FVencimentoBoleto write FVencimentoBoleto; // Data de vencimento do boleto. Se não for informada
                                                                                         // data de vencimento para o boleto, o sistema irá defini-lo
                                                                                         // para 20 dias após a data do registro
    property PercentualMulta: Double read FPercentualMulta write FPercentualMulta; // Percentual da multa (Considerar 2 casas decimais sem
                                                                                   // vírgula ou ponto decimal) Pode ser no máximo 2,00%
                                                                                   // Neste caso informar 0200. Se não utilizar informar zeros
    property PercentualJurosMensal: double read FPercentualJurosMensal write FPercentualJurosMensal; // Percentual de juros mensal para atualização da dívida.
                                                                                                     // (Considerar 2 casas decimais sem vírgula ou ponto
                                                                                                     // decimal) Pode ser no máximo 1,00% ao mês. Neste
                                                                                                     // caso informar 0100, Se não utilizar informar zeros.
    property CobrarRegistroCancelamento: Boolean read FCobrarRegistroCancelamento write FCobrarRegistroCancelamento; // Cobrar Registro no Cancelamento S / N
    property PracaProtesto: String read FPracaProtesto write FPracaProtesto; // Comarca para execução do protesto
    property ValorProtesto: Double read FValorProtesto write FValorProtesto; // Valor para protesto. Se não informado, será assumido o
                                                                             // conteúdo do campo Valor
    property EspecieTitulo: String read FEspecieTitulo write SetEspecieTitulo; // Enviar: DM
    property MensagemRetorno: String read FMensagemRetorno write FMensagemRetorno;
  end;

  TRegistroSPC = class
  strict private
    FDevedor: TDevedor;
    FTipoRegistro: Integer;
    FTipoAtualizacao: TTipoAtualizacao;
    FDebito: TDadosRelativoDebito;

    procedure SetTipoRegistro(const pTipoRegistro: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    property TipoRegistro: Integer read FTipoRegistro write SetTipoRegistro; // 1
    property TipoAtualizacao: TTipoAtualizacao read FTipoAtualizacao write FTipoAtualizacao; // Em caso de Inclusao
                                                                                             // I -> Para incluir o registro no SPC
                                                                                             // P -> Para incluir o registro no SPC e Protestar
                                                                                             // T -> Para apenas protestar um registro já executado
                                                                                             // C -> Para incluir o registro no SPC e Gerar Boleto para Cobrança
                                                                                             // B -> Para Gerar Boleto para Cobrança de um registro já executado
                                                                                             // Em caso de Exclusão de Registro
                                                                                             // E -> Para excluir o registro
    property Devedor: TDevedor read FDevedor write FDevedor; // Dados do Devedor
    property Debito: TDadosRelativoDebito read FDebito write FDebito; // Dados Relativos ao DEBITO - SPC

    function GetLinha(const pNumeroLinha: integer): String;
    function SetLinha(const pLinha: String): TRegistroSPC;
  end;

  TRegistroCheque = class
  strict private
    FTipoRegistro: Integer;
    FTipoAtualizacao: TTipoAtualizacao;
    FDevedor: TDevedor;
    FDadosRelativosCheque: TDadosRelativosCheque;

    procedure setTipoRegistro(const pTipoRegistro: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    property TipoRegistro: Integer read FTipoRegistro write setTipoRegistro; // 2
    property TipoAtualizacao: TTipoAtualizacao read FTipoAtualizacao write FTipoAtualizacao; // Em caso de Inclusao
                                                                                             // I -> Para incluir o registro no SPC
                                                                                             // P -> Para incluir o registro no SPC e Protestar
                                                                                             // T -> Para apenas protestar um registro já executado
                                                                                             // C -> Para incluir o registro no SPC e Gerar Boleto para Cobrança
                                                                                             // B -> Para Gerar Boleto para Cobrança de um registro já executado
                                                                                             // Em caso de Exclusão de Registro
                                                                                             // E -> Para excluir o registro
    property Devedor: TDevedor read FDevedor write FDevedor; // Dados do Devedor
    property DadosCheque: TDadosRelativosCheque read FDadosRelativosCheque write FDadosRelativosCheque; // dados relativos ao cheque

    function GetLinha(const pNumeroLinha: integer): String;
    function SetLinha(const pLinha: String): TRegistroCheque;
  end;

implementation

{ TRegistroSPC }

constructor TRegistroSPC.Create;
begin
  SetTipoRegistro(1);

  FDevedor := TDevedor.Create;
  FDebito := TDadosRelativoDebito.Create;
end;

destructor TRegistroSPC.Destroy;
begin
  FDevedor.Free;
  FDebito.Free;

  inherited;
end;

function TRegistroSPC.GetLinha(const pNumeroLinha: integer): String;
var
  lErro: String;

begin
  result := '';

  try
    lErro := '';

    if (FDevedor.EstadoCivil = tecCasado)and(FDevedor.DataNascimentoConjuge = 0) then
    begin
      lErro := 'Informe a data de nascimento do conjuge!'+ #13 +
               'Nome Cliente: '+ FDevedor.CPF +'-'+ FDevedor.Nome;
      Abort;
    end;

    if (FTipoAtualizacao = taInclusao) then
    begin
      if (MotivoDebitoToStr(Debito.MotivoDebito) = '') then
      begin
        lErro := 'Informe o motivo do débito!';
        Abort;
      end;

      if (FDevedor.Numero = 0)and(Trim(FDevedor.Complemento) = '') then
      begin
        lErro := 'Quando cliente não possui número residencial o campo "complemento" é obrigatório!'+ #13 +
                 'Nome Cliente: '+ FDevedor.CPF +'-'+ FDevedor.Nome;
        Abort;
      end;
    end;

    if (FTipoAtualizacao <> taInclusao)and(MotivoDebitoToStr(Debito.MotivoDebito) <> '') then
    begin
      lErro := 'Motivo do débito não deve ser informado!';
      Abort;
    end;

    if (FTipoAtualizacao = taExcluirRegistro)and(LiquidacaoTipoToStr(Debito.TipoLiquidacao) = '') then
    begin
      lErro := 'Tipo de Liquidação deve ser informado!';
      Abort;
    end;

    if (FTipoAtualizacao <> taExcluirRegistro)and(LiquidacaoTipoToStr(Debito.TipoLiquidacao) <> '') then
    begin
      lErro := 'Tipo de Liquidação não deve ser informado!';
      Abort;
    end;

    Result := intToStr(FTipoRegistro) +
              AlinhaEsq(TipoMovimentoAtualizacaoToStr(FTipoAtualizacao), 1) +
              AlinhaEsq('', 30) +

              AlinhaEsq(FDevedor.CPF, 14) +
              AlinhaEsq(FDevedor.RG, 15) +
              AlinhaEsq(FDevedor.UnidadeFederacao, 2) +
              AlinhaEsq(FDevedor.DocumentoAdicional, 14) +
              AlinhaEsq(TipoDocumentoAdicionalToStr(FDevedor.TipoDocumentoAdicional), 4) +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.Nome)), 44) +
              FormatDateTime('ddmmyyyy', FDevedor.DataNascimento) +
              AlinhaEsq(TipoSexoToStr(FDevedor.Sexo), 1) +
              AlinhaEsq(TipoEstadoCivilToStr(FDevedor.EstadoCivil), 1) +
              AlinhaEsq(FDevedor.Naturalidade, 20) +
              AlinhaEsq(FDevedor.UnidadeFederacaoNaturalidade, 2) +' '+
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.NomePai)), 45) +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.NomeMae)), 45) +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.NomeConjuge)), 45) +
              ifThen(FDevedor.DataNascimentoConjuge > 0, FormatDateTime('ddmmyyyy', FDevedor.DataNascimentoConjuge), '00000000') +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.Endereco)), 50) +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.Complemento)), 100) +
              AlinhaDir(intToStr(FDevedor.Numero), 5, '0') +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.Bairro)), 20) +
              AlinhaDir(intToStr(FDevedor.CEP), 8, '0') +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.Cidade)), 20) +
              AlinhaEsq(FDevedor.UnidadeFederativaEndereco, 2) +
              AlinhaDir(SomenteNumeros(FDevedor.DDD), 3, '0') +
              AlinhaDir(SomenteNumeros(FDevedor.Fone), 15, '0') +
              AlinhaEsq(TiraAcentos(FDevedor.Email), 40) +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.LocalDeTrabalho)), 20) +
              AlinhaDir(SomenteNumeros(FDevedor.DDD_Celular), 2, '0') +
              AlinhaDir(SomenteNumeros(FDevedor.Celular), 9, '0') +
              AlinhaEsq('', 151) +
              AlinhaEsq(PaisNacionalidadeToStr(FDevedor.PaisNacionalidade), 3) +

              AlinhaEsq('', 367) +
              AlinhaEsq(Debito.CodigoDoInformante, 8) +
              FormatDateTime('ddmmyyyy', Debito.DataCompra) +
              FormatDateTime('ddmmyyyy', Debito.DataVencimento) +
              FormatDateTime('ddmmyyyy', Debito.DataRegistro) +
              AlinhaEsq(Debito.NumeroContrato, 16) +
              AlinhaDir(intToStr(Debito.NumeroParcela), 2, '0') +
              AlinhaEsq('', 2) +
              AlinhaEsq(MoedaTipoToStr(Debito.Moeda), 4) +
              AlinhaDir(AnsiReplaceStr(AnsiReplaceStr(FormatFloat('#,##0.00', Debito.Valor), ',', ''), '.', ''), 14, '0') +
              AlinhaEsq(LiquidacaoTipoToStr(Debito.TipoLiquidacao), 1) +
              AlinhaEsq(MotivoDebitoToStr(Debito.MotivoDebito), 1) +
              ' '+
              AlinhaDir(AnsiReplaceStr(AnsiReplaceStr(FormatFloat('#,##0.00', Debito.ValorBoleto), ',', ''), '.', ''), 14, '0') +
              AlinhaEsq(ifThen(Debito.DataVencimentoBoleto = 0, '', FormatDateTime('ddmmyyyy', Debito.DataVencimentoBoleto)), 8, '0') +
              AlinhaDir(AnsiReplaceStr(AnsiReplaceStr(FormatFloat('#,##0.00', Debito.PercentualMulta), ',', ''), '.', ''), 4, '0') +
              AlinhaDir(AnsiReplaceStr(AnsiReplaceStr(FormatFloat('#,##0.00', Debito.PercentualJurosMensal), ',', ''), '.', ''), 4, '0') +
              AlinhaEsq('', 73) +
              ifThen(Debito.CobrarRegistroCancelamento, STR_SIM, STR_NAO) +
              AlinhaEsq(Debito.PracaProtesto, 30) +
              AlinhaDir(AnsiReplaceStr(AnsiReplaceStr(FormatFloat('#,##0.00', Debito.ValorProtesto), ',', ''), '.', ''), 14, '0') +
              AlinhaEsq(Debito.EspecieTitulo, 2) +
              AlinhaEsq('', 554) +
              AlinhaDir(intToStr(pNumeroLinha), 7, '0') + // deve iniciar em 1
              AlinhaEsq('', 50);
  except
    on e:exception do
      raise Exception.Create(ifThen(lErro = '', E.Message, lErro));
  end;
end;

function TRegistroSPC.SetLinha(const pLinha: String): TRegistroSPC;
var
  lOK: Boolean;
  lTipoSexo: TTipoSexo;
  lTipoAtualizacao: TTipoAtualizacao;
  lTipoDocumentoAdicional: TDocumentosAdicionais;
  lEstadoCivil: TTipoEstadoCivil;
  lPaisNacionalidade: TPaisNacionalidade;
  lTipoLiquidacao: TLiquidacaoTipo;
  lMoeda: TMoedaTipo;
  lMotivoDebito: TMotivoDebito;

begin
  result := TRegistroSPC.Create;

  try
    if (Trim(pLinha) = '') or (Copy(pLinha, 1, 1) <> '1') then
      raise Exception.Create('Arquivo não possui um leiaute válido!');

    Result.FTipoRegistro := StrToIntDef(Copy(pLinha, 1, 1), -1);

    lTipoAtualizacao := StrToTipoMovimentoAtualizacao(lOK, Copy(pLinha, 2, 1));

    if not lOK then
      raise Exception.Create('Tipo de Atualização não encontrado!');

    Result.FTipoAtualizacao := lTipoAtualizacao;

    with Result.FDevedor do
    begin
      CPF := Trim(Copy(pLinha, 33, 14));
      RG := Trim(Copy(pLinha, 47, 15));
      UnidadeFederacao := Trim(Copy(pLinha, 62, 2));
      DocumentoAdicional := Trim(Copy(pLinha, 64, 14));

      lTipoDocumentoAdicional := StrToTipoDocumentoAdicional(lOK, Trim(Copy(pLinha, 78, 4)));

      if not lOK then
        raise Exception.Create('Tipo de documento adicional não encontrado!');

      TipoDocumentoAdicional := lTipoDocumentoAdicional;
      Nome := Trim(Copy(pLinha, 82, 44));
      DataNascimento := StrToDateDef(copy(pLinha, 126, 2) +'/'+
                                     copy(pLinha, 128, 2) +'/'+
                                     copy(pLinha, 130, 4), 0);

      lTipoSexo := StrToTipoSexo(lOK, Trim(Copy(pLinha, 134, 1)));

      if not lOK then
        raise Exception.Create('Tipo de sexo não encontrado!');

      Sexo := lTipoSexo;

      lEstadoCivil := StrToTipoEstadoCivil(lOK, Trim(Copy(pLinha, 135, 1)));

      if not lOK then
        raise Exception.Create('Estado civil do cliente não encontrado!');

      EstadoCivil := lEstadoCivil;
      Naturalidade := Trim(Copy(pLinha, 136, 20));
      UnidadeFederacaoNaturalidade := Trim(Copy(pLinha, 156, 2));
      NomePai := Trim(Copy(pLinha, 159, 45));
      NomeMae := Trim(Copy(pLinha, 204, 45));
      NomeConjuge := Trim(Copy(pLinha, 249, 45));
      DataNascimentoConjuge := StrToDateDef(copy(pLinha, 294, 2) +'/'+
                                            copy(pLinha, 296, 2) +'/'+
                                            copy(pLinha, 298, 4), 0);
      Endereco := Trim(Copy(pLinha, 302, 50));
      Complemento := Trim(Copy(pLinha, 352, 100));
      Numero := StrToIntDef(Trim(Copy(pLinha, 452, 5)), 0);
      Bairro := Trim(Copy(pLinha, 457, 20));
      CEP := StrToIntDef(Trim(Copy(pLinha, 477, 8)), 0);
      Cidade := Trim(Copy(pLinha, 485, 20));
      UnidadeFederativaEndereco := Trim(Copy(pLinha, 505, 2));
      DDD := Trim(Copy(pLinha, 507, 3));
      Fone := Trim(Copy(pLinha, 510, 15));
      Email := Trim(Copy(pLinha, 525, 40));
      LocalDeTrabalho := Trim(Copy(pLinha, 565, 20));
      DDD_Celular := Trim(Copy(pLinha, 585, 2));
      Celular := Trim(Copy(pLinha, 587, 9));

      lPaisNacionalidade := StrToPaisNacionalidade(lOK, Trim(Copy(pLinha, 747, 3)));

      if not lOK then
        raise Exception.Create('Nacionalidade do cliente não encontrada!');

      PaisNacionalidade := lPaisNacionalidade;
    end;

    with Result.FDebito do
    begin
      CodigoDoInformante := Trim(Copy(pLinha, 1117, 8));
      DataCompra := StrToDateDef(Copy(pLinha, 1125, 2) +'/'+
                                 Copy(pLinha, 1127, 2) +'/'+
                                 Copy(pLinha, 1129, 4), 0);
      DataVencimento := StrToDateDef(Copy(pLinha, 1133, 2) +'/'+
                                     Copy(pLinha, 1135, 2) +'/'+
                                     Copy(pLinha, 1137, 4), 0);
      DataRegistro := StrToDateDef(Copy(pLinha, 1141, 2) +'/'+
                                   Copy(pLinha, 1143, 2) +'/'+
                                   Copy(pLinha, 1145, 4), 0);
      NumeroContrato := Trim(Copy(pLinha, 1149, 16));
      NumeroParcela := StrToIntDef(Trim(Copy(pLinha, 1165, 2)), 0);

      lMoeda := StrToMoedaTipo(lOK, Trim(Copy(pLinha, 1169, 4)));

      if not lOK then
        raise Exception.Create('Tipo de moeda não encontrado!');

      Moeda := lMoeda;
      Valor := StrToFloatDef(Trim(Copy(pLinha, 1173, 12)) +','+ Trim(Copy(pLinha, 1185, 2)), 0);

      lTipoLiquidacao := StrToLiquidacaoTipo(lOK, Trim(Copy(pLinha, 1187, 1)));

      if not lOK then
        raise Exception.Create('Tipo de liquidação não encontrado!');

      TipoLiquidacao := lTipoLiquidacao;
      MotivoDebito := mdNaoInformado;

      if lTipoAtualizacao = taInclusao then
      begin
        lMotivoDebito := StrToMotivoDebito(lOK, Copy(pLinha, 1188, 1));

        if not lOK then
          raise Exception.Create('Motivo do débito não encontrado!');

        MotivoDebito := lMotivoDebito;
      end;

      ValorBoleto := StrToFloatDef(Trim(Copy(pLinha, 1190, 12)) +','+ Trim(Copy(pLinha, 1202, 2)), 0);
      DataVencimentoBoleto := StrToDateDef(Copy(pLinha, 1204, 2) +'/'+
                                           Copy(pLinha, 1206, 2) +'/'+
                                           Copy(pLinha, 1208, 4), 0);
      PercentualMulta := StrToFloatDef(Trim(Copy(pLinha, 1212, 2)) +','+ Trim(Copy(pLinha, 1214, 2)), 0);
      PercentualJurosMensal := StrToFloatDef(Trim(Copy(pLinha, 1216, 2)) +','+ Trim(Copy(pLinha, 1218, 2)), 0);
      CobrarRegistroCancelamento := Trim(Copy(pLinha, 1293, 1)) = STR_SIM;
      PracaProtesto := Trim(Copy(pLinha, 1294, 30));
      ValorProtesto := StrToFloatDef(Trim(Copy(pLinha, 1324, 12)) +','+ Trim(Copy(pLinha, 1236, 2)), 0);
      EspecieTitulo := Trim(Copy(pLinha, 1338, 2));
      MensagemRetorno := Trim(copy(pLinha, 1901, 50));
    end;

  except
    on e: exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TRegistroSPC.SetTipoRegistro(const pTipoRegistro: Integer);
begin
  FTipoRegistro := pTipoRegistro;
end;

{ TDadosRelativoDebito }

constructor TDadosRelativoDebito.Create;
begin
  FMensagemRetorno := '';
//  SetEspecieTitulo(STR_ESPECIE_TITULO);
end;

procedure TDadosRelativoDebito.SetEspecieTitulo(const pEspecie: String);
begin
  FEspecieTitulo := pEspecie;
end;

{ TRegistroCheque }

constructor TRegistroCheque.Create;
begin
  setTipoRegistro(2);

  FDevedor := TDevedor.Create;
  FDadosRelativosCheque := TDadosRelativosCheque.Create;
end;

destructor TRegistroCheque.Destroy;
begin
  FDevedor.Free;
  FDadosRelativosCheque.Free;

  inherited;
end;

function TRegistroCheque.getLinha(const pNumeroLinha: integer): String;
var
  lErro: String;

begin
  result := '';
  lErro  := '';

  try
    if (FDevedor.EstadoCivil = tecCasado)and(FDevedor.DataNascimentoConjuge = 0) then
    begin
      lErro := 'Informe a data de nascimento do conjuge!'+ #13 +
               'Nome Cliente: '+ FDevedor.Nome;
      Abort;
    end;

    if DadosCheque.Banco = 0 then
    begin
      lErro := 'Banco do cheque não informado!'+ #13 +
               'Número do Cheque: '+ intToStr(DadosCheque.Cheque) + #13 +
               'Nome Cliente: '+ FDevedor.Nome;
      Abort;
    end;

    if DadosCheque.Cheque = 0 then
    begin
      lErro := 'Número do cheque não informado!'+ #13 +
               'Nome Cliente: '+ FDevedor.Nome;
      Abort;
    end;

    if DadosCheque.Agencia = 0 then
    begin
      lErro := 'Agência do cheque não informado!'+ #13 +
               'Número do Cheque: '+ intToStr(DadosCheque.Cheque) + #13 +
               'Nome Cliente: '+ FDevedor.Nome;
      Abort;
    end;

    if Trim(DadosCheque.ContaCorrente) = '' then
    begin
      lErro := 'Conta Corrente do cheque não informado!'+ #13 +
               'Número do Cheque: '+ intToStr(DadosCheque.Cheque) + #13 +
               'Nome Cliente: '+ FDevedor.Nome;
      Abort;
    end;

    if DadosCheque.DataVencimento = 0 then
    begin
      lErro := 'Data de Vencimento do cheque não informada!'+ #13 +
               'Número do Cheque: '+ intToStr(DadosCheque.Cheque) + #13 +
               'Nome Cliente: '+ FDevedor.Nome;
      Abort;
    end;

    if RoundTo(DadosCheque.Valor, -2) = 0 then
    begin
      lErro := 'Valor do cheque não informado!'+ #13 +
               'Número do Cheque: '+ intToStr(DadosCheque.Cheque) + #13 +
               'Nome Cliente: '+ FDevedor.Nome;
      Abort;
    end;

    if (FTipoAtualizacao = taInclusao) then
    begin
      if (MotivoRegistroChequeToStr(DadosCheque.MotivoRegistro) = '') then
      begin
        lErro := 'Informe o motivo do registro!';
        Abort;
      end;

      if (FDevedor.Numero = 0)and(Trim(FDevedor.Complemento) = '') then
      begin
        lErro := 'Quando cliente não possui número residencial o campo "complemento" é obrigatório!'+ #13 +
                 'Nome Cliente: '+ FDevedor.Nome;
        Abort;
      end;
    end;

    if (FTipoAtualizacao <> taInclusao)and(MotivoRegistroChequeToStr(DadosCheque.MotivoRegistro) <> '') then
    begin
      lErro := 'Motivo do registro não deve ser informado!';
      Abort;
    end;

    if (FTipoAtualizacao = taExcluirRegistro)and(LiquidacaoTipoToStr(DadosCheque.TipoLiquidacao) = '') then
    begin
      lErro := 'Tipo de Liquidação deve ser informado!';
      Abort;
    end;

    if (FTipoAtualizacao <> taExcluirRegistro)and(LiquidacaoTipoToStr(DadosCheque.TipoLiquidacao) <> '') then
    begin
      lErro := 'Tipo de Liquidação não deve ser informado!';
      Abort;
    end;

    result := intToStr(FTipoRegistro) +
              AlinhaEsq(TipoMovimentoAtualizacaoToStr(FTipoAtualizacao), 1) +
              AlinhaEsq('', 30) +

              AlinhaEsq(FDevedor.CPF, 14) +
              AlinhaEsq(FDevedor.RG, 15) +
              AlinhaEsq(FDevedor.UnidadeFederacao, 2) +
              AlinhaEsq(FDevedor.DocumentoAdicional, 14) +
              AlinhaEsq(TipoDocumentoAdicionalToStr(FDevedor.TipoDocumentoAdicional), 4) +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.Nome)), 44) +
              FormatDateTime('ddmmyyyy', FDevedor.DataNascimento) +
              AlinhaEsq(TipoSexoToStr(FDevedor.Sexo), 1) +
              AlinhaEsq(TipoEstadoCivilToStr(FDevedor.EstadoCivil), 1) +
              AlinhaEsq(FDevedor.Naturalidade, 20) +
              AlinhaEsq(FDevedor.UnidadeFederacaoNaturalidade, 2) +' '+
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.NomePai)), 45) +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.NomeMae)), 45) +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.NomeConjuge)), 45) +
              ifThen(FDevedor.DataNascimentoConjuge > 0, FormatDateTime('ddmmyyyy', FDevedor.DataNascimentoConjuge), '00000000') +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.Endereco)), 50) +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.Complemento)), 100) +
              AlinhaDir(intToStr(FDevedor.Numero), 5, '0') +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.Bairro)), 20) +
              AlinhaDir(intToStr(FDevedor.CEP), 8, '0') +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.Cidade)), 20) +
              AlinhaEsq(FDevedor.UnidadeFederativaEndereco, 2) +
              AlinhaDir(SomenteNumeros(FDevedor.DDD), 3, '0') +
              AlinhaDir(SomenteNumeros(FDevedor.Fone), 15, '0') +
              AlinhaEsq(TiraAcentos(FDevedor.Email), 40) +
              AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDevedor.LocalDeTrabalho)), 20) +
              AlinhaEsq(SomenteNumeros(FDevedor.DDD_Celular), 2, '0') +
              AlinhaDir(SomenteNumeros(FDevedor.Celular), 9, '0') +
              AlinhaEsq('', 151) +
              AlinhaEsq(PaisNacionalidadeToStr(FDevedor.PaisNacionalidade), 3) +
              AlinhaEsq('', 367) +

              AlinhaEsq(DadosCheque.CodigoDoInformante, 8) +
              FormatDateTime('ddmmyyyy', DadosCheque.DataEmissao) +
              FormatDateTime('ddmmyyyy', DadosCheque.DataVencimento) +
              FormatDateTime('ddmmyyyy', DadosCheque.DataRegistro) +
              AlinhaDir(intToStr(DadosCheque.Banco), 3, '0') +
              AlinhaDir(intToStr(DadosCheque.Agencia), 4, '0') +
              AlinhaDir(DadosCheque.ContaCorrente, 9, '0') +
              AlinhaEsq(DadosCheque.DV_ContaCorrente, 1) +
              AlinhaEsq('', 3) +
              AlinhaEsq(MoedaTipoToStr(DadosCheque.Moeda), 4) +
              AlinhaDir(AnsiReplaceStr(AnsiReplaceStr(FormatFloat('#,##0.00', DadosCheque.Valor), ',', ''), '.', ''), 14, '0') +
              AlinhaEsq(LiquidacaoTipoToStr(DadosCheque.TipoLiquidacao), 1) +
              AlinhaEsq(MotivoRegistroChequeToStr(DadosCheque.MotivoRegistro), 2) +
              AlinhaDir(intToStr(DadosCheque.Cheque), 7, '0') +
              ' '+
              AlinhaDir(AnsiReplaceStr(AnsiReplaceStr(FormatFloat('#,##0.00', DadosCheque.ValorBoleto), ',', ''), '.', ''), 14, '0') +
              AlinhaEsq(ifThen(DadosCheque.DataVencimentoBoleto = 0, '', FormatDateTime('ddmmyyyy', DadosCheque.DataVencimentoBoleto)), 8, '0') +
              AlinhaDir(ifthen(DadosCheque.ValorBoleto = 0, '0', AnsiReplaceStr(AnsiReplaceStr(FormatFloat('#,##0.00', DadosCheque.PercentualMulta), ',', ''), '.', '')), 4, '0') +
              AlinhaDir(ifthen(DadosCheque.ValorBoleto = 0, '0', AnsiReplaceStr(AnsiReplaceStr(FormatFloat('#,##0.00', DadosCheque.PercentualJurosMensal), ',', ''), '.', '')), 4, '0') +
              AlinhaEsq('', 23) +
              AlinhaEsq(ifThen(DadosCheque.CobrarRegistroCancelamento, STR_SIM, STR_NAO), 1) +
              AlinhaEsq(''{DadosCheque.PracaProtesto}, 30) +
              AlinhaDir(AnsiReplaceStr(AnsiReplaceStr(FormatFloat('#,##0.00', DadosCheque.ValorProtesto), ',', ''), '.', ''), 14, '0') +
              AlinhaEsq(DadosCheque.EspecieTitulo, 2) +
              AlinhaEsq('', 596) +
              AlinhaDir(intToStr(pNumeroLinha), 7, '0') +
              AlinhaEsq('', 50);
  except
    on e:exception do
      raise Exception.Create(ifThen(lErro = '', E.Message, lErro));
  end;
end;

function TRegistroCheque.SetLinha(const pLinha: String): TRegistroCheque;
var
  lOK: Boolean;
  lTipoSexo: TTipoSexo;
  lTipoAtualizacao: TTipoAtualizacao;
  lTipoDocumentoAdicional: TDocumentosAdicionais;
  lEstadoCivil: TTipoEstadoCivil;
  lPaisNacionalidade: TPaisNacionalidade;
  lTipoLiquidacao: TLiquidacaoTipo;
  lMoeda: TMoedaTipo;
  lMotivoRegistro: TMotivoRegistroCheque;

begin
  Result := TRegistroCheque.Create;
  try
    if (Trim(pLinha) = '') or (Copy(pLinha, 1, 1) <> '2') then
      raise Exception.Create('Arquivo não possui um leiaute válido!');

    Result.FTipoRegistro := StrToIntDef(Copy(pLinha, 1, 1), -1);

    lTipoAtualizacao := StrToTipoMovimentoAtualizacao(lOK, Copy(pLinha, 2, 1));

    if not lOK then
      raise Exception.Create('Tipo de Atualização não encontrado!');

    Result.FTipoAtualizacao := lTipoAtualizacao;

    with Result.FDevedor do
    begin
      CPF := Trim(Copy(pLinha, 33, 14));
      RG := Trim(Copy(pLinha, 47, 15));
      UnidadeFederacao := Trim(Copy(pLinha, 62, 2));
      DocumentoAdicional := Trim(Copy(pLinha, 64, 14));

      lTipoDocumentoAdicional := StrToTipoDocumentoAdicional(lOK, Trim(Copy(pLinha, 78, 4)));

      if not lOK then
        raise Exception.Create('Tipo de documento adicional não encontrado!');

      TipoDocumentoAdicional := lTipoDocumentoAdicional;
      Nome := Trim(Copy(pLinha, 82, 44));
      DataNascimento := StrToDateDef(copy(pLinha, 126, 2) +'/'+
                                     copy(pLinha, 128, 2) +'/'+
                                     copy(pLinha, 130, 4), 0);

      lTipoSexo := StrToTipoSexo(lOK, Trim(Copy(pLinha, 134, 1)));

      if not lOK then
        raise Exception.Create('Tipo de sexo não encontrado!');

      Sexo := lTipoSexo;

      lEstadoCivil := StrToTipoEstadoCivil(lOK, Trim(Copy(pLinha, 135, 1)));

      if not lOK then
        raise Exception.Create('Estado civil do cliente não encontrado!');

      EstadoCivil := lEstadoCivil;
      Naturalidade := Trim(Copy(pLinha, 136, 20));
      UnidadeFederacaoNaturalidade := Trim(Copy(pLinha, 156, 2));
      NomePai := Trim(Copy(pLinha, 159, 45));
      NomeMae := Trim(Copy(pLinha, 204, 45));
      NomeConjuge := Trim(Copy(pLinha, 249, 45));
      DataNascimentoConjuge := StrToDateDef(copy(pLinha, 294, 2) +'/'+
                                            copy(pLinha, 296, 2) +'/'+
                                            copy(pLinha, 298, 4), 0);
      Endereco := Trim(Copy(pLinha, 302, 50));
      Complemento := Trim(Copy(pLinha, 352, 100));
      Numero := StrToIntDef(Trim(Copy(pLinha, 452, 5)), 0);
      Bairro := Trim(Copy(pLinha, 457, 20));
      CEP := StrToIntDef(Trim(Copy(pLinha, 477, 8)), 0);
      Cidade := Trim(Copy(pLinha, 485, 20));
      UnidadeFederativaEndereco := Trim(Copy(pLinha, 505, 2));
      DDD := Trim(Copy(pLinha, 507, 3));
      Fone := Trim(Copy(pLinha, 510, 15));
      Email := Trim(Copy(pLinha, 525, 40));
      LocalDeTrabalho := Trim(Copy(pLinha, 565, 20));
      DDD_Celular := Trim(Copy(pLinha, 585, 2));
      Celular := Trim(Copy(pLinha, 587, 9));

      lPaisNacionalidade := StrToPaisNacionalidade(lOK, Trim(Copy(pLinha, 747, 3)));

      if not lOK then
        raise Exception.Create('Nacionalidade do cliente não encontrada!');

      PaisNacionalidade := lPaisNacionalidade;
    end;

    with Result.DadosCheque do
    begin
      CodigoDoInformante := Trim(Copy(pLinha, 1117, 8));

      DataEmissao := StrToDateDef(Copy(pLinha, 1125, 2) +'/'+
                                  Copy(pLinha, 1127, 2) +'/'+
                                  Copy(pLinha, 1129, 4), 0);

      DataVencimento := StrToDateDef(Copy(pLinha, 1133, 2) +'/'+
                                     Copy(pLinha, 1135, 2) +'/'+
                                     Copy(pLinha, 1137, 4), 0);

      DataRegistro := StrToDateDef(Copy(pLinha, 1141, 2) +'/'+
                                   Copy(pLinha, 1143, 2) +'/'+
                                   Copy(pLinha, 1145, 4), 0);

      Banco := StrToIntDef(Trim(Copy(pLinha, 1149, 3)), 0);
      Agencia := StrToIntDef(Trim(Copy(pLinha, 1152, 4)), 0);
      ContaCorrente := Trim(Copy(pLinha, 1156, 9));
      DV_ContaCorrente := Trim(Copy(pLinha, 1165, 1));

      lMoeda := StrToMoedaTipo(lOK, Trim(Copy(pLinha, 1169, 4)));

      if not lOK then
        raise Exception.Create('Tipo de moeda não encontrado!');

      Moeda := lMoeda;
      Valor := StrToFloatDef(Trim(Copy(pLinha, 1173, 12)) +','+ Trim(Copy(pLinha, 1185, 2)), 0);

      lTipoLiquidacao := StrToLiquidacaoTipo(lOK, Trim(Copy(pLinha, 1187, 1)));

      if not lOK then
        raise Exception.Create('Tipo de liquidação não encontrado!');

      TipoLiquidacao := lTipoLiquidacao;
      MotivoRegistro := mrcNaoInformado;

      if lTipoAtualizacao = taInclusao then
      begin
        lMotivoRegistro := StrToMotivoRegistroCheque(lOK, Copy(pLinha, 1188, 2));

        if not lOK then
          raise Exception.Create('Motivo do débito não encontrado!');

        MotivoRegistro := lMotivoRegistro;
      end;

      Cheque := StrToIntDef(Trim(Copy(pLinha, 1190, 7)), 0);
      ValorBoleto := StrToFloatDef(Trim(Copy(pLinha, 1198, 12)) +','+ Trim(Copy(pLinha, 1210, 2)), 0);

      DataVencimentoBoleto := StrToDateDef(Copy(pLinha, 1212, 2) +'/'+
                                           Copy(pLinha, 1214, 2) +'/'+
                                           Copy(pLinha, 1216, 4), 0);

      PercentualMulta := StrToFloatDef(Trim(Copy(pLinha, 1220, 2)) +','+ Trim(Copy(pLinha, 1222, 2)), 0);
      PercentualJurosMensal := StrToFloatDef(Trim(Copy(pLinha, 1224, 2)) +','+ Trim(Copy(pLinha, 1226, 2)), 0);
      CobrarRegistroCancelamento := Trim(Copy(pLinha, 1251, 1)) = STR_SIM;
      PracaProtesto := Trim(Copy(pLinha, 1252, 30));
      ValorProtesto := StrToFloatDef(Trim(Copy(pLinha, 1282, 12)) +','+ Trim(Copy(pLinha, 1294, 2)), 0);
      EspecieTitulo := Trim(Copy(pLinha, 1296, 2));
      MensagemRetorno := trim(copy(pLinha, 1901, 50));
    end;

  except
    on e:Exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TRegistroCheque.setTipoRegistro(const pTipoRegistro: Integer);
begin
  FTipoRegistro := pTipoRegistro;
end;

{ TDadosRelativosCheque }

constructor TDadosRelativosCheque.Create;
begin
  FMensagemRetorno := '';
//  SetEspecieTitulo(STR_ESPECIE_TITULO);
end;

procedure TDadosRelativosCheque.SetEspecieTitulo(const pEspecie: String);
begin
  FEspecieTitulo := pEspecie;
end;

end.
