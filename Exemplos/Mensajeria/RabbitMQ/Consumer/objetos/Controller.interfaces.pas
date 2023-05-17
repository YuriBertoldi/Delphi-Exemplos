unit Controller.interfaces;

interface

uses StompClient;

type
  IController = interface
    ['{C38764B7-6972-422B-A354-5883BE73C04E}']

    procedure IniciarConsumo;

    function getStompClient : IStompClient;
    function getStompFrame : IStompFrame;
    procedure SetStompClient(value : IStompClient);
    procedure SetStompFrame(value : IStompFrame);

    property StompCliente: IStompClient read getStompClient write SetStompClient;
    property StompFrame: IStompFrame read getStompFrame write SetStompFrame;
  end;

implementation

end.
