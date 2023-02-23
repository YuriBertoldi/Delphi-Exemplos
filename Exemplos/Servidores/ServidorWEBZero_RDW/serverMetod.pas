unit serverMetod;

interface

uses
  System.SysUtils, System.Classes, uDWDataModule, uDWAbout, uRESTDWServerEvents,
  uDWJSONObject, System.JSON, Data.DB;

type
  Tdm = class(TServerMethodDataModule)
    DWEvents: TDWServerEvents;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses frmPrincipal;

{$R *.dfm}


end.
