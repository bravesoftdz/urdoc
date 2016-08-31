unit UInputSortNum;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls;

type
  TfmInputSortNum = class(TForm)
    pnBottom: TPanel;
    Panel3: TPanel;
    bibOk: TBitBtn;
    bibCancel: TBitBtn;
    lbNumber: TLabel;
    edNumber: TEdit;
    procedure bibOkClick(Sender: TObject);
  private
  public
    TypeReestrId: Integer;
    procedure edNumberKeyPressInteger(Sender: TObject; var Key: Char);
    procedure edNumberKeyPressFloat(Sender: TObject; var Key: Char);
  end;

var
  fmInputSortNum: TfmInputSortNum;

implementation

uses UDm;

{$R *.DFM}

procedure TfmInputSortNum.edNumberKeyPressInteger(Sender: TObject; var Key: Char);
begin
  if (not (Char(Key) in ['0'..'9']))and(Integer(Key)<>VK_Back) then begin
    Key:=Char(nil);
  end;
end;

procedure TfmInputSortNum.edNumberKeyPressFloat(Sender: TObject; var Key: Char);
begin
  if (not (Char(Key) in ['0'..'9'])) and
     (Integer(Key)<>VK_Back) and
     (Key<>DecimalSeparator) then begin
    Key:=Char(nil);
  end;
end;

procedure TfmInputSortNum.bibOkClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

end.