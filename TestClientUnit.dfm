object TestClientForm: TTestClientForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1050#1083#1080#1077#1085#1090' '#1076#1083#1103' '#1090#1077#1089#1090#1086#1074
  ClientHeight = 499
  ClientWidth = 1151
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ResponseMemo: TMemo
    Left = 0
    Top = 483
    Width = 1151
    Height = 16
    Align = alBottom
    TabOrder = 0
    Visible = False
  end
  object RequestMemo: TMemo
    Left = 0
    Top = 459
    Width = 1151
    Height = 24
    Align = alBottom
    TabOrder = 1
    Visible = False
    OnDragDrop = RequestMemoDragDrop
    OnDragOver = RequestMemoDragOver
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 8
    Width = 561
    Height = 481
    TabOrder = 2
    OnMouseUp = StringGrid1MouseUp
    RowHeights = (
      24
      24
      24
      24
      24)
  end
  object StringGrid2: TStringGrid
    Left = 584
    Top = 8
    Width = 559
    Height = 481
    ScrollBars = ssVertical
    TabOrder = 3
    OnMouseUp = StringGrid2MouseUp
  end
  object HTTP: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 8
  end
  object MainMenu1: TMainMenu
    Left = 56
    object N1: TMenuItem
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1058#1072#1073#1083#1080#1094#1099' '
      object N3: TMenuItem
        Caption = #1054#1087#1077#1088#1072#1090#1086#1088#1099
        OnClick = MenuOperatorRun
      end
      object N5: TMenuItem
        Caption = #1058#1086#1074#1072#1088#1086#1074
        OnClick = MenuProductRun
      end
      object N4: TMenuItem
        Caption = #1047#1072#1074#1077#1088#1096#1077#1085#1099#1077' '#1079#1072#1082#1072#1079#1099
        OnClick = openOrder
      end
    end
  end
  object Timer1: TTimer
    OnTimer = Timer
    Left = 568
    Top = 8
  end
end
