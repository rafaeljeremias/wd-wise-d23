unit HeaderFCDL;

interface

uses SysUtils, StrUtils;

const
  STR_TIPO_REMESSA = 'REMESSA';
  STR_TIPO_RETORNO = 'RETORNO';
  STR_VERSAO_LAYOUT = 'V001004';

type
  TTipoHeader = (thRemessa, thRetorno);

  THeaderFCDL = class
  strict private
    FTipoHeader: TTipoHeader;
    FTipoRegistro: Integer;
    FNumeroRemessa: Integer;
    FData: TDate;
    FDescricaoDestinatario: String;
    FDASPC_Destinatario: String;
    FDescricaoRemetente: String;
    FDASCP_Remetente: String;
    FNomeOperador: String;
    FDataInicial: TDate;
    FDataFinal: TDate;
    FHoraInicial: TTime;
    FHoraFinal: TTime;
    FUltimaRemessaLida: Int64;

    procedure setTipoRegistro(const pTipoRegistro: integer);
  public
    constructor Create(const pTipoHeader: TTipoHeader);

    property TipoRegistro: Integer read FTipoRegistro write setTipoRegistro; // "0"
    property Remessa: Integer read FNumeroRemessa write FNumeroRemessa; // Número da Remessa
    property Data: TDate read FData write FData; // Data do Movimento no formato DDMMAAAA
    property Destinatario: String read FDescricaoDestinatario write FDescricaoDestinatario; // Identificação do Destinatário
    property DASPC_Destinatario: String read FDASPC_Destinatario write FDASPC_Destinatario; // DASPC do Destinatário
    property Remetente: String read FDescricaoRemetente write FDescricaoRemetente; // Identificação do Remetente ou Associado
    property DASCP_Remetente: String read FDASCP_Remetente write FDASCP_Remetente; // DASPC do Remetente ou Código do Associado
    property Operador: String read FNomeOperador write FNomeOperador; // Fornecido pelo CDL Local.
    property DataInicial: TDate read FDataInicial write FDataInicial; // Data Inicial da Atualização (DDMMAAAA)
    property DataFinal: TDate read FDataFinal write FDataFinal; // Data Final da Atualização (DDMMAAAA)
    property HoraInicial: TTime read FHoraInicial write FHoraInicial; // Hora inicial da Atualização (HHMMSSMM)
    property HoraFinal: TTime read FHoraFinal write FHoraFinal; // Hora Final da Atulização (HHMMSSMM)
    property UltimaRemessaLida: Int64 read FUltimaRemessaLida write FUltimaRemessaLida; // Última sequencia de remessa processada

    function GetLinha:String;
    function SetLinha(const pLinha: String): Boolean;
  end;


implementation

uses FuncoesFCDL;

{ THeader }

constructor THeaderFCDL.Create(const pTipoHeader: TTipoHeader);
begin
  FData := Date;
  setTipoRegistro(0);
  FTipoHeader := pTipoHeader;
end;

function THeaderFCDL.GetLinha: String;
begin
  result := intToStr(FTipoRegistro) +
            ifThen(FTipoHeader = thRemessa, STR_TIPO_REMESSA, STR_TIPO_RETORNO) +
            AlinhaDir(intToStr(FNumeroRemessa), 7, '0') +
            FormatDateTime('ddmmyyyy', Data) +
            AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDescricaoDestinatario)), 40) +
            ALinhaEsq(FDASPC_Destinatario, 8) +
            AlinhaEsq(TiraCaracteresEspeciais(TiraAcentos(FDescricaoRemetente)), 40) +
            AlinhaDir(FDASCP_Remetente, 8, '0') +
            AlinhaEsq(FNomeOperador, 8) +
            AlinhaEsq(ifThen(FDataInicial = 0, '0', FormatDateTime('ddmmyyyy', FDataInicial)), 8, '0') +
            AlinhaEsq(ifThen(FDataFinal = 0, '0', FormatDateTime('ddmmyyyy', FDataFinal)), 8, '0') +
            FormatDateTime('hhnnsszz', FHoraInicial) +
            FormatDateTime('hhnnsszz', FHoraFinal) +' '+
            STR_VERSAO_LAYOUT +
            AlinhaEsq('', 1719) +
            AlinhaDir(intToStr(FUltimaRemessaLida), 7, '0') +
            AlinhaEsq('0', 7, '0') +
            AlinhaEsq('', 50);
end;

function THeaderFCDL.SetLinha(const pLinha: String): Boolean;
begin
  try
    if (Trim(pLinha) = '') or (Copy(pLinha, 1, 1) <> '0') or (Copy(pLinha, 2, 7) <> STR_TIPO_RETORNO) then
      raise Exception.Create('Arquivo não possui um leiaute válido!');

    FTipoRegistro := StrToIntDef(Copy(pLinha, 1, 1), -1);
    FTipoHeader := thRetorno;
    FNumeroRemessa := StrToIntDef(Copy(pLinha, 9, 7), -1);
    Data := StrToDateDef(copy(pLinha, 16, 2) +'/'+ copy(pLinha, 18, 2) +'/'+ copy(pLinha, 20, 4), 0);
    FDescricaoDestinatario := Copy(pLinha, 24, 40);
    FDASPC_Destinatario := Copy(pLinha, 64, 8);
    FDescricaoRemetente := Copy(pLinha, 72, 40);
    FDASCP_Remetente := Copy(pLinha, 112, 8);
    FNomeOperador := Copy(pLinha, 120, 8);
    FDataInicial := StrToDateDef(copy(pLinha, 128, 2) +'/'+ copy(pLinha, 130, 2) +'/'+ copy(pLinha, 132, 4), 0);
    FDataFinal := StrToDateDef(copy(pLinha, 136, 2) +'/'+ copy(pLinha, 138, 2) +'/'+ copy(pLinha, 140, 4), 0);
    FHoraInicial := StrToTimeDef(copy(pLinha, 144, 2) +':'+ copy(pLinha, 146, 2) +':'+
                                 copy(pLinha, 148, 2) +' '+ copy(pLinha, 150, 2), 0);
    FHoraFinal := StrToTimeDef(copy(pLinha, 152, 2) +':'+ copy(pLinha, 154, 2) +':'+
                               copy(pLinha, 156, 2) +' '+ copy(pLinha, 158, 2), 0);
    FUltimaRemessaLida := StrToIntDef(copy(pLinha, 1887, 7), 0);

    Result := True;

  except
    on e: exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure THeaderFCDL.setTipoRegistro(const pTipoRegistro: integer);
begin
  FTipoRegistro := pTipoRegistro;
end;

end.
