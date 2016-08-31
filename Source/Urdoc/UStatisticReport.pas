unit UStatisticReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, ComCtrls, db, inifiles, IBQuery, 
  ComObj,IBDatabase, CheckLst;

type
  TfmStatisticReport = class(TForm)
    pnBottom: TPanel;
    Panel3: TPanel;
    bibOk: TBitBtn;
    bibCancel: TBitBtn;
    grbDate: TGroupBox;
    cbInString: TCheckBox;
    lbDateFrom: TLabel;
    dtpDateFrom: TDateTimePicker;
    lbDateTo: TLabel;
    dtpDateTo: TDateTimePicker;
    lbUserName: TLabel;
    edUserName: TEdit;
    lbSumm: TLabel;
    edSumm: TEdit;
    bibUsername: TBitBtn;
    bibClear: TBitBtn;
    bibDateIn: TBitBtn;
    grbDateChange: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    dtpDateChangeFrom: TDateTimePicker;
    dtpDateChangeTo: TDateTimePicker;
    bibDateChange: TBitBtn;
    chbOnlyPriv: TCheckBox;
    lbFromNumber: TLabel;
    edFromNumber: TEdit;
    lbToNumber: TLabel;
    edToNumber: TEdit;
    grbCert: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    dtpCertFrom: TDateTimePicker;
    dtpCertTo: TDateTimePicker;
    bibCert: TBitBtn;
    GroupBoxTypeReestr: TGroupBox;
    CheckListBoxTypeReestr: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure bibOkClick(Sender: TObject);
    procedure edStringKeyPress(Sender: TObject; var Key: Char);
    procedure edSummKeyPress(Sender: TObject; var Key: Char);
    procedure edFioChange(Sender: TObject);
    procedure edUserNameKeyPress(Sender: TObject; var Key: Char);
    procedure bibUsernameClick(Sender: TObject);
    procedure bibClearClick(Sender: TObject);
    procedure bibDateInClick(Sender: TObject);
    procedure bibDateChangeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bibCertClick(Sender: TObject);
  private
    CurNotActId: String;
    isFindCurNotActId: Boolean;
    isFindCurNoYear: Boolean;
    isFindCurDefect: Boolean;
    isFindCountCopy: Boolean;
    isFindCountPriv: Boolean;
    isFindTypeReestr,
    isFindDateFrom,isFindDateTo,
    isFindDateChangeFrom,isFindDateChangeTo,
    isFindCertFrom,isFindCertTo,
    isFindOnlyPriv,isFindFromNumber,isFindToNumber,

    FilterInside: Boolean;

    FindTypeReestr: String;
    FindDateChangeFrom,FindDateChangeTo: TDate;
    FindCertFrom,FindCertTo: TDate;
    FindDateFrom,FindDateTo: TDate;

//    procedure DocTreeOkClick(Sender: TObject);
    function GetFilterString(ForSumm: Boolean): string;
    procedure FillTypeReestr;
  public
    procedure LoadFilter;
    procedure ReportView;
    procedure SaveFilter;
  end;

var
  fmStatisticReport: TfmStatisticReport;

implementation

uses UMain, UDocTree, UDm, URBOperation, URBTypeReestr, URBUsers, UProgress,
  WordConst;

{var
  NewFm: TfmDocTree;}

{$R *.DFM}

procedure TfmStatisticReport.FormCreate(Sender: TObject);
begin
  OnKeyDown:=fmMain.OnKeyDown;
  OnKeyPress:=fmMain.OnKeyPress;
  OnKeyUp:=fmMain.OnKeyUp;

  dtpDateFrom.Date:=Workdate;
  dtpDateFrom.Time:=StrtoTime('0:00:00');
  dtpDateFrom.Checked:=false;
  dtpDateTo.Date:=Workdate;
  dtpDateTo.Time:=StrtoTime('23:59:59');
  dtpDateTo.Checked:=false;

  dtpDateChangeFrom.Date:=Workdate;
  dtpDateChangeFrom.Time:=StrtoTime('0:00:00');
  dtpDateChangeFrom.Checked:=false;
  dtpDateChangeTo.Date:=Workdate;
  dtpDateChangeTo.Time:=StrtoTime('23:59:59');
  dtpDateChangeTo.Checked:=false;

  dtpCertFrom.Date:=Workdate;
  dtpCertFrom.Time:=StrtoTime('0:00:00');
  dtpCertFrom.Checked:=false;
  dtpCertTo.Date:=Workdate;
  dtpCertTo.Time:=StrtoTime('23:59:59');
  dtpCertTo.Checked:=false;

  LoadFilter;

  FillTypeReestr;
end;

procedure TfmStatisticReport.bibOkClick(Sender: TObject);
begin
  if Trim(edFromNumber.text)<>'' then
    if not isInteger(Trim(edFromNumber.text)) then begin
      ShowError(Handle,'�������� ������ ���� ����� ������.');
      edFromNumber.SetFocus;
      exit;
    end;
  if Trim(edToNumber.text)<>'' then
    if not isInteger(Trim(edToNumber.text)) then begin
      ShowError(Handle,'�������� ������ ���� ����� ������.');
      edToNumber.SetFocus;
      exit;
    end;  

  if (Trim(edFromNumber.text)<>'')and
     (Trim(edToNumber.text)<>'') then begin
    if StrToInt(Trim(edFromNumber.text))>StrToInt(Trim(edToNumber.text)) then begin
      ShowError(Handle,'����� <� ��������> ������ ���� ������ ������ <��>.');
      edFromNumber.SetFocus;
      exit;
    end;
  end;

  ModalResult:=mrOk;
end;

{procedure TfmStatisticReport.DocTreeOkClick(Sender: TObject);
begin
end;}

procedure TfmStatisticReport.edStringKeyPress(Sender: TObject;
  var Key: Char);
begin
  if (not (Char(Key) in ['0'..'9']))and(Integer(Key)<>VK_Back) then begin
    Key:=Char(nil);
  end;
end;

procedure TfmStatisticReport.edSummKeyPress(Sender: TObject; var Key: Char);
var
  APos: Integer;
begin
  if (not (Key in ['0'..'9']))and (Key<>DecimalSeparator)and(Integer(Key)<>VK_Back) then begin
    Key:=Char(nil);
  end else begin
   if Key=DecimalSeparator then begin
    Apos:=Pos(String(DecimalSeparator),TEdit(Sender).Text);
    if Apos<>0 then Key:=char(nil);
   end;
  end;
end;

procedure TfmStatisticReport.edFioChange(Sender: TObject);
begin
  ChangeFlag:=true;
end;

procedure TfmStatisticReport.edUserNameKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key='''' then Key:=#0;
end;

procedure TfmStatisticReport.bibUsernameClick(Sender: TObject);
var
  fm: TfmUsers;
begin
  fm:=TfmUsers.Create(nil);
  try
   fm.BorderIcons:=[biSystemMenu, biMaximize];
   fm.bibOk.Visible:=true;
   fm.bibOk.OnClick:=fm.MR;
   fm.pnSQL.Visible:=false;
   fm.Grid.OnDblClick:=fm.MR;
   fm.LoadFilter;
   fm.ActiveQuery;
   if trim(edUserName.Text)<>'' then
    fm.Mainqr.locate('name',trim(edUserName.Text),[loCaseInsensitive]);
   if fm.ShowModal=mrOk then begin
     edUserName.Text:=Trim(fm.Mainqr.fieldByName('name').AsString);
   end;
  finally
   fm.Free;
  end;
end;

procedure TfmStatisticReport.LoadFilter;
var
  fi: TIniFile;
  oldVal: Boolean;
begin
  fi:=TIniFile.Create(GetIniFileName);
  try

//    edTypeReestr.text:=fi.ReadString(ClassName,'TypeReestr',edTypeReestr.text);

    oldVal:=fi.ReadBool(ClassName,'isDateFrom',dtpDateFrom.Checked);
    dtpDateFrom.date:=fi.ReadDate(ClassName,'DateFrom',dtpDateFrom.date);
    dtpDateFrom.Time:=Strtotime('0:00:00');
    dtpDateFrom.Checked:=oldVal;
    oldVal:=fi.ReadBool(ClassName,'isDateTo',dtpDateTo.Checked);
    dtpDateTo.Date:=fi.ReadDate(ClassName,'DateTo',dtpDateTo.Date);
    dtpDateTo.Time:=Strtotime('23:59:59');
    dtpDateTo.Checked:=oldVal;

    oldVal:=fi.ReadBool(ClassName,'isDateChangeFrom',dtpDateChangeFrom.Checked);
    dtpDateChangeFrom.date:=fi.ReadDate(ClassName,'DateChangeFrom',dtpDateChangeFrom.date);
    dtpDateChangeFrom.Time:=Strtotime('0:00:00');
    dtpDateChangeFrom.Checked:=oldVal;
    oldVal:=fi.ReadBool(ClassName,'isDateChangeTo',dtpDateChangeTo.Checked);
    dtpDateChangeTo.Date:=fi.ReadDate(ClassName,'DateChangeTo',dtpDateChangeTo.Date);
    dtpDateChangeTo.Time:=Strtotime('23:59:59');
    dtpDateChangeTo.Checked:=oldVal;

    oldVal:=fi.ReadBool(ClassName,'isCertFrom',dtpCertFrom.Checked);
    dtpCertFrom.date:=fi.ReadDate(ClassName,'CertFrom',dtpCertFrom.date);
    dtpCertFrom.Time:=Strtotime('0:00:00');
    dtpCertFrom.Checked:=oldVal;
    oldVal:=fi.ReadBool(ClassName,'isCertTo',dtpCertTo.Checked);
    dtpCertTo.Date:=fi.ReadDate(ClassName,'CertTo',dtpCertTo.Date);
    dtpCertTo.Time:=Strtotime('23:59:59');
    dtpCertTo.Checked:=oldVal;

    chbOnlyPriv.Checked:=fi.ReadBool(ClassName,'FindOnlyPriv',chbOnlyPriv.Checked);
    cbInString.Checked:=fi.ReadBool(ClassName,'Inside',cbInString.Checked);


    edFromNumber.Text:=fi.ReadString(ClassName,'FromNumber',edFromNumber.Text);
    edToNumber.Text:=fi.ReadString(ClassName,'ToNumber',edToNumber.Text);

  finally
   fi.Free;
  end;
end;

procedure TfmStatisticReport.SaveFilter;
var
  fi: TIniFile;
begin
  fi:=TIniFile.Create(GetIniFileName);
  try

//    fi.WriteString(ClassName,'TypeReestr',edTypeReestr.text);

    fi.WriteBool(ClassName,'isDateFrom',dtpDateFrom.Checked);
    fi.WriteDate(ClassName,'DateFrom',dtpDateFrom.date);
    fi.WriteBool(ClassName,'isDateTo',dtpDateTo.Checked);
    fi.WriteDate(ClassName,'DateTo',dtpDateTo.Date);

    fi.WriteBool(ClassName,'isDateChangeFrom',dtpDateChangeFrom.Checked);
    fi.WriteDate(ClassName,'DateChangeFrom',dtpDateChangeFrom.date);
    fi.WriteBool(ClassName,'isDateChangeTo',dtpDateChangeTo.Checked);
    fi.WriteDate(ClassName,'DateChangeTo',dtpDateChangeTo.Date);

    fi.WriteBool(ClassName,'isCertFrom',dtpCertFrom.Checked);
    fi.WriteDate(ClassName,'CertFrom',dtpCertFrom.date);
    fi.WriteBool(ClassName,'isCertTo',dtpCertTo.Checked);
    fi.WriteDate(ClassName,'CertTo',dtpCertTo.Date);

    fi.WriteBool(ClassName,'FindOnlyPriv',chbOnlyPriv.Checked);
    fi.WriteBool(ClassName,'Inside',cbInString.Checked);

    fi.WriteString(ClassName,'FromNumber',edFromNumber.Text);
    fi.WriteString(ClassName,'ToNumber',edToNumber.Text);

  finally
   fi.Free;
  end;
end;

{$WARNINGS OFF}
function TfmStatisticReport.GetFilterString(ForSumm: Boolean): string;

  function GetTypeReestrFilter: String;
  var
    i: Integer;
    ID: Integer;
    First: Boolean;
  begin
    Result:='';
    First:=false;
    for i:=0 to CheckListBoxTypeReestr.Items.Count-1 do begin
      if CheckListBoxTypeReestr.Checked[i] then begin
        ID:=Integer(CheckListBoxTypeReestr.Items.Objects[i]);
        if not First then begin
          Result:=IntToStr(ID);
          First:=true;
        end else begin
          Result:=Result+','+IntToStr(ID);
        end;
      end;
    end;
  end;

var
  FilInSide: string;
  wherestr: string;
  addstr1,addstr2,addstr3,addstr4,addstr5,
  addstr6,addstr7,addstr8,addstr9,addstr10,addstr11,addstr12,addstr13,addstr14,addstr15,addstr16: string;
  and1,and2,and3,and4,and5,and6,and7,and8,and9,and10,and11,and12,and13,and14,and15: string;
  s: string;
begin
    Result:='';

    FindTypeReestr:=GetTypeReestrFilter;
    FindDateFrom:=dtpDateFrom.DateTime;
    FindDateTo:=dtpDateTo.DateTime;
    FindDateChangeFrom:=dtpDateChangeFrom.DateTime;
    FindDateChangeTo:=dtpDateChangeTo.DateTime;
    FindCertFrom:=dtpCertFrom.DateTime;
    FindCertTo:=dtpCertTo.DateTime;

    isFindCurNotActId:=Trim(CurNotActId)<>'';
    isFindTypeReestr:=trim(FindTypeReestr)<>'';
    isFindDateFrom:=dtpDateFrom.Checked;
    isFindDateTo:=dtpDateTo.Checked;
    isFindDateChangeFrom:=dtpDateChangeFrom.Checked;
    isFindDateChangeTo:=dtpDateChangeTo.Checked;
    isFindCertFrom:=dtpCertFrom.Checked;
    isFindCertTo:=dtpCertTo.Checked;
    isFindOnlyPriv:=chbOnlyPriv.Checked;
    isFindFromNumber:=(Trim(edFromNumber.text)<>'') and isInteger(Trim(edFromNumber.text));
    isFindToNumber:=(Trim(edToNumber.text)<>'') and isInteger(Trim(edToNumber.text));


    if isFindTypeReestr or
      isFindDateChangeFrom or isFindDateChangeTo or
      isFindCertFrom or isFindCertTo or
      isFindDateFrom or isFindDateTo or
      isFindCurNotActId or
      isFindCurNoYear or isFindCurDefect or
      isFindCountCopy or (not isFindCountCopy) or
      isFindCountPriv or
      isFindOnlyPriv or isFindFromNumber or isFindToNumber
      then begin
       wherestr:=' where ';
    end;

    if FilterInside then FilInSide:='%';


      if isFindTypeReestr then begin
        addstr1:=' ttr.typereestr_id in ('+AnsiUpperCase(FindTypeReestr)+') ';
      end;
      if isFindDateFrom then begin
         addstr2:=' tb.datein >='''+formatdatetime(fmtDateTime,FindDateFrom)+''' ';
      end;

      if isFindDateTo then begin
         addstr3:=' tb.datein <='''+formatdatetime(fmtDateTime,FindDateTo)+''' ';
      end;

      if isFindDateChangeFrom then begin
         addstr4:=' tb.datechange >='''+formatdatetime(fmtDateTime,FindDateChangeFrom)+''' ';
      end;

      if isFindDateChangeTo then begin
         addstr5:=' tb.datechange <='''+formatdatetime(fmtDateTime,FindDateChangeTo)+''' ';
      end;

      if isFindCurNoYear then begin
         addstr6:=' noyear=1 ';
      end;

      if isFindCurdefect then begin
         addstr7:=' defect=1 ';
      end;


      if isFindCountCopy then begin
        addstr8:=' (parent_id is not null or tna.fieldsort='+inttostr(CopyID)+') ';
      end else begin
        if not ForSumm then begin
          addstr9:=' parent_id is null ';
        end else begin
          addstr9:=' (parent_id is null or parent_id is not null) ';
        end;
      end;

      if isFindCurNotActId then begin
         addstr10:=' tb.notarialaction_id='+CurNotActId+' ';
      end;

      if isFindCountPriv then begin
         addstr11:=' tb.summpriv<tb.summ ';
      end;

      if isFindOnlyPriv then begin
         addstr12:=' tb.summpriv<tb.summ ';
      end;

      if isFindFromNumber then begin
         addstr13:=' tb.numreestr>='+Trim(edFromNumber.text)+' ';
      end;

      if isFindToNumber then begin
         addstr14:=' tb.numreestr<='+Trim(edToNumber.text)+' ';
      end;

      if isFindCertFrom then begin
         addstr15:=' tb.certificatedate >='''+formatdatetime(fmtDateTime,FindCertFrom)+''' ';
      end;

      if isFindCertTo then begin
         addstr16:=' tb.certificatedate <='''+formatdatetime(fmtDateTime,FindCertTo)+''' ';
      end;


      if (isFindTypeReestr and isFindDateFrom)or
         (isFindTypeReestr and isFindDateTo)or
         (isFindTypeReestr and isFindDateChangeFrom)or
         (isFindTypeReestr and isFindDateChangeTo)or
         (isFindTypeReestr and isFindCurNoYear)or
         (isFindTypeReestr and isFindCurdefect)or
         (isFindTypeReestr and isFindCountCopy)or
         (isFindTypeReestr and (not isFindCountCopy))or
         (isFindTypeReestr and isFindCurNotActId)or
         (isFindTypeReestr and isFindCountPriv)or
         (isFindTypeReestr and isFindOnlyPriv)or
         (isFindTypeReestr and isFindFromNumber)or
         (isFindTypeReestr and isFindToNumber)or
         (isFindTypeReestr and isFindCertFrom)or
         (isFindTypeReestr and isFindCertTo)
         then
       and1:=' and ';

      if (isFindDateFrom and isFindDateTo)or
         (isFindDateFrom and isFindDateChangeFrom)or
         (isFindDateFrom and isFindDateChangeTo)or
         (isFindDateFrom and isFindCurNoYear)or
         (isFindDateFrom and isFindCurdefect)or
         (isFindDateFrom and isFindCountCopy)or
         (isFindDateFrom and (not isFindCountCopy))or
         (isFindDateFrom and isFindCurNotActId)or
         (isFindDateFrom and isFindCountPriv)or
         (isFindDateFrom and isFindOnlyPriv)or
         (isFindDateFrom and isFindFromNumber)or
         (isFindDateFrom and isFindToNumber)or
         (isFindDateFrom and isFindCertFrom)or
         (isFindDateFrom and isFindCertTo)
         then
       and2:=' and ';

      if (isFindDateTo and isFindDateChangeFrom)or
         (isFindDateTo and isFindDateChangeTo)or
         (isFindDateTo and isFindCurNoYear)or
         (isFindDateTo and isFindCurdefect)or
         (isFindDateTo and isFindCountCopy)or
         (isFindDateTo and (not isFindCountCopy))or
         (isFindDateTo and isFindCurNotActId)or
         (isFindDateTo and isFindCountPriv)or
         (isFindDateTo and isFindOnlyPriv)or
         (isFindDateTo and isFindFromNumber)or
         (isFindDateTo and isFindToNumber)or
         (isFindDateTo and isFindCertFrom)or
         (isFindDateTo and isFindCertTo)
         then
       and3:=' and ';

      if (isFindDateChangeFrom and isFindDateChangeTo)or
         (isFindDateChangeFrom and isFindCurNoYear)or
         (isFindDateChangeFrom and isFindCurdefect)or
         (isFindDateChangeFrom and isFindCountCopy)or
         (isFindDateChangeFrom and (not isFindCountCopy))or
         (isFindDateChangeFrom and isFindCurNotActId)or
         (isFindDateChangeFrom and isFindCountPriv)or
         (isFindDateChangeFrom and isFindOnlyPriv)or
         (isFindDateChangeFrom and isFindFromNumber)or
         (isFindDateChangeFrom and isFindToNumber)or
         (isFindDateChangeFrom and isFindCertFrom)or
         (isFindDateChangeFrom and isFindCertTo)
         then
       and4:=' and ';

      if (isFindDateChangeTo and isFindCurNoYear)or
         (isFindDateChangeTo and isFindCurdefect)or
         (isFindDateChangeTo and isFindCountCopy)or
         (isFindDateChangeTo and (not isFindCountCopy))or
         (isFindDateChangeTo and isFindCurNotActId)or
         (isFindDateChangeTo and isFindCountPriv)or
         (isFindDateChangeTo and isFindOnlyPriv)or
         (isFindDateChangeTo and isFindFromNumber)or
         (isFindDateChangeTo and isFindToNumber)or
         (isFindDateChangeTo and isFindCertFrom)or
         (isFindDateChangeTo and isFindCertTo)
         then
       and5:=' and ';

      if (isFindCurNoYear and isFindCurdefect)or
         (isFindCurNoYear and isFindCountCopy) or
         (isFindCurNoYear and (not isFindCountCopy))or
         (isFindCurNoYear and isFindCurNotActId)or
         (isFindCurNoYear and isFindCountPriv)or
         (isFindCurNoYear and isFindOnlyPriv)or
         (isFindCurNoYear and isFindFromNumber)or
         (isFindCurNoYear and isFindToNumber)or
         (isFindCurNoYear and isFindCertFrom)or
         (isFindCurNoYear and isFindCertTo)
         then
       and6:=' and ';

      if (isFindCurdefect and isFindCountCopy)or
         (isFindCurdefect and (not isFindCountCopy))or
         (isFindCurdefect and isFindCurNotActId)or
         (isFindCurdefect and isFindCountPriv)or
         (isFindCurdefect and isFindOnlyPriv)or
         (isFindCurdefect and isFindFromNumber)or
         (isFindCurdefect and isFindToNumber)or
         (isFindCurdefect and isFindCertFrom)or
         (isFindCurdefect and isFindCertTo)
         then
       and7:=' and ';

      if (isFindCountCopy and (not isFindCountCopy))or
         (isFindCountCopy and isFindCurNotActId)or
         (isFindCountCopy and isFindCountPriv)or
         (isFindCountCopy and isFindOnlyPriv)or
         (isFindCountCopy and isFindFromNumber)or
         (isFindCountCopy and isFindToNumber)or
         (isFindCountCopy and isFindCertFrom)or
         (isFindCountCopy and isFindCertTo)
         then
       and8:=' and ';

      if ((not isFindCountCopy) and isFindCurNotActId)or
         ((not isFindCountCopy) and isFindCountPriv)or
         ((not isFindCountCopy) and isFindOnlyPriv)or
         ((not isFindCountCopy) and isFindFromNumber)or
         ((not isFindCountCopy) and isFindToNumber)or
         ((not isFindCountCopy) and isFindCertFrom)or
         ((not isFindCountCopy) and isFindCertTo)
         then
       and9:=' and ';

      if (isFindCurNotActId and isFindCountPriv)or
         (isFindCurNotActId and isFindOnlyPriv)or
         (isFindCurNotActId and isFindFromNumber)or
         (isFindCurNotActId and isFindToNumber)or
         (isFindCurNotActId and isFindCertFrom)or
         (isFindCurNotActId and isFindCertTo)
         then
       and10:=' and ';

      if (isFindCountPriv and isFindOnlyPriv)or
         (isFindCountPriv and isFindFromNumber)or
         (isFindCountPriv and isFindToNumber)or
         (isFindCountPriv and isFindCertFrom)or
         (isFindCountPriv and isFindCertTo)
         then
       and11:=' and ';

      if (isFindOnlyPriv and isFindFromNumber)or
         (isFindOnlyPriv and isFindToNumber)or
         (isFindOnlyPriv and isFindCertFrom)or
         (isFindOnlyPriv and isFindCertTo)
         then
       and12:=' and ';

      if (isFindFromNumber and isFindToNumber)or
         (isFindFromNumber and isFindCertFrom)or
         (isFindFromNumber and isFindCertTo)
         then
       and13:=' and ';

      if (isFindToNumber and isFindCertFrom)or
         (isFindToNumber and isFindCertTo)
         then
       and14:=' and ';

      if (isFindCertFrom and isFindCertTo)
         then
       and15:=' and ';

                    s:=addstr1+and1+
                       addstr2+and2+
                       addstr3+and3+
                       addstr4+and4+
                       addstr5+and5+
                       addstr6+and6+
                       addstr7+and7+
                       addstr8+and8+
                       addstr9+and9+
                       addstr10+and10+
                       addstr11+and11+
                       addstr12+and12+
                       addstr13+and13+
                       addstr14+and14+
                       addstr15+and15+
                       addstr16;

      if Trim(s)='' then begin
        s:=' tb.numreestr is not null and isdel is null ';
      end else begin
        s:=s+' and tb.numreestr is not null and isdel is null ';
      end;
      Result:=wherestr+s

end;
{$WARNINGS ON}

procedure TfmStatisticReport.ReportView;
var
  W: Variant;

  procedure SetMaxAndMinDate(var MaxData,MinData: TDateTime);
  var
   qr: TIBQuery;
   sqls: string;
   tr: TIBTransaction;
  begin
   Screen.Cursor:=crHourGlass;
   tr:=TIBTransaction.Create(nil);
   qr:=TIBQuery.Create(nil);
   try
    tr.AddDatabase(dm.IBDbase);
    dm.IBDbase.AddTransaction(tr);
    tr.Params.Text:=DefaultTransactionParamsTwo;
    qr.Database:=dm.IBDbase;
    qr.Transaction:=tr;
    qr.Transaction.Active:=true;
    sqls:='Select Max(datein)as maxdatein, Min(datein) as mindatein from '+TableReestr+
          ' where isdel is null ';
    qr.sql.Add(sqls);
    qr.Active:=true;
    if not qr.IsEmpty then begin
      MaxData:=Qr.FieldByName('maxdatein').AsDateTime;
      MinData:=Qr.FieldByName('mindatein').AsDateTime;
    end;
   finally
    qr.Free;
    tr.Free;
    Screen.Cursor:=crDefault;
   end;
  end;

  function GetCountFromReestr(var Summa: Extended): Integer;
  var
   qr: TIBQuery;
   sqls: string;
   tr: TIBTransaction;
  begin
   Result:=0;
   Screen.Cursor:=crHourGlass;
   tr:=TIBTransaction.Create(nil);
   qr:=TIBQuery.Create(nil);
   try
    tr.AddDatabase(dm.IBDbase);
    dm.IBDbase.AddTransaction(tr);
    tr.Params.Text:=DefaultTransactionParamsTwo;
    qr.Database:=dm.IBDbase;
    qr.Transaction:=tr;
    qr.Transaction.Active:=true;
    sqls:='Select count(*) as ctn, sum(tb.summpriv) as summa from '+TableReestr+' tb '+
          ' join '+TableTypeReestr+' ttr on tb.typereestr_id=ttr.typereestr_id '+
          ' left join '+TableNotarialAction+' tna on tb.notarialaction_id=tna.notarialaction_id '+
          GetFilterString(false);
    qr.sql.Add(sqls);
    qr.Active:=true;
    if not qr.IsEmpty then begin
      Result:=qr.FieldByname('ctn').AsInteger;
      Summa:=qr.FieldByname('summa').AsCurrency;
    end;
   finally
    qr.Free;
    tr.Free;
    Screen.Cursor:=crDefault;
   end;
  end;

  procedure GetSumm(var Summ,SummPriv: Extended);
  var
   qr: TIBQuery;
   sqls: string;
   tr: TIBTransaction;
  begin
   Screen.Cursor:=crHourGlass;
   tr:=TIBTransaction.Create(nil);
   qr:=TIBQuery.Create(nil);
   try
    tr.AddDatabase(dm.IBDbase);
    dm.IBDbase.AddTransaction(tr);
    tr.Params.Text:=DefaultTransactionParamsTwo;
    qr.Database:=dm.IBDbase;
    qr.Transaction:=tr;
    qr.Transaction.Active:=true;
    sqls:='Select Sum(tb.summ) as tbsumm, Sum(tb.summpriv) as tbsummpriv from '+TableReestr+' tb '+
          ' join '+TableTypeReestr+' ttr on tb.typereestr_id=ttr.typereestr_id '+
          ' left join '+TableNotarialAction+' tna on tb.notarialaction_id=tna.notarialaction_id '+
          GetFilterString(true);
    qr.sql.Add(sqls);
    qr.Active:=true;
    if not qr.IsEmpty then begin
      Summ:=qr.FieldByname('tbsumm').AsFloat;
      SummPriv:=qr.FieldByname('tbsummpriv').AsFloat;
    end;
   finally
    qr.Free;
    tr.Free;
    Screen.Cursor:=crDefault;
   end;
  end;

  procedure SetParam(D: Variant; Min,Max: Integer);
  var
    tb: Variant;
    incr: Extended;
    last: Integer;
    sqls: String;
//    isCheckedData: Boolean;
//    periodStr: string;
    MaxData,MinData: TDateTime;
    i: Integer;
    RecCount: Integer;
    MainQr: TIBQuery;
    newValue: Extended;
//    SummAll: String;
    curCount: Integer;
    j: Integer;
    Summ,SummPriv: Extended;
    {ctnNoYear,ctnDefect,}ctnAll: Integer;
    fGroupNum,lGroupNum: Integer;
    tr: TIBTransaction;
    Summa: Extended;
    SummAll: Extended;
    isSummOk: Boolean;
 begin

  tr:=TIBTransaction.Create(nil);
  MainQr:=TIBQuery.Create(nil);
  try
    tr.AddDatabase(dm.IBDbase);
    dm.IBDbase.AddTransaction(tr);
    tr.Params.Text:=DefaultTransactionParamsTwo;
    MainQr.Database:=dm.IBDbase;
    MainQr.Transaction:=tr;
    MainQr.Transaction.Active:=true;

    MainQr.Active:=false;
    MainQr.SQL.Clear;
    sqls:='Select * from '+TableNotarialAction+' order by fieldsort';

    MainQr.SQL.Add(sqls);
    MainQr.Active:=true;
    RecCount:=GetRecordCount(MainQr);

    fmProgress.gag.Max:=Max;
    newValue:=Min;
    incr:=Max/(RecCount+15);

    SetMaxAndMinDate(MaxData,MinData);

    tb:=D.Paragraphs.Item(1).Range.Tables.Add(D.Paragraphs.Item(1).Range,1,1);
    tb.Rows.Borders.InsideLineStyle:= wdLineStyleNone;
    tb.Rows.Borders.OutsideLineStyle:= wdLineStyleNone;
    tb.Cell(1,1).Range.Font.Bold:=true;
    tb.Cell(1,1).Range.Font.Size:=16;
    tb.Cell(1,1).Range.Paragraphs.Alignment:=wdAlignParagraphCenter;
    tb.Cell(1,1).Range.InsertBefore('�������������� �����');
    tb.Cell(1,1).SetWidth(460,wdAdjustSameWidth);
    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','�������� ���������',nil,fmProgress.gag.Max);

//    isCheckedData:=dtpDateFrom.Checked or dtpDateTo.Checked;
{    if isCheckedData then begin
     if dtpDateFrom.Checked and (not dtpDateTo.Checked)then begin
      periodStr:='�: '+formatDateTime(fmtReportPlus,dtpDateFrom.Datetime)+
                 ' ��: '+formatDateTime(fmtReportPlus,MaxData);
     end;
     if (not dtpDateFrom.Checked) and (dtpDateTo.Checked)then begin
      periodStr:='�: '+formatDateTime(fmtReportPlus,MinData)+
                 ' ��: '+formatDateTime(fmtReportPlus,dtpDateTo.Datetime);
     end;
     if dtpDateFrom.Checked and dtpDateTo.Checked then begin
      periodStr:='�: '+formatDateTime(fmtReportPlus,dtpDateFrom.Datetime)+
                ' ��: '+formatDateTime(fmtReportPlus,dtpDateTo.Datetime);
     end;
    end else begin
      periodStr:='�: '+formatDateTime(fmtReportPlus,MinData)+
                 ' ��: '+formatDateTime(fmtReportPlus,MaxData);
    end;}

    tb.Rows.Add;
    tb.Cell(2,1).Range.Font.Bold:=false;
    tb.Cell(2,1).Range.Font.Size:=12;
//    tb.Cell(2,1).Range.InsertBefore('�� ������ '+periodStr);
    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','�������� ���������',nil,fmProgress.gag.Max);

    tb.Rows.Add;
    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','�������� ���������',nil,fmProgress.gag.Max);

    tb.Rows.Add;
    tb.Cell(4,1).Range.Font.Bold:=true;
    tb.Cell(4,1).Range.Font.Size:=14;
    tb.Cell(4,1).Range.InsertBefore('���������� ������������ ��������');
    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','�������� ���������',nil,fmProgress.gag.Max);

    tb.Rows.Add;
    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','�������� ���������',nil,fmProgress.gag.Max);

    Last:=5;
    Last:=Last+1;
    tb.Rows.Add;
    tb.Cell(last,1).Borders.OutsideLineStyle:= wdLineStyleSingle;
    tb.Cell(last,1).Borders.OutsideLineWidth:= wdLineWidth025pt;
    tb.Cell(last,1).Range.Font.Bold:=true;
    tb.Cell(last,1).Range.Font.Size:=12;

    tb.Cell(last,1).Split(1,3);
    tb.Cell(last,1).Range.Paragraphs.Alignment:=wdAlignParagraphCenter;
    tb.Cell(last,1).SetWidth(350,wdAdjustSameWidth);
    tb.Cell(last,1).Range.InsertBefore('������������');
    tb.Cell(last,2).Range.Paragraphs.Alignment:=wdAlignParagraphCenter;
    tb.Cell(last,2).Range.InsertBefore('���-��');
    tb.Cell(last,2).SetWidth(50,wdAdjustSameWidth);
    tb.Cell(last,3).Range.Paragraphs.Alignment:=wdAlignParagraphCenter;
    tb.Cell(last,3).Range.InsertBefore('�����');

    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','�������� ���������',nil,fmProgress.gag.Max);

    Last:=Last+1;
    tb.Rows.Add;
    tb.Cell(last,1).Range.Font.Bold:=false;
    tb.Cell(last,1).Range.Paragraphs.Alignment:=wdAlignParagraphLeft;
    tb.Cell(last,2).Range.Font.Bold:=false;
    tb.Cell(last,2).Range.Paragraphs.Alignment:=wdAlignParagraphRight;
    tb.Cell(last,3).Range.Font.Bold:=false;
    tb.Cell(last,3).Range.Paragraphs.Alignment:=wdAlignParagraphRight;

    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','�������� ���������',nil,fmProgress.gag.Max);

    Last:=Last+1;
    i:=0;
    ctnAll:=0;
//    ctnNoYear:=0;
//    ctnDefect:=0;
    fGroupNum:=0;
    lGroupNum:=0;
    MainQr.First;
    Summa:=0;
    SummAll:=0;
    for j:=0 to RecCount-1 do begin
      if i<>0 then begin
       tb.Rows.Add;
      end else begin
       fGroupNum:=Mainqr.FieldByName('fieldsort').AsInteger;
      end;
      isSummOk:=true;
//      curCount:=0;
      if MainQr.FieldByName('fieldsort').AsInteger=7 then begin // �/������
       CurNotActId:='';
       isFindCurNoYear:=true;
       isFindCurDefect:=false;
       isFindCountCopy:=false;
       isFindCountPriv:=false;
       curCount:=GetCountFromReestr(Summa);
       isSummOk:=false;
//       ctnNoYear:=ctnNoYear+curCount;
      end else if MainQr.FieldByName('fieldsort').AsInteger=8 then begin // ���.����������
       CurNotActId:='';
       isFindCurNoYear:=false;
       isFindCurDefect:=true;
       isFindCountCopy:=false;
       isFindCountPriv:=false;
       curCount:=GetCountFromReestr(Summa);
       isSummOk:=false;
//       ctnDefect:=ctnDefect+curCount;
      end else if MainQr.FieldByName('fieldsort').AsInteger=CopyID then begin // �����
       CurNotActId:='';
       isFindCurNoYear:=false;
       isFindCurDefect:=false;
       isFindCountCopy:=true;
       isFindCountPriv:=false;
       curCount:=GetCountFromReestr(Summa);
       ctnAll:=ctnAll+curCount;
      end else begin
       CurNotActId:=MainQr.FieldByName('notarialaction_id').AsString;
       isFindCurNoYear:=false;
       isFindCurDefect:=false;
       isFindCountCopy:=false;
       isFindCountPriv:=false;
       curCount:=GetCountFromReestr(Summa);
       ctnAll:=ctnAll+curCount;
      end;

      lGroupNum:=Mainqr.FieldByName('fieldsort').AsInteger;
      tb.Cell(Last+i,1).Range.InsertBefore(inttostr(lGroupNum)+'. '+
                                           Mainqr.FieldByName('hint').AsString);
      tb.Cell(Last+i,2).Range.InsertBefore(inttostr(curCount));
      Summa:=StrToFloat(Trim(Format('%15.2f',[Summa])));
      if isSummOk then
        SummAll:=Summa+SummAll;
      tb.Cell(Last+i,3).Range.InsertBefore(FloatToStr(Summa));
      Application.ProcessMessages;
      if BreakAnyProgress then exit;
      newValue:=newValue+incr;
      SetPositonAndText(Round(newValue),Mainqr.FieldByName('name').AsString,
                        '���-� ��������: ',nil,fmProgress.gag.Max);
      MainQr.Next;
      inc(i);
    end;
    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','������� ����������',nil,fmProgress.gag.Max);

    Last:=Last+i+1;
    tb.Rows.Add;
    tb.Cell(last,1).Range.Font.Bold:=true;
    tb.Cell(Last,1).Range.InsertBefore('����� (��.'+inttostr(fGroupNum)+'-'
                                       +inttostr(lGroupNum)+'), ����� 7,8');
    tb.Cell(last,2).Range.Font.Bold:=true;
    tb.Cell(Last,2).Range.InsertBefore(ctnAll);
    tb.Cell(last,3).Range.Font.Bold:=true;
    tb.Cell(Last,3).Range.InsertBefore(FloatToStr(SummAll));
    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','�������� ���������',nil,fmProgress.gag.Max);

    Last:=Last+1;
    tb.Rows.Add;
    tb.Cell(last,1).Merge(tb.Cell(last,3));
    tb.Rows.Add;
    tb.Rows.Item(last-1).Borders.InsideLineStyle:=wdLineStyleNone;
    tb.Rows.Item(last-1).Borders.OutsideLineStyle:=wdLineStyleNone;
    tb.Rows.Item(last-2).Borders.Item(wdBorderLeft).LineStyle:=wdLineStyleNone;
    tb.Rows.Item(last-2).Borders.Item(wdBorderRight).LineStyle:=wdLineStyleNone;
    tb.Cell(last,1).Range.Paragraphs.Alignment:=wdAlignParagraphCenter;
    tb.Cell(last,1).Range.Font.Bold:=true;
    tb.Cell(last,1).Range.Font.Size:=14;
    tb.Cell(last,1).Range.InsertBefore('���������� ������������');
    tb.Rows.Add;
    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','�������� ���������',nil,fmProgress.gag.Max);

    Last:=Last+1;
    tb.Rows.Add;
    tb.Cell(last,1).Borders.OutsideLineStyle:= wdLineStyleSingle;
    tb.Cell(last,1).Borders.OutsideLineWidth:= wdLineWidth025pt;
    tb.Cell(last,1).Range.Font.Bold:=true;
    tb.Cell(last,1).Range.Font.Size:=12;

   // tb.Cell(last,1).Merge(tb.Cell(last,2));
    tb.Cell(last,1).Split(1,2);
    tb.Cell(last,1).Range.Paragraphs.Alignment:=wdAlignParagraphCenter;
    tb.Cell(last,1).SetWidth(350,wdAdjustSameWidth);
    tb.Cell(last,1).Range.InsertBefore('������������');
    tb.Cell(last,2).Range.Paragraphs.Alignment:=wdAlignParagraphCenter;
    tb.Cell(last,2).Range.InsertBefore('��������');
    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','�������� ���������',nil,fmProgress.gag.Max);

    CurNotActId:='';
    isFindCurNoYear:=false;
    isFindCurDefect:=false;
    isFindCountCopy:=false;
    isFindCountPriv:=false;

    Summ:=0;
    SummPriv:=0;
    GetSumm(Summ,SummPriv);
    Summ:=StrToFloat(Trim(Format('%15.2f',[Summ])));
    SummPriv:=StrToFloat(Trim(Format('%15.2f',[SummPriv])));

    Last:=Last+1;
    tb.Rows.Add;
    tb.Cell(last,1).Range.Font.Bold:=false;
    tb.Cell(last,1).Range.Paragraphs.Alignment:=wdAlignParagraphLeft;
    tb.Cell(last,1).Range.InsertBefore('����� �������� ������');
    tb.Cell(last,2).Range.Font.Bold:=false;
    tb.Cell(last,2).Range.Paragraphs.Alignment:=wdAlignParagraphRight;
    tb.Cell(last,2).Range.InsertBefore(FloatToStr(SummPriv));
    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','�������� ���������',nil,fmProgress.gag.Max);

    Last:=Last+1;
    tb.Rows.Add;
    tb.Cell(last,1).Range.InsertBefore('��������� ��������� ���������� ���-�� �� ����� ������������');
    tb.Cell(last,2).Range.InsertBefore(FloatToStr(0));
    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','�������� ���������',nil,fmProgress.gag.Max);

    CurNotActId:='';
    isFindCurNoYear:=false;
    isFindCurDefect:=false;
    isFindCountCopy:=false;
    isFindCountPriv:=true;

    Last:=Last+1;
    tb.Rows.Add;
    tb.Cell(last,1).Range.InsertBefore('���-�� ���.�������� ����������� �� ��������� ������');
    tb.Cell(last,2).Range.InsertBefore(inttostr(GetCountFromReestr(Summa)));
    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','�������� ���������',nil,fmProgress.gag.Max);

    Last:=Last+1;
    tb.Rows.Add;
    tb.Cell(last,1).Range.InsertBefore('������ �������������� ������� � ��������� ���������� �����');
    tb.Cell(last,2).Range.InsertBefore(FloatToStr(Summ-SummPriv));
    Application.ProcessMessages;
    if BreakAnyProgress then exit;
    newValue:=newValue+incr;
    SetPositonAndText(Round(newValue),'','�������� ���������',nil,fmProgress.gag.Max);
    

  finally
    MainQr.Free;
    tr.Free;
  end;
 end;


  function ViewReport: Boolean;
  var
    D: Variant;
  begin
      BreakAnyProgress:=false;
      SetPositonAndText(2,'','����������',nil,fmProgress.gag.Max);
//      W.Visible:=false;
      D:=W.Documents.Add;
      SetPositonAndText(5,'','����������',nil,fmProgress.gag.Max);
//      D.ActiveWindow.View.Zoom.Percentage:=60;
      D.ActiveWindow.View.Zoom.PageFit:=wdPageFitBestFit;
      D.PageSetup.Orientation:=wdOrientPortrait;
      SetParam(D,10,100);
      W.Visible:=true;
      SetPositonAndText(100,'','��� ������',nil,fmProgress.gag.Max);
      W.Activate;
      W.WindowState:=wdWindowStateMaximize;
      Result:=true;
  end;

  function CreateAndPrepairReport: Boolean;
  begin
   result:=false;
   Screen.Cursor:=crHourGlass;
   try
    try
     VarClear(W);
     W:=CreateOleObject(WordOle);
     result:=ViewReport;
    except
     on E: Exception do begin
       Application.ShowException(E);
     end;
    end;
   finally
    Screen.Cursor:=crDefault;
   end;
  end;

  function PrepairReport: Boolean;
  begin
   fmProgress.Caption:=CaptionCreateReport;
   fmProgress.lbProgress.Caption:='����������';
   fmProgress.gag.Position:=0;
   fmProgress.Visible:=true;
   fmProgress.Update;
   Screen.Cursor:=crHourGlass;
   try
    try
     W:=GetActiveOleObject(WordOle);
     result:=ViewReport;
    except
     on E: Exception do begin
       if E.Message=MesOperationInaccessible then
        result:=CreateAndPrepairReport
       else if E.Message=MesCallingWasDeclined then
        result:=CreateAndPrepairReport
       else begin
         W.Quit;
         Result:=False;
         Application.ShowException(E);
       end;
     end;
    end;
   finally
    fmProgress.Visible:=false;
    Screen.Cursor:=crDefault;
   end;
  end;

begin
   if not Assigned(fmProgress) then exit;
   PrepairReport;
end;


procedure TfmStatisticReport.bibClearClick(Sender: TObject);
begin
  ClearFields(Self);
end;

procedure TfmStatisticReport.bibDateInClick(Sender: TObject);
var
  P: PInfoEnterPeriod;
begin
  GetMem(P,sizeof(TInfoEnterPeriod));
  try
   ZeroMemory(P,sizeof(TInfoEnterPeriod));
   P.TypePeriod:=tepInterval;
   P.LoadAndSave:=true;
   P.DateBegin:=dtpDateFrom.DateTime;
   P.DateEnd:=dtpDateTo.DateTime;
   if ViewEnterPeriod(P) then begin
     dtpDateFrom.DateTime:=P.DateBegin;
     dtpDateFrom.Checked:=true;
     dtpDateTo.DateTime:=P.DateEnd;
     dtpDateTo.Checked:=true;
   end;
  finally
    FreeMem(P,sizeof(TInfoEnterPeriod));
  end;
end;

procedure TfmStatisticReport.bibDateChangeClick(Sender: TObject);
var
  P: PInfoEnterPeriod;
begin
  GetMem(P,sizeof(TInfoEnterPeriod));
  try
   ZeroMemory(P,sizeof(TInfoEnterPeriod));
   P.TypePeriod:=tepYear;
   P.LoadAndSave:=false;
   P.DateBegin:=dtpDateChangeFrom.DateTime;
   P.DateEnd:=dtpDateChangeTo.DateTime;
   if ViewEnterPeriod(P) then begin
     dtpDateChangeFrom.DateTime:=P.DateBegin;
     dtpDateChangeFrom.Checked:=true;
     dtpDateChangeTo.DateTime:=P.DateEnd;
     dtpDateChangeTo.Checked:=true;
   end;
  finally
    FreeMem(P,sizeof(TInfoEnterPeriod));
  end;
end;

procedure TfmStatisticReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  SaveFilter;
end;

procedure TfmStatisticReport.bibCertClick(Sender: TObject);
var
  P: PInfoEnterPeriod;
begin
  GetMem(P,sizeof(TInfoEnterPeriod));
  try
   ZeroMemory(P,sizeof(TInfoEnterPeriod));
   P.TypePeriod:=tepYear;
   P.LoadAndSave:=false;
   P.DateBegin:=dtpCertFrom.DateTime;
   P.DateEnd:=dtpCertTo.DateTime;
   if ViewEnterPeriod(P) then begin
     dtpCertFrom.DateTime:=P.DateBegin;
     dtpCertFrom.Checked:=true;
     dtpCertTo.DateTime:=P.DateEnd;
     dtpCertTo.Checked:=true;
   end;
  finally
    FreeMem(P,sizeof(TInfoEnterPeriod));
  end;
end;

procedure TfmStatisticReport.FillTypeReestr;
var
  qr: TIBQuery;
  sqls: String;
  tr: TIBTransaction;
  OldCursor: TCursor;
begin
  OldCursor:=Screen.Cursor;
  Screen.Cursor:=crHourGlass;
  tr:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  CheckListBoxTypeReestr.Items.BeginUpdate;
  try
    tr.AddDatabase(dm.IBDbase);
    dm.IBDbase.AddTransaction(tr);
    tr.Params.Text:=DefaultTransactionParamsTwo;
    qr.Database:=dm.IBDbase;
    qr.Transaction:=tr;
    qr.Transaction.Active:=true;
    sqls:='Select * from '+TableTypeReestr+' order by sortnum ';
    qr.SQL.Add(sqls);
    qr.Open;
    if qr.Active and not qr.IsEmpty then begin
      CheckListBoxTypeReestr.Items.Clear;
      qr.First;
      while not qr.Eof do begin
        CheckListBoxTypeReestr.Items.AddObject(qr.FieldByName('name').AsString,TObject(qr.FieldByName('typereestr_id').AsInteger));
        qr.Next;
      end;
    end;
  finally
    CheckListBoxTypeReestr.Items.EndUpdate;
    qr.Free;
    tr.Free;
    Screen.Cursor:=OldCursor;
  end;
end;

end.