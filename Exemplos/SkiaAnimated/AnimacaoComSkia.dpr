program AnimacaoComSkia;

uses
  System.StartUpCopy,
  FMX.Forms,
  Skia.FMX,
  uMain in 'uMain.pas' {Main};

{$R *.res}

begin
  GlobalUseSkia := True;
  Application.Initialize;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
