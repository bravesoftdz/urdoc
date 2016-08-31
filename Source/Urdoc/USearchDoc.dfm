object fmSearchDoc: TfmSearchDoc
  Left = 361
  Top = 191
  ActiveControl = LV
  Caption = #1055#1086#1080#1089#1082' '#1096#1072#1073#1083#1086#1085#1086#1074
  ClientHeight = 348
  ClientWidth = 572
  Color = clBtnFace
  Constraints.MinHeight = 200
  Constraints.MinWidth = 580
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pnLVBack: TPanel
    Left = 0
    Top = 0
    Width = 572
    Height = 348
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object pnLv: TPanel
      Left = 0
      Top = 0
      Width = 572
      Height = 348
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object pnFind: TPanel
        Left = 0
        Top = 0
        Width = 572
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object pnCondition: TPanel
          Left = 292
          Top = 0
          Width = 280
          Height = 41
          Align = alRight
          Alignment = taLeftJustify
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 1
          DesignSize = (
            280
            41)
          object bibView: TBitBtn
            Left = 199
            Top = 7
            Width = 75
            Height = 25
            Hint = #1055#1088#1086#1089#1084#1086#1090#1088' (F3)'
            Anchors = [akTop, akRight]
            Caption = #1055#1088#1086#1089#1084#1086#1090#1088
            TabOrder = 2
            Visible = False
            OnClick = bibViewClick
          end
          object bibSCondit: TBitBtn
            Left = 172
            Top = 7
            Width = 102
            Height = 25
            Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1091#1089#1083#1086#1074#1080#1103' '#1087#1086#1080#1089#1082#1072
            Anchors = [akTop, akRight]
            Caption = #1059#1089#1083#1086#1074#1080#1103' '#1087#1086#1080#1089#1082#1072
            TabOrder = 3
            OnClick = bibSConditClick
          end
          object BitBtn1: TBitBtn
            Left = 90
            Top = 7
            Width = 75
            Height = 25
            Hint = #1055#1088#1086#1089#1084#1086#1090#1088' '#1076#1086#1082#1091#1084#1077#1085#1090#1072' (F3)'
            Anchors = [akTop, akRight]
            Caption = #1055#1088#1086#1089#1084#1086#1090#1088
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = bibViewClick
          end
          object bibGotoDoc: TBitBtn
            Left = 8
            Top = 7
            Width = 75
            Height = 25
            Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1096#1072#1073#1083#1086#1085#1091' '#1074' '#1076#1077#1088#1077#1074#1077' (F4)'
            Anchors = [akTop, akRight]
            Caption = #1055#1077#1088#1077#1081#1090#1080
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = bibGotoDocClick
          end
        end
        object pnFindNew: TPanel
          Left = 0
          Top = 0
          Width = 292
          Height = 41
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          object Label1: TLabel
            Left = 11
            Top = 11
            Width = 53
            Height = 13
            Caption = #1054#1087#1080#1089#1072#1085#1080#1077':'
          end
          object edHint: TEdit
            Left = 72
            Top = 8
            Width = 212
            Height = 21
            Color = clBtnFace
            ReadOnly = True
            TabOrder = 0
          end
        end
      end
      object pnBottom: TPanel
        Left = 0
        Top = 312
        Width = 572
        Height = 36
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          572
          36)
        object lbCount: TLabel
          Left = 11
          Top = 16
          Width = 87
          Height = 13
          Anchors = [akLeft, akBottom]
          Caption = #1042#1089#1077#1075#1086' '#1085#1072#1081#1076#1077#1085#1086': 0'
        end
        object bibClose: TBitBtn
          Left = 490
          Top = 6
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Cancel = True
          Caption = #1047#1072#1082#1088#1099#1090#1100
          ModalResult = 2
          TabOrder = 0
          OnClick = bibCloseClick
          NumGlyphs = 2
        end
      end
      object LV: TListView
        Left = 0
        Top = 41
        Width = 572
        Height = 271
        Align = alClient
        Columns = <
          item
            Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
            Width = 250
          end
          item
            Caption = #1055#1072#1087#1082#1072
            Width = 318
          end>
        HideSelection = False
        HotTrackStyles = [htHandPoint, htUnderlineHot]
        MultiSelect = True
        RowSelect = True
        SmallImages = ilLvSmall
        TabOrder = 2
        ViewStyle = vsReport
        OnChange = LVChange
        OnColumnClick = LVColumnClick
        OnCustomDrawItem = LVCustomDrawItem
        OnKeyDown = LVKeyDown
      end
    end
  end
  object ilLvSmall: TImageList
    Left = 212
    Top = 120
    Bitmap = {
      494C010102000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000008080
      8000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000FFFFFF00C0C0C000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000FFFFFF00C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF00000000000000FF00
      000000000000FF00000000000000FF00000000000000FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000C0C0C000C0C0
      C000C0C0C000FFFFFF00C0C0C000000000000000000000000000000000008080
      8000FFFFFF00C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
      C000C0C0C000FFFFFF00C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000FF00
      0000FFFFFF00FF00000000000000FFFFFF00FFFFFF00FF000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FFFFFF00FF0000000000
      0000C0C0C00000000000FF000000C0C0C000FFFFFF0000000000C0C0C000C0C0
      C000C0C0C000FFFFFF00C0C0C000000000000000000000000000000000000000
      000080808000000000000000000000000000FFFFFF00C0C0C000C0C0C000C0C0
      C000C0C0C000FFFFFF00C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0000000000FF00
      000000000000FF00000000000000FF000000FFFFFF00FF000000C0C0C000FFFF
      FF00C0C0C000FFFFFF00C0C0C000000000000000000000000000FFFF0000FFFF
      000000000000FFFF0000FFFF000000000000FFFFFF00C0C0C000FFFFFF00FFFF
      FF00C0C0C000FFFFFF00C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF000000FFFFFF00FF000000FFFF
      FF00FF00000000000000FFFFFF0000000000C0C0C00000000000C0C0C000FFFF
      FF00C0C0C000FFFFFF00C0C0C000000000000000000000000000FFFF0000FFFF
      000000000000FFFF0000FFFF000000000000FFFFFF00C0C0C000C0C0C000FFFF
      FF00C0C0C000FFFFFF00C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FF00000000000000FFFF
      FF0000000000FF000000FFFFFF00FF00000000000000FF000000FFFFFF00FFFF
      FF00C0C0C000FFFFFF00C0C0C000000000000000000000000000FFFF00000000
      0000FFFF0000FFFF000000000000FFFF000000000000C0C0C000FFFFFF00FFFF
      FF00C0C0C000FFFFFF00C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000FF0000000000
      0000FF00000000000000FF00000000000000FF00000000000000C0C0C000C0C0
      C000C0C0C000FFFFFF00C0C0C000000000000000000000000000FFFF00000000
      000000000000FFFF00000000000000000000FFFF000000000000C0C0C000C0C0
      C000C0C0C000FFFFFF00C0C0C000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF00FFFF
      FF000000000000000000000000000000000000000000FFFF0000FFFF0000FFFF
      000000000000FFFF000000000000FFFF0000FFFF0000FFFF000000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00000000000000FF0000000000
      0000FF00000000000000FF00000000000000FF00000000000000FFFFFF00FFFF
      FF0080808000FFFFFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      FF0080808000FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00808080000000000000000000000000000000000000000000000000008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000008080
      8000808080008080800080808000808080008080800080808000808080008080
      8000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E000E00000000000E000E00000000000
      E000E00000000000E000E000000000000000E000000000000000E00000000000
      0000E00000000000000080000000000000008000000000000000800000000000
      0000800000000000000080000000000000000000000000000001000100000000
      E003E00300000000E007E0070000000000000000000000000000000000000000
      000000000000}
  end
end