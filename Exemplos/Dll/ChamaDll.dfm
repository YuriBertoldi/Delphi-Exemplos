object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 92
  ClientWidth = 195
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 133
    Height = 15
    Caption = 'CHAMANDO MINHADLL'
  end
  object Button1: TButton
    Left = 8
    Top = 37
    Width = 177
    Height = 41
    Caption = 'Chamar soma 1+4 minha dll'
    TabOrder = 0
    OnClick = Button1Click
  end
end
