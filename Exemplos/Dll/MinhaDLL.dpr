library MinhaDLL;

uses
  System.SysUtils,
  System.Classes;

function Soma(a, b: Integer): Integer; stdcall;
begin
  Result := a + b;
end;

{$R *.res}
exports
  Soma;

begin
end.
