unit ArquivoRegistroFCDL;

interface

uses HeaderFCDL, SysUtils, Generics.Collections, RegistroSPC, TraillerFCDL, Forms,
     Util.Constantes, SqlExpr, Math, IdBaseComponent, IdComponent, IdTCPConnection,
     IdTCPClient, IdExplicitTLSClientServerBase, IdFTP, IdFTPCommon, Classes, Windows,
     WiseUnit, StrUtils;

type
  TRegistroFCDL = class
  strict private
    FIFTP: TIdFTP;
    FHeader: THeaderFCDL;
    FListaRegistroSPC: TList<TRegistroSPC>;
    FListaRegistroCheque: TList<TRegistroCheque>;
    FTrailler: TTraillerFCDL;
    FCodigoArquivo: Integer;
    FNomeArquivo: String;
    FCaminhoOrigem: string;
    FCaminhoDestino: String;
    FEnderecoFTP: String;
    FPortaFTP: Integer;
    FNomeUsuarioFTP: String;
    FSenhaUsuarioFTP: String;

    function ConectarFTP: Boolean;
  public
    constructor Create(const pCodigoArquivo: Integer = 0);
    destructor Destroy; override;

    property Header: THeaderFCDL read FHeader write FHeader;
    property ListaRegistroSPC: TList<TRegistroSPC> read FListaRegistroSPC write FListaRegistroSPC;
    property ListaRegistroCheque: TList<TRegistroCheque> read FListaRegistroCheque write FListaRegistroCheque;
    property Trailler: TTraillerFCDL read FTrailler write FTrailler;
    property EnderecoFTP: String read FEnderecoFTP write FEnderecoFTP;
    property PortaFTP: Integer read FPortaFTP write FPortaFTP;
    property NomeUsuarioFTP: String read FNomeUsuarioFTP write FNomeUsuarioFTP;
    property SenhaUsuarioFTP: String read FSenhaUsuarioFTP write FSenhaUsuarioFTP;

    function GetCaminhoDestino: String;
    function GerarArquivo: boolean;
    function TransmitirArquivoFTP: Boolean;
    function CarregarArquivo(const pNomeArquivo: String): Boolean;
    function MoveArquivoPasta(const pNomeArquivo: String): boolean;
    function ReceberArquivoFTP(const pNomeArquivo: String = ''): TStringList;
  end;

implementation

Uses FuncoesFCDL;

{ TRegistroFCDL }

constructor TRegistroFCDL.Create(const pCodigoArquivo: Integer);
begin
  FIFTP := TIdFTP.Create(nil);
  FHeader := THeaderFCDL.Create(thRemessa);
  FListaRegistroSPC := TList<TRegistroSPC>.Create;
  FListaRegistroCheque := TList<TRegistroCheque>.Create;
  FTrailler := TTraillerFCDL.Create;
  FCodigoArquivo := pCodigoArquivo;

  FCaminhoOrigem := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + DIRETORIO_REGISTRO_COBRANCA_RAIZ +'\'+ DIRETORIO_REGISTRO_COBRANCA_REMESSA +'\' ;
  FCaminhoDestino := IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName)) + DIRETORIO_REGISTRO_COBRANCA_RAIZ +'\'+ DIRETORIO_REGISTRO_COBRANCA_RETORNO +'\' ;
end;

destructor TRegistroFCDL.Destroy;
var
  lx: Integer;

begin
  FIFTP.Free;
  FHeader.Free;

  for lx := 0 to FListaRegistroSPC.Count -1 do
    FListaRegistroSPC[lx].Free;

  FListaRegistroSPC.Free;

  for lx := 0 to FListaRegistroCheque.Count -1 do
    FListaRegistroCheque[lx].Free;

  FListaRegistroCheque.Free;

  FTrailler.Free;

  inherited;
end;

function TRegistroFCDL.GerarArquivo: boolean;
var
  lArquivo: TextFile;
  lLinhaAtual: integer;
  lRegistroSPC: TRegistroSPC;
  lRegistroCheque: TRegistroCheque;

begin
  lLinhaAtual := 1;
  FNomeArquivo := FHeader.DASPC_Destinatario +'.'+ AlinhaDir(FHeader.DASCP_Remetente, 8, '0') +'.'+
                  STR_TAG_REGISTROS +'.'+ AlinhaDir(intToStr(FCodigoArquivo), 7, '0');

  if not DirectoryExists(FCaminhoOrigem) then
    ForceDirectories(FCaminhoOrigem);

  try
    AssignFile(lArquivo, FCaminhoOrigem + FNomeArquivo);
    try
      rewrite(lArquivo);

      writeLn(lArquivo, FHeader.GetLinha);

      for lRegistroSPC in FListaRegistroSPC do
      begin
        writeLn(lArquivo, lRegistroSPC.GetLinha(lLinhaAtual));
        inc(lLinhaAtual);
      end;

      for lRegistroCheque in FListaRegistroCheque do
      begin
        writeLn(lArquivo, lRegistroCheque.GetLinha(lLinhaAtual));
        inc(lLinhaAtual);
      end;

      write(lArquivo, FTrailler.GetLinha(lLinhaAtual));

      writeLn(lArquivo, QUEBRA_LINHA);

      result := True;
    finally
      CloseFile(lArquivo);
    end;

  except
    on e:exception do
      raise Exception.Create(E.Message);
  end;
end;

function TRegistroFCDL.GetCaminhoDestino: String;
begin
  result := FCaminhoDestino;
end;

function TRegistroFCDL.MoveArquivoPasta(const pNomeArquivo: String): boolean;
begin
  Result := False;

  try
    if not DirectoryExists(FCaminhoDestino + DIRETORIO_REGISTRO_COBRANCA_PROCESSADO) then
      ForceDirectories(FCaminhoDestino + DIRETORIO_REGISTRO_COBRANCA_PROCESSADO);

    if MoveFile(pWideChar(FCaminhoDestino + pNomeArquivo),
      pWideChar(FCaminhoDestino + DIRETORIO_REGISTRO_COBRANCA_PROCESSADO +'\'+ FormatDateTime('yymmddhhnnss', now) +' - '+ pNomeArquivo)) then

    Result := True;

  except
    on e: exception do
      raise Exception.Create(E.Message);
  end;
end;

function TRegistroFCDL.ReceberArquivoFTP(const pNomeArquivo: String = ''): TStringList;
var
  lX: Integer;
  lListArquivo: TStrings;
  lNomeArquivo: String;

  procedure BaixarArquivo;
  begin
    try
      FIFTP.Get(lNomeArquivo, FCaminhoDestino + lNomeArquivo);
      result.Add(FCaminhoDestino + lNomeArquivo);
    except
      on e:exception do
        raise Exception.Create(E.Message);
    end;
  end;

begin
  Result := TStringList.Create;

  if not DirectoryExists(FCaminhoDestino) then
    ForceDirectories(FCaminhoDestino);

  lListArquivo := TStringList.Create;

  try
    if ConectarFTP then
    begin
      try
        FIFTP.ChangeDir('/RETORNO/');
        FIFTP.List(lListArquivo, ifThen(pNomeArquivo = '', '*.RET', pNomeArquivo), True);

        for lX := 0 to lListArquivo.Count - 1 do
        begin
          lNomeArquivo := Copy(lListArquivo[lX], pos('SC', lListArquivo[lX]), Length(lListArquivo[lX]));

          // verifica se arquivo já existe
          if FileExists(FCaminhoDestino + lNomeArquivo) then
          begin
            if msgConfirma('O arquivo '+ lNomeArquivo +' já existe na pasta de destino!'+ #13 +'Substituir?', True) then
            begin
              if MoveArquivoPasta(lNomeArquivo) then
                BaixarArquivo;
            end;
          end
          else
            BaixarArquivo;
        end;

      except
        on E: Exception do
          raise Exception.Create(E.Message);
      end;
    end;

  finally
    lListArquivo.Free;
    FIFTP.Disconnect();
  end;
end;

function TRegistroFCDL.TransmitirArquivoFTP: Boolean;
begin
  Result := False;

  if not FileExists(FCaminhoOrigem + FNomeArquivo) then
    raise Exception.Create('Arquivo '+ FCaminhoOrigem + FNomeArquivo +' não encontrado!');

  try
    if ConectarFTP then
    begin
      try
        FIFTP.Put(FCaminhoOrigem + FNomeArquivo, '/REMESSA/'+ FNomeArquivo);

        result := True;
      except
        on E: Exception do
          raise Exception.Create(E.Message);
      end;
    end;

  finally
    FIFTP.Disconnect();
  end;
end;

function TRegistroFCDL.CarregarArquivo(const pNomeArquivo: String): Boolean;
var
  lArquivo: TextFile;
  lLinhaAtual: String;
  lContadorLinha: Integer;

begin
  Result := False;
  lContadorLinha := 0;

  try
    if FileExists(pNomeArquivo) then
    begin
      AssignFile(lArquivo, pNomeArquivo);

      try
        Reset(lArquivo);

        while not eof(lArquivo) do
        begin
          inc(lContadorLinha);
          Readln(lArquivo, lLinhaAtual);

          // cabecalho
          if lContadorLinha = 1 then
          begin
            if not FHeader.SetLinha(lLinhaAtual) then
              raise Exception.Create('Algo inesperado ocorreu ao processar header do arquivo!');
          end
          else
          if Copy(lLinhaAtual, 1, 1) = '1' then
          begin
            try
              FListaRegistroSPC.Add(TRegistroSPC.Create().SetLinha(lLinhaAtual));
            except
              on e: exception do
                raise Exception.Create(E.Message);
            end;
          end
          else
          if Copy(lLinhaAtual, 1, 1) = '2' then
          begin
            try
              FListaRegistroCheque.Add(TRegistroCheque.Create().SetLinha(lLinhaAtual));
            except
              on e: exception do
                raise Exception.Create(E.Message);
            end;
          end
          else
          if Copy(lLinhaAtual, 1, 1) = '9' then
          begin
            if not Trailler.SetLinha(lLinhaAtual) then
              raise Exception.Create('Algo inesperado ocorreu ao processar trailler do arquivo!');
          end;
        end;

        Result := True;

      finally
        CloseFile(lArquivo);
      end;
    end
    else
      raise Exception.Create('Arquivo '+ pNomeArquivo +' não encontrado!');

  except
    on e:Exception do
      raise Exception.Create(E.Message);
  end;
end;

function TRegistroFCDL.ConectarFTP: Boolean;
begin
  FIFTP.Host := FEnderecoFTP;
  FIFTP.Port := FPortaFTP;
  FIFTP.Username := FNomeUsuarioFTP;
  FIFTP.Password := FSenhaUsuarioFTP;
  FIFTP.TransferType := ftBinary;
  FIFTP.Passive := True;

  try
    FIFTP.Connect;
    Result := FIFTP.Connected;

  except
    on E: Exception do
      raise Exception.Create(E.Message);
  end;
end;


end.
