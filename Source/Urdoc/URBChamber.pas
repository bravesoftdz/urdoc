unit URBChamber;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, DBCtrls, Grids, DBGrids, Buttons,
  UEditChamber, UNewDbGrids, inifiles, IBCustomDataSet, IBQuery, IBTable,
  ImgList, Db,IBDatabase;

type
  TfmChamber = class(TForm)
    pnBut: TPanel;
    pnGrid: TPanel;
    ds: TDataSource;
    pnFind: TPanel;
    Label1: TLabel;
    edSearch: TEdit;
    pnBottom: TPanel;
    DBNav: TDBNavigator;
    lbCount: TLabel;
    Mainqr: TIBQuery;
    il: TImageList;
    pnModal: TPanel;
    bibOk: TBitBtn;
    bibClose: TBitBtn;
    bibFilter: TBitBtn;
    pnSQL: TPanel;
    bibAdd: TBitBtn;
    bibChange: TBitBtn;
    bibDel: TBitBtn;
    tran: TIBTransaction;
    bibPrint: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure bibAddClick(Sender: TObject);
    procedure bibChangeClick(Sender: TObject);
    procedure bibDelClick(Sender: TObject);
    procedure bibFilterClick(Sender: TObject);
    procedure edSearchKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bibCloseClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure MainqrAfterOpen(DataSet: TDataSet);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure bibPrintClick(Sender: TObject);
  private
    FindName,FindAddress,FindPresident,FindPhone,FindEmail: string;
    isFindName,isFindAddress,isFindPresident,isFindPhone,isFindEmail: Boolean;
    FilterInSide: Boolean;
    procedure GridTitleClick(Column: TColumn);
    procedure GridDblClick(Sender: TObject);
    procedure SetImageFilter;
    procedure SaveFilter;
    procedure ViewCount;
    function GetFilterString: string;
    function ChamberNameExists(strName: String; var ID: Integer): Boolean;
  public
    Grid: TNewdbGrid;
    procedure MR(Sender: TObject);
    procedure ActiveQuery;
    procedure LoadFilter;
  end;

var
  fmChamber: TfmChamber;
   
implementation

uses Udm, UMain;

{$R *.DFM}

procedure TfmChamber.FormCreate(Sender: TObject);
begin
  tran.AddDatabase(dm.IBDbase);
  dm.IBDbase.AddTransaction(tran);
  tran.Params.Text:=DefaultTransactionParamsTwo;
  Mainqr.Transaction:=tran;

  Grid:=TNewdbGrid.Create(self);
  Grid.Parent:=pnGrid;
  Grid.Align:=alClient;
  Grid.DataSource:=ds;
   Grid.RowSelected.Visible:=true;
   Grid.RowSelected.Brush.Style:=bsSolid;
   Grid.RowSelected.Brush.Color:=GridRowColor;
   Grid.RowSelected.Font.Color:=clWhite;
   Grid.RowSelected.Pen.Style:=psClear;
   Grid.CellSelected.Visible:=true;
   Grid.CellSelected.Brush.Color:=clHighlight;
   Grid.CellSelected.Font.Color:=clHighlightText;
  Grid.Options:=Grid.Options-[dgEditing]-[dgTabs];
  Grid.ReadOnly:=true;
  Grid.OnTitleClick:=GridTitleClick;
  Grid.OnDblClick:=GridDblClick;
  Grid.OnKeyDown:=FormKeyDown;

  OnKeyDown:=fmMain.OnKeyDown;
  OnKeyPress:=fmMain.OnKeyPress;
  OnKeyUp:=fmMain.OnKeyUp;
  Mainqr.Database:=dm.IBDbase;
end;

procedure TfmChamber.ActiveQuery;
var
 sqls: String;
 cl: TColumn;
begin
  ds.DataSet:=nil;
  Mainqr.Active:=false;
  Mainqr.sql.Clear;
  sqls:='Select * from '+TableChamber+GetFilterString+' order by name';
  Mainqr.sql.Add(sqls);
  Mainqr.Active:=true;
  ds.DataSet:=Mainqr;
  SetImageFilter;
  ViewCount;
  if Grid.Columns.Count<>4 then begin

   cl:=Grid.Columns.Add;
   cl.FieldName:='name';
   cl.Title.Caption:='������������';
   cl.Width:=200;

   cl:=Grid.Columns.Add;
   cl.FieldName:='address';
   cl.Title.Caption:='�����';
   cl.Width:=200;

   cl:=Grid.Columns.Add;
   cl.FieldName:='president';
   cl.Title.Caption:='���������';
   cl.Width:=200;

   cl:=Grid.Columns.Add;
   cl.FieldName:='phone';
   cl.Title.Caption:='�������';
   cl.Width:=100;

  end;
end;

procedure TfmChamber.bibAddClick(Sender: TObject);
var
  fm: TfmEditChamber;
  qr: TIBQuery;
  RetVal: Boolean;
  valname: string;
  ID: Integer;
  sqls: string;
  tr: TIBTransaction;
begin
 fm:=TfmEditChamber.Create(nil);
 try
  fm.Caption:=captionAdd;
  fm.bibOk.OnClick:=fm.OkClick;
  if fm.ShowModal=mrOk then begin

    valname:=Trim(fm.edName.Text);
    retval:=ChamberNameExists(valname,ID);
    if retVal then begin
      ShowError(Application.handle,'�������� <'+valname+'> '+#13+
               '� ���� <'+fm.lbName.Caption+'>'+#13+
               valuePresent);
      MainQr.Locate('chamber_id',id,[loCaseInsensitive]);
      exit;
    end;
    ID:=GetGenId(TableChamber,1);
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
     sqls:='Insert into '+TableChamber+' (chamber_id,name,address,president,phone,email)'+
           ' values ('+IntToStr(ID)+
           ','+QuotedStr(valname)+
           ','+QuotedStr(Trim(fm.edAddress.Text))+
           ','+QuotedStr(Trim(fm.edPresident.Text))+
           ','+iff(Trim(fm.edPhone.Text)<>'',QuotedStr(Trim(fm.edPhone.Text)),'null')+
           ','+iff(Trim(fm.edEmail.Text)<>'',QuotedStr(Trim(fm.edEmail.Text)),'null')+
           ')';
     qr.SQL.Add(sqls);
     qr.ExecSQL;
     qr.Transaction.CommitRetaining;
    finally
     qr.Free;
     tr.Free;
     Mainqr.Active:=false;
     Mainqr.Active:=true;
     Mainqr.Locate('name',valname,[loCaseInsensitive]);
     ViewCount;
     Screen.Cursor:=crDefault;
    end;
  end;
 finally
  fm.Free;
 end;
end;

procedure TfmChamber.bibChangeClick(Sender: TObject);
var
  fm: TfmEditChamber;
  RetVal: Boolean;
  valname: string;
  Id: Integer;
  qr: TIBQuery;
  sqls: string;
  tr: TIBTransaction;
begin
 if MainQr.RecordCount=0 then exit;
 fm:=TfmEditChamber.Create(nil);
 try
  fm.Caption:=captionChange;
  fm.edName.text:=Trim(MainQr.FieldByName('name').AsString);
  fm.edAddress.text:=Trim(MainQr.FieldByName('address').AsString);
  fm.edPresident.text:=Trim(MainQr.FieldByName('president').AsString);
  fm.edPhone.text:=Trim(MainQr.FieldByName('phone').AsString);
  fm.edEmail.text:=Trim(MainQr.FieldByName('email').AsString);

  fm.bibOk.OnClick:=fm.OkClick;
  fm.ChangeFlag:=false;

  if fm.ShowModal=mrOk then begin

    if not fm.ChangeFlag then exit;
    valname:=Trim(fm.edName.Text);
    retval:=ChamberNameExists(valname,Id);
    if (retVal)and(MainQr.FieldByName('chamber_id').AsInteger<>id) then begin
      ShowError(Application.handle,'�������� <'+valname+'> '+#13+
               '� ���� <'+fm.lbName.Caption+'>'+#13+
               valuePresent);
      MainQr.Locate('chamber_id',id,[loCaseInsensitive]);
      exit;
    end;
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
     sqls:='Update '+TableChamber+
           ' set name='+QuotedStr(valname)+
           ', address='+QuotedStr(Trim(fm.edAddress.text))+
           ', president='+QuotedStr(Trim(fm.edPresident.text))+
           ', phone='+iff(Trim(fm.edPhone.text)<>'',QuotedStr(Trim(fm.edPhone.text)),'null')+
           ', email='+iff(Trim(fm.edEmail.text)<>'',QuotedStr(Trim(fm.edEmail.text)),'null')+
           ' where chamber_id='+MainQr.FieldByName('chamber_id').AsString;

     qr.SQL.Add(sqls);
     qr.ExecSQL;
     qr.Transaction.CommitRetaining;
    finally
     qr.Free;
     tr.Free;
     Mainqr.Active:=false;
     Mainqr.Active:=true;
     Mainqr.Locate('name',valname,[loCaseInsensitive]);
     ViewCount;
     Screen.Cursor:=crDefault;
    end;
  end;
 finally
  fm.Free;
 end;
end;

procedure TfmChamber.bibDelClick(Sender: TObject);

  function DeleteRecord: Boolean;
  var
    qr: TIBQuery;
    sqls: string;
    tr: TIBTransaction;
  begin
   Screen.Cursor:=crHourGlass;
   tr:=TIBTransaction.Create(nil);
   qr:=TIBQuery.Create(nil);
   try
    result:=false;
    try

     tr.AddDatabase(dm.IBDbase);
     dm.IBDbase.AddTransaction(tr);
     tr.Params.Text:=DefaultTransactionParamsTwo;
     qr.Database:=dm.IBDbase;
     qr.Transaction:=tr;
     qr.Transaction.Active:=true;
     sqls:='Delete from '+TableChamber+' where chamber_id='+
            Mainqr.FieldByName('chamber_id').asString;
     qr.sql.Add(sqls);
     qr.ExecSQL;
     qr.Transaction.CommitRetaining;
     Mainqr.Active:=false;
     Mainqr.Active:=true;
     Mainqr.Last;
     ViewCount;
     Result:=true;
    except
    end;
   finally
    qr.Free;
    tr.Free;
    Screen.Cursor:=crDefault;
   end;

  end;

var
  mr: TModalResult;  
begin
  if Mainqr.RecordCount=0 then exit;
  mr:=MessageDlg('������� ?',mtConfirmation,[mbYes,mbNo],-1);
  if mr=mrYes then begin
    if not deleteRecord then begin
      ShowError(Application.Handle,'������ <'+Mainqr.FieldByName('name').AsString+'> ������������.');
    end;
  end;
end;

procedure TfmChamber.bibFilterClick(Sender: TObject);
var
  fm: TfmEditChamber;
  filstr: string;
begin
 fm:=TfmEditChamber.Create(nil);
 try
  fm.Caption:=CaptionFilter;

  fm.bibOk.OnClick:=fm.filterClick;

  if Trim(FindName)<>'' then fm.edName.Text:=FindName;
  if Trim(FindAddress)<>'' then fm.edAddress.Text:=FindAddress;
  if Trim(FindPresident)<>'' then fm.edPresident.Text:=FindPresident;
  if Trim(FindPhone)<>'' then fm.edPhone.Text:=FindPhone;
  if Trim(FindEmail)<>'' then fm.edEmail.Text:=FindEmail;

  fm.cbInString.Visible:=true;
  fm.cbInString.Checked:=FilterInSide;
  fm.ChangeFlag:=false;

  if fm.ShowModal=mrOk then begin

    FindName:=Trim(fm.edName.Text);
    isFindName:=Trim(FindName)<>'';

    FindAddress:=Trim(fm.edAddress.Text);
    isFindAddress:=Trim(FindAddress)<>'';

    FindPresident:=Trim(fm.edPresident.Text);
    isFindPresident:=Trim(FindPresident)<>'';

    FindPhone:=Trim(fm.edPhone.Text);
    isFindPhone:=Trim(FindPhone)<>'';

    FindEmail:=Trim(fm.edEmail.Text);
    isFindEmail:=Trim(FindEmail)<>'';

    FilterInSide:=fm.cbInString.Checked;
    if FilterInSide then filstr:='%';

    SaveFilter;
    ActiveQuery;
    ViewCount;
  end;
 finally
  fm.Free;
 end;
end;

procedure TfmChamber.MR(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TfmChamber.edSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 tmps: string;
begin
  if not isValidKey(Char(Key)) then exit;
  if MainQr.IsEmpty then exit;
  if grid.SelectedField=nil then exit;
  tmps:=grid.SelectedField.FullName;
  MainQr.Locate(tmps,Trim(edSearch.Text),
                [loPartialKey,loCaseInsensitive]);
end;

procedure TfmChamber.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:=caFree;
end;

procedure TfmChamber.bibCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmChamber.GridTitleClick(Column: TColumn);
var
  fn: string;
  id: integer;
begin
  if not MainQr.Active then exit;
  if MainQr.RecordCount=0 then exit;
  Screen.Cursor:=crHourGlass;
  try
   fn:=Column.FieldName;
   id:=MainQr.fieldByName('chamber_id').asInteger;
   MainQr.Active:=false;
   MainQr.SQL.Clear;
   MainQr.SQL.Add('Select * from '+TableChamber+GetFilterString+' Order by '+fn);
   MainQr.Active:=true;
   MainQr.First;
   MainQr.Locate('chamber_id',id,[loCaseInsensitive]);
  finally
    Screen.Cursor:=crDefault;
  end;
end;

procedure TfmChamber.FormDestroy(Sender: TObject);
begin
  Grid.Free;
  if fsCreatedMDIChild in FormState then
   fmChamber:=nil;
end;

procedure TfmChamber.SetImageFilter;
begin
  bibFilter.Glyph.Assign(nil);
  bibFilter.Glyph.Width:=dm.IlMain.Width;
  bibFilter.Glyph.Height:=dm.IlMain.Height;
  if isFindName or isFindAddress or isFindPresident or isFindPhone or isFindEmail then begin
    dm.IlMain.draw(bibFilter.Glyph.Canvas,0,0,0,true);
  end else begin
    dm.IlMain.draw(bibFilter.Glyph.Canvas,0,0,1,true);
  end;
end;

procedure TfmChamber.LoadFilter;
var
  fi: TIniFile;
begin
  fi:=TIniFile.Create(GetIniFileName);
  try
    FindName:=fi.ReadString('RBChamber','Name',FindName);
    FindAddress:=fi.ReadString('RBChamber','Address',FindAddress);
    FindPresident:=fi.ReadString('RBChamber','President',FindPresident);
    FindPhone:=fi.ReadString('RBChamber','Phone',FindPhone);
    FindEmail:=fi.ReadString('RBChamber','Email',FindEmail);

    FilterInside:=fi.ReadBool('RBChamber','Inside',FilterInside);
  finally
   fi.Free;
  end;
end;

procedure TfmChamber.SaveFilter;
var
  fi: TIniFile;
begin
  fi:=TIniFile.Create(GetIniFileName);
  try
    fi.WriteString('RBChamber','Name',FindName);
    fi.WriteString('RBChamber','Address',FindAddress);
    fi.WriteString('RBChamber','President',FindPresident);
    fi.WriteString('RBChamber','Phone',FindPhone);
    fi.WriteString('RBChamber','Email',FindEmail);

    fi.WriteBool('RBChamber','Inside',FilterInside);
  finally
   fi.Free;
  end;
end;

function TfmChamber.GetFilterString: string;
var
  FilInSide: string;
  wherestr: string;
  addstr1,addstr2,addstr3,addstr4,addstr5: string;
  and1,and2,and3,and4: string;
begin
    Result:='';

    isFindName:=Trim(FindName)<>'';
    isFindAddress:=Trim(FindAddress)<>'';
    isFindPresident:=Trim(FindPresident)<>'';
    isFindPhone:=Trim(FindPhone)<>'';
    isFindEmail:=Trim(FindEmail)<>'';

    if isFindName or isFindAddress or isFindPresident or isFindPhone or isFindEmail then begin
     wherestr:=' where ';
    end else begin
    end;

    if FilterInside then FilInSide:='%';

     if (isFindName)then begin
        addstr1:=' Upper(name) like '+AnsiUpperCase(QuotedStr(FilInSide+FindName+'%'))+' ';
     end;

     if (isFindAddress)then begin
        addstr2:=' Upper(address) like '+AnsiUpperCase(QuotedStr(FilInSide+FindAddress+'%'))+' ';
     end;

     if (isFindPresident)then begin
        addstr3:=' Upper(president) like '+AnsiUpperCase(QuotedStr(FilInSide+FindPresident+'%'))+' ';
     end;

     if (isFindPhone)then begin
        addstr4:=' Upper(phone) like '+AnsiUpperCase(QuotedStr(FilInSide+FindPhone+'%'))+' ';
     end;

     if (isFindEmail)then begin
        addstr5:=' Upper(email) like '+AnsiUpperCase(QuotedStr(FilInSide+FindEmail+'%'))+' ';
     end;

     if (isFindName and isFindAddress)or
        (isFindName and isFindPresident) or
        (isFindName and isFindPhone) or
        (isFindName and isFindEmail)
        then begin
        and1:=' and ';
     end;

     if (isFindAddress and isFindPresident) or
        (isFindAddress and isFindPhone) or
        (isFindAddress and isFindEmail)
        then begin
        and2:=' and ';
     end;

     if (isFindPresident and isFindPhone) or
        (isFindPresident and isFindEmail)
        then begin
        and3:=' and ';
     end;

     if (isFindPhone and isFindEmail) 
        then begin
        and4:=' and ';
     end;

     Result:=wherestr+addstr1+and1+
                      addstr2+and2+
                      addstr3+and3+
                      addstr4+and4+
                      addstr5;

end;

procedure TfmChamber.ViewCount;
begin
 if MainQr.Active then
  lbCount.Caption:=ViewCountText+inttostr(GetRecordCount(Mainqr));
end;

procedure TfmChamber.MainqrAfterOpen(DataSet: TDataSet);
begin
  ViewCount;
end;

procedure TfmChamber.GridDblClick(Sender: TObject);
begin
  if not Mainqr.Active then exit;
  if Mainqr.RecordCount=0 then exit;
  bibChangeClick(nil);
end;

function TfmChamber.ChamberNameExists(strName: String; var ID: Integer): Boolean;
var
  qr: TIBQuery;
  sqls: string;
  tr: TIBTransaction;
begin
  Result:=false;
  Screen.Cursor:=CrHourGlass;
  tr:=TIBTransaction.Create(nil);
  qr:=TIBQuery.Create(nil);
  try
   tr.AddDatabase(dm.IBDbase);
   dm.IBDbase.AddTransaction(tr);
   tr.Params.Text:=DefaultTransactionParamsTwo;
   qr.Database:=dm.IBDbase;
   qr.Transaction:=tr;
   qr.Transaction.Active:=true;
   sqls:='Select * from '+TableChamber+' where name='+QuotedStr(Trim(strName));
   qr.SQL.Add(sqls);
   qr.Active:=true;
   if qr.recordCount=1 then begin
     ID:=qr.FieldByName('chamber_id').ASInteger;
     Result:=true;
   end;
  finally
   qr.Free;
   tr.Free;
   Screen.Cursor:=CrDefault;
  end;
end;

procedure TfmChamber.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_F2: if pnSQL.Visible then bibAdd.Click;
    VK_F3: if pnSQL.Visible then bibChange.Click;
    VK_F4: if pnSQL.Visible then bibDel.Click;
//    VK_F5: bibRefresh.Click;
    VK_F6: bibFilter.Click;
  end;
  fmMain.FormKeyDown(Sender,Key,Shift);
end;

procedure TfmChamber.FormResize(Sender: TObject);
begin
  edSearch.Width:=Self.Width-edSearch.Left-pnBut.Width-8;
end;

procedure TfmChamber.bibPrintClick(Sender: TObject);
begin
  CreateWordTableByGrid(Grid,Caption);
end;

end.
