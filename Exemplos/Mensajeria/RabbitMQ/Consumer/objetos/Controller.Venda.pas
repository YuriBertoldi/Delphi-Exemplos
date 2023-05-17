unit Controller.Venda;

interface

uses Controller.interfaces, StompClient, System.Classes, System.SysUtils;

type
  TControllerVenda = class(TInterfacedObject, IController)
  private
    FStompCliente : IStompClient;
    FStompFrame: IStompFrame;
    FProcessando : boolean;
    function getStompClient: IStompClient;
    function getStompFrame: IStompFrame;
    procedure SetStompClient(Value: IStompClient);
    procedure SetStompFrame(Value: IStompFrame);
    procedure CriarObjsStomps;
    procedure InscreverNaLista;
    { private declarations }

  public
    { public declarations }
    constructor create;
    destructor destroy;

    procedure IniciarConsumo;

    property StompCliente: IStompClient read getStompClient write SetStompClient;
    property StompFrame: IStompFrame read getStompFrame write SetStompFrame;
  end;

  const FILA = '/queue/venda';

implementation

{ TControllerVenda }

constructor TControllerVenda.create;
begin
  FProcessando := true;
  CriarObjsStomps;
  InscreverNaLista;
end;

function TControllerVenda.getStompClient: IStompClient;
begin
  Result := FStompCliente;
end;

function TControllerVenda.getStompFrame: IStompFrame;
begin
  Result := FStompFrame;
end;

procedure TControllerVenda.IniciarConsumo;
begin
  while FProcessando do
  begin
    if FStompCliente.Receive(FStompFrame, 2000) then
    begin
      Sleep(100);
      Writeln(FILA, ': ', FStompFrame.Body);
      Writeln('ID', ': ', FStompFrame.GetHeaders.Value('message-id'));
    end
    else
      Writeln(FILA, ': ', 'Nenhuma mensagem encontrada');
  end;
end;

procedure TControllerVenda.InscreverNaLista;
begin
  FStompCliente.Subscribe(FILA, amAuto);
end;

procedure TControllerVenda.CriarObjsStomps;
begin
  FStompCliente := StompUtils
    .StompClient
    .Connect;
  FStompFrame := StompUtils.NewFrame;
end;

destructor TControllerVenda.destroy;
begin
  FProcessando := false;
end;

procedure TControllerVenda.SetStompClient(Value: IStompClient);
begin
  FStompCliente := value;
end;

procedure TControllerVenda.SetStompFrame(Value: IStompFrame);
begin
  FStompFrame := Value;
end;

end.
