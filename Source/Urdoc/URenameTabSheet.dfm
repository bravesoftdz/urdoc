object fmRenameTabSheet: TfmRenameTabSheet
  Left = 366
  Top = 219
  ActiveControl = lbTabSheet
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1079#1072#1082#1083#1072#1076#1086#1082
  ClientHeight = 272
  ClientWidth = 468
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 231
    Width = 468
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Panel3: TPanel
      Left = 283
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
        ModalResult = 1
        TabOrder = 0
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
  object pnLeft: TPanel
    Left = 0
    Top = 0
    Width = 237
    Height = 231
    Align = alLeft
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 0
    object grbTabSheet: TGroupBox
      Left = 5
      Top = 5
      Width = 227
      Height = 221
      Align = alClient
      Caption = ' '#1047#1072#1082#1083#1072#1076#1082#1080' '
      TabOrder = 0
      object pnCmbTabSheet: TPanel
        Left = 2
        Top = 15
        Width = 223
        Height = 204
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 5
        TabOrder = 0
        object btDown: TBitBtn
          Left = 175
          Top = 34
          Width = 40
          Height = 25
          TabOrder = 3
          OnClick = btDownClick
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888888888888888888888888888888888888888888888888888888808888
            8888888888060888888888888066608888888888066666088888888066666660
            8888880000666000088888888066608888888888806660888888888880666088
            8888888880000088888888888888888888888888888888888888}
        end
        object btUp: TBitBtn
          Left = 175
          Top = 2
          Width = 40
          Height = 25
          TabOrder = 2
          OnClick = btUpClick
          Glyph.Data = {
            F6000000424DF600000000000000760000002800000010000000100000000100
            0400000000008000000000000000000000001000000010000000000000000000
            8000008000000080800080000000800080008080000080808000C0C0C0000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
            8888888888888888888888888888888888888888888888888888888880000088
            8888888880666088888888888066608888888888806660888888880000666000
            0888888066666660888888880666660888888888806660888888888888060888
            8888888888808888888888888888888888888888888888888888}
        end
        object lbTabSheet: TListBox
          Left = 8
          Top = 32
          Width = 159
          Height = 164
          DragMode = dmAutomatic
          ItemHeight = 13
          TabOrder = 1
          OnClick = lbTabSheetClick
          OnDragDrop = lbTabSheetDragDrop
          OnDragOver = lbTabSheetDragOver
          OnKeyDown = lbTabSheetKeyDown
        end
        object edTabSheet: TEdit
          Left = 9
          Top = 5
          Width = 158
          Height = 21
          TabOrder = 0
          OnChange = edTabSheetChange
          OnKeyDown = edTabSheetKeyDown
        end
      end
    end
  end
  object pnRight: TPanel
    Left = 237
    Top = 0
    Width = 231
    Height = 231
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 1
    object grbFields: TGroupBox
      Left = 5
      Top = 5
      Width = 221
      Height = 221
      Align = alClient
      Caption = ' '#1069#1083#1077#1084#1077#1085#1090#1099' '
      TabOrder = 0
      object pnLBFields: TPanel
        Left = 2
        Top = 15
        Width = 217
        Height = 204
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 8
        TabOrder = 0
        object lbFields: TListBox
          Left = 8
          Top = 8
          Width = 201
          Height = 188
          Style = lbOwnerDrawFixed
          Align = alClient
          ItemHeight = 16
          TabOrder = 0
          OnDrawItem = lbFieldsDrawItem
        end
      end
    end
  end
end