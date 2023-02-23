program SvrHorse;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  IdSSLOpenSSL,
  JSON,
  Horse,
  Horse.GBSwagger,
  Horse.BasicAuthentication,
  Horse.Jhonson,
  Horse.CORS,
  Horse.HandleException,
  Horse.Compression,
  SysUtils,
  uMainSvrHorse,
  Controller.Teste in 'Controllers\Controller.Teste.pas',
  Controller.Teste.Documentacao in 'Documentacao\Controller.Teste.Documentacao.pas';

begin
  IniciarServidorHorse(True);
end.
