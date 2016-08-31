unit UEnterPeriod;

interface

//{$I stbasis.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Buttons, ExtCtrls, IniFiles, Spin, UDM;

type
  TfmEnterPeriod = class(TForm)
    dtpBegin: TDateTimePicker;
    Panel1: TPanel;
    bibOk: TBitBtn;
    bibCancel: TBitBtn;
    dtpEnd: TDateTimePicker;
    lbBegin: TLabel;
    lbEnd: TLabel;
    rbKvartal: TRadioButton;
    rbMonth: TRadioButton;
    rbDay: TRadioButton;
    rbInterval: TRadioButton;
    edKvartal: TEdit;
    udKvartal: TUpDown;
    edMonth: TEdit;
    udMonth: TUpDown;
    dtpDay: TDateTimePicker;
    rbYear: TRadioButton;
    edYear: TEdit;
    udYear: TUpDown;
    procedure bibOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure udKvartalChangingEx(Sender: TObject;
      var AllowChange: Boolean; NewValue: Smallint;
      Direction: TUpDownDirection);
    procedure udKvartalChanging(Sender: TObject; var AllowChange: Boolean);
    procedure edKvartalChange(Sender: TObject);
    procedure rbKvartalClick(Sender: TObject);
    procedure udMonthChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
    procedure edMonthChange(Sender: TObject);
    procedure udYearChangingEx(Sender: TObject; var AllowChange: Boolean;
      NewValue: Smallint; Direction: TUpDownDirection);
  private
    CurKvartal: Word;
    CurKvartalYear: Word;
    CurMonth: Word;
    CurMonthYear: Word;
    isChangeKvartal: Boolean;
    isChangeMonth: Boolean;
    procedure SetKvartalInc(IncDec: Integer);
    procedure SetMonthInc(IncDec: Integer);
  public
    procedure SavePeriod;
    procedure LoadPeriod(P: PInfoEnterPeriod);
    procedure SetPeriod(P: PInfoEnterPeriod);
    procedure GetPeriod(P: PInfoEnterPeriod);
  end;

var
  fmEnterPeriod: TfmEnterPeriod;

implementation

const
  kvstr='�������';

{$R *.DFM}

procedure TfmEnterPeriod.SetPeriod(P: PInfoEnterPeriod);
var
 Year,Month,Day: Word;
begin
 try
   if P.DateBegin=0 then
    P.DateBegin:=Workdate;
   DecodeDate(P.DateBegin,Year,Month,Day);
   case P.TypePeriod of
     tepQuarter: begin
      CurKvartalYear:=Year;
      if (Month mod 3)<>0 then
       CurKvartal:=(Month div 3)+1
      else CurKvartal:=(Month div 3);
      SetKvartalInc(0);
      rbKvartal.Checked:=true;
     end;
     tepMonth: begin
      CurMonthYear:=Year;
      CurMonth:=Month;
      SetMonthInc(0);
      rbMonth.Checked:=true;
     end;
     tepDay: begin
      dtpDay.DateTime:=P.DateBegin;
      rbDay.Checked:=true;
     end;
     tepInterval: begin
      dtpBegin.DateTime:=P.DateBegin;
      dtpEnd.DateTime:=P.DateEnd;
      rbInterval.Checked:=true;
     end;
     tepYear: begin
       udYear.Position:=Year;
       rbYear.Checked:=true;
     end;
   end;
  isChangeKvartal:=false;
  isChangeMonth:=false;
 except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmEnterPeriod.GetPeriod(P: PInfoEnterPeriod);
var
  Year,Month,Day: Word;
  DBegin,DEnd: TDateTime;
begin
try
 if rbKvartal.Checked then begin
  Year:=CurKvartalYear;
  Month:=CurKvartal+2*(CurKvartal-1);
  Day:=1;
  DBegin:=EncodeDate(Year,Month,Day)+EncodeTime(0,0,0,0);
  DEnd:=IncMonth(DBegin,3)-1+EncodeTime(23,59,59,0);
  P.DateBegin:=DBegin;
  P.DateEnd:=DEnd;
  P.TypePeriod:=tepQuarter;
  exit;
 end;
 if rbMonth.Checked then begin
  Year:=CurMonthYear;
  Month:=CurMonth;
  Day:=1;
  DBegin:=EncodeDate(Year,Month,Day)+EncodeTime(0,0,0,0);
  DEnd:=IncMonth(DBegin,1)-1+EncodeTime(23,59,59,0);
  P.DateBegin:=DBegin;
  P.DateEnd:=DEnd;
  P.TypePeriod:=tepMonth;
  exit;
 end;
 if rbDay.Checked then begin
  DBegin:=dtpDay.date+EncodeTime(0,0,0,0);
  DEnd:=dtpDay.date+EncodeTime(23,59,59,0);
  P.DateBegin:=DBegin;
  P.DateEnd:=DEnd;
  P.TypePeriod:=tepDay;
  exit;
 end;
 if rbInterval.Checked then begin
  DBegin:=dtpBegin.date+EncodeTime(0,0,0,0);
  DEnd:=dtpEnd.date+EncodeTime(23,59,59,0);
  P.DateBegin:=DBegin;
  P.DateEnd:=DEnd;
  P.TypePeriod:=tepInterval;
  exit;
 end;
 if rbYear.Checked then begin
  DBegin:=EncodeDate(udYear.Position,1,1)+EncodeTime(0,0,0,0);
  DEnd:=IncMonth(DBegin,12)-1+EncodeTime(23,59,59,0);
  P.DateBegin:=DBegin;
  P.DateEnd:=DEnd;
  P.TypePeriod:=tepYear;
  exit;
 end;
 except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmEnterPeriod.bibOkClick(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TfmEnterPeriod.FormCreate(Sender: TObject);
var
  Year,Month,Day: Word;
begin
 try
  isChangeKvartal:=true;
  isChangeMonth:=true;
  DecodeDate(WorkDate,Year,Month,Day);

  udYear.Position:=Year;

  CurKvartalYear:=Year;
  if (Month mod 3)<>0 then
   CurKvartal:=(Month div 3)+1
  else CurKvartal:=(Month div 3);

  CurMonthYear:=Year;
  CurMonth:=Month;

  dtpDay.Time:=StrToTime('0:00:00');
  dtpDay.date:=Workdate;

  dtpBegin.Time:=StrToTime('0:00:00');
  dtpBegin.date:=Workdate;

  dtpEnd.Time:=StrToTime('0:00:00');
  dtpEnd.date:=Workdate;

  rbInterval.Checked:=true;
//  rbKvartalClick(rbYear);
 except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;

end;

procedure TfmEnterPeriod.udKvartalChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
   AllowChange:=false;
   case Direction of
    updUp: begin
     SetKvartalInc(1);
    end;
    updDown: begin
     SetKvartalInc(-1);
    end;
  end;
end;

procedure TfmEnterPeriod.SetKvartalInc(IncDec: Integer);
var
  tmps: string;
begin
 try
  if ((CurKvartal+IncDec)<=4)and((CurKvartal+IncDec)>0) then begin
   CurKvartal:=CurKvartal+IncDec;
  end else begin
    if ((CurKvartal+IncDec)>4) then begin
     CurKvartal:=1;
     CurKvartalYear:=CurKvartalYear+1;
    end;
    if ((CurKvartal+IncDec)<=0)then begin
     CurKvartal:=4;
     CurKvartalYear:=CurKvartalYear-1;
    end;
  end;
  tmps:=inttostr(CurKvartal)+' '+kvstr+' '+inttostr(CurKvartalYear)+' �.';
  edKvartal.Text:=tmps;
  if self.Visible then
   edKvartal.SetFocus;
  edKvartal.SelectAll;
 except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmEnterPeriod.udKvartalChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  AllowChange:=false;
end;

procedure TfmEnterPeriod.edKvartalChange(Sender: TObject);
begin
  if not isChangeKvartal then begin
    isChangeKvartal:=true;
    edKvartal.Text:=inttostr(CurKvartal)+' '+kvstr+' '+inttostr(CurKvartalYear)+' �.';
  end;
  edYear.SelectAll;
end;

procedure TfmEnterPeriod.rbKvartalClick(Sender: TObject);
const
  clDisable=clBtnFace;
  clEnable=clWindow;
begin
  edYear.Enabled:=false;
  edYear.Color:=clDisable;
  udYear.Enabled:=false;
  edKvartal.Enabled:=false;
  edKvartal.Color:=clDisable;
  udKvartal.Enabled:=false;
  edMonth.Enabled:=false;
  edMonth.Color:=ClDisable;
  udMonth.Enabled:=false;
  dtpDay.Enabled:=false;
  dtpDay.Color:=clDisable;
  lbBegin.Enabled:=false;
  dtpBegin.Enabled:=false;
  dtpBegin.Color:=clDisable;
  lbEnd.Enabled:=false;
  dtpEnd.Enabled:=false;
  dtpEnd.Color:=clDisable;

  if Sender=rbYear then begin
   edYear.Enabled:=true;
   edYear.Color:=clEnable;
   udYear.Enabled:=true;
   exit;
  end;
  if Sender=rbKvartal then begin
    edKvartal.Enabled:=true;
    edKvartal.Color:=clEnable;
    udKvartal.Enabled:=true;
    exit;
  end;
  if Sender=rbMonth then begin
    edMonth.Enabled:=true;
    edMonth.Color:=clEnable;
    udMonth.Enabled:=true;
    exit;
  end;
  if Sender=rbDay then begin
    dtpDay.Enabled:=true;
    dtpDay.Color:=clEnable;
    exit;
  end;
  if Sender=rbInterval then begin
    lbBegin.Enabled:=true;
    dtpBegin.Enabled:=true;
    dtpBegin.Color:=clEnable;
    lbEnd.Enabled:=true;
    dtpEnd.Enabled:=true;
    dtpEnd.Color:=clEnable;
    exit;
  end;

end;

procedure TfmEnterPeriod.SetMonthInc(IncDec: Integer);
var
  tmps: string;
  monthstr: string;
begin
  if ((CurMonth+IncDec)<=12)and((CurMonth+IncDec)>0) then begin
   CurMonth:=CurMonth+IncDec;
  end else begin
    if ((CurMonth+IncDec)>12) then begin
     CurMonth:=1;
     CurMonthYear:=CurMonthYear+1;
    end;
    if ((CurMonth+IncDec)<=0)then begin
     CurMonth:=12;
     CurMonthYear:=CurMonthYear-1;
    end;
  end;
  monthstr:=LongMonthNames[CurMonth];
  tmps:=monthstr+' '+inttostr(CurMonthYear)+' �.';
  edMonth.Text:=tmps;
  if self.Visible then
   edMonth.SetFocus;
  edMonth.SelectAll;
end;

procedure TfmEnterPeriod.udMonthChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
   AllowChange:=false;
   case Direction of
    updUp: begin
     SetMonthInc(1);
    end;
    updDown: begin
     SetMonthInc(-1);
    end;

  end;
end;

procedure TfmEnterPeriod.edMonthChange(Sender: TObject);
var
  monthstr: string;
begin
  if not isChangeMonth then begin
    isChangeMonth:=true;
    monthstr:=LongMonthNames[CurMonth];
    edMonth.Text:=monthstr+' '+inttostr(CurMonthYear)+' �.';
  end;
end;

procedure TfmEnterPeriod.LoadPeriod(P: PInfoEnterPeriod);
var
  fi: TIniFile;
begin
 try
  fi:=TIniFile.Create(GetIniFileName);
  try
    P.TypePeriod:=TTypeEnterPeriod(
                  fi.ReadInteger(ClassName,'TypePeriod',Integer(P.TypePeriod)));
    P.DateBegin:=fi.ReadDateTime(ClassName,'DateBegin',P.DateBegin);
    P.DateEnd:=fi.ReadDateTime(ClassName,'DateEnd',P.DateEnd);
  finally
   fi.Free;
  end;
 except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmEnterPeriod.SavePeriod;
var
  fi: TIniFile;
  P: PInfoEnterPeriod;
begin
 try
  fi:=TIniFile.Create(GetIniFileName);
  New(P);
  try
    ZeroMemory(P,sizeof(TInfoEnterPeriod));
    GetPeriod(P);
    fi.WriteInteger(ClassName,'TypePeriod',Integer(P.TypePeriod));
    fi.WriteDateTime(ClassName,'DateBegin',P.DateBegin);
    fi.WriteDateTime(ClassName,'DateEnd',P.DateEnd);
  finally
   dispose(P);
   fi.Free;
  end;
 except
   {$IFDEF DEBUG} on E: Exception do Assert(false,E.message); {$ENDIF}
 end;
end;

procedure TfmEnterPeriod.udYearChangingEx(Sender: TObject;
  var AllowChange: Boolean; NewValue: Smallint;
  Direction: TUpDownDirection);
begin
  AllowChange:=true;
  if self.Visible then
   edYear.SetFocus;
end;

end.
