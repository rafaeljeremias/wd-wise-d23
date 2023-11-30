unit WDGeraArquivo;

interface

uses
  DB,
  Classes,
  Funcoes,
  SysUtils,
  StrUtils;

type
  TWDCustomGeraArquivo = Class;

  TDataSetItem = class;

  TScroll       = procedure(Sender: TObject; Dataset: TDataset) of object;

  TTipoDado = (tdCaracter, tdNumerico, tdInteger, tdData, tdAscii);

  TTipoCampo = (tcField, tcValor , tcVariavel);

  TAlinhamento = (alEsquerda, alDireita);

  TCampoItem = class(TCollectionItem)
  private
    fField : TField;
    fValor : String;
    fVariavel : String;
    fTipoCampo : TTipoCampo;
    fTamanho : integer;
    fTipoDado : TTipoDado;
    fAlinhamento : TAlinhamento;
    fMascara : String;
    fPreenchimento : String;
    fSeparador : String;
    fDelimitador : String;
    fDecimais : integer;
    function GetField: TField;
    procedure SetField(const Value: TField);
  published
    property Field: TField read GetField write SetField;
    property Valor: String read fValor write fValor;
    property Variavel: String read fVariavel write fVariavel;
    property TipoCampo: TTipoCampo read fTipoCampo write fTipoCampo;
    property TipoDado : TTipoDado read fTipoDado write fTipoDado;
    property Tamanho : integer read fTamanho write fTamanho;
    property Alinhamento : TAlinhamento read fAlinhamento write fAlinhamento;
    property Mascara : String read fMascara write fMascara;
    property Preenchimento : String read fPreenchimento write fPreenchimento;
    property Decimais : integer read fDecimais write fDecimais;
    property Separador: String read fSeparador write fSeparador;
    property DelimitadorCaracter: String read fDelimitador write fDelimitador;
  end;

  TCampoCollectionClass = class of TCampoItem;

  TCampoCollection = class(TCollection)
  private
    fDataSetItem: TDataSetItem;
    function GetCampoItem(Index: Integer): TCampoItem;
    procedure SetCampoItem(Index: Integer; Value: TCampoItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(DataSetItem: TDataSetItem; CampoCollectionClass: TCampoCollectionClass);
    destructor Destroy; override;
    function  Add: TCampoItem;
    property DataSetItem: TDataSetItem read fDataSetItem;
    property Items[Index: Integer]: TCampoItem read GetCampoItem write SetCampoItem; default;
  end;

  TDataSetItem = class(TCollectionItem)
  private
    fDataSet: TDataset;
    fCampos: TCampoCollection;
    fParent: integer;
    procedure SetDataSet(Value: TDataSet); virtual;
    procedure SetCampos(Value: TCampoCollection);
    function  GetDataSet: TDataSet;
    function GetGeraArquivo: TWDCustomGeraArquivo;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property  GeraArquivo : TWDCustomGeraArquivo read GetGeraArquivo;
    property  DataSet     : TDataSet read GetDataSet write SetDataset;
    property Campos       : TCampoCollection read fCampos write setCampos;
    property Parent       : integer read fParent write fParent;
  end;

  TDataSetCollectionClass = class of TDataSetItem;

  TDataSetCollection = class(TCollection)
  private
    fGeraArquivo: TWDCustomGeraArquivo;
    function GetDatasetItem(Index: Integer): TDatasetItem;
    procedure SetDatasetItem(Index: Integer; Value: TDatasetItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(GeraArquivo: TWDCustomGeraArquivo; DataSetCollectionClass: TDataSetCollectionClass);
    destructor Destroy; override;
    function  Add: TDatasetItem;
    property GeraArquivo: TWDCustomGeraArquivo read fGeraArquivo;
    property Items[Index: Integer]: TDataSetItem read GetDatasetItem write SetDatasetItem; default;
  end;

  TVariavel = record
    nome : String;
    valor : String;
  end;

  TWDCustomGeraArquivo = class(TComponent)
  private
    { Private declarations }
    fDataSets : TDatasetCollection;
    fOnScroll : TScroll;
    fArquivo : String;
    variaveis : array of TVariavel;
    procedure setDatasets(const Value: TDataSetCollection);
  protected
    { Protected declarations }
    property DataSets    : TDataSetCollection read fDataSets  write setDatasets;
    property OnScroll    : TScroll            read fOnScroll  write fOnScroll;
    property Arquivo     : String             read fArquivo   write fArquivo;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure executar;
    procedure setVariavel(nome, valor : String);
    procedure executarRecursivo(p:integer; var arquivo : TextFile);
    function valorCampo(const field: TField; valor, variavel: string; tamanho: integer;
      tipoCampo: TTipoCampo; tipoDado: TTipoDado; alinhamento: TAlinhamento ;
      mascara, c_preenchimento: String; decimais: integer; separador, delimitador : String): string;
  end;

  TWDGeraArquivo = class(TWDCustomGeraArquivo)
  published
    { Published declarations }
    property DataSets;
    property OnScroll;
    property Arquivo;
  end;

procedure Register;

implementation


function isSQL(valor: String): boolean;
begin
  Result := (pos('{<', valor) > 0) and (pos('>}', valor) > 0);
end;


procedure Register;
begin
  RegisterComponents('Wise Developer', [TWDGeraArquivo]);
end;

{ TDataSetItem }

constructor TDataSetItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  fCampos := TCampoCollection.Create(self, TCampoItem);
end;

destructor TDataSetItem.Destroy;
begin
  fCampos.Free;

  inherited Destroy;
end;


function TDataSetItem.GetGeraArquivo: TWDCustomGeraArquivo;
begin
  if Assigned(Collection) and (Collection is TDataSetCollection) then
    Result := TDataSetCollection(Collection).GeraArquivo
  else
    Result := nil;
end;

function TDataSetItem.GetDataSet: TDataSet;
begin
  result := fDataSet;
end;

procedure TDataSetItem.SetDataSet(Value: TDataSet);
begin
  if fDataSet <> Value then
  begin
    fDataset := Value;
    { TODO : aqui }
    //if Value <> nil then Value.FreeNotification(Self);
  end;
end;



procedure TDataSetItem.SetCampos(Value: TCampoCollection);
begin
  Campos.Assign(value);
end;

{ TDataSetCollection }

function TDataSetCollection.Add: TDatasetItem;
begin
  Result := TDatasetItem(inherited Add);
end;

constructor TDataSetCollection.Create(GeraArquivo: TWDCustomGeraArquivo;
  DataSetCollectionClass: TDataSetCollectionClass);
begin
  inherited Create(DataSetCollectionClass);
  fGeraArquivo := GeraArquivo;
end;

destructor TDataSetCollection.Destroy;
begin
  inherited Destroy;
end;

function TDataSetCollection.GetDatasetItem(Index: Integer): TDatasetItem;
begin
  Result := TDataSetItem(inherited Items[Index]);
end;

function TDataSetCollection.GetOwner: TPersistent;
begin
  Result := fGeraArquivo;
end;

procedure TDataSetCollection.SetDatasetItem(Index: Integer;
  Value: TDatasetItem);
begin
  Items[Index].Assign(Value);
end;

{ TWDCustomGeraArquivo }


function TWDCustomGeraArquivo.valorCampo(const field: TField; valor, variavel: string; tamanho: integer;
  tipoCampo: TTipoCampo; tipoDado: TTipoDado; alinhamento: TAlinhamento ;
  mascara, c_preenchimento: String; decimais: integer; separador, delimitador : String): string;
var
  resultado : String;
  p_inteiro, p_decimal : String;
  i: integer;
begin
  if c_preenchimento = '' then
    c_preenchimento := ' ';
  case tipoCampo of
    tcField:
    begin
      msgInformaAbort(not Assigned(field), 'Field nao selecionado para tipo TField');
      case tipoDado of
        tdNumerico :
        begin
          if mascara = '' then
          begin
            if decimais > 0 then
              resultado := FormatFloat('0.'+DupeString('0',decimais), field.AsFloat)
            else
              resultado := FormatFloat('0', field.AsFloat);
            resultado := AnsiReplaceStr(resultado, FormatSettings.DecimalSeparator, '');
          end
          else
            resultado := FormatFloat(mascara,field.AsFloat);
        end;
        tdData : resultado := FormatDatetime(mascara,field.AsDateTime);
        tdAscii : resultado := chr(field.AsInteger);
      else
        resultado := field.AsString;
      end;
    end;
    tcValor:
    begin
      case tipoDado of
        tdNumerico :
        begin
          if mascara = '' then
          begin
            if (pos(FormatSettings.DecimalSeparator,valor) <> 0) then
            begin
              p_inteiro := copy(valor, 1, pos(FormatSettings.DecimalSeparator,valor)-1);
              p_decimal := copy(valor, pos(FormatSettings.DecimalSeparator,valor)+1, length(valor)- pos(FormatSettings.DecimalSeparator,valor));
              resultado := p_inteiro + ifthen(decimais>0,AlinhaEsq(p_decimal,decimais-length(p_decimal),'0'),'');
            end
            else
            begin
              //sem decimal separator
              resultado := valor;
              resultado := AlinhaEsq(resultado,length(resultado)+decimais,'0');
            end;
          end
          else
            resultado := FormatFloat(mascara,StrToFloatDef(valor,0));
        end;
        tdData : resultado := FormatDatetime(mascara,StrToDate(valor));
        tdAscii : resultado := chr(StrToInt(valor));
      else
        resultado := valor;
      end;
    end;
    tcVariavel:
    begin
      valor := '';
      for i:=0 to length(variaveis)-1 do
      begin
        if variaveis[i].nome = UpperCase(variavel) then
          valor := variaveis[i].valor;
      end;
      case tipoDado of
        tdNumerico :
        begin
          if mascara = '' then
          begin
            if (pos(FormatSettings.DecimalSeparator,valor) <> 0) then
            begin
              p_inteiro := copy(valor, 1, pos(FormatSettings.DecimalSeparator,valor)-1);
              p_decimal := copy(valor, pos(FormatSettings.DecimalSeparator,valor)+1, length(valor)- pos(FormatSettings.DecimalSeparator,valor));
              resultado := p_inteiro + ifthen(decimais>0,AlinhaEsq(p_decimal,decimais-length(p_decimal),'0'),'');
            end
            else
            begin
              //sem decimal separator
              resultado := valor;
              resultado := AlinhaEsq(resultado,length(resultado)+decimais,'0');
            end;
          end
          else
            resultado := FormatFloat(mascara,StrToFloatDef(valor,0));
        end;
        tdData : resultado := FormatDatetime(mascara,StrToDate(valor));
        tdAscii : resultado := chr(StrToInt(valor));
      else
        resultado := valor;
      end;
    end
  end;

  if tamanho > 0 then
  begin
    case alinhamento of
      alDireita  :
        resultado := AlinhaDir(resultado, tamanho, c_preenchimento[1]);
      alEsquerda :
        resultado := AlinhaEsq(resultado, tamanho, c_preenchimento[1]);
    end;
  end;

  if delimitador <> '' then
    resultado := delimitador+resultado+delimitador;

  if separador <> '' then
    resultado := resultado + separador;

  result := TiraAcentos(resultado);
end;

procedure TWDCustomGeraArquivo.setVariavel(nome, valor: String);
var
  i : integer;
  achou : integer;
begin
  achou := -1;
  for i:=0 to length(variaveis)-1 do
  begin
    if variaveis[i].nome = UpperCase(nome) then
    begin
      achou := i;
      break;
    end
  end;
  if achou = -1 then
  begin
    SetLength(variaveis,length(variaveis)+1);
    variaveis[length(variaveis)-1].nome := UpperCase(nome);
    variaveis[length(variaveis)-1].valor := valor;
  end
  else
  begin
    variaveis[achou].valor := valor
  end;
end;

constructor TWDCustomGeraArquivo.Create(AOwner: TComponent);
begin
  inherited;
  fDataSets := TDataSetCollection.Create(self, TDataSetItem);
end;

procedure TWDCustomGeraArquivo.executarRecursivo(p:integer; var arquivo : TextFile);
var
  i, j : integer;
  linha : String;
begin
  for i :=0 to Pred(fDataSets.Count) do
  begin
    with fdatasets[i] do
    begin
      if fParent = p then
      begin
        fDataSet.first;
        while not fDataSet.eof do
        begin
          if (Assigned(OnScroll)) then OnScroll(self, fDataSet) ;
          linha := '';
          for j:=0 to Pred(Campos.Count) do
          begin
            linha := linha + valorCampo(campos[j].Field, campos[j].fValor, campos[j].fVariavel,
              campos[j].fTamanho, campos[j].fTipoCampo, campos[j].fTipoDado,
              campos[j].fAlinhamento, Campos[j].fMascara, Campos[j].fPreenchimento,
              Campos[j].fDecimais, Campos[j].fSeparador, Campos[j].fDelimitador);
          end;
          write(arquivo, linha);
          executarRecursivo(i, arquivo);
          fDataSet.next;
        end;
      end
    end
  end;
end;

destructor TWDCustomGeraArquivo.Destroy;
begin
  fDataSets.Free;

  inherited Destroy;
end;

procedure TWDCustomGeraArquivo.executar;
var
//  i, j  : integer;
//  linha : String;
  arquivo : TextFile;
begin

  AssignFile(arquivo, fArquivo);
  {$I-}
  rewrite(arquivo);
  {$I+}
  msgInformaAbort(IOResult <> 0, 'Não foi possível escrever no arquivo '+fArquivo);

  executarRecursivo(-1, arquivo);

  closeFile(arquivo);
end;

procedure TWDCustomGeraArquivo.setDatasets(
  const Value: TDataSetCollection);
begin
  DataSets.Assign(value);
  //fDataSets := value;
end;

{ TCampoCollection }

function TCampoCollection.Add: TCampoItem;
begin
  Result := TCampoItem(inherited Add);
end;

constructor TCampoCollection.Create(DataSetItem: TDataSetItem;
  CampoCollectionClass: TCampoCollectionClass);
begin
  inherited Create(CampoCollectionClass);
  fDataSetItem := DataSetItem;
end;

destructor TCampoCollection.Destroy;
begin
  inherited Destroy;
end;

function TCampoCollection.GetCampoItem(Index: Integer): TCampoItem;
begin
  Result := TCampoItem(inherited Items[Index]);
end;

function TCampoCollection.GetOwner: TPersistent;
begin
  Result := fDatasetItem;
end;

procedure TCampoCollection.SetCampoItem(Index: Integer; Value: TCampoItem);
begin
  Items[Index].Assign(Value);
end;

{ TCampoItem }

function TCampoItem.GetField: TField;
begin
  Result := fField;
end;

procedure TCampoItem.SetField(const Value: TField);
begin
  if fField <> Value then
  begin
    fField := Value;
  end;
end;

end.

