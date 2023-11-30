unit WDPrinter;

interface

uses
  Funcoes,
  Classes,
  Dialogs,
  Windows,
  SysUtils,
  Winspool,
  StrUtils,
  WDPrinterConfigUnit,
  WDPrinterPreviewUnit;

Const
  NA = -15;
  fiMaxL66 = 62;
  fiMaxL88 = 82;
  fiaLpp6     = #27#50;
  fiaLpp8     = #27#48;
  fiaCpp10    = #27#80#18;
  fiaCpp12    = #27#80#18#27#77;
  fiaCpp17    = #27#80#15;
  fiaCpp20    = #27#77#15;
  fiAco_ex    = #27#14#15;
  fiExpand    = #27#14;
  fiaEnfat    = #27#69;
  fidEnfat    = #27#70;
  fiaDupla    = #27#71;
  fidDupla    = #27#72;
  fiASensor   = #27#57;
  fidSensor   = #27#56;
  fiReseta    = #27#64;

type
  TWDPTipo       = (EpLQ, EpFX, EpLX);

  TWDPDestino    = (pdArquivo, pdVideo, pdImpressora);

  TAlinhamento         = (alCenter, alLeft, alRight, alJustificado);

  TCpp = (cp10, cp12, cp17, cp20);

  TLpp = (lp6, lp8);

  TWDPParametros = record
    Nome : string;
    Porta: string;
    Rede : Boolean;
  end;

  TWDTab = record
    Posicao     : integer;
    Alinhamento : TAlinhamento;
    Tamanho     : integer;
    Margem      : integer;
  end;

  TWDArrayTab = array of TWDTab;

  TCabecalho       = procedure(Sender: TObject) of object;
  TImprime         = procedure(Sender: TObject) of object;
  TRodape          = procedure(Sender: TObject) of object;

  TWDPrinter = class(TComponent)
  private
    WDPrinterPreviewForm : TWDPrinterPreviewForm;
    //internas
    fLinhaAtual : integer;
    fPaginaAtual: integer;
    fTabAtual   : integer;
    fTab        : TWDArrayTab;
    fTabAux     : TWDArrayTab;
    fSaveTab    : array [1..10] of TWDArrayTab;
    fLinha      : String;
    fFile       : TextFile;
    fRodape     : Boolean;
    fCabecalho  : Boolean;

    //propriedades
    fColunas          : Integer;
    fLinhas           : integer;
    fLinhasNovaPagina : integer;
    fLinhaRodape      : integer;
    fLpp              : TLpp;
    fCpp              : TCpp;
    fArquivoTexto     : String;
    fMostraTelaConfig : Boolean;
    fMargemEsquerda   : integer;
    fMargemDireita    : integer;
    fMargemSuperior   : integer;
    fMargemInferior   : integer;
    fIntervalo        : String;
    fDestino          : TWDPDestino;
    fEjetaFolha       : Boolean;
    fWDTipo           : TWDPTipo;
    fRemoveAcento     : Boolean;

    //eventos
    fOnCabecalho      : TCabecalho;
    fOnImprime        : TImprime;
    fOnRodape         : TRodape;
    procedure Escrevelinha;
    function ShowTelaConfig: Boolean;
    procedure SetPrinter(const Value: TWDPTipo);
    procedure Atualiza;
    procedure ImprimeCabecalho;
    procedure ImprimeArquivo(Arquivo: String);
    procedure ImprimeRodape;
  protected
    { Protected declarations }
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy;  override;
    function SetImpressora(const Descricao: string): Boolean;
    procedure setImpSelecionada(imp : integer);
    function Execute : Boolean;
    procedure Novalinha;
    procedure Pulalinha(linhas: integer=1);
    procedure NovaPagina;
    procedure Imprimeln(Valor: String);
    procedure Imprime(Valor: String);
    procedure EnviaComando(const Comando: string);
    procedure ImprimeLinha(TamanhoTab: boolean = False);
    procedure SetarTamanhoPagina(const Linhas: Integer;  SetarTamanhoNaImpressora: Boolean = True);
    function PaginaAtual : integer;
    function LinhaAtual : integer;
    procedure ImprimeMargemSuperior;
    function TesteImpressao(MostraTelaConfig: Boolean = False): Boolean;
    function GetPrinters : TStringList;
    function GetImpressoras : TStringList;
    //tabs
    function RestoreTabs(indice : integer):boolean;
    function SaveTabs(indice: integer): boolean;
    procedure ClearTabs;
    procedure resetaTabs;
    procedure SetTab(Posicao : integer;  Alinhamento :TAlinhamento; Tamanho:integer; Margem:integer);
    procedure PrintTab(Valor: String);
  published
    property Colunas          : Integer  read fColunas           write fColunas          default 80  ;
    property Linhas           : Integer  read fLinhas            write fLinhas           default 80  ;
    property LinhasNovaPagina : Integer  read fLinhasNovaPagina  write fLinhasNovaPagina default 3   ;
    property LinhaRodape      : Integer  read fLinhaRodape       write fLinhaRodape      default 0   ;
    property Lpp              : TLpp     read fLpp               write fLpp                          ;
    property Cpp              : TCpp     read fCpp               write fCpp                          ;
    property ArquivoTexto     : String   read fArquivoTexto      write fArquivoTexto                 ;
    property Destino          : TWDPDestino read fDestino         write fDestino         default pdVideo;
    property Driver           : TWDPTipo    read fWDTipo      write SetPrinter       default EpLX;
    property EjetaFolha       : Boolean  read fEjetaFolha        write fEjetaFolha       default True;
    property MostraTelaConfig : Boolean  read fMostraTelaConfig  write fMostraTelaConfig default True;
    property MargemEsquerda   : integer  read fMargemEsquerda    write fMargemEsquerda   default 0   ;
    property MargemDireita    : integer  read fMargemDireita     write fMargemDireita    default 0   ;
    property MargemSuperior   : integer  read fMargemSuperior    write fMargemSuperior   default 0   ;
    property MargemInferior   : integer  read fMargemInferior    write fMargemInferior   default 0   ;
    property Intervalo        : string   read fIntervalo         write fIntervalo;
    property RemoveAcento     : Boolean  read fRemoveAcento      write fRemoveAcento     default True;
    //eventos do componente
    property OnCabecalho        : TCabecalho       read fOnCabecalho       write fOnCabecalho;
    property OnImprime          : TImprime         read fOnImprime         write fOnImprime;
    property OnRodape           : TRodape          read fOnRodape          write fOnRodape;
  end;

var
  // formatação da impressora
  fiDescricao: string;

var
  ImpCount: Integer;
  ArrImpressoras    : array of TWDPParametros;
  ImpSelecionada: Integer;
  Maxlinha  : integer;
  MaxColuna : integer;
  Quebra    : Boolean;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Wise Developer', [TWDPrinter]);
end;

constructor TWDPrinter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fColunas := 0;
  fLinhas  := 0;
  fLinhasNovaPagina := 3;
  fCpp     := cp10;
  fLpp     := lp6;
  fLinhaRodape := 0;
  fArquivoTexto := 'c:\impressao.txt' ;
  fDestino := pdVideo;
  fEjetaFolha := True;
  fWDTipo := EpLX;
  fMargemEsquerda := 0;
  fMargemDireita := 0;
  fMargemSuperior := 0;
  fMargemInferior := 0;
  fIntervalo :='';
  fPaginaAtual  := 1;
  fLinhaAtual   := 1 ;
  fLinha := '';
  fMostraTelaConfig := True;
  ResetaTabs;
  atualiza;
  WDPrinterPreviewForm := TWDPrinterPreviewForm.Create(self);
  ImpSelecionada := 0;
  fRemoveAcento := True;
end;

destructor TWDPrinter.Destroy;
begin
  WDPrinterPreviewForm.Free;
  {$I-}
  CloseFile(fFile);
  if IOResult <> 0 then;
  {$I+}
  inherited Destroy;
end;

//www.revolution.com.br/blogdelphi/2005/02/obtendo-as-portas-conectadas-s.html
//thecoadletter.com/article/0,1410,28000,00.html
//www.kbtech777.co.kr/lecture/prog/delphi/tip/tip_12/555_printerdrive.htm
procedure GetPrintersParams;
var
  LineCur, Port        : PChar;
  Buffer, PrinterInfo  : PChar;
  Flags, Count, NumInfo: DWORD;
  I                    : Integer;
  Level                : Byte;
  function FetchStr(var Str: PChar): PChar;
  var
    P: PChar;
  begin
    Result := Str;
    if Str = nil then Exit;
    P := Str;
    while P^ = ' ' do Inc(P);
    Result := P;
    while (P^ <> #0) and (P^ <> ',') do Inc(P);
    if P^ = ',' then
    begin
      P^ := #0;
      Inc(P);
    end;
    Str := P;
  end;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    Flags := PRINTER_ENUM_LOCAL or PRINTER_ENUM_CONNECTIONS ;
    Level := 2;
  end
  else
  begin
    Flags := PRINTER_ENUM_LOCAL;
    Level := 5;
  end;
  Count := 0;
  EnumPrinters(Flags, nil, Level, nil, 0, Count, NumInfo);
  if Count = 0 then Exit;
  GetMem(Buffer, Count);
  try
    if not EnumPrinters(Flags, nil, Level, PByte(Buffer), Count, Count, NumInfo) then Exit;
    PrinterInfo        := Buffer;
    ImpCount := NumInfo;
    SetLength(ArrImpressoras, NumInfo);
    for I := 0 to NumInfo - 1 do
    begin
      if Level = 5 then
        with PPrinterInfo5(PrinterInfo)^ do
        begin
          ArrImpressoras[I].Nome  := pPrinterName;
          ArrImpressoras[I].Porta := pPortName;
          ArrImpressoras[I].Rede  := Pos('\\', pPortName) > 0;
          Inc(PrinterInfo, SizeOf(TPrinterInfo5));
        end
      else
        with PPrinterInfo2(PrinterInfo)^ do
        begin
          try
            LineCur  := pPortName;
            Port     := FetchStr(LineCur);

            if port <> nil then
            begin

              while Port^ <> #0 do
              begin
                ArrImpressoras[I].Nome  := pPrinterName;
                if Trim(pServerName) = '' then
                begin
                  if Pos('\\',pPrinterName) > 0 then
                    ArrImpressoras[I].Porta := pPrinterName
                  else
                    ArrImpressoras[I].Porta := 'LPT1'
                end
                else
                  ArrImpressoras[I].Porta := pServerName + '\' + pShareName;
                ArrImpressoras[I].Rede  := Pos( '\\', ArrImpressoras[I].Nome) > 0;
                Port := FetchStr(LineCur);
              end;
              Inc(PrinterInfo, SizeOf(TPrinterInfo2));
            end;
          except
          end;
        end;
      if Copy(ArrImpressoras[I].Porta, Length(ArrImpressoras[I].Porta), 1) = ':' then
        ArrImpressoras[I].Porta := Copy(ArrImpressoras[I].Porta, 1, Length(ArrImpressoras[I].Porta)-1);
    end;
  finally
    FreeMem(Buffer, Count);
  end;
end;



Function Alinha(Valor:String; Alinhamento:TAlinhamento; tamanho:Integer; margem:integer):String;
begin
  case Alinhamento of
    alRight:
    begin
      //Valor := repeteStr(' ',tamanho - Margem - length(Valor))+Valor;
      Valor := DupeString(' ',tamanho - Margem - length(Valor))+Valor;
      Valor := copy(Valor,0,tamanho -Margem);
      //Valor := repetestr(' ',margem)+Valor;
      Valor := DupeString(' ',margem)+Valor;
    end;
    alLeft :
    begin
      Valor := Valor+DupeString(' ',tamanho);
      Valor := copy(Valor,0,tamanho - Margem);
      Valor := DupeString(' ',margem)+Valor;
    end;
    alCenter :
    begin
      Valor := DupeString(' ',(tamanho - Margem -length(Valor)) div 2)+Valor;
      Valor := Alinha(Valor, alLeft,tamanho,margem);
    end;
    alJustificado :
    begin
      Valor := 'justificado';
      Valor := copy(Valor,length(Valor)- tamanho,tamanho);
    end;
  end;
  Result := Valor;
end;

procedure TWDPrinter.Imprimeln(Valor :String);
begin
  fLinha := fLinha + Valor;
  if ((fLinhaAtual-1)  = Maxlinha - fLinhaRodape) and(Quebra)and(not fRodape)and(not fCabecalho) then
    NovaPagina
  else
    Escrevelinha;
end;

procedure TWDPrinter.Imprime(Valor :String);
begin
  fLinha := fLinha + Valor;
end;


function TWDPrinter.PaginaAtual : integer;
begin
  Result := fPaginaAtual;
end;

function TWDPrinter.LinhaAtual : integer;
begin
  Result := fLinhaAtual;
end;

procedure TWDPrinter.ResetaTabs;
begin
  fTabAtual := 0;
end;

function TWDPrinter.SaveTabs(indice : integer):boolean;
begin
  try
    if (indice >= 1) and (indice <= 10) and (length(fTab)<> 0) then
    begin
      fSaveTab[indice] := copy(fTab);
      Result := True;
    end
    else
      Result := false;
  except
    Result := False;
  end;
end;

function TWDPrinter.RestoreTabs(indice : integer):boolean;
begin
  try
    if (indice >= 1) and (indice <= 10) and (length(fSaveTab[indice])<> 0) then
    begin
      fTab := copy(fSaveTab[indice]);
      Result := True;
    end
    else
      Result := false;
  except
    Result := False;
  end;
end;

procedure TWDPrinter.ClearTabs;
begin
  finalize(ftab);
  resetaTabs;
end;

procedure TWDPrinter.SetTab(Posicao : integer;  Alinhamento :TAlinhamento; Tamanho:integer; Margem:integer);
var
  i,n : integer;
begin
  if length(fTab) = 0 then
    SetLength(fTab,1)
  else
    SetLength(fTab,length(fTab)+1) ;
  if Posicao = NA then
    fTab[High(fTab)].Posicao   := fTab[High(fTab)-1].Posicao + fTab[High(fTab)-1].Tamanho
  else
    fTab[High(fTab)].Posicao   := Posicao ;
  fTab[High(fTab)].Alinhamento := Alinhamento ;
  if Tamanho = NA then
  begin
    n := 0;
    for i := 0 to High(fTab)-1 do
      n := n + fTab[i].Tamanho;
    fTab[High(fTab)].Tamanho := MaxColuna - n - MargemDireita - MargemEsquerda
  end
  else
    fTab[High(fTab)].Tamanho     := Tamanho ;
  fTab[High(fTab)].Margem      := Margem ;
end;

procedure TWDPrinter.PrintTab(Valor : String);
var
  S : String;
begin
  S := Alinha(Valor, ftab[fTabAtual].Alinhamento, ftab[fTabAtual].Tamanho, ftab[fTabAtual].Margem);
  if ftab[fTabAtual].Posicao = length(flinha) then
    flinha := flinha + S
  else
    if ftab[fTabAtual].Posicao > length(flinha) then
      flinha := flinha + DupeString(' ',ftab[fTabAtual].Posicao - length(flinha))+S
    else
      flinha := StuffString(fLinha, ftab[fTabAtual].Posicao + 1, ftab[fTabAtual].Tamanho, S);
  if ftabatual < High(ftab) then
    inc(fTabAtual)
  else
    fTabAtual := 0;
end;

procedure TWDPrinter.Escrevelinha;
begin
    if fDestino = pdVideo then
    begin
      WDPrinterPreviewForm.Tb.Append;
      WDPrinterPreviewForm.TbPagina.AsInteger      := fPaginaAtual;
      WDPrinterPreviewForm.TbPaginaLinha.AsInteger := fLinhaAtual;
      WDPrinterPreviewForm.TbLinha.AsString := fLinha;
      WDPrinterPreviewForm.Tb.Post;
    end;
    {$I-}
    if fRemoveAcento then
      Writeln(fFile,  tiraacentos(flinha))
    else
      Writeln(fFile,  flinha);
    {$I+}
    if not (IOResult = 0) then
    begin
      showmessage('Não foi possível escrever no arquivo');
      abort;
    end;
    flinha := '';
  inc(fLinhaAtual);
end;

procedure TWDPrinter.Novalinha;
begin
  if ((fLinhaAtual-1)  = Maxlinha - fLinhaRodape) and(Quebra)and(not fRodape)and(not fCabecalho) then
  begin
    NovaPagina;
  end
  else
  begin
    fTabAtual := 0;
    EscreveLinha;
  end;
end;

procedure TWDPrinter.Pulalinha(linhas :integer = 1);
var
  i : integer;
begin
  if linhas > 0 then
    for i:=1 to linhas do
      Novalinha
end;

procedure TWDPrinter.ImprimeLinha(TamanhoTab : boolean = False);
var
  i, n, x : integer;
begin
  n := 0;
  if TamanhoTab then
  begin
    for i:=0 to high(fTab) do
      n := n + fTab[i].Tamanho;
    n:= n - fTAb[0].Posicao + 1;
  end
  else
    n := MaxColuna - MargemEsquerda - MargemDireita;
  if TamanhoTab then
    x := fTAb[0].Posicao
  else
    x := MargemEsquerda;
  fLinha := DupeString(' ',x)+DupeString('-',n);
  Escrevelinha;
end;

procedure TWDPrinter.ImprimeRodape;
var
  x : String;
begin
  try
    fRodape := True;
    x := fLinha;
    fTabAux := copy(fTab);
    fLinha := '';
    //imprime linhas em branco para colocar o rodape na parte de baixo da folha
    while (fLinhaAtual-1) < Maxlinha - fLinhaRodape  do
      Novalinha;
    //imprime o rodape
    if Assigned(OnRodape) then OnRodape(self) ;
    //imprime linhas em branco para preencher o redo do rodape
    While (fLinhaAtual-1) < MaxLinha do
      NovaLinha;

    if fLinha <> '' then
      EscreveLinha;
  finally
    fRodape := false;
    fLinha := x;
    fTab := copy(fTabAux);
  end;
end;

procedure TWDPrinter.ImprimeCabecalho;
var
  x : String;
begin
  try
    fCabecalho := True;
    x := fLinha;
    fTabAux := copy(fTab);
    fLinha := '';
    if Assigned(OnCabecalho) then OnCabecalho(self) ;
    if fLinha <> '' then
      EscreveLinha;
  finally
    fCabecalho := False;
    fLinha := x;
    fTab := copy(fTabAux);
  end;
end;

procedure TWDPrinter.NovaPagina;
var
  i : integer;
begin
  if fPaginaAtual > 0 then
  begin
    if assigned(onRodape) then ImprimeRodape;
    {$I-}
      if flinhas = 0 then
        Write(fFile,#12)
      else
        for i:=1 to fLinhasNovaPagina+Maxlinha-flinhaAtual+1 do
          Writeln(fFile,#32);
    {$I+}
    if fDestino = pdVideo then
    begin
      for i:=1 to fLinhasNovaPagina+Maxlinha-flinhaAtual+1 do
        WDPrinterPreviewForm.Tb.AppendRecord([fPaginaAtual,' ',fLinhaAtual]);
    end;
  end;
  fLinhaAtual := 1;
  inc(fPaginaAtual);
  ImprimeMargemSuperior;
  if assigned(onCabecalho) then
    ImprimeCabecalho;
  if not (IOResult = 0) then
  begin
    ShowMessage('Não foi possível escrever no arquivo');
    abort;
  end;
  fTabAtual := 0;
  if (fPaginaAtual > 1)and(flinha<>'') then
    EscreveLinha;
end;

procedure TWDPrinter.SetarTamanhoPagina(const Linhas: Integer; SetarTamanhoNaImpressora: Boolean = True);
begin
  if SetarTamanhoNaImpressora then Write(fFile, #27 + 'C' + Chr(Linhas) ); 
  Quebra := True;
  if Linhas > 0 then
    Maxlinha := Linhas
  else
    if Linhas = 0 then
    begin
      if fLpp = lp6 then
        MaxLinha := fiMaxl66
      else
        MaxLinha := fiMaxl88;
    end
    else
      Quebra := False;
  if fLinhas <> Linhas then
    fLinhas := Linhas;
end;

procedure TWDPrinter.EnviaComando(const Comando:string);
begin
  if Comando = fiAcpp10 then MaxColuna := 80;
  if Comando = fiAcpp12 then MaxColuna := 96;
  if Comando = fiAcpp17 then MaxColuna := 137;
  if Comando = fiAcpp20 then MaxColuna := 160;
  {$I-}
  Write(fFile,Comando);
  {$I+}
  if IOResult <> 0 then;
end;


procedure TWDPrinter.ImprimeMargemSuperior;
var
  i : integer;
  s : string;
begin
  s := flinha;
  flinha := '';
  for i:=1 to fMargemSuperior do
    Novalinha;
  flinha := s;
end;


function TWDPrinter.Execute : Boolean;
begin
  fPaginaAtual  := 0;
  fLinhaAtual   := 1 ;
  fLinha := '';

  if fMostraTelaConfig then
    if not ShowTelaConfig then
    begin
      Result     := False;
      Exit;
    end;

  Result := True ;
  if not DirectoryExists(ExtractFileDir(fArquivoTexto)) then
  begin
    ShowMessage('Nome de arquivo inválido: '+fArquivoTexto);
    abort;
  end;

  {$I-}
  CloseFile(fFile);
  if IOResult <> 0 then;

  if fDestino = pdImpressora then
    AssignFile(fFile,ArrImpressoras[ ImpSelecionada ].Porta)
  else
  begin
    AssignFile(fFile,fArquivoTexto);
    WDPrinterPreviewForm.Tb.DisableControls;
    WDPrinterPreviewForm.Tb.EmptyDataSet;
  end;

  Rewrite(fFile);
  {$I+}
  EnviaComando(fiReseta);

  if not (IOResult = 0) then
  begin
    ShowMessage('Não foi possível escrever no arquivo '+fArquivoTexto);
    abort;
  end;

  case fLpp of
    lp6 : EnviaComando(fiAlpp6);
    lp8 : EnviaComando(fiAlpp8);
  end;

  SetarTamanhoPagina(fLinhas,false);

  case fcpp of
    cp10 : begin
             MaxColuna := 80;
             EnviaComando(fiAcpp10);
           end;
    cp12 : begin
             MaxColuna := 96;
             EnviaComando(fiAcpp12);
           end;
    cp17 : begin
             MaxColuna := 137;
             EnviaComando(fiAcpp17);
           end;
    cp20 : begin
             MaxColuna := 160;
             EnviaComando(fiAcpp20);
           end;
  end;
  if fColunas > 0 then
    MaxColuna := fColunas;


  NovaPagina;
  if Assigned(OnImprime) then OnImprime(self) ;
  if Assigned(OnRodape) then ImprimeRodape;

  if (fEjetaFolha)and(flinhaatual > 1) then
    flinha := flinha + #12;

  if flinha <> '' then
    Escrevelinha;


  CloseFile(fFile);

  if fDestino = pdVideo then
  begin
    WDPrinterPreviewForm.PaginaTotal := WDPrinterPreviewForm.TbPagina.asInteger;
    WDPrinterPreviewForm.Tb.CheckBrowseMode;
    WDPrinterPreviewForm.Tb.First;
    WDPrinterPreviewForm.Tb.EnableControls;
    with WDPrinterPreviewForm.StatusBar do
    begin
      Panels[1].Text := ArrImpressoras[ ImpSelecionada ].Porta;
      Panels[2].Text := ArrImpressoras[ ImpSelecionada ].Nome;
      if ArrImpressoras[ ImpSelecionada ].Rede then Panels[3].Text := 'REDE' else Panels[3].Text := 'LOCAL';
    end;
    WDPrinterPreviewForm.ShowModal;
    if WDPrinterPreviewForm.Imprimiu then
    begin
      Result := True;
      ImprimeArquivo(fArquivoTexto);
    end
    else
      Result := False;
  end;
end;

procedure TWDPrinter.ImprimeArquivo(Arquivo :String);
var
  L : TStringList;
begin
  L := TStringList.Create;
  try
    l.LoadFromFile(Arquivo);
    l.SaveToFile(ArrImpressoras[ ImpSelecionada ].Porta);
  finally
    L.Free
  end;
end;


procedure TWDPrinter.Atualiza;
begin
  GetPrintersParams;
  if ImpCount = 0 then showmessage('Não há impressoras instaladas!');
end;


function TWDPrinter.ShowTelaConfig: Boolean;
var
  I : Integer;
begin
  WDPrinterConfigForm := TWDPrinterConfigForm.Create(Self);

  with WDPrinterConfigForm do
  begin
    for I := 0 to ImpCount - 1 do
    begin
      if I > 9 then Break; //
      ImpressorasInstaladas[0, I] := ArrImpressoras[I].Nome;
      ImpressorasInstaladas[1, I] := ArrImpressoras[I].Porta;
      if ArrImpressoras[I].Rede then ImpressorasInstaladas[2, I] := 'REDE' else ImpressorasInstaladas[2, I] := 'LOCAL';
    end;
    ShowModal;
    if (OK) or (TesteImp) then
    begin
      SetImpressora( DriverComboBox.Items[ DriverComboBox.ItemIndex ] );
      fDestino := pdVideo;
      if VideoCheck.Checked then fDestino := pdVideo;
      if ArquivoCheck.Checked then
      begin
        fDestino := pdArquivo;
        fArquivoTexto := ArquivoEdit.Text;
      end;
      if (not VideoCheck.Checked) and (not ArquivoCheck.Checked) then
        fDestino := pdImpressora;
      ImpSelecionada := InstaladasComboBox.ItemIndex;
      if TesteImp then
      begin
        Free;
        fDestino   := pdImpressora;
        TesteImpressao;
        Result     := False;
        Exit;
      end;
    end;
    Result := OK;
    Free;
  end;
end;



function TWDPrinter.SetImpressora(const Descricao: string): Boolean;
var
  I: TWDPTipo;
begin
  Result := False;
  For I  := Low(I) to High(I) do
  begin
    SetPrinter(I);
    if UpperCase(fiDescricao) = UpperCase(Descricao) then
    begin
      Result := True;
      Break;
    end;
  end;
end;


function TWDPrinter.TesteImpressao(MostraTelaConfig: Boolean = False): Boolean;
begin
  {$I-}
  CloseFile(fFile);
  if IOResult <> 0 then;
  AssignFile(fFile,ArrImpressoras[ ImpSelecionada ].Porta);
  Rewrite(fFile);
  {$I+}
  EnviaComando(fiReseta);


  if not (IOResult = 0) then
  begin
    ShowMessage('Falha na Impressão');
    abort;
  end;

  Imprimeln('Impressora testada com sucesso');
  CloseFile(fFile);
  Result   := True;
end;


procedure TWDPrinter.SetPrinter(const Value: TWDPTipo);
begin
  fWDTipo := Value;
  Case fWDTipo of
    EpLQ: fiDescricao := 'EPSON LQ';
    EpFX: fiDescricao := 'EPSON FX';
    EpLX: fiDescricao := 'EPSON LX';
  end;
end;


function TWDPrinter.GetPrinters: TStringList;
var
  lista : TStringList;
begin
    lista := TStringList.Create;
    lista.Add('EPSON LQ');
    lista.Add('EPSON FX');
    lista.Add('EPSON LX');
    GetPrinters := Lista;
end;

function TWDPrinter.GetImpressoras: TStringList;
var
  i : integer;
  lista : TStringList;
begin
  lista := TStringList.Create;
  for i := 0 to length(ArrImpressoras)-1 do
  begin
    lista.Add(ArrImpressoras[i].Nome);
  end;
  result := lista;
end;

procedure TWDPrinter.setImpSelecionada(imp: integer);
begin
  impSelecionada := imp;
end;

end.
