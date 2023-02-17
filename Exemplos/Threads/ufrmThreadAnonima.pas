unit ufrmThreadAnonima;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Threading;

type
  TfrmThreadAnonima = class(TForm)
    imgCar1: TImage;
    ImgCar2: TImage;
    Label1: TLabel;
    pnChegada: TPanel;
    btnIniciar: TButton;
    tmAtualizaGanhador: TTimer;
    pnGanhador: TPanel;
    Image1: TImage;
    procedure btnIniciarClick(Sender: TObject);
    procedure tmAtualizaGanhadorTimer(Sender: TObject);
  private
    { Private declarations }
    car1 : tthread;
    car2 : tthread;
    Procedure criarThreadsCarro1;
    Procedure criarThreadsCarro2;
  public
    { Public declarations }
  end;

var
  frmThreadAnonima: TfrmThreadAnonima;

implementation

{$R *.dfm}

procedure TfrmThreadAnonima.btnIniciarClick(Sender: TObject);
begin
  criarThreadsCarro1;
  criarThreadsCarro2;
  tmAtualizaGanhador.Enabled := true;
  car2.Start;
  car1.Start;
end;

procedure TfrmThreadAnonima.criarThreadsCarro1;
begin
  car1 := tThread.CreateAnonymousThread(
      procedure
      begin
          while ImgCar1.left < (pnChegada.Left - ImgCar1.Width) do
          begin
            TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              ImgCar1.left := ImgCar1.left + 20;
            end);
            tThread.Sleep(Random(700));
          end;

      end);
end;

procedure TfrmThreadAnonima.criarThreadsCarro2;
begin
  car2 := tThread.CreateAnonymousThread(
      procedure
      begin
          while ImgCar2.left < (pnChegada.Left - ImgCar2.Width) do
          begin
            TThread.Synchronize(TThread.CurrentThread,
            procedure
            begin
              ImgCar2.left := ImgCar2.left + 20;
            end);
            tThread.Sleep(Random(700));
          end;

      end);
end;

procedure TfrmThreadAnonima.tmAtualizaGanhadorTimer(Sender: TObject);
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

end.