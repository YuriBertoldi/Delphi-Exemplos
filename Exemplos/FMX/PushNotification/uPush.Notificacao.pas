unit uPush.Notificacao;

interface

uses
  {$IFDEF ANDROID}
  FMX.PushNotification.Android,
  FMX.Platform,
  {$ENDIF}
  {$IFDEF IOS}
  FMX.PushNotification.FCM.iOS,
  FMX.Platform,
  {$ENDIF}

  System.PushNotification, System.Notification, System.JSON,
  System.Classes, System.Net.HttpClient, System.SysUtils;

  type
  Tpush = class
  private
    FPushService: TPushService;
    FPushServiceConnection: TPushServiceConnection;
    FToken: String;
    procedure OnServiceConnectionChange(Sender: TObject;
      PushChanges: TPushService.TChanges);
    procedure OnServiceConnectionReceiveNotification(Sender: TObject;
      const ServiceNotification: TPushServiceNotification);
    procedure LimparNotificacao;
    {$IFDEF MSWINDOWS}
    {$ELSE}
    function AppEventProc(AAppEvent: TApplicationEvent;
      AContext: TObject): Boolean;
    {$ENDIF}
    procedure SetPushService(const Value: TPushService);
    procedure SetPushServiceConnection(const Value: TPushServiceConnection);
    procedure SetToken(const Value: String);
    procedure InstanciarComponentes;
  public
    destructor Destroy; override;
    constructor create;
    property PushService: TPushService read FPushService write SetPushService;
    property PushServiceConnection: TPushServiceConnection read FPushServiceConnection write SetPushServiceConnection;
    property Token : String read FToken write SetToken;

  end;

  const xURLgoogle = 'https://fcm.googleapis.com/fcm/send';
  procedure EnviarPush(aTokenCelular, aAPIfirebase, aMensagem : string);

implementation

{ Tpush }

{$REGION 'PUSH MOBILE'}
procedure Tpush.SetPushService(const Value: TPushService);
begin
  FPushService := Value;
end;

procedure Tpush.SetPushServiceConnection(const Value: TPushServiceConnection);
begin
  FPushServiceConnection := Value;
end;

procedure Tpush.SetToken(const Value: String);
begin
  FToken := Value;
end;

procedure Tpush.InstanciarComponentes;
{$IFDEF MSWINDOWS}
{$ELSE}
var
    AppEvent : IFMXApplicationEventService;
{$ENDIF}
begin
  //Por motivos divinos e delphianos a diretiva IFDEF IOS não funciona, por isso o ID DEF WINDOWS vazia
  {$IFDEF MSWINDOWS}
  {$ELSE}
  // Eventos do app (para exclusao das notificacoes)...
  if TPlatformServices.Current.SupportsPlatformService(IFMXApplicationEventService, IInterface(AppEvent)) then
      AppEvent.SetApplicationEventHandler(AppEventProc);

  FPushService := TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.FCM);
  FPushServiceConnection                       := TPushServiceConnection.Create(FPushService);

  FPushServiceConnection.OnChange              := OnServiceConnectionChange;
  FPushServiceConnection.OnReceiveNotification := OnServiceConnectionReceiveNotification;

  FPushServiceConnection.Active                := True;
  {$ENDIF}
end;

constructor Tpush.create;
begin
  InstanciarComponentes;
end;

destructor Tpush.Destroy;
begin
  FPushServiceConnection.Free;
  inherited;
end;

{$IFDEF MSWINDOWS}
{$ELSE}
function Tpush.AppEventProc(AAppEvent: TApplicationEvent;
  AContext: TObject): Boolean;
begin
    if (AAppEvent = TApplicationEvent.BecameActive) then
        LimparNotificacao;
end;
{$ENDIF}

procedure Tpush.LimparNotificacao;
begin
  //NotificationCenter.CancelAll;
end;

procedure Tpush.OnServiceConnectionChange(Sender: TObject;
  PushChanges: TPushService.TChanges);
begin
    if TPushService.TChange.Status in PushChanges then
    begin
        if FPushService.Status = TPushService.TStatus.Started then
        begin
            //log para saber se foi iniciado com suscesso
            //memoTeste.Lines.Add('Sucesso');
        end
        else if FPushService.Status = TPushService.TStatus.StartupError then
        begin
            FPushServiceConnection.Active := False;
            //memoTeste.Lines.Add('erro');
            //log para saber que deu erro ao iniciar o serviço
        end;
    end;

    if TPushService.TChange.DeviceToken in PushChanges then
    begin
        FToken := FPushService.DeviceTokenValue[TPushService.TDeviceTokenNames.DeviceToken];

//        memoTeste.Lines.Add('Device token received');
//        memoTeste.Lines.Add('Device identifier: ' + FPushService.DeviceIDValue[TPushService.TDeviceIDNames.DeviceId]);
//        memoTeste.Lines.Add('Device token: ' + FToken);
    end;
end;

procedure Tpush.OnServiceConnectionReceiveNotification(Sender: TObject;
  const ServiceNotification: TPushServiceNotification);
begin
// recebe notificacao com app aberto, nao implentado ainda, por nao sentir necessidade.
end;

{$ENDREGION 'PUSH MOBILE'}

{$REGION 'ENVIO PUSH - SERVIDOR'}

procedure EnviarPush(aTokenCelular, aAPIfirebase, aMensagem : string);
var
    xClient: THTTPClient;
    xJson : TJSONObject;
    xJsonData : TJSONObject;
    xData : TStringStream;
    xResponseContent : TStringStream;
Begin
  try
      try
          xJson := TJSONObject.Create;
          xJson.AddPair('to', aTokenCelular);

          xJsonData := TJSONObject.Create;
          xJsonData.AddPair('body', aMensagem);
          xJsonData.AddPair('sound', 'default');

          xJson.AddPair('notification', xJsonData);

          xJsonData := TJSONObject.Create;
          xJsonData.AddPair('mensagem', aMensagem);

          xJson.AddPair('data', xJsonData);


          xclient := THTTPClient.Create;
          xclient.ContentType := 'application/json';
          xclient.CustomHeaders['Authorization'] := 'key=' + aAPIfirebase;

          // Correção para acentuacao com UTF8...
          xData := TStringStream.Create(xJson.ToString, TEncoding.UTF8);
          xData.Position := 0;

          xResponseContent := TStringStream.Create;

          xclient.Post(xURLgoogle, xData, xResponseContent);
          xResponseContent.Position := 0;
      finally
          xData.DisposeOf;
          xJson.DisposeOf;
          xclient.DisposeOf;
          xResponseContent.DisposeOf;
      end;
  except on E:Exception do
      begin
          //colocar log
          abort;
      end;
  end;
End;

{$ENDREGION 'ENVIO PUSH - SERVIDOR'}

end.
