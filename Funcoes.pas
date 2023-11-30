unit Funcoes;

interface

uses
  Vcl.Controls,
  Winapi.Windows,
  System.SysUtils,
  System.Win.Registry;

procedure msgAlerta(const Texto: string);
procedure msgInformaAbort(const Condicao: Boolean; const Texto: string; Foca: TWinControl = nil);
procedure GravaReg(const Path, Variavel, Valor: string); overload;
procedure GravaReg(const Path, Variavel: string; const Valor: Integer); overload;
procedure GravaReg(const Path, Variavel: string; const Valor: Double); overload;
procedure GravaReg(const Path, Variavel: string; const Valor: Boolean); overload;

function AlinhaEsq(const Palavra: string; Tamanho: Integer; Caracter: Char = #32): string;
function AlinhaDir(const Palavra: string; Tamanho: Integer; Caracter: Char = #32): string;
function AlinhaCentro(const Palavra: string; Tamanho: Integer; Caracter: Char = #32): string;
function LerReg(const Path, Variavel: string; const ValorDefault: string): string; overload;
function LerReg(const Path, Variavel: string; const ValorDefault: Integer): Integer; overload;
function LerReg(const Path, Variavel: string; const ValorDefault: Double): Double; overload;
function LerReg(const Path, Variavel: string; const ValorDefault: Boolean): Boolean; overload;
function TiraAcentos(const Texto: string): string;

implementation

procedure msgAlerta(const texto: string);
begin
  MessageBeep(MB_ICONEXCLAMATION);
  MessageBox(0, pchar( Texto ), 'Alerta', MB_ICONWARNING or MB_OK or MB_TOPMOST);
end;

function LerReg(const Path, Variavel: string; const ValorDefault: string)
  : string; overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  if Reg.ValueExists(Variavel) then
    Result := Reg.ReadString(Variavel)
  else
    Result := ValorDefault;
  FreeAndNil(Reg);
end;

function LerReg(const Path, Variavel: string; const ValorDefault: Integer)
  : Integer; overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  if Reg.ValueExists(Variavel) then
    Result := Reg.ReadInteger(Variavel)
  else
    Result := ValorDefault;
  FreeAndNil(Reg);
end;

function LerReg(const Path, Variavel: string; const ValorDefault: Double)
  : Double; overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  if Reg.ValueExists(Variavel) then
    Result := Reg.ReadFloat(Variavel)
  else
    Result := ValorDefault;
  FreeAndNil(Reg);
end;

function LerReg(const Path, Variavel: string; const ValorDefault: Boolean)
  : Boolean; overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  if Reg.ValueExists(Variavel) then
    Result := Reg.ReadBool(Variavel)
  else
    Result := ValorDefault;
  FreeAndNil(Reg);
end;

procedure GravaReg(const Path, Variavel, Valor: string); overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  // Reg.RootKey := HKEY_CURRENT_USER;
  // Reg.CreateKey(Path);
  Reg.OpenKey(Path, True);
  Reg.WriteString(Variavel, Valor);
  FreeAndNil(Reg);
end;

procedure GravaReg(const Path, Variavel: string; const Valor: Integer);
  overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  Reg.WriteInteger(Variavel, Valor);
  FreeAndNil(Reg);
end;

procedure GravaReg(const Path, Variavel: string; const Valor: Double); overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  Reg.WriteFloat(Variavel, Valor);
  FreeAndNil(Reg);
end;

procedure GravaReg(const Path, Variavel: string; const Valor: Boolean); overload;
var
  Reg: TRegistry;
Begin
  Reg := TRegistry.Create;
  Reg.OpenKey(Path, True);
  Reg.WriteBool(Variavel, Valor);
  FreeAndNil(Reg);
end;

function TiraAcentos(const Texto: string): string;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Texto) do
    case Texto[i] of
      '�', '�', '�', '�', '�':
        Result := Result + 'a';
      '�', '�', '�', '�', '�':
        Result := Result + 'A';
      '�', '�', '�', '�':
        Result := Result + 'e';
      '�', '�', '�', '�':
        Result := Result + 'E';
      '�', '�', '�', '�':
        Result := Result + 'i';
      '�', '�', '�', '�':
        Result := Result + 'I';
      '�', '�', '�', '�', '�':
        Result := Result + 'o';
      '�', '�', '�', '�', '�':
        Result := Result + 'O';
      '�', '�', '�', '�':
        Result := Result + 'u';
      '�', '�', '�', '�':
        Result := Result + 'U';
      '�':
        Result := Result + 'C';
      '�':
        Result := Result + 'c';
      '�':
        Result := Result + 'n';
      '�':
        Result := Result + 'N';
      '�':
        Result := Result + 'a';
      '�':
        Result := Result + 'o';
    else
      Result := Result + Texto[i];
    end;
end;

procedure msgInformaAbort(const Condicao: Boolean; const Texto: string;
  Foca: TWinControl = nil);
begin
  if not Condicao then
    Exit;
  MessageBeep(MB_ICONQUESTION);
  if Texto <> '' Then
    msgAlerta(Texto);
  if Assigned(Foca) then
    TWinControl(Foca).SetFocus;

  Abort;
end;

function AlinhaEsq(const Palavra: string; Tamanho: Integer;
    Caracter: Char = #32): String;
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

function AlinhaDir(const Palavra: string; Tamanho: Integer;
  Caracter: Char = #32): String;
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

function AlinhaCentro(const Palavra: string; Tamanho: Integer;
  Caracter: Char = #32): String;
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

end.
