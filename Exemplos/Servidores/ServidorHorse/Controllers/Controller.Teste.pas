unit Controller.Teste;

interface

uses Horse,
     JSON,
     SysUtils,
     StrUtils;

procedure RegistrarRotas;
procedure TesteConexao(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
procedure ReverseString(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);

implementation

procedure RegistrarRotas;
begin
  THorse.Get('/v1/Teste/TesteConexao', TesteConexao);
  THorse.Get('/v1/Teste/ReverseString/:value', ReverseString);
end;

procedure TesteConexao(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
begin
  Res.Send('Servidor Operante');
end;

procedure ReverseString(Req: THorseRequest; Res: THorseResponse; Next: TNextProc);
begin
  Res.Send(AnsiReverseString(req.Params['value']));
end;



end.
