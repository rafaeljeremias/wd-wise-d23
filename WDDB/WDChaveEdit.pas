unit WDChaveEdit;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Mask, DBCtrls, Windows, SqlExpr,
  Messages,  DB, Forms, STrUtils, dialogs, Graphics;

type
  TWDCustomChaveEdit = Class;

  TWDTipoChave    = (fdInteger, fdString, fdDate, fdDateTime);

  TAtualiza       = procedure(Sender: TObject) of object;

  TChaveItem = class(TCollectionItem)
  private
    fField: TField;
    procedure SetField(Value: TField); virtual;
    function  GetField: TField;
    function GetChaveEdit: TWDCustomChaveEdit;
  protected
    //function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property  ChaveEdit: TWDCustomChaveEdit read GetChaveEdit;
    property  Field: TField read GetField write SetField;
  end;

  TChaveClass = class of TChaveItem;

  TChave = class(TCollection)
  private
    fChaveEdit: TWDCustomChaveEdit;
    function GetChaveItem(Index: Integer): TChaveItem;
    procedure SetChaveItem(Index: Integer; Value: TChaveItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(ChaveEdit: TWdCustomChaveEdit; ChaveClass: TChaveClass);

    function  Add: TChaveItem;
    property ChaveEdit: TWDCustomChaveEDit read FChaveEdit;
    property Items[Index: Integer]: TChaveItem read GetChaveItem write SetChaveItem; default;
  end;

  TDependenciaItem = class(TCollectionItem)
  private
    fField: TField;
    fcampo: String;
    fObrigatorio : boolean;
    procedure SetField(Value: TField); virtual;
    function  GetField: TField;
    function GetChaveEdit: TWDCustomChaveEdit;
  public
    constructor Create(Collection: TCollection); override;
  published
    property  ChaveEdit: TWDCustomChaveEdit read GetChaveEdit;
    property  Field: TField read GetField write SetField;
    property  Campo: String read fCampo write fCampo;
    property  Obrigatorio: Boolean read fObrigatorio write fObrigatorio;
  end;

  TDependenciaClass = class of TDependenciaItem;

  TDependencia = class(TCollection)
  private
    fChaveEdit: TWDCustomChaveEdit;
    function GetDependenciaItem(Index: Integer): TDependenciaItem;
    procedure SetDependenciaItem(Index: Integer; Value: TDependenciaItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(ChaveEdit: TWdCustomChaveEdit; DependenciaClass: TDependenciaClass);
    destructor Destroy; override;

    function  Add: TDependenciaItem;
    property ChaveEdit: TWDCustomChaveEDit read FChaveEdit;
    property Items[Index: Integer]: TDependenciaItem read GetDependenciaItem write SetDependenciaItem; default;
  end;

  TWDCustomChaveEdit = class(TDBEdit)
  private
    corOriginal : TColor;
    fBotao : TButton;
    fSQL   : TStrings;
    fConexao : TSQLConnection;
    fChave   : TChave;
    fDependencia : TDependencia;
    fCampoChave : String;
    fSobreescreveNulo : boolean;
    fMensagem : String;
    fErro :String;
    fMascaraVazio : String;
    fOnAtualiza : TAtualiza;
    function getBotao: TButton;
    procedure SetBotao(const Value: TButton);
    function GetConexao: TSQLConnection;
    procedure SetConexao(const Value: TSQLConnection);
    procedure SetChave(Value: TChave);
    procedure SetDependencia(Value: TDependencia);
    procedure SetSQL(Value: TStrings);
  protected
    property Botao    : TButton read GetBotao write SetBotao ;
    property SQL      : TStrings read fSQL write SetSQL;
    property Conexao  : TSQLConnection read GetConexao write SetConexao;
    property Chave    : TChave read fChave write setChave;
    property Dependencia : TDependencia read fDependencia write setDependencia;
    property CampoChave : String read fCampoChave write fCampoChave;
    property SobreescreveNulo : boolean read fSobreescreveNulo write fSobreescreveNulo;
    property Mensagem : String read fMensagem write fMensagem;
    property MascaraVazio : String read fMascaraVazio write fMascaraVazio;
    property OnAtualiza  : TAtualiza  read fOnAtualiza write fOnAtualiza;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure BeforeExit(var ExitMessage: TWMKillFocus);   message wm_KillFocus;     // Antes de sair
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function atualiza : boolean;
  end;

  TWDChaveEdit = class(TWDCustomChaveEdit)
  published
    property Botao;
    property SQL;
    property Conexao;
    property Chave;
    property Dependencia;
    property CampoChave;
    property SobreescreveNulo;
    property Mensagem;
    property MascaraVazio;
    property OnAtualiza;
  end;

procedure Register;

implementation

uses
  Funcoes,
  Variants;

procedure Register;
begin
  RegisterComponents('Wise Developer', [TWDChaveEdit]);
end;

constructor TWDCustomChaveEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited Hint := 'F3 - Consulta';
  inherited  ShowHint := True;
  fBotao := nil;
  fChave := TChave.Create(self,TChaveItem);
  fDependencia := TDependencia.Create(self,TDependenciaItem);
  fSQL := TStringList.Create;
  fMensagem := 'Registro não Encontrado';
  fSobreescreveNulo := true;
  fCampoChave := '';
  fErro := '';
  corOriginal := self.Color;
end;

destructor TWDCustomChaveEdit.Destroy;
begin
  fSQL.Free;
  fChave.Free;
  fDependencia.Free;

  inherited;
end;

function TWDCustomChaveEdit.getBotao : TButton;
begin
  Result := fBotao;
end;

procedure TWDCustomChaveEdit.SetBotao(const Value: TButton);
begin
  if fBotao <> Value then
  begin
    fBotao := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;


procedure TWDCustomChaveEdit.SetChave(Value: TChave);
begin
  Chave.Assign(Value);
end;


procedure TWDCustomChaveEdit.SetDependencia(Value: TDependencia);
begin
  Dependencia.Assign(Value);
end;


procedure TWDCustomChaveEdit.KeyDown(var Key: Word; Shift: TShiftState);
var
 i : integer;
begin
  if (Key = Vk_F3)and(Assigned(fBotao))and(self.Field.DataSet.CanModify)and(self.Enabled)and(not self.ReadOnly) then
    fBotao.Click;
  if (Key = Vk_Escape) then
  begin
    self.Field.Value := self.Field.OldValue;
    for i:= 0 to Pred(fChave.Count) do
    begin
       if assigned(Fchave[i].fField) then
       begin
         if DataSource.DataSet.State = dsbrowse then
           DataSource.DataSet.Edit;
         Fchave[i].fField.Value := Fchave[i].fField.OldValue; 
       end
    end;
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TWDCustomChaveEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = fBotao  ) then fBotao := nil;
    if (AComponent = fConexao) then fConexao := nil;
  end;
end;

function TWDCustomChaveEdit.atualiza : boolean;
var
  DS : TSQLDataSet;
  Query, Where, campo : String;
  i : integer;
  Formato : TFormatSettings;
begin
  Result:= False;
//  DS := TSQLDataSet.Create(nil);

  {$WARN SYMBOL_PLATFORM OFF}
  formato := TFormatSettings.Create(LCID_INSTALLED);
  {$WARN SYMBOL_PLATFORM ON}

  Formato.DecimalSeparator := '.';
  Formato.ThousandSeparator := ',';
  Formato.ShortDateFormat := 'MM/DD/YYYY';
  Formato.LongDateFormat:= 'MM/DD/YYYY';
  try
    if Assigned(fConexao) then
    begin
      if (fSQL.Text <> '') then
      begin
        if (Trim(self.Text)<>'')and(self.Text <> fMascaraVazio) then
        begin
          Query := fSQL.Text;
          where := ' where ';
          if AnsiContainsText(Query, 'where') then
             where := ' and ';
          //dependencias
          for i:= 0 to Pred(fDependencia.Count) do
          begin
            if (fDependencia.Items[i].fField.IsNull) then
            begin
              if (fDependencia.Items[i].fObrigatorio) then
              begin
                Result := False;
                fErro := 'Campo depende de "'+fDependencia.Items[i].fField.DisplayLabel+'"';
                exit;
              end
              else //se a dependencia nao eh obrigatorio pula
                continue;
            end;
            if Trim(fDependencia.Items[i].fcampo) = '' then
              campo := fDependencia.Items[i].fField.FieldName
            else
              campo := fDependencia.Items[i].fcampo;
            Query := Query + where + campo +'=';
            case fDependencia.Items[i].fField.DataType of
              ftstring: Query := Query + QuotedStr(fDependencia.Items[i].fField.AsString);
              ftInteger, ftSmallint: Query := Query + fDependencia.Items[i].fField.AsString;
              ftFloat, ftFMTBcd, ftBCD: Query := Query + FormatFloat('0.#',fDependencia.Items[i].fField.AsFloat,Formato);
              ftDateTime:  Query := Query + FormatDateTime('MM/DD/YYYY hh:nn:ss',fDependencia.Items[i].fField.AsDateTime);
              ftTime: Query := Query + FormatDateTime('hh:nn:ss',fDependencia.Items[i].fField.AsDateTime);
              ftDate: Query := Query + FormatDateTime('MM/DD/YYYY',fDependencia.Items[i].fField.AsDateTime);
            end;
            where := ' and ';
          end;
          if Trim(fCampoChave) <> '' then
            Query := Query + where + fCampoChave+'='
          else
            Query := Query + where + self.Field.FieldName+'=';
          case self.Field.DataType of
            ftstring: Query := Query + QuotedStr(self.Text);
            ftInteger, ftFMTBcd, ftSmallint, ftLargeint: Query := Query + self.Text;
            ftFloat, ftBCD: Query := Query + FormatFloat('0.#',self.Field.AsFloat,Formato);
            ftDateTime:  Query := Query + FormatDateTime('MM/DD/YYYY hh:nn:ss',self.Field.AsDateTime);
            ftTime: Query := Query + FormatDateTime('hh:nn:ss',self.Field.AsDateTime);
            ftDate: Query := Query + FormatDateTime('MM/DD/YYYY',self.Field.AsDateTime);
          end;
          fConexao.Execute(Query,nil,@DS);
          Result := not Ds.IsEmpty;
        end
        else
          Result := True;

        for i:= 0 to Pred(fChave.Count) do
        begin
          if assigned(Fchave[i].fField) then
          begin
            if DataSource.DataSet.State = dsbrowse then
              DataSource.DataSet.Edit;

            if Assigned(DS) and  ( Ds.Active ) and ( result ) then // Só faz se o dataset estiver ativo e result for verdadeiro... para consertar o bug do D10
            begin
              if fSobreescreveNulo or ( ( not fSobreescreveNulo and ( DS.Fields[i].AsString <> '' ) ) ) then
                Fchave[i].fField.Value := DS.Fields[i].Value
            end
            else
              Fchave[i].fField.Clear;
          end
        end;
        if (Result) and (Assigned(OnAtualiza)) then OnAtualiza(self) ;
      end
    end
    else
    begin
      msgAlerta('WDChave: a propriedade Conexao não foi configurada!');
    end;
  finally
    DS.Free;
  end;
end;


procedure TWDCustomChaveEdit.BeforeExit(var ExitMessage: TWMKillFocus);
begin
  if GetParentForm( self ).Showing then
    if self.Modified then
      if not atualiza then
      begin
          ExitMessage.Msg := 6;
          if fErro <> '' then
          begin
            msgAlerta(fErro);
            fErro := '';
          end
          else
            self.Color := clRed;
            //msgAlerta(fMensagem);
      end
      else
        self.Color := corOriginal;
  inherited;
end;

function TWDCustomChaveEdit.GetConexao: TSQLConnection;
begin
  Result := fConexao;
end;

procedure TWDCustomChaveEdit.SetConexao(const Value: TSQLConnection);
begin
  if fConexao <> Value then
  begin
    fConexao := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;


procedure TWDCustomChaveEdit.SetSQL(Value: TStrings);
begin
  if SQL.Text <> Value.Text then
  begin
    SQL.BeginUpdate;
    try
      SQL.Assign(Value);
    finally
      SQL.EndUpdate;
    end;
  end;
end;

{ TChaveItem }

constructor TChaveItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TChaveItem.Destroy;
begin
  inherited Destroy;
end;

function TChaveItem.GetChaveEdit: TWDCustomChaveEdit;
begin
  if Assigned(Collection) and (Collection is TChave) then
    Result := TChave(Collection).ChaveEdit
  else
    Result := nil;
end;

{function TChaveItem.GetDisplayName: string;
begin
  Result := fField.FieldName;
end;}

function TChaveItem.GetField: TField;
begin
  Result := fField;
end;


procedure TChaveItem.SetField(Value: TField);
begin
  if fField <> Value then
  begin
    fField := Value;
    { TODO : aqui }
    //if Value <> nil then Value.FreeNotification(Self);
  end;
end;

{ TChave }

function TChave.Add: TChaveItem;
begin
  Result := TChaveItem(inherited Add);
end;

constructor TChave.Create(ChaveEdit: TWdCustomChaveEdit; ChaveClass: TChaveClass);
begin
  inherited Create(ChaveClass);
  fChaveEdit := ChaveEdit;
end;

function TChave.GetChaveItem(Index: Integer): TChaveItem;
begin
  Result := TChaveItem(inherited Items[Index]);
end;

function TChave.GetOwner: TPersistent;
begin
  Result := FChaveEdit;
end;

procedure TChave.SetChaveItem(Index: Integer; Value: TChaveItem);
begin
  Items[Index].Assign(Value);
end;


{ TDependenciaItem }

constructor TDependenciaItem.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  fObrigatorio := True;
end;

function TDependenciaItem.GetChaveEdit: TWDCustomChaveEdit;
begin
  if Assigned(Collection) and (Collection is TDependencia) then
    Result := TDependencia(Collection).ChaveEdit
  else
    Result := nil;
end;

function TDependenciaItem.GetField: TField;
begin
  Result := fField;
end;


procedure TDependenciaItem.SetField(Value: TField);
begin
  if fField <> Value then
  begin
    fField := Value;
    { TODO : aqui }
    //if Value <> nil then Value.FreeNotification(Self);
  end;
end;


{ TDependencia }

function TDependencia.Add: TDependenciaItem;
begin
  Result := TDependenciaItem(inherited Add) ;
end;

constructor TDependencia.Create(ChaveEdit: TWdCustomChaveEdit; DependenciaClass: TDependenciaClass);
begin
  inherited Create(DependenciaClass) ;
  fChaveEdit := ChaveEdit ; 
end;

destructor TDependencia.Destroy;
begin

  inherited;
end;

function TDependencia.GetDependenciaItem(Index: Integer): TDependenciaItem;
begin
  Result := TDependenciaItem(inherited Items[Index]) ;
end;

function TDependencia.GetOwner: TPersistent;
begin
  Result := FChaveEdit ;
end;

procedure TDependencia.SetDependenciaItem(Index: Integer; Value: TDependenciaItem);
begin
  Items[Index].Assign(Value) ;
end;

end.
