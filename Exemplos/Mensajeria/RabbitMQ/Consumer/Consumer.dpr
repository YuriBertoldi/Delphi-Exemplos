program Consumer;

{$APPTYPE CONSOLE}

{$R *.res}

//Depencias: https://github.com/danieleteti/delphistompclient.git

uses
  System.SysUtils,
  Controller.Venda in '..\Consumer\objetos\Controller.Venda.pas',
  Controller.interfaces in '..\Consumer\objetos\Controller.interfaces.pas';

begin
  try
    VAR lControllerVenda : IController;
    lControllerVenda := TControllerVenda.create;
    lControllerVenda.IniciarConsumo;
    { TODO -oUser -cConsole Main : Insert code here }
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
