unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Memo.Types,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  System.Generics.Collections, System.JSON, REST.Json;

type
  tJSONModificado = class Helper for  REST.Json.TJson
    class function JsonToObjectList<T: class, constructor>(AJsonArray: TJSONArray; AOptions: TJsonOptions = [joDateIsUTC, joDateFormatISO8601, joBytesFormatArray, joIndentCaseCamel]): tObjectList<T>;
  end;

  tTeste2 = class
    private
    Fbolo: integer;
    Fnome: string;
    procedure Setbolo(const Value: integer);
    procedure Setnome(const Value: string);

    public
      property nome : string  read Fnome write Setnome;
      property bolo : integer  read Fbolo write Setbolo;
  end;

  tTeste = class
    private
    Fidade: integer;
    Fnome: string;
    FTeste2: tTeste2;
    procedure Setidade(const Value: integer);
    procedure Setnome(const Value: string);
    procedure SetTeste2(const Value: tTeste2);

    public
      constructor create;
      property nome : string read Fnome write Setnome;
      property idade : integer read Fidade write Setidade;
      property Teste2 : tTeste2 read FTeste2 write SetTeste2;
      function ToJSON :TJSONObject;

  end;

  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
    xTestes : TObjectList<tTeste>;
    xJSONArray : tJSONArray;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Button1Click(Sender: TObject);
var
  I: Integer;
  xTeste : tTeste;
begin
  xTestes :=  TObjectList<tTeste>.create;

  for I := 0 to 10 do
  begin
    xTeste       := tTeste.Create;
    xTeste.nome  := 'Nome' + i.ToString;
    xTeste.idade := i;
    xTeste.Teste2.Fbolo := i;
    xTeste.Teste2.Fnome  := 'Nome2' + i.ToString;
    xTestes.Add(xTeste);
  end;
end;

{ tTeste }

constructor tTeste.create;
begin
  FTeste2:= tTeste2.create;
end;

procedure tTeste.Setidade(const Value: integer);
begin
  Fidade := Value;
end;

procedure tTeste.Setnome(const Value: string);
begin
  Fnome := Value;
end;

procedure tTeste.SetTeste2(const Value: tTeste2);
begin
  FTeste2 := Value;
end;

function tTeste.ToJSON: TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair('nome', nome);
  result.AddPair('idade', TJSONNumber.Create(idade));
end;

procedure TForm1.Button2Click(Sender: TObject);
var iTeste: tTeste;
begin
  xJSONArray := tJSONArray.Create;
  for iTeste in xTestes do
    xJSONArray.AddElement(TJSON.ObjectToJsonObject(iTeste));

  Memo1.Lines.Add(xJSONArray.ToString);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  xTestes.free;
  xTestes := TJSON.JsonToObjectList<tTeste>(xJSONArray);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  iTeste: tTeste;
begin
  for iTeste in xTestes do
    Memo1.Lines.Add(iTeste.nome + ' ' + iTeste.idade.ToString );
end;

{ tJSONModificado }

class function tJSONModificado.JsonToObjectList<T>(AJsonArray: TJSONArray; AOptions: TJsonOptions = [joDateIsUTC, joDateFormatISO8601, joBytesFormatArray, joIndentCaseCamel]): tObjectList<T>;
var i : integer;
begin
  Result := tObjectList<T>.create;
  for I := 0 to Pred(AJsonArray.Count) do
    Result.add(TJSON.JsonToObject<T>(AJsonArray.Items[i] as TJSONObject));

end;



{ tTeste2 }

procedure tTeste2.Setbolo(const Value: integer);
begin
  Fbolo := Value;
end;

procedure tTeste2.Setnome(const Value: string);
begin
  Fnome := Value;
end;

end.
