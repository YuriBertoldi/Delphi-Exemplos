unit frmPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uDWAbout,
  uRESTDWBase, FMX.StdCtrls, FMX.Controls.Presentation;

type
  TfServer = class(TForm)
    lbStatus: TLabel;
    SwitchAtivaServer: TSwitch;
    RESTServicePooler: TRESTServicePooler;
    lbInstrucao: TLabel;
    procedure SwitchAtivaServerSwitch(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fServer: TfServer;

implementation

{$R *.fmx}

uses serverMetod;

procedure TfServer.FormCreate(Sender: TObject);
begin
    RESTServicePooler.ServerMethodClass  := Tdm;
    RESTServicePooler.Active := SwitchAtivaServer.IsChecked;
end;

procedure TfServer.SwitchAtivaServerSwitch(Sender: TObject);
begin
    RESTServicePooler.Active := SwitchAtivaServer.IsChecked;
    if RESTServicePooler.Active then
        lbStatus.Text :=  ' Servidor Ativo!!'
    else
        lbStatus.Text :=  ' Servidor Inativo!!'
end;

end.
