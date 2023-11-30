unit WDPrinterPreviewUnit;

interface

uses Forms, StdCtrls, Controls, Classes, ExtCtrls, Gauges, Buttons, Windows, Messages,
     Spin, SysUtils, ComCtrls, DB, DBClient, Grids, DBGrids, Graphics, Mask, MidasLib;

type
  TWDPrinterPreviewForm = class(TForm)
    BotoesPanel: TPanel;
    ReguaPanel: TPanel;
    ReguaLabel: TLabel;
    ImprimirButton: TButton;
    SairButton: TButton;
    ZoomMaisButton: TSpeedButton;
    ReguaLabel2: TLabel;
    PaginaButton: TSpeedButton;
    FirstButton: TSpeedButton;
    PrevButton: TSpeedButton;
    NextButton: TSpeedButton;
    LastButton: TSpeedButton;
    StatusBar: TStatusBar;
    FundoButton: TSpeedButton;
    corFonteButton: TSpeedButton;
    FonteComboBox: TComboBox;
    ZoomMenosBtutton: TSpeedButton;
    LocalizarButton: TSpeedButton;
    IntervaloEdit: TEdit;
    Grid: TDBGrid;
    Tb: TClientDataSet;
    TbPagina: TIntegerField;
    DS: TDataSource;
    TbLinha: TStringField;
    TbPaginaLinha: TIntegerField;
    corButton: TSpeedButton;
    FonteSelecaoButton: TSpeedButton;
    PadraoButton: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ImprimirButtonClick(Sender: TObject);
    procedure TbAfterScroll(DataSet: TDataSet);
    procedure GridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure SairButtonClick(Sender: TObject);
  public
    PaginaTotal: Integer;
    Imprimiu   : Boolean;
  end;

var
  WDPrinterPreviewForm: TWDPrinterPreviewForm;

implementation

uses StrUtils;

{$R *.DFM}


procedure TWDPrinterPreviewForm.FormActivate(Sender: TObject);
var
  S, S2: string;
  I: Integer;
begin
  WindowState    := wsMaximized;


  if Screen.Width = 800 then
    S := DupeString('|', 110)
  else
    S := DupeString('|', 140);
  S2 := '';
  for I := 1 to Length(S) do
    if (I mod 10) = 0 then
    begin
      if I < 100 then S2 := S2 + IntToStr(I)[1] else S2 := S2 + IntToStr(I)[2];
    end
    else
      S2 := S2 + #32;

  Insert('&', S , 80);
  Insert('&', S2, 80);
  ReguaLabel.Caption  := S2;
  ReguaLabel2.Caption := S;
end;

procedure TWDPrinterPreviewForm.FormCreate(Sender: TObject);
begin
  Imprimiu := False;
  Tb.LogChanges := False;
end;

procedure TWDPrinterPreviewForm.FormShow(Sender: TObject);
var
  I : Integer;
begin
  FonteComboBox.Items.Clear;
  Canvas.Font.Size := 10;
  for I := 0 to Screen.Fonts.Count-1 do
  begin
    Canvas.Font.Name := Screen.Fonts[I];
    if (Canvas.TextWidth('I') = Canvas.TextWidth('M')) then
      FonteComboBox.Items.Add(Screen.Fonts[I]);
  end;
  FonteComboBox.ItemIndex := FonteComboBox.Items.IndexOf('Courier New');
end;

procedure TWDPrinterPreviewForm.ImprimirButtonClick(Sender: TObject);
begin
  Imprimiu := True;
  Close;
end;


procedure TWDPrinterPreviewForm.TbAfterScroll(DataSet: TDataSet);
begin
  StatusBar.Panels[0].Text:= 'Pág.: ' + TbPagina.AsString + ' de ' + IntToStr(PaginaTotal);
end;

procedure TWDPrinterPreviewForm.GridDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  with Grid do
    if (State = [gdSelected]) or (State = [gdFocused]) or
       (State = [gdSelected,gdFocused]) then
    begin
      Canvas.Brush.Color := clNavy;
      Canvas.Font.Color  := clWhite;
      Canvas.FillRect(Rect);
      DefaultDrawDataCell(Rect, Column.Field, State);
    end;
end;

procedure TWDPrinterPreviewForm.SairButtonClick(Sender: TObject);
begin
  close;
end;

end.
