unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Skia, Skia.FMX,
  FMX.Objects, FMX.Controls.Presentation, FMX.StdCtrls;

  {site com as animações: https://lottiefiles.com/}

type
  TMain = class(TForm)
    loading: TSkAnimatedImage;
    skiLove: TSkAnimatedImage;
    btnEnviar: TSkAnimatedImage;
    skiSend: TSkAnimatedImage;
    btnLove: TSkAnimatedImage;
    loadingSaber: TSkAnimatedImage;
    Label1: TLabel;
    Label2: TLabel;
    Splash: TSkAnimatedImage;
    Label3: TLabel;
    procedure btnEnviarClick(Sender: TObject);
    procedure btnLoveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

{$R *.fmx}

procedure TMain.btnEnviarClick(Sender: TObject);
begin
  skiSend.Visible := not skiSend.Visible;
  skiSend.Enabled := not skiSend.Enabled;
end;

procedure TMain.btnLoveClick(Sender: TObject);
begin
  skiLove.Visible := not skiLove.Visible;
  skiLove.Enabled := not skiLove.Enabled;
end;

end.
