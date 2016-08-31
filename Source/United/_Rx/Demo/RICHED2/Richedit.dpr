program RichEdit;

uses
  Forms,
  ExcptDlg,
  REMain in 'REMain.pas' {MainForm},
  ParaFmt in 'ParaFmt.pas' {ParaFormatDlg},
  RxRichEd in 'RxRichEd.pas';

{$R *.RES}

begin
  Application.Initialize;
  RxErrorIntercept;
  Application.Title := 'RX RichEdit Demo';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.