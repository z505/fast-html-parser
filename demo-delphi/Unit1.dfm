object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 507
  ClientWidth = 714
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 120
  TextHeight = 16
  object Button1: TButton
    Left = 486
    Top = 446
    Width = 189
    Height = 25
    Caption = 'Get Element By Name'
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 60
    Top = 26
    Width = 619
    Height = 409
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object bGetElementByID: TButton
    Left = 486
    Top = 474
    Width = 189
    Height = 25
    Caption = 'Get Element By ID'
    TabOrder = 2
    OnClick = bGetElementByIDClick
  end
end
