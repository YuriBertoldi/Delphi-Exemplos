program ExemploHelper;

uses
  Vcl.Forms,
  ufrmHelper in 'ufrmHelper.pas' {frmHelper};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmHelper, frmHelper);
  Application.Run;
end.
