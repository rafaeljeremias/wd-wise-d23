unit TraillerFCDL;

interface

uses FuncoesFCDL;

type
  TTraillerFCDL = class
  strict private
    FTipoRegistro: Integer;

    procedure SetTipoRegistro(const pTipoRegistro: Integer);
  strict private
    FData: TDate;
    FInclusoesOK: Integer;
    FInclusoesErro: Integer;
    FExclusaoOK: Integer;
    FExclusaoErro: Integer;
  public
    constructor Create;

    property TipoRegistro: Integer read FTipoRegistro write SetTipoRegistro; // 9
    property Data: TDate read FData write FData; // Data do movimento (ddmmaaaa)
    property InclusoesOK: Integer read FInclusoesOK write FInclusoesOK; // Total de Inclusões aceitas
    property InclusoesErro: Integer read FInclusoesErro write FInclusoesErro; // total de inclusões rejeitadas
    property ExclusaoOK: Integer read FExclusaoOK write FExclusaoOK; // total de exclusões aceitas
    property ExclusaoErro: Integer read FExclusaoErro write FExclusaoErro;

    function GetLinha(const pLinha: Integer): String;
    function SetLinha(const pLinha: String): Boolean;
  end;

implementation

Uses SysUtils;

{ TTraillerFCDL }

constructor TTraillerFCDL.Create;
begin
  SetTipoRegistro(9);
end;

function TTraillerFCDL.GetLinha(const pLinha: Integer): String;
begin
  try
    result := intToStr(FTipoRegistro) +
              FormatDateTime('ddmmyyyy', FData) +
              AlinhaEsq('', 30) +
              AlinhaDir(intToStr(FInclusoesOK), 5, '0') +
              AlinhaDir(intToStr(FInclusoesErro), 5, '0') +
              AlinhaDir(intToStr(FExclusaoOK), 5, '0') +
              AlinhaDir(intToStr(FExclusaoErro), 5, '0') +
              AlinhaEsq('', 1834) +
              AlinhaDir(intToStr(pLinha), 7, '0') +
              AlinhaEsq('', 50);
  except
    on e: exception do
      raise Exception.Create(E.Message);
  end;
end;

function TTraillerFCDL.SetLinha(const pLinha: String): Boolean;
begin
  try
    if (Trim(pLinha) = '') or (Copy(pLinha, 1, 1) <> '9') then
      raise Exception.Create('Arquivo não possui um leiaute válido!');

    FTipoRegistro := StrToIntDef(Trim(Copy(pLinha, 1, 1)), -1);

    FData := StrToDateDef(Copy(pLinha, 2, 2) +'/'+
                          Copy(pLinha, 4, 2) +'/'+
                          Copy(pLinha, 6, 4), 0);

    FInclusoesOK := StrToIntDef(Trim(Copy(pLinha, 40, 5)), 0);
    FInclusoesErro := StrToIntDef(Trim(Copy(pLinha, 45, 5)), 0);
    FExclusaoOK := StrToIntDef(Trim(Copy(pLinha, 50, 5)), 0);
    FExclusaoErro := StrToIntDef(Trim(Copy(pLinha, 55, 5)), 0);

    Result := True;
  except
    on e: exception do
      raise Exception.Create(E.Message);
  end;
end;

procedure TTraillerFCDL.SetTipoRegistro(const pTipoRegistro: Integer);
begin
  self.FTipoRegistro := pTipoRegistro;
end;

end.
