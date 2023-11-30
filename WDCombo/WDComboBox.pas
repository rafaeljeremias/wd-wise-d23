unit WDComboBox;

interface

uses
  SysUtils, Classes, Controls, StdCtrls, Dialogs;

type
  TWDComboBox = class(TComboBox)
  private
    fValues: TStringList;
    procedure setValues(v: TStrings);
    function getValues: TStrings;
  protected

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function getValor: String;
  published
    property Values: TStrings read getValues write setValues;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Wise Developer', [TWDComboBox]);
end;

constructor TWDComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fValues := TStringList.Create;
end;

destructor TWDComboBox.Destroy;
begin
  fValues.Free;
  inherited;
end;

function TWDComboBox.getValor: String;
begin
  if Items.Count = fValues.Count then
    if ItemIndex >= 0 then
      result := fValues.Strings[ItemIndex]
    else
      result := ''  
  else
    showmessage('Número de itens diferente do número de valores associados');    
end;

function TWDComboBox.getValues: TStrings;
begin
  result := fValues;
end;

procedure TWDComboBox.setValues(v: TStrings);
begin
  fValues.Assign(v);
end;

end.








