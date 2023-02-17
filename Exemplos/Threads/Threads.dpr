program Threads;

uses
  Vcl.Forms,
  ufrmThreadAnonima in 'ufrmThreadAnonima.pas' {frmThreadAnonima},
  ufrmThreadDeclada in 'ufrmThreadDeclada.pas' {frmThreadDeclada};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmThreadDeclada, frmThreadDeclada);
  Application.CreateForm(TfrmThreadAnonima, frmThreadAnonima);
  Application.Run;
end.
