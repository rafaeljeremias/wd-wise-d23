unit WDSimplesEdit;

interface

uses
  Forms,
  dialogs,
  Classes,
  SqlExpr,
  Windows,
  Funcoes,
  SysUtils,
  Controls,
  StdCtrls,
  Messages,
  StrUtils,
  variants,
  Graphics;

type
  TWDCustomSimplesEdit = Class;

  TWDTipoChave    = (fdInteger, fdString, fdDate, fdDateTime);

  TAtualiza       = procedure(Sender: TObject) of object;

  TChaveItem = class(TCollectionItem)
  private
    fEdit: TCustomEdit;
    fTipo: TWDTipoChave;
    procedure SetEdit(Value: TCustomEdit); virtual;
    function  GetEdit: TCustomEdit;
    function GetChaveEdit: TWDCustomSimplesEdit;
  protected
    //function GetDisplayName: string; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property  ChaveEdit: TWDCustomSimplesEdit read GetChaveEdit;
    property  Edit: TCustomEdit read GetEdit write SetEdit;
    property  Tipo : TWDTipoChave read fTipo write fTipo;
  end;

  TChaveClass = class of TChaveItem;

  TChave = class(TCollection)
  private
    fChaveEdit: TWDCustomSimplesEdit;
    function GetChaveItem(Index: Integer): TChaveItem;
    procedure SetChaveItem(Index: Integer; Value: TChaveItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(ChaveEdit: TWdCustomSimplesEdit; ChaveClass: TChaveClass);
    function  Add: TChaveItem;
    property ChaveEdit: TWDCustomSimplesEdit read FChaveEdit;
    property Items[Index: Integer]: TChaveItem read GetChaveItem write SetChaveItem; default;
  end;

  TDependenciaItem = class(TCollectionItem)
  private
    fEdit: TCustomEdit;
    fcampo: String;
    fTipo: TWDTipoChave;
    fObrigatorio : boolean;
    procedure SetEdit(Value: TCustomEdit); virtual;
    function  GetEdit: TCustomEdit;
    function GetChaveEdit: TWDCustomSimplesEdit;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    property  ChaveEdit: TWDCustomSimplesEdit read GetChaveEdit;
    property  Campo: String read fCampo write fCampo;
    property  Edit: TCustomEdit read GetEdit write SetEdit;
    property  Tipo : TWDTipoChave read fTipo write fTipo;
    property  Obrigatorio: Boolean read fObrigatorio write fObrigatorio;
  end;

  TDependenciaClass = class of TDependenciaItem;

  TDependencia = class(TCollection)
  private
    fChaveEdit: TWDCustomSimplesEdit;
    function GetDependenciaItem(Index: Integer): TDependenciaItem;
    procedure SetDependenciaItem(Index: Integer; Value: TDependenciaItem);
  protected
    function GetOwner: TPersistent; override;
  public
    constructor Create(ChaveEdit: TWDCustomSimplesEdit; DependenciaClass: TDependenciaClass);
    function  Add: TDependenciaItem;
    property ChaveEdit: TWDCustomSimplesEdit read FChaveEdit;
    property Items[Index: Integer]: TDependenciaItem read GetDependenciaItem write SetDependenciaItem; default;
  end;

  TWDCustomSimplesEdit = class(TEdit)
  private
    corOriginal : TColor;
    fBotao : TButton;
    fSQL   : TStrings;
    fConexao : TSQLConnection;
    fChave   : TChave;
    fDependencia : TDependencia;
    fCampoChave : String;
    fMensagem : String;
    fTipo : TWDTipoChave;
    fOnAtualiza : TAtualiza;
    fSobreescreveNulo : boolean;

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
    property Tipo     : TWDTipoChave read fTipo write fTipo;
    property OnAtualiza  : TAtualiza  read fOnAtualiza write fOnAtualiza;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure BeforeExit(var ExitMessage: TWMKillFocus);   message wm_KillFocus;     // Antes de sair
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function atualiza : boolean;
  end;

  TWDSimplesEdit = class(TWDCustomSimplesEdit)
  published
    property Botao;
    property SQL;
    property Conexao;
    property Chave;
    property Dependencia;
    property CampoChave;
    property Mensagem;
    property Tipo;
    property OnAtualiza;
    property SobreescreveNulo;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Wise Developer', [TWDSimplesEdit]);
end;

constructor TWDCustomSimplesEdit.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  inherited Hint := 'F3 - Consulta';
  inherited  ShowHint := True;
  fBotao := nil;
  fChave := TChave.Create(self,TChaveItem);
  fDependencia := TDependencia.Create(self,TDependenciaItem);
  fSQL := TStringList.Create;
  fMensagem := 'Registro não Encontrado';
  fCampoChave := '';
  fTipo := fdInteger;
  corOriginal := self.Color;
  fSobreescreveNulo := true;


end;

destructor TWDCustomSimplesEdit.Destroy;
begin
  fSQL.Free;
  fChave.Free;
  fDependencia.Free;

  inherited;
end;

function TWDCustomSimplesEdit.getBotao : TButton;
begin
  Result := fBotao;
end;

procedure TWDCustomSimplesEdit.SetBotao(const Value: TButton);
begin
  if fBotao <> Value then
  begin
    fBotao := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure TWDCustomSimplesEdit.SetChave(Value: TChave);
begin
  Chave.Assign(Value);
end;

procedure TWDCustomSimplesEdit.SetDependencia(Value: TDependencia);
begin
  Dependencia.Assign(Value);
end;


procedure TWDCustomSimplesEdit.KeyPress(var Key: Char);
begin
  if ftipo = fdinteger then
  begin
    { not interested in control chars }
    if Ord(Key) < Ord(' ') then
    begin
      if Key = #13 then
        Key := #0
      else
        inherited KeyPress(Key);
      Exit;
    end;

    { allow only digits and minus sign }
    if not CharInSet(Key, ['0','1','2','3','4','5','6','7','8','9']) and (Key <> '-') then
      Key := #0;

    if Key <> #0 then
      inherited KeyPress(Key);
  end;
end;

procedure TWDCustomSimplesEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if (Key = Vk_F3)and(Assigned(fBotao))and(self.Enabled)and(not self.ReadOnly) then
    fBotao.Click;
  inherited KeyDown(Key, Shift)
end;

procedure TWDCustomSimplesEdit.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if (AComponent = fBotao  ) then fBotao := nil;
    if (AComponent = fConexao) then fConexao := nil;
  end;
end;

function TWDCustomSimplesEdit.atualiza : boolean;
var
  DS : TSQLDataSet;
  Query, where, campo : String;
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
        if (Trim(self.Text)<>'') then
        begin
          Query := fSQL.Text;
          where := ' where ';
          if AnsiContainsText(Query, 'where') then
            where := ' and ';
          //dependencias
          for i:= 0 to Pred(fDependencia.Count) do
          begin
            if Trim(fDependencia.Items[i].fEdit.Text) = '' then
            begin
              if (fDependencia.Items[i].fObrigatorio) then
              begin
                Result := False;
                exit;
              end
              else //se a dependencia nao eh obrigagoria pula
                continue;
            end;
            campo := fDependencia.Items[i].fCampo;
            Query := Query + where + campo +'=';
            case fDependencia.Items[i].fTipo of
              fdstring: Query := Query + QuotedStr(fDependencia.Items[i].fEdit.Text);
              fdInteger: Query := Query + fDependencia.Items[i].fEdit.Text;
              //ftFloat, ftFMTBcd, ftBCD: Query := Query + FormatFloat('0.#',fDependencia.Items[i].fField.AsFloat,Formato);
              //fdDateTime:  Query := Query + FormatDateTime('MM/DD/YYYY hh:nn:ss',fDependencia.Items[i].fField.AsDateTime);
              //ftTime: Query := Query + FormatDateTime('hh:nn:ss',fDependencia.Items[i].fField.AsDateTime);
              //fdDate: Query := Query + FormatDateTime('MM/DD/YYYY',fDependencia.Items[i].fField.AsDateTime);
            end;
            where := ' and ';
          end;
          Query := Query + Where+fCampoChave+'=';
          case ftipo of
            fdstring: Query := Query + QuotedStr(self.Text);
            fdInteger: Query := Query + self.Text;
          end;
          fConexao.Execute(Query,nil,@DS);
          Result := not Ds.IsEmpty;
        end
        else
          Result := True;

        for i:= 0 to Pred(fChave.Count) do
        begin
          if assigned(Fchave[i].fEdit) then
          begin
            if Assigned(DS)and(Ds.Active)and(not Ds.IsEmpty)and(result) then //Result Adicionado Devido a Bug do Delphi 10
              case fchave[i].Tipo of
                fdString, fdInteger:
                begin
                  if fSobreescreveNulo or ( ( not fSobreescreveNulo and ( DS.Fields[i].AsString <> '' ) ) ) then
                    Fchave[i].fEdit.Text := DS.Fields[i].AsString;
                end
              else
                Fchave[i].fEdit.Text := 'Tipo não implementado';
              end
            else
              Fchave[i].fEdit.Clear;
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


procedure TWDCustomSimplesEdit.BeforeExit(var ExitMessage: TWMKillFocus);
begin
  if GetParentForm( self ).Showing then
    if self.Modified then
      if not atualiza then
      begin
          ExitMessage.Msg := 6;
          self.Color := clRed;
          //msgAlerta(fMensagem);
      end
      else
        self.Color := corOriginal;

  inherited;
end;

function TWDCustomSimplesEdit.GetConexao: TSQLConnection;
begin
  Result := fConexao;
end;

procedure TWDCustomSimplesEdit.SetConexao(const Value: TSQLConnection);
begin
  if fConexao <> Value then
  begin
    fConexao := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;


procedure TWDCustomSimplesEdit.SetSQL(Value: TStrings);
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
  fTipo := fdString;
  inherited Create(Collection);
end;

destructor TChaveItem.Destroy;
begin
  inherited Destroy;
end;

function TChaveItem.GetChaveEdit: TWDCustomSimplesEdit;
begin
  if Assigned(Collection) and (Collection is TChave) then
    Result := TChave(Collection).ChaveEdit
  else
    Result := nil;
end;

function TChaveItem.GetEdit: TCustomEdit;
begin
  Result := fEdit;
end;


procedure TChaveItem.SetEdit(Value: TCustomEdit);
begin
  if fEdit <> Value then
  begin
    fEdit := Value;
    { TODO : aqui }
    //if Value <> nil then Value.FreeNotification(Self);
  end;
end;


{ TChave }

function TChave.Add: TChaveItem;
begin
  Result := TChaveItem(inherited Add);
end;

constructor TChave.Create(ChaveEdit: TWdCustomSimplesEdit; ChaveClass: TChaveClass);
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

destructor TDependenciaItem.Destroy;
begin
  inherited Destroy;
end;

function TDependenciaItem.GetChaveEdit: TWDCustomSimplesEdit;
begin
  if Assigned(Collection) and (Collection is TDependencia) then
    Result := TDependencia(Collection).ChaveEdit
  else
    Result := nil;
end;

function TDependenciaItem.GetEdit: TCustomEdit;
begin
  Result := fEdit;
end;


procedure TDependenciaItem.SetEdit(Value: TCustomEdit);
begin
  if fEdit <> Value then
  begin
    fEdit := Value;
    { TODO : aqui }
    //if Value <> nil then Value.FreeNotification(Self);
  end;
end;


{ TDependencia }

function TDependencia.Add: TDependenciaItem;
begin
  Result := TDependenciaItem(inherited Add) ;
end;

constructor TDependencia.Create(ChaveEdit: TWdCustomSimplesEdit; DependenciaClass: TDependenciaClass);
begin
  inherited Create(DependenciaClass) ;
  fChaveEdit := ChaveEdit ;
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
