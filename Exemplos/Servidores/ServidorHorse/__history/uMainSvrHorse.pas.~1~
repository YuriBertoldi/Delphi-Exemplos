unit uMainSvrHorse;

interface

uses
  IdSSLOpenSSL,
  JSON,
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  Horse.GBSwagger,
  Horse.BasicAuthentication,
  Horse.CORS,
  Horse.Compression,
  Horse.OctetStream,
  SysUtils,
  FireDAC.Comp.Client,
  Windows,
  midasLib,
  Controller.Teste,
  Controller.Teste.Documentacao;

  procedure SwaggerConfig;
  procedure ConfigurarDocumentacao;
  procedure ConfigurarMiddlewares;
  procedure ConfigurarCertificadoSSL;
  procedure ConfigurarRotas;
  procedure IniciarServidorHorse(aConsole: Boolean);

implementation

procedure SwaggerConfig;
begin
  with swagger.Info do
  begin
      Title('Servidor teste');
      Description('API Zerada');
      Contact.Name('Contato @@@@@@@');
      Contact.Email('******@**********.com.br');
      Contact.URL('http://www.***************.com.br');
  end;
  Swagger.BasePath('v1');
  Swagger.AddBasicSecurity;
end;

procedure ConfigurarDocumentacao;
begin
  SwaggerConfig;

  Controller.teste.Documentacao.SwaggerDocumentacao;
end;

procedure ConfigurarCertificadoSSL;
begin
  THorse.IOHandleSSL.SSLVersions := [sslvSSLv3, sslvTLSv1_2];
  THorse.IOHandleSSL.CertFile    := 'C:\Certificado\certificate.crt';
  THorse.IOHandleSSL.KeyFile     := 'C:\Certificado\private.key';
  THorse.IOHandleSSL.Active      := true;
end;

procedure ConfigurarMiddlewares;
begin
  HorseCORS
      .AllowedOrigin('*')
      .AllowedCredentials(True)
      .AllowedHeaders('*')
      .AllowedMethods('*')
      .ExposedHeaders('*');

  THorse.Use(Compression())
        .Use(Jhonson())
        .Use(HandleException)
        .Use(Compression())
        .Use(OctetStream)
        .Use(CORS)
        .Use(HorseSwagger)
        .Use(HorseBasicAuthentication(
        function(const AUsername, APassword: string): Boolean
        begin
            Result := AUsername.Equals('user') and APassword.Equals('password');
        end));

end;

procedure ConfigurarRotas;
begin
  controller.teste.RegistrarRotas;
end;

procedure IniciarServidorHorse(aConsole: Boolean);
begin
  ConfigurarDocumentacao;
  ConfigurarMiddlewares;
  {$IFDEF RELEASE}
  ConfigurarCertificadoSSL;
  {$ENDIF}
  ConfigurarRotas;

  THorse.Listen(9000,
  procedure(Horse: THorse)
  begin
      if aConsole then
      begin
          Writeln(Format('Server executando em: %s:%d', [Horse.Host, Horse.Port]));
      end;
  end);
end;

end.
