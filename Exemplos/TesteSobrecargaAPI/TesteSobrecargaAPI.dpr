program TesteSobrecargaAPI;

uses
  System.StartUpCopy,
  FMX.Forms,
  FrmTesteAPI in 'FrmTesteAPI.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
