object Form10: TForm10
  Left = 0
  Top = 0
  Caption = 'Form10'
  ClientHeight = 354
  ClientWidth = 610
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object StringGrid1: TStringGrid
    Left = 8
    Top = 8
    Width = 593
    Height = 337
    TabOrder = 0
    OnClick = ORO
    OnMouseUp = StringGrid1MouseUp
  end
  object MainMenu1: TMainMenu
    Left = 536
    Top = 32
    object N2: TMenuItem
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      OnClick = ADD
    end
    object N1: TMenuItem
      Caption = #1042#1099#1093#1086#1076
      OnClick = exit
    end
  end
end
