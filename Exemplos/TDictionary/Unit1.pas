unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, System.Generics.Collections,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    dictionary : TObjectDictionary<INTEGER, STRING>;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
begin
  dictionary := tobjectDictionary<INTEGER, STRING>.Create;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to 5 do
    dictionary.Add(I, INTToStr(i));

 dictionary.Add(8, '8');
 dictionary.Add(6, '6');
end;

procedure TForm1.Button3Click(Sender: TObject);
var x : TPair<integer, string>;
begin
  for x in dictionary.ToArray do
  begin
    Memo1.Lines.Add(x.Value)
  end;
end;

end.
