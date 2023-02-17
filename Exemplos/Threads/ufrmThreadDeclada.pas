unit ufrmThreadDeclada;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg;

type
  tCar = class(TThread)
  protected
    procedure Execute; override;
  private
    lcar1 : Boolean;
  public
    constructor MeuCreate(Car1 : boolean);
  end;

  TfrmThreadDeclada = class(TForm)
    btnIniciar: TButton;
    Image1: TImage;
    imgCar1: TImage;
    ImgCar2: TImage;
    Label1: TLabel;
    pnChegada: TPanel;
    pnGanhador: TPanel;
    tmAtualizaGanhador: TTimer;
    procedure tmAtualizaGanhadorTimer(Sender: TObject);
    procedure btnIniciarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmThreadDeclada: TfrmThreadDeclada;

implementation

{$R *.dfm}

procedure TfrmThreadDeclada.btnIniciarClick(Sender: TObject);
begin
  tmAtualizaGanhador.Enabled := true;
  tCar.MeuCreate(false);
  tCar.MeuCreate(true);
end;

procedure TfrmThreadDeclada.tmAtualizaGanhadorTimer(Sender: TObject);
begin
  tmAtualizaGanhador.Enabled := false;
  if ImgCar2.left >= (pnChegada.Left - ImgCar2.Width) then
  begin
    pnGanhador.Caption := 'O carro cinza ganhou!';
    pnGanhador.Visible := true;
    exit;
  end
  else if ImgCar1.left >= (pnChegada.Left - ImgCar1.Width) then
  begin
    pnGanhador.Caption := 'O carro preto ganhou!';
    pnGanhador.Visible := true;
    exit;
  end;
  tmAtualizaGanhador.Enabled := true;
end;

{ tCar }

constructor tCar.MeuCreate(Car1: boolean);
begin
  inherited create(True);
  FreeOnTerminate := true;
  lcar1 := Car1;
  resume;
end;

procedure tCar.Execute;
begin
  if lcar1 then
  begin
    while frmThreadDeclada.ImgCar1.left < (frmThreadDeclada.pnChegada.Left - frmThreadDeclada.ImgCar1.Width) do
    begin
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        frmThreadDeclada.ImgCar1.left := frmThreadDeclada.ImgCar1.left + 20;
      end);
      tThread.Sleep(Random(700));
    end;
  end else
  begin
    while frmThreadDeclada.ImgCar2.left < (frmThreadDeclada.pnChegada.Left - frmThreadDeclada.ImgCar2.Width) do
    begin
      TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        frmThreadDeclada.ImgCar2.left := frmThreadDeclada.ImgCar2.left + 20;
      end);
      tThread.Sleep(Random(700));
    end;
  end;
end;

end.
