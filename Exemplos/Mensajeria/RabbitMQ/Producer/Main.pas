unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, StompClient, FMX.Memo.Types,
  FMX.ScrollBox, FMX.Memo, FMX.Effects;

type
  TfrmMain = class(TForm)
    lbFila: TLabel;
    RecToolBar: TRectangle;
    ShadowEffect1: TShadowEffect;
    MemoMensagem: TMemo;
    Label1: TLabel;
    btnEnviar: TRectangle;
    lbEnviar: TLabel;
    ShadowEffectBtn: TShadowEffect;
    procedure FormCreate(Sender: TObject);
    procedure btnEnviarMouseEnter(Sender: TObject);
    procedure btnEnviarMouseLeave(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
  private
    procedure EnviarMensagemRabbit(msg: string);
    procedure CarregarDadosTela;
    { Private declarations }
  public
    { Public declarations }
  end;

const
  cEXCHANGE = 'exvenda';
  cROUTE = 'venda';

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.btnEnviarClick(Sender: TObject);
begin
  EnviarMensagemRabbit(MemoMensagem.Lines.Text);
end;

procedure TfrmMain.btnEnviarMouseEnter(Sender: TObject);
begin
  ShadowEffectBtn.Enabled := true;
end;

procedure TfrmMain.btnEnviarMouseLeave(Sender: TObject);
begin
  ShadowEffectBtn.Enabled := false;
end;

procedure TfrmMain.CarregarDadosTela;
begin
  lbFila.Text := Format('Caminho da exchange: /exchange/%s/%s', [cEXCHANGE, cROUTE]);
end;

procedure TfrmMain.EnviarMensagemRabbit(msg: string);
var StompCliente : IStompClient;
begin
  StompCliente := StompUtils.StompClient;
  StompCliente.Connect;
  try
    try
      StompCliente.Send(Format('/exchange/%s/%s', [cEXCHANGE, cROUTE]),
                        msg);
      MemoMensagem.Lines.Add('Mensagem enviada com sucesso.');
    except on E: Exception do
      raise Exception.Create('Error Message'+ e.Message);
    end;
  finally
    StompCliente.Disconnect;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  CarregarDadosTela;
end;

end.
