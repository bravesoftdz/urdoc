object fmSelectDatabase: TfmSelectDatabase
  Left = 507
  Top = 203
  BorderStyle = bsDialog
  Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1073#1072#1079#1091' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 100
  ClientWidth = 257
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PanelBottom: TPanel
    Left = 0
    Top = 63
    Width = 257
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      257
      37)
    object butOk: TButton
      Left = 91
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #1054#1050
      Default = True
      ModalResult = 1
      TabOrder = 0
    end
    object butCancel: TButton
      Left = 174
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = #1054#1090#1084#1077#1085#1072
      ModalResult = 2
      TabOrder = 1
    end
  end
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 257
    Height = 63
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 3
    TabOrder = 0
    object grbTop: TGroupBox
      Left = 3
      Top = 3
      Width = 251
      Height = 57
      Align = alClient
      Caption = ' '#1041#1072#1079#1099' '#1076#1072#1085#1085#1099#1093' '
      TabOrder = 0
      object cmbBases: TComboBox
        Left = 13
        Top = 24
        Width = 225
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbBasesChange
      end
    end
  end
end