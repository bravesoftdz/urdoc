object fmInputSortNum: TfmInputSortNum
  Left = 392
  Top = 284
  BorderStyle = bsDialog
  ClientHeight = 81
  ClientWidth = 212
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lbNumber: TLabel
    Left = 6
    Top = 15
    Width = 106
    Height = 13
    Alignment = taRightJustify
    Caption = #1055#1086#1088#1103#1076#1086#1082' '#1076#1086#1082#1091#1084#1077#1085#1090#1072':'
  end
  object pnBottom: TPanel
    Left = 0
    Top = 40
    Width = 212
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Panel3: TPanel
      Left = 27
      Top = 0
      Width = 185
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
      object bibOk: TBitBtn
        Left = 21
        Top = 10
        Width = 75
        Height = 25
        Caption = 'OK'
        Default = True
        TabOrder = 0
        OnClick = bibOkClick
        NumGlyphs = 2
      end
      object bibCancel: TBitBtn
        Left = 104
        Top = 10
        Width = 75
        Height = 25
        Cancel = True
        Caption = #1054#1090#1084#1077#1085#1072
        ModalResult = 2
        TabOrder = 1
        NumGlyphs = 2
      end
    end
  end
  object edNumber: TEdit
    Left = 120
    Top = 12
    Width = 81
    Height = 21
    TabOrder = 0
  end
end