program Servidor;

uses
  System.StartUpCopy,
  FMX.Forms,
  frmPrincipal in 'frmPrincipal.pas' {fServer},
  serverMetod in 'serverMetod.pas' {dm: TServerMethodDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfServer, fServer);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
